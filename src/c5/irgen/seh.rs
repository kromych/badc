//! `__try` / `__except` lowering (Microsoft structured exception handling):
//! the guarded body in a region of its own blocks, whose exceptions enter
//! the `__except` body at a block no edge reaches.

use super::*;
use crate::c5::ast::{SehHandler, UnOp};

/// An open `__try` body or `__except` body.
pub(super) enum SehCtx {
    /// `__leave` leaves the scopes above `depth` for `leave`.
    Try { leave: BlockId, depth: usize },
    /// `_exception_code()` reads `code_slot`.
    Except { code_slot: i64 },
}

/// What a filter evaluates to: `EXCEPTION_EXECUTE_HANDLER`.
const EXECUTE_HANDLER: i64 = 1;
/// `EXCEPTION_CONTINUE_SEARCH`: the region handles nothing.
const CONTINUE_SEARCH: i64 = 0;

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
        } = handler
        else {
            return Err(WalkError::Unsupported(
                "SEH `__finally` lowering not implemented yet",
            ));
        };
        let handles = match self.filter_constant(filter) {
            Some(EXECUTE_HANDLER) => true,
            Some(CONTINUE_SEARCH) => false,
            Some(_) => {
                return Err(WalkError::Unsupported(
                    "SEH filter other than EXCEPTION_EXECUTE_HANDLER or \
                     EXCEPTION_CONTINUE_SEARCH not implemented yet",
                ));
            }
            None => {
                return Err(WalkError::Unsupported(
                    "SEH non-constant filter not implemented yet",
                ));
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
        let target = handles.then(|| b.new_block());
        let scope = target.map(|target| b.open_seh_scope(target));
        let entry = b.new_block();
        b.jmp(entry);
        b.switch_to(entry);
        self.seh.push(SehCtx::Try {
            leave: join,
            depth: self.scopes.len(),
        });
        let walked = self.walk_stmt(b, body);
        self.seh.pop();
        if let Some(scope) = scope {
            b.close_seh_scope(scope);
        }
        if !walked? && b.is_block_open() {
            b.jmp(join);
        }
        if let Some(target) = target {
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
        }
        b.switch_to(join);
        Ok(false)
    }

    /// `__leave;`: to the end of the innermost `__try` body.
    pub(super) fn walk_seh_leave(&mut self, b: &mut SsaBuilder) -> Result<bool, WalkError> {
        let Some((leave, depth)) = self.seh.iter().rev().find_map(|c| match *c {
            SehCtx::Try { leave, depth } => Some((leave, depth)),
            SehCtx::Except { .. } => None,
        }) else {
            return Err(WalkError::Unsupported("`__leave` outside a `__try` body"));
        };
        self.leave_scopes(b, depth, false);
        b.jmp(leave);
        Ok(true)
    }

    /// The code of the exception the innermost `__except` body handles.
    pub(super) fn seh_exception_code(&mut self, b: &mut SsaBuilder) -> Result<ValueId, WalkError> {
        let Some(slot) = self.seh.iter().rev().find_map(|c| match *c {
            SehCtx::Except { code_slot } => Some(code_slot),
            SehCtx::Try { .. } => None,
        }) else {
            return Err(WalkError::Unsupported(
                "SEH filter intrinsics not implemented yet",
            ));
        };
        Ok(b.load_local(slot, LoadKind::U32))
    }

    /// The integer a filter expression folds to.
    fn filter_constant(&self, e: ExprId) -> Option<i64> {
        match self.ast.expr(e) {
            Expr::IntLit { val, .. } => Some(*val),
            Expr::Cast { child, .. } => self.filter_constant(*child),
            Expr::Unary {
                op: UnOp::Neg,
                child,
                ..
            } => self.filter_constant(*child).map(i64::wrapping_neg),
            _ => None,
        }
    }
}
