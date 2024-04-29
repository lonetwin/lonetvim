" load the default colorscheme
" runtime bundle/colorschemes/colors/Monokai.vim
runtime bundle/colorschemes/colors/busierbee.vim
set background=dark

" Ensure vertical splits are the same color as normal text
hi VertSplit ctermbg=fg ctermfg=bg

" Fix highlight for Spelling
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad term=undercurl cterm=undercurl
hi SpellCap term=undercurl cterm=undercurl
hi SpellRare term=undercurl cterm=undercurl
hi SpellLocal term=undercurl cterm=undercurl

" Don't damage eyes when doing a diff
hi clear DiffAdd DiffDelete DiffChange DiffText
hi DiffAdd ctermbg=23
hi DiffDelete ctermbg=234 ctermfg=234
hi DiffChange ctermbg=60
hi DiffText ctermbg=53

" but hurt my eyes by highlighting leading/trailing spaces
hi WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Make folds less blue
hi Folded ctermbg=24 ctermfg=255

" make Comments, WildMenu and Strings italics
hi Comment   cterm=italic gui=italic
hi WildMenu  cterm=italic gui=italic
hi String    cterm=italic gui=italic

" Make visual selections legible
" highlight Visual ctermbg=Brown guibg=Brown

" Gentler SignColumn for ALE Error
" highlight SignColumn ctermbg=Black guibg=Black
highlight clear Error
highlight Error term=reverse cterm=bold ctermfg=Red ctermbg=Black guifg=Red guibg=Black

hi Search ctermbg=74 ctermfg=237
hi CurSearch ctermbg=126 ctermfg=11

hi CursorLine cterm=underdotted
" hi clear CursorLine
" hi CursorLine ctermfg=9
" hi clear CursorColumn
