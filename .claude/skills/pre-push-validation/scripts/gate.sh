#!/bin/bash
# Run the pre-push gate over every local box plus the macOS host.
# The boxes are the host repo's ssh remotes: every remote with an scp-style URL
# (host:path) is a lane named after the remote; a drive-letter path marks a
# Windows box, any other path a Linux box.
# usage: gate.sh [extra validate_local_boxes.py arguments]
set -u
cd "$(git rev-parse --show-toplevel)" || exit 1
args=()
for r in $(git remote); do
  url=$(git remote get-url "$r")
  case "$url" in
    *://*) continue ;;
    *:[A-Za-z]:/*) kind=windows ;;
    *:*) kind=linux ;;
    *) continue ;;
  esac
  args+=(--box "$r=$url:$kind")
done
[ ${#args[@]} -gt 0 ] || { echo "gate.sh: no box remotes (see the local-boxes skill)"; exit 2; }
args+=(--box mac=macos)
exec python3 scripts/validate_local_boxes.py "${args[@]}" "$@"
