call plug#begin(stdpath('data') . '/plugged')

Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'pbrisbin/vim-mkdir'
Plug 'chr4/nginx.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'alvan/vim-closetag', { 'for': ['javascript', 'svelte']  }
Plug 'psf/black', { 'branch': 'stable' }

call plug#end()

"""
""" Insert Mode settings
"""
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"""
""" Normal Mode settings
"""
nmap <CR> o<Esc>k
nmap <leader><CR> O<Esc>j
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" open fzf
nnoremap <C-p> :GFiles<CR>
" reload vimrc
nnoremap <leader>sv :source ~/.vimrc<CR>
" Don't screw up the undo history...
nnoremap U <C-r>

"""
""" Command Mode settings
"""
" use ctags
" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')
command! MakeTags !ctags -R .
cnoreabbrev H vert bo h


"""
""" vim settings
"""
autocmd vimenter * colorscheme gruvbox
autocmd BufWritePre *.py execute ':Black'

set background=dark    " Setting dark mode
colorscheme gruvbox

set cmdheight=1
set laststatus=2
set statusline="%f%m"
set ruler

" sometimes the mouse is useful...
set mouse=a

set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir
set directory^=$HOME/.vim/swap//

" enable backspace
set backspace=indent,eol,start

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" make default :find work better
set path+=**
set wildmenu

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set autoindent

set relativenumber
set number
set hidden
noh

" this lets the user use Shift-Tab to unindent "
" map <Esc>[Z <s-tab> "
" ounmap <Esc>[Z "

let g:svelte_preprocessor_tags = [
      \{ 'name': 'ts', 'tag': 'script', 'as': 'typescript'  }
      \]

" Plugin alvan/vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx,*.js,*.vue,*.erb,*.svelte"
let g:closetag_xhtml_filetypes = 'xhtml,js,jsx,tsx'

" nvim black plugin for python linting
let g:python3_host_prog = $HOME . '/.local/venv/nvim/bin/python'
let g:black_quiet = 1

