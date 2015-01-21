#!/usr/bin/sh

cd /home/copr
HOME=/home/copr PYTHONPATH=/usr/share/copr:$PYTHONPATH python /usr/bin/copr_be.py


