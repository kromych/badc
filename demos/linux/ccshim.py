#!/usr/bin/env python3
"""gcc-CLI shim over badc, for use as Kconfig's ``$(CC)``.

The kernel probes compiler capabilities at configure time by invoking ``$(CC)``
with small snippets (``scripts/Kconfig.include``: ``cc-option``, ``as-instr``,
and bare ``$(success,...)`` commands). Those invocations use driver spellings
badc has no equivalent for (``-x c``, ``-``, ``-S``, ``-E -P``), so badc cannot
be named as ``CC`` directly. This shim accepts the gcc driver surface the
probes use and answers each probe with badc.

Routing, one rule per probe class:

- C capability probes (``-S`` / ``-c`` on C input): answered by badc. Flags are
  passed through unchanged, so a flag badc does not accept fails the probe --
  which is the truthful answer, and matches the sweep, which drops exactly
  those flags when it replays a compile.
- Assembler probes (``-x assembler*``): delegated to the reference compiler.
  badc has no standalone assembler driver and ``.S`` units are outside the
  sweep's scope, so answering them with badc would disable assembler-gated
  options for a reason the sweep does not measure.
- Preprocess-only queries (``-E``): delegated to the reference compiler. These
  are identity and version queries (``scripts/cc-version.sh``), not capability
  probes; the kernel's version gates encode a specific toolchain's bug history
  rather than a feature badc either has or lacks.

``-S`` is answered by compiling to an object: the probe asks whether the
compiler accepts the construct, not what it emits.

Some kernel probes are not discriminating for badc: badc accepts the probe
snippet but rejects every form the kernel actually emits, so the probe reports
a capability badc does not have. ``probes/*.c`` holds a corroborating use of
such a feature, selected by a ``// trigger: <substring>`` line matched against
the probe source; a matching probe is answered by compiling the probe and the
corroboration together. Each file states the evidence for its existence. This
strengthens the kernel's own probe rather than overriding its verdict, and it
is re-verified on every run.

Environment: ``BADC`` (badc binary), ``PROBECFG_REF_CC`` (reference compiler,
default ``gcc``), ``PROBECFG_TARGET`` (badc target triple),
``PROBECFG_LOG`` (append one line per probe: decision, argv, badc stderr).
"""

from __future__ import annotations

import os
import subprocess
import sys
import tempfile
from pathlib import Path

# Options that consume the next token, so a value is never mistaken for input.
ARG_TAKING = {"-o", "-x", "-MF", "-MQ", "-MT", "-Xassembler", "-Xlinker",
              "-include", "-I", "-iquote", "-isystem", "--param", "-idirafter"}


PROBE_DIR = Path(__file__).resolve().parent / "probes"
TRIGGER = "// trigger:"


def corroborations(source: str) -> list[Path]:
    """Corroboration snippets whose trigger appears in this probe source."""
    hits = []
    for p in sorted(PROBE_DIR.glob("*.c")) if PROBE_DIR.is_dir() else []:
        text = p.read_text(errors="replace")
        line = next((ln for ln in text.splitlines() if ln.startswith(TRIGGER)), None)
        if line and line[len(TRIGGER):].strip() in source:
            hits.append(p)
    return hits


def log(decision: str, argv: list[str], detail: str = "") -> None:
    path = os.environ.get("PROBECFG_LOG")
    if not path:
        return
    line = f"{decision}\t{' '.join(argv)}"
    if detail:
        line += "\t| " + " ".join(detail.split())[:200]
    with open(path, "a") as f:
        f.write(line + "\n")


def delegate(argv: list[str], why: str) -> int:
    ref = os.environ.get("PROBECFG_REF_CC", "gcc")
    r = subprocess.run([ref, *argv])
    log(f"ref:{why}:{'y' if r.returncode == 0 else 'n'}", argv)
    return r.returncode


def main(argv: list[str]) -> int:
    lang: str | None = None
    mode = "link"
    out: str | None = None
    sources: list[str] = []
    flags: list[str] = []

    i = 0
    while i < len(argv):
        a = argv[i]
        if a == "-x":
            lang = argv[i + 1]
            i += 2
        elif a.startswith("-x") and len(a) > 2:
            lang = a[2:]
            i += 1
        elif a == "-o":
            out = argv[i + 1]
            i += 2
        elif a in ("-c", "-S", "-E"):
            mode = a[1:]
            i += 1
        elif a in ARG_TAKING:
            flags += [a, argv[i + 1]]
            i += 2
        elif a != "-" and a.startswith("-"):
            flags.append(a)
            i += 1
        else:
            sources.append(a)  # a path, or `-` for stdin
            i += 1

    if lang and lang.startswith("assembler"):
        return delegate(argv, "asm")
    if mode == "E":
        return delegate(argv, "cpp")
    if mode == "link" or not sources:
        return delegate(argv, "other")

    badc = os.environ.get("BADC")
    if not badc:
        print("ccshim: $BADC is not set", file=sys.stderr)
        return 2
    target = os.environ.get("PROBECFG_TARGET", "linux-x64")

    with tempfile.TemporaryDirectory() as td:
        srcs: list[str] = []
        extra: list[Path] = []
        for n, s in enumerate(sources):
            # `-` is stdin and /dev/null is the empty snippet; badc takes
            # neither as an input path, and neither carries a .c suffix.
            if s == "-":
                text = sys.stdin.read()
            elif s == "/dev/null":
                text = ""
            else:
                srcs.append(s)
                continue
            p = Path(td) / f"probe{n}.c"
            p.write_text(text)
            srcs.append(str(p))
            extra += corroborations(text)
        # One badc run per translation unit: badc pairs -o with a single input,
        # and a corroborated probe holds more than one. The probe passes only if
        # every unit compiles.
        obj = out if (out and out != "/dev/null" and mode == "c") \
            else str(Path(td) / "probe.o")
        for n, tu in enumerate([*srcs, *(str(p) for p in extra)]):
            cmd = [badc, "--gnu", "-q", "-c", f"--target={target}",
                   "-o", obj if n == 0 else f"{obj}.{n}", *flags, tu]
            r = subprocess.run(cmd, capture_output=True, text=True)
            if r.returncode != 0:
                break

    tag = "badc" + ("+" + ",".join(p.stem for p in extra) if extra else "")
    log(f"{tag}:{'y' if r.returncode == 0 else 'n'}", argv, r.stderr)
    if r.returncode != 0:
        sys.stderr.write(r.stderr)
    return r.returncode


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
