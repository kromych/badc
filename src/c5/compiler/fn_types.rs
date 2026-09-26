//! The function type of an expression, beside its `i64` tag, which records
//! only the return type: what a call through the expression converts its
//! arguments to (C99 6.5.2.2p7), whatever form the callee takes.

use alloc::boxed::Box;

use super::super::ast::{Expr, ExprId, UnOp};
use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::ir::BinOp;
use super::super::symbol::{FnParams, FnType};
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{
    format_fn_type, is_pointer_ty, is_struct_ty, pointee_ty, strip_object_const, strip_unsigned,
    struct_id_of, struct_ptr_depth, unqualified_object_ty,
};

/// True when the default argument promotions (C99 6.5.2.2p6) leave `ty`
/// unchanged: integer types of rank below `int` promote to `int` and
/// `float` promotes to `double`, so only those four scalars are altered.
fn promotes_unchanged(ty: i64) -> bool {
    let ty = strip_unsigned(ty);
    ![Ty::Char, Ty::Short, Ty::Bool, Ty::Float]
        .iter()
        .any(|&t| ty == t as i64)
}

impl Compiler {
    /// The function type symbol `idx` names, or a function pointer
    /// object's pointee has.
    pub(super) fn symbol_fn_type(&self, idx: usize) -> FnType {
        let s = &self.symbols[idx];
        FnType {
            params: s.fn_params(),
            conv: s.conv,
            ret: s.ret_fn.clone(),
        }
    }

    /// The function type object `idx` leads to and its depth, when it is a
    /// pointer to a function or to one; `None` for an array of them.
    pub(super) fn object_fn_type(&self, idx: usize) -> Option<(FnType, i64)> {
        let s = &self.symbols[idx];
        let depth = self
            .symbol_fn_depth(idx)
            .filter(|&d| d >= 1 && s.array_size == 0)?;
        Some((self.symbol_fn_type(idx), depth))
    }

    /// The function type expression `id` leads to as a conversion compares
    /// it: a designator's as the pointer it converts to (C99 6.3.2.1p4),
    /// and none when a libc binding supplies it, since its declaration
    /// approximates the platform's.
    pub(super) fn value_fn_type(&self, id: Option<ExprId>) -> Option<(FnType, i64)> {
        let id = id?;
        if self.fn_type_from_binding(id) {
            return None;
        }
        self.expr_fn(id).map(|(f, d)| (f, d.max(1)))
    }

    /// Whether the function type expression `id` leads to is a libc
    /// binding's, reached through `&`, `*`, a comma, a conditional arm or a
    /// call's result.
    fn fn_type_from_binding(&self, id: ExprId) -> bool {
        match self.ast.expr(id) {
            Expr::Ident { class, .. } => *class == Token::Sys as i64,
            Expr::Unary {
                op: UnOp::AddrOf | UnOp::Deref,
                child,
                ..
            } => self.fn_type_from_binding(*child),
            Expr::Comma { rhs, .. } => self.fn_type_from_binding(*rhs),
            Expr::Ternary { then_e, else_e, .. } => {
                self.fn_type_from_binding(*then_e) || self.fn_type_from_binding(*else_e)
            }
            Expr::Call { callee, .. } => self.fn_type_from_binding(*callee),
            _ => false,
        }
    }

    /// C99 6.5.16.1p1: a pointer to a function converts as if by assignment
    /// only to a pointer to a compatible function type (6.7.5.3p15). `to`
    /// and `from` are a tag and the function type it leads to; a value
    /// with none recorded, one through `void *` or an integer, is not
    /// compared. `what` names the conversion and its two sides.
    pub(super) fn check_fn_pointer_conversion(
        &mut self,
        to: (i64, &Option<(FnType, i64)>),
        from: (i64, &Option<(FnType, i64)>),
        line: usize,
        what: (&str, &str, &str),
    ) -> Result<(), C5Error> {
        let ((to_ty, Some((tf, td))), (from_ty, Some((ff, fd)))) = (to, from) else {
            return Ok(());
        };
        // TODO: a pointer to an array of function pointers is not compared;
        // `fn_type_text` does not spell its array levels.
        if self.ptr_array_id(to_ty).is_some() || self.ptr_array_id(from_ty).is_some() {
            return Ok(());
        }
        let tags =
            self.tags_compatible(unqualified_object_ty(to_ty), unqualified_object_ty(from_ty));
        if tags && self.value_fn_types_compatible(Some((tf, *td)), Some((ff, *fd))) {
            return Ok(());
        }
        let (context, to_name, from_name) = what;
        let to_s = self.fn_type_text(to_ty, tf, *td);
        let from_s = self.fn_type_text(from_ty, ff, *fd);
        let text = alloc::format!(
            "incompatible function pointer types in {context} \
             ({to_name}=`{to_s}`, {from_name}=`{from_s}`)"
        );
        self.report_at(Code::INCOMPATIBLE_POINTER_TYPES, line, text)
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
    /// level between the pointer and a function-pointer element: only when
    /// the array lies above the function, `fn_levels` pointer levels down,
    /// and not in its result (`A *(*pf)(void)`).
    pub(super) fn pointee_array_levels(&self, tag: i64, fn_levels: i64) -> i64 {
        let depth = struct_ptr_depth(tag);
        if !is_struct_ty(tag) || depth == 0 || depth >= fn_levels {
            return 0;
        }
        let s = &self.structs[struct_id_of(tag)];
        match s.fields.first().filter(|_| s.is_array) {
            Some(f) => f.array_dims.len().max(1) as i64,
            None => 0,
        }
    }

    /// The levels between symbol `idx`'s value and the function type it
    /// leads to: 0 for a function, the pointer levels of a function
    /// pointer object, and one more per dimension of an array of them.
    fn symbol_fn_depth(&self, idx: usize) -> Option<i64> {
        let s = &self.symbols[idx];
        if s.class == Token::Fun as i64 || s.class == Token::Sys as i64 {
            return Some(0);
        }
        // An array parameter, adjusted to a pointer, keeps its inner
        // bounds in `array_dims`; a pointer to an array in its tag.
        let dims = if s.array_size == 0 {
            s.array_dims.len().saturating_sub(1)
        } else {
            s.array_dims.len().max(1)
        };
        (s.fn_ptr_indirection >= 1).then(|| {
            let arrays = self.pointee_array_levels(s.type_, s.fn_ptr_indirection);
            s.fn_ptr_indirection + dims as i64 + arrays
        })
    }

    /// Record an identifier's function type: a function's, a function
    /// pointer object's, or an array's of them, whose value decays one
    /// level further per dimension.
    pub(super) fn record_ident_fn(&mut self, id: ExprId, idx: usize) {
        if let Some(depth) = self.symbol_fn_depth(idx) {
            let f = self.symbol_fn_type(idx);
            self.set_expr_fn(id, f, depth);
        }
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

    /// C99 6.7.5.3p15: two function types agree in their parameter
    /// information and in the function types their results point to, at
    /// equal depths. The return types themselves ride the tags the callers
    /// compare; the calling convention is not compared.
    pub(super) fn fn_types_compatible(&self, a: &FnType, b: &FnType) -> bool {
        self.fn_params_compatible(&a.params, &b.params)
            && match (&a.ret, &b.ret) {
                (None, None) => true,
                (Some((ra, da)), Some((rb, db))) => da == db && self.fn_types_compatible(ra, rb),
                _ => false,
            }
    }

    /// Two prototypes agree in arity, variadic-ness and the compatibility of
    /// their parameters' unqualified types. A type without one agrees with
    /// another without one, and with a non-variadic prototype whose
    /// parameters the default argument promotions leave unchanged; an
    /// old-style definition's parameter types take no part, as in gcc and
    /// clang.
    fn fn_params_compatible(&self, a: &FnParams, b: &FnParams) -> bool {
        let unpromoted =
            |p: &FnParams| !p.variadic && p.types.iter().all(|&t| promotes_unchanged(t));
        match (a.prototyped, b.prototyped) {
            (true, true) => {
                a.variadic == b.variadic
                    && a.types.len() == b.types.len()
                    && a.types.iter().zip(&b.types).all(|(&x, &y)| {
                        self.tags_compatible(strip_object_const(x), strip_object_const(y))
                    })
            }
            (true, false) => unpromoted(a),
            (false, true) => unpromoted(b),
            (false, false) => true,
        }
    }

    /// Whether two values, each with the function type it leads to at its
    /// depth, agree in it: neither has one, or both do at equal depths and
    /// the types agree.
    pub(super) fn value_fn_types_compatible(
        &self,
        a: Option<(&FnType, i64)>,
        b: Option<(&FnType, i64)>,
    ) -> bool {
        match (a, b) {
            (None, None) => true,
            (Some((fa, da)), Some((fb, db))) => da == db && self.fn_types_compatible(fa, fb),
            _ => false,
        }
    }

    /// The function type the base-type carriers describe, and its depth,
    /// when the base is a function or a pointer to one.
    pub(super) fn carriers_fn_type(&self) -> Option<(FnType, i64)> {
        let p = &self.pending;
        let depth = p.fn_ptr_indirection?;
        let f = FnType {
            params: p.fn_ptr_params.clone().unwrap_or_default(),
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
        let levels = core::mem::take(&mut self.pending.fn_base_levels)
            + core::mem::take(&mut self.pending.fn_chain_array_levels);
        if !core::mem::take(&mut self.pending.fn_own_sig) && !own {
            return carrier;
        }
        let mut ret = base.map(|(f, d)| (Box::new(f), d + levels));
        for (params, depth) in chain.into_iter().rev() {
            let conv = crate::c5::codegen::CallConv::Target;
            ret = Some((Box::new(FnType { params, conv, ret }), depth));
        }
        ret
    }
}
