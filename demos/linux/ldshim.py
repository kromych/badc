#!/usr/bin/env python3
"""Kbuild LD shim: badc links what it implements, GNU ld keeps the rest.

Named as the kernel's LD. Routing is decided from facts of the
invocation, not from a list of paths:

- ``-m elf_i386`` (or any emulation badc has no backend for): the real
  linker. badc targets x86-64 and aarch64 only, so the 16/32-bit boot
  links (``arch/x86/boot/setup.elf``, ``arch/x86/realmode/rm``,
  ``vdso32``) cannot be badc's. Recorded as `ld` with the emulation.
- A final link with no ``-T``/``--script``: the real linker. badc has
  no built-in default script, so a scriptless link has no layout to
  follow. Recorded as `ld`.
- A link asking for dynamic-linking metadata (``-soname``,
  ``--hash-style``, ``--dynamic-linker``): the real linker. badc's
  script-driven engine emits relocation tables but no
  ``.dynsym``/``.dynstr``/``.hash``/``.dynamic``, which the vDSO images
  need and the kernel image does not. badc rejects these options rather
  than ignoring them, so this routing only anticipates that refusal.
  Recorded as `ld`.
- Everything else -- ``-r`` merges and script-driven final links,
  including every ``vmlinux`` pass -- badc, and only badc. A badc
  failure is the shim's failure: its exit status and diagnostic go to
  make, which stops at the defect. Recorded as `badc` or `fail`.
- Version and capability probes (``-v``/``--version`` with no output
  file): badc answers, so what the configuration records about the
  linker is what badc actually implements. ``$(call ld-option,...)``
  runs the option past the linker with ``-v``; badc rejects options it
  does not implement, so an unimplemented option is dropped by kbuild
  rather than accepted and ignored.

A unit named in ``$BADC_LD_FALLBACK`` (output paths, one per line) goes
to the real linker and is recorded as `fallback`. That list is the
bisect tool for a suspected bad link: naming an output is explicit and
shows up in the manifest, so a build that used it cannot be mistaken
for a pure one.

Environment: BADC (badc binary, required), BADC_LD_REAL (default ld),
BADC_LD_FALLBACK (file of output paths to leave to the real linker),
BADC_LD_MANIFEST (append `badc|ld|fallback|fail<TAB>output[<TAB>detail]`
per link), BADC_LD_TIMEOUT (seconds per badc link, default 900).
"""

from __future__ import annotations

import os
import subprocess
import sys

# Emulations badc has a backend for. Everything else is the real
# linker's: badc emits ELF64 little-endian x86-64 / aarch64 only.
BADC_EMULATIONS = {"elf_x86_64", "aarch64linux", "aarch64elf"}

# Options that can only be honored by writing a dynamic section.
DYNAMIC_EXACT = {"-soname", "-h", "--dynamic-linker"}
DYNAMIC_PREFIX = ("-soname=", "--soname=", "--dynamic-linker=", "--hash-style=")


def wants_dynamic_metadata(argv: list[str]) -> str | None:
    """The first option requesting a dynamic section, or None."""
    for a in argv:
        if a in DYNAMIC_EXACT or a.startswith(DYNAMIC_PREFIX):
            return a
    return None


def emulation(argv: list[str]) -> str | None:
    """The last `-m EMU` on the line, joined or separate, as ld resolves
    it (a later -m overrides an earlier one)."""
    emu = None
    i = 0
    while i < len(argv):
        a = argv[i]
        if a == "-m" and i + 1 < len(argv):
            emu, i = argv[i + 1], i + 2
            continue
        if a.startswith("-m") and len(a) > 2:
            emu = a[2:]
        i += 1
    return emu


def output_of(argv: list[str]) -> str | None:
    for i, a in enumerate(argv):
        if a == "-o" and i + 1 < len(argv):
            return argv[i + 1]
        if a.startswith("--output="):
            return a[len("--output="):]
    return None


def has_script(argv: list[str]) -> bool:
    for i, a in enumerate(argv):
        if a in ("-T", "--script") and i + 1 < len(argv):
            return True
        if a.startswith(("--script=", "-T")) and len(a) > 2:
            return True
    return False


def manifest(status: str, output: str, detail: str = "") -> None:
    path = os.environ.get("BADC_LD_MANIFEST")
    if not path:
        return
    line = f"{status}\t{output}"
    if detail:
        line += "\t" + " ".join(detail.split())[:300]
    # One O_APPEND write per line keeps parallel jobs from interleaving.
    fd = os.open(path, os.O_APPEND | os.O_CREAT | os.O_WRONLY, 0o644)
    try:
        os.write(fd, (line + "\n").encode())
    finally:
        os.close(fd)


def fallback_listed(output: str) -> bool:
    path = os.environ.get("BADC_LD_FALLBACK")
    if not path:
        return False
    try:
        with open(path) as f:
            entries = [ln.strip() for ln in f
                       if ln.strip() and not ln.startswith("#")]
    except OSError:
        return False
    return any(output == e or output.endswith("/" + e) for e in entries)


def main(argv: list[str]) -> int:
    real = os.environ.get("BADC_LD_REAL", "ld")
    badc = os.environ.get("BADC")
    out = output_of(argv)
    emu = emulation(argv)
    relocatable = any(a in ("-r", "--relocatable", "-i") for a in argv)

    if out is None:
        # A probe, not a link. badc answers so the recorded linker
        # capabilities are badc's; an emulation it has no backend for
        # is still the real linker's answer.
        if badc and (emu is None or emu in BADC_EMULATIONS):
            os.execvp(badc, [badc, "--ld", *argv])
        os.execvp(real, [real, *argv])

    if emu is not None and emu not in BADC_EMULATIONS:
        manifest("ld", out, f"emulation {emu}")
        os.execvp(real, [real, *argv])
    if not relocatable and not has_script(argv):
        manifest("ld", out, "final link without a linker script")
        os.execvp(real, [real, *argv])
    if (dyn := wants_dynamic_metadata(argv)) is not None:
        manifest("ld", out, f"{dyn} needs a dynamic section")
        os.execvp(real, [real, *argv])
    if fallback_listed(out):
        manifest("fallback", out, "listed")
        os.execvp(real, [real, *argv])
    if not badc:
        sys.exit("ldshim: $BADC is not set")

    timeout = float(os.environ.get("BADC_LD_TIMEOUT", "900"))
    cmd = [badc, "--ld", *argv]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
        rc, err = r.returncode, r.stderr
    except subprocess.TimeoutExpired:
        rc, err = 900, f"timeout after {timeout:.0f}s"
    if rc == 0:
        manifest("badc", out)
        sys.stderr.write(err)
        return 0

    # No second linker runs. Drop any partial output so a later make
    # cannot mistake it for a linked one, put badc's diagnostic on
    # stderr, and fail so the build stops at the defect.
    try:
        os.unlink(out)
    except OSError:
        pass
    lines = [ln for ln in err.splitlines() if ln.strip()]
    first = next((ln for ln in lines if "error" in ln or "panicked" in ln),
                 lines[-1] if lines else f"exit {rc}")
    manifest("fail", out, first)
    sys.stderr.write(err if err.endswith("\n") else err + "\n")
    return rc or 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
