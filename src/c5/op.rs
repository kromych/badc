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
    /// Load Word: Loads a 32-bit signed value from the address in the
    /// accumulator, sign-extending into the 64-bit accumulator. Used
    /// for `int` lvalue reads under M31's real-width regime where
    /// `int` is a 4-byte storage slot. Falls back to the 8-byte path
    /// while M31 is incomplete; emitted for `int`-typed reads once
    /// `size_of_type(Ty::Int) == 4` is in effect.
    Lw,
    /// Store Word: Stores the low 32 bits of the accumulator into the
    /// address on top of stack. Companion to [`Op::Lw`] for 4-byte
    /// `int` writes.
    Sw,
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
    /// `*(i64*)(bp + N*8) = a` -- store accumulator into a local
    /// frame slot at the given offset, without disturbing the c5
    /// stack or the accumulator. The compiler emits this when it
    /// needs to spill a freshly-computed value (e.g. an indirect
    /// call's function-pointer source) to a temp before the
    /// surrounding code clobbers `a`. The regular `Lea N; Si`
    /// pattern can't express this safely because `Lea` clobbers
    /// `a` first.
    StLocI,

    // --- Floating-point arithmetic and comparison ---
    //
    // Both `float` and `double` flow through the same f64 ops; the
    // c5 stack stores every FP value in a single 8-byte slot (the
    // 32-bit narrowing the C standard prescribes for `float` only
    // matters at FP-register ABI boundaries, which c5-internal
    // arithmetic never crosses). The accumulator and stack top
    // carry the `f64::to_bits()` representation so reads and writes
    // share the integer Li/Si paths; only the arithmetic dispatches
    // care about the bit-pattern interpretation.
    /// `a = (top + acc)` as f64. Pops top.
    Fadd,
    /// `a = (top - acc)` as f64. Pops top.
    Fsub,
    /// `a = (top * acc)` as f64. Pops top.
    Fmul,
    /// `a = (top / acc)` as f64. Pops top.
    Fdiv,
    /// `a = -acc` as f64.
    Fneg,
    /// `a = (top == acc) ? 1 : 0` as i64.
    Feq,
    /// `a = (top != acc) ? 1 : 0` as i64.
    Fne,
    /// `a = (top <  acc) ? 1 : 0` as i64.
    Flt,
    /// `a = (top >  acc) ? 1 : 0` as i64.
    Fgt,
    /// `a = (top <= acc) ? 1 : 0` as i64.
    Fle,
    /// `a = (top >= acc) ? 1 : 0` as i64.
    Fge,
    /// `a = (i64)(f64::from_bits(acc))` -- truncating float-to-int
    /// cast. Used by `(int)f` and by promotions before integer ops
    /// that take a float operand.
    Fcvtfi,
    /// `a = ((i64)acc as f64).to_bits()` -- int-to-float cast. Used
    /// by `(float)i` / `(double)i` and by integer-side operands of
    /// a mixed FP expression.
    Fcvtif,

    /// Memory copy. Operand: size in bytes (compile-time constant).
    /// Stack top: destination address. Accumulator: source address
    /// (the parser leaves it there because the RHS struct-value
    /// expression terminates with the address in `a`). Copies the
    /// given byte count from src to dst, then sets `a` to dst so
    /// the op behaves as `memcpy(dst, src, n)` does (returns dst).
    /// Used to lower whole-struct assignment without forcing the
    /// program to `#include <string.h>` and bind libc memcpy.
    Mcpy,

    /// Thread-Local Storage address load. Operand: byte offset
    /// within the TLS block of the variable being addressed. The
    /// codegen materialises the TLS-base + offset address into
    /// `a` using the platform's local-exec sequence:
    ///   * Linux/aarch64: `mrs x19, tpidr_el0; add x19, x19, imm`
    ///     (variant-1 layout: TLS sits AFTER the TCB head, so the
    ///     emitted offset is `TCB_HEAD + var_offset`).
    ///   * Linux/x86_64: `mov r13, qword ptr fs:[0]; sub r13, imm`
    ///     (variant-2 layout: TLS sits BEFORE the FS base, so the
    ///     emitted offset is `tls_total_size - var_offset`).
    ///   * macOS arm64 / Win64: not yet supported -- compile-time
    ///     reject in the writer's TLS-fixup application path.
    ///
    /// The VM allocates a per-Program TLS region and treats the
    /// op as a plain `Op::Imm tls_base + offset` (no real per-
    /// thread isolation; the VM is single-threaded).
    TlsLea,
}

const OPS: [Op; 66] = [
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
    Op::Lw,
    Op::Sw,
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
    Op::StLocI,
    // Floating-point arithmetic / comparison / casts.
    Op::Fadd,
    Op::Fsub,
    Op::Fmul,
    Op::Fdiv,
    Op::Fneg,
    Op::Feq,
    Op::Fne,
    Op::Flt,
    Op::Fgt,
    Op::Fle,
    Op::Fge,
    Op::Fcvtfi,
    Op::Fcvtif,
    Op::Mcpy,
    Op::TlsLea,
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
            | OrI | XorI | ShlI | ShrI | EqI | NeI | LtI | GtI | LeI | GeI | LdLocI | LdLocC
            | StLocI | Mcpy | TlsLea => 1,
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
