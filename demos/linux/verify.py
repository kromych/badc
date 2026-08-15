#!/usr/bin/env python3
"""Pass/fail gate for the badc-compiled Linux kernel.

Runs the build described in README.md ("Hybrid build") with an empty fallback
list, so every kernel C unit is badc's, then boots the result under qemu.
Unlike sweep.py, which measures and ranks, this asserts: any unit badc cannot
compile, any undefined reference at link, any boot that does not reach the
marker, or any boot whose userspace could not read the kernel back fails the
run. A unit badc cannot compile now stops make where it happens, so the build
step fails too rather than only showing up in the manifest.

A boot makes two claims and they are checked separately. Reaching userspace is
the first marker; serving reads of /proc and /sys is the second, which the
initramfs prints only after its checks pass (initramfs.py). A kernel that boots
and then cannot serve a procfs read fails on the second, and the failure names
the file it stopped on.

The build step also re-records the compiler identification: it re-runs the
configuration with the build shim as CC, so CONFIG_CC_VERSION_TEXT -- the
compiler text in the boot banner and /proc/version -- carries badc's
identification instead of the reference compiler's, while every capability
symbol keeps the reference answer. Each boot's `Linux version` banner must
then name badc as the compiler, and the linker identification that follows it
must agree with `--linker`, so the image itself states what produced it.

    python3 demos/linux/verify.py --kernel-dir <writable tree> \
        --initramfs <image> --expect-units 1912

`--linker badc` (the default) makes every link badc's, through ldshim.py: the
kallsyms passes, the final vmlinux, the relocatable merges, the vDSOs and the
16/32-bit boot links. A link that fell back or that badc could not make is
recorded in the link manifest and fails the run, so a run cannot claim more
than it did. `--linker reference` leaves
every link to `--real-ld` and is the contrast run. Every run names the linker
it used on its first line and in its verdict, so no result is ambiguous about
which of the two produced the image it booted.

The tree must already be configured (setup.py) and must be writable: the build
runs in it. It is rebuilt from clean by default, because make skips units whose
objects are already current and a gate that compiles nothing passes vacuously.

Each boot runs at a KASLR displacement the gate picked rather than one the
machine drew, so a displacement-dependent defect is reproducible; see kaslr.py
for what each architecture allows. `--kaslr-seed` replays one exactly, and
`--no-build` boots the image already in the tree.

`--self-test` checks the banner reading and takes no tree.
"""

from __future__ import annotations

import argparse
import collections
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
# The initramfs prints this only after its /proc and /sys checks pass; see
# initramfs.py. Reaching userspace and serving a read are separate claims, so
# they are separate markers and a boot has to make both.
DEFAULT_CHECK_MARKER = "BADC-SELFTEST-OK"
CHECK_STEP = "BADC-SELFTEST-STEP"
# A boot that only reports its displacement: nothing is at this path, so the
# kernel panics once it reaches userspace and the panic notifier prints
# `Kernel Offset:`. panic=-1 (already on the command line) then ends the boot.
PROBE_RDINIT = "/nonexistent-kaslr-probe"


def log(m: str) -> None:
    print(f"linux verify: {m}", flush=True)


def die(m: str) -> "None":
    print(f"linux verify: FAIL: {m}", flush=True)
    sys.exit(1)


def read_manifest(path: Path,
                  verdicts: tuple[str, ...] = ("badc", "fallback", "fail",
                                               "badc-asm", "gas")
                  ) -> dict[str, list[str]]:
    """Group a shim's per-invocation lines by verdict."""
    out: dict[str, list[str]] = {v: [] for v in verdicts}
    if not path.exists():
        return out
    for line in path.read_text(errors="replace").splitlines():
        verdict, _, rest = line.partition("\t")
        if verdict in out:
            out[verdict].append(rest)
    return out


def cc_version_text(tree: Path) -> str:
    """The tree's configured CONFIG_CC_VERSION_TEXT, or ""."""
    cfg = tree / ".config"
    if not cfg.exists():
        return ""
    m = re.search(r'(?m)^CONFIG_CC_VERSION_TEXT="(.*)"$',
                  cfg.read_text(errors="replace"))
    return m.group(1) if m else ""


def build(args, arch: dict, tree: Path, manifest: Path,
          ld_manifest: Path) -> tuple[int, float, Path]:
    env = dict(os.environ)
    env.update(
        BADC=str(args.badc),
        BADC_REAL_CC=args.real_cc,
        BADC_TARGET=arch["target"],
        BADC_MANIFEST=str(manifest),
        BADC_TIMEOUT=str(args.timeout),
        BADC_LD_REAL=args.real_ld,
        BADC_LD_MANIFEST=str(ld_manifest),
    )
    if args.fallback:
        env["BADC_FALLBACK"] = str(Path(args.fallback).resolve())
    else:
        env.pop("BADC_FALLBACK", None)
    env.pop("BADC_WEAKEN", None)

    manifest.unlink(missing_ok=True)
    ld_manifest.unlink(missing_ok=True)
    # `LD=` selects the linker for every link the build makes: the
    # shim (badc, with the delegations ldshim.py records) or the
    # reference linker untouched. It is passed to the configuration
    # step too, because Kconfig probes the linker -- what the tree
    # records about linker capabilities has to come from the linker
    # that will do the linking.
    make_vars = [f"CC={LINUX_DIR / 'buildcc.py'}"]
    if args.linker == "badc":
        make_vars.append(f"LD={LINUX_DIR / 'ldshim.py'}")
    if args.clean:
        log("make clean")
        subprocess.run(["make", "clean"], cwd=tree, env=env,
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


    # Identification re-probe: the tree was configured by the reference
    # compiler, so its CONFIG_CC_VERSION_TEXT -- the boot banner's and
    # /proc/version's compiler line -- names that compiler. Re-running the
    # configuration step with the shim as CC records the shim's answer, which
    # is badc's identification; every other symbol keeps the reference
    # compiler's answer because the shim delegates the probes to it. The
    # explicit step (rather than the syncconfig the build would trigger on
    # the mismatch) makes the change diffable here.
    before = cc_version_text(tree)
    subprocess.run(["make", "olddefconfig", *make_vars], cwd=tree, env=env,
                   check=True, stdout=subprocess.DEVNULL)
    after = cc_version_text(tree)
    if before != after:
        log(f"CC_VERSION_TEXT: {before!r} -> {after!r}")
    if "badc" not in after:
        die(f"re-probed CC_VERSION_TEXT does not name badc: {after!r}")

    cmd = ["make", f"-j{args.jobs}", *make_vars, arch["make_target"]]
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


def last_step(text: str) -> str:
    """The last check the initramfs announced, which is the one a boot that
    stopped mid-check stopped on."""
    steps = [l for l in text.splitlines() if CHECK_STEP in l]
    if not steps:
        return ""
    return f", last step {steps[-1].split(CHECK_STEP, 1)[1].strip()!r}"


def banner_line(text: str) -> str:
    """The kernel's `Linux version ...` banner from a console log, from the
    marker onward (console lines carry timestamps). The banner embeds
    CONFIG_CC_VERSION_TEXT followed by the identification the build probed
    from the linker, and /proc/version serves the same text."""
    for ln in text.splitlines():
        if "Linux version " in ln:
            return ln[ln.index("Linux version "):]
    return ""


def banner_failure(banner: str, cc_text: str, badc_ld: bool | None) -> str:
    """What the banner contradicts about the build that produced it, or "".

    Both identifications come out of the booted image rather than out of the
    run's own bookkeeping, so an image left by another run cannot pass as this
    one's. `badc_ld` is None when the run linked nothing and can claim neither.
    """
    if "badc" in cc_text and "badc" not in banner:
        return "does not identify badc as the compiler"
    if badc_ld is None or not cc_text:
        return ""
    if ("badc" in banner.split(cc_text, 1)[-1]) != badc_ld:
        return ("does not name badc as the linker" if badc_ld
                else "names badc as the linker")
    return ""


def _self_test() -> int:
    """Check the banner reading against both lanes' real console text.

    These are pure functions and the gate reaches them an hour into a run, so
    they are checked where a push can afford to say so.
    """
    cc = "badc 0.3.0 (gcc-compatible, GNU C 4.2.1)"

    def line(ld: str) -> str:
        return f"Linux version 7.1.6 (u@h) ({cc}, {ld}) #1 SMP PREEMPT"

    badc = line("GNU ld (badc 0.3.0) 2.33.1")
    ref = line("GNU ld version 2.46.1-1.fc44")
    assert banner_line(f"boot noise\n[    0.000000] {badc}\nmore") == badc
    assert banner_line("no banner in this log") == ""

    assert banner_failure(badc, cc, True) == ""
    assert banner_failure(ref, cc, False) == ""
    assert banner_failure(ref, cc, True), "a reference-linked image is not badc's"
    assert banner_failure(badc, cc, False), "a badc-linked image is not the contrast"
    # A run that linked nothing claims neither linker, and an image built by
    # the reference compiler fails on the compiler before the linker is read.
    assert banner_failure(badc, cc, None) == ""
    assert banner_failure(ref, cc, None) == ""
    assert banner_failure("Linux version 7.1.6 (u@h) (gcc 13.2, GNU ld 2.46) #1",
                          cc, True) == "does not identify badc as the compiler"
    assert banner_failure("", cc, True), "a log with no banner cannot pass"
    print("linux verify: self-test ok", flush=True)
    return 0


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
    ap.add_argument("--linker", choices=("reference", "badc"),
                    default=os.environ.get("BADC_LINKER", "badc"),
                    help="who links: `badc` (the default) runs every link "
                         "through ldshim.py, `reference` leaves them all to "
                         "--real-ld (the contrast run). See README.md")
    ap.add_argument("--real-ld", default=os.environ.get("BADC_LD_REAL", "ld"),
                    help="linker for the steps badc does not implement, and "
                         "for every step under --linker reference")
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
    ap.add_argument("--check-marker", default=DEFAULT_CHECK_MARKER,
                    help="marker the initramfs prints once its kernel checks "
                         "pass; empty string requires only --marker")
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
    units = {"badc": [], "fallback": [], "fail": [], "badc-asm": [], "gas": []}
    links = {"badc": [], "ld": [], "fallback": [], "fail": []}
    rc, secs, undef = 0, 0.0, 0
    if args.build:
        # Named before anything is built: a console log has to say which
        # linker produced the image the boots below ran.
        log(f"linker: {'badc (ldshim.py)' if args.linker == 'badc' else args.real_ld}")
        manifest = args.workdir / f"manifest-{args.arch}.txt"
        ld_manifest = args.workdir / f"ld-manifest-{args.arch}.txt"
        rc, secs, build_log = build(args, arch, tree, manifest, ld_manifest)
        units = read_manifest(manifest)
        links = read_manifest(ld_manifest,
                              ("badc", "ld", "fallback", "fail"))
        text = build_log.read_text(errors="replace")
        undef = len(re.findall(r"undefined reference", text))

        log(f"make rc={rc} in {secs:.0f}s: badc={len(units['badc'])} "
            f"fallback={len(units['fallback'])} fail={len(units['fail'])} "
            f"undefined-refs={undef}")
        # Assembly is measured, not gated: gas assembling what badc's
        # assembler does not yet take is the expected state, so no `gas`
        # line joins `failures`. The counts and the reasons are the point.
        log(f"asm units: badc={len(units['badc-asm'])} "
            f"gas={len(units['gas'])}")
        for reason, n in collections.Counter(
                u.partition("\t")[2] or "(no diagnostic)"
                for u in units["gas"]).most_common():
            log(f"  gas: {n} x {reason}")
        if args.linker == "badc":
            log(f"links: badc={len(links['badc'])} "
                f"{args.real_ld}={len(links['ld'])} "
                f"fallback={len(links['fallback'])} fail={len(links['fail'])}")
            for line in links["ld"]:
                log(f"link left to {args.real_ld}: {line}")
            if links["ld"]:
                failures.append(f"links left to {args.real_ld}: "
                                f"{len(links['ld'])}")
            if links["fail"]:
                named = ", ".join(l.split("\t")[0] for l in links["fail"][:5])
                failures.append(f"links badc could not make: "
                                f"{len(links['fail'])} ({named})")
            if links["fallback"]:
                failures.append(f"links that fell back to {args.real_ld}: "
                                f"{len(links['fallback'])}")
            if not links["badc"]:
                failures.append("no link was made by badc")

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
        # A tree whose configuration names badc as the compiler must boot a
        # kernel whose banner -- and therefore /proc/version -- says so; the
        # banner embeds CONFIG_CC_VERSION_TEXT at build time, so a mismatch
        # means the image was not built from this configuration. The linker
        # identification the build probed follows it, and holds the image to
        # the linker this run asked for.
        cc_text = cc_version_text(tree)
        badc_ld = (args.linker == "badc") if args.build else None
        for i, seed in enumerate(plan, start=1):
            out = Path(args.workdir) / f"boot-{args.arch}-{i}.log"
            text = boot(args, arch, image, out, args.rdinit, trees.get(seed))
            booted, lines = args.marker in text, text.count("\n")
            checked = not args.check_marker or args.check_marker in text
            banner = banner_line(text)
            mismatch = banner_failure(banner, cc_text, badc_ld)
            ok = booted and checked and not mismatch
            tag = f"0x{seed:016x}" if seed is not None else "unpinned"
            # An unpinned boot draws its own displacement, which the probe's
            # does not stand for, so it is left unattributed.
            disp = (kaslr.format_offset(offsets.get(seed))
                    if seed is not None else "drawn")
            log(f"boot {i}/{len(plan)}: seed={tag} displacement={disp} "
                f"marker={'yes' if booted else 'NO'} "
                f"checks={'yes' if checked else 'NO'} console-lines={lines}")
            if i == 1 and banner:
                log(f"banner: {banner}")
            boots.append({"ok": ok, "booted": booted, "checked": checked,
                          "lines": lines, "log": str(out), "banner": banner,
                          "seed": tag, "offset": disp})
            if booted and checked and mismatch:
                failures.append(f"boot {i} banner {mismatch}: "
                                f"{banner!r} (see {out})")
            elif not ok:
                replay = (f"; replay with --kaslr-seed 0x{seed:016x}"
                          if seed is not None else "")
                want = args.marker if not booted else args.check_marker
                failures.append(f"boot {i} did not reach {want!r}"
                                f"{last_step(text)} (see {out}){replay}")
        failures.extend(kaslr.displacement_failures(
            kaslr_configured(tree), plan, offsets))

    if args.report:
        args.report.write_text(json.dumps({
            "arch": args.arch, "make_rc": rc, "seconds": round(secs, 1),
            "qemu": shutil.which(args.qemu) if args.boot else None,
            # A --no-build run linked nothing, so it names no linker.
            "linker": args.linker if args.build else None,
            "units": {k: len(v) for k, v in units.items()},
            # What kept each assembly unit with gas, ranked by incidence.
            "asm_gas_reasons": collections.Counter(
                u.partition("\t")[2] or "(no diagnostic)"
                for u in units["gas"]).most_common(),
            "links": {k: len(v) for k, v in links.items()},
            "links_left_to_ld": links["ld"],
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
    booted = (f", {len(boots)}/{len(boots)} boots reached the marker and "
              f"passed the kernel checks{where}" if boots else "; not booted")
    built = (f"{len(units['badc'])} units, 0 fallbacks, 0 undefined refs"
             if args.build else "not built")
    if not args.build:
        linked = ""
    elif args.linker == "badc":
        linked = (f", {len(links['badc'])} links by badc and "
                  f"{len(links['ld'])} left to {args.real_ld}")
    else:
        linked = f", every link by {args.real_ld}"
    log(f"PASS: {built}{linked}{booted}")
    return 0


if __name__ == "__main__":
    sys.exit(_self_test() if sys.argv[1:] == ["--self-test"] else main())
