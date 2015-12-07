#!/bin/bash

# Copy openssl.cnf and demoCA

cp ./openssl.cnf /usr/lib/ssl/openssl.cnf
tar -xzf demoCA.tar.gz -C /home/alumno/


# Add apache site for CRL

mkdir /var/www/crl
cat > /etc/apache2/conf-available/crl.conf << EOF
Alias /crl "/var/www/crl/"
<Directory "/var/www/crl/">
    Options +FollowSymLinks
    AllowOverride All
</Directory>

EOF

a2enconf crl.conf
service apache2 reload


# Add cron job to generate each day a new CRL list in /var/www/crl/org31.CRL and copy to web server
crontab -l | { cat; echo "0 0 * * * openssl ca -keyfile /home/alumno/demoCA/private/cakey.pem -gencrl -out /var/www/crl/org31.CRL"; } | crontab -
