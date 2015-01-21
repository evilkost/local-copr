#!/usr/bin/sh

if [ -e /opt/shared_ro/update_front_to ]
then
    rpm_file=$(cat /opt/shared_ro/update_front_to)
    echo "Updating copr-frontend using: $rpm_file"
    rpm -Uhv --force /opt/shared_ro/build/noarch/$rpm_file
fi

/usr/bin/supervisord -n
