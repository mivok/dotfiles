""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom settings

set laststatus=2                   " Always show status bar
set title                          " Xterm title bar
set ai                             " Auto indent
set bs=2                           " Make sure backspace works right
set showmatch                      " Show matching parentheses
set matchtime=5                    " 5/10 seconds to show paren matches
set list listchars=tab:>-,trail:-  " Show trailing spaces and hard tabs
set incsearch                      " Incremental search
set inccommand=nosplit             " Incremental replace (preview replacements)
set scrolloff=2                    " Always show lines above/below cursor
set wildmode=longest,list          " Tab expansion like bash
set ignorecase                     " Ignore case in searches
set smartcase                      " ... unless the search term has caps
set iskeyword+=_,$,@,%,#           " Chars not to be word separators
set showcmd                        " Show commands being typed
set viminfo+=%                     " Save/restore buffer list
set encoding=utf-8                 " Use utf-8 by default
set modeline                       " Enable modelines
set modelines=5                    " Look 5 lines into the file
set autoread                       " Reload changed file if unmodified in vim
set ttimeout                       " Timeout on partial key sequences
set timeoutlen=500                 " timeout value in ms
set display+=lastline              " Don't display @ for partial lines
set conceallevel=2                 " Enable concealed text
set concealcursor=cv               " Modes to conceal when cursor in on a line
set mouse=a                        " Enable the mouse
set formatoptions+=j               " Delete comment chars when joining lines
set updatetime=500                 " Make CursorHold respond much quicker
set termguicolors                  " Enable truecolor terminal support

" Line/column settings
set number                         " Display line numbers
set signcolumn=yes                 " Always display the sign column
set colorcolumn=80                 " Highlight column 80
set textwidth=80                   " Word wrapping

" Wrapping options
set wrap                           " Visually wrap long lines
set linebreak                      " Visually wrap at word boundaries
set showbreak=\\                   " Mark manually wrapped lines with \
set breakindent                    " Indent wrapped lines
set breakindentopt=shift:2,sbr     " Additionally indent wrapped lined by 2

" Multi buffer/window settings
set switchbuf=useopen       " Use existing windows (not tabs)
set hidden                  " Hide buffer when editing new file
set wmh=0                   " Allow windows to be just a status bar

" Default tab settings
set tabstop=8                           " Hard tabs are 8 chars
set softtabstop=4                       " Tab key indents by 4 chars
set shiftwidth=4                        " Autoindent by 4 chars
set expandtab                           " Use spaces instead of tabs
