sudo apt update
sudo apt install nala -y
sudo nala upgrade -y
sudo nala install htop -y
sudo nala install vlc -y
sudo nala install blender -y
sudo nala purge firefox -y
sudo nala install -y wget gnupg lsb-release apt-transport-https ca-certificates

distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi)

wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg

sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null 
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF

sudo nala update
sudo nala install librewolf -y
sudo nala install flatpak -y
sudo nala install plasma-discover-backend-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub io.freetubeapp.FreeTube -y
sudo add-apt-repository ppa:phoerious/keepassxc
sudo nala update
sudo nala install keepassxc -y
sudo nala install neovim -y
flatpak install flathub com.usebottles.bottles -y
















