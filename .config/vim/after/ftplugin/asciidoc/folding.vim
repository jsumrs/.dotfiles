set foldcolumn=3

function! AdocFolds()
    let thisline = getline(v:lnum)
    if match(thisline, '^====')>= 0
        return ">4"
    elseif match(thisline, '^===')>= 0
        return ">3"
    elseif match(thisline, '^==') >= 0
        return ">2"
    elseif match(thisline, '^=') >= 0
        return ">1"
    else
        return "="
    endif
endfunction
setlocal foldmethod=expr
setlocal foldexpr=AdocFolds()

function! AdocFoldText()
    let foldsize = (v:foldend-v:foldstart)
    return getline(v:foldstart).' ('.foldsize.' lines)'
endfunction
setlocal foldtext=AdocFoldText()
