# Navigation Plugins

Navigation plugins from `lua/navigation/`.

---

## File Explorer

### Neo-tree

**File**: `navigation/neo-tree.lua`  
**Repository**: [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)  
**Description**: File tree with filesystem, buffers, and git_status sources  
**Key Settings**:
- Sources: filesystem, buffers, git_status
- Follow current file enabled
- Libuv file watcher enabled

| Keys | Action |
|------|--------|
| `<A-e>` | Toggle neo-tree |
| `<A-E>` | Reveal current file |

---

## Directory Editing

### Oil

**File**: `navigation/oil.lua`  
**Repository**: [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim)  
**Description**: Edit directories as buffers  
**Key Settings**: Minimal stripped config

| Keys | Action |
|------|--------|
| `-` | Open current directory |

---

## Terminal File Manager

### Yazi

**File**: `navigation/yazi.lua`  
**Repository**: [mikavilasi/yazi-nvim](https://github.com/mikavilasi/yazi-nvim)  
**Description**: Terminal file manager integration  
**Key Settings**: None

| Keys | Action |
|------|--------|
| `<A-y>` | Open yazi |

---

## Quick Navigation

### Harpoon

**File**: `navigation/harpoon.lua`  
**Repository**: [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)  
**Description**: File marks for quick switching  
**Key Settings**: None

| Keys | Action |
|------|--------|
| `hx` | Open harpoon menu |
| `hm` | Mark file |
| `hn` | Next mark |
| `hp` | Prev mark |
| `h1` - `h5` | Jump to mark 1-5 |

---

## Buffer Picker

### Snipe

**File**: `navigation/snipe.lua`  
**Repository**: [LewisLiu1/snipe.nvim](https://github.com/LewisLiu1/snipe.nvim)  
**Description**: Hint-based buffer switching  
**Key Settings**: None

| Keys | Action |
|------|--------|
| `<A-s>` | Open buffer list |

---

## Motion Search

### Flash

**File**: `navigation/flash.lua`  
**Repository**: [folke/flash.nvim](https://github.com/folke/flash.nvim)  
**Description**: Enhanced motion search  
**Key Settings**: None

| Keys | Action |
|------|--------|
| `s` | Search (motion) |