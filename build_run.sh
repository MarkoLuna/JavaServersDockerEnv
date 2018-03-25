#!/usr/bin/env bash

echo "Building Giblit Server"
docker build -t gitblit gitblit/

echo "Building Jenkins Server"
docker build -t swfactory/jenkins:lts jenkins/

docker-compose up 

# docker-compose down
# docker-machine ip
