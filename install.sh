#!/bin/bash
# Date of creation: 1-Aug-2014, 7:54 PM
# Author: mitthu
# Job:
# ---
# Run this script after fresh installation, on a new machine.

source $HOME/.merc
echo "source ~/.merc" >>~/.bashrc

# Install vundle plugins
vim +BundleInstall +qall
