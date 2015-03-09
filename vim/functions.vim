" ------------------------- Helper Functions --------------------------
" ---------------------------------------------------------------------
let mapleader = exists('g:mapleader') ? g:mapleader : ','

" Replace all occurrences of current word in line,
" with prompt
function! LineReplace()
    let search = expand('<cword>')
    call inputsave()
    let replacement = input('')
    call inputrestore()
    call setline(line('.'), substitute(getline('.'), search, replacement, 'g'))
endfunction

nnoremap <leader>r :call LineReplace()<CR>
