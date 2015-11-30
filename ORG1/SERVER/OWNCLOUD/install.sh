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

