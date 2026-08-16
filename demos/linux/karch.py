#!/usr/bin/env python3
"""Kbuild architecture selection for the kernel scripts.

Kbuild takes its target from ``ARCH`` and its tool prefix from
``CROSS_COMPILE``; with neither set it configures and builds for the host,
whatever architecture was asked for. These helpers name both, report what a
cross build needs that the host does not have, and read back the
architecture a configured tree actually carries.

``--self-test`` runs the checks and takes no tree; ``verify.py --self-test``
includes them.
"""

from __future__ import annotations

import os
import platform
import shutil
import sys
import tempfile
from pathlib import Path
from typing import NamedTuple


class Arch(NamedTuple):
    karch: str
    prefix: str
    selector: str


# The selector is the architecture's own `def_bool y` symbol -- `X86_64` in
# arch/x86/Kconfig, `ARM64` in arch/arm64/Kconfig -- set only when kbuild
# sourced that architecture. The `# Linux/<ARCH>` heading does not serve the
# same purpose: it records the ARCH spelling as given, so a natively
# configured x86_64 tree reads `Linux/x86`.
ARCHES = {
    "x86_64": Arch("x86_64", "x86_64-linux-gnu-", "CONFIG_X86_64"),
    "aarch64": Arch("arm64", "aarch64-linux-gnu-", "CONFIG_ARM64"),
}

# Tools kbuild resolves through CROSS_COMPILE, plus gcc: it is the reference
# build's compiler and the badc shim's fallback.
CROSS_TOOLS = ("gcc", "ld", "objcopy", "nm", "ar", "strip")


def host_arch() -> str:
    m = platform.machine().lower()
    if m in ("arm64", "aarch64"):
        return "aarch64"
    if m in ("x86_64", "amd64"):
        return "x86_64"
    return m


def tool(arch: str, name: str) -> str:
    """`name`, cross-prefixed when `arch` is not the host."""
    return name if arch == host_arch() else ARCHES[arch].prefix + name


def cross_gap(arch: str) -> str:
    """Why `arch` cannot be built on this host, or "" when it can."""
    if arch not in ARCHES:
        return f"no kbuild architecture mapping for {arch!r}"
    if arch == host_arch():
        return ""
    prefix = ARCHES[arch].prefix
    missing = [prefix + t for t in CROSS_TOOLS if not shutil.which(prefix + t)]
    if not missing:
        return ""
    return (f"{arch} is a cross build on this {host_arch()} host and needs a "
            f"{prefix} toolchain; not on PATH: {' '.join(missing)}")


def make_env(arch: str, env: dict[str, str] | None = None) -> dict[str, str]:
    """`env` (default the process environment) with the kbuild architecture
    named. The top Makefile takes ARCH with `?=`, never assigns
    CROSS_COMPILE, and exports both, so the environment reaches every
    sub-make."""
    out = dict(os.environ if env is None else env)
    out["ARCH"] = ARCHES[arch].karch
    if arch == host_arch():
        out.pop("CROSS_COMPILE", None)
    else:
        out["CROSS_COMPILE"] = ARCHES[arch].prefix
    return out


def config_arch(config: Path) -> str:
    """The architecture `config` selects, or "" when no selector is set."""
    lines = set(config.read_text(errors="replace").splitlines())
    for name, spec in ARCHES.items():
        if f"{spec.selector}=y" in lines:
            return name
    return ""


def config_heading(config: Path) -> str:
    """The kconfig heading, which names the ARCH the tree was configured
    with."""
    for ln in config.read_text(errors="replace").splitlines()[:8]:
        if ln.startswith("# Linux/"):
            return ln[2:]
    return "no kconfig heading"


def config_mismatch(config: Path, arch: str) -> str:
    """Why `config` is not a tree for `arch`, or "" when it is."""
    got = config_arch(config)
    if got == arch:
        return ""
    return (f"{config} configures {got or 'no supported architecture'}, not "
            f"the requested {arch}: {ARCHES[arch].selector}=y is absent and "
            f"the tree reads \"{config_heading(config)}\". Kbuild takes the "
            f"target from ARCH=, which defaults to the host.")


def self_test() -> None:
    host = host_arch()
    other = next(a for a in ARCHES if a != host)
    assert tool(host, "gcc") == "gcc"
    assert cross_gap(host) == ""
    assert cross_gap("mips64")
    assert make_env(host, {})["ARCH"] == ARCHES[host].karch
    assert "CROSS_COMPILE" not in make_env(host, {"CROSS_COMPILE": "stale-"})
    assert tool(other, "gcc") == ARCHES[other].prefix + "gcc"
    assert make_env(other, {})["CROSS_COMPILE"] == ARCHES[other].prefix

    with tempfile.TemporaryDirectory() as d:
        cfg = Path(d) / ".config"
        # A natively configured x86_64 tree heads `Linux/x86`, so the
        # selector is what identifies it. The erratum symbol is the case a
        # substring search gets wrong.
        cfg.write_text("#\n# Automatically generated file; DO NOT EDIT.\n"
                       "# Linux/x86 7.1.6 Kernel Configuration\n#\n"
                       "CONFIG_X86_64=y\nCONFIG_ARM64_ERRATUM_843419=y\n")
        assert config_arch(cfg) == "x86_64"
        assert config_mismatch(cfg, "x86_64") == ""
        m = config_mismatch(cfg, "aarch64")
        assert "configures x86_64" in m and "Linux/x86 7.1.6" in m, m

        cfg.write_text("#\n# Linux/arm64 7.1.6 Kernel Configuration\n#\n"
                       "CONFIG_ARM64=y\n")
        assert config_arch(cfg) == "aarch64"
        assert config_mismatch(cfg, "aarch64") == ""

        cfg.write_text("# CONFIG_X86_64 is not set\nCONFIG_64BIT=y\n")
        assert config_arch(cfg) == ""
        assert "no supported architecture" in config_mismatch(cfg, "x86_64")


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        self_test()
        print("linux karch: self-test ok", flush=True)
    else:
        raise SystemExit("usage: karch.py --self-test")
