//! `Ast` -> `FunctionSsa` walker.
//!
//! Drives `SsaBuilder` from a per-function AST. The walker is the
//! production SSA source for every parsed function. An AST shape
//! the walker can't lower comes back as `WalkError` so the
//! caller (`codegen::ssa::shadow::produce_ssa_funcs`) can surface
//! the offending node.
//!
//! This module holds the walk context and the error type; each
//! submodule lowers one part of the grammar.

#![allow(dead_code)]

use alloc::string::String;

use super::super::codegen::ssa::build::SsaBuilder;
use super::super::codegen::{
    ArgPlacement, LongDoubleKind, Target, effective_fp_arg_mask, offset_align, plan_param_regs_aggs,
};
use super::super::compiler::types::{
    STRUCT_BASE, STRUCT_STRIDE, Segment, UNSIGNED_BIT, is_long_double_scalar, is_pointer_ty,
    is_struct_ty, is_struct_value_ty, is_unsigned_ty, is_vector_ty, is_volatile_object_ty,
    is_volatile_ty, load_kind, segment_of_object_ty, strip_unsigned, struct_id_of,
    struct_ptr_depth,
};
use super::super::ir::{
    AsmSeg, AtomicRmwOp, BinOp, BlockId, FpCastKind, FunctionSsa, LoadKind, StoreKind, ValueId,
};
use super::super::op::Intrinsic;
use super::super::symbol::Symbol;
use super::super::token::{Token, Ty};
use super::{
    Ast, AtomicKind, BitfieldDesc, BlockItem, Decl, DeclId, Expr, ExprId, FinishedFunction,
    LabelId, LocalInit, LocalInitPrelude, MAX_MEM_FILL_ACCESSES, MemTransferOp, RuntimeInitValue,
    SLOT_ALIGN, ShortCircuitOp, Stmt, StmtId, UnOp, bitfield_slice_mask, mem_transfer_accesses,
    mem_transfer_chunks,
};

mod access;
mod atomic;
mod bitfield;
mod builtin;
mod decl;
mod expr;
mod function;
mod int128;
mod stmt;
#[cfg(test)]
mod tests;
mod types;
mod vector;

pub(crate) use function::walk_function;
pub(crate) use types::{expr_ty, fold_int_binop, imm_safe_binop, is_comparison_op};

/// The low and high 64-bit halves of a 128-bit value, in that order.
type Halves = (ValueId, ValueId);

/// A shape the walker does not lower. The `Unsupported` variants are
/// deliberate rejections of constructs the target or the backend does not
/// provide, reachable from valid input; the `Invalid` variants mean an
/// invariant the front end establishes did not hold, and carry the AST
/// node so the gap can be routed back to a parser site.
#[derive(Debug)]
pub(crate) enum WalkError {
    UnsupportedExpr { id: ExprId, kind: &'static str },
    Unsupported(&'static str),
    InvalidExpr { id: ExprId, kind: &'static str },
    InvalidStmt { id: StmtId, kind: &'static str },
    UnknownSymbolClass { sym: u32, class: i64 },
}

impl core::fmt::Display for WalkError {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        match self {
            WalkError::UnsupportedExpr { kind, .. } => write!(f, "{kind}"),
            WalkError::Unsupported(reason) => write!(f, "{reason}"),
            WalkError::InvalidExpr { id, kind } => {
                write!(f, "ast::walk: expression #{id} ({kind}) not handled")
            }
            WalkError::InvalidStmt { id, kind } => {
                write!(f, "ast::walk: statement #{id} ({kind}) not handled")
            }
            WalkError::UnknownSymbolClass { sym, class } => {
                let named = [
                    (Token::Loc, "Loc"),
                    (Token::Glo, "Glo"),
                    (Token::Fun, "Fun"),
                    (Token::Sys, "Sys"),
                ]
                .iter()
                .find(|(t, _)| *t as i64 == *class)
                .map(|(_, n)| *n);
                match named {
                    Some(n) => write!(
                        f,
                        "ast::walk: symbol #{sym} has class {n}, which takes no address here"
                    ),
                    None => write!(
                        f,
                        "ast::walk: symbol #{sym} class {class} not recognised \
                         (expected one of Loc, Glo, Fun, Sys)"
                    ),
                }
            }
        }
    }
}

impl WalkError {
    pub(crate) fn into_string(self) -> String {
        alloc::format!("{self}")
    }

    /// `true` when the error reports a broken compiler invariant rather
    /// than a construct the target does not provide. Only these carry the
    /// `internal compiler error` marker.
    pub(crate) fn is_internal(&self) -> bool {
        matches!(
            self,
            WalkError::InvalidExpr { .. }
                | WalkError::InvalidStmt { .. }
                | WalkError::UnknownSymbolClass { .. }
        )
    }
}

/// Resolution result for a `Token::Glo` address producer.
/// `Resolved(off)` selects `Inst::ImmData(off)`; `Extern`
/// selects `Inst::ImmData(0)` plus an entry in
/// `FunctionSsa::extern_imm_data_refs` so the linker patches
/// the slot from the merged symbol table.
#[derive(Clone, Copy)]
enum GloAddr {
    Resolved(i64),
    Extern,
}

/// A C99 6.6p9 address constant: a static-storage object plus a byte
/// offset into it. `base` is the naming identifier's symbol index and
/// its parse-time data offset, which together identify the object.
#[derive(Clone, Copy, PartialEq, Eq)]
struct AddrConst {
    base: (u32, i64),
    off: i64,
}

/// Per-walk context. Mutable so the walker can stack break /
/// continue targets across nested loops + switches and intern
/// `LabelId -> BlockId` for cross-stmt gotos.
struct Walker<'a> {
    ast: &'a Ast,
    symbols: &'a [Symbol],
    structs: &'a [crate::c5::compiler::StructDef],
    target: Target,
    /// Stack of `(break_target, continue_target)` block ids, one
    /// frame per enclosing loop / switch. Break/Continue stmts
    /// jump to the top-of-stack entries.
    loop_ctx: alloc::vec::Vec<(BlockId, BlockId)>,
    /// SSA `BlockId` reserved for each AST label's body, indexed by
    /// `LabelId` (dense over the function's `Ast::goto_targets`).
    /// Filled lazily by either a Goto's forward reference or the
    /// matching Labeled stmt -- both sides see the same block.
    label_blocks: alloc::vec::Vec<Option<BlockId>>,
    /// Per enclosing `switch` (innermost last): the block reserved for
    /// each `case` value and for `default`. A `case` / `default` marker
    /// reached while walking the switch body jumps to its block, so the
    /// dispatcher can target it wherever it sits -- including inside a
    /// loop nested in the switch (C99 6.8.4.2 admits a case label at any
    /// depth; the loop's back edge re-enters the body at its first case
    /// block). The blocks are allocated once by the case-collection pass
    /// before the dispatcher emits.
    #[allow(clippy::type_complexity)]
    switch_dispatch: alloc::vec::Vec<(
        alloc::vec::Vec<(i64, BlockId)>,
        alloc::vec::Vec<(i64, i64, BlockId)>,
        Option<BlockId>,
    )>,
    /// True when the function's declared return type is a struct
    /// value returned through the c5 out-pointer convention. `return
    /// s;` loads the hidden out-pointer from `slot 2`, Mcpy
    /// `return_struct_size` bytes from `s`'s address into it, then
    /// returns the out-pointer. False for host-ABI returns.
    returns_struct: bool,
    /// Byte size of the struct return type when the function returns
    /// a struct by any convention. Zero otherwise.
    return_struct_size: i64,
    /// AAPCS64 register return (aggregate <= 16 bytes): `return s;`
    /// yields `s`'s address; the codegen scatters the eightbytes into
    /// x0/x1.
    ret_in_regs: bool,
    /// AAPCS64 indirect return (aggregate > 16 bytes via x8): `return
    /// s;` copies the value through the saved x8 pointer in
    /// `indirect_result_slot`, then returns that pointer.
    ret_indirect: bool,
    /// The function's declared scalar return type (C99 6.8.6.4). A
    /// `char` / `short` return is narrowed to this width before
    /// `Terminator::Return`.
    scalar_return_ty: i64,
    /// Body-local slot holding the saved x8 indirect-result pointer
    /// when `ret_indirect` is true; zero otherwise.
    indirect_result_slot: i64,
    /// True when the SSA optimization passes will run on this walk's
    /// output. A deferred `__builtin_constant_p` then lowers to
    /// `Intrinsic::ConstantP` for the post-inline folds; otherwise it
    /// resolves to 0 here, keeping the front-end constant-condition
    /// fold (and the emitted code) identical to the early answer.
    optimize: bool,
    /// A dense switch may lower to `Terminator::JumpTable`. Clear under
    /// `-fno-jump-tables`, which leaves every switch on the compare
    /// tree so the dispatch takes no indirect branch.
    jump_tables: bool,
}

impl<'a> Walker<'a> {
    /// The symbol's live function entity, if it holds one: a
    /// `Token::Fun` binding, or a scoped function declaration whose
    /// name binding was unwound at scope exit (class back to 0) while
    /// the entity -- `val`, prototype, linkage -- stayed on the slot.
    fn live_fun_sym(&self, sym: u32) -> Option<&crate::c5::symbol::Symbol> {
        self.symbols.get(sym as usize).filter(|s| s.is_fun_entity())
    }

    /// Live `ent_pc` for a function symbol. Reading the
    /// symbol's current `val` lets every `Expr::Call` resolve to
    /// the matching `pc_to_native` slot the codegen will
    /// populate. Sys trampolines have their `val` patched late
    /// by `emit_sys_trampolines`; the same live-read fits both
    /// cases.
    fn live_fun_val(&self, sym: u32, fallback_val: i64) -> i64 {
        self.live_fun_sym(sym).map_or(fallback_val, |s| s.val)
    }

    /// Live `ent_pc` for a function symbol whose *address* is being
    /// taken. An inline definition provides no external definition, so
    /// its identifier resolves through the import placeholder and the
    /// address denotes the program's one definition (C99 6.2.2p2); every
    /// other function addresses its own `val`, as a call does.
    fn live_fun_addr_val(&self, sym: u32, fallback_val: i64) -> i64 {
        match self.live_fun_sym(sym).and_then(|s| s.inline_addr_pc) {
            Some(pc) => pc,
            None => self.live_fun_val(sym, fallback_val),
        }
    }

    /// True when the function symbol is a variadic function. A
    /// variadic c5 callee keeps the c5 cdecl stack-push argument
    /// shape, so its floating-point arguments ride the integer
    /// register class as widened doubles rather than the FP bank.
    fn fun_is_variadic(&self, sym: u32) -> bool {
        self.live_fun_sym(sym).is_some_and(|s| s.is_variadic)
    }

    /// Count of named (pre-ellipsis) parameters the function
    /// symbol declares. The parser records the prototype's fixed
    /// parameter types in `Symbol::params`; a variadic callee's
    /// arguments past this count are the variadic tail. Used to
    /// split the call's arguments into the fixed (register-bank)
    /// prefix and the variadic (host-stack) tail for the macOS
    /// arm64 variadic ABI.
    fn fun_fixed_args(&self, sym: u32) -> usize {
        self.live_fun_sym(sym).map_or(0, |s| s.params.len())
    }

    /// Resolve an indirect call's callee expression to the pointed-to
    /// function's `(is_variadic, fixed_arg_count)`. Three statically-
    /// typed callee shapes carry the prototype:
    ///   * a direct function name taken as a pointer (`Token::Fun`),
    ///   * a function-pointer variable whose declaration inherited the
    ///     prototype from a function-pointer typedef,
    ///   * the right operand of a comma operator (the `(side, fn)`
    ///     shape), resolved recursively.
    /// A callee with no statically-known prototype defaults to
    /// non-variadic with every argument fixed (`arg_count`), which
    /// keeps the host-ABI placement identical to a plain call.
    fn indirect_callee_proto(&self, callee: ExprId, arg_count: usize) -> (bool, usize) {
        // A variadic callee whose prototype was not recoverable from its
        // symbol -- a struct-field, array-element, or dereferenced
        // function pointer -- is recorded at parse time with its fixed
        // (pre-ellipsis) parameter count, keyed by the callee ExprId.
        if let Some(&(_, fixed)) = self
            .ast
            .variadic_indirect_callees
            .iter()
            .find(|(c, _)| *c == callee)
        {
            return (true, fixed as usize);
        }
        match self.ast.expr(callee) {
            Expr::Ident { sym, .. } => {
                let idx = *sym as usize;
                if idx < self.symbols.len() && self.symbols[idx].is_variadic {
                    (true, self.symbols[idx].params.len())
                } else {
                    (false, arg_count)
                }
            }
            Expr::Comma { rhs, .. } => self.indirect_callee_proto(*rhs, arg_count),
            _ => (false, arg_count),
        }
    }

    /// Calling convention the callee of a call expression follows,
    /// whether it names a function directly or goes through a pointer.
    /// Every ABI question the call site asks -- argument placement,
    /// aggregate argument and return classification, the variadic
    /// dialect -- is asked of this, not of the target's own convention.
    fn callee_conv(&self, callee: ExprId) -> crate::c5::codegen::CallConv {
        if let Expr::Ident { sym, class, .. } = self.ast.expr(callee)
            && *class == Token::Fun as i64
            && let Some(s) = self.symbols.get(*sym as usize)
            && s.conv != crate::c5::codegen::CallConv::Target
        {
            return s.conv;
        }
        self.indirect_callee_conv(callee)
    }

    /// Calling convention the pointed-to function of an indirect call
    /// follows. Recorded at parse time on the callee's `ExprId` when the
    /// declared type carries `__attribute__((ms_abi))` /
    /// `((sysv_abi))`; the entry is already normalised against the
    /// target, so anything listed differs from the target's own.
    fn indirect_callee_conv(&self, callee: ExprId) -> crate::c5::codegen::CallConv {
        if let Some(&(_, conv)) = self
            .ast
            .conv_indirect_callees
            .iter()
            .find(|(c, _)| *c == callee)
        {
            return conv;
        }
        match self.ast.expr(callee) {
            Expr::Comma { rhs, .. } => self.indirect_callee_conv(*rhs),
            _ => crate::c5::codegen::CallConv::Target,
        }
    }

    /// Resolve a `Token::Glo` address producer to either an
    /// intra-unit data offset or a cross-TU symbol reference.
    ///
    /// * `GloAddr::Resolved(off)` -- use `Inst::ImmData(off)`.
    ///   The offset is unit-local pre-link (rebased by the
    ///   linker's merge) or the canonical defining unit's
    ///   absolute offset post-link.
    /// * `GloAddr::Extern` -- the symbol has no in-unit
    ///   storage in this TU. The walker emits
    ///   `Inst::ImmData(0)` and records the parser-symbol idx
    ///   in `FunctionSsa::extern_imm_data_refs`; the linker
    ///   patches the slot against the merged symbol table.
    ///
    /// A symbol with `is_extern_decl && !defined_here` takes the
    /// `GloAddr::Extern` arm and resolves through
    /// `extern_imm_data_refs` against the merged symbol table, so
    /// its parser-tentative `val` is never consulted. The AST
    /// `Expr::Ident` snapshot in `fallback_val` still carries that
    /// offset and is only used when nothing in the live entry
    /// updates it.
    fn live_glo_addr(&self, sym: u32, fallback_val: i64) -> GloAddr {
        use crate::c5::symbol::Linkage;
        let idx = sym as usize;
        if idx < self.symbols.len() {
            let s = &self.symbols[idx];
            if s.class == Token::Glo as i64
                && s.is_extern_decl
                && s.linkage == Linkage::External
                && !s.defined_here
            {
                return if s.val == 0 {
                    GloAddr::Extern
                } else {
                    GloAddr::Resolved(s.val)
                };
            }
            if s.class == Token::Glo as i64
                && s.is_extern_decl
                && s.linkage == Linkage::External
                && s.val != 0
            {
                return GloAddr::Resolved(s.val);
            }
            // Forward reference: a block-scope `extern int g;` parsed
            // before the same-TU `int g = ...;` definition (C99 6.2.2p4)
            // snapshots a stale 0 offset into the `Expr::Ident`, so the
            // access lands at the wrong `.data` address. When the live
            // symbol is now a defined global carrying a real offset,
            // use it. The `fallback_val == 0` guard keeps shadowed
            // same-named globals -- which snapshot their own distinct
            // nonzero offsets -- on the snapshot path.
            if s.class == Token::Glo as i64
                && s.defined_here
                && !s.is_extern_decl
                && fallback_val == 0
                && s.val != 0
            {
                return GloAddr::Resolved(s.val);
            }
        }
        GloAddr::Resolved(fallback_val)
    }

    /// Resolve a block-scope `extern` reference that shadowed a bound
    /// name (recorded in `Ast::block_extern_refs`). The slot's class was
    /// restored to the shadowed binding at block exit, so its live state
    /// no longer reflects the external reference. When the name has a
    /// same-TU file-scope definition the shared slot carries its offset
    /// after all scope-exit restores (the definition is the slot's final
    /// writer); use it. Otherwise the reference is cross-TU and resolves
    /// by name through `extern_imm_data_refs`.
    fn block_extern_glo_addr(&self, sym: u32) -> GloAddr {
        let idx = sym as usize;
        if idx < self.symbols.len() {
            let s = &self.symbols[idx];
            if s.class == Token::Glo as i64 && s.defined_here {
                return GloAddr::Resolved(s.val);
            }
        }
        GloAddr::Extern
    }

    /// Address class for a `_Thread_local` access. A pure extern
    /// reference (`extern _Thread_local T x;` with no definition here)
    /// resolves by symbol against the merged TLS block at link time;
    /// a unit-local definition uses its byte offset within this unit's
    /// TLS block. Mirrors `live_glo_addr` for the TLS template.
    fn live_tls_addr(&self, sym: u32, fallback_val: i64) -> GloAddr {
        let idx = sym as usize;
        if idx < self.symbols.len() {
            let s = &self.symbols[idx];
            if s.is_extern_decl && !s.defined_here {
                return GloAddr::Extern;
            }
            if s.defined_here {
                return GloAddr::Resolved(s.val);
            }
        }
        GloAddr::Resolved(fallback_val)
    }
}
