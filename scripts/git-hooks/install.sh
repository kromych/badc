#!/usr/bin/env bash
# Wire the committed pre-push hook into `.git/hooks/`. Run once per
# fresh checkout. Re-running is idempotent: the existing symlink is
# replaced.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
HOOK_SRC="$REPO_ROOT/scripts/git-hooks/pre-push"
HOOK_DST="$REPO_ROOT/.git/hooks/pre-push"

if [[ ! -f "$HOOK_SRC" ]]; then
    echo "$HOOK_SRC missing" >&2
    exit 1
fi

ln -sf "$HOOK_SRC" "$HOOK_DST"
chmod +x "$HOOK_SRC"
echo "installed: $HOOK_DST -> $HOOK_SRC"
