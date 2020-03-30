# FROM wordpress:fpm
FROM wordpress:php7.2-fpm

COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./wp_db_password /root/wp_db_password

##
## Install the PHP Agent into wordpress
COPY --from=caapm/apmia:latest /usr/local/apmia/extensions/PhpExtension/PHPAgent/ /usr/local/PHPAgent
COPY ./ba.snippet /usr/local/PHPAgent
WORKDIR /usr/local/PHPAgent

# Log Level: 0=trace, 1=debug, 2=info, 3=warning, 4=error, 5=fatal
# If PHP-FPM is started as non-daemon service enable this property and set value as '0'
RUN sed -i -e s/wily_php_agent.logLevel=.*/wily_php_agent.logLevel=5/ /usr/local/PHPAgent/probe/wily_php_agent.ini ; \
sed -i -e s/\;wily_php_agent.enablePhpProcessManager.support=.*/wily_php_agent.enablePhpProcessManager.support=0/ /usr/local/PHPAgent/probe/wily_php_agent.ini

# Browser Agent
RUN sed -i -e s/snippet.autoInjection=.*/snippet.autoInjection=1/ /usr/local/PHPAgent/probe/wily_php_agent.ini ; \
echo "wily_php_agent.browseragent.autoInjection.snippetString=$(cat ba.snippet)" >> /usr/local/PHPAgent/probe/wily_php_agent.ini ; \
echo "wily_php_agent.enable.browseragent.response.decoration=1" >> /usr/local/PHPAgent/probe/wily_php_agent.ini

# run the installer at container start (+environment variables)
RUN chmod +x ./installer.sh ; \
sed -i -e "/exec \"\$@\"/i\/usr\/local\/PHPAgent\/installer.sh -appname wordpress -agenthostname \${APPSERVER_HOSTNAME} -iahost caagent -iaport 5005 -logdir \/usr\/local\/PHPAgent\/probe\/logs\n" /usr/local/bin/docker-entrypoint.sh

# run the installer as part of the build (-environment variables)
# RUN chmod +x ./installer.sh ; \
# ./installer.sh -appname wordpress -agenthostname super_appServer -iahost caagent -iaport 5005 -logdir /usr/local/PHPAgent/probe/logs

WORKDIR /var/www/html
