" vimrc -- lovingly maintained since 2009 by lonetwin <steve@lonetwin.net>
" vim:textwidth=100


" Initialization stuff
" ====================

exe has('python3')

" Call pathogen
let g:pathogen_disabled = []
call pathogen#infect()

"Turn syntax highlighting on.
syntax on

" Turn on filetype detection, plugin loading and indent
filetype plugin indent on

" Load matchit plugin
packadd! matchit

" Customization options
" =====================

" visual options
set background=dark             " Makes syntax highlighting lighter.
if has('gui_running')
    colorscheme desert
else
    exe empty($TRANSPARENT_TERM) ? 'colorscheme busierbee' : 'colorscheme transparent'
endif
set laststatus=2                " Always show a statusbar.
set noshowmode                  " Hide the line showing the mode since that's part of our statusbar
set modeline                    " Respect the file's 'modeline' if it has been defined
set title                       " Set the terminal title
set titleold=                   " Don't default terminal title to "Thanks for flying vim" on exit
set scrolloff=5                 " The offset at which we start scrolling
set splitright                  " Default vsplit to the right
set warn                        " Give a warning message when a shell command is used while the
                                " buffer has been changed.
if &term =~ '256color'          " Disable Background Color Erase (BCE) so that color schemes render
    set t_ut=                   " properly when inside 256-color tmux and GNU screen. see also
endif                           " http://snk.tuxfamily.org/log/vim-256color-bce.html

" editing behavior
set textwidth=80                  " Set a default textwidth
set wrap                          " wrap text at textwidth
set backspace=eol,start,indent    " Backspace over eol, start of line and indents
set nostartofline                 " Don't move cursor to first non-blank position when jumping with
                                  " commands like gg
set cindent                       " Autoindent using cindent'ing rules (better than autoindent or
                                  " smartindent but less flexible than indentexpr)
set tabstop=8                     " Tabs (ASCII 0x09) are always 8 characters !!!
set expandtab                     " Use spaces instead of tabs for indentation
set smarttab                      " ...but do it smartly. ":help st" for more info
set preserveindent                " ...however, don't mess with existing indents
set softtabstop=4 shiftwidth=4    " ...and use 4 spaces at at time to fill in tabbed indent levels
set selection=exclusive           " In visual mode, do not select character under cursor
set showmatch                     " Show matching parens/brackets
set nojoinspaces                  " When joining lines insert only 1 space after a '.' or '?' or '!'
set formatoptions+=j              " Delete comment character when joining commented lines
set pastetoggle=<F2>              " Mapping to take care of disabling ai and si when pasting text.
set clipboard=unnamedplus,unnamed " Make the contents of the yank/copy/deleted text available to the
                                  " X clipboard

" search behavior
set incsearch                   " Show the matches as we type them out
set hlsearch                    " Highlight all matches of the last search pattern
set ignorecase                  " Ignore case in search pattern

" history and backup
set history=100                 " Keep command history
set autowrite                   " Autosave changes when moving out of the buffer temporarily
set backup                      " Keep backup of files
set backupdir=$HOME/tmp/vimbkup " ...here's where to keep 'em
set undofile                    " Save undo's after file closes
set undodir=$HOME/.vim/undo     " ...here's where to save undo histories
set undolevels=1000             " ...here's how many undos to save
set undoreload=10000            " ...here's the number of lines to save for undo

" Completion options
set spell spelllang=en_us                " We no how to spelle (highlight and CTRL-X_S completion)
set dictionary+=/usr/share/dict/words    " Add a dictionary (CTRL-X_CTRL_D completion)
set thesaurus+=./mthesaur.txt            " Add a thesaurus (CTRL-X_CTRL_T completion)
set wildignore+=*.swp,*.pyc,*.o,*.pdf    " In command-mode, skip over these when completing paths
set wildignore+=*.ico,*.png,*.jpg,*.gif
set wildignore+=.git/*
set wildmenu                             " In command-mode, show a 'menu' for completion
set wildmode=longest:full,full           " In command-mode, complete until the longest common
                                         " prefix and show menu of full matches, then cycle thru'
                                         " menu of matches
set completeopt=menuone,longest,noselect " In insert-mode, always show a menu, complete until the
                                         " longest common prefix but don't automatically select
set infercase                            " Infer case for completion. Needed because we've set
                                         " ignorecase for searches

" Other options
set cryptmethod=blowfish2       " default encryption method to use with -x

" Global variables
" ================

" Highlight leading/trailing space errors
let g:c_space_errors = 1

" Python specific stuff
let g:python_highlight_all = 1
let g:pep8_text_width = 119
let g:pep8_comment_text_width = 72


" Mappings
" ========

" Make the up and down movements move by "display" lines:
map j gj
map k gk

" Remap keystroke for switch to Ex-mode (which is never used) to quit all which is used more
" frequently than never
map Q :qa<CR>
command -nargs=0 -bang Q qa

" Remap 'only window' to split in tab
map <C-W>o :tab split<CR>

" execute macro stored in register q (qq to start recording)
nnoremap <Space> @q

" Toggle line numbers
map <Leader>n :set number! relativenumber!<CR>

" Toggle list
map <Leader>l :set list!<CR>

" Keep search matches in the middle of the screen
" http://vimrcfu.com/snippet/175
nnoremap n nzz
nnoremap N Nzz

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" write with sudo using :w!!
cmap w!! w !sudo tee > /dev/null %

" Esc for going to Normal mode from terminal mode
tnoremap <Esc> <C-\><C-n>


" Plugins
" =======
" Load packaged plugins we need always, irrespective of filetype
"
" man plugin (I need it all the time, even when mailing mom)
runtime! ftplugin/man.vim

" matchit plugin packaged with the default vim
runtime! macros/matchit


" Plugin options
" ==============

" auto-pairs
" - don't look for closing pair beyond current line
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutFastWrap = "<C-e>"

" cbackup
let g:backup_directory=expand("$HOME/tmp/vimbkup/cbackup")
let g:backup_purge=20

" SuperTab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabRetainCompletionDuration = 'completion'
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 1
autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \ endif

" jedi
" show call signatures in the command line instead of pop-up
let g:jedi#show_call_signatures = 2

" don't modify completeopt to menuone,longest,preview
let g:jedi#auto_vim_configuration = 0

" use tabs for go-to/show-definition/related-names
let g:jedi#use_tabs_not_buffers = 1


" taglist
" - close when taglist is the only open window
let g:Tlist_Exit_OnlyWindow = 1

" markdown
let g:vim_markdown_folding_disabled = 1

" lightline
let g:lightline = {
    \ 'active': {
    \   'left': [['mode', 'paste'],
    \            ['fugitive', 'virtualenv', 'readonly', 'filename', 'modified']]
    \   },
    \   'component': {
    \       'filename': '%f',
    \   },
    \   'component_function': {
    \       'fugitive': 'LightlineFugitive',
    \       'virtualenv': 'virtualenv#statusline'
    \   },
    \ }

function! LightlineFugitive()
    return exists('*fugitive#head') ? 'λ ' . (fugitive#head() == 'master' ? '(∙)' : fugitive#head()) : ''
endfunction

" virtualenv
let g:virtualenv_stl_format = 'ε ' . fnamemodify($HACKON_ENV, ':t')

function! UpdatePathForHackonEnv()
    if !empty($HACKON_ENV)
        setlocal path=.,,$HACKON_ENV/src/**/
        if !empty($VIRTUAL_ENV)
            let additional_path = systemlist("grep '^/' " . glob('$VIRTUAL_ENV/lib/python???/site-packages/_virtualenv_path_extensions.pth'))
            if !empty(additional_path)
                let &path = &path . ',' . join(additional_path, "/**/,") . '/**/'
            endif
        endif
    endif
endfunction


" Autocommands
" ============

augroup localconfig
    " avoid multiple definition on reloads
    autocmd!

    " Common stuff
    " - when editing a file, always jump to the last cursor position
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif

    " - let terminal resize scale the internal windows
    autocmd VimResized * :wincmd =

    " Filetype specific
    " - make files
    autocmd BufNewFile,BufRead Makefile*
        \ setlocal noexpandtab |
        \ setlocal softtabstop=0

    " - spec files
    autocmd BufNewFile,BufRead *.spec
        \ let packager = "Steven Fernandez <lonetwin@fedoraproject.org>"
    autocmd BufNewFile *.spec
        \ 0r $HOME/.vim/template.spec | ks | call NewSpec() | 's
        fun NewSpec()
            exe "g/Name:/s/Name:/Name:\t\t" . expand("%:t:r")
        endfun

    " - nginx files
    autocmd BufNewFile,BufRead *nginx/* set ft=nginx

    " python files
    autocmd BufNewFile *.py
        \ 0put =\"#!/usr/bin/env python\<nl># -*- coding: utf-8 -*-\<nl>\"|$

    autocmd BufNewFile,BufRead *.py call UpdatePathForHackonEnv()

    " - html/templates -- turn off textwidth
    autocmd BufNewFile,BufRead *.pt,*.html set textwidth=0

    " - treat .zcml as xml
    autocmd BufNewFile,BufRead *.zcml set ft=xml

    " - set custom formatprg for some filetypes
    " Note to self: vim is not too good at detecting json files, make sure ft is set!
    autocmd Filetype json setlocal formatprg=python\ -m\ json.tool
    autocmd Filetype xml setlocal formatprg=xmllint\ --format\ -

    " - set up omni-completion if a specific plugin doesn't already exist for
    "   the filetype
    autocmd Filetype *
        \ if &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif

    " - convenience when editing rst files
    autocmd BufNewFile,BufRead *.rst
        \ setlocal textwidth=80 |
        \ setlocal suffixesadd=.rst

    " Vagrant file
    autocmd BufNewFile Vagrantfile 0r $HOME/.vim/template.vagrantfile

    " Office stuff -- start
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal textwidth=78
    " Office stuff -- end

augroup END

" Custom commands
" ===============

" Custom command to write a copy of the currently opened file to a different
" path on every write. This is useful, for instance, when you have sshfs
" mounted paths from multiple systems and need to keep a copy of the same file
" sync'd on all systems
command -nargs=1 -complete=dir DuplicateAt autocmd BufWritePost * w! <args>%

" See diff between current buffer and the file it was loaded from (*not* across writes !)
" (tip from :help DiffOrig )
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
	 	\ | diffthis | wincmd p | diffthis

" Custom functions
" ================

" Session Management
function SaveSession()
    if (winnr('$') > 1 || tabpagenr('$') > 1) && !&diff
        " we have more than one windows or tabs open, ask whether we want
        " to save the session.
        let save_sesssion = confirm("Save session ? ", "&yes\n&no", 1)
        if save_sesssion == 1
	    call inputsave()
            let session_fl = input("save as: ", getcwd()."/.session.vim", "file")
            call inputrestore()
            execute 'mksession!' session_fl
        endif
    endif
endfunction

function LoadSession()
    if argc() != 0
        return
    endif
    let session_fl = getcwd()."/.session.vim"
    if filereadable(session_fl)
        let load_sesssion = confirm("Load session from '".session_fl."'?", "&yes\n&no\nload and delete\ndelete", 1)
        if load_sesssion == 1 || load_sesssion == 3
            execute 'source' session_fl
        endif
        if load_sesssion == 3 || load_sesssion == 4
            call system('unlink '.session_fl)
        endif
    endif
endfunction

au VimLeavePre * call SaveSession()
au VimEnter * call LoadSession()

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
