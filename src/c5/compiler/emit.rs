//! Low-level emit primitives plus the small "rewrite the trailing
//! op" helpers and the per-symbol shadow / restore pair.
//!
//! Everything in here pushes onto `self.text` (the bytecode stream)
//! and the parallel `source_lines` / `source_functions` /
//! `source_file_indices` columns so a bc_pc lookup is a direct
//! index. The fn-pointer chain tracker (`fn_ptr_chain_depth`) is
//! invalidated by every `emit_op`; identifier-loads and unary `*`
//! re-seed it inside `expr()`.
//!
//! The trailing-load rewriters (`rewrite_trailing_load_as_psh`,
//! `pop_trailing_scalar_load`) implement the assignment / `&expr`
//! protocols by reaching into the last emitted op and converting it
//! from an rvalue load to a stack push or address. Both keep the
//! parallel debug-info columns in sync.

use super::super::error::C5Error;
use super::super::op::Op;
use super::super::symbol::Symbol;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{is_scalar_load_op_val, reemit_scalar_load};

impl Compiler {
    // ---- Lexer plumbing ----

    pub(super) fn next(&mut self) -> Result<(), C5Error> {
        self.lex
            .next(&mut self.symbols, &mut self.symbol_index, &mut self.data)
    }

    /// Skip tokens until the matching close paren. Caller has
    /// just consumed the opening `(`; on exit, `tk` is one past
    /// the matching `)`. Tracks nested parens and stops when the
    /// outermost `)` is reached. Used by the function-pointer
    /// declarator path and a handful of fallback parsers to
    /// discard parameter type lists c5 doesn't yet record.
    pub(super) fn skip_balanced_parens_after_open(&mut self) -> Result<(), C5Error> {
        let mut depth: i64 = 1;
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '(' {
                depth += 1;
            } else if self.lex.tk == ')' {
                depth -= 1;
                if depth == 0 {
                    self.next()?;
                    return Ok(());
                }
            }
            self.next()?;
        }
        Err(self.compile_err("unmatched parentheses"))
    }

    // ---- Code emission ----

    pub(super) fn emit_op(&mut self, op: Op) {
        // Any emit invalidates the function-pointer chain
        // tracking. Identifier loads and the unary `*` handler
        // re-seed it after their own emits when the symbol /
        // result is in fn-ptr lineage (see
        // `fn_ptr_chain_depth`).
        self.pending.fn_ptr_chain_depth = -1;
        self.text.push(op as i64);
        // Mirror text.len() one-for-one in source_lines /
        // source_functions / source_file_indices so a bc_pc
        // lookup is a direct index. Operand slots inherit the
        // op's source position.
        let file_idx = self.intern_source_file();
        self.source_lines.push(self.lex.line as u32);
        self.source_functions
            .push(self.current_function_name.clone());
        self.source_file_indices.push(file_idx);
    }

    pub(super) fn emit_val(&mut self, val: i64) {
        self.text.push(val);
        let file_idx = self.intern_source_file();
        self.source_lines.push(self.lex.line as u32);
        self.source_functions
            .push(self.current_function_name.clone());
        self.source_file_indices.push(file_idx);
    }

    /// Look up the lexer's current `(file)` in `source_files`,
    /// pushing a fresh entry if this is the first time we see it.
    /// Returns the resulting index. Index 0 is reserved for the
    /// translation unit's filename so the file table is always
    /// non-empty for the DWARF emitter (which uses index 0 as the
    /// CU's primary file).
    pub(super) fn intern_source_file(&mut self) -> u16 {
        let name = &self.lex.file;
        if let Some(pos) = self.source_files.iter().position(|f| f == name) {
            // Cap at u16::MAX to keep `source_file_indices` a tight
            // column. A translation unit with > 65k distinct
            // headers is well past anything we've seen; clamp
            // rather than overflow so the codegen still produces
            // *some* attribution.
            return pos.min(u16::MAX as usize) as u16;
        }
        let idx = self.source_files.len();
        self.source_files.push(name.clone());
        idx.min(u16::MAX as usize) as u16
    }

    /// Emit a plain `Op::Imm <val>` -- a 2-word `[op, operand]`
    /// pair that pushes a 64-bit constant into the accumulator.
    /// The constant is treated as a literal value with no
    /// runtime address-fixup; for data-segment offsets that need
    /// `__data` relocation use [`Self::emit_data_imm`] instead.
    pub(super) fn emit_imm(&mut self, val: i64) {
        self.emit_op(Op::Imm);
        self.emit_val(val);
    }

    /// Emit `Op::Lea <slot_off>` -- load the effective address of
    /// a stack slot (param positive, local negative) into the
    /// accumulator. Convenience wrapper for the very common
    /// `emit_op(Lea); emit_val(off);` pair.
    pub(super) fn emit_lea(&mut self, slot_off: i64) {
        self.emit_op(Op::Lea);
        self.emit_val(slot_off);
    }

    /// Emit `Op::Jmp <target_pc>` -- direct branch to a known
    /// bytecode PC. The placeholder shape (Jmp + 0 operand whose
    /// PC is captured for a later patch) doesn't fit this helper
    /// and stays inline at its handful of sites.
    pub(super) fn emit_jmp(&mut self, target_pc: i64) {
        self.emit_op(Op::Jmp);
        self.emit_val(target_pc);
    }

    /// Emit `Psh; Imm <val>; <op>` -- the three-op idiom for
    /// "apply `op` to the accumulator with `val` as the right-
    /// hand operand". The optimizer's immediate-form pass fuses
    /// the same triple into AddI / MulI / ShlI / etc., so the
    /// runtime cost is identical; this helper just consolidates
    /// the 11-odd parser sites that emit pointer-arithmetic
    /// scaling, bitfield mask-and-shift, post/pre-increment step
    /// values, and the like.
    pub(super) fn emit_binop_with_imm(&mut self, op: Op, val: i64) {
        self.emit_op(Op::Psh);
        self.emit_imm(val);
        self.emit_op(op);
    }

    /// Emit `Op::Imm <data_offset>` and record the operand's bytecode
    /// position in [`Compiler::data_imm_positions`]. Use this anywhere
    /// the immediate is the address of a string literal or a global --
    /// the VM treats the result identically to a plain `Op::Imm`, but
    /// the native backend needs the side channel to relocate the value
    /// against the real `__data` vmaddr at link time.
    pub(super) fn emit_data_imm(&mut self, data_offset: i64) {
        self.emit_op(Op::Imm);
        self.data_imm_positions.push(self.text.len());
        self.emit_val(data_offset);
    }

    /// Pad `self.data` with zero bytes so the next allocation lands on
    /// an 8-byte boundary. c5 treats every non-char type as i64-aligned
    /// (short / int / pointers / structs all 8-byte), so a global array
    /// of i64s placed after a char array (or any odd-length blob) would
    /// otherwise start unaligned and `ldr x19, [x19]` would fault on
    /// macOS arm64.
    pub(super) fn align_data_to_8(&mut self) {
        while !self.data.len().is_multiple_of(8) {
            self.data.push(0);
        }
    }

    /// True when the most recently emitted instruction is `Imm 0` --
    /// i.e. the expression that just finished compiling was the literal
    /// `0`. Used by [`Compiler::type_warning`] to suppress the NULL
    /// idiom warning on `pointer = 0`.
    pub(super) fn last_emit_is_zero(&self) -> bool {
        let n = self.text.len();
        n >= 2 && self.text[n - 1] == 0 && self.text[n - 2] == Op::Imm as i64
    }

    /// True if the most recent emitted op is `Op::Jsri` -- an indirect
    /// call through a variable / struct field whose return type the
    /// dialect can't track. Used by `type_warning` to silently accept
    /// an `int`-tagged rvalue assigned to a pointer lvalue (or vice
    /// versa): the actual register value carries a full 8-byte return
    /// regardless, so the assignment is a runtime no-op even though
    /// the type tag mismatches. The walker tolerates a trailing
    /// `Op::Adj N` (cleanup of pushed args) since that's the standard
    /// Jsri tail.
    pub(super) fn last_emit_was_indirect_call(&self) -> bool {
        let n = self.text.len();
        if n >= 1 && self.text[n - 1] == Op::Jsri as i64 {
            return true;
        }
        // Jsri + Adj N: 3 trailing words.
        n >= 3 && self.text[n - 2] == Op::Adj as i64 && self.text[n - 3] == Op::Jsri as i64
    }

    /// If the most recently emitted op is a scalar load (`Op::Lc`
    /// / `Op::Lw` / `Op::Li`), rewrite it in place to `Op::Psh` and
    /// return the matching reload op so the caller can `emit_op` it
    /// to put the original loaded value back into the accumulator.
    /// Returns `None` if the trailing op isn't a scalar load, in
    /// which case the caller reports its own "bad lvalue" error.
    ///
    /// The pattern shows up in pre/post-increment, plain
    /// assignment, and compound assignment. Centralising the
    /// `last() / last_mut() / Op::Psh` triple keeps the four
    /// call sites in sync when new load-op variants are added.
    pub(super) fn rewrite_trailing_load_as_psh(&mut self) -> Option<Op> {
        // Single `last_mut()?` recovers the trailing op as a
        // mutable slot; if `is_scalar_load_op_val` rejects it we
        // bail without touching anything, otherwise we capture the
        // reload op and overwrite the slot in place.
        let slot = self.text.last_mut()?;
        if !is_scalar_load_op_val(*slot) {
            return None;
        }
        let reload_op = reemit_scalar_load(*slot);
        *slot = Op::Psh as i64;
        Some(reload_op)
    }

    /// If the most recently emitted op is a scalar load (`Op::Lc`
    /// / `Op::Lw` / `Op::Li`), pop it -- the load's address-
    /// producing source op then sits at the new tail, ready to
    /// drive the surrounding lvalue operation. Returns `true` on
    /// success. Used by `&expr` to convert an rvalue load chain
    /// into an lvalue-address chain.
    pub(super) fn pop_trailing_scalar_load(&mut self) -> bool {
        if matches!(self.text.last(), Some(&op) if is_scalar_load_op_val(op)) {
            self.text.pop();
            // Keep parallel debug arrays in sync with `text`.
            // Without these matching pops the
            // source_functions / source_lines tail drifts past
            // text.len() and every later emit_op lands in the
            // wrong slot.
            self.source_lines.pop();
            self.source_functions.pop();
            self.source_file_indices.pop();
            true
        } else {
            false
        }
    }

    /// Emit code for accessing a bitfield. On entry `a` holds the
    /// address of the bitfield's 8-byte storage unit. The dispatch
    /// peeks at the next token: if it's `=`, an assignment follows
    /// and we emit a load-clear-shift-or-store sequence; otherwise
    /// we emit a load-shift-and-mask read sequence and let the
    /// surrounding expression continue.
    ///
    /// Self-contained on the c5 stack: read leaves the bitfield's
    /// value in `a` with no net stack change; write leaves the
    /// stored full-word value in `a` (the surrounding expression
    /// rarely uses a bitfield assignment's value, and the
    /// approximation is acceptable for the common case).
    pub(super) fn emit_bitfield_access(
        &mut self,
        bit_offset: u32,
        bit_width: u32,
    ) -> Result<(), C5Error> {
        let mask: i64 = if bit_width >= 64 {
            -1
        } else {
            (1i64 << bit_width) - 1
        };
        if self.lex.tk == Token::Assign {
            // Bitfield write: `s.f = expr`. The c5 stack discipline
            // is delicate here -- we need the storage address
            // available for the final Si, so push it now and reload
            // through indirection later.
            self.next()?; // consume `=`
            // a = field_addr; stack: [...]
            self.emit_op(Op::Psh); // stack: [..., field_addr]; a = field_addr
            self.emit_op(Op::Li); // a = old_value; stack: [..., field_addr]
            self.emit_op(Op::Psh); // stack: [..., field_addr, old_value]
            self.emit_op(Op::Imm);
            self.emit_val(!(mask << bit_offset)); // a = ~(mask << off)
            self.emit_op(Op::And); // a = old_value & ~(mask << off); stack: [..., field_addr]
            self.emit_op(Op::Psh); // stack: [..., field_addr, cleared]
            self.expr(Token::Assign as i64)?; // a = new_value
            self.emit_op(Op::Psh); // stack: [..., field_addr, cleared, new_value]
            self.emit_imm(mask);
            self.emit_op(Op::And); // a = new_value & mask; stack: [..., field_addr, cleared]
            if bit_offset > 0 {
                self.emit_op(Op::Psh);
                self.emit_imm(bit_offset as i64);
                self.emit_op(Op::Shl); // a = (new_value & mask) << bit_offset
            }
            // a = shifted; stack: [..., field_addr, cleared].
            // Op::Or pops cleared, ORs into a. After: a = combined;
            // stack: [..., field_addr]. The trailing Si pops
            // field_addr as the destination.
            self.emit_op(Op::Or);
            self.emit_op(Op::Si); // pops field_addr, stores a (=combined).
            self.ty = Ty::Int as i64;
            Ok(())
        } else {
            // Bitfield read: `s.f` in any non-assignment context.
            self.emit_op(Op::Li); // a = full storage word
            if bit_offset > 0 {
                self.emit_op(Op::Psh);
                self.emit_imm(bit_offset as i64);
                self.emit_op(Op::Shr); // a = (top >> bit_offset)
            }
            self.emit_op(Op::Psh);
            self.emit_imm(mask);
            self.emit_op(Op::And); // a = (...) & mask
            self.ty = Ty::Int as i64;
            Ok(())
        }
    }

    /// Save the current `class` / `type_` / `val` of
    /// `self.symbols[idx]` into the matching shadow fields
    /// `h_class` / `h_type` / `h_val`. Used at function-body
    /// scope when a parameter or local declaration shadows an
    /// outer name; the function-exit cleanup pass restores the
    /// outer binding by reading the shadow fields back.
    pub(super) fn shadow_symbol(&mut self, idx: usize) {
        let s = &mut self.symbols[idx];
        s.h_class = s.class;
        s.h_type = s.type_;
        s.h_val = s.val;
        s.h_fn_ptr_indirection = s.fn_ptr_indirection;
    }

    /// Inverse of [`Self::shadow_symbol`]: restore the saved outer
    /// binding from the `h_*` shadow fields. Static method
    /// because the cleanup pass walks `self.symbols.iter_mut()`
    /// and already holds a `&mut Symbol`; passing the symbol
    /// reference avoids re-borrowing the symbol table.
    pub(super) fn restore_shadowed_symbol(sym: &mut Symbol) {
        sym.class = sym.h_class;
        sym.type_ = sym.h_type;
        sym.val = sym.h_val;
        sym.fn_ptr_indirection = sym.h_fn_ptr_indirection;
    }
}
