# Plugin Migration Plan: Old Config → nvim-dev

**Date**: 2024-05-17  
**Created By**: Analysis of old config (`~/.config/nvim`) vs current nvim-dev  
**Priority**: High  
**Estimated Files**: 16+ changes across 7 phases

## Executive Summary
Migrate 16 plugins from old config to nvim-dev, skipping duplicates and built-in alternatives. Preserve current nvim-dev architecture (Neovim 12 API) and follow built-in-first principle.

## Core Principles
1. **Built-in First**: Skip plugins that duplicate built-in Neovim functionality
2. **No Duplicates**: Keep existing nvim-dev plugins, don't add alternatives
3. **Category Format**: All new keybinds use `[CATEGORY] Comment` format
4. **Architecture Preservation**: Maintain nvim-dev's Neovim 12 API architecture
5. **Error Handling**: Use `pcall` for graceful plugin loading failures

## Execution Framework

### Configuration Pattern (Follow nvim-dev style)
```lua
return {
  'author/plugin-name',
  version = '*',
  dependencies = { 'dep1', 'dep2' },
  opts = {
    -- Plugin configuration
  },
  config = function(_, opts)
    local ok, plugin = pcall(require, 'plugin-name')
    if not ok then return end
    plugin.setup(opts)
  end,
}
```

### Error Handling Pattern
```lua
config = function()
  local ok, plugin = pcall(require, 'plugin-name')
  if not ok then
    vim.notify('plugin-name not available', vim.log.levels.WARN)
    return
  end
  plugin.setup({ ... })
end
```

### Validation Checklist (After Each Phase)
1. ✅ Lua syntax: `nvim --headless -c "q"`
2. ✅ Plugin loads: `:Lazy` shows plugin installed
3. ✅ No keybind conflicts with existing `[CATEGORY]` keybinds
4. ✅ Category format correct: `[CATEGORY] Comment`

### Backup Strategy
- Commit before starting: `git add . && git commit -m "pre-migration backup"`
- Commit after each successful phase
- Rollback available for each phase

## Phase 1: mps-ui Essentials (3 files)

### 1.1 `gitsigns` → `lua/appearance/gitsigns.lua`
**Source**: `~/.config/nvim/lua/mps-ui/gitsigns/gitsigns-repo.lua`
**Keybind Category**: `[Git]`
**Features**: Git sidebar decorations, hunk navigation
**Migration Notes**:
- Use latest version (not legacy)
- Update keybind categories to `[Git]`
- Verify integration with existing Git tools

### 1.2 `colorizer` → `lua/appearance/colorizer.lua`
**Source**: `~/.config/nvim/lua/mps-ui/colorizer/colorizer-config.lua`
**Keybind Category**: `[Colorizer]`
**Features**: Color code highlighting in CSS, HTML, etc.
**Migration Notes**:
- Simple setup: `require("colorizer").setup()`
- No keybinds needed (just highlighting)

### 1.3 `windows.nvim` → `lua/appearance/windows.lua`
**Source**: `~/.config/nvim/lua/mps-ui/windows/`
**Keybind Category**: `[Window]`
**Features**: Enhanced window management (maximize/equalize)
**Keybinds to Migrate**: `<C-w>z`, `<C-w>_`, `<C-w>|`, `<C-w>=`, `ß`, `?`, `\`
**Migration Notes**:
- Keep existing keybinds from old config
- Create consistent pattern with existing window keybinds
- Update keybind comments to `[Window]` format

**Phase 1 Verification**:
- All 3 files have proper plugin spec structure
- Keybinds have `[CATEGORY]` format
- No syntax errors in Lua files

## Phase 2: Git Ecosystem (Combined into 1 file)

### 2.1 Combined `git.lua` → `lua/tools/git.lua`
**Source Plugins**:
- `vim-fugitive` - Git wrapper
- `vim-rhubarb` - GitHub extension (requires fugitive)
- `lazygit.nvim` - Terminal UI for git

**Keybind Category**: `[Git]` for all
**Migration Strategy**:
- Combine all 3 git plugins into single `git.lua`
- Ensure proper dependencies (rhubarb needs fugitive)
- Integrate with existing `gitsigns` from Phase 1

**Phase 2 Verification**:
- Single `git.lua` file with all 3 plugins
- Dependencies configured correctly
- All git functionality works together

## Phase 3: Editing Core (1 file)

### 3.1 `nvim-autopairs` → `lua/core/autopairs.lua`
**Keybind Category**: `[Edit]`
**Features**: Auto-pair brackets, quotes, tags
**Migration Notes**:
- Skip `Comment.nvim` and `nvim-surround` (built-in sufficient)
- Verify no conflict with existing editing keybinds
- Use latest version

**Phase 3 Verification**:
- Auto-pairing works for brackets, quotes
- No interference with existing typing
- Category `[Edit]` if any keybinds added

## Phase 4: Development Tools (4 files)

### 4.1 `fidget.nvim` → `lua/core/fidget.lua`
**Keybind Category**: `[LSP]`
**Features**: LSP progress notifications
**Migration Notes**:
- Use **latest version** (not legacy tag)
- Configure minimal setup
- Integration with existing LSP config

### 4.2 `nvim-hlslens` → `lua/tools/hlslens.lua`
**Keybind Category**: `[Search]`
**Features**: Enhanced search highlighting
**Critical Integration**: Scrollbar expects this plugin (`scrollbar.lua:30-33`)
**Migration Notes**:
- Migrate **full config** from old config
- Ensure scrollbar integration works
- Update keybinds to `[Search]` category

### 4.3 `nvim-ts-autotag` → `lua/tools/autotag.lua`
**Keybind Category**: `[HTML]`
**Features**: Auto close/rename HTML/JSX/XML tags
**Requirements**: Verify `nvim-treesitter` is properly configured
**Migration Notes**:
- Conditional setup for HTML/JSX/XML filetypes
- Ensure treesitter dependencies satisfied
- Category `[HTML]` for web development focus

### 4.4 `todo-comments.nvim` → `lua/tools/todo-comments.lua`
**Keybind Category**: `[Todo]`
**Features**: Highlight TODO/FIXME comments, search and navigation
**Migration Notes**:
- Configure for common comment patterns
- Add search/navigation keybinds with `[Todo]` category

**Phase 4 Verification**:
- All 4 plugins load correctly
- Scrollbar-hlslens integration works
- Treesitter verified for autotag
- TODO comments highlighted properly

## Phase 5: Quality of Life (4 changes)

### 5.1 `project.nvim` → `lua/navigation/project.lua`
**Keybind Category**: `[Project]`
**Features**: Project management, root detection
**Migration Notes**:
- Configure for common project patterns
- Add project navigation keybinds

### 5.2 `vim-sleuth` → `lua/tools/sleuth.lua`
**Keybind Category**: `[Indent]`
**Features**: Auto detect indentation settings
**Migration Notes**:
- Heuristic-based indentation detection
- No keybinds needed (automatic)

### 5.3 `friendly-snippets` → **MODIFY** `lua/core/luasnip.lua`
**Keybind Category**: `[Snippet]` (extends existing)
**Features**: Collection of snippets for LuaSnip
**Migration Notes**:
- **Modify existing file** - add friendly-snippets dependency
- Lazy-load snippets from vscode format
- Extends existing LuaSnip configuration

### 5.4 `tree-sitter-regex` → `lua/tools/treesitter-regex.lua`
**Keybind Category**: `[Syntax]`
**Features**: Regex syntax highlighting
**Migration Notes**:
- Tree-sitter grammar for regex
- Syntax highlighting improvements

**Phase 5 Verification**:
- Project detection works
- Auto-indent detection functions
- LuaSnip loads friendly-snippets
- Regex syntax highlighting applied

## Phase 6: Colorscheme + Built-in (2 files)

### 6.1 `gruvbox.nvim` → `lua/appearance/gruvbox.lua`
**Keybind Category**: `[Theme]`
**Features**: Alternative colorscheme to tokyonight
**Migration Notes**:
- Keep as optional alternative theme
- Configure color palette
- Add theme switching if desired

### 6.2 `yank-highlight.lua` → `lua/appearance/yank-highlight.lua`
**Keybind Category**: `[Yank]`
**Features**: **BUILT-IN** yank highlighting with `vim.highlight.on_yank()`
**Migration Notes**:
- **Not a plugin** - implement as built-in feature
- Autocmd: `TextYankPost` event
- Temporary highlight on yank operations

**Phase 6 Verification**:
- Gruvbox colorscheme loads and applies
- Yank highlighting works on copy operations
- No plugin conflicts with tokyonight

## Phase 7: Config Comparisons & Final Verification (2 checks)

### 7.1 Colorful-winsep Config Merge
**Files to Compare**:
- Old: `~/.config/nvim/lua/mps-ui/colorful-winsep/colorful-winsep-config.lua`
- Current: `lua/appearance/colorful-winsep.lua`

**Action Required**:
- Compare configurations
- Merge useful settings from old config if missing
- Keep nvim-dev structure and patterns

### 7.2 Scrollbar-hlslens Integration Verification
**Critical Check**: Ensure scrollbar integration works
- Verify `scrollbar.lua:30-33` integration with hlslens
- Test search highlighting with scrollbar marks
- Confirm no regressions in scrollbar functionality

### 7.3 AGENTS.md Category Updates
**Update Required**: Add all new categories from this migration:
```markdown
[Git]           # Git operations (gitsigns, fugitive, rhubarb, lazygit)
[Colorizer]     # Color highlighting
[Window]        # Window management
[Yank]          # Yank highlighting (built-in)
[Edit]          # Auto-pairing
[LSP]           # LSP progress
[Search]        # Enhanced search
[HTML]          # HTML/JSX autotagging
[Todo]          # TODO comment highlighting
[Project]       # Project management
[Indent]        # Auto-indent detection
[Snippet]       # Snippet expansion
[Syntax]        # Regex syntax highlighting
[Theme]         # Colorscheme switching
```

**Phase 7 Verification**:
- Colorful-winsep config optimized
- Scrollbar-hlslens integration working
- AGENTS.md updated with all new categories

## Skipped Plugins (Built-in or Duplicate)

### Built-in Alternatives (Skip):
- `Comment.nvim` → Built-in `gc`, `gcc` operations
- `nvim-surround` → Built-in `cs`, `ds`, `ys` surround operations
- `neoformat` → LSP formatting (`vim.lsp.buf.format`) + built-in `=`

### Duplicate Functionality (Skip):
- `vim-airline`, `vim-airline-themes` → Use existing `lualine`
- `nerdtree` → Use existing `neo-tree`
- `nvim-tree.lua` → Use existing `neo-tree`
- `vim-gitgutter` → Use `gitsigns` (migrating)

### CMP Ecosystem (Skip - use blink.cmp):
- All `nvim-cmp` plugins: `cmp-buffer`, `cmp-cmdline`, `cmp-nvim-lsp`, `cmp-path`, `cmp_luasnip`
- nvim-dev uses `blink.cmp` (different completion system)

### Already Migrated/Equivalent:
- `blankindent` → Already as `indent-blankline.lua` (nvim-dev version better)
- `nvim-scrollbar` → Already migrated
- `yank` plugin → Built-in functionality (implementing as built-in)

### Mason Integration (Skip - keep current architecture):
- `mason-lspconfig.nvim` → **Keep current LSP setup** (Neovim 12 API with custom server install)

## Risk Assessment

### Low Risk (5):
- `colorizer` (highlighting only)
- `yank-highlight` (built-in functionality)
- `vim-sleuth` (auto-detection)
- `tree-sitter-regex` (syntax only)
- `gruvbox.nvim` (alternative theme)

### Medium Risk (8):
- `gitsigns` (Git integration)
- `windows.nvim` (window management)
- Git tools (`fugitive`, `rhubarb`, `lazygit`)
- `fidget.nvim` (LSP integration)
- `hlslens` (search integration)
- `todo-comments` (highlighting)
- `project.nvim` (project management)
- `friendly-snippets` (LuaSnip extension)

### High Risk (3):
- `nvim-autopairs` (core editing - could conflict with typing)
- `nvim-ts-autotag` (requires treesitter configuration)
- Config merges (could break existing functionality)

## Rollback Strategy

### Commit Points:
1. **Pre-migration**: Base state backup
2. **After Phase 1**: mps-ui essentials
3. **After Phase 2**: Git ecosystem
4. **After Phase 3**: Editing core
5. **After Phase 4**: Development tools
6. **After Phase 5**: Quality of life
7. **After Phase 6**: Colorscheme + built-in
8. **After Phase 7**: Final verification

### Rollback Commands:
```bash
# Check commit history
git log --oneline -10

# Rollback to specific phase
git reset --hard <commit-hash>

# Or use git revert for safe rollback
git revert <commit-hash> --no-edit
```

## Success Criteria

1. ✅ All 16 target plugins migrated and functional
2. ✅ No regression in existing nvim-dev functionality
3. ✅ Consistent keybind category format (`[CATEGORY] Comment`)
4. ✅ Built-in features used where appropriate
5. ✅ No duplicate plugin functionality
6. ✅ AGENTS.md updated with all new categories
7. ✅ Scrollbar-hlslens integration verified
8. ✅ Lua syntax valid for all new files

## Troubleshooting

### Common Issues & Solutions:

**Plugin fails to load**:
1. Check `:Lazy` for installation status
2. Verify plugin name in lazy-lock.json
3. Check dependencies are installed

**Keybind conflicts**:
1. Search for duplicate keybinds: `grep -r "desc = \\[CATEGORY\\]" lua/`
2. Check AGENTS.md for category standards
3. Use `:WhichKey` to see conflicts

**Syntax errors**:
1. Run: `nvim --headless -c "q"`
2. Check Lua syntax: `luacheck lua/`
3. Verify indentation (2 spaces)

**Integration failures**:
1. Verify scrollbar-hlslens: test search with scrollbar
2. Check Git tools integration: test fugitive + gitsigns
3. Verify autotag treesitter: test HTML file

## Final Notes

**Architecture Integrity**:
- Maintain Neovim 12 API usage (`vim.lsp.config`)
- Keep current `blink.cmp` completion system
- Preserve existing plugin structure and patterns

**Category Consistency**:
- All new keybinds must follow `[CATEGORY] Comment` format
- Update AGENTS.md with new category standards
- Ensure no duplicate categories with different meanings

**Validation Priority**:
1. Syntax and loading (critical)
2. Keybind categories (high)
3. Integration points (medium)
4. Performance impact (low)

**Ready for agent execution.** Follow phases sequentially, validate after each phase, commit successful phases for rollback safety.