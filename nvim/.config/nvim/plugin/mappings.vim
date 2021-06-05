" Mappings config

" Sudo make me a sandwich
cmap w!! %!sudo tee > /dev/null %

" Fix common typos

" I often hold down shift too long when saving files
cabbrev W write
cabbrev Q quit

" Abbreviations/Command remapping
iab xdate <c-r>=strftime("%Y-%m-%d")<cr>
" Toggle paste on/off
set pastetoggle=<F2>
" Shift-Tab to unindent
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
" Quickly reload vimrc
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" LaTeX paragraph formatting
"   Lets you use \gq or gqlp to format a paragraph respecting LaTeX
"   environments
map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gq//-1<CR>
omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>

" Mapping - \x to execute the current line either in vim or lua
" Taken from https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/keymaps.vim#L52-L60
" TODO - move this to a separate file
function! s:executor() abort
    if &ft == 'lua'
        call execute(printf(":lua %s", getline(".")))
    elseif &ft == 'vim'
        exe getline(".")
    endif
endfunction
nnoremap <leader>x :call <SID>executor()<CR>
