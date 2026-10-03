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

use super::super::diag::Code;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::decl_base::ImplicitInt;
use super::types::{add_ptr_level, apply_qual_bits};

/// Bundle returned from `parse_function_params` -- keeps the per-param
/// symbol indices (needed by the function-body binding step) together
/// with the declared types and the variadic flag (needed by the type
/// checker at every call site).
#[derive(Debug)]
pub(super) struct ParsedParams {
    pub(super) indices: Vec<usize>,
    pub(super) types: Vec<i64>,
    pub(super) is_variadic: bool,
    pub(super) form: ParamForm,
    /// Positions declared through an enum tag that had no definition yet.
    pub(super) enum_tags: Vec<(usize, u32)>,
    /// The array size expressions of the parameters, in declaration order.
    pub(super) sizes: Vec<ParamSize>,
}

/// A parameter's array size expression, which a definition evaluates on
/// entry (C99 6.9.1p10) although the adjusted parameter is a pointer
/// (6.7.5.3p7): where it is written, and the identifiers it names that
/// were not parameters there.
#[derive(Clone)]
pub(super) struct ParamSize {
    pub(super) at: crate::c5::lexer::LexerSnapshot,
    pub(super) outer_names: Vec<usize>,
}

impl core::fmt::Debug for ParamSize {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        f.debug_struct("ParamSize")
            .field("outer_names", &self.outer_names)
            .finish_non_exhaustive()
    }
}

impl ParsedParams {
    /// The types as declared, each with the incomplete enum tag it named.
    pub(super) fn spelled(&self) -> Vec<super::redeclaration::Spelled> {
        let tag = |pos: usize| {
            self.enum_tags
                .iter()
                .find(|(p, _)| *p == pos)
                .map(|&(_, t)| t)
        };
        let spell = |(pos, &ty): (usize, &i64)| super::redeclaration::Spelled {
            ty,
            enum_tag: tag(pos),
        };
        self.types.iter().enumerate().map(spell).collect()
    }

    /// The parameter information the list gives its function type.
    pub(super) fn fn_params(&self) -> crate::c5::symbol::FnParams {
        crate::c5::symbol::FnParams {
            types: self.types.clone(),
            variadic: self.is_variadic,
            prototyped: self.form == ParamForm::Prototype,
            enum_tags: self.enum_tags.clone(),
        }
    }

    /// The list of a declarator whose function type a typedef or `typeof`
    /// names: that type's.
    pub(super) fn of_type(p: crate::c5::symbol::FnParams) -> Self {
        ParsedParams {
            indices: Vec::new(),
            form: if p.prototyped {
                ParamForm::Prototype
            } else {
                ParamForm::Empty
            },
            types: p.types,
            is_variadic: p.variadic,
            enum_tags: p.enum_tags,
            sizes: Vec::new(),
        }
    }

    /// Record the tag position `pos` was declared through, if any.
    pub(super) fn note_enum_tag(&mut self, pos: usize, tag: Option<u32>) {
        self.enum_tags.retain(|(p, _)| *p != pos);
        self.enum_tags.extend(tag.map(|t| (pos, t)));
    }
}

/// A parameter's function-pointer carriers: indirection, return lineage,
/// pointee parameter information, and `FnType::ret`.
type ParamFnCarriers = (
    i64,
    i64,
    Option<crate::c5::symbol::FnParams>,
    Option<(alloc::boxed::Box<crate::c5::symbol::FnType>, i64)>,
);

/// How a function declarator specified its parameters (C99 6.7.5.3p14).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum ParamForm {
    /// `T ()`: no parameter information, or no parameters in a definition.
    Empty,
    /// A parameter type list, `(void)` included.
    Prototype,
    /// An identifier list, typed by the declarations that follow it (6.9.1p6).
    IdentifierList,
}

impl Compiler {
    /// Drain the function-pointer base carriers a parameter's type parse
    /// seeded. Every parameter shape must consume them: a carrier that
    /// survives the parameter list (an unnamed `fn_t` parameter has no
    /// declarator to bind it) leaks into the next declaration -- e.g. the
    /// first field of a following struct definition would record a phantom
    /// function-pointer prototype.
    pub(super) fn take_param_fn_ptr_carriers(&mut self) -> ParamFnCarriers {
        let ret_fn = self.take_decl_ret_fn(false);
        let indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
        let ret_indirection = core::mem::take(&mut self.pending.fn_ptr_ret_indirection);
        let params = self.pending.fn_ptr_params.take();
        self.pending.base_is_function_type = false;
        (indirection, ret_indirection, params, ret_fn)
    }

    /// A parameter's own `ms_abi` / `sysv_abi` describes that
    /// parameter's pointed-to function, and its `unused` that parameter,
    /// not the declarator the list belongs to, so the enclosing ones are
    /// detached across the list the way the other declarator carriers are.
    pub(super) fn parse_function_params(&mut self) -> Result<ParsedParams, C5Error> {
        let outer_conv = core::mem::take(&mut self.pending.attr_call_conv);
        let outer_unused = core::mem::take(&mut self.pending.attr_maybe_unused);
        // The enclosing declarator's function-pointer carriers and function
        // types, which each parameter's own declarator starts afresh.
        let p = &mut self.pending;
        let outer = (
            p.fn_ptr_indirection.take(),
            core::mem::take(&mut p.fn_ptr_ret_indirection),
            p.fn_ptr_params.take(),
            p.fn_ptr_ret_fn.take(),
            core::mem::take(&mut p.base_is_function_type),
        );
        let outer_chain = core::mem::take(&mut p.fn_ret_chain);
        let outer_levels = core::mem::take(&mut p.fn_chain_levels);
        let outer_arrays = core::mem::take(&mut p.fn_chain_array_levels);
        let outer_base_levels = core::mem::take(&mut p.fn_base_levels);
        let outer_taken = p.base_array_taken;
        let outer_own = core::mem::take(&mut p.fn_own_sig);
        let outer_base = p.fn_decl_base.take();
        // The shape the enclosing declarator's name had before it, which
        // that name's binding restores; the parameters record their own.
        let outer_prior = p.declarator_prior_shape.take();
        let outer_sizes = core::mem::take(&mut self.param_sizes);
        let mut r = self.parse_function_params_inner();
        let sizes = core::mem::replace(&mut self.param_sizes, outer_sizes);
        if let Ok(params) = &mut r {
            params.sizes = sizes;
        }
        let p = &mut self.pending;
        p.declarator_prior_shape = outer_prior;
        p.attr_call_conv = outer_conv;
        p.attr_maybe_unused = outer_unused;
        (
            p.fn_ptr_indirection,
            p.fn_ptr_ret_indirection,
            p.fn_ptr_params,
            p.fn_ptr_ret_fn,
            p.base_is_function_type,
        ) = outer;
        p.fn_ret_chain = outer_chain;
        p.fn_chain_levels = outer_levels;
        p.fn_chain_array_levels = outer_arrays;
        p.fn_base_levels = outer_base_levels;
        p.base_array_taken = outer_taken;
        p.fn_own_sig = outer_own;
        p.fn_decl_base = outer_base;
        r
    }

    fn parse_function_params_inner(&mut self) -> Result<ParsedParams, C5Error> {
        let mut args = Vec::new();
        let mut types = Vec::new();
        let mut enum_tags = Vec::new();
        let mut is_variadic = false;
        // An empty list declares no prototype; `(void)` declares one with
        // no parameters. A list is an identifier list until a parameter
        // spells a type.
        let mut form = if self.lex.tk == ')' {
            ParamForm::Empty
        } else {
            ParamForm::IdentifierList
        };
        // `(void)` -- C's "no parameters" sigil. With `void` now
        // its own lexeme (`Token::Void`), the early-match below
        // unambiguously fires only for the void-sigil shape; an
        // unnamed `char` parameter (`int f(char)`) flows through
        // the regular declarator path instead of being silently
        // dropped as a "no params" decl, which the prior
        // `Token::Char` + peek-`)` check did mistakenly.
        if self.lex.tk == Token::Void && self.lex.peek_after_whitespace(b')') {
            self.next()?; // consume `void`
            form = ParamForm::Prototype;
            // tk is now `)`; the outer loop sees it and exits.
        }
        while self.lex.tk != ')' {
            if self.lex.tk == ',' {
                return Err(self.parameter_expected());
            }
            // `...` ends the typed-parameter list and marks the function
            // variadic. Anything after is a syntax error.
            if self.lex.tk == Token::Ellipsis {
                self.next()?;
                if self.lex.tk != ')' {
                    return Err(self.compile_err(Code::SYNTAX, "`...` must be the last parameter"));
                }
                is_variadic = true;
                form = ParamForm::Prototype;
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
            // A `maybe_unused` / `unused` attribute may lead the
            // parameter (`__attribute__((unused)) int a`) or trail its
            // declarator (`int a __attribute__((unused))`). Clear the
            // side channel here so a previous parameter's attribute
            // cannot leak; the base-type parse below sets it for the
            // leading form, the post-declarator skip for the trailing.
            self.pending.attr_maybe_unused = false;
            let _ = self.take_base_spelling();
            let param_line = self.lex.line;
            let (base, implicit_int) = if self.lex_is_type_start() {
                form = ParamForm::Prototype;
                let base = self.parse_decl_base_type()?;
                (base, core::mem::take(&mut self.pending.base_implicit_int))
            } else {
                (Ty::Int as i64, false)
            };
            let base_spelling = self.take_base_spelling();
            let base_enum_tag = self.pending.base_enum_tag.take();
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
            let mut leading_ptr_count = 0;
            while self.lex.tk == Token::MulOp {
                self.next()?;
                ty = add_ptr_level(ty);
                leading_ptr_count += 1;
                while self.lex.tk == Token::TypeQual {
                    ty = apply_qual_bits(ty, self.lex_qualifier_bits());
                    self.next()?;
                }
            }
            // `A *p` for an array typedef `A` is a pointer to the array
            // (C99 6.7.7p3 + 6.7.6.1); rebuild the flat tag into the
            // aggregate-backed form, mirroring `parse_declarator`'s
            // leading-`*` epilogue (this loop consumed the `*`s, so the
            // declarator below never sees them). The array is then the
            // pointee, so the declarator's own derivations do not apply to it.
            if leading_ptr_count > 0 && self.pending.typedef_base_array_size > 0 {
                ty = self.ptr_to_array_typedef_ty(base, ty, leading_ptr_count);
                self.pending.clear_base_array();
            }
            // A function-TYPE typedef base pre-decays to a function
            // pointer; the first `*` forms that pointer-to-function (C99
            // 6.2.7) rather than adding a level, mirroring
            // `parse_declarator`'s epilogue. Later `*`s add normally.
            let absorb_fn_type_ptr = self.pending.base_is_function_type && leading_ptr_count > 0;
            if absorb_fn_type_ptr {
                self.pending.base_is_function_type = false;
                ty = super::types::absorb_function_level(ty, super::types::ptr_depth_of(base));
            }
            // A parameter that is a pointer to a function-pointer typedef
            // base (`curl_write_callback *p`) gains one fn-pointer
            // indirection level per leading `*`, matching the general
            // declarator path. Without it the fn-pointer decay no-op
            // (`*fp == fp`) misfires on `*p`, landing the load/store one
            // level too shallow (at the pointer's own slot).
            if leading_ptr_count > 0
                && let Some(fpi) = self.pending.fn_ptr_indirection
            {
                let added = if absorb_fn_type_ptr {
                    leading_ptr_count - 1
                } else {
                    leading_ptr_count
                };
                self.pending.fn_ptr_indirection = Some(fpi + added);
            }
            // An unnamed parameter, possibly of array type (`int [][3]`,
            // `char [16]`). Per C99 6.7.5.3p7 a parameter declared with an
            // array type is adjusted to a pointer to its element type, which
            // a typedef whose alias is an array spells as well (`typedef i64
            // gf[16]; void f(gf);` -- the parameter is `i64 *`). The alias's
            // bounds are the inner ones (C99 6.7.7p3); a pointer-to-array
            // (`gf *`) absorbed them above.
            if self.lex.tk == ',' || self.lex.tk == ')' || self.lex.tk == Token::Brak {
                let mut dims = self.parse_unnamed_param_bounds()?;
                self.require_complete_elements(ty, &dims)?;
                if self.pending.typedef_base_array_size != 0 && leading_ptr_count == 0 {
                    if !dims.is_empty() && self.typedef_base_incomplete() {
                        return Err(self.unknown_size_element_err());
                    }
                    dims.extend(self.typedef_base_dims());
                }
                if !dims.is_empty() {
                    ty = self.array_value_ty(ty, &dims);
                }
                // An unnamed parameter binds no symbol to receive the
                // fn-pointer carriers its base (a fn-pointer typedef) seeded.
                let _ = self.take_param_fn_ptr_carriers();
                if implicit_int {
                    self.report_implicit_int(ImplicitInt::Declarator(usize::MAX), param_line)?;
                }
                self.ty = ty;
                enum_tags.extend(base_enum_tag.map(|t| (types.len(), t)));
                types.push(ty);
                if !self.parameter_separator()? {
                    break;
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
            let (param_idx, mut full_ty, array_size, _) = self.parse_declarator(ty)?;
            if implicit_int {
                self.report_implicit_int(ImplicitInt::Declarator(param_idx), param_line)?;
            }
            // A parameter may carry a trailing attribute
            // (`PyObject *op __attribute__((unused))`).
            self.skip_attribute_specifiers()?;
            let param_maybe_unused = self.pending.attr_maybe_unused;
            // Per C99 6.7.5.3p7, a named array parameter is adjusted to a
            // pointer to its element type, the row of the inner bounds for
            // more than one. The same rule applies when the base type is a
            // typedef whose alias is an array; its carrier is consulted only
            // when parse_declarator did not already absorb it into
            // `array_size` (the declarator carried no brackets). A
            // pointer-to-array parameter (`Node *p`, leading `*` consumed
            // above) already has the aggregate-backed tag.
            let typedef_array = array_size == 0
                && self.pending.typedef_base_array_size != 0
                && leading_ptr_count == 0;
            let adjusted = array_size != 0 || typedef_array;
            if adjusted {
                let dims = if typedef_array {
                    self.typedef_base_dims()
                } else if param_idx != usize::MAX {
                    self.symbols[param_idx].array_dims.clone()
                } else {
                    Vec::new()
                };
                full_ty = self.array_value_ty(full_ty, &dims);
                // The parameter is the pointer: no bounds stay on its symbol.
                if param_idx != usize::MAX {
                    self.symbols[param_idx].inner_array_size = 0;
                    self.symbols[param_idx].array_dims = Vec::new();
                }
            }
            // Fn-pointer lineage: pick up the side-channels that
            // parse_declarator (or the typedef-of-fn-ptr base)
            // populated. Drained even if the declarator didn't
            // set anything so they don't leak into the next
            // parameter or expression.
            let (fn_ptr_indirection, fn_ptr_ret_indirection, fnptr_pp, ret_fn) =
                self.take_param_fn_ptr_carriers();
            // The adjusted pointer is one more level above a function-pointer
            // element, as `fn_t *p` counts it.
            let fn_ptr_indirection =
                fn_ptr_indirection + i64::from(adjusted && fn_ptr_indirection > 0);
            // Drained per parameter so one parameter's convention cannot
            // leak into the next.
            let param_conv = core::mem::take(&mut self.pending.attr_call_conv);
            self.ty = full_ty;
            // An unnamed parameter, or any parameter of a function-pointer
            // declarator's prototype, records its type without binding a
            // name: the prototype's parameter names have no linkage and a
            // name that shadows an enclosing prototype's parameter must not
            // trip the duplicate-parameter check.
            if param_idx == usize::MAX || self.pending.parsing_fn_ptr_proto {
                // The name's slot keeps the array shape of what it denotes
                // outside the prototype (C99 6.2.1p4).
                if let Some((inner, dims)) = self.take_prior_shape(param_idx) {
                    self.symbols[param_idx].inner_array_size = inner;
                    self.symbols[param_idx].array_dims = dims;
                }
                enum_tags.extend(base_enum_tag.map(|t| (types.len(), t)));
                types.push(full_ty);
                if !self.parameter_separator()? {
                    break;
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
                return Err(
                    self.compile_err(Code::INVALID_DECLARATION, "duplicate parameter definition")
                );
            }

            // A parameter has automatic storage, which no named address
            // space covers (pointers into one are fine: the qualifier
            // then sits on the pointee).
            if super::types::segment_of_object_ty(full_ty).is_some() {
                return Err(self.compile_err(
                    Code::INVALID_DECLARATION,
                    "a named address space requires static storage",
                ));
            }
            self.shadow_symbol(param_idx);
            self.symbols[param_idx].class = Token::Loc as i64;
            self.symbols[param_idx].type_ = full_ty;
            self.symbols[param_idx].incomplete_enum_tag = base_enum_tag;
            self.symbols[param_idx].binding.decl_spelling = self.decl_spelling(base_spelling);
            self.symbols[param_idx].binding.maybe_unused = param_maybe_unused;
            self.symbols[param_idx].array_size = 0;
            self.set_decl_site(param_idx);
            // Unconditional write: a regular scalar/pointer
            // parameter must not inherit a stale fn-ptr lineage
            // from a prior binding of the same name (the
            // `shadow_symbol` above saved the outer value), or
            // `*p = ...` against the rebind looks like a fn-ptr
            // decay no-op to the unary `*` handler.
            self.symbols[param_idx].fn_ptr_indirection = fn_ptr_indirection;
            self.symbols[param_idx].fn_ptr_ret_indirection = fn_ptr_ret_indirection;
            self.symbols[param_idx].ret_fn = ret_fn;
            // A function-pointer parameter records its pointee signature's
            // parameter types so an indirect call through it narrows each
            // argument to its declared type (the common callback shape).
            if fn_ptr_indirection > 0
                && let Some(pp) = fnptr_pp
            {
                self.symbols[param_idx].set_fn_params(pp);
            }
            self.symbols[param_idx].conv = param_conv;

            args.push(param_idx);
            enum_tags.extend(base_enum_tag.map(|t| (types.len(), t)));
            types.push(full_ty);
            if !self.parameter_separator()? {
                break;
            }
        }
        self.next()?;
        // A parameter whose type is an array typedef (`va_list` is
        // `__va_list_tag[1]` on the SysV/AAPCS ABIs) leaves the typedef-array
        // carrier set; it describes the parameter, not the enclosing object
        // (a function / function pointer, which cannot be an array), so clear
        // it before the enclosing declarator binds.
        self.pending.clear_base_array();
        Ok(ParsedParams {
            indices: args,
            types,
            is_variadic,
            form,
            enum_tags,
            sizes: Vec::new(),
        })
    }

    /// The bounds of an unnamed parameter's array declarator (`int [][3]`),
    /// outermost first. The outermost is adjusted away (C99 6.7.5.3p7), so
    /// its contents -- `static`, qualifiers, `*` or a size of integer type
    /// -- are discarded and it reads as unspecified; an inner one is a
    /// constant.
    fn parse_unnamed_param_bounds(&mut self) -> Result<Vec<i64>, C5Error> {
        let mut dims = Vec::new();
        while self.lex.tk == Token::Brak {
            self.next()?;
            if dims.is_empty() {
                self.skip_param_array_size()?;
                dims.push(-1);
            } else if self.lex.tk == ']' {
                return Err(self.unknown_size_element_err());
            } else {
                let Some(n) = self.with_const_object_fold_masked(|c| c.try_parse_constant_dim())?
                else {
                    let ty = self.peek_expr_type()?;
                    self.require_integer_size(ty)?;
                    return Err(self.compile_err(
                        Code::UNSUPPORTED,
                        "a non-constant inner array dimension is not supported",
                    ));
                };
                if n < 0 {
                    return Err(self.compile_err(
                        Code::INVALID_DECLARATION,
                        alloc::format!("array dimension must be positive (got {n})"),
                    ));
                }
                dims.push(n);
            }
            self.consume(b']', "close bracket expected in array declarator")?;
        }
        Ok(dims)
    }

    /// The `,` after a parameter declaration: `true` past it, `false` at
    /// the closing `)`. A declaration follows every `,` (C99 6.7.5p1).
    fn parameter_separator(&mut self) -> Result<bool, C5Error> {
        let more = self.list_separator(')', "parameter declaration")?;
        if more && (self.lex.tk == ')' || self.lex.tk == ',') {
            return Err(self.parameter_expected());
        }
        Ok(more)
    }

    fn parameter_expected(&self) -> C5Error {
        self.compile_err(
            Code::SYNTAX,
            alloc::format!(
                "parameter declaration expected (got {})",
                super::super::token::describe(self.lex.tk)
            ),
        )
    }
}
