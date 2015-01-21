#!/usr/bin/sh

docker run -d  -p 127.0.2.99:80:80 -t -i --name back --link front:front.test  -v /srv/docker/shared_ro:/opt/shared_ro:ro  test_back

