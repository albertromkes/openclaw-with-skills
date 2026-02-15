ARG OPENCLAW_VERSION=2026.2.14
FROM ghcr.io/openclaw/openclaw:${OPENCLAW_VERSION}

USER root

# Install dependencies required for Homebrew
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      curl \
      file \
      git \
      ca-certificates \
      procps \
    && rm -rf /var/lib/apt/lists/*

# Ensure /home/node is writable
RUN mkdir -p /home/node/.linuxbrew && \
    mkdir -p /home/node/.npm-global && \
    chown -R 568:568 /home/node

# Switch to OpenClaw user
USER 568
ENV HOME=/home/node

# Set npm global prefix to a directory owned by the container user
ENV NPM_CONFIG_PREFIX=$HOME/.npm-global
ENV PATH="$HOME/.npm-global/bin:/home/node/.linuxbrew/bin:/home/node/.linuxbrew/sbin:$PATH"

# Install Homebrew manually (no installer script)
RUN git clone https://github.com/Homebrew/brew $HOME/.linuxbrew/Homebrew && \
    mkdir -p $HOME/.linuxbrew/bin && \
    ln -s $HOME/.linuxbrew/Homebrew/bin/brew $HOME/.linuxbrew/bin/brew

# Verify installations
RUN brew --version && npm --version

# Now you can safely install global npm packages as UID 568
# Example: RUN npm install -g clawhub

WORKDIR /app
