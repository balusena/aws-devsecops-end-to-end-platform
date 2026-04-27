#!/bin/bash

cd /app
mongosh --host ${DB_HOST} </app/$(basename $SCHEMA_FILE)
