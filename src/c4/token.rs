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
}

/// Primitive Types
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Ty {
    /// 8-bit character
    Char = 0,
    /// 64-bit signed integer
    Int = 1,
    /// Pointer type (values > 1 represent pointer depth)
    Ptr = 2,
}
