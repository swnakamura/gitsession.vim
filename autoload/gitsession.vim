let s:git_executable = "git"
let s:tmp_dir = expand("~/.config/nvim/tmp")

function! GetBranch() abort
    let s:branch_name = system(s:git_executable . " branch 2>/dev/null| grep '*' | sed 's/* //'")
    let s:branch_name = substitute(s:branch_name,' ','_','g')
    let s:branch_name= substitute(s:branch_name, '\n', '', 'g')
    " convert '/' to '_' to avoid problems with path
    let s:branch_name = substitute(s:branch_name, '/', '_', 'g')
    return s:branch_name
endfunction

function! GetOrigin() abort
    let s:orig_name = system(s:git_executable . " remote -v | grep 'push' | grep 'origin'")
    " remove remote branch name
    let s:orig_name = substitute(s:orig_name, '.*\t', '', '')
    " remove https/git headers
    let s:orig_name = substitute(s:orig_name, 'https://[^/]*/', '', '')
    let s:orig_name = substitute(s:orig_name, 'git@\.*:', '', '')
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
            return ''
        endif
        " TODO: if cwd isn't in any repositories...?
    endwhile
    return split(s:repodir_name,'/')[-1]
endfunction

function! gitsession#savesession() abort
    let s:session_filename = s:tmp_dir . "/" . "--" . GetRepoDir() . GetOrigin() . "--" . GetBranch() . "--sessionfile.vim"
    if isdirectory(s:tmp_dir) == 0
        system("!mkdir -p " . s:tmp_dir . " >/dev/null 2>&1")
    endif
    execute "mksession! " . s:session_filename
endfunction

function! gitsession#loadsession() abort
    let s:session_filename = s:tmp_dir . "/" . "--" . GetRepoDir() . GetOrigin() . "--" . GetBranch() . "--sessionfile.vim"
    execute "silent source " . s:session_filename
endfunction

