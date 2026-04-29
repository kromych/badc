/// Virtual Machine Operations (Opcodes)
/// These represent the low-level instructions executed by the VM.
#[repr(i64)]
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
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
    /// Syscall: Copy memory block from src to dst.
    Mcpy,
    /// Syscall: Terminate program with exit code
    Exit,
    /// Syscall: Write a buffer to a file descriptor (fd 1=stdout, 2=stderr).
    Write,
    /// Syscall: Read an environment variable into the data segment.
    Genv,
    /// Syscall: Set an environment variable.
    Senv,
    /// Syscall: `dlopen(path, flags)` -- load a shared library at
    /// runtime. Returns an opaque handle (or 0 on failure). In VM
    /// mode the handle is a real native pointer; calling through it
    /// via `Op::Jsri` is rejected (no FFI from the VM).
    Dlop,
    /// Syscall: `dlsym(handle, name)` -- look up a symbol in a loaded
    /// library. Returns a function pointer (or 0 on miss). Native
    /// binaries can call the result through `Op::Jsri`; VM mode can
    /// only inspect it.
    Dlsm,
    /// Syscall: `dlclose(handle)` -- unload a previously dlopen'd
    /// library. Returns 0 on success, non-zero on failure.
    Dlcl,
    /// Syscall: `dlerror()` -- return the most recent dynamic-loader
    /// error message as a C string, or 0 if none. The returned
    /// pointer is valid until the next dlerror call (POSIX).
    Dler,

    // --- Immediate-form arithmetic / comparison ---
    //
    // Each takes one operand `N`. They fuse the common `Psh; Imm N; <op>`
    // sequence emitted for `<expr> <op> <constant>` patterns into a
    // single dispatch -- `a = a <op> N`. The optimizer pass produces them;
    // the compiler never emits them directly.
    /// `a = a + N`
    AddI,
    /// `a = a - N`
    SubI,
    /// `a = a * N`
    MulI,
    /// `a = a & N`
    AndI,
    /// `a = a | N`
    OrI,
    /// `a = a ^ N`
    XorI,
    /// `a = a << N`
    ShlI,
    /// `a = a >> N`
    ShrI,
    /// `a = (a == N) as i64`
    EqI,
    /// `a = (a != N) as i64`
    NeI,
    /// `a = (a < N) as i64`
    LtI,
    /// `a = (a > N) as i64`
    GtI,
    /// `a = (a <= N) as i64`
    LeI,
    /// `a = (a >= N) as i64`
    GeI,

    // --- Load-local fusion ---
    /// `a = *(i64*)(bp + N*8)` -- fused `Lea N; Li`.
    LdLocI,
    /// `a = *(u8*)(bp + N*8)` -- fused `Lea N; Lc`.
    LdLocC,
}

const OPS: [Op; 64] = [
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
    Op::Mcpy,
    Op::Exit,
    Op::Write,
    Op::Genv,
    Op::Senv,
    Op::Dlop,
    Op::Dlsm,
    Op::Dlcl,
    Op::Dler,
    // Immediate-form ops (optimizer-emitted).
    Op::AddI,
    Op::SubI,
    Op::MulI,
    Op::AndI,
    Op::OrI,
    Op::XorI,
    Op::ShlI,
    Op::ShrI,
    Op::EqI,
    Op::NeI,
    Op::LtI,
    Op::GtI,
    Op::LeI,
    Op::GeI,
    Op::LdLocI,
    Op::LdLocC,
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
