" plugins
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin("~/.config/nvim/plugged")
  " Plugin Senohlsearchction
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin' 
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'psliwka/vim-smoothie'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
"Plug 'puremourning/vimspector'
"Plug 'sagi-z/vimspectorpy', { 'do': { -> vimspectorpy#update() } }
Plug 'szw/vim-maximizer'
call plug#end()

set number
set relativenumber
set cursorline
set statusline=%f
hi CursorLine ctermbg=237

colorscheme gruvbox
let g:fzf_action = { 'enter': 'tabedit' }
" make sure to install bat, riggrep

command W :execute ':silent w !sudo tee % > /dev/null' | :edit!


" Working
"command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)


let g:fzf_layout = { 'down': '~40%' }
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <C-p> :Files<CR>
"nnoremap <silent> <Leader>f :Rg<CR>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
set hlsearch

map <C-K> :bprev <CR>
map <C-J> :bnex <CR>

" quick .vimrc access with ,v
let $NEOVIM = "~/.config/nvim/init.vim"
let mapleader = ","
nmap <leader>v :tabedit $NEOVIM<CR>
nmap <leader>a :ls<CR>
map <C-r> :source $NEOVIM<CR>
nmap <C-f> :Files<CR>

nmap <leader>ss :nohlsearch<CR>
nmap <leader>tt :tabonly<CR>

nmap <leader>x :!xclip -selection c %<CR><CR>
"nmap gx yiW:!xdg-open <c-r>" & <CR><CR>
"source $HOME/.config/nvim/plug-config/coc.vim


" https://github.com/puremourning/vimspector#human-mode
" e.g. F5 to start debugging, F9 to toggle breakpoint, F10to step over.
"let g:vimspector_enable_mappings = 'HUMAN'
"nmap <leader>vl :call vimspector#Launch()<CR>
"nmap <leader>vr :VimspectorReset<CR>
"nmap <leader>ve :VimspectorEval
"nmap <leader>vw :VimspectorWatch
"nmap <leader>vo :VimspectorShowOutput
"nmap <leader>vi <Plug>VimspectorBalloonEval
"xmap <leader>vi <Plug>VimspectorBalloonEval
"let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]

"Example: 
"gCtrl aa - increment visually selected block plus +1 next number plus +2, ...
"Ctrl aa  - increments everything +1
xnoremap <expr> <c-a> "\<esc>'<V'>".v:count1."\<c-a>"


set statusline +=" %F"

"let g:vimspectorpy#launcher = "xterm"
"let g:ycm_semantic_triggers =  {'VimspectorPrompt': [ '.', '->', ':', '<' ]}

"autocmd BufEnter * lcd %:p:h
