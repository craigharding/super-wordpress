
# Super Wordpress
An easy implementation of Wordpress in Docker
### _**Monitored by CA/Broadcom [DX APM](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/dx-apm-saas/SaaS.html "DX APM SaaS Documentation")**_

Super Wordpress will get your CMS up and ready in practically no time with DX APM enterprise class monitoring configured at first startup.

Easy as pie.

_Super Wordpress is based on the [Easy Wordpress](https://github.com/craigharding/easy-wordpress) project, which does not include the DX APM monitoring_

## Features

This is a seven container Wordpress CMS. 
* NGINX is the frontend / reverse proxy and serves up the static content
* PHP FPM is the main Wordpress engine
* MySql is the datbase
* Portainer gives you a Docker dashboard and control of the Docker env
* MailHog is the dummy email server
* ngrok connects the project to the internet, with TLS
* DX APM Infrastructure Agent monitors Applicaton Performance and Infrastructure resouces

## Installing / Getting started

You will need a system with Docker installed and running, docker-compose, openssl, and access DX APM Monitoring.

Edit the .env file and update the connection information for DX APM. You can get the manager URLs and credential from one of the "Cloud Native" Agent downloads in your tenant.

Edit the wordpress/ba.snippet file and paste in the BA snippet from the Manage Apps --> (yourAppName) --> WEB APP --> Web App integration instructions. Make sure to enclose the snippet in single quotes inside the file.

Then run ...

```shell
./gen-passwords.bash
docker-compose up -d
./update-urls.bash
```

The gen-passwords.bash script uses openssl to generate three random passwords that are used to secure the mysql database and Portainer access. These get copied into the easy Wordpress images.

The docker-compose command downloads the base images, creates custom images, and starts your Wordpress project.

And the update-urls.bash script modifies the wp-config.php file to set the Wordpress home and site URLs to whatever you use to access the site.

And then ...

```shell
http://<yourProjectName>.localhost:8080
```

When you connect to the new site you go through the initial Wordpress site configuration.

## DX APM Instrumentation

Using the DX APM Infrastructure Agent this Wordpress installation has these monitoring capabilities in place:
* [NGINX Monitoring](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/dx-apm-saas/SaaS/implementing-agents/infrastructure-agent/nginx-monitoring.html "NGINX Monitoring Docs")
* [PHP Agent](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/dx-apm-saas/SaaS/implementing-agents/php-agent.html "PHP Agent Docs")
* [MySQL Database Monitoring](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/dx-apm-saas/SaaS/implementing-agents/infrastructure-agent/mysql-database-monitoring.html "MySQL Database Monitoring Docs")
* [Docker Monitor](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/dx-apm-saas/SaaS/implementing-agents/infrastructure-agent/docker-monitor/docker-monitoring.html "Docker Monitor Docs")
* [Host Monitoring](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/dx-apm-saas/SaaS/implementing-agents/infrastructure-agent/host-monitoring.html "Host Monitoring Docs")
* [Browser Agent](https://techdocs.broadcom.com/content/broadcom/techdocs/us/en/ca-enterprise-software/it-operations-management/ca-experience-collector/2-4/browser-agent.html "Browser Agent Docs")

## Docker Dashboard

Easy Wordpress includes a Portainer container. Access it using: 

```shell
http://<yourProjectName>.localhost:8080/dashboard/
```

Login with "admin" and the contents of the portainer_admin_password file.

## ngrok

I like [ngrok](https://www.ngrok.com/docs). You can host this site from your dev cloud using ngrok. Get your ngrok URL this way:

```shell
docker attach <yourProjectName>_nGrok
```
And then connect ...

```shell
https://<someRandomNumber>.ngrok.io
```

## Email Setup

This environment comes with a [MailHog](https://github.com/mailhog/MailHog) dummy email server. You need to 
install a WP plugin to send emails to this container. Use the 
[Easy WP SMTP](https://www.hostinger.com/tutorials/wordpress/how-to-configure-wordpress-to-send-emails-using-smtp "How to Configure WordPress to Send Emails Using SMTP Plugin") plugin. Set the SMTP host to "mailhog", the port to 1025, no authentication, no encryption.

Access the MailHog web UI using:

```shell
http://<yourProjectName>.localhost:8080/mailhog/
```

## Customizing

You will want to modify the nginx.conf file to suit your CMS site's URL. Change the server_name parameter to match your URL.

I also recommend configuring your site's upload limit. There are settings for this in both nginx.conf and php.ini. My preference is to leave nginx at unlimited and set the threshold in php.ini.

If you have an [ngrok account](https://dashboard.ngrok.com/login "Login"), put your auth token in the ngrok.yml file along with any other customizations to get your utilize the features available to your [plan](https://www.ngrok.com/pricing "ngrok Plans").

Once you have customized some settings you will need to rebuild the Docker images:

```shell
docker-compose --build
```

## Managing

The Docker documentation has fine instructions to backup, restore, and migrate your project to another server.

You're on your own!

## Contributing

"If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are warmly welcome."

## Licensing

"The code in this project is licensed under MIT license."
