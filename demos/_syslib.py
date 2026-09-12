"""Resolve a system shared library for a demo's link step.

A demo that links a system library by name cannot simply pass
``-l<name>`` to the host compiler on Linux: that spelling resolves
through the ``lib<name>.so`` symlink the development package installs,
and a runner may carry only the runtime package. The runtime file
(``lib<name>.so.<n>``) is always there, so it is located here and handed
to the host compiler as a path. badc's own ``-l`` lookup accepts the
versioned name, so badc keeps the ``-l`` spelling, with the host named
as the sysroot: badc reads no library directory the command line does
not declare.

macOS ships the libraries in the SDK, where ``-l<name>`` resolves for
both compilers once the SDK is the sysroot.
"""

from __future__ import annotations

import glob
import os
import subprocess
import sys

# Where the Linux distributions keep the shared libraries.
LIB_DIRS = (
    "/usr/lib64",
    "/lib64",
    "/usr/lib",
    "/lib",
    "/usr/lib/x86_64-linux-gnu",
    "/usr/lib/aarch64-linux-gnu",
)


def sysroot_args() -> list[str]:
    """The ``--sysroot`` that puts the host's own library and header
    directories on badc's search path: the root on Linux, the SDK
    (``$SDKROOT``, else ``xcrun --show-sdk-path``) on macOS."""
    if sys.platform != "darwin":
        return ["--sysroot=/"]
    sdk = os.environ.get("SDKROOT")
    if not sdk:
        proc = subprocess.run(
            ["xcrun", "--show-sdk-path"], capture_output=True, text=True
        )
        sdk = proc.stdout.strip() if proc.returncode == 0 else ""
    return [f"--sysroot={sdk}"] if sdk else []


def shared_library(
    linux_names: tuple[str, ...], macos_name: str
) -> tuple[list[str], list[str]] | None:
    """The link inputs for badc and for the host compiler, or None when
    no Linux candidate is installed. `linux_names` is tried in order --
    the first that has a runtime file wins."""
    if sys.platform == "darwin":
        return [*sysroot_args(), f"-l{macos_name}"], [f"-l{macos_name}"]
    for name in linux_names:
        for d in LIB_DIRS:
            found = sorted(glob.glob(f"{d}/lib{name}.so*"), key=len)
            if found:
                return [*sysroot_args(), f"-l{name}"], [found[0]]
    return None


def termcap_library() -> tuple[list[str], list[str]] | None:
    """The terminfo entry points a termcap / curses program calls:
    libtinfo where ncurses is split, else libncurses; the SDK's
    libcurses on macOS."""
    return shared_library(("tinfo", "ncursesw", "ncurses"), "curses")


def crypt_library() -> tuple[list[str], list[str]] | None:
    """XSI password hashing. A separate library on Linux (libxcrypt, or
    glibc's own before it was split out); in libSystem on macOS, where
    the link needs no entry of its own."""
    if sys.platform == "darwin":
        return [], []
    return shared_library(("crypt",), "")
