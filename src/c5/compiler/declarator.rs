//! Declarator parser.
//!
//! `parse_declarator` consumes the declarator portion of a
//! declaration -- the part that comes *after* a base-type prefix
//! (`int` / `struct Foo` / a typedef-name). It handles:
//!
//!   * zero-or-more leading `*` markers (each adding one pointer
//!     level via `Ty::Ptr`) plus the qualifier-soup
//!     (`*const`, `*volatile`, `*restrict`) attached to each `*`
//!   * the function-pointer shape `RET (*Name)(args)` (and its
//!     nested / abstract variants) -- requires recursion into
//!     parse_declarator and a one-shot capture of the inner-fn's
//!     params on `pending_fn_params` for the function-returning-fp
//!     shape `void (*foo(args1))(args2)`
//!   * the abstract / unnamed declarator (`)` or `,` immediately
//!     after the type) -- returns `usize::MAX` for the symbol idx
//!   * the optional `[N]` array suffix (with the empty-bracket
//!     `[]` decay to pointer at parameter position) plus 2D
//!     `[N][M]` (flattened to `array_size = N*M` plus
//!     `inner_array_size = M` for first-index scaling)
//!
//! Used by every declaration site -- file-scope globals,
//! parameters, function-top locals, block-scoped locals -- so the
//! four near-identical loops it replaced share one definition of
//! "what counts as a valid name" and "we don't allow struct
//! values in this position."

use super::super::diag::Code;
use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{add_ptr_level, apply_qual_bits, is_decl_modifier};

/// One derivation an abstract declarator spells (C99 6.7.6).
pub(super) enum Derivation {
    Pointer,
    /// An array of the bound, `-1` when it is unspecified.
    Array(i64),
    /// A variable-length array whose bound this expression computes.
    RuntimeArray(super::super::ast::ExprId),
    /// A function with its parameters, when captured.
    Function(Option<super::function::ParsedParams>),
}

/// An abstract declarator in a type name (C99 6.7.6): its derivations from
/// the position of the omitted identifier outward, so each applies to the
/// type the ones after it derive from the base type.
#[derive(Default)]
pub(super) struct AbstractDecl {
    pub(super) derivations: alloc::vec::Vec<Derivation>,
}

impl AbstractDecl {
    pub(super) fn pointer_levels(&self) -> i64 {
        let pointers = self.derivations.iter();
        pointers
            .filter(|d| matches!(d, Derivation::Pointer))
            .count() as i64
    }

    /// The bounds of the array a pointer to an array (`T (*)[M1]...[Mn]`)
    /// points to, or `None` for any other type.
    pub(super) fn pointee_dims(&self) -> Option<alloc::vec::Vec<i64>> {
        let [Derivation::Pointer, rest @ ..] = self.derivations.as_slice() else {
            return None;
        };
        let bound = |d: &Derivation| match d {
            Derivation::Array(n) => Some(*n),
            _ => None,
        };
        rest.iter()
            .map(bound)
            .collect::<Option<_>>()
            .filter(|b: &alloc::vec::Vec<i64>| !b.is_empty())
    }
}

impl Compiler {
    /// Record the array shape `idx` holds before this declarator
    /// overwrites it, for the scope save that runs after the declarator.
    fn record_prior_shape(&mut self, idx: usize) {
        let s = &self.symbols[idx];
        self.pending.declarator_prior_shape = Some((idx, s.inner_array_size, s.array_dims.clone()));
    }

    /// Speculatively parse a block-scope function prototype
    /// `[*]name(params);`. C99 6.7p1 / 6.2.2p5: with no storage-class
    /// specifier or `extern`, such a name has external linkage
    /// (internal under `static`), so bind a function symbol and let
    /// the call resolve at link time. Returns `true` with the cursor
    /// past the prototype when one was consumed, `false` with
    /// the lexer restored when the tokens are an ordinary declarator.
    pub(super) fn try_parse_block_fn_prototype(
        &mut self,
        base: super::redeclaration::Spelled,
        is_static: bool,
    ) -> Result<bool, C5Error> {
        let lbt = base.ty;
        // Snapshot before the speculative `*` walk so a plain pointer
        // declaration with multiple declarators (`int *p, *q;`) keeps
        // its leading `*` for the caller's declarator loop.
        let proto_snap = self.lex.snapshot();
        let base_fn = self.carriers_fn_type();
        let mut ret_ptr_levels: i64 = 0;
        while self.lex.tk == Token::MulOp {
            ret_ptr_levels += 1;
            self.next()?;
        }
        if self.lex.tk == Token::Id && self.lex.peek_after_whitespace(b'(') {
            let id_idx = self.lex.curr_id_idx;
            self.next()?; // consume name
            self.next()?; // consume `(`
            // C99 6.7.6.3: a prototype's parameter names have no linkage
            // and no scope past the declaration. Parse them in no-bind
            // mode so an enclosing local of the same name is untouched.
            let saved_proto = self.pending.parsing_fn_ptr_proto;
            self.pending.parsing_fn_ptr_proto = true;
            let params = self.parse_function_params();
            self.pending.parsing_fn_ptr_proto = saved_proto;
            let params = params?;
            let ret = lbt + ret_ptr_levels * Ty::Ptr as i64;
            let declared = super::redeclaration::Params::of(&params, false);
            let spelled = super::redeclaration::Spelled {
                ty: ret,
                enum_tag: base.enum_tag,
            };
            let declared = super::redeclaration::DeclaredType::Function(spelled, declared);
            self.declare_linked(id_idx, declared, self.lex.line)?;
            // Bind only an as-yet-undeclared name; one already bound to a
            // libc binding, a function, or a variable is the same entity.
            let c = self.symbols[id_idx].class;
            let known = c == Token::Sys as i64
                || c == Token::Fun as i64
                || c == Token::Glo as i64
                || c == Token::Loc as i64;
            if !known {
                // The name has block scope (C99 6.2.1p4): save it for
                // the scope-exit restore. The declared entity survives
                // on the slot past the unbind for call resolution.
                self.rebind_scoped(id_idx)?;
                let sym = &mut self.symbols[id_idx];
                sym.class = Token::Fun as i64;
                sym.scoped_fn_decl = true;
                sym.type_ = ret;
                sym.incomplete_enum_tag = base.enum_tag;
                sym.set_fn_params(params.fn_params());
                // A function-pointer base is the result's function type.
                sym.ret_fn = base_fn.map(|(f, d)| (alloc::boxed::Box::new(f), d + ret_ptr_levels));
                sym.is_extern_decl = true;
                sym.linkage = if is_static {
                    crate::c5::symbol::Linkage::Internal
                } else {
                    crate::c5::symbol::Linkage::External
                };
            }
            self.skip_attribute_specifiers()?;
            // A block-scope prototype takes the same GNU asm-label rename a
            // file-scope one does; the declared entity has external linkage
            // either way (C99 6.2.2p4).
            if self.lex.tk == Token::Asm {
                self.parse_declarator_asm_label(id_idx)?;
            }
            return Ok(true);
        }
        self.restore_lex(proto_snap);
        Ok(false)
    }

    /// At `(` in a declarator, peek whether the parenthesized content
    /// opens a parameter-type list -- an abstract function type
    /// `T ( types )` (C99 6.7.5.3p8) -- rather than a parenthesized
    /// declarator (`T (name)` / `T (*name)`). A type-start (including a
    /// typedef-name) or an empty list marks the function-type form. The
    /// lexer snapshot keeps the peek from consuming the paren.
    fn paren_opens_param_type_list(&mut self) -> bool {
        let snap = self.lex.snapshot();
        let mut ok = self.next().is_ok(); // past `(`
        // A parenthesized declarator may lead with calling-convention /
        // qualifier tokens (`(__stdcall *fp)`, `(__cdecl name)`), which also
        // start a type. Skip them; a `*` after them is a declarator, while a
        // type-start or `)` is a parameter-type list.
        while ok && is_decl_modifier(self.lex.tk) {
            ok = self.next().is_ok();
        }
        let is_param_list =
            ok && self.lex.tk != Token::MulOp && (self.lex.tk == ')' || self.lex_is_type_start());
        self.restore_lex(snap);
        is_param_list
    }

    /// Parse an abstract parenthesized declarator tail that follows a
    /// base type in a type-name (C99 6.7.6): the `(*)(args)` of
    /// `int (*)(int)`, the `(*)[N]` of `int (*)[N]`, and their nested
    /// forms, the leading `(` current. With `capture_proto` each function
    /// level's parameter list is parsed, else skipped.
    pub(super) fn parse_abstract_ptr_declarator(
        &mut self,
        capture_proto: bool,
    ) -> Result<AbstractDecl, C5Error> {
        debug_assert!(self.lex.tk == '(');
        self.next()?;
        self.parse_abstract_group(capture_proto)
    }

    /// `abstract-declarator )` and the suffixes after it, the `(` consumed.
    /// The derivations of a nested group come first, then the suffixes of
    /// the omitted identifier (`[3]` in `(*[3])`), the group's pointers and
    /// the group's own suffixes (C99 6.7.5p4).
    fn parse_abstract_group(&mut self, capture_proto: bool) -> Result<AbstractDecl, C5Error> {
        let mut ptrs = 0usize;
        while self.lex.tk == Token::MulOp || self.lex.tk == Token::TypeQual {
            ptrs += usize::from(self.lex.tk == Token::MulOp);
            self.next()?;
        }
        let mut d = if self.lex.tk == '(' && !self.paren_opens_param_type_list() {
            self.next()?;
            self.parse_abstract_group(capture_proto)?
        } else {
            AbstractDecl::default()
        };
        self.parse_abstract_suffixes(capture_proto, &mut d)?;
        if self.lex.tk != ')' {
            return Err(self.compile_err(Code::SYNTAX, "close paren expected in type name"));
        }
        self.next()?;
        d.derivations
            .extend(core::iter::repeat_with(|| Derivation::Pointer).take(ptrs));
        self.parse_abstract_suffixes(capture_proto, &mut d)?;
        Ok(d)
    }

    /// The function and array suffixes of an abstract declarator. With
    /// `capture_proto` a parameter list is parsed, else skipped. An
    /// unspecified bound records `-1` (C99 6.7.5.2p4).
    fn parse_abstract_suffixes(
        &mut self,
        capture_proto: bool,
        d: &mut AbstractDecl,
    ) -> Result<(), C5Error> {
        loop {
            let step = if self.lex.tk == '(' {
                self.next()?;
                if !capture_proto {
                    self.skip_balanced_parens_after_open()?;
                    Derivation::Function(None)
                } else {
                    // C99 6.2.1p4: the parameter names of a function
                    // declarator that is not part of a function definition
                    // have no scope, so their types are recorded without
                    // binding the names.
                    let saved = self.pending.parsing_fn_ptr_proto;
                    self.pending.parsing_fn_ptr_proto = true;
                    let pp = self.parse_function_params();
                    self.pending.parsing_fn_ptr_proto = saved;
                    Derivation::Function(Some(pp?))
                }
            } else if self.lex.tk == Token::Brak {
                self.next()?;
                let step = match self.parse_type_name_bound()? {
                    super::expr::TypeNameBound::Fixed(n) => Derivation::Array(n),
                    super::expr::TypeNameBound::Runtime(dim) => Derivation::RuntimeArray(dim),
                };
                self.accept(']')?;
                step
            } else {
                return Ok(());
            };
            d.derivations.push(step);
        }
    }

    /// Parse a single declarator: zero-or-more `*` (pointer levels)
    /// + identifier + optional `[N]` array suffix. Returns the symbol
    /// index, the (possibly decayed) base type, and the array
    /// dimension. `array_size = 0` means the declarator is not an
    /// array; otherwise `type_` holds the element type and
    /// `array_size` is N.
    ///
    /// `int xs[]` -- empty-bracket form -- is treated as `int *xs`
    /// (added pointer level, `array_size = 0`) per C's parameter-
    /// position decay rule. Callers in object-decl position can
    /// still detect "the user wrote brackets" by remembering whether
    /// the decay happened, but for c5 today the equivalence is
    /// sufficient.
    /// The element type of a variable-length array declared over `ty`: the
    /// array its constant inner dimensions and an array typedef base form,
    /// if any (C99 6.7.5.2p3).
    fn vla_element_type(&mut self, ty: i64) -> Result<i64, C5Error> {
        let mut inner: alloc::vec::Vec<i64> = alloc::vec::Vec::new();
        while self.lex.tk == Token::Brak {
            self.next()?;
            let Some(m) = self.with_const_object_fold_masked(|c| c.try_parse_constant_dim())?
            else {
                return Err(self.compile_err(
                    Code::UNSUPPORTED,
                    "a non-constant inner array dimension is not supported",
                ));
            };
            if m <= 0 {
                return Err(self.compile_err(
                    Code::INVALID_DECLARATION,
                    format!("array dimension must be positive (got {m})"),
                ));
            }
            if self.lex.tk != ']' {
                return Err(
                    self.compile_err(Code::SYNTAX, "close bracket expected in array declarator")
                );
            }
            self.next()?;
            inner.push(m);
        }
        if self.pending.typedef_base_array_size > 0 && !self.pending.base_array_taken {
            self.pending.base_array_taken = true;
            inner.extend(self.typedef_base_dims());
        }
        Ok(if inner.is_empty() {
            ty
        } else {
            self.array_agg_type(ty, &inner)
        })
    }

    pub(super) fn parse_declarator(&mut self, base: i64) -> Result<(usize, i64, i64), C5Error> {
        let (idx, ty, array_size, _) = self.parse_declarator_levels(base)?;
        Ok((idx, ty, array_size))
    }

    /// `parse_declarator`, and the pointer derivations the declarator
    /// applied to `base`, a function adjusted to a pointer included.
    fn parse_declarator_levels(&mut self, base: i64) -> Result<(usize, i64, i64, i64), C5Error> {
        self.with_nesting("declarator", |c| c.parse_declarator_inner(base))
    }

    fn parse_declarator_inner(&mut self, base: i64) -> Result<(usize, i64, i64, i64), C5Error> {
        // Taken once so it scopes to this parameter's own declarator, not
        // any nested one (a function-pointer parameter's prototype).
        let param_ctx = core::mem::take(&mut self.pending.param_decl_context);
        // An entity's declarator starts its function types from the base.
        let entity_start = !core::mem::take(&mut self.pending.declarator_in_group);
        let outer_levels = if entity_start {
            0
        } else {
            self.pending.declarator_path_levels
        };
        if entity_start {
            self.pending.fn_ret_chain.clear();
            self.pending.fn_chain_levels = 0;
            self.pending.fn_chain_array_levels = 0;
            self.pending.fn_own_sig = false;
            self.pending.fn_decl_base = self.carriers_fn_type();
            self.pending.base_array_taken = false;
        }
        let mut ty = base;
        // A calling-convention decoration may precede the declarator
        // (`RET __stdcall name(args)`) or sit just inside the parentheses
        // of a function-pointer declarator (`RET (__stdcall *fp)(args)`);
        // it lexes as a no-op type qualifier. A GNU/C23 attribute-specifier
        // may also lead the declarator, before the `*` / `(` / identifier
        // (`void [[cold]] f(void)`, `void [[format(printf,2,3)]] (*fp)()`).
        // Consume either here so neither stands in for the declarator name.
        loop {
            if self.lex.tk == Token::TypeQual {
                ty = apply_qual_bits(ty, self.lex_qualifier_bits());
                self.next()?;
            } else if self.at_attribute_specifier() {
                self.skip_attribute_specifiers()?;
            } else {
                break;
            }
        }
        let mut leading_ptr_count: i64 = 0;
        // A `const` after the outermost `*` qualifies the declared object,
        // so only the last derivation's qualifiers count.
        let mut outer_const = false;
        let mut outer_restrict = false;
        while self.lex.tk == Token::MulOp {
            self.next()?;
            ty = add_ptr_level(ty);
            leading_ptr_count += 1;
            outer_const = false;
            outer_restrict = false;
            // Pointer-level qualifiers: `int *const p`, `int *volatile p`,
            // `char *restrict s`. A `volatile` here qualifies the pointer
            // object, which is what `apply_qual_bits` records by clearing
            // the inner-only marker `add_ptr_level` just set (C99
            // 6.7.5.1p1). An attribute may sit here too
            // (`void * __attribute__((malloc)) p`).
            loop {
                if self.lex.tk == Token::TypeQual {
                    outer_const |= self.lex_is_const_qual();
                    outer_restrict |= self.lex_is_restrict_qual();
                    ty = apply_qual_bits(ty, self.lex_qualifier_bits());
                    self.next()?;
                } else if self.at_attribute_specifier() {
                    self.skip_attribute_specifiers()?;
                } else {
                    break;
                }
            }
        }
        self.pending.declarator_outer_const = outer_const;
        self.pending.declarator_outer_restrict = outer_restrict;
        // C99 6.7.7p3 + 6.7.6.1: `A *p` for an array typedef `A` declares
        // a pointer to the array. Rebuild the flat tag into the
        // aggregate-backed pointer-to-array form so the array layer rides
        // the type through typedefs and extra pointer levels. An
        // unspecified bound (`typedef T X[]`, carried as `-1`) is an
        // incomplete array type (6.7.5.2p4), and `T (*)[]` is a pointer to
        // it: `*p` still decays to `T *` under 6.3.2.1p3, which does not
        // require a complete type. Only the first derivation applies to the
        // array: in `A *(*f)(void)` the group's `*` points to that pointer.
        if leading_ptr_count > 0 {
            if self.pending.typedef_base_array_size != 0 && !self.pending.base_array_taken {
                ty = self.ptr_to_array_typedef_ty(base, ty, leading_ptr_count);
            }
            self.pending.base_array_taken = true;
        }
        // Fn-pointer lineage propagation: if the caller pre-seeded
        // `pending_fn_ptr_indirection` from a typedef-of-fn-ptr
        // base type, the leading `*`s here add directly to the
        // indirection count: `fn_t fp` -> 1, `fn_t *pp` -> 2,
        // `fn_t **ppp` -> 3. The fn-ptr-declarator branch below
        // overrides this with its own value when it fires (the
        // declarator carries explicit fn-pointer shape rather
        // than inheriting from the base type), so we update
        // pending only when leading `*`s actually accumulated.
        // A function-TYPE typedef (`typedef RET F(args)`) pre-decays to a
        // function pointer (`RET` + one pointer level). The first `*` in
        // `F *p` forms that pointer-to-function rather than adding a
        // level, so the object is a function pointer, not a pointer to
        // one. Absorb the first `*`: drop one pointer level from the type
        // and count it as zero for the indirection. A later `*` (`F **p`)
        // adds normally. Consumed here so it does not leak to the next
        // declarator.
        let absorb_fn_type_ptr = self.pending.base_is_function_type && leading_ptr_count > 0;
        // With no `*` of its own, a following `( declarator )` is pure
        // grouping (`F (*p)` is `F *p`): the function-type marker flows
        // into the recursion, whose epilogue absorbs the pointer level.
        let fn_type_flows_into_group = self.pending.base_is_function_type
            && !absorb_fn_type_ptr
            && self.lex.tk == '('
            && !self.paren_opens_param_type_list()
            && (self.lex.peek_after_whitespace(b'*')
                || self.lex.peek_after_whitespace(b'(')
                || self.lex.peek_after_whitespace_starts_ident());
        // A function-TYPE typedef used with no pointer level declares the
        // identifier with function type, i.e. a function declaration (C99
        // 6.9.1), not a function-pointer object. Flag it for the file-scope
        // declaration path; `F *p` (a pointer) takes the absorb path above.
        self.pending.bare_function_type_declarator = self.pending.base_is_function_type
            && leading_ptr_count == 0
            && !fn_type_flows_into_group;
        if !fn_type_flows_into_group {
            self.pending.base_is_function_type = false;
        }
        if absorb_fn_type_ptr {
            ty -= Ty::Ptr as i64;
        }
        let own_levels = leading_ptr_count - i64::from(absorb_fn_type_ptr);
        // The pointers of this frame and the enclosing ones apply to the base
        // before a signature this frame's group or suffixes hold.
        let path_levels = outer_levels + own_levels;
        self.pending.fn_base_levels = path_levels;
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

        // Abstract function-type parameter `RET ( param-types )` (C99
        // 6.7.5.3p8): a parameter of function type is adjusted to
        // pointer-to-function. Distinguished from a parenthesized
        // declarator (`RET (name)` / `RET (*name)`) by a type-start --
        // including a typedef-name -- or an empty / `void` list after the
        // paren, which names a type rather than a declarator. Test-harness
        // prototypes use this shape (`void test_a(float32_t(uint32_t), ...)`).
        if self.lex.tk == '(' && self.paren_opens_param_type_list() {
            self.next()?; // consume `(`
            self.parse_function_params()?; // consumes the matching `)`
            ty += Ty::Ptr as i64;
            self.pending.fn_ptr_indirection = Some(1);
            // An abstract parameter binds no name.
            return Ok((usize::MAX, ty, 0, own_levels + 1));
        }

        // Function-pointer declarator: `RET (*Name)(args)`, possibly
        // nested as `RET (*(*Name)(args1))(args2)`, or abstract as
        // `RET (*)(args)` (an unnamed parameter type, e.g.
        // `int register_cb(void *ctx, int(*)(void*,int))`).
        // Detected by peeking past the open paren: `*` opens the
        // pointer-cum-declarator, `(` starts a nested parens group.
        if self.lex.tk == '('
            && (self.lex.peek_after_whitespace(b'*')
                || self.lex.peek_after_whitespace(b'(')
                || self.lex.peek_after_whitespace_starts_ident())
        {
            self.next()?; // consume the outer `(`
            let outer_ty_before_inner = ty;
            // The group's suffixes derive from this frame's type before its
            // content does (C99 6.7.5p4): an array typedef no derivation
            // took yet is the operand of the first.
            let base_array_open = !self.pending.base_array_taken;
            // Discard any stale marker, then read what this recursion's
            // subtree produced: true when an inner group already fixed
            // the identifier's fn-pointer lineage, so this frame's
            // pointer levels describe the return type instead.
            core::mem::take(&mut self.pending.fn_ptr_group_resolved);
            self.pending.declarator_in_group = true;
            self.pending.declarator_path_levels = path_levels;
            let (idx, mut inner_ty, inner_array_size, inner_ptr_levels) =
                self.parse_declarator_levels(ty)?;
            let inner_resolved = core::mem::take(&mut self.pending.fn_ptr_group_resolved);
            // Pending count right after the inner declarator: a fn-pointer
            // typedef base seeded it and the inner leading `*`s added to
            // it. Captured here because the signature parses below drain
            // the pending carriers per parameter.
            let prior_pending_fpi = self.pending.fn_ptr_indirection.unwrap_or(0);
            // The pointer levels the group spells, nested groups' included,
            // are the derefs from the variable's value to the function
            // pointer, plus 1 (`T (*name)(args)`: 1, `T (**name)(args)`: 2).
            // The nested declarator counts them: a pointer to an array
            // re-encodes the tag, so its difference from the base does not.
            // Whether the group is a function pointer is known only after
            // its suffixes: `(args)` makes one, `[N]` a pointer to an array.
            let mut group_levels = inner_ptr_levels;
            // The inner declarator stops on `(` when the group holds the
            // entity's own parameter list: `foo` in `void (*foo(args1))(args2)`
            // or `int (*foo(args1))[3]` is a function, and the group's
            // suffixes derive the type its result points to. The params go
            // to `self.pending.fn_params` so `run_compile` binds `foo` as
            // `Token::Fun` and parses the body that follows.
            let mut own_sig = false;
            if self.lex.tk == '(' {
                self.next()?;
                // parse_function_params consumes the matching `)`,
                // so on return we're already past the inner args1.
                let params = self.parse_function_params()?;
                self.pending.fn_params = Some(params);
                self.pending.fn_own_sig = true;
                self.pending.fn_chain_levels = 0;
                self.pending.fn_chain_array_levels = 0;
                self.pending.fn_base_levels = path_levels + inner_ptr_levels;
                own_sig = true;
            }
            if self.lex.tk != ')' {
                return Err(
                    self.compile_err(Code::SYNTAX, "close paren expected in nested declarator")
                );
            }
            self.next()?;
            // C99 6.7.5p1: a parenthesised declarator `(D)` is
            // equivalent to `D`. When the inner is a plain
            // identifier with no `*` and no fn-pointer signature
            // got consumed already, the parens are redundant and
            // must NOT promote a following `(args)` to a function-
            // pointer or a following `[N]` to a pointer-to-array.
            // Return immediately so the dispatch in `run_compile`
            // parses `(args)` as a regular function signature on
            // the identifier and a plain `[N]` (handled by the
            // array-suffix branch below) lands as a real array.
            // In parameter position a `(name)(args)` shape is a
            // function-typed parameter that decays to a pointer to
            // function (C99 6.7.5.3p8), so it must fall through to the
            // function-signature handling below rather than return the
            // bare identifier for `run_compile` to treat as a function
            // definition.
            if !param_ctx
                && !own_sig
                && inner_ptr_levels == 0
                && idx != usize::MAX
                && self.lex.tk == '('
            {
                return Ok((idx, inner_ty, inner_array_size, own_levels + group_levels));
            }
            // Trailing decorations on the parenthesised group.
            // Multiple are legal: `(*pp)[N](args)` etc. Each
            // `[N]` adds a pointer level to `inner_ty` and a
            // dimension to the symbol's `array_dims` so the
            // indexing path can stride correctly through a
            // `T (*p)[N]` shape (`p[i]` strides by
            // `N * sizeof(T)`, not `sizeof(T*)`).
            let mut pointee_dims: alloc::vec::Vec<i64> = alloc::vec::Vec::new();
            let mut after_sig = false;
            loop {
                if self.lex.tk == '(' {
                    if !pointee_dims.is_empty() {
                        return Err(
                            self.compile_err(Code::INVALID_DECLARATION, "array of functions")
                        );
                    }
                    self.next()?;
                    // Capture the pointee signature's prototype on the
                    // first function-signature paren so a fn-pointer
                    // declarator records its callee's variadic-ness and
                    // named-parameter count. A later signature -- past
                    // the entity's own, in this frame or an inner one --
                    // is the function type a result points to.
                    if !self.pending.fn_own_sig {
                        // Capture the pointee signature's parameter types (not
                        // just the count) so an indirect call through the
                        // pointer narrows each argument to its declared
                        // parameter type instead of applying the default
                        // argument promotions. parse_function_params binds
                        // each named parameter as a Loc symbol; restore the
                        // shadowed bindings since a fn-pointer declarator has
                        // no body to scope them.
                        let saved_proto = self.pending.parsing_fn_ptr_proto;
                        self.pending.parsing_fn_ptr_proto = true;
                        let pp = self.parse_function_params()?;
                        self.pending.parsing_fn_ptr_proto = saved_proto;
                        for &pidx in &pp.indices {
                            Self::restore_shadowed_symbol(&mut self.symbols[pidx]);
                        }
                        self.pending.fn_ptr_params = Some(pp.fn_params());
                        self.pending.fn_own_sig = true;
                        self.pending.fn_chain_levels = inner_ptr_levels;
                        self.pending.fn_chain_array_levels = 0;
                    } else {
                        // A later signature is the function type the
                        // previous one's result points to.
                        let saved_proto = self.pending.parsing_fn_ptr_proto;
                        self.pending.parsing_fn_ptr_proto = true;
                        let pp = self.parse_function_params()?;
                        self.pending.parsing_fn_ptr_proto = saved_proto;
                        for &pidx in &pp.indices {
                            Self::restore_shadowed_symbol(&mut self.symbols[pidx]);
                        }
                        let depth = inner_ptr_levels - self.pending.fn_chain_levels
                            + core::mem::take(&mut self.pending.fn_chain_array_levels);
                        self.pending.fn_chain_levels = inner_ptr_levels;
                        self.pending.fn_ret_chain.push((pp.fn_params(), depth));
                    }
                    self.pending.fn_base_levels = path_levels;
                    after_sig = true;
                } else if self.lex.tk == Token::Brak {
                    // C99 6.7.5.3p1: a result is no array; the entity's
                    // own list with `*`s before it returns a pointer.
                    if after_sig || (own_sig && inner_ptr_levels == 0) {
                        return Err(self.compile_err(
                            Code::INVALID_DECLARATION,
                            "function returning an array",
                        ));
                    }
                    self.next()?;
                    if self.lex.tk == ']' {
                        self.next()?;
                        // `T (*p)[]` -- pointer to an incomplete array,
                        // whose unspecified bound (C99 6.7.5.2p4) is the
                        // negative sentinel `array_agg_type` keeps.
                        pointee_dims.push(-1);
                    } else {
                        let m = self.parse_constant_int()?;
                        if m < 0 {
                            return Err(self.compile_err(
                                Code::INVALID_DECLARATION,
                                format!("array dimension must be positive (got {m})"),
                            ));
                        }
                        // `T (*p)[0]` -- a GCC zero-length array pointee:
                        // a complete type of zero size. The 0 dimension
                        // rides into the aggregate tag so `sizeof(*p)`
                        // folds to 0.
                        pointee_dims.push(m);
                        self.accept(']')?;
                    }
                    // The aggregate-backed rebuild below carries the
                    // dimensions for the pointer form; only the
                    // redundant-paren shape `T (name)[N]` keeps the
                    // per-bracket level bump.
                    if inner_ptr_levels == 0 {
                        inner_ty += Ty::Ptr as i64;
                        group_levels += 1;
                    }
                } else {
                    break;
                }
            }
            // Now the shape is fully known. Only expose the
            // fn-pointer lineage if a function signature actually
            // appeared in the declarator; pointer-to-array shapes
            // share the parenthesised form but must NOT be
            // tagged as fn-ptr lineage (otherwise the unary `*`
            // handler treats `*p` on `T (*p)[N]` as the fn-ptr
            // decay no-op and the row deref never fires).
            if after_sig && inner_ptr_levels > 0 {
                if inner_resolved {
                    // An inner group already fixed the identifier's
                    // lineage; the levels above it belong to the return
                    // type. The outermost signature frame writes last,
                    // recording the whole return-side chain.
                    self.pending.fn_ptr_ret_indirection = inner_ptr_levels - prior_pending_fpi;
                } else {
                    // The innermost signature frame fixes the lineage:
                    // the levels between the identifier and this
                    // signature are the derefs from the variable's
                    // value down to the fn-pointer rvalue, plus 1. A
                    // pending count above that came from a fn-pointer
                    // typedef base (`fn_t (*tp)(int)`), whose lineage
                    // is the return type's.
                    if prior_pending_fpi > inner_ptr_levels {
                        self.pending.fn_ptr_ret_indirection = prior_pending_fpi - inner_ptr_levels;
                    }
                    self.pending.fn_ptr_indirection = Some(inner_ptr_levels);
                }
                self.pending.fn_ptr_group_resolved = true;
            } else if (own_sig || after_sig) && inner_ptr_levels == 0 && param_ctx {
                // `RET (name)(args)` parameter: the function type decays
                // to a pointer to function, the same encoding as
                // `RET (*name)(args)` (one indirection level).
                inner_ty += Ty::Ptr as i64;
                group_levels += 1;
                self.pending.fn_ptr_indirection = Some(1);
                self.pending.fn_ptr_group_resolved = true;
            }
            if !pointee_dims.is_empty() {
                if !after_sig && inner_ptr_levels > 0 {
                    // Pointer-to-array shape `T (*p)[M1]...[Mn]`: fold
                    // the pointee dimensions into the aggregate-backed
                    // tag, one pointer level per inner `*`. Also covers
                    // the abstract form `T (*)[N]` (no symbol) and a
                    // function's result (`T (*f(void))[N]`). An array
                    // typedef base adds its bounds inside these.
                    if base_array_open && self.pending.typedef_base_array_size > 0 {
                        pointee_dims.extend(self.typedef_base_dims());
                    }
                    self.pending.fn_chain_array_levels += pointee_dims.len() as i64;
                    inner_ty = (self.array_agg_type(outer_ty_before_inner, &pointee_dims)
                        + inner_ptr_levels * (Ty::Ptr as i64))
                        | (inner_ty
                            & (super::types::VOLATILE_MASK | super::types::CONST_PTR_LVL_MASK));
                } else if idx != usize::MAX && pointee_dims.iter().all(|&d| d > 0) {
                    // Redundant-paren shape `T (name)[N]`: keep the
                    // per-bracket level plus the leading-0 sentinel dims
                    // the indexing paths expect. A zero dimension keeps
                    // the pre-aggregate handling (same as `T name[0]`).
                    let mut dims = alloc::vec::Vec::with_capacity(pointee_dims.len() + 1);
                    dims.push(0);
                    dims.extend(pointee_dims);
                    self.symbols[idx].array_dims = dims;
                }
            }
            return Ok((idx, inner_ty, inner_array_size, own_levels + group_levels));
        }

        // Abstract declarator: type-only, no identifier. Most
        // commonly seen as the unnamed-fp shape `(*)(args)` whose
        // inner-recursion lands here, and as an unnamed parameter
        // closing-out (`,` / `)`). Return `usize::MAX` so callers
        // recognise "no symbol to bind"; only `parse_function_params`
        // is in a context that should accept this.
        if self.lex.tk == ')' || self.lex.tk == ',' {
            return Ok((usize::MAX, ty, 0, own_levels));
        }

        if self.lex.tk != Token::Id {
            return Err(self.compile_err(
                Code::SYNTAX,
                format!(
                    "identifier expected in declaration (got {})",
                    super::super::token::describe(self.lex.tk)
                ),
            ));
        }
        let idx = self.lex.curr_id_idx;
        // First identifier of a member declarator: keep its symbol entry so
        // the aggregate path can undo the writes below (C99 6.2.3).
        if self.pending.in_member_declarator && self.pending.member_decl_save.is_none() {
            self.pending.member_decl_save =
                Some((idx, alloc::boxed::Box::new(self.symbols[idx].clone())));
        }
        self.next()?;

        // A function-typed parameter `RET name(args)` (no parentheses
        // around the name) decays to a pointer to function in parameter
        // position (C99 6.7.5.3p8), the same encoding as `RET (*name)(args)`.
        // Outside parameter position the trailing `(args)` is a function
        // declaration the caller parses, so only act in parameter context.
        if param_ctx && self.lex.tk == '(' {
            self.next()?;
            let saved_proto = self.pending.parsing_fn_ptr_proto;
            self.pending.parsing_fn_ptr_proto = true;
            let pp = self.parse_function_params()?;
            self.pending.parsing_fn_ptr_proto = saved_proto;
            for &pidx in &pp.indices {
                Self::restore_shadowed_symbol(&mut self.symbols[pidx]);
            }
            self.pending.fn_ptr_params = Some(pp.fn_params());
            self.pending.fn_ptr_indirection = Some(1);
            self.pending.fn_own_sig = true;
            return Ok((idx, ty + Ty::Ptr as i64, 0, own_levels + 1));
        }

        let mut array_size: i64 = 0;
        if self.lex.tk == Token::Brak {
            self.pending.declarator_zero_len_array = false;
            self.next()?;
            // C99 6.7.5.3p7 + 6.7.5.2p1: `[`'s contents may be
            // prefixed by `static` and / or any type qualifier
            // (`const` / `volatile` / `restrict`) in a parameter
            // declarator. The keywords are hints to the compiler;
            // c5 doesn't act on them but consumes them so the
            // dimension expression parses cleanly.
            while self.lex.tk == Token::Static || self.lex.tk == Token::TypeQual {
                self.next()?;
            }
            if self.lex.tk == ']' {
                // `int xs[]` -- empty brackets. The dimension is
                // deferred: in parameter position the caller decays
                // to a pointer; at file or block scope with an
                // initializer the size comes from the initializer
                // (`int xs[] = {1, 2, 3};` -> 3). We signal this
                // shape with `array_size = -1` and let the caller
                // decide how to interpret it.
                self.next()?;
                array_size = -1;
            } else if let Some(n) =
                self.with_const_object_fold_masked(|c| c.try_parse_constant_dim())?
            {
                // `int xs[N]` -- N folded to an integer constant. The
                // constant-expression evaluator accepts integer literals
                // (with optional unary minus) and identifiers bound to
                // compile-time integer constants (Token::Num via enum or
                // via `#define`s the preprocessor folded into the source
                // token stream).
                if n < 0 {
                    return Err(self.compile_err(
                        Code::INVALID_DECLARATION,
                        format!("array dimension must be positive (got {n})"),
                    ));
                }
                if self.lex.tk != ']' {
                    return Err(self
                        .compile_err(Code::SYNTAX, "close bracket expected in array declarator"));
                }
                self.next()?;
                // `T x[0]` -- a GCC zero-length array. As a struct or union
                // member it behaves like a C99 6.7.2.1 flexible array member
                // (`T x[]`), so it rides the same `array_size = -1` sentinel.
                // As a declared object the two differ -- `[0]` is a complete
                // type of size zero -- which `declarator_zero_len_array`
                // carries to the object allocators.
                array_size = if n == 0 { -1 } else { n };
                self.pending.declarator_zero_len_array = n == 0;
            } else {
                // Non-constant dimension (C99 6.7.6.2). In a parameter it
                // is adjusted to a pointer, so the size is parsed and
                // discarded (6.7.6.3p7). At block scope it declares a
                // variable-length array. Everywhere else it is a
                // constraint violation.
                if param_ctx {
                    self.skip_array_dimension_expr()?;
                    // `skip_array_dimension_expr` stops at the `]`; consume
                    // it so the declarator resumes past the dimension.
                    self.next()?;
                    array_size = -1;
                } else if self.pending.vla_allowed {
                    self.expr(Token::Assign as i64)?;
                    self.pending.vla_dim_expr = self.ast_acc.take();
                    if self.lex.tk != ']' {
                        return Err(self.compile_err(
                            Code::SYNTAX,
                            "close bracket expected in array declarator",
                        ));
                    }
                    self.next()?;
                    let ty = self.vla_element_type(ty)?;
                    array_size = super::VLA_ARRAY_SIZE;
                    if idx != usize::MAX {
                        return Ok((idx, ty, array_size, own_levels));
                    }
                } else {
                    return Err(self.compile_err(
                        Code::INVALID_DECLARATION,
                        "variable-length array is only allowed at block scope",
                    ));
                }
            }
            // Trailing dimensions for N-dim arrays. c5 stores
            // `array_size = product(dims)` (total element count),
            // `inner_array_size = dims[1]` for the 2D-init padding
            // path, and `array_dims = [dims..]` for the indexing
            // path so 3D / 4D / ... arrays compute strides at
            // every level.
            let mut dims: alloc::vec::Vec<i64> = alloc::vec::Vec::new();
            if array_size > 0 {
                dims.push(array_size);
            }
            while self.lex.tk == Token::Brak {
                self.next()?;
                // Same C99 6.7.5.3p7 qualifier-skip as the leading
                // dimension above; applies to every trailing
                // dimension too.
                while self.lex.tk == Token::Static || self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
                if self.lex.tk == ']' {
                    self.next()?;
                    continue;
                }
                let Some(m) = self.with_const_object_fold_masked(|c| c.try_parse_constant_dim())?
                else {
                    // A non-constant inner dimension makes the whole
                    // object a variably-modified type (C99 6.7.6.2); c5's
                    // stride model is compile-time only, so reject it
                    // cleanly rather than miscompile the row stride.
                    if self.pending.vla_allowed || param_ctx {
                        return Err(self.compile_err(
                            Code::UNSUPPORTED,
                            "a non-constant inner array dimension is not supported",
                        ));
                    }
                    return Err(self.compile_err(
                        Code::CONSTANT_EXPRESSION,
                        "constant integer expected in array declarator",
                    ));
                };
                if m <= 0 {
                    return Err(self.compile_err(
                        Code::INVALID_DECLARATION,
                        format!("array dimension must be positive (got {m})"),
                    ));
                }
                if self.lex.tk != ']' {
                    return Err(self
                        .compile_err(Code::SYNTAX, "close bracket expected in array declarator"));
                }
                self.next()?;
                dims.push(m);
                if array_size > 0 {
                    array_size *= m;
                }
            }
            // C99 6.7.7p3: when the base type is a typedef whose
            // alias is an array, the typedef's dimensions extend
            // the declarator's. `typedef i64 gf[16]; gf q[4];`
            // declares `q` as `i64[4][16]`. The same composition
            // applies under a deferred or unsized outer bracket
            // (`gf q[]` as an object completed later, or as a
            // parameter adjusting to a row pointer): the alias's
            // dims are the row shape, only the outer count is
            // open. The carrier is left intact so the rest of a
            // comma-separated declarator list (`gf p[4], q[4];`)
            // still folds the dimension; it is reset when the next
            // declaration's base type is parsed. The caller
            // observes `array_size != 0` and skips its own
            // typedef-dim fold to avoid double application.
            if array_size != 0 && !self.pending.base_array_taken {
                self.pending.base_array_taken = true;
                let typedef_dim = self.pending.typedef_base_array_size;
                if typedef_dim > 0 {
                    if self.pending.typedef_base_array_dims.len() >= 2 {
                        dims.extend(self.pending.typedef_base_array_dims.iter().copied());
                    } else {
                        dims.push(typedef_dim);
                    }
                    if array_size > 0 {
                        array_size *= typedef_dim;
                    }
                } else if typedef_dim < 0 && self.pending.typedef_base_zero_len {
                    // An array of a zero-length-array alias has zero
                    // elements whatever the declarator's own bounds are.
                    array_size = -1;
                    self.pending.declarator_zero_len_array = true;
                }
            }
            // Deferred-outer multi-dim arrays (`T arr[][N]`,
            // `T arr[][N][M]`, ...): the outermost dimension's count
            // arrives later, from the initializer. The trailing
            // inner dims still need to be recorded NOW so the
            // indexer's stride math is correct -- otherwise
            // `arr[i]` strides by `elem_size` instead of
            // `inner_dim * elem_size` and an out-of-row reference
            // walks into the previous row's tail bytes.
            //
            // Convention: `array_dims[0] = 0` marks the deferred
            // outer dim. `seed_multi_dim_strides` only reads
            // `dims[k+1..]` for stride[k] so the placeholder zero
            // never propagates into a computed stride; the
            // post-init fixup in `run_compile` overwrites it with
            // the real count once the initializer has been parsed.
            // Unified dimension list, outermost first. For a deferred
            // outer dim (`array_size < 0`), `dims` holds only the
            // trailing inner dims, so prepend the `0` placeholder; an
            // explicit shape already carries every dimension. The
            // post-init fixup in `run_compile` overwrites `dims[0] == 0`
            // with the real outer count once the initializer is parsed.
            let full_dims: alloc::vec::Vec<i64> = if array_size < 0 && !dims.is_empty() {
                let mut v = alloc::vec::Vec::with_capacity(dims.len() + 1);
                v.push(0);
                v.extend(dims);
                v
            } else {
                dims
            };
            // `inner_array_size` is the second overall dimension (the
            // immediate inner row width), used by the 2D-init padding
            // path. `seed_multi_dim_strides` only reads `dims[k+1..]`
            // for stride[k], so the placeholder zero never enters a
            // computed stride.
            let inner_dim: i64 = if full_dims.len() >= 2 {
                full_dims[1]
            } else {
                0
            };
            if idx != usize::MAX {
                // Always overwrite, even with 0, so a rebinding of a
                // name that previously carried a multi-dim shape (a
                // struct field, an outer-scope local, etc.) doesn't
                // inherit the stale strides. C99 6.2.1 identifier
                // scopes: each new binding starts fresh, so any
                // per-symbol shape metadata must be cleared when the
                // binding's scope begins.
                self.record_prior_shape(idx);
                self.symbols[idx].inner_array_size = inner_dim;
                self.symbols[idx].array_dims = if full_dims.len() >= 2 {
                    full_dims
                } else {
                    alloc::vec::Vec::new()
                };
            }
        } else if idx != usize::MAX {
            // No `[` suffix at all -- the declarator is a scalar or
            // pointer. Same rationale as above: scrub any stale
            // multi-dim metadata carried over from an earlier
            // binding of the same name. A pointer over an array
            // typedef needs no symbol-side shape: the leading-`*`
            // epilogue already folded the array layer into the type.
            self.record_prior_shape(idx);
            self.symbols[idx].inner_array_size = 0;
            self.symbols[idx].array_dims = alloc::vec::Vec::new();
        }

        // GNU C / C23: an attribute-specifier-list may trail the declarator
        // (`T x[N] __attribute__((aligned(8)))` or `T x[N] [[...]]`); it does
        // not change c5's type tag. Consume it so the caller resumes at
        // `=` / `,` / `;`.
        while self.at_attribute_specifier() {
            self.skip_attribute_specifiers()?;
        }

        Ok((idx, ty, array_size, own_levels))
    }
}
