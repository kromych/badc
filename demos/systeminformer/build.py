#!/usr/bin/env python3
"""Build System Informer 4.0.26241.138 with badc, as its CMake lists describe it.

    python demos/systeminformer/build.py [--target=windows-x64|windows-arm64]
        [--opt=-O|-O0] [--jobs=N] [-v]

SI's CMake lists name each target's sources, include directories,
definitions, compile options, libraries and delay-loaded DLLs; its
``cmake/`` modules decide the platform and the clang-cl configuration. This
driver evaluates the lists and modules for one processor as SI's clang-cl
toolchain files configure them (``MSVC`` with a ``Clang`` C compiler, so
``MSVC_CLANG``), and runs badc where that build runs clang-cl to compile C,
lib to archive and link to link. The tools that build takes from the SDK and
MSVC stay theirs: mc.exe for kphlib's message table, rc.exe for the resource
scripts, cl.exe for the C++ units, and ml64.exe or armasm64.exe for
SymCrypt's assembly.

Every C unit compiles with ``--msvc`` against cl's headers -- MSVC's include
directory and the SDK's ucrt, um, shared and winrt -- with nothing from
badc's bundled C library, and the images link the static VC runtime with the
UCRT DLL (``-llibvcruntime -llibcmt -lucrt``), the runtime SI's ``/MT``
builds name.

The outputs, under ``.cache/build-<arch><opt>/bin``: SystemInformer.exe,
peview.exe, and phlib-test.exe, phlib's self-test, which only its MSBuild
project describes.

The kernel driver, which only its MSBuild projects and ``Common.Kernel.props``
describe, builds where the WDK's kernel-mode headers and libraries for the
target are installed: kphlib_km, the ksi.dll export driver with its import
library, and the driver, which its project names SystemInformer.sys, under
``bin/driver``. The props' platform
definitions, ``_NT_TARGET_VERSION`` and include order apply, with
``KSI_NO_WPP``, the switch they give for building without WPP tracing; the
images link the WDK's default kernel libraries and enter as its projects do.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import re
import shutil
import struct
import subprocess
import sys
import time
import xml.etree.ElementTree as ET
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

DEMO = Path(__file__).resolve().parent
REPO_ROOT = DEMO.parents[1]
sys.path.insert(0, str(DEMO.parent))
import _win_kits  # noqa: E402

VERSION = "4.0.26241.138"
SRC = DEMO / ".cache" / f"systeminformer-{VERSION}"
PROCESSOR = {"windows-x64": "AMD64", "windows-arm64": "ARM64"}
PLATFORM = {"windows-x64": "x64", "windows-arm64": "ARM64"}
TARGETS = ["SystemInformer", "peview"]
# The libraries a Visual C++ project links by default
# (`%(AdditionalDependencies)`).
VS_DEFAULT_LIBS = ["kernel32", "user32", "gdi32", "winspool", "comdlg32", "advapi32",
                   "shell32", "ole32", "oleaut32", "uuid", "odbc32", "odbccp32"]
# The static VC runtime with the UCRT DLL, which a `/MT` build's cl objects name.
VC_RUNTIME = ["libvcruntime", "libcmt", "ucrt"]
# SI's release images link with `/GUARD:CF` (cmake/toolchain/msvc.cmake), so
# the program loads where a process requires Control Flow Guard, as it does
# once it restarts itself under strict CFG with its driver loaded.
GUARD_LINK = ["--guard-cf"]
# SI's functions with nothing to build here: the plugin SDK's headers
# (`si_sdkbuild`) and the driver signing (`si_kphsign`).
IGNORED_CALLS = {"si_sdkbuild", "si_kphsign"}
# The module defining them, which requires the C# CustomBuildTool they run.
SKIPPED_MODULES = {"tools"}
IGNORED = {"cmake_minimum_required", "project", "source_group", "enable_language"}


class Error(Exception):
    pass


# --- CMake ------------------------------------------------------------------

class Arg:
    __slots__ = ("text", "quoted")

    def __init__(self, text: str, quoted: bool):
        self.text, self.quoted = text, quoted


def commands(text: str, path: Path):
    """Each command invocation of a CMake list: (name, [Arg], line)."""
    i, n, line = 0, len(text), 1
    while i < n:
        c = text[i]
        if c == "\n":
            line += 1
            i += 1
        elif c.isspace():
            i += 1
        elif c == "#":
            while i < n and text[i] != "\n":
                i += 1
        elif c.isalpha() or c == "_":
            m = re.compile(r"[A-Za-z_][A-Za-z0-9_]*").match(text, i)
            name, i = m.group(0), m.end()
            while text[i] in " \t":
                i += 1
            if text[i] != "(":
                raise Error(f"{path}:{line}: `{name}` is not followed by `(`")
            i, at, args, depth = i + 1, line, [], 1
            while depth:
                c = text[i]
                if c == "\n":
                    line += 1
                    i += 1
                elif c.isspace():
                    i += 1
                elif c == "#":
                    while text[i] != "\n":
                        i += 1
                elif c == "(":
                    depth += 1
                    i += 1
                elif c == ")":
                    depth -= 1
                    i += 1
                elif c == '"':
                    j, out = i + 1, []
                    while text[j] != '"':
                        if text[j] == "\\" and text[j + 1] in '"\\;$':
                            j += 1
                        line += text[j] == "\n"
                        out.append(text[j])
                        j += 1
                    args.append(Arg("".join(out), True))
                    i = j + 1
                else:
                    j = i
                    while j < n and not text[j].isspace() and text[j] not in '()"#':
                        j += 1
                    args.append(Arg(text[i:j], False))
                    i = j
            yield name.lower(), args, at
        else:
            raise Error(f"{path}:{line}: unexpected `{c}`")


FALSE = {"", "0", "OFF", "NO", "FALSE", "N", "IGNORE", "NOTFOUND"}


def truthy(value: str) -> bool:
    return value.upper() not in FALSE and not value.upper().endswith("-NOTFOUND")


class Target:
    def __init__(self, name: str, kind: str, directory: Path, binary: Path):
        self.name, self.kind, self.dir, self.binary = name, kind, directory, binary
        self.sources: list[Path] = []
        self.win32 = False
        self.usage = {k: {"PRIVATE": [], "PUBLIC": [], "INTERFACE": []}
                      for k in ("includes", "defines", "options", "links", "link_options")}


class CMake:
    """The part of CMake SI's lists and modules use: variables and lists,
    `if` over variables, `include` and `add_subdirectory`, the target
    commands with their usage requirements, and the custom commands that
    generate sources. A command outside that part stops the evaluation."""

    def __init__(self, target: str, find):
        self.find = find
        self.targets: dict[str, Target] = {}
        self.custom: list[tuple[list[str], list[list[str]], Path]] = []
        self.functions: set[str] = set()
        self.vars = {
            "CMAKE_SYSTEM_NAME": "Windows",
            "CMAKE_SYSTEM_PROCESSOR": PROCESSOR[target],
            "CMAKE_GENERATOR_PLATFORM": PLATFORM[target],
            "CMAKE_C_COMPILER_ID": "Clang",
            "CMAKE_CXX_COMPILER_ID": "Clang",
            "MSVC": "1",
            "WIN32": "1",
            "CMAKE_BUILD_TYPE": "Release",
            "CMAKE_COMMAND": "cmake",
            "CMAKE_MODULE_PATH": "",
        }

    # Values ---------------------------------------------------------------

    def expand(self, text: str, scope: dict) -> str:
        pattern = re.compile(r"\$\{([A-Za-z0-9_]*)\}|\$ENV\{([A-Za-z0-9_]*)\}")
        while True:
            m = pattern.search(text)
            if not m:
                return text
            value = scope.get(m.group(1), "") if m.group(1) is not None else \
                os.environ.get(m.group(2), "")
            text = text[:m.start()] + value + text[m.end():]

    def values(self, args: list[Arg], scope: dict) -> list[str]:
        out = []
        for a in args:
            v = self.expand(a.text, scope)
            if a.quoted:
                out.append(v)
            else:
                out += [x for x in v.split(";") if x]
        return out

    def genex(self, value: str, language: str) -> list[str]:
        """A generator expression, as Release evaluates it for `language`."""
        value = value.replace("$<CONFIG>", "Release")
        while True:
            m = re.search(r"\$<([^<>:]*):([^<>]*)>", value)
            if not m:
                break
            cond, body = m.group(1), m.group(2)
            if cond.startswith("$<COMPILE_LANGUAGE:"):
                raise Error(f"generator expression `{value}`")
            value = value[:m.start()] + body + value[m.end():]
        m = re.fullmatch(r"\$<\$<COMPILE_LANGUAGE:([A-Z,]*)>:(.*)>", value)
        if m:
            return [m.group(2)] if language in m.group(1).split(",") else []
        if "$<" in value:
            raise Error(f"generator expression `{value}`")
        return [value]

    # Conditions -----------------------------------------------------------

    def condition(self, args: list[Arg], scope: dict) -> bool:
        tokens = [(self.expand(a.text, scope), a.quoted) for a in args]

        def operand(tok):
            text, quoted = tok
            return text if quoted or text not in scope else scope[text]

        def single(tok):
            text, quoted = tok
            if quoted:
                return truthy(text)
            if text.upper() in FALSE or text.upper() in {"ON", "YES", "TRUE", "Y"} \
                    or re.fullmatch(r"-?\d+(\.\d+)?", text):
                return truthy(text)
            return text in scope and truthy(scope[text])

        def test(toks):
            if len(toks) == 1:
                return single(toks[0])
            if len(toks) == 2 and toks[0][0] == "DEFINED":
                return toks[1][0] in scope
            if len(toks) == 2 and toks[0][0] == "EXISTS":
                return Path(toks[1][0]).exists()
            if len(toks) == 3:
                a, op, b = operand(toks[0]), toks[1][0], operand(toks[2])
                if op == "MATCHES":
                    return re.search(b, a) is not None
                if op == "STREQUAL":
                    return a == b
                if op == "EQUAL":
                    return float(a) == float(b)
            raise Error(f"if({' '.join(t for t, _ in toks)})")

        def negation(toks):
            if toks and toks[0][0] == "NOT" and not toks[0][1]:
                return not negation(toks[1:])
            return test(toks)

        def split(toks, word):
            parts, cur = [], []
            for t in toks:
                if t[0] == word and not t[1]:
                    parts.append(cur)
                    cur = []
                else:
                    cur.append(t)
            return parts + [cur]

        return any(all(negation(p) for p in split(o, "AND")) for o in split(tokens, "OR"))

    # Evaluation -----------------------------------------------------------

    def run_file(self, path: Path, scope: dict) -> None:
        cmds = list(commands(path.read_text(encoding="utf-8-sig"), path))
        self.run(cmds, 0, len(cmds), path, scope)

    def run(self, cmds, i: int, end: int, path: Path, scope: dict) -> None:
        while i < end:
            name, args, line = cmds[i]
            if name == "if":
                i = self.run_if(cmds, i, path, scope)
                continue
            if name in ("function", "macro"):
                self.functions.add(args[0].text.lower())
                i = self.skip_block(cmds, i, name, "end" + name)
                continue
            try:
                self.command(name, args, path, scope)
            except Error as e:
                raise Error(f"{path}:{line}: {e}") from None
            i += 1

    def skip_block(self, cmds, i: int, start: str, stop: str) -> int:
        depth = 0
        while True:
            name = cmds[i][0]
            depth += name == start
            depth -= name == stop
            i += 1
            if depth == 0:
                return i

    def run_if(self, cmds, i: int, path: Path, scope: dict) -> int:
        # The branches at this nesting level: (start, condition args).
        branches, depth, j = [(i + 1, cmds[i][1])], 0, i + 1
        while True:
            name = cmds[j][0]
            if name == "if":
                depth += 1
            elif name == "endif" and depth:
                depth -= 1
            elif depth == 0 and name in ("elseif", "else"):
                branches.append((j + 1, cmds[j][1] if name == "elseif" else None))
            elif depth == 0 and name == "endif":
                break
            j += 1
        bounds = [b[0] for b in branches[1:]] + [j + 1]
        for (start, cond), stop in zip(branches, bounds):
            if cond is None or self.condition(cond, scope):
                self.run(cmds, start, stop - 1, path, scope)
                break
        return j + 1

    def command(self, name: str, args: list[Arg], path: Path, scope: dict) -> None:
        here = Path(scope["CMAKE_CURRENT_SOURCE_DIR"])
        if name == "set":
            vals = self.values(args[1:], scope)
            var = self.expand(args[0].text, scope)
            if "CACHE" in vals:
                vals = vals[:vals.index("CACHE")]
                if var in scope:
                    return
            if "PARENT_SCOPE" in vals:
                scope["__parent"][var] = ";".join(v for v in vals if v != "PARENT_SCOPE")
                return
            scope[var] = ";".join(vals)
        elif name == "option":
            var = args[0].text
            if var not in scope:
                scope[var] = self.values(args[2:], scope)[0] if len(args) > 2 else "OFF"
        elif name == "list":
            op, var = args[0].text, self.expand(args[1].text, scope)
            items = [x for x in scope.get(var, "").split(";") if x]
            new = self.values(args[2:], scope)
            if op == "APPEND":
                items += new
            elif op == "REMOVE_ITEM":
                items = [x for x in items if x not in new]
            else:
                raise Error(f"list({op})")
            scope[var] = ";".join(items)
        elif name == "message":
            vals = self.values(args, scope)
            if vals and vals[0] in ("FATAL_ERROR", "SEND_ERROR"):
                raise Error(" ".join(vals[1:]))
        elif name == "include":
            module = self.values(args, scope)[0]
            if module in SKIPPED_MODULES:
                return
            for d in scope.get("CMAKE_MODULE_PATH", "").split(";"):
                p = Path(d) / f"{module}.cmake"
                if d and p.is_file():
                    # An included file runs in the includer's scope.
                    saved = scope["CMAKE_CURRENT_LIST_DIR"]
                    scope["CMAKE_CURRENT_LIST_DIR"] = str(p.parent)
                    self.run_file(p, scope)
                    scope["CMAKE_CURRENT_LIST_DIR"] = saved
                    return
            raise Error(f"include({module}): no module")
        elif name == "add_subdirectory":
            sub = here / self.values(args, scope)[0]
            inner = dict(scope)
            inner["__parent"] = scope
            inner["CMAKE_CURRENT_SOURCE_DIR"] = str(sub)
            inner["CMAKE_CURRENT_LIST_DIR"] = str(sub)
            inner["CMAKE_CURRENT_BINARY_DIR"] = str(
                Path(scope["CMAKE_CURRENT_BINARY_DIR"]) / sub.relative_to(here))
            self.run_file(sub / "CMakeLists.txt", inner)
        elif name == "add_compile_options":
            scope["__compile_options"] = ";".join(
                [x for x in scope.get("__compile_options", "").split(";") if x]
                + self.values(args, scope))
        elif name == "find_program":
            var, vals = args[0].text, self.values(args[1:], scope)
            names = vals[vals.index("NAMES") + 1:] if "NAMES" in vals else vals[:1]
            found = next((p for p in map(self.find, names) if p), None)
            scope[var] = str(found) if found else f"{var}-NOTFOUND"
        elif name == "add_custom_command":
            vals = self.values(args, scope)
            outs, cmds, cur, key = [], [], None, None
            for v in vals:
                if v in ("OUTPUT", "COMMAND", "DEPENDS", "COMMENT", "VERBATIM",
                         "WORKING_DIRECTORY", "BYPRODUCTS", "MAIN_DEPENDENCY"):
                    key = v
                    if v == "COMMAND":
                        cur = []
                        cmds.append(cur)
                elif key == "OUTPUT":
                    outs.append(v)
                elif key == "COMMAND":
                    cur.append(v)
            self.custom.append((outs, cmds, here))
        elif name in ("si_add_library", "si_add_executable", "add_library", "add_executable"):
            vals = self.values(args, scope)
            tname, rest = vals[0], vals[1:]
            kind = "exe" if name.endswith("executable") else "static"
            if rest[:1] == ["INTERFACE"]:
                kind = "interface"
            t = Target(tname, kind, here, Path(scope["CMAKE_CURRENT_BINARY_DIR"]))
            t.win32 = "WIN32" in rest
            t.sources = [here / s if not Path(s).is_absolute() else Path(s)
                         for s in rest if s not in ("STATIC", "WIN32", "INTERFACE")]
            if name.startswith("si_"):
                self.si_defaults(t, scope)
            for o in scope.get("__compile_options", "").split(";"):
                if o:
                    t.usage["options"]["PRIVATE"].append(o)
            self.targets[tname] = t
        elif name.startswith("target_"):
            kind = {"target_include_directories": "includes",
                    "target_compile_definitions": "defines",
                    "target_compile_options": "options",
                    "target_link_libraries": "links",
                    "target_link_options": "link_options"}.get(name)
            if kind is None:
                raise Error(f"`{name}`")
            vals = self.values(args, scope)
            t, where = self.targets[vals[0]], None
            for v in vals[1:]:
                if v in ("PRIVATE", "PUBLIC", "INTERFACE"):
                    where = v
                elif v in ("SYSTEM", "BEFORE", "AFTER"):
                    continue
                else:
                    if kind == "includes" and not v.startswith("$<") and not Path(v).is_absolute():
                        v = str(here / v)
                    t.usage[kind][where or "PUBLIC"].append(v)
        elif name == "set_target_properties":
            pass
        elif name in IGNORED_CALLS or name in IGNORED:
            pass
        else:
            raise Error(f"`{name}` is not a command this evaluator carries out")

    def si_defaults(self, t: Target, scope: dict) -> None:
        """What `_si_set_target_defaults` gives a user-mode target in the
        clang-cl configuration: SI's clang diagnostics left off, and no WPP
        tracing."""
        if truthy(scope.get("MSVC_CLANG", "")):
            t.usage["options"]["PRIVATE"] += \
                [x for x in scope.get("SI_UM_CLANG_NO_DIAGNOSTICS", "").split(";") if x]
        if not truthy(scope.get("SI_WITH_WPP_USER", "")):
            t.usage["defines"]["PRIVATE"].append("SI_NO_WPP")

    # Usage requirements ---------------------------------------------------

    def interface(self, name: str, kind: str, seen=None) -> list[str]:
        """What target `name` passes on of `kind`: its PUBLIC and INTERFACE
        entries and those of the targets it links that way."""
        seen = seen if seen is not None else set()
        t = self.targets.get(name)
        if t is None or name in seen:
            return []
        seen.add(name)
        out = t.usage[kind]["PUBLIC"] + t.usage[kind]["INTERFACE"]
        for dep in t.usage["links"]["PUBLIC"] + t.usage["links"]["INTERFACE"]:
            out += self.interface(dep, kind, seen)
        return out

    def compile_usage(self, t: Target, kind: str) -> list[str]:
        out = t.usage[kind]["PRIVATE"] + t.usage[kind]["PUBLIC"]
        for links in t.usage["links"].values():
            for dep in links:
                out += self.interface(dep, kind)
        return list(dict.fromkeys(out))

    def link_closure(self, t: Target) -> tuple[list[str], list[str]]:
        """The static libraries an executable links, dependencies after
        dependents, and the other names it links."""
        libs, names, seen = [], [], set()

        def visit(name):
            dep = self.targets.get(name)
            if dep is None:
                if name not in names:
                    names.append(name)
                return
            if name in seen:
                return
            seen.add(name)
            if dep.kind == "static":
                libs.append(name)
            for links in dep.usage["links"].values():
                for n in links:
                    visit(n)

        for links in t.usage["links"].values():
            for n in links:
                visit(n)
        return libs, names


def evaluate(target: str, find, build: Path) -> CMake:
    cm = CMake(target, find)
    scope = dict(cm.vars)
    scope.update(CMAKE_CURRENT_SOURCE_DIR=str(SRC), CMAKE_CURRENT_LIST_DIR=str(SRC),
                 CMAKE_CURRENT_BINARY_DIR=str(build / "cmake"), CMAKE_SOURCE_DIR=str(SRC),
                 CMAKE_BINARY_DIR=str(build / "cmake"))
    cm.run_file(SRC / "CMakeLists.txt", scope)
    return cm


def vcxproj(path: Path, platform_name: str) -> dict:
    """A C console project's sources, manifests, definitions, include
    directories and libraries, as its Release configuration states them."""
    ns = "{http://schemas.microsoft.com/developer/msbuild/2003}"
    root = ET.parse(path).getroot()
    want = f"'$(Configuration)|$(Platform)'=='Release|{platform_name}'"
    group = next(g for g in root.iter(f"{ns}ItemDefinitionGroup")
                 if g.get("Condition", "").replace(" ", "") == want)

    def field(section, name):
        e = group.find(f"{ns}{section}/{ns}{name}")
        items = (e.text or "").split(";") if e is not None else []
        return [x for x in items if x and not x.startswith("%(")]

    def item(kind):
        return [path.parent / e.get("Include") for g in root.iter(f"{ns}ItemGroup")
                for e in g.iter(f"{ns}{kind}")]

    def macro(text):
        return text.replace("$(SystemInformerRoot)", str(SRC) + os.sep)

    return {
        "sources": item("ClCompile"),
        "manifests": item("Manifest"),
        "defines": field("ClCompile", "PreprocessorDefinitions"),
        "includes": [str((path.parent / macro(d)).resolve()) for d in
                     field("ClCompile", "AdditionalIncludeDirectories")],
        "libs": [Path(x).stem for x in field("Link", "AdditionalDependencies")],
        "console": field("Link", "SubSystem") == ["Console"],
    }


# --- The driver ----------------------------------------------------------------

# The driver's projects in link order: the static library, the export driver
# whose import library the driver links, the driver.
KERNEL_PROJECTS = [
    ("kphlib_km", Path("kphlib") / "kphlib_km.vcxproj"),
    ("ksidll", Path("KSystemInformer") / "ksidll.vcxproj"),
    ("KSystemInformer", Path("KSystemInformer") / "KSystemInformer.vcxproj"),
]
# The libraries a WDK driver project links by default.
WDK_DEFAULT_LIBS = ["ntoskrnl", "hal", "wmilib", "BufferOverflowFastFailK"]
# The driver serves a client whose image has a `.sig` from a key it holds
# (KSystemInformer/README.md, "Development"). The build makes a key pair once,
# under LOCAL_KEY, gives the driver its public half through a header the key
# table includes, and signs the programs. The key is of the Prod type: a Test
# key serves only in the developer mode an enabled kernel debugger turns on.
LOCAL_KEY = DEMO / ".cache" / "kph-local-key"
KEY_HEADER = "kphlocalkey.h"
KEY_HOOK = f"#if __has_include(<{KEY_HEADER}>)\n#include <{KEY_HEADER}>\n#endif\n"
# CustomSignTool's scheme, in BCrypt as it and the driver call it: RSA-4096
# blobs, and a PSS signature (SHA-512, 64-byte salt) over the file's SHA-512,
# written as `<stem>.sig`.
PSS_SALT = 64
MSBUILD_NS = "{http://schemas.microsoft.com/developer/msbuild/2003}"
# link.exe options of the kernel projects badc's linker takes, by spelling:
# `/INTEGRITYCHECK`, without which the kernel refuses the driver's process,
# thread and object callbacks.
LINK_OPTIONS = {"/INTEGRITYCHECK": "--force-integrity"}


def msbuild_condition(text: str, props: dict) -> bool:
    """An MSBuild `Condition` of the `'$(X)'=='v'` / `!=` form the kernel
    props and projects use, case-insensitively as MSBuild compares."""
    if not text.strip():
        return True
    expanded = re.sub(r"\$\((\w+)\)", lambda m: props.get(m.group(1), ""), text)
    m = re.fullmatch(r"\s*'?([^'=!]*)'?\s*(==|!=)\s*'([^']*)'\s*", expanded)
    if not m:
        raise Error(f"MSBuild condition `{text}`")
    return (m.group(1).strip().lower() == m.group(3).lower()) == (m.group(2) == "==")


def kernel_project(rel: Path, props: dict) -> dict:
    """A kernel project's sources and what it and Common.Kernel.props state
    for a Release build in their property and item-definition groups:
    definitions, include directories in order, dependencies, module
    definition file, `_NT_TARGET_VERSION`, the image's name, and the link
    options badc takes for link.exe's (LINK_OPTIONS)."""
    path = SRC / rel
    props = dict(props, ProjectDir=str(path.parent) + os.sep)
    out = {"defines": [], "includes": [], "libs": [], "def": None, "nt_target_version": None,
           "target_name": path.stem, "link": []}

    def expand(text: str) -> str:
        return re.sub(r"\$\((\w+)\)", lambda m: props.get(m.group(1), m.group(0)), text)

    def walk(e, parent: str = "") -> None:
        if not msbuild_condition(e.get("Condition", ""), props):
            return
        tag, text = e.tag.replace(MSBUILD_NS, ""), (e.text or "").strip()
        if (parent, tag) == ("Link", "AdditionalOptions"):
            out["link"] += [LINK_OPTIONS[o] for o in text.split() if o.upper() in LINK_OPTIONS]
        items = [x for x in expand(text).split(";") if x and not x.startswith("%(")]
        if tag == "PreprocessorDefinitions":
            out["defines"] += items
        elif tag == "AdditionalIncludeDirectories":
            out["includes"] += items
        elif tag == "AdditionalDependencies":
            out["libs"] += [Path(x).stem for x in items]
        elif tag == "ModuleDefinitionFile":
            out["def"] = path.parent / expand(text)
        elif tag == "_NT_TARGET_VERSION":
            out["nt_target_version"] = text
        elif tag == "TargetName":
            out["target_name"] = text
        for child in e:
            walk(child, tag)

    for doc in (SRC / "Common.Kernel.props", path):
        for group in ET.parse(doc).getroot():
            if group.tag.replace(MSBUILD_NS, "") in ("PropertyGroup", "ItemDefinitionGroup"):
                walk(group)
    out["sources"] = [path.parent / e.get("Include")
                      for g in ET.parse(path).getroot().iter(f"{MSBUILD_NS}ItemGroup")
                      for e in g.iter(f"{MSBUILD_NS}ClCompile")]
    return out


# --- Toolchain ----------------------------------------------------------------

class Toolchain:
    """badc, and the SDK and MSVC tools and directories cl, link and rc use."""

    def __init__(self, target: str, opt: str):
        if os.name != "nt":
            raise Error("System Informer builds on a Windows host: the SDK's mc.exe and "
                        "rc.exe and MSVC's cl.exe run there")
        self.target, self.opt = target, opt
        arch = _win_kits.ARCH[target]
        self.badc = os.environ.get("BADC") or str(REPO_ROOT / "target" / "release" / "badc.exe")
        if not Path(self.badc).is_file():
            raise Error(f"no badc at {self.badc}; cargo build --release --features full")
        kits = _win_kits.sdk_dirs(target)
        vc = _win_kits.msvc_tools(target)
        if kits is None or vc is None:
            raise Error("no Windows SDK (ucrt, um, shared) or MSVC tools with "
                        f"{arch} libraries; set BADC_WINDOWS_KITS / BADC_MSVC_TOOLS")
        self.sdk_version, sdk_inc, self.sdk_lib = kits
        self.include = [vc / "include", *sdk_inc, sdk_inc[1].parent / "winrt"]
        self.libdirs = [vc / "lib" / arch, *self.sdk_lib]
        host = "Hostarm64" if platform.machine().upper() == "ARM64" else "Hostx64"
        bin_dir = vc / "bin" / host / arch
        self.cl = bin_dir / "cl.exe"
        self.asm = bin_dir / ("ml64.exe" if arch == "x64" else "armasm64.exe")
        self.rc = self.find("rc")
        for tool in (self.cl, self.asm, self.rc):
            if not tool or not Path(tool).is_file():
                raise Error(f"missing tool {tool}")
        self.env = dict(os.environ)
        for k in ("INCLUDE", "LIB", "LIBPATH", "EXTERNAL_INCLUDE"):
            self.env.pop(k, None)
        # cl, rc and the assemblers read INCLUDE, as their MSBuild tasks set it.
        self.tool_env = dict(self.env, INCLUDE=";".join(map(str, self.include)))

    def find(self, name: str):
        return _win_kits.sdk_tool(self.sdk_version, f"{name}.exe") or shutil.which(name)


def run(cmd, env, cwd=None):
    r = subprocess.run([str(c) for c in cmd], capture_output=True, text=True,
                       errors="replace", env=env, cwd=cwd)
    return r.returncode, r.stdout + r.stderr


class BCrypt:
    """bcrypt.dll's RSA provider, which needs no key storage provider."""

    def __init__(self):
        import ctypes
        self.c = ctypes
        self.dll = ctypes.WinDLL("bcrypt")
        self.alg = ctypes.c_void_p()
        self.check(self.dll.BCryptOpenAlgorithmProvider(ctypes.byref(self.alg), "RSA", None, 0))

        class Pss(ctypes.Structure):
            _fields_ = [("alg", ctypes.c_wchar_p), ("salt", ctypes.c_ulong)]
        self.pss = Pss("SHA512", PSS_SALT)

    def check(self, status: int) -> None:
        if status:
            raise Error(f"BCrypt: NTSTATUS {status & 0xFFFFFFFF:#010x}")

    def generate(self) -> tuple[bytes, bytes]:
        """A new pair as (RSAPRIVATEBLOB, RSAPUBLICBLOB)."""
        key = self.c.c_void_p()
        self.check(self.dll.BCryptGenerateKeyPair(self.alg, self.c.byref(key), 4096, 0))
        self.check(self.dll.BCryptFinalizeKeyPair(key, 0))
        return self.export(key, "RSAPRIVATEBLOB"), self.export(key, "RSAPUBLICBLOB")

    def export(self, key, kind: str) -> bytes:
        size = self.c.c_ulong()
        self.check(self.dll.BCryptExportKey(key, None, kind, None, 0, self.c.byref(size), 0))
        buf = self.c.create_string_buffer(size.value)
        self.check(self.dll.BCryptExportKey(key, None, kind, buf, size, self.c.byref(size), 0))
        return buf.raw[:size.value]

    def key(self, blob: bytes, kind: str):
        key = self.c.c_void_p()
        self.check(self.dll.BCryptImportKeyPair(self.alg, None, kind, self.c.byref(key),
                                                blob, len(blob), 0))
        return key

    def sign(self, private: bytes, digest: bytes) -> bytes:
        key, size, flags = self.key(private, "RSAPRIVATEBLOB"), self.c.c_ulong(), 8
        pss = self.c.byref(self.pss)
        self.check(self.dll.BCryptSignHash(key, pss, digest, len(digest), None, 0,
                                           self.c.byref(size), flags))
        buf = self.c.create_string_buffer(size.value)
        self.check(self.dll.BCryptSignHash(key, pss, digest, len(digest), buf, size,
                                           self.c.byref(size), flags))
        return buf.raw[:size.value]

    def verify(self, public: bytes, digest: bytes, sig: bytes) -> bool:
        key = self.key(public, "RSAPUBLICBLOB")
        return self.dll.BCryptVerifySignature(key, self.c.byref(self.pss), digest, len(digest),
                                              sig, len(sig), 8) == 0


def dyn_config() -> bytes:
    """kphlib's embedded dynamic configuration, `KphDynConfig`: the bytes
    CustomBuildTool's `-dyndata` also writes as `ksidyn.bin`, which the
    client hands the driver with its `.sig`."""
    text = (SRC / "kphlib" / "kphdyn.c").read_text(encoding="utf-8")
    body = text[text.index("KphDynConfig[] =") :]
    body = body[body.index("{") + 1 : body.index("};")]
    return bytes(int(x, 16) for x in re.findall(r"0x([0-9a-fA-F]{2})", body))


def sign(files: list[Path]) -> list[Path]:
    """Write each file's `.sig` with LOCAL_KEY's private half."""
    bc, private = BCrypt(), (LOCAL_KEY / "kph.key").read_bytes()
    sigs = []
    for f in files:
        sig = f.with_suffix(".sig")
        sig.write_bytes(bc.sign(private, hashlib.sha512(f.read_bytes()).digest()))
        sigs.append(sig)
    return sigs


def unverified(files: list[Path]) -> list[Path]:
    """The files whose `.sig` LOCAL_KEY's public half does not verify."""
    bc, public = BCrypt(), (LOCAL_KEY / "public.key").read_bytes()
    return [f for f in files if not f.with_suffix(".sig").is_file()
            or not bc.verify(public, hashlib.sha512(f.read_bytes()).digest(),
                             f.with_suffix(".sig").read_bytes())]


def local_key() -> Path:
    """The directory holding KEY_HEADER for LOCAL_KEY's pair, made on first use."""
    public = LOCAL_KEY / "public.key"
    if not public.is_file():
        LOCAL_KEY.mkdir(parents=True, exist_ok=True)
        private, blob = BCrypt().generate()
        (LOCAL_KEY / "kph.key").write_bytes(private)
        public.write_bytes(blob)
    blob = public.read_bytes()
    # BCRYPT_RSAKEY_BLOB: `RSA1`, 4096 bits, a 3-byte exponent, a 512-byte modulus.
    if blob[:4] != b"RSA1" or struct.unpack_from("<4I", blob, 4)[:3] != (4096, 3, 512):
        raise Error(f"{public} is no RSA-4096 public key blob")
    rows = ",\n".join("        " + ", ".join(f"0x{b:02X}" for b in blob[i:i + 12])
                      for i in range(0, len(blob), 12))
    header = LOCAL_KEY / KEY_HEADER
    text = f"    {{\n        KphKeyTypeProd, // {LOCAL_KEY.name}\n        {{\n{rows}\n        }}\n    }},\n"
    if not header.is_file() or header.read_text() != text:
        header.write_text(text)
    return LOCAL_KEY


def first_error(text: str) -> str:
    lines = text.splitlines()
    for i, line in enumerate(lines):
        if re.search(r"\berror\b", line, re.I):
            return "\n".join(lines[i:i + 3])
    return "\n".join(lines[-3:])


# --- Build --------------------------------------------------------------------

class Build:
    def __init__(self, target: str, opt: str, jobs: int, log):
        self.target, self.jobs, self.log = target, jobs, log
        self.tools = Toolchain(target, opt)
        arch = _win_kits.ARCH[target]
        self.out = DEMO / ".cache" / f"build-{arch}{'' if opt == '-O' else opt}"
        self.bin = self.out / "bin"
        self.cm = evaluate(target, self.tools.find, self.out)
        self.failures: list[str] = []
        # Why the driver was not built, where it was not.
        self.driver_skipped: str | None = None

    def obj(self, t: str, src: Path, ext: str) -> Path:
        rel = src.relative_to(SRC) if src.is_relative_to(SRC) else Path(src.name)
        return self.out / "obj" / t / (str(rel).replace(os.sep, "__").replace("/", "__") + ext)

    def generate(self) -> None:
        """The custom commands: kphlib's message table through mc.exe."""
        for outs, cmds, here in self.cm.custom:
            for cmd in cmds:
                cmd = [x for c in cmd for x in self.cm.genex(c, "C")]
                if cmd[:3] == ["cmake", "-E", "make_directory"]:
                    for d in cmd[3:]:
                        Path(d).mkdir(parents=True, exist_ok=True)
                    continue
                rc, text = run(cmd, self.tools.tool_env, cwd=here)
                if rc:
                    raise Error(f"{' '.join(cmd)}: {first_error(text)}")
            for o in outs:
                for p in self.cm.genex(o, "C"):
                    if not Path(p).exists():
                        raise Error(f"the custom command did not write {p}")

    def jobs_for(self, name: str, t: Target | None, spec: dict | None = None):
        """The compile jobs of a target: (kind, source, object, command)."""
        cm, tools = self.cm, self.tools
        if spec is None:
            defines = [x for d in cm.compile_usage(t, "defines") for x in cm.genex(d, "C")]
            includes = [x for d in cm.compile_usage(t, "includes") for x in cm.genex(d, "C")]
            options = [x for d in cm.compile_usage(t, "options") for x in cm.genex(d, "C")]
            sources = [Path(x) for s in t.sources for x in cm.genex(str(s), "C")]
        else:
            defines, includes, options = spec["defines"], spec["includes"], []
            sources = spec["sources"]
        jobs = []
        base = [tools.badc, f"--target={self.target}", "-c", "--msvc", "-nostdlibinc", tools.opt]
        for d in tools.include:
            base += ["-isystem", str(d)]
        for src in sources:
            ext = src.suffix.lower()
            if ext == ".c":
                o = self.obj(name, src, ".o")
                cmd = base + options + [f"-D{x}" for x in defines] + \
                    [f"-I{x}" for x in includes] + [str(src), "-o", str(o)]
                jobs.append(("cc", src, o, cmd, src.parent))
            elif ext == ".cpp":
                o = self.obj(name, src, ".obj")
                # SI's MSVC release flags, but /WX and /W3: a newer cl warns
                # about more, and the warnings are SI's to settle.
                cmd = [tools.cl, "/nologo", "/c", "/O2", "/MT", "/guard:cf", "/EHsc", "/std:c++latest",
                       "/permissive-", "/utf-8", "/Zc:wchar_t", "/Zc:inline", "/GF", "/Gy",
                       "/W0"] + [f"/D{x}" for x in defines] + \
                    [f"/I{x}" for x in includes] + [str(src), f"/Fo{o}"]
                jobs.append(("cxx", src, o, cmd, src.parent))
            elif ext == ".asm":
                o = self.obj(name, src, ".obj")
                inc = [x for d in includes for x in ("-I", d)]
                if tools.asm.name == "ml64.exe":
                    cmd = [tools.asm, "/nologo", "/c"] + [f"/I{d}" for d in includes] + \
                        [f"/D{x}" for x in defines] + [f"/Fo{o}", str(src)]
                else:
                    cmd = [tools.asm, "-nologo"] + inc + ["-o", str(o), str(src)]
                jobs.append(("asm", src, o, cmd, src.parent))
            elif ext == ".rc":
                o = self.obj(name, src, ".res")
                cmd = [tools.rc, "/nologo", "/c", "65001"] + [f"/i{d}" for d in includes] + \
                    [f"/d{x}" for x in defines] + ["/fo", str(o), str(src)]
                jobs.append(("rc", src, o, cmd, src.parent))
            elif ext == ".manifest":
                # As link.exe embeds a /MANIFESTINPUT: RT_MANIFEST resource 1.
                o = self.obj(name, src, ".res")
                script = o.with_suffix(".rc")
                jobs.append(("manifest", src, o, [tools.rc, "/nologo", "/fo", str(o), str(script)],
                             src.parent))
        return jobs

    def compile(self, jobs) -> None:
        for _, _, o, _, _ in jobs:
            o.parent.mkdir(parents=True, exist_ok=True)

        def one(job):
            kind, src, o, cmd, cwd = job
            if kind == "manifest":
                path = str(src).replace("\\", "\\\\")
                o.with_suffix(".rc").write_text(f'1 24 "{path}"\n', encoding="utf-8")
            env = self.tools.env if kind == "cc" else self.tools.tool_env
            t0 = time.time()
            rc, text = run(cmd, env, cwd=cwd)
            return job, rc, text, time.time() - t0

        counts: dict[str, int] = {}
        with ThreadPoolExecutor(self.jobs) as ex:
            for (kind, src, o, _, _), rc, text, _ in ex.map(one, jobs):
                counts[kind] = counts.get(kind, 0) + 1
                if rc or not o.exists():
                    name = src.relative_to(SRC) if src.is_relative_to(SRC) else src
                    self.failures.append(f"{kind} {name}: {first_error(text)}")
        self.log(f"compiled: {', '.join(f'{n} {k}' for k, n in sorted(counts.items()))}")

    def archive(self, name: str, objs: list[Path]) -> Path:
        lib = self.out / "lib" / f"lib{name}.a"
        lib.parent.mkdir(parents=True, exist_ok=True)
        lib.unlink(missing_ok=True)
        rc, text = run([self.tools.badc, "--ar", "rcs", str(lib)] + [str(o) for o in objs],
                       self.tools.env)
        if rc:
            raise Error(f"archive {name}: {first_error(text)}")
        return lib

    def link(self, name: str, objs, resources, libs, names, delay, console: bool,
             defs=()) -> Path:
        exe = self.bin / f"{name}.exe"
        exe.parent.mkdir(parents=True, exist_ok=True)
        cmd = [self.tools.badc, f"--target={self.target}"] + ([] if console else ["-mwindows"])
        for d in self.tools.libdirs:
            cmd += ["-L", str(d)]
        cmd += [str(o) for o in objs] + [str(r) for r in resources] + [str(d) for d in defs]
        cmd += ["--start-group"] + [str(lib) for lib in libs] + ["--end-group"]
        cmd += [f"-l{n}" for n in names] + [f"-l{n}" for n in VC_RUNTIME]
        cmd += [f"--delayload={d}" for d in delay] + GUARD_LINK + ["-o", str(exe)]
        rc, text = run(cmd, self.tools.env, cwd=self.out)
        # The command as JSON, to run again; then what the link printed.
        log = json.dumps([str(c) for c in cmd]) + "\n\n" + text
        (self.out / f"{name}.link.log").write_text(log, encoding="utf-8")
        if rc or not exe.exists():
            raise Error(f"link {name}: {first_error(text)}")
        return exe

    def driver(self) -> list[Path]:
        """kphlib_km, ksi.dll and the driver, SystemInformer.sys as its project
        names it, for the target, under `bin/driver`; none, with the reason
        logged, where the WDK has no kernel-mode kit for it."""
        target, tools = self.target, self.tools
        found = _win_kits.wdk_flags(target, ["ntoskrnl"])
        if found is None:
            self.driver_skipped = f"no WDK kernel-mode headers and {target} libraries"
            return []
        version, flags = found
        libdir = flags[flags.index("-L") + 1]
        kit = {Path(flags[i + 1]).name: flags[i + 1] for i, f in enumerate(flags) if f == "-isystem"}
        props = {"Platform": PLATFORM[target], "Configuration": "Release", "KsiNoWpp": "true",
                 "KSI_NO_WPP": "1", "SystemInformerRoot": str(SRC) + os.sep,
                 "CRT_IncludePath": kit["crt"], "KM_IncludePath": kit["km"],
                 "KIT_SHARED_IncludePath": kit["shared"], "PlatformArchitecture": "64"}
        projects = {name: kernel_project(rel, props) for name, rel in KERNEL_PROJECTS}
        missing = [n for p in projects.values() for n in p["libs"] + WDK_DEFAULT_LIBS
                   if n not in projects and n not in ("ksi", "kphlib_km")
                   and not (Path(libdir) / f"{n}.lib").is_file()]
        if missing:
            self.driver_skipped = f"WDK {version} lacks {', '.join(sorted(set(missing)))}.lib"
            return []
        # `_NT_TARGET_VERSION` names a Windows release: its high word alone,
        # as 0x0A00 does, or a full NTDDI value.
        ntv = int(projects["KSystemInformer"]["nt_target_version"], 16)
        ntddi = ntv << 16 if ntv <= 0xFFFF else ntv
        generated = sorted({str(Path(x).parent) for outs, _, _ in self.cm.custom for o in outs
                            for x in self.cm.genex(o, "C") if x.lower().endswith(".h")})
        drv = self.out / "obj" / "driver"
        # The key table takes LOCAL_KEY's public half after SI's own.
        verify = SRC / "KSystemInformer" / "verify.c"
        table = verify.read_text(encoding="utf-8")
        start = table.index("KphpPublicKeys[] =")
        end = table.index("\n};", start) + 1
        last = table[:end].rstrip()
        hooked = drv / "local-key" / "verify.c"
        hooked.parent.mkdir(parents=True, exist_ok=True)
        hooked.write_text(last + ("" if last.endswith(",") else ",") + "\n" + KEY_HOOK + table[end:],
                          encoding="utf-8")
        key_dir = local_key()
        jobs = []
        for name, p in projects.items():
            defines = p["defines"] + ["_KERNEL_MODE", f"NTDDI_VERSION={ntddi:#010x}",
                                      f"_WIN32_WINNT={ntddi >> 16:#06x}",
                                      f"WINVER={ntddi >> 16:#06x}", "WINNT=1"]
            includes = [d for d in p["includes"] + generated
                        if "$(" not in d and Path(d).is_dir()] + [str(key_dir)]
            for src in p["sources"]:
                o = drv / name / (src.stem + ".o")
                src = hooked if src.resolve() == verify.resolve() else src
                cmd = [tools.badc, f"--target={target}", "-c", "--msvc", "-nostdlibinc", tools.opt]
                cmd += [f for f in flags if f.startswith("-D")] + [f"-D{d}" for d in defines]
                cmd += [f"-I{d}" for d in dict.fromkeys(includes)] + [str(src), "-o", str(o)]
                jobs.append(("cc", src, o, cmd, src.parent))
        self.compile(jobs)
        if self.failures:
            raise Error(f"driver: {len(self.failures)} units failed:\n" + "\n".join(self.failures[:20]))
        objs = {n: [str(j[2]) for j in jobs if j[2].is_relative_to(drv / n)] for n in projects}
        out = self.bin / "driver"
        out.mkdir(parents=True, exist_ok=True)
        kphlib = self.archive("kphlib_km", [Path(o) for o in objs["kphlib_km"]])
        base = [tools.badc, f"--target={target}", "--subsystem=driver", "-L", libdir]
        ksi = out / (projects["ksidll"]["target_name"] + ".dll")
        implib = self.out / "lib" / ksi.with_suffix(".lib").name
        # An export driver defines no DriverEntry; its entry is DllInitialize.
        cmd = base + projects["ksidll"]["link"]
        cmd += ["-shared", "--entry=DllInitialize", *objs["ksidll"], str(projects["ksidll"]["def"]),
                      "--out-implib", str(implib)] + [f"-l{n}" for n in WDK_DEFAULT_LIBS]
        rc, text = run(cmd + ["-o", str(ksi)], tools.env)
        if rc or not ksi.exists():
            raise Error(f"link {ksi.name}: {first_error(text)}")
        # The WDK enters a driver at GsDriverEntry, which seeds the stack
        # cookie and calls DriverEntry.
        # SystemInformer.sys: SI loads the driver from its own name.
        sys_file = out / (projects["KSystemInformer"]["target_name"] + ".sys")
        libs = [n for n in projects["KSystemInformer"]["libs"] if n not in ("ksi", "kphlib_km")]
        cmd = base + projects["KSystemInformer"]["link"]
        cmd += ["--entry=GsDriverEntry", *objs["KSystemInformer"], str(kphlib), str(implib)]
        cmd += [f"-l{n}" for n in dict.fromkeys(libs + WDK_DEFAULT_LIBS)] + ["-o", str(sys_file)]
        rc, text = run(cmd, tools.env)
        if rc or not sys_file.exists():
            raise Error(f"link {sys_file.name}: {first_error(text)}")
        self.log(f"driver: WDK {version}, NTDDI_VERSION {ntddi:#010x}")
        return [ksi, sys_file]

    def go(self) -> list[Path]:
        t0 = time.time()
        self.generate()
        cm = self.cm
        wanted, closure = [], {}
        for name in TARGETS:
            closure[name] = cm.link_closure(cm.targets[name])
            wanted += [n for n in [name] + closure[name][0] if n not in wanted]
        # phlib-test links phlib.lib, the CMake target, with what it links,
        # and builds with phlib's usage requirements. Its Release NDEBUG is
        # left out: the test checks with assert().
        test = vcxproj(SRC / "tools" / "tests" / "phlib-test" / "phlib-test.vcxproj",
                       PLATFORM[self.target])
        phlib_libs, phlib_names = cm.link_closure(cm.targets["phlib"])
        closure["phlib-test"] = (["phlib"] + phlib_libs, phlib_names)
        spec = {
            "defines": [d for d in test["defines"] if d != "NDEBUG"]
            + [x for d in cm.interface("phlib", "defines") for x in cm.genex(d, "C")],
            "includes": test["includes"]
            + [x for d in cm.interface("phlib", "includes") for x in cm.genex(d, "C")],
            "sources": test["sources"] + test["manifests"],
        }
        jobs = [j for n in wanted for j in self.jobs_for(n, cm.targets[n])]
        jobs += self.jobs_for("phlib-test", None, spec)
        # The resource scripts the custom commands generate -- kphlib's
        # message table -- join both programs, as their MSBuild projects
        # compile it; the CMake lists name it as an output only.
        generated = [Path(x) for outs, _, _ in cm.custom for o in outs
                     for x in cm.genex(o, "C") if x.lower().endswith(".rc")]
        jobs += self.jobs_for("generated", None, {"defines": [], "includes": [],
                                                   "sources": generated})
        self.compile(jobs)
        if self.failures:
            raise Error(f"{len(self.failures)} units failed:\n" + "\n".join(self.failures[:20]))

        def of(n, kinds):
            return [j[2] for j in jobs if j[0] in kinds and j[2].is_relative_to(self.out / "obj" / n)]

        archives = {n: self.archive(n, of(n, ("cc", "cxx", "asm")))
                    for n in wanted if cm.targets[n].kind == "static"}
        outputs = []
        for name in TARGETS + ["phlib-test"]:
            libs, names = closure[name]
            res = of(name, ("rc", "manifest")) + (of("generated", ("rc",)) if name in TARGETS else [])
            t = cm.targets.get(name)
            if t is None:
                names = names + [x for x in test["libs"] if x != "phlib"] + VS_DEFAULT_LIBS
                defs, delay, console = [], [], test["console"]
            else:
                defs = [s for s in t.sources if s.suffix.lower() == ".def"]
                delay, console = [], not t.win32
                for opt in (x for o in t.usage["link_options"]["PRIVATE"] for x in cm.genex(o, "C")):
                    if not opt.upper().startswith("/DELAYLOAD:"):
                        raise Error(f"{name}: link option `{opt}`")
                    delay.append(opt.split(":", 1)[1])
            # link.exe takes the delay-load helper from delayimp.lib; badc's
            # --delayload supplies its own.
            names = [n for n in dict.fromkeys(names) if n != "delayimp"]
            outputs.append(self.link(name, of(name, ("cc", "cxx", "asm")), res,
                                     [archives[x] for x in libs], names, delay, console, defs))
        driver = self.driver()
        if driver:
            dyn = self.bin / "ksidyn.bin"
            dyn.write_bytes(dyn_config())
            outputs += [dyn] + sign([p for p in outputs if p.stem in TARGETS] + [dyn])
        outputs += driver
        self.log(f"built {', '.join(p.name for p in outputs)} in {time.time() - t0:.0f} s")
        return outputs


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    host = "windows-arm64" if platform.machine().upper() == "ARM64" else "windows-x64"
    parser.add_argument("--target", default=host, choices=sorted(PROCESSOR))
    parser.add_argument("--opt", default="-O", choices=["-O", "-O0"])
    parser.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    if not (SRC / "CMakeLists.txt").is_file():
        print(f"build: no source at {SRC}; run demos/systeminformer/setup.py", file=sys.stderr)
        return 1
    try:
        build = Build(args.target, args.opt, args.jobs, log)
        for p in build.go():
            print(p)
        if build.driver_skipped:
            print(f"build: the driver was not built: {build.driver_skipped}", file=sys.stderr)
    except Error as e:
        print(f"build: {e}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
