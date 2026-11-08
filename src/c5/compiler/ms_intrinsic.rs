//! A call of a call-site intrinsic (`crate::c5::ms_intrinsic`): the arguments
//! convert as for its prototype and the call becomes the operation's node.

use alloc::format;
use alloc::vec::Vec;

use super::super::ast::{AtomicKind, Expr, ExprId};
use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::ir::BinOp;
use super::super::ms_intrinsic::{self, Op, Param, Scalar};
use super::super::op::Intrinsic;
use super::super::token::Ty;
use super::Compiler;
use super::types::{
    CONST_BIT, UNSIGNED_BIT, VOLATILE_BIT, add_ptr_level, apply_qual_bits, plain_char_ty,
    void_ptr_ty, void_ty,
};

enum Operand {
    Value(ExprId),
    Constant(i64),
}

impl Compiler {
    /// Whether a call of `name` lowers to its intrinsic: `#pragma function`
    /// makes it a call of the function.
    pub(super) fn is_call_site_intrinsic(&self, name: &str) -> bool {
        super::super::preprocessor::builtins::is_ms_intrinsic(name, self.target)
            && !self.pp_functions.contains(name)
    }

    fn ms_scalar_ty(&self, s: Scalar) -> i64 {
        let unsigned = |t: Ty| t as i64 | UNSIGNED_BIT;
        match s {
            Scalar::Char => plain_char_ty(self.lex.char_signed),
            Scalar::UChar => unsigned(Ty::Char),
            Scalar::Short => Ty::Short as i64,
            Scalar::UShort => unsigned(Ty::Short),
            Scalar::Int => Ty::Int as i64,
            Scalar::UInt => unsigned(Ty::Int),
            Scalar::Long => Ty::Long as i64,
            Scalar::ULong => unsigned(Ty::Long),
            Scalar::LLong => Ty::LongLong as i64,
            Scalar::ULLong => unsigned(Ty::LongLong),
            Scalar::VoidPtr => void_ptr_ty(),
        }
    }

    fn ms_param_ty(&self, p: Param) -> i64 {
        match p {
            Param::Ptr {
                to,
                konst,
                volatile,
            } => {
                let quals =
                    if konst { CONST_BIT } else { 0 } | if volatile { VOLATILE_BIT } else { 0 };
                add_ptr_level(apply_qual_bits(self.ms_scalar_ty(to), quals))
            }
            Param::Value(s) => self.ms_scalar_ty(s),
            Param::Constant(_) => Ty::Int as i64,
        }
    }

    /// The constant operand at `pos`, from 0 to `max`.
    fn ms_constant(&mut self, name: &str, pos: usize, max: i64) -> Result<i64, C5Error> {
        let line = self.lex.line;
        let text = match self.parse_constant_int() {
            Ok(v) if (0..=max).contains(&v) => return Ok(v),
            Ok(v) => format!("argument {} of `{name}` is {v}, not 0 to {max}", pos + 1),
            Err(_) => format!(
                "argument {} of `{name}` is not an integer constant expression",
                pos + 1
            ),
        };
        Err(self.compile_err_at(Code::INVALID_ARGUMENTS, line, text))
    }

    /// A call of the intrinsic `name`, the `(` consumed.
    pub(super) fn parse_ms_intrinsic(&mut self, name: &str) -> Result<(), C5Error> {
        let intr = ms_intrinsic::lookup(name, self.target).expect("a call-site intrinsic");
        self.check_seh_intrinsic(intr.op, name)?;
        match intr.op {
            Op::Assume => return self.parse_ms_assume(),
            Op::Noop => return self.parse_ms_noop(),
            Op::VaStart => return self.parse_ms_va_start(name),
            _ => {}
        }
        let mut operands = Vec::new();
        if self.lex.tk != ')' {
            loop {
                let pos = operands.len();
                let Some(&param) = intr.params.get(pos) else {
                    let text = format!(
                        "too many arguments to `{name}` (expected {})",
                        intr.params.len()
                    );
                    return Err(self.compile_err(Code::INVALID_ARGUMENTS, text));
                };
                operands.push(match param {
                    Param::Constant(max) => Operand::Constant(self.ms_constant(name, pos, max)?),
                    p => {
                        let ty = self.ms_param_ty(p);
                        Operand::Value(self.parse_builtin_value(name, pos, ty)?)
                    }
                });
                if !self.list_separator(')', "argument")? {
                    break;
                }
            }
        }
        if operands.len() < intr.params.len() {
            let text = format!(
                "too few arguments to `{name}` (expected {}, got {})",
                intr.params.len(),
                operands.len()
            );
            return Err(self.compile_err(Code::INVALID_ARGUMENTS, text));
        }
        self.next()?;
        self.mark_emit_other();
        let ret = intr.ret.map_or_else(void_ty, |s| self.ms_scalar_ty(s));
        let mut args = Vec::new();
        let mut imm = 0;
        for o in operands {
            match o {
                Operand::Value(e) => args.push(e),
                Operand::Constant(v) => imm = v,
            }
        }
        let intrinsic = |c: &mut Self, kind: Intrinsic, ty: i64| {
            c.ast_node(Expr::Intrinsic {
                kind: kind as i64,
                args: Vec::new(),
                ty,
            })
        };
        let id = match intr.op {
            Op::CompilerBarrier => intrinsic(self, Intrinsic::AtomicSignalFence, ret),
            Op::ReturnAddress => intrinsic(self, Intrinsic::ReturnAddress, ret),
            Op::AddressOfReturnAddress => {
                let u64_ty = Ty::LongLong as i64 | UNSIGNED_BIT;
                let frame = intrinsic(self, Intrinsic::FrameAddress, ret);
                let frame = self.ast_node(Expr::Cast {
                    child: frame,
                    to_ty: u64_ty,
                });
                let slot = self.ast_node(Expr::IntLit { val: 8, ty: u64_ty });
                let sum = self.ast_binary(BinOp::Add, frame, slot, u64_ty);
                self.ast_node(Expr::Cast {
                    child: sum,
                    to_ty: ret,
                })
            }
            Op::Atomic { kind, order, one } => {
                let Param::Ptr { to, .. } = intr.params[0] else {
                    unreachable!("an atomic intrinsic's object pointer")
                };
                let elem_ty = self.ms_scalar_ty(to);
                if one {
                    let one = self.ast_node(Expr::IntLit {
                        val: 1,
                        ty: elem_ty,
                    });
                    args.push(one);
                } else if kind == AtomicKind::SyncCasVal {
                    args.swap(1, 2);
                }
                self.ast_node(Expr::Atomic {
                    kind,
                    args,
                    elem_ty,
                    ty: ret,
                    order,
                })
            }
            op => self.ast_node(Expr::MsIntrinsic {
                op,
                args,
                imm,
                ty: ret,
            }),
        };
        self.ty = ret;
        self.ast_acc = Some(id);
        Ok(())
    }

    /// `__assume(e)`, the `(` consumed: `e` is unevaluated, and the constant
    /// 0 marks the call unreachable, as `__builtin_unreachable()` does.
    fn parse_ms_assume(&mut self) -> Result<(), C5Error> {
        let constant = self.discard_unevaluated_expr()?;
        if self.lex.tk != ')' {
            return Err(self.compile_err(Code::INVALID_ARGUMENTS, "`__assume` takes one argument"));
        }
        self.next()?;
        self.mark_emit_other();
        let void = void_ty();
        let id = if constant == Some(0) {
            self.ast_node(Expr::Intrinsic {
                kind: Intrinsic::Trap as i64,
                args: Vec::new(),
                ty: void,
            })
        } else {
            let zero = self.ast_node(Expr::IntLit {
                val: 0,
                ty: Ty::Int as i64,
            });
            self.ast_node(Expr::Cast {
                child: zero,
                to_ty: void,
            })
        };
        self.ty = void;
        self.ast_acc = Some(id);
        Ok(())
    }

    /// `__noop(...)`, the `(` consumed: the arguments are unevaluated and
    /// the value is the `int` 0.
    fn parse_ms_noop(&mut self) -> Result<(), C5Error> {
        if self.lex.tk != ')' {
            loop {
                self.discard_unevaluated_expr()?;
                if !self.list_separator(')', "argument")? {
                    break;
                }
            }
        }
        self.next()?;
        self.mark_emit_other();
        let int = Ty::Int as i64;
        self.ty = int;
        self.ast_acc = Some(self.ast_node(Expr::IntLit { val: 0, ty: int }));
        Ok(())
    }

    /// `__va_start(&ap, ...)`, the `(` consumed, as clang lowers it: the first
    /// argument converts to `va_list *` and the node is `__builtin_va_start`'s,
    /// whose lowering reads the prototype; what follows, the last fixed
    /// parameter (x64) or its address, size and alignment (arm64), is
    /// unevaluated. The x64 form's parameter takes `va_start`'s `-Wvarargs`
    /// checks; clang makes none on the arm64 form.
    fn parse_ms_va_start(&mut self, name: &str) -> Result<(), C5Error> {
        self.require_variadic_function()?;
        let list_ty = add_ptr_level(add_ptr_level(plain_char_ty(self.lex.char_signed)));
        let list = self.parse_builtin_value(name, 0, list_ty)?;
        let mut rest = alloc::vec::Vec::new();
        let mut tys = alloc::vec::Vec::new();
        while self.list_separator(')', "argument")? {
            let line = self.lex.line;
            let (node, ty) = self.discard_unevaluated_typed()?;
            rest.push((line, node));
            tys.push(ty);
        }
        if let [(line, last)] = rest[..] {
            self.check_va_start_operand(last, line);
        }
        // arm64's form, `__va_start(&ap, &v, _SLOTSIZEOF(v), __alignof(v), &v)`:
        // the operands go unevaluated, and clang checks the named
        // argument's address and its slot size as these do.
        if self.target.is_windows() && self.target.is_aarch64() {
            let wrong = match tys[..] {
                [] | [_] => Some(alloc::string::String::from(
                    "takes the named argument's address and slot size",
                )),
                [addr, ..] if !super::types::is_pointer_ty(addr) => {
                    Some(alloc::string::String::from(
                        "takes the named argument's address as its second operand",
                    ))
                }
                [_, size, ..] if super::types::unqualified_object_ty(size) != self.size_t_ty() => {
                    Some(alloc::string::String::from(
                        "takes the slot size as `size_t`, its third operand",
                    ))
                }
                _ => None,
            };
            if let Some(what) = wrong {
                return Err(self.compile_err(Code::INVALID_ARGUMENTS, format!("`{name}` {what}")));
            }
        }
        self.next()?;
        self.mark_emit_other();
        let unused = self.ast_node(Expr::IntLit {
            val: 0,
            ty: void_ptr_ty(),
        });
        let void = void_ty();
        self.ty = void;
        self.ast_acc = Some(self.ast_node(Expr::Intrinsic {
            kind: Intrinsic::VaStart as i64,
            args: alloc::vec![list, unused],
            ty: void,
        }));
        Ok(())
    }
}
