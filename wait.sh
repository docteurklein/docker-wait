#!/bin/sh

set -e

host=$1
port=$2

echo -n "waiting for TCP connection to $host:$port..."

index=0
while ! nc -w 1 $host $port > /dev/null
do
    if [ $RETRIES -gt 0 ]
    then
        if [ "$index" -gt "$RETRIES" ]
        then
            echo -n "too much retries"
            exit 1
        fi
        index=$((index + 1))
    fi

    echo -n .
    sleep $DELAY
done

echo 'ok'
