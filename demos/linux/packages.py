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
the install, so every measurement has a reference.

    python3 demos/linux/packages.py --arch x86_64 \
        --tarball <linux-7.1.6.tar.xz> --config <corpus .config> \
        --report packages-x86_64.json

Phases (--phases selects a subset; each is idempotent): tree, build, package,
vm. The build runs in <workdir>/linux-<version>; packages land in <workdir>
(deb) or the tree's rpmbuild/RPMS (rpm). On a host without the Debian
packaging tools (an rpm distribution), --deb-tools names a prefix that is
provisioned from the host's own package mirror via `dnf download` + rpm2cpio
extraction; nothing is installed system-wide.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import re
import shlex
import shutil
import subprocess
import sys
import tarfile
import time
import urllib.request
from pathlib import Path

LINUX_DIR = Path(__file__).resolve().parent
REPO_ROOT = LINUX_DIR.parents[1]

ARCHES = {
    "x86_64": {
        "target": "linux-x64",
        "make_target": "bzImage",
        "pkg": "deb",
        "qemu": "qemu-system-x86_64",
        "image_url": "https://cloud.debian.org/images/cloud/trixie/latest/"
                     "debian-13-genericcloud-amd64.qcow2",
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
        "pkg": "rpm",
        "qemu": "qemu-system-aarch64",
        "image_url": "https://download.fedoraproject.org/pub/fedora/linux/"
                     "releases/44/Cloud/aarch64/images/"
                     "Fedora-Cloud-Base-Generic-44-1.7.aarch64.qcow2",
        "distro": "fedora",
        "modprobe": ["fuse", "btrfs"],
        "expect_units": 10000,
    },
}

# aarch64 EFI firmware, first match wins: (code, vars) pflash pair, or a
# single -bios image.
AARCH64_FIRMWARE = [
    ("/usr/share/AAVMF/AAVMF_CODE.fd", "/usr/share/AAVMF/AAVMF_VARS.fd"),
    ("/usr/share/edk2/aarch64/QEMU_EFI.fd", None),
]

DEB_TOOL_RPMS = ["dpkg", "dpkg-dev", "dpkg-perl", "debhelper", "libmd"]

# Patterns whose presence in dmesg fails the gate outright, and patterns
# that are only compared against the stock baseline.
DMESG_SEVERE = re.compile(
    r"BUG:|Oops|Call [Tt]race|general protection|"
    r"Unable to handle kernel|kernel NULL pointer|UBSAN:|KASAN:")
DMESG_WARN = re.compile(r"WARNING:")


def log(m: str) -> None:
    print(f"linux packages: {m}", flush=True)


def die(m: str) -> None:
    print(f"linux packages: FAIL: {m}", flush=True)
    sys.exit(1)


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
    r = subprocess.run(cmd, cwd=cwd, env=env, timeout=timeout, text=True,
                       stdin=subprocess.DEVNULL,
                       capture_output=capture)
    if check and r.returncode != 0:
        tail = (r.stderr or r.stdout or "").strip().splitlines()[-8:]
        die(f"{' '.join(map(str, cmd))} exited {r.returncode}\n" +
            "\n".join(tail))
    return r


# --- tree -------------------------------------------------------------------

def phase_tree(args, arch) -> Path:
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
    if args.config:
        text = Path(args.config).read_text()
    else:
        log("make defconfig")
        run(["make", "defconfig"], cwd=tree, env=shim_env(args, arch),
            check=True)
        text = (tree / ".config").read_text()
    # The build produces boot artifacts itself; a config carried over from
    # another tree must not pull that tree's embedded initramfs in.
    text = re.sub(r'(?m)^CONFIG_INITRAMFS_SOURCE=.*$',
                  'CONFIG_INITRAMFS_SOURCE=""', text)
    (tree / ".config").write_text(text)
    log("make olddefconfig")
    run(["make", f"CC={LINUX_DIR / 'buildcc.py'}", "olddefconfig"], cwd=tree,
        env=shim_env(args, arch), check=True)
    return tree


# --- build ------------------------------------------------------------------

def shim_env(args, arch) -> dict:
    env = dict(os.environ)
    env.update(
        BADC=str(args.badc),
        BADC_REAL_CC=args.real_cc,
        BADC_TARGET=arch["target"],
        BADC_MANIFEST=str(args.manifest),
        BADC_TIMEOUT=str(args.unit_timeout),
    )
    env.pop("BADC_FALLBACK", None)
    if args.arch == "x86_64" and args.deb_tools:
        deb_tool_env(args.deb_tools, env)
    return env


def kbuild(args, arch, tree, targets, extra=(), log_name="build") -> Path:
    shim = LINUX_DIR / "buildcc.py"
    cmd = ["make", f"-j{args.jobs}", f"CC={shim}", *extra, *targets]
    build_log = args.workdir / f"{log_name}-{args.arch}.log"
    log(f"{' '.join(cmd)} (in {tree}, log {build_log})")
    with build_log.open("wb") as fh:
        rc = subprocess.run(cmd, cwd=tree, env=shim_env(args, arch),
                            stdin=subprocess.DEVNULL, stdout=fh,
                            stderr=subprocess.STDOUT).returncode
    if rc != 0:
        die(f"make {' '.join(targets)} exited {rc} (see {build_log})")
    return build_log


def phase_build(args, arch, tree) -> None:
    args.manifest.unlink(missing_ok=True)
    kbuild(args, arch, tree, [arch["make_target"], "modules"])


def read_manifest(path: Path) -> dict[str, list[str]]:
    out = {"badc": [], "fallback": [], "fail": []}
    if path.exists():
        for line in path.read_text(errors="replace").splitlines():
            verdict, _, rest = line.partition("\t")
            if verdict in out:
                out[verdict].append(rest)
    return out


# --- package ----------------------------------------------------------------

def ensure_deb_tools(prefix: Path) -> None:
    """Provision the Debian packaging tools under a prefix on an rpm host.

    `dnf download` + rpm2cpio extraction only; nothing touches the system.
    """
    if (prefix / "usr/bin/dpkg-buildpackage").exists():
        return
    if not shutil.which("dnf"):
        die(f"no dpkg-buildpackage on PATH and no dnf to provision "
            f"{prefix}; install the dpkg/debhelper suite or point "
            f"--deb-tools at a provisioned prefix")
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


def phase_package(args, arch, tree) -> list[Path]:
    # Products of a previous run in this workdir would satisfy the install
    # globs; a fresh package phase replaces them.
    for stale in args.workdir.glob("linux-image-*.deb"):
        stale.unlink()
    shutil.rmtree(tree / "rpmbuild/RPMS", ignore_errors=True)
    if arch["pkg"] == "deb":
        if args.deb_tools:
            ensure_deb_tools(args.deb_tools)
        admindir = (args.deb_tools / "var/lib/dpkg") if args.deb_tools else None
        # -d: build-dependency data lives in a dpkg database this host does
        # not have; the tools themselves are the real prerequisite.
        flags = "-d"
        if admindir:
            flags += f" --buildinfo-option=--admindir={admindir}"
        kbuild(args, arch, tree, ["bindeb-pkg"],
               extra=[f"DPKG_FLAGS={flags}"], log_name="package")
        debs = sorted(args.workdir.glob(
            f"linux-image-{args.release}_*.deb"))
        debs = [d for d in debs if "-dbg" not in d.name]
        if not debs:
            die(f"bindeb-pkg produced no linux-image deb in {args.workdir}")
        return debs
    # rpm: modules are stripped at install; the gate packages the kernel,
    # not its debug info.
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


# --- vm ---------------------------------------------------------------------

def ensure_image(args, arch) -> Path:
    if args.image:
        if not args.image.is_file():
            die(f"no image at {args.image}")
        return args.image
    dst = args.workdir / arch["image_url"].rsplit("/", 1)[1]
    if not dst.is_file():
        log(f"fetching {arch['image_url']}")
        tmp = dst.with_suffix(".part")
        with urllib.request.urlopen(arch["image_url"]) as r, open(tmp, "wb") as f:
            shutil.copyfileobj(r, f)
        tmp.rename(dst)
    return dst


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


def probe_kvm(args, arch) -> bool:
    if not os.access("/dev/kvm", os.R_OK | os.W_OK):
        return False
    pidfile = args.workdir / "kvmprobe.pid"
    machine = (["-M", "virt,accel=kvm"] if args.arch == "aarch64"
               else ["-machine", "accel=kvm"])
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


class VM:
    def __init__(self, args, arch, disk: Path, seed: Path):
        self.args, self.arch, self.disk, self.seed = args, arch, disk, seed
        self.console = args.workdir / f"console-{args.arch}.log"
        self.pidfile = args.workdir / f"vm-{args.arch}.pid"
        self.key = args.workdir / "vm-key"

    def start(self) -> None:
        args, arch = self.args, self.arch
        kvm = probe_kvm(args, arch)
        cpu = "host" if kvm else "max"
        accel = "kvm" if kvm else "tcg"
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
               "-drive", f"if=virtio,format=qcow2,file={self.disk}",
               "-drive", f"if=virtio,format=raw,readonly=on,file={self.seed}",
               "-netdev",
               f"user,id=n0,hostfwd=tcp:127.0.0.1:{args.ssh_port}-:22",
               "-device", "virtio-net-pci,netdev=n0",
               *shlex.split(args.qemu_args)]
        log(f"qemu ({accel}): {' '.join(cmd)}")
        self.pidfile.unlink(missing_ok=True)
        run(cmd, check=True, timeout=60)

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
            die(f"vm command {cmd!r} exited {r.returncode}: "
                f"{(r.stderr or r.stdout).strip()[-400:]}")
        return r

    def scp(self, paths: list[Path], dest: str) -> None:
        run(["scp", "-q", "-P", str(self.args.ssh_port), "-i", str(self.key),
             "-o", "StrictHostKeyChecking=no",
             "-o", "UserKnownHostsFile=/dev/null", "-o", "LogLevel=ERROR",
             *map(str, paths), f"badc@127.0.0.1:{dest}"],
            timeout=600, check=True)

    def wait_ssh(self, timeout: int, expect_boot_id: str | None = None) -> str:
        """Wait until ssh answers; with expect_boot_id, until a new boot."""
        deadline = time.time() + timeout
        while time.time() < deadline:
            if self.pid() is None:
                die(f"qemu exited while waiting for ssh "
                    f"(console: {self.console})")
            r = self.ssh("cat /proc/sys/kernel/random/boot_id", timeout=20)
            bid = r.stdout.strip()
            if r.returncode == 0 and bid and bid != expect_boot_id:
                return bid
            time.sleep(5)
        die(f"vm ssh not reachable within {timeout}s "
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


def probes(vm: VM) -> dict:
    out: dict = {}
    out["uname"] = vm.ssh("uname -r", check=True).stdout.strip()
    out["proc_version"] = vm.ssh("cat /proc/version").stdout.strip()
    out["dmesg_banner"] = vm.ssh("dmesg | head -1", sudo=True).stdout.strip()
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
    out["blk"] = vm.ssh("lsblk -dno NAME,SIZE | tr '\\n' ' '").stdout.strip()
    disk = vm.ssh(
        "dd if=/dev/urandom of=io-probe bs=1M count=64 conv=fsync 2>/dev/null"
        " && sha256sum io-probe && sudo sh -c 'echo 3 > /proc/sys/vm/"
        "drop_caches' && sha256sum io-probe && rm io-probe", timeout=300)
    sums = re.findall(r"^([0-9a-f]{64}) ", disk.stdout, re.M)
    out["disk_rw"] = (disk.returncode == 0 and len(sums) == 2
                      and sums[0] == sums[1])
    return out


def phase_vm(args, arch, packages: list[Path], failures: list[str]) -> dict:
    image = ensure_image(args, arch)
    seed = make_seed(args)
    disk = args.workdir / f"disk-{args.arch}.qcow2"
    disk.unlink(missing_ok=True)
    run(["qemu-img", "create", "-q", "-f", "qcow2", "-b", str(image.resolve()),
         "-F", "qcow2", str(disk), args.vm_disk], check=True)

    vm = VM(args, arch, disk, seed)
    vm.start()
    result: dict = {"image": image.name, "image_sha256": sha256_of(image)}
    try:
        boot_id = vm.wait_ssh(args.vm_timeout)
        log("stock system up; capturing baseline")
        base = probes(vm)
        result["stock"] = base
        log(f"stock: uname={base['uname']} systemd={base['systemd_state']} "
            f"modules={len(base['modules'])}")

        log(f"installing {', '.join(p.name for p in packages)}")
        vm.scp(packages, "")
        names = " ".join(shlex.quote(p.name) for p in packages)
        if arch["pkg"] == "deb":
            r = vm.ssh(f"dpkg -i {names}", sudo=True, timeout=1800)
        else:
            r = vm.ssh(f"rpm -ivh {names}", sudo=True, timeout=1800)
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
                vm.ssh("grub-reboot 'Advanced options for Debian GNU/Linux>"
                       f"Debian GNU/Linux, with Linux {args.release}'",
                       sudo=True, check=True)
                result["boot_select"] = "grub-reboot one-shot"

        log(f"rebooting into {args.release} ({result['boot_select']})")
        vm.reboot(args.vm_timeout, boot_id)
        cur = probes(vm)
        result["badc"] = cur
        log(f"badc: uname={cur['uname']} systemd={cur['systemd_state']} "
            f"modules={len(cur['modules'])}")

        if cur["uname"] != args.release:
            failures.append(f"booted {cur['uname']}, expected {args.release}")
            return result
        # TODO: require "badc" once the compiler identification lands (the
        # banner text is CONFIG_CC_VERSION_TEXT, probed from the reference
        # compiler at configure time). Recorded, not asserted, until then.
        result["compiler_id"] = {
            "banner": cur["proc_version"],
            "names_badc": "badc" in cur["proc_version"].lower(),
            "expected_fail": "badc" not in cur["proc_version"].lower(),
        }
        if not result["compiler_id"]["names_badc"]:
            log(f"compiler-id (expected-fail): banner names the reference "
                f"compiler: {cur['proc_version'][:120]}")
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
        if "virtio" not in cur["net_driver"]:
            failures.append(f"network device not on virtio: "
                            f"{cur['net_driver']!r}")

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
    finally:
        try:
            vm.stop()
        except SystemExit:
            raise
        except Exception as e:  # teardown must not mask the verdict
            log(f"vm teardown: {e}")
    return result


# --- main -------------------------------------------------------------------

def main() -> int:
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--arch", choices=sorted(ARCHES), default=host_arch())
    ap.add_argument("--badc", type=Path,
                    default=os.environ.get("BADC",
                                           REPO_ROOT / "target/release/badc"))
    ap.add_argument("--real-cc", default=os.environ.get("BADC_REAL_CC", "gcc"))
    ap.add_argument("--tarball", type=Path,
                    help="pinned kernel source tarball (see setup.py)")
    ap.add_argument("--config", type=Path,
                    help="kernel .config to build (default: make defconfig)")
    ap.add_argument("-j", "--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--unit-timeout", type=int, default=600,
                    help="seconds per badc unit")
    ap.add_argument("--expect-units", type=int, default=0,
                    help="minimum badc-compiled units (default: per-arch)")
    ap.add_argument("--phases", default="tree,build,package,vm",
                    help="comma-separated subset of tree,build,package,vm")
    ap.add_argument("--deb-tools", type=Path,
                    help="prefix for the Debian packaging tools on an rpm "
                         "host; provisioned there when missing")
    ap.add_argument("--image", type=Path,
                    help="cloud image (default: fetch the pinned URL)")
    ap.add_argument("--ssh-port", type=int, default=22422)
    ap.add_argument("--vm-cpus", type=int, default=2)
    ap.add_argument("--vm-mem", type=int, default=2048)
    ap.add_argument("--vm-disk", default="12G")
    ap.add_argument("--vm-timeout", type=int, default=900,
                    help="seconds to wait for ssh after a boot")
    ap.add_argument("--qemu-args", default="")
    ap.add_argument("--workdir", type=Path,
                    default=Path.cwd() / "packages-out")
    ap.add_argument("--report", type=Path)
    args = ap.parse_args()

    arch = ARCHES[args.arch]
    phases = set(args.phases.split(","))
    if unknown := phases - {"tree", "build", "package", "vm"}:
        die(f"unknown phases: {sorted(unknown)}")
    args.workdir = args.workdir.resolve()
    args.workdir.mkdir(parents=True, exist_ok=True)
    args.badc = Path(args.badc).resolve()
    args.manifest = args.workdir / f"manifest-{args.arch}.txt"
    if not args.expect_units:
        args.expect_units = arch["expect_units"]
    if {"tree", "build", "package"} & phases and not os.access(args.badc,
                                                               os.X_OK):
        die(f"badc not executable: {args.badc} "
            f"(cargo build --release --features full)")
    if args.deb_tools:
        args.deb_tools = args.deb_tools.resolve()
    elif arch["pkg"] == "deb" and not shutil.which("dpkg-buildpackage"):
        args.deb_tools = args.workdir / "deb-tools"

    failures: list[str] = []
    report: dict = {"arch": args.arch, "packages": []}

    if "tree" in phases:
        if not args.tarball or not args.tarball.is_file():
            die("--tarball is required for the tree phase")
        tree = phase_tree(args, arch)
    else:
        trees = sorted(args.workdir.glob("linux-*/Makefile"))
        if not trees:
            die(f"no prepared tree under {args.workdir}; run the tree phase")
        tree = trees[0].parent
    args.release = run(["make", "-s", "kernelrelease"], cwd=tree,
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
    sys.exit(main())
