#!/usr/bin/env python3
"""Produce a badc-probed kernel configuration.

The sweep replays compile commands captured from a gcc reference build. The
kernel's Kconfig probes compiler capabilities at configure time with whatever
compiler configured the tree, so the reference toolchain's capability symbols
are baked into ``include/generated/autoconf.h`` and are replayed as if badc had
them. Measured consequence on x86_64: ``CONFIG_CC_HAS_NAMED_AS=1`` is baked in,
so most units fail on ``__seg_gs``, a named-address-space extension badc does
not implement and a badc-probed configuration would simply switch off.

This script re-runs the kernel's own configuration step with ``ccshim.py`` as
``$(CC)``, so Kconfig's probes actually exercise badc, and reports every symbol
that moved. Its product is a badc-probed ``include/generated/autoconf.h`` that
``sweep.py --probed-autoconf`` substitutes for the reference one.

The probe tree must be a fresh kernel tree that is not the reference build tree
(``setup.py --cache <dir>`` without ``--build`` produces one); configuring
writes ``.config`` and the generated headers, and the reference corpus must
stay as it was captured.
"""

from __future__ import annotations

import argparse
import os
import platform
import re
import subprocess
import sys
from pathlib import Path

LINUX_DIR = Path(__file__).resolve().parent
REPO_ROOT = LINUX_DIR.parents[1]

TARGETS = {"x86_64": "linux-x64", "aarch64": "linux-aarch64"}
KARCH = {"x86_64": "x86_64", "aarch64": "arm64"}


def log(m: str) -> None:
    print(f"linux probecfg: {m}", flush=True)


def host_arch() -> str:
    m = platform.machine().lower()
    if m in ("arm64", "aarch64"):
        return "aarch64"
    if m in ("x86_64", "amd64"):
        return "x86_64"
    return m


def read_config(path: Path) -> dict[str, str]:
    """CONFIG_x -> value; symbols set to n are absent, as in the file."""
    out: dict[str, str] = {}
    for ln in path.read_text(errors="replace").splitlines():
        m = re.match(r"^(CONFIG_\w+)=(.*)$", ln)
        if m:
            out[m.group(1)] = m.group(2)
        else:
            m = re.match(r"^# (CONFIG_\w+) is not set$", ln)
            if m:
                out[m.group(1)] = "n"
    return out


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--kernel-dir", type=Path, required=True,
                    help="fresh kernel tree to configure (not the reference build tree)")
    ap.add_argument("--arch", choices=sorted(TARGETS), default=host_arch())
    ap.add_argument("--badc", help="badc binary (default: $BADC or target/release/badc)")
    ap.add_argument("--ref-cc", default=os.environ.get("PROBECFG_REF_CC", "gcc"),
                    help="reference compiler for the delegated probe classes")
    ap.add_argument("--config", type=Path,
                    help="starting .config (default: the vendored config for --arch)")
    args = ap.parse_args(argv)

    kdir = args.kernel_dir.resolve()
    if not (kdir / "Makefile").is_file():
        sys.exit(f"linux probecfg: {kdir} is not a kernel tree")
    # scripts/ and tools/ hold host-tool builds that configuring produces by
    # itself; a .cmd file anywhere else means this is a reference build tree.
    built = next((p for p in kdir.rglob(".*.o.cmd")
                  if p.relative_to(kdir).parts[0] not in ("scripts", "tools")), None)
    if built is not None:
        sys.exit(f"linux probecfg: {kdir} holds a build ({built.relative_to(kdir)}); "
                 "configure a fresh tree instead so the reference corpus stays "
                 "as it was captured")

    badc = Path(args.badc or os.environ.get("BADC")
                or REPO_ROOT / "target" / "release" / "badc").resolve()
    if not (badc.is_file() and os.access(badc, os.X_OK)):
        sys.exit(f"linux probecfg: badc binary not found at {badc}")

    start = args.config
    if start is None:
        vers = kdir.name.removeprefix("linux-")
        start = LINUX_DIR / "configs" / f"{args.arch}-{vers}.config"
    if not start.is_file():
        sys.exit(f"linux probecfg: missing starting config {start}")

    # Baseline: the same starting config configured by the reference compiler,
    # so the reported deviation is exactly what the probe compiler changed.
    text = re.sub(r'(?m)^CONFIG_INITRAMFS_SOURCE=.*$',
                  'CONFIG_INITRAMFS_SOURCE=""', start.read_text())
    (kdir / ".config").write_text(text)
    env = dict(os.environ, ARCH=KARCH[args.arch])
    log(f"reference olddefconfig (CC={args.ref_cc})")
    subprocess.run(["make", "olddefconfig", f"CC={args.ref_cc}"], cwd=kdir,
                   check=True, env=env, stdout=subprocess.DEVNULL)
    ref_cfg = read_config(kdir / ".config")

    shim = LINUX_DIR / "ccshim.py"
    probe_log = kdir / "probecfg-probes.log"
    probe_log.unlink(missing_ok=True)
    env.update(BADC=str(badc), PROBECFG_REF_CC=args.ref_cc,
               PROBECFG_TARGET=TARGETS[args.arch], PROBECFG_LOG=str(probe_log))
    (kdir / ".config").write_text(text)
    log(f"badc-probed olddefconfig (CC={shim.name}, badc={badc})")
    r = subprocess.run(["make", "olddefconfig",
                        f"CC={sys.executable} {shim}"],
                       cwd=kdir, env=env, capture_output=True, text=True)
    if r.returncode != 0:
        sys.stderr.write(r.stdout + r.stderr)
        sys.exit("linux probecfg: badc-probed olddefconfig failed")
    probe_cfg = read_config(kdir / ".config")
    # olddefconfig writes .config; the generated headers come from syncconfig.
    subprocess.run(["make", "syncconfig", f"CC={sys.executable} {shim}"],
                   cwd=kdir, env=env, check=True, stdout=subprocess.DEVNULL)

    moved = sorted(k for k in set(ref_cfg) | set(probe_cfg)
                   if ref_cfg.get(k, "n") != probe_cfg.get(k, "n"))
    lines = [f"{k}: {ref_cfg.get(k, 'n')} -> {probe_cfg.get(k, 'n')}" for k in moved]
    dev = kdir / f"probe-deviations-{args.arch}.txt"
    dev.write_text("\n".join(lines) + ("\n" if lines else ""))

    n_badc = n_ref = 0
    if probe_log.is_file():
        for ln in probe_log.read_text(errors="replace").splitlines():
            if ln.startswith("badc:"):
                n_badc += 1
            elif ln.startswith("ref:"):
                n_ref += 1
    # The generated header is the mode's actual product, so check it against the
    # probed .config rather than trusting that syncconfig ran: a stale header
    # would report a probed configuration while replaying the reference one.
    autoconf = kdir / "include" / "generated" / "autoconf.h"
    if not autoconf.is_file():
        sys.exit("linux probecfg: no autoconf.h was generated")
    defined = set(re.findall(r"(?m)^#define (CONFIG_\w+)", autoconf.read_text()))
    stale = [k for k in moved if (probe_cfg.get(k, "n") == "n") == (k in defined)]
    if stale:
        sys.exit("linux probecfg: autoconf.h disagrees with the probed .config "
                 f"on {len(stale)} symbols (first: {stale[0]}); it is stale")
    log(f"probes: {n_badc} answered by badc, {n_ref} delegated to {args.ref_cc}")
    log(f"{len(moved)} config symbols moved -> {dev}")
    for ln in lines:
        print("  " + ln)
    log(f"probed autoconf.h -> {autoconf}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
