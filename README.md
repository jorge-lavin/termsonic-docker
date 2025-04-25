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
