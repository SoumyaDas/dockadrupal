#!/bin/bash

# @file build configuration

CONF_DIR=/etc/apache2/sites-available/
CONF=$VIRTUAL_HOST.conf
HOSTS=/etc/hosts
# Specific path to drush version for drush site-install command
DRUSH_SITE_INSTALL_DRUSH='/drush/drush'
DOCROOT=/var/www/html/web

echo -e "# Creating virtual host configuration..."

cd ${CONF_DIR}
rm ${CONF}
a2dissite ${CONF}
touch ${CONF}
chmod -R 777 ${CONF}
chown -R $USER:$USER ${CONF}
FILE=${CONF}

echo "<VirtualHost *:80>
  ServerName $VIRTUAL_HOST

  ## Vhost docroot
  DocumentRoot ${DOCROOT}

  ## Directories, there should at least be a declaration for /www/rml/current

  <Directory ${DOCROOT}>
    Options FollowSymLinks
    AllowOverride all
    Order allow,deny
    Allow from all
  </Directory>

  ## Load additional static includes

  ## Logging
  ErrorLog /var/log/apache2/${VIRTUAL_HOST}_error_log
  ServerSignature Off
  CustomLog /var/log/apache2/${VIRTUAL_HOST}_access_log combined

  ## Rewrite rules
  RewriteEngine On

  ## Server aliases
  ServerAlias ${VIRTUAL_HOST}

  ## Custom fragment
<IfModule php5_module>
  php_value upload_max_filesize 10M
  php_value post_max_size 10M
</IfModule>

</VirtualHost>

<VirtualHost *:443>
 ServerName ${VIRTUAL_HOST}
 DocumentRoot ${DOCROOT}

 SSLEngine on
 SSLCipherSuite AES256+EECDH:AES256+EDH
 SSLProtocol All -SSLv2 -SSLv3
 SSLHonorCipherOrder On
 SSLCompression off
 SSLCertificateFile /etc/ssl/certs/${VIRTUAL_HOST}.crt
 SSLCertificateKeyFile /etc/ssl/private/${VIRTUAL_HOST}.key

 <Directory ${DOCROOT}>
   AllowOverride All
   Options -Indexes +FollowSymLinks
   Require all granted
 </Directory>

</VirtualHost>" >> $FILE

a2ensite $FILERUN a2enmod rewrite
a2enmod ssl
service apache2 restart


function removehost() {
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
        sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
    else
        echo "$HOSTNAME was not found in your $ETC_HOSTS";
    fi
}

function addhost() {
    IP="127.0.0.1"
    HOSTNAME=$VIRTUAL_HOST
    HOSTS_LINE="$IP\t$HOSTNAME"
    ETC_HOSTS="/etc/hosts"

    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS";
            sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

            if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
                then
                    echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)";
                else
                    echo "Failed to Add $HOSTNAME, Try again!";
            fi
    fi
}

echo -e "# Adding hosts entry to hosts file..."

addhost ${VIRTUAL_HOST}

echo -e "# Host entry added-- 127.0.0.1 ${VIRTUAL_HOST}"

exit 0
