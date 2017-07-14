" {{{ plugins
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'						" theme
Plug 'bling/vim-airline'					" status line
Plug 'jeffkreeftmeijer/vim-numbertoggle'	" smart relative numbering
Plug 'airblade/vim-gitgutter'				" show git diffs
Plug 'bronson/vim-trailing-whitespace'		" show trailing spaces
Plug 'jiangmiao/auto-pairs'					" spawn matched brackets / quotes
Plug 'majutsushi/tagbar'                    " class/module browser
Plug 'tpope/vim-surround'
Plug 'roxma/nvim-completion-manager'
Plug 'hynek/vim-python-pep8-indent'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'benekastah/neomake'
Plug 'neoclide/vim-jsx-improve'
Plug 'othree/html5.vim'
Plug 'tpope/vim-fugitive'
call plug#end()
" }}}

" {{{ plugin settings

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section=''
let g:airline_detect_paste=1 " Show PASTE if in paste mode
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" neomake
autocmd BufReadPost * Neomake
autocmd BufWritePost * Neomake

let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_javascript_enabled_makers = ['eslint']
function! NeomakeESlintChecker()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
    let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  let b:neomake_javascript_eslint_exe = l:eslint
endfunction
autocmd FileType javascript :call NeomakeESlintChecker()

" deoplete
let g:deoplete#enable_at_startup = 1

" }}}

" {{{ keybinds

" Define ' ' as map leader
let mapleader = ','
let g:mapleader = ','

" indenting keybinds
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Repurpose up and down arrow keys to move between the buffers
nnoremap <leader><Right>   :bn<CR>
nnoremap <leader><Left>  :bp<CR>

" neomake
map <leader>sc :Neomake!<CR>
map <leader>, :ll<CR>
map <leader>n :lnext<CR>
map <leader>p :lprev<CR>

" copy visual
map <C-c> "+y<CR>

" toggle paste mode
set pastetoggle=<F2>

" Tagbar
nmap <F8> :TagbarToggle<CR>

nnoremap <C-s> :update<CR>

" Disable arrow key
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>

" fold
nnoremap <leader><Space> za
vnoremap <leader><Space> za

" fast move

noremap H ^
noremap L g_
noremap J 5j
noremap K 5k

" }}}

" {{{ others

" tab options
set tabstop=2 shiftwidth=2 expandtab

" set title and allow hidden buffers
set title
set hidden
" set list

" Auto remove all trailing whitespace on :w
autocmd BufWritePre * :%s/\s\+$//e

" Autosave files when focus is lost
:au FocusLost * :wa

" Line Numbers
set number
set numberwidth=3

" Path will be base dir that vim is opened from
set path=$PWD/**

set nomodeline
set noshowmode			" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set shortmess=atToOI    " To avoid the 'Hit Enter' prompts caused by the file messages
set undolevels=1000
set updatetime=1500

" Wild menu (Autocompletion)"
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.jpeg,*.png,*.xpm,*.gif
set wildmode=list:longest,full

" Backup and Swap
set nobackup
set nowritebackup
set noswapfile

" Search Options
set hlsearch   " Highlight search
set magic      " Set magic on, for regular expressions
set ignorecase " Searches are Non Case-sensitive
set smartcase

" FOLDING
set foldenable
set foldmethod=marker
set foldlevel=0
set foldcolumn=0

" colors
set t_Co=256
colorscheme gruvbox
set background=dark
" hi Normal ctermbg=none	" transparent background

set encoding=utf-8

" General UI Options
set mouse=a
set showmatch          " Shows matching brackets when text indicator is over them
set cursorline
set scrolljump=10
set ttyfast            " Improves redrawing for newer computers
set pumheight=20       " popup menu height
set diffopt+=context:3
set nostartofline      " when moving thru the lines, the cursor will try to stay in the previous columns

" LAYOUT / TEXT FORMATTING
" Formatting Options
set wrap " Soft Wrap in all files, while hard wrap can be allow by filetype
set linebreak " It maintains the whole words when wrapping
set smartindent
" execute "set colorcolumn=" . join(range(81,335), ',')
set colorcolumn=120

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" gvim options - remove the toolbar.
set guioptions-=L
set guioptions-=T

set laststatus=2 " Always show airline bar

" other mappings
noremap <Leader>W :w !sudo tee % > /dev/null

" config fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" }}
