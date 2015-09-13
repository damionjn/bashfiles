" Set syntax highlighting
set t_Co=256
set background=dark
syntax on
colorscheme gruvbox

" Change mapleader
let mapleader=','

" NeoVim
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Local dirs
set backupdir=~/.nvim/backups
set directory=~/.nvim/swaps
set undodir=~/.nvim/undo

" ------------------------------------------------------------------------------
" Basic settings [[[
" ------------------------------------------------------------------------------
set autoindent " Copy indent from last line when starting new line.
set backspace=indent,eol,start
set cursorline " Highlight current line
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set encoding=utf-8 nobomb " BOM often causes trouble
set esckeys " Allow cursor keys in insert mode.
set expandtab " Expand tabs to spaces - github, other editor friendly
set foldcolumn=0 " Don't show column folds
set nofoldenable
set foldlevel=2
set foldmethod=syntax " Markers are used to specify folds.
set foldminlines=0 " Allow folding single lines
set foldnestmax=3 " Set max fold nesting level
set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words
set gdefault " By default add g flag to search/replace. Add g to toggle.
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches.
set incsearch " Highlight dynamically as pattern is typed.
set laststatus=2 " Always show status line
set lispwords+=defroutes " Compojure
set lispwords+=defpartial,defpage " Noir core
set lispwords+=defaction,deffilter,defview,defsection " Ciste core
set lispwords+=describe,it " Speclj TDD/BDD
set magic " Enable extended regexes.
set mouse=a " Enable moouse in all in all modes.
set noerrorbells " Disable error bells.
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.
set noshowmode " Don't show the current mode (airline.vim takes care of us)
set nostartofline " Don't reset cursor to start of line when moving around.
set nowrap " Do not wrap lines.
set nu " Enable line numbers.
set ofu=syntaxcomplete#Complete " Set omni-completion method.
set report=0 " Show all changes.
set ruler " Show the cursor position
set scrolloff=3 " Start scrolling three lines before horizontal border of window.
set shell=/bin/sh " Use /bin/sh for executing shell commands
set shiftwidth=2 " The # of spaces for indenting.
set shortmess=atI " Don't show the intro message when starting vim.
set showtabline=2 " Always show tab bar.
set sidescrolloff=3 " Start scrolling three columns before vertical border of window.
set smartcase " Ignore 'ignorecase' if search pattern contains uppercase characters.
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set smartindent
set tabstop=2
set softtabstop=2 " Tab key results in 2 spaces
set splitbelow " New window goes below
set splitright " New windows goes right
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set title " Show the filename in the window titlebar.
set ttyfast " Send more characters at a given time.
set undofile " Persistent Undo.
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*
set wildmenu " Hitting TAB in command mode will show possible completions above command line.
set wildmode=list:longest " Complete only until point of ambiguity.
set winminheight=0 "Allow splits to be reduced to a single line.
set wrapscan " Searches wrap around end of file
silent !tmux set status on " Enable tmux status bar
" ]]]
" ------------------------------------------------------------------------------
" Tricks. You got to use TRICKS: https://www.youtube.com/watch?v=8VEfvuhGv9Q [[[
" ------------------------------------------------------------------------------

" Load vimrc
nmap <leader>m :source $MYVIMRC<CR>

" Sudo write (,W)
noremap <leader>W :w !sudo tee %<CR>

" Clear last search (,<space>)
map <silent> <leader><space> <Esc>:noh<CR>

" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" Quick splits (,v) (,h)
map <leader>v :vsplit<CR>
map <leader>h :split<CR>

" Buffer switching (,,) (,z) (,x)
map <leader>, <C-^>
map <leader>x :bnext<CR>
map <leader>z :bprev<CR>

" Say goodbye to SHIFT-;
nnoremap ; :

" Speed up viewport scrolling
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Faster split resizing (+,_)
if bufwinnr(1)
  map + <C-W>+
  map _ <C-W>-
endif

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Better mark jumping (line + col)
nnoremap ' `

" Remap keys for auto-completion menu
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"

" Yank from cursor to end of line
nnoremap Y y$

" Join lines and restore cursor location (J)
nnoremap J mjJ`j

" Toggle folds (<Space>)
nnoremap <silent> <space> :exe 'silent! normal! '.((foldclosed('.')>0)? 'zMzx' : 'zc')<CR>

" Fix page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

" Make whitespace visible
set list listchars=tab:\ \ ,trail:·

" Give top and bottom padding while scrolling
set scrolloff=10

" Center focus
nnoremap n nzz
nnoremap N Nzz

" Go to end or beginning of line in insert mode (Ctrl-e, Ctrl-a)
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

" Open current file in...
nnoremap <F12>s :exe ':silent !open -a /Applications/Safari.app %'<CR>
nnoremap <F12>m :exe ':silent !open -a /Applications/Mou.app %'<CR>;
nnoremap <F12>v :exe ':silent !open -a /Applications/MacVim.app %'<CR>;

" New line above
inoremap <C-O> <esc>O

" qq to record, Q to replay
nmap Q @q

" <tab>/<S-tab> | Circular buffer navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Never gets used, turn it off
set modelines=0

" Use normal regex
nnoremap / /\v
vnoremap / /\v

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Set relative line numbers
set relativenumber " Use relative line numbers. Current line is still in status bar.
au BufReadPost,BufNewFile * set relativenumber

" Still trying to figure out this whole 'typing' thing
iabbr serach search
iabbr tiem item
iabbr usre user

" ]]]
" ==============================================================================
" Helpers [[[
" ==============================================================================

" Strip trailing whitespace (,w)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>w :call StripWhitespace()<CR>

" Strip semicolons (,e)
function! StripSemicolons()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/;//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>e :call StripSemicolons()<CR>

" Quick Pairs
function! CheckIfEscaped()
  let line = getline('.')[:col('.')-2]
  if  line[-1:] is# '\'
    return "'"
  else
    return "''\<Esc>\i"
  endif
endfunction

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap ' <C-R>=CheckIfEscaped()<CR>
inoremap " ""<Esc>i

" ]]]
"
" }}}
" ==============================================================================
" FILETYPES {{{
" ==============================================================================

" Markdown ---------------------------------------------------------------------
augroup filetype_markdown
  autocmd!
  " Markdown - keep cursor vertically in middle for writing, width of 80 chars
  au BufNewFile,BufReadPost *.md setlocal ft=markdown syntax=markdown so=999 tw=80
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
augroup END

" }}}
