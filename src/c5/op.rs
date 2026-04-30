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
    /// External library call. Followed by one operand: the index
    /// (into the program's flattened `#pragma binding(...)` table)
    /// of the binding to call. Args are already on the VM stack
    /// (in 16-byte slots, as for a regular `Jsri`); the trailing
    /// `Op::Adj N` after the call gives the runtime / lowering the
    /// arg count to drop.
    ///
    /// Replaces the old per-symbol `Op::Open` / `Op::Prtf` / ... set:
    /// the lexer no longer carries a fixed table of libc names,
    /// each header's `#pragma binding` fills the table dynamically,
    /// and a call site lowers the same way regardless of which
    /// dylib's symbol is on the other end.
    JsrExt,
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

const OPS: [Op; 48] = [
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
    Op::JsrExt,
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

    /// Number of operand i64 words that follow this op in the
    /// bytecode. Single source of truth -- every bytecode walker
    /// (the optimizer's decode pass, the regalloc analyzer, the
    /// codegen lowering, the import resolver, the disassembler)
    /// reads its operand-skip count from here. Adding a new
    /// operand-bearing op only requires an entry in this match.
    pub fn operand_count(self) -> usize {
        use Op::*;
        match self {
            // Single-operand ops: control flow, frame setup, libc
            // dispatch, and the optimizer's immediate-form
            // arithmetic / comparison ops.
            Lea | Imm | Jmp | Jsr | Bz | Bnz | Ent | Adj | JsrExt | AddI | SubI | MulI | AndI
            | OrI | XorI | ShlI | ShrI | EqI | NeI | LtI | GtI | LeI | GeI | LdLocI | LdLocC => 1,
            // Everything else -- arithmetic, loads/stores, push,
            // indirect-jump, return, etc. -- is encoded in a
            // single word with no operand.
            _ => 0,
        }
    }

    /// Total i64 words this op occupies in the bytecode (op + its
    /// operand). `1 + operand_count()`.
    pub fn word_size(self) -> usize {
        1 + self.operand_count()
    }
}
