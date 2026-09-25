//! The function type of an expression, beside its `i64` tag, which records
//! only the return type: what a call through the expression converts its
//! arguments to (C99 6.5.2.2p7), whatever form the callee takes.

use alloc::boxed::Box;

use super::super::ast::{Expr, ExprId, UnOp};
use super::super::ir::BinOp;
use super::super::symbol::FnType;
use super::super::token::Token;
use super::Compiler;

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

    /// Record an identifier's function type: a function's, a function
    /// pointer object's, or an array's of them, whose value decays one
    /// level further per dimension.
    pub(super) fn record_ident_fn(&mut self, id: ExprId, idx: usize) {
        let s = &self.symbols[idx];
        let depth = if s.class == Token::Fun as i64 || s.class == Token::Sys as i64 {
            0
        } else if s.fn_ptr_indirection >= 1 {
            let dims = if s.array_size == 0 {
                0
            } else {
                s.array_dims.len().max(1) as i64
            };
            s.fn_ptr_indirection + dims
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
            Expr::Binary {
                op: BinOp::Add | BinOp::Sub,
                lhs,
                rhs,
                ..
            } => self
                .expr_fn(*lhs)
                .or_else(|| self.expr_fn(*rhs))
                .filter(|&(_, d)| d >= 2),
            Expr::Comma { rhs, .. } => self.expr_fn(*rhs),
            Expr::Assign { lhs, .. } => self.expr_fn(*lhs),
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
