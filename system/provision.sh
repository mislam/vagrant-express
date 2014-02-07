#!/usr/bin/env bash

apt-get update
apt-get install -y build-essential

# Download and install pre-compiled NodeJS v0.10.24
cd /tmp && wget http://archive.cdn.demoz.co/node-v0.10.24-linux-x64.tar.gz && tar -xzvf node*.tar.gz && cd node && make install

# Create logs directory
su - vagrant -c "mkdir /vagrant/system/logs"

# Install Nginx
apt-get install -y nginx

# Create backup copy of existing config files (nginx.conf and mime.types)
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
cp /etc/nginx/mime.types /etc/nginx/mime.types.bak

# Create symlink to Nginx H5BP configuration files
mkdir /etc/nginx/conf
ln -sf /vagrant/system/nginx/nginx.conf /etc/nginx/nginx.conf
ln -sf /vagrant/system/nginx/mime.types /etc/nginx/mime.types
ln -s /vagrant/system/nginx/h5bp.conf /etc/nginx/conf/h5bp.conf
ln -s /vagrant/system/nginx/x-ua-compatible.conf /etc/nginx/conf/x-ua-compatible.conf
ln -s /vagrant/system/nginx/expires.conf /etc/nginx/conf/expires.conf
ln -s /vagrant/system/nginx/cross-domain-fonts.conf /etc/nginx/conf/cross-domain-fonts.conf
ln -s /vagrant/system/nginx/protect-system-files.conf /etc/nginx/conf/protect-system-files.conf

# Symlink to the proper log directory
ln -s /var/log/nginx /etc/nginx/logs

# Configure default site using server.conf
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
ln -s /vagrant/system/nginx/server.conf /etc/nginx/sites-available/default
ln -s /vagrant /srv/site

# Turn sendfile off for Nginx to prevent caching bug in VirtualBox
# Leave it on for production though.
sed -i "s/sendfile\s*on/sendfile off/g" /etc/nginx/nginx.conf

# Create upstart job for Node.js app and Nginx
cp /vagrant/system/upstart/app.conf /etc/init/app.conf
cp /vagrant/system/upstart/nginx.conf /etc/init/nginx.conf