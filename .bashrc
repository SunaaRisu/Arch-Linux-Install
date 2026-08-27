#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias lava='lavat -G -g -c FF0000 -k F3D301'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fucku='sudo "$BASH" -c "$(history -p !!)"'
alias please='sudo'
alias bright='echo 96000 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias dark='echo 1000 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias normal='echo 16000 | sudo tee /sys/class/backlight/intel_backlight/brightness'
alias off='shutdown now'
alias authgit='ssh-add /home/sunaa/.ssh/sunaa_github'
alias netbird='netbird up --management-url https://sunaarisu.com'
alias updatenetbird='netbird down && curl -fsSLO https://pkgs.netbird.io/install.sh && chmod +x install.sh && ./install.sh --update && netbird up && rm ./install.sh'
PS1='[\u@\h \W]\$ '

eval $(ssh-agent)
eval "$(starship init bash)"

export CMAKE_EXPORT_COMPILE_COMMANDS=1
export EDITOR=nvim

# pnpm
export PNPM_HOME="/home/sunaa/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
