#!/bin/sh
docker stop back
docker rm back
docker stop database
docker rm database
docker volume rm db_data
docker volume prune -f
docker network rm backend_network

docker network create --subnet 192.168.5.0/24 --ip-range 192.168.5.0/24 backend_network 
docker volume create db_data

docker build -t db_image -f Dockerfile.pg .
docker run --name database --network=backend_network -p 5432:5432 -v db_data:/var/lib/postgresql/data -d db_image

docker build -t backend -f Dockerfile.back .
docker run --name back -e django_pass="123" --network=backend_network -p 8000:8000 -d backend
docker ps
