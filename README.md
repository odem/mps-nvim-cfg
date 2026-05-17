# nvim-dev

A lightweight, fast Neovim configuration built on **Neovim 0.12+**
native APIs. Modular plugin specs, native `vim.lsp.config` for language
servers (no lspconfig), blink.cmp for completion, lazy.nvim for plugin
management.

## Core Features

- **Native first** — uses `vim.lsp.config` + `vim.lsp.enable`
  instead of nvim-lspconfig; no overrides of sensible Neovim
  defaults.
- **Modular** — plugins grouped by domain (appearance, navigation,
  tools, debugging), each with own file, loaded by lazy.nvim's `spec`
  list. No monolithic `init.lua` or single-file configs.
- **Fast startup** — lazy.nvim with per-plugin `keys`/`cmd`/`ft`
  triggers; autoload-only plugins never run at startup.
- **Fail-safe** — `pcall` wraps operations that could fail (missing
  colorscheme, `mkdir`, keymap deletions).
- **Self-documenting keybinds** — every `desc` uses `[bracket]`
  notation for which-key integration.

## Project structure

```
nvim-dev/
├── README.md                 This file
├── docs/                    Documentation
│   ├── README-APPEARANCE.md
│   ├── README-CORE.md
│   ├── README-DEBUGGING.md
│   ├── README-HELPERS.md
│   ├── README-KEYBINDS.md
│   ├── README-NAVIGATION.md
│   ├── README-OPTIONS.md
│   └── README-TOOLS.md
├── init.lua                  Entry point (8 lines)
├── Makefile                  Build/lint/check tasks
├── lazy-lock.json            Locked dependencies
├── lua/
│   ├── init/                 Bootstrap & core setup
│   │   ├── bootstrap.lua     lazy.nvim bootstrap
│   │   ├── plugins.lua       Spec aggregator
│   │   ├── lsp.lua           21 LSP servers
│   │   └── friendly-snippets.lua
│   ├── options.lua           vim.opt, disabled built-ins, providers
│   ├── keymaps.lua           Global keybindings
│   ├── helpers/              Utility modules
│   │   ├── quickfix.lua
│   │   ├── smart_delete.lua
│   │   └── themes.lua
│   ├── core/                 Core plugin specs
│   │   ├── completion.lua   blink.cmp + LuaSnip
│   │   ├── friendly-snippets.lua
│   │   ├── lazydev.lua
│   │   ├── lasnip.lua        Custom snippets
│   │   ├── lsp.lua           Native LSP config
│   │   ├── mason.lua         LSP/DAP installer
│   │   ├── neoconf.lua
│   │   ├── treesitter.lua
│   │   ├── telescope.lua
│   │   ├── telescope-custom.lua
│   │   ├── undotree.lua
│   │   └── which-key.lua
│   ├── appearance/           UI plugins (colorschemes, statusline)
│   │   ├── init.lua
│   │   ├── tokyonight.lua
│   │   ├── gruvbox.lua
│   │   ├── gitsigns.lua
│   │   ├── lualine.lua
│   │   ├── bufferline.lua
│   │   ├── scrollbar.lua
│   │   └── ...
│   ├── navigation/           File navigation & fuzzy finding
│   │   ├── init.lua
│   │   ├── neo-tree.lua
│   │   ├── oil.lua
│   │   ├── harpoon.lua
│   │   ├── snipe.lua
│   │   ├── yazi.lua
│   │   └── flash.lua
│   ├── tools/                Development tools
│   │   ├── init.lua
│   │   ├── toggleterm.lua
│   │   ├── overseer.lua
│   │   ├── rest-console.lua
│   │   ├── git.lua
│   │   ├── hlslens.lua
│   │   ├── todo-comments.lua
│   │   └── ...
│   └── debugging/             DAP configuration
│       ├── init.lua
│       └── core.lua
├── testfiles/                LSP validation test files
│   ├── foo.py, index.ts, main.c, ...
│   └── docker-compose.yaml, foo.toml, ...
```

## Load order

```
init.lua
├── options.lua               vim.opt, disabled built-ins, providers
├── keymaps.lua              global keybindings
└── init/
    ├── bootstrap.lua         lazy.nvim bootstrap
    ├── plugins.lua          loads all plugin specs (core/, appearance/, navigation/, tools/, debugging/)
    └── lsp.lua              native LSP config (21 servers)
```

(The require chain in `init.lua` is the exact load order.)

---

## Files

### [Options](docs/README-OPTIONS.md)

Toggles all relevant `vim.opt` settings: display (number,
signcolumn, colorcolumn), editor behaviour (scrolloff, breakindent),
tabs (4-wide), splits, search (smartcase, inccommand), folding,
files (undodir, swapfile), completion (menuone,noselect), grep (rg),
spell (de+en), timing, clipboard.

Disabled built-in plugins that are replaced by alternatives (netrw,
gzip, tar, vimball, etc.) and unused providers (node, perl, ruby).

### [Keymaps](docs/README-KEYBINDS.md)

All hand-authored global keybindings grouped by category:
escape/mode, window nav, save/source/quit, search, splits, buffers,
quickfix, line movement, indentation, blackhole registers, shell
commands, sessions, editor tools (snipe, neo-tree), smart delete.

Helper modules (`quickfix`, `smart_delete`) are loaded locally at
the top of the file to avoid repeated `require` calls on every
keystroke.

### [Core](docs/README-CORE.md)

Plugin specs for core functionality: completion (blink.cmp, LuaSnip),
LSP setup (native vim.lsp.config), treesitter, mason.nvim, lazydev,
neoconf, which-key.

### [Helpers](docs/README-HELPERS.md)

Shared utility modules used by `keymaps.lua` and plugin `config()`
functions.

### [Appearance](docs/README-APPEARANCE.md)

UI plugins: colorschemes (tokyonight, gruvbox), statusline (lualine),
buffer tabs (bufferline), scrollbar, git signs (gitsigns), indent
highlighting, yank highlight, window decorations.

### [Navigation](docs/README-NAVIGATION.md)

File navigation: neo-tree (file tree), oil (directory editing),
telescope (fuzzy finder), harpoon (file marks), snipe (buffer picker),
yazi (file jumper), flash (motion).

### [Tools](docs/README-TOOLS.md)

Development tools: toggleterm (terminal), overseer (task runner),
rest.nvim (HTTP client), git (fugitive), hlslens (search lens),
todo-comments, autotag, dadbod (DB), sleuth (filetype detection).

### [Debugging](docs/README-DEBUGGING.md)

nvim-dap configuration for debugging (C, Go, Rust, Python, Node.js).

---

## Plugin Quick Reference

| Category | Plugin | Config File | Description |
|----------|--------|-------------|-------------|
| **LSP** | vim.lsp.config | [`lua/init/lsp.lua`](lua/init/lsp.lua) | Native LSP (21 servers) |
| **Completion** | blink.cmp | [`lua/core/completion.lua`](lua/core/completion.lua) | Auto-completion engine |
| **Snippets** | LuaSnip | [`lua/core/luasnip.lua`](lua/core/luasnip.lua) | Snippet expansion |
| **Treesitter** | nvim-treesitter | [`lua/core/treesitter.lua`](lua/core/treesitter.lua) | Syntax highlighting |
| **Package Mgr** | mason.nvim | [`lua/core/mason.lua`](lua/core/mason.lua) | LSP/DAP installer |
| **File Explorer** | neo-tree | [`lua/navigation/neo-tree.lua`](lua/navigation/neo-tree.lua) | File tree |
| **Directory Edit** | oil.nvim | [`lua/navigation/oil.lua`](lua/navigation/oil.lua) | Edit directories as buffers |
| **Buffer Picker** | snipe.nvim | [`lua/navigation/snipe.lua`](lua/navigation/snipe.lua) | Quick buffer switching |
| **Fuzzy Finder** | telescope.nvim | [`lua/core/telescope.lua`](lua/core/telescope.lua) | File/search picker |
| **Quick Nav** | harpoon | [`lua/navigation/harpoon.lua`](lua/navigation/harpoon.lua) | File marks |
| **Git** | gitsigns | [`lua/appearance/gitsigns.lua`](lua/appearance/gitsigns.lua) | Git hunk signs |
| **Terminal** | toggleterm.nvim | [`lua/tools/toggleterm.lua`](lua/tools/toggleterm.lua) | Embedded terminal |
| **Debug** | nvim-dap | [`lua/debugging/core.lua`](lua/debugging/core.lua) | Debug adapter protocol |
| **Task Runner** | overseer.nvim | [`lua/tools/overseer.lua`](lua/tools/overseer.lua) | Build/task runner |
| **REST Client** | rest.nvim | [`lua/tools/rest-console.lua`](lua/tools/rest-console.lua) | HTTP testing |
| **Statusline** | lualine | [`lua/appearance/lualine.lua`](lua/appearance/lualine.lua) | Status line |
| **Buffer Tabs** | bufferline | [`lua/appearance/bufferline.lua`](lua/appearance/bufferline.lua) | Buffer tabline |
| **Scrollbar** | nvim-scrollbar | [`lua/appearance/scrollbar.lua`](lua/appearance/scrollbar.lua) | Scrollbar |
| **Colorscheme** | tokyonight | [`lua/appearance/tokyonight.lua`](lua/appearance/tokyonight.lua) | Dark theme |

---

## See Also

- [Options](docs/README-OPTIONS.md) — All vim options
- [Keymaps](docs/README-KEYBINDS.md) — Complete keybind reference
- [Core](docs/README-CORE.md) — Core plugins
- [Helpers](docs/README-HELPERS.md) — Utility modules
- [Appearance](docs/README-APPEARANCE.md) — UI plugins
- [Navigation](docs/README-NAVIGATION.md) — Navigation plugins
- [Tools](docs/README-TOOLS.md) — Development tools
- [Debugging](docs/README-DEBUGGING.md) — Debugging tools