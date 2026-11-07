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
