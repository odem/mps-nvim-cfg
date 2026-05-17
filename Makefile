.PHONY: lint check health validate

lint:       ## Run luacheck on all Lua files
	luacheck lua/

check:      ## Check Neovim config loads without errors
	XDG_CONFIG_HOME=$(HOME)/.config/nvim-dev nvim --headless -c "q"

health:    ## Run :checkhealth internally
	XDG_CONFIG_HOME=$(HOME)/.config/nvim-dev nvim --headless -c "checkhealth" -c "q"

validate:   ## Full validation suite
	$(MAKE) lint
	$(MAKE) check