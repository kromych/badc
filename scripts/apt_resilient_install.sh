#!/bin/sh
# Install apt packages, tolerating the recurring ports.ubuntu.com (arm64
# archive) outages. Retry a few times with backoff, alternating between the
# default mirror and the Azure-hosted one each attempt -- the outages are
# usually transient over a couple of minutes and rarely hit both at once.
# Usage: apt_resilient_install.sh <pkg> [pkg ...]
set -e
# ForceIPv4: the runners' IPv6 route to the Ubuntu ports archive is often
# dead ("Network is unreachable" on 2620: addresses), which otherwise burns
# retry attempts on instant failures before the IPv4 path is even tried.
printf 'Acquire::Retries "3";\nAcquire::ForceIPv4 "true";\n' \
    | sudo tee /etc/apt/apt.conf.d/80-badc-retries >/dev/null

DEFAULT='http://ports.ubuntu.com/ubuntu-ports'
AZURE='http://azure.ports.ubuntu.com/ubuntu-ports'
files() {
    echo /etc/apt/sources.list /etc/apt/apt-mirrors.txt \
        $(ls /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources 2>/dev/null)
}
use_mirror() {
    # $1 = from, $2 = to
    sudo sed -i "s|$1|$2|g" $(files) 2>/dev/null || true
}

attempt=0
on_azure=0
while :; do
    attempt=$((attempt + 1))
    sudo apt-get update -y || true
    if sudo apt-get install -y --fix-missing "$@"; then
        exit 0
    fi
    if [ "$attempt" -ge 6 ]; then
        echo "apt install still failing after $attempt attempts" >&2
        exit 1
    fi
    # Rotate to the other mirror and back off; the outage often clears.
    if [ "$on_azure" -eq 0 ]; then
        echo "attempt $attempt failed; switching to the Azure mirror" >&2
        use_mirror "$DEFAULT" "$AZURE"
        on_azure=1
    else
        echo "attempt $attempt failed; switching back to the default mirror" >&2
        use_mirror "$AZURE" "$DEFAULT"
        on_azure=0
    fi
    sleep 30
done
