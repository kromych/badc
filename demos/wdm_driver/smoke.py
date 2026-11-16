#!/usr/bin/env python3
"""Build the WDM driver skeleton for both Windows targets and check the
images the kernel's loader would take: the native subsystem, an entry
point, and imports from kernel-mode images alone.

By default `wdm_driver.c` is built, which declares what it uses itself.
`--wdk` builds `wdm_driver_wdk.c` instead, against the installed Windows
Driver Kit's <wdm.h> and ntoskrnl.lib; a target whose WDK is not
installed is reported and skipped. Loading a driver needs test signing,
so neither form is run. Override the badc binary via `BADC=path/to/badc`.
"""

from __future__ import annotations

import importlib.util
import os
import struct
import subprocess
import sys
from pathlib import Path

DRV_DIR = Path(__file__).resolve().parent
REPO_ROOT = DRV_DIR.parent.parent
IMAGE_SUBSYSTEM_NATIVE = 1
# The kernel-mode images a driver may import from.
KERNEL_IMAGES = {"ntoskrnl.exe", "hal.dll"}
TARGETS = ("windows-x64", "windows-arm64")


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    if env:
        return Path(env)
    exe = REPO_ROOT / "target" / "release" / ("badc.exe" if sys.platform == "win32" else "badc")
    if not exe.is_file():
        sys.exit(f"smoke: {exe} not found; build with `cargo build --release --features full`")
    return exe


def pe_facts(image: bytes) -> tuple[int, int, list[str]]:
    """(subsystem, entry RVA, imported DLL names) of a PE32+ image."""
    pe = struct.unpack_from("<I", image, 0x3C)[0]
    opt = pe + 24
    entry = struct.unpack_from("<I", image, opt + 16)[0]
    subsystem = struct.unpack_from("<H", image, opt + 68)[0]
    import_rva = struct.unpack_from("<I", image, opt + 112 + 8)[0]
    nsec = struct.unpack_from("<H", image, pe + 6)[0]
    opt_size = struct.unpack_from("<H", image, pe + 20)[0]
    sections = []
    for i in range(nsec):
        at = opt + opt_size + 40 * i
        vsize, va, rawsize, raw = struct.unpack_from("<IIII", image, at + 8)
        sections.append((va, max(vsize, rawsize), raw))

    def off(rva: int) -> int:
        for va, size, raw in sections:
            if va <= rva < va + size:
                return raw + rva - va
        raise ValueError(f"rva {rva:#x} outside the sections")

    dlls = []
    if import_rva:
        at = off(import_rva)
        while True:
            name_rva = struct.unpack_from("<I", image, at + 12)[0]
            if name_rva == 0:
                break
            name = image[off(name_rva):].split(b"\0", 1)[0].decode()
            dlls.append(name.lower())
            at += 20
    return subsystem, entry, dlls


def build(badc: Path, target: str, source: Path, flags: list[str], out: Path) -> str | None:
    out.unlink(missing_ok=True)
    cmd = [str(badc), "-O", f"--target={target}", *flags, str(source), "-o", str(out)]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0 or not out.is_file():
        return f"exit {proc.returncode}\n{proc.stderr.strip()}"
    subsystem, entry, dlls = pe_facts(out.read_bytes())
    if subsystem != IMAGE_SUBSYSTEM_NATIVE:
        return f"subsystem {subsystem}, not native"
    if entry == 0:
        return "no entry point"
    if not set(dlls) <= KERNEL_IMAGES:
        return f"imports {sorted(set(dlls) - KERNEL_IMAGES)}, which are not kernel-mode images"
    return None


def main() -> int:
    wdk = "--wdk" in sys.argv[1:]
    badc = resolve_badc()
    work = DRV_DIR / ".build"
    work.mkdir(parents=True, exist_ok=True)
    kits = None
    if wdk:
        spec = importlib.util.spec_from_file_location("_win_kits", DRV_DIR.parent / "_win_kits.py")
        kits = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(kits)
    built, failures = 0, []
    for target in TARGETS:
        if kits is None:
            source, flags, label = DRV_DIR / "wdm_driver.c", [], "self-declared"
        else:
            found = kits.wdk_flags(target, ["ntoskrnl"])
            if found is None:
                print(f"skip [{target}]: no WDK with km headers and {target} libraries")
                continue
            version, flags = found
            source, label = DRV_DIR / "wdm_driver_wdk.c", f"WDK {version}"
            flags = [*flags, "--subsystem=driver", "--entry=DriverEntry"]
        out = work / f"{source.stem}-{target}.sys"
        why = build(badc, target, source, flags, out)
        if why:
            failures.append(f"[{target}] {source.name} ({label}): {why}")
            continue
        built += 1
        dlls = pe_facts(out.read_bytes())[2]
        print(f"build OK [{target}]: {label} -> {out.name}, native, imports {dlls or 'nothing'}")
    if failures:
        print("\nsmoke FAIL:", file=sys.stderr)
        for f in failures:
            print(f"  {f}", file=sys.stderr)
        return 1
    print(f"\nwdm_driver smoke: {built} target(s) built")
    return 0


if __name__ == "__main__":
    sys.exit(main())
