ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

unsetopt correct_all
unsetopt share_history
set emacs

# Add (SSH) to prompt if we are connected by ssh
if [[ -z "$SSH_CLIENT" ]]; then
  ssh_prompt=""
else
  ssh_prompt=" (%{$fg_bold[red]%}SSH%{$reset_color%})"
fi

dir_prompt=" [%3c]"

PROMPT="%{$fg_bold[yellow]%}%n@%{$fg_bold[yellow]%}%m%{$reset_color%}$ssh_prompt$dir_prompt %{$fg[red]%}➜%{$reset_color%} "

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ~="cd ~"
alias cdo="cd .."
alias ..="cd .."

alias diffc="colordiff"
alias cdo="cd .."
alias cdl="cd $1; ls"

alias meminfo="watch -n0.1 cat /proc/meminfo"

alias "rmrf"="rm -rfi"
alias "getip"="curl ifconfig.me"
alias "dnsflush"="sudo killall -HUP dnsmasq"
