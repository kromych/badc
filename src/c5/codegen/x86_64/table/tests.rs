//! Tests for the table-driven x86-64 encoder.
//!
//! The golden cases run everywhere and lock exact encodings. The differential
//! sweep and the seeded fuzzer cross-check the catalogue against the system
//! assembler; both are gated on `BADC_FUZZ_ASM=1` and the presence of
//! `clang` + `objdump`, so a bare `cargo test` skips them.

use super::*;

fn enc(mnem: &str, ops: &[Opnd]) -> Vec<u8> {
    let m = Mnem::from_name(mnem).unwrap_or_else(|| panic!("no such mnemonic `{mnem}`"));
    encode(m, None, ops).unwrap_or_else(|e| panic!("{mnem}: {e}"))
}

fn r(num: u8, width: u8) -> Opnd {
    Opnd::Reg { num, width }
}
fn m(base: u8, width: u8) -> Opnd {
    Opnd::Mem {
        base,
        index: None,
        scale: 1,
        disp: 0,
        width,
    }
}
fn md(base: u8, disp: i32, width: u8) -> Opnd {
    Opnd::Mem {
        base,
        index: None,
        scale: 1,
        disp,
        width,
    }
}
fn msib(base: u8, index: u8, scale: u8, disp: i32, width: u8) -> Opnd {
    Opnd::Mem {
        base,
        index: Some(index),
        scale,
        disp,
        width,
    }
}
fn mrip(disp: i32, width: u8) -> Opnd {
    Opnd::RipRel { disp, width }
}

#[test]
fn alu_reg_reg_widths() {
    // add: 8/16/32/64-bit register-to-register, low and high registers.
    assert_eq!(enc("add", &[r(0, 1), r(3, 1)]), [0x00, 0xd8]); // add al, bl
    assert_eq!(enc("add", &[r(0, 2), r(3, 2)]), [0x66, 0x01, 0xd8]); // add ax, bx
    assert_eq!(enc("add", &[r(0, 4), r(3, 4)]), [0x01, 0xd8]); // add eax, ebx
    assert_eq!(enc("add", &[r(0, 8), r(3, 8)]), [0x48, 0x01, 0xd8]); // add rax, rbx
    assert_eq!(enc("add", &[r(0, 8), r(8, 8)]), [0x4c, 0x01, 0xc0]); // add rax, r8
    assert_eq!(enc("add", &[r(8, 8), r(0, 8)]), [0x49, 0x01, 0xc0]); // add r8, rax
    // the byte-register REX for sil/dil.
    assert_eq!(enc("add", &[r(6, 1), r(7, 1)]), [0x40, 0x00, 0xfe]); // add sil, dil
}

#[test]
fn alu_reg_mem_and_imm() {
    // load / store direction picks 03 (RM) vs 01 (MR).
    assert_eq!(enc("add", &[r(0, 8), m(6, 8)]), [0x48, 0x03, 0x06]); // add rax, [rsi]
    assert_eq!(enc("add", &[m(6, 8), r(0, 8)]), [0x48, 0x01, 0x06]); // add [rsi], rax
    // imm8 sign-extended form (83 /0) vs imm32 form (81 /0) by value range.
    assert_eq!(
        enc("add", &[r(0, 8), Opnd::Imm(7)]),
        [0x48, 0x83, 0xc0, 0x07]
    );
    // rax + imm32: the accumulator form (05 id, 6 bytes) is shorter than the
    // 81 /0 id form (7 bytes), so shortest-wins picks it (as the assembler does).
    assert_eq!(
        enc("add", &[r(0, 8), Opnd::Imm(0x1234)]),
        [0x48, 0x05, 0x34, 0x12, 0x00, 0x00]
    );
    // a non-accumulator destination has no short form: 81 /0 id.
    assert_eq!(
        enc("add", &[r(3, 8), Opnd::Imm(0x1234)]),
        [0x48, 0x81, 0xc3, 0x34, 0x12, 0x00, 0x00]
    );
    // sub uses /5; the extension digit rides ModRM.reg.
    assert_eq!(enc("sub", &[r(1, 4), Opnd::Imm(3)]), [0x83, 0xe9, 0x03]); // sub ecx, 3
}

#[test]
fn shifts_and_unary() {
    // shl r/m, imm8 (C1 /4); shl r/m, 1 (D1 /4); shl r/m, cl (D3 /4).
    assert_eq!(
        enc("shl", &[r(0, 8), Opnd::Imm(3)]),
        [0x48, 0xc1, 0xe0, 0x03]
    );
    assert_eq!(enc("shl", &[r(0, 8), r(1, 1)]), [0x48, 0xd3, 0xe0]); // shl rax, cl
    assert_eq!(enc("neg", &[r(2, 4)]), [0xf7, 0xda]); // neg edx
    assert_eq!(enc("bswap", &[r(0, 8)]), [0x48, 0x0f, 0xc8]); // bswap rax
    assert_eq!(enc("bswap", &[r(8, 4)]), [0x41, 0x0f, 0xc8]); // bswap r8d
}

#[test]
fn atomics_and_system() {
    // xadd / cmpxchg into memory (the lock prefix is emitted separately).
    assert_eq!(enc("xadd", &[m(7, 8), r(0, 8)]), [0x48, 0x0f, 0xc1, 0x07]);
    assert_eq!(enc("cmpxchg", &[m(7, 4), r(1, 4)]), [0x0f, 0xb1, 0x0f]);
    // nullary system ops.
    assert_eq!(enc("rdtsc", &[]), [0x0f, 0x31]);
    assert_eq!(enc("rdtscp", &[]), [0x0f, 0x01, 0xf9]);
    assert_eq!(enc("cli", &[]), [0xfa]);
    assert_eq!(enc("hlt", &[]), [0xf4]);
    assert_eq!(enc("cpuid", &[]), [0x0f, 0xa2]);
}

#[test]
fn double_precision_and_ext_moves() {
    // movzx / movsx keep the source and destination widths distinct.
    assert_eq!(enc("movzx", &[r(1, 8), m(2, 1)]), [0x48, 0x0f, 0xb6, 0x0a]); // movzx rcx, byte [rdx]
    assert_eq!(enc("movsxd", &[r(0, 8), r(1, 4)]), [0x48, 0x63, 0xc1]); // movsxd rax, ecx
    // A byte source of spl/bpl/sil/dil takes a REX even though the operation
    // width is that of the wider destination; without it the encoding names
    // ah/ch/dh/bh instead.
    assert_eq!(enc("movsx", &[r(4, 4), r(7, 1)]), [0x40, 0x0f, 0xbe, 0xe7]); // movsx esp, dil
    assert_eq!(
        enc("movzx", &[r(3, 2), r(5, 1)]),
        [0x66, 0x40, 0x0f, 0xb6, 0xdd]
    ); // movzx bx, bpl
    assert_eq!(enc("movsx", &[r(4, 4), r(3, 1)]), [0x0f, 0xbe, 0xe3]); // movsx esp, bl: no REX
}

#[test]
fn setcc_byte_forms() {
    // 0F 90+cc /0 with an r/m8 operand; the reg field is a zero extension.
    // High byte registers (sil, r10b) take the REX / REX.B prefix, verified
    // byte-identical to the assembler.
    assert_eq!(enc("sete", &[r(0, 1)]), [0x0f, 0x94, 0xc0]); // sete al
    assert_eq!(enc("setne", &[r(3, 1)]), [0x0f, 0x95, 0xc3]); // setne bl
    assert_eq!(enc("setl", &[r(1, 1)]), [0x0f, 0x9c, 0xc1]); // setl cl
    assert_eq!(enc("setg", &[r(2, 1)]), [0x0f, 0x9f, 0xc2]); // setg dl
    assert_eq!(enc("seta", &[r(6, 1)]), [0x40, 0x0f, 0x97, 0xc6]); // seta sil
    assert_eq!(enc("setbe", &[r(10, 1)]), [0x41, 0x0f, 0x96, 0xc2]); // setbe r10b
    // An alias spelling encodes identically to its canonical form.
    assert_eq!(enc("setz", &[r(0, 1)]), enc("sete", &[r(0, 1)]));
    assert_eq!(enc("setnge", &[r(0, 1)]), enc("setl", &[r(0, 1)]));
}

#[test]
fn cmov_forms() {
    // 0F 40+cc /r: reg is the destination, r/m the source, width from the
    // operands. Verified byte-identical to the assembler.
    assert_eq!(enc("cmove", &[r(0, 8), r(6, 8)]), [0x48, 0x0f, 0x44, 0xc6]); // cmove rax, rsi
    assert_eq!(enc("cmovl", &[r(2, 4), r(1, 4)]), [0x0f, 0x4c, 0xd1]); // cmovl edx, ecx
    assert_eq!(enc("cmovg", &[r(9, 8), r(8, 8)]), [0x4d, 0x0f, 0x4f, 0xc8]); // cmovg r9, r8
    // Alias spellings match their canonical condition.
    assert_eq!(
        enc("cmovnle", &[r(0, 8), r(1, 8)]),
        enc("cmovg", &[r(0, 8), r(1, 8)])
    );
    assert_eq!(
        enc("cmovz", &[r(0, 8), r(1, 8)]),
        enc("cmove", &[r(0, 8), r(1, 8)])
    );
}

#[test]
fn accumulator_extend_and_fences() {
    // Accumulator sign-extends: the 64-bit forms carry REX.W on a nullary
    // opcode. AT&T spellings alias the Intel ones.
    assert_eq!(enc("cwde", &[]), [0x98]);
    assert_eq!(enc("cdqe", &[]), [0x48, 0x98]);
    assert_eq!(enc("cdq", &[]), [0x99]);
    assert_eq!(enc("cqo", &[]), [0x48, 0x99]);
    assert_eq!(enc("cltq", &[]), enc("cdqe", &[]));
    assert_eq!(enc("cqto", &[]), enc("cqo", &[]));
    // Fences carry their full second opcode byte.
    assert_eq!(enc("lfence", &[]), [0x0f, 0xae, 0xe8]);
    assert_eq!(enc("mfence", &[]), [0x0f, 0xae, 0xf0]);
    assert_eq!(enc("sfence", &[]), [0x0f, 0xae, 0xf8]);
}

#[test]
fn system_and_rng_ops() {
    // Nullary system opcodes, including the three-byte 0F 01 group and the
    // REX.W iretq.
    assert_eq!(enc("syscall", &[]), [0x0f, 0x05]);
    assert_eq!(enc("sysret", &[]), [0x0f, 0x07]);
    assert_eq!(enc("swapgs", &[]), [0x0f, 0x01, 0xf8]);
    assert_eq!(enc("clts", &[]), [0x0f, 0x06]);
    assert_eq!(enc("ud2", &[]), [0x0f, 0x0b]);
    assert_eq!(enc("lahf", &[]), [0x9f]);
    assert_eq!(enc("sahf", &[]), [0x9e]);
    assert_eq!(enc("xgetbv", &[]), [0x0f, 0x01, 0xd0]);
    assert_eq!(enc("iretq", &[]), [0x48, 0xcf]);
    // rdrand / rdseed take the register in r/m (reg field is the extension);
    // movnti stores a register to memory (MR).
    assert_eq!(enc("rdrand", &[r(0, 4)]), [0x0f, 0xc7, 0xf0]); // rdrand eax
    assert_eq!(enc("rdseed", &[r(0, 8)]), [0x48, 0x0f, 0xc7, 0xf8]); // rdseed rax
    assert_eq!(enc("movnti", &[m(6, 4), r(0, 4)]), [0x0f, 0xc3, 0x06]); // movnti [rsi], eax
}

#[test]
fn sizeless_memory_ops() {
    // No operand-size prefix regardless of the operand's declared width; the
    // reg field is the opcode extension. fxsave64 carries REX.W.
    assert_eq!(enc("clflush", &[m(0, 8)]), [0x0f, 0xae, 0x38]); // clflush [rax] (/7)
    assert_eq!(enc("clflush", &[m(0, 2)]), [0x0f, 0xae, 0x38]); // width irrelevant, no 66
    assert_eq!(enc("prefetcht0", &[m(0, 8)]), [0x0f, 0x18, 0x08]); // /1
    assert_eq!(enc("prefetchw", &[m(0, 8)]), [0x0f, 0x0d, 0x08]); // 0F 0D /1
    assert_eq!(enc("fxsave", &[m(0, 8)]), [0x0f, 0xae, 0x00]); // /0
    assert_eq!(enc("fxsave64", &[m(0, 8)]), [0x48, 0x0f, 0xae, 0x00]); // REX.W /0
    assert_eq!(enc("lgdt", &[m(0, 8)]), [0x0f, 0x01, 0x10]); // /2
    assert_eq!(enc("sidt", &[m(0, 8)]), [0x0f, 0x01, 0x08]); // /1
}

#[test]
fn memory_displacement() {
    // mov r64, [base + disp] across the mod-field and special-base cases.
    assert_eq!(enc("mov", &[r(1, 8), md(0, 0, 8)]), [0x48, 0x8b, 0x08]); // [rax]
    assert_eq!(
        enc("mov", &[r(1, 8), md(0, 8, 8)]),
        [0x48, 0x8b, 0x48, 0x08]
    ); // [rax+8] disp8
    assert_eq!(
        enc("mov", &[r(1, 8), md(0, 0x1000, 8)]),
        [0x48, 0x8b, 0x88, 0x00, 0x10, 0x00, 0x00]
    ); // [rax+0x1000] disp32
    assert_eq!(
        enc("mov", &[r(1, 8), md(5, 0, 8)]),
        [0x48, 0x8b, 0x4d, 0x00]
    ); // [rbp] forced disp8=0
    assert_eq!(
        enc("mov", &[r(1, 8), md(5, -4, 8)]),
        [0x48, 0x8b, 0x4d, 0xfc]
    ); // [rbp-4]
    assert_eq!(
        enc("mov", &[r(1, 8), md(4, 16, 8)]),
        [0x48, 0x8b, 0x4c, 0x24, 0x10]
    ); // [rsp+16] SIB
    assert_eq!(
        enc("mov", &[r(1, 8), md(13, 8, 8)]),
        [0x49, 0x8b, 0x4d, 0x08]
    ); // [r13+8] REX.B
}

#[test]
fn memory_sib() {
    // base + scaled index (+ disp): the SIB byte packs scale / index / base.
    assert_eq!(
        enc("mov", &[r(1, 8), msib(0, 3, 4, 0, 8)]),
        [0x48, 0x8b, 0x0c, 0x98]
    ); // [rax+rbx*4]
    assert_eq!(
        enc("mov", &[r(1, 8), msib(0, 3, 4, 8, 8)]),
        [0x48, 0x8b, 0x4c, 0x98, 0x08]
    ); // [rax+rbx*4+8]
    assert_eq!(
        enc("mov", &[r(1, 8), msib(8, 9, 8, 0, 8)]),
        [0x4b, 0x8b, 0x0c, 0xc8]
    ); // [r8+r9*8] REX.X/B
    assert_eq!(
        enc("mov", &[r(1, 8), msib(5, 0, 2, 0, 8)]),
        [0x48, 0x8b, 0x4c, 0x45, 0x00]
    ); // [rbp+rax*2] forced disp8=0
}

#[test]
fn memory_rip_relative() {
    // mod=00 rm=101 with a disp32: RIP-relative, no base/index, no REX.B.
    assert_eq!(
        enc("mov", &[r(1, 8), mrip(8, 8)]),
        [0x48, 0x8b, 0x0d, 0x08, 0x00, 0x00, 0x00]
    ); // mov rcx, [rip+8]
    assert_eq!(
        enc("lea", &[r(0, 8), mrip(-16, 8)]),
        [0x48, 0x8d, 0x05, 0xf0, 0xff, 0xff, 0xff]
    ); // lea rax, [rip-16]
    // A high destination register still takes REX.R; the base contributes no REX.B.
    assert_eq!(
        enc("mov", &[r(8, 8), mrip(0, 8)]),
        [0x4c, 0x8b, 0x05, 0x00, 0x00, 0x00, 0x00]
    ); // mov r8, [rip]
}

#[test]
fn widened_catalogue_encodings() {
    // Branch families: the Rel operand is the raw displacement (the asm
    // layer resolves labels); rel8 wins when the value fits, call has no
    // rel8 form. Register / memory indirect branches ride FF /2, /4.
    assert_eq!(enc("jmp", &[Opnd::Imm(-2)]), [0xeb, 0xfe]);
    assert_eq!(enc("je", &[Opnd::Imm(-2)]), [0x74, 0xfe]);
    assert_eq!(
        enc("jmp", &[Opnd::Imm(0x1000)]),
        [0xe9, 0x00, 0x10, 0x00, 0x00]
    );
    assert_eq!(
        enc("call", &[Opnd::Imm(-5)]),
        [0xe8, 0xfb, 0xff, 0xff, 0xff]
    );
    assert_eq!(enc("jmp", &[r(0, 8)]), [0xff, 0xe0]);
    assert_eq!(enc("call", &[r(0, 8)]), [0xff, 0xd0]);
    assert_eq!(enc("jmp", &[m(0, 8)]), [0xff, 0x20]);
    // Double-shifts: MR with the count in imm8 or cl.
    assert_eq!(
        enc("shld", &[r(0, 8), r(3, 8), Opnd::Imm(5)]),
        [0x48, 0x0f, 0xa4, 0xd8, 0x05]
    );
    assert_eq!(
        enc("shrd", &[r(0, 4), r(3, 4), r(1, 1)]),
        [0x0f, 0xad, 0xd8]
    );
    // 16-bit push/pop take the operand-size prefix; push imm encodes 6A/68
    // (the 66 68 iw pushw-immediate row is excluded as mandatory-66).
    assert_eq!(enc("push", &[r(1, 2)]), [0x66, 0x51]);
    assert_eq!(enc("pop", &[r(1, 2)]), [0x66, 0x59]);
    assert_eq!(enc("push", &[Opnd::Imm(7)]), [0x6a, 0x07]);
    assert_eq!(
        enc("push", &[Opnd::Imm(0x1234)]),
        [0x68, 0x34, 0x12, 0x00, 0x00]
    );
    // Fixed-16-bit system forms take no operand-size prefix (their width is
    // baked into the opcode); the width-group forms of str/sldt do.
    assert_eq!(enc("lldt", &[r(1, 2)]), [0x0f, 0x00, 0xd1]);
    assert_eq!(enc("ltr", &[r(1, 2)]), [0x0f, 0x00, 0xd9]);
    assert_eq!(enc("str", &[r(1, 2)]), [0x66, 0x0f, 0x00, 0xc9]);
    // in/out: fixed al/ax/eax and dx widths select the form, no prefix for
    // the byte form.
    assert_eq!(enc("in", &[r(0, 1), r(2, 2)]), [0xec]);
    assert_eq!(enc("in", &[r(0, 2), r(2, 2)]), [0x66, 0xed]);
    assert_eq!(enc("in", &[r(0, 4), r(2, 2)]), [0xed]);
    assert_eq!(enc("out", &[r(2, 2), r(0, 1)]), [0xee]);
    // movabs spells the 64-bit immediate mov.
    assert_eq!(
        enc("movabs", &[r(0, 8), Opnd::Imm(0x1122334455)]),
        [0x48, 0xb8, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00, 0x00, 0x00]
    );
    // bt-group immediate forms (0F BA /4../7).
    assert_eq!(
        enc("bt", &[r(0, 8), Opnd::Imm(5)]),
        [0x48, 0x0f, 0xba, 0xe0, 0x05]
    );
    assert_eq!(
        enc("btr", &[r(0, 4), Opnd::Imm(3)]),
        [0x0f, 0xba, 0xf0, 0x03]
    );
    // 16-bit accumulator xchg keeps the 90+r short form under the prefix;
    // the 32-bit self-exchange must use 87 /r (0x90 is NOP, which skips the
    // zero-extension), and cmpxchg8b takes no REX.W (that selects
    // cmpxchg16b).
    assert_eq!(enc("xchg", &[r(0, 2), r(3, 2)]), [0x66, 0x93]);
    assert_eq!(enc("xchg", &[r(0, 4), r(0, 4)]), [0x87, 0xc0]);
    assert_eq!(enc("cmpxchg8b", &[m(6, 8)]), [0x0f, 0xc7, 0x0e]);
    // Mandatory F2/F3/66 prefixes ride Form::pp, emitted after the derived
    // operand-size prefix and before REX, matching the assembler's order.
    assert_eq!(enc("pause", &[]), [0xf3, 0x90]);
    assert_eq!(
        enc("popcnt", &[r(0, 8), r(3, 8)]),
        [0xf3, 0x48, 0x0f, 0xb8, 0xc3]
    );
    assert_eq!(
        enc("popcnt", &[r(1, 2), r(2, 2)]),
        [0x66, 0xf3, 0x0f, 0xb8, 0xca]
    );
    assert_eq!(enc("lzcnt", &[r(0, 4), r(3, 4)]), [0xf3, 0x0f, 0xbd, 0xc3]);
    // 0F38-map forms: adcx carries a mandatory 66, movbe none.
    assert_eq!(
        enc("adcx", &[r(0, 8), r(3, 8)]),
        [0x66, 0x48, 0x0f, 0x38, 0xf6, 0xc3]
    );
    assert_eq!(enc("movbe", &[r(0, 4), m(6, 4)]), [0x0f, 0x38, 0xf0, 0x06]);
    // Immediates must fit their field; an out-of-range value falls through
    // to a wider form rather than truncating (push 0x1234 skips pushw's iw).
    assert!(
        encode(
            Mnem::from_name("bt").unwrap(),
            None,
            &[r(0, 8), Opnd::Imm(0x1234)]
        )
        .is_err()
    );
}

#[test]
fn catalogue_is_sorted() {
    // encode() binary-searches the catalogue by mnemonic, which is correct only
    // if the generator emitted it sorted. Lock the invariant.
    let forms = super::super::isa_x86_table::FORMS;
    assert!(
        forms.windows(2).all(|w| w[0].mnemonic <= w[1].mnemonic),
        "isa_x86_table::FORMS must be sorted by mnemonic"
    );
}

// ------------------------------------------------------------------
// Differential + fuzz harness against the system assembler.
// ------------------------------------------------------------------

#[cfg(feature = "std")]
mod differential {
    use super::super::*;
    use alloc::string::String;
    use alloc::vec::Vec;
    use std::process::Command;

    fn enabled() -> bool {
        std::env::var("BADC_FUZZ_ASM").is_ok()
            && Command::new("clang").arg("--version").output().is_ok()
            && Command::new("objdump").arg("--version").output().is_ok()
    }

    const REG64: &[&str] = &[
        "rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
        "r13", "r14", "r15",
    ];
    const REG32: &[&str] = &[
        "eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi", "r8d", "r9d", "r10d", "r11d",
        "r12d", "r13d", "r14d", "r15d",
    ];
    const REG16: &[&str] = &[
        "ax", "cx", "dx", "bx", "sp", "bp", "si", "di", "r8w", "r9w", "r10w", "r11w", "r12w",
        "r13w", "r14w", "r15w",
    ];
    const REG8: &[&str] = &[
        "al", "cl", "dl", "bl", "spl", "bpl", "sil", "dil", "r8b", "r9b", "r10b", "r11b", "r12b",
        "r13b", "r14b", "r15b",
    ];

    fn rname(num: u8, width: u8) -> &'static str {
        match width {
            1 => REG8[num as usize],
            2 => REG16[num as usize],
            4 => REG32[num as usize],
            _ => REG64[num as usize],
        }
    }

    fn intel(mnem: &str, ops: &[Opnd]) -> String {
        let mut parts = Vec::new();
        for o in ops {
            parts.push(match *o {
                Opnd::Reg { num, width } => String::from(rname(num, width)),
                Opnd::Mem {
                    base,
                    index,
                    scale,
                    disp,
                    width,
                } => {
                    let sz = match width {
                        1 => "byte",
                        2 => "word",
                        4 => "dword",
                        _ => "qword",
                    };
                    let b = REG64[base as usize];
                    let idx = match index {
                        Some(i) => alloc::format!(" + {}*{scale}", REG64[i as usize]),
                        None => String::new(),
                    };
                    if disp == 0 {
                        alloc::format!("{sz} ptr [{b}{idx}]")
                    } else {
                        let sign = if disp < 0 { "-" } else { "+" };
                        alloc::format!("{sz} ptr [{b}{idx} {sign} {}]", disp.unsigned_abs())
                    }
                }
                Opnd::RipRel { disp, width } => {
                    let sz = match width {
                        1 => "byte",
                        2 => "word",
                        4 => "dword",
                        _ => "qword",
                    };
                    let sign = if disp < 0 { "-" } else { "+" };
                    alloc::format!("{sz} ptr [rip {sign} {}]", disp.unsigned_abs())
                }
                Opnd::Imm(v) => alloc::format!("{v}"),
            });
        }
        if parts.is_empty() {
            String::from(mnem)
        } else {
            alloc::format!("{mnem} {}", parts.join(", "))
        }
    }

    /// A temp stem unique to this invocation. A content-derived name collides
    /// whenever two concurrent callers assemble the same text, which alias
    /// mnemonics guarantee (`sal r9b, cl` and `shl r9b, cl` are one encoding);
    /// the loser then reads a file the winner has already removed.
    fn temp_stem(prefix: &str) -> String {
        static SEQ: std::sync::atomic::AtomicU64 = std::sync::atomic::AtomicU64::new(0);
        let n = SEQ.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
        alloc::format!("badc-{prefix}-{}-{n}", std::process::id())
    }

    /// Assemble `src`, disassemble the result, and return the single
    /// normalized (mnemonic, operands) it decodes to. Errors carry the tool
    /// invocation and its output so a CI log is diagnosable on its own.
    fn assemble_and_decode(src: &str, prefix: &str) -> Result<(String, Vec<String>), String> {
        let dir = std::env::temp_dir();
        let stem = temp_stem(prefix);
        let s = dir.join(alloc::format!("{stem}.s"));
        let o = dir.join(alloc::format!("{stem}.o"));
        let clean = |s: &std::path::Path, o: &std::path::Path| {
            let _ = std::fs::remove_file(s);
            let _ = std::fs::remove_file(o);
        };
        std::fs::write(&s, src).map_err(|e| alloc::format!("write {}: {e}", s.display()))?;
        let asm_cmd = alloc::format!(
            "clang --target=x86_64-linux-gnu -c {} -o {}",
            s.display(),
            o.display()
        );
        let out = Command::new("clang")
            .args(["--target=x86_64-linux-gnu", "-c"])
            .arg(&s)
            .arg("-o")
            .arg(&o)
            .output()
            .map_err(|e| alloc::format!("spawn `{asm_cmd}`: {e}"))?;
        if !out.status.success() {
            clean(&s, &o);
            return Err(alloc::format!(
                "assemble failed ({}) `{asm_cmd}` src={src:?} stderr={:?}",
                out.status,
                String::from_utf8_lossy(&out.stderr).trim()
            ));
        }
        let dis_cmd = alloc::format!("objdump -d --no-show-raw-insn {}", o.display());
        let dis = Command::new("objdump")
            .args(["-d", "--no-show-raw-insn"])
            .arg(&o)
            .output()
            .map_err(|e| alloc::format!("spawn `{dis_cmd}`: {e}"))?;
        clean(&s, &o);
        let text = String::from_utf8_lossy(&dis.stdout);
        let mut insns: Vec<_> = text.lines().filter_map(insn_body).map(normalize).collect();
        if dis.status.success() && insns.len() == 1 {
            return Ok(insns.pop().unwrap());
        }
        Err(alloc::format!(
            "decoded to {} instructions ({}) `{dis_cmd}` src={src:?} stdout={:?} stderr={:?}",
            insns.len(),
            dis.status,
            text.trim(),
            String::from_utf8_lossy(&dis.stderr).trim()
        ))
    }

    /// Decode an encoder-produced byte string back to an instruction.
    fn disasm(bytes: &[u8]) -> Result<(String, Vec<String>), String> {
        let src = alloc::format!(
            ".text\n.byte {}\n",
            bytes
                .iter()
                .map(|b| alloc::format!("0x{b:02x}"))
                .collect::<Vec<_>>()
                .join(",")
        );
        assemble_and_decode(&src, "asm")
    }

    /// An objdump disassembly line begins with a whitespace-indented hex
    /// address followed by `:` then a tab. The file-format header
    /// (`obj.o:\tfile format ...`) also ends in `:` before a tab but has no
    /// leading indent and a non-hex label, so require both.
    fn insn_body(line: &str) -> Option<&str> {
        let tab = line.find('\t')?;
        let before = &line[..tab];
        if !before.starts_with(char::is_whitespace) {
            return None;
        }
        let addr = before.trim().strip_suffix(':')?;
        if addr.is_empty() || !addr.bytes().all(|b| b.is_ascii_hexdigit()) {
            return None;
        }
        Some(&line[tab + 1..])
    }

    /// Normalize an AT&T disassembly to (base-mnemonic, operand tokens) with
    /// size suffixes, immediate spelling, and `%`/`movabs`/`nop` aliasing
    /// folded out, so a legal-but-different form choice does not read as a
    /// mismatch.
    fn normalize(dis: &str) -> (String, Vec<String>) {
        let dis = dis.split('#').next().unwrap_or("").trim();
        let mut it = dis.splitn(2, char::is_whitespace);
        let mut mn = it.next().unwrap_or("").to_string();
        let rest = it.next().unwrap_or("").trim();
        if mn == "movabs" {
            mn = String::from("mov");
        }
        if mn == "nop" && rest.is_empty() {
            return (String::from("nop"), Vec::new());
        }
        // Drop a trailing AT&T size suffix (addq -> add) but keep movzbq-style
        // compound mnemonics distinct.
        if !matches!(mn.as_str(), "call" | "jmp")
            && mn.len() > 3
            && mn.ends_with(['b', 'w', 'l', 'q'])
            && !mn.starts_with("movz")
            && !mn.starts_with("movs")
        {
            mn.pop();
        }
        let mut ops = Vec::new();
        if !rest.is_empty() {
            for o in rest.split(',') {
                let o = o.trim();
                if o.starts_with('$') {
                    ops.push(String::from("IMM"));
                } else {
                    ops.push(o.replace('%', ""));
                }
            }
        }
        if mn == "xchg" {
            // 86/87 encodes either operand order; the assembler and the
            // catalogue may pick opposite reg/rm assignments of the same
            // exchange, so compare the operand multiset.
            ops.sort();
        }
        (mn, ops)
    }

    /// The instruction the assembler produces for a case, i.e. the intent the
    /// encoder must match. `None` means the assembler rejected the text, which
    /// the caller counts as a skip.
    fn clang_intent(itxt: &str) -> Option<(String, Vec<String>)> {
        let src = alloc::format!(".intel_syntax noprefix\n.text\n{itxt}\n");
        match assemble_and_decode(&src, "int") {
            Ok(v) => Some(v),
            Err(e) => {
                if std::env::var("BADC_FUZZ_DEBUG").is_ok() {
                    std::eprintln!("intent asm fail [{itxt}]: {e}");
                }
                None
            }
        }
    }

    /// Outcome tallies of a differential run. The contract is *never wrong,
    /// may be incomplete*: `bad` (the encoder produced bytes that decode to a
    /// different instruction than intended) is the hard failure; `gap` (the
    /// assembler accepts the instruction but the catalogue has no form for it)
    /// is reported, not fatal; `skip` is a case the assembler itself rejects.
    struct Tally {
        ok: usize,
        bad: usize,
        gap: usize,
        skip: usize,
        fails: Vec<String>,
        gaps: Vec<String>,
    }

    /// Assemble each case's intent, encode it through the table, disassemble
    /// the result, and require the two decode to the same instruction.
    fn check(cases: &[(&str, Vec<Opnd>)]) -> Tally {
        let mut t = Tally {
            ok: 0,
            bad: 0,
            gap: 0,
            skip: 0,
            fails: Vec::new(),
            gaps: Vec::new(),
        };
        for (mnem, ops) in cases {
            let itxt = intel(mnem, ops);
            let Some(intent) = clang_intent(&itxt) else {
                t.skip += 1;
                continue;
            };
            let Some(m) = Mnem::from_name(mnem) else {
                t.skip += 1;
                continue;
            };
            match encode(m, None, ops) {
                Ok(bytes) => match disasm(&bytes) {
                    Ok(got) if got == intent => t.ok += 1,
                    Ok(got) => {
                        t.bad += 1;
                        if t.fails.len() < 40 {
                            t.fails.push(alloc::format!(
                                "{itxt}: got {got:?} want {intent:?} bytes={}",
                                hex(&bytes)
                            ));
                        }
                    }
                    Err(e) => {
                        t.bad += 1;
                        t.fails
                            .push(alloc::format!("{itxt}: disasm {e} bytes={}", hex(&bytes)));
                    }
                },
                Err(_) => {
                    t.gap += 1;
                    if t.gaps.len() < 20 {
                        t.gaps.push(itxt);
                    }
                }
            }
        }
        t
    }

    fn hex(b: &[u8]) -> String {
        b.iter().map(|x| alloc::format!("{x:02x}")).collect()
    }

    fn r(num: u8, width: u8) -> Opnd {
        Opnd::Reg { num, width }
    }
    fn m(base: u8, width: u8) -> Opnd {
        Opnd::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            width,
        }
    }
    fn md(base: u8, disp: i32, width: u8) -> Opnd {
        Opnd::Mem {
            base,
            index: None,
            scale: 1,
            disp,
            width,
        }
    }
    fn msib(base: u8, index: u8, scale: u8, disp: i32, width: u8) -> Opnd {
        Opnd::Mem {
            base,
            index: Some(index),
            scale,
            disp,
            width,
        }
    }
    fn mrip(disp: i32, width: u8) -> Opnd {
        Opnd::RipRel { disp, width }
    }

    /// The operation widths a form's width classes admit: the `v` / `y`
    /// groups instantiate at each member width, fixed-width forms once.
    fn form_widths(f: &Form) -> &'static [u8] {
        let has = |w: W| {
            f.ops.iter().any(|&p| {
                matches!(p,
                    OpPat::Reg(x) | OpPat::Rm(x) | OpPat::Mem(x) | OpPat::Fixed(_, x) if x == w)
            })
        };
        if has(W::V) {
            &[2, 4, 8]
        } else if has(W::Y) {
            &[4, 8]
        } else {
            &[8]
        }
    }

    /// Effective operation width of an instantiation: the widest register /
    /// memory slot (what `op_width` will see). A byte-only form sits in the
    /// fixed-width bucket, so `opw` alone is not it.
    fn effective_width(f: &Form, opw: u8) -> u8 {
        f.ops
            .iter()
            .filter_map(|&p| match p {
                OpPat::Reg(w) | OpPat::Rm(w) | OpPat::Mem(w) | OpPat::Fixed(_, w) => wbytes(w, opw),
                _ => None,
            })
            .max()
            .unwrap_or(opw)
    }

    /// A random immediate that the effective operand width can express. An
    /// out-of-range value is not a catalogue gap: the encoder refuses to
    /// truncate (the assembler silently does), so drawing one only removes the
    /// case from coverage and inflates the gap tally.
    fn rnd_imm(eff: u8, raw: u64) -> Opnd {
        let span: i64 = match eff {
            1 => 0x100,
            2 => 0x10000,
            _ => 0x3000,
        };
        Opnd::Imm((raw % span as u64) as i64 - span / 2)
    }

    /// Synthesize differential cases for one form at one operation width.
    /// Each slot gets a small choice set (low / high registers, a register
    /// and a memory shape for r/m, a small and a wide immediate); the cases
    /// cycle the slots' choices index-aligned rather than taking the full
    /// cartesian product. `Rel` forms are skipped: their operand is a branch
    /// target at the assembler level but a raw displacement here, so the
    /// golden tests lock them instead.
    fn cases_for_form(f: &Form, opw: u8, out: &mut Vec<(&'static str, Vec<Opnd>)>) {
        let eff = effective_width(f, opw);
        let mut slots: Vec<Vec<Opnd>> = Vec::new();
        for &p in f.ops {
            let choices = match p {
                OpPat::Rel(_) => return,
                OpPat::Reg(w) => match wbytes(w, opw) {
                    Some(wb) => vec![r(3, wb), r(9, wb)],
                    None => return,
                },
                OpPat::Rm(w) => match wbytes(w, opw) {
                    Some(wb) => vec![r(3, wb), r(9, wb), m(6, wb)],
                    None => return,
                },
                OpPat::Mem(w) => match wbytes(w, opw) {
                    Some(wb) => vec![m(6, wb), md(13, 8, wb)],
                    None => return,
                },
                OpPat::MemAny => vec![m(6, 8), md(13, 8, 1)],
                OpPat::Fixed(n, w) => match wbytes(w, opw) {
                    Some(wb) => vec![r(n, wb)],
                    None => return,
                },
                OpPat::Imm(ImmC::One) => vec![Opnd::Imm(1)],
                OpPat::Imm(ImmC::Iq) => vec![Opnd::Imm(7), Opnd::Imm(0x1122334455)],
                // The wide value stays inside the effective width so a
                // byte-operand form is not asked for an unencodable case.
                OpPat::Imm(_) => vec![
                    Opnd::Imm(7),
                    Opnd::Imm(if eff == 1 { 0x45 } else { 0x2345 }),
                ],
            };
            slots.push(choices);
        }
        let n = slots.iter().map(Vec::len).max().unwrap_or(1);
        for k in 0..n {
            out.push((f.mnemonic, slots.iter().map(|c| c[k % c.len()]).collect()));
        }
    }

    /// Every catalogued form instantiated at every width it admits, deduped:
    /// the case list is derived from the table itself so a form added by the
    /// generator is fuzzed without touching this file.
    fn derived_cases() -> Vec<(&'static str, Vec<Opnd>)> {
        let mut cases: Vec<(&'static str, Vec<Opnd>)> = Vec::new();
        for f in super::super::super::isa_x86_table::FORMS {
            for &opw in form_widths(f) {
                cases_for_form(f, opw, &mut cases);
            }
        }
        let mut seen = std::collections::HashSet::new();
        cases.retain(|(m, ops)| seen.insert(alloc::format!("{m} {ops:?}")));
        cases
    }

    fn sweep_cases() -> Vec<(&'static str, Vec<Opnd>)> {
        let mut cases = derived_cases();
        // Base + displacement across the special bases (rbp/r13 forced disp8,
        // rsp/r12 SIB) and displacement sizes (zero, disp8, disp32, negative).
        for &(base, disp) in &[
            (0i32, 0i32),
            (0, 8),
            (0, 0x1000),
            (3, -4),
            (5, 0),
            (5, -128),
            (5, 0x2000),
            (4, 0),
            (4, 16),
            (12, 8),
            (13, 0),
            (13, 256),
        ] {
            let base = base as u8;
            for mnem in ["mov", "add", "cmp"] {
                cases.push((mnem, vec![r(1, 8), md(base, disp, 8)]));
                cases.push((mnem, vec![md(base, disp, 8), r(1, 8)]));
            }
        }
        // SIB: base + index*scale (+ disp). Index skips rsp (4), whose SIB slot
        // means "no index". The high registers exercise REX.X / REX.B.
        for &base in &[0u8, 3, 5, 8, 12, 13] {
            for &index in &[0u8, 3, 9, 13] {
                for &scale in &[1u8, 2, 4, 8] {
                    for &disp in &[0i32, 8, -4, 0x1000] {
                        cases.push(("mov", vec![r(1, 8), msib(base, index, scale, disp, 8)]));
                    }
                }
            }
        }
        // RIP-relative across destination registers and displacement signs.
        for &reg in &[0u8, 1, 8, 15] {
            for &disp in &[0i32, 8, -16, 0x1234] {
                cases.push(("mov", vec![r(reg, 8), mrip(disp, 8)]));
                cases.push(("lea", vec![r(reg, 8), mrip(disp, 8)]));
            }
        }
        cases
    }

    #[test]
    fn differential_sweep() {
        if !enabled() {
            return;
        }
        let t = check(&sweep_cases());
        for f in &t.fails {
            std::eprintln!("  FAIL {f}");
        }
        std::eprintln!(
            "differential_sweep: OK={} BAD={} GAP={} SKIP={}",
            t.ok,
            t.bad,
            t.gap,
            t.skip
        );
        // The sweep is derived from the catalogue, so it must be complete
        // (every case has a form) as well as correct.
        assert_eq!(t.bad, 0, "table encodings disagree with the assembler");
        assert_eq!(
            t.gap, 0,
            "sweep case not covered by the catalogue: {:?}",
            t.gaps
        );
    }

    /// Seeded deterministic fuzzer: draw a random catalogue form, a random
    /// admissible width, and random operands (registers, memory shapes with
    /// displacement / SIB / RIP-relative, immediates), and cross-check the
    /// encoding against the assembler. Form-driven, so a catalogue addition
    /// is fuzzed without touching this list.
    #[test]
    fn seeded_fuzz() {
        if !enabled() {
            return;
        }
        // `BADC_FUZZ_SEED` re-runs the same generator on a different draw; the
        // default keeps the case set reproducible.
        let mut st = match std::env::var("BADC_FUZZ_SEED") {
            Ok(v) => v.parse().unwrap_or(0x0123_4567_89ab_cdefu64).max(1),
            Err(_) => 0x0123_4567_89ab_cdefu64,
        };
        let mut next = || {
            st ^= st << 13;
            st ^= st >> 7;
            st ^= st << 17;
            st
        };
        let forms = super::super::super::isa_x86_table::FORMS;
        let mut cases: Vec<(&'static str, Vec<Opnd>)> = Vec::new();
        'draw: while cases.len() < 2000 {
            let f = &forms[(next() as usize) % forms.len()];
            let widths = form_widths(f);
            let opw = widths[(next() as usize) % widths.len()];
            let eff = effective_width(f, opw);
            let mut ops = Vec::new();
            for &p in f.ops {
                let rnd_mem = |wb: u8, next: &mut dyn FnMut() -> u64| -> Opnd {
                    let base = (next() as u8) & 15;
                    match next() % 4 {
                        0 => m(base, wb),
                        1 => md(base, (next() as i32 % 0x200) - 0x100, wb),
                        2 => {
                            // SIB index rsp (4) means "no index"; skip it.
                            let mut index = (next() as u8) & 15;
                            if index == 4 {
                                index = 5;
                            }
                            let scale = 1u8 << (next() % 4);
                            msib(base, index, scale, (next() as i32 % 0x100) - 0x80, wb)
                        }
                        _ => mrip((next() as i32 % 0x1000) - 0x800, wb),
                    }
                };
                let o = match p {
                    OpPat::Rel(_) => continue 'draw,
                    OpPat::Reg(w) => match wbytes(w, opw) {
                        Some(wb) => r((next() as u8) & 15, wb),
                        None => continue 'draw,
                    },
                    OpPat::Rm(w) => match wbytes(w, opw) {
                        Some(wb) => {
                            if next() % 2 == 0 {
                                r((next() as u8) & 15, wb)
                            } else {
                                rnd_mem(wb, &mut next)
                            }
                        }
                        None => continue 'draw,
                    },
                    OpPat::Mem(w) => match wbytes(w, opw) {
                        Some(wb) => rnd_mem(wb, &mut next),
                        None => continue 'draw,
                    },
                    OpPat::MemAny => rnd_mem(8, &mut next),
                    OpPat::Fixed(n, w) => match wbytes(w, opw) {
                        Some(wb) => r(n, wb),
                        None => continue 'draw,
                    },
                    OpPat::Imm(ImmC::One) => Opnd::Imm(1),
                    OpPat::Imm(_) => rnd_imm(eff, next()),
                };
                ops.push(o);
            }
            cases.push((f.mnemonic, ops));
        }
        let t = check(&cases);
        for f in t.fails.iter().take(30) {
            std::eprintln!("  FUZZ FAIL {f}");
        }
        std::eprintln!(
            "seeded_fuzz: OK={} BAD={} GAP={} SKIP={} (gaps e.g. {:?})",
            t.ok,
            t.bad,
            t.gap,
            t.skip,
            t.gaps.iter().take(3).collect::<Vec<_>>()
        );
        assert_eq!(
            t.bad, 0,
            "fuzzed table encodings disagree with the assembler"
        );
        // The generator draws catalogue forms with operands each form admits,
        // so every case must encode. A gap means the draw is unrepresentable
        // (it once fed out-of-range immediates to byte operands) or the
        // catalogue row is unreachable.
        assert_eq!(t.gap, 0, "fuzzed case not encodable: {:?}", t.gaps);
    }

    /// The differential tests run concurrently and alias mnemonics make them
    /// hand identical bytes to `disasm` (`sal r9b, cl` and `shl r9b, cl` are
    /// one encoding), so the helper must not share temp files between calls.
    #[test]
    fn concurrent_disasm_is_isolated() {
        if !enabled() {
            return;
        }
        assert_eq!(
            super::enc("sal", &[r(9, 1), r(1, 1)]),
            super::enc("shl", &[r(9, 1), r(1, 1)])
        );
        let bytes = super::enc("sal", &[r(9, 1), r(1, 1)]);
        let errs = std::sync::Arc::new(std::sync::Mutex::new(Vec::new()));
        let mut threads = Vec::new();
        for _ in 0..4 {
            let (bytes, errs) = (bytes.clone(), errs.clone());
            threads.push(std::thread::spawn(move || {
                for _ in 0..100 {
                    match disasm(&bytes) {
                        Ok((mn, _)) => assert_eq!(mn, "shl"),
                        Err(e) => errs.lock().unwrap().push(e),
                    }
                }
            }));
        }
        for t in threads {
            t.join().unwrap();
        }
        let errs = errs.lock().unwrap();
        assert!(
            errs.is_empty(),
            "{} of 400 concurrent disasm calls failed, e.g. {:?}",
            errs.len(),
            errs.first()
        );
    }
}
