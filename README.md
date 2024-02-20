# Browser Based Terminal

> WARNING: Running this container in an environment accessible by untrusted users could negatively affect your network/hosts (see [#security](#security))

> WIP: Still early stages in this project. Feel free to play around, but expect changes :)
## Overview

This project allows you to run a Docker container that exposes its terminal to the browser. 

The ultimate intent of this project is to be a building block for the running of local, containerized, browser-based learning environments which rely on the command line (similar to https://killercoda.com/ but running locally).

This project was partially inspired by my experience taking the [CKAD](https://www.cncf.io/training/certification/ckad/) exam. I really enjoyed the hands-on aspect of this exam.

## Usage

1. Build and run the image: `./script.sh recycle` (if this fails due to port 8080 being in use, you can run by specifying a different port `./script.sh recycle 1234`)
   - If you are not running from a bash shell, you can look at the docker commands in the build and start functions in [./script.sh](./script.sh) and run them directly in your terminal
2. Navigate in your browser to [http://localhost:8080](http://localhost:8080) (or the port you specified if 8080 was already in use)

To stop and remove the container you can run `./script.sh stop -r`.

## Security

> WARNING: It would only take browser access for someone to exploit these attacks. Don't expose the port used by this container (default 8080) to your network.

This project is NOT meant to be a secure way to expose a terminal to arbitrary users.

Although the terminal is isolated away from the host filesystem due to being run in a Docker container, it can still use curl/wget to access the network of the host machine. Having terminal access could also allow an attacker to run a fork bomb which could affect the host depending on how Docker is configured.

For this reason you should NOT allow arbitrary users to access the terminal exposed by this Docker container.

### Securing this project

In theory you may be able to put limits on the Docker container which limit the resources it can use, and prevent outgoing network requests. But proceed with this at your own risk.
