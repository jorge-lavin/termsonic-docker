# syntax=docker/dockerfile:1.4

# ─── Build Stage ────────────────────────────────────────────────────────
FROM golang:1.20 AS builder

# Install git, C toolchain, pkg-config, PulseAudio *and* ALSA dev headers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git \
      build-essential \
      pkg-config \
      libasound2-dev \
      libpulse-dev \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git clone --branch main https://git.sixfoisneuf.fr/termsonic . \
 && go mod download

RUN CGO_ENABLED=1 go build -o termsonic ./cmd/termsonic

# ─── Runtime Stage ──────────────────────────────────────────────────────
FROM ubuntu:22.04

# Pull in both ALSA & PulseAudio clients + certs
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libasound2 \
      libpulse0 \
      pulseaudio \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# copy your built binary
COPY --from=builder /src/termsonic /usr/local/bin/termsonic

# point Termsonic at /config/termsonic.toml
ENV XDG_CONFIG_DIR=/config

ENTRYPOINT ["/usr/local/bin/termsonic"]
