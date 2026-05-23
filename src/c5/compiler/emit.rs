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

use super::super::ast::{Expr, ExprId, SrcPos};
use super::super::error::C5Error;
use super::super::op::Op;
use super::super::symbol::Symbol;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::is_unsigned_ty;
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
        // Any scalar load whose source is *not* the
        // identifier-rvalue path (field access through `->` /
        // `.`, array indexing through `Op::Brak`, deref through
        // `*`, bitfield extraction) invalidates the tracked
        // identifier whose load was previously trailing. Once
        // the trailing Li belongs to a non-identifier address,
        // a downstream `pop_trailing_scalar_load` /
        // `rewrite_trailing_load_as_psh` must not retract
        // `was_read` from the prior identifier. The
        // identifier-rvalue path in `expr.rs` re-sets the field
        // explicitly after its own load emit.
        if is_scalar_load_op_val(op as i64) {
            self.pending.last_loaded_local = None;
        }
        // Control-flow boundaries flush the dead-store tracker.
        // Function-terminating ops (`Op::Lev`, `Op::TailExt`)
        // have no successor, so any pending store is
        // unambiguously dead and gets reported. Non-terminal
        // boundaries (branches, calls) silently drop the
        // entries because a store straddling such an op may be
        // live in a successor that the analysis can't follow
        // without flow data.
        match op {
            Op::Lev | Op::TailExt => self.emit_dead_stores_and_flush(),
            Op::Jmp | Op::Bz | Op::Bnz | Op::Jsr | Op::JsrExt | Op::Jsri => {
                self.flush_pending_stores();
            }
            _ => {}
        }
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
        // Dual-emit hook -- keep the AST in lockstep with the
        // bytecode for ops whose AST shape is determined by `op`
        // alone (push / pop of the parser-side vstack, arithmetic
        // and comparison binops, unary fneg). Ops that carry an
        // operand word (Imm, Lea, ...) wire their AST through the
        // helper that owns the operand value (`emit_imm`,
        // `emit_lea`, ...); control-flow ops (Jmp / Bz / Bnz /
        // Jsr / Lev / ...) wire at the stmt parser sites that
        // know the matching AST shape.
        self.ast_track_emit_op(op);
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
        // emit_imm is the low-level bytecode primitive and does
        // not touch the AST. Seed `ast_acc` with the matching
        // IntLit so the next emit_op's binop sees a paired rhs.
        // The synthetic literal is always C99 `int`-typed --
        // pointer scaling / mask / shift step constants all fit
        // in the 32-bit signed range C99 6.4.4.1 gives an
        // unsuffixed decimal literal.
        self.ast_emit_int_lit(val, Ty::Int as i64);
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
        // Dual-emit: the bytecode rewrite turns `<addr>; Li` into
        // `<addr>; Psh`, meaning the address producer's value
        // ends up on the c5 stack. Mirror that move on the AST
        // side -- push the current `ast_acc` slot onto the
        // parser vstack and clear the accumulator. `None` here
        // represents an address producer whose AST counterpart
        // hasn't been wired yet; the downstream store op then
        // sees a `None` lvalue and skips the Assign build.
        self.ast_vstack.push(self.ast_acc.take());
        Some(reload_op)
    }

    /// Take the symbol index of the most recently emitted scalar
    /// load of a `Token::Loc` and restore the symbol's
    /// `was_read` flag to the value it held immediately before
    /// the identifier-rvalue path tentatively set it. The
    /// assignment / compound-assign / increment paths call this
    /// after `rewrite_trailing_load_as_psh` (or
    /// `pop_trailing_scalar_load`) so they can mark the lvalue
    /// as written; paths that re-emit the load (compound assign,
    /// post-/pre-increment) also force `was_read` back to true
    /// after the call to reflect the surviving load. Returns
    /// `None` when the trailing load wasn't a local (a global, a
    /// dereferenced pointer rvalue, a field load through `->` /
    /// `.`) -- the unused-symbol analysis tracks `Token::Loc`
    /// only.
    pub(super) fn take_last_loaded_local(&mut self) -> Option<usize> {
        let idx = self.pending.last_loaded_local.take()?;
        self.symbols[idx].was_read = self.pending.last_loaded_local_prior_was_read;
        self.symbols[idx].pending_stores =
            core::mem::take(&mut self.pending.last_loaded_local_prior_pending);
        // If the restored list is non-empty, make sure the
        // symbol is back on the function-level pending list so a
        // later control-flow op can flush it.
        if !self.symbols[idx].pending_stores.is_empty()
            && !self.pending_store_symbols.contains(&idx)
        {
            self.pending_store_symbols.push(idx);
        }
        Some(idx)
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
            // The load is gone -- the symbol's value never gets
            // read at runtime through this path. Revert the
            // tentative `was_read` the identifier-rvalue path
            // set (preserving any genuine read recorded by an
            // earlier expression) and record `address_escaped`:
            // the caller (currently the unary `&` operator) is
            // converting the rvalue load chain into an
            // lvalue-address chain, and the resulting pointer
            // can escape into surrounding code that the
            // unused-symbol analysis can't follow.
            if let Some(idx) = self.take_last_loaded_local() {
                self.symbols[idx].address_escaped = true;
            }
            // Dual-emit: the bytecode drops the trailing load so
            // the address producer's value stays in the
            // accumulator; the AST wraps that producer in
            // `Expr::Unary { op: AddrOf, child }` so the walker
            // emits the address path rather than a load.
            self.ast_apply_unary(super::super::ast::UnOp::AddrOf);
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
        unit_size: u8,
        field_ty: i64,
    ) -> Result<(), C5Error> {
        let mask: i64 = if bit_width >= 64 {
            -1
        } else {
            (1i64 << bit_width) - 1
        };
        // The bitfield's storage unit width (C99 6.7.2.1p11) picks
        // the load / store opcode pair. Sub-word units must not
        // load eight bytes -- doing so would mix in adjacent
        // fields and the subsequent merge would clobber them.
        let (load_op, store_op) = match unit_size {
            1 => (Op::Lc, Op::Sc),
            2 => (Op::Lh, Op::Sh),
            4 => (Op::Lw, Op::Sw),
            _ => (Op::Li, Op::Si),
        };
        if self.lex.tk == Token::Assign {
            // Bitfield write: `s.f = expr`. The c5 stack discipline
            // is delicate here -- we need the storage address
            // available for the final Si, so push it now and reload
            // through indirection later.
            self.next()?; // consume `=`
            // a = field_addr; stack: [...]
            self.emit_op(Op::Psh); // stack: [..., field_addr]; a = field_addr
            self.emit_op(load_op); // a = old_value; stack: [..., field_addr]
            self.emit_op(Op::Psh); // stack: [..., field_addr, old_value]
            self.emit_op(Op::Imm);
            self.emit_val(!(mask << bit_offset)); // a = ~(mask << off)
            self.emit_op(Op::And); // a = old_value & ~(mask << off); stack: [..., field_addr]
            self.emit_op(Op::Psh); // stack: [..., field_addr, cleared]
            self.expr(Token::Assign as i64)?; // a = new_value
            // Stash the rhs AST id before the trailing Op::Si
            // clears `ast_acc` via `ast_apply_assign`. The
            // surrounding Member handler reads this and builds
            // `Expr::BitfieldAssign` so the walker reproduces the
            // load-clear-shift-or-store sequence.
            self.pending.bf_assign_rhs = self.ast_acc;
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
            self.emit_op(store_op); // pops field_addr, stores a (=combined).
            self.ty = Ty::Int as i64;
            Ok(())
        } else if self.lex.tk == Token::AssignOp {
            // Bitfield compound assignment: `s.f OP= expr` per C99
            // 6.5.16.2 ("E1 = E1 OP E2 with E1 evaluated once").
            // The math needs old_value twice -- once to extract the
            // current bitfield value as the binop's left operand,
            // once to clear the slot for the final merge. A
            // dedicated scratch local hands `Op::StLocI` /
            // `Op::LdLocI` the spill / reload pair that the plain
            // `Lea N; Si` shape cannot express (Lea clobbers `a`).
            let binop = self.lex.ival;
            self.next()?; // consume the assign-op
            self.loc_offs += 1;
            if self.loc_offs > self.max_loc_offs {
                self.max_loc_offs = self.loc_offs;
            }
            let ov_temp = -self.loc_offs;
            // a = field_addr; stack: [...]
            self.emit_op(Op::Psh); // stack: [..., field_addr]
            self.emit_op(load_op); // a = old_value
            // Spill old_value into the scratch local without
            // disturbing `a` or the c5 stack.
            self.emit_op(Op::StLocI);
            self.emit_val(ov_temp);
            // Extract current = (old_value >> bit_offset) & mask.
            if bit_offset > 0 {
                self.emit_binop_with_imm(Op::Shr, bit_offset as i64);
            }
            self.emit_binop_with_imm(Op::And, mask);
            // Evaluate the RHS with `current` on the c5 stack so
            // the binop pops it as the left operand. Right-hand-
            // side parsing follows the same precedence as a bare
            // assignment.
            self.emit_op(Op::Psh); // stack: [..., field_addr, current]
            self.expr(Token::Assign as i64)?;
            let op = match binop {
                x if x == Token::AddOp as i64 => Op::Add,
                x if x == Token::SubOp as i64 => Op::Sub,
                x if x == Token::MulOp as i64 => Op::Mul,
                x if x == Token::DivOp as i64 => Op::Div,
                x if x == Token::ModOp as i64 => Op::Mod,
                x if x == Token::AndOp as i64 => Op::And,
                x if x == Token::OrOp as i64 => Op::Or,
                x if x == Token::XorOp as i64 => Op::Xor,
                x if x == Token::ShlOp as i64 => Op::Shl,
                x if x == Token::ShrOp as i64 => Op::Shr,
                _ => return Err(self.compile_err("unsupported compound op on bitfield")),
            };
            self.emit_op(op);
            // Mask + shift the combined value back into the slot.
            self.emit_binop_with_imm(Op::And, mask);
            if bit_offset > 0 {
                self.emit_binop_with_imm(Op::Shl, bit_offset as i64);
            }
            // shifted_new in `a`. Push it so the next ops can
            // reload the cleared old_value into `a`.
            self.emit_op(Op::Psh); // stack: [..., field_addr, shifted_new]
            self.emit_op(Op::LdLocI);
            self.emit_val(ov_temp);
            self.emit_binop_with_imm(Op::And, !(mask << bit_offset));
            self.emit_op(Op::Or); // pops shifted_new; a = cleared | shifted_new
            self.emit_op(store_op); // pops field_addr, stores a
            self.ty = Ty::Int as i64;
            Ok(())
        } else {
            // Bitfield read: `s.f` in any non-assignment context.
            // C99 6.7.2.1p10: a bitfield's signedness follows its
            // declared base type. For a signed bitfield narrower than
            // the c5 accumulator width, the post-mask value is in
            // [0, 2^width) and must be sign-extended so that bit
            // (width-1) propagates through the high half of the
            // 64-bit accumulator; without this `signed short f:2`
            // with the bit pattern `11` reads as `3` instead of `-1`.
            self.emit_op(load_op); // a = full storage word
            if bit_offset > 0 {
                self.emit_op(Op::Psh);
                self.emit_imm(bit_offset as i64);
                self.emit_op(Op::Shr); // a = (top >> bit_offset)
            }
            self.emit_op(Op::Psh);
            self.emit_imm(mask);
            self.emit_op(Op::And); // a = (...) & mask
            if !is_unsigned_ty(field_ty) && bit_width < 64 {
                let shift = 64i64 - (bit_width as i64);
                self.emit_binop_with_imm(Op::Shl, shift);
                self.emit_binop_with_imm(Op::Shr, shift); // Op::Shr is arithmetic
            }
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
        s.h_array_size = s.array_size;
        s.h_inner_array_size = s.inner_array_size;
        // Clone rather than `mem::take`: the inner-scope binding
        // (parameter or block local) keeps using the live
        // `array_dims` for the duration of its scope. Restore
        // copies the shadow back on scope exit.
        s.h_array_dims = s.array_dims.clone();
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
        sym.array_size = sym.h_array_size;
        sym.inner_array_size = sym.h_inner_array_size;
        sym.array_dims = core::mem::take(&mut sym.h_array_dims);
    }

    // ---- AST dual-emit helpers ----
    //
    // The parser's Op::* emit sites pair with the AST helpers below
    // so a function's bytecode and AST are produced in lockstep.
    // The bytecode remains the source of truth during Phase C2;
    // Phase C4 wires the validator that asserts the AST walker
    // produces the same SSA as the bytecode lift.

    /// Reset the AST + parser-side value stack at the start of a
    /// function body. The arena drops the previous function's
    /// nodes wholesale; the accumulator and vstack go empty
    /// because no expression has produced a value yet at function
    /// entry.
    pub(super) fn ast_reset(&mut self) {
        self.ast = super::super::ast::Ast::new();
        self.ast_acc = None;
        self.ast_vstack.clear();
        self.ast_labels.clear();
    }

    /// Capture the just-finished function's AST + the metadata
    /// the SSA walker needs (ent_pc, param count, variadic flag,
    /// post-parse local high-water mark, function name) into the
    /// per-TU snapshot vector. Called from the end-of-function-
    /// body hook in `run_compile`, right after the trailing
    /// `Op::Lev`. The `ast_acc` / `ast_vstack` parser-side state
    /// is left alone -- the next function's `ast_reset` zeroes it.
    #[allow(clippy::too_many_arguments)]
    pub(super) fn ast_finish_function(
        &mut self,
        ent_pc: usize,
        n_params: usize,
        is_variadic: bool,
        param_tys: alloc::vec::Vec<i64>,
        param_local_slots: alloc::vec::Vec<i64>,
        returns_struct: bool,
        return_struct_size: i64,
        alloca_top_slot: i64,
    ) {
        let finished = super::super::ast::FinishedFunction {
            ast: core::mem::take(&mut self.ast),
            ent_pc,
            n_params,
            is_variadic,
            n_locals: self.max_loc_offs,
            name: self.current_function_name.clone(),
            param_tys,
            param_local_slots,
            returns_struct,
            return_struct_size,
            alloca_top_slot,
        };
        self.finished_functions.push(finished);
    }

    /// Count occurrences of `op` in the bytecode region
    /// `[start, end)`. Skips operand words by stepping through
    /// `Op::word_size()`; ops outside the known set count as
    /// 1-word for safety, which is correct for every op the
    /// compiler currently emits.
    fn count_op_in_region(&self, op: super::super::op::Op, start: usize, end: usize) -> usize {
        let mut count = 0usize;
        let mut pc = start;
        while pc < end {
            if pc < self.text.len() && self.text[pc] == op as i64 {
                count += 1;
            }
            // Step by the op's word size. If the slot doesn't
            // hold a recognised op (likely the operand word of
            // a multi-word op), advance one to stay aligned.
            let step = super::super::op::Op::from_i64(self.text[pc])
                .map(|o| o.word_size())
                .unwrap_or(1);
            pc += step.max(1);
        }
        count
    }

    /// Count occurrences of any op in `ops` in the bytecode
    /// region `[start, end)`.
    fn count_ops_in_region(&self, ops: &[super::super::op::Op], start: usize, end: usize) -> usize {
        let mut count = 0usize;
        let mut pc = start;
        while pc < end {
            let opcode = self.text.get(pc).copied().unwrap_or(0);
            if let Some(op) = super::super::op::Op::from_i64(opcode) {
                if ops.contains(&op) {
                    count += 1;
                }
                pc += op.word_size().max(1);
            } else {
                pc += 1;
            }
        }
        count
    }

    /// Count AST `Expr` variants matching `pred` in `func.ast`.
    fn count_ast_exprs(
        &self,
        func: &super::super::ast::FinishedFunction,
        pred: impl Fn(&super::super::ast::Expr) -> bool,
    ) -> usize {
        func.ast.exprs.iter().filter(|e| pred(e)).count()
    }

    /// Run the AST walker against every captured function and
    /// emit per-function diagnostics. Two flavors land:
    ///
    /// * Walker-error lines for shapes the parser pushed but the
    ///   walker can't lower yet.
    /// * Coverage lines comparing the function's AST node count
    ///   to its bytecode word count -- a low ratio flags
    ///   shapes the parser silently dropped (the walker would
    ///   otherwise miss them because the AST never carried the
    ///   node).
    ///
    /// Gated by `BADC_VALIDATE_AST` in `compile()`; never fails
    /// the build. Pushed onto `self.warnings` so the CLI emits
    /// them on stderr at the end of compilation.
    pub(super) fn validate_finished_asts(&mut self) {
        let target = self.target;
        // Sorted ent_pc list lets us bracket each function's
        // bytecode region by the next entry's ent_pc -- the
        // bytecode laid them out in declaration order so the
        // sort is mostly a no-op, but synthetic trampolines
        // append at the end and shouldn't fold into the last
        // user function's region.
        let mut ent_pcs: alloc::vec::Vec<usize> =
            self.finished_functions.iter().map(|f| f.ent_pc).collect();
        ent_pcs.sort_unstable();
        ent_pcs.push(self.text.len());
        for func in self.finished_functions.clone() {
            let bytecode_end = ent_pcs
                .iter()
                .copied()
                .find(|&pc| pc > func.ent_pc)
                .unwrap_or(self.text.len());
            let bytecode_words = bytecode_end.saturating_sub(func.ent_pc);
            let ast_nodes = func.ast.exprs.len() + func.ast.stmts.len() + func.ast.decls.len();
            // Coverage ratio: percent of (heuristic) "AST nodes
            // per bytecode word" -- a fully wired function lands
            // around 30-50% (one AST node per 2-3 bytecode
            // words, since each op + operand pair is one ExprId
            // most of the time). Sub-5% means the parser
            // silently dropped most shapes.
            let pct = (ast_nodes * 100).checked_div(bytecode_words).unwrap_or(0);
            self.warnings.push(alloc::format!(
                "ast::walk: function `{}` (ent_pc={}) coverage {}/{} bytecode words = {}%",
                func.name,
                func.ent_pc,
                ast_nodes,
                bytecode_words,
                pct,
            ));
            // Blind-spot diff: count specific bytecode-op
            // categories against the matching AST shape. Each
            // category that fires in the bytecode but lands fewer
            // AST nodes flags a parser site the dual-emit hasn't
            // wired. Categories track the high-value shapes:
            // calls (Jsr/JsrExt/Jsri/TailExt), conditional
            // branches (Bz/Bnz), unconditional jumps (Jmp), array
            // indexing (Brak), struct memcpy (Mcpy), intrinsics
            // (Intrinsic). The bytecode side is the upper bound;
            // the AST side is the lower bound; the delta is the
            // silent drop.
            use super::super::ast::Expr;
            use super::super::op::Op;
            let bc_calls = self.count_ops_in_region(
                &[Op::Jsr, Op::JsrExt, Op::Jsri, Op::TailExt],
                func.ent_pc,
                bytecode_end,
            );
            let ast_calls = self.count_ast_exprs(&func, |e| matches!(e, Expr::Call { .. }));
            let bc_branches =
                self.count_ops_in_region(&[Op::Bz, Op::Bnz], func.ent_pc, bytecode_end);
            // AST shapes for branches cover both statement-level
            // (If/While/DoWhile/For/Switch) and expression-level
            // (Ternary, the short-circuit && / || lowered to a
            // Ternary or a sequence) -- count Ternary as the
            // expr-side proxy until those statements land.
            let ast_branches = func
                .ast
                .stmts
                .iter()
                .filter(|s| {
                    use super::super::ast::Stmt;
                    matches!(
                        s,
                        Stmt::If { .. }
                            | Stmt::While { .. }
                            | Stmt::DoWhile { .. }
                            | Stmt::For { .. }
                            | Stmt::Switch { .. }
                    )
                })
                .count()
                + self.count_ast_exprs(&func, |e| {
                    matches!(e, Expr::Ternary { .. } | Expr::ShortCircuit { .. },)
                });
            let bc_mcpy = self.count_op_in_region(Op::Mcpy, func.ent_pc, bytecode_end);
            let bc_intrinsic = self.count_op_in_region(Op::Intrinsic, func.ent_pc, bytecode_end);
            let ast_intrinsic =
                self.count_ast_exprs(&func, |e| matches!(e, Expr::Intrinsic { .. }));
            // Only emit a diff line when at least one category
            // has a non-zero gap -- silent successes don't need
            // to clutter the log.
            let gap_call = bc_calls.saturating_sub(ast_calls);
            let gap_branch = bc_branches.saturating_sub(ast_branches);
            let gap_mcpy = bc_mcpy;
            let gap_intrinsic = bc_intrinsic.saturating_sub(ast_intrinsic);
            let any_gap = gap_call + gap_branch + gap_mcpy + gap_intrinsic > 0;
            if any_gap {
                self.warnings.push(alloc::format!(
                    "ast::walk: function `{}` (ent_pc={}) drops call={} branch={} mcpy={} intrinsic={}",
                    func.name,
                    func.ent_pc,
                    gap_call,
                    gap_branch,
                    gap_mcpy,
                    gap_intrinsic,
                ));
            }
            let walker_res = super::super::ast::walk::walk_function(
                &func.ast,
                &self.symbols,
                &self.structs,
                target,
                func.ent_pc,
                func.n_params,
                func.is_variadic,
                func.n_locals,
                &func.param_tys,
                &func.param_local_slots,
                func.returns_struct,
                func.return_struct_size,
                func.alloca_top_slot,
            );
            match walker_res {
                Err(e) => {
                    self.warnings.push(alloc::format!(
                        "ast::walk: function `{}` (ent_pc={}): {}",
                        func.name,
                        func.ent_pc,
                        e,
                    ));
                }
                Ok(walker_fn) => {
                    // Shadow compare: lift the same bytecode
                    // region and diff per-category instruction
                    // counts. Categories that systematically
                    // differ (vstack/acc spill/reload -- lift
                    // bridges stack-machine state with these;
                    // walker doesn't) are excluded so only
                    // meaningful divergences land in the
                    // warning stream.
                    let lift = super::super::codegen::ssa_shadow::lift_single(
                        &self.text,
                        func.ent_pc,
                        bytecode_end,
                        func.n_params,
                        func.is_variadic,
                        &self.data_imm_positions,
                        &self.code_imm_positions,
                        &self.call_fp_arg_masks,
                    );
                    if let Ok(lift_fn) = lift {
                        let wc = super::super::codegen::ssa_shadow::count_insts(&walker_fn);
                        let lc = super::super::codegen::ssa_shadow::count_insts(&lift_fn);
                        let mut diffs: alloc::vec::Vec<alloc::string::String> =
                            alloc::vec::Vec::new();
                        macro_rules! diff {
                            ($cat:ident) => {
                                if wc.$cat != lc.$cat {
                                    diffs.push(alloc::format!(
                                        "{}={}/{}",
                                        stringify!($cat),
                                        wc.$cat,
                                        lc.$cat
                                    ));
                                }
                            };
                        }
                        diff!(imm);
                        diff!(local_addr);
                        diff!(load);
                        diff!(store);
                        diff!(load_local);
                        diff!(store_local);
                        diff!(binop);
                        diff!(binop_imm);
                        diff!(call);
                        diff!(call_ext);
                        diff!(call_indirect);
                        diff!(mcpy);
                        diff!(intrinsic);
                        if !diffs.is_empty() {
                            self.warnings.push(alloc::format!(
                                "ast::walk: function `{}` (ent_pc={}) shadow diff walker/lift: {}",
                                func.name,
                                func.ent_pc,
                                diffs.join(" "),
                            ));
                        }
                    }
                }
            }
        }
    }

    /// Current source position. Mirrors the bytecode tier's
    /// `source_lines` / `intern_source_file` columns so every AST
    /// node carries the line / file the matching Op::* would have
    /// gotten.
    pub(super) fn ast_src_pos(&mut self) -> SrcPos {
        let file = self.intern_source_file();
        SrcPos {
            line: self.lex.line as u32,
            file,
        }
    }

    /// Push an integer-literal expression and stash it in
    /// `ast_acc`. Pairs with the bytecode tier's
    /// `emit_imm(self.lex.ival)` at the integer-literal /
    /// enum-constant / `Token::Num`-class identifier sites.
    pub(super) fn ast_emit_int_lit(&mut self, val: i64, ty: i64) -> ExprId {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::IntLit { val, ty }, pos);
        self.ast_acc = Some(id);
        id
    }

    /// Push a floating-point-literal expression. The lexer already
    /// stored `f64::to_bits()` cast to `i64` in `lex.ival`; the AST
    /// keeps the bit pattern in a `u64` so it round-trips through
    /// the walker without re-casting.
    pub(super) fn ast_emit_float_lit(&mut self, bits: u64, ty: i64) -> ExprId {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::FloatLit { bits, ty }, pos);
        self.ast_acc = Some(id);
        id
    }

    /// Push a string literal. C99 6.4.5p6: the literal has type
    /// `char[N+1]` (NUL terminator included); in any expression
    /// context outside `sizeof` it decays to `char *` per
    /// 6.3.2.1p3. `data_off` is the byte offset where the
    /// literal lives in the program's data segment. `ty` is the
    /// post-decay `char *` so the walker emits the matching
    /// `imm_data` without a trailing load (same shape arrays
    /// follow).
    pub(super) fn ast_emit_str_lit(&mut self, data_off: i64, ty: i64) -> ExprId {
        let pos = self.ast_src_pos();
        let id = self
            .ast
            .push_expr(Expr::StrLit { data_off, ty }, pos);
        self.ast_acc = Some(id);
        id
    }

    /// Push an identifier reference. The bytecode emits a
    /// `Lea / data-Imm` address producer followed by a scalar
    /// load; the AST collapses that into a single `Expr::Ident`
    /// whose `sym` indexes the symbol table and whose `ty` matches
    /// what the load would have left in `self.ty`. The address-of
    /// (`&x`) and assignment (`x = ...`) paths look up the same
    /// `Ident` node and switch lvalue / rvalue interpretation at
    /// the surrounding parent node -- C99 6.3.2.1 lvalue-to-rvalue
    /// conversion is implicit in the AST shape.
    pub(super) fn ast_emit_ident(&mut self, sym: u32, ty: i64) -> ExprId {
        let pos = self.ast_src_pos();
        let s = &self.symbols[sym as usize];
        let class = s.class;
        let val = s.val;
        let is_thread_local = s.is_thread_local;
        let array_size = s.array_size;
        let id = self.ast.push_expr(
            Expr::Ident {
                sym,
                ty,
                class,
                val,
                is_thread_local,
                array_size,
            },
            pos,
        );
        self.ast_acc = Some(id);
        id
    }

    /// Push an `Expr::PreInc` node and set it as the new
    /// `ast_acc`. The bytecode tier emits the six-op increment
    /// sequence (rewrite + reload + Psh + Imm step + Add/Sub +
    /// store_op) before this call lands; the AST collapses the
    /// shape into one node whose `lvalue` is the just-popped
    /// vstack entry. `by` is the step value the parser already
    /// scaled for pointers (+sizeof(*p) / -sizeof(*p)) so the
    /// walker doesn't have to recompute it.
    pub(super) fn ast_emit_pre_inc(&mut self, lvalue: ExprId, by: i64, ty: i64) {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::PreInc { lvalue, by, ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Push `Expr::PostInc { lvalue, by, ty }`. Same shape as
    /// PreInc; the walker captures the pre-update value as the
    /// expression's result per C99 6.5.2.4p3.
    pub(super) fn ast_emit_post_inc(&mut self, lvalue: ExprId, by: i64, ty: i64) {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::PostInc { lvalue, by, ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Push `Expr::Cast { child, to_ty }`. Called from the C-style
    /// cast site once `(type)expr` finishes parsing; the bytecode
    /// tier's conversion ops (Fcvtif / Fcvtfi / Shl / Shr / And)
    /// already left intermediate Binary nodes on `ast_acc`. The
    /// Cast overwrites those with a single canonical node whose
    /// `child` is the pre-cast expression captured by the caller.
    pub(super) fn ast_emit_cast(&mut self, child: ExprId, to_ty: i64) {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::Cast { child, to_ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Wrap the current `ast_acc` in an `Expr::Cast { to_ty }`.
    /// Used by `convert_assign_rhs` and other implicit-conversion
    /// sites where the bytecode tier already emitted the FP
    /// conversion op (`Fcvtif` / `Fcvtfi`) and the AST needs the
    /// matching `Expr::Cast` so the walker emits the right
    /// `Inst::FpCast`. No-op when the accumulator is empty (the
    /// child expression hadn't been wired by the dual-emit yet).
    pub(super) fn ast_apply_assign_conv(&mut self, to_ty: i64) {
        let Some(child) = self.ast_acc.take() else {
            return;
        };
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::Cast { child, to_ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Push `Expr::Member { obj, field_off, bitfield, ty }`.
    /// `obj` is the address-producing expression (struct value or
    /// pointer); `field_off` is the byte offset within the struct;
    /// `bitfield` is `Some` only for bitfields. The walker treats
    /// the node as an lvalue producer + load combination.
    pub(super) fn ast_emit_member(
        &mut self,
        obj: ExprId,
        field_off: i64,
        bitfield: Option<super::super::ast::BitfieldDesc>,
        ty: i64,
        array_size: i64,
    ) {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Member {
                obj,
                field_off,
                bitfield,
                ty,
                array_size,
            },
            pos,
        );
        self.ast_acc = Some(id);
    }

    /// Push `Expr::BitfieldAssign`. The parser invokes this from
    /// the bitfield-write branch of `emit_bitfield_access`, after
    /// the RHS has been parsed (so the rhs `ExprId` is in
    /// `ast_acc`). `obj` is the address producer for the
    /// containing struct; `field_off` + `bitfield` describe the
    /// destination slice; the walker re-emits the matching
    /// load-clear-shift-or-store sequence.
    pub(super) fn ast_emit_bitfield_assign(
        &mut self,
        obj: ExprId,
        field_off: i64,
        bitfield: super::super::ast::BitfieldDesc,
        rhs: ExprId,
        ty: i64,
    ) {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::BitfieldAssign {
                obj,
                field_off,
                bitfield,
                rhs,
                ty,
            },
            pos,
        );
        self.ast_acc = Some(id);
    }

    /// Push `Expr::Index { array, idx, ty }`. `array` is the
    /// pointer / array-decayed-pointer; `idx` is the post-scale
    /// index expression. Same shape the walker uses for indexed
    /// loads.
    pub(super) fn ast_emit_index(&mut self, array: ExprId, idx: ExprId, ty: i64) {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::Index { array, idx, ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Push `Expr::CompoundAssign { op, lhs, rhs, ty }`. C99
    /// 6.5.16.2p3: `E1 op= E2` is `E1 = E1 op E2` with E1
    /// evaluated once; the walker spills the lhs address, loads
    /// it, applies the binop with rhs, and stores back.
    pub(super) fn ast_emit_compound_assign(
        &mut self,
        op: super::super::ir::BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) {
        let pos = self.ast_src_pos();
        let id = self
            .ast
            .push_expr(Expr::CompoundAssign { op, lhs, rhs, ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Push `Expr::ShortCircuit { op, lhs, rhs, ty }`. C99
    /// 6.5.13 / 6.5.14: `&&` and `||` short-circuit -- rhs is
    /// evaluated only when lhs hasn't already decided the
    /// result. The walker emits the matching branch / per-arm
    /// spill / after-block reload pattern.
    pub(super) fn ast_emit_short_circuit(
        &mut self,
        op: super::super::ast::ShortCircuitOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    ) {
        let pos = self.ast_src_pos();
        let id = self
            .ast
            .push_expr(Expr::ShortCircuit { op, lhs, rhs, ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Push `Decl::StaticLocal { sym }` + `Stmt::Decl` wrapper.
    /// Used at the block-scope `static T name = ...;` site; the
    /// storage + init reach the data segment through the c5
    /// global path, not the function body, so the walker has no
    /// per-decl work. Pushing the AST node keeps the dual-emit
    /// surface complete for the eventual flip.
    pub(super) fn ast_emit_static_local_decl(&mut self, sym: u32) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        let decl_id = self
            .ast
            .push_decl(super::super::ast::Decl::StaticLocal { sym }, pos);
        self.ast
            .push_stmt(super::super::ast::Stmt::Decl(decl_id), pos)
    }

    /// Push `Decl::Local { sym, slot_off, init }` and a wrapping
    /// `Stmt::Decl(decl_id)` so the enclosing block's stmt-range
    /// wrapper picks the declaration up alongside ordinary stmts.
    /// `init` distinguishes scalar / aggregate / no-init shapes;
    /// the walker maps each to the matching SSA instruction.
    pub(super) fn ast_emit_local_decl(
        &mut self,
        sym: u32,
        slot_off: i64,
        init: super::super::ast::LocalInit,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        let ty = self.symbols[sym as usize].type_;
        let decl_id = self.ast.push_decl(
            super::super::ast::Decl::Local {
                sym,
                ty,
                slot_off,
                init,
            },
            pos,
        );
        self.ast
            .push_stmt(super::super::ast::Stmt::Decl(decl_id), pos)
    }

    /// Push an `Expr::Call` and set it as the new accumulator.
    /// Called by the function-call parser site after the bytecode
    /// dance (per-arg temp store + reverse push + Jsr/JsrExt/Jsri
    /// + Adj cleanup) lands. `callee` is the callee's AST
    /// expression (synthesised here for direct calls via
    /// `ast.push_expr(Ident { ... })`; the indirect-call path
    /// passes the already-built function-pointer ExprId). `args`
    /// holds each declared argument's ExprId in source order;
    /// `None` slots mean the argument's AST wasn't captured.
    /// If any slot is `None` the helper drops the Call build and
    /// resets `ast_acc` to `None` -- the walker would otherwise
    /// emit an incomplete call.
    pub(super) fn ast_emit_call(
        &mut self,
        callee: ExprId,
        args: alloc::vec::Vec<Option<ExprId>>,
        ty: i64,
    ) {
        let mut resolved: alloc::vec::Vec<ExprId> = alloc::vec::Vec::with_capacity(args.len());
        for a in args {
            match a {
                Some(id) => resolved.push(id),
                None => {
                    self.ast_acc = None;
                    return;
                }
            }
        }
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Call {
                callee,
                args: resolved,
                ty,
            },
            pos,
        );
        self.ast_acc = Some(id);
    }

    /// Synthesise an `Expr::Ident` for a direct-call callee. The
    /// parser's call site looks up `id_idx` (a symbol-table index
    /// for a `Token::Fun` / `Token::Sys` symbol); the AST needs
    /// a matching Ident node so [`Self::ast_emit_call`] can fill
    /// the `callee` field without re-running symbol resolution.
    pub(super) fn ast_synthesize_callee(&mut self, sym: u32, ty: i64) -> ExprId {
        let pos = self.ast_src_pos();
        let s = &self.symbols[sym as usize];
        let class = s.class;
        let val = s.val;
        let is_thread_local = s.is_thread_local;
        let array_size = s.array_size;
        self.ast.push_expr(
            Expr::Ident {
                sym,
                ty,
                class,
                val,
                is_thread_local,
                array_size,
            },
            pos,
        )
    }

    /// Snapshot the current `ast.stmts` length. Used by the
    /// control-flow parser sites to bracket the stmt-range a
    /// sub-statement parse contributes, so the outer stmt can
    /// reference it by id without double-walking.
    pub(super) fn ast_stmts_snapshot(&self) -> usize {
        self.ast.stmts.len()
    }

    /// Return the body `StmtId` produced by a single
    /// `self.stmt()` call that pushed at least one statement
    /// since `before`. C99 6.8 statements form a tree, and the
    /// canonical top-level statement parsed by an inner
    /// `self.stmt()` is the LAST arena entry: any earlier
    /// entries are sub-statements that the last one already
    /// references (e.g. an inner `if`'s then-body is a
    /// `Stmt::Expr` pushed just before the `Stmt::If` that
    /// embeds it). Returning the last id avoids building a fresh
    /// outer `Stmt::Compound` that would re-list the
    /// already-referenced sub-stmts and cause the walker to
    /// double-visit them. For empty statements (`;`) the helper
    /// synthesises an empty `Stmt::Compound` so the caller has a
    /// valid id to bind.
    pub(super) fn ast_wrap_stmts_since(&mut self, before: usize) -> super::super::ast::StmtId {
        let after = self.ast.stmts.len();
        if after > before {
            return (after - 1) as super::super::ast::StmtId;
        }
        let pos = self.ast_src_pos();
        self.ast.push_stmt(
            super::super::ast::Stmt::Compound(alloc::vec::Vec::new()),
            pos,
        )
    }

    /// Wrap an explicit set of top-level stmt ids into a
    /// `Stmt::Compound`. Unlike `ast_wrap_stmts_since`, the
    /// caller hand-curates the list -- nested compounds get one
    /// entry per source-level statement, not one per pushed-into-
    /// arena stmt, so the walker visits each source stmt once.
    /// `parse_block_stmt` and the function-body parse loop use
    /// this to avoid double-walking inner-wrapped stmts.
    pub(super) fn ast_wrap_block_items(
        &mut self,
        item_ids: &[super::super::ast::StmtId],
    ) -> super::super::ast::StmtId {
        if item_ids.len() == 1 {
            return item_ids[0];
        }
        let items: alloc::vec::Vec<super::super::ast::BlockItem> = item_ids
            .iter()
            .map(|&id| super::super::ast::BlockItem::Stmt(id))
            .collect();
        let pos = self.ast_src_pos();
        self.ast
            .push_stmt(super::super::ast::Stmt::Compound(items), pos)
    }

    /// Push `Stmt::If { cond, then_s, else_s }`.
    pub(super) fn ast_emit_if(
        &mut self,
        cond: super::super::ast::ExprId,
        then_s: super::super::ast::StmtId,
        else_s: Option<super::super::ast::StmtId>,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast.push_stmt(
            super::super::ast::Stmt::If {
                cond,
                then_s,
                else_s,
            },
            pos,
        )
    }

    /// Push `Stmt::While { cond, body }`.
    pub(super) fn ast_emit_while(
        &mut self,
        cond: super::super::ast::ExprId,
        body: super::super::ast::StmtId,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast
            .push_stmt(super::super::ast::Stmt::While { cond, body }, pos)
    }

    /// Push `Stmt::DoWhile { body, cond }`.
    pub(super) fn ast_emit_do_while(
        &mut self,
        body: super::super::ast::StmtId,
        cond: super::super::ast::ExprId,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast
            .push_stmt(super::super::ast::Stmt::DoWhile { body, cond }, pos)
    }

    /// Push `Stmt::For { init, cond, post, body }`.
    pub(super) fn ast_emit_for(
        &mut self,
        init: Option<super::super::ast::BlockItem>,
        cond: Option<super::super::ast::ExprId>,
        post: Option<super::super::ast::ExprId>,
        body: super::super::ast::StmtId,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast.push_stmt(
            super::super::ast::Stmt::For {
                init,
                cond,
                post,
                body,
            },
            pos,
        )
    }

    /// Push a `Stmt::Expr` wrapping the current `ast_acc`. C99
    /// 6.8.3: expression statement evaluates the expression for
    /// side effects and discards the value. Returns `None` and
    /// pushes nothing when `ast_acc` is `None` -- the parser
    /// hasn't dual-emitted that expression shape yet, so binding
    /// a `Stmt::Expr` to a stale id would mis-walk.
    pub(super) fn ast_emit_expr_stmt(&mut self) -> Option<super::super::ast::StmtId> {
        let e = self.ast_acc?;
        let pos = self.ast_src_pos();
        let id = self
            .ast
            .push_stmt(super::super::ast::Stmt::Expr(e), pos);
        self.ast_acc = None;
        Some(id)
    }

    /// Push `Stmt::Break`.
    pub(super) fn ast_emit_break(&mut self) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast.push_stmt(super::super::ast::Stmt::Break, pos)
    }

    /// Push `Stmt::Continue`.
    pub(super) fn ast_emit_continue(&mut self) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast.push_stmt(super::super::ast::Stmt::Continue, pos)
    }

    /// Push a `Stmt::Goto`. `label` is the AST-side label id;
    /// the AST table tracks pending fixups so `goto L` before
    /// `L:` is parsed still resolves at function-end.
    pub(super) fn ast_emit_goto(
        &mut self,
        label: super::super::ast::LabelId,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast
            .push_stmt(super::super::ast::Stmt::Goto(label), pos)
    }

    /// Push a `Stmt::Labeled` wrapping the just-parsed body.
    pub(super) fn ast_emit_labeled(
        &mut self,
        label: super::super::ast::LabelId,
        body: super::super::ast::StmtId,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast.resolve_label(label, body);
        self.ast
            .push_stmt(super::super::ast::Stmt::Labeled { label, body }, pos)
    }

    /// Push a `Stmt::Switch { disc, body }`.
    pub(super) fn ast_emit_switch(
        &mut self,
        disc: super::super::ast::ExprId,
        body: super::super::ast::StmtId,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast
            .push_stmt(super::super::ast::Stmt::Switch { disc, body }, pos)
    }

    /// Push a `Stmt::Case { val, body }`.
    pub(super) fn ast_emit_case(
        &mut self,
        val: i64,
        body: super::super::ast::StmtId,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast
            .push_stmt(super::super::ast::Stmt::Case { val, body }, pos)
    }

    /// Push a `Stmt::Default { body }`.
    pub(super) fn ast_emit_default(
        &mut self,
        body: super::super::ast::StmtId,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        self.ast
            .push_stmt(super::super::ast::Stmt::Default { body }, pos)
    }

    /// Allocate a fresh AST label slot. The bytecode tier tracks
    /// goto fixups by name in `self.labels` / `self.unresolved_gotos`;
    /// the AST mirror keeps a flat per-function id space tied back
    /// through `Compiler::ast_label_by_name` so both sides see the
    /// same label.
    pub(super) fn ast_label_by_name(&mut self, name: &str) -> super::super::ast::LabelId {
        for (lname, lid) in &self.ast_labels {
            if lname == name {
                return *lid;
            }
        }
        let id = self.ast.alloc_label();
        self.ast_labels
            .push((alloc::string::String::from(name), id));
        id
    }

    /// Push a `Stmt::Return(value)` node into the per-function
    /// AST. Called from the explicit-return statement parser
    /// site (stmt.rs) right before the bytecode `Op::Lev`. The
    /// `value` is `Some(ast_acc)` when the source spelled out a
    /// value and `None` for a bare `return;` in a void function;
    /// caller decides by passing the right shape. The Stmt's id
    /// is returned in case a future parent (a labelled stmt, a
    /// surrounding compound block) wants to chain it.
    pub(super) fn ast_emit_return(
        &mut self,
        value: Option<super::super::ast::ExprId>,
    ) -> super::super::ast::StmtId {
        let pos = self.ast_src_pos();
        let id = self
            .ast
            .push_stmt(super::super::ast::Stmt::Return(value), pos);
        // C99 6.8.6.4: a return statement has no value as an
        // expression; clear `ast_acc` so a stray surrounding op
        // doesn't pair the function's last value with whatever
        // emits next.
        self.ast_acc = None;
        self.ast_vstack.clear();
        id
    }

    /// AST-side reaction to an emit_op of an operand-free op.
    /// `Op::Psh` records the current accumulator on the parser-
    /// side vstack; binops pop the saved lhs from the vstack,
    /// pair it with the accumulator's rhs ExprId, and replace
    /// the accumulator with the resulting `Expr::Binary`; the
    /// unary `Op::Fneg` rewraps the accumulator with
    /// `Expr::Unary { op: Neg }`.
    ///
    /// Ops outside this set are left alone -- their AST shape
    /// flows through the operand-aware helpers (`emit_imm`,
    /// `emit_lea`, ...) or through the statement-level parser
    /// sites that own control-flow shapes.
    ///
    /// During Phase C2 the AST is shadow data; if an emit_op
    /// fires before a wired-up operand-aware site has populated
    /// `ast_acc`, the binop drops the AST node and leaves the
    /// vstack in sync with whatever the next wired site
    /// produces. The validator (Phase C4) flags the gap.
    pub(super) fn ast_track_emit_op(&mut self, op: Op) {
        use super::super::ir::BinOp as B;
        match op {
            Op::Psh => {
                // Always push a slot so the parser-side vstack
                // depth stays in lockstep with the c5
                // stack-machine vstack. When `ast_acc` is None
                // (an op-aware parser site pushed an address
                // through `Op::Lea` / `emit_data_imm` without
                // wiring its AST counterpart), the slot holds
                // `None` and downstream pops know to skip the
                // node build.
                self.ast_vstack.push(self.ast_acc.take());
            }
            Op::Fneg => self.ast_apply_unary(super::super::ast::UnOp::Neg),
            // Integer arithmetic + comparison. Each case maps the
            // bytecode op to the matching `ir::BinOp`; the AST
            // walker uses the same enum.
            Op::Add => self.ast_apply_binop(B::Add),
            Op::Sub => self.ast_apply_binop(B::Sub),
            Op::Mul => self.ast_apply_binop(B::Mul),
            Op::Div => self.ast_apply_binop(B::Div),
            Op::Mod => self.ast_apply_binop(B::Mod),
            Op::Divu => self.ast_apply_binop(B::Divu),
            Op::Modu => self.ast_apply_binop(B::Modu),
            Op::Or => self.ast_apply_binop(B::Or),
            Op::Xor => self.ast_apply_binop(B::Xor),
            Op::And => self.ast_apply_binop(B::And),
            Op::Shl => self.ast_apply_binop(B::Shl),
            Op::Shr => self.ast_apply_binop(B::Shr),
            Op::Shru => self.ast_apply_binop(B::Shru),
            Op::Eq => self.ast_apply_binop(B::Eq),
            Op::Ne => self.ast_apply_binop(B::Ne),
            Op::Lt => self.ast_apply_binop(B::Lt),
            Op::Gt => self.ast_apply_binop(B::Gt),
            Op::Le => self.ast_apply_binop(B::Le),
            Op::Ge => self.ast_apply_binop(B::Ge),
            Op::Ult => self.ast_apply_binop(B::Ult),
            Op::Ugt => self.ast_apply_binop(B::Ugt),
            Op::Ule => self.ast_apply_binop(B::Ule),
            Op::Uge => self.ast_apply_binop(B::Uge),
            // Floating-point arithmetic + comparison. Same shape;
            // the BinOp tag drives the walker's add-vs-fadd pick.
            Op::Fadd => self.ast_apply_binop(B::Fadd),
            Op::Fsub => self.ast_apply_binop(B::Fsub),
            Op::Fmul => self.ast_apply_binop(B::Fmul),
            Op::Fdiv => self.ast_apply_binop(B::Fdiv),
            Op::Feq => self.ast_apply_binop(B::Feq),
            Op::Fne => self.ast_apply_binop(B::Fne),
            Op::Flt => self.ast_apply_binop(B::Flt),
            Op::Fgt => self.ast_apply_binop(B::Fgt),
            Op::Fle => self.ast_apply_binop(B::Fle),
            Op::Fge => self.ast_apply_binop(B::Fge),
            // Scalar stores: vstack-top holds the lvalue address
            // producer (set by `rewrite_trailing_load_as_psh` from
            // the lhs Ident / Deref / Member / Index node); the
            // accumulator holds the rhs value. Pair them into
            // `Expr::Assign` and leave the result in the
            // accumulator -- C99 6.5.16p3 says an assignment
            // expression evaluates to the value stored.
            Op::Si | Op::Sc | Op::Sh | Op::Sw | Op::Sf => self.ast_apply_assign(),
            // Call ops destroy the c5 accumulator (the call
            // overwrites it with the callee's return value). The
            // dual-emit doesn't yet build `Expr::Call` AST nodes,
            // so clear `ast_acc` here to keep stale data from a
            // previous statement's Assign / Binary from polluting
            // the next store / push. Same for the indirect call
            // op and the Sys-binding external call. Adj is the
            // post-call stack cleanup; it has no acc effect on
            // either side.
            Op::Jsr | Op::JsrExt | Op::Jsri => {
                self.ast_acc = None;
            }
            _ => {}
        }
    }

    /// Helper for the [`Self::ast_track_emit_op`] binop arm: pops
    /// the lhs from the parser-side vstack, takes the rhs from
    /// the accumulator, pushes a new `Expr::Binary`, and replaces
    /// the accumulator with its ExprId. Result `ty` is whatever
    /// `self.ty` currently holds -- the parser pre-computed the
    /// usual-arithmetic-conversion result type immediately before
    /// the emit. Drops the node if either operand is missing
    /// (the surrounding emit site isn't AST-wired yet).
    fn ast_apply_binop(&mut self, op: super::super::ir::BinOp) {
        let rhs_slot = self.ast_acc.take();
        let lhs_slot = self.ast_vstack.pop().flatten();
        let (Some(lhs), Some(rhs)) = (lhs_slot, rhs_slot) else {
            // One side wasn't AST-wired; can't build the node.
            // Drop the AST acc so a downstream consumer doesn't
            // pair a stale value with the next op.
            return;
        };
        let pos = self.ast_src_pos();
        let ty = self.ty;
        let id = self
            .ast
            .push_expr(super::super::ast::Expr::Binary { op, lhs, rhs, ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Helper for the unary arms: wraps the accumulator with the
    /// given `UnOp` and replaces it. Drops the node if the
    /// accumulator is empty (the operand wasn't AST-wired yet).
    fn ast_apply_unary(&mut self, op: super::super::ast::UnOp) {
        let Some(child) = self.ast_acc.take() else {
            return;
        };
        let pos = self.ast_src_pos();
        let ty = self.ty;
        let id = self
            .ast
            .push_expr(super::super::ast::Expr::Unary { op, child, ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Helper for the scalar-store arms: pops the lvalue
    /// (address-producing expression) from the parser-side
    /// vstack, takes the rhs from the accumulator, and pushes an
    /// `Expr::Assign` whose id becomes the new accumulator. The
    /// `ty` is the rhs's type -- the C99 6.5.16 value of the
    /// assignment is the value stored, after any conversion the
    /// surrounding code already applied. Drops the node if either
    /// operand is missing (the surrounding store site emits Si in
    /// a non-canonical shape -- bitfield write, aggregate copy --
    /// that the dedicated AST helpers haven't wired yet).
    fn ast_apply_assign(&mut self) {
        let rhs_slot = self.ast_acc.take();
        let lhs_slot = self.ast_vstack.pop().flatten();
        let (Some(lhs), Some(rhs)) = (lhs_slot, rhs_slot) else {
            return;
        };
        let pos = self.ast_src_pos();
        let ty = self.ty;
        let id = self
            .ast
            .push_expr(super::super::ast::Expr::Assign { lhs, rhs, ty }, pos);
        self.ast_acc = Some(id);
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ast::Expr;
    use super::super::Compiler;

    /// Compile `int main(void) { return 7; }` and confirm the
    /// dual-emit captured exactly one finished function whose AST
    /// contains an `IntLit { val: 7 }`. Locks the integer-literal
    /// wiring + the function-end snapshot hook.
    #[test]
    fn int_main_return_7_captures_int_lit() {
        // Bare `int main(void)` source: no headers, no #pragma. The
        // parser still produces a complete function and trips the
        // dual-emit + finish hook even though there's no libc.
        let src = alloc::string::String::from("int main(void) { return 7; }\n");
        let program = Compiler::new(src).compile().expect("compile int main");
        assert_eq!(program.finished_functions.len(), 1);
        let ast = &program.finished_functions[0].ast;
        let lit_count = ast
            .exprs
            .iter()
            .filter(|e| matches!(e, Expr::IntLit { val: 7, .. }))
            .count();
        assert_eq!(
            lit_count, 1,
            "expected exactly one IntLit{{val:7}}, ast.exprs = {:?}",
            ast.exprs,
        );
    }

    /// `int main(void) { return 7 + 3 * 2; }` -- the parser emits
    /// `Imm 7; Psh; Imm 3; Psh; Imm 2; Mul; [mask]; Add; [mask]`.
    /// `[mask]` is the C99 6.3.1.8 signed-int width truncation
    /// pair `Psh; Imm 32; Shl; Psh; Imm 32; Shr` the parser drops
    /// after every signed arithmetic op. Confirm the AST captures:
    ///   * three source-level IntLits (7, 3, 2) in source order,
    ///   * a `Binary{Mul, IntLit(3), IntLit(2)}` for the inner `*`,
    ///   * a `Binary{Add, IntLit(7), <masked-Mul-result>}` for the
    ///     outer `+`,
    /// and that the parser-side vstack didn't drift across the
    /// intervening mask sequences.
    #[test]
    fn binop_three_operand_capture() {
        use super::super::super::ast::Expr;
        use super::super::super::ir::BinOp;

        let src = alloc::string::String::from("int main(void) { return 7 + 3 * 2; }\n");
        let program = Compiler::new(src).compile().expect("compile");
        assert_eq!(program.finished_functions.len(), 1);
        let ast = &program.finished_functions[0].ast;

        let source_lits: alloc::vec::Vec<i64> = ast
            .exprs
            .iter()
            .filter_map(|e| match e {
                Expr::IntLit { val, .. } if *val != 32 => Some(*val),
                _ => None,
            })
            .collect();
        assert_eq!(
            source_lits,
            alloc::vec![7i64, 3, 2],
            "source int literals not captured in order: {:?}",
            ast.exprs,
        );

        let mul = ast
            .exprs
            .iter()
            .find(|e| matches!(e, Expr::Binary { op: BinOp::Mul, .. }))
            .expect("Mul node missing");
        if let Expr::Binary { lhs, rhs, .. } = mul {
            match (&ast.exprs[*lhs as usize], &ast.exprs[*rhs as usize]) {
                (Expr::IntLit { val: 3, .. }, Expr::IntLit { val: 2, .. }) => {}
                other => panic!("Mul children not (3, 2): {other:?}"),
            }
        }

        let add = ast
            .exprs
            .iter()
            .find(|e| matches!(e, Expr::Binary { op: BinOp::Add, .. }))
            .expect("Add node missing");
        if let Expr::Binary { lhs, rhs, .. } = add {
            assert!(
                matches!(&ast.exprs[*lhs as usize], Expr::IntLit { val: 7, .. }),
                "Add lhs not IntLit(7): {:?}",
                ast.exprs[*lhs as usize],
            );
            // The Add rhs reaches the inner Mul through one or
            // more Shl/Shr masking binops -- chase the binop chain
            // and confirm the leaf is the Mul.
            let mut current = *rhs;
            for _ in 0..6 {
                match &ast.exprs[current as usize] {
                    Expr::Binary { op: BinOp::Mul, .. } => return,
                    Expr::Binary {
                        op: BinOp::Shl | BinOp::Shr,
                        lhs,
                        ..
                    } => current = *lhs,
                    other => panic!("unexpected node walking Add rhs: {other:?}"),
                }
            }
            panic!("did not reach Mul through Add rhs masking chain");
        }
    }

    /// `int callee(int x) { return x + 1; } int main(void) {
    /// return callee(5); }` -- the call site should land one
    /// `Expr::Call { callee: Ident(callee), args: [IntLit(5)] }`
    /// in main's AST.
    #[test]
    fn direct_call_captures_call_expr() {
        use super::super::super::ast::Expr;

        let src = alloc::string::String::from(
            "int callee(int x) { return x + 1; }\nint main(void) { return callee(5); }\n",
        );
        let program = Compiler::new(src).compile().expect("compile");
        // `main` is the second finished function.
        let ast = &program.finished_functions[1].ast;
        let calls: alloc::vec::Vec<&Expr> = ast
            .exprs
            .iter()
            .filter(|e| matches!(e, Expr::Call { .. }))
            .collect();
        assert_eq!(calls.len(), 1, "expected one Call expr, got {calls:?}");
        if let Expr::Call { callee, args, .. } = calls[0] {
            assert_eq!(args.len(), 1, "expected 1 arg in callee(5)");
            assert!(
                matches!(&ast.exprs[*callee as usize], Expr::Ident { .. }),
                "callee node not Ident: {:?}",
                ast.exprs[*callee as usize],
            );
            assert!(
                matches!(&ast.exprs[args[0] as usize], Expr::IntLit { val: 5, .. },),
                "arg not IntLit(5): {:?}",
                ast.exprs[args[0] as usize],
            );
        }
    }

    /// `int main(int a) { ++a; return a; }` -- the prefix `++`
    /// collapses into a single `Expr::PreInc{lvalue: Ident, by: 1}`.
    /// Confirms the bytecode's six-op increment dance leaves the
    /// AST with exactly one PreInc node.
    #[test]
    fn pre_inc_local_captures_pre_inc() {
        use super::super::super::ast::Expr;

        let src = alloc::string::String::from("int main(int a) { ++a; return a; }\n");
        let program = Compiler::new(src).compile().expect("compile");
        let ast = &program.finished_functions[0].ast;
        let pre_inc_count = ast
            .exprs
            .iter()
            .filter(|e| matches!(e, Expr::PreInc { by: 1, .. }))
            .count();
        assert_eq!(
            pre_inc_count, 1,
            "expected exactly one PreInc{{by:1}}, ast.exprs = {:?}",
            ast.exprs,
        );
    }

    /// The shadow-validator walks every captured AST. For shapes
    /// the dual-emit already wires (return-an-int-literal), the
    /// walker returns `Ok` and `self.warnings` stays clean of
    /// `ast::walk` lines.
    #[test]
    fn validator_clean_on_return_literal() {
        let src = alloc::string::String::from("int main(void) { return 5; }\n");
        let mut compiler = Compiler::new(src);
        // Run the validator path directly. `validate_finished_asts`
        // needs `finished_functions` populated, which only happens
        // after run_compile, so drive the whole compile + invoke
        // the validator explicitly (bypassing the env-var gate
        // that the test harness can't toggle reliably).
        compiler.run_compile().expect("run_compile");
        compiler.validate_finished_asts();
        // Filter to actual walker errors -- the per-function
        // coverage lines ("ast::walk: ... coverage X/Y bytecode
        // words = Z%") always land, but a wired-up function
        // shouldn't surface any `Unsupported`/`UnknownSymbolClass`
        // lines. The "ast::walk: ...: ast::walk: " double-prefix
        // shape distinguishes walker errors from coverage entries.
        let walker_errs: alloc::vec::Vec<&alloc::string::String> = compiler
            .warnings
            .iter()
            .filter(|w| w.contains("): ast::walk:"))
            .collect();
        assert!(
            walker_errs.is_empty(),
            "expected no walker errors, got {walker_errs:?}",
        );
    }

    /// `int main(void) { return 5; }` should land exactly one
    /// `Stmt::Return(Some(IntLit{5}))` in the function's AST.
    #[test]
    fn return_statement_captures_value() {
        use super::super::super::ast::{Expr, Stmt};

        let src = alloc::string::String::from("int main(void) { return 5; }\n");
        let program = Compiler::new(src).compile().expect("compile");
        let ast = &program.finished_functions[0].ast;
        let returns: alloc::vec::Vec<&Stmt> = ast
            .stmts
            .iter()
            .filter(|s| matches!(s, Stmt::Return(_)))
            .collect();
        assert_eq!(
            returns.len(),
            1,
            "expected one Return stmt, got {returns:?}"
        );
        if let Stmt::Return(Some(id)) = returns[0] {
            assert!(
                matches!(&ast.exprs[*id as usize], Expr::IntLit { val: 5, .. }),
                "Return value not IntLit(5): {:?}",
                ast.exprs[*id as usize],
            );
        } else {
            panic!("Return without value: {:?}", returns[0]);
        }
    }

    /// `int assign(int a) { int x; x = a; return x; }` -- a
    /// scalar assignment becomes `Expr::Assign{lhs=Ident(x),
    /// rhs=Ident(a)}` after `rewrite_trailing_load_as_psh`
    /// + a trailing Si. Confirms the lvalue ends up on the
    /// parser-side vstack and the store pairs it with the rhs
    /// accumulator value.
    #[test]
    fn assign_local_from_param() {
        use super::super::super::ast::Expr;

        let src = alloc::string::String::from(
            "int assign(int a) { int x; x = a; return x; }\nint main(void) { return assign(7); }\n",
        );
        let program = Compiler::new(src).compile().expect("compile");
        let ast = &program.finished_functions[0].ast;
        let assign = ast
            .exprs
            .iter()
            .find(|e| matches!(e, Expr::Assign { .. }))
            .expect("Assign node missing");
        if let Expr::Assign { lhs, rhs, .. } = assign {
            assert!(
                matches!(&ast.exprs[*lhs as usize], Expr::Ident { .. }),
                "Assign lhs not an Ident: {:?}",
                ast.exprs[*lhs as usize],
            );
            assert!(
                matches!(&ast.exprs[*rhs as usize], Expr::Ident { .. }),
                "Assign rhs not an Ident: {:?}",
                ast.exprs[*rhs as usize],
            );
        }
    }

    /// `int addr(int a) { int *p = &a; return *p; }` -- `&a`
    /// triggers `pop_trailing_scalar_load`, which drops the
    /// trailing Li and wraps the lvalue producer in
    /// `Expr::Unary{AddrOf, Ident}`. The result feeds the
    /// pointer initializer's assignment to `p`.
    #[test]
    fn address_of_local_wraps_ident() {
        use super::super::super::ast::{Expr, UnOp};

        let src = alloc::string::String::from(
            "int addr(int a) { int *p; p = &a; return a; }\nint main(void) { return addr(3); }\n",
        );
        let program = Compiler::new(src).compile().expect("compile");
        let ast = &program.finished_functions[0].ast;
        let addr_of = ast
            .exprs
            .iter()
            .find(|e| {
                matches!(
                    e,
                    Expr::Unary {
                        op: UnOp::AddrOf,
                        ..
                    }
                )
            })
            .expect("AddrOf node missing");
        if let Expr::Unary { child, .. } = addr_of {
            assert!(
                matches!(&ast.exprs[*child as usize], Expr::Ident { .. }),
                "AddrOf child not an Ident: {:?}",
                ast.exprs[*child as usize],
            );
        }
    }

    /// `int add(int a, int b) { return a + b; }` -- the bytecode
    /// emits `Lea 2; Li; Psh; Lea 3; Li; Add; [mask]` for the body.
    /// The dual-emit should land two distinct `Expr::Ident` nodes
    /// (one per parameter), with an outer `Binary{Add, Ident, Ident}`
    /// that reaches the rhs Ident through the post-Add width-mask
    /// chain.
    #[test]
    fn ident_load_captures_two_params() {
        use super::super::super::ast::Expr;
        use super::super::super::ir::BinOp;

        let src = alloc::string::String::from(
            "int add(int a, int b) { return a + b; }\nint main(void) { return add(1, 2); }\n",
        );
        let program = Compiler::new(src).compile().expect("compile");
        // Two finished functions: `add` then `main`. Identifier
        // captures are checked on `add`'s AST.
        assert_eq!(program.finished_functions.len(), 2);
        let ast = &program.finished_functions[0].ast;

        let idents: alloc::vec::Vec<u32> = ast
            .exprs
            .iter()
            .filter_map(|e| match e {
                Expr::Ident { sym, .. } => Some(*sym),
                _ => None,
            })
            .collect();
        assert_eq!(
            idents.len(),
            2,
            "expected exactly two Ident nodes, got {:?}",
            ast.exprs,
        );
        assert_ne!(
            idents[0], idents[1],
            "the two Ident nodes must reference distinct symbols",
        );

        let add = ast
            .exprs
            .iter()
            .find(|e| matches!(e, Expr::Binary { op: BinOp::Add, .. }))
            .expect("Add node missing");
        if let Expr::Binary { lhs, rhs, .. } = add {
            assert!(
                matches!(&ast.exprs[*lhs as usize], Expr::Ident { .. }),
                "Add lhs not an Ident: {:?}",
                ast.exprs[*lhs as usize],
            );
            let mut current = *rhs;
            for _ in 0..6 {
                match &ast.exprs[current as usize] {
                    Expr::Ident { .. } => return,
                    Expr::Binary {
                        op: BinOp::Shl | BinOp::Shr,
                        lhs,
                        ..
                    } => current = *lhs,
                    other => panic!("unexpected node walking Add rhs: {other:?}"),
                }
            }
            panic!("did not reach Ident through Add rhs masking chain");
        }
    }
}
