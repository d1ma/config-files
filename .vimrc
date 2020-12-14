" Run :PlugInstall to update plugins 
" Install COC-server with :CocInstall coc-tsserver 

call plug#begin()
" This is where we will add plugins to install

Plug 'HerringtonDarkholme/yats.vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax

Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }

" Plug 'ervandew/supertab'
let global_extensions = [ 'coc-tsserver' ]
call plug#end()

let mapleader = ','
" enable line numbers by default
set number
" disable backups
set nobackup
set nowritebackup
set noswapfile
" disable annoying beep on errors
set noerrorbells
if has('autocmd')
  autocmd GUIEnter * set vb t_vb=
endif
" expand tabs to 2 spaces
set shiftwidth=2
set tabstop=2
set smarttab
set expandtab
"
" font options
"
" keep at least 5 lines below the cursor
set scrolloff=5
"
" close buffer when tab is closed
set nohidden
"
" better moving between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"
" ; is better than :, and kj is better than ctrl-c
nnoremap ; :
"
" also autosave when going to insert mode
inoremap jk <Esc>:w<CR>
" extra shortcuts
nnoremap <leader>e :CtrlP<CR>
nnoremap <leader>s :vsplit<CR>
nnoremap <C-t>     :tabnew<CR>:CtrlP<CR>

" Key to toggle NERDTree
nmap <leader>t :NERDTreeToggle<cr>
nmap <leader>* :NERDTreeFind<cr>
nnoremap t1 1gt
nnoremap t2 2gt
nnoremap t3 4gt
nnoremap t4 4gt
nnoremap t5 5gt
nnoremap t6 6gt
nnoremap t7 7gt
nnoremap t8 8gt
nnoremap t9 9gt
nmap tn :tabn<cr>
nmap tp :tabp<cr>
" TODO: Add tab-next, tab-previous
nnoremap t1 1gt
nnoremap t2 2gt

let g:NERDTreeWinSize=60
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

set clipboard=unnamed

" ack.vim --- {{{
"
" " Use ripgrep for searching
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search
" case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>
" }}}

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Resetting vim mapped to <leader>0
nnoremap <silent><leader>0 :source ~/.vimrc \| :PlugInstall<CR>

nnoremap <C-f> <C-d>
nnoremap <C-b> <C-u>

function! s:GoToDefinition()
  if CocAction('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error" || ret =~ "错误"
    call searchdecl(expand('<cword>'))
  endif
endfunction

nmap <silent> gd :w<cr>:call <SID>GoToDefinition()<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

