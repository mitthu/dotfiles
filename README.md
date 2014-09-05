# Dotfiles
The repository hosts my dotfiles. Changes are only made to the `$HOME` directory of the user.
The repo. is actually a castle in terms of the project [andsens/homeshick](https://github.com/andsens/homeshick).
To actually deploy the castle, one first needs to clone and install the Homeshick project and then add the repo. as a castle.
One also needs to install a few dependency packages like `zsh`, `tmux`, `vim` etc.
After that one needs to run the one time install script present in the root directory of the castle.
All of the above can be done manually, but to keep things simple, an automated deployment script is created.
Refer the repo. [mitthu/dotfile_deploy](https://github.com/mitthu/dotfiles_deploy) for the **automated deployment script** or just run the command given below:

```bash
curl -sL http://bit.ly/1wgBOfx | /bin/bash -ex
```

## About the Castle
The castle contains configuration file for some packages and some simple bash functions.
Some other project repositories such as ohmyzsh are also present as a submodule.
The contents of the castle include:
- **Config files:** `.zshrc`, `.tmux.conf`, `.vimrc`, `.vim/`
- **My bash/zsh functions and scripts.** (`.merc` and `.me/`)
- My **nautilus scripts**.
- Some **local fonts** for supporting tmux-powerline fonts.
- **Installation Scripts:** `install.sh` and `personal.sh`.
- **Other Repos:**
  - `robbyrussell/oh-my-zsh`
  - `gnome-terminal-colors-solarized`
  - `vim-bundle/vim-colors-solarized`

### My Bash Functions
The usage of my bash functions is documented below.
- `me-update`: Updates the castle by updating from this repo..
- `me-update-repo`: Updates the castle by using the update script from the [mitthu/dotfile_deploy](https://github.com/mitthu/dotfiles_deploy) repo.
