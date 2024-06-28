#!/bin/bash
    sudo apt update
    sudo apt install nala -y
    sudo nala install wget gnupg lsb-release apt-transport-https ca-certificates -y
    cd /my-linux-setup
    sudo bash ./Repos_List/LibrewolfRepo.bash
    sudo nala update
    sudo nala install librewolf -y