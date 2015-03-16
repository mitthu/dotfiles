# Environment Variables
# ---------------------
set -x EDITOR vim
set -x PATH $HOME/.me/bin $PATH $HOME/.bin /usr/java/default/bin $HOME/node_modules/.bin $HOME/.local/bin
set -x TERM xterm-256color
set -x TZ Asia/Kolkata
set -x HOSTALIASES ~/.hosts

# Show proper colors via less
set -x LESS -FRSX

# Source files in .melocal
. $HOME/.melocal/*.fish

# Aliases
. $HOME/.me/alias
alias re-source=". $HOME/.config/fish/config.fish"

# Homeshick utils
. $HOME/.homesick/repos/homeshick/homeshick.fish

# Python Helpers
set PYTHON_VIRTUALENV $HOME/.virtualenv
# Activate a virtualenv
function act
	. $PYTHON_VIRTUALENV/$argv/bin/activate.fish
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
# Pronunce dictionary word
# Source: http://askubuntu.com/questions/170775/offline-dictionary-with-pronunciation-and-usages
function defp
	espeak -ven-uk-rp -x -s 120 "$argv" -> /dev/null &
	def "$argv"
end
