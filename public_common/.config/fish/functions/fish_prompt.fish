set normal (set_color normal)
set bold (set_color -o normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)
set host_colour (set_color $host_prompt_colour)

# git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# status chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

function fish_prompt
	set last_status $status
  set env_string ''
  if set -q VIRTUAL_ENV
    set env_string ' ['(basename "$VIRTUAL_ENV")' env]'
  end
  set_color normal
  printf "%s@$host_colour%s$normal$env_string $bold%s " (whoami) (hostname) (prompt_pwd)
  set_color normal
end
