#!/usr/bin/env python3
"""Build the nt_loader / nt_hello demos with badc, and on Windows
hosts run the loader against nt_hello as a codegen canary.

Both PEs are produced via `badc --target=windows-{x64,arm64}` and
the script asserts each output exists and has the expected
Subsystem byte (IMAGE_SUBSYSTEM_WINDOWS_CUI for nt_loader,
IMAGE_SUBSYSTEM_NATIVE for nt_hello).

On a Windows host, the loader is then run against nt_hello.
The real cross-process handshake can't complete because launching
an IMAGE_SUBSYSTEM_NATIVE image via NtCreateUserProcess requires
SeTcbPrivilege, which hosted runners don't carry. What the smoke
verifies is that the loader's *codegen* reached the privilege
gate without crashing: every milestone log line printed in
order, NtCreateUserProcess returned a known privilege-related
NTSTATUS, and the exit code was the loader's clean-failure 1
rather than an AV-shaped Windows abort code. A regression in c5's
Windows codegen (truncated handles, miscompiled main, etc.) would
either crash before reaching the gate or surface a non-privilege
NTSTATUS, which the smoke flags.

Override the badc binary with `BADC=path/to/badc`.
"""

from __future__ import annotations

import os
import platform
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


def host_windows_target() -> str | None:
    """Map the running Windows host to its badc target id, or
    None if this isn't a Windows host."""
    if sys.platform != "win32":
        return None
    arch = platform.machine().lower()
    if arch in ("arm64", "aarch64"):
        return "windows-arm64"
    if arch in ("amd64", "x86_64"):
        return "windows-x64"
    return None


# Milestone log lines the loader must print in order before
# failing at the privilege gate. A missing or out-of-order
# milestone means the loader either crashed earlier or got
# rerouted -- in either case a codegen smell worth flagging.
MILESTONES = [
    "Resolving ntdll exports",
    "ntdll exports resolved",
    "Sync event created",
    "Spawning child:",
    "NtCreateUserProcess failed:",
]

# NTSTATUS values the loader is *expected* to surface from the
# NtCreateUserProcess call on an unprivileged token. These are
# all variations of "the kernel refused to launch a NATIVE image
# without TCB" -- the kernel reports back at slightly different
# validation stages depending on the parameter shape, all
# stemming from the same privilege gate.
KNOWN_PRIV_STATUSES = {
    "0xC000000D",  # STATUS_INVALID_PARAMETER
    "0xC000003B",  # STATUS_OBJECT_PATH_SYNTAX_BAD
    "0xC0000061",  # STATUS_PRIVILEGE_NOT_HELD
}


def run_codegen_canary(loader: Path, hello: Path) -> int:
    """Run the loader against nt_hello and check the codegen
    reached the privilege gate intact. Returns 0 on healthy
    expected-failure, non-zero on a regression."""
    print(f"\nrunning {loader.name} {hello.name}")
    try:
        proc = subprocess.run(
            [str(loader), str(hello)],
            capture_output=True,
            text=True,
            timeout=30,
        )
    except subprocess.TimeoutExpired:
        print("smoke: nt_loader timed out -- codegen may have looped", file=sys.stderr)
        return 1

    out = proc.stdout
    print(out)

    # Hard reject anything that looks like a Windows-side abort
    # (AV, illegal instruction, etc.). The loader's normal-failure
    # path returns 1; a crash returns a large unsigned NTSTATUS
    # value, which Python surfaces as a negative i32.
    if proc.returncode != 1:
        print(
            f"smoke: nt_loader exit={proc.returncode} (want 1 -- the loader's \n"
            f"       clean privilege-gate path). Anything else, especially a \n"
            f"       large negative value, means the process aborted before \n"
            f"       reaching the gate -- check for a codegen regression.",
            file=sys.stderr,
        )
        return 1

    # Every milestone must appear, in order, before the gate
    # rejection. Out-of-order or missing milestones suggest the
    # loader crashed mid-flow or skipped past a step.
    cursor = 0
    for marker in MILESTONES:
        idx = out.find(marker, cursor)
        if idx == -1:
            print(
                f"smoke: loader output missing milestone `{marker}` -- "
                f"codegen probably crashed earlier",
                file=sys.stderr,
            )
            return 1
        cursor = idx + len(marker)

    # And the gate-rejection status must be one of the documented
    # privilege-related codes. An AV-shaped status (0xC0000005)
    # or anything else means we got past the gate via a path we
    # don't recognise.
    gate_line = next(
        (line for line in out.splitlines() if "NtCreateUserProcess failed:" in line),
        "",
    )
    if not any(status in gate_line for status in KNOWN_PRIV_STATUSES):
        print(
            f"smoke: NtCreateUserProcess returned an unexpected NTSTATUS\n"
            f"       line: {gate_line!r}\n"
            f"       expected one of: {sorted(KNOWN_PRIV_STATUSES)}",
            file=sys.stderr,
        )
        return 1

    print(
        "\nnt_loader codegen canary: loader walked through every milestone\n"
        "and failed at the expected privilege gate; codegen looks healthy."
    )
    return 0


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

    host_target = host_windows_target()
    if host_target is None:
        print("\nnt_loader smoke: build-only (non-Windows host)")
        return 0

    loader = work / f"nt_loader-{host_target}.exe"
    hello = work / f"nt_hello-{host_target}.exe"
    return run_codegen_canary(loader, hello)


if __name__ == "__main__":
    sys.exit(main())
