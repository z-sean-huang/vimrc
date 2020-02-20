set nocompatible               " be iMproved
filetype off                   " required!

"-- http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
"-- Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"-- let Vundle manage Vundle
"-- required!
Bundle 'gmarik/vundle'

"-- Bundle Usage:
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

"-- My Bundles here, original repos on github:
"
" GWrite, Gstatus, Gdiff, Glog, Gblame
Bundle 'tpope/vim-fugitive'

" vim-easymotion: <Leader><Leader>w, <Leader><Leader>b
"Bundle 'Lokaltog/vim-easymotion'
"
" status line for vim
Bundle 'Lokaltog/vim-powerline'
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'fancy'
let g:Powerline_stl_path_style = 'full'

" shows a git diff in the gutter (sign column) 
Bundle 'airblade/vim-gitgutter'

Bundle 'kien/ctrlp.vim'
" exchange the CtrlP's shortcut
let g:ctrlp_prompt_mappings = {'AcceptSelection("t")': ['<cr>'], 'AcceptSelection("e")': ['<c-t>'] }

Bundle 'scrooloose/nerdtree'

if !iCanHazVundle
    BundleInstall
endif

filetype plugin indent on       " required!

"-- general:
set nu                          " show line number
"set showmode                    " show current mode
syntax on                       " enable syntax highlighting
set hlsearch                    " highlight search word
set nocindent                   " no c indent
set autoread                    " auto read when file is changed from outside
"set mouse=a                     " mouse support
set clipboard=unnamed           " yank to the system register (*) by default
set ts=4 shiftwidth=4 expandtab " replace tab with 4 spaces

"-- shortcut
noremap <F1> gT<CR>
noremap <F2> gt<CR>
noremap <F3> :TlistToggle <CR> 
noremap <F4> :NERDTreeToggle<CR> 
"noremap <C-c> "ay
"noremap <C-v> "ap


"-- cursorline
se cursorline
hi cursorLine term=none cterm=none ctermbg=4
autocmd InsertLeave * hi cursorLine term=none cterm=none ctermbg=4
autocmd InsertEnter * hi cursorLine term=none cterm=none ctermbg=0
hi comment term=none cterm=none ctermbg=none ctermfg=darkgray

"-- status bar at the bottom, but is replaced by powerline
"
"set statusline=%4*%=\ %1*[%F]
"set statusline+=%4*\ %5*[%{&encoding}, " encoding
"set statusline+=%{&fileformat}%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}]%m
"set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
"highlight User1 cterm=bold ctermfg=white ctermbg=blue

"let NERDTreeMapOpenInTab='\r'
let NERDTreeMapOpenInTab='<ENTER>'


function! Create_cscope_file(execfile)                                           
    exe "! bash" a:execfile a:execfile                                                                  
endfunction

function! Create_cscope_out(cscope_files)                                           
    exe "! cscope -bRq -i" a:cscope_files                                                                  
endfunction

if has("cscope")
    let cscope_exec=findfile("cscope.sh", ".;")
    if !empty(cscope_exec)
        if cscope_exec ==? "cscope.sh"
            set csre
        endif
        "silent call Create_cscope_file(cscope_exec)
        let cscope_files=findfile("cscope.files", ".;")
        if !empty(cscope_files) && filereadable(cscope_files)
            "silent call Create_cscope_out(cscope_files)
            let cscope_out=findfile("cscope.out", ".;")
            if !empty(cscope_out) && filereadable(cscope_out)
                silent exe "cs add" cscope_out
            endif
        endif
    endif
endif


noremap <leader>cs :cs find s 
noremap <C-\>s :tab cs find s <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>g :tab cs find g <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>c :tab cs find c <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>d :tab cs find d <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>t :tab cs find t <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>e :tab cs find e <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>f :tab cs find f <C-R>=expand("<cfile>")<CR><CR>
noremap <C-\>i :tab cs find i <C-R>=expand("<cfile>")<CR><CR>


