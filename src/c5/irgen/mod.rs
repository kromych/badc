//! `Ast` -> `FunctionSsa` walker: drives `SsaBuilder` from a
//! per-function AST, and is the production SSA source for every parsed
//! function. A shape it cannot lower comes back as a `WalkError`
//! carrying the offending node. This module holds the walk context and
//! the error type; each submodule lowers one part of the grammar.

#![allow(dead_code)]

use alloc::string::String;

use super::ast::{
    Ast, AtomicKind, BitfieldDesc, BlockItem, Decl, DeclId, Expr, ExprId, FinishedFunction,
    LabelId, LocalInit, LocalInitPrelude, MAX_MEM_FILL_ACCESSES, MemTransferOp, RuntimeInitValue,
    SLOT_ALIGN, ShortCircuitOp, Stmt, StmtId, UnOp, bitfield_slice_mask, mem_transfer_accesses,
    mem_transfer_chunks,
};
use super::codegen::ssa::build::SsaBuilder;
use super::codegen::{
    ArgPlacement, LongDoubleKind, Target, effective_fp_arg_mask, offset_align, plan_param_regs_aggs,
};
use super::compiler::types::{
    STRUCT_BASE, STRUCT_STRIDE, Segment, UNSIGNED_BIT, is_long_double_scalar, is_pointer_ty,
    is_struct_ty, is_struct_value_ty, is_unsigned_ty, is_vector_ty, is_volatile_object_ty,
    is_volatile_ty, load_kind, segment_of_object_ty, strip_unsigned, struct_id_of,
    struct_ptr_depth,
};
use super::ir::{
    AsmSeg, AtomicRmwOp, BinOp, BlockId, FpCastKind, FunctionSsa, LoadKind, StoreKind, ValueId,
};
use super::op::Intrinsic;
use super::symbol::Symbol;
use super::token::{Token, Ty};

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
pub(crate) use types::fold_int_binop;

/// The low and high 64-bit halves of a 128-bit value, in that order.
type Halves = (ValueId, ValueId);

/// A shape the walker does not lower. The `Unsupported` variants
/// reject constructs the target or the backend does not provide,
/// reachable from valid input; the `Invalid` variants mean a front-end
/// invariant did not hold, and carry the AST node.
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

/// Resolution of a `Token::Glo` address producer. `Resolved(off)`
/// selects `Inst::ImmData(off)`; `Extern` selects `Inst::ImmData(0)`
/// plus an `extern_imm_data_refs` entry the linker patches from the
/// merged symbol table.
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

/// The blocks one `switch` reserved for its labels.
#[derive(Default)]
struct SwitchLabels {
    /// `(value, block)` per `case`.
    cases: alloc::vec::Vec<(i64, BlockId)>,
    /// `(low, high, block)` per GNU `case lo ... hi`.
    ranges: alloc::vec::Vec<(i64, i64, BlockId)>,
    /// The block for `default`, when the switch has one.
    default: Option<BlockId>,
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
    /// SSA block reserved for each AST label's body, indexed by
    /// `LabelId`. Filled lazily by a Goto's forward reference or by the
    /// matching Labeled stmt, both of which see the same block.
    label_blocks: alloc::vec::Vec<Option<BlockId>>,
    /// Per enclosing `switch`, innermost last: the block reserved for
    /// each `case` value and for `default`, allocated by the
    /// case-collection pass before the dispatcher emits. A marker
    /// reached in the body jumps to its block, so the dispatcher targets
    /// it wherever it sits -- C99 6.8.4.2 admits a case label at any
    /// depth, including inside a nested loop.
    switch_dispatch: alloc::vec::Vec<SwitchLabels>,
    /// True when the declared return type is a struct returned through
    /// the c5 out-pointer convention, where `return s;` copies the
    /// struct into the hidden out-pointer from slot 2 and returns it.
    /// False for a host-ABI return.
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
    /// output, which defers `__builtin_constant_p` to
    /// `Intrinsic::ConstantP` for the post-inline folds instead of
    /// answering 0 here.
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

    /// Live `ent_pc` for a function symbol: the symbol's current `val`,
    /// so a call resolves to the `pc_to_native` slot the codegen
    /// populates even for a sys trampoline, whose `val` is patched
    /// late.
    fn live_fun_val(&self, sym: u32, fallback_val: i64) -> i64 {
        self.live_fun_sym(sym).map_or(fallback_val, |s| s.val)
    }

    /// Whether an `Ident` snapshotted as a `Token::Sys` binding names a
    /// function the unit defined after the snapshot was taken. The
    /// binding is the unit's own function now, and the reference
    /// follows the definition, as the ones parsed after it do.
    fn binding_defined_here(&self, sym: u32, class: i64) -> bool {
        class == Token::Sys as i64
            && self
                .symbols
                .get(sym as usize)
                .is_some_and(|s| s.class == Token::Fun as i64)
    }

    /// Live `ent_pc` for a function symbol whose address is taken. An
    /// inline definition provides no external definition, so its
    /// identifier resolves through the import placeholder and the
    /// address denotes the program's one definition (C99 6.2.2p2).
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

    /// Count of named (pre-ellipsis) parameters the symbol declares,
    /// from `Symbol::params`. A variadic callee's arguments past this
    /// count are the variadic tail, which the macOS arm64 ABI places on
    /// the host stack rather than in the register banks.
    fn fun_fixed_args(&self, sym: u32) -> usize {
        self.live_fun_sym(sym).map_or(0, |s| s.params.len())
    }

    /// Resolve an indirect call's callee to the pointed-to function's
    /// `(is_variadic, fixed_arg_count)`. The prototype is recoverable
    /// from a direct function name, from a function-pointer variable
    /// whose declaration inherited it from a typedef, and through a
    /// comma operator's right operand. Any other callee defaults to
    /// non-variadic with every argument fixed, which places its
    /// arguments as a plain call's are placed.
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
    /// directly or through a pointer. Every ABI question the call site
    /// asks is asked of this, not of the target's own convention.
    fn callee_conv(&self, callee: ExprId) -> crate::c5::codegen::CallConv {
        if let Expr::Ident { sym, class, .. } = self.ast.expr(callee)
            && (*class == Token::Fun as i64 || self.binding_defined_here(*sym, *class))
            && let Some(s) = self.symbols.get(*sym as usize)
            && s.conv != crate::c5::codegen::CallConv::Target
        {
            return s.conv;
        }
        self.indirect_callee_conv(callee)
    }

    /// Calling convention the pointed-to function of an indirect call
    /// follows, recorded at parse time on the callee's `ExprId` when its
    /// declared type carries `__attribute__((ms_abi))` /
    /// `((sysv_abi))`. The entry is normalised against the target, so
    /// anything listed differs from it.
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

    /// Resolve a `Token::Glo` address producer to an intra-unit data
    /// offset or a cross-TU symbol reference. A resolved offset is
    /// unit-local pre-link and the defining unit's absolute offset
    /// after the linker's merge. A symbol with `is_extern_decl &&
    /// !defined_here` has no in-unit storage and resolves by name, so
    /// its parser-tentative `val` is never consulted; `fallback_val`
    /// carries the node's snapshot for the case where nothing in the
    /// live entry updates it.
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
            // A block-scope `extern int g;` parsed before the same-TU
            // definition (C99 6.2.2p4) snapshots a stale 0 offset, so
            // the live symbol's offset wins where it has one. The
            // `fallback_val == 0` guard keeps a shadowed same-named
            // global, which snapshots its own nonzero offset, on the
            // snapshot path.
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
    /// name. Block exit restored the slot's class to the shadowed
    /// binding, so its live state no longer names the external
    /// reference. A same-TU file-scope definition is the slot's final
    /// writer and its offset is used; otherwise the reference is
    /// cross-TU and resolves by name.
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

    /// Address class for a `_Thread_local` access: a pure extern
    /// reference resolves by symbol against the merged TLS block at link
    /// time, and a unit-local definition by its offset within this
    /// unit's TLS block.
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
