#!/bin/bash
# Land queue commits on the checked-out branch of the main repo.
# usage: land.sh <sha>...   (oldest first)
# Fast-forwards when the list is exactly HEAD..last; otherwise cherry-picks each.
# Stops on a conflict, or when the post-commit snapshot hook leaves the tree dirty.
set -u
cd "$(git rev-parse --show-toplevel)" || exit 1
[ $# -gt 0 ] || { echo "usage: land.sh <sha>..."; exit 2; }
[ -z "$(git status --porcelain)" ] || { echo "STOP: the tree is dirty"; exit 2; }
last=${!#}
if git merge-base --is-ancestor HEAD "$last" 2>/dev/null &&
   [ "$(git rev-list --reverse HEAD.."$last" | tr '\n' ' ')" = "$(git rev-parse "$@" | tr '\n' ' ')" ]; then
  git merge --ff-only -q "$last" || exit 1
  git log --format='landed %h %s' HEAD~$#..HEAD | cut -c1-120
else
  for c in "$@"; do
    if ! git cherry-pick "$c" >/dev/null 2>&1; then
      echo "STOP: cherry-pick $c failed"; git status --short | head; exit 1
    fi
    if [ -n "$(git status --porcelain)" ]; then
      echo "DRIFT after $c:"; git status --short | head -20; exit 2
    fi
    git log -1 --format='landed %h %s' | cut -c1-120
  done
fi
up=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
echo "head $(git rev-parse --short HEAD)${up:+; past $up: $(git rev-list --count "$up"..HEAD)}"
