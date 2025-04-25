# syntax=docker/dockerfile:1.4

# --- Build stage -------------------------------------------------------
FROM golang:1.20-alpine AS builder

# Pull in git, the C toolchain, pkgconfig, and PulseAudio dev headers
RUN apk add --no-cache \
    git \
    ca-certificates \
    build-base \
    pkgconfig \
    pulseaudio-dev

WORKDIR /src
RUN --mount=type=cache,target=/root/.cache/go-build \
    git clone --branch main https://git.sixfoisneuf.fr/termsonic . && \
    go mod download

# Enable cgo so Oto’s PulseAudio driver is compiled in
RUN CGO_ENABLED=1 go build -o termsonic ./cmd/termsonic


# --- Final image -------------------------------------------------------
FROM alpine:3.19

# Only the PulseAudio client and certs (no ALSA)
RUN apk add --no-cache \
    ca-certificates \
    pulseaudio-utils \
    pulseaudio

# Copy certs and binary
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /src/termsonic /usr/local/bin/termsonic

# Mount your config at /config/termsonic.toml
ENV XDG_CONFIG_DIR=/config

ENTRYPOINT ["/usr/local/bin/termsonic"]

