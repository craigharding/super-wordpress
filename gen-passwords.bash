#!/bin/bash

# want new files to be read-only by owner
umask 177

# openssl puts a newline char at the end of the string which messes up Portainer
echo -n `openssl rand -base64 20` > portainer/portainer_admin_password
echo -n `openssl rand -base64 20` > mysql/mysql_root_password
echo -n `openssl rand -base64 20` > mysql/wp_db_password
cp -p mysql/wp_db_password wordpress/wp_db_password

# update the apmia mysql bundle.properties with this password
sed -i -e s/wordpressdb.password=.*/wordpressdb.password="$(cat mysql/wp_db_password)"/ apmia/mysql.bundle.properties
