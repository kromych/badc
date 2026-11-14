//! x86 SIMD intrinsic surface: the instruction each builtin emits, the
//! value semantics the interpreter evaluates, and the operand rules the
//! parser enforces.
//!
//! The expected encodings in the emission tests were produced with
//! `llvm-mc --triple=x86_64 --show-encoding` over the AT&T spelling in
//! each comment.

use crate::c5::simd::{self, Sem};
use crate::c5::x86_simd;

/// Vector typedefs the sources below operate on, matching the bundled
/// `<emmintrin.h>` set.
const VEC: &str = "typedef long long __m128i __attribute__((vector_size(16))); \
     typedef int __v4si __attribute__((vector_size(16))); \
     typedef short __v8hi __attribute__((vector_size(16))); \
     typedef char __v16qi __attribute__((vector_size(16))); \
     typedef long long __v2di __attribute__((vector_size(16))); \
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
        "__m128i f(const __m128i *p) { return (__m128i)__builtin_ia32_loaddqu((const char *)p); }",
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
    // Every two-operand form is `<op> %xmm14, %xmm15`, so the encodings
    // differ only in the opcode byte: pxor is 66 45 0f ef fe, paddd
    // 66 45 0f fe fe, and so on down the table.
    for (builtin, opcode) in [
        ("pxor128", 0xefu8),
        ("pand128", 0xdb),
        ("pandn128", 0xdf),
        ("por128", 0xeb),
        ("paddb128", 0xfc),
        ("paddw128", 0xfd),
        ("paddd128", 0xfe),
        ("paddq128", 0xd4),
        ("psubb128", 0xf8),
        ("psubw128", 0xf9),
        ("psubd128", 0xfa),
        ("psubq128", 0xfb),
        ("pmullw128", 0xd5),
        ("pmulhw128", 0xe5),
        ("pmulhuw128", 0xe4),
        ("pmaddwd128", 0xf5),
        ("pavgb128", 0xe0),
        ("pavgw128", 0xe3),
        ("pminsw128", 0xea),
        ("pmaxsw128", 0xee),
        ("pminub128", 0xda),
        ("pmaxub128", 0xde),
        ("pcmpeqb128", 0x74),
        ("pcmpeqw128", 0x75),
        ("pcmpeqd128", 0x76),
        ("pcmpgtb128", 0x64),
        ("pcmpgtw128", 0x65),
        ("pcmpgtd128", 0x66),
        ("paddsb128", 0xec),
        ("paddsw128", 0xed),
        ("paddusb128", 0xdc),
        ("paddusw128", 0xdd),
        ("psubsb128", 0xe8),
        ("psubsw128", 0xe9),
        ("psubusb128", 0xd8),
        ("psubusw128", 0xd9),
        ("psadbw128", 0xf6),
        ("packsswb128", 0x63),
        ("packssdw128", 0x6b),
        ("packuswb128", 0x67),
        ("punpcklbw128", 0x60),
        ("punpcklwd128", 0x61),
        ("punpckldq128", 0x62),
        ("punpcklqdq128", 0x6c),
        ("punpckhbw128", 0x68),
        ("punpckhwd128", 0x69),
        ("punpckhdq128", 0x6a),
        ("punpckhqdq128", 0x6d),
    ] {
        assert_emits(
            &format!(
                "__m128i f(__m128i a, __m128i b) {{ return (__m128i)__builtin_ia32_{builtin}(a, b); }}"
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
        ("psrawi128", 0x71, 0xe7, 3),
        ("psradi128", 0x72, 0xe7, 7),
    ] {
        assert_emits(
            &format!(
                "__m128i f(__m128i a) {{ return (__m128i)__builtin_ia32_{builtin}(a, {count}); }}"
            ),
            &[0x66, 0x41, 0x0f, opcode, modrm, count as u8],
            builtin,
        );
    }
    // The byte-granular shifts count bytes while their builtins take bits:
    // pslldq $0x4, %xmm15   66 41 0f 73 ff 04
    // psrldq $0x4, %xmm15   66 41 0f 73 df 04
    assert_emits(
        "__m128i f(__m128i a) { return __builtin_ia32_pslldqi128(a, 32); }",
        &[0x66, 0x41, 0x0f, 0x73, 0xff, 0x04],
        "pslldqi128",
    );
    assert_emits(
        "__m128i f(__m128i a) { return __builtin_ia32_psrldqi128(a, 32); }",
        &[0x66, 0x41, 0x0f, 0x73, 0xdf, 0x04],
        "psrldqi128",
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
    // psraw %xmm14, %xmm15   66 45 0f e1 fe
    assert_emits(
        "__m128i f(__m128i a, int n) { return (__m128i)__builtin_ia32_psrawi128(a, n); }",
        &[0x66, 0x45, 0x0f, 0xe1, 0xfe],
        "psraw register count",
    );
}

#[cfg(feature = "full")]
#[test]
fn shuffles_carry_their_immediate() {
    // pshufd  $0x93, %xmm14, %xmm15   66 45 0f 70 fe 93
    // pshuflw $0x1b, %xmm14, %xmm15   f2 45 0f 70 fe 1b
    // pshufhw $0x1b, %xmm14, %xmm15   f3 45 0f 70 fe 1b
    assert_emits(
        "__m128i f(__m128i a) { return (__m128i)__builtin_ia32_pshufd(a, 0x93); }",
        &[0x66, 0x45, 0x0f, 0x70, 0xfe, 0x93],
        "pshufd",
    );
    assert_emits(
        "__m128i f(__m128i a) { return (__m128i)__builtin_ia32_pshuflw(a, 0x1b); }",
        &[0xf2, 0x45, 0x0f, 0x70, 0xfe, 0x1b],
        "pshuflw",
    );
    assert_emits(
        "__m128i f(__m128i a) { return (__m128i)__builtin_ia32_pshufhw(a, 0x1b); }",
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
        "__m128i f(__m128i a, __m128i b) { return (__m128i)__builtin_ia32_pshufb128(a, b); }",
        &[0x66, 0x45, 0x0f, 0x38, 0x00, 0xfe],
        "pshufb",
    );
}

/// The SSSE3 forms take the 0F38 map, `66 45 0f 38 <op> fe`; PALIGNR's
/// builtin counts bits and the instruction bytes.
#[cfg(feature = "full")]
#[test]
fn ssse3_ops_emit_their_instruction() {
    for (builtin, opcode, unary) in [
        ("pabsb128", 0x1cu8, true),
        ("pabsw128", 0x1d, true),
        ("pabsd128", 0x1e, true),
        ("psignb128", 0x08, false),
        ("psignw128", 0x09, false),
        ("psignd128", 0x0a, false),
        ("phaddw128", 0x01, false),
        ("phaddd128", 0x02, false),
        ("phaddsw128", 0x03, false),
        ("phsubw128", 0x05, false),
        ("phsubd128", 0x06, false),
        ("phsubsw128", 0x07, false),
        ("pmulhrsw128", 0x0b, false),
    ] {
        let src = if unary {
            format!("__m128i f(__m128i a) {{ return (__m128i)__builtin_ia32_{builtin}(a); }}")
        } else {
            format!(
                "__m128i f(__m128i a, __m128i b) {{ return (__m128i)__builtin_ia32_{builtin}(a, b); }}"
            )
        };
        assert_emits(&src, &[0x66, 0x45, 0x0f, 0x38, opcode, 0xfe], builtin);
    }
    // palignr $0x5, %xmm14, %xmm15   66 45 0f 3a 0f fe 05
    assert_emits(
        "__m128i f(__m128i a, __m128i b) { return (__m128i)__builtin_ia32_palignr128(a, b, 40); }",
        &[0x66, 0x45, 0x0f, 0x3a, 0x0f, 0xfe, 0x05],
        "palignr",
    );
}

/// The SSE4.1 forms and PCMPGTQ take the 0F38 map, the immediate blends 0F3A.
#[cfg(feature = "full")]
#[test]
fn sse41_ops_emit_their_instruction() {
    for (builtin, opcode, unary) in [
        ("pminsb128", 0x38u8, false),
        ("pmaxsb128", 0x3c, false),
        ("pminuw128", 0x3a, false),
        ("pmaxuw128", 0x3e, false),
        ("pminsd128", 0x39, false),
        ("pmaxsd128", 0x3d, false),
        ("pminud128", 0x3b, false),
        ("pmaxud128", 0x3f, false),
        ("pmulld128", 0x40, false),
        ("pmuldq128", 0x28, false),
        ("packusdw128", 0x2b, false),
        ("pcmpgtq", 0x37, false),
        ("pmovsxbw128", 0x20, true),
        ("pmovsxbd128", 0x21, true),
        ("pmovsxbq128", 0x22, true),
        ("pmovsxwd128", 0x23, true),
        ("pmovsxwq128", 0x24, true),
        ("pmovsxdq128", 0x25, true),
        ("pmovzxbw128", 0x30, true),
        ("pmovzxbd128", 0x31, true),
        ("pmovzxbq128", 0x32, true),
        ("pmovzxwd128", 0x33, true),
        ("pmovzxwq128", 0x34, true),
        ("pmovzxdq128", 0x35, true),
    ] {
        let src = if unary {
            format!("__m128i f(__m128i a) {{ return (__m128i)__builtin_ia32_{builtin}(a); }}")
        } else {
            format!(
                "__m128i f(__m128i a, __m128i b) {{ return (__m128i)__builtin_ia32_{builtin}(a, b); }}"
            )
        };
        assert_emits(&src, &[0x66, 0x45, 0x0f, 0x38, opcode, 0xfe], builtin);
    }
    // pblendw $0xa5, %xmm14, %xmm15   66 45 0f 3a 0e fe a5
    // blendps $0x5, %xmm14, %xmm15    66 45 0f 3a 0c fe 05
    // blendpd $0x2, %xmm14, %xmm15    66 45 0f 3a 0d fe 02
    for (builtin, opcode, imm) in [
        ("pblendw128", 0x0eu8, 0xa5u8),
        ("blendps", 0x0c, 5),
        ("blendpd", 0x0d, 2),
    ] {
        assert_emits(
            &format!(
                "__m128i f(__m128i a, __m128i b) {{ return (__m128i)__builtin_ia32_{builtin}(a, b, {imm}); }}"
            ),
            &[0x66, 0x45, 0x0f, 0x3a, opcode, 0xfe, imm],
            builtin,
        );
    }
}

#[cfg(feature = "full")]
#[test]
fn element_access_uses_the_extract_and_insert_instructions() {
    // Alone in this file, these encodings name a general register, which
    // the `codegen_test` pressure knobs reallocate. The rest stage through
    // the fixed xmm14/xmm15 pair and hold under them.
    if std::env::var_os("BADC_MAX_GPR").is_some() || std::env::var_os("BADC_MAX_FPR").is_some() {
        return;
    }
    // pextrw   $0x3, %xmm14, %r11d      66 45 0f c5 de 03
    // pextrd   $0x2, %xmm14, %r11d      66 45 0f 3a 16 f3 02
    // pinsrd   $0x1, %edx, %xmm15       66 44 0f 3a 22 fa 01
    // pinsrw   $0x2, %edx, %xmm15       66 44 0f c4 fa 02
    // pmovmskb %xmm14, %r11d            66 45 0f d7 de
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
        "__m128i f(__m128i a, int x) { return (__m128i)__builtin_ia32_vec_set_v4si(a, x, 1); }",
        &[0x66, 0x44, 0x0f, 0x3a, 0x22, 0xfa, 0x01],
        "pinsrd",
    );
    // The word insert reads a 32-bit register, as the instruction does.
    assert_emits(
        "__m128i f(__m128i a, int x) { return (__m128i)__builtin_ia32_vec_set_v8hi(a, x, 2); }",
        &[0x66, 0x44, 0x0f, 0xc4, 0xfa, 0x02],
        "pinsrw",
    );
    // pextrb $0x3, %xmm14, %r11d   66 45 0f 3a 14 f3 03
    // pextrq $0x1, %xmm14, %r11    66 4d 0f 3a 16 f3 01
    // movq   %r11, (%rax)          4c 89 18, the quadword stored whole
    // pinsrb $0x5, %edx, %xmm15    66 44 0f 3a 20 fa 05
    // pinsrq $0x1, %rdx, %xmm15    66 4c 0f 3a 22 fa 01
    assert_emits(
        "int f(__m128i a) { return __builtin_ia32_vec_ext_v16qi(a, 3); }",
        &[0x66, 0x45, 0x0f, 0x3a, 0x14, 0xf3, 0x03],
        "pextrb",
    );
    assert_emits(
        "long long f(__m128i a) { return __builtin_ia32_vec_ext_v2di(a, 1); }",
        &[0x66, 0x4d, 0x0f, 0x3a, 0x16, 0xf3, 0x01, 0x4c, 0x89, 0x18],
        "pextrq",
    );
    assert_emits(
        "__m128i f(__m128i a, int x) { return (__m128i)__builtin_ia32_vec_set_v16qi(a, x, 5); }",
        &[0x66, 0x44, 0x0f, 0x3a, 0x20, 0xfa, 0x05],
        "pinsrb",
    );
    assert_emits(
        "__m128i f(__m128i a, long long x) { return (__m128i)__builtin_ia32_vec_set_v2di(a, x, 1); }",
        &[0x66, 0x4c, 0x0f, 0x3a, 0x22, 0xfa, 0x01],
        "pinsrq",
    );
    assert_emits(
        "int f(__m128i a) { return __builtin_ia32_pmovmskb128(a); }",
        &[0x66, 0x45, 0x0f, 0xd7, 0xde],
        "pmovmskb",
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
                "__m128i f(__m128i a, __m128i b) {{ return (__m128i)__builtin_ia32_{builtin}(a, b); }}"
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
             v = _mm_srai_epi16(v, 3);\n\
             v = _mm_srli_si128(v, 2);\n\
             v = _mm_madd_epi16(v, k);\n\
             v = _mm_packus_epi16(v, k);\n\
             v = _mm_unpacklo_epi8(v, k);\n\
             v = _mm_insert_epi16(v, _mm_movemask_epi8(k), 3);\n\
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
        (&[0x66, 0x41, 0x0f, 0x71, 0xe7, 0x03][..], "psraw $3"),
        (&[0x66, 0x41, 0x0f, 0x73, 0xdf, 0x02][..], "psrldq $2"),
        (&[0x66, 0x45, 0x0f, 0xf5, 0xfe][..], "pmaddwd"),
        (&[0x66, 0x45, 0x0f, 0x67, 0xfe][..], "packuswb"),
        (&[0x66, 0x45, 0x0f, 0x60, 0xfe][..], "punpcklbw"),
        (&[0x66, 0x45, 0x0f, 0xd7, 0xde][..], "pmovmskb"),
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

/// The interpreter reads the same table as the emit, including the
/// shift whose constant count rides the node instead of an operand.
#[test]
fn the_interpreter_runs_the_builtins() {
    let src = format!(
        "{VEC}int main(void) {{ \
             short lanes[8]; \
             __m128i a = (__m128i)(__v8hi){{-16, -16, -16, -16, -16, -16, -16, -16}}; \
             __builtin_ia32_storedqu((char *)lanes, __builtin_ia32_psrawi128((__v8hi)a, 2)); \
             if (lanes[0] != -4 || lanes[7] != -4) {{ return 1; }} \
             __builtin_ia32_storedqu((char *)lanes, \
                 __builtin_ia32_punpcklwd128((__v8hi)a, (__v8hi)a)); \
             if (lanes[0] != -16 || lanes[1] != -16) {{ return 2; }} \
             return __builtin_ia32_pmovmskb128((__v16qi)a) == 0xffff ? 0 : 3; \
         }}"
    );
    let program = super::compile_str_bare_for(&src, crate::Target::LinuxX64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "the interpreter must agree with the instruction"
    );
}

/// `<pmmintrin.h>` and the `<mmintrin.h>` it reaches give each MMX and SSE3
/// operation the result the SDM defines for its instruction, saturation,
/// out-of-range shift counts and the pair-sum wrap included, as the
/// interpreter runs them on any host; the `mmx_sse3_and_mm_malloc_intrinsics`
/// fixture runs them natively with EMMS, MXCSR and the allocator.
#[test]
fn mmx_and_sse3_operations_follow_the_sdm() {
    let src = "#include <pmmintrin.h>\n\
        #define Q(m) ((unsigned long long)_mm_cvtm64_si64(m))\n\
        int main(void) {\n\
            if (Q(_mm_packs_pi16(_mm_setr_pi16(300, -300, 5, -5), \
                                 _mm_setr_pi16(127, -128, 32767, -32768))) != 0x807F807FFB05807FULL) return 1;\n\
            if (Q(_mm_packs_pu16(_mm_setr_pi16(300, -300, 5, 255), _mm_setr_pi16(256, 0, 128, -1))) \
                != 0x008000FFFF0500FFULL) return 2;\n\
            if (Q(_mm_unpackhi_pi8(_mm_setr_pi8(1, 2, 3, 4, 5, 6, 7, 8), \
                                   _mm_setr_pi8(11, 12, 13, 14, 15, 16, 17, 18))) != 0x1208110710060F05ULL) return 3;\n\
            if (Q(_mm_adds_pi8(_mm_set1_pi8(100), _mm_set1_pi8(100))) != 0x7F7F7F7F7F7F7F7FULL) return 4;\n\
            if (Q(_mm_subs_pu16(_mm_set1_pi16(5), _mm_set1_pi16(7))) != 0) return 5;\n\
            if (Q(_mm_madd_pi16(_mm_set1_pi16(-32768), _mm_set1_pi16(-32768))) != 0x8000000080000000ULL) return 6;\n\
            if (Q(_mm_mullo_pi16(_mm_set1_pi16(300), _mm_set1_pi16(300))) != 0x5F905F905F905F90ULL) return 7;\n\
            if (Q(_mm_slli_pi16(_mm_set1_pi16(1), 16)) != 0 || \
                Q(_mm_srai_pi16(_mm_set1_pi16(-32768), 20)) != 0xFFFFFFFFFFFFFFFFULL) return 8;\n\
            if (Q(_mm_sll_si64(_mm_cvtsi64_m64(1), _mm_cvtsi64_m64(63))) != 0x8000000000000000ULL) return 9;\n\
            if (Q(_mm_cmpgt_pi32(_mm_set_pi32(-1, 5), _mm_set_pi32(0, 4))) != 0x00000000FFFFFFFFULL) return 10;\n\
            __m128 r = _mm_hadd_ps((__m128){1, 2, 3, 4}, (__m128){5, 6, 7, 8});\n\
            if (r[0] != 3 || r[1] != 7 || r[2] != 11 || r[3] != 15) return 11;\n\
            r = _mm_addsub_ps((__m128){1, 2, 3, 4}, (__m128){0.5f, 0.5f, 0.5f, 0.5f});\n\
            if (r[0] != 0.5f || r[1] != 2.5f || r[2] != 2.5f || r[3] != 4.5f) return 12;\n\
            __m128d d = _mm_hsub_pd((__m128d){1, 2}, (__m128d){3, 5});\n\
            return d[0] == -1 && d[1] == -2 ? 0 : 13;\n\
        }\n";
    let program = super::compile_str_bare_for(src, crate::Target::LinuxX64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "the MMX and SSE3 operations must give the instruction's result"
    );
}

/// The `__m64` forms of `<xmmintrin.h>`, `<emmintrin.h>` and `<tmmintrin.h>`
/// give the result the SDM defines for each instruction, as the interpreter
/// runs them on any host; the `sse_sse2_ssse3_m64_forms_follow_the_sdm`
/// fixture checks every form natively, the MXCSR-rounded conversions with it.
#[test]
fn m64_forms_of_sse_sse2_and_ssse3_follow_the_sdm() {
    let src = "#include <tmmintrin.h>\n\
        #define Q(m) ((unsigned long long)_mm_cvtm64_si64(m))\n\
        #define M(q) _mm_cvtsi64_m64((long long)(q))\n\
        int main(void) {\n\
            __m64 a = M(0x80FF7F0102FE10F0ULL), b = M(0x01FF80FF7F0203F1ULL);\n\
            if (Q(_mm_avg_pu8(a, b)) != 0x41FF808041800AF1ULL) return 1;\n\
            if (Q(_mm_sad_pu8(a, b)) != 0x0000000000000305ULL) return 2;\n\
            if (_mm_movemask_pi8(a) != 0xC5 || _mm_extract_pi16(a, 3) != 0x80FF) return 3;\n\
            if (Q(_mm_shuffle_pi16(a, 0x1B)) != 0x10F002FE7F0180FFULL) return 4;\n\
            if (Q(_mm_insert_pi16(a, 0x1234, 1)) != 0x80FF7F01123410F0ULL) return 5;\n\
            if (Q(_mm_max_pi16(a, b)) != 0x01FF7F017F0210F0ULL ||\n\
                Q(_mm_min_pu8(a, b)) != 0x01FF7F01020203F0ULL) return 6;\n\
            if (Q(_mm_mulhi_pu16(M(0xFFFF000200030004ULL), M(0xFFFF800080008000ULL))) !=\n\
                0xFFFE000100010002ULL) return 7;\n\
            char buf[8] = {0};\n\
            _mm_maskmove_si64(M(0x0807060504030201ULL), M(0x80000080000080FFULL), buf);\n\
            if (buf[0] != 1 || buf[1] != 2 || buf[2] || buf[4] != 5 || buf[7] != 8) return 8;\n\
            if (Q(_mm_mul_su32(M(0xFFFFFFFF), M(0x1FFFFFFFFULL))) != 0xFFFFFFFE00000001ULL) return 9;\n\
            __m128i x = _mm_set_epi64(M(1), _mm_movepi64_pi64(_mm_movpi64_epi64(M(5))));\n\
            if (x[0] != 5 || x[1] != 1) return 10;\n\
            __m128 f = _mm_cvtpu8_ps(M(0xFF80));\n\
            if (f[0] != 128.f || f[1] != 255.f || f[2] != 0.f) return 11;\n\
            __m128d d = _mm_cvtpi32_pd(_mm_set_pi32(-3, 7));\n\
            if (d[0] != 7 || d[1] != -3) return 12;\n\
            if (Q(_mm_abs_pi8(M(0x80FF7F01ULL))) != 0x80017F01ULL ||\n\
                Q(_mm_sign_pi16(M(0x8000000500050005ULL), M(0xFFFF0000FFFF0001ULL))) !=\n\
                0x80000000FFFB0005ULL) return 13;\n\
            if (Q(_mm_hadds_pi16(M(0x7FFF7FFF00010002ULL), M(0x8000800000030004ULL))) !=\n\
                0x800000077FFF0003ULL) return 14;\n\
            if (Q(_mm_maddubs_pi16(M(0xFFFFFFFF0201ULL), M(0x7F7F7F7F0304ULL))) != 0x7FFF7FFF000AULL) return 15;\n\
            if (Q(_mm_mulhrs_pi16(M(0x8000400000010000ULL), M(0x8000400040000000ULL))) !=\n\
                0x8000200000010000ULL) return 16;\n\
            if (Q(_mm_shuffle_pi8(M(0x0807060504030201ULL), M(0x80000F0700010203ULL))) !=\n\
                0x0001080801020304ULL) return 17;\n\
            if (Q(_mm_alignr_pi8(M(0x1111111122222222ULL), M(0x3333333344444444ULL), 4)) !=\n\
                0x2222222233333333ULL ||\n\
                Q(_mm_alignr_pi8(M(1), M(2), 16)) != 0) return 18;\n\
            return 0;\n\
        }\n";
    let program = super::compile_str_bare_for(src, crate::Target::LinuxX64);
    assert_eq!(
        super::Vm::new(program).run().expect("interpreted run"),
        0,
        "the __m64 forms must give the instruction's result"
    );
}

/// The x86 system-instruction builtins, with gcc's prototypes, emit their
/// instruction on both x86-64 targets, `__builtin_ia32_xgetbv` with its
/// operand in ecx; on the AArch64 targets `__has_builtin` reports none of
/// them and a call is to an unknown function.
#[cfg(feature = "full")]
#[test]
fn the_x86_system_builtins_emit_their_instruction() {
    use crate::{Compiler, NativeOptions, Target};
    let src = "void fences(void) {\n\
            __builtin_ia32_sfence(); __builtin_ia32_lfence(); __builtin_ia32_mfence();\n\
            __builtin_ia32_pause();\n\
        }\n\
        unsigned long long tsc(void) { return __builtin_ia32_rdtsc(); }\n\
        unsigned long long xcr(unsigned int i) { return __builtin_ia32_xgetbv(i); }\n\
        unsigned long long flags(void) { return __builtin_ia32_readeflags_u64(); }\n\
        _Static_assert(_Generic(__builtin_ia32_rdtsc(), unsigned long long: 1, default: 0), \"rdtsc\");\n\
        _Static_assert(_Generic(__builtin_ia32_xgetbv(0), unsigned long long: 1, default: 0), \"xgetbv\");\n\
        int main(void) { return 0; }\n";
    for target in [Target::LinuxX64, Target::WindowsX64] {
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
        let bytes = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .expect("emit_native");
        for (needle, what) in [
            (&[0x0fu8, 0xae, 0xf8][..], "sfence"),
            (&[0x0f, 0xae, 0xe8][..], "lfence"),
            (&[0x0f, 0xae, 0xf0][..], "mfence"),
            (&[0xf3, 0x90][..], "pause"),
            (&[0x0f, 0x31][..], "rdtsc"),
            (&[0x0f, 0x01, 0xd0][..], "xgetbv"),
        ] {
            assert!(
                bytes.windows(needle.len()).any(|w| w == needle),
                "{target:?}: {what}: {needle:02x?} not in the emitted code"
            );
        }
        // pushfq, then a pop into a general register, REX.B or not.
        let pop = |w: &[u8]| {
            (0x58..=0x5f).contains(&w[0]) || (w[0] == 0x41 && (0x58..=0x5f).contains(&w[1]))
        };
        assert!(
            bytes.windows(3).any(|w| w[0] == 0x9c && pop(&w[1..])),
            "{target:?}: pushfq; pop not in the emitted code"
        );
    }
    for target in [
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsAarch64,
    ] {
        let probe = "#if __has_builtin(__builtin_ia32_pause) || __has_builtin(__builtin_ia32_rdtsc)\n\
            #error \"x86 builtin\"\n#endif\nint main(void) { return 0; }\n";
        Compiler::with_target(probe.to_string(), target)
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
        let call = "void f(void) { __builtin_ia32_sfence(); }\nint main(void) { return 0; }\n";
        let err = Compiler::with_target(call.to_string(), target)
            .compile()
            .err()
            .unwrap_or_else(|| panic!("{target:?}: the call compiled"));
        assert!(
            alloc::format!("{err}").contains("unknown function"),
            "{target:?}: {err}"
        );
    }
}

/// The header wrappers over the system builtins emit their instruction on
/// both x86-64 targets: the `_mm_` fences, `_xgetbv`, `__rdtscp` and the
/// RFLAGS pair, with the builtins `rdtscp` and `writeeflags_u64`. `_xgetbv`
/// is gcc's `long long` on Linux and MSVC's `unsigned __int64` intrinsic on
/// Windows, where every name here is one.
#[cfg(feature = "full")]
#[test]
fn the_x86_system_wrappers_emit_their_instruction() {
    use crate::{Compiler, NativeOptions, Target};
    for (target, xgetbv_ty) in [
        (Target::LinuxX64, "long long"),
        (Target::WindowsX64, "unsigned long long"),
    ] {
        let src = alloc::format!(
            "#include <x86intrin.h>\n\
            void fences(void) {{ _mm_sfence(); _mm_lfence(); _mm_mfence(); }}\n\
            unsigned long long tscp(unsigned *a) {{ return __rdtscp(a) + __builtin_ia32_rdtscp(a); }}\n\
            unsigned long long xcr(void) {{ return _xgetbv(0); }}\n\
            void flags(unsigned long long f) {{\n\
                __writeeflags(f); __builtin_ia32_writeeflags_u64(__readeflags());\n\
            }}\n\
            _Static_assert(_Generic(_xgetbv(0), {xgetbv_ty}: 1, default: 0), \"xgetbv\");\n\
            _Static_assert(_Generic(__readeflags(), unsigned long long: 1, default: 0), \"flags\");\n\
            _Static_assert(_Generic(__rdtscp(0), unsigned long long: 1, default: 0), \"rdtscp\");\n\
            int main(void) {{ return 0; }}\n"
        );
        let program = Compiler::with_target(src, target)
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
        let bytes = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .expect("emit_native");
        for (needle, what) in [
            (&[0x0fu8, 0xae, 0xf8][..], "sfence"),
            (&[0x0f, 0xae, 0xe8][..], "lfence"),
            (&[0x0f, 0xae, 0xf0][..], "mfence"),
            (&[0x0f, 0x01, 0xf9][..], "rdtscp"),
            (&[0x0f, 0x01, 0xd0][..], "xgetbv"),
            (&[0x9c][..], "pushfq"),
            (&[0x9d][..], "popfq"),
        ] {
            assert!(
                bytes.windows(needle.len()).any(|w| w == needle),
                "{target:?}: {what}: {needle:02x?} not in the emitted code"
            );
        }
    }
}

/// MSVC's x64 system intrinsics a kernel-mode driver calls lower to their
/// instruction on windows-x64, undeclared as MSVC compiles them: the
/// control, debug and model-specific registers, the descriptor tables, the
/// VMX instructions with their status flags, SVM and port I/O. Each function
/// holds one call; its opcode, and the ModRM reg field naming the register
/// or the opcode extension, appear in it, a REX prefix aside. No other
/// target knows the names.
#[cfg(feature = "full")]
#[test]
fn the_msvc_system_intrinsics_emit_their_instruction() {
    use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, Target};
    // A byte whose bits under the mask are the value.
    type Pattern = &'static [(u8, u8)];
    const fn x(b: u8) -> (u8, u8) {
        (b, 0xff)
    }
    const fn reg(r: u8) -> (u8, u8) {
        (r << 3, 0x38)
    }
    const REX: (u8, u8) = (0x40, 0xf0);
    const CASES: &[(&str, &str, &[Pattern])] = &[
        (
            "unsigned long long",
            "__readcr0()",
            &[&[x(0x0f), x(0x20), reg(0)]],
        ),
        (
            "unsigned long long",
            "__readcr2()",
            &[&[x(0x0f), x(0x20), reg(2)]],
        ),
        (
            "unsigned long long",
            "__readcr3()",
            &[&[x(0x0f), x(0x20), reg(3)]],
        ),
        (
            "unsigned long long",
            "__readcr4()",
            &[&[x(0x0f), x(0x20), reg(4)]],
        ),
        (
            "unsigned long long",
            "__readcr8()",
            &[&[(0x44, 0xf4), x(0x0f), x(0x20), reg(0)]],
        ),
        ("void", "__writecr0(v)", &[&[x(0x0f), x(0x22), reg(0)]]),
        ("void", "__writecr3(v)", &[&[x(0x0f), x(0x22), reg(3)]]),
        ("void", "__writecr4(v)", &[&[x(0x0f), x(0x22), reg(4)]]),
        (
            "void",
            "__writecr8(v)",
            &[&[(0x44, 0xf4), x(0x0f), x(0x22), reg(0)]],
        ),
        (
            "unsigned long long",
            "__readdr(7)",
            &[&[x(0x0f), x(0x21), reg(7)]],
        ),
        ("void", "__writedr(3, v)", &[&[x(0x0f), x(0x23), reg(3)]]),
        (
            "unsigned long long",
            "__readmsr(0xc0000080)",
            &[&[x(0x0f), x(0x32)]],
        ),
        ("void", "__writemsr(0xc0000080, v)", &[&[x(0x0f), x(0x30)]]),
        ("unsigned long long", "__readpmc(1)", &[&[x(0x0f), x(0x33)]]),
        ("void", "_xsetbv(0, v)", &[&[x(0x0f), x(0x01), x(0xd1)]]),
        ("void", "__lidt(p)", &[&[x(0x0f), x(0x01), reg(3)]]),
        ("void", "__sidt(p)", &[&[x(0x0f), x(0x01), reg(1)]]),
        ("void", "_lgdt(p)", &[&[x(0x0f), x(0x01), reg(2)]]),
        ("void", "_sgdt(p)", &[&[x(0x0f), x(0x01), reg(0)]]),
        ("void", "__invlpg(p)", &[&[x(0x0f), x(0x01), reg(7)]]),
        ("void", "_invpcid(2, p)", &[&[x(0x0f), x(0x38), x(0x82)]]),
        (
            "unsigned long",
            "__segmentlimit(0x10)",
            &[&[x(0x0f), x(0x03)]],
        ),
        ("void", "__wbinvd()", &[&[x(0x0f), x(0x09)]]),
        ("void", "__int2c()", &[&[x(0xcd), x(0x2c)]]),
        ("void", "_m_prefetchw(p)", &[&[x(0x0f), x(0x0d), reg(1)]]),
        ("void", "_disable(), _enable()", &[&[x(0xfa), x(0xfb)]]),
        (
            "unsigned char",
            "__vmx_on(q)",
            &[
                &[x(0xf3), x(0x0f), x(0xc7), reg(6)],
                &[x(0xf3), REX, x(0x0f), x(0xc7), reg(6)],
            ],
        ),
        ("void", "__vmx_off()", &[&[x(0x0f), x(0x01), x(0xc4)]]),
        (
            "unsigned char",
            "__vmx_vmclear(q)",
            &[
                &[x(0x66), x(0x0f), x(0xc7), reg(6)],
                &[x(0x66), REX, x(0x0f), x(0xc7), reg(6)],
            ],
        ),
        (
            "unsigned char",
            "__vmx_vmptrld(q)",
            &[&[x(0x0f), x(0xc7), reg(6)]],
        ),
        ("void", "__vmx_vmptrst(q)", &[&[x(0x0f), x(0xc7), reg(7)]]),
        (
            "unsigned char",
            "__vmx_vmlaunch()",
            &[&[x(0x0f), x(0x01), x(0xc2)]],
        ),
        (
            "unsigned char",
            "__vmx_vmresume()",
            &[&[x(0x0f), x(0x01), x(0xc3)]],
        ),
        (
            "unsigned char",
            "__vmx_vmread(0x4400, q)",
            &[&[x(0x0f), x(0x78)]],
        ),
        (
            "unsigned char",
            "__vmx_vmwrite(0x681e, v)",
            &[&[x(0x0f), x(0x79)]],
        ),
        ("void", "__svm_clgi()", &[&[x(0x0f), x(0x01), x(0xdd)]]),
        ("void", "__svm_stgi()", &[&[x(0x0f), x(0x01), x(0xdc)]]),
        ("void", "__svm_vmload(v)", &[&[x(0x0f), x(0x01), x(0xda)]]),
        ("void", "__svm_vmsave(v)", &[&[x(0x0f), x(0x01), x(0xdb)]]),
        ("void", "__svm_vmrun(v)", &[&[x(0x0f), x(0x01), x(0xd8)]]),
        ("unsigned short", "__inword(port)", &[&[x(0x66), x(0xed)]]),
        ("void", "__outword(port, 7)", &[&[x(0x66), x(0xef)]]),
        ("void", "__inbytestring(port, b, 4)", &[&[x(0xf3), x(0x6c)]]),
        (
            "void",
            "__outdwordstring(port, (unsigned long *)b, 2)",
            &[&[x(0xf3), x(0x6f)]],
        ),
    ];
    let mut src = String::new();
    for (i, (ret, call, _)) in CASES.iter().enumerate() {
        let body = if *ret == "void" {
            alloc::format!("{call};")
        } else {
            alloc::format!("return {call};")
        };
        src.push_str(&alloc::format!(
            "{ret} f{i}(unsigned long long v, void *p, unsigned long long *q, \
             unsigned short port, unsigned char *b) {{ {body} }}\n"
        ));
    }
    let opts = CompileOptions::default().with_no_entry_point(true);
    let program = Compiler::with_options(src.clone(), Target::WindowsX64, opts)
        .compile()
        .unwrap_or_else(|e| panic!("{e}"));
    let nopts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::default()
    };
    let obj = crate::emit_native_with_options(&program, Target::WindowsX64, nopts.clone())
        .expect("emit the object");
    let fits = |w: &[u8], p: Pattern| w.iter().zip(p).all(|(b, (v, m))| b & m == *v);
    for (i, (ret, call, patterns)) in CASES.iter().enumerate() {
        let bytes = super::codegen::function_bytes(&obj, &alloc::format!("f{i}"));
        let found = (patterns.iter()).any(|p| bytes.windows(p.len()).any(|w| fits(w, p)));
        assert!(found, "{call}: {patterns:02x?} not in {bytes:02x?}");
        if call.starts_with("__vmx") && *ret == "unsigned char" {
            let flags = [[0x0f, 0x94], [0x0f, 0x92]];
            assert!(
                flags.iter().all(|f| bytes.windows(2).any(|w| w == f)),
                "{call}: setz and setc not in {bytes:02x?}"
            );
        }
    }
    // `_byteswap_ulong` is the UCRT's function until `#pragma intrinsic`
    // names it, as under cl without `/Oi`.
    for (pragma, swaps) in [("", false), ("#pragma intrinsic(_byteswap_ulong)\n", true)] {
        let src = alloc::format!(
            "#include <intrin.h>\n{pragma}unsigned long f(unsigned long x) {{ return _byteswap_ulong(x); }}\n"
        );
        let opts = CompileOptions::default().with_no_entry_point(true);
        let program = Compiler::with_options(src, Target::WindowsX64, opts)
            .compile()
            .unwrap_or_else(|e| panic!("{e}"));
        let obj = crate::emit_native_with_options(&program, Target::WindowsX64, nopts.clone())
            .expect("emit the object");
        let bytes = super::codegen::function_bytes(&obj, "f");
        let bswap = bytes
            .windows(2)
            .any(|w| w[0] == 0x0f && w[1] & 0xf8 == 0xc8);
        assert_eq!(bswap, swaps, "{pragma:?}: {bytes:02x?}");
    }
    for target in [Target::LinuxX64, Target::WindowsAarch64] {
        let call = "void f(void) { __wbinvd(); }\nint main(void) { return 0; }\n";
        let err = Compiler::with_target(call.to_string(), target)
            .compile()
            .err()
            .unwrap_or_else(|| panic!("{target:?}: the call compiled"));
        assert!(
            alloc::format!("{err}").contains("unknown function"),
            "{target:?}: {err}"
        );
    }
}

/// A unit may not define an intrinsic's name, as cl rejects it (C2169):
/// every call lowers to the intrinsic, so the body would never run.
/// `#pragma function(name)` makes the name a function, which calls reach,
/// and `#pragma intrinsic(name)` takes that back. The name is free on a
/// target where it is no intrinsic.
#[cfg(feature = "full")]
#[test]
fn a_definition_of_an_intrinsic_needs_pragma_function() {
    use crate::{CompileOptions, Compiler, NativeOptions, OutputKind, Target};
    let body = "static unsigned long __segmentlimit(unsigned long s) { return s + 7; }\n\
                unsigned long f(unsigned long s) { return __segmentlimit(s); }\n";
    let compile = |src: String, target| {
        let opts = CompileOptions::default().with_no_entry_point(true);
        Compiler::with_options(src, target, opts).compile()
    };
    let Err(err) = compile(body.to_string(), Target::WindowsX64) else {
        panic!("the definition compiled");
    };
    let text = alloc::format!("{err}");
    assert!(
        text.contains("`__segmentlimit` is an intrinsic, which cannot be defined")
            && text.contains("[B2021]"),
        "{text}"
    );
    let program = compile(
        alloc::format!("#pragma function(__segmentlimit)\n{body}"),
        Target::WindowsX64,
    )
    .unwrap_or_else(|e| panic!("{e}"));
    let nopts = NativeOptions {
        output_kind: OutputKind::Relocatable,
        ..NativeOptions::default()
    };
    let obj = crate::emit_native_with_options(&program, Target::WindowsX64, nopts)
        .expect("emit the object");
    let f = super::codegen::function_bytes(&obj, "f");
    assert!(
        !f.windows(2).any(|w| w == [0x0f, 0x03]) && f.contains(&0xe8),
        "f calls the definition, not `lsl`: {f:02x?}"
    );
    let restored = alloc::format!(
        "#pragma function(__segmentlimit)\n#pragma intrinsic(__segmentlimit)\n{body}"
    );
    assert!(compile(restored, Target::WindowsX64).is_err());
    compile(body.to_string(), Target::LinuxX64).unwrap_or_else(|e| panic!("{e}"));
}

/// MSVC's x64 string intrinsics lower to their `rep stos` and `rep movs`
/// forms on windows-x64, whatever declares them; windows-arm64 has none.
#[cfg(feature = "full")]
#[test]
fn the_msvc_string_intrinsics_emit_rep_stos_and_rep_movs() {
    use crate::{Compiler, NativeOptions, Target};
    let src = "#include <intrin.h>\n\
        void s(unsigned char *b, unsigned short *w, unsigned long *d, unsigned long long *q,\n\
               unsigned long long n) {\n\
            __stosb(b, 1, n); __stosw(w, 2, n); __stosd(d, 3, n); __stosq(q, 4, n);\n\
            __movsb(b, b + 64, n); __movsw(w, w + 64, n); __movsd(d, d + 64, n);\n\
            __movsq(q, q + 64, n);\n\
        }\n\
        int main(void) { return 0; }\n";
    let program = Compiler::with_target(src.into(), Target::WindowsX64)
        .compile()
        .unwrap_or_else(|e| panic!("{e}"));
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::WindowsX64,
        NativeOptions::default(),
    )
    .expect("emit_native");
    for (needle, what) in [
        (&[0xf3u8, 0xaa][..], "rep stosb"),
        (&[0x66, 0xf3, 0xab][..], "rep stosw"),
        (&[0xf3, 0xab][..], "rep stosl"),
        (&[0xf3, 0x48, 0xab][..], "rep stosq"),
        (&[0xf3, 0xa4][..], "rep movsb"),
        (&[0x66, 0xf3, 0xa5][..], "rep movsw"),
        (&[0xf3, 0xa5][..], "rep movsl"),
        (&[0xf3, 0x48, 0xa5][..], "rep movsq"),
    ] {
        assert!(
            bytes.windows(needle.len()).any(|w| w == needle),
            "{what}: {needle:02x?} not in the emitted code"
        );
    }
    let err = Compiler::with_target(
        "void f(unsigned char *b) { __stosb(b, 0, 1); }\n".into(),
        Target::WindowsAarch64,
    )
    .compile()
    .expect_err("no __stosb on arm64");
    assert!(err.to_string().contains("__stosb"), "{err}");
}

/// `<cpuid.h>` executes CPUID: `__get_cpuid_max` emits the instruction on
/// both x86-64 targets with the range's first leaf in eax, rather than
/// folding to a constant. The interpreter runs CPUID as zero in every
/// register, so there the maximum is 0 and `__get_cpuid` rejects the leaf,
/// leaving its outputs as they were.
#[cfg(feature = "full")]
#[test]
fn cpuid_h_executes_the_instruction() {
    use crate::{Compiler, NativeOptions, Target};
    let src = "#include <cpuid.h>\n\
        unsigned int basic(unsigned int *sig) { return __get_cpuid_max(0, sig); }\n\
        int main(void) {\n\
            unsigned int sig = 7, a = 9, b = 9, c = 9, d = 9;\n\
            if (basic(&sig) != 0 || sig != 0) return 1;\n\
            if (__get_cpuid(1, &a, &b, &c, &d) || a != 9 || d != 9) return 2;\n\
            return bit_SSE2 == (1 << 26) && signature_INTEL_ebx == 0x756e6547 ? 0 : 3;\n\
        }\n";
    for target in [Target::LinuxX64, Target::WindowsX64] {
        let program = Compiler::with_target(src.to_string(), target)
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
        let bytes = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            target,
            NativeOptions::default(),
        )
        .expect("emit_native");
        assert!(
            bytes.windows(2).any(|w| w == [0x0f, 0xa2]),
            "{target:?}: cpuid not in the emitted code"
        );
        let program = super::compile_str_bare_for(src, target);
        assert_eq!(
            super::Vm::new(program).run().expect("interpreted run"),
            0,
            "{target:?}: the interpreter's CPUID"
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

/// A result carries the type the builtin's prototype declares, the `__vN..`
/// typedef of its lanes, so it returns as that typedef with no cast; a
/// different typedef is still an incompatible return.
#[test]
fn results_carry_the_prototypes_vector_types() {
    let src = format!(
        "{VEC}\
         __v4si f1(__v4si a, __v4si b) {{ return __builtin_ia32_paddd128(a, b); }} \
         __v8hi f2(__v8hi a, __v8hi b) {{ return __builtin_ia32_paddw128(a, b); }} \
         __v16qi f3(__v16qi a, __v16qi b) {{ return __builtin_ia32_pshufb128(a, b); }} \
         __v2di f4(__v2di a, __v2di b) {{ return __builtin_ia32_pand128(a, b); }} \
         __v2df f5(__v2df a, __v2df b) {{ return __builtin_ia32_shufpd(a, b, 1); }} \
         __v4si f6(__v8hi a, __v8hi b) {{ return __builtin_ia32_pmaddwd128(a, b); }} \
         __v16qi f7(const char *p) {{ return __builtin_ia32_loaddqu(p); }} \
         __v8hi f8(__v8hi a) {{ return __builtin_ia32_psllwi128(a, 3); }} \
         __v4si f9(__v4si a, int x) {{ return __builtin_ia32_vec_set_v4si(a, x, 1); }} \
         __m128i f10(__m128i a, __m128i b) {{ return __builtin_ia32_aesenc128(a, b); }} \
         {MAIN}"
    );
    crate::Compiler::with_target(src, crate::Target::LinuxX64)
        .compile()
        .expect("each builtin returns as the typedef its prototype names");
    let src = "#include <emmintrin.h>\n\
         __v4si f(__v4si a, __v4si b) { return __builtin_ia32_paddd128(a, b); }\n\
         int main(void) { return 0; }";
    crate::Compiler::with_target(src.to_string(), crate::Target::LinuxX64)
        .compile()
        .expect("a result returns as the header's own typedef with no cast");
    let msg =
        compile_x64_err("__v4si f(__v8hi a, __v8hi b) { return __builtin_ia32_paddw128(a, b); }");
    assert!(
        msg.contains(
            "incompatible types in return (declared=int __attribute__((vector_size(16))), \
             returned=short __attribute__((vector_size(16))))"
        ),
        "a different typedef is still diagnosed: {msg}"
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
        simd::eval(Sem::Add(4), &a, &b, 0, 0),
        v([11, 0, 0, 0, 22, 0, 0, 0, 33, 0, 0, 0, 44, 0, 0, 0])
    );
    // Doubleword addition does not carry between lanes.
    let hi = v([0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    let one = v([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    assert_eq!(simd::eval(Sem::Add(4), &hi, &one, 0, 0), [0u8; 16]);
    // Quadword addition does.
    let q = v([0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    assert_eq!(
        simd::eval(Sem::Add(8), &q, &one, 0, 0),
        v([0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    );
    assert_eq!(simd::eval(Sem::Xor, &a, &a, 0, 0), [0u8; 16]);
    assert_eq!(
        simd::eval(Sem::And, &a, &b, 0, 0),
        v([0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0])
    );
    assert_eq!(
        simd::eval(Sem::Or, &a, &b, 0, 0),
        v([11, 0, 0, 0, 22, 0, 0, 0, 31, 0, 0, 0, 44, 0, 0, 0])
    );
    // A quadword compare sets all bits of the equal lane.
    let eq = simd::eval(Sem::CmpEq(8), &a, &a, 0, 0);
    assert_eq!(eq, [0xffu8; 16]);
    // The complement-and takes the first operand complemented.
    assert_eq!(
        simd::eval(Sem::AndNot, &[0x0f; 16], &[0x33; 16], 0, 0),
        [0x30u8; 16]
    );
    // A signed compare orders the negative lane below the positive one.
    let neg = v([0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    let gt = simd::eval(Sem::CmpGt(4), &one, &neg, 0, 0);
    assert_eq!(&gt[..4], &[0xff, 0xff, 0xff, 0xff]);
    let gt = simd::eval(Sem::CmpGt(4), &neg, &one, 0, 0);
    assert_eq!(&gt[..4], &[0, 0, 0, 0]);
    // The byte compare is per byte, not per doubleword.
    let gt = simd::eval(Sem::CmpGt(1), &b, &a, 0, 0);
    assert_eq!(&gt[..5], &[0xff, 0, 0, 0, 0xff]);
}

#[test]
fn shifts_zero_a_lane_shifted_past_its_width() {
    let a = v([0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    assert_eq!(
        simd::eval(Sem::Shl(2), &a, &[0; 16], 0, 4),
        v([0xf0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    );
    assert_eq!(simd::eval(Sem::Shr(2), &a, &[0; 16], 0, 16), [0u8; 16]);
    // The byte shift counts bytes and fills from the low end.
    let b = v([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
    assert_eq!(
        simd::eval(Sem::ShlBytes, &b, &[0; 16], 0, 4),
        v([0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    );
}

#[test]
fn shuffles_select_the_lanes_the_immediate_names() {
    let a = v([0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0]);
    // 0x93 = lanes (2,1,0,3): the rotate ChaCha20 uses.
    assert_eq!(
        simd::eval(Sem::ShufD, &a, &[0; 16], 0x93, 0),
        v([3, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0])
    );
    // The word shuffles leave the other half alone.
    let w = v([0, 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 7, 0]);
    let lo = simd::eval(Sem::ShufLo, &w, &[0; 16], 0x1b, 0);
    assert_eq!(&lo[8..], &w[8..]);
    assert_eq!(&lo[..8], &[3, 0, 2, 0, 1, 0, 0, 0]);
    let hi = simd::eval(Sem::ShufHi, &w, &[0; 16], 0x1b, 0);
    assert_eq!(&hi[..8], &w[..8]);
    assert_eq!(&hi[8..], &[7, 0, 6, 0, 5, 0, 4, 0]);
    // The byte shuffle zeroes a byte whose index has bit 7 set.
    let data = v([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    let mask = v([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0x80]);
    let sh = simd::eval(Sem::ShufB, &data, &mask, 0, 0);
    assert_eq!(
        sh,
        v([15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0])
    );
    // Interleaving the low quads.
    let x = v([1, 1, 1, 1, 1, 1, 1, 1, 9, 9, 9, 9, 9, 9, 9, 9]);
    let y = v([2, 2, 2, 2, 2, 2, 2, 2, 8, 8, 8, 8, 8, 8, 8, 8]);
    assert_eq!(
        simd::eval(Sem::UnpackLo(8), &x, &y, 0, 0),
        v([1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2])
    );
    assert_eq!(
        simd::eval(Sem::UnpackHi(8), &x, &y, 0, 0),
        v([9, 9, 9, 9, 9, 9, 9, 9, 8, 8, 8, 8, 8, 8, 8, 8])
    );
}

/// The interleaves take alternate lanes from the named half of each
/// operand, the first operand's lane first.
#[test]
fn interleaves_alternate_the_lanes_of_one_half() {
    let a = v([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    let b = v([
        0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e,
        0x8f,
    ]);
    let lo = simd::eval(Sem::UnpackLo(1), &a, &b, 0, 0);
    assert_eq!(&lo[..6], &[0, 0x80, 1, 0x81, 2, 0x82]);
    let hi = simd::eval(Sem::UnpackHi(1), &a, &b, 0, 0);
    assert_eq!(&hi[..6], &[8, 0x88, 9, 0x89, 10, 0x8a]);
    let lo = simd::eval(Sem::UnpackLo(2), &a, &b, 0, 0);
    assert_eq!(&lo[..8], &[0, 1, 0x80, 0x81, 2, 3, 0x82, 0x83]);
    let hi = simd::eval(Sem::UnpackHi(4), &a, &b, 0, 0);
    assert_eq!(&hi[..8], &[8, 9, 10, 11, 0x88, 0x89, 0x8a, 0x8b]);
}

/// The packs saturate each source lane into one of half the width, the
/// first operand's lanes filling the low half of the result.
#[test]
fn packs_saturate_into_the_narrower_lane() {
    // 300 saturates to 0x7f signed and 0xff unsigned; -300 to 0x80 and 0.
    let a = v([
        0x2c, 0x01, 0x2c, 0x01, 0x2c, 0x01, 0x2c, 0x01, 0x2c, 0x01, 0x2c, 0x01, 0x2c, 0x01, 0x2c,
        0x01,
    ]);
    let b = v([
        0xd4, 0xfe, 0xd4, 0xfe, 0xd4, 0xfe, 0xd4, 0xfe, 0xd4, 0xfe, 0xd4, 0xfe, 0xd4, 0xfe, 0xd4,
        0xfe,
    ]);
    let s = simd::eval(Sem::PackSigned(2), &a, &b, 0, 0);
    assert_eq!(&s[..8], &[0x7f; 8]);
    assert_eq!(&s[8..], &[0x80; 8]);
    let u = simd::eval(Sem::PackUnsigned(2), &a, &b, 0, 0);
    assert_eq!(&u[..8], &[0xff; 8]);
    assert_eq!(&u[8..], &[0; 8]);
    // A doubleword source saturates into a word: 70000 -> 0x7fff.
    let big = v([
        0x70, 0x11, 0x01, 0x00, 0x70, 0x11, 0x01, 0x00, 0x70, 0x11, 0x01, 0x00, 0x70, 0x11, 0x01,
        0x00,
    ]);
    let d = simd::eval(Sem::PackSigned(4), &big, &big, 0, 0);
    assert_eq!(&d[..4], &[0xff, 0x7f, 0xff, 0x7f]);
    // A lane already in range passes through.
    let small = v([7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0]);
    let p = simd::eval(Sem::PackSigned(4), &small, &small, 0, 0);
    assert_eq!(p, v([7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0, 7, 0]));
}

/// The word products: `pmullw` keeps the low half, `pmulhw` the high
/// half of the signed product, and `pmaddwd` sums adjacent pairs.
#[test]
fn word_products_split_and_sum() {
    let a = v([
        0x34, 0x12, 0x00, 0x10, 0x00, 0xf0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    ]);
    let three = v([3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0]);
    let lo = simd::eval(Sem::MulLo(2), &a, &three, 0, 0);
    // 0x1234 * 3 = 0x369c; 0x1000 * 3 = 0x3000.
    assert_eq!(&lo[..4], &[0x9c, 0x36, 0x00, 0x30]);
    let hi = simd::eval(Sem::MulHi(2, true), &a, &three, 0, 0);
    // 0x1234 * 3 fits in a word, so the high half is zero; -4096 * 3 =
    // -12288, whose high half is the sign.
    assert_eq!(&hi[..2], &[0, 0]);
    assert_eq!(&hi[4..6], &[0xff, 0xff]);
    // Each doubleword is a[2i]*b[2i] + a[2i+1]*b[2i+1]: 0x1234*3 +
    // 0x1000*3 = 0x669c.
    let madd = simd::eval(Sem::MulAddWords, &a, &three, 0, 0);
    assert_eq!(&madd[..4], &[0x9c, 0x66, 0, 0]);
    // The signed extreme wraps within the doubleword, as the
    // instruction does: (-32768 * -32768) * 2 = 2^31.
    let m = v([0x00, 0x80, 0x00, 0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    let w = simd::eval(Sem::MulAddWords, &m, &m, 0, 0);
    assert_eq!(&w[..4], &[0x00, 0x00, 0x00, 0x80]);
    // `pmulhuw` reads the lanes unsigned: 0xf000 * 3 = 0x2d000.
    let hu = simd::eval(Sem::MulHi(2, false), &a, &three, 0, 0);
    assert_eq!(&hu[4..6], &[0x02, 0x00]);
    let hu = simd::eval(Sem::MulHi(2, false), &[0xff; 16], &[0xff; 16], 0, 0);
    assert_eq!(&hu[..2], &[0xfe, 0xff]);
}

/// PABS, PSIGN, the horizontal forms, PMULHRSW and PALIGNR as the SDM
/// defines them.
#[test]
fn ssse3_lanes_follow_the_instruction() {
    let a = v([
        0x80, 0x7f, 0xff, 0x00, 0x00, 0x80, 0x05, 0x00, 1, 2, 3, 4, 5, 6, 7, 8,
    ]);
    let abs = simd::eval(Sem::Abs(1), &a, &[0; 16], 0, 0);
    assert_eq!(&abs[..4], &[0x80, 0x7f, 0x01, 0x00]);
    let abs = simd::eval(Sem::Abs(2), &a, &[0; 16], 0, 0);
    assert_eq!(&abs[4..8], &[0x00, 0x80, 0x05, 0x00]);
    let s = v([0xff, 0x00, 0x01, 0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    let sign = simd::eval(Sem::Sign(1), &a, &s, 0, 0);
    // -(-128) wraps to -128; a zero selector zeroes; a positive one keeps.
    assert_eq!(&sign[..4], &[0x80, 0x00, 0xff, 0x00]);
    // Words of `a`: 0x7f80, 0x00ff, 0x8000, 0x0005.
    let h = simd::eval(Sem::HAdd(2, false), &a, &a, 0, 0);
    assert_eq!(&h[..4], &[0x7f, 0x80, 0x05, 0x80]);
    let hs = simd::eval(Sem::HAdd(2, true), &a, &a, 0, 0);
    assert_eq!(&hs[..4], &[0xff, 0x7f, 0x05, 0x80]);
    let d = simd::eval(Sem::HSub(2, true), &a, &a, 0, 0);
    // 0x7f80 - 0x00ff = 0x7e81; -32768 - 5 saturates to -32768.
    assert_eq!(&d[..4], &[0x81, 0x7e, 0x00, 0x80]);
    let z = simd::eval(Sem::HAdd(4, false), &[0; 16], &a, 0, 0);
    assert_eq!(&z[..8], &[0; 8]);
    // 0x00ff7f80 + 0x00058000 = 0x0104ff80.
    assert_eq!(&z[8..12], &[0x80, 0xff, 0x04, 0x01]);
    // -32768 * -32768 rounds to 0x8000; 0x4000 * 0x4000 to 0x2000.
    let m = v([0x00, 0x80, 0x00, 0x40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    let r = simd::eval(Sem::MulHrs, &m, &m, 0, 0);
    assert_eq!(&r[..4], &[0x00, 0x80, 0x00, 0x20]);
    let lo = v([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    let hi = [0xaa; 16];
    let al = simd::eval(Sem::AlignR, &hi, &lo, 14, 0);
    assert_eq!(&al[..4], &[14, 15, 0xaa, 0xaa]);
    assert_eq!(simd::eval(Sem::AlignR, &hi, &lo, 20, 0)[11], 0xaa);
    assert_eq!(simd::eval(Sem::AlignR, &hi, &lo, 20, 0)[12], 0);
    assert_eq!(simd::eval(Sem::AlignR, &hi, &lo, 32, 0), [0; 16]);
}

/// PMOVSX / PMOVZX, PMULDQ, the immediate blends and PCMPGTQ.
#[test]
fn sse41_lanes_follow_the_instruction() {
    let a = v([
        0x80, 0x7f, 0xff, 0x01, 0, 0, 0, 0x80, 9, 9, 9, 9, 0xfe, 0xff, 0xff, 0xff,
    ]);
    let sx = simd::eval(Sem::Extend(1, 2, true, false), &a, &[0; 16], 0, 0);
    assert_eq!(&sx[..8], &[0x80, 0xff, 0x7f, 0x00, 0xff, 0xff, 0x01, 0x00]);
    let zx = simd::eval(Sem::Extend(1, 2, false, false), &a, &[0; 16], 0, 0);
    assert_eq!(&zx[..8], &[0x80, 0x00, 0x7f, 0x00, 0xff, 0x00, 0x01, 0x00]);
    // Doubleword 1 is 0x80000000: sign-extended to the second quadword.
    let dq = simd::eval(Sem::Extend(4, 8, true, false), &a, &[0; 16], 0, 0);
    assert_eq!(&dq[8..], &[0, 0, 0, 0x80, 0xff, 0xff, 0xff, 0xff]);
    let bq = simd::eval(Sem::Extend(1, 8, false, false), &a, &[0; 16], 0, 0);
    assert_eq!(
        bq,
        v([0x80, 0, 0, 0, 0, 0, 0, 0, 0x7f, 0, 0, 0, 0, 0, 0, 0])
    );
    // Doublewords 0 and 2: 0x01ff7f80 * 3, 0x09090909 * -2 (unsigned 0xfffffffe).
    let b = v([3, 0, 0, 0, 0, 0, 0, 0, 0xfe, 0xff, 0xff, 0xff, 0, 0, 0, 0]);
    let m = simd::eval(Sem::MulEven(true), &a, &b, 0, 0);
    assert_eq!(&m[..8], &0x05fe_7e80u64.to_le_bytes());
    assert_eq!(&m[8..], &0xffff_ffff_eded_edeeu64.to_le_bytes());
    let u = simd::eval(Sem::MulEven(false), &a, &b, 0, 0);
    assert_eq!(&u[8..], &0x0909_0908_eded_edeeu64.to_le_bytes());
    let ones = [0xff; 16];
    let bw = simd::eval(Sem::Blend(2), &[0; 16], &ones, 0xa5, 0);
    assert_eq!(
        bw,
        v([
            0xff, 0xff, 0, 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0xff, 0, 0, 0xff, 0xff
        ])
    );
    let bd = simd::eval(Sem::Blend(8), &[0; 16], &ones, 2, 0);
    assert_eq!(&bd[..8], &[0; 8]);
    assert_eq!(&bd[8..], &[0xff; 8]);
    // 1 > 0, but -1 is not, which an unsigned compare would give.
    let c = v([
        1, 0, 0, 0, 0, 0, 0, 0, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
    ]);
    let gt = simd::eval(Sem::CmpGt(8), &c, &[0; 16], 0, 0);
    assert_eq!(&gt[..8], &[0xff; 8]);
    assert_eq!(&gt[8..], &[0; 8]);
}

/// PAVG rounds the unsigned mean up; PMIN / PMAX compare as the row says.
#[test]
fn averages_and_extremes_read_the_lanes_as_the_instruction_does() {
    let a = v([0xff, 0, 1, 2, 0xff, 0xff, 0, 0x80, 0, 0, 0, 0, 0, 0, 0, 0]);
    let b = v([0xff, 1, 1, 5, 0x01, 0x00, 0, 0x7f, 0, 0, 0, 0, 0, 0, 0, 0]);
    let avg = simd::eval(Sem::Avg(1), &a, &b, 0, 0);
    assert_eq!(&avg[..4], &[0xff, 1, 1, 4]);
    // 0xffff and 0x0001 average to 0x8000.
    let avg = simd::eval(Sem::Avg(2), &a, &b, 0, 0);
    assert_eq!(&avg[4..6], &[0x00, 0x80]);
    // Byte 7: 0x80 is 128 unsigned and -128 signed.
    assert_eq!(simd::eval(Sem::Min(1, false), &a, &b, 0, 0)[7], 0x7f);
    assert_eq!(simd::eval(Sem::Max(1, false), &a, &b, 0, 0)[7], 0x80);
    // Word 2 (bytes 4-5): 0xffff is -1 signed, below 0x0001.
    let min = simd::eval(Sem::Min(2, true), &a, &b, 0, 0);
    assert_eq!(&min[4..6], &[0xff, 0xff]);
    let max = simd::eval(Sem::Max(2, true), &a, &b, 0, 0);
    assert_eq!(&max[4..6], &[0x01, 0x00]);
}

/// The arithmetic shift propagates the sign, and a count at or past the
/// lane width leaves every bit equal to it.
#[test]
fn the_arithmetic_shift_propagates_the_sign() {
    let neg = v([
        0xf0, 0xff, 0xf0, 0xff, 0xf0, 0xff, 0xf0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0,
    ]);
    let r = simd::eval(Sem::Sar(2), &neg, &[0; 16], 0, 2);
    assert_eq!(&r[..4], &[0xfc, 0xff, 0xfc, 0xff]);
    assert_eq!(&r[8..10], &[0, 0]);
    let r = simd::eval(Sem::Sar(2), &neg, &[0; 16], 0, 99);
    assert_eq!(&r[..4], &[0xff, 0xff, 0xff, 0xff]);
    // The same bytes as doublewords: 0xfff0fff0 >> 4 = 0xffff0fff.
    let r = simd::eval(Sem::Sar(4), &neg, &[0; 16], 0, 4);
    assert_eq!(&r[..4], &[0xff, 0x0f, 0xff, 0xff]);
    // The unsigned shift of the same lanes does not.
    let r = simd::eval(Sem::Shr(2), &neg, &[0; 16], 0, 2);
    assert_eq!(&r[..2], &[0xfc, 0x3f]);
}

/// The byte-granular shifts move the whole register, zero-filling.
#[test]
fn the_whole_register_shifts_fill_with_zero() {
    let a = v([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    assert_eq!(
        simd::eval(Sem::ShrBytes, &a, &[0; 16], 0, 3),
        v([3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 0, 0])
    );
    assert_eq!(simd::eval(Sem::ShrBytes, &a, &[0; 16], 0, 16), [0u8; 16]);
    assert_eq!(simd::eval(Sem::ShrBytes, &a, &[0; 16], 0, 255), [0u8; 16]);
}

/// The byte sign bits, lane `i` at bit `i`.
#[test]
fn the_sign_mask_reads_one_bit_per_byte() {
    assert_eq!(simd::eval_movemask(&[0x80; 16]), 0xffff);
    assert_eq!(simd::eval_movemask(&[0x7f; 16]), 0);
    let mut a = [0u8; 16];
    a[0] = 0x80;
    a[15] = 0xff;
    assert_eq!(simd::eval_movemask(&a), 0x8001);
}

#[test]
fn element_access_reads_and_writes_the_named_lane() {
    let a = v([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    assert_eq!(simd::eval_extract(&a, 2, 1), 0x0302);
    assert_eq!(simd::eval_extract(&a, 4, 3), 0x0f0e_0d0c);
    let set = simd::eval_insert(&a, 4, 1, 0xdead_beef);
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
    assert_eq!(simd::eval(Sem::ClMul, &a, &b, 0x00, 0)[0], 4);
    // 0x11 takes the high quads, which are zero here.
    assert_eq!(simd::eval(Sem::ClMul, &a, &b, 0x11, 0), [0u8; 16]);
    // 0b11 * 0b11 = 0b101 with carries suppressed.
    a[0] = 3;
    b[0] = 3;
    assert_eq!(simd::eval(Sem::ClMul, &a, &b, 0x00, 0)[0], 5);
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
            let t2 = simd::eval(Sem::AesKeygen, &t1, &Z, rcon, 0);
            let t2 = simd::eval(Sem::ShufD, &t2, &Z, 0xff, 0);
            let mut t3 = simd::eval(Sem::ShlBytes, &t1, &Z, 0, 4);
            t1 = simd::eval(Sem::Xor, &t1, &t3, 0, 0);
            t3 = simd::eval(Sem::ShlBytes, &t3, &Z, 0, 4);
            t1 = simd::eval(Sem::Xor, &t1, &t3, 0, 0);
            t3 = simd::eval(Sem::ShlBytes, &t3, &Z, 0, 4);
            t1 = simd::eval(Sem::Xor, &t1, &t3, 0, 0);
            t1 = simd::eval(Sem::Xor, &t1, &t2, 0, 0);
            ks[i + 1] = t1;
        }
        ks
    }
    const Z: [u8; 16] = [0u8; 16];
    let ks = expand(hex("000102030405060708090a0b0c0d0e0f"));
    let mut m = simd::eval(
        Sem::Xor,
        &hex("00112233445566778899aabbccddeeff"),
        &ks[0],
        0,
        0,
    );
    for k in ks.iter().take(10).skip(1) {
        m = simd::eval(Sem::AesEnc, &m, k, 0, 0);
    }
    m = simd::eval(Sem::AesEncLast, &m, &ks[10], 0, 0);
    assert_eq!(m, hex("69c4e0d86a7b0430d8cdb78070b4c55a"));

    let mut d = simd::eval(Sem::Xor, &m, &ks[10], 0, 0);
    for k in ks.iter().take(10).skip(1).rev() {
        let dk = simd::eval(Sem::AesImc, k, &Z, 0, 0);
        d = simd::eval(Sem::AesDec, &d, &dk, 0, 0);
    }
    d = simd::eval(Sem::AesDecLast, &d, &ks[0], 0, 0);
    assert_eq!(d, hex("00112233445566778899aabbccddeeff"));
}

/// The key-schedule helper on its own: FIPS-197 A.1 expands the key
/// 2b7e151628aed2a6abf7158809cf4f3c, where the first round constant
/// takes w[3] = 09cf4f3c to SubWord(RotWord(w[3])) xor Rcon[1] =
/// 8b84eb01, the value the instruction leaves in the high doubleword.
#[test]
fn the_key_schedule_helper_matches_the_expansion() {
    let k = hex("2b7e151628aed2a6abf7158809cf4f3c");
    let out = simd::eval(Sem::AesKeygen, &k, &[0u8; 16], 0x01, 0);
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
        assert_eq!(
            row.ret.lane_ty().is_some(),
            row.form.returns_vector(),
            "{}: result type and form disagree",
            row.name
        );
        assert_eq!(
            row.ret == x86_simd::Ret::Void,
            matches!(row.form, x86_simd::Form::Store | x86_simd::Form::MaskStore),
            "{}: only the stores return void",
            row.name
        );
    }
}

/// The floating-point rows emit their instruction: `<op> %xmm14, %xmm15`
/// under its prefix, a compare with its predicate byte, and a conversion to
/// an integer into `%r11d` or `%r11`.
#[cfg(feature = "full")]
#[test]
fn floating_rows_emit_their_instruction() {
    const PS: &str = "typedef float __v4sf __attribute__((vector_size(16))); ";
    for (src, expected, what) in [
        (
            "__v4sf f(__v4sf a, __v4sf b) { return __builtin_ia32_addps(a, b); }",
            &[0x45, 0x0f, 0x58, 0xfe][..],
            "addps",
        ),
        (
            "__v4sf f(__v4sf a, __v4sf b) { return __builtin_ia32_minss(a, b); }",
            &[0xf3, 0x45, 0x0f, 0x5d, 0xfe],
            "minss",
        ),
        (
            "__v2df f(__v2df a, __v2df b) { return __builtin_ia32_divpd(a, b); }",
            &[0x66, 0x45, 0x0f, 0x5e, 0xfe],
            "divpd",
        ),
        (
            "__v2df f(__v2df a) { return __builtin_ia32_sqrtpd(a); }",
            &[0x66, 0x45, 0x0f, 0x51, 0xfe],
            "sqrtpd",
        ),
        (
            "__v4sf f(__v4sf a, __v4sf b) { return __builtin_ia32_cmpps(a, b, 6); }",
            &[0x45, 0x0f, 0xc2, 0xfe, 0x06],
            "cmpps",
        ),
        (
            "__v2df f(__v2df a, __v2df b) { return __builtin_ia32_cmpsd(a, b, 3); }",
            &[0xf2, 0x45, 0x0f, 0xc2, 0xfe, 0x03],
            "cmpsd",
        ),
        (
            "__v4si f(__v4sf a) { return __builtin_ia32_cvttps2dq(a); }",
            &[0xf3, 0x45, 0x0f, 0x5b, 0xfe],
            "cvttps2dq",
        ),
        (
            "int f(__v2df a) { return __builtin_ia32_cvtsd2si(a); }",
            &[0xf2, 0x45, 0x0f, 0x2d, 0xde],
            "cvtsd2si",
        ),
        (
            "long long f(__v4sf a) { return __builtin_ia32_cvttss2si64(a); }",
            &[0xf3, 0x4d, 0x0f, 0x2c, 0xde],
            "cvttss2si64",
        ),
        (
            "__v4si f(__v4sf a) { return __builtin_ia32_cvtps2udq128(a); }",
            &[0x62, 0x51, 0x7c, 0x08, 0x79, 0xfe],
            "vcvtps2udq",
        ),
    ] {
        assert_emits(&format!("{PS}{src}"), expected, what);
    }
}

/// A floating-point row computes in the interpreter's floating-point
/// environment, which rounds in its direction and raises its exceptions, for
/// ordinary lanes or for NaN ones; the others compute over integer lanes. A
/// new semantics takes its place here.
#[test]
fn floating_rows_compute_in_the_environment() {
    let floating = |sem: Sem| match sem {
        Sem::Float(..)
        | Sem::FloatCmp(..)
        | Sem::FloatRel(..)
        | Sem::FloatFma(..)
        | Sem::Convert(_)
        | Sem::ToInt(..)
        | Sem::Estimate(..)
        | Sem::Step(..)
        | Sem::FloatPair(..)
        | Sem::FloatAcross(..)
        | Sem::RoundInt(..)
        | Sem::RoundIntN(..) => true,
        Sem::Add(_)
        | Sem::Sub(_)
        | Sem::MulLo(_)
        | Sem::PolyMul(_)
        | Sem::AesRound(_)
        | Sem::AesMix
        | Sem::Eor3
        | Sem::Bcax
        | Sem::Rax1
        | Sem::Xar
        | Sem::Sha256Hash(_)
        | Sem::Sha256Su0
        | Sem::Sha256Su1
        | Sem::Sha1Hash(_)
        | Sem::Sha1Su0
        | Sem::Sha1Su1
        | Sem::Sha512Hash(_)
        | Sem::Sha512Su0
        | Sem::Sha512Su1
        | Sem::MulHi(..)
        | Sem::Avg(_)
        | Sem::Min(..)
        | Sem::Max(..)
        | Sem::MulAddWords
        | Sem::MulAddBytes
        | Sem::MulEven(_)
        | Sem::Extend(..)
        | Sem::Blend(_)
        | Sem::AddSat(..)
        | Sem::SubSat(..)
        | Sem::SadBytes
        | Sem::And
        | Sem::AndNot
        | Sem::Or
        | Sem::Xor
        | Sem::CmpEq(_)
        | Sem::CmpGt(_)
        | Sem::Shl(_)
        | Sem::Shr(_)
        | Sem::Sar(_)
        | Sem::ShlBytes
        | Sem::ShrBytes
        | Sem::PackSigned(_)
        | Sem::PackUnsigned(_)
        | Sem::UnpackLo(_)
        | Sem::UnpackHi(_)
        | Sem::ShufD
        | Sem::ShufHi
        | Sem::ShufLo
        | Sem::ShufB
        | Sem::Abs(_)
        | Sem::Sign(_)
        | Sem::HAdd(..)
        | Sem::HSub(..)
        | Sem::MulHrs
        | Sem::AlignR
        | Sem::ShufPd
        | Sem::ClMul
        | Sem::AesEnc
        | Sem::AesEncLast
        | Sem::AesDec
        | Sem::AesDecLast
        | Sem::AesImc
        | Sem::AesKeygen
        | Sem::Move
        | Sem::Rand
        | Sem::Perm4x64
        | Sem::PermVar32
        | Sem::Perm2x128
        | Sem::ShufLanes128
        | Sem::DotBytes(_)
        | Sem::DotWords(_)
        | Sem::TernLog
        | Sem::CmpPred(..)
        | Sem::HalvingAdd(..)
        | Sem::HalvingSub(..)
        | Sem::AbsDiff(..)
        | Sem::BitClear
        | Sem::OrNot
        | Sem::CmpGe(_)
        | Sem::CmpHi(_)
        | Sem::CmpHs(_)
        | Sem::CmpTst(_)
        | Sem::PairMax(..)
        | Sem::PairMin(..)
        | Sem::Neg(_)
        | Sem::NegSat(_)
        | Sem::AbsSat(_)
        | Sem::Clz(_)
        | Sem::Cls(_)
        | Sem::PopCnt
        | Sem::Not
        | Sem::MulAcc(_)
        | Sem::MulSub(_)
        | Sem::AbsDiffAcc(..)
        | Sem::BitSelect
        | Sem::FAbs(_)
        | Sem::FNeg(_)
        | Sem::Long(..)
        | Sem::Wide(..)
        | Sem::LongAcc(..)
        | Sem::Narrow(..)
        | Sem::ShlReg(..)
        | Sem::Across(..)
        | Sem::PairAddLong(..)
        | Sem::Rev(..)
        | Sem::Perm(..)
        | Sem::Ext(..)
        | Sem::DupLane(..)
        | Sem::Tbl(..)
        | Sem::Tbx(..)
        | Sem::ShrAcc(..)
        | Sem::ShiftInsert(..)
        | Sem::ShrRound(..)
        | Sem::ShlSat(..)
        | Sem::ShrNarrow(..)
        | Sem::FractionEstimate(..)
        | Sem::CmpLe(_)
        | Sem::CmpLt(_)
        | Sem::ShlSatU(_)
        | Sem::PairAddLongAcc(..) => false,
    };
    /// Counts the operations a row asks of the environment.
    struct Counting(u32);
    impl simd::FloatEnv for Counting {
        fn arith(&mut self, _: simd::FOp, a: u64, _: u64, _: bool) -> u64 {
            self.0 += 1;
            a
        }
        fn compare(&mut self, _: u64, _: u64, _: bool) -> Option<core::cmp::Ordering> {
            self.0 += 1;
            None
        }
        fn to_int(&mut self, _: u64, _: bool, _: u32, _: bool) -> i64 {
            self.0 += 1;
            0
        }
        fn integer_to_float(&mut self, _: i64, _: bool) -> u64 {
            self.0 += 1;
            0
        }
        fn to_single(&mut self, a: u64) -> u64 {
            self.0 += 1;
            a
        }
        fn widen(&mut self, a: u64) -> u64 {
            self.0 += 1;
            a
        }
        fn fma(&mut self, a: u64, _: u64, _: u64, _: bool) -> u64 {
            self.0 += 1;
            a
        }
        fn round_to_integral(&mut self, a: u64, _: simd::RoundTo, _: bool) -> u64 {
            self.0 += 1;
            a
        }
    }
    for op in x86_simd::OPS.iter().chain(crate::c5::aarch64_simd::rows()) {
        let mut env = Counting(0);
        for a in [[0x3f; 16], [0xff; 16]] {
            let packed = simd::eval_float(&mut env, op.sem, &a, &a, 0).is_some()
                || simd::eval_float_acc(&mut env, op.sem, (&a, &a, &a), 16).is_some();
            let scalar = simd::eval_to_int(&mut env, op.sem, &a, 32).is_some();
            assert_eq!(packed || scalar, floating(op.sem), "{}", op.name);
        }
        assert_eq!(env.0 > 0, floating(op.sem), "{}", op.name);
    }
}

/// AVX-512's unsigned doubleword conversions compute in the interpreter as
/// the SDM defines them; no validation box executes AVX-512 to record them.
/// `vcvtps2udq` rounds in the current direction, `vcvttps2udq` truncates,
/// and a NaN or a result outside [0, 2^32) is invalid with all ones;
/// `vcvtudq2ps` rounds the unsigned value to nearest even.
#[test]
fn the_interpreter_computes_the_unsigned_doubleword_conversions() {
    let src = "#include <immintrin.h>\n#include <fenv.h>\n#include <math.h>\n\
        static int same(__m128i v, unsigned a, unsigned b, unsigned c, unsigned d) {\n\
            unsigned r[4];\n\
            _mm_storeu_si128((__m128i *)r, v);\n\
            return r[0] == a && r[1] == b && r[2] == c && r[3] == d;\n\
        }\n\
        int main(void) {\n\
            feclearexcept(FE_ALL_EXCEPT);\n\
            __m128i r = _mm_cvtps_epu32(_mm_setr_ps(3.5f, 4294967040.0f, -0.4f, 2.5f));\n\
            if (!same(r, 4, 4294967040u, 0, 2)) return 1;\n\
            if (fetestexcept(FE_INVALID) || !fetestexcept(FE_INEXACT)) return 2;\n\
            fesetround(FE_UPWARD);\n\
            r = _mm_cvtps_epu32(_mm_setr_ps(3.25f, -0.75f, 0.5f, -1.0f));\n\
            fesetround(FE_TONEAREST);\n\
            if (!same(r, 4, 0, 1, 0xffffffffu)) return 3;\n\
            feclearexcept(FE_ALL_EXCEPT);\n\
            r = _mm_cvttps_epu32(_mm_setr_ps(-1.0f, 4294967296.0f, 1.9f, NAN));\n\
            if (!same(r, 0xffffffffu, 0xffffffffu, 1, 0xffffffffu)) return 4;\n\
            if (!fetestexcept(FE_INVALID)) return 5;\n\
            float b[4];\n\
            _mm_storeu_ps(b, _mm_cvtepu32_ps(_mm_setr_epi32(-1, 1, (int)0x80000001u, 16777217)));\n\
            if (b[0] != 4294967296.0f || b[1] != 1.0f || b[2] != 2147483648.0f || b[3] != 16777216.0f)\n\
                return 6;\n\
            unsigned w[8];\n\
            _mm256_storeu_si256((__m256i *)w, _mm256_cvttps_epu32(_mm256_set1_ps(7.75f)));\n\
            return w[0] == 7 && w[7] == 7 ? 0 : 7;\n\
        }\n";
    for target in [crate::Target::LinuxX64, crate::Target::WindowsX64] {
        let program = crate::Compiler::with_options(src.to_string(), target, Default::default())
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
        let rc = super::Vm::new(program).run().expect("run");
        assert_eq!(rc, 0, "{target:?}: check {rc} failed");
    }
}

/// The interpreter runs the fences, which order nothing in one thread, and
/// reads and loads MXCSR through its floating-point environment: the flags,
/// the masks and the rounding control, which governs the scalar operations.
/// It refuses what it does not model: an unmasked exception, and on
/// linux-x64, whose `fegetround` reads the x87 control word, an MXCSR
/// rounding direction apart from that word's.
#[test]
fn the_interpreter_runs_the_fences_and_mxcsr_access() {
    const SRC: &str = "#include <xmmintrin.h>\n#include <emmintrin.h>\n#include <fenv.h>\n\
        int main(void) {\n\
            _mm_mfence(); _mm_lfence(); _mm_sfence();\n\
            if (_mm_getcsr() != 0x1f80) return 1;\n\
            volatile float a = 1.0f, b = 3.0f;\n\
            volatile float z = a / b; (void)z;\n\
            if (_MM_GET_EXCEPTION_STATE() != _MM_EXCEPT_INEXACT) return 2;\n\
            _MM_SET_EXCEPTION_STATE(0);\n\
            if (fetestexcept(FE_ALL_EXCEPT)) return 3;\n\
            fesetround(FE_UPWARD);\n\
            if (_MM_GET_ROUNDING_MODE() != _MM_ROUND_UP) return 4;\n\
            fesetround(FE_TONEAREST);\n\
            float n = a / b;\n\
            _MM_SET_ROUNDING_MODE(_MM_ROUND_DOWN);\n\
            float d = a / b;\n\
            return d < n && fegetround() == FE_DOWNWARD ? 0 : 5;\n\
        }\n";
    let run = |target| {
        let program = crate::Compiler::with_options(SRC.to_string(), target, Default::default())
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
        super::Vm::new(program).run()
    };
    assert_eq!(run(crate::Target::WindowsX64).expect("run"), 0);
    let err = run(crate::Target::LinuxX64).expect_err("divergent rounding refused");
    assert!(
        err.to_string()
            .contains("apart from the x87 control word's"),
        "{err}"
    );
    let unmasked = "#include <xmmintrin.h>\nint main(void) { _mm_setcsr(0x1f00); return 0; }\n";
    let program = (crate::Compiler::with_options(
        unmasked.to_string(),
        crate::Target::WindowsX64,
        Default::default(),
    )
    .compile())
    .expect("compiles");
    let err = super::Vm::new(program)
        .run()
        .expect_err("unmasked exception refused");
    assert!(err.to_string().contains("unmasks an exception"), "{err}");
}

/// FXSAVE, FNSTCW and FLDCW under the interpreter: the control word the
/// target's process starts with (double precision on Windows, extended
/// elsewhere) with the rounding direction, MXCSR, and an FXRSTOR or FLDCW of
/// what was saved; a control word that changes the precision is refused.
#[test]
fn the_interpreter_saves_the_x87_and_sse_control_state() {
    const SRC: &str = "#include <immintrin.h>\n\
        static unsigned char area[512] __attribute__((aligned(16)));\n\
        int main(void) {\n\
            unsigned short cw;\n\
            __asm__ volatile(\"fnstcw %0\" : \"=m\"(cw));\n\
            _fxsave(area);\n\
            if (cw != (area[0] | area[1] << 8) || area[24] != 0x80 || area[25] != 0x1f) return 1;\n\
            __asm__ volatile(\"fldcw %0\" : : \"m\"(cw));\n\
            _fxrstor(area);\n\
            return cw;\n\
        }\n";
    for (target, cw) in [
        (crate::Target::LinuxX64, 0x037f),
        (crate::Target::WindowsX64, 0x027f),
    ] {
        let program = crate::Compiler::with_options(SRC.to_string(), target, Default::default())
            .compile()
            .unwrap_or_else(|e| panic!("{target:?}: {e}"));
        assert_eq!(
            super::Vm::new(program).run().expect("run"),
            cw,
            "{target:?}"
        );
    }
    let src = "int main(void) { unsigned short cw = 0x007f; __asm__ volatile(\"fldcw %0\" : : \"m\"(cw)); return 0; }\n";
    let program = (crate::Compiler::with_options(
        src.to_string(),
        crate::Target::LinuxX64,
        Default::default(),
    )
    .compile())
    .expect("compiles");
    let err = super::Vm::new(program)
        .run()
        .expect_err("a precision change is refused");
    assert!(err.to_string().contains("changes the precision"), "{err}");
}

/// The floating-point rows, and the AVX and FMA forms built on them, compute
/// in the interpreter as the instructions do: the fixtures' hashes, which
/// the instructions gave in each rounding direction, hold under the
/// interpreter for both x86-64 targets.
#[test]
fn the_interpreter_computes_the_floating_rows_as_the_instructions_do() {
    for fixture in [
        "sse_floating_lanes_follow_the_sdm.c",
        "avx_floating_and_fma_follow_the_sdm.c",
    ] {
        let src = super::load_fixture(fixture);
        for target in [crate::Target::LinuxX64, crate::Target::WindowsX64] {
            let program = crate::Compiler::with_options(src.clone(), target, Default::default())
                .compile()
                .expect("compile");
            let rc = super::Vm::new(program).run().expect("run");
            assert_eq!(rc, 0, "{fixture} {target:?}: row {rc} differs");
        }
    }
}

/// The AVX-512 rows compute what the SDM defines: VNNI's dot product into
/// an accumulator, the ternary logic, vpsadbw, the cross-lane permutes,
/// vpmovb2m and vpmaddubsw at 512 bits, each against the same operation
/// written per element, in the interpreter at -O0 and -O, and each emits
/// its EVEX instruction.
#[test]
fn avx512_rows_compute_and_emit_their_instructions() {
    use crate::{CompileOptions, Compiler, Target, Vm};
    const SRC: &str = "typedef long long v8di __attribute__((vector_size(64)));\n\
typedef int v16si __attribute__((vector_size(64)));\n\
typedef char v64qi __attribute__((vector_size(64)));\n\
typedef short v32hi __attribute__((vector_size(64)));\n\
static unsigned char A[64], B[64], C[64];\n\
int main(void) {\n\
    for (int i = 0; i < 64; i++) A[i] = (unsigned char)(i * 37 + 11), B[i] = (unsigned char)(200 - i * 13), C[i] = (unsigned char)(i * i);\n\
    v64qi a, b, c;\n\
    __builtin_memcpy(&a, A, 64); __builtin_memcpy(&b, B, 64); __builtin_memcpy(&c, C, 64);\n\
    v16si d = __builtin_ia32_vpdpbusd512((v16si)c, (v16si)a, (v16si)b);\n\
    for (int i = 0; i < 16; i++) {\n\
        int e = ((int *)C)[i];\n\
        for (int j = 0; j < 4; j++) e += A[4 * i + j] * (signed char)B[4 * i + j];\n\
        if (d[i] != e) return 1;\n\
    }\n\
    v8di t = __builtin_ia32_pternlogq512((v8di)a, (v8di)b, (v8di)c, 0x96);\n\
    for (int i = 0; i < 64; i++) if (((unsigned char *)&t)[i] != (unsigned char)(A[i] ^ B[i] ^ C[i])) return 2;\n\
    v8di s = __builtin_ia32_psadbw512(a, b);\n\
    for (int q = 0; q < 8; q++) { long long e = 0; for (int j = 0; j < 8; j++) { int x = A[8*q+j] - B[8*q+j]; e += x < 0 ? -x : x; } if (s[q] != e) return 3; }\n\
    v16si idx; for (int i = 0; i < 16; i++) idx[i] = 15 - i;\n\
    v16si p = __builtin_ia32_permvarsi512((v16si)a, idx);\n\
    for (int i = 0; i < 16; i++) if (p[i] != ((int *)A)[15 - i]) return 4;\n\
    v8di sh = __builtin_ia32_shuf_i64x2((v8di)a, (v8di)b, 0x4e);\n\
    long long *la = (long long *)A, *lb = (long long *)B;\n\
    long long want[8] = {la[4], la[5], la[6], la[7], lb[0], lb[1], lb[2], lb[3]};\n\
    for (int i = 0; i < 8; i++) if (sh[i] != want[i]) return 5;\n\
    v8di pq = __builtin_ia32_permdi512((v8di)a, 0x1b);\n\
    for (int h = 0; h < 2; h++) for (int i = 0; i < 4; i++) if (pq[4*h+i] != la[4*h + 3 - i]) return 6;\n\
    long long mm = __builtin_ia32_pmovmskb512(a);\n\
    for (int i = 0; i < 64; i++) if (((mm >> i) & 1) != (A[i] >> 7)) return 7;\n\
    v32hi mw = __builtin_ia32_pmaddubsw512(a, b);\n\
    for (int i = 0; i < 32; i++) { int e = A[2*i] * (signed char)B[2*i] + A[2*i+1] * (signed char)B[2*i+1]; if (e > 32767) e = 32767; if (e < -32768) e = -32768; if (mw[i] != e) return 8; }\n\
    return 0;\n\
}\n\
";
    for optimize in [false, true] {
        let opts = CompileOptions::default().with_optimize(optimize);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        assert_eq!(
            Vm::new(program).run().expect("run"),
            0,
            "optimize={optimize}"
        );
    }
    #[cfg(feature = "full")]
    {
        let opts = CompileOptions::default().with_optimize(true);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        let bytes = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            Target::LinuxX64,
            crate::NativeOptions::new().with_optimize(),
        )
        .expect("emit_native for linux-x64");
        // EVEX: 62, then P0 with its opcode map in bits 2:0 and bit 3 clear
        // (its high bits are the inverted register extensions, which the
        // allocation moves), then P1 with bit 2 set.
        for (map, what) in [
            (2, "an EVEX 0F38 instruction"),
            (3, "an EVEX 0F3A instruction"),
        ] {
            assert!(
                bytes
                    .windows(3)
                    .any(|w| w[0] == 0x62 && w[1] & 0x0F == map && w[2] & 0x04 != 0),
                "no {what}"
            );
        }
    }
}

/// The AVX-512 opmask rows: compares into a mask by predicate, signed and
/// unsigned, the blend it selects, and the masked transfers at each vector
/// length, a load that ends with its buffer reading none of the lanes past
/// it. Checked in the interpreter at -O0 and -O against the same
/// operations written per element; each lowers to its EVEX instruction
/// under k1.
#[test]
fn avx512_opmask_rows_select_their_lanes() {
    use crate::{CompileOptions, Compiler, Target, Vm};
    const SRC: &str = "typedef long long v8di __attribute__((vector_size(64)));\n\
typedef char v64qi __attribute__((vector_size(64)));\n\
typedef char v32qi __attribute__((vector_size(32)));\n\
typedef char v16qi __attribute__((vector_size(16)));\n\
static unsigned char A[64], B[64];\n\
static unsigned char tail[70];\n\
int main(void) {\n\
    for (int i = 0; i < 64; i++) A[i] = (unsigned char)(i * 37 + 11), B[i] = (unsigned char)(i * 53 + 7);\n\
    for (int i = 0; i < 70; i++) tail[i] = (unsigned char)(i + 1);\n\
    v64qi a, b; __builtin_memcpy(&a, A, 64); __builtin_memcpy(&b, B, 64);\n\
    long long lt = __builtin_ia32_ucmpb512_mask(a, b, 1);\n\
    long long sle = __builtin_ia32_cmpb512_mask(a, b, 2);\n\
    for (int i = 0; i < 64; i++) {\n\
        if (((lt >> i) & 1) != (A[i] < B[i])) return 1;\n\
        if (((sle >> i) & 1) != ((signed char)A[i] <= (signed char)B[i])) return 2;\n\
    }\n\
    v64qi bl = __builtin_ia32_blendmb_512(a, lt, b);\n\
    for (int i = 0; i < 64; i++) if ((unsigned char)bl[i] != (((lt >> i) & 1) ? B[i] : A[i])) return 3;\n\
    // The 6 bytes left at the end of `tail`, a mask for 6 lanes: nothing past it is read.\n\
    v64qi t = __builtin_ia32_loaddquqi512_mask(0x3F, (const char *)(tail + 64));\n\
    for (int i = 0; i < 64; i++) if ((unsigned char)t[i] != (i < 6 ? tail[64 + i] : 0)) return 4;\n\
    unsigned char out[64] = {0};\n\
    __builtin_ia32_storedquqi512_mask((char *)out, 0x8000000000000001LL, a);\n\
    for (int i = 0; i < 64; i++) if (out[i] != ((i == 0 || i == 63) ? A[i] : 0)) return 5;\n\
    v32qi h = __builtin_ia32_loaddquqi256_mask(0xF0F0F0F0u, (const char *)A);\n\
    for (int i = 0; i < 32; i++) if ((unsigned char)h[i] != (((0xF0F0F0F0u >> i) & 1) ? A[i] : 0)) return 6;\n\
    v16qi q = __builtin_ia32_loaddquqi128_mask(0x00FF, (const char *)B);\n\
    for (int i = 0; i < 16; i++) if ((unsigned char)q[i] != (i < 8 ? B[i] : 0)) return 7;\n\
    return 0;\n\
}\n\
";
    for optimize in [false, true] {
        let opts = CompileOptions::default().with_optimize(optimize);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        assert_eq!(
            Vm::new(program).run().expect("run"),
            0,
            "optimize={optimize}"
        );
    }
    #[cfg(feature = "full")]
    {
        let opts = CompileOptions::default().with_optimize(true);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        let bytes = crate::c5::object::emit_native_single_tu_for_test(
            &program,
            Target::LinuxX64,
            crate::NativeOptions::new().with_optimize(),
        )
        .expect("emit_native for linux-x64");
        // `kmovq %rax, %k1` (C4 E1 FB 92 C8) moves a mask in.
        assert!(
            bytes.windows(4).any(|w| w == [0xC4, 0xE1, 0xFB, 0x92]),
            "no kmovq into k1"
        );
    }
}

/// A 64-byte GNU vector operation is one zmm instruction under AVX-512F,
/// a byte or word one under AVX512BW too: `vpaddd` with an EVEX prefix.
#[cfg(feature = "full")]
#[test]
fn a_64_byte_vector_add_is_one_zmm_instruction_under_avx512f() {
    use crate::{CompileOptions, Compiler, NativeOptions, Target, X86Features};
    const SRC: &str = "typedef int v16si __attribute__((vector_size(64)));\n\
void add(v16si *r, const v16si *a, const v16si *b) { *r = *a + *b; }\n";
    let text = |ext: Option<&str>| {
        let mut f = X86Features::NONE;
        if let Some(e) = ext {
            f.enable(e);
        }
        let opts = CompileOptions::default()
            .with_optimize(true)
            .with_no_entry_point(true)
            .with_x86_features(f);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        let opts = NativeOptions {
            x86_features: f,
            ..NativeOptions::new().with_optimize()
        };
        crate::c5::object::emit_native_single_tu_for_test(&program, Target::LinuxX64, opts)
            .expect("emit")
    };
    // `vpaddd %zmm1, %zmm0, %zmm0`: 62 F1 7D 48 FE C1.
    let evex_paddd = |b: &[u8]| {
        b.windows(5)
            .any(|w| w[0] == 0x62 && w[3] == 0x48 && w[4] == 0xFE)
    };
    assert!(
        evex_paddd(&text(Some("avx512f"))),
        "no zmm vpaddd under AVX-512F"
    );
    assert!(!evex_paddd(&text(None)), "a zmm vpaddd without AVX-512F");
}

/// AVX's 256-bit floating-point operations, the compares by each of their
/// 32 predicates among them, give in the interpreter the results and the
/// exception flags recorded from the instructions (the fixture's hashes),
/// at -O0 and -O.
#[test]
fn avx_floating_operations_compute_as_the_instructions() {
    use crate::{CompileOptions, Compiler, Target, Vm};
    const SRC: &str =
        include_str!("../../../tests/fixtures/c/avx_floating_and_fma_follow_the_sdm.c");
    for optimize in [false, true] {
        let opts = CompileOptions::default().with_optimize(optimize);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        assert_eq!(
            Vm::new(program).run().expect("run"),
            0,
            "optimize={optimize}"
        );
    }
}

/// The 128-bit halves of the AVX vectors -- extract, insert, the casts
/// between the widths and the float forms on them -- compute as the bytes
/// they move, in the interpreter at -O0 and -O, and are one instruction
/// each at -O: `vextracti128`, `vinserti128`, and for the casts a VEX
/// `vmovdqa` of the xmm register, which clears the bits above it.
#[test]
fn avx_halves_are_their_instructions() {
    use crate::{CompileOptions, Compiler, Target, Vm};
    const SRC: &str = include_str!("../../../tests/fixtures/c/avx_halves_and_casts.c");
    for optimize in [false, true] {
        let opts = CompileOptions::default().with_optimize(optimize);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        assert_eq!(
            Vm::new(program).run().expect("run"),
            0,
            "optimize={optimize}"
        );
    }
    #[cfg(feature = "full")]
    {
        use super::perf_codegen::x64_at;
        const PARTS: &str = "#include <immintrin.h>\n\
__m128i hi(const __m256i *p) { return _mm256_extracti128_si256(*p, 1); }\n\
void put(__m256i *p, const __m128i *x) { *p = _mm256_inserti128_si256(*p, *x, 1); }\n\
void widen(__m256i *p, const __m128i *x) { *p = _mm256_zextsi128_si256(*x); }\n";
        // VEX 0F3A 39 and 38; `vmovdqa` (0F 6F) in its xmm form.
        let hi = x64_at(PARTS, "hi", true);
        assert!(hi.iter().any(|i| i.vex && i.op == 0x3A39), "hi: {hi:x?}");
        let put = x64_at(PARTS, "put", true);
        assert!(put.iter().any(|i| i.vex && i.op == 0x3A38), "put: {put:x?}");
        let widen = x64_at(PARTS, "widen", true);
        assert!(
            widen.iter().all(|i| i.op != 0x3A38 && i.op != 0x3A39) && widen.len() <= 5,
            "widen: {widen:x?}"
        );
    }
}

/// The AVX512VL forms at 256 and 128 bits -- the compares into a mask by
/// each predicate, the blends, a masked shuffle -- the ymm VNNI dot
/// product, the zero-masked 512-bit extracts and `_mm512_set_epi8` compute
/// as the per-lane C they stand for, in the interpreter at -O0 and -O, and
/// the unit lowers.
#[test]
fn avx512vl_forms_compute_as_their_definitions() {
    use crate::{CompileOptions, Compiler, Target, Vm};
    const SRC: &str = "#include <immintrin.h>\n\
static signed char a[32], b[32];\n\
int main(void) {\n\
    for (int i = 0; i < 32; i++) a[i] = (signed char)(i * 37 - 90), b[i] = (signed char)(70 - i * 5);\n\
    __m128i x = _mm_loadu_si128((const __m128i *)a), y = _mm_loadu_si128((const __m128i *)b);\n\
    __mmask16 le = _mm_cmp_epi8_mask(x, y, _MM_CMPINT_LE);\n\
    for (int i = 0; i < 16; i++) if (((le >> i) & 1) != (a[i] <= b[i])) return 1;\n\
    __mmask16 gtu = _mm_cmpgt_epu8_mask(x, y);\n\
    for (int i = 0; i < 16; i++) if (((gtu >> i) & 1) != ((unsigned char)a[i] > (unsigned char)b[i])) return 2;\n\
    __m256i X = _mm256_loadu_si256((const __m256i *)a), Y = _mm256_loadu_si256((const __m256i *)b);\n\
    __mmask8 ne = _mm256_cmpneq_epi32_mask(X, Y);\n\
    int *ia = (int *)a, *ib = (int *)b;\n\
    for (int i = 0; i < 8; i++) if (((ne >> i) & 1) != (ia[i] != ib[i])) return 3;\n\
    __m256i bl = _mm256_mask_blend_epi32(0xA5, X, Y);\n\
    for (int i = 0; i < 8; i++) if (((int *)&bl)[i] != ((0xA5 >> i) & 1 ? ib[i] : ia[i])) return 4;\n\
    __m128i sh = _mm_mask_shuffle_epi8(y, 0x0F0F, x, _mm_set1_epi8(3));\n\
    for (int i = 0; i < 16; i++) if (((signed char *)&sh)[i] != ((0x0F0F >> i) & 1 ? a[3] : b[i])) return 5;\n\
    __m256i dp = _mm256_dpbusd_epi32(_mm256_set1_epi32(7), X, Y);\n\
    for (int i = 0; i < 8; i++) {\n\
        int e = 7;\n\
        for (int k = 0; k < 4; k++) e += (unsigned char)a[4 * i + k] * b[4 * i + k];\n\
        if (((int *)&dp)[i] != e) return 6;\n\
    }\n\
    __m512i z = _mm512_set_epi8(63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 51, 50, 49, 48, 47, 46, 45,\n\
        44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19,\n\
        18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);\n\
    for (int i = 0; i < 64; i++) if (((char *)&z)[i] != i) return 7;\n\
    __m256i hi = _mm512_maskz_extracti64x4_epi64(0x5, z, 1);\n\
    long long *lz = (long long *)&z, *lh = (long long *)&hi;\n\
    for (int i = 0; i < 4; i++) if (lh[i] != ((0x5 >> i) & 1 ? lz[4 + i] : 0)) return 8;\n\
    __m128i q = _mm512_maskz_extracti32x4_epi32(0x6, z, 2);\n\
    int *iz = (int *)&z, *iq = (int *)&q;\n\
    for (int i = 0; i < 4; i++) if (iq[i] != ((0x6 >> i) & 1 ? iz[8 + i] : 0)) return 9;\n\
    return 0;\n\
}\n\
";
    for optimize in [false, true] {
        let opts = CompileOptions::default().with_optimize(optimize);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        assert_eq!(
            Vm::new(program).run().expect("run"),
            0,
            "optimize={optimize}"
        );
    }
    #[cfg(feature = "full")]
    {
        let opts = CompileOptions::default().with_optimize(true);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        crate::c5::object::emit_native_single_tu_for_test(
            &program,
            Target::LinuxX64,
            crate::NativeOptions::new().with_optimize(),
        )
        .expect("emit_native for linux-x64");
    }
}

/// The <immintrin.h> AVX-512 intrinsics compute as the per-element C they
/// stand for: an Adler-32 of 64-byte blocks by vpsadbw and vpdpbusd with a
/// masked tail load against the bytewise sum, a compare into a mask and the
/// blend it selects, the ternary logic, the quadword permute by index, and
/// the reductions; in the interpreter at -O0 and -O, and the unit lowers.
#[test]
fn avx512_intrinsics_compute_as_their_definitions() {
    use crate::{CompileOptions, Compiler, Target, Vm};
    const SRC: &str = "#include <immintrin.h>\n\
static unsigned char buf[1000];\n\
static unsigned adler_ref(const unsigned char *p, int n) { unsigned a = 1, b = 0; for (int i = 0; i < n; i++) { a = (a + p[i]) % 65521; b = (b + a) % 65521; } return a | b << 16; }\n\
static unsigned adler_512(const unsigned char *p, int n) {\n\
    const __m512i w = _mm512_set_epi32(0x01020304, 0x05060708, 0x090a0b0c, 0x0d0e0f10, 0x11121314, 0x15161718, 0x191a1b1c, 0x1d1e1f20,\n\
                                       0x21222324, 0x25262728, 0x292a2b2c, 0x2d2e2f30, 0x31323334, 0x35363738, 0x393a3b3c, 0x3d3e3f40);\n\
    unsigned a = 1, b = 0;\n\
    while (n >= 64) {\n\
        int k = n < 5504 ? n & ~63 : 5504;\n\
        n -= k;\n\
        __m512i va = _mm512_zextsi128_si512(_mm_cvtsi32_si128((int)a)), vb = _mm512_zextsi128_si512(_mm_cvtsi32_si128((int)b)), vp = _mm512_setzero_si512();\n\
        for (; k > 0; k -= 64, p += 64) {\n\
            __m512i x = _mm512_loadu_si512(p);\n\
            vp = _mm512_add_epi32(vp, va);\n\
            va = _mm512_add_epi32(va, _mm512_sad_epu8(x, _mm512_setzero_si512()));\n\
            vb = _mm512_dpbusd_epi32(vb, x, w);\n\
        }\n\
        vb = _mm512_add_epi32(vb, _mm512_slli_epi32(vp, 6));\n\
        a = (unsigned)_mm512_reduce_add_epi32(va) % 65521;\n\
        b = (unsigned)_mm512_reduce_add_epi32(vb) % 65521;\n\
    }\n\
    __m512i t = _mm512_maskz_loadu_epi8(n ? ~0ULL >> (64 - n) : 0, p);\n\
    unsigned char tb[64]; _mm512_storeu_si512(tb, t);\n\
    for (int i = 0; i < n; i++) { a = (a + tb[i]) % 65521; b = (b + a) % 65521; }\n\
    return a | b << 16;\n\
}\n\
int main(void) {\n\
    for (int i = 0; i < 1000; i++) buf[i] = (unsigned char)(i * 131 + (i >> 3));\n\
    for (int n = 0; n <= 1000; n += 37) if (adler_512(buf, n) != adler_ref(buf, n)) return 1;\n\
    __m512i x = _mm512_loadu_si512(buf), y = _mm512_loadu_si512(buf + 64);\n\
    __mmask64 m = _mm512_cmpgt_epu8_mask(x, y);\n\
    for (int i = 0; i < 64; i++) if (((m >> i) & 1) != (buf[i] > buf[64 + i])) return 2;\n\
    __m512i mx = _mm512_mask_blend_epi8(m, y, x);\n\
    unsigned char o[64]; _mm512_storeu_si512(o, mx);\n\
    for (int i = 0; i < 64; i++) if (o[i] != (buf[i] > buf[64 + i] ? buf[i] : buf[64 + i])) return 3;\n\
    __m512i tl = _mm512_ternarylogic_epi32(x, y, mx, 0x96);\n\
    _mm512_storeu_si512(o, tl);\n\
    for (int i = 0; i < 64; i++) if (o[i] != (unsigned char)(buf[i] ^ buf[64 + i] ^ (buf[i] > buf[64 + i] ? buf[i] : buf[64 + i]))) return 4;\n\
    __m512i px = _mm512_permutexvar_epi64(_mm512_set_epi64(0, 1, 2, 3, 4, 5, 6, 7), x);\n\
    long long *q = (long long *)buf;\n\
    for (int i = 0; i < 8; i++) if (((long long *)&px)[i] != q[7 - i]) return 5;\n\
    if (_mm512_reduce_add_epi64(_mm512_set1_epi64(3)) != 24) return 6;\n\
    return 0;\n\
}\n\
";
    for optimize in [false, true] {
        let opts = CompileOptions::default().with_optimize(optimize);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        assert_eq!(
            Vm::new(program).run().expect("run"),
            0,
            "optimize={optimize}"
        );
    }
    #[cfg(feature = "full")]
    {
        let opts = CompileOptions::default().with_optimize(true);
        let program = Compiler::with_options(SRC.into(), Target::LinuxX64, opts)
            .compile()
            .expect("compile");
        crate::c5::object::emit_native_single_tu_for_test(
            &program,
            Target::LinuxX64,
            crate::NativeOptions::new().with_optimize(),
        )
        .expect("emit_native for linux-x64");
    }
}

/// A GNU vector comparison and a shift by a constant count are one
/// instruction on the whole vector (`simd::find`): the comparison the VEX
/// three-operand form into the result's register.
#[cfg(feature = "full")]
#[test]
fn the_vector_operators_take_the_rows() {
    use crate::{NativeOptions, Target};
    let src = "typedef int v4 __attribute__((vector_size(16)));\n\
         typedef unsigned short u8h __attribute__((vector_size(16)));\n\
         v4 lt(v4 a, v4 b) { return a < b; }\n\
         u8h shr(u8h a) { return a >> 3; }\n\
         int main(void) { return 0; }";
    let program = super::compile_str_bare_for(src, Target::LinuxX64);
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit_native for linux-x64");
    for (needle, what) in [
        (
            &[0xc5u8, 0xf1, 0x66, 0xc0][..],
            "vpcmpgtd %xmm0, %xmm1, %xmm0",
        ),
        (&[0x66, 0x0f, 0x71, 0xd0, 0x03][..], "psrlw $3, %xmm0"),
    ] {
        assert!(
            bytes.windows(needle.len()).any(|w| w == needle),
            "{what}: expected encoding {needle:02x?} not in the emitted code"
        );
    }
}

/// A lane of an 8-byte vector is read and written in its xmm register, as
/// a 16-byte vector's is.
#[cfg(feature = "full")]
#[test]
fn an_8_byte_vector_lane_stays_in_its_register() {
    use crate::{NativeOptions, Target};
    let src = "typedef short v4h __attribute__((vector_size(8)));\n\
         int loc(v4h a, v4h b) { v4h v = a + b; return v[3]; }\n\
         v4h setl(v4h a, v4h b, short x) { v4h v = a + b; v[2] = x; return v; }\n\
         int main(void) { return 0; }";
    let program = super::compile_str_bare_for(src, Target::LinuxX64);
    let bytes = crate::c5::object::emit_native_single_tu_for_test(
        &program,
        Target::LinuxX64,
        NativeOptions::new().with_optimize(),
    )
    .expect("emit_native for linux-x64");
    // The opcode and the lane immediate, in either VEX form: the registers
    // are the allocator's.
    let has = |op: u8, imm: u8| {
        bytes
            .windows(5)
            .any(|w| w[0] == 0xc5 && w[2] == op && w[4] == imm)
            || bytes
                .windows(6)
                .any(|w| w[0] == 0xc4 && w[3] == op && w[5] == imm)
    };
    assert!(has(0xc5, 3), "vpextrw $3 not in the emitted code");
    assert!(has(0xc4, 2), "vpinsrw $2 not in the emitted code");
}

/// A row that returns a narrower vector than its operands stores its
/// result's width, the bound the inliner checks a result slot write by.
#[test]
fn a_narrowing_row_stores_its_result_width() {
    let op = simd::lookup("__builtin_ia32_extract128i256").expect("the row");
    let stores: Vec<_> = simd::get(op).stores().collect();
    assert_eq!(stores, [(0, 16)]);
}

/// The bundled intrinsics are inlined at every optimization level on both
/// x86-64 ABIs, so the object defines none of them.
#[cfg(feature = "full")]
#[test]
fn the_intrinsics_are_inlined_at_every_level() {
    use crate::Target;
    let src = "#include <immintrin.h>\n\
         __m128i lo(__m256i a) { return _mm256_castsi256_si128(a); }\n\
         __m256i add(__m256i a, __m256i b) { return _mm256_add_epi32(a, b); }\n\
         __m128 mul(__m128 a, __m128 b) { return _mm_mul_ps(a, b); }\n";
    for target in [Target::LinuxX64, Target::WindowsX64] {
        for optimize in [false, true] {
            let obj = super::perf_codegen::object_at(src, target, optimize);
            let names: Vec<_> = super::codegen::elf_func_symbols(&obj)
                .into_iter()
                .map(|(n, _)| n)
                .collect();
            assert_eq!(
                names,
                ["lo", "add", "mul"],
                "{target:?} optimize={optimize}"
            );
        }
    }
}
