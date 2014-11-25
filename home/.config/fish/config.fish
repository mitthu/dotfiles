# Globals
# -------
set -U EDITOR gvim
set -U PATH $PATH $HOME/.me/bin /usr/java/jdk1.7.0_67/bin
set -U TERM xterm-256color

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

# Misc.
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'

# Copy and paste (originally Mac commands)
alias lcopy='xsel --clipboard --input'
alias lpaste='xsel --clipboard --output'

# Tmux aliases
alias tmux='tmux -u'
alias ts='tmux new-session -s'
alias ta='tmux attach'
alias tas='tmux attach -t'
alias tl='tmux list-sessions'
