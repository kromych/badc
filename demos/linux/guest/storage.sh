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
# Each read is direct I/O first; when dd fails or delivers fewer bytes than
# the payload, it is repeated buffered and reported so with dd's message. A
# digest is compared only once the byte count matched.
#
# Environment: MB (payload size), DIR (where the file is written), SHM (a
# memory-backed directory for the seed and the read-back copy).
# Prints key=value; `status` is last.

set -u
MB=${MB:-64}
DIR=${DIR:-/var/tmp}
SHM=${SHM:-/dev/shm}
BYTES=$(( MB * 1048576 ))
SEED=$SHM/badc-storage-seed
COPY=$SHM/badc-storage-copy
ERR=$SHM/badc-storage-err
FILE="$DIR/badc-storage.bin"
trap 'rm -f "$SEED" "$COPY" "$ERR" "$FILE"' EXIT

fail() { echo "reason=$1"; echo "status=fail"; exit 1; }
drop() { echo 3 > /proc/sys/vm/drop_caches 2>/dev/null || true; }
size() { wc -c < "$1" | tr -d ' '; }

# What dd said, less the transfer statistics the byte count already covers.
dd_message() {
	grep -v -e 'records in$' -e 'records out$' -e 'bytes.*copied' "$ERR" |
		tr '\n' ' ' | sed 's/ *$//'
}

# read_copy SOURCE FLAGS COUNT: dd SOURCE into the copy. `bytes` and `digest`
# describe what arrived; `err` says why dd failed or stopped short.
read_copy() {
	: > "$COPY"
	dd if="$1" of="$COPY" bs=1M $2 ${3:+count=$3} 2>"$ERR"
	rc=$?
	bytes=$(size "$COPY")
	digest=$(sha256sum < "$COPY" | cut -d' ' -f1)
	[ "$rc" = 0 ] && [ "$bytes" = "$BYTES" ] && return 0
	err="$bytes of $BYTES bytes, dd exit $rc"
	msg=$(dd_message)
	[ -z "$msg" ] || err="$err: $msg"
	return 1
}

# read_back NAME SOURCE COUNT: direct I/O first, buffered when that fails.
read_back() {
	mode=direct
	flags=iflag=direct
	if ! read_copy "$2" "$flags" "$3"; then
		echo "${1}_direct_error=$err"
		direct=$err
		mode=buffered
		flags=
		drop
		read_copy "$2" "$flags" "$3" ||
			fail "$1 read: direct: $direct; buffered: $err"
	fi
	echo "${1}_read=$mode"
}

src=$(findmnt -no SOURCE / | sed 's/\[.*//')
dev=$(lsblk -no PKNAME "$src" 2>/dev/null | head -1)
[ -n "$dev" ] || dev=$(basename "$src")
echo "dev=$dev"
echo "mb=$MB"
[ -b "/dev/$dev" ] || fail "no block device for the root filesystem"

dd if=/dev/urandom of="$SEED" bs=1M count="$MB" 2>"$ERR" ||
	fail "seed: $(dd_message)"
[ "$(size "$SEED")" = "$BYTES" ] ||
	fail "seed: $(size "$SEED") of $BYTES bytes"
want=$(sha256sum < "$SEED" | cut -d' ' -f1)

t0=$(date +%s)
dd if="$SEED" of="$FILE" bs=1M oflag=direct 2>"$ERR" ||
	fail "write: $(dd_message)"
sync
echo "write_seconds=$(( $(date +%s) - t0 ))"

drop
t0=$(date +%s)
read_back file "$FILE" ""
echo "read_seconds=$(( $(date +%s) - t0 ))"
[ "$want" = "$digest" ] ||
	fail "file digest $digest does not match the source $want, read $mode"
echo "file_match=1"

# The same blocks read twice through the controller, with nothing written to
# the raw device: a controller that returns stale or short data differs here
# while the filesystem round trip above still agrees with itself.
read_back raw "/dev/$dev" "$MB"
a=$digest
drop
read_copy "/dev/$dev" "$flags" "$MB" || fail "raw read, second pass: $err"
[ "$a" = "$digest" ] || fail "raw read differs between passes: $a then $digest"
echo "raw_match=1"
echo "status=pass"
