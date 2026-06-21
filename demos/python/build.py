#!/usr/bin/env python3
"""Build CPython 3.14.6 with badc for any target, with no make/configure.

One command for every target -- macOS, Linux (x64/arm64), Windows (x64/arm64):

    python3 demos/python/build.py --target=macos-aarch64 --test

POSIX targets compile a committed per-target ``manifest.json`` (the all-builtin
link set distilled offline by gen_manifest.py from a host all-static build) with
its ``config.c`` (the builtin inittab) and ``pyconfig.h``. Windows targets parse
the core link set from ``PCbuild/pythoncore.vcxproj`` and wire the inittab in
``PC/config.c``, since the MSVC project files carry no per-file command list to
scrape. Either way setup.py provides the source and the vendored frozen-module
headers, so no target needs make. badc cross-compiles every target from any host.
"""

from __future__ import annotations

import argparse
import json
import os
import platform
import re
import shutil
import struct
import subprocess
import sys
import tempfile
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

PY_DIR = Path(__file__).resolve().parent
REPO_ROOT = PY_DIR.parents[1]
VERSION = "3.14.6"
SRC = PY_DIR / ".cache" / f"Python-{VERSION}"
# X.Y form for MS_DLL_ID / getpath PYWINVER (PC/dl_nt.c convention).
WINVER_XY = VERSION.rsplit(".", 1)[0]

EXPORT_FLAGS = ["--export-all", "--export-data"]

# --- POSIX targets ---------------------------------------------------------

# Tier 1: a fast module slice every lane (POSIX and Windows) must clear. Tier 2
# (a broader set + a pyperformance subset) runs only if tier 1 passes.
TEST_SLICE = [
    "test_grammar", "test_builtin", "test_int", "test_float",
    "test_list", "test_dict", "test_string", "test_exceptions",
    "test_functools",
]
# Broad library coverage beyond the tier-1 smoke. Every module here was
# verified to pass on the badc-built interpreter; they exercise the C
# accelerators (math, struct, array, _datetime, _decimal, _pickle, _io,
# _json's parser) and the pure-Python library. Tests that spawn isolated
# child interpreters (`-I`, e.g. json.tool's colour output) are omitted:
# an isolated child ignores PYTHONHOME and getpath cannot locate Lib
# without an install layout, which is a harness concern, not a runtime one.
TEST_TIER2 = [
    "test_math", "test_cmath", "test_collections", "test_itertools",
    "test_re", "test_struct", "test_array", "test_binascii",
    "test_datetime", "test_operator", "test_heapq", "test_bisect",
    "test_random", "test_decimal", "test_fractions", "test_complex",
    "test_set", "test_bytes", "test_str", "test_typing", "test_enum",
    "test_dataclasses", "test_contextlib", "test_copy", "test_pickle",
    "test_textwrap", "test_io",
]
# Includes common to every POSIX TU; the manifest carries any per-TU extras.
POSIX_INCLUDES = ["Include", "Include/internal", "."]

# Linux modules badc cannot yet build: ELF/process introspection.
_LINUX_EXCLUDE = [("_remote_debugging_module.c", "_remote_debugging")]
# pyconfig advertises headers badc's bundled set does not provide; undefining the
# HAVE_ macros makes the module take a supported path: select uses poll/select
# (no epoll); socket builds the common families without the
# AF_PACKET/NETLINK/CAN/VSOCK/ALG address handling.
_LINUX_UNDEF = [
    "HAVE_EPOLL", "HAVE_EPOLL_CREATE1", "HAVE_SYS_EPOLL_H",
    "HAVE_NETPACKET_PACKET_H", "HAVE_SOCKADDR_ALG",
    "HAVE_LINUX_NETLINK_H", "HAVE_LINUX_VM_SOCKETS_H", "HAVE_LINUX_TIPC_H",
    "HAVE_LINUX_QRTR_H", "HAVE_LINUX_NETFILTER_IPV4_H",
    "HAVE_LINUX_CAN_H", "HAVE_LINUX_CAN_BCM_H", "HAVE_LINUX_CAN_J1939_H",
    "HAVE_LINUX_CAN_RAW_H", "HAVE_LINUX_CAN_RAW_FD_FRAMES",
    "HAVE_LINUX_CAN_RAW_JOIN_FILTERS",
]

# --- Windows targets -------------------------------------------------------

# PC precedes the source root so PC/pyconfig.h wins over the root pyconfig.h.
_WIN_INCLUDES = [
    "PC", "Include", "Include/internal", "Python",
    "Modules", "Modules/_hacl", "Modules/_hacl/include", ".",
]
# MS_WIN32/MS_WINDOWS come from PC/pyconfig.h; MS_WIN64 is gated on
# _MSC_VER/__MINGW32__ there, neither of which badc presents, so set it directly.
# Py_NO_ENABLE_SHARED selects the static (non-DLL) core. MS_COREDLL re-enables
# sysmodule.c's sys.winver registration (site.py reads it) without DLL
# import/export decoration; MS_DLL_ID is the X.Y string. The two globals MS_DLL_ID
# names live in win_excluded_stubs.c.
_WIN_DEFINES = [
    "Py_BUILD_CORE", "Py_BUILD_CORE_BUILTIN", "Py_NO_ENABLE_SHARED",
    "WIN32", "MS_WINDOWS", "MS_WIN64", "MS_COREDLL",
    f'MS_DLL_ID="{WINVER_XY}"', 'VPATH="."',
]
# getpath.c reads the install layout from these; bytes-only placeholders, the
# runtime path comes from PYTHONHOME.
_WIN_GETPATH_DEFINES = [
    "PREFIX=NULL", "EXEC_PREFIX=NULL", 'VERSION="3.14"', 'VPATH="."',
    'PLATLIBDIR="DLLs"', 'PYDEBUGEXT=""',
]
# TUs excluded from the minimal static interpreter. zlib needs the vendored
# zlib-ng; the SIMD HACL variants need AVX intrinsics (the scalar Blake2 covers
# the same hashes); mmap uses SEH. _hmac (hmacmodule.c + Hacl_Streaming_HMAC.c)
# has no tier-2 coverage and its Windows build is not yet exercised.
# win_excluded_stubs.c provides stub PyInit_* so the PC/config.c inittab entries
# still resolve.
_WIN_EXCLUDE = {
    "Modules/zlibmodule.c",
    "Modules/_hacl/Hacl_Hash_Blake2b_Simd256.c",
    "Modules/_hacl/Hacl_Hash_Blake2s_Simd128.c",
    "Modules/mmapmodule.c",
    "Modules/hmacmodule.c",
    "Modules/_hacl/Hacl_Streaming_HMAC.c",
}
# Built into the core on Windows but shipped as separate .pyd projects by
# pythoncore.vcxproj, so PC/config.c omits them; _wire_builtin_inittab registers
# each (the inittab key is the symbol minus the PyInit_ prefix).
_WIN_ADDITIONAL_TUS = [
    ("Modules/socketmodule.c", "PyInit__socket"),
    ("Modules/unicodedata.c", "PyInit_unicodedata"),
    ("Modules/overlapped.c", "PyInit__overlapped"),
    ("Modules/selectmodule.c", "PyInit_select"),
]
# Harness sources: the console entry shim (main over the wide command line) and
# stub PyInit_* for the excluded builtins.
_WIN_HELPERS = ["win_entry.c", "win_excluded_stubs.c"]

# tier-2 test methods that fail only on the legacy-CRT gaps described at the
# Windows TARGETS entries; -i deselects each by name while the rest of its
# module runs. Shared by both Windows arches.
_WIN_CRT_IGNORE = [
    "testLdexp_denormal",
    "test_phase", "test_polar", "test_specific_values",
    "test_strftime_y2k", "test_strftime_y2k_c99",
]

TARGETS = {
    "macos-aarch64": {
        "asm_trampoline": False,
        # The hosted macOS runner does not execute binaries from the checked-out
        # workspace (the demos run from a temp directory); run_tests does too.
        "run_from_tempdir": True,
        # The captured pyconfig.h claims headers badc's bundled set does not
        # fully provide; undefine them so the module takes a supported path
        # (kqueue -> select/poll; no AF_SYSTEM kernel-control socket).
        "undef_haves": ["HAVE_KQUEUE", "HAVE_SYS_EVENT_H", "HAVE_SYS_KERN_CONTROL_H"],
        # Niche modules badc does not compile: Mach-O internals (remote
        # debugging), libuuid (_uuid), and CoreFoundation (_scproxy).
        "exclude": [
            ("_remote_debugging_module.c", "_remote_debugging"),
            ("_uuidmodule.c", "_uuid"),
            ("_scproxy.c", "_scproxy"),
        ],
    },
    "linux-x64": {
        "asm_trampoline": True,
        # badc has no x86 SSE/AVX intrinsics; build HACL's scalar BLAKE2 and drop
        # the vectorized variants (the runtime dispatch checks these macros).
        "undef_haves": _LINUX_UNDEF + ["_Py_HACL_CAN_COMPILE_VEC128", "_Py_HACL_CAN_COMPILE_VEC256"],
        "exclude": _LINUX_EXCLUDE + [
            ("Hacl_Hash_Blake2s_Simd128.c", "_blake2_simd128"),
            ("Hacl_Hash_Blake2b_Simd256.c", "_blake2_simd256"),
        ],
    },
    "linux-aarch64": {
        "asm_trampoline": True,
        "undef_haves": _LINUX_UNDEF,
        "exclude": _LINUX_EXCLUDE,
    },
    # The Windows interpreter links the legacy msvcrt.dll CRT, several of whose
    # math/time functions deviate from C99 in narrow ways. These are runtime
    # properties of the CRT, not code generation: both arches behave identically
    # and the rest of each module passes, so ignore the individual methods rather
    # than skipping whole modules.
    #   - ldexp rounds a denormal result toward zero, not to nearest
    #     (testLdexp_denormal: ldexp(6993274598585239, -1126) gives 5e-324, not
    #     1e-323). mathmodule.c recomputes errno from the operands, so the rest of
    #     test_math is unaffected.
    #   - atan2 reports EDOM for a NaN argument, contrary to C99 F.10.1.4 (the
    #     cmath source notes it "should not cause any exception"), so cmath.phase
    #     and cmath.polar raise a spurious math domain error on non-finite input
    #     (test_phase, test_polar, and test_specific_values via polar_complex).
    #   - wcsftime lacks the C99 %C/%F/%G conversion specifiers and returns ""
    #     (test_strftime_y2k, test_strftime_y2k_c99).
    # TODO: a C99-conforming CRT or a math/time shim removes every entry here.
    "windows-x64": {"windows": True, "tier2_ignore": _WIN_CRT_IGNORE},
    # arm64 also ignores test_gh_120161. The test helper spawns the interpreter
    # as a child with a sanitized environment block (neither PATH nor SystemRoot
    # present); the child's `import asyncio` then loads _overlapped, whose
    # WSAStartup initializes the Winsock provider catalog. On Windows arm64 that
    # init fails with WinError 10106 (WSAEPROVIDERFAILEDINIT) under the stripped
    # environment, while x64 tolerates it. The byte-identical interpreter imports
    # _overlapped in every normal invocation, so this is an arm64 Winsock-startup
    # property of the spawn environment, not a code-generation defect.
    "windows-arm64": {"windows": True,
                      "tier2_ignore": _WIN_CRT_IGNORE + ["test_gh_120161"]},
}


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, errors="replace", **kw)


def _compile_one(job):
    """Compile one TU in a worker process; args are plain + picklable. The
    caller has resolved the full -D / -I flags for the target. Returns
    (src, obj-path-or-None, error-or-None)."""
    badc, target, src, defs, incs, dbg, opt, out_dir, src_root = job
    obj = os.path.join(out_dir, src.replace("/", "_")[:-2] + ".o")
    # sys.version reports the build compiler; badc presents the GNU C surface
    # (__GNUC__), so name the actual compiler rather than let getcompiler.c
    # report GCC. Every target is built by badc, so this applies to all of them.
    cmd = [badc, "--gnu", "-c", f"--target={target}", "-UHAVE_GCC_UINT128_T",
           '-DCOMPILER="[badc]"', *dbg, *opt, *defs, *incs, src, "-o", obj]
    r = subprocess.run(cmd, cwd=src_root, capture_output=True, text=True, errors="replace", timeout=240)
    if r.returncode != 0:
        msg = ((r.stderr or r.stdout).strip().splitlines() or [f"rc{r.returncode}"])[-1]
        return (src, None, msg[:200])
    return (src, obj, None)


def badc_path() -> str:
    name = "badc.exe" if os.name == "nt" else "badc"
    p = REPO_ROOT / "target" / "release" / name
    if not p.is_file():
        sys.exit(f"build: badc not built at {p} -- run `cargo build --release --features full`")
    return str(p)


# --- input preparation -----------------------------------------------------

def _disable_mimalloc() -> None:
    # The distribution's PC/pyconfig.h enables WITH_MIMALLOC (the POSIX targets'
    # configure-generated pyconfig.h does not); mimalloc's per-thread heap needs
    # a TLS-template relocation badc does not emit, so pymalloc serves instead.
    cfg = SRC / "PC/pyconfig.h"
    text = cfg.read_text()
    needle = "#define WITH_MIMALLOC 1"
    if needle in text:
        cfg.write_text(text.replace(needle, "/* WITH_MIMALLOC disabled (badc) */"))


def _wire_builtin_inittab() -> None:
    # Register the additional builtins in PC/config.c: add the extern and the
    # _PyImport_Inittab entry, or the linked PyInit_* stay unreachable and
    # `import` raises ModuleNotFoundError. Idempotent (a re-extract reverts it).
    cfg = SRC / "PC/config.c"
    text = cfg.read_text()
    struct = "struct _inittab _PyImport_Inittab[] = {"
    term = "    {0, 0}"
    externs = "".join(
        f"extern PyObject* {sym}(void);\n"
        for _rel, sym in _WIN_ADDITIONAL_TUS
        if f"extern PyObject* {sym}(void);" not in text
    )
    entries = "".join(
        f'    {{"{sym.removeprefix("PyInit_")}", {sym}}},\n'
        for _rel, sym in _WIN_ADDITIONAL_TUS
        if f"{sym}}}," not in text
    )
    if externs:
        text = text.replace(struct, externs + struct, 1)
    if entries:
        text = text.replace(term, entries + term, 1)
    cfg.write_text(text)


def _fix_winsock_fd_gates() -> None:
    # On Windows a socket fd is a SOCKET handle whose value is unrelated to
    # FD_SETSIZE, so select() accepts any fd and `_PyIsSelectable_fd` is (1).
    # CPython keys both on `_MSC_VER`, but this is a platform property, not a
    # compiler one; badc presents the GNU C surface (no `_MSC_VER`) and would
    # otherwise take the POSIX path, where `select()` rejects fds >= FD_SETSIZE
    # ("filedescriptor out of range"). Widen the two gates to MS_WINDOWS, which
    # every Windows target defines. Idempotent (a re-extract reverts it).
    fileutils = SRC / "Include/internal/pycore_fileutils.h"
    text = fileutils.read_text()
    needle = "#ifdef _MSC_VER\n    /* On Windows, any socket fd can be select()-ed"
    if needle in text:
        text = text.replace(
            "#ifdef _MSC_VER\n    /* On Windows, any socket fd",
            "#if defined(_MSC_VER) || defined(MS_WINDOWS)\n    /* On Windows, any socket fd",
            1,
        )
        fileutils.write_text(text)
    elif "#if defined(_MSC_VER) || defined(MS_WINDOWS)" not in text:
        sys.exit("build: _PyIsSelectable_fd gate not found in pycore_fileutils.h")

    selectmod = SRC / "Modules/selectmodule.c"
    text = selectmod.read_text()
    needle = "#if defined(_MSC_VER)\n        max = 0;"
    if needle in text:
        text = text.replace(
            needle,
            "#if defined(_MSC_VER) || defined(MS_WINDOWS)\n        max = 0;",
            1,
        )
        selectmod.write_text(text)
    elif "#if defined(_MSC_VER) || defined(MS_WINDOWS)\n        max = 0;" not in text:
        sys.exit("build: select() fd-range gate not found in selectmodule.c")


def _check_frozen() -> None:
    missing = [
        h for h in re.findall(r'frozen_modules/[\w.]+\.h', (SRC / "Python/frozen.c").read_text())
        if not (SRC / "Python" / h).is_file()
    ]
    if missing:
        sys.exit(f"build: frozen-module headers missing (e.g. {missing[0]}) -- setup.py should fetch them")


def ensure_inputs(target: str, log) -> None:
    # setup.py fetches the source tarball and the vendored frozen-module headers
    # (no make).
    r = run([sys.executable, str(PY_DIR / "setup.py")])
    if r.returncode != 0:
        sys.stderr.write(r.stdout + r.stderr)
        sys.exit("build: setup.py failed")
    cfg = TARGETS[target]
    if cfg.get("windows"):
        # Windows derives its config from the in-tree PC/ files rather than a
        # committed manifest: disable mimalloc, wire the extra builtins into the
        # inittab, and confirm setup.py fetched the frozen headers.
        if not (SRC / "PC/pyconfig.h").is_file():
            sys.exit(f"build: source not extracted at {SRC}")
        _disable_mimalloc()
        _wire_builtin_inittab()
        _fix_winsock_fd_gates()
        _check_frozen()
        log(f"inputs ready for {target}")
        return
    tdir = PY_DIR / "targets" / target
    if not tdir.is_dir():
        sys.exit(f"build: no committed inputs for target {target} at {tdir}")
    shutil.copy2(tdir / "pyconfig.h", SRC / "pyconfig.h")
    # Undefine HAVE_ macros for headers badc's bundled set does not provide, so
    # the dependent modules take a supported path rather than failing to compile.
    undefs = cfg.get("undef_haves", [])
    if undefs:
        pc = SRC / "pyconfig.h"
        text = pc.read_text()
        for m in undefs:
            text = text.replace(f"#define {m} 1\n", f"/* badc: {m} unsupported, undefined */\n")
        pc.write_text(text)
    shutil.copy2(tdir / "config.c", SRC / "Modules" / "config.c")
    # Drop the inittab entry and extern for each excluded module so the static
    # link has no unresolved PyInit reference.
    excl_inits = [init for _, init in cfg.get("exclude", [])]
    if excl_inits:
        cc = SRC / "Modules" / "config.c"
        keep = [
            line
            for line in cc.read_text().splitlines(keepends=True)
            if not any(
                f'"{init}", PyInit_{init}' in line or f"PyInit_{init}(void)" in line
                for init in excl_inits
            )
        ]
        cc.write_text("".join(keep))
    # Place any committed generated stdlib modules (e.g. _sysconfigdata, which a
    # host build generates and the tarball omits) onto the path.
    for f in tdir.glob("_sysconfigdata*.py"):
        shutil.copy2(f, SRC / "Lib" / f.name)
    log(f"inputs ready for {target}")


# --- source list -----------------------------------------------------------

def _win_sources() -> list[str]:
    # Core TUs from PCbuild/pythoncore.vcxproj (each <ClCompile Include=".."/> is
    # relative to PCbuild/; the leading ../ resolves to the source root). Drop
    # entries with unexpanded MSBuild variables (external deps), the EXCLUDE set,
    # and paths absent from the tree; append the extra builtins.
    proj = (SRC / "PCbuild/pythoncore.vcxproj").read_text()
    rels: list[str] = []
    seen: set[str] = set()
    for raw in re.findall(r'<ClCompile\s+Include="([^"]+\.c)"', proj):
        if "$(" in raw:
            continue
        rel = re.sub(r'^(\.\./)+', "", raw.replace("\\", "/"))
        if rel in _WIN_EXCLUDE or rel in seen or not (SRC / rel).is_file():
            continue
        seen.add(rel)
        rels.append(rel)
    for rel, _sym in _WIN_ADDITIONAL_TUS:
        if rel in _WIN_EXCLUDE or rel in seen or not (SRC / rel).is_file():
            continue
        seen.add(rel)
        rels.append(rel)
    return rels


def manifest(target: str) -> list[dict]:
    p = PY_DIR / "targets" / target / "manifest.json"
    if not p.is_file():
        sys.exit(f"build: {target} has no manifest.json -- capture it with gen_manifest.py "
                 "from a host all-static build")
    return json.loads(p.read_text())


def _entries(target: str) -> list[tuple[str, list[str], list[str]]]:
    """Per-TU ``(src, -D flags, -I flags)`` for the target."""
    cfg = TARGETS[target]
    if cfg.get("windows"):
        incs = [a for d in _WIN_INCLUDES for a in ("-I", d)]
        base = [f"-D{d}" for d in _WIN_DEFINES]
        getpath = [f"-D{d}" for d in _WIN_GETPATH_DEFINES]
        return [
            (src, base + (getpath if src == "Modules/getpath.c" else []), incs)
            for src in _win_sources()
        ]
    excl_srcs = [s for s, _ in cfg.get("exclude", [])]
    common = [a for d in POSIX_INCLUDES for a in ("-I", d)]
    out: list[tuple[str, list[str], list[str]]] = []
    for e in manifest(target):
        if any(s in e["src"] for s in excl_srcs):
            continue
        core = "Py_BUILD_CORE_BUILTIN" if e["class"] == "builtin" else "Py_BUILD_CORE"
        defs = [f"-D{core}"] + [f"-D{d}" for d in e.get("defines", [])]
        incs = common + [a for d in e.get("includes", []) for a in ("-I", d)]
        out.append((e["src"], defs, incs))
    return out


def compile_trampoline_obj(target: str, cc_kind: str, cc: str, out: Path):
    """Compile the perf-trampoline TU for targets that need it. Returns
    (object_path, error); both None when the target has no trampoline.
    perf_trampoline.c references _Py_trampoline_func_start, which lives in no
    manifest TU, so every linker of this image must add this object."""
    if not TARGETS[target].get("asm_trampoline"):
        return None, None
    tobj = out / "asm_trampoline.o"
    src = str(PY_DIR / "asm_trampoline.c")
    cmd = [cc, "-c", src, "-o", str(tobj)]
    if cc_kind == "badc":
        cmd[1:1] = [f"--target={target}"]
    r = run(cmd, timeout=120)
    if r.returncode != 0:
        return None, (r.stderr or r.stdout)
    return str(tobj), None


def build(target: str, do_link: bool, log) -> Path | None:
    cfg = TARGETS[target]
    win = bool(cfg.get("windows"))
    badc = badc_path()
    out = PY_DIR / ".cache" / f"obj-{target}"
    out.mkdir(parents=True, exist_ok=True)
    dbg = ["-g"] if os.environ.get("BADC_PY_G") else []
    opt = ["-O"] if os.environ.get("BADC_PY_O") else []

    entries = _entries(target)
    jobs = [(badc, target, src, defs, incs, dbg, opt, str(out), str(SRC)) for src, defs, incs in entries]
    objs, fails = [], []
    workers = int(os.environ.get("BADC_PY_JOBS") or (os.cpu_count() or 4))
    # ex.map preserves input order, so the object (link) order is deterministic.
    with ProcessPoolExecutor(max_workers=workers) as ex:
        for src, obj, err in ex.map(_compile_one, jobs):
            if err:
                fails.append((src, err))
            else:
                objs.append(obj)

    log(f"compiled {len(objs)}/{len(objs) + len(fails)} TUs, {len(fails)} failed")
    if fails:
        for s, e in fails[:40]:
            print(f"  COMPILE FAIL {s}: {e}", file=sys.stderr)
        sys.exit(f"build: {len(fails)} translation unit(s) failed")
    if not do_link:
        return None

    if win:
        # The console entry shim and the excluded-builtin stubs, compiled with
        # the core defines (no CPython includes needed).
        for helper in _WIN_HELPERS:
            hobj = out / (helper[:-2] + ".o")
            hcmd = [badc, "--gnu", "-c", f"--target={target}", "-UHAVE_GCC_UINT128_T", *dbg,
                    *[f"-D{d}" for d in _WIN_DEFINES], str(PY_DIR / helper), "-o", str(hobj)]
            r = run(hcmd, timeout=120)
            if r.returncode != 0:
                sys.stderr.write((r.stderr or r.stdout)[-2000:])
                sys.exit(f"build: {helper} failed to compile")
            objs.append(str(hobj))
    else:
        tobj, err = compile_trampoline_obj(target, "badc", badc, out)
        if err:
            sys.stderr.write(err)
            sys.exit("build: asm_trampoline compile failed")
        if tobj:
            objs.append(tobj)

    py = out / ("python.exe" if win else "python")
    log(f"link -> {py}")
    # The static all-builtin POSIX image exports the C-API for its own use; the
    # Windows image is fully static and needs no export decoration.
    export = [] if win else EXPORT_FLAGS
    r = run([badc, f"--target={target}", *export, *dbg, *objs, "-o", str(py)], timeout=900)
    if r.returncode != 0:
        sys.stderr.write((r.stderr or r.stdout)[-3000:])
        sys.exit("build: link failed")
    return py


def _xcrun(tool: str):
    if sys.platform != "darwin":
        return None
    r = subprocess.run(["xcrun", "--find", tool], capture_output=True, text=True)
    return r.stdout.strip() or None


def section_sizes(py: Path) -> dict:
    """text / data / bss / file bytes of a built binary. Reads the binary's own
    section / segment tables first: dependency-free and the only way to see bss
    the linker folds into a segment's virtual tail (PE `.data` VirtualSize,
    Mach-O `__DATA` vmsize), which `size` reports as data or omits. Falls back
    to an external sizer (llvm-size, then GNU `size`) for any format the reader
    rejects, then to the file size alone."""
    out = {"text": 0, "data": 0, "bss": 0, "file": py.stat().st_size}
    native = _native_section_sizes(py)
    if native and (native["text"] or native["data"] or native["bss"]):
        out.update(native)
        return out
    sizer = shutil.which("llvm-size") or _xcrun("llvm-size") or shutil.which("size")
    if sizer:
        r = subprocess.run([sizer, "--format=sysv", str(py)], capture_output=True, text=True)
        if r.returncode == 0:
            for line in r.stdout.splitlines():
                f = line.split()
                if len(f) < 2 or not f[-1].lstrip("-").isdigit():
                    continue
                name, val = f[0], int(f[1])
                low = name.lower()
                if low in ("__text", ".text") or low.endswith("text"):
                    out["text"] += val
                elif "bss" in low or "common" in low:  # Mach-O __common is zero-fill
                    out["bss"] += val
                elif low in ("__data", ".data", ".rodata", "__const") or "data" in low or "const" in low:
                    out["data"] += val
    return out


def _native_section_sizes(py: Path) -> dict | None:
    """Sum text / data / bss from a binary's own section table, dispatching on
    the format magic. Dependency-free; covers the targets badc emits (ELF,
    PE, Mach-O). Returns None when the format is unrecognized or malformed."""
    try:
        data = py.read_bytes()
        if data[:4] == b"\x7fELF":
            return _elf_section_sizes(data)
        if data[:2] == b"MZ":
            return _pe_section_sizes(data)
        if data[:4] in (b"\xcf\xfa\xed\xfe", b"\xce\xfa\xed\xfe"):
            return _macho_section_sizes(data)
    except (struct.error, IndexError, ValueError):
        return None
    return None


def _elf_section_sizes(d: bytes) -> dict | None:
    # ELF64 only (EI_CLASS == 2); the section header table at e_shoff carries
    # name / type / size, and SHT_NOBITS (8) marks .bss.
    if d[4] != 2:
        return None
    le = "<" if d[5] == 1 else ">"
    e_shoff = struct.unpack_from(le + "Q", d, 0x28)[0]
    e_shentsize = struct.unpack_from(le + "H", d, 0x3A)[0]
    e_shnum, e_shstrndx = struct.unpack_from(le + "HH", d, 0x3C)
    if not e_shoff or not e_shnum:
        return None
    strtab = struct.unpack_from(le + "Q", d, e_shoff + e_shstrndx * e_shentsize + 24)[0]
    out = {"text": 0, "data": 0, "bss": 0}
    for i in range(e_shnum):
        base = e_shoff + i * e_shentsize
        sh_name, sh_type = struct.unpack_from(le + "II", d, base)
        sh_size = struct.unpack_from(le + "Q", d, base + 32)[0]
        name = d[strtab + sh_name : d.index(b"\0", strtab + sh_name)].decode("ascii", "replace")
        if sh_type == 8:  # SHT_NOBITS
            out["bss"] += sh_size
        elif name.startswith(".text"):
            out["text"] += sh_size
        elif name.startswith((".data", ".rodata")):
            out["data"] += sh_size
    return out


def _pe_section_sizes(d: bytes) -> dict | None:
    # PE: the COFF header at e_lfanew lists the section table. A section's
    # on-disk SizeOfRawData is its initialised bytes; VirtualSize beyond that
    # is the zero-fill (bss) tail the linker folds into the section, since a
    # PE image carries no separate .bss section.
    e_lfanew = struct.unpack_from("<I", d, 0x3C)[0]
    if d[e_lfanew : e_lfanew + 4] != b"PE\x00\x00":
        return None
    coff = e_lfanew + 4
    nsec, opt = struct.unpack_from("<H", d, coff + 2)[0], struct.unpack_from("<H", d, coff + 16)[0]
    table = coff + 20 + opt
    out = {"text": 0, "data": 0, "bss": 0}
    for i in range(nsec):
        base = table + i * 40
        vsize, _vaddr, rawsize = struct.unpack_from("<III", d, base + 8)
        chars = struct.unpack_from("<I", d, base + 36)[0]
        vsize = vsize or rawsize
        if chars & 0x20:  # IMAGE_SCN_CNT_CODE
            out["text"] += vsize
        elif chars & (0x40 | 0x80):  # INITIALIZED / UNINITIALIZED data
            out["data"] += min(vsize, rawsize)
            out["bss"] += max(0, vsize - rawsize)
    return out


def _macho_section_sizes(d: bytes) -> dict | None:
    # Mach-O 64: walk the LC_SEGMENT_64 (0x19) load commands. A data segment's
    # vmsize beyond its filesize is zero-fill (bss). That covers both a folded
    # tail (no section) and any S_ZEROFILL section (type 0x1 / 0xc) that lives
    # inside it, so count it once per segment rather than per section.
    ncmds = struct.unpack_from("<I", d, 16)[0]
    off = 32
    out = {"text": 0, "data": 0, "bss": 0}
    for _ in range(ncmds):
        cmd, cmdsize = struct.unpack_from("<II", d, off)
        if cmd == 0x19:  # LC_SEGMENT_64
            segname = d[off + 8 : off + 24].split(b"\0", 1)[0].decode("ascii", "replace")
            vmsize, _fileoff, filesize = struct.unpack_from("<QQQ", d, off + 32)
            nsects = struct.unpack_from("<I", d, off + 64)[0]
            seg_bss = 0
            for s in range(nsects):
                sbase = off + 72 + s * 80
                sectname = d[sbase : sbase + 16].split(b"\0", 1)[0].decode("ascii", "replace")
                size = struct.unpack_from("<Q", d, sbase + 40)[0]
                flags = struct.unpack_from("<I", d, sbase + 64)[0]
                if flags & 0xFF in (0x1, 0xC):  # S_ZEROFILL / S_GB_ZEROFILL
                    seg_bss += size
                elif sectname.startswith("__text"):
                    out["text"] += size
                elif sectname.startswith(("__data", "__const", "__cstring", "__rodata")):
                    out["data"] += size
            # Exact bss from the zero-fill section(s); otherwise recover a
            # folded tail from the segment's virtual-minus-file size.
            if seg_bss:
                out["bss"] += seg_bss
            elif segname not in ("__PAGEZERO", "__TEXT", "__LINKEDIT") and vmsize > filesize:
                out["bss"] += vmsize - filesize
        off += cmdsize
    return out


def run_tests(target: str, py: Path, log, tier2: bool = False) -> int:
    # The suite spawns isolated child interpreters (-I) that ignore PYTHONHOME;
    # getpath locates Lib relative to the executable, so the interpreter runs
    # from a copy beside Lib. The source tree serves for that, except where the
    # runner does not execute binaries from the checked-out workspace: there the
    # copy runs from a temp directory with Lib symlinked beside it.
    cfg = TARGETS[target]
    slice_ = TEST_SLICE + TEST_TIER2 if tier2 else TEST_SLICE
    skip = set(cfg.get("tier2_skip", []))
    slice_ = [t for t in slice_ if t not in skip]
    # -i/--ignore deselects individual test methods by name (regrtest matches the
    # pattern against test ids), used for narrow platform gaps where skipping the
    # whole module would lose unrelated coverage.
    ignore = [a for pat in cfg.get("tier2_ignore", []) for a in ("--ignore", pat)]
    if cfg.get("run_from_tempdir"):
        rundir = Path(tempfile.mkdtemp(prefix="badc-cpython-"))
        exe = rundir / py.name
        (rundir / "Lib").symlink_to(SRC / "Lib")
        cwd = rundir
    else:
        exe = SRC / py.name
        cwd = SRC
    shutil.copy2(py, exe)
    os.chmod(exe, 0o755)
    env = dict(os.environ, PYTHONHOME=str(SRC), PYTHONPATH=str(SRC / "Lib"))
    r = run([str(exe), "-c", "print(2 + 2)"], env=env, timeout=120)
    if r.returncode != 0 or r.stdout.strip() != "4":
        sys.stderr.write(r.stdout + r.stderr)
        print("build: interpreter failed the `print(2 + 2)` check")
        return 1
    print("build: interpreter runs `print(2 + 2)`")
    sz = section_sizes(py)
    print(
        f"build: sections text={sz['text'] // 1024}K data={sz['data'] // 1024}K "
        f"bss={sz['bss'] // 1024}K file={sz['file'] // 1024}K"
    )
    if cfg.get("windows"):
        # A Windows socket fd is a SOCKET handle whose value is unrelated to
        # FD_SETSIZE, so select() must accept it regardless of magnitude. Open
        # sockets until one's fd reaches FD_SETSIZE (512) and select on it; the
        # POSIX fd-range gate would raise "filedescriptor out of range in
        # select()". (POSIX targets are skipped: there a high fd genuinely
        # exceeds select()'s fd_set and is not selectable.)
        smoke = (
            "import socket, select\n"
            "socks = []\n"
            "hi = None\n"
            "try:\n"
            "    for _ in range(2000):\n"
            "        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)\n"
            "        socks.append(s)\n"
            "        if s.fileno() >= 512:\n"
            "            hi = s\n"
            "            break\n"
            "    select.select([hi] if hi else [], [], [], 0)\n"
            "    print('select-high-fd-ok' if hi else 'select-high-fd-inconclusive')\n"
            "finally:\n"
            "    [s.close() for s in socks]\n"
        )
        r = run([str(exe), "-c", smoke], env=env, timeout=120)
        if r.returncode != 0 or "select-high-fd" not in r.stdout:
            sys.stderr.write(r.stdout + r.stderr)
            print("build: select() rejected a high socket fd")
            return 1
        print(f"build: {r.stdout.strip()}")
    # -w re-runs any failed test file in verbose mode, so a failure carries
    # its tracebacks into the log instead of "multiple errors occurred".
    r = run([str(exe), "-m", "test", "-q", "-w", *ignore, *slice_], cwd=str(cwd), env=env, timeout=1800)
    print(f"build: test slice {' '.join(slice_)} exit={r.returncode}")
    if r.returncode != 0:
        sys.stderr.write((r.stdout + r.stderr)[-3000:])
        return 1
    return 0


def _host_target() -> str:
    # Map the running host to its badc target so the default needs no flag.
    machine = platform.machine().lower()
    arm = machine in ("arm64", "aarch64")
    system = platform.system()
    if system == "Darwin":
        return "macos-aarch64"
    if system == "Linux":
        return "linux-aarch64" if arm else "linux-x64"
    if system == "Windows":
        return "windows-arm64" if arm else "windows-x64"
    sys.exit(f"build: unsupported host {system} / {machine}")


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--target", default=os.environ.get("BADC_PY_TARGET") or _host_target())
    p.add_argument("--link", action="store_true", help="link the interpreter")
    p.add_argument("--test", action="store_true", help="link + run the tier-1 slice")
    p.add_argument("--tier2", action="store_true",
                   help="also run the broad tier-2 library tests (implies --test)")
    p.add_argument("-v", "--verbose", action="store_true")
    args = p.parse_args(argv)

    def log(msg: str) -> None:
        print(msg, file=sys.stderr if args.verbose else sys.stdout)

    if args.target not in TARGETS:
        sys.exit(f"build: unknown target {args.target}; known: {', '.join(TARGETS)}")
    ensure_inputs(args.target, log)
    py = build(args.target, args.link or args.test or args.tier2, log)
    if args.test or args.tier2:
        return run_tests(args.target, py, log, tier2=args.tier2)
    return 0


if __name__ == "__main__":
    sys.exit(main())
