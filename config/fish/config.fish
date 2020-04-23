if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
set fish_greeting
fundle plugin 'edc/bass'
fundle plugin 'tuvistavie/fish-fastdir'
fundle init
export PATH="/usr/local/sbin:~/.local/bin:~/ovo/international-infra/scripts:$PATH"
export EDITOR="emacs"
