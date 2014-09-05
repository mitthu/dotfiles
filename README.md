# Dotfiles
The repository hosts my dotfiles. Changes are only made to the `$HOME` directory of the user.
The repo. is actually a castle in terms of the project (Homeshick)[andsens/homeshick].
To actually deploy the castle, one first needs to clone and install the Homeshick project and then add the repo. as a castle.
One also needs to install a few dependency packages like tmux, vim etc.
After that one needs to run the one time install script present in the root directory of the castle.
All of the above can be done manually, but for keeping things simple, an automated deployment script is also in place.
Refer the repo. mitthu/dotfile_deploy for the automated deployment script or just run the command given below:
```bash
curl -sL http://bit.ly/1wgBOfx | /bin/bash -ex
```

## About the Castle
The castle contains configuration file for some packages and some simple bash functions.
