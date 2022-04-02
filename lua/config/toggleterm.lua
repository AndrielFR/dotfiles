-- Mapping
vim.api.nvim_set_keymap('n', '<leader>t', '<Cmd>exe v:count1 . "ToggleTerm"<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>t', '<Esc><Cmd>exe v:count1 . "ToggleTerm"<cr>', {noremap = true})
