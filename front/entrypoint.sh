#!/usr/bin/env bash
export EXISTING_VARS=$(printenv | awk -F= '{print $1}' | sed 's/^/\$/g' | paste -sd,);

echo 'Replacing env vars...'
for file in $JSFOLDER;
do
  cat $file | envsubst $EXISTING_VARS > $file
done
echo 'DONE'

exec nginx -g 'daemon off;'
