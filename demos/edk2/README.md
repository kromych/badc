# edk2 demo

Builds a UEFI application from real [TianoCore EDK II](https://github.com/tianocore/edk2)
MdePkg sources with badc, and boots it under OVMF/QEMU.

This is the project's headline target: badc compiles the MdePkg library
closure and links a **PE32+ EFI application** with its **own linker** -- no
external `ld`/`lld`, no `GenFw` -- that a real UEFI firmware loads and runs.
The app (`MyApp.c`) formats through EDK II's own `UnicodeSPrint`
(BasePrintLib) and writes to `ConOut`, so a correct boot exercises the whole
closure end to end.

## Run

```sh
cargo build --release --features full          # build badc
python3 demos/edk2/setup.py                     # fetch the MdePkg subset
python3 demos/edk2/smoke.py                      # build the .efi + boot it
```

## What's committed vs fetched

Committed: the hand-written glue that a full EDK II build would generate with
BaseTools AutoGen -- `AutoGenGlue.c` (the module entry glue, PCD database, and
library constructor/destructor lists), `MiniAutoGen.h` (the FixedAtBuild PCD
defaults), and the application `MyApp.c` -- plus the `qemu_efi.py` boot
harness. `setup.py` fetches the MdePkg source subset (headers + the closure's
C files, ~1.8 MB) from the vendor mirror into `src/`.

## Build shape

badc uses the MSVC compiler identity on X64 (EFIAPI = the MS x64 ABI, which
badc's `windows-x64` target already emits):

```
badc --freestanding --target=windows-x64
     -I MdePkg/Include -I MdePkg/Include/X64
     -D_MSC_EXTENSIONS -D_MSC_VER=1900 -Dstatic_assert=_Static_assert
     -include MiniAutoGen.h  <MyApp.c + AutoGenGlue.c + MdePkg closure>  -o app.efi
```

The library closure (`UefiApplicationEntryPoint`, the boot/runtime services
table libs, `BasePrintLib`, `BaseMemoryLib`, and the `BaseLib` math / string /
unaligned helpers) was resolved iteratively -- link, read the first undefined
symbol, add the MdePkg C file that defines it, repeat -- and is fixed in
`smoke.py`.

## Boot check

`smoke.py` verifies the output is a PE32+ EFI application (machine x64,
subsystem 10). If `qemu-system-x86_64` and OVMF firmware are present it also
boots the image (placed as `EFI/BOOT/BOOTX64.EFI` on a virtual FAT volume that
OVMF auto-boots) and checks the serial output for the app's banner; otherwise
the boot check is skipped and the build stands on its own.
