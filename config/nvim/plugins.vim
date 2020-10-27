" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" === Base === "
""Plug 'tpope/vim-sensible'       " Defaults everyone can agree on
""Plug 'tpope/vim-sleuth'         " Heuristic formatting
""Plug 'tpope/vim-vinegar'
""Plug 'tpope/vim-eunuch'
""Plug 'tpope/vim-surround'
""Plug 'jiangmiao/auto-pairs'
""Plug 'haya14busa/incsearch.vim'
""Plug 'jreybert/vimagit'
""Plug 'jremmen/vim-ripgrep'
""Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
""Plug 'junegunn/fzf.vim'
""Plug 'honza/vim-snippets'
""Plug 'christoomey/vim-tmux-navigator'
""Plug 'samoshkin/vim-mergetool'
""" === Editing Plugins === "
""" Intellisense Engine
""Plug 'neoclide/coc.nvim', {'branch': 'release'}
""Plug 'antoinemadec/coc-fzf', { 'branch': 'release' }
""" === Git Plugins === "
""" Enable git changes to be shown in sign column
""Plug 'mhinz/vim-signify'
""Plug 'tpope/vim-fugitive'
""Plug 'christoomey/vim-conflicted'
""" === Language Plugins === "
""Plug 'sheerun/vim-polyglot'     " Syntax highlighting pack
""
""" === UI === "
""" Colorscheme
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
""" Customized vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()
