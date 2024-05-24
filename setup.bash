# Adding Nala and Items Needed For Adding Repositories
    sudo apt update
    sudo apt install nala -y
    sudo nala upgrade -y
    sudo nala install -y wget gnupg lsb-release apt-transport-https ca-certificates

# Additional Repositories Added

    #librewolf repo
        distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi) && wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg && sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
        Types: deb
        URIs: https://deb.librewolf.net
        Suites: $distro
        Components: main
        Architectures: amd64
        Signed-By: /usr/share/keyrings/librewolf.gpg
        EOF
    
    #keepassxc repo
        sudo add-apt-repository ppa:phoerious/keepassxc
    
    #flatpak repo
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    
    #protonvpn repo
        wget https://repo2.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3-3_all.deb
        sudo dpkg -i ./protonvpn-stable-release_1.0.3-3_all.deb
    
    #fastfetch
        sudo add-apt-repository ppa:zhangsongcui3371/fastfetch

# Installing Apps 
    sudo nala upgrade -y
    
    # Via Nala - (Blender, VLC, Htop, Flatpak, Plasma Discover Flatpak, Neovim, Librewolf, Keepassxc, Proton VPN, Fastfetch) 
        sudo nala install blender vlc htop flatpak plasma-discover-backend-flatpak neovim librewolf keepassxc proton-vpn-gnome-desktop fashfetch -y
   
    # Via Flatpak - (Freetube, Bottles, GIMP, Podman GUI) 
        flatpak install flathub io.freetubeapp.FreeTube -y
        flatpak install flathub com.usebottles.bottles -y
        flatpak install flathub org.gimp.GIMP -y
        flatpak install flathub io.podman_desktop.PodmanDesktop -y
    
    # Removes - (Firefox) 
        sudo nala purge firefox -y
