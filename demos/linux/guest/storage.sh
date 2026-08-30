#!/bin/sh
# Round-trip the root device through its storage controller.
#
# The boot probes conclude that a controller works from the disk having
# attached and from a file surviving a write and a re-read. A controller can
# do both while answering command after command with a hardware error, and the
# fault report is in the kernel log rather than in a return code -- so this
# runs the I/O inside one task, and the stage compares that task's own log
# window against the severity vocabulary.
#
# Environment: MB (payload size), DIR (where the file is written).
# Prints key=value; `status` is last.

set -u
MB=${MB:-64}
DIR=${DIR:-/var/tmp}
SEED=/dev/shm/badc-storage-seed
FILE="$DIR/badc-storage.bin"
trap 'rm -f "$SEED" "$FILE"' EXIT

fail() { echo "reason=$1"; echo "status=fail"; exit 1; }
drop() { echo 3 > /proc/sys/vm/drop_caches 2>/dev/null || true; }

src=$(findmnt -no SOURCE / | sed 's/\[.*//')
dev=$(lsblk -no PKNAME "$src" 2>/dev/null | head -1)
[ -n "$dev" ] || dev=$(basename "$src")
echo "dev=$dev"
echo "mb=$MB"
[ -b "/dev/$dev" ] || fail "no block device for the root filesystem"

dd if=/dev/urandom of="$SEED" bs=1M count="$MB" 2>/dev/null || fail "seed"
want=$(sha256sum < "$SEED" | cut -d' ' -f1)

t0=$(date +%s)
dd if="$SEED" of="$FILE" bs=1M oflag=direct 2>/dev/null || fail "write"
sync
echo "write_seconds=$(( $(date +%s) - t0 ))"

drop
t0=$(date +%s)
got=$(dd if="$FILE" bs=1M iflag=direct 2>/dev/null | sha256sum | cut -d' ' -f1)
echo "read_seconds=$(( $(date +%s) - t0 ))"
[ "$want" = "$got" ] || fail "file digest $got does not match the source $want"
echo "file_match=1"

# The same blocks read twice through the controller, with nothing written to
# the raw device: a controller that returns stale or short data differs here
# while the filesystem round trip above still agrees with itself.
a=$(dd if="/dev/$dev" bs=1M count="$MB" iflag=direct 2>/dev/null |
    sha256sum | cut -d' ' -f1)
drop
b=$(dd if="/dev/$dev" bs=1M count="$MB" iflag=direct 2>/dev/null |
    sha256sum | cut -d' ' -f1)
[ -n "$a" ] || fail "raw read produced nothing"
[ "$a" = "$b" ] || fail "raw read differs between passes: $a then $b"
echo "raw_match=1"
echo "status=pass"
