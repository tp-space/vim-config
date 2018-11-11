

" disables copatibility mode with old vi and hence allows all the nice improvements that come with vim
set nocompatible              " required


" ===== Vundle Start =====

" temporary disable automatic file type detection (only during vundle processing)
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" To reload plugins, execute ":PluginInstall"
Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required
Plugin 'tpope/vim-surround' " allows to surround text with quotes, parenthesis and tags 
" Plugin 'scrooloose/nerdtree' "file browser
" Plugin 'tmhedberg/SimpylFold' "code collapse/folding for python
" Plugin 'vim-scripts/indentpython.vim' "standard PEP8 intendation for python
" Plugin 'Valloric/YouCompleteMe' "generic auto-complete
Plugin 'kien/ctrlp.vim' "super search (ctrl+p)
" Plugin 'tpope/vim-fugitive' " adds git support
Plugin 'mattn/emmet-vim' " high-speed html and css coding 
Plugin 'vim-airline/vim-airline'  "Powerline (pure vim script based)
Plugin 'scrooloose/syntastic' "Syntax checker
Plugin 'christoomey/vim-tmux-navigator' " allows to navigate from vim to tmux
" Plugin 'moll/vim-bbye' " provides an alternative :Bd to :bd, where the windows is not destroyed
" Plugin 'tpope/vim-obsession' " stores continuously vim sessions
" Plugin 'dhruvasagar/vim-prosession' " allows to manage multiple vim sessions (requires vim-obsession plugin)

" All of your Plugins must be added before the following line
call vundle#end()

" ===== Vundle End=====


" Enables filetype detection (for syntax)
filetype plugin indent on
"
" enables syntax highlighting (depending on filetype) 
let python_highlight_all=1
set syntax=on		

" let YouCompleteMe use the pyhton3 interpreter
" let g:ycm_server_python_interpreter='/usr/bin/python3'

" let the working directory of CtrlP be the same as the vim working directory
let g:ctrlp_working_path_mode = 0

" tell vim that background is dark => load optimized color scheme for dark background 
set background=dark

" enable numbering
set number
set relativenumber

" use system clipboard
set clipboard=unnamed

" disable mouse (especially useful when mouse pad is present)
set mouse-=a

" CtrlP settings
let g:ctrlp_cmd = 'CtrlPMRU'

" ===============================Auto command =================

" Highlights trailing white spaces in python and C
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match ExtraWhitespace /\s\+$/

autocmd BufRead,BufNewFile *.vue set ft=html

autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" =============================== Remap ===========================

" Remap leader key to space
let mapleader = " "

 " Remap <ESC> to jj
imap jj <ESC>

" Cycle through buffers
map <leader>n :bn<cr>
map <leader>p :bp<cr>

" Disable arrow keys in Normal-Mode"
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Disable arrow keys in Insert-Mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

nnoremap <ALT-CR> i<CR><Esc>

" map bclose to Bdelete
" cnoreabbrev bc Bdelete

