#!/bin/bash

# Required
domain=$VIRTUAL_HOST
commonname=$VIRTUAL_HOST

# Change to your company details
country=IN
state=Maharastra
locality=Mumbai
organization=TCS
organizationalunit=LS
email=administrator@example.com


if [ -z "$domain" ]
then
    echo "Argument not present."
    echo "Useage $0 [common name]"

    exit 99
fi

echo "Creating Self Signed Certificate..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/$domain.key -out /etc/ssl/certs/$domain.crt \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

