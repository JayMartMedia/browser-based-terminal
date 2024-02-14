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
COPY ./public/* ./public/

# Setup env
ENV LOG_LEVEL=INFO
EXPOSE 8080

CMD ["node", "backend/index.js"]
