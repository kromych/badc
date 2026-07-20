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
    UNSIGNED_BIT, VOLATILE_BIT, format_signature, is_decl_modifier, is_struct_ty, struct_id_of,
    struct_ptr_depth,
};

impl Compiler {
    /// Size of a deferred-size struct array (`struct T xs[] = { ... }`) that
    /// may use array designators (`[N] = { ... }`). C99 6.7.8p22: the size is
    /// one greater than the largest index initialized, whether reached
    /// positionally or by a designator. The positional group count
    /// (`fallback`) misses a designator that jumps past it, so peek the
    /// element list -- evaluating each `[expr]` designator -- and track the
    /// running index the same way the fill loop does. Snapshot-restored, with
    /// any data / PC the constant-fold touched rewound, so the real fill
    /// re-parses from a clean state.
    pub(super) fn designated_array_count(&mut self, fallback: i64) -> Result<i64, C5Error> {
        let snap = self.lex.snapshot();
        let saved_data = self.data.len();
        let saved_pc = self.next_ent_pc;
        let result = self.designated_array_count_inner(fallback);
        self.lex.restore(snap);
        self.data.truncate(saved_data);
        self.next_ent_pc = saved_pc;
        // A non-constant designator (invalid, or a shape this peek can't
        // fold) falls back to the positional count; the real fill re-parses
        // and reports any genuine error.
        Ok(result.unwrap_or(fallback))
    }

    /// Peek whether the first element of the array initializer at the
    /// current `{` is an `[N]` designator, without consuming input.
    fn array_first_element_is_designator(&mut self) -> bool {
        let snap = self.lex.snapshot();
        let saved_data = self.data.len();
        let saved_pc = self.next_ent_pc;
        let is_desig = self.next().is_ok() && self.lex.tk == Token::Brak;
        self.lex.restore(snap);
        self.data.truncate(saved_data);
        self.next_ent_pc = saved_pc;
        is_desig
    }

    fn designated_array_count_inner(&mut self, fallback: i64) -> Result<i64, C5Error> {
        self.next()?; // consume `{`
        let mut i: i64 = 0;
        let mut max_count = fallback;
        while self.lex.tk != '}' && self.lex.tk != 0 {
            if self.lex.tk == Token::Brak {
                self.next()?;
                i = self.parse_constant_int()?;
                if self.lex.tk == ']' {
                    self.next()?;
                }
                if self.lex.tk == Token::Assign {
                    self.next()?;
                }
            }
            self.skip_init_element_value()?;
            if i + 1 > max_count {
                max_count = i + 1;
            }
            i += 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        Ok(max_count)
    }

    /// Advance past one initializer element's value to the next top-level `,`
    /// or the closing `}`, tracking bracket depth so a comma nested inside a
    /// brace / paren / bracket group does not end the element early.
    fn skip_init_element_value(&mut self) -> Result<(), C5Error> {
        let mut depth: i32 = 0;
        while self.lex.tk != 0 {
            if depth == 0 && (self.lex.tk == ',' || self.lex.tk == '}') {
                break;
            }
            if self.lex.tk == '{' || self.lex.tk == '(' || self.lex.tk == Token::Brak {
                depth += 1;
            } else if self.lex.tk == '}' || self.lex.tk == ')' || self.lex.tk == ']' {
                depth -= 1;
            }
            self.next()?;
        }
        Ok(())
    }

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
            // Set when the base type is an `enum`; recorded on a
            // typedef so an enum bitfield declared through it reads
            // unsigned.
            let mut base_is_enum = false;
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
            // Reset the const carrier so a prior declaration's `const`
            // base does not leak onto this iteration's declarators.
            self.pending.base_is_const = false;
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
            let mut atomic_base: Option<i64> = None;
            let mut qual_bits: i64 = 0;
            let mut m = decl_base::IntModifiers::default();
            // `_Noreturn`, `__declspec(thread)`, `__declspec(dllexport)`, and
            // `inline` scope to this declaration; clear the carriers so they
            // cannot leak onto the next one. `inline` matters even without a
            // body: an inline prototype must not mark the following
            // declaration as inline when the linkage rule reads the flag.
            self.pending_noreturn = false;
            self.pending.attr_thread_local = false;
            self.pending.attr_dllexport = false;
            self.pending.attr_align = 0;
            self.pending.attr_vector_size = 0;
            self.pending.attr_constructor = false;
            self.pending.attr_destructor = false;
            self.pending.attr_init_priority = None;
            self.pending.attr_cleanup = None;
            self.pending_is_inline = false;
            self.pending_is_always_inline = false;
            self.pending_is_naked = false;
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
                } else if self.lex.tk == Token::Atomic && self.lex.peek_after_whitespace(b'(') {
                    // C11 6.7.2.4 atomic type specifier `_Atomic(type-name)`:
                    // the inner type-name names the base type (distinct from
                    // the `_Atomic` qualifier consumed as a no-op below).
                    atomic_base = self.try_parse_atomic_type_specifier()?;
                } else if self.lex.tk == Token::Attribute
                    || (self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'['))
                {
                    self.skip_attribute_specifiers()?;
                    // `__declspec(thread)` in the specifier run -> thread-local.
                    if self.pending.attr_thread_local {
                        thread_local = true;
                        self.pending.attr_thread_local = false;
                    }
                } else if is_decl_modifier(self.lex.tk) {
                    if self.lex.tk == Token::Inline || self.lex.tk == Token::ForceInline {
                        self.pending_is_inline = true;
                        if self.lex.tk == Token::ForceInline {
                            self.pending_is_always_inline = true;
                        }
                    }
                    if self.lex.tk == Token::Noreturn {
                        self.pending_noreturn = true;
                    }
                    // `volatile` qualifies the declared type (C99 6.7.3);
                    // `const` is recorded out-of-band for value folding.
                    qual_bits |= self.lex_volatile_bit();
                    self.pending.base_is_const |= self.lex_is_const_qual();
                    self.next()?;
                } else {
                    break;
                }
            }
            if let Some(inner) = atomic_base {
                bt = inner;
            } else if self.lex.tk == Token::Typeof {
                // `typeof` / `__typeof__` (C23 6.7.2.5, long a GCC
                // extension) names the type of a parenthesized type-name or
                // unevaluated expression. The block-scope declaration path
                // (parse_decl_base_type) already routes through the same
                // helper; handle it identically at file scope.
                bt = self.parse_typeof_specifier()?;
            } else if let Some(scalar) = self.parse_scalar_base_specifier(&m)? {
                bt = scalar;
            } else if self.lex.tk == Token::Enum {
                bt = self.parse_enum_decl()?;
                base_is_enum = true;
            } else if self.lex.tk == Token::Struct || self.lex.tk == Token::Union {
                // Aggregate (struct or union) declaration. Three
                // shapes:
                //   <kw> Name { ... };           -- definition only
                //   <kw> Name;                   -- forward declaration
                //   <kw> Name *p;                -- type use, declarators follow
                //   typedef <kw> Name {...} Name; -- definition + typedef alias
                bt = self.parse_aggregate_base_type()?;
            } else if self.is_lex_int128_spelling() {
                // GCC `__int128` / `__uint128_t` at file scope: a 16-byte
                // integer type, modeled as a 16-byte aggregate.
                self.next()?;
                bt = self.builtin_int128_tag();
            } else if self.is_lex_va_list_spelling() {
                // GCC `__builtin_va_list` at file scope: the target's
                // `va_list` representation, usable with no header.
                self.next()?;
                bt = self.builtin_va_list_tag();
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
                    self.pending.base_is_function_type =
                        self.symbols[self.lex.curr_id_idx].is_function_type;
                    // A function-pointer typedef records the pointed-to
                    // function's prototype (`params` + `is_variadic`).
                    // Carry it to the bound declarator so an indirect
                    // call through the variable narrows each argument to
                    // its declared parameter type and splits fixed vs
                    // variadic arguments per the host variadic ABI.
                    self.pending.typedef_fn_proto = Some((
                        self.symbols[self.lex.curr_id_idx].params.len(),
                        self.symbols[self.lex.curr_id_idx].is_variadic,
                    ));
                    self.pending.fn_ptr_param_types =
                        Some(self.symbols[self.lex.curr_id_idx].params.clone());
                }
                // C99 6.7.7 paragraph 3: a typedef whose alias is
                // an array contributes its dimension to the
                // bound declarator.
                let typedef_array = self.symbols[self.lex.curr_id_idx].array_size;
                if typedef_array != 0 {
                    self.pending.typedef_base_array_size = typedef_array;
                    self.pending.typedef_base_array_dims =
                        self.symbols[self.lex.curr_id_idx].array_dims.clone();
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
            // x`, etc. The base type is already chosen; a trailing
            // `volatile` still qualifies it (C99 6.7.3).
            while is_decl_modifier(self.lex.tk) {
                if self.lex.tk == Token::Attribute {
                    self.skip_attribute_specifiers()?;
                    continue;
                }
                qual_bits |= self.lex_volatile_bit();
                self.pending.base_is_const |= self.lex_is_const_qual();
                self.next()?;
            }
            // `__attribute__((vector_size(N)))` rebuilds the base type into a
            // GCC vector of N bytes (C extension) before qualifiers apply.
            if self.pending.attr_vector_size > 0 {
                let n = core::mem::take(&mut self.pending.attr_vector_size);
                bt = self.make_vector_type(bt, n);
            }

            // C99 6.7.1: declaration specifiers may appear in any order, so a
            // storage-class specifier, type qualifier, or function specifier
            // may trail the type specifier (`INTN STATIC f (...)`,
            // `int const x`). Consume any that follow the base type before the
            // declarator; a following `*` or identifier ends the run.
            loop {
                if self.lex.tk == Token::Static {
                    static_seen = true;
                    self.next()?;
                } else if self.lex.tk == Token::Extern {
                    extern_seen = true;
                    self.next()?;
                } else if self.lex.tk == Token::ThreadLocal {
                    thread_local = true;
                    self.next()?;
                } else if self.lex.tk == Token::Inline || self.lex.tk == Token::ForceInline {
                    self.pending_is_inline = true;
                    if self.lex.tk == Token::ForceInline {
                        self.pending_is_always_inline = true;
                    }
                    self.next()?;
                } else if self.lex.tk == Token::Noreturn {
                    self.pending_noreturn = true;
                    self.next()?;
                } else if self.lex.tk == Token::TypeQual {
                    qual_bits |= self.lex_volatile_bit();
                    self.pending.base_is_const |= self.lex_is_const_qual();
                    self.next()?;
                } else if self.lex.tk == Token::Attribute
                    || (self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'['))
                {
                    self.skip_attribute_specifiers()?;
                } else {
                    break;
                }
            }
            bt |= qual_bits;

            // A function-pointer typedef base type contributes its lineage
            // to every declarator in the list (`fn_t a, b;`). The
            // per-declarator symbol creation consumes these pending fields,
            // so capture them and re-seed each iteration; otherwise only the
            // first declarator keeps the lineage and a call through a later
            // one defaults its result type to int.
            let base_fn_ptr_indirection = self.pending.fn_ptr_indirection;
            let base_is_function_type = self.pending.base_is_function_type;
            let base_typedef_fn_proto = self.pending.typedef_fn_proto;
            let base_fn_ptr_param_types = self.pending.fn_ptr_param_types.clone();
            while self.lex.tk != ';' && self.lex.tk != '}' {
                self.pending.fn_ptr_indirection = base_fn_ptr_indirection;
                self.pending.base_is_function_type = base_is_function_type;
                self.pending.typedef_fn_proto = base_typedef_fn_proto;
                self.pending.fn_ptr_param_types = base_fn_ptr_param_types.clone();
                // The declarator's own line -- the name and its parameter
                // list -- for diagnostics that would otherwise point at the
                // function body's opening brace parsed further below.
                let signature_line = self.lex.line;
                let (id_idx, mut ty, mut array_size) = self.parse_declarator(bt)?;
                // TODO: file-scope declarator `asm("name")` -- both the
                // linkage-name rename and the global register variable.
                if self.lex.tk == Token::Asm {
                    return Err(self.compile_err("declarator `asm` is not supported at file scope"));
                }
                // `__declspec(dllexport)` on the declarator exports the name,
                // the equivalent of `#pragma export(name)`. resolve_exports
                // validates the name resolves to a defined function.
                if self.pending.attr_dllexport {
                    self.pending.attr_dllexport = false;
                    let name = self.symbols[id_idx].name.clone();
                    if !self.pending_exports.contains(&name) {
                        self.pending_exports.push(name);
                    }
                }
                // A declarator may carry a trailing attribute before the
                // terminator (`name(args) __attribute__((...));`, an
                // initializer, a comma, or a function body's `{`).
                self.skip_attribute_specifiers()?;
                // `typedef T name __attribute__((vector_size(N)))` (and the
                // object form) binds the attribute to the declarator, not the
                // base type, so it lands here rather than at the base-type
                // sites. The leading form already consumed it, leaving 0.
                if self.pending.attr_vector_size > 0 {
                    let n = core::mem::take(&mut self.pending.attr_vector_size);
                    ty = self.make_vector_type(ty, n);
                }
                // Capture per this declarator before any nested parse can
                // overwrite it (a later parameter of function type would
                // re-set it). A bare function-type declarator is a function
                // declaration; the routing below runs after the typedef
                // branch so only an object/function declaration is affected.
                let bare_function_type = self.pending.bare_function_type_declarator;
                self.pending.bare_function_type_declarator = false;
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
                // A fixed dimension (`> 0`) sizes the object; a deferred array
                // typedef (`typedef T X[]`, carried as `-1`) makes the object
                // a deferred array whose size the initializer fixes.
                if typedef_dim != 0
                    && array_size == 0
                    && self.pending.declarator_leading_ptr_count == 0
                {
                    array_size = typedef_dim;
                    self.apply_typedef_array_dims(id_idx);
                }
                self.ty = ty;
                let prior_array_size = self.symbols[id_idx].array_size;
                self.symbols[id_idx].array_size = array_size;
                // A `const`-qualified plain integer scalar folds its value
                // in later constant expressions (read back from `.data`).
                self.symbols[id_idx].is_const_qualified = self.pending.base_is_const
                    && array_size == 0
                    && super::types::is_integer_scalar_ty(ty);
                // A `const`-element array (`static const T x[]`, sized or
                // deferred: `array_size` is `> 0` or `-1` here, the
                // initializer fixes a deferred count). Its elements and
                // their members cannot be written (C99 6.7.3), so a
                // relocation the initializer planted in the storage holds
                // for the object's lifetime. Scalars (`array_size == 0`)
                // stay excluded: a `const char *p` has a const pointee but
                // a writable object, so its stored address is not fixed.
                self.symbols[id_idx].storage_is_const =
                    self.pending.base_is_const && array_size != 0;
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
                let fnptr_proto = self.pending.typedef_fn_proto.take();
                let fnptr_param_types = self.pending.fn_ptr_param_types.take();
                // `fn_ptr_param_types` is the pointee signature of a
                // fn-pointer typedef used as this declarator's type. It
                // describes a fn-pointer OBJECT (`cb x;` -- a callback
                // variable an indirect call reads its parameter shape
                // from). A declarator that is itself a function whose
                // return type is that typedef (`cb f(args)`) has its own
                // parameter list, installed below; a following `(` marks
                // it, so the return type's pointee params must not stand
                // in as the function's own.
                if self.lex.tk != '(' {
                    if let Some(types) = fnptr_param_types {
                        self.symbols[id_idx].params = types;
                        self.symbols[id_idx].is_variadic = matches!(fnptr_proto, Some((_, true)));
                    } else if let Some((proto_fixed, true)) = fnptr_proto {
                        self.symbols[id_idx].params = alloc::vec![0i64; proto_fixed];
                        self.symbols[id_idx].is_variadic = true;
                    }
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
                let mut preconsumed_params = self.pending.fn_params.take();

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
                    let (typedef_ty, typedef_fpi, typedef_params, typedef_is_fn_type) =
                        if self.lex.tk == '(' && preconsumed_params.is_none() {
                            self.next()?; // consume `(`
                            let pp = self.parse_function_params()?;
                            for &p in &pp.indices {
                                Self::restore_shadowed_symbol(&mut self.symbols[p]);
                            }
                            // `typedef RET NAME(args);` -- a function TYPE.
                            // The type is pre-decayed to a function pointer
                            // (`RET` + one pointer level); the flag lets a
                            // later `NAME *p` declarator absorb the first `*`.
                            let fty = ty + Ty::Ptr as i64;
                            (fty, 1i64, Some(pp), true)
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
                            (ty, fn_ptr_indirection, Some(pp), false)
                        } else {
                            (ty, fn_ptr_indirection, None, false)
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
                    self.symbols[id_idx].is_enum_typedef = base_is_enum;
                    self.symbols[id_idx].is_function_type = typedef_is_fn_type;
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
                        // captured the pointee signature's prototype.
                        // Record the parameter types (so a fn-pointer
                        // variable declared through the typedef narrows
                        // each argument to its declared type) and the
                        // variadic-ness.
                        self.symbols[id_idx].params = self
                            .pending
                            .fn_ptr_param_types
                            .take()
                            .unwrap_or_else(|| alloc::vec![0i64; proto_fixed]);
                        self.symbols[id_idx].is_variadic = proto_variadic;
                    }
                    self.accept(',')?;
                    continue;
                }

                // C99 6.9.1: an identifier declared with a bare function type
                // (a function-TYPE typedef used with no pointer) is a function
                // declaration, not an object. The base type was pre-decayed to
                // a function pointer; undo that level and route through the
                // function path with the typedef's prototype, so a following
                // definition of the same name merges as a redeclaration rather
                // than colliding as a duplicate global.
                if bare_function_type && preconsumed_params.is_none() && self.lex.tk != '(' {
                    ty -= Ty::Ptr as i64;
                    let types = self.pending.fn_ptr_param_types.take().unwrap_or_default();
                    let is_variadic = self
                        .pending
                        .typedef_fn_proto
                        .take()
                        .map(|(_, variadic)| variadic)
                        .unwrap_or(false);
                    preconsumed_params = Some(super::function::ParsedParams {
                        indices: alloc::vec::Vec::new(),
                        types,
                        is_variadic,
                    });
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
                // An explicit return type replaces the implicit-`int`
                // default (Sys binding without a prior prototype).
                self.symbols[id_idx].implicit_return_int = false;

                if self.lex.tk == '(' || preconsumed_params.is_some() {
                    if !was_sys {
                        self.symbols[id_idx].class = Token::Fun as i64;
                        if self.symbols[id_idx].decl_line == 0 {
                            self.symbols[id_idx].decl_line = self.lex.line;
                            self.symbols[id_idx].decl_in_main_source = self.in_main_source();
                        }
                        // C99 6.2.2 / 6.7.4p7 linkage, recomputed from the
                        // facts accumulated across every declaration of this
                        // name. `static` is internal and sticky. A function
                        // all of whose declarations are `inline` without
                        // `extern` provides no external definition in this
                        // unit, so it takes internal linkage (the out-of-line
                        // copy stays private; the external definition, when
                        // the program needs one, comes from a unit that
                        // declares it `extern inline` or non-inline). A single
                        // non-inline or `extern` declaration makes it external.
                        if static_seen {
                            self.symbols[id_idx].saw_static_decl = true;
                        }
                        if !self.pending_is_inline {
                            self.symbols[id_idx].saw_noninline_decl = true;
                        }
                        // `static` is internal; an all-`inline`, never-`extern`
                        // function is inline-only (also internal); anything
                        // with a non-inline or `extern` declaration is external.
                        let sym = &mut self.symbols[id_idx];
                        let internal = sym.saw_static_decl
                            || (!sym.saw_noninline_decl && !extern_seen && !sym.is_extern_decl);
                        sym.linkage = if internal {
                            crate::c5::symbol::Linkage::Internal
                        } else {
                            crate::c5::symbol::Linkage::External
                        };
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
                    // A function declarator may carry a trailing attribute
                    // before the prototype's `;` or the body's `{`
                    // (`RET name(args) __attribute__((noreturn));`).
                    self.skip_attribute_specifiers()?;

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
                        self.accept(',')?;
                        continue;
                    }

                    if was_sys {
                        return Err(self.compile_err_at(
                            signature_line,
                            format!(
                                "cannot give a body to predefined library function `{}` \
                                 (the per-target header's `#pragma binding` provides the \
                                 implementation -- use a prototype only)",
                                self.symbols[id_idx].name
                            ),
                        ));
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
                        let mut qual_bits: i64 = 0;
                        while self.lex.tk == Token::FuncSpec
                            || self.lex.tk == Token::Static
                            || self.lex.tk == Token::Extern
                            || self.lex.tk == Token::TypeQual
                        {
                            qual_bits |= self.lex_volatile_bit();
                            self.next()?;
                            saw_specifier = true;
                        }
                        let base = if self.lex_is_type_start() {
                            self.parse_decl_base_type()?
                        } else if saw_specifier || self.lex.tk == Token::Id {
                            Ty::Int as i64
                        } else {
                            break;
                        } | qual_bits;
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
                            self.accept(',')?;
                        }
                        self.accept(';')?;
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
                    self.committed_loc_offs = 0;
                    self.max_loc_offs = 0;
                    self.multi_cell_temps.clear();
                    self.labels.clear();
                    self.unresolved_gotos.clear();
                    self.uses_alloca_in_current_fn = false;
                    self.func_vla_decls = 0;
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

                    // `__attribute__((constructor))` / `((destructor))` on
                    // this definition: record it so the emit path lowers it
                    // into `.init_array` / `.fini_array` and the VM / JIT run
                    // it around `main`. The pending flags were set by the
                    // leading or trailing attribute specifier.
                    if self.pending.attr_constructor || self.pending.attr_destructor {
                        let is_destructor = self.pending.attr_destructor;
                        self.init_funcs.push(crate::c5::program::InitFunc {
                            name: self.symbols[id_idx].name.clone(),
                            ent_pc,
                            priority: self.pending.attr_init_priority,
                            is_destructor,
                        });
                        self.pending.attr_constructor = false;
                        self.pending.attr_destructor = false;
                        self.pending.attr_init_priority = None;
                    }

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
                        let local_val = self.reserve_slots(slots);
                        if slots > 1 {
                            self.multi_cell_temps.push((local_val, slots));
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
                        let pty = self.symbols[idx].type_ & !(UNSIGNED_BIT | VOLATILE_BIT);
                        if pty != Ty::Float as i64 {
                            continue;
                        }
                        let param_val = self.symbols[idx].val;
                        let local_val = self.reserve_slots(1);
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
                    self.stmt_expr_arena_ranges.clear();
                    // C99 6.2.1: a tag declared in a function body has
                    // block scope. Push a tag scope so a struct / union /
                    // enum defined at the body top level is local to this
                    // function -- two functions defining the same tag do
                    // not collide, and a body-scope tag shadows a
                    // file-scope one. Nested blocks push their own scopes
                    // through parse_block_stmt.
                    self.tag_scopes.push(alloc::vec::Vec::new());
                    // The function body's top-level block scope for
                    // `__attribute__((cleanup))` variables; cleaned on
                    // fall-through (below) and on every `return`.
                    self.cleanup_scopes.push(alloc::vec::Vec::new());
                    while self.lex.tk != '}' {
                        // C23 6.7.13 / 6.8: an attribute-specifier-
                        // sequence may lead either a declaration or a
                        // statement at the function-body top level.
                        // Consume it, then dispatch on the following
                        // token.
                        let mut leading_maybe_unused = false;
                        if self.lex.tk == Token::Attribute
                            || (self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'['))
                        {
                            self.pending.attr_maybe_unused = false;
                            self.pending.attr_cleanup = None;
                            self.skip_attribute_specifiers()?;
                            leading_maybe_unused = self.pending.attr_maybe_unused;
                            if self.lex.tk == '}' {
                                break;
                            }
                        }
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
                            self.parse_function_body_local_decl(leading_maybe_unused)?;
                            let item_after = self.ast.stmts.len();
                            // Skip any statement-expression sub-statements
                            // interleaved by an initializer; they are
                            // reached through the Decl's `Expr::StmtExpr`.
                            for id in item_before..item_after {
                                if self.in_stmt_expr_range(id) {
                                    continue;
                                }
                                top_level_ids.push(id as super::super::ast::StmtId);
                            }
                            self.stmt_expr_arena_ranges
                                .retain(|&(s, _)| s < item_before);
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
                    // Fall-through / implicit return: run the body's
                    // top-level `__attribute__((cleanup))` functions in
                    // reverse declaration order before the synthetic return.
                    if self.cleanup_scopes.last().is_some_and(|s| !s.is_empty()) {
                        let pairs: alloc::vec::Vec<(usize, usize)> = self
                            .cleanup_scopes
                            .last()
                            .unwrap()
                            .iter()
                            .rev()
                            .cloned()
                            .collect();
                        for (var_sym, fn_sym) in pairs {
                            let before = self.ast.stmts.len();
                            self.push_cleanup_call(var_sym, fn_sym);
                            for id in before..self.ast.stmts.len() {
                                top_level_ids.push(id as super::super::ast::StmtId);
                            }
                        }
                    }
                    self.cleanup_scopes.pop();
                    self.tag_scopes.pop();
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
                    // A naked function has no synthetic return value: its
                    // inline-asm body is the entire function and returns on its
                    // own (e.g. `iretq`), so emit no accumulator zeroing.
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

                    // C99 6.9.1p12: warn when a value-returning function
                    // may reach its closing brace without a `return value;`.
                    // Run before `ast_finish_function` moves the body AST.
                    self.check_non_void_fall_off();
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
                    // Record declared multi-cell locals (aggregates and
                    // multi-cell scalars) for slot coalescing. A declared
                    // local at frame slot `fp_slot` (most-negative cell)
                    // occupying `cells` 8-byte cells covers
                    // `fp_slot ..= fp_slot + cells - 1`; the interior cells
                    // carry no direct slot reference, so the pass must
                    // reserve them. Computed from the per-function variable
                    // list assembled just above (`local_storage_slots`
                    // mirrors the parser's reservation). Patches the
                    // `FinishedFunction` pushed by `ast_finish_function`.
                    // A struct-by-value parameter keeps its body-visible copy
                    // in a negative slot too (C99 6.5.2.2 + the host ABI), so
                    // `fp_slot < 0` -- not `!is_parameter` -- selects every
                    // local that needs its interior cells reserved.
                    let mut multi_cell: Vec<(i64, i64)> = Vec::new();
                    for v in &self.variables {
                        if v.function_bc_pc == ent_pc as u64 && v.fp_slot < 0 {
                            let cells = self.local_storage_slots(v.type_tag, v.array_size as i64);
                            if cells > 1 {
                                multi_cell.push((v.fp_slot, cells));
                            }
                        }
                    }
                    // Multi-cell temporaries the parser allocated without a
                    // symbol (struct call results, parameter copies, compound
                    // literals); these never appear in the variable list.
                    multi_cell.extend_from_slice(&self.multi_cell_temps);
                    if let Some(ff) = self.finished_functions.last_mut() {
                        ff.multi_cell_slots = multi_cell;
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
                            || sym.maybe_unused
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
                    // C11 6.7.5: a requested alignment is honored on
                    // file-scope objects -- the object writer aligns the
                    // section to `Program::data_align` and the object's
                    // offset within it via `align_data_to`. The attribute
                    // requires a power of two (C11 6.7.5p3); anything past
                    // the supported maximum is a diagnostic, never a silent
                    // drop.
                    let req_align = core::mem::take(&mut self.pending.attr_align);
                    if req_align > 8 && !(req_align as usize).is_power_of_two() {
                        return Err(self.compile_err(format!(
                            "requested alignment {req_align} is not a power of two"
                        )));
                    }
                    if req_align > super::MAX_STATIC_ALIGN as i64 {
                        return Err(self.compile_err(format!(
                            "requested alignment {req_align} exceeds the supported maximum of {}",
                            super::MAX_STATIC_ALIGN
                        )));
                    }
                    let decl_align: usize = if req_align > 8 {
                        if thread_local {
                            return Err(self.compile_err(
                                "alignment above 8 is not supported for `_Thread_local` objects",
                            ));
                        }
                        self.data_align = self.data_align.max(req_align as usize);
                        req_align as usize
                    } else {
                        8
                    };
                    let was_extern_only_decl =
                        extern_seen && self.lex.tk != Token::Assign && array_size != -1;
                    // `extern struct S s;` whose `struct S` has no fixed
                    // size at the declaration cannot reserve storage: an
                    // incomplete struct (size unknown), or one with a
                    // flexible array member (C99 6.7.2.1 -- the element
                    // count comes from the defining initializer). C99 6.9.2
                    // makes it a pure declaration anyway. Record an
                    // undefined external reference; the defining
                    // declaration allocates the bytes. Without this the
                    // permissive single-TU fallback below reserves a
                    // wrong-sized slot, and either the next global overlaps
                    // it (fixed part too small) or the definition allocating
                    // fresh strands references emitted against the slot.
                    if was_extern_only_decl
                        && is_struct_ty(ty)
                        && struct_ptr_depth(ty) == 0
                        && (self.structs[struct_id_of(ty)].fields.is_empty()
                            || self.structs[struct_id_of(ty)]
                                .fields
                                .iter()
                                .any(|f| f.array_size < 0))
                    {
                        self.symbols[id_idx].is_extern_decl = true;
                        self.symbols[id_idx].defined_here = false;
                        self.symbols[id_idx].type_ = ty;
                        self.accept(',')?;
                        continue;
                    }
                    if was_extern_only_decl {
                        // C99 6.2.2p4 + 6.9.2p2: `extern T x;` after a
                        // prior file-scope definition (tentative or
                        // initialized) redeclares the same object; the
                        // definition stands.
                        if !self.symbols[id_idx].defined_here {
                            self.symbols[id_idx].is_extern_decl = true;
                        }
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
                                // C99 6.2.2p4: after a prior definition,
                                // `extern T x[];` is a redeclaration of
                                // the same object -- the definition and
                                // its dimension stand.
                                if self.symbols[id_idx].defined_here {
                                    self.symbols[id_idx].array_size = prior_array_size;
                                } else {
                                    self.symbols[id_idx].is_extern_decl = true;
                                    self.symbols[id_idx].defined_here = false;
                                }
                                self.accept(',')?;
                                continue;
                            }
                            // C99 6.9.2: a file-scope `T x[];` with no
                            // `extern` and no initializer is a tentative
                            // definition. An array type left incomplete at
                            // the end of the unit is completed to one
                            // element, so reserve a single zero-filled
                            // element here.
                            self.symbols[id_idx].array_size = 1;
                            if let Some(first) = self.symbols[id_idx].array_dims.first_mut() {
                                *first = 1;
                            }
                            let elem = self.size_of_type(ty) as i64;
                            let aligned = ((elem + 7) / 8) * 8;
                            if decl_align > 8 {
                                self.align_data_to(decl_align);
                            } else if self.size_of_type(ty) > 1 {
                                self.align_data_to_8();
                            }
                            let off = self.data.len() as i64;
                            self.symbols[id_idx].val = off;
                            self.symbols[id_idx].reserved_data_bytes = aligned;
                            for _ in 0..aligned {
                                self.data.push(0);
                            }
                            self.symbols[id_idx].defined_here = true;
                            self.accept(',')?;
                            continue;
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
                            // Elements below the outer (deferred) dimension:
                            // for a 2D struct array `T xs[][M]` each top-level
                            // brace is a row of `inner_dim` structs. 1 for a
                            // plain `T xs[]`.
                            let inner_dim: i64 = self.symbols[id_idx]
                                .array_dims
                                .get(1..)
                                .map(|s| s.iter().product::<i64>())
                                .unwrap_or(1)
                                .max(1);
                            // C99 6.7.8p20 brace elision: when no element
                            // carries its own braces, the flat value list
                            // fills consecutive struct elements, each
                            // consuming the struct's scalar slot count.
                            let groups = self.lex.count_top_level_groups_in_array();
                            let count = if groups > 0 {
                                // Braced elements: one `{ ... }` (or `[N] = {
                                // ... }`) per element. A `[N]` designator may
                                // raise the size past the positional count
                                // (C99 6.7.8p22), so peek the designators.
                                self.designated_array_count(groups as i64)?
                            } else {
                                // Brace-elided: the flat value list fills
                                // consecutive elements, each consuming the
                                // struct's scalar slot count.
                                let items = self.lex.count_top_level_items_in_array();
                                let slots = self.struct_flat_init_slots(sid).max(1);
                                let positional = items.div_ceil(slots) as i64;
                                // A `[N].field = v` designated element list (no
                                // braces, one element per item) raises the size
                                // to the highest designated index + 1 (C99
                                // 6.7.8p22), which the positional count misses.
                                if self.array_first_element_is_designator() {
                                    self.designated_array_count(positional)?
                                } else {
                                    positional
                                }
                            };
                            self.next()?;
                            // C99 6.9.2: a prior tentative definition already
                            // reserved storage; reuse it so references emitted
                            // before this definition -- which baked in the
                            // tentative's offset -- observe the initialized
                            // object, not the tentative's separate zero copy.
                            // Reuse only when the initializer fits the reserved
                            // bytes: a deferred-size tentative (`T x[];`)
                            // reserves one element, so a larger initializer must
                            // allocate fresh rather than overrun later globals.
                            let needed = count * inner_dim * elem_size as i64;
                            let off = if was_tentative_glo
                                && needed <= self.symbols[id_idx].reserved_data_bytes
                            {
                                self.symbols[id_idx].val
                            } else {
                                self.align_data_to(decl_align);
                                let fresh = self.data.len() as i64;
                                self.symbols[id_idx].reserved_data_bytes = needed;
                                for _ in 0..needed {
                                    self.data.push(0);
                                }
                                fresh
                            };
                            self.symbols[id_idx].val = off;
                            // 2D struct array `T xs[][M] = { { {...}, ... }, ...
                            // }`: each top-level brace is a row of `inner_dim`
                            // structs. The 1D loop below fills one struct per
                            // top-level brace, so a row would be misread; walk
                            // the rows here instead. (Fully-braced rows, which
                            // is how nested aggregates are written.)
                            if inner_dim > 1 {
                                let mut row: i64 = 0;
                                while self.lex.tk != '}' {
                                    if self.lex.tk != '{' {
                                        return Err(self.compile_err(
                                            "row of a 2D struct array must be brace-enclosed",
                                        ));
                                    }
                                    self.next()?; // row `{`
                                    let mut j: i64 = 0;
                                    while self.lex.tk != '}' {
                                        if j >= inner_dim {
                                            return Err(self.compile_err(
                                                "too many initializers in struct-array row",
                                            ));
                                        }
                                        let here = off + (row * inner_dim + j) * elem_size as i64;
                                        self.skip_opt_compound_literal_cast()?;
                                        let cl_parens = core::mem::take(
                                            &mut self.pending.compound_lit_close_parens,
                                        );
                                        if self.lex.tk == '{' {
                                            self.collect_struct_initializer(sid, here)?;
                                        } else {
                                            self.fill_struct_fields(sid, here, false)?;
                                        }
                                        for _ in 0..cl_parens {
                                            self.accept(')')?;
                                        }
                                        j += 1;
                                        self.accept(',')?;
                                    }
                                    self.next()?; // row `}`
                                    row += 1;
                                    self.accept(',')?;
                                }
                                self.next()?; // outer `}`
                                let total = count * inner_dim;
                                self.symbols[id_idx].array_size = total;
                                self.symbols[id_idx].is_zero_len_array = total == 0;
                                if let Some(first) = self.symbols[id_idx].array_dims.first_mut()
                                    && *first == 0
                                {
                                    *first = count;
                                }
                                while !self.data.len().is_multiple_of(8) {
                                    self.data.push(0);
                                }
                                self.symbols[id_idx].has_initializer = true;
                                self.symbols[id_idx].defined_here = true;
                                self.accept(',')?;
                                continue;
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
                                    if self.lex.tk == Token::Dot || self.lex.tk == Token::Brak {
                                        // C99 6.7.8p7 compound designator
                                        // `[N].field... = v`: override one field
                                        // of a (zero-initialized) element.
                                        let here = off + idx * elem_size as i64;
                                        self.fill_element_field_designator(sid, ty, here)?;
                                        i = idx + 1;
                                        self.accept(',')?;
                                        continue;
                                    }
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
                                // A struct-array element may be written as a
                                // compound literal `(T){ ... }` naming the
                                // element type (C99 6.5.2.5); drop the
                                // redundant cast and fill the brace list.
                                self.skip_opt_compound_literal_cast()?;
                                let cl_parens =
                                    core::mem::take(&mut self.pending.compound_lit_close_parens);
                                if self.lex.tk == '{' {
                                    self.collect_struct_initializer(sid, here)?;
                                } else {
                                    // Brace-elided element: fill the
                                    // struct's fields from the flat list
                                    // until it is full, leaving the rest
                                    // for the next element.
                                    self.fill_struct_fields(sid, here, false)?;
                                }
                                for _ in 0..cl_parens {
                                    self.accept(')')?;
                                }
                                i += 1;
                                self.accept(',')?;
                            }
                            self.next()?; // consume `}`
                            self.symbols[id_idx].array_size = count;
                            // `struct T xs[] = {}` resolves to zero elements.
                            // Keep the array-ness (the `array_size == 0`
                            // scalar encoding would otherwise lose it).
                            self.symbols[id_idx].is_zero_len_array = count == 0;
                            // Pad data to 8-byte alignment so the next
                            // global doesn't land on an odd offset.
                            while !self.data.len().is_multiple_of(8) {
                                self.data.push(0);
                            }
                            self.symbols[id_idx].has_initializer = true;
                            self.symbols[id_idx].defined_here = true;
                            self.accept(',')?;
                            continue;
                        }
                        self.pending.init_inner_dims = self.inner_dims_of(id_idx);
                        let elements = self.collect_array_initializer(ty)?;
                        let final_size = elements.len() as i64;
                        self.symbols[id_idx].array_size = final_size;
                        // `T xs[] = {}` resolves to zero elements; keep the
                        // array-ness that the scalar `array_size == 0`
                        // encoding would otherwise drop.
                        self.symbols[id_idx].is_zero_len_array = final_size == 0;
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
                        // C99 6.9.2: a prior tentative definition already
                        // reserved storage; reuse it so references emitted
                        // before this definition observe the initialized object,
                        // not the tentative's separate zero copy. Reuse only
                        // when the initializer fits the reserved bytes: a
                        // deferred-size tentative (`T x[];`) reserves one
                        // element, so a larger initializer must allocate fresh
                        // rather than overrun later globals.
                        let off = if was_tentative_glo
                            && aligned <= self.symbols[id_idx].reserved_data_bytes
                        {
                            self.symbols[id_idx].val
                        } else {
                            if decl_align > 8 {
                                self.align_data_to(decl_align);
                            } else if self.size_of_type(ty) > 1 {
                                self.align_data_to_8();
                            }
                            let fresh = self.data.len() as i64;
                            self.symbols[id_idx].reserved_data_bytes = aligned;
                            for _ in 0..aligned {
                                self.data.push(0);
                            }
                            fresh
                        };
                        self.symbols[id_idx].val = off;
                        self.write_array_init_into_data(off, ty, &elements);
                        self.symbols[id_idx].has_initializer = true;
                        self.symbols[id_idx].defined_here = true;
                    } else {
                        let mut bytes = if array_size > 0 {
                            let total = (self.size_of_type(ty) as i64) * array_size;
                            ((total + 7) / 8) * 8
                        } else {
                            self.slots_of_type(ty) * 8
                        };
                        // A flexible array member initialized via `.<fam> =
                        // {...}` needs its element bytes reserved now, before
                        // the field fill appends string literals into that
                        // trailing region (they would collide with the
                        // member's data). Only the defining `= {` form
                        // reserves extra; a bare / tentative declaration keeps
                        // the fixed size.
                        if is_struct_ty(ty)
                            && struct_ptr_depth(ty) == 0
                            && self.lex.tk == Token::Assign
                        {
                            let sid = struct_id_of(ty);
                            let fam_elem_ty = self.structs[sid]
                                .fields
                                .iter()
                                .find(|f| f.array_size < 0)
                                .map(|f| f.ty);
                            if let Some(elem_ty) = fam_elem_ty {
                                let elem = self.size_of_type(elem_ty) as i64;
                                let snap = self.lex.snapshot();
                                self.next()?; // `=`
                                let count = self.flexible_array_init_count(sid)? as i64;
                                self.lex.restore(snap);
                                bytes += count * elem;
                                bytes = ((bytes + 7) / 8) * 8;
                            }
                        }
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
                        // `extern _Thread_local T x;` (no initializer) is a
                        // pure reference, not a definition: it must not
                        // reserve TLS storage. The defining unit owns the
                        // slot; the access resolves by symbol against the
                        // merged TLS block at link time. A local slot here
                        // would add a phantom per-unit copy (one TLS block
                        // per object), breaking the shared-state semantics
                        // and the multi-object link.
                        let extern_tls_ref = thread_local && was_extern_only_decl;
                        let var_offset = if extern_tls_ref {
                            self.symbols[id_idx].is_extern_decl = true;
                            self.symbols[id_idx].defined_here = false;
                            0
                        } else if reuse_prior_storage {
                            self.symbols[id_idx].val
                        } else if thread_local {
                            let off = self.tls_data.len() as i64;
                            self.symbols[id_idx].val = off;
                            for _ in 0..bytes {
                                self.tls_data.push(0);
                            }
                            off
                        } else {
                            if decl_align > 8 {
                                self.align_data_to(decl_align);
                            } else if self.size_of_type(ty) > 1 {
                                self.align_data_to_8();
                            }
                            let off = self.data.len() as i64;
                            self.symbols[id_idx].val = off;
                            self.symbols[id_idx].reserved_data_bytes = bytes;
                            for _ in 0..bytes {
                                self.data.push(0);
                            }
                            off
                        };
                        if !extern_tls_ref {
                            self.symbols[id_idx].defined_here = true;
                        }

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
                            // A file-scope aggregate may be initialised by a
                            // compound literal naming its own type (C99
                            // 6.5.2.5): `static T g = (T){ ... };`. Drop the
                            // redundant `(T)` so the brace dispatch below sees
                            // `{ ... }`. A scalar `(int){5}` falls through to
                            // parse_global_initializer's single-value path.
                            self.skip_opt_compound_literal_cast()?;
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
                                // A multi-dimensional array (`T xs[A][B]`) has an
                                // element that is itself an array of structs; each
                                // top-level group spans the inner dimensions.
                                let inner_dims = self.inner_dims_of(id_idx);
                                let inner_product: i64 = inner_dims.iter().product::<i64>().max(1);
                                let group_stride = elem_size as i64 * inner_product;
                                let group_count = array_size / inner_product;
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
                                    // jumps the cursor and writes the brace list
                                    // there. The GCC range form `[lo ... hi] = v`
                                    // writes the same value to every element in
                                    // [lo, hi].
                                    let mut range_hi: Option<i64> = None;
                                    if self.lex.tk == Token::Brak {
                                        self.next()?;
                                        let desig = self.parse_constant_int()?;
                                        if self.lex.tk == Token::Ellipsis {
                                            self.next()?;
                                            let hi = self.parse_constant_int()?;
                                            if hi < desig || hi >= array_size {
                                                return Err(self.compile_err(format!(
                                                    "array designator range [{desig} ... {hi}] out of bounds [0, {array_size})"
                                                )));
                                            }
                                            range_hi = Some(hi);
                                        }
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
                                        if self.lex.tk == Token::Brak {
                                            // C99 6.7.8p6 multi-dimensional element
                                            // designator `[i][j]... = { ... }`:
                                            // index every dimension down to a
                                            // single element. Each subscript scales
                                            // by the product of the dimensions below
                                            // it (the outer `desig` by
                                            // `inner_product`).
                                            if range_hi.is_some() {
                                                return Err(self.compile_err(
                                                    "`[lo ... hi]` range cannot combine with a multi-dimensional designator",
                                                ));
                                            }
                                            if desig >= group_count {
                                                return Err(self.compile_err(format!(
                                                    "array designator index {desig} out of bounds [0, {group_count})"
                                                )));
                                            }
                                            let mut elem = desig * inner_product;
                                            let mut d = 0usize;
                                            while self.lex.tk == Token::Brak {
                                                self.next()?; // `[`
                                                let n = self.parse_constant_int()?;
                                                if self.lex.tk != ']' {
                                                    return Err(self.compile_err(
                                                        "`]` expected after array designator index",
                                                    ));
                                                }
                                                self.next()?; // `]`
                                                if d >= inner_dims.len()
                                                    || n < 0
                                                    || n >= inner_dims[d]
                                                {
                                                    return Err(self.compile_err(format!(
                                                        "array designator index {n} out of bounds"
                                                    )));
                                                }
                                                let scale: i64 = inner_dims
                                                    .iter()
                                                    .skip(d + 1)
                                                    .product::<i64>()
                                                    .max(1);
                                                elem += n * scale;
                                                d += 1;
                                            }
                                            if d != inner_dims.len() {
                                                return Err(self.compile_err(
                                                    "multi-dimensional `[i][j]` designator must index every dimension",
                                                ));
                                            }
                                            let here = var_offset + elem * elem_size as i64;
                                            if self.lex.tk == Token::Dot {
                                                // `[i][j].field = v` field override.
                                                self.fill_element_field_designator(sid, ty, here)?;
                                            } else {
                                                if self.lex.tk != Token::Assign {
                                                    return Err(self.compile_err(
                                                        "`=` expected after `[i][j]` designator",
                                                    ));
                                                }
                                                self.next()?;
                                                self.skip_opt_compound_literal_cast()?;
                                                let cl_parens = core::mem::take(
                                                    &mut self.pending.compound_lit_close_parens,
                                                );
                                                if self.lex.tk == '{' {
                                                    self.collect_struct_initializer(sid, here)?;
                                                } else {
                                                    self.fill_struct_fields(sid, here, false)?;
                                                }
                                                for _ in 0..cl_parens {
                                                    self.accept(')')?;
                                                }
                                            }
                                            idx = desig + 1;
                                            self.accept(',')?;
                                            continue;
                                        }
                                        if self.lex.tk == Token::Dot {
                                            // C99 6.7.8p7 compound designator
                                            // `[N].field... = v`: override one
                                            // field of an already-filled element.
                                            if range_hi.is_some() {
                                                return Err(self.compile_err(
                                                    "`[lo ... hi]` range cannot combine with a `.field` sub-designator",
                                                ));
                                            }
                                            let here = var_offset + desig * group_stride;
                                            self.fill_element_field_designator(sid, ty, here)?;
                                            idx = desig + 1;
                                            self.accept(',')?;
                                            continue;
                                        }
                                        if self.lex.tk != Token::Assign {
                                            return Err(self.compile_err(
                                                "`=` expected after `[N]` designator",
                                            ));
                                        }
                                        self.next()?;
                                        idx = desig;
                                    }
                                    let last = range_hi.unwrap_or(idx);
                                    if last >= group_count {
                                        return Err(self.compile_err(format!(
                                            "too many initializers for `{}`",
                                            self.symbols[id_idx].name
                                        )));
                                    }
                                    // A range re-parses the value for each element
                                    // (from a snapshot at its start) so the value's
                                    // own relocations register at each element's
                                    // offset. The last element leaves the cursor
                                    // past the value for the next designator.
                                    let value_snap = range_hi.map(|_| self.lex.snapshot());
                                    let mut k = idx;
                                    loop {
                                        if let Some(snap) = value_snap {
                                            self.lex.restore(snap);
                                        }
                                        let here = var_offset + k * group_stride;
                                        // C99 6.7.8p20: the braces around each
                                        // struct element may be elided; a
                                        // multi-dimensional element is itself an
                                        // array of structs.
                                        // A compound-literal element `(T){...}`
                                        // naming the element type: drop the
                                        // redundant cast (a multi-dim element
                                        // is an array, never a compound
                                        // literal, so skip only the scalar
                                        // case).
                                        let cl_parens = if inner_dims.is_empty() {
                                            self.skip_opt_compound_literal_cast()?;
                                            core::mem::take(
                                                &mut self.pending.compound_lit_close_parens,
                                            )
                                        } else {
                                            0
                                        };
                                        if !inner_dims.is_empty() {
                                            self.collect_struct_array_data(
                                                sid,
                                                here,
                                                &inner_dims,
                                                elem_size as i64,
                                            )?;
                                        } else if self.lex.tk == '{' {
                                            self.collect_struct_initializer(sid, here)?;
                                        } else {
                                            self.fill_struct_fields(sid, here, false)?;
                                        }
                                        for _ in 0..cl_parens {
                                            self.accept(')')?;
                                        }
                                        if k >= last {
                                            break;
                                        }
                                        k += 1;
                                    }
                                    idx = last + 1;
                                    self.accept(',')?;
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
                self.accept(',')?;
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
        // A `__attribute__((constructor))` / `((destructor))` function
        // has no in-source call site but runs at startup / exit, so it is
        // not unused (matching gcc / clang, which never warn on it).
        let init_names: alloc::collections::BTreeSet<&str> =
            self.init_funcs.iter().map(|f| f.name.as_str()).collect();
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
                || init_names.contains(sym.name.as_str())
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
