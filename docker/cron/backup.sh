#!/bin/bash

DUMP_FILE=/backup/$(date '+%Y%m%d%H%M%S').dump

source /root/env.sh

echo "pg_dump --format=custom --host=$DB_HOST --dbname=$DB_NAME --no-owner --no-acl --username=$DB_USER > $DUMP_FILE" >> /var/log/cron.log 2>&1
pg_dump --format=custom --host=$DB_HOST --dbname=$DB_NAME --no-owner --no-acl --username=$DB_USER > $DUMP_FILE

echo "aws s3 cp $DUMP_FILE s3://landin/backup/" >> /var/log/cron.log 2>&1
aws s3 cp $DUMP_FILE s3://landin/backup/
