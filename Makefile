# Makefile for building, running, and publishing the Termsonic Docker image

# You can override these on the command-line:
#    make build IMAGE_NAME=jorgelavin/termsonic IMAGE_TAG=v0.2
IMAGE_NAME ?= jorgelavin/termsonic
IMAGE_TAG  ?= main
IMAGE      := $(IMAGE_NAME):$(IMAGE_TAG)

.PHONY: build start publish

## build: Build the Docker image and tag with both $(IMAGE_TAG) and latest
build:
	docker build \
	  --build-arg REPO_REF=$(IMAGE_TAG) \
	  -t $(IMAGE_NAME):$(IMAGE_TAG) \
	  -t $(IMAGE_NAME):latest \
	  .

## start: Run the container and use the host networking for connecivity.
start:
	docker run -it \
		--network host \
		-v "$(PWD)/termsonic.toml":/config/termsonic.toml:ro \
		$(IMAGE_NAME):latest

## start: Run the container and use the host networking and WSLg PulseAudio
start-wsl:
	docker run -it \
		--network host \
		-e PULSE_SERVER="${PULSE_SERVER}" \
		-v /mnt/wslg/:/mnt/wslg/ \
		-v "$(PWD)/termsonic.toml":/config/termsonic.toml:ro \
		$(IMAGE_NAME):latest

## publish: Push both tags (versioned and latest) to the registry
publish: build
	docker push $(IMAGE_NAME):$(IMAGE_TAG)
	docker push $(IMAGE_NAME):latest
