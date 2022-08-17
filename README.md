gitsession.vim
==============
Say goodbye to the trouble of session file management.

## About
*gitsession* is a Vim plugin that saves your session state, tagged with the status of git repository.  

## Quick start
Go into your (git) project, open NeoVim, edit as you like. When you are done but want to continue the same project tomorrow, run `:SaveSession` before you leave. This will save your current session.  

When you are back, run `:LoadSession` in any place within the project directory. Your window setting will be reloaded.  

The session file is tagged with the name of the repository, the name of the remote repository and the name of the branch. If any of them changes, the session file will be a different one.  

### Autosave
Type `:StartRepeatedSave` to enable autosaving. Your session will be saved automatically.  
You can also set `let g:gitsession_autosave = 1` (before this plugin is loaded) to enable this feature at the moment Vim starts.  

### CONFIGURATION EXAMPLES

```init.vim
" Change the temporary file location.  
let g:gitsession_tmp_dir = $HOME . "/.config/nvim/tmp/gitsession"  

" mappings  
nmap gss <Cmd>SaveSession<CR>  
nmap gsl <Cmd>LoadSession<CR>  
nmap gsr <Cmd>StartRepeatedSave<CR>  
nmap gsc <Cmd>CleanUpSession<CR>  
```

## Compatibility
This is a quite simple plugin and should work with Vim as well, but compatibility is not guaranteed as I only use NeoVim.  

If you find any problem/feature requests, issues/PRs are welcomed.
