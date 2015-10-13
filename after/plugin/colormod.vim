" Spelling
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad term=standout,underline cterm=underline
hi SpellCap term=underline cterm=underline
hi SpellRare term=underline cterm=underline
hi SpellLocal term=underline cterm=underline

" hurt my eyes by highlighting leading/trailing spaces
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
