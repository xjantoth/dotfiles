" plugins
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin("~/.config/nvim/plugged")
  " Plugin Senohlsearchction
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'psliwka/vim-smoothie'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'puremourning/vimspector'
Plug 'sagi-z/vimspectorpy', { 'do': { -> vimspectorpy#update() } }
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-surround'
Plug 'fisadev/vim-isort'
" Distraction free writing by removing UI elements and centering everything.
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'chrisbra/vim-commentary'
Plug 'robertbasic/vim-hugo-helper'
Plug 'juev/vim-hugo'
call plug#end()

nnoremap <F2> :set invpaste paste?<CR>
set number
set relativenumber
set cursorline
set scroll=10
set scrolloff=10
set pastetoggle=<F2>
set showmode
set hlsearch
set statusline=\ %f%m%r\ %y\ %=\ %c\ [%l/%L]\ %p\%%\ %P\
hi CursorLine ctermbg=237

colorscheme gruvbox
" make sure to install bat, riggrep

autocmd BufEnter *.json.tpl :setlocal filetype=json 
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

let g:fzf_action = { 'enter': 'tabedit' }
let g:fzf_layout = { 'down': '~40%' }
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <C-p> :Files<CR>

map <C-K> :bprev <CR>
map <C-J> :bnex <CR>

" quick .vimrc access with ,v
let $NEOVIM = "~/.config/nvim/init.vim"
let mapleader = ","
nmap <leader>v :tabedit $NEOVIM<CR>
nmap <leader>a :ls<CR>
nmap <leader>w :Windows<CR>
map <C-r> :source $NEOVIM<CR>
nmap <C-f> :Files<CR>
nmap <leader>ss :nohlsearch<CR>
nmap <leader>tt :tabonly<CR>
"nmap <leader>x :!xclip -selection c %<CR><CR>
nmap <leader>x :!pbcopy < %<CR><CR>
vnoremap <leader>x :w !pbcopy<CR><CR>

"nmap gx yiW:!xdg-open <c-r>" & <CR><CR>

"Example: 
"gCtrl aa - increment visually selected block plus +1 next number plus +2, ...
"Ctrl aa  - increments everything +1
xnoremap <expr> <c-a> "\<esc>'<V'>".v:count1."\<c-a>"

let g:vimspector_enable_mappings = 'HUMAN'
source $HOME/.config/nvim/plug-config/coc.vim

" Vimspector
" pip3 install --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org  pynvim jedi

iab bashh 
\<CR>```bash
\<CR>
\<CR>```<ESC>ki

iab yamll 
\<CR>```yaml
\<CR>
\<CR>```<ESC>ki

iab eoff 
\<CR>cat <<'EOF' > filename
\<CR>
\<CR>EOF<ESC>ki

iabbrev iii {{<image src="images/blog/np-1.png">}}

" Setup Hugo post 
let g:hugo_path = "~/Documents/hugo/devopsinuse/hugo"
let g:hugo_post_dirs = "/content/english/blog/ckad/"
let g:hugo_post_suffix = "md"
let g:hugo_title_pattern = "[ '\"]"
