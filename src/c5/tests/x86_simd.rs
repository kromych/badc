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
        ("pmaddwd128", 0xf5),
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

/// gcc's and clang's x86 system-instruction builtins, with gcc's prototypes,
/// emit their instruction on both x86-64 targets, `__builtin_ia32_xgetbv`
/// with its operand in ecx; on the AArch64 targets `__has_builtin` reports
/// none of them and a call is to an unknown function, as gcc and clang have
/// them.
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

/// gcc's and clang's wrappers over the system builtins emit their
/// instruction on both x86-64 targets: the `_mm_` fences, `_xgetbv`,
/// `__rdtscp` and the RFLAGS pair, with the builtins `rdtscp` and
/// `writeeflags_u64`. `_xgetbv` is gcc's `long long` on Linux and MSVC's
/// `unsigned __int64` intrinsic on Windows, where every name here is one.
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

/// `<cpuid.h>` executes CPUID, as gcc's does: `__get_cpuid_max` emits the
/// instruction on both x86-64 targets with the range's first leaf in eax,
/// rather than folding to a constant. The interpreter runs CPUID as zero in
/// every register, so there the maximum is 0 and `__get_cpuid` rejects the
/// leaf, leaving its outputs as they were.
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
    // The complement-and takes the first operand complemented.
    assert_eq!(
        x86_simd::eval(Sem::AndNot, &[0x0f; 16], &[0x33; 16], 0, 0),
        [0x30u8; 16]
    );
    // A signed compare orders the negative lane below the positive one.
    let neg = v([0xff, 0xff, 0xff, 0xff, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    let gt = x86_simd::eval(Sem::CmpGt(4), &one, &neg, 0, 0);
    assert_eq!(&gt[..4], &[0xff, 0xff, 0xff, 0xff]);
    let gt = x86_simd::eval(Sem::CmpGt(4), &neg, &one, 0, 0);
    assert_eq!(&gt[..4], &[0, 0, 0, 0]);
    // The byte compare is per byte, not per doubleword.
    let gt = x86_simd::eval(Sem::CmpGt(1), &b, &a, 0, 0);
    assert_eq!(&gt[..5], &[0xff, 0, 0, 0, 0xff]);
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
        x86_simd::eval(Sem::UnpackLo(8), &x, &y, 0, 0),
        v([1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2])
    );
    assert_eq!(
        x86_simd::eval(Sem::UnpackHi(8), &x, &y, 0, 0),
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
    let lo = x86_simd::eval(Sem::UnpackLo(1), &a, &b, 0, 0);
    assert_eq!(&lo[..6], &[0, 0x80, 1, 0x81, 2, 0x82]);
    let hi = x86_simd::eval(Sem::UnpackHi(1), &a, &b, 0, 0);
    assert_eq!(&hi[..6], &[8, 0x88, 9, 0x89, 10, 0x8a]);
    let lo = x86_simd::eval(Sem::UnpackLo(2), &a, &b, 0, 0);
    assert_eq!(&lo[..8], &[0, 1, 0x80, 0x81, 2, 3, 0x82, 0x83]);
    let hi = x86_simd::eval(Sem::UnpackHi(4), &a, &b, 0, 0);
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
    let s = x86_simd::eval(Sem::PackSigned(2), &a, &b, 0, 0);
    assert_eq!(&s[..8], &[0x7f; 8]);
    assert_eq!(&s[8..], &[0x80; 8]);
    let u = x86_simd::eval(Sem::PackUnsigned(2), &a, &b, 0, 0);
    assert_eq!(&u[..8], &[0xff; 8]);
    assert_eq!(&u[8..], &[0; 8]);
    // A doubleword source saturates into a word: 70000 -> 0x7fff.
    let big = v([
        0x70, 0x11, 0x01, 0x00, 0x70, 0x11, 0x01, 0x00, 0x70, 0x11, 0x01, 0x00, 0x70, 0x11, 0x01,
        0x00,
    ]);
    let d = x86_simd::eval(Sem::PackSigned(4), &big, &big, 0, 0);
    assert_eq!(&d[..4], &[0xff, 0x7f, 0xff, 0x7f]);
    // A lane already in range passes through.
    let small = v([7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0]);
    let p = x86_simd::eval(Sem::PackSigned(4), &small, &small, 0, 0);
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
    let lo = x86_simd::eval(Sem::MulLo(2), &a, &three, 0, 0);
    // 0x1234 * 3 = 0x369c; 0x1000 * 3 = 0x3000.
    assert_eq!(&lo[..4], &[0x9c, 0x36, 0x00, 0x30]);
    let hi = x86_simd::eval(Sem::MulHi(2), &a, &three, 0, 0);
    // 0x1234 * 3 fits in a word, so the high half is zero; -4096 * 3 =
    // -12288, whose high half is the sign.
    assert_eq!(&hi[..2], &[0, 0]);
    assert_eq!(&hi[4..6], &[0xff, 0xff]);
    // Each doubleword is a[2i]*b[2i] + a[2i+1]*b[2i+1]: 0x1234*3 +
    // 0x1000*3 = 0x669c.
    let madd = x86_simd::eval(Sem::MulAddWords, &a, &three, 0, 0);
    assert_eq!(&madd[..4], &[0x9c, 0x66, 0, 0]);
    // The signed extreme wraps within the doubleword, as the
    // instruction does: (-32768 * -32768) * 2 = 2^31.
    let m = v([0x00, 0x80, 0x00, 0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    let w = x86_simd::eval(Sem::MulAddWords, &m, &m, 0, 0);
    assert_eq!(&w[..4], &[0x00, 0x00, 0x00, 0x80]);
}

/// The arithmetic shift propagates the sign, and a count at or past the
/// lane width leaves every bit equal to it.
#[test]
fn the_arithmetic_shift_propagates_the_sign() {
    let neg = v([
        0xf0, 0xff, 0xf0, 0xff, 0xf0, 0xff, 0xf0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0,
    ]);
    let r = x86_simd::eval(Sem::Sar(2), &neg, &[0; 16], 0, 2);
    assert_eq!(&r[..4], &[0xfc, 0xff, 0xfc, 0xff]);
    assert_eq!(&r[8..10], &[0, 0]);
    let r = x86_simd::eval(Sem::Sar(2), &neg, &[0; 16], 0, 99);
    assert_eq!(&r[..4], &[0xff, 0xff, 0xff, 0xff]);
    // The same bytes as doublewords: 0xfff0fff0 >> 4 = 0xffff0fff.
    let r = x86_simd::eval(Sem::Sar(4), &neg, &[0; 16], 0, 4);
    assert_eq!(&r[..4], &[0xff, 0x0f, 0xff, 0xff]);
    // The unsigned shift of the same lanes does not.
    let r = x86_simd::eval(Sem::Shr(2), &neg, &[0; 16], 0, 2);
    assert_eq!(&r[..2], &[0xfc, 0x3f]);
}

/// The byte-granular shifts move the whole register, zero-filling.
#[test]
fn the_whole_register_shifts_fill_with_zero() {
    let a = v([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    assert_eq!(
        x86_simd::eval(Sem::ShrBytes, &a, &[0; 16], 0, 3),
        v([3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 0, 0])
    );
    assert_eq!(
        x86_simd::eval(Sem::ShrBytes, &a, &[0; 16], 0, 16),
        [0u8; 16]
    );
    assert_eq!(
        x86_simd::eval(Sem::ShrBytes, &a, &[0; 16], 0, 255),
        [0u8; 16]
    );
}

/// The byte sign bits, lane `i` at bit `i`.
#[test]
fn the_sign_mask_reads_one_bit_per_byte() {
    assert_eq!(x86_simd::eval_movemask(&[0x80; 16]), 0xffff);
    assert_eq!(x86_simd::eval_movemask(&[0x7f; 16]), 0);
    let mut a = [0u8; 16];
    a[0] = 0x80;
    a[15] = 0xff;
    assert_eq!(x86_simd::eval_movemask(&a), 0x8001);
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
        assert_eq!(
            row.ret.lane_ty().is_some(),
            row.form.returns_vector(),
            "{}: result type and form disagree",
            row.name
        );
        assert_eq!(
            row.ret == x86_simd::Ret::Void,
            row.form == x86_simd::Form::Store,
            "{}: only the store returns void",
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
    ] {
        assert_emits(&format!("{PS}{src}"), expected, what);
    }
}

/// A floating-point row computes in the interpreter's floating-point
/// environment, which rounds in its direction and raises its exceptions; the
/// others compute over integer lanes. A new semantics takes its place here.
#[test]
fn floating_rows_compute_in_the_environment() {
    let floating = |sem: Sem| match sem {
        Sem::Float(..) | Sem::FloatCmp(..) | Sem::Convert(_) | Sem::ToInt(..) => true,
        Sem::Add(_)
        | Sem::Sub(_)
        | Sem::MulLo(_)
        | Sem::MulHi(_)
        | Sem::MulAddWords
        | Sem::MulAddBytes
        | Sem::MulEvenU
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
        | Sem::ShufPd
        | Sem::ClMul
        | Sem::AesEnc
        | Sem::AesEncLast
        | Sem::AesDec
        | Sem::AesDecLast
        | Sem::AesImc
        | Sem::AesKeygen
        | Sem::Move
        | Sem::Rand => false,
    };
    /// Counts the operations a row asks of the environment.
    struct Counting(u32);
    impl x86_simd::FloatEnv for Counting {
        fn arith(&mut self, _: x86_simd::FOp, a: u64, _: u64, _: bool) -> u64 {
            self.0 += 1;
            a
        }
        fn compare(&mut self, _: u64, _: u64, _: bool) -> Option<core::cmp::Ordering> {
            self.0 += 1;
            None
        }
        fn to_int(&mut self, _: u64, _: bool, _: u32) -> i64 {
            self.0 += 1;
            0
        }
        fn int32_to_float(&mut self, _: i32, _: bool) -> u64 {
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
    }
    for op in x86_simd::OPS {
        let (mut env, a) = (Counting(0), [0x3f; 16]);
        let packed = x86_simd::eval_float(&mut env, op.sem, &a, &a, 0).is_some();
        let scalar = x86_simd::eval_to_int(&mut env, op.sem, &a, 32).is_some();
        assert_eq!(packed || scalar, floating(op.sem), "{}", op.name);
        assert_eq!(env.0 > 0, floating(op.sem), "{}", op.name);
    }
}

/// The floating-point rows compute in the interpreter as the instructions
/// do: the fixture's hashes, which the instructions gave in each rounding
/// direction, hold under the interpreter for both x86-64 targets.
#[test]
fn the_interpreter_computes_the_floating_rows_as_the_instructions_do() {
    let src = super::load_fixture("sse_floating_lanes_follow_the_sdm.c");
    for target in [crate::Target::LinuxX64, crate::Target::WindowsX64] {
        let program = crate::Compiler::with_options(src.clone(), target, Default::default())
            .compile()
            .expect("compile");
        let rc = super::Vm::new(program).run().expect("run");
        assert_eq!(rc, 0, "{target:?}: row {rc} differs");
    }
}
