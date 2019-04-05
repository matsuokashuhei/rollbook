#!/bin/bash -eu

function log() {
  echo "$(date '+%Y-%m-%dT%H:%M:%S') - $@"
}

source /root/env.sh

NEW_DUMP=/backup/$(date '+%Y%m%d')-${DB_NAME}.dump
OLD_DUMP=/backup/$(date --date '7 day ago' '+%Y%m%d')-${DB_NAME}.dump

# backup DB using pg_dump
log "pg_dump --format=custom --host=$DB_HOST --dbname=$DB_NAME --no-owner --no-acl --username=$DB_USER > $NEW_DUMP"
pg_dump --format=custom --host=$DB_HOST --dbname=$DB_NAME --no-owner --no-acl --username=$DB_USER > $NEW_DUMP

if [ $RAILS_ENV = 'production' ]
then
  # store dump into S3
  log "aws s3 cp $NEW_DUMP s3://${S3_BUCKET}/backup/"
  aws s3 cp $NEW_DUMP s3://${S3_BUCKET}/backup/
  if [ $? -eq 0 ]
  then
    log "aws s3 cp is succeeded"

    # remove dump from container
    #log "rm -fr $NEW_DUMP" >> /var/log/cron.log 2>&1
    #rm -fr $NEW_DUMP

    # remove old dump from S3
    rm -f $OLD_DUMP
    log "aws s3 rm s3://${S3_BUCKET}/$OLD_DUMP"
    aws s3 rm s3://${S3_BUCKET}/backup/$OLD_DUMP
    if [ $? -eq 0 ]
    then
      log "aws s3 rm is succeeded"
    fi
  fi
fi



