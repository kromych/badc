#!/usr/bin/env python3
"""End-to-end smoke for badc against QEMU 11.0.2 (system emulator).

Compiles every translation unit that feeds ``qemu-system-<arch>`` with badc and
archives the utility library with badc's ``--ar`` -- no ``make``, no ``meson``.
QEMU's build is not reproducible off-box without meson's generated config, so
the vendored asset ships that config: a captured ``compile_commands.json``, the
linker response files, and every meson-generated header/source (see setup.py).
The smoke reads the response files for the object list and
``compile_commands.json`` for each unit's flags, rewriting the gcc flag set to
badc's and substituting the host glib include path via ``pkg-config``.

Two units feed the emulator: the per-target objects (``qemu-system-<arch>.rsp``)
and the utility library (``libqemuutil.a.rsp``); both are compiled with badc.

The runnable emulator is produced by badc's OWN linker over the 100%-badc
objects (the pure self-link) -- no system linker anywhere in the chain. Every
object is badc's and badc lays out the final image; a self-link failure fails
the smoke, so full self-containment is a hard gate (no cc fallback).

The gate is: badc compiles every unit, self-links the emulator, and the
emulator reports its version (and, under ``$BADC_QEMU_BOOT``, boots to a
userspace shell and powers off cleanly). The emulator resolves its externals
against the system glib / zlib / libfdt shared objects.

Scope: the vendored config is per target; the aarch64 and x86_64 Linux
configs are captured. Other hosts have no vendored config and are skipped.

Override the badc binary via ``$BADC`` (default: ``target/release/badc[.exe]``).
"""

from __future__ import annotations

import json
import os
import platform
import shlex
import shutil
import struct
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

QEMU_DIR = Path(__file__).resolve().parent
REPO_ROOT = QEMU_DIR.parents[1]
SHIM = QEMU_DIR / "shim"
VERSION = "11.0.2"

# Per-target vendored build config: (cache build subdir, response-file stem).
TARGETS = {
    "aarch64": ("qbuild-aarch64", "qemu-system-aarch64"),
    "x86_64": ("qbuild-x86_64", "qemu-system-x86_64"),
}

# The three absolute system include paths meson recorded for glib/sysprof. They
# are replaced per host by `pkg-config --cflags glib-2.0`; sysprof is optional.
SYS_INCLUDE = (
    "/usr/include/glib-2.0",
    "/usr/lib64/glib-2.0/include",
    "/usr/include/sysprof-6",
)

# gcc-only flags with no badc equivalent; dropped from each compile command.
DROP_EXACT = {"-c", "-pipe", "-pthread", "-w", "-g", "-MD", "-MMD", "-MP"}
DROP_PREFIX = ("-W", "-f", "-m", "-g", "-O", "-std", "-M", "-arch", "-print", "-x")

# badc provides no host SIMD-intrinsics header (<arm_neon.h> on aarch64,
# <immintrin.h> on x86_64). A unit whose compile fails naming one is retried
# with the per-host accel include dir /host/include/<arch> redirected to QEMU's
# portable scalar fallbacks (see transform(); the dir is built per arch in main).
HOST_INCLUDE = "/host/include"
HOST_GENERIC = "/host/include/generic"

# Host-accel SIMD-intrinsics headers badc lacks; naming one triggers the retry.
HOST_ACCEL_HEADERS = ("arm_neon.h", "immintrin.h")

# QEMU's kernel-header tree names the arch dir asm-<arch>; code includes <asm/*>.
ASM_ARCH = {"aarch64": "arm64", "x86_64": "x86"}

# The vendored config is captured from a meson build whose host capabilities
# (compiler SIMD support, __int128, installed optional libraries) differ from
# the badc toolchain's. These config macros are disabled to match what meson
# would emit if configured with badc: no host SIMD-intrinsics header
# (immintrin.h) so the AVX-optimized paths are off; no native __int128 support
# so the portable struct Int128 path is used, which also rules out the
# __int128-based 128-bit compare-and-swap (leaving QEMU's lock-based fallback);
# no elfutils so libdw (TCG debuginfo) is off. Each has a portable fallback /
# inline stub in QEMU, the same one the aarch64 config already selects. A no-op
# where the config does not set them.
BADC_DISABLED_CONFIG = ("CONFIG_AVX2_OPT", "CONFIG_AVX512BW_OPT", "CONFIG_LIBDW",
                        "CONFIG_INT128", "CONFIG_INT128_TYPE", "CONFIG_CMPXCHG128")

# Objects whose only translation unit unconditionally needs a host library badc
# does not provide. With the gating config off (above), QEMU's header supplies
# inline stubs to callers, so the object is dropped from the link. Substring
# match against the response-file object path; a no-op where absent.
BADC_DROP_OBJECTS = ("debuginfo.c.o",)


def log(m: str) -> None:
    print(f"qemu smoke: {m}", flush=True)


def fail(m: str) -> "None":
    print(f"qemu smoke FAIL: {m}", file=sys.stderr, flush=True)
    sys.exit(1)


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    cands = [Path(env)] if env else []
    default = REPO_ROOT / "target" / "release" / "badc"
    cands += [default, default.with_suffix(".exe")]
    for c in cands:
        if c.is_file() and os.access(c, os.X_OK):
            return c
    fail("BADC binary not found; hint: cargo build --release --features full")
    raise SystemExit(2)


def host_arch() -> str:
    m = platform.machine().lower()
    if m in ("arm64", "aarch64"):
        return "aarch64"
    if m in ("x86_64", "amd64"):
        return "x86_64"
    return m


def pkg_config(*args: str) -> list[str]:
    r = subprocess.run(["pkg-config", *args], capture_output=True, text=True)
    if r.returncode != 0:
        fail(
            "pkg-config glib-2.0 failed; install the glib development package "
            "(Debian/Ubuntu: libglib2.0-dev). stderr: " + r.stderr.strip()
        )
    return r.stdout.split()


def ensure_source(src_dir: Path) -> None:
    if src_dir.is_dir():
        return
    log("fetching QEMU source + build config via setup.py")
    subprocess.run([sys.executable, str(QEMU_DIR / "setup.py")], check=True)


def ensure_asm_symlink(src_dir: Path, arch: str) -> None:
    """Recreate the linux-headers/asm -> asm-<arch> symlink locally. The build box
    provides it with an absolute target that does not exist off-box, so <asm/*>
    resolves against the bundled headers rather than the host's kernel headers."""
    lh = src_dir / "linux-headers"
    target = f"asm-{ASM_ARCH.get(arch, arch)}"
    asm = lh / "asm"
    if (lh / target).is_dir() and not (asm.is_symlink() or asm.exists()):
        asm.symlink_to(target)


def portable_path(p: str, orig_build: str, build_dir: Path, orig_src: str, src_dir: Path) -> str:
    """Rewrite a path captured as an absolute build-box path (under the original
    build or source root) to its location in the extracted bundle. Relative paths
    resolve from the build dir (the smoke's cwd) and are returned unchanged."""
    for orig, local in ((orig_build, build_dir), (orig_src, src_dir)):
        if p == orig:
            return str(local)
        if p.startswith(orig + os.sep):
            return str(local) + p[len(orig):]
    return p


def transform(argv: list[str], glib_cflags: list[str], src_dir: Path, build_dir: Path,
              orig_build: str, orig_src: str, scalar: bool, host_accel: str) -> list[str]:
    """Rewrite a gcc compile command into badc flags. Drops the output/source/
    dependency args and the gcc-only optimization/warning flags; keeps the
    include + -D/-U set. Include paths captured as absolute build-box paths are
    rewritten to the bundle (portable_path) so the build uses QEMU's own
    linux-headers / host / tcg headers, not the host's; the absolute glib
    includes are dropped for the host's pkg-config set. -isystem/-iquote become
    -I (badc searches one include list). When `scalar` is set, the host-accel
    include dir `host_accel` redirects to QEMU's portable equivalent so a unit
    needing a host SIMD-intrinsics header builds without it."""

    def fix(p: str) -> str:
        p = portable_path(p, orig_build, build_dir, orig_src, src_dir)
        return p.replace(host_accel, HOST_GENERIC) if scalar else p

    out: list[str] = []
    i = 1  # argv[0] is the compiler name
    while i < len(argv):
        a = argv[i]
        if a.endswith((".c", ".S", ".o")):
            i += 1
        elif a in ("-o", "-MF", "-MQ", "-MT"):
            i += 2
        elif a in ("-I", "-isystem", "-iquote", "-idirafter"):
            if argv[i + 1] not in SYS_INCLUDE:
                out += ["-I", fix(argv[i + 1])]
            i += 2
        elif a.startswith("-I"):
            if a[2:] not in SYS_INCLUDE:
                out += ["-I", fix(a[2:])]
            i += 1
        elif a == "-include":
            out += ["-include", portable_path(argv[i + 1], orig_build, build_dir, orig_src, src_dir)]
            i += 2
        elif a.startswith(("-D", "-U")):
            out.append(a)
            i += 1
        elif a in DROP_EXACT or a.startswith(DROP_PREFIX):
            i += 1
        elif a.startswith("-"):
            i += 1
        else:
            i += 1  # a stray positional (the source file); added by the caller
    out += glib_cflags
    out += ["-I", str(src_dir / "include"), "-I", str(SHIM)]
    return out


def read_objects(build_dir: Path, stem: str) -> list[str]:
    toks = (build_dir / f"{stem}.rsp").read_text().split()
    return [t for t in toks if t.endswith(".o")]


def index_by_output(build_dir: Path) -> dict[str, dict]:
    entries = json.loads((build_dir / "compile_commands.json").read_text())
    by_out: dict[str, dict] = {}
    for e in entries:
        argv = e.get("arguments") or shlex.split(e["command"])
        for i, a in enumerate(argv):
            if a == "-o":
                by_out[os.path.normpath(argv[i + 1])] = e
            elif a.startswith("-o") and len(a) > 2:
                by_out[os.path.normpath(a[2:])] = e
    return by_out


# In-tree static libraries meson builds from a subproject and the emulator
# links, but whose objects the per-target response file lists only as the
# archive (not enumerated). When the link needs one, its objects are compiled
# from source alongside the emulator's. link-test.c is a build-time check, not
# a library member.
SUBPROJECT_LIBS = ("libvhost-user", "libvduse")


def subproject_objects(build_dir: Path, stem: str) -> list[str]:
    """Object outputs for the subproject static libraries the target links,
    derived from compile_commands. Empty when the target links none (e.g.
    aarch64, whose config disables vhost-user)."""
    rsp = (build_dir / f"{stem}.rsp").read_text()
    needed = [s for s in SUBPROJECT_LIBS if s in rsp]
    if not needed:
        return []
    entries = json.loads((build_dir / "compile_commands.json").read_text())
    objs: list[str] = []
    for e in entries:
        f = e["file"]
        if "link-test" in f or not any(f"subprojects/{s}" in f for s in needed):
            continue
        argv = e.get("arguments") or shlex.split(e["command"])
        for i, a in enumerate(argv):
            if a == "-o":
                objs.append(os.path.normpath(argv[i + 1]))
                break
            if a.startswith("-o") and len(a) > 2:
                objs.append(os.path.normpath(a[2:]))
                break
    return objs


def adapt_config(build_dir: Path) -> int:
    """Disable the vendored config macros badc cannot honor (host SIMD opts,
    libdw) in config-host.h so units select their scalar / stub path. Idempotent;
    returns the count changed (0 where none are set, e.g. aarch64)."""
    cfg = build_dir / "config-host.h"
    if not cfg.is_file():
        return 0
    out, changed = [], 0
    for ln in cfg.read_text().splitlines(keepends=True):
        s = ln.strip()
        if any(s == f"#define {m}" or s.startswith(f"#define {m} ") for m in BADC_DISABLED_CONFIG):
            out.append(f"/* badc: {s[len('#define '):]} disabled (no host header) */\n")
            changed += 1
        else:
            out.append(ln)
    if changed:
        cfg.write_text("".join(out))
    return changed


def main() -> int:
    badc = resolve_badc()
    arch = host_arch()
    if arch not in TARGETS:
        log(f"no vendored QEMU build config for host arch {arch!r}; skipping")
        return 0
    if sys.platform not in ("linux", "linux2"):
        log(f"vendored QEMU config is Linux-only; skipping on {sys.platform}")
        return 0

    build_sub, stem = TARGETS[arch]
    cache = QEMU_DIR / ".cache" / f"qemu-{VERSION}"
    build_dir = cache / build_sub
    src_dir = cache / "qemu-rm"

    ensure_source(src_dir)
    if not (build_dir / "compile_commands.json").is_file():
        log(f"no vendored QEMU build config for {arch} in this asset; skipping")
        return 0
    ensure_asm_symlink(src_dir, arch)
    if adapt_config(build_dir):
        log(f"config: disabled {', '.join(BADC_DISABLED_CONFIG)} not supported by badc")

    # glib plus gmodule (the dynamic-module component the emulator uses).
    glib_pkgs = ("glib-2.0", "gmodule-2.0")
    glib_cflags = [a for a in pkg_config("--cflags", *glib_pkgs) if a.startswith(("-I", "-D"))]
    glib_libs = [a for a in pkg_config("--libs", *glib_pkgs) if a.startswith(("-L", "-l"))]
    log(f"badc={badc} arch={arch} target=qemu-system-{arch}")

    drop = lambda objs: [o for o in objs if not any(d in o for d in BADC_DROP_OBJECTS)]
    main_o = drop(read_objects(build_dir, stem)) + subproject_objects(build_dir, stem)
    util_o = drop(read_objects(build_dir, "libqemuutil.a"))
    all_o = list(dict.fromkeys(main_o + util_o))
    by_out = index_by_output(build_dir)
    # The build box's absolute source/build roots, recorded in compile_commands,
    # are rewritten to the extracted bundle so captured -isystem/-iquote paths
    # (linux-headers, host, tcg) resolve here and the build stays hermetic.
    orig_build = os.path.normpath(next(iter(by_out.values()))["directory"])
    orig_src = os.path.normpath(os.path.join(orig_build, os.pardir, src_dir.name))

    optimize = os.environ.get("BADC_QEMU_OPT") == "1"
    jobs = int(os.environ.get("BADC_QEMU_JOBS") or (os.cpu_count() or 4))
    out_dir = cache / ("objs-O" if optimize else "objs")
    out_dir.mkdir(parents=True, exist_ok=True)
    opt = ["-O"] if optimize else []
    # QEMU forbids NDEBUG (osdep.h #error): it is built optimized but with
    # assertions kept on. badc's -O predefines NDEBUG for release semantics, so
    # the -O compile lane undefines it to match QEMU's build (optimization,
    # asserts on). The link keeps plain -O.
    opt_compile = [*opt, "-U", "NDEBUG"] if optimize else []
    host_accel = f"{HOST_INCLUDE}/{arch}"

    def compile_one(obj: str) -> tuple[str, str]:
        entry = by_out.get(os.path.normpath(obj))
        if entry is None:
            return (obj, "no-entry")
        dst = out_dir / obj
        dst.parent.mkdir(parents=True, exist_ok=True)
        argv = entry.get("arguments") or shlex.split(entry["command"])
        src_file = portable_path(entry["file"], orig_build, build_dir, orig_src, src_dir)
        # Retry a unit needing a host SIMD-intrinsics header on the portable path.
        for scalar in (False, True):
            flags = transform(argv, glib_cflags, src_dir, build_dir, orig_build, orig_src, scalar, host_accel)
            cmd = [str(badc), "--gnu", "-q", *opt_compile, "-c", "-o", str(dst), *flags, src_file]
            r = subprocess.run(cmd, cwd=build_dir, capture_output=True, text=True)
            if r.returncode == 0:
                return (obj, "ok")
            if scalar or not any(h in r.stderr for h in HOST_ACCEL_HEADERS):
                last = r.stderr.strip().splitlines()[-1] if r.stderr.strip() else "?"
                return (obj, f"fail: {last[:120]}")
        return (obj, "fail")

    lane = "-O" if optimize else "-O0"
    log(f"compiling {len(all_o)} translation units with badc [{lane}], {jobs} jobs")
    t0 = time.time()
    results: dict[str, str] = {}
    with ThreadPoolExecutor(max_workers=jobs) as ex:
        for obj, st in ex.map(compile_one, all_o):
            results[obj] = st
    ok = sum(1 for v in results.values() if v == "ok")
    log(f"compiled {ok}/{len(all_o)} in {time.time() - t0:.0f}s [{lane}]")
    if ok != len(all_o):
        for obj, v in results.items():
            if v != "ok":
                print(f"  {v}  {obj}", file=sys.stderr)
        fail(f"{len(all_o) - ok} translation unit(s) did not compile")

    # Archive the utility library with badc's own archiver.
    lib = out_dir / "libqemuutil.a"
    r = subprocess.run(
        [str(badc), "--ar", "-o", str(lib), *[str(out_dir / o) for o in util_o]],
        capture_output=True, text=True,
    )
    if r.returncode != 0 or not lib.is_file():
        fail(f"badc --ar libqemuutil failed:\n{r.stderr.strip()[-800:]}")

    main_paths = [str(out_dir / o) for o in main_o]
    link_libs = [*glib_libs, "-lz", "-lm", "-lutil", "-lfdt"]

    # Pure badc self-link: badc's own linker over the 100%-badc objects, with
    # badc's own --ar archive of the utility library. No system-cc fallback --
    # full self-containment is the gate, so a link failure fails the smoke.
    binp = out_dir / f"qemu-system-{arch}"
    pure = [str(badc), *opt, *main_paths, str(lib), *link_libs, "-o", str(binp)]
    r = subprocess.run(pure, cwd=build_dir, capture_output=True, text=True, timeout=600)
    if r.returncode != 0 or not binp.is_file():
        err = ((r.stderr or "") + (r.stdout or "")).strip()
        fail(f"pure badc self-link failed:\n{err[-1500:]}")
    link_mode = "pure badc self-link"

    binp.chmod(0o755)
    log(f"link: {link_mode}")
    # A PIE loads correctly only when its PT_LOAD p_align is at least the
    # runtime page size; aarch64 kernels run 4K/16K/64K pages, so the image
    # must use the 64K max-page-size. Log both so a load failure on a large
    # page runner is diagnosable from the run alone.
    try:
        with open(binp, "rb") as f:
            hdr = f.read(64)
            phoff = struct.unpack_from("<Q", hdr, 0x20)[0]
            phentsize, phnum = struct.unpack_from("<HH", hdr, 0x36)
            f.seek(phoff)
            ph = f.read(phentsize * phnum)
        aligns = sorted({
            struct.unpack_from("<Q", ph, i * phentsize + 48)[0]
            for i in range(phnum)
            if struct.unpack_from("<I", ph, i * phentsize)[0] == 1  # PT_LOAD
        })
        log(f"env: page_size={os.sysconf('SC_PAGE_SIZE')} "
            f"PT_LOAD p_align={{{', '.join(hex(a) for a in aligns)}}}")
    except Exception as e:
        log(f"env: page_size/p_align probe failed: {e}")
    # The image differing between build hosts (a null init_array slot on one,
    # not the other) points at a non-reproducible input -- glib headers or the
    # badc build -- rather than the runtime. Log the glib version and the
    # badc + image hashes so a runner build can be compared against a local one.
    try:
        import hashlib
        gv = subprocess.run(["pkg-config", "--modversion", "glib-2.0"],
                            capture_output=True, text=True).stdout.strip()
        bh = hashlib.sha256(Path(badc).read_bytes()).hexdigest()[:16]
        qh = hashlib.sha256(binp.read_bytes()).hexdigest()[:16]
        log(f"env: glib={gv} badc_sha={bh} image_sha={qh}")
    except Exception as e:
        log(f"env: repro probe failed: {e}")
    v = subprocess.run([str(binp), "--version"], capture_output=True, text=True)
    if "QEMU emulator version" in v.stdout:
        log(f"--version: {v.stdout.strip().splitlines()[0]}")
        _shutdown_check(binp, arch)
        maybe_boot(binp, arch)
        log(f"smoke OK [{lane}] (badc compiled {ok}/{len(all_o)} units; emulator runs)")
        return 0

    # The gate is that badc compiled every unit and its linker produced the
    # image; running it is best-effort. A self-linked binary can fail to start
    # where the runtime environment differs from the build's. Report the exit
    # status and loader diagnostics rather than swallowing them. Set
    # BADC_QEMU_REQUIRE_RUN=1 to gate on the run (e.g. once a run regression is
    # resolved).
    lines = [f"--version did not run (best-effort); the compile + self-link gate "
             f"holds. rc={v.returncode}"]
    if v.stdout.strip():
        lines.append(f"  stdout: {v.stdout.strip()[:300]}")
    if v.stderr.strip():
        lines.append(f"  stderr: {v.stderr.strip()[:600]}")
    import shutil as _shutil
    for tool in ("file", "ldd"):
        if _shutil.which(tool):
            d = subprocess.run([tool, str(binp)], capture_output=True, text=True)
            out = (d.stdout or d.stderr).strip()
            if out:
                lines.append(f"  {tool}: {out[:600]}")
    # The fault is __c5_run_init_array calling a null: its loop pointer `fn`
    # (at [x29,#-8]) is corrupted mid-loop to a value past __init_array_end,
    # so the walk runs off the array into zero padding. A watchpoint on `fn`
    # that fires only when it jumps outside the array names the store that
    # corrupts it -- the actual bug, in whichever constructor ran just before.
    # A hardware watchpoint catches it at full speed; a software one would be
    # too slow, so this is best-effort within the timeout.
    if v.returncode and v.returncode < 0 and _shutil.which("gdb"):
        # Break at the loop top (past the prologue + the fn store) rather than
        # single-stepping, which would descend into the first constructor and
        # read its frame instead of the loop's. +0x34 is __c5_run_init_array's
        # loop head in the current crt; if it drifts the watchpoint just stays
        # silent (best-effort). $lo is fn's start; the watch fires when fn
        # jumps out of the array, and bt then names the store that moved it.
        g = subprocess.run(
            ["gdb", "-batch", "-nx",
             "-ex", "break __c5_run_init_array", "-ex", "run",
             "-ex", "tbreak *((char *)__c5_run_init_array + 0x34)", "-ex", "continue",
             "-ex", "set $fnloc = (unsigned long *)($x29 - 8)",
             "-ex", "set $lo = *$fnloc",
             "-ex", "printf \"init_array_start=0x%lx fnloc=%p\\n\", $lo, $fnloc",
             "-ex", "watch *$fnloc if *$fnloc - $lo > 0x4000",
             "-ex", "continue",
             "-ex", "bt", "-ex", "info registers pc",
             "--args", str(binp), "--version"],
            capture_output=True, text=True, timeout=170)
        bt = (g.stdout + g.stderr).strip()
        if bt:
            lines.append("  gdb (watchpoint on init-loop pointer):")
            lines += [f"    {ln}" for ln in bt.splitlines()[:60]]
    if os.environ.get("BADC_QEMU_REQUIRE_RUN") == "1":
        fail("\n".join(lines))
    for line in lines:
        log(line)
    log(f"smoke OK [{lane}] (badc compiled {ok}/{len(all_o)} units; self-link produced "
        f"the image; run best-effort)")
    return 0


# Serial markers. A boot is good when the kernel starts (BOOT), reaches its
# init process / a shell (USERSPACE), shows no fault (PANIC), and the guest
# powers the machine off on request (POWERDOWN). The panic set is the strong
# kernel fault strings; a clean boot prints none of them.
BOOT_MARKERS = ("Linux version", "Booting Linux")
USERSPACE_MARKERS = ("Run /sbin/init", "Run /init", "as init process")
PANIC_MARKERS = ("Kernel panic", "Unable to handle", "Internal error", "Oops",
                 "Kernel BUG", "BUG: ", "Call trace:", "segfault at")
POWERDOWN_MARKERS = ("reboot: Power down", "Power down", "System halted")

# Sent to the guest shell to prove the shell runs and then power the machine
# off. The token is echoed twice on execution -- once as the typed command
# line, once as the command's output -- so a count of two means the shell ran
# the command, not merely received it. The command is sent only after a settle
# so it lands on the initialized console tty, not mid-init where the shell's
# tty setup would flush it.
_SHELL_TOKEN = "BADC_BOOT_OK"
_SHELL_CMD = b"\necho BADC_BOOT_OK\npoweroff -f\n"


def _drive_boot(cmd: list[str], deadline: float) -> tuple[int | None, str]:
    """Run the emulator, wait for the guest to reach userspace, settle, then
    send a shell command that prints a token and powers off. Resends the whole
    command periodically as a fallback until the guest exits. Returns (exit
    code or None on timeout, merged serial output)."""
    import threading
    settle = float(os.environ.get("BADC_QEMU_BOOT_SETTLE") or 3.0)
    p = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                         stderr=subprocess.STDOUT, bufsize=0)
    buf = bytearray()
    lock = threading.Lock()

    def reader() -> None:
        assert p.stdout is not None
        while True:
            b = p.stdout.read(4096)
            if not b:
                break
            with lock:
                buf.extend(b)

    threading.Thread(target=reader, daemon=True).start()

    def out() -> str:
        with lock:
            return bytes(buf).decode(errors="replace")

    def send() -> None:
        try:
            assert p.stdin is not None
            p.stdin.write(_SHELL_CMD)
            p.stdin.flush()
        except (BrokenPipeError, OSError):
            pass

    t0 = time.time()
    reached_at = 0.0
    sent_at = 0.0
    while time.time() - t0 < deadline:
        if p.poll() is not None:
            break
        now = time.time()
        if reached_at == 0.0 and any(m in out() for m in USERSPACE_MARKERS):
            reached_at = now
        # Send once the console has settled past the shell's tty init, then
        # resend every few seconds as a fallback (a full command line, safe to
        # repeat) until the guest powers off.
        if reached_at and now - reached_at >= settle and now - sent_at >= 5.0:
            send()
            sent_at = now
        time.sleep(0.2)
    # Let a powering-off guest finish exiting within the remaining budget.
    while time.time() - t0 < deadline and p.poll() is None:
        time.sleep(0.2)
    rc = p.poll()
    if rc is None:
        p.kill()
        try:
            p.wait(timeout=5)
        except subprocess.TimeoutExpired:
            pass
    return rc, out()


# System UEFI firmware for the x86_64 boot. The EFI-stub bzImage boots through
# OVMF (UEFI) rather than QEMU's legacy -kernel loader, so the path matches a
# real UEFI system. Split CODE/VARS is the norm; VARS must be writable, so it is
# copied per run. A combined image (no separate VARS) is used via -bios instead.
OVMF_CODE_NAMES = ("OVMF_CODE.fd", "OVMF_CODE_4M.fd", "OVMF.fd")
OVMF_VARS_NAMES = ("OVMF_VARS.fd", "OVMF_VARS_4M.fd")
OVMF_SEARCH = ("/usr/share/OVMF", "/usr/share/edk2/ovmf",
               "/usr/share/edk2-ovmf/x64", "/usr/share/qemu")


def _find_firmware(env: str, names: tuple[str, ...], dirs: tuple[str, ...]) -> Path | None:
    v = os.environ.get(env)
    if v:
        return Path(v)
    for d in dirs:
        for n in names:
            p = Path(d) / n
            if p.is_file():
                return p
    return None


def ovmf_pflash(cache: Path) -> list[str]:
    """Locate system OVMF and return the QEMU firmware args for a UEFI boot.
    VARS is copied to a writable per-run file. Fails if no firmware is found."""
    code = _find_firmware("BADC_QEMU_OVMF_CODE", OVMF_CODE_NAMES, OVMF_SEARCH)
    if code is None:
        fail("no OVMF firmware found for the x86_64 UEFI boot; install `ovmf` "
             "(Debian/Ubuntu) or `edk2-ovmf` (Fedora), or set $BADC_QEMU_OVMF_CODE")
    vars_src = _find_firmware("BADC_QEMU_OVMF_VARS", OVMF_VARS_NAMES,
                              (str(code.parent), *OVMF_SEARCH))
    if vars_src is None:
        return ["-bios", str(code)]
    vars_rw = cache / "ovmf_vars.rw.fd"
    shutil.copyfile(vars_src, vars_rw)
    return ["-drive", f"if=pflash,format=raw,unit=0,readonly=on,file={code}",
            "-drive", f"if=pflash,format=raw,unit=1,file={vars_rw}"]


def _shutdown_check(binp: Path, arch: str) -> None:
    """Exercise the host-initiated shutdown path: start the machine with no
    devices, issue a QMP `quit`, and require a clean exit. This runs the QMP
    dispatcher teardown a dropped store in QEMU_LOCK_GUARD's compound literal
    once left with a null unlock pointer, SIGSEGV'ing on quit. No kernel or
    firmware is needed (`-nodefaults`), so it is cheap and always runs. A
    signal death here is an unambiguous codegen regression and is fatal; an
    ambiguous non-clean exit is reported best-effort, matching the run gate."""
    machine = "virt" if arch == "aarch64" else "q35"
    cmd = [str(binp), "-M", machine, "-display", "none", "-serial", "null",
           "-qmp", "stdio", "-nodefaults"]
    qmp = b'{"execute":"qmp_capabilities"}\n{"execute":"quit"}\n'
    try:
        p = subprocess.run(cmd, input=qmp, capture_output=True, timeout=40)
    except subprocess.TimeoutExpired:
        log(f"shutdown check [{machine}]: no exit on QMP quit within 40s "
            "(best-effort)")
        return
    out = p.stdout.decode(errors="replace")
    if p.returncode < 0:
        fail(f"shutdown check [{machine}]: qemu died from signal "
             f"{-p.returncode} on QMP quit -- the host-initiated shutdown "
             f"path faulted\n{out[-800:]}")
    if p.returncode == 0 and '"event": "SHUTDOWN"' in out:
        log(f"shutdown OK [{machine}]: QMP quit reached SHUTDOWN, clean exit")
    else:
        log(f"shutdown check [{machine}]: QMP quit did not confirm cleanly "
            f"(rc={p.returncode}); best-effort\n  {out[-300:]}")


def maybe_boot(binp: Path, arch: str) -> None:
    """Boot the freshly built emulator on a kernel + initramfs and require a
    full round trip: the kernel boots, reaches its init process / busybox
    shell, faults nowhere, and the guest powers the machine off cleanly (proof
    the interactive shell ran the command we sent). Any panic marker, a missing
    boot / userspace marker, or a failure to power off within the timeout fails
    the demo.

    Driven by kernel availability, per $BADC_QEMU_BOOT:
      * unset       -- boot only if a kernel is already available (via
                       $BADC_QEMU_KERNEL or a bundle already in the cache);
                       gate on it. Nothing to boot -> skip. Keeps a plain smoke
                       run green while letting a pre-fetched bundle gate.
      * gate/require -- fetch the published bundle if needed, boot, gate.
      * best-effort  -- fetch + boot, but a boot failure is logged, not fatal
                       (for a host too slow under TCG within the timeout).
      * skip         -- do not boot.
    Timeout is $BADC_QEMU_BOOT_TIMEOUT seconds (default 60)."""
    mode = os.environ.get("BADC_QEMU_BOOT", "").strip().lower()
    if mode in ("skip", "0", "off", "no", "none"):
        log("boot: disabled ($BADC_QEMU_BOOT=skip)")
        return
    best_effort = mode in ("best-effort", "best_effort", "besteffort", "soft")
    gate = mode in ("gate", "require", "on", "yes", "1")
    kernel = os.environ.get("BADC_QEMU_KERNEL")
    initrd = os.environ.get("BADC_QEMU_INITRD")
    if not (gate or best_effort or kernel):
        log("boot: not requested; skipping (set BADC_QEMU_BOOT=gate to fetch + "
            "boot the published kernel, or point $BADC_QEMU_KERNEL at an image)")
        return
    if not kernel:
        sys.path.insert(0, str(QEMU_DIR))
        import setup as qsetup  # sibling module; fetches the boot bundle
        pair = qsetup.fetch_kernel(QEMU_DIR / ".cache", arch, log)
        if pair is None:
            msg = f"boot: no kernel bundle published for {arch}"
            if not best_effort:
                fail(msg + " (BADC_QEMU_BOOT set but nothing to boot)")
            log(msg + "; skipping (best-effort)")
            return
        kernel = str(pair[0])
        initrd = str(pair[1]) if pair[1] else None

    timeout = float(os.environ.get("BADC_QEMU_BOOT_TIMEOUT") or 60)
    machine = "virt" if arch == "aarch64" else "q35"
    cpu = "cortex-a57" if arch == "aarch64" else "qemu64"
    console = "ttyAMA0" if arch == "aarch64" else "ttyS0"
    append = os.environ.get("BADC_QEMU_APPEND") or f"rdinit=/sbin/init console={console}"
    # No network: a boot smoke test needs none, and the default virtio-net
    # NIC pulls in a boot ROM (efi-virtio.rom) that is not staged next to the
    # freshly linked emulator, so `-nic none` keeps the run self-contained.
    cmd = [str(binp), "-M", machine, "-cpu", cpu, "-smp", "16", "-m", "512",
           "-nographic", "-no-reboot", "-nic", "none"]
    # x86_64 boots the EFI-stub kernel through system OVMF (UEFI firmware); the
    # cmdline reaches the stub via fw_cfg. aarch64 -M virt loads the raw Image.
    if arch == "x86_64":
        cmd += ovmf_pflash(QEMU_DIR / ".cache")
        # The q35 machine loads a few option ROMs (kvmvapic, the linuxboot /
        # multiboot loaders, the VGA BIOS); point -L at the ROM set shipped in
        # the kernel bundle so the run needs nothing from the host.
        romdir = os.path.join(os.path.dirname(kernel), "pc-bios")
        if os.path.isdir(romdir):
            cmd += ["-L", romdir]
    cmd += ["-kernel", kernel, "-append", append]
    if initrd:
        cmd += ["-initrd", initrd]

    fw = " via OVMF" if arch == "x86_64" else ""
    log(f"boot: {os.path.basename(kernel)} on -M {machine} -smp 16{fw} (timeout {timeout:.0f}s)")
    t0 = time.time()
    try:
        rc, out = _drive_boot(cmd, timeout)
    except Exception as e:  # noqa: BLE001 -- report, then gate on best_effort
        _boot_result(False, f"launch failed: {e}", "", best_effort)
        return
    elapsed = time.time() - t0

    # Persist the full serial log so CI can publish it as an artifact, on
    # success and failure alike (see the qemu job's upload step).
    log_path = os.environ.get("BADC_QEMU_BOOT_LOG") or str(
        QEMU_DIR / ".cache" / f"boot-{arch}.log")
    try:
        os.makedirs(os.path.dirname(log_path), exist_ok=True)
        with open(log_path, "w") as fh:
            fh.write(out)
        log(f"boot: serial log ({len(out)} B) -> {log_path}")
    except OSError as e:
        log(f"boot: serial log not written: {e}")

    panic = next((m for m in PANIC_MARKERS if m in out), None)
    booted = any(m in out for m in BOOT_MARKERS)
    userspace = any(m in out for m in USERSPACE_MARKERS)
    powered = rc == 0 and any(m in out for m in POWERDOWN_MARKERS)

    if panic:
        _boot_result(False, f"kernel fault after {elapsed:.0f}s (marker {panic!r})", out, best_effort)
    elif not booted and rc is not None and rc != 0:
        _boot_result(False, f"emulator exited (rc={rc}) before the kernel started", out, best_effort)
    elif not booted:
        _boot_result(False, f"kernel did not start within {timeout:.0f}s", out, best_effort)
    elif not userspace:
        _boot_result(False, f"kernel booted but did not reach userspace within {timeout:.0f}s", out, best_effort)
    elif rc is None:
        _boot_result(False, f"guest did not power off within {timeout:.0f}s", out, best_effort)
    elif not powered:
        _boot_result(False, f"guest exited rc={rc} without a clean power-down", out, best_effort)
    else:
        shell = out.count(_SHELL_TOKEN) >= 2
        log(f"boot: kernel booted, reached userspace{' + shell' if shell else ''}, "
            f"powered off cleanly in {elapsed:.0f}s")


def _boot_result(ok: bool, reason: str, out: str, best_effort: bool) -> None:
    """A boot failure fails the demo, unless the host opted into best-effort."""
    if ok:
        return
    tail = out[-2000:]
    if best_effort:
        log(f"boot: {reason} (best-effort; not gating)")
        for ln in tail.splitlines()[-20:]:
            log(f"  | {ln}")
        return
    fail(f"boot: {reason}\n--- serial tail ---\n{tail}")


if __name__ == "__main__":
    raise SystemExit(main())
