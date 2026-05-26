//! Code-reloc backpatching and synthetic libc-trampoline emission.
//!
//! Two passes that close out compilation:
//!
//!   * [`Compiler::resolve_code_relocs`] rewrites every recorded
//!     static-initializer function-pointer slot
//!     (`code_relocs[i].target_ent_pc`) to the originating
//!     symbol's post-body `Symbol::val` using the parallel
//!     `code_reloc_sym_idx` shadow. The native writers walk
//!     `Program::code_relocs` to lay down the per-target dynamic
//!     relocation for each slot.
//!
//!   * [`Compiler::ensure_sys_trampoline_sym`] +
//!     [`Compiler::emit_sys_trampolines`] handle the
//!     "address of a libc function" idiom: there's no compile-time
//!     libc address to fold in, so c5 synthesizes a tiny function
//!     whose body re-pushes its declared params and re-dispatches
//!     through `Op::JsrExt`. The synthetic symbol is allocated
//!     lazily on first reference; the bodies are emitted in one
//!     batch after every real function has landed so they never
//!     split a caller mid-emission.

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::lexer;
use super::super::token::Token;
use super::Compiler;

impl Compiler {
    /// Rewrite every `code_relocs[i].target_ent_pc` to the
    /// originating symbol's post-body `val`. Walker-tier
    /// `Inst::Call` / `Inst::ImmCode` references read the live
    /// `Symbol::val` directly through `live_fun_val` and need no
    /// post-parse fixup; only the data-segment function-pointer
    /// initializers reach this pass.
    pub(super) fn resolve_code_relocs(&mut self) -> Result<(), C5Error> {
        // The two arrays must be the same length (one symbol idx
        // per code reloc); a length mismatch is a bug in a
        // CodeReloc-emitting site that forgot to record its sym
        // idx.
        if self.code_relocs.len() != self.code_reloc_sym_idx.len() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                &format!(
                    "code_relocs ({}) and code_reloc_sym_idx ({}) length mismatch \
                 -- a CodeReloc emitter forgot to record its symbol idx",
                    self.code_relocs.len(),
                    self.code_reloc_sym_idx.len()
                ),
            )));
        }
        for (reloc, &sym_idx) in self
            .code_relocs
            .iter_mut()
            .zip(self.code_reloc_sym_idx.iter())
        {
            // The placeholder bytes in `self.data` stay
            // unmodified: the VM and per-target writers walk
            // `code_relocs` and lay down their own bias
            // (`CODE_BASE + target_ent_pc` for the VM; native VA
            // for ELF / Mach-O / PE). They read
            // `target_ent_pc`, not the data bytes.
            reloc.target_ent_pc = self.symbols[sym_idx].val as u64;
        }
        Ok(())
    }

    /// Look up (or lazily allocate) the synthetic-symbol idx that
    /// names the Sys-binding's per-call trampoline. Two clients
    /// reach for this:
    ///
    /// * Static initializers that take the address of a libc fn
    ///   (a `dispatch_table[7].pCurrent = fcntl`-style table).
    /// * Bare expression-position references (`fp = readlink;`).
    ///
    /// Both want a callable c5 function-pointer value with the
    /// same call shape as the libc fn. We synthesize it lazily
    /// in [`Self::emit_sys_trampolines`]; here we only ensure a
    /// stable symbol exists that downstream fixups can reference.
    pub(super) fn ensure_sys_trampoline_sym(&mut self, sys_sym_idx: usize) -> usize {
        if let Some(&idx) = self.sys_trampoline_sym.get(&sys_sym_idx) {
            return idx;
        }
        let name = format!("__c5_sys_trampoline_{sys_sym_idx}");
        let hash = lexer::hash_name(name.as_bytes());
        let sym = crate::c5::symbol::Symbol {
            name,
            token: Token::Id as i64,
            class: Token::Fun as i64,
            type_: self.symbols[sys_sym_idx].type_,
            params: self.symbols[sys_sym_idx].params.clone(),
            is_variadic: self.symbols[sys_sym_idx].is_variadic,
            val: 0,
            ..Default::default()
        };
        let idx = self.symbols.len();
        self.symbols.push(sym);
        // SymbolIndex must stay in sync with `symbols` -- even
        // for synthetic names that real source code can't reach
        // for. Without this the next user identifier the lexer
        // tries to register lands at a stale `idx` and chains
        // get crossed (and unrelated identifiers vanish). The
        // synthetic name is uniquely numbered so it can't shadow
        // anything user-visible.
        self.symbol_index.record(hash);
        self.sys_trampoline_sym.insert(sys_sym_idx, idx);
        idx
    }

    /// Emit the body of every requested Sys trampoline. Called
    /// after every real function body has been parsed so the
    /// synthesised SSA lands after the user code without
    /// splitting a caller mid-build. Each trampoline is the
    /// shortest possible "re-push args, CallExt, return" sequence:
    ///
    /// ```text
    /// Ent 0
    /// Lea 2  ; first arg slot
    /// Li
    /// Psh
    /// Lea 3  ; second arg slot
    /// Li
    /// Psh
    /// ...    ; one more pair per declared param
    /// JsrExt <binding-idx>
    /// Adj N  ; only if N > 0
    /// Lev
    /// ```
    ///
    /// Variadic libc fns lose anything beyond their declared
    /// fixed prefix -- a trampoline can only forward what its
    /// signature tells it to push. The known callers (e.g.
    /// dispatch-table slots for `fcntl` and `ioctl`) work
    /// because the cast at the use site lines up with the fixed
    /// prefix the trampoline does forward.
    pub(super) fn emit_sys_trampolines(&mut self) {
        use crate::c5::codegen::ssa_build::SsaBuilder;
        use crate::c5::ir::{LoadKind, NO_VALUE};

        let entries: Vec<(usize, usize)> = self
            .sys_trampoline_sym
            .iter()
            .map(|(&sys_idx, &tr_idx)| (sys_idx, tr_idx))
            .collect();
        for (sys_idx, tr_idx) in entries {
            let ent_pc = self.next_ent_pc;
            self.symbols[tr_idx].val = ent_pc as i64;
            // C99 6.9 has no notion of synthetic helpers, but
            // a trampoline body is emitted into this TU's text,
            // so its symbol is `defined here` for the linker
            // concat: the rebase loop in `linker::link` shifts
            // every `Token::Fun` sym with `defined_here = true`
            // by `text_base[i]` so post-link callers find the
            // body at the post-link ent_pc.
            self.symbols[tr_idx].defined_here = true;

            let fixed_nargs = self.symbols[sys_idx].params.len();
            let is_variadic = self.symbols[sys_idx].is_variadic;
            let binding_idx = self.symbols[sys_idx].val;
            // Forwarded arg count. Variadic prefix forwards one
            // extra so dispatch tables (open / fcntl / ioctl)
            // line up.
            let nargs_ssa = if fixed_nargs == 0 && !is_variadic {
                0
            } else if is_variadic {
                fixed_nargs + 1
            } else {
                fixed_nargs
            };
            // The synthesised trampoline's own signature is a
            // fixed-arg host-ABI function: callers reach it via
            // function pointer through `(sys_ptr)open`, which the
            // SysV / AAPCS / win64 ABIs deliver in the integer
            // arg registers regardless of whether the underlying
            // libc callee is variadic. The `is_variadic` flag on
            // the SSA function controls the prologue's arg-pickup
            // shape (c5 stack slots vs host ABI registers) -- the
            // trampoline always wants host ABI. The callee's
            // variadicness is encoded on the binding and
            // re-derived by `Inst::CallExt` lowering, so flipping
            // the trampoline's flag to `false` leaves the libc-
            // side `al = xmm_count` setup intact.
            let mut sb = SsaBuilder::new(ent_pc, nargs_ssa, false);
            sb.set_locals(0);
            // Synthetic trampoline body forwarding to the libc
            // binding `self.symbols[sys_idx].name`; tag the
            // FunctionSsa with a deterministic name so the symbol
            // table and DWARF subprogram DIEs identify it.
            sb.set_name(alloc::format!("__c5_sys_{}", self.symbols[sys_idx].name));
            let _alloca = sb.alloca_init(0);
            // Zero-arg and arg-forwarding shapes both flow through
            // the standard `call_ext + return` pair so the codegen
            // emits a matching prologue / epilogue. A bare
            // `Terminator::TailExt` would skip the epilogue --
            // libc's `ret` then pops the trampoline's saved rbp as
            // its return address and the next instruction lands in
            // stack memory.
            let arg_vals: alloc::vec::Vec<_> = (0..nargs_ssa)
                .map(|i| sb.load_local((i + 2) as i64, LoadKind::I64))
                .collect();
            let r = sb.call_ext(binding_idx, arg_vals, 0);
            sb.return_(r);
            let mut func = sb.finish();
            // SsaBuilder doesn't know the ent_pc until the
            // PC reservation below runs. Patch `end_pc` after
            // the reservation so the DWARF emitter's per-
            // function range covers the trampoline body.
            func.end_pc = ent_pc; // patched after the reservation
            let _ = NO_VALUE; // keep import non-warning
            self.synthetic_ssa_funcs.push(func);
            let synth_idx = self.synthetic_ssa_funcs.len() - 1;

            // Two trampoline shapes coexist:
            //
            // * Prototype-bearing bindings (`int fopen(char *,
            //   char *);`, ..., or any `int foo(...);`) get the
            //   classic `Ent + Lea/Li/Psh + JsrExt + Adj + Lev`
            //   body. The forwarded arg count matches the
            //   prototype, and the JsrExt lowering's per-arg
            //   FP-mask + post-call sub-word extension (#48) both
            //   stay in scope.
            //
            // * Bindings with *no* declared params (just
            //   `int Name();`) -- e.g. kernel32 entries that
            //   real-world dispatch tables cast back to the
            //   right arity at the call site -- get the
            //   single-op `Op::TailExt` body. The trampoline is
            //   `jmp [rip+iat]` and the caller's `Op::Jsri`
            //   lowering owns the host-ABI arg setup, return-
            //   register copy, and stack adjustment. Sub-word
            //   extension is left to the caller (the call site
            //   casts the result to the right type explicitly),
            //   which matches what real-world dispatch-table
            //   consumers already do.
            if fixed_nargs == 0 && !is_variadic {
                // The SSA-tier trampoline body is fully built by
                // SsaBuilder above; bump the parser PC counter by
                // one so the synthesised function's `end_pc`
                // stays strictly greater than its `ent_pc`, which
                // is what the linker and DWARF range builder
                // require.
                self.next_ent_pc += 1;
                self.synthetic_ssa_funcs[synth_idx].end_pc = self.next_ent_pc;
                continue;
            }

            // For variadic libc fns the binding-declared param
            // count is only the fixed prefix; common dispatch
            // tables (open/fcntl/ioctl) want the trampoline to
            // forward *one* of the variadic args so the caller's
            // 3-argument cast lines up with what `JsrExt` packs
            // onto the macOS arm64 variadic-args stack region.
            // Callers that pass strictly the fixed prefix end up
            // reading one junk slot from above their own pushes,
            // but no in-the-wild caller does -- they all add at
            // least one extra arg precisely to feed the variadic.
            // The general case (forward N variadic args where N
            // is unknown at compile time) needs a real va_args
            // bridge -- tracked separately with the `c5 va_list`
            // work.
            let nargs = if is_variadic {
                fixed_nargs + 1
            } else {
                fixed_nargs
            };

            // SSA body fully built by SsaBuilder above. Reserve a
            // single PC unit so the trampoline's `end_pc` is
            // strictly greater than `ent_pc`, satisfying the
            // linker / DWARF range invariant. The cdecl
            // right-to-left arg push, JsrExt + binding, Adj
            // cleanup and Lev epilogue used to be tape ops here;
            // the matching SSA insts live on
            // `synthetic_ssa_funcs[synth_idx]` and drive the codegen.
            let _ = (nargs, binding_idx);
            self.next_ent_pc += 1;
            self.synthetic_ssa_funcs[synth_idx].end_pc = self.next_ent_pc;
        }
    }
}
