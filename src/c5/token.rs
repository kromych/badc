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
    /// Integer-type modifier (`signed`, `unsigned`, `short`,
    /// `long`, `_Bool`). c5 has a single 64-bit integer
    /// representation, so all of these collapse onto plain
    /// `int`. The token is consumed before, around, or
    /// instead of the base-type token; if a declaration is
    /// `unsigned x;` (no `int`), the parser still emits an
    /// `int` declaration. `long long int` and `int long`
    /// equally parse to `int`. Severity-aware programs that
    /// rely on 32-bit overflow semantics will diverge -- see
    /// c99-gaps.md M31 for the eventual real-width plan.
    IntMod,
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
///
/// Struct types still start at `STRUCT_BASE` (1000) and follow the
/// 1000-stride scheme in `compiler.rs`. Float bands sit between the
/// integer-family and the struct-family ranges so neither bumps
/// into them, and the helper predicates in `compiler.rs`
/// (`is_float_ty`, `is_double_ty`, `is_pointer_ty`) classify a `ty`
/// without callers needing to know the encoding.
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Ty {
    /// 8-bit character
    Char = 0,
    /// 64-bit signed integer
    Int = 1,
    /// Pointer type (values > 1 represent pointer depth)
    Ptr = 2,
    /// 32-bit IEEE float (scalar). `float*` = 102, etc.
    Float = 100,
    /// 64-bit IEEE double (scalar). `double*` = 202, etc.
    Double = 200,
}
