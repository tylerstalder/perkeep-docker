#!/bin/sh
# run-container.sh
# Description: Run docker container for development

STORAGE_DIR="$HOME/perkeep/data"
CONFIG_DIR="$HOME/perkeep/config"

mkdir -p "$STORAGE_DIR"
mkdir -p "$CONFIG_DIR"

docker run -itP --rm -v $STORAGE_DIR:/storage -v $CONFIG_DIR:/config -p 3179:3179 perkeep:latest
