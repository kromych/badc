#!/usr/bin/env python3
"""Pass/fail gate for the badc-compiled Linux kernel.

Runs the hybrid build described in README.md ("Hybrid build") with an empty
fallback list, so every kernel C unit goes through badc, then boots the result
under qemu. Unlike sweep.py, which measures and ranks, this asserts: any unit
badc cannot compile, any undefined reference at link, or any boot that does
not reach the marker fails the run.

    python3 demos/linux/verify.py --kernel-dir <writable tree> \
        --initramfs <image> --expect-units 1912

The tree must already be configured (setup.py) and must be writable: the build
runs in it. It is rebuilt from clean by default, because make skips units whose
objects are already current and a gate that compiles nothing passes vacuously.
"""

from __future__ import annotations

import argparse
import json
import os
import platform
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

LINUX_DIR = Path(__file__).resolve().parent
REPO_ROOT = LINUX_DIR.parents[1]

ARCHES = {
    "x86_64": {
        "target": "linux-x64",
        "make_target": "bzImage",
        "image": "arch/x86/boot/bzImage",
        "qemu": "qemu-system-x86_64",
        "machine": [],
        "console": "ttyS0",
        "extra_append": [],
    },
    "aarch64": {
        "target": "linux-aarch64",
        "make_target": "Image",
        "image": "arch/arm64/boot/Image",
        "qemu": "qemu-system-aarch64",
        "machine": ["-M", "virt", "-cpu", "max"],
        "console": "ttyAMA0",
        "extra_append": ["earlycon=pl011,0x9000000"],
    },
}

DEFAULT_MARKER = "BADC-VMLINUX-OK"


def log(m: str) -> None:
    print(f"linux verify: {m}", flush=True)


def die(m: str) -> "None":
    print(f"linux verify: FAIL: {m}", flush=True)
    sys.exit(1)


def read_manifest(path: Path) -> dict[str, list[str]]:
    """Group the shim's per-unit lines by verdict."""
    out: dict[str, list[str]] = {"badc": [], "fallback": [], "fail": []}
    if not path.exists():
        return out
    for line in path.read_text(errors="replace").splitlines():
        verdict, _, rest = line.partition("\t")
        if verdict in out:
            out[verdict].append(rest)
    return out


def build(args, arch: dict, tree: Path, manifest: Path) -> tuple[int, float, Path]:
    env = dict(os.environ)
    env.update(
        BADC=str(args.badc),
        BADC_REAL_CC=args.real_cc,
        BADC_TARGET=arch["target"],
        BADC_MANIFEST=str(manifest),
        BADC_TIMEOUT=str(args.timeout),
    )
    if args.fallback:
        env["BADC_FALLBACK"] = str(Path(args.fallback).resolve())
    else:
        env.pop("BADC_FALLBACK", None)
    if args.weaken:
        env["BADC_WEAKEN"] = args.weaken
    else:
        env.pop("BADC_WEAKEN", None)

    manifest.unlink(missing_ok=True)
    if args.clean:
        log("make clean")
        subprocess.run(["make", "clean"], cwd=tree, env=env,
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    shim = LINUX_DIR / "buildcc.py"
    cmd = ["make", f"-j{args.jobs}", f"CC={shim}", arch["make_target"]]
    log(f"{' '.join(cmd)} (in {tree})")
    build_log = Path(args.workdir) / f"build-{args.arch}.log"
    start = time.time()
    with build_log.open("wb") as fh:
        rc = subprocess.run(cmd, cwd=tree, env=env, stdout=fh,
                            stderr=subprocess.STDOUT).returncode
    return rc, time.time() - start, build_log


def boot(args, arch: dict, image: Path, index: int) -> tuple[bool, int, Path]:
    append = [
        f"console={arch['console']}",
        *arch["extra_append"],
        f"rdinit={args.rdinit}",
        "panic=-1",
    ]
    cmd = [
        arch["qemu"], *arch["machine"],
        "-smp", "2", "-m", "1024", "-nographic", "-no-reboot",
        "-kernel", str(image),
        "-initrd", str(args.initramfs),
        "-append", " ".join(append),
    ]
    out = Path(args.workdir) / f"boot-{args.arch}-{index}.log"
    with out.open("wb") as fh:
        try:
            subprocess.run(cmd, stdin=subprocess.DEVNULL, stdout=fh,
                           stderr=subprocess.STDOUT, timeout=args.boot_timeout)
        except subprocess.TimeoutExpired:
            pass
    text = out.read_text(errors="replace")
    return args.marker in text, text.count("\n"), out


def main() -> int:
    host = platform.machine()
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--kernel-dir", required=True, type=Path,
                    help="writable, already-configured kernel tree to build")
    ap.add_argument("--arch", choices=sorted(ARCHES),
                    default="x86_64" if host in ("x86_64", "AMD64") else "aarch64")
    ap.add_argument("--badc", type=Path,
                    default=os.environ.get("BADC", REPO_ROOT / "target/release/badc"))
    ap.add_argument("--real-cc", default=os.environ.get("BADC_REAL_CC", "gcc"))
    ap.add_argument("-j", "--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--timeout", type=int, default=600, help="seconds per badc unit")
    ap.add_argument("--fallback", help="units to leave to the reference compiler; "
                                       "the gate expects none")
    ap.add_argument("--weaken", help="BADC_WEAKEN passthrough (a shim, not a pass "
                                     "condition)")
    ap.add_argument("--clean", action=argparse.BooleanOptionalAction, default=True)
    ap.add_argument("--expect-units", type=int, default=0,
                    help="minimum badc-compiled units; guards against a build that "
                         "compiled nothing")
    ap.add_argument("--initramfs", type=Path, help="boot initramfs; omit with --no-boot")
    ap.add_argument("--rdinit", default="/init")
    ap.add_argument("--marker", default=DEFAULT_MARKER)
    ap.add_argument("--boots", type=int, default=2)
    ap.add_argument("--boot-timeout", type=int, default=180)
    ap.add_argument("--boot", action=argparse.BooleanOptionalAction, default=True)
    ap.add_argument("--workdir", type=Path, default=Path.cwd() / "verify-out")
    ap.add_argument("--report", type=Path, help="write the result set as JSON")
    args = ap.parse_args()

    arch = ARCHES[args.arch]
    tree = args.kernel_dir.resolve()
    args.badc = Path(args.badc).resolve()
    args.workdir = Path(args.workdir).resolve()
    args.workdir.mkdir(parents=True, exist_ok=True)

    if not os.access(args.badc, os.X_OK):
        die(f"badc not executable: {args.badc} "
            f"(cargo build --release --features full)")
    if not (tree / ".config").exists():
        die(f"{tree} is not configured (run setup.py)")
    if not os.access(tree, os.W_OK):
        die(f"{tree} is not writable; build a copy, not the reference corpus")
    if args.boot:
        if not args.initramfs or not Path(args.initramfs).exists():
            die("--initramfs is required unless --no-boot")
        if not shutil.which(arch["qemu"]):
            die(f"{arch['qemu']} not found")
        args.initramfs = Path(args.initramfs).resolve()

    manifest = args.workdir / f"manifest-{args.arch}.txt"
    rc, secs, build_log = build(args, arch, tree, manifest)
    units = read_manifest(manifest)
    text = build_log.read_text(errors="replace")
    undef = len(re.findall(r"undefined reference", text))

    log(f"make rc={rc} in {secs:.0f}s: badc={len(units['badc'])} "
        f"fallback={len(units['fallback'])} fail={len(units['fail'])} "
        f"undefined-refs={undef}")

    failures = []
    if rc != 0:
        failures.append(f"make exited {rc} (see {build_log})")
    if units["fail"]:
        named = ", ".join(u.split("\t")[0] for u in units["fail"][:5])
        failures.append(f"units badc could not compile: {len(units['fail'])} "
                        f"({named})")
    if units["fallback"]:
        failures.append(f"units that fell back to {args.real_cc}: "
                        f"{len(units['fallback'])}")
    if undef:
        failures.append(f"undefined references at link: {undef}")
    if len(units["badc"]) < args.expect_units:
        failures.append(f"units compiled: {len(units['badc'])}, expected at "
                        f"least {args.expect_units}")

    boots = []
    image = tree / arch["image"]
    if args.boot and not failures:
        if not image.exists():
            failures.append(f"no kernel image at {image}")
        for i in range(1, args.boots + 1):
            ok, lines, path = boot(args, arch, image, i)
            log(f"boot {i}/{args.boots}: marker={'yes' if ok else 'NO'} "
                f"console-lines={lines}")
            boots.append({"ok": ok, "lines": lines, "log": str(path)})
            if not ok:
                failures.append(f"boot {i} did not reach {args.marker!r} "
                                f"(see {path})")

    if args.report:
        args.report.write_text(json.dumps({
            "arch": args.arch, "make_rc": rc, "seconds": round(secs, 1),
            "units": {k: len(v) for k, v in units.items()},
            "undefined_refs": undef, "boots": boots, "failures": failures,
        }, indent=2) + "\n")

    for f in failures:
        print(f"linux verify: FAIL: {f}", flush=True)
    if failures:
        return 1
    booted = (f", {len(boots)}/{len(boots)} boots reached the marker" if boots
              else "; not booted")
    log(f"PASS: {len(units['badc'])} units, 0 fallbacks, 0 undefined refs"
        f"{booted}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
