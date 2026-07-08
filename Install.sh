#!/bin/bash

zsh_config="$HOME/.zshrc"
current_config=("$HOME"/.config/{fastfetch,sway,foot,swaync,rofi})
backup_config=(./backups/{fastfetch,sway,foot,swaync,rofi})
packages=(
    # Core Compositor & Themes
    sway
    nwg-look
    rofi
    waybar
    vim
    neo-candy-icons-git
    
    # Wayland Essentials (Missing from your list)
    swaybg          # Sets your wallpaper in Sway
    swaylock        # Screen locker
    swayidle        # Handles idle timeouts (sleep, lock)
    swaync
    
    # System Controls & Utilities
    brightnessctl   # Screen brightness control (great for Waybar/bindsym)
    pamixer         # PulseAudio/PipeWire volume control CLI
    grim            # Screenshot utility (capture screen)
    slurp           # Region selector for screenshots
    wl-clipboard    # Clipboard support (copy/paste in Wayland)
    
    # Fonts & Aesthetics
    ttf-nerd-fonts-symbols  # Needed for icons in fastfetch, Waybar, exa
    otf-font-awesome        # Popular icon font for Waybar modules
)

if [ ! -f "/bin/figlet" ]; then
    sudo pacman -Sy figlet
fi

function grab_config() {
    echo "grabbing config files"
    cp -rvf "${current_config[@]}" "$zsh_config" ./test
}

function setup_zsh() {
    sudo pacman -Syu 
    echo "Installing zsh-theme=powerlevel"
    yay -Syu zsh-theme-powerlevel10k
    echo "follow the installation guide"
    sourcce /usr/share/zsh-theme-powerlevel10k/prompt_powerlevel10k_setup
    cp ./zshrc "$zsh_config"
    echo "Done!"
}

function restore() {
    echo "Restoring your old config"
    cp -rvf "${backup_config[@]}" "$HOME/.config/"
}

function config_install() {
    echo "Installing the config files..."
    cp -rvf "${current_config[@]}" "$HOME/.config/"
}

function packages_install() {
    echo "Installing the packages needed"
    yay -Syu "${packages[@]}" --needed
}

function copying() {
        read -rp "Do you want to proceed? (y/n) " response

        case "${response,,}" in
            y|yes)
                echo "Backing up the current configs..."
                cp -rvf "${current_config[@]}" ./backups

                config_install
                ;;
            n|no)
                echo "cancelling, byebye!!"
                ;;
            *)
                echo "Stupid user detected!!!"
                ;;
        esac
}

function detections() {
    # Warning if files exists
    if [ -f "$HOME/.config/swaync/config.json" ]; then
        printf "The file exist, your old configs are going to ./backups."
        copying
    else
        echo "File not found!"
    fi
}

setup_yay() {
    figlet "Install yay?"
        read -rp "Do you want to proceed? (y/n) " response

        case "${response,,}" in
            y|yes)
                echo "Installing Yay"
                sudo pacman -Sy git --needed
                git clone https://aur.archlinux.org/yay.git /tmp/yay.git
                cd "/tmp/yay.git" || exit
                makepkg -Csi
                ;;
            n|no)
                echo "cancelling, byebye!!"
                ;;
            *)
                echo "Stupid user detected!!!"
                ;;
        esac
}

setup_yay

packages_install


# grab_config
# detections
