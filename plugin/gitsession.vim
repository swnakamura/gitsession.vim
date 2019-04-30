if exists('g:loaded_gitsession')
    finish
endif
let g:loaded_gitsession = 1

" load function
command! SaveSession call gitsession#savesession()
command! LoadSession call gitsession#loadsession()
command! CleanUpSession call gitsession#cleanupsession()

" variables
let g:gitsession_git_executable = get(g:, 'gitsession_git_executable', "git")
let g:gitsession_tmp_dir        = get(g:, 'gitsession_tmp_dir', expand("~/.tmp/gitsession"))
let g:gitsession_current_window = get(g:, 'gitsession_current_window', 1)
