//! Type queries over the walker's type tags, and the constant
//! arithmetic that follows them.

use super::*;
use crate::c5::ast::expr_ty;

impl<'a> Walker<'a> {
    /// Byte size of the struct type encoded by `ty`, looked up by the
    /// struct id the parser's band scheme gives it. Zero when that id
    /// is out of range.
    pub(super) fn struct_size(&self, ty: i64) -> i64 {
        let stripped = strip_unsigned(ty);
        if stripped < STRUCT_BASE {
            return 0;
        }
        let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
        if id < self.structs.len() {
            self.structs[id].size as i64
        } else {
            0
        }
    }

    /// Alignment of the struct type encoded by `ty`, bounding the
    /// `Inst::Mcpy` transfer width. A lookup miss or an unfinished
    /// layout falls back to 1, the C99 6.2.8 minimum every object
    /// satisfies, rather than claiming more.
    pub(super) fn struct_align(&self, ty: i64) -> u32 {
        self.struct_align_opt(ty).unwrap_or(1)
    }

    /// [`Self::struct_align`] without the fallback: `None` when `ty`
    /// names no struct or its layout is unfinished. Resolves a pointer
    /// to a struct to the same id, so `p->f` and `s.f` agree.
    pub(super) fn struct_align_opt(&self, ty: i64) -> Option<u32> {
        let stripped = strip_unsigned(ty);
        if stripped < STRUCT_BASE {
            return None;
        }
        let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
        match self.structs.get(id) {
            Some(s) if s.align > 0 => Some(s.align as u32),
            _ => None,
        }
    }

    /// True when `ty` is the GCC 128-bit `__int128` as a value, not a
    /// pointer to one. It shares the struct machinery, but a cast to or
    /// from a scalar converts the value rather than passing an
    /// address.
    pub(super) fn is_int128_value_ty(&self, ty: i64) -> bool {
        let stripped = strip_unsigned(ty);
        if stripped < STRUCT_BASE || struct_ptr_depth(ty) != 0 {
            return false;
        }
        let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
        self.structs.get(id).is_some_and(|s| s.name == "__int128")
    }
}

/// Test for floating-point scalar types.
pub(super) fn is_floating_scalar(ty: i64) -> bool {
    let stripped = strip_unsigned(ty);
    stripped == Ty::Float as i64 || stripped == Ty::Double as i64
}

/// True for the scalar `float` type. C99 6.3.1.8 leaves `float op
/// float` at type `float` (single precision); the walker tags the
/// result and feeds the single-precision codegen path.
pub(super) fn is_float_ty(ty: i64) -> bool {
    strip_unsigned(ty) == Ty::Float as i64
}

/// True for the scalar `_Bool` type (not a pointer to one). Used by
/// the cast lowering to apply the C99 6.3.1.2 conversion (any
/// nonzero scalar becomes 1).
pub(super) fn is_bool_scalar(ty: i64) -> bool {
    strip_unsigned(ty) == Ty::Bool as i64
}

/// Sign- or zero-extend a scalar call result to 64 bits per its
/// declared return type. A sub-word integer return occupies the low
/// bits of the return register and leaves the rest unspecified (System
/// V AMD64 3.2.3, AAPCS64 6.9, Win64), so the reading side widens it
/// before a 64-bit consumer sees it (C99 6.3.1.1 / 6.5.2.2). A direct
/// libc call takes the emitter's widening from the binding's return
/// type instead. Idempotent, and inert on void, floating-point,
/// pointer, `_Bool`, struct and full-width results.
pub(super) fn extend_scalar_call_result(
    b: &mut SsaBuilder,
    v: ValueId,
    ty: i64,
    target: Target,
) -> ValueId {
    let stripped = strip_unsigned(ty);
    let rs = type_size_bytes(ty, target);
    if is_void_ty(ty)
        || is_floating_scalar(ty)
        || is_pointer_ty(ty)
        || !(rs == 1 || rs == 2 || rs == 4)
    {
        return v;
    }
    // The psABI defines a `_Bool` return only in the low byte, so a
    // callee from another toolchain may leave garbage above it.
    // Zero-extending as an unsigned char makes a full-width test read
    // 0 or 1.
    if (ty & UNSIGNED_BIT) != 0 || stripped == Ty::Bool as i64 {
        let mask: i64 = match rs {
            1 => 0xff,
            2 => 0xffff,
            _ => 0xffff_ffff,
        };
        b.binop_imm(BinOp::And, v, mask)
    } else {
        b.extend(v, sign_extend_kind(rs))
    }
}

/// The width `Inst::Call::arg_widths` records for an argument of type `ty`:
/// its size below 8 bytes, as the default argument promotions leave it when
/// `promoted` (C99 6.5.2.2p6).
pub(super) fn arg_width(ty: i64, target: Target, promoted: bool) -> u32 {
    if is_pointer_ty(ty) {
        return 8;
    }
    if is_float_ty(ty) {
        return if promoted { 8 } else { 4 };
    }
    match type_size_bytes(ty, target) {
        n @ 1..=4 if !is_floating_scalar(ty) => {
            if promoted {
                4
            } else {
                n as u32
            }
        }
        _ => 8,
    }
}

/// Whether a parameter of type `ty` is read in the low 32 bits alone
/// (`Inst::Call::low_word_args`).
pub(super) fn low_word_param(ty: i64, target: Target) -> bool {
    !is_floating_scalar(ty) && !is_pointer_ty(ty) && matches!(type_size_bytes(ty, target), 1..=4)
}

/// The `Inst::Extend` kind that sign-extends a `rs`-byte value.
/// Callers gate on `rs` being 1, 2 or 4.
pub(super) fn sign_extend_kind(rs: usize) -> crate::c5::ir::LoadKind {
    use crate::c5::ir::LoadKind;
    match rs {
        1 => LoadKind::I8,
        2 => LoadKind::I16,
        _ => LoadKind::I32,
    }
}

/// The type an expression contributes as a call argument -- its
/// converted type (C99 6.5.2.2p6/p7). An array-typed compound literal
/// decays to a pointer to its first element (C99 6.3.2.1p3), so its
/// element type must not classify the argument as a by-value aggregate
/// or a floating-point scalar; `Expr::Ident` and `Expr::Member` already
/// carry the decayed type.
pub(crate) fn arg_value_ty(e: &Expr) -> Option<i64> {
    match e {
        Expr::CompoundLiteral { ty, array_size, .. } if *array_size != 0 => {
            Some(*ty + crate::c5::token::Ty::Ptr as i64)
        }
        _ => expr_ty(e),
    }
}

/// The width in bits `op` divides at, the widest of `ty` and the operands';
/// `None` for no divide or a type wider than a register.
pub(super) fn divmod_operand_width(
    ast: &Ast,
    target: Target,
    op: BinOp,
    ty: i64,
    (lhs, rhs): (ExprId, ExprId),
) -> Option<u32> {
    if !matches!(op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu) {
        return None;
    }
    let sz = |id: ExprId| expr_ty(ast.expr(id)).map_or(8, |t| type_size_bytes(t, target));
    match type_size_bytes(ty, target).max(sz(lhs)).max(sz(rhs)) {
        0..=4 => Some(32),
        5..=8 => Some(64),
        _ => None,
    }
}

/// The mask an unsigned 32-bit compare, divide or modulo applies to its
/// operands, or 0: C99 6.3.1.8 converts a signed one to the unsigned type,
/// dropping the sign-extended high bits its register holds.
pub(super) fn const_operand_mask(
    ast: &Ast,
    target: Target,
    op: BinOp,
    ty: i64,
    (lhs, rhs): (ExprId, ExprId),
) -> i64 {
    if matches!(op, BinOp::Divu | BinOp::Modu) {
        return match divmod_operand_width(ast, target, op, ty, (lhs, rhs)) {
            Some(32) => 0xffff_ffff,
            _ => 0,
        };
    }
    if !matches!(op, BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge) {
        return 0;
    }
    let needs = |id: ExprId| -> (bool, usize) {
        let e = ast.expr(id);
        let ty = expr_ty(e);
        let sz = ty.map_or(8, |t| type_size_bytes(t, target));
        let signed = ty.is_some_and(|t| t & UNSIGNED_BIT == 0);
        let nonneg_lit = matches!(e, Expr::IntLit { val, .. } if *val >= 0);
        (signed && !nonneg_lit, sz)
    };
    let (l_needs, lsz) = needs(lhs);
    let (r_needs, rsz) = needs(rhs);
    if lsz <= 4 && rsz <= 4 && (l_needs || r_needs) {
        0xffff_ffffi64
    } else {
        0
    }
}

/// Integer `op` at type `ty` over operand constants read as `op` reads them.
pub(crate) fn fold_const_int_binop(
    ast: &Ast,
    target: Target,
    op: BinOp,
    ty: i64,
    (lhs, l): (ExprId, i64),
    (rhs, r): (ExprId, i64),
) -> Option<i64> {
    let m = const_operand_mask(ast, target, op, ty, (lhs, rhs));
    let (l, r) = if m == 0 { (l, r) } else { (l & m, r & m) };
    crate::c5::ir::eval_int_binop(op, l, r).ok()
}

/// Byte size of a C type tag at the active target, mirroring
/// `compiler::types::size_of_type` over the scalar, pointer and FP
/// cases. Zero for a width the walker does not compute -- a struct or
/// function type, which it does not consume in a cast position.
pub(super) fn type_size_bytes(ty: i64, target: Target) -> usize {
    let stripped = strip_unsigned(ty);
    if is_pointer_ty(ty) {
        return 8;
    }
    if stripped == Ty::Bool as i64 || stripped == Ty::Char as i64 {
        1
    } else if stripped == Ty::Short as i64 {
        2
    } else if stripped == Ty::Int as i64 || stripped == Ty::Float as i64 {
        4
    } else if stripped == Ty::Double as i64 {
        8
    } else if stripped == Ty::Long as i64 {
        if target.is_windows() { 4 } else { 8 }
    } else if stripped == Ty::LongLong as i64 {
        8
    } else {
        0
    }
}

/// Narrow a folded integer constant to the storage width and
/// signedness of `ty` (C99 6.3.1.3). Widths above 4 bytes and
/// types `type_size_bytes` can't size keep the full 64-bit value.
pub(super) fn narrow_const_to_ty(v: i64, ty: i64, target: Target) -> i64 {
    let unsigned = (ty & UNSIGNED_BIT) != 0;
    match type_size_bytes(ty, target) {
        1 => {
            if unsigned {
                v as u8 as i64
            } else {
                v as i8 as i64
            }
        }
        2 => {
            if unsigned {
                v as u16 as i64
            } else {
                v as i16 as i64
            }
        }
        4 => {
            if unsigned {
                v as u32 as i64
            } else {
                v as i32 as i64
            }
        }
        _ => v,
    }
}

/// Fold an integer binop on two constant operands, which C99 6.6 permits
/// at translation time. The semantics are `ir::eval_int_binop`'s; a zero
/// divisor is the caller's to exclude and panics here.
pub(crate) fn fold_int_binop(op: BinOp, lhs: i64, rhs: i64) -> i64 {
    crate::c5::ir::eval_int_binop(op, lhs, rhs).expect("fold_int_binop reached with a zero divisor")
}

pub(super) fn lvalue_shape_label(expr: &Expr) -> &'static str {
    match expr {
        Expr::IntLit { .. } => "IntLit",
        Expr::FloatLit { .. } => "FloatLit",
        Expr::StrLit { .. } => "StrLit",
        Expr::Ident { .. } => "Ident",
        Expr::Unary { .. } => "Unary",
        Expr::Binary { .. } => "Binary",
        Expr::Ternary { .. } => "Ternary",
        Expr::Call { .. } => "Call",
        Expr::Member { .. } => "Member",
        Expr::Index { .. } => "Index",
        Expr::Cast { .. } => "Cast",
        Expr::Assign { .. } => "Assign",
        Expr::BitfieldAssign { .. } => "BitfieldAssign",
        Expr::CompoundAssign { .. } => "CompoundAssign",
        Expr::PreInc { .. } => "PreInc",
        Expr::PostInc { .. } => "PostInc",
        Expr::Sizeof(_) => "Sizeof",
        Expr::CompoundLiteral { .. } => "CompoundLiteral",
        Expr::Comma { .. } => "Comma",
        Expr::Intrinsic { .. } => "Intrinsic",
        Expr::ShortCircuit { .. } => "ShortCircuit",
        Expr::Atomic { .. } => "Atomic",
        Expr::LabelAddr(_) => "LabelAddr",
        Expr::VlaBase { .. } => "VlaBase",
        Expr::VlaSizeof { .. } => "VlaSizeof",
        Expr::StmtExpr { .. } => "StmtExpr",
        Expr::CheckedArith { .. } => "CheckedArith",
        Expr::X86Simd { .. } => "X86Simd",
        Expr::MsIntrinsic { .. } => "MsIntrinsic",
        Expr::MemTransfer { .. } => "MemTransfer",
        Expr::InlineAsm(_) => "InlineAsm",
    }
}
