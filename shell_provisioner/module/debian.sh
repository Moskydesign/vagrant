#!/bin/bash

# Debian

# Locales
sed -i 's/# nl_BE.UTF-8 UTF-8/nl_BE.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
# echo 'LANG=nl_BE.UTF-8' > /etc/default/locale

# Timezone
echo "Europe/Brussels" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# Custom bash prompt
echo "PS1='[\[\033[00;34m\]\u@\h \e[1mDEV\[\033[00m\] \[\033[00;31m\]\w\[\033[00m\]]\n\\$ '" >> /etc/bash.bashrc
echo "PS1='[\[\033[00;34m\]\u@\h \e[1mDEV\[\033[00m\] \[\033[00;31m\]\w\[\033[00m\]]\n\\$ '" >> /home/vagrant/.bashrc

# arrow up/down history behavior
cat << EOF >/root/.inputrc
"\e[A": history-search-backward
"\e[B": history-search-forward
set show-all-if-ambiguous on
set completion-ignore-case on
EOF
cp /root/.inputrc /home/vagrant
chown vagrant:vagrant /home/vagrant/.inputrc

# Console keyboard
sed -i 's/XKBLAYOUT=.*/XKBLAYOUT="be"/' /etc/default/keyboard
setupcon --force

# Host file
echo 127.0.0.1 $APP_DOMAIN >> /etc/hosts

# Enable backports
echo -e "\ndeb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

# Sync package index files
apt-get update
apt-get install -y apt-transport-https lsb-release ca-certificates

