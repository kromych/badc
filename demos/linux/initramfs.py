#!/usr/bin/env python3
"""Build the marker initramfs verify.py boots.

The image holds one file, ``/init``: it prints the marker verify.py greps for
and then asks the machine to go away, so a boot ends when the kernel reaches
userspace rather than when the boot timeout expires. A reset request is what
ends it -- qemu's ``-no-reboot`` turns that into an exit, and unlike power-off
it is wired on every machine tested (``-M virt`` halts on power-off instead of
stopping the emulator). Power-off follows as a fallback; neither returns on a
platform that implements it.

The payload is built with the reference compiler, not badc: it is the probe
that says the kernel reached userspace, and keeping it out of the compiler
under test keeps a boot failure attributable to the kernel.

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

INIT_C = r"""
#include <stdio.h>
#include <unistd.h>
#include <sys/reboot.h>

int main(void)
{
    int i;
    for (i = 1; i <= 5; i++)
        printf("BADC-VMLINUX-OK %d/5\n", i);
    fflush(stdout);
    sync();
    reboot(RB_AUTOBOOT);
    reboot(RB_POWER_OFF);
    for (;;)
        pause();
}
"""


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
        image = cpio_newc([("init", 0o100755, exe.read_bytes())])

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(gzip.compress(image, 9))
    print(f"linux initramfs: wrote {args.output} "
          f"({args.output.stat().st_size} bytes)", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
