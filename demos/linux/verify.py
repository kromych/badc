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

Diagnostics badc wrote on compiles and links that succeeded are counted by
cause and reported with the unit and link counts; a warning comes with
rc == 0, so nothing else in the build states them. The raw lines, each
tagged with the unit that produced it, stay in `warnings-<arch>.txt` in the
work directory.

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
runs in it, and a run that builds holds it exclusively (ktree.py) because a
second run's `make clean` removes this one's generated sources mid-compile. It
is rebuilt from clean by default, because make skips units whose
objects are already current and a gate that compiles nothing passes vacuously.
Its configured architecture must be `--arch`, which is checked before the
build starts; kbuild is then given `ARCH`, and `CROSS_COMPILE` and prefixed
`--real-cc` / `--real-ld` defaults when the target is not the host.

Each boot runs at a KASLR displacement the gate picked rather than one the
machine drew, so a displacement-dependent defect is reproducible; see kaslr.py
for what each architecture allows. `--kaslr-seed` replays one exactly, and
`--no-build` boots the image already in the tree.

After those boots one more boots the payload image unpack.py builds -- the
marker archive followed by 250 MB compressed with the method the
configuration decompresses -- and is held to the time the kernel spends
unpacking it, read from the console. The marker image is too small for a
decompressor regression to show in its boot. `--max-unpack-seconds` sets the
bound (default: the architecture's entry in UNPACK_BOUNDS; 0 reports only)
and `--no-payload` skips the boot.

The build's `System.map` is measured as well: the largest text symbol and
the count of functions over 4 KiB, against the architecture's budgets in
TEXT_BUDGETS. An inliner that duplicates a callee's body at every site moves
aggregate text by a few per cent while single functions move twentyfold, so
the budget is on the distribution rather than on the total.

`--nested-kvm` adds one more boot, under this host's KVM with its CPU model,
whose initramfs carries the emulator `--guest-qemu` names -- the badc-built
one the qemu demo produces -- with its libraries, the firmware it reads
(`--guest-firmware`, the demo's ROM set), the KVM modules of this build,
the image itself and the marker initramfs (initramfs.py's guest). Inside,
/init loads the modules, reports what the CPU model offers to nest on and
whether /dev/kvm appears, then runs the emulator, so the kernel under test
is the hypervisor of a guest booting the same image; the guest's console
arrives on the outer one between bracket lines and is held to the marker
checks. The step is skipped, not passed, where the host has no /dev/kvm or
the emulator or the CPU model offers no nesting. With --build the
configuration builds KVM, which x86_64 defconfig leaves out, as modules
where the architecture allows, and the build makes them.

`--self-test` checks the banner reading, the architecture selection, the
reading of the unpack phase, the text sizing and the reading of the nested
boot, and takes no tree.
"""

from __future__ import annotations

import argparse
import collections
import json
import os
import re
import shlex
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path

import buildcc
import diags
import exercise
import initramfs
import karch
import kaslr
import ktree
import unpack

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
        # The nested boot: the host's CPU model carries the virtualization
        # extension when the host's kvm_intel.nested / kvm_amd.nested
        # allow it. The guest inside runs the carried emulator under the
        # kernel's own KVM, without the VGA whose ROM it would need, and
        # reads these blobs from the image (the set strace shows). KVM is
        # tristate here and rides as modules.
        "nested_machine": ["-accel", "kvm", "-cpu", "host"],
        "guest_machine": ["-accel", "kvm", "-cpu", "host", "-vga", "none"],
        "firmware": ["bios-256k.bin", "linuxboot_dma.bin", "kvmvapic.bin"],
        "kvm_symbols": ["KVM", "KVM_INTEL", "KVM_AMD"],
        "kvm_modular": True,
        "kvm_dir": "arch/x86/kvm",
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
        # EL2 for the guest, which the host's KVM has to support; the
        # emulator refuses the machine where it does not.
        "nested_machine": ["-M", "virt,virtualization=on", "-accel", "kvm",
                           "-cpu", "host"],
        "guest_machine": ["-M", "virt", "-accel", "kvm", "-cpu", "host"],
        "firmware": [],
        # A bool symbol on arm64: KVM is built in or not at all.
        "kvm_symbols": ["KVM"],
        "kvm_modular": False,
        "kvm_dir": "arch/arm64/kvm",
    },
}

PASS, SKIP, FAIL = exercise.PASS, exercise.SKIP, exercise.FAIL
# Memory of the nested boot's outer machine, which holds the emulator, its
# libraries and the image in its initramfs, and of the guest inside it.
NESTED_MEM = 2048
GUEST_MEM = 512
# What the emulator prints when it starts no machine: its own name, then
# the reason. One naming KVM or the virtualization extensions is the host
# offering no nesting.
EMULATOR_ERROR = re.compile(r"^\S*qemu\S*: (.*)")
NESTING_REFUSAL = re.compile(r"kvm|virtualization|accel", re.I)
# arm64's report of the exception level its CPUs started at.
EL_LINE = re.compile(r"CPU: All CPU\(s\) started at (EL\d)")

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
# Processors each boot asks the machine for. Every architecture's
# `smp_cpus_done` reports how many came online, and the count is the only
# evidence a boot gives that the secondaries started: a machine whose
# secondaries never report alive still reaches userspace on the boot CPU, so
# the markers appear either way.
SMP_CPUS = 2
SMP_TOTAL_RE = re.compile(r"Total of (\d+) processors activated")
# Seconds the payload boot may spend from `Unpacking initramfs` to `Freeing
# initrd memory`, per architecture, for the zstd payload. aarch64: on the
# box, under TCG, a 250 MB / 43.7 MB zstd image took 5.124 s to unpack in
# the reference compiler's kernel and 9.782 s in badc's with the regressed
# decompressor (medians of 5 rounds); 7.5 s sits between the two.
# TODO: re-measure with unpack.py's payload on both boxes; x86_64 has no
# figure and is reported only.
UNPACK_BOUNDS = {"aarch64": 7.5}
# Linker labels System.map lists as text symbols: the section bounds of
# asm-generic/sections.h and the linker scripts, and arm64's `__pi_` alias.
TEXT_LABEL = re.compile(
    r"^(__pi_)?(_[se]?(init|exit)?text|__\w*text_(start|end|begin))$")
# A gap this large is a section boundary, not a function.
MAX_FUNCTION_BYTES = 1 << 20
# Budgets over the linked image's text symbols, per architecture: the
# largest function and the count over 4 KiB. aarch64: the box's badc-built
# 7.1.6 defconfig map measures 84530 functions, largest 101612
# (hidinput_configure_usage; 21192 in the gcc-built distribution kernel on
# the same box) and 451 over 4 KiB; the budgets clear those by 29% and 15%.
# TODO: lower `largest` once hidinput_configure_usage shrinks; measure the
# 7.1.10 map, and x86_64, which has no budget and is reported only.
TEXT_BUDGETS = {"aarch64": {"largest": 131072, "over_4k": 520}}


def log(m: str) -> None:
    print(f"linux verify: {m}", flush=True)


def die(m: str) -> "None":
    print(f"linux verify: FAIL: {m}", flush=True)
    sys.exit(1)


def read_manifest(path: Path,
                  verdicts: tuple[str, ...] = ("badc", "fallback", "fail",
                                               "missing", "badc-asm", "gas")
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


# What a failed build is read from. make -j interleaves, so the recipe that
# stopped it is not necessarily the last line; the diagnostics are.
BUILD_ERROR_RE = r"error:|undefined reference|\*\*\*"
# A console log carries the firmware's terminal escapes and a build log can
# carry a compiler's color codes. Neither may reach the terminal a gate run is
# printing to, so the C0 controls go and the printable residue stays.
CONTROLS = re.compile(r"[\x00-\x08\x0b-\x1f\x7f]")


def excerpt(text: str, limit: int, pattern: str | None = None) -> list[str]:
    """The lines a failure states itself in: those matching `pattern` when it
    is given and matches anything, otherwise the tail. A run on a remote box
    is read through its own output, not through the log paths it names."""
    lines = [CONTROLS.sub("", l) for l in text.splitlines()]
    if pattern:
        hits = [l for l in lines if re.search(pattern, l)]
        if hits:
            return hits[-limit:]
    return lines[-limit:]


def cc_version_text(tree: Path) -> str:
    """The tree's configured CONFIG_CC_VERSION_TEXT, or ""."""
    cfg = tree / ".config"
    if not cfg.exists():
        return ""
    m = re.search(r'(?m)^CONFIG_CC_VERSION_TEXT="(.*)"$',
                  cfg.read_text(errors="replace"))
    return m.group(1) if m else ""


def config_value(tree: Path, symbol: str) -> str:
    """What the tree's configuration sets `symbol` to: y, m, or ""."""
    cfg = tree / ".config"
    if not cfg.exists():
        return ""
    m = re.search(rf"(?m)^CONFIG_{symbol}=([ym])$", cfg.read_text(errors="replace"))
    return m.group(1) if m else ""


def enable_kvm(tree: Path, env: dict, arch: dict) -> None:
    """Set the KVM symbols in the tree's configuration, as modules where the
    architecture allows; the olddefconfig that follows resolves what they
    select. x86_64 defconfig builds no KVM."""
    cmd = ["./scripts/config", "--file", ".config"]
    for symbol in arch["kvm_symbols"]:
        cmd += ["--module" if arch["kvm_modular"] else "--enable", symbol]
    subprocess.run(cmd, cwd=tree, env=env, check=True,
                   stdout=subprocess.DEVNULL)


def build(args, arch: dict, tree: Path, manifest: Path,
          ld_manifest: Path, warn_log: Path) -> tuple[int, float, Path]:
    env = karch.make_env(args.arch)
    env.update(
        BADC=str(args.badc),
        BADC_REAL_CC=args.real_cc,
        BADC_TARGET=arch["target"],
        BADC_MANIFEST=str(manifest),
        BADC_WARN_LOG=str(warn_log),
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
    warn_log.unlink(missing_ok=True)
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
    if args.nested_kvm:
        enable_kvm(tree, env, arch)
    subprocess.run(["make", "olddefconfig", *make_vars], cwd=tree, env=env,
                   check=True, stdout=subprocess.DEVNULL)
    after = cc_version_text(tree)
    if before != after:
        log(f"CC_VERSION_TEXT: {before!r} -> {after!r}")
    if "badc" not in after:
        die(f"re-probed CC_VERSION_TEXT does not name badc: {after!r}")
    targets = [arch["make_target"]]
    if args.nested_kvm:
        want = "m" if arch["kvm_modular"] else "y"
        off = [f"CONFIG_{s}" for s in arch["kvm_symbols"]
               if config_value(tree, s) != want]
        if off:
            die(f"the configuration did not take {', '.join(off)}={want} for "
                f"the nested boot")
        log("nested KVM: the configuration builds "
            + ", ".join(f"CONFIG_{s}={want}" for s in arch["kvm_symbols"]))
        if arch["kvm_modular"]:
            targets.append("modules")

    cmd = ["make", f"-j{args.jobs}", *make_vars, *targets]
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


def append_args(arch: dict, rdinit: str, extra: tuple[str, ...] = ()) -> list[str]:
    """The kernel command line every boot takes: its console, the init to
    run and the panic timeout that ends a boot that did not reach it."""
    return [f"console={arch['console']}", *arch["extra_append"],
            f"rdinit={rdinit}", "panic=-1", *extra]


def boot(args, arch: dict, image: Path, out: Path, rdinit: str,
         dtb: Path | None, initrd: Path | None = None,
         extra: tuple[str, ...] = (), machine: list[str] | None = None,
         mem: int = 1024) -> str:
    """Run one boot to completion or to the timeout; returns the console
    log. `machine` replaces the architecture's machine selection."""
    cmd = [
        args.qemu, *(machine_args(arch) if machine is None else machine),
        *args.qemu_args,
        "-smp", str(SMP_CPUS), "-m", str(mem), "-nographic", "-no-reboot",
        "-kernel", str(image),
        "-initrd", str(initrd or args.initramfs),
        "-append", " ".join(append_args(arch, rdinit, extra)),
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
           "-smp", str(SMP_CPUS), "-m", "1024", "-nographic"]
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


def smp_failure(text: str, want: int) -> str:
    """What the console says about processor bringup that contradicts the
    machine the boot asked for, or "". A count below `want` is a kernel that
    booted and then ran on fewer cores than it was given."""
    m = SMP_TOTAL_RE.search(text)
    if not m:
        return f"reports no processor count for a {want}-processor machine"
    got = int(m.group(1))
    return "" if got == want else f"activated {got} of {want} processors"


def fault_failure(text: str) -> str:
    """What the console says the kernel itself reported as a fault, or "".

    Reaching the marker only says init ran. A kernel that warns, oopses or
    disables a subsystem on the way there has still miscompiled, so the boot
    is held to the same fault vocabulary the exercise stage applies to dmesg.
    """
    faults = exercise.dmesg_faults(text.splitlines())
    if not faults:
        return ""
    first = faults[0].strip()[:120]
    more = f" (+{len(faults) - 1} more)" if len(faults) > 1 else ""
    return f"reported {len(faults)} kernel fault line(s){more}: {first!r}"


def boot_checks(args, text: str, cc_text: str, badc_ld: bool | None) -> dict:
    """The verdicts every boot is held to, from its console log."""
    banner = banner_line(text)
    return {"booted": args.marker in text,
            "checked": not args.check_marker or args.check_marker in text,
            "banner": banner,
            "mismatch": banner_failure(banner, cc_text, badc_ld),
            "smp": smp_failure(text, SMP_CPUS),
            "fault": fault_failure(text),
            "lines": text.count("\n")}


def verdict_text(c: dict) -> str:
    return (f"marker={'yes' if c['booted'] else 'NO'} "
            f"checks={'yes' if c['checked'] else 'NO'} "
            f"cpus={'yes' if not c['smp'] else 'NO'} "
            f"clean={'yes' if not c['fault'] else 'NO'}")


def boot_record(c: dict, out: Path, tag: str, disp: str) -> dict:
    ok = (c["booted"] and c["checked"] and not c["mismatch"] and not c["smp"]
          and not c["fault"])
    return {"ok": ok, "booted": c["booted"], "checked": c["checked"],
            "cpus": not c["smp"], "clean": not c["fault"],
            "lines": c["lines"], "log": str(out), "banner": c["banner"],
            "seed": tag, "offset": disp}


def seed_tags(seed: int | None, offsets: dict) -> tuple[str, str]:
    """A boot's seed and displacement as reported. An unpinned boot draws
    its own displacement, which the probe's does not stand for, so it is
    left unattributed."""
    tag = f"0x{seed:016x}" if seed is not None else "unpinned"
    disp = kaslr.format_offset(offsets.get(seed)) if seed is not None else "drawn"
    return tag, disp


def check_failure(args, what: str, c: dict, text: str, out: Path,
                  replay: str = "") -> str:
    """The failure boot `what` states from its checks, or ""."""
    reached = c["booted"] and c["checked"]
    if reached and c["mismatch"]:
        return f"{what} banner {c['mismatch']}: {c['banner']!r} (see {out})"
    if reached and c["smp"]:
        return f"{what} {c['smp']} (see {out})"
    if reached and c["fault"]:
        return f"{what} {c['fault']} (see {out})"
    if not reached:
        want = args.marker if not c["booted"] else args.check_marker
        return (f"{what} did not reach {want!r}{last_step(text)} (see {out})"
                f"{replay}")
    return ""


def unpack_failure(seconds: float | None, trouble: str,
                   bound: float | None) -> str:
    """What the unpack phase contradicts, or "": what unpack.unpack_time
    found wrong with the console, or a time over the bound."""
    if trouble:
        return trouble
    if bound and seconds > bound:
        return f"unpacked the payload in {seconds:.2f} s, over the {bound:.1f} s bound"
    return ""


def payload_boot(args, arch: dict, tree: Path, image: Path, seed: int | None,
                 dtb: Path | None, offsets: dict, cc_text: str,
                 badc_ld: bool | None) -> tuple[dict, list[str]]:
    """Boot the payload image once (unpack.py), held to the marker boots'
    checks and to the unpack bound. Returns the report entry and the
    failures."""
    method = unpack.method_for((tree / ".config").read_text(errors="replace"))
    if not method:
        return {}, ["the configuration decompresses no initramfs method the "
                    "payload can take (" +
                    ", ".join(s for s, _, _ in unpack.METHODS.values()) + ")"]
    payload = args.payload_dir / unpack.payload_name(method)
    if not payload.exists():
        start = time.time()
        unpack.build_payload(payload, method)
        log(f"payload: wrote {payload} ({payload.stat().st_size / 1e6:.1f} MB) "
            f"in {time.time() - start:.0f}s")
    initrd = args.workdir / f"unpack-{args.arch}.initrd"
    size = unpack.build_image(args.initramfs, payload, initrd)
    out = args.workdir / f"unpack-{args.arch}.log"
    # printk.time=1: the phase is read from the timestamps, whatever the
    # configuration says about them.
    text = boot(args, arch, image, out, args.rdinit, dtb, initrd,
                ("printk.time=1",))
    c = boot_checks(args, text, cc_text, badc_ld)
    seconds, trouble = unpack.unpack_time(text)
    if args.max_unpack_seconds is not None:
        bound = args.max_unpack_seconds or None
    else:
        bound = UNPACK_BOUNDS.get(args.arch) if method == "zstd" else None
    tag, disp = seed_tags(seed, offsets)
    log(f"unpack boot: seed={tag} displacement={disp} {verdict_text(c)} "
        f"unpack={f'{seconds:.2f}s' if seconds is not None else 'unknown'} "
        f"bound={f'{bound:.1f}s' if bound else 'none'} "
        f"image={unpack.PAYLOAD_BYTES // 1_000_000}MB/{size / 1e6:.1f}MB "
        f"{method} console-lines={c['lines']}")
    failures = []
    failure = check_failure(args, "unpack boot", c, text, out)
    if failure:
        failures.append(failure)
    over = unpack_failure(seconds, trouble, bound)
    if over:
        failures.append(f"unpack boot {over} (see {out})")
    record = boot_record(c, out, tag, disp)
    record.update({"ok": record["ok"] and not over, "method": method,
                   "payload_bytes": unpack.PAYLOAD_BYTES, "image_bytes": size,
                   "seconds": seconds, "bound": bound})
    return record, failures


def image_has_kvm(tree: Path) -> bool:
    """Whether the linked image carries KVM: its System.map lists kvm_init."""
    smap = tree / "System.map"
    return smap.exists() and re.search(
        r"(?m)^[0-9a-fA-F]+ [tT] kvm_init$",
        smap.read_text(errors="replace")) is not None


def module_depends(ko: bytes) -> list[str]:
    """The modules a .ko's modinfo says it depends on."""
    m = re.search(rb"(?:^|\0)depends=([^\0]*)\0", ko)
    if not m:
        return []
    return [d for d in m.group(1).decode(errors="replace").split(",") if d]


def kvm_modules(tree: Path, arch: dict) -> list[Path]:
    """The KVM modules the build made under the architecture's kvm
    directory, each preceded by the modules it depends on, so the list
    loads in order. modules.order, which `make modules` writes, names
    every module; the .ko sits beside the object it names."""
    order = tree / "modules.order"
    if not order.exists():
        return []
    kos = {}
    for line in order.read_text(errors="replace").splitlines():
        ko = (tree / line.strip()).with_suffix(".ko")
        if line.strip() and ko.is_file():
            kos[ko.stem.replace("-", "_")] = ko
    kvm_dir = tree / arch["kvm_dir"]
    out: list[Path] = []

    def add(name: str) -> None:
        ko = kos.get(name)
        if ko is None or ko in out:
            return
        for dep in module_depends(ko.read_bytes()):
            add(dep)
        out.append(ko)

    for name, ko in kos.items():
        if ko.parent == kvm_dir:
            add(name)
    return out


def kvm_carrier(args, arch: dict, tree: Path,
                kvm_dev: bool) -> tuple[list[Path], str, str]:
    """What carries KVM into the guest: nothing when the image has it built
    in, the build's modules otherwise, or a verdict and the reason. A host
    without KVM is a skip. A build without KVM is a skip when this run did
    not make it and a failure when it did, since the configuration asked."""
    if not kvm_dev:
        return [], SKIP, "no writable /dev/kvm on this host"
    if image_has_kvm(tree):
        return [], "", ""
    modules = kvm_modules(tree, arch)
    if modules:
        return modules, "", ""
    why = ("the build carries no KVM: System.map lists no kvm_init and "
           f"modules.order names no module under {arch['kvm_dir']}")
    if args.build:
        return [], FAIL, f"{why}, although the configuration asked for it"
    return [], SKIP, f"{why}; a --nested-kvm build makes it"


def data_dirs(qemu: str) -> list[Path]:
    """The directories the emulator searches for its firmware."""
    r = subprocess.run([qemu, "-L", "help"], capture_output=True, text=True)
    return [Path(l.strip()) for l in r.stdout.splitlines() if l.strip()]


def firmware_files(dirs: list[Path],
                   names: list[str]) -> tuple[dict[str, Path], list[str]]:
    """Each of `names` in the first of `dirs` holding it, and the names
    none holds."""
    found, missing = {}, []
    for name in names:
        hit = next((d / name for d in dirs if (d / name).is_file()), None)
        if hit is None:
            missing.append(name)
        else:
            found[name] = hit
    return found, missing


def emulator_refusal(text: str) -> str:
    """The emulator's own reason when it started no machine: no kernel
    banner, and a line naming the emulator."""
    if "Linux version " in text:
        return ""
    hits = [m.group(1) for line in text.splitlines()
            if (m := EMULATOR_ERROR.match(CONTROLS.sub("", line).strip()))]
    return hits[-1] if hits else ""


def split_guest(text: str) -> tuple[str, str | None]:
    """The log outside the guest bracket, the bracket lines included, and
    the guest's own console inside it, or None when it never started."""
    lines = text.splitlines(keepends=True)
    begin = next((i for i, l in enumerate(lines) if initramfs.GUEST_BEGIN in l),
                 None)
    if begin is None:
        return text, None
    end = next((i for i in range(begin + 1, len(lines))
                if initramfs.GUEST_END in lines[i]), len(lines))
    return "".join(lines[:begin + 1] + lines[end:]), "".join(lines[begin + 1:end])


def nested_facts(outer: str) -> dict[str, str]:
    """What /init reported about the guest stage: the `key=value` words of
    its report lines, and how the guest ended under `end`."""
    facts: dict[str, str] = {}
    for line in outer.splitlines():
        line = CONTROLS.sub("", line).strip()
        if line.startswith(initramfs.NESTED_MARKER + " "):
            for word in line.split()[1:]:
                key, sep, value = word.partition("=")
                if sep:
                    facts[key] = value
        elif line.startswith(initramfs.GUEST_END + " "):
            facts["end"] = line.split(None, 1)[1]
    return facts


def nesting_offered(arch_name: str, facts: dict, outer: str) -> tuple[str, str]:
    """What the guest was given to nest on, or "" and why not. x86 lists
    the extension among /proc/cpuinfo's flags, which /init reports; arm64's
    kernel reports the exception level its CPUs started at, and KVM there
    needs EL2."""
    if arch_name == "aarch64":
        m = EL_LINE.search(outer)
        if not m:
            return "", "the console reports no exception level"
        if m.group(1) != "EL2":
            return "", f"the CPUs started at {m.group(1)}"
        return m.group(1), ""
    flag = facts.get("cpuinfo", "")
    if flag in ("vmx", "svm"):
        return flag, ""
    return "", (f"/proc/cpuinfo lists neither vmx nor svm "
                f"(cpuinfo={flag or 'unreported'})")


def nested_verdict(args, arch_name: str, text: str, out: Path, cc_text: str,
                   badc_ld: bool | None) -> tuple[str, str, dict]:
    """The nested boot's verdict from its console: a skip where the
    emulator or the CPU model offers no nesting, a failure where /dev/kvm
    never appears or the guest never reaches the markers and exits, a pass
    otherwise. Both boots are held to the checks every boot is."""
    refusal = emulator_refusal(text)
    if refusal:
        if NESTING_REFUSAL.search(refusal):
            return SKIP, f"the emulator offers no nesting: {refusal}", {}
        return FAIL, f"the emulator refused to start: {refusal} (see {out})", {}
    outer, guest = split_guest(text)
    facts = nested_facts(outer)
    data: dict = {"facts": facts}
    c = boot_checks(args, outer, cc_text, badc_ld)
    failure = check_failure(args, "outer boot", c, outer, out)
    if failure:
        return FAIL, failure, data
    if not facts:
        return FAIL, f"/init reported nothing about the guest stage (see {out})", data
    offered, why = nesting_offered(arch_name, facts, outer)
    data["offered"] = offered
    if not offered:
        return SKIP, f"nesting is not offered to the guest: {why}", data
    if facts.get("kvm") != "open":
        kvm = " ".join(f"{k}={facts[k]}" for k in ("kvm", "errno", "dev")
                       if k in facts)
        return FAIL, (f"/dev/kvm did not appear in the guest "
                      f"({kvm or 'kvm unreported'}) with {offered} offered "
                      f"(see {out})"), data
    if guest is None:
        return FAIL, f"the guest emulator never started (see {out})", data
    g = boot_checks(args, guest, cc_text, badc_ld)
    data["guest"] = boot_record(g, out, "unpinned", "drawn")
    failure = check_failure(args, "guest", g, guest, out)
    if failure:
        last = excerpt(guest, 1)
        if last and not g["booted"]:
            failure += f"; last guest line {last[0]!r}"
        return FAIL, failure, data
    end = facts.get("end")
    if end is None:
        return FAIL, f"the guest emulator never exited (see {out})", data
    if end != "exit=0":
        return FAIL, f"the guest emulator ended with {end} (see {out})", data
    return PASS, (f"{offered} offered, /dev/kvm open, the guest reached both "
                  f"markers and its emulator exited"), data


def nested_boot(args, arch: dict, tree: Path, image: Path, cc_text: str,
                badc_ld: bool | None) -> tuple[dict, list[str]]:
    """Boot the image once more under the host's KVM, with an initramfs
    carrying the emulator, this build's KVM modules, the image and the
    marker initramfs, and read the guest the kernel then runs under its
    own KVM. Returns the record and the failures."""
    record: dict = {"status": SKIP, "detail": ""}
    qemu = Path(args.guest_qemu).resolve()
    modules, status, why = kvm_carrier(args, arch, tree,
                                       os.access("/dev/kvm", os.R_OK | os.W_OK))
    if not status:
        dirs = ([args.guest_firmware] if args.guest_firmware else []) + data_dirs(qemu)
        found, missing = firmware_files(dirs, arch["firmware"])
        if missing:
            status, why = FAIL, (f"no directory of {', '.join(map(str, dirs))} "
                                 f"holds {', '.join(missing)} for {qemu.name}; "
                                 f"demos/qemu/setup.py --pc-bios DIR fetches "
                                 f"the ROM set for --guest-firmware")
    if status:
        record.update(status=status, detail=why)
        log(f"nested boot: {status}: {why}")
        return record, [f"nested boot: {why}"] if status == FAIL else []
    files = {"kernel": image, "initrd": args.initramfs, **found}
    argv = [initramfs.guest_path(qemu.name), *arch["guest_machine"],
            "-smp", str(SMP_CPUS), "-m", str(GUEST_MEM), "-nographic",
            "-no-reboot", "-nic", "none", "-L", initramfs.GUEST_DIR,
            "-kernel", initramfs.guest_path("kernel"),
            "-initrd", initramfs.guest_path("initrd"),
            "-append", " ".join(append_args(arch, args.rdinit))]
    initrd = args.workdir / f"nested-{args.arch}.initrd"
    start = time.time()
    size = initramfs.build_image(initrd, args.arch, args.badc, None, modules,
                                 initramfs.Guest(qemu, files, argv))
    log(f"nested boot: wrote {initrd} ({size / 1e6:.1f} MB: {qemu.name}, its "
        f"libraries, {len(found)} firmware files, "
        f"{', '.join(m.name for m in modules) or 'KVM built in'}, the image "
        f"and the marker initramfs) in {time.time() - start:.0f}s")
    out = args.workdir / f"nested-{args.arch}.log"
    start = time.time()
    text = boot(args, arch, image, out, args.rdinit, None, initrd,
                machine=arch["nested_machine"], mem=NESTED_MEM)
    seconds = round(time.time() - start, 1)
    status, detail, data = nested_verdict(args, args.arch, text, out, cc_text,
                                          badc_ld)
    log(f"nested boot: {status} in {seconds}s: {detail}")
    if status == FAIL:
        for line in excerpt(text, 12):
            log(f"nested boot console: {line}")
    record.update(status=status, detail=detail, seconds=seconds,
                  image_bytes=size, log=str(out), emulator=str(qemu),
                  modules=[m.name for m in modules], **data)
    return record, [f"nested boot: {detail}"] if status == FAIL else []


def text_sizes(map_text: str) -> list[tuple[int, str]]:
    """(bytes, name) per text symbol of a System.map. The map records no
    sizes, so a symbol's is the gap to the next address any symbol holds,
    one name per address; weak symbols are functions too."""
    rows = sorted((int(f[0], 16), f[1], f[2])
                  for f in (l.split() for l in map_text.splitlines())
                  if len(f) >= 3 and re.fullmatch(r"[0-9a-fA-F]+", f[0]))
    out: list[tuple[int, str]] = []
    i = 0
    while i < len(rows):
        addr, j, names = rows[i][0], i, []
        while j < len(rows) and rows[j][0] == addr:
            if rows[j][1] in "tTW" and not TEXT_LABEL.match(rows[j][2]):
                names.append(rows[j][2])
            j += 1
        if names and j < len(rows) and rows[j][0] - addr < MAX_FUNCTION_BYTES:
            out.append((rows[j][0] - addr, names[-1]))
        i = j
    return out


def text_summary(sizes: list[tuple[int, str]]) -> dict:
    """The two budgeted figures and the population they come from."""
    big = max(sizes) if sizes else (0, "")
    return {"functions": len(sizes), "largest": list(big),
            "over_4k": sum(1 for s, _ in sizes if s > 4096)}


def text_budget_failures(summary: dict, budget: dict | None) -> list[str]:
    """What the text sizes exceed, or nothing."""
    if budget is None or not summary["functions"]:
        return []
    out = []
    size, name = summary["largest"]
    if size > budget["largest"]:
        out.append(f"largest function {name} is {size} bytes, over the "
                   f"{budget['largest']} budget")
    if summary["over_4k"] > budget["over_4k"]:
        out.append(f"{summary['over_4k']} functions over 4 KiB, over the "
                   f"{budget['over_4k']} budget")
    return out


def _self_test() -> int:
    """Check the banner reading against both lanes' real console text.

    These are pure functions and the gate reaches them an hour into a run, so
    they are checked where a push can afford to say so.
    """
    cc = "badc 0.3.0 (gcc-compatible, GNU C 4.2.1)"

    def line(ld: str) -> str:
        return f"Linux version 7.1.10 (u@h) ({cc}, {ld}) #1 SMP PREEMPT"

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
    assert banner_failure("Linux version 7.1.10 (u@h) (gcc 13.2, GNU ld 2.46) #1",
                          cc, True) == "does not identify badc as the compiler"
    assert banner_failure("", cc, True), "a log with no banner cannot pass"

    # The bringup count, which a boot that reaches userspace on one core of
    # two still prints.
    assert smp_failure("[    1.3] smpboot: Total of 2 processors activated (1 "
                       "BogoMIPS)\n", 2) == ""
    assert smp_failure("[   31.1] smpboot: Total of 1 processors activated\n",
                       2) == "activated 1 of 2 processors"
    assert smp_failure("[    1.3] SMP: Total of 2 processors activated.\n",
                       2) == ""
    assert "no processor count" in smp_failure("a quiet console\n", 2)

    # A fault the kernel reports on its way to the marker. Reaching init is
    # not a verdict on the kernel: this text is from an image whose ftrace
    # patch sites were malformed, which booted to userspace all the same.
    ftrace = ("[    0.000000] ------------[ ftrace bug ]------------\n"
              "[    0.000000] ftrace faulted on writing\n"
              "[    0.000000] ------------[ cut here ]------------\n"
              "[    0.000000] WARNING: kernel/trace/ftrace.c:2260 at "
              "ftrace_bug+0x600/0x960, CPU#0: swapper/0\n"
              "[    0.000000] Call trace:\n")
    assert "2 kernel fault line(s)" in fault_failure(ftrace), fault_failure(ftrace)
    assert fault_failure("[    0.1] smpboot: Total of 2 processors activated\n"
                         "[    1.2] Run /init as init process\n") == ""
    # The crypto self-test verdicts, which report a miscompiled cipher without
    # any of the fault words.
    assert fault_failure("[   2.0] alg: skcipher: test failed for aes\n")

    # A failed build states its cause in the run's own output: the gate runs
    # on remote boxes, where the log path it names is another trip away.
    build = ("  GEN     net/wireless/shipped-certs.c\n"
             "  CC      net/wireless/shipped-certs.o\n"
             "badc: error: cannot read `net/wireless/shipped-certs.c`: "
             "No such file or directory (os error 2)\n"
             "make[4]: *** [scripts/Makefile.build:289: "
             "net/wireless/shipped-certs.o] Error 1\n"
             "  CC      net/wireless/util.o\n")
    lines = excerpt(build, 20, BUILD_ERROR_RE)
    assert len(lines) == 2 and "cannot read" in lines[0], lines
    assert "Error 1" in lines[1], lines
    # Nothing matched: the tail is what there is to report, and the firmware's
    # escapes do not reach the terminal the run prints to.
    assert excerpt("a\nb\nc\n", 2, BUILD_ERROR_RE) == ["b", "c"]
    assert excerpt("\x1b[2JSeaBIOS\x1b[0m\n", 1) == ["[2JSeaBIOS[0m"]

    # The per-boot verdicts and the failure each states.
    opts = argparse.Namespace(marker=DEFAULT_MARKER,
                              check_marker=DEFAULT_CHECK_MARKER)
    good = (f"[    0.000000] {badc}\n"
            "[    1.3] smpboot: Total of 2 processors activated\n"
            f"[    2.1] Run /init as init process\n{DEFAULT_MARKER} 1/5\n"
            f"{CHECK_STEP} reading /proc/stat\n{DEFAULT_CHECK_MARKER} 1/5\n")
    c = boot_checks(opts, good, cc, True)
    assert c["booted"] and c["checked"] and c["banner"] == badc, c
    assert check_failure(opts, "boot 1", c, good, Path("b1.log")) == ""
    assert verdict_text(c) == "marker=yes checks=yes cpus=yes clean=yes"
    assert boot_record(c, Path("b1.log"), "0x1", "0x2000")["ok"]
    stopped = good.replace(f"{DEFAULT_CHECK_MARKER} 1/5\n", "")
    c = boot_checks(opts, stopped, cc, True)
    f = check_failure(opts, "boot 2", c, stopped, Path("b2.log"),
                      "; replay with --kaslr-seed 0x1")
    assert f == (f"boot 2 did not reach {DEFAULT_CHECK_MARKER!r}, last step "
                 f"'reading /proc/stat' (see b2.log); replay with "
                 f"--kaslr-seed 0x1"), f
    c = boot_checks(opts, good.replace(badc, ref), cc, True)
    assert check_failure(opts, "boot 3", c, good, Path("b3.log")).startswith(
        "boot 3 banner does not name badc as the linker")
    assert not boot_record(c, Path("b3.log"), "unpinned", "drawn")["ok"]
    assert seed_tags(1, {1: 0x2000}) == ("0x0000000000000001", "0x2000")
    assert seed_tags(None, {None: 0x2000}) == ("unpinned", "drawn")

    # The unpack phase: the console's own failure, a missing bracket, and
    # the bound; none is a failure without a bound.
    assert unpack_failure(6.1, "", 7.5) == ""
    assert unpack_failure(9.78, "", None) == ""
    assert unpack_failure(9.78, "", 7.5) == ("unpacked the payload in 9.78 s, "
                                             "over the 7.5 s bound")
    assert unpack_failure(None, "has no `Unpacking initramfs` line on its "
                          "console", 7.5).startswith("has no")
    assert unpack_failure(1.6, "reported `Initramfs unpacking failed: x`",
                          None).startswith("reported")
    unpack.self_test()

    # Text sizes from a System.map: the gap to the next address any symbol
    # holds, one name per address, without the linker labels; a weak symbol
    # counts, a gap of a megabyte does not.
    smap = ("ffff800080000000 T _text\n"
            "ffff800080000000 t __pi__text\n"
            "ffff800080010000 T __irqentry_text_start\n"
            "ffff800080010000 T _stext\n"
            "ffff800080010000 t gic_handle_irq\n"
            "ffff800080010200 T __irqentry_text_end\n"
            "ffff800080010200 T small_fn\n"
            "ffff800080010300 W weak_fn\n"
            "ffff800080011400 T big_fn\n"
            "ffff800080013400 D some_table\n"
            "ffff800080020000 T _etext\n"
            "ffff800080020000 R __start_rodata\n"
            "ffff800080100000 T _sinittext\n"
            "ffff800080100000 t init_fn\n"
            "ffff800080100100 T _einittext\n"
            "ffff800080100100 T __exittext_begin\n"
            "ffff800080100100 t exit_fn\n"
            "ffff800080100140 T __exittext_end\n"
            "ffff800080100140 t lonely_fn\n"
            "ffff800081200000 D far_data\n")
    sizes = {n: s for s, n in text_sizes(smap)}
    assert sizes == {"gic_handle_irq": 512, "small_fn": 256, "weak_fn": 4352,
                     "big_fn": 8192, "init_fn": 256, "exit_fn": 64}, sizes
    summary = text_summary(text_sizes(smap))
    assert summary == {"functions": 6, "largest": [8192, "big_fn"],
                       "over_4k": 2}, summary
    assert text_budget_failures(summary, {"largest": 8192, "over_4k": 2}) == []
    assert text_budget_failures(summary, None) == []
    over = text_budget_failures(summary, {"largest": 8191, "over_4k": 1})
    assert over == ["largest function big_fn is 8192 bytes, over the 8191 "
                    "budget", "2 functions over 4 KiB, over the 1 budget"], over
    assert text_summary([]) == {"functions": 0, "largest": [0, ""],
                                "over_4k": 0}
    assert text_budget_failures(text_summary([]), TEXT_BUDGETS["aarch64"]) == []

    # The nested boot, read from an inline console: the outer kernel's
    # lines and /init's report around the guest's own console, which the
    # bracket lines set apart. Both boots are held to the marker checks.
    facts = "BADC-NESTED cpuinfo=vmx\nBADC-NESTED kvm=open\n"
    begin = "BADC-NESTED-GUEST-BEGIN /guest/qemu-system-x86_64\n"
    end = "BADC-NESTED-GUEST-END exit=0\n"
    full = good + facts + begin + good + end + "[    9.0] reboot: Restarting system\n"
    outer, guest = split_guest(full)
    assert guest == good and begin in outer and end in outer, (outer, guest)
    assert outer.count(DEFAULT_MARKER) == 1 and split_guest(good) == (good, None)
    assert nested_facts(outer) == {"cpuinfo": "vmx", "kvm": "open", "end": "exit=0"}
    out = Path("nested.log")
    st, detail, data = nested_verdict(opts, "x86_64", full, out, cc, True)
    assert st == PASS and data["offered"] == "vmx", (st, detail)
    assert data["guest"]["ok"] and data["facts"]["kvm"] == "open", data
    # Skipped: the CPU model lists no extension, so nothing registers
    # /dev/kvm. Failed: it lists one and /dev/kvm still never appears.
    st, detail, _ = nested_verdict(opts, "x86_64", good + "BADC-NESTED cpuinfo=-\n"
                                   "BADC-NESTED kvm=absent errno=2\n", out, cc, True)
    assert st == SKIP and "neither vmx nor svm" in detail, detail
    st, detail, _ = nested_verdict(opts, "x86_64", good + facts.replace(
        "kvm=open", "kvm=absent errno=2"), out, cc, True)
    assert st == FAIL and detail.startswith("/dev/kvm did not appear"), detail
    assert "errno=2" in detail and "vmx offered" in detail, detail
    # Failed: the guest's kernel never reached the marker, and its last
    # line is quoted; the guest never exited; it ended by a signal; it was
    # never started once /dev/kvm opened.
    dead = (good + facts + begin + "KVM: entry failed, hardware error "
            "0x80000021\n" + "BADC-NESTED-GUEST-END exit=1\n")
    st, detail, _ = nested_verdict(opts, "x86_64", dead, out, cc, True)
    assert st == FAIL and detail.startswith("guest did not reach"), detail
    assert detail.endswith("last guest line 'KVM: entry failed, hardware "
                           "error 0x80000021'"), detail
    st, detail, _ = nested_verdict(opts, "x86_64", good + facts + begin + good,
                                   out, cc, True)
    assert st == FAIL and "never exited" in detail, detail
    st, detail, _ = nested_verdict(opts, "x86_64", good + facts + begin + good
                                   + "BADC-NESTED-GUEST-END signal=9\n",
                                   out, cc, True)
    assert st == FAIL and "ended with signal=9" in detail, detail
    st, detail, _ = nested_verdict(opts, "x86_64", good + facts
                                   + "BADC-NESTED fork errno=12\n", out, cc, True)
    assert st == FAIL and "never started" in detail, detail
    # Failed: the outer boot itself, and an /init that reported nothing.
    st, detail, _ = nested_verdict(opts, "x86_64", stopped, out, cc, True)
    assert st == FAIL and detail.startswith("outer boot did not reach"), detail
    st, detail, _ = nested_verdict(opts, "x86_64", good, out, cc, True)
    assert st == FAIL and "reported nothing" in detail, detail
    # Skipped: the emulator started no machine because the host's KVM
    # offers no nesting, in the aarch64 box's words; failed: it refused
    # for a reason of the harness's.
    refused = ("qemu-system-aarch64: mach-virt: host kernel KVM does not "
               "support providing Virtualization extensions to the guest CPU\n")
    st, detail, _ = nested_verdict(opts, "aarch64", refused, out, cc, True)
    assert st == SKIP and "Virtualization extensions" in detail, detail
    st, detail, _ = nested_verdict(opts, "aarch64", "qemu-system-aarch64: "
                                   "could not load kernel '/x'\n", out, cc, True)
    assert st == FAIL and "refused to start" in detail, detail
    assert emulator_refusal("") == "" and emulator_refusal(full) == ""
    # aarch64: what is offered is the exception level the CPUs started at.
    el2 = good.replace("smpboot: Total of 2 processors activated",
                       "SMP: Total of 2 processors activated.\n"
                       "[    1.3] CPU: All CPU(s) started at EL2")
    a64 = "BADC-NESTED cpuinfo=-\nBADC-NESTED kvm=open\n"
    st, detail, data = nested_verdict(
        opts, "aarch64", el2 + a64 + begin.replace("x86_64", "aarch64") + el2
        + end, out, cc, True)
    assert st == PASS and data["offered"] == "EL2", (st, detail)
    st, detail, _ = nested_verdict(opts, "aarch64", el2.replace("EL2", "EL1")
                                   + a64.replace("kvm=open", "kvm=absent errno=2"),
                                   out, cc, True)
    assert st == SKIP and "started at EL1" in detail, detail
    st, detail, _ = nested_verdict(opts, "aarch64", good + a64, out, cc, True)
    assert st == SKIP and "no exception level" in detail, detail

    # What carries KVM into the guest: the image itself, the build's
    # modules in dependency order, or nothing and a verdict; and the
    # firmware the guest's emulator takes from the first directory
    # holding it.
    assert module_depends(b"\0license=GPL\0depends=irqbypass,kvm\0name=x\0") == [
        "irqbypass", "kvm"]
    assert module_depends(b"depends=\0license=GPL\0") == []
    assert module_depends(b"no modinfo") == []
    with tempfile.TemporaryDirectory() as d:
        tree = Path(d)
        built = argparse.Namespace(build=True)
        unbuilt = argparse.Namespace(build=False)
        x64, a64 = ARCHES["x86_64"], ARCHES["aarch64"]
        assert kvm_carrier(built, x64, tree, False) == (
            [], SKIP, "no writable /dev/kvm on this host")
        (tree / "System.map").write_text("ffffffff81000000 T _text\n"
                                         "ffffffff81234560 T kvm_init_foo\n")
        assert kvm_carrier(built, x64, tree, True)[1] == FAIL
        assert kvm_carrier(unbuilt, x64, tree, True)[1] == SKIP
        kos = {"arch/x86/kvm/kvm-intel": b"\0depends=kvm\0",
               "arch/x86/kvm/kvm": b"\0depends=irqbypass\0",
               "arch/x86/kvm/kvm-amd": b"\0depends=kvm\0",
               "virt/lib/irqbypass": b"\0depends=\0",
               "drivers/net/foo": b"\0depends=\0"}
        for name, info in kos.items():
            (tree / name).parent.mkdir(parents=True, exist_ok=True)
            (tree / name).with_suffix(".ko").write_bytes(b"\x7fELF" + info)
        (tree / "modules.order").write_text(
            "".join(f"{n}.o\n" for n in kos) + "arch/x86/kvm/gone.o\n")
        mods = [m.relative_to(tree).as_posix() for m in kvm_modules(tree, x64)]
        assert mods == ["virt/lib/irqbypass.ko", "arch/x86/kvm/kvm.ko",
                        "arch/x86/kvm/kvm-intel.ko", "arch/x86/kvm/kvm-amd.ko"], mods
        assert kvm_modules(tree, a64) == []
        carried, st, why = kvm_carrier(built, x64, tree, True)
        assert st == "" and [m.name for m in carried] == [
            "irqbypass.ko", "kvm.ko", "kvm-intel.ko", "kvm-amd.ko"], (st, why)
        (tree / "System.map").write_text("ffffffff81234560 T kvm_init\n")
        assert kvm_carrier(built, x64, tree, True) == ([], "", "")
        for name in ("a", "b"):
            (tree / name).mkdir()
        (tree / "b" / "bios-256k.bin").write_bytes(b"B")
        (tree / "a" / "kvmvapic.bin").write_bytes(b"V")
        (tree / "b" / "kvmvapic.bin").write_bytes(b"V2")
        found, missing = firmware_files(
            [tree / "a", tree / "b"],
            ["bios-256k.bin", "kvmvapic.bin", "linuxboot_dma.bin"])
        assert found == {"bios-256k.bin": tree / "b" / "bios-256k.bin",
                         "kvmvapic.bin": tree / "a" / "kvmvapic.bin"}, found
        assert missing == ["linuxboot_dma.bin"], missing
    for spec in ARCHES.values():
        assert spec["nested_machine"] and spec["guest_machine"] and spec["kvm_symbols"]

    diags.self_test()
    ktree.self_test()
    # The compile shim's flag classification, which decides what reaches
    # badc; nothing else runs it, and a kernel unit is an hour into a run.
    buildcc._self_test()
    karch.self_test()
    print("linux verify: self-test ok", flush=True)
    return 0


def kaslr_configured(tree: Path) -> bool:
    """Whether the tree's configuration randomizes the kernel base."""
    return config_value(tree, "RANDOMIZE_BASE") == "y"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--kernel-dir", required=True, type=Path,
                    help="writable, already-configured kernel tree to build")
    ap.add_argument("--arch", choices=sorted(ARCHES),
                    default=karch.host_arch())
    ap.add_argument("--badc", type=Path,
                    default=os.environ.get("BADC", REPO_ROOT / "target/release/badc"))
    ap.add_argument("--real-cc", default=os.environ.get("BADC_REAL_CC"),
                    help="compiler for the units badc does not take "
                         "(default: the target's gcc)")
    ap.add_argument("--linker", choices=("reference", "badc"),
                    default=os.environ.get("BADC_LINKER", "badc"),
                    help="who links: `badc` (the default) runs every link "
                         "through ldshim.py, `reference` leaves them all to "
                         "--real-ld (the contrast run). See README.md")
    ap.add_argument("--real-ld", default=os.environ.get("BADC_LD_REAL"),
                    help="linker for the steps badc does not implement, and "
                         "for every step under --linker reference (default: "
                         "the target's ld)")
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
    ap.add_argument("--payload", action=argparse.BooleanOptionalAction,
                    default=True,
                    help="after the boots, boot the payload image once more "
                         "(unpack.py) and hold its unpack time to the bound")
    ap.add_argument("--payload-dir", type=Path,
                    help="where the payload archive is kept between runs "
                         "(default: beside the kernel tree)")
    ap.add_argument("--max-unpack-seconds", type=float,
                    help="bound on the payload boot's unpack time (default: "
                         "the architecture's UNPACK_BOUNDS entry, for the "
                         "zstd payload; 0 reports only)")
    ap.add_argument("--nested-kvm", action="store_true",
                    help="after the other boots, boot once more under this "
                         "host's KVM with an initramfs carrying --guest-qemu, "
                         "this build's KVM modules, the image and the marker "
                         "initramfs, and hold the guest the kernel runs under "
                         "its own KVM to the marker checks; skipped where the "
                         "host, the emulator or the CPU model offers no "
                         "nesting. With --build the configuration builds KVM")
    ap.add_argument("--guest-qemu", type=Path,
                    help="the emulator the nested boot carries into the guest "
                         "and runs there: the badc-built one demos/qemu "
                         "produces (its objs/qemu-system-<arch>)")
    ap.add_argument("--guest-firmware", type=Path,
                    help="directory holding the firmware --guest-qemu reads "
                         "(demos/qemu/setup.py --pc-bios DIR), searched ahead "
                         "of the emulator's own data directories")
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
    # The fallback compiler and linker have to produce the target's objects,
    # so an unset default follows --arch rather than naming the host tools.
    args.real_cc = args.real_cc or karch.tool(args.arch, "gcc")
    args.real_ld = args.real_ld or karch.tool(args.arch, "ld")
    args.qemu_args = shlex.split(args.qemu_args)
    tree = args.kernel_dir.resolve()
    args.badc = Path(args.badc).resolve()
    args.workdir = Path(args.workdir).resolve()
    args.workdir.mkdir(parents=True, exist_ok=True)
    args.payload_dir = (args.payload_dir or tree.parent).resolve()
    if args.payload and not os.access(args.payload_dir, os.W_OK):
        log(f"{args.payload_dir} is not writable; the payload archive goes "
            f"to {args.workdir}")
        args.payload_dir = args.workdir

    # The nested boot builds its initramfs with badc as well.
    if (args.build or args.nested_kvm) and not os.access(args.badc, os.X_OK):
        die(f"badc not executable: {args.badc} "
            f"(cargo build --release --features full)")
    if args.nested_kvm and not args.boot:
        die("--nested-kvm is a boot; it does not go with --no-boot")
    if args.nested_kvm and not (args.guest_qemu and os.access(args.guest_qemu, os.X_OK)):
        die(f"--nested-kvm needs --guest-qemu naming the emulator to carry "
            f"into the guest; {args.guest_qemu or 'none given'} is not "
            f"executable (demos/qemu/smoke.py builds it)")
    if not (tree / ".config").exists():
        die(f"{tree} is not configured (run setup.py)")
    # A tree configured for another architecture would otherwise reach make
    # and fail on the missing image target, naming neither architecture.
    mismatch = karch.config_mismatch(tree / ".config", args.arch)
    if mismatch:
        die(mismatch)
    if args.build:
        gap = karch.cross_gap(args.arch)
        if gap:
            die(gap)
    if args.build and not os.access(tree, os.W_OK):
        die(f"{tree} is not writable; build a copy, not the reference corpus")
    if args.build:
        # Held to the end of the run: `make clean` and the build both write
        # the tree, and a second run's clean removes this one's generated
        # sources mid-compile.
        ktree.exclusive(tree, f"verify.py --arch {args.arch}")
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
    units = {"badc": [], "fallback": [], "fail": [], "missing": [],
             "badc-asm": [], "gas": []}
    links = {"badc": [], "ld": [], "fallback": [], "fail": []}
    diagnostics: collections.Counter = collections.Counter()
    text_report: dict = {}
    rc, secs, undef = 0, 0.0, 0
    if args.build:
        # Named before anything is built: a console log has to say which
        # linker produced the image the boots below ran.
        log(f"linker: {'badc (ldshim.py)' if args.linker == 'badc' else args.real_ld}")
        manifest = args.workdir / f"manifest-{args.arch}.txt"
        ld_manifest = args.workdir / f"ld-manifest-{args.arch}.txt"
        warn_log = args.workdir / f"warnings-{args.arch}.txt"
        rc, secs, build_log = build(args, arch, tree, manifest, ld_manifest,
                                    warn_log)
        units = read_manifest(manifest)
        links = read_manifest(ld_manifest,
                              ("badc", "ld", "fallback", "fail"))
        text = build_log.read_text(errors="replace")
        undef = len(re.findall(r"undefined reference", text))

        log(f"make rc={rc} in {secs:.0f}s: badc={len(units['badc'])} "
            f"fallback={len(units['fallback'])} fail={len(units['fail'])} "
            f"missing={len(units['missing'])} undefined-refs={undef}")
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

        diagnostics, lines = diags.summary(warn_log)
        for line in lines:
            log(line)

        smap = tree / "System.map"
        if rc == 0 and not smap.exists():
            failures.append(f"no System.map at {smap}")
        elif rc == 0:
            text_report = text_summary(
                text_sizes(smap.read_text(errors="replace")))
            budget = TEXT_BUDGETS.get(args.arch)
            text_report["budget"] = budget
            size, name = text_report["largest"]
            log(f"text sizes: {text_report['functions']} functions, largest "
                f"{size} ({name}), {text_report['over_4k']} over 4 KiB; "
                + (f"budget {budget['largest']} and {budget['over_4k']}"
                   if budget else "no committed budget"))
            failures.extend(text_budget_failures(text_report, budget))

        if rc != 0:
            failures.append(f"make exited {rc} (see {build_log})")
            for line in excerpt(text, 20, BUILD_ERROR_RE):
                log(f"build: {line}")
        if units["fail"]:
            named = ", ".join(u.split("\t")[0] for u in units["fail"][:5])
            failures.append(f"units badc could not compile: {len(units['fail'])} "
                            f"({named})")
        if units["missing"]:
            named = ", ".join(u.split("\t")[0] for u in units["missing"][:5])
            failures.append(f"sources not in the tree when their compile ran: "
                            f"{len(units['missing'])} ({named}); no compiler "
                            f"saw them")
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
    unpacked: dict = {}
    nested: dict = {}
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
            c = boot_checks(args, text, cc_text, badc_ld)
            tag, disp = seed_tags(seed, offsets)
            log(f"boot {i}/{len(plan)}: seed={tag} displacement={disp} "
                f"{verdict_text(c)} console-lines={c['lines']}")
            if i == 1 and c["banner"]:
                log(f"banner: {c['banner']}")
            boots.append(boot_record(c, out, tag, disp))
            replay = (f"; replay with --kaslr-seed 0x{seed:016x}"
                      if seed is not None else "")
            failure = check_failure(args, f"boot {i}", c, text, out, replay)
            if failure:
                failures.append(failure)
            if not (c["booted"] and c["checked"]):
                for line in excerpt(text, 12):
                    log(f"boot {i} console: {line}")
        failures.extend(kaslr.displacement_failures(
            kaslr_configured(tree), plan, offsets))
        if args.payload and not failures:
            seed = plan[0] if plan else None
            unpacked, more = payload_boot(args, arch, tree, image, seed,
                                          trees.get(seed), offsets, cc_text,
                                          badc_ld)
            failures.extend(more)
        if args.nested_kvm and not failures:
            nested, more = nested_boot(args, arch, tree, image, cc_text, badc_ld)
            failures.extend(more)

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
            # Diagnostics from compiles and links that succeeded, by
            # (shim, severity, cause) and ranked by incidence.
            "diagnostics": [[list(k), n]
                            for k, n in diagnostics.most_common()],
            "undefined_refs": undef,
            # The linked image's text sizes against their budget.
            "text": text_report,
            "boots": boots,
            # The payload boot: the marker boots' verdicts plus the
            # unpack time and its bound.
            "unpack": unpacked,
            # The nested boot: its verdict, what /init reported, and the
            # guest's own boot record.
            "nested": nested,
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
    if unpacked:
        bound = (f" (bound {unpacked['bound']:.1f} s)" if unpacked["bound"]
                 else " (no bound)")
        booted += (f"; the {unpacked['payload_bytes'] // 1_000_000} MB "
                   f"{unpacked['method']} payload unpacked in "
                   f"{unpacked['seconds']:.2f} s{bound}")
    if nested:
        booted += f"; nested KVM {nested['status']}: {nested['detail']}"
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
