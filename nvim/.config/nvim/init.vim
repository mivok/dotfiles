""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim_plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Lucius color scheme
Plug 'jonathanfilip/vim-lucius'

" Syntax/filetype specific
Plug 'hynek/vim-python-pep8-indent'
Plug 'hashivim/vim-terraform'
Plug 'sirtaj/vim-openscad'
Plug 'cespare/vim-toml'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'ledger/vim-ledger'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'vito-c/jq.vim'
Plug 'elzr/vim-json'
Plug 'LokiChaos/vim-tintin'
Plug 'davidoc/taskpaper.vim'
Plug 'pearofducks/ansible-vim'

" GPG integration
Plug 'jamessan/vim-gnupg'
" Fugitive
Plug 'tpope/vim-fugitive'
" Syntax checking
Plug 'scrooloose/syntastic'
" Snippets
Plug 'SirVer/ultisnips'
" Autocompletion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
" Autocompletion sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-jedi'    " Python - pip3 install jedi (and pip2)
Plug 'ncm2/ncm2-go'      " Golang - uses gocode (installed with vim-go)
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim' " Vim
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'} " Javascript
Plug 'ncm2/ncm2-html-subscope' " HTML
Plug 'ncm2/ncm2-markdown-subscope' " Markdown embedded languages
Plug 'ncm2/ncm2-ultisnips' " Autocomplete ultisnips
" Language server support in ncm2 (for e.g. ruby support)
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Easy alignment - gaip=
Plug 'junegunn/vim-easy-align'

" FZF (:Ag, :Files)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Personal wiki
Plug '~/git/personal/vim-myzettel'

" My Plugins
Plug 'mivok/vimtodo'
Plug 'mivok/vim-minotl'
Plug 'git@github.com:mivok/ultisnips-snippets.git'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom settings
set laststatus=2                   " Always show status bar
set ruler                          " Show line/col
set textwidth=78                   " Word wrapping
set title                          " Xterm title bar
set ai                             " Auto indent
set bs=2                           " Make sure backspace works right
set showmatch                      " Show matching parentheses
set matchtime=5                    " 5/10 seconds to show paren matches
set list listchars=tab:>-,trail:-  " Show trailing spaces and hard tabs
set incsearch                      " Incremental search
set so=2                           " Always show lines above/below cursor
set wildmode=longest,list          " Tab expansion like bash
set ignorecase                     " Ignore case in searches
set smartcase                      " ... unless the search term has caps
set iskeyword+=_,$,@,%,#           " Chars not to be word separators
set showcmd                        " Show commands being typed
set viminfo+=%                     " Save/restore buffer list
set encoding=utf-8                 " Use utf-8 by default
set modeline                       " Enable modelines
set modelines=5                    " Look 5 lines into the file
set wrap                           " Visually wrap long lines
set linebreak                      " Visually wrap at word boundaries
set showbreak=»                    " Mark manually wrapped lines with »
set autoread                       " Reload changed file if unmodified in vim
set ttimeout                       " Timeout on partial key sequences
set timeoutlen=500                 " timeout value in ms
set display+=lastline              " Don't display @ for partial lines
set conceallevel=2                 " Enable concealed text
set concealcursor=cv               " Modes to conceal when cursor in on a line
set mouse=a                        " Enable the mouse
set formatoptions+=j               " Delete comment chars when joining lines
set breakindent                    " Indent wrapped lines

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Multi buffer/window settings
set switchbuf=useopen       " Use existing windows (not tabs)
set hidden                  " Hide buffer when editing new file
set wmh=0                   " Allow windows to be just a status bar
map <Leader>j <C-w>j<C-w>_
map <Leader>k <C-w>k<C-w>_

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sudo make me a sandwich
cmap w!! %!sudo tee > /dev/null %

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab width is 4 and tabs are inserted as spaces
set tabstop=8                           " Hard tabs are 8 chars
set softtabstop=4                       " Tab key indents by 4 chars
set shiftwidth=4                        " Autoindent by 4 chars
set expandtab                           " Use spaces instead of tabs

" Quickly change tab settings
command! Tab2 setlocal sw=2 sts=2 ts=8 et
command! Tab4 setlocal sw=4 sts=4 ts=8 et
command! RealTab4 setlocal sw=4 sts=4 ts=4 noet listchars=tab:\ \ ,trail:-
command! RealTab8 setlocal sw=8 sts=8 ts=8 noet listchars=tab:\ \ ,trail:-

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look and feel options
set t_Co=256                        " 256 color terminal if possible
set background=dark
colorscheme lucius                 " Color scheme
LuciusBlack
" Overide folding colors
hi! link Folded Delimiter
" Make matching brackets look like something other than the cursor
hi MatchParen cterm=underline ctermbg=none ctermfg=white

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
" See http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim for
" cterm/gui mappings
hi User1 ctermfg=252 ctermbg=239 guifg=#d0d0d0 guibg=#4e4e4e
hi User2 ctermfg=254 ctermbg=65 guifg=#e4e4e4 guibg=#5f875f
hi User3 ctermfg=117 ctermbg=236 guifg=#87d7ff guibg=#303030
set statusline=%#User1#\ %t%m%r%h%w\ %#User2#\ %{&ff}\ %#User3#\ 0x\%02.2B%=\ %Y\ %#User2#\ \ %3p%%\ :%4l:%3v\ %#User1#\ L:%L\ B:%n\ 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Easyalign mappings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LaTeX paragraph formatting
"   Lets you use \gq or gqlp to format a paragraph respecting LaTeX
"   environments
map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gq//-1<CR>
omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go settings

" For vim-go and syntastic to play nice together
let g:syntastic_go_checkers = ['golint', 'govet', 'gometalinter']
let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Use goimports instead of gofmt on save
let g:go_fmt_command = "goimports"
" Use the same path for gotools regardless of GOPATH
let g:go_bin_path = expand("~/go/bin")

" Highlight all the things
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python settings
" pylint is slow
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_python_python_exec = '/usr/local/bin/python3'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use specific virtualenvs for neovim python
let venv_path = $HOME . '/.local/share/nvim/virtualenvs'
let g:python_host_prog = venv_path . '/python2/bin/python2'
let g:python3_host_prog = venv_path . '/python3/bin/python3'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Json conceal settings
let g:vim_json_syntax_conceal = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terraform plugin settings
let g:terraform_align = 0
let g:terraform_fmt_on_save = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NCM2 autocompletion settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Make the enter key work properly when the menu is open
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" And allow Tab to select the items on the popup menu

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" This makes ultisnips not conflict with ncm2 - you use Tab to autocomplete
" the snippet trigger, then CR to expand it once it's selected in the menu
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" CSS
call ncm2#register_source({'name' : 'css',
    \ 'priority': 9, 
    \ 'subscope_enable': 1,
    \ 'scope': ['css', 'scss', 'less'],
    \ 'mark': 'css',
    \ 'word_pattern': '[\w\-]+',
    \ 'complete_pattern': ':\s*',
    \ 'on_complete': ['ncm2#on_complete#omni',
    \               'csscomplete#CompleteCSS'],
    \ })
" Language Servers - https://langserver.org
" Installation instructions:
"   solargraph - brew install solargraph
"   bash - npm install -g bash-language-server
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'sh': ['bash-language-server', 'start']
    \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Exceptions for Specific Filetypes
au FileType make RealTab8
au FileType yaml Tab2
au FileType yaml setl indentkeys-=<:>
au FileType markdown Tab2
" Fix for gq on lists with plasticboy plugin - platicboy/vim-markdown#232
au FileType markdown set fo-=q |
    \ set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*\[-*+]\\s\\+
au FileType ruby Tab2
au FileType go RealTab4
au FileType terraform Tab2
au FileType taskpaper RealTab4
au FileType taskpaper setl tw=0
au FileType gitconfig RealTab4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autosave/reload taskpaper files
" Note: autoread doesn't automatically check for updates, so we need to run
" the checktime on regular intervals to see if the file was modified outside
" of vim. FocusGained seems to be good enough.
au FileType taskpaper au CursorHold,FocusLost,WinLeave <buffer> update
au FileType taskpaper setl autoread
au Filetype taskpaper au FocusGained,BufEnter <buffer> checktime

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set filetypes for specific extensions
au BufEnter *.tfstate set ft=json

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Crontab -e fix
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
