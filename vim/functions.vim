" ------------------------- Helper Functions --------------------------
" ---------------------------------------------------------------------
let mapleader = exists('g:mapleader') ? g:mapleader : ','

" Increment visual number block
function! g:VisIncrement()
    let a = line('.') - line("'<")
    let c = virtcol("'<")
    if a > 0
        execute 'normal! ' . c . '|' . a . "\<C-a>"
    endif
    normal `<
endfunction

" Custom fzf source cmd, defaulting to git repo root, if it exists
function! s:getFzfSourceCmd()
    " Use git repository's root instead of current path
    let location = system('git rev-parse --show-cdup')
    " Remove \0 character from the end of the string
    let location = substitute(location, '\%x00', '', 'g')
    if v:shell_error
        " If not a git repository, use git current path
        return 'ag -l -g "" .'
    endif
    " Strip the leading '../'
    return 'ag -l -g "" ' . location . ' | sed "s/^\(\.\.\/\)*//"'
endfunction

" Custom fzf function
function! g:FzfFromGitRoot()
  let source = s:getFzfSourceCmd()
  call fzf#run({'source': source, 'sink': 'e', 'down': '20'})
endfunction

vnoremap <C-a> :call g:VisIncrement()<CR>
nnoremap <silent> <leader>f :call g:FzfFromGitRoot()<CR>
