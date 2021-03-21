#!/bin/sh
# Note: run on the root of this project (big-data-os)
docker build . -f hive/hive-metastore.Dockerfile -t hive-metastore:latest 