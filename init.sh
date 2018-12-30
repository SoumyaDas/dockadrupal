#!/bin/bash

# Treat unset variables as an error
set -o nounset

read -p "Project Name: " PROJECT_NAME
read -p "Http Port: " PROJECT_HTTP_PORT
read -p "Https Port: " PROJECT_HTTPS_PORT

PROJECT_URL=${PROJECT_NAME}.demoserver.com
PHPMYADMIN_URL=pma.${PROJECT_URL}
### Override config/.env environment variables. 
export PROJECT_NAME
export PROJECT_URL
export PHPMYADMIN_URL
export PROJECT_HTTP_PORT
export PROJECT_HTTPS_PORT

mkdir ${PROJECT_NAME}
cd config
docker-compose config > ../${PROJECT_NAME}/docker-compose.yaml
cd ../${PROJECT_NAME}
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

addhost ${PROJECT_URL}
addhost ${PHPMYADMIN_URL}

exit 0
