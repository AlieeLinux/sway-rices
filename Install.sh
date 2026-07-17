#!/bin/bash

zsh_config="$HOME/.zshrc"
current_config=("$HOME"/.config/{fastfetch,sway,foot,swaync,waybar,rofi})
backup_config="./backups"

packages=(
    # Core Compositor & Themes
    sway
    nwg-look
    rofi
    waybar
    vim
    neo-candy-icons-git
    waybar
    python-pywal16
    
    # Wayland Essentials
    swaybg
    swaylock
    swayidle
    swaync
    swaylock-effects-git
    
    # System Controls & Utilities
    brightnessctl
    pamixer
    grim
    slurp
    wl-clipboard
    
    # Fonts & Aesthetics
    ttf-nerd-fonts-symbols
    zsh-theme-powerlevel10k
    otf-font-awesome

    # Utiles
    thunar
    gnome-system-monitor
)

# Ensure figlet is present
if ! command -v figlet &> /dev/null; then
    sudo pacman -Sy --needed figlet
fi

grab_config() {
    echo "Grabbing current config files..."
    mkdir -p ./test
    cp -rvf "${current_config[@]}" ./test/
}

temp_color() {
    wal -i "./rainbow.png" -n
}

link_config() {
    echo "Linking needed color schemes..."
    ln "$HOME/wal/colors-waybar.css" "$HOME/.config/waybar/colors.css"
    ln "$HOME/wal/colors-waybar.css" "$HOME/.config/swaync/colors.css"
}

setup_zsh() {
    sudo pacman -Syu --needed
    echo "Installing zsh-theme-powerlevel10k via yay..."
    yay -S --needed zsh-theme-powerlevel10k
    echo "Follow the installation guide or source the theme:"
    # shellcheck disable=SC1091
    source "/usr/share/zsh-theme-powerlevel10k/prompt_powerlevel10k_setup.zsh" 2>/dev/null || true
    if [ -f "./zshrc" ]; then
        cp ./zshrc "$zsh_config"
    fi
    echo "Zsh setup done!"
}

restore() {
    echo "Restoring your old config from backups..."
    cp -rvf "$backup_config"/* "$HOME/.config/"
}

config_install() {
    echo "Installing the config files to $HOME/.config/..."
    cp -rvf "./configs"/* "$HOME/.config/"
}

packages_install() {
    echo "Installing the packages needed..."
    yay -Syu "${packages[@]}" --needed
}

copying() {
    read -rp "Do you want to proceed with installation & backup? (y/n) " response
    case "${response,,}" in
        y|yes)
            echo "Backing up current configs to $backup_config..."
            mkdir -p "$backup_config"
            cp -rvf "${current_config[@]}" "$backup_config/"

            config_install
            packages_install
            ;;
        n|no)
            echo "Cancelling, byebye!!"
            ;;
        *)
            echo "Invalid option selected!"
            ;;
    esac
}

detections() {
    # Check if config directory/file exists before deciding to backup
    if [ -d "$HOME/.config/sway" ]; then
        printf "Existing configs detected. Old configs will be backed up.\n"
        copying
    else
        echo "No existing Sway config found. Proceeding with fresh install..."
        config_install
        packages_install
    fi
}

setup_yay() {
    figlet "Install yay?"
    read -rp "Do you want to proceed? (y/n) " response
    case "${response,,}" in
        y|yes)
            echo "Installing Yay..."
            sudo pacman -S --needed git base-devel
            git clone https://aur.archlinux.org/yay.git /tmp/yay.git
            cd "/tmp/yay.git" || exit
            makepkg -si
            cd - || exit
            ;;
        n|no)
            echo "Skipping yay installation."
            ;;
        *)
            echo "Invalid choice!"
            ;;
    esac
}

# --- Main Execution Flow ---
setup_yay
detections