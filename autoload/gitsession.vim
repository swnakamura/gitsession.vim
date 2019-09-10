function! GetBranch() abort
    let s:branch_name = system(g:gitsession_git_executable . " branch 2>/dev/null| grep '*' | sed 's/* //'")
    let s:branch_name = substitute(s:branch_name,' ','_','g')
    let s:branch_name = substitute(s:branch_name, '\n', '', 'g')
    " convert '/' to '_' to avoid problems with path
    let s:branch_name = substitute(s:branch_name, '/', '_', 'g')
    return s:branch_name
endfunction

function! GetOrigin() abort
    let s:orig_name = system(g:gitsession_git_executable . " remote -v 2>/dev/null | grep 'push' | grep 'origin'")
    " remove remote branch name
    let s:orig_name = substitute(s:orig_name, '.*\t', '', '')
    " remove https/git header/suffix
    let s:orig_name = substitute(s:orig_name, 'https://[^/]*/', '', '')
    let s:orig_name = substitute(s:orig_name, 'git@.*:', '', '')
    let s:orig_name = substitute(s:orig_name, '\.git', '', '')
    " remove trailing "(push)"
    let s:orig_name = substitute(s:orig_name, ' (.*)', '', '')
    let s:orig_name = substitute(s:orig_name, '\n', '', 'g')
    " convert to '_' to avoid problems with path separator
    let s:orig_name = substitute(s:orig_name, '/', '_', 'g')
    let s:orig_name = substitute(s:orig_name, '\', '_', 'g')
    return s:orig_name
endfunction

function! GetParentDir(path) abort
    let s:sep = split(a:path,'/')
    let s:parentpath = '/' . join(s:sep[:-2],'/')
    return s:parentpath
endfunction

function! GetRepoDir()
    let s:repodir_name = getcwd()
    while !isdirectory(s:repodir_name . '/.git/')
        let s:repodir_name = GetParentDir(s:repodir_name)
        if s:repodir_name == '/'
            " TODO: change this by options
            " return ''
            return split(getcwd(),'/')[0]
        endif
    endwhile
    return split(s:repodir_name,'/')[-1]
endfunction

function! Session_filename() abort
    return g:gitsession_tmp_dir . "/" . GetRepoDir() . "--" . GetOrigin() . "--" . GetBranch() . "--sess.vim"
endfunction

function! gitsession#savesession() abort
    if g:gitsession_current_window
        cd %:p:h
    endif
    if isdirectory(g:gitsession_tmp_dir) == 0
        call system("mkdir -p " . g:gitsession_tmp_dir . " >/dev/null 2>&1")
    endif
    let s:session_filename = Session_filename()
    if g:gitsession_current_window
        cd -
    endif
    execute "mksession! " . s:session_filename
endfunction

function! gitsession#loadsession() abort
    if g:gitsession_current_window
        cd %:p:h
    endif
    let s:session_filename = Session_filename()
    if !filereadable(s:session_filename)
        echo "Session file (" . s:session_filename . ") not found"
        return
    endif
    execute "silent source " . s:session_filename
    if g:gitsession_current_window
        cd -
    endif
endfunction

function! gitsession#cleanupsession() abort
    call system("rm " . g:gitsession_tmp_dir . "/*--*--*--sess.vim")
endfunction

