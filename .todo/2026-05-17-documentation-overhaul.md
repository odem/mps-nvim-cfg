# Todo: nvim-dev Documentation Complete Overhaul

**Created**: 2026-05-17
**Goal**: Finalize all documentation after plugin migration

---

## Phase 1: README-OPTIONS.md (NEW)

**File**: `README-OPTIONS.md`

Document `lua/options.lua`:
- Display settings (number, signcolumn, colorcolumn)
- Editor behavior (scrolloff, breakindent, tabstop)
- File handling (undodir, swapfile)
- Search settings (smartcase, inccommand)
- Completion (menuone, noselect)
- Disabled built-ins (netrw, gzip, tarball, etc.)
- Providers (clipboard, python, node)

---

## Phase 2: README-APPEARANCE.md (NEW)

**File**: `README-APPEARANCE.md`

Document 15 appearance plugins:

| Plugin | File | Description |
|--------|------|-------------|
| tokyonight | `tokyonight.lua` | Primary colorscheme |
| gruvbox | `gruvbox.lua` | Alternative colorscheme |
| gitsigns | `gitsigns.lua` | Git hunk decorations + navigation |
| colorizer | `colorizer.lua` | Color code highlighting |
| windows | `windows.lua` | Window management enhancements |
| yank-highlight | `yank-highlight.lua` | Highlight yanked text |
| lualine | `lualine.lua` | Status line |
| bufferline | `bufferline.lua` | Buffer tabline |
| scrollbar | `scrollbar.lua` | Scrollbar with hlslens |
| indent-blankline | `indent-blankline.lua` | Indent guides |
| colorful-winsep | `colorful-winsep.lua` | Window separator colors |
| barbecue | `barbecue.lua` | Breadcrumb navigation |
| alpha | `alpha.lua` | Startup screen |
| symbols-outline | `symbols-outline.lua` | Symbol outline view |

---

## Phase 3: README-NAVIGATION.md (NEW)

**File**: `README-NAVIGATION.md`

Document 6 navigation plugins:

| Plugin | File | Keybinds |
|--------|------|----------|
| neo-tree | `neo-tree.lua` | `<A-e>`, `<A-E>` |
| oil | `oil.lua` | `-` |
| yazi | `yazi.lua` | `<A-y>` |
| harpoon | `harpoon.lua` | `hx`, `hm`, `hn`, `hp`, `11`-`55` |
| snipe | `snipe.lua` | `<A-s>` |
| flash | `flash.lua` | (motion search) |

---

## Phase 4: README-TOOLS.md (NEW)

**File**: `README-TOOLS.md`

Document 11 tool plugins:

| Plugin | File | Keybinds |
|--------|------|----------|
| telescope | `telescope.lua` | `<leader>T`, `<leader>t*`, `gd`, `gr` |
| telescope-custom | `telescope-custom.lua` | `<leader>tcs*` |
| toggleterm | `toggleterm.lua` | (terminal embedded) |
| overseer | `overseer.lua` | Task runner |
| dadbod | `dadbod.lua` | Database viewer |
| rest-console | `rest-console.lua` | HTTP client |
| git | `git.lua` | `<leader>gg`, `<leader>gf` |
| hlslens | `hlslens.lua` | Search lens |
| autotag | `autotag.lua` | Auto-close tags |
| todo-comments | `todo-comments.lua` | `]t`, `[t`, `<leader>ft` |
| sleuth | `sleuth.lua` | (auto-indent) |

---

## Phase 5: README-DEBUGGING.md (NEW)

**File**: `README-DEBUGGING.md`

Document debugging setup:

- nvim-dap (core DAP)
- nvim-dap-ui (UI)
- nvim-dap-python (Python debug)
- persistent-breakpoints (breakpoint persistence)
- gdb (GDB integration)

**Keybinds**: `<F9>` continue, `<F10>` step over, `<F11>` step into, `<F12>` terminate, `mm` toggle breakpoint

---

## Phase 6: Update README.md

**File**: `README.md`

Add sections:

### Plugin Quick Reference

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

### See Also
- `README-OPTIONS.md` - All vim options
- `README-KEYBINDS.md` - Complete keybind reference
- `README-CORE.md` - Core plugins
- `README-HELPERS.md` - Utility modules
- `README-APPEARANCE.md` - UI plugins
- `README-NAVIGATION.md` - Navigation plugins
- `README-TOOLS.md` - Development tools
- `README-DEBUGGING.md` - Debugging tools

---

## Phase 7: Update README-CORE.md

**File**: `README-CORE.md`

Add migrated plugins:
- **autopairs** - Auto-pair brackets/quotes
- **fidget** - LSP progress notifications

Update existing:
- **treesitter** - Add jsonc parser
- **mason** - Document ensure_installed list
- **completion** - Update for blink.cmp

---

## Phase 8: Update README-KEYBINDS.md

**File**: `README-KEYBINDS.md`

Add missing keybinds:

### Git
| Keys | Action | File |
|------|--------|------|
| `]c` | Next hunk | gitsigns |
| `[c` | Prev hunk | gitsigns |
| `<leader>ghs` | Stage hunk | gitsigns |
| `<leader>ghr` | Reset hunk | gitsigns |
| `<leader>ghp` | Preview hunk | gitsigns |
| `<leader>gg` | Open lazygit | git |
| `<leader>gf` | Lazygit file | git |

### Debug
| Keys | Action |
|------|--------|
| `<F9>` | Start/Continue |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Terminate |
| `mm` | Toggle breakpoint |
| `<leader>b*` | Breakpoint management |
| `<leader>d*` | Debug commands |

### Todo
| Keys | Action |
|------|--------|
| `]t` | Next todo |
| `[t` | Prev todo |
| `<leader>ft` | Search todos |

### Window
| Keys | Action |
|------|--------|
| `<C-w>z` | Maximize |
| `<C-w>_` | Equalize |

---

## Phase 9: Cleanup + Quality Assurance

### Code Quality Checks
- Run luacheck on all Lua files
- Check Neovim loads without errors (`nvim --headless -c "q"`)
- Verify no deprecated API warnings
- Validate all plugin repository URLs

### Fix Known Issues
- Replace deprecated `vim.tbl_*` APIs with `vim.iter():*` alternatives
- Ensure all `pcall` wrappers are in place for fail-safe operations
- Fix any plugin config issues causing warnings

### Final Review
- Remove any placeholder TODOs in code
- Verify all plugin specs have `desc` fields
- Ensure all READMEs reference each other appropriately
- All keybinds use `[Category] Description` format

---

## Phase 10: Add Validation Scripts (NEW)

### Create `.luacheckrc`

```lua
-- luacheck configuration
-- .luacheckrc
```

### Create `Makefile`

```makefile
.PHONY: lint check health validate

lint:       ## Run luacheck on all Lua files
	luacheck lua/

check:      ## Check Neovim config loads without errors
	XDG_CONFIG_HOME=$$HOME/.config/nvim-dev nvim --headless -c "q"

health:    ## Run :checkhealth internally
	XDG_CONFIG_HOME=$$HOME/.config/nvim-dev nvim --headless -c "checkhealth" -c "q"

validate:   ## Full validation suite
	$(MAKE) lint
	$(make) check
```

### Add Validation to CI/CD (Optional)
- GitHub Actions workflow for automated linting
- Run on every commit and PR

---

## Execution Order

1. Phase 1 → Phase 5 (create new READMEs)
2. Phase 6 → Phase 8 (update existing)
3. Phase 9 (cleanup + QA)
4. Phase 10 (add validation tooling)

---

## Notes for Agents

- Use consistent format for each plugin block (see README-CORE.md)
- Include repository URL, one-line description, key settings, keybinds table
- All keybinds should use `[Category] Description` format
- Each phase can be executed independently
- Run `make validate` before considering Phase 9/10 complete