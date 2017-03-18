
if [[ -z ${COOL_DOG} ]]; then
   export COOL_DOG='༼´◉◞౪◟◉༽'
fi
function prompt_huh_setup {
  setopt LOCAL_OPTIONS
  domain='%n@%m'
  COOL_DOG='༼´◉◞౪◟◉༽'
  stuff='%{$fg_bold[cyan]%}($fg[red]${domain}%{$fg_bold[cyan]%}):'
  PROMPT='%F{cyan}༼´◉◞౪◟◉༽ (%f%F{red}%n@%m%f%F{cyan}):%p%f %F{green}%c  %f'

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$fg[cyan]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}] %{$fg[yellow]%}⚡%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}]"
}

prompt_huh_setup "$@"
