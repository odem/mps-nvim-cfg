# nvim-dev

A lightweight, fast Neovim configuration built on **Neovim 0.12+**
native APIs. Modular plugin specs in `lua/core/`, native
`vim.lsp.config` for language servers (no lspconfig), blink.cmp for
completion, lazy.nvim for plugin management.

## Design principles

- **Native first** — uses `vim.lsp.config` + `vim.lsp.enable`
  instead of nvim-lspconfig; no overrides of sensible Neovim
  defaults.
- **Modular** — each plugin is a single file under `lua/core/`,
  loaded by lazy.nvim's `spec` list. No monolithic `init.lua` or
  single-file configs.
- **Fast startup** — lazy.nvim with per-plugin `keys`/`cmd`/`ft`
  triggers; autoload-only plugins never run at startup.
- **Fail-safe** — `pcall` wraps operations that could fail (missing
  colorscheme, `mkdir`, keymap deletions).
- **Self-documenting keybinds** — every `desc` uses `[bracket]`
  notation for which-key integration.

## Project structure

```
nvim-dev/
├── init.lua                  Entry point (7 lines of requires)
├── README.md                 This file
├── README-CORE.md            Per-plugin documentation
├── README-HELPERS.md         Utility module docs
├── README-KEYBINDS.md        Complete keybind reference
│
├── lua/
│   ├── options.lua           vim.opt, disabled built-ins, providers
│   ├── keymaps.lua           Global keybindings (cached helpers)
│   │
│   ├── helpers/              Utility modules
│   │   ├── quickfix.lua         Toggle qf window
│   │   ├── smart_delete.lua     WORD-aware backspace/delete
│   │   ├── telescope-custom.lua find_files at fixed cwds
│   │   └── themes.lua           Protected setColorScheme()
│   │
│   └── core/                 Plugin specs — one file per plugin
│       ├── lazy.lua          lazy.nvim bootstrap + spec aggregator
│       ├── lsp.lua           Native LSP config for ruff, pyright, lua_ls
│       ├── mason.lua
│       ├── completion.lua    blink.cmp + LuaSnip
│       ├── luasnip.lua       Custom snippets (python, rest)
│       ├── treesitter.lua
│       ├── neo-tree.lua
│       ├── oil.lua           Minimal config (just default_file_explorer)
│       ├── telescope.lua     ~40 keymaps, slim layout config
│       ├── telescope-custom.lua
│       ├── harpoon.lua
│       ├── undotree.lua
│       ├── yazi.lua
│       ├── snipe.lua
│       ├── lazydev.lua
│       ├── neoconf.lua
│       ├── which-key.lua
│       ├── tokyonight.lua     Colorscheme via helpers.themes
│   
```

## Load order

```
init.lua
├── options              vim.opt, disabled built-ins, providers
├── keymaps              global keybindings
└── core.lazy            lazy.nvim bootstrap → loads all plugin specs
    └── core.lsp         native LSP config (runs after lazy set-up)
```

(The require chain in `init.lua` is the exact load order.)

## Files

### options

Toggles all relevant `vim.opt` settings: display (number,
signcolumn, colorcolumn), editor behaviour (scrolloff, breakindent),
tabs (4-wide), splits, search (smartcase, inccommand), folding,
files (undodir, swapfile), completion (menuone,noselect), grep (rg),
spell (de+en), timing, clipboard.

Disabled built-in plugins that are replaced by alternatives (netrw,
gzip, tar, vimball, etc.) and unused providers (node, perl, ruby).

### keymaps

All hand-authored global keybindings grouped by category:
escape/mode, window nav, save/source/quit, search, splits, buffers,
quickfix, line movement, indentation, blackhole registers, shell
commands, sessions, editor tools (snipe, neo-tree), smart delete.

Helper modules (`quickfix`, `smart_delete`) are loaded locally at
the top of the file to avoid repeated `require` calls on every
keystroke.

### core/

Plugin specs and native configuration. Each plugin lives in its own
file under `lua/core/` and is loaded by lazy.nvim's `spec` list in
`lazy.lua`. See `README-CORE.md` for per-plugin documentation.

### helpers/

Shared utility modules used by `keymaps.lua` and plugin `config()`
functions. See `README-HELPERS.md` for details.

---

## Plugin Quick Reference

| Category | Plugin | Config File | Description |
|----------|--------|-------------|-------------|
| **LSP** | vim.lsp.config | `core/lsp.lua` | Native LSP (ruff, pyright, lua_ls) |
| **Completion** | blink.cmp | `core/completion.lua` | Auto-completion engine |
| **Snippets** | LuaSnip | `core/luasnip.lua` | Snippet expansion |
| **Treesitter** | nvim-treesitter | `core/treesitter.lua` | Syntax highlighting |
| **Package Mgr** | mason.nvim | `core/mason.lua` | LSP/DAP installer |
| **File Explorer** | neo-tree | `navigation/neo-tree.lua` | File tree |
| **Directory Edit** | oil.nvim | `navigation/oil.lua` | Edit directories as buffers |
| **Buffer Picker** | snipe.nvim | `navigation/snipe.lua` | Quick buffer switching |
| **Fuzzy Finder** | telescope.nvim | `core/telescope.lua` | File/search picker |
| **Quick Nav** | harpoon | `navigation/harpoon.lua` | File marks |
| **Git** | gitsigns | `appearance/gitsigns.lua` | Git hunk signs |
| **Terminal** | toggleterm.nvim | `tools/toggleterm.lua` | Embedded terminal |
| **Debug** | nvim-dap | `debugging/core.lua` | Debug adapter protocol |
| **Task Runner** | overseer.nvim | `tools/overseer.lua` | Build/task runner |
| **REST Client** | rest.nvim | `tools/rest-console.lua` | HTTP testing |
| **Statusline** | lualine | `appearance/lualine.lua` | Status line |
| **Buffer Tabs** | bufferline | `appearance/bufferline.lua` | Buffer tabline |
| **Scrollbar** | nvim-scrollbar | `appearance/scrollbar.lua` | Scrollbar |
| **Colorscheme** | tokyonight | `appearance/tokyonight.lua` | Dark theme |

---

## See Also

- `README-OPTIONS.md` - All vim options
- `README-KEYBINDS.md` - Complete keybind reference
- `README-CORE.md` - Core plugins
- `README-HELPERS.md` - Utility modules
- `README-APPEARANCE.md` - UI plugins
- `README-NAVIGATION.md` - Navigation plugins
- `README-TOOLS.md` - Development tools
- `README-DEBUGGING.md` - Debugging tools
