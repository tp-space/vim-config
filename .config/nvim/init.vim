" disables copatibility mode with old vi and hence allows all the nice improvements that come with vim
set nocompatible

" ===== vimp-plug install =======
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Start plugin definition section. 
" The plugin installation path is indicated in the parenthesis. 
" Type:
" - PlugInstall to install new plugins
" - PlugUpdate to update plugins
" - PlugUpgrade to update vim-plug itself
call plug#begin('~/.config/nvim/plugged')

" Is a wrapper around the fuzzy finding system tool fzf. 
" (I think the plugin will take care of the installation of fzf 
" the first time you invoke fzf in vim, e.g using :F)
" By default fzf operates on the list generated by the command provided in FZF_DEFAULT_COMMAND.
"   To speedup search, you can use ripgrep to generate the list to be searched by fzf.
" For this you need to install the ripgrep system tool
"   The fzf.vim plugin provides some additional input sources 
" like :Lines (for searching in the current file) and :Rg to find text in multiple files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Contains the basic fzf tool (:FZF)
Plug 'junegunn/fzf.vim' " allows fuzzy searching of files 

" Plugin to toggle comments in various languages
" gcc: comment a line
" gc3j: comments 4 lines
" gcip: comments paragrap
" gc (in visual): comments selection
" gcu: uncomment
Plug 'tpope/vim-commentary'

" This plugin highlight the current search with a different style than others
" To cancel highligh, hit Ctrl+C
Plug 'timakro/vim-searchant'

" Allows to surround text with quotes, parenthesis and tags
" cs"': changes surrounding " with '
" ds": delete surround "
" ys2w<div> : surrounds two words with tag div 
" (visual): S": surround visual selection with "
" (visual): S<p> : surrounds visual selection with <p></p>
Plug 'tpope/vim-surround' " allows to surround text with quotes, parenthesis and tags 

" Syntax error checker for many languages.
" :Errors       - to open Error list
" :lclose       - to close Error list
" Plug 'scrooloose/syntastic' "Syntax error checker for many languages

" Adds auto-completion on top of lsp (language server protocol)
" Also adding vim-snippets to be used by coc-snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}    " grep stable version
Plug 'honza/vim-snippets'  " Snippets to be used by coc-snippets

" enables % to match also xml tags
Plug 'tmhedberg/matchit' 

Plug 'mattn/emmet-vim' " high-speed html and css coding 

" provides a nice status bar (using pure vim scripts)
Plug 'vim-airline/vim-airline'

" allows to navigate seeminglessly from vim to tmux
Plug 'christoomey/vim-tmux-navigator' 

" Client to connect to debug servers using dbgp as protocol
" PHP example:
" - Enable XDebug in php (check phpInfo file)
" - Configure Vdebug to connect to XDebug (port=9000)
" - In Vim, hit F5 to start listening for debug sessions
" - In Browser, append ?XDEBUG_SESSION_START=1 to the URL. This will start the session
" - In Vim, the connection should be established and waiting for commands
" Useful commands:
" F5: Run (until next breakpoint)
" F6 F6: Exit debug session (F6) and quit debu interface (F6)
" :Breakpoint : Toggles a breakpoint at current line
" F2, F3, F4:  step over, step into, step out
" :VdebugEval to evaluate an expression, e.g. $projects->toArray()[0]
Plug 'vim-vdebug/vdebug' " requires Python3

" adds git support to vim 
Plug 'tpope/vim-fugitive'

" Easy toggle between single to multiliner (e.g. argument or coma separated lists)
" - gS : splits argumets
" - gJ : joins argumets
Plug 'AndrewRadev/splitjoin.vim'

" Adds colorscheme
Plug 'morhetz/gruvbox'

call plug#end()

" =============================== Configure nvim providers =================

" Source configuration for nvim providers
source ~/.config/nvim/config-plugged/providers.vim

" =============================== General Settings =================

" Enables filetype detection (for syntax)
filetype plugin indent on

" enables syntax highlighting (depending on filetype) 
set syntax=on		

" performs case insensitive search if search expression has no upper case letters
" performs case sensitive search otherwise
set smartcase

" enables incremental search (find while typing search term)
set incsearch

" set default indention 
" tabstop: tells vim how wide (columns) a tab (ascii 0x09) should be represented
" softtabstop: tells vim by how many column the cursor shall be moved when hitting the tab or backspace key 
" expandtab: when enabled and hitting the tab key, spaces are inserted instead of the tab character (ascii 0x09)
" shiftwidth: tells vim the width of indent (e.g. when using << or >> )
" smarttab: 
" Set default to 'everything is 4 spaces'
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" tell vim that background is dark => load optimized color scheme for dark background 
set background=dark

" enable numbering
set number
set relativenumber

" don't create backup files (some lsp server's have problems with backup files)
set nobackup
set nowritebackup

" X11 systems have two clipboards:
" - PRIMARY: Any selected text automatically ends up in this clipboard (without furter actions)
" - CLIPBOARD: Any text yanked with CTRL+C ends up in this clipboard (standard copy)
" To yank/paste from these clipboards, use the * and + register respectively.
" The below config tells to which clippboard the default yank/paste commands shall be connected. 
" Possible values are unnamed (primary) or unnamedplus (clipboard)
set clipboard=unnamed      " connect to PRIMARY

" disable mouse (especially useful when mouse pad is present)
set mouse-=a

" Sets code max length to 120 characters (with dark-greyed vertical bar)
set colorcolumn=120
hi ColorColumn ctermbg=darkGrey guibg=darkGrey

" opens split on the right side when using C-w + v
set splitright

" opens split below when using C-w + s
set splitbelow

colorscheme gruvbox

" =============================== General KeyMappings =================

" Remap leader key to space
let mapleader = " "

" Map jj to <ESC>
inoremap jj <ESC>
tnoremap JJ <C-\><C-n>

" Toggle current word highlighing
nnoremap <leader>h :call CurrentWordHighlightingToggle()<Cr>

" Toggle between split and full screen window
nnoremap Z  :call CurrentZoomToggle()<Cr>

" Quickly execute a macro recorded with qq
nnoremap Q @q 

" Use double bang to store using sudo
" FIXME cnoremap w!! w :term sudo tee % >/dev/null

" After shifting a visual selection with < or >,
" the selection is lost. So this mapping re-selects
" the just shifted block again
vnoremap > >gv
vnoremap < <gv

" Cycle through buffers
map <leader>n :bn<cr>
map <leader>p :bp<cr>

" Disable arrow keys in Normal-Mode"
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

" Disable arrow keys in Insert-Mode
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Disable arrow keys in Visual-Mode
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>

" =============================== Functions =================

" Toggles the highlighting of the current word
let g:current_word_highlight_state = 0
function! CurrentWordHighlightingToggle()
    if g:current_word_highlight_state
        match none
        let g:current_word_highlight_state = 0
    else
        exec 'match' 'IncSearch' '/\V\<'.expand('<cword>').'\>/'
        let g:current_word_highlight_state = 1
    endif
endfunction


" Toggles the zoom state
let g:current_zoom_state = 0
function! CurrentZoomToggle()
    if g:current_zoom_state 
        exec "normal! \<c-w>\<bar>\<c-w>_"
        let g:current_zoom_state = 0
    else
        exec "normal! \<c-w>="
        let g:current_zoom_state = 1
    endif
endfunction
" =============================== Plugin configuration =================

" Source configuration for coc (conquer of completion)
source ~/.config/nvim/config-plugged/coc.vim

" Source configuration for FZF
source ~/.config/nvim/config-plugged/fzf.vim

" Source configuration for Vdebug
source ~/.config/nvim/config-plugged/vdebug.vim


" ===============================Auto command =================

" Capslock has no vim mapping. Hence the mapping must be done outside of vim
" A workaround is to run the external xmodmap tool when starting vim.
" What we do is to disable Capslock and then to remap it to Escape.
" Note this change will persist while using and after leaving vim.
" Also note, this mapping relies on the existance of xmodmap on your system.
" Personally, I prefer to use jj as ESC rather than capslock, as it is much easier to setup on a foreign machine 
" autocmd VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

" Highlights trailing white spaces in python and C
" FIXME: use linter and fixers instead
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match ExtraWhitespace /\s\+$/

" set default file types
autocmd BufRead,BufNewFile *.blade.php set ft=html ts=4 sts=0 expandtab sw=4 nosmarttab
autocmd BufRead,BufNewFile *.vue set ft=html
" autocmd BufRead,BufNewFile *.docker set ft=dockerfile
" autocmd Filetype php setlocal omnifunc=phpactor#Complete



" set default indention for various file types
autocmd BufRead,BufNewFile *.sh set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

