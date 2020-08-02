#!/usr/bin/env bash

# I tend to do this manually, because there's always one or more steps that just
# fail.

sudo apt update && sudo apt full-upgrade && sudo apt install htop git clang curl

git config --global user.name "Jean Niklas L'orange"
git config --global user.email "jeannikl@hypirion.com"

## Install emacs

# Tune /etc/apt/sources.list to include deb-src with them, then run

sudo apt update
sudo apt build-dep emacs24

cd /opt
sudo git clone --depth 1 git://git.sv.gnu.org/emacs.git

cd emacs
# enter sudo mode
sudo su
./autogen.sh
./configure CC=clang CFLAGS="-O3"
export MAKEFLAGS="-j$(nproc)"
make bootstrap
make install

# exit sudo mode
# ctrl-d

## Install Spotify

# (ugh)
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt install spotify-client

## Install chrome


## Xmonad

# Before you go here, go to keyboard settings and remove so-to-say all Super
# commands. Then, set up the following super commands:

# Super + P => xfrun4
# Super + F1 => xfce4-session-logout

sudo apt install xmonad libghc-xmonad-contrib-dev

ln -s ~/.dotfiles/.xmonad ~/.xmonad

# Enter Session and Startup => Application Autostart, and ensure the GNOME
# secret service + SSH agent is running if you experience download trouble. Then
# add the following command to get xmonad + xfce4 to run on startup nicely

# Name:XFCE4-panel hack
# Description To get xmonad + xfce4 to work together nicely
# Command: sh -c "sleep 4 && xfce4-panel restart"
# Trigger: on login

# Note: sleep 4 is tuned to the system. Sometimes you can get away with less,
# feel free to attempt to tune it if you're annoyed by it. Sometimes I need to
# replace this with the more intricate command sh -c "sleep 4 && killall xfce4-panel && xfce4-panel"

# Name: Xmonad
# Description: <none>
# Command: xmonad --replace
# Trigger: on login

## Install zsh

sudo apt install zsh

## See additional steps in README.md


## Install Java 8 (Optional)

cat > /etc/apt/sources.list.d/java-8-debian.list <<EOF 
deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
EOF

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update
apt-get install -y oracle-java8-installer


## Prep for gvm

apt-get install -y bison


## Docker

# Eh, just follow https://docs.docker.com/engine/install/ubuntu/

# Then run the following command
sudo usermod -aG docker jeannikl
