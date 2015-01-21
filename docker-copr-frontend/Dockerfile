FROM fedora:21
MAINTAINER Valentin Gologuzov <vgologuz@redhat.com>

RUN yum install -y copr-frontend copr-selinux copr-cli postgresql-server postgresql-contrib supervisor openssh-server wget

COPY copr-frontend.rpm /tmp/copr-frontend.rpm
RUN yum localinstall -y /tmp/copr-frontend.rpm

ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 TERM=xterm
RUN locale-gen $LC_ALL

EXPOSE 80 1080


RUN runuser -c "yes coprpass | initdb -E UTF8 -W" - postgres
COPY pg_hba.conf /var/lib/pgsql/data/
COPY supervisord.conf /etc/supervisord.conf

COPY httpd/welcome.conf httpd/coprs.conf /etc/httpd/conf.d/

COPY psql_create_pwd.sh init_frontend_db.sh /tmp/

RUN sh /tmp/psql_create_pwd.sh

COPY copr.conf /etc/copr/copr.conf

COPY copr_cli_config /usr/share/copr/coprs_frontend/.config/copr
RUN sh /tmp/init_frontend_db.sh



#COPY copr-frontend.rpm /tmp/copr-frontend.rpm
#RUN rpm -Uhv --force /tmp/copr-frontend.rpm

#CMD ["/usr/bin/supervisord", "-n"]
COPY entry_point.sh /tmp/entry_point.sh
CMD ["/tmp/entry_point.sh"]







