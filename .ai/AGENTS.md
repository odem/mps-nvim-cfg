# Neovim Configuration Agent Guidance

**This file contains ALL mandatory rules, design specifications, and implementation guidelines for AI agents working on the `nvim-dev` configuration. Agents MUST read and follow these guidelines without exception.**

## Overview

`nvim-dev` is a lightweight, fast Neovim 0.12+ configuration built on native APIs with a focus on Python development. The configuration follows strict design principles to maintain performance, modularity, and simplicity.

---

## 1. Mandatory Agent Rules (Axioms)

**These rules are NON-NEGOTIABLE. Every agent MUST follow them without exception.**

### 1.1 Response Language
- **Always respond in English**, regardless of the language the user writes in
- Never switch to another language unless explicitly asked
- This rule ensures consistent communication and documentation

### 1.2 Lightweight & Fast Principle
- Every change must keep the configuration lightweight and fast
- **Prefer Neovim built-ins over plugins** when possible
- **Avoid redundant options** that match Neovim or plugin defaults
- **Warn before introducing** anything heavy or non-standard

### 1.3 Axiom Violation Warnings
- If any proposed change or existing code violates an axiom, the agent **MUST warn the user before proceeding**
- This includes violations in code being reviewed, modified, or added

### 1.4 Helpers Pattern
- Self-written utility modules belong in `lua/helpers/`
- **Never put them in `lua/common/`, inline in plugin specs, or at the top-level `lua/` directory**
- Each helper module should be a focused function module

### 1.5 Fail-Safe Practices
- Wrap operations that can fail in `pcall`:
  - `vim.fn.mkdir`
  - `vim.api.nvim_del_keymap`
  - `vim.cmd('colorscheme ...')`
  - `:MasonInstall`
  - `require('telescope').load_extension`
- This prevents configuration failures from breaking startup

### 1.6 Non-Blocking Startup
- Use `vim.schedule` for deferred startup tasks
- **Never block `init.lua` with synchronous installs** (e.g., Mason auto-install)
- Example: Mason auto-install of missing servers uses `vim.schedule`

### 1.7 Cache Requires Pattern
- When a helper module is called from keymaps, require it **once in a local at the top of the file**
- **Never `require()` the same module on every keystroke**
- Example: `local smart_delete = require('helpers.smart_delete')` at the top of `keymaps.lua`

### 1.8 Plugin Specs Structure
- **Organized by functionality** across multiple directories:
  - `lua/core/` - Core functionality plugins (LSP, completion, treesitter, etc.)
  - `lua/appearance/` - UI and appearance plugins (themes, statusline, window decorations)
  - `lua/navigation/` - Navigation plugins (file explorer, buffer switching, project management)
  - `lua/tools/` - Tool plugins (git, terminal, debugging, utilities)
  - `lua/debugging/` - Debugging and DAP plugins
- **One file per plugin** in the appropriate directory
- Inline specs in `lazy.lua` only for trivial cases (single line, no config)
- Each plugin file should follow the naming convention: `plugin_name.lua`
- **New plugins from migration (2024-05-17)** should follow this structure

### 1.9 Strip Defaults When Porting
- When porting plugin config from an old configuration, **compare every option against the plugin's current defaults**
- **Remove anything that matches** — only keep non-default customizations
- This prevents maintaining redundant configuration

### 1.10 Keybind `desc` Convention
- All `desc` values use `[CATEGORY] comment` format
- Category indicates plugin/functionality group (e.g., `[Telescope]`, `[LSP]`, `[Debug]`)
- Brackets around individual key letters are removed from comments
- Example formatting:
  - `'[Telescope] telescope keymaps'` (formerly `'[t]elescope [k]eymaps'`)
  - `'[LSP] go to definition'` (formerly `'[g]o to definition'`)
  - `'[Debug] Start/Continue'` (formerly `'[F9] Start/Continue'`)

### 1.11 Native LSP Usage
- **Use `vim.lsp.config` + `vim.lsp.enable`** exclusively for server configuration
- **Never use `lspconfig.setup` or `lspconfig.util`** for server setup
- Note: `neovim/nvim-lspconfig` is only installed as a transitive dependency of neoconf

---

## 2. Technology Stack

### Core Stack
- **Plugin manager:** lazy.nvim
- **LSP API:** nvim built-in `vim.lsp.config` + `vim.lsp.enable` (0.11+)
- **Server installer:** mason.nvim (via `vim.schedule` auto-install, no mason-lspconfig)
- **Completion:** blink.cmp (LSP + path + snippets + buffer sources, LuaSnip backend)
- **Syntax:** nvim-treesitter (Python + Lua parsers)
- **Colorscheme:** tokyonight.nvim (folke/tokyonight.nvim, loaded via `pcall`)
- **Lua development:** lazydev.nvim (auto-completion for nvim API in Lua files)
- **Per-project config:** neoconf.nvim (`.neoconf.json` LSP overrides)

### LSP Servers
- **Ruff:** Formatting, linting, imports for Python
- **Pyright:** Type checking for Python
- **Lua Language Server:** Lua configuration files

### Diagnostics & UI
- **Diagnostics UI:** Built-in `vim.diagnostic`
- **File explorer:** neo-tree.nvim (filesystem + buffers + git_status)
- **Buffer picker:** snipe.nvim (hint-based buffer switching)
- **Undo history:** undotree (visual undo tree)
- **Quick navigation:** harpoon (file marks + fast switching)
- **File manager:** yazi.nvim (terminal file manager, `<A-y>`)
- **Directory editor:** oil.nvim (edit directories as buffers, `-` to open)
- **Fuzzy finder:** telescope.nvim (files, grep, buffers, help) + fzf-native
- **Keymap helper:** which-key.nvim (popup for `<leader>` and `<g>` prefixes)
- **Bookmarks:** TODO — planned for separate phase

---

## 3. Project Structure

### File Layout
```
~/.config/nvim-dev/
├── init.lua                  # Entry point (7 lines of requires)
├── README.md                 # Project overview, design principles, load order
├── README-CORE.md            # Per-plugin configuration documentation
├── README-HELPERS.md         # Utility module documentation
├── README-KEYBINDS.md        # Complete keybind reference
│
├── .ai/AGENTS.md            # This file (agent guidance consolidation)
├── .todo/                    # Implementation plan files
│   └── 2024-05-16-update-keybind-comments.md
│
└── lua/
    ├── options.lua           # vim.opt, vim.g.loaded overrides
    ├── keymaps.lua           # Global keybindings (~95 total)
    │
    ├── helpers/              # Utility modules
    │   ├── quickfix.lua         # Toggle qf window
    │   ├── smart_delete.lua     # WORD-aware backspace/delete
    │   ├── telescope-custom.lua # find_files at fixed cwds
    │   └── themes.lua           # Protected setColorScheme()
    │
    ├── core/                 # Core plugin specs
    │   ├── lazy.lua          # lazy.nvim bootstrap + spec aggregator
    │   ├── lsp.lua           # Native LSP config for ruff, pyright, lua_ls
    │   ├── mason.lua         # mason.nvim spec
    │   ├── completion.lua    # blink.cmp + LuaSnip
    │   ├── luasnip.lua       # Custom snippets (python, rest)
    │   ├── treesitter.lua    # nvim-treesitter spec
    │   ├── neo-tree.lua      # Neo-tree.nvim spec (file explorer)
    │   ├── lazydev.lua       # lazydev.nvim spec (nvim API completions)
    │   ├── neoconf.lua       # neoconf.nvim spec (per-project config)
    │   ├── snipe.lua         # snipe.nvim spec (buffer picker)
    │   ├── undotree.lua      # undotree spec (visual undo tree)
    │   ├── harpoon.lua       # harpoon spec (quick file marks)
    │   ├── yazi.lua          # yazi.nvim spec (terminal file manager)
    │   ├── oil.lua           # oil.nvim spec (directory buffer editor)
    │   ├── telescope.lua     # telescope.nvim spec (fuzzy finder)
    │   ├── which-key.lua     # which-key.nvim spec (keymap popup)
    │   └── tokyonight.lua    # Colorscheme via helpers.themes
    │
    ├── navigation/           # Navigation plugins
    │   ├── flash.lua         # Flash.nvim spec
    │   ├── harpoon.lua       # harpoon spec (mirrors core location)
    │   ├── oil.lua           # oil.nvim spec (mirrors core location)
    │   ├── yazi.lua          # yazi.nvim spec (mirrors core location)
    │   └── neo-tree.lua      # neo-tree.nvim spec (mirrors core location)
    │
    ├── tools/                # Development tools
    │   ├── dadbod.lua        # dadbod.nvim spec (database viewer)
    │   ├── overseer.lua      # overseer.nvim spec (task runner)
    │   ├── rest-console.lua  # rest.nvim spec
    │   └── toggleterm.lua    # toggleterm.nvim spec
    │
    ├── debugging/            # Debugging tools
    │   └── core.lua          # dap + dap-ui + dap-virtual-text config
    │
    └── appearance/           # UI/Appearance plugins
        └── symbols-outline.lua # symbols-outline.nvim spec
```

### Load Order
```
init.lua
├── options.lua              # vim.opt, disabled built-ins, providers
├── keymaps.lua              # global keybindings
└── core.lazy                # lazy.nvim bootstrap → loads all plugin specs
    └── core.lsp             # native LSP config (runs after lazy set-up)
```

---

## 4. Implementation Guidelines

### 4.1 Lua/Neovim Specifics

#### Code Organization
- Core plugin configurations live in `lua/core/` (loaded via lazy.nvim)
- Additional plugin configurations are organized by category in subdirectories:
  - `lua/navigation/` - Navigation plugins
  - `lua/tools/` - Development tools
  - `lua/debugging/` - Debugging tools
  - `lua/appearance/` - UI/Appearance plugins
- Utility modules go in `lua/helpers/`
- Global configuration in `options.lua`
- Global keybindings in `keymaps.lua` (95 total keybinds across all files)

#### Default Configuration Removal
- When porting configuration from old setups, **compare every option against plugin defaults**
- Remove options that match defaults to maintain minimal configuration
- Only keep non-default customizations

#### Error Handling
- Use `pcall()` for operations that might fail
- Colorscheme loading: `pcall(vim.cmd, 'colorscheme tokyonight')`
- Extension loading: `pcall(require('telescope').load_extension, '...')`

### 4.2 Plugin Configuration Patterns

#### Lazy.nvim Specs
- Plugin specs are loaded from `lua/core/` files via `require()` in `lazy.lua`
- Each spec file returns a table with plugin configuration
- Example structure:
```lua
return {
  'plugin/name',
  config = function()
    -- plugin configuration
  end,
  keys = {
    -- keybindings
  },
}
```

#### Mason Configuration
- Auto-install deferred via `vim.schedule`:
```lua
vim.schedule(function()
  local servers = {
    { bin = 'ruff', mason = 'ruff' },
    -- ...
  }
  for _, s in ipairs(servers) do
    if vim.fn.executable(s.bin) ~= 1 then
      vim.cmd('MasonInstall ' .. s.mason)
    end
  end
end)
```

### 4.3 Keybinding Conventions

#### Global Keymaps (`keymaps.lua`)
- Grouped by category: escape/mode, window nav, save/source/quit, search, splits, buffers, etc.
- Helper modules (`quickfix`, `smart_delete`) loaded locally at the top
- Use `vim.keymap.set` with descriptive `desc` values

#### `desc` Format
- **Category prefix format**: `[CATEGORY] comment text`
- **Category determination**:
  - Debugging/DAP: `[Debug]`
  - Rest Console: `[Rest]`
  - LSP actions: `[LSP]`
  - Telescope: `[Telescope]`
  - Overseer: `[Overseer]`
  - **New Migration Categories (2024-05-17)**:
    - Git operations: `[Git]` (gitsigns, fugitive, rhubarb, lazygit)
    - Color highlighting: `[Colorizer]`
    - Window management: `[Window]`
    - Yank highlighting: `[Yank]`
    - Auto-pairing: `[Edit]`
    - LSP progress: `[LSP]` (fidget.nvim shares with LSP)
    - Enhanced search: `[Search]`
    - HTML/JSX autotagging: `[HTML]`
    - TODO comment highlighting: `[Todo]`
    - Project management: `[Project]`
    - Auto-indent detection: `[Indent]`
    - Snippet expansion: `[Snippet]`
    - Regex syntax highlighting: `[Syntax]`
    - Colorscheme switching: `[Theme]`
  - Other plugins: Use plugin name (e.g., `[Flash]`, `[Harpoon]`, `[Oil]`, `[Dadbod]`, `[Toggleterm]`, `[Yazi]`, `[Luasnip]`, `[Undotree]`, `[Symbols Outline]`)
- **Space after bracket**: Always one space between `]` and comment
- **Special characters preserved**: `/`, `-`, `()` etc. from original comments
- **Duplicate handling**: Add "(alt)" suffix for duplicate Telescope LSP keybinds
- **Examples**:
  - `'[Telescope] telescope keymaps'` (formerly `'[t]elescope [k]eymaps'`)
  - `'[LSP] go to definition'` (formerly `'[g]o to definition'`)
  - `'[Debug] Start/Continue'` (formerly `'[F9] Start/Continue'`)
  - **New Examples**:
    - `'[Git] go to previous hunk'`
    - `'[Window] maximize horizontally'`
    - `'[Todo] search TODO comments'`
    - `'[Project] switch project'`

#### LSP Keymap Prefixes
- Use `g{action}` prefix convention for LSP actions
- Examples: `gD` (declaration), `gh` (hover), `gca` (code action)

---

## 5. LSP Configuration

### 5.1 Native LSP Approach
- **No `lspconfig`** — servers defined via `vim.lsp.config` directly
- `lspconfig` is installed as a transitive dependency of neoconf, but **NEVER called for server setup**
- Server configuration uses native APIs:
```lua
vim.lsp.config.ruff = {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  -- ...
}
vim.lsp.enable('ruff')
```

### 5.2 Server Configuration

#### Ruff (Python)
- Formatting + linting + imports
- Settings: `lineLength = 88`, `lint = { extendSelect = { 'I' } }`

#### Pyright (Python)
- Type checking only
- Settings: `typeCheckingMode = 'basic'`, `diagnosticMode = 'openFilesOnly'`

#### Lua Language Server
- Lua configuration files
- Runtime: `LuaJIT`
- Workspace includes Neovim runtime files

### 5.3 LSP Keymaps

#### Native LSP (`lua/core/lsp.lua`)
- `gD` → Declaration
- `gh` / `gk` → Hover
- `gsh` / `gK` → Signature help
- `gca` → Code action
- `gn` → Rename
- `gtf` → Format
- `[d` / `]d` → Diagnostic prev/next

#### Telescope LSP Pickers (`lua/helpers/telescope-custom.lua`)
- `gd` → Telescope LSP definitions (`nowait = true`)
- `gr` → Telescope LSP references (`nowait = true`)

### 5.4 Diagnostics & UI
- Diagnostic signs: ✘ (error), ▲ (warn), ℹ (info), ⚑ (hint)
- Inlay hints enabled globally: `vim.lsp.inlay_hint.enable(true)`
- Auto-attach keymaps via `LspAttach` autocmd

---

## 6. Helper Modules (`lua/helpers/`)

### Purpose
Self-written utility modules shared across the configuration. Each is a focused function module, not a plugin spec.

### 6.1 quickfix.lua
- **Purpose**: Toggle the quickfix list window open/closed
- **Logic**: Scans all open windows for `buftype = 'quickfix'`, closes if found, opens if not
- **Use**: Called by `<A-q>` in `keymaps.lua`

### 6.2 smart_delete.lua
- **Purpose**: Conditional delete-left and delete-right using WORD-aware logic
- **Logic**: Context-aware cut/delete preserving yank register
- **Use**: `x`, `XX`, `dd`, `dw` smart behavior

### 6.3 telescope-custom.lua
- **Purpose**: Telescope extension configurations
- **Includes**: `gd` (definitions), `gr` (references), `gr` cleanup
- **Use**: Custom find_files at fixed working directories

### 6.4 themes.lua
- **Purpose**: Colorscheme application with `pcall` fallback
- **Function**: `try_colorscheme()` protected wrapper
- **Use**: Safely apply colorschemes without breaking startup

---

## 7. Plugin-Specific Details

### 7.1 File Explorer (`neo-tree.nvim`)
- **Sources**: filesystem, buffers, git_status
- **Behavior**: Follows current file, libuv file watcher for live updates
- **Keymaps**: `<A-e>` → toggle, `<A-E>` → reveal current file

### 7.2 Buffer Picker (`snipe.nvim`)
- **Approach**: Hint-based buffer switching (no telescope needed)
- **Keymaps**: `<A-s>` → open buffer list
- **Navigation**: `J`/`K` → page through buffers, `<cr>` to select, `<esc>` to cancel

### 7.3 Directory Editor (`oil.nvim`)
- **Purpose**: Edit directories as buffers
- **Keymap**: `-` to open current directory
- **Configuration**: Stripped defaults, minimal setup

### 7.4 Fuzzy Finder (`telescope.nvim`)
- **Configuration**: Slimmed defaults, custom layout
- **Extensions**: `telescope-custom.lua` for LSP pickers
- **Optimization**: `fzf-native` for faster searching

---

## 8. Development Workflow

### 8.1 Adding New Languages
1. **Add server to auto-install list** in `lua/core/lsp.lua` (`vim.schedule` loop with `vim.fn.executable` check)
2. **Add `vim.lsp.config.<name>` + `vim.lsp.enable('<name>')`** in `lua/core/lsp.lua`
3. **Add parser** to treesitter `ensure_installed` in `lua/core/treesitter.lua`

### 8.2 Porting from Old Configs
1. **Compare every option** against plugin's current defaults
2. **Strip matching defaults** — keep only non-default customizations
3. **Place in correct location**: plugin specs in `lua/core/`, helpers in `lua/helpers/`
4. **Add fail-safe wrappers** (`pcall`) where needed

### 8.3 Adding New Plugins
1. **Create spec file** in `lua/core/` (e.g., `core/new_plugin.lua`)
2. **Add require** to `lua/core/lazy.lua` spec list
3. **Configure** with minimal options, stripping defaults
4. **Add keybindings** with proper `desc` format
5. **Test startup time** impact

### 8.4 Performance Considerations
- **Monitor startup time** after changes
- **Prefer built-ins** over plugins
- **Use lazy loading** (`keys`, `cmd`, `ft` triggers)
- **Avoid blocking operations** in `init.lua` or plugin configs

---

## 9. Verification & Quality Checks

### 9.1 Code Quality
- **Follow Lua style conventions** (consistent indentation, naming)
- **Use descriptive variable names**
- **Add comments** for non-obvious logic
- **Keep functions focused** and single-purpose

### 9.2 Configuration Health
- **Test startup** after significant changes
- **Verify LSP servers** connect and function
- **Check keybindings** work as expected
- **Ensure no Lua errors** on startup

### 9.3 Documentation Updates
- **Update README files** when changing user-facing behavior
- **Keep AGENTS.md current** with any new patterns or rules
- **Document non-obvious decisions** in code comments

### 9.4 Testing Changes
1. **Backup** before making significant changes
2. **Test incrementally** — make one change at a time
3. **Verify** all affected functionality
4. **Document** changes in commit messages

---

## 10. Common Tasks & Examples

### 10.1 Adding a New LSP Server
```lua
-- In lua/core/lsp.lua

-- 1. Add to auto-install list
vim.schedule(function()
  local servers = {
    { bin = 'ruff', mason = 'ruff' },
    { bin = 'pyright-langserver', mason = 'pyright' },
    { bin = 'lua-language-server', mason = 'lua-language-server' },
    -- NEW: Add your server
    { bin = 'typescript-language-server', mason = 'typescript-language-server' },
  }
  -- ... rest of auto-install logic
end)

-- 2. Add server configuration
vim.lsp.config.tsserver = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  settings = {
    typescript = {
      -- Your custom settings
    },
  },
}
vim.lsp.enable('tsserver')
```

### 10.2 Creating a New Helper Module
```lua
-- In lua/helpers/new_helper.lua
local M = {}

function M.some_function()
  -- Implementation with pcall for safety
  local ok, result = pcall(some_operation)
  if not ok then
    vim.notify("Helper failed: " .. result, vim.log.levels.WARN)
    return nil
  end
  return result
end

return M

-- In keymaps.lua (at the top)
local new_helper = require('helpers.new_helper')

-- Usage in keymap
map('n', '<leader>nh', function() new_helper.some_function() end, { desc = '[Helper] new helper action' })
```

### 10.3 Adding a Plugin with Lazy Loading
```lua
-- In lua/core/new_plugin.lua
return {
  'author/new-plugin',
  config = function()
    require('new-plugin').setup({
      -- Only non-default options
      option1 = 'custom',
      option2 = true,
    })
  end,
  keys = {
    { '<leader>np', '<cmd>NewPluginCommand<CR>', desc = '[New Plugin] command' },
  },
  event = 'VeryLazy', -- Or specific triggers
}

-- In lua/core/lazy.lua
require('lazy').setup({
  spec = {
    -- ... existing specs
    require('core.new_plugin'),
    -- ... more specs
```
```

---
## 11. Plugin Migration Guidelines (2024-05-17)

### Migration Context
A major plugin migration is underway from an old Neovim configuration (`~/.config/nvim`) to `nvim-dev`. The migration follows strict principles to maintain architecture integrity.

### 11.1 Migration Principles
1. **Built-in First**: Skip plugins that duplicate built-in Neovim functionality
2. **No Duplicates**: Keep existing nvim-dev plugins, don't add alternatives
3. **Architecture Preservation**: Maintain Neovim 12 API, keep current `blink.cmp`
4. **Category Format**: All new keybinds use `[CATEGORY] Comment` format

### 11.2 Plugins Being Migrated (16 total)
**Phase 1: mps-ui Essentials**
- `gitsigns.lua` → `appearance/gitsigns.lua` (`[Git]`)
- `colorizer.lua` → `appearance/colorizer.lua` (`[Colorizer]`)
- `windows.lua` → `appearance/windows.lua` (`[Window]`)

**Phase 2: Git Ecosystem** → Combined `tools/git.lua` (`[Git]`)
- `vim-fugitive` + `vim-rhubarb` + `lazygit.nvim`

**Phase 3: Editing Core**
- `autopairs.lua` → `core/autopairs.lua` (`[Edit]`)

**Phase 4: Development Tools**
- `fidget.lua` → `core/fidget.lua` (`[LSP]`)
- `hlslens.lua` → `tools/hlslens.lua` (`[Search]`)
- `autotag.lua` → `tools/autotag.lua` (`[HTML]`)
- `todo-comments.lua` → `tools/todo-comments.lua` (`[Todo]`)

**Phase 5: Quality of Life**
- `project.lua` → `navigation/project.lua` (`[Project]`)
- `sleuth.lua` → `tools/sleuth.lua` (`[Indent]`)
- **Modify** `core/luasnip.lua` to add `friendly-snippets` (`[Snippet]`)
- `treesitter-regex.lua` → `tools/treesitter-regex.lua` (`[Syntax]`)

**Phase 6: Colorscheme + Built-in**
- `gruvbox.lua` → `appearance/gruvbox.lua` (`[Theme]`)
- `yank-highlight.lua` → `appearance/yank-highlight.lua` (`[Yank]`, built-in)

### 11.3 Skipped Plugins (Built-in or Duplicate)
- **Built-in**: `Comment.nvim`, `nvim-surround`, `neoformat`
- **Duplicates**: `vim-airline` (use `lualine`), `nerdtree`/`nvim-tree` (use `neo-tree`)
- **CMP ecosystem**: Skip all `nvim-cmp` plugins (use `blink.cmp`)
- **Mason integration**: Skip `mason-lspconfig.nvim` (keep current Neovim 12 API)

### 11.4 Configuration Patterns for Migration
```lua
-- Error handling pattern for migrated plugins
config = function()
  local ok, plugin = pcall(require, 'plugin-name')
  if not ok then
    vim.notify('plugin-name not available', vim.log.levels.WARN)
    return
  end
  plugin.setup({
    -- Only non-default options after comparing with defaults
  })
end
```

### 11.5 Verification Requirements
After migrating each plugin:
1. ✅ Syntax: `nvim --headless -c "q"`
2. ✅ Loading: `:Lazy` shows plugin installed
3. ✅ Categories: Keybinds use `[CATEGORY] Comment` format
4. ✅ Integration: Works with existing plugins (scrollbar-hlslens, git tools)
5. ✅ No regressions: Existing functionality unchanged

### 11.6 Migration Todo File
Complete migration plan in: `.todo/2024-05-17-migrate-plugins.md`
- 7 phases, 16 plugins, 16+ file changes
- Risk assessment (low/medium/high)
- Rollback strategy with phase-based commits
- Integration verification checklist

---
## 12. Bookmarks & TODO Items

### Known TODO Items
- **Bookmarks plugin**: Planned for separate phase
- **Reserved keymap**: `<leader>eb` currently commented out in `keymaps.lua:92`
- **Expand language support**: Based on user needs beyond Python/Lua

### Reserved Keymaps
- `<leader>eb`: Reserved for future bookmarks functionality
- Check `keymaps.lua` for commented-out or TODO keybindings

---

## 13. Violation Handling

### 12.1 Agent Responsibility
When encountering a violation (in proposed changes or existing code):
1. **Identify** the specific axiom being violated
2. **Explain** why it's a violation
3. **Suggest** the correct approach
4. **Ask for confirmation** before proceeding

### 12.2 Common Violation Examples
- **Adding redundant defaults**: Warn and suggest removal
- **Blocking startup operations**: Convert to `vim.schedule`
- **Missing `pcall` wrappers**: Add fail-safe protection
- **Incorrect file location**: Move to proper directory
- **Poor `desc` formatting**: Correct to `[CATEGORY] comment` format

---

**Last Updated**: 2026-05-16  
**Updated to match**: `.todo/2024-05-16-update-keybind-comments.md` (keybind format changes)  
**Source Files Consolidated**: `docs/agent_axioms.md`, `docs/superpowers/specs/2026-05-16-nvim-python-config-design.md`  
**Purpose**: Single source of truth for AI agents working on `nvim-dev` configuration  
**Key Change**: Keybind `desc` format changed from `[letter] notation` to `[CATEGORY] comment`

---

*Agents MUST reference this file before making any changes to the configuration.*  
*All rules in this document are MANDATORY and NON-NEGOTIABLE.*