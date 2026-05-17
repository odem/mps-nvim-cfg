# Development Tools

Tool plugins from `lua/tools/` and `lua/core/`.

---

## Fuzzy Finder

### Telescope

**File**: `core/telescope.lua`  
**Repository**: [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)  
**Description**: File/search picker with fzf-native  
**Key Settings**: Custom layout, fzf-native extension

| Keys | Action |
|------|--------|
| `<leader>T` | Telescope main menu |
| `<leader>tf` | Find files |
| `<leader>tg` | Grep |
| `<leader>tb` | Buffers |
| `<leader>th` | Help tags |
| `gd` | LSP definitions |
| `gr` | LSP references |

### Telescope Custom

**File**: `core/telescope-custom.lua`  
**Repository**: [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)  
**Description**: Telescope extensions  
**Key Settings**: Fixed cwd find_files

---

## Terminal

### ToggleTerm

**File**: `tools/toggleterm.lua`  
**Repository**: [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)  
**Description**: Embedded terminal  
**Key Settings**: None (terminal embedded)

---

## Task Runner

### Overseer

**File**: `tools/overseer.lua`  
**Repository**: [stevearc/overseer.nvim](https://github.com/stevearc/overseer.nvim)  
**Description**: Task runner  
**Key Settings**: None

---

## Database

### Dadbod

**File**: `tools/dadbod.lua`  
**Repository**: [tpope/vim-dadbod](https://github.com/tpope/vim-dadbod)  
**Description**: Database viewer  
**Key Settings**: None

---

## REST Client

### Rest Console

**File**: `tools/rest-console.lua`  
**Repository**: [rest-nvim/rest.nvim](https://github.com/rest-nvim/rest.nvim)  
**Description**: HTTP client  
**Key Settings**: None

---

## Git

### Git

**File**: `tools/git.lua`  
**Repository**: [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)  
**Description**: Lazygit integration  
**Key Settings**: None

| Keys | Action |
|------|--------|
| `<leader>gg` | Open lazygit |
| `<leader>gf` | Lazygit file |

---

## Search

### Hlslens

**File**: `tools/hlslens.lua`  
**Repository**: [kevinhwang91/nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens)  
**Description**: Search lens  
**Key Settings**: None (integrates with scrollbar)

---

## HTML/JSX

### AutoTag

**File**: `tools/autotag.lua`  
**Repository**: [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)  
**Description**: Auto-close tags  
**Key Settings**: None

---

## TODO Comments

### Todo Comments

**File**: `tools/todo-comments.lua`  
**Repository**: [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)  
**Description**: Highlight TODO/FIXME comments  

| Keys | Action |
|------|--------|
| `]t` | Next todo |
| `[t` | Prev todo |
| `<leader>ft` | Search todos |

---

## Auto-Indent

### Sleuth

**File**: `tools/sleuth.lua`  
**Repository**: [tpope/vim-sleuth](https://github.com/tpope/vim-sleuth)  
**Description**: Auto-indent detection  
**Key Settings**: None

---

## GDB Integration

### GDB

**File**: `tools/gdb.lua`  
**Repository**: [sukcesang/gdb-dap](https://github.com/sukcesang/gdb-dap) (or similar)  
**Description**: GDB DAP integration  
**Key Settings**: None