# Adapted from Parrot's Dockerfile https://github.com/aquelemiguel/parrot/blob/fcf933818a5e754f5ad4217aec8bfb16935d7442/Dockerfile

FROM rust:slim-bullseye as build

RUN apt-get update && apt-get install -y \
    build-essential autoconf automake cmake libtool libssl-dev pkg-config python3-pip ffmpeg
RUN pip install -U yt-dlp

WORKDIR "/usr/src/parrot"
COPY . .

RUN cargo install --path .

ENV DISCORD_TOKEN=<TODO>
ENV DISCORD_APP_ID=<TODO>

CMD ["parrot"]
