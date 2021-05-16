gitsession.vim
==============
Say goodbye to the trouble of session file management.

## About
*gitsession* is a Vim plugin that saves your session state, tagged with the status of git repository.  

## Quick start
Go into your (git) project, open NeoVim, edit as you like. When you are done but want to continue tomorrow, run `:SaveSession` before you leave. This will save your current session.  

When you are back, run `:LoadSession` in any place within the project directory. Your window setting will be reloaded.  

The session file is tagged with the name of the repository, the name of the remote repository and the name of the branch. If any of them changes, the session file gets separated.  

### Autosave
Type `:StartRepeatedSave` to enable autosave. Your session will be saved automatically. (This internally use `VimLeave`, so that it will be saved only when exiting.)  
You can also set `let g:gitsession_autosave = 1` (before this plugin is loaded) to enable this feature at the moment Vim starts.  

### CONFIGURATION EXAMPLES

```
init.vim
" I don't like buffer to be cached. It piles up and degrades " performance.  
set sessionoptions-=buffers  

" Change temporary file location.  
let g:gitsession_tmp_dir = expand("~/.config/nvim/tmp/gitsession")  

" mappings  
nmap gss :SaveSession  
nmap gsl :LoadSession  
nmap gsr :StartRepeatedSave  
nmap gsc :CleanUpSession  
```

## Compatibility
This is a quite simple plugin and works with Vim as well, but as I only tested it with NeoVim, compatibility is not guaranteed.
