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

Each boot runs at a KASLR displacement the gate picked rather than one the
machine drew, so a displacement-dependent defect is reproducible; see kaslr.py
for what each architecture allows. `--kaslr-seed` replays one exactly, and
`--no-build` boots the image already in the tree.
"""

from __future__ import annotations

import argparse
import json
import os
import platform
import re
import shlex
import shutil
import subprocess
import sys
import time
from pathlib import Path

import kaslr

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
        # The x86 boot path draws its displacement from RDRAND / the TSC /
        # the i8254 counter and takes no seed from outside; see kaslr.py.
        "kaslr_seed_dtb": False,
    },
    "aarch64": {
        "target": "linux-aarch64",
        "make_target": "Image",
        "image": "arch/arm64/boot/Image",
        "qemu": "qemu-system-aarch64",
        "machine": ["-M", "virt", "-cpu", "max"],
        "console": "ttyAMA0",
        "extra_append": ["earlycon=pl011,0x9000000"],
        "kaslr_seed_dtb": True,
    },
}

DEFAULT_MARKER = "BADC-VMLINUX-OK"
# A boot that only reports its displacement: nothing is at this path, so the
# kernel panics once it reaches userspace and the panic notifier prints
# `Kernel Offset:`. panic=-1 (already on the command line) then ends the boot.
PROBE_RDINIT = "/nonexistent-kaslr-probe"


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


def machine_args(arch: dict, dumpdtb: Path | None = None) -> list[str]:
    """The arch's machine selection, optionally asking qemu for its own tree."""
    out = list(arch["machine"])
    if dumpdtb is not None and "-M" in out:
        i = out.index("-M")
        out[i + 1] = f"{out[i + 1]},dumpdtb={dumpdtb}"
    return out


def boot(args, arch: dict, image: Path, out: Path, rdinit: str,
         dtb: Path | None) -> str:
    """Run one boot to completion or to the timeout; returns the console log."""
    append = [
        f"console={arch['console']}",
        *arch["extra_append"],
        f"rdinit={rdinit}",
        "panic=-1",
    ]
    cmd = [
        args.qemu, *machine_args(arch), *args.qemu_args,
        "-smp", "2", "-m", "1024", "-nographic", "-no-reboot",
        "-kernel", str(image),
        "-initrd", str(args.initramfs),
        "-append", " ".join(append),
    ]
    if dtb is not None:
        cmd += ["-dtb", str(dtb)]
    with out.open("wb") as fh:
        try:
            subprocess.run(cmd, stdin=subprocess.DEVNULL, stdout=fh,
                           stderr=subprocess.STDOUT, timeout=args.boot_timeout)
        except subprocess.TimeoutExpired:
            pass
    return out.read_text(errors="replace")


def seed_trees(args, arch: dict, plan: list[int | None]) -> dict[int, Path]:
    """Write one device tree per pinned seed. Empty when nothing can be pinned.

    The base is the tree qemu builds for this exact machine, so the boots see
    the machine they would have seen without `-dtb`.
    """
    seeds = {s for s in plan if s is not None}
    if not seeds:
        return {}
    base = Path(args.workdir) / f"base-{args.arch}.dtb"
    base.unlink(missing_ok=True)
    cmd = [args.qemu, *machine_args(arch, base), *args.qemu_args,
           "-smp", "2", "-m", "1024", "-nographic"]
    try:
        subprocess.run(cmd, stdin=subprocess.DEVNULL, stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL, timeout=args.boot_timeout)
    except subprocess.TimeoutExpired:
        pass
    if not base.exists() or base.stat().st_size == 0:
        log(f"{args.qemu} wrote no device tree for {' '.join(machine_args(arch))}; "
            f"boots run at whatever displacement the machine draws")
        return {}
    raw = base.read_bytes()
    out: dict[int, Path] = {}
    for seed in sorted(seeds):
        path = Path(args.workdir) / f"kaslr-{args.arch}-{seed:016x}.dtb"
        try:
            path.write_bytes(kaslr.set_kaslr_seed(raw, seed))
        except kaslr.FdtError as e:
            log(f"cannot pin the displacement: {e}; boots run at whatever "
                f"displacement the machine draws")
            return {}
        out[seed] = path
    return out


def kaslr_configured(tree: Path) -> bool:
    """Whether the tree's configuration randomizes the kernel base."""
    cfg = tree / ".config"
    if not cfg.exists():
        return False
    return any(line.strip() == "CONFIG_RANDOMIZE_BASE=y"
               for line in cfg.read_text(errors="replace").splitlines())


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
    ap.add_argument("--clean", action=argparse.BooleanOptionalAction, default=True)
    ap.add_argument("--expect-units", type=int, default=0,
                    help="minimum badc-compiled units; guards against a build that "
                         "compiled nothing")
    ap.add_argument("--build", action=argparse.BooleanOptionalAction, default=True,
                    help="--no-build boots the image already in the tree; the "
                         "unit and link checks are then not made")
    ap.add_argument("--initramfs", type=Path, help="boot initramfs; omit with --no-boot")
    ap.add_argument("--rdinit", default="/init")
    ap.add_argument("--marker", default=DEFAULT_MARKER)
    ap.add_argument("--boots", type=int, default=4,
                    help="boots, each at its own KASLR displacement")
    ap.add_argument("--kaslr-seed", action="append", metavar="SEED",
                    help="pin a boot's KASLR displacement to this 64-bit seed "
                         "(repeat for more boots, `random` for an unpinned "
                         "one); replaces the default seed plan. aarch64 only "
                         "-- x86_64 takes no seed from outside the kernel")
    ap.add_argument("--boot-timeout", type=int, default=180)
    ap.add_argument("--boot", action=argparse.BooleanOptionalAction, default=True)
    ap.add_argument("--qemu", help="emulator to boot under (default: the arch's "
                                   "qemu-system-* on PATH)")
    ap.add_argument("--qemu-args", default="",
                    help="extra emulator arguments, shell-quoted; an emulator "
                         "built without its data directory needs `-nic none` "
                         "(the default NIC would want a boot ROM)")
    ap.add_argument("--workdir", type=Path, default=Path.cwd() / "verify-out")
    ap.add_argument("--report", type=Path, help="write the result set as JSON")
    args = ap.parse_args()

    arch = ARCHES[args.arch]
    args.qemu = args.qemu or arch["qemu"]
    args.qemu_args = shlex.split(args.qemu_args)
    tree = args.kernel_dir.resolve()
    args.badc = Path(args.badc).resolve()
    args.workdir = Path(args.workdir).resolve()
    args.workdir.mkdir(parents=True, exist_ok=True)

    if args.build and not os.access(args.badc, os.X_OK):
        die(f"badc not executable: {args.badc} "
            f"(cargo build --release --features full)")
    if not (tree / ".config").exists():
        die(f"{tree} is not configured (run setup.py)")
    if args.build and not os.access(tree, os.W_OK):
        die(f"{tree} is not writable; build a copy, not the reference corpus")
    if args.kaslr_seed and not arch["kaslr_seed_dtb"]:
        die(f"--kaslr-seed does not apply to {args.arch}: its boot path draws "
            f"the displacement from RDRAND / the TSC / the i8254 counter and "
            f"takes no seed from the boot loader, the command line or the "
            f"firmware (see kaslr.py)")
    if args.boot:
        if not args.initramfs or not Path(args.initramfs).exists():
            die("--initramfs is required unless --no-boot")
        if not shutil.which(args.qemu):
            die(f"{args.qemu} not found")
        args.initramfs = Path(args.initramfs).resolve()

    failures = []
    units = {"badc": [], "fallback": [], "fail": []}
    rc, secs, undef = 0, 0.0, 0
    if args.build:
        manifest = args.workdir / f"manifest-{args.arch}.txt"
        rc, secs, build_log = build(args, arch, tree, manifest)
        units = read_manifest(manifest)
        text = build_log.read_text(errors="replace")
        undef = len(re.findall(r"undefined reference", text))

        log(f"make rc={rc} in {secs:.0f}s: badc={len(units['badc'])} "
            f"fallback={len(units['fallback'])} fail={len(units['fail'])} "
            f"undefined-refs={undef}")

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
    else:
        log("--no-build: booting the image already in the tree")

    boots = []
    offsets: dict[int | None, int | None] = {}
    plan: list[int | None] = []
    image = tree / arch["image"]
    if args.boot and not failures and not image.exists():
        failures.append(f"no kernel image at {image}")
    if args.boot and not failures:
        plan = kaslr.seed_plan(args.boots, args.kaslr_seed,
                               arch["kaslr_seed_dtb"])
        trees = seed_trees(args, arch, plan)
        plan = [s if s in trees else None for s in plan]
        # One displacement-reporting boot per distinct plan entry. Where the
        # plan pins nothing the entries collapse to a single probe: each boot
        # would draw its own displacement, so the probe's is not the boots'.
        for seed in dict.fromkeys(plan):
            tag = f"{seed:016x}" if seed is not None else "unpinned"
            out = Path(args.workdir) / f"probe-{args.arch}-{tag}.log"
            text = boot(args, arch, image, out, PROBE_RDINIT, trees.get(seed))
            offsets[seed] = kaslr.parse_kernel_offset(text)
            log(f"probe seed={tag}: "
                f"displacement={kaslr.format_offset(offsets[seed])} (see {out})")
        for i, seed in enumerate(plan, start=1):
            out = Path(args.workdir) / f"boot-{args.arch}-{i}.log"
            text = boot(args, arch, image, out, args.rdinit, trees.get(seed))
            ok, lines = args.marker in text, text.count("\n")
            tag = f"0x{seed:016x}" if seed is not None else "unpinned"
            # An unpinned boot draws its own displacement, which the probe's
            # does not stand for, so it is left unattributed.
            disp = (kaslr.format_offset(offsets.get(seed))
                    if seed is not None else "drawn")
            log(f"boot {i}/{len(plan)}: seed={tag} displacement={disp} "
                f"marker={'yes' if ok else 'NO'} console-lines={lines}")
            boots.append({"ok": ok, "lines": lines, "log": str(out),
                          "seed": tag, "offset": disp})
            if not ok:
                replay = (f"; replay with --kaslr-seed 0x{seed:016x}"
                          if seed is not None else "")
                failures.append(f"boot {i} did not reach {args.marker!r} "
                                f"(see {out}){replay}")
        failures.extend(kaslr.displacement_failures(
            kaslr_configured(tree), plan, offsets))

    if args.report:
        args.report.write_text(json.dumps({
            "arch": args.arch, "make_rc": rc, "seconds": round(secs, 1),
            "qemu": shutil.which(args.qemu) if args.boot else None,
            "units": {k: len(v) for k, v in units.items()},
            "undefined_refs": undef, "boots": boots,
            "kaslr": {
                "configured": kaslr_configured(tree),
                "pinned": any(s is not None for s in plan),
                "displacements": {(f"{s:016x}" if s is not None else "unpinned"):
                                  kaslr.format_offset(o) for s, o in offsets.items()},
            },
            "failures": failures,
        }, indent=2) + "\n")

    for f in failures:
        print(f"linux verify: FAIL: {f}", flush=True)
    if failures:
        return 1
    pinned = [s for s in plan if s is not None]
    where = (f" at {len({offsets.get(s) for s in pinned})} pinned displacements"
             if pinned else " at displacements the machine drew")
    booted = (f", {len(boots)}/{len(boots)} boots reached the marker{where}"
              if boots else "; not booted")
    built = (f"{len(units['badc'])} units, 0 fallbacks, 0 undefined refs"
             if args.build else "not built")
    log(f"PASS: {built}{booted}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
