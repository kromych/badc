# SimpleVisor (Intel VT-x) as a badc Windows demo

[SimpleVisor](https://github.com/ionescu007/SimpleVisor) is Alex
Ionescu's small Intel VT-x hypervisor, built upstream as a Windows
kernel-mode driver. This demo builds its core VMX logic with badc into a
native-subsystem `.sys`, checks the image structurally, and exercises the
pure decode logic in user mode. It never loads the hypervisor: a VMX
fault takes the whole host down, and the boxes are shared.

SimpleVisor is x86-64 only, so only a `windows-x64` driver is built.

## What is built

`setup.py` fetches the upstream source snapshot from the badc vendor-deps
mirror (pinned commit `989d33b1`, sha256 verified) and drops the core VMX
sources into `src/`:

* `shv.c`, `shvutil.c`, `shvvmx.c`, `shvvmxhv.c`, `shvvp.c` and headers --
  compiled verbatim.

badc ships no WDK headers, so the demo supplies what the upstream build
takes from the SDK/WDK:

* `include/basetsd.h` -- the fixed-width typedefs.
* `include/intrin.h` -- the MSVC VMX / control-register / MSR / descriptor
  intrinsics, each written over badc's GNU inline asm. badc's bundled
  `<intrin.h>` leaves these undeclared on purpose; this one is resolved
  ahead of it via `-I`, as `demos/include/simd/intrin.h` does for
  `__cpuid`.
* `include/shvcompat.h` -- the SAL / `static_assert` spellings that are
  not codegen directives.
* `shvasm_x64.c` -- the upstream MASM modules (`shvvmxhvx64.asm`,
  `nt/shvosx64.asm`) translated to badc `__attribute__((naked))`
  functions with GNU inline asm.
* `shvos_badc.c` -- a demo-local Windows OS layer. SimpleVisor abstracts
  every platform service behind the `ShvOs*` contract (it ships an NT
  layer and a UEFI layer upstream); this is a third such layer that
  declares the ntoskrnl.exe routines it calls and binds them by name, the
  way `demos/wdm_driver` declares what it uses. It omits the upstream
  power-state callback (nothing here loads the driver) but keeps the
  memory, DPC and processor-topology services the VMX core calls.

## Checks (`smoke.py`)

1. **Driver build + structure** -- cross-built for `windows-x64` from any
   host into a `.sys`, then asserted: PE32+, machine AMD64, Subsystem
   NATIVE, entry inside `.text`, import table naming ntoskrnl.exe. Like
   `demos/wdm_driver`, the image carries no base-relocation table: badc's
   code is position-independent, so the kernel can load it at any base.
2. **Import resolution** (Windows hosts) -- every ntoskrnl.exe import is
   looked up in the export directory of the host's own
   `C:\Windows\System32\ntoskrnl.exe`, read as a file.
3. **User-mode logic harness** -- `harness/harness.c` runs
   `ShvUtilConvertGdtEntry` (segment-descriptor decode) and
   `ShvUtilAdjustMsr` (VMX capability-MSR adjustment) with the
   segment-limit intrinsic stubbed (`harness/intrin.h`), asserts
   hand-computed invariants, and -- when a host C compiler is present --
   is also built by it and the two outputs are compared. A divergence
   points at a badc codegen defect in bitfield/union access or masking.

## License

SimpleVisor is under the 2-clause BSD license (Copyright 2016 Alex
Ionescu); see the upstream `README.md` in the fetched snapshot. The
demo-local files here are badc project files.

## Build by hand

    python3 demos/simplevisor/setup.py
    python3 demos/simplevisor/smoke.py          # BADC=... CC=... to override
