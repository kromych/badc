#!/usr/bin/env python3
"""Build the initramfs verify.py boots.

The image holds one file, ``/init``, plus the mount points it needs. It does
two things:

* Prints the boot marker, which says the kernel reached userspace, and then
  asks the machine to go away, so a boot ends there rather than at the boot
  timeout. A reset request is what ends it -- qemu's ``-no-reboot`` turns that
  into an exit, and unlike power-off it is wired on every machine tested
  (``-M virt`` halts on power-off instead of stopping the emulator). Power-off
  follows as a fallback; neither returns on a platform that implements it.

* Exercises the kernel it just booted, and reports that under a second marker.
  Reaching userspace only proves the boot path; a defect that leaves ``read()``
  on a procfs file spinning forever passes a marker-only boot. The checks read
  a fixed set of ``/proc`` and ``/sys`` files and assert their contents, in
  small requests so a file spans several ``read()`` calls, and once more from a
  non-zero offset. Each file is named on the console before it is opened, so a
  boot that stops reports which file it stopped on.

The two markers are separate on purpose: a boot that prints the first and not
the second reached userspace and failed the checks, which is a different defect
from one that never got there.

The payload is built with the reference compiler, not badc: it is the probe
that says what the kernel did, and keeping it out of the compiler under test
keeps a failure attributable to the kernel.

    python3 demos/linux/initramfs.py -o initramfs.cpio.gz

The archive is written directly (newc, gzip) so no cpio binary is needed.
"""

from __future__ import annotations

import argparse
import gzip
import io
import subprocess
import sys
import tempfile
from pathlib import Path

BOOT_MARKER = "BADC-VMLINUX-OK"
CHECK_MARKER = "BADC-SELFTEST-OK"
CHECK_FAIL = "BADC-SELFTEST-FAIL"
# Distinct from CHECK_MARKER: a per-file progress line must not read as the
# success marker to anything grepping the console.
CHECK_STEP = "BADC-SELFTEST-STEP"

INIT_C = r"""
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <sys/stat.h>
#include <unistd.h>

#define BOOT_MARKER  "%(boot)s"
#define CHECK_MARKER "%(ok)s"
#define CHECK_FAIL   "%(fail)s"
#define CHECK_STEP   "%(step)s"

/* Small enough that every file takes several read() calls, so a partial
   record has to survive between them. */
#define CHUNK 64
#define CAP   65536

struct probe {
    const char *path;
    const char *want;   /* substring the contents must hold; "" = non-empty */
};

/* Files present at defconfig on every architecture the gate covers. The
   procfs entries are seq_file readers, single-record and multi-record; the
   sysfs entries are kernfs, which is a separate path. */
static const struct probe PROBES[] = {
    { "/proc/cmdline",                    "console=" },
    { "/proc/version",                    "Linux version" },
    { "/proc/meminfo",                    "MemTotal" },
    { "/proc/mounts",                     "proc" },
    { "/proc/stat",                       "cpu" },
    { "/proc/uptime",                     "" },
    { "/proc/interrupts",                 "CPU0" },
    { "/proc/self/stat",                  "" },
    { "/proc/self/maps",                  "" },
    { "/proc/self/status",                "Name:" },
    { "/proc/filesystems",                "proc" },
    { "/sys/devices/system/cpu/online",   "0" },
    { "/sys/devices/system/cpu/possible", "0" },
    { "/sys/kernel/uevent_seqnum",        "" },
};

static char buf[CAP];

static void fail(const char *path, const char *why)
{
    printf("%%s %%s: %%s\n", CHECK_FAIL, path, why);
    fflush(stdout);
}

/* Read the whole file in CHUNK-sized requests. Returns the byte count, or -1
   with the reason reported. Filling the buffer counts as a failure: every
   file read here is far smaller than CAP, so reaching it means the reader
   never reported the end. */
static long slurp(const char *path, long from)
{
    long n = 0;
    ssize_t r = 0;
    int fd = open(path, O_RDONLY);

    if (fd < 0) {
        fail(path, "open failed");
        return -1;
    }
    if (from && lseek(fd, from, SEEK_SET) < 0) {
        fail(path, "lseek failed");
        close(fd);
        return -1;
    }
    while (n < CAP - 1) {
        long want = CAP - 1 - n;

        if (want > CHUNK)
            want = CHUNK;
        r = read(fd, buf + n, (size_t)want);
        if (r <= 0)
            break;
        n += r;
    }
    close(fd);
    if (r < 0) {
        fail(path, "read failed");
        return -1;
    }
    if (n >= CAP - 1) {
        fail(path, "never reached end of file");
        return -1;
    }
    buf[n] = '\0';
    return n;
}

static int check(const struct probe *p)
{
    long n;

    /* Named before the open, so a read that never returns leaves the file it
       stopped on as the last line on the console. */
    printf("%%s reading %%s\n", CHECK_STEP, p->path);
    fflush(stdout);

    n = slurp(p->path, 0);
    if (n < 0)
        return 0;
    if (n == 0) {
        fail(p->path, "empty");
        return 0;
    }
    if (p->want[0] && !strstr(buf, p->want)) {
        fail(p->path, "contents did not match");
        return 0;
    }
    /* Once more from a non-zero offset: seq_file reaches one by replaying
       records rather than by continuing, which a sequential read never does. */
    if (n > 1 && slurp(p->path, 1) < 0)
        return 0;
    return 1;
}

int main(void)
{
    unsigned i;
    int ok = 1;

    mkdir("/proc", 0755);
    mkdir("/sys", 0755);
    if (mount("proc", "/proc", "proc", 0, NULL) < 0) {
        fail("/proc", "mount failed");
        ok = 0;
    }
    if (mount("sysfs", "/sys", "sysfs", 0, NULL) < 0) {
        fail("/sys", "mount failed");
        ok = 0;
    }

    for (i = 1; i <= 5; i++)
        printf("%%s %%u/5\n", BOOT_MARKER, i);
    fflush(stdout);

    if (ok)
        for (i = 0; i < sizeof PROBES / sizeof PROBES[0]; i++)
            ok &= check(&PROBES[i]);

    if (ok)
        for (i = 1; i <= 5; i++)
            printf("%%s %%u/5\n", CHECK_MARKER, i);
    else
        printf("%%s: one or more checks failed\n", CHECK_FAIL);
    fflush(stdout);

    sync();
    reboot(RB_AUTOBOOT);
    reboot(RB_POWER_OFF);
    for (;;)
        pause();
}
""" % {"boot": BOOT_MARKER, "ok": CHECK_MARKER, "fail": CHECK_FAIL,
       "step": CHECK_STEP}


def cpio_newc(entries: list[tuple[str, int, bytes]]) -> bytes:
    """Serialize (name, mode, data) as a newc cpio archive."""
    buf = io.BytesIO()

    def put(name: str, mode: int, data: bytes, ino: int, nlink: int) -> None:
        raw = name.encode() + b"\0"
        fields = [ino, mode, 0, 0, nlink, 0, len(data), 0, 0, 0, 0, len(raw), 0]
        buf.write(b"070701" + b"".join(b"%08X" % f for f in fields))
        buf.write(raw)
        buf.write(b"\0" * (-(110 + len(raw)) % 4))
        buf.write(data)
        buf.write(b"\0" * (-len(data) % 4))

    for i, (name, mode, data) in enumerate(entries, start=1):
        put(name, mode, data, i, 1)
    put("TRAILER!!!", 0, b"", 0, 1)
    return buf.getvalue()


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("-o", "--output", type=Path, required=True)
    ap.add_argument("--cc", default="gcc", help="compiler for /init (default: gcc)")
    args = ap.parse_args()

    with tempfile.TemporaryDirectory() as td:
        src = Path(td) / "init.c"
        exe = Path(td) / "init"
        src.write_text(INIT_C)
        cmd = [args.cc, "-static", "-O2", "-o", str(exe), str(src)]
        r = subprocess.run(cmd, capture_output=True, text=True)
        if r.returncode != 0:
            sys.exit(f"linux initramfs: {' '.join(cmd)} failed:\n{r.stderr.strip()}")
        image = cpio_newc([
            ("proc", 0o040755, b""),
            ("sys", 0o040755, b""),
            ("init", 0o100755, exe.read_bytes()),
        ])

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(gzip.compress(image, 9))
    print(f"linux initramfs: wrote {args.output} "
          f"({args.output.stat().st_size} bytes)", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
