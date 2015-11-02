#!/bin/bash
wget http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/Release.key
apt-key add - < Release.key
sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list"
apt-get update
apt-get install -y owncloud

#LDAP
apt-get install -y php5-ldap
#HTTPS
#a2enmod ssl
#a2ensite default-ssl.conf

service apache2 restart


#TODO: claves HTTPS
#TODO: automatizar configuración con
#sudo -u www-data php /var/www/owncloud/occ ##command##
