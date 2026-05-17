# core/

Plugin specs and native configuration for the Neovim config at
`lua/core/`.

---

## autopairs

windwp/nvim-autopairs — auto-pair brackets and quotes.

### Configuration

Minimal setup: default `opts = {}`. Automatically pairs brackets,
quotes, and tags. Uses `nvim-autopairs` internal rules.

---

## completion

Blink.cmp completion engine with LuaSnip as the snippet backend.

### Configuration

**Keymaps:** `<Tab>` select next / snippet forward / fallback;
`<S-Tab>` previous / fallback; `<C-y>` accept; `<C-space>` /
`<C-@>` show/hide.

**Sources:** `lsp`, `path`, `snippets`, `buffer` (in that order).

**Snippet backend:** LuaSnip.

The full `opts` table is passed directly to blink.cmp's `setup()`.
All options match defaults except the custom keymap bindings above.
  



---

## harpoon

ThePrimeagen/harpoon for quick file marking and navigation.

### Configuration

Uses the legacy v1 API (`harpoon.mark`, `harpoon.ui`) via
lazy.nvim `keys` entries — no explicit `config` function. Keymaps
are defined inline in the spec:

| Keys | Action          |
|------|-----------------|
| `hx` | Add file        |
| `hm` | Toggle menu     |
| `hn` | Next file       |
| `hp` | Prev file       |
| `11`-`55` | Nav file 1-5 |

No `opts` or custom setup — relies entirely on lazy.nvim's
auto-loading on keypress.
  



---

## fidget

folke/fidget.nvim — LSP progress notifications.

### Configuration

Minimal setup: default `opts = {}`. Shows LSP server progress
in a floating window or notification.

---

## lazydev

folke/lazydev.nvim for Neovim API completion in Lua files.

### Configuration

Loaded only for `ft = 'lua'`. Uses default `opts = {}`. This
replaces the old approach of manually adding `vim`-api paths to
the Lua LSP workspace library.
  



---

## lazy

lazy.nvim bootstrap and plugin registry.

### Configuration

Bootstraps lazy.nvim by cloning it to `stdpath('data')/lazy/lazy.nvim`
if not already present, then prepends it to the runtimepath.

The `setup()` call takes a `spec` list of 16 plugin specs, each
returned from its own file under `lua/core/`. `change_detection`
is set to `{ notify = false }` to suppress update notifications.
  



---

## lsp

Native LSP configuration using Neovim 0.11+ APIs (`vim.lsp.config`,
`vim.lsp.enable`).

### Configuration

Three language servers configured:

- **ruff** (`ruff server`) — Python linting and formatting
- **pyright** (`pyright-langserver`) — Python type checking
- **lua_ls** (`lua-language-server`) — Lua diagnostics

Key behaviours:

- Default capabilities register `snippetSupport` for all servers.
- Missing servers are auto-installed via `:MasonInstall` inside a
  `vim.schedule` call (non-blocking startup).
- Inlay hints enabled globally.
- Diagnostic signs use custom Unicode glyphs.
- `LspAttach` auto-command sets buffer-local keymaps for
  navigation (gD, gh, gk, gsh, gK), code actions (gca, gn, gtf),
  and diagnostics ([d, ]d).

Differs from defaults: using `vim.schedule` for Mason install
rather than blocking startup; custom `LspAttach` keymaps instead
of relying on lspconfig defaults.
  



---

## luasnip

LuaSnip snippet engine with a small set of custom snippets.

### Configuration

**Keys:** `<A-n>` expand/jump forward, `<A-p>` jump backward
(both in insert and select modes only — no normal-mode conflict
with `cnext`).

**Snippets:**
- **Python** — `print("<>")` wrapping insert node
- **REST** — Full request template with host, headers, body

The `keys` table uses `mode = { 'i', 's' }` to ensure LuaSnip's
loading trigger doesn't interfere with the normal-mode `<A-n>`
mapped to `cnext` in `keymaps.lua`.
  



---

## mason

williamboman/mason.nvim — LSP/DAP/linter installer.

### Configuration

Minimal setup: just `:MasonUpdate` on install and default `opts`.
No mason-lspconfig integration — server configs are set up via
native `vim.lsp.config` in `lsp.lua` with their own auto-install
loop.

**Ensure Installed:**
- `ruff` — Python linter/formatter
- `pyright` — Python type checker
- `lua-language-server` — Lua LSP
  



---

## neoconf

folke/neoconf.nvim — JSON-based project-local configuration.

### Configuration

Depends on `neovim/nvim-lspconfig` (needed for `lspconfig.util`
internally). Uses default `opts = {}`. Neoconf reads
`.neoconf.json` and `.nvim/config.lua` files from project roots.
  



---

## neo-tree

nvim-neo-tree/neo-tree.nvim v3.x — file explorer.

### Configuration

**Sources:** filesystem, buffers, git_status (all three enabled).
**Behaviour:** `follow_current_file` enabled, libuv file watcher
active, auto-closes when a file is opened
(`file_open_requested` → close).
**Window:** 30-wide left sidebar.

Differs from defaults: the auto-close-on-open handler is a custom
addition; default neo-tree stays open after selecting a file.
  



---

## oil

stevearc/oil.nvim — file explorer as a buffer (like vim-vinegar).

### Configuration

Only non-default setting: `default_file_explorer = true` (Oil
replaces netrw as the default directory opener). All other
options (`win_options`, `keymaps`, `view_options`, `float`,
`preview_win`, `confirmation`, etc.) are left to Oil's defaults.

Key: `-` opens Oil parent directory. `lazy = false` — loads at
startup (intentional, matches the user's old config).
  



---

## snipe

leath-dub/snipe.nvim — quick buffer picker with two-letter hints.

### Configuration

**UI:** Positioned `topleft`, full width (`max_width = -1`).
**Hints dictionary:** `sadflewcmpghio` (home-row heavy).
**Navigation:** `J`/`K` for page up/down, `<cr>` to select under
cursor, `<esc>` to cancel. Sort is `default`.

Key: `<A-s>` opens the buffer menu.
  



---

## telescope

nvim-telescope/telescope.nvim — fuzzy finder.

### Configuration

**Dependencies:** plenary.nvim, telescope-fzf-native.nvim
(builds via `make` if available).

**Layout:** Default horizontal with `prompt_position = 'bottom'`,
`selection_caret = '  '`, `winblend = 10`, `border = true`,
`path_display = 'smart'`.

**~40 keymaps** are defined via lazy.nvim's `keys` table,
including:
- `<leader>t*` — built-in pickers (buffers, files, grep, etc.)
- `<leader>tcs*` — custom file searches (/, ~/mps, /var, etc.)
- `g[ldrt]*` — LSP pickers (definitions, references, type defs,
  symbols, diagnostics)
- `gd`, `gr` — override default LSP bindings (with `nowait` on
  `gr` to avoid timeout from leftover `grr`/`gra` mappings)

A cleanup loop removes old `gr*` keymaps (`grr`, `gra`, `gri`,
`grn`, `grt`, `grx`) that cause prefix conflicts with `gr`.

Differs from defaults: `preview.treesitter = false` (disabled for
performance); `prompt_position = 'bottom'`; custom LSP keymaps
use `g[l]` prefix instead of bare `g[r]` to avoid conflicts.
  



---

## tokyonight

folke/tokyonight.nvim — colorscheme.

### Configuration

Loaded at `priority = 1000` (high priority for colorschemes).
The `config()` function calls
`require('helpers.themes').setColorScheme('tokyonight')`
to apply it using a protected call (gracefully handles missing
plugin).
  



---

## treesitter

nvim-treesitter/nvim-treesitter — syntax highlighting and parsing.

### Configuration

**Parsers:** `ensure_installed = { 'python', 'lua', 'jsonc' }` plus
`auto_install = true` (installs parsers for any new filetype
on the fly). Highlight enabled; no other modules (folding,
indent) are turned on.

Differs from defaults: specifying python, lua, and jsonc explicitly
while letting `auto_install` handle the rest keeps the initial
install lean.
  



---

## undotree

mbbill/undotree — visual undo history browser.

### Configuration

No custom config. Key: `<leader>u` toggles the undotree window.
  



---

## which-key

folke/which-key.nvim — keybinding popup helper.

### Configuration

Uses default `opts = {}`. Shows keybinding hints after pressing
a prefix key (leader, `g`, etc.) with a configurable delay.
  



---

## yazi

mikavilpas/yazi.nvim — Yazi file manager integration.

### Configuration

**Version:** `*` (latest). Depends on plenary.nvim.
**Key:** `<A-y>` opens Yazi.
**Options:** `open_for_directories = false` (prefer Oil for dirs);
help bound to `<f1>`.
  


