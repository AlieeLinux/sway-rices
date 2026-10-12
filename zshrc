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


debian-chroot() {
    # Debian 32-bit
    if ! mountpoint -q /mnt/debian/run; then
        sudo mount --rbind /run /mnt/debian/run
    fi

    if ! mountpoint -q /mnt/debian/dev; then
        sudo mount --rbind /dev /mnt/debian/dev
    fi

    # Debian 64-bit
    if ! mountpoint -q /mnt/debian/dev; then
        sudo mount --rbind /dev /mnt/debian/dev
    fi

    if ! mountpoint -q /mnt/debian/proc; then
        sudo mount --rbind /proc /mnt/debian/proc
    fi

    if ! mountpoint -q /mnt/debian/sys; then
        sudo mount --rbind /sys /mnt/debian/sys
    fi

    if ! mountpoint -q /mnt/debian/run; then
        sudo mount --rbind /run /mnt/debian/run
    fi

    # Enter Debian 32-bit
    sudo chroot /mnt/debian su - koishi
}

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

bindkey -e

# compile jobs
# Temporarily cap CPU to 2.27 GHz for heavy compiling
compile_capped() {
    # Define the cleanup routine
    cleanup() {
        echo -e "\n[!] Cleanup triggered. Restoring full 2.40 GHz range..."
        sudo zsh -c 'for cpu in /sys/devices/system/cpu/cpu*/cpufreq; do
            echo 2400000 > "$cpu/scaling_max_freq"
        done'
    }

    # Trap INT (Ctrl+C), TERM, and EXIT signals to always run the cleanup function
    trap cleanup INT TERM EXIT

    echo "Setting CPU max limit to 2.27 GHz for compilation..."
    sudo zsh -c 'for cpu in /sys/devices/system/cpu/cpu*/cpufreq; do
        echo 2267000 > "$cpu/scaling_max_freq"
    done'

    # Execute the actual compilation command
    "$@"
}

# Teto
## Teto 1

alias fastfetch="fastfetch --raw $HOME/.config/fastfetch/logos/teto.raw --logo-height 26 --logo-width 34"

# fastfetch logos
# Rumia
# alias fastfetch="fastfetch --raw $HOME/.config/fastfetch/logos/aki2.raw --logo-height 29 --logo-width 36"

# Koishi Komeji
# alias fastfetch="fastfetch --raw $HOME/.config/fastfetch/koishi.sixel --logo-height 20 --logo-width 36"

# Satori Komeiji
# alias fastfetch="fastfetch --raw $HOME/.config/fastfetch/satori.sixel --logo-height 24 --logo-width 32"

# Satori Komeiji 2
# alias fastfetch="echo; fastfetch --raw $HOME/.config/fastfetch/satori2.sixel --logo-height 27 --logo-width 33"

# satorisexy
#alias fastfetch="echo&&echo;fastfetch --raw $HOME/.config/fastfetch/logos/satorisexy.raw --logo-height 27 --logo-width 34"

# Satori 3
# alias fastfetch="fastfetch --raw $HOME/.config/fastfetch/satori3.sixel --logo-height 24 --logo-width 33"

# Kaguya Houraisan 1
# alias fastfetch="fastfetch --raw $HOME/.config/fastfetch/kaguya.raw --logo-height 22 --logo-width 32"

# KAguya Houraisan 2
# alias fastfetch="fastfetch --raw ~/.config/fastfetch/kaguya2.raw --logo-height 27 --logo-width 36"

# Suika Ibuki
# alias fastfetch="fastfetch --raw ~/.config/fastfetch/Ibuki.raw --logo-height 25 --logo-width 29"

# Aki sisters
# alias fastfetch="fastfetch --raw ~/.config/fastfetch/aki1.raw  --logo-height 25 --logo-width 36"

# Aki sisters 2
# alias fastfetch="fastfetch --raw ~/.config/fastfetch/aki2.raw  --logo-height 27 --logo-width 38"

# Kogasa
# alias fastfetch="echo ; fastfetch --raw $HOME/.config/fastfetch/logos/Kogasa.raw --logo-height 25 --logo-width 36"

# Kogasa2
#alias fastfetch="echo;fastfetch --raw $HOME/.config/fastfetch/logos/Kogasa2.raw --logo-height 32 --logo-width 36 "

#alias fastfetch="echo ;fastfetch --raw $HOME/.config/fastfetch/logos/teto.raw --logo-height 25 --logo-width 39"

## kaguyama
# alias fastfetch="echo ;fastfetch --raw $HOME/.config/fastfetch/logos/kagiyama.raw --logo-height 28 --logo-width 35"

## Flandre
#alias fastfetch="echo ;fastfetch --raw $HOME/.config/fastfetch/logos/flandre.raw --logo-height 30 --logo-width 33"

## Kokoro
#alias fastfetch="echo;fastfetch --raw ~/.config/fastfetch/logos/kokoro.raw --logo-height 30 --logo-width 37" 

## kokoro2
#alias fastfetch="echo;fastfetch --raw ~/.config/fastfetch/logos/kokoro2.raw --logo-height 22 --logo-width 34" 

## China
# alias fastfetch="echo;echo;fastfetch --raw ~/.config/fastfetch/logos/china.raw --logo-height 21 --logo-width 34" 

## Mac change "EG: 60:60:1F
koishi-change-mac() {
    local mac_address

    if [[ -n "$1" ]]; then
        mac_address="$1"
    else
        mac_address=$(printf '60:60:1f:%02x:%02x:%02x' $((RANDOM % 256)) $((RANDOM % 256)) $((RANDOM % 256)))
    fi

    echo "Setting wlan0 MAC to: $mac_address"
    sudo ip link set wlan0 down && \
    sudo macchanger -m "$mac_address" wlan0 && \
    sudo ip link set wlan0 up
}



#alias koishi-change-mac="sudo ip link set wlan0 down && sudo macchanger -m 60:60:1f:\$(printf '%02x:%02x:%02x' \$((RANDOM%256)) \$((RANDOM%256)) \$((RANDOM%256))) wlan0 && sudo ip link set wlan0 up"

alias play-osu="cd ~/games/osu/ && wine osu\!.exe"

#############################

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


# Created by `pipx` on 2026-07-29 04:36:35
export PATH="$PATH:/home/koishi/.local/bin"
export TERM=xterm-256color

# Created by `pipx` on 2026-10-11 15:49:23
export PATH="$PATH:/home/ali/.local/bin"
