#!/bin/bash
docker stop salty || echo 'container already stopped'
docker rm salty || echo 'container already removed'
docker build -t my_local_salt . || exit 1
docker run --name salty -v "$PWD:/srv/salt" -d my_local_salt || exit 1
