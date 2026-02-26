FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y nano curl ca-certificates gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Build essentials (for native deps)
# -----------------------------
RUN echo "=== [4/6] Installing build tools (build-essential, make) ===" && \
    apt-get update && \
    apt-get install -y --no-install-recommends build-essential make && \
    gcc --version | head -n 1 && \
    make --version | head -n 1 && \
    rm -rf /var/lib/apt/lists/*

RUN echo "=== [6/6] Installed tool versions summary ===" && \
    echo "OS:     $(. /etc/os-release && echo $PRETTY_NAME)" && \
    echo "bash:   $BASH_VERSION" && \
    echo "git:    $(git --version)" && \
    echo "curl:   $(curl --version | head -n 1)" && 

CMD ["sleep", "600"]
