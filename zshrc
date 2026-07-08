# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

export PATH=$PATH:$HOME/.local/share/bin
export EDITOR=vim
alias ls="eza --icons=auto"
alias du="dust "
alias grep="grep --color" 
alias keybind-on="sudo systemctl start keyd"
alias keybind-off="sudo systemctl stop keyd"
alias yay="yay --editmenu "
alias obs="MESA_GL_VERSION_OVERRIDE=3.3 MESA_GLSL_VERSION_OVERRIDE=330 obs"

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

bindkey -e

# compile jobs
# Temporarily cap CPU to 2.27 GHz for heavy compiling

    # Trap INT (Ctrl+C), TERM, and EXIT signals to always run the cleanup function
    trap cleanup INT TERM EXIT

    echo "Setting CPU max limit to 2.27 GHz for compilation..."
    sudo zsh -c 'for cpu in /sys/devices/system/cpu/cpu*/cpufreq; do
        echo 2267000 > "$cpu/scaling_max_freq"
    done'

    # Execute the actual compilation command
    "$@"
}


# fastfetch logos

# Kogasa2
alias fastfetch="echo; fastfetch --raw $HOME/.config/fastfetch/logos/Kogasa2.raw --logo-height 23 --logo-width 36 "

# Ctrl + Left Arrow
bindkey "^[[1;5D" backward-word

# Ctrl + Right Arrow
bindkey "^[[1;5C" forward-word

# Ctrl + Backspace
bindkey "^H" backward-kill-word


bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt MENU_COMPLETE
autoload -Uz compinit
compinit

setopt AUTO_MENU
zstyle ':completion:*' menu select



if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000000
SAVEHIST=1000000000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ali/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/prompt_powerlevel10k_setup

plugins=(colored-man-pages)
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# Created by `pipx` on 2026-04-01 02:49:04
export PATH="$PATH:/home/kogasa/.local/bin"

