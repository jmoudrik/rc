" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"

set nocompatible
filetype off

"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

" let Vundle manage Vundle
" required! 
" Bundle 'gmarik/vundle'

" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" pozor, musel jsem nainstalovat patched font z
" https://github.com/powerline/fonts.git
set guifont=Terminus\ \(TTF\)\ Medium\ 15
"set guifont=Terminess\ Powerline\ 10
"set guifont=Terminus\ for\ Powerline\ 10 
" Always show the status line
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

"Plugin 'moorereason/vim-markdownfmt'
"Bundle 'leafgarland/typescript-vim'
"Bundle 'altercation/vim-colors-solarized'

"Bundle 'scrooloose/nerdtree'
"map <F2> :NERDTreeToggle<CR>
" NERDTress File highlighting
"
"Bundle 'klen/python-mode'
"let g:pymode_rope = 0
"" Documentation
"let g:pymode_doc = 1
"let g:pymode_doc_key = 'K'
""Linting
"let g:pymode_lint = 0
"let g:pymode_lint_checker = "pyflakes,pep8"
"" Auto check on save
"let g:pymode_lint_write = 0
"" Support virtualenv
"let g:pymode_virtualenv = 1
"" Enable breakpoints plugin
"let g:pymode_breakpoint = 1
"let g:pymode_breakpoint_bind = '<leader>b'
"let g:pymode_breakpoint_cmd = 'import ipdb; ipdb.set_trace()  # XXX BREAKPOINT'
"
"
"" syntax highlighting
"let g:pymode_syntax = 1
"let g:pymode_syntax_all = 1
"let g:pymode_syntax_indent_errors = g:pymode_syntax_all
"let g:pymode_syntax_space_errors = g:pymode_syntax_all
"" Don't autofold code
"let g:pymode_folding = 0
"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
"let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pepa pridal: kvuli kontext menu pro spell
set mousemodel=popup

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
"set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
"set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
set background=dark
colorscheme desert
"colorscheme solarized

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set swapfile
"set directory^=~/.vim/swap//

set writebackup
"set backupcopy=auto
set backupdir^=~/.vim/backup//

" persist the undo tree for each file
"set undofile
"set undodir^=~/.vim/undo//


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
autocmd Filetype python setlocal expandtab

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown


set tabstop=4
set shiftwidth=4

" number the lines
set nu

" Linebreak on 500 characters
"set lbr
"set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"pepovo
map <F8> :nohls<CR>
map <F9> :set paste!<bar>set paste?<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <c-space> ?

" Disable highlight when <leader><cr> is pressed
"map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Close the current buffer
"map <leader>bd :Bclose<cr>

" Close all the buffers
"map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew 
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
"autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
"vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
"map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
"map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
"vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
"map <leader>cc :botright cope<cr>
"map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
"map <leader>n :cn<cr>
"map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
"map <leader>sn ]s
"map <leader>sp [s
"map <leader>sa zg
"map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
"map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
"map <leader>pp :setlocal paste!<cr>

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! CmdLine(str)
"    exe "menu Foo.Bar :" . a:str
"    emenu Foo.Bar
"    unmenu Foo
"endfunction
"
"function! VisualSelection(direction) range
"    let l:saved_reg = @"
"    execute "normal! vgvy"
"
"    let l:pattern = escape(@", '\\/.*$^~[]')
"    let l:pattern = substitute(l:pattern, "\n$", "", "")
"
"    if a:direction == 'b'
"        execute "normal ?" . l:pattern . "^M"
"    elseif a:direction == 'gv'
"        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
"    elseif a:direction == 'replace'
"        call CmdLine("%s" . '/'. l:pattern . '/')
"    elseif a:direction == 'f'
"        execute "normal /" . l:pattern . "^M"
"    endif
"
"    let @/ = l:pattern
"    let @" = l:saved_reg
"endfunction


" Don't close window, when deleting a buffer
"command! Bclose call <SID>BufcloseCloseIt()
"function! <SID>BufcloseCloseIt()
"   let l:currentBufNum = bufnr("%")
"   let l:alternateBufNum = bufnr("#")
"
"   if buflisted(l:alternateBufNum)
"     buffer #
"   else
"     bnext
"   endif
"
"   if bufnr("%") == l:currentBufNum
"     new
"   endif
"
"   if buflisted(l:currentBufNum)
"     execute("bdelete! ".l:currentBufNum)
"   endif
"endfunction

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" dokumenty
au VimEnter *  call NERDTreeHighlightFile('doc', 'Red', 'none', '#ffa500', '#151515')
au VimEnter *  call NERDTreeHighlightFile('docx', 'Red', 'none', '#ffa500', '#151515')
au VimEnter *  call NERDTreeHighlightFile('pdf', 'Red', 'none', '#ffa500', '#151515')
au VimEnter *  call NERDTreeHighlightFile('odt', 'Red', 'none', '#ffa500', '#151515')
au VimEnter *  call NERDTreeHighlightFile('ods', 'Red', 'none', '#ffa500', '#151515')

" archivy
au VimEnter *  call NERDTreeHighlightFile('zip', 'green', 'none', 'green', '#151515')
au VimEnter *  call NERDTreeHighlightFile('tar', 'green', 'none', 'green', '#151515')
au VimEnter *  call NERDTreeHighlightFile('gz', 'green', 'none', 'green', '#151515')
au VimEnter *  call NERDTreeHighlightFile('7z', 'green', 'none', 'green', '#151515')
au VimEnter *  call NERDTreeHighlightFile('rar', 'green', 'none', 'green', '#151515')
au VimEnter *  call NERDTreeHighlightFile('bz2', 'green', 'none', 'green', '#151515')

" zdrojaky
au VimEnter *  call NERDTreeHighlightFile('py', 'cyan', 'none', 'cyan', '#151515')
au VimEnter *  call NERDTreeHighlightFile('sh', 'cyan', 'none', 'cyan', '#151515')
au VimEnter *  call NERDTreeHighlightFile('cpp', 'cyan', 'none', 'cyan', '#151515')
au VimEnter *  call NERDTreeHighlightFile('c', 'cyan', 'none', 'cyan', '#151515')
au VimEnter *  call NERDTreeHighlightFile('ts', 'cyan', 'none', 'cyan', '#151515')

au VimEnter *  call NERDTreeHighlightFile('html', 'magenta', 'none', 'magenta', '#151515')

au VimEnter *  call NERDTreeHighlightFile('js', 'green', 'none', 'green', '#151515')

" textovy ne-zdrojaky
au VimEnter *  call NERDTreeHighlightFile('tex', 'yellow', 'none', 'yellow', '#151515')
au VimEnter *  call NERDTreeHighlightFile('md', 'yellow', 'none', 'yellow', '#151515')
au VimEnter *  call NERDTreeHighlightFile('txt', 'yellow', 'none', 'yellow', '#151515')
au VimEnter *  call NERDTreeHighlightFile('csv', 'yellow', 'none', 'yellow', '#151515')
au VimEnter *  call NERDTreeHighlightFile('css', 'yellow', 'none', 'yellow', '#151515')
au VimEnter *  call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
au VimEnter *  call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
au VimEnter *  call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
au VimEnter *  call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')




