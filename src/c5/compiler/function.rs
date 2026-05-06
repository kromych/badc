//! Function-parameter declarator parser.
//!
//! `parse_function_params` lives here because it's a self-contained
//! 130-line parser for the `(arg1, arg2, ...)` paren list of a
//! function declarator. Three parameter shapes are accepted:
//!   * named scalar / struct / pointer (`int foo`)
//!   * unnamed (prototype) (`int` / `int *`) -- the body, if any,
//!     can't refer to the parameter
//!   * function-pointer (`int (*cb)(int)`) -- routed through
//!     `parse_declarator`'s fp-decl path
//! Plus `(void)` for the C "no parameters" sigil and `...` for the
//! variadic suffix.
//!
//! Lives next to `compiler/mod.rs` because the cluster only grew
//! to its current size as the c5 dialect expanded to cover sqlite-
//! shaped declarators -- splitting it out keeps the param-parser's
//! handful of edge cases (the `void` lookahead, the unnamed-
//! prototype detection, the `[N]` decay rule, the abstract-
//! declarator usize::MAX path, the duplicate-parameter check) in
//! one self-contained place.

use alloc::format;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::{Compiler, ParsedParams};

impl Compiler {
    pub(super) fn parse_function_params(&mut self) -> Result<ParsedParams, C5Error> {
        let mut args = Vec::new();
        let mut types = Vec::new();
        let mut is_variadic = false;
        // `(void)` -- C's "no parameters" sigil. The lexer maps
        // `void` to `Token::Char`, so detect the shape via lookahead:
        // a `Char`/`void` token immediately followed by `)` and not
        // by an identifier (which would make this a real parameter).
        if self.lex.tk == Token::Char as i64 && self.lex.peek_after_whitespace(b')') {
            self.next()?; // consume `void`
            // tk is now `)`; the outer loop sees it and exits.
        }
        while self.lex.tk != ')' as i64 {
            // `...` ends the typed-parameter list and marks the function
            // variadic. Anything after is a syntax error.
            if self.lex.tk == Token::Ellipsis as i64 {
                self.next()?;
                if self.lex.tk != ')' as i64 {
                    return Err(C5Error::Compile(format!(
                        "{}: `...` must be the last parameter",
                        self.lex.line
                    )));
                }
                is_variadic = true;
                break;
            }
            // Consume any extern/static prefixes on parameter
            // decls. C lets you write `void f(static int n)`
            // (it's diagnosed in some compilers but legal in
            // others) and `register` belongs here too. No
            // semantic effect.
            while self.lex.tk == Token::Extern as i64 || self.lex.tk == Token::Static as i64 {
                self.next()?;
            }
            let base = if self.lex_is_type_start() {
                self.parse_decl_base_type()?
            } else {
                Ty::Int as i64
            };
            // Consume the parameter declarator. C allows three
            // shapes here:
            //   * Named:  `int foo`        -- regular declarator.
            //   * Unnamed (prototype): `int` or `int *` -- no
            //     identifier between the type and the next `,` /
            //     `)`. Common in headers; the body, if any,
            //     can't refer to the parameter.
            //   * Function-pointer:  `int (*cb)(int)` -- routed
            //     through `parse_declarator`'s fp-decl path.
            // Detect unnamed by counting `*` markers and then
            // peeking for `,` or `)`.
            let mut ty = base;
            while self.lex.tk == Token::MulOp as i64 {
                self.next()?;
                ty += Ty::Ptr as i64;
                while self.lex.tk == Token::TypeQual as i64 {
                    self.next()?;
                }
            }
            // Optional `[N]` / `[]` after an unnamed parameter
            // type ('int []' / 'char [16]'). Per C the array
            // dimension decays to a pointer; we just bump the
            // pointer level once and discard the size.
            if self.lex.tk == ',' as i64
                || self.lex.tk == ')' as i64
                || self.lex.tk == Token::Brak as i64
            {
                if self.lex.tk == Token::Brak as i64 {
                    self.next()?;
                    if self.lex.tk == ']' as i64 {
                        self.next()?;
                    } else {
                        // Eat the constant int + `]`.
                        let _ = self.parse_constant_int()?;
                        if self.lex.tk == ']' as i64 {
                            self.next()?;
                        }
                    }
                    ty += Ty::Ptr as i64;
                }
                self.ty = ty;
                types.push(ty);
                if self.lex.tk == ',' as i64 {
                    self.next()?;
                }
                continue;
            }

            // Function-pointer parameter or named scalar/struct
            // parameter -- delegate to parse_declarator, which
            // handles `(*name)(args)` plus any [N] suffix. The
            // outer `ty` already absorbed the leading `*`s, so
            // pass it as the base. parse_declarator returns
            // `usize::MAX` for abstract declarators (the unnamed
            // function-pointer shape `int(*)(args)` shows up in
            // sqlite-style prototypes); we record the type but
            // don't bind any symbol.
            let (param_idx, mut full_ty, array_size) = self.parse_declarator(ty)?;
            if array_size != 0 {
                full_ty += Ty::Ptr as i64;
            }
            self.ty = full_ty;
            if param_idx == usize::MAX {
                types.push(full_ty);
                if self.lex.tk == ',' as i64 {
                    self.next()?;
                }
                continue;
            }
            if self.symbols[param_idx].class == Token::Loc as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: duplicate parameter definition",
                    self.lex.line
                )));
            }

            self.shadow_symbol(param_idx);
            self.symbols[param_idx].class = Token::Loc as i64;
            self.symbols[param_idx].type_ = full_ty;
            self.symbols[param_idx].array_size = 0;

            args.push(param_idx);
            types.push(full_ty);

            if self.lex.tk == ',' as i64 {
                self.next()?;
            }
        }
        self.next()?;
        Ok(ParsedParams {
            indices: args,
            types,
            is_variadic,
        })
    }
}
