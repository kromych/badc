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
