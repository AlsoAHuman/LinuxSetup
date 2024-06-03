# Check if Script is Run as Root
    if [[ $EUID -ne 0 ]]; then
      echo "You must be a root user to run this script, please run sudo ./setup.sh" 2>&1
      exit 1
    fi

# Adding Nala and Items Needed For Adding Repositories
    sudo apt update
    sudo apt install nala -y
    sudo nala fetch --auto --fetches 4 -y
    sudo nala upgrade -y
    sudo nala install wget gnupg lsb-release apt-transport-https ca-certificates -y

# Additional Repositories Added

    # Librewolf Repo
        sudo bash ./librewolfRepo.bash

    # Keepassxc Repo
        sudo add-apt-repository ppa:phoerious/keepassxc
    
    # Flatpak Repo
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    
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
    
    # Via Nala - (Blender, VLC, Htop, Flatpak, Plasma Discover Flatpak, Neovim, Librewolf, Keepassxc, Proton VPN, Ranger, ADB, Curl, Codium, Podman, Libreoffice, Kdenlive) 
        sudo nala install blender vlc htop flatpak plasma-discover-backend-flatpak neovim librewolf keepassxc proton-vpn-gnome-desktop ranger adb curl codium podman libreoffice kdenlive -y
   
    # Via Flatpak - (Freetube, Bottles, GIMP, Podman Desktop) 
        sudo flatpak install flathub io.freetubeapp.FreeTube -y
        sudo flatpak install flathub com.usebottles.bottles -y
        sudo flatpak install flathub org.gimp.GIMP -y
        sudo flatpak install flathub io.podman_desktop.PodmanDesktop -y

    # Via Curl - (Bun, Rust)
        curl -fsSL https://bun.sh/install | bash
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Via W-get - (Superfile)
        bash -c "$(wget -qO- https://superfile.netlify.app/install.sh)"
    
    # Removes - (Firefox) 
        sudo nala purge firefox -y

# Scripts Setup
