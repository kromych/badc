//! Per-function AST.
//!
//! Built by the parser (`c5::compiler`) one function at a time and
//! consumed by `c5::ast::walk` to drive
//! `c5::codegen::ssa::build::SsaBuilder`. The canonical
//! function-shaped IR the walker descends to produce
//! `FunctionSsa`.
//!
//! Layout follows the same indexed-arena shape `FunctionSsa` uses:
//! every node lives in a flat `Vec`, references are `u32` indices.
//! No `Box`, no `Rc` -- the whole AST drops on function exit.
//!
//! Type tags on each `Expr` keep the same `i64` encoding the
//! single-pass parser already computes into `self.ty` (see
//! `c5::token::Ty` for the band scheme: pointers add to the base,
//! `Ty::Long` is a target-width tag, `Ty::LongLong` is always
//! 64-bit, etc.). Symbol references are resolved at parse time and
//! stored as a symbol-table index, so the walker never re-runs name
//! lookup.

// Several node variants are produced by the parser but consumed
// only by the walker. The dead-code lint flags any unused-arm
// reachability that depends on parser sites we haven't wired
// yet; allow it module-wide rather than per-variant.
#![allow(dead_code)]

pub(crate) mod walk;

use alloc::vec::Vec;

use super::ir::BinOp;

/// Index into [`Ast::exprs`].
pub(crate) type ExprId = u32;

/// Index into [`Ast::stmts`].
pub(crate) type StmtId = u32;

/// Index into [`Ast::decls`].
pub(crate) type DeclId = u32;

/// Forward-referenced label slot for `goto`. Allocated at the first
/// `goto` or label definition; resolved when the matching
/// `Stmt::Labeled` is emitted.
pub(crate) type LabelId = u32;

/// Source position attached to every node. The walker stamps
/// the live `(file, line)` into `inst_src` so DWARF lands
/// per-Inst rows in the right file.
#[derive(Debug, Clone, Copy, Default)]
pub(crate) struct SrcPos {
    /// 1-based source line.
    pub line: u32,
    /// Index into the translation unit's source-file table.
    pub file: u16,
}

/// Short-circuit logical operator. C99 6.5.13 / 6.5.14:
/// `Lan` is `&&`, `Lor` is `||`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ShortCircuitOp {
    /// `lhs && rhs` -- rhs is evaluated only when lhs is non-zero.
    Lan,
    /// `lhs || rhs` -- rhs is evaluated only when lhs is zero.
    Lor,
}

/// Unary operator. Pre/post-increment carry their step value
/// separately on the [`Expr::PreInc`] / [`Expr::PostInc`] variants
/// because pointer arithmetic scales the step by `sizeof(*ptr)`,
/// which the parser resolves at the AST-build site.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum UnOp {
    /// Arithmetic negation, integer or floating per `child.ty`.
    Neg,
    /// Bitwise complement (`~`), C99 6.5.3.3.
    BitNot,
    /// Logical complement (`!`), C99 6.5.3.3p5: result is `int` 0/1.
    LogNot,
    /// `&expr` -- take the address of an lvalue. C99 6.5.3.2.
    AddrOf,
    /// `*expr` -- dereference a pointer. C99 6.5.3.2.
    Deref,
}

/// C11 7.17 generic atomic operation. The operand width is the
/// pointee type of the first argument; the walker lowers each kind
/// to ordinary load / store / read-modify-write on that width.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AtomicKind {
    /// `atomic_load(p)` -- yield `*p`.
    Load,
    /// `atomic_store(p, v)` -- `*p = v`, no value.
    Store,
    /// `atomic_exchange(p, v)` -- store `v`, yield the prior `*p`.
    Exchange,
    /// `atomic_fetch_add/sub/and/or/xor(p, v)` -- apply the binary
    /// operator to `*p` and `v`, store the result, yield the prior
    /// `*p`.
    FetchAdd,
    FetchSub,
    FetchAnd,
    FetchOr,
    FetchXor,
    /// `atomic_compare_exchange_strong(p, expected, desired)` --
    /// if `*p == *expected`, store `desired` and yield 1; otherwise
    /// store `*p` into `*expected` and yield 0.
    CompareExchangeStrong,
    /// GCC `__sync_add_and_fetch` / `_sub_` / `_and_` / `_or_` /
    /// `_xor_and_fetch(p, v)` -- apply the operator and yield the NEW
    /// `*p` (the post-operation value), as opposed to the `Fetch*`
    /// forms which yield the prior value.
    AddFetch,
    SubFetch,
    AndFetch,
    OrFetch,
    XorFetch,
    /// GCC `__sync_val_compare_and_swap(p, old, new)` -- if `*p == old`
    /// store `new`; yield the prior `*p` in either case. `args` are
    /// `[p, old, new]` (`old`/`new` are by value, not pointers).
    SyncCasVal,
    /// GCC `__sync_bool_compare_and_swap(p, old, new)` -- as `SyncCasVal`
    /// but yield 1 on a swap, 0 otherwise.
    SyncCasBool,
    /// GCC generic `__atomic_load(p, ret, memorder)` -- atomically load
    /// `*p` and write it through `ret`. `args` are `[p, ret]`; no value.
    LoadInto,
    /// GCC generic `__atomic_store(p, val, memorder)` -- atomically store
    /// `*val` into `*p`. `args` are `[p, val]`; no value.
    StoreFrom,
}

/// Storage-unit width + bit position for a bitfield reference. The
/// parser resolves these from the struct-field metadata at parse
/// time; the walker emits the load + shift + mask sequence.
#[derive(Debug, Clone, Copy)]
pub(crate) struct BitfieldDesc {
    /// Bit offset within the storage unit. Range `[0, 63]`.
    pub bit_offset: u8,
    /// Bit width of the field. Range `[1, 64]`.
    pub bit_width: u8,
    /// Storage-unit width in bytes (1, 2, 4, or 8). Drives the
    /// load / store opcode pair per C99 6.7.2.1p11.
    pub unit_size: u8,
    /// True when the declared field type is signed -- C99
    /// 6.7.2.1p10 says the read sign-extends through the top of
    /// the storage word.
    pub signed: bool,
}

/// Operand of `sizeof`. C99 6.5.3.4p2 allows either a type-name or
/// a unary-expression. The parser folds the result to a constant at
/// parse time -- the AST stores the resolved byte count and the
/// node's own integer-literal type tag; the walker emits an `imm`.
#[derive(Debug, Clone, Copy)]
pub(crate) struct SizeofResolved {
    pub size_bytes: i64,
    pub result_ty: i64,
}

/// Expression node. Every variant carries a `ty: i64` matching the
/// `i64` encoding the single-pass parser computes into `self.ty`,
/// so the walker never re-runs type resolution.
#[derive(Debug, Clone)]
pub(crate) enum Expr {
    /// Integer literal -- includes character constants and the
    /// resolved-at-parse-time integer value of an enum tag.
    IntLit { val: i64, ty: i64 },
    /// Floating-point literal. `ty` is `Ty::Float as i64` or
    /// `Ty::Double as i64`.
    FloatLit { bits: u64, ty: i64 },
    /// String literal. `data_off` is the byte offset of the first
    /// character inside the program's data segment.
    StrLit { data_off: i64, ty: i64 },
    /// Reference to a declared identifier. `sym` indexes the
    /// symbol table for diagnostics + identity; `class` and
    /// `val` are snapshotted at parse time so a later scope
    /// exit (C99 6.8.5.3 for-init scope; nested block locals)
    /// that restores the symbol's pre-declaration tag doesn't
    /// invalidate the AST. `class` is the Token tag the parser
    /// classified the identifier with (Loc / Glo / Sys / Fun /
    /// Num); `val` is the slot offset / data offset / ent_pc
    /// matching that class. `is_thread_local` mirrors the
    /// symbol's flag at parse time.
    Ident {
        sym: u32,
        ty: i64,
        class: i64,
        val: i64,
        is_thread_local: bool,
        /// Snapshot of `Symbol::array_size` at parse time. Non-zero
        /// for an array-shaped symbol (`T name[N];` -- the decay
        /// happens in the rvalue path). Captured here so the walker
        /// doesn't have to re-index the symbol table post-shadow.
        array_size: i64,
    },
    /// `op child`, where `child` is the operand. Increment /
    /// decrement go through [`Expr::PreInc`] / [`Expr::PostInc`]
    /// instead.
    Unary { op: UnOp, child: ExprId, ty: i64 },
    /// `&&label` -- GCC labels-as-values. The address of a local
    /// label as a `void *`, consumed by `Stmt::GotoIndirect`.
    LabelAddr(LabelId),
    /// `lhs op rhs`. C99 6.5 operator-by-operator semantics; `op`
    /// is already the post-usual-arithmetic-conversion variant
    /// the parser picked (e.g. `Add` vs `Fadd`).
    Binary {
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    },
    /// `cond ? then_e : else_e` (C99 6.5.15). `elvis` marks the GNU
    /// `cond ?: else_e` form (omitted middle operand): the walker
    /// evaluates `cond` once and reuses its value as `then_e`.
    Ternary {
        cond: ExprId,
        then_e: ExprId,
        else_e: ExprId,
        ty: i64,
        elvis: bool,
    },
    /// `callee(args...)`. Variadic calls go through the same
    /// variant; the parser records the variadic boundary by the
    /// length of `args` exceeding the callee's declared param
    /// count (which the walker reads off the callee's symbol).
    Call {
        callee: ExprId,
        args: Vec<ExprId>,
        ty: i64,
    },
    /// Struct / union field access. `field_off` is the byte
    /// offset of the field; `bitfield` is `Some` only for
    /// bitfields. The address producer (`obj`) is built once;
    /// the walker decides whether to chase through `.` or `->`
    /// based on `obj`'s type.
    Member {
        obj: ExprId,
        field_off: i64,
        bitfield: Option<BitfieldDesc>,
        ty: i64,
        /// Non-zero when the field's declared shape is an array
        /// (`T name[N]` inside the struct). Per C99 6.3.2.1p3 +
        /// the c5 address-as-value rule the field's address IS
        /// its rvalue and no load runs at the access site; the
        /// walker keys off this to suppress the trailing load
        /// that scalar / pointer fields take.
        array_size: i64,
    },
    /// `array[idx]` -- the parser has already lowered pointer
    /// arithmetic to `*(array + idx * sizeof(*array))` in older
    /// code paths; AST keeps it as a distinct shape so the
    /// walker can emit `LoadIndexed` directly when the layout
    /// permits.
    Index { array: ExprId, idx: ExprId, ty: i64 },
    /// `(to_ty) child`. C99 6.5.4 -- the parser has already
    /// validated the cast is well-formed; the walker emits the
    /// required `FpCast` (int <-> fp) or width-change ops.
    Cast { child: ExprId, to_ty: i64 },
    /// `lhs = rhs`. `lhs` is an lvalue-shape expression node
    /// (Ident, Deref, Member, Index, or a Cast of one); the
    /// walker chases its address producer and emits a Store.
    Assign { lhs: ExprId, rhs: ExprId, ty: i64 },
    /// `obj.field = rhs` / `p->field = rhs` where `field` is a
    /// bitfield. C99 6.7.2.1: write a sub-word slice of the
    /// containing storage unit while preserving the surrounding
    /// bits. The walker emits the load-clear-shift-or-store
    /// sequence; the parser resolves `bitfield` from the struct
    /// field metadata at parse time. `obj` is the address-
    /// producing expression for the containing struct, already
    /// offset to the storage unit by `field_off`.
    BitfieldAssign {
        obj: ExprId,
        field_off: i64,
        bitfield: BitfieldDesc,
        rhs: ExprId,
        ty: i64,
    },
    /// `lhs op= rhs`. C99 6.5.16.2p3: `lhs` is evaluated exactly
    /// once; the walker spills the address and reloads.
    CompoundAssign {
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    },
    /// Prefix `++` / `--`. `by` is the post-pointer-scaling step
    /// value (+1 / -1 for scalars, `+sizeof(*ptr)` / `-sizeof(*ptr)`
    /// for pointers) the parser resolved at this site.
    PreInc { lvalue: ExprId, by: i64, ty: i64 },
    /// Postfix `++` / `--`. Same `by` semantics; the walker
    /// captures the pre-update value as the expression's result.
    PostInc { lvalue: ExprId, by: i64, ty: i64 },
    /// `sizeof <operand>`. Resolved to a constant at parse time.
    Sizeof(SizeofResolved),
    /// `lhs, rhs`. C99 6.5.17 -- evaluate `lhs` for side effects,
    /// the value of the comma expression is `rhs`.
    Comma { lhs: ExprId, rhs: ExprId, ty: i64 },
    /// `lhs && rhs` (C99 6.5.13) / `lhs || rhs` (6.5.14). Both
    /// short-circuit: the rhs is evaluated only when the lhs
    /// doesn't already determine the result. `ir::BinOp` carries
    /// only the bitwise And / Or / Xor; the logical pair lives
    /// here so the walker can emit the proper branch + value-
    /// merge sequence.
    ShortCircuit {
        op: ShortCircuitOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    },
    /// Compiler-builtin call (alloca, memset, setjmp, longjmp,
    /// ...). `kind` is the `Intrinsic` enum discriminant; the
    /// walker forwards it to `Inst::Intrinsic`.
    Intrinsic {
        kind: i64,
        args: Vec<ExprId>,
        ty: i64,
    },
    /// GCC extended inline asm with operands. The payload is an index
    /// into [`Ast::asm_blocks`]; the descriptor there holds the
    /// template, per-operand constraints, clobbers, and the operand
    /// expressions. As a statement it yields no value (`void`); the
    /// walker lowers it to `Inst::InlineAsm`.
    InlineAsm(u32),
    /// C11 7.17 atomic operation (`atomic_load`, `atomic_store`,
    /// `atomic_exchange`, `atomic_fetch_*`,
    /// `atomic_compare_exchange_strong`). `args` holds the pointer
    /// plus the operation's value / expected / desired operands;
    /// `ty` is the result type (the pointee type for the value-
    /// producing forms, `int` for the predicate and store forms).
    /// The walker lowers each kind to load / store / RMW on the
    /// pointee width.
    Atomic {
        kind: AtomicKind,
        args: Vec<ExprId>,
        /// Pointee type of the first argument -- drives the load /
        /// store width. Distinct from `ty` because the store and
        /// compare-exchange forms have a result type (`void` / `int`)
        /// that differs from the operand width.
        elem_ty: i64,
        ty: i64,
    },
    /// `(type){ initializer-list }` -- C99 6.5.2.5 compound
    /// literal at block scope. The parser reserves a frame slot
    /// (automatic storage, lifetime = enclosing block per 6.5.2.5p5)
    /// and snapshots the initializer; the walker emits the init at
    /// the evaluation point (so non-constant elements observe the
    /// surrounding evaluation order) and yields the slot's address
    /// for array / struct objects, or the loaded scalar value.
    /// `array_size` is 0 for a scalar / struct literal, > 0 for an
    /// array literal.
    CompoundLiteral {
        slot_off: i64,
        ty: i64,
        array_size: i64,
        init: LocalInit,
    },
    /// A variable-length array identifier in a value context (C99
    /// 6.3.2.1p3 decay). The array's storage is at a runtime address
    /// held in `ptr_slot`; the walker loads that pointer. `ty` is the
    /// decayed element-pointer type.
    VlaBase { ptr_slot: i64, ty: i64 },
    /// `sizeof <vla>` -- the runtime byte count the matching
    /// `Decl::Vla` stored into `size_slot` (C99 6.5.3.4p2: for a VLA
    /// the operand is evaluated and the result is a runtime value).
    VlaSizeof { size_slot: i64 },
    /// GCC statement expression `({ ... })` (Annex J.5 common
    /// extension). `block` is the enclosed compound statement (or,
    /// for a single-item block, the bare statement `ast_wrap_block_items`
    /// yields). The value and type are those of the last
    /// expression-statement; `ty` is `Ty::Void` when the trailing
    /// block-item is not an expression statement.
    #[allow(clippy::enum_variant_names)]
    StmtExpr { block: StmtId, ty: i64 },
    /// GCC checked-arithmetic builtin
    /// `__builtin_{add,sub,mul}_overflow(a, b, dst)`. `op` is 0 = add,
    /// 1 = sub, 2 = mul. `dst` is the result pointer; `elem_ty` is its
    /// pointee type, which drives the operation width and signedness.
    /// The walker stores the wrapped `a op b` through `dst` and yields
    /// the `int` overflow flag (`ty`).
    CheckedArith {
        op: i64,
        a: ExprId,
        b: ExprId,
        dst: ExprId,
        elem_ty: i64,
        ty: i64,
    },
}

/// One item inside a compound statement. C99 6.8.2's
/// `block-item-list` permits declarations and statements to
/// interleave; the variant keeps them as two distinct shapes.
#[derive(Debug, Clone, Copy)]
pub(crate) enum BlockItem {
    Stmt(StmtId),
    Decl(DeclId),
}

/// Statement node. Same arena/index pattern as [`Expr`].
#[derive(Debug, Clone)]
pub(crate) enum Stmt {
    /// `{ ... }` (C99 6.8.2). `items` is the block-item-list in
    /// source order.
    Compound(Vec<BlockItem>),
    /// Expression statement. The wrapped expression is evaluated
    /// for side effects; its value is discarded.
    Expr(ExprId),
    /// `if (cond) then_s [else else_s]` (C99 6.8.4.1).
    If {
        cond: ExprId,
        then_s: StmtId,
        else_s: Option<StmtId>,
    },
    /// `while (cond) body` (C99 6.8.5.1).
    While { cond: ExprId, body: StmtId },
    /// `do body while (cond)` (C99 6.8.5.2).
    DoWhile { body: StmtId, cond: ExprId },
    /// `for (init; cond; post) body` (C99 6.8.5.3). `init` is a
    /// block-item to admit the C99 declaration-init shape; `cond`
    /// and `post` are independently optional.
    For {
        init: Option<BlockItem>,
        cond: Option<ExprId>,
        post: Option<ExprId>,
        body: StmtId,
    },
    /// `switch (disc) body` (C99 6.8.4.2). `body` is the
    /// statement that contains the case labels.
    Switch { disc: ExprId, body: StmtId },
    /// `case val: body` (C99 6.8.1).
    /// `case val: body`, or the GNU range `case val ... hi: body`
    /// (`hi == val` for a single label). The walker maps every value in
    /// `[val, hi]` to this case's block.
    Case { val: i64, hi: i64, body: StmtId },
    /// `default: body` (C99 6.8.1).
    Default { body: StmtId },
    /// `break;` (C99 6.8.6.3).
    Break,
    /// `continue;` (C99 6.8.6.2).
    Continue,
    /// `return [value];` (C99 6.8.6.4).
    Return(Option<ExprId>),
    /// `goto label;` (C99 6.8.6.1).
    Goto(LabelId),
    /// `goto *expr;` -- GCC computed goto. `target` evaluates to a
    /// label address produced by `Expr::LabelAddr`.
    GotoIndirect(ExprId),
    /// `label: body` (C99 6.8.1) -- the goto target.
    Labeled { label: LabelId, body: StmtId },
    /// Inline assembly. `text` is the assembler source; `clobbers`
    /// is the comma-separated clobber list.
    Asm {
        text: alloc::string::String,
        clobbers: alloc::string::String,
    },
    /// Local declaration that lives inline in a block. C99 6.8.2
    /// allows `block-item-list` to interleave declarations and
    /// statements; the parser wraps each block-scope declaration
    /// in this variant so the existing snapshot/range-wrapping
    /// `parse_block_stmt` can capture decls alongside stmts via a
    /// single stmt-id sequence.
    Decl(DeclId),
    /// Snapshot the per-frame alloca-arena top into `save_slot` on
    /// entry to a block that declares a variable-length array. Paired
    /// with `VlaScopeExit` so the VLA storage is reclaimed on block
    /// exit and, for a loop body, on every iteration (C99 6.2.4p2).
    VlaScopeEnter { save_slot: i64 },
    /// Restore the alloca-arena top from `save_slot` on block exit.
    VlaScopeExit { save_slot: i64 },
}

/// One stored element in a runtime aggregate initializer.
/// `offset` is the byte offset into the local; `value` is the
/// element's expression; `ty` is the destination type that
/// drives the walker's `store_kind_for` pick. `bitfield`, when set,
/// makes the walker emit a load-clear-shift-or-store into the
/// storage unit at `offset` instead of a full-width store (a
/// bitfield member with a non-constant initializer).
#[derive(Debug, Clone, Copy)]
pub(crate) struct RuntimeInitElement {
    pub offset: i64,
    pub value: ExprId,
    pub ty: i64,
    pub bitfield: Option<BitfieldDesc>,
}

/// Initializer shape on a `Decl::Local`. C99 6.7.8 admits four
/// flavours the AST distinguishes:
/// * `None` -- no initializer; C99 6.7.8p10 leaves the value
///   indeterminate.
/// * `Scalar(ExprId)` -- a single initializer expression for an
///   arithmetic / pointer / single-value local. Walker emits one
///   `store_local`.
/// * `Aggregate { src_data_off, size_bytes }` -- a brace-list
///   initializer whose every element folded to a compile-time
///   constant. The parser stages the bytes at `src_data_off`
///   inside `Program.data`; the walker emits `Inst::Mcpy` to
///   copy them into the local's slot.
/// * `Runtime { zero_init, elements }` -- a brace-list
///   initializer with at least one non-constant element. C99
///   6.7.8p13. `zero_init` is the optional Mcpy-from-staged-zero
///   prelude that implements the "omitted entries are zero" rule
///   (6.7.8p19); `elements` is the per-position store sequence.
#[derive(Debug, Clone)]
pub(crate) enum LocalInit {
    None,
    Scalar(ExprId),
    Aggregate {
        src_data_off: i64,
        size_bytes: i64,
    },
    Runtime {
        zero_init: Option<(i64, i64)>,
        elements: Vec<RuntimeInitElement>,
    },
}

/// Declaration node. Captures variable / function declarations
/// that the AST needs to surface to the walker as side-effecting
/// (e.g. local variables with initializers, VLAs with a runtime
/// dimension). Global declarations and type definitions stay in
/// the symbol table; only the bits the walker needs land here.
#[derive(Debug, Clone)]
pub(crate) enum Decl {
    /// Local variable declaration. The slot offset is captured at
    /// parse time; the initializer (if any) is one of the shapes
    /// in [`LocalInit`] and is evaluated / Mcpy'd at the
    /// declaration site per C99 6.7.8. `ty` is snapshotted at the
    /// declaration site so the walker picks the right
    /// load/store width even after the symbol's outer-scope
    /// binding is restored at function-end.
    Local {
        sym: u32,
        ty: i64,
        slot_off: i64,
        init: LocalInit,
    },
    /// Variable-length array declaration (C99 6.7.6.2). `dim` is the
    /// runtime element-count expression; `elem_size` is the element's
    /// byte size. The walker evaluates `dim * elem_size`, allocates
    /// that many bytes from the per-frame alloca arena, stores the
    /// base pointer into `ptr_slot`, and the byte count into
    /// `size_slot` (read back by `sizeof`). `elem_ty` carries the
    /// element type for struct-size remapping.
    Vla {
        sym: u32,
        elem_ty: i64,
        elem_size: i64,
        ptr_slot: i64,
        size_slot: i64,
        dim: ExprId,
    },
    /// Block-scope `static T name [= init];` declaration. C99
    /// 6.2.4p3 (lifetime is whole program) + 6.7.8p4 (init must
    /// be constant). The parser promotes the symbol to the `Glo`
    /// class with persistent storage in `.data`; the initializer
    /// is staged at TU load time, not at the declaration site.
    /// The AST records the binding for completeness; the walker
    /// emits nothing because the storage + init live outside the
    /// function body.
    StaticLocal { sym: u32 },
}

/// Per-function AST snapshot captured at function-end. Carries
/// the metadata the SSA walker needs alongside the node arenas:
/// the function's ent_pc identifier for symbol-PC remapping,
/// the param count + variadic flag for the function prologue,
/// and the post-parse local slot high-water mark for frame
/// sizing.
#[derive(Debug, Clone)]
pub(crate) struct FinishedFunction {
    pub ast: Ast,
    pub ent_pc: usize,
    /// One-past-the-last ent_pc reserved for this function.
    /// Set at parser-emit close so the SSA tier knows the
    /// function's PC range without consulting a parser-side
    /// counter post hoc.
    pub end_pc: usize,
    pub n_params: usize,
    pub is_variadic: bool,
    /// True if the source declarator carried an `inline` /
    /// `__inline` / `__inline__` function specifier (C99 6.7.4).
    /// The walker propagates this onto `FunctionSsa::is_inline` so
    /// `inline` bypasses its body-size cap for these.
    pub is_inline: bool,
    /// True if the declarator carried a *mandatory* inline request
    /// (`__attribute__((always_inline))` or MSVC `__forceinline`).
    /// Propagated onto `FunctionSsa::is_always_inline`; implies
    /// `is_inline`.
    pub is_always_inline: bool,
    pub n_locals: i64,
    /// Per-parameter type tags in declared order. The walker
    /// reads these to emit the C99 6.2.4 / 6.5.2.2-mandated
    /// entry-Mcpy for struct-by-value parameters: the caller
    /// passes the struct's address in `arg_reg[i]`, and the
    /// callee copies the bytes into its own local slot before
    /// the body runs. Empty when there were no parameters.
    pub param_tys: alloc::vec::Vec<i64>,
    /// Per-parameter local-slot offsets the parser allocated
    /// for the callee's local copy of each struct-by-value
    /// param. Slot `0` (= no offset) means the param is a
    /// scalar / pointer / unhandled shape -- the walker
    /// skips the entry-Mcpy for those.
    pub param_local_slots: alloc::vec::Vec<i64>,
    /// True when the declared return type is a struct value
    /// (`struct T` rather than `struct T *`). Walker uses
    /// this to lower `return s;` as the C99 ABI's
    /// out-pointer Mcpy: load the hidden out-pointer from
    /// `slot 2`, copy `sizeof(T)` bytes from `s` into it,
    /// then return.
    pub returns_struct: bool,
    /// Byte size of the returned struct when `returns_struct`
    /// is true. Zero otherwise.
    pub return_struct_size: i64,
    /// Declared return type tag. The walker classifies the host-ABI
    /// return convention (registers / x8 / out-pointer) from it.
    pub return_ty: i64,
    /// `slot` operand for the function's `Inst::AllocaInit`. Non-
    /// zero when the body contains an `alloca` call: codegen
    /// reserves a per-frame arena and uses this local slot for
    /// the running top. Zero when `alloca` is unused, in which
    /// case codegen treats AllocaInit as a no-op.
    pub alloca_top_slot: i64,
    /// `(base_offset, cells)` for each declared multi-cell local (aggregate
    /// or multi-cell scalar): the local occupies `base_offset ..=
    /// base_offset + cells - 1`. The walker seeds `FunctionSsa::multi_cell_slots`
    /// with these so slot coalescing reserves the interior cells, which carry
    /// no direct slot reference (reached only via the base address). Empty
    /// when the function has no multi-cell local.
    pub multi_cell_slots: alloc::vec::Vec<(i64, i64)>,
    pub name: alloc::string::String,
}

/// Per-function AST. One instance lives on the active function in
/// [`super::compiler::Compiler`]; dropped at function exit.
/// A GCC extended-asm statement as parsed, before the walker evaluates
/// its operands. `block` carries the template, constraints, and
/// clobbers; `operand_exprs` is parallel to `block.operands` and holds
/// each operand's parenthesised expression (an lvalue for an output, an
/// rvalue for an input). Referenced by index from [`Expr::InlineAsm`].
#[derive(Debug, Clone)]
pub(crate) struct AsmBlockAst {
    pub block: crate::c5::ir::AsmBlock,
    pub operand_exprs: Vec<ExprId>,
}

#[derive(Debug, Default, Clone)]
pub(crate) struct Ast {
    pub exprs: Vec<Expr>,
    pub stmts: Vec<Stmt>,
    pub decls: Vec<Decl>,
    /// Extended inline-asm descriptors, indexed by [`Expr::InlineAsm`].
    /// Sparse: empty unless a function uses operand-carrying asm.
    pub asm_blocks: Vec<AsmBlockAst>,
    /// Source position columns. Same length as the matching arena;
    /// `expr_src[ExprId as usize]` is the position of that node.
    pub expr_src: Vec<SrcPos>,
    pub stmt_src: Vec<SrcPos>,
    pub decl_src: Vec<SrcPos>,
    /// Root statement of the function body -- a [`Stmt::Compound`]
    /// in well-formed C. `None` until the parser finishes the
    /// function definition.
    pub body: Option<StmtId>,
    /// Forward-fixup table for `goto`. `goto_targets[id as usize]`
    /// is `Some(StmtId)` once the matching labelled statement is
    /// seen; `None` while the label is still pending.
    pub goto_targets: Vec<Option<StmtId>>,
    /// Indirect-call callees whose pointed-to function is variadic, keyed
    /// by the callee's `ExprId` with the count of fixed (pre-ellipsis)
    /// parameters. Populated when the callee's prototype is not
    /// recoverable from its symbol alone -- a struct-field, array-element,
    /// or dereferenced function pointer. The walker reads it to split a
    /// variadic call's arguments at the fixed count so the host variadic
    /// ABI places the tail correctly (C99 6.5.2.2; macOS/AAPCS64 Darwin
    /// passes the tail on the stack). Sparse: empty unless a variadic
    /// indirect call appears in the function.
    pub variadic_indirect_callees: Vec<(ExprId, u32)>,
    /// `Expr::Ident` nodes that reference a block-scope `extern` which
    /// shadows an enclosing bound name (a local, parameter, or enum
    /// constant). The shadowed binding is restored at block exit, so the
    /// slot's class at walk time no longer reflects the external
    /// reference; the walker resolves a node listed here against the
    /// same-TU file-scope definition (if one exists) or a name-keyed
    /// cross-TU relocation, rather than re-reading the restored slot.
    /// Sparse: empty unless a block-scope extern shadows a local.
    pub block_extern_refs: Vec<ExprId>,
}

impl Ast {
    pub(crate) fn new() -> Self {
        Self::default()
    }

    pub(crate) fn push_expr(&mut self, e: Expr, src: SrcPos) -> ExprId {
        let id = self.exprs.len() as ExprId;
        self.exprs.push(e);
        self.expr_src.push(src);
        id
    }

    pub(crate) fn push_stmt(&mut self, s: Stmt, src: SrcPos) -> StmtId {
        let id = self.stmts.len() as StmtId;
        self.stmts.push(s);
        self.stmt_src.push(src);
        id
    }

    pub(crate) fn push_decl(&mut self, d: Decl, src: SrcPos) -> DeclId {
        let id = self.decls.len() as DeclId;
        self.decls.push(d);
        self.decl_src.push(src);
        id
    }

    pub(crate) fn alloc_label(&mut self) -> LabelId {
        let id = self.goto_targets.len() as LabelId;
        self.goto_targets.push(None);
        id
    }

    pub(crate) fn resolve_label(&mut self, label: LabelId, target: StmtId) {
        self.goto_targets[label as usize] = Some(target);
    }

    pub(crate) fn expr(&self, id: ExprId) -> &Expr {
        &self.exprs[id as usize]
    }

    /// Value type of an expression node, falling back to `Ty::Int`
    /// for a node the type helper does not classify. Used by the
    /// statement-expression parser to type `({ ...; expr; })` from
    /// its last expression-statement.
    pub(crate) fn expr_value_ty(&self, id: ExprId) -> i64 {
        walk::expr_ty(self.expr(id)).unwrap_or(crate::c5::token::Ty::Int as i64)
    }

    pub(crate) fn stmt(&self, id: StmtId) -> &Stmt {
        &self.stmts[id as usize]
    }

    /// Apply `f` to every data-segment byte offset stored on AST nodes.
    /// One visitor backs both the linker's uniform rebase and static
    /// DCE's compaction remap, so the two can never drift on which
    /// offsets count as data references. Touches:
    ///   * `Expr::StrLit { data_off }`
    ///   * `Expr::Ident { class: Glo, val }` (non-TLS) -- `val` is the
    ///     symbol's data-segment byte offset.
    ///   * `LocalInit::Aggregate { src_data_off }` and the
    ///     `Runtime { zero_init: (src_data_off, _) }` prelude, on both
    ///     `Expr::CompoundLiteral` and `Decl::Local`.
    fn for_each_data_offset(&mut self, f: &mut impl FnMut(&mut i64)) {
        use crate::c5::token::Token;
        for expr in &mut self.exprs {
            match expr {
                Expr::StrLit { data_off, .. } => f(data_off),
                Expr::Ident {
                    class,
                    val,
                    is_thread_local,
                    ..
                } if *class == Token::Glo as i64 && !*is_thread_local => f(val),
                Expr::CompoundLiteral { init, .. } => match init {
                    LocalInit::Aggregate { src_data_off, .. } => f(src_data_off),
                    LocalInit::Runtime {
                        zero_init: Some((off, _)),
                        ..
                    } => f(off),
                    _ => {}
                },
                _ => {}
            }
        }
        for decl in &mut self.decls {
            if let Decl::Local { init, .. } = decl {
                match init {
                    LocalInit::Aggregate { src_data_off, .. } => f(src_data_off),
                    LocalInit::Runtime {
                        zero_init: Some((off, _)),
                        ..
                    } => f(off),
                    _ => {}
                }
            }
        }
    }

    /// Add `data_base` to every data-segment offset stored on AST nodes.
    /// Used by the linker after each unit's data segment is placed in the
    /// merged image: parser-time `data_off` / `val` snapshots are
    /// unit-local; the merged image places the unit at `data_base` bytes
    /// from the segment's start (and beyond the leading NULL guard).
    pub(crate) fn rebase_data_offsets(&mut self, data_base: i64) {
        if data_base == 0 {
            return;
        }
        self.for_each_data_offset(&mut |off| *off += data_base);
    }

    /// Rewrite every data-segment offset through `remap`. Used by static
    /// DCE after `.data` is compacted: an object that survives the prune
    /// moves to a new packed offset, and every AST reference to it must
    /// follow. `remap` must be defined for every offset the AST holds.
    pub(crate) fn remap_data_offsets(&mut self, remap: &impl Fn(i64) -> i64) {
        self.for_each_data_offset(&mut |off| *off = remap(*off));
    }

    /// Linker-side fixup for multi-TU builds: shift every
    /// `Token::Fun` ident's `val` (the callee's pre-link
    /// `ent_pc`) by `text_base`, mirroring the rebase the linker
    /// applies elsewhere through `apply_reloc`. The walker reads
    /// `val` directly when the merged `Symbol` table is empty
    /// (the multi-TU path), so without this fixup an in-unit
    /// `Expr::Call` to a defined-in-the-same-unit function
    /// lowers to `Inst::Call { target_pc = pre-link PC }` and
    /// the SSA emit's `pc_to_native[target_pc]` lookup hits an
    /// unmapped slot. Cross-unit references (forward `extern`
    /// calls into another unit) carry `val == 0` and are
    /// handled by the symbol-table fixup pass on the linker side.
    pub(crate) fn rebase_function_pcs(&mut self, text_base: i64) {
        use crate::c5::token::Token;
        if text_base == 0 {
            return;
        }
        for expr in &mut self.exprs {
            if let Expr::Ident { class, val, .. } = expr
                && *class == Token::Fun as i64
                && *val > 0
            {
                *val += text_base;
            }
        }
    }

    /// Linker-side fixup for multi-TU builds: shift every `sym`
    /// index stored on AST nodes by `sym_base`. The linker
    /// concatenates per-unit `parser_symbols` so unit `i`'s
    /// indices start at `sym_base[i]`; without this shift the
    /// walker's `live_fun_val` reads the wrong symbol entry.
    pub(crate) fn rebase_sym_indices(&mut self, sym_base: u32) {
        if sym_base == 0 {
            return;
        }
        for expr in &mut self.exprs {
            if let Expr::Ident { sym, .. } = expr {
                *sym += sym_base;
            }
        }
        for decl in &mut self.decls {
            match decl {
                Decl::Local { sym, .. } => *sym += sym_base,
                Decl::Vla { sym, .. } => *sym += sym_base,
                Decl::StaticLocal { sym, .. } => *sym += sym_base,
            }
        }
    }

    /// Linker-side fixup: remap every `Token::Sys` ident's `val`
    /// from the unit-local `#pragma binding` flat index to the
    /// merged binding flat index produced by `linker::link::merge`.
    /// The walker reads `val` straight off the AST snapshot, so
    /// the snapshot needs the rewrite or the emitted
    /// `Inst::CallExt::binding_idx` reaches the wrong libc
    /// import.
    pub(crate) fn rebase_sys_binding_indices(&mut self, remap: &[i64]) {
        use crate::c5::token::Token;
        if remap.is_empty() {
            return;
        }
        for expr in &mut self.exprs {
            if let Expr::Ident { class, val, .. } = expr
                && *class == Token::Sys as i64
            {
                let idx = *val as usize;
                if idx < remap.len() {
                    *val = remap[idx];
                }
            }
        }
    }

    /// Linker-side fixup: remap every struct type tag from the
    /// unit-local struct id to the merged struct id. The linker
    /// dedupes structs by name when concatenating per-unit
    /// `structs` tables, so a unit's local id can drift relative
    /// to its position in the merged list; without this remap the
    /// walker's `struct_size(ty)` indexes the wrong entry and
    /// emits the wrong `Inst::Mcpy` byte count for struct
    /// assignments / returns / struct-by-value params.
    /// Linker-side fixup for multi-TU builds: shift every
    /// `SrcPos::file` carried on the parallel `expr_src` /
    /// `stmt_src` / `decl_src` arrays by `file_offset`. The
    /// linker concatenates per-unit `source_files` into one
    /// merged table; each unit's parser-time file indices start
    /// at the unit's offset in the merged table. Without this
    /// shift the walker stamps SSA insts with unit-local file
    /// indices, the DWARF line program emits `DW_LNS_set_file`
    /// rows pointing at the wrong entry, and a debugger
    /// attributes the PC to the file from another TU.
    pub(crate) fn rebase_source_file_indices(&mut self, file_offset: u16) {
        if file_offset == 0 {
            return;
        }
        let bump = |pos: &mut SrcPos| {
            pos.file = pos.file.saturating_add(file_offset);
        };
        for pos in &mut self.expr_src {
            bump(pos);
        }
        for pos in &mut self.stmt_src {
            bump(pos);
        }
        for pos in &mut self.decl_src {
            bump(pos);
        }
    }

    pub(crate) fn rebase_struct_ids(&mut self, remap: &[usize]) {
        if remap.is_empty() {
            return;
        }
        for expr in &mut self.exprs {
            visit_expr_ty(expr, &mut |ty| *ty = remap_struct_ty(*ty, remap));
        }
        for decl in &mut self.decls {
            visit_decl_ty(decl, &mut |ty| *ty = remap_struct_ty(*ty, remap));
        }
    }

    pub(crate) fn decl(&self, id: DeclId) -> &Decl {
        &self.decls[id as usize]
    }
}

/// Linker-side struct-id rebase helpers. Defined out of the
/// `impl Ast` block so callers can also use them on raw type
/// tags carried outside the AST (e.g. `FinishedFunction::param_tys`,
/// `Symbol::type_`).
pub(crate) fn remap_struct_ty(ty: i64, remap: &[usize]) -> i64 {
    use crate::c5::compiler::types::{STRUCT_BASE, STRUCT_STRIDE};
    use crate::c5::compiler::types::{UNSIGNED_BIT, VOLATILE_BIT};
    let unsigned = ty & UNSIGNED_BIT;
    let stripped = ty & !(UNSIGNED_BIT | VOLATILE_BIT);
    if stripped < STRUCT_BASE {
        return ty;
    }
    let old_id = ((stripped - STRUCT_BASE) / STRUCT_STRIDE) as usize;
    if old_id >= remap.len() {
        return ty;
    }
    let new_id = remap[old_id] as i64;
    let ptr_part = (stripped - STRUCT_BASE) % STRUCT_STRIDE;
    let rebased = STRUCT_BASE + new_id * STRUCT_STRIDE + ptr_part;
    rebased | unsigned
}

fn visit_expr_ty(expr: &mut Expr, f: &mut impl FnMut(&mut i64)) {
    match expr {
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
        | Expr::CheckedArith { ty, .. } => f(ty),
        Expr::VlaSizeof { .. } => {}
        Expr::Cast { to_ty, .. } => f(to_ty),
        Expr::CompoundLiteral { ty, init, .. } => {
            f(ty);
            if let LocalInit::Runtime { elements, .. } = init {
                for e in elements {
                    f(&mut e.ty);
                }
            }
        }
        Expr::Sizeof(_) => {}
        // No `ty` field; `&&label` is always a `void *`.
        Expr::LabelAddr(_) => {}
        // No `ty` field; the operand expressions carry their own.
        Expr::InlineAsm(_) => {}
    }
}

fn visit_decl_ty(decl: &mut Decl, f: &mut impl FnMut(&mut i64)) {
    match decl {
        Decl::Local { ty, init, .. } => {
            f(ty);
            if let LocalInit::Runtime { elements, .. } = init {
                for e in elements {
                    f(&mut e.ty);
                }
            }
        }
        Decl::Vla { elem_ty, .. } => f(elem_ty),
        Decl::StaticLocal { .. } => {}
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::BinOp;
    use crate::c5::token::Token;

    /// Hand-build `return a + 1;`: Ident + IntLit -> Binary ->
    /// Return statement. Confirms the arena indices line up and
    /// the source-position columns stay parallel.
    #[test]
    fn return_a_plus_one() {
        let mut ast = Ast::new();
        let src = SrcPos { line: 7, file: 0 };
        let a = ast.push_expr(
            Expr::Ident {
                sym: 42,
                ty: 1,
                class: Token::Loc as i64,
                val: -1,
                is_thread_local: false,
                array_size: 0,
            },
            src,
        );
        let one = ast.push_expr(Expr::IntLit { val: 1, ty: 1 }, src);
        let sum = ast.push_expr(
            Expr::Binary {
                op: BinOp::Add,
                lhs: a,
                rhs: one,
                ty: 1,
            },
            src,
        );
        let ret = ast.push_stmt(Stmt::Return(Some(sum)), src);
        ast.body = Some(ret);

        assert_eq!(ast.exprs.len(), 3);
        assert_eq!(ast.expr_src.len(), 3);
        assert_eq!(ast.stmts.len(), 1);
        assert!(matches!(ast.stmt(ret), Stmt::Return(Some(_))));
        if let Expr::Binary { lhs, rhs, .. } = ast.expr(sum) {
            assert_eq!(*lhs, a);
            assert_eq!(*rhs, one);
        } else {
            panic!("expected Binary at sum");
        }
    }

    /// Allocate two label ids before either is resolved (forward
    /// goto). Resolving one leaves the other pending; the slot
    /// shape matches what the parser will need during a
    /// `goto L1; ... goto L2; ... L1: ... L2: ...` sequence.
    #[test]
    fn label_forward_fixups() {
        let mut ast = Ast::new();
        let l1 = ast.alloc_label();
        let l2 = ast.alloc_label();
        assert_eq!(ast.goto_targets, alloc::vec![None, None]);
        let src = SrcPos { line: 1, file: 0 };
        let body1 = ast.push_stmt(Stmt::Break, src);
        ast.resolve_label(l1, body1);
        assert_eq!(ast.goto_targets[l1 as usize], Some(body1));
        assert_eq!(ast.goto_targets[l2 as usize], None);
    }
}
