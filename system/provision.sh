#!/usr/bin/env bash

apt-get update
apt-get install -y build-essential

# Download and install pre-compiled NodeJS v0.10.24
cd /tmp && wget http://archive.cdn.demoz.co/node-v0.10.24-linux-x64.tar.gz && tar -xzvf node*.tar.gz && cd node && make install

# Create upstart job
cp /vagrant/system/upstart.conf /etc/init/myapp.conf

# Create logs directory
su - vagrant -c "mkdir /vagrant/system/logs"