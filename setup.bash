#!/bin/bash

    # Check if Script is Run as Root
        if [[ $EUID -ne 0 ]]; then
          echo "You must be a root user to run this script, please run sudo ./setup.sh" 2>&1
          exit 1
        fi

    # Variables - (Username, Directory)
        username=$(id -u -n 1000)
        builddir=$(pwd)
        
    # Adding Nala and Items Needed For Adding Repositories
        sudo apt update
        sudo apt install nala -y
        sudo nala fetch --auto --fetches 4 -y
        sudo nala upgrade -y
        sudo nala install wget git gnupg lsb-release apt-transport-https ca-certificates -y

    # Additional Repositories Added

        # Protonvpn Repo
            wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
            sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb

        # Vscodium Repo
            wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
                | gpg --dearmor \
                | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
            echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
                | sudo tee /etc/apt/sources.list.d/vscodium.list

    # Installing Apps 
        sudo nala upgrade -y

        # Via Nala - (Blender, VLC, Htop, Flatpak, Plasma Discover Flatpak, Neovim, Keepassxc, Proton VPN, Ranger, ADB, Curl, Codium, Podman, Libreoffice, Kdenlive, ffempeg) 
            sudo nala install blender vlc htop flatpak plasma-discover-backend-flatpak neovim keepassxc ranger adb curl podman libreoffice kdenlive ffmpeg libsdl2-2.0-0 adb gcc pkg-config meson ninja-build libsdl2-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev libswresample-dev libusb-1.0-0 libusb-1.0-0-dev -y
            
        # Via Flatpak - (Freetube, Bottles, GIMP, Podman Desktop) 
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            flatpak install flathub io.freetubeapp.FreeTube -y
            flatpak install flathub com.usebottles.bottles -y
            flatpak install flathub org.gimp.GIMP -y
            flatpak install flathub io.podman_desktop.PodmanDesktop -y

        # Via Git Clone - (Scrcpy, Librewolf)
            git clone https://github.com/Genymobile/scrcpy
            cd scrcpy
            ./install_release.sh
            cd
            sudo bash Librewolf.bash

        # Via Curl - (Bun, Rust)
            curl -fsSL https://bun.sh/install | bash
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

        # Via W-get - (Superfile)
            bash -c "$(wget -qO- https://superfile.netlify.app/install.sh)"

        # Removes - (Firefox) 
            sudo nala purge firefox -y

    # Scripts Setup
        sudo bash Scripts_List/usenala

    # Clean Up
        clear
        echo "This program has installed nala, a custom media suite, librewolf, bun, rust, and some command line goodies."
