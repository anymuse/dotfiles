" General behaviour_______________________________________
" Automatic reloading of .vimrc
autocmd! BufWritePost .vimrc source %
" Syntax highlighting
syntax on
" Remove old compatible mode
set nocompatible hidden
" Set encoding
set encoding=utf-8
set ruler
" Cursor enlightenment
"set cuc cul
hi CursorColumn term=underline cterm=underline guibg=#F4F4F4
hi! link CursorLine CursorColumn
" Set scrolling visibility to 3 lines
set scrolloff=3
" Fast TTY (not using minicom)
set ttyfast
" Reduce ESC's delay
set timeoutlen=250
" Change leader
let mapleader=","
" History in command line mode
set history=200
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Search___________________________________________________
" Case management when searching (replacing)
set ignorecase smartcase
" Highlighted and incremental search
set hlsearch incsearch
" Search regexp in 'very magic'
" PEM nnoremap / /\v
" PEM vnoremap / /\v
" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
" Reduce time for matching
set matchtime=2
" Folding__________________________________________________
set foldlevelstart=0
" Enter to toggle folds.
"nnoremap <Enter> za
"vnoremap <Enter> za
function! MyFoldText()
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart
  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()
" Backup___________________________________________________
set nowritebackup nobackup
set directory=/tmp// " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
" Plugins__________________________________________________
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Vim AirLine (lightwieght powerline)
Bundle 'bling/vim-airline'
let g:airline_powerline_fonts=1
" Augment plugins language capabilities
Bundle 'L9'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tlib'
" Themes
Bundle 'altercation/vim-colors-solarized'
"set t_Co=256
"set background=light
set background=dark
colo solarized
"let g:solarized_contrast='high'
"let g:solarized_visibility='high'
" See tab indendation
Bundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=white
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgrey
" Comment line selected in visual mode: best combo: <Leader>c<Space>
Bundle 'scrooloose/nerdcommenter'
" Changes the project's working directory to the project root when opening a file
Bundle 'airblade/vim-rooter'
let g:rooter_use_lcd=1
" Let Vundle manage Vundle: Use :BundleInstall to install all plugins
Bundle 'gmarik/vundle'
" Press '<leader>ce'(':ColorVEdit') in 'LightSlateGray'
Bundle 'Rykka/colorv.vim'
" Automatic 'end' on Ruby, 'fi/endif' on bash or vi, ...
Bundle 'tpope/vim-endwise'
" Better keyword completion
"Bundle 'Shougo/neocomplcache'
"let g:neocomplcache_enable_at_startup=1
" NodeJS dictionnary
Bundle 'guileen/vim-node'
au FileType javascript set dictionary+=$HOME/.vim/bundle/vim-node/dict/node.dict
" Better indendation support for Javascript
Bundle "pangloss/vim-javascript"
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
" CoffeScript provides CoffeeMake
Bundle 'kchmck/vim-coffee-script'
let coffee_make_options = '--bare -o ~/tmp' " compile without top-level function: usefull for syntax checks
let coffee_compiler = '/usr/local/bin/coffee' " useful for changing compiler to IcedCoffee
au BufWritePost *.coffee silent make
let coffee_lint_options='-f ~/.coffeelint.json'
let coffee_linter='/usr/local/bin/coffeelint'
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
Bundle 'mintplant/vim-literate-coffeescript'
" Better JSON syntax highlighting
Bundle 'elzr/vim-json'
" Fork of a.vim for CoffeeScript: Switch from JS to Coffee (or h to c for C) with :A or :AS
Bundle 'clvv/a.vim'
" Jasmine support for Coffeescript and Javascript
Bundle 'claco/jasmine.vim'
" Cucumber support
Bundle 'tpope/vim-cucumber'
" Brunch : Fast Backbone & Coffeescript dev framewwork
Bundle 'drichard/vim-brunch'
" Grunt
Bundle 'mklabs/grunt.vim'
" CtrlP Fast fuzzy search. Use it with <C-p>
Bundle 'kien/ctrlp.vim'
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = '~/tmp/cache/ctrlp'
set wildignore+=node_modules,bower_components,tmp,build,dist
" Add closing parenthesis, bracket, quotes
Bundle 'Raimondi/delimitMate'
au FileType mail let b:delimitMate_autoclose=0
" Add closing tag support for HTML and XML
Bundle 'closetag.vim'
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,xsd,wsdl,htmldjango,jinjahtml,eruby,mako,byt source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
" Completion with <Tab>
"Bundle 'ervandew/supertab'
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
"let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
" Better terminal support of colors
" Bundle 'godlygeek/csapprox'
" Change surrounding: 'test' -> <p>test</p> : cs'<p>
Bundle 'tpope/vim-surround'
" Show marks for fast code jumps
Bundle 'ShowMarks'
nmap <F2> :ShowMarksToggle<CR>
let g:showmarks_enable=0 " avoid automatically showing marks
" Completion with tab in search window
Bundle 'SearchComplete'
" JQuery tag completion
Bundle 'firat/tagcomplete'
" File system explorer
Bundle 'scrooloose/nerdtree'
autocmd vimenter * if !argc() | NERDTree | endif " open Nerdtree if no file specified at start
nmap <F3> :NERDTreeToggle<CR>
let NERDTreeWinSize=25
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
" MBE - MiniBufferEXplorer
"Bundle 'fholgado/minibufexpl.vim'
"map <F5> :TMiniBufExplorer<CR>
"let g:miniBufExplMaxSize=1            " Only one line for MBE
"let g:miniBufExplMapWindowNavVim=1    " Map <C-[hjkl]> to window movement
"let g:miniBufExplMapWindowNavArrows=1 " Map <C-[Left,Right]> to window movement
"let g:miniBufExplMapCTabSwitchWindows=1 " Same thing as buffers but for windows
"let g:miniBufExplUseSingleClick=1     " Use single click for opening any buffer
"let g:miniBufExplModSelTarget=1       " Accomodating MBE with TagBar and TagList
"let g:miniBufExplCloseOnSelect=1      " Close MBE on buffer selection
" Ag is available here: https://github.com/ggreer/the_silver_searcher
Bundle 'rking/ag.vim'
map <C-F> :Ag! 
" Syntax for AS files
Bundle 'endel/flashdevelop.vim'
" Syntax for NGinx configuration files
"Bundle 'andersjanmyr/nginx-vim-syntax'
" Align selected text in visual mode on a parttern. Example with a =: :Tab /=
Bundle 'godlygeek/tabular'
" Git plugins : syntax and commands: Gbrowse, Gstatus, Gcommit, ...
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
" Powerline: Status line
" Bundle 'Lokaltog/powerline'
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
  autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
set laststatus=2
set noshowmode
" Support for C/C++ block highlighting in {}
Bundle 'BlockHL'
" Syntax for MarkDown files
Bundle 'tpope/vim-markdown'
" Syntax for JADE files
Bundle 'digitaltoad/vim-jade'
" Syntax for CSS3 files
Bundle 'skammer/vim-css-color'
Bundle 'hail2u/vim-css3-syntax'
" Syntax for LESS files
Bundle 'groenewege/vim-less'
" Syntax for STYLUS files
Bundle 'wavded/vim-stylus'
" Syntax for HTML5 files
Bundle 'othree/html5.vim'
" Emmet (simplify HTML and CSS writings like snipmate on steroids), works also
" in Chrome Dev Tools
Bundle 'mattn/emmet-vim'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" Snippets
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle 'Jasmine-snippets-for-snipMate'
Bundle 'carlosvillu/coffeScript-VIM-Snippets'
" Analyse CTags and present them in a window
Bundle 'majutsushi/tagbar'
"autocmd VimEnter * nested :call tagbar#autoopen(1) " Auto open tagbar for handled files
let g:tagbar_width=25
let g:tagbar_autoshowtag=1
let g:tagbar_compact=1
map <F4> :TagbarToggle<CR>
map <F8> :let x = system('ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . >/dev/null 2>&1')<CR>
" Better tags definition: brew install ctags-exuberant
set tags=./tags,tags;/
" Better JS support via DoctorJS: npm install -g jsctags
let g:tagbar_type_javascript = {
  \ 'ctagsbin' : '/usr/local/bin/jsctags'
  \ }

" CoffeeScript : gem install coffeetags
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '--include-vars',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif
" Posix regular expressions for matching interesting items. Since this will 
" be passed as an environment variable, no whitespace can exist in the options
" so [:space:] is used instead of normal whitespaces.
" Adapted from: https://gist.github.com/2901844
"let s:ctags_opts = '
  "\ --langdef=coffee
  "\ --langmap=coffee:.coffee
  "\ --regex-coffee=/(^|=[ \t])*class ([A-Za-z_][A-Za-z0-9_]+\.)*([A-Za-z_][A-Za-z0-9_]+)( extends ([A-Za-z][A-Za-z0-9_.]*)+)?$/\3/c,class/
  "\ --regex-coffee=/^[ \t]*(module\.)?(exports\.)?@?(([A-Za-z][A-Za-z0-9_.]*)+):.*[-=]>.*$/\3/m,method/
  "\ --regex-coffee=/^[ \t]*(module\.)?(exports\.)?(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=.*[-=]>.*$/\3/f,function/
  "\ --regex-coffee=/^[ \t]*(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=[^->\n]*$/\1/v,variable/
  "\ --regex-coffee=/^[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=[^->\n]*$/\1/f,field/
  "\ --regex-coffee=/^[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+):[^->\n]*$/\1/f,static field/
  "\ --regex-coffee=/^[ \t]*(([A-Za-z][A-Za-z0-9_.]*)+):[^->\n]*$/\1/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?/\3/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){0}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){1}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){2}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){3}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){4}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){5}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){6}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){7}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){8}/\8/f,field/
  "\ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){9}/\8/f,field/'
"let $CTAGS = substitute(s:ctags_opts, '\v\\([nst]\)', '\\\\\1', 'g')
" Markdown support
let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:Heading_L1',
    \ 'i:Heading_L2',
    \ 'k:Heading_L3'
  \ ]
\ }
" Ruby
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
" CSS
let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }
" Syntax error checking
Bundle 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol='⚠'
let g:syntastic_style_warning_symbol='⚠'
" Set plugin to work depending on filetype
filetype plugin indent on " Automatic indentation
filetype plugin on " Add automatic plugins depending on filetype
" Set the default tabulation mode (use CTRL-V<Tab> for a real tab)
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" Line number______________________________________________
" Display line number with a dark backgound a lightly contrasted digits to avoid distraction
set number
"hi LineNr guibg=black guifg=darkgrey
" Mouse support in vim
set mouse=a
" Key binding______________________________________________
" Settings TAB for switching between splitted windows
map <Tab> <C-W>w
map <S-Tab> <C-W>p
" Open pane the same way as tmux, but on <C-w>
map <C-w>- :split<CR>
map <C-w><Bar> :vsplit<CR>
" OmniCompletion___________________________________________
set ofu=syntaxcomplete#Complete
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"
let g:SuperTabDefaultCompletionType='<Tab>'
let g:SuperTabDefaultCompletionType="context"
hi Pmenu    guibg=black
hi PMenuSel guibg=yellow guifg=black gui=bold
set completeopt=longest,menuone,preview
set wildmenu
set wildmode=full
"Add syntax highlighting for filetypes
au BufNewFile,BufRead *.wsdl,*.xsd set filetype=xml
" SyntaxComplete_________________________________________
Bundle 'vim-scripts/SyntaxComplete'
" JavaScript libraries completion
Bundle 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs='jquery,angularjs'
" Clang Complete__________________________________________
"Bundle 'Rip-Rip/clang_complete'
"let g:clang_library_path='/usr/lib/'
"let g:clang_use_library=1
" Vim-Clang_______________________________________________
"Bundle 'vim-clang'
" You Complete Me_________________________________________
Bundle 'Valloric/YouCompleteMe'
" Vertical splitter________________________________________
hi VertSplit guibg=black guifg=darkgrey
set fillchars=vert:\│
"File navigation
map <C-e> <Esc>:Exp<CR>
" Copy and paste___________________________________________
"System copy and paste
"noremap <leader>y "*y
"noremap <leader>yy "*Y
" Preserve indentation while pasting text from system clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
" Yanking (pasting) goes on clipboard
set clipboard+=unnamed
" Wrap_____________________________________________________
" Set wrap to 80 column
set colorcolumn=80
" Highlight text when transgressing the column's limit
"augroup vimrc_autocmds
  "autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  "autocmd BufEnter * match OverLength /\%150v.*/
"augroup END
" Avoid wrapping
set nowrap
set showbreak=↪
" Save_____________________________________________________
" Save readonly files with w!!
cmap w!! w !sudo tee % >/dev/null
" LanguageTool_____________________________________________
Bundle 'vim-scripts/LanguageTool'
let g:languagetool_jar='~/.vim/tools/LanguageTool/LanguageTool.jar'
" Vimux____________________________________________________
Bundle 'benmills/vimux'
" Jedi (Python IDE)________________________________________
Bundle 'davidhalter/jedi-vim'
let g:jedi#popup_on_dot = 0
"let g:jedi#autocompletion_command = "<Tab>"
" Python-mode
"Bundle 'klen/python-mode'
" Vim-Pasta : Meilleur paste
Bundle 'sickill/vim-pasta'
" Quickfixsigns : Ajout de marqueur lors de bookmarks de lignes
Bundle 'tomtom/quickfixsigns_vim'
" Autoclose
Bundle 'Townk/vim-autoclose'
" Unimpaired
Bundle 'tpope/vim-unimpaired'
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" Xiki
" let $XIKI_DIR='/var/lib/gems/1.9.1/gems/xiki-0.6.5'
" source /var/lib/gems/1.9.1/gems/xiki-0.6.5/etc/vim/xiki.vim
" Neo4j and Cypher_________________________________________
Bundle "neo4j-contrib/cypher-vim-syntax"
" Lorem ipsum______________________________________________
Bundle "loremipsum"
" Internal Vim plugin
runtime macros/matchit.vim
" Quickrun: markdown_______________________________________
Bundle 'thinca/vim-quickrun'
Bundle 'mattn/webapi-vim'
Bundle 'tyru/open-browser.vim'
Bundle 'superbrothers/vim-quickrun-markdown-gfm'
let g:quickrun_config = {
\   'markdown': {
\     'type': 'markdown/gfm',
\     'outputter': 'browser'
\   }
\ }
" Dash integration
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
