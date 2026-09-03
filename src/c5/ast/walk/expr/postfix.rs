//! Postfix expressions: calls, member access, subscripting,
//! postfix increment and compound literals (C99 6.5.2).

use super::super::access::{load_kind_for, load_kind_width, load_place, store_kind_for};
use super::super::types::{
    arg_value_ty, extend_scalar_call_result, is_float_ty, is_floating_scalar,
};
use super::super::*;
/// A struct or union member access (C99 6.5.2.3), shared by the read and
/// the bitfield write.
pub(super) struct MemberRef {
    /// Address producer for the containing object.
    pub obj: ExprId,
    /// Byte offset of the member. For a bitfield the parser has already
    /// pointed it at the storage unit.
    pub field_off: i64,
    /// The member's type.
    pub ty: i64,
}

impl<'a> Walker<'a> {
    /// C99 6.5.2.2 function call.
    pub(super) fn walk_call(
        &mut self,
        b: &mut SsaBuilder,
        callee: ExprId,
        args: &'a [ExprId],
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let callee_conv = self.callee_conv(callee);
        // Out-pointer-returning c5-internal callee: allocate a
        // result temp on this frame, prepend its address as the
        // hidden out-pointer arg 0, run the call, and return the
        // temp's address as the expression's value (the c5 ABI's
        // address-as-value rule for struct rvalues). Host-ABI
        // returns (registers / x8) carry no hidden argument and
        // fall through to the normal call path below, which
        // tags the call's `ret_agg` / `ret_slot`.
        if is_struct_ty(ty)
            && struct_ptr_depth(ty) == 0
            && matches!(
                crate::c5::compiler::struct_return_abi_conv(
                    self.structs,
                    self.target,
                    callee_conv,
                    ty
                ),
                crate::c5::compiler::StructReturnAbi::OutPtr
            )
            && let Expr::Ident {
                sym, class, val, ..
            } = self.ast.expr(callee)
            && *class == Token::Fun as i64
        {
            // The callee writes the whole struct through the
            // out-pointer, so the result temp must hold
            // `sizeof(struct)` bytes, not a single slot.
            let result_size = self.struct_size(ty);
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
        let indirect_target: Option<ValueId> = if let Expr::Ident { .. } = self.ast.expr(callee) {
            None
        } else {
            Some(self.walk_expr_rvalue(b, callee)?)
        };
        let mut arg_vals: alloc::vec::Vec<ValueId> = alloc::vec::Vec::with_capacity(args.len());
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
        } = self.ast.expr(callee)
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
                                    if is_struct_value_ty(aty) && self.struct_size(aty) <= 8 =>
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
                    let fp_return = is_floating_scalar(ty);
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
                            ty,
                        )
                    {
                        let ridx = b.intern_agg_desc(desc.clone());
                        let slot = b.alloc_synthetic_struct(desc.size as i64);
                        b.set_call_ret_agg(call, ridx, slot);
                        return Ok(b.local_addr(slot));
                    }
                    if is_float_ty(ty) {
                        return Ok(b.mark_f32(call));
                    }
                    // An external (`target_pc == 0`) callee may per
                    // AAPCS leave a narrow return's high bits
                    // undefined; extend to keep the walker's
                    // sign/zero-extended-to-64-bits invariant. An
                    // intra-TU callee already returns full width.
                    return Ok(if !self.symbols[*sym as usize].defined_here {
                        extend_scalar_call_result(b, call, ty, self.target)
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
                if callee_variadic && (abi.sysv_host_variadic() || abi.aarch64_host_variadic()) {
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
                    let fp_return = is_floating_scalar(ty);
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
                            ty,
                        )
                    {
                        let ridx = b.intern_agg_desc(desc.clone());
                        let slot = b.alloc_synthetic_struct(desc.size as i64);
                        b.set_call_ret_agg(call, ridx, slot);
                        return Ok(b.local_addr(slot));
                    }
                    if is_float_ty(ty) {
                        return Ok(b.mark_f32(call));
                    }
                    // An external (`target_pc == 0`) callee may per
                    // AAPCS leave a narrow return's high bits
                    // undefined; extend to keep the walker's
                    // sign/zero-extended-to-64-bits invariant. An
                    // intra-TU callee already returns full width.
                    return Ok(if !self.symbols[*sym as usize].defined_here {
                        extend_scalar_call_result(b, call, ty, self.target)
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
                let force_int = callee_variadic || (fp_arg_mask != 0 && eff_fp_arg_mask == 0);
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
                let fp_return = is_floating_scalar(ty);
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
                        ty,
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
                if is_float_ty(ty) {
                    return Ok(b.mark_f32(call));
                }
                // An external (`target_pc == 0`) callee may per
                // AAPCS leave a narrow return's high bits undefined;
                // extend to keep the walker's sign/zero-extended-to-
                // 64-bits invariant. An intra-TU callee already
                // returns full width.
                return Ok(if !self.symbols[*sym as usize].defined_here {
                    extend_scalar_call_result(b, call, ty, self.target)
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
                if is_struct_ty(ty)
                    && struct_ptr_depth(ty) == 0
                    && matches!(
                        crate::c5::compiler::struct_return_abi(self.structs, self.target, ty),
                        crate::c5::compiler::StructReturnAbi::OutPtr
                    )
                {
                    let result_size = self.struct_size(ty);
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
                        ty,
                    ) {
                    let ridx = b.intern_agg_desc(desc.clone());
                    let slot = b.alloc_synthetic_struct(desc.size as i64);
                    Some((ridx, slot))
                } else {
                    None
                };
                let fp_return = is_floating_scalar(ty);
                let call = b.call_ext(*val, arg_vals, fp_arg_mask, fp_return);
                if !ext_arg_aggs.is_empty() {
                    b.set_call_arg_aggs(call, ext_arg_aggs);
                }
                if let Some((ridx, slot)) = ret_temp {
                    b.set_call_ret_agg(call, ridx, slot);
                    return Ok(b.local_addr(slot));
                }
                if is_float_ty(ty) {
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
        let (callee_variadic, callee_fixed) = self.indirect_callee_proto(callee, args.len());
        // The pointed-to function's own calling convention drives
        // the argument placement, so every ABI question below --
        // which variadic dialect applies, whether a floating-point
        // argument rides the FP bank -- is asked of it rather than
        // of the target's default.
        let abi = self.target.abi_for(callee_conv);
        let target = match indirect_target {
            Some(t) => t,
            None => self.walk_expr_rvalue(b, callee)?,
        };
        let fp_return = is_floating_scalar(ty);
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
            crate::c5::compiler::struct_return_abi_conv(self.structs, self.target, callee_conv, ty),
            crate::c5::compiler::StructReturnAbi::OutPtr
        ) {
            // The callee writes the whole struct through the
            // out-pointer, so the result temp must hold
            // `sizeof(struct)` bytes.
            let result_size = self.struct_size(ty);
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
            let call = b.call_indirect(target, all_args, false, fixed, false, 0, callee_conv);
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
            crate::c5::compiler::struct_return_abi_conv(self.structs, self.target, callee_conv, ty)
        {
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
            if is_float_ty(ty) {
                return Ok(b.mark_f32(call));
            }
            return Ok(extend_scalar_call_result(b, call, ty, self.target));
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
            if is_float_ty(ty) {
                return Ok(b.mark_f32(call));
            }
            return Ok(extend_scalar_call_result(b, call, ty, self.target));
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
        let force_int_indirect = callee_variadic && abi.variadic_int_only && fp_arg_mask != 0;
        let call_fp_arg_mask = if force_int_indirect || (fp_arg_mask != 0 && eff_fp_arg_mask == 0) {
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
        if is_float_ty(ty) {
            return Ok(b.mark_f32(call));
        }
        Ok(extend_scalar_call_result(b, call, ty, self.target))
    }

    /// C99 6.5.2.3 member access.
    pub(super) fn walk_member(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
        m: MemberRef,
        bitfield: Option<BitfieldDesc>,
        array_size: i64,
    ) -> Result<ValueId, WalkError> {
        let MemberRef { obj, field_off, ty } = m;
        if let Some(bf) = bitfield {
            // C99 6.7.2.1: bitfield read. Address points at
            // the field's storage unit (parser already
            // included `field_off`).
            let vol = self.expr_is_volatile(id);
            let seg = self.bitfield_access_seg(id, ty, bf)?;
            let base = self.walk_expr_rvalue(b, obj)?;
            let addr = if field_off != 0 {
                b.binop_imm(BinOp::Add, base, field_off)
            } else {
                base
            };
            let align = self.member_align(obj, field_off, bf.unit_size as u32);
            return Ok(self.load_from_bitfield(b, addr, bf, seg, vol, align));
        }
        let base = self.walk_expr_rvalue(b, obj)?;
        let addr = if field_off != 0 {
            b.binop_imm(BinOp::Add, base, field_off)
        } else {
            base
        };
        // C99 6.3.2.1p3: an array-typed field decays to a
        // pointer to its first element; the field's
        // address IS the rvalue. Same address-as-value
        // rule for a struct-value field (no `*` on the
        // declared type).
        if array_size != 0 || (is_struct_ty(ty) && struct_ptr_depth(ty) == 0) {
            return Ok(addr);
        }
        let kind = load_kind_for(ty, self.target);
        let vol = self.expr_is_volatile(id);
        let seg = self.access_seg(id, ty)?;
        let align = self.member_align(obj, field_off, load_kind_width(kind));
        Ok(load_place(b, addr, kind, seg, vol, align))
    }

    /// C99 6.5.2.1 array subscript.
    pub(super) fn walk_index(
        &mut self,
        b: &mut SsaBuilder,
        id: ExprId,
        array: ExprId,
        idx: ExprId,
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let arr = self.walk_expr_rvalue(b, array)?;
        let i = self.walk_expr_rvalue(b, idx)?;
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
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            return Ok(addr);
        }
        let kind = load_kind_for(ty, self.target);
        let seg = self.access_seg(id, ty)?;
        Ok(load_place(b, addr, kind, seg, self.expr_is_volatile(id), 0))
    }

    /// C99 6.5.2.4 / 6.5.3.1: step an lvalue by `by`. The expression's
    /// value is the pre-update value for the postfix form and the
    /// post-update value, in the lvalue's own type, for the prefix form.
    pub(super) fn walk_inc(
        &mut self,
        b: &mut SsaBuilder,
        lvalue: ExprId,
        by: i64,
        ty: i64,
        post: bool,
    ) -> Result<ValueId, WalkError> {
        if self.is_int128_value_ty(ty) || self.is_wide_unit_bitfield(lvalue) {
            return self.walk_int128_inc(b, lvalue, by, post);
        }
        let kind = load_kind_for(ty, self.target);
        let store_kind = store_kind_for(ty, self.target);
        let place = self.rmw_place(b, lvalue, ty)?;
        let vol = self.rmw_is_volatile(&place, ty, lvalue);
        let old = place.load(b, kind, vol);
        let stepped = self.increment_value(b, old, by, ty);
        place.store(b, stepped, store_kind, vol);
        if post {
            return Ok(old);
        }
        // Reload through `kind` for a sub-64-bit lvalue so a surrounding
        // test like `(++p) == 0` sees the wrapped value rather than the
        // wider Add result. A floating result is already at storage width,
        // and a volatile lvalue is not re-read (C99 6.7.3p6) -- its result
        // is the stored value narrowed in a register.
        Ok(if matches!(kind, LoadKind::I64) || is_floating_scalar(ty) {
            stepped
        } else if vol {
            self.narrow_int_to_ty(b, stepped, Ty::LongLong as i64, ty)
        } else {
            place.load(b, kind, false)
        })
    }

    /// C99 6.5.2.5 compound literal.
    pub(super) fn walk_compound_literal(
        &mut self,
        b: &mut SsaBuilder,
        slot_off: i64,
        ty: i64,
        array_size: i64,
        init: &'a LocalInit,
    ) -> Result<ValueId, WalkError> {
        self.emit_local_init(b, slot_off, ty, init)?;
        // C99 6.5.2.5p4: a compound literal is an lvalue, so an array
        // decays to (and a struct is passed by) the object's address; a
        // scalar literal yields the loaded value.
        if array_size != 0 || is_struct_value_ty(ty) {
            Ok(b.local_addr(slot_off))
        } else {
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_local_vol(slot_off, kind, is_volatile_object_ty(ty)))
        }
    }
}
