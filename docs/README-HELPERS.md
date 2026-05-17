# helpers/

Utility modules shared across the config at `lua/helpers/`.

---

## quickfix

Toggle the quickfix list window open/closed.

### Details

Scans all open windows for one whose buffer `buftype` is
`'quickfix'`. If found, closes it (`cclose`). If not found,
opens a new quickfix window (`copen`).

Called by `<A-q>` in `keymaps.lua`.

Differs from a naive toggle: checks actual window `buftype`
rather than tracking state in a variable, so it stays correct
even if the quickfix window is closed manually.
  



---

## smart_delete

Conditional delete-left and delete-right using WORD-aware logic.

### Details

Two functions:

**`left()`** — Smart Backspace:
- At the beginning of a non-first line: join with the previous
  line (`k$J`).
- Character to the left is whitespace: delete single character
  (`hx`).
- Otherwise: delete backward WORD (`dB`).

**`right()`** — Smart Delete:
- Cursor on the last byte of a line: join with the next line
  (`J`).
- Character after cursor is whitespace: delete single character
  (`lx`).
- Otherwise: delete forward WORD (`dW`).

Rewritten in pure Lua (the original Vimscript in the old config
had off-by-one errors from mixing 0-based `getline()[idx]` with
1-based `col('.')`). Uses Lua 1-based `string:sub()` which
matches `col('.')` natively.

Called by `<S-BS>` and `<S-Del>` in `keymaps.lua`.
  



---

## telescope-custom

Custom telescope `find_files` pickers rooted at specific
directories.

### Details

Nine functions, each opening `telescope.builtin.find_files` with
`themes.get_ivy()` and a specific `cwd`:

| Function             | `cwd`          |
|----------------------|----------------|
| `find_files_slash`   | `/`            |
| `find_files_root`    | `/root`        |
| `find_files_home`    | `~`            |
| `find_files_etc`     | `/etc`         |
| `find_files_var`     | `/var`         |
| `find_files_log`     | `/var/log`     |
| `find_files_mps`     | `~/mps`        |
| `find_files_repo`    | `~/mps/repo`   |
| `find_files_scratch` | `~/mps/scratch`|

All use `follow = true` and `hidden = true`.

Called by `<leader>tcs*` keymaps in `telescope.lua`.
  



---

## themes

Protected colorscheme application with a reusable function.

### Details

`setColorScheme(name)` wraps `vim.cmd('colorscheme ' .. name)` in
`pcall`. If the colorscheme isn't installed (e.g., first startup
before lazy.nvim syncs), it prints a warning instead of crashing.

Called by `tokyonight.lua`'s `config()` to apply the tokyonight
theme. Can be reused for other colorschemes by importing this
module.
  


