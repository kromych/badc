//! x86 SIMD intrinsic surface: the instruction each builtin emits, the
//! value semantics the interpreter evaluates, and the operand rules the
//! parser enforces.
//!
//! The expected encodings in the emission tests were produced with
//! `llvm-mc --triple=x86_64 --show-encoding` over the AT&T spelling in
//! each comment.

use crate::c5::x86_simd::{self, Sem};

/// Vector typedefs the sources below operate on, matching the bundled
/// `<emmintrin.h>` set.
const VEC: &str = "typedef long long __m128i __attribute__((vector_size(16))); \
     typedef int __v4si __attribute__((vector_size(16))); \
     typedef short __v8hi __attribute__((vector_size(16))); \
     typedef char __v16qi __attribute__((vector_size(16))); \
     typedef double __m128d __attribute__((vector_size(16))); \
     typedef double __v2df __attribute__((vector_size(16))); ";

/// Every emitted unit needs an entry point.
const MAIN: &str = " int main(void) { return 0; }";

#[cfg(feature = "full")]
fn emitted(src: &str) -> Vec<u8> {
    use crate::{NativeOptions, Target};
    let program = super::compile_str_bare_for(&format!("{VEC}{src}{MAIN}"), Target::LinuxX64);
    crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .expect("emit_native for linux-x64")
}

#[cfg(feature = "full")]
#[track_caller]
fn assert_emits(src: &str, expected: &[u8], what: &str) {
    let bytes = emitted(src);
    assert!(
        bytes.windows(expected.len()).any(|w| w == expected),
        "{what}: expected encoding {expected:02x?} not in the emitted code"
    );
}

/// The 128-bit operands are memory-resident and 8-byte aligned, so every
/// transfer is `movdqu`: `f3 44 0f 6f` (load into xmm14/xmm15) and
/// `f3 44 0f 7f` (store).
#[cfg(feature = "full")]
#[test]
fn transfers_use_unaligned_moves() {
    // movdqu (%rcx), %xmm15  f3 44 0f 6f 39
    // movdqu %xmm15, (%rax)  f3 44 0f 7f 38
    assert_emits(
        "__m128i f(const __m128i *p) { return __builtin_ia32_loaddqu((const char *)p); }",
        &[0xf3, 0x44, 0x0f, 0x6f],
        "loaddqu",
    );
    assert_emits(
        "void f(__m128i *p, __m128i a) { __builtin_ia32_storedqu((char *)p, a); }",
        &[0xf3, 0x44, 0x0f, 0x7f],
        "storedqu",
    );
}

#[cfg(feature = "full")]
#[test]
fn sse2_packed_ops_emit_their_instruction() {
    // pxor  %xmm14, %xmm15   66 45 0f ef fe
    // paddd %xmm14, %xmm15   66 45 0f fe fe
    // paddq %xmm14, %xmm15   66 45 0f d4 fe
    // psubq %xmm14, %xmm15   66 45 0f fb fe
    // pand  %xmm14, %xmm15   66 45 0f db fe
    // por   %xmm14, %xmm15   66 45 0f eb fe
    // punpcklqdq %xmm14, %xmm15   66 45 0f 6c fe
    for (builtin, opcode) in [
        ("pxor128", 0xefu8),
        ("paddd128", 0xfe),
        ("paddq128", 0xd4),
        ("psubq128", 0xfb),
        ("pand128", 0xdb),
        ("por128", 0xeb),
        ("punpcklqdq128", 0x6c),
    ] {
        assert_emits(
            &format!(
                "__m128i f(__m128i a, __m128i b) {{ return __builtin_ia32_{builtin}(a, b); }}"
            ),
            &[0x66, 0x45, 0x0f, opcode, 0xfe],
            builtin,
        );
    }
}

#[cfg(feature = "full")]
#[test]
fn shifts_take_the_immediate_form_for_a_constant_count() {
    // psllw  $0x3, %xmm15   66 41 0f 71 f7 03
    // pslld  $0x7, %xmm15   66 41 0f 72 f7 07
    // psllq  $0x9, %xmm15   66 41 0f 73 f7 09
    // psrlw  $0x3, %xmm15   66 41 0f 71 d7 03
    // psrld  $0x7, %xmm15   66 41 0f 72 d7 07
    // psrlq  $0x9, %xmm15   66 41 0f 73 d7 09
    for (builtin, opcode, modrm, count) in [
        ("psllwi128", 0x71u8, 0xf7u8, 3),
        ("pslldi128", 0x72, 0xf7, 7),
        ("psllqi128", 0x73, 0xf7, 9),
        ("psrlwi128", 0x71, 0xd7, 3),
        ("psrldi128", 0x72, 0xd7, 7),
        ("psrlqi128", 0x73, 0xd7, 9),
    ] {
        assert_emits(
            &format!("__m128i f(__m128i a) {{ return __builtin_ia32_{builtin}(a, {count}); }}"),
            &[0x66, 0x41, 0x0f, opcode, modrm, count as u8],
            builtin,
        );
    }
    // The byte-granular shift counts bytes while the builtin takes bits:
    // pslldq $0x4, %xmm15   66 41 0f 73 ff 04
    assert_emits(
        "__m128i f(__m128i a) { return __builtin_ia32_pslldqi128(a, 32); }",
        &[0x66, 0x41, 0x0f, 0x73, 0xff, 0x04],
        "pslldqi128",
    );
}

#[cfg(feature = "full")]
#[test]
fn a_runtime_shift_count_takes_the_register_form() {
    // movq %rcx, %xmm14 then psrlq %xmm14, %xmm15   66 45 0f d3 fe
    assert_emits(
        "__m128i f(__m128i a, int n) { return __builtin_ia32_psrlqi128(a, n); }",
        &[0x66, 0x45, 0x0f, 0xd3, 0xfe],
        "psrlq register count",
    );
}

#[cfg(feature = "full")]
#[test]
fn shuffles_carry_their_immediate() {
    // pshufd  $0x93, %xmm14, %xmm15   66 45 0f 70 fe 93
    // pshuflw $0x1b, %xmm14, %xmm15   f2 45 0f 70 fe 1b
    // pshufhw $0x1b, %xmm14, %xmm15   f3 45 0f 70 fe 1b
    assert_emits(
        "__m128i f(__m128i a) { return __builtin_ia32_pshufd(a, 0x93); }",
        &[0x66, 0x45, 0x0f, 0x70, 0xfe, 0x93],
        "pshufd",
    );
    assert_emits(
        "__m128i f(__m128i a) { return __builtin_ia32_pshuflw(a, 0x1b); }",
        &[0xf2, 0x45, 0x0f, 0x70, 0xfe, 0x1b],
        "pshuflw",
    );
    assert_emits(
        "__m128i f(__m128i a) { return __builtin_ia32_pshufhw(a, 0x1b); }",
        &[0xf3, 0x45, 0x0f, 0x70, 0xfe, 0x1b],
        "pshufhw",
    );
    // shufpd $0x1, %xmm14, %xmm15   66 45 0f c6 fe 01
    assert_emits(
        "__m128d f(__m128d a, __m128d b) { return (__m128d)__builtin_ia32_shufpd(a, b, 1); }",
        &[0x66, 0x45, 0x0f, 0xc6, 0xfe, 0x01],
        "shufpd",
    );
    // pshufb %xmm14, %xmm15   66 45 0f 38 00 fe
    assert_emits(
        "__m128i f(__m128i a, __m128i b) { return __builtin_ia32_pshufb128(a, b); }",
        &[0x66, 0x45, 0x0f, 0x38, 0x00, 0xfe],
        "pshufb",
    );
}

#[cfg(feature = "full")]
#[test]
fn element_access_uses_the_extract_and_insert_instructions() {
    // pextrw $0x3, %xmm14, %r11d        66 45 0f c5 de 03
    // pextrd $0x2, %xmm14, %r11d        66 45 0f 3a 16 f3 02
    // pinsrd $0x1, %edx, %xmm15         66 44 0f 3a 22 fa 01
    assert_emits(
        "int f(__m128i a) { return __builtin_ia32_vec_ext_v8hi(a, 3); }",
        &[0x66, 0x45, 0x0f, 0xc5, 0xde, 0x03],
        "pextrw",
    );
    assert_emits(
        "int f(__m128i a) { return __builtin_ia32_vec_ext_v4si(a, 2); }",
        &[0x66, 0x45, 0x0f, 0x3a, 0x16, 0xf3, 0x02],
        "pextrd",
    );
    assert_emits(
        "__m128i f(__m128i a, int x) { return __builtin_ia32_vec_set_v4si(a, x, 1); }",
        &[0x66, 0x44, 0x0f, 0x3a, 0x22, 0xfa, 0x01],
        "pinsrd",
    );
    // pcmpeqq %xmm14, %xmm15   66 45 0f 38 29 fe
    assert_emits(
        "__m128i f(__m128i a, __m128i b) { return __builtin_ia32_pcmpeqq(a, b); }",
        &[0x66, 0x45, 0x0f, 0x38, 0x29, 0xfe],
        "pcmpeqq",
    );
}

#[cfg(feature = "full")]
#[test]
fn aes_and_carryless_multiply_emit_their_instruction() {
    // aesenc     %xmm14, %xmm15   66 45 0f 38 dc fe
    // aesenclast %xmm14, %xmm15   66 45 0f 38 dd fe
    // aesdec     %xmm14, %xmm15   66 45 0f 38 de fe
    // aesdeclast %xmm14, %xmm15   66 45 0f 38 df fe
    for (builtin, opcode) in [
        ("aesenc128", 0xdcu8),
        ("aesenclast128", 0xdd),
        ("aesdec128", 0xde),
        ("aesdeclast128", 0xdf),
    ] {
        assert_emits(
            &format!(
                "__m128i f(__m128i a, __m128i b) {{ return __builtin_ia32_{builtin}(a, b); }}"
            ),
            &[0x66, 0x45, 0x0f, 0x38, opcode, 0xfe],
            builtin,
        );
    }
    // aesimc %xmm14, %xmm15   66 45 0f 38 db fe
    assert_emits(
        "__m128i f(__m128i a) { return __builtin_ia32_aesimc128(a); }",
        &[0x66, 0x45, 0x0f, 0x38, 0xdb, 0xfe],
        "aesimc",
    );
    // aeskeygenassist $0x1b, %xmm14, %xmm15   66 45 0f 3a df fe 1b
    assert_emits(
        "__m128i f(__m128i a) { return __builtin_ia32_aeskeygenassist128(a, 0x1b); }",
        &[0x66, 0x45, 0x0f, 0x3a, 0xdf, 0xfe, 0x1b],
        "aeskeygenassist",
    );
    // pclmulqdq $0x11, %xmm14, %xmm15   66 45 0f 3a 44 fe 11
    assert_emits(
        "__m128i f(__m128i a, __m128i b) { return __builtin_ia32_pclmulqdq128(a, b, 0x11); }",
        &[0x66, 0x45, 0x0f, 0x3a, 0x44, 0xfe, 0x11],
        "pclmulqdq",
    );
}

#[cfg(feature = "full")]
#[test]
fn rdrand_reports_its_carry_flag() {
    // rdrandl %r10d     41 0f c7 f2
    // setb    %r10b     41 0f 92 c2
    // movzbl  %r10b, %r10d   45 0f b6 d2
    let bytes = emitted("int f(unsigned *p) { return __builtin_ia32_rdrand32_step(p); }");
    for (needle, what) in [
        (&[0x41u8, 0x0f, 0xc7, 0xf2][..], "rdrand"),
        (&[0x41, 0x0f, 0x92, 0xc2][..], "setc"),
        (&[0x45, 0x0f, 0xb6, 0xd2][..], "movzx"),
    ] {
        assert!(
            bytes.windows(needle.len()).any(|w| w == needle),
            "{what}: expected encoding {needle:02x?} not in the emitted code"
        );
    }
}

/// The bundled headers reach the same instructions through the `_mm_*`
/// spellings, including the macro forms that carry an immediate.
#[cfg(feature = "full")]
#[test]
fn the_bundled_headers_reach_the_instructions() {
    use crate::{NativeOptions, Target};
    let src = "#include <x86intrin.h>\n\
         __m128i f(const __m128i *p, __m128i k) {\n\
             __m128i v = _mm_loadu_si128(p);\n\
             v = _mm_xor_si128(v, k);\n\
             v = _mm_shuffle_epi32(v, _MM_SHUFFLE(0, 3, 2, 1));\n\
             v = _mm_slli_epi32(v, 5);\n\
             v = _mm_aesenc_si128(v, k);\n\
             v = _mm_clmulepi64_si128(v, k, 0x10);\n\
             return _mm_shuffle_epi8(v, k);\n\
         }\n\
         int main(void) { return 0; }";
    let program = crate::Compiler::with_target(src.to_string(), Target::LinuxX64)
        .compile()
        .expect("the bundled x86 intrinsic headers must compile for an x86 target");
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::default(),
    )
    .expect("emit_native for linux-x64");
    for (needle, what) in [
        (&[0x66u8, 0x45, 0x0f, 0xef, 0xfe][..], "pxor"),
        (&[0x66, 0x45, 0x0f, 0x70, 0xfe, 0x39][..], "pshufd"),
        (&[0x66, 0x41, 0x0f, 0x72, 0xf7, 0x05][..], "pslld $5"),
        (&[0x66, 0x45, 0x0f, 0x38, 0xdc, 0xfe][..], "aesenc"),
        (&[0x66, 0x45, 0x0f, 0x3a, 0x44, 0xfe, 0x10][..], "pclmulqdq"),
        (&[0x66, 0x45, 0x0f, 0x38, 0x00, 0xfe][..], "pshufb"),
    ] {
        assert!(
            bytes.windows(needle.len()).any(|w| w == needle),
            "{what}: expected encoding {needle:02x?} not in the emitted code"
        );
    }
}

// ------------------------------------------------------------------
// Operand rules.
// ------------------------------------------------------------------

fn compile_x64_err(src: &str) -> String {
    let full = format!("{VEC}{src}{MAIN}");
    match crate::Compiler::with_target(full, crate::Target::LinuxX64).compile() {
        Ok(_) => panic!("expected a diagnostic, got a successful compile"),
        Err(e) => format!("{e:?}"),
    }
}

#[test]
fn an_immediate_operand_must_be_a_constant_expression() {
    let msg =
        compile_x64_err("__m128i f(__m128i a, int n) { return __builtin_ia32_pshufd(a, n); }");
    assert!(
        msg.contains("integer constant expression"),
        "names the rule: {msg}"
    );
    // The byte-granular shift has no register-count form either.
    let msg =
        compile_x64_err("__m128i f(__m128i a, int n) { return __builtin_ia32_pslldqi128(a, n); }");
    assert!(
        msg.contains("integer constant expression"),
        "names the rule: {msg}"
    );
}

#[test]
fn operand_kinds_and_counts_are_checked() {
    let msg = compile_x64_err("__m128i f(__m128i a) { return __builtin_ia32_pxor128(a); }");
    assert!(
        msg.contains("expects 2 arguments"),
        "names the arity: {msg}"
    );
    let msg =
        compile_x64_err("__m128i f(__m128i a, int b) { return __builtin_ia32_pxor128(a, b); }");
    assert!(
        msg.contains("must be a 16-byte vector"),
        "names the operand kind: {msg}"
    );
    let msg = compile_x64_err("__m128i f(int p) { return __builtin_ia32_loaddqu(p); }");
    assert!(
        msg.contains("must be a pointer"),
        "names the operand kind: {msg}"
    );
}

#[test]
fn the_builtins_are_x86_only() {
    let src = format!(
        "{VEC}__m128i f(__m128i a, __m128i b) {{ return __builtin_ia32_pxor128(a, b); }}{MAIN}"
    );
    let Err(err) = crate::Compiler::with_target(src, crate::Target::LinuxAarch64).compile() else {
        panic!("an x86 SIMD builtin must not compile for aarch64");
    };
    assert!(
        format!("{err:?}").contains("requires an x86 target"),
        "names the reason: {err:?}"
    );
}

// ------------------------------------------------------------------
// Value semantics. The vectors below are the ones the SDM and
// FIPS-197 publish for these instructions.
// ------------------------------------------------------------------

fn v(bytes: [u8; 16]) -> [u8; 16] {
    bytes
}

fn hex(s: &str) -> [u8; 16] {
    let mut o = [0u8; 16];
    for (i, b) in o.iter_mut().enumerate() {
        *b = u8::from_str_radix(&s[2 * i..2 * i + 2], 16).unwrap();
    }
    o
}

#[test]
fn lane_arithmetic_and_logic_match_the_instruction() {
    let a = v([1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 4, 0, 0, 0]);
    let b = v([10, 0, 0, 0, 20, 0, 0, 0, 30, 0, 0, 0, 40, 0, 0, 0]);
    assert_eq!(
        x86_simd::eval(Sem::Add(4), &a, &b, 0, 0),
        v([11, 0, 0, 0, 22, 0, 0, 0, 33, 0, 0, 0, 44, 0, 0, 0])
    );
    // Doubleword addition does not carry between lanes.
    let hi = v([0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    let one = v([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    assert_eq!(x86_simd::eval(Sem::Add(4), &hi, &one, 0, 0), [0u8; 16]);
    // Quadword addition does.
    let q = v([0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    assert_eq!(
        x86_simd::eval(Sem::Add(8), &q, &one, 0, 0),
        v([0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    );
    assert_eq!(x86_simd::eval(Sem::Xor, &a, &a, 0, 0), [0u8; 16]);
    assert_eq!(
        x86_simd::eval(Sem::And, &a, &b, 0, 0),
        v([0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0])
    );
    assert_eq!(
        x86_simd::eval(Sem::Or, &a, &b, 0, 0),
        v([11, 0, 0, 0, 22, 0, 0, 0, 31, 0, 0, 0, 44, 0, 0, 0])
    );
    // A quadword compare sets all bits of the equal lane.
    let eq = x86_simd::eval(Sem::CmpEq(8), &a, &a, 0, 0);
    assert_eq!(eq, [0xffu8; 16]);
}

#[test]
fn shifts_zero_a_lane_shifted_past_its_width() {
    let a = v([0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    assert_eq!(
        x86_simd::eval(Sem::Shl(2), &a, &[0; 16], 0, 4),
        v([0xf0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    );
    assert_eq!(x86_simd::eval(Sem::Shr(2), &a, &[0; 16], 0, 16), [0u8; 16]);
    // The byte shift counts bytes and fills from the low end.
    let b = v([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
    assert_eq!(
        x86_simd::eval(Sem::ShlBytes, &b, &[0; 16], 0, 4),
        v([0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    );
}

#[test]
fn shuffles_select_the_lanes_the_immediate_names() {
    let a = v([0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0]);
    // 0x93 = lanes (2,1,0,3): the rotate ChaCha20 uses.
    assert_eq!(
        x86_simd::eval(Sem::ShufD, &a, &[0; 16], 0x93, 0),
        v([3, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0])
    );
    // The word shuffles leave the other half alone.
    let w = v([0, 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0]);
    let lo = x86_simd::eval(Sem::ShufLo, &w, &[0; 16], 0x1b, 0);
    assert_eq!(&lo[8..], &w[8..]);
    assert_eq!(&lo[..8], &[3, 0, 2, 0, 1, 0, 0, 0]);
    let hi = x86_simd::eval(Sem::ShufHi, &w, &[0; 16], 0x1b, 0);
    assert_eq!(&hi[..8], &w[..8]);
    assert_eq!(&hi[8..], &[7, 0, 6, 0, 5, 0, 4, 0]);
    // The byte shuffle zeroes a byte whose index has bit 7 set.
    let data = v([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    let mask = v([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0x80]);
    let sh = x86_simd::eval(Sem::ShufB, &data, &mask, 0, 0);
    assert_eq!(
        sh,
        v([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0])
    );
    // Interleaving the low quads.
    let x = v([1, 1, 1, 1, 1, 1, 1, 1, 9, 9, 9, 9, 9, 9, 9, 9]);
    let y = v([2, 2, 2, 2, 2, 2, 2, 2, 8, 8, 8, 8, 8, 8, 8, 8]);
    assert_eq!(
        x86_simd::eval(Sem::UnpackLoQ, &x, &y, 0, 0),
        v([1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2])
    );
}

#[test]
fn element_access_reads_and_writes_the_named_lane() {
    let a = v([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    assert_eq!(x86_simd::eval_extract(&a, 2, 1), 0x0302);
    assert_eq!(x86_simd::eval_extract(&a, 4, 3), 0x0f0e_0d0c);
    let set = x86_simd::eval_insert(&a, 4, 1, 0xdead_beef);
    assert_eq!(&set[4..8], &[0xef, 0xbe, 0xad, 0xde]);
    assert_eq!(&set[..4], &a[..4]);
}

/// PCLMULQDQ multiplies without carries: `x^1 * x^1 = x^2`, and the
/// immediate selects the source quadwords.
#[test]
fn carryless_multiply_selects_its_quadwords() {
    let mut a = [0u8; 16];
    let mut b = [0u8; 16];
    a[0] = 2;
    b[0] = 2;
    assert_eq!(x86_simd::eval(Sem::ClMul, &a, &b, 0x00, 0)[0], 4);
    // 0x11 takes the high quads, which are zero here.
    assert_eq!(x86_simd::eval(Sem::ClMul, &a, &b, 0x11, 0), [0u8; 16]);
    // 0b11 * 0b11 = 0b101 with carries suppressed.
    a[0] = 3;
    b[0] = 3;
    assert_eq!(x86_simd::eval(Sem::ClMul, &a, &b, 0x00, 0)[0], 5);
}

/// AES-128 over the FIPS-197 appendix C.1 known answer, run through the
/// same instruction sequence the AES-NI key expansion and cipher use:
/// `aeskeygenassist` + `pshufd` + `pslldq` + `pxor` for the schedule,
/// `aesenc` / `aesenclast` for the cipher, and `aesimc` + `aesdec` /
/// `aesdeclast` for the equivalent inverse cipher.
#[test]
fn aes_128_reproduces_the_published_known_answer() {
    fn expand(key: [u8; 16]) -> [[u8; 16]; 11] {
        let mut ks = [[0u8; 16]; 11];
        let mut t1 = key;
        ks[0] = t1;
        for (i, rcon) in [0x01u8, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36]
            .into_iter()
            .enumerate()
        {
            let t2 = x86_simd::eval(Sem::AesKeygen, &t1, &Z, rcon, 0);
            let t2 = x86_simd::eval(Sem::ShufD, &t2, &Z, 0xff, 0);
            let mut t3 = x86_simd::eval(Sem::ShlBytes, &t1, &Z, 0, 4);
            t1 = x86_simd::eval(Sem::Xor, &t1, &t3, 0, 0);
            t3 = x86_simd::eval(Sem::ShlBytes, &t3, &Z, 0, 4);
            t1 = x86_simd::eval(Sem::Xor, &t1, &t3, 0, 0);
            t3 = x86_simd::eval(Sem::ShlBytes, &t3, &Z, 0, 4);
            t1 = x86_simd::eval(Sem::Xor, &t1, &t3, 0, 0);
            t1 = x86_simd::eval(Sem::Xor, &t1, &t2, 0, 0);
            ks[i + 1] = t1;
        }
        ks
    }
    const Z: [u8; 16] = [0u8; 16];
    let ks = expand(hex("000102030405060708090a0b0c0d0e0f"));
    let mut m = x86_simd::eval(
        Sem::Xor,
        &hex("00112233445566778899aabbccddeeff"),
        &ks[0],
        0,
        0,
    );
    for k in ks.iter().take(10).skip(1) {
        m = x86_simd::eval(Sem::AesEnc, &m, k, 0, 0);
    }
    m = x86_simd::eval(Sem::AesEncLast, &m, &ks[10], 0, 0);
    assert_eq!(m, hex("69c4e0d86a7b0430d8cdb78070b4c55a"));

    let mut d = x86_simd::eval(Sem::Xor, &m, &ks[10], 0, 0);
    for k in ks.iter().take(10).skip(1).rev() {
        let dk = x86_simd::eval(Sem::AesImc, k, &Z, 0, 0);
        d = x86_simd::eval(Sem::AesDec, &d, &dk, 0, 0);
    }
    d = x86_simd::eval(Sem::AesDecLast, &d, &ks[0], 0, 0);
    assert_eq!(d, hex("00112233445566778899aabbccddeeff"));
}

/// The key-schedule helper on its own: FIPS-197 A.1 expands the key
/// 2b7e151628aed2a6abf7158809cf4f3c, where the first round constant
/// takes w[3] = 09cf4f3c to SubWord(RotWord(w[3])) xor Rcon[1] =
/// 8b84eb01, the value the instruction leaves in the high doubleword.
#[test]
fn the_key_schedule_helper_matches_the_expansion() {
    let k = hex("2b7e151628aed2a6abf7158809cf4f3c");
    let out = x86_simd::eval(Sem::AesKeygen, &k, &[0u8; 16], 0x01, 0);
    assert_eq!(&out[12..], &[0x8b, 0x84, 0xeb, 0x01]);
    // The low doubleword is SubWord(w[1]) with no rotate and no round
    // constant: w[1] = 28aed2a6 maps through the S-box to 34e4b524.
    assert_eq!(&out[..4], &[0x34, 0xe4, 0xb5, 0x24]);
}

/// Every row must name a mnemonic the x86 assembler encodes, and every
/// builtin name must be unique.
#[test]
fn the_table_is_well_formed() {
    let mut seen: Vec<&str> = Vec::new();
    for row in x86_simd::OPS {
        assert!(
            row.name.starts_with("__builtin_ia32_"),
            "{}: not a gcc builtin spelling",
            row.name
        );
        assert!(!seen.contains(&row.name), "{}: duplicate row", row.name);
        seen.push(row.name);
        assert!(
            x86_simd::lookup(row.name).is_some(),
            "{}: not reachable by name",
            row.name
        );
    }
}
