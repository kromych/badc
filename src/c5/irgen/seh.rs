//! `__try` / `__except` / `__finally` lowering (Microsoft structured
//! exception handling): the guarded body in a region of its own blocks,
//! whose exceptions enter the `__except` body at a block no edge reaches.
//! A filter other than `EXCEPTION_EXECUTE_HANDLER` and a `__finally` block
//! are funclets of their own, which reach the function's objects through
//! the frame value the language handler passes; inside a `__finally`
//! block, through the frame values each enclosing funclet holds in turn.
//! A `__finally` funclet allocates on its own stack. Every exit from a
//! `__finally` region calls its funclet: normally with 0, for a jump with
//! 1, from a block outside the region.

use super::*;
use crate::c5::ast::{SehFunclet, SehHandler};
use crate::c5::ir::ScopeHandler;

/// An open `__try` body, `__except` body, filter or `__finally` block.
pub(super) enum SehCtx {
    /// `__leave` leaves the scopes above `depth` for `leave`.
    Try { leave: BlockId, depth: usize },
    /// `_exception_code()` reads `code_slot`.
    Except { code_slot: i64 },
    /// A filter funclet's expression; `pointers` holds its
    /// `EXCEPTION_POINTERS *`.
    Filter { pointers: i64 },
    /// A `__finally` funclet's block; `abnormal` holds its first argument.
    Finally { abnormal: i64 },
}

/// What a funclet lowers.
#[derive(Clone, Copy)]
enum FuncletBody {
    Filter(ExprId),
    Finally(StmtId),
}

impl<'a> Walker<'a> {
    pub(super) fn walk_seh_try(
        &mut self,
        b: &mut SsaBuilder,
        body: StmtId,
        handler: SehHandler,
        index: u32,
    ) -> Result<bool, WalkError> {
        match handler {
            SehHandler::Except {
                filter,
                body: except,
                funclet,
            } => self.walk_seh_except(b, body, filter, except, funclet),
            SehHandler::Finally { body: fin, funclet } => {
                self.walk_seh_finally(b, body, fin, funclet, index)
            }
        }
    }

    fn walk_seh_except(
        &mut self,
        b: &mut SsaBuilder,
        body: StmtId,
        filter: ExprId,
        except: StmtId,
        funclet: Option<SehFunclet>,
    ) -> Result<bool, WalkError> {
        let handler = match funclet {
            None => ScopeHandler::ExecuteHandler,
            Some(f) => {
                ScopeHandler::Filter(self.walk_funclet(b, FuncletBody::Filter(filter), f)?)
            }
        };
        let join = b.new_block();
        // The handler resets sp to the frame bottom; a frame whose sp moves
        // takes it back to its value at the region's entry.
        let sp_slot = self.dynamic_sp.then(|| {
            let slot = b.alloc_synthetic_local();
            let top = b.intrinsic(Intrinsic::AllocaSave as i64, alloc::vec::Vec::new());
            b.store_local(slot, top, StoreKind::I64);
            slot
        });
        let target = b.new_block();
        let scope = b.open_seh_scope(Some(target), handler);
        self.walk_seh_region(b, body, scope, join)?;
        b.switch_to(target);
        let code = b.exception_code();
        if let Some(slot) = sp_slot {
            let saved = b.load_local(slot, LoadKind::I64);
            b.intrinsic(Intrinsic::AllocaRestore as i64, alloc::vec![saved]);
        }
        let code_slot = b.alloc_synthetic_local();
        b.store_local(code_slot, code, StoreKind::I32);
        self.seh.push(SehCtx::Except { code_slot });
        let walked = self.walk_stmt(b, except);
        self.seh.pop();
        if !walked? && b.is_block_open() {
            b.jmp(join);
        }
        b.switch_to(join);
        Ok(false)
    }

    /// `__try body __finally fin`: the body's normal exit and `__leave`
    /// reach a block outside the region that runs the funclet with 0.
    fn walk_seh_finally(
        &mut self,
        b: &mut SsaBuilder,
        body: StmtId,
        fin: StmtId,
        funclet: SehFunclet,
        index: u32,
    ) -> Result<bool, WalkError> {
        let pc = self.walk_funclet(b, FuncletBody::Finally(fin), funclet)?;
        let normal = b.new_block();
        let scope = b.open_seh_scope(None, ScopeHandler::Finally(pc));
        self.finally_calls.insert(index, (pc, scope));
        self.walk_seh_region(b, body, scope, normal)?;
        b.switch_to(normal);
        self.call_finally(b, pc, 0);
        Ok(false)
    }

    /// The body of region `scope`, `__leave` and its normal exit reaching
    /// `exit`.
    fn walk_seh_region(
        &mut self,
        b: &mut SsaBuilder,
        body: StmtId,
        scope: u32,
        exit: BlockId,
    ) -> Result<(), WalkError> {
        let entry = b.new_block();
        b.jmp(entry);
        b.switch_to(entry);
        self.seh.push(SehCtx::Try {
            leave: exit,
            depth: self.scopes.len(),
        });
        let walked = self.walk_stmt(b, body);
        self.seh.pop();
        b.close_seh_scope(scope);
        if !walked? && b.is_block_open() {
            b.jmp(exit);
        }
        Ok(())
    }

    /// A jump out of the body of `__try` statement `index` runs its
    /// `__finally` funclet with 1, outside the region, so an exception the
    /// funclet raises does not run it again.
    pub(super) fn walk_seh_finally_call(&mut self, b: &mut SsaBuilder, index: u32) {
        let Some(&(pc, scope)) = self.finally_calls.get(&index) else {
            return;
        };
        let block = b.new_block_outside(scope);
        if b.is_block_open() {
            b.jmp(block);
        }
        b.switch_to(block);
        self.call_finally(b, pc, 1);
    }

    /// `pc(abnormal, frame)`: the funclet sees this function's frame as the
    /// language handler shows it.
    fn call_finally(&self, b: &mut SsaBuilder, pc: usize, abnormal: i64) {
        let abnormal = b.imm(abnormal);
        let frame = b.intrinsic(Intrinsic::FuncletFrame as i64, alloc::vec::Vec::new());
        let conv = crate::c5::codegen::CallConv::Target;
        let none = crate::c5::ir::FpMask::EMPTY;
        b.call(pc, alloc::vec![abnormal, frame], 2, false, none, conv);
    }

    /// Lower `body` into its funclet and return its `ent_pc`: a filter,
    /// `long (EXCEPTION_POINTERS *, void *frame)`, or a `__finally` block,
    /// `void (unsigned char abnormal, void *frame)`. An over-aligned object
    /// of the function, which a realigned frame places off the frame value,
    /// is reached through a slot the function stores its address in here,
    /// ahead of the region.
    fn walk_funclet(
        &mut self,
        b: &mut SsaBuilder,
        body: FuncletBody,
        f: SehFunclet,
    ) -> Result<usize, WalkError> {
        let fun = self.fun;
        let pc = fun.funclet_pcs[f.index as usize];
        if self.funclets.iter().any(|g| g.ent_pc == pc) {
            let kind = "a funclet lowered twice";
            return Err(match body {
                FuncletBody::Filter(id) => WalkError::InvalidExpr { id, kind },
                FuncletBody::Finally(id) => WalkError::InvalidStmt { id, kind },
            });
        }
        // This function's over-aligned objects in scope, a funclet's own
        // when this is one.
        let over_aligned = (fun.over_aligned_slots.iter())
            .map(|&(slot, _, _)| slot)
            .filter(|&slot| -slot <= f.slot_base)
            .filter_map(|slot| b.own_slot(slot))
            .collect();
        let frame = b.child_frame(f.slot_base, over_aligned);
        let own_slots = f.slot_end - f.slot_base;
        let (mut fb, first) = SsaBuilder::new_funclet(pc, frame, own_slots, f.allocates);
        fb.set_end_pc(pc + 1);
        for &(base, cells) in &fun.multi_cell_slots {
            fb.add_multi_cell(base, cells);
        }
        for &slot in &fun.array_slots {
            fb.add_array_slot(slot);
        }
        for &(slot, align, size) in &fun.over_aligned_slots {
            if fb.own_slot(slot).is_some() {
                fb.add_region_member(slot, align, size);
            }
        }
        let void = Ty::Char as i64 | crate::c5::compiler::types::VOID_BIT;
        let (ctx, ret_ty, name) = match body {
            FuncletBody::Filter(_) => {
                (SehCtx::Filter { pointers: first }, Ty::Int as i64, "$filt$")
            }
            FuncletBody::Finally(_) => (SehCtx::Finally { abnormal: first }, void, "$fin$"),
        };
        fb.set_name(name.into());
        fb.set_ret_type_tag(ret_ty);
        let mut w = Walker {
            ast: self.ast,
            fun,
            funclets: alloc::vec::Vec::new(),
            finally_calls: alloc::collections::BTreeMap::new(),
            symbols: self.symbols,
            structs: self.structs,
            target: self.target,
            loop_ctx: alloc::vec::Vec::new(),
            scopes: alloc::vec::Vec::new(),
            seh: alloc::vec![ctx],
            dynamic_sp: f.allocates,
            label_scopes: self.label_scopes.clone(),
            label_blocks: alloc::vec![None; self.ast.goto_targets.len()],
            cleanup_exits: alloc::collections::BTreeMap::new(),
            switch_dispatch: alloc::vec::Vec::new(),
            call_temps: alloc::vec::Vec::new(),
            returns_struct: false,
            return_struct_size: 0,
            ret_in_regs: false,
            ret_indirect: false,
            scalar_return_ty: ret_ty,
            returns_no_value: matches!(body, FuncletBody::Finally(_)),
            naked: false,
            indirect_result_slot: 0,
            optimize: self.optimize,
            jump_tables: self.jump_tables,
            named_refs: self.named_refs,
            freestanding: self.freestanding,
        };
        match body {
            FuncletBody::Filter(e) => {
                w.walk_return(&mut fb, e)?;
            }
            FuncletBody::Finally(s) => {
                w.label_scopes = w.label_scope_chains(s);
                if !w.walk_stmt(&mut fb, s)? && fb.is_block_open() {
                    w.return_without_value(&mut fb);
                }
            }
        }
        fb.close_dead_blocks();
        fb.place_region_members();
        let (funclet, levels) = fb.finish_funclet();
        b.adopt_child_frame(levels);
        self.funclets.push(funclet);
        self.funclets.extend(w.funclets);
        Ok(pc)
    }

    /// `__leave;`: to the end of the innermost `__try` body.
    pub(super) fn walk_seh_leave(&mut self, b: &mut SsaBuilder) -> Result<bool, WalkError> {
        let Some((leave, depth)) = self.seh.iter().rev().find_map(|c| match *c {
            SehCtx::Try { leave, depth } => Some((leave, depth)),
            _ => None,
        }) else {
            return Err(WalkError::Unsupported("`__leave` outside a `__try` body"));
        };
        self.leave_scopes(b, depth, false);
        b.jmp(leave);
        Ok(true)
    }

    /// The code of the exception the innermost `__except` body or filter
    /// handles: the first field of the `EXCEPTION_RECORD` a filter's
    /// `EXCEPTION_POINTERS` names first.
    pub(super) fn seh_exception_code(&mut self, b: &mut SsaBuilder) -> Result<ValueId, WalkError> {
        match self.seh_handled() {
            Some(SehCtx::Except { code_slot }) => Ok(b.load_local(*code_slot, LoadKind::U32)),
            Some(SehCtx::Filter { pointers }) => {
                let pointers = b.load_local(*pointers, LoadKind::I64);
                let record = b.load(pointers, LoadKind::I64);
                Ok(b.load(record, LoadKind::U32))
            }
            _ => Err(WalkError::Unsupported(
                "`_exception_code` outside a handler",
            )),
        }
    }

    /// The `EXCEPTION_POINTERS *` of the filter being lowered.
    pub(super) fn seh_exception_info(&mut self, b: &mut SsaBuilder) -> Result<ValueId, WalkError> {
        match self.seh_handled() {
            Some(SehCtx::Filter { pointers }) => Ok(b.load_local(*pointers, LoadKind::I64)),
            _ => Err(WalkError::Unsupported("`_exception_info` outside a filter")),
        }
    }

    /// Whether the `__finally` block being lowered runs for a jump or an
    /// exception: its funclet's first argument, an `unsigned char`.
    pub(super) fn seh_abnormal_termination(
        &mut self,
        b: &mut SsaBuilder,
    ) -> Result<ValueId, WalkError> {
        match self
            .seh
            .iter()
            .rev()
            .find(|c| matches!(c, SehCtx::Finally { .. }))
        {
            Some(SehCtx::Finally { abnormal }) => Ok(b.load_local(*abnormal, LoadKind::U8)),
            _ => Err(WalkError::Unsupported(
                "`_abnormal_termination` outside a `__finally` block",
            )),
        }
    }

    /// The innermost `__except` body or filter.
    fn seh_handled(&self) -> Option<&SehCtx> {
        (self.seh.iter().rev()).find(|c| matches!(c, SehCtx::Except { .. } | SehCtx::Filter { .. }))
    }
}
