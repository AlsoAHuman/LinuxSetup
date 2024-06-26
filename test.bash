#!/bin/bash
    sudo apt install curl -y
    yes -s "1" | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh