#!/bin/bash

# Treat unset variables as an error
set -o nounset

read -p "Project Name: " PROJECT_NAME
read -p "Http Port: " PROJECT_HTTP_PORT

#PROJECT_URL=${PROJECT_NAME}.demoserver.com
#PHPMYADMIN_URL=pma.${PROJECT_URL}
### Override config/.env environment variables. 
export PROJECT_NAME
export PROJECT_URL
export PHPMYADMIN_URL
export PROJECT_HTTP_PORT
export PROJECT_HTTPS_PORT

mkdir ${PROJECT_NAME}
mkdir ${PROJECT_NAME}/web
cp config/mywebapp/web/index.php ${PROJECT_NAME}/web/

cd config
docker-compose config > ../${PROJECT_NAME}/docker-compose.yaml
cd ../${PROJECT_NAME}
#docker pull nginx
#docker run -v $PWD nginx openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt
docker-compose down
docker-compose build
docker-compose up -d

function addhost() {
    IP="127.0.0.1"
    HOSTNAME=$1
    HOSTS_LINE="$IP $HOSTNAME"
    ETC_HOSTS="/etc/hosts"

    if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]
        then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS";
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> $ETC_HOSTS";

            if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]
                then
                    echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME $ETC_HOSTS)";
                else
                    echo "Failed to Add $HOSTNAME, Try again!";
            fi
    fi
}

echo -e "# Adding hosts entry to hosts file..."

#addhost ${PROJECT_URL}
#addhost ${PHPMYADMIN_URL}

exit 0
