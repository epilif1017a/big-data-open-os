#!/bin/sh
docker container rm -f trino

docker run -d -p 8080:8080 --network hadoop --name trino trino
