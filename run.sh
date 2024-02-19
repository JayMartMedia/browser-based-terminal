#!/bin/bash
# Usage:
#     `./run.sh` - run with default port 8080
#     `./run.sh 1234` - run with specific port 1234

PORT=${1:-8080}
docker run -d -p $PORT:8080 --name browser-terminal browser-terminal
docker ps
