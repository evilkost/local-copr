#!/usr/bin/sh


#/usr/bin/supervisord &
su - postgres -c '/usr/bin/postgres -D /var/lib/pgsql/data' &
sleep 5

cd /usr/share/copr/coprs_frontend

su - copr-fe -c 'cd /usr/share/copr/coprs_frontend && python manage.py create_db -f alembic.ini'
su - copr-fe -c 'cd /usr/share/copr/coprs_frontend && alembic upgrade head'
su - copr-fe -c 'cd /usr/share/copr/coprs_frontend && python manage.py create_chroot fedora-20-x86_64 fedora-20-i386 fedora-21-x86_64 fedora-21-i386 epel-7-x86_64 fedora-rawhide-x86__64'

PGPASSWORD=coprpass psql -a -h localhost -U copr-fe coprdb -c "insert into \"user\" (username, mail, api_login, api_token, timezone, api_token_expiration) VALUES ('test_user', 'test_user@example.com',  'Y29wcg==##xvlgutojqwbbtgchimga',  'gihbqhuartrdsxjbklfhejsotzvqbd', 'UTC', '2025-03-22');"



sleep 2

kill %1
