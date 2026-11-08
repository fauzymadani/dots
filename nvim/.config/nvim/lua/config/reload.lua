-- Push config changes into the *running* Nvim, without quitting it.
--
-- From inside a session (any session, even one started with an older config):
--   :ConfigReload           " options, keymaps, plugin specs, LSP servers
--   :ConfigReload style     " config/options.lua + config/keymaps.lua only
--   :ConfigReload lsp       " lua/plugins/lsp.lua + restart LSP servers
--   <leader>ra / <leader>rl / <leader>rs   " the same three
--
-- From another terminal, against an already-running session:
--   :echo v:servername                      " inside that session
--   nvim --server <address> --remote-expr \
--     'luaeval("require(\"config.reload\").apply(\"all\")")'
--
-- Everything below reads the files from disk on demand (`require` searches the
-- runtimepath, not a saved snapshot), so no restart is needed for any of it.
--
-- What still needs a restart (`<leader>rr` / `:restart`):
--   * `vim.g.mapleader` / `vim.g.maplocalleader`
--   * edits to init.lua itself (top-level code and autocmds)
--   * `config`/`opts` of plugins that are not listed in `M.plugins`
--     (reload those with `require('config.reload').reload_plugins({ 'x.nvim' })`
--      or `:Lazy reload x.nvim`)
local M = {}

-- Modules that only call vim.opt / vim.keymap.set, so re-running is idempotent.
M.modules = { 'config.options', 'config.keymaps' }

-- Plugins whose `config` is re-run by `apply()`. Every server definition for
-- this config lives in mason-lspconfig.nvim's `config` (see lua/plugins/lsp.lua),
-- so that is the only one needed. Extend it if you edit other plugin specs.
M.plugins = { 'mason-lspconfig.nvim' }

-- Plugins that must never be hot-reloaded.
-- * nvim-lspconfig: reloading it clears `package.loaded` and its deprecated
--   `require('lspconfig')` proxy breaks. Nvim re-reads its `lsp/*.lua` files
--   whenever a config is resolved, so nothing is lost by skipping it.
-- * nui.nvim / plenary.nvim: lazy's `deactivate` cannot clean them up
--   ("module 'nui' not found", "attempt to call field 'deactivate'").
M.skip = {
	['nvim-lspconfig'] = true,
	['lazy.nvim'] = true,
	['nui.nvim'] = true,
	['plenary.nvim'] = true,
}

--- Re-run the plain-Lua config modules (options + keymaps).
function M.reload_style()
	for _, mod in ipairs(M.modules) do
		package.loaded[mod] = nil
		require(mod)
	end
end

--- Re-read lua/plugins/*.lua from disk into lazy's spec table.
--- Plugin state (what is loaded, dirs, deps) is preserved by lazy.
---@return boolean ok
function M.respec()
	local ok, plugin = pcall(require, 'lazy.core.plugin')
	if not ok then
		return false
	end
	plugin.load()
	return true
end

--- Reload plugins, re-running `init`/`config` with the freshly read spec.
---@param names? string[] limit to these plugin names (default: every loaded plugin)
---@return string[] errors
function M.reload_plugins(names)
	local ok, Config = pcall(require, 'lazy.core.config')
	if not ok then
		return {}
	end

	local loader = require('lazy.core.loader')
	local targets = {}

	if names then
		targets = names
	else
		for name, plugin in pairs(Config.plugins) do
			if plugin._.loaded and not M.skip[name] then
				targets[#targets + 1] = name
			end
		end
		table.sort(targets)
	end

	local errors = {}
	for _, name in ipairs(targets) do
		local plugin = Config.plugins[name]
		if plugin and plugin._.loaded then
			-- a broken spec must not abort the whole reload
			local reloaded, err = pcall(loader.reload, plugin)
			if not reloaded then
				errors[#errors + 1] = name .. ': ' .. tostring(err)
			end
		end
	end
	return errors
end

--- Start the client for `name` on `bufnr` using the *currently resolved* config.
--- Mirrors what Nvim's own `vim.lsp.enable` FileType callback does.
---@param name string
---@param bufnr integer
local function start_client(name, bufnr)
	local config = vim.lsp.config[name]
	if type(config) ~= 'table' then
		return
	end

	local function start(cfg)
		vim.lsp.start(cfg, {
			bufnr = bufnr,
			reuse_client = cfg.reuse_client,
			_root_markers = cfg.root_markers,
		})
	end

	if type(config.root_dir) == 'function' then
		local resolve = config.root_dir
		resolve(bufnr, function(root_dir)
			config.root_dir = root_dir
			vim.schedule(function()
				start(config)
			end)
		end)
	else
		start(config)
	end
end

--- Restart the LSP servers attached to a buffer, re-reading `vim.lsp.config`.
--- `:lsp restart` on its own is not enough: it reuses the client's *already
--- resolved* config, so a new `cmd`/`init_options`/`settings` would be ignored.
--- Disabling + re-enabling the config makes Nvim resolve it from the table again.
---@param bufnr? integer (default: current buffer; 0 also means current buffer)
function M.restart_lsp(bufnr)
	if bufnr == nil or bufnr == 0 then
		bufnr = vim.api.nvim_get_current_buf()
	end

	-- Names attached here, plus every buffer those clients were serving, so a
	-- restart does not silently drop LSP from your other open files.
	local names, buffers = {}, { [bufnr] = true }
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
		if type(vim.lsp.is_enabled) ~= 'function' or vim.lsp.is_enabled(client.name) then
			names[client.name] = true
			for attached in pairs(client.attached_buffers or {}) do
				buffers[attached] = true
			end
		end
	end

	if vim.tbl_isempty(names) then
		-- No managed client here: fall back to the builtin command.
		if vim.fn.exists(':lsp') == 2 then
			vim.cmd('lsp restart')
		elseif vim.fn.exists(':LspRestart') == 2 then
			vim.cmd('LspRestart')
		else
			vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = bufnr }))
			vim.cmd.edit()
		end
		return
	end

	for name in pairs(names) do
		vim.lsp.enable(name, false) -- stop the client(s), drop the cached config
	end

	-- Wait for the processes to be gone: while an old client is still in
	-- `vim.lsp.get_clients()`, `vim.lsp.start()` would simply reuse it.
	local function alive()
		for name in pairs(names) do
			if #vim.lsp.get_clients({ name = name, _uninitialized = true }) > 0 then
				return true
			end
		end
		return false
	end
	vim.wait(3000, function()
		return not alive()
	end, 20)

	for name in pairs(names) do
		vim.lsp.enable(name) -- keep the config enabled for files opened later
		for buffer in pairs(buffers) do
			if vim.api.nvim_buf_is_loaded(buffer) then
				start_client(name, buffer)
			end
		end
	end
end

--- Apply config changes to this session.
---@param what? 'all'|'style'|'lsp'
function M.apply(what)
	what = what or 'all'
	local errors = {}

	if what == 'style' then
		M.reload_style()
	elseif what == 'lsp' then
		M.respec()
		vim.list_extend(errors, M.reload_plugins(M.plugins))
		M.restart_lsp()
	elseif what == 'all' then
		M.reload_style()
		M.respec()
		vim.list_extend(errors, M.reload_plugins(M.plugins))
		M.restart_lsp()
	else
		vim.notify('ConfigReload: unknown target ' .. what, vim.log.levels.ERROR)
		return
	end

	if #errors > 0 then
		vim.notify('Config reloaded with errors:\n' .. table.concat(errors, '\n'), vim.log.levels.WARN)
	else
		vim.notify('Config reloaded (' .. what .. ')', vim.log.levels.INFO)
	end
end

return M
