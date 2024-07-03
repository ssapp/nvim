" Initialize plugin manager (vim-plug)
call plug#begin('~/.vim/plugged')

" List of plugins
Plug 'fatih/vim-go'                                " Go development plugin
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}   " Language Server Protocol (LSP) client
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder
Plug 'junegunn/fzf.vim'                            " FZF integration for Vim
Plug 'stsewd/fzf-checkout.vim'                     " FZF integration for Git branches
Plug 'preservim/nerdtree'                          " File system explorer
Plug 'jiangmiao/auto-pairs'                        " Auto-close pairs
Plug 'tpope/vim-fugitive'                          " Git integration
Plug 'nvim-lua/plenary.nvim'                       " Lua functions used by lots of plugins
Plug 'NeogitOrg/neogit'                            " Magit clone for Neovim
Plug 'voldikss/vim-floaterm'                       " Floating terminal manager
Plug 'charlespascoe/vim-go-syntax'                 " Go syntax highlighting
Plug 'doums/darcula'                               " Darcula color scheme
call plug#end()

" General settings
set expandtab              " Use spaces instead of tabs
set shiftwidth=4           " Shift 4 spaces when tab
set tabstop=4              " 1 tab = 4 spaces
set signcolumn=yes:2       " Always show sign column
set number                 " Show line numbers
set termguicolors          " Enable true color support
set undofile               " Enable persistent undo
set spell                  " Enable spell checking
set title                  " Show file title in terminal title bar
set ignorecase             " Ignore case in search patterns
set smartcase              " Override ignorecase if search pattern contains uppercase letters
set wildmode=longest:full,full " Command-line completion mode
set nowrap                 " Do not wrap long lines
" set list                   " Show invisible characters
set mouse=a                " Enable mouse support
set scrolloff=8            " Minimum number of screen lines to keep above and below the cursor
set sidescrolloff=8        " Minimum number of screen columns to keep to the left and right of the cursor
set nojoinspaces           " Prevents adding two spaces after a period with join command
set splitright             " Vertical splits open to the right
set clipboard=unnamedplus  " Use system clipboard
set confirm                " Ask for confirmation instead of erroring
set exrc                   " Enable project-specific .vimrc files
set hidden                 " Allow switching buffers without saving
set cmdheight=2            " More space in the command line for displaying messages
set updatetime=300         " Faster completion (default is 4000 ms)
set shortmess+=c           " Don't pass messages to |ins-completion-menu|
set signcolumn=yes         " Always show the sign column

" Leader key
let mapleader=" "  " Set Leader key to SPACE

" Color scheme
colorscheme darcula

" CoC (Conquer of Completion) settings
inoremap <silent><expr> <c-space> coc#refresh()  " Trigger completion
nmap <silent> [c <Plug>(coc-diagnostic-prev)     " Navigate to previous diagnostic
nmap <silent> ]c <Plug>(coc-diagnostic-next)     " Navigate to next diagnostic
nmap <silent> gd <Plug>(coc-definition)          " Go to definition
nmap <silent> gy <Plug>(coc-type-definition)     " Go to type definition
nmap <silent> gi <Plug>(coc-implementation)      " Go to implementation
nmap <silent> gr <Plug>(coc-references)          " Find references
nnoremap <silent> U :call <SID>show_documentation()<CR>  " Show documentation in preview window
nmap <leader>rn <Plug>(coc-rename)               " Rename symbol
vmap <leader>f  <Plug>(coc-format-selected)      " Format selected region
nmap <leader>f  <Plug>(coc-format-selected)      " Format selected region
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>  " Show all diagnostics
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>  " Manage extensions
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>    " Show commands
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>     " Find symbol in current document
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>  " Search workspace symbols
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>    " Do default action for next item
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>    " Do default action for previous item
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>  " Resume latest Coc list

" FZF settings
let g:fzf_layout = { 'up': '~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5 } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

" Customize the Files command to use rg which respects .gitignore files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

" Add an AllFiles variation that ignores .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

" FZF key mappings
nmap <leader>f :Files<cr>       " Open Files with FZF
nmap <leader>F :AllFiles<cr>    " Open AllFiles with FZF
nmap <leader>b :Buffers<cr>     " List open buffers
nmap <leader>h :History<cr>     " Show command history
nmap <leader>r :Rg<cr>          " Search with ripgrep
nmap <leader>R :Rg<space>       " Search with ripgrep with prompt
nmap <leader>gb :GBranches<cr>  " List git branches

" NERDTree key mappings
nnoremap <leader>n :NERDTreeFocus<CR>    " Focus on NERDTree
nnoremap <C-n> :NERDTree<CR>             " Open NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>       " Toggle NERDTree
nnoremap <C-f> :NERDTreeFind<CR>         " Find current file in NERDTree

" Floaterm key mappings
nnoremap <silent> <F7> :FloatermNew<CR>         " Open new terminal
tnoremap <silent> <F7> <C-\><C-n>:FloatermNew<CR>  " Open new terminal in terminal mode
nnoremap <silent> <F8> :FloatermPrev<CR>        " Go to previous terminal
tnoremap <silent> <F8> <C-\><C-n>:FloatermPrev<CR>  " Go to previous terminal in terminal mode
nnoremap <silent> <F9> :FloatermNext<CR>        " Go to next terminal
tnoremap <silent> <F9> <C-\><C-n>:FloatermNext<CR>  " Go to next terminal in terminal mode
nnoremap <silent> <F12> :FloatermToggle<CR>     " Toggle terminal
tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>  " Toggle terminal in terminal mode

" Go plugin settings
let g:go_def_mapping_enabled = 0  " Disable default Go definition mapping

" CoC settings for Enter key
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"  " Accept completion or format

