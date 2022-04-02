--- Aliases
local g = vim.g

g.splitjoin_split_mapping = ''
g.splitjoin_join_mapping = ''

vim.api.nvim_set_keymap('n', '<leader>j', ':SplitjoinSplit<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>k', ':SplitjoinJoin<cr>', {})
