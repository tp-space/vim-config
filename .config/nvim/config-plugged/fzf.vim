"###### FZF
"
" Prefixes all FZF commands with Fzf. E.g. :Files becomes :FzfFiles
let g:fzf_command_prefix = 'Fzf'

" FZF Files config with predefined filters
command! -bang -nargs=* FzfMyFiles call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{.git/*}"'}))
command! -bang -nargs=* FzfMyFilesWeb call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!{node_modules/*,vendor/*,.git/*, *[!~]}"'}))

" FZF Rg config with predefined filters
command! -bang -nargs=* FzfMyRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, <bang>0)
"command! -bang -nargs=* FzfMyRgWeb call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '!{node_modules/**,vendor/**,.git/**,database/*,app/DSVSuite/Database/**}' -- ".shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FzfMyRgWeb call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '{*.php,*.js,*.vue,*.json,*.css,*.html}' --glob '!{node_modules/**,vendor/**,.git/**}' -- ".shellescape(<q-args>), 1, <bang>0)

" add some custom bindings
nnoremap <leader>f  :FzfMyFiles<Cr>
nnoremap <leader>fw :FzfMyFilesWeb<Cr>
nnoremap <leader>g  :FzfMyRg<Cr>
nnoremap <leader>gw  :FzfMyRgWeb<Cr>

nnoremap <leader>b  :FzfBuffers<Cr>
nnoremap <leader>l  :FzfBLines<Cr>
nnoremap <leader>t  :FzfTags<Cr>

