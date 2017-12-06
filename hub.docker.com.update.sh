#!/usr/bin/env bash

# after 
# docker login

docker build -t laouache/gh-docker-script-armhf --pull . 
docker push laouache/gh-docker-script-armhf:latest
# docker-compose down
# docker-compose up -d

