# Debugging Tools

Debugging plugins from `lua/debugging/`.

---

## Debug Adapter Protocol

### Core DAP

**File**: `debugging/core.lua`  
**Repository**: [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)  
**Description**: Core DAP implementation  
**Key Settings**: None

### DAP UI

**File**: `debugging/core.lua` (part of)  
**Repository**: [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)  
**Description**: DAP UI  
**Key Settings**: None

### Python Debug

**File**: `debugging/core.lua` (part of)  
**Repository**: [mfussenegger/nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)  
**Description**: Python debug adapter  
**Key Settings**: None

### Persistent Breakpoints

**File**: `debugging/core.lua` (part of)  
**Repository**: [linux-cultist/venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim) (or similar)  
**Description**: Breakpoint persistence  
**Key Settings**: None

---

## Keybinds

| Keys | Action |
|------|--------|
| `<F9>` | Start/Continue |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Terminate |
| `mm` | Toggle breakpoint |
| `<leader>bb` | List breakpoints |
| `<leader>bc` | Clear breakpoints |
| `<leader>bo` | Toggle breakpoint options |