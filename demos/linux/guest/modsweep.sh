#!/bin/sh
# Module load sweep for the running kernel (guest side): every module in the
# kernel's own tree, one at a time, classified. Absent hardware is expected; a
# fault, a hang, a missing symbol or a crash taint bit is a finding. Modules
# loaded before the sweep are never unloaded, so it cannot take the network or
# the root disk down; the rest are pruned periodically, which bounds memory and
# exercises the module exit paths. Output is key=value lines on stdout.

: "${RELEASE:=$(uname -r)}"
: "${LIMIT:=0}"
: "${PERMOD:=20}"
: "${PRUNE:=250}"
: "${SKIP_RE:=(torture|lkdtm|test_lockup|_kunit|kunit_)}"

dir=/lib/modules/$RELEASE/kernel
base=/dev/shm/badc-modbase
lsmod | awk 'NR>1 {print $1}' | sort > "$base"

all=/dev/shm/badc-modall
find "$dir" -name '*.ko' -o -name '*.ko.*' 2>/dev/null |
	sed 's|.*/||; s|\.ko.*$||; s|-|_|g' | sort -u |
	grep -Ev "$SKIP_RE" > "$all"
total=$(wc -l < "$all")

want=$all
if [ "$LIMIT" -gt 0 ] && [ "$total" -gt "$LIMIT" ]; then
	# An even stride over the sorted list, so every subsystem prefix is
	# represented rather than the first N directories.
	awk -v n="$total" -v k="$LIMIT" 'int(NR*k/n) > int((NR-1)*k/n)' \
		"$all" > /dev/shm/badc-modwant
	want=/dev/shm/badc-modwant
fi

prune() {
	i=0
	while [ $i -lt 3 ]; do
		lsmod | awk 'NR>1 && $3=="0" {print $1}' | while read -r m; do
			grep -qx "$m" "$base" || rmmod "$m" 2>/dev/null
		done
		i=$(( i + 1 ))
	done
}

read -r taint0 < /proc/sys/kernel/tainted
# Bits 4 (machine check) and 7 (oops/die): a module load that sets either
# crashed the kernel, whatever exit status modprobe reported.
prev_crash=$(( taint0 & 144 ))
attempted=0; loaded=0; refused=0; hard=0; since_prune=0
start=$(date +%s)

while read -r m; do
	attempted=$(( attempted + 1 ))
	err=$(timeout "$PERMOD" modprobe -- "$m" 2>&1)
	rc=$?
	read -r taint < /proc/sys/kernel/tainted
	crash=$(( taint & 144 ))
	if [ "$rc" = 0 ] && [ "$crash" = "$prev_crash" ]; then
		loaded=$(( loaded + 1 ))
	elif [ "$crash" != "$prev_crash" ]; then
		hard=$(( hard + 1 ))
		echo "hard_mod=$m rc=$rc taint=$taint msg=$(echo "$err" | tr '\n' ' ')"
		prev_crash=$crash
	elif [ "$rc" = 124 ]; then
		hard=$(( hard + 1 ))
		echo "hard_mod=$m rc=124 msg=load did not finish in ${PERMOD}s"
	else
		reason=$(echo "$err" | sed 's/.*: //' | tr -d '\n')
		case "$reason" in
		"No such device"|"No such device or address"|\
		"Operation not supported"|"Function not implemented"|\
		"No such file or directory"|"Invalid argument"|\
		"Device or resource busy"|"Inappropriate ioctl for device"|\
		"No such process"|"Package not installed"|"Protocol not supported"|\
		"Cannot allocate memory")
			refused=$(( refused + 1 ))
			echo "refused_mod=$m reason=$reason"
			;;
		*)
			hard=$(( hard + 1 ))
			echo "hard_mod=$m rc=$rc msg=$(echo "$err" | tr '\n' ' ')"
			;;
		esac
	fi
	since_prune=$(( since_prune + 1 ))
	if [ "$since_prune" -ge "$PRUNE" ]; then
		prune
		since_prune=0
	fi
done < "$want"
prune

read -r taint1 < /proc/sys/kernel/tainted
echo "built=$total"
echo "attempted=$attempted"
echo "loaded=$loaded"
echo "refused=$refused"
echo "hard=$hard"
echo "resident=$(lsmod | awk 'NR>1' | wc -l)"
echo "taint_before=$taint0"
echo "taint_after=$taint1"
echo "seconds=$(( $(date +%s) - start ))"
