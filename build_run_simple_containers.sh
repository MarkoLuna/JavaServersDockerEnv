#!/usr/bin/env bash

# build and pull all Images
docker build -t gitblit gitblit/
docker pull jenkins/jenkins:lts
docker pull sonarqube
docker pull mysql:5.6

# Gitblit Server
docker run -p 8081:8080 -d gitblit

# run jenkins container
docker run -p 8080:8080 -p 50000:50000 -d jenkins/jenkins:lts

# run SonarQube Server
docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube
# By default you can login as admin with password admin

# run MySQL Server 
docker run --name mysql-server -v /mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -p 3306:3306 -d mysql:5.6


# docker-machine ip