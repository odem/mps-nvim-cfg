# Appearance Plugins

UI and appearance plugins from `lua/appearance/`.

---

## Colorschemes

### Tokyo Night

**File**: `appearance/tokyonight.lua`  
**Repository**: [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)  
**Description**: Primary colorscheme (loaded at priority 1000)  
**Keybinds**: None (colorscheme switch via keymaps)

### Gruvbox

**File**: `appearance/gruvbox.lua`  
**Repository**: [morhetz/gruvbox](https://github.com/morhetz/gruvbox)  
**Description**: Alternative warm colorscheme  
**Keybinds**: None

---

## Git Integration

### Git Signs

**File**: `appearance/gitsigns.lua`  
**Repository**: [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)  
**Description**: Git hunk decorations + navigation  
**Key Settings**:
- Signs: `│` (add/change), `_` (delete), `‾` (topdelete), `~` (changedelete), `┆` (untracked)
- Signcolumn enabled, linehl disabled

| Keys | Action |
|------|--------|
| `]c` | Next hunk |
| `[c` | Prev hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghS` | Stage buffer |
| `<leader>ghu` | Undo stage hunk |
| `<leader>ghR` | Reset buffer |
| `<leader>ghp` | Preview hunk |
| `<leader>ghb` | Blame line |
| `<leader>ghd` | Diff this |
| `<leader>ghD` | Diff this ~ |
| `<leader>ghw` | Toggle words |

---

## UI Enhancements

### Colorizer

**File**: `appearance/colorizer.lua`  
**Repository**: [NvChad/nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)  
**Description**: Color code highlighting (`#RGB`, `rgb()`)  
**Keybinds**: None (automatic)

### Windows

**File**: `appearance/windows.lua`  
**Repository**: [anuvyklack/windows.nvim](https://github.com/anuvyklack/windows.nvim)  
**Description**: Window management enhancements  
**Keybinds**: None

### Yank Highlight

**File**: `appearance/yank-highlight.lua`  
**Repository**: [AckslD/nvim-FeMaco.lua](https://github.com/AckslD/nvim-FeMaco.lua) (or built-in)  
**Description**: Highlight yanked text  
**Keybinds**: None (automatic)

---

## Statusline & Tabline

### Lualine

**File**: `appearance/lualine.lua`  
**Repository**: [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)  
**Description**: Status line  
**Keybinds**: None

### Bufferline

**File**: `appearance/bufferline.lua`  
**Repository**: [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)  
**Description**: Buffer tabline  
**Keybinds**: None

### Scrollbar

**File**: `appearance/scrollbar.lua`  
**Repository**: [petertriho/nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar)  
**Description**: Scrollbar with hlslens integration  
**Keybinds**: None

---

## Indentation & Separators

### Indent Blankline

**File**: `appearance/indent-blankline.lua`  
**Repository**: [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)  
**Description**: Indent guides  
**Keybinds**: None

### Colorful Winsep

**File**: `appearance/colorful-winsep.lua`  
**Repository**: [yorickpeterse/nvim-window](https://github.com/yorickpeterse/nvim-window) (or similar)  
**Description**: Window separator colors  
**Keybinds**: None

---

## Navigation & UI

### Barbecue

**File**: `appearance/barbecue.lua`  
**Repository**: [utilyre/barbecue.nvim](https://github.com/utilyre/barbecue.nvim)  
**Description**: Breadcrumb navigation  
**Keybinds**: None (automatic)

### Alpha

**File**: `appearance/alpha.lua`  
**Repository**: [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)  
**Description**: Startup screen  
**Keybinds**: None

### Symbols Outline

**File**: `appearance/symbols-outline.lua`  
**Repository**: [simrat39/symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)  
**Description**: Symbol outline view  
**Keybinds**: None