#!/bin/bash

current_config=("$HOME"/.config/{fastfetch,sway,foot,swaync})
backup_config=(./backups/{fastfetch,sway,foot,swaync})

function restore() {
    echo "Restoring your old config"
    cp -rvf "${backup_config[@]}" "$HOME/.config/"
}

function config_install() {
    echo "Installing the config files..."
    cp -rvf "${current_config[@]}" "$HOME/.config/"
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


detections