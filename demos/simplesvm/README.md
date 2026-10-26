# SimpleSvm (AMD-V/SVM) as a badc Windows demo

[SimpleSvm](https://github.com/tandasat/SimpleSvm) is Satoshi Tanda's
small AMD SVM (Secure Virtual Machine) hypervisor with Nested Page
Tables, built upstream as a Windows kernel-mode driver. It is the AMD
counterpart to the Intel VT-x `demos/simplevisor`.

Upstream is written in C-style C++ (one `SimpleSvm.cpp`, one
`SimpleSvm.hpp`, one MASM module). badc is a C compiler, so this demo
builds the driver's logic as C99: `setup.py` rewrites the handful of
C++-only spellings in the source, the WDK/intrinsic surface is supplied
by demo-local headers, the MASM module is translated to a badc naked
function, and the result links into a native-subsystem `.sys`. The demo
checks the image structurally and exercises the pure bitfield logic in
user mode. It never loads the hypervisor: an SVM fault takes the whole
host down, and the boxes are shared.

SimpleSvm is x86-64 only, so only a `windows-x64` driver is built.

## What is built

`setup.py` fetches the upstream source snapshot from the badc
vendor-deps mirror (pinned commit `c4a479e0`, sha256 verified; falls
back to github.com/tandasat/SimpleSvm) and produces `src/`:

* `src/SimpleSvm.c` -- the upstream `SimpleSvm.cpp` with its C++-only
  spellings rewritten to C99. The rewrite is deterministic and touches
  no control flow, types or logic:
  * `reinterpret_cast<T>` / `static_cast<T>` -> `(T)`
  * `nullptr` -> `NULL`
  * `constexpr` -> `const`
  * `#pragma prefast(...)` lines (MSVC static-analysis directives) are
    dropped.
* `src/SimpleSvm.hpp` -- the VMCB and event-injection definitions,
  verbatim.

badc ships no WDK headers, so the demo supplies what the upstream build
takes from the SDK/WDK:

* `include/basetsd.h` -- the fixed-width typedefs.
* `include/intrin.h` -- the MSVC SVM / control-register / MSR /
  descriptor intrinsics, each written over badc's GNU inline asm. badc's
  bundled `<intrin.h>` leaves these undeclared on purpose; this one is
  resolved ahead of it via `-I` and `#include_next`s the bundled header
  for the intrinsics it does provide (`__cpuid`, `__debugbreak`), as
  `demos/simplevisor/include/intrin.h` does.
* `include/svcompat.h` -- the `EXTERN_C` / `static_assert` / SAL
  spellings, which are not codegen directives.
* `include/ntifs.h` -- the WDK types, constants, structures and the
  ntoskrnl.exe routines the driver calls, declared and bound by name
  the way `demos/wdm_driver` declares what it uses. Structure layouts
  (`CONTEXT`, `KTRAP_FRAME`) follow the documented windows-x64 ABI and
  carry size/offset asserts. Unlike SimpleVisor, SimpleSvm calls the
  WDK directly throughout its single source file rather than behind an
  OS-abstraction contract, so the demo supplies a header rather than an
  OS layer.
* `x64_asm.c` -- the upstream MASM module (`x64.asm`: the VMRUN loop
  `SvLaunchVm`) translated to a badc `__attribute__((naked))` function
  with GNU inline asm, plus `_sgdt`.

## Checks (`smoke.py`)

1. **Driver build + structure** -- cross-built for `windows-x64` from
   any host into a `.sys`, then asserted: PE32+, machine AMD64,
   Subsystem NATIVE, entry inside `.text`, and an import table that
   names only ntoskrnl.exe.
2. **Import resolution** (Windows hosts) -- every ntoskrnl.exe import is
   looked up in the export directory of the host's own
   `C:\Windows\System32\ntoskrnl.exe`, read as a file.
3. **User-mode logic harness** -- `harness/harness.c` runs the segment
   descriptor decode (`SvGetSegmentAccessRight`) and the #GP event
   packing (`SvInjectGeneralProtectionException`) over SimpleSvm's exact
   union/bitfield layouts (`harness/svbits.h`), asserts hand-computed
   invariants, and -- when a host C compiler is present -- is also built
   by it and the two outputs are compared. A divergence points at a badc
   codegen defect in bitfield/union access, shifts or masking.

## License

SimpleSvm is under the MIT license (Copyright 2017-2020 Satoshi Tanda);
see the upstream `LICENSE` in the fetched snapshot. The demo-local files
here are badc project files.

## Build by hand

    python3 demos/simplesvm/setup.py
    python3 demos/simplesvm/smoke.py          # BADC=... CC=... to override
