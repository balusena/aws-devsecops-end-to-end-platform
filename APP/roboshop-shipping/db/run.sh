#!/bin/bash

cd /app
mysql -h ${DB_HOST} -u${DB_USER} -p${DB_PASS} < /app/$(basename $SCHEMA_FILE)
