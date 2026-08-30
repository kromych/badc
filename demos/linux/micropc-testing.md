# Booting badc kernels on real hardware: the GPD MicroPC

The VM lanes prove a kernel boots under an emulator whose devices badc's
output has never surprised. This box is the other half: a physical
machine, reached over a real RS-232 line, that runs the same packages.

## What the machine is

| | |
|---|---|
| Model | GPD MicroPC, BIOS 4.15, `192.168.1.39` |
| CPU | Celeron N4100 (Gemini Lake, Goldmont Plus), 4 cores |
| Firmware | UEFI, Secure Boot **disabled** |
| Storage | SATA SSD (`BIWIN SSD`, 119 GB) -- no NVMe |
| Serial | 16550A at I/O `0x2f8`, IRQ 3, exposed as the DE-9 port |
| Distribution | Fedora 44, kernel 7.1.10-200.fc44 |

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
kernel installed later inherits the same arguments.

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
- **`rhgb quiet` removed** so nothing is suppressed.

### A password-less root shell on the port

```
/etc/systemd/system/serial-getty@ttyS1.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -- \\u' --autologin root --keep-baud 115200,57600,38400,9600 ttyS1 $TERM
```

Debugging a kernel that reaches userspace but misbehaves means running
commands at the moment it happens; a login prompt in that situation costs
time and sometimes the evidence. The machine is a lab target on a private
network with Secure Boot off -- it holds no secret that a password would
protect.

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
minute. A kernel that hangs *before* that -- the interesting case --
still needs the power button, which is why every badc boot is one-shot.

## Booting a badc kernel

Never make one the default. Install it, select it for exactly one boot,
and let any failure fall back:

```bash
sudo dnf install -y ./kernel-7.1.6-*.x86_64.rpm     # or rpm -i
sudo grubby --info=ALL | grep -E '^(index|title)'   # find its index
sudo grub2-reboot <index>                            # one shot only
sudo systemctl reboot
```

`GRUB_DEFAULT=saved` keeps the distro kernel as the standing choice, so a
kernel that hangs is one power-button press away from a working system,
and an unattended failure that trips the watchdog comes back on the
distro kernel by itself.

## Watching from the Mac

The DE-9 goes to a USB adapter on the Mac. Use the `cu.*` node, not
`tty.*` -- the latter blocks waiting for carrier detect:

```bash
ls /dev/cu.usbserial-* /dev/cu.SLAB_USBtoUART 2>/dev/null
screen /dev/cu.usbserial-XXXX 115200          # interactive
```

For a run that has to be diffable against the emulator's console logs,
capture with timestamps rather than `screen`:

```bash
python3 - <<'EOF'
import serial, time
p = serial.Serial('/dev/cu.usbserial-XXXX', 115200, timeout=1)
with open('micropc-console.log', 'ab', buffering=0) as f:
    while True:
        b = p.readline()
        if b:
            f.write(time.strftime('[%H:%M:%S] ').encode() + b)
EOF
```

FTDI and CP210x adapters work with the drivers macOS ships; CH340 clones
usually need a kext.

## Still open

- **Netconsole as a second channel.** `netconsole=6666@<box-ip>/,6666@<mac-ip>/<mac-mac>`
  survives a misconfigured serial line and is live very early. It needs
  the Mac's MAC address, so it is documented rather than enabled.
- **kdump** is not installed. It would capture a vmcore for panics the
  serial line truncates, though a badc kernel's own kdump path is itself
  unproven.
- **A hardware lane in the harness.** `packages.py` drives qemu today;
  the same sequence -- install, select one-shot, reset, capture console,
  run the probes and the exercise stage -- applies to this box, with the
  console read from the Mac's USB adapter instead of a file qemu writes.
  That turns a real-hardware boot from a manual session into a gate.
