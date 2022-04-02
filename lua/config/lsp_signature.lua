require 'lsp_signature'.setup {
  bind = true,
  floating_window = true,
  floating_window_above_cur_line = false,
  fix_pos = false,
  max_height = 25,
  max_width = 55,
  handler_opts = {
    border = 'rounded'
  },
  always_trigger = false,
  timer_interval = 120
}
