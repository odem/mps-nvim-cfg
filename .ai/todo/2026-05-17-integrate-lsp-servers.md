# Todo: Integrate Additional LSP Servers from Old Config

**Created**: 2026-05-17
**Goal**: Add 18 LSP servers from old config to nvim-dev

---

## Existing LSP Servers (already in nvim-dev)

- `ruff` — Python formatting/linting
- `pyright` — Python type checking
- `lua_ls` — Lua configuration files

---

## New LSP Servers to Add (18 total)

| Server | Mason Package | Status |
|--------|---------------|--------|
| html | `html` | ✅ |
| cssls | `css-lsp` | ✅ |
| ts_ls | `typescript-language-server` | ✅ |
| dockerls | `dockerfile-language-server` | ✅ |
| docker_compose_language_service | `docker-compose-language-service` | ✅ |
| texlab | `texlab` | ⚠️ needs latexmk, latexindent |
| jsonls | `json-lsp` | ✅ |
| marksman | `marksman` | ✅ |
| lemminx | `lemminx` | ⚠️ needs Java |
| bashls | `bash-language-server` | ✅ |
| rust_analyzer | `rust-analyzer` | ✅ |
| taplo | `taplo` | ✅ |
| vimls | `vim-language-server` | ✅ |
| nginx_language_server | `nginx-language-server` | ✅ |
| cmake | `cmake-language-server` | ✅ |
| clangd | `clangd` | ✅ |
| csharp_ls | `csharp-ls` | ⚠️ needs .NET SDK |
| ansiblels | `ansible-lint` | ⚠️ needs Ansible |

---

## System Dependencies (Manual Install)

**Essential** (install via apt):
```bash
sudo apt install shellcheck cmake clangd
```

**Optional** (skip if not available):
- `latexmk`, `latexindent` — for LaTeX
- Java — for XML (lemminx)
- .NET SDK — for C#
- Ansible — for Ansible support

---

## Implementation

### Step 1: Update `lua/core/lsp.lua`

Add 18 new server configs using `vim.lsp.config` API (already compatible).

### Step 2: Update `lua/core/mason.lua`

Add all servers to auto-install list.

### Step 3: Verify

- `make check` — verify config loads
- `make lint` — verify no warnings
- Restart Neovid to trigger Mason installs

---

## Notes

- All servers use native `vim.lsp.config` API (already compatible)
- EFM server skipped — use native LSP formatters instead
- Omnisharp skipped — requires hardcoded path
- Servers marked ⚠️ won't work until external deps installed (but configs load fine)