#!/bin/bash

MYSQL_DUMP=$1

echo $MYSQL_DUMP

if [ ! -f $MYSQL_DUMP ]
then
  echo "Need a mysql dump file"
  exit 1
fi

gunzip < $MYSQL_DUMP | grep -v -E 'INSERT INTO \`(_calls|job_statuses|call_|calls|cdr_|nn|versions|sessions|subscription_charges)' | mysql -u root mainframe_dev
