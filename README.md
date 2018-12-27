## Introduction

**Build Docker Images for Drupal Environment Stack.**

DockADrupal is an open source repository to orchestrate Drupal local environment.


Each environment is consist of 
  * A docker-compose.yml file to define different elements of the Drupal environment.
  * Self-signed certificates under ./certs/ directory with the domain name "demoserver.com"
  * A Dockerfile under ./drush/ directory to build a shared drush container.
  * A Dockerfile under ./mywebapp/ directory to build an web application.
  * The ./mywebapp/web directory is the place where you have to placce your docroot for your application which is configured in the default apache-config.conf file.
  * .env file to chnage the versions and some environment variables from a single place. Though Dockerfile and the docker-compose files also contains other environments variables which are not expected to change frequently.
  
<Project1> and <Project2> is the example directory to start with docker based applications.
You should rename these directories according to your project name. 

Drupal 7 web directory -- project1/mywebapp/web/docroot
docroot is not present by default, you place your d7 project here in ...web/ directory and rename it to <docroot>. Now your application would be available to the apache webserver.
 
To control application URL and PORT you have to edit .env file inside project1 directory.

Currently apache is configured for https only.

Repeat the above steps to create another application.

## How to Spin Up an Environment:
 
  
* $ cd dockadrupal/project1
* $ cp <...../drupal project> mywebapp/web/
* $ mv <..../drupal project> to docroot
* $ docker-compose build
* $ docker-compose up -d
* $ docker ps
 
 Add your virtual host name of your application (e.g. project1.demoserver.com) to the /etc/hosts file of your host O/S.
 
 Now browse your web application from your favourite browser (tested on chrome/fedora) with the url --
  -- https://project1.demoserver.com:<PORT>
  
## Maintenance

We actively monitor the issue queue, so please log any [**issues**](https://github.com/SoumyaDas/dockadrupal/issues) that you encounter. Any contribution is also welcomed.

## License

This project is licensed under the MIT open source license.

## Credit
Thanks to Jason Wilder for awesome reverse proxy server --
https://github.com/jwilder/nginx-proxy

Thanks to Docker community for official images.

