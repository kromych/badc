use std::collections::HashMap;
use std::fmt;
use std::fs::File;

pub mod codegen;
pub mod parser;
pub mod vm;

#[cfg(test)]
mod tests;

#[derive(Debug, Clone)]
pub enum C4Error {
    Compile(String),
    Runtime(String),
}

impl fmt::Display for C4Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            C4Error::Compile(msg) => write!(f, "Compile Error: {}", msg),
            C4Error::Runtime(msg) => write!(f, "Runtime Error: {}", msg),
        }
    }
}

impl std::error::Error for C4Error {}

/// Virtual Machine Operations (Opcodes)
/// These represent the low-level instructions executed by the VM.
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Op {
    /// Load Effective Address: Calculates address of a local variable.
    Lea = 0,
    /// Load Immediate: Loads a constant value into the accumulator.
    Imm,
    /// Jump: Unconditional jump to a specific text address.
    Jmp,
    /// Jump to Subroutine: Pushes return address and jumps.
    Jsr,
    /// Jump to Subroutine indirect.
    Jsri,
    /// Branch if Zero: Jumps if the accumulator is 0.
    Bz,
    /// Branch if Not Zero: Jumps if the accumulator is not 0.
    Bnz,
    /// Enter Subroutine: Sets up the stack frame for a new function.
    Ent,
    /// Adjust Stack: Cleans up arguments from the stack after a call.
    Adj,
    /// Leave Subroutine: Restores previous stack frame and returns.
    Lev,
    /// Load Integer: Loads an i64 from the address in the accumulator.
    Li,
    /// Load Character: Loads a u8 from the address in the accumulator.
    Lc,
    /// Store Integer: Stores the accumulator into the address on top of stack.
    Si,
    /// Store Character: Stores the lower byte of accumulator into address on stack.
    Sc,
    /// Push: Pushes the accumulator onto the stack.
    Psh,
    /// Bitwise OR
    Or,
    /// Bitwise XOR
    Xor,
    /// Bitwise AND
    And,
    /// Equality `==`
    Eq,
    /// Inequality `!=`
    Ne,
    /// Less Than `<`
    Lt,
    /// Greater Than `>`
    Gt,
    /// Less Than or Equal `<=`
    Le,
    /// Greater Than or Equal `>=`
    Ge,
    /// Shift Left `<<`
    Shl,
    /// Shift Right `>>`
    Shr,
    /// Addition `+`
    Add,
    /// Subtraction `-`
    Sub,
    /// Multiplication `*`
    Mul,
    /// Division `/`
    Div,
    /// Modulo `%`
    Mod,
    /// Syscall: Open a file
    Open,
    /// Syscall: Read from a file descriptor
    Read,
    /// Syscall: Close a file descriptor
    Clos,
    /// Syscall: Formatted print to stdout
    Prtf,
    /// Syscall: Dynamic memory allocation
    Malc,
    /// Syscall: Deallocate memory
    Free,
    /// Syscall: Set memory block to value
    Mset,
    /// Syscall: Compare memory blocks
    Mcmp,
    /// Syscall: Terminate program with exit code
    Exit,
}

const OPS: [Op; 40] = [
    Op::Lea,
    Op::Imm,
    Op::Jmp,
    Op::Jsr,
    Op::Jsri,
    Op::Bz,
    Op::Bnz,
    Op::Ent,
    Op::Adj,
    Op::Lev,
    Op::Li,
    Op::Lc,
    Op::Si,
    Op::Sc,
    Op::Psh,
    Op::Or,
    Op::Xor,
    Op::And,
    Op::Eq,
    Op::Ne,
    Op::Lt,
    Op::Gt,
    Op::Le,
    Op::Ge,
    Op::Shl,
    Op::Shr,
    Op::Add,
    Op::Sub,
    Op::Mul,
    Op::Div,
    Op::Mod,
    Op::Open,
    Op::Read,
    Op::Clos,
    Op::Prtf,
    Op::Malc,
    Op::Free,
    Op::Mset,
    Op::Mcmp,
    Op::Exit,
];

impl Op {
    pub fn from_i64(val: i64) -> Option<Self> {
        if val >= 0 && val < OPS.len() as i64 {
            Some(OPS[val as usize])
        } else {
            None
        }
    }
}

/// Lexical Tokens
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Token {
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
pub enum Ty {
    /// 8-bit character
    Char = 0,
    /// 64-bit signed integer
    Int = 1,
    /// Pointer type (values > 1 represent pointer depth)
    Ptr = 2,
}

pub(crate) const STACK_CAPACITY: usize = 256 * 1024;
pub(crate) const STACK_BASE: usize = 0x1000_0000;

#[derive(Clone, Debug, Default)]
pub struct Symbol {
    pub name: String,
    pub hash: i64,
    pub token: i64,
    pub class: i64,
    pub type_: i64,
    pub val: i64,
    pub h_class: i64,
    pub h_type: i64,
    pub h_val: i64,
}

pub struct C4 {
    // --- Source / lexer state ---
    pub(crate) src: Vec<u8>,
    pub(crate) src_pos: usize,
    pub(crate) line: usize,
    pub(crate) tk: i64,
    pub(crate) ival: i64,
    pub(crate) ty: i64,
    pub(crate) curr_id_idx: usize,

    // --- Symbol table ---
    pub symbols: Vec<Symbol>,

    // --- Code generation state ---
    pub text: Vec<i64>,
    pub data: Vec<u8>,
    pub(crate) loc_offs: i64,
    pub(crate) loop_breaks: Vec<Vec<usize>>,
    pub(crate) loop_continues: Vec<Vec<usize>>,
    pub(crate) labels: HashMap<String, usize>,
    pub(crate) unresolved_gotos: Vec<(String, usize)>,
    pub(crate) switch_cases: Vec<Vec<(i64, usize)>>,
    pub(crate) switch_defaults: Vec<Option<usize>>,

    // --- VM runtime state ---
    pub(crate) stack: Vec<i64>,
    pub(crate) fd_table: HashMap<i64, File>,
    pub(crate) next_fd: i64,
    pub(crate) debug: bool,
}

impl C4 {
    pub fn new(source: String, debug: bool) -> Self {
        let mut vm = C4 {
            src: source.into_bytes(),
            src_pos: 0,
            debug,
            text: Vec::new(),
            data: Vec::new(),
            stack: vec![0; STACK_CAPACITY],
            symbols: Vec::new(),
            fd_table: HashMap::new(),
            next_fd: 3,
            curr_id_idx: 0,
            tk: 0,
            ival: 0,
            ty: 0,
            line: 1,
            loc_offs: 0,
            loop_breaks: Vec::new(),
            loop_continues: Vec::new(),
            labels: HashMap::new(),
            unresolved_gotos: Vec::new(),
            switch_cases: Vec::new(),
            switch_defaults: Vec::new(),
        };
        vm.init_symbols();
        vm
    }
}
