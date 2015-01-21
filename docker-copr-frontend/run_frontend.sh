#!/usr/bin/sh

sudo docker run -p 9022:22  -p 127.0.1.99:80:80 -p 127.0.1.99:1080:1080 -t -i --name front -d  -v /srv/docker/shared_ro:/opt/shared_ro:ro -v /home/vgologuz/dev/copr/frontend:/opt/copr-frontend:ro test_front
