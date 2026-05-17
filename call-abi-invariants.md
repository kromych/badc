# Call-boundary invariants

Working reference for the host-ABI lift. Each entry is a *site that
encodes the current c5-cdecl 16-byte-slot contract*. The upcoming
refactor must either change the encoded assumption or delete the site.

## Contract today

* The VM stack stores every value in an **8-byte** slot.
* The native lowering re-encodes every `Op::Psh` as a **16-byte** slot
  so SP stays 16-byte aligned at call sites without a re-align per
  call.
* `Op::Lea N` for `N >= 2` reads parameter slot `N-1` at byte
  offset `(N-1) * 16` from FP; locals (`N <= -1`) at `N * 8`. See
  `lea_offset_bytes` in `aarch64.rs:3081` and `x86_64.rs:1210`.
* Call argument order: c5's cdecl push, **first declared parameter on
  top of stack**, i.e. at `[sp + 0]` at the call op.
* Host arg regs are populated by either (a) the call-site marshalling
  in `Op::Jsri`/`Op::JsrExt` (today's libc path), or (b) a per-function
  arg-shuffling thunk that re-spills `x0..x7` / `rdi..r9` into the
  callee's 16-byte slots before `bl`-ing the real body (today's direct
  user-call path).
* `main` and the program entrypoint receive args in host arg regs and
  spill them into the 16-byte cdecl slots in the prologue, same shape
  as the thunk.

## Codegen — aarch64.rs

* `lea_offset_bytes` (3081): params at `(off-1)*16`, locals at `off*8`.
* `Op::Psh` lowering (1742): `str x19, [sp, #-16]!` for Real,
  `mov pool_reg, x19` for Pseudo.
* `Op::Adj` lowering (1595): `add sp, sp, #16*N`.
* `Op::Jsr` (1873): bare `bl`; relies on the callee's thunk for the
  host-ABI→c5-slot fanout.
* `Op::Jsri` (1886): peeks `Adj N`, loads c5-stack args at `[sp + i*16]`
  into `x0..x7` + overflow at `sp + i*8`, `blr`, copy `x0` → `x19`.
* `Op::JsrExt` libc marshalling (2488): three branches —
  AAPCS64-non-variadic, AAPCS64-macOS-variadic-on-stack,
  Windows-AArch64-variadic-int-side. Each reads c5 slot stride 16 and
  walks `imp.is_variadic`, `imp.fixed_args`, `fp_arg_mask`.
* `Op::TailExt` (2012): assumes host arg regs are already loaded by
  caller, just branches via GOT.
* `emit_arg_thunk` (3192): host arg regs (`x0..x7`) + AAPCS64 stack
  args at `[fp+16+i*8]` → c5 slots at `[fp - 16*(N-i)]`.
* `emit_prologue` entry shape (3306–3327): same host-regs → 16-byte-
  slot spill, in reverse so arg 0 ends up on top.
* `function_is_variadic` (3113): byte-pattern detector for the
  `Lea LAST; Psh; Imm 2; Psh; Imm 8; Mul; Add; Si` va_start macro
  expansion (the `2 * 8 == 16` is the c5 slot stride).
* `param_count_for_func` (3160): scans `Lea / LdLocI / LdLocC` with
  `off >= 2` to recover the declared param count.
* `fp_arg_mask_at` (~2814): per-call-site bitmap of which args are FP
  vs int, drives the d0..d7 vs x0..x7 split in libc marshalling.

## Codegen — x86_64.rs

* `lea_offset_bytes` (1210): mirror of the aarch64 helper.
* `Op::Psh` (1966): `sub rsp, 16` + `mov [rsp], r13` for Real, pool
  reg for Pseudo.
* `Op::Adj` (1838): `add rsp, 16*N`.
* `Op::Jsr` (2089): bare `call rel32`, returns in RAX → R13.
* `Op::Jsri` (2110): SysV/Win64 split, loads c5-stack args into
  `rdi..r9` / `rcx..r9`, overflow at host stride 8, shadow space on
  Win64.
* `Op::JsrExt` libc marshalling (2258–2320): SysV-non-variadic,
  SysV-variadic (AL = XMM count), Win64-variadic (int regs only).
  Same `imp.is_variadic` / `imp.fixed_args` / `fp_arg_mask` plumbing
  as aarch64.
* `emit_arg_thunk` (~1305): SysV/Win64 thunk shapes.
  `host_stack_base = 16 + abi.shadow_space` produces the host's
  outgoing-arg offset.
* `emit_prologue` entry shape (3216–3242): pops the return-address-
  shaped slot, spills host arg regs into 16-byte c5 slots, pushes
  return back.
* `function_is_variadic` (1232) and `param_count_for_func` (1280):
  same shape as aarch64 helpers.

## Codegen — mod.rs

* `Abi.int_arg_regs` / `Abi.shadow_space` / `Abi.variadic_on_stack`
  (1175–1192): the per-target tuple that the libc marshalling reads.
* `ResolvedImport.is_variadic`, `ResolvedImport.fixed_args`,
  `ResolvedImport.returns_long_double` (305): per-binding metadata.
* `NativeOptions.optimize` (876): drives the pool regalloc on/off.

## Codegen — jit.rs, mach_o.rs, pe.rs

* `jit.rs` (~210): JIT entrypoint resolves `func_thunk_offsets` first,
  falling back to `bytecode_to_native` when the function has no
  declared params (no thunk needed).
* `mach_o.rs` (~2293): writer fixups consume `func_thunk_offsets` for
  address-of-function relocations.
* `pe.rs` (~1080): same shape for PE; Win64 always uses the thunk
  even for fp-typed-decl dispatch slots because shadow space
  requires host-side staging that bare c5-call wiring can't do.
* `BuildOutput.func_thunk_offsets` (mod.rs:624): the BTreeMap that
  binds each ent_pc to its thunk offset.

## VM — vm/mod.rs

* Slot stride is **8 bytes**, not 16 — the VM doesn't have a real
  native stack to keep aligned. Differences from codegen:
  * `Op::Psh`: `sp -= 8` (mod.rs:795).
  * `Op::Adj N`: `sp += N * 8` (mod.rs:733).
  * `Op::Ent`: locals reserved at 8-byte stride (mod.rs:722).
* `argv` setup (mod.rs:318): pointers at 8-byte spacing, host shape
  not c5 shape.
* `Op::Jsr` / `Op::Jsri` push the return PC at 8-byte stride
  (mod.rs:691).
* The VM also handles `JsrExt` by dispatching through `Host::call`
  and unpacks args from its 8-byte slots, so `is_variadic` /
  `fixed_args` are consumed VM-side too.

## Compiler — call sites

* The `Op::Psh ; Op::Jsr/Jsri/JsrExt ; Op::Adj N` sequence is emitted
  in `src/c5/compiler/expr.rs` (and `call_fixups.rs` for indirect
  calls). First declared arg pushed first → ends up on top of stack.
* `Op::Ent N` operand is the local-slot count, set in
  `src/c5/compiler/function.rs` once the body's local declarations
  are settled. The compiler does NOT emit any thunk; thunks are
  pure codegen output.
* va_start expansion is emitted by the preprocessor's `<stdarg.h>`
  macro definition: `va_start(ap, last)` →
  `ap = ((char *)&last) + sizeof(c5_arg_slot)` where the literal
  `8 * 2 = 16` is the c5 slot stride. The byte-pattern detector
  recovers this back; replacing the detector requires either
  a frontend flag (`Symbol::is_variadic`) plumbed onto the function
  table, or rewriting the macro to leave a clean marker (e.g. an
  unused `Op::Imm` with a sentinel value).

## Symbol / Program

* `Symbol::is_variadic` exists already (`src/c5/symbol.rs:19`) but is
  not surfaced in the `Program`'s function table the codegen consumes
  — only `ResolvedImport.is_variadic` is, and that's for libc bindings.
  Plumbing this through is the prerequisite for replacing
  `function_is_variadic`.
* `Program.text` is the flat bytecode the codegen walks; per-function
  metadata today is implicit (rediscovered by scanning).

## Linker — link_units.rs / call_fixups.rs

* Direct-call `Op::Jsr` targets are resolved to absolute bytecode PCs
  at link time. The host-ABI lift doesn't change this — the call op
  still references the function body's `Op::Ent` PC; the marshalling
  shape is decided at codegen time.
* Indirect-call dispatch tables (function pointers in static data)
  resolve to the thunk's offset, not the body's offset, on Win64 +
  Mach-O + JIT. Removing thunks means these tables resolve to the
  body's offset directly, with the codegen guaranteeing every body
  has a host-ABI-compatible prologue.

## Net assumptions to break or preserve

* **Break**: c5-stack 16-byte slots as the argument transport between
  caller and user-function callee. Args ride in host arg regs / host
  stack directly; the prologue spills them to c5 slots only if the
  body actually reads them via `Op::Lea`.
* **Break**: per-function arg-shuffling thunks; replaced by every
  user-function prologue doing the spill itself.
* **Break**: the va_start byte-pattern detector; replaced by
  `Symbol::is_variadic` on the function-table entry.
* **Preserve**: VM-side 8-byte slot stride. The VM doesn't see the
  ABI change — every value still rides an 8-byte slot through the
  interpreter.
* **Preserve**: `lea_offset_bytes` slot semantics *for the codegen
  view*. The body's `Op::Lea N` for `N >= 2` continues to read at
  the same FP-relative offset; only the prologue's *source* changes
  (host arg reg vs. caller's c5-stack push).
* **Preserve**: variadic call-site marshalling. The three-way split
  (AAPCS64, macOS-arm64, Win-arm64; and SysV vs Win64) is inherent to
  the host variadic ABIs and can't be collapsed at the call site.
  What collapses is the *fixed*-arg shape, which becomes one driver
  parameterised by `Abi`.
