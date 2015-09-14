source ~/.antigen.zsh

#antigen use oh-my-zsh
antigen bundle robbyrussell/oh-my-zsh lib/
antigen bundle git
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle coffee
antigen bundle node
antigen bundle npm
antigen bundle tmuxinator
antigen bundle rupa/z

if [[ $CURRENT_OS == 'OS X' ]]; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle osx
fi

# Load the theme.
antigen theme $HOME/.themes/huh.zsh-theme --no-local-clone
# Tell antigen that you're done.
antigen apply

export EDITOR="/usr/local/bin/emacs"
export PYTHONSTARTUP=~/.pythonrc
source /usr/local/share/zsh/site-functions/_aws
# Add GHC 7.8.3 to the PATH, via http://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.8.3.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

killd () {
  screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
}


alias memacs='open -a emacs'
