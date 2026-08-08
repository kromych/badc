#!/usr/bin/env python3
"""Kbuild CC shim: hybrid badc/gcc kernel build.

Named as the kernel's CC, substitutes badc objects for kernel C compiles
while gcc keeps every other duty. Per invocation:

- Kernel C compile (-c, -D__KERNEL__, a .c source, not -m16/-m32): the real
  gcc runs first with the original argv, producing kbuild's object and the
  -Wp,-MMD dependency bookkeeping. Unless the source is on the fallback
  list, badc then recompiles the unit with the flag set sweep.py replays
  and replaces the object on success. A badc failure leaves gcc's object
  standing and is recorded: a unit that passed the sweep is expected to
  compile here, so every such line is a bug report.
- ``--version``: answered with badc's identification when ``$BADC`` is set.
  The kernel captures ``$(CC) --version | head -n1`` as
  ``CONFIG_CC_VERSION_TEXT``, which reaches the boot banner and
  ``/proc/version``; a hybrid build whose kernel C units are badc's must
  identify badc there, and the answer must come from this shim itself --
  Kconfig re-runs whenever the recorded text disagrees with what the
  build's ``$(CC)`` reports, so an identification the shim did not give
  cannot survive the build. Classification stays with the reference
  compiler: ``scripts/cc-version.sh`` asks via ``-E``, and badc's claimed
  ``__GNUC__`` (4.2.1) is below the kernel's gcc floor.
- Anything else (cc-option probes, -E, -S, .S units, links,
  -m16/-m32 units): the real gcc, untouched. Configuration answers stay
  the reference compiler's, so the built object population matches the
  corpus the sweep measured.

Environment: BADC (badc binary, required once a kernel unit appears),
BADC_REAL_CC (default gcc), BADC_TARGET (default linux-x64),
BADC_FALLBACK (file of kernel-relative source paths to leave to gcc),
BADC_MANIFEST (append `badc|fallback|fail<TAB>source[<TAB>detail]` per
kernel unit), BADC_TIMEOUT (seconds per badc run, default 300).
"""

from __future__ import annotations

import os
import subprocess
import sys

# Flag policy identical to sweep.py: keep the preprocessor surface and the
# code model (-mcmodel=), fold -isystem/-idirafter into -I, honor the
# recorded optimization level, drop the rest (warnings, -g/-std, the gcc
# hardening spellings badc has no equivalent for).
KEEP_ARG = {"-I", "-include", "-iquote"}
FOLD_TO_I = {"-isystem", "-idirafter"}
DROP_ARG = {"-o", "-MF", "-MQ", "-MT", "--param", "-Xassembler", "-Xlinker"}

# Speculative-execution mitigations. These change what the built object
# guarantees, not just how it is built, so they are forwarded rather than
# dropped: a mitigation flag that the compiler never sees produces an
# unmitigated object that still links and boots, which is indistinguishable
# from a mitigated one without disassembling it.
#
# Valued forms are matched by prefix; badc accepts the argument set it
# implements and rejects the rest, so a spelling it does not cover fails the
# unit instead of building it unprotected.
HARDENING_EXACT = {"-mindirect-branch-register", "-mindirect-branch-cs-prefix"}
HARDENING_PREFIX = ("-mindirect-branch=", "-mfunction-return=", "-mharden-sls=",
                    "-fcf-protection=")

# Return-address signing has no badc spelling: badc emits no
# pointer-authentication prologue/epilogue pair, so `-mbranch-protection`
# specs naming `pac-ret` (directly or through `standard`) are reported and
# withheld rather than forwarded, which would fail every unit, or dropped,
# which would hide the gap. `bti` and `none` are forwarded.
BRANCH_PROT_PREFIX = "-mbranch-protection="
BRANCH_PROT_IMPLEMENTED = {"none", "bti"}
_reported_unimplemented: set[str] = set()


def hardening_arg(a: str) -> str | None:
    """The badc spelling of a mitigation flag, or None to withhold it.

    Withholding is announced once per distinct flag on stderr so a build log
    records which mitigation the objects do not carry.
    """
    if a in HARDENING_EXACT or a.startswith(HARDENING_PREFIX):
        return a
    if a.startswith(BRANCH_PROT_PREFIX):
        spec = a[len(BRANCH_PROT_PREFIX):]
        if all(f in BRANCH_PROT_IMPLEMENTED for f in spec.split("+")):
            return a
        if a not in _reported_unimplemented:
            _reported_unimplemented.add(a)
            print(
                f"badc: note: `{a}` has no badc spelling; objects built by badc "
                "carry no return-address signing",
                file=sys.stderr,
            )
        return None
    return None


def rewrite(argv: list[str]) -> list[str]:
    out: list[str] = []
    opt: str | None = None
    i = 0
    while i < len(argv):
        a = argv[i]
        if a in KEEP_ARG:
            out += [a, argv[i + 1]]
            i += 2
        elif a in FOLD_TO_I:
            out += ["-I", argv[i + 1]]
            i += 2
        elif a.startswith("-I") and len(a) > 2:
            out += ["-I", a[2:]]
            i += 1
        elif a.startswith(("-D", "-U")):
            out.append(a)
            i += 1
        elif a in DROP_ARG:
            i += 2
        elif a.startswith("-O"):
            opt = a  # last one wins, as with gcc
            i += 1
        elif a == "-mstrict-align":
            # Early-boot units that run with the MMU off are built with
            # this: memory is Device-typed there and an unaligned access
            # raises an alignment fault. badc caps every compiler-generated
            # access at the alignment its operand types guarantee.
            out.append(a)
            i += 1
        elif a in ("-mno-sse", "-mgeneral-regs-only"):
            # Keep generated code off the floating-point / SIMD register
            # file, which a linked kernel object must do: the kernel runs
            # with it trapped (no CR4.OSFXSR on x86_64, CPACR_EL1.FPEN on
            # aarch64) and callers do not maintain the System V `al`
            # convention. badc's variadic prologue honors both spellings.
            out.append(a)
            i += 1
        elif a.startswith("-mcmodel="):
            # Code model: under `kernel` external addresses become the
            # sign-extended 32-bit absolutes the module loader applies,
            # not GOT loads. badc validates the value.
            out.append(a)
            i += 1
        elif a in ("-fPIC", "-fpic", "-fPIE", "-fpie", "-fno-pic", "-fno-PIC"):
            # The EFI-stub island copies its objects wholesale and rejects
            # any absolute relocation, and the boot decompressor links its
            # objects into a segment that may carry none, so units built
            # position-independent must take badc's position-independent
            # object form (label-difference switch tables). Elsewhere the
            # default absolute form stays: its relocations name the branch
            # targets, which the ORC pass requires.
            out.append(a)
            i += 1
        elif (mitigation := hardening_arg(a)) is not None:
            out.append(mitigation)
            i += 1
        elif a.startswith("-"):
            i += 1
        else:
            i += 1  # positional: the source (re-added by the caller)
    if opt is not None and opt != "-O0":
        out.append("-O")
    return out


def manifest(status: str, src: str, detail: str = "") -> None:
    path = os.environ.get("BADC_MANIFEST")
    if not path:
        return
    line = f"{status}\t{src}"
    if detail:
        line += "\t" + " ".join(detail.split())[:300]
    # One O_APPEND write per line keeps parallel jobs from interleaving.
    fd = os.open(path, os.O_APPEND | os.O_CREAT | os.O_WRONLY, 0o644)
    try:
        os.write(fd, (line + "\n").encode())
    finally:
        os.close(fd)


def fallback_listed(src: str, obj: str) -> bool:
    """True when the source path or the object path is listed. Object
    entries discriminate a compile context: a source shared with an
    isolated-link environment (EFI stub's lib-%.o) is listed by the object
    it becomes there, leaving its other compiles to badc."""
    path = os.environ.get("BADC_FALLBACK")
    if not path:
        return False
    try:
        with open(path) as f:
            entries = [ln.strip() for ln in f
                       if ln.strip() and not ln.startswith("#")]
    except OSError:
        return False
    return any(p == e or p.endswith("/" + e)
               for e in entries for p in (src, obj))


def main(argv: list[str]) -> int:
    real = os.environ.get("BADC_REAL_CC", "gcc")
    badc = os.environ.get("BADC")
    if argv == ["--version"] and badc:
        os.execvp(badc, [badc, "--version"])
    src = next((a for a in argv
                if a.endswith(".c") and not a.startswith("-")), None)
    kernel_c = (src is not None and "-c" in argv and "-D__KERNEL__" in argv
                and "-m16" not in argv and "-m32" not in argv)
    if not kernel_c:
        os.execvp(real, [real, *argv])

    rc = subprocess.run([real, *argv]).returncode
    if rc != 0:
        return rc
    try:
        obj = argv[argv.index("-o") + 1]
    except (ValueError, IndexError):
        return 0
    if fallback_listed(src, obj):
        manifest("fallback", src, "listed")
        return 0

    if not badc:
        sys.exit("buildcc: $BADC is not set")
    target = os.environ.get("BADC_TARGET", "linux-x64")
    timeout = float(os.environ.get("BADC_TIMEOUT", "300"))

    # badc writes next to the object and replaces it only on success, so a
    # failure of any kind leaves gcc's object in place.
    tmp = obj + ".badc"
    cmd = [badc, "--gnu", "-q", "-c", f"--target={target}", "-o", tmp,
           *rewrite(argv), src]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           timeout=timeout)
        rc_b, err = r.returncode, r.stderr
    except subprocess.TimeoutExpired:
        rc_b, err = 900, f"timeout after {timeout:.0f}s"
    if rc_b == 0 and os.path.isfile(tmp):
        os.replace(tmp, obj)
        manifest("badc", src)
    else:
        try:
            os.unlink(tmp)
        except OSError:
            pass
        lines = [ln for ln in err.splitlines() if ln.strip()]
        first = next((ln for ln in lines
                      if "error" in ln or "panicked" in ln),
                     lines[-1] if lines else f"exit {rc_b}")
        manifest("fail", src, first)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
