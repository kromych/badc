#!/bin/sh
# Filesystem and block-stack exercise for one filesystem instance (guest side).
#
# Creates the filesystem on a loop device over a sparse file (or on a device
# the caller names), runs parallel adversarial workloads over it for a bounded
# time, then verifies file content against digests computed from the source
# data rather than from the filesystem: the data is written, the page cache is
# dropped, the filesystem is remounted and every digest is checked again. A
# codegen defect on a checksum or copy path shows up there as a digest
# mismatch, which no dmesg scan would report. The instance ends with the
# filesystem's own check-only fsck.
#
# Settings arrive in the environment; every one has a default here. Output is
# key=value lines on stdout, `status=` last.

: "${LABEL:=fs}"
: "${DEV:=}"
: "${IMG:=/var/tmp/badc-fs-$LABEL.img}"
: "${SIZE:=2G}"
: "${LBLK:=512}"
: "${MKFS:=mkfs.ext4 -q -F}"
: "${MTYPE:=auto}"
: "${MOPTS:=}"
: "${FEATS:=links perms sparse odirect}"
: "${SECS:=20}"
: "${JOBS:=4}"
: "${FSCK:=}"
: "${MNT:=/mnt/badc-$LABEL}"
: "${SEED:=/dev/shm/badc-seed}"
: "${RO:=0}"
: "${STACK:=}"
: "${RAID_EXTRA:=}"
: "${LUKSPASS:=badc-exercise}"

KAT_SIZES="1 7 511 4095 4096 65536 131071 1048576 8388608"
start=$(date +%s)
deadline=0
loop=""; loop2=""; mapper=""; md=""
rc_mkfs=""; rc_mount=""; rc_fsck=""; bad=0; failed=""

say() { echo "$*"; }
# A deep tree of small files to copy around: the first directory the image
# has with substance in it, since a kernel built without modules leaves the
# module tree nearly empty.
srcdir() {
	for d in "/usr/lib/modules/$(uname -r)/kernel" /usr/share/doc \
		/usr/lib/python3 /usr/include /etc; do
		[ -d "$d" ] || continue
		n=$(find "$d" -type f 2>/dev/null | head -300 | wc -l)
		[ "$n" -ge 200 ] && { echo "$d"; return; }
	done
	echo /etc
}
elapsed() { echo $(( $(date +%s) - start )); }
# Headroom for the workload. A filesystem the jobs drive to ENOSPC can end
# the instance unmountable -- ntfs3 cannot extend $MFT once full -- and that
# says nothing about the kernel under test.
room() {
	[ "$(df -P "$MNT" | tail -1 | awk '{print $5+0}')" -lt 80 ]
}
has() { case " $FEATS " in *" $1 "*) return 0;; esac; return 1; }
fail() { failed="$1"; }

cleanup() {
	umount "$MNT" 2>/dev/null || umount -l "$MNT" 2>/dev/null
	[ -n "$md" ] && mdadm --stop "$md" > /dev/null 2>&1
	[ -n "$mapper" ] && cryptsetup close "badc-$LABEL" > /dev/null 2>&1
	for d in $DEV $RAID_EXTRA; do
		mdadm --zero-superblock "$d" > /dev/null 2>&1
	done
	[ -n "$loop2" ] && losetup -d "$loop2" 2>/dev/null
	rm -f "$IMG.2"
	[ -n "$loop" ] && losetup -d "$loop" 2>/dev/null
	[ -z "$DEV" ] && rm -f "$IMG"
	# rmdir, not rm -rf: an unmount that did not take must not turn the
	# cleanup into a delete of the filesystem's contents.
	rmdir "$MNT" 2>/dev/null
	rm -rf /dev/shm/badc-sums-$LABEL* /var/tmp/badc-stage-$LABEL 2>/dev/null
}
trap cleanup EXIT INT TERM

# Digest list for a file set, computed from the seed: `sha256sum -c` format
# with the paths the files will have once written.
kat_sums() {
	dir=$1; out=$2
	: > "$out"
	for n in $KAT_SIZES; do
		s=$(head -c "$n" "$SEED" | sha256sum | cut -d' ' -f1)
		echo "$s  $dir/f$n" >> "$out"
	done
}

kat_write() {
	dir=$1
	mkdir -p "$dir" || return 1
	for n in $KAT_SIZES; do
		head -c "$n" "$SEED" > "$dir/f$n" || return 1
	done
	sync -f "$dir" 2>/dev/null || sync
	return 0
}

kat_check() {
	sums=$1; tag=$2
	out=$(sha256sum -c "$sums" 2>&1)
	n=$(echo "$out" | grep -c ': FAILED' || true)
	m=$(echo "$out" | grep -c ': OK' || true)
	say "$tag=ok:$m,bad:$n"
	if [ "$n" -gt 0 ]; then
		bad=$(( bad + n ))
		echo "$out" | grep ': FAILED' | head -8 | sed "s/^/${tag}_failed=/"
	fi
}

# --- workload jobs ---------------------------------------------------------

job_stream() {
	i=0
	while [ "$(date +%s)" -lt "$deadline" ]; do
		room || { rm -f "$MNT/stress/stream.$1."* 2>/dev/null; continue; }
		for bs in 4k 64k 1M; do
			dd if="$SEED" of="$MNT/stress/stream.$1.$i" bs=$bs \
			   conv=fsync 2>/dev/null || true
			i=$(( i + 1 ))
		done
		rm -f "$MNT/stress/stream.$1."* 2>/dev/null
	done
}

job_smallfiles() {
	d="$MNT/stress/small.$1"
	while [ "$(date +%s)" -lt "$deadline" ]; do
		room || { rm -rf "$d"; continue; }
		mkdir -p "$d" || return
		i=0
		while [ $i -lt 400 ]; do
			head -c $(( (i % 17) * 293 + 1 )) "$SEED" > "$d/f$i" || break
			i=$(( i + 1 ))
		done
		sync -f "$d" 2>/dev/null || sync
		i=0
		while [ $i -lt 400 ]; do
			mv "$d/f$i" "$d/r$i" 2>/dev/null
			has links && ln "$d/r$i" "$d/l$i" 2>/dev/null
			has perms && chmod 0640 "$d/r$i" 2>/dev/null
			i=$(( i + 1 ))
		done
		find "$d" -type f -size -2k -newer "$SEED" > /dev/null 2>&1
		rm -rf "$d"
	done
}

job_tree() {
	src=$(srcdir)
	d="$MNT/stress/tree.$1"
	while [ "$(date +%s)" -lt "$deadline" ]; do
		room || { rm -rf "$d"; continue; }
		mkdir -p "$d" || return
		cp -a "$src" "$d/" 2>/dev/null || true
		sync -f "$d" 2>/dev/null || sync
		find "$d" -type f | head -400 | xargs -r grep -lc . > /dev/null 2>&1
		rm -rf "$d"
	done
}

job_sparse() {
	f="$MNT/stress/sparse.$1"
	while [ "$(date +%s)" -lt "$deadline" ]; do
		room || { rm -f "$f"; continue; }
		if has sparse; then
			dd if="$SEED" of="$f" bs=4k count=1 seek=200000 \
			   conv=fsync,notrunc 2>/dev/null || true
			dd if="$SEED" of="$f" bs=4k count=16 seek=7 \
			   conv=fsync,notrunc 2>/dev/null || true
		else
			dd if="$SEED" of="$f" bs=4k count=2048 conv=fsync \
			   2>/dev/null || true
		fi
		has odirect && dd if="$f" of=/dev/null bs=4k iflag=direct \
			2>/dev/null || true
		rm -f "$f"
	done
}

job_tool() {
	if command -v fsstress > /dev/null 2>&1; then
		mkdir -p "$MNT/stress/fsstress"
		timeout "$SECS" fsstress -d "$MNT/stress/fsstress" -n 4000 -p 2 \
			-l 0 > /dev/null 2>&1 || true
	elif command -v fio > /dev/null 2>&1; then
		timeout "$SECS" fio --name=badc --directory="$MNT/stress" \
			--rw=randrw --bs=4k --size=64M --numjobs=2 \
			--ioengine=psync --fsync=16 --group_reporting \
			> /dev/null 2>&1 || true
	fi
}

# --- instance --------------------------------------------------------------

mkdir -p "$MNT"
say "label=$LABEL"

if [ "$RO" = 1 ]; then
	# Read-only image formats: the filesystem is built from a staging tree,
	# so the digests are checked against what the image reader returns.
	stage=/var/tmp/badc-stage-$LABEL
	rm -rf "$stage"; mkdir -p "$stage"
	kat_write "$stage/kat" || { say "status=fail"; say "reason=stage-write"; exit 1; }
	cp -a "$(srcdir)" "$stage/tree" 2>/dev/null || true
	rm -f "$IMG"
	out=$(eval "$MKFS" 2>&1); rc_mkfs=$?
	say "mkfs_rc=$rc_mkfs"
	rm -rf "$stage"
	if [ "$rc_mkfs" -ge 128 ]; then
		echo "$out" | tail -3 | sed 's/^/mkfs_out=/'
		say "status=fail"; say "reason=mkfs-signal-$rc_mkfs"; exit 1
	elif [ "$rc_mkfs" != 0 ]; then
		echo "$out" | tail -3 | sed 's/^/mkfs_out=/'
		say "status=skip"; say "reason=mkfs"; exit 0
	fi
	loop=$(losetup --show -r -f "$IMG" 2>/dev/null) || loop=""
	[ -n "$loop" ] || { say "status=fail"; say "reason=losetup"; exit 1; }
	say "loop=$loop"
	out=$(mount -t "$MTYPE" -o "ro${MOPTS:+,$MOPTS}" "$loop" "$MNT" 2>&1)
	rc_mount=$?
	say "mount_rc=$rc_mount"
	if [ "$rc_mount" != 0 ]; then
		echo "$out" | tail -3 | sed 's/^/mount_out=/'
		dmesg | tail -60 | grep -iE "$MTYPE|BUG:|Oops|RIP:" |
			head -8 | sed 's/^/mount_dmesg=/'
		say "status=fail"; say "reason=mount"; exit 1
	fi
	kat_sums "$MNT/kat" /dev/shm/badc-sums-$LABEL
	echo 3 > /proc/sys/vm/drop_caches
	kat_check /dev/shm/badc-sums-$LABEL kat
	say "seconds=$(elapsed)"
	[ "$bad" = 0 ] && say "status=pass" || say "status=fail"
	[ "$bad" = 0 ] || say "reason=digest-mismatch"
	exit 0
fi

if [ -n "$DEV" ]; then
	target=$DEV
	say "backing=$DEV"
else
	rm -f "$IMG"
	truncate -s "$SIZE" "$IMG" || { say "status=fail"; say "reason=truncate"; exit 1; }
	loop=$(losetup --show -b "$LBLK" -f "$IMG" 2>/dev/null) || loop=""
	if [ -z "$loop" ]; then
		loop=$(losetup --show -f "$IMG" 2>/dev/null) || loop=""
		LBLK=default
	fi
	[ -n "$loop" ] || { say "status=fail"; say "reason=losetup"; exit 1; }
	target=$loop
	say "backing=$loop"
fi
say "logical_block=$LBLK"

for d in $DEV $RAID_EXTRA; do
	wipefs -a "$d" > /dev/null 2>&1
	mdadm --zero-superblock "$d" > /dev/null 2>&1
done

case "$STACK" in
luks:*)
	cipher=${STACK#luks:}
	say "cipher=$cipher"
	printf '%s' "$LUKSPASS" | cryptsetup luksFormat --type luks2 \
		-c "$cipher" -q --key-file=- "$target" > /dev/null 2>&1
	rc=$?
	say "luks_format_rc=$rc"
	if [ "$rc" -ge 128 ]; then
		say "status=fail"; say "reason=cryptsetup-signal-$rc"; exit 1
	elif [ "$rc" != 0 ]; then
		say "status=skip"; say "reason=luksFormat-$cipher"; exit 0
	fi
	printf '%s' "$LUKSPASS" | cryptsetup open --key-file=- "$target" \
		"badc-$LABEL" > /dev/null 2>&1
	rc=$?
	say "luks_open_rc=$rc"
	[ "$rc" = 0 ] || { say "status=fail"; say "reason=luks-open"; exit 1; }
	mapper=/dev/mapper/badc-$LABEL
	target=$mapper
	;;
raid1*)
	if [ -n "$RAID_EXTRA" ]; then
		second=$RAID_EXTRA
	else
		rm -f "$IMG.2"
		truncate -s "$SIZE" "$IMG.2" || {
			say "status=fail"; say "reason=truncate2"; exit 1; }
		loop2=$(losetup --show -b "$LBLK" -f "$IMG.2" 2>/dev/null) ||
			loop2=$(losetup --show -f "$IMG.2" 2>/dev/null)
		second=$loop2
	fi
	[ -n "$second" ] || { say "status=fail"; say "reason=raid-member"; exit 1; }
	say "raid_members=$target,$second"
	md=/dev/md/badc-$LABEL
	# --size bounds the array, and with it the initial resync, to the
	# instance size rather than the whole spare disk.
	echo y | mdadm --create "$md" --level=1 --raid-devices=2 \
		--metadata=1.2 --size="$SIZE" --run "$target" "$second" \
		> /dev/null 2>&1
	rc=$?
	say "mdadm_rc=$rc"
	if [ "$rc" -ge 128 ]; then
		say "status=fail"; say "reason=mdadm-signal-$rc"; exit 1
	elif [ "$rc" != 0 ]; then
		say "status=skip"; say "reason=mdadm-create"; exit 0
	fi
	target=$md
	;;
esac

out=$(eval "$MKFS \"$target\"" 2>&1); rc_mkfs=$?
say "mkfs_rc=$rc_mkfs"
if [ "$rc_mkfs" -ge 128 ]; then
	echo "$out" | tail -3 | sed 's/^/mkfs_out=/'
	say "status=fail"; say "reason=mkfs-signal-$rc_mkfs"; exit 1
elif [ "$rc_mkfs" != 0 ]; then
	echo "$out" | tail -3 | sed 's/^/mkfs_out=/'
	say "status=skip"; say "reason=mkfs"; exit 0
fi

out=$(mount -t "$MTYPE" ${MOPTS:+-o "$MOPTS"} "$target" "$MNT" 2>&1)
rc_mount=$?
say "mount_rc=$rc_mount"
if [ "$rc_mount" != 0 ]; then
	echo "$out" | tail -3 | sed 's/^/mount_out=/'
	dmesg | tail -60 | grep -iE "$MTYPE|BUG:|Oops|RIP:" | head -8 |
		sed 's/^/mount_dmesg=/'
	say "status=fail"; say "reason=mount"; exit 1
fi

mkdir -p "$MNT/stress"
kat_sums "$MNT/kat" /dev/shm/badc-sums-$LABEL
kat_write "$MNT/kat" || { say "status=fail"; say "reason=kat-write"; exit 1; }

deadline=$(( $(date +%s) + SECS ))
i=1
while [ $i -le "$JOBS" ]; do
	job_stream $i & job_smallfiles $i & job_tree $i & job_sparse $i &
	i=$(( i + 1 ))
done
job_tool &
wait
say "workload_seconds=$(elapsed)"

df -P "$MNT" | tail -1 | awk '{print "stress_kb=" $3}'
rm -rf "$MNT/stress"
kat_sums "$MNT/kat2" /dev/shm/badc-sums-$LABEL-2
kat_write "$MNT/kat2" || say "kat2_write=failed"

sync -f "$MNT" 2>/dev/null || sync
echo 3 > /proc/sys/vm/drop_caches
umount "$MNT" || { say "status=fail"; say "reason=umount"; exit 1; }
out=$(mount -t "$MTYPE" ${MOPTS:+-o "$MOPTS"} "$target" "$MNT" 2>&1) || {
	echo "$out" | tail -3 | sed 's/^/remount_out=/'
	dmesg | tail -60 | grep -iE "$MTYPE|BUG:|Oops|RIP:" | head -8 |
		sed 's/^/remount_dmesg=/'
	say "status=fail"; say "reason=remount"; exit 1; }
echo 3 > /proc/sys/vm/drop_caches

kat_check /dev/shm/badc-sums-$LABEL kat
[ -d "$MNT/kat2" ] && kat_check /dev/shm/badc-sums-$LABEL-2 kat2

df -P "$MNT" | tail -1 | awk '{print "used_kb=" $3}'
umount "$MNT" || { say "status=fail"; say "reason=umount2"; exit 1; }

if [ -n "$FSCK" ]; then
	out=$(eval "$FSCK \"$target\"" 2>&1)
	rc_fsck=$?
	say "fsck_rc=$rc_fsck"
	if [ "$rc_fsck" != 0 ]; then
		echo "$out" | tail -6 | sed 's/^/fsck_out=/'
		fail fsck
	fi
	echo "$out" | grep -iE 'csum|checksum|crc' | head -4 | \
		sed 's/^/fsck_csum=/'
else
	say "fsck_rc=skipped"
fi

say "seconds=$(elapsed)"
if [ "$bad" != 0 ]; then
	say "status=fail"; say "reason=digest-mismatch"
elif [ -n "$failed" ]; then
	say "status=fail"; say "reason=$failed"
else
	say "status=pass"
fi
