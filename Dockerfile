ARG OPENCLAW_VERSION=2026.2.14
FROM ghcr.io/openclaw/openclaw:${OPENCLAW_VERSION}

USER root

# Install required dependencies for Linuxbrew
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      curl \
      file \
      git \
      ca-certificates \
      procps \
    && rm -rf /var/lib/apt/lists/*

# Switch to OpenClaw user
USER 568
ENV HOME=/home/node

# Install Homebrew manually (no interactive script)
RUN git clone https://github.com/Homebrew/brew $HOME/.linuxbrew/Homebrew && \
    mkdir -p $HOME/.linuxbrew/bin && \
    ln -s $HOME/.linuxbrew/Homebrew/bin/brew $HOME/.linuxbrew/bin/brew

# Add brew to PATH
ENV PATH="/home/node/.linuxbrew/bin:/home/node/.linuxbrew/sbin:${PATH}"

# Verify brew works
RUN brew --version

WORKDIR /app
