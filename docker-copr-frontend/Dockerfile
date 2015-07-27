FROM fedora:22
MAINTAINER Valentin Gologuzov <vgologuz@redhat.com>

RUN dnf install -y dnf-plugins-core  --enablerepo=updates --enablerepo=updates-testing && \
    dnf copr enable msuchy/copr -y && \
    dnf install -y less vim tree copr-frontend copr-selinux copr-cli postgresql-server postgresql-contrib supervisor openssh-server wget \
       telnet python-celery tmux python-dateutil python-netaddr net-tools python-pip redis python-redis && \
    pip install ipython ipdb


#ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 TERM=xterm
#RUN locale-gen $LC_ALL
# RUN dnf install -y  redis python-redis

#ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 TERM=xterm
#RUN locale-gen $LC_ALL
# RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
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

# RUN dnf install -y  redis python-redis

CMD ["/tmp/entry_point.sh"]







