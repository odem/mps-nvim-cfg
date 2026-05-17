-- luacheck configuration
-- .luacheckrc

std = lua51+glua

exclude_files = {
    ".deps/",
}

globals = {
    "vim",
    "describe",
    "it",
    "before_each",
    "after_each",
}

unused = false