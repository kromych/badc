//! Postfix expressions: calls, member access, subscripting,
//! postfix increment and compound literals (C99 6.5.2).

use super::super::access::{load_kind_for, load_kind_width, load_place};
use super::super::atomic::RmwOpen;
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
        // A host-ABI aggregate return carries no hidden argument and
        // takes the normal path below, which tags the call's `ret_agg` /
        // `ret_slot` instead.
        if self.returns_through_out_ptr(callee_conv, ty)
            && let Expr::Ident {
                sym, class, val, ..
            } = self.ast.expr(callee)
            && (*class == Token::Fun as i64 || self.binding_defined_here(*sym, *class))
        {
            return self.call_direct_out_ptr(b, *sym, *val, args, ty);
        }
        // The callee's evaluation order relative to the arguments
        // follows the parser: a non-Ident callee (`*fp(...)`, a struct
        // field) is evaluated before them, and an Ident holding a
        // function pointer after them, by the branch below.
        let indirect_target: Option<ValueId> = if let Expr::Ident { .. } = self.ast.expr(callee) {
            None
        } else {
            Some(self.walk_expr_rvalue(b, callee)?)
        };
        let mut arg_vals: alloc::vec::Vec<ValueId> = alloc::vec::Vec::with_capacity(args.len());
        // C99 6.5.2.2p7 + ABI: a bit per FP-typed argument, so
        // `plan_call_args` places each argument in the right register
        // class. The argument's snapshotted type already carries the
        // implicit int-to-double lift the parser emitted here.
        let mut fp_arg_mask: u32 = 0;
        for (i, a) in args.iter().enumerate() {
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
            if *class == Token::Fun as i64 || self.binding_defined_here(*sym, *class) {
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
    /// address as argument 0. The expression yields that address.
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
            // cell the callee reads a floating-point parameter from as a
            // double, so a `float` widens and round-trips through an
            // integer slot rather than reaching it in its 4-byte form.
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
        // The result is an address, so `fp_return` is false, and the
        // hidden out-pointer shifts every parameter cell out of
        // `param_fp_mask`, so `fp_arg_mask` is 0. The out-pointer is
        // itself a fixed argument and counts toward `fixed_args`.
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
        // `Symbol::params` records the pre-ellipsis parameters, so the
        // arguments past them are the variadic ones.
        let fixed_args = if callee_variadic {
            self.fun_fixed_args(sym).min(args.exprs.len())
        } else {
            args.exprs.len()
        };
        let arg_aggs = self.direct_arg_aggs(b, sym, &mut args, callee_variadic);
        // C99 6.5.2.2p6: a variadic floating-point argument widens to
        // `double` under a host variadic ABI but stays FP-classed --
        // riding an FP argument register on the register-save hosts, and
        // read back as a double from the 8-byte stack stride on macOS
        // arm64. The named arguments keep their FP-bank placement either
        // way, so the call passes the real `fp_mask`.
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
        // A variadic callee reaching here is on a `variadic_int_only`
        // host (the Microsoft conventions), where every argument rides
        // the integer bank. The same widening covers a non-variadic
        // callee whose placement would interleave the banks, which the
        // c5 cdecl cell layout does not admit.
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
        // The aggregate return temp is reserved before the call: its
        // frame slot rides on the call instruction rather than as an SSA
        // operand, so it survives value renumbering.
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
    /// host-ABI layout, so the caller marshals it into the registers and
    /// stack slots the callee reads (AAPCS64 6.8.2 / System V 3.2.3). A
    /// named parameter classifies by its declared type and a variadic
    /// argument by its own; a variadic aggregate of at most one eightbyte
    /// rides as a single loaded integer in the variadic slot (C99
    /// 6.5.2.2), and a larger one through the host-ABI placement so
    /// `va_arg` reads its eightbytes contiguously. A variadic callee's
    /// named aggregate keeps the c5 by-address convention its prologue
    /// expects.
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
            self.record_arg_agg(b, &mut arg_aggs, args, i, ty_tag);
        }
        arg_aggs
    }

    /// Record argument `i`'s host-ABI aggregate layout in `aggs`, which
    /// stays empty until some argument needs one. Inert on the ABIs and
    /// sizes the classifier declines.
    fn record_arg_agg(
        &self,
        b: &mut SsaBuilder,
        aggs: &mut alloc::vec::Vec<Option<u32>>,
        args: &CallArgs<'_>,
        i: usize,
        ty_tag: i64,
    ) {
        let Some(desc) = crate::c5::compiler::host_abi_agg_desc_conv(
            self.structs,
            self.target,
            args.conv,
            ty_tag,
        ) else {
            return;
        };
        if aggs.is_empty() {
            *aggs = alloc::vec![None; args.vals.len()];
        }
        aggs[i] = Some(b.intern_agg_desc(desc));
    }

    /// Reserve the frame temp an aggregate return lands in, with its
    /// interned descriptor. `None` unless the host ABI hands the return
    /// back in the result registers or through the indirect-result
    /// register.
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
    /// temp's address, filled from the result registers or written
    /// through the indirect-result pointer; a `float` result is tagged
    /// single-precision (C99 6.2.5p10). `extend` widens a narrow scalar
    /// return whose high bits the callee may leave undefined.
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

    /// Route each selected floating-point argument through an integer
    /// slot as a widened `double`, the 8-byte pattern the all-integer
    /// cdecl reads a floating-point parameter from.
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
    /// ABI rather than the c5 cdecl shape. `val` is the binding index
    /// `Inst::CallExt` takes.
    fn call_binding(
        &mut self,
        b: &mut SsaBuilder,
        sym: u32,
        val: i64,
        args: CallArgs<'a>,
    ) -> Result<ValueId, WalkError> {
        // A returns-twice callee (the setjmp family, vfork) disables
        // spill-slot sharing in this function.
        if crate::c5::ir::returns_twice_fn_name(&self.symbols[sym as usize].name) {
            b.mark_returns_twice();
        }
        // A by-value struct argument to a libc binding is packed into
        // the platform-ABI argument registers (at most 16 bytes on
        // System V and AAPCS64), not passed by the c5 address
        // convention.
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
        // allocates the result buffer and passes its address as the
        // hidden first integer argument, which shifts the FP-argument
        // mask and the aggregate descriptors by one slot. AArch64
        // returns this size through the indirect-result register, which
        // the `ret_agg` path below covers.
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
        // The CallExt lowering extends a narrow return from the
        // binding's declared return type, leaving an unprototyped
        // binding unextended rather than truncating what may be a
        // pointer.
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
        // The pointed-to function's variadic-ness and named-parameter
        // count come from the callee's static type; any other callee
        // defaults to non-variadic and all-fixed.
        //
        // TODO: a variadic call whose prototype is not statically
        // recoverable takes that default and, under
        // `variadic_on_stack`, places the variadic tail in registers
        // rather than on the stack the callee's va_arg walks. Carrying
        // the prototype on the pointer's type would close this.
        let (callee_variadic, callee_fixed) = self.indirect_callee_proto(callee, args.exprs.len());
        // Every ABI question below is asked of the pointed-to function's
        // own convention, not the target's default.
        let abi = self.target.abi_for(conv);
        let target = match indirect_target {
            Some(t) => t,
            None => self.walk_expr_rvalue(b, callee)?,
        };
        let fp_return = is_floating_scalar(ty);
        let arg_aggs = self.indirect_arg_aggs(b, &args, callee_variadic, callee_fixed);
        // An out-pointer-returning function uses the all-integer cdecl,
        // its prologue skipping the FP bank, so the call is non-variadic
        // with FP mask 0 and every argument fixed.
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
        // C99 6.5.2.2p6, as on the direct path: a variadic
        // floating-point argument widens to `double` and stays
        // FP-classed. On x86_64 the emit sets `al` to the XMM-argument
        // count at the call site.
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
        // Both cases route their floating-point arguments through
        // integer slots and pass mask 0: a callee whose placement would
        // interleave the banks keeps the all-integer c5 cdecl ABI,
        // having applied the same predicate to its `param_fp_mask`, and
        // a variadic callee on a `variadic_int_only` host takes every
        // argument in the integer bank.
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

    /// Tag each by-value aggregate argument of an indirect call with
    /// its host-ABI layout (System V AMD64 3.2.3 / AAPCS64 6.4, 6.8.2).
    /// The parser narrows each argument to its parameter type before the
    /// call, so the argument's own type is that parameter type. A
    /// variadic argument keeps the by-address convention, as on the
    /// direct path.
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
            self.record_arg_agg(b, &mut arg_aggs, args, i, aty);
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
        // C99 6.3.2.1p3: an array-typed field decays to a pointer to
        // its first element, so the field's address is the rvalue, as
        // it is for a struct-value field.
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
        // The parser already scaled `idx` by the element size, and for
        // a literal index that walk folds to a single `Imm`, so the
        // address is `arr + Imm` and takes the immediate form.
        let addr = match b.peek_imm(i) {
            Some(k) => b.binop_imm(BinOp::Add, arr, k),
            None => b.binop(BinOp::Add, arr, i),
        };
        // C99 6.5.2.1p2 with the address-as-value rule: for a
        // struct-value element `arr[i]` yields the element's address
        // and the enclosing site handles the bytes.
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
        let RmwOpen {
            place,
            load_kind: kind,
            store_kind,
            vol,
            old,
        } = self.rmw_open(b, lvalue, ty)?;
        let stepped = self.increment_value(b, old, by, ty);
        place.store(b, stepped, store_kind, vol);
        if post {
            return Ok(old);
        }
        // A sub-64-bit lvalue reloads through `kind`, so a surrounding
        // `(++p) == 0` sees the wrapped value and not the wider Add
        // result. A volatile lvalue is not re-read (C99 6.7.3p6) and
        // narrows in a register instead.
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
