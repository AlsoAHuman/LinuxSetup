#!/bin/bash

    # Check if Script is Run as Root
        if [[ $EUID -ne 0 ]]; then
          echo "You must be a root user to run this script, please run sudo bash setup.bash" 2>&1
          exit 1
        fi
  
    # Variables - (Username, Directory)
        username=$(id -u -n 1000)
        builddir=$(pwd)
        
    # Adding Nala and Items Needed For Adding Repositories
        sudo apt update
        sudo apt install nala -y
        sudo nala fetch --https-only --auto --fetches 4 -y
        sudo nala upgrade -y
        sudo nala install wget git curl gnupg lsb-release apt-transport-https ca-certificates -y

    # Additional Repositories Added

         # Steam Repo
            sudo deb http://deb.debian.org/debian/ bookworm main contrib non-free
            sudo dpkg --add-architecture i386
        
        # Protonvpn Repo
            wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
            sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb

        # Fastfetch Repo
            FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)
        
        # Signal Desktop Repo
            wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
            cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
            echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
            sudo tee /etc/apt/sources.list.d/signal-xenial.list
        
        # Vscodium Repo
            wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
                | gpg --dearmor \
                | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
            echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
                | sudo tee /etc/apt/sources.list.d/vscodium.list

    # Installing Apps 
        sudo nala upgrade -y

        # Via Nala - (Blender, VLC, Flatpak, Signal, Keepassxc, Proton VPN, Ranger, ADB, VSCodium, Podman, Libreoffice, Kdenlive, ffempeg, preload) 
            # Native Section
                sudo nala install blender mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 vlc htop flatpak plasma-discover-backend-flatpak neovim keepassxc ranger fzf adb podman libreoffice kdenlive ffmpeg libsdl2-2.0-0 bat gcc pkg-config meson ninja-build libsdl2-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev libswresample-dev libusb-1.0-0 libusb-1.0-0-dev preload python3.11-venv -y

            # Added Repositories Section
                sudo nala install signal-desktop steam-installer -y
            
        # Via Flatpak - (Freetube, Bottles, GIMP, Podman Desktop, Flatseal) 
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
            flatpak install flathub io.freetubeapp.FreeTube -y
            flatpak install flathub com.usebottles.bottles -y
            flatpak install flathub org.gimp.GIMP -y
            flatpak install flathub io.podman_desktop.PodmanDesktop -y
            flatpak install flathub com.github.tchx84.Flatseal -y

        # Via Git Clone - (Scrcpy, Librewolf)
            sudo bash Librewolf.bash
            git clone https://github.com/Genymobile/scrcpy
            cd scrcpy
            ./install_release.sh
            cd
            cd My-Linux-Setup

        # Via Curl - (Bun, Rust, Fastfetch)
            curl -fsSL https://bun.sh/install | bash
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
            curl -sL $FASTFETCH_URL -o /tmp/fastfetch_latest_amd64.deb
            sudo nala install /tmp/fastfetch_latest_amd64.deb
            
        # Via W-get - (Superfile)
            bash -c "$(wget -qO- https://superfile.netlify.app/install.sh)"
            
        # Removes - (Firefox) 
            sudo nala purge firefox -y

    # Scripts Setup
        sudo bash Scripts_List/usenala.bash
        sudo bash Scripts_List/AutoUpdate.bash

    # Clean Up
        cd
        clear
        echo "This program has installed nala, a custom media suite, librewolf, bun, rust, and some command line goodies."
        echo "To see a full list of changes, run the command bash fullLS.bash"
