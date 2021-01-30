#!/bin/sh
# Note: run on the root of this project (big-data-os)
docker build . -f spark/spark-hs.Dockerfile -t spark-hs:latest 