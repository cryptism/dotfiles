if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
set fish_greeting
fundle plugin 'edc/bass'
fundle plugin 'tuvistavie/fish-fastdir'
fundle init
bass source /Users/joe/.nix-profile/etc/profile.d/nix.sh
export PATH="$HOME/.local/bin:$HOME/.npm-packages/bin:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.smackage/bin:/usr/local/sbin:/usr/local/texbin:$PATH"
export PATH="/Users/joe/blocksure/blocksure-os/kt/bops-dev:/Users/joe/.local/bin:$PATH"
export NPM_TOKEN="c698ede6-327b-4e74-a105-cd89514e9060"
export EDITOR="emacs"
source ~/.iterm2_shell_integration.fish
source ~/dotfiles/zsh/themes/huh/huh.fish
