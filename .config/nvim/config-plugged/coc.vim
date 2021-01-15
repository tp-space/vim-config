" list the extentions to be loaded
let g:coc_global_extensions = [ 
  \ 'coc-snippets', 
  \ 'coc-json', 
  \ 'coc-tsserver', 
  \ 'coc-html', 
  \ 'coc-css', 
  \ 'coc-yaml', 
  \ 'coc-phpls', 
  \ 'coc-sh', 
  \ 'coc-highlight' 
  \ ]

" Define mapping for code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use Ctrl+l to expand snippet and jump to next placeholder
imap <C-l> <Plug>(coc-snippets-expand)

"user Ctrl j and k to jump between placeholders
let g:coc_snippet_next = '<c-l>' 

" Trigger suggestion list for autocompletion
inoremap <silent><expr> <c-space> coc#refresh()

" Show documentation of the current word (in normal mode)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


