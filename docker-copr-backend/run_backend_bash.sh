#!/usr/bin/sh

docker run --rm  -p 10080:80 -t -i --name back_bash --link front:front  kost/test_back bash

