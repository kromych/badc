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

    /// Pick the `char` tag. `signed char` is the only spelling
    /// that keeps the `UNSIGNED_BIT` off; bare `char` and
    /// `unsigned char` both carry it (c5 treats plain `char` as
    /// unsigned so byte-array idioms see zero-extending loads).
    pub fn char_tag(&self) -> i64 {
        if self.saw_signed {
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
            self.parse_aggregate_body(&name, is_union)?
        } else {
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
    pub(super) fn parse_decl_base_type(&mut self) -> Result<i64, C5Error> {
        // Reset the void side channel up front so a previous
        // declaration's bare-void base doesn't leak into this one.
        self.pending.base_was_void = false;
        // Leading modifier soup -- the order doesn't matter; we
        // collect everything we see, then look at the next token
        // for the type keyword.
        let mut m = IntModifiers::default();
        while is_decl_modifier(self.lex.tk) {
            if !self.try_consume_int_modifier(&mut m)? {
                // const / volatile / restrict / _Atomic / etc. --
                // all no-ops in c5, just consume.
                self.next()?;
            }
        }

        let bt = if self.lex.tk == Token::Int {
            self.next()?;
            m.int_base()
        } else if self.lex.tk == Token::Char {
            self.next()?;
            m.char_tag()
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
            // function symbol's `returns_void`. The earlier
            // attempt to give `void` its own band collided with
            // sqlite3's `void (*xFunc)(...)` dispatch tables (the
            // band number leaked into the call-through-fn-ptr type
            // comparison) -- keeping the encoding here untouched
            // sidesteps that trap.
            self.pending.base_was_void = true;
            Ty::Char as i64 | UNSIGNED_BIT
        } else if self.lex.tk == Token::Float {
            self.next()?;
            Ty::Float as i64
        } else if self.lex.tk == Token::Double {
            self.next()?;
            // `long double` is only as wide as `double` here -- c5
            // has no 80- or 128-bit FP type. The trailing-modifier
            // loop already silently consumes any extra `long`.
            Ty::Double as i64
        } else if self.lex.tk == Token::Enum {
            // `enum [Tag] [{ ... }]` -- in c5 every enum collapses
            // to plain `int`. Consume any tag name and any optional
            // body; return Int as the underlying type.
            self.next()?;
            if self.lex.tk == Token::Id {
                self.next()?;
            }
            if self.lex.tk == '{' {
                // Re-parse the body via the same constants-loop the
                // file-scope path uses.
                self.parse_enum_body()?;
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
            }
            // Propagate the bare-void flag through the typedef so
            // `(VOID)` in parameter position is recognised as the
            // no-parameter idiom.
            if self.symbols[self.lex.curr_id_idx].is_void_typedef {
                self.pending.base_was_void = true;
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
            self.next()?;
        }

        Ok(bt)
    }
}
