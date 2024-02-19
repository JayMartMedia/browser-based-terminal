FROM node:18-bookworm

WORKDIR /opt/app

# Install deps and cache
COPY package.json .
COPY package-lock.json .
RUN npm ci

# Get latest packages and install vim (one liner to prevent caching)
RUN apt-get upgrade && apt-get update && apt-get install vim -y

# Copy backend src code
COPY ./backend/index.js ./backend/index.js

# Copy frontend public directory
COPY ./public/ ./public/

# Copy directory with sections
COPY ./sections/ ./sections/

# Setup env
ENV LOG_LEVEL=INFO
ENV PATH_TO_SECTIONS=/opt/app/sections

# TODO: I do NOT think the user should have access to read/write files in the app code directory.
#       They WILL need to have execute in order to run the check scripts.

CMD ["node", "backend/index.js"]
