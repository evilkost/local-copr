FROM fedora:21
MAINTAINER Valentin Gologuzov <vgologuz@redhat.com>

#ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 TERM=xterm
# RUN locale-gen $LC_ALL


COPY msuchy-copr-fedora-20.repo /etc/yum.repos.d/
RUN yum install -y dnf
RUN dnf install -y vim fedmsg fedmsg-relay telnet tmux zsh ipython redis python-pip python-celery python-IPy copr-backend python-novaclient supervisor openssh-server iproute ansible vim --enablerepo=updates --enablerepo=updates-testing

RUN pip install -U six

EXPOSE 22 80 443

COPY fedmsg/endpoints.py /etc/fedmsg.d/endpoints.py
COPY supervisord.conf /etc/supervisord.conf

COPY lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY lighttpd/dirlisting.conf  /etc/lighttpd/conf.d/dirlisting.conf
COPY lighttpd/mime.conf  /etc/lighttpd/conf.d/mime.conf


# DO: Place your private key to connect to host --> builder_id_rsa

COPY cloud/ssh_keys/config cloud/ssh_keys/id_rsa  cloud/ssh_keys/vagrant_insecure_privkey builder_id_rsa /home/copr/.ssh/

RUN chown -R copr:copr /home/copr/



COPY copr-be.conf /etc/copr/copr-be.conf
COPY cloud /home/copr/provision/

RUN  ip -4 route list 0/0  | cut -d" " -f3 > /tmp/gw_ip
RUN sed -i "s/VM_BUILDER_IP/`cat /tmp/gw_ip`/" /home/copr/provision/inventory

RUN chown -R copr:copr /home/copr && chmod 600 /home/copr/.ssh/config

COPY cloud/ansible.cfg /etc/ansible/ansible.cfg

COPY run_cb.sh /usr/bin/run_cb.sh
RUN chmod +x /usr/bin/run_cb.sh

COPY entry_point.sh /usr/bin/entry_point.sh

CMD ["/usr/bin/entry_point.sh"]

