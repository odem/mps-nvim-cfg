local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		require("core.mason"),
		require("core.autopairs"),
		require("core.fidget"),
		require("core.completion"),
		require("core.luasnip"),
		{ "rafamadriz/friendly-snippets" },
		require("core.treesitter"),
		require("core.lazydev"),
		require("core.neoconf"),
		require("core.undotree"),
		require("core.telescope"),
		require("core.which-key"),
		require("appearance"),
		require("navigation"),
		require("tools"),
		require("debugging"),
	},
	change_detection = { notify = false },
})
