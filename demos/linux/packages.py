#!/usr/bin/env python3
"""Distro-package gate for the badc-compiled Linux kernel.

Builds the pinned kernel with badc compiling every kernel C unit (buildcc.py,
same contract as verify.py: zero fallbacks), packages the result with the
kernel's own packaging targets (bindeb-pkg on x86_64, binrpm-pkg on aarch64),
installs the package in a stock distribution cloud image under qemu, and
validates the rebooted system: the package scriptlets (depmod, initramfs
generation, boot-loader entry) and the running kernel (systemd reaches
multi-user, udev-bound devices, on-demand module loads, dmesg, disk and
network I/O). A stock-kernel baseline is captured from the same image before
the install, so every measurement has a reference. `--exercise` adds a stage
after those probes that drives what the boot does not reach -- the crypto
implementations, every built module, the kunit suites, and the filesystem and
block stack under a verified stress load (exercise.py).

    python3 demos/linux/packages.py --arch x86_64 \
        --tarball <linux-7.1.6.tar.xz> --config <corpus .config> \
        --report packages-x86_64.json

Phases (--phases selects a subset; each is idempotent): config, tree, build,
package, vm, and the optional selfhost. The build runs in
<workdir>/linux-<version>; packages land in
<workdir> (deb) or the tree's rpmbuild/RPMS (rpm). On a host without the Debian
packaging tools (an rpm distribution), --deb-tools names a prefix that is
provisioned from the host's own package mirror via `dnf download` + rpm2cpio
extraction; nothing is installed system-wide.

The same script is the local survey tool. `--config from-vm` takes the
distribution's own /boot/config-$(uname -r) out of the stock image instead of
building defconfig; `--tarball-url` with a required `--tarball-sha256` fetches
the kernel rather than taking a local path; `--pkg deb,rpm` produces both
formats; and `--keep-going` runs the build under `make -k`, so the manifest
ranks every unit badc rejects instead of stopping at the first. A configuration
from another kernel version is carried forward with `make olddefconfig` and
what moved is recorded in <workdir>/config-deviations-<arch>.txt.

The selfhost phase runs inside the vm phase, once the guest is on the badc
kernel: it stages a build environment, pushes badc and the shims, and builds
the kernel again with badc inside the VM. The build is the load and the kernel
is what is measured -- the kernel log window around it, taint, OOM records,
core dumps, and the unit outcomes against the host build's. It is off by
default; `--selfhost-scope` sizes it.

`--self-test` checks the pure helpers and takes no tree, host or guest.

Concurrent runs on one host are supported: the ssh forward takes a free port
per run and the workdir is held under an exclusive lock, so a second run
against the same workdir fails immediately instead of corrupting the first.
"""

from __future__ import annotations

import argparse
import fcntl
import hashlib
import json
import os
import platform
import re
import shlex
import shutil
import socket
import subprocess
import sys
import tarfile
import time
import urllib.parse
import urllib.request
from pathlib import Path

import diags
import exercise

LINUX_DIR = Path(__file__).resolve().parent
REPO_ROOT = LINUX_DIR.parents[1]

sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

# Cloud images are mirrored on this release rather than pulled from the
# distributions: Debian keeps only the last few dated cloud snapshots, so an
# upstream URL pinned to a snapshot stops resolving within weeks. `upstream`
# and `upstream_digest` record where each asset came from and the digest the
# distribution publishes for it, so the mirrored bytes stay auditable. An
# image the release does not carry yet is fetched from `upstream` and held to
# the same pinned sha256, so a run never depends on the mirror being complete.
IMAGE_RELEASE_TAG = "vendor-deps-v1"

# The packaging format and the cloud image are the distribution's, not the
# architecture's. `DISTROS[d]["images"][a]` is the image distribution `d`
# publishes for architecture `a`; an architecture the distribution has no
# image for is simply absent.
DISTROS = {
    "debian": {
        "pkg": "deb",
        "images": {
            "x86_64": {
                "asset": "debian-13-genericcloud-amd64-20260803-2559.qcow2",
                "sha256": "d4c515da9031f6e79851de7ddbf50ec9320427f91a7ae99bd0c910d3676be9e1",
                "upstream": "https://cloud.debian.org/images/cloud/trixie/"
                            "20260803-2559/"
                            "debian-13-genericcloud-amd64-20260803-2559.qcow2",
                "upstream_digest":
                    "sha512:769562604ecaac26b661167891ef922f71f4d87d50a11423fc0"
                    "4e51444fda0d882c87996dd1181170d233627f4728e6722db2695c0ef7"
                    "53dad762c4ac4ed32e1",
            },
            "aarch64": {
                "asset": "debian-13-genericcloud-arm64-20260803-2559.qcow2",
                "sha256": "37f7b60e4128c33f5b4a94e30b9c4034e0aa2c567550b4d5cca2cf0437e9588f",
                "upstream": "https://cloud.debian.org/images/cloud/trixie/"
                            "20260803-2559/"
                            "debian-13-genericcloud-arm64-20260803-2559.qcow2",
                "upstream_digest":
                    "sha512:fa3c6a469deb88835871c04fa4ac5865de7947806c09bb49045"
                    "f4427ddf8e7a8763ba018526f380958784f6bcdc2786cc55fe58775fe1"
                    "b066f8ae7f3d9f9de6f",
            },
        },
    },
    "ubuntu": {
        "pkg": "deb",
        "images": {
            "x86_64": {
                "asset": "ubuntu-26.04-server-cloudimg-amd64.img",
                "sha256": "8196be9d7958059cb56c6c75c80fdf6cee8a8885bc149ea791d7db1c7ef93035",
                "upstream": "https://cloud-images.ubuntu.com/releases/26.04/"
                            "release-20260823/"
                            "ubuntu-26.04-server-cloudimg-amd64.img",
                "upstream_digest":
                    "sha256:8196be9d7958059cb56c6c75c80fdf6cee8a8885bc149ea79"
                    "1d7db1c7ef93035",
            },
            "aarch64": {
                "asset": "ubuntu-26.04-server-cloudimg-arm64.img",
                "sha256": "00e2d9f09373125eb9040952ae3b8d5553fe3df8f5004c08838473a1f61b74bf",
                "upstream": "https://cloud-images.ubuntu.com/releases/26.04/"
                            "release-20260823/"
                            "ubuntu-26.04-server-cloudimg-arm64.img",
                "upstream_digest":
                    "sha256:00e2d9f09373125eb9040952ae3b8d5553fe3df8f5004c088"
                    "38473a1f61b74bf",
            },
        },
    },
    "fedora": {
        "pkg": "rpm",
        "images": {
            "x86_64": {
                "asset": "Fedora-Cloud-Base-Generic-44-1.7.x86_64.qcow2",
                "sha256": "28680fe5b371a5a82ebf43a31926e086a168e59949d03969c5093e7071f90b7f",
                "upstream": "https://dl.fedoraproject.org/pub/fedora/linux/"
                            "releases/44/Cloud/x86_64/images/"
                            "Fedora-Cloud-Base-Generic-44-1.7.x86_64.qcow2",
                "upstream_digest":
                    "sha256:28680fe5b371a5a82ebf43a31926e086a168e59949d03969c"
                    "5093e7071f90b7f",
            },
            "aarch64": {
                "asset": "Fedora-Cloud-Base-Generic-44-1.7.aarch64.qcow2",
                "sha256": "55c60a3b80d3616a08705afd0459e75fe9f03c54aba7a46e4002a41a72fa0d5b",
                "upstream": "https://dl.fedoraproject.org/pub/fedora/linux/"
                            "releases/44/Cloud/aarch64/images/"
                            "Fedora-Cloud-Base-Generic-44-1.7.aarch64.qcow2",
                "upstream_digest":
                    "sha256:55c60a3b80d3616a08705afd0459e75fe9f03c54aba7a46e400"
                    "2a41a72fa0d5b",
            },
        },
    },
}

ARCHES = {
    "x86_64": {
        "target": "linux-x64",
        "make_target": "bzImage",
        "qemu": "qemu-system-x86_64",
        "distro": "debian",
        # The corpus defconfig builds these as modules; sit pulls ip_tunnel
        # and tunnel4, so the load also exercises depmod dependency data.
        "modprobe": ["sit", "xt_mark", "nf_log_syslog"],
        # Floors just under the measured defconfig unit counts (2953 and
        # 10489 at the 7.1.6 pin); make skips current objects, so a build
        # that compiled nothing must not pass.
        "expect_units": 2900,
    },
    "aarch64": {
        "target": "linux-aarch64",
        "make_target": "Image",
        "qemu": "qemu-system-aarch64",
        "distro": "fedora",
        "modprobe": ["fuse", "btrfs"],
        "expect_units": 10000,
    },
}


def resolve_arch(name: str, distro: str | None) -> dict:
    """The architecture's settings with the distribution's folded in, so
    every consumer keeps reading `arch["pkg"]` / `arch["image"]` /
    `arch["distro"]`. Without `--distro` the result is the architecture's
    own default distribution."""
    arch = dict(ARCHES[name])
    if distro:
        arch["distro"] = distro
    images = DISTROS[arch["distro"]]["images"]
    if name not in images:
        die(f"{arch['distro']} publishes no {name} cloud image "
            f"(have: {', '.join(sorted(images))})")
    arch["pkg"] = DISTROS[arch["distro"]]["pkg"]
    arch["image"] = images[name]
    return arch

# Storage controllers the guest disks ride on, with the kernel driver the
# booted system must then show on the root disk's device chain. `virtio` is
# the paravirtual block device; the rest are emulated controllers -- NVMe,
# an ICH9 AHCI SATA controller, a MegaRAID SAS and an LSI 53C895A SCSI HBA --
# whose drivers the badc-built kernel has to bring up itself.
DISK_BUSES = {
    "virtio": "virtio_blk",
    "nvme": "nvme",
    "ahci": "ahci",
    "megasas": "megaraid_sas",
    "lsi53c895a": "sym53c8xx",
}

# NIC models and the driver the booted system must bind them to.
NICS = {
    "virtio-net-pci": "virtio_net",
    "e1000e": "e1000e",
    "e1000": "e1000",
    "rtl8139": "8139cp",
    "igb": "igb",
}

# aarch64 EFI firmware, first match wins: (code, vars) pflash pair, or a
# single -bios image.
AARCH64_FIRMWARE = [
    ("/usr/share/AAVMF/AAVMF_CODE.fd", "/usr/share/AAVMF/AAVMF_VARS.fd"),
    ("/usr/share/edk2/aarch64/QEMU_EFI.fd", None),
    ("/opt/homebrew/share/qemu/edk2-aarch64-code.fd",
     "/opt/homebrew/share/qemu/edk2-arm-vars.fd"),
]

DEB_TOOL_RPMS = ["dpkg", "dpkg-dev", "dpkg-perl", "debhelper", "libmd"]

# The dmesg severity vocabulary is the exercise stage's: both the boot
# probes and the stage judge a kernel log by the same patterns.
DMESG_SEVERE = exercise.DMESG_SEVERE
DMESG_WARN = exercise.DMESG_WARN

# badc's one-line identification: `badc <version> (gcc-compatible, GNU C
# <v>)`. It is both the `--version` first line the kernel records as
# CONFIG_CC_VERSION_TEXT and the `.comment` producer string in every
# object badc writes.
BADC_ID = re.compile(r"badc \S+ \(gcc-compatible, GNU C [^)]+\)")


def names_badc(text: str) -> bool:
    return bool(BADC_ID.search(text or ""))


def log(m: str) -> None:
    print(f"linux packages: {m}", flush=True)


def die(m: str) -> None:
    print(f"linux packages: FAIL: {m}", flush=True)
    sys.exit(1)


def tail(path: Path, lines: int = 60) -> str:
    # A build log written on a runner is gone with the runner, so a failure
    # reproduces from the run output alone.
    try:
        text = path.read_text(errors="replace").splitlines()
    except OSError as e:
        return f"\n  (cannot read {path}: {e})"
    if not text:
        return f"\n  ({path} is empty)"
    head = f"\n--- last {min(lines, len(text))} lines of {path} ---\n"
    return head + "\n".join(text[-lines:])


def host_arch() -> str:
    m = platform.machine().lower()
    return {"arm64": "aarch64", "amd64": "x86_64"}.get(m, m)


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def run(cmd, cwd=None, env=None, timeout=None, capture=True, check=False):
    # The executable is looked up on the PATH `env` carries, not the
    # caller's: a macOS host puts GNU make ahead of the BSD one there.
    if env is not None and cmd and "/" not in str(cmd[0]):
        cmd = [shutil.which(str(cmd[0]), path=env.get("PATH")) or cmd[0], *cmd[1:]]
    # A timeout is reported as an exit status, not an exception: every caller
    # already handles a non-zero status, and an escaping TimeoutExpired would
    # end the run without writing the report.
    try:
        r = subprocess.run(cmd, cwd=cwd, env=env, timeout=timeout, text=True,
                           stdin=subprocess.DEVNULL,
                           capture_output=capture)
    except subprocess.TimeoutExpired as e:
        def text_of(b) -> str:
            return b.decode(errors="replace") if isinstance(b, bytes) else b or ""
        r = subprocess.CompletedProcess(
            cmd, 124, text_of(e.stdout),
            text_of(e.stderr) + f"\ntimed out after {timeout}s")
    if check and r.returncode != 0:
        tail = (r.stderr or r.stdout or "").strip().splitlines()[-8:]
        die(f"{' '.join(map(str, cmd))} exited {r.returncode}\n" +
            "\n".join(tail))
    return r


# --- config -----------------------------------------------------------------

# Options whose value names a file in the originating packaging tree. A
# configuration lifted out of a distribution kernel carries the paths that
# distribution's build used; none of them exist here, and the artifacts they
# name (an embedded initramfs, signing and trust keyrings) are ones this build
# produces itself or does not need. Cleared before olddefconfig, so every
# clearing appears in the recorded deviations.
FOREIGN_FILE_OPTIONS = (
    "CONFIG_INITRAMFS_SOURCE",
    "CONFIG_SYSTEM_TRUSTED_KEYS",
    "CONFIG_SYSTEM_REVOCATION_KEYS",
    "CONFIG_MODULE_SIG_KEY",
)

CONFIG_FROM_VM = "from-vm"


def fetch_tarball(url: str, want_sha: str, cache: Path) -> Path:
    """Download a kernel tarball and verify the caller's sha256.

    The digest is required rather than optional: a survey has to be
    reproducible, and a truncated or substituted download must not be able to
    present itself as a compiler defect.
    """
    cache.mkdir(parents=True, exist_ok=True)
    dst = cache / Path(urllib.parse.urlparse(url).path).name
    if dst.is_file() and sha256_of(dst) == want_sha:
        log(f"cached: {dst.name}")
        return dst
    log(f"fetching {url}")
    tmp = dst.with_suffix(dst.suffix + ".part")
    with urllib.request.urlopen(url) as r, open(tmp, "wb") as f:
        shutil.copyfileobj(r, f, 1 << 20)
    got = sha256_of(tmp)
    if got != want_sha:
        tmp.unlink()
        die(f"sha256 mismatch for {dst.name}: got {got}, want {want_sha}")
    tmp.rename(dst)
    return dst


def clear_foreign_files(text: str) -> str:
    for opt in FOREIGN_FILE_OPTIONS:
        text = re.sub(rf'(?m)^{opt}=.*$', f'{opt}=""', text)
    # The signing key is not a foreign file: the kernel generates it at
    # its default path during the build. An empty value makes every
    # sign-file call read its key from `./` and modules_install fails;
    # the default keeps CONFIG_MODULE_SIG=y kernels packageable.
    return re.sub(r'(?m)^CONFIG_MODULE_SIG_KEY=""$',
                  'CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"', text)


def phase_config(args, arch) -> Path:
    """Take the distribution's own kernel configuration out of its image.

    A distribution ships the configuration its kernel was built with as
    /boot/config-$(uname -r). Reading it from the booted stock image is the
    one source that cannot drift from the kernel the distribution actually
    runs, and it is the same pinned image the gate validates against, so the
    configuration and the system under test agree by construction.
    """
    dest = args.workdir / f"config-vm-{args.arch}.config"
    meta_path = args.workdir / f"config-vm-{args.arch}.json"
    if dest.is_file() and meta_path.is_file():
        meta = json.loads(meta_path.read_text())
        log(f"config already extracted from {meta['source_release']}: {dest}")
        return dest
    image = ensure_image(args, arch)
    accel = resolve_accel(args, arch)
    seed = make_seed(args)
    # A throwaway overlay: extraction must not disturb the disk the gate
    # installs into, and nothing here is carried forward.
    disk = args.workdir / f"disk-config-{args.arch}.qcow2"
    disk.unlink(missing_ok=True)
    run(["qemu-img", "create", "-q", "-f", "qcow2", "-b", str(image.resolve()),
         "-F", "qcow2", str(disk), args.vm_disk], check=True)
    vm = VM(args, arch, disk, seed, accel)
    vm.console = args.workdir / f"console-config-{args.arch}.log"
    vm.pidfile = args.workdir / f"vm-config-{args.arch}.pid"
    vm.start()
    try:
        vm.wait_ssh(args.vm_timeout)
        release = vm.ssh("uname -r", check=True).stdout.strip()
        os_id = vm.ssh('. /etc/os-release && echo "$ID $VERSION_ID"',
                       check=True).stdout.strip()
        remote = f"/boot/config-{release}"
        if not vm.pull(remote, dest):
            die(f"{remote} is not readable in the {arch['distro']} image; "
                f"the distribution kernel package ships it")
        meta = {"source_release": release, "source_os": os_id,
                "source_path": remote, "image": image.name,
                "sha256": sha256_of(dest), "bytes": dest.stat().st_size,
                "set_options": sum(1 for ln in dest.read_text().splitlines()
                                   if re.match(r"CONFIG_\w+=", ln))}
        meta_path.write_text(json.dumps(meta, indent=2) + "\n")
        log(f"config from {os_id} kernel {release}: {meta['set_options']} "
            f"options set ({dest})")
    finally:
        vm.stop()
        disk.unlink(missing_ok=True)
    return dest


# --- tree -------------------------------------------------------------------

def phase_tree(args, arch, config: Path | None) -> Path:
    m = re.fullmatch(r"linux-(.+?)\.tar\.\w+", args.tarball.name)
    if not m:
        die(f"cannot derive the kernel version from {args.tarball.name!r}")
    tree = args.workdir / f"linux-{m.group(1)}"
    if not (tree / "Makefile").is_file():
        log(f"extracting {args.tarball}")
        with tarfile.open(args.tarball) as tf:
            base = args.workdir.resolve()
            for m in tf.getmembers():
                p = (base / m.name).resolve()
                if base not in p.parents and p != base:
                    die(f"unsafe path in tarball: {m.name!r}")
            tf.extractall(base)
    if config:
        text = config.read_text()
    else:
        log("make defconfig")
        run(["make", "defconfig"], cwd=tree, env=shim_env(args, arch),
            check=True)
        text = (tree / ".config").read_text()
    text = clear_foreign_files(text)
    (tree / ".config").write_text(text)
    (tree / ".config.orig").write_text(text)
    log("make olddefconfig")
    run(["make", *toolchain_args(args), "olddefconfig"], cwd=tree,
        env=shim_env(args, arch), check=True)
    # A configuration from another kernel version is carried forward by
    # olddefconfig answering the symbols the version difference added or
    # removed. What it changed is the deviation list.
    dev = run(["./scripts/diffconfig", ".config.orig", ".config"], cwd=tree)
    out = args.workdir / f"config-deviations-{args.arch}.txt"
    out.write_text(dev.stdout)
    n = len([ln for ln in dev.stdout.splitlines() if ln.strip()])
    log(f"config ready ({n} olddefconfig deviations recorded in {out})")
    return tree


# --- build ------------------------------------------------------------------

# What a macOS host has to supply for kbuild, per `demos/linux/README.md`
# ("Building on macOS"): Homebrew's GNU tools ahead of the BSD ones, the
# cross binutils for every tool but CC and LD, the SDK gaps `hostcompat/`
# covers, Homebrew's libcrypto for the signing host tools, and no depmod.
KBUILD_ARCH = {"x86_64": "x86", "aarch64": "arm64"}


def darwin_kbuild_env(args, arch, env: dict) -> None:
    brew = Path(shutil.which("brew") or "/opt/homebrew/bin/brew").resolve().parents[1]
    gnubin = [brew / "opt" / t / "libexec/gnubin"
              for t in ("make", "coreutils", "findutils", "gnu-sed", "grep",
                        "gawk", "gnu-tar")]
    env["PATH"] = ":".join([*(str(d) for d in gnubin if d.is_dir()),
                            env.get("PATH", ""), str(brew / "opt/binutils/bin")])
    env["ARCH"] = KBUILD_ARCH[args.arch]
    env["CROSS_COMPILE"] = args.real_cc[:-len("gcc")] if args.real_cc.endswith(
        "-gcc") else env.get("CROSS_COMPILE", "")
    hc = LINUX_DIR / "hostcompat"
    env["HOSTCFLAGS"] = f"-I{hc} -include {hc}/hostcompat.h -D_UUID_T"
    ssl = brew / "opt/openssl/lib/pkgconfig"
    if ssl.is_dir():
        env["PKG_CONFIG_PATH"] = ":".join(
            [str(ssl), *filter(None, [env.get("PKG_CONFIG_PATH")])])
    env["DEPMOD"] = "true"


def shim_env(args, arch) -> dict:
    env = dict(os.environ)
    if platform.system() == "Darwin":
        darwin_kbuild_env(args, arch, env)
    env.update(
        BADC=str(args.badc),
        BADC_REAL_CC=args.real_cc,
        BADC_TARGET=arch["target"],
        BADC_MANIFEST=str(args.manifest),
        BADC_WARN_LOG=str(args.warn_log),
        BADC_TIMEOUT=str(args.unit_timeout),
        BADC_LD_REAL=args.real_ld,
        BADC_LD_MANIFEST=str(args.ld_manifest),
    )
    # The gate's contract is zero fallbacks, so an inherited list is dropped;
    # --fallback states one explicitly and it lands in the manifest, where a
    # build that used it cannot be mistaken for a pure one.
    env.pop("BADC_FALLBACK", None)
    env.pop("BADC_LD_FALLBACK", None)
    if args.fallback:
        env["BADC_FALLBACK"] = str(args.fallback)
    if args.ld_fallback:
        env["BADC_LD_FALLBACK"] = str(args.ld_fallback)
    # Keyed off the packaging format being built, not the architecture: a
    # survey can ask for a deb on either arch, and --deb-tools is only set
    # when a deb is wanted and the host lacks the tools.
    if args.deb_tools:
        deb_tool_env(args.deb_tools, env)
    return env


def toolchain_args(args) -> list[str]:
    """`CC=`/`LD=` for a make line. kbuild takes these from the command
    line only: the top Makefile assigns them, so an environment value
    would lose."""
    out = [f"CC={LINUX_DIR / 'buildcc.py'}"]
    if args.linker == "badc":
        out.append(f"LD={LINUX_DIR / 'ldshim.py'}")
    return out


def kbuild(args, arch, tree, targets, extra=(), log_name="build",
           tolerate_rc=False) -> Path:
    keep = ["-k"] if args.keep_going else []
    cmd = ["make", f"-j{args.jobs}", *keep, *toolchain_args(args), *extra,
           *targets]
    build_log = args.workdir / f"{log_name}-{args.arch}.log"
    log(f"{' '.join(cmd)} (in {tree}, log {build_log})")
    with build_log.open("wb") as fh:
        rc = subprocess.run(cmd, cwd=tree, env=shim_env(args, arch),
                            stdin=subprocess.DEVNULL, stdout=fh,
                            stderr=subprocess.STDOUT).returncode
    if rc != 0:
        detail = f"make {' '.join(targets)} exited {rc} (see {build_log})"
        if not tolerate_rc:
            die(detail + tail(build_log))
        log(detail)
    return build_log


def phase_build(args, arch, tree) -> None:
    args.manifest.unlink(missing_ok=True)
    args.ld_manifest.unlink(missing_ok=True)
    args.warn_log.unlink(missing_ok=True)
    # Under --keep-going the build is a survey: make carries on past a unit
    # badc rejects so the manifest ranks every failure instead of naming the
    # first. The failing status is still reported, and the manifest counts
    # are what the run is judged on.
    kbuild(args, arch, tree, [arch["make_target"], "modules"],
           tolerate_rc=args.keep_going)


def read_manifest(path: Path) -> dict[str, list[str]]:
    out = {"badc": [], "fallback": [], "fail": []}
    if path.exists():
        for line in path.read_text(errors="replace").splitlines():
            verdict, _, rest = line.partition("\t")
            if verdict in out:
                out[verdict].append(rest)
    return out


# --- package ----------------------------------------------------------------

def deb_tool_stamp() -> str:
    """Digest of the rpm file names `dnf` resolves the tool set to now.

    The mirror host rotates per query, so only the resolved NEVRAs are
    hashed. A prefix whose stamp differs was built against a package set the
    mirror no longer serves and is rebuilt rather than reused.
    """
    r = run(["dnf", "download", "--url", "--arch", platform.machine(),
             "--arch", "noarch", *DEB_TOOL_RPMS], check=True)
    names = sorted(u.rsplit("/", 1)[-1] for u in r.stdout.split()
                   if u.endswith(".rpm"))
    if not names:
        die(f"dnf resolved no rpms for {' '.join(DEB_TOOL_RPMS)}")
    return hashlib.sha256("\n".join(names).encode()).hexdigest()


def ensure_deb_tools(prefix: Path) -> None:
    """Provision the Debian packaging tools under a prefix on an rpm host.

    `dnf download` + rpm2cpio extraction only; nothing touches the system.
    """
    if not shutil.which("dnf"):
        die(f"no dpkg-buildpackage on PATH and no dnf to provision "
            f"{prefix}; install the dpkg/debhelper suite or point "
            f"--deb-tools at a provisioned prefix")
    stamp = deb_tool_stamp()
    stamp_file = prefix / "stamp"
    if ((prefix / "usr/bin/dpkg-buildpackage").exists()
            and stamp_file.is_file()
            and stamp_file.read_text().strip() == stamp):
        return
    shutil.rmtree(prefix, ignore_errors=True)
    prefix.mkdir(parents=True, exist_ok=True)
    rpms = prefix / "rpms"
    rpms.mkdir(exist_ok=True)
    log(f"provisioning Debian packaging tools under {prefix}")
    run(["dnf", "download", "--destdir", str(rpms), "--arch",
         platform.machine(), "--arch", "noarch", *DEB_TOOL_RPMS], check=True)
    for rpm in sorted(rpms.glob("*.rpm")):
        with open(rpm, "rb") as f:
            unrpm = subprocess.Popen(["rpm2cpio", "-"], stdin=f,
                                     stdout=subprocess.PIPE)
            subprocess.run(["cpio", "-idmu", "--quiet"], stdin=unrpm.stdout,
                           cwd=prefix, check=True)
            if unrpm.wait() != 0:
                die(f"rpm2cpio failed on {rpm.name}")


def deb_tool_env(prefix: Path, env: dict) -> None:
    admindir = prefix / "var/lib/dpkg"
    admindir.mkdir(parents=True, exist_ok=True)
    (admindir / "status").touch()
    env["PATH"] = f"{prefix}/usr/bin:{env['PATH']}"
    env["PERL5LIB"] = f"{prefix}/usr/share/perl5/vendor_perl"
    env["LD_LIBRARY_PATH"] = f"{prefix}/usr/lib64"
    env["DPKG_DATADIR"] = f"{prefix}/usr/share/dpkg"
    env["DPKG_ADMINDIR"] = str(admindir)


def posix_echo_shell() -> str:
    """A shell whose `echo -n` suppresses the newline instead of printing the
    flag. `/bin/sh` on macOS is bash in xpg_echo mode, where
    `scripts/package/builddeb` writes `INITRD=-n Yes` into the maintainer
    scripts. Every Linux `/bin/sh` passes the probe, so this returns
    `/bin/sh` there."""
    for sh in ("/bin/sh", shutil.which("bash"), shutil.which("dash")):
        if not sh:
            continue
        r = run([sh, "-c", "echo -n x"], timeout=30)
        if r.returncode == 0 and r.stdout == "x":
            return sh
    die("no shell whose `echo -n` omits the newline")


def build_deb_without_debhelper(args, arch, tree) -> list[Path]:
    """The deb the kernel's `bindeb-pkg` would build, on a host with no
    debhelper. `debian/rules` reaches the packaging through `dh_*`, but the
    staging itself is `scripts/package/builddeb`, which is plain shell: run
    the tree's own script, then let dpkg write the control file and the
    archive. `--root-owner-group` is what removes the need for fakeroot."""
    pkg = f"linux-image-{args.release}"
    pdir = tree / "debian" / pkg
    shutil.rmtree(pdir, ignore_errors=True)
    kbuild(args, arch, tree, ["debian"], log_name="package")
    # `debian/rules build-arch` builds `all`; builddeb only copies what that
    # produced, so the image and modules have to exist first.
    kbuild(args, arch, tree, ["all"], log_name="package")
    sh = posix_echo_shell()
    kbuild(args, arch, tree, ["run-command"],
           extra=[f"KERNELRELEASE={args.release}",
                  f"KBUILD_RUN_COMMAND={sh} $(srctree)/scripts/package/builddeb "
                  f"{pkg}"],
           log_name="package")
    if not (pdir / "DEBIAN").is_dir():
        die(f"builddeb staged no {pdir}/DEBIAN")
    # dpkg-gencontrol resolves the package's architecture against the build
    # host's, which is not a Debian architecture here; the tree already
    # recorded the one it is building for.
    env = dict(os.environ, DEB_HOST_ARCH=(tree / "debian/arch").read_text().strip())
    run(["dpkg-gencontrol", f"-p{pkg}", f"-P{pdir}", "-fdebian/files-nodh"],
        cwd=tree, env=env, check=True)
    # A directory destination makes dpkg-deb name the file
    # <package>_<version>_<arch>.deb, which is what the install step globs for.
    run(["dpkg-deb", "--root-owner-group", "--build", str(pdir),
         str(args.workdir)], check=True)
    debs = sorted(args.workdir.glob(f"{pkg}_*.deb"))
    if not debs:
        die(f"dpkg-deb produced no {pkg} deb in {args.workdir}")
    return debs


def build_deb(args, arch, tree) -> list[Path]:
    # Products of a previous run in this workdir would satisfy the install
    # globs; a fresh package phase replaces them.
    for stale in args.workdir.glob("linux-image-*.deb"):
        stale.unlink()
    if args.deb_tools:
        ensure_deb_tools(args.deb_tools)
    elif shutil.which("dh_listpackages") is None:
        # `debian/rules` enumerates and assembles packages with debhelper.
        # Without it the kernel's own target cannot run at all, so the deb is
        # built from the same staging by hand. Reachable on Linux by design,
        # not only on macOS: a Linux host with dpkg-dev but no debhelper used
        # to fail inside bindeb-pkg and now takes this route.
        log("no debhelper: building the linux-image deb without it")
        return build_deb_without_debhelper(args, arch, tree)
    admindir = (args.deb_tools / "var/lib/dpkg") if args.deb_tools else None
    # -d: build-dependency data lives in a dpkg database this host does
    # not have; the tools themselves are the real prerequisite.
    flags = "-d"
    if admindir:
        flags += f" --buildinfo-option=--admindir={admindir}"
    kbuild(args, arch, tree, ["bindeb-pkg"],
           extra=[f"DPKG_FLAGS={flags}"], log_name="package")
    debs = sorted(args.workdir.glob(f"linux-image-{args.release}_*.deb"))
    debs = [d for d in debs if "-dbg" not in d.name]
    if not debs:
        die(f"bindeb-pkg produced no linux-image deb in {args.workdir}")
    return debs


def build_rpm(args, arch, tree) -> list[Path]:
    shutil.rmtree(tree / "rpmbuild/RPMS", ignore_errors=True)
    # Modules are stripped at install; the gate packages the kernel, not its
    # debug info.
    kbuild(args, arch, tree, ["binrpm-pkg"],
           extra=["INSTALL_MOD_STRIP=1", "RPMOPTS=--without debuginfo"],
           log_name="package")
    ver = args.release.replace("-", "_")
    rpms = [p for p in sorted((tree / "rpmbuild/RPMS").rglob("*.rpm"))
            if re.fullmatch(rf"kernel-{re.escape(ver)}-[^-]+\.[^.]+\.rpm",
                            p.name)]
    if not rpms:
        die(f"binrpm-pkg produced no kernel rpm under {tree}/rpmbuild/RPMS")
    return rpms


# The packaging format is a property of the target distribution, not of the
# architecture: the kernel's bindeb-pkg and binrpm-pkg targets both work on
# either arch given their tools. The per-arch default is the format the image
# the gate boots installs; a survey can ask for both.
PACKAGERS = {"deb": build_deb, "rpm": build_rpm}


def phase_package(args, arch, tree) -> list[Path]:
    out: list[Path] = []
    for fmt in args.pkg_formats:
        out += PACKAGERS[fmt](args, arch, tree)
    return out


def readelf_bin() -> str:
    """`readelf`, resolved also through Homebrew's binutils on a macOS
    host, where the SDK ships none and the kbuild PATH is per-run."""
    found = shutil.which("readelf")
    if found:
        return found
    brew = Path(shutil.which("brew") or "/opt/homebrew/bin/brew").resolve().parents[1]
    cand = brew / "opt/binutils/bin/readelf"
    return str(cand) if cand.is_file() else "readelf"


def assert_module_producer(tree: Path, failures: list[str]) -> dict:
    """Every packaged module must carry badc's `.comment` producer string.

    The banner states the compiler Kconfig recorded; this states the
    compiler that actually wrote the shipped objects. Modules are read
    from the build tree, where they are neither stripped nor compressed.
    """
    mods = sorted(tree.glob("**/*.ko"))[:24]
    if not mods:
        failures.append(f"no modules built under {tree}")
        return {}
    checked, bad = 0, []
    for m in mods:
        r = run([readelf_bin(), "-p", ".comment", str(m)])
        if r.returncode != 0:
            continue
        checked += 1
        if not names_badc(r.stdout):
            bad.append(m.relative_to(tree).as_posix())
    if not checked:
        failures.append("could not read .comment from any module")
    elif bad:
        failures.append(f"modules whose .comment does not name badc: "
                        f"{len(bad)} ({', '.join(bad[:3])})")
    else:
        log(f"module .comment names badc in all {checked} sampled modules")
    return {"sampled": checked, "not_badc": bad}


def assert_manifest(args, failures: list[str]) -> dict:
    units = read_manifest(args.manifest)
    log(f"units: badc={len(units['badc'])} fallback={len(units['fallback'])} "
        f"fail={len(units['fail'])}")
    if units["fail"]:
        named = ", ".join(u.split("\t")[0] for u in units["fail"][:5])
        failures.append(
            f"units badc could not compile: {len(units['fail'])} ({named})")
    if units["fallback"]:
        failures.append(f"units that fell back to {args.real_cc}: "
                        f"{len(units['fallback'])}")
    if len(units["badc"]) < args.expect_units:
        failures.append(f"units compiled: {len(units['badc'])}, expected at "
                        f"least {args.expect_units}")
    return {k: len(v) for k, v in units.items()}


def assert_link_manifest(args, failures: list[str]) -> dict:
    """Under `--linker badc` every link is badc's, so anything else in
    the manifest is a failure the package must not hide."""
    links = read_manifest(args.ld_manifest)
    log(f"links: badc={len(links['badc'])} "
        f"fallback={len(links['fallback'])} fail={len(links['fail'])}")
    if links["fail"]:
        named = ", ".join(l.split("\t")[0] for l in links["fail"][:5])
        failures.append(
            f"links badc could not make: {len(links['fail'])} ({named})")
    if links["fallback"]:
        failures.append(f"links that fell back to {args.real_ld}: "
                        f"{len(links['fallback'])}")
    if not links["badc"]:
        failures.append("no link was made by badc")
    return {k: len(v) for k, v in links.items()}


# --- vm ---------------------------------------------------------------------

# Machine the vm phase runs on. The selfhost stage compiles a kernel inside
# the guest and needs one that can; the gate's own sizes are unchanged.
VM_SIZE = {"vm_cpus": 2, "vm_mem": 2048, "vm_disk": "12G"}
VM_SIZE_SELFHOST = {"vm_mem": 6144, "vm_disk": "40G"}


def vm_size(selfhost: bool) -> dict:
    if not selfhost:
        return dict(VM_SIZE)
    return {**VM_SIZE, **VM_SIZE_SELFHOST,
            "vm_cpus": min(4, os.cpu_count() or 4)}


def ensure_image(args, arch) -> Path:
    """The cloud image, verified against a pinned sha256 in every path.

    An image that does not match is a hard failure: the gate's verdict has to
    be attributable to the kernel under test, not to whatever the mirror
    served that day.
    """
    spec = arch["image"]
    if args.image:
        if not args.image.is_file():
            die(f"no image at {args.image}")
        want = args.image_sha256 or spec["sha256"]
        got = sha256_of(args.image)
        if got != want:
            die(f"image {args.image} has sha256 {got}, expected {want} "
                f"(--image-sha256 states the digest of an ad-hoc image)")
        return args.image
    args.image_cache.mkdir(parents=True, exist_ok=True)
    dst = args.image_cache / spec["asset"]
    _fetch.fetch_and_verify(IMAGE_RELEASE_TAG, spec["asset"], dst,
                            spec["sha256"], log, fallback_url=spec["upstream"])
    return dst


def require_case_sensitive(workdir: Path) -> None:
    """The tree carries header pairs that differ only in case
    (`netfilter_ipv4/ipt_ECN.h` and `ipt_ecn.h`, the `xt_DSCP.h` /
    `xt_dscp.h` family), so extracting it on a case-insensitive
    filesystem -- a macOS APFS volume in its default format -- keeps one
    of each pair and the build then fails on a missing member rather
    than on the filesystem."""
    a, b = workdir / ".case-probe-A", workdir / ".case-probe-a"
    a.write_text("A")
    try:
        distinct = not b.exists()
    finally:
        a.unlink(missing_ok=True)
    if not distinct:
        die(f"{workdir} is on a case-insensitive filesystem; the kernel "
            f"tree needs a case-sensitive one (on macOS: a volume formatted "
            f"as Case-sensitive APFS, or a sparse image created with "
            f"`hdiutil create -fs 'Case-sensitive APFS' -size 40g -volname "
            f"kernel kernel.sparseimage` and attached)")


def free_port() -> int:
    with socket.socket() as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]


def make_seed(args) -> Path:
    key = args.workdir / "vm-key"
    if not key.is_file():
        run(["ssh-keygen", "-q", "-t", "ed25519", "-N", "", "-f", str(key)],
            check=True)
    pub = (args.workdir / "vm-key.pub").read_text().strip()
    seed_dir = args.workdir / "seed"
    seed_dir.mkdir(exist_ok=True)
    (seed_dir / "meta-data").write_text(
        f"instance-id: badc-{args.arch}\nlocal-hostname: badc-{args.arch}\n")
    (seed_dir / "user-data").write_text(f"""\
#cloud-config
users:
  - name: badc
    plain_text_passwd: badc
    lock_passwd: false
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - {pub}
ssh_pwauth: true
""")
    seed = args.workdir / "seed.iso"
    tool = next((t for t in ("genisoimage", "mkisofs", "xorriso")
                 if shutil.which(t)), None)
    if tool is None:
        die("no genisoimage/mkisofs/xorriso for the cloud-init seed")
    cmd = [tool, "-output", str(seed), "-volid", "cidata", "-joliet",
           "-rock", "user-data", "meta-data"]
    if tool == "xorriso":
        cmd = ["xorriso", "-as", "genisoimage", *cmd[1:]]
    run(cmd, cwd=seed_dir, check=True)
    return seed


def probe_accel(args, arch, name: str) -> bool:
    """True when qemu starts a guest under `name`."""
    pidfile = args.workdir / f"{name}probe.pid"
    machine = (["-M", f"virt,accel={name}"] if args.arch == "aarch64"
               else ["-machine", f"accel={name}"])
    r = run([arch["qemu"], *machine, "-cpu", "host", "-S", "-display",
             "none", "-nodefaults", "-pidfile", str(pidfile), "-daemonize"],
            timeout=30)
    if r.returncode != 0:
        return False
    try:
        os.kill(int(pidfile.read_text()), 15)
    except (OSError, ValueError):
        pass
    return True


def probe_kvm(args, arch) -> bool:
    if not os.access("/dev/kvm", os.R_OK | os.W_OK):
        return False
    return probe_accel(args, arch, "kvm")


def probe_hvf(args, arch) -> bool:
    """macOS's hypervisor framework, the host-virtualization accelerator
    where /dev/kvm does not exist."""
    if platform.system() != "Darwin":
        return False
    return probe_accel(args, arch, "hvf")


def resolve_accel(args, arch) -> str:
    """The accelerator the vm phase will use.

    `--accel kvm` / `--accel hvf` fail when that accelerator is unusable
    rather than running the same validation an order of magnitude slower
    under a different execution engine; `auto` reports the substitution it
    makes. kvm is probed first, so a Linux host resolves exactly as before.
    """
    if args.accel == "tcg":
        return "tcg"
    if args.accel == "hvf":
        if probe_hvf(args, arch):
            return "hvf"
        die("--accel hvf: no usable hypervisor framework on this host")
    if probe_kvm(args, arch):
        return "kvm"
    if args.accel == "kvm":
        die("--accel kvm: no usable /dev/kvm on this host")
    if probe_hvf(args, arch):
        return "hvf"
    log("no usable /dev/kvm: running under tcg (--accel kvm to require kvm)")
    return "tcg"


class VmError(Exception):
    """A vm-phase step failed. Recorded as a run failure; the run still
    tears the VM down and writes its report."""


# Seconds of console silence after the machine starts that mean the
# firmware never ran.
FIRMWARE_CONSOLE_GRACE = 90

# qemu's i440fx caps memory below the 4 GiB boundary at 0xe0000000 and
# places the rest above it. SeaBIOS boots an nvme disk only while the
# guest stays under that split; at or above it the machine starts and
# the firmware writes nothing at all. virtio and ahci are unaffected,
# as is a direct `-kernel` boot at any size.
SEABIOS_NVME_MEM_LIMIT = 3584


class VM:
    def __init__(self, args, arch, disk: Path, seed: Path, accel: str):
        self.args, self.arch, self.disk, self.seed = args, arch, disk, seed
        self.accel = accel
        # `host` passes the machine's own features through; under tcg there is
        # no host to pass through, so the model is the emulator's maximum.
        self.cpu = args.vm_cpu or ("host" if accel in ("kvm", "hvf") else "max")
        self.console = args.workdir / f"console-{args.arch}.log"
        self.pidfile = args.workdir / f"vm-{args.arch}.pid"
        self.key = args.workdir / "vm-key"
        self.spares: list[Path] = []

    def start(self) -> None:
        args, arch = self.args, self.arch
        accel, cpu = self.accel, self.cpu
        if args.arch == "aarch64":
            machine = ["-M", f"virt,accel={accel}"]
            for code, vars_ in AARCH64_FIRMWARE:
                if Path(code).is_file():
                    if vars_ and Path(vars_).is_file():
                        vc = args.workdir / "efivars.fd"
                        shutil.copyfile(vars_, vc)
                        machine += ["-drive",
                                    f"if=pflash,format=raw,readonly=on,file={code}",
                                    "-drive", f"if=pflash,format=raw,file={vc}"]
                    else:
                        machine += ["-bios", code]
                    break
            else:
                die("no aarch64 EFI firmware found")
        else:
            machine = ["-machine", f"accel={accel}"]
        cmd = [arch["qemu"], *machine, "-cpu", cpu, "-smp", str(args.vm_cpus),
               "-m", str(args.vm_mem), "-display", "none", "-daemonize",
               "-pidfile", str(self.pidfile),
               "-serial", f"file:{self.console}",
               *self.disk_args(),
               "-netdev",
               f"user,id=n0,hostfwd=tcp:127.0.0.1:{args.ssh_port}-:22",
               "-device", f"{args.vm_nic},netdev=n0",
               *shlex.split(args.qemu_args)]
        log(f"qemu ({accel}): {' '.join(cmd)}")
        self.pidfile.unlink(missing_ok=True)
        run(cmd, check=True, timeout=60)

    def disk_args(self) -> list[str]:
        """The system disk, the cloud-init seed and any spare disks the
        exercise stage asked for, all on `--vm-disk-bus`."""
        bus = self.args.vm_disk_bus
        drives = [("d0", f"format=qcow2,file={self.disk}", "hd"),
                  ("d1", f"format=raw,readonly=on,file={self.seed}", "cd")]
        drives += [(f"d{i + 2}", f"format=qcow2,file={p}", "hd")
                   for i, p in enumerate(self.spares)]
        if bus == "virtio":
            return [a for _, spec, _ in drives for a in ("-drive", f"if=virtio,{spec}")]
        out: list[str] = []
        # The firmware boots the system disk first on every bus; without the
        # index SeaBIOS probes the emulated controllers in its own order and
        # may try the seed image first.
        boot = ["bootindex=0", *[""] * (len(drives) - 1)]
        if bus == "nvme":
            for i, (did, spec, _) in enumerate(drives):
                out += ["-drive", f"if=none,id={did},{spec}",
                        "-device", f"nvme,drive={did},serial=badc{i},{boot[i]}".rstrip(",")]
            return out
        if bus == "ahci":
            out += ["-device", "ahci,id=ctl0"]
            for i, (did, spec, kind) in enumerate(drives):
                out += ["-drive", f"if=none,id={did},{spec}",
                        "-device", f"ide-{kind},drive={did},bus=ctl0.{i},{boot[i]}".rstrip(",")]
            return out
        out += ["-device", f"{bus},id=ctl0"]
        for i, (did, spec, kind) in enumerate(drives):
            out += ["-drive", f"if=none,id={did},{spec}",
                    "-device", f"scsi-{kind},drive={did},bus=ctl0.0,scsi-id={i},{boot[i]}".rstrip(",")]
        return out

    def pid(self) -> int | None:
        try:
            pid = int(self.pidfile.read_text())
            os.kill(pid, 0)
            return pid
        except (OSError, ValueError):
            return None

    def ssh(self, cmd: str, timeout=120, check=False, sudo=False):
        if sudo:
            cmd = "sudo " + cmd
        r = run(["ssh", "-p", str(self.args.ssh_port), "-i", str(self.key),
                 "-o", "StrictHostKeyChecking=no",
                 "-o", "UserKnownHostsFile=/dev/null",
                 "-o", "ConnectTimeout=10", "-o", "LogLevel=ERROR",
                 "badc@127.0.0.1", cmd], timeout=timeout)
        if check and r.returncode != 0:
            raise VmError(f"vm command {cmd!r} exited {r.returncode}: "
                          f"{(r.stderr or r.stdout).strip()[-400:]}")
        return r

    def scp(self, paths: list[Path], dest: str) -> None:
        r = run(["scp", "-q", "-P", str(self.args.ssh_port), "-i", str(self.key),
                 "-o", "StrictHostKeyChecking=no",
                 "-o", "UserKnownHostsFile=/dev/null", "-o", "LogLevel=ERROR",
                 *map(str, paths), f"badc@127.0.0.1:{dest}"],
                timeout=600)
        if r.returncode != 0:
            raise VmError(f"scp into the vm exited {r.returncode}: "
                          f"{(r.stderr or '').strip()[-300:]}")

    def pull(self, remote: str, dest: Path) -> bool:
        r = run(["scp", "-q", "-P", str(self.args.ssh_port), "-i", str(self.key),
                 "-o", "StrictHostKeyChecking=no",
                 "-o", "UserKnownHostsFile=/dev/null", "-o", "LogLevel=ERROR",
                 f"badc@127.0.0.1:{remote}", str(dest)], timeout=600)
        return r.returncode == 0

    def console_bytes(self) -> int:
        """Bytes the machine has written to its console so far."""
        return self.console.stat().st_size if self.console.exists() else 0

    def wait_ssh(self, timeout: int, expect_boot_id: str | None = None) -> str:
        """Wait until ssh answers; with expect_boot_id, until a new boot."""
        deadline = time.time() + timeout
        # Firmware writes to the console within seconds of the machine
        # starting. Silence past that is a machine that never began to
        # boot, not a slow guest, and waiting out the full timeout hides
        # which of the two happened.
        silent_by = time.time() + FIRMWARE_CONSOLE_GRACE
        while time.time() < deadline:
            if self.pid() is None:
                raise VmError(f"qemu exited while waiting for ssh "
                              f"(console: {self.console})")
            if silent_by and time.time() > silent_by:
                if self.console_bytes() == 0:
                    raise VmError(
                        f"no console output {FIRMWARE_CONSOLE_GRACE}s after "
                        f"the machine started: the firmware never ran. On "
                        f"x86 with SeaBIOS that is what an nvme disk bus "
                        f"does once the guest has {SEABIOS_NVME_MEM_LIMIT} "
                        f"MiB or more (vm_mem={self.args.vm_mem}, bus="
                        f"{self.args.vm_disk_bus}) (console: {self.console})")
                silent_by = 0
            r = self.ssh("cat /proc/sys/kernel/random/boot_id", timeout=20)
            bid = r.stdout.strip()
            if r.returncode == 0 and bid and bid != expect_boot_id:
                return bid
            time.sleep(5)
        raise VmError(f"vm ssh not reachable within {timeout}s "
                      f"(console: {self.console})")

    def reboot(self, timeout: int, boot_id: str) -> str:
        self.ssh("reboot", sudo=True)
        time.sleep(10)
        return self.wait_ssh(timeout, expect_boot_id=boot_id)

    def stop(self) -> None:
        pid = self.pid()
        if pid is None:
            return
        self.ssh("poweroff", sudo=True)
        for _ in range(60):
            if self.pid() is None:
                return
            time.sleep(2)
        os.kill(pid, 15)


# Core file directory and pattern. A plain file pattern (not the distro's
# systemd-coredump pipe) makes cores land as extractable files; the sweep
# also checks coredumpctl in case a pipe pattern is still in force.
CORE_DIR = "/var/crash"
CORE_PATTERN = f"{CORE_DIR}/core.%e.%p.%t"


def configure_core_capture(vm: VM) -> dict:
    """Turn on core dumps and make the settings survive the reboot into the
    badc kernel: a sysctl.d file for the pattern, a limits.d file and a
    systemd drop-in for the size limit (so service / udev / modprobe crashes
    dump too). Applied on the stock system after the baseline, then verified
    again on the badc system. Returns the live core_pattern for the record."""
    script = (
        f"set -e; sudo mkdir -p {CORE_DIR}; sudo chmod 1777 {CORE_DIR}; "
        f"printf 'kernel.core_pattern={CORE_PATTERN}\\nkernel.core_uses_pid=1\\n' "
        "| sudo tee /etc/sysctl.d/99-badc-cores.conf >/dev/null; "
        f"sudo sysctl -w kernel.core_pattern='{CORE_PATTERN}' >/dev/null; "
        "printf '* soft core unlimited\\n* hard core unlimited\\n' "
        "| sudo tee /etc/security/limits.d/99-badc-core.conf >/dev/null; "
        "sudo mkdir -p /etc/systemd/system.conf.d; "
        "printf '[Manager]\\nDefaultLimitCORE=infinity\\n' "
        "| sudo tee /etc/systemd/system.conf.d/99-badc-core.conf >/dev/null; "
        "sudo systemctl daemon-reexec 2>/dev/null || true"
    )
    vm.ssh(script, timeout=120)
    return {"core_pattern": vm.ssh("cat /proc/sys/kernel/core_pattern").stdout.strip()}


def sweep_cores(args, vm: VM, phase: str, findings: list[str]) -> list[dict]:
    """After a validation phase, collect any core dumps: pull each core, the
    crashed binary and /proc/version out of the VM into the box scratch, and
    take a first-pass backtrace on the box. A core from a badc-compiled binary
    is a finding; every core is reported."""
    cores_dir = args.workdir / "cores" / f"{args.arch}-{phase}"
    listing = vm.ssh(
        f"sudo sh -c 'ls -1 {CORE_DIR}/core.* 2>/dev/null'").stdout.split()
    have_cdctl = vm.ssh("command -v coredumpctl").returncode == 0
    cdctl = []
    if have_cdctl:
        cdctl = [l for l in vm.ssh(
            "coredumpctl list --no-legend --no-pager 2>/dev/null"
        ).stdout.splitlines() if l.strip()]
    if not listing and not cdctl:
        return []
    cores_dir.mkdir(parents=True, exist_ok=True)
    vm.ssh(f"cat /proc/version | sudo tee {CORE_DIR}/proc_version >/dev/null")
    vm.pull(f"{CORE_DIR}/proc_version", cores_dir / "proc_version")
    found: list[dict] = []

    # coredumpctl-managed cores: export the core and the executable path.
    for i, line in enumerate(cdctl):
        exe = line.split()[-1]
        core = cores_dir / f"cdctl-{i}.core"
        vm.ssh(f"sudo sh -c 'coredumpctl dump --output={CORE_DIR}/e{i}.core "
               f"{i} >/dev/null 2>&1'")
        vm.pull(f"{CORE_DIR}/e{i}.core", core)
        binp = cores_dir / f"cdctl-{i}.bin"
        vm.pull(exe, binp)
        found.append(analyze_core(core, binp, exe, phase, findings))

    # File-pattern cores.
    for path in listing:
        core = cores_dir / Path(path).name
        vm.pull(path, core)
        exe = Path(path).name.split(".")[1] if "." in Path(path).name else ""
        which = vm.ssh(f"command -v {exe} 2>/dev/null").stdout.strip() or f"/usr/bin/{exe}"
        binp = cores_dir / f"{exe}.bin"
        vm.pull(which, binp)
        found.append(analyze_core(core, binp, which, phase, findings))

    for f in found:
        log(f"core [{phase}]: {f['exe']} -> {f['bt_first']}")
    return found


def analyze_core(core: Path, binp: Path, exe: str, phase: str,
                 findings: list[str]) -> dict:
    """First-pass backtrace on the box; flag a badc-compiled binary."""
    bt = ""
    if core.exists() and binp.exists() and shutil.which("gdb"):
        r = run(["gdb", "-batch", "-nx", "-ex", "bt", str(binp), str(core)],
                timeout=120)
        bt = (r.stdout + r.stderr)
    top = next((l.strip() for l in bt.splitlines()
                if l.lstrip().startswith("#")), bt.strip()[:200] or "no bt")
    # A badc-compiled ELF carries badc's producer string in .comment; distro
    # binaries carry GCC/Clang. This is the badc-artifact test the report needs.
    is_badc = False
    if binp.exists():
        c = run(["sh", "-c",
                 f"strings -a {shlex.quote(str(binp))} | grep -i badc | head -1"])
        is_badc = bool(c.stdout.strip())
    if is_badc:
        findings.append(f"core dump from a badc-compiled binary ({exe}) in the "
                        f"{phase} phase: {top}")
    return {"exe": exe, "core": str(core), "bt_first": top,
            "badc_built": is_badc, "phase": phase}


def grub_entry(vm: VM, release: str) -> str | None:
    """The `submenu>entry` title path of the grub.cfg entry that loads
    vmlinuz-<release>, in the form `grub-reboot` takes."""
    titles: list[str] = []
    for line in vm.ssh("cat /boot/grub/grub.cfg", sudo=True).stdout.splitlines():
        s = line.strip()
        m = re.match(r"(?:submenu|menuentry)\s+'([^']*)'.*\{$", s)
        if m:
            titles.append(m.group(1))
        elif s == "}":
            if titles:
                titles.pop()
        elif (m := re.match(r"linux\S*\s+(\S+)", s)) and m.group(1).endswith(
                f"/vmlinuz-{release}"):
            return ">".join(titles)
    return None


def probes(vm: VM) -> dict:
    out: dict = {}
    out["uname"] = vm.ssh("uname -r", check=True).stdout.strip()
    out["proc_version"] = vm.ssh("cat /proc/version").stdout.strip()
    # Not `head -1`: only x86_64 prints the version banner first. arm64
    # opens with the CPU-identification line.
    out["dmesg_banner"] = vm.ssh(
        "dmesg | grep -m1 'Linux version'", sudo=True).stdout.strip()
    out["cmdline"] = vm.ssh("cat /proc/cmdline").stdout.strip()
    for _ in range(60):
        state = vm.ssh("systemctl is-system-running").stdout.strip()
        if state and state != "starting":
            break
        time.sleep(5)
    out["systemd_state"] = state
    out["multi_user"] = vm.ssh(
        "systemctl is-active multi-user.target").stdout.strip()
    lsmod = vm.ssh("lsmod", check=True).stdout.splitlines()[1:]
    out["modules"] = sorted(l.split()[0] for l in lsmod if l.split())
    out["taint"] = vm.ssh("cat /proc/sys/kernel/tainted").stdout.strip()
    dmesg = vm.ssh("dmesg", sudo=True).stdout
    out["dmesg_severe"] = [l for l in dmesg.splitlines()
                           if DMESG_SEVERE.search(l)]
    out["dmesg_warn"] = sum(1 for l in dmesg.splitlines()
                            if DMESG_WARN.search(l))
    out["net_route"] = vm.ssh(
        "ip -o route show default").stdout.strip()
    out["net_driver"] = vm.ssh(
        "ls -l /sys/class/net/*/device/driver 2>/dev/null | "
        "sed 's/.*\\///' | sort -u | tr '\\n' ' '").stdout.strip()
    out["blk"] = vm.ssh("lsblk -dno NAME,SIZE,TRAN | tr '\\n' ' '").stdout.strip()
    # Every driver bound between the root disk and the bus it sits on: the
    # SCSI disk driver alone names no controller, so the chain is what a
    # storage model is checked against.
    out["disk_driver"] = vm.ssh(
        "src=$(findmnt -no SOURCE / | sed 's/\\[.*//'); "
        "dev=$(lsblk -no PKNAME \"$src\" | head -1); "
        "[ -n \"$dev\" ] || dev=$(basename \"$src\"); "
        "d=/sys/class/block/$dev/device; c=''; for _ in $(seq 16); do "
        "r=$(readlink -f $d) || break; [ \"$r\" = / ] && break; "
        "[ -e $d/driver ] && c=\"$c $(basename $(readlink -f $d/driver))\"; "
        "d=$d/..; done; echo $c").stdout.strip()
    disk = vm.ssh(
        "dd if=/dev/urandom of=io-probe bs=1M count=64 conv=fsync 2>/dev/null"
        " && sha256sum io-probe && sudo sh -c 'echo 3 > /proc/sys/vm/"
        "drop_caches' && sha256sum io-probe && rm io-probe", timeout=300)
    sums = re.findall(r"^([0-9a-f]{64}) ", disk.stdout, re.M)
    out["disk_rw"] = (disk.returncode == 0 and len(sums) == 2
                      and sums[0] == sums[1])
    return out


# --- selfhost ---------------------------------------------------------------

# What a kernel build needs beyond what a cloud image ships: the host compiler
# kbuild builds its own tools with, the assembler and linker behind badc, the
# Kconfig and certificate prerequisites, and the distribution's packaging
# tools. Installed while the stock kernel is still running, so the badc kernel
# carries the build alone and no part of it depends on the network.
SELFHOST_TOOLS = {
    "deb": ["build-essential", "bc", "bison", "flex", "libssl-dev",
            "libelf-dev", "cpio", "kmod", "rsync", "xz-utils", "debhelper",
            "dpkg-dev", "python3"],
    "rpm": ["gcc", "make", "binutils", "bc", "bison", "flex", "openssl-devel",
            "elfutils-libelf-devel", "cpio", "kmod", "rsync", "xz",
            "rpm-build", "python3"],
}

# Built-in objects the `units` scope compiles: the subsystems the build load
# itself runs through.
SELFHOST_UNIT_DIRS = ["init/", "kernel/", "mm/", "lib/", "fs/"]

# Minimum badc-compiled units per scope, floors just under the measured
# counts (805 for `units` at the x86_64 defconfig pin, 2953 for the whole
# tree). A scope that compiled a fraction of its corpus must not pass.
SELFHOST_EXPECT = {"units": 750, "image": 2900, "package": 2900}

SELFHOST_DIR = "/home/badc/selfhost"

# Written to /dev/kmsg on either side of the in-guest build, so what the
# kernel logged while building is separable from what it logged while booting.
SELFHOST_MARK = "badc-selfhost-{}"

OOM_KILL = re.compile(r"oom-kill:|Out of memory: Killed process|"
                      r"invoked oom-killer")


def selfhost_make_targets(scope: str, arch: dict) -> list[str]:
    """The make targets the in-guest build runs. `units` produces object
    files only, `image` links the kernel and builds its modules, `package`
    runs the distribution's packaging target, which builds both and stages
    them."""
    if scope == "units":
        return list(SELFHOST_UNIT_DIRS)
    if scope == "package":
        return ["bindeb-pkg" if arch["pkg"] == "deb" else "binrpm-pkg"]
    return [arch["make_target"], "modules"]


def selfhost_script(args, arch, targets: list[str], mark: str) -> str:
    """The build script the guest runs detached. Every variable the shims
    read is set here, so the in-guest build and the host build differ in
    nothing but the machine they run on."""
    ld = f"LD={SELFHOST_DIR}/ldshim.py" if args.linker == "badc" else ""
    return f"""\
set -u
cd {SELFHOST_DIR}/linux-{args.tree_version} || exit 1
export BADC={SELFHOST_DIR}/badc
export BADC_REAL_CC=gcc BADC_LD_REAL=ld
export BADC_TARGET={arch['target']}
export BADC_MANIFEST={SELFHOST_DIR}/manifest.txt
export BADC_LD_MANIFEST={SELFHOST_DIR}/ld-manifest.txt
export BADC_WARN_LOG={SELFHOST_DIR}/warnings.txt
export BADC_TIMEOUT={args.unit_timeout}
echo '{mark} begin' | sudo tee /dev/kmsg > /dev/null
make -j{args.selfhost_jobs} CC={SELFHOST_DIR}/buildcc.py {ld} {' '.join(targets)}
rc=$?
echo '{mark} end' | sudo tee /dev/kmsg > /dev/null
echo $rc > {SELFHOST_DIR}/rc
"""


def kmsg_window(dmesg: str, mark: str) -> list[str] | None:
    """The kernel log between the build's two markers. None when the opening
    marker is gone: the ring buffer wrapped and no window is attributable."""
    lines = dmesg.splitlines()
    start = next((i for i, l in enumerate(lines) if f"{mark} begin" in l), None)
    if start is None:
        return None
    end = next((i for i, l in enumerate(lines) if f"{mark} end" in l),
               len(lines))
    return lines[start + 1:end]


def scan_kmsg(lines: list[str]) -> dict:
    return {"lines": len(lines),
            "severe": [l for l in lines if DMESG_SEVERE.search(l)],
            "warn": [l for l in lines if DMESG_WARN.search(l)],
            "oom": [l for l in lines if OOM_KILL.search(l)]}


def manifest_regressions(host: dict, guest: dict) -> list[str]:
    """Units badc compiled on the build host and could not compile in the
    guest. The guest builds a subset of the host's corpus, so only units both
    runs reached are compared; a difference there is the kernel under the
    build, not a corpus difference."""
    ok = {u.split("\t")[0] for u in host["badc"]}
    return sorted({u.split("\t")[0] for u in guest["fail"]} & ok)


def sample_evenly(items: list[str], n: int) -> list[str]:
    """`n` items spread across the list, so a sample covers the build rather
    than its first seconds."""
    if n <= 0 or not items:
        return []
    if len(items) <= n:
        return list(items)
    step = len(items) / n
    return [items[int(i * step)] for i in range(n)]


def selfhost_provision(args, arch, vm: VM, result: dict) -> None:
    """Stage what the in-guest build needs while the stock kernel is still
    running: the tool set from the distribution's mirror, then badc, the shims
    and the kernel tarball pushed in from the host."""
    tools = SELFHOST_TOOLS[arch["pkg"]]
    if arch["pkg"] == "deb":
        # The image's own periodic apt units may still hold the lock this
        # early after boot; the timeout waits for them instead of failing.
        apt = "apt-get -qq -o DPkg::Lock::Timeout=600"
        cmd = (f"export DEBIAN_FRONTEND=noninteractive; {apt} update && "
               f"{apt} -y install " + " ".join(tools))
    else:
        cmd = "dnf -q -y install " + " ".join(tools)
    log(f"selfhost: installing {len(tools)} build packages in the guest")
    r = vm.ssh("sh -c " + shlex.quote(cmd), sudo=True,
               timeout=args.install_timeout)
    if r.returncode != 0:
        raise VmError(f"selfhost tool install exited {r.returncode}: "
                      f"{(r.stdout + r.stderr).strip()[-400:]}")
    vm.ssh(f"mkdir -p {SELFHOST_DIR}", check=True)
    log(f"selfhost: pushing badc, the shims and {args.tarball.name}")
    vm.scp([args.badc, LINUX_DIR / "buildcc.py", LINUX_DIR / "ldshim.py",
            args.tarball], SELFHOST_DIR)
    vm.ssh(f"chmod +x {SELFHOST_DIR}/badc {SELFHOST_DIR}/buildcc.py "
           f"{SELFHOST_DIR}/ldshim.py", check=True)
    ver = vm.ssh(f"{SELFHOST_DIR}/badc --version", check=True).stdout.strip()
    if not names_badc(ver):
        raise VmError(f"the pushed badc does not run in the guest: {ver[:200]}")
    result["badc_version"] = ver.splitlines()[0]
    result["tools"] = tools
    log(f"selfhost: guest badc: {result['badc_version']}")


def selfhost_prepare_tree(args, arch, vm: VM, result: dict) -> None:
    """Extract and configure the tree under the badc kernel; the extract
    alone is tens of thousands of file creations against the page cache."""
    t0 = time.time()
    r = vm.ssh(f"cd {SELFHOST_DIR} && tar xf {args.tarball.name}",
               timeout=args.selfhost_timeout)
    if r.returncode != 0:
        raise VmError(f"tarball extract in the guest exited {r.returncode}: "
                      f"{(r.stderr or '').strip()[-300:]}")
    result["extract_s"] = round(time.time() - t0, 1)
    tree = f"{SELFHOST_DIR}/linux-{args.tree_version}"
    target = "defconfig"
    if args.selfhost_config == "host":
        vm.scp([args.host_config], f"{tree}/.config")
        target = "olddefconfig"
    t0 = time.time()
    r = vm.ssh(f"cd {tree} && make -j{args.selfhost_jobs} "
               f"CC={SELFHOST_DIR}/buildcc.py {target} "
               f"> {SELFHOST_DIR}/config.log 2>&1",
               timeout=args.selfhost_timeout)
    result["config_s"] = round(time.time() - t0, 1)
    result["config_target"] = target
    if r.returncode != 0:
        raise VmError(f"make {target} in the guest exited {r.returncode}: " +
                      vm.ssh(f"tail -n 20 {SELFHOST_DIR}/config.log").stdout)
    log(f"selfhost: tree extracted in {result['extract_s']}s, "
        f"{target} in {result['config_s']}s")


def selfhost_stats(vm: VM) -> dict:
    """Load, memory, fault and per-disk I/O counters as the guest reports
    them, one `key value` line each."""
    out = vm.ssh(
        "printf 'loadavg %s\\n' \"$(cut -d' ' -f1-3 /proc/loadavg)\"; "
        "grep -E '^(MemTotal|MemAvailable|Committed_AS):' /proc/meminfo | "
        "tr -d ':' | awk '{print $1, $2}'; "
        "grep -E '^(pgfault|pgmajfault|pswpin|pswpout|oom_kill) ' "
        "/proc/vmstat; "
        "for s in /sys/block/*/stat; do d=${s%/stat}; "
        "echo \"io_${d##*/} $(awk '{print $3, $7}' $s)\"; done").stdout
    stats: dict = {}
    for line in out.splitlines():
        key, _, value = line.partition(" ")
        value = value.strip()
        stats[key] = int(value) if value.isdigit() else value
    return stats


def selfhost_watch(args, vm: VM, result: dict) -> int:
    """Poll the guest until the detached build records its status. Each poll
    is a fresh ssh on a short timeout, so a kernel that stops scheduling is
    reported as a guest that stopped answering rather than stalling an open
    connection for the whole build."""
    deadline = time.time() + args.selfhost_timeout
    silent_since, last = None, -1
    peak = {"units": 0, "load": 0.0, "mem_used_kb": 0}
    while time.time() < deadline:
        time.sleep(30)
        r = vm.ssh(f"cut -d' ' -f1 /proc/loadavg; "
                   f"wc -l < {SELFHOST_DIR}/manifest.txt 2>/dev/null || echo 0; "
                   f"awk '/^MemTotal:/{{t=$2}} /^MemAvailable:/{{a=$2}} "
                   f"END{{print t-a}}' /proc/meminfo; "
                   f"cat {SELFHOST_DIR}/rc 2>/dev/null || echo -", timeout=90)
        if r.returncode != 0:
            silent_since = silent_since or time.time()
            if vm.pid() is None:
                raise VmError("qemu exited during the in-guest build "
                              f"(console: {vm.console})")
            silent = round(time.time() - silent_since)
            if silent > args.vm_timeout:
                raise VmError(f"the guest stopped answering ssh for {silent}s "
                              f"during the in-guest build")
            continue
        silent_since = None
        fields = r.stdout.split()
        if len(fields) < 4:
            continue
        peak["load"] = max(peak["load"], float(fields[0]))
        peak["units"] = max(peak["units"], int(fields[1]))
        peak["mem_used_kb"] = max(peak["mem_used_kb"], int(fields[2]))
        if peak["units"] != last:
            log(f"selfhost: {peak['units']} units, load {fields[0]}, "
                f"{int(fields[2]) >> 10} MiB used")
            last = peak["units"]
        if fields[3] != "-":
            result["peak"] = peak
            return int(fields[3])
    raise VmError(f"the in-guest build did not finish within "
                  f"{args.selfhost_timeout}s")


def selfhost_objects(args, arch, vm: VM, tree: str, units: dict,
                     result: dict, failures: list[str]) -> None:
    """Rebuild a sample of the objects badc just produced and require the
    bytes to repeat. badc is deterministic for a fixed command line, so a
    difference is the kernel losing or corrupting what the compiler wrote."""
    sources = [u for u in units["badc"] if u.endswith(".c")]
    cands = [s[:-2] + ".o"
             for s in sample_evenly(sources, args.selfhost_sample * 4)]
    # kbuild compiles some sources into a directory other than the source's,
    # so a manifest entry does not name its object. Keep the ones it does.
    present = vm.ssh("cd %s && ls -1 %s 2>/dev/null" % (
        tree, " ".join(shlex.quote(o) for o in cands))).stdout.split()
    objs = sample_evenly(present, args.selfhost_sample)
    if not objs:
        return
    names = " ".join(shlex.quote(o) for o in objs)
    before = vm.ssh(f"cd {tree} && sha256sum {names}", timeout=300)
    r = vm.ssh(f"cd {tree} && rm -f {names} && "
               f"BADC={SELFHOST_DIR}/badc BADC_REAL_CC=gcc "
               f"BADC_TARGET={arch['target']} "
               f"make -j{args.selfhost_jobs} CC={SELFHOST_DIR}/buildcc.py "
               f"{names} > {SELFHOST_DIR}/remake.log 2>&1",
               timeout=args.selfhost_timeout)
    after = vm.ssh(f"cd {tree} && sha256sum {names}", timeout=300)
    same = (r.returncode == 0 and before.returncode == 0
            and before.stdout == after.stdout)
    result["reproduced"] = {"sampled": len(objs), "identical": same}
    if not same:
        detail = vm.ssh(f"tail -n 5 {SELFHOST_DIR}/remake.log").stdout
        failures.append(f"the in-guest rebuild of {len(objs)} objects did not "
                        f"reproduce the bytes (rc={r.returncode}): "
                        f"{detail.strip()[-300:]}")
    else:
        log(f"selfhost: {len(objs)} rebuilt objects reproduced byte for byte")


def selfhost_packages(args, arch, vm: VM, tree: str,
                      failures: list[str]) -> list[dict]:
    """Shape of what the in-guest packaging target produced: the archive
    listing, and a kernel image inside it."""
    if args.selfhost_scope != "package":
        return []
    if arch["pkg"] == "deb":
        found = vm.ssh(f"ls -1 {SELFHOST_DIR}/linux-image-*.deb "
                       f"2>/dev/null").stdout.split()
        lister = "dpkg-deb -c"
    else:
        found = vm.ssh(f"find {tree}/rpmbuild/RPMS -name 'kernel-*.rpm' "
                       f"2>/dev/null").stdout.split()
        lister = "rpm -qlp"
    out: list[dict] = []
    for p in [p for p in found if "-dbg" not in p]:
        size = vm.ssh(f"stat -c %s {shlex.quote(p)}").stdout.strip()
        listing = vm.ssh(f"{lister} {shlex.quote(p)}", timeout=300).stdout
        entries = listing.splitlines()
        out.append({"name": Path(p).name, "bytes": int(size or 0),
                    "entries": len(entries),
                    "kernel_image": any(
                        re.search(r"/boot/(vmlinuz|Image|vmlinux)", l)
                        for l in entries)})
        log(f"selfhost: package {out[-1]['name']} "
            f"({out[-1]['bytes'] >> 20} MiB, {out[-1]['entries']} entries)")
        if not out[-1]["kernel_image"]:
            failures.append(f"the in-guest package {out[-1]['name']} carries "
                            f"no kernel image")
    if not out:
        failures.append("the in-guest packaging target produced no package")
    return out


def phase_selfhost(args, arch, vm: VM, failures: list[str]) -> dict:
    """Build the kernel again, with badc, inside the VM running the badc
    kernel. The build is the load; the kernel is what is under test."""
    result: dict = {"scope": args.selfhost_scope, "jobs": args.selfhost_jobs,
                    "config": args.selfhost_config,
                    "expect_units": args.selfhost_expect}
    tree = f"{SELFHOST_DIR}/linux-{args.tree_version}"
    selfhost_prepare_tree(args, arch, vm, result)
    targets = selfhost_make_targets(args.selfhost_scope, arch)
    result["targets"] = targets
    mark = SELFHOST_MARK.format(os.getpid())
    script = args.workdir / f"selfhost-build-{args.arch}.sh"
    script.write_text(selfhost_script(args, arch, targets, mark))
    vm.scp([script], f"{SELFHOST_DIR}/build.sh")
    result["taint_before"] = vm.ssh(
        "cat /proc/sys/kernel/tainted").stdout.strip()
    result["stats_before"] = selfhost_stats(vm)
    log(f"selfhost: make {' '.join(targets)} -j{args.selfhost_jobs} in the "
        f"guest")
    t0 = time.time()
    vm.ssh(f"rm -f {SELFHOST_DIR}/rc; setsid sh {SELFHOST_DIR}/build.sh "
           f"> {SELFHOST_DIR}/build.log 2>&1 < /dev/null &", check=True)
    rc = selfhost_watch(args, vm, result)
    result["build_s"] = round(time.time() - t0, 1)
    result["build_rc"] = rc
    result["build_tail"] = vm.ssh(
        f"tail -n 40 {SELFHOST_DIR}/build.log").stdout.strip()[-4000:]
    result["stats_after"] = selfhost_stats(vm)
    result["taint_after"] = vm.ssh(
        "cat /proc/sys/kernel/tainted").stdout.strip()

    # The kernel's own record of the build window.
    window = kmsg_window(vm.ssh("dmesg", sudo=True, timeout=300).stdout, mark)
    if window is None:
        result["kmsg"] = {"wrapped": True}
        failures.append("the kernel ring buffer wrapped during the in-guest "
                        "build; no window is attributable to it")
    else:
        scan = scan_kmsg(window)
        result["kmsg"] = scan
        log(f"selfhost: {scan['lines']} kernel log lines during the build "
            f"({len(scan['severe'])} severe, {len(scan['warn'])} warning, "
            f"{len(scan['oom'])} oom)")
        if scan["severe"]:
            failures.append(f"kernel log during the in-guest build: "
                            f"{scan['severe'][:3]}")
        if scan["warn"]:
            failures.append(f"kernel warnings during the in-guest build: "
                            f"{scan['warn'][:3]}")
        if scan["oom"]:
            failures.append(
                f"{len(scan['oom'])} OOM kill records during the in-guest "
                f"build at --vm-mem {args.vm_mem}: {scan['oom'][:2]}")
    if result["taint_after"] != result["taint_before"]:
        failures.append(f"kernel taint moved from {result['taint_before']} to "
                        f"{result['taint_after']} during the in-guest build")

    manifest = args.workdir / f"selfhost-manifest-{args.arch}.txt"
    vm.pull(f"{SELFHOST_DIR}/manifest.txt", manifest)
    warns = args.workdir / f"selfhost-warnings-{args.arch}.txt"
    vm.pull(f"{SELFHOST_DIR}/warnings.txt", warns)
    units = read_manifest(manifest)
    result["units"] = {k: len(v) for k, v in units.items()}
    counts, _ = diags.summary(warns)
    result["diagnostics"] = [[list(k), n] for k, n in counts.most_common()]
    log(f"selfhost: units badc={len(units['badc'])} "
        f"fallback={len(units['fallback'])} fail={len(units['fail'])} "
        f"in {result['build_s']}s")
    if rc != 0:
        failures.append(f"the in-guest build exited {rc}: "
                        f"{result['build_tail'][-400:]}")
    if units["fail"]:
        named = ", ".join(u.split("\t")[0] for u in units["fail"][:5])
        failures.append(f"units badc could not compile in the guest: "
                        f"{len(units['fail'])} ({named})")
    if len(units["badc"]) < args.selfhost_expect:
        failures.append(f"in-guest units compiled: {len(units['badc'])}, "
                        f"expected at least {args.selfhost_expect}")

    host_units = read_manifest(args.manifest)
    result["host_units"] = len(host_units["badc"])
    if host_units["badc"]:
        result["regressed"] = manifest_regressions(host_units, units)
        if result["regressed"]:
            failures.append(
                f"{len(result['regressed'])} units badc compiled on the build "
                f"host and failed in the guest: "
                f"{', '.join(result['regressed'][:5])}")
        else:
            log(f"selfhost: no unit regressed against the host build's "
                f"{result['host_units']}")
    else:
        log("selfhost: no host manifest in the workdir; unit outcomes are "
            "not compared")

    if rc == 0:
        selfhost_objects(args, arch, vm, tree, units, result, failures)
        result["packages"] = selfhost_packages(args, arch, vm, tree, failures)
    result["cores"] = sweep_cores(args, vm, "selfhost", failures)
    return result


def phase_vm(args, arch, packages: list[Path], failures: list[str]) -> dict:
    image = ensure_image(args, arch)
    accel = resolve_accel(args, arch)
    seed = make_seed(args)
    disk = args.workdir / f"disk-{args.arch}.qcow2"
    disk.unlink(missing_ok=True)
    run(["qemu-img", "create", "-q", "-f", "qcow2", "-b", str(image.resolve()),
         "-F", "qcow2", str(disk), args.vm_disk], check=True)

    vm = VM(args, arch, disk, seed, accel)
    if args.exercise:
        for i in range(args.exercise_spares):
            spare = args.workdir / f"spare-{args.arch}-{i}.qcow2"
            spare.unlink(missing_ok=True)
            run(["qemu-img", "create", "-q", "-f", "qcow2", str(spare),
                 exercise.SPARE_SIZE], check=True)
            vm.spares.append(spare)
    vm.start()
    result: dict = {"image": image.name, "image_sha256": arch["image"]["sha256"],
                    "accel": accel, "cpu": vm.cpu, "ssh_port": args.ssh_port,
                    "vm_cpus": args.vm_cpus, "vm_mem_mb": args.vm_mem,
                    "disk_bus": args.vm_disk_bus, "nic": args.vm_nic}
    try:
        boot_id = vm.wait_ssh(args.vm_timeout)
        log("stock system up; capturing baseline")
        # Turn on core capture on the stock system; the sysctl.d / limits.d /
        # systemd drop-in make it persist into the badc kernel's boot.
        result["core_capture"] = configure_core_capture(vm)
        log(f"core capture: pattern={result['core_capture']['core_pattern']}")
        base = probes(vm)
        result["stock"] = base
        log(f"stock: uname={base['uname']} systemd={base['systemd_state']} "
            f"modules={len(base['modules'])}")
        result["cores_stock"] = sweep_cores(args, vm, "stock", failures)
        if args.selfhost:
            result["selfhost"] = {}
            selfhost_provision(args, arch, vm, result["selfhost"])

        # Only the image's own format is installable in it; a survey may have
        # built the other one alongside.
        suffix = "." + arch["pkg"]
        packages = [p for p in packages if p.suffix == suffix]
        if not packages:
            failures.append(f"no {suffix} package to install in the "
                            f"{arch['distro']} image")
            return result
        log(f"installing {', '.join(p.name for p in packages)}")
        vm.scp(packages, "")
        names = " ".join(shlex.quote(p.name) for p in packages)
        cmd = f"dpkg -i {names}" if arch["pkg"] == "deb" else f"rpm -ivh {names}"
        r = vm.ssh(cmd, sudo=True, timeout=args.install_timeout)
        result["install_rc"] = r.returncode
        result["install_tail"] = (r.stdout + r.stderr).strip()[-2000:]
        if r.returncode != 0:
            failures.append(f"package install exited {r.returncode}: "
                            f"{result['install_tail'][-300:]}")
            return result

        # Make the new kernel the default entry. Debian's update-grub sorts
        # by version, which is asserted rather than assumed; Fedora's BLS
        # default is set explicitly.
        if arch["distro"] == "fedora":
            r = vm.ssh(f"grubby --set-default /boot/vmlinuz-{args.release}",
                       sudo=True)
            # Without grubby the BLS default is the highest version, which
            # the post-reboot uname assertion checks either way.
            result["boot_select"] = ("grubby --set-default" if r.returncode == 0
                                     else "bls version sort")
        else:
            # The default entry's title names no version; the kernel it
            # loads does.
            first = vm.ssh(
                "awk '/^[[:space:]]*linux/{print $2; exit}' "
                "/boot/grub/grub.cfg").stdout.strip()
            if first.endswith(f"vmlinuz-{args.release}"):
                result["boot_select"] = "version-sorted default"
            else:
                entry = grub_entry(vm, args.release)
                if entry is None:
                    failures.append(f"no grub.cfg entry loads "
                                    f"vmlinuz-{args.release}")
                    return result
                vm.ssh(f"grub-reboot {shlex.quote(entry)}", sudo=True,
                       check=True)
                result["boot_select"] = f"grub-reboot one-shot: {entry}"

        log(f"rebooting into {args.release} ({result['boot_select']})")
        vm.reboot(args.vm_timeout, boot_id)
        cur = probes(vm)
        result["badc"] = cur
        log(f"badc: uname={cur['uname']} systemd={cur['systemd_state']} "
            f"modules={len(cur['modules'])}")

        if cur["uname"] != args.release:
            failures.append(f"booted {cur['uname']}, expected {args.release}")
            return result
        # The banner is CONFIG_CC_VERSION_TEXT, captured from
        # `$(CC) --version | head -n1` at configure time. buildcc.py
        # answers that with badc's identification, so a kernel whose C
        # units are badc's must say so in /proc/version and in the boot
        # banner. Both surfaces are asserted: they come from the same
        # string, and a disagreement means the recorded config and the
        # running image were built from different Kconfig runs.
        result["compiler_id"] = {
            "banner": cur["proc_version"],
            "dmesg_banner": cur["dmesg_banner"],
            "names_badc": names_badc(cur["proc_version"]),
        }
        if not result["compiler_id"]["names_badc"]:
            failures.append(
                f"/proc/version does not identify badc: "
                f"{cur['proc_version'][:160]}")
        elif not names_badc(cur["dmesg_banner"]):
            failures.append(
                f"boot banner does not identify badc: "
                f"{cur['dmesg_banner'][:160]}")
        else:
            log(f"compiler-id: {cur['proc_version'][:120]}")
        if cur["multi_user"] != "active":
            failures.append(f"multi-user.target: {cur['multi_user']}")
        if cur["systemd_state"] not in ("running", "degraded"):
            failures.append(f"systemd state: {cur['systemd_state']}")
        if (cur["systemd_state"] == "degraded"
                and base["systemd_state"] != "degraded"):
            failed = vm.ssh("systemctl --failed --no-legend").stdout.strip()
            failures.append(f"systemd degraded under the badc kernel only: "
                            f"{failed}")
        if cur["taint"] != "0":
            failures.append(f"kernel tainted: {cur['taint']}")
        if cur["dmesg_severe"]:
            failures.append(f"dmesg severe patterns: "
                            f"{cur['dmesg_severe'][:3]}")
        if cur["dmesg_warn"] > base["dmesg_warn"]:
            failures.append(f"dmesg WARNING count {cur['dmesg_warn']} exceeds "
                            f"stock baseline {base['dmesg_warn']}")
        if not cur["disk_rw"]:
            failures.append("disk write/readback failed")
        if not cur["net_route"]:
            failures.append("no default route")
        want_nic = NICS[args.vm_nic]
        if want_nic not in cur["net_driver"].split():
            failures.append(f"network device not on {want_nic}: "
                            f"{cur['net_driver']!r}")
        want_disk = DISK_BUSES[args.vm_disk_bus]
        if want_disk not in cur["disk_driver"].split():
            failures.append(f"root disk not on {want_disk}: "
                            f"{cur['disk_driver']!r}")

        # Package-scriptlet products: depmod data and the initramfs.
        checks = {
            "modules.dep": f"test -s /lib/modules/{args.release}/modules.dep",
            "initramfs": (f"test -s /boot/initrd.img-{args.release} || "
                          f"test -s /boot/initramfs-{args.release}.img || "
                          f"ls /boot/*/{args.release}/initrd >/dev/null"),
        }
        for name, cmd in checks.items():
            if vm.ssh(cmd).returncode != 0:
                failures.append(f"missing package product: {name}")
        result["initrd_dmesg"] = vm.ssh(
            "dmesg | grep -m1 -i 'unpacking initramfs'",
            sudo=True).stdout.strip()

        loads = {}
        for mod in arch["modprobe"]:
            r = vm.ssh(f"modprobe {mod}", sudo=True, timeout=300)
            listed = mod in vm.ssh("lsmod").stdout
            loads[mod] = bool(r.returncode == 0 and listed)
            if not loads[mod]:
                failures.append(f"modprobe {mod}: rc={r.returncode} "
                                f"listed={listed} "
                                f"{(r.stderr or '').strip()[-200:]}")
        result["modprobe"] = loads
        after = vm.ssh("cat /proc/sys/kernel/tainted").stdout.strip()
        if after != "0":
            failures.append(f"kernel tainted after module loads: {after}")

        if args.exercise:
            result["exercise"] = exercise.run(args, vm, arch, args.release,
                                              failures, log)

        # Sweep for cores produced under the badc kernel (services, udev,
        # modprobe). A kernel-side oops/panic leaves no userspace core; the
        # qemu console log is that record and is kept regardless.
        result["cores_badc"] = sweep_cores(args, vm, "badc", failures)
        if not result["cores_badc"]:
            log("no userspace cores under the badc kernel")

        if args.selfhost:
            result["selfhost"].update(
                phase_selfhost(args, arch, vm, failures))
    except VmError as e:
        failures.append(str(e))
    finally:
        try:
            vm.stop()
        except Exception as e:  # teardown must not mask the verdict
            log(f"vm teardown: {e}")
    return result



# --- self-test --------------------------------------------------------------

def _self_test() -> int:
    """The pure helpers, without a tree, a host or a guest."""
    import types

    assert names_badc("badc 0.1 (gcc-compatible, GNU C 15.0.0)")
    assert not names_badc("gcc (GCC) 15.2.1")

    cfg = clear_foreign_files(
        'CONFIG_SYSTEM_TRUSTED_KEYS="debian/certs/x.pem"\n'
        'CONFIG_MODULE_SIG_KEY="debian/certs/k.pem"\n')
    assert 'CONFIG_SYSTEM_TRUSTED_KEYS=""' in cfg
    assert 'CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"' in cfg

    deb = {"pkg": "deb", "make_target": "bzImage", "target": "linux-x64"}
    rpm = {"pkg": "rpm", "make_target": "Image", "target": "linux-aarch64"}
    assert selfhost_make_targets("units", deb) == SELFHOST_UNIT_DIRS
    assert selfhost_make_targets("image", deb) == ["bzImage", "modules"]
    assert selfhost_make_targets("image", rpm) == ["Image", "modules"]
    assert selfhost_make_targets("package", deb) == ["bindeb-pkg"]
    assert selfhost_make_targets("package", rpm) == ["binrpm-pkg"]
    assert set(SELFHOST_EXPECT) == {"units", "image", "package"}

    args = types.SimpleNamespace(linker="reference", tree_version="7.1.6",
                                 selfhost_jobs=4, unit_timeout=600)
    sh = selfhost_script(args, deb, ["kernel/"], "M")
    assert f"cd {SELFHOST_DIR}/linux-7.1.6" in sh
    assert "export BADC_TARGET=linux-x64" in sh
    assert f"make -j4 CC={SELFHOST_DIR}/buildcc.py  kernel/" in sh
    assert "ldshim" not in sh
    assert "echo 'M begin' | sudo tee /dev/kmsg" in sh
    args.linker = "badc"
    assert f"LD={SELFHOST_DIR}/ldshim.py" in selfhost_script(
        args, deb, ["bzImage"], "M")

    log_text = "[0.0] boot\n[1.0] M begin\n[2.0] WARNING: x\n[3.0] M end\n"
    assert kmsg_window(log_text, "M") == ["[2.0] WARNING: x"]
    assert kmsg_window("[0.0] boot\n", "M") is None
    # No closing marker: the build died before writing it, and the window is
    # everything the kernel logged after it started.
    assert kmsg_window("[1.0] M begin\n[2.0] BUG: y\n", "M") == ["[2.0] BUG: y"]

    scan = scan_kmsg(["BUG: unable to handle", "WARNING: at x",
                      "oom-kill: constraint=CONSTRAINT_NONE", "plain"])
    assert (scan["lines"], len(scan["severe"]), len(scan["warn"]),
            len(scan["oom"])) == (4, 1, 1, 1)

    host = {"badc": ["fs/open.c", "mm/filemap.c"], "fallback": [], "fail": []}
    guest = {"badc": ["fs/open.c"], "fallback": [],
             "fail": ["mm/filemap.c\tinternal error", "net/new.c\tx"]}
    assert manifest_regressions(host, guest) == ["mm/filemap.c"]

    assert sample_evenly([], 4) == []
    assert sample_evenly(["a", "b"], 4) == ["a", "b"]
    assert sample_evenly([str(i) for i in range(100)], 4) == ["0", "25", "50",
                                                              "75"]

    assert vm_size(False) == VM_SIZE
    big = vm_size(True)
    assert big["vm_mem"] > VM_SIZE["vm_mem"] and big["vm_cpus"] >= 1

    print("linux packages: self-test ok", flush=True)
    return 0


# --- main -------------------------------------------------------------------

def self_test() -> int:
    assert names_badc("badc 0.1 (gcc-compatible, GNU C 15.0.0)")
    assert not names_badc("gcc (GCC) 15.0.0")
    assert not names_badc("")
    text = clear_foreign_files(
        'CONFIG_INITRAMFS_SOURCE="/x/y"\nCONFIG_MODULE_SIG_KEY="/k.pem"\n'
        'CONFIG_LOCALVERSION="-badc"\n')
    assert 'CONFIG_INITRAMFS_SOURCE=""' in text
    assert 'CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"' in text
    assert 'CONFIG_LOCALVERSION="-badc"' in text
    for name in ARCHES:
        arch = resolve_arch(name, None)
        assert arch["pkg"] in PACKAGERS and "sha256" in arch["image"]
        assert arch["qemu"].endswith(name)
    assert resolve_arch("x86_64", "fedora")["pkg"] == "rpm"
    assert set(DISK_BUSES) >= {"virtio", "nvme"} and "virtio-net-pci" in NICS
    exercise.self_test()
    print("linux packages: self-test ok", flush=True)
    return 0


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--arch", choices=sorted(ARCHES), default=host_arch())
    ap.add_argument("--distro", choices=sorted(DISTROS),
                    help="distribution to install into (default: the "
                         "architecture's own); selects the cloud image and "
                         "the packaging format")
    ap.add_argument("--badc", type=Path,
                    default=os.environ.get("BADC",
                                           REPO_ROOT / "target/release/badc"))
    ap.add_argument("--real-cc", default=os.environ.get("BADC_REAL_CC"),
                    help="reference compiler for the probes and the assembly "
                         "units badc declines (default: gcc; on macOS the "
                         "musl-cross <triple>-gcc for --arch)")
    ap.add_argument("--linker", choices=("reference", "badc"),
                    default="reference",
                    help="linker for the kernel build: the reference `ld`, "
                         "or badc through ldshim.py")
    ap.add_argument("--real-ld", default=os.environ.get("BADC_LD_REAL"),
                    help="reference linker (default: ld; on macOS the "
                         "musl-cross <triple>-ld for --arch)")
    ap.add_argument("--tarball", type=Path,
                    help="pinned kernel source tarball (see setup.py)")
    ap.add_argument("--tarball-url",
                    help="fetch the kernel tarball from this URL instead; "
                         "requires --tarball-sha256")
    ap.add_argument("--tarball-sha256",
                    help="expected sha256 of --tarball-url")
    ap.add_argument("--tarball-cache", type=Path,
                    default=LINUX_DIR / ".cache" / "tarballs",
                    help="where a fetched tarball is kept between runs")
    ap.add_argument("--config",
                    help=f"kernel .config to build: a path, or "
                         f"{CONFIG_FROM_VM!r} to take the distribution's own "
                         f"/boot/config-$(uname -r) out of the stock image "
                         f"(default: make defconfig)")
    ap.add_argument("--pkg", default="",
                    help="packaging formats, comma-separated from "
                         "deb,rpm (default: the image's own)")
    ap.add_argument("--keep-going", action="store_true",
                    help="survey mode: make -k, so the manifest ranks every "
                         "unit badc rejects instead of stopping at the first")
    ap.add_argument("--fallback", type=Path,
                    help="file of kernel-relative sources to leave to the "
                         "real compiler (BADC_FALLBACK), for bisecting")
    ap.add_argument("--ld-fallback", type=Path,
                    help="file of link outputs to leave to the real linker "
                         "(BADC_LD_FALLBACK), for bisecting")
    ap.add_argument("-j", "--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--unit-timeout", type=int, default=600,
                    help="seconds per badc unit")
    ap.add_argument("--expect-units", type=int, default=0,
                    help="minimum badc-compiled units (default: per-arch)")
    ap.add_argument("--phases", default="config,tree,build,package,vm",
                    help="comma-separated subset of config,tree,build,"
                         "package,vm,selfhost; selfhost is off by default and "
                         "runs inside the vm phase")
    ap.add_argument("--selfhost-scope", choices=sorted(SELFHOST_EXPECT),
                    default="units",
                    help="what the in-guest build makes: `units` the built-in "
                         "objects of "
                         f"{' '.join(SELFHOST_UNIT_DIRS)} (default), `image` "
                         "the kernel and its modules, `package` the "
                         "distribution's packaging target")
    ap.add_argument("--selfhost-config", choices=("defconfig", "host"),
                    default="defconfig",
                    help="configuration the in-guest build uses: the tree's "
                         "own defconfig (default), or the host build's")
    ap.add_argument("--selfhost-jobs", type=int, default=0,
                    help="make jobs in the guest (default: --vm-cpus)")
    ap.add_argument("--selfhost-timeout", type=int, default=7200,
                    help="seconds for any single in-guest build step")
    ap.add_argument("--selfhost-sample", type=int, default=8,
                    help="objects rebuilt in the guest and checked for byte "
                         "identity")
    ap.add_argument("--selfhost-expect-units", type=int, default=0,
                    help="minimum badc-compiled units in the guest "
                         "(default: per-scope)")
    ap.add_argument("--deb-tools", type=Path,
                    help="prefix for the Debian packaging tools on an rpm "
                         "host; provisioned there when missing")
    ap.add_argument("--image", type=Path,
                    help="cloud image (default: fetch the pinned asset)")
    ap.add_argument("--image-sha256",
                    help="expected sha256 of an ad-hoc --image; the pinned "
                         "digest is required without it")
    ap.add_argument("--image-cache", type=Path,
                    default=LINUX_DIR / ".cache" / "images",
                    help="where the pinned image is kept between runs")
    ap.add_argument("--accel", choices=("auto", "kvm", "hvf", "tcg"),
                    default="auto",
                    help="qemu accelerator; kvm and hvf fail when that "
                         "accelerator is unusable instead of substituting tcg")
    ap.add_argument("--ssh-port", type=int, default=0,
                    help="host port forwarded to the vm's ssh (default: a "
                         "free port, so runs do not collide)")
    ap.add_argument("--vm-cpu", default="",
                    help="qemu -cpu model (default: host under kvm, max "
                         "under tcg)")
    ap.add_argument("--vm-cpus", type=int, default=None)
    ap.add_argument("--vm-disk-bus", choices=sorted(DISK_BUSES), default="virtio",
                    help="storage controller the system disk and the seed are "
                         "attached through (default: virtio); the booted "
                         "kernel must drive the root disk with that "
                         "controller's driver")
    ap.add_argument("--vm-nic", choices=sorted(NICS), default="virtio-net-pci",
                    help="NIC model (default: virtio-net-pci); the booted "
                         "kernel must bind it to that model's driver")
    ap.add_argument("--vm-mem", type=int, default=None)
    ap.add_argument("--vm-disk", default=None)
    ap.add_argument("--vm-timeout", type=int, default=900,
                    help="seconds to wait for ssh after a boot")
    ap.add_argument("--install-timeout", type=int, default=1800,
                    help="seconds for the package install, which regenerates "
                         "the initramfs and is the longest single step")
    ap.add_argument("--qemu-args", default="")
    exercise.add_arguments(ap)
    ap.add_argument("--workdir", type=Path,
                    default=Path.cwd() / "packages-out")
    ap.add_argument("--report", type=Path)
    args = ap.parse_args()

    arch = resolve_arch(args.arch, args.distro)
    cross = f"{args.arch}-linux-musl-" if platform.system() == "Darwin" else ""
    args.real_cc = args.real_cc or f"{cross}gcc"
    args.real_ld = args.real_ld or f"{cross}ld"
    phases = set(args.phases.split(","))
    if unknown := phases - {"config", "tree", "build", "package", "vm",
                            "selfhost"}:
        die(f"unknown phases: {sorted(unknown)}")
    args.selfhost = "selfhost" in phases
    if args.selfhost and "vm" not in phases:
        die("the selfhost phase runs inside the vm phase and needs it")
    for name, value in vm_size(args.selfhost).items():
        if getattr(args, name) is None:
            setattr(args, name, value)
    args.selfhost_jobs = args.selfhost_jobs or args.vm_cpus
    args.selfhost_expect = (args.selfhost_expect_units
                            or SELFHOST_EXPECT[args.selfhost_scope])
    args.workdir = args.workdir.resolve()
    args.workdir.mkdir(parents=True, exist_ok=True)
    require_case_sensitive(args.workdir)
    # Held for the process lifetime: the tree, the packages and the vm disk
    # all live in the workdir, so two runs sharing one would corrupt both.
    lock = (args.workdir / "lock").open("w")
    try:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except OSError:
        die(f"another packages.py run holds {args.workdir}; pass a distinct "
            f"--workdir")
    lock.write(f"{os.getpid()}\n")
    lock.flush()
    if not args.ssh_port:
        args.ssh_port = free_port()
    if args.exercise and args.vm_mem < exercise.EXERCISE_VM_MEM:
        log(f"--exercise: raising --vm-mem to {exercise.EXERCISE_VM_MEM}")
        args.vm_mem = exercise.EXERCISE_VM_MEM
    args.badc = Path(args.badc).resolve()
    args.manifest = args.workdir / f"manifest-{args.arch}.txt"
    args.ld_manifest = args.workdir / f"ld-manifest-{args.arch}.txt"
    args.warn_log = args.workdir / f"warnings-{args.arch}.txt"
    if not args.expect_units:
        args.expect_units = arch["expect_units"]
    if {"tree", "build", "package"} & phases and not os.access(args.badc,
                                                               os.X_OK):
        die(f"badc not executable: {args.badc} "
            f"(cargo build --release --features full)")
    args.pkg_formats = args.pkg.split(",") if args.pkg else [arch["pkg"]]
    if bad := set(args.pkg_formats) - set(PACKAGERS):
        die(f"unknown packaging formats: {sorted(bad)}")
    if args.deb_tools:
        args.deb_tools = args.deb_tools.resolve()
    elif "deb" in args.pkg_formats and not shutil.which("dpkg-buildpackage"):
        args.deb_tools = args.workdir / "deb-tools"

    failures: list[str] = []
    report: dict = {"arch": args.arch, "linker": args.linker, "packages": []}

    config = None
    if args.config == CONFIG_FROM_VM:
        if "config" not in phases:
            die(f"--config {CONFIG_FROM_VM} needs the config phase")
        config = phase_config(args, arch)
        report["config_source"] = json.loads(
            (args.workdir / f"config-vm-{args.arch}.json").read_text())
    elif args.config:
        config = Path(args.config)
        if not config.is_file():
            die(f"no config at {config}")

    if not phases - {"config"}:
        if args.report:
            report["failures"] = failures
            args.report.write_text(json.dumps(report, indent=2) + "\n")
        return 0

    if "tree" in phases:
        if args.tarball_url:
            if not args.tarball_sha256:
                die("--tarball-url requires --tarball-sha256")
            args.tarball = fetch_tarball(args.tarball_url,
                                         args.tarball_sha256,
                                         args.tarball_cache)
        if not args.tarball or not args.tarball.is_file():
            die("--tarball or --tarball-url is required for the tree phase")
        tree = phase_tree(args, arch, config)
        report["config_deviations"] = len([
            ln for ln in (args.workdir /
                          f"config-deviations-{args.arch}.txt")
            .read_text().splitlines() if ln.strip()])
    else:
        trees = sorted(args.workdir.glob("linux-*/Makefile"))
        if not trees:
            die(f"no prepared tree under {args.workdir}; run the tree phase")
        tree = trees[0].parent
    args.tree_version = tree.name[len("linux-"):]
    args.host_config = tree / ".config"
    args.release = run(["make", "-s", "kernelrelease"], cwd=tree,
                       env=shim_env(args, arch),
                       check=True).stdout.strip()
    log(f"kernel {args.release} in {tree}")
    report["release"] = args.release

    if "build" in phases:
        phase_build(args, arch, tree)

    packages: list[Path] = []
    if "package" in phases:
        packages = phase_package(args, arch, tree)
        for p in packages:
            log(f"package: {p.name} ({p.stat().st_size >> 20} MiB)")
        report["packages"] = [{"name": p.name, "bytes": p.stat().st_size,
                               "sha256": sha256_of(p)} for p in packages]
    if {"build", "package"} & phases:
        report["units"] = assert_manifest(args, failures)
        if args.linker == "badc":
            report["links"] = assert_link_manifest(args, failures)
        counts, lines = diags.summary(args.warn_log)
        for line in lines:
            log(line)
        report["diagnostics"] = [[list(k), n] for k, n in counts.most_common()]
        report["module_producer"] = assert_module_producer(tree, failures)

    if args.selfhost and (not args.tarball or not args.tarball.is_file()):
        die("the selfhost phase pushes the kernel tarball into the guest; "
            "--tarball or --tarball-url is required")
    if "vm" in phases and not failures:
        if not packages:
            packages = (sorted(args.workdir.glob(
                f"linux-image-{args.release}_*.deb"))
                if arch["pkg"] == "deb" else
                [p for p in sorted((tree / "rpmbuild/RPMS").rglob("*.rpm"))
                 if p.name.startswith(
                     f"kernel-{args.release.replace('-', '_')}-")])
            packages = [p for p in packages if "-dbg" not in p.name]
            if not packages:
                die("no packages to install; run the package phase")
        report["vm"] = phase_vm(args, arch, packages, failures)

    if args.report:
        report["failures"] = failures
        args.report.write_text(json.dumps(report, indent=2) + "\n")

    for f in failures:
        print(f"linux packages: FAIL: {f}", flush=True)
    if failures:
        return 1
    log(f"PASS: {args.release} packaged as "
        f"{', '.join(p.name for p in packages) or 'n/a'}"
        + (", installed and validated in the "
           f"{arch['distro']} vm" if "vm" in phases else ""))
    return 0


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        sys.exit(_self_test())
    sys.exit(main())
