//! Forward-call backpatching and synthetic libc-trampoline emission.
//!
//! Two passes that close out compilation:
//!
//!   * [`Compiler::apply_fn_call_fixups`] walks the linear table of
//!     `(operand_pc, sym_idx)` pairs recorded by every `Jsr` /
//!     bare-function-reference site and rewrites the operand to
//!     the callee's now-resolved bytecode PC. The same pass also
//!     drives `code_relocs` (static-initializer function-pointer
//!     slots) using the parallel `code_reloc_sym_idx` shadow.
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
use super::super::op::Op;
use super::super::token::Token;
use super::CODE_BASE;
use super::Compiler;

impl Compiler {
    /// Rewrite every recorded forward-call placeholder so each
    /// `Jsr` / fn-pointer-literal operand points at its callee's
    /// final bytecode PC. The c5 model lets a function be *called*
    /// before its body is parsed: the call-site emit only knows the
    /// callee's `Symbol` index, not its `val` (which is the
    /// bytecode PC the body will eventually land at). We stash the
    /// `(operand_pc, sym_idx)` pair in `fn_call_fixups` at the
    /// call-site emit; this pass walks the list and updates each
    /// operand once every body has been emitted. The bias on
    /// bare-function-reference emits (`CODE_BASE + val`) is
    /// detected by reading the op preceding the operand: `Op::Imm`
    /// means a value-context reference (fp = name) so the operand
    /// carries the `CODE_BASE` bias; otherwise the op is `Op::Jsr`
    /// and the operand is a raw bytecode PC.
    pub(super) fn apply_fn_call_fixups(&mut self) -> Result<(), C5Error> {
        for &(operand_pc, sym_idx) in &self.fn_call_fixups {
            let target = self.symbols[sym_idx].val;
            let op = self.text[operand_pc - 1];
            if op == Op::Imm as i64 {
                self.text[operand_pc] = CODE_BASE as i64 + target;
            } else {
                self.text[operand_pc] = target;
            }
        }
        // Static-initializer function-pointer entries (vtables /
        // function-pointer struct fields, e.g. dispatch tables of
        // libc callbacks). Each `CodeReloc` was recorded at parse
        // time with the
        // symbol's prototype-time `val` (often 0); the parallel
        // `code_reloc_sym_idx` tracks the originating symbol so
        // we can read its post-body `val` here. We rewrite both
        // the `target_bc_pc` and the matching little-endian
        // bytes in `data` -- both are sourced from the same
        // value at write time, so both must agree post-fixup.
        // The two arrays must be the same length (one symbol idx
        // per code reloc); a length mismatch is a bug in a
        // CodeReloc-emitting site that forgot to record its
        // sym idx.
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
            let new_target = self.symbols[sym_idx].val as u64;
            reloc.target_bc_pc = new_target;
            // Don't rewrite the data bytes -- the VM and per-target
            // writers walk `code_relocs` and lay down their own
            // bias (`CODE_BASE + target_bc_pc` for the VM; native
            // VA for ELF / Mach-O / PE). They read `target_bc_pc`,
            // not the placeholder bytes.
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
    /// after every real function body has been parsed -- so the
    /// emitted bytecode lands at the tail of `text` and never
    /// splits a caller mid-emission. Each trampoline is the
    /// shortest possible "re-push args, JsrExt, return" sequence:
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
        let entries: Vec<(usize, usize)> = self
            .sys_trampoline_sym
            .iter()
            .map(|(&sys_idx, &tr_idx)| (sys_idx, tr_idx))
            .collect();
        for (sys_idx, tr_idx) in entries {
            let bc_pc = self.text.len();
            self.symbols[tr_idx].val = bc_pc as i64;

            let fixed_nargs = self.symbols[sys_idx].params.len();
            let is_variadic = self.symbols[sys_idx].is_variadic;
            let binding_idx = self.symbols[sys_idx].val;

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
                self.emit_op(Op::TailExt);
                self.emit_val(binding_idx);
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

            self.emit_op(Op::Ent);
            self.emit_val(0);
            // c5 uses cdecl push order: the first declared arg
            // ends up on top of the stack (lowest address) so
            // JsrExt can load arg-K from `sp + K*16`. We re-emit
            // the pushes right-to-left -- last declared arg
            // first -- so the trampoline's own JsrExt sees the
            // same shape its caller passed in.
            for i in (0..nargs).rev() {
                self.emit_lea((i + 2) as i64);
                self.emit_op(Op::Li);
                self.emit_op(Op::Psh);
            }
            self.emit_op(Op::JsrExt);
            self.emit_val(binding_idx);
            if nargs > 0 {
                self.emit_op(Op::Adj);
                self.emit_val(nargs as i64);
            }
            self.emit_op(Op::Lev);
        }
    }
}
