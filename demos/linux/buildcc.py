#!/usr/bin/env python3
"""Kbuild CC shim: badc builds the kernel's C, gcc keeps the rest.

Named as the kernel's CC. Per invocation:

- Kernel C compile (-c, -D__KERNEL__, a .c source, not -m16/-m32): badc
  compiles it, and only badc. The rewritten flag set carries the
  dependency flags through, so badc writes the .d file kbuild's fixdep
  consumes; no other compiler runs and no other compiler's object can
  end up in the image. A badc failure is the shim's failure: its exit
  status and diagnostic go straight to make, which stops at the defect.
  Recorded in the manifest as `badc` or `fail`.
- A unit named in ``$BADC_FALLBACK`` is compiled by the real compiler and
  recorded as `fallback`. That list is the bisect tool for a suspected
  miscompile: naming a unit is explicit and shows up in the manifest, so
  a build that used it cannot be mistaken for a pure one.
- ``--version``: answered with badc's identification when ``$BADC`` is set.
  The kernel captures ``$(CC) --version | head -n1`` as
  ``CONFIG_CC_VERSION_TEXT``, which reaches the boot banner and
  ``/proc/version``; the answer must come from this shim itself --
  Kconfig re-runs whenever the recorded text disagrees with what the
  build's ``$(CC)`` reports, so an identification the shim did not give
  cannot survive the build. Classification stays with the reference
  compiler: ``scripts/cc-version.sh`` asks via ``-E``, and badc's claimed
  ``__GNUC__`` (4.2.1) is below the kernel's gcc floor.
- Anything else (cc-option probes, -E, -S, .S units, links,
  -m16/-m32 units, the host tools under scripts/ and tools/): the real
  compiler, untouched. gas still assembles .S and ld still links.
  Configuration answers stay the reference compiler's, so the built
  object population matches the corpus the sweep measured.

There is no gcc pre-pass and no substitution. Every kernel C object in
the tree was produced by badc unless its source is on the fallback list.

Environment: BADC (badc binary, required once a kernel unit appears),
BADC_REAL_CC (default gcc), BADC_TARGET (default linux-x64),
BADC_FALLBACK (file of kernel-relative source paths to leave to the real
compiler), BADC_MANIFEST (append `badc|fallback|fail<TAB>source[<TAB>detail]`
per kernel unit), BADC_TIMEOUT (seconds per badc run, default 300).
"""

from __future__ import annotations

import os
import subprocess
import sys

# Flag policy as in sweep.py: keep the preprocessor surface and the code
# model (-mcmodel=), fold -isystem/-idirafter into -I, honor the recorded
# optimization level, drop the rest (warnings, -g/-std, the gcc hardening
# spellings badc has no equivalent for). It differs in the dependency
# flags below: the sweep compiles into a scratch directory and wants no
# .d files, while this shim is the kernel's CC and must produce them.
KEEP_ARG = {"-I", "-include", "-iquote", "-MF", "-MT", "-MQ"}
FOLD_TO_I = {"-isystem", "-idirafter"}
DROP_ARG = {"-o", "--param", "-Xassembler", "-Xlinker"}

# Dependency generation. kbuild names the depfile with -Wp,-MMD,<path> and
# turns it into the .cmd file with fixdep, so a unit whose compiler never
# sees these rebuilds on the wrong triggers. badc implements the gcc
# surface, so the flags forward unchanged.
DEP_FLAG = {"-M", "-MM", "-MD", "-MMD", "-MP"}
DEP_WP_PREFIX = ("-Wp,-MMD,", "-Wp,-MD,")

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
        elif a.startswith(("-D", "-U")) or a in DEP_FLAG or a.startswith(DEP_WP_PREFIX):
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


def source_of(argv: list[str]) -> str | None:
    """The compiled source: a positional `.c` argument.

    An option's separate argument is not positional, so the value of
    `-include`, `-I` and the rest is skipped. The kernel's vDSO units are
    built with `-include lib/vdso/gettimeofday.c` ahead of the source, and
    taking the first `.c` token anywhere on the line picks that up instead
    and compiles a translation unit the build never asked for.
    """
    takes_arg = KEEP_ARG | FOLD_TO_I | DROP_ARG
    i = 0
    while i < len(argv):
        a = argv[i]
        if a in takes_arg:
            i += 2
            continue
        if not a.startswith("-") and a.endswith(".c"):
            return a
        i += 1
    return None


def main(argv: list[str]) -> int:
    real = os.environ.get("BADC_REAL_CC", "gcc")
    badc = os.environ.get("BADC")
    if argv == ["--version"] and badc:
        os.execvp(badc, [badc, "--version"])
    src = source_of(argv)
    kernel_c = (src is not None and "-c" in argv and "-D__KERNEL__" in argv
                and "-m16" not in argv and "-m32" not in argv)
    if not kernel_c:
        os.execvp(real, [real, *argv])
    try:
        obj = argv[argv.index("-o") + 1]
    except (ValueError, IndexError):
        # kbuild always names the object; a kernel C compile without -o is
        # some other caller's shape, so leave it to the real compiler
        # rather than guessing an output path.
        os.execvp(real, [real, *argv])
    if fallback_listed(src, obj):
        # Opt-in only, and recorded before the exec: a build that used the
        # list says so in the manifest.
        manifest("fallback", src, "listed")
        os.execvp(real, [real, *argv])

    if not badc:
        sys.exit("buildcc: $BADC is not set")
    target = os.environ.get("BADC_TARGET", "linux-x64")
    timeout = float(os.environ.get("BADC_TIMEOUT", "300"))

    cmd = [badc, "--gnu", "-q", "-c", f"--target={target}", "-o", obj,
           *rewrite(argv), src]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           timeout=timeout)
        rc, err = r.returncode, r.stderr
    except subprocess.TimeoutExpired:
        rc, err = 900, f"timeout after {timeout:.0f}s"
    if rc == 0:
        manifest("badc", src)
        return 0

    # No second compiler runs. Drop any partial object so a later make
    # cannot mistake it for a built one, put badc's diagnostic on stderr,
    # and fail so the build stops at the defect.
    try:
        os.unlink(obj)
    except OSError:
        pass
    lines = [ln for ln in err.splitlines() if ln.strip()]
    first = next((ln for ln in lines
                  if "error" in ln or "panicked" in ln),
                 lines[-1] if lines else f"exit {rc}")
    manifest("fail", src, first)
    sys.stderr.write(err if err.endswith("\n") else err + "\n")
    return rc or 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
