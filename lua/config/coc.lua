-- Mapping
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', {})
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-nextt)', {})

vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {})
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {})
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {})
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {})

vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {})

vim.api.nvim_set_keymap('n', '<leader>fs', '<Plug>(coc-format-selected)', {})
vim.api.nvim_set_keymap('x', '<leader>fs', '<Plug>(coc-format-selected)', {})

vim.cmd [[
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : '\<C-g>u\<CR>'
	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use <tab> for trigger completion and navigate to the next complete item
  function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
	endfunction
	inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
]]

-- Highlight the symbol and its references when holding the cursor
vim.cmd "autocmd CursorHold * silent call CocActionAsync('highlight')"

-- Add `:OR` command for organize imports of the current buffer
vim.cmd "command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')"
