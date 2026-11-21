#!/usr/bin/env python3
"""Build System Informer with badc at -O0 and -O and run what it builds.

    python demos/systeminformer/smoke.py [--opt=-O0|-O] [--jobs=N] [-v]

For each level ``build.py`` builds SystemInformer.exe, peview.exe and
phlib-test.exe for the host's Windows target. phlib-test, phlib's self-test,
must pass: its assert()s check the string, AVL tree, formatting and utility
routines. Its formatting checks write numbers with a `.` decimal separator
and `,` grouping, which phlib takes from the user's locale; under a locale
with another decimal separator the first of them fails whatever compiler
built it, and the smoke then requires exactly that failure, which the string
and tree checks before it have passed. SystemInformer.exe (without its
settings file, driver or plugins) and peview.exe (on a system DLL) must each
still run after 10 s, when the smoke stops them.

Windows only: the build runs the SDK's and MSVC's tools. Elsewhere the smoke
reports that and exits 0.
"""

from __future__ import annotations

import argparse
import os
import platform
import subprocess
import sys
import time
from pathlib import Path

DEMO = Path(__file__).resolve().parent
sys.path.insert(0, str(DEMO))
import build  # noqa: E402
import setup  # noqa: E402

FIRST_DOUBLE_CHECK = 'wcscmp(buffer, L"0.000000")'


def user_separators() -> tuple[str, str]:
    """The user locale's decimal and grouping separators, as phlib reads them."""
    import ctypes

    def info(kind: int) -> str:
        buf = ctypes.create_unicode_buffer(8)
        # LOCALE_USER_DEFAULT
        ctypes.windll.kernel32.GetLocaleInfoW(0x400, kind, buf, len(buf))
        return buf.value

    return info(0x0E), info(0x0F)  # LOCALE_SDECIMAL, LOCALE_STHOUSAND


def phlib_test(exe: Path) -> str | None:
    """None when phlib-test's result is the one this locale allows, else why not."""
    r = subprocess.run([str(exe)], capture_output=True, text=True, errors="replace", timeout=120)
    text = (r.stdout + r.stderr).strip()
    decimal, group = user_separators()
    if (decimal, group) == (".", ","):
        return None if r.returncode == 0 else f"exit {r.returncode & 0xFFFFFFFF:#x}: {text[:300]}"
    if r.returncode != 0 and FIRST_DOUBLE_CHECK in text:
        print(f"  phlib-test: the formatting checks assume `.` and `,`; this locale uses "
              f"`{decimal}` and `{group}`, so it stops at the first of them", file=sys.stderr)
        return None
    return f"exit {r.returncode & 0xFFFFFFFF:#x} under separators `{decimal}` `{group}`: {text[:300]}"


def stays_up(exe: Path, args: list[str], seconds: int = 10) -> str | None:
    """None when `exe` still runs after `seconds`, else how it ended."""
    p = subprocess.Popen([str(exe), *args], cwd=exe.parent)
    try:
        code = p.wait(timeout=seconds)
        return f"exited {code & 0xFFFFFFFF:#x} within {seconds} s"
    except subprocess.TimeoutExpired:
        p.kill()
        p.wait()
        return None


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--opt", choices=["-O0", "-O"], action="append")
    parser.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)
    if os.name != "nt":
        print("systeminformer: skipped -- the build runs on a Windows host", file=sys.stderr)
        return 0
    if setup.main(["-v"] if args.verbose else []) != 0:
        return 1
    failures = []
    for opt in args.opt or ["-O0", "-O"]:
        t0 = time.time()
        rc = build.main([f"--opt={opt}", f"--jobs={args.jobs}"] + (["-v"] if args.verbose else []))
        if rc != 0:
            failures.append(f"{opt}: build failed")
            continue
        host = "arm64" if platform.machine().upper() == "ARM64" else "x64"
        bin_dir = DEMO / ".cache" / f"build-{host}{'' if opt == '-O' else opt}" / "bin"
        checks = [
            ("phlib-test", phlib_test(bin_dir / "phlib-test.exe")),
            ("SystemInformer", stays_up(bin_dir / "SystemInformer.exe",
                                        ["-nosettings", "-nokph", "-noplugins", "-newinstance"])),
            ("peview", stays_up(bin_dir / "peview.exe",
                                [str(Path(os.environ.get("SystemRoot", r"C:\Windows"))
                                     / "System32" / "kernel32.dll")])),
        ]
        for name, why in checks:
            if why:
                failures.append(f"{opt}: {name}: {why}")
        print(f"systeminformer {opt}: {'FAIL' if any(f.startswith(opt + ':') for f in failures) else 'OK'}"
              f" ({time.time() - t0:.0f} s)")
    for f in failures:
        print(f"  {f}", file=sys.stderr)
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
