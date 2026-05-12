FROM debian:bookworm AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/aragorn.tgz http://130.235.244.92/ARAGORN/Downloads/aragorn1.2.41.tgz && \
    tar -xzf /tmp/aragorn.tgz -C /tmp && \
    cd /tmp/aragorn1.2.41 && \
    make -j"$(nproc)" && \
    install -m 0755 aragorn /usr/local/bin/aragorn

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/bin/aragorn /usr/local/bin/aragorn
WORKDIR /data
ENTRYPOINT ["/usr/local/bin/aragorn"]
