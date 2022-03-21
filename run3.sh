#!/bin/sh

docker run -d -p 5000:5000 --name registry registry:2

docker build -t db_image -f Dockerfile.pg .
docker tag db_image:latest localhost:5000/db_image:0.0.1
docker push localhost:5000/db_image:0.0.1

docker build -t backend -f Dockerfile.back .
docker tag backend:latest localhost:5000/backend:0.0.1
docker push localhost:5000/backend:0.0.1

export SERVER_NAME=localhost
docker build -t frontend --build-arg SERVER_NAME -f Dockerfile.front .
docker tag frontend:latest localhost:5000/frontend:0.0.1
docker push localhost:5000/frontend:0.0.1

cp env_sample .env
docker-compose up --build -d
docker-compose ps
