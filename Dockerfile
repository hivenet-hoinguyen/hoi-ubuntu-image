FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-lc"]

# -----------------------------
# Base + popular CLI tools
# -----------------------------
RUN echo "=== [1/3] Installing base CLI tools ===" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      nano \
      curl \
      ca-certificates \
      gnupg \
      wget \
      unzip \
      zip \
      jq \
      openssh-client \
      less \
      vim-tiny \
      procps \
      iputils-ping \
      dnsutils \
      net-tools \
      lsb-release \
      software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# -----------------------------
# Node.js (LTS) + npm
# -----------------------------
RUN echo "=== [2/3] Installing Node.js (LTS) + npm ===" && \
    apt-get update && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    echo "Node: $(node -v)" && \
    echo "npm:  $(npm -v)" && \
    rm -rf /var/lib/apt/lists/*

# -----------------------------
# Build tools (for npm native deps)
# -----------------------------
RUN echo "=== [3/3] Installing build tools ===" && \
    apt-get update && \
    apt-get install -y --no-install-recommends build-essential make && \
    gcc --version | head -n 1 && \
    make --version | head -n 1 && \
    rm -rf /var/lib/apt/lists/*

# -----------------------------
# Summary
# -----------------------------
RUN echo "=== [5/5] Installation Summary ===" && \
    echo "OS:     $(. /etc/os-release && echo $PRETTY_NAME)" && \
    echo "bash:   $BASH_VERSION" && \
    echo "git:    $(git --version 2>/dev/null || echo 'already present')" && \
    echo "node:   $(node -v)" && \
    echo "npm:    $(npm -v)" && \
    echo "nano:   $(nano --version | head -n 1)"

CMD ["sleep", "3600"]
