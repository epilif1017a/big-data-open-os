#!/bin/sh
echo "removing possible leftovers..."
docker container rm -f hdfs-nn hdfs-dn1 yarn-nm1 yarn-rm yarn-ts
docker network rm hadoop

echo "creating hadoop network..."
docker network create hadoop

echo "bringing hdfs up..."
docker run -d --name hdfs-nn --hostname hdfs-nn --network hadoop -p 9870:9870 hdfs-nn

echo "waiting for hdfs nn to be up..."
sleep 30

docker run -d --name hdfs-dn1 --hostname hdfs-dn1 --network hadoop -p 9864:9864 hdfs-dn 

echo "waiting for hdfs dn to be up..."
sleep 30

echo "creating folders and setting permissions..."
docker run -it --network hadoop big-data-os-client /home/hdfs/bin/init-fs.sh

#echo "uploading spark yarn archive"
#docker run -it --network hadoop big-data-os-client /home/hdfs/bin/upload-spark-yarn-archive.sh

#echo "bringing yarn and history server up..."
#docker run -d --name yarn-rm --hostname yarn-rm --network hadoop -p 8088:8088 yarn-rm 
#docker run -d --name yarn-nm1 --hostname yarn-nm1 --network hadoop -p 8042:8042 yarn-nm
#docker run -d --name yarn-ts --hostname yarn-ts --network hadoop -p 8188:8188 yarn-ts