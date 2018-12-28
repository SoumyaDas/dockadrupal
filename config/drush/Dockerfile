FROM drush/drush:8

LABEL name="SoumyaDas/nginx-proxy"
LABEL version="1.0.0"
LABEL maintainer="ssdas@live.in"

# Move drush to a more generic path so it can be used with any image
RUN mkdir -p /drush && \
    mv -f /usr/local/bin/drush /drush/drush

# Volume the drush path so we can use it with other containers
VOLUME /drush

# Change the entrypoint to match the new drush path
ENTRYPOINT ["/drush/drush", "status"]
