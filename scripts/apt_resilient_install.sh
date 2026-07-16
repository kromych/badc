#!/bin/sh
# Install apt packages, tolerating ports.ubuntu.com outages that
# recurrently fail the arm64 archive. Set retries, try the install, and
# on failure rotate to the Azure-hosted mirror, refresh, and retry with
# --fix-missing. Usage: apt_resilient_install.sh <pkg> [pkg ...]
set -e
echo 'Acquire::Retries "3";' | sudo tee /etc/apt/apt.conf.d/80-badc-retries >/dev/null
sudo apt-get update -y || true
if sudo apt-get install -y "$@"; then
    exit 0
fi
echo "apt install failed; rotating to the Azure mirror and retrying" >&2
sudo sed -i 's|http://ports.ubuntu.com/ubuntu-ports|http://azure.ports.ubuntu.com/ubuntu-ports|g' \
    /etc/apt/sources.list /etc/apt/apt-mirrors.txt \
    $(ls /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources 2>/dev/null) || true
sudo apt-get update -y
sudo apt-get install -y --fix-missing "$@"
