//! Expression parser.
//!
//! Hosts the giant precedence-climbing `expr()` -- C99 6.5 in one
//! function -- plus the small `seed_multi_dim_strides` helper that
//! the array-decay paths use to queue per-level subscript strides
//! for a multi-dimensional array.
//!
//! `expr()` is the parser's single entry point for evaluating any
//! C expression. Callers pass the *outer precedence level* (`lev`):
//! the loop body keeps consuming operators as long as the next
//! token has a higher-or-equal precedence than `lev`. This lets
//! statement-level callers ask for the full expression
//! (`expr(Assign)`), while internal operator handlers reach for
//! tighter subtrees (`expr(Add)`, `expr(Mul)`, ...).
//!
//! The function's overall shape:
//!   * Primary / unary prefix dispatch on the current token
//!     (literal, identifier, cast, sizeof, unary op).
//!   * `while self.lex.tk >= lev || self.lex.tk == '('` -- the
//!     precedence-climbing loop. Each operator case picks up the
//!     LHS from the accumulator + c5 stack, evaluates its RHS at
//!     the matching precedence, and emits the right Op sequence
//!     (plus pointer-scaling / unsigned-mask / FP-conversion
//!     bookkeeping as needed).
//!
//! Lives in its own file because at ~1800 lines it dwarfed every
//! other parser routine. The move is a pure relocation; the side-
//! channel fields it consumes (`pending_index_stride`,
//! `last_array_decay_size`, `fn_ptr_chain_depth`, ...) are still
//! declared on `Compiler` in `mod.rs`.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::op::Op;
use super::super::token::{Token, Ty};
use super::CODE_BASE;
use super::Compiler;
use super::types::{
    UNSIGNED_BIT, format_type, fp_result_ty, integer_promote, is_floating_scalar, is_pointer_ty,
    is_struct_ty, is_unsigned_ty, load_op_for, store_op_for, struct_id_of, struct_ptr_depth,
    usual_arith_common_ty,
};

/// Relational comparison operator. The four variants share an
/// identical emit shape -- push LHS, evaluate RHS at shift
/// precedence, pick the FP / unsigned / signed Op flavour by
/// inspecting the operand types -- and only differ in *which* Op
/// to emit per flavour plus the diagnostic spelling. Threading
/// them through this enum collapses what was four near-identical
/// branches into one.
#[derive(Copy, Clone)]
enum Cmp {
    Lt,
    Gt,
    Le,
    Ge,
}

impl Cmp {
    /// Map a lexer token onto the relational op it represents.
    /// Returns `None` for every non-relational token so the caller
    /// can use it as an `if let` arm in the precedence-climbing
    /// chain.
    fn from_tok(tok: super::super::token::Tok) -> Option<Self> {
        if tok == Token::LtOp {
            Some(Cmp::Lt)
        } else if tok == Token::GtOp {
            Some(Cmp::Gt)
        } else if tok == Token::LeOp {
            Some(Cmp::Le)
        } else if tok == Token::GeOp {
            Some(Cmp::Ge)
        } else {
            None
        }
    }

    /// Return the (signed, unsigned, FP, name) tuple of bytecode
    /// ops + diagnostic spelling for this comparison. Same shape
    /// the per-arm code emitted before the collapse.
    fn ops(self) -> (Op, Op, Op, &'static str) {
        match self {
            Cmp::Lt => (Op::Lt, Op::Ult, Op::Flt, "<"),
            Cmp::Gt => (Op::Gt, Op::Ugt, Op::Fgt, ">"),
            Cmp::Le => (Op::Le, Op::Ule, Op::Fle, "<="),
            Cmp::Ge => (Op::Ge, Op::Uge, Op::Fge, ">="),
        }
    }
}

impl Compiler {
    /// Pick the C99 6.4.4.1p5 type of an integer literal whose value
    /// is `ival`, honouring the lexer-recorded `u`/`l`/`ll` suffix.
    ///
    /// No suffix: the first of `int`, `long`, `long long` whose
    /// range holds the magnitude. A value above INT_MAX must not
    /// stay at `int`, or the post-binop mask in `convert.rs`
    /// truncates `INT64_MAX - 1` back to 32 bits.
    /// With `u`/`U`: same hierarchy in the unsigned variants.
    /// With `l`/`L` / `ll`/`LL`: floor at the named width and let
    /// the magnitude bump further as needed.
    fn literal_auto_promoted_type(&self, ival: i64) -> i64 {
        let suffix_long = self.lex.int_suffix_long;
        let is_unsigned = self.lex.int_suffix_unsigned;
        let int_size = self.size_of_type(Ty::Int as i64);
        let long_size = self.size_of_type(Ty::Long as i64);
        let mag = (ival as i128).unsigned_abs();
        let fits = |size_bytes: usize, signed: bool| -> bool {
            let bits = (size_bytes as u32) * 8;
            if signed {
                if bits >= 128 {
                    true
                } else {
                    mag <= (1u128 << (bits - 1))
                }
            } else if bits >= 128 {
                true
            } else if bits == 0 {
                false
            } else {
                mag <= ((1u128 << bits) - 1u128)
            }
        };
        let mut rank: u8 = suffix_long;
        if rank < 1 && (!fits(int_size, !is_unsigned)) {
            rank = 1;
        }
        if rank < 2 && (!fits(long_size, !is_unsigned)) {
            rank = 2;
        }
        let mut ty = match rank {
            2 => Ty::LongLong as i64,
            1 => Ty::Long as i64,
            _ => Ty::Int as i64,
        };
        if is_unsigned {
            ty |= UNSIGNED_BIT;
        }
        ty
    }

    pub(super) fn expr(&mut self, lev: i64) -> Result<(), C5Error> {
        let mut t: i64;

        if self.lex.tk == 0 {
            return Err(self.compile_err("unexpected eof in expression"));
        } else if self.lex.tk == Token::Num {
            let val = self.lex.ival;
            self.emit_imm(val);
            self.ty = self.literal_auto_promoted_type(val);
            self.ast_emit_int_lit(val, self.ty);
            self.next()?;
        } else if self.lex.tk == Token::FloatNum {
            // C99 6.4.4.2: floating constant. The lexer parsed
            // `1.5` etc. into f64 and stored `f64::to_bits()` cast
            // to i64 in `ival`. The byte pattern flows through
            // Op::Imm unmodified; the codegen reads it back via
            // `f64::from_bits` when the surrounding `self.ty`
            // marks the value as floating.
            let bits = self.lex.ival as u64;
            self.emit_imm(self.lex.ival);
            self.ty = Ty::Double as i64;
            self.ast_emit_float_lit(bits, self.ty);
            self.next()?;
        } else if self.lex.tk == '"' {
            // C99 6.4.5 paragraph 6: a string literal has type
            // `char[N+1]` where the +1 is the trailing NUL. The
            // value decays to `char *` in this expression context,
            // but `sizeof("...")` reads the full array size --
            // surface the byte count via `last_array_decay_bytes`
            // so `sizeof_operand_bytes` returns N+1 instead of the
            // decayed pointer's 8.
            let start_offset = self.lex.ival;
            self.emit_data_imm(start_offset);
            self.next()?;
            // C concatenates adjacent string literals -- `"a" "b"` is one
            // string. The lexer leaves the NUL off so the bytes flow
            // straight together; we add the single trailing NUL here.
            while self.lex.tk == '"' {
                self.next()?;
            }
            self.data.push(0);
            self.pending.last_array_decay_bytes = (self.data.len() as i64) - start_offset;
            self.ty = Ty::Ptr as i64;
            // Dual-emit: capture the decayed `char *` rvalue so
            // the wrapping expression (typically a call argument,
            // initializer, or assignment) finds the address on
            // `ast_acc`.
            self.ast_emit_str_lit(start_offset, self.ty);
        } else if self.lex.tk == Token::Sizeof {
            // C99 6.5.3.4: `sizeof(<type>)`, `sizeof(<expr>)`, or
            // `sizeof <unary-expr>`. The shared helper handles
            // all three shapes; this site just emits the result
            // as a runtime immediate and pins the expression
            // type at `int`.
            self.next()?;
            let total_bytes = self.sizeof_operand_bytes()?;
            self.emit_imm(total_bytes);
            self.ty = Ty::Int as i64;
            // Dual-emit: sizeof is a compile-time constant per
            // 6.5.3.4p2. Seed the accumulator with the matching
            // IntLit so a wrapping expression (call argument,
            // binary op, assignment) finds the value on
            // `ast_acc`.
            self.ast_emit_int_lit(total_bytes, self.ty);
        } else if self.lex.tk == Token::Id
            && !self.current_function_name.is_empty()
            && matches!(
                self.symbols[self.lex.curr_id_idx].name.as_str(),
                "__func__" | "__FUNCTION__" | "__PRETTY_FUNCTION__"
            )
        {
            // C99 6.4.2.2: __func__ is implicitly declared as
            // `static const char __func__[] = "function-name";` at
            // the start of every function body. GCC predates the
            // standard with __FUNCTION__ / __PRETTY_FUNCTION__ as
            // aliases. The bytes are appended to the data segment
            // and the expression's value is the pointer to them.
            let fn_name = self.current_function_name.clone();
            let offset = self.data.len() as i64;
            self.data.extend_from_slice(fn_name.as_bytes());
            self.data.push(0);
            self.emit_data_imm(offset);
            self.next()?;
            self.ty = Ty::Char as i64 + Ty::Ptr as i64;
        } else if self.lex.tk == Token::Id {
            let id_idx = self.lex.curr_id_idx;
            self.next()?;
            if self.lex.tk == '(' {
                self.next()?;
                // Intrinsic call: the identifier was registered via
                // `#pragma intrinsic("name")`. Each intrinsic has
                // its own fixed arity (alloca / __c5_aarch64_setjmp
                // take one; __c5_aarch64_longjmp takes two) and the
                // call site lowering produces `Op::Intrinsic <id>`
                // with the operand layout each lowering expects.
                if let Some(&intrinsic_id) = self.pp_intrinsics.get(&self.symbols[id_idx].name) {
                    let fn_name = self.symbols[id_idx].name.clone();
                    if self.lex.tk == ')' {
                        return Err(self
                            .compile_err(format!("intrinsic `{fn_name}` requires one argument")));
                    }
                    let longjmp_id = crate::c5::op::Intrinsic::LongjmpAArch64 as i64;
                    let setjmp_id = crate::c5::op::Intrinsic::SetjmpAArch64 as i64;
                    let alloca_id = crate::c5::op::Intrinsic::Alloca as i64;
                    let va_start_id = crate::c5::op::Intrinsic::VaStart as i64;
                    let va_arg_id = crate::c5::op::Intrinsic::VaArg as i64;
                    let va_end_id = crate::c5::op::Intrinsic::VaEnd as i64;
                    let va_copy_id = crate::c5::op::Intrinsic::VaCopy as i64;
                    let mut ast_intrinsic_args: alloc::vec::Vec<super::super::ast::ExprId> =
                        alloc::vec::Vec::new();
                    if intrinsic_id == longjmp_id
                        || intrinsic_id == va_start_id
                        || intrinsic_id == va_copy_id
                    {
                        // Two-arg shape: env then val. The first
                        // gets pushed; the second lands in the
                        // accumulator so the AArch64 lowering can
                        // pop env and read val without extra
                        // shuffling.
                        self.expr(Token::Assign as i64)?;
                        if let Some(a) = self.ast_acc {
                            ast_intrinsic_args.push(a);
                        }
                        self.emit_op(Op::Psh);
                        if self.lex.tk != ',' {
                            return Err(
                                self.compile_err(format!("intrinsic `{fn_name}` takes (env, val)"))
                            );
                        }
                        self.next()?;
                        self.expr(Token::Assign as i64)?;
                        if let Some(a) = self.ast_acc {
                            ast_intrinsic_args.push(a);
                        }
                        if is_floating_scalar(self.ty) {
                            self.emit_op(Op::Fcvtfi);
                            self.ty = Ty::Int as i64;
                        }
                    } else {
                        self.expr(Token::Assign as i64)?;
                        if let Some(a) = self.ast_acc {
                            ast_intrinsic_args.push(a);
                        }
                        // Coerce a float argument to int when the
                        // intrinsic expects an integer size (alloca
                        // and SetjmpAArch64 are both pointer-shape
                        // inputs).
                        if is_floating_scalar(self.ty) {
                            self.emit_op(Op::Fcvtfi);
                            self.ty = Ty::Int as i64;
                        }
                    }
                    if self.lex.tk != ')' {
                        return Err(self.compile_err(format!(
                            "intrinsic `{fn_name}` arity mismatch at close paren"
                        )));
                    }
                    self.next()?;
                    self.emit_op(Op::Intrinsic);
                    self.emit_val(intrinsic_id);
                    // Flag the function for the alloca-arena
                    // patch-up at function-end. We don't reserve
                    // the alloca-top slot here -- the function
                    // might still grow more regular locals after
                    // this point, and the slot must sit just
                    // below them so the arena ends up at the
                    // deepest part of the frame.
                    if intrinsic_id == alloca_id {
                        self.uses_alloca_in_current_fn = true;
                    }
                    // Result type: alloca returns `void *`,
                    // SetjmpAArch64 returns `int`, LongjmpAArch64
                    // has no real return (control never reaches
                    // the next statement) but the parser still
                    // typechecks downstream uses as `int`.
                    // __builtin_va_start / __builtin_va_end /
                    // __builtin_va_copy don't return a useful
                    // value, but the parser threads them through
                    // as int so a statement-context call
                    // typechecks.
                    if intrinsic_id == setjmp_id
                        || intrinsic_id == longjmp_id
                        || intrinsic_id == va_start_id
                        || intrinsic_id == va_end_id
                        || intrinsic_id == va_copy_id
                    {
                        self.ty = Ty::Int as i64;
                    } else if intrinsic_id == va_arg_id {
                        // __builtin_va_arg returns `void *`
                        // pointing at the just-vacated 8-byte
                        // slot. The <stdarg.h> macro dereferences
                        // as the requested type.
                        self.ty = (Ty::Char as i64) + (Ty::Ptr as i64);
                    } else {
                        self.ty = (Ty::Char as i64) + (Ty::Ptr as i64);
                    }
                    // Dual-emit `Expr::Intrinsic { kind, args, ty }`.
                    // The walker dispatches by `kind` to the matching
                    // `Inst::Intrinsic` op. Args carry through in
                    // source order regardless of the c5 stack/acc
                    // shuffle the bytecode tier did.
                    let intr_ty = self.ty;
                    let pos = self.ast_src_pos();
                    let id = self.ast.push_expr(
                        super::super::ast::Expr::Intrinsic {
                            kind: intrinsic_id,
                            args: ast_intrinsic_args,
                            ty: intr_ty,
                        },
                        pos,
                    );
                    self.ast_acc = Some(id);
                } else {
                    // Snapshot the declared signature up front: the per-arg
                    // type checks read from `expected_params` and `is_variadic`,
                    // and we don't want a recursive call to clobber them via
                    // self-mutation. Cloning the Vec is cheap (typically 1-3
                    // i64s) compared to the cost of the type check itself.
                    let expected_params = self.symbols[id_idx].params.clone();
                    let is_variadic = self.symbols[id_idx].is_variadic;
                    let fn_name_for_warn = self.symbols[id_idx].name.clone();
                    // Struct-returning callees use a hidden out-pointer
                    // arg at val=2: the caller pre-allocates a temp for
                    // the result and passes its address as arg 0; the
                    // callee's `return s` writes to *(out_pointer)
                    // before Lev. The result expression's value (in
                    // `a`) becomes the temp's address so an enclosing
                    // `lhs = call(...)` Mcpy reads from there.
                    let callee_ret_ty = self.symbols[id_idx].type_;
                    let callee_returns_struct = self.symbols[id_idx].class == Token::Fun as i64
                        && is_struct_ty(callee_ret_ty)
                        && struct_ptr_depth(callee_ret_ty) == 0;
                    // Token::Sys (libc) calls returning a struct by
                    // value would need real platform-ABI register
                    // packing -- SysV's two-register split for
                    // 8 < size <= 16, Win64's hidden out-pointer for
                    // size > 8, AAPCS64's HFA / two-GPR split, and so
                    // on. The c5-internal "address-as-value, hidden
                    // out-pointer at val=2" convention only works for
                    // c5-to-c5 calls. Refuse the call up front rather
                    // than emit a silently-broken sequence.
                    if self.symbols[id_idx].class == Token::Sys as i64
                        && is_struct_ty(callee_ret_ty)
                        && struct_ptr_depth(callee_ret_ty) == 0
                    {
                        return Err(self.compile_err(format!(
                            "`{}` returns a struct by value, but the \
                         platform-ABI struct-return convention isn't \
                         implemented for Token::Sys calls. Use a \
                         pointer-returning variant or pass an out-buffer.",
                            fn_name_for_warn
                        )));
                    }
                    let mut nargs = 0;
                    // Snapshot the AST parser-side vstack depth so
                    // the call's bytecode dance (per-arg `Op::Lea +
                    // Op::Psh` arg-temp setup, the right-to-left
                    // `Op::Lea + Op::Li + Op::Psh` re-push, the
                    // optional struct-return out-pointer push) can
                    // leak transient pushes without polluting the
                    // outer expression's lvalue stack. The bytecode
                    // side's matching pops happen inside the same
                    // sequence; on the AST side the matching pops
                    // are routed through `ast_apply_assign` for the
                    // per-arg `*temp = arg` shape (the only Op::Si
                    // in this region), which consumes ONE vstack
                    // slot per Op::Si. The right-to-left re-push
                    // and the out-pointer push are pure leaks --
                    // truncate the vstack back to this depth right
                    // before `ast_emit_call` so the outer scalar
                    // assign's `ast_apply_assign` sees the lvalue
                    // it pushed.
                    let saved_ast_vstack_depth = self.ast_vstack.len();
                    // For struct returns, allocate a result temp now
                    // so its address can be pushed before the
                    // declared-arg pushes.
                    let saved_loc_offs_for_result = self.loc_offs;
                    let result_temp_off: i64 = if callee_returns_struct {
                        let slots = self.slots_of_type(callee_ret_ty);
                        self.loc_offs += slots;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        -self.loc_offs
                    } else {
                        0
                    };
                    // c5 uses cdecl-style arg passing: args are pushed
                    // right-to-left so the i'th declared param sits at
                    // `[bp + 16*(i+1)]`. The parser still has to evaluate
                    // args left-to-right (so observable side effects
                    // happen in source order), so each arg gets parked in
                    // a transient temp local and we re-emit the pushes in
                    // reverse once they're all evaluated.
                    let saved_loc_offs = self.loc_offs;
                    let mut temp_offsets: Vec<i64> = Vec::new();
                    // Per-arg FP flag, captured at evaluation time. Used
                    // below when the call is `Token::Sys` to build a bit
                    // mask the codegen reads for variadic FP packing
                    // (`printf("%f", x)` etc.). Order matches
                    // `temp_offsets`: index 0 = first declared arg.
                    let mut arg_is_fp: Vec<bool> = Vec::new();
                    // Per-arg AST ExprId, captured at evaluation time
                    // (post-conversion, pre-store). Empty slot when
                    // the dual-emit hasn't wired the arg expression
                    // yet; the call-site Call node accepts only the
                    // wired ones today and skips Call build if any
                    // arg is unwired.
                    let mut ast_arg_ids: Vec<Option<super::super::ast::ExprId>> = Vec::new();
                    while self.lex.tk != ')' {
                        let arg_line = self.lex.line;
                        // Allocate a temp slot for this arg.
                        self.loc_offs += 1;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        let temp_off = -self.loc_offs;
                        temp_offsets.push(temp_off);

                        // Emit the `*temp = expr;` shape that c5's
                        // assignment path already supports: address
                        // first, push, then RHS, then Si.
                        self.emit_lea(temp_off);
                        self.emit_op(Op::Psh);
                        self.expr(Token::Assign as i64)?;

                        // Type-check before the Si overwrites self.ty.
                        if (nargs as usize) < expected_params.len() {
                            let want = expected_params[nargs as usize];
                            let zero = self.last_emit_is_zero();
                            let untyped = self.last_emit_was_indirect_call();
                            if let Some(reason) =
                                Self::type_warning_with_flags(want, self.ty, zero, untyped)
                            {
                                let got = self.ty;
                                let want_s = format_type(want, &self.structs);
                                let got_s = format_type(got, &self.structs);
                                self.warn_at(
                                arg_line,
                                format!(
                                    "{reason} in argument {} of `{}` (param={want_s}, arg={got_s})",
                                    nargs + 1,
                                    fn_name_for_warn,
                                ),
                            );
                            }
                            // C99 6.5.2.2p7: declared-parameter call
                            // arguments undergo the same assignment
                            // conversion as the `= expr` rule. If the
                            // prototype expects `double` and the
                            // actual is an integer, lift via
                            // `Op::Fcvtif` so the IEEE-754 bit pattern
                            // reaches the FP-arg register the codegen
                            // routes through (xmm_N / d_N). Without
                            // this, the integer bit pattern lands in
                            // the GPR-arg register and libm reads
                            // garbage out of the FP register.
                            self.convert_assign_rhs(want);
                        } else if !expected_params.is_empty() && !is_variadic {
                            self.warn_at(
                                arg_line,
                                format!(
                                    "too many arguments to `{}` (expected {}, got at least {})",
                                    fn_name_for_warn,
                                    expected_params.len(),
                                    nargs + 1,
                                ),
                            );
                        }

                        arg_is_fp.push(is_floating_scalar(self.ty));
                        // Refuse passing a struct by value to a
                        // Token::Sys callee. The c5-internal "push
                        // the address" convention works for c5-to-c5
                        // calls (the callee copies into a fresh local
                        // on entry); platform ABIs for libc instead
                        // expect the bytes packed into argument
                        // registers (SysV/AAPCS64: 1-2 GPRs for
                        // structs <= 16 bytes; Win64: a single GPR
                        // for <= 8 bytes, hidden pointer otherwise).
                        // Implementing those splits is future work;
                        // for now flag the mismatch loudly.
                        if self.symbols[id_idx].class == Token::Sys as i64
                            && is_struct_ty(self.ty)
                            && struct_ptr_depth(self.ty) == 0
                        {
                            return Err(self.compile_err_at(
                                arg_line,
                                format!(
                                    "argument {} of `{}` is a struct passed by value, \
                                 but the platform-ABI struct-arg convention isn't \
                                 implemented for Token::Sys calls. Pass `&s` (a \
                                 pointer to the struct) instead.",
                                    nargs + 1,
                                    fn_name_for_warn
                                ),
                            ));
                        }
                        // Snapshot the arg's AST ExprId before the
                        // Si consumes both vstack and acc. The Call
                        // node built below uses these in source
                        // order regardless of the c5 right-to-left
                        // push.
                        ast_arg_ids.push(self.ast_acc);
                        self.emit_op(Op::Si);
                        nargs += 1;
                        if self.lex.tk == ',' {
                            self.next()?;
                        }
                    }
                    // Push from temp slots right-to-left so the first
                    // declared param ends up on top of the c5 stack.
                    for &temp_off in temp_offsets.iter().rev() {
                        self.emit_lea(temp_off);
                        self.emit_op(Op::Li);
                        self.emit_op(Op::Psh);
                    }
                    // For struct-returning callees, push the hidden
                    // out-pointer (address of the result temp) so it
                    // lands at val=2 -- ahead of the first declared
                    // arg in the c5 stack walk. The callee's `return
                    // s` writes through it; on return we set `a` to
                    // the temp's address so the enclosing assignment
                    // can Mcpy from it.
                    if callee_returns_struct {
                        self.emit_lea(result_temp_off);
                        self.emit_op(Op::Psh);
                    }
                    // Release the staging slots; they'll be reused by
                    // the next call in this function. The result-temp
                    // slot stays alive (loc_offs not reset to it) until
                    // the enclosing expression consumes it.
                    let target_loc_offs = if callee_returns_struct {
                        saved_loc_offs_for_result + self.slots_of_type(callee_ret_ty)
                    } else {
                        saved_loc_offs
                    };
                    self.loc_offs = target_loc_offs;
                    // Arity underflow check (after the loop, when nargs is
                    // final). Only fires for non-variadic functions with a
                    // recorded signature.
                    if !is_variadic
                        && !expected_params.is_empty()
                        && (nargs as usize) < expected_params.len()
                    {
                        let line = self.lex.line;
                        self.warn_at(
                            line,
                            format!(
                                "too few arguments to `{}` (expected {}, got {})",
                                fn_name_for_warn,
                                expected_params.len(),
                                nargs,
                            ),
                        );
                    }
                    self.next()?;
                    if self.symbols[id_idx].class == Token::Sys as i64 {
                        // External library call. The symbol's `val` is
                        // the binding's flat index across all
                        // `#pragma binding(...)` directives the
                        // preprocessor parsed; the codegen / VM use it
                        // as the GOT slot lookup key (native) or the
                        // dispatch-table key (VM).
                        let jsrext_pc = self.text.len();
                        self.emit_op(Op::JsrExt);
                        self.emit_val(self.symbols[id_idx].val);
                        // Capture per-arg FP-ness for the codegen. Only
                        // needed when at least one arg is FP; an
                        // all-integer call rides the existing path.
                        let mut mask: u32 = 0;
                        for (i, &is_fp) in arg_is_fp.iter().enumerate() {
                            if is_fp && i < 32 {
                                mask |= 1u32 << i;
                            }
                        }
                        if mask != 0 {
                            self.call_fp_arg_masks.push((jsrext_pc, mask));
                        }
                    } else if self.symbols[id_idx].class == Token::Fun as i64 {
                        self.symbols[id_idx].was_referenced = true;
                        self.emit_op(Op::Jsr);
                        // Record a fixup so the operand gets re-resolved
                        // after the callee's body lands. `val == 0`
                        // means the body hasn't been parsed yet (the
                        // symbol is from a forward declaration); the
                        // value we emit now is a placeholder. After
                        // every function body is parsed we walk this
                        // list and rewrite each operand to the
                        // post-body `ent_pc` of its callee. Calls that
                        // already see a non-zero `val` (the callee's
                        // body lands before the call, the common case)
                        // still record an entry but the post-body walk
                        // re-emits the same value -- a no-op rather
                        // than a bug.
                        let operand_pc = self.text.len();
                        self.fn_call_fixups.push((operand_pc, id_idx));
                        self.emit_val(self.symbols[id_idx].val);
                    } else if self.symbols[id_idx].class == Token::Loc as i64
                        || self.symbols[id_idx].class == Token::Glo as i64
                    {
                        if self.symbols[id_idx].class == Token::Loc as i64 {
                            // Indirect call through a local function
                            // pointer: the upcoming Li loads the
                            // function address into the accumulator,
                            // Jsri then consumes it. The load is a
                            // real read of the local's value.
                            self.symbols[id_idx].was_referenced = true;
                            self.symbols[id_idx].was_read = true;
                            self.emit_lea(self.symbols[id_idx].val);
                        } else {
                            self.emit_data_imm(self.symbols[id_idx].val);
                            let operand_pc = *self.data_imm_positions.last().unwrap();
                            self.glo_imm_refs.push((operand_pc, id_idx));
                        }
                        self.emit_op(Op::Li);
                        self.emit_op(Op::Jsri);
                    } else {
                        let name = self.symbols[id_idx].name.clone();
                        let suggestion = match super::super::headers::header_declaring(&name) {
                            Some(h) => format!(" -- try `#include <{h}>`"),
                            None => String::new(),
                        };
                        return Err(
                            self.compile_err(format!("unknown function `{name}`{suggestion}"))
                        );
                    }
                    let total_pushed = if callee_returns_struct {
                        nargs + 1
                    } else {
                        nargs
                    };
                    if total_pushed > 0 {
                        self.emit_op(Op::Adj);
                        self.emit_val(total_pushed);
                    }
                    // Drop the AST parser-side vstack pushes the
                    // call's bytecode dance leaked (right-to-left
                    // re-push, optional struct-return out-pointer
                    // push) before the outer expression's
                    // `ast_apply_assign` runs. See the matching
                    // `saved_ast_vstack_depth` snapshot above.
                    self.ast_vstack.truncate(saved_ast_vstack_depth);
                    // Dual-emit the call's AST: build a callee
                    // Ident node from the call-site symbol idx and
                    // pair with the per-arg ExprIds captured above.
                    // Struct-returning calls skip the AST build for
                    // now; the hidden out-pointer doesn't fit the
                    // canonical `Call { callee, args, ty }` shape.
                    if !callee_returns_struct {
                        let callee_ty = self.symbols[id_idx].type_;
                        let callee_id = self.ast_synthesize_callee(id_idx as u32, callee_ty);
                        let return_ty = callee_ret_ty;
                        self.ast_emit_call(callee_id, ast_arg_ids.clone(), return_ty);
                    }
                    // For struct-returning callees, the result lives
                    // in the caller-allocated temp. After the call,
                    // load the temp's address into `a` so the
                    // expression's value (struct-rvalue semantics:
                    // address-as-value) flows into the enclosing
                    // assignment / `.field` access.
                    if callee_returns_struct {
                        self.emit_lea(result_temp_off);
                    }
                    // For direct calls (Jsr/JsrExt) the symbol's `type_`
                    // is the declared return type. For indirect calls
                    // through a variable (Jsri), `type_` is the *variable*
                    // type (e.g. `int *` for a function pointer), not the
                    // return type -- the dialect has no place to record
                    // a function pointer's return type. Default to `int`
                    // for the result; the actual register value carries
                    // the full 8-byte return regardless of the tag, so
                    // assigning to a wider lvalue still preserves bits.
                    self.ty = if self.symbols[id_idx].class == Token::Loc as i64
                        || self.symbols[id_idx].class == Token::Glo as i64
                    {
                        Ty::Int as i64
                    } else {
                        self.symbols[id_idx].type_
                    };
                } // close intrinsic-vs-normal-call else branch
            } else if self.symbols[id_idx].class == Token::Num as i64 {
                let val = self.symbols[id_idx].val;
                self.emit_imm(val);
                self.ty = Ty::Int as i64;
                // Dual-emit the resolved constant so a wrapping
                // expression (assignment, call argument, binop)
                // captures the value on `ast_acc`. Enum
                // constants and `#define`-via-const-decl idioms
                // both go through this path; the walker's
                // `IntLit` arm emits `Inst::Imm(val)`.
                self.ast_emit_int_lit(val, self.ty);
            } else if self.symbols[id_idx].class == Token::Fun as i64 {
                self.symbols[id_idx].was_referenced = true;
                // Bare function reference (e.g. `fp = add;`). The value
                // becomes a user-visible pointer, so it gets the CODE_BASE
                // bias -- that lets the VM tell apart "function pointer"
                // from "data pointer", and refuse to deref the former.
                self.emit_op(Op::Imm);
                let operand_pc = self.text.len();
                self.fn_call_fixups.push((operand_pc, id_idx));
                // Record the operand_pc so the native codegen knows
                // this Imm carries (CODE_BASE + bc_pc) -- otherwise
                // a user constant that happens to land in the
                // [CODE_BASE, CODE_BASE + text.len()) range would be
                // misclassified as a function-pointer literal.
                self.code_imm_positions.push(operand_pc);
                self.emit_val(CODE_BASE as i64 + self.symbols[id_idx].val);
                // Type as `int*` rather than `char*`: matches the
                // conventional `int *fp = some_function;` idiom and
                // keeps the type-check loose-but-not-wrong.
                self.ty = Ty::Int as i64 + Ty::Ptr as i64;
                // Dual-emit: an Ident node so the wrapping shape
                // (call-arg, assignment, cast) sees the function
                // reference on `ast_acc`. The walker's
                // `load_ident_rvalue` for `Token::Fun` emits the
                // matching `imm_code(val)`.
                self.ast_emit_ident(id_idx as u32, self.ty);
            } else if self.symbols[id_idx].class == Token::Sys as i64 {
                // Bare libc reference -- `fp = readlink;`. We can't
                // fold in the real GOT/IAT address at compile time,
                // so we point the value at a per-Sys trampoline (a
                // tiny synthetic c5 function that re-dispatches
                // through `Op::JsrExt`). `apply_fn_call_fixups`
                // then patches this `Imm` operand to
                // `CODE_BASE + trampoline_pc` once
                // [`Self::emit_sys_trampolines`] has placed the
                // trampolines at the tail of `text`. The
                // accompanying `code_imm_positions` entry tells the
                // codegen this Imm carries a code pointer so it
                // emits the right ADRP/ADD (or RIP-relative LEA)
                // sequence.
                let tr_idx = self.ensure_sys_trampoline_sym(id_idx);
                self.emit_op(Op::Imm);
                let operand_pc = self.text.len();
                self.fn_call_fixups.push((operand_pc, tr_idx));
                self.code_imm_positions.push(operand_pc);
                self.emit_val(CODE_BASE as i64);
                self.ty = Ty::Int as i64 + Ty::Ptr as i64;
                // Dual-emit: the trampoline symbol is Token::Fun
                // class; the walker reads `Symbol::val` live at
                // walk time (post-`emit_sys_trampolines`) to get
                // the trampoline's ent_pc. Push an Ident keyed on
                // the trampoline symbol so wrapping shapes
                // (static-init, assign, call-arg) see the address
                // producer on `ast_acc`.
                self.ast_emit_ident(tr_idx as u32, self.ty);
            } else {
                let identifier_is_local = self.symbols[id_idx].class == Token::Loc as i64;
                if identifier_is_local {
                    self.symbols[id_idx].was_referenced = true;
                    self.emit_lea(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Glo as i64
                    && self.symbols[id_idx].is_thread_local
                {
                    // `_Thread_local` global: emit Op::TlsLea so
                    // the codegen lowers via the per-target TLS
                    // sequence (TPIDR_EL0 + offset on aarch64,
                    // fs:0 + offset on x86_64). The operand is the
                    // byte offset within the program's TLS block.
                    self.emit_op(Op::TlsLea);
                    self.emit_val(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Glo as i64 {
                    self.emit_data_imm(self.symbols[id_idx].val);
                    let operand_pc = *self.data_imm_positions.last().unwrap();
                    self.glo_imm_refs.push((operand_pc, id_idx));
                } else {
                    return Err(self
                        .compile_err(format!("undefined variable {}", self.symbols[id_idx].name)));
                }
                self.ty = self.symbols[id_idx].type_;
                let is_struct_value = is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                let is_array_var = self.symbols[id_idx].array_size != 0;
                // Array variables decay to a pointer to the first
                // element: the symbol's address IS its value, no
                // load. Bump the type by one pointer level so
                // downstream pointer arithmetic / indexing scales
                // correctly. Struct values follow the same
                // "address-as-value" rule but keep their type
                // because the `.field` operator needs the struct's
                // value type to look up offsets.
                if is_array_var {
                    if identifier_is_local {
                        // Array decay produces the array's
                        // address rather than a scalar value, so
                        // the load-op path below never runs. The
                        // address can be indexed, passed to a
                        // helper, or stored into a pointer; none
                        // of those are tracked here. Mark
                        // `address_escaped` so the unused-symbol
                        // analysis at scope exit conservatively
                        // treats the array as read.
                        self.symbols[id_idx].address_escaped = true;
                    }
                    self.ty += Ty::Ptr as i64;
                    // C99 6.3.2.1p3 array-to-pointer decay: the
                    // symbol's address IS the rvalue; no trailing
                    // load runs. Dual-emit an `Expr::Ident` typed
                    // at the decayed pointer level so a wrapping
                    // index / call-arg / assignment site finds the
                    // array on `ast_acc`. Walker's
                    // `load_ident_rvalue` for Loc / Glo with this
                    // shape still routes through `load_local` /
                    // `imm_data` + load, which is wrong for arrays
                    // -- the array AST tag is the address-as-value
                    // rule; the walker's Index / call-arg arms
                    // re-walk the same Ident and need just the
                    // address. Push the node; the walker arm fix
                    // lives separately.
                    self.ast_emit_ident(id_idx as u32, self.ty);
                    // Stash the array's element count so a
                    // surrounding `sizeof(<arr>)` can compute
                    // `count * sizeof(elem)` instead of the
                    // decayed pointer's `sizeof(T*) = 8`.
                    // `array_size = -1` marks `extern T x[];` whose
                    // size is unknown at this TU (C99 6.7.5.2); leave
                    // the sizeof hint at zero so the operand falls
                    // through to the bare-pointer size, matching the
                    // standard's incomplete-type rule.
                    if self.symbols[id_idx].array_size > 0 {
                        self.pending.last_array_decay_size = self.symbols[id_idx].array_size;
                    }
                    // N-dim-array decay: seed strides for each of
                    // the N-1 levels of multi-dim subscript. The
                    // first stride goes into `pending_index_stride`
                    // (consumed by the next Brak); the rest queue
                    // in `pending_index_strides_tail` and shift
                    // down per Brak.
                    let elem_ty = self.symbols[id_idx].type_;
                    let elem_size = self.size_of_type(elem_ty) as i64;
                    let dims = self.symbols[id_idx].array_dims.clone();
                    self.seed_multi_dim_strides(&dims, elem_size);
                } else if is_struct_value {
                    if identifier_is_local {
                        // Struct value rvalue: the symbol's
                        // address is the rvalue, no Li runs. Field
                        // access through `.f` emits its own Li
                        // against the field offset; treat the
                        // struct itself as address-escaped so the
                        // unused-symbol analysis stays conservative.
                        self.symbols[id_idx].address_escaped = true;
                    }
                    // Dual-emit: like the array-decay branch, the
                    // address is the rvalue (C99 6.7.2.1 struct
                    // assignment semantics + c5's
                    // address-as-value rule). Push the Ident so
                    // wrapping shapes (`.field`, call-arg copy,
                    // struct-to-struct assign) see the producer
                    // on `ast_acc`. Walker treats Ident-of-struct
                    // as an address-only producer (no load).
                    self.ast_emit_ident(id_idx as u32, self.ty);
                } else {
                    // Pointers to structs and every scalar type go
                    // through the normal load_op_for path.
                    self.emit_op(load_op_for(self.ty, self.target));
                    // Dual-emit: the bytecode `Lea / data-Imm` +
                    // scalar load collapses into a single AST
                    // `Expr::Ident` keyed on the symbol-table
                    // index. The address-of / assignment paths
                    // re-interpret the same node as an lvalue.
                    self.ast_emit_ident(id_idx as u32, self.ty);
                    if identifier_is_local {
                        // Tentative: the load survives by default,
                        // so the symbol's value is being read. The
                        // assignment / address-of helpers revert
                        // `was_read` and `pending_stores` to their
                        // prior state (preserving genuine earlier
                        // reads and prior dead-store entries) if
                        // they remove the load from the bytecode
                        // before it executes. `last_loaded_local`
                        // lets those helpers know which symbol the
                        // trailing load belonged to.
                        self.pending.last_loaded_local = Some(id_idx);
                        self.pending.last_loaded_local_prior_was_read =
                            self.symbols[id_idx].was_read;
                        self.pending.last_loaded_local_prior_pending =
                            core::mem::take(&mut self.symbols[id_idx].pending_stores);
                        self.symbols[id_idx].was_read = true;
                    }
                    // Seed the fn-pointer chain depth from
                    // the symbol's recorded indirection. emit_op
                    // just cleared the field; re-set it now so the
                    // surrounding unary-`*` chain can recognise
                    // function-pointer decay. `fn_ptr_indirection`
                    // is "indirection above fn-ptr, plus 1"; depth
                    // after the load is one less (the load itself
                    // consumed one indirection level).
                    let fpi = self.symbols[id_idx].fn_ptr_indirection;
                    if fpi > 0 {
                        self.pending.fn_ptr_chain_depth = fpi - 1;
                    }
                    // N-dim-array parameter decay: a parameter
                    // declared as `T name[A][B][C]` carries
                    // `array_dims = [A, B, C]` on its symbol but
                    // the function-param binder wiped `array_size`
                    // to 0 (per C99 6.7.5.3p7 the outermost
                    // dimension decays to a pointer, and params
                    // don't own storage). The loaded value is
                    // already a pointer (one level less than the
                    // array would have been), so the pointee size
                    // is `pointee_size(self.ty)` rather than the
                    // element size; the strides for `[i]`, `[j]`,
                    // ... `[N-1]` are seeded into the pending
                    // queue.
                    let dims = self.symbols[id_idx].array_dims.clone();
                    if !dims.is_empty() && is_pointer_ty(self.ty) {
                        if dims[0] == 0 {
                            // Pointer-to-array variable
                            // (`T (*p)[M1][Mn]`): the declarator
                            // baked one Ptr per `Mi` into the
                            // symbol's type. Collapse those Ptrs so
                            // the surviving level is the single
                            // decayed-array pointer to the scalar
                            // element. Element size comes from the
                            // type at the bottom of the array Ptrs;
                            // the n-1 trailing Ptrs (one per Mi
                            // after the `*` itself) get peeled.
                            let array_ptrs = (dims.len() as i64) - 1;
                            let scalar_ty =
                                self.symbols[id_idx].type_ - (dims.len() as i64) * (Ty::Ptr as i64);
                            self.ty -= array_ptrs * (Ty::Ptr as i64);
                            let elem_size = self.size_of_type(scalar_ty) as i64;
                            self.seed_multi_dim_strides(&dims, elem_size);
                        } else {
                            let elem_size = self.pointee_size(self.ty);
                            self.seed_multi_dim_strides(&dims, elem_size);
                        }
                    }
                }
            }
        } else if self.lex.tk == '(' {
            self.next()?;
            if self.lex_is_type_start() {
                // C-style cast: `(<type>)expr`. Accepts int, char,
                // float, double, or struct base, with any number of
                // `*` markers and pointer-level qualifiers.
                t = self.parse_decl_base_type()?;
                // Fn-pointer lineage: if the base type came from a
                // typedef-of-fn-pointer, parse_decl_base_type seeded
                // `pending_fn_ptr_indirection`; the leading `*`s
                // below add directly to that count. The abstract
                // fn-ptr branch further down overrides this when a
                // `(*)(args)` shape is present in the cast.
                let mut cast_fpi = self.pending.fn_ptr_indirection.take();
                while self.lex.tk == Token::MulOp {
                    self.next()?;
                    t += Ty::Ptr as i64;
                    if let Some(fpi) = cast_fpi {
                        cast_fpi = Some(fpi + 1);
                    }
                    while self.lex.tk == Token::TypeQual {
                        self.next()?;
                    }
                }
                // Function-pointer cast inside a cast expression:
                // any abstract function-pointer declarator after
                // the base type. Common shapes:
                //   `(int (*)(args))expr`
                //   `(void (*)(void))expr`
                //   `(void(*(*)(args))(void))expr`  -- function
                //       returning function pointer
                // c5's type representation is base + pointer-level,
                // so we treat the entire abstract-declarator tail
                // as a no-op pointer level. Counted-parens scan
                // until the cast's outer `)` so even nested fp
                // shapes consume cleanly.
                if self.lex.tk == '(' {
                    let mut depth: i64 = 1;
                    self.next()?;
                    let mut nested_ptrs: i64 = 0;
                    while depth > 0 && self.lex.tk != 0 {
                        if self.lex.tk == '(' {
                            depth += 1;
                        } else if self.lex.tk == ')' {
                            depth -= 1;
                            if depth == 0 {
                                self.next()?;
                                break;
                            }
                        } else if self.lex.tk == Token::MulOp && depth == 1 {
                            nested_ptrs += 1;
                        }
                        self.next()?;
                    }
                    // C99 6.7.6 abstract declarators after the
                    // inner `)`: a `(args)` arg-list for the
                    // function-returning-fn shape OR a `[N]` /
                    // `[]` array suffix for the
                    // pointer-to-array shape (`T (*)[N]`). Both
                    // are no-ops at c5's type-tag granularity --
                    // the resulting type is the pointer level
                    // already accumulated. Multiple `[N]`
                    // suffixes (`T (*)[N][M]`) are absorbed too;
                    // they don't change the result type beyond
                    // what `nested_ptrs` already encodes.
                    if self.lex.tk == '(' {
                        self.next()?;
                        self.skip_balanced_parens_after_open()?;
                    }
                    while self.lex.tk == Token::Brak {
                        self.next()?;
                        if self.lex.tk == ']' {
                            self.next()?;
                        } else {
                            let _ = self.parse_constant_int()?;
                            if self.lex.tk == ']' {
                                self.next()?;
                            }
                        }
                    }
                    t += nested_ptrs * (Ty::Ptr as i64);
                    // Abstract fn-ptr declarator: the inner `*`
                    // count IS the indirection from the cast's
                    // result down to the fn-ptr rvalue, plus 1
                    // (matching `Symbol::fn_ptr_indirection`).
                    if nested_ptrs > 0 {
                        cast_fpi = Some(nested_ptrs);
                    }
                }
                if self.lex.tk == ')' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("bad cast"));
                }
                self.expr(Token::Inc as i64)?;
                let cast_child_ast = self.ast_acc;
                // FP-vs-int casts emit conversion ops so the bit
                // pattern in r13 is consistent with the new type.
                // Same-class casts (int<->ptr, float<->double) are
                // bit-pattern-compatible and need no conversion.
                let target_is_fp = is_floating_scalar(t);
                let source_is_fp = is_floating_scalar(self.ty);
                if target_is_fp && !source_is_fp {
                    self.emit_op(Op::Fcvtif);
                } else if !target_is_fp && source_is_fp {
                    self.emit_op(Op::Fcvtfi);
                } else if !target_is_fp
                    && !source_is_fp
                    && !is_pointer_ty(t)
                    && !is_pointer_ty(self.ty)
                {
                    // Cast to a non-pointer integer narrower than
                    // 8 bytes: re-extend the accumulator to the
                    // target storage width. c5 keeps every value
                    // sign- or zero-extended to 64 bits in the
                    // accumulator, so a cast that narrows in C99
                    // is otherwise invisible until the value lands
                    // in a typed slot.
                    //
                    // Unsigned target -> mask the high bits.
                    // Signed target  -> shift-left then arith-shift-
                    //                   right by (64 - width*8) so
                    //                   the high bit of the target
                    //                   propagates.
                    let target_size = self.size_of_type(t);
                    let source_size = self.size_of_type(self.ty);
                    if is_unsigned_ty(t) {
                        let mask: i64 = match target_size {
                            1 => 0xff,
                            2 => 0xffff,
                            4 => 0xffff_ffff,
                            _ => -1,
                        };
                        if mask != -1 {
                            self.emit_binop_with_imm(Op::And, mask);
                        }
                    } else if target_size == 1 || target_size == 2 || target_size == 4 {
                        // Signed cast: shift-pair to mask + sign-extend
                        // to the target storage width. Fires when:
                        //  * the cast genuinely narrows (target_size <
                        //    source_size) -- e.g. `(signed char)int_val`,
                        //  * source is unsigned at the same width as the
                        //    signed target -- the accumulator is zero-
                        //    extended, but `(signed char)(unsigned char)`
                        //    has to flip values >= 0x80 to negative per
                        //    C99 6.3.1.3.
                        // Skipped for same-width signed-to-signed casts
                        // (already correctly sign-extended in the
                        //  accumulator) and widening signed casts (the
                        //  source-side load did the extension).
                        let source_is_unsigned = is_unsigned_ty(self.ty);
                        let needs_extend = target_size < source_size
                            || (target_size == source_size && source_is_unsigned);
                        if needs_extend {
                            let bits = 64i64 - (target_size as i64) * 8;
                            self.emit_binop_with_imm(Op::Shl, bits);
                            self.emit_binop_with_imm(Op::Shr, bits);
                        }
                    }
                }
                self.ty = t;
                // Overwrite the AST acc with a canonical Cast
                // node so the intermediate Binary nodes the
                // bytecode conversion dance pushed don't surface
                // as the cast's value. The dropped nodes have no
                // consumers; the SSA walker won't visit them.
                if let Some(child) = cast_child_ast {
                    self.ast_emit_cast(child, t);
                }
                // Re-seed the fn-ptr chain depth from the
                // cast destination so a unary `*` chain that
                // follows a `(fn_t*)expr` cast (e.g.
                // `(**(finder_type*)pVfs->pAppData)(...)`) can
                // recognise the decay. The cast result lives
                // in `a`, so the depth is `cast_fpi - 1`.
                if let Some(fpi) = cast_fpi
                    && fpi > 0
                {
                    self.pending.fn_ptr_chain_depth = fpi - 1;
                }
            } else {
                self.expr(Token::Assign as i64)?;
                // Comma operator within parens: `(a, b, c)` evaluates
                // each subexpression for its side effects and yields
                // the last. Outside parens, comma stays a separator
                // (function args, declarators) -- this branch only
                // fires inside `(...)` because expr(Assign) doesn't
                // consume `,`.
                while self.lex.tk == ',' {
                    self.next()?;
                    self.expr(Token::Assign as i64)?;
                }
                if self.lex.tk == ')' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("close paren expected"));
                }
                // Forward the inner expr's exit snapshot into the
                // active multi-dim queue so the outer expression's
                // postfix can keep striding through, e.g.,
                // `(*p)[k]` on a pointer-to-array (the unary `*`
                // consumed one dim, the `[k]` should pick up the
                // next). Without this transfer the inner expr's
                // defensive clear strands the remaining strides.
                self.pending.index_stride = core::mem::take(&mut self.pending.end_of_expr_stride);
                self.pending.index_strides_tail =
                    core::mem::take(&mut self.pending.end_of_expr_strides_tail);
            }
        } else if self.lex.tk == Token::MulOp {
            self.next()?;
            // Stash whatever the surrounding scope had in the
            // "end-of-expr" capture slots so the recursive expr()
            // that parses our operand can populate them fresh.
            // After the parse, the new values tell us what
            // strides the operand left unconsumed -- the signal
            // we use to decide whether `*p` is a pointer-to-array
            // row deref. The outer snapshot is restored afterwards
            // so a containing operator's view isn't disturbed.
            let saved_eos_stride = core::mem::take(&mut self.pending.end_of_expr_stride);
            let saved_eos_tail = core::mem::take(&mut self.pending.end_of_expr_strides_tail);
            self.expr(Token::Inc as i64)?;
            let leftover_stride = core::mem::take(&mut self.pending.end_of_expr_stride);
            let leftover_tail = core::mem::take(&mut self.pending.end_of_expr_strides_tail);
            self.pending.end_of_expr_stride = saved_eos_stride;
            self.pending.end_of_expr_strides_tail = saved_eos_tail;
            // C function-pointer decay (6.3.2.1 / 6.3.4): `*` on
            // a function-pointer rvalue is a no-op -- it yields
            // back the same function pointer. The chain-depth
            // side-channel marks the operand as already at the
            // fn-ptr level, so we suppress the load and leave
            // both the type and the accumulator unchanged. Next
            // `*` keeps decaying; eventually the postfix `(`
            // call-site reads `a` as the function pointer.
            //
            // Without this branch the existing handler emits a
            // spurious `Li` that loads through the function
            // pointer's bit pattern, hits unmapped memory, and
            // SIGBUSes when called. The conservative pop in the
            // call-site path catches this only when the result
            // type drops to a non-pointer; if the function's
            // return type is itself a pointer (e.g. an
            // `io_methods *`-returning fn-ptr typedef)
            // the pop is short-circuited and the
            // garbage call target slips through.
            if self.pending.fn_ptr_chain_depth == 0 {
                // Decay no-op. Keep depth at 0: the decayed
                // result is itself a fn-ptr rvalue, so any
                // further `*`s also decay.
                // Note: emit_op was not called, so the chain
                // depth is preserved (no clear happened).
            } else if leftover_stride > 0 {
                // Pointer-to-array operand: `*p` is the row
                // deref, equivalent to `p[0]`. The row's address
                // is already in `a` -- no load, no Ptr peel.
                // Consume the head stride (we just stepped over
                // one dim at index 0) and shift the rest into
                // the active queue so a following postfix `[k]`
                // strides correctly. Surface the row's byte
                // size via `last_array_decay_bytes` so an
                // enclosing `sizeof` recovers it.
                self.pending.last_array_decay_bytes = leftover_stride;
                let mut tail = leftover_tail;
                self.pending.index_stride = if tail.is_empty() { 0 } else { tail.remove(0) };
                self.pending.index_strides_tail = tail;
            } else {
                if is_pointer_ty(self.ty) {
                    self.ty -= Ty::Ptr as i64;
                } else {
                    return Err(self.compile_err("bad dereference"));
                }
                // `*p` where `p` is a struct pointer yields a struct
                // *value*. c5 represents struct values address-as-
                // value: the address goes in `a`, no load. The next
                // op (`.field`, `= rhs` lowering Mcpy, etc.) reads
                // the address from `a` directly.
                let result_is_struct_value =
                    is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                // Dual-emit: capture the operand snapshot before
                // the load op runs `ast_track_emit_op` (which is
                // a no-op for load ops today, but capturing here
                // matches the assignment / cast pattern).
                let deref_child_ast = self.ast_acc;
                if !result_is_struct_value {
                    let prior_depth = self.pending.fn_ptr_chain_depth;
                    self.emit_op(load_op_for(self.ty, self.target));
                    // emit_op cleared the chain depth. Restore it
                    // one level deeper if the operand was tracked:
                    // a real deref consumes one level of indirection
                    // toward the fn-ptr. (-1 stays -1.)
                    if prior_depth > 0 {
                        self.pending.fn_ptr_chain_depth = prior_depth - 1;
                    }
                }
                // Push `Expr::Unary { op: Deref, child, ty }`. For
                // struct-value `*p` the result type is the struct
                // and the address-as-value rule means no load
                // happened; the same Unary node still lets a
                // wrapping `.field` / `= rhs` lookup the AST shape.
                if let Some(child) = deref_child_ast {
                    let result_ty = self.ty;
                    let pos = self.ast_src_pos();
                    let id = self.ast.push_expr(
                        super::super::ast::Expr::Unary {
                            op: super::super::ast::UnOp::Deref,
                            child,
                            ty: result_ty,
                        },
                        pos,
                    );
                    self.ast_acc = Some(id);
                }
                // The operand may have been an array-decayed pointer
                // (e.g. `*arr` where `arr` is `T arr[N]`), in which
                // case the identifier-load path seeded
                // `last_array_decay_size` with the array's element
                // count. After the `*` consumed that decay, the
                // value is no longer the array-of-T shape but the
                // T-shaped first element, so an enclosing
                // `sizeof(*arr)` must compute `sizeof(T)` rather
                // than `N * sizeof(T)`. Clear the marker.
                self.pending.last_array_decay_size = 0;
                self.pending.last_array_decay_bytes = 0;
            }
        } else if self.lex.tk == Token::AndOp {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            // Order matters here: a struct-value rvalue (`p->mutex`
            // where `mutex` is a struct field, or `*p` where `p`
            // is a struct pointer) leaves the field's address in
            // `a` *without* emitting a trailing Li for the load
            // that produced the address. But the parser may still
            // have emitted an Li for *something earlier in the
            // chain* (e.g. the `Li` that loaded `p`'s value to
            // reach `p->mutex`). Popping that Li would unwind one
            // step too far and yield `&p` instead of `&p->mutex`.
            //
            // So check the resulting type *first*: if `&expr`
            // yields a struct value, the underlying address is
            // already in `a` and we leave the IR alone. Only the
            // remaining scalar / pointer-rvalue cases pop the
            // trailing load.
            // Bump `self.ty` by one pointer level FIRST so the
            // dual-emit helper called from
            // `pop_trailing_scalar_load` captures the post-`&`
            // type. Without the pre-bump the AST `Expr::Unary {
            // op: AddrOf, ty }` carried the pre-`&` scalar /
            // pointer type, and a wrapping `(T *)&x` cast saw
            // the wrong source kind in the walker (e.g. `float`
            // instead of `float *`, which made the cast walker
            // pick `FpCast(FpToInt)` instead of the integer
            // pass-through).
            let pre_addr_ty = self.ty;
            let _ = pre_addr_ty;
            self.ty += Ty::Ptr as i64;
            if is_struct_ty(pre_addr_ty) && struct_ptr_depth(pre_addr_ty) == 0 {
                // Struct value -- the parser already left the
                // address in `a` (no final-load Li). `&s` just
                // raises the type by one pointer level; no IR
                // change needed.
            } else if self.pop_trailing_scalar_load() {
                // Scalar / pointer lvalue: dropped the trailing
                // load so what's left is the address-producing op.
            } else if is_pointer_ty(pre_addr_ty) {
                // Array-decay shape: `&arr` and `&pPager->dbFileVers`
                // when `dbFileVers` is a `char[16]` field. The
                // expression already yielded the array's address as
                // its rvalue (no Li was emitted), so `&` is a no-op
                // at the IR level; the type bump below tracks the
                // extra pointer level.
            } else {
                return Err(self.compile_err("bad address-of"));
            }
            // The pointer-level bump was applied above before
            // `pop_trailing_scalar_load` so the dual-emit
            // captured the post-`&` type.
            // `&` adds one pointer level toward the fn-ptr
            // for any chain we were tracking. -1 (untracked) stays
            // -1.
            if self.pending.fn_ptr_chain_depth >= 0 {
                self.pending.fn_ptr_chain_depth += 1;
            }
        } else if self.lex.tk == '!' {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_binop_with_imm(Op::Eq, 0);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == '~' {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_binop_with_imm(Op::Xor, -1);
            // C99 6.5.3.3: `~` applies integer promotions; the result
            // has the promoted operand's type. `unsigned char` /
            // `unsigned short` promote to signed `int`, so no mask.
            // `unsigned int` (size 4 unsigned that doesn't promote
            // down) stays unsigned int -- mask the high half back to
            // 32 bits so the register doesn't carry the
            // 0xFFFFFFFF.... high pattern from `XOR -1`.
            let operand_ty = self.ty;
            if is_unsigned_ty(operand_ty) && self.size_of_type(operand_ty) == 4 {
                self.emit_binop_with_imm(Op::And, 0xffff_ffff);
                self.ty = operand_ty;
            } else {
                self.ty = Ty::Int as i64;
            }
        } else if self.lex.tk == Token::AddOp {
            // Unary `+`: a no-op per C99 6.5.3.3p2. The operand's
            // type is preserved (subject to integer promotion for
            // sub-int integer operands -- a `(unsigned char)c`
            // promotes to `int`, which the `+` doesn't undo).
            // Critically, FP operands must keep their FP type --
            // otherwise `+0.5` poses as an integer and a later
            // `r + (+0.5)` lowers to `Op::Add` instead of `Op::Fadd`.
            self.next()?;
            self.expr(Token::Inc as i64)?;
            if !is_floating_scalar(self.ty) {
                self.ty = Ty::Int as i64;
            }
        } else if self.lex.tk == Token::SubOp {
            self.next()?;
            // Constant-fold `-<int-literal>` into `Imm -N`. Float
            // literals don't qualify -- we want Op::Fneg to apply
            // to the parsed f64 bit pattern, not a sign flip on the
            // integer-shaped operand.
            if self.lex.tk == Token::Num {
                let val = self.lex.ival;
                let negated = val.wrapping_neg();
                self.emit_imm(negated);
                // C99 6.5.3.3p3: unary `-` returns the integer-
                // promoted operand type. The literal's type comes
                // from C99 6.4.4.1p5 (first of int / long / long
                // long that holds the magnitude), so a value past
                // INT_MAX must not stay at `int` here -- otherwise
                // the post-Add/Sub mask in `convert.rs` truncates
                // a downstream `-MAX - 1` back to 32 bits and
                // yields 0 instead of `INT64_MIN`.
                self.ty = self.literal_auto_promoted_type(val);
                // Dual-emit: the constant-folded `-N` collapses
                // the unary-minus on the AST side too. Seed
                // `ast_acc` with the matching IntLit so a
                // wrapping expression (cast, call-arg, assignment)
                // finds the folded value on the accumulator
                // instead of whatever stale id the caller left.
                self.ast_emit_int_lit(negated, self.ty);
                self.next()?;
            } else {
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(self.ty) {
                    self.emit_op(Op::Fneg);
                    // self.ty already matches the operand's FP type
                } else {
                    // C99 6.5.3.3 paragraph 3: the integer promotions
                    // are performed on the operand of unary `-`, and
                    // the result has the promoted operand type.
                    // Forcing `Ty::Int` here would drop the high half
                    // of a `long long` / `unsigned long long` operand
                    // and run any subsequent comparison or shift on
                    // the negated value in `int`.
                    let operand_ty = self.ty;
                    self.emit_binop_with_imm(Op::Mul, -1);
                    self.ty = integer_promote(operand_ty);
                    // C99 6.5.3.3p3: result has the promoted operand
                    // type and follows that type's overflow rules.
                    // For `unsigned int` (4-byte unsigned that does
                    // not promote down) wrap modulo 2^32, otherwise
                    // the 64-bit Mul leaves the sign-extended high
                    // half set and a downstream Or / Shr operates
                    // on the wider pattern.
                    if is_unsigned_ty(self.ty) && self.size_of_type(self.ty) == 4 {
                        self.emit_binop_with_imm(Op::And, 0xffff_ffff);
                    }
                }
            }
        } else if self.lex.tk == Token::Inc || self.lex.tk == Token::Dec {
            t = self.lex.tk.raw();
            self.next()?;
            self.expr(Token::Inc as i64)?;
            // Snapshot the lvalue's AST node before the bytecode
            // dance below: rewrite + reload + Psh + Imm + Add/Sub
            // + store_op all run through `ast_apply_*` helpers
            // that pop the vstack regardless of whether the build
            // succeeded, so by the time `ast_emit_pre_inc` fires
            // the lvalue would otherwise be gone.
            let pre_inc_lvalue = self.ast_acc;
            let reload = self
                .rewrite_trailing_load_as_psh()
                .ok_or_else(|| self.compile_err("bad lvalue in pre-increment"))?;
            // ++/-- reads the prior value and stores a new one.
            // `take_last_loaded_local` restored was_read to its
            // pre-load state; force it true because the reload
            // below re-emits the load. The read clears any
            // pending dead-store entries; the subsequent store
            // pushes a fresh one.
            let line = self.lex.line;
            if let Some(idx) = self.take_last_loaded_local() {
                self.symbols[idx].was_read = true;
                self.symbols[idx].was_written = true;
                self.record_local_read(idx);
                self.record_local_store(idx, line);
            }
            self.emit_op(reload);
            if is_floating_scalar(self.ty) {
                return Err(self.compile_err("floating-point ++/-- not yet implemented"));
            }
            self.emit_op(Op::Psh);
            let step = self.pointee_step(self.ty);
            self.emit_imm(step);
            self.emit_op(if t == Token::Inc as i64 {
                Op::Add
            } else {
                Op::Sub
            });
            self.emit_op(store_op_for(self.ty, self.target));
            // Dual-emit: the bytecode tier just ran the six-op
            // increment sequence; collapse it into one
            // `Expr::PreInc` whose `by` is signed by the op
            // direction so the walker can route to a single
            // `binop_imm(Add, lvalue, by)` rather than match the
            // sign separately. The lvalue producer is already on
            // the parser-side vstack from the trailing-load
            // rewrite.
            let pre_inc_step = if t == Token::Inc as i64 { step } else { -step };
            let pre_inc_ty = self.ty;
            if let Some(lvalue) = pre_inc_lvalue {
                self.ast_emit_pre_inc(lvalue, pre_inc_step, pre_inc_ty);
            }
        } else {
            // The parse-error message includes the enclosing function
            // name and (for `Token::Id`) the identifier name -- those
            // two facts make a parse error like a stuck macro
            // expansion tractable, vs. a generic "bad expression"
            // which is otherwise opaque.
            let func = self.current_function_name.clone();
            let id_suffix = if self.lex.tk == Token::Id {
                format!(" `{}`", self.symbols[self.lex.curr_id_idx].name)
            } else {
                String::new()
            };
            return Err(self.compile_err(format!(
                "bad expression: got {}{id_suffix} (in {func})",
                super::super::token::describe(self.lex.tk),
            )));
        }

        while self.lex.tk >= lev || self.lex.tk == '(' {
            t = self.ty;
            // The array-decay flag tracks the *trailing* decay so
            // `sizeof(arr)` recovers the real array size. Once
            // any further postfix / binop runs, the value is
            // consumed -- clear the flag so the decay doesn't
            // leak into a sizeof of an unrelated subexpression.
            self.pending.last_array_decay_size = 0;
            self.pending.last_array_decay_bytes = 0;
            if self.lex.tk == '(' {
                // Snapshot the callee AST + vstack depth before
                // any of the call's bytecode emit sites perturb
                // the dual-emit state. The indirect-call dual-
                // emit at the end of this branch builds an
                // `Expr::Call { callee, args, ty }` from these.
                let callee_ast = self.ast_acc;
                let ast_vstack_snapshot = self.ast_vstack.len();
                let mut indirect_arg_ids: alloc::vec::Vec<Option<super::super::ast::ExprId>> =
                    alloc::vec::Vec::new();
                // Postfix indirect call: the expression so far put a
                // function-pointer value in `a`. Examples:
                //   `s.fp(args)` -- function-pointer struct field
                //   `arr[i](args)` -- function-pointer array element
                //   `(*fp)(args)` -- explicit dereference shape
                //   `(**fpp)(args)` -- dereference through a pointer
                //                       to a function-pointer variable
                // Direct identifier calls (`name(args)`) take the
                // dedicated path higher up that knows the symbol's
                // class and signature; that path consumes `(`
                // immediately and never reaches the Pratt loop.
                //
                // C's function-pointer-decay rule says `*fp` (where
                // `fp` is a function-pointer rvalue) is a no-op:
                // the dereferenced "function lvalue" auto-decays
                // back to a function pointer for any subsequent use.
                // The unary `*` handler emits an `Op::Li` regardless
                // -- it can't tell at parse time that the operand
                // will be called rather than loaded -- so the chain
                // ends one Li too deep, with `a` holding the first
                // 8 bytes of the callee's code instead of its
                // address. We undo that here: if `self.ty` says we
                // ended on a non-pointer (= the last `*` removed
                // the final pointer level) and the most recent emit
                // was an `Op::Li`, pop the Li and restore one
                // pointer level so the spill below sees the actual
                // function pointer.
                if !is_pointer_ty(self.ty) {
                    let last = self.text.last().copied();
                    let is_load = matches!(
                        last,
                        Some(x) if x == Op::Li as i64
                            || x == Op::Lc as i64
                            || x == Op::Lw as i64
                            || x == Op::Lwu as i64
                    );
                    if is_load {
                        self.text.pop();
                        self.source_lines.pop();
                        self.source_functions.pop();
                        self.source_file_indices.pop();
                        self.ty += Ty::Ptr as i64;
                    }
                }
                self.next()?;
                // Spill the FP into a fresh local temp via Op::StLocI.
                // The plain `Lea N; Si` shape can't express this
                // without losing `a` (Lea clobbers `a`), so the c5
                // dialect carries a dedicated store-local op for the
                // case where `a` already holds the value.
                self.loc_offs += 1;
                if self.loc_offs > self.max_loc_offs {
                    self.max_loc_offs = self.loc_offs;
                }
                let fp_temp = -self.loc_offs;
                self.emit_op(Op::StLocI);
                self.emit_val(fp_temp);
                // Each arg lands in its own temp slot first
                // (left-to-right eval), then we push them
                // right-to-left so the first arg ends up on top of
                // the c5 stack.
                let mut temp_offsets: Vec<i64> = Vec::new();
                let mut nargs: i64 = 0;
                while self.lex.tk != ')' {
                    self.loc_offs += 1;
                    if self.loc_offs > self.max_loc_offs {
                        self.max_loc_offs = self.loc_offs;
                    }
                    let temp_off = -self.loc_offs;
                    temp_offsets.push(temp_off);
                    self.emit_lea(temp_off);
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;
                    indirect_arg_ids.push(self.ast_acc);
                    self.emit_op(Op::Si);
                    nargs += 1;
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
                }
                self.next()?; // consume `)`
                for &temp_off in temp_offsets.iter().rev() {
                    self.emit_lea(temp_off);
                    self.emit_op(Op::Li);
                    self.emit_op(Op::Psh);
                }
                self.emit_lea(fp_temp);
                self.emit_op(Op::Li);
                self.emit_op(Op::Jsri);
                if nargs > 0 {
                    self.emit_op(Op::Adj);
                    self.emit_val(nargs);
                }
                // The dialect can't declare the return type of a
                // function pointer, so default to `int`. The actual
                // register value carries the full 8-byte return
                // regardless of the tag.
                self.ty = Ty::Int as i64;
                // Dual-emit the indirect call. Drop the AST
                // vstack pushes the bytecode dance leaked,
                // mirror of the direct-call truncation.
                self.ast_vstack.truncate(ast_vstack_snapshot);
                let return_ty = self.ty;
                if let Some(callee_id) = callee_ast {
                    let pos = self.ast_src_pos();
                    let mut resolved: alloc::vec::Vec<super::super::ast::ExprId> =
                        alloc::vec::Vec::with_capacity(indirect_arg_ids.len());
                    let mut all_some = true;
                    for a in indirect_arg_ids {
                        match a {
                            Some(id) => resolved.push(id),
                            None => {
                                all_some = false;
                                break;
                            }
                        }
                    }
                    if all_some {
                        let id = self.ast.push_expr(
                            super::super::ast::Expr::Call {
                                callee: callee_id,
                                args: resolved,
                                ty: return_ty,
                            },
                            pos,
                        );
                        self.ast_acc = Some(id);
                    } else {
                        self.ast_acc = None;
                    }
                } else {
                    self.ast_acc = None;
                }
            } else if self.lex.tk == Token::Assign {
                self.next()?;
                let lhs_is_struct_value = is_struct_ty(t) && struct_ptr_depth(t) == 0;
                if lhs_is_struct_value {
                    // Struct-to-struct copy. The LHS already left
                    // its address in `a`; push it so the RHS can
                    // produce the source address into `a`. Then
                    // emit Op::Mcpy with the byte size; the runtime
                    // (VM and both codegens) takes top-of-stack as
                    // dst, accumulator as src, and copies `size`
                    // bytes. Returns dst in `a` to mirror libc
                    // memcpy.
                    //
                    // This branch must run *before* the scalar Li/Lc
                    // rewrite below: for `*pItem = struct_rvalue`
                    // where pItem is a struct pointer, the deref
                    // elides the trailing struct-value load but
                    // leaves the pointer-load Li in place, so
                    // `last == Op::Li` would otherwise misroute us
                    // into the scalar path and rewrite the wrong Li
                    // into a Psh.
                    let struct_lhs_ast = self.ast_acc.take();
                    self.emit_op(Op::Psh);
                    self.expr(Token::Assign as i64)?;
                    let struct_rhs_ast = self.ast_acc;
                    if !is_struct_ty(self.ty) || struct_ptr_depth(self.ty) != 0 {
                        return Err(self.compile_err("cannot assign non-struct value to a struct"));
                    }
                    if t != self.ty {
                        let lhs_s = format_type(t, &self.structs);
                        let rhs_s = format_type(self.ty, &self.structs);
                        return Err(self.compile_err(format!(
                            "struct types differ on either side of `=` \
                             (lhs={lhs_s}, rhs={rhs_s})"
                        )));
                    }
                    let size = self.size_of_type(t);
                    self.emit_op(Op::Mcpy);
                    self.emit_val(size as i64);
                    self.ty = t;
                    // Dual-emit `Expr::Assign { lhs, rhs, ty }`
                    // with the struct type; the walker keys on
                    // `is_struct_ty(ty) && struct_ptr_depth(ty)
                    // == 0` to emit `Inst::Mcpy` instead of the
                    // scalar store.
                    if let (Some(lhs), Some(rhs)) = (struct_lhs_ast, struct_rhs_ast) {
                        let pos = self.ast_src_pos();
                        let id = self.ast.push_expr(
                            super::super::ast::Expr::Assign { lhs, rhs, ty: t },
                            pos,
                        );
                        self.ast_acc = Some(id);
                    } else {
                        self.ast_acc = None;
                    }
                } else if self.rewrite_trailing_load_as_psh().is_some() {
                    // Scalar / pointer assignment: trailing load
                    // rewritten to a push so the address is
                    // preserved on the stack while the RHS evaluates.
                    // `take_last_loaded_local` reverts the tentative
                    // `was_read` the identifier-rvalue path set so
                    // that prior real reads in the function are not
                    // forgotten. The dead-store record runs after
                    // the RHS is parsed -- a self-referencing RHS
                    // like `x = x + 1` reads the prior value and
                    // must not be charged against the store about
                    // to land.
                    let line = self.lex.line;
                    let assigned_local = self.take_last_loaded_local();
                    if let Some(idx) = assigned_local {
                        self.symbols[idx].was_written = true;
                    }
                    self.expr(Token::Assign as i64)?;
                    let rhs_is_zero = self.last_emit_is_zero();
                    let rhs_is_untyped = self.last_emit_was_indirect_call();
                    if let Some(reason) =
                        Self::type_warning_with_flags(t, self.ty, rhs_is_zero, rhs_is_untyped)
                    {
                        let lhs_s = format_type(t, &self.structs);
                        let rhs_s = format_type(self.ty, &self.structs);
                        self.warn_at(
                            line,
                            format!("{reason} in assignment (lhs={lhs_s}, rhs={rhs_s})"),
                        );
                    }
                    // C99 6.5.16.1p2 assignment conversion: when
                    // the lvalue is float / double and the rvalue
                    // is integer (or vice versa), bit-cast through
                    // the IEEE-754 conversion ops so the stored
                    // value matches the destination type's
                    // representation rather than the source's.
                    self.convert_assign_rhs(t);
                    self.ty = t;
                    self.emit_op(store_op_for(self.ty, self.target));
                    if let Some(idx) = assigned_local {
                        self.record_local_store(idx, line);
                    }
                } else {
                    return Err(self.compile_err("bad lvalue in assignment"));
                }
            } else if self.lex.tk == Token::AssignOp {
                // Compound assignment `a OP= b`. The lexer stuffed
                // the underlying binop's Token into `lex.ival`. The
                // shape mirrors plain `=`: rewrite the trailing
                // load (Op::Lc / Op::Li) into Op::Psh so the
                // address sits on the stack, then load it again
                // via Op::Li (or Op::Lc), push, evaluate the RHS,
                // emit the binop, and store. Only scalar / pointer
                // lvalues qualify -- structs and bitfields don't
                // accept compound assignment in c5.
                let binop = self.lex.ival;
                let compound_lhs_ast = self.ast_acc;
                self.next()?;
                // Rewrite the trailing load into a Psh so the
                // address sits on the c5 stack across the compound
                // op; the helper hands back the matching reload op
                // so we can put the current value back into `a`
                // before pushing it for the binop's pop.
                let reload = self
                    .rewrite_trailing_load_as_psh()
                    .ok_or_else(|| self.compile_err("bad lvalue in compound assignment"))?;
                // Compound assignment reads the prior value
                // (`reload` re-emits the load below) and stores a
                // new one. `take_last_loaded_local` reverted
                // was_read to its prior state; force it true
                // because the reload below survives, and add
                // was_written. The dead-store record is deferred
                // until after the binop emits so a self-
                // referencing RHS does not cancel its own store.
                let line = self.lex.line;
                let assigned_local = self.take_last_loaded_local();
                if let Some(idx) = assigned_local {
                    self.symbols[idx].was_read = true;
                    self.symbols[idx].was_written = true;
                    self.record_local_read(idx);
                }
                self.emit_op(reload);
                // Push the current value so the binop can pop it.
                self.emit_op(Op::Psh);
                // For pointer arithmetic with `+=` / `-=`, scale
                // the RHS by the element size before applying the
                // op. We capture lhs ty here; rhs ty is known after
                // expr().
                let lhs_ty = self.ty;
                self.expr(Token::Assign as i64)?;
                let pre_scale_rhs_ast = self.ast_acc;
                if (binop == Token::AddOp as i64 || binop == Token::SubOp as i64)
                    && is_pointer_ty(lhs_ty)
                    && !is_floating_scalar(lhs_ty)
                {
                    let elem_ty = lhs_ty - Ty::Ptr as i64;
                    let elem_size = self.size_of_type(elem_ty) as i64;
                    if elem_size > 1 {
                        self.emit_binop_with_imm(Op::Mul, elem_size);
                    }
                }
                // Capture rhs after the pointer-arithmetic
                // scale ran; the scale is a wrapping `Binary {
                // Mul, rhs, IntLit(scale) }` node and the
                // walker's `CompoundAssign` arm uses the
                // captured id verbatim, so the walker re-emits
                // the same `Mul` chain (rather than letting the
                // walker apply its own pointer scaling).
                let compound_rhs_ast = self.ast_acc.or(pre_scale_rhs_ast);
                // Floating-point lvalue (`double x; x *= 2.0;`) needs
                // the FP variant of the binop, not the integer one.
                // Without this, `x *= y` lowered to `Op::Mul` which
                // multiplied the bit patterns of the two doubles as
                // signed integers, producing a useless result. Same
                // shape applies to `+=` / `-=` / `/=` on doubles.
                let lhs_is_fp = is_floating_scalar(lhs_ty);
                // C99 6.5.16.2: a compound assignment is equivalent
                // to `E1 = (E1) OP (E2)` with E1 evaluated once. The
                // OP step is the same arithmetic step as the binary
                // operator, so when one side is FP we have to apply
                // the same int->FP lift the binary path uses --
                // otherwise `x *= -1` (FP lvalue, int rvalue) hands
                // the FP op a 64-bit signed `-1` and produces NaN
                // straight away. C99 6.5.16.2 specifies that the
                // arithmetic is performed in the type of `E1 op
                // E2` and the result is converted back to E1's
                // type, so an integer RHS must be widened to
                // double before the FP op runs.
                if lhs_is_fp || is_floating_scalar(self.ty) {
                    self.require_both_float(lhs_ty, "compound assign")?;
                }
                let op = match binop {
                    x if x == Token::AddOp as i64 => {
                        if lhs_is_fp {
                            Op::Fadd
                        } else {
                            Op::Add
                        }
                    }
                    x if x == Token::SubOp as i64 => {
                        if lhs_is_fp {
                            Op::Fsub
                        } else {
                            Op::Sub
                        }
                    }
                    x if x == Token::MulOp as i64 => {
                        if lhs_is_fp {
                            Op::Fmul
                        } else {
                            Op::Mul
                        }
                    }
                    x if x == Token::DivOp as i64 => {
                        if lhs_is_fp {
                            Op::Fdiv
                        } else if is_unsigned_ty(lhs_ty) {
                            Op::Divu
                        } else {
                            Op::Div
                        }
                    }
                    x if x == Token::ModOp as i64 => {
                        if is_unsigned_ty(lhs_ty) {
                            Op::Modu
                        } else {
                            Op::Mod
                        }
                    }
                    x if x == Token::AndOp as i64 => Op::And,
                    x if x == Token::OrOp as i64 => Op::Or,
                    x if x == Token::XorOp as i64 => Op::Xor,
                    x if x == Token::ShlOp as i64 => Op::Shl,
                    x if x == Token::ShrOp as i64 => {
                        if is_unsigned_ty(lhs_ty) {
                            Op::Shru
                        } else {
                            Op::Shr
                        }
                    }
                    _ => {
                        return Err(self.compile_err("unknown compound-assign opcode"));
                    }
                };
                self.emit_op(op);
                self.ty = lhs_ty;
                self.emit_op(store_op_for(self.ty, self.target));
                if let Some(idx) = assigned_local {
                    self.record_local_store(idx, line);
                }
                // Dual-emit `Expr::CompoundAssign`. Map the
                // selected bytecode `Op` to the matching `BinOp`
                // so the walker can reproduce the binop without
                // re-running the FP-vs-int dispatch.
                use super::super::ir::BinOp as B;
                let ast_binop = match op {
                    Op::Add => Some(B::Add),
                    Op::Sub => Some(B::Sub),
                    Op::Mul => Some(B::Mul),
                    Op::Div => Some(B::Div),
                    Op::Mod => Some(B::Mod),
                    Op::Divu => Some(B::Divu),
                    Op::Modu => Some(B::Modu),
                    Op::Or => Some(B::Or),
                    Op::Xor => Some(B::Xor),
                    Op::And => Some(B::And),
                    Op::Shl => Some(B::Shl),
                    Op::Shr => Some(B::Shr),
                    Op::Shru => Some(B::Shru),
                    Op::Fadd => Some(B::Fadd),
                    Op::Fsub => Some(B::Fsub),
                    Op::Fmul => Some(B::Fmul),
                    Op::Fdiv => Some(B::Fdiv),
                    _ => None,
                };
                if let (Some(lhs), Some(rhs), Some(bop)) =
                    (compound_lhs_ast, compound_rhs_ast, ast_binop)
                {
                    let ca_ty = self.ty;
                    self.ast_emit_compound_assign(bop, lhs, rhs, ca_ty);
                }
            } else if self.lex.tk == Token::Cond {
                let cond_ast = self.ast_acc;
                self.next()?;
                self.emit_op(Op::Bz);
                let b_else = self.text.len();
                self.emit_val(0);
                self.expr(Token::Assign as i64)?;
                // Comma operator in the middle of a ternary:
                // `cond ? (side_effect, value) : alt`. C allows
                // `e1, e2, ..., eN` in the ternary's then-arm
                // because the spec says it's an *expression*, not
                // an assignment-expression. expr(Assign) stops at
                // `,`; resume the chain here so the colon search
                // finds its match.
                while self.lex.tk == ',' {
                    self.next()?;
                    self.expr(Token::Assign as i64)?;
                }
                let then_ast = self.ast_acc;
                if self.lex.tk == ':' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("conditional missing colon"));
                }
                let b_end_val = (self.text.len() + 2) as i64;
                self.text[b_else] = b_end_val;
                self.emit_op(Op::Jmp);
                let b_end = self.text.len();
                self.emit_val(0);
                self.expr(Token::Cond as i64)?;
                let else_ast = self.ast_acc;
                self.text[b_end] = self.text.len() as i64;
                // Dual-emit Expr::Ternary. The branch fixups above
                // resolve forward into the bytecode; the AST
                // captures the three sub-expressions for the
                // walker to lower with branch + phi-like join.
                if let (Some(cond), Some(then_e), Some(else_e)) = (cond_ast, then_ast, else_ast) {
                    let pos = self.ast_src_pos();
                    let ty = self.ty;
                    let id = self.ast.push_expr(
                        super::super::ast::Expr::Ternary {
                            cond,
                            then_e,
                            else_e,
                            ty,
                        },
                        pos,
                    );
                    self.ast_acc = Some(id);
                }
            } else if self.lex.tk == Token::Lor {
                let lhs_ast = self.ast_acc;
                self.next()?;
                self.emit_op(Op::Bnz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::Lan as i64)?;
                let rhs_ast = self.ast_acc;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
                if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                    self.ast_emit_short_circuit(
                        super::super::ast::ShortCircuitOp::Lor,
                        lhs,
                        rhs,
                        Ty::Int as i64,
                    );
                }
            } else if self.lex.tk == Token::Lan {
                let lhs_ast = self.ast_acc;
                self.next()?;
                self.emit_op(Op::Bz);
                let b = self.text.len();
                self.emit_val(0);
                self.expr(Token::OrOp as i64)?;
                let rhs_ast = self.ast_acc;
                self.text[b] = self.text.len() as i64;
                self.ty = Ty::Int as i64;
                if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                    self.ast_emit_short_circuit(
                        super::super::ast::ShortCircuitOp::Lan,
                        lhs,
                        rhs,
                        Ty::Int as i64,
                    );
                }
            } else if self.lex.tk == Token::OrOp {
                // C99 6.5.12: result of `|` is the common type
                // produced by the usual arithmetic conversions on
                // the operands. Forcing `int` here drops the upper
                // 32 bits when either operand is a 64-bit type and
                // a downstream operator narrows back to `int` --
                // e.g. `(u64 | u64) + 1` ends up emitting a
                // Shl 32 / Shr 32 pair on the result and zeroes
                // bits 32..63 for a positive value.
                let lhs_ty = t;
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::XorOp as i64)?;
                self.emit_op(Op::Or);
                self.ty = usual_arith_common_ty(lhs_ty, self.ty, self.target);
            } else if self.lex.tk == Token::XorOp {
                // C99 6.5.11: same common-type rule as `|`.
                let lhs_ty = t;
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AndOp as i64)?;
                self.emit_op(Op::Xor);
                self.ty = usual_arith_common_ty(lhs_ty, self.ty, self.target);
            } else if self.lex.tk == Token::AndOp {
                // C99 6.5.10: same common-type rule as `|`.
                let lhs_ty = t;
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::EqOp as i64)?;
                self.emit_op(Op::And);
                self.ty = usual_arith_common_ty(lhs_ty, self.ty, self.target);
            } else if self.lex.tk == Token::EqOp || self.lex.tk == Token::NeOp {
                // `==` and `!=` share emit shape -- only the FP
                // variant and the `invert` flag handed to
                // `emit_eq_with_common_width` differ.
                let invert = self.lex.tk == Token::NeOp;
                let (fp_op, name) = if invert {
                    (Op::Fne, "!=")
                } else {
                    (Op::Feq, "==")
                };
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::LtOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, name)?;
                    self.emit_op(fp_op);
                } else {
                    self.emit_eq_with_common_width(t, invert);
                }
                self.ty = Ty::Int as i64;
            } else if let Some(cmp) = Cmp::from_tok(self.lex.tk) {
                // All four relational ops share the same emit shape;
                // see `Cmp::ops` for the per-flavour op picks.
                let (signed_op, unsigned_op, fp_op, name) = cmp.ops();
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::ShlOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, name)?;
                    self.emit_op(fp_op);
                } else if is_unsigned_ty(usual_arith_common_ty(t, self.ty, self.target)) {
                    self.emit_op(unsigned_op);
                } else {
                    self.emit_op(signed_op);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ShlOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                self.emit_op(Op::Shl);
                // C99 6.5.7: `E1 << E2` has the type of `E1` after
                // integer promotion. `char` / `short` (signed or
                // unsigned, size 1 or 2) promote to signed `int`.
                // Wider operands keep their type. For an unsigned
                // size-4 LHS the result needs a mask back to 32 bits
                // because bits shifted past bit 31 survive in the
                // 64-bit accumulator.
                let lhs_size = self.size_of_type(t);
                if lhs_size <= 2 {
                    self.ty = Ty::Int as i64;
                } else {
                    if is_unsigned_ty(t) && lhs_size == 4 {
                        self.emit_binop_with_imm(Op::And, 0xffff_ffff);
                    }
                    self.ty = t;
                }
            } else if self.lex.tk == Token::ShrOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::AddOp as i64)?;
                // Pick logical (Shru) for unsigned LHS, arithmetic (Shr) otherwise.
                // The RHS is the shift count; only the LHS sign matters.

                if is_unsigned_ty(t) {
                    self.emit_op(Op::Shru);
                    // Preserve LHS unsigned-ness so chained shifts/compares stay unsigned.
                    self.ty = t;
                } else {
                    self.emit_op(Op::Shr);
                    self.ty = Ty::Int as i64;
                }
            } else if self.lex.tk == Token::AddOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "+")?;
                    self.emit_op(Op::Fadd);
                    self.ty = fp_result_ty(t, self.ty);
                } else if !is_pointer_ty(t) && is_pointer_ty(self.ty) {
                    // `int + ptr`: result is the pointer type.
                    // When the pointee size is > 1, the int has to
                    // be scaled by it (it's currently on the c5
                    // stack, so spill the rhs ptr to a temp, lift
                    // the int into `a`, scale, push, reload, add).
                    // For unscaled pointee (`char *`, `void *`)
                    // the byte add is already correct -- we just
                    // need to set the result type to ptr.
                    let rhs_ty = self.ty;
                    if self.is_ptr_scaling_nontrivial(rhs_ty) {
                        let scale = self.pointee_size(rhs_ty);
                        self.loc_offs += 1;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        let rhs_temp = -self.loc_offs;
                        self.emit_op(Op::StLocI);
                        self.emit_val(rhs_temp);
                        // Pop the int LHS off the c5 stack into
                        // `a` via `Imm 0; Or` (Or pops stack-top).
                        self.emit_imm(0);
                        self.emit_op(Op::Or);
                        self.emit_binop_with_imm(Op::Mul, scale);
                        self.emit_op(Op::Psh);
                        self.emit_lea(rhs_temp);
                        self.emit_op(Op::Li);
                    }
                    self.emit_op(Op::Add);
                    self.ty = rhs_ty;
                } else {
                    let rhs_ty = self.ty;
                    if self.is_ptr_scaling_nontrivial(t) {
                        let scale = self.pointee_size(t);
                        self.emit_binop_with_imm(Op::Mul, scale);
                    }
                    // Pre-compute the common type so the dual-
                    // emit binop tracker captures the result-
                    // shape `ty` rather than the rhs's pre-
                    // conversion tag.
                    if is_pointer_ty(t) {
                        self.ty = t;
                    } else {
                        self.ty = usual_arith_common_ty(t, rhs_ty, self.target);
                    }
                    self.emit_op(Op::Add);
                    if !is_pointer_ty(t) {
                        self.maybe_mask_to_unsigned_width(t, rhs_ty);
                    }
                }
            } else if self.lex.tk == Token::SubOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::MulOp as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "-")?;
                    self.emit_op(Op::Fsub);
                    self.ty = fp_result_ty(t, self.ty);
                } else if is_pointer_ty(t) && t == self.ty {
                    // ptr - ptr -> element count (Int). Divide by
                    // the pointee size to convert raw byte distance
                    // into element distance (skipped for `char*`,
                    // where byte and element counts coincide).
                    self.emit_op(Op::Sub);
                    if self.is_ptr_scaling_nontrivial(t) {
                        let scale = self.pointee_size(t);
                        self.emit_binop_with_imm(Op::Div, scale);
                    }
                    self.ty = Ty::Int as i64;
                } else if self.is_ptr_scaling_nontrivial(t) {
                    let scale = self.pointee_size(t);
                    self.emit_binop_with_imm(Op::Mul, scale);
                    self.emit_op(Op::Sub);
                    self.ty = t;
                } else {
                    let rhs_ty = self.ty;
                    // Pre-set the post-conversion result type so
                    // the dual-emit binop tracker captures the
                    // C99 6.3.1.8 common type.
                    if is_pointer_ty(t) {
                        self.ty = t;
                    } else {
                        self.ty = usual_arith_common_ty(t, rhs_ty, self.target);
                    }
                    self.emit_op(Op::Sub);
                    if !is_pointer_ty(t) {
                        self.maybe_mask_to_unsigned_width(t, rhs_ty);
                    }
                }
            } else if self.lex.tk == Token::MulOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "*")?;
                    self.emit_op(Op::Fmul);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    let rhs_ty = self.ty;
                    // Pre-compute the C99 6.3.1.8 common type so
                    // the dual-emit binop tracker (which reads
                    // `self.ty` for `Expr::Binary { ty }`) sees
                    // the post-conversion type, not the rhs's
                    // pre-conversion tag. Walker's post-op
                    // narrowing keys off `ty`.
                    self.ty = usual_arith_common_ty(t, rhs_ty, self.target);
                    self.emit_op(Op::Mul);
                    self.maybe_mask_to_unsigned_width(t, rhs_ty);
                }
            } else if self.lex.tk == Token::DivOp {
                self.next()?;
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "/")?;
                    self.emit_op(Op::Fdiv);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    // C99 6.3.1.8: when either operand is unsigned, the
                    // common type is unsigned, so the divide is unsigned
                    // too. Route to Op::Divu (UDIV / DIV instead of
                    // SDIV / IDIV). When the common type is narrower
                    // than the 8-byte register, mix-of-signed-and-
                    // unsigned operands need C99 conversion to the
                    // unsigned width applied first -- otherwise a
                    // sign-extended `-1` enters the udiv as
                    // 0xFFFFFFFFFFFFFFFF instead of 0xFFFFFFFF.
                    let common = usual_arith_common_ty(t, self.ty, self.target);
                    if is_unsigned_ty(common) {
                        // The masking sequence emits bytecode-only
                        // ops (`Op::StLocI`, `Op::Or`,
                        // `Op::And + mask`) that route through
                        // `ast_track_emit_op` and corrupt the AST
                        // vstack/accumulator. Snapshot the AST
                        // operands first, then run the bytecode
                        // dance, then rebuild the Binary AST node
                        // manually. The walker re-derives the
                        // masking from the operand type.
                        let lhs_ast = self.ast_vstack.pop().flatten();
                        let rhs_ast = self.ast_acc;
                        let ast_acc_save = self.ast_acc;
                        let vstack_depth = self.ast_vstack.len();
                        self.maybe_mask_operands_to_unsigned_common(t, self.ty);
                        self.emit_op(Op::Divu);
                        self.ast_vstack.truncate(vstack_depth);
                        self.ast_acc = ast_acc_save;
                        if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                            let pos = self.ast_src_pos();
                            let id = self.ast.push_expr(
                                super::super::ast::Expr::Binary {
                                    op: super::super::ir::BinOp::Divu,
                                    lhs,
                                    rhs,
                                    ty: common,
                                },
                                pos,
                            );
                            self.ast_acc = Some(id);
                        } else {
                            self.ast_acc = None;
                        }
                    } else {
                        self.emit_op(Op::Div);
                    }
                    self.ty = common;
                }
            } else if self.lex.tk == Token::ModOp {
                self.next()?;
                if is_floating_scalar(t) {
                    return Err(self.compile_err("`%` is not defined on floating-point operands"));
                }
                self.emit_op(Op::Psh);
                self.expr(Token::Inc as i64)?;
                if is_floating_scalar(self.ty) {
                    return Err(self.compile_err("`%` is not defined on floating-point operands"));
                }
                let common = usual_arith_common_ty(t, self.ty, self.target);
                if is_unsigned_ty(common) {
                    let lhs_ast = self.ast_vstack.pop().flatten();
                    let rhs_ast = self.ast_acc;
                    let ast_acc_save = self.ast_acc;
                    let vstack_depth = self.ast_vstack.len();
                    self.maybe_mask_operands_to_unsigned_common(t, self.ty);
                    self.emit_op(Op::Modu);
                    self.ast_vstack.truncate(vstack_depth);
                    self.ast_acc = ast_acc_save;
                    if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                        let pos = self.ast_src_pos();
                        let id = self.ast.push_expr(
                            super::super::ast::Expr::Binary {
                                op: super::super::ir::BinOp::Modu,
                                lhs,
                                rhs,
                                ty: common,
                            },
                            pos,
                        );
                        self.ast_acc = Some(id);
                    } else {
                        self.ast_acc = None;
                    }
                } else {
                    self.emit_op(Op::Mod);
                }
                self.ty = common;
            } else if self.lex.tk == Token::Inc || self.lex.tk == Token::Dec {
                let post_inc_lvalue = self.ast_acc;
                let reload = self
                    .rewrite_trailing_load_as_psh()
                    .ok_or_else(|| self.compile_err("bad lvalue in post-increment"))?;
                // Post ++/-- reads the prior value and stores a
                // new one. Same shape as the compound-assign
                // path: revert via `take_last_loaded_local`,
                // then force was_read true (reload re-emits the
                // load), was_written true, and refresh the
                // dead-store tracker.
                let line = self.lex.line;
                if let Some(idx) = self.take_last_loaded_local() {
                    self.symbols[idx].was_read = true;
                    self.symbols[idx].was_written = true;
                    self.record_local_read(idx);
                    self.record_local_store(idx, line);
                }
                self.emit_op(reload);
                if is_floating_scalar(self.ty) {
                    return Err(self.compile_err("floating-point ++/-- not yet implemented"));
                }
                self.emit_op(Op::Psh);
                self.emit_imm(self.pointee_step(self.ty));
                self.emit_op(if self.lex.tk == Token::Inc {
                    Op::Add
                } else {
                    Op::Sub
                });
                self.emit_op(store_op_for(self.ty, self.target));
                self.emit_op(Op::Psh);
                self.emit_imm(self.pointee_step(self.ty));
                self.emit_op(if self.lex.tk == Token::Inc {
                    Op::Sub
                } else {
                    Op::Add
                });
                // Dual-emit `Expr::PostInc { lvalue, by, ty }`.
                // The bytecode left the post-update bias in the
                // accumulator; the AST replaces that with the
                // canonical post-inc node so the walker emits
                // load -> binop_imm(Add, by) -> store -> return
                // the pre-update value per C99 6.5.2.4p3.
                let post_step = self.pointee_step(self.ty);
                let post_signed = if self.lex.tk == Token::Inc {
                    post_step
                } else {
                    -post_step
                };
                let post_ty = self.ty;
                if let Some(lvalue) = post_inc_lvalue {
                    self.ast_emit_post_inc(lvalue, post_signed, post_ty);
                }
                self.next()?;
            } else if self.lex.tk == Token::Brak {
                self.next()?;
                let array_ast = self.ast_acc;
                // Read-and-park the multi-dim stride queue. The
                // identifier / param / field-decay branches seed
                // strides for each of the N-1 multi-dim subscript
                // levels of an N-dim array. The inner expr() that
                // parses the index expression clears the pending
                // state at its exit, so save the head + tail
                // locally, hand the inner parse a clean slate, and
                // shift the queue back after it returns.
                let multi_dim_stride = self.pending.index_stride;
                let saved_tail = core::mem::take(&mut self.pending.index_strides_tail);
                self.pending.index_stride = 0;
                self.emit_op(Op::Psh);
                self.expr(Token::Assign as i64)?;
                let idx_ast = self.ast_acc;
                // Restore the queue and shift one level down so
                // the next `[i]` sees the stride for that level
                // in `pending_index_stride` and the rest in the
                // tail. While we still have strides queued, the
                // result type stays at pointer level so multi-dim
                // shape carries forward; the innermost subscript
                // (queue empty) falls through to the regular
                // sizeof + decay path.
                self.pending.index_strides_tail = saved_tail;
                self.pending.index_stride = if self.pending.index_strides_tail.is_empty() {
                    0
                } else {
                    self.pending.index_strides_tail.remove(0)
                };
                if self.lex.tk == ']' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("close bracket expected"));
                }
                if !is_pointer_ty(t) {
                    return Err(self.compile_err("pointer type expected"));
                }
                if multi_dim_stride > 0 {
                    self.emit_binop_with_imm(Op::Mul, multi_dim_stride);
                    self.emit_op(Op::Add);
                    // Multi-dim row pointer -- ty stays at the same
                    // pointer level; the innermost `[k]` decays it
                    // the regular way to a scalar element.
                    self.ty = t;
                    // The subscript just produced one row of the
                    // remaining shape -- exactly `multi_dim_stride`
                    // bytes wide (the stride was computed as
                    // `elem_size * product(remaining_dims)`).
                    // Surface that byte count so an enclosing
                    // `sizeof` recovers the full row size instead
                    // of the decayed-pointer `sizeof(T*) = 8`. The
                    // size flows in raw bytes because the row may
                    // itself be multi-dim, which c5's type encoding
                    // can't represent as `count * sizeof(elem_ty)`.
                    // The next postfix iteration clears this flag
                    // at its top so it doesn't leak past the
                    // subscript.
                    self.pending.last_array_decay_bytes = multi_dim_stride;
                } else {
                    if self.is_ptr_scaling_nontrivial(t) {
                        let scale = self.pointee_size(t);
                        self.emit_binop_with_imm(Op::Mul, scale);
                    }
                    // Re-snapshot `idx_ast` after the scale `Mul`.
                    // `emit_binop_with_imm` ran through
                    // `ast_track_emit_op`, which wrapped the
                    // earlier `idx_ast` into a fresh
                    // `Binary { Mul, idx, IntLit(scale) }` whose
                    // id is now on `ast_acc`. Using the post-scale
                    // expression here means the walker can emit a
                    // single `b.binop(Add, array, idx)` (the idx
                    // already carries the C99 6.5.6 stride
                    // multiplication) without re-deriving the
                    // pointee size from `ty`.
                    let idx_ast_scaled = if self.is_ptr_scaling_nontrivial(t) {
                        self.ast_acc.or(idx_ast)
                    } else {
                        idx_ast
                    };
                    self.emit_op(Op::Add);
                    self.ty = t - Ty::Ptr as i64;
                    // `xs[i]` where `xs` is a `struct Foo *` yields a
                    // struct value -- the address-as-value rule. Skip
                    // the load so the `.field` operator can apply the
                    // field offset to the just-computed element
                    // address. Scalar / pointer / nested-pointer
                    // element types still take the regular load.
                    let elem_is_struct_value =
                        is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                    if !elem_is_struct_value {
                        self.emit_op(load_op_for(self.ty, self.target));
                    }
                    // Dual-emit a canonical `Expr::Index { array,
                    // idx, ty }`. The bytecode tier ran the scale
                    // + Add + load sequence; the AST collapses to
                    // one node so the walker emits a single
                    // address+load through `Expr::Index`.
                    if let (Some(array), Some(idx)) = (array_ast, idx_ast_scaled) {
                        let idx_ty = self.ty;
                        self.ast_emit_index(array, idx, idx_ty);
                    }
                }
            } else if self.lex.tk == Token::Arrow || self.lex.tk == Token::Dot {
                // p->field / s.field. Both shapes resolve a struct
                // field offset and load the field. The difference is
                // upstream: `->` runs on a struct pointer (which the
                // preceding subexpression loaded into `a` via Op::Li),
                // while `.` runs on a struct value, where the parser
                // suppressed the load and `a` already holds the
                // struct's address.
                let obj_ast = self.ast_acc;
                let is_dot = self.lex.tk == Token::Dot;
                let valid = if is_dot {
                    is_struct_ty(t) && struct_ptr_depth(t) == 0
                } else {
                    is_struct_ty(t) && struct_ptr_depth(t) == 1
                };
                if !valid {
                    let want = if is_dot {
                        "struct value"
                    } else {
                        "single-level struct pointer"
                    };
                    let op = if is_dot { "." } else { "->" };
                    return Err(self.compile_err(format!("{op} requires a {want}")));
                }
                self.next()?;
                if self.lex.tk != Token::Id {
                    let op = if is_dot { "." } else { "->" };
                    return Err(self.compile_err(format!("field name expected after {op}")));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;

                let sid = struct_id_of(t);
                let field = self.structs[sid]
                    .fields
                    .iter()
                    .find(|f| f.name == field_name)
                    .ok_or_else(|| {
                        self.compile_err(format!(
                            "struct {} has no field {}",
                            self.structs[sid].name, field_name
                        ))
                    })?
                    .clone();

                if field.offset > 0 {
                    self.emit_binop_with_imm(Op::Add, field.offset as i64);
                }
                self.ty = field.ty;

                if field.bit_width > 0 {
                    // Bitfield. Two shapes:
                    //   `s.f = expr`  -- emit a load-clear-or-store
                    //                    sequence that preserves the
                    //                    other bits in the storage
                    //                    unit.
                    //   anything else -- emit a `Li; Shr; And`
                    //                    extraction that lands the
                    //                    bitfield's value in `a` for
                    //                    the surrounding expression.
                    self.emit_bitfield_access(
                        field.bit_offset,
                        field.bit_width,
                        field.bit_unit_size,
                        field.ty,
                    )?;
                } else {
                    // Trailing Lc/Li loads the field. The assignment handler
                    // (in the same loop) converts a trailing Li/Lc to Psh, so
                    // `p->x = value` and `s.x = value` work the same way as
                    // `*ptr = value`. Struct-typed fields get no load -- the
                    // address propagates so `s.inner.field` chains. Array
                    // fields decay to a pointer-to-element with the same
                    // address-as-value rule as a local array.
                    let field_is_struct_value =
                        is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                    if field.array_size > 0 {
                        self.ty += Ty::Ptr as i64;
                        // Stash the array's element count so an
                        // enclosing sizeof can recover the real
                        // size; otherwise `sizeof(s.field)` for a
                        // `T field[N]` returns 8 (decayed pointer)
                        // instead of `N * sizeof(T)`.
                        self.pending.last_array_decay_size = field.array_size;
                        // N-dim-array decay: mirror the Id-path so
                        // `s.xs[i][j][k]` scales each level by its
                        // row stride and only the innermost
                        // subscript decays to a scalar.
                        let dims = field.array_dims.clone();
                        let elem_size = self.size_of_type(field.ty) as i64;
                        self.seed_multi_dim_strides(&dims, elem_size);
                    } else if !field_is_struct_value {
                        self.emit_op(load_op_for(self.ty, self.target));
                        // Function-pointer field: re-seed the fn-ptr
                        // chain depth from the field's lineage tag so
                        // a following unary `*` recognises the C99
                        // 6.3.2.1p4 function-to-pointer decay no-op.
                        // Without this re-seed `(*g->frealloc)(...)`
                        // emits a spurious `Li` that loads through
                        // the function's code address and the call
                        // jumps to garbage. Mirrors the symbol-load
                        // path in the Id branch above.
                        if field.fn_ptr_indirection > 0 {
                            self.pending.fn_ptr_chain_depth = field.fn_ptr_indirection - 1;
                        }
                        // Pointer-to-array field (`T (*field)[M1]...[Mn]`):
                        // declarator stashed dims as `[0, M1, ...]`
                        // with a leading-0 sentinel, and bumped
                        // `field.ty` by one Ptr for the `*` plus
                        // one per trailing `[Mi]`. The Mi Ptrs are
                        // a positional record of the array shape,
                        // not real indirections -- collapse them
                        // here so the surviving Ptr is the single
                        // "decayed array pointer to scalar element"
                        // level. Without this, each subscript past
                        // the seeded multi-dim queue routes through
                        // `pointee_size` on a multi-level pointer
                        // and falls into the default-8 branch,
                        // mis-striding (and mis-sizing) by `8/elem`.
                        if field.array_dims.len() >= 2
                            && field.array_dims[0] == 0
                            && is_pointer_ty(self.ty)
                        {
                            let dims = field.array_dims.clone();
                            let array_ptrs = (dims.len() as i64) - 1;
                            let scalar_ty = field.ty - (dims.len() as i64) * (Ty::Ptr as i64);
                            self.ty -= array_ptrs * (Ty::Ptr as i64);
                            let elem_size = self.size_of_type(scalar_ty) as i64;
                            self.seed_multi_dim_strides(&dims, elem_size);
                        }
                    }
                }
                // Dual-emit `Expr::Member` collapsing the address +
                // load (or just the address for struct-value /
                // bitfield) into one node. `bitfield: None` for
                // regular fields; bitfields use the existing
                // `emit_bitfield_access` shape and skip Member
                // synthesis (TODO once the bitfield shape lands).
                if field.bit_width == 0
                    && let Some(obj) = obj_ast
                {
                    let mty = self.ty;
                    self.ast_emit_member(
                        obj,
                        field.offset as i64,
                        None,
                        mty,
                        field.array_size,
                    );
                }
            } else {
                return Err(self.compile_err(format!(
                    "compiler error: unexpected {}",
                    super::super::token::describe(self.lex.tk)
                )));
            }
        }
        // Multi-dim stride queue: set by the id-load / param /
        // field-decay branches when an N-dim array decays,
        // consumed by the Brak postfix. If we leave this expr()
        // without seeing every `[i]` -- e.g., the array was
        // passed to a function as a bare argument with `foo(arr)`
        // -- the queue must not leak to the next expression.
        // Otherwise the next array access in a fresh expression
        // would inherit a stale row stride and skip its scalar
        // load, leaving no lvalue for a following `=`.
        //
        // Snapshot what was still in the queue here so an outer
        // unary `*` -- which runs a recursive `expr()` to parse
        // its operand -- can tell whether that operand was a
        // pointer-to-array decay whose strides nothing consumed.
        // The snapshot is one operator deep: the next `expr()`
        // exit overwrites it.
        self.pending.end_of_expr_stride = self.pending.index_stride;
        self.pending.end_of_expr_strides_tail =
            core::mem::take(&mut self.pending.index_strides_tail);
        self.pending.index_stride = 0;
        Ok(())
    }

    /// Seed the multi-dim subscript stride queue for an N-dim
    /// array with element size `elem_size`. The first N-1
    /// dimensions each get a stride; the innermost subscript
    /// falls through to the regular `sizeof(elem)` path. For
    /// `T[A][B][C]` the strides are `[B*C*s, C*s]`. The head
    /// goes into `pending_index_stride`; the rest queue in
    /// `pending_index_strides_tail`. Empty `dims` or a 1D shape
    /// produces no stride hint at all.
    pub(super) fn seed_multi_dim_strides(&mut self, dims: &[i64], elem_size: i64) {
        self.pending.index_stride = 0;
        self.pending.index_strides_tail.clear();
        if dims.len() < 2 || elem_size <= 0 {
            return;
        }
        // strides[k] = elem_size * product(dims[k+1..]) for k in 0..N-1.
        let n = dims.len();
        let mut strides: Vec<i64> = Vec::with_capacity(n - 1);
        let mut running: i64 = elem_size;
        // Build right-to-left: stride[N-2] = elem*dims[N-1],
        // stride[N-3] = stride[N-2]*dims[N-2], etc.
        for k in (0..n - 1).rev() {
            running = running.saturating_mul(dims[k + 1]);
            strides.push(running);
        }
        strides.reverse();
        if let Some((&head, tail)) = strides.split_first() {
            self.pending.index_stride = head;
            self.pending.index_strides_tail.extend_from_slice(tail);
        }
    }
}
