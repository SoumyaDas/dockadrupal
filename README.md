## Introduction

**Docker image for Drupal Environment Stack.**

DockADrupal is an open source repository to orchestrate Drupal local environment. It has included two different project application scenario --
  * Multi Project Environment &
  * Single Project Environment

The only different between the above two scenario is the dedicated database server for each project. Leveraging the docker command and respecting the docker principle I have decided to keep the database servers tightly coupled to its corresponding application server. You can check the corresponding docker-compose files to observe the difference.

Each environment is consist of 
  * A docker-compose.yml file to define different elements of the Drupal environment.
  * Self-signed certificates under ./certs/ directory with the domain name "demoserver.com"
  * A Dockerfile under ./drush/ directory to build a shared drush container.
  * A Dockerfile under ./mywebapp/(./mywebapp1/ | ./mywebapp2/ | ./mywebapp3/) directory to build an web application.
  * The ./mywebapp/web directory is the docroot for your application which is configured in the default apache-config.conf file.
  * .env file to chnage the versions and some environment variables from a single place. Though Dockerfile and the docker-compose files also contains other environments variables which are not expected to change frequently.
  
## How to Spin Up an Environment:
 
  * $ cd multi_projects
  * $ docker-compose build
  * $ docker-compose up -d
 
 Add your virtual host name of your application (e.g. mywebapp1.demoserver.com) to the /etc/hosts file of your host O/S.
 
 Now browse your web application from your favourite browser (tested on chrome/fedora) with the url --
  -- https://mywebapp1.demoserver.com:4443
  
## Maintenance

We actively monitor the issue queue, so please log any [**issues**](https://github.com/SoumyaDas/dockadrupal/issues) that you encounter. Any contribution is also welcomed.

## License

This project is licensed under the MIT open source license.
