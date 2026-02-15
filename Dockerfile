ARG OPENCLAW_VERSION=2026.2.14
FROM ghcr.io/openclaw/openclaw:${OPENCLAW_VERSION}

USER root

# Required system dependencies for Linuxbrew
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      curl \
      file \
      git \
      ca-certificates \
      procps \
    && rm -rf /var/lib/apt/lists/*

# Create linuxbrew user
RUN useradd -m -u 1000 linuxbrew

# Install Homebrew non-interactively
USER linuxbrew
ENV HOME=/home/linuxbrew

RUN git clone https://github.com/Homebrew/brew $HOME/.linuxbrew/Homebrew && \
    mkdir -p $HOME/.linuxbrew/bin && \
    ln -s $HOME/.linuxbrew/Homebrew/bin/brew $HOME/.linuxbrew/bin/ && \
    $HOME/.linuxbrew/bin/brew update --force --quiet

# Make brew available system-wide
USER root
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# Optional: Verify
RUN brew --version

# Switch back to OpenClaw user
USER 568
ENV HOME=/home/node

WORKDIR /app
