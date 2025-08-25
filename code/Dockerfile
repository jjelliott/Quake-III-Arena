FROM debian:stretch
RUN echo "deb http://archive.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security stretch/updates main contrib non-free" >> /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

# Install legacy build tools
RUN apt-get update && apt-get install -y \
    gcc-2.95 g++-2.95 make perl libc6-i386 \
    libncurses5-dev wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /quake3

# Set default command to build
ENTRYPOINT ["./unix/cons", "--", "gcc=gcc-2.95", "g++=g++-2.95"]

