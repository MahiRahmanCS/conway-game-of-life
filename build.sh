#!/usr/bin/env bash
# Build Conway's Game of Life and copy the executable into ./dist
set -euo pipefail

# Use sudo only if we're not already root (e.g. inside a Docker container)
SUDO=""
if [ "$(id -u)" -ne 0 ]; then SUDO="sudo"; fi

# 1. Update the machine first (always do this on a fresh VM)
export DEBIAN_FRONTEND=noninteractive
$SUDO apt-get update
$SUDO apt-get dist-upgrade -y

# 2. Install build dependencies
$SUDO apt-get install -y build-essential git

# 3. Build
make clean
make

# 4. Copy the executable somewhere it can be picked up / run
mkdir -p dist
cp conway dist/
# Tarball keeps the executable bit (artifact zips drop it)
tar -czf dist/conway-linux-x86_64.tar.gz -C dist conway

echo "Build finished: $(pwd)/dist/conway"
