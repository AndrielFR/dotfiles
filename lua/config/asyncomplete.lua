--- Aliases
local g = vim.g
local set = vim.opt

-- Mapping
vim.cmd[[
  function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ asyncomplete#force_refresh()
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
  imap <c-space> <Plug>(asyncomplete_force_refresh)
]]

-- Enable preview window
g.asyncomplete_auto_completeopt = 0
set.completeopt = 'menuone,noinsert,noselect,preview'
vim.cmd 'autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif'

-- ALE
g.ale_fix_on_save = 1
g.ale_lint_on_save = 0
g.ale_lint_on_enter = 1
g.ale_lint_on_text_changed = 'never'
g.ale_lint_on_insert_leave = 1

g.ale_sign_error = 'E'
g.ale_sign_warning = 'W'
g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
g.ale_floating_window_border = {'│', '─', '╭', '╮', '╯', '╰'}
g.ale_warn_about_trailing_whitespace = 0

g.ale_linters = {
  bash = 'cspell',
  c = {'clangd', 'cspell'},
  css = {'stylelint', 'cspell'},
  graphql = {'gplint', 'eslint'},
  html = {'proselint', 'cspell'},
  javascript = {'eslint', 'flow', 'tsserver', 'cspell'},
  json = {'eslint', 'cspell'},
  json5 = 'eslint',
  jsonc = 'eslint',
  lua = {'luacheck', 'cspell'},
  markdown = {'markdownlint', 'cspell'},
  python = {'flake8', 'mypy', 'pyright', 'pydocstyle', 'cspell'},
  rust = {'rls', 'cspell'},
  text = {'proselint', 'cspell'},
  typescript = {'tsserver', 'cspell'},
  vim = 'vimls',
  yaml = 'yamllint',
}
g.ale_fixers = {
  bash = 'shfmt',
  c = 'clang-format',
  css = 'prettier',
  graphql = 'prettier',
  html = {'html-beautify', 'prettier'},
  javascript = {'eslint', 'prettier'},
  json = 'prettier',
  lua = 'lua-format',
  markdown = 'prettier',
  python = {'autoflake', 'black', 'isort'},
  rust = 'rustfmt',
  sql = 'sqlformat',
  typescript = {'eslint', 'prettier'},
  yaml = {'yamlfix', 'prettier'},
}

vim.api.nvim_set_keymap('n', '[g', '<Plug>(ale_previous_wrap)', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', ']g', '<Plug>(ale_next_wrap)', {silent = true, noremap = true})

vim.api.nvim_set_keymap('n', 'gd', ':ALEGoToDefinition<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gr', ':ALEFindReferences<cr>', {noremap = true})

vim.api.nvim_set_keymap('n', 'ss', ':ALESymbolSearch<cr>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>rn', ':ALERename<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ca', ':ALECodeAction<cr>', {noremap = true})

--- Sources
-- Neosnippet
g['neosnippet#snippets_directory'] = '~/.local/share/nvim/site/pack/paqs/start/vim-snippets/snippets'
vim.cmd[[
  call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
      \ 'name': 'neosnippet',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
      \ }))
]]
vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('s', '<C-k>', '<Plug>(neosnippet_expand_or_jump)', {})
vim.api.nvim_set_keymap('x', '<C-k>', '<Plug>(neosnippet_expand_target)', {})

-- Buffer
vim.cmd[[
  call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'allowlist': ['*'],
      \ 'blocklist': ['go'],
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ 'config': {
      \    'max_buffer_size': 5000000,
      \  },
      \ }))
]]

-- File
vim.cmd[[
  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'allowlist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))
]]

-- Git commit
vim.cmd[[
  au User asyncomplete_setup call asyncomplete#register_source({
      \ 'name': 'gitcommit',
      \ 'whitelist': ['gitcommit'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#gitcommit#completor')
      \ })
]]
