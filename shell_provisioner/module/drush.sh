#!/bin/bash

# Drush and Drupal Console
curl https://s3.amazonaws.com/files.drush.org/drush.phar -L -o drush.phar
mv drush.phar /usr/bin/drush
chmod +x /usr/bin/drush
su - vagrant -c 'composer global require drupal/console --prefer-dist --optimize-autoloader --sort-packages'
ln -sf /home/vagrant/.composer/vendor/bin/drupal /usr/bin/drupal

# Install Drupal Console
su - vagrant -c 'mkdir -p /home/vagrant/.console/chain'
su - vagrant -c 'drupal init --override'
echo 'source "/home/vagrant/.console/console.rc" 2>/dev/null' >> /home/vagrant/.bashrc
su - vagrant -c 'mkdir -p /home/vagrant/.config/fish/completions'
ln -sf /home/vagrant/.console/drupal.fish /home/vagrant/.config/fish/completions/drupal.fish
su - vagrant -c 'drupal check'
su - vagrant -c 'composer global update'
