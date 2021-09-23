FROM jwilder/nginx-proxy:alpine

LABEL name="SoumyaDas/nginx-proxy"
LABEL version="1.0.0"
LABEL maintainer="ssdas@live.in"

COPY custom_proxy_settings.conf /etc/nginx/conf.d/custom_proxy_settings.conf

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/etc/nginx/certs", "/etc/nginx/dhparam"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
