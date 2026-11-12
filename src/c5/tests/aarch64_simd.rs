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

/// Each lane permute is its one instruction on the argument registers
/// under `-O`, a floating one the integer form of its lane width, and
/// `vext` the byte form at its lane's byte offset; so is each conversion
/// between the float and double lanes.
#[cfg(feature = "full")]
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
        (0x4e01_3800u32, "zip1 v0.16b, v0.16b, v1.16b"),
        (0x0e41_5800, "uzp2 v0.4h, v0.4h, v1.4h"),
        (0x4ec1_2800, "trn1 v0.2d, v0.2d, v1.2d"),
        (0x0e81_6800, "trn2 v0.2s, v0.2s, v1.2s"),
        (0x6e01_2800, "ext v0.16b, v0.16b, v1.16b, #5"),
        (0x2e01_3000, "ext v0.8b, v0.8b, v1.8b, #6"),
        (0x0e61_7800, "fcvtl v0.2d, v0.2s"),
        (0x0e61_6800, "fcvtn v0.2s, v0.2d"),
        (0x4e0f_0400, "dup v0.16b, v0.b[7]"),
        (0x0e1a_0400, "dup v0.4h, v0.h[6]"),
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

/// A GNU vector comparison, a shift by a constant count and a negation are
/// the target's one instruction for the whole vector where it has one
/// (`simd::find`): `<` is `cmgt` with the operands swapped.
#[cfg(feature = "full")]
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

/// A lane of an 8-byte vector is read and written in its register, as a
/// 16-byte vector's is: `smov` and `ins` on the D register.
#[cfg(feature = "full")]
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
