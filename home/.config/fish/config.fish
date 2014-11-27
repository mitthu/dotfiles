# Globals
# -------
set -Ux EDITOR vim
set -Ux PATH $PATH $HOME/.me/bin /usr/java/jdk1.7.0_67/bin
set -U TERM xterm-256color
# Show proper colors via less
set -x LESS -FRSX

# Aliases
# -------
# Resource dotfiles
alias re-source="source $HOME/.config/fish/config.fish"
alias v="gvim"

# Packages
alias au="sudo apt-get update"
alias au+="sudo apt-get upgrade"
alias ai="sudo apt-get install"
alias ar="sudo apt-get remove"
alias ar-="sudo apt-get purge"
alias apts="apt-cache search"

# Homeshick utils
alias hs="$HOME/.homesick/repos/homeshick/bin/homeshick"

# Vim: Vundle - Silently install bundles
alias vundle-install="vim +BundleInstall +qall"

# Editors
alias e="vim"

# Login helpers
## ssh as my user
alias s="ssh -l aditya.ba"
## ssh using automatic password typing
alias st="sshpass"
## ssh without using Public Key auth
alias ssh-no-pk="ssh -o PubkeyAuthentication=no"

# Network
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias d='dig +noall +answer'
alias dr='dig +noall +answer -x'

# Copy and paste (originally Mac commands)
alias lcopy='xsel --clipboard --input'
alias lpaste='xsel --clipboard --output'

# Tmux aliases
alias tmux='tmux -u'
alias ts='tmux new-session -s'
alias ta='tmux attach'
alias tas='tmux attach -t'
alias tl='tmux list-sessions'

# Git aliases
alias ga='git add'
alias gp='git push'
alias gl='git pull'
alias gst='git status'
alias gd='git diff'
alias gc='git commit'
alias gsync='git pull & git push'

# Python Helpers
set PYTHON_VIRTUALENV $HOME/.virtualenv
# Activate a virtualenv
function act
	source $PYTHON_VIRTUALENV/$argv/bin/activate.fish
end
# Create a virtualenv
function venv
	virtualenv $PYTHON_VIRTUALENV/$argv
end
# List all virtualenvs
function venvls
	ls $PYTHON_VIRTUALENV
end
# Remove virtualenv
function venvrm
	echo -n "Are you sure you want to remove $argv (y/N): "
	read answer
	switch $answer
		case y Y yes YES
			echo "Removing $argv."
			rm -rf $PYTHON_VIRTUALENV/$argv
		case '*'
			echo "Retaining $argv."
	end
end
