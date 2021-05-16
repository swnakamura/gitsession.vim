gitsession.nvim
==============

Say goodbye to the trouble of session file management.

## About
With this plugin you can save & load session file (the arrangement of tabs & windows) tagged with its git repository, its absolute path and its remote repository URL.

## Quick start
Install it with a plugin manager.

Go into your (git) project, open NeoVim, edit as you like, and type `:SaveSession` before you leave. This will save your current session.

When you are back, type `:LoadSession` in the same project repository. Your window setting will reappear.

## Example configuration

```init.vim
nmap gss :SaveSession<CR>
nmap gsl :LoadSession<CR>
```

## Autosave
Type `:StartRepeatedSave` to enable autosave. Your session will be saved automatically.
(This internally use `CursorHold`, so that it will be saved only when needed.)

You can also set `let g:gitsession_autosave = 1` (before this plugin is loaded) to enable this feature at the moment Vim starts.

## Compatibility
This is a quite simple plugin and works with Vim as well, but as I only tested it with NeoVim, compatibility is not guaranteed.
