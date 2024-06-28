#!/bin/bash
    sudo apt update
    sudo apt install nala -y
    sudo nala install wget gnupg lsb-release apt-transport-https ca-certificates -y
    
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

    sudo bash ./Repos_List/LibrewolfRepo.bash