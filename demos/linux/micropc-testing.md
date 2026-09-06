# Booting badc kernels on real hardware: the GPD MicroPC

The VM lanes prove a kernel boots under an emulator whose devices badc's
output has never surprised. This box is the other half: a physical
machine, reached over a real RS-232 line, that runs the same packages.

## What the machine is

| | |
|---|---|
| Model | GPD MicroPC, BIOS 4.15 |
| CPU | Celeron N4100 (Gemini Lake, Goldmont Plus), 4 cores |
| Firmware | UEFI, Secure Boot **disabled** |
| Storage | SATA SSD (`BIWIN SSD`, 119 GB) -- no NVMe |
| Serial | 16550A at I/O `0x2f8`, IRQ 3, exposed as the DE-9 port |
| Distribution | Fedora 44, kernel 7.1.10-200.fc44 |

The box is reached over ssh with key authentication and password-less
sudo. Its address is site-specific and deliberately not recorded here.

Three of those decide what this box can and cannot test.

**No AVX.** Goldmont Plus carries SSE4.2 and AES-NI and stops there. The
kernel's AVX2/AVX-512 RAID6 and crypto paths compile but never execute
here, so the inline-asm work they cover still needs the x86_64 Linux
box. It also means the EVEX encoding gap is not reachable at runtime on
this machine.

**SATA, not NVMe.** A boot here exercises `ahci`/`libata`, not the `nvme`
path the emulated lanes drive. The two are complementary rather than
redundant: the module-autoload defect that hid behind NVMe was a
packaging property, and this box reaches it through a different bus.

**A battery.** Cutting mains power does not reset a laptop, so a
networked plug buys nothing. The chipset watchdog is the only unattended
recovery the machine has.

## The serial port is `ttyS1`, not `ttyS0`

Worth stating plainly, because the obvious guess is wrong and produces a
console that is silent rather than broken. The board enumerates 32
`ttyS*` nodes; only two are real:

```
00:01: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
dw-apb-uart.8: ttyS4 at MMIO 0xa1324000 (irq = 4) is a 16550A
```

`ttyS0` at `0x3f8` reports `type=0` -- no hardware behind it. The
`dw-apb-uart` nodes are the SoC's own LPSS UARTs, wired to internal
peripherals. The physical DE-9 is the legacy-style 16550A at `0x2f8`,
i.e. COM2, which is why GRUB needs `--unit=1` and the kernel needs
`console=ttyS1`.

Confirm on any similar board before trusting a console setting:

```bash
sudo dmesg | grep -iE 'ttyS|8250|dw-apb'
for n in 0 1 2 3; do printf 'ttyS%s type=%s port=%s\n' "$n" \
  "$(cat /sys/class/tty/ttyS$n/type)" "$(cat /sys/class/tty/ttyS$n/port)"; done
```

A `type` of 4 is a detected 16550A; `0` means the node exists but nothing
answers.

## Configuration applied

### Boot: console, early console, and a bounded panic

`/etc/default/grub`:

```
GRUB_TERMINAL="serial console"
GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=1 --word=8 --parity=no --stop=1"
GRUB_CMDLINE_LINUX="console=tty0 console=ttyS1,115200n8 earlycon=uart8250,io,0x2f8,115200n8 panic=30"
```

then, because Fedora keeps each entry's command line in its own BLS
snippet rather than deriving it from `grub.cfg`:

```bash
grubby --update-kernel=ALL --args="console=tty0 console=ttyS1,115200n8 earlycon=uart8250,io,0x2f8,115200n8 panic=30"
grubby --update-kernel=ALL --remove-args="rhgb quiet"
grub2-mkconfig -o /boot/grub2/grub.cfg
```

`/etc/kernel/cmdline` is written from the resulting default entry so a
kernel installed later inherits the same arguments -- and it **must
carry `root=`**, which is easy to lose:

```bash
sudo grubby --info=DEFAULT          # root= is printed on its own line,
                                    # NOT inside args="..."
```

Deriving the file from `args=` alone produces a command line with no root
device. Nothing complains at install time; the entry simply cannot mount
a root filesystem, and the machine lands in emergency mode on the next
boot into it. That is not hypothetical -- it is how this box was first
stranded, and the resulting entry had to be repaired with
`grubby --update-kernel=... --args="root=UUID=..."`.

Installing a kernel here also **silently takes the standing default**:
`rpm -i` runs `kernel-install`, which writes the new entry and points
`saved_entry` at it. Re-assert the fallback after any install:

```bash
sudo grubby --set-default /boot/vmlinuz-<the distro kernel>
```

**That file must carry `root=`.** `grubby --info` prints the root device
in its own `root=` field and leaves it out of `args=`, so an
`/etc/kernel/cmdline` built from `args` alone is missing it. The entry
`kernel-install` then writes for a newly installed kernel has no root
device; the kernel reaches the initramfs, `systemd-gpt-auto-generator`
looks for a root partition, `dev-gpt-auto-root.device` times out after
45 s, `sysroot.mount` fails and the boot parks in an emergency shell. It
is silent until it happens -- the installed kernel looks fine, and the
running one is unaffected. Check it before installing any kernel:

```bash
grep -o 'root=[^ ]*' /etc/kernel/cmdline || echo 'MISSING: kernel-install \
  will write an entry with no root device'
```

Each piece earns its place:

- **`GRUB_TERMINAL="serial console"`** puts the boot menu on the wire, so
  a kernel can be chosen -- or a failing one abandoned -- without the
  6-inch screen.
- **`console=ttyS1` last.** Every `console=` receives kernel messages,
  but the final one becomes `/dev/console` for init, which is what makes
  the serial line interactive rather than a log tap.
- **`earlycon`** attaches before the console driver initialises. This is
  the argument that matters most here: several defects this milestone
  chased presented as a kernel that printed *nothing at all*, and
  `earlycon` is what turns that into a diagnosis. It is confirmed
  working -- `earlycon: uart8250 at I/O port 0x2f8` appears at timestamp
  `0.000000`.
- **`panic=30`** reboots instead of parking at a panic that nobody is
  watching.
- **`nmi_watchdog=panic softlockup_panic=1`**, which `hwprep.py entry` puts on
  the badc entry along with `oops=panic` and `printk.always_kmsg_dump=1`, turn
  a detected lockup into a panic. Fedora's kernel and the badc build both
  leave lockup panics off -- `BOOTPARAM_HARDLOCKUP_PANIC` unset,
  `BOOTPARAM_SOFTLOCKUP_PANIC=0` -- so without them the NMI watchdog's
  detection is a warning and nothing more. `hardlockup_panic` and `panic_on_oops` are sysctl
  names and the command line takes neither; these are the boot-parameter
  forms.
- **`rhgb quiet` removed** so nothing is suppressed.

### A password-less root shell on the port

```
/etc/systemd/system/serial-getty@ttyS1.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --autologin root --keep-baud 115200,57600,38400,9600 ttyS1 $TERM
```

Debugging a kernel that reaches userspace but misbehaves means running
commands at the moment it happens; a login prompt in that situation costs
time and sometimes the evidence. The machine is a lab target on a private
network with Secure Boot off -- it holds no secret that a password would
protect.

The **`-f` inside `-o` is required**, and its absence is not obvious:
`--autologin root` alone still leaves `login` authenticating, so the port
answers with a password prompt and the journal records
`FAILED LOGIN 1 FROM ttyS1 FOR root`. `-o` is the option string handed to
`login`, and `-f` is what makes it accept the name without a password.

### Watchdog: the only unattended recovery

```bash
echo iTCO_wdt > /etc/modules-load.d/watchdog.conf
# /etc/systemd/system.conf.d/watchdog.conf
[Manager]
RuntimeWatchdogSec=60
RebootWatchdogSec=2min
```

The firmware actually provides an ACPI `wdat_wdt`, which systemd adopts;
`wdctl` reports a 60 s timeout with time left, so it is armed and being
petted. A kernel that wedges after systemd starts resets itself within a
minute.

Before the real root is mounted nothing pets it, and the case is not
hypothetical. A kernel whose boot entry lost its `root=` reaches the
initramfs, fails to mount the root filesystem, and parks in an emergency
shell; the watchdog configuration lives on the filesystem that was never
mounted, so nothing resets the box.

Magic SysRq is what ends that, and it is this machine's only remote reset
-- the battery makes a switched mains outlet useless. A BREAK on the line
followed by a command character reaches the kernel, so `s`, `u`, `b`
syncs, remounts read-only and reboots:

```
kernel.sysrq = 1        # persistent; Fedora's default of 16 permits sync alone
```

`tcsendbreak` on the descriptor that reads the port sends the BREAK, which
is what the harness does after the watchdog has had its chance. It is
best-effort: it needs a kernel still servicing interrupts.

A locked root account takes away the other half of the answer. `sulogin`
refuses a console it cannot authenticate on -- `Cannot open access to
console, the root account is locked` -- which on a box whose only console
is a serial line leaves no way in at all:

```
# /etc/systemd/system/emergency.service.d/override.conf, and the same for
# rescue.service
[Service]
Environment=SYSTEMD_SULOGIN_FORCE=1
```

### Suspend, disabled at every layer that can ask for it

A desktop session on the target will put it to sleep mid-run. Observed on
this box as a broadcast from the greeter -- `The system will suspend
now!` -- which ends the ssh connection and silences the console, and is
indistinguishable from a kernel that hung.

```bash
systemctl mask sleep.target suspend.target hibernate.target \
  hybrid-sleep.target suspend-then-hibernate.target
```

```
/etc/systemd/logind.conf.d/no-sleep.conf
[Login]
HandleLidSwitch=ignore
HandleLidSwitchDocked=ignore
HandleLidSwitchExternalPower=ignore
HandleSuspendKey=ignore
IdleAction=ignore
```

and the greeter's own policy, which is what asked here:

```bash
sudo -u gdm dbus-run-session -- gsettings set \
  org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
sudo -u gdm dbus-run-session -- gsettings set \
  org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing
sudo -u gdm dbus-run-session -- gsettings set \
  org.gnome.desktop.session idle-delay 0
```

Masking the targets is the layer that actually holds: whatever asks --
greeter, logind idle, the power button -- the request fails rather than
being honoured. `systemctl suspend` now answers `Call to Suspend failed:
Access denied`. The lid settings matter separately, because the machine
is a clamshell that will sit closed on a bench; without them, closing it
ends the run.

### No desktop

```bash
systemctl set-default multi-user.target
systemctl isolate multi-user.target        # applies without a reboot
```

The greeter is what asked to suspend, and a desktop session contributes
nothing to a kernel boot test while adding daemons, a compositor and a
power policy that can each act on the machine mid-run. Removing it also
returns about a gigabyte: the box now sits at 745 MB of 7.7 GB. The masks
above still hold whatever runs on top; this simply removes the layer that
kept asking.

### A shell in emergency mode, and a way back from a wedge

Both of these were added after a failed boot left the machine
unreachable with nothing to do but hold the power button.

```bash
# /etc/systemd/system/{emergency,rescue}.service.d/sulogin-force.conf
[Service]
Environment=SYSTEMD_SULOGIN_FORCE=1
```

```bash
# /etc/sysctl.d/99-sysrq.conf
kernel.sysrq = 1
```

The autologin getty covers a boot that reaches userspace. A boot that
does **not** drops to emergency mode, which runs `sulogin` -- and Fedora
ships the root account locked, so the console answers `Cannot open access
to console, the root account is locked.` and there is no shell at the one
moment a shell matters. `SYSTEMD_SULOGIN_FORCE=1` is the documented way
to let a headless machine past that.

`kernel.sysrq=1` makes a serial BREAK followed by a key reach the kernel,
so a wedged box can be synced and reset over the wire (`BREAK` then `s`,
then `b`). On this machine that is the *only* remote reset: the battery
means cutting mains power changes nothing, and the systemd watchdog is
useless once systemd is running but stuck at a prompt.

### What a failed boot leaves behind

Nothing on disk. A boot that ends in emergency mode never gets far enough
to flush the journal, so `journalctl -b -1` has no record of it --
verified after exactly that failure. **The serial console is the only
evidence**, which means the capture has to be running *before* the reboot
is issued and stay open across it. Opening the port afterwards catches
whatever is still in flight and nothing that came before.

One case now leaves more than that. With `nmi_watchdog=panic
softlockup_panic=1` on the badc entry, a lockup the NMI watchdog detects
panics rather than sitting there, so the trace reaches the console and,
where `hwprep.py arm` has enabled pstore, survives the reboot. A hang the
detector cannot catch is unchanged: the console holds whatever was
printed, and the chipset watchdog is what ends it.

## Booting a badc kernel

Never make one the default. Install it, select it for exactly one boot,
and let any failure fall back:

```bash
sudo dnf install -y ./kernel-7.1.10-*.x86_64.rpm    # or rpm -i
sudo grubby --info=ALL | grep -E '^(index|title)'   # find its index
sudo grub2-reboot <index>                            # one shot only
sudo systemctl reboot
```

`GRUB_DEFAULT=saved` keeps the distro kernel as the standing choice, so a
kernel that hangs is one power-button press away from a working system,
and an unattended failure that trips the watchdog comes back on the
distro kernel by itself.

Installing a kernel also **moves the standing default to it**:
`kernel-install` writes the new entry and `grubby --default-kernel` then
names it, which quietly removes the fallback the one-shot scheme depends
on. Put it back before rebooting:

```bash
sudo grubby --set-default /boot/vmlinuz-7.1.10-200.fc44.x86_64
```

`rpm -i` refuses a kernel whose version-release orders below the one the
box already runs -- the pinned release built as `-1` against Fedora's
`-200.fc44` -- with `package kernel-7.1.10-200.fc44.x86_64 (which is newer
than ...) is already installed`. Kernels are install-only, so the version
ordering is not meaningful here; `--oldpackage` is what gets past it, and
`dnf install` applies the same semantics on its own.

## The harness lane

`packages.py --phases hw` runs that sequence unattended, with the same
probes, dmesg scanners and exercise stage the qemu lanes use. The
[README](README.md) documents the phase; what it needs from this box is
what the sections above configure:

```sh
python3 demos/linux/packages.py --arch x86_64 --distro fedora --phases hw \
    --release <kernel release> --package <kernel rpm> \
    --hw-host <host> --hw-serial /dev/cu.usbserial-XXXX \
    --workdir <scratch> --report hw-x86_64.json
```

Three of this box's properties are the lane's load-bearing assumptions:

- **The standing default is a distro kernel.** The lane reads it with
  `grubby --default-kernel`, checks `CONFIG_CC_VERSION_TEXT` in that
  kernel's `/boot/config-<release>`, and refuses to run at all if the
  fallback is the release under test or one badc built. Nothing is
  installed before that check passes, and because the install itself moves
  the default, the lane reads it again afterwards and puts it back.
- **The watchdog is armed.** It is the only thing that ends a boot that
  wedges after systemd starts. When ssh does not return, the lane reports
  the stage the console reached and then waits for the box to come back on
  the standing default; that second wait is what separates a kernel that
  hung from a box that is gone. A boot that parks *before* the real root is
  mounted -- an initramfs emergency shell -- runs a systemd that never read
  `/etc/systemd/system.conf.d/watchdog.conf`, so nothing resets it. The lane
  names that outcome from the console rather than waiting the timeout out,
  and then resets the machine with SysRq over the serial line.
- **The console is on the wire from timestamp 0.000000.** `earlycon` is
  what turns "printed nothing" into a stage the report can name.
- **A failed boot leaves no journal.** `journalctl --list-boots` has no
  entry for one: emergency mode never gets far enough to flush a journal
  to disk. The serial console is the only record such a boot has, which is
  why the lane opens the port before it does anything else, holds it open
  across the reset, and writes the log unbuffered. A port opened after the
  fact catches whatever was still in flight and nothing that preceded it.

The lane leaves the machine on the standing default and clears any pending
one-shot selection on every exit path, including the failing ones. Like
the qemu lanes it turns on core capture, which writes `99-badc-*` drop-ins
under `/etc/sysctl.d`, `/etc/security/limits.d` and
`/etc/systemd/system.conf.d` and sets `kernel.core_pattern` to a file
pattern; those persist on the machine.

## Watching from the Mac

The DE-9 goes to a USB adapter on the Mac. Use the `cu.*` node, not
`tty.*` -- the latter blocks waiting for carrier detect:

```bash
ls /dev/cu.usbserial-* /dev/cu.SLAB_USBtoUART 2>/dev/null
picocom -b 115200 /dev/cu.usbserial-XXXX      # interactive; C-a C-x to quit
```

**Each `open()` of the port resets its termios on macOS**, so setting the
speed with `stty -f` in one command and reading in the next gets the
default rate, not 115200 -- the line then delivers a few bytes of
plausible-looking garbage rather than silence, which reads like a wiring
fault and is not one. Set the speed in the same descriptor that does the
reading. `picocom` does this; so does the harness, using `termios` from
the standard library rather than a `pyserial` dependency, which also
keeps the capture identical on the Linux lanes.

FTDI and CP210x adapters work with the drivers macOS ships; CH340 clones
usually need a kext.

## Still open

- **Netconsole as a second channel.** `netconsole=6666@<box-ip>/<iface>,6666@<mac-ip>/<mac-mac>`
  survives a misconfigured serial line. It needs the Mac's MAC address, so
  it is documented rather than enabled. `CONFIG_NETCONSOLE=m` here as on the
  other lane, so it would load on the interface's udev event rather than
  early -- `earlycon` remains this box's only view of the window before
  that.
- **kdump** is not installed. It would capture a vmcore for panics the
  serial line truncates, though a badc kernel's own kdump path is itself
  unproven.
## Undoing all of it

Every change above is reversible, and none of it touches the distribution
kernel or the bootloader binaries. `/etc/default/grub` was backed up
before the first edit.

```bash
# 1. Boot arguments and the GRUB console
sudo cp /etc/default/grub.badc-backup /etc/default/grub
sudo grubby --update-kernel=ALL --remove-args=\
"console=tty0 console=ttyS1,115200n8 earlycon=uart8250,io,0x2f8,115200n8 panic=30"
sudo grubby --update-kernel=ALL --args="rhgb quiet"
sudo rm -f /etc/kernel/cmdline          # regenerated on the next kernel install
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# 2. The serial root shell
sudo systemctl disable --now serial-getty@ttyS1.service
sudo rm -rf /etc/systemd/system/serial-getty@ttyS1.service.d

# 3. The watchdog
sudo rm -f /etc/modules-load.d/watchdog.conf /etc/systemd/system.conf.d/watchdog.conf
sudo systemctl daemon-reexec

# 4. Sleep
sudo systemctl unmask sleep.target suspend.target hibernate.target \
  hybrid-sleep.target suspend-then-hibernate.target
sudo rm -f /etc/systemd/logind.conf.d/no-sleep.conf
sudo systemctl restart systemd-logind
for k in sleep-inactive-ac-type sleep-inactive-battery-type; do
  sudo -u gdm dbus-run-session -- gsettings reset \
    org.gnome.settings-daemon.plugins.power $k
done
sudo -u gdm dbus-run-session -- gsettings reset org.gnome.desktop.session idle-delay

# 5. The desktop
sudo systemctl set-default graphical.target
sudo systemctl isolate graphical.target

# 6. Core capture, if the lane's probes ran
sudo rm -f /etc/sysctl.d/99-badc-cores.conf /etc/security/limits.d/99-badc-core.conf \
           /etc/systemd/system.conf.d/99-badc-core.conf
sudo rm -rf /var/crash
sudo systemctl daemon-reexec

# 7. Rescue-shell access and sysrq
sudo rm -rf /etc/systemd/system/emergency.service.d/sulogin-force.conf \
            /etc/systemd/system/rescue.service.d/sulogin-force.conf
sudo rm -f /etc/sysctl.d/99-sysrq.conf
sudo systemctl daemon-reload
```

One caveat on reversing the boot arguments: `grubby --remove-args` edits
the BLS entries that exist at that moment, so a kernel installed while
the serial configuration was in place keeps the arguments until it is
removed or its entry is edited too. `grubby --info=ALL` shows what each
entry currently carries.
