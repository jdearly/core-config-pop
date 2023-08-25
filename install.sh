#!/bin/bash

echo "Upgrading and installing ansible and git"
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install ansible git -y

echo "Configuring git locally..."
read -p 'Github user: ' gituser
read -p 'Github email: ' gitemail
git config --global user.email "$gitemail"
git config --global user.name "$gituser"

echo "Setting up SSH key, using github email"
ssh-keygen -t ed25519 -C "$gitemail"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

echo "Copy and add the new public key to GitHub"
cat ~/.ssh/id_ed25519.pub
echo "PRESS ENTER TO CONTINUE SETUP"
read -n 1 -s

echo "Pulling ansible config"
ansible-pull -U https://github.com/jdearly/core-config-pop.git -K
