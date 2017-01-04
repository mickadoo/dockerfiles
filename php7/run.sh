#!/usr/bin/env bash

docker run -it \
    -p 22:22 \
    -p 80:80 \
    -p 3306:3306 \
    -v /home/michael/workspace:/var/www \
    --network dockernet \
    --ip 172.19.0.2 \
    mickadoo/php7
