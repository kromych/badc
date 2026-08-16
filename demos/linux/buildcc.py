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
- Kernel assembly (-c, -D__KERNEL__, a .S / .s source): badc assembles
  it, and gas assembles it when badc cannot. kbuild routes .S through
  $(CC), not $(AS), so this shim is where an assembly unit is decided.
  Recorded in the manifest as `badc-asm` or `gas`, with badc's own
  diagnostic as the detail of a `gas` line. Unlike the C path a
  fallback here is expected, so it is measured rather than fatal: the
  count of each is what the manifest is for.
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
- Anything else (cc-option probes, -E, -S, links, the host tools under
  scripts/ and tools/): the real compiler, untouched. Configuration
  answers stay the reference compiler's, so the built object population
  matches the corpus the sweep measured.

There is no gcc pre-pass and no substitution. Every kernel C object in
the tree was produced by badc unless its source is on the fallback list.

Every flag on a kernel unit's command line is accounted for. It is
forwarded to badc, or listed in ``UNSUPPORTED_*`` -- badc has no
equivalent and the object differs without it, so each unit that passes
one says so down the diagnostic channel -- or listed in ``IGNORE_*``
with the measured reason badc's object is the same without it. A flag on
no list fails the unit: a shim that cannot account for a flag must not
decide that the compiler does not need it.

A warning comes with `rc == 0`, so the success path decides whether it is
observable. With ``$BADC_WARN_LOG`` set, what badc wrote on a successful
compile is appended there tagged with the unit, for the caller to
summarize; without it, it goes to stderr.

Environment: BADC (badc binary, required once a kernel unit appears),
BADC_REAL_CC (default gcc), BADC_TARGET (default linux-x64),
BADC_FALLBACK (file of kernel-relative source paths to leave to the real
compiler), BADC_MANIFEST (append
`badc|fallback|fail|badc-asm|gas<TAB>source[<TAB>detail]` per kernel unit),
BADC_WARN_LOG (append `cc<TAB>source<TAB>diagnostic` per line badc wrote
on a successful compile), BADC_TIMEOUT (seconds per badc run, default 300).
"""

from __future__ import annotations

import os
import subprocess
import sys
import tempfile
from typing import NamedTuple

# Flag policy as in sweep.py: keep the preprocessor surface and the code
# model (-mcmodel=), fold -isystem/-idirafter into -I, honor the recorded
# optimization level, drop the rest (warnings, the gcc hardening
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

# Debug-info request. CONFIG_DEBUG_INFO_DWARF{4,5} spell it -gdwarf-N;
# -g/-g1/-g2/-g3 are the level spellings. badc accepts only -g, so all of
# them map onto it.
DEBUG_EXACT = {"-g", "-g1", "-g2", "-g3", "-ggdb"}
DEBUG_PREFIX = ("-gdwarf", "-ggdb")

# Speculative-execution mitigations. These change what the built object
# guarantees, not just how it is built, so they are forwarded rather than
# dropped: a mitigation flag that the compiler never sees produces an
# unmitigated object that still links and boots, which is indistinguishable
# from a mitigated one without disassembling it.
#
# Valued forms are matched by prefix; badc accepts the argument set it
# implements and rejects the rest, so a spelling it does not cover fails the
# unit instead of building it unprotected.
#
# `-mbranch-protection=` is one of them. kbuild probes it with `cc-option`,
# which this shim delegates to the reference compiler, so the probe answers
# yes whatever badc does; withholding the flag would leave every unit
# unsigned under a configuration that says otherwise, and
# `arch/arm64/kernel/pi/map_kernel.c` drops the shadow call stack on the
# strength of that configuration.
HARDENING_EXACT = {"-mindirect-branch-register", "-mindirect-branch-cs-prefix"}
HARDENING_PREFIX = ("-mindirect-branch=", "-mfunction-return=", "-mharden-sls=",
                    "-fcf-protection=", "-mbranch-protection=")


FORWARD_EXACT = {
    # Code mode. Only an assembly unit reaches this with a non-64-bit
    # spelling (the C path leaves those to the real compiler); forwarding it
    # makes badc name the gap in the manifest rather than the shim guess.
    "-m16", "-m32", "-m64",
    # arch/x86/Makefile adds -fno-jump-tables under
    # CONFIG_MITIGATION_RETPOLINE and probes it with the IBT pair: a table
    # dispatch is an indirect branch, which those configurations forbid
    # unthunked and require a landing pad at.
    "-fno-jump-tables", "-fjump-tables",
    # Early-boot units that run with the MMU off are built with this: memory
    # is Device-typed there and an unaligned access raises an alignment
    # fault. badc caps every compiler-generated access at the alignment its
    # operand types guarantee.
    "-mstrict-align",
    # Keep generated code off the floating-point / SIMD register file, which
    # a linked kernel object must do: the kernel runs with it trapped (no
    # CR4.OSFXSR on x86_64, CPACR_EL1.FPEN on aarch64) and callers do not
    # maintain the System V `al` convention.
    "-mno-sse", "-mgeneral-regs-only",
    # wchar_t width. The kernel builds the whole tree with -fshort-wchar and
    # stages L"..." into efi_char16_t (u16) arrays, so a compiler that never
    # sees it lays out the wrong element width.
    "-fshort-wchar", "-fno-short-wchar",
    # Plain char signedness. The kernel builds every unit -funsigned-char
    # because the ABI default differs per architecture; it inverts badc's
    # linux-x64 default and matches its linux-aarch64 one.
    "-funsigned-char", "-fsigned-char", "-fno-unsigned-char", "-fno-signed-char",
    # The EFI-stub island copies its objects wholesale and rejects any
    # absolute relocation, and the boot decompressor links its objects into a
    # segment that may carry none, so units built position-independent must
    # take badc's position-independent object form (label-difference switch
    # tables). Elsewhere the default absolute form stays: its relocations
    # name the branch targets, which the ORC pass requires.
    "-fPIC", "-fpic", "-fPIE", "-fpie", "-fno-pic", "-fno-PIC",
    "-fno-pie", "-fno-PIE",
}

FORWARD_PREFIX = (
    "-D", "-U",
    # The dialect selects which declarations the kernel's headers reach:
    # `<asm/xen/interface_64.h>` gates the anonymous union naming both `rip`
    # and `eip` on `__GNUC__ && !__STRICT_ANSI__`. badc keys `__STRICT_ANSI__`
    # off this flag as gcc does, so the kernel's own `-std=gnu11` reaches it.
    "-std=",
    # Code model: under `kernel` external addresses become the sign-extended
    # 32-bit absolutes the module loader applies, not GOT loads. badc
    # validates the value.
    "-mcmodel=",
    # Assembler options. badc checks each against what its own assembler
    # implements and rejects the rest, so an option it does not cover fails
    # the unit instead of assembling under different rules -- which is what
    # `-Wa,-mrelax-relocations=no` selects for the boot units that pass it.
    "-Wa,",
    *HARDENING_PREFIX,
)

# Flags badc has no equivalent for whose effect on the object is either
# measured to differ or not ruled out. They are not dropped quietly: every
# unit that passes one reports it (`report_unsupported`), so the count
# reaches the build's diagnostic summary rather than only the reader of this
# file.
UNSUPPORTED_EXACT = {
    # badc emits no stack-protector prologue, guard load or __stack_chk_fail
    # call, so a CONFIG_STACKPROTECTOR_STRONG kernel has no canary.
    "-fstack-protector", "-fstack-protector-all", "-fstack-protector-strong",
    # badc searches its bundled headers whatever the include flags say, so a
    # `#include <...>` the kernel means to resolve against its own tree can
    # reach a bundled one.
    "-nostdinc",
    # badc recognizes calls by libc name and folds them (strlen of a literal
    # becomes its length), which these switch off.
    "-fno-builtin", "-ffreestanding",
    # badc emits no .eh_frame, so the 64-bit vDSO units that ask for unwind
    # tables get none. The negative spelling is already what badc does.
    "-fasynchronous-unwind-tables", "-funwind-tables",
}

UNSUPPORTED_PREFIX = (
    # Where the stack-protector guard lives; part of the same gap.
    "-mstack-protector-guard",
    # badc leaves automatic storage uninitialized, so
    # CONFIG_INIT_STACK_ALL_ZERO is not in effect.
    "-ftrivial-auto-var-init=",
    # badc has no option for what an initializer leaves in padding bits.
    "-fzero-init-padding-bits=",
    # badc emits no patch site and no __fentry__ call, so ftrace has nothing
    # to patch in a unit built here.
    "-fpatchable-function-entry",
    # badc packs functions back to back (.text alignment 1), so the
    # CONFIG_FUNCTION_ALIGNMENT the kernel states does not hold.
    "-fmin-function-alignment=",
    # Which trailing arrays __builtin_object_size treats as bounded, hence
    # what the FORTIFY_SOURCE checks are computed against.
    "-fstrict-flex-arrays=",
    # As -fno-builtin, per function.
    "-fno-builtin-",
)

# Flags measured to leave badc's object unchanged, with the measurement.
# Nothing outside these lists may be dropped: `rewrite` reports an unlisted
# flag and the caller fails the unit, so a new kernel flag cannot change what
# is compiled without saying so.
IGNORE_EXACT = {
    # Driver bookkeeping. The shim passes its own -c.
    "-c",
    # badc performs no type-based alias analysis, deletes no null check on
    # the strength of a preceding dereference, and derives no range from
    # signed overflow being undefined, so the kernel's three relaxations are
    # already what it does.
    "-fno-strict-aliasing", "-fno-delete-null-pointer-checks",
    "-fno-strict-overflow",
    # What badc already emits: a tentative definition placed in .data rather
    # than left common, no stack probe, no .eh_frame, no stack-protector
    # prologue, one .text and one .data per object, and a frame pointer in
    # every function.
    "-fno-common", "-fno-stack-check", "-fno-stack-clash-protection",
    "-fno-asynchronous-unwind-tables", "-fno-unwind-tables",
    "-fno-function-sections", "-fno-data-sections", "-fno-stack-protector",
    "-fno-omit-frame-pointer", "-fomit-frame-pointer",
    # Anonymous members of a named struct type are accepted unconditionally,
    # which is what the kernel asks -fms-extensions for.
    "-fms-extensions",
    # Passes badc does not have: it runs no global common subexpression
    # elimination, invents no store, and turns no return-of-call into a
    # branch -- an aarch64 `return g(x)` emits BL, not B.
    "-fno-gcse", "-fno-allow-store-data-races", "-fconserve-stack",
    "-foptimize-sibling-calls", "-fno-optimize-sibling-calls",
    # Debug-info detail. badc emits one DWARF form per construct, so these
    # change nothing outside the .debug_* sections.
    "-fno-var-tracking", "-femit-struct-debug-baseonly",
    # aarch64 reserves x18 in badc's register pool on every target, so the
    # shadow-call-stack register is never allocated. Any other -ffixed- is
    # unlisted and fails the unit.
    "-ffixed-x18",
    # badc's aarch64 targets are little-endian LP64 only; -mbig-endian and
    # -mabi=ilp32 are unlisted and fail the unit rather than being assumed.
    "-mlittle-endian", "-mabi=lp64",
    # The x87 / MMX / SSE-extension subsets of what the forwarded -mno-sse
    # already selects: under it badc emits nothing from those register files.
    "-mno-80387", "-mno-fp-ret-in-387", "-mno-mmx", "-mno-3dnow",
    "-mno-sse2", "-mno-sse4a", "-mno-avx",
    # badc's System V variadic prologue is what the kernel skips setting `al`
    # for, and it addresses nothing below the stack pointer: every function
    # subtracts its frame before using it.
    "-mskip-rax-setup", "-mno-red-zone",
}

IGNORE_PREFIX = (
    "-fdiagnostics-", "-femit-struct-debug-detailed=",
    # Alignment padding the kernel asks to be dropped, which badc emits none
    # of. The alignment it asks to be added is unsupported, above.
    "-falign-",
    # Instruction selection. badc's backends emit the base architecture, so
    # the baseline these name is what a unit already gets.
    "-march=", "-mtune=",
    # 32-bit calling convention and stack alignment. Only the -m16 / -m32
    # units carry them, and of those only the hand-written assembly reaches
    # badc -- the C ones go to the real compiler -- where neither applies.
    "-mregparm=", "-mpreferred-stack-boundary=",
)


def forwarded(a: str) -> bool:
    """True when the flag reaches badc as written."""
    return (a in FORWARD_EXACT or a in DEP_FLAG or a in HARDENING_EXACT
            or a.startswith(FORWARD_PREFIX) or a.startswith(DEP_WP_PREFIX))


def unsupported(a: str) -> bool:
    """True when badc has no equivalent and the object differs without it."""
    return a in UNSUPPORTED_EXACT or a.startswith(UNSUPPORTED_PREFIX)


def ignorable(a: str) -> bool:
    """True when the flag is deliberately not forwarded.

    `-W` is gcc's diagnostic namespace apart from three pass-throughs: `-Wa,`
    is forwarded above, `-Wl,` cannot reach a `-c` compile, and a `-Wp,`
    option reaches the preprocessor, so an unlisted one is answered rather
    than assumed inert."""
    if a.startswith("-Wp,"):
        return False
    if a.startswith("-W") and not a.startswith("-Wa,"):
        return True
    return a in IGNORE_EXACT or a.startswith(IGNORE_PREFIX)


class Rewritten(NamedTuple):
    """The badc flag set, plus what the shim did not forward: `dropped`
    listed in UNSUPPORTED_*, `unknown` matching no list at all."""
    argv: list[str]
    dropped: list[str]
    unknown: list[str]


def rewrite(argv: list[str]) -> Rewritten:
    out: list[str] = []
    dropped: list[str] = []
    unknown: list[str] = []
    opt: str | None = None
    debug = False
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
        elif a in DROP_ARG:
            i += 2
        elif a.startswith("-O"):
            opt = a  # last one wins, as with gcc
            i += 1
        elif a == "-g0":
            debug = False
            i += 1
        elif a in DEBUG_EXACT or a.startswith(DEBUG_PREFIX):
            # Debug info. A configuration that asks for it and gets a kernel
            # without it is a silent divergence: layout.py and any debugger
            # have nothing to read. badc spells every level and version `-g`,
            # so the request is honored at what badc emits (DWARF 4) rather
            # than dropped. CONFIG_DEBUG_INFO_NONE passes no such flag, so
            # configurations that ask for none are unaffected.
            debug = True
            i += 1
        elif forwarded(a):
            out.append(a)
            i += 1
        elif not a.startswith("-"):
            i += 1  # positional: the source (re-added by the caller)
        elif unsupported(a):
            dropped.append(a)
            i += 1
        elif ignorable(a):
            i += 1
        else:
            unknown.append(a)
            i += 1
    if opt is not None and opt != "-O0":
        out.append("-O")
    if debug:
        out.append("-g")
    return Rewritten(out, dropped, unknown)


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


def warn_log(kind: str, path: str, err: str) -> bool:
    """Append badc's diagnostics for one successful invocation, one line
    per diagnostic tagged with the unit it came from. Returns False when
    no log is configured, leaving the caller to forward them itself."""
    log = os.environ.get("BADC_WARN_LOG")
    if not log:
        return False
    lines = [f"{kind}\t{path}\t{ln.strip()}\n"
             for ln in err.splitlines() if ln.strip()]
    if lines:
        # One O_APPEND write per invocation keeps parallel jobs from
        # interleaving a unit's diagnostics with another's.
        fd = os.open(log, os.O_APPEND | os.O_CREAT | os.O_WRONLY, 0o644)
        try:
            os.write(fd, "".join(lines).encode())
        finally:
            os.close(fd)
    return True


def report_unsupported(src: str, flags: list[str]) -> None:
    """State, once per unit and per flag, that a flag the build asked for was
    not applied. It goes down the diagnostic channel so the count reaches the
    build's summary; a shim-side note only its own reader sees is what let a
    dropped mitigation stand."""
    text = "".join(f"buildcc: warning: {f} not applied: badc has no "
                   f"equivalent\n" for f in dict.fromkeys(flags))
    if not warn_log("flag", src, text):
        sys.stderr.write(text)


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


SOURCE_SUFFIXES = (".c", ".S", ".s")


def source_of(argv: list[str]) -> str | None:
    """The compiled source: a positional `.c` / `.S` / `.s` argument.

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
        if not a.startswith("-") and a.endswith(SOURCE_SUFFIXES):
            return a
        i += 1
    return None


def first_diagnostic(err: str, rc: int) -> str:
    lines = [ln for ln in err.splitlines() if ln.strip()]
    return next((ln for ln in lines if "error" in ln or "panicked" in ln),
                lines[-1] if lines else f"exit {rc}")


def main(argv: list[str]) -> int:
    real = os.environ.get("BADC_REAL_CC", "gcc")
    badc = os.environ.get("BADC")
    if argv == ["--version"] and badc:
        os.execvp(badc, [badc, "--version"])
    src = source_of(argv)
    kernel_unit = src is not None and "-c" in argv and "-D__KERNEL__" in argv
    is_asm = kernel_unit and src.endswith((".S", ".s"))
    # A 16- / 32-bit C unit stays with the real compiler; the assembly
    # equivalent is attempted so badc's own refusal reaches the manifest.
    if kernel_unit and not is_asm and ("-m16" in argv or "-m32" in argv):
        kernel_unit = False
    if not kernel_unit:
        os.execvp(real, [real, *argv])
    try:
        obj = argv[argv.index("-o") + 1]
    except (ValueError, IndexError):
        # kbuild always names the object; a kernel compile without -o is
        # some other caller's shape, so leave it to the real compiler
        # rather than guessing an output path.
        os.execvp(real, [real, *argv])
    if fallback_listed(src, obj):
        # Opt-in only, and recorded before the exec: a build that used the
        # list says so in the manifest.
        manifest("gas" if is_asm else "fallback", src, "listed")
        os.execvp(real, [real, *argv])

    if not badc:
        sys.exit("buildcc: $BADC is not set")
    target = os.environ.get("BADC_TARGET", "linux-x64")
    timeout = float(os.environ.get("BADC_TIMEOUT", "300"))

    flags = rewrite(argv)
    if flags.unknown:
        # An unclassified flag is a shim gap, not a compiler one, so no
        # fallback runs: falling back would build the unit under the flag's
        # effect and hide that this shim cannot account for it.
        detail = ("unclassified flag(s) "
                  + " ".join(dict.fromkeys(flags.unknown))
                  + "; forward them, or list them in buildcc.py's "
                    "UNSUPPORTED_* / IGNORE_* with the reason")
        manifest("fail", src, detail)
        sys.stderr.write(f"buildcc: error: {detail}\n")
        return 1
    if flags.dropped:
        report_unsupported(src, flags.dropped)

    cmd = [badc, "--gnu", "-q", "-c", f"--target={target}", "-o", obj,
           *flags.argv, src]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           timeout=timeout)
        rc, err = r.returncode, r.stderr
    except subprocess.TimeoutExpired:
        rc, err = 900, f"timeout after {timeout:.0f}s"
    if rc == 0:
        manifest("badc-asm" if is_asm else "badc", src)
        if err.strip() and not warn_log("cc", src, err):
            sys.stderr.write(err if err.endswith("\n") else err + "\n")
        return 0

    # Drop any partial object so neither make nor the fallback mistakes it
    # for a built one.
    try:
        os.unlink(obj)
    except OSError:
        pass
    first = first_diagnostic(err, rc)
    if is_asm:
        # gas assembles what badc's assembler does not yet take. The
        # manifest records which unit and why; the build carries on.
        manifest("gas", src, first)
        os.execvp(real, [real, *argv])
    # No second compiler runs for C. Put badc's diagnostic on stderr and
    # fail so the build stops at the defect.
    manifest("fail", src, first)
    sys.stderr.write(err if err.endswith("\n") else err + "\n")
    return rc or 1


def _self_test() -> int:
    """Check the flag rewrite. Pure, and the gate reaches a kernel unit
    only after a tree is configured, so it is checked where a push can
    afford to say so."""
    kept = rewrite(["-c", "-O2", "-Wall", "-D__KERNEL__", "-mcmodel=kernel",
                    "-mbranch-protection=pac-ret", "-mharden-sls=all",
                    "-fcf-protection=branch", "-mindirect-branch=thunk-extern"])
    # A mitigation reaches badc verbatim: kbuild probed it against the
    # reference compiler, so withholding it would leave the unit
    # unprotected under a configuration that says otherwise.
    for flag in ("-mbranch-protection=pac-ret", "-mharden-sls=all",
                 "-fcf-protection=branch", "-mindirect-branch=thunk-extern"):
        assert flag in kept.argv, flag
    assert "-Wall" not in kept.argv
    assert kept.unknown == [] and kept.dropped == [], kept
    for spec in ("none", "bti", "standard", "pac-ret+bti"):
        assert f"-mbranch-protection={spec}" in \
            rewrite([f"-mbranch-protection={spec}"]).argv

    # No flag leaves the shim unaccounted for. A spelling on no list is
    # `unknown`, which fails the unit rather than compiling under a
    # configuration the build did not ask for; one badc has no equivalent
    # for is `dropped`, which is reported per unit.
    assert rewrite(["-fno-such-flag"]).unknown == ["-fno-such-flag"]
    assert rewrite(["-Wp,-fno-such-flag"]).unknown == ["-Wp,-fno-such-flag"]
    for flag in ("-fstack-protector-strong", "-nostdinc",
                 "-ftrivial-auto-var-init=zero", "-fmin-function-alignment=16",
                 "-fpatchable-function-entry=16,16", "-fno-builtin-wcslen",
                 "-mstack-protector-guard=sysreg", "-ffreestanding",
                 "-fstrict-flex-arrays=3", "-fasynchronous-unwind-tables"):
        r = rewrite([flag])
        assert r.dropped == [flag] and r.unknown == [], (flag, r)
    for flag in ("-Wall", "-Werror=return-type", "-Wno-sign-compare",
                 "-fno-strict-aliasing", "-mno-red-zone", "-falign-loops=1",
                 "-march=x86-64", "-mregparm=3", "-Wl,-r", "-mlittle-endian",
                 "-mabi=lp64", "-ffixed-x18", "-fno-optimize-sibling-calls"):
        r = rewrite([flag])
        assert r == Rewritten([], [], []), (flag, r)
    # A target property badc does not implement is not assumed satisfied
    # because its opposite is: only the spelling that holds is listed.
    for flag in ("-mbig-endian", "-mabi=ilp32", "-ffixed-x9"):
        assert rewrite([flag]).unknown == [flag], flag
    assert rewrite(["-fno-PIE", "-Wa,-mrelax-relocations=no"]).argv == \
        ["-fno-PIE", "-Wa,-mrelax-relocations=no"]
    # The plain-char selection reaches badc: the kernel passes it on every
    # unit and it inverts the linux-x64 default.
    assert rewrite(["-funsigned-char"]) == Rewritten(["-funsigned-char"], [], [])
    assert rewrite(["-fsigned-char"]) == Rewritten(["-fsigned-char"], [], [])

    # Success-path diagnostics: tagged with the unit when a log is
    # configured, left to the caller to forward when none is.
    saved = os.environ.pop("BADC_WARN_LOG", None)
    try:
        assert warn_log("cc", "kernel/fork.c", "badc: warning: w\n") is False
        with tempfile.TemporaryDirectory() as d:
            path = os.path.join(d, "warnings.txt")
            os.environ["BADC_WARN_LOG"] = path
            assert warn_log("cc", "kernel/fork.c", "a\n\nb\n") is True
            with open(path) as f:
                assert f.read() == ("cc\tkernel/fork.c\ta\n"
                                    "cc\tkernel/fork.c\tb\n")
            # An unapplied flag goes down the same channel, once per
            # spelling, so the build's diagnostic summary counts it.
            os.truncate(path, 0)
            report_unsupported("mm/slub.c", ["-nostdinc", "-nostdinc"])
            with open(path) as f:
                assert f.read() == ("flag\tmm/slub.c\tbuildcc: warning: "
                                    "-nostdinc not applied: badc has no "
                                    "equivalent\n")
    finally:
        os.environ.pop("BADC_WARN_LOG", None)
        if saved is not None:
            os.environ["BADC_WARN_LOG"] = saved
    print("linux buildcc: self-test ok", flush=True)
    return 0


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        raise SystemExit(_self_test())
    raise SystemExit(main(sys.argv[1:]))
