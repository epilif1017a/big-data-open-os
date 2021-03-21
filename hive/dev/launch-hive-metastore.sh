#!/bin/sh
docker container rm -f hive-metastore-db hive-metastore

docker run -d --name hive-metastore-db -v hive-metastore-db-volume:/var/lib/mysql --network hadoop -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=hive -e MYSQL_USER=hive -e MYSQL_PASSWORD=hive mysql:8
echo "INFO: Waiting for hive metastore db to be up..."
sleep 10

docker run -d --network hadoop --name hive-metastore -p 9083:9083 hive-metastore