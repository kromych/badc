use super::super::super::ir::{BinOp, Inst};
use super::super::super::symbol::Symbol;
use super::super::super::token::Token;
use super::super::Ast;
use super::super::*;
use super::*;

fn empty_symbols() -> alloc::vec::Vec<Symbol> {
    alloc::vec::Vec::new()
}

/// `return 7 + 3;` -- both operands are integer literals,
/// so C99 6.6 constant evaluation kicks in and the walker
/// emits a single `Imm(10)` without producing the binop at
/// all.
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
    let __ret = ast.push_stmt(Stmt::Return(Some(add)), src);
    ast.body = Some(__ret);

    let func = walk_function(
        &FinishedFunction {
            ast,
            n_locals: 0,
            return_ty: Ty::Int as i64,
            ..Default::default()
        },
        &empty_symbols(),
        &[],
        Target::LinuxAarch64,
        false,
        true,
    )
    .expect("walk");
    let immediates: alloc::vec::Vec<i64> = func
        .insts
        .iter()
        .filter_map(|i| match i {
            Inst::Imm(v) => Some(*v),
            _ => None,
        })
        .collect();
    // The walker folds `7 + 3` to the single value 10 -- no
    // binop, just one `Imm`.
    assert_eq!(immediates, alloc::vec![10i64]);
    let any_binop = func
        .insts
        .iter()
        .any(|i| matches!(i, Inst::Binop { .. } | Inst::BinopI { .. }));
    assert!(!any_binop, "constant-fold should leave no binop");
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
            array_size: 0,
        },
        src,
    );
    let __ret = ast.push_stmt(Stmt::Return(Some(x)), src);
    ast.body = Some(__ret);

    let func = walk_function(
        &FinishedFunction {
            ast,
            n_locals: 8,
            ..Default::default()
        },
        &syms,
        &[],
        Target::LinuxAarch64,
        false,
        true,
    )
    .expect("walk");
    let loads: alloc::vec::Vec<_> = func
        .insts
        .iter()
        .filter_map(|i| match i {
            Inst::LoadLocal { off, kind, .. } => Some((*off, *kind)),
            _ => None,
        })
        .collect();
    assert_eq!(loads, alloc::vec![(-1, LoadKind::I32)]);
}

/// A scalar local assignment lowers to a single fused
/// `StoreLocal` of the value's natural width.
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
            array_size: 0,
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
    let __ret = ast.push_stmt(Stmt::Return(Some(assign)), src);
    ast.body = Some(__ret);

    let func = walk_function(
        &FinishedFunction {
            ast,
            n_locals: 8,
            ..Default::default()
        },
        &syms,
        &[],
        Target::LinuxAarch64,
        false,
        true,
    )
    .expect("walk");
    let store_kinds: alloc::vec::Vec<_> = func
        .insts
        .iter()
        .filter_map(|i| match i {
            Inst::StoreLocal { off, kind, .. } => Some((*off, *kind)),
            _ => None,
        })
        .collect();
    assert_eq!(store_kinds, alloc::vec![(-1, StoreKind::I32)]);
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
    let __ret = ast.push_stmt(Stmt::Return(Some(neg)), src);
    ast.body = Some(__ret);

    let func = walk_function(
        &FinishedFunction {
            ast,
            n_locals: 0,
            ..Default::default()
        },
        &empty_symbols(),
        &[],
        Target::LinuxAarch64,
        false,
        true,
    )
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

/// A statement shape the parser never produces (`Asm`) surfaces as a
/// `WalkError::InvalidStmt` so the validator can route the gap back to
/// a parser site, and it is reported as an internal error.
#[test]
fn unsupported_stmt_returns_error() {
    let mut ast = Ast::new();
    let src = SrcPos { line: 1, file: 0 };
    let asm_id = ast.push_stmt(
        Stmt::Asm {
            text: alloc::string::String::new(),
            clobbers: alloc::string::String::new(),
        },
        src,
    );
    ast.body = Some(asm_id);

    let err = walk_function(
        &FinishedFunction {
            ast,
            n_locals: 0,
            ..Default::default()
        },
        &empty_symbols(),
        &[],
        Target::LinuxAarch64,
        false,
        true,
    )
    .expect_err("Asm must surface as unsupported");
    assert!(matches!(err, WalkError::InvalidStmt { kind: "Asm", .. }));
    assert!(err.is_internal());
}
