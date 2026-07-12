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
use super::types::{UNSIGNED_BIT, VOLATILE_BIT, is_decl_modifier, struct_ty_for};

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
            let base_arr = core::mem::take(&mut self.pending.typedef_base_array_size);
            let mut had_ptr = false;
            while self.lex.tk == Token::MulOp {
                self.next()?;
                inner += Ty::Ptr as i64;
                had_ptr = true;
                while self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
            }
            // `typeof(T[N])` is an array type; `typeof(T *)` is not.
            self.pending.typeof_operand_was_array = base_arr != 0 && !had_ptr;
            inner
        } else {
            // Unevaluated expression operand: parse it to learn the
            // type, then discard everything the parse pushed so no
            // live code, AST node, or PC reservation survives.
            let saved_text_len = self.next_ent_pc;
            let saved_code_reloc_sym_idx = self.code_reloc_sym_idx.len();
            let saved_ast_acc = self.ast_acc;
            let saved_vstack = self.ast_vstack.len();
            // Array-decay hints record that the operand's value came
            // from an array: `last_array_decay_size` (element count) for
            // a 1D bare array, `last_array_decay_bytes` (byte width) for
            // a multi-dim subscript row, a `*p` pointer-to-array row
            // deref, or a string literal. Capture both so an array
            // operand types distinctly from a pointer, then restore them
            // so they do not leak into a surrounding `sizeof`.
            let saved_decay = self.pending.last_array_decay_size;
            let saved_decay_bytes = self.pending.last_array_decay_bytes;
            self.pending.last_array_decay_size = 0;
            self.pending.last_array_decay_bytes = 0;
            // The operand is a full expression (C99 6.7.6.2 / the GCC
            // extension): parse at assignment precedence so binary,
            // conditional, and assignment operators are consumed, then a
            // trailing comma operator whose last term gives the type.
            self.expr(Token::Assign as i64)?;
            while self.lex.tk == ',' {
                self.next()?;
                self.pending.last_array_decay_size = 0;
                self.pending.last_array_decay_bytes = 0;
                self.expr(Token::Assign as i64)?;
            }
            let expr_ty = self.ty;
            // Either marker firing means the operand decayed from an
            // array, so `typeof(x)` is an array type and
            // `__builtin_types_compatible_p(typeof(x), typeof(&(x)[0]))`
            // must report it as distinct from a pointer -- including a
            // subscripted row of a multi-dim array (`arr2d[i]`), which
            // sets only the byte marker.
            self.pending.typeof_operand_was_array =
                self.pending.last_array_decay_size != 0 || self.pending.last_array_decay_bytes > 0;
            self.pending.last_array_decay_size = saved_decay;
            self.pending.last_array_decay_bytes = saved_decay_bytes;
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

    /// Set `*packed` / `*maybe_unused` if the current token is the
    /// corresponding attribute name (`packed` / `__packed__`,
    /// `unused` / `maybe_unused` / `__unused__`). Other names are
    /// ignored.
    #[allow(clippy::too_many_arguments)]
    fn note_attribute_name(
        &self,
        packed: &mut bool,
        maybe_unused: &mut bool,
        thread_local: &mut bool,
        noreturn: &mut bool,
        dllexport: &mut bool,
        aligned: &mut bool,
        constructor: &mut bool,
        destructor: &mut bool,
    ) {
        if self.lex.tk == Token::Id {
            let n = self.symbols[self.lex.curr_id_idx].name.as_str();
            if n == "packed" || n == "__packed__" {
                *packed = true;
            } else if n == "unused" || n == "maybe_unused" || n == "__unused__" {
                *maybe_unused = true;
            } else if n == "thread" {
                // MSVC `__declspec(thread)`: thread-local storage. `thread` is
                // not a GNU attribute, so it can only mean this.
                *thread_local = true;
            } else if n == "noreturn" || n == "__noreturn__" {
                // `__declspec(noreturn)` / `__attribute__((noreturn))`.
                *noreturn = true;
            } else if n == "dllexport" {
                // MSVC `__declspec(dllexport)`: export the symbol, the
                // equivalent of `#pragma export(name)`.
                *dllexport = true;
            } else if n == "aligned" || n == "__aligned__" || n == "align" {
                // GNU `aligned(N)` / MSVC `__declspec(align(N))`.
                *aligned = true;
            } else if n == "constructor" || n == "__constructor__" {
                // GNU `constructor` / `constructor(N)`: run before `main`.
                *constructor = true;
            } else if n == "destructor" || n == "__destructor__" {
                // GNU `destructor` / `destructor(N)`: run after `main` returns.
                *destructor = true;
            }
        }
    }

    /// Consume a run of declaration decorators -- GCC
    /// `__attribute__ (( ... ))` / `__declspec ( ... )` / `_Alignas
    /// ( ... )` and C23 `[[ ... ]]` -- if any. Returns true when one
    /// names the `packed` attribute, which sets an aggregate's layout;
    /// `maybe_unused` / `unused` is recorded on `pending.attr_maybe_unused`.
    /// Every other decorator is an advisory hint the dialect does not act
    /// on and is discarded. The payload is matched by balance, so any
    /// parenthesis depth and content -- nested calls, string literals,
    /// comma lists -- is consumed.
    pub(super) fn skip_attribute_specifiers(&mut self) -> Result<bool, C5Error> {
        let mut packed = false;
        let mut maybe_unused = false;
        let mut thread_local = false;
        let mut noreturn = false;
        let mut dllexport = false;
        let mut align: i64 = 0;
        let mut vector_size: i64 = 0;
        let mut constructor = false;
        let mut destructor = false;
        let mut init_priority: Option<u32> = None;
        loop {
            if self.lex.tk == Token::Attribute {
                // `__attribute__((...))`, `__declspec(...)`,
                // `_Alignas(...)`. Consume the balanced parenthesised
                // payload, recording the `packed` attribute.
                let is_alignas = self.symbols[self.lex.curr_id_idx].name == "_Alignas";
                self.next()?;
                if self.lex.tk != '(' {
                    return Err(self.compile_err("`(` expected after attribute specifier"));
                }
                // C11 6.7.5 `_Alignas(constant-expression)`. The
                // type-name form's alignment never exceeds 8 in this
                // dialect and stays advisory.
                if is_alignas {
                    self.next()?; // (
                    if self.lex.tk == Token::Num {
                        let n = self.parse_constant_int()?;
                        align = align.max(n);
                        if self.lex.tk != ')' {
                            return Err(self.compile_err("`)` expected after `_Alignas` operand"));
                        }
                        self.next()?;
                    } else {
                        let mut depth = 1i32;
                        while depth > 0 {
                            if self.lex.tk == '(' {
                                depth += 1;
                            } else if self.lex.tk == ')' {
                                depth -= 1;
                            } else if self.lex.tk == 0 {
                                return Err(self.compile_err("unterminated `_Alignas`"));
                            }
                            self.next()?;
                        }
                    }
                    continue;
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
                        return Err(self.compile_err("unterminated attribute specifier"));
                    } else {
                        // Capture whether this is `vector_size` before the
                        // `&mut self` calls below release the symbol borrow.
                        let is_vector_size = self.lex.tk == Token::Id
                            && matches!(
                                self.symbols[self.lex.curr_id_idx].name.as_str(),
                                "vector_size" | "__vector_size__"
                            );
                        let is_cleanup = self.lex.tk == Token::Id
                            && matches!(
                                self.symbols[self.lex.curr_id_idx].name.as_str(),
                                "cleanup" | "__cleanup__"
                            );
                        let mut saw_aligned = false;
                        let mut saw_constructor = false;
                        let mut saw_destructor = false;
                        self.note_attribute_name(
                            &mut packed,
                            &mut maybe_unused,
                            &mut thread_local,
                            &mut noreturn,
                            &mut dllexport,
                            &mut saw_aligned,
                            &mut saw_constructor,
                            &mut saw_destructor,
                        );
                        self.next()?;
                        if saw_aligned {
                            if self.lex.tk == '(' {
                                self.next()?;
                                let n = self.parse_constant_int()?;
                                align = align.max(n);
                                if self.lex.tk != ')' {
                                    return Err(
                                        self.compile_err("`)` expected after `aligned` operand")
                                    );
                                }
                                self.next()?;
                            } else {
                                // Bare `aligned`: the target's largest
                                // fundamental alignment (16 on the
                                // supported targets).
                                align = align.max(16);
                            }
                        } else if saw_constructor || saw_destructor {
                            constructor |= saw_constructor;
                            destructor |= saw_destructor;
                            init_priority = self.parse_init_priority(init_priority)?;
                        } else if is_vector_size && self.lex.tk == '(' {
                            // GCC `vector_size(N)`: the declared type becomes a
                            // vector N bytes wide. Captured here; the base-type
                            // parse rebuilds the element type into the vector.
                            self.next()?;
                            vector_size = self.parse_constant_int()?;
                            if self.lex.tk != ')' {
                                return Err(
                                    self.compile_err("`)` expected after `vector_size` operand")
                                );
                            }
                            self.next()?;
                        } else if is_cleanup && self.lex.tk == '(' {
                            // GCC `cleanup(fn)`: name the function to call with
                            // the variable's address at scope exit. The operand
                            // is an identifier already in scope.
                            self.next()?; // `(`
                            if self.lex.tk != Token::Id {
                                return Err(
                                    self.compile_err("`cleanup` operand must be a function name")
                                );
                            }
                            self.pending.attr_cleanup = Some(self.lex.curr_id_idx);
                            self.next()?; // function name
                            if self.lex.tk != ')' {
                                return Err(
                                    self.compile_err("`)` expected after `cleanup` operand")
                                );
                            }
                            self.next()?;
                        }
                    }
                }
            } else if self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'[') {
                // C23 6.7.13 `[[ ... ]]` attribute. The opening `[[` and
                // closing `]]` are each two bracket tokens; argument
                // lists use balanced parentheses, so a `]` closes only at
                // paren depth zero. The `gnu::` / `clang::` namespace
                // prefixes lex as separate tokens and need no special
                // handling -- the `packed` name is detected wherever it
                // appears.
                self.next()?; // first `[`
                self.next()?; // second `[`
                let mut depth = 0i32;
                loop {
                    if self.lex.tk == '(' {
                        depth += 1;
                        self.next()?;
                    } else if self.lex.tk == ')' {
                        depth -= 1;
                        self.next()?;
                    } else if self.lex.tk == ']' && depth == 0 {
                        self.next()?; // first `]`
                        if self.lex.tk != ']' {
                            return Err(self.compile_err("`]]` expected to close attribute"));
                        }
                        self.next()?; // second `]`
                        break;
                    } else if self.lex.tk == 0 {
                        return Err(self.compile_err("unterminated `[[` attribute"));
                    } else {
                        let mut saw_aligned = false;
                        let mut saw_constructor = false;
                        let mut saw_destructor = false;
                        self.note_attribute_name(
                            &mut packed,
                            &mut maybe_unused,
                            &mut thread_local,
                            &mut noreturn,
                            &mut dllexport,
                            &mut saw_aligned,
                            &mut saw_constructor,
                            &mut saw_destructor,
                        );
                        self.next()?;
                        if saw_aligned && self.lex.tk == '(' {
                            self.next()?;
                            let n = self.parse_constant_int()?;
                            align = align.max(n);
                            if self.lex.tk != ')' {
                                return Err(
                                    self.compile_err("`)` expected after `aligned` operand")
                                );
                            }
                            self.next()?;
                        } else if saw_constructor || saw_destructor {
                            constructor |= saw_constructor;
                            destructor |= saw_destructor;
                            init_priority = self.parse_init_priority(init_priority)?;
                        }
                    }
                }
            } else {
                break;
            }
        }
        if maybe_unused {
            self.pending.attr_maybe_unused = true;
        }
        if thread_local {
            self.pending.attr_thread_local = true;
        }
        if noreturn {
            self.pending_noreturn = true;
        }
        if dllexport {
            self.pending.attr_dllexport = true;
        }
        if align > 0 {
            self.pending.attr_align = self.pending.attr_align.max(align);
        }
        if vector_size > 0 {
            self.pending.attr_vector_size = vector_size;
        }
        if constructor {
            self.pending.attr_constructor = true;
        }
        if destructor {
            self.pending.attr_destructor = true;
        }
        if let Some(p) = init_priority {
            self.pending.attr_init_priority = Some(p);
        }
        Ok(packed)
    }

    /// Parse the optional `(N)` priority argument of a
    /// `constructor` / `destructor` attribute. The current token is
    /// the attribute name's successor; `(` opens the priority, absent
    /// leaves `prev` unchanged (the bare form). GNU reserves 0-100 for
    /// the implementation but does not reject them; the value rides
    /// into the `.init_array.NNNNN` section ordering.
    fn parse_init_priority(&mut self, prev: Option<u32>) -> Result<Option<u32>, C5Error> {
        if self.lex.tk != '(' {
            return Ok(prev);
        }
        self.next()?; // (
        let n = self.parse_constant_int()?;
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected after constructor/destructor priority"));
        }
        self.next()?;
        if !(0..=65535).contains(&n) {
            return Err(self.compile_err("constructor/destructor priority out of range 0..65535"));
        }
        Ok(Some(n as u32))
    }

    /// Parse a scalar base-type keyword (`int` / `char` / `void` /
    /// `float` / `double`) given the modifiers already collected in
    /// `m`, consuming the keyword. Returns `None` without consuming
    /// when the current token is not one of these. Sets the
    /// `base_was_void` / `base_was_long_double` side channels the
    /// function-declaration path reads. C99 6.7.2.
    pub(super) fn parse_scalar_base_specifier(
        &mut self,
        m: &IntModifiers,
    ) -> Result<Option<i64>, C5Error> {
        let bt = if self.lex.tk == Token::Int {
            self.next()?;
            m.int_base()
        } else if self.lex.tk == Token::Char {
            self.next()?;
            m.char_tag(self.target.plain_char_signed())
        } else if self.lex.tk == Token::Void {
            self.next()?;
            // `void` shares the `unsigned char` encoding so void-pointer
            // arithmetic / sizeof / fn-ptr tables match the legacy
            // void-as-char path; the void-ness rides `base_was_void`,
            // which the function-decl path reads for `returns_void`.
            self.pending.base_was_void = true;
            Ty::Char as i64 | UNSIGNED_BIT
        } else if self.lex.tk == Token::Float {
            self.next()?;
            Ty::Float as i64
        } else if self.lex.tk == Token::Double {
            self.next()?;
            // `long double` collapses to the f64 `double` encoding; the
            // marker carries the spelling so the prototype path can stamp
            // a libc binding's return convention (SysV x86_64 returns
            // long double in x87 st(0), not XMM0).
            if m.saw_long() {
                self.pending.base_was_long_double = true;
            }
            Ty::Double as i64
        } else {
            return Ok(None);
        };
        Ok(Some(bt))
    }

    /// `VOLATILE_BIT` when the current token is the `volatile` type
    /// qualifier (C99 6.7.3), 0 for any other spelling mapped to
    /// `Token::TypeQual` (`const`, `restrict`, calling-convention
    /// decorations). Qualifier identity lives on the interned keyword
    /// symbol; the caller consumes the token.
    pub(super) fn lex_volatile_bit(&self) -> i64 {
        if self.lex.tk != Token::TypeQual {
            return 0;
        }
        match self.symbols[self.lex.curr_id_idx].name.as_str() {
            "volatile" | "__volatile" | "__volatile__" => VOLATILE_BIT,
            _ => 0,
        }
    }

    /// True when the current token is the `const` type qualifier.
    pub(super) fn lex_is_const_qual(&self) -> bool {
        self.lex.tk == Token::TypeQual
            && matches!(
                self.symbols[self.lex.curr_id_idx].name.as_str(),
                "const" | "__const" | "__const__"
            )
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
        let mut qual_bits: i64 = 0;
        loop {
            // C23 6.7.13 `[[...]]` and GNU `__attribute__`/`__declspec`
            // may lead the declaration specifiers.
            if self.lex.tk == Token::Attribute
                || (self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'['))
            {
                self.skip_attribute_specifiers()?;
                continue;
            }
            if !is_decl_modifier(self.lex.tk) {
                break;
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
                // `volatile` sets the tag's qualifier bit (C99 6.7.3);
                // `const` is recorded out-of-band for value folding;
                // restrict / _Atomic / etc. are no-ops.
                qual_bits |= self.lex_volatile_bit();
                self.pending.base_is_const |= self.lex_is_const_qual();
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

        let base_tok = self.lex.tk;
        let mut bt = if let Some(scalar) = self.parse_scalar_base_specifier(&m)? {
            scalar
        } else if self.lex.tk == Token::Enum {
            // `enum [Tag] [{ ... }]` is `int`, or the packed underlying
            // type for `enum __attribute__((packed))`; the shared
            // parse_enum_decl captures the tag + body for DWARF.
            self.parse_enum_decl()?
        } else if self.lex.tk == Token::Struct || self.lex.tk == Token::Union {
            self.parse_aggregate_base_type()?
        } else if self.is_lex_int128_spelling() {
            // GCC `__int128` / `__int128_t` / `__uint128_t` (and, via the
            // modifier soup, `unsigned __int128`): a 16-byte integer type,
            // modeled as a 16-byte aggregate for layout / sizeof / copy.
            self.next()?;
            self.builtin_int128_tag()
        } else if !m.saw_int_mod && self.is_lex_typedef_name() {
            // Typedef-name as base type. Resolve to the aliased
            // type and consume the identifier. Guarded by
            // `!saw_int_mod`: C99 6.7.2p2 forbids combining a
            // typedef-name with `unsigned`/`short`/`long`/`signed`,
            // so once an int-modifier is seen the following
            // typedef-name is the declarator identifier (a redeclared
            // name), not a second type-specifier.
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
            // Non-zero covers a fixed dimension and the `-1` deferred-array
            // marker (`typedef T X[]`); a parameter of the latter still decays
            // to a pointer to the element (C99 6.7.5.3p7).
            if typedef_array != 0 {
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

        // Trailing specifiers: C99 6.7.2p2 admits the specifier
        // multiset in any order, so `int long`, `int unsigned`,
        // `char unsigned`, `double long` re-derive the base tag from
        // the folded modifiers; trailing qualifiers fold into the
        // qualifier bits. A non-scalar base (typedef, struct, enum)
        // has no valid int-modifier combination; the tokens are
        // consumed as before.
        let (saw_int_mod, trailing_quals) = self.consume_trailing_decl_modifiers(&mut m)?;
        qual_bits |= trailing_quals;
        if saw_int_mod {
            if base_tok == Token::Int {
                bt = m.int_base();
            } else if base_tok == Token::Char {
                bt = m.char_tag(self.target.plain_char_signed());
            } else if base_tok == Token::Double && m.saw_long() {
                self.pending.base_was_long_double = true;
            }
        }

        // `__attribute__((vector_size(N)))` rebuilds the base type into a GCC
        // vector of N bytes before qualifiers apply, matching the file-scope
        // path in `run_compile.rs`.
        if self.pending.attr_vector_size > 0 {
            let n = core::mem::take(&mut self.pending.attr_vector_size);
            bt = self.make_vector_type(bt, n);
        }

        Ok(bt | qual_bits)
    }

    /// Consume the specifiers that may trail the base-type keyword:
    /// int modifiers fold into `m` (the caller re-derives the base
    /// tag), qualifier bits are returned for the caller to fold into
    /// the type, and `inline` / `_Noreturn` set the same pending
    /// flags as in leading position.
    pub(super) fn consume_trailing_decl_modifiers(
        &mut self,
        m: &mut IntModifiers,
    ) -> Result<(bool, i64), C5Error> {
        let mut saw_int_mod = false;
        let mut qual_bits = 0i64;
        while is_decl_modifier(self.lex.tk) {
            if self.lex.tk == Token::Attribute {
                self.skip_attribute_specifiers()?;
                continue;
            }
            if self.lex.tk == Token::Inline {
                self.pending_is_inline = true;
            }
            if self.lex.tk == Token::Noreturn {
                self.pending_noreturn = true;
            }
            if self.try_consume_int_modifier(m)? {
                saw_int_mod = true;
                continue;
            }
            qual_bits |= self.lex_volatile_bit();
            self.next()?;
        }
        Ok((saw_int_mod, qual_bits))
    }
}
