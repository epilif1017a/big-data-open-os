#!/bin/sh
# Note: run on the root of this project (big-data-os)

docker run -d -p 8888:8888 -p 4040:4040 -p 4041:4041 --network hadoop --name jupyter jupyter/all-spark-notebook:spark-3.1.1
