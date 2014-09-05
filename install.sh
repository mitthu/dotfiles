#!/bin/bash
# Date of creation: 1-Aug-2014, 7:54 PM
# Author: mitthu
# Job:
# ---
# Run this script after fresh installation, on a new machine.

source $HOME/.merc

# Update the ~/.bashrc
if [[ -z `grep "source ~/.merc"  <~/.bashrc` ]]; then
	echo "Add sourcing of .merc in ~/.bashrc"
	cat >>~/.bashrc <<-EOF
	# My Custom Profile
	source ~/.merc
	EOF
fi

# Install vundle plugins
vim +BundleInstall +qall </dev/tty
