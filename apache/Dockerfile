FROM ubuntu:latest
MAINTAINER Soumya Das <ssdas@live.in>
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install apache2 -y
RUN apt-get install apache2-utils -y
EXPOSE 80
ENTRYPOINT ["apache2ctl"]
CMD ["-DFOREGROUND"]
