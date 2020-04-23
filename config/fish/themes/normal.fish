


function _git_branch_name

  set -l cyan (set_color cyan)
  set -l green (set_color green)
  set -l branchname (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
  if test -n "$branchname"
    echo $green$branchname$cyan\]
  else
    echo ''
  end
end

function _git_status_symbol
  set -l yellow (set_color yellow)
  if test -n "$git_status"
    # Is there anyway to preserve newlines so we can reuse $git_status?
    if git status --porcelain 2> /dev/null | grep '^.[^ ]' >/dev/null
      echo '$yellow🗲 ' # dirty
    else
      echo '$yellow#' # all staged
    end
  else
    echo    '' # clean
  end
end

function _remote_hostname
  echo (whoami)@(hostname)
end

function fish_prompt
  set -l cyan (set_color cyan)
  set -l normal (set_color normal)
  set -l red (set_color red)

  set -l cwd (set_color $fish_color_cwd)(prompt_pwd)
  set -l git_status $cyan(_git_status_symbol)$cyan(_git_branch_name)

  echo -n $red(_remote_hostname) $cwd$cyan$git_status$normal'⤇ '
end
