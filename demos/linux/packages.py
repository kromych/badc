#!/usr/bin/env python3
"""Distro-package gate for the badc-compiled Linux kernel.

Builds the pinned kernel with badc compiling every kernel C unit (buildcc.py,
same contract as verify.py: zero fallbacks), packages the result with the
kernel's own packaging targets (bindeb-pkg or binrpm-pkg, following the
distribution), installs the package in a stock distribution cloud image under
qemu, and validates the rebooted system: the package scriptlets (depmod, initramfs
generation, boot-loader entry) and the running kernel (systemd reaches
multi-user, udev-bound devices, on-demand module loads, dmesg, disk and
network I/O). A stock-kernel baseline is captured from the same image before
the install, so every measurement has a reference. Those probes read the
guest's own verdict on itself, so a stage after them drives what the boot does
not reach (exercise.py): the protocol families, a root-device round trip, the
crypto implementations and the kunit suites run on every boot, and
`--exercise` adds the module load sweep and the filesystem and block-stack
stress, which cost minutes.

    python3 demos/linux/packages.py --arch x86_64 --distro fedora \
        --tarball <linux-7.1.10.tar.xz> --config vendor \
        --report packages-x86_64.json

Phases (--phases selects a subset; each is idempotent): config, tree, build,
package, vm, hw, and the optional selfhost. The build runs in
<workdir>/linux-<version>; packages land in
<workdir> (deb) or the tree's rpmbuild/RPMS (rpm). On a host without the Debian
packaging tools (an rpm distribution), --deb-tools names a prefix that is
provisioned from the host's own package mirror via `dnf download` + rpm2cpio
extraction; nothing is installed system-wide.

The configuration is the distribution's own, not defconfig. `--config vendor`
takes it off the vendor-deps release, sha256-verified and cached, which is what
a package build uses; `--config from-vm` extracts the same file from the booted
stock image, which is how that asset is produced and refreshed. A path names an
ad-hoc config, and without `--config` the tree's defconfig is built. A
configuration from another kernel version is carried forward with `make
olddefconfig` and what moved is recorded in
<workdir>/config-deviations-<arch>.txt.

The same script is the local survey tool: `--tarball-url` with a required
`--tarball-sha256` fetches the kernel rather than taking a local path; `--pkg
deb,rpm` produces both formats; and `--keep-going` runs the build under `make
-k`, so the manifest ranks every unit badc rejects instead of stopping at the
first.

The selfhost phase runs inside the vm phase, once the guest is on the badc
kernel: it stages a build environment, pushes badc and the shims, and builds
the kernel again with badc inside the VM. The build is the load and the kernel
is what is measured -- the kernel log window around it, taint, OOM records,
core dumps, and the unit outcomes against the host build's. It is off by
default; `--selfhost-scope` sizes it.

The hw phase runs the vm phase's sequence on a physical machine instead of a
guest: --hw-host reaches it over ssh and --hw-serial reads its console from a
serial port on this host. It needs no tree -- --release names what the
packages install and --package names the files -- and it refuses to run unless
the machine's standing boot default is a distribution kernel, since a box with
no remote power cut has nothing else to fall back to.

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
import termios
import threading
import time
import urllib.parse
import urllib.request
from pathlib import Path

import diags
import exercise
import setup

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
# image for is simply absent. `DISTROS[d]["kconfigs"][a]` is the sha256 of
# that image's own /boot/config, mirrored on the same release so a package
# build does not have to boot the image to read it.
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
        "kconfigs": {
            "x86_64": "b07d3cb0d53236b021d73038e315018801fa6b843529d53129ad94a2a5233bf6",
            "aarch64": "a61fbda882ae55d5321e55012f41d52e20c52f2a5de31808f89342eeb5d69cdc",
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
        "kconfigs": {
            "x86_64": "1c0d2e478cdc33747fb3bdd9e332677c517b5791c8cbed0454d22e6e430042d5",
            "aarch64": "044be830f7df5cb19c1b38ea42383e1a770b3722efb2b375cc86ac2efcfb2530",
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
    arch["kconfig"] = DISTROS[arch["distro"]].get("kconfigs", {}).get(name)
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

# EFI firmware per architecture, first match wins: a (code, vars) pflash
# pair, or a single -bios image where the entry names no variable store.
EFI_FIRMWARE = {
    "aarch64": [
        ("/usr/share/AAVMF/AAVMF_CODE.fd", "/usr/share/AAVMF/AAVMF_VARS.fd"),
        ("/usr/share/edk2/aarch64/QEMU_EFI.fd", None),
        ("/opt/homebrew/share/qemu/edk2-aarch64-code.fd",
         "/opt/homebrew/share/qemu/edk2-arm-vars.fd"),
    ],
    "x86_64": [
        ("/usr/share/edk2/ovmf/OVMF_CODE.fd",
         "/usr/share/edk2/ovmf/OVMF_VARS.fd"),
        ("/usr/share/OVMF/OVMF_CODE_4M.fd", "/usr/share/OVMF/OVMF_VARS_4M.fd"),
        ("/usr/share/OVMF/OVMF_CODE.fd", "/usr/share/OVMF/OVMF_VARS.fd"),
        ("/usr/share/edk2/x64/OVMF_CODE.4m.fd",
         "/usr/share/edk2/x64/OVMF_VARS.4m.fd"),
        ("/usr/share/edk2/ovmf/OVMF_CODE_4M.qcow2",
         "/usr/share/edk2/ovmf/OVMF_VARS_4M.qcow2"),
        ("/opt/homebrew/share/qemu/edk2-x86_64-code.fd",
         "/opt/homebrew/share/qemu/edk2-i386-vars.fd"),
    ],
}

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

# Where a distribution configuration comes from. `from-vm` boots the stock
# image and reads /boot/config-$(uname -r) out of it; `vendor` takes the
# mirrored copy of those same bytes off the vendor-deps release, which is how
# a package build gets one without a VM. `from-vm` is how the mirrored asset
# is produced and refreshed.
CONFIG_FROM_VM = "from-vm"
CONFIG_VENDOR = "vendor"
CONFIG_SOURCES = (CONFIG_FROM_VM, CONFIG_VENDOR)


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


def kconfig_asset(distro: str, arch: str, sha: str) -> str:
    """The mirrored configuration's asset name, per the scripts/vendor_deps
    convention: the basename plus the first 8 hex of its sha256."""
    return f"kconfig-{distro}-{arch}-{sha[:8]}.config"


def config_meta(path: Path, **fields) -> dict:
    """The provenance record both config sources write beside the .config."""
    return {**fields, "sha256": sha256_of(path),
            "bytes": path.stat().st_size,
            "set_options": sum(1 for ln in path.read_text().splitlines()
                               if re.match(r"CONFIG_\w+=", ln))}


def config_from_vendor(args, arch) -> Path:
    """Take the distribution's configuration off the vendor-deps release.

    The asset is the byte-identical copy of what `from-vm` extracted from the
    same pinned image, held to a sha256 the same way the image itself is, so
    a package build reaches the distribution's configuration without booting
    anything.
    """
    sha = arch["kconfig"]
    if not sha:
        die(f"no mirrored kernel configuration for {arch['distro']}/"
            f"{args.arch}; `--config {CONFIG_FROM_VM}` extracts one from the "
            f"image and scripts/vendor_deps/build_bundle.py publishes it")
    asset = kconfig_asset(arch["distro"], args.arch, sha)
    args.config_cache.mkdir(parents=True, exist_ok=True)
    cached = args.config_cache / asset
    _fetch.fetch_and_verify(IMAGE_RELEASE_TAG, asset, cached, sha, log)
    dest = args.workdir / f"config-vendor-{args.arch}.config"
    shutil.copyfile(cached, dest)
    meta = config_meta(dest, source="vendor-deps", asset=asset,
                       distro=arch["distro"], image=arch["image"]["asset"])
    (args.workdir / f"config-vendor-{args.arch}.json").write_text(
        json.dumps(meta, indent=2) + "\n")
    log(f"config from the {arch['distro']} mirror asset {asset}: "
        f"{meta['set_options']} options set ({dest})")
    return dest


def config_from_vm(args, arch) -> Path:
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
        meta = config_meta(dest, source="from-vm", source_release=release,
                           source_os=os_id, source_path=remote,
                           image=image.name)
        meta_path.write_text(json.dumps(meta, indent=2) + "\n")
        log(f"config from {os_id} kernel {release}: {meta['set_options']} "
            f"options set ({dest}); publish it as "
            f"{kconfig_asset(arch['distro'], args.arch, meta['sha256'])}")
    finally:
        vm.stop()
        disk.unlink(missing_ok=True)
    return dest


CONFIG_PHASE = {CONFIG_FROM_VM: config_from_vm,
                CONFIG_VENDOR: config_from_vendor}


def phase_config(args, arch) -> Path:
    return CONFIG_PHASE[args.config](args, arch)


# --- tree -------------------------------------------------------------------

def tarball_tree(args) -> Path:
    """Where the tarball unpacks. The directory name comes from the archive
    rather than from the file name: a mirrored asset carries a digest prefix
    in its file name that the directory inside it does not."""
    with tarfile.open(args.tarball) as tf:
        first = tf.next()
    if first is None:
        die(f"{args.tarball.name} is empty")
    root = first.name.split("/", 1)[0]
    if root in ("", ".", ".."):
        die(f"{args.tarball.name} does not unpack into a directory")
    return args.workdir / root


def phase_tree(args, arch, config: Path | None) -> Path:
    tree = tarball_tree(args)
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
    # `__cold` is an attribute macro in Apple's SDK and a keyword-like
    # define in the kernel's tools headers; the collision is between two
    # host headers, not in kernel code.
    env["HOSTCFLAGS"] = (f"-I{hc} -include {hc}/hostcompat.h -D_UUID_T"
                         f" -Wno-macro-redefined")
    # objtool, which x86 builds as a host program, links libelf; the SDK
    # has none and Homebrew keeps its headers in a subdirectory.
    elf = brew / "opt/libelf"
    if elf.is_dir():
        env["HOSTCFLAGS"] += f" -I{elf}/include -I{elf}/include/libelf"
        env["HOSTLDFLAGS"] = f"-L{elf}/lib " + env.get("HOSTLDFLAGS", "")
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


class TargetError(Exception):
    """A step against the machine under test failed. Recorded as a run
    failure; the run still releases the machine and writes its report."""


# Seconds of console silence after the machine starts that mean the
# firmware never ran.
FIRMWARE_CONSOLE_GRACE = 90

# ssh and scp options shared by every target: a lab machine's host key is
# not pinned, and a run must never stop at a prompt.
SSH_OPTS = ["-o", "StrictHostKeyChecking=no",
            "-o", "UserKnownHostsFile=/dev/null",
            "-o", "ConnectTimeout=10", "-o", "LogLevel=ERROR"]

# qemu's i440fx caps memory below the 4 GiB boundary at 0xe0000000 and
# places the rest above it. SeaBIOS boots an nvme disk only while the
# guest stays under that split; at or above it the machine starts and
# the firmware writes nothing at all. virtio and ahci are unaffected,
# as is a direct `-kernel` boot at any size. EFI has no such limit, which
# is why it is the default where firmware is installed.
SEABIOS_NVME_MEM_LIMIT = 3584


def find_firmware(arch: str, exists=None) -> tuple[str, str | None] | None:
    """The first installed EFI firmware entry for `arch`: (code, vars), with
    vars None when no variable store accompanies the image."""
    exists = exists or (lambda p: Path(p).is_file())
    for code, vars_ in EFI_FIRMWARE.get(arch, ()):
        if exists(code):
            return code, (vars_ if vars_ and exists(vars_) else None)
    return None


def resolve_firmware(arch: str, choice: str, found) -> tuple[str, str]:
    """The firmware `--vm-firmware choice` resolves to -- "uefi" or "bios" --
    and the reason to log when the run did not get what it asked for.
    Raises ValueError when the choice cannot be honoured on this host."""
    efi_only = arch != "x86_64"
    if choice == "bios":
        if efi_only:
            raise ValueError(f"--vm-firmware bios: {arch} guests have no "
                             f"non-EFI firmware")
        return "bios", ""
    if found:
        return "uefi", ""
    pkg = ("edk2-aarch64 / qemu-efi-aarch64" if efi_only
           else "edk2-ovmf / ovmf")
    if choice == "uefi" or efi_only:
        raise ValueError(f"no {arch} EFI firmware found: install {pkg}"
                         + ("" if efi_only else ", or --vm-firmware bios"))
    return "bios", f"no EFI firmware found ({pkg} installs it): booting SeaBIOS"


def pflash_format(path: str) -> str:
    return "qcow2" if path.endswith(".qcow2") else "raw"


def firmware_args(found: tuple[str, str | None], workdir: Path) -> list[str]:
    """qemu arguments for `found`: the read-only code image plus a per-run
    copy of the variable store, which the firmware writes."""
    code, vars_ = found
    if vars_ is None:
        return ["-bios", code]
    copy = workdir / ("efivars" + Path(vars_).suffix)
    shutil.copyfile(vars_, copy)
    return ["-drive", f"if=pflash,format={pflash_format(code)},unit=0,"
                      f"readonly=on,file={code}",
            "-drive", f"if=pflash,format={pflash_format(vars_)},unit=1,"
                      f"file={copy}"]


def seabios_nvme_blocked(firmware: str, bus: str, mem: int) -> bool:
    """True for the one machine SeaBIOS cannot boot: an nvme system disk at
    or above the memory split."""
    return firmware == "bios" and bus == "nvme" and mem >= SEABIOS_NVME_MEM_LIMIT


EFI_EXCEPTION = re.compile(
    r"!!!! (?:X64|IA32) Exception Type[^\r\n]*|"
    r"!!!! Synchronous Exception[^\r\n]*")


def efi_fault(console: str) -> str | None:
    """The first line of EDK2's exception dump, which it prints when a UEFI
    image faults. The machine stops there rather than resetting."""
    m = EFI_EXCEPTION.search(console)
    return m.group(0).strip() if m else None


class Target:
    """A machine a kernel is installed on and booted. The boot probes, the
    core sweep and the exercise stage need only what is defined here: shell
    commands over ssh, file transfer both ways, a console log and a wait for
    the next boot. An emulated guest and a physical box differ in how they
    are started, watched and released, not in any of that."""

    # Seconds of console silence after a reset that mean the machine never
    # began to boot, and seconds to let a reset take effect before polling.
    silence_grace = FIRMWARE_CONSOLE_GRACE
    reset_grace = 10

    def __init__(self, dest: str, port: int, key: Path | None, console: Path):
        self.dest, self.port, self.key, self.console = dest, port, key, console
        # Console bytes already written when the current wait began; silence
        # is judged past this point, not from an empty file.
        self.console_mark = 0

    def ssh_opts(self) -> list[str]:
        return [*(["-i", str(self.key)] if self.key else []), *SSH_OPTS]

    def ssh(self, cmd: str, timeout=120, check=False, sudo=False):
        if sudo:
            cmd = "sudo " + cmd
        r = run(["ssh", "-p", str(self.port), *self.ssh_opts(), self.dest,
                 cmd], timeout=timeout)
        if check and r.returncode != 0:
            raise TargetError(f"target command {cmd!r} exited {r.returncode}: "
                              f"{(r.stderr or r.stdout).strip()[-400:]}")
        return r

    def scp(self, paths: list[Path], dest: str) -> None:
        r = run(["scp", "-q", "-P", str(self.port), *self.ssh_opts(),
                 *map(str, paths), f"{self.dest}:{dest}"], timeout=600)
        if r.returncode != 0:
            raise TargetError(f"scp onto the target exited {r.returncode}: "
                              f"{(r.stderr or '').strip()[-300:]}")

    def pull(self, remote: str, dest: Path) -> bool:
        r = run(["scp", "-q", "-P", str(self.port), *self.ssh_opts(),
                 f"{self.dest}:{remote}", str(dest)], timeout=600)
        return r.returncode == 0

    def console_bytes(self) -> int:
        """Bytes the machine has written to its console so far."""
        return self.console.stat().st_size if self.console.exists() else 0

    def console_fault(self) -> str | None:
        """The firmware exception the machine stopped at, if any. Never
        one from before the current wait: a console captured continuously
        keeps an earlier boot's dump in its tail."""
        try:
            size = self.console.stat().st_size
            with open(self.console, "rb") as f:
                f.seek(max(self.console_mark, size - 4096))
                return efi_fault(f.read().decode("utf-8", "replace"))
        except OSError:
            return None

    def console_since(self, offset: int) -> str:
        """Console text written past `offset`, which is what a report has to
        explain when a boot nobody watched did not come back."""
        try:
            with open(self.console, "rb") as f:
                f.seek(offset)
                return f.read().decode("utf-8", "replace")
        except OSError as e:
            return f"(cannot read {self.console}: {e})"

    def gone(self) -> str | None:
        """Why the machine is no longer running, when the host can tell."""
        return None

    def console_stop(self) -> str | None:
        """A console marker meaning this boot will not reach ssh."""
        return None

    def silence_reason(self) -> str:
        """What console silence means on this kind of machine."""
        return "the machine never started"

    def wait_ssh(self, timeout: int, expect_boot_id: str | None = None,
                 watch_console: bool = True) -> str:
        """Wait until ssh answers; with expect_boot_id, until a new boot."""
        deadline = time.time() + timeout
        # Firmware writes to the console within seconds of the machine
        # starting. Silence past that is a machine that never began to
        # boot, not a slow guest, and waiting out the full timeout hides
        # which of the two happened.
        silent_by = time.time() + self.silence_grace if watch_console else 0
        while time.time() < deadline:
            if reason := self.gone():
                raise TargetError(f"{reason} (console: {self.console})")
            fault = self.console_fault()
            if fault:
                raise TargetError(f"the machine faulted in the firmware or in "
                                  f"a boot image it started: {fault} "
                                  f"(console: {self.console})")
            if stop := self.console_stop():
                raise TargetError(f"the boot stopped before it could answer "
                                  f"ssh: {stop} (console: {self.console})")
            if silent_by and time.time() > silent_by:
                if self.console_bytes() <= self.console_mark:
                    raise TargetError(
                        f"no console output {self.silence_grace}s after "
                        f"the machine started: {self.silence_reason()} "
                        f"(console: {self.console})")
                silent_by = 0
            r = self.ssh("cat /proc/sys/kernel/random/boot_id", timeout=20)
            bid = r.stdout.strip()
            if r.returncode == 0 and bid and bid != expect_boot_id:
                return bid
            time.sleep(5)
        raise TargetError(f"target ssh not reachable within {timeout}s "
                          f"(console: {self.console})")

    def reboot(self, timeout: int, boot_id: str) -> str:
        self.ssh("reboot", sudo=True)
        time.sleep(self.reset_grace)
        return self.wait_ssh(timeout, expect_boot_id=boot_id)

    def stop(self) -> None:
        """Release the machine at the end of the run."""


def bus_args(bus: str, ctl: str, drives: list[tuple[str, str, str]],
             boot_first: bool) -> list[str]:
    """qemu arguments attaching `drives` -- (id, drive spec, `hd`/`cd`) --
    to one controller of `bus`. The first drive takes `bootindex=0` when
    `boot_first`: without it the firmware probes the emulated controllers in
    its own order and may try the seed image, or the data disk, first."""
    boot = ["bootindex=0" if boot_first else "", *[""] * (len(drives) - 1)]
    if bus == "virtio":
        return [a for _, spec, _ in drives
                for a in ("-drive", f"if=virtio,{spec}")]
    out: list[str] = []
    if bus == "nvme":
        for i, (did, spec, _) in enumerate(drives):
            out += ["-drive", f"if=none,id={did},{spec}",
                    "-device",
                    f"nvme,drive={did},serial={did},{boot[i]}".rstrip(",")]
        return out
    if bus == "ahci":
        out += ["-device", f"ahci,id={ctl}"]
        for i, (did, spec, kind) in enumerate(drives):
            out += ["-drive", f"if=none,id={did},{spec}",
                    "-device",
                    f"ide-{kind},drive={did},bus={ctl}.{i},{boot[i]}".rstrip(",")]
        return out
    # megasas emulates a RAID controller: a raw disk lands on the physical
    # channel, which the MegaRAID firmware only serves in JBOD mode. Without
    # it the driver binds, the disk enumerates, and every command to it comes
    # back DID_BAD_TARGET -- on a gcc-built kernel as well.
    opts = ",use_jbod=on" if bus == "megasas" else ""
    # megasas's JBOD path answers SYNCHRONIZE CACHE with an internal target
    # failure, which fails every flush the filesystem issues. A drive that
    # reports no write cache is not asked to flush one.
    dopts = ",write-cache=off" if bus == "megasas" else ""
    out += ["-device", f"{bus},id={ctl}{opts}"]
    for i, (did, spec, kind) in enumerate(drives):
        out += ["-drive", f"if=none,id={did},{spec}",
                "-device",
                f"scsi-{kind},drive={did},bus={ctl}.0,scsi-id={i}{dopts},"
                f"{boot[i]}".rstrip(",")]
    return out


class VM(Target):
    def __init__(self, args, arch, disk: Path, seed: Path, accel: str):
        self.args, self.arch, self.disk, self.seed = args, arch, disk, seed
        self.accel = accel
        # `host` passes the machine's own features through; under tcg there is
        # no host to pass through, so the model is the emulator's maximum.
        self.cpu = args.vm_cpu or ("host" if accel in ("kvm", "hvf") else "max")
        found = find_firmware(args.arch)
        try:
            self.firmware, reason = resolve_firmware(
                args.arch, args.vm_firmware, found)
        except ValueError as e:
            die(str(e))
        if reason:
            log(reason)
        self.efi = found if self.firmware == "uefi" else None
        if seabios_nvme_blocked(self.firmware, args.vm_disk_bus, args.vm_mem):
            die(f"SeaBIOS cannot boot an nvme disk with {args.vm_mem} MiB of "
                f"guest memory ({SEABIOS_NVME_MEM_LIMIT} MiB and up): install "
                f"EFI firmware, or pass --vm-disk-bus virtio, or lower "
                f"--vm-mem")
        super().__init__("badc@127.0.0.1", args.ssh_port,
                         args.workdir / "vm-key",
                         args.workdir / f"console-{args.arch}.log")
        self.pidfile = args.workdir / f"vm-{args.arch}.pid"
        self.spares: list[Path] = []
        self.data_disk: Path | None = None
        self.devices: list[str] = []

    def start(self) -> None:
        args, arch = self.args, self.arch
        accel, cpu = self.accel, self.cpu
        if args.arch == "aarch64":
            machine = ["-M", f"virt,accel={accel}"]
        elif self.firmware == "uefi":
            # OVMF runs on q35, not on the i440fx qemu defaults to.
            machine = ["-machine", f"q35,accel={accel}"]
        else:
            machine = ["-machine", f"accel={accel}"]
        if self.efi:
            machine += firmware_args(self.efi, args.workdir)
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
        # Kept for the report: which controllers and NIC models the machine
        # actually carried is what a result has to be read against, and the
        # console is not that record -- a distribution whose kernel messages
        # do not reach the serial line prints none of it.
        self.devices = [a for f, a in zip(cmd, cmd[1:])
                        if f in ("-device", "-drive")]
        self.pidfile.unlink(missing_ok=True)
        run(cmd, check=True, timeout=60)

    def disk_args(self) -> list[str]:
        """The system disk, the cloud-init seed and any spare disks on
        `--vm-disk-bus`, plus the data disk `--vm-data-bus` asks for on a
        controller of its own."""
        drives = [("d0", f"format=qcow2,file={self.disk}", "hd"),
                  ("d1", f"format=raw,readonly=on,file={self.seed}", "cd")]
        drives += [(f"d{i + 2}", f"format=qcow2,file={p}", "hd")
                   for i, p in enumerate(self.spares)]
        out = bus_args(self.args.vm_disk_bus, "ctl0", drives, True)
        if self.data_disk:
            out += bus_args(self.args.vm_data_bus, "ctl1",
                            [("x0", f"format=qcow2,file={self.data_disk}",
                              "hd")], False)
        return out

    def pid(self) -> int | None:
        try:
            pid = int(self.pidfile.read_text())
            os.kill(pid, 0)
            return pid
        except (OSError, ValueError):
            return None

    def gone(self) -> str | None:
        return None if self.pid() else "qemu exited while waiting for ssh"

    def silence_reason(self) -> str:
        return (f"the firmware never ran (firmware={self.firmware}, "
                f"bus={self.args.vm_disk_bus}, vm_mem={self.args.vm_mem})")

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


# --- hardware target --------------------------------------------------------

# A physical machine takes longer than an emulated one to leave firmware:
# POST, the boot menu's timeout and a real disk all sit before the kernel.
HW_CONSOLE_GRACE = 180
HW_RESET_GRACE = 20


def baud_constant(baud: int) -> int:
    """The termios speed constant for `baud`."""
    try:
        return getattr(termios, f"B{baud}")
    except AttributeError:
        raise ValueError(f"termios has no B{baud}; supported: " + ", ".join(
            n[1:] for n in sorted(dir(termios))
            if re.fullmatch(r"B\d+", n))) from None


class SerialConsole:
    """Reads a serial port into a log file byte for byte, giving a physical
    machine the console a qemu `-serial file:` guest has, so the same
    scanners read both.

    The line settings are applied to the descriptor that does the reading.
    An open() resets a port's termios on macOS, so a speed set by a separate
    `stty` call is gone before the first byte arrives and the line then
    delivers plausible-looking garbage rather than silence. The port carries
    a console, and on this lane a root shell, so nothing is written to it
    except an explicit SysRq request."""

    def __init__(self, device: str, baud: int, path: Path):
        self.device, self.baud, self.path = device, baud, path
        self.speed = baud_constant(baud)
        self.fd = -1
        self.reopens = 0
        self.bytes = 0
        self._stop = threading.Event()
        self._thread: threading.Thread | None = None

    def _open(self) -> None:
        self.fd = os.open(self.device, os.O_RDWR | os.O_NOCTTY | os.O_NONBLOCK)
        attrs = termios.tcgetattr(self.fd)
        cc = list(attrs[6])
        cc[termios.VMIN], cc[termios.VTIME] = 0, 1
        # 8N1, receiver on, modem lines ignored, no input, output or line
        # processing: the log is to hold what the wire carried.
        termios.tcsetattr(self.fd, termios.TCSANOW,
                          [0, 0, termios.CS8 | termios.CREAD | termios.CLOCAL,
                           0, self.speed, self.speed, cc])
        termios.tcflush(self.fd, termios.TCIFLUSH)

    def _close(self) -> None:
        if self.fd >= 0:
            try:
                os.close(self.fd)
            except OSError:
                pass
            self.fd = -1

    def _pump(self) -> None:
        with open(self.path, "wb", buffering=0) as sink:
            while not self._stop.is_set():
                try:
                    data = os.read(self.fd, 4096)
                except BlockingIOError:
                    data = b""
                except OSError:
                    # The adapter re-enumerated or was unplugged. Reopening
                    # keeps the rest of the boot on record.
                    self._close()
                    self.reopens += 1
                    time.sleep(1)
                    try:
                        self._open()
                    except OSError:
                        pass
                    continue
                if data:
                    sink.write(data)
                    self.bytes += len(data)
                else:
                    time.sleep(0.05)

    def start(self) -> None:
        self._open()
        self._thread = threading.Thread(target=self._pump, daemon=True)
        self._thread.start()

    def stop(self) -> None:
        self._stop.set()
        if self._thread:
            self._thread.join(timeout=5)
        self._close()

    def sysrq(self, keys: str) -> None:
        """Magic SysRq over the serial line: a BREAK puts the port in SysRq
        mode and the next character is the command. Best-effort -- it needs
        a kernel that still services interrupts and a `kernel.sysrq` mask
        that permits the command -- but it is the only remote reset a
        machine with a battery has."""
        if self.fd < 0:
            raise OSError(f"{self.device} is not open")
        for k in keys:
            termios.tcsendbreak(self.fd, 0)
            time.sleep(0.3)
            os.write(self.fd, k.encode())
            time.sleep(1.0)

    def stats(self) -> dict:
        return {"device": self.device, "baud": self.baud,
                "bytes": self.bytes, "reopens": self.reopens,
                "log": str(self.path)}


class HwTarget(Target):
    """A physical machine reached over ssh, with its console read from a
    serial port on the host. It has no remote power cut -- the box under
    test is a laptop -- so recovery rests on the standing boot default and
    the chipset watchdog, and every kernel under test is selected for one
    boot only."""

    silence_grace = HW_CONSOLE_GRACE
    reset_grace = HW_RESET_GRACE

    def __init__(self, args, console: Path,
                 serial: SerialConsole | None = None):
        super().__init__(args.hw_host, args.hw_port, args.hw_key, console)
        self.args, self.serial = args, serial

    def console_stop(self) -> str | None:
        _, verdict, at = console_stop(self.console_since(self.console_mark))
        return f"{verdict}: {at}" if verdict else None

    def silence_reason(self) -> str:
        if self.serial is None:
            return "no serial console was attached to observe the reset"
        return (f"the machine did not restart, or {self.serial.device} "
                f"stopped delivering")

    def reboot(self, timeout: int, boot_id: str) -> str:
        # The console is captured continuously, so silence after a reset is
        # measured from where the log stood when the reset was ordered.
        self.console_mark = self.console_bytes()
        return super().reboot(timeout, boot_id)


# Core file directory and pattern. A plain file pattern (not the distro's
# systemd-coredump pipe) makes cores land as extractable files; the sweep
# also checks coredumpctl in case a pipe pattern is still in force.
CORE_DIR = "/var/crash"
CORE_PATTERN = f"{CORE_DIR}/core.%e.%p.%t"


def configure_core_capture(vm: Target) -> dict:
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


def sweep_cores(args, vm: Target, phase: str,
                findings: list[str]) -> list[dict]:
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


def grub_entry(vm: Target, release: str) -> str | None:
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


# Every driver bound between a block device and the bus it sits on. The SCSI
# disk driver alone names no controller, so the chain is what a storage model
# is checked against.
DRIVER_CHAIN = (
    "d=/sys/class/block/$dev/device; c=''; for _ in $(seq 16); do "
    'r=$(readlink -f $d) || break; [ "$r" = / ] && break; '
    '[ -e $d/driver ] && c="$c $(basename $(readlink -f $d/driver))"; '
    "d=$d/..; done")

ROOT_DEV = (
    "src=$(findmnt -no SOURCE / | sed 's/\\[.*//'); "
    'dev=$(lsblk -no PKNAME "$src" | head -1); '
    '[ -n "$dev" ] || dev=$(basename "$src")')

DATA_MOUNT = "/mnt/badc-data"


def data_disk_dev(listing: str, driver: str, root_dev: str) -> str | None:
    """The block device the data controller's driver is bound to.

    `listing` is one `<name>:<chain>` line per whole disk. The root disk is
    excluded by name rather than by driver, because a data controller of the
    same model as the root one binds the same driver.
    """
    for line in listing.splitlines():
        name, _, chain = line.partition(":")
        name = name.strip()
        if not name or name == root_dev:
            continue
        if driver in chain.split():
            return name
    return None


def probe_data_disk(vm: Target, bus: str) -> dict:
    """Bind, format, write, re-read and check a filesystem on the disk the
    `bus` controller carries. A controller the firmware cannot boot from is
    still a driver the badc-built kernel has to bring up; this is how that
    driver is exercised when it cannot carry the root."""
    driver = DISK_BUSES[bus]
    root_dev = vm.ssh(f"{ROOT_DEV}; echo $dev", check=True).stdout.strip()
    listing = vm.ssh(
        "for dev in $(lsblk -dno NAME); do "
        "case $dev in zram*|sr*|loop*|fd*) continue;; esac; "
        f'{DRIVER_CHAIN}; echo "$dev:$c"; done').stdout
    dev = data_disk_dev(listing, driver, root_dev)
    out = {"bus": bus, "expect_driver": driver, "root_dev": root_dev,
           "listing": listing.split(), "dev": dev}
    if dev is None:
        out["io_ok"] = False
        return out
    out["driver"] = next(
        (ln.partition(":")[2].strip() for ln in listing.splitlines()
         if ln.partition(":")[0].strip() == dev), "")
    # One `sh -c` under sudo: `sudo` elevates the command it is given, not
    # the rest of a `;`-separated line.
    script = (
        f"set -e; mkfs.ext4 -q -F /dev/{dev}; mkdir -p {DATA_MOUNT}; "
        f"mount /dev/{dev} {DATA_MOUNT}; "
        f"dd if=/dev/urandom of={DATA_MOUNT}/probe bs=1M count=64 "
        f"conv=fsync 2>/dev/null; sha256sum {DATA_MOUNT}/probe; "
        f"umount {DATA_MOUNT}; echo 3 > /proc/sys/vm/drop_caches; "
        f"mount /dev/{dev} {DATA_MOUNT}; sha256sum {DATA_MOUNT}/probe; "
        f"umount {DATA_MOUNT}; e2fsck -fn /dev/{dev} >/dev/null")
    r = vm.ssh("sh -c " + shlex.quote(script), sudo=True, timeout=900)
    sums = re.findall(r"^([0-9a-f]{64}) ", r.stdout, re.M)
    out["io_ok"] = (r.returncode == 0 and len(sums) == 2
                    and sums[0] == sums[1])
    if not out["io_ok"]:
        out["error"] = (r.stderr or r.stdout).strip()[-300:]
    return out


def probes(vm: Target) -> dict:
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
    # Everything the kernel logged at KERN_ERR or worse. The severity
    # vocabulary above is the set of faults named in advance; this is the net
    # for a driver fault nobody wrote a pattern for, and the stock boot of the
    # same image is what says which of these lines are the image's own.
    err = vm.ssh("dmesg --level=emerg,alert,crit,err", sudo=True, timeout=120)
    out["dmesg_err"] = (sorted(set(exercise.normalize_log(err.stdout)))
                        if err.returncode == 0 else None)
    out["net_route"] = vm.ssh(
        "ip -o route show default").stdout.strip()
    out["net_driver"] = vm.ssh(
        "ls -l /sys/class/net/*/device/driver 2>/dev/null | "
        "sed 's/.*\\///' | sort -u | tr '\\n' ' '").stdout.strip()
    out["blk"] = vm.ssh("lsblk -dno NAME,SIZE,TRAN | tr '\\n' ' '").stdout.strip()
    out["disk_driver"] = vm.ssh(
        f"{ROOT_DEV}; {DRIVER_CHAIN}; echo $c").stdout.strip()
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
        raise TargetError(f"selfhost tool install exited {r.returncode}: "
                      f"{(r.stdout + r.stderr).strip()[-400:]}")
    vm.ssh(f"mkdir -p {SELFHOST_DIR}", check=True)
    log(f"selfhost: pushing badc, the shims and {args.tarball.name}")
    vm.scp([args.badc, LINUX_DIR / "buildcc.py", LINUX_DIR / "ldshim.py",
            args.tarball], SELFHOST_DIR)
    vm.ssh(f"chmod +x {SELFHOST_DIR}/badc {SELFHOST_DIR}/buildcc.py "
           f"{SELFHOST_DIR}/ldshim.py", check=True)
    ver = vm.ssh(f"{SELFHOST_DIR}/badc --version", check=True).stdout.strip()
    if not names_badc(ver):
        raise TargetError(f"the pushed badc does not run in the guest: "
                          f"{ver[:200]}")
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
        raise TargetError(f"tarball extract in the guest exited "
                          f"{r.returncode}: "
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
        raise TargetError(f"make {target} in the guest exited "
                          f"{r.returncode}: " +
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
                raise TargetError("qemu exited during the in-guest build "
                              f"(console: {vm.console})")
            silent = round(time.time() - silent_since)
            if silent > args.vm_timeout:
                raise TargetError(f"the guest stopped answering ssh for "
                                  f"{silent}s "
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
    raise TargetError(f"the in-guest build did not finish within "
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


PHASES = ("config", "tree", "build", "package", "vm", "hw", "selfhost")


def resolve_phases(spec: str, release: str | None,
                   hw_host: str | None) -> tuple[set[str], bool]:
    """The phases `spec` names and whether they need a kernel tree. Raises
    ValueError on a combination that cannot be run."""
    phases = set(spec.split(","))
    if unknown := phases - set(PHASES):
        raise ValueError(f"unknown phases: {sorted(unknown)}")
    if "selfhost" in phases and "vm" not in phases:
        raise ValueError("the selfhost phase runs inside the vm phase and "
                         "needs it")
    if "hw" in phases and not hw_host:
        raise ValueError("the hw phase needs --hw-host")
    if release and {"tree", "build", "package"} & phases:
        raise ValueError("--release names the release an already-built "
                         "package carries; the build phases take it from "
                         "the tree")
    # The build phases work on the tree, and without --release it is also
    # where the release comes from.
    needs_tree = bool({"tree", "build", "package", "selfhost"} & phases
                      or (phases - {"config"} and not release))
    return phases, needs_tree


def install_cmd(arch, packages: list[Path], extra: str = "") -> str:
    """The distribution's command to install `packages` from files.

    A kernel is an install-only package, so a build of an older release
    than the one already present is added beside it rather than upgraded
    over it -- but rpm still refuses the older version without being told
    that is the intent, and the corpus release trails the distribution's
    own on any machine that has been updated.
    """
    tool = "dpkg -i" if arch["pkg"] == "deb" else "rpm -ivh --oldpackage"
    names = " ".join(shlex.quote(p.name) for p in packages)
    return " ".join(filter(None, (tool, extra, names)))


def new_kernel_errors(base: dict, cur: dict) -> list[str] | None:
    """KERN_ERR-or-worse lines the kernel under test logged and the stock boot
    of the same image did not. None when either log was unreadable."""
    if base.get("dmesg_err") is None or cur.get("dmesg_err") is None:
        return None
    seen = set(base["dmesg_err"])
    return [l for l in cur["dmesg_err"] if l not in seen]


def assert_boot(args, vm: Target, base: dict, cur: dict, result: dict,
                failures: list[str]) -> bool:
    """The checks every lane makes on the kernel it just booted: the release,
    the compiler that built it, systemd, taint, the kernel log, and disk and
    network I/O. Returns False when the machine is not running the kernel
    under test, which makes every later check meaningless. The devices are
    the caller's: what a driver must bind to is a property of the machine."""
    if cur["uname"] != args.release:
        failures.append(f"booted {cur['uname']}, expected {args.release}")
        return False
    # The banner is CONFIG_CC_VERSION_TEXT, captured from
    # `$(CC) --version | head -n1` at configure time. buildcc.py answers that
    # with badc's identification, so a kernel whose C units are badc's must
    # say so in /proc/version and in the boot banner. Both surfaces are
    # asserted: they come from the same string, and a disagreement means the
    # recorded config and the running image were built from different Kconfig
    # runs.
    result["compiler_id"] = {
        "banner": cur["proc_version"],
        "dmesg_banner": cur["dmesg_banner"],
        "names_badc": names_badc(cur["proc_version"]),
    }
    if args.expect_producer != "badc":
        log(f"compiler-id (not asserted): {cur['proc_version'][:120]}")
    elif not result["compiler_id"]["names_badc"]:
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
        failures.append(f"systemd degraded under the kernel under test "
                        f"only: {failed}")
    if cur["taint"] != "0":
        failures.append(f"kernel tainted: {cur['taint']}")
    if cur["dmesg_severe"]:
        failures.append(f"dmesg severe patterns: "
                        f"{cur['dmesg_severe'][:3]}")
    if cur["dmesg_warn"] > base["dmesg_warn"]:
        failures.append(f"dmesg WARNING count {cur['dmesg_warn']} exceeds "
                        f"stock baseline {base['dmesg_warn']}")
    # Reported, not asserted: the baseline is the image's stock kernel, a
    # different version, and a version gap introduces error lines of its own
    # (a driver registered twice, a platform feature the older kernel did not
    # probe for). The named vocabulary above is what fails a boot; this is
    # what a reader compares when it does not.
    result["dmesg_err_new"] = new_kernel_errors(base, cur)
    if result["dmesg_err_new"] is None:
        failures.append("the kernel error log was not readable "
                        "(dmesg --level); no cover on driver-reported faults")
    elif result["dmesg_err_new"]:
        log(f"{len(result['dmesg_err_new'])} kernel error line(s) the stock "
            f"boot did not log: {result['dmesg_err_new'][:5]}")
    if not cur["disk_rw"]:
        failures.append("disk write/readback failed")
    if not cur["net_route"]:
        failures.append("no default route")
    return True


def assert_package_products(args, arch, vm: Target, result: dict,
                            failures: list[str]) -> None:
    """What the package's scriptlets had to produce -- depmod data and an
    initramfs -- and that the packaged modules load on demand."""
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
        "dmesg | grep -m1 -i 'unpacking initramfs'", sudo=True).stdout.strip()

    builtin = builtin_modules(
        vm.ssh(f"cat /lib/modules/{args.release}/modules.builtin").stdout)
    loads = {}
    for mod in arch["modprobe"]:
        r = vm.ssh(f"modprobe {mod}", sudo=True, timeout=300)
        loads[mod] = state = module_state(mod, vm.ssh("lsmod").stdout, builtin)
        if r.returncode != 0 or state == "absent":
            failures.append(f"modprobe {mod}: rc={r.returncode} "
                            f"state={state} "
                            f"{(r.stderr or '').strip()[-200:]}")
    result["modprobe"] = loads
    after = vm.ssh("cat /proc/sys/kernel/tainted").stdout.strip()
    if after != "0":
        failures.append(f"kernel tainted after module loads: {after}")


def builtin_modules(text: str) -> set[str]:
    """The module names `modules.builtin` records, which modules_install
    ships beside modules.dep. Lines are kbuild paths (`kernel/fs/btrfs/
    btrfs.ko`)."""
    return {Path(ln).stem.replace("-", "_") for ln in text.split() if ln}


def module_state(mod: str, lsmod: str, builtin: set[str]) -> str:
    """Where a name the gate asks for ended up: `loaded` as a module,
    `builtin` in the image, or `absent`. A distribution configuration
    builds in what defconfig leaves modular, so lsmod alone does not
    answer whether the subsystem is there."""
    key = mod.replace("-", "_")
    if any(ln.split()[:1] == [key] for ln in lsmod.splitlines()[1:]):
        return "loaded"
    return "builtin" if key in builtin else "absent"


GUEST_SCRATCH = "/tmp/badc-guest"


def run_guest_script(args, vm: Target, failures: list[str]) -> dict:
    """Run `--vm-guest-script` in the booted kernel with `--vm-guest-file`
    beside it. The verdict is the script's own exit status; its output is
    recorded either way."""
    vm.ssh(f"mkdir -p {GUEST_SCRATCH}", check=True)
    vm.scp([args.vm_guest_script, *args.vm_guest_file], GUEST_SCRATCH + "/")
    name = args.vm_guest_script.name
    r = vm.ssh(f"sh -c {shlex.quote(f'cd {GUEST_SCRATCH} && sh ./{name}')}",
               sudo=True, timeout=args.vm_timeout)
    out = {"script": name, "rc": r.returncode,
           "stdout": r.stdout, "stderr": r.stderr}
    log(f"guest script {name}: rc={r.returncode}")
    for line in r.stdout.splitlines():
        log(f"  {line}")
    if r.returncode != 0:
        failures.append(f"guest script {name} exited {r.returncode}: "
                        f"{(r.stderr or r.stdout).strip()[-300:]}")
    return out


def phase_vm(args, arch, packages: list[Path], failures: list[str]) -> dict:
    image = ensure_image(args, arch)
    accel = resolve_accel(args, arch)
    seed = make_seed(args)
    disk = args.workdir / f"disk-{args.arch}.qcow2"
    disk.unlink(missing_ok=True)
    run(["qemu-img", "create", "-q", "-f", "qcow2", "-b", str(image.resolve()),
         "-F", "qcow2", str(disk), args.vm_disk], check=True)

    vm = VM(args, arch, disk, seed, accel)
    if args.vm_data_bus:
        data = args.workdir / f"data-{args.arch}.qcow2"
        data.unlink(missing_ok=True)
        run(["qemu-img", "create", "-q", "-f", "qcow2", str(data), "3G"],
            check=True)
        vm.data_disk = data
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
                    "disk_bus": args.vm_disk_bus, "nic": args.vm_nic,
                    "data_bus": args.vm_data_bus, "firmware": vm.firmware,
                    "devices": vm.devices,
                    # Which bytes produced this verdict. A vm-only run takes
                    # the package from wherever --package points, and a later
                    # build phase in the same workdir replaces it; without
                    # the digest here a result cannot be traced back to an
                    # artefact, let alone re-run against it.
                    "installed": [{"name": p.name, "sha256": sha256_of(p)}
                                  for p in packages]}
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
        r = vm.ssh(install_cmd(arch, packages, args.install_args), sudo=True,
                   timeout=args.install_timeout)
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

        if not assert_boot(args, vm, base, cur, result, failures):
            return result
        want_nic = NICS[args.vm_nic]
        if want_nic not in cur["net_driver"].split():
            failures.append(f"network device not on {want_nic}: "
                            f"{cur['net_driver']!r}")
        want_disk = DISK_BUSES[args.vm_disk_bus]
        if want_disk not in cur["disk_driver"].split():
            failures.append(f"root disk not on {want_disk}: "
                            f"{cur['disk_driver']!r}")
        if args.vm_data_bus:
            data = probe_data_disk(vm, args.vm_data_bus)
            result["data_disk"] = data
            log(f"data disk on {data['bus']}: dev={data['dev']} "
                f"driver={data.get('driver', '')!r} io_ok={data['io_ok']}")
            if data["dev"] is None:
                failures.append(
                    f"no block device bound to {data['expect_driver']} for "
                    f"the {data['bus']} data disk: {data['listing']}")
            elif not data["io_ok"]:
                failures.append(f"data disk on {data['bus']} "
                                f"({data['dev']}): {data.get('error', '')}")

        assert_package_products(args, arch, vm, result, failures)
        if args.vm_guest_script:
            result["guest_script"] = run_guest_script(args, vm, failures)

        # The gate set runs on every boot; --exercise widens it. Without it
        # a boot is judged by what the guest's own init reported.
        if steps := exercise.selected_steps(args):
            result["exercise"] = exercise.run(args, vm, arch, args.release,
                                              failures, log, steps)

        # Sweep for cores produced under the badc kernel (services, udev,
        # modprobe). A kernel-side oops/panic leaves no userspace core; the
        # qemu console log is that record and is kept regardless.
        result["cores_badc"] = sweep_cores(args, vm, "badc", failures)
        if not result["cores_badc"]:
            log("no userspace cores under the badc kernel")

        if args.selfhost:
            result["selfhost"].update(
                phase_selfhost(args, arch, vm, failures))
    except TargetError as e:
        failures.append(str(e))
    finally:
        try:
            vm.stop()
        except Exception as e:  # teardown must not mask the verdict
            log(f"vm teardown: {e}")
    return result


# --- hardware lane ----------------------------------------------------------

# Console text kept in the report when a boot has to be explained from the
# wire alone.
HW_CONSOLE_TAIL = 8000

# SysRq sequence for a reset that gives the filesystems a chance: sync,
# remount read-only, boot.
SYSRQ_RESET = "sub"

# What a boot puts on a serial console, in the order it reaches them. The
# furthest one seen names the stage a boot that never returned died in.
BOOT_STAGES = (
    ("firmware", re.compile(r"BdsDxe|UEFI Interactive Shell|"
                            r"Press \S+ to enter")),
    ("bootloader", re.compile(r"GNU GRUB|Booting `|Loading Linux ")),
    ("earlycon", re.compile(r"earlycon:")),
    ("kernel", re.compile(r"Linux version \d")),
    ("initramfs", re.compile(r"[Uu]npacking initramfs|dracut-|"
                             r"Reached target .*[Ii]nitrd")),
    ("userspace", re.compile(r"systemd\[1\]:|Welcome to ")),
    ("multi-user", re.compile(r"login:|"
                             r"Reached target .*[Mm]ulti-?[- ]?[Uu]ser")),
)

# What the kernel says when something went wrong, whether or not the boot
# continued past it.
BOOT_FAULT = re.compile(r"Kernel panic[^\r\n]*|BUG: [^\r\n]*|"
                        r"Oops[:#][^\r\n]*|Internal error:[^\r\n]*|"
                        r"Unable to mount root fs[^\r\n]*")

# How a boot ends when it ends badly, as a named outcome with the verdict it
# carries. These are distinct results, not variants of "ssh never returned":
# each says something different about where to look. A failed boot leaves no
# journal -- emergency mode never flushes one -- so the console is the only
# record any of them has.
BOOT_STOPS = (
    ("emergency",
     "the boot dropped to the initramfs emergency shell: the root "
     "filesystem was not mounted",
     re.compile(r"Entering emergency mode[^\r\n]*|"
                r"Cannot open access to console[^\r\n]*|"
                r"emergency\.target|Emergency Mode")),
    ("panic", "the kernel panicked",
     re.compile(r"Kernel panic - not syncing[^\r\n]*")),
    ("dracut-shell", "the boot stopped in the dracut shell",
     re.compile(r"dracut:/#")),
)


def console_stop(text: str) -> tuple[str, str, str]:
    """The named outcome that ended this boot, its verdict and the console
    text that said so. The earliest marker wins, so a panic is not reported
    as the emergency shell that followed it."""
    best = None
    for name, verdict, rx in BOOT_STOPS:
        m = rx.search(text)
        if m and (best is None or m.start() < best[0]):
            best = (m.start(), name, verdict, m.group(0).strip())
    return best[1:] if best else ("", "", "")


def console_stage(text: str) -> dict:
    """How far a boot got on the console, the first fault it reported, and
    the named outcome that ended it."""
    reached = [name for name, rx in BOOT_STAGES if rx.search(text)]
    fault = BOOT_FAULT.search(text)
    outcome, verdict, at = console_stop(text)
    return {"stage": reached[-1] if reached else "none", "reached": reached,
            "fault": fault.group(0).strip() if fault else "",
            "outcome": outcome, "verdict": verdict, "stopped_at": at}


def entry_release(kernel: str) -> str:
    """The release a boot entry's kernel path names."""
    name = kernel.strip().strip('"').rsplit("/", 1)[-1]
    for prefix in ("vmlinuz-", "vmlinux-", "Image-"):
        if name.startswith(prefix):
            return name[len(prefix):]
    return ""


GRUBBY_KV = re.compile(r'^(\w+)=(?:"(.*)"|(.*))$')


def grubby_entries(text: str) -> list[dict]:
    """The entry blocks `grubby --info=ALL` prints, in the order it prints
    them. `index` opens each block."""
    entries: list[dict] = []
    cur: dict = {}
    for line in text.splitlines():
        m = GRUBBY_KV.match(line.strip())
        if not m:
            continue
        key = m.group(1)
        if key == "index" and cur:
            entries.append(cur)
            cur = {}
        cur[key] = m.group(2) if m.group(2) is not None else m.group(3)
    if cur:
        entries.append(cur)
    return entries


def grubby_index(entries: list[dict], release: str) -> int | None:
    """The boot index of the entry that loads vmlinuz-<release>."""
    for e in entries:
        if entry_release(e.get("kernel", "")) == release:
            try:
                return int(e["index"])
            except (KeyError, ValueError):
                return None
    return None


def entry_root(entry: dict) -> str:
    """The root device a boot entry names, from grubby's own `root` field or
    from a root= in its arguments."""
    if root := entry.get("root", "").strip():
        return root
    m = re.search(r"(?:^|\s)root=(\S+)", entry.get("args", ""))
    return m.group(1) if m else ""


def entry_bootable(entry: dict) -> str | None:
    """Why booting this entry cannot work. An entry with no root device
    reaches the initramfs and parks in an emergency shell, which on a
    machine with no remote power cut costs a trip to it. `kernel-install`
    writes the entry from /etc/kernel/cmdline, so an installed kernel
    inherits whatever that file omits."""
    if not entry_root(entry):
        return (f"the entry names no root device (grubby root= empty and no "
                f"root= in its arguments), so it cannot mount a root "
                f"filesystem: {entry.get('args', '')[:120]!r}")
    return None


def cc_version_text(config: str) -> str:
    """CONFIG_CC_VERSION_TEXT out of a kernel configuration: the compiler
    that built the kernel the configuration belongs to."""
    m = re.search(r'^CONFIG_CC_VERSION_TEXT="(.*)"$', config, re.M)
    return m.group(1) if m else ""


def fallback_refusal(default_kernel: str, release: str,
                     cc_version: str) -> str | None:
    """Why this machine must not be booted into `release`. The standing boot
    default is the only recovery a box with no remote power cut has, so it
    has to be a kernel the run neither replaces nor built."""
    rel = entry_release(default_kernel)
    if not rel:
        return (f"the standing boot default is not a kernel entry: "
                f"{default_kernel!r}")
    if rel == release:
        return (f"the standing boot default is {rel}, the kernel under test: "
                f"a failed boot would fall back to itself")
    if names_badc(cc_version):
        return (f"the standing boot default {rel} was built by badc "
                f"({cc_version[:80]}): the fallback has to be a "
                f"distribution kernel")
    return None


def hw_identity(tgt: Target) -> dict:
    """What the machine is, recorded next to the boot verdict so a hardware
    run is diffable against a VM run."""
    def dmi(field: str) -> str:
        return tgt.ssh(f"dmidecode -s {field} 2>/dev/null | grep -v '^#'",
                       sudo=True).stdout.strip()
    sb = tgt.ssh("mokutil --sb-state 2>/dev/null || "
                 "bootctl status 2>/dev/null | grep -i 'secure boot'").stdout
    return {
        "vendor": dmi("system-manufacturer"),
        "model": dmi("system-product-name"),
        "bios": " ".join(filter(None, (dmi("bios-vendor"), dmi("bios-version"),
                                       dmi("bios-release-date")))),
        "cpu": tgt.ssh("grep -m1 'model name' /proc/cpuinfo | "
                       "cut -d: -f2-").stdout.strip(),
        "firmware": ("uefi" if tgt.ssh("test -d /sys/firmware/efi").returncode
                     == 0 else "bios"),
        "secure_boot": sb.strip().splitlines()[0].strip() if sb.strip()
                       else "unknown",
        "watchdog": tgt.ssh("wdctl 2>/dev/null | "
                            "awk -F: '/Identity|Timeout/{print $2}' | "
                            "tr -s ' \\n' ' '", sudo=True).stdout.strip(),
    }


def hw_default_kernel(tgt: Target) -> str:
    return tgt.ssh("grubby --default-kernel", sudo=True).stdout.strip()


def hw_clear_oneshot(tgt: Target) -> str:
    """Drop any pending one-shot selection, so the next boot is the standing
    default whatever this run did."""
    for tool in ("grub2-editenv", "grub-editenv"):
        r = tgt.ssh(f"{tool} - unset next_entry", sudo=True, timeout=60)
        if r.returncode == 0:
            return f"{tool}: cleared"
    return (r.stderr or r.stdout).strip()[-200:] or "unreachable"


def hw_recover(args, tgt: HwTarget, result: dict, failures: list[str]) -> None:
    """The machine did not answer. Record what the console last showed, then
    establish which of the two happened: the kernel under test wedged, or the
    box is gone. The watchdog resets a wedged kernel and the one-shot
    selection expires with the boot that consumed it, so a box that is merely
    wedged comes back on the standing default by itself."""
    since = tgt.console_since(tgt.console_mark)
    result["console_stage"] = console_stage(since)
    result["console_tail"] = since[-HW_CONSOLE_TAIL:]
    stage = result["console_stage"]
    log(f"console: reached {stage['stage']}"
        + (f"; {stage['verdict']} ({stage['stopped_at']})"
           if stage["outcome"] else "")
        + (f"; fault: {stage['fault']}" if stage["fault"] else ""))
    # Two ways back, cheapest first: the watchdog resetting a kernel that
    # stopped petting it, then a SysRq reset over the serial line for a boot
    # that parked where the watchdog was never armed -- an initramfs
    # emergency shell runs a systemd that never read the watchdog
    # configuration, because that lives on the filesystem it failed to mount.
    back_to = result.get("boot_default") or "the standing default"
    attempts = [("the watchdog and the one-shot expiry", "")]
    if args.hw_sysrq and tgt.serial:
        attempts.append(("a SysRq reset over the serial line", SYSRQ_RESET))
    last = ""
    for how, keys in attempts:
        if keys:
            log(f"sending SysRq {keys!r} over {tgt.serial.device}")
            try:
                tgt.serial.sysrq(keys)
            except OSError as e:
                log(f"SysRq over {tgt.serial.device}: {e}")
                continue
        log(f"waiting up to {args.hw_recover_timeout}s for the machine to "
            f"come back on {back_to} ({how})")
        # What follows is a different boot: the markers that ended the last
        # one must not end this wait too.
        tgt.console_mark = tgt.console_bytes()
        try:
            tgt.wait_ssh(args.hw_recover_timeout, watch_console=False)
        except TargetError as e:
            last = str(e)
            continue
        back = tgt.ssh("uname -r").stdout.strip()
        result["recovered"], result["recovered_by"] = True, how
        result["recovered_uname"] = back
        if back == args.release:
            failures.append(f"the machine came back on {back}, the kernel "
                            f"under test: the one-shot selection did not "
                            f"expire")
        else:
            log(f"recovered on {back} through {how}")
        return
    result["recovered"] = False
    seen = (f"the console last reached {stage['stage']}"
            + (f" and {stage['verdict']} ({stage['stopped_at']})"
               if stage["outcome"] else "")
            + (f": {stage['fault']}" if stage["fault"] else "")
            if stage["stage"] != "none"
            else "the console recorded nothing from this boot, so a wedged "
                 "kernel and a box that is gone read the same")
    failures.append(f"the machine did not come back after the failed boot; "
                    f"{seen} ({last})")


def phase_hw(args, arch, packages: list[Path], failures: list[str]) -> dict:
    """Install the packages on a physical machine, boot the kernel they carry
    for exactly one boot, and run the probes and the exercise stage the vm
    lane runs. The console is read from a serial port on this host."""
    console = args.workdir / f"console-hw-{args.arch}.log"
    serial = None
    if args.hw_serial:
        serial = SerialConsole(args.hw_serial, args.hw_baud, console)
        try:
            serial.start()
        except (OSError, ValueError) as e:
            die(f"cannot read the console from {args.hw_serial}: {e} "
                f"(on macOS use the /dev/cu.* node, not /dev/tty.*, which "
                f"blocks waiting for carrier detect)")
        log(f"serial console: {args.hw_serial} at {args.hw_baud} "
            f"-> {console}")
    else:
        console.write_bytes(b"")
        log("no --hw-serial: a boot that does not reach ssh leaves no record")
    tgt = HwTarget(args, console, serial)
    result: dict = {"console": str(console),
                    "serial": serial.stats() if serial else None}
    try:
        boot_id = tgt.wait_ssh(args.hw_timeout, watch_console=False)
        result["target"] = hw_identity(tgt)
        result["firmware"] = result["target"]["firmware"]
        log(f"target: {result['target']['vendor']} "
            f"{result['target']['model']}, bios {result['target']['bios']}, "
            f"{result['firmware']}")

        # The standing default is the recovery. Establish it before anything
        # is installed, so a run that must not proceed has changed nothing.
        default = hw_default_kernel(tgt)
        result["boot_default"] = default
        cfg = tgt.ssh(f"cat /boot/config-{entry_release(default)} 2>/dev/null",
                      sudo=True).stdout
        if refusal := fallback_refusal(default, args.release,
                                       cc_version_text(cfg)):
            failures.append(f"refusing to boot {args.release}: {refusal}")
            return result
        log(f"standing default: {default} (the fallback)")

        result["core_capture"] = configure_core_capture(tgt)
        base = probes(tgt)
        result["stock"] = base
        log(f"stock: uname={base['uname']} systemd={base['systemd_state']} "
            f"modules={len(base['modules'])} disk={base['disk_driver']!r} "
            f"net={base['net_driver']!r}")
        result["cores_stock"] = sweep_cores(args, tgt, "stock", failures)

        suffix = "." + arch["pkg"]
        packages = [p for p in packages if p.suffix == suffix]
        if not packages:
            failures.append(f"no {suffix} package to install on "
                            f"{arch['distro']}")
            return result
        log(f"installing {', '.join(p.name for p in packages)}")
        tgt.scp(packages, "")
        r = tgt.ssh(install_cmd(arch, packages, args.install_args), sudo=True,
                    timeout=args.install_timeout)
        result["install_rc"] = r.returncode
        result["install_tail"] = (r.stdout + r.stderr).strip()[-2000:]
        if r.returncode != 0:
            failures.append(f"package install exited {r.returncode}: "
                            f"{result['install_tail'][-300:]}")
            return result

        # Installing a kernel makes its own entry the default on a BLS
        # distribution. The standing default is the recovery, so it goes
        # back before anything selects a one-shot: an install alone must
        # never change what the machine boots on its own.
        moved = hw_default_kernel(tgt)
        result["boot_default_after_install"] = moved
        if moved != default:
            r = tgt.ssh(f"grubby --set-default {shlex.quote(default)}",
                        sudo=True)
            result["boot_default_restored"] = r.returncode == 0
            if r.returncode != 0:
                failures.append(f"the install moved the standing default to "
                                f"{moved}, and it could not be put back: "
                                f"{(r.stderr or r.stdout).strip()[-200:]}")
                return result
            log(f"the install moved the standing default to {moved}; "
                f"restored {default}")

        entries = grubby_entries(tgt.ssh("grubby --info=ALL",
                                         sudo=True).stdout)
        result["boot_entries"] = len(entries)
        index = grubby_index(entries, args.release)
        if index is None:
            failures.append(f"no boot entry loads vmlinuz-{args.release} "
                            f"after the install ({len(entries)} entries)")
            return result
        entry = entries[index] if index < len(entries) else {}
        result["boot_entry_root"] = entry_root(entry)
        # Checked before the reset, not after: a boot that cannot mount a
        # root filesystem leaves the machine in a state only someone at it
        # can end.
        if why := entry_bootable(entry):
            failures.append(f"refusing to boot entry {index} "
                            f"({args.release}): {why}")
            return result
        # One boot only: never the standing default, so any failure -- a hang
        # the watchdog resets included -- comes back on the distribution
        # kernel without anyone at the machine.
        tgt.ssh(f"grub2-reboot {index}", sudo=True, check=True)
        result["boot_select"] = f"grub2-reboot one-shot: index {index}"
        log(f"rebooting into {args.release} ({result['boot_select']})")

        try:
            tgt.reboot(args.hw_timeout, boot_id)
        except TargetError as e:
            failures.append(str(e))
            hw_recover(args, tgt, result, failures)
            return result
        since = tgt.console_since(tgt.console_mark)
        result["console_stage"] = console_stage(since)
        result["console_tail"] = since[-HW_CONSOLE_TAIL:]
        log(f"console: reached {result['console_stage']['stage']} "
            f"over {len(since)} bytes")

        cur = probes(tgt)
        result["badc"] = cur
        log(f"badc: uname={cur['uname']} systemd={cur['systemd_state']} "
            f"modules={len(cur['modules'])}")
        if not assert_boot(args, tgt, base, cur, result, failures):
            return result
        # The machine's devices are fixed, so the baseline names what has to
        # bind: the kernel under test must drive the same disk and network
        # hardware the distribution kernel drove.
        for what in ("disk_driver", "net_driver"):
            missing = sorted(set(base[what].split()) - set(cur[what].split()))
            if missing:
                failures.append(f"{what}: {' '.join(missing)} bound under "
                                f"{base['uname']} but not under "
                                f"{cur['uname']} "
                                f"({cur[what]!r})")
        if result["console_stage"]["outcome"]:
            failures.append(f"{result['console_stage']['verdict']} "
                            f"({result['console_stage']['stopped_at']})")
        if result["console_stage"]["fault"]:
            failures.append(f"console fault during the boot: "
                            f"{result['console_stage']['fault']}")

        assert_package_products(args, arch, tgt, result, failures)
        if steps := exercise.selected_steps(args):
            result["exercise"] = exercise.run(args, tgt, arch, args.release,
                                              failures, log, steps)
        result["cores_badc"] = sweep_cores(args, tgt, "badc", failures)
        if not result["cores_badc"]:
            log("no userspace cores under the kernel under test")

        if args.hw_restore:
            log(f"restoring the machine to {default}")
            try:
                tgt.reboot(args.hw_timeout, tgt.ssh(
                    "cat /proc/sys/kernel/random/boot_id").stdout.strip())
                result["restored_uname"] = tgt.ssh("uname -r").stdout.strip()
                if result["restored_uname"] == args.release:
                    failures.append(
                        f"the machine is still on {args.release} after the "
                        f"restore: the standing default did not take")
            except TargetError as e:
                failures.append(f"restoring the standing default: {e}")
    except TargetError as e:
        failures.append(str(e))
    finally:
        try:
            result["oneshot_cleared"] = hw_clear_oneshot(tgt)
            after = hw_default_kernel(tgt)
            result["boot_default_after"] = after
            want = result.get("boot_default")
            if want and after and after != want:
                failures.append(f"the machine is left with {after} as its "
                                f"standing default, not {want}: the next "
                                f"boot would not fall back")
        except Exception as e:  # teardown must not mask the verdict
            log(f"hardware teardown: {e}")
        if serial:
            serial.stop()
            result["serial"] = serial.stats()
            log(f"serial console: {serial.bytes} bytes, "
                f"{serial.reopens} reopens")
    return result


# --- self-test --------------------------------------------------------------

def _self_test() -> int:
    """The pure helpers, without a tree, a host or a guest."""
    import types

    assert names_badc("badc 0.1 (gcc-compatible, GNU C 15.0.0)")
    assert not names_badc("gcc (GCC) 15.2.1")
    assert not names_badc("")

    cfg = clear_foreign_files(
        'CONFIG_SYSTEM_TRUSTED_KEYS="debian/certs/x.pem"\n'
        'CONFIG_MODULE_SIG_KEY="debian/certs/k.pem"\n'
        'CONFIG_INITRAMFS_SOURCE="/x/y"\nCONFIG_LOCALVERSION="-badc"\n')
    assert 'CONFIG_SYSTEM_TRUSTED_KEYS=""' in cfg
    assert 'CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"' in cfg
    assert 'CONFIG_INITRAMFS_SOURCE=""' in cfg
    assert 'CONFIG_LOCALVERSION="-badc"' in cfg

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

    for name in ARCHES:
        a = resolve_arch(name, None)
        assert a["pkg"] in PACKAGERS and "sha256" in a["image"]
        assert a["qemu"].endswith(name)
    assert resolve_arch("x86_64", "fedora")["pkg"] == "rpm"
    assert set(DISK_BUSES) >= {"virtio", "nvme"} and "virtio-net-pci" in NICS

    # Config sources: the mirrored asset name is the basename plus the first
    # 8 hex of the digest resolve_arch carries, and every mirrored digest is
    # a full sha256 for an architecture that distribution has an image for.
    assert set(CONFIG_PHASE) == set(CONFIG_SOURCES)
    assert kconfig_asset("fedora", "x86_64", "1c0d2e47" + "8" * 56) == \
        "kconfig-fedora-x86_64-1c0d2e47.config"
    mirrored = {(d, a) for d, spec in DISTROS.items()
                for a in spec.get("kconfigs", ())}
    assert mirrored == {(d, a) for d in ("fedora", "ubuntu")
                        for a in ("x86_64", "aarch64")}
    for distro, name in mirrored:
        spec = resolve_arch(name, distro)
        assert re.fullmatch(r"[0-9a-f]{64}", spec["kconfig"])
        assert spec["kconfig"] == DISTROS[distro]["kconfigs"][name]
    # A distribution with no mirrored configuration reports None rather than
    # resolving to another distribution's asset.
    assert resolve_arch("x86_64", "debian")["kconfig"] is None

    # A name the gate modprobes may be a module or built in: a
    # distribution configuration builds in what defconfig leaves modular,
    # and modprobe reports success either way.
    bi = builtin_modules("kernel/fs/btrfs/btrfs.ko\nkernel/net/xt-mark.ko\n")
    assert bi == {"btrfs", "xt_mark"}
    lsmod = "Module Size Used by\nfuse 217088 1\nnvme 61440 3\n"
    assert module_state("fuse", lsmod, bi) == "loaded"
    assert module_state("btrfs", lsmod, bi) == "builtin"
    assert module_state("xt-mark", lsmod, bi) == "builtin"
    assert module_state("xfs", lsmod, bi) == "absent"
    # A name that only appears in another module's "Used by" column is not
    # loaded itself.
    assert module_state("by", lsmod, set()) == "absent"

    meta = config_meta(Path(__file__), source="x")
    assert meta["source"] == "x" and meta["bytes"] > 0

    # One controller per bus, and a data controller that is not the boot one.
    root = bus_args("nvme", "ctl0", [("d0", "file=/d.qcow2", "hd"),
                                     ("d1", "file=/s.iso", "cd")], True)
    assert "bootindex=0" in root[3] and "bootindex" not in root[7]
    assert bus_args("virtio", "ctl0", [("d0", "file=/d", "hd")], True) == [
        "-drive", "if=virtio,file=/d"]
    ahci = bus_args("ahci", "ctl1", [("x0", "file=/x", "hd")], False)
    assert ahci[:2] == ["-device", "ahci,id=ctl1"]
    assert ahci[-1] == "ide-hd,drive=x0,bus=ctl1.0"
    scsi = bus_args("megasas", "ctl1", [("x0", "file=/x", "hd")], False)
    assert scsi[:2] == ["-device", "megasas,id=ctl1,use_jbod=on"]
    assert bus_args("lsi53c895a", "ctl1", [("x0", "file=/x", "hd")],
                    False)[:2] == ["-device", "lsi53c895a,id=ctl1"]
    assert scsi[-1] == "scsi-hd,drive=x0,bus=ctl1.0,scsi-id=0,write-cache=off"
    # nvme serials are per drive, so two controllers do not collide.
    two = bus_args("nvme", "ctl0", [("d0", "file=/d", "hd")], True) + \
        bus_args("nvme", "ctl1", [("x0", "file=/x", "hd")], False)
    assert "serial=d0" in two[3] and "serial=x0" in two[7]

    # The data disk is picked by driver, with the root excluded by name: a
    # data controller of the root's own model binds the same driver.
    listing = "vda: virtio_blk virtio-pci\nnvme0n1: nvme\n"
    assert data_disk_dev(listing, "nvme", "vda") == "nvme0n1"
    assert data_disk_dev(listing, "virtio_blk", "vda") is None
    assert data_disk_dev("vda: virtio_blk\nvdb: virtio_blk\n",
                         "virtio_blk", "vda") == "vdb"
    assert data_disk_dev("", "nvme", "vda") is None

    # The tree directory comes from the archive, not from the asset name:
    # a mirrored tarball's name carries a digest prefix the directory lacks.
    import tempfile
    with tempfile.TemporaryDirectory() as d:
        d = Path(d)
        (d / "linux-7.1.10").mkdir()
        (d / "linux-7.1.10" / "Makefile").write_text("")
        tar = d / "linux-7.1.10-67d2f469.tar.xz"
        with tarfile.open(tar, "w:xz") as tf:
            tf.add(d / "linux-7.1.10", arcname="linux-7.1.10")
        a = types.SimpleNamespace(tarball=tar, workdir=d)
        assert tarball_tree(a) == d / "linux-7.1.10"

    # Firmware discovery: the first entry whose code image is installed wins,
    # and one whose variable store is absent falls back to a -bios image.
    def installed(*paths):
        return set(paths).__contains__

    assert find_firmware("x86_64", installed(
        "/usr/share/edk2/ovmf/OVMF_CODE.fd",
        "/usr/share/edk2/ovmf/OVMF_VARS.fd")) == (
            "/usr/share/edk2/ovmf/OVMF_CODE.fd",
            "/usr/share/edk2/ovmf/OVMF_VARS.fd")
    assert find_firmware("x86_64", installed(
        "/usr/share/OVMF/OVMF_CODE_4M.fd",
        "/usr/share/OVMF/OVMF_VARS_4M.fd",
        "/usr/share/OVMF/OVMF_CODE.fd",
        "/usr/share/OVMF/OVMF_VARS.fd")) == (
            "/usr/share/OVMF/OVMF_CODE_4M.fd",
            "/usr/share/OVMF/OVMF_VARS_4M.fd")
    assert find_firmware("x86_64", installed(
        "/usr/share/OVMF/OVMF_CODE_4M.fd")) == (
            "/usr/share/OVMF/OVMF_CODE_4M.fd", None)
    assert find_firmware("aarch64", installed(
        "/usr/share/edk2/aarch64/QEMU_EFI.fd")) == (
            "/usr/share/edk2/aarch64/QEMU_EFI.fd", None)
    assert find_firmware("x86_64", lambda p: False) is None

    ovmf = ("/usr/share/OVMF/OVMF_CODE_4M.fd", "/usr/share/OVMF/OVMF_VARS_4M.fd")
    assert resolve_firmware("x86_64", "auto", ovmf) == ("uefi", "")
    assert resolve_firmware("x86_64", "uefi", ovmf) == ("uefi", "")
    assert resolve_firmware("x86_64", "bios", ovmf) == ("bios", "")
    fw, why = resolve_firmware("x86_64", "auto", None)
    assert (fw, bool(why)) == ("bios", True)
    for arch, choice, found in (("x86_64", "uefi", None),
                                ("aarch64", "auto", None),
                                ("aarch64", "uefi", None),
                                ("aarch64", "bios", ovmf)):
        try:
            resolve_firmware(arch, choice, found)
            assert False, (arch, choice)
        except ValueError:
            pass

    assert firmware_args(("/c.fd", None), Path("/w")) == ["-bios", "/c.fd"]
    assert (pflash_format("/x/OVMF_CODE_4M.qcow2"),
            pflash_format("/x/OVMF_CODE.fd")) == ("qcow2", "raw")

    assert efi_fault(
        "BdsDxe: starting Boot0004\r\n"
        "!!!! X64 Exception Type - 0D(#GP - General Protection)  CPU Apic ID "
        "- 00000000 !!!!\r\nRIP  - 000000007A\r\n"
    ) == ("!!!! X64 Exception Type - 0D(#GP - General Protection)  "
          "CPU Apic ID - 00000000 !!!!")
    assert efi_fault("!!!! Synchronous Exception at 0x000000013F2 !!!!")
    assert efi_fault("[    0.0] Linux version 7.1.6\n") is None

    # The nvme bus above the memory split is SeaBIOS's limit alone, and the
    # exercise stage's guest size is above it.
    assert seabios_nvme_blocked("bios", "nvme", SEABIOS_NVME_MEM_LIMIT)
    assert not seabios_nvme_blocked("bios", "nvme", SEABIOS_NVME_MEM_LIMIT - 1)
    assert not seabios_nvme_blocked("uefi", "nvme", 8192)
    assert not seabios_nvme_blocked("bios", "virtio", 8192)
    assert exercise.EXERCISE_VM_MEM > SEABIOS_NVME_MEM_LIMIT

    assert new_kernel_errors({"dmesg_err": ["a", "b"]},
                             {"dmesg_err": ["b", "c"]}) == ["c"]
    assert new_kernel_errors({"dmesg_err": ["a"]}, {"dmesg_err": ["a"]}) == []
    assert new_kernel_errors({"dmesg_err": None}, {"dmesg_err": ["a"]}) is None
    assert new_kernel_errors({}, {"dmesg_err": ["a"]}) is None

    assert resolve_phases("config,tree,build,package,vm", None, None) == (
        {"config", "tree", "build", "package", "vm"}, True)
    assert resolve_phases("vm", None, None) == ({"vm"}, True)
    assert resolve_phases("config", None, None) == ({"config"}, False)
    # A hardware run over an already-built package needs no tree at all.
    assert resolve_phases("hw", "7.1.6-badc", "box") == ({"hw"}, False)
    assert resolve_phases("hw", None, "box") == ({"hw"}, True)
    for spec, rel, host in (("vm,bogus", None, None), ("selfhost", None, None),
                            ("hw", None, None),
                            ("tree,build", "7.1.6-badc", None)):
        try:
            resolve_phases(spec, rel, host)
            assert False, spec
        except ValueError:
            pass

    assert install_cmd(deb, [Path("/o/linux-image_1_amd64.deb")]) == (
        "dpkg -i linux-image_1_amd64.deb")
    assert install_cmd(rpm, [Path("/o/kernel-1.rpm"), Path("/o/kernel-c.rpm")],
                       "--replacepkgs") == (
        "rpm -ivh --oldpackage --replacepkgs kernel-1.rpm kernel-c.rpm")

    # --- hardware lane ---
    assert baud_constant(115200) == termios.B115200
    assert baud_constant(9600) == termios.B9600
    try:
        baud_constant(115201)
        assert False
    except ValueError:
        pass

    assert entry_release("/boot/vmlinuz-7.1.10-200.fc44.x86_64") == (
        "7.1.10-200.fc44.x86_64")
    assert entry_release('"/boot/vmlinuz-6.1.0-badc"') == "6.1.0-badc"
    assert entry_release("/boot/efi/EFI/fedora/grubx64.efi") == ""

    info = ('index=0\nkernel="/boot/vmlinuz-7.1.10-200.fc44.x86_64"\n'
            'args="ro root=UUID=1e14 console=ttyS1,115200n8"\n'
            'root="UUID=1e14"\ntitle="Fedora Linux (7.1.10-200.fc44.x86_64)"\n'
            'index=1\nkernel="/boot/vmlinuz-7.1.6-badc"\n'
            'title="Fedora Linux (7.1.6-badc)"\nid="c8-7.1.6-badc"\n'
            'index=2\nkernel="/boot/vmlinuz-0-rescue-c8ed"\n')
    entries = grubby_entries(info)
    assert [e["index"] for e in entries] == ["0", "1", "2"]
    assert entries[0]["args"] == "ro root=UUID=1e14 console=ttyS1,115200n8"
    assert grubby_index(entries, "7.1.6-badc") == 1
    assert grubby_index(entries, "7.1.10-200.fc44.x86_64") == 0
    assert grubby_index(entries, "9.9.9") is None
    assert grubby_entries("") == []

    assert entry_root(entries[0]) == "UUID=1e14"
    assert entry_root({"args": "ro root=/dev/sda3 quiet"}) == "/dev/sda3"
    assert entry_root({"args": "ro rootflags=subvol=root"}) == ""
    assert entry_bootable(entries[0]) is None
    assert entry_bootable({"args": "ro root=/dev/sda3"}) is None
    # rootflags is not a root device: the entry kernel-install wrote from an
    # /etc/kernel/cmdline with no root= looks exactly like this.
    assert entry_bootable({"args": "ro rootflags=subvol=root panic=30"})
    assert entry_bootable({})

    assert cc_version_text(
        'CONFIG_CC_IS_GCC=y\nCONFIG_CC_VERSION_TEXT="gcc (GCC) 15.2.1"\n'
    ) == "gcc (GCC) 15.2.1"
    assert cc_version_text("CONFIG_CC_IS_GCC=y\n") == ""

    # The standing default is the only recovery: it must be a kernel entry,
    # neither the release under test nor one badc built.
    assert fallback_refusal("/boot/vmlinuz-7.1.10-200.fc44.x86_64",
                            "7.1.6-badc", "gcc (GCC) 15.2.1") is None
    for default, rel, cc in (
            ("", "7.1.6-badc", "gcc (GCC) 15.2.1"),
            ("/boot/vmlinuz-7.1.6-badc", "7.1.6-badc", "gcc (GCC) 15.2.1"),
            ("/boot/vmlinuz-7.1.6-other", "7.1.6-badc",
             "badc 0.1 (gcc-compatible, GNU C 15.0.0)")):
        assert fallback_refusal(default, rel, cc), (default, rel)

    boot = ("GNU GRUB  version 2.14\r\nBooting `Fedora Linux'\r\n"
            "[    0.000000] earlycon: uart8250 at I/O port 0x2f8\r\n"
            "[    0.000000] Linux version 7.1.10-200.fc44.x86_64\r\n"
            "[    1.100000] Unpacking initramfs...\r\n"
            "[    5.200000] systemd[1]: Detected architecture x86-64.\r\n"
            "[   20.000000] Reached target Multi-User System.\r\n"
            "fedora login: ")
    st = console_stage(boot)
    assert (st["stage"], st["fault"]) == ("multi-user", "")
    assert st["reached"] == ["bootloader", "earlycon", "kernel", "initramfs",
                            "userspace", "multi-user"]
    hung = console_stage(boot.split("Unpacking")[0] +
                         "[    1.5] Kernel panic - not syncing: VFS: Unable "
                         "to mount root fs\r\n")
    assert hung["stage"] == "kernel"
    assert hung["fault"].startswith("Kernel panic - not syncing")
    assert console_stage("")["stage"] == "none"

    # A boot that parks in the initramfs emergency shell reaches userspace
    # and never answers ssh; the wait ends on the marker, not on the timeout.
    emerg = ("[  OK  ] Started \x1b[0;1;39memergency.service\x1b[0m - "
             "Emergency Shell.\r\n[  OK  ] Reached target "
             "\x1b[0;1;39memergency.target\x1b[0m - Emergency Mode.\r\n")
    # Emergency mode is a named outcome of its own, not "ssh never
    # returned": the verdict names the root filesystem, not the kernel.
    emerg_st = console_stage(emerg)
    assert emerg_st["outcome"] == "emergency", emerg_st
    assert "root filesystem was not mounted" in emerg_st["verdict"]
    assert console_stage(boot)["outcome"] == ""
    assert hung["outcome"] == "panic"
    assert hung["stopped_at"].startswith("Kernel panic - not syncing")
    assert console_stage(
        "Cannot open access to console, the root account is locked."
    )["outcome"] == "emergency"
    # A panic that then parks in emergency mode is reported as the panic.
    assert console_stop("[1.0] Kernel panic - not syncing: x\r\n"
                        "Entering emergency mode.\r\n")[0] == "panic"

    _self_test_wait()

    exercise.self_test()
    print("linux packages: self-test ok", flush=True)
    return 0


def _self_test_wait() -> int:
    """Target.wait_ssh over a console file and a scripted ssh, which is every
    way a wait ends: a machine that is gone, a console that stayed silent, a
    marker that ended the boot, a new boot id, and the timeout."""
    import tempfile
    import types

    class Fake(Target):
        silence_grace = 0.01

        def __init__(self, console: Path, answers, absent="", stop=""):
            super().__init__("t@h", 22, None, console)
            self.answers, self.absent, self.stopper = answers, absent, stop
            self.asked = 0

        def ssh(self, cmd, timeout=120, check=False, sudo=False):
            i = min(self.asked, len(self.answers) - 1)
            self.asked += 1
            ok = 0 if self.answers[i] else 1
            return types.SimpleNamespace(returncode=ok,
                                         stdout=self.answers[i], stderr="")

        def gone(self):
            return self.absent or None

        def console_stop(self):
            return self.stopper or None

    with tempfile.TemporaryDirectory() as d:
        con = Path(d) / "console.log"
        con.write_text("[    0.0] Linux version 7.1.6\n")

        # A new boot id ends the wait; the same one keeps it going.
        f = Fake(con, ["b2"])
        assert f.wait_ssh(30, expect_boot_id="b1") == "b2"
        f = Fake(con, ["", "b2"])
        assert f.wait_ssh(30) == "b2" and f.asked == 2

        for kwargs, want in (({"absent": "qemu exited"}, "qemu exited"),
                             ({"stop": "emergency.target"}, "emergency")):
            try:
                Fake(con, ["b2"], **kwargs).wait_ssh(30)
                assert False, kwargs
            except TargetError as e:
                assert want in str(e), e

        # Silence past the grace, judged from the mark rather than from an
        # empty file: a console that has not grown is a machine that did not
        # start, whatever it wrote before the reset.
        empty = Path(d) / "empty.log"
        empty.write_bytes(b"")
        try:
            Fake(empty, [""]).wait_ssh(30)
            assert False
        except TargetError as e:
            assert "no console output" in str(e), e
        marked = Fake(con, [""])
        marked.console_mark = con.stat().st_size
        try:
            marked.wait_ssh(30)
            assert False
        except TargetError as e:
            assert "no console output" in str(e), e

        # Past the mark the console has grown, so the wait runs to its
        # timeout and says so.
        try:
            Fake(con, [""]).wait_ssh(0)
            assert False
        except TargetError as e:
            assert "not reachable within 0s" in str(e), e
    return 0


# --- main -------------------------------------------------------------------

def main() -> int:
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
                    default=os.environ.get("BADC_LINKER", "badc"),
                    help="linker for the kernel build: badc through "
                         "ldshim.py (the default, matching verify.py), or "
                         "the reference `ld` for the contrast run")
    ap.add_argument("--real-ld", default=os.environ.get("BADC_LD_REAL"),
                    help="reference linker (default: ld; on macOS the "
                         "musl-cross <triple>-ld for --arch)")
    ap.add_argument("--tarball", type=Path,
                    help="kernel source tarball (default: fetch the pinned "
                         "release from the mirror, sha256-verified)")
    ap.add_argument("--tarball-url",
                    help="fetch the kernel tarball from this URL instead; "
                         "requires --tarball-sha256")
    ap.add_argument("--tarball-sha256",
                    help="expected sha256 of --tarball-url")
    ap.add_argument("--tarball-cache", type=Path,
                    default=LINUX_DIR / ".cache" / "tarballs",
                    help="where a fetched tarball is kept between runs")
    ap.add_argument("--config",
                    help=f"kernel .config to build: a path, "
                         f"{CONFIG_VENDOR!r} for the distribution's own "
                         f"configuration mirrored on the vendor-deps release, "
                         f"or {CONFIG_FROM_VM!r} to extract that same file "
                         f"from the booted stock image (default: make "
                         f"defconfig)")
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
                         "package,vm,hw,selfhost; selfhost is off by default "
                         "and runs inside the vm phase, hw installs on the "
                         "physical machine --hw-host names")
    ap.add_argument("--release",
                    help="kernel release the packages install (default: read "
                         "from the prepared tree)")
    ap.add_argument("--package", type=Path, action="append", default=[],
                    dest="package_files",
                    help="package to install, repeatable (default: what the "
                         "package phase produced)")
    ap.add_argument("--expect-producer", choices=("badc", "any"),
                    default="badc",
                    help="compiler the booted kernel must identify itself as "
                         "built by; `any` records the banner without "
                         "asserting it, for a run that installs a reference "
                         "package to exercise the lane itself")
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
    ap.add_argument("--config-cache", type=Path,
                    default=LINUX_DIR / ".cache" / "configs",
                    help=f"where a `--config {CONFIG_VENDOR}` asset is kept "
                         f"between runs")
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
    ap.add_argument("--vm-data-bus", choices=sorted(DISK_BUSES),
                    help="attach a second, empty disk on this controller as "
                         "well; the booted kernel must bind its driver and "
                         "carry a filesystem on it. For a controller no "
                         "firmware can boot from, this is how its driver is "
                         "covered")
    ap.add_argument("--vm-guest-file", type=Path, action="append", default=[],
                    help="file to copy into the booted kernel's guest before "
                         "--vm-guest-script runs, repeatable")
    ap.add_argument("--vm-guest-script", type=Path,
                    help="shell script to run in the booted badc kernel after "
                         "the probes; its output lands in the report. For "
                         "driving one subsystem by hand -- swapping a module "
                         "for another compiler's build of it, say -- without "
                         "a harness change per experiment")
    ap.add_argument("--vm-nic", choices=sorted(NICS), default="virtio-net-pci",
                    help="NIC model (default: virtio-net-pci); the booted "
                         "kernel must bind it to that model's driver")
    ap.add_argument("--vm-firmware", choices=("auto", "uefi", "bios"),
                    default="auto",
                    help="guest firmware: EFI (OVMF on x86 q35, AAVMF on "
                         "aarch64 virt) or SeaBIOS on x86 i440fx; auto takes "
                         "EFI wherever it is installed")
    ap.add_argument("--vm-mem", type=int, default=None)
    ap.add_argument("--vm-disk", default=None)
    ap.add_argument("--vm-timeout", type=int, default=900,
                    help="seconds to wait for ssh after a boot")
    ap.add_argument("--install-timeout", type=int, default=1800,
                    help="seconds for the package install, which regenerates "
                         "the initramfs and is the longest single step")
    ap.add_argument("--install-args", default="",
                    help="extra flags for the package install command, e.g. "
                         "`--replacepkgs` to reinstall a package the target "
                         "already carries")
    ap.add_argument("--qemu-args", default="")
    ap.add_argument("--hw-host",
                    help="[user@]host of the physical machine the hw phase "
                         "installs on and boots; reached over ssh with key "
                         "authentication and password-less sudo")
    ap.add_argument("--hw-port", type=int, default=22)
    ap.add_argument("--hw-key", type=Path,
                    help="ssh identity for --hw-host (default: ssh's own)")
    ap.add_argument("--hw-serial",
                    help="serial device on this host carrying the target's "
                         "console, e.g. /dev/cu.usbserial-XXXX or "
                         "/dev/ttyUSB0; without it a boot that never reaches "
                         "ssh leaves no record")
    ap.add_argument("--hw-baud", type=int, default=115200)
    ap.add_argument("--hw-timeout", type=int, default=600,
                    help="seconds to wait for ssh after a reset")
    ap.add_argument("--hw-recover-timeout", type=int, default=600,
                    help="seconds to wait for the machine to fall back to "
                         "the standing default after a failed boot; the "
                         "watchdog is what resets it")
    ap.add_argument("--no-hw-sysrq", dest="hw_sysrq", action="store_false",
                    help="do not send a SysRq reset over the serial line "
                         "when a failed boot leaves the machine parked "
                         "where the watchdog cannot reset it")
    ap.add_argument("--no-hw-restore", dest="hw_restore", action="store_false",
                    help="leave the machine running the kernel under test "
                         "instead of rebooting it onto the standing default")
    exercise.add_arguments(ap)
    ap.add_argument("--workdir", type=Path,
                    default=Path.cwd() / "packages-out")
    ap.add_argument("--report", type=Path)
    args = ap.parse_args()

    arch = resolve_arch(args.arch, args.distro)
    cross = f"{args.arch}-linux-musl-" if platform.system() == "Darwin" else ""
    args.real_cc = args.real_cc or f"{cross}gcc"
    args.real_ld = args.real_ld or f"{cross}ld"
    try:
        phases, needs_tree = resolve_phases(args.phases, args.release,
                                            args.hw_host)
    except ValueError as e:
        die(str(e))
    args.selfhost = "selfhost" in phases
    for name, value in vm_size(args.selfhost).items():
        if getattr(args, name) is None:
            setattr(args, name, value)
    args.selfhost_jobs = args.selfhost_jobs or args.vm_cpus
    args.selfhost_expect = (args.selfhost_expect_units
                            or SELFHOST_EXPECT[args.selfhost_scope])
    args.workdir = args.workdir.resolve()
    args.workdir.mkdir(parents=True, exist_ok=True)
    if needs_tree:
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
    if args.config in CONFIG_SOURCES:
        if "config" not in phases:
            die(f"--config {args.config} needs the config phase")
        config = phase_config(args, arch)
        report["config_source"] = json.loads(
            config.with_suffix(".json").read_text())
    elif args.config:
        config = Path(args.config)
        if not config.is_file():
            die(f"no config at {config}")

    if not phases - {"config"}:
        if args.report:
            report["failures"] = failures
            args.report.write_text(json.dumps(report, indent=2) + "\n")
        return 0

    tree = None
    if "tree" in phases:
        if not args.tarball and not args.tarball_url:
            # Neither given: take the release this tree is pinned to, from
            # the mirror, against its recorded sha256. The same verified
            # path setup.py uses, so a bare invocation builds packages
            # without first having to name a tarball.
            version, sha = setup.DEFCONFIG_KERNEL
            log(f"no tarball named; taking the pinned release {version}")
            args.tarball_url = setup.tarball_urls(version, sha)[0]
            args.tarball_sha256 = sha
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
    elif needs_tree:
        trees = sorted(args.workdir.glob("linux-*/Makefile"))
        if not trees:
            die(f"no prepared tree under {args.workdir}; run the tree phase")
        tree = trees[0].parent
    if tree is not None:
        args.tree_version = tree.name[len("linux-"):]
        args.host_config = tree / ".config"
        args.release = run(["make", "-s", "kernelrelease"], cwd=tree,
                           env=shim_env(args, arch),
                           check=True).stdout.strip()
        log(f"kernel {args.release} in {tree}")
    else:
        log(f"kernel {args.release} (no tree; --release)")
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
    if {"vm", "hw"} & phases and not failures:
        if args.package_files:
            for p in args.package_files:
                if not p.is_file():
                    die(f"no package at {p}")
            packages = [p.resolve() for p in args.package_files]
        if not packages:
            if tree is None:
                die("no packages to install; pass --package or run the "
                    "package phase")
            packages = (sorted(args.workdir.glob(
                f"linux-image-{args.release}_*.deb"))
                if arch["pkg"] == "deb" else
                [p for p in sorted((tree / "rpmbuild/RPMS").rglob("*.rpm"))
                 if p.name.startswith(
                     f"kernel-{args.release.replace('-', '_')}-")])
            packages = [p for p in packages if "-dbg" not in p.name]
            if not packages:
                die("no packages to install; run the package phase")
        if "vm" in phases:
            report["vm"] = phase_vm(args, arch, packages, failures)
        if "hw" in phases:
            report["hw"] = phase_hw(args, arch, packages, failures)

    if args.report:
        report["failures"] = failures
        args.report.write_text(json.dumps(report, indent=2) + "\n")

    for f in failures:
        print(f"linux packages: FAIL: {f}", flush=True)
    if failures:
        return 1
    where = [f"the {arch['distro']} vm" if p == "vm" else args.hw_host
             for p in ("vm", "hw") if p in phases]
    log(f"PASS: {args.release} packaged as "
        f"{', '.join(p.name for p in packages) or 'n/a'}"
        + (f", installed and validated on {' and '.join(where)}"
           if where else ""))
    return 0


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        sys.exit(_self_test())
    sys.exit(main())
