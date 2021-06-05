" Tab and wrapping commands

" Quickly change tab settings
command! Tab2 setlocal sw=2 sts=2 ts=8 et
command! Tab4 setlocal sw=4 sts=4 ts=8 et
command! RealTab2 setlocal sw=2 sts=2 ts=2 noet listchars=tab:\ \ ,trail:-
command! RealTab4 setlocal sw=4 sts=4 ts=4 noet listchars=tab:\ \ ,trail:-
command! RealTab8 setlocal sw=8 sts=8 ts=8 noet listchars=tab:\ \ ,trail:-

" Soft/Hard wrapping
command! SoftWrap call s:softwrap()
command! HardWrap call s:hardwrap()

function! s:softwrap() abort
    " Turn of hard wrapping
    set textwidth=0
    " Mappings to make line movement commands move by screen lines instead of
    " file lines
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
    noremap <silent> k gk
    noremap <silent> j gj
    noremap <silent> 0 g0
    noremap <silent> $ g$
    onoremap <silent> k gk
    onoremap <silent> j gj
endfunction

function! s:hardwrap() abort
    " Set textwidth back to normal
    set textwidth=78
    " Undo the softwrap mappings
    silent! nunmap  <Up>
    silent! nunmap  <Down>
    silent! nunmap  <Home>
    silent! nunmap  <End>
    silent! iunmap <Up>
    silent! iunmap <Down>
    silent! iunmap <Home>
    silent! iunmap <End>
    silent! nunmap k
    silent! nunmap j
    silent! nunmap 0
    silent! nunmap $
    silent! ounmap k
    silent! ounmap j
endfunction
