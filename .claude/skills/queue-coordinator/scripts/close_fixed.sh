#!/bin/bash
# Close each open issue named by a `Fixes: #N` trailer in <base>..HEAD.
# usage: close_fixed.sh <base> <remote-branch> <pr> local|pushed
#   local:  commits not yet on <remote-branch> ("arrives with the next push")
#   pushed: commits already on <remote-branch>
set -u
[ $# -eq 4 ] || { echo "usage: close_fixed.sh <base> <remote-branch> <pr> local|pushed"; exit 2; }
base=$1 remote=$2 pr=$3 mode=$4
cd "$(git rev-parse --show-toplevel)" || exit 1
branch=${remote#*/}
for c in $(git rev-list --reverse "$base"..HEAD); do
  for n in $(git log -1 --format='%(trailers:key=Fixes,valueonly,separator=%x20)' "$c" | /usr/bin/grep -oE '[0-9]+'); do
    if git merge-base --is-ancestor "$c" "$remote"; then state=pushed; else state=local; fi
    [ "$state" = "$mode" ] || continue
    st=$(gh issue view "$n" --json state --jq .state)
    [ "$st" = "OPEN" ] || continue
    sha=$(git rev-parse --short=9 "$c"); subj=$(git log -1 --format=%s "$c")
    if [ "$mode" = pushed ]; then where="on $branch (PR #$pr)"; else where="on $branch, in the next push to PR #$pr"; fi
    gh issue close "$n" --comment "Fixed by $sha $where: $subj." >/dev/null && echo "closed #$n by $sha"
  done
done
