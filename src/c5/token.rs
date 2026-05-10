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
    /// following global as having per-thread storage. Recognised
    /// at the parser surface; the codegen still emits a clean
    /// "not yet implemented" error -- ELF .tdata/.tbss + PE TLS
    /// directory + Mach-O __thread_* sections are a future
    /// milestone (the codegen lowering needs `mrs x0, tpidr_el0`
    /// on aarch64 and `mov rax, %fs:0` on x86_64 plus the
    /// per-target dyld initializer).
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
    /// `Op::Lh` / `Op::Sh` for memory access, and proper sign /
    /// zero extension on load. `unsigned short` ORs in
    /// `UNSIGNED_BIT` and switches the load to `Op::Lhu`.
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
    /// pick `Op::Ult/Ugt/Ule/Uge` over their signed twins.
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
    /// Function specifier (`inline`, `register`, `auto`).
    /// Consumed as a no-op anywhere a storage class may
    /// appear. `auto` is the C default, `register` is a
    /// historical hint, `inline` is something a real
    /// optimizer would honour -- c5 ignores all three.
    FuncSpec,
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
}
