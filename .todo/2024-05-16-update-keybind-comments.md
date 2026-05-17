# Keybind Comment Update Plan

## Scope
Update keybind comments in 13 Lua files across the project (95 total keybinds)

## Goals
1. Remove all `[` and `]` brackets from existing comments
2. Add category prefixes in format `[CATEGORY] COMMENT` (space after bracket)
3. Maintain special characters like `/`
4. Handle duplicates with "(alt)" suffix (Telescope LSP only)

## Category Rules
1. Debugging folder: All categories become `[Debug]`
2. DAP categories: All become `[Debug]`
3. Rest Console: `[Rest]` (shortened)
4. LSP categories: All become `[LSP]`
5. Telescope categories: All become `[Telescope]`
6. Overseer categories: All become `[Overseer]`

## Files to Update (95 keybinds total)

### A. CORE FOLDER (4 files, 47 keybinds)
1. `lua/core/telescope.lua` - 34 keybinds → `[Telescope]`
2. `lua/core/lsp.lua` - 10 keybinds → `[LSP]`
3. `lua/core/luasnip.lua` - 2 keybinds → `[Luasnip]`
4. `lua/core/undotree.lua` - 1 keybind → `[Undotree]`

### B. NAVIGATION FOLDER (4 files, 17 keybinds)
5. `lua/navigation/flash.lua` - 5 keybinds → `[Flash]`
6. `lua/navigation/harpoon.lua` - 9 keybinds → `[Harpoon]`
7. `lua/navigation/oil.lua` - 1 keybind → `[Oil]`
8. `lua/navigation/yazi.lua` - 1 keybind → `[Yazi]`

### C. TOOLS FOLDER (4 files, 14 keybinds)
9. `lua/tools/dadbod.lua` - 1 keybind → `[Dadbod]`
10. `lua/tools/overseer.lua` - 11 keybinds → `[Overseer]`
11. `lua/tools/rest-console.lua` - 1 keybind → `[Rest]`
12. `lua/tools/toggleterm.lua` - 1 keybind → `[Toggleterm]`

### D. DEBUGGING FOLDER (1 file, 16 keybinds)
13. `lua/debugging/core.lua` - 16 keybinds → `[Debug]`

### E. APPEARANCE FOLDER (1 file, 1 keybind)
14. `lua/appearance/symbols-outline.lua` - 1 keybind → `[Symbols Outline]`

## Implementation Guidelines

### Format Rules
1. **Remove brackets**: Strip all `[` and `]` from original comment text
2. **Category format**: `[CATEGORY] Comment text`
3. **Space after bracket**: Always one space between `]` and comment
4. **Special characters**: Preserve `/`, `-`, `()` etc.
5. **Capitalization**: Preserve original comment casing
6. **Duplicate handling**: Add "(alt)" suffix for duplicate Telescope LSP keybinds

### Examples
Before → After:
- `'[t]elescope [k]eymaps'` → `'[Telescope] telescope keymaps'`
- `'[tc] [s]earch [/]'` → `'[Telescope] search /'`
- `'[g]o to definition'` → `'[LSP] go to definition'`
- `'[F9] Start/Continue'` → `'[Debug] Start/Continue'`
- `'[ov]erseer [t]ask action'` → `'[Overseer] overseer task action'`
- `'[r]est query'` → `'[Rest] rest query'`

### Verification Checklist
- [ ] Lua syntax valid after each file update
- [ ] Total keybind count remains 95
- [ ] Format consistent: `[CATEGORY] comment`
- [ ] All `[` and `]` removed from comments
- [ ] Telescope LSP duplicates have "(alt)" suffix
- [ ] Categories follow simplification rules

## Implementation Order
1. Core folder files (biggest files first)
2. Navigation folder
3. Tools folder
4. Debugging folder
5. Appearance folder
6. Verification

## Notes
- Preserve original comment casing (don't force sentence case)
- Brackets within words (like `[ov]`) should be removed, not replaced
- Watch for special regex characters when using edit commands
- Test Lua syntax after each file with `luac -p filename.lua`

## Progress Tracking
- Total files: 14
- Total keybinds: 95
- Categories: 14
- Priority: High