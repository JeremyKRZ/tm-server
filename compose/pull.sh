#!/bin/bash
echo "Pull du repo"
git pull
cd ./compose
echo "restarting containers ..."

docker-compose down
docker rm -f $(docker ps -a -q)
docker-compose up -d --build