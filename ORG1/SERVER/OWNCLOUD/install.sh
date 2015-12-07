#!/bin/bash

#Instalar paquete owncloud
wget http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/Release.key
apt-key add - < Release.key
sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list"
apt-get update
apt-get install -y owncloud

#php LDAP
apt-get install -y php5-ldap


#HTTPS con comprobación de CRL
a2enmod ssl
#certificados:
tar -xzf toserver.tar.gz -C /home/alumno/
chown alumno.alumno /home/alumno/toserver
chown alumno.alumno /home/alumno/toserver/*

echo "ServerName server.org31" >> /etc/apache2/apache2.conf
#configuración ssl
cat > /etc/apache2/sites-available/default-ssl.conf << EOF
<IfModule mod_ssl.c>
	<VirtualHost _default_:443>
		ServerAdmin webmaster@localhost

		DocumentRoot /var/www/html

		ErrorLog ${APACHE_LOG_DIR}/error.log
		CustomLog ${APACHE_LOG_DIR}/access.log combined

		SSLEngine on

		SSLCertificateFile	/home/alumno/toserver/servercert.pem
		SSLCertificateKeyFile /home/alumno/toserver/serverkey.pem

		SSLCACertificateFile /home/alumno/toserver/cacert.pem

		SSLCARevocationCheck chain
		SSLCARevocationFile /home/alumno/toserver/ca-bundle.crl

		SSLVerifyClient require
		SSLVerifyDepth  10

		<FilesMatch "\.(cgi|shtml|phtml|php)$">
				SSLOptions +StdEnvVars
		</FilesMatch>
		<Directory /usr/lib/cgi-bin>
				SSLOptions +StdEnvVars
		</Directory>

		BrowserMatch "MSIE [2-6]" \
				nokeepalive ssl-unclean-shutdown \
				downgrade-1.0 force-response-1.0
		BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown

	</VirtualHost>
</IfModule>
EOF
#activar https
a2ensite default-ssl.conf


service apache2 restart

#Configurar owncloud
curl -X POST -d @curl-post-data.txt http://192.168.31.100/index.php
sudo -u cp config.php /var/www/owncloud/config/config.php
#chown www-data:www-data /var/www/owncloud/config/config.php

sudo -u www-data php /var/www/owncloud/occ app:enable encryption
sudo -u www-data php /var/www/owncloud/occ encryption:enable
sudo -u www-data php /var/www/owncloud/occ app:enable user_ldap
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' hasMemberOfFilterSupport "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' hasPagedResultSupport ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' homeFolderNamingRule ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' lastJpegPhotoLookup "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapAgentName "cn=admin,dc=org31,dc=es"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapAgentPassword "alumno"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapAttributesForGroupSearch ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapAttributesForUserSearch ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapBackupHost ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapBackupPort ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapBase "dc=org31,dc=es"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapBaseGroups "dc=org31,dc=es"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapBaseUsers "dc=org31,dc=es"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapCacheTTL "600"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapConfigurationActive "1"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapEmailAttribute ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapExperiencedAdmin "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapExpertUUIDGroupAttr ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapExpertUUIDUserAttr ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapExpertUsernameAttr ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapGroupDisplayName "cn"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapGroupFilter "(&(|(objectclass=organizationalUnit)))"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapGroupFilterGroups ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapGroupFilterMode "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapGroupFilterObjectclass "organizationalUnit"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapGroupMemberAssocAttr "uniqueMember"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapHost "192.168.31.100"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapIgnoreNamingRules ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapLoginFilter "(&(|(objectclass=inetOrgPerson))(|(uid=%uid)(|(uid=%uid))))"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapLoginFilterAttributes "uid"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapLoginFilterEmail "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapLoginFilterMode "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapLoginFilterUsername "1"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapNestedGroups "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapNoCase "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapOverrideMainServer ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapPagingSize "500"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapPort "389"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapQuotaAttribute ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapQuotaDefault ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapTLS "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapUserDisplayName "cn"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapUserFilter "(|(objectclass=inetOrgPerson))"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapUserFilterGroups ""
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapUserFilterMode "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapUserFilterObjectclass "inetOrgPerson"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapUuidGroupAttribute "auto"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' ldapUuidUserAttribute "auto"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' turnOffCertCheck "0"
sudo -u www-data php /var/www/owncloud/occ ldap:set-config '' useMemberOfToDetectMembership "1"
