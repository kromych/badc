//! AArch64 SIMD rows: the instruction each `<arm_neon.h>` intrinsic over
//! them emits, the value semantics the interpreter evaluates, and the
//! target the parser requires.
//!
//! The expected encodings were decoded by the system `objdump` (LLVM's
//! AArch64 disassembler) as the instruction in each comment.

/// Each intrinsic is its one instruction on the argument registers under
/// `-O`; a 64-bit single-lane form is the scalar instruction on D views,
/// and `vclt` is `cmgt` with the operands swapped.
#[cfg(feature = "full")]
#[test]
fn the_intrinsics_emit_their_instruction() {
    use crate::{NativeOptions, Target};
    let src = "#include <arm_neon.h>\n\
        int8x16_t f(int8x16_t a, int8x16_t b) { return vqaddq_s8(a, b); }\n\
        uint16x4_t g(uint16x4_t a, uint16x4_t b) { return vrhadd_u16(a, b); }\n\
        int64x1_t h(int64x1_t a, int64x1_t b) { return vqsub_s64(a, b); }\n\
        uint32x4_t k(int32x4_t a, int32x4_t b) { return vcltq_s32(a, b); }\n\
        int main(void) { return 0; }";
    let program = crate::Compiler::with_target(src.to_string(), Target::LinuxAarch64)
        .compile()
        .expect("<arm_neon.h> must compile for an AArch64 target");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxAarch64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit_native for linux-aarch64");
    for (word, what) in [
        (0x4e21_0c00u32, "sqadd v0.16b, v0.16b, v1.16b"),
        (0x2e61_1400, "urhadd v0.4h, v0.4h, v1.4h"),
        (0x5ee1_2c00, "sqsub d0, d0, d1"),
        (0x4ea0_3420, "cmgt v0.4s, v1.4s, v0.4s"),
    ] {
        let needle = word.to_le_bytes();
        assert!(
            bytes.windows(4).any(|w| w == needle),
            "{what}: expected {word:#010x} in the emitted code"
        );
    }
}

/// The interpreter evaluates the rows the emit encodes: saturation at both
/// bounds, halving and rounding, absolute difference, the pairwise forms
/// over both operands, 64-bit lanes, the bitwise forms, and the signed and
/// unsigned compares.
#[test]
fn the_interpreter_runs_the_rows() {
    let src = "#include <arm_neon.h>\n\
        int main(void) {\n\
            int8x16_t a = {100, -100, 127, -128, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};\n\
            int8x16_t b = {100, -100, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};\n\
            int8x16_t q = vqaddq_s8(a, b);\n\
            if (q[0] != 127 || q[1] != -128 || q[2] != 127 || q[3] != -128 || q[4] != 2) return 1;\n\
            uint8x16_t u = vqsubq_u8(vreinterpretq_u8_s8(b), vreinterpretq_u8_s8(a));\n\
            if (u[0] != 0 || u[2] != 0 || u[3] != 127) return 2;\n\
            uint16x4_t c = {1, 2, 65535, 4}, d = {2, 2, 65535, 9};\n\
            uint16x4_t h = vrhadd_u16(c, d);\n\
            if (h[0] != 2 || h[1] != 2 || h[2] != 65535 || h[3] != 7) return 3;\n\
            int32x2_t m = {7, -7}, n = {-3, 3};\n\
            int32x2_t ab = vabd_s32(m, n);\n\
            if (ab[0] != 10 || ab[1] != 10) return 4;\n\
            int16x4_t p = vpadd_s16((int16x4_t){1, 2, 3, 4}, (int16x4_t){10, 20, 30, 40});\n\
            if (p[0] != 3 || p[1] != 7 || p[2] != 30 || p[3] != 70) return 5;\n\
            uint8x8_t mx = vpmax_u8((uint8x8_t){1, 9, 8, 2, 0, 0, 255, 3},\n\
                                    (uint8x8_t){4, 5, 6, 7, 1, 1, 2, 2});\n\
            if (mx[0] != 9 || mx[1] != 8 || mx[3] != 255 || mx[4] != 5 || mx[7] != 2) return 6;\n\
            int64x2_t x = {-1, 5}, y = {3, 5};\n\
            uint64x2_t gt = vcgtq_s64(x, y), ge = vcgeq_u64(vreinterpretq_u64_s64(x),\n\
                                                            vreinterpretq_u64_s64(y));\n\
            if (gt[0] != 0 || gt[1] != 0 || ge[0] != ~0ull || ge[1] != ~0ull) return 7;\n\
            int64x1_t s = vqadd_s64((int64x1_t){0x7fffffffffffffffll}, (int64x1_t){1});\n\
            if (s[0] != 0x7fffffffffffffffll) return 8;\n\
            uint32x4_t t = vtstq_u32((uint32x4_t){1, 2, 4, 8}, (uint32x4_t){1, 1, 4, 7});\n\
            if (t[0] != ~0u || t[1] != 0 || t[2] != ~0u || t[3] != 0) return 9;\n\
            uint8x8_t bc = vbic_u8((uint8x8_t){0xff, 0xf0}, (uint8x8_t){0x0f, 0xff});\n\
            uint8x8_t on = vorn_u8((uint8x8_t){0x00, 0x01}, (uint8x8_t){0xf0, 0xff});\n\
            if (bc[0] != 0xf0 || bc[1] != 0 || on[0] != 0x0f || on[1] != 0x01) return 10;\n\
            uint16x8_t lt = vcltq_s16((int16x8_t){-1, 1}, (int16x8_t){0, 0});\n\
            if (lt[0] != 0xffff || lt[1] != 0 || lt[2] != 0) return 11;\n\
            return 0;\n\
        }";
    let program = super::compile_str_bare_for(src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "the interpreter must agree with the instructions"
    );
}

/// A row names an AArch64 instruction; an x86 unit cannot call it, and
/// the parser says which target it requires.
#[test]
fn the_rows_are_aarch64_only() {
    let src = "typedef signed char v16 __attribute__((vector_size(16)));\n\
        v16 f(v16 a, v16 b) { return __builtin_neon_sqadd_16b(a, b); }\n\
        int main(void) { return 0; }";
    let Err(err) = crate::Compiler::with_target(src.to_string(), crate::Target::LinuxX64).compile()
    else {
        panic!("an AArch64 SIMD builtin must not compile for x86-64");
    };
    assert!(
        format!("{err:?}").contains("requires an AArch64 target"),
        "names the reason: {err:?}"
    );
}

/// Every element type's integer arithmetic, saturating, halving, pairwise,
/// bitwise, bit-count, select and compare intrinsic, checked against the
/// operation the Arm ARM defines over 128-bit integers: the fixture runs
/// natively on the AArch64 lanes, and here under the interpreter on any
/// host.
#[test]
fn the_interpreter_runs_the_integer_intrinsics() {
    let src = super::load_fixture("arm_neon_integer_arithmetic_bitwise_and_compares.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "a failing group sets its bit in the exit code"
    );
}
