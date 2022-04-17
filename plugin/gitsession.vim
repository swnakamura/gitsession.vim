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
let g:gitsession_ask_autoload   = get(g:, 'gitsession_ask_autoload', 0)
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
    if g:gitsession_ask_autoload
                \&& !g:gitsession_autoload
                \&& gitsession#exists_session()
                \&& bufname(1) == ''
        echomsg 'A previous session file is found. Load this before starting autosave? Y(es)/n(o)/q(uit)/e(dit current directory): '
        let s:got_correct_response = v:false
        while s:got_correct_response == v:false
            let s:got_correct_response = v:true
            let s:choice = nr2char(getchar())
            if index(['Y', 'y', "\r"], s:choice) >= 1
                call gitsession#loadsession()
            elseif s:choice == 'n'
            elseif s:choice == 'e'
                exe 'e .'
            elseif s:choice == 'q'
                quit
            else
                let s:got_correct_response = v:false
            endif
            if s:got_correct_response == v:false
                echohl WarningMsg
                echo 'please answer Y/n/q/e: '
                echohl None
            endif
        endwhile
    endif
endif
