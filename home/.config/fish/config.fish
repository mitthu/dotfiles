# Environment Variables
# ---------------------
set -x EDITOR vim
set -x TERM xterm-256color
set -x HOSTALIASES ~/.hosts

# Setup PATH
# Function: add_before_path => Prefix/Prepend path with directory (if it exists)
# Note: This function variant can add multiple directories at once.
function add_before_path -d "add_before_path /foo /bar ..."
	# iterate over all arguments
	for i in (seq 1 (count $argv))
		# if directory exists, add it to $PATH
		if test -d $argv[$i]
			set -x PATH $argv[$i] $PATH
		end
	end
end

# Function: add_after_path => Suffix/Append path with directory (if it exists)
# Note: Only one directory at a time.
function add_after_path -d "add_after_path /foo"
	if test -d $1
		set -x PATH $PATH $1
	end
end

# Update $PATH: load my bin/ locations
add_before_path $HOME/.me/bin
add_before_path $HOME/.local/bin
add_before_path $HOME/.bin
add_before_path $HOME/bin

# Update $PATH: misc.
add_after_path /usr/java/default/bin
add_after_path $HOME/node_modules/.bin
add_after_path $HOME/apps/packer

# Show proper colors via less
set -x LESS -FRSX

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
# Stop and delete a container
function dkrm
	docker stop $argv
	docker rm $argv
end
# Exec bash on docker container
function dkexec
	docker exec -it $argv /bin/bash
end

# Source files in .melocal
# These take precedence over aliases.
. $HOME/.melocal/*.fish

