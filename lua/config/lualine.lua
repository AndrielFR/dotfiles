require 'lualine'.setup {
    options = {
	icons_enabled = false,
	theme = 'powerline',
	component_separators = {left = '≤', right = '≥'},
	section_separators = {left = '⟨', right = '⟩'},
    },
    sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {{'filename', file_status = true, path = 1}, 'diagnostics', 'g:coc_status'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}
