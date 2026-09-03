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

/// One call site's arguments and the ABI facts that place them.
struct CallArgs<'e> {
    /// Argument expressions in source order.
    exprs: &'e [ExprId],
    /// The value each argument lowered to.
    vals: alloc::vec::Vec<ValueId>,
    /// Bit per argument, set when the argument is a floating-point scalar,
    /// so `plan_call_args` places it in the right register bank.
    fp_mask: u32,
    /// The convention the callee declares.
    conv: crate::c5::codegen::CallConv,
    /// The call expression's type.
    ty: i64,
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
        if self.returns_through_out_ptr(callee_conv, ty)
            && let Expr::Ident {
                sym, class, val, ..
            } = self.ast.expr(callee)
            && *class == Token::Fun as i64
        {
            return self.call_direct_out_ptr(b, *sym, *val, args, ty);
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
        let call_args = CallArgs {
            exprs: args,
            vals: arg_vals,
            fp_mask: fp_arg_mask,
            conv: callee_conv,
            ty,
        };
        if let Expr::Ident {
            sym, class, val, ..
        } = self.ast.expr(callee)
        {
            if *class == Token::Fun as i64 {
                return self.call_direct(b, *sym, *val, call_args);
            }
            if *class == Token::Sys as i64 {
                return self.call_binding(b, *sym, *val, call_args);
            }
        }
        self.call_through_pointer(b, callee, indirect_target, call_args)
    }

    /// True when the call returns its aggregate through the c5
    /// out-pointer convention: the caller allocates the result object
    /// and passes its address as the hidden first argument.
    fn returns_through_out_ptr(&self, conv: crate::c5::codegen::CallConv, ty: i64) -> bool {
        matches!(
            crate::c5::compiler::struct_return_abi_conv(self.structs, self.target, conv, ty),
            crate::c5::compiler::StructReturnAbi::OutPtr
        )
    }

    /// A direct call whose c5 out-pointer return prepends the result
    /// address as argument 0. The expression yields the result temp's
    /// address, per the c5 address-as-value rule for struct rvalues.
    fn call_direct_out_ptr(
        &mut self,
        b: &mut SsaBuilder,
        sym: u32,
        val: i64,
        args: &'a [ExprId],
        ty: i64,
    ) -> Result<ValueId, WalkError> {
        let (result_slot, out_arg) = self.out_ptr_arg(b, ty);
        let mut all_args: alloc::vec::Vec<ValueId> = alloc::vec::Vec::with_capacity(args.len() + 1);
        all_args.push(out_arg);
        for a in args {
            let mut v = self.walk_expr_rvalue(b, *a)?;
            // The all-integer cdecl carries each argument in an 8-byte
            // integer cell, where the callee reads a floating-point
            // parameter as a double. A `double` already occupies eight
            // bytes; a `float` must be widened to that pattern and reloaded
            // through an integer slot, or only its 4-byte form reaches the
            // low half and the f64 read sees noise in the high half.
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
        let target_pc = self.live_fun_val(sym, val);
        // The result is an address, never an FP scalar, so `fp_return` is
        // false; the callee keeps the c5 cdecl shape -- the hidden
        // out-pointer shifts every parameter cell, which excludes it from
        // `param_fp_mask` -- so `fp_arg_mask` is 0.
        //
        // The out-pointer is a fixed argument. A variadic struct-returning
        // callee still passes its variadic tail per the host variadic ABI,
        // so `fixed_args` counts the out-pointer plus the callee's named
        // parameters; a non-variadic callee keeps every argument fixed.
        let fixed_args = if self.fun_is_variadic(sym) {
            1 + self.fun_fixed_args(sym)
        } else {
            all_args.len()
        };
        let _ = emit_direct_call(b, target_pc, sym, all_args, fixed_args, false, 0);
        Ok(b.local_addr(result_slot))
    }

    /// A direct call to a function this unit declares (`Token::Fun`).
    fn call_direct(
        &mut self,
        b: &mut SsaBuilder,
        sym: u32,
        val: i64,
        mut args: CallArgs<'a>,
    ) -> Result<ValueId, WalkError> {
        let (conv, ty, fp_mask) = (args.conv, args.ty, args.fp_mask);
        let callee_variadic = self.fun_is_variadic(sym);
        let abi = self.target.abi_for(conv);
        // A variadic callee's prototype records the pre-ellipsis
        // parameters in `Symbol::params`; `exprs[fixed_args..]` are the
        // variadic arguments. Every argument of a non-variadic callee is
        // fixed.
        let fixed_args = if callee_variadic {
            self.fun_fixed_args(sym).min(args.exprs.len())
        } else {
            args.exprs.len()
        };
        let arg_aggs = self.direct_arg_aggs(b, sym, &mut args, callee_variadic);
        // C99 6.5.2.2p7 + the host ABI: a floating-point scalar argument
        // rides an FP argument register, and a `float` stays at single
        // precision -- the callee narrows back from the s-register view.
        //
        // Under a host variadic ABI the variadic floating-point arguments
        // widen to `double` (C99 6.5.2.2p6 default argument promotions) but
        // stay FP-classed: on the register-save hosts (System V AMD64 on
        // Linux x86_64, AAPCS64 on Linux aarch64) they ride an FP argument
        // register, and on macOS arm64, which places every variadic
        // argument on the stack at 8-byte stride, the 8-byte store reads
        // back as a double. The named arguments keep their FP-bank
        // placement either way, so the call passes the real `fp_mask`.
        if callee_variadic
            && (abi.variadic_on_stack || abi.sysv_host_variadic() || abi.aarch64_host_variadic())
        {
            self.widen_variadic_fp(b, &mut args, fixed_args);
            let fp_return = is_floating_scalar(ty);
            let target_pc = self.live_fun_val(sym, val);
            let call =
                emit_direct_call(b, target_pc, sym, args.vals, fixed_args, fp_return, fp_mask);
            if !arg_aggs.is_empty() {
                b.set_call_arg_aggs(call, arg_aggs);
            }
            let ret_temp = self.call_ret_temp(b, conv, ty);
            let extend = !self.symbols[sym as usize].defined_here;
            return Ok(self.call_result(b, call, ret_temp, ty, extend));
        }
        // A variadic callee reaching here is on a `variadic_int_only` host
        // (the Microsoft calling conventions): its named and variadic
        // arguments ride the integer register bank, a floating-point
        // argument as its raw bit pattern. The same widening covers a
        // non-variadic callee whose register / stack placement would
        // interleave, which the c5 cdecl cell layout does not admit.
        let eff_fp_mask = effective_fp_arg_mask(args.exprs.len(), fp_mask, abi);
        let call_fp_mask = if callee_variadic || (fp_mask != 0 && eff_fp_mask == 0) {
            self.widen_fp_through_int(b, &mut args, is_floating_scalar);
            0
        } else {
            eff_fp_mask
        };
        // C99 6.2.5p10: a floating-point return rides the FP return
        // register; tag the call so the codegen reads it there.
        let fp_return = is_floating_scalar(ty);
        let target_pc = self.live_fun_val(sym, val);
        // Reserve the aggregate return temp before the call: its frame slot
        // rides on the call instruction, so it survives value renumbering
        // and needs no SSA operand.
        let ret_temp = self.call_ret_temp(b, conv, ty);
        let call = emit_direct_call(
            b,
            target_pc,
            sym,
            args.vals,
            fixed_args,
            fp_return,
            call_fp_mask,
        );
        if !arg_aggs.is_empty() {
            b.set_call_arg_aggs(call, arg_aggs);
        }
        let extend = !self.symbols[sym as usize].defined_here;
        Ok(self.call_result(b, call, ret_temp, ty, extend))
    }

    /// Tag each by-value aggregate argument of a direct call with its
    /// host-ABI layout, so the caller marshals it into the argument
    /// registers and stack slots the callee reads (AAPCS64 6.8.2 / System V
    /// 3.2.3). A named parameter classifies by its declared type and a
    /// variadic argument by its own; a variadic aggregate of at most one
    /// eightbyte rides as a single loaded integer in the variadic slot
    /// (C99 6.5.2.2), and a larger one routes through the host-ABI
    /// placement so `va_arg` reads its eightbytes contiguously. A variadic
    /// callee's named aggregate keeps the c5 by-address convention, which
    /// its prologue expects. Inert on the ABIs and sizes the classifier
    /// declines.
    ///
    /// TODO: pass the second eightbyte of a variadic aggregate wider than
    /// one eightbyte, which stays on the address path.
    fn direct_arg_aggs(
        &mut self,
        b: &mut SsaBuilder,
        sym: u32,
        args: &mut CallArgs<'_>,
        callee_variadic: bool,
    ) -> alloc::vec::Vec<Option<u32>> {
        let mut arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
        let nparams = self.symbols[sym as usize].params.len();
        for i in 0..args.vals.len() {
            let agg_ty = if i < nparams {
                Some(self.symbols[sym as usize].params[i])
            } else {
                match arg_value_ty(self.ast.expr(args.exprs[i])) {
                    Some(aty) if is_struct_value_ty(aty) && self.struct_size(aty) <= 8 => {
                        args.vals[i] = b.load(args.vals[i], LoadKind::I64);
                        None
                    }
                    other => other,
                }
            };
            let Some(ty_tag) = agg_ty else {
                continue;
            };
            if callee_variadic && i < nparams {
                continue;
            }
            if let Some(desc) = crate::c5::compiler::host_abi_agg_desc_conv(
                self.structs,
                self.target,
                args.conv,
                ty_tag,
            ) {
                if arg_aggs.is_empty() {
                    arg_aggs = alloc::vec![None; args.vals.len()];
                }
                arg_aggs[i] = Some(b.intern_agg_desc(desc));
            }
        }
        arg_aggs
    }

    /// Reserve the frame temp an aggregate return lands in, with its
    /// interned descriptor. `None` when the return is not an aggregate the
    /// host ABI hands back in the result registers or through the
    /// indirect-result register.
    fn call_ret_temp(
        &self,
        b: &mut SsaBuilder,
        conv: crate::c5::codegen::CallConv,
        ty: i64,
    ) -> Option<(u32, i64)> {
        if let crate::c5::compiler::StructReturnAbi::Regs(desc)
        | crate::c5::compiler::StructReturnAbi::Indirect(desc) =
            crate::c5::compiler::struct_return_abi_conv(self.structs, self.target, conv, ty)
        {
            let ridx = b.intern_agg_desc(desc.clone());
            let slot = b.alloc_synthetic_struct(desc.size as i64);
            return Some((ridx, slot));
        }
        None
    }

    /// The value a call expression yields. An aggregate return is the
    /// temp's address, which the codegen fills from the result registers or
    /// has the callee write through the indirect-result pointer; a `float`
    /// result is tagged single-precision (C99 6.2.5p10 / 6.3.1.8). `extend`
    /// widens a narrow scalar return whose high bits the callee may leave
    /// undefined.
    fn call_result(
        &self,
        b: &mut SsaBuilder,
        call: ValueId,
        ret_temp: Option<(u32, i64)>,
        ty: i64,
        extend: bool,
    ) -> ValueId {
        if let Some((ridx, slot)) = ret_temp {
            b.set_call_ret_agg(call, ridx, slot);
            return b.local_addr(slot);
        }
        if is_float_ty(ty) {
            return b.mark_f32(call);
        }
        if extend {
            return extend_scalar_call_result(b, call, ty, self.target);
        }
        call
    }

    /// C99 6.5.2.2p6: widen each variadic floating-point argument to
    /// `double`, kept FP-classed.
    fn widen_variadic_fp(&self, b: &mut SsaBuilder, args: &mut CallArgs<'_>, fixed: usize) {
        for (i, a) in args.exprs.iter().enumerate() {
            if i < fixed {
                continue;
            }
            if arg_value_ty(self.ast.expr(*a))
                .map(is_floating_scalar)
                .unwrap_or(false)
            {
                args.vals[i] = b.fp_widen_to_f64(args.vals[i]);
            }
        }
    }

    /// Route each selected floating-point argument through an integer slot
    /// as a widened `double`, which is the 8-byte pattern the all-integer
    /// cdecl reads a floating-point parameter from. Without the round trip
    /// a `float` reaches the callee as its 4-byte form in the low half.
    fn widen_fp_through_int(
        &self,
        b: &mut SsaBuilder,
        args: &mut CallArgs<'_>,
        select: fn(i64) -> bool,
    ) {
        for (i, a) in args.exprs.iter().enumerate() {
            if arg_value_ty(self.ast.expr(*a)).map(select).unwrap_or(false) {
                let widened = b.fp_widen_to_f64(args.vals[i]);
                let slot = b.alloc_synthetic_local();
                b.store_local(slot, widened, StoreKind::I64);
                args.vals[i] = b.load_local(slot, LoadKind::I64);
            }
        }
    }

    /// A call to a libc binding (`Token::Sys`), which follows the host
    /// ABI rather than the c5 cdecl shape. `val` is the binding's flat
    /// index across the `#pragma binding(...)` directives, which is what
    /// `Inst::CallExt` takes.
    fn call_binding(
        &mut self,
        b: &mut SsaBuilder,
        sym: u32,
        val: i64,
        args: CallArgs<'a>,
    ) -> Result<ValueId, WalkError> {
        // A returns-twice callee (the setjmp family, vfork) disables
        // spill-slot sharing in this function; see
        // `FunctionSsa::has_returns_twice_call`.
        if crate::c5::ir::returns_twice_fn_name(&self.symbols[sym as usize].name) {
            b.mark_returns_twice();
        }
        // A by-value struct argument to a libc binding is packed into the
        // platform-ABI argument registers (System V / AAPCS64: at most 16
        // bytes), not passed by the c5 address convention. Tag each so the
        // emitter classifies and marshals it.
        let mut arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
        let nparams = self.symbols[sym as usize].params.len();
        for i in 0..args.vals.len() {
            let arg_ty = if i < nparams {
                self.symbols[sym as usize].params[i]
            } else {
                match arg_value_ty(self.ast.expr(args.exprs[i])) {
                    Some(t) => t,
                    None => continue,
                }
            };
            if is_struct_value_ty(arg_ty)
                && let Some(desc) =
                    crate::c5::compiler::host_abi_agg_desc(self.structs, self.target, arg_ty)
            {
                if arg_aggs.is_empty() {
                    arg_aggs = alloc::vec![None; args.vals.len()];
                }
                arg_aggs[i] = Some(b.intern_agg_desc(desc));
            }
        }
        let (ty, fp_mask) = (args.ty, args.fp_mask);
        // System V AMD64 MEMORY class / Win64 oversize: the caller
        // allocates the result buffer and passes its address as the hidden
        // first integer argument; the callee writes through it and returns
        // it. The FP-argument mask and the aggregate descriptors shift one
        // slot to follow it. AArch64 returns this size through the
        // indirect-result register, which the `ret_agg` path below covers.
        if matches!(
            crate::c5::compiler::struct_return_abi(self.structs, self.target, ty),
            crate::c5::compiler::StructReturnAbi::OutPtr
        ) {
            let (result_slot, out_arg) = self.out_ptr_arg(b, ty);
            let mut shifted: alloc::vec::Vec<ValueId> =
                alloc::vec::Vec::with_capacity(args.vals.len() + 1);
            shifted.push(out_arg);
            shifted.extend_from_slice(&args.vals);
            let call = b.call_ext(val, shifted, fp_mask << 1, false);
            if !arg_aggs.is_empty() {
                let mut s = alloc::vec![None; args.vals.len() + 1];
                s[1..].clone_from_slice(&arg_aggs);
                b.set_call_arg_aggs(call, s);
            }
            return Ok(b.local_addr(result_slot));
        }
        // A floating-point return is FP-classed (C99 6.2.5p10) so the
        // result rides d0 / xmm0 without a GPR bridge.
        let ret_temp = self.call_ret_temp(b, args.conv, ty);
        let fp_return = is_floating_scalar(ty);
        let call = b.call_ext(val, args.vals, fp_mask, fp_return);
        if !arg_aggs.is_empty() {
            b.set_call_arg_aggs(call, arg_aggs);
        }
        // A narrow return is extended by `return_extension` at the CallExt
        // lowering, keyed on the binding's declared return type, which
        // leaves an unprototyped binding unextended rather than truncating
        // a value that is really a pointer.
        Ok(self.call_result(b, call, ret_temp, ty, false))
    }

    /// A call through a function pointer: the pointed-to prototype
    /// drives the argument placement and the variadic dialect.
    fn call_through_pointer(
        &mut self,
        b: &mut SsaBuilder,
        callee: ExprId,
        indirect_target: Option<ValueId>,
        mut args: CallArgs<'a>,
    ) -> Result<ValueId, WalkError> {
        let (conv, ty, fp_mask) = (args.conv, args.ty, args.fp_mask);
        // The pointed-to function's variadic-ness and named-parameter count
        // come from the callee's static type: a function-pointer Ident
        // carries the prototype on its symbol, propagated from the typedef
        // at declaration. A callee with no statically known prototype -- the
        // result of a comma operator, say -- defaults to non-variadic and
        // all-fixed.
        //
        // TODO: a variadic call through a function pointer whose prototype
        // is not statically recoverable here (a pointer received as a
        // parameter, or loaded through a non-typedef path) takes the
        // all-fixed default and, under `variadic_on_stack`, places the
        // variadic tail in registers rather than on the stack the callee's
        // va_arg walks. Carrying the prototype on the pointer's type rather
        // than on the variable symbol would close this.
        let (callee_variadic, callee_fixed) = self.indirect_callee_proto(callee, args.exprs.len());
        // Every ABI question below -- which variadic dialect applies,
        // whether a floating-point argument rides the FP bank -- is asked of
        // the pointed-to function's own convention, not the target's
        // default.
        let abi = self.target.abi_for(conv);
        let target = match indirect_target {
            Some(t) => t,
            None => self.walk_expr_rvalue(b, callee)?,
        };
        let fp_return = is_floating_scalar(ty);
        let arg_aggs = self.indirect_arg_aggs(b, &args, callee_variadic, callee_fixed);
        // An out-pointer-returning function uses the all-integer cdecl --
        // its prologue skips the FP bank -- so the call is non-variadic with
        // FP mask 0 and every argument, the hidden out-pointer included, is
        // fixed.
        if self.returns_through_out_ptr(conv, ty) {
            let (result_slot, out_arg) = self.out_ptr_arg(b, ty);
            self.widen_fp_through_int(b, &mut args, is_float_ty);
            let mut all_args: alloc::vec::Vec<ValueId> =
                alloc::vec::Vec::with_capacity(args.vals.len() + 1);
            all_args.push(out_arg);
            all_args.extend_from_slice(&args.vals);
            let fixed = all_args.len();
            let call = b.call_indirect(target, all_args, false, fixed, false, 0, conv);
            if !arg_aggs.is_empty() {
                // The hidden out-pointer takes slot 0, so the aggregate
                // descriptors shift by one.
                let mut shifted = alloc::vec![None; arg_aggs.len() + 1];
                shifted[1..].clone_from_slice(&arg_aggs);
                b.set_call_arg_aggs(call, shifted);
            }
            return Ok(b.local_addr(result_slot));
        }
        let ret_temp = self.call_ret_temp(b, conv, ty);
        // Under a host variadic ABI the variadic floating-point arguments
        // widen to `double` (C99 6.5.2.2p6) but stay FP-classed: the
        // register-save hosts (System V AMD64 on Linux x86_64, AAPCS64 on
        // Linux aarch64) place them in xmm0..xmm7 / d0..d7, and macOS arm64
        // stores them on the stack at 8-byte stride where the read is a
        // double. The named arguments keep their AAPCS64 placement, so the
        // call passes the real `fp_mask`; on x86_64 the emit sets `al` to
        // the XMM-argument count at the call site.
        if callee_variadic
            && (abi.variadic_on_stack || abi.sysv_host_variadic() || abi.aarch64_host_variadic())
        {
            self.widen_variadic_fp(b, &mut args, callee_fixed);
            let call = b.call_indirect(
                target,
                args.vals,
                true,
                callee_fixed,
                fp_return,
                fp_mask,
                conv,
            );
            if !arg_aggs.is_empty() {
                b.set_call_arg_aggs(call, arg_aggs);
            }
            return Ok(self.call_result(b, call, ret_temp, ty, true));
        }
        // A callee whose register / stack placement would interleave keeps
        // the all-integer c5 cdecl ABI -- the pointed-to function applied
        // the same predicate to its `param_fp_mask` -- so its floating-point
        // arguments go through the integer slots and the call passes mask 0.
        //
        // A variadic callee compiled for a `variadic_int_only` host (the
        // Microsoft conventions) reads its named parameters from the integer
        // home cells its prologue spills and takes its variadic tail in the
        // integer register bank, so the same routing applies. The
        // register-save and stack hosts returned above.
        let eff_fp_mask = effective_fp_arg_mask(args.exprs.len(), fp_mask, abi);
        let force_int = callee_variadic && abi.variadic_int_only && fp_mask != 0;
        let call_fp_mask = if force_int || (fp_mask != 0 && eff_fp_mask == 0) {
            self.widen_fp_through_int(b, &mut args, is_floating_scalar);
            0
        } else {
            eff_fp_mask
        };
        // Non-macOS targets keep the c5 cdecl stack-push shape for the
        // indirect call regardless of `callee_variadic` (`fixed_args` is
        // unused there); the prototype is passed through so only the macOS
        // path consults it.
        let call = b.call_indirect(
            target,
            args.vals,
            callee_variadic,
            callee_fixed,
            fp_return,
            call_fp_mask,
            conv,
        );
        if !arg_aggs.is_empty() {
            b.set_call_arg_aggs(call, arg_aggs);
        }
        Ok(self.call_result(b, call, ret_temp, ty, true))
    }

    /// Tag each by-value aggregate argument of an indirect call with its
    /// host-ABI layout. The arguments classify by the pointed-to
    /// prototype's parameter types (System V AMD64 3.2.3 / AAPCS64 6.4,
    /// 6.8.2): the parser narrows each argument to its parameter type
    /// before the call, so the argument's own type is that parameter type.
    /// A variadic argument keeps the by-address convention, matching the
    /// direct-call path. Inert on the ABIs, sizes and by-address aggregates
    /// the classifier declines.
    fn indirect_arg_aggs(
        &mut self,
        b: &mut SsaBuilder,
        args: &CallArgs<'_>,
        callee_variadic: bool,
        callee_fixed: usize,
    ) -> alloc::vec::Vec<Option<u32>> {
        let mut arg_aggs: alloc::vec::Vec<Option<u32>> = alloc::vec::Vec::new();
        for i in 0..args.vals.len() {
            if callee_variadic && i >= callee_fixed {
                continue;
            }
            let Some(aty) = arg_value_ty(self.ast.expr(args.exprs[i])) else {
                continue;
            };
            if !is_struct_value_ty(aty) {
                continue;
            }
            if let Some(desc) = crate::c5::compiler::host_abi_agg_desc_conv(
                self.structs,
                self.target,
                args.conv,
                aty,
            ) {
                if arg_aggs.is_empty() {
                    arg_aggs = alloc::vec![None; args.vals.len()];
                }
                arg_aggs[i] = Some(b.intern_agg_desc(desc));
            }
        }
        arg_aggs
    }

    /// Allocate the result object a c5 out-pointer return writes through,
    /// and route its address via an integer slot so the codegen passes it in
    /// a host integer argument register the way every other pointer argument
    /// goes. Returns the object's frame slot and the argument value.
    fn out_ptr_arg(&self, b: &mut SsaBuilder, ty: i64) -> (i64, ValueId) {
        // The callee writes the whole struct through the pointer, so the
        // object holds `sizeof(struct)` bytes, not a single slot.
        let result_size = self.struct_size(ty);
        let result_slot = b.alloc_synthetic_struct(result_size);
        let addr = b.local_addr(result_slot);
        let temp = b.alloc_synthetic_local();
        b.store_local(temp, addr, StoreKind::I64);
        (result_slot, b.load_local(temp, LoadKind::I64))
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

/// Emit a direct call: an entry point in this unit goes through `b.call`
/// on its `ent_pc`; one the linker resolves goes through `b.call_extern`
/// on its symbol.
fn emit_direct_call(
    b: &mut SsaBuilder,
    target_pc: i64,
    sym: u32,
    vals: alloc::vec::Vec<ValueId>,
    fixed_args: usize,
    fp_return: bool,
    fp_mask: u32,
) -> ValueId {
    if target_pc == 0 {
        b.call_extern(sym, vals, fixed_args, fp_return, fp_mask)
    } else {
        b.call(target_pc as usize, vals, fixed_args, fp_return, fp_mask)
    }
}
