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

RUN apt-get update && apt-get install -y python3-pip ffmpeg && rm -rf /var/lib/apt/lists/*
RUN pip install -U yt-dlp --break-system-packages --no-cache-dir

COPY --from=builder /usr/local/cargo/bin/parrot /usr/local/bin/parrot

CMD ["parrot"]
