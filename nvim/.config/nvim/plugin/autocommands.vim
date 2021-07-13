" Filetype autocommands
augroup mh_filetypes
    au!
    au FileType yaml Tab2
    au FileType yaml setl indentkeys-=<:>
    au FileType markdown Tab2
    " Fix for gq on lists with plasticboy plugin - platicboy/vim-markdown#232
    au FileType markdown set fo-=q |
        \ set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*\[-*+]\\s\\+
    au FileType javascript Tab2
    au FileType javascriptreact Tab2
    au FileType lua Tab2
    au FileType ruby Tab2
    au FileType terraform Tab2
    au FileType go RealTab4
    au FileType taskpaper RealTab4
    au FileType taskpaper setl tw=0
    au FileType gitconfig RealTab4
    au FileType make RealTab8

    " Autosave/reload taskpaper files
    " Note: autoread doesn't automatically check for updates, so we need to
    " run the checktime on regular intervals to see if the file was modified
    " outside of vim. FocusGained seems to be good enough.
    au FileType taskpaper au CursorHold,FocusLost,WinLeave <buffer> update
    au FileType taskpaper setl autoread
    au Filetype taskpaper au FocusGained,BufEnter <buffer> checktime

    " Set filetypes for specific extensions
    au BufEnter *.tfstate set ft=json

    " Notes settings
    au BufEnter ~/notes/*.md SoftWrap
    au BufEnter ~/git/personal/notes/*.md SoftWrap

    " Crontab -e fix
    au BufEnter /private/tmp/crontab.* setl backupcopy=yes
augroup END

" Highlight text on yank
augroup highlight
    au!
    au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=500, on_visual=true}
augroup END
