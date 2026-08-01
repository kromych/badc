//! Native-path linker tests.
//!
//! Each test compiles one or more inline sources to ELF64 ET_REL
//! through `emit_native_with_options`, recovers them with
//! `parse_native_elf`, and merges them with `link_native_objects`,
//! asserting on the resulting `MergedNative` (dead-code elimination,
//! `_Thread_local` layout, `#pragma export` / dylib routing) or on
//! the final image written by `write_native_image_from_merged`.

use super::TEST_PRELUDE;
use crate::c5::Compiler;

#[test]
fn transitively_dead_static_chain_is_dropped_from_object() {
    // A static helper `a` that calls another static `b`. Nothing
    // in the TU references `a`, so `a`, `b`, and everything else
    // reachable only from `a` should drop. The parser's lexical
    // `was_referenced` flag would keep `b` alive (its callee
    // reference is set when `a`'s body is parsed); the codegen's
    // transitive reachability pass over `Inst::Call` /
    // `Inst::ImmCode` recovers the dead status.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "\
         static int dead_leaf(int x) { return x + 1; }\n\
         static int dead_caller(int x) { return dead_leaf(x) * 2; }\n\
         int main(void) { return 0; }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let has_leaf = bytes.windows(9).any(|w| w == b"dead_leaf");
    let has_caller = bytes.windows(11).any(|w| w == b"dead_caller");
    assert!(!has_leaf, "transitively-dead leaf must drop");
    assert!(!has_caller, "lexically-dead caller must drop");
}

#[test]
fn address_taken_static_survives_dce() {
    // A static function whose address is stored in a global
    // function-pointer table must survive DCE: the table entry
    // becomes a `program.code_relocs` root. Mirrors the vtable
    // pattern (`static const VTable v = { .fp = doubled };`).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "\
         static int doubled(int n) { return n + n; }\n\
         typedef int (*fp_t)(int);\n\
         const fp_t vtable[] = { doubled };\n\
         int main(void) { return vtable[0](21); }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let has_doubled = bytes.windows(7).any(|w| w == b"doubled");
    assert!(
        has_doubled,
        "address-taken static must survive DCE via code_relocs root"
    );
}

/// Source with one over-aligned automatic object at `align`; its address is
/// taken so the object stays in the frame (C11 6.7.5).
#[cfg(test)]
fn overaligned_source_at(align: u32) -> String {
    alloc::format!(
        "int use(void *);\n\
         int f(int n) {{ _Alignas({align}) char buf[64]; buf[0] = (char)n; return use(buf); }}\n\
         int main(void) {{ return f(0); }}\n"
    )
}

#[cfg(test)]
fn overaligned_source() -> String {
    overaligned_source_at(64)
}

/// Emitted text of `src` as a relocatable object for `target`.
#[cfg(test)]
fn overaligned_text(src: &str, target: crate::c5::Target) -> Vec<u8> {
    use crate::c5::{NativeOptions, OutputKind, emit_native_with_options};
    let program = Compiler::new(src.to_string()).compile().expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    emit_native_with_options(&program, target, opts).expect("emit")
}

#[test]
fn overaligned_automatic_realigns_at_the_16_byte_boundary() {
    // 16 is the narrowest boundary the 8-byte frame slots cannot place, so it
    // realigns like the wider ones: `and rsp, -16` is 48 83 E4 F0, and
    // `and sp, x16, #-16` is the word 0x927CEE1F.
    use crate::c5::Target;
    let src = overaligned_source_at(16);
    let x64 = overaligned_text(&src, Target::LinuxX64);
    assert!(
        x64.windows(4).any(|w| w == [0x48, 0x83, 0xE4, 0xF0]),
        "x86_64 realigning prologue `and rsp, -0x10` not emitted"
    );
    let a64 = overaligned_text(&src, Target::LinuxAarch64);
    assert!(
        a64.windows(4).any(|w| w == [0x1F, 0xEE, 0x7C, 0x92]),
        "aarch64 realigning prologue `and sp, x16, #-16` not emitted"
    );
}

#[test]
fn overaligned_automatic_x64_realigns_prologue() {
    // The x86_64 prologue aligns rsp down to the object's 64-byte boundary:
    // `and rsp, -64` encodes as 48 83 E4 C0. A function without an over-aligned
    // object emits no such instruction (verified by the snapshot suite).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(overaligned_source())
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(4).any(|w| w == [0x48, 0x83, 0xE4, 0xC0]),
        "x86_64 realigning prologue `and rsp, -0x40` not emitted"
    );
}

#[test]
fn overaligned_automatic_aarch64_realigns_prologue() {
    // The aarch64 prologue stages sp through x16 and aligns down:
    // `and sp, x16, #-64` encodes as the word 0x927AE61F (little-endian bytes
    // 1F E6 7A 92).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(overaligned_source())
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    assert!(
        bytes.windows(4).any(|w| w == [0x1F, 0xE6, 0x7A, 0x92]),
        "aarch64 realigning prologue `and sp, x16, #-64` not emitted"
    );
}

#[test]
fn inline_asm_gas_macro_sysreg_read_encodes_numeric_mrs() {
    // The arm64 read_sysreg_s construct: `__DEFINE_ASM_GPR_NUMS` builds the
    // `.L__gpr_num_*` register-number table with `.irp`/`.equ`, a local
    // `mrs_s` macro emits the numeric MRS through `.inst`, and `.purgem`
    // removes it. Two reads in one unit must both encode, each expansion
    // independent. The sysreg field is byte-identical to GNU as: a read of
    // sys_reg(3,0,0,0,0) (midr_el1) is 0xd538_0000 | Rt and of
    // sys_reg(3,0,0,4,0) (id_aa64pfr0_el1) is 0xd538_0400 | Rt.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
#define __stringify_1(x...) #x
#define __stringify(x...)   __stringify_1(x)
#define __emit_inst(x)      ".inst " __stringify((x)) "\n\t"
#define __DEFINE_ASM_GPR_NUMS \
"\t.irp\tnum,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n" \
"\t.equ\t.L__gpr_num_x\\num, \\num\n" \
"\t.equ\t.L__gpr_num_w\\num, \\num\n" \
"\t.endr\n" \
"\t.equ\t.L__gpr_num_xzr, 31\n" \
"\t.equ\t.L__gpr_num_wzr, 31\n"
#define DEFINE_MRS_S \
	__DEFINE_ASM_GPR_NUMS \
"\t.macro\tmrs_s, rt, sreg\n" \
	__emit_inst(0xd5200000|(\\sreg)|(.L__gpr_num_\\rt)) \
"\t.endm\n"
#define UNDEFINE_MRS_S "\t.purgem\tmrs_s\n"
#define __mrs_s(v, r) DEFINE_MRS_S "\tmrs_s " v ", " __stringify(r) "\n" UNDEFINE_MRS_S
#define sys_reg(op0,op1,crn,crm,op2) (((op0)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
#define read_sysreg_s(r) ({ unsigned long __val; __asm__ volatile(__mrs_s("%0", r) : "=r"(__val)); __val; })
unsigned long two_reads(void) {
	return read_sysreg_s(sys_reg(3,0,0,0,0)) + read_sysreg_s(sys_reg(3,0,0,4,0));
}
"#;
    let copts = CompileOptions {
        no_entry_point: true,
        gnu: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), Target::LinuxAarch64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let words: alloc::vec::Vec<u32> = obj
        .text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // Rt (bits 4:0) is allocator-chosen; the sysreg field is fixed.
    let has_mrs = |base: u32| words.iter().any(|&w| w & 0xFFFF_FFE0 == base);
    assert!(
        has_mrs(0xd538_0000),
        "midr_el1 read must encode as a numeric MRS: {words:08x?}"
    );
    assert!(
        has_mrs(0xd538_0400),
        "id_aa64pfr0_el1 read must encode as a numeric MRS: {words:08x?}"
    );
}

#[test]
fn inline_asm_inst_operand_folds_prefix_logical_not() {
    // A `.inst` operand is an integer-constant-expression (C99 6.6). The
    // AArch64 MSR-immediate word `0xd500401f | (op1 << 16 | op2 << 5) |
    // ((!!x) << 8)` mixes `|`, `<<`, and prefix `!!` over constants. Prefix
    // `!` (C99 6.5.3.3) yields 1/0, so `!!(0)` clears the imm field and
    // `!!(1)` sets it. Byte-identical to GNU as: 0xd500409f and 0xd500419f.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
void inst_neg_zero(void) {
    __asm__ volatile(".inst (0xd500401f | ((0) << 16 | (4) << 5) | ((!!(0)) << 8))");
}
void inst_neg_one(void) {
    __asm__ volatile(".inst (0xd500401f | ((0) << 16 | (4) << 5) | ((!!(1)) << 8))");
}
int main(void) { inst_neg_zero(); inst_neg_one(); return 0; }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let words: alloc::vec::Vec<u32> = obj
        .text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    assert!(
        words.contains(&0xd500_409f),
        "`!!(0)` must fold to 0, leaving the imm field clear: {words:08x?}"
    );
    assert!(
        words.contains(&0xd500_419f),
        "`!!(1)` must fold to 1, setting the imm field: {words:08x?}"
    );
}

#[test]
fn inline_asm_lse_arch_extension_directive_is_accepted() {
    // The arm64 LSE atomics prepend `.arch_extension lse` to every atomic asm
    // block to enable the LSE instruction set for the assembler. badc's encoder
    // holds the LSE forms unconditionally, so the directive carries no code and
    // must be accepted, not parsed as an operand. Both the store form (`stadd`,
    // two operands) and the load-return form (`ldaddal`, three) must still
    // encode: `stadd Ws, [Xn]` is 0xB820_001F and `ldaddal Ws, Wt, [Xn]` is
    // 0xB8E0_0000, register fields aside (byte-identical to GNU as).
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
typedef struct { int counter; } atomic_t;
void lse_add(int i, atomic_t *v) {
    __asm__ volatile(".arch_extension lse\n\tstadd\t%w[i], %[v]\n"
        : [v] "+Q" (v->counter) : [i] "r" (i));
}
int lse_fetch(int i, atomic_t *v) {
    int old;
    __asm__ volatile(".arch_extension lse\n\tldaddal\t%w[i], %w[old], %[v]"
        : [v] "+Q" (v->counter), [old] "=r" (old) : [i] "r" (i) : "memory");
    return old;
}
"#;
    let copts = CompileOptions {
        no_entry_point: true,
        gnu: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), Target::LinuxAarch64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let words: alloc::vec::Vec<u32> = obj
        .text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // Rs (bits 20:16), Rt (bits 4:0) and Rn (bits 9:5) are allocator-chosen.
    let stadd_mask = !((0x1Fu32 << 16) | (0x1F << 5));
    let ldadd_mask = !((0x1Fu32 << 16) | (0x1F << 5) | 0x1F);
    assert!(
        words
            .iter()
            .any(|&w| w & stadd_mask == 0xB820_001F & stadd_mask),
        "stadd must encode after `.arch_extension lse`: {words:08x?}"
    );
    assert!(
        words.iter().any(|&w| w & ldadd_mask == 0xB8E0_0000),
        "ldaddal must encode after `.arch_extension lse`: {words:08x?}"
    );
}

#[test]
fn inline_asm_prfm_q_operand_in_gas_block_encodes_memory_form() {
    // A `Q` (`+Q`) operand's `%N` reference is the whole memory reference
    // `[xN]` through its address register. When the block carries a GNU-as
    // directive (`.equ` here, as the arm64 uaccess/futex blocks do via their
    // `.irp`/`.equ` register-number tables), the macro pass substitutes each
    // `%N` before the instruction parse, so it must render a `Q` operand as
    // `[xN]` -- otherwise `prfm` (and `ldxr`/`stlxr`) see a bare register and
    // reject it. `prfm pstl1strm, [xN]` is 0xf9800011 (Rn aside), the prefetch
    // op 17 in the Rt slot; byte-identical to GNU as.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
int futex_op(int oparg, unsigned int *uaddr) {
    unsigned int loops = 128;
    int ret, oldval, tmp;
    __asm__ volatile(
"	prfm	pstl1strm, %2\n"
"1:	ldxr	%w1, %2\n"
"	add	%w3, %w1, %w5\n"
"2:	stlxr	%w0, %w3, %2\n"
"	cbnz	%w0, 1b\n"
"	.equ	.Lz, 0\n"
        : "=&r" (ret), "=&r" (oldval), "+Q" (*uaddr), "=&r" (tmp), "+r" (loops)
        : "r" (oparg), "Ir" (-11) : "memory");
    return ret;
}
int main(void) { unsigned int u = 0; return futex_op(1, &u); }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let words: alloc::vec::Vec<u32> = obj
        .text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // Rn (bits 9:5) is the allocator-chosen address register.
    let rn_mask = !(0x1Fu32 << 5);
    assert!(
        words.iter().any(|&w| w & rn_mask == 0xf980_0011),
        "prfm must take the `Q` operand as a memory reference `[xN]`: {words:08x?}"
    );
    // The same `Q` operand feeds `ldxr Wt, [xN]` (0x885f7c00, Rn/Rt aside).
    let ldxr_mask = !((0x1Fu32 << 5) | 0x1F);
    assert!(
        words.iter().any(|&w| w & ldxr_mask == 0x885f_7c00),
        "ldxr must take the `Q` operand as a memory reference `[xN]`: {words:08x?}"
    );
}

#[test]
fn inline_asm_ldr_q_operand_in_gas_block_encodes_memory_form() {
    // The arm64 `load_unaligned_zeropad` / `read_word_at_a_time` blocks load a
    // `Q` operand with `ldr %0, %2` and carry the `.irp`/`.equ` register-number
    // table for their `__ex_table` entry, so the macro pass substitutes `%2`
    // before the parse. Rendered as a bare register, `ldr Xt, xN` has no A64
    // encoding; rendered as the `Q` memory reference `[xN]` it is the plain
    // load 0xf9400000 (Rn/Rt aside), byte-identical to GNU as.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
unsigned long load_zeropad(const void *addr) {
    unsigned long ret;
    __asm__(
"1:	ldr	%0, %2\n"
"2:\n"
"	.equ	.Lg, 0\n"
        : "=&r" (ret) : "r" (addr), "Q" (*(unsigned long *)addr));
    return ret;
}
int main(void) { unsigned long v = 0; return (int)load_zeropad(&v); }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let words: alloc::vec::Vec<u32> = obj
        .text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // Rn (bits 9:5) and Rt (bits 4:0) are allocator-chosen.
    let ldr_mask = !((0x1Fu32 << 5) | 0x1F);
    assert!(
        words.iter().any(|&w| w & ldr_mask == 0xf940_0000),
        "ldr must take the `Q` operand as a memory reference `[xN]`: {words:08x?}"
    );
}

#[test]
fn inline_asm_memory_offset_folds_constant_expression() {
    // A memory-operand offset is a GNU as constant expression, not just a
    // literal: the arm64 `__const_memcpy_toio` blocks write `str %w, [%r, #4 *
    // N]`. Fold the `#4 * N` offset -- `#4 * 3` scales to 12 in `str Wt, [Xn,
    // #12]`, encoded 0xb9000c00 (Rn/Rt aside), byte-identical to GNU as.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
void store2(volatile unsigned *to, const unsigned *from) {
    __asm__ volatile(
"str %w0, [%2, #4 * 0]\n"
"str %w1, [%2, #4 * 3]\n"
        : : "rZ"(from[0]), "rZ"(from[1]), "r"(to));
}
int main(void) { unsigned t = 0, f[2] = {1, 2}; store2(&t, f); return 0; }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let words: alloc::vec::Vec<u32> = obj
        .text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // Rn (bits 9:5) and Rt (bits 4:0) are allocator-chosen.
    let str_mask = !((0x1Fu32 << 5) | 0x1F);
    assert!(
        words.iter().any(|&w| w & str_mask == 0xb900_0c00),
        "`#4 * 3` must fold to the scaled imm 3 (offset 12): {words:08x?}"
    );
}

#[test]
fn inline_asm_rept_in_main_stream_expands_nop_padding() {
    // A `.rept N ... .endr` in the main asm stream must expand to straight-line
    // text, as the deferred ALTERNATIVE-replacement path already does. The
    // arm64 Cavium errata read emits a standalone `.rept 8; nop; .endr` padding
    // block; unexpanded, `.rept` reaches the instruction parse and has no
    // encoding. Each `nop` is 0xd503201f, byte-identical to GNU as.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
void nop_pad(void) { __asm__ volatile(".rept 8\nnop\n.endr\n"); }
int main(void) { nop_pad(); return 0; }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let nops = obj
        .text
        .chunks_exact(4)
        .filter(|c| u32::from_le_bytes((*c).try_into().unwrap()) == 0xd503_201f)
        .count();
    assert!(nops >= 8, "`.rept 8` must expand to 8 nops: found {nops}");
}

#[test]
fn inline_asm_dot_branch_target_encodes_zero_displacement() {
    // The device-load ordering barrier (`__io_ar`) branches to the location
    // counter `.`: `cbnz %0, .` is a never-taken control dependency whose
    // target is the branch instruction itself, so the encoded displacement is
    // zero. `cbnz x0, .` is 0xB500_0000 (Rt field aside) and `b .` is
    // 0x1400_0000, byte-identical to GNU as.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
unsigned long io_ar(unsigned long v) {
    unsigned long tmp;
    __asm__ volatile("eor %0, %1, %1\n\tcbnz %0, ." : "=r" (tmp) : "r" (v) : "memory");
    return tmp;
}
void spin(void) { __asm__ volatile("b ."); }
"#;
    let copts = CompileOptions {
        no_entry_point: true,
        gnu: true,
        ..Default::default()
    };
    let program = Compiler::with_options(src.to_string(), Target::LinuxAarch64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let words: alloc::vec::Vec<u32> = obj
        .text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // CBNZ Rt (bits 4:0) is allocator-chosen; the rest is the 64-bit
    // branch-to-self word with imm19 == 0.
    let cbnz_mask = !0x1Fu32;
    assert!(
        words.iter().any(|&w| w & cbnz_mask == 0xB500_0000),
        "`cbnz %0, .` must encode a zero-displacement branch-to-self: {words:08x?}"
    );
    assert!(
        words.contains(&0x1400_0000),
        "`b .` must encode a zero-displacement branch-to-self: {words:08x?}"
    );
}

#[test]
fn inline_asm_x86_debug_register_mov_encodes_0f21_0f23() {
    // AT&T spells the x86 debug registers DR0..DR7 `db0..db7` (also
    // `dr0..dr7`). `mov %dbN, r64` is 0F 21 /r and `mov r64, %dbN` is 0F 23 /r;
    // the ModRM reg field selects DRn, byte-identical to GNU as. The rm field
    // (the GP register) is allocator-chosen and masked out.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
unsigned long read_db7(void) { unsigned long v; __asm__ volatile("mov %%db7, %0" : "=r"(v)); return v; }
void write_db7(unsigned long v) { __asm__ volatile("mov %0, %%db7" : : "r"(v)); }
int main(void) { write_db7(read_db7()); return 0; }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let text = &obj.text;
    let has = |op: u8| {
        text.windows(3)
            .any(|w| w[0] == 0x0F && w[1] == op && (w[2] & 0xF8) == 0xF8)
    };
    assert!(
        has(0x21),
        "read of %db7 must encode as 0F 21 /r with reg=7: {text:02x?}"
    );
    assert!(
        has(0x23),
        "write of %db7 must encode as 0F 23 /r with reg=7: {text:02x?}"
    );
}

#[test]
fn inline_asm_lar_lsl_r32_from_r16_source_encode_0f02_0f03() {
    // `lar`/`lsl` read a 16-bit selector into a 32-bit destination. The
    // kernel casts the source to `u16` (`lar %[ss], %[ar]` with `[ss] "rm"
    // ((u16)x)`), so the source is a 16-bit register or `m16` and the
    // catalogue's `r16,r/m16` and `r32,r/m32` forms both miss. GNU as
    // encodes `lar %bx,%eax` as `0F 02 C3` (no `66` prefix, the 32-bit
    // destination sets the operand size); `lsl` is `0F 03 /r`.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
unsigned lar_ss(unsigned short ss){ unsigned ar; __asm__ volatile("lar %[s], %[a]" : [a]"=r"(ar) : [s]"rm"((unsigned short)ss)); return ar; }
unsigned lsl_ss(unsigned short ss){ unsigned lim; __asm__ volatile("lsl %[s], %[l]" : [l]"=r"(lim) : [s]"rm"((unsigned short)ss)); return lim; }
int main(void){ return (int)(lar_ss(3) + lsl_ss(3)); }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let text = &obj.text;
    // `0F 02`/`0F 03` with a mod=11 ModRM (register-direct source), and no
    // `66` operand-size prefix on the byte before the `0F`.
    let has = |op: u8| {
        (2..text.len()).any(|i| {
            text[i - 1] == 0x0F && text[i] == op && text[i + 1] >= 0xC0 && text[i - 2] != 0x66
        })
    };
    assert!(
        has(0x02),
        "lar must encode 0F 02 /r, no 66 prefix: {text:02x?}"
    );
    assert!(
        has(0x03),
        "lsl must encode 0F 03 /r, no 66 prefix: {text:02x?}"
    );
}

#[test]
fn inline_asm_svm_vmsave_vmload_take_implicit_rax_operand() {
    // The AMD SVM ops address the VMCB through an implicit `rax`; the kernel
    // spells the operand out (`vmsave %0` with `"a"(pa)`). GNU as encodes
    // `vmsave %rax` as `0F 01 DB` and `vmload %rax` as `0F 01 DA`, `rax`
    // unnamed in the opcode.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
void do_vmsave(unsigned long pa){ __asm__ volatile("vmsave %0" : : "a"(pa) : "memory"); }
void do_vmload(unsigned long pa){ __asm__ volatile("vmload %0" : : "a"(pa) : "memory"); }
int main(void){ do_vmsave(0); do_vmload(0); return 0; }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let text = &obj.text;
    let has = |b: [u8; 3]| text.windows(3).any(|w| w == b);
    assert!(
        has([0x0F, 0x01, 0xDB]),
        "vmsave must encode 0F 01 DB: {text:02x?}"
    );
    assert!(
        has([0x0F, 0x01, 0xDA]),
        "vmload must encode 0F 01 DA: {text:02x?}"
    );
}

#[test]
fn inline_asm_svm_invlpga_takes_implicit_rax_ecx_operands() {
    // `invlpga` addresses through an implicit `rax` (address) and `ecx`
    // (ASID); the kernel spells both out (`invlpga %1, %0` with `"a"(addr)`,
    // `"c"(asid)`). GNU as encodes `invlpga %rax, %ecx` as `0F 01 DF`, both
    // registers unnamed in the opcode.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
void do_invlpga(unsigned long addr, unsigned int asid){
    __asm__ volatile("invlpga %1, %0" : : "c"(asid), "a"(addr) : "memory");
}
int main(void){ do_invlpga(0, 0); return 0; }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let text = &obj.text;
    assert!(
        text.windows(3).any(|w| w == [0x0F, 0x01, 0xDF]),
        "invlpga must encode 0F 01 DF: {text:02x?}"
    );
}

#[test]
fn inline_asm_section_operand_constant_survives_unpromoted_function() {
    // C99 6.5p6: an `"i"` operand is an integer constant expression. A computed
    // goto opts the function out of slot promotion, so the constant reaches the
    // section-data operand as a store + load of a local rather than an
    // immediate; GNU as folds it. badc must recover the constant by the load's
    // reaching definition and emit it, as the kernel's `WARN_ON` bug table
    // (`.word %c<flags>`) requires. The `do {} while (0)` mirrors that macro's
    // dead back edge, which the recovery follows through.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    // A distinctive constant, unlikely to occur by chance in the object.
    let src = r#"
int f(int x){
    static void *tab[] = { &&a, &&b };
    do {
        __auto_type flags = 0x5AB3C1D2;
        __asm__ volatile(".pushsection .test_bugs,\"a\"\n\t.long %c0\n\t.popsection\n"
                         : : "i"(flags));
    } while (0);
    goto *tab[x];
    a: return 1;
    b: return 2;
}
int main(void){ return f(0); }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts)
        .expect("emit must recover the constant `\"i\"` operand");
    // The section holds `.long 0x5AB3C1D2`, little-endian.
    assert!(
        bytes.windows(4).any(|w| w == [0xD2, 0xC1, 0xB3, 0x5A]),
        "the section-data `\"i\"` operand constant must be emitted"
    );
}

#[test]
fn inline_asm_more_than_eight_register_operands() {
    // A block with more register operands than the eight caller-saved pool
    // registers must still allocate: the callee-saved r12..r15 join the pool,
    // saved and restored in the frame's asm scratch region. The kernel's IRQ
    // stack-switch asm (`common_interrupt`) needs this. Eleven register
    // operands (one output, ten inputs) force r12..r15 into use.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
long sum(long a,long b,long c,long d,long e,long f,long g,long h,long i,long j){
    long out;
    __asm__("xorq %0,%0\n\t addq %1,%0\n\t addq %2,%0\n\t addq %3,%0\n\t addq %4,%0\n\t"
            "addq %5,%0\n\t addq %6,%0\n\t addq %7,%0\n\t addq %8,%0\n\t addq %9,%0\n\t addq %10,%0"
        : "=&r"(out)
        : "r"(a),"r"(b),"r"(c),"r"(d),"r"(e),"r"(f),"r"(g),"r"(h),"r"(i),"r"(j));
    return out;
}
int main(void){ return (int)sum(1,2,3,4,5,6,7,8,9,10); }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts)
        .expect("eleven register operands must allocate across r12..r15");
    let text = parse_native_elf(&bytes).expect("parse ET_REL").text;
    // A callee-saved high register is used as an operand, so its save/restore
    // (`mov %r1x, disp(%rbp)` / the reverse) carries REX.WR (0x4C) or REX.WB.
    assert!(
        text.windows(2)
            .any(|w| (w[0] == 0x4C || w[0] == 0x4D) && (w[1] == 0x89 || w[1] == 0x8B)),
        "a high register save/restore must appear: {text:02x?}"
    );
}

#[test]
fn parenthesized_bitfield_lvalue_assigns_as_a_store() {
    // C99 6.5.1p5: a parenthesized lvalue is an lvalue. The member parser
    // selects a bitfield read vs write from the token after the member, so
    // parentheses (a macro wrapping `(...->f)`) hid the following `=` and the
    // assignment was rejected as a bad lvalue. `(p->f) = v` must emit the
    // read-clear-shift-or-store sequence, byte-identical to `p->f = v`.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let text_of = |src: &str| -> alloc::vec::Vec<u8> {
        let program = Compiler::with_target(String::from(src), Target::LinuxX64)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL").text
    };
    // Field `c:8` at bit offset 8: the store clears with ~(0xff << 8) =
    // 0xFFFF00FF (imm32 `ff 00 ff ff`), a mask a bitfield read never forms.
    let clear_mask = [0xffu8, 0x00, 0xff, 0xff];
    let paren = text_of(
        "struct s { unsigned int a:4, b:4, c:8; };\n\
         void set_c(struct s *p, unsigned v){ (p->c) = v; }\n\
         int main(void){ return 0; }\n",
    );
    let plain = text_of(
        "struct s { unsigned int a:4, b:4, c:8; };\n\
         void set_c(struct s *p, unsigned v){ p->c = v; }\n\
         int main(void){ return 0; }\n",
    );
    assert!(
        paren.windows(4).any(|w| w == clear_mask),
        "a parenthesized bitfield assignment must emit the clear-mask store: {paren:02x?}"
    );
    assert_eq!(
        paren, plain,
        "`(p->c) = v` must emit the same object as `p->c = v`"
    );
}

#[test]
fn parenthesized_bitfield_lvalue_post_inc_and_compound_assign() {
    // C99 6.5.1p5 / 6.5.2.4 / 6.5.16.2: `(p->f)++` and `(p->f) OP= v` on a
    // parenthesized bitfield lvalue must emit the same object as the
    // unparenthesized forms. Parentheses hid the trailing `++` / `OP=` from the
    // member parser, which committed to a read; the post-increment and compound-
    // assignment paths recover the bitfield member from that read node.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let text_of = |src: &str| -> alloc::vec::Vec<u8> {
        let program = Compiler::with_target(String::from(src), Target::LinuxX64)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL").text
    };
    let decl = "struct s { unsigned int a:4, b:1, f:3, c:4; };\n";
    let build = |body: &str| -> alloc::vec::Vec<u8> {
        text_of(&alloc::format!(
            "{decl}void op(struct s *p){{ {body} }}\nint main(void){{ return 0; }}\n"
        ))
    };
    assert_eq!(
        build("(p->f)++;"),
        build("p->f++;"),
        "`(p->f)++` must emit the same object as `p->f++`"
    );
    assert_eq!(
        build("(p->f)--;"),
        build("p->f--;"),
        "`(p->f)--` must emit the same object as `p->f--`"
    );
    assert_eq!(
        build("(p->f) += 2;"),
        build("p->f += 2;"),
        "`(p->f) += 2` must emit the same object as `p->f += 2`"
    );
    assert_eq!(
        build("(p->f) |= 5;"),
        build("p->f |= 5;"),
        "`(p->f) |= 5` must emit the same object as `p->f |= 5`"
    );
}

#[test]
fn seg_qualified_direct_access_rides_a_segment_prefix() {
    // A direct read / write through a `__seg_gs` / `__seg_fs` pointer (GCC
    // named address spaces, the x86 percpu pattern) lowers to a plain load /
    // store carrying a segment-override prefix: `%gs:` is 0x65, `%fs:` is
    // 0x64. gcc -O2 emits `65 48 8b ..` (gs read) / `64 48 8b ..` (fs read) /
    // `65 48 89 ..` (gs write); badc computes the address into a base register
    // first, so it emits the register-indirect form of the same instruction.
    // Scan for the override byte followed by a REX.W and the 64-bit mov
    // opcode -- allocator register choice independent.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let text_of = |src: &str| -> alloc::vec::Vec<u8> {
        let program = Compiler::with_target(String::from(src), Target::LinuxX64)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL").text
    };
    // 0x8b = mov r64, r/m64 (read); 0x89 = mov r/m64, r64 (write).
    let riding = |text: &[u8], pfx: u8, op: u8| -> bool {
        text.windows(3)
            .any(|w| w[0] == pfx && (0x48..=0x4f).contains(&w[1]) && w[2] == op)
    };
    // main must reference each function so it survives dead-code elimination.
    let read_prog = |seg: &str| {
        alloc::format!(
            "unsigned long r(unsigned long *p){{ return *(unsigned long {seg} *)p; }}\n\
             int main(void){{ unsigned long x = 0; return (int)r(&x); }}"
        )
    };
    let gs_read = text_of(&read_prog("__seg_gs"));
    let fs_read = text_of(&read_prog("__seg_fs"));
    let gs_write = text_of(
        "void w(unsigned long *p, unsigned long x){ *(unsigned long __seg_gs *)p = x; }\n\
         int main(void){ unsigned long x = 0; w(&x, 1); return 0; }",
    );
    let plain = text_of(&read_prog(""));
    assert!(
        riding(&gs_read, 0x65, 0x8b),
        "`__seg_gs` read must ride a %gs (0x65) prefix on the 64-bit load: {gs_read:02x?}"
    );
    assert!(
        riding(&fs_read, 0x64, 0x8b),
        "`__seg_fs` read must ride a %fs (0x64) prefix on the 64-bit load: {fs_read:02x?}"
    );
    assert!(
        riding(&gs_write, 0x65, 0x89),
        "`__seg_gs` write must ride a %gs (0x65) prefix on the 64-bit store: {gs_write:02x?}"
    );
    // A read-modify-write through the same lvalue: C99 6.5.16.2 reads and
    // writes the object, so both halves ride the override. Dropping it on
    // either half accesses the generic-space address instead.
    let gs_rmw = text_of(
        "void a(unsigned long *p, unsigned long x){ *(unsigned long __seg_gs *)p += x; }\n\
         int main(void){ unsigned long x = 0; a(&x, 1); return 0; }",
    );
    let gs_inc = text_of(
        "void i(unsigned long *p){ (*(unsigned long __seg_gs *)p)++; }\n\
         int main(void){ unsigned long x = 0; i(&x); return 0; }",
    );
    for (name, text) in [("+=", &gs_rmw), ("++", &gs_inc)] {
        assert!(
            riding(text, 0x65, 0x8b),
            "a `__seg_gs` {name} must read under a %gs prefix: {text:02x?}"
        );
        assert!(
            riding(text, 0x65, 0x89),
            "a `__seg_gs` {name} must write under a %gs prefix: {text:02x?}"
        );
    }
    assert!(
        !riding(&plain, 0x65, 0x8b) && !riding(&plain, 0x64, 0x8b),
        "an unqualified load must carry no segment override: {plain:02x?}"
    );
}

#[test]
fn block_scope_externs_emit_distinct_undef_symbols() {
    // C99 6.2.2p4: a block-scope `extern` declaration has external
    // linkage and refers to the file-scope object of the same name in
    // another unit. Taking the address of several such declarations must
    // produce a distinct named relocation per object. The bug was that
    // the block-scope path set `class=Glo` + `is_extern_decl` but not
    // `linkage=External`, so `live_glo_addr` fell back to the tentative
    // `val` (0) and every `&name` collapsed onto the same `.data` base.
    // Each distinct extern must surface as its own undefined symbol.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "void use3(char *a, char *b, char *c);\n\
         int main(void) {\n\
         extern int g1;\n\
         extern int g2;\n\
         extern int g3;\n\
         use3((char *)&g1, (char *)&g2, (char *)&g3);\n\
         return 0;\n\
         }\n"
        .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    use crate::c5::linker::object::NativeSymSection;
    for name in ["g1", "g2", "g3"] {
        let found = obj
            .symbols
            .iter()
            .any(|s| s.name == name && matches!(s.section, NativeSymSection::Undef));
        assert!(
            found,
            "block-scope extern `{name}` must emit its own undefined data symbol"
        );
    }
}

#[test]
fn nested_block_externs_emit_distinct_undef_symbols() {
    // Same as the body-top case, but the `extern` declarations sit in a
    // nested `{ }`. That path consumed `extern` as a no-op and allocated
    // a local for the declarator; it must instead register an external
    // reference so the address resolves to the defining unit's object.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "void use3(char *a, char *b, char *c);\n\
         int main(void) {\n\
         {\n\
         extern int n1;\n\
         extern int n2;\n\
         extern int n3;\n\
         use3((char *)&n1, (char *)&n2, (char *)&n3);\n\
         }\n\
         return 0;\n\
         }\n"
        .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    for name in ["n1", "n2", "n3"] {
        let found = obj
            .symbols
            .iter()
            .any(|s| s.name == name && matches!(s.section, NativeSymSection::Undef));
        assert!(
            found,
            "nested-block extern `{name}` must emit its own undefined data symbol"
        );
    }
}

#[test]
fn cross_tu_thread_local_resolves_by_symbol() {
    // A `_Thread_local` defined in one unit and accessed in another via
    // `extern _Thread_local` resolves by symbol against the merged TLS
    // block. The accessor must not reserve its own TLS storage (a phantom
    // per-unit copy), and its Mach-O TLV descriptor must be keyed by the
    // variable name so the linker fills the per-thread offset from the
    // defining unit. macOS arm64 uses the TLV descriptor model.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let unit = |src: &str| {
        let prog = Compiler::with_options(
            src.to_string(),
            Target::MacOSAarch64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let bytes = emit_native_with_options(&prog, Target::MacOSAarch64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse")
    };

    // Definer: `other` sits at TLS offset 4 (after `counter` at 0).
    let def = unit(
        "#include <stdlib.h>\n\
         _Thread_local int counter = 7;\n\
         _Thread_local int other = 3;\n\
         int read_other(void) { return other; }\n",
    );
    let off_other = def
        .tls_symbols
        .iter()
        .find(|(n, _, _)| n == "other")
        .map(|(_, off, _)| *off)
        .expect("definer exports `other` as a TLS symbol");
    assert_eq!(
        off_other, 8,
        "`other` follows the 8-byte-aligned `counter` slot"
    );

    // Accessor: references `other` but defines no TLS storage.
    let acc = unit(
        "#include <stdlib.h>\n\
         extern _Thread_local int other;\n\
         int get_other(void) { return other; }\n",
    );
    assert!(
        acc.tls_data.is_empty() && acc.tls_bss_size == 0,
        "an extern _Thread_local reference must not reserve storage"
    );
    assert!(
        acc.macho_tlv_descriptor_syms
            .iter()
            .any(|(_, name)| name == "other"),
        "the cross-unit access must be a symbol-keyed TLV descriptor"
    );

    // The link resolves the accessor's descriptor to `other`'s merged
    // offset (4): the definer is the only TLS contributor, base 0.
    let merged = link_native_objects(&[def, acc]).expect("link resolves cross-unit TLS");
    assert!(
        merged.macho_tlv_descriptors.contains(&8),
        "the accessor's `other` descriptor must resolve to offset 8, got {:?}",
        merged.macho_tlv_descriptors,
    );
}

#[test]
fn cross_tu_thread_local_resolves_by_symbol_windows_aarch64() {
    // The Windows/aarch64 analogue of the cross-unit TLS resolve. The
    // access reaches the variable through the TEB's TLS array
    // (`ldr x16, [x18, #0x58]`, index by `_tls_index`), so the accessor
    // records both a `_tls_index` fixup and an extern TLS-offset fixup
    // (reusing the `elf_tpoff_fixups` channel) keyed by the variable name.
    // The linker fills the `add x?, x16, #imm12` with the variable's raw
    // offset in the merged TLS block -- no thread-pointer bias, unlike the
    // variant-1 ELF path's `+16` -- so the patched immediate equals the
    // merged offset directly.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::ElfTpoffTarget;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let unit = |src: &str| {
        let prog = Compiler::with_options(
            src.to_string(),
            Target::WindowsAarch64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let bytes = emit_native_with_options(&prog, Target::WindowsAarch64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse")
    };

    let def = unit(
        "#include <stdlib.h>\n\
         _Thread_local int counter = 7;\n\
         _Thread_local int other = 3;\n\
         int read_other(void) { return other; }\n",
    );
    let off_other = def
        .tls_symbols
        .iter()
        .find(|(n, _, _)| n == "other")
        .map(|(_, off, _)| *off)
        .expect("definer exports `other` as a TLS symbol");
    assert_eq!(off_other, 8, "`other` follows the 8-byte-aligned `counter`");

    let acc = unit(
        "#include <stdlib.h>\n\
         extern _Thread_local int other;\n\
         int get_other(void) { return other; }\n",
    );
    assert!(
        acc.tls_data.is_empty() && acc.tls_bss_size == 0,
        "an extern _Thread_local reference must not reserve storage"
    );
    assert!(
        !acc.tls_index_fixups.is_empty(),
        "the Windows TEB access must record a `_tls_index` fixup"
    );
    assert!(
        acc.elf_tpoff_fixups
            .iter()
            .any(|(_, t)| matches!(t, ElfTpoffTarget::Extern(name) if name == "other")),
        "the cross-unit access must record an extern TLS-offset fixup for `other`"
    );

    let merged = link_native_objects(&[acc, def]).expect("link resolves cross-unit Windows TLS");

    // Scan the merged `.text` for the TEB sequence and confirm its closing
    // `add x?, x16, #imm12` was patched to `other`'s merged offset (8): the
    // definer is the only TLS contributor (base 0) and `counter` precedes
    // it. The raw offset (not `8 + 16`) proves the Windows bias.
    const TEB_LOAD: u32 = 0xF940_2E50; // ldr x16, [x18, #0x58]
    let text = &merged.text;
    let mut patched = None;
    let mut i = 0;
    while i + 20 <= text.len() {
        let w = u32::from_le_bytes(text[i..i + 4].try_into().unwrap());
        if w == TEB_LOAD {
            let a = u32::from_le_bytes(text[i + 16..i + 20].try_into().unwrap());
            if (a & 0xFF80_0000) == 0x9100_0000 && (a >> 5) & 0x1F == 16 {
                patched = Some((a >> 10) & 0xFFF);
                break;
            }
        }
        i += 4;
    }
    assert_eq!(
        patched,
        Some(off_other as u32),
        "the TEB `add x?, x16, #imm12` must hold the raw merged offset {off_other} (no +16 bias)"
    );
}

#[test]
fn pointer_to_extern_data_resolves_cross_tu() {
    // `int *p = &g;` / `int *p = arr;` where the target is defined in
    // another unit must emit a `.rela.data` reloc against the named
    // undefined data symbol, not against this unit's `.data` section, so
    // the link resolves it to the defining unit's storage. Before the
    // fix the slot held this unit's `.data` base.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let prog_a = Compiler::with_options(
        "extern int g;\nextern int arr[];\nint *ps = &g;\nint *pa = &arr[1];\nint *pd = arr;\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile a");
    let bytes_a = emit_native_with_options(&prog_a, Target::LinuxX64, opts).expect("emit a");
    let obj_a = parse_native_elf(&bytes_a).expect("parse a");

    // `g` and `arr` are undefined data symbols, and every `.rela.data`
    // entry targets one of them by name rather than the `.data` section.
    for name in ["g", "arr"] {
        assert!(
            obj_a
                .symbols
                .iter()
                .any(|s| s.name == name && matches!(s.section, NativeSymSection::Undef)),
            "`{name}` must be an undefined data symbol"
        );
    }
    assert_eq!(
        obj_a.data_relocs.len(),
        3,
        "three pointer-to-extern-data slots must each emit a reloc"
    );
    for r in &obj_a.data_relocs {
        let target = &obj_a.symbols[r.sym_idx].name;
        assert!(
            target == "g" || target == "arr",
            "extern-data reloc must target the named symbol, got `{target}`"
        );
    }

    // The defining unit links cleanly against the references.
    let prog_b = Compiler::with_options(
        "int g = 77;\nint arr[3] = {11, 22, 33};\n".to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile b");
    let bytes_b = emit_native_with_options(&prog_b, Target::LinuxX64, opts).expect("emit b");
    let obj_b = parse_native_elf(&bytes_b).expect("parse b");
    link_native_objects(&[obj_a, obj_b]).expect("link resolves the extern-data references");
}

#[test]
fn extern_data_address_in_struct_initializer_resolves_cross_tu() {
    // `&g` for a cross-unit `extern` target inside a brace-list / struct
    // initializer must emit a named relocation against the undefined
    // symbol, the same as the scalar `T *p = &g;` path. Before the fix
    // it resolved against this unit's `.data` section + the extern's
    // permissive local fallback offset, pointing into the wrong unit.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let prog_a = Compiler::with_options(
        "struct Obj { long refcnt; struct Obj *type; };\n\
         extern struct Obj TheType;\n\
         struct Obj inst = { 1, &TheType };\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile a");
    let bytes_a = emit_native_with_options(&prog_a, Target::LinuxX64, opts).expect("emit a");
    let obj_a = parse_native_elf(&bytes_a).expect("parse a");

    assert!(
        obj_a
            .symbols
            .iter()
            .any(|s| s.name == "TheType" && matches!(s.section, NativeSymSection::Undef)),
        "`TheType` must be an undefined data symbol, not a local fallback"
    );
    assert!(
        obj_a
            .data_relocs
            .iter()
            .any(|r| obj_a.symbols[r.sym_idx].name == "TheType"),
        "the struct-initializer `&TheType` must emit a named reloc against `TheType`"
    );

    let prog_b = Compiler::with_options(
        "struct Obj { long refcnt; struct Obj *type; };\n\
         struct Obj TheType = { 9, 0 };\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile b");
    let bytes_b = emit_native_with_options(&prog_b, Target::LinuxX64, opts).expect("emit b");
    let obj_b = parse_native_elf(&bytes_b).expect("parse b");
    link_native_objects(&[obj_a, obj_b]).expect("link resolves the struct-init extern reference");
}

#[test]
fn file_scope_asm_globl_gives_external_linkage() {
    // `asm(".globl name");` at file scope binds the named symbol
    // STB_GLOBAL, as gcc and clang do: a `static` function so named
    // leaves the unit's local-function list and becomes a definition the
    // merge resolves by name.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let unit = |directive: &str| {
        let program = Compiler::with_options(
            alloc::format!(
                "static int hidden(void) {{ return 7; }}\n\
                 {directive}\n\
                 int main(void) {{ return hidden() - 7; }}\n"
            ),
            Target::LinuxX64,
            CompileOptions::default(),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        link_native_objects(&[parse_native_elf(&bytes).expect("parse")]).expect("link")
    };
    let is_local =
        |m: &crate::c5::linker::MergedNative| m.local_funcs.iter().any(|(n, _)| n == "hidden");
    // Control: without the directive the static function stays local.
    assert!(
        is_local(&unit("")),
        "a plain `static` function must keep internal linkage"
    );
    assert!(
        !is_local(&unit("asm(\".globl hidden\");")),
        "`.globl` must give the static function external linkage"
    );
    // The directive may precede the definition it names.
    let program = Compiler::with_options(
        "asm(\".globl hidden\");\n\
         static int hidden(void) { return 7; }\n\
         int main(void) { return hidden() - 7; }\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default(),
    )
    .compile()
    .expect("compile with the directive first");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let merged = link_native_objects(&[parse_native_elf(&bytes).expect("parse")]).expect("link");
    assert!(
        !merged.local_funcs.iter().any(|(n, _)| n == "hidden"),
        "`.globl` ahead of the definition must still apply"
    );
}

#[test]
fn file_scope_asm_type_size_set_symbol_type_and_size() {
    // A static-call trampoline names its symbol with `.type name,
    // @function` and `.size name, . - name`. badc must emit STT_FUNC with
    // st_size = the trampoline's byte length, byte-for-byte as gas does
    // (verified against gas: FUNC / GLOBAL / size 8). Both 64-bit ELF
    // targets share the symbol path, so both are checked.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const STT_FUNC: u8 = 2;
    const STB_GLOBAL: u8 = 1;
    let src = r#"asm(".pushsection .static_call.text, \"ax\"\n"
    ".globl tramp\n"
    "tramp:\n"
    ".byte 0xe9, 0x11, 0x22, 0x33, 0x44\n"
    ".byte 0x0f, 0xb9, 0xcc\n"
    ".type tramp, @function\n"
    ".size tramp, . - tramp\n"
    ".popsection\n");
int main(void) { return 0; }
"#;
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let sym = obj
            .symbols
            .iter()
            .find(|s| s.name == "tramp")
            .unwrap_or_else(|| panic!("{target:?}: `tramp` symbol missing"));
        assert_eq!(
            sym.kind, STT_FUNC,
            "{target:?}: `.type @function` must set STT_FUNC"
        );
        assert_eq!(
            sym.size, 8,
            "{target:?}: `.size . - tramp` must set st_size = 8"
        );
        assert_eq!(
            sym.binding, STB_GLOBAL,
            "{target:?}: `.globl` must set STB_GLOBAL"
        );
    }
}

#[test]
fn libc_address_trampoline_is_per_tu_local() {
    // Two translation units that each take the address of the same
    // libc function in a `.data` function-pointer table both emit a
    // synthetic `__c5_sys_exp` forwarding trampoline. The trampoline
    // is referenced only within its own unit (via a `.text`-section
    // reloc carrying its byte offset, not by name), so it must have
    // internal linkage; binding it STB_GLOBAL would make the merge
    // reject the second definition. Verifies the per-TU local
    // classification in `elf_reloc::write_relocatable`.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let unit = |table: &str, extra: &str| {
        let program = Compiler::with_options(
            alloc::format!(
                "#include <math.h>\n\
                 typedef double (*mathfn)(double);\n\
                 const mathfn {table}[] = {{ exp, log }};\n\
                 {extra}"
            ),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL")
    };
    let a = unit(
        "a_tbl",
        "double call_a(int i, double x) { return a_tbl[i](x); }\n",
    );
    let b = unit(
        "b_tbl",
        "double call_a(int i, double x);\n\
         int main(void) { return call_a(0, 0.0) == 1.0 ? 0 : 1; }\n",
    );
    // The merge must not reject the duplicate `__c5_sys_exp` /
    // `__c5_sys_log` trampolines.
    let merged = link_native_objects(&[a, b]).expect("link must not collide on libc trampolines");
    // Each unit kept its own local copy: the merged static-function
    // list carries the trampoline name from both units.
    let exp_copies = merged
        .local_funcs
        .iter()
        .filter(|(n, _)| n == "__c5_sys_exp")
        .count();
    assert!(
        exp_copies >= 2,
        "each TU must keep its own local __c5_sys_exp trampoline, got {exp_copies}"
    );
}

#[test]
fn unreferenced_static_function_is_dropped_from_object() {
    // C99 6.2.2p3: a file-scope `static` function has internal
    // linkage and is reachable only from the current TU. The
    // parser already emits a `warn_unused_static_functions`
    // diagnostic when no in-TU call site references it; the
    // codegen also drops the body so the resulting object
    // doesn't carry dead code. Verifies the
    // `function_is_unreachable_static` gate in `walk_program`.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         static int unused_helper(int x) {{ return x * 2; }}\n\
         static int used_helper(int x) {{ return x + 1; }}\n\
         int main(void) {{ return used_helper(41); }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    // Walk for the function names by byte-substring lookup; the
    // strtab carries them as NUL-terminated entries among the
    // section header / symbol-table bytes.
    let has_used = bytes.windows(11).any(|w| w == b"used_helper");
    let has_unused = bytes.windows(13).any(|w| w == b"unused_helper");
    assert!(
        has_used,
        "reachable static helper must survive into the object"
    );
    assert!(
        !has_unused,
        "unreachable static helper must not appear in the object"
    );
}

/// Relocatable-emit options for an entry-less TU, the `-c` shape the
/// dead-static tests below exercise.
#[cfg(test)]
fn reloc_tu(src: &str, target: crate::c5::Target, optimize: bool) -> alloc::vec::Vec<u8> {
    use crate::c5::compiler::CompileOptions;
    use crate::c5::{NativeOptions, OutputKind, emit_native_with_options};
    let copts = CompileOptions {
        no_entry_point: true,
        gnu: true,
        ..Default::default()
    };
    let program = Compiler::with_options(String::from(src), target, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        optimize,
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    emit_native_with_options(&program, target, opts).expect("emit")
}

#[test]
fn dead_static_data_with_extern_relocs_drops_reloc_and_undef() {
    // A static pointer table holding extern-symbol addresses, itself
    // unreferenced, and a dead static->static pointer chain. gcc -O
    // drops the objects, their relocation slots, and the undefined
    // reference; a relocation slot must not root its own object, or an
    // isolated link consuming the object fails on the undefined name.
    use crate::c5::Target;
    use crate::c5::linker::{NativeSymSection, parse_native_elf};
    let src = "\
        extern int ext_key;\n\
        static int *dead_tab[2] = { &ext_key, &ext_key };\n\
        static long dead_target = 7;\n\
        static long *dead_chain = &dead_target;\n\
        int keep(int x) { return x; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let bytes = reloc_tu(src, target, false);
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        assert!(
            !obj.symbols
                .iter()
                .any(|s| s.name == "ext_key" && s.section == NativeSymSection::Undef),
            "undefined ext_key must drop with the dead slots ({target:?})"
        );
        assert!(
            obj.data_relocs.is_empty(),
            "dead objects' .rela.data entries must drop ({target:?})"
        );
    }
}

#[test]
fn dead_static_fnptr_table_drops_table_and_callee() {
    // A static function referenced only from a static, itself
    // unreferenced, function-pointer table: the table's relocation is
    // not a root, so the table, the callee, and the callee's extern
    // reference all drop (gcc -O parity).
    use crate::c5::Target;
    use crate::c5::linker::{NativeSymSection, parse_native_elf};
    let src = "\
        extern int missing_ext(int);\n\
        static int helper(int x) { return missing_ext(x) + 1; }\n\
        static int (*const dead_tbl[1])(int) = { helper };\n\
        int keep(int x) { return x; }\n";
    let bytes = reloc_tu(src, Target::LinuxX64, false);
    assert!(
        !bytes.windows(6).any(|w| w == b"helper"),
        "table-only callee must drop with the dead table"
    );
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        !obj.symbols
            .iter()
            .any(|s| s.name == "missing_ext" && s.section == NativeSymSection::Undef),
        "the dead callee's extern reference must not surface as an undef"
    );
}

#[test]
fn static_fnptr_table_read_by_live_code_keeps_callee() {
    // Inverse guard for the reloc-edge rule: the same table read by an
    // external function keeps the table and, through its relocation
    // slot, the callee.
    let src = "\
        static int helper(int x) { return x + 1; }\n\
        static int (*const tbl[1])(int) = { helper };\n\
        int keep(int x) { return tbl[0](x); }\n";
    let bytes = reloc_tu(src, crate::c5::Target::LinuxX64, false);
    assert!(
        bytes.windows(6).any(|w| w == b"helper"),
        "callee reachable through a live table's relocation must survive"
    );
}

#[test]
fn asm_named_statics_survive_dce() {
    // A static function named only inside a live function's asm
    // template and a static object named only in file-scope asm are
    // referenced by the emitted sections; both must survive.
    let src = "\
        static int asm_fn(int x) { return x + 2; }\n\
        static long asm_blob[2] = { 0x1122334455667788L, 0 };\n\
        asm(\".pushsection .keepme,\\\"a\\\"\\n.quad asm_blob\\n.popsection\");\n\
        void keep(void) { __asm__ volatile(\"// asm_fn\" ::: \"memory\"); }\n";
    let bytes = reloc_tu(src, crate::c5::Target::LinuxAarch64, false);
    assert!(
        bytes.windows(6).any(|w| w == b"asm_fn"),
        "static named in a live function's asm template must survive"
    );
    let pat = 0x1122334455667788u64.to_le_bytes();
    assert!(
        bytes.windows(8).any(|w| w == pat),
        "static named in file-scope asm must keep its bytes"
    );
}

#[test]
fn used_and_section_statics_survive_dce() {
    // `__attribute__((used))` and named-section placement keep an
    // otherwise unreferenced internal definition: their consumers
    // resolve only at link time (kernel-style section protocols).
    let src = "\
        static long used_obj __attribute__((used)) = 0x2233445566778899L;\n\
        static long sect_obj __attribute__((section(\".keep2\"))) = 0x33445566778899aaL;\n\
        static __attribute__((section(\".text.keepf\"))) int sect_fn(int x) { return x; }\n\
        int keep(int x) { return x; }\n";
    let bytes = reloc_tu(src, crate::c5::Target::LinuxX64, false);
    assert!(
        bytes
            .windows(8)
            .any(|w| w == 0x2233445566778899u64.to_le_bytes()),
        "used-attributed static data must survive"
    );
    assert!(
        bytes
            .windows(8)
            .any(|w| w == 0x33445566778899aau64.to_le_bytes()),
        "named-section static data must survive"
    );
    // gcc parity: a named section alone does not retain a function
    // (`static inline` helpers headers pull in are section-attributed
    // wholesale via `__init`-style macros).
    assert!(
        !bytes.windows(7).any(|w| w == b"sect_fn"),
        "unreferenced section-only static function must drop"
    );
}

#[test]
fn unreferenced_static_data_drops_from_object() {
    // Plain dead static data (no relocations) leaves no bytes behind.
    let src = "\
        static long dead_obj[2] = { 0x445566778899aabbL, 0x5566778899aabbccL };\n\
        int keep(int x) { return x; }\n";
    let bytes = reloc_tu(src, crate::c5::Target::LinuxX64, false);
    assert!(
        !bytes
            .windows(8)
            .any(|w| w == 0x445566778899aabbu64.to_le_bytes()),
        "unreferenced static data must not keep its bytes"
    );
}

#[test]
fn block_static_lives_and_dies_with_its_function() {
    // A block-scope static exists only in an emitted instance of its
    // function. `used` + `section` on one (the addressable-record
    // idiom) keep it -- placed in its named section -- only while the
    // owner survives; with the owner dead, the object, its section,
    // and its extern relocation all drop, as a toolchain that never
    // instantiates the inline body emits nothing.
    use crate::c5::linker::{NativeSymSection, parse_native_elf};
    let dead = "\
        extern int ext_key;\n\
        static inline void helper(void) {\n\
            static void * __attribute__((__used__)) \
             __attribute__((__section__(\".discard.addressable\"))) rec = (void *)&ext_key;\n\
        }\n\
        int keep(int x) { return x; }\n";
    let bytes = reloc_tu(dead, crate::c5::Target::LinuxX64, false);
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        !obj.symbols
            .iter()
            .any(|s| s.name == "ext_key" && s.section == NativeSymSection::Undef),
        "a dead owner's used/section block static must drop with it"
    );
    assert!(
        !bytes.windows(20).any(|w| w == b".discard.addressable"),
        "no named section for a dropped block static"
    );

    let live = "\
        extern int ext_key;\n\
        static inline void helper(void) {\n\
            static void * __attribute__((__used__)) \
             __attribute__((__section__(\".discard.addressable\"))) rec = (void *)&ext_key;\n\
        }\n\
        int keep(int x) { helper(); return x; }\n";
    let bytes = reloc_tu(live, crate::c5::Target::LinuxX64, false);
    assert!(
        bytes.windows(20).any(|w| w == b".discard.addressable"),
        "a live owner's section-attributed block static goes to its section"
    );
}

#[test]
fn dead_block_static_pointer_array_drops_with_literals() {
    // A block-scope `static const char *const` table in a dead inline
    // helper: the emission record gives the array its own object
    // boundary and every literal start is recorded at lex time, so the
    // table, its relocations, and the string bytes all drop.
    use crate::c5::linker::parse_native_elf;
    let src = "\
        static inline const char *name_of(int a) {\n\
            static const char *const name_of[] = { \"qq-init\", \"qq-apply\" };\n\
            return name_of[a];\n\
        }\n\
        int keep(int x) { return x; }\n";
    let bytes = reloc_tu(src, crate::c5::Target::LinuxX64, false);
    assert!(
        !bytes.windows(7).any(|w| w == b"qq-init"),
        "a dead table's string literals must drop"
    );
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        obj.data_relocs.is_empty(),
        "a dead table's pointer relocations must drop"
    );
}

#[test]
fn automatic_initializer_materializes_addresses_without_data_relocs() {
    // C99 6.5.2.5p6 / 6.7.8: automatic storage (a compound literal, a
    // local aggregate) is built at runtime, so an address member --
    // `&global`, a function name, an array's decay -- is stored by the
    // code, not baked into a staged template as an absolute data
    // relocation. An abs-reloc-free link (vDSO, firmware stub) rejects
    // such template relocations.
    use crate::c5::linker::parse_native_elf;
    let src = "\
        struct dp { unsigned short limit; unsigned long base; } __attribute__((packed));\n\
        static const unsigned long gdt[3] = { 0, 1, 2 };\n\
        static int f1(int x) { return x + 1; }\n\
        extern void take(const struct dp *p);\n\
        void run(void) {\n\
            struct h { int (*fp)(int); const unsigned long *p; } s = { f1, gdt };\n\
            take(&(struct dp){ sizeof(gdt) - 1, (unsigned long)gdt });\n\
            take((const struct dp *)(void *)s.fp((int)s.p[0]));\n\
        }\n";
    for optimize in [false, true] {
        let bytes = reloc_tu(src, crate::c5::Target::LinuxX64, optimize);
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        assert!(
            obj.data_relocs.is_empty(),
            "automatic initializers must not emit .data relocations (optimize={optimize})"
        );
    }
}

#[test]
fn fam_struct_definition_survives_extern_redeclaration() {
    // C99 6.2.2p4 / 6.9.2p2: `extern struct S s;` after a tentative
    // definition of a flexible-array-member struct redeclares the same
    // object; the definition stands. The incomplete-struct extern arm
    // used to flip the symbol undefined, dropping the definition and
    // its initializer relocations from the object.
    use crate::c5::linker::{NativeSymSection, parse_native_elf};
    let src = "\
        struct SK { struct SK *next; };\n\
        struct Q { void (*fn)(void); struct SK gso; long priv[]; };\n\
        static void noop_fn(void) {}\n\
        struct Q nq = { .fn = noop_fn, .gso = { .next = (struct SK *)&nq.gso } };\n\
        extern struct Q nq;\n\
        int keep(int x) { return x; }\n";
    let bytes = reloc_tu(src, crate::c5::Target::LinuxX64, false);
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        obj.symbols.iter().any(|s| s.name == "nq"
            && matches!(s.section, NativeSymSection::Data | NativeSymSection::Bss)),
        "the definition must survive the extern redeclaration"
    );
    assert!(
        bytes.windows(7).any(|w| w == b"noop_fn"),
        "the initializer's callee must stay reachable through the live table"
    );
}

#[test]
fn zero_sized_static_keeps_a_distinct_start() {
    // A zero-sized static (empty struct, GNU) reserves one slot: the
    // interval model and the named-section carve identify objects by
    // start offset, so a zero-size object sharing the next object's
    // start would be attributed to it -- here, an address-taken key
    // would follow a section-attributed record into its carved
    // section, dangling once a link discards that section.
    use crate::c5::linker::parse_native_elf;
    let src = "\
        typedef unsigned long uintptr_t;\n\
        extern int ext_key;\n\
        extern int consume(void *a, void *b);\n\
        struct lk {};\n\
        static inline int helper(int v) {\n\
            static struct lk key1;\n\
            static void * __attribute__((__used__)) \
             __attribute__((__section__(\".discard.addressable\"))) rec\n\
                = (void *)(uintptr_t)&ext_key;\n\
            static struct lk key2;\n\
            return consume(&key1, &key2) + v;\n\
        }\n\
        int keep(int x) { return helper(x); }\n";
    let bytes = reloc_tu(src, crate::c5::Target::LinuxX64, false);
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    // Each key occupies its own wholly-zero slot, so both references
    // resolve against `.bss`. A zero-size key sharing the record's
    // start resolves into the record's carved section instead -- and
    // dangles once a link discards that section.
    let bss_refs = obj
        .text_relocs
        .iter()
        .filter(|r| {
            obj.symbols
                .get(r.sym_idx)
                .is_some_and(|s| s.section == crate::c5::linker::NativeSymSection::Bss)
        })
        .count();
    assert!(
        bss_refs >= 2,
        "both zero-sized keys must resolve in .bss (got {bss_refs})"
    );
}

#[test]
fn underscore_prefixed_static_drops_after_inline() {
    // gcc parity: a leading underscore does not retain a static. The
    // helper's only call is inlined at -O, after which the post-inline
    // DCE rerun must drop the out-of-line body.
    let src = "\
        static int __only_call(int x) { return x + 3; }\n\
        int keep(int x) { return __only_call(x); }\n";
    let bytes = reloc_tu(src, crate::c5::Target::LinuxX64, true);
    assert!(
        !bytes.windows(11).any(|w| w == b"__only_call"),
        "underscore-prefixed static must drop once its only call is inlined"
    );
}

#[test]
fn always_inline_immediate_asm_operand_drops_standalone_body() {
    // An always_inline accessor whose inline asm has an `i`
    // (immediate-only) operand built from a parameter -- `1 << (bit & 7)`
    // -- is an integer-constant-expression (C99 6.6) only once inlining
    // substitutes a constant argument, so it is uncompilable out of line.
    // The `_`-prefix static-DCE retention kept such a body even after the
    // caller inlined it, and its out-of-line emit then failed on the
    // non-constant immediate. It must drop; the caller keeps the folded imm.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        extern unsigned char cap[64];\n\
        static __attribute__((always_inline)) inline void _touch_bit(unsigned short bit) {\n\
            __asm__ volatile(\"testb %0, %1\\n\\t\" : : \"i\"(1 << (bit & 7)), \"m\"(cap[bit >> 3]));\n\
        }\n\
        void probe(void) { _touch_bit(15); }\n";
    let copts = CompileOptions {
        no_entry_point: true,
        gnu: true,
        ..Default::default()
    };
    let program = Compiler::with_options(String::from(src), Target::LinuxX64, copts)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        optimize: true,
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    // The out-of-line emit of `_touch_bit` failed before the fix, so a
    // successful emit is itself part of the regression guard.
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let has_standalone = bytes.windows(10).any(|w| w == b"_touch_bit");
    assert!(
        !has_standalone,
        "the inlined always_inline accessor must not keep an out-of-line body"
    );
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    // `testb $imm8, r/m8` is `F6 /0 ib`; the caller carries the folded
    // immediate `1 << (15 & 7) == 0x80`. `w[1] & 0x38 == 0` pins the ModRM
    // reg field to the `/0` TEST extension (not NOT / NEG / MUL / ...).
    let has_folded_imm = obj
        .text
        .windows(3)
        .any(|w| w[0] == 0xf6 && (w[1] & 0x38) == 0 && w[2] == 0x80);
    assert!(
        has_folded_imm,
        "the folded `1 << (bit & 7)` immediate must materialize at the call site"
    );
}

#[test]
fn asm_replacement_mem_operand_resolves_nested_global_offset() {
    // A replacement instruction in an executable inline-asm section
    // (`.pushsection ...,"ax"`) whose `%a[N]` memory operand names a
    // link-time address `&global.member[const]` must lower to a
    // RIP-relative reference. That address is a chain of constant `Add`s
    // (the member offset, then the element offset); resolving only the
    // outermost level left the base unrecognized and rejected the operand
    // as having no register. `testb $imm8, sym(%rip)` encodes
    // `F6 05 <disp32> <imm8>` with a PC32 relocation against the symbol,
    // the addend folding the whole offset chain less the 4-byte PC skew
    // and the trailing immediate -- byte-identical to gas.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_PC32: u32 = 2;
    let src = r#"
        struct s { int a; long b; unsigned int cap[24]; };
        extern struct s g;
        static __attribute__((always_inline)) inline void touch(unsigned short n) {
            __asm__ volatile(".pushsection .altinstr_aux,\"ax\"\n"
                "1: testb %[bit], %a[addr]\n"
                ".popsection\n"
                : : [bit] "i" (1 << (n & 7)),
                    [addr] "i" (&((const char *)g.cap)[n >> 3]));
        }
        int main(void) { touch(117); return 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        optimize: true,
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    // The replacement emit rejected the nested-offset operand before the
    // fix, so a successful emit is itself part of the guard.
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    // `testb $0x20, sym(%rip)` == `F6 05 <disp32=0> 20`; ModRM 0x05 is the
    // `/0` TEST extension over a RIP-relative base. `1 << (117 & 7) == 0x20`.
    let field = obj
        .text
        .windows(7)
        .position(|w| w == [0xf6, 0x05, 0x00, 0x00, 0x00, 0x00, 0x20])
        .expect("RIP-relative `testb $0x20, sym(%rip)` must be encoded");
    // The disp32 field sits two bytes into the instruction. `g.cap` is at
    // offset 16 and the `[117 >> 3] == [14]` byte index adds 14; the PC32
    // addend subtracts the 4-byte PC skew and the 1-byte trailing immediate:
    // 16 + 14 - 4 - 1 == 25.
    let disp_off = (field + 2) as u64;
    let reloc = obj
        .text_relocs
        .iter()
        .find(|r| r.offset == disp_off)
        .expect("the replacement's disp32 must carry a relocation");
    assert_eq!(
        reloc.rtype, R_X86_64_PC32,
        "the RIP-relative memory operand must relocate as PC32"
    );
    assert_eq!(
        obj.symbols[reloc.sym_idx].name, "g",
        "the reloc must target the named global"
    );
    assert_eq!(
        reloc.addend, 25,
        "the addend must fold the member + element offset less PC skew and imm"
    );
}

#[test]
fn asm_replacement_lea_of_mem_operand_uses_register_indirect() {
    // A memory-constraint (`m`) operand as the source of a `lea` inside an
    // executable replacement section: `%N` is the operand's address, held in
    // the operand's assigned register, so it lowers to the register-indirect
    // form `lea (%reg), %rdi` -- the same lowering the main code stream uses.
    // Before the fix the section encoder resolved the `m` operand to a bare
    // register and rejected `lea` (a register source has no `lea` encoding),
    // so a successful emit carrying an `8D` ModRM over a register base is the
    // guard.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        static int sel_data;
        void sel(void) {
            __asm__ volatile(".pushsection .altinstr_replacement,\"ax\"\n"
                "lea %[mem], %%rdi\n"
                ".popsection\n"
                : : [mem] "m" (sel_data) : "rdi");
        }
        int main(void) { sel(); return 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let repl = &sections
        .iter()
        .find(|(n, _, _, _)| n == ".altinstr_replacement")
        .expect(".altinstr_replacement present")
        .3;
    // `lea (%reg), %rdi` is `REX.W 8D ModRM`: reg field 7 (%rdi), mod=00. The
    // base register is the free-pool choice; assert the opcode and the %rdi
    // destination without pinning it.
    assert!(
        repl.len() >= 3
            && repl[0] == 0x48
            && repl[1] == 0x8d
            && (repl[2] >> 3) & 7 == 7
            && repl[2] >> 6 == 0,
        "replacement must be `lea (%reg), %rdi` (48 8D /r, reg=7, mod=00): {repl:02x?}"
    );
    // A register-indirect base: rm is neither 4 (SIB) nor 5 (RIP-relative), so
    // the `lea` carries no relocation -- the address already lives in a
    // register the surrounding code loaded.
    assert!(
        (repl[2] & 7) != 4 && (repl[2] & 7) != 5,
        "the `m` operand lowers to a register base, not RIP-relative or SIB: {repl:02x?}"
    );
}

#[test]
fn asm_replacement_seg_qualified_mem_operand_keeps_prefix() {
    // A `__seg_gs`-qualified `m` operand inside a replacement section keeps
    // its segment override: the 0x65 prefix precedes the encoded body, as in
    // the main code stream.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        static unsigned long __seg_gs *gp;
        unsigned long f(void) {
            unsigned long r;
            __asm__(".pushsection .altinstr_replacement,\"ax\"\n"
                "movq %[mem], %0\n"
                ".popsection\n"
                "movq %[mem], %0\n"
                : "=r"(r) : [mem] "m"(*gp));
            return r;
        }
        int main(void) { return 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let repl = &sections
        .iter()
        .find(|(n, _, _, _)| n == ".altinstr_replacement")
        .expect(".altinstr_replacement present")
        .3;
    // `movq %gs:(%reg), %rax` is `65 REX.W 8B ModRM` with mod=00.
    assert!(
        repl.len() >= 4
            && repl[0] == 0x65
            && repl[1] == 0x48
            && repl[2] == 0x8b
            && repl[3] >> 6 == 0,
        "replacement must keep the gs override (65 48 8B /r, mod=00): {repl:02x?}"
    );
}

#[test]
fn asm_main_stream_reference_binds_label_in_pushed_section() {
    // A GNU-as local label defined inside a `.pushsection ...,"ax"` block is
    // in scope for the surrounding asm's main instruction stream: `jmp 6f`
    // reaches a `6:` placed in that section. The two land in different object
    // sections, so the branch cannot carry an in-stream displacement; it
    // becomes a PC-relative relocation against the section symbol, the label's
    // placed offset folded into the addend less the 4-byte field skew. Here
    // `6:` sits 3 bytes into the section, so the addend is `3 - 4 == -1`,
    // byte-identical to gas. Before the fix the reference reported the label
    // undefined, so the emit succeeding is itself part of the guard.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_PC32: u32 = 2;
    let src = r#"
        void f(void) {
            __asm__ volatile(
                "jmp 6f\n\t"
                ".pushsection .altcode,\"ax\"\n"
                ".byte 0x90, 0x90, 0x90\n"
                "6:\n"
                "\tnop\n"
                ".popsection\n");
        }
        int main(void) { f(); return 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    // `jmp rel32` is `E9 <disp32>`; a zeroed displacement means the linker
    // fills it through the relocation rather than the emit patching it in
    // place, which is what a same-section target would take.
    let jmp = obj
        .text
        .windows(5)
        .position(|w| w == [0xe9, 0x00, 0x00, 0x00, 0x00])
        .expect("main-stream `jmp 6f` must encode as `E9 00000000`");
    let reloc = obj
        .text_relocs
        .iter()
        .find(|r| r.offset == (jmp + 1) as u64)
        .expect("the cross-section branch's disp32 must carry a relocation");
    assert_eq!(
        reloc.rtype, R_X86_64_PC32,
        "a branch into another section relocates as PC32"
    );
    assert_eq!(
        reloc.addend, -1,
        "the addend folds the label's in-section offset (3) less the 4-byte PC skew"
    );
    assert!(
        obj.symbols[reloc.sym_idx].name.is_empty(),
        "the reference binds the pushed section's symbol, not a named symbol"
    );
}

#[test]
fn asm_label_address_immediate_relocates_absolute() {
    // `pushq $1f` pushes the address of a template-local label as an absolute
    // immediate: gas encodes it as `68 <imm32>` (push imm32, never the imm8
    // form, which has no room for the address) and relocates the field as
    // `R_X86_64_32S` against `.text` with the label's offset as addend. Both
    // the encoding and the reloc are byte-identical to `gcc -O2 -c`.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_32S: u32 = 11;
    let src = r#"
        void f(void) {
            __asm__ volatile(
                "pushq %%rsp\n\t"
                "pushfq\n\t"
                "pushq $1f\n\t"
                "iretq\n\t"
                "1:\n\t"
                ::: "memory");
        }
        int main(void) { f(); return 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    // `push imm32` is `68` then a zeroed field the relocation fills; the imm8
    // form (`6A`) could not carry the address.
    let push = obj
        .text
        .windows(5)
        .position(|w| w == [0x68, 0x00, 0x00, 0x00, 0x00])
        .expect("`pushq $1f` must encode as `68 00000000`");
    // `1:` sits right after `iretq` (`48 CF`), which follows the push.
    let iretq = obj.text[push + 5..]
        .windows(2)
        .position(|w| w == [0x48, 0xcf])
        .map(|p| push + 5 + p)
        .expect("`iretq` must follow the push");
    let label_off = iretq + 2;
    let reloc = obj
        .text_relocs
        .iter()
        .find(|r| r.offset == (push + 1) as u64)
        .expect("the imm32 field must carry a relocation");
    assert_eq!(
        reloc.rtype, R_X86_64_32S,
        "a label-address immediate relocates as absolute 32S, not PC-relative"
    );
    assert!(
        obj.symbols[reloc.sym_idx].name.is_empty(),
        "the reference binds the `.text` section symbol"
    );
    assert_eq!(
        reloc.addend, label_off as i64,
        "the addend is the label's text offset (right after `iretq`)"
    );
}

#[test]
fn asm_label_address_immediate_into_register_relocates_absolute() {
    // `movq $1f, %reg` takes a template-local label's address as an absolute
    // immediate the same way `pushq $1f` does. gas encodes it as the
    // sign-extended imm32 form (`48 C7 C0+r`) and relocates the field
    // `R_X86_64_32S`; the label may sit in a pushed section, in which case the
    // reference binds that section's symbol instead of `.text`. Both
    // encodings are byte-identical to the reference assembler.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_32S: u32 = 11;
    let src = r#"
        const void *f(void) {
            const void *p;
            __asm__ volatile(
                "movq $1f,%0\n"
                ".section .probe_addrs,\"a\"\n"
                "1:\t.word 7\n\t"
                ".previous"
                : "=r"(p));
            return p;
        }
        int main(void) { return f() != 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    // `mov r64, imm32` is `48 C7 C0+r` then a zeroed field the relocation
    // fills; the imm64 (`movabs`) form is longer and gas does not pick it.
    let mov = obj
        .text
        .windows(7)
        .position(|w| w[0] == 0x48 && w[1] == 0xc7 && w[3..] == [0, 0, 0, 0])
        .expect("`movq $1f,%reg` must encode as `48 c7 c0+r 00000000`");
    let reloc = obj
        .text_relocs
        .iter()
        .find(|r| r.offset == (mov + 3) as u64)
        .expect("the imm32 field must carry a relocation");
    assert_eq!(
        reloc.rtype, R_X86_64_32S,
        "a label-address immediate relocates as absolute 32S, not PC-relative"
    );
    assert_eq!(
        reloc.addend, 0,
        "the label sits at the start of the pushed section"
    );
}

/// Read `st_other` (visibility byte) of the first `.symtab` entry named
/// `want` from a raw ELF64 object. `parse_native_elf` drops visibility, so
/// the byte is read directly.
#[cfg(test)]
fn elf_symbol_st_other(bytes: &[u8], want: &str) -> u8 {
    let rd16 = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let rd32 = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let rd64 = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let e_shoff = rd64(0x28) as usize;
    let e_shentsize = rd16(0x3a) as usize;
    let e_shnum = rd16(0x3c) as usize;
    const SHT_SYMTAB: u32 = 2;
    for i in 0..e_shnum {
        let sh = e_shoff + i * e_shentsize;
        if rd32(sh + 4) != SHT_SYMTAB {
            continue;
        }
        let sym_off = rd64(sh + 0x18) as usize;
        let sym_size = rd64(sh + 0x20) as usize;
        let str_off = {
            let strtab = rd32(sh + 0x28) as usize;
            rd64(e_shoff + strtab * e_shentsize + 0x18) as usize
        };
        let mut p = sym_off;
        while p + 24 <= sym_off + sym_size {
            let name_start = str_off + rd32(p) as usize;
            let name_len = bytes[name_start..].iter().position(|&b| b == 0).unwrap();
            if &bytes[name_start..name_start + name_len] == want.as_bytes() {
                return bytes[p + 5]; // st_other
            }
            p += 24;
        }
    }
    panic!("symbol `{want}` not found in .symtab");
}

#[test]
fn weak_hidden_undef_addressof_is_pc_relative_direct() {
    // The `symbol_get(x)` kernel idiom (CONFIG_MODULES off):
    //   ({ extern typeof(x) x __attribute__((weak,visibility("hidden"))); &(x); })
    // A block-scope extern redeclaration marks an already-known name weak and
    // hidden and takes its address. gcc emits the symbol WEAK HIDDEN UND and
    // the address-of GOT-free -- a RIP-relative `lea` (R_X86_64_PC32) on
    // x86_64, a direct adrp+add pair on aarch64 -- so a static link resolves
    // the undefined weak to 0 with an empty GOT. Match that reloc form plus
    // STB_WEAK binding and STV_HIDDEN visibility on both ELF targets.
    use crate::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_PC32: u32 = 2;
    const R_AARCH64_ADR_PREL_PG_HI21: u32 = 275;
    const R_AARCH64_ADD_ABS_LO12_NC: u32 = 277;
    const STB_WEAK: u8 = 2;
    const STV_HIDDEN: u8 = 2;
    let src = "extern int probe(void);\n\
               #define symbol_get(x) \
               ({ extern typeof(x) x __attribute__((weak, visibility(\"hidden\"))); &(x); })\n\
               void *take(void) { return symbol_get(probe); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let copts = CompileOptions {
            no_entry_point: true,
            ..Default::default()
        };
        let program = Compiler::with_options(String::from(src), target, copts)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let sym_idx = obj
            .symbols
            .iter()
            .position(|s| s.name == "probe")
            .expect("probe symbol present");
        assert!(
            matches!(obj.symbols[sym_idx].section, NativeSymSection::Undef),
            "probe stays undefined"
        );
        assert_eq!(
            obj.symbols[sym_idx].binding, STB_WEAK,
            "the weak attribute binds STB_WEAK"
        );
        assert_eq!(
            elf_symbol_st_other(&bytes, "probe"),
            STV_HIDDEN,
            "visibility(\"hidden\") sets STV_HIDDEN"
        );
        let relocs: alloc::vec::Vec<_> = obj
            .text_relocs
            .iter()
            .filter(|r| r.sym_idx == sym_idx)
            .collect();
        if target == Target::LinuxX64 {
            assert_eq!(relocs.len(), 1, "one address-of reloc against probe");
            assert_eq!(
                relocs[0].rtype, R_X86_64_PC32,
                "hidden address-of is a direct lea (PC32), not a GOT load"
            );
            assert_eq!(relocs[0].addend, -4, "PC32 end-of-field skew, matching gcc");
        } else {
            let types: alloc::vec::Vec<u32> = relocs.iter().map(|r| r.rtype).collect();
            assert!(
                types.contains(&R_AARCH64_ADR_PREL_PG_HI21)
                    && types.contains(&R_AARCH64_ADD_ABS_LO12_NC),
                "hidden address-of is a direct adrp+add pair, not a GOT page load, got {types:?}"
            );
        }
    }
}

#[test]
fn file_scope_asm_assembles_instructions_in_rodata() {
    // A file-scope asm whose `.pushsection .rodata` holds a trampoline body:
    // GNU as assembles instructions into any section, the flags only setting
    // the object section's attributes. The section token classifier rejected a
    // non-directive token unless the section was `"ax"`-flagged, so the `pushq`
    // reported an unsupported directive. A `.rodata` given without explicit
    // flags is allocatable, as GNU as knows the name.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"asm(
        ".pushsection .rodata\n"
        "tmpl:\n"
        "\tpushq $0x18\n"
        "\tpushq %rsp\n"
        "\tpushfq\n"
        "\tpushq %r15\n"
        "\tpopq %r15\n"
        "\tpopfq\n"
        ".popsection\n");
    "#;
    let program = Compiler::with_options(
        src.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    // Before the fix the `pushq` reported an unsupported directive, so a
    // successful emit is itself part of the guard.
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    // `pushq $0x18; pushq %rsp; pushfq` is `6A 18 54 9C`, byte-identical to gas.
    assert!(
        bytes.windows(4).any(|w| w == [0x6a, 0x18, 0x54, 0x9c]),
        "the trampoline body must assemble to bytes in the object"
    );
    const SHF_ALLOC: u64 = 0x2;
    assert_eq!(
        elf_section_flags(&bytes, b".rodata") & SHF_ALLOC,
        SHF_ALLOC,
        "`.rodata` given without flags is allocatable, as gas knows the name"
    );
}

#[test]
fn file_scope_asm_assembles_a_trampoline_body() {
    // A file-scope asm that defines a whole function in the default section --
    // `.global`/`.type` (a forward reference, before the label) then a label,
    // instructions, and `.size` -- is assembled as a `.text` section, not
    // rejected as linkage-only. The symbol carries STT_FUNC / STB_GLOBAL and
    // the `.size` byte span, matching `gcc -O2 -c`.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const STB_GLOBAL: u8 = 1;
    const STT_FUNC: u8 = 2;
    let src = r#"
        asm(".global handler\n\t"
            ".type handler, @function\n\t"
            "handler:\n\t"
            "ret; int3\n\t"
            ".size handler, . - handler\n\t");
        int main(void) { return 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let handler = obj
        .symbols
        .iter()
        .find(|s| s.name == "handler")
        .expect("`handler` must be defined by the asm");
    assert_eq!(handler.kind, STT_FUNC, "`.type @function` sets STT_FUNC");
    assert_eq!(handler.binding, STB_GLOBAL, "`.global` sets STB_GLOBAL");
    assert_eq!(handler.size, 2, "`.size handler, .-handler` is `ret; int3`");
}

#[test]
fn file_scope_asm_push_symbol_address_relocates_32s() {
    // `pushq $symbol` in a file-scope trampoline pushes the symbol's address as
    // an absolute immediate: `68 <imm32>` with an `R_X86_64_32S` relocation
    // against the symbol, byte-identical to gcc. The `.text` shorthand opens the
    // section and `call sym` relocates as `PLT32`.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_32S: u32 = 11;
    let src = r#"
        extern void cb(void);
        asm(".text\n"
            ".global tramp\n"
            ".type tramp, @function\n"
            "tramp:\n"
            "\tpushq $tramp\n"
            "\tcall cb\n"
            "\tret\n"
            ".size tramp, .-tramp\n");
        int main(void) { return 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let push = obj
        .text
        .windows(5)
        .position(|w| w == [0x68, 0x00, 0x00, 0x00, 0x00])
        .expect("`pushq $tramp` must encode as `68 00000000`");
    let reloc = obj
        .text_relocs
        .iter()
        .find(|r| r.offset == (push + 1) as u64)
        .expect("the imm32 field must carry a relocation");
    assert_eq!(
        reloc.rtype, R_X86_64_32S,
        "a symbol-address immediate relocates as absolute 32S"
    );
    assert_eq!(
        obj.symbols[reloc.sym_idx].name, "tramp",
        "the reloc targets the named symbol"
    );
    assert_eq!(reloc.addend, 0, "gcc folds no addend into a `$symbol` push");
}

#[test]
fn file_scope_asm_symbol_displacement_memory_relocates_32s() {
    // A no-base scaled-index reference with a symbol displacement
    // (`sym(,%rdi,8)`) and a based reference with a constant+symbol
    // displacement (`16+sym(%rax)`) each take an absolute `R_X86_64_32S`
    // in their disp32 field, byte-identical to gcc:
    //   48 8b 04 fd <disp32>    mov sym(,%rdi,8),%rax
    //   80 b8 <disp32> 00       cmpb $0, 16+sym(%rax)
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_32S: u32 = 11;
    let src = super::load_fixture("file_scope_asm_sym_mem.c");
    let program = Compiler::with_target(src, Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let movq = obj
        .text
        .windows(8)
        .position(|w| w == [0x48, 0x8b, 0x04, 0xfd, 0, 0, 0, 0])
        .expect("`mov sym(,%rdi,8),%rax` must encode as `48 8b 04 fd <disp32>`");
    let r1 = obj
        .text_relocs
        .iter()
        .find(|r| r.offset == (movq + 4) as u64)
        .expect("the scaled-index disp32 field must carry a relocation");
    assert_eq!(r1.rtype, R_X86_64_32S, "index-form displacement is 32S");
    let cmpb = obj
        .text
        .windows(7)
        .position(|w| w == [0x80, 0xb8, 0, 0, 0, 0, 0])
        .expect("`cmpb $0, 16+sym(%rax)` must encode as `80 b8 <disp32> 00`");
    let r2 = obj
        .text_relocs
        .iter()
        .find(|r| r.offset == (cmpb + 2) as u64)
        .expect("the based disp32 field must carry a relocation");
    assert_eq!(r2.rtype, R_X86_64_32S, "based displacement is 32S");
}

#[test]
fn file_scope_asm_jcc_to_section_label_and_lock_prefix() {
    // `jne .slowpath` inside a pushed section branches to a label defined
    // later in the same section: the rel32 `0f 85` form with a branch
    // relocation the linker resolves against the local label symbol. The
    // `lock cmpxchg` line encodes with the `f0` prefix in front.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_PLT32: u32 = 4;
    let src = super::load_fixture("file_scope_asm_local_label_branch.c");
    let program = Compiler::with_target(src, Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        obj.text.windows(4).any(|w| w == [0xf0, 0x0f, 0xb0, 0x17]),
        "`lock cmpxchg %dl,(%rdi)` must encode as `f0 0f b0 17`"
    );
    let jne = obj
        .text
        .windows(6)
        .position(|w| w == [0x0f, 0x85, 0, 0, 0, 0])
        .expect("`jne .slowpath` must encode as `0f 85 <rel32>`");
    let r = obj
        .text_relocs
        .iter()
        .find(|r| r.offset == (jne + 2) as u64)
        .expect("the rel32 field must carry a relocation");
    assert_eq!(r.rtype, R_X86_64_PLT32, "a branch relocates as PLT32");
    assert_eq!(
        obj.symbols[r.sym_idx].name, ".slowpath",
        "the reloc targets the section-local label"
    );
    assert_eq!(r.addend, -4, "rel32 branch addend is -4");
}

/// `sh_flags` of the first section named `want` in an ELF64 object, or 0.
fn elf_section_flags(bytes: &[u8], want: &[u8]) -> u64 {
    let u16a = |o: usize| u16::from_le_bytes([bytes[o], bytes[o + 1]]) as usize;
    let u32a = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap()) as usize;
    let u64a = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let (shoff, shentsize, shnum, shstrndx) =
        (u64a(0x28) as usize, u16a(0x3a), u16a(0x3c), u16a(0x3e));
    let stroff = u64a(shoff + shstrndx * shentsize + 0x18) as usize;
    (0..shnum)
        .map(|i| shoff + i * shentsize)
        .find(|&sh| {
            let name_at = stroff + u32a(sh);
            bytes[name_at..].starts_with(want) && bytes[name_at + want.len()] == 0
        })
        .map(|sh| u64a(sh + 8))
        .unwrap_or(0)
}

#[test]
fn asm_lsl_encodes_32bit_destination_form() {
    // `lsl` loads a segment limit into a register: the source is a 16-bit
    // selector but the destination may be 32-bit, so the operands are written
    // as 32-bit registers (`lsl %edx, %eax`). The instruction database's
    // uniform-width `r/m` model omits that `r32/m16` form, so the encoder
    // reported no encoding; the 32-bit form is `0F 03 /r` (no operand-size
    // prefix, no REX.W), byte-identical to gas.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        unsigned f(unsigned sel) {
            unsigned lim;
            __asm__("lsl %1, %0" : "=r"(lim) : "r"(sel));
            return lim;
        }
        int main(void) { return (int)f(0); }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    // `0F 03 /r` with a register r/m: modrm is `11 reg rm`, so `w[2] & 0xC0`
    // pins the register-direct form. No `66` and no `48` REX.W precede it.
    let lsl = obj
        .text
        .windows(3)
        .position(|w| w[0] == 0x0f && w[1] == 0x03 && (w[2] & 0xc0) == 0xc0)
        .expect("`lsl` must encode as the 32-bit `0F 03 /r` form");
    assert!(
        lsl == 0 || obj.text[lsl - 1] != 0x66,
        "the 32-bit form takes no operand-size prefix"
    );
}

#[test]
fn thread_local_storage_round_trips_through_et_rel() {
    // `_Thread_local` storage now rides the native ET_REL object:
    // elf_reloc emits `.tdata` (initialised slice) + `.tbss`
    // (zero-fill remainder), and `parse_native_elf` concatenates
    // them back into `tls_data` / `tls_bss_size`. Verifies the
    // bytes survive the write -> parse round-trip; the link-time
    // PT_TLS layout is guarded separately until it lands.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         _Thread_local int counter = 7;\n\
         int main(void) {{ counter += 1; return counter; }}\n"
    ))
    .compile()
    .expect("compile");
    assert!(
        !program.tls_data.is_empty(),
        "source declares `_Thread_local`, so tls_data must be non-empty"
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(6).any(|w| w == b".tdata"),
        "ET_REL must carry a `.tdata` section header name"
    );
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let total = obj.tls_data.len() + obj.tls_bss_size;
    assert_eq!(
        total,
        program.tls_data.len(),
        "round-tripped TLS size (tdata + tbss) must match the source's tls_data",
    );
    // `counter = 7` is a 4-byte initialised int; its little-endian
    // image leads the `.tdata` bytes.
    assert!(
        obj.tls_data.starts_with(&7i32.to_le_bytes()),
        "initialised TLS byte image must round-trip; got {:?}",
        obj.tls_data,
    );
}

#[test]
fn thread_local_storage_links_into_pt_tls_executable() {
    // A single `_Thread_local`-bearing object links through the
    // native path into an executable with a PT_TLS segment. The
    // local-exec tpoff baked into `.text` stays valid because the
    // merged TLS block keeps the source's size: `link_native_objects`
    // carries the single unit's `tls_data` / `tls_init_size` forward
    // and `write_native_image_from_merged` lays out PT_TLS from them.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         _Thread_local int counter = 7;\n\
         int main(void) {{ counter += 1; return counter; }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(
        merged.tls_init_size, program.tls_init_size,
        "merged tls_init_size must match the source's"
    );
    assert_eq!(
        merged.tls_data.len(),
        program.tls_data.len(),
        "merged tls_data length must match the source's total TLS size"
    );
    assert!(
        merged.tls_data.starts_with(&7i32.to_le_bytes()),
        "initialised TLS image must survive the merge"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::LinuxX64,
        None,
    )
    .expect("write executable");
    // ELF64: e_phoff @ 0x20 (u64), e_phentsize @ 0x36 (u16),
    // e_phnum @ 0x38 (u16). Scan the program header table for a
    // PT_TLS (p_type == 7) whose p_filesz covers the 4-byte int.
    let phoff = u64::from_le_bytes(exe[0x20..0x28].try_into().unwrap()) as usize;
    let phentsize = u16::from_le_bytes(exe[0x36..0x38].try_into().unwrap()) as usize;
    let phnum = u16::from_le_bytes(exe[0x38..0x3a].try_into().unwrap()) as usize;
    const PT_TLS: u32 = 7;
    let pt_tls = (0..phnum).find_map(|i| {
        let base = phoff + i * phentsize;
        let p_type = u32::from_le_bytes(exe[base..base + 4].try_into().unwrap());
        if p_type == PT_TLS {
            // p_filesz @ +0x20, p_memsz @ +0x28 within the phdr.
            let p_filesz = u64::from_le_bytes(exe[base + 0x20..base + 0x28].try_into().unwrap());
            let p_memsz = u64::from_le_bytes(exe[base + 0x28..base + 0x30].try_into().unwrap());
            Some((p_filesz, p_memsz))
        } else {
            None
        }
    });
    let (p_filesz, p_memsz) = pt_tls.expect("executable must carry a PT_TLS segment");
    assert_eq!(
        p_filesz, program.tls_init_size as u64,
        "PT_TLS p_filesz must equal the initialised TLS image size"
    );
    assert_eq!(
        p_memsz,
        program.tls_data.len() as u64,
        "PT_TLS p_memsz must cover the full per-thread TLS block"
    );
}

#[test]
fn macho_tlv_descriptors_round_trip_through_et_rel() {
    // A macOS `_Thread_local` access lowers to a TLV-descriptor call
    // whose descriptor offset + adrp fixup ride the ET_REL
    // `.note.badc` NT_BADC_MACHO_TLV_DESC / NT_BADC_MACHO_TLV_FIXUP
    // records. parse_native_elf recovers them and link_native_objects
    // rebases the fixups into the merged `.text`, so the Mach-O writer
    // materialises the `__thread_vars` descriptors.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        alloc::format!(
            "{TEST_PRELUDE}\
             _Thread_local int counter = 7;\n\
             int main(void) {{ counter += 1; return counter; }}\n"
        ),
        Target::MacOSAarch64,
        crate::c5::CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        !obj.macho_tlv_descriptors.is_empty(),
        "the macOS `_Thread_local` variable must surface a TLV descriptor via the note"
    );
    assert!(
        !obj.macho_tlv_fixups.is_empty(),
        "the macOS `_Thread_local` access must surface a TLV fixup via the note"
    );
    let nd = obj.macho_tlv_descriptors.len();
    let nf = obj.macho_tlv_fixups.len();
    let merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(merged.macho_tlv_descriptors.len(), nd);
    assert_eq!(merged.macho_tlv_fixups.len(), nf);
}

#[test]
fn win64_tls_index_fixups_round_trip_through_et_rel() {
    // A Windows `_Thread_local` access lowers to a `_tls_index` TEB
    // lookup whose fixup site rides the ET_REL `.note.badc`
    // NT_BADC_TLS_INDEX record. parse_native_elf recovers the byte
    // offsets and link_native_objects rebases them into the merged
    // `.text`, so the PE writer can patch each site.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        alloc::format!(
            "{TEST_PRELUDE}\
             _Thread_local int counter = 7;\n\
             int main(void) {{ counter += 1; return counter; }}\n"
        ),
        Target::WindowsAarch64,
        crate::c5::CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::WindowsAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        !obj.tls_index_fixups.is_empty(),
        "the Windows `_Thread_local` access must surface a tls_index fixup via the note"
    );
    let n = obj.tls_index_fixups.len();
    let merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(
        merged.tls_index_fixups.len(),
        n,
        "the linker must carry every tls_index fixup into the merged image"
    );
}

#[test]
fn pragma_export_round_trips_into_shared_library() {
    // `#pragma export(<name>)` rides the ET_REL `.note.badc`
    // NT_BADC_EXPORTS record: `parse_native_elf` recovers the name,
    // `link_native_objects` unions it, and the shared-library writer
    // promotes only the exported name. A symbol not named by the
    // pragma stays private.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         #pragma export(exported_fn)\n\
         int exported_fn(int x) {{ return x + 1; }}\n\
         int internal_fn(int x) {{ return x + 2; }}\n\
         int main(void) {{ return exported_fn(1) + internal_fn(1); }}\n"
    ))
    .compile()
    .expect("compile");
    assert!(
        program.exports.iter().any(|e| e.name == "exported_fn"),
        "compiler must record the `#pragma export` name"
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        obj.exports.contains(&"exported_fn".to_string()),
        "export name must round-trip through the `.note.badc` record"
    );
    assert!(
        !obj.exports.contains(&"internal_fn".to_string()),
        "a symbol not named by `#pragma export` must not appear in the note"
    );
    let mut merged = link_native_objects(&[obj]).expect("link");
    assert_eq!(
        merged.exports,
        alloc::vec!["exported_fn".to_string()],
        "linker unions only the exported names"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let so = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
        None,
    )
    .expect("write shared library");
    // e_type @ 0x10: ET_DYN (3) for a shared object.
    assert_eq!(
        u16::from_le_bytes(so[0x10..0x12].try_into().unwrap()),
        3,
        "shared library must be ET_DYN"
    );
}

#[test]
fn export_all_executable_exposes_dynamic_symbols() {
    // The same exports go into an executable's `.dynsym` (the
    // `-rdynamic` behavior) so a `dlopen`'d module resolves the host's
    // symbols from the global scope. An `--export-all` executable is
    // ET_EXEC and carries its exported symbol name; an ordinary
    // executable does not export it.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let build_exe = |export_all: bool| -> alloc::vec::Vec<u8> {
        let copts = CompileOptions::default().with_export_all_functions(export_all);
        let program = Compiler::with_options(
            alloc::format!(
                "{TEST_PRELUDE}\
                 int host_api(int x) {{ return x + 1; }}\n\
                 int main(void) {{ return host_api(0); }}\n"
            ),
            Target::LinuxX64,
            copts,
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let mut merged = link_native_objects(&[obj]).expect("link");
        let plt = emit_x86_64_plt(&mut merged).expect("plt");
        write_native_image_from_merged(
            &merged,
            &plt,
            "main",
            None,
            OutputKind::Executable,
            Target::LinuxX64,
            None,
        )
        .expect("write executable")
    };
    // `.symtab` carries `host_api` in every executable; only a
    // `.dynsym` entry is visible to a `dlopen`'d module, so read the
    // dynamic table through the linker's ELF record reader.
    use crate::c5::linker::object::{read_dynamic_symbol_names, read_elf_header};
    let exported = build_exe(true);
    assert_eq!(
        read_elf_header(&exported).expect("read header").e_type,
        3,
        "executable must be ET_DYN (PIE)"
    );
    assert!(
        read_dynamic_symbol_names(&exported)
            .expect("parse .dynsym")
            .iter()
            .any(|n| n == "host_api"),
        "an --export-all executable must export host_api in .dynsym"
    );
    assert!(
        !read_dynamic_symbol_names(&build_exe(false))
            .expect("parse .dynsym")
            .iter()
            .any(|n| n == "host_api"),
        "an ordinary executable must not export host_api dynamically"
    );
}

#[test]
fn export_data_exposes_data_globals_in_dynsym() {
    // `--export-data` adds an executable's defined data globals to
    // `.dynsym` (as STT_OBJECT) so a `dlopen`'d module resolves them --
    // the data half of `-rdynamic`, which `--export-all` (functions
    // only) cannot reach. An exported data-object global is the motivating
    // case. An executable without the flag exports no data symbol.
    use crate::c5::linker::object::read_dynamic_symbol_names;
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged_ex,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let build_exe = |export_data: bool| -> alloc::vec::Vec<u8> {
        let program = Compiler::new(alloc::format!(
            "{TEST_PRELUDE}\
             int host_data = 7;\n\
             int main(void) {{ return host_data; }}\n"
        ))
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let mut merged = link_native_objects(&[obj]).expect("link");
        let plt = emit_x86_64_plt(&mut merged).expect("plt");
        write_native_image_from_merged_ex(
            &merged,
            &plt,
            "main",
            None,
            OutputKind::Executable,
            Target::LinuxX64,
            None,
            false,
            export_data,
        )
        .expect("write executable")
    };
    assert!(
        read_dynamic_symbol_names(&build_exe(true))
            .expect("parse .dynsym")
            .iter()
            .any(|n| n == "host_data"),
        "an --export-data executable must export host_data in .dynsym"
    );
    assert!(
        !read_dynamic_symbol_names(&build_exe(false))
            .expect("parse .dynsym")
            .iter()
            .any(|n| n == "host_data"),
        "an executable without --export-data must not export host_data"
    );
}

#[test]
fn macho_executable_exports_globals_through_dyld_info_trie() {
    // macOS publishes every global of an executable so a dlopen'd module
    // resolves them against the host. dyld resolves an image carrying
    // LC_DYLD_INFO exclusively through the export trie -- a symtab-only
    // entry is invisible to it -- so a text and a data global must both
    // resolve through the trie at their symtab addresses.
    use crate::c5::linker::{
        emit_aarch64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        alloc::format!(
            "{TEST_PRELUDE}\
             int host_data = 7;\n\
             int host_api(int x) {{ return x + host_data; }}\n\
             int main(void) {{ return host_api(0); }}\n"
        ),
        Target::MacOSAarch64,
        CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_aarch64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::MacOSAarch64,
        None,
    )
    .expect("write executable");

    fn uleb(buf: &[u8], p: &mut usize) -> u64 {
        let (mut v, mut shift) = (0u64, 0);
        loop {
            let b = buf[*p];
            *p += 1;
            v |= ((b & 0x7F) as u64) << shift;
            if b & 0x80 == 0 {
                return v;
            }
            shift += 7;
        }
    }
    fn trie_lookup(trie: &[u8], name: &str) -> Option<u64> {
        let bytes = name.as_bytes();
        let (mut node, mut pos) = (0usize, 0usize);
        loop {
            let mut p = node;
            let term_size = uleb(trie, &mut p) as usize;
            if pos == bytes.len() {
                if term_size == 0 {
                    return None;
                }
                let _flags = uleb(trie, &mut p);
                return Some(uleb(trie, &mut p));
            }
            p += term_size;
            let child_count = trie[p];
            p += 1;
            let mut next = None;
            for _ in 0..child_count {
                let start = p;
                while trie[p] != 0 {
                    p += 1;
                }
                let label = &trie[start..p];
                p += 1;
                let child = uleb(trie, &mut p) as usize;
                if bytes[pos..].starts_with(label) {
                    next = Some((label.len(), child));
                    break;
                }
            }
            match next {
                Some((len, child)) => {
                    pos += len;
                    node = child;
                }
                None => return None,
            }
        }
    }

    let read_u32 = |off: usize| u32::from_le_bytes(exe[off..off + 4].try_into().unwrap());
    let read_u64 = |off: usize| u64::from_le_bytes(exe[off..off + 8].try_into().unwrap());
    assert_eq!(read_u32(0), 0xfeed_facf, "executable must be MH_MAGIC_64");
    // Walk the load commands for LC_DYLD_INFO_ONLY (export_off/size at
    // +40/+44), LC_SYMTAB (symoff/nsyms/stroff at +8/+12/+16), and the
    // __TEXT segment vmaddr (image base; trie addresses are relative to it).
    let sizeofcmds = read_u32(20) as usize;
    let (mut export_range, mut symtab_loc, mut image_base) = (None, None, None);
    let mut p = 32usize;
    while p < 32 + sizeofcmds {
        match read_u32(p) {
            0x8000_0022 => {
                export_range = Some((read_u32(p + 40) as usize, read_u32(p + 44) as usize));
            }
            0x2 => {
                symtab_loc = Some((
                    read_u32(p + 8) as usize,
                    read_u32(p + 12) as usize,
                    read_u32(p + 16) as usize,
                ));
            }
            0x19 if exe[p + 8..p + 15] == *b"__TEXT\0" => {
                image_base = Some(read_u64(p + 24));
            }
            _ => {}
        }
        p += read_u32(p + 4) as usize;
    }
    let (export_off, export_size) = export_range.expect("LC_DYLD_INFO_ONLY must be present");
    let trie = &exe[export_off..export_off + export_size];
    let (symoff, nsyms, stroff) = symtab_loc.expect("LC_SYMTAB must be present");
    let image_base = image_base.expect("__TEXT segment must be present");
    let n_value_of = |name: &str| -> u64 {
        (0..nsyms)
            .find_map(|i| {
                let base = symoff + i * 16;
                let s = &exe[stroff + read_u32(base) as usize..];
                let end = s.iter().position(|&b| b == 0).unwrap();
                (&s[..end] == name.as_bytes()).then(|| read_u64(base + 8))
            })
            .unwrap_or_else(|| panic!("symtab must carry {name}"))
    };
    for name in ["_host_api", "_host_data"] {
        assert_eq!(
            trie_lookup(trie, name),
            Some(n_value_of(name) - image_base),
            "{name} must resolve through the export trie at its symtab address"
        );
    }
}

#[test]
fn thread_local_in_elf_shared_library_is_a_link_error() {
    // The emitted `_Thread_local` sequences use the local-exec TLS
    // model, whose TP-relative offsets are valid only in the
    // executable's static TLS block; baked into ET_DYN they address
    // another module's TLS. The writer must reject the combination
    // until the general-dynamic model is implemented.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "_Thread_local int counter = 7;\n\
         int bump(void) { counter += 1; return counter; }\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    assert!(
        !merged.tls_data.is_empty(),
        "the merged unit must carry TLS data"
    );
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let err = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
        None,
    )
    .expect_err("a _Thread_local shared library must be rejected");
    assert!(
        err.to_string()
            .contains("_Thread_local data is not supported in ELF shared-library output"),
        "unexpected diagnostic: {err}"
    );
}

#[test]
fn shared_object_relocates_internal_data_pointers() {
    // A function / data pointer baked into a shared object's static data
    // must carry an R_*_RELATIVE relocation so it tracks the runtime load
    // base (C: a `static const` table of pointers in a dlopen'd module);
    // an executable maps at a fixed base and needs none. Without it the
    // table holds link-time addresses and dereferences garbage at load.
    use crate::c5::linker::object::count_dynamic_relocs_of_type;
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const R_X86_64_RELATIVE: u32 = 8;
    let program = Compiler::with_target(
        alloc::format!(
            "{TEST_PRELUDE}\
             static int f1(void) {{ return 1; }}\n\
             static int f2(void) {{ return 2; }}\n\
             typedef int (*fn_t)(void);\n\
             static const fn_t tab[2] = {{ f1, f2 }};\n\
             int use_tab(int i) {{ return tab[i](); }}\n\
             int main(void) {{ return use_tab(0) + use_tab(1); }}\n"
        ),
        Target::LinuxX64,
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let so = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
        None,
    )
    .expect("write shared library");
    let so_rel = count_dynamic_relocs_of_type(&so, R_X86_64_RELATIVE).expect("count so relocs");
    assert!(
        so_rel >= 2,
        "shared object must relocate the two internal function pointers, got {so_rel}"
    );
    let plt2 = emit_x86_64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt2,
        "main",
        None,
        OutputKind::Executable,
        Target::LinuxX64,
        None,
    )
    .expect("write executable");
    let exe_rel = count_dynamic_relocs_of_type(&exe, R_X86_64_RELATIVE).expect("count exe relocs");
    assert!(
        exe_rel >= 2,
        "a PIE executable relocates its internal function pointers like the shared \
         object, got {exe_rel}"
    );
}

#[test]
fn export_all_round_trips_into_shared_library() {
    // `--export-all` (`CompileOptions::export_all_functions`) exports
    // every non-static function without a `#pragma export`. The names
    // ride the same `.note.badc` NT_BADC_EXPORTS record through emit ->
    // parse -> link and the shared-library writer promotes them; a
    // `static` function keeps internal linkage and is omitted.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let copts = CompileOptions::default().with_export_all_functions(true);
    let program = Compiler::with_options(
        alloc::format!(
            "{TEST_PRELUDE}\
             static int internal_fn(int x) {{ return x + 2; }}\n\
             int api_one(int x) {{ return x + 1; }}\n\
             int api_two(int x) {{ return api_one(x) + internal_fn(x); }}\n\
             int main(void) {{ return api_two(1); }}\n"
        ),
        Target::LinuxX64,
        copts,
    )
    .compile()
    .expect("compile");
    let names: alloc::vec::Vec<&str> = program.exports.iter().map(|e| e.name.as_str()).collect();
    assert!(
        names.contains(&"api_one") && names.contains(&"api_two"),
        "both non-static functions must auto-export: {names:?}"
    );
    assert!(
        !names.contains(&"internal_fn"),
        "a static function must not export: {names:?}"
    );
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    assert!(
        obj.exports.contains(&"api_one".to_string())
            && obj.exports.contains(&"api_two".to_string()),
        "auto-exports must round-trip through the `.note.badc` record"
    );
    assert!(
        !obj.exports.contains(&"internal_fn".to_string()),
        "a static function must not round-trip"
    );
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let so = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::LinuxX64,
        None,
    )
    .expect("write shared library");
    assert_eq!(
        u16::from_le_bytes(so[0x10..0x12].try_into().unwrap()),
        3,
        "shared library must be ET_DYN"
    );
}

#[test]
fn win64_dll_records_requested_name() {
    // A Win64 DLL records its own name in the export directory so a
    // consumer linking against it by name references the file it loads
    // at runtime; the name comes from the requested `-o` basename, not a
    // fixed default. (The runtime's `exit` binding resolving through
    // msvcrt.dll rather than ucrtbase.dll is exercised by the Windows
    // demos, which link the embedded runtime.) No prelude: the host's
    // headers would carry host-OS data bindings into this PE-target
    // link, which the linker rejects as binding/definition collisions.
    use crate::c5::linker::{
        emit_x86_64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "#pragma export(api_fn)\n\
         int api_fn(int x) { return x + 1; }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::WindowsX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_x86_64_plt(&mut merged).expect("plt");
    let dll = write_native_image_from_merged(
        &merged,
        &plt,
        "",
        None,
        OutputKind::SharedLibrary,
        Target::WindowsX64,
        Some("requested_name.dll"),
    )
    .expect("write DLL");
    let contains = |needle: &str| dll.windows(needle.len()).any(|w| w == needle.as_bytes());
    assert!(
        contains("requested_name.dll"),
        "export directory must carry the requested DLL name"
    );
    assert!(
        !contains("c5-output.dll"),
        "the fixed default name must not leak into the image"
    );
}

#[test]
fn win64_dll_without_imports_leaves_import_and_iat_dirs_empty() {
    // A DLL whose code calls nothing external has no imported DLLs.
    // The import-descriptor block is then a lone zero terminator and
    // the IAT is empty. Pointing the Import data directory at that
    // descriptor with a zero-size IAT directory is rejected by the
    // Windows loader (ERROR_INVALID_PARAMETER) at LoadLibrary time,
    // though wine tolerates it. The writer must leave both directories
    // empty (RVA = 0, size = 0) in that case.
    use crate::c5::object::emit_native_with_options_named;
    use crate::c5::{NativeOptions, Target};
    let src = "#pragma export(answer)\nint answer(void) { return 42; }\n";
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        // Compile for the same target the writer lowers for, so the
        // per-target bindings are in scope (a host-default compile
        // would feed the wrong `#pragma binding` set).
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .expect("compile");
        let dll = emit_native_with_options_named(
            &program,
            target,
            NativeOptions::new().with_shared_library(),
            Some("noimports.dll"),
        )
        .expect("emit DLL");
        let pe = u32::from_le_bytes(dll[0x3c..0x40].try_into().unwrap()) as usize;
        let opt = pe + 24;
        // PE32+ data directories start at optional-header offset 112;
        // entry 1 is Import, entry 12 is IAT (8 bytes each: RVA, size).
        let dir = |i: usize| {
            let o = opt + 112 + i * 8;
            let rva = u32::from_le_bytes(dll[o..o + 4].try_into().unwrap());
            let size = u32::from_le_bytes(dll[o + 4..o + 8].try_into().unwrap());
            (rva, size)
        };
        assert_eq!(dir(1), (0, 0), "{target:?}: import directory must be empty");
        assert_eq!(dir(12), (0, 0), "{target:?}: IAT directory must be empty");
        // The export directory (entry 0) still carries `answer`.
        let (exp_rva, exp_size) = dir(0);
        assert!(
            exp_rva != 0 && exp_size != 0,
            "{target:?}: export directory must be present"
        );
    }
}

#[test]
fn windows_hypotf_imports_underscored_ucrtbase_export() {
    // ucrtbase.dll exports the float hypot only under the legacy
    // underscored `_hypotf`; the C99 `hypotf` spelling is a header inline
    // there, with no exported symbol. Binding the call to the bare
    // `hypotf` leaves an unresolved import that fails the Windows loader
    // at process start (STATUS_ENTRYPOINT_NOT_FOUND, 0xc0000139). The
    // import-name string in the PE must therefore be `_hypotf` on both
    // Windows targets.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "#include <math.h>\n\
               #pragma export(use_hypotf)\n\
               float use_hypotf(float a, float b) { return hypotf(a, b); }\n";
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .expect("compile hypotf TU");
        let obj = emit_native_with_options(
            &program,
            target,
            NativeOptions {
                output_kind: OutputKind::Relocatable,
                ..Default::default()
            },
        )
        .expect("emit object");
        // The import symbol is the null-delimited `_hypotf`; matching the
        // bare substring would also hit the `use_hypotf` definition.
        let contains = |needle: &[u8]| obj.windows(needle.len()).any(|w| w == needle);
        assert!(
            contains(b"\0_hypotf\0"),
            "{target:?}: the float hypot call must bind to the exported `_hypotf`"
        );
        assert!(
            !contains(b"\0hypotf\0"),
            "{target:?}: the unexported bare `hypotf` must not be imported"
        );
    }
}

#[test]
fn wdm_driver_demo_builds_as_native_subsystem_pe() {
    // The WDM driver skeleton carries `#pragma subsystem(driver)`
    // (an alias for the native subsystem) and `#pragma
    // entrypoint(DriverEntry)`. The PE optional-header Subsystem must
    // be IMAGE_SUBSYSTEM_NATIVE (1) for both Windows targets; the
    // kernel's PE loader refuses a CUI/GUI subsystem.
    //
    // A NATIVE-subsystem image runs no `_start` CRT stub, so the
    // libc-`exit` runtime wrapper is not linked and the image carries
    // no user-mode `exit` import -- `msvcrt!exit` is unsatisfiable in
    // kernel mode. The skeleton imports nothing, so the import data
    // directory is empty.
    use crate::c5::{NativeOptions, Target, emit_native_with_options};
    let mut path = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("demos");
    path.push("wdm_driver");
    path.push("wdm_driver.c");
    let src = std::fs::read_to_string(&path).expect("read wdm_driver.c");
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        let program = Compiler::with_target(src.clone(), target)
            .compile()
            .expect("compile wdm_driver.c");
        let pe = emit_native_with_options(&program, target, NativeOptions::default())
            .expect("emit driver PE");
        let pe_off = u32::from_le_bytes(pe[0x3c..0x40].try_into().unwrap()) as usize;
        let opt = pe_off + 24;
        // Subsystem sits at optional-header offset 68 in PE32+.
        let subsystem = u16::from_le_bytes(pe[opt + 68..opt + 70].try_into().unwrap());
        assert_eq!(
            subsystem, 1,
            "{target:?}: wdm_driver must be IMAGE_SUBSYSTEM_NATIVE"
        );
        // Import data directory (entry 1) must be empty.
        let imp = opt + 112 + 8;
        let imp_rva = u32::from_le_bytes(pe[imp..imp + 4].try_into().unwrap());
        let imp_size = u32::from_le_bytes(pe[imp + 4..imp + 8].try_into().unwrap());
        assert_eq!(
            (imp_rva, imp_size),
            (0, 0),
            "{target:?}: a native driver must carry no imports"
        );
        assert!(
            !pe.windows(10)
                .any(|w| w.eq_ignore_ascii_case(b"msvcrt.dll")),
            "{target:?}: a native driver must not reference msvcrt.dll"
        );
    }
}

#[test]
fn cross_tu_call_into_secondary_dylib_keeps_routing() {
    // Cross-TU import routing through the native merge. The parser
    // records each `#pragma binding` import against its `#pragma
    // dylib`; `parse_native_elf` recovers the per-object (import ->
    // dylib) map and the merge in `link.rs` remaps it into the
    // deduped dylib order. Unit A binds a symbol in a second dylib
    // (libutil); unit B references only the shared first dylib
    // (libc). The merge must keep A's libutil import routed to
    // libutil even though B contributes no libutil entry.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let compile_rel = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL")
    };

    let unit_a = compile_rel(
        "
        #pragma dylib(libc, \"libc.so.6\")
        #pragma binding(libc::printf, \"printf\")
        #pragma dylib(libutil, \"libutil.so.1\")
        #pragma binding(libutil::do_work, \"do_work\")
        int printf(const char *, ...);
        int do_work(void);
        int lib_call(void) { printf(\"x\"); return do_work(); }
        ",
    );
    let unit_b = compile_rel(
        "
        #pragma dylib(libc, \"libc.so.6\")
        #pragma binding(libc::printf, \"printf\")
        #pragma binding(libc::fputs, \"fputs\")
        int printf(const char *, ...);
        int fputs(const char *, void *);
        extern int lib_call(void);
        int main(void) { fputs(\"y\", 0); printf(\"z\"); return lib_call(); }
        ",
    );

    // Unit B first: a single-pass merge that appended B's libc
    // bindings before resolving A's routing would shift libutil.
    let merged = link_native_objects(&[unit_b, unit_a]).expect("link");

    let libutil_idx = merged
        .dylibs
        .iter()
        .position(|d| d.as_str() == "libutil.so.1")
        .expect("merged dylibs should include libutil.so.1") as u32;
    let libc_idx = merged
        .dylibs
        .iter()
        .position(|d| d.as_str() == "libc.so.6")
        .expect("merged dylibs should include libc.so.6") as u32;
    assert_eq!(
        merged.import_dylib_map.get("do_work"),
        Some(&libutil_idx),
        "secondary-dylib import `do_work` must stay routed to libutil after the merge"
    );
    assert_eq!(
        merged.import_dylib_map.get("printf"),
        Some(&libc_idx),
        "shared-dylib import `printf` must route to libc"
    );
}

#[test]
fn out_of_range_text_reloc_offset_is_diagnostic_not_panic() {
    // .o / .a files are untrusted linker input read from disk. A corrupt
    // r_offset must yield a diagnostic, not a slice-index panic. x86_64
    // PC32/PLT32 is the path whose only prior guard was the displacement
    // fit check, which an out-of-bounds offset passes.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let reloc = || NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let compile = |src: &str| {
        Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile")
    };
    let caller = compile("extern int f(void);\nint main(void){ return f(); }\n");
    let callee = compile("int f(void){ return 7; }\n");
    let a_bytes = emit_native_with_options(&caller, Target::LinuxX64, reloc()).expect("emit a");
    let b_bytes = emit_native_with_options(&callee, Target::LinuxX64, reloc()).expect("emit b");
    let mut a = parse_native_elf(&a_bytes).expect("parse a");
    let b = parse_native_elf(&b_bytes).expect("parse b");
    assert!(!a.text_relocs.is_empty(), "caller must carry a text reloc");
    // Past the end of the merged text (well beyond any object's size).
    for r in &mut a.text_relocs {
        r.offset = 0x4000_0000;
    }
    assert!(
        link_native_objects(&[a, b]).is_err(),
        "out-of-range text reloc offset must be a diagnostic, not a panic"
    );
}

#[test]
fn wrapping_section_size_is_diagnostic_not_panic() {
    // A malformed object whose section sh_offset + sh_size wraps must be
    // rejected, not abort the linker on the slice bound.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new("int g = 5;\nint main(void){ return g; }\n".to_string())
        .compile()
        .expect("compile");
    let mut bytes = emit_native_with_options(
        &program,
        Target::LinuxX64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        },
    )
    .expect("emit");
    // Elf64_Ehdr: e_shoff @40, e_shentsize @58, e_shnum @60.
    let e_shoff = u64::from_le_bytes(bytes[40..48].try_into().unwrap()) as usize;
    let e_shentsize = u16::from_le_bytes(bytes[58..60].try_into().unwrap()) as usize;
    let e_shnum = u16::from_le_bytes(bytes[60..62].try_into().unwrap()) as usize;
    assert!(
        e_shoff != 0 && e_shnum > 1,
        "expected a section header table"
    );
    // Set the first SHT_PROGBITS section's sh_size (Elf64_Shdr @32) to the
    // max so section_slice's off + size wraps when it reads that section.
    let mut patched = false;
    for i in 1..e_shnum {
        let shdr = e_shoff + i * e_shentsize;
        let sh_type = u32::from_le_bytes(bytes[shdr + 4..shdr + 8].try_into().unwrap());
        if sh_type == 1 {
            let at = shdr + 32;
            bytes[at..at + 8].copy_from_slice(&u64::MAX.to_le_bytes());
            patched = true;
            break;
        }
    }
    assert!(patched, "expected a SHT_PROGBITS section to corrupt");
    assert!(
        parse_native_elf(&bytes).is_err(),
        "a wrapping sh_offset + sh_size must be a diagnostic, not a panic"
    );
}

#[test]
fn inline_linkage_follows_c99_6_7_4p7() {
    // C99 6.7.4p7: a function all of whose file-scope declarations are
    // `inline` without `extern` provides no external definition in the
    // unit -- its out-of-line copy must be local so the same inline
    // function compiled into another unit does not collide at link time.
    // A single non-inline declaration (a prototype) or `extern inline`
    // makes the definition external, so a unit that only references the
    // function resolves against it.
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const STB_LOCAL: u8 = 0;
    const STB_GLOBAL: u8 = 1;

    fn binding_of(src: &str, name: &str) -> u8 {
        let program = Compiler::new(src.to_string()).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let sym = obj
            .symbols
            .iter()
            .find(|s| s.name == name && !matches!(s.section, NativeSymSection::Undef))
            .unwrap_or_else(|| panic!("`{name}` must be a defined symbol"));
        sym.binding
    }

    // Plain `inline`, no other declaration: internal linkage (local).
    assert_eq!(
        binding_of(
            "inline int f(int x) { return x + 1; }\n\
             int main(void) { return f(41) == 42 ? 0 : 1; }\n",
            "f",
        ),
        STB_LOCAL,
        "plain inline-only definition must be local"
    );
    // A non-inline prototype precedes the inline definition: external.
    assert_eq!(
        binding_of(
            "int g(int);\n\
             inline int g(int x) { return x + 1; }\n\
             int main(void) { return g(41) == 42 ? 0 : 1; }\n",
            "g",
        ),
        STB_GLOBAL,
        "a non-inline declaration makes the inline definition external"
    );
    // `extern inline` provides the one external definition.
    assert_eq!(
        binding_of(
            "extern inline int h(int x) { return x + 1; }\n\
             int main(void) { return h(41) == 42 ? 0 : 1; }\n",
            "h",
        ),
        STB_GLOBAL,
        "extern inline must be external"
    );
    // `static inline` is internal.
    assert_eq!(
        binding_of(
            "static inline int s(int x) { return x + 1; }\n\
             int main(void) { return s(41) == 42 ? 0 : 1; }\n",
            "s",
        ),
        STB_LOCAL,
        "static inline must be local"
    );
    // An inline prototype (no body) must not mark the following,
    // unrelated definition inline: `pb` is a plain external function.
    assert_eq!(
        binding_of(
            "inline int pa(int);\n\
             int pb(int x) { return x + 1; }\n\
             int main(void) { return pb(41) == 42 ? 0 : 1; }\n",
            "pb",
        ),
        STB_GLOBAL,
        "an inline prototype must not leak `inline` onto the next definition"
    );
}

#[test]
fn cpuid_xgetbv_asm_emit_for_x86_64() {
    // The GCC `cpuid` / `xgetbv` inline-asm forms (a common CPU feature
    // probe) lower to dedicated intrinsics on x86_64: the `cpuid` (0F A2)
    // and `xgetbv` (0F 01 D0) opcodes appear, bracketed by a save of the
    // fixed registers they clobber (push rbx = 0x53, ebx being callee-saved).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "static void cpuid(unsigned f, unsigned s, unsigned o[4]) {\n\
         __asm__ __volatile__(\"cpuid\" : \"=a\"(o[0]),\"=b\"(o[1]),\"=c\"(o[2]),\"=d\"(o[3]) : \"a\"(f),\"c\"(s));\n\
         }\n\
         static unsigned long long xgetbv(unsigned r) {\n\
         unsigned lo, hi;\n\
         __asm__ __volatile__(\"xgetbv\" : \"=a\"(lo),\"=d\"(hi) : \"c\"(r));\n\
         return ((unsigned long long)hi << 32) | lo;\n\
         }\n\
         unsigned long long use_both(unsigned o[4]) { cpuid(1,0,o); return xgetbv(0); }\n\
         int main(void){ unsigned o[4]; return (int)use_both(o); }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(2).any(|w| w == [0x0F, 0xA2]),
        "cpuid opcode (0F A2) must be emitted"
    );
    assert!(
        bytes.windows(3).any(|w| w == [0x0F, 0x01, 0xD0]),
        "xgetbv opcode (0F 01 D0) must be emitted"
    );
    assert!(
        bytes.contains(&0x53),
        "push rbx (callee-saved, clobbered by cpuid) must be saved"
    );
}

#[test]
fn cpuid_matching_constraint_x86_64() {
    // A common `host_cpuid` shape ties the eax input to output operand 0
    // with the matching constraint `"0"(function)` rather than `"a"(function)`.
    // The digit constraint resolves to that output's register (eax) and
    // lowers to the same `cpuid` (0F A2) intrinsic.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "void host_cpuid(unsigned function, unsigned count,\n\
         unsigned *eax, unsigned *ebx, unsigned *ecx, unsigned *edx) {\n\
         unsigned vec[4];\n\
         __asm__ __volatile__(\"cpuid\"\n\
         : \"=a\"(vec[0]),\"=b\"(vec[1]),\"=c\"(vec[2]),\"=d\"(vec[3])\n\
         : \"0\"(function),\"c\"(count) : \"cc\");\n\
         if (eax) *eax = vec[0]; if (ebx) *ebx = vec[1];\n\
         if (ecx) *ecx = vec[2]; if (edx) *edx = vec[3];\n\
         }\n\
         int main(void){ unsigned a,b,c,d; host_cpuid(0,0,&a,&b,&c,&d); return (int)a; }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(2).any(|w| w == [0x0F, 0xA2]),
        "cpuid opcode (0F A2) must be emitted for the `\"0\"` matching constraint"
    );
}

#[test]
fn cpuid_read_write_a_constraint_supplies_leaf_x86_64() {
    // A read-write output `"+a"(level)` passes the leaf in eax and reads the
    // result back into the same variable (the kernel's cpucheck probe). The
    // `+` modifier makes the operand an input as well; without recognizing it
    // the leaf input was reported missing. Lowers to the same cpuid (0F A2).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_target(
        "unsigned d_of_leaf(unsigned level) {\n\
         unsigned d;\n\
         __asm__(\"cpuid\" : \"+a\"(level), \"=d\"(d) : : \"ecx\", \"ebx\");\n\
         return d;\n\
         }\n\
         int main(void){ return (int)d_of_leaf(1); }\n"
            .to_string(),
        Target::LinuxX64,
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(2).any(|w| w == [0x0F, 0xA2]),
        "cpuid opcode (0F A2) must be emitted for the `\"+a\"` read-write leaf input"
    );
}

#[test]
fn cpuid_partial_outputs_with_clobbers_x86_64() {
    // A `cpuid` with one output operand and the other implicit outputs
    // listed as clobbers (a common max-leaf probe) lowers to the same
    // intrinsic; the clobbered registers store to scratch slots and the
    // absent `c` input defaults to subleaf 0.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(
        "static unsigned leaf_max(void) {\n\
         unsigned m;\n\
         __asm__ volatile(\"cpuid\" : \"=a\"(m) : \"a\"(0) : \"rbx\", \"rcx\", \"rdx\");\n\
         return m;\n\
         }\n\
         int main(void){ return (int)(leaf_max() & 0); }\n"
            .to_string(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    assert!(
        bytes.windows(2).any(|w| w == [0x0F, 0xA2]),
        "cpuid opcode (0F A2) must be emitted for the partial-output form"
    );
}

#[test]
fn cpuid_uncovered_implicit_output_rejected() {
    // An implicit output register that is neither an output operand nor
    // a clobber is rejected: the instruction overwrites it behind the
    // register allocator's back.
    let err = Compiler::new(
        "static unsigned leaf_max(void) {\n\
         unsigned m;\n\
         __asm__ volatile(\"cpuid\" : \"=a\"(m) : \"a\"(0));\n\
         return m;\n\
         }\n\
         int main(void){ return (int)leaf_max(); }\n"
            .to_string(),
    )
    .compile()
    .expect_err("cpuid with uncovered implicit outputs must be rejected");
    assert!(
        format!("{err}").contains("output operand or a clobber"),
        "{err}"
    );
}

#[test]
fn same_named_statics_keep_their_own_prologue_anchor() {
    // The post-prologue anchor map is keyed by the function's merged
    // entry offset. Name-keying handed a later unit's same-named
    // static the first unit's anchor, describing a framed function as
    // frameless in the Win-x64 .pdata / DWARF CFA output.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let compile = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL")
    };
    let a = compile(
        "static int helper(int x) { int buf[16]; buf[0] = x; return buf[0] + 1; }\n\
         int call_a(int x) { return helper(x); }\n",
    );
    let b = compile(
        "static int helper(int x) { int buf[32]; buf[1] = x; return buf[1] + 2; }\n\
         int call_b(int x) { return helper(x); }\n",
    );
    let merged = link_native_objects(&[a, b]).expect("link");
    let helpers: alloc::vec::Vec<u64> = merged
        .local_funcs
        .iter()
        .filter(|(n, _)| n == "helper")
        .map(|(_, off)| *off)
        .collect();
    assert_eq!(helpers.len(), 2, "both statics survive: {helpers:?}");
    let mut posts = alloc::vec::Vec::new();
    for entry in &helpers {
        let post = merged
            .prologue_ends
            .get(entry)
            .unwrap_or_else(|| panic!("anchor for helper at 0x{entry:x} missing"));
        assert!(
            post > entry,
            "post-prologue 0x{post:x} must lie past the entry 0x{entry:x}"
        );
        posts.push(*post);
    }
    assert_ne!(posts[0], posts[1], "each static keeps its own anchor");
}

#[test]
fn unrouted_weak_undef_resolves_to_zero() {
    // ELF behavior: a weak reference nothing on the link line
    // satisfies resolves to address 0 -- not a required import
    // against the first dylib. The call becomes a no-op, the
    // address-of reads null, and a pointer initializer slot holds 0.
    use crate::c5::linker::object::{NativeReloc, NativeSymbol};
    use crate::c5::linker::{NativeMachine, NativeSymSection, link_native_objects};
    let null_sym = || NativeSymbol {
        name: String::new(),
        section: NativeSymSection::Undef,
        value: 0,
        size: 0,
        binding: 0,
        kind: 0,
    };
    let weak_undef = || NativeSymbol {
        name: "hook".to_string(),
        section: NativeSymSection::Undef,
        value: 0,
        size: 0,
        binding: 2, // STB_WEAK
        kind: 0,
    };
    let mk = |machine: NativeMachine,
              text: alloc::vec::Vec<u8>,
              data: alloc::vec::Vec<u8>,
              text_relocs: alloc::vec::Vec<NativeReloc>,
              data_relocs: alloc::vec::Vec<NativeReloc>| {
        crate::c5::linker::NativeObject {
            text_align: 16,
            rodata: Vec::new(),
            rodata_align: 8,
            machine,
            text,
            data,
            data_align: 8,
            bss_size: 0,
            bss_align: 1,
            tls_data: alloc::vec::Vec::new(),
            tls_bss_size: 0,
            symbols: alloc::vec![null_sym(), weak_undef()],
            text_relocs,
            data_relocs,
            init_funcs: alloc::vec::Vec::new(),
            dylibs: alloc::vec::Vec::new(),
            import_dylib_map: alloc::vec::Vec::new(),
            exports: alloc::vec::Vec::new(),
            tls_index_fixups: alloc::vec::Vec::new(),
            macho_tlv_descriptors: alloc::vec::Vec::new(),
            macho_tlv_fixups: alloc::vec::Vec::new(),
            tls_symbols: alloc::vec::Vec::new(),
            macho_tlv_descriptor_syms: alloc::vec::Vec::new(),
            elf_tpoff_fixups: alloc::vec::Vec::new(),
            copy_relocs: alloc::vec::Vec::new(),
            debug_info: alloc::vec::Vec::new(),
            debug_abbrev: alloc::vec::Vec::new(),
            debug_line: alloc::vec::Vec::new(),
            debug_str: alloc::vec::Vec::new(),
            debug_info_relocs: alloc::vec::Vec::new(),
            debug_line_relocs: alloc::vec::Vec::new(),
        }
    };

    // x86_64: `lea rax, [rip+hook]` (R_X86_64_PC32) then `call hook`
    // (R_X86_64_PLT32), plus a `.data` pointer slot (R_X86_64_64).
    let x64 = mk(
        NativeMachine::X86_64,
        alloc::vec![
            0x48, 0x8D, 0x05, 0, 0, 0, 0, // lea rax, [rip+0]
            0xE8, 0, 0, 0, 0, // call rel32
        ],
        alloc::vec![0u8; 8],
        alloc::vec![
            NativeReloc {
                offset: 3,
                sym_idx: 1,
                rtype: 2, // R_X86_64_PC32
                addend: -4,
            },
            NativeReloc {
                offset: 8,
                sym_idx: 1,
                rtype: 4, // R_X86_64_PLT32
                addend: -4,
            },
        ],
        alloc::vec![NativeReloc {
            offset: 0,
            sym_idx: 1,
            rtype: 1, // R_X86_64_64
            addend: 0,
        }],
    );
    let merged = link_native_objects(&[x64]).expect("weak undef links");
    assert!(
        merged.imports.is_empty(),
        "no import for an unresolved weak ref: {:?}",
        merged.imports
    );
    assert_eq!(
        &merged.text[0..7],
        &[0x48, 0xC7, 0xC0, 0, 0, 0, 0],
        "lea rewritten to mov rax, 0"
    );
    assert_eq!(
        &merged.text[7..12],
        &[0x0F, 0x1F, 0x44, 0x00, 0x00],
        "call rewritten to a 5-byte nop"
    );
    assert_eq!(&merged.data[0..8], &[0u8; 8], "pointer slot holds null");

    // aarch64: `adrp x0, hook` + `add x0, x0, :lo12:hook` + `bl hook`.
    let a64 = mk(
        NativeMachine::Aarch64,
        alloc::vec![
            0x00, 0x00, 0x00, 0x90, // adrp x0, 0
            0x00, 0x00, 0x00, 0x91, // add x0, x0, #0
            0x00, 0x00, 0x00, 0x94, // bl 0
        ],
        alloc::vec::Vec::new(),
        alloc::vec![
            NativeReloc {
                offset: 0,
                sym_idx: 1,
                rtype: 275, // R_AARCH64_ADR_PREL_PG_HI21
                addend: 0,
            },
            NativeReloc {
                offset: 4,
                sym_idx: 1,
                rtype: 277, // R_AARCH64_ADD_ABS_LO12_NC
                addend: 0,
            },
            NativeReloc {
                offset: 8,
                sym_idx: 1,
                rtype: 283, // R_AARCH64_CALL26
                addend: 0,
            },
        ],
        alloc::vec::Vec::new(),
    );
    let merged = link_native_objects(&[a64]).expect("weak undef links");
    assert!(merged.imports.is_empty(), "{:?}", merged.imports);
    let word = |i: usize| u32::from_le_bytes(merged.text[i..i + 4].try_into().unwrap());
    assert_eq!(word(0), 0xd280_0000, "adrp rewritten to movz x0, #0");
    assert_eq!(word(4), 0xd503_201f, "add pair half becomes a nop");
    assert_eq!(word(8), 0xd503_201f, "bl becomes a nop");
}

#[test]
fn elf_section_offsets_respect_their_claimed_alignment() {
    // gABI: `sh_addr` (and the file offset for SHF_ALLOC sections)
    // must be congruent to 0 modulo `sh_addralign`. Version-name
    // strings appended to `.dynstr` after its pad used to leave
    // `.hash` / `.gnu.version` misaligned; the check runs over every
    // section so any future layout drift is caught. Version sections
    // only appear when the build host's libc yields versioned imports.
    use crate::c5::linker::{
        emit_aarch64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         int main(void) {{ printf(\"x\"); return 0; }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_aarch64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::LinuxAarch64,
        None,
    )
    .expect("write executable");
    let shoff = u64::from_le_bytes(exe[0x28..0x30].try_into().unwrap()) as usize;
    let shentsize = u16::from_le_bytes(exe[0x3a..0x3c].try_into().unwrap()) as usize;
    let shnum = u16::from_le_bytes(exe[0x3c..0x3e].try_into().unwrap()) as usize;
    assert!(shnum > 0, "executable must carry section headers");
    const SHT_NOBITS: u32 = 8;
    for i in 0..shnum {
        let base = shoff + i * shentsize;
        let sh_type = u32::from_le_bytes(exe[base + 4..base + 8].try_into().unwrap());
        let sh_addr = u64::from_le_bytes(exe[base + 16..base + 24].try_into().unwrap());
        let sh_offset = u64::from_le_bytes(exe[base + 24..base + 32].try_into().unwrap());
        let sh_addralign = u64::from_le_bytes(exe[base + 48..base + 56].try_into().unwrap());
        if sh_addralign <= 1 {
            continue;
        }
        assert_eq!(
            sh_addr % sh_addralign,
            0,
            "section {i} sh_addr 0x{sh_addr:x} violates sh_addralign {sh_addralign}"
        );
        if sh_type != SHT_NOBITS {
            assert_eq!(
                sh_offset % sh_addralign,
                0,
                "section {i} sh_offset 0x{sh_offset:x} violates sh_addralign {sh_addralign}"
            );
        }
    }
}

#[test]
fn extern_redeclaration_keeps_the_tentative_definition() {
    // C99 6.2.2p4 + 6.9.2p2: `int x; extern int x;` retains the
    // tentative definition (the extern redeclaration refers to the
    // same object), so the TU's object defines `x`. The same holds
    // for the array form and for an initialized definition.
    use crate::c5::linker::{NativeSymSection, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let defined_sections = |src: &str, names: &[&str]| -> alloc::vec::Vec<bool> {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        names
            .iter()
            .map(|n| {
                obj.symbols
                    .iter()
                    .any(|s| &s.name == n && s.section != NativeSymSection::Undef)
            })
            .collect()
    };
    let defined = defined_sections(
        "int x;\nextern int x;\n\
         int a[4];\nextern int a[];\n\
         int y = 5;\nextern int y;\n\
         int use_all(void) { return x + a[0] + y; }\n",
        &["x", "a", "y"],
    );
    assert_eq!(
        defined,
        alloc::vec![true, true, true],
        "the definitions must survive the extern redeclarations (x, a, y)"
    );
    // A genuinely extern-only declaration still emits an UNDEF.
    let defined = defined_sections("extern int z;\nint use_z(void) { return z; }\n", &["z"]);
    assert_eq!(defined, alloc::vec![false], "extern-only stays undefined");
}

#[test]
fn alignas_places_objects_at_requested_alignment() {
    // C11 6.7.5: an alignment request on a file-scope object is honored --
    // the object's section offset is aligned through compaction and the
    // unit records `data_align` so the linker and image writers keep the
    // base congruent. Static objects honor power-of-two requests up to a
    // page; automatic objects and non-power-of-two requests are diagnostics.
    use crate::c5::linker::{NativeSymSection, link_native_objects, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let compile = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse ET_REL")
    };
    let aligned_unit = "\
        _Alignas(16) unsigned char pool[24];\n\
        char skew[3] = \"ab\";\n\
        __attribute__((aligned(16))) unsigned char pool2[8];\n\
        int use_all(void) { return pool[0] + skew[0] + pool2[0]; }\n";
    let obj = compile(aligned_unit);
    assert_eq!(obj.data_align, 16, "unit must claim 16-byte data alignment");
    for name in ["pool", "pool2"] {
        let sym = obj
            .symbols
            .iter()
            .find(|s| s.name == name)
            .unwrap_or_else(|| panic!("{name} missing"));
        assert!(
            sym.section != NativeSymSection::Undef && sym.value.is_multiple_of(16),
            "{name} at {:?}+0x{:x} must be 16-aligned",
            sym.section,
            sym.value
        );
    }
    // Linked after a unit with an odd-sized data tail, the offsets
    // stay 16-congruent (the unit base honors the claimed alignment)
    // and the file image is padded so bss offsets keep their residue.
    let odd = compile("char tail[5] = \"abcd\";\nint use_tail(void) { return tail[0]; }\n");
    let merged = link_native_objects(&[odd, compile(aligned_unit)]).expect("link");
    assert_eq!(merged.data_align, 16);
    if merged.bss_size > 0 {
        assert!(merged.data.len().is_multiple_of(16));
    }
    for name in ["pool", "pool2"] {
        let sym = merged.defined.get(name).unwrap_or_else(|| panic!("{name}"));
        assert!(
            sym.value.is_multiple_of(16),
            "{name} merged offset 0x{:x} must stay 16-aligned",
            sym.value
        );
    }
    // A static object over-aligns past 16: `aligned(64)` places it at 64
    // and raises the unit's data alignment to match.
    let over = compile(
        "__attribute__((aligned(64))) unsigned char big[64] = { 1 };\n\
         int use_big(void) { return big[0]; }\n",
    );
    assert_eq!(
        over.data_align, 64,
        "aligned(64) must raise unit data alignment to 64"
    );
    let big = over
        .symbols
        .iter()
        .find(|s| s.name == "big")
        .expect("big missing");
    assert!(
        big.section != NativeSymSection::Undef && big.value.is_multiple_of(64),
        "big at {:?}+0x{:x} must be 64-aligned",
        big.section,
        big.value
    );
    // An automatic object's own request is placed from 16 up, in the
    // prologue-realigned region (the overaligned_automatic fixtures check the
    // resulting addresses at run time).
    assert!(
        Compiler::new("int main(void) { _Alignas(16) char buf[8]; return buf[0]; }\n".to_string())
            .compile()
            .is_ok(),
        "an automatic object's aligned(16) request must be honored"
    );
    // Diagnostics: a non-power-of-two request, and one past what the frame
    // can align to.
    for src in [
        "__attribute__((aligned(24))) static char weird[8];\nint main(void) { return 0; }\n",
        "int main(void) { _Alignas(8192) char buf[8]; return buf[0]; }\n",
    ] {
        assert!(
            Compiler::new(src.to_string()).compile().is_err(),
            "must be diagnosed: {src}"
        );
    }
    // A struct member's 16-byte alignment is honored, not diagnosed (the
    // member and the aggregate both align to 16; the aligned_member fixture
    // checks the resulting layout against gcc/clang).
    assert!(
        Compiler::new(
            "struct S { _Alignas(16) int f; };\nint main(void) { struct S s; s.f = 0; return s.f; }\n"
                .to_string()
        )
        .compile()
        .is_ok(),
        "a struct member's aligned(16) request must be honored"
    );
}

#[test]
fn windows_x64_tz_globals_bind_to_msvcrt_data_exports() {
    // msvcrt's `_tzset` writes the DLL's own `_tzname` / `_timezone` /
    // `_daylight`; the x64 image must import them as data (the
    // `environ` treatment) instead of resolving the externs to local
    // zero-filled slots `_tzset` never writes.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "#include <time.h>\n\
               #include <stdio.h>\n\
               #pragma export(use_tz)\n\
               long use_tz(void) { tzset(); return timezone + daylight + (tzname[0] != 0); }\n";
    let program = Compiler::with_target(src.to_string(), Target::WindowsX64)
        .compile()
        .expect("compile tz TU");
    let obj = emit_native_with_options(
        &program,
        Target::WindowsX64,
        NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        },
    )
    .expect("emit object");
    let contains = |needle: &[u8]| obj.windows(needle.len()).any(|w| w == needle);
    for sym in [
        &b"\0_tzname\0"[..],
        &b"\0_timezone\0"[..],
        &b"\0_daylight\0"[..],
    ] {
        assert!(
            contains(sym),
            "x64 tz output {:?} must be a data import",
            core::str::from_utf8(sym)
        );
    }
}

#[test]
fn dead_libc_bindings_fail_at_build_not_at_load() {
    // libSystem exports none of these (dlsym-verified); the header must
    // leave them unbound so a use fails the build loudly instead of
    // producing an image that aborts at load with a dyld error.
    let cases = [
        (
            "#include <time.h>\nint main(void) { struct timespec t; t.tv_sec = 0; t.tv_nsec = 0; return clock_nanosleep(0, 0, &t, 0); }\n",
            "clock_nanosleep",
        ),
        (
            "#include <sys/mman.h>\nint main(void) { return mremap((void *)0, 0, 0, 0) != 0; }\n",
            "mremap",
        ),
        (
            "#include <sched.h>\nint main(void) { return sched_getscheduler(0); }\n",
            "sched_getscheduler",
        ),
        (
            "#include <unistd.h>\nint main(void) { return fexecve(0, 0, 0); }\n",
            "fexecve",
        ),
    ];
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let link_one = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::MacOSAarch64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::MacOSAarch64, opts).expect("emit");
        link_native_objects(&[parse_native_elf(&bytes).expect("parse")])
    };
    for (src, name) in cases {
        let err = link_one(src)
            .err()
            .unwrap_or_else(|| panic!("{name}: use of an unexported symbol must not link"));
        assert!(
            format!("{err}").contains(name),
            "{name}: diagnostic must name the symbol: {err}"
        );
    }
    // The bound neighbors still link.
    for src in [
        "#include <time.h>\nint main(void) { struct timespec t; return clock_gettime(0, &t); }\n",
        "#include <sched.h>\nint main(void) { return sched_yield(); }\n",
    ] {
        link_one(src).expect("bound libc call must link");
    }
}

#[test]
fn macho_data_import_gets_no_bogus_local_text_symbol() {
    // A Mach-O data import (`environ`, bound through the GOT) carries no
    // PLT trampoline. The symtab previously fabricated a local text
    // symbol for it at code offset 0 -- the first function's address --
    // mislabeling backtraces and breakpoints. Only imports that actually
    // have a trampoline get a local text symbol; a data import keeps just
    // its undefined entry.
    use crate::c5::linker::{
        emit_aarch64_plt, link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    use crate::c5::{CompileOptions, NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "#include <unistd.h>\n\
         #include <string.h>\n\
         int main(void) { return environ != 0 ? (int)strlen(\"x\") : 0; }\n"
            .to_string(),
        Target::MacOSAarch64,
        CompileOptions::default(),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::MacOSAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let mut merged = link_native_objects(&[obj]).expect("link");
    let plt = emit_aarch64_plt(&mut merged).expect("plt");
    let exe = write_native_image_from_merged(
        &merged,
        &plt,
        "main",
        None,
        OutputKind::Executable,
        Target::MacOSAarch64,
        None,
    )
    .expect("write executable");

    // Walk LC_SYMTAB collecting (name, n_type). N_STAB=0xe0, N_TYPE=0x0e,
    // N_SECT=0x0e, N_EXT=0x01.
    const LC_SYMTAB: u32 = 2;
    let ncmds = u32::from_le_bytes(exe[16..20].try_into().unwrap());
    let mut p = 32usize;
    let mut names: alloc::vec::Vec<(String, u8)> = alloc::vec::Vec::new();
    for _ in 0..ncmds {
        let cmd = u32::from_le_bytes(exe[p..p + 4].try_into().unwrap());
        let cmdsize = u32::from_le_bytes(exe[p + 4..p + 8].try_into().unwrap()) as usize;
        if cmd == LC_SYMTAB {
            let symoff = u32::from_le_bytes(exe[p + 8..p + 12].try_into().unwrap()) as usize;
            let nsyms = u32::from_le_bytes(exe[p + 12..p + 16].try_into().unwrap()) as usize;
            let stroff = u32::from_le_bytes(exe[p + 16..p + 20].try_into().unwrap()) as usize;
            for k in 0..nsyms {
                let e = symoff + k * 16;
                let n_strx = u32::from_le_bytes(exe[e..e + 4].try_into().unwrap()) as usize;
                let n_type = exe[e + 4];
                let s = stroff + n_strx;
                let len = exe[s..].iter().position(|&b| b == 0).unwrap();
                names.push((
                    String::from_utf8_lossy(&exe[s..s + len]).into_owned(),
                    n_type,
                ));
            }
            break;
        }
        p += cmdsize;
    }
    // No local (N_SECT set, N_EXT clear) symbol named `environ`.
    assert!(
        !names
            .iter()
            .any(|(n, t)| n == "environ" && t & 0x0e == 0x0e && t & 0x01 == 0),
        "data import `environ` must not get a bogus local text symbol: {names:?}"
    );
    // Its undefined import entry (`_environ`, N_SECT clear) survives.
    assert!(
        names.iter().any(|(n, t)| n == "_environ" && t & 0x0e == 0),
        "data import must keep its undefined `_environ` entry: {names:?}"
    );
    // A real function import (`_strlen`) still gets its local text symbol.
    assert!(
        names
            .iter()
            .any(|(n, t)| n == "_strlen" && t & 0x0e == 0x0e && t & 0x01 == 0),
        "a trampolined import must keep its local text symbol: {names:?}"
    );
}

#[test]
fn init_array_round_trips_through_object() {
    // A constructor and a prioritized destructor emit `.init_array` /
    // `.fini_array.NNNNN` sections in the ET_REL object; `parse_native_elf`
    // recovers them as `NativeObject::init_funcs`, each resolved to the
    // target function's `.text` offset. Static (internal-linkage) init
    // functions -- what `type_init`-style macros generate -- must resolve
    // too, so use `static`.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(
            "static int g;\n\
             __attribute__((constructor)) static void ctor(void) { g = 1; }\n\
             __attribute__((destructor(101))) static void dtor(void) { g = 0; }\n\
             int main(void) { return g; }\n"
                .to_string(),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let ctors: alloc::vec::Vec<_> =
            obj.init_funcs.iter().filter(|f| !f.is_destructor).collect();
        let dtors: alloc::vec::Vec<_> = obj.init_funcs.iter().filter(|f| f.is_destructor).collect();
        assert_eq!(ctors.len(), 1, "{target:?}: one constructor");
        assert_eq!(dtors.len(), 1, "{target:?}: one destructor");
        assert!(ctors[0].priority.is_none(), "{target:?}: bare ctor");
        assert_eq!(dtors[0].priority, Some(101), "{target:?}: dtor priority");
        // Each entry resolves to a real function body inside `.text`.
        assert!((ctors[0].unit_text_offset as usize) < obj.text.len());
        assert!((dtors[0].unit_text_offset as usize) < obj.text.len());
    }
}

#[test]
fn constructor_links_into_executable_with_runtime() {
    // The full CLI link path: a program with a `static` constructor plus
    // the startup runtime. runtime.c references the linker-defined
    // `__init_array_*` boundary symbols; before they were provided this
    // link failed with "undefined reference to __init_array_start".
    // Producing a well-formed image proves the boundary symbols resolve
    // and the init array is laid out. Execution is covered by the
    // native_elf / native_elf_x64 suites on Linux.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::{NativeOptions, Target};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::with_options(
            "static int g;\n\
             __attribute__((constructor)) static void ctor(void) { g = 7; }\n\
             __attribute__((destructor)) static void dtor(void) { g = 0; }\n\
             int main(void) { return g; }\n"
                .to_string(),
            target,
            CompileOptions::default(),
        )
        .compile()
        .expect("compile");
        let bytes = super::link_executable_with_runtime(&program, target, NativeOptions::default())
            .unwrap_or_else(|e| panic!("{target:?}: link with runtime: {e}"));
        assert!(
            bytes.len() > 64 && &bytes[0..4] == b"\x7fELF",
            "{target:?}: produced a valid ELF image"
        );
    }
}

#[test]
fn dead_arm_switch_and_noreturn_tail_drop_their_callees() {
    // Two shapes the constant-branch elimination must cover so an
    // undefined fallback symbol is never referenced from the object:
    //   * an `if (0)` arm containing a whole `switch` (its case labels
    //     are owned by the dropped dispatch, so they don't pin it);
    //   * the tail behind a statement-level call to a `noreturn`
    //     function (C11 6.7.4p8), in each accepted spelling.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         __attribute__((noreturn)) extern void die_attr(void);\n\
         _Noreturn void die_kw(void);\n\
         static int sw_helper(int x) {{ return x * 2; }}\n\
         static int nr_helper_a(int x) {{ return x + 1; }}\n\
         static int nr_helper_k(int x) {{ return x + 2; }}\n\
         int probe(int v, int s) {{\n\
             if (0) {{\n\
                 int x;\n\
                 switch (s) {{\n\
                 case 1 ... 7: x = sw_helper(s); break;\n\
                 default: x = 0;\n\
                 }}\n\
                 return x;\n\
             }}\n\
             if (v == 1) {{ die_attr(); return nr_helper_a(v); }}\n\
             if (v == 2) {{ die_kw(); return nr_helper_k(v); }}\n\
             return 9;\n\
         }}\n\
         int main(void) {{ return probe(0, 0) - 9; }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let has = |name: &[u8]| bytes.windows(name.len()).any(|w| w == name);
    assert!(has(b"probe"), "the reachable function must survive");
    assert!(
        !has(b"sw_helper"),
        "a helper only the dead switch arm names must not be emitted"
    );
    assert!(
        !has(b"nr_helper_a"),
        "a helper behind an attribute-noreturn call must not be emitted"
    );
    assert!(
        !has(b"nr_helper_k"),
        "a helper behind a _Noreturn call must not be emitted"
    );
}

#[test]
fn init_array_stays_strictly_inside_data_at_bss_boundary() {
    // The startup runtime walks `[__init_array_start, __init_array_end)`; the
    // end symbol is a one-past-the-array `.data` address. If an array ends
    // exactly at the `.data` length, the offset->vaddr map resolves that
    // offset as the first `.bss` byte -- and a `.tbss` gap between `.data`
    // and `.bss` then makes the end symbol overshoot, so the walk runs off
    // the array into zero padding and calls a null pointer. `g` is a lone
    // 8-byte `.data` datum, so the single init_array slot ends 16-aligned at
    // the `.data` length, and `t` forces the `.tbss` gap: exactly that
    // boundary. The linker must keep the array strictly inside `.data`.
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    // Sweep the `.data` size a byte at a time so one size lands the sole
    // init_array slot 16-aligned exactly at the `.data` length -- the case the
    // fix guards. Every size must keep the array strictly inside `.data`.
    for pad in 1..=24usize {
        let program = Compiler::new(alloc::format!(
            "{TEST_PRELUDE}\
             long pad[{pad}] = {{1}};\n\
             __thread int t;\n\
             static int b;\n\
             __attribute__((constructor)) static void ctor(void) {{ b = (int)pad[0]; }}\n\
             int main(void) {{ return b + t; }}\n"
        ))
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        let merged = link_native_objects(&[obj]).expect("link");
        let (start, size) = merged
            .init_fini_arrays
            .init
            .expect("the constructor must produce an init_array");
        assert!(
            start + size < merged.data.len() as u64,
            "pad={pad}: init_array end offset {:#x} must stay strictly below the .data length \
             {:#x}; at the boundary the end symbol resolves into .bss past the .tbss gap and \
             the startup walk overruns the array",
            start + size,
            merged.data.len(),
        );
    }
}

#[test]
fn divmod_constant_branch_drops_its_dead_callee() {
    // Integer `/` and `%` are integer constant expressions (C99 6.6), so a
    // `?:` / `if` controlled by one selects its arm at translation time and
    // the dead arm's call to an extern-declared-but-undefined function must
    // not reach the object -- otherwise a link with no definition of it
    // fails. `nested` reproduces the compile-time-dispatch idiom
    // `__builtin_constant_p(K) ? <chain keyed on K> : <runtime fallback>`
    // where the chain's conditions divide, and the final chain arm is a
    // diagnostic stub; `guarded` is a bare `%`-controlled `if`.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         extern long build_bug_never_defined(void);\n\
         extern unsigned long long rt_fallback(unsigned v, unsigned long long c);\n\
         unsigned long long nested(unsigned long long c) {{\n\
             return __builtin_constant_p(4 / 2)\n\
                 ? ( (4 / 2) == 0 ? c\n\
                   : (4 / 2) == 1 ? c + 1\n\
                   : (4 / 2) == 2 ? c + 2\n\
                   : (build_bug_never_defined(), 0) )\n\
                 : rt_fallback(4 / 2, c);\n\
         }}\n\
         int guarded(void) {{\n\
             if ((5 % 3) == 1) {{ return (int)build_bug_never_defined(); }}\n\
             return 7;\n\
         }}\n\
         int main(void) {{ return (int)nested(5) + guarded() - 14; }}\n"
    ))
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let has = |name: &[u8]| bytes.windows(name.len()).any(|w| w == name);
    assert!(
        has(b"nested") && has(b"guarded"),
        "the live functions must survive"
    );
    assert!(
        !has(b"build_bug_never_defined"),
        "a `/`- or `%`-guarded dead branch's call to an undefined extern must be eliminated"
    );
    assert!(
        !has(b"rt_fallback"),
        "the __builtin_constant_p-false runtime fallback arm is dead and must be eliminated"
    );
}

#[test]
fn constant_p_inline_param_folds_assert_call_at_o() {
    // GCC defers a non-constant `__builtin_constant_p` under `-O` until
    // after inlining and constant propagation. The build-time-assert
    // idiom `if (!__builtin_constant_p(p) || (p & M)) undefined_fn();`
    // inside an always-inline helper called with a literal must fold
    // away entirely at `-O` so the undefined reference never reaches
    // the object; without `-O` the early conservative 0 keeps the
    // reference (gcc -O0 fails that link too).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::new(alloc::format!(
        "{TEST_PRELUDE}\
         extern void compiletime_assert_11(void);\n\
         extern void compiletime_assert_22(void);\n\
         extern unsigned long long rt_fallback(unsigned long long v);\n\
         static inline __attribute__((always_inline)) void check(unsigned long long req) {{\n\
             if (!__builtin_constant_p(req) || (req & 0xff00ULL))\n\
                 compiletime_assert_11();\n\
         }}\n\
         static inline int width_ok(int sz) {{\n\
             if (!(__builtin_constant_p(sz) && (sz == 1 || sz == 2 || sz == 4 || sz == 8)))\n\
                 compiletime_assert_22();\n\
             return sz;\n\
         }}\n\
         static inline unsigned long long sel(unsigned long long n) {{\n\
             return __builtin_constant_p(n) ? n + 1 : rt_fallback(n);\n\
         }}\n\
         int main(void) {{\n\
             check(0x12ULL);\n\
             return (int)sel(3ULL) + width_ok(4) - 8;\n\
         }}\n"
    ))
    .compile()
    .expect("compile");
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            optimize: true,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit -O");
        let has = |name: &[u8]| bytes.windows(name.len()).any(|w| w == name);
        assert!(has(b"main"), "{target:?}: main must survive");
        assert!(
            !has(b"compiletime_assert_11") && !has(b"compiletime_assert_22"),
            "{target:?}: the constant_p-guarded assert calls must fold away at -O"
        );
        assert!(
            !has(b"rt_fallback"),
            "{target:?}: the constant_p-false runtime arm is dead at -O"
        );
    }
    // Without -O the early conservative 0 keeps the references, as gcc
    // -O0 does.
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit -O0");
    let has = |name: &[u8]| bytes.windows(name.len()).any(|w| w == name);
    assert!(
        has(b"compiletime_assert_11") && has(b"rt_fallback"),
        "without -O the early 0 keeps the assert reference and the runtime arm"
    );
}

#[test]
fn weak_alias_used_bindings_in_relocatable() {
    // `weak` binds STB_WEAK on definitions and declarations;
    // `alias("target")` emits an additional symbol at the target's
    // address; `used` keeps an unreferenced static in the object.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "int real_fn(void) { return 41; }\n\
         int alias_fn(void) __attribute__((weak, alias(\"real_fn\")));\n\
         static int keep_me(void) __attribute__((used));\n\
         static int keep_me(void) { return 1; }\n\
         int weak_def(void) __attribute__((weak));\n\
         int weak_def(void) { return 2; }\n\
         extern int missing_weak __attribute__((weak));\n\
         int gdata = 7;\n\
         extern int gdata_alias __attribute__((alias(\"gdata\")));\n\
         int *paddr(void) { return &missing_weak; }\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let find = |name: &str| {
        obj.symbols
            .iter()
            .find(|s| s.name == name)
            .unwrap_or_else(|| panic!("symbol `{name}` missing"))
    };
    let real = find("real_fn");
    let alias = find("alias_fn");
    assert_eq!(alias.binding, 2, "alias declared weak binds STB_WEAK");
    assert_eq!(
        alias.value, real.value,
        "alias sits at the target's address"
    );
    assert!(matches!(alias.section, NativeSymSection::Text));
    assert_eq!(
        find("weak_def").binding,
        2,
        "weak definition binds STB_WEAK"
    );
    assert_eq!(find("keep_me").binding, 0, "used static stays STB_LOCAL");
    let mw = find("missing_weak");
    assert_eq!(mw.binding, 2, "weak extern declaration binds STB_WEAK");
    assert!(matches!(mw.section, NativeSymSection::Undef));
    let gd = find("gdata");
    let gda = find("gdata_alias");
    assert_eq!(gda.value, gd.value, "data alias shares the target's offset");
    assert_eq!(gda.binding, 1, "non-weak alias binds STB_GLOBAL");
}

#[test]
fn strong_definition_overrides_weak_at_link() {
    // ELF weak semantics in the native linker: a strong STB_GLOBAL
    // definition wins over a weak one with no multiple-definition
    // error; a weak definition alone satisfies references.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{
        NativeOptions, OutputKind, Target, emit_native_with_options, link_native_objects,
    };
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let compile = |src: &str| {
        let program = Compiler::with_options(
            src.to_string(),
            Target::LinuxX64,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
        parse_native_elf(&bytes).expect("parse")
    };
    // The weak unit defines `f` first in its text (absolute offset 0
    // when the unit links first); the strong unit's `f` lands past it.
    let weak_obj = compile("int f(void) __attribute__((weak));\nint f(void) { return 1; }\n");
    let strong_obj = compile("int filler(void) { return 9; }\nint f(void) { return 2; }\n");
    let merged = link_native_objects(&[weak_obj, strong_obj]).expect("link");
    let sym = merged.defined.get("f").expect("f defined in merge");
    assert_ne!(
        sym.value, 0,
        "strong definition (second unit) must win over the weak one at text offset 0"
    );
    // A weak definition alone satisfies the reference.
    let weak_only = compile("int f(void) __attribute__((weak));\nint f(void) { return 1; }\n");
    let merged = link_native_objects(&[weak_only]).expect("link weak-only");
    assert!(merged.defined.contains_key("f"));
}

#[test]
fn section_attribute_places_symbols_in_named_sections() {
    // `__attribute__((section("name")))`: the ET_REL object carries a
    // section of that name with the right type/flags, the attributed
    // symbols sit in it, and a `.rela` companion exists exactly when
    // relocations apply inside it: `.cfg.data`'s function-pointer slot
    // needs one, `.init.text` needs none (the same-section call is
    // direct; the cross-section call from `use_cfg` applies in
    // `.text`).
    use crate::c5::compiler::CompileOptions;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        "__attribute__((section(\".init.text\"))) static int boot_step(int x) { return x + 3; }\n\
         __attribute__((section(\".init.text\"))) int boot(void) { return boot_step(4); }\n\
         int cfg __attribute__((section(\".cfg.data\"))) = 35;\n\
         int cfg_zero __attribute__((section(\".cfg.data\")));\n\
         int (*hook)(void) __attribute__((section(\".cfg.data\"))) = boot;\n\
         int use_cfg(void) { return boot() + cfg + cfg_zero + hook(); }\n"
            .to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");

    // Walk the raw section headers and symbol table; the linker-side
    // parser folds named sections into families, so the assertions
    // must read the container directly.
    let u16le = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let u32le = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let u64le = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64le(0x28) as usize;
    let shnum = u16le(0x3c) as usize;
    let shstrndx = u16le(0x3e) as usize;
    let shdr = |i: usize| shoff + i * 64;
    let shstr_off = u64le(shdr(shstrndx) + 0x18) as usize;
    let name_at = |name_off: usize| -> &str {
        let s = shstr_off + name_off;
        let end = bytes[s..].iter().position(|&b| b == 0).unwrap() + s;
        core::str::from_utf8(&bytes[s..end]).unwrap()
    };
    let mut idx_of = std::collections::BTreeMap::new();
    for i in 0..shnum {
        idx_of.insert(name_at(u32le(shdr(i)) as usize).to_string(), i);
    }
    const SHT_PROGBITS: u32 = 1;
    const SHT_RELA: u32 = 4;
    const SHF_WRITE: u64 = 1;
    const SHF_ALLOC: u64 = 2;
    const SHF_EXECINSTR: u64 = 4;

    let init_i = *idx_of.get(".init.text").expect(".init.text present");
    assert_eq!(u32le(shdr(init_i) + 4), SHT_PROGBITS);
    assert_eq!(u64le(shdr(init_i) + 8), SHF_ALLOC | SHF_EXECINSTR);
    assert!(
        u64le(shdr(init_i) + 0x20) > 0,
        ".init.text holds code bytes"
    );

    let cfg_i = *idx_of.get(".cfg.data").expect(".cfg.data present");
    assert_eq!(u32le(shdr(cfg_i) + 4), SHT_PROGBITS);
    assert_eq!(u64le(shdr(cfg_i) + 8), SHF_ALLOC | SHF_WRITE);

    // `.rela` companions are on-demand: none for the reloc-free
    // `.init.text`, one for `.cfg.data` whose `hook` slot binds to
    // `boot` (retargeted to the `.init.text` section symbol).
    assert!(
        !idx_of.contains_key(".rela.init.text"),
        "no empty .rela companion"
    );
    let rela_i = *idx_of
        .get(".rela.cfg.data")
        .expect("companion rela present");
    assert_eq!(u32le(shdr(rela_i) + 4), SHT_RELA);
    assert_eq!(
        u32le(shdr(rela_i) + 0x2c) as usize,
        cfg_i,
        "sh_info names the section"
    );
    let rela_off = u64le(shdr(rela_i) + 0x18) as usize;
    let rela_size = u64le(shdr(rela_i) + 0x20) as usize;
    assert_eq!(rela_size, 24, "one relocation for the hook slot");
    let r_sym = (u64le(rela_off + 8) >> 32) as usize;

    // Symbols: boot / boot_step in .init.text; cfg (initialized) and
    // cfg_zero (zero, carved out of the bss region) in .cfg.data.
    let symtab_i = *idx_of.get(".symtab").expect(".symtab");
    let strtab_i = *idx_of.get(".strtab").expect(".strtab");
    let sym_off = u64le(shdr(symtab_i) + 0x18) as usize;
    let sym_n = (u64le(shdr(symtab_i) + 0x20) / 24) as usize;
    let str_off = u64le(shdr(strtab_i) + 0x18) as usize;
    let mut shndx_by_name = std::collections::BTreeMap::new();
    for s in 0..sym_n {
        let o = sym_off + s * 24;
        let noff = u32le(o) as usize;
        let start = str_off + noff;
        let end = bytes[start..].iter().position(|&b| b == 0).unwrap() + start;
        let name = core::str::from_utf8(&bytes[start..end]).unwrap();
        if !name.is_empty() {
            shndx_by_name.insert(name.to_string(), u16le(o + 6) as usize);
        }
    }
    assert_eq!(shndx_by_name["boot"], init_i);
    assert_eq!(shndx_by_name["boot_step"], init_i);
    assert_eq!(shndx_by_name["cfg"], cfg_i);
    assert_eq!(shndx_by_name["cfg_zero"], cfg_i);
    assert_eq!(shndx_by_name["hook"], cfg_i);
    assert_eq!(shndx_by_name["use_cfg"], idx_of[".text"]);
    assert_eq!(
        u16le(sym_off + r_sym * 24 + 6) as usize,
        init_i,
        "hook's reloc binds to the .init.text section symbol"
    );

    // The `.cfg.data` payload starts with cfg's initializer.
    let cfg_off = u64le(shdr(cfg_i) + 0x18) as usize;
    assert_eq!(&bytes[cfg_off..cfg_off + 4], &35i32.to_le_bytes());
}

/// Section headers of an ET_REL image: `name -> (sh_size, sh_addralign)`.
#[cfg(feature = "native-emit")]
type ElfSectionMap = std::collections::BTreeMap<String, (u64, u64)>;
/// Named symbols of an ET_REL image: `name -> (st_shndx, st_value)`.
#[cfg(feature = "native-emit")]
type ElfSymbolMap = std::collections::BTreeMap<String, (usize, u64)>;

/// Section headers and object symbols of an ET_REL image, for the
/// named-section layout tests below.
#[cfg(feature = "native-emit")]
fn elf_layout(bytes: &[u8]) -> (ElfSectionMap, ElfSymbolMap) {
    let u16le = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap());
    let u32le = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let u64le = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64le(0x28) as usize;
    let shnum = u16le(0x3c) as usize;
    let shstrndx = u16le(0x3e) as usize;
    let shdr = |i: usize| shoff + i * 64;
    let shstr_off = u64le(shdr(shstrndx) + 0x18) as usize;
    let name_at = |off: usize| -> String {
        let s = shstr_off + off;
        let end = bytes[s..].iter().position(|&b| b == 0).unwrap() + s;
        core::str::from_utf8(&bytes[s..end]).unwrap().to_string()
    };
    let mut sections = std::collections::BTreeMap::new();
    let mut by_index: Vec<String> = Vec::with_capacity(shnum);
    for i in 0..shnum {
        let name = name_at(u32le(shdr(i)) as usize);
        sections.insert(name.clone(), (u64le(shdr(i) + 0x20), u64le(shdr(i) + 0x30)));
        by_index.push(name);
    }
    let symtab_i = by_index.iter().position(|n| n == ".symtab").unwrap();
    let strtab_i = by_index.iter().position(|n| n == ".strtab").unwrap();
    let sym_off = u64le(shdr(symtab_i) + 0x18) as usize;
    let sym_n = (u64le(shdr(symtab_i) + 0x20) / 24) as usize;
    let str_off = u64le(shdr(strtab_i) + 0x18) as usize;
    let mut syms = std::collections::BTreeMap::new();
    for s in 0..sym_n {
        let o = sym_off + s * 24;
        let start = str_off + u32le(o) as usize;
        let end = bytes[start..].iter().position(|&b| b == 0).unwrap() + start;
        let name = core::str::from_utf8(&bytes[start..end]).unwrap();
        if !name.is_empty() {
            syms.insert(name.to_string(), (u16le(o + 6) as usize, u64le(o + 8)));
        }
    }
    (sections, syms)
}

#[cfg(feature = "native-emit")]
fn emit_reloc_for(src: &str) -> alloc::vec::Vec<u8> {
    use crate::c5::compiler::CompileOptions;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let program = Compiler::with_options(
        src.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit")
}

#[test]
#[cfg(feature = "native-emit")]
fn named_section_alignment_and_size_data_only_unit() {
    // A unit with no functions (the data-table TU shape): each named
    // section's sh_addralign is its members' widest alignment --
    // explicit `aligned(N)`, a natural aggregate alignment, or an
    // aligned typedef -- its sh_size is exactly the members' span, and
    // `.data` holds only the default-placement objects (the NULL guard
    // slot plus `in_data`'s slot), not a shadow of the moved ones.
    // Sizes and alignments match `gcc -c` on the same source.
    let bytes = emit_reloc_for(
        "__attribute__((section(\".d.ro\"), aligned(4096))) char raw[8192];\n\
         __attribute__((section(\".d.c64\"), aligned(64))) int v64;\n\
         struct nat16 { long long a, b; } __attribute__((aligned(16)));\n\
         __attribute__((section(\".d.nat\"))) struct nat16 s16;\n\
         typedef struct { char page[4096]; } __attribute__((aligned(4096))) page_t;\n\
         __attribute__((section(\".d.page\"))) page_t percpu_page;\n\
         int in_data = 5;\n",
    );
    let (sections, syms) = elf_layout(&bytes);
    assert_eq!(sections[".d.ro"], (8192, 4096));
    assert_eq!(sections[".d.c64"], (4, 64));
    assert_eq!(sections[".d.nat"], (16, 16));
    assert_eq!(sections[".d.page"], (4096, 4096));
    assert_eq!(sections[".data"], (16, 8), "no ghost bytes in .data");
    assert_eq!(sections[".bss"].0, 0);
    assert_eq!(syms["raw"].1, 0);
    assert_eq!(syms["in_data"].1, 8);
}

#[test]
#[cfg(feature = "native-emit")]
fn named_section_members_pack_in_declaration_order() {
    // Several objects sharing one named section: bases follow
    // declaration order at each member's own alignment (matching the
    // emission order a toolchain assembler produces), even though the
    // zero objects are segregated into the bss region of the unified
    // layout first. Offsets, section sizes, and alignments match
    // `gcc -c` on the same source; `.data` and `.bss` keep only the
    // default-placement objects.
    let bytes = emit_reloc_for(
        "__attribute__((section(\".ms\"), aligned(64))) char a[10];\n\
         __attribute__((section(\".ms\"))) int b = 7;\n\
         __attribute__((section(\".ms\"), aligned(16))) char c[3] = {1, 2, 3};\n\
         __attribute__((section(\".ms\"))) long long d;\n\
         __attribute__((section(\".other\"), aligned(256))) static int st = 42;\n\
         int plain = 9;\n\
         long long reader(void) { return a[0] + b + c[1] + d + st + plain; }\n\
         char *one_past_a(void) { return a + sizeof(a); }\n",
    );
    let (sections, syms) = elf_layout(&bytes);
    assert_eq!(sections[".ms"], (0x20, 64));
    assert_eq!(sections[".other"], (4, 256));
    let ms = syms["a"].0;
    assert_eq!(syms["a"], (ms, 0));
    assert_eq!(syms["b"], (ms, 0xc));
    assert_eq!(syms["c"], (ms, 0x10));
    assert_eq!(syms["d"], (ms, 0x18));
    assert!(
        sections[".data"].0 < 0x40,
        ".data keeps only the guard, plain, and literals (got {:#x})",
        sections[".data"].0
    );
    assert_eq!(sections[".data"].1, 8, ".data alignment not inflated");
    assert_eq!(sections[".bss"].0, 0, "no ghost bytes in .bss");
}

#[test]
#[cfg(feature = "native-emit")]
fn named_section_object_keeps_its_flexible_array_tail() {
    // C99 6.7.2.1p16 leaves a flexible array member out of `sizeof`, but
    // a definition that initializes it occupies the element bytes: the
    // object's size is `sizeof` plus them, and the next object in the
    // named section starts past them rather than over them. `gcc -c` on
    // the same source gives `.fam` sh_size 0x78, `st_size` 32 / 65 / 16
    // for head / tail / table, and 0x48 from the tail object's start to
    // the next object's; the tail object's 65 bytes are the same.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        struct over { unsigned long v; };\n\
        struct desc {\n\
            char name[20];\n\
            union { struct over *ptr; signed int off; } over;\n\
            struct { char field[10]; unsigned char shift; } regs[];\n\
        };\n\
        static struct over t1, t2;\n\
        #define SEC __attribute__((section(\".fam\"), aligned(8)))\n\
        SEC const struct desc head = { .name = \"head\", .over = { &t1 } };\n\
        SEC const struct desc tail = { .name = \"tail\", .over = { &t2 },\n\
            .regs = { {\"aa\", 1}, {\"bb\", 2}, {\"cc\", 3} } };\n\
        SEC const struct desc *const table[] = { &head, &tail };\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::with_options(
            src.to_string(),
            target,
            CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let (sections, _) = elf_layout(&bytes);
        assert_eq!(sections[".fam"], (0x78, 8), "{target:?}: section extent");
        let syms = elf_symbols(&bytes);
        let by_name = |n: &str| {
            let s = syms.iter().find(|s| s.0 == n).expect("symbol");
            (s.3, s.4)
        };
        assert_eq!(by_name("head"), (0x00, 32), "{target:?}: head");
        assert_eq!(by_name("tail"), (0x20, 65), "{target:?}: tail");
        assert_eq!(by_name("table"), (0x68, 16), "{target:?}: table");
        let body = elf_sections(&bytes)
            .into_iter()
            .find(|(n, ..)| n == ".fam")
            .expect(".fam section")
            .3;
        // The tail object: name, the 8-byte union slot the relocation
        // fills, then the three initialized elements (11 bytes each).
        let mut want = alloc::vec![0u8; 65];
        want[..4].copy_from_slice(b"tail");
        for (i, (name, shift)) in [("aa", 1u8), ("bb", 2), ("cc", 3)].iter().enumerate() {
            let at = 32 + i * 11;
            want[at..at + name.len()].copy_from_slice(name.as_bytes());
            want[at + 10] = *shift;
        }
        let got = &body[0x20..0x20 + 65];
        assert_eq!(&got[..24], &want[..24], "{target:?}: fixed fields");
        assert_eq!(&got[32..], &want[32..], "{target:?}: initialized elements");
    }
}

/// Minimal ELF64 section-header walk for the tests below: returns
/// `(name, sh_type, sh_flags, bytes)` per section.
fn elf_sections(bytes: &[u8]) -> alloc::vec::Vec<(String, u32, u64, alloc::vec::Vec<u8>)> {
    let u16le = |o: usize| u16::from_le_bytes(bytes[o..o + 2].try_into().unwrap()) as usize;
    let u32le = |o: usize| u32::from_le_bytes(bytes[o..o + 4].try_into().unwrap());
    let u64le = |o: usize| u64::from_le_bytes(bytes[o..o + 8].try_into().unwrap());
    let shoff = u64le(0x28) as usize;
    let shentsize = u16le(0x3A);
    let shnum = u16le(0x3C);
    let shstrndx = u16le(0x3E);
    let strtab_off = u64le(shoff + shstrndx * shentsize + 0x18) as usize;
    let mut out = alloc::vec::Vec::new();
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        let name_off = strtab_off + u32le(sh) as usize;
        let name_end = bytes[name_off..].iter().position(|&b| b == 0).unwrap() + name_off;
        let name = String::from_utf8_lossy(&bytes[name_off..name_end]).into_owned();
        let sh_type = u32le(sh + 0x04);
        let sh_flags = u64le(sh + 0x08);
        let off = u64le(sh + 0x18) as usize;
        let size = u64le(sh + 0x20) as usize;
        let body = if sh_type == 8 {
            alloc::vec::Vec::new() // SHT_NOBITS
        } else {
            bytes[off..off + size].to_vec()
        };
        out.push((name, sh_type, sh_flags, body));
    }
    out
}

#[test]
fn file_scope_asm_pushsection_lands_in_relocatable_object() {
    // A file-scope `asm(".pushsection ...")` block emits into the named
    // section of the `-c` object exactly as an in-function block does:
    // constants and strings laid out, a C symbol reference emitted as a
    // named-symbol relocation.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int export_me(void) { return 42; }\n\
        __asm__(\".pushsection .export_tab,\\\"a\\\"\\n\"\n\
            \".balign 8\\n\"\n\
            \".quad export_me\\n\"\n\
            \".long 7\\n\"\n\
            \".asciz \\\"export_me\\\"\\n\"\n\
            \".popsection\");\n\
        int main(void) { return export_me(); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".export_tab")
            .unwrap_or_else(|| panic!("{target:?}: .export_tab section missing"));
        assert_eq!(sec.1, 1, "{target:?}: SHT_PROGBITS expected");
        assert_eq!(sec.2 & 0x2, 0x2, "{target:?}: SHF_ALLOC expected");
        // 8 (quad symbol ref) + 4 (constant 7) + 10 (asciz + NUL).
        assert_eq!(sec.3.len(), 22, "{target:?}: section size");
        assert_eq!(&sec.3[8..12], &7u32.to_le_bytes(), "{target:?}: constant");
        assert_eq!(&sec.3[12..22], b"export_me\0", "{target:?}: asciz");
        // One abs64 relocation against the `export_me` function symbol.
        let rela = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.export_tab")
            .unwrap_or_else(|| panic!("{target:?}: .rela.export_tab missing"));
        assert_eq!(rela.1, 4, "{target:?}: SHT_RELA expected");
        assert_eq!(rela.3.len(), 24, "{target:?}: one relocation");
        let r_offset = u64::from_le_bytes(rela.3[0..8].try_into().unwrap());
        let r_info = u64::from_le_bytes(rela.3[8..16].try_into().unwrap());
        let abs64 = match target {
            Target::LinuxX64 => 1u64,
            _ => 257,
        };
        assert_eq!(r_offset, 0, "{target:?}: reloc at the quad field");
        assert_eq!(r_info & 0xFFFF_FFFF, abs64, "{target:?}: abs64 type");
        // The relocation's symbol is the C function, by name.
        let symtab = &sections
            .iter()
            .find(|(n, _, _, _)| n == ".symtab")
            .unwrap()
            .3;
        let strtab = &sections
            .iter()
            .find(|(n, _, _, _)| n == ".strtab")
            .unwrap()
            .3;
        let sym = (r_info >> 32) as usize;
        let st_name =
            u32::from_le_bytes(symtab[sym * 24..sym * 24 + 4].try_into().unwrap()) as usize;
        let end = strtab[st_name..].iter().position(|&b| b == 0).unwrap();
        assert_eq!(
            &strtab[st_name..st_name + end],
            b"export_me",
            "{target:?}: reloc symbol name"
        );
    }
}

/// The `-c` object's `.symtab` entries as `(name, info, shndx, value, size)`.
fn elf_symbols(bytes: &[u8]) -> alloc::vec::Vec<(String, u8, u16, u64, u64)> {
    let sections = elf_sections(bytes);
    let symtab = &sections
        .iter()
        .find(|(n, _, _, _)| n == ".symtab")
        .unwrap()
        .3;
    let strtab = &sections
        .iter()
        .find(|(n, _, _, _)| n == ".strtab")
        .unwrap()
        .3;
    symtab
        .chunks_exact(24)
        .map(|e| {
            let st_name = u32::from_le_bytes(e[0..4].try_into().unwrap()) as usize;
            let end = strtab[st_name..].iter().position(|&b| b == 0).unwrap();
            (
                String::from_utf8_lossy(&strtab[st_name..st_name + end]).into_owned(),
                e[4],
                u16::from_le_bytes(e[6..8].try_into().unwrap()),
                u64::from_le_bytes(e[8..16].try_into().unwrap()),
                u64::from_le_bytes(e[16..24].try_into().unwrap()),
            )
        })
        .collect()
}

#[test]
fn single_tu_image_folds_called_asm_section_code() {
    // A single-TU final image has no link step, so an executable pushed
    // section whose label the C code calls is folded into the text stream:
    // the emit must succeed (not report the callee undefined), the wrapper
    // body must be present in the image, and its inner call must be
    // resolved to a nonzero displacement. The execution round-trip is
    // covered by the ELF fixture-parity suites on a matching host.
    use crate::c5::{NativeOptions, Target, emit_native_with_options};
    let src = "\
        int cs_inner(int x);\n\
        __asm__(\".pushsection .spinlock.text, \\\"ax\\\"\\n\"\n\
                \".globl cs_wrapper\\n\"\n\
                \".type cs_wrapper, @function\\n\"\n\
                \"cs_wrapper:push %rcx;\"\n\
                \"push %rdx;\"\n\
                \"push %rsi;\"\n\
                \"call cs_inner;\"\n\
                \"pop %rsi;\"\n\
                \"pop %rdx;\"\n\
                \"pop %rcx;\"\n\
                \"ret\\n\"\n\
                \".size cs_wrapper, .-cs_wrapper\\n\"\n\
                \".popsection\");\n\
        int cs_inner(int x) { return x + 5; }\n\
        int cs_wrapper(int x);\n\
        int main(void) { return cs_wrapper(37); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let bytes = emit_native_with_options(&program, Target::LinuxX64, NativeOptions::default())
        .expect("a called asm-section label must resolve in a single-TU image");
    // push %rcx; push %rdx; push %rsi; call rel32 ... pop %rsi; pop %rdx;
    // pop %rcx; ret.
    let head = [0x51u8, 0x52, 0x56, 0xE8];
    let at = bytes
        .windows(head.len())
        .position(|w| w == head)
        .expect("the folded wrapper body must be in the image");
    let rel = i32::from_le_bytes(bytes[at + 4..at + 8].try_into().unwrap());
    assert_ne!(
        rel, 0,
        "the inner call must be resolved, not left a placeholder"
    );
    assert_eq!(
        &bytes[at + 8..at + 12],
        &[0x5E, 0x5A, 0x59, 0xC3],
        "the wrapper tail follows the call"
    );
}

#[test]
fn file_scope_asm_numeric_labels_bind_per_definition() {
    // GNU as numeric labels are redefinable: each `10:` is a new instance
    // and a `10b` reference binds to the nearest definition backward,
    // across a nested pushed section. Each definition gets its own
    // per-instance local symbol, so the two table entries relocate
    // against distinct labels at their own offsets.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        asm(\".pushsection .tbl,\\\"a\\\"\\n\"\n\
            \"10: .byte 1\\n\"\n\
            \"11: .byte 2\\n\"\n\
            \".pushsection .refs,\\\"a\\\"\\n\"\n\
            \".long (10b) - .\\n.long (11b) - .\\n\"\n\
            \".popsection\\n\"\n\
            \"10: .byte 3\\n\"\n\
            \"11: .byte 4\\n\"\n\
            \".pushsection .refs,\\\"a\\\"\\n\"\n\
            \".long (10b) - .\\n.long (11b) - .\\n\"\n\
            \".popsection\\n\"\n\
            \".popsection\");\n\
        int main(void) { return 0; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let tbl = &sections.iter().find(|(n, _, _, _)| n == ".tbl").unwrap().3;
        assert_eq!(tbl, &[1u8, 2, 3, 4], "{target:?}: label bytes");
        let rela = &sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.refs")
            .unwrap_or_else(|| panic!("{target:?}: .rela.refs missing"))
            .3;
        assert_eq!(rela.len(), 4 * 24, "{target:?}: four relocations");
        let symbols = elf_symbols(&bytes);
        // Each reloc's symbol is a distinct per-instance label whose value
        // is that definition's offset in `.tbl` (1, 2, 3, 4 -> 0, 1, 2, 3).
        let mut names = alloc::vec::Vec::new();
        for (i, r) in rela.chunks_exact(24).enumerate() {
            let r_info = u64::from_le_bytes(r[8..16].try_into().unwrap());
            let sym = &symbols[(r_info >> 32) as usize];
            assert_eq!(
                sym.3, i as u64,
                "{target:?}: entry {i} binds the nearest-backward definition"
            );
            names.push(sym.0.clone());
        }
        names.sort();
        names.dedup();
        assert_eq!(names.len(), 4, "{target:?}: four distinct label symbols");
    }
}

#[test]
fn file_scope_asm_weak_and_set_emit_weak_symbols() {
    // `.set alias, target` + `.weak alias` is a weak alias of a function
    // in the unit (the conditional-syscall shape): FUNC, WEAK, the
    // target's value and size. `.weak` on a section label binds the label
    // weak; `.weak` of an undefined name yields a weak UNDEF entry.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        long ni_syscall(void) { return -38; }\n\
        asm(\".weak sys_alias\\n\\t.set  sys_alias,ni_syscall\");\n\
        asm(\".pushsection .rodata,\\\"a\\\"\\n\"\n\
            \".weak weak_marker\\n\"\n\
            \"weak_marker:\\n.long 7\\n\"\n\
            \".popsection\");\n\
        asm(\".weak optional_hook\");\n\
        int main(void) { return 0; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let symbols = elf_symbols(&bytes);
        let by_name = |n: &str| {
            symbols
                .iter()
                .find(|s| s.0 == n)
                .unwrap_or_else(|| panic!("{target:?}: symbol `{n}` missing"))
        };
        const STB_WEAK: u8 = 2;
        const STT_FUNC: u8 = 2;
        let tgt = by_name("ni_syscall");
        let alias = by_name("sys_alias");
        assert_eq!(
            alias.1,
            (STB_WEAK << 4) | STT_FUNC,
            "{target:?}: alias info"
        );
        assert_eq!(alias.2, tgt.2, "{target:?}: alias section");
        assert_eq!(alias.3, tgt.3, "{target:?}: alias value");
        assert_eq!(alias.4, tgt.4, "{target:?}: alias size");
        let marker = by_name("weak_marker");
        assert_eq!(marker.1 >> 4, STB_WEAK, "{target:?}: weak label binding");
        assert_ne!(marker.2, 0, "{target:?}: weak label is defined");
        let hook = by_name("optional_hook");
        assert_eq!(hook.1 >> 4, STB_WEAK, "{target:?}: weak undef binding");
        assert_eq!(hook.2, 0, "{target:?}: weak undef is SHN_UNDEF");
    }
}

#[test]
fn self_referential_global_stays_defined_in_object() {
    // C99 6.6p9 + 6.2.2p4: a file-scope object whose initializer takes its
    // own address, referenced through a prior extern declaration and
    // redeclared extern after the definition, is still one defined symbol
    // in the relocatable object -- never an undefined reference, never
    // dropped -- with `st_size` = sizeof (the flexible array member
    // contributes nothing).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        struct queue;\n\
        struct sched {\n\
            struct sched *self;\n\
            struct queue *dq;\n\
            int id;\n\
            long priv[];\n\
        };\n\
        struct queue { struct sched *sd; struct sched *sleeping; };\n\
        extern struct sched s_obj;\n\
        static struct queue q_obj = {\n\
            .sd = (typeof(*(&s_obj)) *)(&s_obj),\n\
            .sleeping = &s_obj,\n\
        };\n\
        struct sched s_obj = { .self = &s_obj, .dq = &q_obj, .id = 9 };\n\
        extern typeof(s_obj) s_obj;\n\
        struct queue *keep = &q_obj;\n\
        int main(void) { return 0; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let symbols = elf_symbols(&bytes);
        let entries: alloc::vec::Vec<_> = symbols.iter().filter(|s| s.0 == "s_obj").collect();
        assert_eq!(
            entries.len(),
            1,
            "{target:?}: one `s_obj` symbol, no import twin"
        );
        let s = entries[0];
        const STB_GLOBAL: u8 = 1;
        const STT_OBJECT: u8 = 1;
        assert_eq!(
            s.1,
            (STB_GLOBAL << 4) | STT_OBJECT,
            "{target:?}: global object"
        );
        assert_ne!(s.2, 0, "{target:?}: defined, not SHN_UNDEF");
        assert_eq!(s.4, 24, "{target:?}: st_size = sizeof(struct sched)");
    }
}

#[test]
fn file_scope_asm_incbin_embeds_file_bytes() {
    // `.incbin "path"` splices the file's raw bytes at that point in the
    // section image; the path resolves as GNU as resolves it, against the
    // working directory (an absolute path here, so the test is
    // cwd-independent). A missing file is a compile error naming the path.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let payload = b"\x00\x01binary\xffpayload";
    let path = std::env::temp_dir().join("badc_incbin_test.bin");
    std::fs::write(&path, payload).expect("write payload");
    let src = alloc::format!(
        "asm(\".pushsection .blob,\\\"a\\\"\\n\"\n\
             \".byte 0x5a\\n\"\n\
             \".incbin \\\"{}\\\"\\n\"\n\
             \".byte 0xa5\\n\"\n\
             \".popsection\");\n\
         int main(void) {{ return 0; }}\n",
        // Forward slashes keep the embedded C string literal free of
        // escape sequences; Windows file APIs accept them.
        path.display().to_string().replace('\\', "/")
    );
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(src.clone()).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let blob = &sections.iter().find(|(n, _, _, _)| n == ".blob").unwrap().3;
        let mut expect = alloc::vec![0x5au8];
        expect.extend_from_slice(payload);
        expect.push(0xa5);
        assert_eq!(blob, &expect, "{target:?}: spliced bytes");
    }
    let missing = "asm(\".pushsection .blob,\\\"a\\\"\\n.incbin \\\"badc_no_such_payload.bin\\\"\\n.popsection\");";
    let err = Compiler::new(String::from(missing))
        .compile()
        .expect_err("missing file must be a compile error");
    let msg = alloc::format!("{err:?}");
    assert!(
        msg.contains("badc_no_such_payload.bin") && msg.contains("cannot read"),
        "diagnostic names the path: {msg}"
    );
}

#[test]
fn inline_asm_pushsection_lands_in_relocatable_object() {
    // A `.pushsection` data block must appear as a named section of the
    // `-c` object, with its constants resolved and its label references
    // emitted as relocations against `.text`.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int f(int *p) {\n\
            int r;\n\
            __asm__(\"1: nop\\n\"\n\
                \".pushsection .discard.probe,\\\"a\\\"\\n\"\n\
                \".balign 8\\n\"\n\
                \".quad 1b\\n\"\n\
                \".long 1b - .\\n\"\n\
                \".long %c[k]\\n\"\n\
                \".popsection\\n\"\n\
                \"mov %1, %0\"\n\
                : \"=r\"(r) : \"r\"(*p), [k] \"i\"(42));\n\
            return r;\n\
        }\n\
        int main(void) { int v = 42; return f(&v); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".discard.probe")
            .unwrap_or_else(|| panic!("{target:?}: .discard.probe section missing"));
        assert_eq!(sec.1, 1, "{target:?}: SHT_PROGBITS expected");
        assert_eq!(sec.2 & 0x2, 0x2, "{target:?}: SHF_ALLOC expected");
        // 8 (quad label ref) + 4 (pcrel ref) + 4 (constant 42).
        assert_eq!(sec.3.len(), 16, "{target:?}: section size");
        assert_eq!(&sec.3[12..16], &42u32.to_le_bytes(), "{target:?}: %c value");
        // The companion .rela with two entries against .text.
        let rela = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.discard.probe")
            .unwrap_or_else(|| panic!("{target:?}: .rela.discard.probe missing"));
        assert_eq!(rela.1, 4, "{target:?}: SHT_RELA expected");
        assert_eq!(rela.3.len(), 2 * 24, "{target:?}: two relocations");
        let r_info =
            |k: usize| u64::from_le_bytes(rela.3[k * 24 + 8..k * 24 + 16].try_into().unwrap());
        let (abs64, prel32) = match target {
            Target::LinuxX64 => (1u64, 2u64),
            _ => (257, 261),
        };
        assert_eq!(r_info(0) & 0xFFFF_FFFF, abs64, "{target:?}: abs64 type");
        assert_eq!(r_info(1) & 0xFFFF_FFFF, prel32, "{target:?}: pcrel32 type");
    }
}

#[test]
fn asm_section_align_fill_byte() {
    // GNU as `.balign n, fill` / `.p2align e, fill` pad with the given fill
    // byte. In an executable section the padding must carry that byte, not
    // zero: the compiler once parsed the whole operand as the alignment and
    // rejected `n, 0x90`. Distinct fills (0x90, 0xcc) confirm the byte is
    // applied literally rather than hardcoded.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int f(void) {\n\
            __asm__ volatile(\".pushsection .exec_align_probe,\\\"ax\\\"\\n\"\n\
                \".byte 0x11\\n\"\n\
                \".balign 16, 0x90\\n\"\n\
                \".byte 0x22\\n\"\n\
                \".p2align 5, 0xcc\\n\"\n\
                \".byte 0x33\\n\"\n\
                \".popsection\\n\");\n\
            return 0;\n\
        }\n\
        int main(void) { return f(); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(n, _, _, _)| n == ".exec_align_probe")
        .expect(".exec_align_probe section missing");
    assert_eq!(sec.2 & 0x4, 0x4, "SHF_EXECINSTR expected");
    let body = &sec.3;
    // 0x11 | pad to 16 with 0x90 | 0x22 | pad to 32 with 0xcc | 0x33.
    assert_eq!(body.len(), 33, "section size: {body:02x?}");
    assert_eq!(body[0], 0x11);
    assert!(
        body[1..16].iter().all(|&b| b == 0x90),
        "exec .balign fill must be 0x90: {body:02x?}"
    );
    assert_eq!(body[16], 0x22);
    assert!(
        body[17..32].iter().all(|&b| b == 0xcc),
        "exec .p2align fill must be 0xcc: {body:02x?}"
    );
    assert_eq!(body[32], 0x33);
}

#[test]
fn asm_section_space_and_fill_family() {
    // The GNU as space-and-fill family inside a named section. `.skip` and
    // `.space` are the same directive, `.zero` fixes the fill at zero, and
    // `.fill repeat, size, value` repeats the low `size` bytes of the value
    // zero-extended to eight. The expected bytes are the reference
    // assembler's output for the same directives.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int f(void) {\n\
            __asm__ volatile(\".pushsection .fill_probe,\\\"a\\\"\\n\"\n\
                \".skip 4, 0x90\\n\"\n\
                \".space 3, 0x41\\n\"\n\
                \".zero 5\\n\"\n\
                \".fill 3\\n\"\n\
                \".fill 2, 4, 0x11223344\\n\"\n\
                \".fill 2, 8, 0x11223344\\n\"\n\
                \".fill 1, 3, 0xaabbccdd\\n\"\n\
                \".fill 1, 12, 0x11223344\\n\"\n\
                \".skip 2\\n\"\n\
                \".popsection\\n\");\n\
            return 0;\n\
        }\n\
        int main(void) { return f(); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(n, _, _, _)| n == ".fill_probe")
        .expect(".fill_probe section missing");
    #[rustfmt::skip]
    let want: &[u8] = &[
        0x90, 0x90, 0x90, 0x90,
        0x41, 0x41, 0x41,
        0, 0, 0, 0, 0,
        0, 0, 0,
        0x44, 0x33, 0x22, 0x11, 0x44, 0x33, 0x22, 0x11,
        0x44, 0x33, 0x22, 0x11, 0, 0, 0, 0,
        0x44, 0x33, 0x22, 0x11, 0, 0, 0, 0,
        0xdd, 0xcc, 0xbb,
        0x44, 0x33, 0x22, 0x11, 0, 0, 0, 0,
        0, 0,
    ];
    assert_eq!(sec.3, want, "section body: {:02x?}", sec.3);
}

#[test]
fn asm_section_local_binding_and_elf_type_spelling() {
    // `.local` completes the binding family beside `.globl` / `.weak`, and
    // GNU as accepts the ELF constant spellings (`STT_OBJECT`) of a `.type`
    // alongside `@object`. A `.zero`-sized object declared this way must come
    // out as a local `STT_OBJECT` symbol of the stated size.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int f(void) {\n\
            __asm__ volatile(\".pushsection .idlist,\\\"a\\\"\\n\"\n\
                \".local probe_id\\n\"\n\
                \".type probe_id, STT_OBJECT\\n\"\n\
                \".size probe_id, 4\\n\"\n\
                \"probe_id:\\n\"\n\
                \".zero 4\\n\"\n\
                \".popsection\\n\");\n\
            return 0;\n\
        }\n\
        int main(void) { return f(); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(n, _, _, _)| n == ".idlist")
        .expect(".idlist section missing");
    assert_eq!(sec.3, vec![0u8; 4], "`.zero 4` must emit four zero bytes");
    let obj = crate::c5::linker::parse_native_elf(&bytes).expect("parse ET_REL");
    let sym = obj
        .symbols
        .iter()
        .find(|s| s.name == "probe_id")
        .expect("`probe_id` must be a symbol");
    const STT_OBJECT: u8 = 1;
    const STB_LOCAL: u8 = 0;
    assert_eq!(sym.kind, STT_OBJECT, "`STT_OBJECT` spelling honored");
    assert_eq!(sym.binding, STB_LOCAL, "`.local` keeps local binding");
    assert_eq!(sym.size, 4, "`.size` applies to the local object");
}

#[test]
fn asm_section_const_local_folds_with_alloca_present() {
    // A `.long %c[..]` section datum fed by an address-free local
    // constant must fold at -O even when the function also uses a VLA
    // (dynamic sp). The alloca once disabled mem2reg for the whole
    // function, leaving the local in a frame slot the section-data
    // emit could not read (`non-constant section data value`). gcc
    // const-propagates it regardless; badc must match. `flags` is
    // `(1<<0)|((1<<3)|((9)<<8))` == 2313.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int probe(int *p, int n) {\n\
            int r;\n\
            __auto_type flags = (1 << 0) | ((1 << 3) | ((9) << 8));\n\
            __asm__(\"1: nop\\n\"\n\
                \".pushsection .bug_tab,\\\"aw\\\"\\n\"\n\
                \".long 1b - .\\n\"\n\
                \".long %c[f]\\n\"\n\
                \".popsection\\n\"\n\
                \"mov %1, %0\"\n\
                : \"=r\"(r) : \"r\"(*p), [f] \"i\"(flags));\n\
            { char buf[n]; buf[0] = 0; r += buf[0]; }\n\
            return r;\n\
        }\n\
        int main(void) { int v = 7; return probe(&v, 4); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::with_target(String::from(src), target)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            optimize: true,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts)
            .unwrap_or_else(|e| panic!("{target:?}: emit -O: {e}"));
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".bug_tab")
            .unwrap_or_else(|| panic!("{target:?}: .bug_tab section missing"));
        // 4 (pcrel label ref) + 4 (folded constant 2313).
        assert_eq!(sec.3.len(), 8, "{target:?}: section size");
        assert_eq!(
            &sec.3[4..8],
            &2313u32.to_le_bytes(),
            "{target:?}: folded %c[f] value"
        );
    }
}

#[test]
fn always_inline_trap_accessor_folds_section_operand() {
    // An always_inline accessor whose asm-goto writes a `.hword %[c]`
    // section datum from an `i` (immediate-only) operand is an
    // integer-constant-expression (C99 6.6) only once a constant
    // argument substitutes. Its always_inline caller holds a
    // `__builtin_unreachable` (an `Intrinsic::Trap`); the inliner once
    // rejected any intrinsic, so the caller stayed out of line and its
    // out-of-line emit failed on the non-constant section datum. The
    // inliner now admits a non-frame-bound intrinsic, so both accessors
    // inline at the constant call site, the datum folds, and the
    // out-of-line bodies drop.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        static __attribute__((always_inline)) inline int\n\
        emit_tag(const unsigned long c) {\n\
            __asm__ goto(\".pushsection .tag_tab,\\\"a\\\"\\n\"\n\
                \".hword %[c]\\n\"\n\
                \".popsection\\n\" : : [c] \"i\"(c) : : hit);\n\
            return 0;\n\
        hit:\n\
            return 1;\n\
        }\n\
        static __attribute__((always_inline)) inline int\n\
        pick_tag(int n, int ready) {\n\
            if (ready)\n\
                return emit_tag(n);\n\
            __builtin_unreachable();\n\
        }\n\
        static int probe(int r) { return pick_tag(42, r); }\n\
        int main(void) { volatile int r = 1; return probe(r); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        optimize: true,
        ..Default::default()
    };
    // A successful emit is itself the regression guard: the out-of-line
    // accessor emit failed with `non-constant section data value`.
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts)
        .unwrap_or_else(|e| panic!("emit -O: {e}"));
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(n, _, _, _)| n == ".tag_tab")
        .expect(".tag_tab section missing");
    // The `.hword %[c]` folds to the constant argument 42 (0x002a).
    assert_eq!(sec.3, 42u16.to_le_bytes(), "folded %[c] value");
    // Both always_inline accessors inlined at the call site and their
    // out-of-line bodies dropped from the object -- no residual symbol.
    for name in [b"emit_tag".as_slice(), b"pick_tag".as_slice()] {
        assert!(
            !bytes.windows(name.len()).any(|w| w == name),
            "inlined accessor kept an out-of-line body"
        );
    }
}

#[test]
fn inline_asm_numeric_label_defined_twice_binds_nearest() {
    // GNU as permits a numeric label many definitions; a reference `Nf`
    // resolves to the nearest definition at a greater source position, `Nb`
    // to the nearest at a not-greater one. Label `1` is defined three times;
    // the two `1f - 1b` differences sit between successive definitions, so
    // each binds to a different pair -- the first spans definitions 1..2 (4
    // bytes), the second spans 2..3 (2 bytes). A position-agnostic binding
    // would give one value for both.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int main(void) {\n\
            __asm__ volatile(\n\
                \".pushsection .lt,\\\"a\\\"\\n\"\n\
                \"1:\\n\"\n\
                \".byte 1f - 1b\\n\"\n\
                \".byte 0,0,0\\n\"\n\
                \"1:\\n\"\n\
                \".byte 1f - 1b\\n\"\n\
                \".byte 0\\n\"\n\
                \"1:\\n\"\n\
                \".popsection\\n\");\n\
            return 0;\n\
        }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        optimize: true,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(n, _, _, _)| n == ".lt")
        .expect(".lt section missing");
    // The first `1f - 1b` is definitions 1..2 (4 bytes), the second is 2..3
    // (2 bytes). Both differences fold to constants -- no relocation.
    assert_eq!(
        sec.3,
        [0x04, 0, 0, 0, 0x02, 0],
        "nearest-in-direction binding"
    );
    assert!(
        !sections.iter().any(|(n, _, _, _)| n == ".rela.lt"),
        "same-section differences fold to constants"
    );
}

#[test]
fn inline_asm_multidef_numeric_labels_bind_by_position() {
    // Two nested replacement arms reuse the numeric labels `771`..`775`, so
    // each is defined twice. A `.skip` sizes the padding of each arm from its
    // own replacement length, an entry section records each arm's source and
    // replacement lengths, and cross-section references reach each arm's
    // replacement. Every reference must bind to its own arm's definitions by
    // source position, matching GNU as; a position-agnostic binding would use
    // the last definition for both arms (a silent miscompile).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int main(void) {\n\
            __asm__ volatile(\n\
                \"771:\\n771:\\n\"\n\
                \"nop\\n\"\n\
                \"772:\\n\"\n\
                \".skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90\\n\"\n\
                \"773:\\n\"\n\
                \".pushsection .alti,\\\"a\\\"\\n\"\n\
                \".long 771b - .\\n.long 774f - .\\n.byte 773b-771b\\n.byte 775f-774f\\n\"\n\
                \".popsection\\n\"\n\
                \".pushsection .altr,\\\"ax\\\"\\n774:\\nnop\\nnop\\n775:\\n.popsection\\n\"\n\
                \"772:\\n\"\n\
                \".skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90\\n\"\n\
                \"773:\\n\"\n\
                \".pushsection .alti,\\\"a\\\"\\n\"\n\
                \".long 771b - .\\n.long 774f - .\\n.byte 773b-771b\\n.byte 775f-774f\\n\"\n\
                \".popsection\\n\"\n\
                \".pushsection .altr,\\\"ax\\\"\\n774:\\nnop\\nnop\\nnop\\nnop\\nnop\\n775:\\n.popsection\\n\"\n\
                ::: \"memory\");\n\
            return 0;\n\
        }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        optimize: true,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let alti = &sections
        .iter()
        .find(|(n, _, _, _)| n == ".alti")
        .expect(".alti section missing")
        .3;
    // Each entry is `.long`(4) + `.long`(4) + `.byte`(1) + `.byte`(1). The two
    // folded `.byte` differences (source length `773b-771b`, replacement
    // length `775f-774f`) are the first arm's 2 and the second arm's 5; a
    // last-definition binding would give 5 for both.
    assert_eq!(alti.len(), 20, "two 10-byte entries");
    assert_eq!((alti[8], alti[9]), (2, 2), "first arm lengths");
    assert_eq!((alti[18], alti[19]), (5, 5), "second arm lengths");
    // The two `.long 774f - .` cross-section references bind to distinct
    // replacement definitions, so their relocations name distinct symbols.
    let rela = &sections
        .iter()
        .find(|(n, _, _, _)| n == ".rela.alti")
        .expect(".rela.alti missing")
        .3;
    assert_eq!(rela.len(), 4 * 24, "four relocations");
    let sym_at = |field: u64| -> u32 {
        let e = (0..4)
            .map(|k| k * 24)
            .find(|&o| u64::from_le_bytes(rela[o..o + 8].try_into().unwrap()) == field)
            .expect("relocation at field offset");
        (u64::from_le_bytes(rela[e + 8..e + 16].try_into().unwrap()) >> 32) as u32
    };
    assert_ne!(sym_at(0x04), sym_at(0x0e), "774f binds per arm");
}

#[test]
fn asm_section_is_not_duplicated_by_branch_relaxation() {
    // A section-emitting inline asm in a function whose body is re-laid-out
    // for branch relaxation must contribute its section content once, not
    // once per relaxation pass. The section sink merges by name and is
    // restored before each re-emit; without that restore a second pass
    // appends a duplicate entry (a silent miscompile).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int loopy(int n) {\n\
            __asm__ volatile(\"1: nop\\n\"\n\
                \".pushsection .probe.tab,\\\"a\\\"\\n\"\n\
                \".long 1b - .\\n\"\n\
                \".popsection\\n\");\n\
            int s = 0;\n\
            for (int i = 0; i < n; i++) s += i * i - i;\n\
            return s;\n\
        }\n\
        int main(void) { return loopy(3); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".probe.tab")
            .unwrap_or_else(|| panic!("{target:?}: .probe.tab section missing"));
        // Exactly one `.long 1b - .`: 4 bytes, one relocation.
        assert_eq!(sec.3.len(), 4, "{target:?}: one entry, not duplicated");
        let reloc_count = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.probe.tab")
            .map_or(0, |r| r.3.len() / 24);
        assert_eq!(reloc_count, 1, "{target:?}: exactly one reloc");
    }
}

#[test]
fn asm_section_numeric_labels_are_per_instance_unique() {
    // GNU as numeric labels inside a section are local to one asm instance.
    // Two expansions of the same bug-table-shaped block must not collide:
    // each cross-section `.long 14472b - .` relocates to its own copy of the
    // string in `.bstr`, a distinct per-instance symbol. Without unique
    // identities the second `14472:` is a duplicate-label error, or both
    // entries point at one string (a silent miscompile).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let entry = |file: &str| {
        format!(
            "__asm__ volatile(\
                \".pushsection .btab,\\\"aw\\\"\\n\"\
                \"14470:\\t.long 14471f - .\\n\"\
                \".pushsection .bstr,\\\"a\\\"\\n\"\
                \"14472:\\t.string \\\"{file}\\\"\\n\"\
                \".popsection\\n\"\
                \".long 14472b - .\\n\"\
                \".popsection\\n\"\
                \"14471:\\tnop\\n\");"
        )
    };
    let src = format!(
        "void a(void) {{ {} }}\n\
         void b(void) {{ {} }}\n\
         int main(void) {{ a(); b(); return 0; }}\n",
        entry("aa"),
        entry("bb"),
    );
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(src.clone()).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = |n: &str| {
            sections
                .iter()
                .find(|(name, _, _, _)| name == n)
                .unwrap_or_else(|| panic!("{target:?}: {n} section missing"))
        };
        // Two 8-byte entries (a text ref and a string ref each).
        assert_eq!(sec(".btab").3.len(), 16, "{target:?}: two entries");
        // Both strings present, neither merged nor overwritten.
        assert_eq!(&sec(".bstr").3, b"aa\0bb\0", "{target:?}: both strings");
        let bstr_idx = sections
            .iter()
            .position(|(n, _, _, _)| n == ".bstr")
            .unwrap();
        let rela = sec(".rela.btab");
        assert_eq!(rela.3.len(), 4 * 24, "{target:?}: four relocs");
        let symtab = &sec(".symtab").3;
        // The two string references (field offsets 4 and 12) must resolve to
        // distinct symbols, both in `.bstr`, at the two string offsets.
        let mut str_syms = alloc::vec::Vec::new();
        for k in 0..4 {
            let r_off = u64::from_le_bytes(rela.3[k * 24..k * 24 + 8].try_into().unwrap());
            let r_info = u64::from_le_bytes(rela.3[k * 24 + 8..k * 24 + 16].try_into().unwrap());
            if r_off == 4 || r_off == 12 {
                let sym = (r_info >> 32) as usize;
                let shndx =
                    u16::from_le_bytes(symtab[sym * 24 + 6..sym * 24 + 8].try_into().unwrap());
                let value =
                    u64::from_le_bytes(symtab[sym * 24 + 8..sym * 24 + 16].try_into().unwrap());
                assert_eq!(shndx as usize, bstr_idx, "{target:?}: str ref into .bstr");
                str_syms.push((sym, value));
            }
        }
        assert_eq!(str_syms.len(), 2, "{target:?}: two string references");
        assert_ne!(
            str_syms[0].0, str_syms[1].0,
            "{target:?}: per-instance-distinct symbols"
        );
        let mut values = [str_syms[0].1, str_syms[1].1];
        values.sort_unstable();
        assert_eq!(values, [0, 3], "{target:?}: the two string offsets");
    }
}

#[test]
fn asm_section_org_pads_to_label_plus_operand() {
    // `.org 2b + %c0` (the `__bug_table` entry size) pads to a section-local
    // label's offset plus an `i`-class operand constant. Two instances of the
    // numeric label `2` stay independent. Byte-identical padding to gas.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let entry = "__asm__ volatile(\
        \"1:\\tnop\\n\"\
        \".pushsection .otab,\\\"aw\\\"\\n\"\
        \"2:\\t.long 1b - .\\n\"\
        \"\\t.word 11\\n\"\
        \"\\t.org 2b + %c0\\n\"\
        \".popsection\\n\" : : \"i\"(12));";
    let src = format!(
        "void a(void) {{ {entry} }}\n\
         void b(void) {{ {entry} }}\n\
         int main(void) {{ a(); b(); return 0; }}\n"
    );
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(src.clone()).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".otab")
            .unwrap_or_else(|| panic!("{target:?}: .otab missing"));
        // Two entries, each padded to `2b + 12` = 12 bytes.
        assert_eq!(sec.3.len(), 24, "{target:?}: two 12-byte entries");
        // The `.word 11` line field sits after the 4-byte text reference; the
        // rest of each entry is `.org` zero padding.
        let line0 = u16::from_le_bytes(sec.3[4..6].try_into().unwrap());
        let line1 = u16::from_le_bytes(sec.3[16..18].try_into().unwrap());
        assert_eq!((line0, line1), (11, 11), "{target:?}: line fields");
        assert!(
            sec.3[6..12].iter().all(|&b| b == 0),
            "{target:?}: entry A pad"
        );
        assert!(
            sec.3[18..24].iter().all(|&b| b == 0),
            "{target:?}: entry B pad"
        );
    }
}

#[test]
fn inline_asm_label_glued_section_directive_balances() {
    // A section directive may follow a label on the same line in the code
    // stream (`1:\t.pushsection ...`): GNU as treats the label and the
    // directive as two statements. The section-stack tracker must recognize
    // the directive after the label; otherwise the matching `.popsection`
    // underflows and is wrongly rejected as unbalanced.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
int f(int *p) {
    int r;
    __asm__ volatile("1:\t"
        ".pushsection .lktab,\"a\"\n"
        ".balign 4\n"
        ".long 9f - .\n"
        ".popsection\n"
        "9:\n\tmovl %1, %0\n"
        : "=r" (r) : "m" (*p));
    return r;
}
int main(void) { int x = 0; return f(&x); }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = |n: &str| {
        sections
            .iter()
            .find(|(s, _, _, _)| s == n)
            .unwrap_or_else(|| panic!("{n} missing"))
    };
    // One 4-byte entry, one PC-relative reference into `.text` (the `9:`
    // label), proving the pushed section closed and its `.long` relocated.
    assert_eq!(sec(".lktab").3.len(), 4);
    assert_eq!(sec(".rela.lktab").3.len(), 24);
}

#[test]
fn inline_asm_gas_macro_register_number_encodes() {
    // A GNU as `.macro` invoked with keyword arguments, using `.irp` to scan a
    // register-name list, `.ifc` to match the operand's register, a
    // self-referential `.set` counter, and `.if`/`.error` to reject a
    // no-match. The body emits one `.long type + (regnr << 8)`. Binding the
    // operand to `rbx` (register number 3) makes the value deterministic:
    // 0x11 + (3 << 8) = 0x311.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
int f(int x) {
    register int r asm("rbx") = x;
    __asm__ volatile(
        ".pushsection .rtab,\"a\"\n"
        ".macro enc_reg type:req reg:req\n"
        ".set found, 0\n"
        ".set n, 0\n"
        ".irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi\n"
        ".ifc \\reg, %%\\rs\n"
        ".set found, found+1\n"
        ".long \\type + (n << 8)\n"
        ".endif\n"
        ".set n, n+1\n"
        ".endr\n"
        ".if (found != 1)\n"
        ".error \"enc_reg: bad register\"\n"
        ".endif\n"
        ".endm\n"
        "enc_reg reg=%0, type=0x11\n"
        ".purgem enc_reg\n"
        ".popsection\n"
        : "+r" (r) : : "memory");
    return r;
}
int main(void) { return f(0); }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(s, _, _, _)| s == ".rtab")
        .expect(".rtab missing");
    assert_eq!(sec.3.len(), 4, "one .long entry");
    let v = u32::from_le_bytes(sec.3[0..4].try_into().unwrap());
    assert_eq!(v, 0x0000_0311, "type 0x11 with register number 3 (rbx)");
}

#[test]
fn inline_asm_parenthesized_goto_label_reloc() {
    // A section data reference may wrap a goto-label operand in one paren and
    // subtract the field's own position (`.long (%l[out]) - .`). The operand
    // relocation must be recognized through the paren; otherwise the value is
    // rejected as a bad section value.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
int f(int *p, int v) {
    __asm__ volatile goto("1:\tmovl %1, %0\n"
        ".pushsection .gtab,\"a\"\n"
        ".balign 4\n"
        ".long (1b) - .\n"
        ".long (%l[out]) - .\n"
        ".popsection\n"
        : "+m" (*p) : "r" (v) : : out);
    return 0;
out:
    return 1;
}
int main(void) { int x = 0; return f(&x, 1); }
"#;
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = |n: &str| {
        sections
            .iter()
            .find(|(s, _, _, _)| s == n)
            .unwrap_or_else(|| panic!("{n} missing"))
    };
    // Two 4-byte entries, each a PC-relative reference into `.text` (the `1:`
    // label and the `out` goto target).
    assert_eq!(sec(".gtab").3.len(), 8);
    assert_eq!(sec(".rela.gtab").3.len(), 2 * 24);
}

#[test]
fn asm_string_operand_data_is_emitted() {
    // A string-literal `i`-class operand is interned into the data buffer
    // while lexing the operand list, and the walk lowers its `Expr::StrLit`
    // to an `ImmData` at that offset. The bytes must survive into the object;
    // the operand parse used to truncate the buffer on the way out, leaving
    // the reference dangling past the image.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int probe(void) {\n\
            __asm__ volatile(\"\" : : \"i\"(\"asm_operand_marker\"));\n\
            return 0;\n\
        }\n\
        int main(void) { return probe(); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let emitted = sections
            .iter()
            .any(|(_, _, _, body)| body.windows(18).any(|w| w == b"asm_operand_marker"));
        assert!(emitted, "{target:?}: string operand data must be emitted");
    }
}

#[test]
fn asm_section_operand_symbol_relocates_to_data() {
    // `.long %c0 - .` where `%c0` is an `i`-class operand naming a link-time
    // address (a string literal, the bug table's file pointer) relocates
    // PC-relative to that data. The string must be emitted -- it is interned
    // while lexing the operand and referenced only by the section field. A
    // second field adds a constant operand to the base (`.quad %c1 + %c2 - .`,
    // the static-key jump entry). Byte-structure identical to gas.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int probe(void) {\n\
            __asm__ volatile(\n\
                \"1:\\tnop\\n\"\n\
                \".pushsection .optab,\\\"aw\\\"\\n\"\n\
                \".long %c0 - .\\n\"\n\
                \".quad %c0 + %c1 - .\\n\"\n\
                \".popsection\\n\" : : \"i\"(\"probe.c\"), \"i\"(4));\n\
            return 0;\n\
        }\n\
        int main(void) { return probe(); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".optab")
            .unwrap_or_else(|| panic!("{target:?}: .optab section missing"));
        // A 4-byte and an 8-byte PC-relative field.
        assert_eq!(sec.3.len(), 4 + 8, "{target:?}: section size");
        // The operand string is emitted so the field has a target to reach.
        let has_string = sections
            .iter()
            .any(|(_, _, _, body)| body.windows(7).any(|w| w == b"probe.c"));
        assert!(has_string, "{target:?}: operand string emitted");
        let rela = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.optab")
            .unwrap_or_else(|| panic!("{target:?}: .rela.optab missing"));
        assert_eq!(rela.3.len(), 2 * 24, "{target:?}: two relocs");
        let (prel32, prel64) = match target {
            Target::LinuxX64 => (2u64, 24u64),
            _ => (261, 260),
        };
        let r_info =
            |k: usize| u64::from_le_bytes(rela.3[k * 24 + 8..k * 24 + 16].try_into().unwrap());
        let r_addend =
            |k: usize| i64::from_le_bytes(rela.3[k * 24 + 16..k * 24 + 24].try_into().unwrap());
        assert_eq!(
            r_info(0) & 0xFFFF_FFFF,
            prel32,
            "{target:?}: `.long %c0 - .` pcrel32"
        );
        assert_eq!(
            r_info(1) & 0xFFFF_FFFF,
            prel64,
            "{target:?}: `.quad ... - .` pcrel64"
        );
        // The second field's operand addend (`+ %c1`, the constant 4) folds
        // into the relocation addend, atop the string's own data offset.
        assert_eq!(
            r_addend(1) - r_addend(0),
            4,
            "{target:?}: `+ %c1` addend folds in"
        );
    }
}

#[test]
fn asm_section_operand_extern_symbol_relocates_to_symbol() {
    // `.long %c0 - .` / `.quad %c0 + %c1 - .` where `%c0` is an `i`-class
    // operand naming a *cross-TU* address (`&extern_var`, a static key defined
    // in another unit) relocates against that symbol, not this unit's `.data`
    // image -- a `.data + off` relocation would name unrelated local bytes. A
    // constant offset folds into the addend, whether spelled `%c0 + %c1` or
    // folded into the operand (`&sym + n`). Byte-identical to gas: the
    // referenced symbol, PC-relative type by field width, and the addend.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        struct sk { int x; };\n\
        extern struct sk extkey;\n\
        int probe(void) {\n\
            __asm__ volatile(\n\
                \"1:\\tnop\\n\"\n\
                \".pushsection .optab,\\\"aw\\\"\\n\"\n\
                \".long %c0 - .\\n\"\n\
                \".quad %c0 + %c1 - .\\n\"\n\
                \".quad %c2 - .\\n\"\n\
                \".popsection\\n\" : : \"i\"(&extkey), \"i\"(4), \"i\"((char*)&extkey + 8));\n\
            return 0;\n\
        }\n\
        int main(void) { return probe(); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        // The cross-TU key surfaces as an undefined symbol; every field
        // relocates against it rather than a `.data` / `.bss` section symbol.
        let (shndx, _, _, _, extkey_idx) =
            elf_symbol(&bytes, "extkey").unwrap_or_else(|| panic!("{target:?}: extkey symbol"));
        assert_eq!(shndx, 0, "{target:?}: extkey is undefined (SHN_UNDEF)");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".optab")
            .unwrap_or_else(|| panic!("{target:?}: .optab section missing"));
        // A 4-byte and two 8-byte PC-relative fields.
        assert_eq!(sec.3.len(), 4 + 8 + 8, "{target:?}: section size");
        let rela = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.optab")
            .unwrap_or_else(|| panic!("{target:?}: .rela.optab missing"));
        assert_eq!(rela.3.len(), 3 * 24, "{target:?}: three relocs");
        let r_off = |k: usize| u64::from_le_bytes(rela.3[k * 24..k * 24 + 8].try_into().unwrap());
        let r_info =
            |k: usize| u64::from_le_bytes(rela.3[k * 24 + 8..k * 24 + 16].try_into().unwrap());
        let r_add =
            |k: usize| i64::from_le_bytes(rela.3[k * 24 + 16..k * 24 + 24].try_into().unwrap());
        let (prel32, prel64) = match target {
            Target::LinuxX64 => (2u64, 24u64),
            _ => (261, 260),
        };
        // (field offset, PC-relative reloc type, folded addend).
        for (off, rtype, addend) in [(0u64, prel32, 0i64), (4, prel64, 4), (12, prel64, 8)] {
            let k = (0..3)
                .find(|&k| r_off(k) == off)
                .unwrap_or_else(|| panic!("{target:?}: no reloc at field {off}"));
            assert_eq!(
                r_info(k) & 0xFFFF_FFFF,
                rtype,
                "{target:?}: field {off} PC-relative type"
            );
            assert_eq!(
                r_info(k) >> 32,
                extkey_idx as u64,
                "{target:?}: field {off} relocates against extkey, not .data"
            );
            assert_eq!(r_add(k), addend, "{target:?}: field {off} addend");
        }
    }
}

#[test]
fn asm_section_pcrel_extern_with_addend_relocates_like_gas() {
    // A static-call trampoline emits `jmp.d32 func` as section data:
    // `.byte 0xe9; .long func - (. + 4)`, `func` an external symbol. The
    // `.long` is a PC-relative relocation against `func` with the inner `+ 4`
    // folded into the addend, byte-identical to gas: R_X86_64_PC32 against
    // `func`, addend -4, at the field's own offset (past the 0xe9 opcode).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        extern void extfn(void);\n\
        int probe(void) {\n\
            __asm__ volatile(\n\
                \".pushsection .sctramp,\\\"ax\\\"\\n\"\n\
                \".globl mytramp\\n\"\n\
                \"mytramp:\\n\"\n\
                \".byte 0xe9\\n\"\n\
                \".long extfn - (. + 4)\\n\"\n\
                \".popsection\\n\");\n\
            return 0;\n\
        }\n\
        int main(void) { return probe(); }\n";
    let target = Target::LinuxX64;
    let program = Compiler::with_target(String::from(src), target)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, target, opts).expect("emit");
    // `extfn` surfaces as an undefined external symbol; the field relocates
    // against it, not this unit's `.text`.
    let (shndx, _, _, _, extfn_idx) = elf_symbol(&bytes, "extfn").expect("extfn symbol");
    assert_eq!(shndx, 0, "extfn is undefined (SHN_UNDEF)");
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(n, _, _, _)| n == ".sctramp")
        .expect(".sctramp section");
    assert_eq!(sec.3.len(), 1 + 4, "one opcode byte plus a 4-byte field");
    let rela = sections
        .iter()
        .find(|(n, _, _, _)| n == ".rela.sctramp")
        .expect(".rela.sctramp");
    assert_eq!(rela.3.len(), 24, "one reloc");
    let r_off = u64::from_le_bytes(rela.3[0..8].try_into().unwrap());
    let r_info = u64::from_le_bytes(rela.3[8..16].try_into().unwrap());
    let r_add = i64::from_le_bytes(rela.3[16..24].try_into().unwrap());
    assert_eq!(r_off, 1, "field follows the 0xe9 opcode byte");
    assert_eq!(r_info & 0xFFFF_FFFF, 2, "R_X86_64_PC32");
    assert_eq!(r_info >> 32, extfn_idx as u64, "relocates against extfn");
    assert_eq!(r_add, -4, "gas addend for `- (. + 4)`");
}

#[test]
fn asm_section_pcrel_label_minus_operand_const_relocates_like_gas() {
    // The user-pointer bound emits `.long 1b - %c2 - .` as section data: a
    // PC-relative relocation against the template text label `1b`, with the
    // operand constant `%c2` (`sizeof(long)`, 8) folded into the addend.
    // Contrast a plain `.long 1b - .`: the same PC-relative reloc against the
    // same text base, its addend lighter by 8 -- exactly as gas folds `- %c2`.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        unsigned long probe(void) {\n\
            unsigned long r;\n\
            __asm__ volatile(\n\
                \"mov %1, %0\\n\"\n\
                \"1:\\n\"\n\
                \".pushsection .uptr,\\\"a\\\"\\n\"\n\
                \".long 1b - .\\n\"\n\
                \".long 1b - %c2 - .\\n\"\n\
                \".popsection\\n\"\n\
                : \"=r\"(r) : \"i\"(0x0123456789abcdefULL), \"i\"(sizeof(long)));\n\
            return r;\n\
        }\n\
        int main(void) { return (int)probe(); }\n";
    let target = Target::LinuxX64;
    let program = Compiler::with_target(String::from(src), target)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, target, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(n, _, _, _)| n == ".uptr")
        .expect(".uptr section");
    assert_eq!(sec.3.len(), 4 + 4, "two 4-byte fields");
    let rela = sections
        .iter()
        .find(|(n, _, _, _)| n == ".rela.uptr")
        .expect(".rela.uptr");
    assert_eq!(rela.3.len(), 2 * 24, "two relocs");
    let r_off = |k: usize| u64::from_le_bytes(rela.3[k * 24..k * 24 + 8].try_into().unwrap());
    let r_info = |k: usize| u64::from_le_bytes(rela.3[k * 24 + 8..k * 24 + 16].try_into().unwrap());
    let r_add = |k: usize| i64::from_le_bytes(rela.3[k * 24 + 16..k * 24 + 24].try_into().unwrap());
    // Field 0 is `1b - .` (section offset 0); field 1 is `1b - %c2 - .` (4).
    let f0 = (0..2).find(|&k| r_off(k) == 0).expect("field at 0");
    let f1 = (0..2).find(|&k| r_off(k) == 4).expect("field at 4");
    // Both relocate PC-relative against the `.text` section symbol (`1b` is a
    // local text label), exactly as gas resolves a local-label difference.
    let text_sym = elf_section_symbol_index(&bytes, ".text").expect(".text section symbol");
    for k in [f0, f1] {
        assert_eq!(r_info(k) & 0xFFFF_FFFF, 2, "R_X86_64_PC32");
        assert_eq!(
            r_info(k) >> 32,
            text_sym as u64,
            "relocates against the .text section symbol"
        );
    }
    assert_eq!(
        r_add(f1) - r_add(f0),
        -8,
        "`- %c2` folds `sizeof(long)` into the addend"
    );
}

#[test]
fn asm_section_goto_label_relocates_to_block() {
    // `.long %l0 - .` (a static-key jump entry) relocates PC-relative to an
    // `asm goto` label's block. The block's text offset is not known when the
    // section materializes, so the reloc carries the block and is rewritten
    // after layout. The label ref lands in `.text`, alongside the template's
    // own `1b`, while the operand address (`%c0`) targets the data image.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        static int key;\n\
        int probe(void) {\n\
            __asm__ goto(\n\
                \"1:\\tnop\\n\"\n\
                \".pushsection .jtab,\\\"aw\\\"\\n\"\n\
                \".long 1b - ., %l[l_yes] - .\\n\"\n\
                \".quad %c0 - .\\n\"\n\
                \".popsection\\n\" : : \"i\"(&key) : : l_yes);\n\
            return 0;\n\
        l_yes:\n\
            return 1;\n\
        }\n\
        int main(void) { return probe(); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".jtab")
            .unwrap_or_else(|| panic!("{target:?}: .jtab section missing"));
        // `.long 1b - .`, `.long %l0 - .`, `.quad %c0 - .`.
        assert_eq!(sec.3.len(), 4 + 4 + 8, "{target:?}: section size");
        let rela = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.jtab")
            .unwrap_or_else(|| panic!("{target:?}: .rela.jtab missing"));
        assert_eq!(rela.3.len(), 3 * 24, "{target:?}: three relocs");
        let r_off = |k: usize| u64::from_le_bytes(rela.3[k * 24..k * 24 + 8].try_into().unwrap());
        let r_info =
            |k: usize| u64::from_le_bytes(rela.3[k * 24 + 8..k * 24 + 16].try_into().unwrap());
        // Offsets 0/4 are the two `.long`s; offset 8 is the `.quad`.
        let sym_at = |field: u64| -> u64 {
            (0..3)
                .find(|&k| r_off(k) == field)
                .map(|k| r_info(k) >> 32)
                .unwrap_or_else(|| panic!("{target:?}: no reloc at {field}"))
        };
        // Both the template label `1b` and the goto label `%l0` resolve into
        // `.text` -- the same section symbol; the operand address does not.
        assert_eq!(
            sym_at(0),
            sym_at(4),
            "{target:?}: `%l0` resolves into .text"
        );
        assert_ne!(
            sym_at(0),
            sym_at(8),
            "{target:?}: operand address is not in .text"
        );
        // No leftover TextBlock: every reloc names a defined symbol index.
        for k in 0..3 {
            assert_ne!(r_info(k) >> 32, 0, "{target:?}: reloc {k} has a symbol");
        }
    }
}

#[test]
fn aarch64_asm_replacement_branch_resolves_to_in_region_label() {
    // An ALTERNATIVE `.subsection` replacement whose branch targets a local
    // label defined inside the same out-of-line region. The displacement is
    // region-relative (target minus branch within the region), so it holds
    // wherever the region is placed: `b 1f` two words ahead encodes 0x14000002.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        void f(void) {
            __asm__ volatile(
                "661:\n\tnop\n\tnop\n\tnop\n662:\n"
                ".subsection 1\n"
                "663:\n\tb 1f\n\tnop\n1:\n\tnop\n664:\n\t"
                ".org . - (664b-663b) + (662b-661b)\n\t"
                ".org . - (662b-661b) + (664b-663b)\n\t"
                ".previous\n" : : : "memory");
        }
        int main(void) { f(); return 0; }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let text = elf_sections(&bytes)
        .into_iter()
        .find(|(n, ..)| n == ".text")
        .expect(".text missing")
        .3;
    let words: alloc::vec::Vec<u32> = text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // The region is `b 1f; nop; 1: nop`; the branch resolves to +2 words.
    assert!(
        words
            .windows(3)
            .any(|w| w[0] == 0x1400_0002 && w[1] == 0xd503_201f && w[2] == 0xd503_201f),
        "replacement branch not resolved to the in-region label: {words:08x?}"
    );
}

#[cfg(feature = "native-emit")]
#[test]
fn aarch64_asm_replacement_branch_to_symbol_relocates_out_of_line() {
    // An ALTERNATIVE `.subsection` replacement that branches to a symbol: the
    // out-of-line site takes a call relocation, exactly as a main-stream
    // template branch does.
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        extern void helper(void);
        long probe(long x) {
            __asm__ volatile(
                "661:\n\tnop\n662:\n"
                ".pushsection .altinstructions,\"a\"\n"
                " .word 661b - .\n .word 663f - .\n .hword 66\n"
                " .byte 662b-661b\n .byte 664f-663f\n"
                ".popsection\n"
                ".subsection 1\n"
                "663:\n\tbl helper\n664:\n\t.previous\n" : "+r"(x));
            return x;
        }
    "#;
    let program = Compiler::with_options(
        String::from(src),
        Target::LinuxAarch64,
        crate::CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let sites: alloc::vec::Vec<&crate::c5::linker::NativeReloc> = obj
        .text_relocs
        .iter()
        .filter(|r| obj.symbols[r.sym_idx].name == "helper")
        .collect();
    assert_eq!(sites.len(), 1, "expected one relocation against `helper`");
    assert_eq!(sites[0].rtype, 283, "R_AARCH64_CALL26 expected");
    let text = elf_sections(&bytes)
        .into_iter()
        .find(|(n, ..)| n == ".text")
        .expect(".text missing")
        .3;
    // The site holds the zero-displacement `bl` the linker patches, and it
    // sits past the function body rather than in the fall-through path.
    let off = sites[0].offset as usize;
    assert_eq!(
        u32::from_le_bytes(text[off..off + 4].try_into().unwrap()),
        0x9400_0000
    );
    let ret = text
        .chunks_exact(4)
        .position(|c| u32::from_le_bytes(c.try_into().unwrap()) == 0xd65f_03c0)
        .expect("ret present");
    assert!(off > ret * 4, "replacement branch is not out of line");
}

#[cfg(feature = "native-emit")]
#[test]
fn aarch64_clobbered_callee_saved_register_is_saved_around_the_block() {
    // The allocator places live values in the callee-saved GPRs, so a clobber
    // of one must be saved and restored around the block as a caller-saved
    // clobber is; otherwise the template destroys the value.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        long sink(long);
        long f(long a) {
            long v0 = sink(a + 1), v1 = sink(a + 2), v2 = sink(a + 3);
            long v3 = sink(a + 4), v4 = sink(a + 5), v5 = sink(a + 6);
            long v6 = sink(a + 7), v7 = sink(a + 8), v8 = sink(a + 9);
            __asm__ volatile("mov x20, #-1" ::: "x20", "memory");
            return v0 + v1 + v2 + v3 + v4 + v5 + v6 + v7 + v8;
        }
    "#;
    let program = Compiler::with_options(
        String::from(src),
        Target::LinuxAarch64,
        crate::CompileOptions::default()
            .with_no_entry_point(true)
            .with_optimize(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let text = elf_sections(&bytes)
        .into_iter()
        .find(|(n, ..)| n == ".text")
        .expect(".text missing")
        .3;
    let words: alloc::vec::Vec<u32> = text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    let template = words
        .iter()
        .position(|&w| w == 0x9280_0014)
        .expect("`mov x20, #-1` emitted");
    // `str x20, [sp, #imm]` before and `ldr x20, [sp, #imm]` after.
    let is_sp_x20 =
        |w: u32, load: bool| w & 0xFFC0_03FF == (if load { 0xF940_03F4 } else { 0xF900_03F4 });
    assert!(
        words[..template].iter().any(|&w| is_sp_x20(w, false)),
        "clobbered x20 not saved: {words:08x?}"
    );
    assert!(
        words[template..].iter().any(|&w| is_sp_x20(w, true)),
        "clobbered x20 not restored: {words:08x?}"
    );
}

#[cfg(feature = "native-emit")]
#[test]
fn aarch64_fixed_operand_outside_the_pool_is_saved_and_restored() {
    // A register-asm variable names its own register, which need not be in the
    // allocatable pool. The block saves and restores it like any other operand
    // register; only the emitter's scratch pair is off limits.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        long strip(long p) {
            register long v __asm__("x30") = p;
            __asm__("hint #7" : "+r"(v));
            return v;
        }
    "#;
    let program = Compiler::with_options(
        String::from(src),
        Target::LinuxAarch64,
        crate::CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let text = elf_sections(&bytes)
        .into_iter()
        .find(|(n, ..)| n == ".text")
        .expect(".text missing")
        .3;
    let words: alloc::vec::Vec<u32> = text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // x30 is stored to the operand frame before the template and reloaded
    // after it: `str x30, [sp, #imm]` / `ldr x30, [sp, #imm]` (0xf90*/0xf94*
    // with Rt = 30), around `hint #7` (xpaclri).
    let hint = words
        .iter()
        .position(|&w| w == 0xd503_20ff)
        .expect("hint #7 emitted");
    let is_sp_x30 =
        |w: u32, load: bool| w & 0xFFC0_03FF == (if load { 0xF940_03FE } else { 0xF900_03FE });
    assert!(
        words[..hint].iter().any(|&w| is_sp_x30(w, false)),
        "x30 not saved before the template: {words:08x?}"
    );
    assert!(
        words[hint..].iter().any(|&w| is_sp_x30(w, true)),
        "x30 not restored after the template: {words:08x?}"
    );
}

#[cfg(feature = "native-emit")]
#[test]
fn aarch64_file_scope_section_assembles_instructions() {
    // A file-scope `.pushsection .text,"ax"` block of register-concrete
    // instructions is assembled into the named section.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        __asm__(".pushsection .text.stub, \"ax\", @progbits\n"
                ".global stub\n"
                "stub:\n"
                "\tmov x10, x30\n"
                "\tmov x30, x9\n"
                "\tret x10\n"
                ".popsection\n");
        void f(void) {}
    "#;
    let program = Compiler::with_options(
        String::from(src),
        Target::LinuxAarch64,
        crate::CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let sec = elf_sections(&bytes)
        .into_iter()
        .find(|(n, ..)| n == ".text.stub")
        .expect(".text.stub missing")
        .3;
    let words: alloc::vec::Vec<u32> = sec
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // mov x10, x30 / mov x30, x9 / ret x10, as the reference assembler encodes
    // them (orr Xd, xzr, Xm; ret Xn).
    assert_eq!(&words[..3], &[0xaa1e_03ea, 0xaa09_03fe, 0xd65f_0140]);
}

#[test]
fn aarch64_asm_replacement_goto_branch_targets_label_block() {
    // A frameless `asm goto` whose ALTERNATIVE `.subsection` replacement
    // branches to a C label (`%l[...]`). The branch leaves the out-of-line
    // region for the label's block; with no operand frame to restore it
    // targets the block directly, as a plain out-of-line branch would.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"
        int f(void) {
            __asm__ goto(
                "661:\n\tnop\n662:\n"
                ".subsection 1\n"
                "663:\n\tb %l[l_yes]\n664:\n\t"
                ".org . - (664b-663b) + (662b-661b)\n\t"
                ".org . - (662b-661b) + (664b-663b)\n\t"
                ".previous\n" : : : : l_yes);
            return 0;
        l_yes:
            return 1;
        }
        int main(void) { return f(); }
    "#;
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let text = elf_sections(&bytes)
        .into_iter()
        .find(|(n, ..)| n == ".text")
        .expect(".text missing")
        .3;
    let words: alloc::vec::Vec<u32> = text
        .chunks_exact(4)
        .map(|c| u32::from_le_bytes(c.try_into().unwrap()))
        .collect();
    // `return 1;` lowers the l_yes block to `mov x0, #1`.
    let lyes = words
        .iter()
        .position(|&w| w == 0xd280_0020)
        .expect("l_yes block");
    // A `b` in `.text` -- the out-of-line replacement branch -- targets it.
    let targets_lyes = words.iter().enumerate().any(|(i, &w)| {
        (w & 0xfc00_0000) == 0x1400_0000 && {
            let off = ((w & 0x03ff_ffff) << 6) as i32 >> 6; // sign-extend imm26
            i as i64 + off as i64 == lyes as i64
        }
    });
    assert!(
        targets_lyes,
        "replacement `b %l[l_yes]` does not target the label block: {words:08x?}"
    );
}

#[test]
fn asm_goto_branch_and_section_field_name_one_address() {
    // The jump-label patching contract: a runtime patcher reads the label
    // address from the pushed section (`.long %l[l_yes] - .`) and rewrites the
    // template's own branch to it, so the two must already agree. Decode the
    // branch at the recorded `1b` and check it reaches the recorded label
    // address, as the patcher's own comparison does.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for (target, jump) in [(Target::LinuxX64, "jmp"), (Target::LinuxAarch64, "b")] {
        let src = alloc::format!(
            "static inline __attribute__((always_inline)) int probe(int b) {{\n\
                 __asm__ goto(\"1:\\t{jump} %l[l_yes]\\n\"\n\
                     \".pushsection .jt,\\\"aw\\\"\\n\"\n\
                     \".balign 8\\n\"\n\
                     \".long 1b - .\\n\"\n\
                     \".long %l[l_yes] - .\\n\"\n\
                     \".popsection\\n\" : : \"i\"(b) : : l_yes);\n\
                 return 0;\n\
             l_yes:\n\
                 return 1;\n\
             }}\n\
             int main(void) {{ return probe(1); }}\n"
        );
        let program = Compiler::with_target(src, target)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let text = &sections
            .iter()
            .find(|(n, _, _, _)| n == ".text")
            .expect(".text missing")
            .3;
        let rela = &sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.jt")
            .expect(".rela.jt missing")
            .3;
        assert_eq!(rela.len(), 2 * 24, "{target:?}: two `.long` relocs");
        // A `- .` field relocates PC-relative against the `.text` section
        // symbol, so its addend is the target's text offset.
        let addend =
            |k: usize| i64::from_le_bytes(rela[k * 24 + 16..k * 24 + 24].try_into().unwrap());
        let (code_off, label_off) = (addend(0) as usize, addend(1));
        let reached = if matches!(target, Target::LinuxAarch64) {
            let w = u32::from_le_bytes(text[code_off..code_off + 4].try_into().unwrap());
            assert_eq!(w & 0xfc00_0000, 0x1400_0000, "{target:?}: `1b` holds a `b`");
            let off = ((w & 0x03ff_ffff) << 6) as i32 >> 6;
            code_off as i64 + off as i64 * 4
        } else {
            assert_eq!(
                text[code_off], 0xE9,
                "{target:?}: `1b` holds the 5-byte jmp"
            );
            let rel = i32::from_le_bytes(text[code_off + 1..code_off + 5].try_into().unwrap());
            code_off as i64 + 5 + rel as i64
        };
        assert_eq!(
            reached, label_off,
            "{target:?}: the template branch and the section field name different addresses"
        );
    }
}

#[test]
fn x64_asm_m_operand_on_a_global_is_rip_relative() {
    // `call *%[op]` on a file-scope object encodes `FF 15 disp32` with a
    // PC-relative relocation, gcc's form and the one an indirect-call patcher
    // recognises. gcc's addend is the field's offset in the object less the
    // 4-byte end skew.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        struct ops { long pad; void (*fn)(void); };\n\
        extern struct ops o;\n\
        void probe(void) { __asm__ volatile(\"call *%[op]\" : : [op] \"m\"(o.fn) : \"memory\"); }\n\
        int main(void) { return 0; }\n";
    let program = Compiler::new(String::from(src)).compile().expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let text = &sections
        .iter()
        .find(|(n, _, _, _)| n == ".text")
        .expect(".text missing")
        .3;
    let at = text
        .windows(6)
        .position(|w| w[0] == 0xFF && w[1] == 0x15 && w[2..] == [0, 0, 0, 0])
        .expect("no `FF 15 disp32` indirect call");
    let rela = &sections
        .iter()
        .find(|(n, _, _, _)| n == ".rela.text")
        .expect(".rela.text missing")
        .3;
    let hit = (0..rela.len() / 24)
        .map(|k| {
            let f =
                |o: usize| u64::from_le_bytes(rela[k * 24 + o..k * 24 + o + 8].try_into().unwrap());
            (f(0), f(8) & 0xffff_ffff, f(16) as i64)
        })
        .find(|&(off, _, _)| off as usize == at + 2)
        .expect("no relocation on the call's disp32");
    const R_X86_64_PC32: u64 = 2;
    assert_eq!(hit.1, R_X86_64_PC32, "PC-relative relocation");
    assert_eq!(
        hit.2,
        8 - 4,
        "addend is the member offset less the end skew"
    );
}

#[test]
fn asm_goto_section_reloc_survives_branch_relaxation() {
    // An `asm goto` section field in a function that also relaxes a branch:
    // the section sink is restored before each re-emit, so the entry is not
    // duplicated, and the goto reloc is rewritten to the label block's FINAL
    // offset after layout. Exercises the restore + goto-resolve interaction.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int probe(int n) {\n\
            __asm__ goto(\"1:\\tnop\\n\"\n\
                \".pushsection .jt,\\\"aw\\\"\\n\"\n\
                \".long %l[y] - .\\n\"\n\
                \".popsection\\n\" : : : : y);\n\
            int s = 0;\n\
            for (int i = 0; i < n; i++) s += i * i - i;\n\
            return s;\n\
        y:\n\
            return 1;\n\
        }\n\
        int main(void) { return probe(3); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".jt")
            .unwrap_or_else(|| panic!("{target:?}: .jt section missing"));
        // One 4-byte field, not duplicated by the relaxation re-emit.
        assert_eq!(sec.3.len(), 4, "{target:?}: single entry");
        let rela = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.jt")
            .unwrap_or_else(|| panic!("{target:?}: .rela.jt missing"));
        // Exactly one relocation, resolved (a symbol index, not a TextBlock).
        assert_eq!(rela.3.len(), 24, "{target:?}: one reloc, not duplicated");
        let r_info = u64::from_le_bytes(rela.3[8..16].try_into().unwrap());
        assert_ne!(
            r_info >> 32,
            0,
            "{target:?}: goto reloc resolved to a symbol"
        );
    }
}

#[test]
fn asm_section_values_fold_constant_expressions() {
    // A named section's data value may be an integer constant expression,
    // not just a literal; the folded value is what lands in the section.
    // Byte-for-byte identical to gcc for the same template.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int probe(void) {\n\
            __asm__(\".pushsection .cexpr,\\\"a\\\"\\n\"\n\
                \".long (16*32+22)\\n\"\n\
                \".long (1<<3)|2\\n\"\n\
                \".long 7*2\\n\"\n\
                \".long 0xF0|0x0F\\n\"\n\
                \".word 3*8+1\\n\"\n\
                \".byte ~0 & 0xFF\\n\"\n\
                \".popsection\\n\"\n\
                \"nop\");\n\
            return 0;\n\
        }\n\
        int main(void) { return probe(); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".cexpr")
            .unwrap_or_else(|| panic!("{target:?}: .cexpr section missing"));
        // Four longs, one word, one byte. `.word` is 2 bytes on x86 ELF and
        // 4 on aarch64 (GNU as convention), so the section size and the byte's
        // offset follow the target's word width.
        let word_width = if matches!(target, Target::LinuxAarch64) {
            4
        } else {
            2
        };
        assert_eq!(
            sec.3.len(),
            4 * 4 + word_width + 1,
            "{target:?}: section size"
        );
        let long_at = |k: usize| u32::from_le_bytes(sec.3[k * 4..k * 4 + 4].try_into().unwrap());
        assert_eq!(long_at(0), 16 * 32 + 22, "{target:?}: (16*32+22)");
        assert_eq!(long_at(1), (1 << 3) | 2, "{target:?}: (1<<3)|2");
        assert_eq!(long_at(2), 7 * 2, "{target:?}: 7*2");
        assert_eq!(long_at(3), 0xF0 | 0x0F, "{target:?}: 0xF0|0x0F");
        let word = if word_width == 4 {
            u32::from_le_bytes(sec.3[16..20].try_into().unwrap()) as u64
        } else {
            u16::from_le_bytes(sec.3[16..18].try_into().unwrap()) as u64
        };
        assert_eq!(word, 3 * 8 + 1, "{target:?}: 3*8+1");
        assert_eq!(sec.3[16 + word_width], 0xFF, "{target:?}: ~0 & 0xFF");
    }
}

#[test]
fn asm_section_operand_expression_and_parenthesised_label() {
    // Two kernel section-value forms: an `i`-class operand folded into a
    // constant expression (`.hword (1 << 15) | (%0)`, the cpucap alternatives)
    // and a parenthesised label reference (`.long (1b) - .`, the exception
    // table). Byte-identical to gas: 0x8000 | 37 = 0x8025, followed by a
    // 4-byte PC-relative field. The `.hword` / `.long` widths are the same on
    // both targets, so the layout is too.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int probe(void) {\n\
            __asm__ volatile(\"1:\\tnop\\n\"\n\
                \".pushsection .cb,\\\"a\\\"\\n\"\n\
                \".hword (1 << 15) | (%0)\\n\"\n\
                \".long (1b) - .\\n\"\n\
                \".popsection\\n\" : : \"i\"(37));\n\
            return 0;\n\
        }\n\
        int main(void) { return 0; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".cb")
            .unwrap_or_else(|| panic!("{target:?}: .cb section missing"));
        // The folded operand expression, then the 4-byte label-reference field.
        assert_eq!(&sec.3[0..2], &[0x25, 0x80], "{target:?}: (1<<15)|37");
        assert_eq!(sec.3.len(), 2 + 4, "{target:?}: section size");
    }
}

#[test]
fn asm_section_double_parenthesised_label_relocates() {
    // The aarch64 exception table wraps the whole PC-relative expression in
    // an outer paren: `.long ((insn) - .)`. It must relocate exactly like the
    // single-paren form: a 4-byte PC-relative field per label, no folded
    // constant. Byte-structure identical to gas.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int load_ex(int *p) {\n\
            int r = 0;\n\
            __asm__ volatile(\"1:\\tnop\\n\"\n\
                \".pushsection .exx,\\\"a\\\"\\n\"\n\
                \".long ((1b) - .)\\n\"\n\
                \".long ((2f) - .)\\n\"\n\
                \".short 0\\n\"\n\
                \".popsection\\n\"\n\
                \"2:\\n\" : \"=r\"(r) : \"r\"(*p));\n\
            return r;\n\
        }\n\
        int main(void) { int v = 1; return load_ex(&v); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".exx")
            .unwrap_or_else(|| panic!("{target:?}: .exx section missing"));
        // Two 4-byte PC-relative fields plus a 2-byte word.
        assert_eq!(sec.3.len(), 4 + 4 + 2, "{target:?}: section size");
        let rela = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.exx")
            .unwrap_or_else(|| panic!("{target:?}: .rela.exx missing"));
        assert_eq!(rela.3.len(), 2 * 24, "{target:?}: two PC-relative relocs");
        let prel32 = match target {
            Target::LinuxX64 => 2u64,
            _ => 261,
        };
        for k in 0..2 {
            let r_info = u64::from_le_bytes(rela.3[k * 24 + 8..k * 24 + 16].try_into().unwrap());
            assert_eq!(
                r_info & 0xFFFF_FFFF,
                prel32,
                "{target:?}: reloc {k} pcrel32"
            );
        }
    }
}

#[test]
fn asm_section_label_difference_is_a_constant() {
    // `label_a - label_b` between two template labels is the constant byte
    // distance in the emitted code, sized to the directive. Byte-for-byte
    // identical to GNU as: the nop between the labels is 1 byte on x86-64 and
    // 4 bytes on aarch64, so the diffs are those constants; `.long 661b - .`
    // stays a PC-relative relocation and is the section's only reloc.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        void f(void) {\n\
            __asm__ volatile(\"661:\\n\\tnop\\n662:\\n\"\n\
                \".pushsection .altinstructions,\\\"a\\\"\\n\"\n\
                \".long 661b - .\\n\"\n\
                \".byte 662b - 661b\\n\"\n\
                \".short 662f - 661b\\n\"\n\
                \".popsection\\n\");\n\
        }\n\
        int main(void) { f(); return 0; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".altinstructions")
            .unwrap_or_else(|| panic!("{target:?}: .altinstructions missing"));
        // 4 (pcrel long) + 1 (byte diff) + 2 (short diff).
        assert_eq!(sec.3.len(), 7, "{target:?}: section size");
        let nop_len = match target {
            Target::LinuxX64 => 1u8,
            _ => 4,
        };
        assert_eq!(sec.3[4], nop_len, "{target:?}: .byte 662b - 661b");
        assert_eq!(
            u16::from_le_bytes(sec.3[5..7].try_into().unwrap()),
            u16::from(nop_len),
            "{target:?}: .short 662f - 661b"
        );
        // Only `.long 661b - .` relocates; both diffs are folded constants.
        let reloc_count = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.altinstructions")
            .map_or(0, |r| r.3.len() / 24);
        assert_eq!(reloc_count, 1, "{target:?}: exactly one reloc");
    }
}

#[test]
fn asm_section_local_label_difference_is_a_constant() {
    // A label difference between two labels defined inside the same section is
    // the constant byte distance there, not only for main-stream template
    // labels. Byte-for-byte identical to GNU as: `.byte sb - sa` is 3 (the
    // three data bytes between them), and `.long 1b - .` stays the section's
    // one PC-relative relocation. Target-independent -- the distance is section
    // data, not emitted code.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        void f(void) {\n\
            __asm__ volatile(\"1: nop\\n\"\n\
                \".pushsection .sldiff,\\\"a\\\"\\n\"\n\
                \"sa:\\n\"\n\
                \".byte 0x11, 0x22, 0x33\\n\"\n\
                \"sb:\\n\"\n\
                \".byte sb - sa\\n\"\n\
                \".long 1b - .\\n\"\n\
                \".popsection\\n\");\n\
        }\n\
        int main(void) { f(); return 0; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let sec = sections
            .iter()
            .find(|(n, _, _, _)| n == ".sldiff")
            .unwrap_or_else(|| panic!("{target:?}: .sldiff missing"));
        // 3 data bytes + 1 (sb - sa) + 4 (pcrel long).
        assert_eq!(sec.3.len(), 8, "{target:?}: section size");
        assert_eq!(&sec.3[..3], &[0x11, 0x22, 0x33], "{target:?}: data bytes");
        assert_eq!(
            sec.3[3], 3,
            "{target:?}: .byte sb - sa is the folded distance"
        );
        // Only `.long 1b - .` relocates; the section-local diff is a constant.
        let reloc_count = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.sldiff")
            .map_or(0, |r| r.3.len() / 24);
        assert_eq!(reloc_count, 1, "{target:?}: exactly one reloc");
    }
}

#[test]
fn x86_alternative_data_replacement_pads_and_relocates() {
    // The x86 ALTERNATIVE with a raw-byte replacement: `.skip` pads the old
    // site to the replacement length with `0x90` nops, the replacement bytes go
    // to `.altinstr_replacement`, and `.altinstructions` records the entry.
    // Byte-for-byte identical to GNU as: a 3-byte replacement (`clac`), an empty
    // old site padded to 3, and the entry's `.byte 773b-771b` / `.byte
    // 775f-774f` both folding to 3. Two PC-relative relocations aim the entry at
    // the old site and at the replacement. x86-only: `.skip` sizing against the
    // replacement length is an x86 main-stream directive.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        void clac(void) {\n\
            __asm__ volatile(\n\
                \"771:\\n772:\\n\"\n\
                \".skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90\\n\"\n\
                \"773:\\n\"\n\
                \".pushsection .altinstructions,\\\"a\\\"\\n\"\n\
                \" .long 771b - .\\n .long 774f - .\\n .4byte 7\\n\"\n\
                \" .byte 773b-771b\\n .byte 775f-774f\\n\"\n\
                \".popsection\\n\"\n\
                \".pushsection .altinstr_replacement, \\\"ax\\\"\\n\"\n\
                \"774:\\n .byte 0x0f,0x01,0xca\\n775:\\n\"\n\
                \".popsection\\n\" ::: \"memory\");\n\
        }\n\
        int main(void) { clac(); return 0; }\n";
    let program = Compiler::new(String::from(src)).compile().expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let body = |name: &str| {
        sections
            .iter()
            .find(|(n, _, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name} missing"))
            .3
            .clone()
    };
    let text = body(".text");
    // The `.skip` fill is `0x90`; three of them pad the empty old site.
    assert!(
        text.windows(3).any(|w| w == [0x90, 0x90, 0x90]),
        "old site padded with nops"
    );
    assert_eq!(body(".altinstr_replacement"), [0x0f, 0x01, 0xca]);
    // `.long 771b-.`(0) `.long 774f-.`(0) `.4byte 7` `.byte 773b-771b`(3)
    // `.byte 775f-774f`(3); the two 3s prove the padding and replacement length.
    assert_eq!(
        body(".altinstructions"),
        [0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 3, 3]
    );
    let reloc_count = sections
        .iter()
        .find(|(n, _, _, _)| n == ".rela.altinstructions")
        .map_or(0, |r| r.3.len() / 24);
    assert_eq!(reloc_count, 2, "PC32 to old site and to replacement");
}

#[test]
fn x86_alternative_call_replacement_encodes_and_relocates() {
    // The x86 ALTERNATIVE with a real-instruction replacement: a `call
    // %c[new]` naming a function goes to `.altinstr_replacement` as `E8` +
    // rel32, with a `R_X86_64_PLT32` branch relocation (addend -4) against the
    // callee -- byte-for-byte identical to GNU as. The empty old site is padded
    // to the 5-byte replacement length by `.skip`, and `.altinstructions`
    // records both lengths as 5. Contrast the data-only replacement above.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        extern void repfn(void);\n\
        void f(void) {\n\
            __asm__ volatile(\n\
                \"771:\\n772:\\n\"\n\
                \".skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90\\n\"\n\
                \"773:\\n\"\n\
                \".pushsection .altinstructions,\\\"a\\\"\\n\"\n\
                \" .long 771b - .\\n .long 774f - .\\n .4byte 7\\n\"\n\
                \" .byte 773b-771b\\n .byte 775f-774f\\n\"\n\
                \".popsection\\n\"\n\
                \".pushsection .altinstr_replacement, \\\"ax\\\"\\n\"\n\
                \"774:\\n call %c[new]\\n775:\\n\"\n\
                \".popsection\\n\" : : [new] \"i\" (repfn) : \"memory\");\n\
        }\n\
        int main(void) { f(); return 0; }\n";
    let program = Compiler::new(String::from(src)).compile().expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let body = |name: &str| {
        sections
            .iter()
            .find(|(n, _, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name} missing"))
            .3
            .clone()
    };
    // The replacement is `call rel32` with a zero displacement (the reloc fills
    // it): `E8 00 00 00 00`, identical to GNU as.
    assert_eq!(body(".altinstr_replacement"), [0xe8, 0, 0, 0, 0]);
    // `.long 771b-.`(0) `.long 774f-.`(0) `.4byte 7` `.byte 773b-771b`(5)
    // `.byte 775f-774f`(5): both lengths are the 5-byte call.
    assert_eq!(
        body(".altinstructions"),
        [0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 5, 5]
    );
    // The empty old site is padded to 5 with `0x90` nops.
    assert!(
        body(".text").windows(5).any(|w| w == [0x90; 5]),
        "old site padded to the replacement length"
    );
    // The single `.altinstr_replacement` relocation is `R_X86_64_PLT32` against
    // `repfn` at offset 1 (the rel32 field) with addend -4.
    let rela = body(".rela.altinstr_replacement");
    assert_eq!(rela.len(), 24, "one replacement relocation");
    let r_offset = u64::from_le_bytes(rela[0..8].try_into().unwrap());
    let r_info = u64::from_le_bytes(rela[8..16].try_into().unwrap());
    let r_addend = i64::from_le_bytes(rela[16..24].try_into().unwrap());
    assert_eq!(r_offset, 1, "reloc at the rel32 field");
    assert_eq!(r_info & 0xffff_ffff, 4, "R_X86_64_PLT32");
    assert_eq!(r_addend, -4, "branch addend");
    // The relocation names the callee `repfn`.
    let symtab = body(".symtab");
    let strtab = body(".strtab");
    let sym = (r_info >> 32) as usize;
    let name_off = u32::from_le_bytes(symtab[sym * 24..sym * 24 + 4].try_into().unwrap()) as usize;
    let name_end = strtab[name_off..].iter().position(|&b| b == 0).unwrap() + name_off;
    assert_eq!(
        String::from_utf8_lossy(&strtab[name_off..name_end]),
        "repfn"
    );
}

#[test]
fn x86_alternative_replacement_goto_branch_relocates_to_block() {
    // The x86 `_static_cpu_has` places a `jnz %l[t_yes]` / `jmp %l[t_no]` in an
    // executable ALTERNATIVE section. Each `asm goto` branch encodes to the
    // rel32 form (`0F 85` / `E9` with a zero displacement) and a `R_X86_64_PC32`
    // relocation to the label's caller block, deferred as `TextBlock` and
    // rewritten to the block's text offset after layout -- byte-for-byte the GNU
    // as cross-section branch. The same `.jtab` field (`.long %l - .`, the
    // known-good data path) targets the same blocks; a rel32 branch's addend is
    // the field's less 4 (the rel32 is measured from the byte after it).
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int probe(int n) {\n\
            __asm__ goto(\n\
                \".pushsection .altinstr_replacement, \\\"ax\\\"\\n\"\n\
                \"774:\\n jnz %l[t_yes]\\n jmp %l[t_no]\\n775:\\n\"\n\
                \".popsection\\n\"\n\
                \".pushsection .jtab,\\\"aw\\\"\\n\"\n\
                \".long %l[t_yes] - ., %l[t_no] - .\\n\"\n\
                \".popsection\\n\" : : : : t_yes, t_no);\n\
            return n;\n\
        t_yes:\n\
            return 0x11;\n\
        t_no:\n\
            return 0x22;\n\
        }\n\
        int main(void) { return probe(0); }\n";
    let program = Compiler::new(String::from(src)).compile().expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let body = |name: &str| {
        sections
            .iter()
            .find(|(n, _, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name} missing"))
            .3
            .clone()
    };
    // `jnz %l0` -> `0F 85` + rel32(0); `jmp %l1` -> `E9` + rel32(0). The reloc
    // fills each displacement -- identical to GNU as.
    assert_eq!(
        body(".altinstr_replacement"),
        [0x0f, 0x85, 0, 0, 0, 0, 0xe9, 0, 0, 0, 0]
    );
    const R_X86_64_PC32: u64 = 2;
    // Find the reloc at byte offset `off` in a `.rela.*` body; return
    // `(r_info, r_addend)`.
    let at = |rela: &[u8], off: u64| -> (u64, i64) {
        for b in rela.chunks_exact(24) {
            if u64::from_le_bytes(b[0..8].try_into().unwrap()) == off {
                return (
                    u64::from_le_bytes(b[8..16].try_into().unwrap()),
                    i64::from_le_bytes(b[16..24].try_into().unwrap()),
                );
            }
        }
        panic!("no reloc at offset {off}");
    };
    let code = body(".rela.altinstr_replacement");
    let data = body(".rela.jtab");
    // Two code branches: `jnz` rel32 at offset 2, `jmp` rel32 at offset 7.
    let (ci_yes, ca_yes) = at(&code, 2);
    let (ci_no, ca_no) = at(&code, 7);
    // Two data fields: `%l0` at offset 0, `%l1` at offset 4.
    let (di_yes, da_yes) = at(&data, 0);
    let (di_no, da_no) = at(&data, 4);
    assert_eq!(ci_yes & 0xffff_ffff, R_X86_64_PC32, "jnz field is PC32");
    assert_eq!(ci_no & 0xffff_ffff, R_X86_64_PC32, "jmp field is PC32");
    // Every field targets one symbol -- the `.text` section symbol the data
    // path already resolves to; the branch is a cross-section reference to it.
    assert_eq!(
        ci_yes >> 32,
        di_yes >> 32,
        "jnz targets .text like the field"
    );
    assert_eq!(ci_no >> 32, di_no >> 32, "jmp targets .text like the field");
    assert_eq!(di_yes >> 32, di_no >> 32, "both fields target .text");
    // The branch addend is the field's less 4: `jmp rel32` counts from the byte
    // after the displacement, `.long %l - .` from the field itself.
    assert_eq!(ca_yes + 4, da_yes, "jnz addend = t_yes block off - 4");
    assert_eq!(ca_no + 4, da_no, "jmp addend = t_no block off - 4");
    assert_ne!(da_yes, da_no, "the two labels are different blocks");
    // Each addend + 4 indexes the target block in `.text`: `t_yes` returns
    // 0x11, `t_no` returns 0x22 (`mov $imm32, %eax` = `B8 imm32`).
    let text = body(".text");
    let at_block = |a: i64| &text[(a + 4) as usize..(a + 4) as usize + 5];
    assert_eq!(
        at_block(ca_yes),
        [0xb8, 0x11, 0, 0, 0],
        "t_yes: mov $0x11,%eax"
    );
    assert_eq!(
        at_block(ca_no),
        [0xb8, 0x22, 0, 0, 0],
        "t_no: mov $0x22,%eax"
    );
}

#[test]
fn x86_static_cpu_has_memory_operand_replacement_encodes_and_relocates() {
    // The full `_static_cpu_has` shape: a permanent `.altinstr_aux` replacement
    // `testb %[bitnum], %a[cap_byte]` (a `%a` data memory operand) followed by
    // `jnz %l[t_yes]` / `jmp %l[t_no]`. The `%a[cap_byte]` operand names a
    // link-time address (`&cap[2]`) and lowers to a RIP-relative reference:
    // `F6 05` + a zero disp32 + the imm8, with a `R_X86_64_PC32` relocation at
    // the disp32 field against `cap` with addend `2 - 5` (the operand offset
    // less the PC-relative end skew and the trailing imm8) -- byte-for-byte
    // GNU as. The two goto branches encode as before.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        extern const char cap[64];\n\
        int probe(void) {\n\
            __asm__ goto(\n\
                \".pushsection .altinstr_aux,\\\"ax\\\"\\n\"\n\
                \"6:\\n testb %[bitnum], %a[cap_byte]\\n jnz %l[t_yes]\\n jmp %l[t_no]\\n\"\n\
                \".popsection\\n\"\n\
                : : [bitnum] \"i\" (2), [cap_byte] \"i\" (&cap[2]) : : t_yes, t_no);\n\
            return 0;\n\
        t_yes:\n\
            return 1;\n\
        t_no:\n\
            return 2;\n\
        }\n\
        int main(void) { return probe(); }\n";
    let program = Compiler::new(String::from(src)).compile().expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let body = |name: &str| {
        sections
            .iter()
            .find(|(n, _, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name} missing"))
            .3
            .clone()
    };
    // `testb $2, cap+2(%rip)` -> `F6 05` + disp32(0) + imm8(2); `jnz %l0` ->
    // `0F 85` + rel32(0); `jmp %l1` -> `E9` + rel32(0). Byte-for-byte GNU as.
    assert_eq!(
        body(".altinstr_aux"),
        [
            0xf6, 0x05, 0, 0, 0, 0, 0x02, // testb $2, cap+2(%rip)
            0x0f, 0x85, 0, 0, 0, 0, // jnz t_yes
            0xe9, 0, 0, 0, 0, // jmp t_no
        ]
    );
    const R_X86_64_PC32: u64 = 2;
    let rela = body(".rela.altinstr_aux");
    // The `testb` disp32 reloc: at byte offset 2, PC32 against `cap`, addend
    // `2 - 5 = -3` (GNU as: `cap - 3`).
    let at = |off: u64| -> (u64, i64) {
        for b in rela.chunks_exact(24) {
            if u64::from_le_bytes(b[0..8].try_into().unwrap()) == off {
                return (
                    u64::from_le_bytes(b[8..16].try_into().unwrap()),
                    i64::from_le_bytes(b[16..24].try_into().unwrap()),
                );
            }
        }
        panic!("no reloc at offset {off}");
    };
    let (info, addend) = at(2);
    assert_eq!(info & 0xffff_ffff, R_X86_64_PC32, "testb field is PC32");
    assert_eq!(
        addend, -3,
        "testb addend = cap offset (2) less the 5-byte skew"
    );
    // The relocation names `cap`.
    let symtab = body(".symtab");
    let strtab = body(".strtab");
    let sym = (info >> 32) as usize;
    let name_off = u32::from_le_bytes(symtab[sym * 24..sym * 24 + 4].try_into().unwrap()) as usize;
    let name_end = strtab[name_off..].iter().position(|&b| b == 0).unwrap() + name_off;
    assert_eq!(String::from_utf8_lossy(&strtab[name_off..name_end]), "cap");
}

#[test]
fn x86_alternative_register_and_memory_replacement_encodes() {
    // A replacement instruction whose operands are template register
    // references (`popcntl %1, %0`, both constraint-fixed registers) and one
    // with a register-indirect memory operand (`movb $0, (%rdi)`) encode
    // through the table with no relocation -- the paravirt / hweight class.
    // `popcntl %edi, %eax` = `F3 0F B8 C7`; `movb $0, (%rdi)` = `C6 07 00`,
    // byte-for-byte GNU as.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        unsigned hw(unsigned w) {\n\
            unsigned res;\n\
            __asm__ volatile(\n\
                \".pushsection .altinstr_replacement, \\\"ax\\\"\\n\"\n\
                \"popcntl %1, %0\\n\"\n\
                \".popsection\\n\" : \"=a\" (res) : \"D\" (w));\n\
            return res;\n\
        }\n\
        void unlock(void) {\n\
            __asm__ volatile(\n\
                \".pushsection .altinstr_replacement, \\\"ax\\\"\\n\"\n\
                \"movb $0, (%%rdi)\\n\"\n\
                \".popsection\\n\" : : : \"memory\");\n\
        }\n\
        int main(void) { unlock(); return (int)hw(0); }\n";
    let program = Compiler::new(String::from(src)).compile().expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let repl = sections
        .iter()
        .find(|(n, _, _, _)| n == ".altinstr_replacement")
        .expect(".altinstr_replacement missing")
        .3
        .clone();
    // Both replacements land in the merged section; order is emission order.
    assert!(
        repl.windows(4).any(|w| w == [0xf3, 0x0f, 0xb8, 0xc7]),
        "popcntl %edi, %eax = F3 0F B8 C7: {repl:02x?}"
    );
    assert!(
        repl.windows(3).any(|w| w == [0xc6, 0x07, 0x00]),
        "movb $0, (%rdi) = C6 07 00: {repl:02x?}"
    );
    // No data relocation: both are self-contained.
    assert!(
        !sections
            .iter()
            .any(|(n, _, _, _)| n == ".rela.altinstr_replacement"),
        "self-contained replacements carry no relocation"
    );
}

#[test]
fn x86_file_scope_asm_section_near_return_encodes() {
    // A file-scope basic `asm` that pushes a named executable section and emits
    // a near return assembles the `ret` to 0xC3, byte-for-byte GNU as. The
    // section-instruction encoder runs at file scope with an empty operand
    // context, so a self-contained instruction like `ret` still assembles.
    // `with_target` selects the x86-64 encoder for the compile-time check.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        __asm__(\".pushsection .text.f, \\\"ax\\\"\\n\"\n\
                \"ret\\n\"\n\
                \".popsection\\n\");\n\
        int main(void) { return 0; }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxX64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let sec = sections
        .iter()
        .find(|(n, _, _, _)| n == ".text.f")
        .expect(".text.f missing")
        .3
        .clone();
    assert!(sec.contains(&0xC3), "near return `ret` = C3: {sec:02x?}");
    assert_eq!(
        sec,
        alloc::vec![0xC3],
        "bare `ret` assembles to a single C3"
    );
}

#[test]
fn aarch64_alternative_subsection_defers_replacement_and_relocates() {
    // The AArch64 ALTERNATIVE places its replacement in a `.subsection`, which
    // GNU as appends to `.text` after the function body -- out of the main
    // sequence's fall-through path. badc encodes the replacement into a
    // deferred region emitted after the body; the `.altinstructions` entry's
    // `.word 663f - .` relocates against the replacement's final text offset,
    // `.word 661b - .` against the original, both R_AARCH64_PREL32 -- the same
    // construct GNU as emits. Equal `.byte` lengths make the `.org` a no-op.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        unsigned long f(void) {\n\
            unsigned long off;\n\
            __asm__(\n\
                \"661:\\n\\tmrs %0, tpidr_el1\\n662:\\n\"\n\
                \".pushsection .altinstructions,\\\"a\\\"\\n\"\n\
                \" .word 661b - .\\n .word 663f - .\\n .hword 0x0134\\n\"\n\
                \" .byte 662b-661b\\n .byte 664f-663f\\n\"\n\
                \".popsection\\n\"\n\
                \".subsection 1\\n663:\\n\\tmrs %0, tpidr_el2\\n664:\\n\"\n\
                \".org . - (664b-663b) + (662b-661b)\\n\"\n\
                \".org . - (662b-661b) + (664b-663b)\\n\"\n\
                \".previous\\n\" : \"=r\" (off));\n\
            return off;\n\
        }\n\
        int main(void) { return (int)f(); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let body = |name: &str| {
        sections
            .iter()
            .find(|(n, _, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name} missing"))
            .3
            .clone()
    };
    // The `.altinstructions` entry: word(661b-.) word(663f-.) hword(cpucap)
    // byte(old_len) byte(new_len). The two words are reloc placeholders (0);
    // cpucap 0x0134, both lengths the 4-byte instruction -- the GNU as bytes.
    let alt = body(".altinstructions");
    assert_eq!(alt.len(), 12);
    assert_eq!(&alt[0..8], &[0u8; 8], "two PREL32 placeholders");
    assert_eq!(&alt[8..12], &[0x34, 0x01, 4, 4], "cpucap 0x0134, old=new=4");
    // Two R_AARCH64_PREL32 relocations against `.text`: the field at offset 0
    // targets the original (661), the field at offset 4 the replacement (663).
    // The addends are the labels' text offsets; the replacement's is larger,
    // being appended after the body.
    const R_AARCH64_PREL32: u64 = 261;
    let rela = body(".rela.altinstructions");
    assert_eq!(rela.len(), 48, "two relocations");
    let entry = |i: usize| {
        let b = &rela[i * 24..i * 24 + 24];
        let off = u64::from_le_bytes(b[0..8].try_into().unwrap());
        let info = u64::from_le_bytes(b[8..16].try_into().unwrap());
        let add = i64::from_le_bytes(b[16..24].try_into().unwrap());
        (off, info & 0xffff_ffff, add)
    };
    let by_off = |want: u64| (0..2).map(entry).find(|e| e.0 == want).expect("reloc");
    let (_, t661, a661) = by_off(0);
    let (_, t663, a663) = by_off(4);
    assert_eq!(t661, R_AARCH64_PREL32, "661 field is PREL32");
    assert_eq!(t663, R_AARCH64_PREL32, "663 field is PREL32");
    assert!(a663 > a661, "replacement deferred after the original");
    // The text at each addend is the encoded instruction: `mrs Xn, tpidr_el1`
    // at the original, `mrs Xn, tpidr_el2` (the replacement) at 663, same Xn.
    let text = body(".text");
    let word = |o: i64| u32::from_le_bytes(text[o as usize..o as usize + 4].try_into().unwrap());
    let el1 = word(a661);
    let el2 = word(a663);
    assert_eq!(el1 & 0xffff_ffe0, 0xd538_d080, "mrs _, tpidr_el1");
    assert_eq!(el2 & 0xffff_ffe0, 0xd53c_d040, "mrs _, tpidr_el2");
    assert_eq!(el1 & 0x1f, el2 & 0x1f, "same destination register");
}

#[test]
fn aarch64_alternative_multi_instruction_replacement_defers_and_asserts_length() {
    // A multi-instruction ALTERNATIVE (an LL/SC original replaced by an LSE
    // sequence): the whole replacement defers after the body, the original's
    // local backward branch (`cbnz .., 1b`) resolves within the main sequence,
    // and the equal `.byte` lengths (five 4-byte instructions each) make the
    // `.org` a no-op. The `.altinstructions` records both lengths as 20.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        unsigned char f(unsigned char x, volatile void *ptr) {\n\
            unsigned char ret; unsigned long tmp;\n\
            __asm__ volatile(\n\
                \"661:\\n\\tprfm pstl1strm, %2\\n\"\n\
                \"1:\\tldxrb %w0, %2\\n\\tstlxrb %w1, %w3, %2\\n\\tcbnz %w1, 1b\\n\\tdmb ish\\n662:\\n\"\n\
                \".pushsection .altinstructions,\\\"a\\\"\\n .word 661b - .\\n .word 663f - .\\n\"\n\
                \" .hword 40\\n .byte 662b-661b\\n .byte 664f-663f\\n.popsection\\n\"\n\
                \".subsection 1\\n663:\\n\\tswpalb %w3, %w0, %2\\n\\tnop\\n\\tnop\\n\\tnop\\n\\tnop\\n664:\\n\"\n\
                \".org . - (664b-663b) + (662b-661b)\\n.org . - (662b-661b) + (664b-663b)\\n.previous\\n\"\n\
                : \"=&r\" (ret), \"=&r\" (tmp), \"+Q\" (*(unsigned char *)ptr) : \"r\" (x) : \"memory\");\n\
            return ret;\n\
        }\n\
        int main(void) { unsigned char c = 0; return f(1, &c); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let body = |name: &str| {
        sections
            .iter()
            .find(|(n, _, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name} missing"))
            .3
            .clone()
    };
    // Both lengths are the five-instruction, 20-byte sequences (0x14).
    let alt = body(".altinstructions");
    assert_eq!(
        &alt[8..12],
        &[0x28, 0x00, 0x14, 0x14],
        "cpucap 40, old=new=20"
    );
    let rela = body(".rela.altinstructions");
    let addend = |i: usize| i64::from_le_bytes(rela[i * 24 + 16..i * 24 + 24].try_into().unwrap());
    let (a661, a663) = (addend(0), addend(1));
    assert!(a663 > a661, "replacement deferred after the body");
    // The replacement's first instruction is `swpalb Ws, Wt, [Xn]` (LSE swap,
    // byte, acquire-release): bits [31:21] are 0b00111000111 == 0x1c7.
    let text = body(".text");
    let swp = u32::from_le_bytes(text[a663 as usize..a663 as usize + 4].try_into().unwrap());
    assert_eq!(swp >> 21, 0x1c7, "swpalb");
    // The four following slots are `nop` (0xd503201f).
    for k in 1..5 {
        let o = a663 as usize + k * 4;
        assert_eq!(
            u32::from_le_bytes(text[o..o + 4].try_into().unwrap()),
            0xd503_201f,
            "nop padding slot {k}"
        );
    }
}

#[test]
fn aarch64_alternative_rept_nop_padding_expands_to_repeated_instructions() {
    // An LSE ALTERNATIVE pads its replacement to the original length with
    // `.rept n\nnop\n.endr` (a repeated `nop`). The deferred region must expand
    // `.rept 3` to three `nop`s so the replacement (`swpb` + 3 nops) matches
    // the four-instruction LL/SC original, recording both lengths as 16 --
    // byte-identical to GNU as. A rejected or mis-counted `.rept` would leave
    // the replacement short and the length byte and `.org` wrong.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        unsigned char f(unsigned char x, volatile void *ptr) {\n\
            unsigned char ret; unsigned long tmp;\n\
            __asm__ volatile(\n\
                \"661:\\n\\tprfm pstl1strm, %2\\n\"\n\
                \"1:\\tldxrb %w0, %2\\n\\tstxrb %w1, %w3, %2\\n\\tcbnz %w1, 1b\\n662:\\n\"\n\
                \".pushsection .altinstructions,\\\"a\\\"\\n .word 661b - .\\n .word 663f - .\\n\"\n\
                \" .hword 37\\n .byte 662b-661b\\n .byte 664f-663f\\n.popsection\\n\"\n\
                \".subsection 1\\n663:\\n\\t.arch_extension lse\\n\\tswpb %w3, %w0, %2\\n\"\n\
                \".rept 3\\nnop\\n.endr\\n664:\\n\"\n\
                \".org . - (664b-663b) + (662b-661b)\\n.org . - (662b-661b) + (664b-663b)\\n.previous\\n\"\n\
                : \"=&r\" (ret), \"=&r\" (tmp), \"+Q\" (*(unsigned char *)ptr) : \"r\" (x) : \"memory\");\n\
            return ret;\n\
        }\n\
        int main(void) { unsigned char c = 0; return f(1, &c); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let sections = elf_sections(&bytes);
    let body = |name: &str| {
        sections
            .iter()
            .find(|(n, _, _, _)| n == name)
            .unwrap_or_else(|| panic!("{name} missing"))
            .3
            .clone()
    };
    // Both lengths are 16: the four-instruction original and `swpb` + 3 nops.
    let alt = body(".altinstructions");
    assert_eq!(
        &alt[8..12],
        &[0x25, 0x00, 0x10, 0x10],
        "cpucap 37, old=new=16"
    );
    // The replacement defers after the body; its first slot is `swpb` and the
    // three following slots are the `.rept 3` nops.
    let rela = body(".rela.altinstructions");
    let addend = |i: usize| i64::from_le_bytes(rela[i * 24 + 16..i * 24 + 24].try_into().unwrap());
    let (a661, a663) = (addend(0), addend(1));
    assert!(a663 > a661, "replacement deferred after the body");
    let text = body(".text");
    let word = |o: usize| u32::from_le_bytes(text[o..o + 4].try_into().unwrap());
    assert_eq!(word(a663 as usize) >> 21, 0x1c1, "swpb");
    for k in 1..4 {
        assert_eq!(
            word(a663 as usize + k * 4),
            0xd503_201f,
            "rept nop slot {k}"
        );
    }
}

#[test]
fn aarch64_alternative_rept_nonconstant_count_is_rejected() {
    // A `.rept` count is an assemble-time constant. A count naming a label
    // (unknown until layout) cannot be expanded here and is rejected rather
    // than mis-counted, which would leave the replacement the wrong length.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        unsigned long f(void) {\n\
            unsigned long off;\n\
            __asm__(\n\
                \"661:\\n\\tmrs %0, tpidr_el1\\n662:\\n\"\n\
                \".pushsection .altinstructions,\\\"a\\\"\\n .word 661b - .\\n .word 663f - .\\n .hword 1\\n .byte 662b-661b\\n .byte 664f-663f\\n.popsection\\n\"\n\
                \".subsection 1\\n663:\\n\\tmrs %0, tpidr_el2\\n\\t.rept 662b-661b\\nnop\\n.endr\\n664:\\n.org . - (664b-663b) + (662b-661b)\\n.org . - (662b-661b) + (664b-663b)\\n.previous\\n\"\n\
                : \"=r\" (off));\n\
            return off;\n\
        }\n\
        int main(void) { return (int)f(); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let err = emit_native_with_options(&program, Target::LinuxAarch64, opts).unwrap_err();
    assert!(
        alloc::format!("{err:?}").contains("not constant"),
        "{err:?}"
    );
}

#[test]
fn aarch64_alternative_length_mismatch_is_rejected() {
    // The ALTERNATIVE `.org` pair asserts the replacement and original are the
    // same length; GNU as fails with "attempt to move .org backwards" when
    // they differ. A replacement one instruction longer than the original is
    // rejected rather than emitted at the wrong length.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        unsigned long f(void) {\n\
            unsigned long off;\n\
            __asm__(\n\
                \"661:\\n\\tmrs %0, tpidr_el1\\n662:\\n\"\n\
                \".pushsection .altinstructions,\\\"a\\\"\\n .word 661b - .\\n .word 663f - .\\n .hword 1\\n .byte 662b-661b\\n .byte 664f-663f\\n.popsection\\n\"\n\
                \".subsection 1\\n663:\\n\\tmrs %0, tpidr_el2\\n\\tnop\\n664:\\n.org . - (664b-663b) + (662b-661b)\\n.org . - (662b-661b) + (664b-663b)\\n.previous\\n\"\n\
                : \"=r\" (off));\n\
            return off;\n\
        }\n\
        int main(void) { return (int)f(); }\n";
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let err = emit_native_with_options(&program, Target::LinuxAarch64, opts).unwrap_err();
    assert!(alloc::format!("{err:?}").contains("length"), "{err:?}");
}

#[test]
fn attribute_and_asm_pushsection_merge_into_one_section() {
    // An `__attribute__((section))` object and an inline-asm
    // `.pushsection` block naming the same section share one output
    // section: the attribute content first, the asm payload after it
    // at its `.balign`, and both sides' relocations in the single
    // `.rela` companion.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        int marker __attribute__((section(\".mix\"))) = 77;\n\
        int probe(void) {\n\
            __asm__(\"1: nop\\n\"\n\
                \".pushsection .mix,\\\"aw\\\"\\n\"\n\
                \".balign 8\\n\"\n\
                \".quad 1b\\n\"\n\
                \".quad marker\\n\"\n\
                \".popsection\\n\");\n\
            return 0;\n\
        }\n\
        int main(void) { return probe(); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let mix: alloc::vec::Vec<usize> = sections
            .iter()
            .enumerate()
            .filter(|(_, s)| s.0 == ".mix")
            .map(|(i, _)| i)
            .collect();
        assert_eq!(mix.len(), 1, "{target:?}: exactly one .mix section");
        let mix_i = mix[0];
        let sec = &sections[mix_i];
        assert_eq!(sec.1, 1, "{target:?}: SHT_PROGBITS");
        assert_eq!(sec.2, 0x3, "{target:?}: SHF_WRITE | SHF_ALLOC");
        // marker's 4 initialized bytes, padding to the asm block's
        // `.balign 8`, then the two 8-byte fields.
        assert_eq!(sec.3.len(), 24, "{target:?}: merged payload size");
        assert_eq!(
            &sec.3[0..4],
            &77u32.to_le_bytes(),
            "{target:?}: marker first"
        );
        let text_i = sections.iter().position(|s| s.0 == ".text").unwrap();
        let symtab = &sections.iter().find(|s| s.0 == ".symtab").unwrap().3;
        let sym_shndx = |sym: usize| {
            u16::from_le_bytes(symtab[sym * 24 + 6..sym * 24 + 8].try_into().unwrap()) as usize
        };
        let rela = &sections
            .iter()
            .find(|s| s.0 == ".rela.mix")
            .unwrap_or_else(|| panic!("{target:?}: .rela.mix missing"))
            .3;
        assert_eq!(rela.len(), 2 * 24, "{target:?}: two relocations");
        let field = |k: usize, o: usize| {
            u64::from_le_bytes(rela[k * 24 + o..k * 24 + o + 8].try_into().unwrap())
        };
        let abs64 = match target {
            Target::LinuxX64 => 1u64,
            _ => 257,
        };
        // `.quad 1b`: the asm label in probe's body, against `.text`.
        assert_eq!(field(0, 0), 8, "{target:?}: label reloc offset");
        assert_eq!(field(0, 8) & 0xFFFF_FFFF, abs64, "{target:?}: abs64 type");
        assert_eq!(
            sym_shndx((field(0, 8) >> 32) as usize),
            text_i,
            "{target:?}: label reloc binds to .text"
        );
        // `.quad marker`: the attribute object carved into `.mix`
        // itself, against the `.mix` section symbol at offset 0.
        assert_eq!(field(1, 0), 16, "{target:?}: marker reloc offset");
        assert_eq!(field(1, 8) & 0xFFFF_FFFF, abs64, "{target:?}: abs64 type");
        assert_eq!(
            sym_shndx((field(1, 8) >> 32) as usize),
            mix_i,
            "{target:?}: marker reloc binds to .mix"
        );
        assert_eq!(field(1, 16), 0, "{target:?}: marker sits at .mix offset 0");
        // `marker`'s own symbol lives in `.mix`.
        let strtab = &sections.iter().find(|s| s.0 == ".strtab").unwrap().3;
        let mut marker_shndx = None;
        for s in 0..symtab.len() / 24 {
            let noff = u32::from_le_bytes(symtab[s * 24..s * 24 + 4].try_into().unwrap()) as usize;
            let end = strtab[noff..].iter().position(|&b| b == 0).unwrap() + noff;
            if &strtab[noff..end] == b"marker" {
                marker_shndx = Some(sym_shndx(s));
            }
        }
        assert_eq!(
            marker_shndx,
            Some(mix_i),
            "{target:?}: marker symbol in .mix"
        );
    }
}

/// Compile a single TU to ET_REL and return the parsed object plus the
/// `.rela.text` entries whose symbol matches `name`.
fn relocs_against(
    src: &str,
    target: crate::c5::Target,
    name: &str,
) -> (
    crate::c5::linker::object::NativeObject,
    Vec<crate::c5::linker::object::NativeReloc>,
) {
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, emit_native_with_options};
    let program = Compiler::with_options(
        src.to_string(),
        target,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, target, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    let matched = obj
        .text_relocs
        .iter()
        .filter(|r| obj.symbols.get(r.sym_idx).is_some_and(|s| s.name == name))
        .copied()
        .collect();
    (obj, matched)
}

const EXTERN_DATA_SRC: &str = "\
    extern int ext_var;\n\
    int use_it(void) { ext_var = ext_var + 1; return ext_var; }\n\
    int *addr(void) { return &ext_var; }\n";

#[test]
fn extern_data_ref_is_relaxable_got_load_x86_64() {
    // Cross-TU data access must carry `R_X86_64_REX_GOTPCRELX` on a
    // `REX mov reg, [rip+disp32]` so a linker resolving the symbol in
    // the image relaxes the load to `lea` and a fully static link ends
    // with an empty GOT; plain `R_X86_64_GOTPCREL` is never relaxed.
    use crate::c5::Target;
    let (obj, relocs) = relocs_against(EXTERN_DATA_SRC, Target::LinuxX64, "ext_var");
    assert!(!relocs.is_empty(), "extern data refs must reloc `ext_var`");
    for r in &relocs {
        assert_eq!(
            r.rtype, 42,
            "extern data ref must be R_X86_64_REX_GOTPCRELX"
        );
        assert_eq!(r.addend, -4, "disp32 reloc uses the end-of-field addend");
        let off = r.offset as usize;
        assert!(off >= 3 && off + 4 <= obj.text.len());
        assert_eq!(
            obj.text[off - 3] & 0xf8,
            0x48,
            "the marked instruction must carry a REX prefix"
        );
        assert_eq!(
            obj.text[off - 2],
            0x8b,
            "the marked instruction must be the relaxable `mov` form"
        );
    }
}

#[test]
fn extern_data_ref_is_direct_pair_aarch64() {
    // Cross-TU data access to a non-weak symbol uses the direct
    // `adrp + add` pair (`ADR_PREL_PG_HI21` + `ADD_ABS_LO12_NC`): the
    // definition is guaranteed, so the pair resolves within any image
    // and keeps the GOT empty. The weak case takes the GOT pair below.
    use crate::c5::Target;
    let (obj, relocs) = relocs_against(EXTERN_DATA_SRC, Target::LinuxAarch64, "ext_var");
    assert!(!relocs.is_empty(), "extern data refs must reloc `ext_var`");
    for r in &relocs {
        assert!(
            r.rtype == 275 || r.rtype == 277,
            "extern data ref must be ADR_PREL_PG_HI21 / ADD_ABS_LO12_NC, got {}",
            r.rtype
        );
        if r.rtype == 277 {
            let off = r.offset as usize;
            let insn = u32::from_le_bytes(obj.text[off..off + 4].try_into().unwrap());
            assert_eq!(
                insn & 0xffc0_0000,
                0x9100_0000,
                "the lo12 site must be an `add`, not a GOT `ldr`"
            );
        }
    }
    assert!(relocs.iter().any(|r| r.rtype == 275));
    assert!(relocs.iter().any(|r| r.rtype == 277));
}

const WEAK_EXTERN_DATA_SRC: &str = "\
    extern __attribute__((weak)) int weak_var;\n\
    int *addr(void) { return &weak_var; }\n";

#[test]
fn weak_extern_data_ref_is_got_pair_aarch64() {
    // A weak symbol this unit does not define may resolve to zero, which
    // the page-relative pair cannot encode, so its address goes through
    // the GOT (`ADR_GOT_PAGE` + `LD64_GOT_LO12_NC`) and the lo12 site is
    // the `ldr`, not an `add`. Same forms gcc emits for the shape.
    use crate::c5::Target;
    let (obj, relocs) = relocs_against(WEAK_EXTERN_DATA_SRC, Target::LinuxAarch64, "weak_var");
    assert!(!relocs.is_empty(), "&weak_var must reloc `weak_var`");
    for r in &relocs {
        assert!(
            r.rtype == 311 || r.rtype == 312,
            "weak extern data ref must be ADR_GOT_PAGE / LD64_GOT_LO12_NC, got {}",
            r.rtype
        );
        if r.rtype == 312 {
            let off = r.offset as usize;
            let insn = u32::from_le_bytes(obj.text[off..off + 4].try_into().unwrap());
            assert_eq!(
                insn & 0xffc0_0000,
                0xf940_0000,
                "the lo12 site must be the GOT `ldr`, not an `add`"
            );
        }
    }
    assert!(relocs.iter().any(|r| r.rtype == 311));
    assert!(relocs.iter().any(|r| r.rtype == 312));
}

#[test]
fn import_address_keeps_got_pair_aarch64() {
    // Address-taking a dylib-routed import stays GOT-indirect: the
    // symbol binds against a shared object at load time, so a direct
    // pair would force a copy relocation / canonical PLT entry.
    use crate::c5::Target;
    let src = alloc::format!(
        "{TEST_PRELUDE}\
         typedef int (*cmp_t)(const char *, const char *);\n\
         cmp_t get(void) {{ return strcmp; }}\n"
    );
    let (_, relocs) = relocs_against(&src, Target::LinuxAarch64, "strcmp");
    assert!(!relocs.is_empty(), "&strcmp must reloc `strcmp`");
    for r in &relocs {
        assert!(
            r.rtype == 311 || r.rtype == 312,
            "import address-of must be ADR_GOT_PAGE / LD64_GOT_LO12_NC, got {}",
            r.rtype
        );
    }
}

#[test]
fn import_address_is_relaxable_got_load_x86_64() {
    // Same site on x86_64: the GOT load carries the relaxable marking,
    // so a static link of a defined `strcmp` relaxes to `lea` and a
    // dynamic link keeps the indirection.
    use crate::c5::Target;
    let src = alloc::format!(
        "{TEST_PRELUDE}\
         typedef int (*cmp_t)(const char *, const char *);\n\
         cmp_t get(void) {{ return strcmp; }}\n"
    );
    let (_, relocs) = relocs_against(&src, Target::LinuxX64, "strcmp");
    assert!(!relocs.is_empty(), "&strcmp must reloc `strcmp`");
    for r in &relocs {
        assert_eq!(
            r.rtype, 42,
            "import address-of must be R_X86_64_REX_GOTPCRELX"
        );
    }
}

#[test]
fn two_tu_extern_data_links_through_own_linker() {
    // Consumption side: badc's linker must resolve both the relaxable
    // x86_64 GOT load (rewritten back to `lea`) and the direct aarch64
    // pair against the defining unit.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let tu2 = "int ext_var = 20;\n\
               int main(void) { extern int use_it(void); return use_it(); }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let objs: Vec<_> = [EXTERN_DATA_SRC, tu2]
            .iter()
            .map(|src| {
                let program = Compiler::with_options(
                    src.to_string(),
                    target,
                    CompileOptions::default().with_no_entry_point(true),
                )
                .compile()
                .expect("compile");
                let opts = NativeOptions {
                    output_kind: OutputKind::Relocatable,
                    ..Default::default()
                };
                let bytes = emit_native_with_options(&program, target, opts).expect("emit");
                parse_native_elf(&bytes).expect("parse ET_REL")
            })
            .collect();
        let merged = link_native_objects(&objs).expect("link");
        assert!(
            merged.imports.is_empty(),
            "{target:?}: a two-TU link with every symbol defined must import nothing"
        );
    }
}

/// A single-TU final image has no link step, so an external reference
/// the codegen left as a zero-displacement placeholder must not reach
/// the output: a rip-relative `lea` with disp 0 materializes the
/// address of the next instruction, which reads as a non-null function
/// pointer and faults when called. An undefined weak reference
/// resolves to 0 instead (ELF STB_WEAK), so the `if (fn) fn();` guard
/// skips the call.
#[test]
fn undefined_weak_reference_in_single_tu_image_reads_as_null() {
    use crate::c5::{NativeOptions, Target, emit_native_with_options};
    const SRC: &str = "\
         extern void optional_hook(void) __attribute__((weak));\n\
         int main(void) {\n\
             if (optional_hook) { optional_hook(); return 1; }\n\
             return 0;\n\
         }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program =
            Compiler::with_options(SRC.to_string(), target, crate::CompileOptions::default())
                .compile()
                .expect("compile");
        let bytes =
            emit_native_with_options(&program, target, NativeOptions::default()).expect("emit");
        match target {
            Target::LinuxX64 => {
                assert!(
                    !bytes
                        .windows(7)
                        .any(|w| w == [0x48, 0x8D, 0x05, 0, 0, 0, 0]),
                    "{target:?}: `lea rax, [rip+0]` names an unresolved external"
                );
                assert!(
                    !bytes.windows(5).any(|w| w == [0xE8, 0, 0, 0, 0]),
                    "{target:?}: `call` with disp 0 names an unresolved external"
                );
            }
            _ => {
                // `adrp xd, #0` (0x90000000 | rd) and `bl #0` (0x94000000)
                // are the aarch64 unresolved-placeholder shapes.
                for word in bytes.chunks_exact(4) {
                    let w = u32::from_le_bytes(word.try_into().unwrap());
                    assert_ne!(w & 0xFFFF_FFE0, 0x9000_0000, "{target:?}: `adrp xd, #0`");
                    assert_ne!(w, 0x9400_0000, "{target:?}: `bl #0`");
                }
            }
        }
    }
}

/// The same path with a non-weak undefined reference is a diagnostic.
/// Emitting the placeholder silently produced a binary that faulted at
/// the call site with no build-time signal.
#[test]
fn undefined_strong_reference_in_single_tu_image_is_diagnosed() {
    use crate::c5::{NativeOptions, Target, emit_native_with_options};
    const SRC: &str = "extern void absent(void);\nint main(void) { absent(); return 0; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program =
            Compiler::with_options(SRC.to_string(), target, crate::CompileOptions::default())
                .compile()
                .expect("compile");
        let err = emit_native_with_options(&program, target, NativeOptions::default())
            .expect_err("an undefined reference in a final image must be diagnosed");
        assert!(
            format!("{err}").contains("undefined reference to `absent`"),
            "{target:?}: unexpected diagnostic: {err}"
        );
    }
}

/// A call to a function defined `__attribute__((weak))` in the same TU
/// must go through a relocation, not a baked local displacement, and
/// the linker must resolve that relocation against the strong sibling
/// definition rather than this unit's own copy (ELF STB_WEAK). Matches
/// gcc, which emits `R_X86_64_PLT32` for this shape.
#[test]
fn call_to_weak_definition_resolves_to_the_strong_sibling() {
    use crate::c5::linker::{link_native_objects, parse_native_elf};
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const WEAK_UNIT: &str = "\
         int pick(void) __attribute__((weak));\n\
         int pick(void) { return 1; }\n\
         int call_pick(void) { return pick(); }\n";
    const STRONG_UNIT: &str = "int pick(void) { return 2; }\n";
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let obj = |src: &str| {
            let program = Compiler::with_options(
                src.to_string(),
                target,
                crate::CompileOptions::default().with_no_entry_point(true),
            )
            .compile()
            .expect("compile");
            let opts = NativeOptions {
                output_kind: OutputKind::Relocatable,
                ..Default::default()
            };
            emit_native_with_options(&program, target, opts).expect("emit")
        };
        let weak_bytes = obj(WEAK_UNIT);
        let weak_obj = parse_native_elf(&weak_bytes).expect("parse ET_REL");
        let call_sites: Vec<u64> = weak_obj
            .text_relocs
            .iter()
            .filter(|r| weak_obj.symbols[r.sym_idx].name == "pick")
            .map(|r| r.offset)
            .collect();
        assert_eq!(
            call_sites.len(),
            1,
            "{target:?}: the call to a weak definition must be a relocation"
        );
        let strong_bytes = obj(STRONG_UNIT);
        let merged = link_native_objects(&[
            weak_obj,
            parse_native_elf(&strong_bytes).expect("parse ET_REL"),
        ])
        .expect("link");
        let pick = merged.defined.get("pick").expect("pick resolved");
        // The weak unit links first, so its text starts at 0 and the
        // reloc offset doubles as the merged-text offset.
        let target_off = match target {
            Target::LinuxX64 => {
                let site = call_sites[0] as usize;
                let rel = i32::from_le_bytes(merged.text[site..site + 4].try_into().unwrap());
                (site as i64 + 4 + rel as i64) as u64
            }
            _ => {
                let site = call_sites[0] as usize;
                let w = u32::from_le_bytes(merged.text[site..site + 4].try_into().unwrap());
                let imm26 = ((w & 0x03ff_ffff) << 6) as i32 >> 6;
                (site as i64 + (imm26 as i64) * 4) as u64
            }
        };
        assert_eq!(
            target_off, pick.value,
            "{target:?}: the call must branch to the winning definition"
        );
        assert!(
            pick.value as usize >= merged_weak_text_len(&weak_bytes),
            "{target:?}: the strong definition must win over the weak one"
        );
    }
}

/// `.text` length of an ET_REL object, used to tell which unit a merged
/// symbol landed in.
#[cfg(feature = "full")]
fn merged_weak_text_len(bytes: &[u8]) -> usize {
    crate::c5::linker::parse_native_elf(bytes)
        .expect("parse ET_REL")
        .text
        .len()
}

/// An inline-asm `call` / `bl` naming a symbol this unit does not
/// define must become a call relocation against that name -- the same
/// treatment a compiler-emitted call to an extern function gets --
/// rather than being rejected for having no local target. The symbol
/// need not be declared in C: a template can name a pure-asm symbol.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_branch_to_undefined_symbol_emits_a_call_relocation() {
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let branch = if target == Target::LinuxX64 {
            "call"
        } else {
            "bl"
        };
        // R_X86_64_PLT32 / R_AARCH64_CALL26.
        let want_rtype = if target == Target::LinuxX64 { 4 } else { 283 };
        // Both an `extern`-declared callee and one with no C
        // declaration at all reach the same relocation.
        for src in [
            format!(
                "extern void helper(void);\n\
                 void f(void) {{ __asm__ __volatile__(\"{branch} helper\" ::: \"memory\"); }}\n"
            ),
            format!(
                "void f(void) {{ __asm__ __volatile__(\"{branch} helper\" ::: \"memory\"); }}\n"
            ),
        ] {
            let program = Compiler::with_options(
                src.clone(),
                target,
                crate::CompileOptions::default().with_no_entry_point(true),
            )
            .compile()
            .expect("compile");
            let opts = NativeOptions {
                output_kind: OutputKind::Relocatable,
                ..Default::default()
            };
            let bytes = emit_native_with_options(&program, target, opts).expect("emit");
            let obj = parse_native_elf(&bytes).expect("parse ET_REL");
            let sites: Vec<&crate::c5::linker::NativeReloc> = obj
                .text_relocs
                .iter()
                .filter(|r| obj.symbols[r.sym_idx].name == "helper")
                .collect();
            assert_eq!(
                sites.len(),
                1,
                "{target:?}: expected one call relocation against `helper` for {src:?}, \
                 got {:?}",
                obj.text_relocs
                    .iter()
                    .map(|r| (&obj.symbols[r.sym_idx].name, r.rtype))
                    .collect::<Vec<_>>()
            );
            assert_eq!(
                sites[0].rtype, want_rtype,
                "{target:?}: wrong relocation type for an inline-asm branch"
            );
        }
    }
}

/// The same inline-asm branch in a single-TU final image has no link
/// step to bind it, so an undefined non-weak target is a diagnostic
/// rather than a placeholder that faults at run time.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_branch_to_undefined_symbol_in_final_image_is_diagnosed() {
    use crate::c5::{NativeOptions, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let branch = if target == Target::LinuxX64 {
            "call"
        } else {
            "bl"
        };
        let src = format!(
            "int main(void) {{ __asm__ __volatile__(\"{branch} helper\" ::: \"memory\"); \
             return 0; }}\n"
        );
        let program = Compiler::with_options(src, target, crate::CompileOptions::default())
            .compile()
            .expect("compile");
        let err = emit_native_with_options(&program, target, NativeOptions::default())
            .expect_err("an undefined inline-asm branch target must be diagnosed");
        assert!(
            format!("{err}").contains("undefined reference to `helper`"),
            "{target:?}: unexpected diagnostic: {err}"
        );
    }
}

/// An inline-asm branch whose target IS defined in the unit keeps
/// resolving locally, with no relocation emitted for it.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_branch_to_local_definition_stays_local() {
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let branch = if target == Target::LinuxX64 {
            "call"
        } else {
            "bl"
        };
        let src = format!(
            "void helper(void) {{}}\n\
             void f(void) {{ __asm__ __volatile__(\"{branch} helper\" ::: \"memory\"); }}\n"
        );
        let program = Compiler::with_options(
            src,
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        assert!(
            !obj.text_relocs
                .iter()
                .any(|r| obj.symbols[r.sym_idx].name == "helper"),
            "{target:?}: a locally-defined branch target must not go through a relocation"
        );
    }
}

/// A branch target assembled from template text plus a `%c` operand
/// names the symbol the substituted text spells: `__get_user_%c0` with
/// a constant 4 relocates against `__get_user_4`. Resolution therefore
/// happens after substitution, not at template-parse time.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_branch_target_substitutes_a_constant_operand() {
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let branch = if target == Target::LinuxX64 {
            "call"
        } else {
            "bl"
        };
        // R_X86_64_PLT32 / R_AARCH64_CALL26.
        let want_rtype = if target == Target::LinuxX64 { 4 } else { 283 };
        // Adjacent string literals joined before parsing, a named
        // operand, and a positional `%cN` all reach the same symbol.
        for body in [
            format!("\"{branch} __\" \"get_user\" \"_%c[size]\" :: [size] \"i\"(4)"),
            format!("\"{branch} __get_user_%c[size]\" :: [size] \"i\"(4)"),
            format!("\"{branch} __get_user_%c0\" :: \"i\"(4)"),
        ] {
            let src = format!("void f(void) {{ __asm__ __volatile__({body} : \"memory\"); }}\n");
            let program = Compiler::with_options(
                src.clone(),
                target,
                crate::CompileOptions::default().with_no_entry_point(true),
            )
            .compile()
            .expect("compile");
            let opts = NativeOptions {
                output_kind: OutputKind::Relocatable,
                ..Default::default()
            };
            let bytes = emit_native_with_options(&program, target, opts).expect("emit");
            let obj = parse_native_elf(&bytes).expect("parse ET_REL");
            let sites: Vec<&crate::c5::linker::NativeReloc> = obj
                .text_relocs
                .iter()
                .filter(|r| obj.symbols[r.sym_idx].name == "__get_user_4")
                .collect();
            assert_eq!(
                sites.len(),
                1,
                "{target:?}: expected one relocation against `__get_user_4` for {src:?}, got {:?}",
                obj.text_relocs
                    .iter()
                    .map(|r| (&obj.symbols[r.sym_idx].name, r.rtype))
                    .collect::<Vec<_>>()
            );
            assert_eq!(
                sites[0].rtype, want_rtype,
                "{target:?}: wrong relocation type for a substituted branch target"
            );
        }
    }
}

/// Substitution is positional text, so a reference may sit anywhere in
/// the name, and several may appear in one target.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_branch_target_substitutes_every_reference_position() {
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let branch = if target == Target::LinuxX64 {
            "call"
        } else {
            "bl"
        };
        let src = format!(
            "void f(void) {{ __asm__ __volatile__(\"{branch} pre_%c0_mid_%c1_end\" \
             :: \"i\"(3), \"i\"(7) : \"memory\"); }}\n"
        );
        let program = Compiler::with_options(
            src,
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        assert!(
            obj.text_relocs
                .iter()
                .any(|r| obj.symbols[r.sym_idx].name == "pre_3_mid_7_end"),
            "{target:?}: expected a relocation against `pre_3_mid_7_end`, got {:?}",
            obj.text_relocs
                .iter()
                .map(|r| &obj.symbols[r.sym_idx].name)
                .collect::<Vec<_>>()
        );
    }
}

/// A substituted target that the unit DOES define resolves locally, so
/// the substituted name -- not the template text -- is what the local
/// lookup sees.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_substituted_branch_target_resolves_a_local_definition() {
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let branch = if target == Target::LinuxX64 {
            "call"
        } else {
            "bl"
        };
        let src = format!(
            "void helper_4(void) {{}}\n\
             void f(void) {{ __asm__ __volatile__(\"{branch} helper_%c0\" \
             :: \"i\"(4) : \"memory\"); }}\n"
        );
        let program = Compiler::with_options(
            src,
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let obj = parse_native_elf(&bytes).expect("parse ET_REL");
        assert!(
            !obj.text_relocs
                .iter()
                .any(|r| obj.symbols[r.sym_idx].name == "helper_4"),
            "{target:?}: a locally-defined substituted target must not go through a relocation"
        );
    }
}

/// An operand reference only spells part of a symbol name when it
/// prints bare. x86 prints an unmodified `%N` as `$N`, which cannot,
/// so it is diagnosed; AArch64 prints it bare and accepts it. Both
/// follow what gcc and clang emit for the same template.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_branch_target_requires_a_bare_operand_reference() {
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for (target, branch, modifier, accepted) in [
        (Target::LinuxX64, "call", "c", true),
        (Target::LinuxX64, "call", "P", true),
        (Target::LinuxX64, "call", "", false),
        (Target::LinuxAarch64, "bl", "c", true),
        (Target::LinuxAarch64, "bl", "", true),
        (Target::LinuxAarch64, "bl", "P", false),
    ] {
        let src = format!(
            "void f(void) {{ __asm__ __volatile__(\"{branch} __get_user_%{modifier}0\" \
             :: \"i\"(4) : \"memory\"); }}\n"
        );
        let program = Compiler::with_options(
            src,
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let got = emit_native_with_options(&program, target, opts);
        assert_eq!(
            got.is_ok(),
            accepted,
            "{target:?}: `%{modifier}` in a branch target: {:?}",
            got.err().map(|e| format!("{e}"))
        );
        if !accepted {
            let err = format!("{}", got.err().unwrap());
            assert!(
                err.contains("does not print a bare symbol name"),
                "{target:?}: unexpected diagnostic: {err}"
            );
        }
    }
}

/// A branch target whose operand is not a compile-time constant cannot
/// name a symbol, so it is diagnosed rather than relocated against a
/// malformed name.
#[cfg(feature = "native-emit")]
#[test]
fn inline_asm_branch_target_with_a_non_constant_operand_is_diagnosed() {
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let branch = if target == Target::LinuxX64 {
            "call"
        } else {
            "bl"
        };
        let src = format!(
            "void f(int n) {{ __asm__ __volatile__(\"{branch} __get_user_%c0\" \
             :: \"i\"(n) : \"memory\"); }}\n"
        );
        let program = Compiler::with_options(
            src,
            target,
            crate::CompileOptions::default().with_no_entry_point(true),
        )
        .compile()
        .expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let err = emit_native_with_options(&program, target, opts)
            .expect_err("a non-constant branch-target operand must be diagnosed");
        assert!(
            format!("{err}").contains("needs a constant operand"),
            "{target:?}: unexpected diagnostic: {err}"
        );
    }
}

/// Symbol table lookup: `(st_shndx, st_value, binding, type, index)` of the
/// named symbol in an ELF object's `.symtab`.
fn elf_symbol(bytes: &[u8], name: &str) -> Option<(u16, u64, u8, u8, usize)> {
    let sections = elf_sections(bytes);
    let symtab = &sections.iter().find(|(n, _, _, _)| n == ".symtab")?.3;
    let strtab = &sections.iter().find(|(n, _, _, _)| n == ".strtab")?.3;
    for i in 0..symtab.len() / 24 {
        let s = &symtab[i * 24..i * 24 + 24];
        let st_name = u32::from_le_bytes(s[0..4].try_into().unwrap()) as usize;
        let end = strtab[st_name..].iter().position(|&b| b == 0)? + st_name;
        if &strtab[st_name..end] == name.as_bytes() {
            let st_info = s[4];
            return Some((
                u16::from_le_bytes(s[6..8].try_into().unwrap()),
                u64::from_le_bytes(s[8..16].try_into().unwrap()),
                st_info >> 4,
                st_info & 0xF,
                i,
            ));
        }
    }
    None
}

/// Index of the STT_SECTION symbol whose `st_shndx` is the section named
/// `name` -- the symbol a local (section-relative) relocation resolves against.
fn elf_section_symbol_index(bytes: &[u8], name: &str) -> Option<usize> {
    let sections = elf_sections(bytes);
    let shndx = sections.iter().position(|(n, _, _, _)| n == name)? as u16;
    let symtab = &sections.iter().find(|(n, _, _, _)| n == ".symtab")?.3;
    (0..symtab.len() / 24).find(|&i| {
        let s = &symtab[i * 24..i * 24 + 24];
        s[4] & 0xF == 3 // STT_SECTION
            && u16::from_le_bytes(s[6..8].try_into().unwrap()) == shndx
    })
}

#[test]
fn inline_asm_section_label_defines_a_symbol() {
    // A label written inside a file-scope `asm()` named section defines a
    // symbol in that section at its offset within it, matching GNU as:
    // undecorated labels bind locally, `.globl` promotes to external.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"int foo = 7;
asm(".section \".export_symbol\",\"a\"\n"
    "__export_symbol_foo:\n"
    "\t.asciz \"GPL\"\n"
    "\t.balign 8\n"
    "\t.quad foo\n"
    ".globl __export_global\n"
    "__export_global:\n"
    "\t.quad 0\n"
    ".previous\n");
int main(void) { return 0; }
"#;
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        // The quoted section name is unquoted, as GNU as spells it.
        let idx = sections
            .iter()
            .position(|(n, _, _, _)| n == ".export_symbol")
            .unwrap_or_else(|| panic!("{target:?}: .export_symbol section missing"));
        let sec = &sections[idx];
        assert_eq!(sec.1, 1, "{target:?}: SHT_PROGBITS expected");
        assert_eq!(sec.2 & 0x2, 0x2, "{target:?}: SHF_ALLOC expected");
        // "GPL\0" padded to 8, the quad symbol ref, then the second quad.
        assert_eq!(sec.3.len(), 24, "{target:?}: section size");

        let (shndx, value, bind, ty, local_i) = elf_symbol(&bytes, "__export_symbol_foo")
            .unwrap_or_else(|| panic!("{target:?}: label symbol missing"));
        assert_eq!(shndx as usize, idx, "{target:?}: label section index");
        assert_eq!(value, 0, "{target:?}: label offset within the section");
        assert_eq!(bind, 0, "{target:?}: undecorated label binds locally");
        assert_eq!(ty, 0, "{target:?}: STT_NOTYPE expected");

        let (g_shndx, g_value, g_bind, _, global_i) = elf_symbol(&bytes, "__export_global")
            .unwrap_or_else(|| panic!("{target:?}: .globl label symbol missing"));
        assert_eq!(
            g_shndx as usize, idx,
            "{target:?}: .globl label section index"
        );
        assert_eq!(g_value, 16, "{target:?}: .globl label offset");
        assert_eq!(g_bind, 1, "{target:?}: `.globl` binds externally");
        // ELF requires every LOCAL symbol to precede every GLOBAL one.
        assert!(
            local_i < global_i,
            "{target:?}: local label must precede the global one"
        );
    }
}

#[test]
fn inline_asm_section_label_is_relocation_target() {
    // A data reference to a label defined in the same named section
    // resolves to that label's symbol, not to an undefined import.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = r#"asm(".section \".tbl\",\"a\"\n"
    "\t.quad 0\n"
    "anchor:\n"
    "\t.quad anchor\n"
    ".previous\n");
int main(void) { return 0; }
"#;
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let idx = sections
            .iter()
            .position(|(n, _, _, _)| n == ".tbl")
            .unwrap_or_else(|| panic!("{target:?}: .tbl section missing"));
        let (shndx, value, _, _, sym_i) = elf_symbol(&bytes, "anchor")
            .unwrap_or_else(|| panic!("{target:?}: anchor symbol missing"));
        assert_eq!(shndx as usize, idx, "{target:?}: anchor section index");
        assert_eq!(value, 8, "{target:?}: anchor offset");
        let rela = sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.tbl")
            .unwrap_or_else(|| panic!("{target:?}: .rela.tbl missing"));
        assert_eq!(rela.3.len(), 24, "{target:?}: one relocation");
        let r_offset = u64::from_le_bytes(rela.3[0..8].try_into().unwrap());
        let r_info = u64::from_le_bytes(rela.3[8..16].try_into().unwrap());
        assert_eq!(r_offset, 8, "{target:?}: relocation at the second quad");
        assert_eq!(
            (r_info >> 32) as usize,
            sym_i,
            "{target:?}: relocation targets the label symbol"
        );
    }
}

#[test]
fn asm_section_pointer_to_global_object_names_the_object_symbol() {
    // A relocation reaching an external-linkage object must name that
    // object's symbol: the binding is a property of the symbol, so reducing
    // the reference to section+addend presents the definition to a reader as
    // local. An internal-linkage object has no such symbol and stays
    // section-relative, matching how an assembler reduces a local name.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    const STB_LOCAL: u8 = 0;
    const STB_GLOBAL: u8 = 1;
    const STT_SECTION: u8 = 3;
    let src = r#"int plain_obj = 1;
const int const_obj = 2;
int placed_obj __attribute__((section(".placed"))) = 3;
static int local_obj = 4;
asm(".section \".tbl\",\"a\"\n"
    "\t.quad plain_obj\n"
    "\t.quad const_obj\n"
    "\t.quad placed_obj\n"
    "\t.quad local_obj\n"
    ".previous\n");
int main(void) { return plain_obj + const_obj + placed_obj + local_obj; }
"#;
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let opts = NativeOptions {
            output_kind: OutputKind::Relocatable,
            ..Default::default()
        };
        let bytes = emit_native_with_options(&program, target, opts).expect("emit");
        let sections = elf_sections(&bytes);
        let symtab = sections
            .iter()
            .find(|(n, _, _, _)| n == ".symtab")
            .unwrap_or_else(|| panic!("{target:?}: .symtab missing"))
            .3
            .clone();
        let rela = &sections
            .iter()
            .find(|(n, _, _, _)| n == ".rela.tbl")
            .unwrap_or_else(|| panic!("{target:?}: .rela.tbl missing"))
            .3;
        assert_eq!(rela.len(), 4 * 24, "{target:?}: four relocations");
        let row = |i: usize| {
            let r = &rela[i * 24..i * 24 + 24];
            let r_info = u64::from_le_bytes(r[8..16].try_into().unwrap());
            let addend = i64::from_le_bytes(r[16..24].try_into().unwrap());
            let idx = (r_info >> 32) as usize;
            let st_info = symtab[idx * 24 + 4];
            (idx, st_info >> 4, st_info & 0xF, addend)
        };
        for (i, name) in ["plain_obj", "const_obj", "placed_obj"].iter().enumerate() {
            let (idx, bind, _, addend) = row(i);
            let want = elf_symbol(&bytes, name)
                .unwrap_or_else(|| panic!("{target:?}: `{name}` symbol missing"))
                .4;
            assert_eq!(
                idx, want,
                "{target:?}: `{name}` relocation names the object"
            );
            assert_eq!(bind, STB_GLOBAL, "{target:?}: `{name}` binding");
            assert_eq!(addend, 0, "{target:?}: `{name}` addend");
        }
        let (_, bind, sym_type, _) = row(3);
        assert_eq!(bind, STB_LOCAL, "{target:?}: internal-linkage stays local");
        assert_eq!(
            sym_type, STT_SECTION,
            "{target:?}: internal-linkage stays section-relative"
        );
    }
}

#[test]
fn asm_address_constraint_renders_as_a_memory_reference() {
    // The `p` constraint takes its operand as an address in a general
    // register; `%a` renders that register as an address reference, so the
    // instruction encodes a memory operand rather than a register-direct one.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let opts = || NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let text = |src: &str, target| {
        let program = Compiler::new(String::from(src)).compile().expect("compile");
        let bytes = emit_native_with_options(&program, target, opts()).expect("emit");
        elf_sections(&bytes)
            .into_iter()
            .find(|(n, _, _, _)| n == ".text")
            .expect(".text")
            .3
    };

    // AArch64 `prfm pldl1keep, [Xn]`: the base register is the operand and
    // the immediate offset is zero.
    let a64 = text(
        "void pl(const void *p) { __asm__ volatile(\"prfm pldl1keep, %a0\\n\" : : \"p\" (p)); }\nint main(void) { return 0; }\n",
        Target::LinuxAarch64,
    );
    let found = a64.chunks_exact(4).any(|w| {
        let w = u32::from_le_bytes(w.try_into().unwrap());
        w & 0xFFFF_FC1F == 0xF980_0000
    });
    assert!(found, "aarch64: `prfm pldl1keep, [Xn]` not encoded");

    // x86-64 `prefetcht0 (%reg)`: opcode 0F 18 /1 with a mod=00 ModR/M, the
    // base-only memory form. A `%0` operand would encode mod=11 instead.
    let x64 = text(
        "void pl(const void *p) { __asm__ volatile(\"prefetcht0 %a0\" : : \"p\" (p)); }\nint main(void) { return 0; }\n",
        Target::LinuxX64,
    );
    let found = x64.windows(3).any(|w| {
        w[0] == 0x0F && w[1] == 0x18 && w[2] >> 6 == 0 && (w[2] >> 3) & 7 == 1 && w[2] & 7 != 4
    });
    assert!(found, "x86-64: `prefetcht0 (%reg)` not encoded");
}

#[test]
fn asm_prfm_accepts_a_bare_q_operand_reference() {
    // The AArch64 LL/SC atomics name the `+Q` memory operand with a bare
    // `%N` reference (`prfm pstl1strm, %2`), not `%aN`. The operand's address
    // register renders as `[xN]`, the base-register form, and prfm/ldxr/stxr
    // on the same operand must all address that register.
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let src = "typedef struct { int counter; } atomic_t;\n\
        void a(int i, atomic_t *v) {\n\
        int result; unsigned long tmp;\n\
        __asm__ volatile(\n\
        \"prfm pstl1strm, %2\\n\"\n\
        \"1: ldxr %w0, %2\\n\"\n\
        \"add %w0, %w0, %w3\\n\"\n\
        \"stxr %w1, %w0, %2\\n\"\n\
        \"cbnz %w1, 1b\\n\"\n\
        : \"=&r\"(result), \"=&r\"(tmp), \"+Q\"(v->counter)\n\
        : \"Ir\"(i));\n\
        }\nint main(void) { return 0; }\n";
    // Compile for the aarch64 target, not the host: the inline asm is aarch64
    // (prfm/ldxr/stxr), so a host-target compile rejects it on an x86-64 host.
    let program = Compiler::with_target(String::from(src), Target::LinuxAarch64)
        .compile()
        .expect("compile");
    let bytes = emit_native_with_options(&program, Target::LinuxAarch64, opts).expect("emit");
    let text = elf_sections(&bytes)
        .into_iter()
        .find(|(n, _, _, _)| n == ".text")
        .expect(".text")
        .3;
    let words = || {
        text.chunks_exact(4)
            .map(|w| u32::from_le_bytes(w.try_into().unwrap()))
    };
    // prfm pstl1strm, [Xn]: base-register form, zero offset, prfop 0x11.
    let prfm = words()
        .find(|&w| w & 0xFFC0_0000 == 0xF980_0000)
        .expect("prfm encoded");
    assert_eq!(prfm & 0x1F, 0x11, "prfm prfop is pstl1strm");
    assert_eq!((prfm >> 10) & 0xFFF, 0, "prfm offset is zero");
    let base = (prfm >> 5) & 0x1F;
    // ldxr Wt, [Xn] and stxr Ws, Wt, [Xn] on the same operand share the base.
    let ldxr = words()
        .find(|&w| w & 0xFFFF_FC00 == 0x885F_7C00)
        .expect("ldxr encoded");
    let stxr = words()
        .find(|&w| w & 0xFFE0_FC00 == 0x8800_7C00)
        .expect("stxr encoded");
    assert_eq!(
        (ldxr >> 5) & 0x1F,
        base,
        "ldxr shares the prfm base register"
    );
    assert_eq!(
        (stxr >> 5) & 0x1F,
        base,
        "stxr shares the prfm base register"
    );
}

#[test]
fn x86_percpu_seg_a_operand_uses_a_direct_pcrel_reloc() {
    // The x86 percpu read accessors apply the `%a` address modifier to an
    // `i`-class operand naming a percpu global, under a `%%gs:` prefix:
    // `movq %%gs:%a[var], %[val]` with `[var] "i" (&pcpu_hot.field)`. gcc
    // lowers this to `65 48 8b 05 <disp32>` (mov %gs:sym(%rip), reg) plus a
    // direct R_X86_64_PC32 against the symbol -- never a GOT load, since the
    // access rides the symbol's link-time value. Verify the encoding and the
    // reloc for both a zero and a non-zero folded field offset, with a
    // negative control that no relaxable GOT reloc lands on the same access.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    // psABI x86_64 reloc types.
    const R_X86_64_PC32: u32 = 2;
    const R_X86_64_REX_GOTPCRELX: u32 = 42;

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let src = "\
        extern struct pcpu_t { unsigned long cur; unsigned long nxt; } pcpu_hot;\n\
        unsigned long read_cur(void) { unsigned long v;\n\
          __asm__(\"movq %%gs:%a[var], %[val]\" : [val] \"=r\" (v)\n\
                  : [var] \"i\" (&pcpu_hot.cur)); return v; }\n\
        unsigned long read_nxt(void) { unsigned long v;\n\
          __asm__(\"movq %%gs:%a[var], %[val]\" : [val] \"=r\" (v)\n\
                  : [var] \"i\" (&pcpu_hot.nxt)); return v; }\n";
    let program = Compiler::with_options(
        src.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse");

    // `65 48 8b <modrm>` with mod=00 rm=101 is `mov %gs:disp32(%rip), reg`
    // for any destination register; the disp32 field follows the modrm.
    let disp32_offsets: alloc::vec::Vec<u64> = obj
        .text
        .windows(4)
        .enumerate()
        .filter(|(_, w)| w[0] == 0x65 && w[1] == 0x48 && w[2] == 0x8b && (w[3] & 0xC7) == 0x05)
        .map(|(i, _)| (i + 4) as u64)
        .collect();
    assert_eq!(
        disp32_offsets.len(),
        2,
        "both percpu reads must encode `mov %gs:sym(%rip), reg`"
    );

    let mut addends: alloc::vec::Vec<i64> = alloc::vec::Vec::new();
    for off in &disp32_offsets {
        let direct = obj
            .text_relocs
            .iter()
            .find(|r| r.offset == *off && r.rtype == R_X86_64_PC32)
            .unwrap_or_else(|| panic!("direct PC32 reloc missing at disp32 {off}"));
        assert_eq!(
            obj.symbols[direct.sym_idx].name, "pcpu_hot",
            "the reloc must target the percpu symbol"
        );
        assert!(
            !obj.text_relocs
                .iter()
                .any(|r| r.offset == *off && r.rtype == R_X86_64_REX_GOTPCRELX),
            "a segment-relative percpu access must not ride a GOT load"
        );
        addends.push(direct.addend);
    }
    // gcc's addend is the folded field offset less the 4-byte PC32 end skew:
    // `cur` (offset 0) -> -4, `nxt` (offset 8) -> +4.
    addends.sort_unstable();
    assert_eq!(addends, [-4, 4], "PC32 addend must be field offset - 4");
}

#[test]
fn x86_this_ip_rip_relative_lea_has_no_reloc() {
    // `_THIS_IP_` compiles `lea disp(%%rip), %reg` with a literal
    // displacement: a self-relative address (`rip + disp`) the CPU forms at
    // run time. gcc encodes it as `<REX.W> 8d <modrm=..000.101> <disp32>`
    // (mod=00 rm=101) carrying the literal displacement and NO relocation.
    // Emitting a relocation here, or a wrong disp32, is a silent miscompile.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};

    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let src = "\
        unsigned long here0(void) { unsigned long p;\n\
          __asm__(\"lea 0(%%rip), %0\" : \"=r\" (p)); return p; }\n\
        unsigned long here16(void) { unsigned long p;\n\
          __asm__(\"lea 16(%%rip), %0\" : \"=r\" (p)); return p; }\n";
    let program = Compiler::with_options(
        src.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse");

    // `<REX.W> 8d <modrm>` with mod=00 rm=101 is `lea disp32(%rip), reg` for
    // any destination register; the disp32 field follows the modrm byte.
    let sites: alloc::vec::Vec<(u64, i32)> = obj
        .text
        .windows(7)
        .enumerate()
        .filter(|(_, w)| (w[0] & 0xF8) == 0x48 && w[1] == 0x8D && (w[2] & 0xC7) == 0x05)
        .map(|(i, w)| {
            let disp = i32::from_le_bytes([w[3], w[4], w[5], w[6]]);
            ((i + 3) as u64, disp)
        })
        .collect();
    let mut disps: alloc::vec::Vec<i32> = sites.iter().map(|&(_, d)| d).collect();
    disps.sort_unstable();
    assert_eq!(disps, [0, 16], "each lea must carry its literal disp32");
    // The address is self-relative: no relocation may land on either disp32.
    for &(off, _) in &sites {
        assert!(
            !obj.text_relocs.iter().any(|r| r.offset == off),
            "a self-relative rip lea must not carry a relocation"
        );
    }
}

#[test]
fn c_reference_binds_to_an_asm_defined_label_in_the_same_unit() {
    // A label defined only by the unit's assembly is a definition of the
    // unit: gas binds a reference within the unit to it and emits no
    // undefined entry. gcc on this source emits one local symbol per label
    // and a direct relocation per reference; three definition sites must
    // behave alike -- a pushed section, plain file-scope asm in `.text`, and
    // a named label in a function body's asm stream.
    use crate::c5::compiler::CompileOptions;
    use crate::c5::linker::object::NativeSymSection;
    use crate::c5::linker::parse_native_elf;
    use crate::c5::{NativeOptions, OutputKind, Target, emit_native_with_options};
    let src = "\
        extern void fn_in_section(void);\n\
        __asm__(\".pushsection .init.text,\\\"ax\\\",@progbits\\n\"\n\
                \".type fn_in_section, @function\\n\"\n\
                \"fn_in_section:\\n\\tret\\n\"\n\
                \".size fn_in_section, .-fn_in_section\\n\"\n\
                \".popsection\\n\");\n\
        extern void plain_text_fn(void);\n\
        __asm__(\".text\\n\"\n\
                \".type plain_text_fn, @function\\n\"\n\
                \"plain_text_fn:\\n\\tret\\n\");\n\
        extern void label_in_text(void);\n\
        void user(void) { __asm__ volatile(\"label_in_text:\\n\\tnop\\n\" ::: \"memory\"); }\n\
        unsigned long a(void) { return (unsigned long)&fn_in_section; }\n\
        unsigned long b(void) { return (unsigned long)&plain_text_fn; }\n\
        unsigned long c(void) { return (unsigned long)&label_in_text; }\n";
    let program = Compiler::with_options(
        src.to_string(),
        Target::LinuxX64,
        CompileOptions::default().with_no_entry_point(true),
    )
    .compile()
    .expect("compile");
    let opts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..Default::default()
    };
    let bytes = emit_native_with_options(&program, Target::LinuxX64, opts).expect("emit");
    let obj = parse_native_elf(&bytes).expect("parse ET_REL");
    for name in ["fn_in_section", "plain_text_fn", "label_in_text"] {
        let hits: alloc::vec::Vec<&crate::c5::linker::object::NativeSymbol> =
            obj.symbols.iter().filter(|s| s.name == name).collect();
        assert_eq!(
            hits.len(),
            1,
            "`{name}` must surface as one symbol, not a definition plus an \
             undefined twin: {hits:?}"
        );
        assert_eq!(
            hits[0].binding, 0,
            "`{name}` has no `.globl`, so it is local"
        );
        assert!(
            matches!(hits[0].section, NativeSymSection::Text),
            "`{name}` must be defined in the unit's code, not undefined: {:?}",
            hits[0].section
        );
        // The C reference relocates against that definition.
        let idx = obj.symbols.iter().position(|s| s.name == name).unwrap();
        assert!(
            obj.text_relocs.iter().any(|r| r.sym_idx == idx),
            "the C reference to `{name}` must relocate against the in-unit definition"
        );
    }
}
