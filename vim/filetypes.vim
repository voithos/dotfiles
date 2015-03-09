" Contains custom filetype declarations
"

" Flex, The Fast Lexical Analyzer
au BufNewFile,BufRead *.flex set filetype=lex

" ASP.NET ASMX
au BufNewFile,BufRead *.asmx set filetype=cs

" Markdown (auto-detected as Modula 2)
au BufNewFile,BufRead *.md set filetype=markdown


" Filetype-specific configs
"
au FileType ruby setlocal sw=2 ts=2 sts=2
au FileType yaml setlocal sw=2 ts=2 sts=2

au FileType make setlocal noexpandtab  " Makefiles *require* tabs
