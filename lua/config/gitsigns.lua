-- Setup
require 'gitsigns'.setup {
  signs = {
    add = {hl = 'GitSignsAdd', text = '+'},
    change = {hl = 'GitSignsChange', text = '~'},
    delete = {hl = 'GitSignsDelete', text = '-'},
    topdelete = {hl = 'GitSignsDelete', text = '^-'},
    changedelete = {hl = 'GitSignsChange', text = '~-'},
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 400,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 400,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 40000,
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

-- Mapping
vim.api.nvim_set_keymap('n', '[h', "&diff ? ']c' : '<cmd>Gitsigns prev_hunk<cr>'", {expr = true, noremap = true})
vim.api.nvim_set_keymap('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'", {expr = true, noremap = true})
