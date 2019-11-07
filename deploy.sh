#!/bin/bash
rsync -avzh --chown node:nogroup backend/ /srv/node/xrpolsup/
systemctl restart xrpolsup
