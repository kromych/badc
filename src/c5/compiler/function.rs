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
//! to its current size as the c5 dialect expanded to cover the
//! full set of C declarator shapes -- splitting it out keeps the
//! param-parser's handful of edge cases (the `void` lookahead,
//! the unnamed-prototype detection, the `[N]` decay rule, the
//! abstract-declarator usize::MAX path, the duplicate-parameter
//! check) in one self-contained place.

use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;

/// Bundle returned from `parse_function_params` -- keeps the per-param
/// symbol indices (needed by the function-body binding step) together
/// with the declared types and the variadic flag (needed by the type
/// checker at every call site).
#[derive(Debug)]
pub(super) struct ParsedParams {
    pub(super) indices: Vec<usize>,
    pub(super) types: Vec<i64>,
    pub(super) is_variadic: bool,
}

impl Compiler {
    pub(super) fn parse_function_params(&mut self) -> Result<ParsedParams, C5Error> {
        let mut args = Vec::new();
        let mut types = Vec::new();
        let mut is_variadic = false;
        // `(void)` -- C's "no parameters" sigil. With `void` now
        // its own lexeme (`Token::Void`), the early-match below
        // unambiguously fires only for the void-sigil shape; an
        // unnamed `char` parameter (`int f(char)`) flows through
        // the regular declarator path instead of being silently
        // dropped as a "no params" decl, which the prior
        // `Token::Char` + peek-`)` check did mistakenly.
        if self.lex.tk == Token::Void && self.lex.peek_after_whitespace(b')') {
            self.next()?; // consume `void`
            // tk is now `)`; the outer loop sees it and exits.
        }
        while self.lex.tk != ')' {
            // `...` ends the typed-parameter list and marks the function
            // variadic. Anything after is a syntax error.
            if self.lex.tk == Token::Ellipsis {
                self.next()?;
                if self.lex.tk != ')' {
                    return Err(self.compile_err("`...` must be the last parameter"));
                }
                is_variadic = true;
                break;
            }
            // Consume any extern/static prefixes on parameter
            // decls. C lets you write `void f(static int n)`
            // (it's diagnosed in some compilers but legal in
            // others) and `register` belongs here too. No
            // semantic effect.
            while self.lex.tk == Token::Extern || self.lex.tk == Token::Static {
                self.next()?;
            }
            let base = if self.lex_is_type_start() {
                self.parse_decl_base_type()?
            } else {
                Ty::Int as i64
            };
            // `(void)` via a typedef alias. The early check above
            // matches only the bare `void` keyword; aliases reach
            // here with `base_was_void` set by `parse_decl_base_type`.
            let _ = base;
            if self.pending.base_was_void && types.is_empty() && self.lex.tk == ')' {
                self.pending.base_was_void = false;
                break;
            }
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
            while self.lex.tk == Token::MulOp {
                self.next()?;
                ty += Ty::Ptr as i64;
                while self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
            }
            // Optional `[N]` / `[]` after an unnamed parameter
            // type ('int []' / 'char [16]'). Per C99 6.7.5.3p7,
            // a parameter declared with an array type is
            // adjusted to a pointer to the element type; we
            // bump the pointer level once and discard the size.
            // The same adjustment applies when the base type is
            // a typedef whose alias is an array (`typedef i64
            // gf[16]; void f(gf x);` -- `x` is `i64 *`).
            if self.lex.tk == ',' || self.lex.tk == ')' || self.lex.tk == Token::Brak {
                if self.lex.tk == Token::Brak {
                    self.next()?;
                    if self.lex.tk == ']' {
                        self.next()?;
                    } else {
                        // Eat the constant int + `]`.
                        let _ = self.parse_constant_int()?;
                        if self.lex.tk == ']' {
                            self.next()?;
                        }
                    }
                    ty += Ty::Ptr as i64;
                }
                if self.pending.typedef_base_array_size > 0 {
                    ty += Ty::Ptr as i64;
                }
                self.ty = ty;
                types.push(ty);
                if self.lex.tk == ',' {
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
            // callback-registering prototypes); we record the
            // type but don't bind any symbol.
            self.pending.param_decl_context = true;
            let (param_idx, mut full_ty, array_size) = self.parse_declarator(ty)?;
            // A parameter may carry a trailing attribute
            // (`PyObject *op __attribute__((unused))`).
            self.skip_attribute_specifiers()?;
            if array_size != 0 {
                full_ty += Ty::Ptr as i64;
            }
            // Per C99 6.7.5.3p7, a named array parameter is
            // adjusted to a pointer to the element type. The
            // same rule applies when the base type is a typedef
            // whose alias is an array. Only consult the carrier
            // when parse_declarator did not already absorb it
            // into `array_size` (i.e., the declarator carried no
            // explicit brackets).
            if array_size == 0 && self.pending.typedef_base_array_size > 0 {
                full_ty += Ty::Ptr as i64;
            }
            // Fn-pointer lineage: pick up the side-channel that
            // parse_declarator (or the typedef-of-fn-ptr base)
            // populated. Cleared even if the declarator didn't
            // set anything so it doesn't leak into the next
            // parameter or expression.
            let fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
            self.ty = full_ty;
            // An unnamed parameter, or any parameter of a function-pointer
            // declarator's prototype, records its type without binding a
            // name: the prototype's parameter names have no linkage and a
            // name that shadows an enclosing prototype's parameter must not
            // trip the duplicate-parameter check.
            if param_idx == usize::MAX || self.pending.parsing_fn_ptr_proto {
                types.push(full_ty);
                if self.lex.tk == ',' {
                    self.next()?;
                }
                continue;
            }
            // A name repeated within this parameter list is an error;
            // each earlier parameter is already bound `Loc` and its
            // index recorded in `args`. A name that merely shadows an
            // outer local -- a prototype declared inside a function
            // body, where the enclosing parameter or local carries the
            // same name (C99 6.7.6.3 puts the prototype's parameters in
            // their own scope) -- is not a duplicate; `shadow_symbol`
            // saves the outer binding and the caller restores it.
            if self.symbols[param_idx].class == Token::Loc as i64 && args.contains(&param_idx) {
                return Err(self.compile_err("duplicate parameter definition"));
            }

            self.shadow_symbol(param_idx);
            self.symbols[param_idx].class = Token::Loc as i64;
            self.symbols[param_idx].type_ = full_ty;
            self.symbols[param_idx].array_size = 0;
            self.symbols[param_idx].was_referenced = false;
            self.symbols[param_idx].decl_line = self.lex.line;
            let decl_file = self.intern_source_file() as u32;
            self.symbols[param_idx].decl_file = decl_file;
            self.symbols[param_idx].decl_in_main_source = self.in_main_source();
            // Unconditional write: a regular scalar/pointer
            // parameter must not inherit a stale fn-ptr lineage
            // from a prior binding of the same name (the
            // `shadow_symbol` above saved the outer value), or
            // `*p = ...` against the rebind looks like a fn-ptr
            // decay no-op to the unary `*` handler.
            self.symbols[param_idx].fn_ptr_indirection = fn_ptr_indirection;
            // A function-pointer parameter records its pointee signature's
            // parameter types so an indirect call through it narrows each
            // argument to its declared type (the common callback shape).
            let fnptr_pp = if fn_ptr_indirection > 0 {
                self.pending.fn_ptr_param_types.take()
            } else {
                None
            };
            if let Some(pp_types) = fnptr_pp {
                self.symbols[param_idx].params = pp_types;
                self.symbols[param_idx].is_variadic =
                    matches!(self.pending.typedef_fn_proto.take(), Some((_, true)));
            }

            args.push(param_idx);
            types.push(full_ty);

            if self.lex.tk == ',' {
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
