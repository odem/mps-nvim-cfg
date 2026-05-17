vim.lsp.config["*"] = {
	capabilities = {
		textDocument = {
			completion = {
				completionItem = { snippetSupport = true },
			},
		},
	},
}

-- Auto-install missing servers via Mason (deferred, non-blocking)
vim.schedule(function()
	local servers = {
		{ bin = "ruff", mason = "ruff" },
		{ bin = "pyright-langserver", mason = "pyright" },
		{ bin = "lua-language-server", mason = "lua-language-server" },
	}
	for _, s in ipairs(servers) do
		if vim.fn.executable(s.bin) ~= 1 then
			vim.cmd("MasonInstall " .. s.mason)
		end
	end
end)

vim.lsp.config.ruff = {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	settings = {
		ruff = {
			lineLength = 88,
			lint = { extendSelect = { "I" } },
			format = { preview = true },
		},
	},
}

vim.lsp.enable("ruff")

vim.lsp.config.pyright = {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
}

vim.lsp.enable("pyright")

vim.lsp.config.lua_ls = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.enable("lua_ls")

-- Inlay hints
vim.lsp.inlay_hint.enable(true)

-- Diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "✘", numhl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "▲", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ", numhl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "⚑", numhl = "DiagnosticSignHint" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("core-lsp", { clear = true }),
	callback = function(ev)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
		end

		-- Navigation / info
		map("n", "gD", vim.lsp.buf.declaration, "[LSP] Declaration")
		map("n", "gh", vim.lsp.buf.hover, "[LSP] Hover")
		map("n", "gk", vim.lsp.buf.hover, "[LSP] Hover (alt)")
		map("n", "gsh", vim.lsp.buf.signature_help, "[LSP] Signature help")
		map("n", "gK", vim.lsp.buf.signature_help, "[LSP] Signature help (alt)")

		-- Code actions
		map("n", "gca", vim.lsp.buf.code_action, "[LSP] Code action")
		map("n", "gn", vim.lsp.buf.rename, "[LSP] Rename")
		map("n", "gtf", vim.lsp.buf.format, "[LSP] Format")

		-- Diagnostics
		map("n", "[d", vim.diagnostic.goto_prev, "[LSP] Prev diagnostic")
		map("n", "]d", vim.diagnostic.goto_next, "[LSP] Next diagnostic")
	end,
})
