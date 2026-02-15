# Declare ARG before FROM
ARG OPENCLAW_VERSION=2026.2.14

FROM ghcr.io/openclaw/openclaw:${OPENCLAW_VERSION}

# Re-declare ARG after FROM (required for later use)
ARG OPENCLAW_VERSION

USER root

RUN apt-get update && \
    apt-get install -y curl git build-essential && \
    rm -rf /var/lib/apt/lists/*

USER 568
ENV HOME=/home/node

RUN mkdir -p $HOME/.linuxbrew && \
    NONINTERACTIVE=1 \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH="/home/node/.linuxbrew/bin:/home/node/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

WORKDIR /app
