/// Virtual Machine Operations (Opcodes)
/// These represent the low-level instructions executed by the VM.
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Op {
    /// Load Effective Address: Calculates address of a local variable.
    Lea = 0x7f00_0000_0000_0001,
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
    /// Syscall: Write a buffer to a file descriptor (fd 1=stdout, 2=stderr).
    Write,
    /// Syscall: Read an environment variable into the data segment.
    Genv,
    /// Syscall: Set an environment variable.
    Senv,
}

const OPS: [Op; 43] = [
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
    Op::Write,
    Op::Genv,
    Op::Senv,
];

impl Op {
    pub fn from_i64(val: i64) -> Option<Self> {
        // Opcodes carry a non-zero discriminant base so that legitimate
        // operand values (PCs, immediates, stack slot counts) can never be
        // mistaken for an instruction. Translate back into the OPS index.
        let base = Op::Lea as i64;
        let idx = val.checked_sub(base)?;
        if (0..OPS.len() as i64).contains(&idx) {
            Some(OPS[idx as usize])
        } else {
            None
        }
    }
}
