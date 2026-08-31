# Booting badc kernels on real hardware: the x86_64 build box

This box already builds and qemu-boots the kernel packages. Running one on the
metal is a different proposition from the MicroPC lane, because this machine
has no console at all: no serial port and no display. Everything below follows
from that.

Read [micropc-testing.md](micropc-testing.md) first if you have not. Where the
two lanes agree, this document says so and does not repeat the reasoning.

## What the machine is

| | |
|---|---|
| Role | x86_64 build box; also the x86_64 hardware-boot target |
| OS | Fedora Linux 44 (Workstation Edition), `multi-user.target` |
| Running kernel | the distribution's own, currently `7.1.9-200.fc44.x86_64` |
| Stock kernels installed | three (`7.1.7`, `7.1.8`, `7.1.9`) |
| Firmware | UEFI, Secure Boot **disabled**, so an unsigned kernel boots |
| Bootloader | GRUB 2 with `GRUB_DEFAULT=saved`, `GRUB_TIMEOUT=5` |
| Root | ext4 on `/dev/sda2`, 817 GB free; ESP is a separate 2 GB `/dev/sda1` |
| Network | one wired interface, static lease on the lab network |
| Watchdogs | `intel_oc_wdt` and `iTCO_wdt`, both loaded |
| Serial | a 16550A exists (`ttyS0`, `type=4`, `0x3f8`, IRQ 4) but reaches no accessible connector: the board ships no DB-9, and any PCB header is not reachable. Unusable as a console |
| Display | **none attached.** All three DRM connectors report `disconnected` |

The root filesystem is ext4, so there is no filesystem snapshot to roll back
to. Rollback here means *boot a different kernel*, and nothing else.

## The constraint, stated plainly

There is a UART on this board -- sysfs reports `ttyS0` as `type=4`
(`PORT_16550A`) at `0x3f8` IRQ 4, which is a port the driver probed, not a
phantom node -- but it reaches no connector anyone can attach a cable to. The
chassis has no DB-9, and whatever header may exist on the PCB is not
accessible. So there is no serial console, and with no monitor attached there
is no console at all.

A kernel that fails before the network comes up therefore produces **no output
anywhere**: nothing to watch, no scrollback to read, no shell to log into. The
machine is either reachable over ssh or it is a black box. Everything below
follows from that: the visibility has to be arranged in advance, and the
recovery has to be automatic, because there will be nobody at a console to
intervene.

(An earlier revision of this document asserted the machine had no serial port
at all. That came from reading `/proc/tty/driver/serial`, which is root-only
and had returned empty because the command failed, not because the file was
empty. The conclusion held; the evidence for it did not.)

## Rollback: the part that matters

Four independent layers, in the order they take effect. Any one of them alone
recovers the machine; they are stacked because the cheap ones fail silently.

### 1. One-shot boot selection, never a changed default

`GRUB_DEFAULT=saved` is already set, so `grub2-reboot` selects an entry **for
the next boot only**. The saved default is untouched.

```sh
# select the badc entry for exactly one boot
sudo grub2-reboot "$(sudo grubby --info=ALL | awk -F= '/^title=/ {print $2}' | grep badc | head -1)"
sudo systemctl reboot
```

If that kernel does not reach userspace, the following boot is the stock
default again -- no intervention, no console needed. **Never** run
`grub2-set-default` or `grubby --set-default` against a badc entry.

### 2. A bounded panic

Put these on the badc entry's command line only, not in `/etc/default/grub`:

```
panic=30 panic_on_oops=1 oops=panic
```

A panic or oops then reboots after 30 s, and combined with layer 1 that reboot
lands on a stock kernel. Thirty seconds is long enough for netconsole to flush
and for pstore to write, and short enough not to matter.

`nmi_watchdog=1` is on by default and turns a hard lockup into a panic, which
layer 2 then converts into a reboot. Leave it alone.

### 3. The hardware watchdog, for hangs that never panic

A silent hang -- no panic, no oops -- is the one case layers 1 and 2 do not
cover, because nothing ever decides to reboot. `iTCO_wdt` can, but only once
something opens `/dev/watchdog`, so it protects the window from systemd
onwards and not before:

```sh
# /etc/systemd/system.conf.d/watchdog.conf
[Manager]
RuntimeWatchdogSec=60
RebootWatchdogSec=120
```

A hang before systemd starts is **not** covered by anything here and needs the
power button. That gap is real; see "What is still uncovered".

### 4. The stock kernels stay

Never `dnf remove kernel`, and keep `installonly_limit` at three or more. The
badc package installs under its own version string (`7.1.10`), so it is an
addition and not a replacement. Verify before rebooting:

```sh
rpm -q kernel | wc -l          # expect >= 3
sudo grubby --info=ALL | grep -c '^title='
```

## Visibility without a console

### netconsole, for anything after the NIC is up

`netconsole.ko` ships with the distribution kernel and the badc one, and both
build it as a **module** (`CONFIG_NETCONSOLE=m`). That decides where the target
goes, and getting it wrong is silent: `netconsole=` on the kernel command line
is a parameter only a builtin registers, so on these kernels it is rejected --
the boot prints one `Unknown kernel command line parameters` line and carries
on with no remote log at all. `hwprep.py entry` reads which it is and writes

```
/etc/modprobe.d/badc-netconsole.conf   options netconsole netconsole=<spec>
/etc/modules-load.d/badc-netconsole.conf   netconsole
```

for a module, or puts it on the command line for a builtin. The spec is

```
netconsole=6666@<box-ip>/<iface>,6666@<collector-ip>/<collector-mac>
```

As a module it loads from userspace, so it covers everything from that point
on but not the window before it -- driver probe, mount, `switch_root`. pstore
is the only record for that window, which is why both are armed.

Both IP addresses and the collector's MAC are site-specific and deliberately
not recorded here. Collect on the other machine with:

```sh
nc -u -l -k 6666 | tee "netconsole-$(date +%Y%m%dT%H%M%S).log"
```

This is the primary window. It covers driver probe, filesystem mount,
`switch_root`, systemd, and everything after.

Prove the path carries before a boot depends on it, because a netconsole that
does not arrive is indistinguishable from a kernel that produced no output.
Start the collector, then send from the box over the same route the kernel
will use:

```sh
# on the collector
nc -u -l 6666

# on the box, from bash -- the login shell may be zsh, which has no /dev/udp
bash -c 'echo probe > /dev/udp/<collector-ip>/6666'
```

The probe arriving confirms the addressing, the route and that nothing between
the two machines drops the port. It does not confirm the MAC in the
`netconsole=` line, which the kernel uses directly rather than resolving by
ARP: get that wrong and the frames are emitted and silently not delivered. Read
it from the collector's own interface, and re-read it if the collector's
hardware or network changes.

### efi_pstore, for what happens when nothing is watching

The module is present but **disabled** (`pstore_disable=Y`), so today a panic
leaves nothing behind. Enable it:

```sh
# /etc/modprobe.d/pstore.conf
options efi_pstore pstore_disable=0
```

and add `printk.always_kmsg_dump=1` to the badc entry so the dump also runs on
a clean-ish shutdown path. After the machine comes back on a stock kernel:

```sh
ls /sys/fs/pstore/                 # dmesg-efi-* records, newest first
sudo cat /sys/fs/pstore/dmesg-efi-*
sudo rm /sys/fs/pstore/dmesg-efi-* # clear before the next attempt
```

`efi_pstore` is **builtin** on the Fedora kernels this box runs (`modinfo
efi_pstore` reports `filename: (builtin)`), and it ships with
`pstore_disable=Y`. A builtin takes its parameters from the kernel command
line, not from `modprobe.d`: a `modprobe.d` drop-in for it is read by nothing
and changes nothing. The parameter therefore goes on the badc entry's command
line, as `efi_pstore.pstore_disable=0`, where it applies to the kernel whose
death is being recorded and to no other.

The ESP has 2 GB free and EFI variable space is small; clearing records between
runs keeps the variable store from filling.

### Removing `rhgb quiet`

The stock command line carries `rhgb quiet`, which suppresses exactly the
messages worth having. Drop both from the badc entry. Leave
`/etc/default/grub` alone so the stock entries keep their normal behaviour.

## Preparation, in order

Each step is reversible and the undo is recorded at the end of this document.

Every step below needs root; the operator account has a passwordless `sudo`
rule, so they can be driven over ssh. `hwprep.py` applies them, records what it
changed, and replays the record backwards on `rollback`.

`hwprep.py` performs these, records every change it makes, and replays the
record backwards on `rollback`. Run it on the box:

```sh
scp demos/linux/hwprep.py <box>:                     # from the repo

# 1. Record the state to return to. Refuses nothing, changes nothing.
sudo python3 hwprep.py record

# 2-3. Post-mortem capture and the watchdog.
sudo python3 hwprep.py arm

# 4. Install the badc package. It adds a version, it replaces none.
sudo python3 hwprep.py install kernel-7.1.10-*.x86_64.rpm

# 5. Give that entry its own arguments, and no other entry any.
sudo python3 hwprep.py entry --kernel 7.1.10 \
  --netconsole '6666@<box-ip>/<iface>,6666@<collector-ip>/<collector-mac>'

# 6. Confirm the machine can still recover. This is the step not to skip.
sudo python3 hwprep.py check
```

`check` is the gate. It reports `READY` only when the default boot entry is a
stock kernel, at least one stock kernel remains installed to fall back to, and
the recovery configuration is in effect -- reading the watchdog's live timeout
from systemd and pstore's state from the running kernel, rather than the
presence of the files that were meant to set them. The `arm` step relies on
that distinction: on this machine it removes its own `modprobe.d` drop-in once
it sees `efi_pstore` is builtin, because that file could not have worked.

Every step is idempotent, so a re-run after an interruption is safe, and each
prints what it changed. `--dry-run` prints without changing anything.

Then, and only after `check` reports `READY`:

```sh
sudo python3 hwprep.py boot --kernel 7.1.10   # one boot, then back to stock
sudo systemctl reboot
```

`boot` selects the entry through `grub2-reboot`, which GRUB consumes on the
next start. It does not change `GRUB_DEFAULT`, so a kernel that panics, hangs
or never reaches userspace is followed by a stock boot without anyone touching
the machine.

## Boot procedure

1. Start the netconsole collector on the other machine **first**. There is no
   scrollback; anything not captured live is gone unless it panics.
2. Clear pstore: `sudo rm -f /sys/fs/pstore/*`.
3. Select the badc entry for one boot with `grub2-reboot`, then reboot.
4. Watch the collector. Expect the banner to name badc as both compiler and
   linker:
   `Linux version 7.1.10 ... (badc 0.4.1 (gcc-compatible, GNU C 4.3.0), GNU ld (badc 0.4.1) ...)`
5. If ssh comes back, run the same checks the qemu lane runs -- `uname -r`,
   `/proc/sys/kernel/tainted`, `systemctl is-system-running`, `lsmod | wc -l`,
   the root disk driver chain, and `demos/linux/exercise.py` -- so the hardware
   result is comparable to the qemu result rather than a separate vocabulary.
6. If ssh does not come back within a few minutes, wait for the panic reboot
   (30 s) or the watchdog (60 s). When it returns on the stock kernel, read
   `/sys/fs/pstore/`.

## What a failed boot leaves behind

| failure | netconsole | pstore | recovers by itself |
|---|---|---|---|
| panic or oops after the NIC probes | yes | yes | yes, `panic=30` then stock |
| panic before the NIC probes | no | yes | yes, `panic=30` then stock |
| hang after systemd starts | up to the hang | no | yes, watchdog |
| hang before systemd starts | up to the hang | no | **no -- power button** |
| hang before the NIC probes | **nothing at all** | no | **no -- power button** |

The last row is the honest limit of this lane. There is no way to observe or
recover from it remotely on this hardware.

## What is still uncovered

- **The early-boot window is dark.** Between firmware handoff and the network
  driver probing, nothing is observable. On the MicroPC this is what
  `earlycon=uart8250` covers; there is no equivalent here. Mitigations: only
  boot kernels that already boot in qemu on this same box, and keep the
  one-shot selection so a dark failure still self-recovers on the next power
  cycle.
- **A hang before systemd needs physical access.** If the box gains a
  switchable outlet, note that it is a desktop with no battery, so cutting
  power does force a reset -- unlike the MicroPC, where the battery defeats
  that. That would close the last row of the table above and is the single
  highest-value addition to this lane.
- **A monitor would close most of the gap** more cheaply than a serial port:
  with a display attached, `earlycon=efifb` gives output from very early on.
  Worth attaching for a first bring-up even if it is removed afterwards.
- **kdump is disabled.** It would capture a full crash dump rather than the
  tail of dmesg, at the cost of reserved memory. Worth enabling if pstore's
  record turns out to be too short to diagnose something.

## What the preparation changes

Seven items, and nothing else. `hwprep.py status` prints the recorded ones at
any time; the table gives the manual undo for each, should the record be lost.

| # | Change | Where it lives | Outlives a reboot | Undo |
|---|--------|----------------|-------------------|------|
| 1 | The rollback snapshot | `/var/lib/badc-hwprep/` | yes | `sudo rm -rf /var/lib/badc-hwprep` -- it only records |
| 2 | Watchdog drop-in | `/etc/systemd/system.conf.d/badc-watchdog.conf` | yes | `sudo rm` it, then `sudo systemctl daemon-reexec` |
| 3 | Kernel package | rpm database, `/boot`, `/lib/modules` | yes | `sudo rpm -e kernel-<version>` -- takes its BLS entry with it |
| 3a | **The default entry, moved by the package** | grubenv | yes | `sudo grubby --set-default=/boot/vmlinuz-<stock>` -- `install` does this itself |
| 4 | Arguments on the badc entry | that entry's BLS file only | yes | `sudo grubby --update-kernel=/boot/vmlinuz-<version> --remove-args="..."` |
| 5 | One-shot boot selection | `next_entry` in the grubenv | no, one boot | `sudo grub2-editenv - unset next_entry` |
| 6 | pstore records left by a crash | EFI variable store, via `/sys/fs/pstore` | yes | `sudo rm -f /sys/fs/pstore/*` |
| 7 | Initramfs rebuild | `/boot/initramfs-<running>.img` | yes | `sudo dracut -f` regenerates it |

Item 2 is the only one that changes how the machine behaves outside the badc
entry: after `arm`, systemd pets a hardware watchdog with a one-minute timeout
on **every** boot, stock kernels included. A stock system that wedges hard
enough to stop systemd from petting it will therefore reset itself rather than
sit there. That is the intended behaviour -- it is what makes an unattended
badc boot recoverable -- but it applies machine-wide, and it is live from the
moment `arm` runs, not from the first badc boot.

Item 3a is not something the preparation asks for. Fedora's kernel package
makes the kernel it just installed the default, so `rpm -i` alone leaves the
machine one reboot away from starting a kernel that may not come back --
without anyone having chosen that. `install` captures the default beforehand,
notices when the package has moved it to a kernel this tool installed, and puts
it back, reporting both. The invariant check that follows would catch it
regardless, but detecting a hazard whose window is a reboot wide is not as good
as not opening it.

Items 3 through 6 otherwise touch the badc entry alone. Nothing in this lane modifies
`/etc/default/grub`, the stock kernels, their command lines, the default boot
entry, or the root filesystem.

## Undoing all of it

```sh
sudo python3 hwprep.py rollback      # --keep-kernels leaves the packages
sudo python3 hwprep.py status        # what remains, and what is default
```

`rollback` replays the recorded changes newest-first: it strips the arguments
it added from the entries it added them to, removes the kernel packages it
installed, and restores or deletes each file it wrote according to whether
that file existed beforehand. It then re-checks the invariant and compares the
installed kernel set against the one `record` captured, reporting any
difference in either direction rather than reporting success on the strength
of having run.

It does not clear items 5 and 6 -- a pending one-shot selection is consumed by
the next boot whether or not anyone clears it, and the pstore records are the
evidence a failed boot was run to collect. Clear those by hand when done:

```sh
sudo grub2-editenv - unset next_entry
sudo rm -f /sys/fs/pstore/*
```

To confirm the machine is where it started:

```sh
sudo python3 hwprep.py status                       # 0 recorded changes
diff <(sudo grubby --info=ALL) /var/lib/badc-hwprep/before/grubby-info-all.txt
rpm -q kernel                                       # the stock set, unchanged
```
