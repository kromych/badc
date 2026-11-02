//! `__try` / `__except` lowering (Microsoft structured exception handling):
//! the guarded body in a region of its own blocks, whose exceptions enter
//! the `__except` body at a block no edge reaches, and a filter other than
//! `EXCEPTION_EXECUTE_HANDLER` as a funclet of its own, which reaches the
//! function's objects through the frame value the language handler passes.

use super::*;
use crate::c5::ast::{FilterFunclet, SehHandler};
use crate::c5::codegen::ssa::build::ParentFrame;
use crate::c5::ir::{Inst, SehFilter};

/// An open `__try` body, `__except` body or filter.
pub(super) enum SehCtx {
    /// `__leave` leaves the scopes above `depth` for `leave`.
    Try { leave: BlockId, depth: usize },
    /// `_exception_code()` reads `code_slot`.
    Except { code_slot: i64 },
    /// A filter funclet's expression; `pointers` holds its
    /// `EXCEPTION_POINTERS *`.
    Filter { pointers: i64 },
}

impl<'a> Walker<'a> {
    pub(super) fn walk_seh_try(
        &mut self,
        b: &mut SsaBuilder,
        body: StmtId,
        handler: SehHandler,
    ) -> Result<bool, WalkError> {
        let SehHandler::Except {
            filter,
            body: except,
            funclet,
        } = handler
        else {
            return Err(WalkError::Unsupported(
                "SEH `__finally` lowering not implemented yet",
            ));
        };
        let filter = match funclet {
            None => SehFilter::ExecuteHandler,
            Some(f) => SehFilter::Funclet(self.walk_filter(b, filter, f)?),
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
        let scope = b.open_seh_scope(target, filter);
        let entry = b.new_block();
        b.jmp(entry);
        b.switch_to(entry);
        self.seh.push(SehCtx::Try {
            leave: join,
            depth: self.scopes.len(),
        });
        let walked = self.walk_stmt(b, body);
        self.seh.pop();
        b.close_seh_scope(scope);
        if !walked? && b.is_block_open() {
            b.jmp(join);
        }
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

    /// Lower `filter` into its funclet, `long (EXCEPTION_POINTERS *, void
    /// *frame)`, and return its `ent_pc`. An over-aligned object of the
    /// function, which a realigned frame places off the frame value, is
    /// reached through a slot the function stores its address in here,
    /// ahead of the region.
    fn walk_filter(
        &mut self,
        b: &mut SsaBuilder,
        filter: ExprId,
        f: FilterFunclet,
    ) -> Result<usize, WalkError> {
        let fun = self.fun;
        let pc = fun.funclet_pcs[f.index as usize];
        if self.funclets.iter().any(|g| g.ent_pc == pc) {
            return Err(WalkError::InvalidExpr {
                id: filter,
                kind: "a filter lowered twice",
            });
        }
        let over_aligned = (fun.over_aligned_slots.iter())
            .map(|&(slot, _, _)| slot)
            .filter(|&slot| -slot <= f.slot_base)
            .collect();
        let frame = ParentFrame::new(fun.ent_pc, f.slot_base, b.funclet_slots(), over_aligned);
        let (mut fb, pointers) = SsaBuilder::new_funclet(pc, frame, f.slot_end - f.slot_base);
        fb.set_end_pc(pc + 1);
        fb.set_ret_type_tag(Ty::Int as i64);
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
        let mut w = Walker {
            ast: self.ast,
            fun,
            funclets: alloc::vec::Vec::new(),
            symbols: self.symbols,
            structs: self.structs,
            target: self.target,
            loop_ctx: alloc::vec::Vec::new(),
            scopes: alloc::vec::Vec::new(),
            seh: alloc::vec![SehCtx::Filter { pointers }],
            dynamic_sp: false,
            label_scopes: self.label_scopes.clone(),
            label_blocks: alloc::vec![None; self.ast.goto_targets.len()],
            cleanup_exits: alloc::collections::BTreeMap::new(),
            switch_dispatch: alloc::vec::Vec::new(),
            returns_struct: false,
            return_struct_size: 0,
            ret_in_regs: false,
            ret_indirect: false,
            scalar_return_ty: Ty::Int as i64,
            returns_no_value: false,
            naked: false,
            indirect_result_slot: 0,
            optimize: self.optimize,
            jump_tables: self.jump_tables,
            named_refs: self.named_refs,
        };
        w.walk_return(&mut fb, filter)?;
        fb.close_dead_blocks();
        fb.place_region_members();
        let (funclet, mut frame) = fb.finish_funclet();
        let moves_sp = funclet.insts.iter().any(|i| {
            matches!(i, Inst::Intrinsic { kind, .. }
                if *kind == Intrinsic::Alloca as i64 || *kind == Intrinsic::AllocaSave as i64)
        });
        if moves_sp {
            return Err(WalkError::Unsupported(
                "stack allocation in an `__except` filter",
            ));
        }
        for slot in frame.slots.iter_mut() {
            if frame.reached.remove(slot) {
                let object = *slot;
                *slot = b.alloc_synthetic_local();
                let addr = b.local_addr(object);
                b.store_local(*slot, addr, StoreKind::I64);
            }
        }
        b.set_funclet_slots(frame.slots);
        self.funclets.push(funclet);
        Ok(pc)
    }

    /// `__leave;`: to the end of the innermost `__try` body.
    pub(super) fn walk_seh_leave(&mut self, b: &mut SsaBuilder) -> Result<bool, WalkError> {
        let Some((leave, depth)) = self.seh.iter().rev().find_map(|c| match *c {
            SehCtx::Try { leave, depth } => Some((leave, depth)),
            SehCtx::Except { .. } | SehCtx::Filter { .. } => None,
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

    /// The innermost `__except` body or filter.
    fn seh_handled(&self) -> Option<&SehCtx> {
        (self.seh.iter().rev()).find(|c| !matches!(c, SehCtx::Try { .. }))
    }
}
