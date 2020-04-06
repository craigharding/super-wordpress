#!/bin/bash

# want new files to be read-only by owner
umask 177

# openssl puts a newline char at the end of the string which messes up Portainer
echo -n `openssl rand -base64 20` > portainer/portainer_admin_password
echo -n `openssl rand -base64 20` > mysql/mysql_root_password
echo -n `openssl rand -base64 20` > mysql/wp_db_password
cp -p mysql/wp_db_password wordpress/wp_db_password

# update the .my.cnf file with the root password
sed -i -e "s|password = .*|password = \'$(cat mysql/mysql_root_password)\'|" mysql/.my.cnf

# update the apmia mysql bundle.properties with this password
sed -i -e "s|wordpressdb.password=.*|wordpressdb.password=\'$(cat mysql/wp_db_password)\'|" apmia/mysql.bundle.properties

# update this install directory in the backup script
sed -i -e "s|EASY_HOME=.*|EASY_HOME=$PWD|" backup/backup_wordpress
