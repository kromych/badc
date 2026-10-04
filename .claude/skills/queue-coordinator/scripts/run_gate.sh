#!/bin/bash
# Five-lane gate over HEAD while agent queues share the boxes: hold the locks the
# queues honor (~/.badc-heavy.lock and ~/.badc-kernel.lock on every Linux box
# remote), run the pre-push-validation skill's gate.sh, release the locks.
# Logs and status go to .claude/queues/gate/ (git-ignored).
# usage: run_gate.sh [extra validate_local_boxes.py arguments]
set -u
root=$(git rev-parse --show-toplevel) || exit 1
cd "$root"
G=.claude/queues/gate; mkdir -p "$G"
sha=$(git rev-parse --short HEAD)
log=$G/validate_$sha.log; status=$G/gate_status_$sha.txt
linux_hosts=()
for r in $(git remote); do
  url=$(git remote get-url "$r")
  case "$url" in *://*|*:[A-Za-z]:/*) continue ;; *:*) linux_hosts+=("${url%%:*}") ;; esac
done
take_lock() {  # $1 host, $2 lock name
  local out=$G/lock_${1%%.*}_$2.out
  ssh "$1" "flock ~/.badc-$2.lock bash -c 'echo \$\$ > ~/.badc-gate-$2.pid; echo LOCKED; exec sleep 14400'" < /dev/null > "$out" 2>&1 &
  until /usr/bin/grep -q LOCKED "$out"; do sleep 10; done
}
release_lock() { ssh "$1" "kill \$(cat ~/.badc-gate-$2.pid) 2>/dev/null; rm -f ~/.badc-gate-$2.pid" < /dev/null; }
echo "$(date '+%H:%M:%S') waiting for locks on ${linux_hosts[*]}" > "$status"
for h in "${linux_hosts[@]}"; do take_lock "$h" heavy; take_lock "$h" kernel; done
echo "$(date '+%H:%M:%S') locks held; gate running on $sha" >> "$status"
bash .claude/skills/pre-push-validation/scripts/gate.sh "$@" > "$log" 2>&1
rc=$?
for h in "${linux_hosts[@]}"; do release_lock "$h" heavy; release_lock "$h" kernel; done
echo "$(date '+%H:%M:%S') gate rc=$rc on $sha; log $log" >> "$status"
exit $rc
