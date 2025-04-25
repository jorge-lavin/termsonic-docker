# Makefile for building and running the Termsonic Docker image

# Docker image name and tag
IMAGE ?= termsonic:pa

.PHONY: build start

## build: Build the Docker image
build:
	docker build -t $(IMAGE) .

## start: Run the container with WSLg PulseAudio and host networking for Tailscale
start:
	docker run -it \
		--network host \
		-e PULSE_SERVER="${PULSE_SERVER}" \
		-v /mnt/wslg/:/mnt/wslg/ \
		-v "$(PWD)/termsonic.toml":/config/termsonic.toml:ro \
		$(IMAGE)
