docker run -it   --network host   -e PULSE_SERVER="${PULSE_SERVER}"   -v /mnt/wslg/:/mnt/wslg/   -v "$(pwd)/termsonic.toml":/config/termsonic.toml:ro   termsonic:pa
