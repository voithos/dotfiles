" ------------------------------------------------------------------------
" -----------------------------   vimrc   --------------------------------
" ------------------------------------------------------------------------

" ------------------------------- System ---------------------------------
" ------------------------------------------------------------------------

if has('vim_starting')
    " Make Vim more useful than Vi
    set nocompatible

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" --------- Plugin Manager ---------
" ----------------------------------

" Setup NeoBundle
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Required for tsuquyomi
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" Original repos
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'burnettk/vim-angular'
NeoBundle 'cespare/vim-toml'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'google/vim-ft-bzl'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'honza/vim-snippets'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'junegunn/fzf', { 'base': '~', 'directory': '.fzf' }
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'matthewsimo/angular-vim-snippets'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'nacitar/a.vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'othree/yajs.vim'
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'rking/ag.vim'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/bufkill.vim'
NeoBundle 'vim-scripts/genutils'
NeoBundle 'vim-scripts/matchit.zip'

" Original mirrors
NeoBundle 'voithos/vim-multiselect'
NeoBundle 'voithos/vim-python-matchit'
NeoBundle 'voithos/vim-python-syntax'

" Forks
NeoBundle 'voithos/vim-colorpack'

" Conditional repos
if !filereadable(expand('~/.atwork'))
    " Non-work only
    NeoBundle 'Valloric/YouCompleteMe'
endif

call neobundle#end()

" Turn on filetype plugin and indentation handling
filetype plugin indent on

NeoBundleCheck

" --------------------------

" Set map leader
let mapleader = ','

" ------------------------------- General --------------------------------
" ------------------------------------------------------------------------
" Increase history size
set history=1000

" Allow changing of buffers without saving
set hidden

" Set the directory of the swap file
" The // indicates that the swap name should be globally unique
set directory=~/.vim/tmp//,/tmp//

" Enable backup files and specify backup directories
set backupdir=~/.vim/backup//,/tmp//
set backup

" Enable undo
set undodir=~/.vim/undo
set undofile

" Specify spelling file
set spellfile=~/.vim/spell/spell.utf-8.add

" Enable viminfo file, and create autocmd to restore file
" position between edits
set viminfo='10,<100,:20,%

function! ResCur()
    if line("'\"") < line("$")
        normal! g'"
        return 1
    endif
endfunction

autocmd BufReadPost * call ResCur()

" Use the bash shell
set shell=/bin/bash

" Use UTF-8 for internal text
set encoding=utf-8

" Try the following EOL formats when opening a new file
set fileformats=unix,dos,mac

" Automatically insert comment leader
set formatoptions=q

" Do not redraw while running macros
set lazyredraw

" Remove annoying bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Lower keycode timeout, to avoid lag when using <ESC> in terminal vim
" (ESC is a common starting character for terminal escape sequences)
set ttimeoutlen=100

" ------------------------------- Editing --------------------------------
" ------------------------------------------------------------------------
" Make backspace more flexible
set backspace=eol,start,indent

" Turn on syntax highlighting
syntax enable

" Set the tab stop to the given value and enable tab-to-space expansion
set tabstop=4
set shiftwidth=4
set expandtab

" Make sure that <BS> deletes a "shiftwidth" worth of spaces
set smarttab

" Make the indent carry to the next line
set autoindent

" Jump to the corresponding brace when inserting closing braces
" for the given time, in tenths of a second
set showmatch
set matchtime=3

" ------------------------------ Interface -------------------------------
" ------------------------------------------------------------------------
" Set options for GUI vs shell
if has("gui_running")
    " Disable the toolbar
    set guioptions-=T

    " Set theme options
    silent! colorscheme solarized
    set background=dark

    " Set font
    silent! set guifont=mononoki
    if &guifont != 'mononoki'
        set guifont=Monospace
    endif
else
    " Enable more colors for the terminal
    set t_Co=256

    " Set theme options
    silent! colorscheme badwolf
    set background=dark
endif

" Turn on Wild Menu for command completion
set wildmenu

" Set the title to be more meaningful
set title

" Keep the screen neat by not wrapping long lines
set nowrap

" Set whitespace characters to use when using list
set listchars=eol:¬,tab:»\ ,trail:·

" Set list by default
set list

" Enable an warning when exceeding a certain line length
set colorcolumn=+1,+2

" Enable line numbers
set number

" Show the line and column numbers
set ruler

" Increase height of Vim command prompt
set cmdheight=2

" Enable status line for all files
set laststatus=2

" Set the status line to show useful information
set statusline=\ %F%m%r%h\ %w\ \ [%{&ff}]%y\ Line:\ %l/%L:%c\ (%p%%)

" Always report number of lines modified
set report=0

" Maintain a certain number of lines between the cursor
" and the end of the window
set scrolloff=7

" ------------------------------ Searching -------------------------------
" ------------------------------------------------------------------------
" Ignore case in searching by default, unless there are capitals
set ignorecase
set smartcase

" Match searches immediately, and highlight subsequent matches
set incsearch
set hlsearch

" ------------------------------ Mappings --------------------------------
" ------------------------------------------------------------------------
" Map spellcheck toggle
nnoremap <silent> <leader>p :setlocal spell! spelllang=en_us<CR>

" Map list command
nnoremap <silent> <leader>l :set list!<CR>

" Map window switching shortcut
nnoremap <silent> <leader>w <C-W><C-W>

" Map CTRL+L to clear highlight search
noremap <silent> <C-L> :silent nohlsearch<CR>

" Map CTRL+Backspace to delete words in insert mode
inoremap <C-BS> <C-W>

" Map CTRL+S to select all
nnoremap <C-S> ggVG

" Map clipboard register paste and copy operations
nnoremap <C-P> "+gp
inoremap <C-P> <C-R>+
vnoremap <C-X> "+d
vnoremap <C-Y> "+y
vnoremap <C-P> "+gP

" Replace the backtick with the apostrophe, for better accessibility
nnoremap ' `
nnoremap ` '

" Same with the colon and semicolon; colon is used very often
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" Map Enter and Shift-Enter to insert newlines below and above the cursor
nnoremap <CR> o<ESC>0d$
nnoremap <S-CR> O<ESC>0d$

" Helper functions to avoid BufChange'ing the NERD tree window
function! BufNext()
    if exists("t:NERDTreeBufName")
        if bufnr(t:NERDTreeBufName) != bufnr('')
            bn
        endif
    else
        bn
    endif
endfunction

function! BufPrev()
    if exists("t:NERDTreeBufName")
        if bufnr(t:NERDTreeBufName) != bufnr('')
            bp
        endif
    else
        bp
    endif
endfunction

function! BufWipe()
    if exists("t:NERDTreeBufName")
        if bufnr(t:NERDTreeBufName) != bufnr('')
            BW
        endif
    else
        BW
    endif
endfunction

" Map buffer navigation easier
nnoremap <silent> <leader>j :call BufNext()<CR>
nnoremap <silent> <leader>k :call BufPrev()<CR>

" Map easier shortcuts to common plugins
nnoremap <silent> <leader>e :EasyAlign<CR>
vnoremap <silent> <leader>e :EasyAlign<CR>
nnoremap <silent> <leader>t :NERDTreeToggle<CR>
nnoremap <silent> <leader>n :NERDTreeFind<CR>
nnoremap <silent> <leader>q :call BufWipe()<CR> " Close buffer without closing window
nnoremap <silent> <leader>g :GundoToggle<CR>
nnoremap <silent> <leader>a :Ag! -i ''<LEFT>
nnoremap <silent> <leader>s :SyntasticCheck<CR>
nnoremap <silent> <leader>f :GitFiles<CR>
nnoremap <silent> <leader>h :echo tsuquyomi#hint()<CR>

" Map timestamp functions
nnoremap <F4> a<C-R>=strftime("%m/%d/%y")<CR><ESC>
inoremap <F4> <C-R>=strftime("%m/%d/%y")<CR>
nnoremap <F3> a<C-R>=strftime("%Y-%m-%d %a")<CR>
inoremap <F3> <C-R>=strftime("%Y-%m-%d %a")<CR>

" ------------------------------- Plugins --------------------------------
" ------------------------------------------------------------------------
" NERDCommenter
let NERDSpaceDelims = 1

" NERDTree
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeWinSize = 35

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }
" Allow usage of tsconfig.json.
let g:syntastic_typescript_tsc_fname = ''

" UltiSnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsSnippetsDir = "~/.vim/snips"
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snips"]

" Emmet
let g:user_emmet_leader_key = '<C-Z>'

" javascript-libraries-syntax
let g:used_javascript_libs = 'angularjs'

" ------------------------------ Includes --------------------------------
" ------------------------------------------------------------------------

" Add extra filetypes
source ~/.vim/filetypes.vim
" Extra helper functions
source ~/.vim/functions.vim


" Machine-specific overrides
if filereadable(expand("~/.vimlocal"))
    source ~/.vimlocal
endif
