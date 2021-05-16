if exists('g:loaded_gitsession')
    finish
endif
let g:loaded_gitsession = 1

" load function
command! SaveSession call gitsession#savesession()
command! LoadSession call gitsession#loadsession()
command! CleanUpSession call gitsession#cleanupsession()
command! StartRepeatedSave call gitsession#repeatsaving()

" variables
let g:gitsession_git_executable = get(g:, 'gitsession_git_executable', "git")
let g:gitsession_tmp_dir        = get(g:, 'gitsession_tmp_dir', expand("~/.tmp/gitsession"))
let g:gitsession_current_window = get(g:, 'gitsession_current_window', v:true)
let g:gitsession_autoload       = get(g:, 'gitsession_autoload', 0)
let g:gitsession_autosave       = get(g:, 'gitsession_autosave', 0)

if g:gitsession_autoload == 1
    augroup GSAutoLoad
        autocmd!
        autocmd VimEnter * call gitsession#loadsession()
    augroup END
endif

if g:gitsession_autosave == 1
    augroup GSAutoSave
        autocmd!
        autocmd VimEnter * call gitsession#repeatsaving()
    augroup END
    " If the previous session file is found, prompt to load immediately before
    " overwritten by autosaving
    if gitsession#exists_session()
        echo 'The previous session file is found. Load this before starting autosave? Y/n: '
        if nr2char(getchar()) != 'n'
            call gitsession#loadsession()
        endif
    endif
endif
