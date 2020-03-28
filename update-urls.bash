#!/bin/bash

source ./.env

docker exec -it ${COMPOSE_PROJECT_NAME}_appServer sed -i "/stop editing/i \/** Dynamic site URL and HOME *\/\n\
define('WP_SITEURL', (isset(\$_SERVER['HTTPS']) ? 'https://' : 'http://') . \$_SERVER['HTTP_HOST']);\n\
define('WP_HOME', (isset(\$_SERVER['HTTPS']) ? 'https://' : 'http://') . \$_SERVER['HTTP_HOST']);\n\
" /var/www/html/wp-config.php
