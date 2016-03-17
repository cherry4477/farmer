#!/bin/bash

set -eo pipefail

# Generate SSL Certificates if missing.
(
  cd /var/mail
  if ! [ -e ./ssl.cfg ]; then
    cat >./ssl.cfg <<EOF
[ req ]
prompt             = no
default_bits       = 2048
distinguished_name = req_distinguished_name

[ req_distinguished_name ]
CN = *
EOF
    [ -e ./ssl.key ] && touch -r ssl.key ssl.cfg
  fi
  if [ ./ssl.cfg -nt ./ssl.key ] || ! [ -e ./ssl.key ]; then
    echo "Generating private key and certificate request"
    openssl req -config ./ssl.cfg -new -nodes \
      -keyout ./ssl.key -out ./ssl.csr
  fi
  if ! [ -e ./ssl.crt ]; then
    echo "Generating self-signed certificate"
    openssl x509 -req -days 3650 -in ./ssl.csr -signkey ./ssl.key -out ./ssl.crt
    echo "SSL certificate $(openssl x509 -in ./ssl.crt -noout -fingerprint)"
  fi
  chown root:ssl ./ssl.key ./ssl.csr ./ssl.crt
  chmod g+r ./ssl.key
  [ -e exim.user.conf ]    || touch exim.user.conf
)

echo "[mailer] confd is now monitoring etcd for changes..."
confd -interval 10 -node ${ETCD_NODE} &

echo "[mailer] starting exim service..."
exec /usr/sbin/exim4 -bdf -v -q30m
