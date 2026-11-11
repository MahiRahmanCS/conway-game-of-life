#!/usr/bin/env bash
# Build Conway's Game of Life and copy the executable into ./dist
set -euo pipefail

# Use sudo only if we're not already root (e.g. inside a Docker container)
SUDO=""
if [ "$(id -u)" -ne 0 ]; then SUDO="sudo"; fi

# 1. Update the machine first (always do this on a fresh VM)
# Note: sudo drops exported variables, so DEBIAN_FRONTEND is passed on each
# command, and the dpkg options stop config-file prompts from hanging the build.
export DEBIAN_FRONTEND=noninteractive
APT="$SUDO env DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold"
$APT update
# Hold back snap-wrapper packages (e.g. firefox on GitHub's Ubuntu runners):
# upgrading them needs the Snap Store, which runners can't reach, so
# dist-upgrade hangs and then fails.
SNAP_PKGS=$(dpkg-query -W -f='${Package} ${Version}\n' | awk '$2 ~ /snap/ {print $1}')
if [ -n "$SNAP_PKGS" ]; then
  echo "Holding snap-wrapper packages: $SNAP_PKGS"
  $SUDO apt-mark hold $SNAP_PKGS
fi
$APT dist-upgrade

# 2. Install build dependencies
$APT install build-essential git

# 3. Build
make clean
make

# 4. Copy the executable somewhere it can be picked up / run
mkdir -p dist
cp conway dist/
# Tarball keeps the executable bit (artifact zips drop it)
tar -czf dist/conway-linux-x86_64.tar.gz -C dist conway

echo "Build finished: $(pwd)/dist/conway"
