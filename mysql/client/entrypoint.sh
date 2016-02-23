#!/bin/sh

set -e

SERVER_CONFIG=/config/database.cfg

get_json() {
    JSON_DATA=$1
    KEY=$2
    echo ${JSON_DATA} | json -l | grep "${KEY}" | awk '{ print $2; }'
}

if [ -z $DATABASE_NAME ]; then
    echo "Please set DATABASE_NAME environment variable"
    exit
fi

if [ ! -f $SERVER_CONFIG ]; then
    RESPONSE="$(curl  -H "Content-Type: application/json" -X POST -d '{"database":"'"${DATABASE_NAME}"'"}' http://farmer_mysql_api/create)"

    DATABASE_NAME=`get_json ${RESPONSE} "database_name"`
    DATABASE_USERNAME=`get_json ${RESPONSE} "username"`
    DATABASE_PASSWORD=`get_json ${RESPONSE} "password"`

    if [ -n "${DATABASE_NAME}" ]; then
        echo "DATABASE_USERNAME=${DATABASE_USERNAME}" | tr -d '"' >> $SERVER_CONFIG
        echo "DATABASE_PASSWORD=${DATABASE_PASSWORD}" | tr -d '"' >> $SERVER_CONFIG
        echo "DATABASE_NAME=${DATABASE_NAME}" | tr -d '"' >> $SERVER_CONFIG

        echo "Database Credentials:"
        cat $SERVER_CONFIG
    else
        echo "MySql Error:"
        echo ${RESPONSE}
        exit 1
    fi

fi

if [ ! /docker-entrypoint-initdb.d/.installed ]; then
    export $(cat ${DATABASE_NAME})
    for f in /docker-entrypoint-initdb.d/*; do
        case "$f" in
            *.sql) echo "running $f"; mysql -hfarmer_mysql_server -u${DATABASE_USERNAME} -p${DATABASE_PASSWORD} -D${DATABASE_NAME} < "$f" ;;
            *)     echo "ignoring $f" ;;
        esac
    done
    touch /docker-entrypoint-initdb.d/.installed
fi

exec "$@"
