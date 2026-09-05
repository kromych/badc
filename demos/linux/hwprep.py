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

  panic     a bounded panic, an oops that implies one and a detected lockup
            that implies one, so a fatal fault reboots into the stock kernel
            instead of sitting at a dead console
  watchdog  a hardware watchdog through systemd, the only recovery for a hang
            that never panics -- systemd stops petting it and the board resets
  pstore    the firmware post-mortem store, which keeps the dying kernel log
            across the reboot when nothing is watching the console
  netconsole  the kernel log to a UDP collector, for everything from the
            interface's appearance on
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
import re
import shutil
import subprocess
import sys
import time

STATE_DEFAULT = "/var/lib/badc-hwprep"
MANIFEST = "manifest.json"

NETCONSOLE_OPTIONS = "/etc/modprobe.d/badc-netconsole.conf"
NETCONSOLE_RULE = "/etc/udev/rules.d/99-badc-netconsole.rules"
NETCONSOLE_MODULES_LOAD = "/etc/modules-load.d/badc-netconsole.conf"

# A detected lockup is otherwise a warning to a console this class of box does
# not have. These turn one into a panic, which pstore records and `panic=`
# reboots out of. `nmi_watchdog=panic` is the boot-parameter form:
# hardlockup_panic is a sysctl name, which the command line does not take.
LOCKUP_ARGS = ("nmi_watchdog=panic", "softlockup_panic=1")


def netconsole_interface(spec):
    """The local interface a netconsole specification names, if any.

    netconsole=[+][src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-mac]"""
    local = spec.split(",", 1)[0]
    return local.split("/", 1)[1].strip() if "/" in local else ""


def netconsole_rule(iface, modprobe):
    """The udev rule that loads netconsole once the interface exists.

    udev applies rules before it renames an interface, so the add event still
    carries the kernel's name; the rename that follows emits a move event
    carrying the configured one. Matching both reaches the interface whether
    or not it is renamed, and modprobe on a loaded module changes nothing."""
    return (
        "# netconsole binds netpoll to the interface as it loads. Loading it\n"
        "# before the driver has probed leaves netpoll nothing to bind to and\n"
        "# the target is dropped for the rest of the boot.\n"
        'ACTION=="add|move", SUBSYSTEM=="net", ENV{INTERFACE}=="%s", '
        'RUN+="%s netconsole"\n' % (iface, modprobe)
    )


def rule_interface(text):
    """The interface a written rule matches on."""
    m = re.search(r'ENV\{INTERFACE\}=="([^"]+)"', text)
    return m.group(1) if m else ""


class Prep:
    def __init__(self, state, dry_run, root=""):
        self.state = state
        self.dry_run = dry_run
        self.root = root
        self.manifest = []
        path = os.path.join(state, MANIFEST)
        if os.path.exists(path):
            with open(path) as f:
                self.manifest = json.load(f)

    # -- plumbing ---------------------------------------------------------

    def path(self, p):
        """A system path, under the self-test's root when one is set."""
        return self.root + p if self.root else p

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
        path = self.path(path)
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
        path = self.path(path)
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
        for p in sorted(glob.glob(self.path("/boot/vmlinuz-*")), reverse=True):
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
        if os.path.exists(self.path(f"/sys/module/{name}")):
            return ("module"
                    if os.path.exists(self.path(f"/sys/module/{name}/initstate"))
                    else "builtin")
        return None

    def config_kind(self, symbol, version):
        """"builtin", "module" or None for a symbol in one kernel's config.

        The kernel being prepared is not the one running, and the two can
        differ on any symbol. /boot/config-<version> is that kernel's own
        answer; modinfo only ever answers for the running one."""
        try:
            with open(self.path(f"/boot/config-{version}")) as f:
                text = f.read()
        except OSError:
            return None
        for line in text.splitlines():
            if line.startswith(f"CONFIG_{symbol}="):
                return {"y": "builtin", "m": "module"}.get(
                    line.split("=", 1)[1].strip())
        return None

    def pstore_kind(self):
        return self.module_kind("efi_pstore")

    def pstore_enabled(self):
        try:
            with open(self.path(
                    "/sys/module/efi_pstore/parameters/pstore_disable")) as f:
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

    def select_kernel(self, version):
        """The installed kernel `version` names, or None with a report.

        An exact version wins over a substring: a package's version is
        routinely a prefix of a distribution kernel's (`7.1.10` against
        `7.1.10-200.fc44.x86_64`), and the exact name is unambiguous.
        """
        installed = self.kernels()
        exact = [(v, p) for v, p in installed if v == version]
        matches = exact or [(v, p) for v, p in installed if version in v]
        if len(matches) == 1:
            return matches[0]
        print(f"! {version!r} matches {len(matches)} installed kernels:")
        for v, _ in installed:
            print(f"!   {v}")
        return None

    def cmd_entry(self, args):
        """Give one kernel entry its own arguments, and no other entry any.

        A bounded panic and an oops that implies one turn a fatal fault into a
        reboot back to stock. Removing `rhgb quiet` makes the boot verbose,
        which only matters where something can see it, and costs nothing where
        nothing can.
        """
        chosen = self.select_kernel(args.kernel)
        if chosen is None:
            return 1
        v, path = chosen
        if not self.is_badc_kernel(v):
            print(f"! {v} is not a kernel this tool installed.")
            print("! refusing to change a stock entry's arguments.")
            return 1
        add = self.entry_args(args.panic)
        if args.netconsole:
            self.arm_netconsole(args.netconsole, add, v)
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

    def entry_args(self, panic):
        """The arguments this entry carries, before the optional ones.

        `oops=panic` is the boot-parameter form; `panic_on_oops` is a sysctl
        name and the kernel rejects it on the command line, as it does
        `hardlockup_panic`. The lockup pair is not an option: a box with no
        console has nowhere to report a lockup that does not panic."""
        add = [f"panic={panic}", "oops=panic", "printk.always_kmsg_dump=1"]
        add.extend(LOCKUP_ARGS)
        if self.pstore_kind() == "builtin" and not self.pstore_enabled():
            add.append("efi_pstore.pstore_disable=0")
        return add

    def arm_netconsole(self, spec, add, version):
        """Put the netconsole target where the kernel being prepared reads it.

        Built in, it is a kernel command-line parameter and starts as soon as
        the network driver probes. Built as a module -- which is what both
        Fedora and Ubuntu ship -- the same text on the command line is
        rejected as an unknown parameter and nothing listens, so the target
        goes to modprobe.d and the load is triggered by the interface's own
        udev event. modules-load.d cannot carry it: systemd-modules-load runs
        before the network driver has probed, netpoll finds no interface, the
        target is dropped for the rest of the boot, and the module reports
        that logging started regardless.

        The interface's udev event is the earliest trigger it offers. RUN
        executes in the worker that processed the event, which is before
        systemd is told the device exists and so before anything ordered
        after that device's unit can start.

        The window before the interface appears still belongs to pstore."""
        kind = (self.config_kind("NETCONSOLE", version)
                or self.module_kind("netconsole"))
        if kind == "builtin":
            add.append(f"netconsole={spec}")
            print("  netconsole: builtin, armed on the command line")
            return
        if kind is None:
            print("  ! netconsole is not available on this kernel; no remote log")
            return
        iface = netconsole_interface(spec)
        if not iface:
            print(f"  ! the netconsole spec names no interface: {spec}")
            print("  ! a module is loaded on the interface's own event and")
            print("  ! cannot be armed without one; no remote log")
            return
        modprobe = shutil.which("modprobe") or "/sbin/modprobe"
        self.write_file(NETCONSOLE_OPTIONS,
                        f"options netconsole netconsole={spec}\n")
        self.write_file(NETCONSOLE_RULE, netconsole_rule(iface, modprobe))
        self.unwrite_file(NETCONSOLE_MODULES_LOAD,
                          "it loads netconsole before the driver probes")
        print(f"  netconsole: module, loaded by udev when {iface} appears")
        print("  note: the window before that reaches no collector. pstore")
        print("  covers it.")

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
        entries = [a for a in self.manifest if a.get("action") == "entry"]
        if entries:
            carried = all(x in a["args"] for a in entries for x in LOCKUP_ARGS)
            print(f"  lockup: a detected lockup"
                  f" {'panics' if carried else 'does NOT panic'} on the badc"
                  f" entry ({' '.join(LOCKUP_ARGS)})")
        ok &= self.netconsole_report()

        print("entry arguments")
        for a in self.manifest:
            if a.get("action") == "entry":
                print(f"  {a['version']}: {' '.join(a['args'])}")

        print("one-shot selection")
        print(f"  {self.grub_reboot() or 'NO grub-reboot; boot must be selected by hand'}")
        print()
        print("READY" if ok else "NOT READY")
        return 0 if ok else 1

    def netconsole_route(self):
        """How netconsole is armed, from what is on the machine."""
        for a in self.manifest:
            if a.get("action") == "entry":
                for x in a["args"]:
                    if x.startswith("netconsole="):
                        return f"kernel command line on {a['version']} (builtin)"
        rule = self.path(NETCONSOLE_RULE)
        if os.path.exists(rule):
            with open(rule) as f:
                iface = rule_interface(f.read()) or "an interface"
            return f"udev rule on {iface} (module)"
        return None

    def netconsole_targets(self):
        """Targets carrying on the running kernel, or None where the kernel
        keeps no target list -- netconsole built without dynamic targets, or
        configfs not mounted."""
        base = self.path("/sys/kernel/config/netconsole")
        try:
            names = sorted(os.listdir(base))
        except OSError:
            return None
        live = []
        for name in names:
            try:
                with open(os.path.join(base, name, "enabled")) as f:
                    if f.read().strip() == "1":
                        live.append(name)
            except OSError:
                continue
        return live

    def netconsole_failed(self):
        """Whether the current boot's log records a target that did not set up."""
        text = (self.out(["journalctl", "-b", "-k", "--no-pager"])
                or self.out(["dmesg"]))
        return any("Netpoll setup failed" in line
                   or ("netpoll" in line and "aborting" in line)
                   for line in text.splitlines())

    def netconsole_report(self):
        """The route the entry took, and whether the running kernel is sending.

        netconsole reports that logging started whether or not a target set
        up, so the target list is the evidence and that line is not. Loaded
        with no target it sends nothing for the whole boot, which is not
        repairable from a machine that has no console."""
        ok = True
        print(f"  netconsole route: {self.netconsole_route() or 'not armed'}")
        stale = self.path(NETCONSOLE_MODULES_LOAD)
        if os.path.exists(stale):
            print(f"  ! {NETCONSOLE_MODULES_LOAD} loads netconsole before the")
            print("  ! network driver probes; netpoll aborts and nothing is sent")
            ok = False
        if not os.path.exists(self.path("/sys/module/netconsole")):
            print("  netconsole: not loaded on the running kernel")
            return ok
        targets = self.netconsole_targets()
        if targets:
            print(f"  netconsole: loaded, target {', '.join(targets)}")
        elif targets is None and not self.netconsole_failed():
            print("  netconsole: loaded; this kernel keeps no target list and")
            print("  the log reports no failed target")
        else:
            print("  ! netconsole is loaded with no target: nothing is sent,")
            print("  ! and the module reports that logging started regardless")
            ok = False
        return ok

    # -- boot -------------------------------------------------------------

    def cmd_boot(self, args):
        """Select an entry for exactly one boot. The next boot is stock."""
        chosen = self.select_kernel(args.kernel)
        if chosen is None:
            return 1
        v = chosen[0]
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


def _self_test() -> int:
    """Drive the decisions that need no machine: the netconsole route for a
    modular kernel, the arguments the badc entry carries, and the verdict on
    a netconsole that is loaded with no target. The addresses are the
    documentation range, which names no machine."""
    import contextlib
    import io
    import tempfile

    spec = "6666@192.0.2.10/enp5s0,6666@192.0.2.11/"
    assert netconsole_interface(spec) == "enp5s0"
    assert netconsole_interface("6666@192.0.2.10/,6666@192.0.2.11/") == ""
    assert netconsole_interface("6666@192.0.2.10") == ""
    modprobe = shutil.which("modprobe") or "/sbin/modprobe"
    assert rule_interface(netconsole_rule("eth7", modprobe)) == "eth7"
    quiet = contextlib.redirect_stdout(io.StringIO())

    with tempfile.TemporaryDirectory() as tmp:
        os.makedirs(tmp + "/boot")
        for v in ("7.1.10", "7.1.11"):
            open(f"{tmp}/boot/vmlinuz-{v}", "w").close()
        with open(tmp + "/boot/config-7.1.10", "w") as f:
            f.write("CONFIG_NETCONSOLE=m\nCONFIG_NETCONSOLE_DYNAMIC=y\n")
        with open(tmp + "/boot/config-7.1.11", "w") as f:
            f.write("CONFIG_NETCONSOLE=y\n")
        prep = Prep(tmp + "/state", dry_run=False, root=tmp)
        prep.record_action(action="install", version="7.1.10",
                           package="kernel-7.1.10-2.x86_64.rpm")
        assert prep.config_kind("NETCONSOLE", "7.1.10") == "module"
        assert prep.config_kind("NETCONSOLE", "7.1.11") == "builtin"
        assert prep.config_kind("NETCONSOLE", "7.1.12") is None

        # A modular netconsole loads on the interface's own event, and the
        # modules-load.d entry of the route it replaces goes with it.
        stale = tmp + NETCONSOLE_MODULES_LOAD
        os.makedirs(os.path.dirname(stale))
        with open(stale, "w") as f:
            f.write("netconsole\n")
        add = prep.entry_args(30)
        with quiet:
            prep.arm_netconsole(spec, add, "7.1.10")
        assert not os.path.exists(stale), stale
        with open(tmp + NETCONSOLE_OPTIONS) as f:
            assert f.read() == f"options netconsole netconsole={spec}\n"
        with open(tmp + NETCONSOLE_RULE) as f:
            rule = f.read()
        assert 'ACTION=="add|move", SUBSYSTEM=="net"' in rule, rule
        assert 'ENV{INTERFACE}=="enp5s0"' in rule, rule
        assert f'RUN+="{modprobe} netconsole"' in rule, rule
        assert not [x for x in add if x.startswith("netconsole=")], add
        assert prep.netconsole_route() == "udev rule on enp5s0 (module)"

        # The entry carries the lockup pair whether or not anything asked.
        assert add == ["panic=30", "oops=panic", "printk.always_kmsg_dump=1",
                       "nmi_watchdog=panic", "softlockup_panic=1"], add

        # A builtin netconsole keeps the command line and writes no file.
        before = sorted(os.listdir(tmp + "/etc"))
        builtin = prep.entry_args(30)
        with quiet:
            prep.arm_netconsole(spec, builtin, "7.1.11")
        assert f"netconsole={spec}" in builtin, builtin
        assert sorted(os.listdir(tmp + "/etc")) == before

        # Loaded with no target is the state that sends nothing all boot.
        os.makedirs(tmp + "/sys/module/netconsole")
        os.makedirs(tmp + "/sys/kernel/config/netconsole")
        out = io.StringIO()
        with contextlib.redirect_stdout(out):
            rc = prep.cmd_check(argparse.Namespace())
        assert rc == 1, out.getvalue()
        assert "netconsole is loaded with no target" in out.getvalue(), out.getvalue()

        target = tmp + "/sys/kernel/config/netconsole/cmdline0"
        os.makedirs(target)
        with open(target + "/enabled", "w") as f:
            f.write("1\n")
        out = io.StringIO()
        with contextlib.redirect_stdout(out):
            prep.cmd_check(argparse.Namespace())
        assert "netconsole: loaded, target cmdline0" in out.getvalue(), out.getvalue()
        assert "no target" not in out.getvalue(), out.getvalue()

        # The entry's own arguments decide what check reports about lockups,
        # so an entry left by an earlier run is visible rather than assumed.
        prep.record_action(action="entry", version="7.1.10",
                           path="/boot/vmlinuz-7.1.10", args=add)
        out = io.StringIO()
        with contextlib.redirect_stdout(out):
            prep.cmd_check(argparse.Namespace())
        assert "lockup: a detected lockup panics" in out.getvalue(), out.getvalue()

        prep.record_action(action="entry", version="7.1.10",
                           path="/boot/vmlinuz-7.1.10", args=["panic=30"])
        out = io.StringIO()
        with contextlib.redirect_stdout(out):
            prep.cmd_check(argparse.Namespace())
        assert "lockup: a detected lockup does NOT panic" in out.getvalue(), \
            out.getvalue()

        # A package's version is routinely a prefix of a distribution
        # kernel's, so the exact name has to win over the substring.
        prep.kernels = lambda: [
            ("7.1.10", "/boot/vmlinuz-7.1.10"),
            ("7.1.10-200.fc44.x86_64", "/boot/vmlinuz-7.1.10-200.fc44.x86_64"),
            ("6.19.10-300.fc44.x86_64", "/boot/vmlinuz-6.19.10-300.fc44.x86_64"),
        ]
        assert prep.select_kernel("7.1.10")[0] == "7.1.10"
        assert prep.select_kernel("200.fc44")[0] == "7.1.10-200.fc44.x86_64"
        out = io.StringIO()
        with contextlib.redirect_stdout(out):
            assert prep.select_kernel("fc44") is None
        assert "matches 2 installed kernels" in out.getvalue(), out.getvalue()

    print("linux hwprep: self-test ok", flush=True)
    return 0


def main():
    p = argparse.ArgumentParser(
        description=__doc__.split("\n")[0],
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="Run on the machine being prepared, as root.",
    )
    p.add_argument("--state", default=STATE_DEFAULT, help="where the record lives")
    p.add_argument("--dry-run", action="store_true", help="print, change nothing")
    p.add_argument("--self-test", action="store_true",
                   help="check the routing and the verdicts, no machine")
    sub = p.add_subparsers(dest="cmd")

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
    if args.self_test:
        return _self_test()
    if not args.cmd:
        p.error("a subcommand is required")
    if os.geteuid() != 0 and args.cmd not in ("status", "check") and not args.dry_run:
        print(f"! {args.cmd} needs root; re-run under sudo", file=sys.stderr)
        return 1
    prep = Prep(args.state, args.dry_run)
    return getattr(prep, f"cmd_{args.cmd}")(args)


if __name__ == "__main__":
    sys.exit(main())
