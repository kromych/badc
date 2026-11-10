#!/usr/bin/env python3
"""Build the CPython 3.15.1 Windows distribution with badc, as PCbuild does.

PCbuild's project files are the specification: ``pcbuild.proj`` names the
projects and each ``.vcxproj`` (with ``pyproject.props`` and the dependency
property sheets) its sources, preprocessor definitions, include directories
and libraries. This driver evaluates those MSBuild files for one platform and
Release configuration and runs badc where MSBuild would run cl, link and lib:

    python3 demos/python/build_sdk.py --target=windows-x64 [--projects=a,b] [--test]

Every unit compiles with ``--msvc`` against the toolchain cl uses -- the MSVC
headers (vcruntime.h, vadefs.h, ...) and the Windows SDK's ucrt, um and shared
headers -- with nothing from badc's bundled C library, and links against the
MSVC and SDK import libraries (ucrt.lib, vcruntime.lib, kernel32.lib, ...).
The outputs follow PCbuild's layout: ``PCbuild/<arch>/python315.dll``,
``python3.dll``, ``python.exe``, ``pythonw.exe``, the launchers and one
``.pyd`` per extension module, each importing from the core DLL, with the
external libraries (bzip2, xz, zlib-ng, zstd, mpdecimal, sqlite, libffi)
built from source at get_externals.bat's versions. Resource scripts go
through the SDK's rc.exe and libffi's assembly through ml64 / armasm64,
the tools MSBuild runs for them. C++ projects (_wmi, pyshellext) are not a C
compiler's input.
TODO: OpenSSL (_ssl, _hashlib) and Tcl/Tk (_tkinter) from source.

The toolchain directories come from the installed kits on a Windows host, or
from ``BADC_WINDOWS_KITS`` (the ``Windows Kits\\10`` root) and
``BADC_MSVC_TOOLS`` (a ``VC\\Tools\\MSVC\\<version>`` directory) on any host,
which makes the build a cross build from macOS or Linux. ``--test`` runs the
full regression suite with regrtest on a Windows host.
"""

from __future__ import annotations

import argparse
import hashlib
import os
import platform
import re
import shutil
import subprocess
import sys
import tarfile
import time
import urllib.request
import xml.etree.ElementTree as ET
import zipfile
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

PY_DIR = Path(__file__).resolve().parent
REPO_ROOT = PY_DIR.parents[1]
sys.path.insert(0, str(PY_DIR.parent))
import _win_kits  # noqa: E402

VERSION = "3.15.1"
CACHE = PY_DIR / ".cache" / "sdk"
# A tree of its own: build.py patches the shared extraction for its
# bundled-header build, and this build takes the sources as released.
SRC = CACHE / f"Python-{VERSION}"
PCBUILD = SRC / "PCbuild"
MS = "{http://schemas.microsoft.com/developer/msbuild/2003}"

PLATFORM = {"windows-x64": "x64", "windows-arm64": "ARM64"}
ARCHNAME = {"windows-x64": "amd64", "windows-arm64": "arm64"}

# --- external dependencies ---------------------------------------------------

# get_externals.bat's versions, fetched from each project's own release. The
# directory name is the one python.props expects under externals/.
EXTERNALS = {
    "bzip2-1.0.8": (
        "https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz",
        "ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269",
        "bzip2-1.0.8",
    ),
    "mpdecimal-4.0.0": (
        "https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-4.0.0.tar.gz",
        "942445c3245b22730fd41a67a7c5c231d11cb1b9936b9c0f76334fb7d0b4468c",
        "mpdecimal-4.0.0",
    ),
    "xz-5.2.5": (
        "https://downloads.sourceforge.net/project/lzmautils/xz-5.2.5.tar.gz",
        "f6f4910fd033078738bd82bfba4f49219d03b17eb0794eb91efbae419f4aba10",
        "xz-5.2.5",
    ),
    "zlib-ng-2.2.4": (
        "https://github.com/zlib-ng/zlib-ng/archive/refs/tags/2.2.4.tar.gz",
        "a73343c3093e5cdc50d9377997c3815b878fd110bf6511c2c7759f2afb90f5a3",
        "zlib-ng-2.2.4",
    ),
    "zstd-1.5.7": (
        "https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz",
        "eb33e51f49a15e023950cd7825ca74a4a2b43db8354825ac24fc1b7ee09e6fa3",
        "zstd-1.5.7",
    ),
    "libffi-3.4.4": (
        "https://github.com/libffi/libffi/releases/download/v3.4.4/libffi-3.4.4.tar.gz",
        "d66c56ad259a82cf2a9dfc408b32bf5da52371500b84745f7fb8b645712df676",
        "libffi-3.4.4",
    ),
    "sqlite-3.50.4.0": (
        "https://www.sqlite.org/2025/sqlite-amalgamation-3500400.zip",
        None,
        "sqlite-amalgamation-3500400",
    ),
}


def fetch_external(name: str, log) -> Path:
    url, sha, top = EXTERNALS[name]
    dest = SRC / "externals" / name
    if dest.is_dir() and any(dest.iterdir()):
        return dest
    dl = CACHE / "downloads"
    dl.mkdir(parents=True, exist_ok=True)
    archive = dl / url.rsplit("/", 1)[1]
    if not archive.is_file():
        log(f"fetching {url}")
        with urllib.request.urlopen(url, timeout=300) as r, open(archive, "wb") as f:
            shutil.copyfileobj(r, f)
    digest = hashlib.sha256(archive.read_bytes()).hexdigest()
    if sha and digest != sha:
        archive.unlink()
        sys.exit(f"build_sdk: {archive.name}: sha256 {digest}, expected {sha}")
    stage = dl / f"x-{name}"
    shutil.rmtree(stage, ignore_errors=True)
    stage.mkdir()
    if archive.suffix == ".zip":
        with zipfile.ZipFile(archive) as z:
            z.extractall(stage)
    else:
        with tarfile.open(archive) as t:
            t.extractall(stage)
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.rmtree(dest, ignore_errors=True)
    shutil.move(str(stage / top), str(dest))
    shutil.rmtree(stage, ignore_errors=True)
    return dest


# --- MSBuild evaluation --------------------------------------------------------

class Cond:
    """MSBuild condition expressions: comparisons of quoted or bare operands,
    ``!``, ``and``, ``or``, parentheses, ``Exists`` and ``HasTrailingSlash``."""

    # A property reference is one operand even when it expands to nothing
    # or to text with spaces, so the tokens are taken before expansion.
    TOKEN = re.compile(r"\s*(\$\((?:[^()]|\((?:[^()]|\([^()]*\))*\))*\)|==|!=|<=|>=|<|>|!|\(|\)|,"
                       r"|'[^']*'|`[^`]*`|[^\s=!<>(),']+)")

    def __init__(self, proj: "Project", text: str):
        self.proj = proj
        self.toks = []
        pos = 0
        while pos < len(text):
            m = self.TOKEN.match(text, pos)
            if not m:
                break
            self.toks.append(m.group(1))
            pos = m.end()
        self.i = 0

    def peek(self):
        return self.toks[self.i] if self.i < len(self.toks) else None

    def take(self):
        t = self.peek()
        self.i += 1
        return t

    def value(self) -> bool:
        v = self.or_()
        return bool(v) if not isinstance(v, str) else v.lower() == "true"

    def or_(self):
        v = self.and_()
        while (self.peek() or "").lower() == "or":
            self.take()
            r = self.and_()
            v = self.truth(v) or self.truth(r)
        return v

    def and_(self):
        v = self.not_()
        while (self.peek() or "").lower() == "and":
            self.take()
            r = self.not_()
            v = self.truth(v) and self.truth(r)
        return v

    def not_(self):
        if self.peek() == "!":
            self.take()
            return not self.truth(self.not_())
        return self.cmp()

    @staticmethod
    def truth(v) -> bool:
        return v if isinstance(v, bool) else str(v).strip().lower() == "true"

    def cmp(self):
        a = self.atom()
        op = self.peek()
        if op in ("==", "!=", "<", ">", "<=", ">="):
            self.take()
            b = self.atom()
            sa, sb = str(a).strip(), str(b).strip()
            if op in ("==", "!="):
                eq = sa.lower() == sb.lower()
                return eq if op == "==" else not eq
            try:
                fa, fb = float(sa), float(sb)
            except ValueError:
                return False
            return {"<": fa < fb, ">": fa > fb, "<=": fa <= fb, ">=": fa >= fb}[op]
        return a

    def atom(self):
        t = self.take()
        if t == "(":
            v = self.or_()
            self.take()
            return v
        if t and t[0] in "'`":
            return self.proj.expand(t[1:-1])
        if t and t.startswith("$("):
            return self.proj.expand(t)
        low = (t or "").lower()
        if low in ("exists", "hastrailingslash") and self.peek() == "(":
            self.take()
            arg = self.atom()
            self.take()
            if low == "exists":
                return bool(str(arg).strip()) and Path(self.proj.native(str(arg))).exists()
            return str(arg).rstrip().endswith(("\\", "/"))
        return t or ""


class Project:
    """One evaluated project file: its properties, item definitions and
    items for the configuration the global properties select."""

    def __init__(self, path: Path, globals_: dict[str, str], skip_imports: set[str]):
        self.path = path
        self.globals = globals_
        self.props: dict[str, str] = dict(globals_)
        self.defs: dict[str, dict[str, str]] = {}
        self.items: list[tuple[str, str, dict[str, str]]] = []
        self.skip = skip_imports
        self.imported: dict[tuple[str, int], bool] = {}
        self.props["MSBuildThisFileDirectory"] = str(path.parent) + os.sep
        # MSBuild evaluates properties, then item definitions, then items,
        # each pass over the whole file and its imports.
        for phase in ("props", "defs", "items"):
            self.load(path, phase)

    @staticmethod
    def native(p: str) -> str:
        return p.replace("\\", "/") if os.sep == "/" else p

    def prop_fn(self, expr: str) -> str:
        # `Name.Method(args)` on a property; the methods the PCbuild files use.
        m = re.fullmatch(r"(\w+)\.(\w+)\((.*?)\)(?:\[(\d+)\])?", expr)
        if not m:
            return ""
        val = self.props.get(m.group(1), "")
        meth = m.group(2)
        args = [self.expand(a.strip()).strip("`'\"") for a in m.group(3).split(",")] if m.group(3) else []
        if meth == "Split" and args and m.group(4):
            parts = val.split(args[0])
            return parts[int(m.group(4))] if int(m.group(4)) < len(parts) else ""
        if meth == "LastIndexOf" and args:
            return str(val.rfind(args[0]))
        if meth == "Substring" and args and args[0].lstrip("-").isdigit():
            start = int(args[0])
            return val[start:start + int(args[1])] if len(args) > 1 else val[start:]
        if meth == "Trim":
            return val.strip(args[0] if args else None)
        if meth == "Replace" and len(args) == 2:
            return val.replace(args[0], args[1])
        if meth in ("StartsWith", "EndsWith", "Contains"):
            f = {"StartsWith": val.startswith, "EndsWith": val.endswith,
                 "Contains": val.__contains__}[meth]
            return "true" if args and f(args[0]) else "false"
        return ""

    def expand(self, text: str, meta: dict[str, str] | None = None) -> str:
        out, i = [], 0
        while i < len(text):
            if text.startswith("$(", i) or text.startswith("%(", i):
                depth, j = 1, i + 2
                while j < len(text) and depth:
                    depth += {"(": 1, ")": -1}.get(text[j], 0)
                    j += 1
                inner = text[i + 2:j - 1]
                if text[i] == "%":
                    out.append(meta.get(inner, "") if meta is not None else text[i:j])
                elif re.fullmatch(r"\w+", inner):
                    out.append(self.props.get(inner, os.environ.get(inner, "") if inner.isupper() else ""))
                elif m := re.fullmatch(r"\[System\.Text\.RegularExpressions\.Regex\]::Match\("
                                       r"`(.*?)`,\s*`(.*?)`\)\.Groups", inner):
                    # A match's groups, as MSBuild joins a collection: by ';'.
                    found = re.search(m.group(2), self.expand(m.group(1)))
                    out.append(";".join([found.group(0), *(g or "" for g in found.groups())])
                               if found else "")
                elif inner.startswith("[System.IO.Path]::GetFullPath("):
                    arg = self.expand(inner[len("[System.IO.Path]::GetFullPath("):-1]).strip("`'")
                    out.append(os.path.normpath(self.native(arg)))
                else:
                    out.append(self.prop_fn(inner))
                i = j
            else:
                out.append(text[i])
                i += 1
        return "".join(out)

    def cond(self, el) -> bool:
        c = el.get("Condition")
        return True if c is None else Cond(self, c).value()

    def load(self, path: Path, phase: str) -> None:
        root = ET.parse(path).getroot()
        saved = self.props.get("MSBuildThisFileDirectory")
        self.props["MSBuildThisFileDirectory"] = str(path.parent) + os.sep
        self.walk(root, path, phase, [0])
        self.props["MSBuildThisFileDirectory"] = saved

    def walk(self, node, path: Path, phase: str, seq: list[int]) -> None:
        base = path.parent
        for el in node:
            tag = el.tag.replace(MS, "")
            if tag in ("Import", "ImportGroup"):
                # Imports resolve once, in the property pass, and the later
                # passes visit the same files, as MSBuild records them.
                seq[0] += 1
                key = (str(path), seq[0])
                if phase == "props":
                    self.imported[key] = self.cond(el)
                if not self.imported.get(key):
                    continue
            elif not self.cond(el):
                continue
            if tag == "PropertyGroup" and phase == "props":
                for p in el:
                    name = p.tag.replace(MS, "")
                    if name in self.globals or not self.cond(p):
                        continue
                    self.props[name] = self.expand(p.text or "").strip()
            elif tag == "ImportGroup":
                self.walk(el, path, phase, seq)
            elif tag == "Import":
                proj = self.expand(el.get("Project", ""))
                name = Path(self.native(proj)).name
                if name == "Microsoft.Cpp.props" and phase == "props":
                    # The VC property sheets give the target the extension of
                    # its configuration type; a later property group may
                    # change it, an earlier one may not.
                    kind = self.props.get("ConfigurationType", "Application")
                    ext = {"DynamicLibrary": ".dll", "StaticLibrary": ".lib"}.get(kind, ".exe")
                    self.props["TargetExt"] = ext
                if "$(" in el.get("Project", "") and not proj.endswith(".props") or name in self.skip:
                    continue
                target = base / self.native(proj)
                if target.is_file() and target.suffix == ".props":
                    self.load(target, phase)
            elif tag == "ItemDefinitionGroup" and phase == "defs":
                for tool in el:
                    t = tool.tag.replace(MS, "")
                    if not self.cond(tool):
                        continue
                    d = self.defs.setdefault(t, {})
                    for m in tool:
                        if self.cond(m):
                            d[m.tag.replace(MS, "")] = self.expand(m.text or "", d).strip()
            elif tag == "ItemGroup" and phase == "items":
                for it in el:
                    t = it.tag.replace(MS, "")
                    inc = it.get("Include")
                    if inc is None or not self.cond(it):
                        continue
                    meta = dict(self.defs.get(t, {}))
                    for m in it:
                        if self.cond(m):
                            meta[m.tag.replace(MS, "")] = self.expand(m.text or "", meta).strip()
                    for one in self.expand(inc).split(";"):
                        if one.strip():
                            self.items.append((t, one.strip(), meta))

    def files(self, kind: str) -> list[tuple[Path, dict[str, str]]]:
        res = []
        for t, inc, meta in self.items:
            if t != kind or meta.get("ExcludedFromBuild", "").lower() == "true":
                continue
            res.append((self.resolve(inc), meta))
        return res

    def resolve(self, p: str) -> Path:
        q = Path(self.native(p))
        return q if q.is_absolute() else (self.path.parent / q)

    def list_meta(self, meta: dict[str, str], key: str) -> list[str]:
        return [v.strip() for v in meta.get(key, "").split(";")
                if v.strip() and not v.strip().startswith("%(")]


# --- toolchain ------------------------------------------------------------------

class Toolchain:
    """badc and the directories cl and link.exe would search."""

    def __init__(self, target: str):
        self.target = target
        arch = _win_kits.ARCH[target]
        name = "badc.exe" if os.name == "nt" else "badc"
        self.badc = os.environ.get("BADC") or str(REPO_ROOT / "target" / "release" / name)
        if not Path(self.badc).is_file():
            sys.exit(f"build_sdk: no badc at {self.badc}; cargo build --release --features std,full")
        kits = _win_kits.sdk_dirs(target)
        if kits is None:
            sys.exit("build_sdk: no Windows SDK with ucrt, um and shared headers and "
                     f"{arch} libraries; set BADC_WINDOWS_KITS")
        self.sdk_version, sdk_inc, sdk_lib = kits
        vc = _win_kits.msvc_tools(target)
        if vc is None:
            sys.exit(f"build_sdk: no MSVC tools with vcruntime.h and {arch} libraries; "
                     "set BADC_MSVC_TOOLS")
        self.vc = vc
        # cl's INCLUDE and link.exe's LIB order: the MSVC tools, then the kits.
        self.include = [vc / "include", *sdk_inc]
        self.libdirs = [vc / "lib" / arch, *sdk_lib]
        # The Microsoft assemblers a project's MASM or armasm sources take,
        # where the host runs them.
        self.ml = self.armasm = None
        if os.name == "nt":
            host = "Hostarm64" if platform.machine().upper() == "ARM64" else "Hostx64"
            ml = vc / "bin" / host / arch / ("ml64.exe" if arch == "x64" else "armasm64.exe")
            if ml.is_file():
                if arch == "x64":
                    self.ml = ml
                else:
                    self.armasm = ml
        # The resource compiler, which reads INCLUDE as cl does.
        self.rc = _win_kits.sdk_tool(self.sdk_version, "rc.exe") if os.name == "nt" else None

    def compile_cmd(self, src: Path, obj: Path, defines, includes, extra=()) -> list[str]:
        cmd = [self.badc, "-c", f"--target={self.target}", "--msvc", "-nostdlibinc", "-O"]
        for d in self.include:
            cmd += ["-isystem", str(d)]
        cmd += [f"-D{d}" for d in defines]
        for d in includes:
            cmd += ["-I", str(d)]
        return cmd + list(extra) + [str(src), "-o", str(obj)]

    def link_cmd(self, out: Path, inputs, libs, *, kind: str, extra=()) -> list[str]:
        cmd = [self.badc, f"--target={self.target}"]
        if kind == "DynamicLibrary":
            cmd.append("--shared")
        for d in self.libdirs:
            cmd += ["-L", str(d)]
        return cmd + list(extra) + [str(i) for i in inputs] + [f"-l{l}" for l in libs] + ["-o", str(out)]


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, errors="replace", **kw)


def msbuild_quote(s: str) -> str:
    """A command-line value as MSBuild's tasks quote one: in quotes, its own
    escaped quotes kept, a trailing backslash dropped."""
    return '"' + s.rstrip("\\") + '"'


def first_diagnostic(text: str, rc: int) -> str:
    lines = text.strip().splitlines()
    for severity in (": error: ", "error:", ": warning: "):
        for line in lines:
            if severity in line:
                return line
    return lines[-1] if lines else f"rc{rc}"


# --- PCbuild properties ------------------------------------------------------------

def version_props() -> dict[str, str]:
    text = (SRC / "Include" / "patchlevel.h").read_text()

    def get(name: str) -> str:
        return re.search(rf"define\s+{name}\s+(\w+)", text).group(1)

    major, minor, micro = get("PY_MAJOR_VERSION"), get("PY_MINOR_VERSION"), get("PY_MICRO_VERSION")
    serial = get("PY_RELEASE_SERIAL")
    level = {"PY_RELEASE_LEVEL_ALPHA": 10, "PY_RELEASE_LEVEL_BETA": 11,
             "PY_RELEASE_LEVEL_GAMMA": 12}.get(get("PY_RELEASE_LEVEL"), 15)
    return {
        "MajorVersionNumber": major, "MinorVersionNumber": minor,
        "MicroVersionNumber": micro, "ReleaseSerial": serial,
        "ReleaseLevelNumber": str(level),
        "Field3Value": str(int(micro) * 1000 + level * 10 + int(serial)),
    }


def global_props(target: str, tc: Toolchain) -> dict[str, str]:
    sep = os.sep
    arch = ARCHNAME[target]
    v = version_props()
    xy = v["MajorVersionNumber"] + v["MinorVersionNumber"]
    root = str(SRC) + sep
    ext = str(SRC / "externals") + sep
    build = str(PCBUILD / arch) + sep
    props = dict(v)
    props.update({
        "__Python_Props_Imported": "true",
        "Platform": PLATFORM[target], "Configuration": "Release",
        "PlatformToolset": "v143", "VisualStudioVersion": "17.0",
        "ArchName": arch, "PySourcePath": root, "BuildPath": build, "OutDir": build,
        "Py_IntDir": str(PCBUILD / "obj") + sep,
        "PyVPath": "..\\\\..", "PyDebugExt": "", "PyTestExt": "",
        "PyArchExt": "-arm64" if arch == "arm64" else "",
        "ExternalsDir": ext,
        "sqlite3Dir": ext + "sqlite-3.50.4.0" + sep, "bz2Dir": ext + "bzip2-1.0.8" + sep,
        "lzmaDir": ext + "xz-5.2.5" + sep, "mpdecimalDir": ext + "mpdecimal-4.0.0" + sep,
        "zlibNgDir": ext + "zlib-ng-2.2.4" + sep, "zstdDir": ext + "zstd-1.5.7" + sep,
        "libffiDir": ext + "libffi-3.4.4" + sep,
        "libffiOutDir": ext + "libffi-3.4.4" + sep + arch + sep,
        "libffiIncludeDir": ext + "libffi-3.4.4" + sep + arch + sep + "include",
        "opensslDir": ext + "openssl-3.5.7" + sep,
        "opensslOutDir": ext + "openssl-bin-3.5.7" + sep + arch + sep,
        "opensslIncludeDir": ext + "openssl-bin-3.5.7" + sep + arch + sep + "include",
        "GeneratedFrozenModulesDir": str(PCBUILD / "obj" / f"{xy}_frozen") + sep,
        "GeneratedZlibNgDir": str(PCBUILD / "obj" / f"{xy}{arch}_Release" / "zlib-ng") + sep,
        "GeneratedJitStencilsDir": str(PCBUILD / "obj" / f"{xy}_Release"),
        "PyExeName": "python", "PyWExeName": "pythonw",
        "PyDllName": f"python{xy}", "Py3DllName": "python3",
        "PydTag": f".cp{xy}-win_{arch}", "PyStdlibPydExt": ".pyd",
        "SysWinVer": f"{v['MajorVersionNumber']}.{v['MinorVersionNumber']}"
                     + ("-arm64" if arch == "arm64" else ""),
        "SupportPGO": "false", "SupportSigning": "false",
        "IncludeExternals": "true", "IncludeTkinter": "true", "IncludeSSL": "true",
        "IncludeCTypes": "true", "IncludeTests": "true",
        "WindowsTargetPlatformVersion": tc.sdk_version,
        "DefaultWindowsSDKVersion": tc.sdk_version,
    })
    return props


# MSBuild's default AdditionalDependencies for a Win32 desktop project
# (Microsoft.Cpp.CoreWin.props), and the libraries cl's /MD objects name by
# /DEFAULTLIB: the UCRT, the VC runtime and the POSIX-name aliases.
CORE_LIBS = ["kernel32", "user32", "gdi32", "winspool", "comdlg32", "advapi32",
             "shell32", "ole32", "oleaut32", "uuid", "odbc32", "odbccp32"]
CRT_LIBS = ["ucrt", "vcruntime", "oldnames"]

# Instruction-set capabilities PCbuild assumes of cl. badc's <immintrin.h>
# carries the SSE family and a 256-bit integer subset, so the units needing
# the rest of AVX2 and AVX-512 are not built and the code that dispatches to
# them is configured off, as a configure probe of the compiler would.
# TODO(#1979): the AVX2 and AVX-512 intrinsics.
NO_WIDE_VECTORS = {
    "pythoncore": {"undef": ["_Py_HACL_CAN_COMPILE_VEC256"],
                   "skip": ["Hacl_Hash_Blake2b_Simd256.c"]},
    "zlib-ng": {"undef": ["X86_AVX2", "X86_AVX512", "X86_AVX512VNNI", "X86_VPCLMULQDQ_CRC"],
                "skip": ["slide_hash_avx2.c", "chunkset_avx2.c", "compare256_avx2.c",
                         "adler32_avx2.c", "adler32_avx512.c", "chunkset_avx512.c",
                         "adler32_avx512_vnni.c", "crc32_vpclmulqdq.c"]},
}


class Build:
    def __init__(self, target: str, tc: Toolchain, jobs: int, log):
        self.target, self.tc, self.jobs, self.log = target, tc, jobs, log
        self.globals = global_props(target, tc)
        self.out = PCBUILD / ARCHNAME[target]
        self.out.mkdir(parents=True, exist_ok=True)
        self.results: dict[str, str] = {}
        self.outputs: dict[str, Path] = {}

    def evaluate(self, name: str) -> Project:
        g = dict(self.globals)
        xy = g["MajorVersionNumber"] + g["MinorVersionNumber"]
        g["ProjectName"] = name
        g["MSBuildProjectName"] = name
        g["IntDir"] = str(PCBUILD / "obj" / f"{xy}{ARCHNAME[self.target]}_Release" / name) + os.sep
        return Project(PCBUILD / f"{name}.vcxproj", g, {"python.props", "pyproject-clangcl.props"})

    def implicit_defines(self, proj: Project, meta: dict[str, str]) -> list[str]:
        """What cl and the VC property sheets define beyond the project's list:
        /MD's _MT and _DLL, _WINDLL for a DLL, and the character set's."""
        out = ["_MT", "_DLL"]
        if proj.props.get("ConfigurationType") == "DynamicLibrary":
            out.append("_WINDLL")
        charset = proj.props.get("CharacterSet", "NotSet")
        out += {"Unicode": ["_UNICODE", "UNICODE"], "MultiByte": ["_MBCS"]}.get(charset, [])
        return out

    def target_path(self, proj: Project, name: str) -> Path:
        kind = proj.props.get("ConfigurationType", "Application")
        tname = proj.props.get("TargetName") or name
        ext = proj.props.get("TargetExt") or {"DynamicLibrary": ".dll", "StaticLibrary": ".lib"}.get(kind, ".exe")
        return self.out / f"{tname}{ext}"

    def compile_units(self, name: str, proj: Project) -> tuple[list[Path], list[str]]:
        int_dir = Path(proj.props["IntDir"])
        int_dir.mkdir(parents=True, exist_ok=True)
        tweak = NO_WIDE_VECTORS.get(name, {}) if self.target == "windows-x64" else {}
        jobs, seen = [], set()
        for src, meta in proj.files("ClCompile"):
            if src.name in tweak.get("skip", []):
                continue
            stem = src.stem
            while stem in seen:
                stem += "_"
            seen.add(stem)
            defs = [d for d in proj.list_meta(meta, "PreprocessorDefinitions")
                    if d.split("=", 1)[0] not in tweak.get("undef", [])]
            if name == "pythoncore" and src.name == "getbuildinfo.c":
                defs += ['GITVERSION=""', 'GITTAG=""', 'GITBRANCH=""']
            defs = self.implicit_defines(proj, meta) + defs
            incs = [proj.resolve(d) for d in proj.list_meta(meta, "AdditionalIncludeDirectories")]
            obj = int_dir / f"{stem}.obj"
            jobs.append((src, obj, self.tc.compile_cmd(src, obj, defs, incs), None))
        for src, meta in proj.files("CustomBuild"):
            if src.suffix.lower() != ".asm":
                continue
            obj = int_dir / f"{src.stem}.obj"
            if self.tc.ml is None:
                return [], [f"{src.name}: MASM source and no ml64 on this host"]
            jobs.append((src, obj, [str(self.tc.ml), "/nologo", "/c", f"/Fo{obj}", str(src)], None))
        # ResourceCompile as MSBuild's RC task runs it; the .res joins the link.
        for src, meta in proj.files("ResourceCompile"):
            if self.tc.rc is None:
                self.log(f"  [{name}] {src.name}: no rc.exe on this host; the image has no resources")
                continue
            res = int_dir / f"{src.stem}.res"
            # rc.exe reads its command line as MSBuild writes it, each value
            # in quotes.
            cmd = [str(self.tc.rc), "/nologo"]
            for d in proj.list_meta(meta, "PreprocessorDefinitions"):
                cmd += ["/D", msbuild_quote(d)]
            if meta.get("Culture"):
                cmd += ["/l", meta["Culture"]]
            for d in proj.list_meta(meta, "AdditionalIncludeDirectories"):
                cmd += ["/I", msbuild_quote(str(proj.resolve(d)))]
            cmd += ["/fo", msbuild_quote(str(res)), msbuild_quote(str(src))]
            env = dict(os.environ, INCLUDE=os.pathsep.join(map(str, self.tc.include)))
            jobs.append((src, res, " ".join(cmd), env))
        objs, fails = [], []

        def one(job):
            src, obj, cmd, env = job
            r = run(cmd, cwd=str(PCBUILD), timeout=600, env=env)
            return src, obj, cmd, r

        with ThreadPoolExecutor(max_workers=self.jobs) as ex:
            for src, obj, cmd, r in ex.map(one, jobs):
                if r.returncode != 0:
                    fails.append(f"{src.relative_to(SRC) if SRC in src.parents else src}: "
                                 f"{first_diagnostic(r.stderr or r.stdout, r.returncode)[:300]}")
                else:
                    objs.append(obj)
        return objs, fails

    def link_libs(self, proj: Project) -> list[str]:
        meta = proj.defs.get("Link", {})
        libs = []
        for dep in proj.list_meta(meta, "AdditionalDependencies"):
            libs.append(dep[:-4] if dep.lower().endswith(".lib") else dep)
        return libs

    def build_project(self, name: str) -> bool:
        path = PCBUILD / f"{name}.vcxproj"
        if not path.is_file():
            self.results[name] = "no project file"
            return False
        proj = self.evaluate(name)
        kind = proj.props.get("ConfigurationType", "Application")
        out = self.target_path(proj, name)
        cpp = [s for s, _ in proj.files("ClCompile") if s.suffix.lower() != ".c"]
        if cpp:
            self.results[name] = f"C++ sources ({cpp[0].name}): not a C compiler's input"
            return False
        t0 = time.time()
        objs, fails = self.compile_units(name, proj)
        if fails:
            self.results[name] = f"{len(fails)} unit(s) failed: " + fails[0]
            for f in fails:
                self.log(f"  [{name}] COMPILE FAIL {f}")
            return False
        if kind == "StaticLibrary":
            out.unlink(missing_ok=True)
            r = run([self.tc.badc, "--ar", "rcs", str(out), *map(str, objs)])
        else:
            # A referenced project's output joins the link, as MSBuild passes
            # a referenced static library or DLL's import library.
            inputs = list(objs)
            for ref in (Path(proj.native(i)).stem for t, i, _ in proj.items if t == "ProjectReference"):
                if ref in self.outputs:
                    inputs.append(self.outputs[ref])
            produced = {p.name.lower() for p in self.outputs.values()}
            libs = [l for l in self.link_libs(proj) if f"{l.lower()}.lib" not in produced]
            link = proj.defs.get("Link", {})
            # pyproject.props puts $(OutDir) on the library path, and link.exe
            # writes a DLL's import library beside it.
            extra = ["-L", str(self.out)]
            if kind == "DynamicLibrary":
                extra.append(f"-Wl,--out-implib,{out.with_suffix('.lib')}")
            if link.get("NoEntryPoint", "").lower() == "true":
                extra.append("--entry=")
            if link.get("StackReserveSize"):
                extra.append(f"-Wl,--stack,{link['StackReserveSize']}")
            if kind == "Application" and link.get("SubSystem") == "Windows":
                extra.append("--subsystem=windows")
            all_libs = libs + [l for l in CORE_LIBS + CRT_LIBS if l not in libs]
            out.unlink(missing_ok=True)
            r = run(self.tc.link_cmd(out, inputs, all_libs, kind=kind, extra=extra), timeout=900)
        if r.returncode != 0 or not out.is_file():
            self.results[name] = "link failed: " + first_diagnostic(r.stderr or r.stdout, r.returncode)[:400]
            self.log((r.stderr or r.stdout)[-3000:])
            return False
        if kind != "Application":
            self.outputs[name] = out.with_suffix(".lib")
        if name == "python":
            # python.vcxproj's GeneratePyBuildDirTxt: getpath reads the build
            # layout from it beside the executable.
            (self.out / "pybuilddir.txt").write_bytes(b"\r\n\r\n")
        note = ""
        if name == "_freeze_module" and os.name == "nt":
            note = self.freeze_modules(proj, out)
            if note.startswith("failed"):
                self.results[name] = note
                return False
        self.results[name] = f"ok {out.name} ({len(objs)} units, {time.time() - t0:.0f}s){note}"
        return True

    def freeze_modules(self, proj: Project, exe: Path) -> str:
        """_freeze_module.vcxproj's _RebuildFrozen and _RebuildGetPath: the
        freezer just built writes each frozen module's header and getpath's,
        which replace the vendored ones when they differ."""
        changed = 0
        for src, meta in proj.files("None") + proj.files("GetPath"):
            if not meta.get("ModName"):
                continue
            inter, final = Path(proj.native(meta["IntFile"])), Path(proj.native(meta["OutFile"]))
            inter.parent.mkdir(parents=True, exist_ok=True)
            r = run([str(exe), meta["ModName"], str(src), str(inter)], cwd=str(PCBUILD), timeout=600)
            if r.returncode != 0:
                return f"failed: {exe.name} {meta['ModName']}: {first_diagnostic(r.stderr or r.stdout, r.returncode)}"
            if not final.is_file() or final.read_bytes() != inter.read_bytes():
                final.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(inter, final)
                changed += 1
        return f"; froze the modules, {changed} header(s) differing from the vendored ones"


def project_projects() -> list[str]:
    """pcbuild.proj's projects for the Release configuration with every
    option on, each after the projects it references: the freeze tool, the
    core and the stable-ABI DLL, the extension, external and test modules,
    then the launchers and the interpreters."""
    text = (PCBUILD / "pcbuild.proj").read_text()

    def items(tag: str) -> list[str]:
        out = []
        for m in re.finditer(rf'<{tag} Include="([^"$@]+)"', text):
            out += [n.strip() for n in m.group(1).split(";") if n.strip()]
        return out

    names = ["_freeze_module", "zlib-ng", "pythoncore", "python3dll"]
    names += items("ExtensionModules") + items("ExternalModules")
    names += items("TestModules") + ["xxlimited", "xxlimited_35"]
    # The UWP interpreters are conditional on IncludeUwp, which is off.
    names += [Path(p).stem for p in items("Projects") + items("Projects2")
              if p.endswith(".vcxproj") and "_uwp" not in p]
    ordered: list[str] = []

    def visit(name: str) -> None:
        if name in ordered or not (PCBUILD / f"{name}.vcxproj").is_file():
            return
        refs = re.findall(r'<ProjectReference Include="([^"]+)\.vcxproj"',
                          (PCBUILD / f"{name}.vcxproj").read_text())
        for ref in refs:
            visit(Path(ref.replace("\\", "/")).name)
        ordered.append(name)

    for name in names:
        visit(name)
    return ordered


# --- external libraries -----------------------------------------------------------

def run_jobs(b: Build, jobs) -> list[str]:
    """Run `(label, command)` jobs in parallel; the failures' first lines."""
    def one(job):
        label, cmd = job
        r = run(cmd, timeout=900)
        return None if r.returncode == 0 else f"{label}: {first_diagnostic(r.stderr or r.stdout, r.returncode)[:300]}"
    with ThreadPoolExecutor(max_workers=b.jobs) as ex:
        return [f for f in ex.map(one, jobs) if f]


def build_libffi(b: Build) -> str:
    """libffi-8.dll as prepare_libffi.bat builds it with cl: configure's
    MSVC sources (the C files, and win64_armasm.S for armasm64, preprocessed
    by the compiler), FFI_BUILDING_DLL for the exports, and the headers
    _ctypes reads from libffiIncludeDir. On x64 the GNU-syntax win64.S,
    whose `.seh_*` directives give its functions their unwind rows, is
    assembled by badc in place of win64_intel.S for ml64. On arm64 the C
    side declares the HFA helpers only win64_armasm.S defines."""
    x64 = b.target == "windows-x64"
    if not x64 and b.tc.armasm is None:
        return "no armasm64 on this host for libffi's MSVC assembly source"
    src = fetch_external("libffi-3.4.4", b.log)
    out = Path(b.globals["libffiOutDir"])
    inc = out / "include"
    obj = out / "obj"
    inc.mkdir(parents=True, exist_ok=True)
    obj.mkdir(parents=True, exist_ok=True)
    arch_dir = src / "src" / ("x86" if x64 else "aarch64")
    template = (src / "include" / "ffi.h.in").read_text()
    for key, value in {"@VERSION@": "3.4.4", "@TARGET@": "X86_WIN64" if x64 else "ARM_WIN64",
                       "@HAVE_LONG_DOUBLE@": "0", "@HAVE_LONG_DOUBLE_VARIANT@": "0",
                       "@FFI_EXEC_TRAMPOLINE_TABLE@": "0"}.items():
        template = template.replace(key, value)
    (inc / "ffi.h").write_text(template)
    shutil.copy2(arch_dir / "ffitarget.h", inc / "ffitarget.h")
    # configure's answers for an MSVC host, as the distributed fficonfig.h has them.
    config = ["HAVE_ALLOCA 1", "HAVE_INTTYPES_H 1", "HAVE_STDINT_H 1", "HAVE_STDIO_H 1",
              "HAVE_STDLIB_H 1", "HAVE_STRING_H 1", "HAVE_SYS_STAT_H 1", "HAVE_SYS_TYPES_H 1",
              "SIZEOF_DOUBLE 8", "SIZEOF_LONG_DOUBLE 8", "SIZEOF_SIZE_T 8", "STDC_HEADERS 1",
              'VERSION "3.4.4"'] + (["HAVE_AS_X86_PCREL 1"] if x64 else [])
    (inc / "fficonfig.h").write_text(
        "".join(f"#define {c}\n" for c in config)
        + "#ifdef LIBFFI_ASM\n#define FFI_HIDDEN(name)\n#else\n#define FFI_HIDDEN\n#endif\n")
    sources = [src / "src" / n for n in ("prep_cif.c", "types.c", "raw_api.c", "java_raw_api.c",
                                         "closures.c", "tramp.c")]
    sources.append(arch_dir / ("ffiw64.c" if x64 else "ffi.c"))
    incs = [inc, src / "include", arch_dir]
    defines = ["_MT", "_DLL", "_WINDLL", "FFI_BUILDING_DLL"]
    objs = [obj / f"{c.stem}.obj" for c in sources]
    if x64:
        sources.append(arch_dir / "win64.S")
        objs.append(obj / "win64.obj")
    fails = run_jobs(b, [(c.name, b.tc.compile_cmd(c, o, defines, incs)) for c, o in zip(sources, objs)])
    if not x64:
        asm = arch_dir / "win64_armasm.S"
        pre = obj / f"{asm.stem}.asm"
        cmd = [b.tc.badc, "-E", "-P", f"--target={b.target}", "--msvc", "-nostdlibinc",
               "-DLIBFFI_ASM"]
        for d in b.tc.include + incs:
            cmd += ["-I", str(d)]
        r = run(cmd + [str(asm), "-o", str(pre)])
        if r.returncode != 0:
            fails.append(f"{asm.name}: {first_diagnostic(r.stderr, r.returncode)[:300]}")
        else:
            aobj = obj / f"{asm.stem}.obj"
            r = run([str(b.tc.armasm), "-nologo", "-o", str(aobj), str(pre)])
            if r.returncode != 0:
                fails.append(f"{asm.name}: {(r.stdout + r.stderr).strip().splitlines()[-1:]}")
            objs.append(aobj)
    if fails:
        return f"{len(fails)} unit(s) failed: {fails[0]}"
    dll = out / "libffi-8.dll"
    r = run(b.tc.link_cmd(dll, objs, CORE_LIBS + CRT_LIBS, kind="DynamicLibrary",
                          extra=[f"-Wl,--out-implib,{out / 'libffi-8.lib'}"]))
    if r.returncode != 0:
        return "link failed: " + first_diagnostic(r.stderr or r.stdout, r.returncode)[:300]
    # libffi.props copies the DLL beside the modules that load it.
    shutil.copy2(dll, b.out / dll.name)
    return f"ok {dll.name} ({len(objs)} units)"


# --- generated inputs ---------------------------------------------------------------

def prepare_source(log) -> None:
    """A pristine extraction of the release, with the frozen-module headers
    setup.py vendors for a host that cannot run _freeze_module."""
    r = run([sys.executable, str(PY_DIR / "setup.py")])
    if r.returncode != 0:
        sys.exit("build_sdk: setup.py failed\n" + r.stdout + r.stderr)
    if not (PCBUILD / "pcbuild.proj").is_file():
        tarball = next((PY_DIR / ".cache").glob(f"python-{VERSION}-*.tar.gz"))
        log(f"extracting {tarball.name}")
        CACHE.mkdir(parents=True, exist_ok=True)
        with tarfile.open(tarball) as t:
            t.extractall(CACHE)


def place_frozen(b: Build) -> None:
    """_freeze_module's outputs from the vendored headers; on a Windows host
    the freezer's own output replaces them (Build.freeze_modules)."""
    dest = Path(b.globals["GeneratedFrozenModulesDir"]) / "Python" / "frozen_modules"
    dest.mkdir(parents=True, exist_ok=True)
    vendored = PY_DIR / ".cache" / f"Python-{VERSION}" / "Python" / "frozen_modules"
    for h in vendored.glob("*.h"):
        target = dest / h.name
        if not target.is_file() or target.read_bytes() != h.read_bytes():
            shutil.copy2(h, target)


def place_zlib_header(b: Build) -> None:
    """zlib-ng.vcxproj's _EnsureZlibH: zlib.h from zlib.h.in, no symbol prefix."""
    src = Path(b.globals["zlibNgDir"]) / "zlib.h.in"
    out = Path(b.globals["GeneratedZlibNgDir"])
    out.mkdir(parents=True, exist_ok=True)
    (out / "zlib.h").write_text(src.read_text().replace("@ZLIB_SYMBOL_PREFIX@", ""))


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    host = {"AMD64": "windows-x64", "ARM64": "windows-arm64"}.get(platform.machine().upper(), "windows-x64")
    p.add_argument("--target", default=os.environ.get("BADC_PY_TARGET") or host, choices=list(PLATFORM))
    p.add_argument("--projects", help="comma-separated subset of the PCbuild projects")
    p.add_argument("-j", "--jobs", type=int, default=os.cpu_count() or 4)
    p.add_argument("--keep-going", action="store_true", help="build the projects after a failed one")
    p.add_argument("--test", action="store_true",
                   help="run regrtest on the build afterwards (Windows host)")
    args = p.parse_args(argv)
    log = print
    prepare_source(log)
    tc = Toolchain(args.target)
    log(f"badc {tc.badc}; SDK {tc.sdk_version}; MSVC tools {tc.vc}")
    if not args.projects:
        # A whole build starts from an empty output directory, so no output
        # of an earlier run stands in for one this run did not produce.
        shutil.rmtree(PCBUILD / ARCHNAME[args.target], ignore_errors=True)
    b = Build(args.target, tc, args.jobs, log)
    for ext in ("zlib-ng-2.2.4", "mpdecimal-4.0.0", "bzip2-1.0.8", "xz-5.2.5", "zstd-1.5.7",
                "sqlite-3.50.4.0"):
        fetch_external(ext, log)
    place_frozen(b)
    place_zlib_header(b)
    externals = {"libffi": build_libffi}
    names = args.projects.split(",") if args.projects else list(externals) + project_projects()
    for name in [n for n in names if n in externals]:
        b.results[name] = externals[name](b)
        log(f"{name}: {b.results[name]}")
    names = [n for n in names if n not in externals]
    for name in names:
        ok = b.build_project(name)
        log(f"{name}: {b.results[name]}")
        if not ok and name == "pythoncore" and not args.keep_going:
            break
    built = sum(r.startswith("ok") for r in b.results.values())
    log(f"\n{built}/{len(b.results)} projects built")
    for name, res in b.results.items():
        if not res.startswith("ok"):
            log(f"  {name}: {res}")
    if args.test:
        return run_tests(args.target, args.jobs, log)
    return 0 if built == len(b.results) else 1


def run_tests(target: str, jobs: int, log) -> int:
    """regrtest over the whole suite, as Tools\\buildbot\\test.bat runs it, with a
    per-test timeout and the JUnit results beside the cache."""
    if os.name != "nt":
        log("--test runs the build on a Windows host")
        return 1
    exe = PCBUILD / ARCHNAME[target] / "python.exe"
    junit = CACHE / f"junit-{target}.xml"
    env = {k: v for k, v in os.environ.items() if k not in ("PYTHONHOME", "PYTHONPATH")}
    cmd = [str(exe), "-m", "test", "-j", str(jobs), "--timeout=900", "--junit-xml", str(junit)]
    log(" ".join(cmd))
    return subprocess.run(cmd, cwd=str(SRC), env=env).returncode


if __name__ == "__main__":
    sys.exit(main())
