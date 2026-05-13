#!/usr/bin/env python3
"""Build the nt_loader / nt_hello demos with badc.

Both PEs are produced via `badc --target=windows-{x64,arm64}` and
the script asserts each output exists and has the expected
Subsystem byte (IMAGE_SUBSYSTEM_WINDOWS_CUI for nt_loader,
IMAGE_SUBSYSTEM_NATIVE for nt_hello).

The two demos are independent: nt_loader exercises TxF + SEC_IMAGE
section creation + NtCreateProcessEx process-object creation, but
stops short of starting an initial thread. nt_hello is a NATIVE-
subsystem PE that opens / signals a named event when launched by
something with sufficient privilege. Wiring them together for an
end-to-end handshake needs either SeTcbPrivilege (so the loader
can call NtCreateUserProcess on a NATIVE image) or hand-built
PEB.Ldr + PEB.ProcessParameters; both are out of scope here.

Override the badc binary with `BADC=path/to/badc`.
"""

from __future__ import annotations

import os
import subprocess
import sys
from pathlib import Path

NT_DIR = Path(__file__).resolve().parent
REPO_ROOT = NT_DIR.parent.parent
HELLO_DIR = REPO_ROOT / "demos" / "nt_hello"

IMAGE_SUBSYSTEM_WINDOWS_CUI = 3
IMAGE_SUBSYSTEM_NATIVE = 1


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    candidates: list[Path] = []
    if env:
        candidates.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates.extend([default, default.with_suffix(".exe")])
    for cand in candidates:
        if cand.is_file() and os.access(cand, os.X_OK):
            return cand
    print(
        f"smoke: BADC binary not found / not executable\n"
        f"       hint: cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml",
        file=sys.stderr,
    )
    sys.exit(2)


def pe_subsystem(path: Path) -> int:
    """Read the Subsystem field out of a PE32+'s optional header."""
    data = path.read_bytes()
    pe_off = int.from_bytes(data[0x3C:0x40], "little")
    # OptionalHeader64.Subsystem sits 68 bytes into the optional
    # header on PE32+, which itself starts at pe_off + 4 (Signature)
    # + 20 (COFF header).
    optional_off = pe_off + 4 + 20
    sub_off = optional_off + 68
    return int.from_bytes(data[sub_off : sub_off + 2], "little")


def build_pe(badc: Path, target: str, source: Path, out: Path) -> None:
    cmd = [str(badc), f"--target={target}", str(source), "-o", str(out)]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        print(
            f"smoke: {source.name} -> {target} failed (exit {proc.returncode})\n"
            f"  stdout: {proc.stdout.strip()}\n"
            f"  stderr: {proc.stderr.strip()}",
            file=sys.stderr,
        )
        sys.exit(1)
    if not out.exists() or out.stat().st_size == 0:
        print(f"smoke: {out} not produced", file=sys.stderr)
        sys.exit(1)


def main() -> int:
    badc = resolve_badc()
    work = NT_DIR / ".build"
    work.mkdir(parents=True, exist_ok=True)

    # Build for both Windows arches so the smoke catches arch-specific
    # codegen drift even when the host can only run one of them.
    for target in ("windows-x64", "windows-arm64"):
        loader = work / f"nt_loader-{target}.exe"
        hello = work / f"nt_hello-{target}.exe"
        build_pe(badc, target, NT_DIR / "nt_loader.c", loader)
        build_pe(badc, target, HELLO_DIR / "nt_hello.c", hello)

        sub = pe_subsystem(loader)
        if sub != IMAGE_SUBSYSTEM_WINDOWS_CUI:
            print(
                f"smoke: {loader.name} Subsystem={sub} (want {IMAGE_SUBSYSTEM_WINDOWS_CUI})",
                file=sys.stderr,
            )
            return 1
        sub = pe_subsystem(hello)
        if sub != IMAGE_SUBSYSTEM_NATIVE:
            print(
                f"smoke: {hello.name} Subsystem={sub} (want {IMAGE_SUBSYSTEM_NATIVE})",
                file=sys.stderr,
            )
            return 1
        print(f"build OK [{target}]: nt_loader + nt_hello, subsystems CUI / NATIVE")

    return 0


if __name__ == "__main__":
    sys.exit(main())
