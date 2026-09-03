//! Expression lowering (C99 6.5). This module dispatches on the node and
//! holds the shapes shared across the categories -- lvalues, the
//! scalar conversions, and constant folding; each category walks in its
//! own submodule.

mod binary;
mod cond;
mod postfix;
mod primary;
mod unary;

use super::types::{
    fold_int_binop, is_bool_scalar, is_float_ty, is_floating_scalar, lvalue_shape_label,
    narrow_const_to_ty, type_size_bytes,
};
use super::*;
use crate::c5::ast::expr_ty;
use crate::c5::ir::{imm_safe_binop, is_comparison_op};
use postfix::MemberRef;

impl<'a> Walker<'a> {
    /// Walk an expression in rvalue position. Returns the
    /// `ValueId` whose runtime value is the C99 6.5p1 evaluation
    /// of the expression.
    pub(super) fn walk_expr_rvalue(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
    ) -> Result<ValueId, WalkError> {
        match self.ast.expr(id) {
            Expr::IntLit { val, .. } => Ok(b.imm(*val)),
            Expr::FloatLit { bits, ty } => {
                // C99 6.4.4.2: an `f`-suffixed constant is single
                // precision, so the lexer's f64 pattern narrows to the
                // f32 one and the value is tagged f32.
                if is_float_ty(*ty) {
                    let f32_bits = f64::from_bits(*bits) as f32;
                    return Ok(b.imm_f32(f32_bits.to_bits()));
                }
                Ok(b.imm(*bits as i64))
            }
            Expr::StrLit { data_off, .. } => Ok(b.imm_data(*data_off)),
            Expr::Ident {
                sym,
                ty,
                class,
                val,
                is_thread_local,
                array_size,
            } => self.load_ident_rvalue(
                b,
                id,
                *sym,
                *ty,
                *class,
                *val,
                *is_thread_local,
                *array_size,
            ),
            Expr::Unary { op, child, ty } => self.walk_unary(b, *op, *child, *ty),
            Expr::Binary { op, lhs, rhs, ty } => self.walk_binary(b, *op, *lhs, *rhs, *ty),
            Expr::BitfieldAssign {
                obj,
                field_off,
                bitfield,
                rhs,
                ty,
            } => {
                let m = MemberRef {
                    obj: *obj,
                    field_off: *field_off,
                    ty: *ty,
                };
                self.walk_bitfield_assign(b, id, m, *bitfield, *rhs)
            }
            Expr::Assign { lhs, rhs, ty } => self.walk_assign(b, *lhs, *rhs, *ty),
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                ty,
                elvis,
            } => self.walk_ternary(b, *cond, *then_e, *else_e, *ty, *elvis),
            Expr::Call { callee, args, ty } => self.walk_call(b, *callee, args, *ty),
            Expr::Member {
                obj,
                field_off,
                bitfield,
                ty,
                array_size,
            } => {
                let m = MemberRef {
                    obj: *obj,
                    field_off: *field_off,
                    ty: *ty,
                };
                self.walk_member(b, id, m, *bitfield, *array_size)
            }
            Expr::Index { array, idx, ty } => self.walk_index(b, id, *array, *idx, *ty),
            Expr::Cast { child, to_ty } => self.walk_cast(b, *child, *to_ty),
            Expr::CompoundAssign { op, lhs, rhs, ty } => {
                self.walk_compound_assign(b, *op, *lhs, *rhs, *ty)
            }
            Expr::PreInc { lvalue, by, ty } => self.walk_inc(b, *lvalue, *by, *ty, false),
            Expr::PostInc { lvalue, by, ty } => self.walk_inc(b, *lvalue, *by, *ty, true),
            Expr::Sizeof(s) => Ok(b.imm(s.size_bytes)),
            // C99 6.3.2.1p3: a VLA lvalue decays to a pointer to its
            // first element -- the runtime base pointer the matching
            // `Decl::Vla` stored into `ptr_slot`.
            Expr::VlaBase { ptr_slot, .. } => Ok(b.load_local(*ptr_slot, LoadKind::I64)),
            // C99 6.5.3.4p2: `sizeof <vla>` is the runtime byte count
            // the matching `Decl::Vla` stored into `size_slot`.
            Expr::VlaSizeof { size_slot } => Ok(b.load_local(*size_slot, LoadKind::I64)),
            Expr::CompoundLiteral {
                slot_off,
                ty,
                array_size,
                init,
            } => self.walk_compound_literal(b, *slot_off, *ty, *array_size, init),
            Expr::Comma { lhs, rhs, .. } => {
                let _ = self.walk_expr_rvalue(b, *lhs)?;
                self.walk_expr_rvalue(b, *rhs)
            }
            // GCC statement expression `({ ... })`: emit the block for
            // its side effects; the value is that of the last
            // expression-statement the source wrote.
            Expr::StmtExpr {
                block, value_item, ..
            } => {
                let (block, value_item) = (*block, *value_item);
                self.walk_stmt_expr(b, block, value_item)
            }
            // GCC `__builtin_mem*` with a constant byte count.
            Expr::MemTransfer {
                op,
                dst,
                src,
                size,
                align,
                ..
            } => {
                let (op, dst, src, size, align) = (*op, *dst, *src, *size, *align);
                self.walk_mem_transfer(b, op, dst, src, size, align)
            }
            // GCC `__builtin_{add,sub,mul}_overflow(a, b, dst)`.
            Expr::CheckedArith {
                op,
                a,
                b: rhs,
                dst,
                elem_ty,
                ..
            } => {
                let (op, a, rhs, dst, elem_ty) = (*op, *a, *rhs, *dst, *elem_ty);
                self.walk_checked_arith(b, op, a, rhs, dst, elem_ty)
            }
            Expr::X86Simd { op, args, imm, .. } => {
                let (op, imm) = (*op, *imm);
                let args = args.clone();
                self.walk_x86_simd(b, op, &args, imm)
            }
            // A short-circuit in value position: the result is used, so
            // normalize it to 0/1.
            Expr::ShortCircuit { .. } => self.walk_short_circuit(b, id, true),
            Expr::Intrinsic { kind, args, .. } => self.walk_intrinsic(b, *kind, args),
            Expr::InlineAsm(idx) => self.walk_inline_asm(b, *idx),
            Expr::LabelAddr(label) => {
                // GCC `&&label`: materialize the address of the label's
                // block as a code pointer. block_addr records the block
                // as a computed-goto successor.
                let blk = self.block_for_label(b, *label);
                Ok(b.block_addr(blk))
            }
            Expr::Atomic {
                kind,
                args,
                elem_ty,
                ..
            } => {
                let kind = *kind;
                let elem_ty = *elem_ty;
                let args = args.clone();
                self.walk_atomic(b, kind, &args, elem_ty)
            }
        }
    }

    /// Walk an expression in lvalue position -- the result is the
    /// `ValueId` of the lvalue's *address*. The `Assign` rhs and
    /// `Unary{AddrOf}` cases drive into this path; the rvalue
    /// walker re-enters from this address with a matching load.
    pub(super) fn walk_expr_lvalue(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
    ) -> Result<ValueId, WalkError> {
        match self.ast.expr(id) {
            Expr::Ident { .. } => self.ident_address(b, id),
            Expr::Unary {
                op: UnOp::Deref,
                child,
                ..
            } => self.walk_expr_rvalue(b, *child),
            // `t->f = v` lowers to `*(t + field_off) = v` with the
            // Deref absorbed into the address expression, so the lhs
            // arrives as `Binary{Add, t, off}` whose value is the
            // address (C99 6.5.6).
            Expr::Binary { .. } => self.walk_expr_rvalue(b, id),
            // `arr[i] = v`: the address, without the load the rvalue
            // path would append.
            Expr::Index { array, idx, .. } => {
                let (array_id, idx_id) = (*array, *idx);
                let arr = self.walk_expr_rvalue(b, array_id)?;
                let i = self.walk_expr_rvalue(b, idx_id)?;
                // The constant-index fold of the rvalue path.
                match b.peek_imm(i) {
                    Some(k) => Ok(b.binop_imm(BinOp::Add, arr, k)),
                    None => Ok(b.binop(BinOp::Add, arr, i)),
                }
            }
            // `s.f = v`: the object's address plus the field offset.
            Expr::Member { obj, field_off, .. } => {
                let obj_id = *obj;
                let off = *field_off;
                let base = self.walk_expr_rvalue(b, obj_id)?;
                if off != 0 {
                    Ok(b.binop_imm(BinOp::Add, base, off))
                } else {
                    Ok(base)
                }
            }
            // C99 6.5.2.5p4: a compound literal names an unnamed
            // object, so in lvalue position the initializer runs into
            // the reserved slot and the slot's address is the value.
            Expr::CompoundLiteral {
                slot_off, ty, init, ..
            } => {
                let (slot, ty, init) = (*slot_off, *ty, init.clone());
                self.emit_local_init(b, slot, ty, &init)?;
                Ok(b.local_addr(slot))
            }
            other => Err(WalkError::InvalidExpr {
                id,
                kind: lvalue_shape_label(other),
            }),
        }
    }

    /// Fold `id` to a compile-time integer constant when it is an
    /// integer constant expression evaluable without runtime state (C99
    /// 6.6); `None` for an operand needing a load or a call, or an
    /// operator outside the handled set. Identifiers are not resolved,
    /// so only literal-rooted expressions fold. This selects the live
    /// arm of a constant-condition `?:` or `if`.
    pub(super) fn const_fold_int(&self, id: ExprId) -> Option<i64> {
        match self.ast.expr(id) {
            Expr::IntLit { val, .. } => Some(*val),
            Expr::Unary { op, child, .. } => {
                let v = self.const_fold_int(*child)?;
                match op {
                    UnOp::Neg => Some(v.wrapping_neg()),
                    UnOp::BitNot => Some(!v),
                    UnOp::LogNot => Some((v == 0) as i64),
                    UnOp::AddrOf | UnOp::Deref => None,
                }
            }
            Expr::Binary { op, lhs, rhs, .. } => {
                if is_comparison_op(*op)
                    && let Some(v) = self.const_fold_addr_cmp(*op, *lhs, *rhs)
                {
                    return Some(v);
                }
                // Integer `/` and `%` are constant expressions (C99
                // 6.6) that `imm_safe_binop` excludes, having no
                // immediate form. A zero divisor is undefined, so it is
                // not a constant.
                let divmod = matches!(*op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu);
                if !imm_safe_binop(*op) && !divmod {
                    return None;
                }
                let l = self.const_fold_int(*lhs)?;
                let r = self.const_fold_int(*rhs)?;
                if divmod && r == 0 {
                    return None;
                }
                Some(fold_int_binop(*op, l, r))
            }
            Expr::ShortCircuit { op, lhs, rhs, .. } => {
                let l = self.const_fold_int(*lhs)?;
                match op {
                    ShortCircuitOp::Lan if l == 0 => Some(0),
                    ShortCircuitOp::Lan => Some((self.const_fold_int(*rhs)? != 0) as i64),
                    ShortCircuitOp::Lor if l != 0 => Some(1),
                    ShortCircuitOp::Lor => Some((self.const_fold_int(*rhs)? != 0) as i64),
                }
            }
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                elvis,
                ..
            } => {
                let c = self.const_fold_int(*cond)?;
                if *elvis {
                    if c != 0 {
                        Some(c)
                    } else {
                        self.const_fold_int(*else_e)
                    }
                } else if c != 0 {
                    self.const_fold_int(*then_e)
                } else {
                    self.const_fold_int(*else_e)
                }
            }
            Expr::Cast { child, to_ty } => {
                let v = self.const_fold_int(*child)?;
                let to = *to_ty;
                if is_floating_scalar(to) {
                    return None;
                }
                if is_bool_scalar(to) {
                    return Some((v != 0) as i64);
                }
                if type_size_bytes(to, self.target) == 0 {
                    return None;
                }
                Some(narrow_const_to_ty(v, to, self.target))
            }
            // Without the SSA folds the answer is 0, which the
            // dead-branch fold reads as a constant condition; under `-O`
            // it is not yet known and the branch stays.
            Expr::Intrinsic { kind, .. }
                if *kind == Intrinsic::ConstantP as i64 && !self.optimize =>
            {
                Some(0)
            }
            _ => None,
        }
    }

    /// Fold `lhs op rhs` when both are address constants over the same
    /// object: C99 6.5.8p5 / 6.5.9p6 make that the comparison of their
    /// offsets, which is fixed at translation time even though the
    /// object's address is not. Addresses over different objects are
    /// left alone, their relative order being the data layout's choice.
    ///
    /// An address constant against a null pointer constant folds for
    /// equality only. C99 6.3.2.3p3 guarantees an object or function
    /// address compares unequal to null, provided the symbol is defined
    /// in this unit and not weak -- an undefined or weak reference may
    /// bind to address zero -- and provided the offset is zero, since a
    /// converted address plus an integer may wrap.
    fn const_fold_addr_cmp(&self, op: BinOp, lhs: ExprId, rhs: ExprId) -> Option<i64> {
        let (l, r) = match (self.addr_const_value(lhs), self.addr_const_value(rhs)) {
            (Some(l), Some(r)) => (l, r),
            (Some(a), None) if self.const_fold_int(rhs) == Some(0) => {
                return self.fold_addr_vs_null(op, a);
            }
            (None, Some(a)) if self.const_fold_int(lhs) == Some(0) => {
                return self.fold_addr_vs_null(op, a);
            }
            _ => return None,
        };
        if l.base != r.base {
            return None;
        }
        // The base cancels, so the addresses order as their offsets do
        // as integers; the unsigned pointer comparisons would wrap on a
        // negative offset.
        let signed = match op {
            BinOp::Ult => BinOp::Lt,
            BinOp::Ugt => BinOp::Gt,
            BinOp::Ule => BinOp::Le,
            BinOp::Uge => BinOp::Ge,
            BinOp::Eq | BinOp::Ne | BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge => op,
            _ => return None,
        };
        Some(fold_int_binop(signed, l.off, r.off))
    }

    /// The `addr == null` / `addr != null` arm of the fold above.
    fn fold_addr_vs_null(&self, op: BinOp, a: AddrConst) -> Option<i64> {
        if !matches!(op, BinOp::Eq | BinOp::Ne) || a.off != 0 {
            return None;
        }
        let nonnull = self
            .symbols
            .get(a.base.0 as usize)
            .is_some_and(|s| s.defined_here && !s.is_weak);
        nonnull.then_some((op == BinOp::Ne) as i64)
    }

    /// The value of `id` as an address constant (C99 6.6p9), or None
    /// when it is not one. Casts that keep the whole address pass
    /// through; a narrowing cast does not.
    fn addr_const_value(&self, id: ExprId) -> Option<AddrConst> {
        match self.ast.expr(id) {
            Expr::Unary {
                op: UnOp::AddrOf,
                child,
                ..
            } => self.addr_const_object(*child),
            // An array designator's value is its own address.
            Expr::Ident { array_size, .. } | Expr::Member { array_size, .. }
                if *array_size != 0 =>
            {
                self.addr_const_object(id)
            }
            // A function designator's value is the function's address
            // (C99 6.3.2.1p4).
            Expr::Ident { class, .. } if *class == Token::Fun as i64 => self.addr_const_object(id),
            Expr::Cast { child, to_ty } => {
                if type_size_bytes(*to_ty, self.target) < 8 || is_floating_scalar(*to_ty) {
                    return None;
                }
                self.addr_const_value(*child)
            }
            Expr::Binary {
                op: op @ (BinOp::Add | BinOp::Sub),
                lhs,
                rhs,
                ..
            } => {
                // The parser has already scaled the integer operand to
                // bytes, so it adds to the offset unchanged.
                if let Some(mut base) = self.addr_const_value(*lhs) {
                    let k = self.const_fold_int(*rhs)?;
                    base.off = if *op == BinOp::Add {
                        base.off.wrapping_add(k)
                    } else {
                        base.off.wrapping_sub(k)
                    };
                    return Some(base);
                }
                if *op != BinOp::Add {
                    return None;
                }
                let mut base = self.addr_const_value(*rhs)?;
                base.off = base.off.wrapping_add(self.const_fold_int(*lhs)?);
                Some(base)
            }
            _ => None,
        }
    }

    /// The address of the lvalue `id` as an address constant. Only an
    /// object with static storage duration has one: a frame slot's
    /// address is not fixed at translation time, and a thread-local's
    /// resolves through the TLS block.
    fn addr_const_object(&self, id: ExprId) -> Option<AddrConst> {
        match self.ast.expr(id) {
            Expr::Ident {
                sym,
                class,
                val,
                is_thread_local,
                ..
            } => {
                if (*class != Token::Glo as i64 && *class != Token::Fun as i64) || *is_thread_local
                {
                    return None;
                }
                // A shadowed name reuses its symbol table entry, so the
                // parse-time data offset (or a function's entry PC) is
                // what pins the object this identifier named.
                Some(AddrConst {
                    base: (*sym, *val),
                    off: 0,
                })
            }
            Expr::Member {
                obj,
                field_off,
                bitfield,
                ..
            } => {
                if bitfield.is_some() {
                    return None;
                }
                // `p->f` loads `p`; only `s.f` keeps a constant base.
                if is_pointer_ty(expr_ty(self.ast.expr(*obj))?) {
                    return None;
                }
                let mut base = self.addr_const_object(*obj)?;
                base.off = base.off.wrapping_add(*field_off);
                Some(base)
            }
            Expr::Index { array, idx, .. } => {
                let mut base = self.addr_const_value(*array)?;
                base.off = base.off.wrapping_add(self.const_fold_int(*idx)?);
                Some(base)
            }
            // `&*p` is `p` -- no load runs.
            Expr::Unary {
                op: UnOp::Deref,
                child,
                ..
            } => self.addr_const_value(*child),
            _ => None,
        }
    }

    /// Convert an already-evaluated scalar value from `src_ty` to
    /// `to_ty` (C99 6.3.1). Shared by the `Cast` lowering and the GNU
    /// `?:` then-arm, which reuses the condition's value.
    pub(super) fn convert_scalar_value(
        &mut self,
        b: &mut SsaBuilder,
        v: ValueId,
        src_ty: i64,
        to_ty: i64,
    ) -> ValueId {
        let target_is_fp = is_floating_scalar(to_ty);
        let source_is_fp = is_floating_scalar(src_ty);
        // C99 6.3.1.2: a conversion to `_Bool` yields 0 when the source
        // compares equal to 0, else 1. This holds for every scalar
        // source, so it precedes the width/fp-ness conversions below.
        if is_bool_scalar(to_ty) {
            if source_is_fp {
                let d = b.fp_widen_to_f64(v);
                let zero = b.imm(0);
                return b.binop(BinOp::Fne, d, zero);
            }
            return b.binop_imm(BinOp::Ne, v, 0);
        }
        if target_is_fp && !source_is_fp {
            // Integer to FP (C99 6.3.1.4), one rounding to the target
            // type. An unsigned 64-bit source can exceed the signed
            // range, which the signed convert would render negative;
            // narrower unsigned types fit it zero-extended.
            let stripped = strip_unsigned(src_ty);
            let unsigned_64 = (src_ty & UNSIGNED_BIT) != 0
                && (stripped == Ty::Long as i64 || stripped == Ty::LongLong as i64);
            let to_float = is_float_ty(to_ty);
            // Fold a constant operand to the converted FP constant.
            if let Some(k) = b.peek_imm(v) {
                if to_float {
                    let f = if unsigned_64 {
                        k as u64 as f32
                    } else {
                        k as f32
                    };
                    return b.imm_f32(f.to_bits());
                }
                let d = if unsigned_64 {
                    k as u64 as f64
                } else {
                    k as f64
                };
                return b.imm(d.to_bits() as i64);
            }
            let kind = if unsigned_64 {
                FpCastKind::UIntToFp
            } else {
                FpCastKind::IntToFp
            };
            // A `float` target converts directly to single precision; a
            // `double` target stays f64.
            if to_float {
                return b.fp_cast_to_f32(kind, v);
            }
            return b.fp_cast(kind, v);
        } else if !target_is_fp && source_is_fp {
            // FP to integer (C99 6.3.1.4) truncates toward zero. An
            // unsigned 64-bit target holds values in [2^63, 2^64) that
            // the signed truncate saturates, so it takes the unsigned
            // converter, widening a `float` source to f64 for it.
            let stripped_to = strip_unsigned(to_ty);
            let target_unsigned_64 = (to_ty & UNSIGNED_BIT) != 0
                && (stripped_to == Ty::Long as i64 || stripped_to == Ty::LongLong as i64);
            if target_unsigned_64 {
                let d = b.fp_widen_to_f64(v);
                return b.fp_cast(FpCastKind::UFpToInt, d);
            }
            return b.fp_cast(FpCastKind::FpToInt, v);
        }
        // FP-to-FP cast (C99 6.3.1.5): `(double)f` widens, `(float)d`
        // narrows; a no-op when the source already has the target width.
        if target_is_fp && source_is_fp {
            if is_float_ty(to_ty) {
                return b.fp_narrow_to_f32(v);
            }
            return b.fp_widen_to_f64(v);
        }
        // Integer-to-integer cast (C99 6.3.1.3): narrow to the target
        // storage width, sign- or zero-extending per the target's sign.
        self.narrow_int_to_ty(b, v, src_ty, to_ty)
    }
}
