--- Aliases
local g = vim.g

-- Set the leader
g.mapleader = ','

-- Type jj to exit insert mode quickly
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})

-- Press the space bar to type the : character in command mode
vim.api.nvim_set_keymap('n', '<space>', ':', {noremap = true})

-- Center the cursor vertically when moving to the next word during a search
vim.api.nvim_set_keymap('n', 'n', 'nzz', {noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzz', {noremap = true})

-- You can split the window in Vim by typing :split or :vsplit
-- Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l
vim.api.nvim_set_keymap('n', '<ctrl-j>', '<ctrl-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<ctrl-k>', '<ctrl-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<ctrl-h>', '<ctrl-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<ctrl-l>', '<ctrl-w>l', {noremap = true})

-- Move to beginning/end of line
vim.api.nvim_set_keymap('n', 'B', '^', {noremap = true})
vim.api.nvim_set_keymap('n', 'E', '$', {noremap = true})

-- ^/$ doesn't do anything
vim.api.nvim_set_keymap('n', '^', '<nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '$', '<nop>', {noremap = true})
