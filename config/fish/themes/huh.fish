#!/usr/local/bin/fish
set -g fish_color_error red --bold
set -g fish_color_command cyan --bold
set -g fish_color_quote green -i
set faces "༼´◉◞౪◟◉༽" "║ ≖д≖ ║" "ʕ✿´꒳` ʔ" "ᕙ(⇀‸↼‶)ᕗ" "{๑･ ロ ･๑}" "[ɵ̥̥ ˑ̫ ɵ̥̥]" "( ͒ ˃̣̣̥᷄ꇵ͒˂̣̣̥᷅ ू ͒)"
set colours "cyan" "blue" "magenta" "normal" "purple" "FFA500" "328332" "yellow" "2B6AB2"
function fish_prompt
  set face (set_color (random choice $colours))(random choice $faces)
  set bncolor (set_color green)
  if test $status -gt 0
    echo $status
    set bncolor (set_color red)
  end
  set bn $bncolor(basename (pwd))
  set div (set_color yellow)"⊢"
  #set communism='☭'
  echo $face $bn $div (set_color normal)
end
