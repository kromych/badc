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
        // `typeof(f)` where `f` names a function: the specifier is `f`'s
        // function type. Route the same pending carriers a function-type
        // typedef base uses so a declarator through the specifier is a
        // function declaration and a redeclaration of a defined function
        // merges (C99 6.2.7) instead of colliding as a duplicate.
        if self.lex.tk == Token::Id && self.lex.peek_after_whitespace(b')') {
            let idx = self.lex.curr_id_idx;
            let class = self.symbols[idx].class;
            if class == Token::Fun as i64 || class == Token::Sys as i64 {
                let fty = self.symbols[idx].type_ + Ty::Ptr as i64;
                self.pending.fn_ptr_indirection = Some(1);
                self.pending.base_is_function_type = true;
                self.pending.typedef_fn_proto = Some((
                    self.symbols[idx].params.len(),
                    self.symbols[idx].is_variadic,
                ));
                self.pending.fn_ptr_param_types = Some(self.symbols[idx].params.clone());
                self.next()?; // identifier
                self.next()?; // )
                return Ok(fty);
            }
        }
        let ty = if self.lex_is_type_start() {
            let mut inner = self.parse_decl_base_type()?;
            let mut had_ptr = false;
            while self.lex.tk == Token::MulOp {
                self.next()?;
                inner += Ty::Ptr as i64;
                had_ptr = true;
                while self.lex.tk == Token::TypeQual {
                    self.next()?;
                }
            }
            // An array typedef operand keeps its dimension on the carrier
            // so a declarator through the specifier is an array, exactly
            // as if the typedef itself were the base type. `typeof(T *)`
            // names a pointer; the dimension belongs to the pointee.
            if had_ptr {
                self.pending.typedef_base_array_size = 0;
                self.pending.typedef_base_array_dims.clear();
            }
            self.pending.typeof_operand_was_array =
                self.pending.typedef_base_array_size != 0 && !had_ptr;
            inner
        } else {
            let mut inner = self.parse_unevaluated_expr_ty(true)?;
            // A 1D array expression operand decayed to a pointer to its
            // element; recover the element type and put the element count
            // on the carrier like an array typedef base, so a declarator
            // through the specifier is an array. TODO: multi-dim
            // expression operands (the dims chain is not recoverable from
            // the decay markers).
            let n = core::mem::take(&mut self.pending.typeof_operand_array_size);
            if n != 0 && inner >= Ty::Ptr as i64 {
                inner -= Ty::Ptr as i64;
                self.pending.typedef_base_array_size = n;
            }
            inner
        };
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected after `typeof` operand"));
        }
        self.next()?; // )
        Ok(ty)
    }

    /// Parse an unevaluated expression to learn its type, then discard
    /// everything the parse pushed so no live code, AST node, or PC
    /// reservation survives. `comma_operands` extends the parse across
    /// a trailing comma operator whose last term gives the type
    /// (`typeof`'s operand grammar); a declarator initializer stops at
    /// the comma. Sets `pending.typeof_operand_was_array` when the
    /// operand's value decayed from an array.
    /// The symbol index of the function whose address the accumulated
    /// expression takes (`&f`), if that is its whole shape.
    fn addressed_function_symbol(&self) -> Option<usize> {
        use super::super::ast::{Expr, UnOp};
        // A function designator already denotes its address, so `&f` may
        // reach here either wrapped in the operator or collapsed to the
        // identifier.
        let e = self.ast.expr(self.ast_acc?);
        let e = match e {
            Expr::Unary {
                op: UnOp::AddrOf,
                child,
                ..
            } => self.ast.expr(*child),
            _ => e,
        };
        let Expr::Ident { sym, class, .. } = e else {
            return None;
        };
        (*class == Token::Fun as i64 || *class == Token::Sys as i64).then_some(*sym as usize)
    }

    fn parse_unevaluated_expr_ty(&mut self, comma_operands: bool) -> Result<i64, C5Error> {
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
        // Parse at assignment precedence so binary, conditional, and
        // assignment operators are consumed.
        self.expr(Token::Assign as i64)?;
        if comma_operands {
            while self.lex.tk == ',' {
                self.next()?;
                self.pending.last_array_decay_size = 0;
                self.pending.last_array_decay_bytes = 0;
                self.expr(Token::Assign as i64)?;
            }
        }
        // `&f` where `f` names a function: the operand is a pointer to
        // `f`'s function type. Route the same pending carriers the
        // function-typedef and `typeof(f)` bases use, so the prototype
        // reaches a type-name reader; without them the specifier keeps
        // only the return type and an opaque pointer level.
        let expr_ty = match self.addressed_function_symbol() {
            Some(idx) => {
                self.pending.fn_ptr_indirection = Some(1);
                self.pending.base_is_function_type = false;
                self.pending.typedef_fn_proto = Some((
                    self.symbols[idx].params.len(),
                    self.symbols[idx].is_variadic,
                ));
                self.pending.fn_ptr_param_types = Some(self.symbols[idx].params.clone());
                self.symbols[idx].type_ + Ty::Ptr as i64
            }
            None => self.ty,
        };
        // Either marker firing means the operand decayed from an
        // array, so `typeof(x)` is an array type and
        // `__builtin_types_compatible_p(typeof(x), typeof(&(x)[0]))`
        // must report it as distinct from a pointer -- including a
        // subscripted row of a multi-dim array (`arr2d[i]`), which
        // sets only the byte marker.
        self.pending.typeof_operand_was_array =
            self.pending.last_array_decay_size != 0 || self.pending.last_array_decay_bytes > 0;
        self.pending.typeof_operand_array_size = self.pending.last_array_decay_size;
        self.pending.last_array_decay_size = saved_decay;
        self.pending.last_array_decay_bytes = saved_decay_bytes;
        self.next_ent_pc = saved_text_len;
        self.clear_recent_emits();
        self.code_reloc_sym_idx.truncate(saved_code_reloc_sym_idx);
        self.ast_acc = saved_ast_acc;
        self.ast_vstack.truncate(saved_vstack);
        Ok(expr_ty)
    }

    /// `asm ( "reg" )` after a block-scope declarator: a GNU
    /// explicit-register binding. The current token is `asm`; on
    /// return the cursor is past the closing `)`. Returns the quoted
    /// register name.
    pub(super) fn parse_asm_register_suffix(&mut self) -> Result<alloc::string::String, C5Error> {
        self.next()?; // asm
        self.consume(b'(', "`(` expected after `asm`")?;
        if self.lex.tk != '"' {
            return Err(self.compile_err("register name string expected in `asm(...)`"));
        }
        // The lexer appended the literal's bytes to the data section;
        // read them back and drop them.
        let start = self.lex.ival as usize;
        self.next()?; // consume the string
        let mut bytes = self.data[start..].to_vec();
        self.data.truncate(start);
        while bytes.last() == Some(&0) {
            bytes.pop();
        }
        let name = alloc::string::String::from_utf8_lossy(&bytes).into_owned();
        if self.lex.tk != ')' {
            return Err(self.compile_err("`)` expected after register name"));
        }
        self.next()?;
        Ok(name)
    }

    /// Consume an optional `asm("reg")` explicit-register suffix on a
    /// block-scope declarator. The binding requires the `register`
    /// storage class and automatic duration.
    pub(super) fn parse_register_asm_binding(
        &mut self,
        is_static: bool,
        is_extern: bool,
    ) -> Result<Option<crate::c5::symbol::AsmRegister>, C5Error> {
        if self.lex.tk != Token::Asm {
            return Ok(None);
        }
        let name = self.parse_asm_register_suffix()?;
        if !self.pending.saw_register_storage {
            return Err(self.compile_err(
                "an explicit-register binding requires the `register` storage class",
            ));
        }
        if is_static || is_extern {
            return Err(
                self.compile_err("an explicit-register variable cannot be `static` or `extern`")
            );
        }
        Ok(Some(self.resolve_asm_register(&name)?))
    }

    /// A stack- or frame-pointer register variable compiles reads into
    /// direct register moves and holds no writable storage; reject an
    /// initializer before the declaration parse consumes it.
    pub(super) fn check_register_asm_init(
        &self,
        reg: Option<crate::c5::symbol::AsmRegister>,
    ) -> Result<(), C5Error> {
        use crate::c5::symbol::AsmRegister as R;
        if matches!(reg, Some(R::StackPointer | R::FramePointer)) && self.lex.tk == Token::Assign {
            return Err(self
                .compile_err("a stack- or frame-pointer register variable cannot be initialized"));
        }
        Ok(())
    }

    /// `register T name asm("reg")` at file scope: a GNU global register
    /// variable. Stack- and frame-pointer bindings are supported; reads
    /// anywhere in the unit compile into direct register moves, the name
    /// holds no storage and emits no symbol. The declaration may repeat
    /// across the unit (headers re-include it) as long as the register
    /// matches. TODO: general-purpose global register variables (the
    /// register must be reserved in every function's allocation).
    pub(super) fn parse_file_scope_register_binding(
        &mut self,
        id_idx: usize,
        ty: i64,
        is_static: bool,
        is_extern: bool,
    ) -> Result<(), C5Error> {
        use crate::c5::symbol::AsmRegister as R;
        let name = self.parse_asm_register_suffix()?;
        if is_static || is_extern {
            return Err(
                self.compile_err("an explicit-register variable cannot be `static` or `extern`")
            );
        }
        let reg = self.resolve_asm_register(&name)?;
        if !matches!(reg, R::StackPointer | R::FramePointer) {
            return Err(self.compile_err(
                "file-scope register variables are supported for the stack and frame pointer only",
            ));
        }
        let prior_class = self.symbols[id_idx].class;
        if prior_class != 0 {
            let same =
                prior_class == Token::Loc as i64 && self.symbols[id_idx].asm_register == Some(reg);
            if !same {
                return Err(self.compile_err(format!(
                    "`{}` conflicts with a prior declaration",
                    self.symbols[id_idx].name
                )));
            }
        }
        self.check_register_asm_init(Some(reg))?;
        let sym = &mut self.symbols[id_idx];
        sym.class = Token::Loc as i64;
        sym.type_ = ty;
        sym.val = 0;
        sym.array_size = 0;
        sym.asm_register = Some(reg);
        sym.is_global_register = true;
        sym.decl_line = self.lex.line;
        // The binding is the outermost scope: make the shadow slots hold
        // the binding itself so the per-function `Loc` cleanup restore
        // (and any block-scope shadowing) round-trips back to it.
        sym.h_class = sym.class;
        sym.h_type = sym.type_;
        sym.h_val = sym.val;
        sym.h_array_size = 0;
        sym.h_asm_register = sym.asm_register;
        sym.h_is_global_register = true;
        Ok(())
    }

    /// Resolve a `register T name asm("reg")` register name against the
    /// compile target. The `%`-prefixed spelling is accepted. Registers
    /// the emitters reserve as scratch (r10 / r11 on x86-64, x16 / x17
    /// on aarch64) and non-general-purpose registers are rejected: a
    /// binding through them cannot be honored.
    pub(super) fn resolve_asm_register(
        &self,
        name: &str,
    ) -> Result<crate::c5::symbol::AsmRegister, C5Error> {
        use crate::c5::symbol::AsmRegister as R;
        let n = name.trim_start_matches('%');
        let aarch64 = matches!(
            self.target,
            crate::Target::MacOSAarch64
                | crate::Target::LinuxAarch64
                | crate::Target::WindowsAarch64
        );
        let resolved = if aarch64 {
            match n {
                "sp" | "wsp" => Some(R::StackPointer),
                "fp" | "x29" | "w29" => Some(R::FramePointer),
                "lr" => Some(R::Gp(30)),
                _ => {
                    let (prefix, rest) = n.split_at(1.min(n.len()));
                    if (prefix == "x" || prefix == "w")
                        && let Ok(i) = rest.parse::<u8>()
                        && i <= 30
                    {
                        // x16 / x17 are the emitters' scratch pair; x18
                        // is the platform register on the supported
                        // OS ABIs.
                        if (16..=18).contains(&i) {
                            return Err(self.compile_err(format!(
                                "register `{n}` is reserved and cannot hold a register variable"
                            )));
                        }
                        Some(R::Gp(i))
                    } else {
                        None
                    }
                }
            }
        } else {
            match n {
                "rsp" | "esp" => Some(R::StackPointer),
                "rbp" | "ebp" => Some(R::FramePointer),
                "rax" | "eax" => Some(R::Gp(0)),
                "rcx" | "ecx" => Some(R::Gp(1)),
                "rdx" | "edx" => Some(R::Gp(2)),
                "rbx" | "ebx" => Some(R::Gp(3)),
                "rsi" | "esi" => Some(R::Gp(6)),
                "rdi" | "edi" => Some(R::Gp(7)),
                "r8" | "r8d" => Some(R::Gp(8)),
                "r9" | "r9d" => Some(R::Gp(9)),
                "r10" | "r10d" | "r11" | "r11d" => {
                    // The emitters stage spills and asm operands through
                    // r10 / r11; a binding there cannot be honored.
                    return Err(self.compile_err(format!(
                        "register `{n}` is reserved and cannot hold a register variable"
                    )));
                }
                "r12" | "r12d" => Some(R::Gp(12)),
                "r13" | "r13d" => Some(R::Gp(13)),
                "r14" | "r14d" => Some(R::Gp(14)),
                "r15" | "r15d" => Some(R::Gp(15)),
                _ => None,
            }
        };
        resolved.ok_or_else(|| {
            self.compile_err(format!(
                "`{n}` is not a bindable register for target {}",
                self.target.id_str()
            ))
        })
    }

    /// `__auto_type` (GCC): the declared variable takes its
    /// initializer's type. The declaration must be a single plain
    /// identifier declarator with an initializer. The initializer is
    /// pre-scanned unevaluated to recover its type, the lexer rewinds
    /// to the identifier, and the declaration then parses normally
    /// under the recovered base type. Array initializers decay to a
    /// pointer, matching the value-context decay `typeof` applies.
    pub(super) fn parse_auto_type_specifier(&mut self) -> Result<i64, C5Error> {
        self.next()?; // __auto_type
        if self.lex.tk != Token::Id {
            return Err(self.compile_err("`__auto_type` requires a plain identifier declarator"));
        }
        let snap = self.lex.snapshot();
        self.next()?; // identifier
        if self.lex.tk != Token::Assign {
            return Err(self.compile_err("`__auto_type` declaration requires an initializer"));
        }
        self.next()?; // =
        if self.lex.tk == '{' {
            return Err(self.compile_err("`__auto_type` initializer must be a single expression"));
        }
        let ty = self.parse_unevaluated_expr_ty(false)?;
        // The initializer decayed any array to a pointer; the declared
        // variable is that pointer, never an array.
        self.pending.typeof_operand_was_array = false;
        self.pending.auto_type_single_declarator = true;
        self.lex.restore(snap);
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
        always_inline: &mut bool,
        naked: &mut bool,
        weak: &mut bool,
        used: &mut bool,
    ) {
        // The bare `noreturn` spelling lexes as the <stdnoreturn.h>
        // keyword token, not an identifier; both name this attribute.
        if self.lex.tk == Token::Noreturn {
            *noreturn = true;
            return;
        }
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
            } else if n == "always_inline" || n == "__always_inline__" {
                // GNU `always_inline`: a mandatory inline request. Recorded so
                // the inliner can warn when it cannot honor it.
                *always_inline = true;
            } else if n == "naked" || n == "__naked__" {
                // GNU `naked`: emit no prologue/epilogue; the body is the
                // function's entire machine code (inline asm). Used for
                // interrupt service routines that return via `iretq`/`eret`.
                *naked = true;
            } else if n == "weak" || n == "__weak__" {
                // GNU `weak`: the defined (or declared) symbol binds
                // STB_WEAK in the object's symbol table.
                *weak = true;
            } else if n == "used" || n == "__used__" {
                // GNU `used`: keep the definition in the object even when
                // nothing in the unit references it.
                *used = true;
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
    /// True when the cursor is at an attribute-specifier: a GNU/MSVC
    /// keyword (`__attribute__`, `__declspec`, `_Alignas`) or a C23
    /// `[[` sequence (6.7.13). `[[` is unambiguous -- no C99 declarator
    /// or expression begins with two adjacent `[` -- so peeking one byte
    /// past the current `[` suffices.
    pub(super) fn at_attribute_specifier(&self) -> bool {
        self.lex.tk == Token::Attribute
            || (self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'['))
    }

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
        let mut always_inline = false;
        let mut naked = false;
        let mut weak = false;
        let mut used = false;
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
                        let is_section = self.lex.tk == Token::Id
                            && matches!(
                                self.symbols[self.lex.curr_id_idx].name.as_str(),
                                "section" | "__section__"
                            );
                        let is_alias = self.lex.tk == Token::Id
                            && matches!(
                                self.symbols[self.lex.curr_id_idx].name.as_str(),
                                "alias" | "__alias__"
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
                            &mut always_inline,
                            &mut naked,
                            &mut weak,
                            &mut used,
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
                        } else if is_section && self.lex.tk == '(' {
                            // GCC `section("name")`: place the declared
                            // symbol's bytes in the named object section.
                            self.next()?; // `(`
                            let name = self.parse_attribute_string_operand("section")?;
                            self.pending.attr_section = Some(name);
                            if self.lex.tk != ')' {
                                return Err(
                                    self.compile_err("`)` expected after `section` operand")
                                );
                            }
                            self.next()?;
                        } else if is_alias && self.lex.tk == '(' {
                            // GCC `alias("target")`: the declared name is an
                            // additional symbol for `target`, which must be
                            // defined in this unit.
                            self.next()?; // `(`
                            let name = self.parse_attribute_string_operand("alias")?;
                            self.pending.attr_alias = Some(name);
                            if self.lex.tk != ')' {
                                return Err(self.compile_err("`)` expected after `alias` operand"));
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
                            &mut always_inline,
                            &mut naked,
                            &mut weak,
                            &mut used,
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
        if packed {
            self.pending.attr_packed = true;
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
        if always_inline {
            // A mandatory inline request implies `inline`.
            self.pending_is_inline = true;
            self.pending_is_always_inline = true;
        }
        if naked {
            self.pending_is_naked = true;
        }
        if let Some(p) = init_priority {
            self.pending.attr_init_priority = Some(p);
        }
        if weak {
            self.pending.attr_weak = true;
        }
        if used {
            self.pending.attr_used = true;
        }
        Ok(packed)
    }

    /// Parse the string-literal operand of an attribute whose payload
    /// is `("...")`. The current token is the opening `"`; on return
    /// the cursor is at the token after the literal. Adjacent literals
    /// concatenate (C99 5.1.1.2 phase 6).
    fn parse_attribute_string_operand(
        &mut self,
        attr: &str,
    ) -> Result<alloc::string::String, C5Error> {
        if self.lex.tk != '"' {
            return Err(self.compile_err(format!("`{attr}` operand must be a string literal")));
        }
        let start = self.lex.ival as usize;
        self.next()?;
        while self.lex.tk == '"' {
            self.next()?;
        }
        let mut bytes = self.data[start..].to_vec();
        self.data.truncate(start);
        while bytes.last() == Some(&0) {
            bytes.pop();
        }
        Ok(alloc::string::String::from_utf8_lossy(&bytes).into_owned())
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

    /// True when the current token is the `register` storage class.
    pub(super) fn lex_is_register_storage(&self) -> bool {
        self.lex.tk == Token::FuncSpec && self.symbols[self.lex.curr_id_idx].name == "register"
    }

    /// True when the current token is the `const` type qualifier.
    pub(super) fn lex_is_const_qual(&self) -> bool {
        self.lex.tk == Token::TypeQual
            && matches!(
                self.symbols[self.lex.curr_id_idx].name.as_str(),
                "const" | "__const" | "__const__"
            )
    }

    /// Fold a multi-dim typedef alias's dimension list onto the bound
    /// symbol, mirroring what a literal `T x[A][B]` declarator records.
    /// Callers gate on the same condition as the element-count fold
    /// (`typedef_base_array_size` consumed, declarator added no `*`s
    /// and no brackets of its own).
    pub(super) fn apply_typedef_array_dims(&mut self, idx: usize) {
        if self.pending.typedef_base_array_dims.len() >= 2 {
            let dims = self.pending.typedef_base_array_dims.clone();
            self.symbols[idx].inner_array_size = dims[1];
            self.symbols[idx].array_dims = dims;
        }
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
            if self.lex.tk == Token::Inline || self.lex.tk == Token::ForceInline {
                self.pending_is_inline = true;
                if self.lex.tk == Token::ForceInline {
                    self.pending_is_always_inline = true;
                }
            }
            if self.lex.tk == Token::Noreturn {
                self.pending_noreturn = true;
            }
            if self.lex_is_register_storage() {
                self.pending.saw_register_storage = true;
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
        if self.lex.tk == Token::AutoType {
            return self.parse_auto_type_specifier();
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
            let tag = self.lex_int128_tag(m.saw_unsigned);
            self.next()?;
            tag
        } else if self.is_lex_va_list_spelling() {
            // GCC `__builtin_va_list`: the target's `va_list`
            // representation, usable with no header.
            self.next()?;
            self.builtin_va_list_tag()
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
                self.pending.typedef_base_array_dims =
                    self.symbols[self.lex.curr_id_idx].array_dims.clone();
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
            } else if m.saw_unsigned && self.is_int128_ty(bt) {
                // Trailing modifier form `__int128 unsigned`.
                bt |= UNSIGNED_BIT;
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
            if self.lex.tk == Token::Inline || self.lex.tk == Token::ForceInline {
                self.pending_is_inline = true;
                if self.lex.tk == Token::ForceInline {
                    self.pending_is_always_inline = true;
                }
            }
            if self.lex.tk == Token::Noreturn {
                self.pending_noreturn = true;
            }
            if self.lex_is_register_storage() {
                self.pending.saw_register_storage = true;
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
