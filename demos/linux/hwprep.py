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
  netconsole  the kernel log to a UDP collector, from the interface's
            appearance on, at whatever console_loglevel admits
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


def entry_args_of(text):
    """The arguments one `grubby --info` record carries."""
    for line in text.splitlines():
        if line.startswith("args="):
            return line.split("=", 1)[1].strip().strip('"').split()
    return []


def out_fixture(cmd):
    """The file under <root>/.out that answers one command."""
    return re.sub(r"[^A-Za-z0-9.-]+", "_", " ".join(cmd)).strip("_")


class Verdict:
    """One check's finding: what was observed, and what that decides.

    A check that cannot observe the fact reports UNKNOWN. That is not a
    failure: the operator is told the answer is missing rather than given a
    wrong one, so a real NOT READY is not lost among checks that could not
    see. UNKNOWN gates only where the gate has to fail closed."""

    OK, BAD, UNKNOWN = "ok", "bad", "unknown"
    MARK = {OK: "  ", BAD: "  ! ", UNKNOWN: "  ? "}

    def __init__(self, state, finding, *notes, gates=False):
        self.state = state
        self.finding = finding
        self.notes = notes
        self.gates = gates

    @classmethod
    def ok(cls, finding, *notes):
        return cls(cls.OK, finding, *notes)

    @classmethod
    def bad(cls, finding, *notes):
        return cls(cls.BAD, finding, *notes)

    @classmethod
    def unknown(cls, finding, *notes, gates=False):
        return cls(cls.UNKNOWN, finding, *notes, gates=gates)

    @property
    def blocks(self):
        return self.state == self.BAD or (self.state == self.UNKNOWN
                                          and self.gates)

    def report(self):
        print(self.MARK[self.state] + self.finding)
        for line in self.notes:
            print(self.MARK[self.state] + "  " + line)
        return self


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
        if self.dry_run or self.root:
            return subprocess.CompletedProcess(cmd, 0, "", "")
        return subprocess.run(cmd, capture_output=True, text=True, check=check)

    def out(self, cmd):
        """Command output, or None when the command is absent or fails.

        None means the fact was not observed, which is not an empty answer;
        the callers keep the two apart.

        Under a root this object describes a tree rather than the machine it
        runs on, and path() cannot redirect a subprocess, so commands are
        answered from the tree too -- <root>/.out/<out_fixture(cmd)>, and
        unobserved without it. Nothing under a root reaches the host."""
        if self.root:
            try:
                with open(os.path.join(self.root, ".out",
                                       out_fixture(cmd))) as f:
                    return f.read()
            except OSError:
                return None
        try:
            r = subprocess.run(cmd, capture_output=True, text=True)
            return r.stdout if r.returncode == 0 else None
        except (FileNotFoundError, OSError):
            return None

    def which(self, name):
        """A host program's path, and nothing under a root. See out()."""
        return None if self.root else shutil.which(name)

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
        if self.which("grubby"):
            return "grubby"
        if self.which("grub-mkconfig") or self.which("grub2-mkconfig"):
            return "grub"
        return None

    def grub_reboot(self):
        for c in ("grub2-reboot", "grub-reboot"):
            if self.which(c):
                return c
        return None

    def default_kernel(self):
        d = (self.out(["grubby", "--default-kernel"]) or "").strip()
        return d or None

    def kernels(self):
        """Installed kernel versions, newest first, as (version, path)."""
        out = []
        for p in sorted(glob.glob(self.path("/boot/vmlinuz-*")), reverse=True):
            out.append((os.path.basename(p)[len("vmlinuz-"):], p))
        return out

    def module_kind(self, name):
        """"module", "builtin", "absent", or None where nothing answered.

        The distinction decides where a parameter has to go, and getting it
        wrong is silent both ways: a builtin ignores modprobe.d, and a
        loadable module's parameter on the kernel command line is rejected as
        unknown -- the kernel prints one line about it at boot and carries on
        without the facility the parameter was meant to arm."""
        text = self.out(["modinfo", name])
        for line in (text or "").splitlines():
            if line.startswith("filename:"):
                return "builtin" if "(builtin)" in line else "module"
        if os.path.exists(self.path(f"/sys/module/{name}")):
            return ("module"
                    if os.path.exists(self.path(f"/sys/module/{name}/initstate"))
                    else "builtin")
        return "absent" if text is not None else None

    def config_kind(self, symbol, version):
        """"builtin", "module", "absent", or None where the config is
        unreadable.

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
                kind = {"y": "builtin", "m": "module"}.get(
                    line.split("=", 1)[1].strip())
                if kind:
                    return kind
        return "absent"

    def pstore_kind(self):
        return self.module_kind("efi_pstore")

    def pstore_enabled(self):
        """Whether efi_pstore is enabled now, or None where the parameter
        cannot be read."""
        try:
            with open(self.path(
                    "/sys/module/efi_pstore/parameters/pstore_disable")) as f:
                return f.read().strip() == "N"
        except OSError:
            return None

    def is_badc_kernel(self, version):
        """A kernel this tool installed, per the manifest, which is the only
        record of where a kernel came from."""
        return any(
            a.get("action") == "install" and a.get("version") == version
            for a in self.manifest
        )

    # -- boot loader entries ----------------------------------------------

    def live_entry_args(self, path):
        """The arguments the boot loader carries for one entry now, or None
        where it cannot be read.

        The entry is what the kernel reads. The manifest is a rollback
        record and can be older than the entry, so it does not answer for
        it."""
        text = self.out(["grubby", f"--info={path}"])
        return None if text is None else entry_args_of(text)

    def entry_records(self):
        """One record per kernel this tool gave arguments to, the arguments
        unioned. Manifests written before this held one record per run, and
        rollback has to remove every argument ever applied to an entry."""
        out = {}
        for a in self.manifest:
            if a.get("action") != "entry":
                continue
            args = list(out[a["version"]]["args"]) if a["version"] in out else []
            args += [x for x in a["args"] if x not in args]
            out[a["version"]] = dict(a, args=args)
        return list(out.values())

    def record_entry(self, version, path, args):
        """Replace this kernel's entry record, keeping the union of every
        argument applied to it."""
        merged = list(args)
        for rec in self.entry_records():
            if rec["version"] == version:
                merged += [x for x in rec["args"] if x not in merged]
        self.manifest = [
            a for a in self.manifest
            if not (a.get("action") == "entry" and a.get("version") == version)
        ]
        self.record_action(action="entry", version=version, path=path,
                           args=merged)

    def prepared_entries(self):
        """Each prepared kernel as (version, args, live).

        `live` says whether the arguments came from the boot loader or, when
        it could not be read, from the manifest record; every verdict drawn
        from them says which it read."""
        for rec in self.entry_records():
            live = self.live_entry_args(rec["path"])
            if live is None:
                yield rec["version"], rec["args"], False
            else:
                yield rec["version"], live, True

    # -- the invariant ----------------------------------------------------

    def check_invariant(self):
        """The default boot entry must be a stock kernel.

        The recovery path is this invariant, so an answer that cannot be read
        blocks: this is the one check where not knowing is not good enough."""
        default = self.default_kernel()
        if default is None:
            return Verdict.unknown(
                "cannot read the default boot entry; check by hand",
                "grubby answered nothing: run as root, or check the entry",
                gates=True)
        version = os.path.basename(default)[len("vmlinuz-"):]
        if self.is_badc_kernel(version):
            notes = ["a failed boot would not come back on its own.",
                     "set a stock kernel as the default before rebooting:"]
            for v, p in self.kernels():
                if not self.is_badc_kernel(v):
                    notes.append(f"  grubby --set-default={p}")
                    break
            return Verdict.bad(f"DEFAULT IS A BADC KERNEL: {default}", *notes)
        return Verdict.ok(f"default boot entry: {default} (stock)")

    def invariant_holds(self):
        return not self.check_invariant().report().blocks

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
            if text is None:
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
        return 0 if self.invariant_holds() else 1

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
        elif kind == "absent":
            print("  - efi_pstore not present, skipped")
        else:
            print("  - cannot tell whether efi_pstore is present, skipped")

        print("watchdog: recovery for a hang that never panics")
        wd = glob.glob(self.path("/sys/class/watchdog/watchdog*"))
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
            if self.which("dracut"):
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
        return 0 if self.invariant_holds() else 1

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
        self.record_entry(v, path, add)
        print()
        return 0 if self.invariant_holds() else 1

    def entry_args(self, panic):
        """The arguments this entry carries, before the optional ones.

        `oops=panic` is the boot-parameter form; `panic_on_oops` is a sysctl
        name and the kernel rejects it on the command line, as it does
        `hardlockup_panic`. The lockup pair is not an option: a box with no
        console has nowhere to report a lockup that does not panic."""
        add = [f"panic={panic}", "oops=panic", "printk.always_kmsg_dump=1"]
        add.extend(LOCKUP_ARGS)
        if self.pstore_kind() == "builtin" and self.pstore_enabled() is not True:
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
        kind = self.config_kind("NETCONSOLE", version)
        if kind is None:
            kind = self.module_kind("netconsole")
        if kind == "builtin":
            add.append(f"netconsole={spec}")
            print("  netconsole: builtin, armed on the command line")
            return
        if kind == "absent":
            print("  ! netconsole is not available on this kernel; no remote log")
            return
        if kind is None:
            print("  ! cannot tell how netconsole is built on this kernel:")
            print("  ! no /boot/config and no modinfo; arming it would guess")
            return
        iface = netconsole_interface(spec)
        if not iface:
            print(f"  ! the netconsole spec names no interface: {spec}")
            print("  ! a module is loaded on the interface's own event and")
            print("  ! cannot be armed without one; no remote log")
            return
        modprobe = self.which("modprobe") or "/sbin/modprobe"
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
        """Confirm every precondition for a boot that can be recovered.

        Every verdict names what it observed and reads the thing that carries
        the fact: the boot loader entry for what a kernel will be given, the
        running kernel for what is in force now. A fact the tool cannot
        observe is reported as undetermined rather than as a failure."""
        verdicts = []

        def say(*vs):
            for v in vs:
                verdicts.append(v.report())

        print("invariant")
        say(self.check_invariant())

        print("stock kernels available to fall back to")
        stock = [v for v, _ in self.kernels() if not self.is_badc_kernel(v)]
        say(Verdict.ok(f"{len(stock)}: {', '.join(stock)}") if stock else
            Verdict.bad("no stock kernel installed: nothing to fall back to",
                        "do not reboot."))

        print("badc kernels installed")
        badc = [v for v, _ in self.kernels() if self.is_badc_kernel(v)]
        print(f"  {len(badc)}: {', '.join(badc) or 'none'}")

        print("recovery configuration")
        say(*self.pstore_reports())
        say(self.watchdog_report())
        say(*self.lockup_reports())
        say(*self.netconsole_reports())

        print("entry arguments")
        for version, args, live in self.prepared_entries():
            src = "boot loader" if live else "manifest record"
            print(f"  {version} ({src}): {' '.join(args)}")

        print("one-shot selection")
        print(f"  {self.grub_reboot() or 'NO grub-reboot; boot must be selected by hand'}")

        blocked = [v for v in verdicts if v.blocks]
        undecided = [v for v in verdicts
                     if v.state == Verdict.UNKNOWN and not v.gates]
        print()
        print("NOT READY" if blocked else "READY")
        for v in blocked:
            print(v.MARK[v.state] + v.finding)
        if undecided:
            print(f"  ? {len(undecided)} not determined, which is not a failure:")
            for v in undecided:
                print(f"  ?   {v.finding}")
        return 1 if blocked else 0

    def pstore_reports(self):
        """Whether the dying kernel log survives the reboot.

        A builtin reads pstore_disable from the command line, so for one it
        is the badc entry that decides and the entry that is read."""
        kind = self.pstore_kind()
        if kind is None:
            yield Verdict.unknown(
                "pstore: cannot tell whether efi_pstore is present:"
                " no modinfo and no /sys/module entry")
            return
        if kind == "absent":
            yield Verdict.ok("pstore: efi_pstore is not on this machine")
            return
        enabled = self.pstore_enabled()
        if enabled:
            yield Verdict.ok(f"pstore: enabled ({kind})")
            return
        if enabled is None:
            yield Verdict.unknown(
                f"pstore: {kind}, and its pstore_disable parameter is not"
                " readable; whether it records is undetermined")
            return
        if kind == "module":
            if os.path.exists(self.path("/etc/modprobe.d/badc-pstore.conf")):
                yield Verdict.ok("pstore: module, disabled now; modprobe.d"
                                 " enables it on the next boot")
            else:
                yield Verdict.bad("pstore: module, disabled, and no modprobe.d"
                                  " option is written; run `arm`")
            return
        prepared = list(self.prepared_entries())
        if not prepared:
            yield Verdict.ok("pstore: builtin, disabled on the running kernel;"
                             " no badc entry is prepared to carry it yet")
            return
        for version, args, live in prepared:
            carried = [x for x in args if x.startswith("efi_pstore.")]
            if not live:
                yield Verdict.unknown(
                    f"pstore: builtin and disabled now; {version}'s entry"
                    " cannot be read",
                    "the manifest record holds"
                    f" {' '.join(carried) or 'no efi_pstore parameter'}")
            elif carried:
                yield Verdict.ok(
                    f"pstore: builtin and disabled now; {version}'s entry"
                    " re-enables it",
                    f"{' '.join(carried)} on the boot loader entry")
            else:
                yield Verdict.bad(
                    f"pstore: builtin and disabled now, and {version}'s entry"
                    " does not re-enable it",
                    "a panic on it leaves no log; run `entry` again")

    def watchdog_report(self):
        wd = self.out(["systemctl", "show", "-p", "RuntimeWatchdogUSec"])
        if wd is None:
            return Verdict.unknown(
                "watchdog: systemctl could not be read; the runtime timeout"
                " is undetermined")
        value = wd.strip().split("=")[-1]
        if not value or value == "0":
            return Verdict.ok("watchdog: not armed (RuntimeWatchdogUSec=0)")
        return Verdict.ok(f"watchdog: {value} runtime timeout")

    def lockup_reports(self):
        """A detected lockup has to panic on the badc entry: a box with no
        console has nowhere else to report one."""
        for version, args, live in self.prepared_entries():
            missing = [x for x in LOCKUP_ARGS if x not in args]
            held = ("is missing " + " ".join(missing) if missing
                    else "carries the pair")
            if not live:
                yield Verdict.unknown(
                    f"lockup: {version}'s boot loader entry cannot be read",
                    f"the manifest record {held}")
            elif missing:
                yield Verdict.bad(
                    f"lockup: a detected lockup does NOT panic on {version}",
                    f"its boot loader entry {held}")
            else:
                yield Verdict.ok(
                    f"lockup: a detected lockup panics on {version}",
                    f"{' '.join(LOCKUP_ARGS)} on the boot loader entry")

    def netconsole_route(self):
        """How netconsole is armed, from what is on the machine."""
        for version, args, live in self.prepared_entries():
            for x in args:
                if x.startswith("netconsole="):
                    src = "" if live else ", per the manifest record"
                    return f"kernel command line on {version} (builtin){src}"
        rule = self.path(NETCONSOLE_RULE)
        if os.path.exists(rule):
            with open(rule) as f:
                iface = rule_interface(f.read()) or "an interface"
            return f"udev rule on {iface} (module)"
        return None

    def netconsole_targets(self):
        """(published, enabled) target names, or None where configfs cannot
        be listed.

        A target that came from the module parameter is not published here,
        so an empty list is not evidence that no target is configured. Only a
        published target that is not enabled is."""
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
        return names, live

    def netconsole_failed(self):
        """Whether this boot's log records a target that did not set up, or
        None where no log can be read."""
        text = (self.out(["journalctl", "-b", "-k", "--no-pager"])
                or self.out(["dmesg"]))
        if not text:
            return None
        return any("Netpoll setup failed" in line
                   or ("netpoll" in line and "aborting" in line)
                   for line in text.splitlines())

    def netconsole_reports(self):
        """The route the entry took, and whether the running kernel is sending.

        netconsole reports that logging started whether or not a target set
        up, so that line is not evidence. A published target that is enabled
        is; where the kernel publishes none, the boot log is."""
        yield Verdict.ok(
            f"netconsole route: {self.netconsole_route() or 'not armed'}")
        if os.path.exists(self.path(NETCONSOLE_MODULES_LOAD)):
            yield Verdict.bad(
                f"{NETCONSOLE_MODULES_LOAD} loads netconsole before the",
                "network driver probes; netpoll aborts and nothing is sent")
        if not os.path.exists(self.path("/sys/module/netconsole")):
            yield Verdict.ok("netconsole: not loaded on the running kernel")
            return
        targets = self.netconsole_targets()
        published, live = targets if targets else ([], [])
        if live:
            yield Verdict.ok(f"netconsole: loaded, target {', '.join(live)}")
            return
        if published:
            yield Verdict.bad(
                f"netconsole: loaded, and its target {', '.join(published)}"
                " is not enabled",
                "nothing is sent for this boot")
            return
        seen = ("configfs cannot be listed" if targets is None else
                "configfs lists no target; a module-parameter target is not"
                " published there")
        failed = self.netconsole_failed()
        if failed:
            yield Verdict.bad(
                "netconsole: loaded, and its target did not set up:"
                " nothing is sent",
                "this boot's log records a netpoll setup failure", seen)
        elif failed is None:
            yield Verdict.unknown(
                "netconsole: loaded, and no boot log can be read",
                "whether a target carries is undetermined", seen)
        else:
            yield Verdict.ok(
                "netconsole: loaded, and this boot's log records no netpoll"
                " failure", seen)

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
        if not self.invariant_holds():
            return 1
        cmd = self.grub_reboot()
        if not cmd:
            print("! no grub-reboot on this machine; select the entry by hand")
            return 1
        title = self.out(["grubby", f"--info=/boot/vmlinuz-{v}"])
        index = None
        for line in (title or "").splitlines():
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
        # One entry per kernel with every argument ever applied to it, so a
        # manifest written before entry records were merged still undoes both.
        entries = {r["version"]: r for r in self.entry_records()}
        for a in reversed(self.manifest):
            act = a.get("action")
            if act == "entry":
                rec = entries.pop(a["version"], None)
                if rec is None:
                    continue
                print(f"  entry {rec['version']}: removing its arguments")
                self.run(
                    [
                        "grubby",
                        f"--update-kernel={rec['path']}",
                        f"--remove-args={' '.join(rec['args'])}",
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
            if self.which("dracut"):
                self.run(["dracut", "-f"], check=False)
        print()
        print("state after rollback")
        self.invariant_holds()
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
        self.invariant_holds()
        return 0


def _self_test() -> int:
    """Drive the decisions that need no machine, over a tree that stands in
    for one. Nothing here reads the host: the object under a root answers
    every file and every command from the tree, so a verdict that changes
    with the box it is checked on is a defect this catches."""
    import contextlib
    import io
    import tempfile

    spec = "6666@192.0.2.10/enp5s0,6666@192.0.2.11/"
    assert netconsole_interface(spec) == "enp5s0"
    assert netconsole_interface("6666@192.0.2.10/,6666@192.0.2.11/") == ""
    assert netconsole_interface("6666@192.0.2.10") == ""
    assert rule_interface(netconsole_rule("eth7", "/sbin/modprobe")) == "eth7"
    assert entry_args_of('index=1\nargs="ro panic=30 oops=panic"\n') == \
        ["ro", "panic=30", "oops=panic"]
    assert entry_args_of("index=1\nkernel=/boot/vmlinuz-7.1.10\n") == []
    quiet = contextlib.redirect_stdout(io.StringIO())

    with tempfile.TemporaryDirectory() as tmp:
        def answer(cmd, text):
            d = os.path.join(tmp, ".out")
            os.makedirs(d, exist_ok=True)
            with open(os.path.join(d, out_fixture(cmd)), "w") as f:
                f.write(text)

        def forget(cmd):
            p = os.path.join(tmp, ".out", out_fixture(cmd))
            if os.path.exists(p):
                os.unlink(p)

        def checked():
            out = io.StringIO()
            with contextlib.redirect_stdout(out):
                rc = prep.cmd_check(argparse.Namespace())
            return rc, out.getvalue()

        entry = ["grubby", "--info=/boot/vmlinuz-7.1.10"]
        stock = "7.1.12-200.fc44.x86_64"
        os.makedirs(tmp + "/boot")
        for v in ("7.1.10", "7.1.11", stock):
            open(f"{tmp}/boot/vmlinuz-{v}", "w").close()
        with open(tmp + "/boot/config-7.1.10", "w") as f:
            f.write("CONFIG_NETCONSOLE=m\nCONFIG_NETCONSOLE_DYNAMIC=y\n")
        with open(tmp + "/boot/config-7.1.11", "w") as f:
            f.write("CONFIG_NETCONSOLE=y\n")
        with open(tmp + "/boot/config-7.1.13", "w") as f:
            f.write("# CONFIG_NETCONSOLE is not set\n")
        prep = Prep(tmp + "/state", dry_run=False, root=tmp)
        prep.record_action(action="install", version="7.1.10",
                           package="kernel-7.1.10-2.x86_64.rpm")

        # The host is not evidence about the tree: a command with no answer
        # in it is unobserved, and no host program is found through it.
        assert prep.out(["modinfo", "efi_pstore"]) is None
        assert prep.which("grubby") is None
        assert prep.run(["rpm", "-e", "kernel"], quiet=True).returncode == 0

        assert prep.config_kind("NETCONSOLE", "7.1.10") == "module"
        assert prep.config_kind("NETCONSOLE", "7.1.11") == "builtin"
        assert prep.config_kind("NETCONSOLE", "7.1.13") == "absent"
        assert prep.config_kind("NETCONSOLE", "7.1.99") is None

        # The pstore parameter is on the entry because the tree says the
        # kernel has efi_pstore builtin and disabled, not because the box
        # running the test does.
        assert prep.pstore_kind() is None
        assert prep.entry_args(30) == [
            "panic=30", "oops=panic", "printk.always_kmsg_dump=1",
            "nmi_watchdog=panic", "softlockup_panic=1"]
        params = tmp + "/sys/module/efi_pstore/parameters"
        os.makedirs(params)
        with open(params + "/pstore_disable", "w") as f:
            f.write("Y\n")
        assert prep.pstore_kind() == "builtin"
        assert prep.pstore_enabled() is False
        add = prep.entry_args(30)
        assert add[-1] == "efi_pstore.pstore_disable=0", add

        # A modular netconsole loads on the interface's own event, and the
        # modules-load.d entry of the route it replaces goes with it.
        stale = tmp + NETCONSOLE_MODULES_LOAD
        os.makedirs(os.path.dirname(stale))
        with open(stale, "w") as f:
            f.write("netconsole\n")
        with quiet:
            prep.arm_netconsole(spec, add, "7.1.10")
        assert not os.path.exists(stale), stale
        with open(tmp + NETCONSOLE_OPTIONS) as f:
            assert f.read() == f"options netconsole netconsole={spec}\n"
        with open(tmp + NETCONSOLE_RULE) as f:
            rule = f.read()
        assert 'ACTION=="add|move", SUBSYSTEM=="net"' in rule, rule
        assert 'ENV{INTERFACE}=="enp5s0"' in rule, rule
        assert 'RUN+="/sbin/modprobe netconsole"' in rule, rule
        assert not [x for x in add if x.startswith("netconsole=")], add
        assert prep.netconsole_route() == "udev rule on enp5s0 (module)"

        # A builtin netconsole keeps the command line and writes no file; a
        # kernel whose own config has it off is not armed either way.
        before = sorted(os.listdir(tmp + "/etc"))
        builtin = prep.entry_args(30)
        with quiet:
            prep.arm_netconsole(spec, builtin, "7.1.11")
        assert f"netconsole={spec}" in builtin, builtin
        off = prep.entry_args(30)
        with quiet:
            prep.arm_netconsole(spec, off, "7.1.13")
        assert not [x for x in off if x.startswith("netconsole=")], off
        assert sorted(os.listdir(tmp + "/etc")) == before

        # The invariant fails closed: an unreadable default blocks, and says
        # it could not be read rather than that it was violated.
        rc, text = checked()
        assert rc == 1, text
        assert "cannot read the default boot entry" in text, text
        answer(["grubby", "--default-kernel"], f"/boot/vmlinuz-{stock}\n")
        answer(["systemctl", "show", "-p", "RuntimeWatchdogUSec"],
               "RuntimeWatchdogUSec=1min\n")
        answer(entry, 'index=1\nargs="ro ' + " ".join(add) + '"\n')
        prep.record_entry("7.1.10", "/boot/vmlinuz-7.1.10", add)
        rc, text = checked()
        assert rc == 0, text
        assert f"default boot entry: /boot/vmlinuz-{stock} (stock)" in text, text
        assert "watchdog: 1min runtime timeout" in text, text
        assert "lockup: a detected lockup panics on 7.1.10" in text, text
        assert "7.1.10 (boot loader):" in text, text

        # The boot loader entry decides, not the record: a record left by an
        # earlier run without the lockup pair does not outvote the entry.
        prep.manifest.insert(0, dict(action="entry", version="7.1.10",
                                     path="/boot/vmlinuz-7.1.10",
                                     args=["panic=30"], when="2026-01-01T00:00:00"))
        rc, text = checked()
        assert rc == 0, text
        assert "lockup: a detected lockup panics on 7.1.10" in text, text

        # An entry that really lacks the pair is a failure, and names what
        # is missing.
        answer(entry, 'index=1\nargs="ro panic=30 oops=panic"\n')
        rc, text = checked()
        assert rc == 1, text
        assert "does NOT panic on 7.1.10" in text, text
        assert "is missing nmi_watchdog=panic softlockup_panic=1" in text, text
        assert "does not re-enable it" in text, text

        # An entry that cannot be read is undetermined, not a failure.
        forget(entry)
        rc, text = checked()
        assert rc == 0, text
        assert "boot loader entry cannot be read" in text, text
        assert "not determined, which is not a failure" in text, text
        assert "7.1.10 (manifest record):" in text, text
        answer(entry, 'index=1\nargs="ro ' + " ".join(add) + '"\n')

        # netconsole. An empty configfs directory is not evidence that no
        # target is configured: a target from the module parameter is not
        # published there. The boot log is what distinguishes the two.
        os.makedirs(tmp + "/sys/module/netconsole")
        os.makedirs(tmp + "/sys/kernel/config/netconsole")
        answer(["journalctl", "-b", "-k", "--no-pager"],
               "[    6.319026] alx 0000:05:00.0 enp5s0: renamed from eth0\n")
        rc, text = checked()
        assert rc == 0, text
        assert "configfs lists no target" in text, text
        assert "records no netpoll failure" in text, text

        answer(["journalctl", "-b", "-k", "--no-pager"],
               "netconsole: Not enabling netconsole for cmdline0."
               " Netpoll setup failed\n")
        rc, text = checked()
        assert rc == 1, text
        assert "its target did not set up" in text, text

        # No log at all is undetermined, and does not block.
        forget(["journalctl", "-b", "-k", "--no-pager"])
        rc, text = checked()
        assert rc == 0, text
        assert "no boot log can be read" in text, text

        # A published target that is not enabled is the state that does send
        # nothing, and stays a failure.
        target = tmp + "/sys/kernel/config/netconsole/cmdline0"
        os.makedirs(target)
        with open(target + "/enabled", "w") as f:
            f.write("0\n")
        rc, text = checked()
        assert rc == 1, text
        assert "its target cmdline0 is not enabled" in text, text
        with open(target + "/enabled", "w") as f:
            f.write("1\n")
        rc, text = checked()
        assert rc == 0, text
        assert "netconsole: loaded, target cmdline0" in text, text

        # systemctl that cannot be read leaves the watchdog undetermined
        # rather than reported as not armed.
        forget(["systemctl", "show", "-p", "RuntimeWatchdogUSec"])
        rc, text = checked()
        assert rc == 0, text
        assert "systemctl could not be read" in text, text

        # One entry record per kernel, holding every argument ever applied,
        # so rollback still removes an argument a later run stopped adding.
        prep.record_entry("7.1.10", "/boot/vmlinuz-7.1.10", ["panic=15"])
        records = [a for a in prep.manifest if a.get("action") == "entry"]
        assert len(records) == 1, records
        assert records[0]["args"][0] == "panic=15", records
        assert set(add) <= set(records[0]["args"]), records

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
