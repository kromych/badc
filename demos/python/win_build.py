#!/usr/bin/env python3
"""Build the CPython 3.14.6 core interpreter for windows-x64 with badc.

Unlike the POSIX ``smoke.py`` this harness does not scrape a ``make`` build
trace: the Windows build is driven by MSVC ``PCbuild/*.vcxproj`` files, not
``configure``/``make``, so there is no per-translation-unit command list to
read back. The translation-unit set is instead constructed from
``PCbuild/pythoncore.vcxproj`` (the core project) and compiled with a flag
set derived from ``PC/pyconfig.h``.

The interpreter is linked as a single static ``python.exe`` (no
``pythonXX.dll``): every standard-library C module is a builtin
(``Py_BUILD_CORE_BUILTIN`` + the ``PC/config.c`` inittab), so no extension
``.pyd`` is loaded and the C-API need not be exported from the image. The
result imports Windows system DLLs only (kernel32 / msvcrt / ucrtbase).

The derived sources the release tarball omits -- the frozen-module headers
``Python/frozen_modules/*.h`` -- are produced by a host ``configure``/``make``
(see ``smoke.py``); they hold portable marshalled bytecode and are valid for
the Windows interpreter. Run that host build once before this harness.

badc cross-compiles windows-x64 PE from any host, so the compile and link
stages run on the build host; the produced ``python.exe`` runs on Windows.
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
PY_DIR = Path(__file__).resolve().parent
VERSION = "3.14.6"
# X.Y form used for sys.winver and MS_DLL_ID (PC/dl_nt.c convention).
WINVER_XY = VERSION.rsplit(".", 1)[0]
SRC = PY_DIR / ".cache" / f"Python-{VERSION}"
TARGET = os.environ.get("BADC_PY_TARGET", "windows-x64")

# Translation units excluded from the minimal static interpreter. zlib needs
# the vendored zlib-ng; the SIMD HACL variants need AVX intrinsics and the
# scalar Blake2b/Blake2s cover the same hashes.
EXCLUDE = {
    "Modules/zlibmodule.c",
    "Modules/_hacl/Hacl_Hash_Blake2b_Simd256.c",
    "Modules/_hacl/Hacl_Hash_Blake2s_Simd128.c",
    # Not in the test slice; each needs a separate badc feature:
    # mmap uses SEH (__try/__except); cmath has a nested-aggregate
    # initializer badc does not yet accept. Their inittab entries are
    # dropped at link time accordingly.
    "Modules/mmapmodule.c",
    "Modules/cmathmodule.c",
    # The _hmac HACL source uses a compound literal with a nested
    # positional union initializer that badc does not yet parse; _hmac
    # is not in the test slice. TODO: support the compound-literal form.
    "Modules/hmacmodule.c",
    "Modules/_hacl/Hacl_Streaming_HMAC.c",
}

# Translation units built into the core on Windows that pythoncore.vcxproj
# does not list (their MSVC builds ship as separate .pyd projects), each
# paired with its PyInit_* symbol. wire_builtin_inittab() registers them in
# PC/config.c; the inittab key is the symbol minus the PyInit_ prefix.
ADDITIONAL_TUS = [
    ("Modules/socketmodule.c", "PyInit__socket"),
    ("Modules/unicodedata.c", "PyInit_unicodedata"),
    ("Modules/overlapped.c", "PyInit__overlapped"),
    ("Modules/selectmodule.c", "PyInit_select"),
]

# Core defines. MS_WIN32/MS_WINDOWS come from PC/pyconfig.h; MS_WIN64 is gated
# on _MSC_VER/__MINGW32__ there, neither of which badc presents, so set it
# directly. Py_NO_ENABLE_SHARED selects the static (non-DLL) core.
# MS_COREDLL (kept independent of Py_ENABLE_SHARED so no DLL import/export
# decoration is introduced) re-enables sysmodule.c's sys.winver / sys.dllhandle
# registration, which the static core otherwise omits; site.py reads sys.winver
# at startup. MS_DLL_ID is the X.Y version string (pythoncore.vcxproj passes the
# same), also consumed by getpath.c PYWINVER. The two globals it names live in
# win_excluded_stubs.c.
DEFINES = [
    "Py_BUILD_CORE",
    "Py_BUILD_CORE_BUILTIN",
    "Py_NO_ENABLE_SHARED",
    "WIN32",
    "MS_WINDOWS",
    "MS_WIN64",
    "MS_COREDLL",
    f'MS_DLL_ID="{WINVER_XY}"',
    'VPATH="."',
]

# PC must precede the source root so PC/pyconfig.h wins over the POSIX
# pyconfig.h the host configure left at the root.
INCLUDE_DIRS = [
    "PC",
    "Include",
    "Include/internal",
    "Python",
    "Modules",
    "Modules/_hacl",
    "Modules/_hacl/include",
    ".",
]

# getpath.c reads the install layout from these macros (PCbuild passes them
# per-file). Bytes-only placeholders; the runtime path comes from PYTHONHOME.
GETPATH_DEFINES = [
    "PREFIX=NULL",
    "EXEC_PREFIX=NULL",
    'VERSION="3.14"',
    'VPATH="."',
    'PLATLIBDIR="DLLs"',
    'PYDEBUGEXT=""',
]


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, errors="replace", **kw)


def badc_path() -> str:
    name = "badc.exe" if os.name == "nt" else "badc"
    p = REPO_ROOT / "target" / "release" / name
    if not p.is_file():
        sys.exit(f"win_build: badc not built at {p} -- run `cargo build --release --features full`")
    return str(p)


def disable_mimalloc() -> None:
    """Mirror the POSIX ``--without-mimalloc`` for the static Windows config.

    PC/pyconfig.h hardcodes ``WITH_MIMALLOC``; mimalloc's per-thread heap
    needs a TLS-template relocation badc does not emit, and pymalloc (also
    enabled) serves instead. Idempotent: a configure does not regenerate
    PC/pyconfig.h, but a re-extract reverts it, so re-apply each run.
    """
    cfg = SRC / "PC/pyconfig.h"
    text = cfg.read_text()
    needle = "#define WITH_MIMALLOC 1"
    if needle in text:
        cfg.write_text(text.replace(needle, "/* WITH_MIMALLOC disabled (see win_build.py) */"))


def wire_builtin_inittab() -> None:
    """Register the ADDITIONAL_TUS modules in PC/config.c's inittab.

    pythoncore.vcxproj ships them as separate .pyd projects, so PC/config.c
    omits them; the static all-builtin interpreter must add the extern
    declaration and the _PyImport_Inittab entry, or the linked PyInit_* stay
    unreachable and `import` raises ModuleNotFoundError. Idempotent: a
    re-extract reverts config.c, so re-apply each run.
    """
    cfg = SRC / "PC/config.c"
    text = cfg.read_text()
    struct = "struct _inittab _PyImport_Inittab[] = {"
    term = "    {0, 0}"
    externs = "".join(
        f"extern PyObject* {sym}(void);\n"
        for _rel, sym in ADDITIONAL_TUS
        if f"extern PyObject* {sym}(void);" not in text
    )
    entries = "".join(
        f'    {{"{sym.removeprefix("PyInit_")}", {sym}}},\n'
        for _rel, sym in ADDITIONAL_TUS
        if f"{sym}}}," not in text
    )
    if externs:
        text = text.replace(struct, externs + struct, 1)
    if entries:
        text = text.replace(term, entries + term, 1)
    cfg.write_text(text)


def ensure_derived_sources() -> None:
    if not (SRC / "configure").is_file():
        sys.exit(f"win_build: source not extracted at {SRC} -- run setup.py")
    disable_mimalloc()
    wire_builtin_inittab()
    missing = [
        h for h in re.findall(r'frozen_modules/[\w.]+\.h', (SRC / "Python/frozen.c").read_text())
        if not (SRC / "Python" / h).is_file()
    ]
    if missing:
        sys.exit(
            "win_build: frozen-module headers missing (e.g. "
            f"{missing[0]}) -- run `python3 demos/python/setup.py` to fetch them"
        )


def manifest() -> list[str]:
    """Core translation units, parsed from pythoncore.vcxproj.

    Each ``<ClCompile Include="..\\Dir\\file.c"/>`` is relative to PCbuild/;
    the leading ``..`` resolves to the source root. Entries with unexpanded
    MSBuild variables (external dependencies) and the explicit EXCLUDE set are
    dropped, as are paths absent from the tree.
    """
    proj = (SRC / "PCbuild/pythoncore.vcxproj").read_text()
    rels: list[str] = []
    seen: set[str] = set()
    for raw in re.findall(r'<ClCompile\s+Include="([^"]+\.c)"', proj):
        if "$(" in raw:
            continue
        rel = raw.replace("\\", "/")
        rel = re.sub(r'^(\.\./)+', "", rel)
        if rel in EXCLUDE or rel in seen or not (SRC / rel).is_file():
            continue
        seen.add(rel)
        rels.append(rel)
    for rel, _sym in ADDITIONAL_TUS:
        if rel in EXCLUDE or rel in seen or not (SRC / rel).is_file():
            continue
        seen.add(rel)
        rels.append(rel)
    # The executable entry comes from demos/python/win_entry.c (compiled
    # separately): Programs/python.c provides wmain, which the runtime
    # stub does not call.
    return rels


def module_search_path() -> str:
    # The standard library lives under the source tree's ``Lib/``; the
    # interpreter needs it on the path to import ``encodings`` (required for
    # stdio). All C extension modules are linked as builtins here, so unlike
    # the POSIX build there is no separate extension-module directory to add.
    return str(SRC / "Lib")


# A single deep-recursion module the native interpreter must clear; the broad
# slice is a follow-up. TODO: expand to the full smoke.py TEST_SLICE.
TEST_SLICE = ["test_functools"]


def run_tests(py: Path) -> int:
    # The test suite spawns isolated child interpreters (-I), which ignore
    # PYTHONHOME; getpath then locates Lib relative to the executable. Run from
    # a copy co-located with the source tree's Lib (a prefix layout) so those
    # children find the standard library.
    exe = SRC / py.name
    shutil.copy2(py, exe)
    env = dict(os.environ, PYTHONHOME=str(SRC), PYTHONPATH=module_search_path())
    r = run([str(exe), "-c", "print(2 + 2)"], env=env, timeout=120)
    if r.returncode != 0 or r.stdout.strip() != "4":
        sys.stderr.write(r.stdout + r.stderr)
        print("win_build: interpreter failed the `print(2 + 2)` check")
        return 1
    print("win_build: interpreter runs `print(2 + 2)`")

    cmd = [str(exe), "-m", "test", "-q", *TEST_SLICE]
    r = run(cmd, cwd=SRC, env=env, timeout=1800)
    out = r.stdout + r.stderr
    print(f"win_build: test slice {' '.join(TEST_SLICE)} exit={r.returncode}")
    if r.returncode != 0:
        sys.stderr.write(out[-3000:])
        return 1
    return 0


def compile_one(badc: str, rel: str, out: Path, dbg: list[str]) -> tuple[bool, str]:
    obj = out / (rel.replace("/", "_")[:-2] + ".o")
    cmd = [badc, "--gnu", "-c", f"--target={TARGET}", "-UHAVE_GCC_UINT128_T", *dbg]
    for d in DEFINES:
        cmd.append(f"-D{d}")
    if rel == "Modules/getpath.c":
        for d in GETPATH_DEFINES:
            cmd.append(f"-D{d}")
    for inc in INCLUDE_DIRS:
        cmd += ["-I", inc]
    cmd += [rel, "-o", str(obj)]
    r = run(cmd, cwd=SRC, timeout=240)
    if r.returncode != 0:
        last = ((r.stderr or r.stdout).strip().splitlines() or [f"rc{r.returncode}"])[-1]
        return False, last[:200]
    return True, str(obj)


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("-v", "--verbose", action="store_true")
    p.add_argument("--list", action="store_true", help="print the TU manifest and exit")
    p.add_argument("--link", action="store_true", help="attempt the python.exe link after compile")
    p.add_argument("--test", action="store_true",
                   help="run the built python.exe (print check + test slice); implies --link")
    p.add_argument("--max-fail", type=int, default=40, help="failures to print")
    args = p.parse_args(argv)
    if args.test:
        args.link = True

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    ensure_derived_sources()
    tus = manifest()
    if args.list:
        for t in tus:
            print(t)
        print(f"# {len(tus)} translation units", file=sys.stderr)
        return 0

    badc = badc_path()
    out = PY_DIR / ".cache" / ("obj-win" if TARGET == "windows-x64" else f"obj-{TARGET}")
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True, exist_ok=True)
    dbg = ["-g"] if os.environ.get("BADC_PY_G") else []

    objs, fails = [], []
    for rel in tus:
        ok, info = compile_one(badc, rel, out, dbg)
        (objs if ok else fails).append(info if ok else (rel, info))
    print(f"win_build: compiled {len(objs)}/{len(tus)} TUs, {len(fails)} failed")
    for rel, err in fails[: args.max_fail]:
        print(f"  COMPILE FAIL {rel}: {err}", file=sys.stderr)
    if fails:
        return 1

    # Harness-provided sources: the console entry shim (main over the wide
    # command line) and stub init functions for the excluded builtin modules.
    for helper in ("win_entry.c", "win_excluded_stubs.c"):
        hobj = out / (helper[:-2] + ".o")
        hcmd = [badc, "--gnu", "-c", f"--target={TARGET}", "-UHAVE_GCC_UINT128_T", *dbg]
        for d in DEFINES:
            hcmd.append(f"-D{d}")
        hcmd += [str(PY_DIR / helper), "-o", str(hobj)]
        r = run(hcmd, timeout=120)
        if r.returncode != 0:
            sys.stderr.write((r.stderr or r.stdout)[-2000:])
            sys.exit(f"win_build: {helper} failed to compile")
        objs.append(str(hobj))

    if args.link:
        py = out / "python.exe"
        log(f"link -> {py}")
        r = run([badc, f"--target={TARGET}", *dbg, *objs, "-o", str(py)], timeout=900)
        if r.returncode != 0:
            sys.stderr.write((r.stderr or r.stdout)[-3000:])
            return 1
        print(f"win_build: linked {py}")
        if args.test:
            return run_tests(py)
    return 0


if __name__ == "__main__":
    sys.exit(main())
