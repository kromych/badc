#!/usr/bin/env python3
"""Boot a UEFI application under QEMU/OVMF and check its serial output.

The image is placed at EFI/BOOT/BOOTX64.EFI (or BOOTAA64.EFI) on a virtual
FAT volume that OVMF auto-boots as removable media, so no UEFI Shell, no
mtools, and no on-disk FAT image are required. OVMF's ConSplitter mirrors
ConOut to the serial line, which QEMU routes to stdout. The emulator is
stopped once every expected string has appeared, so the timeout bounds only a
boot that never prints them.
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile
import threading
import time

# QEMU models that carry badc's instruction-set baseline: `max` for
# ARMv8.4-A with the ARMv8.5-A additions, `Haswell-noTSX` for x86-64-v3,
# which no named QEMU model spells and `max` over-provides (LA57 changes a
# kernel's paging mode). The x64 model drops the three features TCG does
# not implement, which QEMU would otherwise drop with a warning per boot.
BASELINE_CPU = {"x64": "Haswell-noTSX,-pcid,-invpcid,-tsc-deadline", "aarch64": "max"}

# OVMF firmware locations, in priority order. `$OVMF_CODE`/`$OVMF_VARS` (x64)
# and `$AAVMF_CODE`/`$AAVMF_VARS` (aarch64) override; then the common macOS
# (Homebrew) and Linux distro install paths. An empty env value never matches
# (`os.path.exists("")` is false).
FIRMWARE = {
    "x64": {
        "code": [
            os.environ.get("OVMF_CODE", ""),
            "/opt/homebrew/share/qemu/edk2-x86_64-code.fd",
            "/usr/share/OVMF/OVMF_CODE.fd",
            "/usr/share/edk2/x64/OVMF_CODE.fd",
            "/usr/share/edk2-ovmf/OVMF_CODE.fd",
            "/usr/share/qemu/edk2-x86_64-code.fd",
        ],
        "vars": [
            os.environ.get("OVMF_VARS", ""),
            "/opt/homebrew/share/qemu/edk2-i386-vars.fd",
            "/usr/share/OVMF/OVMF_VARS.fd",
            "/usr/share/edk2/x64/OVMF_VARS.fd",
            "/usr/share/edk2-ovmf/OVMF_VARS.fd",
            "/usr/share/qemu/edk2-i386-vars.fd",
        ],
        "qemu": "qemu-system-x86_64",
        "boot": "BOOTX64.EFI",
        "machine": "q35",
    },
    "aarch64": {
        "code": [
            os.environ.get("AAVMF_CODE", ""),
            "/opt/homebrew/share/qemu/edk2-aarch64-code.fd",
            "/usr/share/AAVMF/AAVMF_CODE.fd",
            "/usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.raw",
        ],
        "vars": [
            os.environ.get("AAVMF_VARS", ""),
            "/opt/homebrew/share/qemu/edk2-arm-vars.fd",
            "/usr/share/AAVMF/AAVMF_VARS.fd",
        ],
        "qemu": "qemu-system-aarch64",
        "boot": "BOOTAA64.EFI",
        "machine": "virt",
    },
}


def first_existing(paths):
    for p in paths:
        if os.path.exists(p):
            return p
    return None


def serial_until(cmd, wants, timeout):
    """Run the emulator and return its serial text, stopping once every string
    in `wants` has appeared.

    The guests do not exit on success -- preempt.c ends in a halt loop and
    kernel.c returns to the firmware -- so waiting for the process spends the
    whole budget on every boot. `timeout` bounds a guest that never prints.
    """
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                            stderr=subprocess.DEVNULL)
    chunks = []
    lock = threading.Lock()

    def drain(fd):
        while True:
            try:
                block = os.read(fd, 65536)
            except OSError:
                break
            if not block:
                break
            with lock:
                chunks.append(block)

    def serial():
        with lock:
            return b"".join(chunks).decode("latin-1").replace("\r", "")

    reader = threading.Thread(target=drain, args=(proc.stdout.fileno(),),
                              daemon=True)
    reader.start()
    # Each read is scanned once, against a window holding a tail long enough
    # that a string split across two reads still matches. Rescanning
    # everything printed so far would cost a guest more the longer it runs,
    # which is the case the budget exists to bound. The verdict is not taken
    # here: `run` recomputes it over the whole text this returns.
    left, seen, window = list(wants), 0, ""
    keep = max((len(w) for w in wants), default=1)
    deadline = time.monotonic() + timeout
    while left:
        if proc.poll() is not None or time.monotonic() >= deadline:
            break
        with lock:
            fresh, seen = b"".join(chunks[seen:]), len(chunks)
        if not fresh:
            time.sleep(0.05)
            continue
        window += fresh.decode("latin-1").replace("\r", "")
        left = [w for w in left if w not in window]
        window = window[-keep:]
    if proc.poll() is None:
        proc.terminate()
        try:
            proc.wait(timeout=5)
        except subprocess.TimeoutExpired:
            proc.kill()
            proc.wait()
    reader.join(timeout=5)
    proc.stdout.close()
    return serial()


def run(efi, expect, arch="x64", timeout=30, extra_files=None, startup=None):
    fw = FIRMWARE[arch]
    # A badc-built emulator (demos/qemu) can stand in for the system QEMU:
    # `$QEMU_SYSTEM_X64` / `$QEMU_SYSTEM_AARCH64` override the binary.
    qemu = os.environ.get(f"QEMU_SYSTEM_{arch.upper()}", fw["qemu"])
    code = first_existing(fw["code"])
    vars_tmpl = first_existing(fw["vars"])
    if not code:
        sys.exit(f"no OVMF code firmware for {arch}: tried {fw['code']}")
    work = tempfile.mkdtemp(prefix="qemu_efi_")
    esp = os.path.join(work, "esp", "EFI", "BOOT")
    os.makedirs(esp)
    shutil.copy(efi, os.path.join(esp, fw["boot"]))
    for name, path in (extra_files or {}).items():
        shutil.copy(path, os.path.join(work, "esp", name))
    if startup is not None:
        with open(os.path.join(work, "esp", "startup.nsh"), "w") as f:
            f.write(startup)
    vars_rw = os.path.join(work, "vars.fd")
    if vars_tmpl:
        shutil.copy(vars_tmpl, vars_rw)
    else:
        with open(vars_rw, "wb") as f:
            f.write(b"\xff" * os.path.getsize(code))

    cmd = [
        qemu, "-machine", fw["machine"], "-m", "256", "-display", "none",
        "-drive", f"if=pflash,format=raw,unit=0,file={code},readonly=on",
        "-drive", f"if=pflash,format=raw,unit=1,file={vars_rw}",
        "-drive", f"format=raw,file=fat:rw:{os.path.join(work, 'esp')}",
        "-serial", "stdio", "-no-reboot",
    ]
    # The guest CPU carries badc's instruction-set baseline
    # (doc/native-compilation.md): a smaller model faults on the first
    # baseline instruction the program selects, such as an LSE atomic.
    cmd += ["-cpu", BASELINE_CPU[arch]]
    wants = [expect] if isinstance(expect, str) else list(expect)
    text = serial_until(cmd, wants, timeout)
    shutil.rmtree(work, ignore_errors=True)
    missing = [w for w in wants if w not in text]
    return (not missing), text, missing


def self_test():
    """`serial_until` returns at the markers, at the guest's own exit, and at
    the timeout, and never waits out the budget on a guest that printed."""
    def guest(script):
        return [sys.executable, "-c", script]

    printed = ("import sys, time\n"
               "sys.stdout.write('boot\\r\\nMARK-A\\r\\nMARK-B\\r\\n')\n"
               "sys.stdout.flush()\n"
               "time.sleep(600)\n")
    t0 = time.monotonic()
    text = serial_until(guest(printed), ["MARK-A", "MARK-B"], 600)
    took = time.monotonic() - t0
    assert "MARK-A" in text and "MARK-B" in text, text
    assert "\r" not in text, repr(text)
    assert took < 30, took

    t0 = time.monotonic()
    text = serial_until(guest("import time\ntime.sleep(600)\n"), ["MARK-A"], 2)
    took = time.monotonic() - t0
    assert "MARK-A" not in text, text
    assert 2 <= took < 30, took

    t0 = time.monotonic()
    text = serial_until(guest("print('partial')\n"), ["MARK-A"], 600)
    took = time.monotonic() - t0
    assert text.strip() == "partial", repr(text)
    assert took < 30, took

    # A marker split across reads still matches, and one that arrives after
    # megabytes of noise costs a scan of the noise once, not once per poll.
    noisy = ("import sys, time\n"
             "sys.stdout.write('x' * (8 << 20))\n"
             "sys.stdout.write('MARK-SPLIT-')\n"
             "sys.stdout.flush()\n"
             "time.sleep(0.5)\n"
             "sys.stdout.write('TAIL\\r\\n')\n"
             "sys.stdout.flush()\n"
             "time.sleep(600)\n")
    t0 = time.monotonic()
    text = serial_until(guest(noisy), ["MARK-SPLIT-TAIL"], 600)
    took = time.monotonic() - t0
    assert "MARK-SPLIT-TAIL" in text, text[-80:]
    assert took < 30, took


def main():
    if sys.argv[1:] == ["--self-test"]:
        self_test()
        print("qemu_efi: self-test ok", flush=True)
        return 0
    ap = argparse.ArgumentParser()
    ap.add_argument("efi")
    ap.add_argument("--expect", action="append", required=True,
                    help="substring that must appear on serial (repeatable)")
    ap.add_argument("--arch", default="x64", choices=list(FIRMWARE))
    ap.add_argument("--timeout", type=int, default=30)
    ap.add_argument("--show", action="store_true", help="print captured serial")
    args = ap.parse_args()
    ok, text, missing = run(args.efi, args.expect, args.arch, args.timeout)
    if args.show or not ok:
        sys.stderr.write(text[-4000:] + "\n")
    if ok:
        print(f"PASS: {args.efi} produced {args.expect}")
        return 0
    print(f"FAIL: {args.efi} missing {missing}", file=sys.stderr)
    return 1


if __name__ == "__main__":
    sys.exit(main())
