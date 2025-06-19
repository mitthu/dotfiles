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

# Run myupdate to add cron entry
~/.me/bin/myupdate

# Install atuin.sh
if ! command -v atuin >/dev/null 2>&1; then
	curl --proto '=https' --tlsv1.2 -LsSf https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh | sh

    # Remove plugin entry added by atuin to ~/.bashrc
	cp ~/.bashrc ~/.bashrc.bak
	awk '{
        lines[NR] = $0
    }
    /.atuin\/bin\/env/ {
        last = NR
    }
    END {
        for (i = 1; i <= last; i++)
            print lines[i]
    }' ~/.bashrc.bak >~/.bashrc

fi

# Start systemd services
if command -v systemctl >/dev/null 2>&1; then
    systemctl --user daemon-reload
    systemctl --user enable atuin.service
    systemctl --user start atuin.service
fi

