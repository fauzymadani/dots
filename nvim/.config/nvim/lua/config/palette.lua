-- Semantic palette for the ACTIVE colorscheme.
-- Known themes (rose-pine) map from their own named palette for a curated look;
-- any other theme falls back to reading standard highlight groups. Call .get()
-- again (e.g. on ColorScheme) to re-read after a theme switch.
local M = {}

-- rose-pine (+ moon/dawn) expose require('rose-pine.palette') with named colors.
local function from_rose_pine()
	local name = vim.g.colors_name or ''
	if not name:match('^rose%-pine') then
		return nil
	end
	local ok, p = pcall(require, 'rose-pine.palette')
	if not ok or not p or not p.iris then
		return nil
	end
	return {
		bg = p.base,
		fg = p.text,
		bg_raised = p.surface,
		subtle = p.subtle,
		muted = p.muted,
		red = p.love,
		green = p.pine,
		yellow = p.gold,
		blue = p.foam,
		cyan = p.foam,
		violet = p.iris,
		magenta = p.love,
		orange = p.rose,
	}
end

-- Generic: read whatever the theme assigns to standard groups (rose-pine hex fallbacks).
local function pick(attr, ...)
	for _, name in ipairs({ ... }) do
		local ok, h = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
		if ok and h and h[attr] then
			return string.format('#%06x', h[attr])
		end
	end
	return nil
end

local function from_highlights()
	return {
		bg = pick('bg', 'Normal') or '#191724',
		fg = pick('fg', 'Normal') or '#e0def4',
		bg_raised = pick('bg', 'Pmenu', 'CursorLine') or '#26233a',
		subtle = pick('fg', 'Comment') or '#908caa',
		muted = pick('fg', 'LineNr', 'Comment') or '#6e6a86',
		red = pick('fg', 'DiagnosticError', 'Error') or '#eb6f92',
		green = pick('fg', 'DiagnosticOk', 'String') or '#31748f',
		yellow = pick('fg', 'DiagnosticWarn', 'WarningMsg') or '#f6c177',
		blue = pick('fg', 'Function') or '#9ccfd8',
		cyan = pick('fg', 'Special', 'Function') or '#9ccfd8',
		violet = pick('fg', 'Keyword', 'Statement', 'Function') or '#c4a7e7',
		magenta = pick('fg', 'Identifier', 'Constant') or '#eb6f92',
		orange = pick('fg', 'Constant', 'Number') or '#ebbcba',
	}
end

function M.get()
	return from_rose_pine() or from_highlights()
end

return M
