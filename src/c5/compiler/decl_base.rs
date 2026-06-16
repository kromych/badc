//! Base-type parsing for declarations.
//!
//! C's declaration grammar separates the *base type* (`int`,
//! `const unsigned long *`, `struct Foo`, a typedef name, ...)
//! from the *declarator* (`*p[10]`, `(*fp)(int)`, ...). This
//! module owns the first half: consume zero-or-more leading
//! qualifier / sign / size / storage-class modifiers, then
//! recognise the base type keyword (`int`, `char`, `void`,
//! `float`, `double`, `enum`, `struct`, `union`) or a typedef
//! name, returning the resulting `ty`-encoded type.
//!
//! Two flavours of caller exist:
//!
//!   * Mid-stream callers ([`Compiler::parse_decl_base_type`])
//!     -- inside sizeof / cast / function-param /
//!     block-local-decl. They consume any decl-modifier they
//!     encounter; storage-class prefixes (`extern`, `static`,
//!     `typedef`, `_Thread_local`) are illegal here and would be
//!     classified upstream.
//!
//!   * The file-scope caller (`run_compile` in mod.rs) which
//!     ALSO has to accept storage-class prefixes and stash
//!     the `typedef` / `_Thread_local` flags. It reaches for the
//!     same [`IntModifiers`] accumulator + [`Compiler::try_consume_int_modifier`]
//!     primitives so the int-modifier soup ("`unsigned long long
//!     int`", "`short signed int`", `_Bool`, ...) only has one
//!     copy of the truth.

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{UNSIGNED_BIT, is_decl_modifier, struct_ty_for};

/// Accumulator for the int-modifier soup that prefixes a C base
/// type. `signed` / `unsigned` / `short` / `long` (any count) /
/// `_Bool` are tracked separately so a later dispatch can pick
/// between `Ty::Int`, `Ty::Long`, `Ty::LongLong`, `Ty::Short` etc.
/// `long_count` lets us recognise `long long`.
#[derive(Default, Debug, Clone, Copy)]
pub(super) struct IntModifiers {
    pub saw_signed: bool,
    pub saw_unsigned: bool,
    pub saw_short: bool,
    /// True when the base type spelled `_Bool`. Tracked separately
    /// because `_Bool` is a distinct C99 type, not an `int`
    /// modifier; the implicit-int path must yield `Ty::Bool`.
    pub saw_bool: bool,
    pub long_count: u8,
    /// True if any int-style modifier was observed -- drives the
    /// "implicit int" rule (`unsigned x;` becomes `unsigned int x;`).
    pub saw_int_mod: bool,
}

impl IntModifiers {
    pub fn saw_long(&self) -> bool {
        self.long_count >= 1
    }
    pub fn saw_long_long(&self) -> bool {
        self.long_count >= 2
    }

    /// Compute the base integer type tag for the `int` keyword
    /// path *and* the implicit-int (bare-modifier) path. `long
    /// long int` -> `Ty::LongLong` (always 64-bit); `long int` ->
    /// `Ty::Long` (LP64 -> 64-bit, LLP64 -> 32-bit); `short int`
    /// -> `Ty::Short`; bare `int` -> `Ty::Int`. Adds the
    /// `UNSIGNED_BIT` when `saw_unsigned` is set.
    pub fn int_base(&self) -> i64 {
        if self.saw_bool {
            // `_Bool` does not combine with any other integer
            // modifier in valid C, so it wins outright.
            return Ty::Bool as i64;
        }
        let base = if self.saw_long_long() {
            Ty::LongLong as i64
        } else if self.saw_long() {
            Ty::Long as i64
        } else if self.saw_short {
            Ty::Short as i64
        } else {
            Ty::Int as i64
        };
        if self.saw_unsigned {
            base | UNSIGNED_BIT
        } else {
            base
        }
    }

    /// Pick the `char` tag. `signed char` is always signed and
    /// `unsigned char` always unsigned; plain `char` follows the
    /// target's implementation-defined signedness
    /// ([`Target::plain_char_signed`], C99 6.2.5p15). The signedness
    /// is encoded as the presence/absence of `UNSIGNED_BIT`, which
    /// drives the load extension in `load_kind_for`.
    pub fn char_tag(&self, plain_char_signed: bool) -> i64 {
        let signed = if self.saw_signed {
            true
        } else if self.saw_unsigned {
            false
        } else {
            plain_char_signed
        };
        if signed {
            Ty::Char as i64
        } else {
            Ty::Char as i64 | UNSIGNED_BIT
        }
    }
}

impl Compiler {
    /// Consume the current token if it's one of the int modifiers
    /// (`signed`, `unsigned`, `short`, `long`, `_Bool`),
    /// recording it in `m`. Returns `true` when consumed, `false`
    /// when the token doesn't match (caller decides what to do
    /// next). Other decl modifiers (`const`, `volatile`, ...)
    /// fall through; the file-scope caller checks
    /// `is_decl_modifier` and consumes them as a no-op separately.
    pub(super) fn try_consume_int_modifier(
        &mut self,
        m: &mut IntModifiers,
    ) -> Result<bool, C5Error> {
        if self.lex.tk == Token::IntMod {
            // `_Bool` is the only keyword mapped to `IntMod`.
            m.saw_bool = true;
            m.saw_int_mod = true;
        } else if self.lex.tk == Token::Signed {
            m.saw_signed = true;
            m.saw_int_mod = true;
        } else if self.lex.tk == Token::Unsigned {
            m.saw_unsigned = true;
            m.saw_int_mod = true;
        } else if self.lex.tk == Token::Long {
            m.long_count = m.long_count.saturating_add(1);
            m.saw_int_mod = true;
        } else if self.lex.tk == Token::Short {
            m.saw_short = true;
            m.saw_int_mod = true;
        } else {
            return Ok(false);
        }
        self.next()?;
        Ok(true)
    }

    /// Parse a struct / union / typedef-name base reference --
    /// the keyword token has already been peeked, but not yet
    /// consumed. Used by both `parse_decl_base_type` and the
    /// file-scope base-type matcher in `run_compile`; both want
    /// the same "named tag or anonymous body" handling and the
    /// same anonymous-struct synthetic tag scheme.
    pub(super) fn parse_aggregate_base_type(&mut self) -> Result<i64, C5Error> {
        let is_union = self.lex.tk == Token::Union;
        let kind = if is_union { "union" } else { "struct" };
        self.next()?;
        // An attribute may sit between the keyword and the tag
        // (`struct __attribute__((packed)) name`).
        let packed = self.skip_attribute_specifiers()?;
        let name = if self.lex.tk == Token::Id {
            let n = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;
            n
        } else if self.lex.tk == '{' {
            // Anonymous: `typedef struct { ... } Foo;`. Synth a tag
            // so the inner body can register and so a typedef-side
            // declarator that follows still sees a struct type.
            format!("__anon_{kind}_{}", self.structs.len())
        } else {
            return Err(self.compile_err(format!("{kind} name or `{{` expected")));
        };
        let id = if self.lex.tk == '{' {
            let id = self.parse_aggregate_body(&name, is_union, packed)?;
            // `struct name { ... } __attribute__((packed))`: the attribute
            // follows the body. Re-pack the already-laid-out fields.
            if self.skip_attribute_specifiers()? {
                self.repack_struct(id);
            }
            id
        } else {
            // A trailing attribute on a tag use without a body
            // (`struct name __attribute__((...))`); consume it.
            self.skip_attribute_specifiers()?;
            self.find_or_forward_declare_struct(&name)
        };
        Ok(struct_ty_for(id))
    }

    /// Parse a C base type (modifiers + keyword) and return its
    /// `ty` encoding. Most callers also expect the bare-`void`
    /// side channel (`pending_base_was_void`) and the typedef
    /// fn-pointer-lineage side channel
    /// (`pending_fn_ptr_indirection`) to be (re)set; this helper
    /// sets both as appropriate.
    ///
    /// Examples of input shapes accepted:
    ///   * `int`, `unsigned int`, `signed long long`, `short`
    ///   * `char`, `signed char`, `unsigned char`
    ///   * `void`
    ///   * `float`, `double`, `long double`
    ///   * `enum [Tag] [{ ... }]` (treated as plain `int`)
    ///   * `struct Tag`, `union Tag`, `struct Tag { ... }`,
    ///     `struct { ... }` (anonymous)
    ///   * a typedef name bound earlier in the translation unit
    /// C11 6.7.2.4 atomic type specifier `_Atomic ( type-name )`. When the
    /// current token is `_Atomic` immediately followed by `(`, consume the
    /// whole specifier and return the inner type-name's type. c5 does not
    /// model atomicity, so this is the unqualified inner type plus any
    /// abstract pointer declarator inside the parentheses. Returns `None`
    /// without consuming when the current token is not this specifier form
    /// (e.g. the `_Atomic` qualifier). Shared by every base-type parser
    /// (decl base, file-scope declaration, struct field).
    pub(super) fn try_parse_atomic_type_specifier(&mut self) -> Result<Option<i64>, C5Error> {
        if self.lex.tk != Token::Atomic || !self.lex.peek_after_whitespace(b'(') {
            return Ok(None);
        }
        self.next()?; // _Atomic
        self.next()?; // (
        let mut inner = self.parse_decl_base_type()?;
        while self.lex.tk == Token::MulOp {
            self.next()?;
            inner += Ty::Ptr as i64;
        }
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected after `_Atomic(type-name)`"));
        }
        self.next()?; // )
        Ok(Some(inner))
    }

    /// `typeof ( type-name )` / `typeof ( expression )` (C23 6.7.2.5,
    /// the GCC `__typeof__` extension). The result is the operand's
    /// type. A type-name operand parses as a base type plus any
    /// abstract pointer decoration; an expression operand is parsed
    /// unevaluated and its type recovered, mirroring `sizeof`'s
    /// expression branch. Only the flat scalar / pointer / aggregate
    /// type the rest of the parser carries is recovered; an array
    /// operand's element type is returned (the dimension is dropped,
    /// matching the decay the value contexts already apply).
    pub(super) fn parse_typeof_specifier(&mut self) -> Result<i64, C5Error> {
        self.next()?; // typeof
        if self.lex.tk != '(' {
            return Err(self.compile_err("`(` expected after `typeof`"));
        }
        self.next()?; // (
        let ty = if self.lex_is_type_start() {
            let mut inner = self.parse_decl_base_type()?;
            core::mem::take(&mut self.pending.typedef_base_array_size);
            while self.lex.tk == Token::MulOp {
                self.next()?;
                inner += Ty::Ptr as i64;
                while self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
            }
            inner
        } else {
            // Unevaluated expression operand: parse it to learn the
            // type, then discard everything the parse pushed so no
            // live code, AST node, or PC reservation survives.
            let saved_text_len = self.next_ent_pc;
            let saved_code_reloc_sym_idx = self.code_reloc_sym_idx.len();
            let saved_ast_acc = self.ast_acc;
            let saved_vstack = self.ast_vstack.len();
            self.expr(Token::Inc as i64)?;
            let expr_ty = self.ty;
            self.next_ent_pc = saved_text_len;
            self.clear_recent_emits();
            self.code_reloc_sym_idx.truncate(saved_code_reloc_sym_idx);
            self.ast_acc = saved_ast_acc;
            self.ast_vstack.truncate(saved_vstack);
            expr_ty
        };
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected after `typeof` operand"));
        }
        self.next()?; // )
        Ok(ty)
    }

    /// Consume a run of declaration decorators -- GCC
    /// `__attribute__ (( ... ))` and MSVC `__declspec ( ... )` -- if any.
    /// Returns true when one names the `packed` attribute, which sets an
    /// aggregate's layout; every other decorator is an advisory hint the
    /// dialect does not act on and is discarded. The parenthesised
    /// payload is matched by balance, so either parenthesis depth and
    /// any content -- nested calls, string literals, comma lists -- is
    /// consumed.
    pub(super) fn skip_attribute_specifiers(&mut self) -> Result<bool, C5Error> {
        let mut packed = false;
        while self.lex.tk == Token::Attribute {
            self.next()?; // __attribute__ / __declspec
            if self.lex.tk != '(' {
                return Err(self.compile_err("`(` expected after attribute specifier"));
            }
            let mut depth = 0i32;
            loop {
                if self.lex.tk == '(' {
                    depth += 1;
                    self.next()?;
                } else if self.lex.tk == ')' {
                    depth -= 1;
                    self.next()?;
                    if depth == 0 {
                        break;
                    }
                } else if self.lex.tk == 0 {
                    return Err(self.compile_err("unterminated `__attribute__`"));
                } else {
                    if self.lex.tk == Token::Id {
                        let n = self.symbols[self.lex.curr_id_idx].name.as_str();
                        if n == "packed" || n == "__packed__" {
                            packed = true;
                        }
                    }
                    self.next()?;
                }
            }
        }
        Ok(packed)
    }

    pub(super) fn parse_decl_base_type(&mut self) -> Result<i64, C5Error> {
        // Reset the void side channel up front so a previous
        // declaration's bare-void base doesn't leak into this one.
        self.pending.base_was_void = false;
        // Same for the function-type-typedef marker: a cast or sizeof
        // operand whose base was a function-type typedef must not leave
        // the flag set for a following declarator.
        self.pending.base_is_function_type = false;
        // Same reset for the long-double marker -- a binding
        // declared `double f(...)` after one declared `long
        // double g(...)` must not inherit g's marker.
        self.pending.base_was_long_double = false;
        // Same reset for the array-typedef dimension carrier: a
        // previous declaration that consumed a typedef-array base
        // (parameter parsing, abstract-declarator casts, ...)
        // may not have routed through the per-declarator
        // consumer, so clear here to keep the channel scoped to
        // this one base-type parse.
        self.pending.typedef_base_array_size = 0;
        self.pending.typedef_fn_proto = None;
        self.pending.fn_ptr_param_types = None;
        // Leading modifier soup -- the order doesn't matter; we
        // collect everything we see, then look at the next token
        // for the type keyword.
        let mut m = IntModifiers::default();
        while is_decl_modifier(self.lex.tk) {
            if self.lex.tk == Token::Attribute {
                self.skip_attribute_specifiers()?;
                continue;
            }
            // C11 6.7.2.4 atomic type specifier `_Atomic ( type-name )`.
            // Distinct from the `_Atomic` qualifier handled below: here
            // `_Atomic` names the type rather than qualifying a later
            // one. c5 does not model atomicity, so the declared type is
            // the unqualified inner type-name (base plus any abstract
            // pointer declarator inside the parentheses).
            if let Some(inner) = self.try_parse_atomic_type_specifier()? {
                return Ok(inner);
            }
            if self.lex.tk == Token::Inline {
                self.pending_is_inline = true;
            }
            if self.lex.tk == Token::Noreturn {
                self.pending_noreturn = true;
            }
            if !self.try_consume_int_modifier(&mut m)? {
                // const / volatile / restrict / _Atomic / etc. --
                // all no-ops in c5, just consume.
                self.next()?;
            }
        }

        // `typeof` / `__typeof__` (C23 6.7.2.5) names the type of a
        // parenthesized type-name or unevaluated expression operand.
        // The operand supplies the complete type, so the int-modifier
        // soup collected above does not apply.
        if self.lex.tk == Token::Typeof {
            return self.parse_typeof_specifier();
        }

        let bt = if self.lex.tk == Token::Int {
            self.next()?;
            m.int_base()
        } else if self.lex.tk == Token::Char {
            self.next()?;
            m.char_tag(self.target.plain_char_signed())
        } else if self.lex.tk == Token::Void {
            self.next()?;
            // `void` collapses to the same type encoding as
            // `unsigned char` so the existing void-pointer
            // arithmetic (`void *p; p + 1` strides one byte),
            // sizeof, struct-field layout, and function-pointer
            // call-table encoding stay byte-for-byte identical to
            // the legacy void-as-char desugaring. The void-vs-char
            // distinction is carried out-of-band via
            // `pending_base_was_void`: the function-decl path
            // reads it after the declarator runs to mark the
            // function symbol's `returns_void`. A prior attempt
            // to give `void` its own type band leaked into the
            // call-through-fn-ptr type comparison and rejected
            // `void (*p)(...)` dispatch tables, so the encoding
            // here stays unchanged and `returns_void` propagates
            // through the side channel instead.
            self.pending.base_was_void = true;
            Ty::Char as i64 | UNSIGNED_BIT
        } else if self.lex.tk == Token::Float {
            self.next()?;
            Ty::Float as i64
        } else if self.lex.tk == Token::Double {
            self.next()?;
            // `long double` collapses to the same f64 encoding as
            // plain `double` for storage and expression semantics
            // -- c5 has no 80- or 128-bit FP scalar. The
            // trailing-modifier loop silently consumes any extra
            // `long`. The marker below carries the spelling out
            // of band so the function-prototype path can stamp
            // a libc binding's return-convention flag (SysV
            // x86_64 returns long double in x87 st(0), not XMM0).
            if m.saw_long() {
                self.pending.base_was_long_double = true;
            }
            Ty::Double as i64
        } else if self.lex.tk == Token::Enum {
            // `enum [Tag] [{ ... }]` -- in c5 every enum collapses
            // to plain `int`. Capture any tag name and any
            // optional body's constants for DWARF; return Int as
            // the underlying type.
            self.next()?;
            let tag_name = if self.lex.tk == Token::Id {
                let id_idx = self.lex.curr_id_idx;
                let name = self.symbols[id_idx].name.clone();
                self.next()?;
                name
            } else {
                alloc::string::String::new()
            };
            if self.lex.tk == '{' {
                // Re-parse the body via the same constants-loop the
                // file-scope path uses.
                self.parse_enum_body(&tag_name)?;
            }
            Ty::Int as i64
        } else if self.lex.tk == Token::Struct || self.lex.tk == Token::Union {
            self.parse_aggregate_base_type()?
        } else if self.is_lex_typedef_name() {
            // Typedef-name as base type. Resolve to the aliased
            // type and consume the identifier.
            let aliased = self.symbols[self.lex.curr_id_idx].type_;
            // Carry the typedef's fn-pointer lineage forward (gh
            // #19) so a later `fn_t fp` declaration ends up with
            // the right indirection count.
            let typedef_fpi = self.symbols[self.lex.curr_id_idx].fn_ptr_indirection;
            if typedef_fpi > 0 {
                self.pending.fn_ptr_indirection = Some(typedef_fpi);
                self.pending.base_is_function_type =
                    self.symbols[self.lex.curr_id_idx].is_function_type;
                // A function-pointer typedef records the pointed-to
                // function's prototype; carry it to the bound declarator
                // so an indirect call through the variable narrows each
                // argument to its declared parameter type and splits
                // fixed vs variadic arguments per the host variadic ABI.
                self.pending.typedef_fn_proto = Some((
                    self.symbols[self.lex.curr_id_idx].params.len(),
                    self.symbols[self.lex.curr_id_idx].is_variadic,
                ));
                self.pending.fn_ptr_param_types =
                    Some(self.symbols[self.lex.curr_id_idx].params.clone());
            }
            // Propagate the bare-void flag through the typedef so
            // `(VOID)` in parameter position is recognised as the
            // no-parameter idiom.
            if self.symbols[self.lex.curr_id_idx].is_void_typedef {
                self.pending.base_was_void = true;
            }
            // Propagate the typedef's array dimension (C99 6.7.7
            // paragraph 3). `typedef long jmp_buf[64]; jmp_buf b;`
            // must bind `b` as `long b[64]`, not as a scalar.
            let typedef_array = self.symbols[self.lex.curr_id_idx].array_size;
            if typedef_array > 0 {
                self.pending.typedef_base_array_size = typedef_array;
            }
            self.next()?;
            aliased
        } else if m.saw_int_mod {
            // Bare `unsigned x;` / `long x;` / `long long x;` /
            // `short x;` / `_Bool x;` -- the C implicit-int rule
            // applies for int-modifier-only decls.
            m.int_base()
        } else {
            return Err(self.compile_err("type expected"));
        };

        // Trailing qualifiers / modifiers: `int const`, `int long`,
        // `unsigned int long long`, etc. all collapse to the base type
        // already chosen.
        while is_decl_modifier(self.lex.tk) {
            if self.lex.tk == Token::Attribute {
                self.skip_attribute_specifiers()?;
                continue;
            }
            self.next()?;
        }

        Ok(bt)
    }
}
