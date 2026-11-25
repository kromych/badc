//! AArch64 SIMD rows: the instruction each `<arm_neon.h>` intrinsic over
//! them emits, the value semantics the interpreter evaluates, and the
//! target the parser requires.
//!
//! The expected encodings were decoded by the system `objdump` (LLVM's
//! AArch64 disassembler) as the instruction in each comment.

/// Each intrinsic is its one instruction on the argument registers under
/// `-O`; a 64-bit single-lane form is the scalar instruction on D views,
/// and `vclt` is `cmgt` with the operands swapped.
#[cfg(feature = "linker")]
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

/// Each lane permute is its one instruction on the argument registers
/// under `-O`, a floating one the integer form of its lane width, and
/// `vext` the byte form at its lane's byte offset; so is each conversion
/// between the float and double lanes, each lane `dup` and table lookup,
/// and each shift by an immediate, an accumulating one in its first
/// operand's register.
#[cfg(feature = "linker")]
#[test]
fn the_permutes_emit_their_instruction() {
    use crate::{NativeOptions, Target};
    let src = "#include <arm_neon.h>\n\
        int8x16_t f(int8x16_t a, int8x16_t b) { return vzip1q_s8(a, b); }\n\
        uint16x4_t g(uint16x4_t a, uint16x4_t b) { return vuzp2_u16(a, b); }\n\
        int64x2_t h(int64x2_t a, int64x2_t b) { return vtrn1q_s64(a, b); }\n\
        float32x2_t k(float32x2_t a, float32x2_t b) { return vtrn2_f32(a, b); }\n\
        uint8x16_t m(uint8x16_t a, uint8x16_t b) { return vextq_u8(a, b, 5); }\n\
        int16x4_t n(int16x4_t a, int16x4_t b) { return vext_s16(a, b, 3); }\n\
        float64x2_t wide(float32x2_t a) { return vcvt_f64_f32(a); }\n\
        float32x2_t narrow(float64x2_t a) { return vcvt_f32_f64(a); }\n\
        int8x16_t dupq(int8x8_t a) { return vdupq_lane_s8(a, 7); }\n\
        uint16x4_t dup(uint16x8_t a) { return vdup_laneq_u16(a, 6); }\n\
        uint8x16_t tbl(uint8x16_t t, uint8x16_t i) { return vqtbl1q_u8(t, i); }\n\
        uint8x8_t tbx(uint8x8_t d, uint8x16_t t, uint8x8_t i) { return vqtbx1_u8(d, t, i); }\n\
        int8x16_t qshl(int8x16_t a) { return vqshlq_n_s8(a, 3); }\n\
        uint16x8_t rshr(uint16x8_t a) { return vrshrq_n_u16(a, 16); }\n\
        int8x8_t shrn(int16x8_t a) { return vshrn_n_s16(a, 3); }\n\
        uint16x4_t rshrn(uint32x4_t a) { return vrshrn_n_u32(a, 16); }\n\
        int8x16_t sra(int8x16_t a, int8x16_t b) { return vsraq_n_s8(a, b, 3); }\n\
        uint32x2_t sli(uint32x2_t a, uint32x2_t b) { return vsli_n_u32(a, b, 5); }\n\
        uint64x1_t sri(uint64x1_t a, uint64x1_t b) { return vsri_n_u64(a, b, 64); }\n\
        uint16x8_t rsra(uint16x8_t a, uint16x8_t b) { return vrsraq_n_u16(a, b, 16); }\n\
        uint64x1_t usra(uint64x1_t a, uint64x1_t b) { return vsra_n_u64(a, b, 1); }\n\
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
    // The masks clear the register fields the allocator chooses, Rm with
    // them in the three-register forms.
    const THREE: u32 = 0xFFE0_FC00;
    const TWO: u32 = 0xFFFF_FC00;
    for (word, mask, what) in [
        (0x4e01_3800u32, THREE, "zip1 v0.16b, v0.16b, v1.16b"),
        (0x0e41_5800, THREE, "uzp2 v0.4h, v0.4h, v1.4h"),
        (0x4ec1_2800, THREE, "trn1 v0.2d, v0.2d, v1.2d"),
        (0x0e81_6800, THREE, "trn2 v0.2s, v0.2s, v1.2s"),
        (0x6e01_2800, THREE, "ext v0.16b, v0.16b, v1.16b, #5"),
        (0x2e01_3000, THREE, "ext v0.8b, v0.8b, v1.8b, #6"),
        (0x0e61_7800, TWO, "fcvtl v0.2d, v0.2s"),
        (0x0e61_6800, TWO, "fcvtn v0.2s, v0.2d"),
        (0x4e0f_0400, TWO, "dup v0.16b, v0.b[7]"),
        (0x0e1a_0400, TWO, "dup v0.4h, v0.h[6]"),
        (0x4e01_0000, THREE, "tbl v0.16b, {v0.16b}, v1.16b"),
        (0x0e02_1020, THREE, "tbx v0.8b, {v1.16b}, v2.8b"),
        (0x4f0b_7400, TWO, "sqshl v0.16b, v0.16b, #3"),
        (0x6f10_2400, TWO, "urshr v0.8h, v0.8h, #16"),
        (0x0f0d_8400, TWO, "shrn v0.8b, v0.8h, #3"),
        (0x0f10_8c00, TWO, "rshrn v0.4h, v0.4s, #16"),
        (0x4f0d_1420, TWO, "ssra v0.16b, v1.16b, #3"),
        (0x2f25_5420, TWO, "sli v0.2s, v1.2s, #5"),
        (0x7f40_4420, TWO, "sri d0, d1, #64"),
        (0x6f10_3420, TWO, "ursra v0.8h, v1.8h, #16"),
        (0x7f7f_1420, TWO, "usra d0, d1, #1"),
    ] {
        let mut words = bytes
            .as_chunks::<4>()
            .0
            .iter()
            .map(|w| u32::from_le_bytes(*w));
        assert!(
            words.any(|w| w & mask == word & mask),
            "{what}: expected {word:#010x} under {mask:#010x} in the emitted code"
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

/// A GNU vector comparison, a shift by a constant count and a negation are
/// the target's one instruction for the whole vector where it has one
/// (`simd::find`): `<` is `cmgt` with the operands swapped.
#[cfg(feature = "linker")]
#[test]
fn the_vector_operators_take_the_rows() {
    use crate::{NativeOptions, Target};
    let src = "typedef int v4 __attribute__((vector_size(16)));\n\
        typedef unsigned short u8h __attribute__((vector_size(16)));\n\
        v4 lt(v4 a, v4 b) { return a < b; }\n\
        u8h shr(u8h a) { return a >> 3; }\n\
        v4 neg(v4 a) { return -a; }\n\
        int main(void) { return 0; }";
    let program = super::compile_str_bare_for(src, Target::LinuxAarch64);
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxAarch64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit_native for linux-aarch64");
    for (word, what) in [
        (0x4ea0_3420u32, "cmgt v0.4s, v1.4s, v0.4s"),
        (0x6f1d_0400, "ushr v0.8h, v0.8h, #3"),
        (0x6ea0_b800, "neg v0.4s, v0.4s"),
    ] {
        let needle = word.to_le_bytes();
        assert!(
            bytes.windows(4).any(|w| w == needle),
            "{what}: expected {word:#010x} in the emitted code"
        );
    }
}

/// The floating rows give the bits the instructions give, checked against
/// the hardware and the reference compiler on AArch64: a NaN operand
/// propagated and a signaling one quieted, `fmax` and `fmin` ordering -0
/// below +0, the quiet `fcmeq` and the ordered compares, `fabs` and `fneg`
/// on a NaN's sign, and `fmla` and `fmls` rounded once.
#[test]
fn the_interpreter_runs_the_floating_rows() {
    let src = "#include <arm_neon.h>\n\
        #include <string.h>\n\
        static float f(unsigned x) { float r; memcpy(&r, &x, 4); return r; }\n\
        static int bits4(uint32x4_t v, const unsigned *e) {\n\
            return v[0] != e[0] || v[1] != e[1] || v[2] != e[2] || v[3] != e[3];\n\
        }\n\
        int main(void) {\n\
            float32x4_t a = {f(0x7fc12345), 0.0f, -0.0f, 1.5f};\n\
            float32x4_t b = {2.0f, -0.0f, 0.0f, f(0x7f812345)};\n\
            float32x4_t c = {1e30f, -1e-30f, 3.0f, -2.0f};\n\
            float32x4_t big = {16777217.0f, 1.0f / 3.0f, 0.1f, 3.0f};\n\
            float32x4_t sm = {16777215.0f, 3.0f, 10.0f, 1.0f / 3.0f};\n\
            if (bits4((uint32x4_t)vmaxq_f32(a, b), (unsigned[4]){0x7fc12345, 0x00000000, 0x00000000, 0x7fc12345})) return 1;\n\
            if (bits4((uint32x4_t)vminq_f32(a, b), (unsigned[4]){0x7fc12345, 0x80000000, 0x80000000, 0x7fc12345})) return 2;\n\
            if (bits4((uint32x4_t)vmaxq_f32(b, a), (unsigned[4]){0x7fc12345, 0x00000000, 0x00000000, 0x7fc12345})) return 3;\n\
            if (bits4((uint32x4_t)vminq_f32(b, a), (unsigned[4]){0x7fc12345, 0x80000000, 0x80000000, 0x7fc12345})) return 4;\n\
            if (bits4((uint32x4_t)vaddq_f32(a, c), (unsigned[4]){0x7fc12345, 0x8da24260, 0x40400000, 0xbf000000})) return 5;\n\
            if (bits4((uint32x4_t)vsubq_f32(c, b), (unsigned[4]){0x7149f2ca, 0x8da24260, 0x40400000, 0x7fc12345})) return 6;\n\
            if (bits4((uint32x4_t)vmulq_f32(c, c), (unsigned[4]){0x7f800000, 0x00000000, 0x41100000, 0x40800000})) return 7;\n\
            if (bits4((uint32x4_t)vdivq_f32(c, a), (unsigned[4]){0x7fc12345, 0xff800000, 0xff800000, 0xbfaaaaab})) return 8;\n\
            if (bits4((uint32x4_t)vabsq_f32(a), (unsigned[4]){0x7fc12345, 0x00000000, 0x00000000, 0x3fc00000})) return 9;\n\
            if (bits4((uint32x4_t)vnegq_f32(b), (unsigned[4]){0xc0000000, 0x00000000, 0x80000000, 0xff812345})) return 10;\n\
            if (bits4((uint32x4_t)vsqrtq_f32(c), (unsigned[4]){0x58635fa9, 0x7fc00000, 0x3fddb3d7, 0x7fc00000})) return 11;\n\
            if (bits4((uint32x4_t)vceqq_f32(a, b), (unsigned[4]){0x00000000, 0xffffffff, 0xffffffff, 0x00000000})) return 12;\n\
            if (bits4((uint32x4_t)vcgeq_f32(a, b), (unsigned[4]){0x00000000, 0xffffffff, 0xffffffff, 0x00000000})) return 13;\n\
            if (bits4((uint32x4_t)vcgtq_f32(c, a), (unsigned[4]){0x00000000, 0x00000000, 0xffffffff, 0x00000000})) return 14;\n\
            if (bits4((uint32x4_t)vcleq_f32(c, b), (unsigned[4]){0x00000000, 0xffffffff, 0x00000000, 0x00000000})) return 15;\n\
            if (bits4((uint32x4_t)vcltq_f32(b, c), (unsigned[4]){0xffffffff, 0x00000000, 0xffffffff, 0x00000000})) return 16;\n\
            if (bits4((uint32x4_t)vfmaq_f32(sm, big, sm), (unsigned[4]){0x57800000, 0x40800000, 0x41300000, 0x3faaaaab})) return 17;\n\
            if (bits4((uint32x4_t)vfmsq_f32(sm, big, sm), (unsigned[4]){0xd77ffffe, 0x40000000, 0x41100000, 0xbf2aaaab})) return 18;\n\
            uint32x2_t r = (uint32x2_t)vmax_f32((float32x2_t){f(0xff800001), -0.0f}, (float32x2_t){1.0f, 0.0f});\n\
            uint32x2_t s = (uint32x2_t)vmin_f32((float32x2_t){f(0xff800001), -0.0f}, (float32x2_t){1.0f, 0.0f});\n\
            if (r[0] != 0xffc00001 || r[1] != 0x00000000 || s[0] != 0xffc00001 || s[1] != 0x80000000) return 30;\n\
            uint64x2_t z = (uint64x2_t)vaddq_f64((float64x2_t){0.1, -0.0}, (float64x2_t){0.2, 0.0});\n\
            uint64x2_t w = (uint64x2_t)vminq_f64((float64x2_t){0.1, -0.0}, (float64x2_t){0.2, 0.0});\n\
            uint64x1_t q = (uint64x1_t)vsqrt_f64((float64x1_t){2.0});\n\
            if (z[0] != 0x3fd3333333333334ull || z[1] != 0x0000000000000000ull) return 31;\n\
            if (w[0] != 0x3fb999999999999aull || w[1] != 0x8000000000000000ull || q[0] != 0x3ff6a09e667f3bcdull) return 32;\n\
            return 0;\n\
        }";
    let program = super::compile_str_bare_for(src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "the failing check's number"
    );
}

/// The widening and narrowing intrinsics on every element type, checked
/// against the operation computed on the wide type: the fixture runs
/// natively on the AArch64 lanes, and here under the interpreter.
#[test]
fn the_interpreter_runs_the_widening_intrinsics() {
    let src = super::load_fixture("arm_neon_widening_and_narrowing_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "a failing element type sets its bit in the exit code"
    );
}

/// The shifts by a register count give each lane the result the
/// instructions give, checked against the hardware and the reference
/// compiler: counts at and past the lane width either way, the low byte's
/// sign, rounding at the boundary, saturation, and the scalar 64-bit forms.
#[test]
fn the_interpreter_runs_the_register_shifts() {
    let src = "#include <arm_neon.h>\n\
        #include <string.h>\n\
        int main(void) {\n\
            static const signed char A[16] = {-128, 127, -1, 1, 0x40, -0x41, 3, -3, 100, -100, 7, 0, 0x55, -0x56, 1, -1};\n\
            static const signed char S[16] = {1, 1, 7, 8, -1, -7, -8, -9, 127, -128, 3, 5, 2, -2, 64, -64};\n\
            int8x16_t a, s; memcpy(&a, A, 16); memcpy(&s, S, 16);\n\
            int16x8_t h = {-32768, 32767, -1, 300, 5, -5, 0x4000, 2}, hs = {1, -1, 15, 16, -16, -17, 1, 14};\n\
            int64x2_t d = {(long long)0x8000000000000000ull, 0x7fffffffffffffffll}, ds = {-1, 1};\n\
            uint8x16_t r[11];\n\
            r[0] = (uint8x16_t)vshlq_s8(a, s); r[1] = (uint8x16_t)vrshlq_s8(a, s);\n\
            r[2] = (uint8x16_t)vqshlq_s8(a, s); r[3] = vshlq_u8((uint8x16_t)a, s);\n\
            r[4] = vrshlq_u8((uint8x16_t)a, s); r[5] = vqshlq_u8((uint8x16_t)a, s);\n\
            r[6] = (uint8x16_t)vqshlq_s16(h, hs); r[7] = (uint8x16_t)vrshlq_s16(h, hs);\n\
            r[8] = (uint8x16_t)vqshlq_s64(d, ds); r[9] = (uint8x16_t)vrshlq_s64(d, ds);\n\
            r[10] = (uint8x16_t)vshlq_s64(d, (int64x2_t){-64, 63});\n\
            if (memcmp(&r[0], (const unsigned char[16]){0x00, 0xfe, 0x80, 0x00, 0x20, 0xff, 0x00, 0xff, 0x00, 0xff, 0x38, 0x00, 0x54, 0xea, 0x00, 0xff}, 16)) return 1;\n\
            if (memcmp(&r[1], (const unsigned char[16]){0x00, 0xfe, 0x80, 0x00, 0x20, 0xff, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x54, 0xeb, 0x00, 0x00}, 16)) return 2;\n\
            if (memcmp(&r[2], (const unsigned char[16]){0x80, 0x7f, 0x80, 0x7f, 0x20, 0xff, 0x00, 0xff, 0x7f, 0xff, 0x38, 0x00, 0x7f, 0xea, 0x7f, 0xff}, 16)) return 3;\n\
            if (memcmp(&r[3], (const unsigned char[16]){0x00, 0xfe, 0x80, 0x00, 0x20, 0x01, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x54, 0x2a, 0x00, 0x00}, 16)) return 4;\n\
            if (memcmp(&r[4], (const unsigned char[16]){0x00, 0xfe, 0x80, 0x00, 0x20, 0x01, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x54, 0x2b, 0x00, 0x00}, 16)) return 5;\n\
            if (memcmp(&r[5], (const unsigned char[16]){0xff, 0xfe, 0xff, 0xff, 0x20, 0x01, 0x00, 0x00, 0xff, 0x00, 0x38, 0x00, 0xff, 0x2a, 0xff, 0x00}, 16)) return 6;\n\
            if (memcmp(&r[6], (const unsigned char[16]){0x00, 0x80, 0xff, 0x3f, 0x00, 0x80, 0xff, 0x7f, 0x00, 0x00, 0xff, 0xff, 0xff, 0x7f, 0xff, 0x7f}, 16)) return 7;\n\
            if (memcmp(&r[7], (const unsigned char[16]){0x00, 0x00, 0x00, 0x40, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x80}, 16)) return 8;\n\
            if (memcmp(&r[8], (const unsigned char[16]){0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f}, 16)) return 9;\n\
            if (memcmp(&r[9], (const unsigned char[16]){0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, 16)) return 10;\n\
            if (memcmp(&r[10], (const unsigned char[16]){0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80}, 16)) return 11;\n\
            int64x1_t f1 = vqshl_s64((int64x1_t){3}, (int64x1_t){62});\n\
            uint64x1_t f2 = vrshl_u64((uint64x1_t){0xffffffffffffffffull}, (int64x1_t){-1});\n\
            if ((unsigned long long)f1[0] != 0x7fffffffffffffffull || f2[0] != 0x8000000000000000ull) return 20;\n\
            return 0;\n\
        }";
    let program = super::compile_str_bare_for(src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "the failing check's number"
    );
}

/// The reductions across lanes, the pairwise long sums and the reversals,
/// checked against the operations computed lane by lane: the fixture runs
/// natively on the AArch64 lanes, and here under the interpreter.
#[test]
fn the_interpreter_runs_the_reductions() {
    let src = super::load_fixture("arm_neon_reductions_and_reversals.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "a failing group sets its bit in the exit code"
    );
}

/// The lane permutes, checked against the permutations computed lane by
/// lane: the fixture runs natively on the AArch64 lanes, and here under
/// the interpreter.
#[test]
fn the_interpreter_runs_the_permutes() {
    let src = super::load_fixture("arm_neon_permutes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "a failing type sets its bit in the exit code"
    );
}

/// The saturating, rounding and narrowing shifts by an immediate, checked
/// against the operations computed lane by lane: natively on the AArch64
/// lanes, and here under the interpreter.
#[test]
fn the_interpreter_runs_the_immediate_shifts() {
    let src = super::load_fixture("arm_neon_immediate_shifts.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "a failing group sets its bit in the exit code"
    );
}

/// The whole-vector loads, stores and broadcasts are C the interpreter
/// runs, as are the rows of the halfword fixture.
#[test]
fn the_interpreter_runs_the_loads_stores_and_broadcasts() {
    let src = super::load_fixture("arm_neon_halfword_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        42,
        "the fixture's own status"
    );
}

/// `vmovl_high` lengthens the high half: one `sxtl2` / `uxtl2` (the
/// `sshll2` / `ushll2` #0 alias) under `-O`, and in the interpreter the
/// lanes from the middle of the source.
#[cfg(feature = "linker")]
#[test]
fn the_high_lengthening_moves_read_the_high_half() {
    const SRC: &str = "#include <arm_neon.h>\n\
        int16x8_t a(int8x16_t v) { return vmovl_high_s8(v); }\n\
        uint32x4_t b(uint16x8_t v) { return vmovl_high_u16(v); }\n\
        int64x2_t c(int32x4_t v) { return vmovl_high_s32(v); }\n\
        int main(void) {\n\
            int8x16_t v = {0, 1, 2, 3, 4, 5, 6, 7, -8, -9, -10, -11, -12, -13, -14, -15};\n\
            int16x8_t r = a(v);\n\
            for (int i = 0; i < 8; i++) if (r[i] != -8 - i) return 1 + i;\n\
            uint16x8_t u = {0, 1, 2, 3, 0xfff0, 0xfff1, 0xfff2, 0xfff3};\n\
            uint32x4_t s = b(u);\n\
            for (int i = 0; i < 4; i++) if (s[i] != 0xfff0u + i) return 20 + i;\n\
            int64x2_t t = c((int32x4_t){1, 2, -3, -4});\n\
            return t[0] == -3 && t[1] == -4 ? 42 : 30;\n\
        }\n";
    const RET: u32 = 0xD65F_03C0;
    for (name, want) in [
        ("a", &[0x4F08_A400u32, RET][..]),
        ("b", &[0x6F10_A400, RET]),
        ("c", &[0x4F20_A400, RET]),
    ] {
        let words = super::perf_codegen::a64_at(SRC, name, true);
        assert_eq!(words, want, "{name}: {words:08x?}");
    }
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 42);
}

/// The precision conversions of the high half: `vcvt_high_f64_f32` is
/// `fcvtl2`, and `vcvt_high_f32_f64` narrows into a register and inserts
/// it above the low half; the interpreter computes both.
#[cfg(feature = "linker")]
#[test]
fn the_high_precision_conversions_are_rows() {
    const SRC: &str = "#include <arm_neon.h>\n\
        float64x2_t hi(float32x4_t a) { return vcvt_high_f64_f32(a); }\n\
        float32x4_t nh(float32x2_t lo, float64x2_t a) { return vcvt_high_f32_f64(lo, a); }\n\
        int main(void) {\n\
            float64x2_t w = hi((float32x4_t){1.5f, -2.0f, 3.25f, -8.0f});\n\
            if (w[0] != 3.25 || w[1] != -8.0) return 1;\n\
            float32x4_t n = nh((float32x2_t){0.5f, 4.0f}, (float64x2_t){2.0, -0.25});\n\
            return n[0] == 0.5f && n[1] == 4.0f && n[2] == 2.0f && n[3] == -0.25f ? 42 : 2;\n\
        }\n";
    const RET: u32 = 0xD65F_03C0;
    let words = super::perf_codegen::a64_at(SRC, "hi", true);
    assert_eq!(words, [0x4E61_7800, RET], "hi: {words:08x?}");
    let words = super::perf_codegen::a64_at(SRC, "nh", true);
    assert_eq!(words, [0x0E61_6821, 0x6E18_0420, RET], "nh: {words:08x?}");
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 42);
}

/// `vmul_p8` multiplies each byte lane as a polynomial over GF(2), keeping
/// the low eight bits: one `pmul` under -O, the carry-less product in the
/// interpreter and in the constant folder.
#[cfg(feature = "linker")]
#[test]
fn the_polynomial_multiply_is_a_row() {
    const SRC: &str = "#include <arm_neon.h>\n\
        poly8x8_t m(poly8x8_t a, poly8x8_t b) { return vmul_p8(a, b); }\n\
        poly8x16_t mq(poly8x16_t a, poly8x16_t b) { return vmulq_p8(a, b); }\n\
        static unsigned char ref(unsigned char x, unsigned char y) {\n\
            unsigned p = 0;\n\
            for (int k = 0; k < 8; k++) if (y >> k & 1) p ^= (unsigned)x << k;\n\
            return (unsigned char)p;\n\
        }\n\
        int main(void) {\n\
            volatile unsigned char seed = 0x53;\n\
            poly8x16_t a, b;\n\
            for (int i = 0; i < 16; i++) {\n\
                a[i] = (unsigned char)(seed * (i + 3));\n\
                b[i] = (unsigned char)(seed ^ (i * 29));\n\
            }\n\
            poly8x16_t r = mq(a, b);\n\
            for (int i = 0; i < 16; i++) if (r[i] != ref(a[i], b[i])) return 1 + i;\n\
            poly8x8_t c = vmul_p8((poly8x8_t){0xca, 3}, (poly8x8_t){0x53, 0x81});\n\
            return c[0] == ref(0xca, 0x53) && c[1] == ref(3, 0x81) ? 42 : 40;\n\
        }\n";
    const RET: u32 = 0xD65F_03C0;
    for (name, want) in [
        ("m", &[0x2E21_9C00u32, RET][..]),
        ("mq", &[0x6E21_9C00, RET]),
    ] {
        let words = super::perf_codegen::a64_at(SRC, name, true);
        assert_eq!(words, want, "{name}: {words:08x?}");
    }
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 42);
}

/// The integer and floating conversions of one lane width are rows: toward
/// zero to an integer, saturating at the range and a NaN to zero, and an
/// unsigned 64-bit lane to a `double` rounded once. Hardware, the
/// interpreter and the constant folder agree on each edge.
#[cfg(feature = "linker")]
#[test]
fn the_lane_conversions_saturate_as_the_instructions_do() {
    const SRC: &str = "#include <arm_neon.h>\n\
        int main(void) {\n\
            volatile float nanf_ = __builtin_nanf(\"\");\n\
            float32x4_t f = {nanf_, 3e9f, -3e9f, -0.75f};\n\
            int32x4_t s = vcvtq_s32_f32(f);\n\
            if (s[0] != 0 || s[1] != 2147483647 || s[2] != -2147483647 - 1 || s[3] != 0) return 1;\n\
            uint32x4_t u = vcvtq_u32_f32((float32x4_t){-0.5f, 5e9f, 4294967040.0f, __builtin_inff()});\n\
            if (u[0] != 0 || u[1] != 4294967295u || u[2] != 4294967040u || u[3] != 4294967295u) return 2;\n\
            int64x2_t l = vcvtq_s64_f64((float64x2_t){-9.3e18, 1e19});\n\
            if (l[0] != -9223372036854775807LL - 1 || l[1] != 9223372036854775807LL) return 3;\n\
            uint64x2_t m = vcvtq_u64_f64((float64x2_t){9223372036854775808.0, 1.8e19});\n\
            if (m[0] != 9223372036854775808ULL || m[1] != 18000000000000000000ULL) return 4;\n\
            uint64x2_t big = {18446744073709551615ULL, 9223372036854777857ULL};\n\
            float64x2_t d = vcvtq_f64_u64(big);\n\
            if (d[0] != 18446744073709551616.0 || d[1] != 9223372036854777856.0) return 5;\n\
            float64x2_t sd = vcvtq_f64_s64((int64x2_t){-9007199254740993LL, 3});\n\
            if (sd[0] != -9007199254740992.0 || sd[1] != 3.0) return 6;\n\
            float32x2_t uf = vcvt_f32_u32((uint32x2_t){4294967295u, 16777217u});\n\
            if (uf[0] != 4294967296.0f || uf[1] != 16777216.0f) return 7;\n\
            int32x2_t s2 = vcvt_s32_f32((float32x2_t){-2.9f, 2.9f});\n\
            if (s2[0] != -2 || s2[1] != 2) return 8;\n\
            return 42;\n\
        }\n";
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 42);
    let src = super::load_fixture("arm_neon_float_vectors.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    let words = super::perf_codegen::a64_at(
        "#include <arm_neon.h>\nint32x4_t f(float32x4_t a) { return vcvtq_s32_f32(a); }\n",
        "f",
        true,
    );
    assert_eq!(words, [0x4EA1_B800, 0xD65F_03C0], "f: {words:08x?}");
}

/// The AES rounds are rows: `aese` / `aesd` xor the round key and apply
/// [inverse] ShiftRows and SubBytes, `aesmc` / `aesimc` [inverse]
/// MixColumns. The interpreter's checksum of a round each way is the one
/// AArch64 hardware and clang compute (148); under -O each is one
/// instruction, the round on its state's register.
#[cfg(feature = "linker")]
#[test]
fn the_aes_rounds_are_rows() {
    const SRC: &str = "#include <arm_neon.h>\n\
        uint8x16_t enc(uint8x16_t s, uint8x16_t k) { return vaesmcq_u8(vaeseq_u8(s, k)); }\n\
        uint8x16_t dec(uint8x16_t s, uint8x16_t k) { return vaesimcq_u8(vaesdq_u8(s, k)); }\n\
        int main(void) {\n\
            volatile unsigned char seed = 0x3b;\n\
            uint8x16_t s, k;\n\
            for (int i = 0; i < 16; i++) {\n\
                s[i] = (unsigned char)(seed * (i + 1));\n\
                k[i] = (unsigned char)(seed ^ (i * 17));\n\
            }\n\
            uint8x16_t e = enc(s, k), d = dec(e, k);\n\
            unsigned sum = 0;\n\
            for (int i = 0; i < 16; i++) sum = sum * 31 + e[i] + 7 * d[i];\n\
            return (int)(sum % 251);\n\
        }\n";
    const RET: u32 = 0xD65F_03C0;
    for (name, want) in [
        ("enc", &[0x4E28_4820u32, 0x4E28_6800, RET][..]),
        ("dec", &[0x4E28_5820, 0x4E28_7800, RET]),
    ] {
        let words = super::perf_codegen::a64_at(SRC, name, true);
        assert_eq!(words, want, "{name}: {words:08x?}");
    }
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 148);
}

/// The carry-less products of twice the width are rows: `pmull` /
/// `pmull2` of bytes into halfwords and of doublewords into the 128-bit
/// lane, which hardware, clang's results, the interpreter and the
/// constant folder agree on.
#[cfg(feature = "linker")]
#[test]
fn the_polynomial_long_products_are_rows() {
    const SRC: &str = "#include <arm_neon.h>\n\
        #include <string.h>\n\
        static void ref64(unsigned long long x, unsigned long long y, unsigned long long *lo, unsigned long long *hi) {\n\
            unsigned long long l = 0, h = 0;\n\
            for (int k = 0; k < 64; k++) if (y >> k & 1) { l ^= x << k; if (k) h ^= x >> (64 - k); }\n\
            *lo = l; *hi = h;\n\
        }\n\
        static unsigned short ref8(unsigned char x, unsigned char y) { unsigned p = 0; for (int k = 0; k < 8; k++) if (y >> k & 1) p ^= (unsigned)x << k; return (unsigned short)p; }\n\
        int main(void) {\n\
            volatile unsigned long long s1 = 0x87654321fedcba98ULL, s2 = 0xf00d1234cafe5678ULL;\n\
            unsigned long long lo, hi;\n\
            poly128_t r = vmull_p64(s1, s2);\n\
            ref64(s1, s2, &lo, &hi);\n\
            unsigned long long w[2];\n\
            memcpy(w, &r, 16);\n\
            if (w[0] != lo || w[1] != hi) return 1;\n\
            poly64x2_t a = {s2, s1}, b = {s1 ^ 5, s2 + 3};\n\
            poly128_t r2 = vmull_high_p64(a, b);\n\
            ref64(s1, s2 + 3, &lo, &hi);\n\
            memcpy(w, &r2, 16);\n\
            if (w[0] != lo || w[1] != hi) return 2;\n\
            poly8x16_t c, d;\n\
            for (int i = 0; i < 16; i++) { c[i] = (unsigned char)(s1 >> (i * 3)); d[i] = (unsigned char)(s2 >> (i * 2)); }\n\
            poly16x8_t e = vmull_p8(vget_low_p8(c), vget_low_p8(d)), f = vmull_high_p8(c, d);\n\
            for (int i = 0; i < 8; i++) if (e[i] != ref8(c[i], d[i]) || f[i] != ref8(c[i + 8], d[i + 8])) return 3 + i;\n\
            return 42;\n\
        }\n";
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 42);
    const OPS: &str = "#include <arm_neon.h>\n\
        poly128_t m(poly64_t a, poly64_t b) { return vmull_p64(a, b); }\n\
        poly128_t h(poly64x2_t a, poly64x2_t b) { return vmull_high_p64(a, b); }\n\
        poly16x8_t b8(poly8x16_t a, poly8x16_t b) { return vmull_high_p8(a, b); }\n";
    let b8 = super::perf_codegen::a64_at(OPS, "b8", true);
    assert_eq!(b8, [0x4E21_E000, 0xD65F_03C0], "b8: {b8:08x?}");
    // A poly128_t returns in x0:x1: `pmull2`, `mov x0, v0.d[0]`,
    // `mov x1, v0.d[1]`.
    let h = super::perf_codegen::a64_at(OPS, "h", true);
    assert_eq!(
        h,
        [0x4EE1_E000, 0x4E08_3C00, 0x4E18_3C01, 0xD65F_03C0],
        "h: {h:08x?}"
    );
    let words = super::perf_codegen::a64_at(OPS, "m", true);
    assert!(words.contains(&0x0EE1_E000), "m: {words:08x?}");
}

/// `poly128_t` is the 128-bit unsigned integer the ACLE specifies: code
/// shifts, converts and compares it as one -- the high half of a product is
/// `pmull` and `mov x0, v0.d[1]` -- and a subscript of it is an error.
#[cfg(feature = "linker")]
#[test]
fn poly128_t_is_a_128_bit_integer() {
    const SRC: &str = "#include <arm_neon.h>\n\
        unsigned long long hi(poly64_t a, poly64_t b) { poly128_t r = vmull_p64(a, b); return (unsigned long long)(r >> 64); }\n\
        int zero(poly64_t a, poly64_t b) { return vmull_p64(a, b) == 0; }\n";
    let words = super::perf_codegen::a64_at(SRC, "hi", true);
    assert!(
        words.ends_with(&[0x0EE1_E000, 0x4E18_3C00, 0xD65F_03C0]),
        "hi: {words:08x?}"
    );
    let program = super::compile_str_bare_for(
        "#include <arm_neon.h>\n\
         int main(void) { poly128_t r = vmull_p64(0x8000000000000001ULL, 3); \
             return (unsigned long long)r == 0x8000000000000003ULL && (r >> 64) == 1 ? 0 : 1; }\n",
        crate::Target::LinuxAarch64,
    );
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    let err = crate::Compiler::with_target(
        "#include <arm_neon.h>\n\
         unsigned long long hi(poly64_t a, poly64_t b) { poly128_t r = vmull_p64(a, b); return r[1]; }\n"
            .to_string(),
        crate::Target::LinuxAarch64,
    )
    .compile()
    .err()
    .map(|e| e.to_string())
    .unwrap_or_default();
    assert!(err.contains("subscripted value"), "{err}");
}

/// The FEAT_SHA3 bitwise forms are rows: `eor3` and `bcax` over four
/// registers, `rax1` and `xar` over the 64-bit lanes. Hardware, clang and
/// the interpreter agree, and each is one instruction under -O.
#[cfg(feature = "linker")]
#[test]
fn the_sha3_bitwise_forms_are_rows() {
    const SRC: &str = "#include <arm_neon.h>\n\
        int main(void) {\n\
            volatile unsigned long long seed = 0x0123456789abcdefULL;\n\
            uint64x2_t a = {seed, seed * 3}, b = {seed ^ 0xff00ff00ff00ff00ULL, seed + 77}, c = {~seed, seed << 7};\n\
            uint64x2_t e = veor3q_u64(a, b, c), x = vbcaxq_u64(a, b, c), r = vrax1q_u64(a, b), y = vxarq_u64(a, b, 13);\n\
            for (int i = 0; i < 2; i++) {\n\
                if (e[i] != (a[i] ^ b[i] ^ c[i])) return 1;\n\
                if (x[i] != (a[i] ^ (b[i] & ~c[i]))) return 2;\n\
                if (r[i] != (a[i] ^ (b[i] << 1 | b[i] >> 63))) return 3;\n\
                unsigned long long t = a[i] ^ b[i];\n\
                if (y[i] != (t >> 13 | t << 51)) return 4;\n\
            }\n\
            uint8x16_t p = vreinterpretq_u8_u64(a), q = vreinterpretq_u8_u64(b), s = vreinterpretq_u8_u64(c);\n\
            uint8x16_t e8 = veor3q_u8(p, q, s);\n\
            for (int i = 0; i < 16; i++) if (e8[i] != (p[i] ^ q[i] ^ s[i])) return 5;\n\
            return 42;\n\
        }\n";
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 42);
    const OPS: &str = "#include <arm_neon.h>\n\
        uint64x2_t e(uint64x2_t a, uint64x2_t b, uint64x2_t c) { return veor3q_u64(a, b, c); }\n\
        uint64x2_t x(uint64x2_t a, uint64x2_t b, uint64x2_t c) { return vbcaxq_u64(a, b, c); }\n\
        uint64x2_t r(uint64x2_t a, uint64x2_t b) { return vrax1q_u64(a, b); }\n\
        uint64x2_t y(uint64x2_t a, uint64x2_t b) { return vxarq_u64(a, b, 13); }\n";
    for (name, want) in [
        ("e", 0xCE01_0800u32),
        ("x", 0xCE21_0800),
        ("r", 0xCE61_8C00),
        ("y", 0xCE81_3400),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The SHA-256 hash and schedule updates are rows: eight chained rounds
/// of each over a seeded state give the checksum AArch64 hardware and
/// clang give (34) in the interpreter, and each is one instruction under
/// -O, the hash naming its state halves as q registers.
#[cfg(feature = "linker")]
#[test]
fn the_sha256_updates_are_rows() {
    const SRC: &str = "#include <arm_neon.h>\n\
        int main(void) {\n\
            volatile unsigned seed = 0x9e3779b9u;\n\
            unsigned x = seed;\n\
            uint32x4_t a, b, w, s;\n\
            for (int i = 0; i < 4; i++) {\n\
                x = x * 1664525u + 1013904223u; a[i] = x;\n\
                x = x * 1664525u + 1013904223u; b[i] = x;\n\
                x = x * 1664525u + 1013904223u; w[i] = x;\n\
                x = x * 1664525u + 1013904223u; s[i] = x;\n\
            }\n\
            unsigned sum = 0;\n\
            for (int r = 0; r < 8; r++) {\n\
                uint32x4_t a2 = vsha256hq_u32(a, b, w);\n\
                uint32x4_t b2 = vsha256h2q_u32(b, a, w);\n\
                uint32x4_t s0 = vsha256su0q_u32(s, w);\n\
                uint32x4_t s1 = vsha256su1q_u32(s0, a2, b2);\n\
                a = a2; b = b2; w = s1; s = s0;\n\
                for (int i = 0; i < 4; i++) sum = sum * 33 + a[i] + 3 * b[i] + 5 * w[i] + 7 * s[i];\n\
            }\n\
            return (int)(sum % 251);\n\
        }\n";
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 34);
    const OPS: &str = "#include <arm_neon.h>\n\
        uint32x4_t h(uint32x4_t a, uint32x4_t b, uint32x4_t w) { return vsha256hq_u32(a, b, w); }\n\
        uint32x4_t h2(uint32x4_t a, uint32x4_t b, uint32x4_t w) { return vsha256h2q_u32(a, b, w); }\n\
        uint32x4_t s0(uint32x4_t a, uint32x4_t b) { return vsha256su0q_u32(a, b); }\n\
        uint32x4_t s1(uint32x4_t a, uint32x4_t b, uint32x4_t c) { return vsha256su1q_u32(a, b, c); }\n";
    for (name, want) in [
        ("h", 0x5E02_4020u32),
        ("h2", 0x5E02_5020),
        ("s0", 0x5E28_2820),
        ("s1", 0x5E02_6020),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The SHA-1 hash and schedule updates are rows: six chained rounds of
/// each over a seeded state give the checksum AArch64 hardware and clang
/// give (112) in the interpreter, and each is one instruction under -O
/// after `e` moves to an s register; `vsha1h_u32` is the rotation in a
/// general register.
#[cfg(feature = "linker")]
#[test]
fn the_sha1_updates_are_rows() {
    const SRC: &str = "#include <arm_neon.h>\n\
        int main(void) {\n\
            volatile unsigned seed = 0x7f4a7c15u;\n\
            unsigned x = seed;\n\
            uint32x4_t a, w, s, t;\n\
            for (int i = 0; i < 4; i++) {\n\
                x = x * 1664525u + 1013904223u; a[i] = x;\n\
                x = x * 1664525u + 1013904223u; w[i] = x;\n\
                x = x * 1664525u + 1013904223u; s[i] = x;\n\
                x = x * 1664525u + 1013904223u; t[i] = x;\n\
            }\n\
            unsigned e = x ^ 0x5a5a5a5au, sum = 0;\n\
            for (int r = 0; r < 6; r++) {\n\
                uint32x4_t c = vsha1cq_u32(a, e, w), p = vsha1pq_u32(c, e + 1, s), m = vsha1mq_u32(p, e + 2, t);\n\
                unsigned h = vsha1h_u32(e);\n\
                uint32x4_t s0 = vsha1su0q_u32(w, s, t), s1 = vsha1su1q_u32(s0, m);\n\
                a = m; e = h ^ c[1]; w = s1; s = s0; t = p;\n\
                for (int i = 0; i < 4; i++) sum = sum * 33 + c[i] + 3 * p[i] + 5 * m[i] + 7 * s0[i] + 11 * s1[i];\n\
                sum += h;\n\
            }\n\
            return (int)(sum % 251);\n\
        }\n";
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 112);
    const OPS: &str = "#include <arm_neon.h>\n\
        uint32x4_t c(uint32x4_t a, uint32_t e, uint32x4_t w) { return vsha1cq_u32(a, e, w); }\n\
        uint32x4_t s0(uint32x4_t a, uint32x4_t b, uint32x4_t w) { return vsha1su0q_u32(a, b, w); }\n\
        uint32x4_t s1(uint32x4_t a, uint32x4_t b) { return vsha1su1q_u32(a, b); }\n";
    const RET: u32 = 0xD65F_03C0;
    for (name, want) in [
        ("c", &[0x1E27_0002u32, 0x5E01_0040, RET][..]),
        ("s0", &[0x5E02_3020, RET]),
        ("s1", &[0x5E28_1820, RET]),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, want, "{name}: {words:08x?}");
    }
}

/// The SHA-512 hash and schedule updates are rows: eight chained rounds of
/// each over a seeded state give the checksum AArch64 hardware and clang
/// give (247) in the interpreter, and each is one instruction under -O.
#[cfg(feature = "linker")]
#[test]
fn the_sha512_updates_are_rows() {
    const SRC: &str = "#include <arm_neon.h>\n\
        int main(void) {\n\
            volatile unsigned long long seed = 0x9e3779b97f4a7c15ULL;\n\
            unsigned long long x = seed;\n\
            uint64x2_t a, b, w, s;\n\
            for (int i = 0; i < 2; i++) {\n\
                x = x * 6364136223846793005ULL + 1442695040888963407ULL; a[i] = x;\n\
                x = x * 6364136223846793005ULL + 1442695040888963407ULL; b[i] = x;\n\
                x = x * 6364136223846793005ULL + 1442695040888963407ULL; w[i] = x;\n\
                x = x * 6364136223846793005ULL + 1442695040888963407ULL; s[i] = x;\n\
            }\n\
            unsigned long long sum = 0;\n\
            for (int r = 0; r < 8; r++) {\n\
                uint64x2_t h = vsha512hq_u64(w, a, b);\n\
                uint64x2_t h2 = vsha512h2q_u64(h, b, a);\n\
                uint64x2_t s0 = vsha512su0q_u64(s, w);\n\
                uint64x2_t s1 = vsha512su1q_u64(s0, h, h2);\n\
                a = h; b = h2; w = s1; s = s0;\n\
                for (int i = 0; i < 2; i++) sum = sum * 33 + h[i] + 3 * h2[i] + 5 * s0[i] + 7 * s1[i];\n\
            }\n\
            return (int)(sum % 251);\n\
        }\n";
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 247);
    const OPS: &str = "#include <arm_neon.h>\n\
        uint64x2_t h(uint64x2_t a, uint64x2_t b, uint64x2_t c) { return vsha512hq_u64(a, b, c); }\n\
        uint64x2_t h2(uint64x2_t a, uint64x2_t b, uint64x2_t c) { return vsha512h2q_u64(a, b, c); }\n\
        uint64x2_t s0(uint64x2_t a, uint64x2_t b) { return vsha512su0q_u64(a, b); }\n\
        uint64x2_t s1(uint64x2_t a, uint64x2_t b, uint64x2_t c) { return vsha512su1q_u64(a, b, c); }\n";
    for (name, want) in [
        ("h", 0xCE62_8020u32),
        ("h2", 0xCE62_8420),
        ("s0", 0xCEC0_8020),
        ("s1", 0xCE62_8820),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The reciprocal and reciprocal square root estimates and their steps are
/// rows: the Arm ARM's 8-bit tables, the steps rounded once with infinity
/// times zero giving 2 or 1.5, a NaN operand propagated with the first one
/// negated, and the u32 forms' fractions. Over seeded lanes the
/// interpreter's results hash to the hardware's, and each is one
/// instruction under -O, the f64 forms the scalar d-register one.
#[cfg(feature = "linker")]
#[test]
fn the_estimates_and_steps_are_rows() {
    for fixture in [
        "arm_neon_float_estimates_and_steps.c",
        "arm_neon_estimates_on_seeded_lanes.c",
    ] {
        let src = super::load_fixture(fixture);
        let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
        let rc = super::Vm::new(program).run().expect("interpreted run");
        assert_eq!(rc, 0, "{fixture}: failing groups {rc:#x}");
    }
    const OPS: &str = "#include <arm_neon.h>\n\
        float32x4_t e(float32x4_t a) { return vrecpeq_f32(a); }\n\
        float64x1_t q(float64x1_t a) { return vrsqrte_f64(a); }\n\
        float32x2_t s(float32x2_t a, float32x2_t b) { return vrecps_f32(a, b); }\n\
        float64x2_t t(float64x2_t a, float64x2_t b) { return vrsqrtsq_f64(a, b); }\n\
        uint32x4_t u(uint32x4_t a) { return vrecpeq_u32(a); }\n\
        uint32x2_t v(uint32x2_t a) { return vrsqrte_u32(a); }\n";
    for (name, want) in [
        ("e", 0x4EA1_D800u32),
        ("q", 0x7EE1_D800),
        ("s", 0x0E21_FC00),
        ("t", 0x4EE1_FC00),
        ("u", 0x4EA1_C800),
        ("v", 0x2EA1_C800),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The compares against zero are rows of the `#0` forms: over seeded lanes
/// the interpreter's results hash to the hardware's, and each is one
/// instruction under -O, a 64-bit lane the scalar d-register form.
#[cfg(feature = "linker")]
#[test]
fn the_compares_against_zero_are_rows() {
    let src = super::load_fixture("arm_neon_compares_against_zero_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        uint32x4_t a(int32x4_t x) { return vceqzq_s32(x); }\n\
        uint8x8_t b(int8x8_t x) { return vcltz_s8(x); }\n\
        uint64x1_t c(int64x1_t x) { return vclez_s64(x); }\n\
        uint16x8_t d(int16x8_t x) { return vcgtzq_s16(x); }\n\
        uint64x2_t e(float64x2_t x) { return vcgezq_f64(x); }\n\
        uint32x4_t f(float32x4_t x) { return vclezq_f32(x); }\n\
        uint64x1_t g(float64x1_t x) { return vcltz_f64(x); }\n";
    for (name, want) in [
        ("a", 0x4EA0_9800u32),
        ("b", 0x0E20_A800),
        ("c", 0x7EE0_9800),
        ("d", 0x4E60_8800),
        ("e", 0x6EE0_C800),
        ("f", 0x6EA0_D800),
        ("g", 0x5EE0_E800),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// `vqshlu_n`, `vshll_n` and `vpadal` are rows: over seeded lanes the
/// interpreter's results hash to the hardware's, and each is one
/// instruction under -O -- `shll` for a shift by the lane width, and the
/// pairwise accumulation in its accumulator's register.
#[cfg(feature = "linker")]
#[test]
fn the_qshlu_shll_and_padal_forms_are_rows() {
    let src = super::load_fixture("arm_neon_qshlu_shll_and_padal_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        int16x8_t a(int8x8_t x) { return vshll_n_s8(x, 3); }\n\
        uint16x8_t b(uint8x8_t x) { return vshll_n_u8(x, 8); }\n\
        int64x2_t c(int32x4_t x) { return vshll_high_n_s32(x, 32); }\n\
        uint32x4_t d(uint32x4_t acc, uint16x8_t x) { return vpadalq_u16(acc, x); }\n\
        int64x1_t e(int64x1_t acc, int32x2_t x) { return vpadal_s32(acc, x); }\n\
        uint8x16_t f(int8x16_t x) { return vqshluq_n_s8(x, 3); }\n\
        uint64x1_t g(int64x1_t x) { return vqshlu_n_s64(x, 5); }\n";
    for (name, want) in [
        ("a", 0x0F0B_A400u32),
        ("b", 0x2E21_3800),
        ("c", 0x6EA1_3800),
        ("d", 0x6E60_6820),
        ("e", 0x0EA0_6820),
        ("f", 0x6F0B_6400),
        ("g", 0x7F45_6400),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The saturating narrowing shifts are rows: over seeded lanes the
/// interpreter's results hash to the hardware's, and each is one
/// instruction under -O.
#[cfg(feature = "linker")]
#[test]
fn the_saturating_narrowing_shifts_are_rows() {
    let src = super::load_fixture("arm_neon_saturating_narrowing_shifts_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        int8x8_t a(int16x8_t x) { return vqshrn_n_s16(x, 3); }\n\
        uint16x4_t b(int32x4_t x) { return vqrshrun_n_s32(x, 16); }\n\
        uint32x2_t c(uint64x2_t x) { return vqrshrn_n_u64(x, 7); }\n";
    for (name, want) in [
        ("a", 0x0F0D_9400u32),
        ("b", 0x2F10_8C00),
        ("c", 0x2F39_9C00),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The floating absolute difference, maxnum, minnum and mulx forms, the
/// pairwise forms and the reductions are rows: over seeded lanes with
/// NaNs, zeros and infinities the interpreter's results hash to the
/// hardware's, and each is one instruction under -O, `vaddvq_f32` two.
#[cfg(feature = "linker")]
#[test]
fn the_float_pairwise_and_maxnum_forms_are_rows() {
    let src = super::load_fixture("arm_neon_float_pairwise_and_maxnum_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        float32x4_t a(float32x4_t x, float32x4_t y) { return vabdq_f32(x, y); }\n\
        float64x1_t b(float64x1_t x, float64x1_t y) { return vmaxnm_f64(x, y); }\n\
        float32x2_t c(float32x2_t x, float32x2_t y) { return vpmaxnm_f32(x, y); }\n\
        float32_t d(float32x4_t x) { return vminnmvq_f32(x); }\n\
        float64_t f(float64x2_t x) { return vmaxvq_f64(x); }\n\
        float64x2_t g(float64x2_t x, float64x2_t y) { return vmulxq_f64(x, y); }\n\
        float32_t e(float32x4_t x) { return vaddvq_f32(x); }\n";
    for (name, want) in [
        ("a", &[0x6EA1_D400u32][..]),
        ("b", &[0x1E61_6800]),
        ("c", &[0x2E21_C400]),
        ("d", &[0x6EB0_C800]),
        ("f", &[0x6E60_F400]),
        ("g", &[0x4E61_DC00]),
        ("e", &[0x6E20_D400, 0x2E20_D400]),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words[..words.len() - 1], *want, "{name}: {words:08x?}");
    }
}

/// The roundings to an integral value are rows: over seeded lanes in two
/// rounding directions the interpreter's results and flags hash to the
/// hardware's, and each is one instruction under -O, a float64x1_t the
/// scalar d-register form.
#[cfg(feature = "linker")]
#[test]
fn the_roundings_are_rows() {
    let src = super::load_fixture("arm_neon_roundings_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        float32x4_t a(float32x4_t x) { return vrndnq_f32(x); }\n\
        float64x1_t b(float64x1_t x) { return vrndm_f64(x); }\n\
        float32x2_t c(float32x2_t x) { return vrnd32x_f32(x); }\n\
        float64x2_t d(float64x2_t x) { return vrnd64zq_f64(x); }\n\
        float32x4_t e(float32x4_t x) { return vrndaq_f32(x); }\n";
    for (name, want) in [
        ("a", 0x4E21_8800u32),
        ("b", 0x1E65_4000),
        ("c", 0x2E21_E800),
        ("d", 0x4E61_F800),
        ("e", 0x6E21_8800),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The conversions in each rounding direction and to and from fixed point
/// are rows: over seeded lanes the interpreter's results and flags hash
/// to the hardware's, and each is one instruction under -O, a float64x1_t
/// the scalar d-register form.
#[cfg(feature = "linker")]
#[test]
fn the_rounding_and_fixed_point_conversions_are_rows() {
    let src = super::load_fixture("arm_neon_conversions_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        int32x4_t a(float32x4_t x) { return vcvtnq_s32_f32(x); }\n\
        uint64x1_t b(float64x1_t x) { return vcvtp_u64_f64(x); }\n\
        float32x4_t c(int32x4_t x) { return vcvtq_n_f32_s32(x, 16); }\n\
        uint64x2_t d(float64x2_t x) { return vcvtq_n_u64_f64(x, 3); }\n\
        int64x1_t e(float64x1_t x) { return vcvta_s64_f64(x); }\n\
        float64x1_t f(uint64x1_t x) { return vcvt_n_f64_u64(x, 64); }\n";
    for (name, want) in [
        ("a", 0x4E21_A800u32),
        ("b", 0x7EE1_A800),
        ("c", 0x4F30_E400),
        ("d", 0x6F7D_FC00),
        ("e", 0x5E61_C800),
        ("f", 0x7F40_E400),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The doubling multiplies are rows: over seeded lanes with the extremes
/// that saturate the interpreter's results hash to the hardware's, and
/// each is one instruction under -O, an accumulating one in its
/// accumulator's register.
#[cfg(feature = "linker")]
#[test]
fn the_doubling_multiplies_are_rows() {
    let src = super::load_fixture("arm_neon_doubling_multiplies_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        int16x8_t a(int16x8_t x, int16x8_t y) { return vqdmulhq_s16(x, y); }\n\
        int32x2_t b(int32x2_t x, int32x2_t y) { return vqrdmulh_s32(x, y); }\n\
        int16x4_t c(int16x4_t acc, int16x4_t x, int16x4_t y) { return vqrdmlah_s16(acc, x, y); }\n\
        int64x2_t d(int32x4_t x, int32x4_t y) { return vqdmull_high_s32(x, y); }\n\
        int32x4_t e(int32x4_t acc, int16x4_t x, int16x4_t y) { return vqdmlsl_s16(acc, x, y); }\n";
    for (name, want) in [
        ("a", 0x4E61_B400u32),
        ("b", 0x2EA1_B400),
        ("c", 0x2E42_8420),
        ("d", 0x4EA1_D000),
        ("e", 0x0E62_B020),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The lane-indexed forms are by-element rows: over seeded lanes the
/// interpreter's results hash to the hardware's, and each is one
/// instruction under -O naming its lane; a halfword element in v16 or above,
/// which the encoding cannot name, is broadcast first and takes the vector
/// form, as at -O0. The float vmla multiplies and adds in two roundings.
#[cfg(feature = "linker")]
#[test]
fn the_lane_indexed_forms_are_by_element_rows() {
    let src = super::load_fixture("arm_neon_lane_indexed_forms_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        int16x8_t a(int16x8_t x, int16x8_t v) { return vmulq_laneq_s16(x, v, 5); }\n\
        int32x4_t b(int32x4_t acc, int32x4_t x, int32x2_t v) { return vmlaq_lane_s32(acc, x, v, 1); }\n\
        float32x4_t c(float32x4_t acc, float32x4_t x, float32x4_t v) { return vfmaq_laneq_f32(acc, x, v, 3); }\n\
        float64x1_t d(float64x1_t x, float64x2_t v) { return vmul_laneq_f64(x, v, 1); }\n\
        int32x4_t e(int16x8_t x, int16x8_t v) { return vmull_high_laneq_s16(x, v, 7); }\n\
        int64x2_t f(int64x2_t acc, int32x2_t x, int32x4_t v) { return vqdmlal_laneq_s32(acc, x, v, 2); }\n\
        float32x4_t m(float32x4_t acc, float32x4_t x, float32x2_t v) { return vmlaq_lane_f32(acc, x, v, 1); }\n";
    for (name, want) in [
        ("a", &[0x4F51_8800u32][..]),
        ("b", &[0x6FA2_0020]),
        ("c", &[0x4FA2_1820]),
        ("d", &[0x5FC1_9800]),
        ("e", &[0x4F71_A800]),
        ("f", &[0x0F82_3820]),
        ("m", &[0x4FA2_9021, 0x4E21_D400]),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words[..words.len() - 1], *want, "{name}: {words:08x?}");
    }
    let words = super::perf_codegen::a64_at(OPS, "a", false);
    assert!(
        words
            .windows(2)
            .any(|w| w[0] & 0xFFE0_FC00 == 0x4E00_0400 && w[1] & 0xFFE0_FC00 == 0x4E60_9C00),
        "a at -O0: a broadcast and the vector mul expected: {words:08x?}"
    );
}

/// The dot products and the FEAT_I8MM mixed-sign and matrix products are
/// rows: over seeded lanes the interpreter's results hash to the
/// hardware's (the I8MM fixture's on hardware that has it, which the M1
/// host lacks), and each is one instruction under -O, a lane form naming
/// its 4-byte group.
#[cfg(feature = "linker")]
#[test]
fn the_dot_products_are_rows() {
    for fixture in [
        "arm_neon_dot_products_on_seeded_lanes.c",
        "arm_neon_i8mm_dot_and_matrix_products.c",
    ] {
        let src = super::load_fixture(fixture);
        let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
        let rc = super::Vm::new(program).run().expect("interpreted run");
        assert_eq!(rc, 0, "{fixture}");
    }
    const OPS: &str = "#include <arm_neon.h>\n\
        uint32x4_t a(uint32x4_t r, uint8x16_t x, uint8x16_t y) { return vdotq_u32(r, x, y); }\n\
        int32x2_t b(int32x2_t r, int8x8_t x, int8x8_t y) { return vdot_s32(r, x, y); }\n\
        uint32x4_t c(uint32x4_t r, uint8x16_t x, uint8x16_t y) { return vdotq_laneq_u32(r, x, y, 3); }\n\
        int32x2_t d(int32x2_t r, int8x8_t x, int8x8_t y) { return vdot_lane_s32(r, x, y, 1); }\n\
        int32x4_t e(int32x4_t r, uint8x16_t x, int8x16_t y) { return vusdotq_s32(r, x, y); }\n\
        int32x4_t f(int32x4_t r, int8x16_t x, int8x16_t y) { return vmmlaq_s32(r, x, y); }\n\
        int32x4_t g(int32x4_t r, int8x16_t x, uint8x16_t y) { return vsudotq_laneq_s32(r, x, y, 2); }\n";
    for (name, want) in [
        ("a", 0x6E82_9420u32),
        ("b", 0x0E82_9420),
        ("c", 0x6FA2_E820),
        ("d", 0x0FA2_E020),
        ("e", 0x4E82_9C20),
        ("f", 0x4E82_A420),
        ("g", 0x4F02_F820),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The scalar FEAT_RDM lane forms are lane 0 of the vector ones: the
/// interpreter gives the values the hardware and clang give, saturated at
/// both ends.
#[test]
fn the_scalar_rdm_lane_forms_saturate_as_the_hardware_does() {
    const SRC: &str = "#include <arm_neon.h>\n\
        int main(void) {\n\
            int16x8_t v = {3, -7, 0x7fff, (int16_t)0x8000, 12345, -2, 99, -32767};\n\
            int32x4_t w = {0x40000000, (int32_t)0x80000000u, -5, 77};\n\
            if (vqrdmlahh_lane_s16(1000, (int16_t)0x8000, vget_low_s16(v), 3) != 32767) return 1;\n\
            if (vqrdmlshh_laneq_s16(-20000, 30000, v, 4) != -31302) return 2;\n\
            if (vqrdmlahs_laneq_s32(0x7ffffff0, 0x40000000, w, 0) != 2147483647) return 3;\n\
            if (vqrdmlshs_lane_s32(5, (int32_t)0x80000000u, vget_high_s32(w), 0) != 0) return 4;\n\
            return 0;\n\
        }\n";
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
}

/// The magnitude compares, the high-half narrowing sums and differences,
/// the saturating accumulates of the other signedness and the bit
/// reversal are rows: over seeded lanes the interpreter's results hash to
/// the hardware's, and each is one instruction under -O, `vcalt` the
/// `facgt` with its operands swapped.
#[cfg(feature = "linker")]
#[test]
fn the_magnitude_compares_and_high_narrowing_forms_are_rows() {
    let src = super::load_fixture(
        "arm_neon_magnitude_compares_high_narrowing_and_mixed_accumulates_on_seeded_lanes.c",
    );
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        uint32x4_t a(float32x4_t x, float32x4_t y) { return vcaltq_f32(x, y); }\n\
        int8x8_t b(int16x8_t x, int16x8_t y) { return vraddhn_s16(x, y); }\n\
        int32x4_t c(int32x4_t x, uint32x4_t y) { return vuqaddq_s32(x, y); }\n\
        uint8x16_t d(uint8x16_t x) { return vrbitq_u8(x); }\n\
        uint64x1_t e(float64x1_t x, float64x1_t y) { return vcage_f64(x, y); }\n";
    for (name, want) in [
        ("a", 0x6EA0_EC20u32),
        ("b", 0x2E21_4000),
        ("c", 0x4EA0_3820),
        ("d", 0x6E60_5800),
        ("e", 0x7E61_EC00),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The structure loads and stores move the bytes the instructions move,
/// on every element type at both widths: over seeded bytes the
/// interpreter's results hash to the hardware's. Two and four vectors
/// deinterleave by the permutes: `vld2q_u8` is two loads and `uzp1` /
/// `uzp2` under -O.
#[cfg(feature = "linker")]
#[test]
fn the_structure_loads_and_stores_move_the_instructions_bytes() {
    let src = super::load_fixture("arm_neon_structure_loads_and_stores_on_seeded_bytes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    let words = super::perf_codegen::a64_at(
        "#include <arm_neon.h>\nuint8x16x2_t a(const uint8_t *p) { return vld2q_u8(p); }\n",
        "a",
        true,
    );
    assert_eq!(
        words,
        [
            0x3DC0_0001u32,
            0x3DC0_0402,
            0x4E02_1820,
            0x4E02_5821,
            0xD65F_03C0
        ],
        "{words:08x?}"
    );
}

/// The table lookups in two to four registers and in 64-bit tables give
/// the hardware's bytes for indices in and past the tables: over seeded
/// lanes the interpreter's results hash to the hardware's. A lookup in two
/// 16-byte tables is `tbl` in the first and `tbx` in the second at the
/// index less 16.
#[cfg(feature = "linker")]
#[test]
fn the_multi_register_table_lookups_are_one_register_lookups_in_turn() {
    let src = super::load_fixture("arm_neon_multi_register_table_lookups_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    let words = super::perf_codegen::a64_at(
        "#include <arm_neon.h>\n\
         uint8x16_t a(uint8x16x2_t t, uint8x16_t i) { return vqtbl2q_u8(t, i); }\n",
        "a",
        true,
    );
    let tbl = |w: &u32| w & 0xFFE0_FC00 == 0x4E00_0000;
    let tbx = |w: &u32| w & 0xFFE0_FC00 == 0x4E00_1000;
    assert!(
        words.iter().any(tbl) && words.iter().any(tbx),
        "{words:08x?}"
    );
}

/// vqrshl, the round-to-odd vcvtx and the reciprocal exponent vrecpx are
/// rows: over seeded lanes the interpreter's results and flags hash to the
/// hardware's, and each is one instruction under -O, frecpx its scalar
/// form, the only one it has.
#[cfg(feature = "linker")]
#[test]
fn the_qrshl_cvtx_and_recpx_forms_are_rows() {
    let src = super::load_fixture("arm_neon_qrshl_cvtx_recpx_and_poly_forms_on_seeded_lanes.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    // Round to odd overflows only from 2^128 and underflows to the least
    // subnormal, as the M1 and clang give.
    const ODD: &str = "#include <arm_neon.h>\n#include <fenv.h>\n#include <string.h>\n\
        static int check(double x, unsigned want, int over, int under) {\n\
            feclearexcept(FE_ALL_EXCEPT);\n\
            float r = vcvtxd_f32_f64(x);\n\
            unsigned u;\n\
            memcpy(&u, &r, 4);\n\
            return u == want && !!fetestexcept(FE_OVERFLOW) == over\n\
                && !!fetestexcept(FE_UNDERFLOW) == under && fetestexcept(FE_INEXACT);\n\
        }\n\
        int main(void) {\n\
            if (!check(0x1.fffffff8p127, 0x7f7fffffu, 0, 0)) return 1;\n\
            if (!check(0x1p128, 0x7f7fffffu, 1, 0)) return 2;\n\
            if (!check(0x1p-151, 1u, 0, 1)) return 3;\n\
            if (!check(-0x1.0000003p+1, 0xc0000001u, 0, 0)) return 4;\n\
            return 0;\n\
        }\n";
    let program = super::compile_str_bare_for(ODD, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    const OPS: &str = "#include <arm_neon.h>\n\
        int8x16_t a(int8x16_t x, int8x16_t y) { return vqrshlq_s8(x, y); }\n\
        float32x2_t b(float64x2_t x) { return vcvtx_f32_f64(x); }\n\
        float64_t d(float64_t x) { return vrecpxd_f64(x); }\n\
        uint64x1_t e(uint64x1_t x, int64x1_t y) { return vqrshl_u64(x, y); }\n";
    for (name, want) in [
        ("a", 0x4E21_5C00u32),
        ("b", 0x2E61_6800),
        ("d", 0x5EE1_F800),
        ("e", 0x7EE1_5C00),
    ] {
        let words = super::perf_codegen::a64_at(OPS, name, true);
        assert_eq!(words, [want, 0xD65F_03C0], "{name}: {words:08x?}");
    }
}

/// The pairwise sum of two 64-bit lanes wraps, as `addp` does: the
/// interpreter computes it without overflowing its own arithmetic.
#[test]
fn a_pairwise_sum_of_64_bit_lanes_wraps() {
    const SRC: &str = "#include <arm_neon.h>\n\
        int main(void) {\n\
            int64x2_t a = {0x7fffffffffffffffLL, 1}, b = {-0x7fffffffffffffffLL - 1, -1};\n\
            int64x2_t r = vpaddq_s64(a, b);\n\
            if (r[0] != -0x7fffffffffffffffLL - 1 || r[1] != 0x7fffffffffffffffLL) return 1;\n\
            return vaddvq_s64(a) == -0x7fffffffffffffffLL - 1 ? 0 : 2;\n\
        }\n";
    let program = super::compile_str_bare_for(SRC, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
}

/// The scalar forms are lane 0 of the vector ones: over seeded values with
/// the saturating extremes the interpreter's results hash to the
/// hardware's, and `vqadds_s32` is the vector `sqadd` between the moves in
/// and out of v registers.
#[cfg(feature = "linker")]
#[test]
fn the_scalar_forms_are_lane_zero_of_the_vector_forms() {
    let src = super::load_fixture("arm_neon_scalar_forms_on_seeded_values.c");
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxAarch64);
    assert_eq!(super::Vm::new(program).run().expect("interpreted run"), 0);
    let words = super::perf_codegen::a64_at(
        "#include <arm_neon.h>\nint32_t f(int32_t a, int32_t b) { return vqadds_s32(a, b); }\n",
        "f",
        true,
    );
    assert!(
        words.contains(&0x0EA1_0C00),
        "sqadd v0.2s, v0.2s, v1.2s: {words:08x?}"
    );
}

/// `__ARM_NEON` is predefined on AArch64, and code keyed on it takes the
/// intrinsics: the 128-bit polynomial adds as an exclusive or and loads
/// and stores whole.
#[test]
fn neon_keyed_code_takes_the_intrinsics() {
    const SRC: &str = "#include <arm_neon.h>\n\
        #ifndef __ARM_NEON\n#error no NEON\n#endif\n\
        int main(void) {\n\
            poly128_t a = vreinterpretq_p128_u64((uint64x2_t){0xf0f0, 3}), b, c;\n\
            b = vreinterpretq_p128_u64((uint64x2_t){0x0ff0, 5});\n\
            vstrq_p128(&c, vaddq_p128(a, vldrq_p128(&b)));\n\
            uint64x2_t r = vreinterpretq_u64_p128(c);\n\
            return r[0] == 0xff00 && r[1] == 6 ? 0 : 1;\n\
        }\n";
    for target in [crate::Target::LinuxAarch64, crate::Target::MacOSAarch64] {
        let program = super::compile_str_bare_for(SRC, target);
        assert_eq!(
            super::Vm::new(program).run().expect("interpreted run"),
            0,
            "{target:?}"
        );
    }
}

/// `vld1`, `vst1`, `vdup_n` and `vld1_dup` are the load, store and
/// broadcast of their vector under `-O`, with no inline asm between them
/// and the operations that use them: `ldr q`, `str q`, `dup v0.4s, w0`,
/// `ldrh` and `dup v0.8h`, and in a loop the loads, `fmla` and the store
/// around a broadcast made before it.
#[cfg(feature = "linker")]
#[test]
fn the_loads_stores_and_broadcasts_are_their_instructions() {
    const SRC: &str = "#include <arm_neon.h>\n\
        uint8x16_t ld(const uint8_t *p) { return vld1q_u8(p); }\n\
        void st(uint8_t *p, uint8x16_t v) { vst1q_u8(p, v); }\n\
        uint32x4_t dup(uint32_t x) { return vdupq_n_u32(x); }\n\
        float32x4_t fdup(float x) { return vdupq_n_f32(x); }\n\
        uint16x8_t ldr(const uint16_t *p) { return vld1q_dup_u16(p); }\n\
        void axpy(float *y, const float *x, float a, int n) {\n\
            float32x4_t va = vdupq_n_f32(a);\n\
            for (int i = 0; i < n; i += 4)\n\
                vst1q_f32(y + i, vfmaq_f32(vld1q_f32(y + i), vld1q_f32(x + i), va));\n\
        }\n";
    const RET: u32 = 0xD65F_03C0;
    for (name, want) in [
        ("ld", &[0x3DC0_0000u32, RET][..]),
        ("st", &[0x3D80_0000, RET]),
        ("dup", &[0x4E04_0C00, RET]),
        ("fdup", &[0x4E04_0400, RET]),
        ("ldr", &[0x7940_0000, 0x4E02_0C00, RET]),
    ] {
        let words = super::perf_codegen::a64_at(SRC, name, true);
        assert_eq!(words, want, "{name}: {words:08x?}");
    }
    let words = super::perf_codegen::a64_at(SRC, "axpy", true);
    let fmla = words.iter().position(|w| w & 0xFFE0_FC00 == 0x4E20_CC00);
    let dup = words.iter().position(|w| w & 0xFFFF_FC00 == 0x4E04_0400);
    assert!(
        dup.is_some_and(|d| fmla.is_some_and(|f| d < f)) && words.len() <= 16,
        "axpy: {words:08x?}"
    );
}

/// A half of a 128-bit vector is its 64-bit lane, and two halves combine
/// into one register: `mov d, v.d[1]`, nothing for the low half, `ins` and
/// `zip1`.
#[cfg(feature = "linker")]
#[test]
fn the_halves_and_their_combination_are_lane_moves() {
    const SRC: &str = "#include <arm_neon.h>\n\
        uint8x8_t lo(uint8x16_t a) { return vget_low_u8(a); }\n\
        float32x2_t hi(float32x4_t a) { return vget_high_f32(a); }\n\
        int16x8_t comb(int16x4_t a, int16x4_t b) { return vcombine_s16(a, b); }\n\
        int16x8_t swap(int16x4_t a, int16x4_t b) { return vcombine_s16(b, a); }\n\
        float32x4_t mix(float32x4_t a, float32x4_t b) {\n\
            return vcombine_f32(vget_high_f32(a), vget_low_f32(b));\n\
        }\n";
    const RET: u32 = 0xD65F_03C0;
    for (name, want) in [
        ("lo", &[RET][..]),
        ("hi", &[0x5E18_0400, RET]),
        ("comb", &[0x6E18_0420, RET]),
        ("swap", &[0x4EC0_3820, RET]),
    ] {
        let words = super::perf_codegen::a64_at(SRC, name, true);
        assert_eq!(words, want, "{name}: {words:08x?}");
    }
    let words = super::perf_codegen::a64_at(SRC, "mix", true);
    assert!(words.len() <= 3, "mix: {words:08x?}");
}

/// The lane writes, lane loads and stores and 64-bit lane broadcasts are
/// subscripts of the vector in its register: `ins` of the lane, `ld1` /
/// `st1` of one lane through the pointer, `str` of lane 0 and
/// `mov d, v.d[1]`, with nothing for lane 0 of a 64-bit broadcast.
#[cfg(feature = "linker")]
#[test]
fn the_lane_writes_stores_and_broadcasts_are_register_moves() {
    const SRC: &str = "#include <arm_neon.h>\n\
        float32x4_t setf(float32x4_t v, float x) { return vsetq_lane_f32(x, v, 3); }\n\
        uint16x8_t ld16(const uint16_t *p, uint16x8_t v) { return vld1q_lane_u16(p, v, 6); }\n\
        float32x4_t ldf(const float *p, float32x4_t v) { return vld1q_lane_f32(p, v, 2); }\n\
        void st32(uint32_t *p, uint32x4_t v) { vst1q_lane_u32(p, v, 3); }\n\
        void stf0(float *p, float32x4_t v) { vst1q_lane_f32(p, v, 0); }\n\
        void std1(double *p, float64x2_t v) { vst1q_lane_f64(p, v, 1); }\n\
        int64x1_t dup64(int64x2_t v) { return vdup_laneq_s64(v, 1); }\n\
        float64x1_t dupf(float64x2_t v) { return vdup_laneq_f64(v, 0); }\n";
    const RET: u32 = 0xD65F_03C0;
    for (name, want) in [
        ("setf", &[0x6E1C_0420u32, RET][..]),
        ("ld16", &[0x4D40_5000, RET]),
        ("ldf", &[0x4D40_8000, RET]),
        ("st32", &[0x4D00_9000, RET]),
        ("stf0", &[0xBD00_0000, RET]),
        ("std1", &[0x4D00_8400, RET]),
        ("dup64", &[0x5E18_0400, RET]),
        ("dupf", &[RET]),
    ] {
        let words = super::perf_codegen::a64_at(SRC, name, true);
        assert_eq!(words, want, "{name}: {words:08x?}");
    }
}

/// A lane of an 8-byte vector is read and written in its register, as a
/// 16-byte vector's is: `smov` and `ins` on the D register.
#[cfg(feature = "linker")]
#[test]
fn an_8_byte_vector_lane_stays_in_its_register() {
    use crate::{NativeOptions, Target};
    let src = "typedef short v4h __attribute__((vector_size(8)));\n\
        int loc(v4h a, v4h b) { v4h v = a + b; return v[3]; }\n\
        v4h setl(v4h a, v4h b, short x) { v4h v = a + b; v[2] = x; return v; }\n\
        int main(void) { return 0; }";
    let program = super::compile_str_bare_for(src, Target::LinuxAarch64);
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxAarch64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit_native for linux-aarch64");
    for (word, what) in [
        (0x4e0e_2c00u32, "smov x0, v0.h[3]"),
        (0x4e0a_1c00, "mov v0.h[2], w0"),
    ] {
        let needle = word.to_le_bytes();
        assert!(
            bytes.windows(4).any(|w| w == needle),
            "{what}: expected {word:#010x} in the emitted code"
        );
    }
}

/// An automatic object of an SVE type takes the vector length of storage
/// (an eighth of it for `svbool_t`) from the alloca arena, and assignment
/// and initialization copy it through a register of its kind. The copy
/// holds across a call, the value staying in its object, which `&x`
/// addresses, and a loop allocates it afresh each iteration within one
/// frame. The interpreter runs it at four vector lengths.
#[test]
fn sve_objects_take_the_vector_length_and_copy_whole() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/objects_copy_whole.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
}

/// SVE values live across calls, swap through phis, outnumber the registers
/// and merge beside objects that keep storage, at four vector lengths.
#[test]
fn sve_values_survive_calls_and_register_exhaustion() {
    for src in [
        include_str!("../../../tests/fixtures/sve/values_across_calls.c"),
        include_str!("../../../tests/fixtures/sve/values_exhaust_registers.c"),
        include_str!("../../../tests/fixtures/sve/values_merge_with_memory.c"),
    ] {
        let program = crate::Compiler::with_options(
            String::from(src),
            crate::Target::LinuxAarch64,
            Default::default(),
        )
        .compile()
        .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(vm.run().expect("runs"), bits as i64 / 128, "{bits} bits");
        }
    }
}

/// Under `-O` an SVE object whose address is not taken takes no storage.
/// Across a call it takes a slot of the VL-scaled region: forty vectors and
/// twenty predicates take 43 vector lengths, and none takes z8-z15.
#[cfg(feature = "linker")]
#[test]
fn sve_values_without_an_address_take_registers_and_vl_slots() {
    let words = |src: &str, name: &str| super::perf_codegen::a64_at(src, name, true);
    let count = |w: &[u32], mask: u32, want: u32| w.iter().filter(|&&x| x & mask == want).count();
    // ADDVL sp, sp, #imm and its immediate.
    let addvl = |w: &[u32]| -> i32 {
        (w.iter().filter(|&&x| x & 0xFFFF_F81F == 0x043F_501F))
            .map(|&x| ((x >> 5 & 0x3F) as i32) << 26 >> 26)
            .sum()
    };
    let swap = words(
        include_str!("../../../tests/fixtures/sve/values_across_calls.c"),
        "swap",
    );
    for (mask, want, what) in [
        (0xFFFF_FFE0, 0x0420_E3E0, "cntb"),
        (0xFFFF_FFE0, 0x04E0_E3E0, "cntd"),
    ] {
        assert_eq!(count(&swap, mask, want), 0, "{what}: {swap:08x?}");
    }
    assert!(addvl(&swap) < 0, "addvl: {swap:08x?}");
    // STR p, [x, #-k, mul vl] and STR z, [x, #-k, mul vl].
    assert!(
        count(&swap, 0xFFE0_E010, 0xE5A0_0000) > 0,
        "str p: {swap:08x?}"
    );
    assert!(
        count(&swap, 0xFFE0_E000, 0xE5A0_4000) > 0,
        "str z: {swap:08x?}"
    );
    let reverse = words(
        include_str!("../../../tests/fixtures/sve/values_exhaust_registers.c"),
        "reverse",
    );
    assert_eq!(addvl(&reverse), -43, "{reverse:08x?}");
    // LDR z, [x, #imm, mul vl] into z8-z15.
    let callee_saved =
        |x: &&u32| *x & 0xFFC0_E000 == 0x8580_4000 && (8..=15).contains(&(*x & 0x1F));
    assert_eq!(
        reverse.iter().filter(callee_saved).count(),
        0,
        "a vector across the call in z8-z15: {reverse:08x?}"
    );
}

/// A vector slot more than 256 vector lengths into the region, past the
/// reach of `[base, #imm, mul vl]`, takes its base from `addvl`.
#[cfg(feature = "linker")]
#[test]
fn far_sve_slots_step_the_base_with_addvl() {
    let mut src =
        String::from("#include <arm_sve.h>\nvoid many(svint8_t *const *s, svint8_t *const *d) {\n");
    for i in 0..300 {
        src += &format!("    svint8_t v{i} = *s[{i}];\n");
    }
    for i in 0..300 {
        src += &format!("    *d[{i}] = v{i};\n");
    }
    src += "}\n";
    let object =
        super::perf_codegen::object_with_pool(&src, crate::Target::LinuxAarch64, (usize::MAX, 0));
    let w = super::codegen::function_words(&object, "many");
    // ADDVL x16 / x17, xn, #-k, and the slot accesses' offsets.
    let steps = w
        .iter()
        .filter(|&&x| x & 0xFFE0_F81E == 0x0420_5010)
        .count();
    assert!(steps > 0, "addvl into an IP register: none");
    let reach = (w.iter())
        .filter(|&&x| x & 0xFFC0_E000 == 0x8580_4000 || x & 0xFFC0_E000 == 0xE580_4000)
        .all(|&x| {
            let imm = ((x >> 16 & 0x3F) << 3 | (x >> 10 & 7)) as i32;
            imm << 23 >> 23 >= -256
        });
    assert!(reach);
}

/// `&x` of an SVE object is a pointer to it: passed to a function, the
/// argument register takes the object's base.
#[cfg(feature = "linker")]
#[test]
fn an_sve_object_s_address_is_a_pointer_argument() {
    const SRC: &str = "#include <arm_sve.h>\n\
        void g(svint32_t *dst, svint32_t *src, void (*f)(svint32_t *)) {\n\
            svint32_t kept = *src; f(&kept); *dst = kept; }\n";
    let w = super::perf_codegen::a64_at(SRC, "g", true);
    // STR z, [xb] into the object, then MOV x0, xb ahead of BLR.
    let base = (w.iter().find(|&&x| x & 0xFFFF_FC00 == 0xE580_4000))
        .map(|&x| x >> 5 & 0x1F)
        .expect("str z");
    let call = w
        .iter()
        .position(|&x| x & 0xFFFF_FC1F == 0xD63F_0000)
        .expect("blr");
    assert!(w[..call].contains(&(0xAA00_03E0 | base << 16)), "{w:08x?}");
}

/// The SVE object's storage is the vector length (`cntb`) or the
/// predicate length (`cntd`) of bytes, and a copy is `ldr` and `str` of a
/// whole Z or P register, the value's own.
#[cfg(feature = "linker")]
#[test]
fn sve_copies_are_whole_register_loads_and_stores() {
    const SRC: &str = "#include <arm_sve.h>\n\
        void copy(svint32_t *dst, svint32_t *src, void (*f)(void)) { svint32_t x = *src; svint32_t *px = &x; f(); *dst = *px; }\n\
        void copyp(svbool_t *dst, svbool_t *src) { svbool_t p = *src; svbool_t *pp = &p; *dst = *pp; }\n";
    let has = |w: &[u32], mask: u32, want: u32| w.iter().filter(|&&x| x & mask == want).count();
    let z = super::perf_codegen::a64_at(SRC, "copy", true);
    assert_eq!(has(&z, 0xFFFF_FFE0, 0x0420_E3E0), 1, "cntb: {z:08x?}");
    assert_eq!(has(&z, 0xFFFF_FC00, 0x8580_4000), 2, "ldr z: {z:08x?}");
    assert_eq!(has(&z, 0xFFFF_FC00, 0xE580_4000), 2, "str z: {z:08x?}");
    let p = super::perf_codegen::a64_at(SRC, "copyp", true);
    assert_eq!(has(&p, 0xFFFF_FFE0, 0x04E0_E3E0), 1, "cntd: {p:08x?}");
    assert_eq!(has(&p, 0xFFFF_FC10, 0x8580_0000), 2, "ldr p: {p:08x?}");
    assert_eq!(has(&p, 0xFFFF_FC10, 0xE580_0000), 2, "str p: {p:08x?}");
}

/// With no FP register to take, an SVE vector spills to the VL-scaled
/// region, one vector length `addvl` reserves, at `[base, #-1, mul vl]`.
#[cfg(feature = "linker")]
#[test]
fn sve_vectors_spill_to_the_vl_scaled_region() {
    const SRC: &str = "#include <arm_sve.h>\n\
        void copy(svint32_t *dst, svint32_t *src) { *dst = *src; }\n";
    let object =
        super::perf_codegen::object_with_pool(SRC, crate::Target::LinuxAarch64, (usize::MAX, 0));
    let w = super::codegen::function_words(&object, "copy");
    let has = |mask: u32, want: u32| w.iter().filter(|&&x| x & mask == want).count();
    assert_eq!(
        has(0xFFFF_FFFF, 0x043F_57FF),
        1,
        "addvl sp, sp, #-1: {w:08x?}"
    );
    assert_eq!(
        has(0xFFFF_FC00, 0xE5BF_5C00),
        1,
        "str z, [x, #-1, mul vl]: {w:08x?}"
    );
    assert_eq!(
        has(0xFFFF_FC00, 0x85BF_5C00),
        1,
        "ldr z, [x, #-1, mul vl]: {w:08x?}"
    );
}

/// SVE arguments, parameters and results cross calls by the SVE procedure
/// call standard; the interpreter runs the fixture at four vector lengths.
#[test]
fn sve_arguments_and_results_follow_the_sve_pcs() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/pcs_arguments.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
}

/// AAPCS64 6.8.2: a vector argument takes z[NSRN], which the
/// floating-point arguments advance too, and a predicate p[NPRN]; past z7
/// and p3 the caller passes the address of a copy in its VL-scaled region,
/// in x[NGRN] or on the stack. Each callee reads its arguments there.
#[cfg(feature = "linker")]
#[test]
fn sve_arguments_take_z_and_p_registers_or_a_copy_s_address() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/pcs_arguments.c");
    let has = |w: &[u32], mask: u32, want: u32| w.iter().any(|&x| x & mask == want);
    // `mixed(int, double, a, p, b, double, q, c)`: a, b and c in z1, z2 and
    // z4, p and q in p0 and p1.
    let mixed = super::perf_codegen::a64_at(SRC, "mixed", true);
    for (word, what) in [
        (0x0461_3020, "mov z0.d, z1.d"),
        (0x0462_3040, "mov z0.d, z2.d"),
        (0x0464_3080, "mov z0.d, z4.d"),
    ] {
        assert!(mixed.contains(&word), "{what}: {mixed:08x?}");
    }
    assert!(
        has(&mixed, 0xFFFF_FC1F, 0xE580_0000),
        "str p0: {mixed:08x?}"
    );
    assert!(
        has(&mixed, 0xFFFF_FC1F, 0xE580_0001),
        "str p1: {mixed:08x?}"
    );
    // `nth`'s ninth to eleventh vectors and `nthp`'s fifth and sixth
    // predicates through x1-x3: LDR z / p, [xn].
    let nth = super::perf_codegen::a64_at(SRC, "nth", true);
    for n in 1..=3 {
        assert!(
            has(&nth, 0xFFFF_FFE0, 0x8580_4000 | n << 5),
            "x{n}: {nth:08x?}"
        );
    }
    let nthp = super::perf_codegen::a64_at(SRC, "nthp", true);
    for n in 1..=2 {
        assert!(
            has(&nthp, 0xFFFF_FFF0, 0x8580_0000 | n << 5),
            "x{n}: {nthp:08x?}"
        );
    }
    // `far`'s copy address on the stack: LDR xt, [x29, #16], then LDR z, [xt].
    let far = super::perf_codegen::a64_at(SRC, "far", true);
    let at = (far.iter().position(|&x| x & 0xFFFF_FFE0 == 0xF940_0BA0)).expect("ldr x, [x29, #16]");
    assert!(
        far[at + 1] & 0xFFFF_FFE0 == 0x8580_4000 | (far[at] & 0x1F) << 5,
        "{far:08x?}"
    );
    // The caller makes the copies: ADDVL x1-x3 and ADDPL x1-x2 at the
    // calls, and the stack copy's address through x16.
    let main = super::perf_codegen::a64_at(SRC, "main", true);
    for n in 1..=3 {
        assert!(
            has(&main, 0xFFE0_F81F, 0x0420_5000 | n),
            "addvl x{n}: {main:08x?}"
        );
    }
    for n in 1..=2 {
        assert!(
            has(&main, 0xFFE0_F81F, 0x0460_5000 | n),
            "addpl x{n}: {main:08x?}"
        );
    }
    assert!(main.contains(&0xF900_03F0), "str x16, [sp]: {main:08x?}");
}

/// A function following the SVE PCS preserves z8-z23 and p4-p15 whole
/// (AAPCS64 6.1.3, 6.1.4): all of them where it calls a function of the
/// base standard, those it writes where it does not, and none where its
/// values stay in z0-z7 and z24-z31. `aarch64_sve_pcs` declares the
/// standard for a function of no SVE type. A vector across the base
/// standard's call takes a slot, not z8-z15.
#[cfg(feature = "linker")]
#[test]
fn sve_pcs_functions_preserve_z8_to_z23_and_p4_to_p15() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/pcs_preserves.c");
    // STR z / p, [xn, #imm, mul vl] of a register the standard preserves.
    let saves = |w: &[u32]| {
        let z = (w.iter())
            .filter(|&&x| x & 0xFFC0_E000 == 0xE580_4000 && (8..=23).contains(&(x & 0x1F)))
            .count();
        let p = (w.iter())
            .filter(|&&x| x & 0xFFC0_E010 == 0xE580_0000 && (4..=15).contains(&(x & 0xF)))
            .count();
        (z, p)
    };
    let across = super::perf_codegen::a64_at(SRC, "across", true);
    assert_eq!(saves(&across), (16, 12), "{across:08x?}");
    let call = across.iter().position(|&x| x >> 26 == 0x25).expect("bl");
    // MOV z0.d, zn.d from z8-z15 after the call.
    let held = |x: &&u32| *x & 0xFFE0_FC1F == 0x0460_3000 && (8..=15).contains(&(*x >> 16 & 0x1F));
    assert_eq!(
        across[call..].iter().filter(held).count(),
        0,
        "{across:08x?}"
    );
    let many = super::perf_codegen::a64_at(SRC, "many", true);
    let (z, p) = saves(&many);
    assert!(z > 0 && z < 16 && p > 0 && p < 12, "{many:08x?}");
    let mixed = super::perf_codegen::a64_at(
        include_str!("../../../tests/fixtures/sve/pcs_arguments.c"),
        "mixed",
        true,
    );
    assert_eq!(saves(&mixed), (0, 0), "{mixed:08x?}");
    const ATTR: &str = "double g(double);\n\
        void __attribute__((aarch64_sve_pcs)) f(double *x) { *x = g(*x); }\n\
        void __attribute__((aarch64_sve_pcs)) leaf(double *x) { *x = *x * 2.0; }\n";
    let f = super::perf_codegen::a64_at(ATTR, "f", true);
    assert_eq!(saves(&f), (16, 12), "{f:08x?}");
    let leaf = super::perf_codegen::a64_at(ATTR, "leaf", true);
    assert_eq!(saves(&leaf), (0, 0), "{leaf:08x?}");
}

/// The first ACLE SVE intrinsics -- svwhilelt loops stepped by svcnt*,
/// svld1, svst1, svadd, svsub and svmul in each predication form and with a
/// scalar operand, the compares, svaddv and svptrue -- compute what scalar C
/// does; the interpreter runs the fixture at four vector lengths.
#[test]
fn the_first_sve_rows_run_in_the_interpreter() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_basic.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
}

/// Each SVE intrinsic is its instruction on the argument registers under
/// `-O`: the don't-care form the unpredicated one where SVE has it, the
/// zeroing form `movprfx` of the governed lanes, the merging form into a
/// destination holding its second operand through a scratch; an unsigned
/// compare `cmphi`, an unsigned `svwhilelt` `whilelo`.
#[cfg(feature = "linker")]
#[test]
fn the_sve_rows_emit_their_instructions() {
    const SRC: &str = "#include <arm_sve.h>\n\
        svint32_t add_m(svbool_t pg, svint32_t a, svint32_t b) { return svadd_m(pg, a, b); }\n\
        svint32_t add_x(svbool_t pg, svint32_t a, svint32_t b) { return svadd_x(pg, a, b); }\n\
        svint32_t sub_z(svbool_t pg, svint32_t a, svint32_t b) { return svsub_z(pg, a, b); }\n\
        svint32_t sub_m(svbool_t pg, svint32_t a, svint32_t b) { return svsub_m(pg, b, a); }\n\
        svint16_t mul_x(svbool_t pg, svint16_t a, svint16_t b) { return svmul_x(pg, a, b); }\n\
        svbool_t gt(svbool_t pg, svuint8_t a, svuint8_t b) { return svcmpgt(pg, a, b); }\n\
        svbool_t wl(long i, long n) { return svwhilelt_b32(i, n); }\n\
        svbool_t wlo(unsigned i, unsigned n) { return svwhilelt_b8(i, n); }\n\
        uint64_t cw(void) { return svcntw(); }\n\
        int64_t sum(svbool_t pg, svint16_t a) { return svaddv(pg, a); }\n\
        float fsum(svbool_t pg, svfloat32_t a) { return svaddv(pg, a); }\n\
        svfloat64_t ld(svbool_t pg, const double *p) { return svld1(pg, p); }\n\
        void st(svbool_t pg, float *p, svfloat32_t v) { svst1(pg, p, v); }\n\
        svbool_t pt(void) { return svptrue_pat_b16(SV_VL4); }\n\
        svint64_t dup(long x) { return svdup_n_s64(x); }\n\
        svfloat32_t fdup(float x) { return svdup_f32(x); }\n";
    let object = super::perf_codegen::object_at(SRC, crate::Target::LinuxAarch64, true);
    for (name, words, what) in [
        ("add_m", &[0x0480_0020u32][..], "add z0.s, p0/m, z0.s, z1.s"),
        ("add_x", &[0x04a1_0000], "add z0.s, z0.s, z1.s"),
        (
            "sub_z",
            &[0x0490_2000, 0x0481_0020],
            "movprfx z0.s, p0/z, z0.s; sub",
        ),
        ("mul_x", &[0x0450_0020], "mul z0.h, p0/m, z0.h, z1.h"),
        ("gt", &[0x2401_0010], "cmphi p0.b, p0/z, z0.b, z1.b"),
        ("wl", &[0x25a1_1400], "whilelt p0.s, x0, x1"),
        ("wlo", &[0x2521_0c00], "whilelo p0.b, w0, w1"),
        ("cw", &[0x04a0_e3e0], "cntw x0"),
        ("fsum", &[0x6580_2000], "faddv s0, p0, z0.s"),
        ("ld", &[0xa5e0_a000], "ld1d {z0.d}, p0/z, [x0]"),
        ("st", &[0xe540_e000], "st1w {z0.s}, p0, [x0]"),
        ("pt", &[0x2558_e080], "ptrue p0.h, vl4"),
        ("dup", &[0x05e0_3800], "mov z0.d, x0"),
        ("fdup", &[0x0524_2000], "mov z0.s, s0"),
    ] {
        let w = super::codegen::function_words(&object, name);
        assert!(
            w.windows(words.len()).any(|x| x == words),
            "{what}: {w:08x?}"
        );
    }
    // `svsub_m(pg, b, a)` into z0, which holds `a`: MOVPRFX zt, z1; SUB zt,
    // p0/m, zt, z0; MOV z0.d, zt.d.
    let w = super::codegen::function_words(&object, "sub_m");
    assert!(
        w[0] & 0xFFFF_FFE0 == 0x0420_BC20 && w[1] & 0xFFFF_FFE0 == 0x0481_0000,
        "{w:08x?}"
    );
    // SADDV d, p0, z0.h, then FMOV x0 from that d.
    let w = super::codegen::function_words(&object, "sum");
    let d = w[0] & 0x1F;
    assert!(
        w[0] & 0xFFFF_FFE0 == 0x0440_2000 && w[1] == 0x9E66_0000 | d << 5,
        "{w:08x?}"
    );
}

/// A predicate that governs an instruction takes p0-p6; one live across a
/// call, in its slot, is reloaded into p7 for the store it governs.
#[cfg(feature = "linker")]
#[test]
fn a_governing_predicate_takes_p0_to_p6_or_is_reloaded_into_p7() {
    const SRC: &str = "#include <arm_sve.h>\n\
        void keep(svbool_t *pp, svint32_t *v, int32_t *p, void (*f)(void)) {\n\
            svbool_t pg = *pp; svint32_t x = *v; f(); svst1(pg, p, x); }\n";
    let w = super::perf_codegen::a64_at(SRC, "keep", true);
    // LDR p7, [x, #imm, mul vl], then ST1W {z.s}, p7, [x].
    let reload = w
        .iter()
        .position(|&x| x & 0xFFC0_E01F == 0x8580_0007)
        .expect("ldr p7");
    assert!(
        w[reload..].iter().any(|&x| x & 0xFFFF_FC00 == 0xE540_FC00),
        "{w:08x?}"
    );
}

/// svand, svorr and sveor in each predication form and with a scalar
/// operand, the predicate logic svand_b_z to svnot_b_z, svsel of vectors
/// and of predicates, and svptest compute what scalar C does; the
/// interpreter runs the fixture at four vector lengths.
#[test]
fn the_sve_logic_select_and_test_rows_run_in_the_interpreter() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_logic.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
}

/// svdiv, svmin, svmax, svminnm, svmaxnm and svbic in each predication form
/// and with a scalar operand, and svnot, svabs and svneg in each form,
/// compute what scalar C does over integer and floating lanes; the
/// interpreter runs the fixture at four vector lengths.
#[test]
fn the_sve_arithmetic_rows_run_in_the_interpreter() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_arith.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
}

/// svlsl, svlsr and svasr shift by an unsigned vector of counts or a
/// scalar in each predication form, a count of the lane width or more
/// shifting every bit out or the sign in, as scalar C computes; the
/// interpreter runs the fixture at four vector lengths. Under `-O` a shift
/// is its destructive instruction, and one into its count's register the
/// reversed LSLR, LSRR or ASRR; a signed count does not convert.
#[test]
fn the_sve_shift_rows_take_unsigned_counts() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_shift.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    let err = crate::Compiler::with_target(
        String::from(
            "#include <arm_sve.h>\n\
             svint32_t f(svbool_t pg, svint32_t a) { return svlsl_x(pg, a, a); }\n",
        ),
        crate::Target::LinuxAarch64,
    )
    .compile()
    .err()
    .map(|e| e.to_string())
    .unwrap_or_default();
    assert!(err.contains("types differ in the operand 3"), "{err}");
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            svint32_t lsl_x(svbool_t pg, svint32_t a, svuint32_t c) { return svlsl_x(pg, a, c); }\n\
            svint16_t lsl_r(svbool_t pg, svuint16_t c, svint16_t a) { return svlsl_z(pg, a, c); }\n\
            svuint8_t lsr_m(svbool_t pg, svuint8_t a, svuint8_t c) { return svlsr_m(pg, a, c); }\n\
            svint64_t asr_r(svbool_t pg, svuint64_t c, svint64_t a) { return svasr_x(pg, a, c); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        // LSL z0.s, p0/m, z0.s, z1.s.
        assert_eq!(words("lsl_x"), [0x0493_8020, RET]);
        // MOVPRFX z0.h, p0/z, z0.h; LSLR z0.h, p0/m, z0.h, z1.h.
        assert_eq!(words("lsl_r"), [0x0450_2000, 0x0457_8020, RET]);
        // LSR z0.b, p0/m, z0.b, z1.b.
        assert_eq!(words("lsr_m"), [0x0411_8020, RET]);
        // ASRR z0.d, p0/m, z0.d, z1.d.
        assert_eq!(words("asr_r"), [0x04D4_8020, RET]);
    }
}

/// svmaxv, svminv, svmaxnmv, svminnmv, svandv, svorv and sveorv reduce the
/// active lanes into a value of the lane's type, the operation's identity
/// with none active, as scalar C computes; the interpreter runs the fixture
/// at four vector lengths. Under `-O` a narrow integer reduction moves its
/// lane into the register extended as its type is, SMOV or UMOV, which
/// leaves the return no extension or mask of its own; a doubleword one is
/// FMOV and a floating one stays in its register.
#[test]
fn the_sve_reductions_take_their_lanes_type() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_reduce.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            int8_t maxv(svbool_t pg, svint8_t a) { return svmaxv(pg, a); }\n\
            uint32_t orv(svbool_t pg, svuint32_t a) { return svorv(pg, a); }\n\
            int64_t eorv(svbool_t pg, svint64_t a) { return sveorv(pg, a); }\n\
            float fmaxv(svbool_t pg, svfloat32_t a) { return svmaxv(pg, a); }\n\
            uint16_t minv(svbool_t pg, svuint16_t a) { return svminv(pg, a); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        // UMINV ht, p0, z0.h; UMOV w0, vt.h[0].
        let w = words("minv");
        let t = w[0] & 0x1F;
        assert_eq!(w, [0x044B_2000 | t, 0x0E02_3C00 | t << 5, RET]);
        // SMAXV bt, p0, z0.b; SMOV x0, vt.b[0].
        let w = words("maxv");
        let t = w[0] & 0x1F;
        assert_eq!(w, [0x0408_2000 | t, 0x4E01_2C00 | t << 5, RET]);
        // ORV st, p0, z0.s; MOV w0, vt.s[0].
        let w = words("orv");
        let t = w[0] & 0x1F;
        assert_eq!(w, [0x0498_2000 | t, 0x0E04_3C00 | t << 5, RET]);
        // EORV dt, p0, z0.d; FMOV x0, dt.
        let w = words("eorv");
        let t = w[0] & 0x1F;
        assert_eq!(w, [0x04D9_2000 | t, 0x9E66_0000 | t << 5, RET]);
        // FMAXV s0, p0, z0.s.
        assert_eq!(words("fmaxv"), [0x6586_2000, RET]);
    }
}

/// svzip1 to svtrn2, svrev, svext, svdup_lane and svreinterpret move lanes
/// across the whole vector as scalar C computes for the run's length, an
/// index past the vector giving zero lanes (svdup_lane) or the first vector
/// whole (svext); the interpreter runs the fixture at four vector lengths.
/// Under `-O` svdup_lane is the index in every lane of a scratch and TBL,
/// svext the destructive EXT by bytes, in a scratch where the destination
/// holds the second operand, and svreinterpret a move or nothing. An index
/// past the type's range is diagnosed.
#[test]
fn the_sve_permutes_move_lanes_across_the_vector() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_permute.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    let err = crate::Compiler::with_target(
        String::from(
            "#include <arm_sve.h>\n\
             svint32_t f(svint32_t a) { return svext(a, a, 64); }\n",
        ),
        crate::Target::LinuxAarch64,
    )
    .compile()
    .err()
    .map(|e| e.to_string())
    .unwrap_or_default();
    assert!(err.contains("must be a constant from 0 to 63"), "{err}");
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            svint32_t dl(svint32_t a, uint32_t i) { return svdup_lane(a, i); }\n\
            svint16_t zip(svint16_t a, svint16_t b) { return svzip1(a, b); }\n\
            svint32_t ext(svint32_t b, svint32_t a) { return svext(a, b, 3); }\n\
            svuint8_t same(svint32_t a) { return svreinterpret_u8(a); }\n\
            svfloat32_t moved(svint32_t x, svint32_t a) { return svreinterpret_f32(a); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        // DUP zt.s, w0; TBL z0.s, {z0.s}, zt.s.
        let w = words("dl");
        let t = w[0] & 0x1F;
        assert_eq!(w, [0x05A0_3800 | t, 0x05A0_3000 | t << 16, RET]);
        // ZIP1 z0.h, z0.h, z1.h.
        assert_eq!(words("zip"), [0x0561_6000, RET]);
        // MOVPRFX zt, z1; EXT zt.b, zt.b, z0.b, #12; MOV z0.d, zt.d.
        let w = words("ext");
        let t = w[0] & 0x1F;
        let mov = 0x0460_3000 | t << 16 | t << 5;
        assert_eq!(w, [0x0420_BC20 | t, 0x0521_1000 | t, mov, RET]);
        assert_eq!(words("same"), [RET]);
        // MOV z0.d, z1.d.
        assert_eq!(words("moved"), [0x0461_3020, RET]);
    }
}

/// A floating SVE row raises the exceptions of its active lanes alone, as
/// a predicated instruction does: the interpreter computes those lanes one
/// at a time, so a zero divisor or a NaN compared in an inactive lane of
/// svdiv_m, svdiv_z or svcmpgt sets no flag, where one in an active lane
/// does; at four vector lengths.
#[test]
fn an_inactive_sve_lane_raises_no_floating_exception() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_fenv.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
}

/// A unary row is its instruction on the argument registers under `-O`:
/// the don't-care form in place, the merging form on a `movprfx` copy of
/// the inactive operand, the zeroing form on a zeroing `movprfx` of the
/// operand, both in a scratch where the destination holds the operand;
/// the bit clear, division, minimum and maximum the destructive forms,
/// a division into its divisor's register `sdivr`, and svbic_x the
/// unpredicated doubleword BIC.
#[cfg(feature = "linker")]
#[test]
fn the_sve_arithmetic_rows_emit_their_instructions() {
    const SRC: &str = "#include <arm_sve.h>\n\
        svint32_t not_x(svbool_t pg, svint32_t a) { return svnot_x(pg, a); }\n\
        svint32_t not_m(svint32_t i, svbool_t pg, svint32_t a) { return svnot_m(i, pg, a); }\n\
        svint32_t not_m2(svint32_t a, svbool_t pg, svint32_t i) { return svnot_m(i, pg, a); }\n\
        svint16_t abs_z(svbool_t pg, svint16_t x, svint16_t a) { return svabs_z(pg, a); }\n\
        svfloat64_t neg_z(svbool_t pg, svfloat64_t a) { return svneg_z(pg, a); }\n\
        svuint8_t bic_x(svbool_t pg, svuint8_t a, svuint8_t b) { return svbic_x(pg, a, b); }\n\
        svint32_t div_r(svbool_t pg, svint32_t b, svint32_t a) { return svdiv_z(pg, a, b); }\n\
        svuint64_t max_m(svbool_t pg, svuint64_t a, svuint64_t b) { return svmax_m(pg, a, b); }\n\
        svfloat32_t minnm_x(svbool_t pg, svfloat32_t a, svfloat32_t b) { return svminnm_x(pg, a, b); }\n";
    const RET: u32 = 0xD65F_03C0;
    let words = |name: &str| super::perf_codegen::a64_at(SRC, name, true);
    // NOT z0.s, p0/m, z0.s.
    assert_eq!(words("not_x"), [0x049E_A000, RET]);
    // NOT z0.s, p0/m, z1.s.
    assert_eq!(words("not_m"), [0x049E_A020, RET]);
    // MOVPRFX zt, z1; NOT zt.s, p0/m, z0.s; MOV z0.d, zt.d.
    let w = words("not_m2");
    let t = w[0] & 0x1F;
    assert_eq!(
        w,
        [
            0x0420_BC20 | t,
            0x049E_A000 | t,
            0x0460_3000 | t << 16 | t << 5,
            RET
        ]
    );
    // MOVPRFX z0.h, p0/z, z1.h; ABS z0.h, p0/m, z1.h.
    assert_eq!(words("abs_z"), [0x0450_2020, 0x0456_A020, RET]);
    // MOVPRFX zt.d, p0/z, z0.d; FNEG zt.d, p0/m, z0.d; MOV z0.d, zt.d.
    let w = words("neg_z");
    let t = w[0] & 0x1F;
    assert_eq!(
        w,
        [
            0x04D0_2000 | t,
            0x04DD_A000 | t,
            0x0460_3000 | t << 16 | t << 5,
            RET
        ]
    );
    // BIC z0.d, z0.d, z1.d.
    assert_eq!(words("bic_x"), [0x04E1_3000, RET]);
    // MOVPRFX z0.s, p0/z, z0.s; SDIVR z0.s, p0/m, z0.s, z1.s.
    assert_eq!(words("div_r"), [0x0490_2000, 0x0496_0020, RET]);
    // UMAX z0.d, p0/m, z0.d, z1.d; FMINNM z0.s, p0/m, z0.s, z1.s.
    assert_eq!(words("max_m"), [0x04C9_0020, RET]);
    assert_eq!(words("minnm_x"), [0x6585_8020, RET]);
}

/// svabd and svmulh in each predication form and with a scalar, svsqrt
/// in each form, and svqadd and svqsub at the bounds of every lane width
/// compute what scalar C does; the interpreter runs the fixture at four
/// vector lengths. Under `-O` svabd and svmulh are the destructive SABD,
/// UABD, FABD, SMULH and UMULH, svsqrt FSQRT, svqadd and svqsub the
/// unpredicated SQADD to UQSUB, a constant their immediate form, a
/// negative one's signed sum the difference of its negation.
#[test]
fn sve_differences_high_products_roots_and_saturation() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_difference.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            svint32_t abd_z(svbool_t pg, svint32_t b, svint32_t a) { return svabd_z(pg, a, b); }\n\
            svint64_t mulh_x(svbool_t pg, svint64_t a, svint64_t b) { return svmulh_x(pg, a, b); }\n\
            svfloat32_t sqrt_m(svfloat32_t i, svbool_t pg, svfloat32_t a) { return svsqrt_m(i, pg, a); }\n\
            svint8_t qadd(svint8_t a, svint8_t b) { return svqadd(a, b); }\n\
            svint8_t qaddn(svint8_t a) { return svqadd_n_s8(a, -3); }\n\
            svuint32_t qsubn(svuint32_t x, svuint32_t a) { return svqsub_n_u32(a, 0x100); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        // MOVPRFX z0.s, p0/z, z0.s; SABD z0.s, p0/m, z0.s, z1.s.
        assert_eq!(words("abd_z"), [0x0490_2000, 0x048C_0020, RET]);
        // SMULH z0.d, p0/m, z0.d, z1.d.
        assert_eq!(words("mulh_x"), [0x04D2_0020, RET]);
        // FSQRT z0.s, p0/m, z1.s.
        assert_eq!(words("sqrt_m"), [0x658D_A020, RET]);
        // SQADD z0.b, z0.b, z1.b.
        assert_eq!(words("qadd"), [0x0421_1000, RET]);
        // SQSUB z0.b, z0.b, #3.
        assert_eq!(words("qaddn"), [0x2526_C060, RET]);
        // MOVPRFX z0, z1; UQSUB z0.s, z0.s, #256.
        assert_eq!(words("qsubn"), [0x0420_BC20, 0x25A7_E020, RET]);
    }
}

/// svmla, svmls, svmad, svmsb and the floating svnmla to svnmsb in each
/// predication form and with a scalar compute what scalar C does, with the
/// result's register holding each operand in turn; the interpreter runs
/// the fixture at four vector lengths. Under `-O` the destructive operand
/// is the one the destination holds -- the addend for MLA, a factor for
/// MAD -- where the other two are not there, a merging form's the first,
/// and a negating floating row's never the second factor, else a scratch.
#[test]
fn sve_multiply_adds_destroy_the_operand_the_destination_holds() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_fused.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            svint32_t mla_m(svbool_t pg, svint32_t b, svint32_t a, svint32_t c) { return svmla_m(pg, a, b, c); }\n\
            svint32_t mla_x(svbool_t pg, svint32_t b, svint32_t a, svint32_t c) { return svmla_x(pg, a, b, c); }\n\
            svint32_t mla_z(svbool_t pg, svint32_t b, svint32_t a, svint32_t c) { return svmla_z(pg, a, b, c); }\n\
            svint32_t mad_x(svbool_t pg, svint32_t c, svint32_t a, svint32_t b) { return svmad_x(pg, a, b, c); }\n\
            svfloat64_t mls_x(svbool_t pg, svfloat64_t c, svfloat64_t a, svfloat64_t b) { return svmls_x(pg, a, b, c); }\n\
            svfloat32_t nmla_z(svbool_t pg, svfloat32_t a, svfloat32_t b, svfloat32_t c) { return svnmla_z(pg, a, b, c); }\n\
            svint32_t mla_aa(svint32_t a, svbool_t pg, svint32_t c) { return svmla_m(pg, a, a, c); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        let mov = |t: u32| 0x0460_3000 | t << 16 | t << 5;
        // MOVPRFX zt, z1; MLA zt.s, p0/m, z0.s, z2.s; MOV z0.d, zt.d.
        let w = words("mla_m");
        let t = w[0] & 0x1F;
        assert_eq!(w, [0x0420_BC20 | t, 0x0482_4000 | t, mov(t), RET]);
        // MAD z0.s, p0/m, z2.s, z1.s.
        assert_eq!(words("mla_x"), [0x0482_C020, RET]);
        // MOVPRFX z0.s, p0/z, z0.s; MAD z0.s, p0/m, z2.s, z1.s.
        assert_eq!(words("mla_z"), [0x0490_2000, 0x0482_C020, RET]);
        // MLA z0.s, p0/m, z1.s, z2.s.
        assert_eq!(words("mad_x"), [0x0482_4020, RET]);
        // MOVPRFX zt, z1; FMLS zt.d, p0/m, z2.d, z0.d; MOV z0.d, zt.d.
        let w = words("mls_x");
        let t = w[0] & 0x1F;
        assert_eq!(w, [0x0420_BC20 | t, 0x65E0_2040 | t, mov(t), RET]);
        // MOVPRFX z0.s, p0/z, z0.s; FNMLA z0.s, p0/m, z1.s, z2.s.
        assert_eq!(words("nmla_z"), [0x0490_2000, 0x65A2_4020, RET]);
        // MLA z0.s, p0/m, z0.s, z1.s: no MOVPRFX, so z0 may be a factor too.
        assert_eq!(words("mla_aa"), [0x0481_4000, RET]);
    }
}

/// svcnt, svclz and svcls give the unsigned type of their width, and svcvt
/// converts between the integer and floating types of a width, rounding to
/// nearest and back toward zero, saturating, as scalar C computes; a
/// merging form's inactive operand and an overloaded form's result are of
/// the result's type, the operand's selecting the row. The interpreter
/// runs the fixture at four vector lengths. Under `-O` each is its unary
/// instruction: CNT, CLZ, CLS, SCVTF, UCVTF, FCVTZS and FCVTZU.
#[test]
fn sve_bit_counts_and_conversions_change_the_element_type() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_count_convert.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            svuint32_t cnt_m(svuint32_t i, svbool_t pg, svint32_t a) { return svcnt_m(i, pg, a); }\n\
            svuint8_t cls_x(svbool_t pg, svint8_t a) { return svcls_x(pg, a); }\n\
            svfloat32_t cvt_x(svbool_t pg, svint32_t a) { return svcvt_f32_x(pg, a); }\n\
            svuint64_t cvt_m(svuint64_t i, svbool_t pg, svfloat64_t a) { return svcvt_u64_m(i, pg, a); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        // CNT z0.s, p0/m, z1.s.
        assert_eq!(words("cnt_m"), [0x049A_A020, RET]);
        // CLS z0.b, p0/m, z0.b.
        assert_eq!(words("cls_x"), [0x0418_A000, RET]);
        // SCVTF z0.s, p0/m, z0.s.
        assert_eq!(words("cvt_x"), [0x6594_A000, RET]);
        // FCVTZU z0.d, p0/m, z1.d.
        assert_eq!(words("cvt_m"), [0x65DF_A020, RET]);
    }
}

/// svzip1 to svrev over predicates move whole lanes of 1 to 8 bits, every
/// bit of a lane, and svpfalse sets none, as scalar C computes over the
/// bits; the interpreter runs the fixture at four vector lengths. Under
/// `-O` each is its P-register instruction.
#[test]
fn sve_predicate_permutes_move_whole_lanes() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_predicate_permute.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            svbool_t z1(svbool_t a, svbool_t b) { return svzip1_b16(a, b); }\n\
            svbool_t u2(svbool_t b, svbool_t a) { return svuzp2_b64(a, b); }\n\
            svbool_t r(svbool_t a) { return svrev_b32(a); }\n\
            svbool_t f(void) { return svpfalse_b(); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        // ZIP1 p0.h, p0.h, p1.h.
        assert_eq!(words("z1"), [0x0561_4000, RET]);
        // UZP2 p0.d, p1.d, p0.d.
        assert_eq!(words("u2"), [0x05E0_4C20, RET]);
        // REV p0.s, p0.s.
        assert_eq!(words("r"), [0x05B4_4000, RET]);
        // PFALSE p0.b.
        assert_eq!(words("f"), [0x2518_E400, RET]);
    }
}

/// svindex gives lane `i` as base + i * step, wrapping in the lane's width,
/// over every integer type; the interpreter runs the fixture at four
/// vector lengths. Under `-O` it is INDEX, a base or a step from -16 to
/// 15 its immediate and another a W or, for doubleword lanes, an X
/// register.
#[test]
fn sve_index_counts_from_its_base_by_its_step() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_index.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            svint32_t i0(void) { return svindex_s32(0, 1); }\n\
            svint64_t i1(int64_t b) { return svindex_s64(b, -3); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        // INDEX z0.s, #0, #1.
        assert_eq!(words("i0"), [0x04A1_4000, RET]);
        // INDEX z0.d, x0, #-3.
        assert_eq!(words("i1"), [0x04FD_4400, RET]);
    }
}

/// A constant operand of an SVE row compiles as scalar C computes at the
/// edges of the immediates' ranges and past them; the interpreter runs the
/// fixture at four vector lengths. Under `-O` a constant is its row's
/// immediate form where one encodes it -- the unpredicated integer and
/// shift forms of a `_x` row, the predicated shift and floating forms, the
/// compares, DUP, FDUP and DUPM, and DUP (indexed) of a lane -- and no
/// general register holds it.
#[test]
fn sve_constant_operands_take_the_immediate_forms() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_immediate.c");
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 256, 512, 2048] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(
                vm.run().expect("runs"),
                bits as i64 / 128,
                "{bits} bits, -O {optimize}"
            );
        }
    }
    #[cfg(feature = "linker")]
    {
        const ASM: &str = "#include <arm_sve.h>\n\
            svint32_t asr_x(svbool_t pg, svint32_t a) { return svasr_n_s32_x(pg, a, 3); }\n\
            svint32_t asr_z(svbool_t pg, svint32_t a) { return svasr_n_s32_z(pg, a, 3); }\n\
            svint8_t smin_x(svbool_t pg, svint8_t a) { return svmin_n_s8_x(pg, a, -3); }\n\
            svint32_t add_m(svbool_t pg, svint32_t a) { return svadd_n_s32_m(pg, a, 3); }\n\
            svint16_t sub_x(svbool_t pg, svint16_t x, svint16_t a) { return svsub_x(pg, a, -256); }\n\
            svfloat64_t fmax_m(svbool_t pg, svfloat64_t a) { return svmax_n_f64_m(pg, a, 0.0); }\n\
            svbool_t cmple(svbool_t pg, svuint8_t a) { return svcmple_n_u8(pg, a, 127); }\n\
            svint32_t lane(svint32_t a) { return svdup_lane_s32(a, 2); }\n\
            svfloat32_t one(void) { return svdup_n_f32(1.0f); }\n\
            svuint64_t bit(void) { return svdup_n_u64(0x100000000); }\n";
        const RET: u32 = 0xD65F_03C0;
        let words = |name: &str| super::perf_codegen::a64_at(ASM, name, true);
        // ASR z0.s, z0.s, #3.
        assert_eq!(words("asr_x"), [0x047D_9000, RET]);
        // MOVPRFX z0.s, p0/z, z0.s; ASR z0.s, p0/m, z0.s, #3.
        assert_eq!(words("asr_z"), [0x0490_2000, 0x0440_83A0, RET]);
        // SMIN z0.b, z0.b, #-3.
        assert_eq!(words("smin_x"), [0x252A_DFA0, RET]);
        // DUP zt.s, #3; ADD z0.s, p0/m, z0.s, zt.s.
        let w = words("add_m");
        let t = w[0] & 0x1F;
        assert_eq!(w, [0x25B8_C060 | t, 0x0480_0000 | t << 5, RET]);
        // MOVPRFX z0, z1; SUB z0.h, z0.h, #0xff00.
        assert_eq!(words("sub_x"), [0x0420_BC20, 0x2561_FFE0, RET]);
        // FMAX z0.d, p0/m, z0.d, #0.0.
        assert_eq!(words("fmax_m"), [0x65DE_8000, RET]);
        // CMPLS p0.b, p0/z, z0.b, #127.
        assert_eq!(words("cmple"), [0x243F_E010, RET]);
        // DUP z0.s, z0.s[2].
        assert_eq!(words("lane"), [0x0534_2000, RET]);
        // FDUP z0.s, #1.0.
        assert_eq!(words("one"), [0x25B9_CE00, RET]);
        // DUPM z0.d, #0x100000000.
        assert_eq!(words("bit"), [0x05C3_0000, RET]);
    }
}

/// The logic, select and test intrinsics are their instructions on the
/// argument registers under `-O`: a bitwise don't-care form the
/// unpredicated doubleword one, a predicate form its zeroing instruction,
/// svnot_b_z `not`, svsel `sel`, svptest `ptest` and the `cset` of the
/// flag it reads.
#[cfg(feature = "linker")]
#[test]
fn the_sve_logic_select_and_test_rows_emit_their_instructions() {
    const SRC: &str = "#include <arm_sve.h>\n\
        svint32_t and_m(svbool_t pg, svint32_t a, svint32_t b) { return svand_m(pg, a, b); }\n\
        svuint16_t orr_x(svbool_t pg, svuint16_t a, svuint16_t b) { return svorr_x(pg, a, b); }\n\
        svint8_t eor_z(svbool_t pg, svint8_t a, svint8_t b) { return sveor_z(pg, a, b); }\n\
        svbool_t pand(svbool_t pg, svbool_t a, svbool_t b) { return svand_z(pg, a, b); }\n\
        svbool_t pnand(svbool_t pg, svbool_t a, svbool_t b) { return svnand_b_z(pg, a, b); }\n\
        svbool_t pnot(svbool_t pg, svbool_t a) { return svnot_b_z(pg, a); }\n\
        svfloat64_t sel(svbool_t pg, svfloat64_t a, svfloat64_t b) { return svsel(pg, a, b); }\n\
        svbool_t psel(svbool_t pg, svbool_t a, svbool_t b) { return svsel_b(pg, a, b); }\n\
        _Bool any(svbool_t pg, svbool_t p) { return svptest_any(pg, p); }\n\
        _Bool first(svbool_t pg, svbool_t p) { return svptest_first(pg, p); }\n\
        _Bool last(svbool_t pg, svbool_t p) { return svptest_last(pg, p); }\n";
    let object = super::perf_codegen::object_at(SRC, crate::Target::LinuxAarch64, true);
    for (name, words, what) in [
        ("and_m", &[0x049a_0020u32][..], "and z0.s, p0/m, z0.s, z1.s"),
        ("orr_x", &[0x0461_3000], "orr z0.d, z0.d, z1.d"),
        (
            "eor_z",
            &[0x0410_2000, 0x0419_0020],
            "movprfx z0.b, p0/z, z0.b; eor",
        ),
        ("pand", &[0x2502_4020], "and p0.b, p0/z, p1.b, p2.b"),
        ("pnand", &[0x2582_4230], "nand p0.b, p0/z, p1.b, p2.b"),
        ("pnot", &[0x2500_4220], "not p0.b, p0/z, p1.b"),
        ("sel", &[0x05e1_c000], "sel z0.d, p0, z0.d, z1.d"),
        ("psel", &[0x2502_4230], "sel p0.b, p0, p1.b, p2.b"),
        (
            "any",
            &[0x2550_c020, 0x9a9f_07e0],
            "ptest p0, p1.b; cset ne",
        ),
        (
            "first",
            &[0x2550_c020, 0x9a9f_57e0],
            "ptest p0, p1.b; cset mi",
        ),
        (
            "last",
            &[0x2550_c020, 0x9a9f_27e0],
            "ptest p0, p1.b; cset lo",
        ),
    ] {
        let w = super::codegen::function_words(&object, name);
        assert!(
            w.windows(words.len()).any(|x| x == words),
            "{what}: {w:08x?}"
        );
    }
}

/// A row's predicate operands in slots reload into p7, p15 and p14 in
/// turn; an SVE-PCS function whose row reloads one into p15 saves it.
#[cfg(feature = "linker")]
#[test]
fn predicate_operands_in_slots_reload_into_p7_p15_and_p14() {
    const ACROSS: &str = "#include <arm_sve.h>\n\
        void keep(svbool_t *p0, svbool_t *p1, svbool_t *p2, svbool_t *o, void (*f)(void)) {\n\
            svbool_t pg = *p0, a = *p1, b = *p2; f(); *o = svorr_b_z(pg, a, b); }\n";
    let w = super::perf_codegen::a64_at(ACROSS, "keep", true);
    let ldr_p = |p: u32| move |x: &u32| x & 0xFFC0_E01F == 0x8580_0000 | p;
    let orr = w.iter().position(|&x| x & 0xFFFF_FFF0 == 0x258E_5DE0);
    let orr = orr.expect("orr pd.b, p7/z, p15.b, p14.b");
    for p in [7, 15, 14] {
        assert!(w[..orr].iter().any(ldr_p(p)), "ldr p{p}: {w:08x?}");
    }
    // Fifteen predicates live at once leave q12 and q13 in slots; the
    // first EOR reads q13 second, through p15.
    let mut src = String::from("#include <arm_sve.h>\nsvbool_t many(svbool_t pg, int n) {\n");
    for k in 0..14 {
        src += &alloc::format!("svbool_t q{k} = svwhilelt_b8({k}, n);\n");
    }
    src += "svbool_t r = sveor_b_z(pg, q13, q12);\n";
    for k in (0..12).rev() {
        src += &alloc::format!("r = sveor_b_z(pg, q{k}, r);\n");
    }
    src += "return r; }\n";
    let w = super::perf_codegen::a64_at(&src, "many", true);
    let body = w.iter().position(|&x| x & 0xFF20_FC10 == 0x2520_0400);
    let body = body.expect("whilelt");
    assert!(w[body..].iter().any(ldr_p(15)), "ldr p15: {w:08x?}");
    let str_p15 = |x: &u32| x & 0xFFC0_E01F == 0xE580_000F;
    assert!(w[..body].iter().any(str_p15), "str p15: {w:08x?}");
}

/// A 32-bit svwhilelt reads the W registers of its bounds and a dup into
/// lanes of up to 4 bytes that of its scalar, so under `-O` no extension
/// of a 32-bit parameter precedes them; a doubleword lane takes the
/// sign-extended int.
#[cfg(feature = "linker")]
#[test]
fn a_32_bit_while_and_a_narrow_dup_read_the_low_word_alone() {
    const SRC: &str = "#include <arm_sve.h>\n\
        svbool_t wlo(unsigned i, unsigned n) { return svwhilelt_b8(i, n); }\n\
        svbool_t wlt(int i, int n) { return svwhilelt_b32(i, n); }\n\
        svint32_t d32(int x) { return svdup_n_s32(x); }\n\
        svuint8_t d8(unsigned x) { return svdup_n_u8(x); }\n\
        svint64_t d64(int x) { return svdup_n_s64(x); }\n";
    const RET: u32 = 0xd65f_03c0;
    let object = super::perf_codegen::object_at(SRC, crate::Target::LinuxAarch64, true);
    for (name, words) in [
        ("wlo", &[0x2521_0c00, RET][..]),
        ("wlt", &[0x25a1_0400, RET]),
        ("d32", &[0x05a0_3800, RET]),
        ("d8", &[0x0520_3800, RET]),
        ("d64", &[0x9340_7c00, 0x05e0_3800, RET]),
    ] {
        assert_eq!(
            super::codegen::function_words(&object, name),
            words,
            "{name}"
        );
    }
}

/// A destructive SVE row whose destination holds its second operand: the
/// zeroing form of a vector with itself computes in a scratch, as the
/// instruction MOVPRFX prefixes may read its destination as the
/// destructive operand alone; a commutative one takes the operands the
/// other way round, a subtraction is the reversed one, and the don't-care
/// form of a vector with itself needs no prefix. The fixture computes
/// what scalar C does.
#[cfg(feature = "linker")]
#[test]
fn a_destructive_sve_row_into_its_second_operand_swaps_reverses_or_takes_a_scratch() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/rows_destructive.c");
    const RET: u32 = 0xd65f_03c0;
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(String::from(SRC), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        let vm = super::Vm::new(program).with_sve_vector_bits(512);
        assert_eq!(vm.run().expect("runs"), 4, "-O {optimize}");
    }
    let object = super::perf_codegen::object_at(SRC, crate::Target::LinuxAarch64, true);
    for (name, words) in [
        ("mul_x", &[0x0490_0020, RET][..]),
        ("and_z", &[0x0490_2000, 0x049a_0020, RET]),
        ("sub_z", &[0x0490_2000, 0x0483_0020, RET]),
        ("fsub_z", &[0x0490_2000, 0x6583_8020, RET]),
        ("square_x", &[0x0490_0000, RET]),
    ] {
        assert_eq!(
            super::codegen::function_words(&object, name),
            words,
            "{name}"
        );
    }
    // MOVPRFX zt.s, p0/z, z0.s; MUL zt.s, p0/m, zt.s, z0.s; MOV z0.d, zt.d.
    let w = super::codegen::function_words(&object, "square_z");
    let t = w[0] & 0x1F;
    assert!(t != 0 && w[0] == 0x0490_2000 | t, "{w:08x?}");
    assert_eq!(
        w[1..],
        [0x0490_0000 | t, 0x0460_3000 | t << 16 | t << 5, RET]
    );
}

/// An SVE-PCS leaf moves the FP scratch its rows write into z24-z31 where
/// a register there is free, and saves of z16 and z17, the scratch it
/// falls back to, the one a row writes alone: the integer sum's D register.
#[cfg(feature = "linker")]
#[test]
fn an_sve_pcs_leaf_saves_the_scratch_its_rows_write_alone() {
    // `n` sums live at once; the result their sum, or its svaddv.
    let src = |n: usize, sum: bool| {
        let mut s = String::from("#include <arm_sve.h>\n");
        s += if sum { "int64_t" } else { "svint32_t" };
        s += " f(svbool_t pg, svint32_t a, svint32_t b) {\n";
        for k in 0..n {
            s += &alloc::format!(
                "svint32_t t{k} = svmul_x(pg, a, svadd_x(pg, b, svdup_n_s32({k})));\n"
            );
        }
        let mut acc = String::from("t0");
        for k in 1..n {
            acc = alloc::format!("svadd_x(pg, {acc}, t{k})");
        }
        if sum {
            acc = alloc::format!("svaddv(pg, {acc})");
        }
        s + &alloc::format!("return {acc}; }}\n")
    };
    // STR zt, [xn, #imm, mul vl] of z16-z18; SADDV dd, p0, z0.s.
    let saved = |w: &[u32]| -> Vec<u32> {
        let str_z = w.iter().filter(|&&x| x & 0xFFC0_E000 == 0xE580_4000);
        str_z
            .map(|x| x & 0x1F)
            .filter(|r| (16..19).contains(r))
            .collect()
    };
    let sum = |w: &[u32]| {
        w.iter()
            .find(|&&x| x & 0xFFFF_FFE0 == 0x0480_2000)
            .map(|x| x & 0x1F)
    };
    let w = super::perf_codegen::a64_at(&src(21, false), "f", true);
    for r in 24..32 {
        let held = w.iter().any(|&x| x >> 24 == 0x04 && x & 0x1F == r);
        assert!(held, "z{r} holds no value: {w:08x?}");
    }
    assert_eq!(saved(&w), [], "{w:08x?}");
    let w = super::perf_codegen::a64_at(&src(21, true), "f", true);
    let d = sum(&w).expect("saddv");
    assert_eq!(saved(&w), [d], "{w:08x?}");
    // Registers of z24-z31 free: the sum's scratch takes one.
    let w = super::perf_codegen::a64_at(&src(12, true), "f", true);
    assert!((24..32).contains(&sum(&w).expect("saddv")), "{w:08x?}");
    assert_eq!(saved(&w), [], "{w:08x?}");
}

/// The SVE PCS has a function preserve z16-z23 as it does z8-z15 (AAPCS64
/// 6.1.3), so an SVE-PCS function whose values cross no call takes z24-z31
/// before them: 12 sums live at once save no register. One that calls
/// keeps the base banks, as a callee of the base standard may change
/// z16-z31: its scalars across the call take the registers a base-PCS
/// twin gives them.
#[cfg(feature = "linker")]
#[test]
fn an_sve_pcs_function_without_calls_takes_z24_to_z31_before_z16_to_z23() {
    let mut src = String::from(
        "#include <arm_sve.h>\nsvint32_t f(svbool_t pg, svint32_t a, svint32_t b) {\n",
    );
    for k in 0..12 {
        src +=
            &alloc::format!("svint32_t t{k} = svmul_x(pg, a, svadd_x(pg, b, svdup_n_s32({k})));\n");
    }
    let sum = (1..12).fold(String::from("t0"), |acc, k| {
        alloc::format!("svadd_x(pg, {acc}, t{k})")
    });
    src += &alloc::format!("return {sum}; }}\n");
    let w = super::perf_codegen::a64_at(&src, "f", true);
    // STR zt, [xn, #imm, mul vl]; MUL zd.s, p0/m, zd.s, z0.s.
    assert!(
        !w.iter().any(|&x| x & 0xFFC0_E000 == 0xE580_4000),
        "{w:08x?}"
    );
    let mul_into = |r: u32| w.contains(&(0x0490_0000 | r));
    assert!((24..29).all(mul_into), "{w:08x?}");
    assert!(!(16..24).any(mul_into), "{w:08x?}");
    const CALLS: &str = "#include <arm_sve.h>\ndouble g(double);\n\
        #define BODY double s0 = x[0], s1 = x[1], s2 = x[2], s3 = x[3], s4 = x[4], \\\n\
          s5 = x[5], s6 = x[6], s7 = x[7], s8 = x[8], s9 = x[9], s10 = x[10]; \\\n\
          double r = g(s0) + s1 * s2 + s3 * s4 + s5 * s6 + s7 * s8 + s9 * s10;\n\
        svint32_t f(svbool_t pg, svint32_t a, const double *x) {\n\
          BODY return svadd_x(pg, a, svdup_n_s32((int)r)); }\n\
        int h(const double *x) { BODY return (int)r; }\n";
    // LDR dt, [xn, #imm] ahead of the call: the registers of s0-s10.
    let loaded = |name: &str| -> Vec<u32> {
        let w = super::perf_codegen::a64_at(CALLS, name, true);
        let call = w.iter().position(|&x| x >> 26 == 0x25).expect("bl");
        (w[..call].iter())
            .filter(|&&x| x & 0xFFC0_0000 == 0xFD40_0000)
            .map(|x| x & 0x1F)
            .collect()
    };
    assert_eq!(loaded("f"), loaded("h"));
}

/// An SVE-PCS leaf saves the P registers it stages predicates through where
/// a site writes them, not wherever a predicate sits in a slot: p15
/// reloading a second operand of a 4-bit field and p14 computing a result
/// bound for a slot, and p7 only where a predicate in a slot governs.
#[cfg(feature = "linker")]
#[test]
fn an_sve_pcs_leaf_saves_the_predicate_stages_its_sites_write() {
    const SRC: &str = include_str!("../../../tests/fixtures/sve/pcs_preserves.c");
    // STR pt, [xn, #imm, mul vl]: a save, or a store to a slot.
    let stored = |name: &str| -> u16 {
        let w = super::perf_codegen::a64_at(SRC, name, true);
        (w.iter())
            .filter(|&&x| x & 0xFFC0_E010 == 0xE580_0000)
            .fold(0, |m, x| m | 1 << (x & 0xF))
    };
    let preds = stored("preds");
    assert_eq!(preds & 0xC080, 0xC000, "{preds:016b}");
    let govern = stored("govern");
    assert_eq!(govern & 0xC080, 0x4080, "{govern:016b}");
}

/// An overloaded intrinsic of `<arm_sve.h>` passes `void` for its type and
/// takes its row from its first SVE operand after the governing one, so no
/// macro names an operand twice and a chain of nested intrinsics expands to
/// text in proportion to its depth, not doubling with each level. A
/// scalar before that operand, as in svcmplt's `_n` form, becomes a vector
/// of its type; a `void`-typed call with no SVE operand is diagnosed.
#[test]
fn an_overloaded_sve_intrinsic_names_each_operand_once() {
    const HDR: &str = include_str!("../../../libc/compiler/include/arm_sve.h");
    let ident = |c: char| c.is_ascii_alphanumeric() || c == '_';
    for def in HDR.lines().filter_map(|l| l.strip_prefix("#define ")) {
        let head_end = def.find(|c: char| !ident(c)).unwrap_or(def.len());
        let Some(rest) = def[head_end..].strip_prefix('(') else {
            continue;
        };
        let (params, body) = rest.split_once(')').expect("parameter list");
        for p in params.split(',').map(str::trim).filter(|p| !p.is_empty()) {
            let n = body.split(|c: char| !ident(c)).filter(|w| *w == p).count();
            assert!(n <= 1, "{def}: `{p}` appears {n} times");
        }
    }
    let chain = (0..64).fold(String::from("a"), |s, _| {
        alloc::format!("svadd_x(pg, {s}, a)")
    });
    let src = alloc::format!(
        "#include <arm_sve.h>\n\
         int main(void) {{\n\
           int32_t x[64], y[64];\n\
           for (int i = 0; i < 64; i++) x[i] = i - 7;\n\
           svbool_t pg = svptrue_b32();\n\
           svint32_t a = svld1(pg, x), s = {chain};\n\
           svbool_t in = svand_z(pg, svcmplt(pg, a, 3), svcmpgt(pg, a, -2));\n\
           svst1(pg, y, svsel(in, s, a));\n\
           for (int i = 0; i < (int)svcntw(); i++)\n\
             if (y[i] != (x[i] < 3 && x[i] > -2 ? 65 * x[i] : x[i])) return 100 + i;\n\
           return (int)svaddv(pg, svdup_n_s32(1));\n\
         }}\n"
    );
    for optimize in [false, true] {
        let options = crate::CompileOptions::default().with_optimize(optimize);
        let program =
            crate::Compiler::with_options(src.clone(), crate::Target::LinuxAarch64, options)
                .compile()
                .expect("compiles");
        for bits in [128, 512] {
            let vm = super::Vm::new(program.clone()).with_sve_vector_bits(bits);
            assert_eq!(vm.run().expect("runs"), bits as i64 / 32, "{bits} bits");
        }
    }
    let err = crate::Compiler::with_target(
        String::from(
            "#include <arm_sve.h>\n\
             int f(void) { return (int)__builtin_sve_add_x(void, svptrue_b8(), 1, 2); }\n",
        ),
        crate::Target::LinuxAarch64,
    )
    .compile()
    .err()
    .map(|e| e.to_string())
    .unwrap_or_default();
    assert!(
        err.contains("takes an SVE vector or predicate operand"),
        "{err}"
    );
}

/// `Imm(0)` stands for a zero vector too. One read as a 128-bit NEON
/// operand, spilled when the banks are cut to one register each, keeps its
/// whole width in its slot: interleaving bytes with it by `zip1` / `zip2`
/// sums the bytes natively at -O as at the full register file.
#[cfg(all(
    target_arch = "aarch64",
    any(target_os = "linux", target_os = "macos", target_os = "windows")
))]
#[test]
fn a_spilled_zero_vector_keeps_its_width() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target, jit_run_with_options};
    let src = "#include <arm_neon.h>\n\
        static unsigned char buf[640];\n\
        static unsigned long sum(const unsigned char *p, const unsigned char *q, int n, int step, int a, int b) {\n\
            uint8x16_t zero = {0};\n\
            uint64x2_t acc = {0}, acc2 = {0};\n\
            for (int i = 0, j = 0, k = n; i < n; i += step, j += a, k -= b) {\n\
                uint8x16_t x = vld1q_u8(p + i), y = vld1q_u8(q + (k & 0x1f0));\n\
                acc = vpadalq_u32(acc, vpaddlq_u16(vpaddlq_u8(vzip1q_u8(x, zero))));\n\
                acc2 = vaddq_u64(acc2, vpaddlq_u32(vpaddlq_u16(vpaddlq_u8(vzip2q_u8(y, zero)))));\n\
                acc2 = vaddq_u64(acc2, vdupq_n_u64((unsigned long)j));\n\
            }\n\
            return vgetq_lane_u64(acc, 0) + vgetq_lane_u64(acc, 1) + (vgetq_lane_u64(acc2, 0) > 0 ? 0 : 1);\n\
        }\n\
        int main(void) {\n\
            for (int i = 0; i < 640; i++) buf[i] = (unsigned char)(i * 131 + (i >> 3));\n\
            unsigned long want = 0;\n\
            for (int i = 0; i < 640; i += 16) for (int t = 0; t < 8; t++) want += buf[i + t];\n\
            return sum(buf, buf + 128, 640, 16, 3, 5) == want ? 0 : 1;\n\
        }\n";
    let host = if cfg!(target_os = "macos") {
        Target::MacOSAarch64
    } else if cfg!(windows) {
        Target::WindowsAarch64
    } else {
        Target::LinuxAarch64
    };
    for (gpr, fpr) in [(1, 1), (1, 2), (usize::MAX, usize::MAX)] {
        let code = crate::c5::codegen::ssa::reg_alloc::with_pool_size_override(gpr, fpr, || {
            let program = Compiler::with_options(src.into(), host, CompileOptions::default())
                .compile()
                .expect("compile");
            let opts = NativeOptions::new().with_optimize();
            jit_run_with_options(&program, &[String::from("p")], opts, &mut |_| {}).expect("run")
        });
        assert_eq!(code, 0, "registers per bank: {gpr} general, {fpr} vector");
    }
}
