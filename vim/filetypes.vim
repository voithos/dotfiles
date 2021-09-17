" Contains custom filetype declarations
"

" Markdown (auto-detected as Modula 2)
au BufNewFile,BufRead *.md set filetype=markdown

" Localfile formats
au BufNewFile,BufRead .bashlocal set filetype=sh
au BufNewFile,BufRead .vimlocal set filetype=vim

" Filetype-specific configs
"
au FileType yaml setlocal sw=2 ts=2 sts=2

au FileType glsl setlocal formatoptions+=roq

au FileType make setlocal noexpandtab  " Makefiles *require* tabs

au FileType markdown vnoremap <leader><Bslash> :EasyAlign*<Bar><CR>
au FileTYpe markdown let b:coc_suggest_disable = 1

au FileType typescript nnoremap <silent> <buffer> <leader>h :echo tsuquyomi#hint()<CR>
au FileType typescript setlocal completeopt+=menu,preview

" Non-work configs
if !filereadable(expand('~/.atwork'))
    augroup autoformat_settings
        autocmd FileType bzl AutoFormatBuffer buildifier
        autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
        autocmd FileType glsl,vert,frag AutoFormatBuffer clang-format
        autocmd FileType python AutoFormatBuffer yapf
        autocmd FileType typescript,typescriptreact AutoFormatBuffer prettier
    augroup END
endif
