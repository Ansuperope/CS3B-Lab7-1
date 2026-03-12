# Creates a Arm64 environment
FROM --platform=linux/arm64 ubuntu:22.04

# States theres no frontend
ENV DEBIAN_FRONTEND=noninteractive

# Commands to run to build
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        gdb \
        strace \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# States folder to run
WORKDIR /workspace

CMD ["/bin/bash"]