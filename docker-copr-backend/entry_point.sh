#!/usr/bin/sh

rm -f /var/run/copr-backend/copr-be.pid
rm -f /var/run/copr-backend/copr-be.pid.lock


if [ -e /opt/shared_ro/update_back_to ]
then
    rpm_file=$(cat /opt/shared_ro/update_back_to)
    echo "Updating copr-backend using: $rpm_file"
    rpm -Uhv --force /opt/shared_ro/build/noarch/$rpm_file
else
    echo "copr-backend update not found"
fi


/usr/bin/supervisord -n

