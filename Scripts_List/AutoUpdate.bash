#!/bin/bash

  # Create a temporary file to store the new command
    temp_file=$(mktemp)
  
  # Add the new command to the temporary file
    echo "0 0 * * * sudo nala upgrade -y && sudo flatpak update -y" >> "$temp_file"
  
  # Append the contents of the temporary file to the crontab file
    crontab -l | cat - "$temp_file" | crontab -
  
  # Remove the temporary file
    rm "$temp_file"
