#!/usr/bin/sh


#/usr/bin/supervisord &
su - postgres -c '/usr/bin/postgres -D /var/lib/pgsql/data' &


sleep 5
su - postgres -c 'PGPASSWORD=coprpass ; createdb -E UTF8 coprdb ; yes $PGPASSWORD | createuser -P -sDR copr-fe'
sleep 2

kill %1
