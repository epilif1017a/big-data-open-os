#!/bin/sh
# Note: run on the root of this project (big-data-os)

docker run -d -p 8888:8888 -p 4040:4040 -p 4041:4041 --network hadoop --name jupyter jupyter/pyspark-notebook:spark-3.5.0
# if you have mac m1/m2 use: aarch64-spark-3.5.0 as the tag for the image