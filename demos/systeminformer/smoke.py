#!/usr/bin/env python3
"""Build System Informer with badc at -O0 and -O and run what it builds.

    python demos/systeminformer/smoke.py [--opt=-O0|-O] [--jobs=N] [-v]

For each level ``build.py`` builds SystemInformer.exe, peview.exe and
phlib-test.exe for the host's Windows target, and the kernel driver where the
WDK's kernel-mode kit for it is installed. phlib-test, phlib's self-test,
must pass: its assert()s check the string, AVL tree, formatting and utility
routines. Its formatting checks write numbers with a `.` decimal separator
and `,` grouping, which phlib takes from the user's locale; under a locale
with another decimal separator the first of them fails whatever compiler
built it, and the smoke then requires exactly that failure, which the string
and tree checks before it have passed. SystemInformer.exe (without its
settings file, driver or plugins) and peview.exe (on a system DLL) must each
still run after 10 s, when the smoke stops them. The driver loads only under
test signing, so its images are checked as the loader reads them: the
target's machine, the native subsystem, an entry, the kernel modules it
imports from, a load-config directory, and ksi.dll's exports. Where no kit
is installed the summary says the driver was not built, and why.

Windows only: the build runs the SDK's and MSVC's tools. Elsewhere the smoke
reports that and exits 0.
"""

from __future__ import annotations

import argparse
import os
import platform
import struct
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


MACHINE = {"x64": 0x8664, "arm64": 0xAA64}
DRIVER_IMPORTS = {"ntoskrnl.exe", "hal.dll", "fltmgr.sys", "ksecdd.sys", "ksi.dll"}


def pe_facts(image: bytes) -> dict:
    """The header fields, the imported module names and the exported names of
    a PE32+ image."""
    pe = struct.unpack_from("<I", image, 0x3C)[0]
    machine, nsec = struct.unpack_from("<HH", image, pe + 4)
    characteristics = struct.unpack_from("<H", image, pe + 22)[0]
    opt = pe + 24
    entry = struct.unpack_from("<I", image, opt + 16)[0]
    subsystem = struct.unpack_from("<H", image, opt + 68)[0]
    dirs = [struct.unpack_from("<II", image, opt + 112 + 8 * i) for i in range(16)]
    table = opt + struct.unpack_from("<H", image, pe + 20)[0]
    sections = [struct.unpack_from("<IIII", image, table + 40 * i + 8) for i in range(nsec)]

    def at(rva: int) -> int:
        for size, va, raw_size, raw in sections:
            if va <= rva < va + max(size, raw_size):
                return raw + rva - va
        raise ValueError(f"RVA {rva:#x} in no section")

    def name(rva: int) -> str:
        o = at(rva)
        return image[o:image.index(b"\0", o)].decode()

    imports, d = set(), at(dirs[1][0]) if dirs[1][0] else None
    while d is not None and struct.unpack_from("<I", image, d + 12)[0]:
        imports.add(name(struct.unpack_from("<I", image, d + 12)[0]).lower())
        d += 20
    exports = set()
    if dirs[0][0]:
        e = at(dirs[0][0])
        count, names = struct.unpack_from("<II", image, e + 24)[0], struct.unpack_from("<I", image, e + 32)[0]
        exports = {name(struct.unpack_from("<I", image, at(names) + 4 * i)[0]) for i in range(count)}
    return {"machine": machine, "dll": bool(characteristics & 0x2000), "entry": entry,
            "subsystem": subsystem, "load_config": dirs[10][1], "imports": imports,
            "exports": exports}


def driver_checks(driver: Path, arch: str) -> str | None:
    """None when the driver images are what the kernel's loader takes, else
    what is not."""
    sys_facts = pe_facts((driver / "KSystemInformer.sys").read_bytes())
    ksi = pe_facts((driver / "ksi.dll").read_bytes())
    wrong = []
    for name, f in (("KSystemInformer.sys", sys_facts), ("ksi.dll", ksi)):
        if f["machine"] != MACHINE[arch] or f["subsystem"] != 1 or not f["entry"]:
            wrong.append(f"{name}: machine {f['machine']:#x}, subsystem {f['subsystem']}, "
                         f"entry {f['entry']:#x}")
    if not DRIVER_IMPORTS <= sys_facts["imports"]:
        wrong.append(f"KSystemInformer.sys imports {sorted(sys_facts['imports'])}")
    if not sys_facts["load_config"]:
        wrong.append("KSystemInformer.sys has no load-config directory")
    if not ksi["dll"] or "KsiInitialize" not in ksi["exports"]:
        wrong.append(f"ksi.dll exports {sorted(ksi['exports'])[:5]}")
    return "; ".join(wrong) or None


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
    failures, notes = [], []
    host = "arm64" if platform.machine().upper() == "ARM64" else "x64"

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    for opt in args.opt or ["-O0", "-O"]:
        t0 = time.time()
        try:
            b = build.Build(f"windows-{host}", opt, args.jobs, log)
            b.go()
        except build.Error as e:
            failures.append(f"{opt}: build failed: {e}")
            continue
        bin_dir = b.bin
        checks = [
            ("phlib-test", phlib_test(bin_dir / "phlib-test.exe")),
            ("SystemInformer", stays_up(bin_dir / "SystemInformer.exe",
                                        ["-nosettings", "-nokph", "-noplugins", "-newinstance"])),
            ("peview", stays_up(bin_dir / "peview.exe",
                                [str(Path(os.environ.get("SystemRoot", r"C:\Windows"))
                                     / "System32" / "kernel32.dll")])),
        ]
        if b.driver_skipped:
            notes.append(f"{opt}: the driver was not built: {b.driver_skipped}")
        else:
            checks.append(("driver", driver_checks(bin_dir / "driver", host)))
        for name, why in checks:
            if why:
                failures.append(f"{opt}: {name}: {why}")
        print(f"systeminformer {opt}: {'FAIL' if any(f.startswith(opt + ':') for f in failures) else 'OK'}"
              f" ({time.time() - t0:.0f} s)")
    for n in notes:
        print(f"  note: {n}", file=sys.stderr)
    for f in failures:
        print(f"  {f}", file=sys.stderr)
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
