//! Type queries over the walker's type tags, and the constant
//! arithmetic that follows them.

use super::super::plain_ty_expr;
use super::*;

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

/// Integer relational and equality operators (C99 6.5.8 / 6.5.9),
/// signed and unsigned.
pub(crate) fn is_int_comparison_op(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Eq
            | BinOp::Ne
            | BinOp::Lt
            | BinOp::Gt
            | BinOp::Le
            | BinOp::Ge
            | BinOp::Ult
            | BinOp::Ugt
            | BinOp::Ule
            | BinOp::Uge
    )
}

/// Floating-point relational and equality operators (C99 6.5.8 /
/// 6.5.9).
pub(crate) fn is_fp_comparison_op(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Feq | BinOp::Fne | BinOp::Flt | BinOp::Fgt | BinOp::Fle | BinOp::Fge
    )
}

/// Floating-point arithmetic operators (C99 6.5.5 / 6.5.6).
pub(crate) fn is_fp_arith_op(op: BinOp) -> bool {
    matches!(op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv)
}

/// True for a relational or equality operator (integer or
/// floating-point). The result is `int` (C99 6.5.8 / 6.5.9) regardless
/// of operand type.
pub(crate) fn is_comparison_op(op: BinOp) -> bool {
    is_int_comparison_op(op) || is_fp_comparison_op(op)
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
/// declared return type. A c5-compiled callee already returns a
/// 64-bit-correct value and the emitter widens a direct libc call from
/// the binding's return type, but a call through a function pointer to
/// a host routine has neither: the routine sets only its natural-width
/// register (`strcmp` returns 32 bits in `eax` with undefined high
/// bits), so the result widens here before the caller reads it at 64
/// bits (C99 6.3.1.1 / 6.5.2.2). Idempotent, and inert on
/// floating-point, pointer, `_Bool`, struct and full-width results.
pub(super) fn extend_scalar_call_result(
    b: &mut SsaBuilder,
    v: ValueId,
    ty: i64,
    target: Target,
) -> ValueId {
    let stripped = strip_unsigned(ty);
    let rs = type_size_bytes(ty, target);
    if is_floating_scalar(ty) || is_pointer_ty(ty) || !(rs == 1 || rs == 2 || rs == 4) {
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
        let bits = 64i64 - (rs as i64) * 8;
        let shifted = b.binop_imm(BinOp::Shl, v, bits);
        b.binop_imm(BinOp::Shr, shifted, bits)
    }
}

/// Read the type tag off an expression node. Returns `None` for
/// shapes that don't carry one (`Sizeof` is constant-evaluated
/// and the walker doesn't peek into the result; intrinsics carry
/// their own `ty`).
pub(crate) fn expr_ty(e: &Expr) -> Option<i64> {
    match e {
        plain_ty_expr!(ty) => Some(*ty),
        Expr::Cast { to_ty, .. } => Some(*to_ty),
        Expr::Sizeof(s) => Some(s.result_ty),
        // `sizeof <vla>` is a runtime `size_t`; c5 types it as `int`.
        Expr::VlaSizeof { .. } => Some(crate::c5::token::Ty::Int as i64),
        Expr::CompoundLiteral { ty, .. } => Some(*ty),
        // `&&label` is a `void *` (char-pointer encoding).
        Expr::LabelAddr(_) => {
            Some(crate::c5::token::Ty::Char as i64 + crate::c5::token::Ty::Ptr as i64)
        }
        // An asm statement carries no value type.
        Expr::InlineAsm(_) => None,
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

/// AND mask narrowing an unsigned operand of an integer divide or
/// modulo to its declared storage width. Zero -- no mask -- for an
/// I64-wide type and for any signed type.
pub(super) fn unsigned_narrow_mask(ty: i64) -> i64 {
    let stripped = strip_unsigned(ty);
    let unsigned = (ty & UNSIGNED_BIT) != 0;
    if !unsigned {
        return 0;
    }
    if stripped == Ty::Char as i64 {
        0xff
    } else if stripped == Ty::Short as i64 {
        0xffff
    } else if stripped == Ty::Int as i64 {
        0xffff_ffff
    } else {
        0
    }
}

/// Arithmetic, bitwise and shift operators the per-arch `BinopI`
/// immediate lowering covers. Excludes Div / Divu / Mod / Modu, which
/// `fold_int_binop` evaluates but the immediate path does not lower.
pub(crate) fn is_imm_arith_op(op: BinOp) -> bool {
    matches!(
        op,
        BinOp::Add
            | BinOp::Sub
            | BinOp::Mul
            | BinOp::And
            | BinOp::Or
            | BinOp::Xor
            | BinOp::Shl
            | BinOp::Shr
            | BinOp::Shru
    )
}

/// Ops whose two-constant fold and per-arch `BinopI` immediate
/// lowering are both defined.
pub(crate) fn imm_safe_binop(op: BinOp) -> bool {
    is_imm_arith_op(op) || is_int_comparison_op(op)
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
/// divisor is the caller's responsibility (`const_fold_int` declines it)
/// and panics here.
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
        Expr::MemTransfer { .. } => "MemTransfer",
        Expr::InlineAsm(_) => "InlineAsm",
    }
}
