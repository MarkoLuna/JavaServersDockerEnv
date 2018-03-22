#!/usr/bin/env bash

if [ "$(docker network ls | grep dockernet)" ]; then
    echo "Removing dockernet ..." 
    echo 
    docker network rm dockernet
fi

echo "Creating network ..."
docker network create -d bridge --subnet 10.51.145.0/23 --gateway 10.51.144.1 dockernet

echo "Building Giblit Server"
docker build -t gitblit gitblit/

echo "Building Jenkins Server"
docker build --rm -t swfactory/jenkins:lts jenkins/

docker-compose up 

# docker-compose down
# docker-machine ip
