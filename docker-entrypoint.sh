#!/bin/sh
set -e
setProperty(){
  awk -v pat="^$1 = " -v value="$1 = $2" '{ if ($0 ~ pat) print value; else print $0; }' $3 > $3.tmp
  mv $3.tmp $3
}
setProperty "database" "${DATABASE_DRIVER}" "/opt/mirth-connect/conf/mirth.properties"
setProperty "database.url" "${DATABASE_URL}" "/opt/mirth-connect/conf/mirth.properties"
setProperty "database.username" "${DATABASE_USERNAME}" "/opt/mirth-connect/conf/mirth.properties"
setProperty "database.password" "${DATABASE_PASSWORD}" "/opt/mirth-connect/conf/mirth.properties"

exec "$@"