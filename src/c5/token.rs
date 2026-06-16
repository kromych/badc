/// Runtime token identity as stored by the lexer.
///
/// C lexing has to mix two namespaces in the same scalar slot:
///   * ASCII punctuation (`(`, `;`, `{`, ...) is its own byte
///     value -- enumerating each of the 128 ASCII bytes inside
///     [`Token`] would dwarf the meaningful keyword / operator
///     variants.
///   * Multi-character keywords and operators get explicit
///     discriminants starting at 128 (just past ASCII), encoded
///     in the [`Token`] enum.
///
/// `Tok` wraps the underlying `i64` so that call sites can write
/// `lex.tk == Token::MulOp` (without an `as i64`) and
/// `lex.tk == '('` (without an `as i64`) -- the `PartialEq`
/// impls below route both shapes through a single integer
/// comparison. `lex.tk.raw()` recovers the i64 for diagnostics
/// and the few places that need the bit pattern directly
/// (token-id tables, the describe() pretty-printer).
#[derive(Copy, Clone, PartialEq, Eq, Debug, Hash, Default)]
pub(crate) struct Tok(pub i64);

impl Tok {
    /// Sentinel for end-of-input. The lexer sets this when the
    /// source is exhausted; comparisons against `Tok::EOF` mirror
    /// `lex.tk == 0` but read more clearly.
    pub const EOF: Tok = Tok(0);

    /// Raw i64 for callers that genuinely need the bit pattern
    /// (the diagnostic pretty-printer, hash-table keys, etc.).
    pub const fn raw(self) -> i64 {
        self.0
    }
}

impl From<Token> for Tok {
    fn from(t: Token) -> Self {
        Tok(t as i64)
    }
}

impl PartialEq<Token> for Tok {
    fn eq(&self, other: &Token) -> bool {
        self.0 == *other as i64
    }
}

impl PartialEq<char> for Tok {
    fn eq(&self, other: &char) -> bool {
        self.0 == *other as i64
    }
}

impl PartialEq<u8> for Tok {
    fn eq(&self, other: &u8) -> bool {
        self.0 == *other as i64
    }
}

impl PartialEq<i64> for Tok {
    fn eq(&self, other: &i64) -> bool {
        self.0 == *other
    }
}

impl PartialEq<i32> for Tok {
    fn eq(&self, other: &i32) -> bool {
        self.0 == *other as i64
    }
}

impl PartialOrd<i64> for Tok {
    fn partial_cmp(&self, other: &i64) -> Option<core::cmp::Ordering> {
        self.0.partial_cmp(other)
    }
}

impl core::fmt::Display for Tok {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        self.0.fmt(f)
    }
}

/// Lexical Tokens
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Token {
    /// Numeric literal
    Num = 128,
    /// Function definition/declaration
    Fun,
    /// System call / Library function
    Sys,
    /// Global variable
    Glo,
    /// Local variable
    Loc,
    /// Identifier (variable or function name)
    Id,
    /// 'char' keyword
    Char,
    /// 'else' keyword
    Else,
    /// 'enum' keyword
    Enum,
    /// 'for' keyword
    For,
    /// 'if' keyword
    If,
    /// 'int' keyword
    Int,
    /// 'return' keyword
    Return,
    /// 'sizeof' keyword
    Sizeof,
    /// '_Alignof' keyword (C11 6.5.3.4), and its `__alignof__` /
    /// `__alignof` GCC spellings.
    Alignof,
    /// 'while' keyword
    While,
    /// Assignment '='
    Assign,
    /// Compound assignment: `+=`, `-=`, `*=`, `/=`, `%=`, `&=`,
    /// `|=`, `^=`, `<<=`, `>>=`. The underlying binary operator
    /// (Token::AddOp / Token::SubOp / etc.) is stored in
    /// `lex.ival` so this single token slot serves all ten forms
    /// without shifting the rest of the enum's precedence levels.
    /// Sits right after `Assign` so the Pratt-loop precedence
    /// comparison (`tk >= lev`) treats compound-assigns at the
    /// same level as `=`.
    AssignOp,
    /// Ternary conditional '?'
    Cond,
    /// Logical OR '||'
    Lor,
    /// Logical AND '&&'
    Lan,
    /// Bitwise OR '|'
    OrOp,
    /// Bitwise XOR '^'
    XorOp,
    /// Bitwise AND '&'
    AndOp,
    /// Equality '=='
    EqOp,
    /// Inequality '!='
    NeOp,
    /// Less than '<'
    LtOp,
    /// Greater than '>'
    GtOp,
    LeOp,
    /// Greater than or equal '>='
    GeOp,
    /// Shift left '<<'
    ShlOp,
    /// Shift right '>>'
    ShrOp,
    /// Addition '+'
    AddOp,
    /// Subtraction '-'
    SubOp,
    /// Multiplication '*'
    MulOp,
    /// Division '/'
    DivOp,
    /// Modulo '%'
    ModOp,
    /// Increment '++'
    Inc,
    /// Decrement '--'
    Dec,
    /// Array bracket '['
    Brak,
    Do,
    Break,
    Continue,
    Goto,
    Switch,
    Case,
    Default,
    /// `struct` keyword.
    Struct,
    /// `->` operator (struct pointer field access).
    Arrow,
    /// `...` -- variadic-function marker in parameter lists.
    Ellipsis,
    /// `.` operator (struct value field access). Mirror of
    /// `Token::Arrow` but the LHS is the struct's address rather
    /// than a struct pointer, so the lowering skips the implicit
    /// load of the pointer slot.
    Dot,
    /// `_Thread_local` storage-class specifier (C11). Marks the
    /// following global as having per-thread storage. Lowering
    /// uses `mrs x0, tpidr_el0` on aarch64 and `mov rax, %fs:0`
    /// on x86_64 to recover the thread-local block base; the
    /// post-link target writers (ELF .tdata/.tbss, PE TLS
    /// directory, Mach-O __thread_*) place the symbol within
    /// the runtime block.
    ThreadLocal,
    /// `extern` keyword. Accepted as a no-op storage-class
    /// prefix in declarations (global, function, parameter,
    /// local). c5 doesn't have separate translation units yet
    /// -- there's nothing to "declare without defining" --
    /// but mainstream C headers and code routinely use the
    /// keyword, so consuming it lets unmodified C compile
    /// cleanly. The byte semantics are identical to the
    /// no-prefix form: `extern int x;` allocates a global the
    /// same way `int x;` does.
    Extern,
    /// `static` keyword. Like [`Self::Extern`], accepted as a
    /// no-op prefix in declarations. C's `static` at file
    /// scope means "internal linkage", which c5 already gives
    /// every symbol (we don't expose any externally), so
    /// the keyword is a documentation hint rather than a
    /// behavior change. `static` on a local would mean
    /// "function-scope storage-duration = static" but c5
    /// only supports automatic locals; the keyword is still
    /// consumed and the local stays automatic, matching the
    /// extern handling.
    Static,
    /// Type qualifier (`const`, `volatile`, `restrict`). All
    /// three collapse to one token because c5 has no
    /// const-correctness checking and treats memory accesses
    /// as already non-cacheable; the keywords are consumed
    /// wherever a type qualifier may appear (base-type prefix,
    /// after `*` in a declarator, after `*` in a parameter)
    /// and have no semantic effect. Recognizing them at the
    /// lexer level lets unmodified C headers tokenize.
    TypeQual,
    /// Integer-type modifier (`short`, `_Bool`). `int` is a
    /// 32-bit type, so these collapse onto plain `int` (32-bit
    /// signed). The token is consumed
    /// before, around, or instead of the base-type token; if a
    /// declaration is `unsigned x;` (no `int`), the parser still
    /// emits an `int` declaration. Programs that rely on the
    /// signed/unsigned distinction at the bit level still narrow
    /// uniformly to a 32-bit slot. The remaining IntMod tokens
    /// today are `_Bool` (which c5 maps to int) -- `short` was
    /// promoted to its own [`Token::Short`] so it can drive the
    /// 16-bit `Ty::Short` storage class.
    IntMod,
    /// `short` modifier -- a real 2-byte width specifier. Drives
    /// `parse_decl_base_type` to pick `Ty::Short` rather than
    /// `Ty::Int`, so `short` declarations get a 2-byte slot,
    /// `LoadKind::I16` / `StoreKind::I16` for memory access, and
    /// proper sign / zero extension on load. `unsigned short`
    /// ORs in `UNSIGNED_BIT` and switches the load to
    /// `LoadKind::U16`.
    Short,
    /// `signed` modifier -- separated from the rest of [`IntMod`]
    /// because c5 needs to know specifically when `signed` was
    /// applied to a `char` base. A bare `char` collapses to a
    /// 1-byte unsigned slot, but `signed char` is a real signed
    /// 8-bit type the C standard guarantees holds -128..127. We
    /// promote `signed char` to `int` so the values load sign-
    /// extended; otherwise a `signed char` field set to `-1`
    /// reads back as `255` and any consumer that uses it as an
    /// array index (or a length, or a flag) walks into garbage.
    Signed,
    /// `unsigned` modifier -- separated from [`IntMod`] so the
    /// parser can mark the resulting integer type as unsigned.
    /// `unsigned int x;` and `unsigned long y;` and `typedef
    /// unsigned int u32;` all flow through `parse_decl_base_type`
    /// where the `saw_unsigned` flag ORs `UNSIGNED_BIT` into the
    /// chosen base type. Comparisons later check the bit and
    /// pick `BinOp::Ult/Ugt/Ule/Uge` over their signed twins.
    /// Without it, an unsigned 32-bit value compared against a
    /// high-bit-set constant like `0xFFFFFFFE` reads as signed
    /// `-2` and the comparison's sign goes the wrong way.
    Unsigned,
    /// `long` modifier -- separated from [`IntMod`] because seeing
    /// `long` on a declaration's base type drives the 64-bit
    /// `Ty::Long` selection (vs. the 32-bit `Ty::Int` that bare
    /// `int` produces). `long long` parses by entering this branch
    /// twice in a row; both spellings yield `Ty::Long` so 64-bit-
    /// storage code stays portable across C platforms.
    Long,
    /// Function specifier (`register`, `auto`, `_Noreturn`,
    /// `noreturn`). Consumed as a no-op anywhere a storage class
    /// may appear. `auto` is the C default, `register` is a
    /// historical hint, `_Noreturn` is a hint to optimisers about
    /// non-returning calls.
    FuncSpec,
    /// `inline` / `__inline` / `__inline__` (C99 6.7.4). Tracked
    /// distinctly from the no-op specifiers so the parser can
    /// flag the function symbol for the SSA inliner, which
    /// bypasses the body-size cap for inline-marked callees.
    Inline,
    /// `_Noreturn` / `noreturn` (C11 6.7.4). Tracked distinctly so
    /// the parser can flag the function symbol; the reachability
    /// analysis treats a call to a `_Noreturn` function as not
    /// reaching its continuation, which suppresses the
    /// fall-off-the-end diagnostic on a caller whose last statement
    /// is such a call.
    Noreturn,
    /// `_Atomic` (C11 6.7.2.4 / 6.7.3). Two forms: the type
    /// specifier `_Atomic ( type-name )` and the type qualifier
    /// `_Atomic` preceding a type. c5 does not model atomicity, so
    /// both reduce to the unqualified inner type; a distinct token
    /// is needed only so the parser can recognize the parenthesized
    /// specifier (the qualifier form is consumed like `const`).
    Atomic,
    /// `asm` / `__asm__` / `__asm` (GCC inline assembly statement).
    /// c5 supports the operand-free forms: an empty template (a
    /// compiler barrier, no instruction) and a single known
    /// operand-free hint instruction (`pause` / `yield`). Operand
    /// constraints and other instructions are rejected.
    Asm,
    /// `typedef` keyword. Drives the typedef parser: when seen
    /// at the start of a declaration, the declarator's name is
    /// registered as a *type alias* whose underlying type is
    /// the parsed declaration's type. The alias is consumed at
    /// every type-start position by checking the symbol's
    /// class for `Token::Typedef`. Unlike `extern`/`static`,
    /// `typedef` has real semantic effect -- it's not a
    /// no-op; a single token slot just keeps the parser path
    /// uniform.
    Typedef,
    /// `union` keyword. Parsed and stored in the same struct
    /// table as `struct`; the only difference is layout (all
    /// members at offset 0; total size = max(member sizes)).
    /// Member access uses the same field-resolution path as a
    /// struct since each field already records its offset and
    /// the union's just gives them all offset 0.
    Union,
    /// `float` keyword -- 32-bit IEEE float type.
    Float,
    /// `double` keyword -- 64-bit IEEE double type.
    Double,
    /// Floating-point numeric literal (`1.5`, `1e10`, `.5`, `1.0f`).
    /// The lexer stores the parsed `f64` bit pattern in `ival`; the
    /// parser plucks it back out via `f64::from_bits(ival as u64)`.
    FloatNum,
    /// `_Static_assert` keyword (C11 6.7.10) and the C23 alias
    /// `static_assert`. Followed by `( <const-int-expr>,
    /// "<string-literal>" )` at declaration position. The parser
    /// folds the constant expression; if it's zero, the message
    /// is surfaced through the standard compile-error path,
    /// otherwise the construct is a parse-time no-op.
    StaticAssert,
    /// `void` keyword. A distinct lexeme so a bare `void` return
    /// type or `(void)` parameter list can be told apart from a
    /// `char` of the same width. The type encoding stays
    /// `Ty::Char | UNSIGNED_BIT` for both spellings (so `void *`
    /// arithmetic, sizeof, struct-field layout, and function-
    /// pointer encoding behave identically to a previous `void
    /// = char` desugaring); the void-vs-char distinction is
    /// carried out-of-band by
    /// [`super::compiler::Compiler::pending_base_was_void`] and
    /// [`super::symbol::Symbol::returns_void`]. The earlier
    /// attempt to add a `Ty::Void` band collided with the
    /// function-pointer slot encoding C99 6.7.6.3 requires for
    /// `void (*)(...)` members of dispatch-table structs;
    /// keeping the encoding untouched and carrying void-ness on
    /// the side avoids that collision.
    Void,
    /// `typeof` (C23 6.7.2.5) and its GCC `__typeof__` / `__typeof`
    /// spellings: a type specifier naming the type of a parenthesized
    /// type-name or unevaluated expression operand. Added at the end of
    /// the enum so the operator variants keep their precedence-ordinal
    /// values.
    Typeof,
    /// Marker for `__attribute__((packed))` (and `__packed__`). The
    /// preprocessor rewrites a `packed` attribute to a reserved
    /// identifier the aggregate parser consumes to lay the struct out
    /// without inter-member padding; every other `__attribute__` payload
    /// is still dropped. Added at the end so the operator ordinals are
    /// unchanged.
    Packed,
}

/// Map a token-id (the value stored in `lex.tk` as i64) back to a
/// human-readable spelling for diagnostics. ASCII tokens (`(`,
/// `;`, `{` etc.) render as a quoted single character; the
/// keyword / operator / classifier tokens render under the
/// canonical name. Returns an owned `String` so callers don't
/// have to worry about the storage of the ASCII branch's
/// formatted glyph.
pub(crate) fn describe(tk: Tok) -> alloc::string::String {
    use alloc::format;
    use alloc::string::ToString;
    let tk = tk.raw();
    if tk == 0 {
        return "end of file".to_string();
    }
    if (0..128).contains(&tk) {
        let c = tk as u8 as char;
        if c.is_ascii_graphic() || c == ' ' {
            return format!("`{}`", c);
        }
        return format!("byte {tk:#x}");
    }
    let name = match tk {
        x if x == Token::Num as i64 => "integer literal",
        x if x == Token::Fun as i64 => "function identifier",
        x if x == Token::Sys as i64 => "libc binding",
        x if x == Token::Glo as i64 => "global identifier",
        x if x == Token::Loc as i64 => "local identifier",
        x if x == Token::Id as i64 => "identifier",
        x if x == Token::Char as i64 => "`char`",
        x if x == Token::Else as i64 => "`else`",
        x if x == Token::Enum as i64 => "`enum`",
        x if x == Token::For as i64 => "`for`",
        x if x == Token::If as i64 => "`if`",
        x if x == Token::Int as i64 => "`int`",
        x if x == Token::Return as i64 => "`return`",
        x if x == Token::Sizeof as i64 => "`sizeof`",
        x if x == Token::Alignof as i64 => "`_Alignof`",
        x if x == Token::While as i64 => "`while`",
        x if x == Token::Assign as i64 => "`=`",
        x if x == Token::AssignOp as i64 => "compound-assign (`+=` / `-=` / ...)",
        x if x == Token::Cond as i64 => "`?`",
        x if x == Token::Lor as i64 => "`||`",
        x if x == Token::Lan as i64 => "`&&`",
        x if x == Token::OrOp as i64 => "`|`",
        x if x == Token::XorOp as i64 => "`^`",
        x if x == Token::AndOp as i64 => "`&`",
        x if x == Token::EqOp as i64 => "`==`",
        x if x == Token::NeOp as i64 => "`!=`",
        x if x == Token::LtOp as i64 => "`<`",
        x if x == Token::GtOp as i64 => "`>`",
        x if x == Token::LeOp as i64 => "`<=`",
        x if x == Token::GeOp as i64 => "`>=`",
        x if x == Token::ShlOp as i64 => "`<<`",
        x if x == Token::ShrOp as i64 => "`>>`",
        x if x == Token::AddOp as i64 => "`+`",
        x if x == Token::SubOp as i64 => "`-`",
        x if x == Token::Atomic as i64 => "`_Atomic`",
        x if x == Token::Asm as i64 => "`asm`",
        x if x == Token::MulOp as i64 => "`*`",
        x if x == Token::DivOp as i64 => "`/`",
        x if x == Token::ModOp as i64 => "`%`",
        x if x == Token::Inc as i64 => "`++`",
        x if x == Token::Dec as i64 => "`--`",
        x if x == Token::Brak as i64 => "`[`",
        x if x == Token::Do as i64 => "`do`",
        x if x == Token::Break as i64 => "`break`",
        x if x == Token::Continue as i64 => "`continue`",
        x if x == Token::Goto as i64 => "`goto`",
        x if x == Token::Switch as i64 => "`switch`",
        x if x == Token::Case as i64 => "`case`",
        x if x == Token::Default as i64 => "`default`",
        x if x == Token::Struct as i64 => "`struct`",
        x if x == Token::Arrow as i64 => "`->`",
        x if x == Token::Ellipsis as i64 => "`...`",
        x if x == Token::Dot as i64 => "`.`",
        x if x == Token::ThreadLocal as i64 => "`_Thread_local`",
        x if x == Token::Extern as i64 => "`extern`",
        x if x == Token::Static as i64 => "`static`",
        x if x == Token::TypeQual as i64 => "type qualifier (`const` / `volatile` / `restrict`)",
        x if x == Token::IntMod as i64 => "integer-type modifier",
        x if x == Token::Short as i64 => "`short`",
        x if x == Token::Signed as i64 => "`signed`",
        x if x == Token::Unsigned as i64 => "`unsigned`",
        x if x == Token::Long as i64 => "`long`",
        x if x == Token::FuncSpec as i64 => "function specifier (`inline` / `register` / `auto`)",
        x if x == Token::Typedef as i64 => "`typedef`",
        x if x == Token::Union as i64 => "`union`",
        x if x == Token::Float as i64 => "`float`",
        x if x == Token::Double as i64 => "`double`",
        x if x == Token::FloatNum as i64 => "floating-point literal",
        x if x == Token::StaticAssert as i64 => "`static_assert` / `_Static_assert`",
        x if x == Token::Void as i64 => "`void`",
        _ => return format!("token id {tk}"),
    };
    name.to_string()
}

/// Primitive Types
///
/// The integer-family encoding is:
///   `char` = 0, `int` = 1; pointers add `Ty::Ptr` (= 2) per `*`
///   level, so `int*` = 3, `char**` = 4, `int**` = 5, etc. Pointer
///   levels share the low band `[0, 100)`.
///
/// Floating types live in their own non-overlapping bands so that
/// the existing `>= Ty::Ptr` arithmetic in the integer family stays
/// correct -- the per-band base + 2-per-`*` scheme is reused inside
/// each band:
///   `float`   = 100, `float*`   = 102, `float**`   = 104, ...
///   `double`  = 200, `double*`  = 202, `double**`  = 204, ...
///   `long`    = 300, `long*`    = 302, `long**`    = 304, ...   (M31)
///
/// Struct types still start at `STRUCT_BASE` (1000) and follow the
/// 1000-stride scheme in `compiler.rs`. Float and long bands sit
/// between the integer-family and the struct-family ranges so
/// neither bumps into them, and the helper predicates in
/// `compiler.rs` (`is_float_ty`, `is_double_ty`, `is_long_ty`,
/// `is_pointer_ty`) classify a `ty` without callers needing to
/// know the encoding.
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Ty {
    /// 8-bit character
    Char = 0,
    /// 32-bit signed integer (M31). Was 64-bit until widths landed;
    /// callers that want a guaranteed 64-bit slot should use `long`
    /// (== `Ty::Long`).
    Int = 1,
    /// Pointer type (values > 1 represent pointer depth)
    Ptr = 2,
    /// 32-bit IEEE float (scalar). `float*` = 102, etc.
    Float = 100,
    /// 64-bit IEEE double (scalar). `double*` = 202, etc.
    Double = 200,
    /// Per-target signed integer for `long`. LP64 (Linux / macOS):
    /// 8 bytes. LLP64 (Windows): 4 bytes. The `Compiler::target`
    /// switches the load / store / size at each access site;
    /// `Ty::Long` is the *type* tag, not a width commitment.
    /// `long*` = 302, `long**` = 304, etc.
    Long = 300,
    /// 16-bit signed integer. Distinct from `int` so `short` is a
    /// real 2-byte storage slot (not just an "int that the lexer
    /// tolerated"). `short*` = 402, `short**` = 404, etc. Sits in
    /// its own band [400, 500) leaving 50 pointer levels.
    Short = 400,
    /// 64-bit signed integer for `long long`. Always 8 bytes,
    /// regardless of target. Distinct from `Ty::Long` so the
    /// LP64-vs-LLP64 width split flows through cleanly:
    /// `long long` is the spelling that always means "64-bit
    /// integer" in real C, and c5 keeps the same guarantee.
    /// `long long*` = 502, `long long**` = 504, etc.
    LongLong = 500,
    /// C99 `_Bool` (6.2.5p2): a 1-byte unsigned integer type that
    /// holds only 0 or 1. Distinct from `unsigned char` so the
    /// conversion sites can apply the 6.3.1.2 normalisation
    /// (any nonzero scalar becomes 1) that a plain `unsigned char`
    /// store must not. Sits in its own band [600, 700); the same
    /// +2-per-`*` scheme applies, so `_Bool*` = 602, `_Bool**` =
    /// 604, etc.
    Bool = 600,
}
