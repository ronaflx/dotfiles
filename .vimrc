" Vundle setting
" make sure on the top vim .vimrc
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Required
Plugin 'gmarik/Vundle.vim'

" Personal Plugins
" super tab plugin.
Plugin 'ervandew/supertab'
" you complete me plugin, YCM.
Plugin 'ycm-core/YouCompleteMe'
" syntastic plugin, show compiling error.
Plugin 'scrooloose/syntastic'
" NerdTree to navigate file directory.
Plugin 'scrooloose/nerdtree'
" google protobuf highlight.
Plugin 'fhenrysson/vim-protobuf'
" markdown syntax support.
Plugin 'plasticboy/vim-markdown'
" html/js format.
Plugin 'pangloss/vim-javascript'
" vim-airline.
Plugin 'bling/vim-airline'
" vim-tmux.
Plugin 'christoomey/vim-tmux-navigator'
" clang-format.
Plugin 'rhysd/vim-clang-format'
" C++ syntax hightlight.
Plugin 'octol/vim-cpp-enhanced-highlight'

" vim.org/scripts

call vundle#end()            " required
filetype plugin indent on    " required
" Vundle end

" Vundle plugin setting
" YCM
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
" Vundle plugin end

" Don't use Ex mode, use Q for formatting
map Q gq

" set mouse behave ,in xterm windows the middle key is to copy clipboard
behave xterm

" custom setting
set backup              " keep a backup file.
set history=50          " keep 50 lines of command line history.
set ruler               " show the cursor position all the time.
set showcmd             " display incomplete commands.
set incsearch           " do incremental searching.
set cmdheight=1 				" set command line height=1.
set laststatus=2

set backupdir=~/.vim/backup
set directory=~/.vim/swap
set statusline=%F%(\ %m%r%h%w%)\ [%{&ff}]\ [%Y]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}%=[0x%B]\ [%l,%(%c%V%)]\ [%P]
                                                                                 
set number        " set show line numbers.
set cmdheight=1   " set command line height.
set noswapfile    " set no swap files.                                            
set showmatch 		" set showmatch.
set wildmenu 			" set command lines menu.
set autoread
set autowrite
set autochdir
set magic
" custom setting end


" word setting
set backspace=indent,eol,start
set iskeyword=@,48-57,_,192-255 " the keywords are letter _ number and visual Latain latter
" select word under cursor
nnoremap <space> viw
" word setting end

" indent style setting
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set wrap
" indent style setting end

" color setting
colorscheme koehler
set colorcolumn=81
" colorcolumn setting end

" judge the platform is window or linux
if(has("win32") || has("win95") || has("win64") || has("win16"))
	let g:vimrc_iswindows=1
else
	let g:vimrc_iswindows=0
endif
autocmd BufEnter * lcd %:p:h

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

if has("gui_running")
	set lines=72 columns=170
endif
set guifont=Ubuntu\ Mono\ 11
set fileencodings=utf-8,GBK,GB18030,GB2312,usc-bot,latin1,default

"===============Compile & Run the C Program With Input File==========
map <F8> : call Compile_run_gcc_with_input_file()<CR>
func! Compile_run_gcc_with_input_file()
	exec "w"
	if expand("%:e") == "cpp" || expand("%:e") == "cc"
		exec "!clang++ % -o %< -Wall -std=c++14 -stdlib=libc++"
		exec "!%:p:r < %:p:r.in"
	elseif expand("%:e") == "java"
		exec "!javac %"
		exec "!java %< < %:p:r.in"
	elseif expand("%:e") == "py"
		exec "!python % < %:p:r.in"
	endif
endfunc 

"===============Compile & Run the C Program==========
map <F6> : call Compile_run_gcc()<CR>
func! Compile_run_gcc()
	exec "w"
	if expand("%:e") == "cpp" || expand("%:e") == "cc"
		exec "!clang++ % -o %< -Wall -std=c++14 -lpthread"
		exec "! %:p:r"
	elseif expand("%:e") == "c"
		exec "!gcc % -o %< -Wall"
		exec "! %:p:r"
	elseif expand("%:e") == "py"
		exec "!python %"
	elseif expand("%:e") == "java"
		exec "!javac %"
		exec "!java %<" 
	endif
endfunc 

"===============Compile the C Program==========
map <C-F6> : call Compile_gcc()<CR>
func! Compile_gcc()
	make "%:p:r"
endfunc 

map <F7> : call GDB()<CR><CR>
func! GDB()
	exec "! gnome-terminal --workdir %:p:h -e gdb %:p:r 2>&1 >> /dev/null"
endfunc

" clang-format
let g:clang_format#code_style = 'google'
autocmd FileType c ClangFormatAutoEnable
 
" command short-cut setting
let mapleader=","
" remove line in insert mode
inoremap <C-D> <esc>ddi
" to uppercase in insert mode
inoremap <C-U> <esc>^v$~
" vimrc short-cut, nore is short for No Recursion
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
noremap <C-G> :ClangFormat<CR>
inoremap <C-G> <C-O>:ClangFormat<CR>
map <C-N> :NERDTreeToggle<CR>
iabbrev @@ 900831flx@gmail.com
" command short-cut setting end



" html-format
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

