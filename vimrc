" vimrc -- lovingly maintained since 2009 by lonetwin <steve@lonetwin.net>
" vim:textwidth=100


" Initialization stuff
" ====================

" Call pathogen
let g:pathogen_disabled = []
call pathogen#infect()

"Turn syntax highlighting on.
syntax on

" Turn on filetype detection, plugin loading and indent
filetype plugin indent on

" Customization options
" =====================
"
" terminal options |'terminal-options'|
let &t_Cs = "\e[4:3m"   " undercurl mode
let &t_Ce = "\e[4:0m"   " undercurl and underline end
let &t_Us = "\e[4:2m"   " double underline mode
let &t_ds = "\e[4:4m"   " dotted underline mode
let &t_Ds = "\e[4:5m"   " dashed underline mode

" visual options
" if has('gui_running')
"     colorscheme desert
" else
"     exe empty($TRANSPARENT_TERM) ? 'colorscheme busierbee' : 'colorscheme transparent'
" endif
" runtime colors/colormod.vim
set background=dark             " Makes syntax highlighting lighter. (needs to come after colorscheme
                                " (https://github.com/mhinz/vim-janah/issues/2#issuecomment-184216367))
" set termguicolors
colorscheme colormod            " Use our own colorscheme built on top of busierbee (in ./colors)
set numberwidth=1               " The minimum width for the number column
set laststatus=2                " Always show a statusbar.
set noshowmode                  " Hide the line showing the mode since that's part of our statusbar
set modeline                    " Respect the file's 'modeline' if it has been defined
set title                       " Set the terminal title
set titleold=                   " Don't default terminal title to "Thanks for flying vim" on exit
set scrolloff=5                 " The offset at which we start scrolling
set splitright                  " Default vsplit to the right of current window
set splitbelow                  " Default split to the bottom of current window
set warn                        " Give a warning message when a shell command is used while the
                                " buffer has been changed.
set fillchars+=vert:│           " Use a vertical bar for vertical splits

if &term =~ '256color'          " Disable Background Color Erase (BCE) so that color schemes render
    set t_ut=                   " properly when inside 256-color tmux and GNU screen. see also
endif                           " http://snk.tuxfamily.org/log/vim-256color-bce.html

" editing behavior
set exrc secure                   " Enable .vimrc in current directory, but ensure only secure
                                  " options are set (eg: no write commands, no shell commands, etc.)
set textwidth=80                  " Set a default textwidth
set wrap                          " wrap text at textwidth
set backspace=eol,start,indent    " Backspace over eol, start of line and indents
set nostartofline                 " Don't move cursor to first non-blank position when jumping with
                                  " commands like gg
set cindent                       " Autoindent using cindent'ing rules (better than autoindent or
                                  " smartindent but less flexible than setting indentexpr (which
                                  " might get set by plugins, in which case this is overriden))
set tabstop=8                     " Tabs (ASCII 0x09) are always 8 characters !!!
set expandtab                     " Use spaces instead of tabs for indentation
set smarttab                      " ...but do it smartly. ":help st" for more info
set preserveindent                " ...however, don't mess with existing indents
set softtabstop=4 shiftwidth=4    " ...and use 4 spaces at a time to fill in tabbed indent levels
set shiftround                    " ...and round indent to a multiple of shiftwidth
                                  " (useful while in moving blocks with < >)
set selection=exclusive           " In visual mode, do not select character under cursor
set showmatch                     " Show matching parens/brackets
set nojoinspaces                  " When joining lines insert only 1 space after a '.' or '?' or '!'
set formatoptions+=j              " Delete comment character when joining commented lines
set pastetoggle=<F2>              " Mapping to take care of disabling ai and si when pasting text.
set clipboard=unnamedplus,unnamed " Make the contents of the yank/copy/deleted text available to the
                                  " X clipboard
set encoding=utf-8
set mouse=a                       " Enable the use of mouse in all modes
set virtualedit=block             " Allow placing the cursor where there are no characters
                                  " (eg: within tabs or past EOL), during block selection
set showcmd                       " Show useful normal mode commands/info in the status line

" search behavior
set incsearch                   " Show the matches as we type them out
set hlsearch                    " Highlight all matches of the last search pattern
set ignorecase smartcase        " Ignore case in search pattern if pattern is lowercase
" set shortmess-=S                " Show search count message when searching
set cscopetag                   " `:tag` should use cscope db
set csto=1                      " ...but lookup tags before cscope db

" history and backup
set history=100                 " Keep command history
set autowrite                   " Autosave changes when moving out of the buffer temporarily
set backup                      " Keep backup of files
set backupdir=$HOME/tmp/vimbkup " ...here's where to keep 'em
set undofile                    " Save undo's after file closes
set undodir=$HOME/.vim/undo     " ...here's where to save undo histories
set undolevels=1000             " ...here's how many undos to save
set undoreload=10000            " ...here's the number of lines to save for undo
set viminfo=%,'50,<50           " Remember the buffer list (%), 50 previously edited files (')
                                " and 50 lines for each register (<)
" diff
set diffopt=internal,indent-heuristic,algorithm:patience,filler,hiddenoff

" Completion options
set complete=.,w,b,u,t,i,kspell,k,s
set spell " spelllang=en_us                " We no how to spelle (highlight and CTRL-X_S completion)
set dictionary+=/usr/share/dict/words    " Add a dictionary (CTRL-X_CTRL_D completion)
set thesaurus+=./thesaurus_pkg/thesaurs.txt  " Add a thesaurus (CTRL-X_CTRL_T completion)
set wildignore+=*.swp,*.pyc,*.o,*.pdf    " In command-mode, skip over these when completing paths
set wildignore+=*.ico,*.png,*.jpg,*.gif
set wildignore+=.git/*
set wildignore+=**/__pycache__/**

set wildmenu                             " In command-mode, show a 'menu' for completion
set wildoptions=pum,tagfile
set wildmode=longest:full,lastused,full  " In command-mode, complete until the longest common
                                         " prefix and show menu of full matches, then cycle thru'
                                         " menu of matches
set completeopt=menuone,longest,noselect " In insert-mode, always show a menu, complete until the
                                         " longest common prefix but don't automatically select
set infercase                            " Infer case for completion. Needed because we've set
                                         " ignorecase for searches

" Other options
set cryptmethod=blowfish2                " default encryption method to use with -x
set hidden

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

" Vertical sfind
cabbrev vsf vert sfind

" Remap keystroke for switch to Ex-mode (which is never used) to quit all which is used more
" frequently than never
map Q <Cmd>qa<CR>
command -nargs=0 -bang Q qa<bang>

" Remap 'only window' to split in tab
map <C-W>o <Cmd>tab split<CR>
" Remap 'move cursor to top-left split' to 'move to new tab'
map <C-W>t <C-W>T
" Map for create new vertical split and execute `-` from vim-vinegar
map <C-W>- <Cmd>vnew<CR>-
" Map for create new vertical split
map <C-W>V <Cmd>vnew<CR>

" Like gf, but in a vertical split
map vgf <C-W><C-f><C-W>L

" execute macro stored in register q (qq to start recording, qqq to clear)
nnoremap <Space> @q

" Toggle line numbers
" map <Leader>sn <Cmd>set number! cursorline<CR>
map <Leader>sn <Cmd>echo("Use yon + yox !")<CR>

" Toggle list
" map <Leader>l <Cmd>set list!<CR>
map <Leader>l <Cmd>echo("Use yol !")<CR>

" Keep search matches in the middle of the screen
" http://vimrcfu.com/snippet/175
nnoremap n nzz
nnoremap N Nzz

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" write with sudo using :w!!
cmap w!! <Cmd>echo("Use Sudowrite/Sudoedit instead")<CR>

" Esc for going to Normal mode from terminal mode
tnoremap <Esc> <C-\><C-n>

" Search on word boundary
nnoremap <leader>/ /\<\><left><left>

" JSON formatting
" - visual mode
xnoremap <leader>jq :!jq .<CR>
" - entire file
nnoremap <leader>jq :%!jq .<CR>

" Toggle copilot
function! ToggleCopilot()
    if exists('g:copilot_enabled') && g:copilot_enabled
        execute "Copilot disable"
    else
        execute "Copilot enable"
    endif
endfunction
inoremap <C-Q> <Cmd>call ToggleCopilot()<CR>
imap <C-L> <Plug>(copilot-accept-word)

" Plugins
" =======
" Load packaged plugins we need always, irrespective of filetype
"
" man plugin (I need it all the time, even when mailing mom)
runtime! ftplugin/man.vim

" matchit plugin packaged with the default vim
packadd! matchit


" Plugin options
" ==============

" auto-pairs
" - don't look for closing pair beyond current line
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutFastWrap = "<C-e>"
au FileType python let b:AutoPairs = AutoPairsDefine({"b'": "'", "f'": "'", "r'": "'", 'b"': '"', 'f"': '"', 'r"': '"'})
au FileType markdown let b:AutoPairs = AutoPairsDefine({"[": "]()"})

" cbackup
let g:backup_directory=expand("$HOME/tmp/vimbkup/cbackup")
let g:backup_purge=20

" SuperTab
" let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-x><c-p>'
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabRetainCompletionDuration = 'completion'
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
" let g:SuperTabCrMapping = 1
autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \ endif

" jedi
" show call signatures in the command line instead of pop-up
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 1  " smart import completion

" don't modify completeopt to menuone,longest,preview
autocmd FileType python setlocal completeopt-=preview suffixesadd=.py
let g:jedi#auto_vim_configuration = 0

" use tabs for go-to/show-definition/related-names
" let g:jedi#use_tabs_not_buffers = 1

" ale
let g:ale_python_auto_virtualenv = 1
" let g:ale_virtualenv_dir_name = ['.venv', '.env_python3.12', '.env_python3.6', '.env_python3.8', '.env_python2.7']
let g:ale_linters = {
            \ 'python': ['ruff', 'isort', 'black', 'flake8', 'mypy'],
            \ }
let g:ale_fixers = {
            \ 'python': ['remove_trailing_lines', 'trim_whitespace', 'ruff', 'ruff_format', 'autoflake', 'isort', 'black']
            \}

let g:ale_python_autoflake_options = '--remove-all-unused-imports --ignore-init-module-imports'
let g:ale_python_black_options = '--line-length=100'
let g:ale_completion_enabled = 1
" let g:ale_disable_lsp = 1
let g:ale_pattern_options = {'/tmp/.*\.py$': {'ale_enabled': 0}}
let g:ale_list_vertical = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '~'
let g:ale_echo_msg_format = "%linter%:%severity%:%code: %%s "
let g:ale_lsp_suggestions = 1
if empty($ALE_FIX_ON_SAVE_IGNORE)
    let g:ale_fix_on_save = 1
endif

" mapping to toggle ALE on buffer C-a is "increment number"
" nmap <silent> <C-a> <Plug>(ale_toggle_buffer)

" taglist
" - close when taglist is the only open window
let g:Tlist_Exit_OnlyWindow = 1

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal_code_blocks = 1
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'python=python']
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_edit_url_in = 'tab'

" lightline
let g:lightline = {
    \ 'active': {
    \   'left': [['mode', 'paste'],
    \            ['fugitive', 'virtualenv', 'readonly', 'relativepath', 'modified', 'searchcount']]
    \ },
    \ 'component': {
    \   'virtualenv': empty($VIRTUAL_ENV) ? '' : 'ε ' . fnamemodify($HACKON_ENV, ':t'),
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightlineFugitive',
    \   'searchcount': 'LightlineSearchCount'
    \ }
    \ }

function! LightlineFugitive()
    return exists('*fugitive#head') ? 'λ ' . (fugitive#head() == 'master' ? '(∙)' : fugitive#head()) : ''
endfunction

function! LightlineSearchCount()
    if !v:hlsearch
        return ''
    endif
    let s = searchcount()
    return s.current . '/' . s.total
endfunction

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_max_line_indicator = "exceeding"

" vim-readonly
let g:readonly_python = 0

" vim-gutentags
let g:gutentags_cache_dir = expand('~/.cache/vim-tags')

" vim-mundo
let g:mundo_verbose_graph = 0

" Update copilot workspace folder
if !empty($HACKON_ENV)
    let g:copilot_workspace_folders = [$HACKON_ENV]
endif

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

    " Cursor Stuff
    " - Reference chart of values:
    "   0: blinking block.
    "   1: blinking block (default).
    "   2: steady block.
    "   3: blinking underline.
    "   4: steady underline.
    "   5: blinking bar (xterm).
    "   6: steady bar (xterm).
    let &t_SI = "\e[2 q"   " Start Insert mode
    let &t_SR = "\e[6 q"   " Start Insert mode
    let &t_EI = "\e[0 q"   " Exit insert mode
    " - set cursorline in normal mode when multiple windows are open
    autocmd WinEnter,BufWinEnter,InsertLeave * exe winnr('$') > 1 ? "setlocal cursorline" : "setlocal nocursorline"
    autocmd WinLeave,BufWinLeave,InsertEnter *  setlocal nocursorline

    " - reset cursor when leaving vim
    autocmd VimLeave * silent !echo -ne "\e[0 q"

    " HACKON_ENV specific updates
    if !empty($HACKON_ENV)
        let s:path_updated = 0
        augroup hackonenv
            autocmd!
            autocmd VimEnter * call s:UpdateForHackonEnv()
            autocmd BufNewFile * call s:CheckPath()
        augroup END
        " autocmd BufNewFile,BufReadPre * call UpdateForHackonEnv()
        " autocmd VimEnter * call UpdateForHackonEnv()
        " autocmd BufNewFile * call CheckPath()
        function! s:UpdateForHackonEnv()
            if s:path_updated == 1
                return
            endif

            " convenience to lookup python code just by filename.
            " Here because needs to be set even when !argc for findfile() to work
            set suffixesadd=.py

            " Protect virtualenv files
            if exists("g:readonly_paths") && index(g:readonly_paths, $VIRTUAL_ENV) == -1
                call extend(g:readonly_paths, [$VIRTUAL_ENV])
            endif

            " Update path for env
            let s:paths = [".,"]

            " - git dirs
            " let git_toplevel_dirs = systemlist('for i in $(git ls-files); do fn=${i%%/*}; [[ -d ${fn} ]] && echo ${fn}; done |sort -u')
            " XXX `silent` to prevent messages reporting the end of execution
            silent let git_toplevel_dirs = systemlist('dirname $(git ls-files)|grep -v "\.$"|sort -u')
            " silent let git_toplevel_dirs = systemlist('dirname $(git ls-files)|grep -v "\."|sort -u|' . shellescape('-'))
            for dirname in git_toplevel_dirs
                call add(s:paths, dirname . '/**/')
            endfor

            let &path = join(s:paths, ',')

            " - custom paths
            if !empty($VIM_SEARCH_PATH)
                set path+=$VIM_SEARCH_PATH
            endif

            let s:path_updated = 1
        endfunction

        function! s:CheckPath()
            if s:path_updated == 0
                call s:UpdateForHackonEnv()
            endif
            let filename = expand("<afile>")
            if filereadable(filename)
                return
            endif
            let matches = findfile(filename, &path, -1)
            if empty(matches)
                let matches = finddir(filename, &path, -1)
            endif
            if empty(matches)
                return
            elseif matches->len() == 1
                call feedkeys(":args " . matches[0]. "\<CR>", "t")
            else
                call feedkeys(":find " . filename . "\<Tab>\<Tab>", "t")
            endif
        endfunction
    endif

    " mkdir -p on write
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
      function! s:auto_mkdir(dir, force)
        if !&diff && !isdirectory(a:dir)
            \ && (a:force
            \       || input("'" . a:dir . "' does not exist. Create? [y/N] ") =~? '^y\%[es]$')
          call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
      endfunction

    " WSL specific
    " - WSL yank support
    if !empty($WSLENV)
        let s:clip = exepath('clip.exe')
        if executable(s:clip)
            augroup WSLYank
                autocmd!
                autocmd TextYankPost * if v:event.operator ==# 'y' | silent call system(s:clip, @0) | echo "Use Shift+Ins to Paste!" | endif
            augroup END
        endif
    endif


    " Filetype specific
    " - avro files
    autocmd BufNewFile,BufRead *.avsc set ft=json

    " - make files
    autocmd Filetype make setlocal noexpandtab softtabstop=0
    " - spec files
    autocmd BufNewFile,BufRead *.spec
        \ let packager = "Steven Fernandez <lonetwin@fedoraproject.org>"
    autocmd BufNewFile *.spec
        \ 0r $HOME/.vim/templates/tmpl.spec | ks | call NewSpec() | 's
        fun NewSpec()
            exe "g/Name:/s/Name:/Name:\t\t" . expand("%:t:r")
        endfun

    " - nginx files
    autocmd BufNewFile,BufRead *nginx/* set ft=nginx

    " - log files
    autocmd BufNewFile,BufRead *.log set nospell readonly

    " - typescript files
    autocmd BufNewFile,BufRead *.tsx set ft=typescript

    " - treat .zcml as xml
    autocmd BufNewFile,BufRead *.zcml set ft=xml
    autocmd Filetype xml
        \ setlocal formatprg=xmllint\ --format\ --recover\ -\ 2>/dev/null   |
        \ setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null    |
        \ setlocal textwidth=0 nowrap tabstop=2 softtabstop=2 shiftwidth=2

    " - YAML files
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2

    " - set custom formatprg for some filetypes
    " Note to self: vim is not too good at detecting json files, make sure ft is set!
    autocmd Filetype json setlocal formatprg=jq\ .\

    " - html/templates
    autocmd FileType html
        \ set textwidth=0 nowrap tabstop=2 softtabstop=2 shiftwidth=2 smartindent

    " - set up omni-completion if a specific plugin doesn't already exist for
    "   the filetype
    autocmd Filetype *
        \ if &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif

    " - convenience when editing rst files
    autocmd BufNewFile,BufRead *.rst
        \ setlocal textwidth=80 |
        \ setlocal suffixesadd=.rst |
        \ iabbrev <expr> {date} strftime('%F') . '<CR>----------<CR><CR>*'

    " - convenience when editing md files
    autocmd FileType markdown set conceallevel=2
    autocmd BufNewFile,BufRead *.md
        \ iabbrev <expr> {date} '# ' . strftime('%a, %F') . '<CR><CR>*'

    " Vagrant file
    autocmd BufNewFile Vagrantfile 0r $HOME/.vim/templates/tmpl.vagrantfile

    " bash files
    autocmd BufNewFile *.sh 0r $HOME/.vim/templates/tmpl.bash

    " Office stuff -- start
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal textwidth=100
    " Office stuff -- end

augroup END

" Custom commands
" ===============

" Custom command to write a copy of the currently opened file to a different
" path on every write. This is useful, for instance, when you have sshfs
" mounted paths from multiple systems and need to keep a copy of the same file
" sync'd on all systems
command -nargs=1 -complete=dir DuplicateAt autocmd BufWritePost * w! <args>%
command -nargs=0  DuplicateAtDel autocmd! BufWritePost *

" HTML formatting
command -range=% FixHtml :<line1>,<line2>s/> *</>\r</g<bar>normal gg=G

" This is part of |defaults.vim| but on wsl, seems like this isn't loaded
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
    \ | diffthis | wincmd p | diffthis


" Custom functions
" ================

function QuickFixPopulate(cmd_str, fmt="%f:%l")
    let &errorformat=a:fmt
    cexpr systemlist(a:cmd_str)
    set errorformat&
endfunction

" Session Management
function SaveSession()
    if &diff || expand("%:t") == "COMMIT_EDITMSG"
        return
    endif

    if (winnr('$') > 1 || tabpagenr('$') > 1)
        " check if we have more than one windows or tabs open and ask whether we want to save
        " the session if we do.
        let save_sesssion = confirm("Save session ? ", "&yes\n&no", 1)
        if save_sesssion == 1
	    call inputsave()
            if !empty($HACKON_ENV)
                let session_fl = input("save as: ~/tmp/vim/" . fnamemodify($HACKON_ENV, ':t') . '.session.vim', "file")
            else
                let session_fl = input("save as: ", getcwd() . '/.session.vim', "file")
            endif
            call inputrestore()
            execute 'mksession!' session_fl
        endif
    endif
endfunction

function LoadSession()
    let session_fl = getcwd() . '/.session.vim'
    if !empty($HACKON_ENV) && filereadable('~/tmp/vim/' . fnamemodify($HACKON_ENV, ':t') . '.session.vim')
        session_fl = '~/tmp/vim/' . fnamemodify($HACKON_ENV, ':t') . '.session.vim'
    endif

    if filereadable(expand(session_fl))
        let load_sesssion = confirm("Load session from '".session_fl."'?", "&yes\n&no\nload and delete\ndelete", 1)
        if load_sesssion == 1 || load_sesssion == 3
            execute 'source' session_fl
            execute 'source ~/.vim/after/plugin/colormod.vim'
        endif
        if load_sesssion == 3 || load_sesssion == 4
            call system('unlink '.session_fl)
        endif
    endif
endfunction

" LoadSession or Open :browse oldfiles if no args were provided
" The 'nested' before call allows nested autocmds, important for
" syntax detection etc.
" au VimLeavePre * call SaveSession()
" au VimEnter * nested call LoadSession()

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


" Define a function to replace selected lines with Python output using pydo
" fun! ReplaceWithPythonOutput()
"     " Save the current visual selection into a variable
"     let selected_lines = getline("'<", "'>")
"
"     " Execute Python command on the selected lines using pydo
"     let python_output = py3do selected_lines
"
"     " Replace the selected lines with the Python output
"     execute "normal! gv\"_d"  " Delete the selected lines
"     call setline("'<", python_output)  " Set the Python output as the new content
" endfun
"
" " Create a mapping to trigger the function (e.g., F5 key)
" vnoremap <F5> :call ReplaceWithPythonOutput()<CR>
"
"
function! FindImportStatement()
    " Get the word under the cursor
    let l:word = expand("<cword>")
    " Search for a line that matches 'import.*<cword>'
    let l:match = search('import.*' . l:word, 'nw')

    if l:match > 0
        " If a match is found, echo the line
        echo getline(l:match)
    else
        " If no match is found, display a message
        echo "No import statement found for " . l:word
    endif
endfunction

" Map the function to a key combination, e.g., <leader>fi
nnoremap <leader>fi :call FindImportStatement()<CR>

" AddVenvModulePath.vim
" Call with:  :call AddVenvModulePath('requests')
" It will add $VIRTUAL_ENV/.../site-packages/requests to 'path'.

function! AddVenvModulePath(mod) abort
  " 1. Make sure we're in a virtualenv
  if empty($VIRTUAL_ENV)
    echoerr 'VIRTUAL_ENV is not set'
    return
  endif

  let l:root = $VIRTUAL_ENV
  let l:pkg  = a:mod

  " 2. Find matching site-packages directories
  let l:dirs = glob(l:root . '/lib/python*/site-packages/' . l:pkg, 0, 1)
  let l:dirs += glob(l:root . '/lib64/python*/site-packages/' . l:pkg, 0, 1)

  if empty(l:dirs)
    echoerr printf("Module '%s' not found under %s/**/*.site-packages", l:pkg, l:root)
    return
  endif

  " 3. For each match, canonicalize and add to 'path'
  for l:dir in l:dirs
    let l:full = fnamemodify(l:dir, ':p')
    execute 'set path+=' . fnameescape(l:full)
    echom printf("Added %s to 'path'", l:full)
  endfor
endfunction


" ===================================================================
" ExecPy(): eval the selected text (char- or line-wise) or a line-range
" and replace it with the result.
" ===================================================================
function! ExecPy(...) abort
  " ———————————————————————
  " 1) Figure out what kind of invocation we have
  " ———————————————————————
  if a:0 == 2
    " :<start>,<end>ExecPy → full lines
    let l:start_line = a:1
    let l:end_line   = a:2
    let l:start_col  = 1
    let l:end_col    = len(getline(l:end_line))
  elseif a:0 == 1
    " ExecPy(<vismode>) from our vnoremap
    let l:vis = a:1
    if l:vis ==# 'V'
      " line-wise visual: grab whole lines
      let l:start_line = getpos("'<")[1]
      let l:end_line   = getpos("'>")[1]
      let l:start_col  = 1
      let l:end_col    = len(getline(l:end_line))
    elseif l:vis ==# 'v'
      " char-wise visual: grab just those columns
      let l:start_line = getpos("'<")[1]
      let l:start_col  = getpos("'<")[2]
      let l:end_line   = getpos("'>")[1]
      let l:end_col    = getpos("'>")[2]
    elseif l:vis ==# "\<C-V>" || l:vis ==# "\<C-v>"
      echoerr "ExecPy(): block-wise visual selection is not supported."
      return
    else
      echoerr "ExecPy(): unknown visual mode “".l:vis."”"
      return
    endif
  else
    echoerr "ExecPy(): call with either a visual selection or a line-range."
    return
  endif

  " ———————————————————————————————
  " 2) Hand off to Python for eval/exec + capture + replace
  " ———————————————————————————————
  python3 << EOF
import vim, io, contextlib

sl = int(vim.eval('l:start_line'))
sc = int(vim.eval('l:start_col'))
el = int(vim.eval('l:end_line'))
ec = int(vim.eval('l:end_col'))
buf = vim.current.buffer

# extract exactly what was selected
if sl == el:
    line   = buf[sl-1]
    code   = line[sc-1:ec-1]
    prefix = line[:sc-1]
    suffix = line[ec-1:]
else:
    first  = buf[sl-1][sc-1:]
    middle = buf[sl:el-1]
    last   = buf[el-1][:ec]
    code   = '\n'.join([first] + middle + [last])
    prefix = buf[sl-1][:sc-1]
    suffix = buf[el-1][ec:]

# execute or eval, capturing stdout or the value of a lone expression
stream = io.StringIO()
with contextlib.redirect_stdout(stream):
    try:
        res = eval(code, {})
        if res is not None:
            print(res)
    except Exception:
        exec(code, {})

out_lines = stream.getvalue().splitlines()
if not out_lines:
    out_lines = ['']

# splice the result back into the buffer
if sl == el:
    buf[sl-1] = prefix + out_lines[0] + suffix
    for l in out_lines[1:]:
        buf.append(l, sl-1)
else:
    buf[sl-1] = prefix + out_lines[0]
    buf[el-1] = out_lines[-1] + suffix
    if el - sl > 1:
        del buf[sl:el-1]
    for idx, l in enumerate(out_lines[1:-1]):
        buf.append(l, sl-1+idx)
EOF
endfunction

" —————————————————————————————————————————
" 3) A command for explicit ranges:
"      :5,10ExecPy
"    will run lines 5–10 as a block.
" —————————————————————————————————————————
command! -range ExecPy <line1>,<line2>call ExecPy(<line1>,<line2>)

" —————————————————————————————————————————
" 4) A visual-mode mapping.  Select text (char- or line-wise) and hit <leader>p.
"    We pass in the visualmode() so the function knows how to slice.
" —————————————————————————————————————————
vnoremap <silent> <leader>p :<C-U>call ExecPy(visualmode())<CR>
