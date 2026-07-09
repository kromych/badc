#!/usr/bin/env python3
"""Minimal `hexdump -C` for hosts without one (native Windows).

NASM's nasm-t.py shells out to `hexdump -C <file>` to render a byte diff when a
golden test fails; it is display-only and does not affect the pass/fail
decision. This reproduces the canonical `-C` layout so the suite runs where the
BSD/util-linux hexdump is absent.
"""
import sys


def main() -> int:
    path = sys.argv[-1]
    with open(path, "rb") as f:
        data = f.read()
    for off in range(0, len(data), 16):
        chunk = data[off:off + 16]
        hi = " ".join(f"{b:02x}" for b in chunk[:8])
        lo = " ".join(f"{b:02x}" for b in chunk[8:])
        hexpart = f"{hi:<23}  {lo:<23}"
        ascii_part = "".join(chr(b) if 32 <= b < 127 else "." for b in chunk)
        print(f"{off:08x}  {hexpart}  |{ascii_part}|")
    print(f"{len(data):08x}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
