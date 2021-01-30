#!/bin/sh
docker container rm -f spark-hs

docker run -d --name spark-hs --hostname spark-hs --network hadoop -p 18080:18080 spark-hs