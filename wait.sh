#!/bin/sh

set -e

host=$1
port=$2

echo -n "waiting for TCP connection to $host:$port..."

index=1
while ! nc -z $host $port
do
    if [ ${RETRIES-0} -gt 0 ]
    then
        if [ "$index" -gt "${RETRIES-0}" ]
        then
            echo -n "too much retries"
            exit 1
        fi
        index=$((index + 1))
    fi

    echo -n .
    sleep ${DELAY-1}
done

echo 'ok'
