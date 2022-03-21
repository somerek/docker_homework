#!/bin/sh
docker stop front
docker rm front
docker image rm frontend

export SERVER_NAME=$(hostname)
docker build -t frontend --build-arg SERVER_NAME -f Dockerfile.front .
docker run -d -p 80:80 --name front frontend
docker ps
