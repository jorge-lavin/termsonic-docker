# Termsonic Docker

A minimal Docker setup for running [Termsonic](https://git.sixfoisneuf.fr/termsonic). on a tailscale server using docker over wsl2

## Requirements

- Docker  
- WSLg (for audio)  
- Tailscale (host networking)  

## Usage

1. Build the image:
   ```bash
   make build
   ```

2. Run the container:
   ```bash
   make start
   ```

Configuration is loaded from `termsonic.toml` in the project root (mounted into `/config/termsonic.toml`).  
