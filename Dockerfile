# Creates a Arm64 environment
FROM ubuntu:22.04

# States theres no frontend
ENV DEBIAN_FRONTEND=noninteractive

# Commands to run to build
RUN apt-get update && \
    apt-get install -y \
        gcc-aarch64-linux-gnu \
        binutils-aarch64-linux-gnu \
        qemu-user \
        gdb-multiarch \
        make && \
    rm -rf /var/lib/apt/lists/*

# States folder to run
WORKDIR /workspace

CMD ["/bin/bash"]
