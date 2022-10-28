#!/bin/sh

if [ "$1" = "local" ]
then echo "$1"
else cd crewtech || return
fi

docker compose -f crewtech_api/.docker-compose/production.yml up -d --build
docker image prune -f --filter="dangling=true"
docker ps --format '{{.Names}} ===== {{.Status}}'
docker logs crewtech_production_django
