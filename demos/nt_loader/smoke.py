#!/usr/bin/env python3
"""Build the nt_loader / nt_hello demos with badc and, on Windows
hosts, verify the cross-process event handshake end-to-end.

Outside Windows: build-only smoke. Both PEs are produced via
`badc --target=windows-{x64,arm64}` and the script asserts each
output exists and has the expected Subsystem byte
(IMAGE_SUBSYSTEM_WINDOWS_CUI for nt_loader, IMAGE_SUBSYSTEM_NATIVE
for nt_hello).

On Windows: build the binaries for the host arch, start
nt_loader in the background, open the shared
`BadcLoaderSync` named event from Python via Win32, signal it,
then wait for the loader to exit. Pass requires exit code 0
and `Sync event received` in the captured stdout.

Override the badc binary with `BADC=path/to/badc`.
"""

from __future__ import annotations

import os
import platform
import subprocess
import sys
import time
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
    """Map the running Windows host to its badc target id."""
    if sys.platform != "win32":
        return None
    arch = platform.machine().lower()
    if arch in ("arm64", "aarch64"):
        return "windows-arm64"
    if arch in ("amd64", "x86_64"):
        return "windows-x64"
    return None


def run_event_handshake(loader: Path, hello: Path) -> None:
    """Start the loader, signal the named event from Python, then
    check the exit code and the captured log."""
    import ctypes  # win32-only import; deferred so non-Windows builds don't choke.

    kernel32 = ctypes.windll.kernel32  # type: ignore[attr-defined]
    kernel32.OpenEventW.argtypes = [ctypes.c_uint32, ctypes.c_int, ctypes.c_wchar_p]
    kernel32.OpenEventW.restype = ctypes.c_void_p
    kernel32.SetEvent.argtypes = [ctypes.c_void_p]
    kernel32.SetEvent.restype = ctypes.c_int
    kernel32.CloseHandle.argtypes = [ctypes.c_void_p]
    kernel32.CloseHandle.restype = ctypes.c_int

    event_modify_state = 0x0002
    event_name = "BadcLoaderSync"

    proc = subprocess.Popen(
        [str(loader), str(hello)],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
    )

    # Poll for the event to exist rather than racing a fixed sleep:
    # the loader prints "Sync event created" after NtCreateEvent
    # returns, so once OpenEventW succeeds we're past that point.
    handle = None
    for _ in range(50):  # up to ~1s
        handle = kernel32.OpenEventW(event_modify_state, 0, event_name)
        if handle:
            break
        time.sleep(0.02)

    if not handle:
        # Drain whatever the loader printed before giving up.
        proc.terminate()
        out, _ = proc.communicate(timeout=5)
        print(
            f"smoke: OpenEventW({event_name!r}) failed; loader output:\n{out}",
            file=sys.stderr,
        )
        sys.exit(1)

    if not kernel32.SetEvent(handle):
        print(f"smoke: SetEvent failed (GetLastError={kernel32.GetLastError()})", file=sys.stderr)
        kernel32.CloseHandle(handle)
        proc.terminate()
        sys.exit(1)
    kernel32.CloseHandle(handle)

    out, _ = proc.communicate(timeout=10)
    print(out)
    if proc.returncode != 0:
        print(f"smoke: nt_loader exit={proc.returncode}", file=sys.stderr)
        sys.exit(1)
    if "Sync event received" not in out:
        print("smoke: loader log missing `Sync event received`", file=sys.stderr)
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

    host_target = host_windows_target()
    if host_target is None:
        print("\nnt_loader smoke: build-only (non-Windows host)")
        return 0

    loader = work / f"nt_loader-{host_target}.exe"
    hello = work / f"nt_hello-{host_target}.exe"
    print(f"\nrunning {loader.name} {hello.name}")
    run_event_handshake(loader, hello)
    print(f"\nnt_loader smoke: event handshake verified on {host_target}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
