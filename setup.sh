#!/usr/bin/env bash

set -euo pipefail

## TODO: Ensure it is run as root

apt-get update
apt-get upgrade

## Install emacs

apt-get install -y git
apt-get build-dep -y emacs24

cd /opt
git clone --depth 1 git://git.sv.gnu.org/emacs.git

cd emacs
./autogen.sh
./configure
make bootstrap
make install

## Install Spotify

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
     --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free \
     > /etc/apt/sources.list.d/spotify.list
apt-get update
apt-get install -y spotify-client

## Install chrome

tmpdir="$(mktemp -d)"
cd "$tmpdir"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
## TOOD: the following command will fail
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -fy

## Haskell Stack

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
     --recv-keys 575159689BEFB442
echo 'deb http://download.fpcomplete.com/debian jessie main' \
     > /etc/apt/sources.list.d/fpco.list
apt-get update
apt-get install -y stack

## Xmonad

apt-get install -y xmonad libghc-xmonad-contrib-dev

## TODO: Setup xmonad config here.
## Notes: use `xmonad --replace && xfce4-panel --restart`

## Install zsh

apt-get install -y zsh


## Install Java 8

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

apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo 'deb https://apt.dockerproject.org/repo debian-jessie main' \
     > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y docker-engine
service docker start

groupadd docker
gpasswd -a jeannikl docker
service docker restart
