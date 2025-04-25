# Termsonic Docker

A minimal Docker setup for running [Termsonic](https://git.sixfoisneuf.fr/termsonic). 

## Usage

1. Build the image:
   ```bash
   make build
   ```

2. Run the container:
   ```bash
   make start
   ```

    If you are using wsl you can run:
    ```bash
    make start-wsl
    ```

Configuration is loaded from `termsonic.toml` in the project root (mounted into `/config/termsonic.toml`).  

## Using the pre-built Docker image

Instead of building locally, pull and run the image from Docker Hub:

```bash
docker pull jorgelavin/termsonic:latest
docker run -it \
  --network host \
  -e PULSE_SERVER="${PULSE_SERVER}" \
  -v /mnt/wslg/:/mnt/wslg/ \
  -v "$(pwd)/termsonic.toml":/config/termsonic.toml:ro \
  jorgelavin/termsonic:latest
```

To run a specific version (e.g. v0.2):

```bash
docker pull jorgelavin/termsonic:v0.2
docker run -it \
  --network host \
  -e PULSE_SERVER="${PULSE_SERVER}" \
  -v /mnt/wslg/:/mnt/wslg/ \
  -v "$(pwd)/termsonic.toml":/config/termsonic.toml:ro \
  jorgelavin/termsonic:v0.2
```


## Publishing

To build and push a versioned Termsonic image, run:

```bash
make build IMAGE_NAME=jorgelavin/termsonic IMAGE_TAG=v0.2
make publish IMAGE_NAME=jorgelavin/termsonic IMAGE_TAG=v0.2
```

This will produce and push both jorgelavin/termsonic:v0.2 and jorgelavin/termsonic:latest.
