# Docker TLS Keys
For `toolbelt` and `farmer` server to talk securely to each other through Docker using `docker-compose` you need to setup TLS keys.

## Docker Instructions
You can read official Docker documentation about [how to setup TLS](https://docs.docker.com/engine/security/https/).

## Generator Script
You can use [`generate.sh`](generate.sh) script to automate creating certificate files required by TLS.