//! `Ast` -> `FunctionSsa` walker.
//!
//! Drives `SsaBuilder` from a per-function AST. Stops at the first
//! unsupported shape and surfaces the offending node through
//! `WalkError` so the shadow-validator can tag exactly which AST
//! shape the dual-emit hasn't wired yet.
//!
//! Covers every expression variant the parser already populates in
//! Phase C2 (literals, identifiers, unary, binary, assignment) and
//! the matching `Stmt::Return`. Variants that the parser hasn't
//! wired yet -- Call, Member, Index, Cast, Ternary, PreInc /
//! PostInc, CompoundAssign, Sizeof, Comma, Intrinsic, plus every
//! statement other than Return -- come back as `Unsupported`.
//!
//! The walker doesn't manage control-flow blocks beyond what the
//! Phase C2 surface needs; the for / while / if / switch
//! lowerings land alongside their parser-side dual-emit in
//! follow-on patches.

#![allow(dead_code)]

use alloc::string::String;

use super::super::codegen::Target;
use super::super::ir::{BinOp, FunctionSsa, LoadKind, StoreKind};
use super::super::symbol::Symbol;
use super::super::token::{Token, Ty};
use super::{Expr, ExprId, Stmt, StmtId, UnOp};

/// Diagnostic for a shape the walker can't lower yet. Carries
/// enough context to point at the offending AST node so the
/// shadow-validator can route the dual-emit gap back to a parser
/// site.
#[derive(Debug)]
pub(crate) enum WalkError {
    UnsupportedExpr { id: ExprId, kind: &'static str },
    UnsupportedStmt { id: StmtId, kind: &'static str },
    UnknownSymbolClass { sym: u32, class: i64 },
    UnsupportedSymbolShape { sym: u32, reason: &'static str },
}

impl core::fmt::Display for WalkError {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        match self {
            WalkError::UnsupportedExpr { id, kind } => {
                write!(f, "ast::walk: expression #{id} ({kind}) not yet supported")
            }
            WalkError::UnsupportedStmt { id, kind } => {
                write!(f, "ast::walk: statement #{id} ({kind}) not yet supported")
            }
            WalkError::UnknownSymbolClass { sym, class } => {
                write!(f, "ast::walk: symbol #{sym} class {class} not recognised",)
            }
            WalkError::UnsupportedSymbolShape { sym, reason } => {
                write!(f, "ast::walk: symbol #{sym}: {reason}")
            }
        }
    }
}

impl WalkError {
    pub(crate) fn into_string(self) -> String {
        alloc::format!("{self}")
    }
}

/// Run a per-function AST through `SsaBuilder` and return the
/// resulting `FunctionSsa`. `n_params` and `is_variadic` come from
/// the function's declarator; `n_locals` is the post-parse local
/// slot count (`max_loc_offs`). `ent_pc` is the function's
/// bytecode-tier entry PC -- the SSA emit threads it through to
/// keep call-site fixups byte-for-byte compatible with the lift.
///
/// During Phase C2 the AST is incomplete: stmts other than
/// `Return` aren't pushed yet, control-flow nesting isn't built,
/// and many expression shapes are missing. The walker iterates
/// `ast.stmts` flat (no nested blocks) and returns the first
/// unsupported shape rather than fabricating a value.
pub(crate) fn walk_function(
    ast: &super::Ast,
    symbols: &[Symbol],
    target: Target,
    ent_pc: usize,
    n_params: usize,
    is_variadic: bool,
    n_locals: i64,
) -> Result<FunctionSsa, WalkError> {
    let mut b = super::super::codegen::ssa_build::SsaBuilder::new(ent_pc, n_params, is_variadic);
    if n_locals != 0 {
        b.set_locals(n_locals);
    }
    let ctx = Walker {
        ast,
        symbols,
        target,
    };
    // Stmt walker is structured to terminate when it sees a
    // `Stmt::Return`; everything before that contributes side
    // effects. A function with no Return falls off the end -- we
    // synthesize a `return 0` to keep the FunctionSsa well-formed
    // (every block needs a terminator; the entry block stays open
    // otherwise).
    let mut returned = false;
    for (i, _) in ast.stmts.iter().enumerate() {
        let terminated = ctx.walk_stmt(&mut b, i as StmtId)?;
        if terminated {
            returned = true;
            break;
        }
    }
    if !returned {
        let zero = b.imm(0);
        b.return_(zero);
    }
    Ok(b.finish())
}

/// Per-walk read-only context: the AST + symbol table + target,
/// passed by reference into the recursive walkers so the
/// SsaBuilder borrow stays exclusive to one method.
struct Walker<'a> {
    ast: &'a super::Ast,
    symbols: &'a [Symbol],
    target: Target,
}

impl<'a> Walker<'a> {
    /// Walk a statement. Returns `true` when the statement
    /// terminates the current block (an unconditional return /
    /// jmp), letting the caller stop iterating siblings that
    /// would otherwise emit dead code.
    fn walk_stmt(
        &self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: StmtId,
    ) -> Result<bool, WalkError> {
        match self.ast.stmt(id) {
            Stmt::Return(Some(e)) => {
                let v = self.walk_expr_rvalue(b, *e)?;
                b.return_(v);
                Ok(true)
            }
            Stmt::Return(None) => {
                let zero = b.imm(0);
                b.return_(zero);
                Ok(true)
            }
            Stmt::Expr(e) => {
                // C99 6.8.3: expression statement evaluates the
                // expression for side effects and discards the
                // value. The walker emits the side-effecting
                // chain; the SSA DCE pass drops the dead final
                // value if it has no other uses.
                let _ = self.walk_expr_rvalue(b, *e)?;
                Ok(false)
            }
            Stmt::Compound(items) => {
                for item in items {
                    match item {
                        super::BlockItem::Stmt(s) => {
                            if self.walk_stmt(b, *s)? {
                                return Ok(true);
                            }
                        }
                        super::BlockItem::Decl(_) => {
                            return Err(WalkError::UnsupportedStmt {
                                id,
                                kind: "Compound{Decl}",
                            });
                        }
                    }
                }
                Ok(false)
            }
            Stmt::If { .. } => Err(WalkError::UnsupportedStmt { id, kind: "If" }),
            Stmt::While { .. } => Err(WalkError::UnsupportedStmt { id, kind: "While" }),
            Stmt::DoWhile { .. } => Err(WalkError::UnsupportedStmt {
                id,
                kind: "DoWhile",
            }),
            Stmt::For { .. } => Err(WalkError::UnsupportedStmt { id, kind: "For" }),
            Stmt::Switch { .. } => Err(WalkError::UnsupportedStmt { id, kind: "Switch" }),
            Stmt::Case { .. } => Err(WalkError::UnsupportedStmt { id, kind: "Case" }),
            Stmt::Default { .. } => Err(WalkError::UnsupportedStmt {
                id,
                kind: "Default",
            }),
            Stmt::Break => Err(WalkError::UnsupportedStmt { id, kind: "Break" }),
            Stmt::Continue => Err(WalkError::UnsupportedStmt {
                id,
                kind: "Continue",
            }),
            Stmt::Goto(_) => Err(WalkError::UnsupportedStmt { id, kind: "Goto" }),
            Stmt::Labeled { .. } => Err(WalkError::UnsupportedStmt {
                id,
                kind: "Labeled",
            }),
            Stmt::Asm { .. } => Err(WalkError::UnsupportedStmt { id, kind: "Asm" }),
        }
    }

    /// Walk an expression in rvalue position. Returns the
    /// `ValueId` whose runtime value matches what the bytecode
    /// tier would have left in the c5 accumulator.
    fn walk_expr_rvalue(
        &self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        match self.ast.expr(id) {
            Expr::IntLit { val, .. } => Ok(b.imm(*val)),
            Expr::FloatLit { bits, .. } => Ok(b.imm(*bits as i64)),
            Expr::StrLit { data_off, .. } => Ok(b.imm_data(*data_off)),
            Expr::Ident {
                sym,
                ty,
                class,
                val,
                is_thread_local,
            } => self.load_ident_rvalue(b, *sym, *ty, *class, *val, *is_thread_local),
            Expr::Unary { op, child, ty } => self.walk_unary(b, *op, *child, *ty),
            Expr::Binary { op, lhs, rhs, .. } => {
                let lv = self.walk_expr_rvalue(b, *lhs)?;
                let rv = self.walk_expr_rvalue(b, *rhs)?;
                Ok(b.binop(*op, lv, rv))
            }
            Expr::Assign { lhs, rhs, ty } => {
                let addr = self.walk_expr_lvalue(b, *lhs)?;
                let value = self.walk_expr_rvalue(b, *rhs)?;
                let kind = store_kind_for(*ty, self.target);
                b.store(addr, value, kind);
                // C99 6.5.16p3: the assignment's value is the
                // value stored, after any conversion the rhs walker
                // already applied.
                Ok(value)
            }
            Expr::Ternary { .. } => Err(WalkError::UnsupportedExpr {
                id,
                kind: "Ternary",
            }),
            Expr::Call { .. } => Err(WalkError::UnsupportedExpr { id, kind: "Call" }),
            Expr::Member { .. } => Err(WalkError::UnsupportedExpr { id, kind: "Member" }),
            Expr::Index { .. } => Err(WalkError::UnsupportedExpr { id, kind: "Index" }),
            Expr::Cast { .. } => Err(WalkError::UnsupportedExpr { id, kind: "Cast" }),
            Expr::CompoundAssign { .. } => Err(WalkError::UnsupportedExpr {
                id,
                kind: "CompoundAssign",
            }),
            Expr::PreInc { lvalue, by, ty } => {
                let addr = self.walk_expr_lvalue(b, *lvalue)?;
                let kind = load_kind_for(*ty, self.target);
                let old = b.load(addr, kind);
                let stepped = b.binop_imm(BinOp::Add, old, *by);
                let store_kind = store_kind_for(*ty, self.target);
                b.store(addr, stepped, store_kind);
                Ok(stepped)
            }
            Expr::PostInc { .. } => Err(WalkError::UnsupportedExpr {
                id,
                kind: "PostInc",
            }),
            Expr::Sizeof(s) => Ok(b.imm(s.size_bytes)),
            Expr::Comma { lhs, rhs, .. } => {
                let _ = self.walk_expr_rvalue(b, *lhs)?;
                self.walk_expr_rvalue(b, *rhs)
            }
            Expr::Intrinsic { .. } => Err(WalkError::UnsupportedExpr {
                id,
                kind: "Intrinsic",
            }),
        }
    }

    /// Walk an expression in lvalue position -- the result is the
    /// `ValueId` of the lvalue's *address*. The `Assign` rhs and
    /// `Unary{AddrOf}` cases drive into this path; the rvalue
    /// walker re-enters from this address with a matching load.
    fn walk_expr_lvalue(
        &self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
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
            // lhs reaches the walker as `Binary{Add, t, off}` (or
            // an `Index` for `arr[i]`). The Binary's value IS the
            // address per C99 6.5.6 pointer-plus-integer; storing
            // through it matches the bytecode tier's address
            // computation followed by `Op::Si`/etc.
            Expr::Binary { .. } | Expr::Index { .. } => self.walk_expr_rvalue(b, id),
            other => Err(WalkError::UnsupportedExpr {
                id,
                kind: lvalue_shape_label(other),
            }),
        }
    }

    /// Walk a `Expr::Unary` rvalue. AddrOf hands off to the
    /// lvalue walk; Deref loads from the rvalue-shaped address;
    /// Neg / BitNot / LogNot lower to a binop against an
    /// immediate.
    fn walk_unary(
        &self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        op: UnOp,
        child: ExprId,
        ty: i64,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        match op {
            UnOp::Neg => {
                let v = self.walk_expr_rvalue(b, child)?;
                if is_floating_scalar(ty) {
                    Ok(b.fneg(v))
                } else {
                    let zero = b.imm(0);
                    Ok(b.binop(BinOp::Sub, zero, v))
                }
            }
            UnOp::BitNot => {
                let v = self.walk_expr_rvalue(b, child)?;
                let all_ones = b.imm(-1);
                Ok(b.binop(BinOp::Xor, v, all_ones))
            }
            UnOp::LogNot => {
                let v = self.walk_expr_rvalue(b, child)?;
                let zero = b.imm(0);
                Ok(b.binop(BinOp::Eq, v, zero))
            }
            UnOp::AddrOf => self.walk_expr_lvalue(b, child),
            UnOp::Deref => {
                let addr = self.walk_expr_rvalue(b, child)?;
                let kind = load_kind_for(ty, self.target);
                Ok(b.load(addr, kind))
            }
        }
    }

    /// Address-of for an identifier. Locals lower to a
    /// `local_addr` against the symbol's slot offset; globals to
    /// an `imm_data` against the symbol's data offset; functions
    /// to an `imm_code` against the function's bytecode PC.
    /// Token::Sys and TLS variants surface as unsupported until
    /// their walker arms land.
    fn ident_address(
        &self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        id: ExprId,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        let Expr::Ident {
            sym,
            class,
            val,
            is_thread_local,
            ..
        } = self.ast.expr(id)
        else {
            return Err(WalkError::UnsupportedExpr {
                id,
                kind: lvalue_shape_label(self.ast.expr(id)),
            });
        };
        if *class == Token::Loc as i64 {
            Ok(b.local_addr(*val))
        } else if *class == Token::Glo as i64 {
            if *is_thread_local {
                Ok(b.tls_addr(*val))
            } else {
                Ok(b.imm_data(*val))
            }
        } else if *class == Token::Fun as i64 {
            Ok(b.imm_code(*val as usize))
        } else {
            Err(WalkError::UnknownSymbolClass {
                sym: *sym,
                class: *class,
            })
        }
    }

    /// Identifier rvalue: take the address, load through the
    /// type-appropriate `LoadKind`. The bytecode tier's `Op::Lea
    /// N; Op::Li` (etc.) collapses into this one address + load
    /// pair on the SSA side. Reads `class` / `val` /
    /// `is_thread_local` straight off the snapshotted Ident node
    /// so a post-parse scope-exit that restored the symbol's
    /// pre-declaration tag doesn't invalidate the walker.
    fn load_ident_rvalue(
        &self,
        b: &mut super::super::codegen::ssa_build::SsaBuilder,
        sym: u32,
        ty: i64,
        class: i64,
        val: i64,
        is_thread_local: bool,
    ) -> Result<super::super::ir::ValueId, WalkError> {
        // Wrap the snapshot fields in a synthetic Symbol-shaped
        // tuple by branching directly on `class`; the function
        // is purely a fan-out over the recognised classes.
        if class == Token::Loc as i64 {
            let kind = load_kind_for(ty, self.target);
            Ok(b.load_local(val, kind))
        } else if class == Token::Glo as i64 && !is_thread_local {
            let addr = b.imm_data(val);
            let kind = load_kind_for(ty, self.target);
            Ok(b.load(addr, kind))
        } else if class == Token::Glo as i64 && is_thread_local {
            let addr = b.tls_addr(val);
            let kind = load_kind_for(ty, self.target);
            Ok(b.load(addr, kind))
        } else if class == Token::Fun as i64 {
            Ok(b.imm_code(val as usize))
        } else if class == Token::Num as i64 {
            // Enum constants and `#define`-via-const-decl idioms
            // both surface as `Token::Num`-class symbols; `val`
            // holds the resolved integer constant.
            Ok(b.imm(val))
        } else {
            Err(WalkError::UnknownSymbolClass { sym, class })
        }
    }
}

/// Map a c5 type tag to the matching `LoadKind`. Mirrors
/// `compiler::types::load_op_for` but produces the SSA-side enum
/// directly so the walker doesn't have to round-trip through
/// `Op::*`.
fn load_kind_for(ty: i64, target: Target) -> LoadKind {
    let unsigned = (ty & UNSIGNED_BIT) != 0;
    let stripped = ty & !UNSIGNED_BIT;
    if is_pointer_ty(ty) {
        return LoadKind::I64;
    }
    if stripped == Ty::Char as i64 {
        if unsigned { LoadKind::U8 } else { LoadKind::I8 }
    } else if stripped == Ty::Short as i64 {
        if unsigned {
            LoadKind::U16
        } else {
            LoadKind::I16
        }
    } else if stripped == Ty::Int as i64 {
        if unsigned {
            LoadKind::U32
        } else {
            LoadKind::I32
        }
    } else if stripped == Ty::Float as i64 {
        LoadKind::F32
    } else if stripped == Ty::Long as i64 && target.is_windows() {
        if unsigned {
            LoadKind::U32
        } else {
            LoadKind::I32
        }
    } else {
        LoadKind::I64
    }
}

/// Mirror of [`load_kind_for`] for stores.
fn store_kind_for(ty: i64, target: Target) -> StoreKind {
    let stripped = ty & !UNSIGNED_BIT;
    if is_pointer_ty(ty) {
        return StoreKind::I64;
    }
    if stripped == Ty::Char as i64 {
        StoreKind::I8
    } else if stripped == Ty::Short as i64 {
        StoreKind::I16
    } else if stripped == Ty::Int as i64 {
        StoreKind::I32
    } else if stripped == Ty::Float as i64 {
        StoreKind::F32
    } else if stripped == Ty::Long as i64 && target.is_windows() {
        StoreKind::I32
    } else {
        StoreKind::I64
    }
}

/// Test for a pointer-shaped type tag. Pointer levels add to the
/// base in the C99-aligned encoding `compiler::types::is_pointer_ty`
/// uses; mirroring it here keeps the walker self-contained.
fn is_pointer_ty(ty: i64) -> bool {
    let stripped = ty & !UNSIGNED_BIT;
    // The token::Ty band scheme reserves [base, base+100) per
    // type family; a stripped `ty` whose remainder mod 100 is >= 2
    // is a pointer at depth (remainder / 2).
    let base = stripped - (stripped % 100);
    let off = stripped - base;
    off >= 2 && (off % 2) == 0
}

/// Test for floating-point scalar types.
fn is_floating_scalar(ty: i64) -> bool {
    let stripped = ty & !UNSIGNED_BIT;
    stripped == Ty::Float as i64 || stripped == Ty::Double as i64
}

/// `Token::Ty` unsigned-bit position. The compiler-side helper is
/// `pub(super)`-visible to the parser module only; the walker
/// keeps a local copy to avoid coupling to the compiler module.
const UNSIGNED_BIT: i64 = 1 << 30;

fn lvalue_shape_label(expr: &Expr) -> &'static str {
    match expr {
        Expr::IntLit { .. } => "IntLit",
        Expr::FloatLit { .. } => "FloatLit",
        Expr::StrLit { .. } => "StrLit",
        Expr::Ident { .. } => "Ident",
        Expr::Unary { .. } => "Unary",
        Expr::Binary { .. } => "Binary",
        Expr::Ternary { .. } => "Ternary",
        Expr::Call { .. } => "Call",
        Expr::Member { .. } => "Member",
        Expr::Index { .. } => "Index",
        Expr::Cast { .. } => "Cast",
        Expr::Assign { .. } => "Assign",
        Expr::CompoundAssign { .. } => "CompoundAssign",
        Expr::PreInc { .. } => "PreInc",
        Expr::PostInc { .. } => "PostInc",
        Expr::Sizeof(_) => "Sizeof",
        Expr::Comma { .. } => "Comma",
        Expr::Intrinsic { .. } => "Intrinsic",
    }
}

#[cfg(test)]
mod tests {
    use super::super::super::ir::{BinOp, Inst};
    use super::super::super::symbol::Symbol;
    use super::super::super::token::Token;
    use super::super::Ast;
    use super::super::*;
    use super::*;

    fn empty_symbols() -> alloc::vec::Vec<Symbol> {
        alloc::vec::Vec::new()
    }

    /// `return 7 + 3;` -- walker produces two Imm + one Add binop
    /// and a Return terminator on the entry block. Locks the
    /// expression recursion + the basic Return wiring.
    #[test]
    fn return_constant_add() {
        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let seven = ast.push_expr(Expr::IntLit { val: 7, ty: 1 }, src);
        let three = ast.push_expr(Expr::IntLit { val: 3, ty: 1 }, src);
        let add = ast.push_expr(
            Expr::Binary {
                op: BinOp::Add,
                lhs: seven,
                rhs: three,
                ty: 1,
            },
            src,
        );
        ast.push_stmt(Stmt::Return(Some(add)), src);

        let func = walk_function(&ast, &empty_symbols(), Target::LinuxAarch64, 0, 0, false, 0)
            .expect("walk");
        let immediates: alloc::vec::Vec<i64> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Imm(v) => Some(*v),
                _ => None,
            })
            .collect();
        assert_eq!(immediates, alloc::vec![7i64, 3]);
        let binops: alloc::vec::Vec<BinOp> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Binop { op, .. } => Some(*op),
                _ => None,
            })
            .collect();
        assert_eq!(binops, alloc::vec![BinOp::Add]);
    }

    /// Identifier rvalue against a local symbol: walker emits a
    /// `LoadLocal { off, kind: I32 }` for an `int` local.
    #[test]
    fn local_int_ident_loads() {
        let mut syms = empty_symbols();
        syms.push(Symbol {
            name: alloc::string::String::from("x"),
            class: Token::Loc as i64,
            type_: Ty::Int as i64,
            val: -1,
            ..Default::default()
        });

        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let x = ast.push_expr(
            Expr::Ident {
                sym: 0,
                ty: Ty::Int as i64,
                class: Token::Loc as i64,
                val: -1,
                is_thread_local: false,
            },
            src,
        );
        ast.push_stmt(Stmt::Return(Some(x)), src);

        let func = walk_function(&ast, &syms, Target::LinuxAarch64, 0, 0, false, 8).expect("walk");
        let loads: alloc::vec::Vec<_> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::LoadLocal { off, kind } => Some((*off, *kind)),
                _ => None,
            })
            .collect();
        assert_eq!(loads, alloc::vec![(-1, LoadKind::I32)]);
    }

    /// Assignment lowers as: address-of-lhs + value-of-rhs + Store.
    #[test]
    fn local_int_assign_emits_store() {
        let mut syms = empty_symbols();
        syms.push(Symbol {
            name: alloc::string::String::from("x"),
            class: Token::Loc as i64,
            type_: Ty::Int as i64,
            val: -1,
            ..Default::default()
        });

        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let lhs = ast.push_expr(
            Expr::Ident {
                sym: 0,
                ty: Ty::Int as i64,
                class: Token::Loc as i64,
                val: -1,
                is_thread_local: false,
            },
            src,
        );
        let rhs = ast.push_expr(
            Expr::IntLit {
                val: 42,
                ty: Ty::Int as i64,
            },
            src,
        );
        let assign = ast.push_expr(
            Expr::Assign {
                lhs,
                rhs,
                ty: Ty::Int as i64,
            },
            src,
        );
        ast.push_stmt(Stmt::Return(Some(assign)), src);

        let func = walk_function(&ast, &syms, Target::LinuxAarch64, 0, 0, false, 8).expect("walk");
        let store_kinds: alloc::vec::Vec<_> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Store { kind, .. } => Some(*kind),
                _ => None,
            })
            .collect();
        assert_eq!(store_kinds, alloc::vec![StoreKind::I32]);
        // The Return's value should reach the same Imm 42 the
        // assignment used (C99 6.5.16p3 says the assignment
        // expression's value is the value stored).
        let immediates: alloc::vec::Vec<i64> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Imm(v) => Some(*v),
                _ => None,
            })
            .collect();
        assert!(immediates.contains(&42));
    }

    /// Unary negation: walker lowers `-x` as `0 - x`. Locks the
    /// Neg dispatch path.
    #[test]
    fn unary_neg_lowers_to_sub() {
        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let lit = ast.push_expr(
            Expr::IntLit {
                val: 5,
                ty: Ty::Int as i64,
            },
            src,
        );
        let neg = ast.push_expr(
            Expr::Unary {
                op: UnOp::Neg,
                child: lit,
                ty: Ty::Int as i64,
            },
            src,
        );
        ast.push_stmt(Stmt::Return(Some(neg)), src);

        let func = walk_function(&ast, &empty_symbols(), Target::LinuxAarch64, 0, 0, false, 0)
            .expect("walk");
        let binops: alloc::vec::Vec<BinOp> = func
            .insts
            .iter()
            .filter_map(|i| match i {
                Inst::Binop { op, .. } => Some(*op),
                _ => None,
            })
            .collect();
        assert_eq!(binops, alloc::vec![BinOp::Sub]);
    }

    /// An unsupported statement (e.g. `If`) surfaces as a
    /// `WalkError::UnsupportedStmt` so the validator can route the
    /// gap back to a parser site. The unsupported stmt must
    /// precede any terminator so the walker actually visits it.
    #[test]
    fn unsupported_stmt_returns_error() {
        let mut ast = Ast::new();
        let src = SrcPos { line: 1, file: 0 };
        let z = ast.push_expr(
            Expr::IntLit {
                val: 0,
                ty: Ty::Int as i64,
            },
            src,
        );
        // Body of the If first, then the If itself; the If sits
        // ahead of any Return statement so the walker's
        // terminator-shortcut doesn't skip past it.
        let body = ast.push_stmt(Stmt::Return(Some(z)), src);
        let if_id = ast.push_stmt(
            Stmt::If {
                cond: z,
                then_s: body,
                else_s: None,
            },
            src,
        );
        // The walker iterates `ast.stmts` in declaration order;
        // since we appended `body` before `if_id` the body's
        // return would terminate first. Swap their slots so the
        // walker reaches the If before any Return.
        ast.stmts.swap(body as usize, if_id as usize);

        let err = walk_function(&ast, &empty_symbols(), Target::LinuxAarch64, 0, 0, false, 0)
            .expect_err("If must surface as unsupported");
        assert!(matches!(err, WalkError::UnsupportedStmt { kind: "If", .. }));
    }
}
