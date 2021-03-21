#!/bin/sh
# Note: run on the root of this project (big-data-os)

echo "building images..."
docker build . -f ./hadoop/hadoop-base.Dockerfile -t hadoop-base

docker build . -f ./hadoop/hdfs-nn.Dockerfile -t hdfs-nn &
p1=$!
docker build . -f ./hadoop/hdfs-dn.Dockerfile -t hdfs-dn &
p2=$!
docker build . -f ./hadoop/yarn-rm.Dockerfile -t yarn-rm &
p3=$!
docker build . -f ./hadoop/yarn-nm.Dockerfile -t yarn-nm &
p4=$!
docker build . -f ./hadoop/yarn-ts.Dockerfile -t yarn-ts &
p5=$!
docker build . -f ./big-data-os-client/big-data-os-client.Dockerfile -t big-data-os-client &
p6=$!

wait $p1 $p2 $p3 $p4 $p5 $p6