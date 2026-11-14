"""Locate an installed Windows SDK or WDK for a demo's kit mode.

The kits install under ``Windows Kits\\10``: ``Include\\<version>\\{um,shared,
km,km\\crt}`` and ``Lib\\<version>\\{um,km}\\<arch>``. ``BADC_WINDOWS_KITS``
names another root and ``BADC_WINDOWS_KITS_VERSION`` pins a version;
otherwise the newest version holding the files a mode needs is taken. A
kit build passes ``--msvc``, as the kits' headers expect cl's identity, and
the architecture macros the WDK's build properties define.
"""

from __future__ import annotations

import os
import platform
from pathlib import Path

DEFAULT_ROOT = Path(r"C:\Program Files (x86)\Windows Kits\10")
ARCH = {"windows-x64": "x64", "windows-arm64": "arm64"}
# What the WDK's MSBuild properties define per architecture.
WDK_DEFINES = {
    "windows-x64": ["-D_AMD64_", "-DAMD64", "-D_WIN64"],
    "windows-arm64": ["-D_ARM64_", "-DARM64", "-D_WIN64"],
}


def _root() -> Path:
    env = os.environ.get("BADC_WINDOWS_KITS")
    return Path(env) if env else DEFAULT_ROOT


def _versions(root: Path) -> list[str]:
    pinned = os.environ.get("BADC_WINDOWS_KITS_VERSION")
    if pinned:
        return [pinned]
    inc = root / "Include"
    if not inc.is_dir():
        return []
    names = [p.name for p in inc.iterdir() if p.name[:1].isdigit()]
    return sorted(names, key=lambda v: tuple(int(x) for x in v.split(".")), reverse=True)


def _flags(target: str, include: list[str], header: str, lib: str, libs: list[str]):
    root = _root()
    arch = ARCH[target]
    for v in _versions(root):
        inc = [root / "Include" / v / d for d in include]
        libdir = root / "Lib" / v / lib / arch
        if (inc[0] / header).is_file() and (libdir / f"{libs[0]}.lib").is_file():
            flags = ["--msvc"]
            for d in inc:
                flags += ["-isystem", str(d)]
            flags += ["-L", str(libdir)] + [f"-l{name}" for name in libs]
            return v, flags
    return None


def sdk_flags(target: str, libs: list[str]):
    """``(version, flags)`` building a user-mode program against the SDK."""
    return _flags(target, ["um", "shared"], "windows.h", "um", libs)


def wdk_flags(target: str, libs: list[str]):
    """``(version, flags)`` building a kernel-mode driver against the WDK."""
    found = _flags(target, ["km", "km/crt", "shared"], "wdm.h", "km", libs)
    if found is None:
        return None
    version, flags = found
    return version, flags + WDK_DEFINES[target]


def sdk_dirs(target: str):
    """``(version, include dirs, library dirs)`` of the SDK as cl's INCLUDE and
    link.exe's LIB name them for a desktop program on the UCRT: the ucrt, um
    and shared headers and the ucrt and um import libraries."""
    root = _root()
    arch = ARCH[target]
    for v in _versions(root):
        inc = [root / "Include" / v / d for d in ("ucrt", "um", "shared")]
        lib = [root / "Lib" / v / d / arch for d in ("ucrt", "um")]
        if (inc[0] / "stdio.h").is_file() and (lib[0] / "ucrt.lib").is_file() \
                and (lib[1] / "kernel32.lib").is_file():
            return v, inc, lib
    return None


def msvc_tools(target: str):
    """The ``VC\\Tools\\MSVC\\<version>`` directory whose headers and libraries
    cl and link.exe take: ``BADC_MSVC_TOOLS``, else the newest installed
    version carrying vcruntime.h and the target's vcruntime.lib."""
    arch = ARCH[target]

    def complete(d: Path) -> bool:
        return (d / "include" / "vcruntime.h").is_file() and \
            (d / "lib" / arch / "vcruntime.lib").is_file()

    env = os.environ.get("BADC_MSVC_TOOLS")
    if env:
        return Path(env) if complete(Path(env)) else None
    found = []
    for base in (os.environ.get("ProgramFiles"), os.environ.get("ProgramFiles(x86)")):
        vs = Path(base or "") / "Microsoft Visual Studio"
        if not base or not vs.is_dir():
            continue
        found += [d for d in vs.glob("*/*/VC/Tools/MSVC/*") if complete(d)]
    key = lambda d: tuple(int(x) for x in d.name.split(".") if x.isdigit())  # noqa: E731
    return max(found, key=key) if found else None


def sdk_tool(version: str, name: str):
    """The SDK's ``bin\\<version>\\<host arch>\\<name>`` (rc.exe, mt.exe), where
    the host runs it."""
    host = "arm64" if platform.machine().upper() == "ARM64" else "x64"
    tool = _root() / "bin" / version / host / name
    return tool if tool.is_file() else None
