

domain='%n@%m'
stuff='%{$fg_bold[cyan]%}($fg[red]${domain}%{$fg_bold[cyan]%}):'
PROMPT='%{$fg_bold[cyan]%}λ %{$fg_bold[cyan]%}(%{$fg[red]%}%n@%m%{$fg_bold[cyan]%}):%{$fg_bold[cyan]%}%p %{$fg[green]%}%c $(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}] %{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}]"
