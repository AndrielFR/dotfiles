--- Aliases
local g = vim.g

-- Enable
g.better_whitespace_enabled = 1

-- Strip whitespace on save
g.strip_whitespace_on_save = 1

-- Don't strip on files beyond x lines
g.strip_max_file_size = 1000

-- Disable ask on save
g.strip_whitespace_confirm = 0

-- Don't strip whitespace in following files
g.better_whitespace_filetypes_blacklist = {'diff', 'git', 'gitcommit', 'help', 'fugitive'}

-- Strip whitespace at the end of the file
g.strip_whitelines_at_eof = 1

-- Show spaces
g.show_spaces_that_precede_tabs = 1

-- Ignore empty lines
g.better_whitespace_skip_empty_lines = 1

-- Mapping
vim.api.nvim_set_keymap('n', '[w', ':PrevTrailingWhitespace<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', ']w', ':NextTrailingWhitespace<cr>', {noremap = true})
