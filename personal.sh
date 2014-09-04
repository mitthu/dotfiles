#!/bin/bash
# Date of creation: 04-Sept-2014, 5:39 PM
# Author: mitthu
# Job:
# ---
# Run this script on personal computers.

echo "Update repo. links to ssh version..."
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

echo "Updating the dotfiles castle..."
homeshick cd dotfiles
git remote set-url origin git@github.com:mitthu/dotfiles_deploy.git

