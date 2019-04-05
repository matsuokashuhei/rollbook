#!/bin/bash -eu

source /root/env.sh

NEW_DUMP=/backup/$(date '+%Y%m%d')-${DB_NAME}.dump
OLD_DUMP=/backup/$(date --date '7 day ago' '+%Y%m%d')-${DB_NAME}.dump

# backup DB using pg_dump
echo "$(date '+%Y-%m-%d %H:%M:%S') - pg_dump --format=custom --host=$DB_HOST --dbname=$DB_NAME --no-owner --no-acl --username=$DB_USER > $NEW_DUMP" >> /var/log/cron.log 2>&1
pg_dump --format=custom --host=$DB_HOST --dbname=$DB_NAME --no-owner --no-acl --username=$DB_USER > $NEW_DUMP

if [ $RAILS_ENV = 'production' ]
then
  # store dump into S3
  echo "$(date '+%Y-%m-%d %H:%M:%S') - aws s3 cp $NEW_DUMP s3://${S3_BUCKET}/backup/" >> /var/log/cron.log 2>&1
  aws s3 cp $NEW_DUMP s3://${S3_BUCKET}/backup/
  if [ $? -eq 0 ]
  then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - aws s3 cp is succeeded" >> /var/log/cron.log 2>&1

    # remove dump from container
    #echo "$(date '+%Y-%m-%d %H:%M:%S') - rm -fr $NEW_DUMP" >> /var/log/cron.log 2>&1
    #rm -fr $NEW_DUMP

    # remove old dump from S3
    rm -f $OLD_DUMP
    echo "$(date '+%Y-%m-%d %H:%M:%S') - aws s3 rm s3://${S3_BUCKET}/$OLD_DUMP" >> /var/log/cron.log 2>&1
    aws s3 rm s3://${S3_BUCKET}/backup/$OLD_DUMP
    if [ $? -eq 0 ]
    then
      echo "$(date '+%Y-%m-%d %H:%M:%S') - aws s3 rm is succeeded" >> /var/log/cron.log 2>&1
    fi
  fi
fi


