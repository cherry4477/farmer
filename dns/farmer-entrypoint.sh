#!/bin/bash

set -eo pipefail

sed -i -e 's/{{HOST_EXTERNAL_IP}}/'${HOST_EXTERNAL_IP}'/g' /etc/bind/zones/db.catchall

/sbin/entrypoint.sh "$@"