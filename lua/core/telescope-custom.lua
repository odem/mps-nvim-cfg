local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local M = {}

function M.find_files_slash()
  builtin.find_files(themes.get_ivy({
    cwd = '/',
    prompt_title = '  /  ',
    follow = true,
    hidden = true,
  }))
end

function M.find_files_root()
  builtin.find_files(themes.get_ivy({
    cwd = '/root',
    prompt_title = '  /root  ',
    follow = true,
    hidden = true,
  }))
end

function M.find_files_home()
  builtin.find_files(themes.get_ivy({
    cwd = '~',
    prompt_title = '  ~  ',
    follow = true,
    hidden = true,
  }))
end

function M.find_files_mps()
  builtin.find_files(themes.get_ivy({
    cwd = '~/mps',
    prompt_title = '  ~/mps  ',
    follow = true,
    hidden = true,
  }))
end

function M.find_files_scratch()
  builtin.find_files(themes.get_ivy({
    cwd = '~/mps/scratch',
    prompt_title = '  ~/mps/scratch  ',
    follow = true,
    hidden = true,
  }))
end

function M.find_files_repo()
  builtin.find_files(themes.get_ivy({
    cwd = '~/mps/repo',
    prompt_title = '  ~/mps/repo  ',
    follow = true,
    hidden = true,
  }))
end

function M.find_files_etc()
  builtin.find_files(themes.get_ivy({
    cwd = '/etc',
    prompt_title = '  /etc  ',
    follow = true,
    hidden = true,
  }))
end

function M.find_files_var()
  builtin.find_files(themes.get_ivy({
    cwd = '/var',
    prompt_title = '  /var  ',
    follow = true,
    hidden = true,
  }))
end

function M.find_files_log()
  builtin.find_files(themes.get_ivy({
    cwd = '/var/log',
    prompt_title = '  /var/log  ',
    follow = true,
    hidden = true,
  }))
end

return M