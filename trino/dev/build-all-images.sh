#!/bin/sh
# Note: run on the root of this project (big-data-os)
docker build . -f trino/trino.Dockerfile -t trino:latest 
