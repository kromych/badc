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
use super::super::ir::LoadKind;
use super::super::token::{Token, Ty};
use super::CODE_BASE;
use super::Compiler;
use super::types::{
    UNSIGNED_BIT, format_type, fp_result_ty, integer_promote, is_bool_ty, is_char_band_ptr_ty,
    is_float_ty, is_floating_scalar, is_pointer_ty, is_struct_ty, is_unsigned_ty, is_vector_ty,
    is_void_ptr_ty, struct_id_of, struct_ptr_depth,
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

    /// Return the (signed, unsigned, FP, name) tuple of `BinOp`
    /// tags + diagnostic spelling for this comparison.
    fn ops(
        self,
    ) -> (
        super::super::ir::BinOp,
        super::super::ir::BinOp,
        super::super::ir::BinOp,
        &'static str,
    ) {
        use super::super::ir::BinOp as B;
        match self {
            Cmp::Lt => (B::Lt, B::Ult, B::Flt, "<"),
            Cmp::Gt => (B::Gt, B::Ugt, B::Fgt, ">"),
            Cmp::Le => (B::Le, B::Ule, B::Fle, "<="),
            Cmp::Ge => (B::Ge, B::Uge, B::Fge, ">="),
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
    pub(super) fn literal_auto_promoted_type(&self, ival: i64) -> i64 {
        let suffix_long = self.lex.int_suffix_long;
        let mut is_unsigned = self.lex.int_suffix_unsigned;
        // C99 6.4.4.1: a hexadecimal, octal, or binary constant may take
        // an unsigned type at a rank when no signed type at that rank
        // fits; a decimal constant with no `u` suffix never does.
        let allow_unsigned_fallback = !self.lex.int_is_decimal;
        let sizes = [
            self.size_of_type(Ty::Int as i64),
            self.size_of_type(Ty::Long as i64),
            self.size_of_type(Ty::LongLong as i64),
        ];
        // An integer constant is non-negative (a leading `-` is a
        // separate unary operator), so the magnitude is the unsigned
        // interpretation of the lexer's 64-bit value. Treating it as
        // signed would read a constant past `LLONG_MAX` (bit 63 set,
        // e.g. `18446744073709551615`) as a small negative magnitude.
        let mag = (ival as u64) as u128;
        let fits = |size_bytes: usize, signed: bool| -> bool {
            let bits = (size_bytes as u32) * 8;
            if signed {
                if bits >= 128 {
                    true
                } else {
                    // Signed max is 2^(bits-1) - 1; 2^31 / 2^63 exactly
                    // must move to the next rank (or unsigned type).
                    mag < (1u128 << (bits - 1))
                }
            } else if bits >= 128 {
                true
            } else if bits == 0 {
                false
            } else {
                mag <= ((1u128 << bits) - 1u128)
            }
        };
        // Walk the rank list (int, long, long long) starting at the
        // floor the `l`/`ll` suffix names. At each rank try the signed
        // type, then the unsigned type when a `u` suffix or the
        // non-decimal base allows it, before widening.
        let mut rank: usize = (suffix_long as usize).min(2);
        loop {
            let size = sizes[rank];
            if !is_unsigned && fits(size, true) {
                break;
            }
            if (is_unsigned || allow_unsigned_fallback) && fits(size, false) {
                is_unsigned = true;
                break;
            }
            if rank >= 2 {
                // C99 6.4.4.1p5 lists only signed types for a decimal
                // constant, but a value that exceeds the widest signed
                // type cannot be represented there. gcc and clang type
                // such a constant as the unsigned type at the same rank;
                // follow that when the unsigned type fits.
                is_unsigned = is_unsigned || allow_unsigned_fallback || fits(sizes[rank], false);
                break;
            }
            rank += 1;
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

    /// Parse a C11 7.17 atomic builtin call. The opening `(` has
    /// already been consumed. The first operand is the atomic-object
    /// pointer; its pointee type sets the operand width. The result
    /// type follows C11 7.17.7: the pointee value for the load /
    /// exchange / fetch forms, `int` for compare-exchange (the
    /// predicate) and for store (used in statement position).
    fn parse_atomic_builtin(
        &mut self,
        kind: super::super::ast::AtomicKind,
        id_idx: usize,
    ) -> Result<(), C5Error> {
        use super::super::ast::{AtomicKind, Expr};
        let fn_name = self.symbols[id_idx].name.clone();
        let want = atomic_arity(kind);
        let mut args: Vec<super::super::ast::ExprId> = Vec::new();
        // First operand: the atomic-object pointer.
        self.expr(Token::Assign as i64)?;
        let ptr_ty = self.ty;
        if let Some(a) = self.ast_acc {
            args.push(a);
        }
        if !is_pointer_ty(ptr_ty) {
            return Err(self.compile_err(format!(
                "`{fn_name}` first argument must be a pointer to the atomic object"
            )));
        }
        let elem_ty = ptr_ty - Ty::Ptr as i64;
        while args.len() < want {
            if self.lex.tk != ',' {
                return Err(self.compile_err(format!("`{fn_name}` takes {want} arguments")));
            }
            self.next()?;
            self.expr(Token::Assign as i64)?;
            if let Some(a) = self.ast_acc {
                args.push(a);
            }
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err(format!("`{fn_name}` takes {want} arguments")));
        }
        self.next()?;
        self.mark_emit_other();
        let result_ty = match kind {
            AtomicKind::Store | AtomicKind::CompareExchangeStrong => Ty::Int as i64,
            _ => elem_ty,
        };
        self.ty = result_ty;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::Atomic {
                kind,
                args,
                elem_ty,
                ty: result_ty,
            },
            pos,
        );
        self.ast_acc = Some(id);
        Ok(())
    }

    /// Fetch a required GCC-builtin operand or report an arity error.
    fn require_gcc_arg(
        &self,
        a: Option<super::super::ast::ExprId>,
        name: &str,
    ) -> Result<super::super::ast::ExprId, C5Error> {
        a.ok_or_else(|| self.compile_err(format!("`{name}` -- too few arguments")))
    }

    /// Parse a GCC `__atomic_*` / `__sync_*` builtin call (the opening
    /// `(` already consumed) and lower it onto the C11 7.17 atomic
    /// infrastructure. The `__atomic_*` forms carry trailing
    /// `memory_order` arguments and the compare-exchange forms a `weak`
    /// flag; badc parses and discards them (it always emits seq_cst).
    /// The `__sync_*` forms are seq_cst with no order argument.
    /// Parse a GCC checked-arithmetic builtin
    /// `__builtin_{add,sub,mul}_overflow(a, b, dst)`. The third operand
    /// is the result pointer; its pointee type drives the operation
    /// width and signedness. Builds an `Expr::CheckedArith` node whose
    /// value is the `int` overflow flag.
    fn parse_overflow_builtin(&mut self, name: &str) -> Result<(), C5Error> {
        use super::super::ast::{Expr, ExprId};
        let op = match name {
            "__builtin_add_overflow" => 0i64,
            "__builtin_sub_overflow" => 1,
            _ => 2,
        };
        let mut args: Vec<ExprId> = Vec::new();
        let mut dst_ty = 0i64;
        if self.lex.tk != ')' {
            loop {
                self.expr(Token::Assign as i64)?;
                if let Some(a) = self.ast_acc {
                    args.push(a);
                }
                dst_ty = self.ty;
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }
        }
        if self.lex.tk != ')' || args.len() != 3 {
            return Err(self.compile_err(format!("`{name}` expects (a, b, result pointer)")));
        }
        self.next()?; // consume ')'
        if !is_pointer_ty(dst_ty) {
            return Err(
                self.compile_err(format!("`{name}` third argument must be a result pointer"))
            );
        }
        let elem_ty = dst_ty - Ty::Ptr as i64;
        self.mark_emit_other();
        let ty = Ty::Int as i64;
        let pos = self.ast_src_pos();
        let id = self.ast.push_expr(
            Expr::CheckedArith {
                op,
                a: args[0],
                b: args[1],
                dst: args[2],
                elem_ty,
                ty,
            },
            pos,
        );
        self.ty = ty;
        self.ast_acc = Some(id);
        Ok(())
    }

    fn parse_gcc_atomic_builtin(&mut self, name: &str, id_idx: usize) -> Result<(), C5Error> {
        use super::super::ast::{AtomicKind, Expr, ExprId};
        let _ = id_idx;
        // Parse the full argument list; the first operand's type sets the
        // access width for the pointer-based forms.
        let mut args: Vec<ExprId> = Vec::new();
        let mut first_ty = 0i64;
        if self.lex.tk != ')' {
            loop {
                self.expr(Token::Assign as i64)?;
                if args.is_empty() {
                    first_ty = self.ty;
                }
                if let Some(a) = self.ast_acc {
                    args.push(a);
                }
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err(format!("`{name}` -- malformed argument list")));
        }
        self.next()?;
        self.mark_emit_other();
        let int_ty = Ty::Int as i64;

        // Fences (C11 7.17.4): a full barrier with no pointer operand.
        // `__atomic_signal_fence` is a compiler-only barrier; a real
        // fence is a safe superset.
        if matches!(
            name,
            "__sync_synchronize" | "__atomic_thread_fence" | "__atomic_signal_fence"
        ) {
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(
                Expr::Intrinsic {
                    kind: crate::c5::op::Intrinsic::AtomicThreadFence as i64,
                    args: Vec::new(),
                    ty: int_ty,
                },
                pos,
            );
            self.ty = int_ty;
            self.ast_acc = Some(id);
            return Ok(());
        }

        // `__atomic_is_lock_free(size, ptr)` -- a compile-time predicate;
        // the supported targets provide lock-free atomics for the sizes
        // used here.
        if name == "__atomic_is_lock_free" {
            let pos = self.ast_src_pos();
            let id = self.ast.push_expr(Expr::IntLit { val: 1, ty: int_ty }, pos);
            self.ty = int_ty;
            self.ast_acc = Some(id);
            return Ok(());
        }

        // Every remaining form takes the atomic-object pointer first; its
        // pointee type drives the load / store / RMW width.
        if args.is_empty() || !is_pointer_ty(first_ty) {
            return Err(self.compile_err(format!(
                "`{name}` first argument must be a pointer to the atomic object"
            )));
        }
        let elem_ty = first_ty - Ty::Ptr as i64;
        let ptr = args[0];
        let val1 = args.get(1).copied();
        let val2 = args.get(2).copied();
        let pos = self.ast_src_pos();

        let (kind, op_args, result_ty): (AtomicKind, Vec<ExprId>, i64) = match name {
            "__atomic_load_n" => (AtomicKind::Load, alloc::vec![ptr], elem_ty),
            "__atomic_store_n" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::Store, alloc::vec![ptr, v], int_ty)
            }
            // Generic forms: the value moves through a pointer rather than
            // by value, so they work for any-size objects.
            "__atomic_load" => {
                let ret = self.require_gcc_arg(val1, name)?;
                (AtomicKind::LoadInto, alloc::vec![ptr, ret], int_ty)
            }
            "__atomic_store" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::StoreFrom, alloc::vec![ptr, v], int_ty)
            }
            "__atomic_exchange_n" | "__sync_lock_test_and_set" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::Exchange, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_add" | "__sync_fetch_and_add" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchAdd, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_sub" | "__sync_fetch_and_sub" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchSub, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_and" | "__sync_fetch_and_and" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchAnd, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_or" | "__sync_fetch_and_or" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchOr, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_fetch_xor" | "__sync_fetch_and_xor" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::FetchXor, alloc::vec![ptr, v], elem_ty)
            }
            // The C11 `__atomic_*_fetch` forms return the new (post-op)
            // value and take a memory-order argument; the `__sync_*_and_fetch`
            // forms are the older two-argument spelling. Both map to the same
            // read-modify-write returning the updated value.
            "__atomic_add_fetch" | "__sync_add_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::AddFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_sub_fetch" | "__sync_sub_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::SubFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_and_fetch" | "__sync_and_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::AndFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_or_fetch" | "__sync_or_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::OrFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_xor_fetch" | "__sync_xor_and_fetch" => {
                let v = self.require_gcc_arg(val1, name)?;
                (AtomicKind::XorFetch, alloc::vec![ptr, v], elem_ty)
            }
            "__atomic_compare_exchange_n" => {
                let exp = self.require_gcc_arg(val1, name)?;
                let des = self.require_gcc_arg(val2, name)?;
                (
                    AtomicKind::CompareExchangeStrong,
                    alloc::vec![ptr, exp, des],
                    int_ty,
                )
            }
            "__sync_val_compare_and_swap" => {
                let old = self.require_gcc_arg(val1, name)?;
                let new = self.require_gcc_arg(val2, name)?;
                (AtomicKind::SyncCasVal, alloc::vec![ptr, old, new], elem_ty)
            }
            "__sync_bool_compare_and_swap" => {
                let old = self.require_gcc_arg(val1, name)?;
                let new = self.require_gcc_arg(val2, name)?;
                (AtomicKind::SyncCasBool, alloc::vec![ptr, old, new], int_ty)
            }
            // `__atomic_test_and_set(ptr, mo)` -- set the byte to 1 and
            // yield the prior contents (callers test for non-zero).
            "__atomic_test_and_set" => {
                let one = self.ast.push_expr(Expr::IntLit { val: 1, ty: int_ty }, pos);
                (AtomicKind::Exchange, alloc::vec![ptr, one], elem_ty)
            }
            // `__atomic_clear(ptr, mo)` / `__sync_lock_release(ptr)` --
            // store 0 to the object.
            "__atomic_clear" | "__sync_lock_release" => {
                let zero = self.ast.push_expr(Expr::IntLit { val: 0, ty: int_ty }, pos);
                (AtomicKind::Store, alloc::vec![ptr, zero], int_ty)
            }
            _ => {
                return Err(self.compile_err(format!("`{name}` -- unsupported atomic builtin")));
            }
        };

        self.ty = result_ty;
        let id = self.ast.push_expr(
            Expr::Atomic {
                kind,
                args: op_args,
                elem_ty,
                ty: result_ty,
            },
            pos,
        );
        self.ast_acc = Some(id);
        Ok(())
    }

    /// C99 6.5.5-6.5.14: the arithmetic, bitwise, shift, relational,
    /// equality, and logical operators require scalar operands. Reject a
    /// struct / union *value* operand (a pointer to one is a scalar and
    /// is fine) so `struct + struct` surfaces an error instead of
    /// silently operating on the operand's address. Called by each
    /// value-computing binary branch after both operand types are known.
    fn reject_aggregate_binop(&self, lhs_ty: i64, rhs_ty: i64, op: &str) -> Result<(), C5Error> {
        // GCC vector extension: a bitwise operator on two same-width vector
        // values is element-wise (no inter-lane carry, so the walker lowers it
        // as wide chunks). Mixed vector/scalar, mismatched widths, and the
        // arithmetic / shift / relational operators still reject here.
        if matches!(op, "^" | "&" | "|")
            && is_vector_ty(&self.structs, lhs_ty)
            && is_vector_ty(&self.structs, rhs_ty)
            && self.structs[struct_id_of(lhs_ty)].size == self.structs[struct_id_of(rhs_ty)].size
        {
            return Ok(());
        }
        // The GCC 128-bit integer shares the aggregate layout machinery
        // but is an integer type: the walker expands each operator over
        // its two 64-bit halves.
        if self.is_int128_ty(lhs_ty) || self.is_int128_ty(rhs_ty) {
            return Ok(());
        }
        let is_aggregate_value = |ty: i64| is_struct_ty(ty) && struct_ptr_depth(ty) == 0;
        if is_aggregate_value(lhs_ty) || is_aggregate_value(rhs_ty) {
            return Err(self.compile_err(format!("invalid operands to binary `{op}`")));
        }
        Ok(())
    }

    /// Opcode for `E1 op= E2` given the operand types. C99 6.5.16.2p3:
    /// the operation is `E1 op E2`, so divide / modulo signedness
    /// follows the 6.3.1.8 common type of both operands, not the lvalue
    /// alone (`int x; x /= 2u` divides unsigned). Pointer operands keep
    /// the lvalue's signedness (no arithmetic common type). The shift
    /// operators take the lvalue's signedness alone (6.5.7 promotes the
    /// operands separately).
    fn compound_assign_binop(
        &self,
        binop: i64,
        lhs_ty: i64,
        rhs_ty: i64,
        op_is_fp: bool,
    ) -> Result<super::super::ir::BinOp, C5Error> {
        let div_unsigned = if op_is_fp || is_pointer_ty(lhs_ty) || is_pointer_ty(rhs_ty) {
            is_unsigned_ty(lhs_ty)
        } else {
            is_unsigned_ty(self.arith_common_ty(lhs_ty, rhs_ty))
        };
        use super::super::ir::BinOp as B;
        Ok(match binop {
            x if x == Token::AddOp as i64 => {
                if op_is_fp {
                    B::Fadd
                } else {
                    B::Add
                }
            }
            x if x == Token::SubOp as i64 => {
                if op_is_fp {
                    B::Fsub
                } else {
                    B::Sub
                }
            }
            x if x == Token::MulOp as i64 => {
                if op_is_fp {
                    B::Fmul
                } else {
                    B::Mul
                }
            }
            x if x == Token::DivOp as i64 => {
                if op_is_fp {
                    B::Fdiv
                } else if div_unsigned {
                    B::Divu
                } else {
                    B::Div
                }
            }
            x if x == Token::ModOp as i64 => {
                if div_unsigned {
                    B::Modu
                } else {
                    B::Mod
                }
            }
            x if x == Token::AndOp as i64 => B::And,
            x if x == Token::OrOp as i64 => B::Or,
            x if x == Token::XorOp as i64 => B::Xor,
            x if x == Token::ShlOp as i64 => B::Shl,
            x if x == Token::ShrOp as i64 => {
                if is_unsigned_ty(lhs_ty) {
                    B::Shru
                } else {
                    B::Shr
                }
            }
            _ => return Err(self.compile_err("unknown compound-assign opcode")),
        })
    }

    /// The lvalue and type for a `++` / `--` operand that cannot use the
    /// generic trailing-load rewrite and must build `Expr::PreInc` /
    /// `Expr::PostInc` directly: a bitfield member (its load is a
    /// shift-and-mask sequence, not one scalar load) and the GCC 128-bit
    /// integer (its lvalue's value is its address, so there is no
    /// trailing load at all).
    fn direct_inc_lvalue(&self) -> Option<(super::super::ast::ExprId, i64)> {
        let lv = self.ast_acc?;
        if let super::super::ast::Expr::Member {
            bitfield: Some(_),
            ty,
            ..
        } = self.ast.expr(lv)
        {
            return Some((lv, *ty));
        }
        if self.is_int128_ty(self.ty) {
            return Some((lv, self.ty));
        }
        None
    }

    pub(super) fn expr(&mut self, lev: i64) -> Result<(), C5Error> {
        self.with_nesting("expression", |c| c.expr_inner(lev))
    }

    fn expr_inner(&mut self, lev: i64) -> Result<(), C5Error> {
        let mut t: i64;

        if self.lex.tk == 0 {
            return Err(self.compile_err("unexpected eof in expression"));
        } else if self.lex.tk == Token::Num {
            let val = self.lex.ival;
            self.emit_imm(val);
            // C99 6.4.4.4p11: a wide character constant (`L'x'`) has type
            // `wchar_t`, sized by the target -- `unsigned short` (2 bytes)
            // on Windows, `int` (4 bytes) on the Unix targets, matching the
            // `<stddef.h>` typedef. A plain integer or narrow character
            // constant takes the usual value-driven promotion.
            self.ty = if self.lex.char_is_wide {
                if self.lex.wchar_bytes == 2 {
                    Ty::Short as i64 | super::types::UNSIGNED_BIT
                } else {
                    Ty::Int as i64
                }
            } else {
                self.literal_auto_promoted_type(val)
            };
            self.ast_emit_int_lit(val, self.ty);
            self.next()?;
        } else if self.lex.tk == Token::FloatNum {
            // C99 6.4.4.2p4: an unsuffixed floating constant has
            // type double, `f`/`F` float, `l`/`L` long double
            // (represented as f64 in c5). The lexer stored the
            // value -- already rounded to single precision for
            // `f`/`F` -- as `f64::to_bits()` cast to i64 in `ival`.
            let bits = self.lex.ival as u64;
            self.emit_imm(self.lex.ival);
            self.ty = if self.lex.float_suffix_f32 {
                Ty::Float as i64
            } else {
                Ty::Double as i64
            };
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
            // A wide literal carries its own `wchar_t`-width terminator
            // from the lexer (which also absorbs adjacent `L"..."`
            // parts); a narrow literal does not, so the single trailing
            // NUL is added here. Capture the kind before `next()`
            // re-lexes the following token.
            let is_wide = self.lex.str_is_wide;
            self.emit_data_imm(start_offset);
            self.next()?;
            // C concatenates adjacent string literals -- `"a" "b"` is one
            // string. The lexer leaves the narrow NUL off so the bytes
            // flow straight together; the trailing NUL is added below.
            while self.lex.tk == '"' {
                self.next()?;
            }
            if !is_wide {
                self.data.push(0);
            }
            // Record the resolved object start (after adjacent-literal
            // concatenation and the trailing NUL) for static DCE
            // boundaries. Interior part starts are not recorded.
            self.data_object_starts.push(start_offset);
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
            // C99 6.5.3.4p2: `sizeof` of a variable-length array is a
            // runtime value -- emit a load of the VLA's byte-count
            // slot. Every other operand folds to a compile-time
            // constant; seed the accumulator with the matching IntLit.
            if let Some(size_slot) = self.pending.sizeof_vla_size_slot.take() {
                self.ast_emit_vla_sizeof(size_slot);
            } else {
                self.ast_emit_int_lit(total_bytes, self.ty);
            }
        } else if self.lex.tk == Token::Alignof {
            // C11 6.5.3.4: `_Alignof ( type-name )`, a compile-time
            // constant. Emit the alignment as a runtime immediate and
            // pin the type at `int`, matching the `sizeof` site.
            self.next()?;
            let align = self.alignof_operand_bytes()?;
            self.emit_imm(align);
            self.ty = Ty::Int as i64;
            self.ast_emit_int_lit(align, self.ty);
        } else if self.lex.tk == Token::Generic {
            // C11 6.5.1.1 generic selection `_Generic(expr, T1: e1, ...)`.
            self.parse_generic_selection()?;
        } else if self.lex.tk == Token::BuiltinTypesCompatible {
            // GCC `__builtin_types_compatible_p(T1, T2)`: an integer
            // constant, emitted like the `sizeof` / `_Alignof` results.
            self.next()?;
            let v = self.parse_types_compatible_p()?;
            self.emit_imm(v);
            self.ty = Ty::Int as i64;
            self.ast_emit_int_lit(v, self.ty);
        } else if self.lex.tk == Token::BuiltinOffsetof {
            // GCC `__builtin_offsetof(T, member)`: the member's byte offset, a
            // `size_t`-typed integer. Constant unless the designator carries a
            // runtime array subscript (a GCC extension), which the parser then
            // emits onto the accumulator directly.
            self.next()?;
            match self.parse_builtin_offsetof(true)? {
                Some(v) => {
                    self.emit_imm(v);
                    self.ty = self.size_t_ty();
                    self.ast_emit_int_lit(v, self.ty);
                }
                None => {
                    // Runtime offset already emitted; the type is size_t.
                    self.ty = self.size_t_ty();
                }
            }
        } else if self.is_func_name_ident() {
            // C99 6.4.2.2: __func__ is implicitly declared as
            // `static const char __func__[] = "function-name";` at the
            // start of every function body; __FUNCTION__ /
            // __PRETTY_FUNCTION__ are the GCC aliases. The bytes live in
            // the data segment and the expression decays to a pointer.
            let offset = self.intern_func_name();
            self.emit_data_imm(offset);
            self.next()?;
            self.ty = Ty::Char as i64 + Ty::Ptr as i64;
            // `__func__` is a `char[]` of length strlen + 1 (C99
            // 6.4.2.2); surface that to an enclosing `sizeof` the same
            // way a decayed array does, so `sizeof(__func__)` is the
            // array size, not the decayed pointer's.
            self.pending.last_array_decay_size = self.current_function_name.len() as i64 + 1;
            // Dual-emit the decayed `char *` value so the walker
            // sees the address on `ast_acc` (identical shape to a
            // plain string literal -- the same `Expr::StrLit`
            // carrier).
            self.ast_emit_str_lit(offset, self.ty);
        } else if self.lex.tk == Token::Id {
            let id_idx = self.lex.curr_id_idx;
            self.next()?;
            if self.lex.tk == '(' {
                self.next()?;
                // C89 6.3.2.2 implicit declaration, restricted to the
                // names the driver listed: the link set defines them,
                // so the call binds `extern int name();` and resolves
                // against the user's definition rather than through a
                // header's library binding.
                if self.symbols[id_idx].class == 0
                    && !self.implicit_extern_fns.is_empty()
                    && self
                        .implicit_extern_fns
                        .iter()
                        .any(|n| n == &self.symbols[id_idx].name)
                {
                    self.symbols[id_idx].class = Token::Fun as i64;
                    self.symbols[id_idx].type_ = Ty::Int as i64;
                    self.symbols[id_idx].implicit_return_int = true;
                    self.symbols[id_idx].linkage = crate::c5::symbol::Linkage::External;
                    self.symbols[id_idx].defined_here = false;
                }
                // C11 7.17 atomic operations and the other compiler
                // builtins share the `#pragma intrinsic` registry
                // (`<stdatomic.h>` declares the atomics). An atomic op is
                // lowered at the call site to load / store /
                // read-modify-write, but only when the name is not bound
                // to a real function, in which case the call is left to
                // the normal path.
                let intrinsic_id = self.pp_intrinsics.get(&self.symbols[id_idx].name).copied();
                let not_real_fn = self.symbols[id_idx].class != Token::Fun as i64
                    && self.symbols[id_idx].class != Token::Sys as i64;
                let atomic_kind = if not_real_fn {
                    intrinsic_id.and_then(atomic_kind_from_intrinsic)
                } else {
                    None
                };
                // GCC `__atomic_*` / `__sync_*` builtins are compiler-
                // provided (no header) and lowered at the call site like
                // the C11 7.17 atomics. Recognize them by name prefix when
                // the name is not bound to a real function.
                let is_gcc_atomic = not_real_fn
                    && (self.symbols[id_idx].name.starts_with("__atomic_")
                        || self.symbols[id_idx].name.starts_with("__sync_"));
                // GCC checked-arithmetic builtins, lowered at the call
                // site to a wrapped store plus an overflow test.
                let is_overflow = not_real_fn
                    && matches!(
                        self.symbols[id_idx].name.as_str(),
                        "__builtin_add_overflow"
                            | "__builtin_sub_overflow"
                            | "__builtin_mul_overflow"
                    );
                // GCC `__builtin_object_size`, folded to a constant at
                // the call site (the pointer operand is unevaluated).
                let is_object_size =
                    not_real_fn && self.symbols[id_idx].name == "__builtin_object_size";
                // GCC `__builtin_choose_expr`: the chosen operand is the
                // expression, with its exact type.
                let is_choose_expr =
                    not_real_fn && self.symbols[id_idx].name == "__builtin_choose_expr";
                // GCC `__builtin_constant_p(x)`: an `int` (0 or 1), 1 when
                // the unevaluated operand folds to a constant expression.
                let is_constant_p =
                    not_real_fn && self.symbols[id_idx].name == "__builtin_constant_p";
                if is_choose_expr {
                    self.parse_choose_expr_builtin()?;
                } else if is_constant_p {
                    self.parse_constant_p_builtin()?;
                } else if is_object_size {
                    self.parse_object_size_builtin()?;
                } else if is_overflow {
                    let name = self.symbols[id_idx].name.clone();
                    self.parse_overflow_builtin(&name)?;
                } else if is_gcc_atomic {
                    let name = self.symbols[id_idx].name.clone();
                    self.parse_gcc_atomic_builtin(&name, id_idx)?;
                } else if let Some(akind) = atomic_kind {
                    self.parse_atomic_builtin(akind, id_idx)?;
                } else if let Some(intrinsic_id) = intrinsic_id {
                    let fn_name = self.symbols[id_idx].name.clone();
                    // `__builtin_trap()` is the only nullary intrinsic;
                    // every other one needs at least one argument.
                    if self.lex.tk == ')' && intrinsic_id != crate::c5::op::Intrinsic::Trap as i64 {
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
                    let fma_id = crate::c5::op::Intrinsic::Fma as i64;
                    let fmaf_id = crate::c5::op::Intrinsic::Fmaf as i64;
                    let trap_id = crate::c5::op::Intrinsic::Trap as i64;
                    let intr_kind = crate::c5::op::Intrinsic::from_i64(intrinsic_id);
                    let is_fp_unary = intr_kind.is_some_and(|i| i.is_fp_unary());
                    let is_int_bit_unary = intr_kind.is_some_and(|i| i.is_int_bit_unary());
                    let is_bit_unary_64 = intr_kind.is_some_and(|i| i.is_bit_unary_64());
                    let is_bswap = intr_kind.is_some_and(|i| i.is_bswap());
                    // Set for va_arg: the requested argument type. After
                    // the intrinsic node is built the result is wrapped
                    // in a load of this type (GCC value semantics).
                    let mut va_arg_result_ty: Option<i64> = None;
                    let mut ast_intrinsic_args: alloc::vec::Vec<super::super::ast::ExprId> =
                        alloc::vec::Vec::new();
                    if intrinsic_id == trap_id {
                        // __builtin_trap() -- no arguments.
                    } else if intrinsic_id == fma_id || intrinsic_id == fmaf_id {
                        // fma(x, y, z) / fmaf(x, y, z) -- C99 7.12.13.1.
                        // Three FP arguments, each cast to the result
                        // precision so the fused node sees uniform-width
                        // operands (6.3.1.4 / 6.3.1.5). The walker lowers
                        // the call to a single `Inst::Fma`.
                        let elem_ty = if intrinsic_id == fmaf_id {
                            Ty::Float as i64
                        } else {
                            Ty::Double as i64
                        };
                        let mut count = 0;
                        loop {
                            self.expr(Token::Assign as i64)?;
                            if let Some(child) = self.ast_acc {
                                let pos = self.ast_src_pos();
                                let cast_id = self.ast.push_expr(
                                    super::super::ast::Expr::Cast {
                                        child,
                                        to_ty: elem_ty,
                                    },
                                    pos,
                                );
                                ast_intrinsic_args.push(cast_id);
                            }
                            count += 1;
                            if self.lex.tk == ',' {
                                self.next()?;
                                continue;
                            }
                            break;
                        }
                        if count != 3 {
                            return Err(
                                self.compile_err(format!("intrinsic `{fn_name}` takes (x, y, z)"))
                            );
                        }
                    } else if is_fp_unary {
                        // sqrt / fabs / floor / ceil / trunc and their
                        // single-precision partners -- one FP argument cast
                        // to the result precision (6.3.1.4 / 6.3.1.5). The
                        // walker lowers the call to a single
                        // `Inst::Intrinsic` that emits the hardware
                        // instruction.
                        let elem_ty = if intr_kind.is_some_and(|i| i.is_single_precision()) {
                            Ty::Float as i64
                        } else {
                            Ty::Double as i64
                        };
                        self.expr(Token::Assign as i64)?;
                        if let Some(child) = self.ast_acc {
                            let pos = self.ast_src_pos();
                            let cast_id = self.ast.push_expr(
                                super::super::ast::Expr::Cast {
                                    child,
                                    to_ty: elem_ty,
                                },
                                pos,
                            );
                            ast_intrinsic_args.push(cast_id);
                        }
                    } else if is_int_bit_unary || is_bswap {
                        // __builtin_clz / ctz / popcount (+ ll forms) and
                        // __builtin_bswap16 / 32 / 64 -- one integer argument.
                        // Cast to the unsigned form of the operation width so
                        // the value reaches the walker zero-extended (clz /
                        // popcount count over the full width; bswap reverses
                        // exactly that many bytes).
                        let is_clrsb = intr_kind.is_some_and(|i| i.is_clrsb());
                        let elem_ty = if is_bswap {
                            let base = match intr_kind {
                                Some(crate::c5::op::Intrinsic::Bswap16) => Ty::Short as i64,
                                Some(crate::c5::op::Intrinsic::Bswap64) => Ty::LongLong as i64,
                                _ => Ty::Int as i64,
                            };
                            base | super::types::UNSIGNED_BIT
                        } else if is_clrsb {
                            // clrsb counts sign bits: the operand is signed,
                            // so sign-extend into the register.
                            if is_bit_unary_64 {
                                Ty::LongLong as i64
                            } else {
                                Ty::Int as i64
                            }
                        } else if is_bit_unary_64 {
                            Ty::LongLong as i64 | super::types::UNSIGNED_BIT
                        } else {
                            Ty::Int as i64 | super::types::UNSIGNED_BIT
                        };
                        self.expr(Token::Assign as i64)?;
                        if let Some(child) = self.ast_acc {
                            let pos = self.ast_src_pos();
                            let cast_id = self.ast.push_expr(
                                super::super::ast::Expr::Cast {
                                    child,
                                    to_ty: elem_ty,
                                },
                                pos,
                            );
                            ast_intrinsic_args.push(cast_id);
                        }
                    } else if intrinsic_id == va_arg_id {
                        // `__builtin_va_arg(ap, T)` -- ap names the
                        // va_list, T is the argument's type-name. The
                        // first operand is reduced to the storage
                        // address and pushed; the second is the packed
                        // descriptor `(kind << 16) | size` (kind 0 =
                        // integer / pointer, 1 = floating) the
                        // per-target codegen reads from the
                        // accumulator. The System V x86_64 ABI (3.5.7)
                        // routes the read to the gp or fp save area by
                        // `kind`; the cursor targets ignore the
                        // descriptor.
                        self.expr(Token::Assign as i64)?;
                        self.va_list_operand_address();
                        if let Some(a) = self.ast_acc {
                            ast_intrinsic_args.push(a);
                        }
                        if self.lex.tk != ',' {
                            return Err(
                                self.compile_err(format!("intrinsic `{fn_name}` takes (ap, type)"))
                            );
                        }
                        self.next()?;
                        if !self.lex_is_type_start() {
                            return Err(self.compile_err(format!(
                                "intrinsic `{fn_name}` second operand must be a type name"
                            )));
                        }
                        // Parse the type-name with optional pointer
                        // decoration (C99 6.7.6 abstract declarator), the
                        // same machinery `sizeof(<type>)` uses. A pointer
                        // type collapses to an 8-byte integer-class slot.
                        let mut arg_ty = self.parse_decl_base_type()?;
                        let _ = core::mem::take(&mut self.pending.typedef_base_array_size);
                        let mut is_pointer = false;
                        while self.lex.tk == Token::MulOp {
                            self.next()?;
                            arg_ty += Ty::Ptr as i64;
                            is_pointer = true;
                            while self.lex.tk == Token::TypeQual {
                                self.next()?;
                            }
                        }
                        let size = self.size_of_type(arg_ty) as i64;
                        // C99 6.5.2.2p6: a floating-point argument that
                        // survives default argument promotions is `double`
                        // and rides the fp save area; a pointer or integer
                        // rides the gp save area. `kind` 1 = floating,
                        // 0 = integer / pointer.
                        let kind = if !is_pointer && is_floating_scalar(arg_ty) {
                            1i64
                        } else {
                            0i64
                        };
                        let descriptor = (kind << 16) | (size & 0xffff);
                        let desc_id = self.ast_emit_int_lit(descriptor, Ty::Int as i64);
                        ast_intrinsic_args.push(desc_id);
                        va_arg_result_ty = Some(arg_ty);
                    } else if intrinsic_id == va_start_id || intrinsic_id == va_copy_id {
                        // Two operands: the va_list, then the rightmost
                        // fixed parameter (va_start, C99 7.15.1.4) or
                        // the source va_list (va_copy). Both reach the
                        // intrinsic as addresses; the helpers reduce
                        // the GCC-shaped operands (`ap`, `last`) and
                        // explicit-address spellings alike.
                        self.expr(Token::Assign as i64)?;
                        self.va_list_operand_address();
                        if let Some(a) = self.ast_acc {
                            ast_intrinsic_args.push(a);
                        }
                        self.ast_psh();
                        if self.lex.tk != ',' {
                            return Err(self
                                .compile_err(format!("intrinsic `{fn_name}` takes two operands")));
                        }
                        self.next()?;
                        self.expr(Token::Assign as i64)?;
                        if intrinsic_id == va_copy_id {
                            self.va_list_operand_address();
                        } else {
                            self.va_operand_take_address();
                        }
                        if let Some(a) = self.ast_acc {
                            ast_intrinsic_args.push(a);
                        }
                    } else if intrinsic_id == va_end_id {
                        // One operand: the va_list, reduced to its
                        // storage address.
                        self.expr(Token::Assign as i64)?;
                        self.va_list_operand_address();
                        if let Some(a) = self.ast_acc {
                            ast_intrinsic_args.push(a);
                        }
                    } else if intrinsic_id == longjmp_id {
                        // Two-arg shape: env then val. The first
                        // gets pushed; the second lands in the
                        // accumulator so the AArch64 lowering can
                        // pop env and read val without extra
                        // shuffling.
                        self.expr(Token::Assign as i64)?;
                        if let Some(a) = self.ast_acc {
                            ast_intrinsic_args.push(a);
                        }
                        self.ast_psh();
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
                            self.ast_fpcast();
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
                            self.ast_fpcast();
                            self.ty = Ty::Int as i64;
                        }
                    }
                    if self.lex.tk != ')' {
                        return Err(self.compile_err(format!(
                            "intrinsic `{fn_name}` arity mismatch at close paren"
                        )));
                    }
                    self.next()?;
                    self.mark_emit_other();
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
                        || intrinsic_id == trap_id
                    {
                        self.ty = Ty::Int as i64;
                    } else if intrinsic_id == va_arg_id {
                        // __builtin_va_arg returns `void *`
                        // pointing at the just-vacated 8-byte
                        // slot. The <stdarg.h> macro dereferences
                        // as the requested type.
                        self.ty = (Ty::Char as i64) + (Ty::Ptr as i64);
                    } else if intrinsic_id == fma_id {
                        self.ty = Ty::Double as i64;
                    } else if intrinsic_id == fmaf_id {
                        self.ty = Ty::Float as i64;
                    } else if is_fp_unary {
                        self.ty = if intr_kind.is_some_and(|i| i.is_single_precision()) {
                            Ty::Float as i64
                        } else {
                            Ty::Double as i64
                        };
                    } else if is_int_bit_unary {
                        // C99 has no such builtin; GCC defines the result
                        // type as `int` for every form.
                        self.ty = Ty::Int as i64;
                    } else if is_bswap {
                        // GCC types the result as the unsigned operand
                        // width: uint16_t / uint32_t / uint64_t.
                        self.ty = match intr_kind {
                            Some(crate::c5::op::Intrinsic::Bswap16) => Ty::Short as i64,
                            Some(crate::c5::op::Intrinsic::Bswap64) => Ty::LongLong as i64,
                            _ => Ty::Int as i64,
                        } | super::types::UNSIGNED_BIT;
                    } else {
                        self.ty = (Ty::Char as i64) + (Ty::Ptr as i64);
                    }
                    // Dual-emit `Expr::Intrinsic { kind, args, ty }`.
                    // The walker dispatches by `kind` to the matching
                    // `Inst::Intrinsic` op. Args carry through in
                    // source order.
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
                    // GCC semantics: `__builtin_va_arg(ap, T)` yields
                    // the next argument as a value of type T. The
                    // intrinsic returns the slot address; wrap it in
                    // the `*(T *)...` shape <stdarg.h>'s va_arg used
                    // to spell out.
                    if let Some(res_ty) = va_arg_result_ty {
                        if let Some(child) = self.ast_acc {
                            self.ast_emit_cast(child, res_ty + Ty::Ptr as i64);
                        }
                        if !(is_struct_ty(res_ty) && struct_ptr_depth(res_ty) == 0) {
                            self.mark_emit_scalar_load();
                        }
                        self.ty = res_ty;
                        self.ast_apply_unary(super::super::ast::UnOp::Deref);
                    }
                } else {
                    // Snapshot the declared signature up front: the per-arg
                    // type checks read from `expected_params` and `is_variadic`,
                    // and we don't want a recursive call to clobber them via
                    // self-mutation. Cloning the Vec is cheap (typically 1-3
                    // i64s) compared to the cost of the type check itself.
                    let expected_params = self.symbols[id_idx].params.clone();
                    let is_variadic = self.symbols[id_idx].is_variadic;
                    let fn_name_for_warn = self.symbols[id_idx].name.clone();
                    // A Token::Sys callee is a libc import: it reads each
                    // argument at the platform-ABI register width and never
                    // re-narrows to its declared parameter type. A c5
                    // (Token::Fun) callee instead truncates each argument in
                    // its prologue via the typed parameter load, so the
                    // caller-side narrowing below is needed only for Sys
                    // calls to satisfy the C99 6.5.2.2p4 conversion.
                    let is_sys_call = self.symbols[id_idx].class == Token::Sys as i64;
                    // A callee whose return type is the implicit `int`
                    // default -- a `#pragma binding` with no prototype, or
                    // a C89 implicit declaration -- truncates the result to
                    // 32 bits if it really returns a pointer or wider type.
                    // Warn once so the source (or a header) declares it.
                    if self.symbols[id_idx].implicit_return_int
                        && self.warned_implicit_ret.insert(id_idx)
                    {
                        let name = self.symbols[id_idx].name.clone();
                        let line = self.lex.line;
                        self.warn_at(
                            line,
                            alloc::format!(
                                "`{name}` is called without a return-type prototype; assuming `int`"
                            ),
                        );
                    }
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
                    // A Token::Sys (dylib-bound) call returning a struct by
                    // value is lowered through the native SSA path: the
                    // walker tags the CallExt with `ret_agg` and the emitter
                    // gathers the result from the platform-ABI return
                    // registers into the result temp (HFA in v0..vN, x0/x1
                    // for a small aggregate, x8 indirect for > 16 bytes).
                    let mut nargs = 0;
                    // Snapshot the AST parser-side vstack depth so
                    // the call's per-arg emit sequence (per-arg
                    // address-of-temp setup, the right-to-left
                    // re-push, the optional struct-return
                    // out-pointer push) can leak transient pushes
                    // without polluting the outer expression's
                    // lvalue stack. The matching pops on the AST
                    // side route through `ast_apply_assign` for
                    // the per-arg `*temp = arg` shape (the only
                    // store in this region), which consumes one
                    // vstack slot per store. The right-to-left
                    // re-push and the out-pointer push are pure
                    // leaks -- truncate the vstack back to this
                    // depth right before `ast_emit_call` so the
                    // outer scalar assign's `ast_apply_assign`
                    // sees the lvalue it pushed.
                    let saved_ast_vstack_depth = self.ast_vstack.len();
                    // For struct returns, allocate a result temp now
                    // so its address can be pushed before the
                    // declared-arg pushes.
                    let saved_loc_offs_for_result = self.loc_offs;
                    let result_temp_off: i64 = if callee_returns_struct {
                        let slots = self.slots_of_type(callee_ret_ty);
                        let off = self.reserve_slots(slots);
                        if slots > 1 {
                            self.multi_cell_temps.push((off, slots));
                        }
                        off
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
                        let temp_off = self.reserve_slots(1);
                        temp_offsets.push(temp_off);

                        // Emit the `*temp = expr;` shape that c5's
                        // assignment path already supports: address
                        // first, push, then RHS, then Si.
                        self.emit_lea(temp_off);
                        self.ast_psh();
                        self.expr(Token::Assign as i64)?;

                        // Type-check before the Si overwrites self.ty.
                        if (nargs as usize) < expected_params.len() {
                            let want = expected_params[nargs as usize];
                            let arg_ty = self.ty;
                            let zero = self.last_emit_is_zero();
                            let untyped = self.last_emit_was_indirect_call();
                            if let Some(reason) = Self::type_warning_with_flags(
                                &self.structs,
                                want,
                                self.ty,
                                zero,
                                untyped,
                            ) {
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
                            // actual is an integer, lift through
                            // the int-to-float cast so the IEEE-754
                            // bit pattern reaches the FP-arg register
                            // the codegen routes through (xmm_N / d_N).
                            // Without this, the integer bit pattern
                            // lands in the GPR-arg register and libm
                            // reads garbage out of the FP register.
                            self.convert_assign_rhs(want);
                            // C99 6.5.2.2p4: the argument is converted to the
                            // declared parameter type. For a Sys (libc) callee
                            // the conversion must happen here -- the import
                            // reads the argument at the full register width and
                            // never re-narrows. A c5 callee truncates in its
                            // typed parameter load, so this is Sys-only, and
                            // only when the argument is wider than the integer
                            // parameter (an in-width argument needs no mask).
                            if is_sys_call
                                && !is_pointer_ty(want)
                                && !is_floating_scalar(want)
                                && !is_struct_ty(want)
                                && self.size_of_type(arg_ty) > self.size_of_type(want)
                            {
                                self.renormalize_to_width(want);
                            }
                        } else {
                            if !expected_params.is_empty() && !is_variadic {
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
                            // C99 6.5.2.2p6-7: arguments beyond the
                            // declared parameters (the variadic tail, or
                            // any argument to a function with no
                            // prototype) undergo the default argument
                            // promotions. A `float` is promoted to
                            // `double` so it reaches the FP-arg register
                            // as the 8-byte value the callee reads;
                            // `char` / `short` already ride the int
                            // accumulator.
                            if is_float_ty(self.ty) {
                                self.convert_assign_rhs(Ty::Double as i64);
                            }
                        }

                        // A struct passed by value to a Token::Sys callee is
                        // packed into the platform-ABI argument registers by
                        // the walker + emitter (the same host-ABI path c5-to-c5
                        // calls use); the by-value struct argument is no longer
                        // rejected here.
                        // Snapshot the arg's AST ExprId before the
                        // Si consumes both vstack and acc. The Call
                        // node built below uses these in source
                        // order regardless of the c5 right-to-left
                        // push.
                        ast_arg_ids.push(self.ast_acc);
                        self.ast_assign();
                        nargs += 1;
                        self.accept(',')?;
                    }
                    // Push from temp slots right-to-left so the first
                    // declared param ends up on top of the c5 stack.
                    for &temp_off in temp_offsets.iter().rev() {
                        self.emit_lea(temp_off);
                        self.mark_emit_other();
                        self.ast_psh();
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
                        self.ast_psh();
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
                    // Never drop below block-lifetime storage a compound
                    // literal reserved while evaluating these arguments
                    // (C99 6.5.2.5p5); reclaiming it would alias the literal
                    // with a later full-expression's temporaries.
                    self.loc_offs = target_loc_offs.max(self.committed_loc_offs);
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
                        // External library call. The walker emits
                        // Inst::CallExt keyed on the binding's flat
                        // index (taken from Symbol::val); the
                        // codegen lowers it to the per-target GOT /
                        // import-table reference.
                        self.flush_pending_stores();
                        self.pending.last_emit_was_indirect_call = false;
                        self.ast_acc = None;
                    } else if self.symbols[id_idx].class == Token::Fun as i64 {
                        // Direct call to a c5 user function. The
                        // walker resolves Inst::Call::target_pc
                        // through live_fun_val and the linker's
                        // extern_call_refs channel.
                        self.symbols[id_idx].was_referenced = true;
                        self.flush_pending_stores();
                        self.pending.last_emit_was_indirect_call = false;
                        self.ast_acc = None;
                    } else if self.symbols[id_idx].class == Token::Loc as i64
                        || self.symbols[id_idx].class == Token::Glo as i64
                    {
                        // Indirect call through a function pointer:
                        // a Loc / Glo whose value is the target's
                        // ent_pc. Mark the symbol as read for the
                        // dead-store diagnostic; the walker emits
                        // Inst::CallIndirect from the AST.
                        if self.symbols[id_idx].class == Token::Loc as i64 {
                            self.symbols[id_idx].was_referenced = true;
                            self.symbols[id_idx].was_read = true;
                        } else {
                            self.glo_imm_refs.push(id_idx);
                        }
                        self.flush_pending_stores();
                        self.pending.last_emit_was_indirect_call = true;
                        self.ast_acc = None;
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
                    // Drop the AST parser-side vstack pushes that
                    // the call's emit sequence leaked (right-to-
                    // left re-push, optional struct-return out-
                    // pointer push) before the outer expression's
                    // `ast_apply_assign` runs. See the matching
                    // `saved_ast_vstack_depth` snapshot above.
                    self.ast_vstack.truncate(saved_ast_vstack_depth);
                    // Dual-emit the call's AST: build a callee
                    // Ident node from the call-site symbol idx and
                    // pair with the per-arg ExprIds captured above.
                    // Struct-returning calls skip the AST build for
                    // now; the hidden out-pointer doesn't fit the
                    // canonical `Call { callee, args, ty }` shape.
                    // For a direct (Fun / Sys) call the symbol's `type_`
                    // is the return type. For a call through a
                    // function-pointer variable (Loc / Glo) `type_` is
                    // the pointer's type, which encodes the return type
                    // plus one pointer level for the fn-pointer; the
                    // result type is that minus one level (`int (*)()` ->
                    // int, `struct S *(*)()` -> struct S *). A variable
                    // that is not a fn-pointer falls back to int.
                    let is_var_call = self.symbols[id_idx].class == Token::Loc as i64
                        || self.symbols[id_idx].class == Token::Glo as i64;
                    let result_ty = if is_var_call {
                        let vt = self.symbols[id_idx].type_;
                        if self.symbols[id_idx].fn_ptr_indirection > 0 && is_pointer_ty(vt) {
                            vt - Ty::Ptr as i64
                        } else {
                            Ty::Int as i64
                        }
                    } else {
                        callee_ret_ty
                    };
                    // For a struct-returning callee the `Expr::Call
                    // { ty: <struct> }` makes the walker allocate a
                    // synthetic local for the hidden out-pointer,
                    // prepend its address to the arg list, and return
                    // the address as the call's value (the c5 ABI's
                    // address-as-value rule).
                    let callee_ty = self.symbols[id_idx].type_;
                    let callee_id = self.ast_synthesize_callee(id_idx as u32, callee_ty);
                    // A call through a variadic function-pointer
                    // variable records its fixed count at parse time,
                    // while the block-scope binding is live: the
                    // walker runs after scope exit restored the outer
                    // signature, so the symbol no longer carries the
                    // pointer's prototype (C99 6.2.1p4).
                    if is_var_call && self.symbols[id_idx].is_variadic {
                        self.ast
                            .variadic_indirect_callees
                            .push((callee_id, self.symbols[id_idx].params.len() as u32));
                    }
                    self.ast_emit_call(callee_id, ast_arg_ids.clone(), result_ty);
                    // For struct-returning callees, the result lives
                    // in the caller-allocated temp. After the call,
                    // load the temp's address into `a` so the
                    // expression's value (struct-rvalue semantics:
                    // address-as-value) flows into the enclosing
                    // assignment / `.field` access.
                    if callee_returns_struct {
                        self.emit_lea(result_temp_off);
                    }
                    self.ty = result_ty;
                    // A callee whose return type is itself a function
                    // pointer (`int (*f())()`) leaves a fn-pointer
                    // rvalue, so a following unary `*` is the C99
                    // 6.3.2.1p4 decay no-op. The lineage is recorded on
                    // the function symbol by the declarator.
                    if self.symbols[id_idx].class == Token::Fun as i64
                        && self.symbols[id_idx].fn_ptr_indirection > 0
                    {
                        self.pending.fn_ptr_chain_depth = 0;
                    }
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
                // The integer-literal placeholder runs only to keep the
                // trailing-emit peek flags honest; the walker's
                // `imm_code_extern` / `imm_code` emit resolves the
                // function-pointer literal on the SSA side.
                self.emit_imm(CODE_BASE as i64 + self.symbols[id_idx].val);
                // Encode the function-pointer type as the callee's return
                // type plus one pointer level, so an inline call through
                // the value (`(cond ? f : g)(x)`) recovers the real
                // result type instead of defaulting to `int` and
                // narrowing a wider return.
                self.ty = self.symbols[id_idx].type_ + Ty::Ptr as i64;
                // Dual-emit: an Ident node so the wrapping shape
                // (call-arg, assignment, cast) sees the function
                // reference on `ast_acc`. The walker's
                // `load_ident_rvalue` for `Token::Fun` emits the
                // matching `imm_code(val)`.
                self.ast_emit_ident(id_idx as u32, self.ty);
                // The value is already a function pointer; a following
                // unary `*` is the C99 6.3.2.1p4 decay no-op at every
                // level (`(****g)(...)` calls `g`). Depth 0 marks "at
                // the fn-ptr level" for the `*` handler.
                self.pending.fn_ptr_chain_depth = 0;
            } else if self.symbols[id_idx].class == Token::Sys as i64 {
                // Bare imported-function reference -- `fp = strcmp;`.
                // There is no compile-time address to fold in, so the
                // walker emits `Inst::ImmExtCode(binding_idx)`; the
                // codegen materializes the import's shared PLT-stub
                // address (RIP-relative `lea` on x86_64, `adrp + add`
                // on aarch64), the same stub a call to the import
                // reaches. The Sys symbol's `val` is the binding index.
                self.emit_imm(CODE_BASE as i64);
                self.ty = self.symbols[id_idx].type_ + Ty::Ptr as i64;
                // Dual-emit: push the Sys Ident so wrapping shapes
                // (static-init, assign, call-arg) see the address
                // producer on `ast_acc`. The walker's
                // `address_of_ident` / `load_ident_rvalue`
                // `Token::Sys` arm emits the `imm_ext_code(val)`.
                self.ast_emit_ident(id_idx as u32, self.ty);
                // Same fn-pointer decay as the `Token::Fun` branch: a
                // following unary `*` is a no-op.
                self.pending.fn_ptr_chain_depth = 0;
            } else if self.symbols[id_idx].class == Token::Loc as i64
                && matches!(
                    self.symbols[id_idx].asm_register,
                    Some(
                        crate::c5::symbol::AsmRegister::StackPointer
                            | crate::c5::symbol::AsmRegister::FramePointer
                    )
                )
            {
                // A stack- / frame-pointer register variable: the read is
                // a direct register move, no storage behind it. Writes
                // have no meaning; reject them here where the following
                // token is visible.
                if self.lex.tk == Token::Assign
                    || self.lex.tk == Token::AssignOp
                    || self.lex.tk == Token::Inc
                    || self.lex.tk == Token::Dec
                {
                    return Err(self.compile_err(format!(
                        "cannot write register variable `{}`",
                        self.symbols[id_idx].name
                    )));
                }
                self.symbols[id_idx].was_referenced = true;
                self.symbols[id_idx].was_read = true;
                self.mark_emit_other();
                self.ty = self.symbols[id_idx].type_;
                let kind = match self.symbols[id_idx].asm_register {
                    Some(crate::c5::symbol::AsmRegister::FramePointer) => {
                        crate::c5::op::Intrinsic::FrameAddress
                    }
                    _ => crate::c5::op::Intrinsic::StackPointer,
                };
                let mut args = alloc::vec::Vec::new();
                if kind == crate::c5::op::Intrinsic::FrameAddress {
                    // FrameAddress carries the (ignored) level operand.
                    args.push(self.ast_emit_int_lit(0, Ty::Int as i64));
                }
                let intr_ty = self.ty;
                let pos = self.ast_src_pos();
                let id = self.ast.push_expr(
                    super::super::ast::Expr::Intrinsic {
                        kind: kind as i64,
                        args,
                        ty: intr_ty,
                    },
                    pos,
                );
                self.ast_acc = Some(id);
            } else {
                let identifier_is_local = self.symbols[id_idx].class == Token::Loc as i64;
                if identifier_is_local {
                    self.symbols[id_idx].was_referenced = true;
                    self.emit_lea(self.symbols[id_idx].val);
                } else if self.symbols[id_idx].class == Token::Glo as i64
                    && self.symbols[id_idx].is_thread_local
                {
                    // `_Thread_local` global: emit through the
                    // TLS-address path so the codegen lowers via
                    // the per-target TLS sequence (TPIDR_EL0 +
                    // offset on aarch64, fs:0 + offset on x86_64).
                    // The operand is the byte offset within the
                    // program's TLS block.
                    self.mark_emit_other();
                } else if self.symbols[id_idx].class == Token::Glo as i64 {
                    self.emit_data_imm(self.symbols[id_idx].val);
                    self.glo_imm_refs.push(id_idx);
                } else {
                    return Err(self
                        .compile_err(format!("undefined variable {}", self.symbols[id_idx].name)));
                }
                self.ty = self.symbols[id_idx].type_;
                let is_struct_value = is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0;
                let is_array_var =
                    self.symbols[id_idx].array_size != 0 || self.symbols[id_idx].is_zero_len_array;
                let is_vla_var = self.symbols[id_idx].is_vla;
                // A function-pointer variable carries its callee parameter
                // types so the dereferenced-call shape `(*fp)(args)` (which
                // reaches the postfix path rather than the direct-identifier
                // call path) narrows each argument to its declared type.
                // Only a function pointer carries params on a Loc / Glo
                // symbol; the array case is handled at its decay below.
                if !is_array_var && !is_struct_value && !self.symbols[id_idx].params.is_empty() {
                    self.pending.indirect_callee_params = Some(self.symbols[id_idx].params.clone());
                    self.pending.indirect_callee_is_variadic = self.symbols[id_idx].is_variadic;
                }
                // Array variables decay to a pointer to the first
                // element: the symbol's address IS its value, no
                // load. Bump the type by one pointer level so
                // downstream pointer arithmetic / indexing scales
                // correctly. Struct values follow the same
                // "address-as-value" rule but keep their type
                // because the `.field` operator needs the struct's
                // value type to look up offsets.
                if is_vla_var {
                    // C99 6.3.2.1p3: a VLA decays to a pointer to its
                    // first element -- the runtime base pointer, loaded
                    // from the hidden slot, not a fixed frame address.
                    let ptr_slot = self.symbols[id_idx].vla_ptr_slot;
                    self.ty += Ty::Ptr as i64;
                    self.ast_emit_vla_base(ptr_slot, self.ty);
                } else if is_array_var {
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
                    } else if self.symbols[id_idx].is_zero_len_array {
                        // Zero-length array: signal the array-ness to a
                        // surrounding `sizeof` / `typeof` with the `-1`
                        // sentinel (element count is genuinely 0, which the
                        // `> 0` recovery paths read as "no array hint").
                        self.pending.last_array_decay_size = -1;
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
                    // A function-pointer array element keeps the element's
                    // parameter types so a following `arr[i](args)` narrows
                    // each argument to its declared type. Empty params means
                    // the element is not a prototyped function pointer.
                    // The element's function-pointer decay depth rides
                    // along as well: `(*arr[i])(...)` must treat the
                    // `*` as the C99 6.3.2.1p4 no-op rather than load
                    // through the code address (the subscript consumes
                    // an array level, not an indirection level).
                    let fpi = self.symbols[id_idx].fn_ptr_indirection;
                    if fpi > 0 {
                        self.pending.fn_ptr_chain_depth = fpi - 1;
                    }
                    if !self.symbols[id_idx].params.is_empty() {
                        self.pending.indirect_callee_params =
                            Some(self.symbols[id_idx].params.clone());
                        self.pending.indirect_callee_is_variadic = self.symbols[id_idx].is_variadic;
                    }
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
                    self.mark_emit_scalar_load();
                    // The AST node is a single `Expr::Ident` keyed
                    // on the symbol-table index. The address-of /
                    // assignment paths re-interpret the same node
                    // as an lvalue.
                    self.ast_emit_ident(id_idx as u32, self.ty);
                    if identifier_is_local {
                        // Tentative: the load survives by default,
                        // so the symbol's value is being read. The
                        // assignment / address-of helpers revert
                        // `was_read` and `pending_stores` to their
                        // prior state (preserving genuine earlier
                        // reads and prior dead-store entries) if
                        // they retract the load before it
                        // executes. `last_loaded_local`
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
                    // the symbol's recorded indirection.
                    // `mark_emit_scalar_load` just cleared the
                    // field; re-set it now so the surrounding
                    // unary-`*` chain can recognise function-
                    // pointer decay. `fn_ptr_indirection`
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
            if self.lex.tk == '{' {
                // GCC statement expression `({ ... })`: the value is
                // that of the enclosed compound's last
                // expression-statement.
                self.parse_stmt_expr_body()?;
            } else if self.lex_is_type_start() {
                // C-style cast: `(<type>)expr`. Accepts int, char,
                // float, double, or struct base, with any number of
                // `*` markers and pointer-level qualifiers.
                t = self.parse_decl_base_type()?;
                // An array typedef (`typedef T A[N]`, e.g. `sigjmp_buf`)
                // contributes its element count here; a single `*` below
                // forms a pointer-to-array whose deref is the C99 6.3.2.1p3
                // decay (no load), not a dereference. Capture the count and
                // element type before the pointer loop rewrites `t`.
                let cast_array_elem_ty = t;
                let cast_typedef_array = core::mem::take(&mut self.pending.typedef_base_array_size);
                let cast_typedef_dims = core::mem::take(&mut self.pending.typedef_base_array_dims);
                let mut cast_ptr_levels: i64 = 0;
                // Fn-pointer lineage: if the base type came from a
                // typedef-of-fn-pointer, parse_decl_base_type seeded
                // `pending_fn_ptr_indirection`; the leading `*`s
                // below add directly to that count. The abstract
                // fn-ptr branch further down overrides this when a
                // `(*)(args)` shape is present in the cast.
                let mut cast_fpi = self.pending.fn_ptr_indirection.take();
                // A function-TYPE typedef already encodes one pointer
                // level, so the first `*` in `(F *)x` forms the
                // pointer-to-function rather than adding a level (matching
                // the declarator path). Take and clear the flag so it does
                // not leak into a later declarator.
                let mut absorb_fn_type_ptr =
                    core::mem::take(&mut self.pending.base_is_function_type);
                while self.lex.tk == Token::MulOp {
                    self.next()?;
                    if absorb_fn_type_ptr {
                        absorb_fn_type_ptr = false;
                    } else {
                        t += Ty::Ptr as i64;
                        cast_ptr_levels += 1;
                        if let Some(fpi) = cast_fpi {
                            cast_fpi = Some(fpi + 1);
                        }
                    }
                    while self.lex.tk == Token::TypeQual {
                        t |= self.lex_volatile_bit();
                        self.next()?;
                    }
                }
                // Top-level array brackets in the abstract
                // declarator: `(int[]){...}` / `(char[N]){...}`.
                // Only a compound literal (detected after the `)`)
                // gives these meaning; `t` stays the element type and
                // `cast_array_size` records the count (`-1` when the
                // bracket is empty and the initializer determines it).
                let mut cast_is_array = false;
                let mut cast_array_size: i64 = 0;
                while self.lex.tk == Token::Brak {
                    cast_is_array = true;
                    self.next()?;
                    if self.lex.tk == ']' {
                        cast_array_size = -1;
                        self.next()?;
                    } else {
                        cast_array_size = self.parse_constant_int()?;
                        self.accept(']')?;
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
                let mut cast_fn_proto = None;
                if self.lex.tk == '(' {
                    let (nested_ptrs, proto, dims) = self.parse_abstract_ptr_declarator(true)?;
                    // `T (*)[N]`: fold the pointee dimensions into the
                    // aggregate-backed tag so the pointee keeps its size,
                    // matching the named declarator `T (*p)[N]`.
                    if !dims.is_empty() && nested_ptrs > 0 {
                        t = self.array_agg_type(t, &dims) + nested_ptrs * (Ty::Ptr as i64);
                    } else {
                        t += nested_ptrs * (Ty::Ptr as i64);
                    }
                    // Abstract fn-ptr declarator: the inner `*`
                    // count IS the indirection from the cast's
                    // result down to the fn-ptr rvalue, plus 1
                    // (matching `Symbol::fn_ptr_indirection`).
                    if nested_ptrs > 0 {
                        cast_fpi = Some(nested_ptrs);
                    }
                    cast_fn_proto = proto;
                }
                if self.lex.tk == ')' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("bad cast"));
                }
                if self.lex.tk == '{' {
                    // C99 6.5.2.5 compound literal: `(type){ init }`.
                    // The `(type)` parsed above is the literal's
                    // type, not a cast operator.
                    self.parse_block_compound_literal(t, cast_is_array, cast_array_size)?;
                } else {
                    self.expr(Token::Inc as i64)?;
                    let cast_child_ast = self.ast_acc;
                    // FP-vs-int casts emit conversion ops so the bit
                    // pattern in r13 is consistent with the new type.
                    // Same-class casts (int<->ptr, float<->double) are
                    // bit-pattern-compatible and need no conversion.
                    let target_is_fp = is_floating_scalar(t);
                    let source_is_fp = is_floating_scalar(self.ty);
                    if target_is_fp ^ source_is_fp {
                        // Mixed FP / int cast: route through ast_fpcast
                        // regardless of direction. The shared call is
                        // the AST shape for `int -> fp` *and* `fp ->
                        // int`; the actual register conversion lives in
                        // the per-arch emit.
                        self.ast_fpcast();
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
                                self.emit_binop_with_imm(crate::c5::ir::BinOp::And, mask);
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
                                self.emit_binop_with_imm(crate::c5::ir::BinOp::Shl, bits);
                                self.emit_binop_with_imm(crate::c5::ir::BinOp::Shr, bits);
                            }
                        }
                    }
                    // `(A *)e` for an array typedef `A` names a
                    // pointer-to-array; rebuild the flat tag into the
                    // aggregate-backed form (extra `*`s add levels).
                    // Pointer casts convert no bits, so only the result
                    // type changes; a following `*` / `[i]` then takes
                    // the array-decay path off the type.
                    if cast_typedef_array > 0
                        && cast_ptr_levels >= 1
                        && cast_fn_proto.is_none()
                        && !cast_is_array
                    {
                        let dims: alloc::vec::Vec<i64> = if cast_typedef_dims.len() >= 2 {
                            cast_typedef_dims.clone()
                        } else {
                            alloc::vec![cast_typedef_array]
                        };
                        let agg = self.array_agg_type(cast_array_elem_ty, &dims);
                        t = (agg + cast_ptr_levels * (Ty::Ptr as i64))
                            | (t & super::types::VOLATILE_BIT);
                    }
                    self.ty = t;
                    // Overwrite the AST acc with a canonical Cast
                    // node so any intermediate Binary nodes the
                    // conversion-shaping sequence pushed don't surface
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
                    // C99 6.5.2.2p7: a call through the cast pointer
                    // uses the cast's prototype. Override the operand's
                    // recorded callee channel so a following call
                    // narrows each argument and splits the variadic
                    // tail per the cast, whatever the operand's own
                    // declared type said.
                    if let Some(pp) = cast_fn_proto {
                        self.pending.indirect_callee_is_variadic = pp.is_variadic;
                        self.pending.indirect_callee_params = if pp.types.is_empty() {
                            None
                        } else {
                            Some(pp.types)
                        };
                    }
                }
            } else {
                self.expr(Token::Assign as i64)?;
                // Comma operator within parens: `(a, b, c)` evaluates
                // each subexpression for its side effects and yields
                // the last. Outside parens, comma stays a separator
                // (function args, declarators) -- this branch only
                // fires inside `(...)` because expr(Assign) doesn't
                // consume `,`. Build `Expr::Comma { lhs, rhs }`
                // chains on the AST so the walker visits the lhs
                // before producing the rhs's value; without the
                // chain the dropped lhs expressions take their
                // side effects with them when the walker drives the
                // codegen.
                while self.lex.tk == ',' {
                    let lhs_ast = self.ast_acc;
                    self.next()?;
                    self.expr(Token::Assign as i64)?;
                    let rhs_ast = self.ast_acc;
                    if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                        let pos = self.ast_src_pos();
                        let ty = self.ty;
                        let id = self
                            .ast
                            .push_expr(super::super::ast::Expr::Comma { lhs, rhs, ty }, pos);
                        self.ast_acc = Some(id);
                    }
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
            if let Some(id) = self.ptr_array_id_depth1(self.ty) {
                // Tested ahead of the function-pointer decay below: a
                // pointer-to-array tag is never a function pointer, and a
                // cast leaves the chain depth at 0, which would otherwise
                // take the decay branch and drop the dereference.
                //
                // Pointer-to-array at the last level: `*p` reaches the
                // array itself, which decays to the element pointer
                // (C99 6.3.2.1p3). The operand's load already produced
                // the row address; no further load, no Ptr peel.
                self.decay_ptr_array_value(id);
            } else if self.pending.fn_ptr_chain_depth == 0 {
                // Decay no-op. Keep depth at 0: the decayed
                // result is itself a fn-ptr rvalue, so any
                // further `*`s also decay. No scalar load fired,
                // so the chain depth is preserved.
            } else if let Some(id) = self.ptr_array_id_depth1(self.ty) {
                // Pointer-to-array at the last level: `*p` reaches the
                // array itself, which decays to the element pointer
                // (C99 6.3.2.1p3). The operand's load already produced
                // the row address; no further load, no Ptr peel.
                self.decay_ptr_array_value(id);
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
                // Capture the operand snapshot before
                // `mark_emit_scalar_load` clears the chain-depth
                // state; the snapshot is the deref's child for
                // the Unary node below.
                let deref_child_ast = self.ast_acc;
                if !result_is_struct_value {
                    let prior_depth = self.pending.fn_ptr_chain_depth;
                    self.mark_emit_scalar_load();
                    // `mark_emit_scalar_load` cleared the chain
                    // depth. Restore it one level deeper if the
                    // operand was tracked:
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
        } else if self.lex.tk == Token::Lan {
            // GCC labels-as-values: `&&label` yields the address of a
            // local label as a `void *`. The label may be defined later
            // in the function (forward reference); `ast_label_by_name`
            // interns it and the walker resolves it to the block.
            self.next()?; // consume `&&`
            if self.lex.tk != Token::Id {
                return Err(self.compile_err("label name expected after `&&`"));
            }
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;
            let label = self.ast_label_by_name(&name);
            let pos = self.ast_src_pos();
            let id = self
                .ast
                .push_expr(super::super::ast::Expr::LabelAddr(label), pos);
            self.ast_acc = Some(id);
            // GCC types `&&label` as `void *`; c5 encodes a void
            // pointer as `char *` (Ty::Char + Ty::Ptr).
            self.ty = Ty::Char as i64 + Ty::Ptr as i64;
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
                // Struct value -- the parser already left the address
                // in `a` (no final-load Li), so the bytecode path needs
                // no change. Record the pointer result type in the
                // dual-emit AST by wrapping the operand in
                // `Expr::Unary { op: AddrOf, ty: struct* }`, so a
                // consumer (e.g. a variadic argument) distinguishes a
                // struct pointer from a by-value struct. The walker's
                // AddrOf arm takes the child's lvalue address, which for
                // a struct lvalue is its rvalue, leaving the value
                // unchanged. Limit the wrap to the lvalue forms
                // `walk_expr_lvalue` handles; a struct rvalue with no
                // lvalue (compound literal, call result) keeps the
                // address-as-value representation and its struct type.
                let wrappable = match self.ast_acc {
                    Some(id) => matches!(
                        self.ast.expr(id),
                        super::super::ast::Expr::Ident { .. }
                            | super::super::ast::Expr::Member { .. }
                            | super::super::ast::Expr::Index { .. }
                            | super::super::ast::Expr::Binary { .. }
                            | super::super::ast::Expr::Unary {
                                op: super::super::ast::UnOp::Deref,
                                ..
                            }
                    ),
                    None => false,
                };
                if wrappable {
                    self.ast_apply_unary(super::super::ast::UnOp::AddrOf);
                }
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
            } else if matches!(
                self.ast_acc,
                Some(id) if matches!(
                    self.ast.expr(id),
                    super::super::ast::Expr::CompoundLiteral { .. }
                )
            ) {
                // C99 6.5.2.5p4: a compound literal is an lvalue -- an
                // unnamed object with automatic storage. A scalar literal's
                // value was materialized without a trailing load, so there
                // was nothing for `pop_trailing_scalar_load` to drop; wrap
                // the literal in `AddrOf` and let the walker's lvalue path
                // emit the init and yield the slot address. Struct / array
                // literals reach `&` through the branches above.
                self.ast_apply_unary(super::super::ast::UnOp::AddrOf);
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
            self.emit_binop_with_imm(crate::c5::ir::BinOp::Eq, 0);
            self.ty = Ty::Int as i64;
        } else if self.lex.tk == '~' {
            self.next()?;
            self.expr(Token::Inc as i64)?;
            self.emit_binop_with_imm(crate::c5::ir::BinOp::Xor, -1);
            // C99 6.5.3.3p4: `~` applies the integer promotions and the
            // result has the promoted operand type. `unsigned char` /
            // `unsigned short` promote to signed `int`. A `long` /
            // `long long` (signed or unsigned) keeps its width and
            // signedness -- forcing `Ty::Int` here would both narrow it
            // and drop the unsigned bit, so a following `>>` would pick
            // an arithmetic shift on `~(unsigned long)x`. A 4-byte
            // unsigned result needs the high half masked back to 32
            // bits because `XOR -1` sets the full 64-bit register.
            let promoted = integer_promote(self.ty);
            if is_unsigned_ty(promoted) && self.size_of_type(promoted) == 4 {
                self.emit_binop_with_imm(crate::c5::ir::BinOp::And, 0xffff_ffff);
            }
            self.ty = promoted;
        } else if self.lex.tk == Token::AddOp {
            // Unary `+`: a no-op per C99 6.5.3.3p2; the result has the
            // integer-promoted operand type. Integer promotion only
            // widens sub-int operands (char / short -> int); types of
            // rank int and above (unsigned, long, long long) keep their
            // type, so forcing `int` here would drop the width and
            // signedness and run a later comparison or shift on the
            // wrong type. FP operands keep their FP type -- otherwise
            // `+0.5` poses as an integer and a later `r + (+0.5)` lowers
            // to `BinOp::Add` instead of `BinOp::Fadd`.
            self.next()?;
            self.expr(Token::Inc as i64)?;
            if !is_floating_scalar(self.ty) {
                self.ty = integer_promote(self.ty);
            }
        } else if self.lex.tk == Token::SubOp {
            self.next()?;
            // Constant-fold `-<int-literal>` into the negated
            // integer literal. Float literals don't qualify --
            // floating negation must apply to the parsed f64 bit
            // pattern, not a sign flip on the integer-shaped operand.
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
                    self.ast_fneg();
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
                    self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, -1);
                    self.ty = integer_promote(operand_ty);
                    // C99 6.5.3.3p3: result has the promoted operand type and
                    // follows that type's overflow rules. Negating the
                    // type-minimum overflows past the type width, so a 32-bit
                    // result is renormalized to its declared width -- otherwise
                    // `-INT_MIN` leaves the high half clear and a later 64-bit
                    // read (Shr, widen to long) sees the wrong value.
                    if self.size_of_type(self.ty) == 4 {
                        self.renormalize_to_width(self.ty);
                    }
                }
            }
        } else if self.lex.tk == Token::Inc || self.lex.tk == Token::Dec {
            t = self.lex.tk.raw();
            self.next()?;
            self.expr(Token::Inc as i64)?;
            // Snapshot the lvalue's AST node before the emit
            // sequence below: rewrite + reload + Psh + Imm +
            // Add/Sub + store_op all run through `ast_apply_*`
            // helpers that pop the vstack regardless of whether the
            // build succeeded, so by the time `ast_emit_pre_inc`
            // fires the lvalue would otherwise be gone.
            let bf_pre = self.direct_inc_lvalue();
            if let Some((lv, ety)) = bf_pre {
                let by = if t == Token::Inc as i64 { 1 } else { -1 };
                let src = self.ast_src_pos();
                let id = self.ast.push_expr(
                    super::super::ast::Expr::PreInc {
                        lvalue: lv,
                        by,
                        ty: ety,
                    },
                    src,
                );
                self.ast_acc = Some(id);
                self.ty = ety;
            } else {
                let pre_inc_lvalue = self.ast_acc;
                self.rewrite_trailing_load_as_psh()
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
                self.mark_emit_other();
                self.ast_psh();
                // A pointer-to-array (`T (*p)[N]`) looks like a plain
                // `T*` in the flat type, so `pointee_step` would scale by
                // `sizeof(T)`. The correct step is the array's size,
                // seeded into the stride snapshot when the operand was
                // loaded (the operand was parsed via a nested `expr()`,
                // so it sits in `end_of_expr_stride`).
                let step = self.pointer_to_array_arith_stride(
                    self.pending.end_of_expr_stride,
                    self.ty,
                    self.pointee_step(self.ty),
                );
                self.emit_imm(step);
                self.ast_binop(if t == Token::Inc as i64 {
                    super::super::ir::BinOp::Add
                } else {
                    super::super::ir::BinOp::Sub
                });
                self.ast_assign();
                // Build the AST `Expr::PreInc` whose `by` is signed
                // by the op direction so the walker routes to a
                // single `binop_imm(Add, lvalue, by)` rather than
                // matching the sign separately. The lvalue producer
                // is already on the parser-side vstack from the
                // trailing-load rewrite.
                let pre_inc_step = if t == Token::Inc as i64 { step } else { -step };
                let pre_inc_ty = self.ty;
                if let Some(lvalue) = pre_inc_lvalue {
                    self.ast_emit_pre_inc(lvalue, pre_inc_step, pre_inc_ty);
                }
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
            // C99 6.5: a struct / union value is not a valid operand of an
            // arithmetic / bitwise / shift / relational / equality / logical
            // operator (the contiguous token range `Lor..=ModOp`). Reject the
            // LHS here; each value-computing branch checks its RHS below. A
            // pointer to a struct is a scalar and is allowed through.
            if is_struct_ty(t)
                && struct_ptr_depth(t) == 0
                && self.lex.tk >= Token::Lor as i64
                && self.lex.tk <= Token::ModOp as i64
                // GCC vector extension: a vector LHS with a bitwise operator is
                // element-wise; let it reach the per-operator branch, which
                // does the same-width check. Other operators still reject.
                && !(is_vector_ty(&self.structs, t)
                    && matches!(
                        self.lex.tk,
                        x if x == Token::XorOp as i64
                            || x == Token::AndOp as i64
                            || x == Token::OrOp as i64
                    ))
                // The GCC 128-bit integer is an integer type; the
                // per-operator branch below routes it to the walker's
                // half-pair expansion.
                && !self.is_int128_ty(t)
            {
                return Err(
                    self.compile_err("invalid operands to binary operator (aggregate type)")
                );
            }
            if self.lex.tk == '(' {
                // Snapshot the callee AST + vstack depth before
                // any of the call's per-arg emit sites perturb
                // the state. The Expr::Call build at the end of
                // this branch combines them into a single
                // `Expr::Call { callee, args, ty }`.
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
                // The unary `*` handler emits a pointer-sized load
                // regardless -- it can't tell at parse time that
                // the operand will be called rather than loaded --
                // so the chain ends one load too deep, with `a`
                // holding the first 8 bytes of the callee's code
                // instead of its address. Undo that here: if
                // `self.ty` says we ended on a non-pointer (= the
                // last `*` removed the final pointer level) and the
                // most recent emit was a pointer-sized load, drop
                // the trailing-load tag and restore one pointer
                // level so the spill below sees the actual function
                // pointer.
                if !is_pointer_ty(self.ty) {
                    let trailing = self.current_scalar_load_kind();
                    let is_load = matches!(
                        trailing,
                        Some(LoadKind::I64)
                            | Some(LoadKind::U8)
                            | Some(LoadKind::I32)
                            | Some(LoadKind::U32)
                    );
                    if is_load {
                        self.clear_recent_emits();
                        self.ty += Ty::Ptr as i64;
                    }
                }
                self.next()?;
                // The function-pointer type encodes the callee's return
                // type plus one pointer level for the fn-pointer itself,
                // so the call result type is `fp_ty - 1` pointer level
                // (`int (*)()` -> int, `struct S *(*)()` -> struct S *).
                // Capture it before the argument parse below overwrites
                // `self.ty`. A non-pointer here is not a valid callee;
                // fall back to int.
                let callee_fp_ty = self.ty;
                // The call result strips the pointer levels that form the
                // function-pointer chain. A plain function pointer needs
                // one level removed. A pointer-to-function-pointer -- e.g.
                // a `typedef RET F(args); ... F *m;` member, where the
                // function-type typedef already encodes one pointer level
                // and the `*` adds another -- needs the whole chain
                // (`fn_ptr_chain_depth + 1`) removed so the result is RET,
                // not an intermediate pointer. Restricted to a struct
                // callee (the case that otherwise reaches an assignment
                // type error) and capped by the actual pointer depth so a
                // stale chain count cannot over-strip.
                let chain = self.pending.fn_ptr_chain_depth;
                let strip = if chain > 0
                    && is_struct_ty(callee_fp_ty)
                    && struct_ptr_depth(callee_fp_ty) > chain
                {
                    chain + 1
                } else {
                    1
                };
                let indirect_ret_ty = if is_pointer_ty(callee_fp_ty) {
                    callee_fp_ty - strip * Ty::Ptr as i64
                } else {
                    Ty::Int as i64
                };
                // Spill the FP into a fresh local temp through the
                // store-local path. The plain "address-of-local
                // then store" shape can't express this without
                // losing the accumulator, so the dialect carries a
                // dedicated store-local op for the case where the
                // accumulator already holds the value.
                let fp_temp = self.reserve_slots(1);
                self.mark_emit_other();
                // Each arg lands in its own temp slot first
                // (left-to-right eval), then we push them
                // right-to-left so the first arg ends up on top of
                // the c5 stack.
                //
                // The callee's parameter types, ferried from the
                // producing function-pointer symbol, drive the same
                // C99 6.5.2.2p7 assignment conversion the direct-call
                // path applies: each argument narrows / widens to its
                // declared parameter type before the store. Without it
                // a `double`-typed argument (a `float` literal is typed
                // `double` in the accumulator) reaches a `float`
                // parameter unconverted and the callee reads the wrong
                // half of the FP register.
                let callee_params = self.pending.indirect_callee_params.take();
                // Recover the variadic prototype alongside the parameter
                // types so the call node records the fixed-argument count
                // for the walker's host-ABI tail placement.
                let callee_is_variadic =
                    core::mem::take(&mut self.pending.indirect_callee_is_variadic);
                let callee_fixed = callee_params.as_ref().map_or(0, |p| p.len()) as u32;
                let mut arg_idx: usize = 0;
                while self.lex.tk != ')' {
                    let temp_off = self.reserve_slots(1);
                    self.emit_lea(temp_off);
                    self.ast_psh();
                    self.expr(Token::Assign as i64)?;
                    if let Some(params) = &callee_params
                        && arg_idx < params.len()
                    {
                        self.convert_assign_rhs(params[arg_idx]);
                    }
                    indirect_arg_ids.push(self.ast_acc);
                    self.ast_assign();
                    arg_idx += 1;
                    self.accept(',')?;
                }
                self.next()?; // consume `)`
                self.flush_pending_stores();
                self.pending.last_emit_was_indirect_call = true;
                self.ast_acc = None;
                let _ = fp_temp;
                // Result type recovered from the function-pointer's type
                // above. The register carries the full 8-byte return
                // regardless; the tag lets a following `->` / `[` / `*`
                // see the right pointer level.
                self.ty = indirect_ret_ty;
                // Drop the AST vstack pushes the call's emit
                // sequence leaked, mirror of the direct-call
                // truncation.
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
                        // Record a variadic indirect callee so the walker
                        // splits the argument list at the fixed count even
                        // when the callee's prototype is not recoverable
                        // from its symbol (a struct-field, array-element, or
                        // dereferenced function pointer).
                        if callee_is_variadic {
                            self.ast
                                .variadic_indirect_callees
                                .push((callee_id, callee_fixed));
                        }
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
                    // Struct-to-struct copy. The destination lvalue is
                    // captured in `struct_lhs_ast`; the walker emits
                    // `Inst::Mcpy { dst, src, size }` from the AST node
                    // and returns the dst address as the value (mirroring
                    // libc memcpy). The lvalue is not pushed onto the
                    // AST vstack: a sub-expression must leave the vstack
                    // as it found it (its result rides `ast_acc`), or an
                    // enclosing assignment's `ast_apply_assign` pops the
                    // stray entry as its own lvalue and drops itself.
                    //
                    // This branch must run *before* the scalar
                    // load-rewrite below: for `*pItem =
                    // struct_rvalue` where pItem is a struct
                    // pointer, the deref elides the trailing
                    // struct-value load but leaves the pointer-load
                    // tag in place, so a `Some(LoadKind::I64)`
                    // would otherwise misroute us into the scalar
                    // path and rewrite the wrong tag.
                    let struct_lhs_ast = self.ast_acc.take();
                    self.mark_emit_other();
                    self.expr(Token::Assign as i64)?;
                    let mut struct_rhs_ast = self.ast_acc;
                    if !is_struct_ty(self.ty) || struct_ptr_depth(self.ty) != 0 {
                        // A scalar assigned to a 128-bit `__int128` lvalue is
                        // widened: wrap the rhs in a cast to `__int128` so the
                        // cast lowering materialises the 16-byte value and the
                        // struct-copy below stores it. Other struct types
                        // reject a non-struct rhs (C99 6.5.16.1p1).
                        if self.is_int128_ty(t) {
                            if let Some(rhs) = struct_rhs_ast {
                                let pos = self.ast_src_pos();
                                struct_rhs_ast = Some(self.ast.push_expr(
                                    super::super::ast::Expr::Cast {
                                        child: rhs,
                                        to_ty: t,
                                    },
                                    pos,
                                ));
                            }
                            self.ty = t;
                        } else {
                            return Err(
                                self.compile_err("cannot assign non-struct value to a struct")
                            );
                        }
                    }
                    // C99 6.5.16.1p1: the operands need compatible
                    // unqualified struct types -- lvalue conversion
                    // (6.3.2.1p2) already drops qualifiers from the
                    // right operand's value, so a `volatile`-qualified
                    // source object assigns to a plain destination.
                    // `UNSIGNED_BIT` is stripped too: only the int128
                    // tag carries it, and a signed / unsigned 128-bit
                    // assignment converts the value (a bit copy, C99
                    // 6.3.1.3), so the copy below is already correct.
                    if super::types::strip_unsigned(t) != super::types::strip_unsigned(self.ty) {
                        let lhs_s = format_type(t, &self.structs);
                        let rhs_s = format_type(self.ty, &self.structs);
                        return Err(self.compile_err(format!(
                            "struct types differ on either side of `=` \
                             (lhs={lhs_s}, rhs={rhs_s})"
                        )));
                    }
                    self.mark_emit_other();
                    self.ty = t;
                    // Dual-emit `Expr::Assign { lhs, rhs, ty }`
                    // with the struct type; the walker keys on
                    // `is_struct_ty(ty) && struct_ptr_depth(ty)
                    // == 0` to emit `Inst::Mcpy` instead of the
                    // scalar store.
                    if let (Some(lhs), Some(rhs)) = (struct_lhs_ast, struct_rhs_ast) {
                        let pos = self.ast_src_pos();
                        let id = self
                            .ast
                            .push_expr(super::super::ast::Expr::Assign { lhs, rhs, ty: t }, pos);
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
                    if let Some(reason) = Self::type_warning_with_flags(
                        &self.structs,
                        t,
                        self.ty,
                        rhs_is_zero,
                        rhs_is_untyped,
                    ) {
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
                    self.ast_assign();
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
                // scalar load into a stack push so the address
                // sits on the stack, then load it again, push,
                // evaluate the RHS, emit the binop, and store.
                // Only scalar / pointer lvalues qualify -- structs
                // and bitfields don't accept compound assignment
                // in c5.
                let binop = self.lex.ival;
                let compound_lhs_ast = self.ast_acc;
                // GCC vector extension: `v OP= w` for a bitwise OP on same-width
                // vectors is `v = v OP w`. Build that node pair directly (the
                // scalar compound path below handles only scalar / pointer
                // lvalues). The lhs is a side-effect-free operand reused as both
                // the store target and the binop's left operand.
                if is_vector_ty(&self.structs, t)
                    && (binop == Token::XorOp as i64
                        || binop == Token::AndOp as i64
                        || binop == Token::OrOp as i64)
                {
                    let vec_ty = t;
                    let lhs_node = compound_lhs_ast
                        .ok_or_else(|| self.compile_err("bad lvalue in compound assignment"))?;
                    let pos = self.ast_src_pos();
                    self.next()?; // consume `OP=`
                    self.expr(Token::Assign as i64)?; // parse the rhs
                    let rhs_node = self
                        .ast_acc
                        .ok_or_else(|| self.compile_err("bad operand in compound assignment"))?;
                    if !(is_vector_ty(&self.structs, self.ty)
                        && self.structs[struct_id_of(self.ty)].size
                            == self.structs[struct_id_of(vec_ty)].size)
                    {
                        return Err(self.compile_err("invalid operands to vector compound `^=`"));
                    }
                    use super::super::ir::BinOp as B;
                    let bop = if binop == Token::XorOp as i64 {
                        B::Xor
                    } else if binop == Token::AndOp as i64 {
                        B::And
                    } else {
                        B::Or
                    };
                    let bin = self.ast.push_expr(
                        super::super::ast::Expr::Binary {
                            op: bop,
                            lhs: lhs_node,
                            rhs: rhs_node,
                            ty: vec_ty,
                        },
                        pos,
                    );
                    let asg = self.ast.push_expr(
                        super::super::ast::Expr::Assign {
                            lhs: lhs_node,
                            rhs: bin,
                            ty: vec_ty,
                        },
                        pos,
                    );
                    self.ast_acc = Some(asg);
                    self.ty = vec_ty;
                    continue;
                }
                // The GCC 128-bit integer: its lvalue's value is its
                // address, so there is no trailing scalar load for the
                // path below to rewrite. Build the `CompoundAssign`
                // node directly; the walker evaluates the lvalue once
                // (C99 6.5.16.2p3) and expands the operator over the
                // two 64-bit halves.
                if self.is_int128_ty(t) {
                    let lhs_node = compound_lhs_ast
                        .ok_or_else(|| self.compile_err("bad lvalue in compound assignment"))?;
                    let lhs_ty = t;
                    let pos = self.ast_src_pos();
                    self.next()?;
                    self.expr(Token::Assign as i64)?;
                    let rhs_node = self
                        .ast_acc
                        .ok_or_else(|| self.compile_err("bad rhs in compound assignment"))?;
                    let bop = self.compound_assign_binop(binop, lhs_ty, self.ty, false)?;
                    let node = self.ast.push_expr(
                        super::super::ast::Expr::CompoundAssign {
                            op: bop,
                            lhs: lhs_node,
                            rhs: rhs_node,
                            ty: lhs_ty,
                        },
                        pos,
                    );
                    self.ast_acc = Some(node);
                    self.ty = lhs_ty;
                    continue;
                }
                self.next()?;
                // Rewrite the trailing load into a Psh so the
                // address sits on the c5 stack across the compound
                // op; the helper hands back the matching reload op
                // so we can put the current value back into `a`
                // before pushing it for the binop's pop.
                self.rewrite_trailing_load_as_psh()
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
                self.mark_emit_other();
                // Push the current value so the binop can pop it.
                self.ast_psh();
                // For pointer arithmetic with `+=` / `-=`, scale
                // the RHS by the element size before applying the
                // op. We capture lhs ty here; rhs ty is known after
                // expr().
                let lhs_ty = self.ty;
                self.expr(Token::Assign as i64)?;
                let pre_scale_rhs_ast = self.ast_acc;
                // Captured before any conversion cast rewrites
                // `self.ty`: drives the FP-vs-integer opcode choice
                // below when the lvalue is integer but the rhs is
                // floating (C99 6.5.16.2 performs the operation in the
                // common type).
                let rhs_ty = self.ty;
                let rhs_is_fp = is_floating_scalar(rhs_ty);
                if (binop == Token::AddOp as i64 || binop == Token::SubOp as i64)
                    && is_pointer_ty(lhs_ty)
                    && !is_floating_scalar(lhs_ty)
                {
                    let elem_ty = lhs_ty - Ty::Ptr as i64;
                    let elem_size = self.size_of_type(elem_ty) as i64;
                    if elem_size > 1 {
                        self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, elem_size);
                    }
                }
                // Capture rhs after the pointer-arithmetic
                // scale ran; the scale is a wrapping `Binary {
                // Mul, rhs, IntLit(scale) }` node and the
                // walker's `CompoundAssign` arm uses the
                // captured id verbatim, so the walker re-emits
                // the same `Mul` chain (rather than letting the
                // walker apply its own pointer scaling).
                let mut compound_rhs_ast = self.ast_acc.or(pre_scale_rhs_ast);
                // Floating-point lvalue (`double x; x *= 2.0;`) needs
                // the FP variant of the binop, not the integer one.
                // Without this, `x *= y` lowered to `BinOp::Mul` which
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
                if lhs_is_fp {
                    self.require_both_float(lhs_ty, "compound assign")?;
                    // `require_both_float` wrapped `ast_acc` in
                    // an `Expr::Cast` (via the dual-emit hook in
                    // `convert.rs`); pick up the cast'd id so
                    // the walker emits the int->FP lift before
                    // the FP binop.
                    compound_rhs_ast = self.ast_acc.or(compound_rhs_ast);
                }
                // An integer lvalue with a floating rhs keeps the rhs
                // unchanged; the walker loads the lvalue, converts it
                // to the floating common type, applies the FP op, and
                // converts the result back to the lvalue's integer
                // type (C99 6.5.16.2).
                let op_is_fp = lhs_is_fp || rhs_is_fp;
                let bop = self.compound_assign_binop(binop, lhs_ty, rhs_ty, op_is_fp)?;
                self.ast_binop(bop);
                self.ty = lhs_ty;
                self.ast_assign();
                if let Some(idx) = assigned_local {
                    self.record_local_store(idx, line);
                }
                if let (Some(lhs), Some(rhs)) = (compound_lhs_ast, compound_rhs_ast) {
                    let ca_ty = self.ty;
                    self.ast_emit_compound_assign(bop, lhs, rhs, ca_ty);
                }
            } else if self.lex.tk == Token::Cond {
                let cond_ast = self.ast_acc;
                self.next()?; // consume `?`
                self.flush_pending_stores();
                // GNU conditional with omitted middle operand `a ?: b`: the
                // condition's own value is the result when nonzero. The
                // walker (`Ternary { elvis: true }`) evaluates `a` once and
                // reuses its value; the then-arm mirrors the condition so the
                // common-type conversions below apply unchanged.
                let elvis = self.lex.tk == ':';
                let mut then_ast = cond_ast;
                if !elvis {
                    self.expr(Token::Assign as i64)?;
                    then_ast = self.ast_acc;
                }
                // Comma operator in the middle of a ternary:
                // `cond ? (side_effect, value) : alt`. C99 6.5.15
                // makes the middle slot an `expression`, not an
                // assignment-expression, so a comma chain is
                // legal there. `expr(Assign)` stops at `,`; the
                // chain is resumed here so the colon search finds
                // its match. Each rhs becomes the new accumulator
                // value; the lhs side effects evaluate first.
                // Build an `Expr::Comma { lhs, rhs }` chain so the
                // walker preserves the lhs side effects; without
                // the chain, only the rhs reaches the Ternary AST
                // and the lhs's stores / calls disappear at the
                // walker tier.
                while self.lex.tk == ',' {
                    self.next()?;
                    let lhs_ast = then_ast;
                    self.expr(Token::Assign as i64)?;
                    let rhs_ast = self.ast_acc;
                    if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                        let pos = self.ast_src_pos();
                        let ty = self.ty;
                        let id = self
                            .ast
                            .push_expr(super::super::ast::Expr::Comma { lhs, rhs, ty }, pos);
                        self.ast_acc = Some(id);
                        then_ast = Some(id);
                    } else {
                        then_ast = self.ast_acc;
                    }
                }
                let then_ty = self.ty;
                if self.lex.tk == ':' {
                    self.next()?;
                } else {
                    return Err(self.compile_err("conditional missing colon"));
                }
                self.flush_pending_stores();
                self.expr(Token::Cond as i64)?;
                let mut else_ast = self.ast_acc;
                let else_ty = self.ty;
                // C99 6.5.15p5: when both arms have arithmetic type the
                // conditional's type is their usual-arithmetic-conversions
                // common type and each arm converts to it. Without the cast
                // a mixed int / floating ternary stores one arm through the
                // other arm's store kind, and mixed-signedness integer arms
                // take the wrong signedness (`c ? 1u : -1` must be the
                // zero-extended unsigned value, not sign-extended int).
                // Same-typed integer arms need no conversion.
                let mut result_ty = self.ty;
                let arith = |t: i64| !is_pointer_ty(t) && !is_struct_ty(t);
                let arms_fp = is_floating_scalar(then_ty) || is_floating_scalar(else_ty);
                let then_ptr = is_pointer_ty(then_ty);
                let else_ptr = is_pointer_ty(else_ty);
                if (arms_fp || then_ty != else_ty) && arith(then_ty) && arith(else_ty) {
                    result_ty = if arms_fp {
                        fp_result_ty(then_ty, else_ty)
                    } else {
                        self.arith_common_ty(then_ty, else_ty)
                    };
                } else if then_ptr || else_ptr {
                    // C99 6.5.15p6, in order: a null pointer constant arm
                    // takes the other arm's type; otherwise a `void*` arm
                    // against a pointer to an object type yields `void*`.
                    // The null-pointer-constant test is a value test, not a
                    // structural one -- `(void*)0` takes the other arm's
                    // type but `(void*)(x * 0)` does not, and the two are
                    // spelled alike.
                    let then_npc = then_ast.is_some_and(|e| self.expr_is_null_pointer_constant(e));
                    let else_npc = else_ast.is_some_and(|e| self.expr_is_null_pointer_constant(e));
                    let then_sp = is_struct_ty(then_ty) && struct_ptr_depth(then_ty) > 0;
                    let else_sp = is_struct_ty(else_ty) && struct_ptr_depth(else_ty) > 0;
                    // Both pointers: the null-pointer-constant arm yields the
                    // other arm's type, and a `void*` arm yields `void*`. The
                    // two rules pick the same side here, so they share an arm.
                    result_ty = if then_ptr && else_ptr && then_npc && !else_npc {
                        else_ty
                    } else if then_ptr
                        && else_ptr
                        && ((else_npc && !then_npc)
                            || (is_void_ptr_ty(then_ty) && !is_char_band_ptr_ty(else_ty)))
                    {
                        then_ty
                    } else if then_ptr
                        && else_ptr
                        && is_void_ptr_ty(else_ty)
                        && !is_char_band_ptr_ty(then_ty)
                    {
                        else_ty
                    } else if then_sp && !else_sp {
                        then_ty
                    } else if else_sp && !then_sp {
                        else_ty
                    } else if then_ptr && !else_ptr {
                        then_ty
                    } else {
                        else_ty
                    };
                }
                // Convert each arm to the conditional's result type so the
                // branch join stores both through the same width and
                // signedness (a null-constant integer arm widens to the
                // pointer result, an int arm to the common arithmetic type).
                if then_ty != result_ty && then_ast.is_some() {
                    let pos = self.ast_src_pos();
                    then_ast = Some(self.ast.push_expr(
                        super::super::ast::Expr::Cast {
                            child: then_ast.unwrap(),
                            to_ty: result_ty,
                        },
                        pos,
                    ));
                }
                if else_ty != result_ty && else_ast.is_some() {
                    let pos = self.ast_src_pos();
                    else_ast = Some(self.ast.push_expr(
                        super::super::ast::Expr::Cast {
                            child: else_ast.unwrap(),
                            to_ty: result_ty,
                        },
                        pos,
                    ));
                }
                // Build Expr::Ternary so the walker lowers the three
                // sub-expressions with a branch + phi-like join.
                if let (Some(cond), Some(then_e), Some(else_e)) = (cond_ast, then_ast, else_ast) {
                    let pos = self.ast_src_pos();
                    let id = self.ast.push_expr(
                        super::super::ast::Expr::Ternary {
                            cond,
                            then_e,
                            else_e,
                            ty: result_ty,
                            elvis,
                        },
                        pos,
                    );
                    self.ast_acc = Some(id);
                }
                self.ty = result_ty;
            } else if self.lex.tk == Token::Lor {
                let lhs_ast = self.ast_acc;
                self.next()?;
                self.flush_pending_stores();
                self.expr(Token::Lan as i64)?;
                self.reject_aggregate_binop(t, self.ty, "||")?;
                let rhs_ast = self.ast_acc;
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
                self.flush_pending_stores();
                self.expr(Token::OrOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, "&&")?;
                let rhs_ast = self.ast_acc;
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
                self.ast_psh();
                self.expr(Token::XorOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, "|")?;
                // Set the result type before building the AST binop node
                // so its `ty` is the C99 6.5.12 common type, not the
                // rhs's pre-conversion tag. The walker reads this node
                // `ty` as the cast source type, so an order-dependent tag
                // breaks `(int)(unsigned | int)` sign extension. Mirrors
                // the additive path.
                self.ty = if is_vector_ty(&self.structs, lhs_ty) {
                    lhs_ty
                } else {
                    self.arith_common_ty(lhs_ty, self.ty)
                };
                self.ast_binop(crate::c5::ir::BinOp::Or);
            } else if self.lex.tk == Token::XorOp {
                // C99 6.5.11: same common-type rule as `|`.
                let lhs_ty = t;
                self.next()?;
                self.ast_psh();
                self.expr(Token::AndOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, "^")?;
                self.ty = if is_vector_ty(&self.structs, lhs_ty) {
                    lhs_ty
                } else {
                    self.arith_common_ty(lhs_ty, self.ty)
                };
                self.ast_binop(crate::c5::ir::BinOp::Xor);
            } else if self.lex.tk == Token::AndOp {
                // C99 6.5.10: same common-type rule as `|`.
                let lhs_ty = t;
                self.next()?;
                self.ast_psh();
                self.expr(Token::EqOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, "&")?;
                self.ty = if is_vector_ty(&self.structs, lhs_ty) {
                    lhs_ty
                } else {
                    self.arith_common_ty(lhs_ty, self.ty)
                };
                self.ast_binop(crate::c5::ir::BinOp::And);
            } else if self.lex.tk == Token::EqOp || self.lex.tk == Token::NeOp {
                // `==` and `!=` share emit shape -- only the FP
                // variant and the `invert` flag handed to
                // `emit_eq_with_common_width` differ.
                let invert = self.lex.tk == Token::NeOp;
                use super::super::ir::BinOp as B;
                let (fp_op, name) = if invert {
                    (B::Fne, "!=")
                } else {
                    (B::Feq, "==")
                };
                self.next()?;
                self.ast_psh();
                self.expr(Token::LtOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, name)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, name)?;
                    self.ast_binop(fp_op);
                } else {
                    self.emit_eq_with_common_width(t, invert);
                }
                self.ty = Ty::Int as i64;
            } else if let Some(cmp) = Cmp::from_tok(self.lex.tk) {
                // All four relational ops share the same emit shape;
                // see `Cmp::ops` for the per-flavour op picks.
                let (signed_op, unsigned_op, fp_op, name) = cmp.ops();
                self.next()?;
                self.ast_psh();
                self.expr(Token::ShlOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, name)?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, name)?;
                    self.ast_binop(fp_op);
                } else if is_unsigned_ty(self.arith_common_ty(t, self.ty)) {
                    self.ast_binop(unsigned_op);
                } else {
                    self.ast_binop(signed_op);
                }
                self.ty = Ty::Int as i64;
            } else if self.lex.tk == Token::ShlOp {
                self.next()?;
                self.ast_psh();
                self.expr(Token::AddOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, "<<")?;
                // C99 6.5.7: `E1 << E2` has the type of `E1` after
                // integer promotion, not `E2` (the shift count).
                // `char` / `short` (signed or unsigned, size 1 or 2)
                // promote to signed `int`; wider operands keep their
                // type. Set the result type before building the AST
                // node so it carries the correct signedness -- a later
                // cast reads the operand's type to decide whether to
                // sign-extend.
                let lhs_size = self.size_of_type(t);
                let result_ty = if lhs_size <= 2 { Ty::Int as i64 } else { t };
                self.ty = result_ty;
                self.ast_binop(crate::c5::ir::BinOp::Shl);
                // The shift can push bits past the result type's width into
                // the 64-bit accumulator, so a 32-bit result is renormalized
                // to its declared width so a later 64-bit read (arithmetic >>,
                // widen to long) sees the right value, matching the arithmetic
                // binops. A 64-bit result is already full width.
                if self.size_of_type(result_ty) == 4 {
                    self.renormalize_to_width(result_ty);
                    self.ty = result_ty;
                }
            } else if self.lex.tk == Token::ShrOp {
                self.next()?;
                self.ast_psh();
                self.expr(Token::AddOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, ">>")?;
                // Pick logical (Shru) for unsigned LHS, arithmetic (Shr)
                // otherwise; the RHS is the shift count and does not
                // participate. C99 6.5.7p3: the result has the promoted
                // LHS type, so a 64-bit LHS keeps its width. Set the
                // type before building the AST node so the node carries
                // the result type, mirroring the `<<` path.
                let lhs_size = self.size_of_type(t);
                self.ty = if lhs_size <= 2 { Ty::Int as i64 } else { t };
                if is_unsigned_ty(t) {
                    self.ast_binop(crate::c5::ir::BinOp::Shru);
                } else {
                    self.ast_binop(crate::c5::ir::BinOp::Shr);
                }
            } else if self.lex.tk == Token::AddOp {
                self.next()?;
                // Capture the LHS's pointer-to-array stride before the
                // RHS parse moves it out of `index_stride`. `carry_stride`
                // re-seeds it after this op so chained pointer-to-array
                // arithmetic (`p + i - 1`) keeps the array size.
                let lhs_stride = self.pending.index_stride;
                let mut carry_stride: i64 = 0;
                self.ast_psh();
                self.expr(Token::MulOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, "+")?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "+")?;
                    self.ast_binop(crate::c5::ir::BinOp::Fadd);
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
                    let lhs_ty = t;
                    if self.is_ptr_scaling_nontrivial(rhs_ty) {
                        // Snapshot the AST operands before the
                        // pointer-scaling sequence: lhs (int) sits
                        // on the parser-side vstack, rhs (ptr) is
                        // in `ast_acc`. The store-local / multiply /
                        // address-of-local / load-int emit chain
                        // consumes one vstack slot per intermediate
                        // store. Drain the outer vstack, push a
                        // sentinel for the inner ops to consume,
                        // run the sequence, then restore.
                        let lhs_ast = self.ast_vstack.pop().flatten();
                        let rhs_ast = self.ast_acc.take();
                        let saved_vstack: alloc::vec::Vec<_> = self.ast_vstack.drain(..).collect();
                        self.ast_vstack.push(None);
                        // RHS is the pointer; a pointer-to-array RHS left
                        // its array stride in `end_of_expr_stride` at the
                        // RHS parse exit.
                        let scale = self.pointer_to_array_arith_stride(
                            self.pending.end_of_expr_stride,
                            rhs_ty,
                            self.pointee_size(rhs_ty),
                        );
                        if scale > self.pointee_size(rhs_ty) {
                            carry_stride = scale;
                        }
                        let rhs_temp = self.reserve_slots(1);
                        self.mark_emit_other();
                        self.emit_imm(0);
                        self.ast_binop(crate::c5::ir::BinOp::Or);
                        self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, scale);
                        self.ast_psh();
                        self.emit_lea(rhs_temp);
                        self.mark_emit_other();
                        self.ast_binop(crate::c5::ir::BinOp::Add);
                        self.ast_vstack.clear();
                        self.ast_vstack.extend(saved_vstack);
                        // Rebuild AST: `Binary { Add, Binary { Mul,
                        // lhs_int, scale }, rhs_ptr }`. Type is
                        // the pointer (C99 6.5.6p8: integer added
                        // to a pointer keeps the pointer type).
                        self.ty = rhs_ty;
                        if let (Some(lhs), Some(rhs)) = (lhs_ast, rhs_ast) {
                            let pos = self.ast_src_pos();
                            let scale_lit = self.ast.push_expr(
                                super::super::ast::Expr::IntLit {
                                    val: scale,
                                    ty: super::super::token::Ty::Int as i64,
                                },
                                pos,
                            );
                            let scaled = self.ast.push_expr(
                                super::super::ast::Expr::Binary {
                                    op: super::super::ir::BinOp::Mul,
                                    lhs,
                                    rhs: scale_lit,
                                    ty: lhs_ty,
                                },
                                pos,
                            );
                            let added = self.ast.push_expr(
                                super::super::ast::Expr::Binary {
                                    op: super::super::ir::BinOp::Add,
                                    lhs: scaled,
                                    rhs,
                                    ty: rhs_ty,
                                },
                                pos,
                            );
                            self.ast_acc = Some(added);
                        } else {
                            self.ast_acc = None;
                        }
                    } else {
                        self.ast_binop(crate::c5::ir::BinOp::Add);
                        self.ty = rhs_ty;
                    }
                } else {
                    let rhs_ty = self.ty;
                    if self.is_ptr_scaling_nontrivial(t) {
                        let scale =
                            self.pointer_to_array_arith_stride(lhs_stride, t, self.pointee_size(t));
                        if scale > self.pointee_size(t) {
                            carry_stride = scale;
                        }
                        self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, scale);
                    }
                    // Pre-compute the common type so the dual-
                    // emit binop tracker captures the result-
                    // shape `ty` rather than the rhs's pre-
                    // conversion tag.
                    if is_pointer_ty(t) {
                        self.ty = t;
                    } else {
                        self.ty = self.arith_common_ty(t, rhs_ty);
                    }
                    self.ast_binop(crate::c5::ir::BinOp::Add);
                    if !is_pointer_ty(t) {
                        self.maybe_mask_to_unsigned_width(t, rhs_ty);
                    }
                }
                // Carry the pointer-to-array stride into the next
                // arithmetic step so a chained `p + i - j` keeps the
                // array element size; a following `[` subscript or the
                // end of the expression clears it.
                if carry_stride > 1 {
                    self.pending.index_stride = carry_stride;
                }
            } else if self.lex.tk == Token::SubOp {
                self.next()?;
                let lhs_stride = self.pending.index_stride;
                let mut carry_stride: i64 = 0;
                self.ast_psh();
                self.expr(Token::MulOp as i64)?;
                self.reject_aggregate_binop(t, self.ty, "-")?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "-")?;
                    self.ast_binop(crate::c5::ir::BinOp::Fsub);
                    self.ty = fp_result_ty(t, self.ty);
                } else if is_pointer_ty(t) && self.ptr_diff_compatible(t, self.ty) {
                    // ptr - ptr -> element count (Int). Divide by
                    // the pointee size to convert raw byte distance
                    // into element distance (skipped for `char*`,
                    // where byte and element counts coincide). Both
                    // operands share the pointer-to-array stride.
                    self.ast_binop(crate::c5::ir::BinOp::Sub);
                    if self.is_ptr_scaling_nontrivial(t) {
                        let scale =
                            self.pointer_to_array_arith_stride(lhs_stride, t, self.pointee_size(t));
                        self.emit_binop_with_imm(crate::c5::ir::BinOp::Div, scale);
                    }
                    self.ty = Ty::Int as i64;
                } else if self.is_ptr_scaling_nontrivial(t) {
                    let scale =
                        self.pointer_to_array_arith_stride(lhs_stride, t, self.pointee_size(t));
                    if scale > self.pointee_size(t) {
                        carry_stride = scale;
                    }
                    self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, scale);
                    self.ast_binop(crate::c5::ir::BinOp::Sub);
                    self.ty = t;
                } else {
                    let rhs_ty = self.ty;
                    // Pre-set the post-conversion result type so
                    // the dual-emit binop tracker captures the
                    // C99 6.3.1.8 common type.
                    if is_pointer_ty(t) {
                        self.ty = t;
                    } else {
                        self.ty = self.arith_common_ty(t, rhs_ty);
                    }
                    self.ast_binop(crate::c5::ir::BinOp::Sub);
                    if !is_pointer_ty(t) {
                        self.maybe_mask_to_unsigned_width(t, rhs_ty);
                    }
                }
                if carry_stride > 1 {
                    self.pending.index_stride = carry_stride;
                }
            } else if self.lex.tk == Token::MulOp {
                self.next()?;
                self.ast_psh();
                self.expr(Token::Inc as i64)?;
                self.reject_aggregate_binop(t, self.ty, "*")?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "*")?;
                    self.ast_binop(crate::c5::ir::BinOp::Fmul);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    let rhs_ty = self.ty;
                    // Pre-compute the C99 6.3.1.8 common type so
                    // the dual-emit binop tracker (which reads
                    // `self.ty` for `Expr::Binary { ty }`) sees
                    // the post-conversion type, not the rhs's
                    // pre-conversion tag. Walker's post-op
                    // narrowing keys off `ty`.
                    self.ty = self.arith_common_ty(t, rhs_ty);
                    self.ast_binop(crate::c5::ir::BinOp::Mul);
                    self.maybe_mask_to_unsigned_width(t, rhs_ty);
                }
            } else if self.lex.tk == Token::DivOp {
                self.next()?;
                self.ast_psh();
                self.expr(Token::Inc as i64)?;
                self.reject_aggregate_binop(t, self.ty, "/")?;
                if is_floating_scalar(t) || is_floating_scalar(self.ty) {
                    self.require_both_float(t, "/")?;
                    self.ast_binop(crate::c5::ir::BinOp::Fdiv);
                    self.ty = fp_result_ty(t, self.ty);
                } else {
                    // C99 6.3.1.8: when either operand is unsigned, the
                    // common type is unsigned, so the divide is unsigned
                    // too. Route to BinOp::Divu (UDIV / DIV instead of
                    // SDIV / IDIV). When the common type is narrower
                    // than the 8-byte register, mix-of-signed-and-
                    // unsigned operands need C99 conversion to the
                    // unsigned width applied first -- otherwise a
                    // sign-extended `-1` enters the udiv as
                    // 0xFFFFFFFFFFFFFFFF instead of 0xFFFFFFFF.
                    let common = self.arith_common_ty(t, self.ty);
                    if is_unsigned_ty(common) {
                        // The masking sequence routes intermediate
                        // store-local / load-or / mask emits through
                        // the AST tracker, which would corrupt the
                        // AST vstack / accumulator. Snapshot the AST
                        // operands first, save the rest of the AST
                        // vstack, run the emit sequence against a
                        // sentinel-padded vstack so the inner
                        // unsigned-divide's embedded pop consumes
                        // the sentinel rather than an outer
                        // expression's lvalue, then rebuild the
                        // Binary node
                        // manually. The walker re-derives the
                        // masking from the operand type.
                        let lhs_ast = self.ast_vstack.pop().flatten();
                        let rhs_ast = self.ast_acc.take();
                        let saved_vstack: alloc::vec::Vec<_> = self.ast_vstack.drain(..).collect();
                        self.ast_vstack.push(None);
                        self.maybe_mask_operands_to_unsigned_common(t, self.ty);
                        self.ast_binop(crate::c5::ir::BinOp::Divu);
                        self.ast_vstack.clear();
                        self.ast_vstack.extend(saved_vstack);
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
                        // Set the result type before building the node
                        // so its `ty` is the C99 6.3.1.8 common type
                        // rather than the rhs's pre-conversion tag; the
                        // walker reads the node `ty` as the cast source
                        // type. Mirrors the multiplicative path.
                        self.ty = common;
                        self.ast_binop(crate::c5::ir::BinOp::Div);
                    }
                    self.ty = common;
                }
            } else if self.lex.tk == Token::ModOp {
                self.next()?;
                if is_floating_scalar(t) {
                    return Err(self.compile_err("`%` is not defined on floating-point operands"));
                }
                self.ast_psh();
                self.expr(Token::Inc as i64)?;
                self.reject_aggregate_binop(t, self.ty, "%")?;
                if is_floating_scalar(self.ty) {
                    return Err(self.compile_err("`%` is not defined on floating-point operands"));
                }
                let common = self.arith_common_ty(t, self.ty);
                if is_unsigned_ty(common) {
                    let lhs_ast = self.ast_vstack.pop().flatten();
                    let rhs_ast = self.ast_acc.take();
                    let saved_vstack: alloc::vec::Vec<_> = self.ast_vstack.drain(..).collect();
                    self.ast_vstack.push(None);
                    self.maybe_mask_operands_to_unsigned_common(t, self.ty);
                    self.ast_binop(crate::c5::ir::BinOp::Modu);
                    self.ast_vstack.clear();
                    self.ast_vstack.extend(saved_vstack);
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
                    // Result type before the node build, as for `/`.
                    self.ty = common;
                    self.ast_binop(crate::c5::ir::BinOp::Mod);
                }
                self.ty = common;
            } else if self.lex.tk == Token::Inc || self.lex.tk == Token::Dec {
                if let Some((lv, ety)) = self.direct_inc_lvalue()
                    && self.is_int128_ty(ety)
                {
                    let by = if self.lex.tk == Token::Inc { 1 } else { -1 };
                    let src = self.ast_src_pos();
                    self.next()?;
                    let id = self.ast.push_expr(
                        super::super::ast::Expr::PostInc {
                            lvalue: lv,
                            by,
                            ty: ety,
                        },
                        src,
                    );
                    self.ast_acc = Some(id);
                    self.ty = ety;
                    continue;
                }
                let post_inc_lvalue = self.ast_acc;
                self.rewrite_trailing_load_as_psh()
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
                self.mark_emit_other();
                self.ast_psh();
                self.emit_imm(self.pointee_step(self.ty));
                self.ast_binop(if self.lex.tk == Token::Inc {
                    super::super::ir::BinOp::Add
                } else {
                    super::super::ir::BinOp::Sub
                });
                self.ast_assign();
                self.ast_psh();
                // Pointer-to-array (`T (*p)[N]`) carries a `T*` flat
                // type; the correct step is the array's size, seeded
                // into the stride snapshot at the operand load (which
                // sits in the current scope's `index_stride` for a
                // postfix operand).
                let post_step = self.pointer_to_array_arith_stride(
                    self.pending.index_stride,
                    self.ty,
                    self.pointee_step(self.ty),
                );
                self.emit_imm(post_step);
                self.ast_binop(if self.lex.tk == Token::Inc {
                    super::super::ir::BinOp::Sub
                } else {
                    super::super::ir::BinOp::Add
                });
                // Build `Expr::PostInc { lvalue, by, ty }` so
                // the walker emits load -> binop_imm(Add, by) ->
                // store -> return the pre-update value per C99
                // 6.5.2.4p3.
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
                // GCC vector extension: `v[i]` indexes lane `i` as an
                // element-typed lvalue. The vector value carries its address on
                // the accumulator like a decayed array, so reinterpret the base
                // as a pointer to the element type and reuse the pointer-
                // subscript machinery below.
                if is_vector_ty(&self.structs, t) {
                    let elem_ty = self.structs[struct_id_of(t)].fields[0].ty;
                    t = elem_ty + Ty::Ptr as i64;
                    self.ty = t;
                }
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
                // The element subscripted by `arr[i]` keeps the array
                // element's callee parameters captured at the array decay;
                // the index expression is a separate evaluation that must
                // not consume or clear them. Park them across the parse.
                // The function-pointer decay depth is parked the same way:
                // for a function-pointer array element, a following unary
                // `*` must stay the C99 6.3.2.1p4 no-op rather than load
                // through the code address.
                let saved_callee_params = self.pending.indirect_callee_params.take();
                let saved_callee_variadic =
                    core::mem::take(&mut self.pending.indirect_callee_is_variadic);
                let saved_fn_ptr_chain = self.pending.fn_ptr_chain_depth;
                self.ast_psh();
                self.expr(Token::Assign as i64)?;
                let idx_ast = self.ast_acc;
                self.pending.indirect_callee_params = saved_callee_params;
                self.pending.indirect_callee_is_variadic = saved_callee_variadic;
                self.pending.fn_ptr_chain_depth = saved_fn_ptr_chain;
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
                if let Some(id) = self.ptr_array_id_depth1(t) {
                    // `p[i]` on a single-level pointer-to-array selects
                    // row `i` (stride = whole row) and decays to the
                    // element pointer: an address, no load (C99
                    // 6.3.2.1p3). Deeper levels take the generic path
                    // below as ordinary pointer loads.
                    let row = self.structs[id].size as i64;
                    if row > 1 {
                        self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, row);
                    }
                    self.ast_binop(crate::c5::ir::BinOp::Add);
                    self.decay_ptr_array_value(id);
                } else if multi_dim_stride > 0 {
                    self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, multi_dim_stride);
                    self.ast_binop(crate::c5::ir::BinOp::Add);
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
                        self.emit_binop_with_imm(crate::c5::ir::BinOp::Mul, scale);
                    }
                    // Re-snapshot `idx_ast` after the scale `Mul`.
                    // `emit_binop_with_imm` wrapped the earlier
                    // `idx_ast` into a fresh
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
                    self.ast_binop(crate::c5::ir::BinOp::Add);
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
                        self.mark_emit_scalar_load();
                        // The load marking cleared the function-pointer
                        // decay depth; a subscript consumes an array
                        // level, not an indirection level, so the depth
                        // parked before the index parse still applies
                        // (`(*fparr[i])()` must treat the `*` as the
                        // C99 6.3.2.1p4 no-op).
                        if saved_fn_ptr_chain >= 0 {
                            self.pending.fn_ptr_chain_depth = saved_fn_ptr_chain;
                        }
                    }
                    // Build a canonical `Expr::Index { array,
                    // idx, ty }` so the walker emits a single
                    // address+load.
                    if let (Some(array), Some(idx)) = (array_ast, idx_ast_scaled) {
                        let idx_ty = self.ty;
                        self.ast_emit_index(array, idx, idx_ty);
                    }
                }
            } else if self.lex.tk == Token::Arrow || self.lex.tk == Token::Dot {
                // p->field / s.field. Both shapes resolve a struct
                // field offset and load the field. The difference is
                // upstream: `->` runs on a struct pointer (which the
                // preceding subexpression loaded into `a` via LoadKind::I64),
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

                // A function-pointer field carries its callee parameter
                // types so a following `s.fp(args)` / `s->fp(args)` narrows
                // each argument to its declared type (C99 6.5.2.2p7). A
                // non-function-pointer field has empty params and clears the
                // channel so a stale producer's parameters cannot reach an
                // unrelated call.
                self.pending.indirect_callee_params = if field.params.is_empty() {
                    None
                } else {
                    Some(field.params.clone())
                };
                self.pending.indirect_callee_is_variadic =
                    !field.params.is_empty() && field.is_variadic;

                if field.offset > 0 {
                    self.emit_binop_with_imm(crate::c5::ir::BinOp::Add, field.offset as i64);
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
                    let is_bf_assign = self.lex.tk == Token::Assign;
                    let is_bf_compound = self.lex.tk == Token::AssignOp;
                    // Postfix `s.f++` / `s.f--` on a bitfield. The `++`
                    // sits after the member access; build an `Expr::PostInc`
                    // over the bitfield member so the walker reads the old
                    // value, stores old +/- 1, and yields the old value.
                    let is_bf_incdec = self.lex.tk == Token::Inc || self.lex.tk == Token::Dec;
                    let bf_desc = super::super::ast::BitfieldDesc {
                        bit_offset: field.bit_offset as u8,
                        bit_width: field.bit_width as u8,
                        unit_size: field.bit_unit_size,
                        // C99 6.2.5p2: `_Bool` holds only 0 or 1, so a
                        // `_Bool` bitfield is unsigned even at width 1,
                        // where a signed 1-bit field reads its set bit
                        // back as -1.
                        signed: !is_unsigned_ty(field.ty) && !is_bool_ty(field.ty),
                    };
                    let bf_field_off = field.offset as i64;
                    let bf_field_ty = field.ty;
                    self.pending.bf_assign_rhs = None;
                    self.pending.bf_compound_assign = None;
                    // emit_bitfield_access drives the c5 stack
                    // through several Psh/Si rounds that the
                    // AST-tracking layer treats as a normal
                    // assignment chain. Snapshot the parser-side
                    // vstack depth + clear ast_acc so the AST
                    // side stays in lockstep: the helpers below
                    // pop the leftover slots back off, and the
                    // dedicated dual-emit for the bitfield
                    // produces the only AST node this site needs.
                    let bf_vstack_depth = self.ast_vstack.len();
                    self.emit_bitfield_access(field.bit_offset, field.bit_width, field.ty)?;
                    if self.ast_vstack.len() > bf_vstack_depth {
                        self.ast_vstack.truncate(bf_vstack_depth);
                    }
                    self.ast_acc = None;
                    // Build the AST shape now that the
                    // bitfield-emit helper has run.
                    if let Some(obj) = obj_ast {
                        if is_bf_assign {
                            // The rhs was parsed inside
                            // `emit_bitfield_access` (self.expr).
                            // Its top-level AST id was stashed in
                            // `pending.bf_assign_rhs` ahead of the
                            // storage emit (whose `ast_apply_assign`
                            // would otherwise have cleared
                            // `ast_acc`).
                            if let Some(rhs) = self.pending.bf_assign_rhs.take() {
                                let res_ty = self.ty;
                                self.ast_emit_bitfield_assign(
                                    obj,
                                    bf_field_off,
                                    bf_desc,
                                    rhs,
                                    res_ty,
                                );
                            }
                        } else if is_bf_compound {
                            // C99 6.5.16.2: `E1 OP= E2` is
                            // equivalent to `E1 = E1 OP E2` with
                            // E1 evaluated once. Synthesise the
                            // equivalent AST tree here so the
                            // walker reproduces the same
                            // load-clear-shift-or-store sequence
                            // as a plain bitfield assignment.
                            if let Some((rhs, ir_op)) = self.pending.bf_compound_assign.take() {
                                let src = self.ast_src_pos();
                                let read = self.ast.push_expr(
                                    super::super::ast::Expr::Member {
                                        obj,
                                        field_off: bf_field_off,
                                        bitfield: Some(bf_desc),
                                        ty: bf_field_ty,
                                        array_size: 0,
                                    },
                                    src,
                                );
                                let combined = self.ast.push_expr(
                                    super::super::ast::Expr::Binary {
                                        op: ir_op,
                                        lhs: read,
                                        rhs,
                                        ty: bf_field_ty,
                                    },
                                    src,
                                );
                                let res_ty = self.ty;
                                self.ast_emit_bitfield_assign(
                                    obj,
                                    bf_field_off,
                                    bf_desc,
                                    combined,
                                    res_ty,
                                );
                            }
                        } else if is_bf_incdec {
                            // Postfix `s.f++` / `s.f--`. The member-access
                            // helper above ran in read mode and left the
                            // `++` / `--` token; consume it here and build
                            // an `Expr::PostInc` over the bitfield member.
                            let by = if self.lex.tk == Token::Inc { 1 } else { -1 };
                            self.next()?;
                            let src = self.ast_src_pos();
                            let lvalue = self.ast.push_expr(
                                super::super::ast::Expr::Member {
                                    obj,
                                    field_off: bf_field_off,
                                    bitfield: Some(bf_desc),
                                    ty: bf_field_ty,
                                    array_size: 0,
                                },
                                src,
                            );
                            let id = self.ast.push_expr(
                                super::super::ast::Expr::PostInc {
                                    lvalue,
                                    by,
                                    ty: bf_field_ty,
                                },
                                src,
                            );
                            self.ast_acc = Some(id);
                        } else {
                            // Read path: dual-emit
                            // `Expr::Member { bitfield: Some(_) }`
                            // so the walker emits the
                            // load + shift + mask + sign-extend
                            // sequence at the surrounding rvalue
                            // site.
                            self.ast_emit_member(obj, bf_field_off, Some(bf_desc), bf_field_ty, 0);
                        }
                    }
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
                    if field.array_size != 0 {
                        self.ty += Ty::Ptr as i64;
                        if field.array_size > 0 {
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
                        } else {
                            // A flexible array member (`array_size == -1`,
                            // C99 6.7.2.1p16) is an incomplete array type,
                            // distinct from the decayed element pointer.
                            // Signal array-ness to a surrounding `typeof` /
                            // `__builtin_types_compatible_p` with the `-1`
                            // sentinel (its element count is genuinely
                            // unknown, which the `> 0` recovery paths read as
                            // "no array hint"), mirroring the zero-length
                            // array variable path.
                            self.pending.last_array_decay_size = -1;
                        }
                    } else if !field_is_struct_value {
                        self.mark_emit_scalar_load();
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
                    self.ast_emit_member(obj, field.offset as i64, None, mty, field.array_size);
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

    /// C99 6.3.2.1p3 at the last level of a pointer-to-array: the
    /// value already holds the array's address, so the "dereference"
    /// decays to the element pointer without a load. Retags `self.ty`
    /// to the element pointer, seeds the remaining-dimension stride
    /// queue for the following subscripts, and surfaces the row byte
    /// count for an enclosing `sizeof`. `id` is the array aggregate's
    /// struct id (see `ptr_array_id_depth1`).
    fn decay_ptr_array_value(&mut self, id: usize) {
        let f = &self.structs[id].fields[0];
        let elem_ty = f.ty;
        let dims: alloc::vec::Vec<i64> = if f.array_dims.len() >= 2 {
            f.array_dims.clone()
        } else {
            alloc::vec![f.array_size]
        };
        let elem_size = self.size_of_type(elem_ty) as i64;
        self.seed_multi_dim_strides(&dims, elem_size);
        self.pending.last_array_decay_bytes = self.structs[id].size as i64;
        self.ty = elem_ty + Ty::Ptr as i64;
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

    /// C11 6.5.1.1 generic selection
    /// `_Generic(controlling-expr, T1: e1, ..., default: eN)`. The
    /// controlling expression is unevaluated; its type selects the
    /// association with a compatible type name, or the `default`
    /// association when none matches. The value and type of the whole
    /// construct are those of the selected expression; the non-selected
    /// expressions are not evaluated.
    ///
    /// The controlling expression is parsed only for its type (its
    /// emitted state is rewound). The association list is scanned by
    /// bracket depth without parsing the expressions, so only the
    /// selected one is parsed live -- via a lexer snapshot taken at its
    /// start and restored once the winner is known.
    pub(super) fn parse_generic_selection(&mut self) -> Result<(), C5Error> {
        let after = self.generic_select_to_winner()?;
        // Parse the selected expression live; it is the result.
        self.expr(Token::Assign as i64)?;
        self.lex.restore(after);
        Ok(())
    }

    /// Shared front half of `_Generic` for the runtime and constant
    /// paths. Consumes `_Generic ( controlling , assoc-list )`, selects
    /// the association, and leaves the lexer positioned at the selected
    /// expression's first token so the caller can parse it with either
    /// the runtime or the constant grammar. Returns the lexer snapshot
    /// just past the closing `)`, to restore after parsing the winner.
    pub(super) fn generic_select_to_winner(
        &mut self,
    ) -> Result<super::super::lexer::LexerSnapshot, C5Error> {
        self.next()?; // _Generic
        self.consume(b'(', "`(` expected after `_Generic`")?;

        // The lexer appends string-literal bytes to the data section as
        // it tokenizes; scanning the non-selected associations therefore
        // pollutes the data section. Record the length so it can be
        // rewound before the selected expression is parsed live.
        let data_start = self.data.len();

        // Controlling expression: recover its type, discard everything
        // the parse pushed (unevaluated per 6.5.1.1p2).
        let saved_text_len = self.next_ent_pc;
        let saved_reloc = self.code_reloc_sym_idx.len();
        let saved_ast_acc = self.ast_acc;
        let saved_vstack = self.ast_vstack.len();
        self.expr(Token::Assign as i64)?;
        let ctrl_ty = self.ty;
        self.next_ent_pc = saved_text_len;
        self.clear_recent_emits();
        self.code_reloc_sym_idx.truncate(saved_reloc);
        self.ast_acc = saved_ast_acc;
        self.ast_vstack.truncate(saved_vstack);
        self.consume(b',', "`,` expected after `_Generic` controlling expression")?;

        // Scan the association list. A type match wins over `default`
        // regardless of order (6.5.1.1p3: at most one type may match).
        // The snapshot is taken at the `:`, before the expression's
        // first token is lexed, so restoring and re-lexing appends its
        // string data cleanly after the rewind below.
        let mut winner = None;
        let mut default_assoc = None;
        loop {
            if self.lex.tk == Token::Default {
                self.next()?; // default
                if default_assoc.is_none() {
                    default_assoc = Some(self.lex.snapshot());
                }
                self.consume(b':', "`:` expected after `default`")?;
            } else {
                let (assoc_ty, _) = self.parse_generic_type_name()?;
                let is_match = winner.is_none() && generic_type_match(ctrl_ty, assoc_ty);
                if is_match {
                    winner = Some(self.lex.snapshot());
                }
                self.consume(b':', "`:` expected after generic association type")?;
            }
            self.skip_generic_assoc_expr()?;
            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            break;
        }
        self.consume(b')', "`)` expected to close `_Generic`")?;
        let after = self.lex.snapshot();

        let Some(chosen) = winner.or(default_assoc) else {
            return Err(self.compile_err("no `_Generic` association matches the controlling type"));
        };
        // Drop the data the scan appended, then position at the selected
        // association's `:`; the following `next` re-lexes its first
        // token, appending any string data at `data_start`.
        self.data.truncate(data_start);
        self.lex.restore(chosen);
        self.next()?; // the `:` -> the expression's first token
        Ok(after)
    }

    /// Parse `__builtin_types_compatible_p ( type-name , type-name )`
    /// (GCC) and return 1 when the two type names are compatible (flat
    /// tags equal after dropping top-level qualifiers), else 0. The
    /// leading keyword has been consumed.
    pub(super) fn parse_types_compatible_p(&mut self) -> Result<i64, C5Error> {
        self.consume(b'(', "`(` expected after `__builtin_types_compatible_p`")?;
        let (a, a_dims) = self.parse_generic_type_name()?;
        self.consume(b',', "`,` expected between type names")?;
        let (b, b_dims) = self.parse_generic_type_name()?;
        self.consume(b')', "`)` expected after `__builtin_types_compatible_p`")?;
        // C99 6.7.6.2: an array type and a pointer type are never
        // compatible, even when the element / pointee coincide -- the flat
        // type collapses both to the element pointer, so the recorded
        // dimensions carry the array-vs-pointer distinction a compile-time
        // element-count macro depends on.
        Ok((generic_type_match(a, b) && array_dims_match(&a_dims, &b_dims)) as i64)
    }

    /// Parse `__builtin_offsetof ( type-name , member-designator )` (GCC /
    /// C11, what `offsetof` may expand to) and return the member's byte
    /// offset. The leading keyword has been consumed. The member designator
    /// is an identifier followed by a chain of `.field` and `[constant]`
    /// steps (C11 7.19). The offset is a compile-time constant.
    /// Parse `__builtin_offsetof(T, member-designator)`. Returns `Some(off)`
    /// when the whole designator folds to a constant byte offset. A GCC
    /// extension allows a non-constant array subscript (`m[i]` with runtime
    /// `i`); when `allow_runtime` is set and such a subscript appears, the
    /// offset `const_base + i * stride` is emitted onto the accumulator (value
    /// stack + AST) as a `size_t` and `None` is returned. In a constant
    /// context `allow_runtime` is false and a runtime subscript is an error.
    pub(super) fn parse_builtin_offsetof(
        &mut self,
        allow_runtime: bool,
    ) -> Result<Option<i64>, C5Error> {
        use super::super::ir::BinOp;
        self.consume(b'(', "`(` expected after `__builtin_offsetof`")?;
        let (ty, _) = self.parse_generic_type_name()?;
        if !is_struct_ty(ty) || struct_ptr_depth(ty) != 0 {
            return Err(self.compile_err("`__builtin_offsetof` requires a struct or union type"));
        }
        self.consume(b',', "`,` expected after the `__builtin_offsetof` type")?;
        // Resolve the leading member and then each `.field` / `[index]` step,
        // accumulating the byte offset. `cur_ty` / `cur_dims` track the
        // element type and remaining array dimensions of the current member.
        let field_dims = |f: &super::StructField| -> alloc::vec::Vec<i64> {
            if !f.array_dims.is_empty() {
                f.array_dims.clone()
            } else if f.array_size > 0 {
                alloc::vec![f.array_size]
            } else {
                alloc::vec![]
            }
        };
        let mut offset: i64 = 0;
        // Set once a non-constant subscript has been emitted onto the
        // accumulator; the constant `offset` is added to it at the end.
        let mut have_runtime = false;
        let mut sid = struct_id_of(ty);
        let f = self.offsetof_member(sid)?;
        offset += f.offset as i64;
        let mut cur_ty = f.ty;
        let mut cur_dims = field_dims(&f);
        loop {
            if self.lex.tk == Token::Dot {
                self.next()?;
                if !cur_dims.is_empty() || !is_struct_ty(cur_ty) || struct_ptr_depth(cur_ty) != 0 {
                    return Err(
                        self.compile_err("`.` in `__builtin_offsetof` on a non-struct member")
                    );
                }
                sid = struct_id_of(cur_ty);
                let f = self.offsetof_member(sid)?;
                offset += f.offset as i64;
                cur_ty = f.ty;
                cur_dims = field_dims(&f);
            } else if self.lex.tk == Token::Brak {
                self.next()?;
                // Row stride: the product of the dimensions below this one
                // times the element size. A flexible / zero-length trailing
                // array (`UINT8 Data[0]`, which edk2 subscripts as `Data[i]`
                // in offsetof) records no dimension, but its element is the
                // field type, so the stride is that element's size.
                let inner: i64 = if cur_dims.is_empty() {
                    1
                } else {
                    cur_dims[1..].iter().product::<i64>().max(1)
                };
                let stride = inner * self.size_of_type(cur_ty) as i64;
                match self.try_parse_constant_dim()? {
                    Some(idx) => offset += idx * stride,
                    None => {
                        // GCC extension: a runtime array subscript. The offset
                        // is `const_base + i * stride`, a runtime value.
                        if !allow_runtime {
                            return Err(self.compile_err(
                                "constant integer expected in `__builtin_offsetof` subscript",
                            ));
                        }
                        if have_runtime {
                            return Err(self.compile_err(
                                "`__builtin_offsetof` supports at most one runtime array subscript",
                            ));
                        }
                        self.expr(Token::Assign as i64)?;
                        self.emit_binop_with_imm(BinOp::Mul, stride);
                        have_runtime = true;
                    }
                }
                self.consume(b']', "`]` expected after `__builtin_offsetof` subscript")?;
                if !cur_dims.is_empty() {
                    cur_dims.remove(0);
                }
            } else {
                break;
            }
        }
        self.consume(b')', "`)` expected after `__builtin_offsetof`")?;
        if have_runtime {
            if offset != 0 {
                self.emit_binop_with_imm(BinOp::Add, offset);
            }
            self.ty = self.size_t_ty();
            return Ok(None);
        }
        Ok(Some(offset))
    }

    /// Consume one member name and return its `StructField` in struct `sid`.
    fn offsetof_member(&mut self, sid: usize) -> Result<super::StructField, C5Error> {
        if self.lex.tk != Token::Id {
            return Err(self.compile_err("member name expected in `__builtin_offsetof`"));
        }
        let name = self.symbols[self.lex.curr_id_idx].name.clone();
        self.next()?;
        self.structs[sid]
            .fields
            .iter()
            .find(|f| f.name == name)
            .cloned()
            .ok_or_else(|| {
                self.compile_err(format!(
                    "struct {} has no member {name}",
                    self.structs[sid].name
                ))
            })
    }

    /// Parse a `_Generic` association type name: a base type plus any
    /// abstract pointer and array decoration, matching the
    /// `typeof(type-name)` surface. Returns the flat type tag and the
    /// array dimensions outermost first, `-1` for an unspecified bound
    /// (`T []`). An empty dimension list means the type name is not an
    /// array.
    fn parse_generic_type_name(&mut self) -> Result<(i64, alloc::vec::Vec<i64>), C5Error> {
        self.pending.typeof_operand_was_array = false;
        let mut ty = self.parse_decl_base_type()?;
        // `typeof(arr)` and an array typedef leave the operand's extent on
        // the carrier; a multi-dimensional alias also fills the dims list.
        let base_extent = core::mem::take(&mut self.pending.typedef_base_array_size);
        let base_dims = core::mem::take(&mut self.pending.typedef_base_array_dims);
        let mut dims = if !self.pending.typeof_operand_was_array {
            alloc::vec::Vec::new()
        } else if !base_dims.is_empty() {
            base_dims
        } else {
            alloc::vec![if base_extent > 0 { base_extent } else { -1 }]
        };
        while self.lex.tk == Token::MulOp {
            self.next()?;
            ty += Ty::Ptr as i64;
            // A pointer through the specifier names a pointer, not an
            // array; the extent belongs to the pointee.
            dims.clear();
            while self.lex.tk == Token::TypeQual {
                self.next()?;
            }
        }
        // Abstract array declarator `T []` / `T [N]` (C99 6.7.6). An
        // omitted bound is an incomplete array type, which C99 6.7.5.2p6
        // makes compatible with any bound for the same element type.
        while self.lex.tk == Token::Brak {
            self.next()?;
            let n = if self.lex.tk == ']' {
                -1
            } else {
                let n = self.parse_constant_int()?;
                if n < 0 {
                    return Err(
                        self.compile_err("array dimension in a type name must not be negative")
                    );
                }
                n
            };
            if self.lex.tk != ']' {
                return Err(self.compile_err("close bracket expected in an array type name"));
            }
            self.next()?;
            dims.push(n);
        }
        Ok((ty, dims))
    }

    /// Advance the lexer past one generic association's expression to
    /// the terminating top-level `,` or `)`, tracking bracket depth so
    /// commas and parens inside the expression do not end the scan.
    fn skip_generic_assoc_expr(&mut self) -> Result<(), C5Error> {
        let mut depth = 0i32;
        loop {
            let tk = self.lex.tk;
            if depth == 0 && (tk == ',' || tk == ')') {
                return Ok(());
            }
            // The lexer emits `Token::Brak` for a subscript `[` (not the
            // raw `[` byte), so an arm containing `&x[i]` must count it or
            // the bracket depth unbalances and the scan stops at the wrong
            // `)` / `,`.
            if tk == '(' || tk == '[' || tk == Token::Brak || tk == '{' {
                depth += 1;
            } else if tk == ')' || tk == ']' || tk == '}' {
                depth -= 1;
            }
            self.next()?;
        }
    }
}

/// C11 6.5.1.1p2 type match for a generic association: compare the flat
/// type tags after dropping the qualifier bits. `unsigned`-ness and the
/// pointer level / aggregate identity stay significant so
/// `unsigned int` and `T *` select distinct associations.
fn generic_type_match(ctrl: i64, assoc: i64) -> bool {
    (ctrl & !super::types::VOLATILE_BIT) == (assoc & !super::types::VOLATILE_BIT)
}

/// C99 6.7.5.2p6 array compatibility: two array types are compatible when
/// they have the same rank and, for each dimension where both bounds are
/// specified, the bounds agree. An unspecified bound (`-1`) matches any.
/// A rank mismatch also covers array-vs-non-array, since a non-array type
/// name has rank 0. The flat type tag does not carry the element type of
/// an inner dimension, so the rank comparison stands in for it: `int[2][3]`
/// and `int[]` differ in rank and are correctly incompatible.
fn array_dims_match(a: &[i64], b: &[i64]) -> bool {
    a.len() == b.len() && a.iter().zip(b).all(|(x, y)| *x < 0 || *y < 0 || x == y)
}

/// Map an atomic-operation [`Intrinsic`](crate::c5::op::Intrinsic)
/// discriminant to its AST [`AtomicKind`](super::super::ast::AtomicKind).
/// Returns `None` for any non-atomic intrinsic. The `#pragma intrinsic`
/// registry stores the atomic operations under these discriminants; the
/// call site converts them here for `parse_atomic_builtin`.
fn atomic_kind_from_intrinsic(id: i64) -> Option<super::super::ast::AtomicKind> {
    use super::super::ast::AtomicKind;
    use crate::c5::op::Intrinsic;
    Some(match Intrinsic::from_i64(id)? {
        Intrinsic::AtomicLoad => AtomicKind::Load,
        Intrinsic::AtomicStore => AtomicKind::Store,
        Intrinsic::AtomicExchange => AtomicKind::Exchange,
        Intrinsic::AtomicFetchAdd => AtomicKind::FetchAdd,
        Intrinsic::AtomicFetchSub => AtomicKind::FetchSub,
        Intrinsic::AtomicFetchAnd => AtomicKind::FetchAnd,
        Intrinsic::AtomicFetchOr => AtomicKind::FetchOr,
        Intrinsic::AtomicFetchXor => AtomicKind::FetchXor,
        Intrinsic::AtomicCompareExchangeStrong => AtomicKind::CompareExchangeStrong,
        _ => return None,
    })
}

/// Argument count for each atomic operation: the object pointer
/// plus the operation's value / expected / desired operands.
fn atomic_arity(kind: super::super::ast::AtomicKind) -> usize {
    use super::super::ast::AtomicKind;
    match kind {
        AtomicKind::Load => 1,
        AtomicKind::CompareExchangeStrong => 3,
        _ => 2,
    }
}
