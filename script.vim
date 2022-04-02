" Strip trailing whitespaces function
function! <SID>StripTrailingWhitespaces()
   if !&binary && &filetype != 'diff'
   let l:save = winsaveview()
   keeppatterns %s/\s\+$//e
   call winrestview(l:save)
 endif
endfun

" Configure specific file types.
augroup configgroup
   autocmd!
   autocmd VimEnter * highlight clear SignColumn
   autocmd BufWritePre,FileWritePre,FileAppendPre,FilterWritePre *.rs,*.py,*.js,*.ts,*.txt,*.md,*.toml,*.sh,*.vim
        \ :call <SID>StripTrailingWhitespaces()
   autocmd FileType vim setlocal foldmethod=marker
   autocmd FileType vim setlocal foldlevel=0
   autocmd BufEnter *.sh setlocal tabstop=2
   autocmd BufEnter *.sh setlocal shiftwidth=2
   autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
