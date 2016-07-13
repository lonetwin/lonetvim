" Steve's vimrc (Modified from the original Mandrake vimrc)
" Steve <lonetwin@yahoo.com>
"
" Notes:
" - the 'set spell' below will only work on vim 7.0 onwards, when spell
"   checking was built-in into vim. If you are using an earlier version of vim
"   install the vimspell.vim plugin
" - use ":help statusline" to understand and modify rulerformat and statusline
" - be sure you change the 'backupdir' and 'dictionary' to suit your preference
" - keybinding you might want to change: pastetoggle, cycle between windows,
"   toggle line numbers

" Use Vim defaults (much better!)
set nocompatible

" Call pathogen
call pathogen#infect()

"Turn syntax highlighting on.
syntax on

" Turn on filetype plugin
filetype on
filetype plugin on
filetype indent on

"Makes syntax highlighting lighter.
set background=dark

"Set the colorscheme - my terminal is usually dark, but i like my gvim
"backgroud white, so i use different colorschemes for vim Vs gvim
if has("gui_running")
   colorscheme desert
else
   colorscheme busierbee
   "map <C-s> :colorscheme random<CR>
endif

"Show the position of the cursor.
set ruler
set rulerformat=%50(%-30(%f%)\ %o,%l,%c%V\ %p%%%)

"Set a statusbar.
set laststatus=2
set noshowmode

" A lot of plugins assume bash like shell
if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif

set textwidth=80
set wrap                        " wrap text at textwidth
set cindent                     " automatically indent following cindent'ing
                                " rules (better than autoindent or smartindent
                                " but less flexible than indentexpr)
set nostartofline               " Maintain cursor position when doing stuff
                                " like gg, d or :copy .
set backspace=eol,start,indent  " Backspace over eol, start of line and indents
set tabstop=8                   " Tabs (ASCII 0x09) are always 8 characters !!!
set softtabstop=4 shiftwidth=4  " default indentation level
set expandtab                   " use spaces instead of tabs for indentation
set smarttab                    " ...but do it smartly. ":help st" for more info
set preserveindent              " ...however, don't mess with existing indents
set selection=exclusive         " In visual mode, do not select character under cursor
set incsearch                   " Show the matches as we type them out
set hlsearch                    " Highlight all matches of the last search pattern
set ignorecase                  " Ignore case in search pattern
set showmatch                   " show matching parens/brackets
set nojoinspaces                " insert only 1 space following a '.' when joining lines
set history=100                 " Keep command history
set autowrite                   " Automatically save changes whenever moving
                                " out of the buffer temporarily
set backup                      " Keep backup of files
set backupdir=$HOME/tmp/vimbkup " where to keep 'em
    " for use with cbackup.vim
    let g:backup_directory=expand("$HOME/tmp/vimbkup/cbackup")
    let g:backup_purge=20
set undofile                    " Save undo's after file closes
set undodir=$HOME/.vim/undo     " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo

set dictionary+=/usr/share/dict/words " For completion
set thesaurus+=$HOME/.mthesaur.txt
set spell spelllang=en_us       " We no how to spelle
set infercase                   " infer case from the case of the pattern being typed
set warn                        " Give a warning message when a shell command
                                " is used while the buffer has been changed.
set modeline                    " Set the 'modeline' if they have been defined
                                " in the file that you are editing
set title                       " Set the terminal title
set scrolloff=5                 " at what offset do we start scrolling
set pastetoggle=<F2>            " Mapping to take care of unsetting ai and
                                " smartindent when pasting text.

" Completion options
" - in command-mode, while doing completion, show all matches
set wildmode=list:longest

" - make the contents of the yank/copy/deleted text available to the X
"   clipboard (NOTE, you need to have +xterm_clipboard support
"   (check :version)). On fedora this comes in if you use `vimx`
set clipboard=unnamedplus,unnamed

" - tell supertab plugin to be context sensitive for completion
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']

" - tell supertab plugin to only complete when there isn't a leading whitespace
let g:SuperTabLeadingSpaceCompletion = 0

" Make the up and down movements move by "display" lines:
map j      gj
map k      gk
map <Down> gj
map <Up>   gk

" Cycle between windows and make active window full size
nmap <CR> <C-W>w<C-W>_

" Toggle line numbers
map <Leader>n :set number! cursorline!<CR>

" Toggle list
map <Leader>l :set list!<CR>

" Source man plugin (I need it all the time, even when mailing mom)
runtime! ftplugin/man.vim

" Stuff that I am picky about:
" - don't automatically ^fix^ leading/trailing space errors in C files ...
let c_space_errors = 1

" autocommands
if has("autocmd")
    " common stuff
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

    " let terminal resize scale the internal windows
    autocmd VimResized * :wincmd =

    " spec files
    autocmd BufNewFile,BufRead *.spec
    \ let packager = "Steven Fernandez <lonetwin@fedoraproject.org>"
    autocmd BufNewFile *.spec
    \ 0r $HOME/.vim/template.spec | ks | call NewSpec() | 's
        fun NewSpec()
            exe "g/Name:/s/Name:/Name:\t\t" . expand("%:t:r")
        endfun

    " nginx files
    autocmd BufNewFile,BufRead *nginx/* set ft=nginx

    " python files
    " - highlight numbers, builtins, standard exceptions and space errors
    " - turn off omni-completion `preview` of the doc string, cos it is
    "   distracts us
    autocmd BufNewFile,BufRead *.py
                \ set ft=python |
                \ let python_highlight_all = 1 |
                \ set completeopt=menu,longest |
                \ let g:pep8_text_width = 119  |
                \ let g:pep8_comment_text_width = 72

    autocmd BufNewFile *.py
                \ 0put =\"#!/usr/bin/env python\<nl># -*- coding: utf-8 -*-\<nl>\"|$

    " html/templates -- turn off textwidth
    " autocmd BufNewFile,BufRead *.html,*.pt set textwidth=0
    autocmd BufNewFile,BufRead *.html,*.pt
        \ set textwidth=0 |
        \ set ft=htmldjango

    " for json files use javascript highlighting
    autocmd BufNewFile,BufRead *.json
                \ set ft=javascript |
                \ map <Leader>j :%!python -m json.tool<CR>

    " treat .zcml as xml
    autocmd BufNewFile,BufRead *.zcml set ft=xml

    " fish files
    autocmd BufNewFile,BufRead *.fish set ft=fish

    " taglist plugin - close when taglist is the only open window
    let Tlist_Exit_OnlyWindow = 1
    let Tlist_Show_One_File = 1

    " - set up omni-completion if a specific plugin doesn't already exist for
    "   the filetype
    autocmd Filetype *
                \ if &omnifunc == "" |
                \       setlocal omnifunc=syntaxcomplete#Complete |
                \ endif

    " Within quickfix buffers, <CR> is used to switch to the next error, so we
    " remove our mapping from above which uses <CR> to cycle-thru-and-maximize the
    " next buffer
    autocmd BufReadPost quickfix nunmap <CR>

    " Office suff -- start
    autocmd BufNewFile,BufRead COMMIT_EDITMSG set textwidth=72
    autocmd BufNewFile,BufRead *.rst set textwidth=80
    " Office suff -- end

endif

" Break bad habits
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

"vim-markdown options
let g:vim_markdown_folding_disabled=1

" Custom command to write a copy of the currently opened file to a different
" path on every write. This is useful, for instance, when you have sshfs
" mounted paths from multiple systems and need to keep a copy of the same file
" sync'd on all systems
command -nargs=1 -complete=dir DuplicateAt autocmd BufWritePost * w! <args>%

function ShowGitHubURL()
    " Function to echo the github URL for the currently open file at the
    " current line number. This is useful if for example, you want to quickly
    " share the URL for the file you're working on via, email / IRC etc.
    "
    " This can also be easily extended to open the browser with the displayed
    " URL using tips such as http://vim.wikia.com/wiki/VimTip306
    "
    " You may add a mapping like this to bind this function to a keystroke:
    " map <Leader>gh :call ShowGitHubURL()<CR>
    "
    " XXX KNOWN ISSUE: file needs to be opened from the 'top' level of the
    " source tree ie: '%' should expand to the filename under the root of the
    " repositories source tree. I don't know (yet) how to fix this.
    " Suggestions/Patches welcome.

    let gh_base = 'github.com'
    let gh_url = system("git remote -v show")
    if strridx(gh_url, gh_base) == -1
        echom "Not within a github repo or github origin not found"
        return
    endif

    " Build the repo's github url
    let remote = split(gh_url)[0]

    let gh_url = split(gh_url, '@')[2]
    let gh_url = split(gh_url)[0]
    let gh_url = substitute(gh_url, ':', '/', '')
    let gh_url = substitute(gh_url, '.git$', '', '')
    let gh_url = 'https://'.gh_url

    " Add the current branch
    let branch = system("git remote show ".remote."| grep 'HEAD branch'")
    let branch = split(branch)[-1]
    let gh_url = gh_url."/blob/".branch

    " Add the current filename and line number
    let gh_url = gh_url . "/" . expand("%") . "#L" . line(".")

    echom gh_url
endfunction

" Session Management
function SaveSession()
    if winnr('$') > 1 || tabpagenr('$') > 1
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

" Move visual block
vnoremap J :m '>+1<CR>gv
vnoremap K :m '<-2<CR>gv

" view and paste from register
" http://vimrcfu.com/snippet/116
function! Reg()
    reg
    echo "Register: "
    let char = nr2char(getchar())
    if char != "\<Esc>"
        execute "normal! \"".char."p"
    endif
    redraw
endfunction
command! -nargs=0 Reg call Reg()

" Keep search matches in the middle of the screen
" http://vimrcfu.com/snippet/175
nnoremap n nzz
nnoremap N Nzz

" See diff between current buffer and the file it was loaded from (*not* across writes !)
" (tip from :help DiffOrig )
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
	 	\ | diffthis | wincmd p | diffthis
