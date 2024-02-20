#!/bin/bash
# Usage details
usage() {
    echo "Usage: ./script.sh <command> [<options>]"
    echo "For example:"
    echo "  './script.sh start 1234'"
    echo "  './script.sh stop -r'"
    echo "  './script.sh r' <-- the one I use the most often to quickly rebuild and run"
    echo ""
    echo "Commands:"
    echo "  --help            display this usage screen (alias -h)"
    echo "  build             build the docker image (alias b)"
    echo "  start             start the docker container on the default port 8080 (alias sta)"
    echo "    start 9090      start the docker container on port 9090 (alias sta)"
    echo "  stop              stop the docker image, does not remove the container which keeps state (alias sto)"
    echo "    stop -r         kill and remove the docker container clearing all state (alias sto)"
    echo "  recycle           stop, build, the start the container on the default port 8080 (alias r)"
    echo "    recycle 9090    stop, build, the start the container on port 9090 (alias r)"
}

# Print usage details
if [ "$1" = "--help" ]; then 
    usage
elif [ "$1" = "-h" ]; then
    usage
elif [ "$1" = "" ]; then
    usage
fi

# Commands
build() {
    docker build -t browser-based-terminal .
}

start() {
    PORT=${1:-8080}
    docker run -d -p $PORT:8080 --name browser-based-terminal browser-based-terminal
    docker ps
}

stop() {
    if [ "$1" = "-r" ]; then
        docker kill browser-based-terminal
        docker rm browser-based-terminal
    else
        docker stop browser-based-terminal
    fi    
}

recycle() {
    stop -r
    build
    start $1
}

# Run commands
if [ "$1" = "build" ] || [ "$1" = "b" ]; then
    build
elif [ "$1" = "start" ] || [ "$1" = "sta" ]; then 
    start $2
elif [ "$1" = "stop" ] || [ "$1" = "sto" ]; then
    stop $2
elif [ "$1" = "recycle" ] || [ "$1" = "r" ]; then
    recycle $2
fi
