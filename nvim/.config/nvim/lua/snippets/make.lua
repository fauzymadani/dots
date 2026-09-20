return {
	s('mk', {
		t({
			'.PHONY: all build test run clean',
			'',
			'TARGET := ',
		}),
		i(1, 'app'),
		t({
			'',
			'BUILD_COMMAND := ',
		}),
		i(2),
		t({
			'',
			'TEST_COMMAND := ',
		}),
		i(3),
		t({
			'',
			'RUN_COMMAND := ',
		}),
		i(4),
		t({
			'',
			'',
			'all: build',
			'',
			'build:',
			'	$(BUILD_COMMAND)',
			'',
			'test:',
			'	$(TEST_COMMAND)',
			'',
			'run:',
			'	$(RUN_COMMAND)',
			'',
			'clean:',
			'	$(RM) $(TARGET)',
			'',
		}),
		i(0),
	}),
}
