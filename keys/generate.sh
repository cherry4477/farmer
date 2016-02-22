#!/bin/bash

HOSTNAME=${HOSTNAME:-ravaj.ir}
ADMIN_IP=${ADMIN_IP:-127.0.0.1}   # It only allows connection from Admin's IP
SERVER_IP=${SERVER_IP:-127.0.0.1} # and server's own IP (connecting externally from within a container!!).

TMPDIR=`mktemp -d` && cd ${TMPDIR}

# Generate CA private and public keys
openssl genrsa -aes256 -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem

# Generate server key
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=${HOSTNAME}" -sha256 -new -key server-key.pem -out server.csr
echo subjectAltName = IP:${ADMIN_IP},IP:127.0.0.1,IP:${SERVER_IP} > extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf

# Generate client key
openssl genrsa -out key.pem 4096
openssl req -subj "/CN=client" -new -key key.pem -out client.csr
echo extendedKeyUsage = clientAuth > extfile.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf

# Remove certificate signing requests
rm -v client.csr server.csr

# Set correct permissions
chmod -v 0400 ca-key.pem key.pem server-key.pem # Private Keys
chmod -v 0444 ca.pem cert.pem server-cert.pem   # Public Certificates

sudo cp -r ${TMPDIR}/* ~/.docker/
