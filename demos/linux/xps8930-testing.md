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
| Serial | **none.** `/dev/ttyS0..17` exist as driver nodes; `/proc/tty/driver/serial` reports no port behind any of them |
| Display | **none attached.** All three DRM connectors report `disconnected` |

The root filesystem is ext4, so there is no filesystem snapshot to roll back
to. Rollback here means *boot a different kernel*, and nothing else.

## The constraint, stated plainly

With no serial port and no monitor, a kernel that fails before the network
comes up produces **no output anywhere**. There is no console to watch, no
scrollback to read, and no shell to log into. The machine is either reachable
over ssh or it is a black box.

Three consequences drive the whole design:

1. **The badc kernel must never become the default.** If a boot wedges, the
   recovery has to happen without anyone reading anything, which means the
   *next* boot must already be a stock kernel.
2. **A panic must reboot, not hang.** `kernel.panic` is `0` on this box today,
   so a panic sits there forever. On a headless machine that converts a
   software fault into a physical trip.
3. **Post-mortem has to survive the reboot**, because nothing can be observed
   during the failure. That is what pstore is for, and it is currently off.

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
default again — no intervention, no console needed. **Never** run
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

A silent hang — no panic, no oops — is the one case layers 1 and 2 do not
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

`netconsole.ko` ships with the distribution kernel and the badc one. Configured
on the kernel command line it starts as soon as the network driver probes,
which is far earlier than any userspace logging:

```
netconsole=6666@<box-ip>/<iface>,6666@<collector-ip>/<collector-mac>
```

Both IP addresses and the collector's MAC are site-specific and deliberately
not recorded here. Collect on the other machine with:

```sh
nc -u -l -k 6666 | tee "netconsole-$(date +%Y%m%dT%H%M%S).log"
```

This is the primary window. It covers driver probe, filesystem mount,
`switch_root`, systemd, and everything after.

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

The ESP has 2 GB free and EFI variable space is small; clearing records between
runs keeps the variable store from filling.

### Removing `rhgb quiet`

The stock command line carries `rhgb quiet`, which suppresses exactly the
messages worth having. Drop both from the badc entry. Leave
`/etc/default/grub` alone so the stock entries keep their normal behaviour.

## Preparation, in order

Each step is reversible and the undo is recorded at the end of this document.

```sh
# 1. Record the state to return to.
sudo grubby --info=ALL > ~/rollback/grubby-before.txt
sudo cp /etc/default/grub ~/rollback/
sudo grub2-editenv list > ~/rollback/grubenv-before.txt
rpm -q kernel > ~/rollback/kernels-before.txt
sysctl kernel.panic kernel.panic_on_oops > ~/rollback/sysctl-before.txt

# 2. Turn on the post-mortem path.
echo 'options efi_pstore pstore_disable=0' | sudo tee /etc/modprobe.d/pstore.conf
sudo dracut -f                       # rebuild so the setting applies early

# 3. Arm the watchdog for the post-systemd window.
sudo install -d /etc/systemd/system.conf.d
printf '[Manager]\nRuntimeWatchdogSec=60\nRebootWatchdogSec=120\n' \
  | sudo tee /etc/systemd/system.conf.d/watchdog.conf
sudo systemctl daemon-reexec

# 4. Install the badc package. It adds a version, it does not replace one.
sudo rpm -ivh --oldpackage <kernel-7.1.10-*.x86_64.rpm>
rpm -q kernel                        # confirm the stock kernels are still there

# 5. Give the badc entry its own arguments, and nothing else its own arguments.
sudo grubby --update-kernel="/boot/vmlinuz-7.1.10" \
  --args="panic=30 panic_on_oops=1 oops=panic printk.always_kmsg_dump=1 netconsole=..." \
  --remove-args="rhgb quiet"

# 6. Confirm the default is still a stock kernel.
sudo grubby --default-title
```

Step 6 is the one that must not be skipped. If it names the badc kernel, stop
and fix it before rebooting.

## Boot procedure

1. Start the netconsole collector on the other machine **first**. There is no
   scrollback; anything not captured live is gone unless it panics.
2. Clear pstore: `sudo rm -f /sys/fs/pstore/*`.
3. Select the badc entry for one boot with `grub2-reboot`, then reboot.
4. Watch the collector. Expect the banner to name badc as both compiler and
   linker:
   `Linux version 7.1.10 ... (badc 0.4.0 (gcc-compatible, GNU C 4.3.0), GNU ld (badc 0.4.0) ...)`
5. If ssh comes back, run the same checks the qemu lane runs — `uname -r`,
   `/proc/sys/kernel/tainted`, `systemctl is-system-running`, `lsmod | wc -l`,
   the root disk driver chain, and `demos/linux/exercise.py` — so the hardware
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
| hang before systemd starts | up to the hang | no | **no — power button** |
| hang before the NIC probes | **nothing at all** | no | **no — power button** |

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
  power does force a reset — unlike the MicroPC, where the battery defeats
  that. That would close the last row of the table above and is the single
  highest-value addition to this lane.
- **A monitor would close most of the gap** more cheaply than a serial port:
  with a display attached, `earlycon=efifb` gives output from very early on.
  Worth attaching for a first bring-up even if it is removed afterwards.
- **kdump is disabled.** It would capture a full crash dump rather than the
  tail of dmesg, at the cost of reserved memory. Worth enabling if pstore's
  record turns out to be too short to diagnose something.

## Undoing all of it

```sh
# 1. The badc kernel and its boot entry
sudo rpm -e kernel-7.1.10                     # removes its BLS entry too
sudo grub2-editenv - unset next_entry         # clear any pending one-shot

# 2. Post-mortem capture
sudo rm -f /etc/modprobe.d/pstore.conf
sudo rm -f /sys/fs/pstore/*
sudo dracut -f

# 3. The watchdog
sudo rm -f /etc/systemd/system.conf.d/watchdog.conf
sudo systemctl daemon-reexec

# 4. Verify the machine is back where it started
sudo grubby --default-title                   # a stock kernel
rpm -q kernel                                 # the three stock kernels
diff <(sudo grubby --info=ALL) ~/rollback/grubby-before.txt
```

Nothing in this lane modifies `/etc/default/grub`, the stock kernels, their
command lines, or the root filesystem, so there is no state to restore beyond
the four items above.
