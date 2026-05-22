//! Per-function AST.
//!
//! Built by the parser (`c5::compiler`) one function at a time and
//! consumed by `c5::ast::walk` (a separate file once added) to drive
//! `c5::codegen::ssa_build::SsaBuilder`. Replaces the stack-machine
//! bytecode tier as the canonical function-shaped IR; a follow-on
//! patch wires the parser onto it and retires the bytecode lift.
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

// Phase C1 lands the node definitions ahead of any consumer; the
// parser dual-emit (Phase C2) and the SSA walker (Phase C3) drive
// real use sites in follow-on patches. Until then every node is
// only reached from the unit tests at the bottom of this file.
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

/// Source position attached to every node. Mirrors the
/// `source_lines` / `source_file_indices` columns the bytecode tier
/// maintains today so DWARF emit keeps byte-for-byte fidelity.
#[derive(Debug, Clone, Copy, Default)]
pub(crate) struct SrcPos {
    /// 1-based source line.
    pub line: u32,
    /// Index into the translation unit's source-file table.
    pub file: u16,
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
    /// symbol table; the walker reads class / val from there to
    /// pick LocalAddr / ImmData / ImmCode.
    Ident { sym: u32, ty: i64 },
    /// `op child`, where `child` is the operand. Increment /
    /// decrement go through [`Expr::PreInc`] / [`Expr::PostInc`]
    /// instead.
    Unary { op: UnOp, child: ExprId, ty: i64 },
    /// `lhs op rhs`. C99 6.5 operator-by-operator semantics; `op`
    /// is already the post-usual-arithmetic-conversion variant
    /// the parser picked (e.g. `Add` vs `Fadd`).
    Binary {
        op: BinOp,
        lhs: ExprId,
        rhs: ExprId,
        ty: i64,
    },
    /// `cond ? then_e : else_e` (C99 6.5.15).
    Ternary {
        cond: ExprId,
        then_e: ExprId,
        else_e: ExprId,
        ty: i64,
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
    /// Compiler-builtin call (alloca, memset, setjmp, longjmp,
    /// ...). `kind` is the same integer tag the bytecode tier
    /// uses for `Op::Intrinsic`; the walker forwards it to
    /// `Inst::Intrinsic`.
    Intrinsic {
        kind: i64,
        args: Vec<ExprId>,
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
    Case { val: i64, body: StmtId },
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
    /// `label: body` (C99 6.8.1) -- the goto target.
    Labeled { label: LabelId, body: StmtId },
    /// Inline assembly. `text` is the assembler source; `clobbers`
    /// is the comma-separated clobber list. c5's asm shape stays
    /// the same as the bytecode tier carried.
    Asm {
        text: alloc::string::String,
        clobbers: alloc::string::String,
    },
}

/// Declaration node. Captures variable / function declarations
/// that the AST needs to surface to the walker as side-effecting
/// (e.g. local variables with initializers, VLAs with a runtime
/// dimension). Global declarations and type definitions stay in
/// the symbol table; only the bits the walker needs land here.
#[derive(Debug, Clone)]
pub(crate) enum Decl {
    /// Local variable declaration with an optional initializer.
    /// The slot offset is captured at parse time; the initializer
    /// (if present) is evaluated and assigned at the declaration
    /// site per C99 6.7.8.
    Local {
        sym: u32,
        slot_off: i64,
        init: Option<ExprId>,
    },
    /// Variable-length array declaration. `dim` is the runtime
    /// dimension expression; the walker emits `Inst::AllocaInit`
    /// to reserve the matching stack region. C99 6.7.6.2p4.
    Vla { sym: u32, dim: ExprId },
}

/// Per-function AST. One instance lives on the active function in
/// [`super::compiler::Compiler`]; dropped at function exit.
#[derive(Debug, Default, Clone)]
pub(crate) struct Ast {
    pub exprs: Vec<Expr>,
    pub stmts: Vec<Stmt>,
    pub decls: Vec<Decl>,
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

    pub(crate) fn stmt(&self, id: StmtId) -> &Stmt {
        &self.stmts[id as usize]
    }

    pub(crate) fn decl(&self, id: DeclId) -> &Decl {
        &self.decls[id as usize]
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::ir::BinOp;

    /// Hand-build `return a + 1;`: Ident + IntLit -> Binary ->
    /// Return statement. Confirms the arena indices line up and
    /// the source-position columns stay parallel.
    #[test]
    fn return_a_plus_one() {
        let mut ast = Ast::new();
        let src = SrcPos { line: 7, file: 0 };
        let a = ast.push_expr(Expr::Ident { sym: 42, ty: 1 }, src);
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
