# Build image
# Necessary dependencies to build Parrot
FROM rust:slim-bookworm AS builder

RUN apt-get update && apt-get install -y \
    build-essential autoconf automake cmake libtool libssl-dev pkg-config

WORKDIR "/usr/src/parrot"
COPY . .
RUN cargo install --path .

# Release image
# Necessary dependencies to run Parrot
FROM debian:bookworm-slim 

RUN apt-get update && apt-get install -y ffmpeg wget && rm -rf /var/lib/apt/lists/*

# Install yt-dlp
RUN wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp

COPY --from=builder /usr/local/cargo/bin/parrot /usr/local/bin/parrot

CMD ["parrot"]
