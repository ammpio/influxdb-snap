#!/bin/sh
set -e

export INFLUX_CMD="$SNAP/bin/influx -execute "

export DBNAME="db"
export RETENTION="365d"
export INIT_QUERY="CREATE DATABASE $DBNAME WITH DURATION $RETENTION"

# Wait for Influx server to come up properly
for i in {30..0}; do
    if $INFLUX_CMD "$INIT_QUERY" &> /dev/null; then
        break
    fi
    echo 'InfluxDB init process in progress...'
    sleep 1
done
