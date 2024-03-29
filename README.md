# Browser Based Terminal

> WARNING: Running this container in an environment accessible by untrusted users could negatively affect your network/hosts (see [#security](#security))

> WIP: Still early stages in this project. Feel free to play around, but expect changes :)
## Overview

This project allows you to run a Docker container that exposes its terminal to the browser. 

The ultimate intent of this project is to be a building block for the running of local, containerized, browser-based learning environments which rely on the command line (similar to https://killercoda.com/ but running locally).

This project was partially inspired by my experience taking the [CKAD](https://www.cncf.io/training/certification/ckad/) exam. I really enjoyed the hands-on aspect of this exam.

## Usage

Running the Docker container in order to access the browser based terminal

1. Build the image: `./build.sh`
2. Run the image: `./run.sh` (if this fails due to port 8080 being in use, you can run by specifying a different port `./run.sh 1234`)
3. Navigate in your browser to [http://localhost:8080](http://localhost:8080) (or the port you specified if 8080 was already in use)

Once the container is running you can interact with it from your browser!

To stop and remove the container you can run `./stop.sh`.

## Security

> WARNING: It would only take browser access for someone to exploit these attacks. Don't expose the port used by this container (default 8080) to your network.

This project is NOT meant to be a secure way to expose a terminal to arbitrary users.

Although the terminal is isolated away from the host filesystem due to being run in a Docker container, it can still use curl/wget to access the network of the host machine. Having terminal access could also allow an attacker to run a fork bomb which could affect the host depending on how Docker is configured.

For this reason you should NOT allow arbitrary users to access the terminal exposed by this Docker container.

### Securing this project

In theory you may be able to put limits on the Docker container which limit the resources it can use, and prevent outgoing network requests. But proceed with this at your own risk.
