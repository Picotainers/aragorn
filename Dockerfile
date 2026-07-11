FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    aragorn \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data
ENTRYPOINT ["aragorn"]
