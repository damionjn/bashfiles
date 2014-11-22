" Make vim more useful
set nocompatible

" Set syntax highlighting options.
set t_Co=256
set background=dark
syntax on
colorscheme gruvbox
"colorscheme molotov

" Enabled later, after Pathogen
filetype off

" Change mapleader
let mapleader=","

" Set some junk
"set autoindent " Copy indent from last line when starting new line.
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
"set mouse=a " Enable moouse in all in all modes.
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
set ttymouse=xterm " Set mouse type to xterm.
set undofile " Persistent Undo.
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*
set wildmenu " Hitting TAB in command mode will show possible completions above command line.
set wildmode=list:longest " Complete only until point of ambiguity.
set winminheight=0 "Allow splits to be reduced to a single line.
set wrapscan " Searches wrap around end of file

" Speed up transition from modes
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Faster split resizing (+,_)
if bufwinnr(1)
  map + <C-W>+
  map _ <C-W>-
endif

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Sudo write (,W)
noremap <leader>W :w !sudo tee %<CR>

" Get output of shell commands
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" Remap :W to :w
command W w

" Better mark jumping (line + col)
nnoremap ' `

" Hard to type things
imap >> →
imap << ←
imap ^^ ↑
imap VV ↓
imap aa λ


" Clear last search (,qs)
map <silent> <leader>qs <Esc>:noh<CR>

" Remap keys for auto-completion menu
inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>" : "\<Up>"

" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

" Close Quickfix window (,qq)
map <leader>qq :cclose<CR>

" Yank from cursor to end of line
nnoremap Y y$

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" Strip trailing whitespace (,w)
function! StripWhitespace ()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>w :call StripWhitespace ()<CR>

" Join lines and restore cursor location (J)
nnoremap J mjJ`j

" Toggle folds (<Space>)
nnoremap <silent> <space> :exe 'silent! normal! '.((foldclosed('.')>0)? 'zMzx' : 'zc')<CR>

" Fix page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

" Jumping to tags. (via Steve Losh)
"
" Basically, <c-]> jumps to tags (like normal) and <c-\> opens the tag in a new
" split instead.
"
" Both of them will align the destination line to the upper middle part of the
" screen.  Both will pulse the cursor line so you can see where the hell you
" are.  <c-\> will also fold everything in the buffer and then unfold just
" enough for you to see the destination line.
nnoremap <c-]> <c-]>mzzvzz15<c-e>`z:Pulse<cr>
nnoremap <c-\> <c-w>v<c-]>mzzMzvzz15<c-e>`z:Pulse<cr>

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Set relative line numbers
set relativenumber " Use relative line numbers. Current line is still in status bar.
au BufReadPost,BufNewFile * set relativenumber

" JSON
au BufRead,BufNewFile *.json set ft=json syntax=javascript

" Jade
au BufRead,BufNewFile *.jade setlocal ft=jade syntax=jade

" Ruby
au BufRead,BufNewFile Rakefile,Capfile,Gemfile,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

" ZSH
au BufRead,BufNewFile .zsh_rc,.functions,.commonrc set ft=zsh

" XML
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Highlight Custom C Types
autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
autocmd BufRead,BufNewFile *.[ch] endif

" Airline.vim
let g:airline_powerline_fonts = 1
let g:airline_enable_syntastic = 1

" Markdown.vim
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']

" Tabular.vim
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:\zs/l0l1<CR>
vmap <Leader>a: :Tabularize /:\zs/l0l1<CR>
nmap <Leader>a, :Tabularize /,\zs/l0l1<CR>
vmap <Leader>a, :Tabularize /,\zs/l0l1<CR>

" Ruby.vim
let ruby_operators = 1
let ruby_space_errors = 1
let ruby_fold = 1

" Syntastic.vim
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'



" damionjn edits ----------------------------------------------------
" Say goodbye to SHIFT-;
nnoremap ; :

" Make whitespace visible
set list listchars=tab:\ \ ,trail:·

" Give top and bottom padding while scrolling
set scrolloff=10

" Quick splits (,v) (,h)
map <leader>v :vsplit<CR>
map <leader>h :split<CR>

" Buffer switching (,,) (,z) (,x)
map <leader>, <C-^>
map <leader>x :bnext<CR>
map <leader>z :bprev<CR>

" Tab navigation (,a) (,s)
map <leader>a gT
map <leader>s gt

" CtrlP.vim
" Fuzzy finder & buffer tray (,t) (,b)
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<cr>
" Ignore .git/ and others for quicker referencing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

" Nerdtree.vim
" Show project directory (,d) (,f)
nnoremap <leader>d :NERDTreeToggle<CR>
" Show current file when wandering directories
nnoremap <leader>f :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1

" Snipmate.vim
let g:snippets_dir = "~/.vim/snippets"

" Fugitive.vim
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gaa :Git add .<CR><CR>
nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>glg :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gg :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gbr :Git branch<Space>
nnoremap <leader>gco :Git checkout<Space>
nnoremap <leader>gbl :Gblame<Space>
nnoremap <leader>gp :! git push<CR>
nnoremap <leader>gl :! git pull<CR>

" Instant-markdown.vim (,im) show preview in browser
let g:instant_markdown_autostart = 0
nnoremap <leader>im :InstantMarkdownPreview<CR>

" Markdown - keep cursor vertically in middle for writing, width of 80 chars
au BufRead,BufNewFile *.md setlocal ft=markdown syntax=markdown so=999 tw=80

" Center focus
nnoremap n nzz
nnoremap N Nzz

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

" Go to end or beginning of line in insert mode (Ctrl-e, Ctrl-a)
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

iabbr serach search
iabbr tiem item
iabbr usre user

" Mustache-handlebars.vim ({{) abbreviation completion
let g:mustache_abbreviations = 1

" Change cursor to line when in insert mode
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    " let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    " let &t_EI = "\<Esc>]50;CursorShape=0\x7"
		let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
		let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  endif
end

" Strip semicolons (,s)
function! StripSemicolons ()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/;//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>s :call StripSemicolons ()<CR>

" New line above
inoremap <C-O> <esc>O
" damionjn edits end -------------------------------------------------


" Emulate bundles, allow plugins to live independently. Easier to manage.
execute pathogen#infect()
filetype plugin indent on

