#!/bin/bash
#docker stop browser-terminal
docker kill browser-terminal # docker kill is faster if you will never restart it
docker rm browser-terminal
