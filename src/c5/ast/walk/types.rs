//! Type queries over the walker's type tags, and the constant
//! arithmetic that follows them.

use super::*;

impl<'a> Walker<'a> {
    /// Byte size of the struct type encoded by `ty`. Looks up
    /// the struct id (via the same band scheme the parser uses)
    /// in the propagated `structs` slice. Returns 0 when the
    /// struct id is out of range (defensive -- the parser
    /// shouldn't emit such a type).
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

    /// Alignment of the struct type encoded by `ty`, for the `Inst::Mcpy`
    /// transfer-width bound. Falls back to 1 -- the alignment every
    /// object satisfies -- when the id is out of range or the layout has
    /// not been finished, so a lookup miss cannot claim more than the
    /// C99 6.2.8 minimum.
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

    /// True when `ty` is the GCC 128-bit `__int128` as a value (not a
    /// pointer to one). It shares the struct machinery but a cast to or
    /// from a scalar converts the 128-bit value, unlike a plain struct
    /// whose value in a scalar context is just its address.
    pub(super) fn is_int128_value_ty(&self, ty: i64) -> bool {
        let stripped = strip_unsigned(ty);
        if stripped < STRUCT_BASE || struct_ptr_depth(ty) != 0 {
            return false;
        }
        let id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
        self.structs.get(id).is_some_and(|s| s.name == "__int128")
    }
}

/// True for a relational or equality operator (integer or
/// floating-point). The result is `int` (C99 6.5.8 / 6.5.9) regardless
/// of operand type.
pub(crate) fn is_comparison_op(op: BinOp) -> bool {
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
            | BinOp::Feq
            | BinOp::Fne
            | BinOp::Flt
            | BinOp::Fgt
            | BinOp::Fle
            | BinOp::Fge
    )
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

/// Sign- or zero-extend a scalar call result to the full 64-bit
/// accumulator per its declared return type. A c5-compiled callee
/// already returns a 64-bit-correct value, and a direct libc call
/// (`Inst::CallExt`) is widened in the emitter from the binding's
/// return type. A call through a function pointer to a host library
/// routine has neither: the routine leaves only its natural-width
/// register set (`strcmp` returns a 32-bit result in `eax` with
/// undefined high bits), so a call through an `int (*)()` pointer
/// must widen the result before the caller reads it at 64 bits
/// (C99 6.3.1.1 / 6.5.2.2). Idempotent for an already-extended
/// value. Floating-point, pointer, `_Bool`, struct, and full-width
/// integer results are left unchanged.
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
    // A `_Bool` return is defined only in the low byte per the psABI
    // (a callee compiled by another toolchain may leave garbage in the
    // high bits, e.g. `sete %al` with no zero-extend). Zero-extend it
    // like an unsigned char so a full-width test / `!` reads 0 or 1.
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
        Expr::IntLit { ty, .. }
        | Expr::FloatLit { ty, .. }
        | Expr::StrLit { ty, .. }
        | Expr::Ident { ty, .. }
        | Expr::Unary { ty, .. }
        | Expr::Binary { ty, .. }
        | Expr::Ternary { ty, .. }
        | Expr::Call { ty, .. }
        | Expr::Member { ty, .. }
        | Expr::Index { ty, .. }
        | Expr::Assign { ty, .. }
        | Expr::BitfieldAssign { ty, .. }
        | Expr::CompoundAssign { ty, .. }
        | Expr::PreInc { ty, .. }
        | Expr::PostInc { ty, .. }
        | Expr::Comma { ty, .. }
        | Expr::ShortCircuit { ty, .. }
        | Expr::Intrinsic { ty, .. }
        | Expr::Atomic { ty, .. }
        | Expr::VlaBase { ty, .. }
        | Expr::StmtExpr { ty, .. }
        | Expr::CheckedArith { ty, .. }
        | Expr::X86Simd { ty, .. }
        | Expr::MemTransfer { ty, .. } => Some(*ty),
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

/// The type an expression contributes as a call argument (C99
/// 6.5.2.2p6/p7: the argument's converted type). An array-typed
/// compound literal decays to a pointer to its first element (C99
/// 6.3.2.1p3); its element type must not classify the argument as a
/// by-value aggregate or as a floating-point scalar. `Expr::Ident`
/// and `Expr::Member` already carry the decayed type. Other shapes
/// keep [`expr_ty`].
pub(crate) fn arg_value_ty(e: &Expr) -> Option<i64> {
    match e {
        Expr::CompoundLiteral { ty, array_size, .. } if *array_size != 0 => {
            Some(*ty + crate::c5::token::Ty::Ptr as i64)
        }
        _ => expr_ty(e),
    }
}

/// Byte size of a C type tag at the active target. Mirrors
/// `compiler::types::size_of_type` for the scalar / pointer / FP
/// cases the walker handles. Returns 0 for types whose width
/// the walker can't compute (struct types, function types -- the
/// walker doesn't currently consume those in cast positions).
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

/// Return the AND mask needed to narrow an unsigned-typed
/// operand of an integer divide / modulo to its declared storage
/// width. Returns `0` (no mask) for I64-wide types and for any
/// signed type. Takes only the common type tag and lets the
/// walker apply the mask through `BinopI(And, _, mask)`.
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

/// Ops whose two-constant fold and per-arch `BinopI` immediate
/// lowering are both defined: arithmetic, bitwise, shift, and
/// integer comparison. Excludes Div / Divu / Mod / Modu (which
/// `fold_int_binop` evaluates but the immediate path does not
/// cover) and every FP op.
pub(crate) fn imm_safe_binop(op: BinOp) -> bool {
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
            | BinOp::Eq
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

/// Fold an integer binop on two constant operands. C99 6.6
/// permits this at translation time. Covers arithmetic, bitwise,
/// shift, integer comparison, and integer divide / modulo; FP
/// and the non-integer opcodes are rejected. A zero divisor is
/// the caller's responsibility (`const_fold_int` declines it);
/// signed `INT_MIN / -1` wraps to `INT_MIN` rather than trapping.
/// Shifts at out-of-range amounts produce 0 (matches what `lsl
/// xd, xn, xm` with `xm >= 64` would land on; signed `asr` on a
/// non-negative operand likewise saturates to 0, and on a
/// negative operand to -1, so the model picks the closer of the
/// two for the rhs's sign).
pub(crate) fn fold_int_binop(op: BinOp, lhs: i64, rhs: i64) -> i64 {
    match op {
        BinOp::Add => lhs.wrapping_add(rhs),
        BinOp::Sub => lhs.wrapping_sub(rhs),
        BinOp::Mul => lhs.wrapping_mul(rhs),
        BinOp::And => lhs & rhs,
        BinOp::Or => lhs | rhs,
        BinOp::Xor => lhs ^ rhs,
        BinOp::Shl => {
            let s = rhs as u32 & 63;
            ((lhs as u64) << s) as i64
        }
        BinOp::Shr => {
            let s = rhs as u32 & 63;
            lhs >> s
        }
        BinOp::Shru => {
            let s = rhs as u32 & 63;
            ((lhs as u64) >> s) as i64
        }
        BinOp::Eq => (lhs == rhs) as i64,
        BinOp::Ne => (lhs != rhs) as i64,
        BinOp::Lt => (lhs < rhs) as i64,
        BinOp::Gt => (lhs > rhs) as i64,
        BinOp::Le => (lhs <= rhs) as i64,
        BinOp::Ge => (lhs >= rhs) as i64,
        BinOp::Ult => ((lhs as u64) < (rhs as u64)) as i64,
        BinOp::Ugt => ((lhs as u64) > (rhs as u64)) as i64,
        BinOp::Ule => ((lhs as u64) <= (rhs as u64)) as i64,
        BinOp::Uge => ((lhs as u64) >= (rhs as u64)) as i64,
        BinOp::Div => lhs.wrapping_div(rhs),
        BinOp::Mod => lhs.wrapping_rem(rhs),
        BinOp::Divu => ((lhs as u64) / (rhs as u64)) as i64,
        BinOp::Modu => ((lhs as u64) % (rhs as u64)) as i64,
        _ => unreachable!("fold_int_binop reached on a non-integer op"),
    }
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
