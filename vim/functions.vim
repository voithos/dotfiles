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

vnoremap <C-a> :call g:VisIncrement()<CR>
