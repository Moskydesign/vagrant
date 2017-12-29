#!/bin/bash

# Frontend modules

# Install node.js
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs

# Install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt-get update
apt-get install yarn

# Install module dependencies
apt-get install -y g++ git

