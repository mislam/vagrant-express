#!/usr/bin/env bash

# Update
apt-get update

# Set timezone and install NTP
echo "America/New_York" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
apt-get install -y ntp

# Install build tools
apt-get install -y build-essential

# Add the repositories to install the latest version of nginx
apt-get install -y python-software-properties
add-apt-repository -y ppa:nginx/stable
apt-get update

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
ln -s /var/log/nginx /usr/share/nginx/logs

# Configure default site using server.conf
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
ln -s /vagrant/system/nginx/server.conf /etc/nginx/sites-available/default

# Create upstart job for Node.js app and Nginx
cp /vagrant/system/upstart/app.conf /etc/init/app.conf
cp /vagrant/system/upstart/nginx.conf /etc/init/nginx.conf
