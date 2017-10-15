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
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'fatih/vim-go'
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
NeoBundle 'rking/ag.vim'
NeoBundle 'roxma/vim-tmux-clipboard'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tikhomirov/vim-glsl'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/bufkill.vim'
NeoBundle 'vim-scripts/genutils'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'tmux-plugins/vim-tmux-focus-events'

" Original mirrors
NeoBundle 'voithos/vim-multiselect'
NeoBundle 'voithos/vim-python-matchit'
NeoBundle 'voithos/vim-python-syntax'

" Forks
NeoBundle 'voithos/vim-colorpack'

" Non-work only
if !filereadable(expand('~/.atwork'))
    NeoBundle 'google/vim-maktaba'

    NeoBundle 'bazelbuild/vim-ft-bzl'
    NeoBundle 'google/vim-codefmt'
    NeoBundle 'google/vim-glaive'

    NeoBundle 'Quramy/tsuquyomi'
    NeoBundle 'Valloric/YouCompleteMe'
endif

call neobundle#end()

" Post-install
if !filereadable(expand('~/.atwork'))
    call glaive#Install()
endif

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

" Automatically reload buffers if changed on disk
set autoread

" Fix weird focus redraw issues.
autocmd FocusLost * silent redraw!

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

" Spell color is awful
highlight SpellBad ctermbg=NONE

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
set tabstop=2
set shiftwidth=2
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

" Map quick fix shortcut
nnoremap <silent> <leader>cx :cclose<CR>

" Allow clearing highlight search
noremap <silent> <leader>l :silent nohlsearch<CR>

" Allow deleting words in insert mode
inoremap <C-BS> <C-W>

" Replace the backtick with the apostrophe, for better accessibility
nnoremap ' `
nnoremap ` '

" Same with the colon and semicolon; colon is used very often
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" Map keys to insert newlines below the cursor
nnoremap <CR> o<ESC>0d$

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

" Searches upwards in the directory tree to look for a certain sibling folder.
" Returns the repository root. Pass '.git' or '.hg', etc, to check for a
" certain repository type.
function! GetRepoRoot(repodir)
    let l:dir = getcwd()
    while 1
        let l:repo = l:dir . '/' . a:repodir
        if isdirectory(l:repo)
            return l:dir
        endif

        if l:dir ==# '/'
            break
        endif
        let l:dir = fnamemodify(l:dir, ':h') " dirname
    endwhile
    " No repo found.
    return ''
endfunction

" Can be overridden by machine-local vimrc for custom repo styles.
function! FzfCustomRepoFiles(...)
    return 0
endfunction

" Note: most of this is essentially s:fzf taken from fzf.vim.
function! FzfHgFiles(hgdir, extra)
    let [extra, bang] = [{}, 0]
    if len(a:extra) <= 1
        let first = get(a:extra, 0, 0)
        if type(first) == s:TYPE.dict
            let extra = first
        else
            let bang = first
        endif
    elseif len(a:extra) == 2
        let [extra, bang] = a:extra
    else
        throw 'invalid number of arguments'
    endif

    let opts = {
      \ 'source': 'hg status --no-status -m -a -c -u',
      \ 'dir': a:hgdir,
      \ 'options': '-m --prompt "HgFiles> "'
      \}
    let eopts = has_key(extra, 'options') ? remove(extra, 'options') : ''
    let merged = extend(copy(opts), extra)
    let merged.options = join(filter([get(merged, 'options', ''), eopts], '!empty(v:val)'))
    return fzf#run(fzf#wrap('hgfiles', merged, bang))
endfunction

" Runs fzf based on what repository the cwd is under.
" If no repository is found, runs fzf over the cwd.
function! FzfRepoFiles(...)
    let l:gitdir = GetRepoRoot('.git')
    if l:gitdir !=# ''
        return call('fzf#vim#gitfiles', [''] + a:000)
    endif
    let l:hgdir = GetRepoRoot('.hg')
    if l:hgdir !=# ''
        return FzfHgFiles(l:hgdir, a:000)
    endif

    " No known repos found; attempt custom repo routine.
    let l:customrepo = call('FzfCustomRepoFiles', a:000)
    if l:customrepo !=# 0
        return l:customrepo
    endif

    " Not inside a repository; run from the current directory.
    return call('fzf#vim#files', [getcwd()] + a:000)
endfunction

" Create a custom FZF command that uses the above helper.
command! -bang RepoOrCwdFiles
  \ call FzfRepoFiles(fzf#vim#with_preview(), <bang>0)

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
nnoremap <silent> <leader>f :RepoOrCwdFiles<CR>
nnoremap <silent> <leader>h :echo tsuquyomi#hint()<CR>
nnoremap <silent> <leader>i :cfirst<CR>

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

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_highlighting = 0

" Make the preview window wrap long lines.
function! PreviewFix()
    if &previewwindow
      setlocal linebreak wrap
      setlocal winheight=5  " Empirically determined.
    endif
endfunction

autocmd BufWinEnter * call PreviewFix()

" Non-work plugins
if !filereadable(expand('~/.atwork'))
    Glaive codefmt plugin[mappings]="<leader>u"
endif

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
