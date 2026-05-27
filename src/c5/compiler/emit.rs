//! Low-level emit primitives plus the small "rewrite the trailing
//! op" helpers and the per-symbol shadow / restore pair.
//!
//! `emit_op` is the surviving tag-only helper. It updates the
//! trailing-op state (`last_imm_was_zero`, `trailing_scalar_load`,
//! `last_emit_was_indirect_call`, `fn_ptr_chain_depth`) so the
//! peek detectors (`last_emit_is_zero`, `pop_trailing_scalar_load`,
//! `rewrite_trailing_load_as_psh`) and the function-pointer
//! lineage tracker stay accurate. Identifier loads and unary `*`
//! re-seed `fn_ptr_chain_depth` inside `expr()`.
//!
//! The trailing-load rewriters implement the assignment / `&expr`
//! protocols by reading `trailing_scalar_load` and converting the
//! trailing rvalue load into a stack push or address producer.

use super::super::ast::{Expr, ExprId, SrcPos};
use super::super::error::C5Error;
use super::super::op::Op;
use super::super::symbol::Symbol;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::is_scalar_load_op_val;
use super::types::is_unsigned_ty;

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
        // Trailing scalar-load tracker. Scalar load ops
        // (`Op::Li` / `Op::Lc` / ...) set the flag; every other
        // op clears it.
        if is_scalar_load_op_val(op as i64) {
            self.pending.trailing_scalar_load = Some(op);
            // The identifier-rvalue path in expr.rs re-seeds
            // `last_loaded_local` after its own load emit; any
            // other scalar-load source (field, deref, index,
            // bitfield) leaves it cleared so a downstream pop /
            // rewrite does not retract `was_read` from a symbol
            // whose load is no longer trailing.
            self.pending.last_loaded_local = None;
        } else {
            self.pending.trailing_scalar_load = None;
        }
        // No caller routes Op::Jsri / Op::Adj through emit_op
        // any more (the indirect-call sites set the flag inline
        // via the call-site path); every op that reaches here
        // clears the flag.
        self.pending.last_emit_was_indirect_call = false;
        // Trailing `Imm 0` peek is set only by `emit_imm(0)`; any
        // other op clears it.
        self.pending.last_imm_was_zero = false;
        // AST hook -- ops whose shape is determined by `op` alone
        // (vstack push, arithmetic / comparison binops, unary
        // fneg, scalar stores, call-site Acc clobbers).
        self.ast_track_emit_op(op);
    }

    /// Push the parser-side AST accumulator onto the vstack.
    /// This method is the AST hook for what used to be an
    /// `emit_op(Op::Psh)` tag.
    pub(super) fn ast_psh(&mut self) {
        self.pending.fn_ptr_chain_depth = -1;
        self.pending.last_emit_was_indirect_call = false;
        self.pending.last_imm_was_zero = false;
        self.pending.trailing_scalar_load = None;
        self.ast_vstack.push(self.ast_acc.take());
    }

    /// Apply a binary operator to the parser-side vstack-top (lhs)
    /// + accumulator (rhs); the result lands in the accumulator.
    /// Callers pass `BinOp` directly; the helper handles the
    /// state-tracking flags every binop emit needs to clear.
    pub(super) fn ast_binop(&mut self, binop: super::super::ir::BinOp) {
        self.pending.fn_ptr_chain_depth = -1;
        self.pending.last_emit_was_indirect_call = false;
        self.pending.last_imm_was_zero = false;
        self.pending.trailing_scalar_load = None;
        self.ast_apply_binop(binop);
    }

    /// Apply unary `Op::Fneg` to the accumulator.
    pub(super) fn ast_fneg(&mut self) {
        self.pending.fn_ptr_chain_depth = -1;
        self.pending.last_emit_was_indirect_call = false;
        self.pending.last_imm_was_zero = false;
        self.pending.trailing_scalar_load = None;
        self.ast_apply_unary(super::super::ast::UnOp::Neg);
    }

    /// Tag-only state mgmt for an FP cast (`Op::Fcvtif` /
    /// `Op::Fcvtfi`). The AST counterpart is wired by the
    /// surrounding call site through `ast_apply_assign_conv` (for
    /// the assignment-conversion case) or skipped entirely (when
    /// the walker re-derives the conversion from the intrinsic /
    /// cast signature). Clears the parser-state flags so a
    /// trailing `Imm 0` / scalar-load shape doesn't leak across
    /// the conversion.
    pub(super) fn ast_fpcast(&mut self) {
        self.mark_emit_other();
    }

    /// Clear every trailing-emit flag a non-binop / non-load tag
    /// would clear. Replaces `emit_op(Op::Mcpy | StLocI | LdLocI
    /// | Lea | TlsLea | Intrinsic)` for sites that only need the
    /// flag bookkeeping and don't drive an AST hook.
    pub(super) fn mark_emit_other(&mut self) {
        self.pending.fn_ptr_chain_depth = -1;
        self.pending.last_emit_was_indirect_call = false;
        self.pending.last_imm_was_zero = false;
        self.pending.trailing_scalar_load = None;
    }

    /// Build an `Expr::Assign` from the vstack-top (lvalue
    /// address producer) + accumulator (rvalue), leaving the
    /// assigned value in the accumulator per C99 6.5.16p3.
    /// Replaces `emit_op(Op::Si | Sc | Sh | Sw | Sf)`.
    pub(super) fn ast_assign(&mut self) {
        self.pending.fn_ptr_chain_depth = -1;
        self.pending.last_emit_was_indirect_call = false;
        self.pending.last_imm_was_zero = false;
        self.pending.trailing_scalar_load = None;
        self.ast_apply_assign();
    }

    /// Clear the trailing-emit peek flags. Called by sizeof's
    /// parse-rollback site after the inner expression's tags get
    /// discarded so a downstream peek doesn't see leftover state.
    pub(super) fn clear_recent_emits(&mut self) {
        self.pending.last_imm_was_zero = false;
        self.pending.trailing_scalar_load = None;
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
        self.pending.fn_ptr_chain_depth = -1;
        self.pending.last_emit_was_indirect_call = false;
        self.pending.trailing_scalar_load = None;
        // Only literal-zero immediates set the peek flag; every
        // other Imm clears it.
        self.pending.last_imm_was_zero = val == 0;
        // Op::Imm carries no AST hook in `ast_track_emit_op`;
        // the per-site helper (`ast_emit_int_lit`,
        // `ast_emit_data_imm`, ...) owns the AST shape.
    }

    /// Address-of a stack slot (param positive, local negative)
    /// lands in the accumulator. Was `Op::Lea <slot_off>`; the
    /// operand word is no longer carried, only the trailing-op
    /// state cleared.
    pub(super) fn emit_lea(&mut self, _slot_off: i64) {
        self.mark_emit_other();
    }

    /// Emit `Psh; Imm <val>; <binop>` -- the three-step idiom for
    /// "apply `binop` to the accumulator with `val` as the right-
    /// hand operand". Consolidates the parser sites that emit
    /// pointer-arithmetic scaling, bitfield mask-and-shift,
    /// post/pre-increment step values, and the like.
    pub(super) fn emit_binop_with_imm(&mut self, binop: super::super::ir::BinOp, val: i64) {
        self.ast_psh();
        self.emit_imm(val);
        // Seed `ast_acc` with the matching IntLit so the next
        // binop sees a paired rhs. The synthetic literal is always
        // C99 `int`-typed -- pointer scaling / mask / shift step
        // constants all fit in the 32-bit signed range C99 6.4.4.1
        // gives an unsuffixed decimal literal.
        self.ast_emit_int_lit(val, Ty::Int as i64);
        self.ast_binop(binop);
    }

    /// Immediate carrying a string-literal / global address. The
    /// surrounding caller records the originating symbol idx into
    /// `glo_imm_refs` so the linker can rebase the address
    /// against the merged data segment. Goes through emit_imm so
    /// the `last_imm_was_zero` peek flag tracks correctly when
    /// the data offset happens to be 0.
    pub(super) fn emit_data_imm(&mut self, data_offset: i64) {
        self.emit_imm(data_offset);
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
        self.pending.last_imm_was_zero
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
        self.pending.last_emit_was_indirect_call
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
        let load_op = self.pending.trailing_scalar_load.take()?;
        // Mirror what the equivalent Op::Lc/Lh/Lw/Li -> Op::Psh
        // tag rewrite did: the address producer's value moves to
        // the c5 stack; push the current `ast_acc` slot onto the
        // parser vstack and clear the accumulator. `None` here
        // represents an address producer whose AST counterpart
        // hasn't been wired yet; the downstream store op then
        // sees a `None` lvalue and skips the Assign build.
        self.ast_vstack.push(self.ast_acc.take());
        // The new tail behaves like a Psh, not a scalar load,
        // and is not a literal Imm 0 either.
        self.pending.last_imm_was_zero = false;
        Some(load_op)
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
        if self.pending.trailing_scalar_load.take().is_none() {
            return false;
        }
        // The load is gone -- the symbol's value never gets
        // read at runtime through this path. Revert the
        // tentative `was_read` the identifier-rvalue path set
        // (preserving any genuine read recorded by an earlier
        // expression) and record `address_escaped`: the caller
        // (currently the unary `&` operator) is converting the
        // rvalue load chain into an lvalue-address chain, and
        // the resulting pointer can escape into surrounding
        // code that the unused-symbol analysis can't follow.
        if let Some(idx) = self.take_last_loaded_local() {
            self.symbols[idx].address_escaped = true;
        }
        // The address producer's value now stays in the
        // accumulator; wrap it in `Expr::Unary { op: AddrOf,
        // child }` so the walker emits the address path rather
        // than a load.
        self.ast_apply_unary(super::super::ast::UnOp::AddrOf);
        true
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
        let load_op = match unit_size {
            1 => Op::Lc,
            2 => Op::Lh,
            4 => Op::Lw,
            _ => Op::Li,
        };
        if self.lex.tk == Token::Assign {
            // Bitfield write: `s.f = expr`. The storage address
            // must remain available for the final Si; push it now
            // and reload through indirection later.
            self.next()?; // consume `=`
            // a = field_addr; stack: [...]
            self.ast_psh(); // stack: [..., field_addr]; a = field_addr
            self.emit_op(load_op); // a = old_value; stack: [..., field_addr]
            self.ast_psh(); // stack: [..., field_addr, old_value]
            self.emit_imm(!(mask << bit_offset)); // a = ~(mask << off)
            self.ast_binop(crate::c5::ir::BinOp::And); // a = old_value & ~(mask << off); stack: [..., field_addr]
            self.ast_psh(); // stack: [..., field_addr, cleared]
            self.expr(Token::Assign as i64)?; // a = new_value
            // Stash the rhs AST id before the trailing Op::Si
            // clears `ast_acc` via `ast_apply_assign`. The
            // surrounding Member handler reads this and builds
            // `Expr::BitfieldAssign` so the walker reproduces the
            // load-clear-shift-or-store sequence.
            self.pending.bf_assign_rhs = self.ast_acc;
            self.ast_psh(); // stack: [..., field_addr, cleared, new_value]
            self.emit_imm(mask);
            self.ast_binop(crate::c5::ir::BinOp::And); // a = new_value & mask; stack: [..., field_addr, cleared]
            if bit_offset > 0 {
                self.ast_psh();
                self.emit_imm(bit_offset as i64);
                self.ast_binop(crate::c5::ir::BinOp::Shl); // a = (new_value & mask) << bit_offset
            }
            // a = shifted; stack: [..., field_addr, cleared].
            // Op::Or pops cleared, ORs into a. After: a = combined;
            // stack: [..., field_addr]. The trailing Si pops
            // field_addr as the destination.
            self.ast_binop(crate::c5::ir::BinOp::Or);
            self.ast_assign(); // pops field_addr, stores a (=combined).
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
            let _ov_temp = -self.loc_offs;
            // a = field_addr; stack: [...]
            self.ast_psh(); // stack: [..., field_addr]
            self.emit_op(load_op); // a = old_value
            // Spill old_value into the scratch local without
            // disturbing `a` or the c5 stack.
            self.mark_emit_other();
            // Extract current = (old_value >> bit_offset) & mask.
            if bit_offset > 0 {
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Shr, bit_offset as i64);
            }
            self.emit_binop_with_imm(crate::c5::ir::BinOp::And, mask);
            // Evaluate the RHS with `current` on the c5 stack so
            // the binop pops it as the left operand. Right-hand-
            // side parsing follows the same precedence as a bare
            // assignment.
            self.ast_psh(); // stack: [..., field_addr, current]
            self.expr(Token::Assign as i64)?;
            // Stash the parsed rhs AST id + the binop here, before
            // the trailing Op::Si clears `ast_acc`. The Member
            // handler reads this to build the dual-emit equivalent
            // `BitfieldAssign { rhs: Binop(read, op, rhs) }` per
            // C99 6.5.16.2.
            let rhs_ast = self.ast_acc;
            let (op, ir_op) = match binop {
                x if x == Token::AddOp as i64 => (Op::Add, crate::c5::ir::BinOp::Add),
                x if x == Token::SubOp as i64 => (Op::Sub, crate::c5::ir::BinOp::Sub),
                x if x == Token::MulOp as i64 => (Op::Mul, crate::c5::ir::BinOp::Mul),
                x if x == Token::DivOp as i64 => (Op::Div, crate::c5::ir::BinOp::Div),
                x if x == Token::ModOp as i64 => (Op::Mod, crate::c5::ir::BinOp::Mod),
                x if x == Token::AndOp as i64 => (Op::And, crate::c5::ir::BinOp::And),
                x if x == Token::OrOp as i64 => (Op::Or, crate::c5::ir::BinOp::Or),
                x if x == Token::XorOp as i64 => (Op::Xor, crate::c5::ir::BinOp::Xor),
                x if x == Token::ShlOp as i64 => (Op::Shl, crate::c5::ir::BinOp::Shl),
                x if x == Token::ShrOp as i64 => (Op::Shr, crate::c5::ir::BinOp::Shr),
                _ => return Err(self.compile_err("unsupported compound op on bitfield")),
            };
            if let Some(r) = rhs_ast {
                self.pending.bf_compound_assign = Some((r, ir_op));
            }
            self.emit_op(op);
            // Mask + shift the combined value back into the slot.
            self.emit_binop_with_imm(crate::c5::ir::BinOp::And, mask);
            if bit_offset > 0 {
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Shl, bit_offset as i64);
            }
            // shifted_new in `a`. Push it so the next ops can
            // reload the cleared old_value into `a`.
            self.ast_psh(); // stack: [..., field_addr, shifted_new]
            self.mark_emit_other();
            self.emit_binop_with_imm(crate::c5::ir::BinOp::And, !(mask << bit_offset));
            self.ast_binop(crate::c5::ir::BinOp::Or); // pops shifted_new; a = cleared | shifted_new
            self.ast_assign(); // pops field_addr, stores a
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
                self.ast_psh();
                self.emit_imm(bit_offset as i64);
                self.ast_binop(crate::c5::ir::BinOp::Shr); // a = (top >> bit_offset)
            }
            self.ast_psh();
            self.emit_imm(mask);
            self.ast_binop(crate::c5::ir::BinOp::And); // a = (...) & mask
            if !is_unsigned_ty(field_ty) && bit_width < 64 {
                let shift = 64i64 - (bit_width as i64);
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Shl, shift);
                self.emit_binop_with_imm(crate::c5::ir::BinOp::Shr, shift); // Op::Shr is arithmetic
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

    // ---- AST helpers ----
    //
    // The parser's `ast_*` calls (plus the small number of
    // remaining `emit_op(Op::*)` tag sites) populate the per-
    // function AST that the walker descends to produce SSA.

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
        // Reserve one PC unit so end_pc > ent_pc holds for every
        // function regardless of body content. With emit_op and
        // emit_val no longer pushing to the tape, the body's
        // text.len() growth is zero; without this reservation the
        // linker / DWARF range invariant would fail.
        self.next_ent_pc += 1;
        let finished = super::super::ast::FinishedFunction {
            ast: core::mem::take(&mut self.ast),
            ent_pc,
            end_pc: self.next_ent_pc,
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

    /// Current source position. Used by the parser's dual-emit
    /// to attach line / file info to every AST node so the
    /// walker can stamp `inst_src` rows for DWARF.
    pub(super) fn ast_src_pos(&mut self) -> SrcPos {
        let file = self.intern_source_file();
        SrcPos {
            line: self.lex.line as u32,
            file,
        }
    }

    /// Push an integer-literal expression and stash it in
    /// `ast_acc`. Called at the integer-literal / enum-constant /
    /// `Token::Num`-class identifier sites.
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
        let id = self.ast.push_expr(Expr::StrLit { data_off, ty }, pos);
        self.ast_acc = Some(id);
        id
    }

    /// Push an identifier reference. The AST node is a single
    /// `Expr::Ident` whose `sym` indexes the symbol table and
    /// whose `ty` matches the C99 6.3.2.1 lvalue-to-rvalue
    /// conversion result. The address-of (`&x`) and assignment
    /// (`x = ...`) paths look up the same `Ident` node and switch
    /// lvalue / rvalue interpretation at the surrounding parent
    /// node -- the conversion is implicit in the AST shape.
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
    /// `ast_acc`. `lvalue` is the just-popped vstack entry.
    /// `by` is the step value the parser already scaled for
    /// pointers (+sizeof(*p) / -sizeof(*p)) so the walker doesn't
    /// have to recompute it.
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
    /// cast site once `(type)expr` finishes parsing; any
    /// intermediate Binary nodes the conversion-shaping sequence
    /// (Fcvtif / Fcvtfi / Shl / Shr / And) left on `ast_acc` are
    /// overwritten with a single canonical Cast node whose
    /// `child` is the pre-cast expression captured by the caller.
    pub(super) fn ast_emit_cast(&mut self, child: ExprId, to_ty: i64) {
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(Expr::Cast { child, to_ty }, pos);
        self.ast_acc = Some(id);
    }

    /// Wrap the current `ast_acc` in an `Expr::Cast { to_ty }`.
    /// Used by `convert_assign_rhs` and other implicit-conversion
    /// sites so the walker emits the right `Inst::FpCast`. No-op
    /// when the accumulator is empty (the child expression
    /// hadn't been wired yet).
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
    /// Called by the function-call parser site after the per-arg
    /// temp store + reverse push + call dispatch lands. `callee`
    /// is the callee's AST expression (synthesised here for
    /// direct calls via `ast.push_expr(Ident { ... })`; the
    /// indirect-call path passes the already-built function-
    /// pointer ExprId). `args` holds each declared argument's
    /// ExprId in source order;
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

    /// Push `Stmt::If { cond, then_s, else_s }`. The caller passes
    /// the source position captured at the `if` keyword so the
    /// walker's `set_src` lands on the line a debugger user types
    /// when they say `b function`, not on the line the lexer
    /// reached after parsing the then-body.
    pub(super) fn ast_emit_if(
        &mut self,
        cond: super::super::ast::ExprId,
        then_s: super::super::ast::StmtId,
        else_s: Option<super::super::ast::StmtId>,
        pos: super::super::ast::SrcPos,
    ) -> super::super::ast::StmtId {
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
        let id = self.ast.push_stmt(super::super::ast::Stmt::Expr(e), pos);
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

    /// Allocate a fresh AST label slot. `self.labels` /
    /// `self.unresolved_gotos` track names for the goto-vs-label
    /// diagnostics; the AST mirror keeps a flat per-function id
    /// space tied back through `Compiler::ast_label_by_name` so
    /// `goto` resolves to the labelled statement.
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
    /// site (stmt.rs). The `value` is `Some(ast_acc)` when the
    /// source spelled out a value and `None` for a bare
    /// `return;` in a void function; the caller picks the shape.
    /// The Stmt's id is returned in case a future parent
    /// (a labelled stmt, a surrounding compound block) wants to
    /// chain it.
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

    /// AST-side reaction to `emit_op`. Only the binop family is
    /// still reached via the variable-Op path (compound-assign
    /// dispatch in `expr.rs`); every other arm dropped after the
    /// `ast_psh` / `ast_assign` / `ast_fneg` / call-site helpers
    /// captured their specialised side effects. The fall-through
    /// arm keeps the dispatch total for the residual Op tags
    /// (Lea / Li / StLocI / LdLocI / Mcpy / TlsLea / Intrinsic /
    /// load_op_for outputs) that still drive `emit_op` for the
    /// state-tracking flags.
    pub(super) fn ast_track_emit_op(&mut self, op: Op) {
        use super::super::ir::BinOp as B;
        match op {
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
            _ => {}
        }
    }

    /// Build an `Expr::Binary` from the parser-side vstack-top
    /// (lhs) and the accumulator (rhs); leave the resulting
    /// ExprId in the accumulator. Result `ty` is whatever
    /// `self.ty` currently holds -- the parser pre-computed the
    /// usual-arithmetic-conversion result type immediately before
    /// the emit. Drops the node when either operand is missing,
    /// keeping the vstack in lockstep with the next wired site.
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
        // C99 6.5.16p2: an assignment's left operand must be a
        // modifiable lvalue. Only a small set of `Expr` shapes
        // qualify; everything else lands on the vstack from a
        // different chain (a nested assignment's value pushed
        // for an enclosing operator, a constant literal pushed
        // by a side-effect computation, ...). Drop the build
        // rather than synthesise a non-C99 shape the walker
        // would reject downstream.
        if !matches!(
            self.ast.expr(lhs),
            super::super::ast::Expr::Ident { .. }
                | super::super::ast::Expr::Unary {
                    op: super::super::ast::UnOp::Deref,
                    ..
                }
                | super::super::ast::Expr::Member { .. }
                | super::super::ast::Expr::Index { .. }
                | super::super::ast::Expr::Binary { .. }
                | super::super::ast::Expr::Cast { .. }
        ) {
            return;
        }
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
    /// Confirms the increment sequence leaves the AST with
    /// exactly one PreInc node.
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

    /// `int add(int a, int b) { return a + b; }` -- the AST
    /// should land two distinct `Expr::Ident` nodes (one per
    /// parameter), with an outer `Binary{Add, Ident, Ident}`
    /// reaching the rhs Ident through the post-Add width-mask
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
