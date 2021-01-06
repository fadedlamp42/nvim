    """"""""
    "basics"
    """"""""
filetype off
set autochdir               "working directory is always directory of current file
filetype plugin on          "netrw file browser
filetype plugin indent on   "filetype specific indenting
set mouse=a                 "mouse support
set hidden                  "allow hiding modified buffer
set scrolloff=10

    """"""""""""""""
    "vim-plug pulls"
    """"""""""""""""
call plug#begin()
"completion and linting
    Plug 'dense-analysis/ale'                           "asynchronous linting
    Plug 'fatih/vim-go'                                 "golang support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     "auto complete
    Plug 'sheerun/vim-polyglot'                         "many language syntax support
    Plug 'xolox/vim-easytags'                           "auto tag generation (requires exuberant-ctags)
    Plug 'xolox/vim-misc'                               "utils for easy-tags
"functional additions
    Plug 'airblade/vim-gitgutter'                       "git diff visualization
    Plug 'ctrlpvim/ctrlp.vim'                           "project fuzzy finder
    Plug 'junegunn/vim-easy-align'                      "align text using ga
    Plug 'kyuhi/vim-emoji-complete'
    Plug 'majutsushi/tagbar'                            "tag side bar
    Plug 'mattn/emmet-vim'                              "html/css editing
    Plug 'preservim/nerdcommenter'                      "commenting with ,c*
    Plug 'psliwka/vim-smoothie'                         "smooth scrolling animations
    Plug 'tpope/vim-fugitive'                           "git integration
    Plug 'tpope/vim-repeat'                             "allow plugins to map .
    Plug 'tpope/vim-surround'                           "add, change, and delete surroundings
"visual
    Plug 'RRethy/vim-illuminate'                        "highlight occurences of hovered token
    Plug 'Yggdroot/indentLine'                          "tab visualization
    Plug 'junegunn/goyo.vim'                            "distraction free editing
    Plug 'junegunn/limelight.vim'                       "paragraph highlighting
    Plug 'lilydjwg/colorizer'                           "colorize css colors
    Plug 'lukas-reineke/indent-blankline.nvim'          "virtual indent guides on blank lines
    Plug 'machakann/vim-highlightedyank'                "highlight yanked text
    Plug 'vim-airline/vim-airline'                      "nice status bar
    Plug 'vim-airline/vim-airline-themes'               "airline themes
call plug#end()

    """""""""""""""""""""""
    "plugin configurations"
    """""""""""""""""""""""
"ale
let g:ale_virtualtext_cursor = 1 "virtual text for diagnostics
let g:ale_set_signs = 0 " dont use the sign column
let g:ale_lint_on_text_changed = 'normal' " always in normal Mode
let g:ale_lint_on_insert_leave = 1 " only lint after insert
let g:ale_lint_delay = 0 " set delay to zero

let g:ale_fixers = {'python': ['black', 'isort']}

    "highlights
highlight ALEInfo           guifg=#ffff00
highlight ALEWarning        guifg=#ffff00
highlight ALEError          guifg=#ff0000
highlight ALEVirtualTextInfo    guifg=#777777
highlight ALEVirtualTextWarning guifg=#777777
highlight ALEVirtualTextError   guifg=#777777


"limelight
let g:limelight_conceal_ctermfg = 1

"tagbar
let g:tagbar_autofocus = 1 "autofocus on tagbar open

"coc
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set shortmess+=a
set shortmess-=t
set shortmess-=T
set signcolumn=auto

"smoothie
let g:smoothie_update_interval = 3
let g:smoothie_base_speed = 9
let g:smoothie_break_on_reverse = 1


"airline 
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1        "enable buffer tabline
let g:airline#extensions#tabline#fnamemod = ':t'    "only show file names of buffers

"vim-indent-guides 
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

"ctrlp
    "ignore redundant files/dirs
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
    "use closest .git as root
let g:ctrlp_working_path_mode = 'r' 

    "custom search
let g:ctrlp_user_command = 'find %s -type f'

    "ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] 

"easytags
    "enable asynchronous tag generation
let g:easytags_async = 1

"coc
let g:coc_global_extensions = [
\   'coc-cmake',
\   'coc-css',
\   'coc-cssmodules',
\   'coc-stylelintplus',
\   'coc-eslint',
\   'coc-git',
\   'coc-go',
\   'coc-html',
\   'coc-json',
\   'coc-python',
\   'coc-sh',
\   'coc-sql',
\   'coc-tsserver',
\   'coc-vimlsp',
\   'coc-xml',
\   'coc-yaml',
\]

"emmet
let g:user_emmet_leader_key='<C-E>'

    """""""""
    "mapping"
    """""""""
"""base vim"""
let mapleader="," "leader is comma

"tab complete
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"enter confirms completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"map jk to ESC to save time
inoremap jk <esc>
tnoremap jk <C-\><C-n>

"map ,f to open netrw in a vertical split
nnoremap <silent> <leader>f :Vexplore<CR>
"map ,F to open netrw
nnoremap <silent> <leader>F :Explore<CR>

"map ,s to horizontal split
nnoremap <silent> <leader>s :split<CR>
"map ,S to vertical split
nnoremap <silent> <leader>S :vsplit<CR>

"map ,t to make new tab and explore
nnoremap <silent> <leader>t :tab split<CR>:Explore<CR>
"map ,T to make new tab with same file
nnoremap <silent> <leader>T :tab split<CR>
"map <leader>q/w to switch tabs
nnoremap <silent> <leader>q :tabp<CR>
nnoremap <silent> <leader>w :tabn<CR>

"map J/K to flip buffers
nnoremap <silent> J :bprev<CR>
nnoremap <silent> K :bnext<CR>
"map <leader>W to close buffer
nnoremap <silent> <leader>W :bp <BAR> bd! #<CR>

"map <leader>V to edit init.vim
nnoremap <silent> <leader>V :e ~/.config/nvim/init.vim<CR>
"map <leader>C to edit coc-settings.json
nnoremap <silent> <leader>C :CocConfig<CR>

"clear search highlight after search and fix paste insert mode
nnoremap <silent> <leader><space> :nohlsearch<CR>:set nopaste<CR>

"map leader m to jump with menu
nnoremap <silent> <leader>m :tj<CR>
"map leader return to toggle tag sidebar
nnoremap <silent> <leader><CR> :TagbarToggle<CR>
nnoremap <silent> <leader>b :BuffergatorOpen<CR>
nnoremap <silent> <leader>B :BuffergatorClose<CR>

"map j and k to move visually on wrapped lines
nnoremap j gj
nnoremap k gk

"map <C-k> and <C-j> to cycle windows
nnoremap <C-k> <C-w><C-W> 
nnoremap <C-j> <C-w><S-w> 

"map <C + hyil> to resize windows
nnoremap <silent> <C-h> :vertical res -3<CR>
nnoremap <silent> <C-l> :vertical res +3<CR>
nnoremap <silent> <C-y> :res +3<CR>
nnoremap <silent> <C-i> :res -3<CR>

"map <leader>e to jump to next location
nnoremap <silent> <leader>e :lne<CR>zz
"map <leader>E to jump to previous location
nnoremap <silent> <leader>E :lNe<CR>zz

"map ?? to find highlight group
nnoremap <silent> ?? :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

"""plugins"""
"goyo
nnoremap <silent> <leader>g :Goyo<CR>

"limelight
nnoremap <silent> <leader>l :Limelight!! 0.85<CR>

"illuminate
hi link illuminatedWord Visual
let g:Illuminate_ftblacklist = ['', 'text']

    "goto's
nmap <silent> gD <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap gd :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

    "rename bound to ,r
nmap <leader>r <Plug>(coc-rename)

"easyalign
    " Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

    """"""""""""""
    "tab settings"
    """"""""""""""
set autoindent "maintain indentation from previous line
set expandtab "replace tabs with spaces
set tabstop=4 "amount of spaces in a tab character 
set softtabstop=4 "amount of spaces inserted when tabbing
set shiftwidth=4 "changes >> and <<, automatic indentation
set linebreak "word wrapping

    """"""""
    "scheme"
    """"""""
set termguicolors
colorscheme fadedwolf

    """"""""""""""""""
    "vanilla settings"
    """"""""""""""""""
syntax enable "explanatory
set relativenumber "line numbers aren't absolute
set nu rnu "hybrid line numbers
set showcmd "show command being typed
set cursorline "highlight line being edited
set wildmenu "visual autocomplete for commands
set lazyredraw "optimization, especially for macros 
set showmatch "highlight matching [{()}]
set fillchars+=vert:\  "remove window dividers

"folding
set foldmethod=syntax
set foldlevelstart=99

"searching
set path+=** "find searches downward with depth of 30 from working dir, **n changes the amount of layers
set incsearch "search as you enter characters
set hlsearch "highlight matches

    """""""
    "netrw"
    """""""
let g:netrw_liststyle = 3 "change default directory view
let g:netrw_banner = 0 "banner off on startup, I to view
let g:netrw_preview   = 1 "vertical split
let g:netrw_winsize   = 30 "only use 30% of window

    """""""""""
    "termdebug"
    """""""""""
packadd termdebug
let g:termdebug_wide = 1
set helpheight=100
