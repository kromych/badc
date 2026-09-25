//! The function type of an expression, beside its `i64` tag, which records
//! only the return type: what a call through the expression converts its
//! arguments to (C99 6.5.2.2p7), whatever form the callee takes.

use alloc::boxed::Box;

use super::super::ast::{Expr, ExprId, UnOp};
use super::super::ir::BinOp;
use super::super::symbol::FnType;
use super::super::token::Token;
use super::Compiler;
use super::types::{
    format_fn_type, is_pointer_ty, is_struct_ty, pointee_ty, struct_id_of, struct_ptr_depth,
};

impl Compiler {
    /// The function type symbol `idx` names, or a function pointer
    /// object's pointee has.
    pub(super) fn symbol_fn_type(&self, idx: usize) -> FnType {
        let s = &self.symbols[idx];
        FnType {
            params: s.params.clone(),
            variadic: s.is_variadic,
            conv: s.conv,
            ret: s.ret_fn.clone(),
        }
    }

    /// Record that expression `id` has function type `f`, `depth` pointer
    /// levels above it: 0 for a function, 1 for a pointer to one.
    pub(super) fn set_expr_fn(&mut self, id: ExprId, f: FnType, depth: i64) {
        self.expr_fns.insert(id, (f, depth));
    }

    /// Re-record the value in hand at the depth `to` gives: `*` and `&`
    /// between a function and a pointer to it, between an array and its
    /// address and between an array of arrays and its first row add no
    /// node.
    pub(super) fn retag_expr_fn_depth(&mut self, to: impl Fn(i64) -> i64) {
        if let Some(id) = self.ast_acc
            && let Some((f, d)) = self.expr_fn(id)
        {
            self.set_expr_fn(id, f, to(d));
        }
    }

    /// A row a subscript selects from an array of arrays, built as an
    /// addition, is one level below `array`.
    pub(super) fn record_row_fn(&mut self, array: Option<ExprId>) {
        if let (Some(row), Some(array)) = (self.ast_acc, array)
            && let Some((f, d)) = self.expr_fn(array).filter(|&(_, d)| d >= 2)
        {
            self.set_expr_fn(row, f, d - 1);
        }
    }

    /// The dimensions of the array a pointer-to-array tag points to, each a
    /// level between the pointer and a function-pointer element.
    pub(super) fn pointee_array_levels(&self, tag: i64) -> i64 {
        if !is_struct_ty(tag) || struct_ptr_depth(tag) == 0 {
            return 0;
        }
        let s = &self.structs[struct_id_of(tag)];
        match s.fields.first().filter(|_| s.is_array) {
            Some(f) => f.array_dims.len().max(1) as i64,
            None => 0,
        }
    }

    /// Record an identifier's function type: a function's, a function
    /// pointer object's, or an array's of them, whose value decays one
    /// level further per dimension.
    pub(super) fn record_ident_fn(&mut self, id: ExprId, idx: usize) {
        let s = &self.symbols[idx];
        let depth = if s.class == Token::Fun as i64 || s.class == Token::Sys as i64 {
            0
        } else if s.fn_ptr_indirection >= 1 {
            // An array parameter, adjusted to a pointer, keeps its inner
            // bounds in `array_dims`; a pointer to an array in its tag.
            let dims = if s.array_size == 0 {
                s.array_dims.len().saturating_sub(1)
            } else {
                s.array_dims.len().max(1)
            };
            s.fn_ptr_indirection + dims as i64 + self.pointee_array_levels(s.type_)
        } else {
            return;
        };
        let f = self.symbol_fn_type(idx);
        self.set_expr_fn(id, f, depth);
    }

    /// The function type of expression `id` and its depth, through the
    /// operators that pass a function or a pointer to one along.
    pub(super) fn expr_fn(&self, id: ExprId) -> Option<(FnType, i64)> {
        if let Some(r) = self.expr_fns.get(&id) {
            return Some(r.clone());
        }
        match self.ast.expr(id) {
            // C99 6.3.2.1p4: a function designator decays to a pointer
            // first, so `*` of one is the function again.
            Expr::Unary {
                op: UnOp::Deref,
                child,
                ..
            } => self.expr_fn(*child).map(|(f, d)| (f, (d - 1).max(0))),
            Expr::Unary {
                op: UnOp::AddrOf,
                child,
                ..
            } => self.expr_fn(*child).map(|(f, d)| (f, d + 1)),
            Expr::Index { array, .. } => self
                .expr_fn(*array)
                .filter(|&(_, d)| d >= 2)
                .map(|(f, d)| (f, d - 1)),
            // GNU C steps a pointer to a function by bytes; the result
            // keeps its type. A pointer difference is an integer.
            Expr::Binary {
                op: BinOp::Add | BinOp::Sub,
                lhs,
                rhs,
                ty,
            } if is_pointer_ty(*ty) => self
                .expr_fn(*lhs)
                .or_else(|| self.expr_fn(*rhs))
                .map(|(f, d)| (f, d.max(1))),
            Expr::CompoundAssign {
                op: BinOp::Add | BinOp::Sub,
                lhs,
                ty,
                ..
            } if is_pointer_ty(*ty) => self.expr_fn(*lhs),
            Expr::Assign { lhs, .. }
            | Expr::PreInc { lvalue: lhs, .. }
            | Expr::PostInc { lvalue: lhs, .. } => self.expr_fn(*lhs),
            // The operands of these decay (C99 6.3.2.1p4).
            Expr::Comma { rhs, .. } => self.expr_fn(*rhs).map(|(f, d)| (f, d.max(1))),
            Expr::StmtExpr {
                block, value_item, ..
            } => self
                .stmt_expr_value(*block, *value_item)
                .and_then(|e| self.expr_fn(e))
                .map(|(f, d)| (f, d.max(1))),
            Expr::Call { callee, .. } => {
                let (f, d) = self.expr_fn(*callee)?;
                if d > 1 {
                    return None;
                }
                f.ret.map(|(r, rd)| (*r, rd))
            }
            _ => None,
        }
    }

    /// The spelling of a pointer to `f`, `depth` levels above it, for a
    /// value tagged `tag`: the tag holds the return type plus a pointer
    /// level for each pointer in the chain, one for a designator.
    pub(super) fn fn_type_text(&self, tag: i64, f: &FnType, depth: i64) -> alloc::string::String {
        let mut levels = depth.max(1);
        let mut next = f.ret.as_ref();
        while let Some((r, d)) = next {
            levels += d;
            next = r.ret.as_ref();
        }
        let ret = (0..levels).fold(tag, |t, _| pointee_ty(t));
        format_fn_type(ret, f, depth, &self.structs)
    }

    /// The function type a call through `callee` has: the callee's, when
    /// it is a function or a pointer to one.
    pub(super) fn callee_fn(&self, callee: Option<ExprId>) -> Option<FnType> {
        let (f, d) = self.expr_fn(callee?)?;
        (d <= 1).then_some(f)
    }

    /// The function type the base-type carriers describe, and its depth,
    /// when the base is a function or a pointer to one.
    pub(super) fn carriers_fn_type(&self) -> Option<(FnType, i64)> {
        let p = &self.pending;
        let depth = p.fn_ptr_indirection?;
        let f = FnType {
            params: p.fn_ptr_param_types.clone().unwrap_or_default(),
            variadic: matches!(p.typedef_fn_proto, Some((_, true))),
            conv: p.attr_call_conv,
            ret: p.fn_ptr_ret_fn.clone(),
        };
        Some((f, depth))
    }

    /// `FnType::ret` of the entity a declarator just declared, taking the
    /// carriers. Past the entity's own signature (`own`, or one the
    /// declarator spelled) come the signatures it spelled next, innermost
    /// first, then the base type's function type; without its own, the
    /// entity takes the base's `ret`.
    pub(super) fn take_decl_ret_fn(&mut self, own: bool) -> Option<(Box<FnType>, i64)> {
        let chain = core::mem::take(&mut self.pending.fn_ret_chain);
        let base = self.pending.fn_decl_base.take();
        let carrier = self.pending.fn_ptr_ret_fn.take();
        self.pending.fn_chain_levels = 0;
        if !core::mem::take(&mut self.pending.fn_own_sig) && !own {
            return carrier;
        }
        let mut ret = base.map(|(f, d)| (Box::new(f), d));
        for (params, variadic, depth) in chain.into_iter().rev() {
            let conv = crate::c5::codegen::CallConv::Target;
            ret = Some((
                Box::new(FnType {
                    params,
                    variadic,
                    conv,
                    ret,
                }),
                depth,
            ));
        }
        ret
    }
}
