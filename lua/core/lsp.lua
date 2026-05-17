vim.lsp.config["*"] = {
	capabilities = {
		textDocument = {
			completion = {
				completionItem = { snippetSupport = true },
			},
		},
	},
}

-- Auto-install LSP servers via Mason (deferred, non-blocking)
vim.schedule(function()
	local data_dir = vim.fn.stdpath("data")
	local cache_file = data_dir .. "/mason-installed"
	local installed = {}

	-- Load cached installation status
	local lines = {}
	local ok, lines_read = pcall(vim.fn.readfile, cache_file)
	if ok and lines_read and #lines_read > 0 then
		lines = lines_read
		for _, name in ipairs(lines) do
			installed[name] = true
		end
	end

	local servers = {
		{ bin = "ruff", mason = "ruff" },
		{ bin = "pyright-langserver", mason = "pyright" },
		{ bin = "lua-language-server", mason = "lua-language-server" },
		{ bin = "html-lsp", mason = "html-lsp" },
		{ bin = "css-lsp", mason = "css-lsp" },
		{ bin = "typescript-language-server", mason = "typescript-language-server" },
		{ bin = "dockerfile-language-server", mason = "dockerfile-language-server" },
		{ bin = "docker-compose-language-service", mason = "docker-compose-language-service" },
		{ bin = "json-lsp", mason = "json-lsp" },
		{ bin = "marksman", mason = "marksman" },
		{ bin = "bash-language-server", mason = "bash-language-server" },
		{ bin = "rust-analyzer", mason = "rust-analyzer" },
		{ bin = "clangd", mason = "clangd" },
		{ bin = "cmake-language-server", mason = "cmake-language-server" },
		{ bin = "vim-language-server", mason = "vim-language-server" },
		{ bin = "texlab", mason = "texlab" },
		{ bin = "lemminx", mason = "lemminx" },
		{ bin = "taplo", mason = "taplo" },
		{ bin = "nginx-language-server", mason = "nginx-language-server" },
		{ bin = "ansible-language-server", mason = "ansible-language-server" },
		{ bin = "omnisharp", mason = "omnisharp" },
	}

	local to_install = {}
	for _, s in ipairs(servers) do
		if not installed[s.mason] and vim.fn.executable(s.bin) ~= 1 then
			table.insert(to_install, s.mason)
		end
	end

	-- Install all at once to avoid repeated restarts
	if #to_install > 0 then
		local ok, err = pcall(vim.cmd, "MasonInstall " .. table.concat(to_install, " "))
		if ok then
			-- Cache successful installations
			vim.fn.writefile(to_install, cache_file, "a")
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

-- HTML
vim.lsp.config.html = {
	cmd = { "html-lsp", "--stdio" },
	filetypes = { "html", "templ" },
	root_markers = { "package.json", ".git" },
}
vim.lsp.enable("html")

-- CSS
vim.lsp.config.cssls = {
	cmd = { "css-lsp", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}
vim.lsp.enable("cssls")

-- TypeScript/JavaScript
vim.lsp.config.ts_ls = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "javascript" },
	root_markers = { "package.json", "tsconfig.json", ".git" },
}
vim.lsp.enable("ts_ls")

-- Docker
vim.lsp.config.dockerls = {
	cmd = { "dockerfile-language-server", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile", ".git" },
}
vim.lsp.enable("dockerls")

-- Docker Compose
vim.lsp.config.docker_compose_language_service = {
	cmd = { "docker-compose-language-service", "stdio" },
	filetypes = { "yaml.docker-compose" },
	root_markers = {
		"docker-compose.yaml",
		"docker-compose.yml",
		"compose.yaml",
		"compose.yml",
	},
}
vim.lsp.enable("docker_compose_language_service")

-- JSON
vim.lsp.config.jsonls = {
	cmd = { "json-lsp", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { ".git" },
}
vim.lsp.enable("jsonls")

-- Markdown
vim.lsp.config.marksman = {
	cmd = { "marksman" },
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = { ".git", ".marksman.toml" },
}
vim.lsp.enable("marksman")

-- LaTeX
vim.lsp.config.texlab = {
	cmd = { "texlab" },
	filetypes = { "tex", "plaintex", "bib" },
	settings = {
		texlab = {
			build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
			},
			chktex = { onEdit = false, onOpenAndSave = false },
			diagnosticsDelay = 300,
			formatterLineLength = 80,
		},
	},
}
vim.lsp.enable("texlab")

-- XML
vim.lsp.config.lemminx = {
	cmd = { "lemminx" },
	filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
	root_markers = { ".git" },
}
vim.lsp.enable("lemminx")

-- Bash
vim.lsp.config.bashls = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash" },
	root_markers = { ".git" },
	settings = {
		bashIde = {
			shellcheckPath = "shellcheck",
			shellcheckArguments = "--color=always -S style -W 1 -x",
		},
	},
}
vim.lsp.enable("bashls")

-- Rust
vim.lsp.config.rust_analyzer = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
	settings = {
		["rust-analyzer"] = {},
	},
}
vim.lsp.enable("rust_analyzer")

-- TOML
vim.lsp.config.taplo = {
	cmd = { "taplo" },
	filetypes = { "toml" },
	root_markers = { ".toml", ".git" },
}
vim.lsp.enable("taplo")

-- Vim
vim.lsp.config.vimls = {
	cmd = { "vim-language-server", "--stdio" },
	filetypes = { "vim" },
	root_markers = { ".git" },
	settings = {
		diagnostic = { enable = true },
		indexes = { count = 3, gap = 100 },
		isNeovim = true,
	},
}
vim.lsp.enable("vimls")

-- Nginx
vim.lsp.config.nginx_language_server = {
	cmd = { "nginx-language-server", "--stdio" },
	filetypes = { "nginx" },
	root_markers = { ".git" },
}
vim.lsp.enable("nginx_language_server")

-- CMake
vim.lsp.config.cmake = {
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	root_markers = { "CMakeLists.txt", "CMakePresets.json", ".git" },
	settings = {
		buildDirectory = "build",
	},
}
vim.lsp.enable("cmake")

-- C/C++
vim.lsp.config.clangd = {
	cmd = { "clangd", "--offset-encoding=utf-16" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	root_markers = {
		".clangd",
		".clang-tidy",
		"compile_commands.json",
		"compile_flags.txt",
		".git",
	},
}
vim.lsp.enable("clangd")

-- C#
vim.lsp.config.csharp_ls = {
	cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
	filetypes = { "cs" },
	root_markers = { ".csproj", ".git" },
	settings = {
		AutomaticWorkspaceInit = true,
	},
}
vim.lsp.enable("csharp_ls")

-- Ansible
vim.lsp.config.ansiblels = {
	cmd = { "ansible-language-server", "--stdio" },
	filetypes = { "yaml", "yml" },
	root_markers = { ".ansible-lint", ".git" },
	settings = {
		ansible = {
			ansible = { path = "ansible", useFullyQualifiedCollectionNames = true },
			ansibleLint = { enabled = true, path = "ansible-lint" },
			completion = { provideRedirectModules = true },
		},
	},
}
vim.lsp.enable("ansiblels")

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
