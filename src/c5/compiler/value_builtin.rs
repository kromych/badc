//! The GCC builtins whose value the call forms from its operands, with
//! gcc's signatures. A call lowers to the conversions and operators
//! computing the value, and folds in a constant expression.

use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::super::ast::{Expr, ExprId};
use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::ir::BinOp;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::const_expr::ConstVal;
use super::types::{
    LONG_DOUBLE_BIT, UNSIGNED_BIT, is_pointer_ty, plain_char_ty, pointer_to_const, void_ptr_ty,
    void_ty,
};

#[derive(Clone, Copy)]
pub(super) enum ValueBuiltin {
    /// `long (long exp, long c)`: `exp`.
    Expect,
    /// `void (const void *, ...)`: the access kind (0 to 2) and locality
    /// (0 to 3) are integer constants.
    Prefetch,
    /// `void *(const void *exp, size_t align, ...)`: `exp`.
    AssumeAligned,
    Inf(i64),
    /// A literal payload's quiet NaN; any other operand calls the library.
    Nan(i64),
    /// `int (int)`; C99 5.2.1p3 makes the decimal digits contiguous.
    IsDigit,
    IsAscii,
    ToAscii,
    /// The identity: `__builtin_return_address` already strips the aarch64
    /// authentication code.
    ReturnAddr,
}

impl ValueBuiltin {
    pub(super) fn of(name: &str) -> Option<Self> {
        let double = Ty::Double as i64;
        let float = Ty::Float as i64;
        Some(match name {
            "__builtin_expect" => Self::Expect,
            "__builtin_prefetch" => Self::Prefetch,
            "__builtin_assume_aligned" => Self::AssumeAligned,
            "__builtin_inf" | "__builtin_huge_val" => Self::Inf(double),
            "__builtin_inff" | "__builtin_huge_valf" => Self::Inf(float),
            "__builtin_infl" | "__builtin_huge_vall" => Self::Inf(double | LONG_DOUBLE_BIT),
            "__builtin_nan" => Self::Nan(double),
            "__builtin_nanf" => Self::Nan(float),
            "__builtin_isdigit" => Self::IsDigit,
            "__builtin_isascii" => Self::IsAscii,
            "__builtin_toascii" => Self::ToAscii,
            "__builtin_extract_return_addr" | "__builtin_frob_return_addr" => Self::ReturnAddr,
            _ => return None,
        })
    }
}

/// An operand: a value converted as an argument is (C99 6.5.2.2p7), an
/// integer constant up to `max`, or the string spelling a NaN payload.
#[derive(Clone, Copy)]
enum Param {
    Value(i64),
    Constant(i64),
    Payload(i64),
}

#[derive(Clone, Copy)]
enum Arg {
    Value(ExprId),
    Constant,
}

/// The binary64 pattern of the quiet NaN of `ty` with the payload gcc reads
/// from `spelling`: past white space and a sign, a decimal, octal or hex
/// number in the significand's low bits. `None` for a spelling gcc leaves
/// to the library. A `float` payload sits where binary32 narrowing keeps it.
fn nan_bits(spelling: &[u8], ty: i64) -> Option<u64> {
    let text = spelling.trim_ascii_start();
    let text = text
        .strip_prefix(b"-")
        .or(text.strip_prefix(b"+"))
        .unwrap_or(text);
    let (radix, digits) = match text {
        [b'0', b'x' | b'X', rest @ ..] => (16, rest),
        [b'0', rest @ ..] => (8, rest),
        _ => (10, text),
    };
    let payload = digits.iter().try_fold(0u64, |acc, &d| {
        let v = (d as char).to_digit(radix)?;
        Some(
            acc.wrapping_mul(u64::from(radix))
                .wrapping_add(u64::from(v)),
        )
    });
    Some(if ty == Ty::Float as i64 {
        0x7ff8_0000_0000_0000 | ((payload? & 0x003f_ffff) << 29)
    } else {
        0x7ff8_0000_0000_0000 | (payload? & 0x0007_ffff_ffff_ffff)
    })
}

fn arity(required: usize, max: usize) -> String {
    if required == max {
        required.to_string()
    } else {
        format!("{required} to {max}")
    }
}

impl Compiler {
    /// The parameters of `kind` and how many are required.
    fn value_builtin_params(&self, kind: ValueBuiltin) -> (Vec<Param>, usize) {
        use Param::*;
        let int = Ty::Int as i64;
        let address = pointer_to_const(void_ty());
        let size = self.size_t_ty();
        match kind {
            ValueBuiltin::Expect => (alloc::vec![Value(Ty::Long as i64); 2], 2),
            ValueBuiltin::Prefetch => (alloc::vec![Value(address), Constant(2), Constant(3)], 1),
            ValueBuiltin::AssumeAligned => {
                (alloc::vec![Value(address), Value(size), Value(size)], 2)
            }
            ValueBuiltin::Inf(_) => (Vec::new(), 0),
            ValueBuiltin::Nan(ty) => (alloc::vec![Payload(ty)], 1),
            ValueBuiltin::IsDigit | ValueBuiltin::IsAscii | ValueBuiltin::ToAscii => {
                (alloc::vec![Value(int)], 1)
            }
            ValueBuiltin::ReturnAddr => (alloc::vec![Value(void_ptr_ty())], 1),
        }
    }

    /// The operands of `name`, the `(` consumed, through the `)`.
    fn builtin_operands<T>(
        &mut self,
        name: &str,
        (params, required): (&[Param], usize),
        mut operand: impl FnMut(&mut Self, usize, Param) -> Result<T, C5Error>,
    ) -> Result<Vec<T>, C5Error> {
        let mut args = Vec::new();
        if self.lex.tk != ')' {
            loop {
                let Some(&param) = params.get(args.len()) else {
                    return Err(self.compile_err(
                        Code::INVALID_ARGUMENTS,
                        format!(
                            "too many arguments to `{name}` (expected {})",
                            arity(required, params.len())
                        ),
                    ));
                };
                args.push(operand(self, args.len(), param)?);
                if !self.list_separator(')', "argument")? {
                    break;
                }
            }
        }
        if args.len() < required {
            return Err(self.compile_err(
                Code::INVALID_ARGUMENTS,
                format!(
                    "too few arguments to `{name}` (expected {}, got {})",
                    arity(required, params.len()),
                    args.len()
                ),
            ));
        }
        self.next()?;
        Ok(args)
    }

    /// An integer constant operand; outside `0..=max` it warns and is 0, as in gcc.
    fn builtin_constant(&mut self, name: &str, pos: usize, max: i64) -> Result<i64, C5Error> {
        let line = self.lex.line;
        let Ok(v) = self.parse_constant_int() else {
            let text = format!(
                "argument {} of `{name}` is not an integer constant expression",
                pos + 1
            );
            return Err(self.compile_err_at(Code::INVALID_ARGUMENTS, line, text));
        };
        if !(0..=max).contains(&v) {
            let text = format!(
                "argument {} of `{name}` is {v}, not 0 to {max}; using 0",
                pos + 1
            );
            self.warn_at(Code::BUILTIN_ARGUMENT_RANGE, line, text);
            return Ok(0);
        }
        Ok(v)
    }

    /// The NaN a narrow literal payload `s` spells, reclaiming the literal's
    /// storage when it was staged last.
    fn literal_nan_bits(&mut self, s: ExprId, ty: i64) -> Option<u64> {
        let mut e = s;
        while let Expr::Cast { child, .. } = *self.ast.expr(e) {
            e = child;
        }
        let Expr::StrLit {
            data_off,
            ty: str_ty,
        } = *self.ast.expr(e)
        else {
            return None;
        };
        let start = data_off as usize;
        if self.size_of_type(super::types::pointee_ty(str_ty)) != 1 {
            return None;
        }
        let len = self.data[start..].iter().position(|&b| b == 0)?;
        let bits = nan_bits(&self.data[start..start + len], ty)?;
        if start + len + 1 == self.data.len() {
            self.truncate_data(start);
        }
        Some(bits)
    }

    /// A call to `kind`, spelled `name`, the `(` consumed.
    pub(super) fn parse_value_builtin(
        &mut self,
        kind: ValueBuiltin,
        name: &str,
    ) -> Result<(), C5Error> {
        let (params, required) = self.value_builtin_params(kind);
        let args = self.builtin_operands(name, (&params, required), |c, pos, param| {
            c.parse_builtin_operand(name, pos, param)
        })?;
        self.mark_emit_other();
        let int = Ty::Int as i64;
        let (value, ty) = match (kind, args.as_slice()) {
            (ValueBuiltin::Expect, &[Arg::Value(exp), Arg::Value(c)]) => {
                // C99 6.5.2.2p10 leaves the order of the arguments unspecified.
                let long = Ty::Long as i64;
                (self.ast_after(c, exp, long), long)
            }
            (ValueBuiltin::Prefetch, &[Arg::Value(addr), ..]) => {
                let void = void_ty();
                (
                    self.ast_node(Expr::Cast {
                        child: addr,
                        to_ty: void,
                    }),
                    void,
                )
            }
            (ValueBuiltin::AssumeAligned, &[Arg::Value(exp), Arg::Value(align), ..]) => {
                // The alignment and the offset are evaluated as arguments are.
                let ty = void_ptr_ty();
                let mut value = self.ast_node(Expr::Cast {
                    child: exp,
                    to_ty: ty,
                });
                value = self.ast_after(align, value, ty);
                if let Some(&Arg::Value(off)) = args.get(2) {
                    value = self.ast_after(off, value, ty);
                }
                (value, ty)
            }
            (ValueBuiltin::Inf(ty), []) => {
                let bits = f64::INFINITY.to_bits();
                (self.ast_node(Expr::FloatLit { bits, ty }), ty)
            }
            (ValueBuiltin::Nan(ty), &[Arg::Value(s)]) => match self.literal_nan_bits(s, ty) {
                Some(bits) => (self.ast_node(Expr::FloatLit { bits, ty }), ty),
                None => {
                    let library = name.strip_prefix("__builtin_").unwrap_or(name);
                    return self.emit_builtin_libcall(library, &[s], ty);
                }
            },
            (ValueBuiltin::IsDigit, &[Arg::Value(c)]) => {
                // In a 64-bit unsigned type no wrap reaches the range.
                let u64 = Ty::LongLong as i64 | UNSIGNED_BIT;
                let c = self.ast_node(Expr::Cast {
                    child: c,
                    to_ty: u64,
                });
                let zero = self.ast_node(Expr::IntLit {
                    val: i64::from(b'0'),
                    ty: u64,
                });
                let rel = self.ast_binary(BinOp::Sub, c, zero, u64);
                let ten = self.ast_node(Expr::IntLit { val: 10, ty: u64 });
                (self.ast_binary(BinOp::Ult, rel, ten, int), int)
            }
            (ValueBuiltin::IsAscii, &[Arg::Value(c)]) => {
                let mask = self.ast_node(Expr::IntLit {
                    val: !0x7f,
                    ty: int,
                });
                let high = self.ast_binary(BinOp::And, c, mask, int);
                let zero = self.ast_node(Expr::IntLit { val: 0, ty: int });
                (self.ast_binary(BinOp::Eq, high, zero, int), int)
            }
            (ValueBuiltin::ToAscii, &[Arg::Value(c)]) => {
                let mask = self.ast_node(Expr::IntLit { val: 0x7f, ty: int });
                (self.ast_binary(BinOp::And, c, mask, int), int)
            }
            (ValueBuiltin::ReturnAddr, &[Arg::Value(addr)]) => (addr, void_ptr_ty()),
            _ => unreachable!("`{name}` operands follow its parameters"),
        };
        self.ast_acc = Some(value);
        self.ty = ty;
        Ok(())
    }

    fn parse_builtin_operand(
        &mut self,
        name: &str,
        pos: usize,
        param: Param,
    ) -> Result<Arg, C5Error> {
        match param {
            Param::Value(ty) => self.parse_builtin_value(name, pos, ty).map(Arg::Value),
            Param::Constant(max) => self.builtin_constant(name, pos, max).map(|_| Arg::Constant),
            Param::Payload(_) => {
                let string = pointer_to_const(plain_char_ty(self.lex.char_signed));
                self.parse_builtin_value(name, pos, string).map(Arg::Value)
            }
        }
    }

    /// A value operand at `pos` of `name`, converted to `want` as an
    /// argument for a parameter of that type is, with the same diagnostics.
    fn parse_builtin_value(
        &mut self,
        name: &str,
        pos: usize,
        want: i64,
    ) -> Result<ExprId, C5Error> {
        let line = self.lex.line;
        self.expr(Token::Assign as i64)?;
        self.reject_void_value(self.ty)?;
        let zero = self.value_is_null_pointer_constant();
        let untyped = self.last_emit_was_indirect_call();
        if let Some(m) = Self::type_warning_with_flags(&self.structs, want, self.ty, zero, untyped)
        {
            let text = format!(
                "{} in argument {} of `{name}` (param={}, arg={})",
                m.reason,
                pos + 1,
                self.typed_text(want, &None),
                self.typed_text(self.ty, &None),
            );
            if m.no_conversion {
                return Err(self.compile_err_at(Code::INCOMPATIBLE_TYPES, line, text));
            }
            self.report_mismatch(&m, line, text)?;
        }
        self.check_value_conversion_of(self.ast_acc, want, 0, line);
        self.convert_assign_rhs(want);
        let Some(value) = self.ast_acc.take() else {
            let text = format!("argument {} of `{name}` has no value", pos + 1);
            return Err(self.compile_err_at(Code::INVALID_ARGUMENTS, line, text));
        };
        let converted = super::super::ast::expr_ty(self.ast.expr(value)) == Some(want);
        Ok(if converted {
            value
        } else {
            self.ast_node(Expr::Cast {
                child: value,
                to_ty: want,
            })
        })
    }

    fn ast_node(&mut self, e: Expr) -> ExprId {
        let pos = self.ast_src_pos();
        self.ast.push_expr(e, pos)
    }

    fn ast_binary(&mut self, op: BinOp, lhs: ExprId, rhs: ExprId, ty: i64) -> ExprId {
        self.ast_node(Expr::Binary { op, lhs, rhs, ty })
    }

    /// `value` of type `ty` after a non-constant `effect` is evaluated.
    fn ast_after(&mut self, effect: ExprId, value: ExprId, ty: i64) -> ExprId {
        if self.expr_const_int(effect).is_some() {
            return value;
        }
        self.ast_node(Expr::Comma {
            lhs: effect,
            rhs: value,
            ty,
        })
    }

    /// Fold a value builtin's call at the cursor in a constant expression;
    /// `None`, the cursor unmoved, for anything else.
    pub(super) fn try_fold_value_builtin(&mut self) -> Result<Option<ConstVal>, C5Error> {
        if self.lex.tk != Token::Id {
            return Ok(None);
        }
        let name = self.symbols[self.lex.curr_id_idx].name.clone();
        // A hint has no value to fold.
        let Some(kind) = ValueBuiltin::of(&name).filter(|k| !matches!(k, ValueBuiltin::Prefetch))
        else {
            return Ok(None);
        };
        let snap = self.lex.snapshot();
        self.next()?;
        if self.lex.tk != '(' {
            self.restore_lex(snap);
            return Ok(None);
        }
        self.next()?;
        let (params, required) = self.value_builtin_params(kind);
        let args = self.builtin_operands(&name, (&params, required), |c, pos, param| {
            c.fold_builtin_operand(&name, pos, param)
        })?;
        let classify = |c: &Self, f: fn(i32) -> i32| -> Result<ConstVal, C5Error> {
            let v = c.require_integer_const(args[0])?.as_i128() as i32;
            Ok(ConstVal::Int {
                val: i128::from(f(v)),
                ty: Ty::Int as i64,
                enumeration: None,
            })
        };
        Ok(Some(match kind {
            ValueBuiltin::Expect | ValueBuiltin::Nan(_) => args[0],
            ValueBuiltin::AssumeAligned | ValueBuiltin::ReturnAddr | ValueBuiltin::Prefetch => {
                self.const_void_pointer(args[0])
            }
            ValueBuiltin::Inf(ty) => ConstVal::Float {
                val: f64::INFINITY,
                ty,
            },
            ValueBuiltin::IsDigit => classify(self, |c| {
                i32::from((c as u32).wrapping_sub(u32::from(b'0')) < 10)
            })?,
            ValueBuiltin::IsAscii => classify(self, |c| i32::from(c & !0x7f == 0))?,
            ValueBuiltin::ToAscii => classify(self, |c| c & 0x7f)?,
        }))
    }

    fn fold_builtin_operand(
        &mut self,
        name: &str,
        pos: usize,
        param: Param,
    ) -> Result<ConstVal, C5Error> {
        let int = |v: i64| ConstVal::Int {
            val: i128::from(v),
            ty: Ty::Int as i64,
            enumeration: None,
        };
        match param {
            Param::Value(ty) => {
                let v = self.parse_const_expr_cond_val()?;
                Ok(if is_pointer_ty(ty) {
                    v
                } else {
                    self.const_convert(v, ty)
                })
            }
            Param::Constant(max) => self.builtin_constant(name, pos, max).map(int),
            Param::Payload(ty) => {
                let bits = match self.try_take_narrow_string_literal()? {
                    Some((start, len)) => {
                        let text = &self.data[start..start + len];
                        let end = text.iter().position(|&b| b == 0).unwrap_or(len);
                        let bits = nan_bits(&text[..end], ty);
                        self.truncate_data(start);
                        bits
                    }
                    None => None,
                };
                let Some(bits) = bits else {
                    let text = format!("`{name}` is constant only for a literal spelling a number");
                    return Err(self.compile_err(Code::CONSTANT_EXPRESSION, text));
                };
                Ok(ConstVal::Float {
                    val: f64::from_bits(bits),
                    ty,
                })
            }
        }
    }

    /// `v` converted to `void *`: a symbol's address keeps its relocation.
    fn const_void_pointer(&self, v: ConstVal) -> ConstVal {
        let ty = void_ptr_ty();
        match v {
            ConstVal::Addr(mut a) if a.root.is_symbolic() => {
                a.ty = ty;
                a.function = false;
                a.pointee = Some(void_ty());
                a.elem_size = 1;
                ConstVal::Addr(a)
            }
            v => self.const_pointer_of(v.as_i128(), ty, false),
        }
    }
}
