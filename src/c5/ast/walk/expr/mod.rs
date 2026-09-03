//! Expression lowering (C99 6.5). This module dispatches on the node and
//! holds the shapes shared across the categories -- lvalues, the
//! scalar conversions, and constant folding; each category walks in its
//! own submodule.

mod binary;
mod cond;
mod primary;
mod unary;

use super::access::{
    load_kind_for, load_kind_width, load_place, store_kind_for, store_kind_width, store_place,
};
use super::builtin::{lower_clrsb, lower_clz, lower_ctz, lower_ffs, lower_popcount};
use super::types::{
    arg_value_ty, expr_ty, extend_scalar_call_result, fold_int_binop, imm_safe_binop,
    is_bool_scalar, is_comparison_op, is_float_ty, is_floating_scalar, lvalue_shape_label,
    narrow_const_to_ty, type_size_bytes, unsigned_narrow_mask,
};
use super::*;

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
                // C99 6.4.4.2: an `f`-suffixed constant has type `float`
                // and is represented in single precision. The lexer
                // records the f64 bit pattern; narrow it to the f32 bit
                // pattern (parked in the low 32 bits of the immediate)
                // and tag the value f32 so the codegen reinterprets it
                // through a 32-bit move. A `double` constant keeps its
                // f64 bits untagged.
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
            Expr::Binary { op, lhs, rhs, ty } => {
                // GCC vector extension: the parser tags a Binary node with a
                // vector type for the element-wise operators, including a
                // vector / scalar pair the scalar broadcasts across.
                if is_vector_ty(self.structs, *ty) {
                    return self.walk_vector_binop(b, *op, *lhs, *rhs, *ty);
                }
                // A 128-bit operand makes the node a 128-bit operation,
                // whatever the node's own type: a comparison's result is
                // `int`, and the parser spells the unary operators as a
                // binop against a literal.
                if self.is_int128_binary(*lhs, *rhs) {
                    return self.walk_int128_binary(b, *op, *lhs, *rhs);
                }
                // A comparison whose operand is a floating-point value must
                // use the FP comparison. The parser tags the op from the
                // operand types; when that tracking is clouded by the
                // surrounding expression it can emit the integer variant
                // against an operand that lowers to an FP register, which
                // the integer paths cannot compare. Re-derive the op from
                // the operand types so the FP path below handles it.
                let op_remapped = {
                    // An operand's value is floating-point when its node
                    // carries a floating type tag -- except a comparison,
                    // whose result is `int` even though its node may carry
                    // the operand type. Treat a comparison operand as int.
                    let operand_is_fp = |id: ExprId| -> bool {
                        let e = self.ast.expr(id);
                        if let Expr::Binary { op, .. } = e
                            && is_comparison_op(*op)
                        {
                            return false;
                        }
                        expr_ty(e).is_some_and(is_floating_scalar)
                    };
                    let lhs_fp = operand_is_fp(*lhs);
                    let rhs_fp = operand_is_fp(*rhs);
                    if lhs_fp || rhs_fp {
                        match *op {
                            BinOp::Eq => BinOp::Feq,
                            BinOp::Ne => BinOp::Fne,
                            BinOp::Lt => BinOp::Flt,
                            BinOp::Gt => BinOp::Fgt,
                            BinOp::Le => BinOp::Fle,
                            BinOp::Ge => BinOp::Fge,
                            other => other,
                        }
                    } else {
                        *op
                    }
                };
                let op = &op_remapped;
                let mask = unsigned_narrow_mask(*ty);
                let needs_divmod_mask = mask != 0 && matches!(*op, BinOp::Divu | BinOp::Modu);
                // An unsigned relational compare at a common type narrower
                // than the register where one operand is signed: the signed
                // operand carries its sign-extended high bits in the 64-bit
                // register, but C99 6.3.1.8 converts it to the unsigned
                // common type (zero-extended), so those bits must be cleared
                // or the unsigned compare reads a huge value. The common
                // type is unsigned (the front end picked the U-op) and
                // 4-byte unless an operand is 8 bytes, in which case the
                // value already fills the register. Two unsigned operands
                // are already zero-extended and need no mask. Mask both
                // operands to the common width.
                let cmp_mask = if matches!(*op, BinOp::Ult | BinOp::Ugt | BinOp::Ule | BinOp::Uge) {
                    // An operand carries sign-extended high bits only when it
                    // is signed and not a non-negative literal: an unsigned
                    // operand is zero-extended, and a non-negative constant
                    // has no high bits set. The latter keeps the common
                    // `unsigned < positive-literal` loop test on the
                    // immediate path.
                    let needs = |id: ExprId, this: &Self| -> (bool, usize) {
                        let e = this.ast.expr(id);
                        let ty = expr_ty(e);
                        let sz = ty.map_or(8, |t| type_size_bytes(t, this.target));
                        let signed = ty.is_some_and(|t| t & UNSIGNED_BIT == 0);
                        let nonneg_lit = matches!(e, Expr::IntLit { val, .. } if *val >= 0);
                        (signed && !nonneg_lit, sz)
                    };
                    let (l_needs, lsz) = needs(*lhs, self);
                    let (r_needs, rsz) = needs(*rhs, self);
                    if lsz <= 4 && rsz <= 4 && (l_needs || r_needs) {
                        0xffff_ffffi64
                    } else {
                        0
                    }
                } else {
                    0
                };
                // Constant-rhs short-circuit: when the AST rhs is
                // an integer literal and the per-arch BinopI
                // lowering covers `*op`, route through
                // `binop_imm`. The per-arch emit picks the
                // existing immediate-form peepholes
                // (`add r, imm`, `shl r, imm8`, sxtw/sxth/sxtb,
                // and so on) instead of materialising the literal
                // into a register first. Ops whose BinopI path
                // bails (Mod / Modu / Div / Divu / every FP op)
                // stay on the register-rhs path so the SSA emit
                // doesn't fall back to the pool path.
                let imm_safe_op = imm_safe_binop(*op);
                // Operands that need masking take the register path so the
                // mask below applies; the immediate fast paths skip it.
                let imm_safe_op = imm_safe_op && cmp_mask == 0;
                // C99 6.6: a constant expression evaluates at
                // translation time. The parser doesn't fold the
                // synthesised pointer-arithmetic scaling
                // (`arr[K]` lowers to `arr + (K * sizeof(*arr))`
                // with K and the size both literals), so do the
                // fold here. Skip ops the per-arch BinopI lowering
                // doesn't cover.
                if imm_safe_op
                    && let Expr::IntLit { val: lv_imm, .. } = *self.ast.expr(*lhs)
                    && let Expr::IntLit { val: rv_imm, .. } = *self.ast.expr(*rhs)
                {
                    return Ok(b.imm(fold_int_binop(*op, lv_imm, rv_imm)));
                }
                let mut lv = self.walk_expr_rvalue(b, *lhs)?;
                if imm_safe_op && let Expr::IntLit { val, .. } = self.ast.expr(*rhs) {
                    // C99 6.3.1.3 + 6.3.1.8: unsigned divide /
                    // modulo at a narrower-than-register common
                    // type needs each operand masked first. The
                    // `imm_safe_op` set excludes Divu / Modu so
                    // this branch never carries the divmod mask
                    // path; the literal flows through unchanged.
                    debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
                    return Ok(b.binop_imm(*op, lv, *val));
                }
                let mut rv = self.walk_expr_rvalue(b, *rhs)?;
                // Floating-point binops (C99 6.3.1.8). `float op float`
                // is single precision; any `double` operand promotes the
                // op (and the other operand) to double. The parser
                // already chose Fadd/.../Feq and set `ty` to the result
                // type; the walker decides the operand / result width.
                if matches!(
                    *op,
                    BinOp::Fadd
                        | BinOp::Fsub
                        | BinOp::Fmul
                        | BinOp::Fdiv
                        | BinOp::Feq
                        | BinOp::Fne
                        | BinOp::Flt
                        | BinOp::Fgt
                        | BinOp::Fle
                        | BinOp::Fge
                ) {
                    // C99 6.3.1.8: the op is single precision only when
                    // both operands are already f32; any f64 operand
                    // promotes the op (and the f32 operand) to double.
                    // The walker tags each `float`-typed value f32 as it
                    // is produced, so the operands' f32 markers are the
                    // bit-accurate signal -- the operand AST's C type can
                    // diverge from the value's representation after an
                    // intervening widening.
                    let op_is_f32 = b.is_f32(lv) && b.is_f32(rv);
                    if op_is_f32 {
                        let res = b.binop(*op, lv, rv);
                        // Arithmetic produces a `float`; tag it. A
                        // comparison produces an `int` and is left
                        // untagged.
                        if matches!(*op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv) {
                            return Ok(b.mark_f32(res));
                        }
                        return Ok(res);
                    }
                    // Double-precision op: any f32 operand widens to
                    // double first (6.3.1.5).
                    lv = b.fp_widen_to_f64(lv);
                    rv = b.fp_widen_to_f64(rv);
                    return Ok(b.binop(*op, lv, rv));
                }
                // The rhs AST shape isn't an `IntLit`, but walking
                // it may have constant-folded down to one (e.g.
                // `K * sizeof(*arr)` with both K and the size as
                // literals). Inspect the SSA value the walker
                // returned and route through `binop_imm` when it
                // names an `Imm`. The producing inst becomes dead
                // (use_counts drops to 0) and DCE skips it.
                if imm_safe_op && let Some(rk) = b.peek_imm(rv) {
                    debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
                    return Ok(b.binop_imm(*op, lv, rk));
                }
                // For commutative ops where the constant landed on
                // lhs (C99 source order `4 * i`), swap operands and
                // emit BinopI so the literal never spills to a
                // register. Bit ops Eq / Ne are commutative; ordered
                // comparisons Lt / Gt / Le / Ge / Ult / Ugt / Ule /
                // Uge are not, but swapping operands flips the
                // comparison direction, so `K < x` rewrites to
                // `x > K` (and so on), still routing through
                // BinopI.
                let commutative = matches!(
                    *op,
                    BinOp::Add
                        | BinOp::Mul
                        | BinOp::And
                        | BinOp::Or
                        | BinOp::Xor
                        | BinOp::Eq
                        | BinOp::Ne
                );
                let reversed_cmp = match *op {
                    BinOp::Lt => Some(BinOp::Gt),
                    BinOp::Gt => Some(BinOp::Lt),
                    BinOp::Le => Some(BinOp::Ge),
                    BinOp::Ge => Some(BinOp::Le),
                    BinOp::Ult => Some(BinOp::Ugt),
                    BinOp::Ugt => Some(BinOp::Ult),
                    BinOp::Ule => Some(BinOp::Uge),
                    BinOp::Uge => Some(BinOp::Ule),
                    _ => None,
                };
                if imm_safe_op
                    && commutative
                    && let Some(lk) = b.peek_imm(lv)
                {
                    debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
                    return Ok(b.binop_imm(*op, rv, lk));
                }
                if imm_safe_op
                    && let Some(swapped_op) = reversed_cmp
                    && let Some(lk) = b.peek_imm(lv)
                {
                    debug_assert!(!needs_divmod_mask, "imm_safe_op should exclude Divu/Modu");
                    return Ok(b.binop_imm(swapped_op, rv, lk));
                }
                // C99 6.3.1.3 + 6.3.1.8: unsigned divide / modulo
                // at a narrower-than-register common type needs
                // each operand masked to that width *before* the
                // op. A signed operand promoted to the unsigned
                // common type carries its sign-extended high
                // half in the 64-bit register; without the mask,
                // `udiv` / `umod` operate on the wider pattern
                // and produce the wrong order of magnitude.
                if needs_divmod_mask || cmp_mask != 0 {
                    let m = if needs_divmod_mask { mask } else { cmp_mask };
                    lv = b.binop_imm(BinOp::And, lv, m);
                    rv = b.binop_imm(BinOp::And, rv, m);
                }
                // Strength-reduce divide / modulo by a constant divisor
                // to shifts, masks and reciprocal multiplies. This is
                // the only constant-divisor fast path: the per-arch
                // `BinopI` emit does not lower Div / Mod, so they are
                // otherwise excluded from `imm_safe_op` and divide
                // through the register path.
                if let Some(w) = self.divmod_operand_width(*op, *ty, *lhs, *rhs)
                    && let Some(reduced) = b.divmod_const(*op, lv, rv, w)
                {
                    return Ok(reduced);
                }
                // The parser's `maybe_mask_to_unsigned_width`
                // already pushes the explicit narrow mask /
                // signed `Shl K; Shr K` pair as additional
                // `Expr::Binary` nodes through the dual-emit
                // binop tracker. Re-applying the narrowing here
                // would double-shift (or double-mask) the
                // result; walker just emits the raw `Binop` and
                // lets those wrapping Binary nodes do the rest.
                Ok(b.binop(*op, lv, rv))
            }
            Expr::BitfieldAssign {
                obj,
                field_off,
                bitfield,
                rhs,
                ty,
            } => {
                let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*obj);
                // C99 6.7.2.1: bitfield write -- load the storage
                // unit, clear the destination slice, mask + shift
                // the new value into place, OR the cleared old
                // value with the shifted new, store back. The
                // assignment's own value (for an enclosing expression)
                // is the masked field value, not the storage word.
                let bf = *bitfield;
                let seg = self.bitfield_access_seg(id, *ty, bf)?;
                let base = self.walk_expr_rvalue(b, *obj)?;
                let addr = if *field_off != 0 {
                    b.binop_imm(BinOp::Add, base, *field_off)
                } else {
                    base
                };
                // Evaluate the RHS before loading the storage unit: a
                // chained assignment whose RHS writes the same unit
                // (adjacent bitfields, `a.x = a.y = v`) must be observed by
                // this read-modify-write, else its store is clobbered.
                let rhs_v = self.bitfield_store_value(b, bf, *rhs)?;
                let align = self.member_align(*obj, *field_off, bf.unit_size as u32);
                Ok(self.store_into_bitfield(b, addr, bf, rhs_v, seg, vol, align))
            }
            Expr::Assign { lhs, rhs, ty } => {
                // C99 6.5.16.1p1 + the c5 address-as-value rule:
                // a struct-typed assignment copies the bytes from
                // the source struct into the destination. The
                // walker walks both sides as lvalue / rvalue
                // address producers (struct rvalues land their
                // address on `ast_acc`, not a load) and emits
                // `Inst::Mcpy { dst, src, size }`. Returns the
                // dst address as the expression's value
                // (mirroring libc `memcpy`).
                if is_struct_ty(*ty) && struct_ptr_depth(*ty) == 0 {
                    let dst_seg = self.access_seg(*lhs, *ty)?;
                    let src_seg = match self.seg_aggregate_ty(*rhs) {
                        Some(t) => self.access_seg(*rhs, t)?,
                        None => AsmSeg::None,
                    };
                    let dst = self.walk_expr_lvalue(b, *lhs)?;
                    let src = self.walk_expr_rvalue(b, *rhs)?;
                    let size = self.struct_size(*ty);
                    let align = self.struct_align(*ty);
                    if dst_seg == AsmSeg::None && src_seg == AsmSeg::None {
                        b.mcpy(dst, src, size, align);
                    } else {
                        let vol = is_volatile_ty(*ty)
                            || self.expr_is_volatile(*lhs)
                            || self.expr_is_volatile(*rhs);
                        self.seg_copy_bytes(b, dst, dst_seg, src, src_seg, size, align, vol);
                    }
                    return Ok(dst);
                }
                // Local-target shortcut: a Token::Loc-class Ident
                // lvalue lowers to a single `StoreLocal` instead of
                // `LocalAddr` + `Store`, keeping the slot mem2reg-
                // promotable. The `F32` s-view is narrowed below before
                // the store so the assignment yields the f32 value.
                let kind = store_kind_for(*ty, self.target);
                let vol = is_volatile_ty(*ty) || self.expr_is_volatile(*lhs);
                if let Expr::Ident {
                    class,
                    val,
                    is_thread_local: false,
                    ..
                } = self.ast.expr(*lhs)
                    && *class == Token::Loc as i64
                {
                    // A frame slot has no named address space; the parser
                    // rejects such declarations, so a tag reaching here is
                    // an error, not a generic-space store.
                    if segment_of_object_ty(*ty).is_some() {
                        return Err(WalkError::InvalidExpr {
                            id: *lhs,
                            kind: "named address space on automatic storage",
                        });
                    }
                    let slot = *val;
                    // The destination is the object's own storage, so its
                    // top-level qualifier governs, not one that sits on a
                    // pointee below it.
                    let vol = is_volatile_object_ty(*ty);
                    let mut value = self.walk_expr_rvalue(b, *rhs)?;
                    // C99 6.5.16.1 + 6.3.1.5: a `double` value assigned
                    // to a `float` object is narrowed to single precision;
                    // the assignment expression's value is the converted
                    // (f32) value.
                    if matches!(kind, StoreKind::F32) {
                        value = b.fp_narrow_to_f32(value);
                    }
                    b.store_local_vol(slot, value, kind, vol);
                    // C99 6.5.16p3: the assignment expression's value has
                    // the converted type of the left operand. The store
                    // truncated the stored bytes; the value carried
                    // forward to an enclosing expression must also be
                    // narrowed (the F32 case did so above).
                    let rhs_ty = expr_ty(self.ast.expr(*rhs)).unwrap_or(*ty);
                    return Ok(self.narrow_int_to_ty(b, value, rhs_ty, *ty));
                }
                let seg = self.access_seg(*lhs, *ty)?;
                let addr = self.walk_expr_lvalue(b, *lhs)?;
                let mut value = self.walk_expr_rvalue(b, *rhs)?;
                // C99 6.5.16.1 + 6.3.1.5: a `double` value assigned to a
                // `float` object is narrowed to single precision. The
                // parser inserts no float<->double cast (same type
                // class), so the walker narrows here when the stored
                // value is still double. The assignment expression's
                // value is the converted (f32) value.
                if matches!(kind, StoreKind::F32) {
                    value = b.fp_narrow_to_f32(value);
                }
                let align = self.lvalue_align(*lhs, store_kind_width(kind));
                store_place(b, addr, value, kind, seg, vol, align);
                // C99 6.5.16p3: the assignment expression's value has the
                // converted type of the left operand. The store truncated
                // the stored bytes; the value carried forward to an
                // enclosing expression must also be narrowed (the F32 case
                // did so above). A dead value drops out in DCE.
                let rhs_ty = expr_ty(self.ast.expr(*rhs)).unwrap_or(*ty);
                Ok(self.narrow_int_to_ty(b, value, rhs_ty, *ty))
            }
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                ty,
                elvis,
            } => {
                // A constant controlling expression selects one arm at
                // translation time (C99 6.5.15); evaluate only that arm
                // so the dead arm's side effects and undefined-symbol
                // references are never emitted. Ternary arms are
                // expressions, so no label/goto concern applies. The
                // GNU `a ?: b` form keeps its runtime path. Matches
                // gcc's front-end fold at -O0.
                if !*elvis && let Some(c) = self.const_fold_int(*cond) {
                    let live = if c != 0 { *then_e } else { *else_e };
                    let v = self.walk_expr_rvalue(b, live)?;
                    let arm_ty = expr_ty(self.ast.expr(live)).unwrap_or(*ty);
                    return Ok(self.convert_scalar_value(b, v, arm_ty, *ty));
                }
                // C99 6.5.15: evaluate cond; depending on the
                // value, evaluate exactly one of then_e / else_e
                // and the conditional expression's value is that
                // arm's value. Same synthetic-local-slot phi
                // substitute the `ShortCircuit` arm uses -- both
                // arms store the arm result and the merge block
                // loads it. Width is taken from the result type:
                // an FP-typed ternary uses `StoreLocal { kind: F32 }` /
                // `LoadLocal { kind: F32 }` so the codegen routes
                // through the FP register class; everything else
                // stays on the I64 `StoreLocal` / `LoadLocal` fast
                // path the emit lowers in a single `stur` / `ldur`.
                //
                // The GNU `a ?: b` form evaluates the condition once and
                // reuses its value as the then-arm (converted to the result
                // type). The plain form evaluates the condition for its
                // truthiness only and evaluates a separate then-arm.
                let (cond_v, elvis_val) = if *elvis {
                    let v = self.walk_expr_rvalue(b, *cond)?;
                    (self.cond_truthy(b, v, *cond), Some(v))
                } else {
                    (self.walk_cond_value(b, *cond)?, None)
                };
                let then_blk = b.new_block();
                let else_blk = b.new_block();
                let after_blk = b.new_block();
                b.branch_zero(cond_v, else_blk, then_blk);
                let slot = b.alloc_synthetic_local();
                let load_kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                // An FP-typed result rides the FP register class through
                // the fused `StoreLocal` / `LoadLocal` path: the emit
                // lowers `F32` (`movss` / `str s`, narrowing an f64 arm
                // per C99 6.3.1.5) and `F64` (`movsd` / `ldr d`) each in
                // a single instruction. The fused ops keep the synthetic
                // merge slot mem2reg-promotable, unlike `LocalAddr` +
                // `Store`. Everything else stays on the I64 fast path.
                let is_fp = matches!(load_kind, LoadKind::F32 | LoadKind::F64);
                let arm_store = |b: &mut SsaBuilder, v| {
                    let kind = if is_fp { store_kind } else { StoreKind::I64 };
                    b.store_local(slot, v, kind);
                };
                b.switch_to(then_blk);
                let then_v = if let Some(v) = elvis_val {
                    // Reuse the condition's value, converted from its own
                    // type to the conditional's result type.
                    let cond_ty = expr_ty(self.ast.expr(*cond)).unwrap_or(*ty);
                    self.convert_scalar_value(b, v, cond_ty, *ty)
                } else {
                    self.walk_expr_rvalue(b, *then_e)?
                };
                arm_store(b, then_v);
                b.jmp(after_blk);
                b.switch_to(else_blk);
                let else_v = self.walk_expr_rvalue(b, *else_e)?;
                arm_store(b, else_v);
                b.jmp(after_blk);
                b.switch_to(after_blk);
                let read_kind = if is_fp { load_kind } else { LoadKind::I64 };
                Ok(b.load_local(slot, read_kind))
            }
            Expr::Call { callee, args, ty } => {
                let callee_conv = self.callee_conv(*callee);
                // Out-pointer-returning c5-internal callee: allocate a
                // result temp on this frame, prepend its address as the
                // hidden out-pointer arg 0, run the call, and return the
                // temp's address as the expression's value (the c5 ABI's
                // address-as-value rule for struct rvalues). Host-ABI
                // returns (registers / x8) carry no hidden argument and
                // fall through to the normal call path below, which
                // tags the call's `ret_agg` / `ret_slot`.
                if is_struct_ty(*ty)
                    && struct_ptr_depth(*ty) == 0
                    && matches!(
                        crate::c5::compiler::struct_return_abi_conv(
                            self.structs,
                            self.target,
                            callee_conv,
                            *ty
                        ),
                        crate::c5::compiler::StructReturnAbi::OutPtr
                    )
                    && let Expr::Ident {
                        sym, class, val, ..
                    } = self.ast.expr(*callee)
                    && *class == Token::Fun as i64
                {
                    // The callee writes the whole struct through the
                    // out-pointer, so the result temp must hold
                    // `sizeof(struct)` bytes, not a single slot.
                    let result_size = self.struct_size(*ty);
                    let result_slot = b.alloc_synthetic_struct(result_size);
                    // Spill the out-pointer through an int-typed
                    // temp so the codegen routes it via the host
                    // int arg register, matching the way FP and
                    // pointer args are routed.
                    let addr = b.local_addr(result_slot);
                    let temp = b.alloc_synthetic_local();
                    b.store_local(temp, addr, StoreKind::I64);
                    let out_arg = b.load_local(temp, LoadKind::I64);
                    let mut all_args: alloc::vec::Vec<ValueId> =
                        alloc::vec::Vec::with_capacity(args.len() + 1);
                    all_args.push(out_arg);
                    for a in args {
                        let mut v = self.walk_expr_rvalue(b, *a)?;
                        // The all-integer cdecl carries each argument in an
                        // 8-byte integer slot, where the callee reads a
                        // floating-point parameter as a double. A `double`
                        // already occupies eight bytes; a `float` must be
                        // widened to that pattern and reloaded through an
                        // integer slot, or the marshal moves only its 4-byte
                        // form into the low half and the f64 read sees noise in
                        // the high half.
                        if arg_value_ty(self.ast.expr(*a))
                            .map(is_float_ty)
                            .unwrap_or(false)
                        {
                            let widened = b.fp_widen_to_f64(v);
                            let slot = b.alloc_synthetic_local();
                            b.store_local(slot, widened, StoreKind::I64);
                            v = b.load_local(slot, LoadKind::I64);
                        }
                        all_args.push(v);
                    }
                    let target_pc = self.live_fun_val(*sym, *val);
                    // Struct-returning callee: the result is an
                    // address (the c5 address-as-value rule), never
                    // an FP scalar, so `fp_return` is false. The callee
                    // keeps the c5 cdecl shape (excluded from
                    // `param_fp_mask` because the hidden out-pointer
                    // shifts every parameter cell), so its arguments
                    // ride the integer bank: `fp_arg_mask` is 0.
                    // The hidden out-pointer is a fixed argument. A
                    // variadic struct-returning callee (e.g. a printf-style
                    // error helper returning a 16-byte value) still passes
                    // its variadic tail on the host stack, so fixed_args
                    // counts the out-pointer plus the callee's named
                    // parameters; the emit detects the variadic callee from
                    // its target and places `args[fixed_args..]` per the
                    // host variadic ABI. A non-variadic callee keeps every
                    // argument fixed.
                    let fixed_args = if self.fun_is_variadic(*sym) {
                        1 + self.fun_fixed_args(*sym)
                    } else {
                        all_args.len()
                    };
                    if target_pc == 0 {
                        let _ = b.call_extern(*sym, all_args, fixed_args, false, 0);
                    } else {
                        let _ = b.call(target_pc as usize, all_args, fixed_args, false, 0);
                    }
                    return Ok(b.local_addr(result_slot));
                }
                // Lower each arg as an rvalue, then dispatch
                // through the callee's class. Direct
                // c5-internal (`Token::Fun`) calls go through
                // `b.call(target_pc, args)`; libc bindings
                // (`Token::Sys`) go through `b.call_ext`;
                // anything else routes through
                // `b.call_indirect` with the callee's value.
                //
                // Indirect-call shape splits by callee form:
                //   * Non-Ident callee (struct-field-then-call,
                //     `*fp(...)`, ...): the parser's Pratt loop
                //     evaluates the callee before reaching `(` and
                //     spills it to a temp through the store-local
                //     path. The walker evaluates the callee FIRST
                //     and stashes the resulting ValueId.
                //   * Ident callee of class Loc / Glo (simple
                //     function-pointer variable): the parser's
                //     dedicated `()`-after-identifier path
                //     evaluates args FIRST, then loads the
                //     callee's stored function-pointer value.
                //     The walker mirrors this by deferring the
                //     callee walk to after the args loop.
                // Token::Fun / Token::Sys never reach the
                // indirect-call site (the per-class branches
                // below dispatch to b.call / b.call_ext) so they
                // don't walk the callee at all.
                let indirect_target: Option<ValueId> =
                    if let Expr::Ident { .. } = self.ast.expr(*callee) {
                        None
                    } else {
                        Some(self.walk_expr_rvalue(b, *callee)?)
                    };
                let mut arg_vals: alloc::vec::Vec<ValueId> =
                    alloc::vec::Vec::with_capacity(args.len());
                // C99 6.5.2.2p7 + ABI: each FP-typed argument
                // routes through d0..d7 (or the host's variadic
                // FP slot). Encode the per-arg FP-ness as a bit
                // mask so the codegen's `plan_call_args` places
                // each arg in the right register class. Walker
                // reads the arg's snapshotted `ty`; the post-
                // conversion type captured by the dual-emit
                // binop tracker already reflects the implicit
                // int->double lift the parser emitted at this
                // call site.
                let mut fp_arg_mask: u32 = 0;
                for (i, a) in args.iter().enumerate() {
                    // A by-value aggregate argument is copied by the
                    // callee through the generic space.
                    arg_vals.push(self.walk_copy_operand(b, *a)?);
                    if arg_value_ty(self.ast.expr(*a))
                        .map(is_floating_scalar)
                        .unwrap_or(false)
                        && i < 32
                    {
                        fp_arg_mask |= 1u32 << i;
                    }
                }
                if let Expr::Ident {
                    sym, class, val, ..
                } = self.ast.expr(*callee)
                {
                    if *class == Token::Fun as i64 {
                        // C99 6.5.2.2p7 + the host ABI: a floating-point
                        // scalar argument rides an FP argument register
                        // (xmm0..xmm7 / d0..d7). The value left in
                        // `arg_vals[i]` is already FP-classed; the
                        // per-arch `marshal_args` places it in the FP
                        // bank per `plan_call_args` using `fp_arg_mask`.
                        // A `float` argument stays at single precision
                        // (no widen-to-double); the callee narrows back
                        // from the s-register view.
                        //
                        // A variadic c5 callee is the exception: it keeps
                        // the c5 cdecl stack shape (its prologue skips the
                        // host-arg-reg spill and reads args off the
                        // 16-byte-stride stack as raw 8-byte patterns).
                        // C99 6.5.2.2p6 default argument promotions widen
                        // a `float` argument to `double`; route every FP
                        // argument through the integer register class as a
                        // widened 8-byte double, matching what the callee
                        // reads back, and pass `fp_arg_mask = 0`.
                        let callee_variadic = self.fun_is_variadic(*sym);
                        let abi = self.target.abi_for(callee_conv);
                        // Named (fixed) parameter count of the callee.
                        // For a variadic callee the prototype records the
                        // pre-ellipsis parameters in `Symbol::params`;
                        // `args[fixed_args..]` are the variadic arguments.
                        // For a non-variadic callee every argument is
                        // fixed.
                        let fixed_args = if callee_variadic {
                            self.fun_fixed_args(*sym).min(args.len())
                        } else {
                            args.len()
                        };
                        // C99 6.5.2.2 + the host ABI: a struct passed as
                        // a variadic argument rides by value -- its
                        // eightbyte occupies the save area / stack slot
                        // `va_arg` reads -- not via the c5 address-as-
                        // value pointer that `walk_expr_rvalue` left in
                        // `arg_vals`. Replace each small struct variadic
                        // argument's address with its loaded eightbyte.
                        // A struct larger than one eightbyte is left on
                        // the address path. TODO: pass its second
                        // eightbyte.
                        // Host-ABI aggregate arguments (AAPCS64 6.8.2 /
                        // System V 3.2.3): tag each by-value struct argument
                        // with its layout so the caller marshals it into the
                        // argument registers / stack slots the callee reads.
                        // A fixed parameter classifies by its declared type;
                        // a variadic argument by its own type. A variadic
                        // struct of at most one eightbyte rides as a single
                        // loaded integer in the variadic slot (C99 6.5.2.2);
                        // a larger aggregate routes through the host-ABI
                        // placement so `plan_call_args_aggs` lays its
                        // eightbytes down all-or-nothing and the callee's
                        // `va_arg` reads them contiguously. Inert on ABIs /
                        // sizes the classifier declines.
                        let mut arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
                        {
                            let nparams = self.symbols[*sym as usize].params.len();
                            for i in 0..arg_vals.len() {
                                let agg_ty = if i < nparams {
                                    Some(self.symbols[*sym as usize].params[i])
                                } else {
                                    match arg_value_ty(self.ast.expr(args[i])) {
                                        Some(aty)
                                            if is_struct_value_ty(aty)
                                                && self.struct_size(aty) <= 8 =>
                                        {
                                            arg_vals[i] = b.load(arg_vals[i], LoadKind::I64);
                                            None
                                        }
                                        other => other,
                                    }
                                };
                                let Some(ty_tag) = agg_ty else {
                                    continue;
                                };
                                // A variadic callee's named aggregate parameter
                                // rides the c5 by-address convention: the callee
                                // reads it from the passed address (its prologue
                                // does not scatter an incoming aggregate
                                // register pair into the parameter local). Host-
                                // ABI by-value placement for a named aggregate
                                // of a variadic callee is not yet lowered on the
                                // register-save variadic ABIs, so keep both ends
                                // on the by-address shape.
                                if callee_variadic && i < self.symbols[*sym as usize].params.len() {
                                    continue;
                                }
                                if let Some(desc) = crate::c5::compiler::host_abi_agg_desc_conv(
                                    self.structs,
                                    self.target,
                                    callee_conv,
                                    ty_tag,
                                ) {
                                    if arg_aggs.is_empty() {
                                        arg_aggs = alloc::vec![None; arg_vals.len()];
                                    }
                                    arg_aggs[i] = Some(b.intern_agg_desc(desc));
                                }
                            }
                        }
                        // macOS arm64's variadic ABI (Apple "Writing
                        // ARM64 Code for Apple Platforms") passes the
                        // named arguments per AAPCS64 6.4.1 (int bank +
                        // FP bank) and every variadic argument on the
                        // stack at 8-byte stride. The codegen marshals
                        // this exactly like a libc variadic call, so the
                        // named FP arguments keep their FP-bank placement;
                        // only the variadic `float` arguments are widened
                        // to `double` per C99 6.5.2.2p6 (kept FP-classed
                        // so the 8-byte stack store reads back as a
                        // double).
                        if callee_variadic && abi.variadic_on_stack {
                            for (i, a) in args.iter().enumerate() {
                                if i < fixed_args {
                                    continue;
                                }
                                let arg_is_fp = arg_value_ty(self.ast.expr(*a))
                                    .map(is_floating_scalar)
                                    .unwrap_or(false);
                                if arg_is_fp {
                                    arg_vals[i] = b.fp_widen_to_f64(arg_vals[i]);
                                }
                            }
                            let fp_return = is_floating_scalar(*ty);
                            let target_pc = self.live_fun_val(*sym, *val);
                            let call = if target_pc == 0 {
                                b.call_extern(*sym, arg_vals, fixed_args, fp_return, fp_arg_mask)
                            } else {
                                b.call(
                                    target_pc as usize,
                                    arg_vals,
                                    fixed_args,
                                    fp_return,
                                    fp_arg_mask,
                                )
                            };
                            if !arg_aggs.is_empty() {
                                b.set_call_arg_aggs(call, arg_aggs);
                            }
                            if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                            | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                                crate::c5::compiler::struct_return_abi_conv(
                                    self.structs,
                                    self.target,
                                    callee_conv,
                                    *ty,
                                )
                            {
                                let ridx = b.intern_agg_desc(desc.clone());
                                let slot = b.alloc_synthetic_struct(desc.size as i64);
                                b.set_call_ret_agg(call, ridx, slot);
                                return Ok(b.local_addr(slot));
                            }
                            if is_float_ty(*ty) {
                                return Ok(b.mark_f32(call));
                            }
                            // An external (`target_pc == 0`) callee may per
                            // AAPCS leave a narrow return's high bits
                            // undefined; extend to keep the walker's
                            // sign/zero-extended-to-64-bits invariant. An
                            // intra-TU callee already returns full width.
                            return Ok(if !self.symbols[*sym as usize].defined_here {
                                extend_scalar_call_result(b, call, *ty, self.target)
                            } else {
                                call
                            });
                        }
                        // Register-save host variadic ABI (System V AMD64
                        // on Linux x86_64, AAPCS64 on Linux aarch64): a
                        // variadic callee receives its floating-point
                        // arguments in the FP argument-register bank
                        // (xmm0..xmm7 / d0..d7), so the call passes the
                        // real `fp_arg_mask` rather than force-routing FP
                        // arguments through the integer bank. Variadic
                        // `float` arguments are still widened to `double`
                        // (C99 6.5.2.2p6 default argument promotions) but
                        // kept FP-classed so they ride an FP register.
                        if callee_variadic
                            && (abi.sysv_host_variadic() || abi.aarch64_host_variadic())
                        {
                            for (i, a) in args.iter().enumerate() {
                                if i < fixed_args {
                                    continue;
                                }
                                let arg_is_fp = arg_value_ty(self.ast.expr(*a))
                                    .map(is_floating_scalar)
                                    .unwrap_or(false);
                                if arg_is_fp {
                                    arg_vals[i] = b.fp_widen_to_f64(arg_vals[i]);
                                }
                            }
                            let fp_return = is_floating_scalar(*ty);
                            let target_pc = self.live_fun_val(*sym, *val);
                            let call = if target_pc == 0 {
                                b.call_extern(*sym, arg_vals, fixed_args, fp_return, fp_arg_mask)
                            } else {
                                b.call(
                                    target_pc as usize,
                                    arg_vals,
                                    fixed_args,
                                    fp_return,
                                    fp_arg_mask,
                                )
                            };
                            if !arg_aggs.is_empty() {
                                b.set_call_arg_aggs(call, arg_aggs);
                            }
                            if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                            | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                                crate::c5::compiler::struct_return_abi_conv(
                                    self.structs,
                                    self.target,
                                    callee_conv,
                                    *ty,
                                )
                            {
                                let ridx = b.intern_agg_desc(desc.clone());
                                let slot = b.alloc_synthetic_struct(desc.size as i64);
                                b.set_call_ret_agg(call, ridx, slot);
                                return Ok(b.local_addr(slot));
                            }
                            if is_float_ty(*ty) {
                                return Ok(b.mark_f32(call));
                            }
                            // An external (`target_pc == 0`) callee may per
                            // AAPCS leave a narrow return's high bits
                            // undefined; extend to keep the walker's
                            // sign/zero-extended-to-64-bits invariant. An
                            // intra-TU callee already returns full width.
                            return Ok(if !self.symbols[*sym as usize].defined_here {
                                extend_scalar_call_result(b, call, *ty, self.target)
                            } else {
                                call
                            });
                        }
                        // A variadic callee reaching here is a
                        // `variadic_int_only` host (Win64 / Windows arm64,
                        // the Microsoft calling conventions): the macOS
                        // arm64 (`variadic_on_stack`) and System V /
                        // AAPCS64 register-save hosts returned above. Its
                        // named and variadic arguments ride the integer
                        // register bank -- a floating-point argument as its
                        // raw bit pattern -- so widen every FP argument to
                        // an 8-byte double in an integer slot, matching
                        // what the callee reads back, and pass
                        // `fp_arg_mask = 0`. The same widening covers a
                        // non-variadic callee whose register/stack
                        // placement would interleave.
                        let eff_fp_arg_mask = effective_fp_arg_mask(args.len(), fp_arg_mask, abi);
                        let force_int =
                            callee_variadic || (fp_arg_mask != 0 && eff_fp_arg_mask == 0);
                        let call_fp_arg_mask = if force_int {
                            for (i, a) in args.iter().enumerate() {
                                let arg_is_fp = arg_value_ty(self.ast.expr(*a))
                                    .map(is_floating_scalar)
                                    .unwrap_or(false);
                                if arg_is_fp {
                                    let widened = b.fp_widen_to_f64(arg_vals[i]);
                                    let slot = b.alloc_synthetic_local();
                                    b.store_local(slot, widened, StoreKind::I64);
                                    arg_vals[i] = b.load_local(slot, LoadKind::I64);
                                }
                            }
                            0
                        } else {
                            eff_fp_arg_mask
                        };
                        // C99 6.2.5p10: a call to a function whose
                        // return type is a floating-point scalar
                        // yields its value in the FP return register.
                        // Tag the call so the codegen reads the result
                        // from there and FP-classes the value.
                        let fp_return = is_floating_scalar(*ty);
                        let target_pc = self.live_fun_val(*sym, *val);
                        // Host-ABI aggregate return (AAPCS64 6.9):
                        // reserve the result temp before the call. Its
                        // frame slot rides on the call instruction, so it
                        // survives value renumbering and needs no SSA
                        // operand.
                        let ret_temp = if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                        | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                            crate::c5::compiler::struct_return_abi_conv(
                                self.structs,
                                self.target,
                                callee_conv,
                                *ty,
                            ) {
                            let ridx = b.intern_agg_desc(desc.clone());
                            let slot = b.alloc_synthetic_struct(desc.size as i64);
                            Some((ridx, slot))
                        } else {
                            None
                        };
                        let call = if target_pc == 0 {
                            b.call_extern(*sym, arg_vals, fixed_args, fp_return, call_fp_arg_mask)
                        } else {
                            b.call(
                                target_pc as usize,
                                arg_vals,
                                fixed_args,
                                fp_return,
                                call_fp_arg_mask,
                            )
                        };
                        if !arg_aggs.is_empty() {
                            b.set_call_arg_aggs(call, arg_aggs);
                        }
                        // Tag the call's `ret_agg` / `ret_slot` and yield
                        // the result temp's address. The codegen reads
                        // the eightbytes from x0/x1 (<= 16 bytes) or has
                        // the callee write through x8 (> 16 bytes); the
                        // VM copies the returned struct into the temp.
                        if let Some((ridx, slot)) = ret_temp {
                            b.set_call_ret_agg(call, ridx, slot);
                            return Ok(b.local_addr(slot));
                        }
                        // A `float`-returning callee yields a single-
                        // precision value (C99 6.2.5p10 / 6.3.1.8); tag it.
                        if is_float_ty(*ty) {
                            return Ok(b.mark_f32(call));
                        }
                        // An external (`target_pc == 0`) callee may per
                        // AAPCS leave a narrow return's high bits undefined;
                        // extend to keep the walker's sign/zero-extended-to-
                        // 64-bits invariant. An intra-TU callee already
                        // returns full width.
                        return Ok(if !self.symbols[*sym as usize].defined_here {
                            extend_scalar_call_result(b, call, *ty, self.target)
                        } else {
                            call
                        });
                    }
                    if *class == Token::Sys as i64 {
                        // A returns-twice callee (setjmp family /
                        // vfork) disables spill-slot sharing in this
                        // function; see FunctionSsa::has_returns_twice_call.
                        if crate::c5::ir::returns_twice_fn_name(&self.symbols[*sym as usize].name) {
                            b.mark_returns_twice();
                        }
                        // The Ident's `val` is the binding's
                        // flat index across all `#pragma
                        // binding(...)` directives -- exactly
                        // what `Inst::CallExt::binding_idx`
                        // wants. `fp_arg_mask` is the per-arg
                        // FP-ness bit set we built above. A
                        // floating-point return is FP-classed (C99
                        // 6.2.5p10) so the result rides d0 / xmm0
                        // without a GPR bridge; a `float` result
                        // additionally carries the f32 tag.
                        // A by-value struct argument to a libc binding is
                        // packed into the platform-ABI argument registers
                        // (SysV / AAPCS64: <= 16 bytes), not passed by the
                        // c5-internal address convention. Tag each struct arg
                        // so the emitter classifies and marshals it.
                        let mut ext_arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
                        let nparams = self.symbols[*sym as usize].params.len();
                        for i in 0..arg_vals.len() {
                            let arg_ty = if i < nparams {
                                self.symbols[*sym as usize].params[i]
                            } else {
                                match arg_value_ty(self.ast.expr(args[i])) {
                                    Some(t) => t,
                                    None => continue,
                                }
                            };
                            if is_struct_value_ty(arg_ty)
                                && let Some(desc) = crate::c5::compiler::host_abi_agg_desc(
                                    self.structs,
                                    self.target,
                                    arg_ty,
                                )
                            {
                                if ext_arg_aggs.is_empty() {
                                    ext_arg_aggs = alloc::vec![None; arg_vals.len()];
                                }
                                ext_arg_aggs[i] = Some(b.intern_agg_desc(desc));
                            }
                        }
                        // System V AMD64 MEMORY class / Win64 oversize
                        // (StructReturnAbi::OutPtr): the caller allocates the
                        // result buffer and passes its address as the hidden
                        // first integer argument; the callee writes through it
                        // and returns it in rax. Prepend the out-pointer to the
                        // argument vector and shift the FP-arg mask and the
                        // aggregate descriptors one slot to follow it. AArch64
                        // returns this size through x8 (StructReturnAbi::Indirect,
                        // handled by the ret_agg path below).
                        if is_struct_ty(*ty)
                            && struct_ptr_depth(*ty) == 0
                            && matches!(
                                crate::c5::compiler::struct_return_abi(
                                    self.structs,
                                    self.target,
                                    *ty
                                ),
                                crate::c5::compiler::StructReturnAbi::OutPtr
                            )
                        {
                            let result_size = self.struct_size(*ty);
                            let result_slot = b.alloc_synthetic_struct(result_size);
                            // Spill the out-pointer through an int temp so the
                            // codegen routes it via the host integer arg register.
                            let addr = b.local_addr(result_slot);
                            let temp = b.alloc_synthetic_local();
                            b.store_local(temp, addr, StoreKind::I64);
                            let out_arg = b.load_local(temp, LoadKind::I64);
                            let mut shifted: alloc::vec::Vec<ValueId> =
                                alloc::vec::Vec::with_capacity(arg_vals.len() + 1);
                            shifted.push(out_arg);
                            shifted.extend_from_slice(&arg_vals);
                            let call = b.call_ext(*val, shifted, fp_arg_mask << 1, false);
                            if !ext_arg_aggs.is_empty() {
                                let mut s = alloc::vec![None; arg_vals.len() + 1];
                                for (i, a) in ext_arg_aggs.iter().enumerate() {
                                    s[i + 1] = *a;
                                }
                                b.set_call_arg_aggs(call, s);
                            }
                            return Ok(b.local_addr(result_slot));
                        }
                        // A by-value struct return follows the platform ABI:
                        // reserve the result temp and tag the call's
                        // `ret_agg` so the emitter gathers the return
                        // registers (HFA in v0..vN, x0/x1 for a small
                        // aggregate, x8 indirect for > 16 bytes). The Mcpy at
                        // the use site copies from this temp's address.
                        let ret_temp = if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                        | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                            crate::c5::compiler::struct_return_abi_conv(
                                self.structs,
                                self.target,
                                callee_conv,
                                *ty,
                            ) {
                            let ridx = b.intern_agg_desc(desc.clone());
                            let slot = b.alloc_synthetic_struct(desc.size as i64);
                            Some((ridx, slot))
                        } else {
                            None
                        };
                        let fp_return = is_floating_scalar(*ty);
                        let call = b.call_ext(*val, arg_vals, fp_arg_mask, fp_return);
                        if !ext_arg_aggs.is_empty() {
                            b.set_call_arg_aggs(call, ext_arg_aggs);
                        }
                        if let Some((ridx, slot)) = ret_temp {
                            b.set_call_ret_agg(call, ridx, slot);
                            return Ok(b.local_addr(slot));
                        }
                        if is_float_ty(*ty) {
                            return Ok(b.mark_f32(call));
                        }
                        // A libc / bound (`Sys`) callee's narrow return is
                        // extended by `return_extension` at the CallExt
                        // lowering, keyed on the binding's declared return
                        // type -- which correctly leaves an unprototyped
                        // binding (return_type_tag == 0) unextended rather
                        // than truncating a value that is really a pointer.
                        return Ok(call);
                    }
                }
                // Determine the pointed-to function's variadic-ness
                // and named-parameter count from the callee's static
                // type. A fn-pointer Ident (`cb(...)` where `cb` is a
                // variadic-fn-pointer variable) carries the prototype
                // on its symbol (propagated from the typedef at
                // declaration). A callee with no statically-known
                // prototype (e.g. the result of a comma operator)
                // defaults to non-variadic, all-fixed.
                //
                // TODO: a variadic call through a function pointer whose
                // prototype is not statically recoverable here (a pointer
                // received as a parameter, or loaded through a non-typedef
                // path) takes the all-fixed default and, under the host
                // variadic ABI (`variadic_on_stack`), places the variadic
                // tail in registers rather than on the stack the callee's
                // va_arg walks. Carrying the prototype on the pointer's
                // type rather than the variable symbol would close this.
                let (callee_variadic, callee_fixed) =
                    self.indirect_callee_proto(*callee, args.len());
                // The pointed-to function's own calling convention drives
                // the argument placement, so every ABI question below --
                // which variadic dialect applies, whether a floating-point
                // argument rides the FP bank -- is asked of it rather than
                // of the target's default.
                let abi = self.target.abi_for(callee_conv);
                let target = match indirect_target {
                    Some(t) => t,
                    None => self.walk_expr_rvalue(b, *callee)?,
                };
                let fp_return = is_floating_scalar(*ty);
                // Aggregate arguments through a function pointer classify by
                // the pointed-to prototype's parameter types (System V AMD64
                // 3.2.3 / AAPCS64 6.4 / 6.8.2). The parser narrows each
                // argument to its parameter type before the call, so the
                // argument's own type is that parameter type; classify from
                // it. A variadic aggregate keeps the by-address convention
                // (matching the direct-call variadic handling). Inert on the
                // ABIs / sizes / by-address aggregates the classifier
                // declines.
                let mut arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
                for i in 0..arg_vals.len() {
                    if callee_variadic && i >= callee_fixed {
                        continue;
                    }
                    let Some(aty) = arg_value_ty(self.ast.expr(args[i])) else {
                        continue;
                    };
                    if !(is_struct_value_ty(aty)) {
                        continue;
                    }
                    if let Some(desc) = crate::c5::compiler::host_abi_agg_desc_conv(
                        self.structs,
                        self.target,
                        callee_conv,
                        aty,
                    ) {
                        if arg_aggs.is_empty() {
                            arg_aggs = alloc::vec![None; arg_vals.len()];
                        }
                        arg_aggs[i] = Some(b.intern_agg_desc(desc));
                    }
                }
                // Host-ABI out-pointer struct return through a function
                // pointer (SysV x86_64 > 16 bytes, Win64 aggregates outside
                // {1,2,4,8} bytes). Mirror the direct-call path: allocate
                // the result temp, pass its address as a hidden first
                // integer argument, and yield the temp's address; the
                // callee writes the struct through the pointer and returns
                // it. An out-pointer-returning function uses the all-integer
                // cdecl (its prologue skips the FP bank), so the call is
                // non-variadic with FP mask 0.
                if matches!(
                    crate::c5::compiler::struct_return_abi_conv(
                        self.structs,
                        self.target,
                        callee_conv,
                        *ty
                    ),
                    crate::c5::compiler::StructReturnAbi::OutPtr
                ) {
                    // The callee writes the whole struct through the
                    // out-pointer, so the result temp must hold
                    // `sizeof(struct)` bytes.
                    let result_size = self.struct_size(*ty);
                    let result_slot = b.alloc_synthetic_struct(result_size);
                    let addr = b.local_addr(result_slot);
                    let temp = b.alloc_synthetic_local();
                    b.store_local(temp, addr, StoreKind::I64);
                    let out_arg = b.load_local(temp, LoadKind::I64);
                    let mut all_args: alloc::vec::Vec<ValueId> =
                        alloc::vec::Vec::with_capacity(arg_vals.len() + 1);
                    all_args.push(out_arg);
                    // The all-integer cdecl reads a floating-point parameter as
                    // a double from its 8-byte integer slot. A `double` already
                    // occupies eight bytes; a `float` must be widened to that
                    // pattern and reloaded through an integer slot so it is not
                    // passed as its 4-byte form in the low half of the slot.
                    for i in 0..arg_vals.len() {
                        if arg_value_ty(self.ast.expr(args[i]))
                            .map(is_float_ty)
                            .unwrap_or(false)
                        {
                            let widened = b.fp_widen_to_f64(arg_vals[i]);
                            let slot = b.alloc_synthetic_local();
                            b.store_local(slot, widened, StoreKind::I64);
                            arg_vals[i] = b.load_local(slot, LoadKind::I64);
                        }
                    }
                    all_args.extend_from_slice(&arg_vals);
                    let fixed = all_args.len();
                    let call =
                        b.call_indirect(target, all_args, false, fixed, false, 0, callee_conv);
                    if !arg_aggs.is_empty() {
                        // `all_args` prepends the hidden out-pointer, so the
                        // aggregate descriptors shift by one slot.
                        let mut shifted = alloc::vec![None; arg_aggs.len() + 1];
                        shifted[1..].clone_from_slice(&arg_aggs);
                        b.set_call_arg_aggs(call, shifted);
                    }
                    return Ok(b.local_addr(result_slot));
                }
                // Host-ABI aggregate return through a function pointer:
                // mirror the direct-call path. Reserve the result temp and
                // tag the call so the codegen reads the eightbytes from
                // x0/x1 (<= 16 bytes) or has the callee write through x8
                // (> 16 bytes on aarch64); the VM copies the returned
                // struct into the temp.
                let ret_temp = if let crate::c5::compiler::StructReturnAbi::Regs(desc)
                | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
                    crate::c5::compiler::struct_return_abi_conv(
                        self.structs,
                        self.target,
                        callee_conv,
                        *ty,
                    ) {
                    let ridx = b.intern_agg_desc(desc.clone());
                    let slot = b.alloc_synthetic_struct(desc.size as i64);
                    Some((ridx, slot))
                } else {
                    None
                };
                if callee_variadic && abi.variadic_on_stack {
                    // macOS arm64 variadic ABI: named arguments follow
                    // AAPCS64 (int / FP bank), variadic arguments on the
                    // stack at 8-byte stride. Widen variadic `float`
                    // arguments to `double` per C99 6.5.2.2p6, kept
                    // FP-classed so the 8-byte stack store is a double;
                    // the named FP arguments keep their FP-bank
                    // placement through the real `fp_arg_mask`.
                    for (i, a) in args.iter().enumerate() {
                        if i < callee_fixed {
                            continue;
                        }
                        let arg_is_fp = arg_value_ty(self.ast.expr(*a))
                            .map(is_floating_scalar)
                            .unwrap_or(false);
                        if arg_is_fp {
                            arg_vals[i] = b.fp_widen_to_f64(arg_vals[i]);
                        }
                    }
                    let call = b.call_indirect(
                        target,
                        arg_vals,
                        true,
                        callee_fixed,
                        fp_return,
                        fp_arg_mask,
                        callee_conv,
                    );
                    if !arg_aggs.is_empty() {
                        b.set_call_arg_aggs(call, arg_aggs);
                    }
                    if let Some((ridx, slot)) = ret_temp {
                        b.set_call_ret_agg(call, ridx, slot);
                        return Ok(b.local_addr(slot));
                    }
                    // A `float`-returning callee yields a single-precision
                    // value (C99 6.2.5p10 / 6.3.1.8); tag it so the result
                    // store reads the s-register view instead of narrowing
                    // the d-register a second time.
                    if is_float_ty(*ty) {
                        return Ok(b.mark_f32(call));
                    }
                    return Ok(extend_scalar_call_result(b, call, *ty, self.target));
                }
                // Register-save host variadic ABI (System V AMD64 on Linux
                // x86_64, AAPCS64 on Linux aarch64): a variadic callee
                // through a function pointer receives its floating-point
                // arguments in xmm0..xmm7 / d0..d7, so pass the real
                // `fp_arg_mask` and widen the variadic `float` arguments to
                // `double` (C99 6.5.2.2p6) kept FP-classed. On x86_64 the
                // emit sets `al` to the XMM-argument count at the call site.
                if callee_variadic && (abi.sysv_host_variadic() || abi.aarch64_host_variadic()) {
                    for (i, a) in args.iter().enumerate() {
                        if i < callee_fixed {
                            continue;
                        }
                        let arg_is_fp = arg_value_ty(self.ast.expr(*a))
                            .map(is_floating_scalar)
                            .unwrap_or(false);
                        if arg_is_fp {
                            arg_vals[i] = b.fp_widen_to_f64(arg_vals[i]);
                        }
                    }
                    let call = b.call_indirect(
                        target,
                        arg_vals,
                        true,
                        callee_fixed,
                        fp_return,
                        fp_arg_mask,
                        callee_conv,
                    );
                    if !arg_aggs.is_empty() {
                        b.set_call_arg_aggs(call, arg_aggs);
                    }
                    if let Some((ridx, slot)) = ret_temp {
                        b.set_call_ret_agg(call, ridx, slot);
                        return Ok(b.local_addr(slot));
                    }
                    // A `float`-returning callee yields a single-precision
                    // value (C99 6.2.5p10 / 6.3.1.8); tag it so the result
                    // store reads the s-register view instead of narrowing
                    // the d-register a second time.
                    if is_float_ty(*ty) {
                        return Ok(b.mark_f32(call));
                    }
                    return Ok(extend_scalar_call_result(b, call, *ty, self.target));
                }
                // A function-pointer callee whose register/stack
                // placement would interleave keeps the all-integer c5
                // cdecl ABI (the pointed-to function applied the same
                // predicate to its `param_fp_mask`); widen its FP
                // arguments through the integer slots and pass mask 0.
                //
                // A variadic callee through a function pointer compiled
                // for a `variadic_int_only` host (Win64 x86_64 or Windows
                // aarch64) reads its named parameters from the integer
                // home / gr-save cells the prologue spills (its
                // `param_fp_mask` is 0) and the variadic tail rides the
                // integer register bank then the stack. Route every
                // floating-point argument through the integer registers
                // as a widened double so the call site and the callee
                // agree; SysV / Linux / macOS leave `variadic_int_only`
                // clear, so their variadic indirect lowering is
                // unchanged (macOS took the `variadic_on_stack` branch
                // above).
                let eff_fp_arg_mask = effective_fp_arg_mask(args.len(), fp_arg_mask, abi);
                let force_int_indirect =
                    callee_variadic && abi.variadic_int_only && fp_arg_mask != 0;
                let call_fp_arg_mask =
                    if force_int_indirect || (fp_arg_mask != 0 && eff_fp_arg_mask == 0) {
                        for (i, a) in args.iter().enumerate() {
                            let arg_is_fp = arg_value_ty(self.ast.expr(*a))
                                .map(is_floating_scalar)
                                .unwrap_or(false);
                            if arg_is_fp {
                                let widened = b.fp_widen_to_f64(arg_vals[i]);
                                let slot = b.alloc_synthetic_local();
                                b.store_local(slot, widened, StoreKind::I64);
                                arg_vals[i] = b.load_local(slot, LoadKind::I64);
                            }
                        }
                        0
                    } else {
                        eff_fp_arg_mask
                    };
                // Non-macOS targets keep the c5 cdecl stack-push shape
                // for the indirect call regardless of `callee_variadic`
                // (`fixed_args` is unused there); pass the prototype
                // through so only the macOS path consults it.
                let call = b.call_indirect(
                    target,
                    arg_vals,
                    callee_variadic,
                    callee_fixed,
                    fp_return,
                    call_fp_arg_mask,
                    callee_conv,
                );
                if !arg_aggs.is_empty() {
                    b.set_call_arg_aggs(call, arg_aggs);
                }
                if let Some((ridx, slot)) = ret_temp {
                    b.set_call_ret_agg(call, ridx, slot);
                    return Ok(b.local_addr(slot));
                }
                // A `float`-returning callee yields a single-precision value
                // (C99 6.2.5p10 / 6.3.1.8); tag it so the result store reads
                // the s-register view instead of narrowing the d-register a
                // second time.
                if is_float_ty(*ty) {
                    return Ok(b.mark_f32(call));
                }
                Ok(extend_scalar_call_result(b, call, *ty, self.target))
            }
            Expr::Member {
                obj,
                field_off,
                bitfield,
                ty,
                array_size,
            } => {
                if let Some(bf) = bitfield {
                    // C99 6.7.2.1: bitfield read. Address points at
                    // the field's storage unit (parser already
                    // included `field_off`).
                    let bf = *bf;
                    let ty = *ty;
                    let vol = self.expr_is_volatile(id);
                    let seg = self.bitfield_access_seg(id, ty, bf)?;
                    let base = self.walk_expr_rvalue(b, *obj)?;
                    let addr = if *field_off != 0 {
                        b.binop_imm(BinOp::Add, base, *field_off)
                    } else {
                        base
                    };
                    let align = self.member_align(*obj, *field_off, bf.unit_size as u32);
                    return Ok(self.load_from_bitfield(b, addr, bf, seg, vol, align));
                }
                let base = self.walk_expr_rvalue(b, *obj)?;
                let addr = if *field_off != 0 {
                    b.binop_imm(BinOp::Add, base, *field_off)
                } else {
                    base
                };
                // C99 6.3.2.1p3: an array-typed field decays to a
                // pointer to its first element; the field's
                // address IS the rvalue. Same address-as-value
                // rule for a struct-value field (no `*` on the
                // declared type).
                if *array_size != 0 || (is_struct_ty(*ty) && struct_ptr_depth(*ty) == 0) {
                    return Ok(addr);
                }
                let kind = load_kind_for(*ty, self.target);
                let vol = self.expr_is_volatile(id);
                let seg = self.access_seg(id, *ty)?;
                let align = self.member_align(*obj, *field_off, load_kind_width(kind));
                Ok(load_place(b, addr, kind, seg, vol, align))
            }
            Expr::Index { array, idx, ty } => {
                let arr = self.walk_expr_rvalue(b, *array)?;
                let i = self.walk_expr_rvalue(b, *idx)?;
                // The parser already scaled `idx` by the element
                // size (via `emit_binop_with_imm(BinOp::Mul, scale)`)
                // when the pointee size is non-trivial. The
                // resulting child `Binary{Mul, idx, scale}` rides
                // through `walk_expr_rvalue` above; for a
                // literal `K`, that walk folds to a single `Imm`,
                // so the address becomes `arr + Imm`. Route
                // through `binop_imm` in that case so the per-arch
                // emit picks `add r, imm12` / `add r, imm32`.
                let addr = match b.peek_imm(i) {
                    Some(k) => b.binop_imm(BinOp::Add, arr, k),
                    None => b.binop(BinOp::Add, arr, i),
                };
                // C99 6.5.2.1p2 + the c5 address-as-value rule:
                // when `ty` is a struct value (non-pointer
                // struct), `arr[i]` produces the element's
                // address as its rvalue and no load runs. The
                // wrapping `.field` / `= rhs` site handles the
                // bytes from there.
                if is_struct_ty(*ty) && struct_ptr_depth(*ty) == 0 {
                    return Ok(addr);
                }
                let kind = load_kind_for(*ty, self.target);
                let seg = self.access_seg(id, *ty)?;
                Ok(load_place(b, addr, kind, seg, self.expr_is_volatile(id), 0))
            }
            Expr::Cast { child, to_ty } => {
                let v = self.walk_expr_rvalue(b, *child)?;
                // C99 6.5.4: a cast performs a value-changing
                // conversion when the source/destination differ
                // in fp-ness. Same-class casts (int<->ptr,
                // float<->double) are bit-pattern-compatible and
                // need no op. Width-narrowing on integers is a
                // truncation the SSA emitter already handles
                // through the Store / Load kinds at the
                // surrounding sites.
                let src_ty = match self.ast.expr(*child) {
                    Expr::IntLit { ty, .. }
                    | Expr::FloatLit { ty, .. }
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
                    | Expr::ShortCircuit { ty, .. } => *ty,
                    Expr::Cast { to_ty: t, .. } => *t,
                    Expr::Sizeof(s) => s.result_ty,
                    Expr::CompoundLiteral { ty, .. } => *ty,
                    Expr::StrLit { ty, .. } => *ty,
                    Expr::Intrinsic { ty, .. } => *ty,
                    Expr::Atomic { ty, .. } => *ty,
                    Expr::VlaBase { ty, .. } => *ty,
                    Expr::VlaSizeof { .. } => Ty::Int as i64,
                    Expr::StmtExpr { ty, .. } => *ty,
                    Expr::CheckedArith { ty, .. } => *ty,
                    Expr::X86Simd { ty, .. } => *ty,
                    Expr::MemTransfer { ty, .. } => *ty,
                    // `&&label` is a `void *` (char-pointer encoding).
                    Expr::LabelAddr(_) => {
                        crate::c5::token::Ty::Char as i64 + crate::c5::token::Ty::Ptr as i64
                    }
                    // An asm statement yields no value; it is never a
                    // cast operand.
                    Expr::InlineAsm(_) => Ty::Int as i64,
                };
                // A 128-bit `__int128` rvalue is carried as its address
                // (the struct-rvalue address-as-value rule). A cast to an
                // integer or pointer loads the object's low 8 bytes (its
                // value mod 2^64); the convert then narrows to `to_ty`.
                // Without the load the address is used as the value. A
                // floating target instead converts the whole 128-bit
                // value (C99 6.3.1.4) through `int128_to_fp`.
                if self.is_int128_value_ty(src_ty) && !is_struct_ty(*to_ty) {
                    let v = self.flatten_copy_operand(b, *child, v)?;
                    if is_floating_scalar(*to_ty) {
                        let pair = self.int128_load(b, v);
                        let signed = (src_ty & UNSIGNED_BIT) == 0;
                        return Ok(self.int128_to_fp(b, pair, signed, is_float_ty(*to_ty)));
                    }
                    let low_ty = Ty::LongLong as i64 | UNSIGNED_BIT;
                    let low = b.load(v, load_kind_for(low_ty, self.target));
                    return Ok(self.convert_scalar_value(b, low, low_ty, *to_ty));
                }
                // The reverse: a scalar cast to a 128-bit `__int128`
                // materialises a 16-byte object and yields its address per
                // the same address-as-value rule. Without this the scalar
                // value stands where an address is expected.
                if !is_struct_ty(src_ty) && self.is_int128_value_ty(*to_ty) {
                    let slot = b.alloc_synthetic_struct(16);
                    let addr = b.local_addr(slot);
                    self.store_scalar_as_int128(b, addr, v, src_ty, *to_ty);
                    return Ok(addr);
                }
                Ok(self.convert_scalar_value(b, v, src_ty, *to_ty))
            }
            Expr::CompoundAssign { op, lhs, rhs, ty } => {
                // C99 6.5.16.2p3: `E1 op= E2` is `E1 = E1 op E2`
                // with E1 evaluated once. Spill the lhs address,
                // load through it, apply the binop with rhs,
                // store back. The expression's value is the new
                // (post-op) value per the same clause.
                if self.is_int128_value_ty(*ty) || self.is_wide_unit_bitfield(*lhs) {
                    return self.walk_int128_compound_assign(b, *op, *lhs, *rhs);
                }
                let load_kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let place = self.rmw_place(b, *lhs, *ty)?;
                let vol = self.rmw_is_volatile(&place, *ty, *lhs);
                let old = place.load(b, load_kind, vol);
                // Constant-rhs short-circuit (mirror of the
                // `Expr::Binary` path): an integer-literal rhs
                // routes through `binop_imm` so the per-arch
                // immediate-form peepholes fire and the literal
                // doesn't get materialised into a scratch first.
                // FP / Div / Divu / Mod / Modu stay on the
                // register-rhs path because the per-arch BinopI
                // lowering bails on them.
                let imm_safe = matches!(
                    *op,
                    BinOp::Add
                        | BinOp::Sub
                        | BinOp::Mul
                        | BinOp::And
                        | BinOp::Or
                        | BinOp::Xor
                        | BinOp::Shl
                        | BinOp::Shr
                        | BinOp::Shru
                );
                let new_val =
                    if matches!(*op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv)
                        && !is_floating_scalar(*ty)
                    {
                        // C99 6.5.16.2: an integer lvalue with a floating
                        // operand. The operation runs in the floating common
                        // type; convert the loaded integer up, apply the op,
                        // then convert the result back to the lvalue's
                        // integer type before the store.
                        let lv = b.fp_cast(FpCastKind::IntToFp, old);
                        let mut rv = self.walk_expr_rvalue(b, *rhs)?;
                        if b.is_f32(rv) {
                            rv = b.fp_widen_to_f64(rv);
                        }
                        let res = b.binop(*op, lv, rv);
                        b.fp_cast(FpCastKind::FpToInt, res)
                    } else if matches!(*op, BinOp::Fadd | BinOp::Fsub | BinOp::Fmul | BinOp::Fdiv) {
                        // C99 6.5.16.2: `E1 op= E2` computes `E1 op E2` in
                        // the operands' common type, then converts to E1's
                        // type. `old` (the lvalue) is `float` when the store
                        // is F32; the rhs may be `float` or `double`. Match
                        // the `Expr::Binary` precision rules, then narrow the
                        // result to the store width.
                        let mut lv = old;
                        let mut rv = self.walk_expr_rvalue(b, *rhs)?;
                        let op_is_f32 = b.is_f32(lv) && b.is_f32(rv);
                        if op_is_f32 {
                            let res = b.binop(*op, lv, rv);
                            b.mark_f32(res)
                        } else {
                            lv = b.fp_widen_to_f64(lv);
                            rv = b.fp_widen_to_f64(rv);
                            let res = b.binop(*op, lv, rv);
                            // Narrow the double result back to the lvalue's
                            // single precision (C99 6.3.1.5) before the store.
                            if matches!(store_kind, StoreKind::F32) {
                                b.fp_narrow_to_f32(res)
                            } else {
                                res
                            }
                        }
                    } else if imm_safe && let Expr::IntLit { val, .. } = self.ast.expr(*rhs) {
                        b.binop_imm(*op, old, *val)
                    } else {
                        let mut rhs_val = self.walk_expr_rvalue(b, *rhs)?;
                        // The walked rhs may have constant-folded to
                        // an `Imm` even when the AST shape isn't an
                        // `IntLit`; route through `binop_imm` in that
                        // case for the same reason as the
                        // `Expr::Binary` arm.
                        if imm_safe && let Some(rk) = b.peek_imm(rhs_val) {
                            b.binop_imm(*op, old, rk)
                        } else {
                            let mut lv = old;
                            // C99 6.3.1.3 + 6.3.1.8: unsigned divide /
                            // modulo at a narrower-than-register common
                            // type masks each operand first, mirroring
                            // the `Expr::Binary` lowering. Both operand
                            // types <= 4 bytes means the common type is
                            // 4 bytes (integer promotion floors at int).
                            if matches!(*op, BinOp::Divu | BinOp::Modu) {
                                let rhs_sz = expr_ty(self.ast.expr(*rhs))
                                    .map_or(8, |t| type_size_bytes(t, self.target));
                                if type_size_bytes(*ty, self.target) <= 4 && rhs_sz <= 4 {
                                    lv = b.binop_imm(BinOp::And, lv, 0xffff_ffff);
                                    rhs_val = b.binop_imm(BinOp::And, rhs_val, 0xffff_ffff);
                                }
                            }
                            b.binop(*op, lv, rhs_val)
                        }
                    };
                place.store(b, new_val, store_kind, vol);
                // C99 6.5.16.2p3: the value of `E1 op= E2` is the
                // post-update value of E1 in E1's type. For a
                // sub-64-bit lvalue the 64-bit binop result is not
                // narrowed; reload through `load_kind` so the
                // returned ValueId reflects what was actually
                // stored (with the kind's sign / zero extension).
                // A volatile lvalue is accessed exactly once per read
                // and once per write (C99 6.7.3p6); its result is the
                // stored value narrowed in a register, never a re-read.
                Ok(if matches!(load_kind, LoadKind::I64) {
                    new_val
                } else if vol {
                    if is_floating_scalar(*ty) {
                        new_val
                    } else {
                        self.narrow_int_to_ty(b, new_val, Ty::LongLong as i64, *ty)
                    }
                } else {
                    place.load(b, load_kind, false)
                })
            }
            Expr::PreInc { lvalue, by, ty } => {
                if self.is_int128_value_ty(*ty) || self.is_wide_unit_bitfield(*lvalue) {
                    return self.walk_int128_inc(b, *lvalue, *by, false);
                }
                let kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let place = self.rmw_place(b, *lvalue, *ty)?;
                let vol = self.rmw_is_volatile(&place, *ty, *lvalue);
                let old = place.load(b, kind, vol);
                let stepped = self.increment_value(b, old, *by, *ty);
                place.store(b, stepped, store_kind, vol);
                // C99 6.5.3.1p3 + 6.5.16.2: the value of `++E` is
                // the post-update value of E in E's type. Reload
                // through `kind` for sub-64-bit lvalues so a
                // surrounding test like `(++p) == 0` sees the
                // wrapped u8/u16/u32 value rather than the wider
                // Add result that overflows past the storage width.
                // A floating result is already at storage width.
                // A volatile lvalue is not re-read (C99 6.7.3p6); the
                // result is the stored value narrowed in a register.
                Ok(
                    if matches!(kind, LoadKind::I64) || is_floating_scalar(*ty) {
                        stepped
                    } else if vol {
                        self.narrow_int_to_ty(b, stepped, Ty::LongLong as i64, *ty)
                    } else {
                        place.load(b, kind, false)
                    },
                )
            }
            Expr::PostInc { lvalue, by, ty } => {
                if self.is_int128_value_ty(*ty) || self.is_wide_unit_bitfield(*lvalue) {
                    return self.walk_int128_inc(b, *lvalue, *by, true);
                }
                let kind = load_kind_for(*ty, self.target);
                let store_kind = store_kind_for(*ty, self.target);
                let place = self.rmw_place(b, *lvalue, *ty)?;
                let vol = self.rmw_is_volatile(&place, *ty, *lvalue);
                let old = place.load(b, kind, vol);
                let stepped = self.increment_value(b, old, *by, *ty);
                place.store(b, stepped, store_kind, vol);
                // C99 6.5.2.4p3: the expression's value is the
                // pre-update value (`old`).
                Ok(old)
            }
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
            } => {
                let slot = *slot_off;
                let ty = *ty;
                let array_size = *array_size;
                let init = init.clone();
                self.emit_local_init(b, slot, ty, &init)?;
                // C99 6.5.2.5p4: a compound literal is an lvalue. An
                // array decays to (and a struct is passed by) the
                // object's address; a scalar literal yields the
                // loaded value.
                let address_only = array_size != 0 || (is_struct_value_ty(ty));
                if address_only {
                    Ok(b.local_addr(slot))
                } else {
                    let kind = load_kind_for(ty, self.target);
                    Ok(b.load_local_vol(slot, kind, is_volatile_object_ty(ty)))
                }
            }
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
            Expr::Intrinsic { kind, args, .. } => {
                let intr_kind = *kind;
                // Deferred `__builtin_constant_p`: under `-O` lower the
                // side-effect-free operand for the SSA folds; otherwise
                // the answer is 0 and the operand stays unevaluated.
                if intr_kind == Intrinsic::ConstantP as i64 {
                    if !self.optimize {
                        return Ok(b.imm(0));
                    }
                    let v = self.walk_expr_rvalue(b, args[0])?;
                    return Ok(b.intrinsic(intr_kind, alloc::vec![v]));
                }
                // The va_* intrinsics receive the ADDRESS of the va_list
                // storage. The `__va_list_self(ap)` macro spells this as
                // `(ap)` on System V / AAPCS64 (the array decays to its
                // address) and `&(ap)` on the cursor targets. When `ap`
                // is `*pva` (a va_list reached through a pointer) the
                // System V form is a bare deref whose rvalue would load
                // the list's first eightbyte; the address wanted is the
                // pointer itself, so take the deref's lvalue. Operand
                // positions: arg 0 for va_start / va_arg / va_end, args 0
                // and 1 for va_copy.
                use crate::c5::op::Intrinsic as VaI;
                let va_addr_operand = |i: usize| match VaI::from_i64(intr_kind) {
                    Some(VaI::VaStart) | Some(VaI::VaArg) | Some(VaI::VaEnd) => i == 0,
                    Some(VaI::VaCopy) => i == 0 || i == 1,
                    _ => false,
                };
                let mut arg_vals: alloc::vec::Vec<ValueId> =
                    alloc::vec::Vec::with_capacity(args.len());
                for (i, a) in args.clone().into_iter().enumerate() {
                    let v = if va_addr_operand(i)
                        && matches!(
                            self.ast.expr(a),
                            Expr::Unary {
                                op: UnOp::Deref,
                                ..
                            }
                        ) {
                        self.walk_expr_lvalue(b, a)?
                    } else {
                        self.walk_expr_rvalue(b, a)?
                    };
                    arg_vals.push(v);
                }
                // fma / fmaf (C99 7.12.13.1) lower to the fused node so
                // the three operands round once. The parser has already
                // coerced the arguments to the matching FP width.
                let fma_kind = Intrinsic::Fma as i64;
                let fmaf_kind = Intrinsic::Fmaf as i64;
                if intr_kind == fma_kind || intr_kind == fmaf_kind {
                    let v = b.fma(arg_vals[0], arg_vals[1], arg_vals[2], false, false);
                    if intr_kind == fmaf_kind {
                        return Ok(b.mark_f32(v));
                    }
                    return Ok(v);
                }
                // The integer bit-count builtins lower to a portable
                // shift / mask sequence here rather than a dedicated
                // instruction, so the result is identical across the
                // interpreter and every target. clz / ctz at zero are
                // undefined in GCC; this lowering returns the bit width.
                if let Some(i) = Intrinsic::from_i64(intr_kind)
                    && i.is_int_bit_unary()
                {
                    use crate::c5::op::Intrinsic as I;
                    let x = arg_vals[0];
                    let w64 = i.is_bit_unary_64();
                    return Ok(match i {
                        I::Clz | I::Clzll => lower_clz(b, x, w64),
                        I::Ctz | I::Ctzll => lower_ctz(b, x, w64),
                        I::Clrsb | I::Clrsbll => lower_clrsb(b, x, w64),
                        I::Ffs | I::Ffsll => lower_ffs(b, x, w64),
                        I::Parity | I::Parityll => {
                            let pc = lower_popcount(b, x, w64);
                            b.binop_imm(BinOp::And, pc, 1)
                        }
                        _ => lower_popcount(b, x, w64),
                    });
                }
                // Byte reversal is a single instruction on every
                // supported target, so it lowers to a dedicated inst
                // rather than a portable shift / mask sequence.
                if let Some(i) = Intrinsic::from_i64(intr_kind)
                    && i.is_bswap()
                {
                    use crate::c5::op::Intrinsic as I;
                    let width = match i {
                        I::Bswap16 => 2,
                        I::Bswap64 => 8,
                        _ => 4,
                    };
                    return Ok(b.bswap(arg_vals[0], width));
                }
                // The unary FP math intrinsics produce an FP value; tag the
                // single-precision forms so the codegen picks the f32
                // instruction and width.
                let single =
                    Intrinsic::from_i64(intr_kind).is_some_and(|i| i.is_single_precision());
                let v = b.intrinsic(intr_kind, arg_vals);
                if single {
                    return Ok(b.mark_f32(v));
                }
                Ok(v)
            }
            Expr::InlineAsm(idx) => {
                // GCC extended asm. Each operand expression is an output
                // destination address (the parser applied `&`) or an
                // input value; the block descriptor carries the template
                // and per-operand constraints for the per-arch lowering.
                let asm = self.ast.asm_blocks[*idx as usize].clone();
                let mut args: alloc::vec::Vec<ValueId> =
                    alloc::vec::Vec::with_capacity(asm.operand_exprs.len());
                for &e in &asm.operand_exprs {
                    args.push(self.walk_expr_rvalue(b, e)?);
                }
                Ok(b.inline_asm(alloc::boxed::Box::new(asm.block), args))
            }
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
            // Pointer-arithmetic-derived lvalues: `t->f = v` lowers
            // to `*(t + field_off) = v`, the parser absorbs the
            // Deref into the address expression, and the Assign's
            // lhs reaches the walker as `Binary{Add, t, off}`.
            // The Binary's value IS the address per C99 6.5.6
            // pointer-plus-integer.
            Expr::Binary { .. } => self.walk_expr_rvalue(b, id),
            // Indexed lvalue: `arr[i] = v`. Compute the address
            // (`arr + i`) without the trailing load that
            // `walk_expr_rvalue` would emit.
            Expr::Index { array, idx, .. } => {
                let (array_id, idx_id) = (*array, *idx);
                let arr = self.walk_expr_rvalue(b, array_id)?;
                let i = self.walk_expr_rvalue(b, idx_id)?;
                // Same constant-index fold as the rvalue Index
                // path above.
                match b.peek_imm(i) {
                    Some(k) => Ok(b.binop_imm(BinOp::Add, arr, k)),
                    None => Ok(b.binop(BinOp::Add, arr, i)),
                }
            }
            // Member lvalue: `s.f = v` / `p->f = v`. Address is
            // the object's address-producer plus the field
            // offset; no trailing load.
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
            // C99 6.5.2.5p4: a compound literal is an lvalue naming an
            // unnamed object. In lvalue position (`&(T){...}`) emit the
            // initializer into the reserved slot and yield the slot's
            // address. The rvalue path handles the value-position case,
            // where a scalar literal loads the slot instead.
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
    /// integer constant expression the walker can evaluate without
    /// runtime state (C99 6.6). Returns None for any operand that
    /// needs a load, a call, or an operator outside the handled set.
    /// Used to select the live arm of a constant-condition `?:` /
    /// `if` so the dead arm's side effects -- including references to
    /// undefined symbols -- are never emitted, matching the front-end
    /// fold gcc performs even at -O0. Identifiers are not resolved, so
    /// only literal-rooted expressions fold.
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
                // Integer `/` and `%` are integer constant expressions
                // (C99 6.6) but are not immediate-foldable operators, so
                // the imm-safe predicate (shared with the BinopI rvalue
                // fold) excludes them; accept them here for the pure
                // compile-time evaluation. A zero divisor is undefined
                // and thus not a constant, so the fold declines it.
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
            // Without the SSA folds the answer is 0, so the front-end
            // dead-branch fold sees it as a constant condition. Under `-O`
            // it is not known yet and the branch stays.
            Expr::Intrinsic { kind, .. }
                if *kind == Intrinsic::ConstantP as i64 && !self.optimize =>
            {
                Some(0)
            }
            _ => None,
        }
    }

    /// Fold `lhs op rhs` when both are address constants over the same
    /// object. C99 6.5.8p5 / 6.5.9p6 define the result of comparing two
    /// pointers into one object as the comparison of their offsets, and
    /// that answer is fixed at translation time even though the object's
    /// own address is not. Addresses over *different* objects are left
    /// alone: their relative order is chosen by the data layout.
    ///
    /// An address constant against a null pointer constant also folds
    /// (equality only): C99 6.3.2.3p3 guarantees the address of an
    /// object or function compares unequal to null, provided the named
    /// symbol is defined in this unit and not weak -- an undefined or
    /// weak reference may bind to address zero. The offset must be
    /// zero: a converted address plus an arbitrary integer may wrap.
    /// This is the front-end fold GCC performs at every level.
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
        // The base cancels, so the ordering of the addresses is the
        // ordering of the offsets as integers; the pointer comparisons'
        // unsigned forms would wrap on a negative offset.
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
                // The symbol table entry is reused when a name is
                // shadowed, so the parse-time data offset (or a
                // function's entry PC) pins the object the identifier
                // named here.
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
            // Integer -> FP (C99 6.3.1.4), one rounding to the target
            // type. An unsigned 64-bit source can exceed the signed
            // range, where the signed convert yields a negative result,
            // so it takes the unsigned converter. Narrower unsigned
            // types fit the signed range zero-extended.
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
            // FP -> integer (C99 6.3.1.4) truncates toward zero. An
            // unsigned 64-bit target can hold a value in [2^63, 2^64),
            // which the signed truncate would saturate, so it takes the
            // unsigned converter (a `float` source widens to f64 for it).
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
