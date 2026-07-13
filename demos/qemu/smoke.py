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

The runnable emulator is produced by linking badc's objects with the system
linker (``cc``): every object is badc's, and ``cc`` only relocates and lays out.
badc's own linker cannot yet emit the final image for this input -- it compiles
and archives the objects but the synthesizer lacks some aarch64 reloc types
(TODO). The pure badc self-link is attempted as a reported, non-gating step so
the smoke tracks progress toward full self-containment without going red.

The gate is: badc compiles every unit, and the ``cc``-linked emulator reports
its version. The emulator resolves its externals against the system glib /
zlib / libfdt shared objects.

Scope: the vendored config is per target; the aarch64 and x86_64 Linux
configs are captured. Other hosts have no vendored config and are skipped.

Override the badc binary via ``$BADC`` (default: ``target/release/badc[.exe]``)
and the system linker via ``$CC`` (default: ``cc``).
"""

from __future__ import annotations

import json
import os
import platform
import shlex
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

# badc has no <arm_neon.h>; a unit that needs it is retried with QEMU's portable
# scalar path selected instead of the host-accelerated one (see transform()).
HOST_ACCEL = "/host/include/aarch64"
HOST_GENERIC = "/host/include/generic"


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


def resolve_cc() -> str:
    """The system linker driver for the hybrid link step: ``$CC`` if set, else
    the first of cc / gcc / clang on PATH."""
    import shutil
    env = os.environ.get("CC")
    for cand in ([env] if env else []) + ["cc", "gcc", "clang"]:
        if cand and shutil.which(cand):
            return cand
    fail("no system linker found (need cc / gcc / clang on PATH, or set $CC)")
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


def transform(argv: list[str], glib_cflags: list[str], src: Path, scalar: bool) -> list[str]:
    """Rewrite a gcc compile command into badc flags. Drops the output/source/
    dependency-tracking args and the gcc-only optimization/warning flags, keeps
    the -I/-D/-U/-include set, and replaces the absolute glib includes with the
    host's. When `scalar` is set, host-accelerated include dirs are redirected to
    QEMU's portable equivalents so a unit needing <arm_neon.h> builds without it.
    """

    def remap(p: str) -> str:
        return p.replace(HOST_ACCEL, HOST_GENERIC) if scalar else p

    out: list[str] = []
    i = 1  # argv[0] is the compiler name
    while i < len(argv):
        a = argv[i]
        if a.endswith((".c", ".S", ".o")):
            i += 1
        elif a in ("-o", "-MF", "-MQ", "-MT"):
            i += 2
        elif a in ("-isystem", "-iquote", "-idirafter"):
            if argv[i + 1] not in SYS_INCLUDE:
                out += ["-I", remap(argv[i + 1])]
            i += 2
        elif a == "-include":
            out += ["-include", argv[i + 1]]
            i += 2
        elif a == "-I":
            if argv[i + 1] not in SYS_INCLUDE:
                out += ["-I", remap(argv[i + 1])]
            i += 2
        elif a.startswith("-I"):
            if a[2:] not in SYS_INCLUDE:
                out += ["-I", remap(a[2:])]
            i += 1
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
    out += ["-I", str(src / "include"), "-I", str(SHIM)]
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

    glib_cflags = [a for a in pkg_config("--cflags", "glib-2.0") if a.startswith(("-I", "-D"))]
    glib_libs = [a for a in pkg_config("--libs", "glib-2.0") if a.startswith(("-L", "-l"))]
    log(f"badc={badc} arch={arch} target=qemu-system-{arch}")

    main_o = read_objects(build_dir, stem)
    util_o = read_objects(build_dir, "libqemuutil.a")
    all_o = list(dict.fromkeys(main_o + util_o))
    by_out = index_by_output(build_dir)

    optimize = os.environ.get("BADC_QEMU_OPT") == "1"
    jobs = int(os.environ.get("BADC_QEMU_JOBS") or (os.cpu_count() or 4))
    out_dir = cache / ("objs-O" if optimize else "objs")
    out_dir.mkdir(parents=True, exist_ok=True)
    opt = ["-O"] if optimize else []

    def compile_one(obj: str) -> tuple[str, str]:
        entry = by_out.get(os.path.normpath(obj))
        if entry is None:
            return (obj, "no-entry")
        dst = out_dir / obj
        dst.parent.mkdir(parents=True, exist_ok=True)
        argv = entry.get("arguments") or shlex.split(entry["command"])
        # Retry a unit that needs <arm_neon.h> with the portable path selected.
        for scalar in (False, True):
            flags = transform(argv, glib_cflags, src_dir, scalar)
            cmd = [str(badc), "--gnu", "-q", *opt, "-c", "-o", str(dst), *flags, entry["file"]]
            r = subprocess.run(cmd, cwd=build_dir, capture_output=True, text=True)
            if r.returncode == 0:
                return (obj, "ok")
            if scalar or "arm_neon.h" not in r.stderr:
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

    # Prefer the pure badc self-link: badc's own linker over 100% badc objects.
    # It succeeds for the aarch64 config here; where the synthesizer still lacks
    # an aarch64 reloc type (TODO) the link fails and the hybrid path below takes
    # over, so the emulator is always produced. BADC_QEMU_NO_SELFLINK forces the
    # hybrid path (e.g. to exercise it on a host where the self-link works).
    binp = out_dir / f"qemu-system-{arch}"
    link_mode = None
    if os.environ.get("BADC_QEMU_NO_SELFLINK") != "1":
        pure = [str(badc), *opt, *main_paths, str(lib), *link_libs, "-o", str(binp)]
        r = subprocess.run(pure, cwd=build_dir, capture_output=True, text=True, timeout=600)
        if r.returncode == 0 and binp.is_file():
            link_mode = "pure badc self-link"
        else:
            err = ((r.stderr or "") + (r.stdout or "")).strip()
            first = next((l for l in err.splitlines() if l.strip()), "?")
            log(f"pure badc self-link: pending linker support -- {first[:160]}")

    # Hybrid fallback: badc objects, system cc as the linker. cc supplies crt
    # startup + libc and relocates/lays out badc's objects. The utility objects
    # go into a system-ar archive rather than being passed directly: libqemuutil
    # carries stub definitions (cpu_get_clock, ...) that must be pulled in only
    # when unresolved, which is archive semantics. badc's own linker reads badc's
    # --ar archive (the pure path above) but GNU ld does not, so cc gets a fresh
    # archive built with the system ar.
    if link_mode is None:
        cc = resolve_cc()
        ar = os.environ.get("AR") or "ar"
        util_paths = [str(out_dir / o) for o in util_o]
        sys_lib = out_dir / "libqemuutil-sys.a"
        sys_lib.unlink(missing_ok=True)
        r = subprocess.run([ar, "rcs", str(sys_lib), *util_paths], capture_output=True, text=True)
        if r.returncode != 0 or not sys_lib.is_file():
            fail(f"system ar of libqemuutil failed:\n{r.stderr.strip()[-800:]}")
        hybrid = [cc, *main_paths, str(sys_lib), *link_libs, "-o", str(binp)]
        r = subprocess.run(hybrid, cwd=build_dir, capture_output=True, text=True)
        if r.returncode != 0 or not binp.is_file():
            fail(f"cc link of badc objects failed:\n{r.stderr.strip()[-1500:]}")
        link_mode = f"hybrid ({os.path.basename(cc)}-linked badc objects)"

    binp.chmod(0o755)
    v = subprocess.run([str(binp), "--version"], capture_output=True, text=True)
    if "QEMU emulator version" not in v.stdout:
        fail(f"linked qemu-system-{arch} did not report a version:\n{v.stdout}\n{v.stderr}")
    log(f"link: {link_mode}")
    log(f"--version: {v.stdout.strip().splitlines()[0]}")

    maybe_boot(binp, arch)
    log(f"smoke OK [{lane}] (badc compiled {ok}/{len(all_o)} units; emulator runs)")
    return 0


def maybe_boot(binp: Path, arch: str) -> None:
    """Optional boot check: if $BADC_QEMU_KERNEL (and optionally
    $BADC_QEMU_INITRD) point at a bootable image, launch the emulator on the
    default machine and require the kernel to reach an early boot marker.
    Best-effort and off by default -- the version check is the functional gate.
    """
    kernel = os.environ.get("BADC_QEMU_KERNEL")
    if not kernel:
        return
    machine = "virt" if arch == "aarch64" else "q35"
    cpu = "cortex-a57" if arch == "aarch64" else "qemu64"
    cmd = [str(binp), "-M", machine, "-cpu", cpu, "-m", "512", "-nographic",
           "-kernel", kernel, "-append", "console=ttyAMA0 console=ttyS0"]
    initrd = os.environ.get("BADC_QEMU_INITRD")
    if initrd:
        cmd += ["-initrd", initrd]
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=60)
        out = r.stdout + r.stderr
    except subprocess.TimeoutExpired as e:
        out = (e.stdout or "") + (e.stderr or "")
    if "Linux version" in out or "Booting Linux" in out:
        log("boot: kernel reached early boot")
    else:
        fail(f"boot: kernel did not reach an early boot marker:\n{out[-1500:]}")


if __name__ == "__main__":
    raise SystemExit(main())
