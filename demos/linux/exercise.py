#!/usr/bin/env python3
"""Post-boot exercise stage for the badc-compiled kernel.

`packages.py` proves the packaged kernel boots and that the emulated storage
and network bind. That covers a few dozen of the several thousand modules a
distribution kernel ships. This stage runs after those probes, inside the
badc kernel, and drives the code the boot never reaches:

  storage  the root device round-tripped through its controller: a known
           payload written and read back with direct I/O, and the raw device
           read twice, with the kernel log window the I/O produced read as
           part of the verdict
  sockets  every protocol family the configuration builds: the socket
           created, bound where a family binds without a peer, and driven
           through a local transfer where one is reachable
  crypto   every crypto module loaded, the registration self-tests forced
           where the configuration keeps them, and a known-answer sweep that
           reaches each registered implementation through AF_ALG by its
           driver name -- so an arch-optimized path is checked on its own,
           against hashlib or against the generic implementation
  modules   every built module loaded once, classified, and pruned again
  kunit     the in-kernel test suites, when the configuration builds them
  fs        filesystems built on loop devices over sparse files, stressed in
            parallel, verified against digests taken from the source data,
            then fsck'd -- including the btrfs checksum variants and dm-crypt,
            which put filesystem data through the kernel's crypto code
  dmesg     one consolidated severity scan over the whole stage

Steps are data: a name, the guest work, and the rule that reads the outcome.
`GATE_STEPS` is the subset that runs on every boot: those cost seconds, and
they are the only check on subsystems the boot probes never reach. `--exercise`
widens the stage to the whole set, whose module sweep and filesystem matrix
cost minutes. `--self-test` checks the parsers and the verdict rules and needs
no guest.
"""

from __future__ import annotations

import json
import re
import shlex
import sys
import time
from pathlib import Path

LINUX_DIR = Path(__file__).resolve().parent
GUEST_DIR = "/home/badc/badc-exercise"
DMESG_LOG = "/var/tmp/badc-exercise-dmesg.log"

# Kernel-log patterns that report a fault. The boot probes compare the second
# against the stock baseline; inside the stage both fail the step that
# produced them, since the stage's own work is what put them there.
#
# The second group is driver-reported. An oops-shaped vocabulary alone let a
# storage controller answering every command with a hardware error through as
# a clean boot: the sense data is the fault report, and nothing above it
# matches. The sense keys listed are the ones a working device does not
# produce; `Not Ready`, `Illegal Request` and `Unit Attention` are the normal
# answers of empty removable media and of probes for optional commands, so
# they are left to the KERN_ERR baseline comparison instead.
DMESG_SEVERE = re.compile(
    r"BUG:|Oops|Call [Tt]race|general protection|"
    r"Unable to handle kernel|kernel NULL pointer|UBSAN:|KASAN:|"
    r"Sense Key : (Hardware Error|Medium Error|Aborted Command|Data Protect)|"
    r"Add\. Sense: Internal target failure|"
    r"critical (target|medium|nexus) error|"
    r"Buffer I/O error on dev|blk_update_request: I/O error|"
    r"EXT4-fs error|BTRFS (error|critical)|XFS \(.*\): (C|c)orruption|"
    r"F2FS-fs .*: (invalid|corrupted)|"
    r"PCIe Bus Error|AER: .*(error|Error)")
DMESG_WARN = re.compile(r"WARNING:")

# Kernel-log line shapes that vary between boots: the timestamp, and the
# addresses, PIDs and device indices inside the text. Collapsing them lets the
# stock baseline and the kernel under test be compared line for line.
LOG_STAMP = re.compile(r"^<?\d*>?\[\s*\d+\.\d+\]\s*")
LOG_VARIABLE = re.compile(r"0x[0-9a-fA-F]+|\b\d+\b")

# The crypto subsystem's own verdict lines: testmgr prints these when an
# implementation disagrees with its test vectors.
ALG_FAIL = re.compile(r"alg: .*(test failed|failed to|inconsistent)|"
                      r"self-test failed", re.I)

# `dmesg -x` prefixes each line with `facility:level : ` before the
# timestamp, which is how the stage reads severity rather than guessing it
# from the text.
DMESG_DECODE = r"(?:\w+\s*:\w+\s*: )?"
DMESG_STAMP = re.compile(rf"^{DMESG_DECODE}\[\s*(\d+\.\d+)\]")
DMESG_LEVEL_ERR = re.compile(r"^\w+\s*:(err|crit|alert|emerg)\s*:")

# Taint bits 4 (machine check) and 7 (oops/die).
TAINT_CRASH = 0x90

# Spare disks are thin qcow2 files: the size is the ceiling a raid1 member or
# a whole-disk filesystem instance can reach, not space taken up front.
SPARE_SIZE = "8G"

# The sweep holds every loaded module resident between prunes; the boot
# default leaves too little for that plus the filesystem workloads. EFI
# boots every disk bus at this size; the SeaBIOS fallback does not boot an
# nvme disk here, which is what SEABIOS_NVME_MEM_LIMIT reports up front.
EXERCISE_VM_MEM = 4096

PASS, SKIP, FAIL = "pass", "skip", "fail"

# Modules that fault, stall or loop by design, and the test suites, which the
# kunit step reads as TAP rather than as load outcomes. A suite loaded here
# runs a second time and collides with its own boot-time registrations, and
# not every suite carries `kunit` in its name -- `platform-test` does not.
MODULE_SKIP_RE = r"(^test_|_tests?$|torture|lkdtm|kunit)"

# Guest packages that supply the filesystem and block-stack tools. Absent ones
# turn their instances into skips, so provisioning only widens coverage.
GUEST_TOOL_PACKAGES = {
    "deb": ["xfsprogs", "btrfs-progs", "f2fs-tools", "dosfstools",
            "exfatprogs", "ntfs-3g", "squashfs-tools", "erofs-utils",
            "udftools", "xorriso", "cryptsetup-bin", "mdadm"],
    "rpm": ["xfsprogs", "btrfs-progs", "f2fs-tools", "dosfstools",
            "exfatprogs", "ntfsprogs", "squashfs-tools", "erofs-utils",
            "udftools", "xorriso", "cryptsetup", "mdadm"],
}


# Protocol families a distribution kernel configures, the option that builds
# each, and the modules that must be resident before the family answers.
# `af_vsock.c` declares no `net-pf-40` alias, so nothing autoloads vsock: a
# family reached only through autoload would go unprobed on every guest.
SOCKET_FAMILIES = (
    {"name": "AF_UNIX", "config": "CONFIG_UNIX", "modules": ()},
    {"name": "AF_INET", "config": "CONFIG_INET", "modules": ()},
    {"name": "AF_INET6", "config": "CONFIG_IPV6", "modules": ("ipv6",)},
    {"name": "AF_NETLINK", "config": "CONFIG_NET", "modules": ()},
    {"name": "AF_PACKET", "config": "CONFIG_PACKET", "modules": ("af_packet",)},
    {"name": "AF_ALG", "config": "CONFIG_CRYPTO_USER_API_HASH",
     "modules": ("af_alg", "algif_hash")},
    {"name": "AF_VSOCK", "config": "CONFIG_VSOCKETS",
     "modules": ("vsock", "vsock_loopback")},
)


# --- pure helpers -----------------------------------------------------------

def dmesg_since(text: str, since: float) -> list[str]:
    """The lines of a dmesg capture stamped at or after `since` seconds of
    uptime. A line with no stamp belongs to the record before it. A capture
    with no stamps at all is returned whole: over-reporting is safe, dropping
    a fault line is not."""
    out: list[str] = []
    keep = False
    stamped = False
    for line in text.splitlines():
        m = DMESG_STAMP.match(line)
        if m:
            stamped = True
            keep = float(m.group(1)) >= since
        if keep:
            out.append(line)
    return out if stamped else text.splitlines()


def normalize_log(text: str) -> list[str]:
    """Kernel-log lines with the timestamp and the numbers that differ between
    boots collapsed, so two boots' error logs compare as sets of lines."""
    out = []
    for line in text.splitlines():
        line = LOG_STAMP.sub("", line).strip()
        if line:
            out.append(LOG_VARIABLE.sub("#", line))
    return out


def dmesg_faults(lines) -> list[str]:
    """A task's own log window needs no vocabulary: the same kernel logged
    these seconds apart, so anything it recorded at KERN_ERR belongs to the
    work that provoked it. The patterns stay for a log with no decoded
    severity -- a follower without `dmesg -x`, or a ring-buffer read."""
    return [l for l in lines
            if DMESG_LEVEL_ERR.match(l) or DMESG_SEVERE.search(l)
            or DMESG_WARN.search(l) or ALG_FAIL.search(l)]


def parse_kv(text: str) -> dict[str, list[str]]:
    """`key=value` output from the guest scripts. A key that repeats keeps
    every value, so the per-module and per-file findings survive."""
    out: dict[str, list[str]] = {}
    for line in text.splitlines():
        k, sep, v = line.partition("=")
        if sep and k and " " not in k:
            out.setdefault(k, []).append(v)
    return out


def one(kv: dict[str, list[str]], key: str, default: str = "") -> str:
    return kv[key][-1] if kv.get(key) else default


def config_options(text: str) -> dict[str, str]:
    out = {}
    for line in text.splitlines():
        m = re.match(r"(CONFIG_\w+)=(.*)", line)
        if m:
            out[m.group(1)] = m.group(2)
    return out


KTAP_RESULT = re.compile(
    r"^(?:\[[^\]]*\]\s*)?\s*(not ok|ok)\s+\d+\s*-?\s*(.*)$")


def kunit_tap(lines) -> tuple[list[str], list[str]]:
    """KTAP result lines from a kunit run: (ok, not ok). Subtests are
    indented and may carry a dmesg timestamp; a case marked SKIP counts as
    neither."""
    ok, bad = [], []
    for line in lines:
        m = KTAP_RESULT.match(line)
        if not m:
            continue
        name = m.group(2).strip()
        if re.search(r"#\s*SKIP", name):
            continue
        (bad if m.group(1) == "not ok" else ok).append(name)
    return ok, bad


def module_verdict(kv: dict[str, list[str]]) -> tuple[str, str]:
    hard = kv.get("hard_mod", [])
    t0 = int(one(kv, "taint_before", "0") or 0)
    t1 = int(one(kv, "taint_after", "0") or 0)
    if hard:
        return (FAIL, f"{len(hard)} module(s) failed hard: "
                f"{'; '.join(hard[:5])}")
    if (t1 & TAINT_CRASH) != (t0 & TAINT_CRASH):
        return FAIL, f"taint went {t0} -> {t1} across the sweep"
    if not one(kv, "attempted"):
        return FAIL, "the sweep produced no counters"
    return PASS, ""


def fs_verdict(kv: dict[str, list[str]]) -> tuple[str, str]:
    status = one(kv, "status")
    reason = one(kv, "reason")
    if status == "pass":
        return PASS, ""
    if status == "skip":
        return SKIP, reason or "skipped"
    detail = reason or "no status reported"
    for key in ("kat_failed", "kat2_failed", "fsck_out", "fsck_csum",
                "mount_out", "mount_dmesg", "remount_out", "remount_dmesg"):
        detail += "".join(f" | {key}={v}" for v in kv.get(key, [])[:3])
    return FAIL, detail


def kat_verdict(rc: int, out: str) -> tuple[str, str, dict]:
    """The AF_ALG report: a mismatch names the algorithm, the implementation
    and the reference it disagreed with."""
    try:
        rec = json.loads(out[out.index("{"):out.rindex("}") + 1])
    except (ValueError, json.JSONDecodeError):
        return FAIL, f"unreadable report (exit {rc}): {out.strip()[-300:]}", {}
    bad = rec.get("mismatch", [])
    if bad:
        first = "; ".join(
            f"{m['alg']}/{m['driver']} != {m['reference']}"
            f" (want {m['want'][:24]} got {m['got'][:24]})" for m in bad[:4])
        return FAIL, f"{len(bad)} implementation(s) disagree: {first}", \
            {"mismatch": bad[:20], "checked_count": rec.get("checked_count")}
    summary = {"registered": rec.get("registered"),
               "checked_count": rec.get("checked_count"),
               "kat_seconds": rec.get("seconds"),
               "unusable": rec.get("unusable", [])[:20],
               "unreferenced": rec.get("unreferenced", [])[:40]}
    if not rec.get("checked_count"):
        return SKIP, "no implementation was reachable through AF_ALG", summary
    return PASS, "", summary


def sock_verdict(rc: int, out: str) -> tuple[str, str, dict]:
    """The socket-family probe's own per-family outcome. A family the
    configuration builds and the kernel cannot create, bind or drive fails
    the step and names the step and the errno; what the probe could not
    reach is carried as `uncovered` rather than counted as covered."""
    try:
        doc = json.loads(out[out.index("{"):out.rindex("}") + 1])
    except (ValueError, json.JSONDecodeError):
        return (FAIL, f"unreadable probe output (exit {rc}): "
                      f"{out.strip()[-200:]}", {})
    fams = doc.get("families", [])
    bad = [f"{f['name']} {f['detail']}" for f in fams if f["status"] == FAIL]
    data = {"families_checked": len(fams),
            "families_failed": len(bad),
            "families_skipped": [f"{f['name']}: {f['detail']}"
                                 for f in fams if f["status"] == SKIP],
            "uncovered": [f"{f['name']}: {u}"
                          for f in fams for u in f.get("uncovered", ())],
            "steps": {f["name"]: f["steps"] for f in fams}}
    if bad:
        return FAIL, "; ".join(bad[:5]), data
    if not fams:
        return SKIP, "the probe checked no family", data
    return PASS, "", data


# --- filesystem matrix ------------------------------------------------------

# One entry per filesystem instance. `config` is the kernel option the
# filesystem needs, so a kernel built without it skips rather than failing to
# mount; `mkfs` and `fsck` are guest command prefixes the device is appended
# to; `feats` gates the workload operations the filesystem supports; `lblk` is
# the loop device's logical block size, varied because the sector-size paths
# are distinct code. The btrfs entries differ only in the checksum algorithm:
# those route file data through the same kernel crypto implementations the
# crypto step tests directly.
FILESYSTEMS = (
    {"label": "ext4-4k", "type": "ext4", "config": "CONFIG_EXT4_FS",
     "lblk": 4096, "fsck": "e2fsck -fn",
     "mkfs": "mkfs.ext4 -q -F -O metadata_csum,metadata_csum_seed,64bit",
     "needs": ("mkfs.ext4", "e2fsck")},
    {"label": "ext4-512", "type": "ext4", "config": "CONFIG_EXT4_FS",
     "lblk": 512, "fsck": "e2fsck -fn",
     "mkfs": "mkfs.ext4 -q -F -O metadata_csum,64bit -b 1024",
     "needs": ("mkfs.ext4", "e2fsck")},
    {"label": "xfs", "type": "xfs", "config": "CONFIG_XFS_FS",
     "lblk": 4096, "fsck": "xfs_repair -n",
     "mkfs": "mkfs.xfs -q -f -m crc=1,finobt=1",
     "needs": ("mkfs.xfs", "xfs_repair")},
    {"label": "btrfs-crc32c", "type": "btrfs", "config": "CONFIG_BTRFS_FS",
     "lblk": 4096, "fsck": "btrfs check --readonly",
     "mkfs": "mkfs.btrfs -q -f --csum crc32c",
     "needs": ("mkfs.btrfs", "btrfs")},
    {"label": "btrfs-xxhash", "type": "btrfs", "config": "CONFIG_BTRFS_FS",
     "lblk": 512, "fsck": "btrfs check --readonly",
     "mkfs": "mkfs.btrfs -q -f --csum xxhash",
     "needs": ("mkfs.btrfs", "btrfs")},
    {"label": "btrfs-sha256", "type": "btrfs", "config": "CONFIG_BTRFS_FS",
     "lblk": 4096, "fsck": "btrfs check --readonly",
     "mkfs": "mkfs.btrfs -q -f --csum sha256",
     "needs": ("mkfs.btrfs", "btrfs")},
    {"label": "btrfs-blake2", "type": "btrfs", "config": "CONFIG_BTRFS_FS",
     "lblk": 512, "fsck": "btrfs check --readonly",
     "mkfs": "mkfs.btrfs -q -f --csum blake2",
     "needs": ("mkfs.btrfs", "btrfs")},
    {"label": "btrfs-zstd", "type": "btrfs", "config": "CONFIG_BTRFS_FS",
     "lblk": 4096, "fsck": "btrfs check --readonly",
     "mkfs": "mkfs.btrfs -q -f --csum sha256",
     "opts": "compress-force=zstd", "needs": ("mkfs.btrfs", "btrfs")},
    {"label": "f2fs", "type": "f2fs", "config": "CONFIG_F2FS_FS",
     "lblk": 4096, "fsck": "fsck.f2fs --dry-run",
     "mkfs": "mkfs.f2fs -q -f -O extra_attr,inode_checksum",
     "needs": ("mkfs.f2fs", "fsck.f2fs")},
    {"label": "vfat", "type": "vfat", "config": "CONFIG_VFAT_FS",
     "lblk": 512, "fsck": "fsck.vfat -n", "mkfs": "mkfs.vfat -F 32",
     "feats": "odirect", "needs": ("mkfs.vfat", "fsck.vfat")},
    {"label": "exfat", "type": "exfat", "config": "CONFIG_EXFAT_FS",
     "lblk": 512, "fsck": "fsck.exfat -n", "mkfs": "mkfs.exfat",
     "feats": "odirect", "needs": ("mkfs.exfat", "fsck.exfat")},
    {"label": "ntfs3", "type": "ntfs3", "config": "CONFIG_NTFS3_FS",
     "lblk": 512, "fsck": "ntfsfix -n", "mkfs": "mkfs.ntfs -Q -F",
     "needs": ("mkfs.ntfs", "ntfsfix")},
    {"label": "udf", "type": "udf", "config": "CONFIG_UDF_FS",
     "lblk": 512, "fsck": "", "mkfs": "mkudffs --media-type=hd",
     "feats": "links perms", "needs": ("mkudffs",)},
    {"label": "squashfs", "type": "squashfs", "config": "CONFIG_SQUASHFS",
     "ro": True, "needs": ("mksquashfs",),
     "mkfs": 'mksquashfs "$stage" "$IMG" -noappend -no-progress -quiet'},
    {"label": "erofs", "type": "erofs", "config": "CONFIG_EROFS_FS",
     "ro": True, "mkfs": 'mkfs.erofs "$IMG" "$stage"',
     "needs": ("mkfs.erofs",)},
    {"label": "iso9660", "type": "iso9660", "config": "CONFIG_ISO9660_FS",
     "ro": True, "mkfs": 'xorrisofs -quiet -o "$IMG" "$stage"',
     "needs": ("xorrisofs",)},
    {"label": "luks-aes-xts", "type": "ext4", "config": "CONFIG_DM_CRYPT",
     "lblk": 4096, "stack": "luks:aes-xts-plain64", "fsck": "e2fsck -fn",
     "mkfs": "mkfs.ext4 -q -F", "needs": ("cryptsetup", "mkfs.ext4")},
    {"label": "luks-aes-cbc", "type": "ext4", "config": "CONFIG_DM_CRYPT",
     "lblk": 512, "stack": "luks:aes-cbc-essiv:sha256", "fsck": "e2fsck -fn",
     "mkfs": "mkfs.ext4 -q -F", "needs": ("cryptsetup", "mkfs.ext4")},
    {"label": "md-raid1", "type": "ext4", "config": "CONFIG_MD_RAID1",
     "lblk": 4096, "stack": "raid1", "fsck": "e2fsck -fn",
     "mkfs": "mkfs.ext4 -q -F", "needs": ("mdadm", "mkfs.ext4")},
)


# --- guest session ----------------------------------------------------------

class Ctx:
    """State shared by the steps on the machine under test: the ssh handle,
    the tool probe cache, the running kernel's configuration and the dmesg
    follower. The handle is any target -- an emulated guest or a physical
    box -- so the stage runs unchanged on both."""

    def __init__(self, args, target, arch, release, log):
        self.args, self.target, self.arch = args, target, arch
        self.release, self.log = release, log
        self.have_cache: dict[str, bool] = {}
        self.config: dict[str, str] = {}
        self.spares: list[str] = []
        self.follower = self.decoded = False
        self.offset, self.since = 0, 0.0
        # The first kernel fault the stage provokes. After one, nothing the
        # kernel reports is attributable to the work that follows, and a
        # wedged subsystem turns later tasks into timeouts.
        self.faulted = ""

    def sh(self, cmd: str, timeout: int = 300):
        return self.target.ssh("sh -c " + shlex.quote(cmd), sudo=True,
                               timeout=timeout)

    def have(self, prog: str) -> bool:
        if prog not in self.have_cache:
            self.have_cache[prog] = self.sh(
                f"command -v {shlex.quote(prog)}", timeout=60).returncode == 0
        return self.have_cache[prog]

    def uptime(self) -> float:
        r = self.sh("cut -d' ' -f1 /proc/uptime", timeout=60)
        try:
            return float(r.stdout.strip())
        except ValueError:
            return 0.0

    def dmesg_text(self) -> str:
        src = f"cat {DMESG_LOG}" if self.follower else "dmesg"
        return self.sh(src, timeout=600).stdout

    def mark(self) -> None:
        """Remember where the kernel log stands, so the next read returns
        only what the task about to run produced."""
        if self.follower:
            r = self.sh(f"wc -c < {DMESG_LOG}", timeout=60)
            self.offset = int(r.stdout.strip() or 0)
        else:
            self.since = self.uptime()

    def dmesg_new(self) -> list[str]:
        if self.follower:
            return self.sh(f"tail -c +{self.offset + 1} {DMESG_LOG}",
                           timeout=600).stdout.splitlines()
        return dmesg_since(self.sh("dmesg", timeout=600).stdout, self.since)

    def start_follower(self) -> None:
        """A dmesg follower into a file: the sweep produces far more lines
        than the ring buffer holds, and a wrapped ring drops exactly the
        early fault the sweep is looking for."""
        for flags in ("-w -x", "-w"):
            self.sh(f"rm -f {DMESG_LOG}; : > {DMESG_LOG}; "
                    f"nohup setsid dmesg {flags} > {DMESG_LOG} 2>/dev/null "
                    f"< /dev/null & sleep 2", timeout=120)
            self.follower = self.sh(f"test -s {DMESG_LOG}",
                                    timeout=60).returncode == 0
            if self.follower:
                self.decoded = flags.endswith("-x")
                break
        if not self.follower:
            self.log("exercise: no dmesg follower; using ring-buffer reads")
        elif not self.decoded:
            # Without it a driver error nobody wrote a pattern for is a line
            # like any other.
            self.log("exercise: dmesg does not decode severity here; faults "
                     "are read by pattern only")


class Task:
    """One unit of guest work: a name, the shell run as root in the guest,
    and the rule that turns the outcome into a verdict."""

    def __init__(self, name: str, command: str, verdict=None, timeout: int = 0,
                 needs=(), env: dict | None = None, config=()):
        self.name, self.command, self.needs = name, command, tuple(needs)
        self.verdict = verdict or rc_zero
        self.timeout, self.env = timeout, env or {}
        # Kernel options the work needs; a kernel without one skips.
        self.config = (config,) if isinstance(config, str) else tuple(config)


class Outcome:
    def __init__(self, rc: int, out: str, dmesg: list[str], seconds: float):
        self.rc, self.out, self.dmesg, self.seconds = rc, out, dmesg, seconds
        self.kv = parse_kv(out)


def rc_zero(o: Outcome) -> tuple[str, str]:
    return (PASS, "") if o.rc == 0 else (
        FAIL, f"exit {o.rc}: {o.out.strip()[-300:]}")


def clean_dmesg(o: Outcome) -> tuple[str, str]:
    bad = dmesg_faults(o.dmesg)
    return (FAIL, " | ".join(bad[:3])) if bad else (PASS, "")


def alg_scan(o: Outcome) -> tuple[str, str]:
    """testmgr's own verdicts, wherever in the log they were printed."""
    bad = [l for l in o.out.splitlines() if ALG_FAIL.search(l)]
    return (FAIL, " | ".join(bad[:5])) if bad else (PASS, "")


def all_of(*rules):
    """Rules in order; the first non-pass decides. A rule may return a third
    element, data for the record, and every rule's data is kept."""
    def check(o: Outcome):
        data: dict = {}
        for rule in rules:
            v = rule(o)
            data.update(v[2] if len(v) > 2 else {})
            if v[0] != PASS:
                return v[0], v[1], data
        return PASS, "", data
    return check


def run_task(ctx: Ctx, task: Task) -> dict:
    if ctx.faulted:
        return {"name": task.name, "status": SKIP, "seconds": 0,
                "detail": f"not run: the kernel faulted earlier in the stage "
                          f"({ctx.faulted[:120]})"}
    off = [c for c in task.config if ctx.config.get(c) not in ("y", "m")]
    if off:
        return {"name": task.name, "status": SKIP, "seconds": 0,
                "detail": f"kernel built without {', '.join(off)}"}
    missing = [p for p in task.needs if not ctx.have(p)]
    if missing:
        return {"name": task.name, "status": SKIP, "seconds": 0,
                "detail": f"guest has no {', '.join(missing)}"}
    cap = task.timeout or ctx.args.exercise_timeout
    env = "".join(f"{k}={shlex.quote(str(v))} " for k, v in task.env.items())
    started = time.time()
    ctx.mark()
    r = ctx.sh(f"{env}timeout {cap} sh -c {shlex.quote(task.command)}",
               timeout=cap + 120)
    seconds = round(time.time() - started, 1)
    o = Outcome(r.returncode, r.stdout + r.stderr, ctx.dmesg_new(), seconds)
    v = task.verdict(o)
    rec = {"name": task.name, "status": v[0], "seconds": seconds,
           "rc": o.rc, "detail": v[1]}
    report = {k: (v2[0] if len(v2) == 1 else v2[:20])
              for k, v2 in o.kv.items()}
    report.update(v[2] if len(v) > 2 else {})
    if report:
        rec["report"] = report
    faults = dmesg_faults(o.dmesg)
    severe = [l for l in o.dmesg if DMESG_SEVERE.search(l)]
    if severe and not ctx.faulted:
        ctx.faulted = severe[0]
    if faults:
        rec["dmesg"] = faults[:20]
        # A fault the kernel logged is the finding; the step's own verdict
        # may have stopped at a symptom of it.
        if rec["status"] == FAIL:
            rec["detail"] = f"{rec['detail']} | dmesg: {faults[0][:200]}"
    ctx.log(f"exercise {task.name}: {rec['status']} in {seconds}s"
            + (f" -- {rec['detail'][:300]}" if rec["detail"] else ""))
    return rec


# --- steps ------------------------------------------------------------------

def step_crypto(ctx: Ctx) -> dict:
    """Load every crypto implementation, force the registration self-tests
    where the configuration keeps them, then check each implementation
    against a reference through AF_ALG."""
    rel = ctx.release
    load = (
        f"find /lib/modules/{rel}/kernel/crypto "
        f"/lib/modules/{rel}/kernel/arch/*/crypto "
        f"/lib/modules/{rel}/kernel/lib/crypto "
        r"-name '*.ko*' 2>/dev/null | sed 's|.*/||; s|\.ko.*$||; s|-|_|g' | "
        "sort -u > /dev/shm/badc-crypto-mods; "
        "while read -r m; do e=$(modprobe -- \"$m\" 2>&1) || "
        "echo \"refused=$m ${e##*: }\"; "
        "done < /dev/shm/badc-crypto-mods; "
        "for m in algif_hash algif_skcipher algif_aead tcrypt; do "
        "modprobe -q -- $m 2>/dev/null || true; done; "
        "echo attempted=$(wc -l < /dev/shm/badc-crypto-mods); "
        "echo registered=$(grep -c '^name' /proc/crypto)")
    tasks = [Task("crypto-load", load,
                  all_of(clean_dmesg, lambda o: (
                      PASS, "") if int(one(o.kv, "registered", "0") or 0) > 20
                      else (FAIL, "fewer than 20 algorithms registered")))]
    # A built-in algorithm is tested when it registers, which is during the
    # boot, so the scan covers the whole log rather than this task's window.
    tasks.append(Task(
        "crypto-selftest-scan",
        "dmesg | grep -aiE 'alg: |self-test' | tail -200; "
        "echo alg_lines=$(dmesg | grep -ac 'alg: ')", alg_scan))
    # tcrypt returns an error on completion by design, so its verdict comes
    # from dmesg. Modes 0..9 are the correctness batteries.
    if ctx.config.get("CONFIG_CRYPTO_SELFTESTS") == "y":
        tasks.append(Task(
            "crypto-tcrypt",
            "for m in 0 1 2 3 4 5 6 7 8 9; do timeout 240 modprobe -q tcrypt "
            "mode=$m >/dev/null 2>&1; rmmod tcrypt 2>/dev/null; done; "
            "echo swept=10",
            clean_dmesg))
    tasks.append(Task("crypto-kat", f"python3 {GUEST_DIR}/afalg_kat.py",
                      lambda o: kat_verdict(o.rc, o.out), needs=("python3",),
                      config="CONFIG_CRYPTO_USER_API_HASH"))
    recs = [run_task(ctx, t) for t in tasks]
    out = {"tasks": recs,
           "selftests_configured":
               ctx.config.get("CONFIG_CRYPTO_SELFTESTS") == "y"}
    if not out["selftests_configured"]:
        ctx.log("exercise crypto: CONFIG_CRYPTO_SELFTESTS is off in this "
                "kernel; the known-answer sweep is the correctness check")
    return out


def step_modules(ctx: Ctx) -> dict:
    """Load every built module once and classify each outcome."""
    task = Task("module-sweep", f"sh {GUEST_DIR}/modsweep.sh",
                all_of(lambda o: module_verdict(o.kv), clean_dmesg),
                env={"RELEASE": ctx.release,
                     "LIMIT": ctx.args.exercise_modules,
                     "PERMOD": 20, "SKIP_RE": MODULE_SKIP_RE})
    return {"tasks": [run_task(ctx, task)]}


def step_kunit(ctx: Ctx) -> dict:
    """Run the in-kernel test suites and read their TAP output."""
    if not ctx.config.get("CONFIG_KUNIT"):
        return {"tasks": [{"name": "kunit", "status": SKIP, "seconds": 0,
                           "detail": "CONFIG_KUNIT is not set here"}]}
    rel = ctx.release
    cmd = (f"find /lib/modules/{rel}/kernel -name '*kunit*.ko*' "
           r"| sed 's|.*/||; s|\.ko.*$||; s|-|_|g' | sort -u | "
           "while read -r m; do modprobe -q -- \"$m\" 2>/dev/null; done; "
           "cat /sys/kernel/debug/kunit/*/results 2>/dev/null; "
           # A built-in suite runs at boot, before the stage; its results are
           # in the log, not only in what this task produced.
           r"dmesg | grep -aE '(not ok|ok) [0-9]+ ' || true; "
           "echo suites=$(ls /sys/kernel/debug/kunit 2>/dev/null | wc -l)")

    def verdict(o: Outcome) -> tuple[str, str]:
        ok, bad = kunit_tap(o.out.splitlines() + o.dmesg)
        if bad:
            return (FAIL, f"{len(bad)} kunit case(s) not ok: "
                    f"{'; '.join(bad[:5])}")
        return (PASS, f"{len(ok)} cases ok") if ok else (
            SKIP, "no kunit suite produced TAP output")

    return {"tasks": [run_task(ctx, Task("kunit", cmd, verdict))]}


def fs_task(ctx: Ctx, spec: dict) -> Task:
    env = {"LABEL": spec["label"], "MTYPE": spec["type"],
           "MKFS": spec["mkfs"], "FSCK": spec.get("fsck", ""),
           "MOPTS": spec.get("opts", ""), "LBLK": spec.get("lblk", 512),
           "SECS": ctx.args.exercise_fs_seconds,
           "SIZE": ctx.args.exercise_fs_size,
           "FEATS": spec.get("feats", "links perms sparse odirect"),
           "STACK": spec.get("stack", ""),
           "RO": "1" if spec.get("ro") else "0",
           "MNT": f"/mnt/badc-{spec['label']}",
           "IMG": f"/var/tmp/badc-{spec['label']}.img"}
    # The spare disks put the traffic on the emulated storage controller
    # rather than on the loop device alone; raid1 needs two members.
    if spec.get("stack") == "raid1" and len(ctx.spares) >= 2:
        env["DEV"], env["RAID_EXTRA"] = ctx.spares[0], ctx.spares[1]
    return Task(f"fs-{spec['label']}", f"sh {GUEST_DIR}/fsexercise.sh",
                all_of(lambda o: fs_verdict(o.kv), clean_dmesg),
                env=env, needs=spec.get("needs", ()),
                config=("CONFIG_BLK_DEV_LOOP", spec["config"]),
                timeout=ctx.args.exercise_fs_seconds * 6 + 600)


def step_fs(ctx: Ctx) -> dict:
    """Build, stress, verify and check each filesystem in the matrix."""
    want = ctx.args.exercise_fs.split(",") if ctx.args.exercise_fs else []
    recs = []
    if unknown := set(want) - {f["label"] for f in FILESYSTEMS}:
        recs.append({"name": "fs-select", "status": FAIL, "seconds": 0,
                     "detail": "no such instance: "
                               f"{', '.join(sorted(unknown))}"})
    for spec in FILESYSTEMS:
        if want and spec["label"] not in want:
            continue
        recs.append(run_task(ctx, fs_task(ctx, spec)))
    return {"tasks": recs, "spares": ctx.spares}


def step_storage(ctx: Ctx) -> dict:
    """Round-trip the root device through its controller and read the kernel
    log window the I/O produced."""
    task = Task("storage-roundtrip", f"sh {GUEST_DIR}/storage.sh",
                all_of(lambda o: fs_verdict(o.kv), clean_dmesg),
                timeout=600,
                env={"MB": ctx.args.exercise_storage_mb, "DIR": "/var/tmp"})
    return {"tasks": [run_task(ctx, task)]}


def step_sockets(ctx: Ctx) -> dict:
    """Create, bind and drive every protocol family the configuration
    builds. The boot probes reach a family only through what the guest's own
    init happens to do, which makes the verdict depend on the image."""
    want = [f for f in SOCKET_FAMILIES
            if ctx.config.get(f["config"]) in ("y", "m")]
    if not want:
        return {"tasks": [{"name": "socket-families", "status": SKIP,
                           "seconds": 0,
                           "detail": "this kernel builds no probed family"}]}
    mods = sorted({m for f in want for m in f["modules"]})
    cmd = ("".join(f"modprobe -q -- {m} 2>/dev/null; " for m in mods)
           + f"python3 {GUEST_DIR}/sockfam.py")
    task = Task("socket-families", cmd,
                all_of(lambda o: sock_verdict(o.rc, o.out), clean_dmesg),
                needs=("python3",), timeout=300,
                env={"FAMILIES": ",".join(f["name"] for f in want)})
    return {"tasks": [run_task(ctx, task)],
            "families": [f["name"] for f in want]}


def step_dmesg(ctx: Ctx) -> dict:
    """One consolidated severity scan over everything the stage produced."""
    text = ctx.dmesg_text()
    lines = text.splitlines()
    # The follower holds the boot log as well as the stage's, and the boot
    # is what the packages probes judge against the stock baseline. Here the
    # vocabulary decides, so a distribution's own boot-time error lines do
    # not fail work that did not produce them.
    severe = [l for l in lines if DMESG_SEVERE.search(l)]
    alg = [l for l in lines if ALG_FAIL.search(l)]
    warn = [l for l in lines if DMESG_WARN.search(l)]
    taint = ctx.sh("cat /proc/sys/kernel/tainted", timeout=60).stdout.strip()
    detail = ""
    status = PASS
    if not lines or not taint:
        # A gate that read nothing has checked nothing.
        status, detail = FAIL, ("the kernel log or the taint word was not "
                                "readable at the end of the stage")
    elif severe or alg:
        status = FAIL
        detail = " | ".join((severe + alg)[:5])
    elif (int(taint or 0) & TAINT_CRASH) != 0:
        status, detail = FAIL, f"kernel tainted {taint} after the stage"
    rec = {"name": "dmesg-gate", "status": status, "seconds": 0,
           "detail": detail, "report": {"lines": len(lines),
                                        "severe": len(severe),
                                        "alg_failures": len(alg),
                                        "warnings": len(warn),
                                        "taint": taint}}
    if warn:
        rec["warnings"] = warn[:20]
    ctx.log(f"exercise dmesg-gate: {status} over {len(lines)} lines "
            f"(severe={len(severe)} alg={len(alg)} warn={len(warn)} "
            f"taint={taint})")
    return {"tasks": [rec], "taint": taint}


STEPS = {"sockets": step_sockets, "storage": step_storage,
         "crypto": step_crypto, "modules": step_modules, "kunit": step_kunit,
         "fs": step_fs, "dmesg": step_dmesg}

# The steps that run on every boot, not only under `--exercise`. Measured on
# the x86_64 box against a badc-built Fedora kernel: 20.1 s for the four
# together. The two left out are the stage's cost: `modules` is 130 ms per
# module over a tree of thousands, and `fs` is 420-590 s for the matrix plus
# the guest tool packages it installs.
GATE_STEPS = ("sockets", "storage", "crypto", "kunit", "dmesg")


# --- stage ------------------------------------------------------------------

def provision(ctx: Ctx) -> list[str]:
    """Install the filesystem and block-stack tools from the guest's own
    package mirror. A failure here only narrows the matrix."""
    if ctx.args.exercise_tools == "skip":
        return []
    pkgs = GUEST_TOOL_PACKAGES[ctx.arch["pkg"]]
    if ctx.arch["pkg"] == "deb":
        head = ("export DEBIAN_FRONTEND=noninteractive; apt-get -qq update; "
                "apt-get -qq -y --no-install-recommends install ")
    else:
        head = "dnf -q -y install "
    ctx.log(f"exercise: installing {len(pkgs)} tool packages in the guest")
    got = pkgs
    if ctx.sh(head + " ".join(pkgs),
              timeout=ctx.args.exercise_timeout).returncode != 0:
        # One name the archive does not carry fails the whole transaction;
        # retrying singly keeps the packages that do exist.
        got = [p for p in pkgs
               if ctx.sh(head + p, timeout=600).returncode == 0]
        ctx.log(f"exercise: {len(got)} of {len(pkgs)} tool packages installed")
    ctx.have_cache.clear()
    return got


def find_spares(ctx: Ctx) -> list[str]:
    """Whole disks of at least a gibibyte with no partitions and no
    filesystem signature: the spare drives the stage asked for, never the
    system disk, the seed, or the emulated floppy."""
    out = ctx.sh(
        "lsblk -dnpbo NAME,TYPE,SIZE | "
        "awk '$2==\"disk\" && $3+0 >= 1073741824 {print $1}' | "
        "while read -r d; do "
        "[ \"$(lsblk -nro NAME \"$d\" | wc -l)\" = 1 ] && "
        "[ -z \"$(blkid -p \"$d\" 2>/dev/null)\" ] && echo \"$d\"; "
        "done", timeout=120).stdout.split()
    return out


def selected_steps(args) -> str:
    """The steps this run drives. `--exercise` asks for the whole set;
    otherwise the gate set runs anyway, since the boot probes read the
    guest's mood rather than the kernel's subsystems."""
    if args.exercise:
        return args.exercise_steps
    return ",".join(GATE_STEPS) if args.exercise_gate else ""


def run(args, target, arch, release, failures: list[str], log,
        steps: str = "") -> dict:
    """Run the exercise stage in the booted badc kernel. Every step's verdict
    lands in the report; a failing step appends to `failures`."""
    ctx = Ctx(args, target, arch, release, log)
    names = [n for n in (steps or args.exercise_steps).split(",") if n]
    started = time.time()
    result: dict = {"steps": []}
    cfg = target.ssh(f"cat /boot/config-{release} 2>/dev/null || "
                     f"zcat /proc/config.gz 2>/dev/null", sudo=True,
                     timeout=120)
    ctx.config = config_options(cfg.stdout)
    result["config_seen"] = len(ctx.config)
    if not ctx.config:
        # Every step gates on it; without it the stage would skip in silence.
        failures.append("exercise: the running kernel's configuration is not "
                        "readable (/boot/config-<release>, /proc/config.gz)")
        return result
    ctx.start_follower()
    target.ssh(f"mkdir -p {GUEST_DIR}", check=True)
    target.scp(sorted((LINUX_DIR / "guest").glob("*")), GUEST_DIR + "/")
    # Guest tool packages, spare disks and the seed data exist for the
    # filesystem matrix; a run without it leaves the guest as it found it.
    if "fs" in names:
        result["tools_installed"] = provision(ctx)
        ctx.spares = find_spares(ctx)
        log(f"exercise: spare disks {ctx.spares or 'none'}")
        # 16 MiB of source data in tmpfs: every verified digest is taken from
        # it, never from the filesystem under test.
        ctx.sh("mkdir -p /dev/shm && dd if=/dev/urandom of=/dev/shm/badc-seed "
               "bs=1M count=16 2>/dev/null", timeout=300)

    for name in names:
        if name not in STEPS:
            failures.append(f"exercise: unknown step {name!r}")
            continue
        t0 = time.time()
        step = STEPS[name](ctx)
        step["name"] = name
        step["seconds"] = round(time.time() - t0, 1)
        step["status"] = worst(t["status"] for t in step["tasks"])
        result["steps"].append(step)
        for t in step["tasks"]:
            if t["status"] == FAIL:
                failures.append(f"exercise {name}/{t['name']}: {t['detail']}")
    result["seconds"] = round(time.time() - started, 1)
    log(f"exercise: {len(result['steps'])} steps in {result['seconds']}s")
    return result


def worst(statuses) -> str:
    ranked = list(statuses)
    for s in (FAIL, PASS, SKIP):
        if s in ranked:
            return s
    return SKIP


def add_arguments(ap) -> None:
    ap.add_argument("--exercise", action="store_true",
                    help="widen the exercise stage from the gate set to the "
                         "whole one: the module load sweep and the "
                         "filesystem and block-stack stress as well")
    ap.add_argument("--no-exercise-gate", dest="exercise_gate",
                    action="store_false",
                    help=f"skip the always-on part of the stage "
                         f"({','.join(GATE_STEPS)}); a boot that skips it has "
                         f"no cover on the subsystems the probes never reach")
    ap.add_argument("--exercise-steps", default=",".join(STEPS),
                    help=f"comma-separated subset of {','.join(STEPS)}")
    ap.add_argument("--exercise-timeout", type=int, default=1800,
                    help="seconds for one exercise task")
    ap.add_argument("--exercise-modules", type=int, default=0,
                    help="modules to load in the sweep, evenly strided over "
                         "the module tree (default: every built module)")
    ap.add_argument("--exercise-storage-mb", type=int, default=64,
                    help="payload size for the root-device round trip")
    ap.add_argument("--exercise-fs", default="",
                    help="comma-separated filesystem instance labels "
                         "(default: the whole matrix)")
    ap.add_argument("--exercise-fs-seconds", type=int, default=20,
                    help="workload seconds per filesystem instance")
    ap.add_argument("--exercise-fs-size", default="2G",
                    help="backing size per filesystem instance")
    ap.add_argument("--exercise-tools", choices=("auto", "skip"),
                    default="auto",
                    help="install the missing filesystem and block-stack "
                         "tools from the guest's own package mirror")
    ap.add_argument("--exercise-spares", type=int, default=2,
                    help="spare disks attached for the stage")


# --- self-test --------------------------------------------------------------

class _StepArgs:
    """The three fields `selected_steps` reads, for the self-test."""

    def __init__(self, exercise: bool, gate: bool):
        self.exercise, self.exercise_gate = exercise, gate
        self.exercise_steps = "fs"


def guest_sockfam():
    """The guest-side socket-family probe, loaded for its family table."""
    return _load_guest("sockfam.py")


def guest_kat():
    """The guest-side known-answer test, loaded for its parsers."""
    return _load_guest("afalg_kat.py")


def _load_guest(name: str):
    """A guest script loaded for its pure parts. They use the standard
    library only, so they import on a host with no AF_ALG; exec'd rather than
    imported so the check leaves no bytecode behind."""
    import types
    ns: dict = {"__name__": name.removesuffix(".py")}
    exec((LINUX_DIR / "guest" / name).read_text(), ns)
    return types.SimpleNamespace(**ns)


def self_test() -> None:
    text = ("[    0.100000] boot line\n"
            "[   12.500000] WARNING: at foo\n"
            "continued line\n"
            "[   99.000000] alg: self-test failed for sha256-avx2\n")
    assert dmesg_since(text, 12.0) == text.splitlines()[1:]
    assert dmesg_since(text, 500.0) == []
    assert dmesg_since("no stamps here\n", 5.0) == ["no stamps here"]
    faults = dmesg_faults(text.splitlines())
    assert len(faults) == 2, faults

    # Driver-reported faults: the sense keys a working device does not
    # produce fail, the ones empty removable media produce do not.
    for line in ("sd 0:0:0:0: [sda] Sense Key : Hardware Error [current]",
                 "sd 0:0:0:0: [sda] Add. Sense: Internal target failure",
                 "EXT4-fs error (device sda1): ext4_find_entry:1683",
                 "blk_update_request: I/O error, dev sda, sector 8",
                 "pcieport 0000:00:1c.0: AER: Corrected error received"):
        assert DMESG_SEVERE.search(line), line
    for line in ("sr 1:0:0:0: [sr0] Sense Key : Not Ready [current]",
                 "sd 0:0:0:0: [sda] Unit Not Ready",
                 "megaraid_sas 0000:00:03.0: Init cmd success"):
        assert not DMESG_SEVERE.search(line), line

    assert normalize_log("[   12.500000] sd 0:0:0:0: [sda] failed\n\n") == [
        "sd #:#:#:#: [sda] failed"]
    assert normalize_log("<3>[    1.0] at 0xdeadbeef") == ["at #"]
    assert normalize_log("plain line") == ["plain line"]

    kv = parse_kv("status=fail\nreason=digest-mismatch\nhard_mod=a rc=1\n"
                  "hard_mod=b rc=2\nnot a pair\n")
    assert kv["hard_mod"] == ["a rc=1", "b rc=2"]
    assert one(kv, "status") == "fail"
    assert one(kv, "absent", "d") == "d"

    assert config_options("CONFIG_A=y\n# CONFIG_B is not set\nCONFIG_C=\"x\"\n"
                          ) == {"CONFIG_A": "y", "CONFIG_C": '"x"'}

    ok, bad = kunit_tap(["[    1.000000]     ok 1 - case_a",
                         "[    1.000000] not ok 2 - case_b",
                         "    ok 3 - case_c # SKIP no hardware",
                         "ok 4 - case_d",
                         "    # Subtest: example"])
    assert ok == ["case_a", "case_d"] and bad == ["case_b"], (ok, bad)

    assert module_verdict(parse_kv("attempted=10\nloaded=9\ntaint_before=0\n"
                                   "taint_after=512\n"))[0] == PASS
    assert module_verdict(parse_kv("attempted=10\ntaint_before=0\n"
                                   "taint_after=128\n"))[0] == FAIL
    # The per-module findings and the summary counters must not share a key.
    assert module_verdict(parse_kv("hard_mod=zz rc=1\nattempted=1\n"
                                   "hard=1\n"))[0] == FAIL
    assert module_verdict(parse_kv("attempted=9\nloaded=9\nhard=0\n"
                                   "taint_before=0\ntaint_after=0\n"
                                   ))[0] == PASS
    assert module_verdict(parse_kv("loaded=0\n"))[0] == FAIL

    assert fs_verdict(parse_kv("status=pass\n"))[0] == PASS
    assert fs_verdict(parse_kv("status=skip\nreason=mkfs\n")) == (SKIP, "mkfs")
    st, detail = fs_verdict(parse_kv(
        "status=fail\nreason=digest-mismatch\nkat_failed=/mnt/x: FAILED\n"))
    assert st == FAIL and "kat_failed" in detail, detail
    st, detail = fs_verdict(parse_kv(
        "status=fail\nreason=mount\nmount_dmesg=[ 1.0] BUG: at xfs_mountfs\n"))
    assert st == FAIL and "xfs_mountfs" in detail, detail

    st, detail, rec = kat_verdict(0, '{"checked_count": 3, "mismatch": []}')
    assert st == PASS and rec["checked_count"] == 3
    st, detail, _ = kat_verdict(1, json.dumps(
        {"checked_count": 2,
         "mismatch": [{"alg": "sha256", "driver": "sha256-avx2",
                       "reference": "hashlib", "want": "aa", "got": "bb"}]}))
    assert st == FAIL and "sha256-avx2" in detail, detail
    assert kat_verdict(2, "nonsense")[0] == FAIL
    assert kat_verdict(0, '{"checked_count": 0, "mismatch": []}')[0] == SKIP

    ok = ('{"families": [{"name": "AF_VSOCK", "status": "pass", "detail": "",'
          ' "steps": {"create": 0, "bind": 0}, "uncovered": ["no peer"]}]}')
    st, detail, data = sock_verdict(0, ok)
    assert st == PASS and data["families_checked"] == 1, (st, data)
    assert data["uncovered"] == ["AF_VSOCK: no peer"], data
    bad = ok.replace('"pass", "detail": ""', '"fail", "detail": "bind: EINVAL"')
    st, detail, data = sock_verdict(1, bad)
    assert st == FAIL and "bind: EINVAL" in detail, (st, detail)
    assert data["families_failed"] == 1, data
    skipped = ok.replace('"pass", "detail": ""',
                         '"skip", "detail": "needs root"')
    assert sock_verdict(0, skipped)[0] == PASS
    assert sock_verdict(2, 'FAMILIES is empty')[0] == FAIL
    assert sock_verdict(0, '{"families": []}')[0] == SKIP

    names = [f["name"] for f in SOCKET_FAMILIES]
    assert len(names) == len(set(names)), "duplicate family"
    probes = guest_sockfam().PROBES
    for f in SOCKET_FAMILIES:
        assert f["config"].startswith("CONFIG_"), f["name"]
        assert f["name"] in probes, f["name"]

    assert set(GATE_STEPS) <= set(STEPS), GATE_STEPS
    assert selected_steps(_StepArgs(False, True)) == ",".join(GATE_STEPS)
    assert selected_steps(_StepArgs(False, False)) == ""
    assert selected_steps(_StepArgs(True, True)) == "fs"
    assert selected_steps(_StepArgs(True, False)) == "fs"

    assert worst([PASS, SKIP, FAIL]) == FAIL
    assert worst([SKIP, PASS]) == PASS
    assert worst([SKIP]) == SKIP

    labels = [f["label"] for f in FILESYSTEMS]
    assert len(labels) == len(set(labels)), "duplicate filesystem label"
    for f in FILESYSTEMS:
        assert f.get("ro") or f["mkfs"].split()[0] in f["needs"], f["label"]
        assert f["config"].startswith("CONFIG_"), f["label"]

    o = Outcome(0, "status=pass\n", [], 1.0)
    assert all_of(rc_zero, clean_dmesg)(o) == (PASS, "", {})
    assert all_of(rc_zero)(Outcome(3, "boom", [], 1.0))[0] == FAIL
    assert clean_dmesg(Outcome(0, "", ["BUG: bad"], 1.0))[0] == FAIL
    assert alg_scan(Outcome(0, "alg: No test for foo (bar)\n", [], 1.0))[0] \
        == PASS
    assert alg_scan(Outcome(
        0, "alg: shash: sha256-avx2 test failed\n", [], 1.0))[0] == FAIL
    # A rule's third element reaches the record even when a later rule fails.
    keeps = all_of(lambda _o: (PASS, "", {"n": 1}), clean_dmesg)(
        Outcome(0, "", ["WARNING: here"], 1.0))
    assert keeps[0] == FAIL and keeps[2] == {"n": 1}, keeps

    import hashlib
    import hmac
    kat = guest_kat()
    entries = kat.parse_proc_crypto(
        "name         : sha256\ndriver       : sha256-avx2\n"
        "priority     : 170\ntype         : shash\ndigestsize   : 32\n\n"
        "name         : sha256\ndriver       : sha256-generic\n"
        "priority     : 100\ntype         : shash\ndigestsize   : 32\n\n"
        "name         : xts(aes)\ndriver       : __xts-aes-aesni\n"
        "type         : skcipher\n")
    assert len(entries) == 3, entries
    groups = kat.group_by_name(entries, ("shash",))
    assert list(groups) == ["sha256"] and len(groups["sha256"]) == 2
    assert kat.reference_driver(groups["sha256"])["driver"] == "sha256-generic"
    # The internal implementations userspace cannot allocate stay out.
    assert not kat.group_by_name(entries, ("skcipher",))
    assert kat.hashlib_ref("sha256")(b"") == hashlib.sha256(b"").digest()
    assert kat.hashlib_ref("blake2s-256")(b"abc") == hashlib.blake2s(
        b"abc", digest_size=32).digest()
    assert kat.hashlib_ref("sm3") is None
    assert kat.hmac_ref("hmac(sha256)", b"k")(b"m") == hmac.new(
        b"k", b"m", hashlib.sha256).digest()
    assert kat.hmac_ref("cmac(aes)", b"k") is None
    assert len(kat.stream(37)) == 37 and kat.stream(8) == kat.stream(8)


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        self_test()
        print("linux exercise: self-test ok", flush=True)
        raise SystemExit(0)
    raise SystemExit("usage: exercise.py --self-test")
