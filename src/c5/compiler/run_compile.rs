//! File-scope declaration driver.
//!
//! `run_compile()` is the outer loop of the parser: read the next
//! top-level item (declaration, definition, `_Static_assert`,
//! `typedef`) and dispatch into the matching sub-parser. It owns
//! the storage-class prefix soup (`extern`, `static`,
//! `_Thread_local`, `typedef`), the base-type matcher (`int`,
//! `char`, `void`, `float`, `double`, `struct`, `union`, `enum`,
//! typedef-name), and the per-declarator binding step (function
//! definition vs global variable, with or without an initializer).
//!
//! Lives in its own file because at ~900 lines it dwarfs every
//! other parser routine that isn't [`super::Compiler::expr`]. The
//! shared int-modifier soup and aggregate-base parser live in
//! `compiler/decl_base.rs`; this file is the only direct caller
//! that needs the full storage-class superset (`Token::Typedef`,
//! `Token::Extern`, `Token::Static`, `Token::ThreadLocal`).

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::decl_base;
use super::types::{
    UNSIGNED_BIT, format_signature, is_decl_modifier, is_pointer_ty, is_struct_ty, struct_id_of,
    struct_ptr_depth,
};

impl Compiler {
    pub(super) fn run_compile(&mut self) -> Result<(), C5Error> {
        self.next()?;
        while self.lex.tk != 0 {
            // C11 6.7.10 `_Static_assert(<expr>, "<msg>");` at
            // file scope -- consume the construct as a parse-time
            // assertion. Zero expression aborts compilation with
            // the message verbatim through the standard error path.
            if self.lex.tk == Token::StaticAssert {
                self.parse_static_assert()?;
                continue;
            }
            let mut bt = Ty::Int as i64;
            // Reset the bare-`void` side channel for this
            // declaration. Set further down if the base-type loop
            // matches `Token::Void`; consumed by the function-decl
            // path to mark `Symbol::returns_void`.
            self.pending.base_was_void = false;
            // Same reset for the long-double marker. A previous
            // declaration that consumed `long double` would
            // otherwise stamp this iteration's binding with the
            // wrong x87 return convention.
            self.pending.base_was_long_double = false;
            // Same reset for the typedef-array dimension carrier
            // so a previous declaration's typedef base does not
            // leak its array count into this iteration's
            // declarator binding.
            self.pending.typedef_base_array_size = 0;
            // Storage-class prefixes -- can appear in any order
            // and any combination before the type. C lets you
            // mix `static extern` (silly but legal in some
            // compilers) and `_Thread_local extern` (legal),
            // so we accept any ordering. `extern` and `static`
            // are no-ops in c5 (every symbol already has
            // internal linkage and there's no separate
            // translation-unit story); `_Thread_local` flips
            // the per-thread storage flag. The int-modifier
            // soup (`signed`, `unsigned`, `short`, `long*`,
            // `_Bool`) flows through the shared `IntModifiers`
            // accumulator so `parse_decl_base_type` and the
            // file-scope path interpret it identically.
            let mut thread_local = false;
            let mut is_typedef = false;
            let mut static_seen = false;
            let mut extern_seen = false;
            let mut m = decl_base::IntModifiers::default();
            // `_Noreturn` scopes to this declaration; clear the carrier
            // so it cannot leak onto the next one.
            self.pending_noreturn = false;
            loop {
                if self.lex.tk == Token::ThreadLocal {
                    thread_local = true;
                    self.next()?;
                } else if self.lex.tk == Token::Typedef {
                    is_typedef = true;
                    self.next()?;
                } else if self.try_consume_int_modifier(&mut m)? {
                    // Consumed an int modifier; the helper already
                    // advanced the lexer.
                } else if self.lex.tk == Token::Static {
                    static_seen = true;
                    self.next()?;
                } else if self.lex.tk == Token::Extern {
                    extern_seen = true;
                    self.next()?;
                } else if is_decl_modifier(self.lex.tk) {
                    if self.lex.tk == Token::Inline {
                        self.pending_is_inline = true;
                    }
                    if self.lex.tk == Token::Noreturn {
                        self.pending_noreturn = true;
                    }
                    self.next()?;
                } else {
                    break;
                }
            }
            if self.lex.tk == Token::Int {
                self.next()?;
                bt = m.int_base();
            } else if self.lex.tk == Token::Char {
                self.next()?;
                bt = m.char_tag();
            } else if self.lex.tk == Token::Void {
                self.next()?;
                // Bare `void` shares the `unsigned char` encoding
                // (so void-pointer arithmetic / sizeof / fn-ptr
                // tables stay identical to the legacy
                // void-as-char path). The void-ness is captured
                // out-of-band via `pending_base_was_void`, which
                // the function-decl path consumes below to set
                // `Symbol::returns_void`.
                self.pending.base_was_void = true;
                bt = Ty::Char as i64 | UNSIGNED_BIT;
            } else if self.lex.tk == Token::Float {
                self.next()?;
                bt = Ty::Float as i64;
            } else if self.lex.tk == Token::Double {
                self.next()?;
                // `long double` collapses to the same f64 encoding
                // as plain `double` for storage / expression
                // semantics. The marker carries the spelling out
                // of band so the function-prototype path can
                // stamp a libc binding's return-convention flag
                // (SysV x86_64 returns long double in x87 st(0),
                // not XMM0).
                if m.saw_long() {
                    self.pending.base_was_long_double = true;
                }
                bt = Ty::Double as i64;
            } else if self.lex.tk == Token::Enum {
                self.parse_enum_decl()?;
            } else if self.lex.tk == Token::Struct || self.lex.tk == Token::Union {
                // Aggregate (struct or union) declaration. Three
                // shapes:
                //   <kw> Name { ... };           -- definition only
                //   <kw> Name;                   -- forward declaration
                //   <kw> Name *p;                -- type use, declarators follow
                //   typedef <kw> Name {...} Name; -- definition + typedef alias
                bt = self.parse_aggregate_base_type()?;
            } else if self.is_lex_typedef_name() {
                // Typedef-name as base type at file scope: `Foo bar;`
                // where `Foo` was bound by a prior `typedef`.
                bt = self.symbols[self.lex.curr_id_idx].type_;
                // Carry the typedef's fn-ptr lineage forward so a
                // declarator like `fn_t fp` (no leading `*`) still
                // gets `Symbol::fn_ptr_indirection = 1`. The
                // declarator itself, if it adds leading `*`s, will
                // bump this further before the symbol is bound.
                let typedef_fpi = self.symbols[self.lex.curr_id_idx].fn_ptr_indirection;
                if typedef_fpi > 0 {
                    self.pending.fn_ptr_indirection = Some(typedef_fpi);
                    // A function-pointer typedef records the pointed-to
                    // function's prototype (`params` + `is_variadic`).
                    // Carry it to the bound declarator so an indirect
                    // call through the variable can split fixed vs
                    // variadic arguments per the host variadic ABI.
                    self.pending.typedef_fn_proto = Some((
                        self.symbols[self.lex.curr_id_idx].params.len(),
                        self.symbols[self.lex.curr_id_idx].is_variadic,
                    ));
                }
                // C99 6.7.7 paragraph 3: a typedef whose alias is
                // an array contributes its dimension to the
                // bound declarator.
                let typedef_array = self.symbols[self.lex.curr_id_idx].array_size;
                if typedef_array > 0 {
                    self.pending.typedef_base_array_size = typedef_array;
                }
                self.next()?;
            } else if m.saw_int_mod {
                // Bare modifier(s) without an explicit type keyword:
                // `unsigned x;` / `short x;` / `long x;` /
                // `long long x;` (the implicit-int rule).
                bt = m.int_base();
            } else if self.lex.tk == Token::Id {
                // Identifier in base-type position with no matching
                // typedef. C89 6.5.2 / C99 6.7.2p2 (deprecated)
                // "implicit int": a declaration without a type
                // specifier infers `int`. Common at file scope for
                // `main() { ... }` and K&R-shaped third-party C.
                // Honour the implicit-int rule only when the
                // identifier looks like the declarator itself --
                // i.e. the next non-whitespace byte is `(` (a
                // function declarator) or `;` / `,` / `=` (a
                // simple-variable declarator). Other shapes
                // (`Foo bar;` where `Foo` is supposed to be a type)
                // continue to error so a typo in a type name is
                // surfaced at the declaration, not silently
                // accepted as `int Foo bar;`.
                if self.lex.peek_after_whitespace(b'(')
                    || self.lex.peek_after_whitespace(b';')
                    || self.lex.peek_after_whitespace(b',')
                    || self.lex.peek_after_whitespace(b'=')
                {
                    bt = Ty::Int as i64;
                } else {
                    let name = self.symbols[self.lex.curr_id_idx].name.clone();
                    return Err(self.compile_err(format!("unknown type name `{name}`")));
                }
            }
            // Trailing qualifiers / int modifiers between the base
            // type and the declarators -- `Foo const *p`, `int long
            // x`, etc. The base type is already chosen; these are
            // pure no-ops in c5 but appear in real C source.
            while is_decl_modifier(self.lex.tk) {
                self.next()?;
            }

            while self.lex.tk != ';' && self.lex.tk != '}' {
                let (id_idx, ty, mut array_size) = self.parse_declarator(bt)?;
                // Pick up the fn-pointer indirection count
                // the declarator (or its typedef base type)
                // recorded, and store it on the symbol so a later
                // identifier load can seed the chain-depth tracker.
                let fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
                // A typedef whose alias is an array contributes its
                // dimension when the declarator did not supply
                // one. The multi-dim composition rule (`arr_t
                // four[4]` -> `long four[4][64]` per C99 6.7.7)
                // needs the `array_dims` chain and is out of
                // scope here; the single-dim case is the common
                // one and is what the immediate fix unblocks.
                //
                // The dimension belongs to the base type and must
                // remain visible across every declarator in a
                // comma list: `typedef i64 gf[16]; static const gf
                // a, b = { 1 };` -- both `a` and `b` are `i64[16]`.
                // The carrier is reset at the top of the next
                // declaration loop iteration, so a peek here is
                // sufficient.
                // A declarator that added pointer levels (`T *p`
                // for an array typedef `T`) names a pointer to
                // the typedef's element type; the array dimension
                // is part of the pointee and must not re-apply to
                // the declarator (C99 6.7.7p3 + 6.7.6.1). Skip
                // the carrier in that case.
                let typedef_dim = self.pending.typedef_base_array_size;
                if typedef_dim > 0 && array_size == 0 && !is_pointer_ty(ty) {
                    array_size = typedef_dim;
                }
                self.ty = ty;
                self.symbols[id_idx].array_size = array_size;
                if fn_ptr_indirection > 0 {
                    self.symbols[id_idx].fn_ptr_indirection = fn_ptr_indirection;
                }
                // Inherit a variadic function-pointer prototype onto the
                // bound declarator so an indirect call through it knows
                // the callee's named-parameter count and routes the
                // variadic tail per the host variadic ABI. Only variadic
                // prototypes are recorded: a non-variadic indirect call
                // places every argument as fixed regardless, and
                // synthesising placeholder parameter types would feed the
                // call-site argument type-check a spurious mismatch.
                if let Some((proto_fixed, true)) = self.pending.typedef_fn_proto.take() {
                    self.symbols[id_idx].params = alloc::vec![0i64; proto_fixed];
                    self.symbols[id_idx].is_variadic = true;
                }
                // Carry the bare-`void` side channel onto the
                // declarator. `pending_base_was_void` was set if
                // the base type spelled `void`; it stays valid
                // for the FIRST declarator in a comma-separated
                // group only -- subsequent ones see the flag
                // and would mis-fire if the declarator added
                // pointer levels in between. Gate on
                // "no leading `*` added" by checking that the
                // declarator's returned `ty` still equals the
                // bare-void encoding. Any declarator that bumped
                // `ty` by `Ty::Ptr` falls out.
                let declarator_is_bare_void =
                    self.pending.base_was_void && ty == (Ty::Char as i64 | UNSIGNED_BIT);
                // Consume the flag so the next iteration of the
                // declarator loop (`void *a, b;`) doesn't
                // re-trigger on a different declarator's shape.
                self.pending.base_was_void = false;
                // Function-returning-FP shape: parse_declarator
                // already consumed the outer function's params.
                // Synthesize the function-definition path: bind the
                // symbol as Fun, install the captured params, then
                // proceed straight into the body (the next token is
                // `{`, not `(`).
                let preconsumed_params = self.pending.fn_params.take();

                // typedef branch: register a type alias and skip the
                // function / global storage path entirely. Re-declaring
                // an existing typedef with the same underlying type is
                // tolerated -- amalgamated translation units routinely
                // re-emit identical typedefs through several `#include`
                // paths -- but a clashing redefinition or a clash with
                // a non-typedef symbol is rejected.
                if is_typedef {
                    // C99 function-type typedef: `typedef RET NAME(args);`.
                    // The declarator stopped at NAME; the `(args)`
                    // that follows is the function's parameter
                    // list. Parse it and bind NAME as a function-
                    // pointer alias (fpi=1, type bumped by one
                    // Ptr) -- every real use is through `NAME cb`
                    // (decays to fn-ptr per C99 6.3.2.1p4) or
                    // `NAME *cb` (already fn-ptr), so the two
                    // spellings collapse to the same effective
                    // shape in c5's model.
                    //
                    // parse_function_params binds each named parameter
                    // as a Loc symbol (it's shared with function-decl
                    // parsing). For a typedef there's no body to put
                    // those locals into scope for, so we restore each
                    // param's shadowed binding right after.
                    let (typedef_ty, typedef_fpi, typedef_params) =
                        if self.lex.tk == '(' && preconsumed_params.is_none() {
                            self.next()?; // consume `(`
                            let pp = self.parse_function_params()?;
                            for &p in &pp.indices {
                                Self::restore_shadowed_symbol(&mut self.symbols[p]);
                            }
                            let fty = ty + Ty::Ptr as i64;
                            (fty, 1i64, Some(pp))
                        } else if let Some(pp) = preconsumed_params {
                            // `typedef RET (*NAME)(args);`: the `(*NAME)`
                            // nested declarator already consumed the
                            // pointee's parameter list into
                            // `pending.fn_params`. Record the prototype on
                            // the typedef so a fn-pointer variable declared
                            // through it inherits the callee's variadic-ness
                            // and named-parameter count.
                            for &p in &pp.indices {
                                Self::restore_shadowed_symbol(&mut self.symbols[p]);
                            }
                            (ty, fn_ptr_indirection, Some(pp))
                        } else {
                            (ty, fn_ptr_indirection, None)
                        };
                    let prior_class = self.symbols[id_idx].class;
                    let prior_type = self.symbols[id_idx].type_;
                    if prior_class != 0 && prior_class != Token::Typedef as i64 {
                        return Err(self.compile_err(format!(
                            "typedef name `{}` clashes with prior non-typedef declaration",
                            self.symbols[id_idx].name
                        )));
                    }
                    if prior_class == Token::Typedef as i64 && prior_type != typedef_ty {
                        return Err(self.compile_err(format!(
                            "typedef `{}` redefined with a different type",
                            self.symbols[id_idx].name
                        )));
                    }
                    self.symbols[id_idx].class = Token::Typedef as i64;
                    self.symbols[id_idx].type_ = typedef_ty;
                    self.symbols[id_idx].val = 0;
                    self.symbols[id_idx].is_void_typedef = declarator_is_bare_void;
                    if typedef_fpi > 0 {
                        self.symbols[id_idx].fn_ptr_indirection = typedef_fpi;
                    }
                    if let Some(pp) = typedef_params {
                        self.symbols[id_idx].params = pp.types;
                        self.symbols[id_idx].is_variadic = pp.is_variadic;
                    } else if let Some((proto_fixed, proto_variadic)) =
                        self.pending.typedef_fn_proto.take()
                    {
                        // `typedef RET (*NAME)(args)`: the declarator
                        // captured the pointee signature's prototype
                        // (c5 otherwise skips it). Record the
                        // named-parameter count and variadic-ness so a
                        // fn-pointer variable declared through the
                        // typedef can split fixed vs variadic arguments
                        // per the host variadic ABI.
                        self.symbols[id_idx].params = alloc::vec![0i64; proto_fixed];
                        self.symbols[id_idx].is_variadic = proto_variadic;
                    }
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
                    continue;
                }

                // Sys-class predefined symbols (the per-target
                // header's libc bindings) are allowed to be
                // *re-declared* as prototypes -- the source uses the
                // declaration to teach the parser the type signature
                // without overriding the function's binding-driven
                // class/val. Function symbols with no body yet
                // (Token::Fun, val == 0) can also be re-declared
                // -- amalgamated translation units include the
                // same prototype many times. A second body for
                // the same Fun is still a real duplicate.
                let was_sys = self.symbols[id_idx].class == Token::Sys as i64;
                // Forward / repeat function declarations: allowed
                // either when the next token is `(` (the regular
                // `int foo(args)` shape) OR when parse_declarator
                // already consumed the outer params for the
                // function-returning-FP shape (tk is `;` or `{`
                // depending on prototype-vs-definition).
                let was_fwd_fun = self.symbols[id_idx].class == Token::Fun as i64
                    && (self.lex.tk == '(' || preconsumed_params.is_some());
                // Tentative-definition merge (C11 6.9.2): a prior
                // `T x;` (no `=`, no `extern`) becomes the defining
                // declaration when re-declared, optionally with an
                // initializer this time. Function-shaped re-decls
                // never go through this path.
                //
                // An earlier extern-only declaration is split into
                // two sub-cases by whether storage was allocated:
                //
                //   * `extern T x;` / `extern const T x;` -- the
                //     extern code path allocated `sizeof(T)` bytes
                //     at `sym.val`. Any code already emitted that
                //     refers to `&x` has that offset baked in.
                //     Reuse the storage when the definition lands
                //     so later refs see the same offset.
                //
                //   * `extern T x[];` -- deferred-size, no storage,
                //     `defined_here == false`. A reuse would write
                //     the initializer at `data[0..N]` and alias
                //     every following defining decl. Allocate
                //     fresh.
                let was_extern_redecl = self.symbols[id_idx].class == Token::Glo as i64
                    && !self.symbols[id_idx].has_initializer
                    && self.symbols[id_idx].is_extern_decl
                    && !self.symbols[id_idx].defined_here
                    && self.lex.tk != '(';
                let was_tentative_glo = self.symbols[id_idx].class == Token::Glo as i64
                    && !self.symbols[id_idx].has_initializer
                    && (!self.symbols[id_idx].is_extern_decl || self.symbols[id_idx].defined_here)
                    && self.lex.tk != '(';
                // C99 6.9.2: a file-scope declaration with no initializer
                // is a tentative definition. It is a redundant
                // declaration of an existing object -- whether or not
                // that object already carries an initializer -- and is
                // not an error. A second initializer is still rejected
                // because the prior symbol keeps `has_initializer`.
                let new_is_tentative_glo = self.symbols[id_idx].class == Token::Glo as i64
                    && self.lex.tk != Token::Assign
                    && self.lex.tk != '(';
                if self.symbols[id_idx].class != 0
                    && !was_sys
                    && !was_fwd_fun
                    && !was_tentative_glo
                    && !was_extern_redecl
                    && !new_is_tentative_glo
                {
                    return Err(self.compile_err("duplicate global definition"));
                }
                // Snapshot the prior signature before overwriting
                // `type_` so the redeclaration-mismatch warnings
                // below have something to compare against.
                let prior_return_ty = self.symbols[id_idx].type_;
                let prior_params = self.symbols[id_idx].params.clone();
                let prior_is_variadic = self.symbols[id_idx].is_variadic;
                self.symbols[id_idx].type_ = ty;

                if self.lex.tk == '(' || preconsumed_params.is_some() {
                    if !was_sys {
                        self.symbols[id_idx].class = Token::Fun as i64;
                        if self.symbols[id_idx].decl_line == 0 {
                            self.symbols[id_idx].decl_line = self.lex.line;
                            self.symbols[id_idx].decl_in_main_source = self.in_main_source();
                        }
                        // C99 6.2.2 linkage: `static` at file scope
                        // is internal; everything else (bare or
                        // `extern`) is external. `static` on either
                        // the prototype or the definition is
                        // sticky -- once seen, the function is
                        // internal-linkage from then on. Mirrors
                        // gcc / clang: `static int f(); int f() {
                        // ... }` keeps f static.
                        if static_seen {
                            self.symbols[id_idx].linkage = crate::c5::symbol::Linkage::Internal;
                        } else if self.symbols[id_idx].linkage
                            != crate::c5::symbol::Linkage::Internal
                        {
                            self.symbols[id_idx].linkage = crate::c5::symbol::Linkage::External;
                        }
                        if extern_seen {
                            self.symbols[id_idx].is_extern_decl = true;
                        }
                        // Leave `val` untouched. For a first-time
                        // prototype it stays at the Symbol default
                        // (0); the walker reads the live
                        // `Symbol::val` through `live_fun_val`
                        // when it lowers a call to this name, so
                        // a call placed before the body sees the
                        // post-body `ent_pc` once the body has
                        // been parsed. For a
                        // redeclaration after the body has been
                        // emitted, `val` already points at the
                        // real `ent_pc` and must not be
                        // clobbered -- a previous version of this
                        // code wrote `val = self.next_ent_pc`
                        // whenever val was 0, which silently
                        // broke any function whose body
                        // legitimately started at PC 0.
                    }
                    // Only warn on user-vs-user redeclarations.
                    // Sys symbols (the per-target header's libc
                    // bindings) start out with stub signatures
                    // that the user's `<stdio.h>` etc. is *expected*
                    // to refine -- complaining about every printf
                    // / memcpy / fcntl in the standard library
                    // would drown real bugs.
                    let prior_was_known = was_fwd_fun;
                    // Capture the long-double return-type marker
                    // before parameter parsing, which calls
                    // `parse_decl_base_type` per param and clears
                    // the side channel as part of its reset.
                    let ret_was_long_double = self.pending.base_was_long_double;
                    let mut params = if let Some(pp) = preconsumed_params {
                        pp
                    } else {
                        self.next()?;
                        self.parse_function_params()?
                    };

                    // Stash the signature on the function symbol so
                    // call sites can type-check arguments later. For
                    // both prototypes and bodied definitions.
                    self.symbols[id_idx].params = params.types.clone();
                    self.symbols[id_idx].is_variadic = params.is_variadic;
                    // C11 6.7.4: `_Noreturn` on any declaration of the
                    // function marks the symbol so the reachability
                    // analysis treats a call to it as not reaching its
                    // continuation. The standard non-returning library
                    // functions carry `_Noreturn` in the bundled
                    // headers, so a name reused without that declaration
                    // is not flagged. The flag is sticky -- a later
                    // plain redeclaration of an already-`_Noreturn`
                    // function keeps it.
                    if self.pending_noreturn {
                        self.symbols[id_idx].is_noreturn = true;
                    }
                    // Carry the bare-`void` return marker onto the
                    // symbol so the body-emit path zeroes the
                    // accumulator before the trailing return, and so a
                    // future call-site check can reject value-
                    // context use of a void callee. Prototypes
                    // pick it up too -- a later body that
                    // re-declares with a different bare-void-ness
                    // is itself a C99 6.7p4 redecl violation
                    // covered by the parameter-list check above.
                    if declarator_is_bare_void {
                        self.symbols[id_idx].returns_void = true;
                    }

                    // Warn if a redeclaration disagrees with the
                    // prior signature. C99 6.7p4 requires
                    // compatibility (same return type + same
                    // parameter list, modulo unprototyped forms);
                    // amalgamated translation units occasionally
                    // disagree by accident (a header was edited
                    // but one .c forgot to pick it up), which is
                    // a real bug worth surfacing -- but not one
                    // the c5 codegen is in a position to refuse,
                    // since it only has the redeclaration in scope.
                    // C99 6.7.5.3p14: an empty list in a non-defining
                    // function declarator means "no information about
                    // the number or types of the parameters is
                    // supplied" -- not a claim about a particular
                    // signature. Comparing such an unspecified-shape
                    // prototype against a fully-specified one isn't a
                    // mismatch under the standard, so we skip the
                    // parameter-list check when either side is empty.
                    // Two `static`-scope-but-amalgamated definitions
                    // that fully specify different parameters still
                    // warn, because both sides specify them.
                    let either_unspecified = prior_params.is_empty() || params.types.is_empty();
                    let return_differs = prior_return_ty != ty;
                    let variadic_differs = prior_is_variadic != params.is_variadic;
                    let params_differ = !either_unspecified && prior_params != params.types;
                    if prior_was_known && (return_differs || variadic_differs || params_differ) {
                        let name = self.symbols[id_idx].name.clone();
                        let line = self.lex.line;
                        let prior_sig = format_signature(
                            prior_return_ty,
                            &prior_params,
                            prior_is_variadic,
                            &self.structs,
                        );
                        let new_sig =
                            format_signature(ty, &params.types, params.is_variadic, &self.structs);
                        self.warn_at(
                            line,
                            format!(
                                "redeclaration of `{name}` differs from the previous \
                                 declaration\n  previous: {prior_sig}\n  now:      {new_sig}",
                            ),
                        );
                    }

                    // For Sys symbols (header-bound libc functions),
                    // also fold the variadic flag onto the matching
                    // `#pragma binding`. The native lowering reads
                    // it when it picks the variadic ABI path (macOS
                    // arm64 stack-packing, SysV `xor eax, eax`)
                    // instead of consulting the symbol table at
                    // codegen time -- it is out of scope by then.
                    if was_sys {
                        let name = self.symbols[id_idx].name.clone();
                        let fixed = params.types.len();
                        let variadic = params.is_variadic;
                        // `ty` is the return type the parser extracted just
                        // above. Stash it so the codegen knows whether the
                        // libc call leaves a 32-bit value with junk in the
                        // upper half of the host return register (msvcrt
                        // `int` returns) and needs sign / zero extension
                        // before the result becomes the c5 accumulator.
                        let ret_ty = ty;
                        let ret_is_long_double = ret_was_long_double;
                        for spec in self.dylibs.iter_mut() {
                            for binding in spec.bindings.iter_mut() {
                                if binding.local_name == name {
                                    binding.is_variadic = variadic;
                                    binding.fixed_args = fixed;
                                    binding.return_type_tag = ret_ty;
                                    binding.returns_long_double = ret_is_long_double;
                                    // Per-param types for the
                                    // DWARF subprogram DIE the codegen
                                    // emits over each PLT trampoline.
                                    // Without these, gdb shows
                                    // `in malloc ()` instead of
                                    // `in malloc (size=...)`.
                                    binding.param_types = params.types.clone();
                                }
                            }
                        }
                    }

                    if self.lex.tk == ';' || self.lex.tk == ',' {
                        // Function prototype, not a definition. C99 6.7
                        // permits several declarators in one declaration,
                        // so a prototype can be followed by `,` and more
                        // declarators (further prototypes or objects),
                        // e.g. `int f(int a), g(int a), a;`. Restore the
                        // param symbols' outer class (parse_function_params
                        // marked them as `Loc`) so subsequent declarations
                        // of the same names don't trip the
                        // duplicate-global check.
                        for sym in self.symbols.iter_mut() {
                            if sym.class == Token::Loc as i64 {
                                Self::restore_shadowed_symbol(sym);
                            }
                        }
                        // On `,` consume it and let the outer loop parse
                        // the next declarator; on `;` the outer loop exits
                        // and `self.next()` after it consumes the `;`.
                        if self.lex.tk == ',' {
                            self.next()?;
                        }
                        continue;
                    }

                    if was_sys {
                        return Err(self.compile_err(format!(
                            "cannot give a body to predefined library function `{}` \
                             (the per-target header's `#pragma binding` provides the \
                             implementation -- use a prototype only)",
                            self.symbols[id_idx].name
                        )));
                    }
                    // C99 6.9.1: an old-style (K&R) definition lists the
                    // parameter names in the declarator and gives their
                    // types in declarations between the `)` and the
                    // body; unlisted parameters keep the default int.
                    // Each declaration names one or more of the
                    // parameters already bound by parse_function_params,
                    // so update those symbols' types in place.
                    while self.lex.tk != '{' && self.lex.tk != 0 {
                        // A parameter declaration may lead with storage-
                        // class specifiers (`register short *p;`) and may
                        // omit the type, in which case it is int (C99
                        // 6.9.1 / 6.7.2p2). Stop when the next token is
                        // neither a specifier nor a type nor a parameter
                        // name -- that is the function body.
                        let mut saw_specifier = false;
                        while self.lex.tk == Token::FuncSpec
                            || self.lex.tk == Token::Static
                            || self.lex.tk == Token::Extern
                            || self.lex.tk == Token::TypeQual
                        {
                            self.next()?;
                            saw_specifier = true;
                        }
                        let base = if self.lex_is_type_start() {
                            self.parse_decl_base_type()?
                        } else if saw_specifier || self.lex.tk == Token::Id {
                            Ty::Int as i64
                        } else {
                            break;
                        };
                        while self.lex.tk != ';' && self.lex.tk != 0 {
                            let (decl_idx, mut decl_ty, decl_arr) = self.parse_declarator(base)?;
                            if decl_idx != usize::MAX {
                                // An array parameter is adjusted to a
                                // pointer to the element type (6.7.5.3p7).
                                if decl_arr != 0 {
                                    decl_ty += Ty::Ptr as i64;
                                }
                                if let Some(pos) =
                                    params.indices.iter().position(|&pi| pi == decl_idx)
                                {
                                    self.symbols[decl_idx].type_ = decl_ty;
                                    params.types[pos] = decl_ty;
                                } else {
                                    return Err(self.compile_err(
                                        "old-style parameter declaration names a non-parameter",
                                    ));
                                }
                            }
                            if self.lex.tk == ',' {
                                self.next()?;
                            }
                        }
                        if self.lex.tk == ';' {
                            self.next()?;
                        }
                    }
                    // Re-record the signature now that old-style
                    // declarations may have refined the parameter types.
                    self.symbols[id_idx].params = params.types.clone();

                    if self.lex.tk != '{' {
                        return Err(self.compile_err("bad function definition"));
                    }
                    self.next()?;

                    // Track this function's declared return type
                    // so the `return s` lowering knows whether to
                    // emit a struct-copy through the hidden
                    // out-pointer.
                    let return_ty = self.symbols[id_idx].type_;
                    self.current_func_return_ty = return_ty;
                    self.current_func_returns_void = self.symbols[id_idx].returns_void;
                    self.current_function_name = self.symbols[id_idx].name.clone();

                    // c5 callers push args right-to-left (cdecl-style), so
                    // the i'th declared param ends up at `[bp + 16*(i+1)]`,
                    // i.e. val = i + 2: the first declared param is at the
                    // shallowest c5 stack slot, the last is deepest.
                    // Variadic args follow after the last declared, at
                    // val = N+2, N+3, ... -- which is what stdarg.h walks.
                    //
                    // A function returning a struct value through the c5
                    // out-pointer convention gets a hidden out-pointer at
                    // val=2 (the caller pre-allocates a result temp and
                    // pushes its address as the first arg); declared params
                    // start at val=3. Host-ABI returns (AAPCS64 registers
                    // or x8) carry no hidden argument, so their params start
                    // at val=2 like any other function.
                    let param_base = if matches!(
                        super::struct_return_abi(&self.structs, self.target, return_ty),
                        super::StructReturnAbi::OutPtr
                    ) {
                        3
                    } else {
                        2
                    };
                    for (i, &idx) in params.indices.iter().enumerate() {
                        self.symbols[idx].val = (i as i64) + param_base;
                    }

                    self.loc_offs = 0;
                    self.max_loc_offs = 0;
                    self.labels.clear();
                    self.unresolved_gotos.clear();
                    self.uses_alloca_in_current_fn = false;
                    self.ast_reset();

                    let ent_pc = self.next_ent_pc;
                    // Point the symbol at the real `ent_pc`. The
                    // walker reads Symbol::val through live_fun_val
                    // when it lowers a call to this name, so any
                    // call placed before the body sees the post-body
                    // ent_pc once parsing reaches here.
                    //
                    // When a parameter shares the function's name (C99
                    // 6.2.1: the parameter shadows the function inside
                    // the body), the live binding at `id_idx` is the
                    // parameter, holding its stack slot. Write the entry
                    // pc onto the shadowed function binding (`h_val`),
                    // which the function-exit cleanup restores, so the
                    // parameter's slot survives the body.
                    if params.indices.contains(&id_idx) {
                        self.symbols[id_idx].h_val = ent_pc as i64;
                    } else {
                        self.symbols[id_idx].val = ent_pc as i64;
                    }
                    self.symbols[id_idx].defined_here = true;
                    // A body trumps any earlier `extern T f();`
                    // forward declaration -- the function is now
                    // defined in this translation unit.
                    self.symbols[id_idx].is_extern_decl = false;

                    // Struct-value parameters: the caller pushed
                    // the struct's *address* into the param slot
                    // (matching the "address is the value" rule
                    // for struct rvalues). Without a copy the
                    // function body's `p.field = v` would land in
                    // the caller's storage, which isn't C
                    // by-value. Memcpy each struct param into a
                    // freshly allocated local and re-point the
                    // param's symbol so subsequent accesses inside
                    // the function go to the local copy. The
                    // sequence reuses the struct-copy intrinsic so
                    // neither codegen needs new shapes for
                    // parameter passing.
                    for &idx in params.indices.iter() {
                        let pty = self.symbols[idx].type_;
                        if !is_struct_ty(pty) || struct_ptr_depth(pty) != 0 {
                            continue;
                        }
                        let slots = self.slots_of_type(pty);
                        let param_val = self.symbols[idx].val;
                        self.loc_offs += slots;
                        let local_val = -self.loc_offs;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        // dst = &local
                        self.emit_lea(local_val);
                        self.ast_psh();
                        // src = *param_slot (the passed address;
                        // val from the param-base-aware
                        // numbering above)
                        self.emit_lea(param_val);
                        self.mark_emit_other();
                        self.mark_emit_other();
                        // The symbol now points at the local copy.
                        self.symbols[idx].val = local_val;
                    }

                    // `float` parameters get the same "rebind to a
                    // freshly allocated local" treatment as struct
                    // by-value params, but for a different reason:
                    // c5's call ABI passes every arg as an 8-byte
                    // c5-stack slot holding the value's `f64::to_bits`
                    // (the caller's `expr` left an `f64` in the
                    // accumulator and `Si` wrote all 8 bytes). With
                    // `sizeof(float) == 4`, the matching `LoadKind::F32`
                    // load that the body would emit reads only the
                    // *low* 4 bytes of the slot, which for a typical
                    // `double`-shaped bit pattern is the *low* half
                    // of the mantissa -- garbage, not the f32 of the
                    // passed value. The fix: at function entry,
                    // narrow each `float`-typed param through the
                    // 4-byte store path (the 8-byte load reads the
                    // caller's f64 bits, the 4-byte store narrows
                    // to f32 and writes 4 bytes into a fresh local
                    // slot). The
                    // symbol is repointed to that local; every
                    // subsequent body access goes through the
                    // narrow-storage path the rest of the
                    // float-typed code expects, and the load/store
                    // semantics stay consistent.
                    for &idx in params.indices.iter() {
                        let pty = self.symbols[idx].type_ & !UNSIGNED_BIT;
                        if pty != Ty::Float as i64 {
                            continue;
                        }
                        let param_val = self.symbols[idx].val;
                        self.loc_offs += 1; // float local takes 1 slot
                        let local_val = -self.loc_offs;
                        if self.loc_offs > self.max_loc_offs {
                            self.max_loc_offs = self.loc_offs;
                        }
                        // dst = &local
                        self.emit_lea(local_val);
                        self.ast_psh();
                        // Load the caller-pushed f64::to_bits from
                        // the param slot. The full 8-byte load is
                        // intentional -- the caller pushed 8 bytes
                        // and the f32 information lives across all
                        // 8 of them (as an f64).
                        self.emit_lea(param_val);
                        self.mark_emit_other();
                        // Narrow to f32 + write 4 bytes to the local.
                        // The rounding is round-to-nearest-ties-to-
                        // even, matching `f64 as f32` in Rust and
                        // `cvtsd2ss` / `fcvt s, d` on the JIT path.
                        self.ast_assign();
                        // Symbol now points at the f32-storage local.
                        self.symbols[idx].val = local_val;
                    }

                    // C99 block-scope: declarations may appear
                    // anywhere a statement may. Each iteration
                    // either parses a local decl (with optional
                    // initializer) into the function's symbol
                    // frame, or parses a statement.
                    let mut top_level_ids: alloc::vec::Vec<super::super::ast::StmtId> =
                        alloc::vec::Vec::new();
                    while self.lex.tk != '}' {
                        if self.lex.tk == Token::StaticAssert {
                            // C11 6.7.10 lets static_assert sit
                            // anywhere a declaration may appear,
                            // including the function-body top
                            // level (and the inner blocks reached
                            // through parse_block_stmt).
                            self.parse_static_assert()?;
                        } else if self.lex.tk == Token::Typedef {
                            // C99 6.7.7: a typedef may appear at the
                            // function-body top level. `lex_is_type_start`
                            // does not cover the `typedef` storage-class
                            // keyword, so dispatch it here (the nested
                            // blocks reach the same handler through
                            // parse_block_stmt).
                            self.parse_block_typedef(None)?;
                        } else if self.lex_is_type_start() {
                            let item_before = self.ast_stmts_snapshot();
                            self.parse_function_body_local_decl()?;
                            let item_after = self.ast.stmts.len();
                            for id in item_before..item_after {
                                top_level_ids.push(id as super::super::ast::StmtId);
                            }
                        } else {
                            let item_before = self.ast_stmts_snapshot();
                            self.stmt()?;
                            let item_after = self.ast.stmts.len();
                            let item_id = if item_after > item_before + 1 {
                                self.ast_wrap_stmts_since(item_before)
                            } else if item_after > item_before {
                                (item_after - 1) as super::super::ast::StmtId
                            } else {
                                continue;
                            };
                            top_level_ids.push(item_id);
                        }
                    }
                    // Wrap the function's top-level stmts into a
                    // Compound and pin it as `ast.body` so the
                    // walker has a single tree root to descend
                    // without double-walking inner-wrapped stmts.
                    let body_root = self.ast_wrap_block_items(&top_level_ids);
                    self.ast.body = Some(body_root);
                    // C99 6.8.6.4p3: a `void`-returning function
                    // doesn't produce a value. Zero the accumulator
                    // before the trailing synthetic return so a
                    // caller that misclassifies the prototype (or
                    // invokes the function through a typed
                    // function-pointer table whose slot was set
                    // from a value-returning cast) reads `0`
                    // instead of whatever the function body
                    // happened to leave in the accumulator.
                    if self.current_func_returns_void {
                        self.emit_imm(0);
                    }
                    self.emit_dead_stores_and_flush();
                    let n_params = params.indices.len();
                    let is_variadic = params.is_variadic;
                    // Snapshot per-param types + the local-copy
                    // slot the parser allocated for each
                    // struct-by-value parameter. The walker
                    // replays the C99 6.5.2.2 entry-Mcpy from
                    // these so the callee operates on its own
                    // copy. Scalar / pointer params end up
                    // with `0` in `param_local_slots`; the
                    // walker checks the slot and the type both.
                    let param_tys: alloc::vec::Vec<i64> = params.types.to_vec();
                    let param_local_slots: alloc::vec::Vec<i64> = params
                        .indices
                        .iter()
                        .map(|&idx| {
                            let v = self.symbols[idx].val;
                            // `val < 0` -> local slot reassigned
                            // by the entry-Mcpy emit; preserve
                            // it. `val >= 0` -> scalar param
                            // still sits in its original slot;
                            // record 0 so the walker skips.
                            if v < 0 { v } else { 0 }
                        })
                        .collect();
                    let ret_ty_for_finish = self.current_func_return_ty;
                    let returns_struct_finish =
                        is_struct_ty(ret_ty_for_finish) && struct_ptr_depth(ret_ty_for_finish) == 0;
                    let return_struct_size_finish = if returns_struct_finish {
                        self.size_of_type(ret_ty_for_finish) as i64
                    } else {
                        0
                    };

                    // Patch Ent's local-slot count. With alloca,
                    // bump it by 1 (the alloca-top bookkeeping
                    // slot) plus the fixed arena slot count so the
                    // prologue reserves the arena alongside the
                    // regular locals. The alloca-top slot sits at
                    // index `max_loc_offs + 1` (just below all
                    // regular locals); the arena occupies indices
                    // `[max_loc_offs + 2, max_loc_offs + 1 + ARENA_SLOTS]`.
                    let regular_locals = self.max_loc_offs.max(self.loc_offs);
                    let alloca_top_slot_finish: i64 = if self.uses_alloca_in_current_fn {
                        regular_locals + 1
                    } else {
                        0
                    };

                    // C99 6.9.1p12: a value-returning function must not
                    // reach its closing brace without a `return value;`.
                    // Run before `ast_finish_function` moves the body AST.
                    self.check_non_void_fall_off()?;
                    self.ast_finish_function(
                        ent_pc,
                        n_params,
                        is_variadic,
                        param_tys,
                        param_local_slots,
                        returns_struct_finish,
                        return_struct_size_finish,
                        ret_ty_for_finish,
                        alloca_top_slot_finish,
                    );
                    self.current_function_name.clear();
                    self.current_func_returns_void = false;

                    for name in &self.unresolved_gotos {
                        if !self.labels.iter().any(|n| n == name) {
                            return Err(self.compile_err(format!("unresolved label: {}", name)));
                        }
                    }

                    // Snapshot the function's locals +
                    // formal parameters before `restore_shadowed_symbol`
                    // unwinds the bindings. The DWARF emitter groups
                    // these by `function_bc_pc` (the Ent's PC) and
                    // emits `DW_TAG_formal_parameter` /
                    // `DW_TAG_variable` DIEs as children of the
                    // matching subprogram, with `DW_OP_fbreg` locations
                    // derived from `fp_slot * 8`. Slots `0..2` cover
                    // the saved-x29 / saved-x30 area and don't
                    // correspond to a user-visible name; everything
                    // else is either a parameter (val >= 2) or a
                    // local (val < 0).
                    let param_set: alloc::collections::BTreeSet<usize> =
                        params.indices.iter().copied().collect();
                    for (i, sym) in self.symbols.iter().enumerate() {
                        if sym.class == Token::Loc as i64
                            && sym.val != 0
                            && sym.val != 1
                            && !sym.name.is_empty()
                        {
                            let is_parameter = param_set.contains(&i);
                            // C99 6.7.5.3p7: a parameter declared as
                            // `T name[N]` decays to a pointer and
                            // doesn't carry an array-type DIE; keep
                            // `array_size` at zero for parameters.
                            let array_size = if is_parameter {
                                0
                            } else {
                                sym.array_size.max(0) as u32
                            };
                            self.variables.push(crate::c5::program::VariableInfo {
                                function_bc_pc: ent_pc as u64,
                                name: sym.name.clone(),
                                type_tag: sym.type_,
                                fp_slot: sym.val,
                                is_parameter,
                                decl_line: sym.decl_line as u32,
                                array_size,
                                decl_file: sym.decl_file,
                            });
                        }
                    }
                    // Merge block-scoped locals captured during body
                    // parsing. The symbol walk above misses them: their
                    // bindings were restored at block exit. Every
                    // pending entry belongs to this function, since C
                    // has no nested function definitions.
                    for mut bl in core::mem::take(&mut self.pending_block_locals) {
                        bl.function_bc_pc = ent_pc as u64;
                        self.variables.push(bl);
                    }
                    // Collect unused-parameter and unused-local
                    // diagnostics for the function's top-level
                    // bindings. Inner-block locals were already
                    // checked in `parse_block_stmt` at their
                    // block exit. Must run before the loop below
                    // restores the outer binding -- once `class`
                    // is overwritten the Token::Loc test no
                    // longer holds. Names starting with `_` are
                    // suppressed (gcc / clang `-Wunused`
                    // convention).
                    enum UnusedKind {
                        Variable,
                        Parameter,
                        ValueSet,
                    }
                    let mut unused: Vec<(usize, String, UnusedKind)> = Vec::new();
                    for (i, sym) in self.symbols.iter().enumerate() {
                        if sym.class != Token::Loc as i64
                            || !sym.decl_in_main_source
                            || sym.address_escaped
                            || sym.was_read
                            || sym.name.is_empty()
                            || sym.name.starts_with('_')
                        {
                            continue;
                        }
                        let is_param = param_set.contains(&i);
                        // sym.val < 0 -> stack-frame local
                        // sym.val >= 2 -> parameter slot
                        // (slots 0/1 are reserved for caller's
                        // saved rbp / saved-ret-addr; never
                        // user-visible names)
                        if !is_param && sym.val >= 0 {
                            continue;
                        }
                        // `was_referenced` distinguishes "never
                        // mentioned in any expression" (the only
                        // write, if any, was the declaration
                        // initializer) from "mentioned, but every
                        // mention was a write". The latter is the
                        // dead-store case. Parameters skip the
                        // ValueSet diagnostic -- a parameter is
                        // always implicitly written at call entry,
                        // and warning "set but never used" on
                        // every unused parameter would just be
                        // noise.
                        let kind = if sym.was_referenced && sym.was_written && !is_param {
                            UnusedKind::ValueSet
                        } else if is_param {
                            UnusedKind::Parameter
                        } else {
                            UnusedKind::Variable
                        };
                        unused.push((sym.decl_line, sym.name.clone(), kind));
                    }
                    for (line, name, kind) in unused {
                        let msg = match kind {
                            UnusedKind::Variable => alloc::format!("unused variable `{name}`"),
                            UnusedKind::Parameter => alloc::format!("unused parameter `{name}`"),
                            UnusedKind::ValueSet => {
                                alloc::format!("variable `{name}` set but never used")
                            }
                        };
                        self.warn_at(line, msg);
                    }
                    // Drain dead-store entries for this function's
                    // locals via the shared helper -- a store that
                    // reaches function exit without an intervening
                    // read or branch is unambiguously dead.
                    self.emit_dead_stores_and_flush();
                    for sym in self.symbols.iter_mut() {
                        // Block-scope locals (`Loc`) and `static` locals
                        // (promoted to `Glo` but block-scoped) both unbind
                        // at function exit so a file-scope object of the
                        // same name reappears.
                        if sym.class == Token::Loc as i64
                            || sym.is_scope_static
                            || sym.is_scope_typedef
                        {
                            Self::restore_shadowed_symbol(sym);
                        }
                    }
                } else {
                    self.symbols[id_idx].class = Token::Glo as i64;
                    if !was_tentative_glo {
                        self.symbols[id_idx].is_thread_local = thread_local;
                    }
                    // C99 6.2.2 linkage on file-scope variables.
                    // `static` is sticky once seen on any earlier
                    // declaration of the same name; absent that,
                    // the default is external linkage. `extern T x;`
                    // is captured separately so an extern-only
                    // declaration can be distinguished from a
                    // tentative definition at link-unit assembly.
                    if static_seen {
                        self.symbols[id_idx].linkage = crate::c5::symbol::Linkage::Internal;
                    } else if self.symbols[id_idx].linkage != crate::c5::symbol::Linkage::Internal {
                        self.symbols[id_idx].linkage = crate::c5::symbol::Linkage::External;
                    }
                    let was_extern_only_decl =
                        extern_seen && self.lex.tk != Token::Assign && array_size != -1;
                    // `extern struct S s;` while `struct S` is still
                    // incomplete cannot reserve storage (its size is
                    // unknown), and C99 6.9.2 makes it a pure declaration
                    // anyway. Record an undefined external reference; the
                    // defining declaration that follows the struct's
                    // completion allocates the bytes. Without this the
                    // permissive single-TU fallback below would reserve a
                    // wrong-sized slot and the next global would overlap.
                    if was_extern_only_decl
                        && is_struct_ty(ty)
                        && struct_ptr_depth(ty) == 0
                        && self.structs[struct_id_of(ty)].fields.is_empty()
                    {
                        self.symbols[id_idx].is_extern_decl = true;
                        self.symbols[id_idx].defined_here = false;
                        self.symbols[id_idx].type_ = ty;
                        if self.lex.tk == ',' {
                            self.next()?;
                        }
                        continue;
                    }
                    if was_extern_only_decl {
                        self.symbols[id_idx].is_extern_decl = true;
                    } else {
                        self.symbols[id_idx].is_extern_decl = false;
                        // Default: a file-scope global declaration
                        // that reaches this branch will allocate
                        // storage (or merge with prior tentative
                        // storage) below; the matching
                        // `defined_here = true` is set at each
                        // alloc site so the field tracks every
                        // path that produces real bytes.
                    }
                    // Deferred-size array global: the dimension
                    // comes from the initializer and storage is
                    // reserved after parsing it. Disallow on TLS
                    // globals -- the per-target rebase ordering
                    // needs design work.
                    if array_size == -1 {
                        if self.lex.tk != Token::Assign {
                            // `extern T x[];` declares an array
                            // whose definition (with its actual
                            // size) lives in another TU. Mark
                            // the symbol as undefined-here and
                            // let the link step resolve the
                            // address against the defining TU's
                            // storage.
                            if extern_seen {
                                self.symbols[id_idx].is_extern_decl = true;
                                self.symbols[id_idx].defined_here = false;
                                if self.lex.tk == ',' {
                                    self.next()?;
                                }
                                continue;
                            }
                            return Err(self.compile_err(format!(
                                "array `{}` declared with empty brackets needs an initializer",
                                self.symbols[id_idx].name
                            )));
                        }
                        if thread_local {
                            return Err(self.compile_err(
                                "deferred-size `_Thread_local` arrays are not supported",
                            ));
                        }
                        self.next()?;
                        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                            // `struct T xs[] = { {...}, {...}, ... };`
                            // Pre-scan the source to count elements so
                            // every element's storage is pre-reserved
                            // contiguously *before* any string literal
                            // inside an element gets appended to
                            // `self.data` and pushes subsequent
                            // elements to a non-contiguous offset.
                            let elem_size = self.size_of_type(ty);
                            if self.lex.tk != '{' {
                                return Err(
                                    self.compile_err("array initializer must start with `{{`")
                                );
                            }
                            let sid = struct_id_of(ty);
                            // C99 6.7.8p20 brace elision: when no element
                            // carries its own braces, the flat value list
                            // fills consecutive struct elements, each
                            // consuming the struct's scalar slot count.
                            let groups = self.lex.count_top_level_groups_in_array();
                            let count = if groups > 0 {
                                groups as i64
                            } else {
                                let items = self.lex.count_top_level_items_in_array();
                                let slots = self.struct_flat_init_slots(sid).max(1);
                                items.div_ceil(slots) as i64
                            };
                            self.next()?;
                            self.align_data_to_8();
                            let off = self.data.len() as i64;
                            self.symbols[id_idx].val = off;
                            for _ in 0..(count * elem_size as i64) {
                                self.data.push(0);
                            }
                            let mut i: i64 = 0;
                            while self.lex.tk != '}' {
                                // C99 6.7.8p7 array designator on a
                                // struct-array element: `[N] = {field, ...}`
                                // jumps the cursor and writes the
                                // brace list there.
                                if self.lex.tk == Token::Brak {
                                    self.next()?;
                                    let idx = self.parse_constant_int()?;
                                    if idx < 0 || idx >= count {
                                        return Err(self.compile_err(format!(
                                            "array designator index {idx} out of bounds [0, {count})"
                                        )));
                                    }
                                    if self.lex.tk != ']' {
                                        return Err(self.compile_err(
                                            "`]` expected after array designator index",
                                        ));
                                    }
                                    self.next()?;
                                    if self.lex.tk != Token::Assign {
                                        return Err(
                                            self.compile_err("`=` expected after `[N]` designator")
                                        );
                                    }
                                    self.next()?;
                                    i = idx;
                                }
                                if i >= count {
                                    return Err(self.compile_err(format!("struct array element count miscount (parser scanned {count}, parsed past)")));
                                }
                                let here = off + i * elem_size as i64;
                                if self.lex.tk == '{' {
                                    self.collect_struct_initializer(sid, here)?;
                                } else {
                                    // Brace-elided element: fill the
                                    // struct's fields from the flat list
                                    // until it is full, leaving the rest
                                    // for the next element.
                                    self.fill_struct_fields(sid, here, false)?;
                                }
                                i += 1;
                                if self.lex.tk == ',' {
                                    self.next()?;
                                }
                            }
                            self.next()?; // consume `}`
                            self.symbols[id_idx].array_size = count;
                            // Pad data to 8-byte alignment so the next
                            // global doesn't land on an odd offset.
                            while !self.data.len().is_multiple_of(8) {
                                self.data.push(0);
                            }
                            self.symbols[id_idx].has_initializer = true;
                            self.symbols[id_idx].defined_here = true;
                            if self.lex.tk == ',' {
                                self.next()?;
                            }
                            continue;
                        }
                        self.pending.init_inner_dims = self.inner_dims_of(id_idx);
                        let elements = self.collect_array_initializer(ty)?;
                        let final_size = elements.len() as i64;
                        self.symbols[id_idx].array_size = final_size;
                        // Patch the deferred-outer placeholder in
                        // `array_dims[0]` to the resolved row count.
                        // Layout: total elements = outer * inner-dims-product,
                        // so the outermost count is final_size /
                        // product(dims[1..]).
                        if let Some(first) = self.symbols[id_idx].array_dims.first().copied()
                            && first == 0
                        {
                            let inner_product: i64 =
                                self.symbols[id_idx].array_dims.iter().skip(1).product();
                            if inner_product > 0 {
                                self.symbols[id_idx].array_dims[0] = final_size / inner_product;
                            }
                        }
                        let total_bytes = (self.size_of_type(ty) as i64) * final_size;
                        let aligned = ((total_bytes + 7) / 8) * 8;
                        // On a tentative-merge path the prior
                        // declaration would have had no `[]` either
                        // (deferred size cannot be a re-decl), so
                        // always allocate fresh storage here.
                        if self.size_of_type(ty) > 1 {
                            self.align_data_to_8();
                        }
                        let off = self.data.len() as i64;
                        self.symbols[id_idx].val = off;
                        for _ in 0..aligned {
                            self.data.push(0);
                        }
                        self.write_array_init_into_data(off, ty, &elements);
                        self.symbols[id_idx].has_initializer = true;
                        self.symbols[id_idx].defined_here = true;
                    } else {
                        let bytes = if array_size > 0 {
                            let total = (self.size_of_type(ty) as i64) * array_size;
                            ((total + 7) / 8) * 8
                        } else {
                            self.slots_of_type(ty) * 8
                        };
                        // `extern T x;` -- C99 6.9.2 says no
                        // tentative definition. We still
                        // allocate storage here so the single-TU
                        // `Compiler::compile()` path stays
                        // permissive (writing through `a` in
                        // `extern int a; a = 1;` works without a
                        // link partner). In a multi-TU build the
                        // walker emits a `GloAddr::Extern` reference
                        // for an `extern`-marked Glo with no
                        // initializer, so the defining TU's bytes
                        // are the ones in play and this local
                        // storage is only the single-TU fallback.
                        let _ = was_extern_only_decl;
                        // Tentative-merge: reuse the storage that was
                        // already allocated for the prior declaration.
                        // The initializer (if any) writes into the
                        // existing slot. Mismatched array sizes between
                        // the prior tentative and the new defining
                        // declaration aren't merged here -- the prior
                        // allocation would be too small or too large.
                        // Reuse the prior storage on a tentative merge,
                        // and also when a redundant tentative declaration
                        // (no initializer) follows an already-defined
                        // global -- C99 6.9.2 makes the later `T x;` a
                        // redeclaration of the same object, so allocating
                        // fresh zeroed storage would discard its value.
                        // The two-initializer case already errored at the
                        // duplicate-definition check above.
                        let reuse_prior_storage = was_tentative_glo
                            || (self.symbols[id_idx].defined_here && self.lex.tk != Token::Assign);
                        let var_offset = if reuse_prior_storage {
                            self.symbols[id_idx].val
                        } else if thread_local {
                            let off = self.tls_data.len() as i64;
                            self.symbols[id_idx].val = off;
                            for _ in 0..bytes {
                                self.tls_data.push(0);
                            }
                            off
                        } else {
                            if self.size_of_type(ty) > 1 {
                                self.align_data_to_8();
                            }
                            let off = self.data.len() as i64;
                            self.symbols[id_idx].val = off;
                            for _ in 0..bytes {
                                self.data.push(0);
                            }
                            off
                        };
                        self.symbols[id_idx].defined_here = true;

                        // Optional initializer. For non-arrays, the
                        // restricted constant-expression path
                        // (parse_global_initializer) handles
                        // integer / NULL / address-of-global. For
                        // known-size arrays, a string literal or a
                        // brace list populates the leading bytes;
                        // the rest stays zero (the allocation
                        // pre-zeroed self.data). For struct-value
                        // globals, a `{ ... }` brace list with
                        // designators or positional entries
                        // populates per-field; unspecified fields
                        // stay zero.
                        if self.lex.tk == Token::Assign {
                            self.next()?;
                            if array_size > 0 && is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                                if thread_local {
                                    return Err(self.compile_err(
                                        "array `_Thread_local` initialisers are not supported",
                                    ));
                                }
                                // Known-size struct array: write each
                                // brace-list element into the pre-
                                // allocated slot. Missing trailing
                                // entries stay zero-init.
                                let elem_size = self.size_of_type(ty);
                                let sid = struct_id_of(ty);
                                if self.lex.tk != '{' {
                                    return Err(
                                        self.compile_err("array initializer must start with `{{`")
                                    );
                                }
                                self.next()?;
                                let mut idx: i64 = 0;
                                while self.lex.tk != '}' {
                                    // C99 6.7.8p7 array designator on a
                                    // struct-array element: `[N] = {field, ...}`
                                    // jumps the cursor and writes the
                                    // brace list there.
                                    if self.lex.tk == Token::Brak {
                                        self.next()?;
                                        let desig = self.parse_constant_int()?;
                                        if desig < 0 || desig >= array_size {
                                            return Err(self.compile_err(format!(
                                                "array designator index {desig} out of bounds [0, {array_size})"
                                            )));
                                        }
                                        if self.lex.tk != ']' {
                                            return Err(self.compile_err(
                                                "`]` expected after array designator index",
                                            ));
                                        }
                                        self.next()?;
                                        if self.lex.tk != Token::Assign {
                                            return Err(self.compile_err(
                                                "`=` expected after `[N]` designator",
                                            ));
                                        }
                                        self.next()?;
                                        idx = desig;
                                    }
                                    if idx >= array_size {
                                        return Err(self.compile_err(format!(
                                            "too many initializers for `{}`",
                                            self.symbols[id_idx].name
                                        )));
                                    }
                                    let here = var_offset + idx * elem_size as i64;
                                    // C99 6.7.8p20: the braces around each
                                    // struct element may be elided, in which
                                    // case the flat list fills that element's
                                    // fields in order.
                                    if self.lex.tk == '{' {
                                        self.collect_struct_initializer(sid, here)?;
                                    } else {
                                        self.fill_struct_fields(sid, here, false)?;
                                    }
                                    idx += 1;
                                    if self.lex.tk == ',' {
                                        self.next()?;
                                    }
                                }
                                self.next()?; // consume `}`
                            } else if array_size > 0 {
                                if thread_local {
                                    return Err(self.compile_err(
                                        "array `_Thread_local` initialisers are not supported",
                                    ));
                                }
                                self.pending.init_inner_dims = self.inner_dims_of(id_idx);
                                self.pending.init_target_array_size = array_size;
                                let elements = self.collect_array_initializer(ty)?;
                                if elements.len() > array_size as usize {
                                    return Err(self.compile_err(format!(
                                        "too many initializers for array `{}` ({} > {})",
                                        self.symbols[id_idx].name,
                                        elements.len(),
                                        array_size
                                    )));
                                }
                                self.write_array_init_into_data(var_offset, ty, &elements);
                            } else if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                                if thread_local {
                                    return Err(self.compile_err(
                                        "struct `_Thread_local` initialisers are not supported",
                                    ));
                                }
                                let sid = struct_id_of(ty);
                                self.collect_struct_initializer(sid, var_offset)?;
                            } else {
                                self.parse_global_initializer(ty, var_offset, thread_local)?;
                            }
                            self.symbols[id_idx].has_initializer = true;
                        }
                    }
                }
                if self.lex.tk == ',' {
                    self.next()?;
                }
            }
            self.next()?;
        }
        self.warn_unused_static_functions();
        Ok(())
    }

    /// Emit one `unused function` diagnostic per defined-here
    /// Token::Fun whose `was_referenced` flag is still false and
    /// whose `linkage` is `Internal`. C99 6.2.2: a `static`
    /// file-scope function is reachable only from the current
    /// translation unit, so an unreferenced one really is dead
    /// code. External-linkage functions cannot be flagged here --
    /// another TU may call them through the link-unit symbol
    /// table; the linker is responsible for the cross-TU
    /// reachability check. Names starting with `_` are suppressed
    /// (gcc / clang `-Wunused-function` convention). `main` is
    /// suppressed regardless of linkage: it is the program's
    /// entry, called by the runtime stub the codegen emits.
    fn warn_unused_static_functions(&mut self) {
        use crate::c5::symbol::Linkage;
        let mut unused: Vec<(usize, String)> = Vec::new();
        for sym in self.symbols.iter() {
            if sym.class != Token::Fun as i64
                || !sym.defined_here
                || sym.linkage != Linkage::Internal
                || sym.was_referenced
                || !sym.decl_in_main_source
                || sym.name.is_empty()
                || sym.name.starts_with('_')
                || sym.name == "main"
            {
                continue;
            }
            unused.push((sym.decl_line, sym.name.clone()));
        }
        for (line, name) in unused {
            self.warn_at(line, alloc::format!("unused function `{name}`"));
        }
    }
}
