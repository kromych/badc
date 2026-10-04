#!/bin/bash
# Five-lane gate over HEAD while agent queues share the boxes: hold the locks the
# queues honor (~/.badc-heavy.lock and ~/.badc-kernel.lock on every Linux box
# remote) for as long as that box's lane runs, run the pre-push-validation
# skill's gate.sh, and release each box when its lane prints its wall clock.
# Logs and status go to .claude/queues/gate/ (git-ignored).
# usage: run_gate.sh [extra validate_local_boxes.py arguments]
set -u
root=$(git rev-parse --show-toplevel) || exit 1
cd "$root"
G=.claude/queues/gate; mkdir -p "$G"
sha=$(git rev-parse --short HEAD)
log=$G/validate_$sha.log; status=$G/gate_status_$sha.txt
lanes=(); hosts=()
for r in $(git remote); do
  url=$(git remote get-url "$r")
  case "$url" in *://*|*:[A-Za-z]:/*) continue ;; *:*) lanes+=("$r"); hosts+=("${url%%:*}") ;; esac
done
take_lock() {  # $1 host, $2 lock name
  local out=$G/lock_${1%%.*}_$2.out
  ssh "$1" "flock ~/.badc-$2.lock bash -c 'echo \$\$ > ~/.badc-gate-$2.pid; echo LOCKED; exec sleep 14400'" < /dev/null > "$out" 2>&1 &
  until /usr/bin/grep -q LOCKED "$out"; do sleep 10; done
}
# Kills the holder only after checking it is the gate's sleep, then drops the pid file.
release_box() {  # $1 host
  ssh "$1" 'for l in heavy kernel; do f=~/.badc-gate-$l.pid; [ -f $f ] || continue;
    p=$(cat $f); ps -o args= -p $p | grep -q "sleep 14400" && kill $p; rm -f $f; done' < /dev/null
}
echo "$(date '+%H:%M:%S') waiting for locks on ${hosts[*]}" > "$status"
for h in "${hosts[@]}"; do take_lock "$h" heavy; take_lock "$h" kernel; done
echo "$(date '+%H:%M:%S') locks held; gate running on $sha" >> "$status"
bash .claude/skills/pre-push-validation/scripts/gate.sh "$@" > "$log" 2>&1 &
gate=$!
released=()
while kill -0 "$gate" 2>/dev/null; do
  for i in "${!lanes[@]}"; do
    [ -n "${released[$i]:-}" ] && continue
    if /usr/bin/grep -q "^\[${lanes[$i]}\] lane wall clock" "$log"; then
      release_box "${hosts[$i]}"; released[$i]=1
      echo "$(date '+%H:%M:%S') ${lanes[$i]} lane done; its locks released" >> "$status"
    fi
  done
  sleep 30
done
wait "$gate"; rc=$?
for i in "${!lanes[@]}"; do [ -n "${released[$i]:-}" ] || release_box "${hosts[$i]}"; done
echo "$(date '+%H:%M:%S') gate rc=$rc on $sha; log $log" >> "$status"
exit $rc
