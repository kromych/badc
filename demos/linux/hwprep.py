#!/usr/bin/env python3
"""Prepare a machine to boot a badc-built kernel package, and undo it.

The qemu lane proves a package boots an emulated machine. A physical box adds
firmware, real controllers and real timing, and takes away the ability to kill
the guest and read its log. A kernel that fails there can leave a machine that
does not come back on its own.

This stage applies the configuration that makes such a boot recoverable and
observable, records every change it makes, and can replay the record backwards.
Its safety property is one invariant, checked before and after every run:

    the default boot entry is always a stock kernel

so the recovery path is a power cycle, not a rescue disk. A badc kernel is
reached by one-shot selection only, and the boot after it returns to stock
whether it succeeded, panicked, or hung.

What it arms, each optional and each recorded:

  panic     a bounded panic and oops-implies-panic, so a fatal fault reboots
            into the stock kernel instead of sitting at a dead console
  watchdog  a hardware watchdog through systemd, the only recovery for a hang
            that never panics -- systemd stops petting it and the board resets
  pstore    the firmware post-mortem store, which keeps the dying kernel log
            across the reboot when nothing is watching the console
  netconsole  the kernel log to a UDP collector, for everything after the NIC
            comes up
  console   a serial console where the machine has one

Run it on the machine being prepared, as root:

    hwprep.py record                  # snapshot the state to return to
    hwprep.py arm --netconsole ...    # apply the recovery configuration
    hwprep.py install kernel-*.rpm    # add a kernel, never replace one
    hwprep.py entry --kernel 7.1.10   # give that entry its own arguments
    hwprep.py check                   # confirm the invariant holds
    hwprep.py boot --kernel 7.1.10    # select it for exactly one boot
    hwprep.py rollback                # undo everything, in reverse

`--dry-run` prints what each would do and changes nothing.
"""

import argparse
import glob
import json
import os
import shutil
import subprocess
import sys
import time

STATE_DEFAULT = "/var/lib/badc-hwprep"
MANIFEST = "manifest.json"


class Prep:
    def __init__(self, state, dry_run):
        self.state = state
        self.dry_run = dry_run
        self.manifest = []
        path = os.path.join(state, MANIFEST)
        if os.path.exists(path):
            with open(path) as f:
                self.manifest = json.load(f)

    # -- plumbing ---------------------------------------------------------

    def run(self, cmd, check=True, quiet=False):
        if not quiet:
            print(f"  $ {' '.join(cmd)}")
        if self.dry_run:
            return subprocess.CompletedProcess(cmd, 0, "", "")
        return subprocess.run(cmd, capture_output=True, text=True, check=check)

    def out(self, cmd):
        """Command output, or "" when the command is absent or fails."""
        try:
            r = subprocess.run(cmd, capture_output=True, text=True)
            return r.stdout if r.returncode == 0 else ""
        except (FileNotFoundError, OSError):
            return ""

    def record_action(self, **kw):
        kw["when"] = time.strftime("%Y-%m-%dT%H:%M:%S")
        self.manifest.append(kw)
        self.save()

    def save(self):
        if self.dry_run:
            return
        os.makedirs(self.state, exist_ok=True)
        with open(os.path.join(self.state, MANIFEST), "w") as f:
            json.dump(self.manifest, f, indent=2)

    def write_file(self, path, content):
        """Write a config file, recording whether it existed and its content."""
        existed = os.path.exists(path)
        if existed:
            with open(path) as f:
                if f.read() == content:
                    print(f"  {path} already correct")
                    return False
            backup = os.path.join(self.state, "files", path.lstrip("/"))
            if not self.dry_run:
                os.makedirs(os.path.dirname(backup), exist_ok=True)
                shutil.copy2(path, backup)
        print(f"  write {path}")
        if not self.dry_run:
            os.makedirs(os.path.dirname(path), exist_ok=True)
            with open(path, "w") as f:
                f.write(content)
        self.record_action(action="write_file", path=path, existed=existed)
        return True

    def unwrite_file(self, path, why):
        """Remove a file this tool wrote, and forget it. Used when a later
        probe shows the file cannot have the effect it was written for."""
        kept = [
            a for a in self.manifest
            if not (a.get("action") == "write_file" and a.get("path") == path)
        ]
        if os.path.exists(path):
            print(f"  remove {path} ({why})")
            if not self.dry_run:
                os.unlink(path)
        if len(kept) != len(self.manifest):
            self.manifest = kept
            self.save()

    # -- machine facts ----------------------------------------------------

    def bootloader(self):
        if shutil.which("grubby"):
            return "grubby"
        if shutil.which("grub-mkconfig") or shutil.which("grub2-mkconfig"):
            return "grub"
        return None

    def grub_reboot(self):
        for c in ("grub2-reboot", "grub-reboot"):
            if shutil.which(c):
                return c
        return None

    def default_kernel(self):
        d = self.out(["grubby", "--default-kernel"]).strip()
        return d or None

    def kernels(self):
        """Installed kernel versions, newest first, as (version, path)."""
        out = []
        for p in sorted(glob.glob("/boot/vmlinuz-*"), reverse=True):
            out.append((os.path.basename(p)[len("vmlinuz-"):], p))
        return out

    def module_kind(self, name):
        """"module", "builtin", or None.

        The distinction decides where a parameter has to go, and getting it
        wrong is silent both ways: a builtin ignores modprobe.d, and a
        loadable module's parameter on the kernel command line is rejected as
        unknown -- the kernel prints one line about it at boot and carries on
        without the facility the parameter was meant to arm."""
        for line in self.out(["modinfo", name]).splitlines():
            if line.startswith("filename:"):
                return "builtin" if "(builtin)" in line else "module"
        if os.path.exists(f"/sys/module/{name}"):
            return ("module" if os.path.exists(f"/sys/module/{name}/initstate")
                    else "builtin")
        return None

    def pstore_kind(self):
        return self.module_kind("efi_pstore")

    def pstore_enabled(self):
        try:
            with open("/sys/module/efi_pstore/parameters/pstore_disable") as f:
                return f.read().strip() == "N"
        except OSError:
            return False

    def is_badc_kernel(self, version):
        """A kernel this tool installed, per the manifest."""
        return any(
            a.get("action") == "install" and a.get("version") == version
            for a in self.manifest
        )

    # -- the invariant ----------------------------------------------------

    def check_invariant(self, fatal=True):
        """The default boot entry must be a stock kernel."""
        default = self.default_kernel()
        if default is None:
            print("  ! cannot read the default boot entry; check by hand")
            return not fatal
        version = os.path.basename(default)[len("vmlinuz-"):]
        if self.is_badc_kernel(version):
            print(f"  ! DEFAULT IS A BADC KERNEL: {default}")
            print("  ! a failed boot would not come back on its own.")
            print("  ! set a stock kernel as the default before rebooting:")
            for v, p in self.kernels():
                if not self.is_badc_kernel(v):
                    print(f"  !     grubby --set-default={p}")
                    break
            return False
        print(f"  default boot entry: {default} (stock)")
        return True

    # -- record -----------------------------------------------------------

    def cmd_record(self, args):
        """Snapshot the state this machine has to be returned to."""
        print(f"recording into {self.state}")
        snap = os.path.join(self.state, "before")
        if not self.dry_run:
            os.makedirs(snap, exist_ok=True)
        captures = {
            "grubby-info-all.txt": ["grubby", "--info=ALL"],
            "grubby-default.txt": ["grubby", "--default-kernel"],
            "grubenv.txt": ["grub2-editenv", "list"],
            "sysctl-panic.txt": ["sysctl", "kernel.panic", "kernel.panic_on_oops"],
            "uname.txt": ["uname", "-a"],
            "lsblk.txt": ["lsblk", "-o", "NAME,SIZE,FSTYPE,MOUNTPOINT"],
        }
        for name, cmd in captures.items():
            text = self.out(cmd)
            if not text:
                print(f"  - {name}: {cmd[0]} unavailable, skipped")
                continue
            print(f"  + {name}")
            if not self.dry_run:
                with open(os.path.join(snap, name), "w") as f:
                    f.write(text)
        text = "\n".join(f"{v}\t{p}" for v, p in self.kernels())
        print(f"  + kernels.txt ({len(self.kernels())} installed)")
        if not self.dry_run:
            with open(os.path.join(snap, "kernels.txt"), "w") as f:
                f.write(text + "\n")
        for src in ("/etc/default/grub",):
            if os.path.exists(src):
                print(f"  + {os.path.basename(src)}")
                if not self.dry_run:
                    shutil.copy2(src, snap)
        self.record_action(action="record", state=snap)
        print()
        return 0 if self.check_invariant() else 1

    # -- arm --------------------------------------------------------------

    def cmd_arm(self, args):
        """Apply the recovery configuration that is machine-wide and safe.

        Per-boot arguments -- panic, netconsole -- belong to the badc entry
        alone and are applied by `entry`, so the stock kernels keep the
        behaviour they had.
        """
        if not self.manifest:
            print("! run `record` first: without it, rollback has nothing to")
            print("! return the machine to.")
            return 1
        changed = False
        print("pstore: keep the dying kernel log across a reboot")
        kind = self.pstore_kind()
        if kind == "module":
            changed |= self.write_file(
                "/etc/modprobe.d/badc-pstore.conf",
                "# Keep efi_pstore enabled so a panic leaves a log in the\n"
                "# firmware store when nothing is watching a console.\n"
                "options efi_pstore pstore_disable=0\n",
            )
        elif kind == "builtin":
            self.unwrite_file(
                "/etc/modprobe.d/badc-pstore.conf",
                "efi_pstore is builtin; modprobe.d cannot reach it",
            )
            print("  efi_pstore is builtin: modprobe.d does not apply to it.")
            print("  `entry` puts efi_pstore.pstore_disable=0 on the command")
            print("  line instead, which is where a builtin reads it.")
        else:
            print("  - efi_pstore not present, skipped")

        print("watchdog: recovery for a hang that never panics")
        wd = glob.glob("/sys/class/watchdog/watchdog*")
        if wd:
            names = [
                open(os.path.join(w, "identity")).read().strip()
                for w in wd
                if os.path.exists(os.path.join(w, "identity"))
            ]
            print(f"  present: {', '.join(names) or 'unnamed'}")
            changed |= self.write_file(
                "/etc/systemd/system.conf.d/badc-watchdog.conf",
                "[Manager]\n"
                f"RuntimeWatchdogSec={args.watchdog}\n"
                f"RebootWatchdogSec={args.watchdog * 2}\n",
            )
        else:
            print("  - no watchdog device, skipped")

        if changed and not self.dry_run:
            print("applying")
            self.run(["systemctl", "daemon-reexec"], check=False)
            if shutil.which("dracut"):
                print("  rebuilding the initramfs (this takes a minute)")
                self.run(["dracut", "-f"], check=False)
        print()
        return 0

    # -- install ----------------------------------------------------------

    def cmd_install(self, args):
        """Add a kernel package. It adds a version; it replaces none."""
        pkg = args.package
        if not os.path.exists(pkg):
            print(f"! no such package: {pkg}")
            return 1
        before = {v for v, _ in self.kernels()}
        default_before = self.default_kernel()
        if pkg.endswith(".rpm"):
            cmd = ["rpm", "-ivh", "--oldpackage", pkg]
        elif pkg.endswith(".deb"):
            cmd = ["dpkg", "-i", pkg]
        else:
            print(f"! unrecognized package type: {pkg}")
            return 1
        print(f"installing {os.path.basename(pkg)}")
        r = self.run(cmd, check=False)
        if r.returncode != 0:
            print(r.stdout + r.stderr)
            return r.returncode
        after = {v for v, _ in self.kernels()}
        added = sorted(after - before)
        if not added and not self.dry_run:
            print("! the package installed but added no /boot/vmlinuz-*.")
            print("! nothing to boot; check the package contents.")
            return 1
        for v in added:
            print(f"  added {v}")
            self.record_action(
                action="install", version=v, package=os.path.basename(pkg)
            )
        self.restore_default(default_before)
        print()
        return 0 if self.check_invariant() else 1

    def restore_default(self, default_before):
        """Put the default boot entry back where it was.

        A distribution's kernel install scripts make the kernel they just
        installed the default: on Fedora, `rpm -i` of a kernel package leaves
        the machine one reboot away from starting a kernel that may not come
        back. Detecting that after the fact is not enough when the window is
        a reboot wide, so it is undone here."""
        if not default_before:
            return
        now = self.default_kernel()
        if not now or now == default_before:
            return
        version = os.path.basename(now)[len("vmlinuz-"):]
        if not self.is_badc_kernel(version):
            return
        print(f"  the package took the default: {now}")
        print(f"  restoring {default_before}")
        r = self.run(["grubby", f"--set-default={default_before}"], check=False)
        if r.returncode != 0:
            print(r.stdout + r.stderr)

    # -- entry ------------------------------------------------------------

    def cmd_entry(self, args):
        """Give one kernel entry its own arguments, and no other entry any.

        A bounded panic and an oops that implies one turn a fatal fault into a
        reboot back to stock. Removing `rhgb quiet` makes the boot verbose,
        which only matters where something can see it, and costs nothing where
        nothing can.
        """
        version = args.kernel
        matches = [(v, p) for v, p in self.kernels() if version in v]
        if len(matches) != 1:
            print(f"! {version!r} matches {len(matches)} installed kernels:")
            for v, _ in self.kernels():
                print(f"!   {v}")
            return 1
        v, path = matches[0]
        if not self.is_badc_kernel(v):
            print(f"! {v} is not a kernel this tool installed.")
            print("! refusing to change a stock entry's arguments.")
            return 1
        # `oops=panic` is the boot-parameter form. `panic_on_oops` is a
        # sysctl name and the kernel rejects it on the command line.
        add = [
            f"panic={args.panic}",
            "oops=panic",
            "printk.always_kmsg_dump=1",
        ]
        if self.pstore_kind() == "builtin" and not self.pstore_enabled():
            add.append("efi_pstore.pstore_disable=0")
        if args.netconsole:
            self.arm_netconsole(args.netconsole, add)
        if args.console:
            add.append(f"console={args.console}")
        if args.args:
            add.extend(args.args.split())
        print(f"entry {v}")
        print(f"  args   {' '.join(add)}")
        print("  remove rhgb quiet")
        r = self.run(
            [
                "grubby",
                f"--update-kernel={path}",
                f"--args={' '.join(add)}",
                "--remove-args=rhgb quiet",
            ],
            check=False,
        )
        if r.returncode != 0:
            print(r.stdout + r.stderr)
            return r.returncode
        self.record_action(action="entry", version=v, path=path, args=add)
        print()
        return 0 if self.check_invariant() else 1

    def arm_netconsole(self, spec, add):
        """Put the netconsole target where the build will actually read it.

        Built in, it is a kernel command-line parameter and starts as soon as
        the network driver probes. Built as a module -- which is what both
        Fedora and Ubuntu ship -- the same text on the command line is
        rejected as an unknown parameter and nothing listens, so it goes to
        modprobe.d with a modules-load.d entry to load it. That costs the
        early window: the module loads from userspace, so a failure before
        then reaches no collector, and pstore remains the only record."""
        kind = self.module_kind("netconsole")
        if kind == "builtin":
            add.append(f"netconsole={spec}")
            print("  netconsole: builtin, armed on the command line")
            return
        if kind is None:
            print("  ! netconsole is not available on this kernel; no remote log")
            return
        self.write_file("/etc/modprobe.d/badc-netconsole.conf",
                        f"options netconsole netconsole={spec}\n")
        self.write_file("/etc/modules-load.d/badc-netconsole.conf",
                        "netconsole\n")
        print("  netconsole: module, armed via modprobe.d + modules-load.d")
        print("  note: it loads from userspace, so a failure before that")
        print("  reaches no collector. pstore covers that window.")

    # -- check ------------------------------------------------------------

    def cmd_check(self, args):
        """Confirm every precondition for a boot that can be recovered."""
        ok = True
        print("invariant")
        ok &= self.check_invariant()

        print("stock kernels available to fall back to")
        stock = [v for v, _ in self.kernels() if not self.is_badc_kernel(v)]
        print(f"  {len(stock)}: {', '.join(stock) or 'NONE'}")
        if not stock:
            print("  ! nothing to fall back to. Do not reboot.")
            ok = False

        print("badc kernels installed")
        badc = [v for v, _ in self.kernels() if self.is_badc_kernel(v)]
        print(f"  {len(badc)}: {', '.join(badc) or 'none'}")

        print("recovery configuration")
        kind = self.pstore_kind()
        if kind is None:
            print("  pstore: absent on this machine")
        elif self.pstore_enabled():
            print(f"  pstore: enabled ({kind})")
        elif kind == "builtin":
            armed = any(
                a.get("action") == "entry"
                and any(x.startswith("efi_pstore.") for x in a["args"])
                for a in self.manifest
            )
            print(f"  pstore: builtin, disabled on the running kernel; the badc"
                  f" entry {'carries' if armed else 'does NOT carry'} the parameter")
        else:
            print("  pstore: module, disabled; reboot to pick up modprobe.d")
        wd = self.out(["systemctl", "show", "-p", "RuntimeWatchdogUSec"]).strip()
        live = wd.endswith("=0") or not wd
        print(f"  watchdog: {'NOT armed' if live else wd.split('=')[-1] + ' runtime timeout'}")

        print("entry arguments")
        for a in self.manifest:
            if a.get("action") == "entry":
                print(f"  {a['version']}: {' '.join(a['args'])}")

        print("one-shot selection")
        print(f"  {self.grub_reboot() or 'NO grub-reboot; boot must be selected by hand'}")
        print()
        print("READY" if ok else "NOT READY")
        return 0 if ok else 1

    # -- boot -------------------------------------------------------------

    def cmd_boot(self, args):
        """Select an entry for exactly one boot. The next boot is stock."""
        version = args.kernel
        matches = [v for v, _ in self.kernels() if version in v]
        if len(matches) != 1:
            print(f"! {version!r} matches {len(matches)} installed kernels")
            return 1
        v = matches[0]
        if not self.is_badc_kernel(v):
            print(f"! {v} is not a badc kernel; nothing to select")
            return 1
        if not self.check_invariant():
            return 1
        cmd = self.grub_reboot()
        if not cmd:
            print("! no grub-reboot on this machine; select the entry by hand")
            return 1
        title = self.out(["grubby", "--info", f"/boot/vmlinuz-{v}"])
        index = None
        for line in title.splitlines():
            if line.startswith("index="):
                index = line.split("=", 1)[1].strip()
        if index is None:
            print("! cannot determine the entry index")
            return 1
        print(f"selecting {v} (index {index}) for one boot")
        r = self.run([cmd, index], check=False)
        if r.returncode != 0:
            print(r.stdout + r.stderr)
            return r.returncode
        self.record_action(action="boot", version=v, index=index)
        print()
        print("The next boot uses this kernel. Every boot after it is stock,")
        print("whether it succeeds, panics or hangs. Reboot when ready:")
        print("    systemctl reboot")
        return 0

    # -- rollback ---------------------------------------------------------

    def cmd_rollback(self, args):
        """Replay the record backwards. Every step is idempotent."""
        if not self.manifest:
            print("nothing recorded; nothing to undo")
            return 0
        print(f"undoing {len(self.manifest)} recorded changes, newest first")
        remaining = []
        for a in reversed(self.manifest):
            act = a.get("action")
            if act == "entry":
                print(f"  entry {a['version']}: removing its arguments")
                self.run(
                    [
                        "grubby",
                        f"--update-kernel={a['path']}",
                        f"--remove-args={' '.join(a['args'])}",
                    ],
                    check=False,
                )
            elif act == "install":
                if args.keep_kernels:
                    print(f"  kernel {a['version']}: kept (--keep-kernels)")
                    remaining.append(a)
                    continue
                print(f"  kernel {a['version']}: removing")
                pkg = a.get("package", "")
                if pkg.endswith(".deb"):
                    self.run(["dpkg", "-r", f"linux-image-{a['version']}"], check=False)
                else:
                    self.run(["rpm", "-e", f"kernel-{a['version']}"], check=False)
            elif act == "write_file":
                path = a["path"]
                backup = os.path.join(self.state, "files", path.lstrip("/"))
                if a.get("existed") and os.path.exists(backup):
                    print(f"  {path}: restoring")
                    if not self.dry_run:
                        shutil.copy2(backup, path)
                elif os.path.exists(path):
                    print(f"  {path}: removing")
                    if not self.dry_run:
                        os.unlink(path)
            elif act in ("record", "boot"):
                continue
        self.manifest = remaining
        self.save()
        if not self.dry_run:
            self.run(["systemctl", "daemon-reexec"], check=False)
            if shutil.which("dracut"):
                self.run(["dracut", "-f"], check=False)
        print()
        print("state after rollback")
        self.check_invariant()
        snap = os.path.join(self.state, "before", "kernels.txt")
        if os.path.exists(snap):
            with open(snap) as f:
                before = {l.split("\t")[0] for l in f.read().splitlines() if l}
            now = {v for v, _ in self.kernels()}
            extra, missing = sorted(now - before), sorted(before - now)
            print(f"  kernels now: {len(now)}, recorded before: {len(before)}")
            if extra:
                print(f"  ! still installed beyond the record: {', '.join(extra)}")
            if missing:
                print(f"  ! recorded but now absent: {', '.join(missing)}")
            if not extra and not missing:
                print("  kernel set matches the record")
        return 0

    # -- status -----------------------------------------------------------

    def cmd_status(self, args):
        print(f"state directory: {self.state}")
        print(f"recorded changes: {len(self.manifest)}")
        for a in self.manifest:
            detail = {k: v for k, v in a.items() if k not in ("action", "when")}
            print(f"  {a['when']}  {a['action']:<11} {detail}")
        print()
        print(f"running kernel: {os.uname().release}")
        for v, _ in self.kernels():
            tag = "badc" if self.is_badc_kernel(v) else "stock"
            print(f"  {tag:<5} {v}")
        print()
        self.check_invariant()
        return 0


def main():
    p = argparse.ArgumentParser(
        description=__doc__.split("\n")[0],
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="Run on the machine being prepared, as root.",
    )
    p.add_argument("--state", default=STATE_DEFAULT, help="where the record lives")
    p.add_argument("--dry-run", action="store_true", help="print, change nothing")
    sub = p.add_subparsers(dest="cmd", required=True)

    sub.add_parser("record", help="snapshot the state to return to")

    a = sub.add_parser("arm", help="apply pstore and watchdog recovery")
    a.add_argument("--watchdog", type=int, default=60, help="RuntimeWatchdogSec")

    a = sub.add_parser("install", help="add a kernel package")
    a.add_argument("package", help="the .rpm or .deb to install")

    a = sub.add_parser("entry", help="give one badc entry its own arguments")
    a.add_argument("--kernel", required=True, help="version, or a unique substring")
    a.add_argument("--panic", type=int, default=30, help="seconds before reboot")
    a.add_argument("--netconsole", help="the netconsole= specification")
    a.add_argument("--console", help="console= where the machine has one")
    a.add_argument("--args", help="further arguments for this entry only")

    sub.add_parser("check", help="confirm the boot can be recovered")

    a = sub.add_parser("boot", help="select an entry for exactly one boot")
    a.add_argument("--kernel", required=True, help="version, or a unique substring")

    a = sub.add_parser("rollback", help="undo every recorded change")
    a.add_argument("--keep-kernels", action="store_true", help="leave packages installed")

    sub.add_parser("status", help="what is recorded and what is installed")

    args = p.parse_args()
    if os.geteuid() != 0 and args.cmd not in ("status", "check") and not args.dry_run:
        print(f"! {args.cmd} needs root; re-run under sudo", file=sys.stderr)
        return 1
    prep = Prep(args.state, args.dry_run)
    return getattr(prep, f"cmd_{args.cmd}")(args)


if __name__ == "__main__":
    sys.exit(main())
