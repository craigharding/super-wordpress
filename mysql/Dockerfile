# FROM mysql:5
FROM mysql:latest
COPY ./mysql_root_password /root/mysql_root_password
COPY ./wp_db_password /root/wp_db_password
COPY ./.my.cnf /root/.my.cnf
RUN echo "default_authentication_plugin=mysql_native_password" >> /etc/mysql/my.cnf
