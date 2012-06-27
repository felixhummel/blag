" generate the following for every sphinx keyword:
"   - short description (to display in ins-completion-menu)
"   - long description (to display in preview-window)
" this is somewhat ugly.
"   - better: generate (a ctags file?) from sphinx

" Bugs:
" - need validation for keywords_file

let keywords_file = expand('$HOME/.vim/ftplugin/rst/sphinx_keywords.txt')

let g:roles = {}
let f = readfile(keywords_file)
for line in f
    let splitidx = stridx(line, ': ')
    let keyword = strpart(line, 0, splitidx)
    let short_description = strpart(line, splitidx+2)
    let g:roles[keyword] = short_description
endfor

fun! CompleteSphinxKeywords(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a\|:'
            let start -= 1
        endwhile
        return start
    else
        " find roles matching with "a:base"
        let res = []
        for k in keys(g:roles)
            if ':' . k =~ '^' . a:base
                let completion_entry = {}
                let completion_entry['word'] = ':' . k . ':`'
                let completion_entry['abbr'] = k
                let completion_entry['menu'] = '| '.g:roles[k]
                call add(res, completion_entry)
            endif
        endfor
        return res
    endif
endfun
set completefunc=CompleteSphinxKeywords

