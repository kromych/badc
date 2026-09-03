//! Statement lowering (C99 6.8): the control flow, the switch dispatch
//! and the label blocks.

use super::types::{expr_ty, is_floating_scalar, type_size_bytes};
use super::*;

impl<'a> Walker<'a> {
    /// Walk a statement. Returns `true` when the statement
    /// terminates the current block (an unconditional return /
    /// jmp), letting the caller stop iterating siblings that
    /// would otherwise emit dead code.
    pub(super) fn walk_stmt(&mut self, b: &mut SsaBuilder, id: StmtId) -> Result<bool, WalkError> {
        let src = self.ast.stmt_src[id as usize];
        b.set_src(src.line, src.file as u32);
        match self.ast.stmt(id) {
            Stmt::Return(Some(e)) => self.walk_return(b, *e),
            Stmt::Return(None) => {
                let zero = b.imm(0);
                b.return_(zero);
                Ok(true)
            }
            Stmt::Expr(e) => {
                // C99 6.8.3: expression statement evaluates the
                // expression for side effects and discards the
                // value. The walker emits the side-effecting
                // chain; the SSA DCE pass drops the dead final
                // value if it has no other uses.
                let e = *e;
                let _ = self.walk_expr_rvalue(b, e)?;
                // A direct call to a `noreturn` function ends the
                // block: the statements after it are unreachable
                // (C11 6.7.4p8) and the unreachable-block prune
                // drops them, so a dead tail's calls never reach
                // the object. Seal with `Unreachable` (not a return),
                // so the block is not counted as a return path -- a
                // guard like `if (x) noreturn_fn(); return v;` stays a
                // single-return, inlinable function.
                if let Expr::Call { callee, .. } = self.ast.expr(e)
                    && let Expr::Ident { sym, .. } = self.ast.expr(*callee)
                    && self
                        .symbols
                        .get(*sym as usize)
                        .is_some_and(|s| s.is_noreturn)
                {
                    b.unreachable();
                    return Ok(true);
                }
                Ok(false)
            }
            Stmt::Compound(items) => self.walk_compound(b, items),
            Stmt::If {
                cond,
                then_s,
                else_s,
            } => self.walk_if(b, *cond, *then_s, *else_s),
            Stmt::While { cond, body } => self.walk_while(b, *cond, *body),
            Stmt::DoWhile { body, cond } => self.walk_do_while(b, *body, *cond),
            Stmt::For {
                init,
                cond,
                post,
                body,
            } => self.walk_for(b, *init, *cond, *post, *body),
            Stmt::Break => {
                let Some(&(brk, _)) = self.loop_ctx.last() else {
                    return Err(WalkError::InvalidStmt { id, kind: "Break" });
                };
                b.jmp(brk);
                Ok(true)
            }
            Stmt::Continue => {
                let Some(&(_, cont)) = self.loop_ctx.last() else {
                    return Err(WalkError::InvalidStmt {
                        id,
                        kind: "Continue",
                    });
                };
                b.jmp(cont);
                Ok(true)
            }
            Stmt::AsmGoto(idx) => {
                // GCC `asm goto`: evaluate the inputs, then close the
                // block with `Terminator::AsmGoto`. Row entry 0 is the
                // fall-through successor; the label-block targets
                // follow in label-list order, sharing the C-label
                // machinery with `goto` (forward references included).
                let asm = self.ast.asm_blocks[*idx as usize].clone();
                let mut args: alloc::vec::Vec<ValueId> =
                    alloc::vec::Vec::with_capacity(asm.operand_exprs.len());
                for &e in &asm.operand_exprs {
                    args.push(self.walk_expr_rvalue(b, e)?);
                }
                let fall = b.new_block();
                let mut targets = alloc::vec::Vec::with_capacity(1 + asm.labels.len());
                targets.push(fall);
                for &l in &asm.labels {
                    targets.push(self.block_for_label(b, l));
                }
                b.asm_goto(alloc::boxed::Box::new(asm.block), args, targets);
                b.switch_to(fall);
                Ok(false)
            }
            Stmt::Goto(label) => {
                let target = self.block_for_label(b, *label);
                b.jmp(target);
                Ok(true)
            }
            Stmt::GotoIndirect(target) => {
                // GCC `goto *expr;`: evaluate the label-address operand
                // and close the block with an indirect branch.
                let v = self.walk_expr_rvalue(b, *target)?;
                b.goto_indirect(v);
                Ok(true)
            }
            Stmt::Labeled { label, body } => {
                let label_blk = self.block_for_label(b, *label);
                // C99 6.8.1: a labeled statement is reachable from
                // both fall-through and any matching goto. When the
                // current block is open, splice it into the label
                // block with a jmp + switch_to. When it is closed
                // (the immediately-preceding stmt terminated --
                // typically a `goto label;` or a return), just
                // switch the cursor; the label block already has
                // its predecessors recorded by their jmps.
                if b.is_block_open() {
                    b.jmp(label_blk);
                }
                b.switch_to(label_blk);
                let body_id = *body;
                self.walk_stmt(b, body_id)
            }
            Stmt::Switch { disc, body } => self.walk_switch(b, *disc, *body),
            // A case / default marker inside the active switch jumps to
            // the block the case-collection pass reserved for it, so the
            // dispatcher can target it and a preceding statement falls
            // through into it. Outside any switch (a parser bug) it is a
            // transparent wrapper around its body.
            Stmt::Case { val, body, .. } => {
                let val = *val;
                let body_id = *body;
                let blk = self.switch_dispatch.last().and_then(|d| {
                    d.cases
                        .iter()
                        .find(|(v, _)| *v == val)
                        .map(|&(_, b)| b)
                        .or_else(|| {
                            d.ranges
                                .iter()
                                .find(|(lo, _, _)| *lo == val)
                                .map(|&(_, _, b)| b)
                        })
                });
                if let Some(blk) = blk {
                    if b.is_block_open() {
                        b.jmp(blk);
                    }
                    b.switch_to(blk);
                }
                self.walk_stmt(b, body_id)
            }
            Stmt::Default { body } => {
                let body_id = *body;
                let blk = self.switch_dispatch.last().and_then(|d| d.default);
                if let Some(blk) = blk {
                    if b.is_block_open() {
                        b.jmp(blk);
                    }
                    b.switch_to(blk);
                }
                self.walk_stmt(b, body_id)
            }
            Stmt::Asm { .. } => Err(WalkError::InvalidStmt { id, kind: "Asm" }),
            Stmt::Decl(d) => {
                let decl_id = *d;
                self.walk_decl(b, decl_id)?;
                Ok(false)
            }
            // C99 6.2.4p2: snapshot the stack pointer on entry to a
            // VLA-declaring block, restore it on exit so the storage is
            // reclaimed (per loop iteration for a loop body).
            Stmt::VlaScopeEnter { save_slot } => {
                let slot = *save_slot;
                let top = b.intrinsic(Intrinsic::AllocaSave as i64, alloc::vec::Vec::new());
                b.store_local(slot, top, StoreKind::I64);
                Ok(false)
            }
            Stmt::VlaScopeExit { save_slot } => {
                let saved = b.load_local(*save_slot, LoadKind::I64);
                b.intrinsic(Intrinsic::AllocaRestore as i64, alloc::vec![saved]);
                Ok(false)
            }
        }
    }

    /// Allocate or reuse the SSA block reserved for the given AST
    /// label id. Goto's forward reference and the matching Labeled
    /// stmt both look up through this so they share the same block.
    pub(super) fn block_for_label(&mut self, b: &mut SsaBuilder, label: LabelId) -> BlockId {
        if let Some(blk) = self.label_blocks[label as usize] {
            return blk;
        }
        let blk = b.new_block();
        self.label_blocks[label as usize] = Some(blk);
        blk
    }

    /// Emit a jump-table dispatcher for a dense case list: a bias
    /// subtract, an unsigned bounds check branching to `deflt`, and a
    /// `Terminator::JumpTable` indexed by the biased discriminant.
    /// Returns false (leaving the cursor untouched) when the case set
    /// is too small or too sparse; the caller falls back to the
    /// compare tree. `cases` is sorted with values already converted
    /// to the promoted controlling type, so consecutive entries differ
    /// by their true unsigned distance regardless of signedness.
    fn emit_switch_table(
        &mut self,
        b: &mut SsaBuilder,
        disc: ValueId,
        cases: &[(i64, BlockId)],
        deflt: BlockId,
    ) -> bool {
        const MIN_CASES: usize = 8;
        if cases.len() < MIN_CASES {
            return false;
        }
        let lo = cases[0].0;
        let hi = cases[cases.len() - 1].0;
        // Exact unsigned span; wrapping covers the full i64 label
        // domain (hi >= lo in the sort order, so the difference is
        // < 2^64 and the wrapped subtraction is exact).
        let span = (hi as u64).wrapping_sub(lo as u64);
        // Density gate: at least half the table slots hold a real
        // case. The bound also caps the table at 2 * cases entries.
        if span >= 2 * cases.len() as u64 {
            return false;
        }
        let mut targets = alloc::vec![deflt; span as usize + 1];
        for &(v, blk) in cases {
            let slot = &mut targets[(v as u64).wrapping_sub(lo as u64) as usize];
            // First case wins on a converted-value collision, matching
            // the compare tree's first-match order.
            if *slot == deflt {
                *slot = blk;
            }
        }
        // idx = disc - lo; the wrapped 64-bit subtraction with the
        // unsigned bound accepts exactly disc in [lo, hi] for every
        // promoted width (the discriminant is already sign- or
        // zero-extended to the same domain as the labels).
        let idx = if lo != 0 {
            b.binop_imm(BinOp::Sub, disc, lo)
        } else {
            disc
        };
        let inb = b.binop_imm(BinOp::Ult, idx, span as i64 + 1);
        let dispatch = b.new_block();
        b.branch_zero(inb, deflt, dispatch);
        b.switch_to(dispatch);
        b.jump_table(idx, targets);
        true
    }

    /// Emit a balanced binary search over a sorted, distinct case list
    /// as the switch dispatcher. The cursor is at an open block on entry
    /// and the block is closed on return. Internal nodes branch on
    /// `lt_op` (`<`); a leaf tests equality and falls to `deflt` when the
    /// discriminant matches no case.
    fn emit_switch_search(
        &mut self,
        b: &mut SsaBuilder,
        disc: ValueId,
        cases: &[(i64, BlockId)],
        lt_op: BinOp,
        deflt: BlockId,
    ) {
        match cases {
            [] => b.jmp(deflt),
            [(val, blk)] => {
                let eq = b.binop_imm(BinOp::Eq, disc, *val);
                b.branch_nonzero(eq, *blk, deflt);
            }
            _ => {
                let mid = cases.len() / 2;
                let pivot = cases[mid].0;
                let lt = b.binop_imm(lt_op, disc, pivot);
                let left = b.new_block();
                let ge = b.new_block();
                b.branch_nonzero(lt, left, ge);
                b.switch_to(left);
                self.emit_switch_search(b, disc, &cases[..mid], lt_op, deflt);
                b.switch_to(ge);
                self.emit_switch_search(b, disc, &cases[mid..], lt_op, deflt);
            }
        }
    }

    /// Reserve a block for every `case` value and for `default` in a
    /// switch body, descending into nested statements but not into a
    /// nested switch (whose labels belong to it, C99 6.8.4.2). A
    /// duplicate case value keeps the first block; the parser already
    /// rejects duplicates.
    #[allow(clippy::type_complexity)]
    fn collect_switch_cases(
        &mut self,
        b: &mut SsaBuilder,
        stmt_id: StmtId,
        cases: &mut alloc::vec::Vec<(i64, BlockId)>,
        ranges: &mut alloc::vec::Vec<(i64, i64, BlockId)>,
        default_blk: &mut Option<BlockId>,
    ) {
        match self.ast.stmt(stmt_id) {
            Stmt::Case { val, hi, body } => {
                let val = *val;
                let hi = *hi;
                let body = *body;
                // Both a single `case v` and a range `case lo ... hi` reserve
                // one block; the body walker looks it up by `lo`. A single
                // value joins the sorted-dispatch list; a range is dispatched
                // by an explicit `lo <= disc <= hi` comparison so a wide range
                // (register-decode switches span millions of values) needs no
                // per-value expansion.
                let blk = b.new_block();
                if val == hi {
                    if !cases.iter().any(|(cv, _)| *cv == val) {
                        cases.push((val, blk));
                    }
                } else {
                    ranges.push((val, hi, blk));
                }
                self.collect_switch_cases(b, body, cases, ranges, default_blk);
            }
            Stmt::Default { body } => {
                let body = *body;
                if default_blk.is_none() {
                    *default_blk = Some(b.new_block());
                }
                self.collect_switch_cases(b, body, cases, ranges, default_blk);
            }
            Stmt::Compound(items) => {
                let items = items.clone();
                for item in items {
                    if let BlockItem::Stmt(s) = item {
                        self.collect_switch_cases(b, s, cases, ranges, default_blk);
                    }
                }
            }
            Stmt::If { then_s, else_s, .. } => {
                let then_s = *then_s;
                let else_s = *else_s;
                self.collect_switch_cases(b, then_s, cases, ranges, default_blk);
                if let Some(e) = else_s {
                    self.collect_switch_cases(b, e, cases, ranges, default_blk);
                }
            }
            Stmt::While { body, .. }
            | Stmt::DoWhile { body, .. }
            | Stmt::For { body, .. }
            | Stmt::Labeled { body, .. } => {
                let body = *body;
                self.collect_switch_cases(b, body, cases, ranges, default_blk);
            }
            // A nested switch owns its own case labels; every other
            // statement carries none.
            _ => {}
        }
    }

    /// Lower a GCC statement expression `({ ... })`. Walks the
    /// block items exactly as `Stmt::Compound` does -- new-block on
    /// a closed predecessor, decls through `walk_decl` -- but keeps
    /// the value of the final expression-statement (GCC: the value
    /// of the whole construct; a non-expression tail makes it void,
    /// lowered as an immediate 0). Labels wrapping the final
    /// statement are entered before it is evaluated, so the value
    /// is computed in the label's join block and is defined on
    /// every arriving path -- fall-through and any `goto` into the
    /// label. `block` is the enclosed compound, or the bare
    /// statement for a single-item block.
    pub(super) fn walk_stmt_expr(
        &mut self,
        b: &mut SsaBuilder,
        block: StmtId,
        value_item: u32,
    ) -> Result<ValueId, WalkError> {
        let items: alloc::vec::Vec<BlockItem> = match self.ast.stmt(block) {
            Stmt::Compound(items) => items.clone(),
            _ => alloc::vec![BlockItem::Stmt(block)],
        };
        let mut result: Option<ValueId> = None;
        for (i, item) in items.into_iter().enumerate() {
            if !b.is_block_open() {
                let dead = b.new_block();
                b.switch_to(dead);
            }
            match item {
                BlockItem::Stmt(mut s) => {
                    // The scope-exit statements after it are walked for
                    // effect only, which is C's scope-exit order.
                    let carries_value = i as u32 == value_item;
                    if carries_value {
                        while let Stmt::Labeled { label, body } = self.ast.stmt(s) {
                            let (label, body) = (*label, *body);
                            let label_blk = self.block_for_label(b, label);
                            if b.is_block_open() {
                                b.jmp(label_blk);
                            }
                            b.switch_to(label_blk);
                            s = body;
                        }
                    }
                    if let Stmt::Expr(e) = self.ast.stmt(s) {
                        let e = *e;
                        let v = self.walk_expr_rvalue(b, e)?;
                        if carries_value {
                            // A value the item left in a closed block
                            // (a noreturn call) is unreachable; the
                            // placeholder below stands for it.
                            result = b.is_block_open().then_some(v);
                        }
                    } else {
                        let _ = self.walk_stmt(b, s)?;
                    }
                }
                BlockItem::Decl(d) => {
                    self.walk_decl(b, d)?;
                }
            }
        }
        // A GNU statement expression whose final statement transfers
        // control out of it (a `goto` or `return`, or a noreturn call)
        // closes the block; its value is then unreachable. Open a fresh
        // block and yield a placeholder so callers, which assume an rvalue
        // leaves an open block, keep building well-formed SSA that the
        // unreachable-block prune drops.
        if !b.is_block_open() {
            let dead = b.new_block();
            b.switch_to(dead);
            return Ok(b.imm(0));
        }
        match result {
            Some(v) => Ok(v),
            None => Ok(b.imm(0)),
        }
    }

    /// Whether the statement subtree defines a label reachable from
    /// outside it: a `goto` target (`Labeled`) anywhere within, or a
    /// `case` / `default` belonging to a `switch` that encloses the
    /// subtree. A constant-condition `if` may drop its dead branch
    /// only when that branch defines none, since the branch's block
    /// would otherwise never be emitted for the jump to reach. A
    /// `switch` wholly inside the branch owns its case labels -- its
    /// dispatch drops with the branch -- so those don't pin it.
    fn stmt_defines_label(&self, id: StmtId) -> bool {
        self.stmt_defines_external_label(id, false)
    }

    fn stmt_defines_external_label(&self, id: StmtId, cases_owned: bool) -> bool {
        match self.ast.stmt(id) {
            Stmt::Labeled { .. } => true,
            Stmt::Case { body, .. } | Stmt::Default { body } => {
                !cases_owned || self.stmt_defines_external_label(*body, cases_owned)
            }
            Stmt::Compound(items) => items.iter().any(|it| match it {
                BlockItem::Stmt(s) => self.stmt_defines_external_label(*s, cases_owned),
                BlockItem::Decl(_) => false,
            }),
            Stmt::If { then_s, else_s, .. } => {
                self.stmt_defines_external_label(*then_s, cases_owned)
                    || else_s.is_some_and(|e| self.stmt_defines_external_label(e, cases_owned))
            }
            Stmt::While { body, .. } | Stmt::DoWhile { body, .. } | Stmt::For { body, .. } => {
                self.stmt_defines_external_label(*body, cases_owned)
            }
            Stmt::Switch { body, .. } => self.stmt_defines_external_label(*body, true),
            _ => false,
        }
    }

    /// C99 6.8.6.4: return the operand, converted as if by assignment to the
    /// function's return type.
    pub(super) fn walk_return(&mut self, b: &mut SsaBuilder, e: ExprId) -> Result<bool, WalkError> {
        // C99 6.8.6.4p3: the operand converts as if by assignment. A
        // scalar returned through the 128-bit integer carrier is a
        // value, not an address, so widen it into a 16-byte object
        // first -- the aggregate paths below read an address.
        let widened =
            if self.is_int128_value_ty(self.scalar_return_ty) && !self.expr_is_int128_value(e) {
                let pair = self.int128_operand(b, e)?;
                Some(self.int128_materialize(b, pair))
            } else {
                None
            };
        if self.ret_in_regs || self.ret_indirect {
            // C99 6.8.6.4 + AAPCS64 6.9 host-ABI struct return:
            // yield the struct's address. The codegen scatters
            // the eightbytes into the result registers (<= 16
            // bytes) or copies the value through the x8 result
            // pointer (> 16 bytes); the VM copies it into the
            // caller's result temp.
            let v = match widened {
                Some(addr) => addr,
                None => self.walk_copy_operand(b, e)?,
            };
            b.return_(v);
            return Ok(true);
        }
        if self.returns_struct {
            // C99 6.8.6.4 + the c5 out-pointer convention: the
            // callee receives the caller's result-temp address
            // in `slot 2`. `return s;` copies `sizeof(struct
            // T)` bytes from `s`'s address into that
            // out-pointer and returns it so the call site has a
            // stable value to chain into the surrounding
            // assignment / Mcpy.
            let out_ptr = b.load_local(2, LoadKind::I64);
            let src = match widened {
                Some(addr) => addr,
                None => self.walk_copy_operand(b, e)?,
            };
            if self.return_struct_size > 0 {
                // The out-pointer is the caller's result temp, so
                // only the returned type's own alignment holds.
                let align = match widened {
                    Some(_) => self.struct_align(self.scalar_return_ty),
                    None => expr_ty(self.ast.expr(e))
                        .map(|t| self.struct_align(t))
                        .unwrap_or(1),
                };
                b.mcpy(out_ptr, src, self.return_struct_size, align);
            }
            b.return_(out_ptr);
            return Ok(true);
        }
        let mut v = self.walk_copy_operand(b, e)?;
        // C99 6.8.6.4 / 6.3.1.1: the return value is converted to the
        // function's return type. A body evaluated in 64-bit registers
        // can leave bits above the type width set -- a signed constant
        // or arithmetic sign-extends past bit 31, an unsigned source
        // zero-extends -- so a char/short/int (and LLP64 long) return
        // is narrowed to its declared width: zero-extend when unsigned,
        // sign-extend when signed. Same-unit callers read the result
        // register directly and do not re-narrow. `_Bool` is excluded:
        // 6.3.1.2 already normalized it to 0/1.
        let stripped = strip_unsigned(self.scalar_return_ty);
        let rs = type_size_bytes(self.scalar_return_ty, self.target);
        if !is_floating_scalar(self.scalar_return_ty)
            && !is_pointer_ty(self.scalar_return_ty)
            && stripped != Ty::Bool as i64
            && (rs == 1 || rs == 2 || rs == 4)
        {
            let unsigned = (self.scalar_return_ty & UNSIGNED_BIT) != 0;
            let bits = 64i64 - (rs as i64) * 8;
            let mask: i64 = match rs {
                1 => 0xff,
                2 => 0xffff,
                _ => 0xffff_ffff,
            };
            if let Some(k) = b.peek_imm(v) {
                // A constant is its own narrowing: fold it, and leave
                // the value untouched when it already fits the type.
                let narrowed = if unsigned {
                    k & mask
                } else {
                    (k << bits) >> bits
                };
                if narrowed != k {
                    v = b.imm(narrowed);
                }
            } else if unsigned {
                v = b.binop_imm(BinOp::And, v, mask);
            } else {
                let shifted = b.binop_imm(BinOp::Shl, v, bits);
                v = b.binop_imm(BinOp::Shr, shifted, bits);
            }
        }
        b.return_(v);
        Ok(true)
    }

    /// C99 6.8.2: a block's items in source order. A statement that closed the
    /// current block leaves the rest of the block unreachable.
    pub(super) fn walk_compound(
        &mut self,
        b: &mut SsaBuilder,
        items: &'a [BlockItem],
    ) -> Result<bool, WalkError> {
        for item in items {
            match item {
                BlockItem::Stmt(s) => {
                    // A previous item closed the current
                    // block (Return / Goto / Break /
                    // Continue / If-both-arms-return). If
                    // this item is a `Stmt::Labeled`, the
                    // walker below resumes at its label
                    // block so any earlier `goto label`,
                    // `case <val>:`, or `default:` lands
                    // somewhere walkable. Non-label dead
                    // code per C99 6.8.6 is still walked
                    // into a fresh synthetic block so the
                    // SSA covers the unreachable region;
                    // the resolver later prunes anything
                    // the codegen can elide.
                    if !b.is_block_open()
                        && !matches!(
                            self.ast.stmt(*s),
                            Stmt::Labeled { .. } | Stmt::Case { .. } | Stmt::Default { .. },
                        )
                    {
                        let dead = b.new_block();
                        b.switch_to(dead);
                    }
                    if self.walk_stmt(b, *s)? {
                        continue;
                    }
                }
                BlockItem::Decl(d) => {
                    // Decls in dead-code regions still go
                    // through walk_decl so the walker's
                    // local-slot bookkeeping mirrors what
                    // the parser stamped (per-decl
                    // initialiser side effects land in the
                    // same trailing dead block).
                    if !b.is_block_open() {
                        let dead = b.new_block();
                        b.switch_to(dead);
                    }
                    let d = *d;
                    self.walk_decl(b, d)?;
                }
            }
        }
        Ok(!b.is_block_open())
    }

    /// C99 6.8.4.1 selection statement.
    pub(super) fn walk_if(
        &mut self,
        b: &mut SsaBuilder,
        cond: ExprId,
        then_s: StmtId,
        else_s: Option<StmtId>,
    ) -> Result<bool, WalkError> {
        // A constant controlling expression selects one branch
        // at translation time (C99 6.8.4.1); emit only that
        // branch so the dead branch's side effects and
        // undefined-symbol references are never emitted. Skip
        // the fold when the dead branch defines a label a goto
        // or switch could target -- dropping its block would
        // leave the jump unresolved. Matches gcc's front-end
        // fold at -O0.
        if let Some(c) = self.const_fold_int(cond) {
            let dead = if c != 0 { else_s } else { Some(then_s) };
            if !dead.is_some_and(|s| self.stmt_defines_label(s)) {
                if c != 0 {
                    return self.walk_stmt(b, then_s);
                }
                return match else_s {
                    Some(else_id) => self.walk_stmt(b, else_id),
                    None => Ok(false),
                };
            }
        }
        let cond_v = self.walk_cond_value(b, cond)?;
        let then_blk = b.new_block();
        let after_blk = b.new_block();
        let else_blk = if else_s.is_some() {
            b.new_block()
        } else {
            after_blk
        };
        // C99 6.8.4.1: branch-when-zero to the else (or
        // after) block; fall through to then.
        b.branch_zero(cond_v, else_blk, then_blk);
        b.switch_to(then_blk);
        let then_id = then_s;
        let else_id = else_s;
        let then_terminated = self.walk_stmt(b, then_id)?;
        if !then_terminated {
            b.jmp(after_blk);
        }
        if let Some(else_id) = else_id {
            b.switch_to(else_blk);
            let else_terminated = self.walk_stmt(b, else_id)?;
            if !else_terminated {
                b.jmp(after_blk);
            }
        }
        b.switch_to(after_blk);
        Ok(false)
    }

    /// Walk a loop body in `body_blk`, with `break` leaving to `after`
    /// and `continue` entering `next` (C99 6.8.6.2 / 6.8.6.3). A body
    /// that does not terminate falls through to `next`. The caller
    /// switches to the block its own layout continues in.
    fn walk_loop_body(
        &mut self,
        b: &mut SsaBuilder,
        body_blk: BlockId,
        body: StmtId,
        next: BlockId,
        after: BlockId,
    ) -> Result<(), WalkError> {
        b.switch_to(body_blk);
        self.loop_ctx.push((after, next));
        let terminated = self.walk_stmt(b, body)?;
        self.loop_ctx.pop();
        if !terminated {
            b.jmp(next);
        }
        Ok(())
    }

    /// C99 6.8.5.1 `while` loop.
    pub(super) fn walk_while(
        &mut self,
        b: &mut SsaBuilder,
        cond: ExprId,
        body: StmtId,
    ) -> Result<bool, WalkError> {
        let header = b.new_block();
        let body_blk = b.new_block();
        let after = b.new_block();
        b.jmp(header);
        b.switch_to(header);
        let cond_v = self.walk_cond_value(b, cond)?;
        b.branch_zero(cond_v, after, body_blk);
        self.walk_loop_body(b, body_blk, body, header, after)?;
        b.switch_to(after);
        Ok(false)
    }

    /// C99 6.8.5.2 `do` loop.
    pub(super) fn walk_do_while(
        &mut self,
        b: &mut SsaBuilder,
        body: StmtId,
        cond: ExprId,
    ) -> Result<bool, WalkError> {
        let body_blk = b.new_block();
        let cond_blk = b.new_block();
        let after = b.new_block();
        b.jmp(body_blk);
        self.walk_loop_body(b, body_blk, body, cond_blk, after)?;
        b.switch_to(cond_blk);
        let cond_v = self.walk_cond_value(b, cond)?;
        b.branch_nonzero(cond_v, body_blk, after);
        b.switch_to(after);
        Ok(false)
    }

    /// C99 6.8.5.3 `for` loop.
    pub(super) fn walk_for(
        &mut self,
        b: &mut SsaBuilder,
        init: Option<BlockItem>,
        cond: Option<ExprId>,
        post: Option<ExprId>,
        body: StmtId,
    ) -> Result<bool, WalkError> {
        // C99 6.8.5.3: for-init is either an expression
        // (`BlockItem::Stmt`) or a declaration
        // (`BlockItem::Decl`). The init runs once before
        // the cond / body / post loop; without walking
        // the declaration path the loop counter stays
        // uninitialised on every iteration.
        match init {
            Some(BlockItem::Stmt(s)) => {
                let _ = self.walk_stmt(b, s)?;
            }
            Some(BlockItem::Decl(d)) => {
                self.walk_decl(b, d)?;
            }
            None => {}
        }
        let header = b.new_block();
        let post_blk = b.new_block();
        let body_blk = b.new_block();
        let after = b.new_block();
        b.jmp(header);
        b.switch_to(header);
        let cond_v = match cond {
            Some(c) => self.walk_cond_value(b, c)?,
            None => b.imm(1),
        };
        b.branch_zero(cond_v, after, body_blk);
        // C99 6.8.5.3 specifies the *evaluation* order
        // (cond, body, post) but leaves layout open. Walk
        // post before body so the SSA Inst ordering
        // matches the layout the call-fixup resolver
        // expects. Control flow is unaffected -- each
        // block's terminator routes execution in the C99
        // order regardless of inst-vec layout.
        b.switch_to(post_blk);
        if let Some(p) = post {
            let _ = self.walk_expr_rvalue(b, p)?;
        }
        b.jmp(header);
        self.walk_loop_body(b, body_blk, body, post_blk, after)?;
        b.switch_to(after);
        Ok(false)
    }

    /// C99 6.8.4.2 `switch`: the case dispatch and the body it jumps into.
    pub(super) fn walk_switch(
        &mut self,
        b: &mut SsaBuilder,
        disc: ExprId,
        body: StmtId,
    ) -> Result<bool, WalkError> {
        let disc_val = self.walk_expr_rvalue(b, disc)?;
        let body_id = body;
        let after_blk = b.new_block();

        // Reserve a block for every case value and for default
        // (C99 6.8.4.2: case labels at any depth scope to the
        // nearest switch). The body walk below jumps to these
        // blocks at each marker, so a marker inside a nested
        // loop is still reachable from the dispatcher.
        let mut cases: alloc::vec::Vec<(i64, BlockId)> = alloc::vec::Vec::new();
        let mut ranges: alloc::vec::Vec<(i64, i64, BlockId)> = alloc::vec::Vec::new();
        let mut default_blk: Option<BlockId> = None;
        self.collect_switch_cases(b, body_id, &mut cases, &mut ranges, &mut default_blk);

        // Dispatcher: a balanced binary search over the sorted
        // case values. Each internal node branches on `<` (one
        // conditional branch) and a leaf tests equality, so a
        // dispatch is O(log n) branches where a linear compare
        // chain is O(n). Case values are distinct (C99 6.8.4.2);
        // the discriminant's signedness selects the ordering and
        // the comparison so an unsigned discriminant with the
        // high bit set still sorts correctly.
        let deflt = default_blk.unwrap_or(after_blk);
        let disc_ty = expr_ty(self.ast.expr(disc)).unwrap_or(Ty::Int as i64);
        let disc_unsigned = disc_ty & UNSIGNED_BIT != 0;
        let mut sorted = cases.clone();
        if disc_unsigned {
            // C99 6.8.4.2p1 + p5: the controlling expression is
            // integer-promoted, then each case label is converted to
            // that promoted type. A 4-byte unsigned controlling type
            // (`unsigned int`, and `unsigned long` on LLP64) promotes
            // to itself, so a negative label wraps modulo 2^32 and
            // must match the zero-extended discriminant -- mask it to
            // 32 bits. An 8-byte unsigned type keeps the full-width
            // value, which already matches. (Sub-`int` unsigned types
            // promote to signed `int`, so a negative label stays
            // negative and never matches a zero-extended value; those
            // are reported as unsigned by `disc_ty` but take the plain
            // path here with no masking.)
            if type_size_bytes(disc_ty, self.target) == 4 {
                for c in sorted.iter_mut() {
                    c.0 = (c.0 as u32) as i64;
                }
            }
            sorted.sort_by_key(|p| p.0 as u64);
        } else {
            // Signed controlling type: a 4-byte type promotes to
            // itself and a sub-int type to signed `int`, so the
            // label converts by sign-truncation to 32 bits --
            // `case 0x80000000:` on an `int` switch must match
            // the sign-extended INT_MIN discriminant. An 8-byte
            // type keeps the full-width label.
            if type_size_bytes(disc_ty, self.target) <= 4 {
                for c in sorted.iter_mut() {
                    c.0 = (c.0 as i32) as i64;
                }
            }
            sorted.sort_by_key(|p| p.0);
        }
        // Range cases (`case lo ... hi`): each is dispatched by an
        // explicit `lo <= disc <= hi` test before the single-value
        // search, so a wide range needs no per-value expansion. The
        // bounds convert to the promoted type exactly like the
        // single-value labels above.
        let (ge_op, le_op) = if disc_unsigned {
            (BinOp::Uge, BinOp::Ule)
        } else {
            (BinOp::Ge, BinOp::Le)
        };
        let disc_bytes = type_size_bytes(disc_ty, self.target);
        for &(mut lo, mut hi, blk) in &ranges {
            if disc_unsigned {
                if disc_bytes == 4 {
                    lo = (lo as u32) as i64;
                    hi = (hi as u32) as i64;
                }
            } else if disc_bytes <= 4 {
                lo = (lo as i32) as i64;
                hi = (hi as i32) as i64;
            }
            let ge_lo = b.binop_imm(ge_op, disc_val, lo);
            let hi_chk = b.new_block();
            let next = b.new_block();
            b.branch_nonzero(ge_lo, hi_chk, next);
            b.switch_to(hi_chk);
            let le_hi = b.binop_imm(le_op, disc_val, hi);
            b.branch_nonzero(le_hi, blk, next);
            b.switch_to(next);
        }
        let lt_op = if disc_unsigned { BinOp::Ult } else { BinOp::Lt };
        if !self.jump_tables || !self.emit_switch_table(b, disc_val, &sorted, deflt) {
            self.emit_switch_search(b, disc_val, &sorted, lt_op, deflt);
        }

        // Walk the body linearly. The opening block is reachable
        // only by a goto into the switch ahead of the first case
        // (C99 6.8.1); the dispatcher never targets it.
        let fallin = b.new_block();
        b.switch_to(fallin);

        // `break` leaves the switch; `continue` is invalid in a
        // bare switch, so propagate the enclosing loop's target.
        let prev_continue = self.loop_ctx.last().map(|&(_, c)| c).unwrap_or(after_blk);
        self.loop_ctx.push((after_blk, prev_continue));
        self.switch_dispatch.push(SwitchLabels {
            cases,
            ranges,
            default: default_blk,
        });
        let terminated = self.walk_stmt(b, body_id)?;
        self.switch_dispatch.pop();
        self.loop_ctx.pop();
        if !terminated {
            b.jmp(after_blk);
        }
        b.switch_to(after_blk);
        Ok(false)
    }
}
