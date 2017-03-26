function! VimDjangoCompletion()
    let matches = matchlist(getline('.'), '{%\s\+\(block\|if\|for\)')
    return empty(matches) ? "%" : "%}\n{% end" . matches[1] . " %\<ESC>==O"
endfunction

inoremap <buffer> %} <C-R>=VimDjangoCompletion()<CR>
