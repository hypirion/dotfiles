# dotfiles

hyPiRion's assorted collection of arcane setups.

Because it's always nice to have your setup in a repository, especially when
you're constantly experimenting with your setup.

## Setup

Right, there is a bit of setup before you can use everything. I'm going to write
a script to set this up but, in the meantime...

Generally, ensure that the submodules are there. You can do that by issuing
following commands:

```bash
git submodule init
git submodule update
```

### Zsh Goodies

`zsh` needs to have zsh installed, obviously. Before `.zshrc` kicks in, symlink
the `.fonts` directory and ensure that the default terminal is the XFCE
terminal. After that, run the following commands:

```bash
ln -s ~/.dotfiles/.fonts ~/.fonts
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d
ln -s ~/.dotfiles/.config/fontconfig/conf.d/10-powerline-symbols.conf \
  ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
mkdir -p ~/.config/xfce4/terminal/
ln -s ~/.dotfiles/.config/xfce4/terminal/terminalrc \
  ~/.config/xfce4/terminal/terminalrc
mkdir -p ~/.local/share/xfce4/terminal
ln -s ~/.dotfiles/.local/share/xfce4/terminal/colorschemes \
  ~/.local/share/xfce4/terminal/colorschemes
ln -s ~/.dotfiles/.zshrc ~/.zshrc
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
chsh -s /bin/zsh
```

Then, install powerlevel10k from inside zsh (will presumably run
with some errors):

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
ln -s ~/.dotfiles/.p10k.zsh ~/.p10k.zsh
```

When you've reloaded, that should be it.

## Day/night colourscheme change

I have some cronjobs that change the terminal colours by just swapping the
terminalrc contents with some predefined stuff I made. My crontab for these
tasks looks like this:

```
@reboot python3 ~/bin/fix-xfce4-terminal-colours.py
@hourly python3 ~/bin/fix-xfce4-terminal-colours.py
```

To get this to run, you must perform the following commands:

```
mkdir -p ~/bin
cp ~/.dotfiles/fix-xfce4-terminal-colours.py ~/bin/fix-xfce4-terminal-colours.py
rm ~/.config/xfce4/terminal/terminalrc
cp ~/.dotfiles/.config/xfce4/terminal/terminalrc-light \
  ~/.config/xfce4/terminal/terminalrc
cp ~/.dotfiles/.config/xfce4/terminal/terminalrc-light \
  ~/.config/xfce4/terminal/terminalrc-light
cp ~/.dotfiles/.config/xfce4/terminal/terminalrc-dark \
  ~/.config/xfce4/terminal/terminalrc-dark
```

Note that I kill the symlinks because it messes up my .dotfile git repo, and I
typically tune the font size a bit depending on HiDPI etc.

## Licenses

Copyright © 2012-2020 Jean Niklas L'orange

Distributed under the MIT License (MIT). You can find a copy in the root of
this directory with the name `LICENSE`.
