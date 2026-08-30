//! EVEX encoding tests.
//!
//! Every expected byte string is what GNU as 2.46.1 emits for the AT&T text on
//! the left, taken from `objdump -d` of an assembled object. The `disp8*N`
//! cases carry, per tuple type, a displacement that compresses, the largest and
//! smallest that do, and the neighbours that must fall back to disp32: a wrong
//! scale factor encodes cleanly and addresses the wrong memory, so the boundary
//! is where it shows.

use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::ir::AsmRegSize;

use super::super::asm::{
    AsmMemBase, AsmOpnd, Concrete, encode_in, parse_file_template, parse_template,
};
use super::super::table::Mode;

/// Assemble one AT&T instruction the way the file-scope asm path does.
fn enc(text: &str) -> Result<Vec<u8>, String> {
    enc_in(text, Mode::Bits64)
}

/// [`enc`] in a given code mode. VEX and EVEX carry no mode-dependent field,
/// so only the addressing an instruction's memory operand encodes differs.
fn enc_in(text: &str, mode: Mode) -> Result<Vec<u8>, String> {
    let mut out = Vec::new();
    for insn in parse_file_template(text.as_bytes())? {
        let reg_of = |b: AsmMemBase| match b {
            AsmMemBase::Reg { num, .. } => num,
            AsmMemBase::Ref(_) => unreachable!("explicit-register template expected"),
        };
        let ops: Vec<Concrete> = insn
            .operands
            .iter()
            .map(|o| match *o {
                AsmOpnd::Reg { reg, size } => Concrete::Reg { reg, size },
                AsmOpnd::Imm(v) => Concrete::Imm(v),
                AsmOpnd::Mem {
                    base,
                    index,
                    scale,
                    disp,
                } => Concrete::Mem {
                    base: reg_of(base),
                    index: index.map(reg_of),
                    scale,
                    disp,
                    size: AsmRegSize::Quad,
                },
                ref other => panic!("unexpected operand {other:?}"),
            })
            .collect();
        let addr = super::super::asm::addr_size(&insn, mode);
        encode_in(&mut out, mode, addr, insn.mnemonic, insn.suffix, &ops)?;
    }
    Ok(out)
}

/// Check one instruction against the bytes GNU as emits for it.
#[track_caller]
fn gas(text: &str, bytes: &[u8]) {
    match enc(text) {
        Ok(got) if got == bytes => {}
        Ok(got) => panic!("{text}\n  badc {got:02x?}\n  gas  {bytes:02x?}"),
        Err(e) => panic!("{text}: {e}"),
    }
}

/// Check one instruction in a given code mode against the bytes GNU as emits.
#[track_caller]
fn gas_in(text: &str, mode: Mode, bytes: &[u8]) {
    match enc_in(text, mode) {
        Ok(got) if got == bytes => {}
        Ok(got) => panic!("{text}\n  badc {got:02x?}\n  gas  {bytes:02x?}"),
        Err(e) => panic!("{text}: {e}"),
    }
}

/// Check that an instruction is refused, and that the diagnostic names why.
#[track_caller]
fn refused(text: &str, needle: &str) {
    match enc(text) {
        Err(e) if e.contains(needle) => {}
        Err(e) => panic!("{text}: refused with `{e}`, expected `{needle}`"),
        Ok(b) => panic!("{text}: encoded {b:02x?}, expected a refusal"),
    }
}

/// The instructions that kept the x86_64 defconfig kernel's last assembly
/// units on gas.
#[test]
fn kernel_units() {
    // lib/crypto/x86/poly1305-x86_64-cryptogams.S: the same lane permute in
    // its AVX2 (VEX, 256-bit) and AVX-512 (EVEX, 512-bit) instantiations.
    gas(
        "vpermq $0x2,%ymm3,%ymm10",
        &[0xC4, 0x63, 0xFD, 0x00, 0xD3, 0x02],
    );
    gas(
        "vpermq $0x2,%zmm3,%zmm14",
        &[0x62, 0x73, 0xFD, 0x48, 0x00, 0xF3, 0x02],
    );
    gas(
        "vpermq $0xb1,%zmm15,%zmm4",
        &[0x62, 0xD3, 0xFD, 0x48, 0x00, 0xE7, 0xB1],
    );
    // The same unit's widening multiply, which EVEX gives a qword broadcast
    // and so W=1 where VEX ignores the bit.
    gas(
        "vpmuludq %zmm7,%zmm16,%zmm11",
        &[0x62, 0x71, 0xFD, 0x40, 0xF4, 0xDF],
    );
    // arch/x86/crypto/aes-ctr-avx-x86_64.S: `vpbroadcastq XCTR_CTR, LE_CTR`
    // with XCTR_CTR = %r9 and LE_CTR = V9 at vl=64.
    gas(
        "vpbroadcastq %r9,%zmm9",
        &[0x62, 0x52, 0xFD, 0x48, 0x7C, 0xC9],
    );
    // lib/crypto/x86/blake2s-core.S.
    gas(
        "vpermi2d %ymm7,%ymm6,%ymm8",
        &[0x62, 0x72, 0x4D, 0x28, 0x76, 0xC7],
    );
    gas(
        "vpermi2d %ymm7,%ymm6,%ymm9",
        &[0x62, 0x72, 0x4D, 0x28, 0x76, 0xCF],
    );
    // lib/crc/x86/crc32-pclmul.S: `_cond_vex "pextrd $1 + LSB_CRC,"` with
    // LSB_CRC = 1, so the immediate is the expression `1 + 1`.
    gas(
        "vpextrd $1 + 1, %xmm0, %eax",
        &[0xC4, 0xE3, 0x79, 0x16, 0xC0, 0x02],
    );
    gas(
        "vpextrd $2,%xmm0,%eax",
        &[0xC4, 0xE3, 0x79, 0x16, 0xC0, 0x02],
    );
    // The rest of that unit's AVX-512 instantiation (vl=64, avx_level=512).
    gas(
        "vpternlogq $0x96,%xmm2,%xmm1,%xmm0",
        &[0x62, 0xF3, 0xF5, 0x08, 0x25, 0xC2, 0x96],
    );
    gas(
        "vpternlogq $0x96,(%rsi),%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x48, 0x25, 0x06, 0x96],
    );
    gas(
        "vpternlogq $0x96,64(%rsi),%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x48, 0x25, 0x46, 0x01, 0x96],
    );
    gas(
        "vpxorq (%rsi),%zmm1,%zmm0",
        &[0x62, 0xF1, 0xF5, 0x48, 0xEF, 0x06],
    );
    gas(
        "vmovdqu8 (%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x0E],
    );
    gas(
        "vmovdqu8 0xc0(%rsi),%zmm3",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x5E, 0x03],
    );
    gas(
        "vbroadcasti32x4 -0x20(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x5A, 0x79, 0xFE],
    );
    gas(
        "vextracti64x4 $0x1,%zmm0,%ymm1",
        &[0x62, 0xF3, 0xFD, 0x48, 0x3B, 0xC1, 0x01],
    );
    gas(
        "vpclmulqdq $0x11,%zmm7,%zmm1,%zmm1",
        &[0x62, 0xF3, 0x75, 0x48, 0x44, 0xCF, 0x11],
    );
    // The same op below 512 bits stays on VEX, as GNU as encodes it.
    gas(
        "vpclmulqdq $0x00,%ymm7,%ymm0,%ymm0",
        &[0xC4, 0xE3, 0x7D, 0x44, 0xC7, 0x00],
    );
    gas(
        "vpclmulqdq $0x00,%xmm7,%xmm0,%xmm0",
        &[0xC4, 0xE3, 0x79, 0x44, 0xC7, 0x00],
    );
    // arch/x86/crypto/aria-{aesni-avx,aesni-avx2,gfni-avx512}-asm_64.S: the
    // same affine transform at each of the three vector lengths, VEX below
    // 512 bits and EVEX at it.
    gas(
        "vgf2p8affineqb $0x2c,%xmm4,%xmm15,%xmm15",
        &[0xC4, 0x63, 0x81, 0xCE, 0xFC, 0x2C],
    );
    gas(
        "vgf2p8affineqb $0x2c,%ymm4,%ymm15,%ymm15",
        &[0xC4, 0x63, 0x85, 0xCE, 0xFC, 0x2C],
    );
    gas(
        "vgf2p8affineqb $0x2c,%zmm28,%zmm15,%zmm15",
        &[0x62, 0x13, 0x85, 0x48, 0xCE, 0xFC, 0x2C],
    );
    gas(
        "vgf2p8affineinvqb $0x00,%xmm2,%xmm15,%xmm15",
        &[0xC4, 0x63, 0x81, 0xCF, 0xFA, 0x00],
    );
    gas(
        "vgf2p8affineinvqb $0xe2,%ymm0,%ymm13,%ymm13",
        &[0xC4, 0x63, 0x95, 0xCF, 0xE8, 0xE2],
    );
    gas(
        "vgf2p8affineinvqb $0xe2,%zmm24,%zmm15,%zmm15",
        &[0x62, 0x13, 0x85, 0x48, 0xCF, 0xF8, 0xE2],
    );
}

/// The AVX-512 forms the distribution-configuration crypto units name:
/// `arch/x86/crypto/aes-{ctr,xts}-avx-x86_64.S` (VAES on zmm) and
/// `arch/x86/crypto/aes-gcm-vaes-avx512.S` (the 128-bit lane shuffles).
#[test]
fn vaes_and_lane_shuffles() {
    gas(
        "vaesenc %zmm14,%zmm0,%zmm0",
        &[0x62, 0xD2, 0x7D, 0x48, 0xDC, 0xC6],
    );
    gas(
        "vaesenc %zmm16,%zmm0,%zmm0",
        &[0x62, 0xB2, 0x7D, 0x48, 0xDC, 0xC0],
    );
    gas(
        "vaesenclast %zmm9,%zmm8,%zmm7",
        &[0x62, 0xD2, 0x3D, 0x48, 0xDD, 0xF9],
    );
    gas(
        "vaesdec %zmm1,%zmm2,%zmm3",
        &[0x62, 0xF2, 0x6D, 0x48, 0xDE, 0xD9],
    );
    gas(
        "vaesdeclast (%rdi),%zmm2,%zmm3",
        &[0x62, 0xF2, 0x6D, 0x48, 0xDF, 0x1F],
    );
    // Below 512 bits and with no high register the same op stays on VEX.
    gas("vaesenc %ymm3,%ymm2,%ymm1", &[0xC4, 0xE2, 0x6D, 0xDC, 0xCB]);
    gas(
        "vshufi64x2 $0,%zmm4,%zmm4,%zmm4",
        &[0x62, 0xF3, 0xDD, 0x48, 0x43, 0xE4, 0x00],
    );
    gas(
        "vshufi64x2 $0x11,%zmm20,%zmm5,%zmm6",
        &[0x62, 0xB3, 0xD5, 0x48, 0x43, 0xF4, 0x11],
    );
    gas(
        "vshufi64x2 $2,%ymm4,%ymm5,%ymm6",
        &[0x62, 0xF3, 0xD5, 0x28, 0x43, 0xF4, 0x02],
    );
    gas(
        "vshufi32x4 $1,%zmm4,%zmm5,%zmm6",
        &[0x62, 0xF3, 0x55, 0x48, 0x43, 0xF4, 0x01],
    );
    gas(
        "vshuff64x2 $3,%zmm4,%zmm5,%zmm6",
        &[0x62, 0xF3, 0xD5, 0x48, 0x23, 0xF4, 0x03],
    );
    gas(
        "vshuff32x4 $4,%zmm4,%zmm5,%zmm6",
        &[0x62, 0xF3, 0x55, 0x48, 0x23, 0xF4, 0x04],
    );
}

/// GFNI under EVEX, the form `arch/x86/crypto/aria-gfni-avx512-asm_64.S`
/// names. The affine transforms read qword elements: W is set, the tuple is
/// Full, and a `{1toN}` broadcast reads one qword. The field multiply reads
/// bytes: W is clear, the tuple is Full Mem, and it has no broadcast.
#[test]
fn gfni_evex() {
    // The whole register file through R', X, V' and B.
    gas(
        "vgf2p8affineqb $0x33,%xmm31,%xmm7,%xmm0",
        &[0x62, 0x93, 0xC5, 0x08, 0xCE, 0xC7, 0x33],
    );
    gas(
        "vgf2p8affineqb $0x33,%ymm16,%ymm17,%ymm18",
        &[0x62, 0xA3, 0xF5, 0x20, 0xCE, 0xD0, 0x33],
    );
    gas(
        "vgf2p8affineqb $0x2c,%zmm28,%zmm15,%zmm15",
        &[0x62, 0x13, 0x85, 0x48, 0xCE, 0xFC, 0x2C],
    );
    gas(
        "vgf2p8affineinvqb $0xe2,%zmm24,%zmm15,%zmm15",
        &[0x62, 0x13, 0x85, 0x48, 0xCF, 0xF8, 0xE2],
    );
    // Masking and zeroing.
    gas(
        "vgf2p8affineinvqb $0x33,%zmm3,%zmm2,%zmm9{%k1}",
        &[0x62, 0x73, 0xED, 0x49, 0xCF, 0xCB, 0x33],
    );
    gas(
        "vgf2p8affineinvqb $0x33,%zmm3,%zmm2,%zmm9{%k7}{z}",
        &[0x62, 0x73, 0xED, 0xCF, 0xCF, 0xCB, 0x33],
    );
    gas(
        "vgf2p8affineqb $0x33,%ymm3,%ymm2,%ymm9{%k5}{z}",
        &[0x62, 0x73, 0xED, 0xAD, 0xCE, 0xCB, 0x33],
    );
    // Full tuple: disp8 scales by the vector length, and by 8 -- one qword --
    // under a broadcast.
    gas(
        "vgf2p8affineinvqb $0x33,64(%rdx),%xmm6,%xmm22",
        &[0x62, 0xE3, 0xCD, 0x08, 0xCF, 0x72, 0x04, 0x33],
    );
    gas(
        "vgf2p8affineinvqb $0x33,64(%rdx),%ymm6,%ymm22",
        &[0x62, 0xE3, 0xCD, 0x28, 0xCF, 0x72, 0x02, 0x33],
    );
    gas(
        "vgf2p8affineinvqb $0x33,64(%rdx),%zmm6,%zmm22",
        &[0x62, 0xE3, 0xCD, 0x48, 0xCF, 0x72, 0x01, 0x33],
    );
    gas(
        "vgf2p8affineinvqb $0x33,8128(%rdx),%zmm6,%zmm22",
        &[0x62, 0xE3, 0xCD, 0x48, 0xCF, 0x72, 0x7F, 0x33],
    );
    gas(
        "vgf2p8affineinvqb $0x33,8192(%rdx),%zmm6,%zmm22",
        &[
            0x62, 0xE3, 0xCD, 0x48, 0xCF, 0xB2, 0x00, 0x20, 0x00, 0x00, 0x33,
        ],
    );
    gas(
        "vgf2p8affineinvqb $0x33,63(%rdx),%zmm6,%zmm22",
        &[
            0x62, 0xE3, 0xCD, 0x48, 0xCF, 0xB2, 0x3F, 0x00, 0x00, 0x00, 0x33,
        ],
    );
    gas(
        "vgf2p8affineqb $0x33,(%rdx){1to2},%xmm6,%xmm22",
        &[0x62, 0xE3, 0xCD, 0x18, 0xCE, 0x32, 0x33],
    );
    gas(
        "vgf2p8affineqb $0x33,8(%rdx){1to4},%ymm6,%ymm22",
        &[0x62, 0xE3, 0xCD, 0x38, 0xCE, 0x72, 0x01, 0x33],
    );
    gas(
        "vgf2p8affineqb $0x33,1016(%rdx){1to8},%zmm6,%zmm22",
        &[0x62, 0xE3, 0xCD, 0x58, 0xCE, 0x72, 0x7F, 0x33],
    );
    gas(
        "vgf2p8affineqb $0x33,-1024(%rdx){1to8},%zmm6,%zmm22",
        &[0x62, 0xE3, 0xCD, 0x58, 0xCE, 0x72, 0x80, 0x33],
    );
    gas(
        "vgf2p8affineqb $0x33,1024(%rdx){1to8},%zmm6,%zmm22",
        &[
            0x62, 0xE3, 0xCD, 0x58, 0xCE, 0xB2, 0x00, 0x04, 0x00, 0x00, 0x33,
        ],
    );
    // The field multiply: W clear, no broadcast, disp8 by the vector length.
    gas(
        "vgf2p8mulb %zmm17,%zmm18,%zmm19",
        &[0x62, 0xA2, 0x6D, 0x40, 0xCF, 0xD9],
    );
    gas(
        "vgf2p8mulb %ymm31,%ymm2,%ymm3{%k2}",
        &[0x62, 0x92, 0x6D, 0x2A, 0xCF, 0xDF],
    );
    gas(
        "vgf2p8mulb %xmm16,%xmm1,%xmm2{%k4}{z}",
        &[0x62, 0xB2, 0x75, 0x8C, 0xCF, 0xD0],
    );
    gas(
        "vgf2p8mulb 64(%rdx),%zmm6,%zmm22",
        &[0x62, 0xE2, 0x4D, 0x48, 0xCF, 0x72, 0x01],
    );
    gas(
        "vgf2p8mulb 63(%rdx),%zmm6,%zmm22",
        &[0x62, 0xE2, 0x4D, 0x48, 0xCF, 0xB2, 0x3F, 0x00, 0x00, 0x00],
    );
    gas(
        "vgf2p8mulb 96(%r12,%r13,8),%zmm31,%zmm31",
        &[
            0x62, 0x02, 0x05, 0x40, 0xCF, 0xBC, 0xEC, 0x60, 0x00, 0x00, 0x00,
        ],
    );
}

/// `disp8*N` per tuple type: the scale factor the tuple fixes, the largest and
/// smallest quotients a signed byte holds, and the displacements just past them
/// or off the multiple, which take disp32.
#[test]
fn disp8_compressed_displacement() {
    // Full vector memory (`vmovdqu8`), N = VL: 64 / 32 / 16 bytes.
    gas(
        "vmovdqu8 (%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x0E],
    );
    gas(
        "vmovdqu8 64(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x4E, 0x01],
    );
    gas(
        "vmovdqu8 -64(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x4E, 0xFF],
    );
    gas(
        "vmovdqu8 8128(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x4E, 0x7F],
    );
    gas(
        "vmovdqu8 -8192(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x4E, 0x80],
    );
    // 63 is not a multiple of 64; 65 is not either; 8192 and -8256 are but
    // their quotients overflow a signed byte. All four take disp32.
    gas(
        "vmovdqu8 63(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x8E, 0x3F, 0, 0, 0],
    );
    gas(
        "vmovdqu8 65(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x8E, 0x41, 0, 0, 0],
    );
    gas(
        "vmovdqu8 8192(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x8E, 0x00, 0x20, 0, 0],
    );
    gas(
        "vmovdqu8 -8256(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0x8E, 0xC0, 0xDF, 0xFF, 0xFF],
    );
    // The same form at 256 and 128 bits scales by 32 and 16.
    gas(
        "vmovdqu8 32(%rsi),%ymm1",
        &[0x62, 0xF1, 0x7F, 0x28, 0x6F, 0x4E, 0x01],
    );
    gas(
        "vmovdqu8 4064(%rsi),%ymm1",
        &[0x62, 0xF1, 0x7F, 0x28, 0x6F, 0x4E, 0x7F],
    );
    gas(
        "vmovdqu8 4096(%rsi),%ymm1",
        &[0x62, 0xF1, 0x7F, 0x28, 0x6F, 0x8E, 0x00, 0x10, 0, 0],
    );
    gas(
        "vmovdqu8 16(%rsi),%xmm1",
        &[0x62, 0xF1, 0x7F, 0x08, 0x6F, 0x4E, 0x01],
    );
    gas(
        "vmovdqu8 2032(%rsi),%xmm1",
        &[0x62, 0xF1, 0x7F, 0x08, 0x6F, 0x4E, 0x7F],
    );
    gas(
        "vmovdqu8 2048(%rsi),%xmm1",
        &[0x62, 0xF1, 0x7F, 0x08, 0x6F, 0x8E, 0x00, 0x08, 0, 0],
    );
    // Full vector (`vpternlog*`), N = VL without a broadcast and the element
    // width with one: 8 under W1, 4 under W0.
    gas(
        "vpternlogq $0x96,8128(%rsi),%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x48, 0x25, 0x46, 0x7F, 0x96],
    );
    gas(
        "vpternlogq $0x96,8192(%rsi),%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x48, 0x25, 0x86, 0x00, 0x20, 0, 0, 0x96],
    );
    gas(
        "vpternlogq $0x96,-8192(%rsi),%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x48, 0x25, 0x46, 0x80, 0x96],
    );
    gas(
        "vpternlogq $0x96,8(%rsi){1to8},%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x58, 0x25, 0x46, 0x01, 0x96],
    );
    gas(
        "vpternlogq $0x96,1016(%rsi){1to8},%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x58, 0x25, 0x46, 0x7F, 0x96],
    );
    gas(
        "vpternlogq $0x96,1024(%rsi){1to8},%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x58, 0x25, 0x86, 0x00, 0x04, 0, 0, 0x96],
    );
    gas(
        "vpternlogq $0x96,-1024(%rsi){1to8},%zmm1,%zmm0",
        &[0x62, 0xF3, 0xF5, 0x58, 0x25, 0x46, 0x80, 0x96],
    );
    gas(
        "vpternlogd $0x96,4(%rsi){1to16},%zmm1,%zmm0",
        &[0x62, 0xF3, 0x75, 0x58, 0x25, 0x46, 0x01, 0x96],
    );
    gas(
        "vpternlogd $0x96,508(%rsi){1to16},%zmm1,%zmm0",
        &[0x62, 0xF3, 0x75, 0x58, 0x25, 0x46, 0x7F, 0x96],
    );
    gas(
        "vpternlogd $0x96,512(%rsi){1to16},%zmm1,%zmm0",
        &[0x62, 0xF3, 0x75, 0x58, 0x25, 0x86, 0x00, 0x02, 0, 0, 0x96],
    );
    gas(
        "vpternlogd $0x96,32(%rsi),%ymm1,%ymm0",
        &[0x62, 0xF3, 0x75, 0x28, 0x25, 0x46, 0x01, 0x96],
    );
    gas(
        "vpternlogd $0x96,16(%rsi),%xmm1,%xmm0",
        &[0x62, 0xF3, 0x75, 0x08, 0x25, 0x46, 0x01, 0x96],
    );
    gas(
        "vpaddd 64(%rsi),%zmm1,%zmm0",
        &[0x62, 0xF1, 0x75, 0x48, 0xFE, 0x46, 0x01],
    );
    gas(
        "vpaddd 4(%rsi){1to16},%zmm1,%zmm0",
        &[0x62, 0xF1, 0x75, 0x58, 0xFE, 0x46, 0x01],
    );
    gas(
        "vpaddq 8(%rsi){1to8},%zmm1,%zmm0",
        &[0x62, 0xF1, 0xF5, 0x58, 0xD4, 0x46, 0x01],
    );
    // Element groups: N is the count times the width EVEX.W selects, so it
    // does not follow the vector length.
    gas(
        "vbroadcasti32x4 16(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x5A, 0x79, 0x01],
    );
    gas(
        "vbroadcasti32x4 2032(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x5A, 0x79, 0x7F],
    );
    gas(
        "vbroadcasti32x4 2048(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x5A, 0xB9, 0x00, 0x08, 0, 0],
    );
    gas(
        "vbroadcasti32x4 -2048(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x5A, 0x79, 0x80],
    );
    gas(
        "vbroadcasti32x4 16(%rcx),%ymm7",
        &[0x62, 0xF2, 0x7D, 0x28, 0x5A, 0x79, 0x01],
    );
    gas(
        "vbroadcasti64x4 32(%rcx),%zmm7",
        &[0x62, 0xF2, 0xFD, 0x48, 0x5B, 0x79, 0x01],
    );
    gas(
        "vbroadcasti64x4 4064(%rcx),%zmm7",
        &[0x62, 0xF2, 0xFD, 0x48, 0x5B, 0x79, 0x7F],
    );
    gas(
        "vbroadcasti64x4 4096(%rcx),%zmm7",
        &[0x62, 0xF2, 0xFD, 0x48, 0x5B, 0xB9, 0x00, 0x10, 0, 0],
    );
    gas(
        "vbroadcasti32x2 8(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x59, 0x79, 0x01],
    );
    gas(
        "vbroadcasti64x2 16(%rcx),%zmm7",
        &[0x62, 0xF2, 0xFD, 0x48, 0x5A, 0x79, 0x01],
    );
    gas(
        "vinserti64x4 $1,32(%rcx),%zmm7,%zmm7",
        &[0x62, 0xF3, 0xC5, 0x48, 0x3A, 0x79, 0x01, 0x01],
    );
    gas(
        "vextracti64x4 $1,%zmm0,32(%rcx)",
        &[0x62, 0xF3, 0xFD, 0x48, 0x3B, 0x41, 0x01, 0x01],
    );
    gas(
        "vextracti32x4 $1,%zmm0,16(%rcx)",
        &[0x62, 0xF3, 0x7D, 0x48, 0x39, 0x41, 0x01, 0x01],
    );
    // Half, quarter and eighth of a vector: the packed extends and converts.
    gas(
        "vpmovzxbw 32(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x30, 0x79, 0x01],
    );
    gas(
        "vpmovzxbw 4064(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x30, 0x79, 0x7F],
    );
    gas(
        "vpmovzxbw 4096(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x30, 0xB9, 0x00, 0x10, 0, 0],
    );
    gas(
        "vpmovzxbd 16(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x31, 0x79, 0x01],
    );
    gas(
        "vpmovzxbd 2032(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x31, 0x79, 0x7F],
    );
    gas(
        "vpmovzxbq 8(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x32, 0x79, 0x01],
    );
    gas(
        "vpmovzxbq 1016(%rcx),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x32, 0x79, 0x7F],
    );
    gas(
        "vcvtdq2pd 32(%rcx),%zmm7",
        &[0x62, 0xF1, 0x7E, 0x48, 0xE6, 0x79, 0x01],
    );
    gas(
        "vcvtdq2pd 4064(%rcx),%zmm7",
        &[0x62, 0xF1, 0x7E, 0x48, 0xE6, 0x79, 0x7F],
    );
    gas(
        "vcvtdq2pd 4(%rcx){1to8},%zmm7",
        &[0x62, 0xF1, 0x7E, 0x58, 0xE6, 0x79, 0x01],
    );
    // One element, width from EVEX.W.
    gas(
        "vaddss 4(%rcx),%xmm17,%xmm18",
        &[0x62, 0xE1, 0x76, 0x00, 0x58, 0x51, 0x01],
    );
    gas(
        "vaddss 508(%rcx),%xmm17,%xmm18",
        &[0x62, 0xE1, 0x76, 0x00, 0x58, 0x51, 0x7F],
    );
    gas(
        "vaddss 512(%rcx),%xmm17,%xmm18",
        &[0x62, 0xE1, 0x76, 0x00, 0x58, 0x91, 0x00, 0x02, 0, 0],
    );
    gas(
        "vaddsd 8(%rcx),%xmm17,%xmm18",
        &[0x62, 0xE1, 0xF7, 0x00, 0x58, 0x51, 0x01],
    );
    gas(
        "vaddsd 1016(%rcx),%xmm17,%xmm18",
        &[0x62, 0xE1, 0xF7, 0x00, 0x58, 0x51, 0x7F],
    );
}

/// The extended register file: xmm/ymm16..31 and zmm0..31 reach ModRM.reg
/// through `R'`, ModRM.rm through `X` in the register-direct form, and
/// EVEX.vvvv through `V'`.
#[test]
fn extended_registers() {
    gas(
        "vpaddd %zmm2,%zmm1,%zmm0",
        &[0x62, 0xF1, 0x75, 0x48, 0xFE, 0xC2],
    );
    gas(
        "vpaddd %zmm18,%zmm17,%zmm16",
        &[0x62, 0xA1, 0x75, 0x40, 0xFE, 0xC2],
    );
    gas(
        "vpaddd %zmm31,%zmm30,%zmm29",
        &[0x62, 0x01, 0x0D, 0x40, 0xFE, 0xEF],
    );
    gas(
        "vpaddd %xmm31,%xmm30,%xmm29",
        &[0x62, 0x01, 0x0D, 0x00, 0xFE, 0xEF],
    );
    gas(
        "vpaddd %ymm31,%ymm30,%ymm29",
        &[0x62, 0x01, 0x0D, 0x20, 0xFE, 0xEF],
    );
    gas(
        "vpxorq %zmm31,%zmm31,%zmm31",
        &[0x62, 0x01, 0x85, 0x40, 0xEF, 0xFF],
    );
    gas(
        "vpternlogq $0x96,%zmm31,%zmm30,%zmm29",
        &[0x62, 0x03, 0x8D, 0x40, 0x25, 0xEF, 0x96],
    );
    gas(
        "vpermi2d %zmm31,%zmm30,%zmm29",
        &[0x62, 0x02, 0x0D, 0x40, 0x76, 0xEF],
    );
    gas(
        "vpermi2d %xmm7,%xmm6,%xmm8",
        &[0x62, 0x72, 0x4D, 0x08, 0x76, 0xC7],
    );
    gas(
        "vmovdqa64 %zmm29,%zmm30",
        &[0x62, 0x01, 0xFD, 0x48, 0x6F, 0xF5],
    );
    gas(
        "vextracti64x4 $1,%zmm16,%ymm17",
        &[0x62, 0xA3, 0xFD, 0x48, 0x3B, 0xC1, 0x01],
    );
    gas(
        "vmovd 4(%rcx),%xmm16",
        &[0x62, 0xE1, 0x7D, 0x08, 0x6E, 0x41, 0x01],
    );
    gas(
        "vmovd %xmm16,4(%rcx)",
        &[0x62, 0xE1, 0x7D, 0x08, 0x7E, 0x41, 0x01],
    );
    gas("vmovd %eax,%xmm16", &[0x62, 0xE1, 0x7D, 0x08, 0x6E, 0xC0]);
    gas("vmovd %xmm16,%eax", &[0x62, 0xE1, 0x7D, 0x08, 0x7E, 0xC0]);
    gas("vmovd %r10d,%xmm16", &[0x62, 0xC1, 0x7D, 0x08, 0x6E, 0xC2]);
    gas(
        "vmovq 8(%rcx),%xmm16",
        &[0x62, 0xE1, 0xFD, 0x08, 0x6E, 0x41, 0x01],
    );
    gas("vmovq %rax,%xmm16", &[0x62, 0xE1, 0xFD, 0x08, 0x6E, 0xC0]);
    gas("vmovq %xmm16,%rax", &[0x62, 0xE1, 0xFD, 0x08, 0x7E, 0xC0]);
    // A vector-register pair takes the F3-prefixed opcode instead.
    gas("vmovq %xmm16,%xmm17", &[0x62, 0xA1, 0xFE, 0x08, 0x7E, 0xC8]);
    gas(
        "vpextrd $2,%xmm16,%eax",
        &[0x62, 0xE3, 0x7D, 0x08, 0x16, 0xC0, 0x02],
    );
    gas(
        "vpinsrd $2,4(%rcx),%xmm16,%xmm17",
        &[0x62, 0xE3, 0x7D, 0x00, 0x22, 0x49, 0x01, 0x02],
    );
    // High general registers in the address: EVEX.B is the base's bit 3 and
    // EVEX.X the index's, exactly as REX carries them.
    gas(
        "vpaddd (%rsi,%r14,8),%zmm1,%zmm0",
        &[0x62, 0xB1, 0x75, 0x48, 0xFE, 0x04, 0xF6],
    );
    gas(
        "vpaddd 64(%r13),%zmm1,%zmm0",
        &[0x62, 0xD1, 0x75, 0x48, 0xFE, 0x45, 0x01],
    );
    gas(
        "vpaddd 64(%r12),%zmm1,%zmm0",
        &[0x62, 0xD1, 0x75, 0x48, 0xFE, 0x44, 0x24, 0x01],
    );
    gas(
        "vpaddd (%r12),%zmm1,%zmm0",
        &[0x62, 0xD1, 0x75, 0x48, 0xFE, 0x04, 0x24],
    );
    gas(
        "vpaddd (%r13),%zmm1,%zmm0",
        &[0x62, 0xD1, 0x75, 0x48, 0xFE, 0x45, 0x00],
    );
    gas(
        "vmovdqu64 %zmm29,64(%r13,%r14,4)",
        &[0x62, 0x01, 0xFE, 0x48, 0x7F, 0x6C, 0xB5, 0x01],
    );
}

/// `{%kN}` write masks and `{z}` zeroing.
#[test]
fn opmask_decorators() {
    gas(
        "vpaddd %zmm2,%zmm1,%zmm0{%k1}",
        &[0x62, 0xF1, 0x75, 0x49, 0xFE, 0xC2],
    );
    gas(
        "vpaddd %zmm2,%zmm1,%zmm0{%k7}",
        &[0x62, 0xF1, 0x75, 0x4F, 0xFE, 0xC2],
    );
    gas(
        "vpaddd %zmm2,%zmm1,%zmm0{%k1}{z}",
        &[0x62, 0xF1, 0x75, 0xC9, 0xFE, 0xC2],
    );
    gas(
        "vpaddd 64(%rsi),%zmm1,%zmm0{%k3}{z}",
        &[0x62, 0xF1, 0x75, 0xCB, 0xFE, 0x46, 0x01],
    );
    // In an extended-asm template `%k<N>` under a single `%` stays GCC's
    // operand modifier -- the 32-bit form of operand N -- not an opmask
    // register; only the file-scope parse reads it as one.
    assert_eq!(
        parse_template(b"shrl %k1, %k0").unwrap()[0].operands,
        [
            AsmOpnd::Ref {
                idx: 1,
                size: Some(AsmRegSize::Long)
            },
            AsmOpnd::Ref {
                idx: 0,
                size: Some(AsmRegSize::Long)
            }
        ]
    );
}

/// Opmask registers as instruction operands: the VEX-encoded `k*` set and
/// the EVEX forms that read or write one. Byte strings are GNU as 2.46.1's
/// and llvm-mc's, which agree on every case.
#[test]
fn opmask_operands() {
    // The 0F-map families: byte and dword forms take 0x66, dword and qword
    // forms VEX.W; the 3-operand forms set VEX.L.
    gas("kandw %k1,%k2,%k3", &[0xC5, 0xEC, 0x41, 0xD9]);
    gas("kandnb %k4,%k5,%k6", &[0xC5, 0xD5, 0x42, 0xF4]);
    gas("kord %k7,%k0,%k1", &[0xC4, 0xE1, 0xFD, 0x45, 0xCF]);
    gas("kxorq %k2,%k3,%k4", &[0xC4, 0xE1, 0xE4, 0x47, 0xE2]);
    gas("kxnorw %k5,%k6,%k7", &[0xC5, 0xCC, 0x46, 0xFD]);
    gas("kaddb %k1,%k2,%k3", &[0xC5, 0xED, 0x4A, 0xD9]);
    gas("kunpckbw %k1,%k2,%k3", &[0xC5, 0xED, 0x4B, 0xD9]);
    gas("kunpckwd %k1,%k2,%k3", &[0xC5, 0xEC, 0x4B, 0xD9]);
    gas("kunpckdq %k1,%k2,%k3", &[0xC4, 0xE1, 0xEC, 0x4B, 0xD9]);
    gas("knotw %k1,%k2", &[0xC5, 0xF8, 0x44, 0xD1]);
    gas("kortestd %k3,%k4", &[0xC4, 0xE1, 0xF9, 0x98, 0xE3]);
    gas("ktestq %k5,%k6", &[0xC4, 0xE1, 0xF8, 0x99, 0xF5]);
    // The shifts pair the widths per opcode on the 0F3A map.
    gas("kshiftlw $3,%k1,%k2", &[0xC4, 0xE3, 0xF9, 0x32, 0xD1, 0x03]);
    gas("kshiftrd $5,%k3,%k4", &[0xC4, 0xE3, 0x79, 0x31, 0xE3, 0x05]);
    // `kmov`: 90/91 against opmask / memory, 92/93 against a general
    // register, whose prefix pair differs (F2 for the d/q members).
    gas("kmovw %k1,%k2", &[0xC5, 0xF8, 0x90, 0xD1]);
    gas("kmovb (%rax),%k2", &[0xC5, 0xF9, 0x90, 0x10]);
    gas("kmovq 8(%rsi),%k3", &[0xC4, 0xE1, 0xF8, 0x90, 0x5E, 0x08]);
    gas("kmovd %k2,(%rax)", &[0xC4, 0xE1, 0xF9, 0x91, 0x10]);
    gas("kmovw %eax,%k2", &[0xC5, 0xF8, 0x92, 0xD0]);
    gas("kmovd %eax,%k2", &[0xC5, 0xFB, 0x92, 0xD0]);
    gas("kmovq %k2,%rax", &[0xC4, 0xE1, 0xFB, 0x93, 0xC2]);
    gas("kmovw %k2,%r9d", &[0xC5, 0x78, 0x93, 0xCA]);
    gas("kmovb (%r8),%k2", &[0xC4, 0xC1, 0x79, 0x90, 0x10]);
    // EVEX compares and tests write an opmask; the mask <-> vector moves
    // read or write one in a register-only form.
    gas(
        "vpcmpeqb %zmm1,%zmm2,%k3",
        &[0x62, 0xF1, 0x6D, 0x48, 0x74, 0xD9],
    );
    gas(
        "vpcmpeqd %zmm1,%zmm2,%k3",
        &[0x62, 0xF1, 0x6D, 0x48, 0x76, 0xD9],
    );
    gas(
        "vpcmpeqq %zmm1,%zmm2,%k3",
        &[0x62, 0xF2, 0xED, 0x48, 0x29, 0xD9],
    );
    gas(
        "vpcmpgtw %zmm1,%zmm2,%k3",
        &[0x62, 0xF1, 0x6D, 0x48, 0x65, 0xD9],
    );
    gas(
        "vpcmpd $2,%zmm1,%zmm2,%k3",
        &[0x62, 0xF3, 0x6D, 0x48, 0x1F, 0xD9, 0x02],
    );
    gas(
        "vpcmpuw $2,%zmm1,%zmm2,%k3",
        &[0x62, 0xF3, 0xED, 0x48, 0x3E, 0xD9, 0x02],
    );
    gas(
        "vptestmd %zmm1,%zmm2,%k3",
        &[0x62, 0xF2, 0x6D, 0x48, 0x27, 0xD9],
    );
    gas(
        "vptestnmb %zmm1,%zmm2,%k3",
        &[0x62, 0xF2, 0x6E, 0x48, 0x26, 0xD9],
    );
    gas("vpmovm2d %k1,%zmm2", &[0x62, 0xF2, 0x7E, 0x48, 0x38, 0xD1]);
    gas("vpmovq2m %zmm19,%k7", &[0x62, 0xB2, 0xFE, 0x48, 0x39, 0xFB]);
    gas(
        "vcmpps $1,%zmm1,%zmm2,%k3",
        &[0x62, 0xF1, 0x6C, 0x48, 0xC2, 0xD9, 0x01],
    );
    gas(
        "vcmpsd $3,8(%rax),%xmm2,%k3",
        &[0x62, 0xF1, 0xEF, 0x08, 0xC2, 0x58, 0x01, 0x03],
    );
    // Compressed displacement, embedded broadcast, and a write mask on the
    // opmask destination.
    gas(
        "vpcmpeqd 64(%rax),%zmm2,%k3",
        &[0x62, 0xF1, 0x6D, 0x48, 0x76, 0x58, 0x01],
    );
    gas(
        "vpcmpeqd (%rax){1to16},%zmm2,%k3",
        &[0x62, 0xF1, 0x6D, 0x58, 0x76, 0x18],
    );
    gas(
        "vpcmpeqd %zmm1,%zmm2,%k3{%k4}",
        &[0x62, 0xF1, 0x6D, 0x4C, 0x76, 0xD9],
    );
    gas(
        "vpcmpeqq %zmm26,%zmm22,%k5",
        &[0x62, 0x92, 0xCD, 0x40, 0x29, 0xEA],
    );
    gas(
        "vpcmpgtq (%r9){1to8},%zmm30,%k2{%k1}",
        &[0x62, 0xD2, 0x8D, 0x51, 0x37, 0x11],
    );
}

/// The packed moves, in both directions.
#[test]
fn packed_moves() {
    gas(
        "vmovdqu8 %zmm1,%zmm2",
        &[0x62, 0xF1, 0x7F, 0x48, 0x6F, 0xD1],
    );
    gas(
        "vmovdqu8 %zmm1,64(%rsi)",
        &[0x62, 0xF1, 0x7F, 0x48, 0x7F, 0x4E, 0x01],
    );
    gas(
        "vmovdqu64 %zmm0,%zmm1",
        &[0x62, 0xF1, 0xFE, 0x48, 0x6F, 0xC8],
    );
    gas(
        "vmovdqu32 %zmm0,%zmm1",
        &[0x62, 0xF1, 0x7E, 0x48, 0x6F, 0xC8],
    );
    gas(
        "vmovdqu16 %zmm0,%zmm1",
        &[0x62, 0xF1, 0xFF, 0x48, 0x6F, 0xC8],
    );
    gas(
        "vmovdqa32 %zmm0,%zmm1",
        &[0x62, 0xF1, 0x7D, 0x48, 0x6F, 0xC8],
    );
    gas(
        "vmovdqu8 %zmm1,(%rsi)",
        &[0x62, 0xF1, 0x7F, 0x48, 0x7F, 0x0E],
    );
    gas(
        "vmovaps 64(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7C, 0x48, 0x28, 0x4E, 0x01],
    );
    gas(
        "vmovaps %zmm1,64(%rsi)",
        &[0x62, 0xF1, 0x7C, 0x48, 0x29, 0x4E, 0x01],
    );
    gas(
        "vmovups 64(%rsi),%zmm1",
        &[0x62, 0xF1, 0x7C, 0x48, 0x10, 0x4E, 0x01],
    );
    gas(
        "vmovupd 64(%rsi),%zmm1",
        &[0x62, 0xF1, 0xFD, 0x48, 0x10, 0x4E, 0x01],
    );
    gas(
        "vmovapd 64(%rsi),%zmm1",
        &[0x62, 0xF1, 0xFD, 0x48, 0x28, 0x4E, 0x01],
    );
    gas(
        "vpshufb %zmm2,%zmm1,%zmm0",
        &[0x62, 0xF2, 0x75, 0x48, 0x00, 0xC2],
    );
    gas(
        "vpshufb 64(%rsi),%zmm1,%zmm0",
        &[0x62, 0xF2, 0x75, 0x48, 0x00, 0x46, 0x01],
    );
    gas(
        "vpclmulqdq $0,64(%rsi),%zmm1,%zmm0",
        &[0x62, 0xF3, 0x75, 0x48, 0x44, 0x46, 0x01, 0x00],
    );
}

/// Shifts and rotates by immediate: the destination rides EVEX.vvvv and the
/// opcode extension ModRM.reg. `vprord` is what the AVX-512 BLAKE2s round uses.
#[test]
fn shift_rotate_by_immediate() {
    gas(
        "vprord $16,%xmm3,%xmm3",
        &[0x62, 0xF1, 0x65, 0x08, 0x72, 0xC3, 0x10],
    );
    gas(
        "vprord $16,%zmm3,%zmm4",
        &[0x62, 0xF1, 0x5D, 0x48, 0x72, 0xC3, 0x10],
    );
    gas(
        "vprord $16,%zmm31,%zmm30",
        &[0x62, 0x91, 0x0D, 0x40, 0x72, 0xC7, 0x10],
    );
    gas(
        "vprold $16,%zmm3,%zmm4",
        &[0x62, 0xF1, 0x5D, 0x48, 0x72, 0xCB, 0x10],
    );
    gas(
        "vprorq $16,%zmm3,%zmm4",
        &[0x62, 0xF1, 0xDD, 0x48, 0x72, 0xC3, 0x10],
    );
    gas(
        "vprolq $16,%zmm3,%zmm4",
        &[0x62, 0xF1, 0xDD, 0x48, 0x72, 0xCB, 0x10],
    );
    gas(
        "vprord $16,64(%rcx),%zmm4",
        &[0x62, 0xF1, 0x5D, 0x48, 0x72, 0x41, 0x01, 0x10],
    );
    gas(
        "vprord $16,4(%rcx){1to16},%zmm4",
        &[0x62, 0xF1, 0x5D, 0x58, 0x72, 0x41, 0x01, 0x10],
    );
    // The packed shifts by immediate keep their VEX encoding between
    // registers; only the memory-source form AVX-512 added needs EVEX.
    gas("vpslld $3,%xmm3,%xmm4", &[0xC5, 0xD9, 0x72, 0xF3, 0x03]);
    gas("vpslld $3,%ymm3,%ymm4", &[0xC5, 0xDD, 0x72, 0xF3, 0x03]);
    gas(
        "vpslld $3,%zmm3,%zmm4",
        &[0x62, 0xF1, 0x5D, 0x48, 0x72, 0xF3, 0x03],
    );
    gas(
        "vpslld $3,64(%rcx),%zmm4",
        &[0x62, 0xF1, 0x5D, 0x48, 0x72, 0x71, 0x01, 0x03],
    );
    gas(
        "vpslld $3,4(%rcx){1to16},%zmm4",
        &[0x62, 0xF1, 0x5D, 0x58, 0x72, 0x71, 0x01, 0x03],
    );
    gas(
        "vpsllq $3,%zmm3,%zmm4",
        &[0x62, 0xF1, 0xDD, 0x48, 0x73, 0xF3, 0x03],
    );
    gas(
        "vpsraq $3,%zmm3,%zmm4",
        &[0x62, 0xF1, 0xDD, 0x48, 0x72, 0xE3, 0x03],
    );
    // 16-bit elements and the byte-lane shifts have no broadcast form, so
    // their memory operand is a whole vector.
    gas(
        "vpsllw $3,64(%rcx),%zmm4",
        &[0x62, 0xF1, 0x5D, 0x48, 0x71, 0x71, 0x01, 0x03],
    );
    gas(
        "vpslldq $3,64(%rcx),%zmm4",
        &[0x62, 0xF1, 0x5D, 0x48, 0x73, 0x79, 0x01, 0x03],
    );
}

/// Between two registers a VEX move encodes the same transfer either way
/// round, and GNU as picks the direction that fits the 2-byte prefix.
#[test]
fn vex_move_direction() {
    gas("vmovdqa %xmm14,%xmm2", &[0xC5, 0x79, 0x7F, 0xF2]);
    gas("vmovdqa %xmm2,%xmm14", &[0xC5, 0x79, 0x6F, 0xF2]);
    gas("vmovdqa %xmm14,%xmm15", &[0xC4, 0x41, 0x79, 0x6F, 0xFE]);
    gas("vmovdqa %xmm2,%xmm3", &[0xC5, 0xF9, 0x6F, 0xDA]);
    gas("vmovdqu %ymm8,%ymm6", &[0xC5, 0x7E, 0x7F, 0xC6]);
    gas("vmovdqu %ymm6,%ymm8", &[0xC5, 0x7E, 0x6F, 0xC6]);
    gas("vmovdqu %ymm8,%ymm9", &[0xC4, 0x41, 0x7E, 0x6F, 0xC8]);
    gas("vmovaps %xmm14,%xmm2", &[0xC5, 0x78, 0x29, 0xF2]);
    gas("vmovups %ymm14,%ymm2", &[0xC5, 0x7C, 0x11, 0xF2]);
    gas("vmovapd %xmm14,%xmm2", &[0xC5, 0x79, 0x29, 0xF2]);
    gas("vmovupd %xmm14,%xmm2", &[0xC5, 0x79, 0x11, 0xF2]);
    // EVEX is four bytes either way, so it keeps the register direction.
    gas(
        "vmovdqu8 %zmm18,%zmm2",
        &[0x62, 0xB1, 0x7F, 0x48, 0x6F, 0xD2],
    );
    gas(
        "vmovdqu8 %zmm2,%zmm18",
        &[0x62, 0xE1, 0x7F, 0x48, 0x6F, 0xD2],
    );
    gas(
        "vmovaps %zmm18,%zmm2",
        &[0x62, 0xB1, 0x7C, 0x48, 0x28, 0xD2],
    );
    // A general-register transfer takes its width from the register, whichever
    // of the two spellings names it.
    gas("vmovd %rcx,%xmm0", &[0xC4, 0xE1, 0xF9, 0x6E, 0xC1]);
    gas("vmovd %ecx,%xmm0", &[0xC5, 0xF9, 0x6E, 0xC1]);
    gas("vmovd %xmm0,%rcx", &[0xC4, 0xE1, 0xF9, 0x7E, 0xC1]);
    gas("vmovq %rcx,%xmm0", &[0xC4, 0xE1, 0xF9, 0x6E, 0xC1]);
}

/// The non-temporal moves have one direction each: the stores take a memory
/// destination only, `vmovntdqa` a memory source only.
#[test]
fn non_temporal_moves() {
    gas("vmovntdq %ymm4,(%rdi)", &[0xC5, 0xFD, 0xE7, 0x27]);
    gas(
        "vmovntdq %ymm12,64(%rdi,%rcx,2)",
        &[0xC5, 0x7D, 0xE7, 0x64, 0x4F, 0x40],
    );
    gas(
        "vmovntdq %ymm2,-32(%r13)",
        &[0xC4, 0xC1, 0x7D, 0xE7, 0x55, 0xE0],
    );
    gas("vmovntdq %xmm3,16(%rsi)", &[0xC5, 0xF9, 0xE7, 0x5E, 0x10]);
    gas("vmovntps %ymm1,(%rax)", &[0xC5, 0xFC, 0x2B, 0x08]);
    gas("vmovntpd %ymm1,(%rax)", &[0xC5, 0xFD, 0x2B, 0x08]);
    gas(
        "vmovntdq %zmm4,(%rdi)",
        &[0x62, 0xF1, 0x7D, 0x48, 0xE7, 0x27],
    );
    gas(
        "vmovntdq %zmm12,64(%rdi,%rcx,2)",
        &[0x62, 0x71, 0x7D, 0x48, 0xE7, 0x64, 0x4F, 0x01],
    );
    gas(
        "vmovntdq %zmm12,-64(%r13)",
        &[0x62, 0x51, 0x7D, 0x48, 0xE7, 0x65, 0xFF],
    );
    // The disp8 scale is the full vector: 128 compresses, 129 does not.
    gas(
        "vmovntdq %zmm2,128(%rsi)",
        &[0x62, 0xF1, 0x7D, 0x48, 0xE7, 0x56, 0x02],
    );
    gas(
        "vmovntdq %zmm2,129(%rsi)",
        &[0x62, 0xF1, 0x7D, 0x48, 0xE7, 0x96, 0x81, 0x00, 0x00, 0x00],
    );
    gas(
        "vmovntdq %zmm31,(%r14,%r15,8)",
        &[0x62, 0x01, 0x7D, 0x48, 0xE7, 0x3C, 0xFE],
    );
    gas(
        "vmovntdq %ymm17,(%rax)",
        &[0x62, 0xE1, 0x7D, 0x28, 0xE7, 0x08],
    );
    gas(
        "vmovntdq %xmm20,(%rax)",
        &[0x62, 0xE1, 0x7D, 0x08, 0xE7, 0x20],
    );
    gas(
        "vmovntps %zmm1,64(%rax)",
        &[0x62, 0xF1, 0x7C, 0x48, 0x2B, 0x48, 0x01],
    );
    gas(
        "vmovntpd %zmm1,64(%rax)",
        &[0x62, 0xF1, 0xFD, 0x48, 0x2B, 0x48, 0x01],
    );
    gas(
        "vmovntdqa 64(%rax),%zmm1",
        &[0x62, 0xF2, 0x7D, 0x48, 0x2A, 0x48, 0x01],
    );
    gas(
        "vmovntdqa (%rax),%ymm17",
        &[0x62, 0xE2, 0x7D, 0x28, 0x2A, 0x08],
    );
    refused("vmovntdq %ymm1,%ymm2", "memory destination");
    refused("vmovntdq (%rax),%ymm1", "memory destination");
    refused("vmovntdq %zmm1,%zmm2", "memory destination");
    refused("vmovntdq (%rax),%zmm1", "memory destination");
    refused("vmovntdqa %ymm1,%ymm2", "memory source");
    refused("vmovntdqa %zmm1,%zmm2", "memory source");
}

/// GNU as reads register names without regard to case; the kernel's AVX-512
/// RAID-6 syndrome spells `%Zmm14`.
#[test]
fn register_names_fold_case() {
    gas(
        "vpaddb %Zmm14,%zmm14,%zmm14",
        &[0x62, 0x51, 0x0D, 0x48, 0xFC, 0xF6],
    );
    gas("vpxor %YMM5,%ymm4,%ymm4", &[0xC5, 0xDD, 0xEF, 0xE5]);
    gas(
        "vpcmpgtb %zmm4,%zmm5,%K1",
        &[0x62, 0xF1, 0x55, 0x48, 0x64, 0xCC],
    );
    gas("vmovdqa (%RDI),%ymm0", &[0xC5, 0xFD, 0x6F, 0x07]);
}

/// Every mnemonic and operand form the RAID-6 units spell (`lib/raid6/avx2.c`,
/// `avx512.c`, `recov_avx2.c`, `recov_avx512.c`), at both vector lengths.
#[test]
fn raid6_units() {
    gas(
        "vmovdqa64 (%rdi),%zmm0",
        &[0x62, 0xF1, 0xFD, 0x48, 0x6F, 0x07],
    );
    gas(
        "vmovdqa64 %zmm2,%zmm4",
        &[0x62, 0xF1, 0xFD, 0x48, 0x6F, 0xE2],
    );
    gas(
        "vmovdqa64 %zmm4,64(%rdi)",
        &[0x62, 0xF1, 0xFD, 0x48, 0x7F, 0x67, 0x01],
    );
    gas("vmovdqa (%rdi),%ymm0", &[0xC5, 0xFD, 0x6F, 0x07]);
    gas("vmovdqa %ymm2,%ymm4", &[0xC5, 0xFD, 0x6F, 0xE2]);
    gas("vmovdqa %ymm4,32(%rdi)", &[0xC5, 0xFD, 0x7F, 0x67, 0x20]);
    gas(
        "vpxorq %zmm5,%zmm4,%zmm4",
        &[0x62, 0xF1, 0xDD, 0x48, 0xEF, 0xE5],
    );
    gas(
        "vpxorq 64(%rdi),%zmm4,%zmm4",
        &[0x62, 0xF1, 0xDD, 0x48, 0xEF, 0x67, 0x01],
    );
    gas("vpxor %ymm5,%ymm4,%ymm4", &[0xC5, 0xDD, 0xEF, 0xE5]);
    gas(
        "vpxor 32(%rdi),%ymm4,%ymm4",
        &[0xC5, 0xDD, 0xEF, 0x67, 0x20],
    );
    gas(
        "vpandq %zmm0,%zmm5,%zmm5",
        &[0x62, 0xF1, 0xD5, 0x48, 0xDB, 0xE8],
    );
    gas("vpand %ymm0,%ymm5,%ymm5", &[0xC5, 0xD5, 0xDB, 0xE8]);
    gas(
        "vpaddb %zmm4,%zmm4,%zmm4",
        &[0x62, 0xF1, 0x5D, 0x48, 0xFC, 0xE4],
    );
    gas("vpaddb %ymm4,%ymm4,%ymm4", &[0xC5, 0xDD, 0xFC, 0xE4]);
    gas(
        "vpcmpgtb %zmm4,%zmm5,%k1",
        &[0x62, 0xF1, 0x55, 0x48, 0x64, 0xCC],
    );
    gas(
        "vpcmpgtb %zmm14,%zmm15,%k4",
        &[0x62, 0xD1, 0x05, 0x48, 0x64, 0xE6],
    );
    gas("vpcmpgtb %ymm4,%ymm5,%ymm5", &[0xC5, 0xD5, 0x64, 0xEC]);
    gas("vpmovm2b %k1,%zmm5", &[0x62, 0xF2, 0x7E, 0x48, 0x28, 0xE9]);
    gas("vpmovm2b %k4,%zmm15", &[0x62, 0x72, 0x7E, 0x48, 0x28, 0xFC]);
    gas(
        "vpsraw $4,%zmm3,%zmm6",
        &[0x62, 0xF1, 0x4D, 0x48, 0x71, 0xE3, 0x04],
    );
    gas("vpsraw $4,%ymm3,%ymm6", &[0xC5, 0xCD, 0x71, 0xE3, 0x04]);
    gas(
        "vpshufb %zmm6,%zmm1,%zmm1",
        &[0x62, 0xF2, 0x75, 0x48, 0x00, 0xCE],
    );
    gas("vpshufb %ymm6,%ymm1,%ymm1", &[0xC4, 0xE2, 0x75, 0x00, 0xCE]);
    gas(
        "vpbroadcastb (%rax),%zmm7",
        &[0x62, 0xF2, 0x7D, 0x48, 0x78, 0x38],
    );
    gas("vpbroadcastb (%rax),%ymm7", &[0xC4, 0xE2, 0x7D, 0x78, 0x38]);
    gas(
        "vbroadcasti64x2 (%rax),%zmm1",
        &[0x62, 0xF2, 0xFD, 0x48, 0x5A, 0x08],
    );
    gas(
        "vbroadcasti128 (%rax),%ymm1",
        &[0xC4, 0xE2, 0x7D, 0x5A, 0x08],
    );
    gas(
        "vmovapd %zmm1,%zmm14",
        &[0x62, 0x71, 0xFD, 0x48, 0x28, 0xF1],
    );
    gas("vmovapd %ymm1,%ymm14", &[0xC5, 0x7D, 0x28, 0xF1]);
    gas("prefetchnta 64(%rdi)", &[0x0F, 0x18, 0x47, 0x40]);
    gas("prefetchnta (%rdi,%rcx,1)", &[0x0F, 0x18, 0x04, 0x0F]);
}

/// The VEX compares with a vector destination, which the EVEX rows (an
/// opmask destination) do not reach.
#[test]
fn vex_vector_compares() {
    gas(
        "vpcmpgtq %xmm1,%xmm2,%xmm0",
        &[0xC4, 0xE2, 0x69, 0x37, 0xC1],
    );
    gas(
        "vpcmpgtq (%rax),%ymm2,%ymm0",
        &[0xC4, 0xE2, 0x6D, 0x37, 0x00],
    );
    gas(
        "vcmpps $1,%ymm1,%ymm2,%ymm0",
        &[0xC5, 0xEC, 0xC2, 0xC1, 0x01],
    );
    gas(
        "vcmppd $1,%xmm1,%xmm2,%xmm0",
        &[0xC5, 0xE9, 0xC2, 0xC1, 0x01],
    );
    gas(
        "vcmpss $1,(%rax),%xmm2,%xmm0",
        &[0xC5, 0xEA, 0xC2, 0x00, 0x01],
    );
    gas(
        "vcmpsd $1,%xmm1,%xmm2,%xmm0",
        &[0xC5, 0xEB, 0xC2, 0xC1, 0x01],
    );
    gas(
        "vcmpps $2,%zmm1,%zmm2,%k1",
        &[0x62, 0xF1, 0x6C, 0x48, 0xC2, 0xC9, 0x02],
    );
}

/// The EVEX element insert / extract forms, reached when the vector operand is
/// one only EVEX names.
#[test]
fn evex_element_insert_extract() {
    gas(
        "vpextrb $7,%xmm16,%eax",
        &[0x62, 0xE3, 0x7D, 0x08, 0x14, 0xC0, 0x07],
    );
    gas(
        "vpextrb $7,%xmm16,1(%rcx)",
        &[0x62, 0xE3, 0x7D, 0x08, 0x14, 0x41, 0x01, 0x07],
    );
    gas(
        "vpextrd $1,%xmm16,(%rcx)",
        &[0x62, 0xE3, 0x7D, 0x08, 0x16, 0x01, 0x01],
    );
    gas(
        "vpextrq $1,%xmm16,%rax",
        &[0x62, 0xE3, 0xFD, 0x08, 0x16, 0xC0, 0x01],
    );
    gas(
        "vpextrq $1,%xmm16,8(%rcx)",
        &[0x62, 0xE3, 0xFD, 0x08, 0x16, 0x41, 0x01, 0x01],
    );
    gas(
        "vextractps $1,%xmm16,4(%rcx)",
        &[0x62, 0xE3, 0x7D, 0x08, 0x17, 0x41, 0x01, 0x01],
    );
    gas(
        "vpinsrb $7,%eax,%xmm16,%xmm17",
        &[0x62, 0xE3, 0x7D, 0x00, 0x20, 0xC8, 0x07],
    );
    gas(
        "vpinsrw $3,2(%rcx),%xmm16,%xmm17",
        &[0x62, 0xE1, 0x7D, 0x00, 0xC4, 0x49, 0x01, 0x03],
    );
    gas(
        "vpinsrq $1,8(%rcx),%xmm16,%xmm17",
        &[0x62, 0xE3, 0xFD, 0x00, 0x22, 0x49, 0x01, 0x01],
    );
}

/// The VEX element insert / extract family, which the AVX-512 CRC template
/// reaches through `vpextrd`.
#[test]
fn vex_element_insert_extract() {
    gas(
        "vpextrb $7,%xmm0,%eax",
        &[0xC4, 0xE3, 0x79, 0x14, 0xC0, 0x07],
    );
    gas(
        "vpextrb $7,%xmm0,(%rcx)",
        &[0xC4, 0xE3, 0x79, 0x14, 0x01, 0x07],
    );
    // The word extract's register form is the shorter 0F-map opcode, with the
    // roles of ModRM.reg and r/m swapped.
    gas("vpextrw $3,%xmm0,%eax", &[0xC5, 0xF9, 0xC5, 0xC0, 0x03]);
    gas(
        "vpextrw $3,%xmm0,(%rcx)",
        &[0xC4, 0xE3, 0x79, 0x15, 0x01, 0x03],
    );
    gas(
        "vpextrd $1,%xmm0,(%rcx)",
        &[0xC4, 0xE3, 0x79, 0x16, 0x01, 0x01],
    );
    gas(
        "vpextrq $1,%xmm0,%rax",
        &[0xC4, 0xE3, 0xF9, 0x16, 0xC0, 0x01],
    );
    gas(
        "vpextrq $1,%xmm0,(%rcx)",
        &[0xC4, 0xE3, 0xF9, 0x16, 0x01, 0x01],
    );
    gas(
        "vpextrd $1,%xmm9,%r10d",
        &[0xC4, 0x43, 0x79, 0x16, 0xCA, 0x01],
    );
    gas(
        "vextractps $1,%xmm0,%eax",
        &[0xC4, 0xE3, 0x79, 0x17, 0xC0, 0x01],
    );
    gas(
        "vpinsrb $7,%eax,%xmm1,%xmm0",
        &[0xC4, 0xE3, 0x71, 0x20, 0xC0, 0x07],
    );
    gas(
        "vpinsrw $3,%eax,%xmm1,%xmm0",
        &[0xC5, 0xF1, 0xC4, 0xC0, 0x03],
    );
    gas(
        "vpinsrd $1,%eax,%xmm1,%xmm0",
        &[0xC4, 0xE3, 0x71, 0x22, 0xC0, 0x01],
    );
    gas(
        "vpinsrq $1,%rax,%xmm1,%xmm0",
        &[0xC4, 0xE3, 0xF1, 0x22, 0xC0, 0x01],
    );
    gas(
        "vpinsrd $1,(%rcx),%xmm1,%xmm0",
        &[0xC4, 0xE3, 0x71, 0x22, 0x01, 0x01],
    );
}

/// What this encoder does not implement is refused, not guessed.
#[test]
fn refusals() {
    // A name with no EVEX form cannot take an EVEX-only register.
    refused("vpxor %zmm2,%zmm1,%zmm0", "no EVEX");
    refused("vmovdqu (%rsi),%zmm1", "no EVEX");
    refused("vperm2i128 $1,%ymm18,%ymm1,%ymm0", "no EVEX");
    // Rounding and SAE controls.
    refused("vaddps {rn-sae},%zmm2,%zmm1,%zmm0", "rounding / SAE");
    refused("vmaxps {sae},%zmm2,%zmm1,%zmm0", "rounding / SAE");
    // Decorators that do not apply.
    refused("vpaddd %zmm2,%zmm1,%zmm0{%k0}", "not a write mask");
    refused("vpaddd %zmm2,%zmm1,%zmm0{z}", "needs a `{%k1}`");
    refused(
        "vpshufb 64(%rsi){1to16},%zmm1,%zmm0",
        "no `{1toN}` broadcast",
    );
    refused("vpaddd 4(%rsi){1to8},%zmm1,%zmm0", "does not match");
    refused("vpaddd %zmm2,%zmm1,%zmm0{%k9}", "no mask register");
    // Gather / scatter addressing: a vector index never reaches the encoder,
    // the address parse having refused it.
    refused("vpaddd (%rsi,%zmm2,8),%zmm1,%zmm0", "unsupported operand");
    refused("vpaddd (%rsi,%xmm2,8),%zmm1,%zmm0", "unsupported operand");
    // A sub-vector broadcast reads memory only, as GNU as also requires.
    refused("vbroadcasti32x4 %xmm1,%zmm0", "memory source");
    // `vmovd` has no vector-register pair form.
    refused("vmovd %xmm16,%xmm17", "general register or memory");
    // `vpextrw`'s register-destination form puts the general register in
    // ModRM.reg, inverting the shape; it is left out of the EVEX table rather
    // than encoded as the memory form, which writes 16 bits.
    refused("vpextrw $3,%xmm16,%eax", "no EVEX");
    // Opmask operand class mismatches.
    refused("vpcmpeqd %zmm1,%zmm2,%zmm3", "writes an opmask register");
    refused("vpmovm2d (%rax),%zmm1", "reads an opmask register");
    refused("vpmovd2m (%rax),%k1", "vector register source");
    refused("vpaddd %k1,%zmm1,%zmm0", "vector register or memory");
    refused("vpcmpeqd %zmm1,%zmm2,%k3{%k4}{z}", "opmask destination");
    refused("kmovq %eax,%k1", "64-bit general register");
    refused("kandw %k1,%k2,%eax", "opmask instruction takes");
    // GFNI: the field multiply reads bytes and has no broadcast form; the
    // affine transforms read qwords, so the element count must match the
    // vector length. The legacy-SSE names have no EVEX row at all.
    refused(
        "vgf2p8mulb (%rax){1to8},%zmm1,%zmm0",
        "no `{1toN}` broadcast",
    );
    refused(
        "vgf2p8affineqb $1,(%rax){1to4},%xmm2,%xmm3",
        "does not match the operand",
    );
    refused("gf2p8affineqb $1,%zmm1,%zmm0", "no EVEX");
    refused("gf2p8mulb %ymm1,%ymm0", "must be an XMM register");
    refused(
        "vgf2p8affineqb %xmm1,%xmm2,%xmm3",
        "needs $imm, %src2, %src1, %dst",
    );
    refused(
        "vgf2p8mulb $1,%xmm1,%xmm2,%xmm3",
        "VEX op needs %src2, %src1, %dst",
    );
}

/// The tuple table is the SDM's, restated as a function; these are the factors
/// the byte-parity cases above exercise.
#[test]
fn tuple_scale_factors() {
    use super::Tuple::*;
    let n = |t: super::Tuple, vl, w, b| t.disp8_n(vl, w, b);
    assert_eq!(
        [n(Full, 16, false, false), n(Full, 32, false, false)],
        [16, 32]
    );
    assert_eq!([n(Full, 64, false, true), n(Full, 64, true, true)], [4, 8]);
    assert_eq!(
        [n(Half, 64, false, false), n(Half, 64, false, true)],
        [32, 4]
    );
    assert_eq!(n(FullMem, 64, true, false), 64);
    assert_eq!(
        [n(Group(2), 64, false, false), n(Group(2), 64, true, false)],
        [8, 16]
    );
    assert_eq!(
        [n(Group(4), 64, false, false), n(Group(4), 64, true, false)],
        [16, 32]
    );
    assert_eq!(n(Group(8), 64, false, false), 32);
    assert_eq!(
        [
            n(HalfMem, 64, false, false),
            n(QuarterMem, 64, false, false),
            n(EighthMem, 64, false, false)
        ],
        [32, 16, 8]
    );
    assert_eq!(
        [n(ElemW, 64, false, false), n(ElemW, 64, true, false)],
        [4, 8]
    );
    assert_eq!(
        [n(Elem(1), 64, false, false), n(Elem(2), 64, false, false)],
        [1, 2]
    );
    assert_eq!([n(Dup, 16, true, false), n(Dup, 64, true, false)], [8, 64]);
}

/// The lane-crossing quadword permutes. Each name has two members: an
/// immediate-controlled one on the 0F3A map and an index-vector-controlled one
/// on 0F38, told apart by the leading operand. Neither has a 128-bit form.
#[test]
fn lane_permutes() {
    gas(
        "vpermq $0x2,%ymm3,%ymm20",
        &[0x62, 0xE3, 0xFD, 0x28, 0x00, 0xE3, 0x02],
    );
    gas(
        "vpermq $0x2,%ymm19,%ymm3",
        &[0x62, 0xB3, 0xFD, 0x28, 0x00, 0xDB, 0x02],
    );
    gas(
        "vpermq $0x2,%zmm3,%zmm14{%k1}",
        &[0x62, 0x73, 0xFD, 0x49, 0x00, 0xF3, 0x02],
    );
    gas(
        "vpermq $0x2,%zmm3,%zmm14{%k2}{z}",
        &[0x62, 0x73, 0xFD, 0xCA, 0x00, 0xF3, 0x02],
    );
    // Tuple Full: disp8 scales by 64 without a broadcast and by 8 with one.
    gas(
        "vpermq $0x2,(%rax),%zmm1",
        &[0x62, 0xF3, 0xFD, 0x48, 0x00, 0x08, 0x02],
    );
    gas(
        "vpermq $0x2,0x40(%rax),%zmm1",
        &[0x62, 0xF3, 0xFD, 0x48, 0x00, 0x48, 0x01, 0x02],
    );
    gas(
        "vpermq $0x2,-0x40(%rax),%zmm1",
        &[0x62, 0xF3, 0xFD, 0x48, 0x00, 0x48, 0xFF, 0x02],
    );
    gas(
        "vpermq $0x2,(%rax){1to8},%zmm1",
        &[0x62, 0xF3, 0xFD, 0x58, 0x00, 0x08, 0x02],
    );
    gas(
        "vpermq $0x2,0x40(%rax){1to8},%zmm1",
        &[0x62, 0xF3, 0xFD, 0x58, 0x00, 0x48, 0x08, 0x02],
    );
    gas(
        "vpermpd $0x1b,%zmm2,%zmm3",
        &[0x62, 0xF3, 0xFD, 0x48, 0x01, 0xDA, 0x1B],
    );
    gas(
        "vpermpd $0x1b,%ymm2,%ymm19",
        &[0x62, 0xE3, 0xFD, 0x28, 0x01, 0xDA, 0x1B],
    );
    // The index-vector-controlled member. It has no VEX form at any length,
    // so it reaches EVEX on low registers too.
    gas(
        "vpermq %zmm2,%zmm1,%zmm0",
        &[0x62, 0xF2, 0xF5, 0x48, 0x36, 0xC2],
    );
    gas(
        "vpermq %ymm2,%ymm1,%ymm0",
        &[0x62, 0xF2, 0xF5, 0x28, 0x36, 0xC2],
    );
    gas(
        "vpermq %zmm18,%zmm17,%zmm16",
        &[0x62, 0xA2, 0xF5, 0x40, 0x36, 0xC2],
    );
    gas(
        "vpermq (%rax),%zmm1,%zmm0",
        &[0x62, 0xF2, 0xF5, 0x48, 0x36, 0x00],
    );
    gas(
        "vpermq (%rax){1to8},%zmm1,%zmm0",
        &[0x62, 0xF2, 0xF5, 0x58, 0x36, 0x00],
    );
    gas(
        "vpermq 0x40(%rax),%zmm1,%zmm0",
        &[0x62, 0xF2, 0xF5, 0x48, 0x36, 0x40, 0x01],
    );
    gas(
        "vpermq %zmm2,%zmm1,%zmm0{%k7}",
        &[0x62, 0xF2, 0xF5, 0x4F, 0x36, 0xC2],
    );
    gas(
        "vpermpd %zmm2,%zmm1,%zmm0",
        &[0x62, 0xF2, 0xF5, 0x48, 0x16, 0xC2],
    );
    gas(
        "vpermpd %ymm2,%ymm1,%ymm16",
        &[0x62, 0xE2, 0xF5, 0x28, 0x16, 0xC2],
    );
    // GNU as refuses every 128-bit spelling of both members.
    refused("vpermq $0x2,%xmm19,%xmm3", "no 128-bit form");
    refused("vpermpd $0x1b,%xmm2,%xmm19", "no 128-bit form");
    refused("vpermq %xmm2,%xmm1,%xmm0", "no 128-bit form");
    refused("vpermpd %xmm18,%xmm17,%xmm16", "no 128-bit form");
}

/// The element broadcasts read a general register under a second opcode, whose
/// width EVEX.W fixes: `vpbroadcastq` takes a 64-bit register and the narrower
/// three a 32-bit one, as GNU as accepts them.
#[test]
fn broadcast_from_general_register() {
    gas(
        "vpbroadcastq %rax,%zmm0",
        &[0x62, 0xF2, 0xFD, 0x48, 0x7C, 0xC0],
    );
    gas(
        "vpbroadcastq %rax,%ymm0",
        &[0x62, 0xF2, 0xFD, 0x28, 0x7C, 0xC0],
    );
    gas(
        "vpbroadcastq %rax,%xmm0",
        &[0x62, 0xF2, 0xFD, 0x08, 0x7C, 0xC0],
    );
    gas(
        "vpbroadcastq %r15,%zmm31",
        &[0x62, 0x42, 0xFD, 0x48, 0x7C, 0xFF],
    );
    gas(
        "vpbroadcastq %rax,%zmm1{%k3}",
        &[0x62, 0xF2, 0xFD, 0x4B, 0x7C, 0xC8],
    );
    gas(
        "vpbroadcastq %rax,%zmm1{%k3}{z}",
        &[0x62, 0xF2, 0xFD, 0xCB, 0x7C, 0xC8],
    );
    gas(
        "vpbroadcastd %eax,%zmm0",
        &[0x62, 0xF2, 0x7D, 0x48, 0x7C, 0xC0],
    );
    gas(
        "vpbroadcastd %r9d,%ymm20",
        &[0x62, 0xC2, 0x7D, 0x28, 0x7C, 0xE1],
    );
    gas(
        "vpbroadcastd %eax,%xmm17",
        &[0x62, 0xE2, 0x7D, 0x08, 0x7C, 0xC8],
    );
    gas(
        "vpbroadcastw %eax,%zmm0",
        &[0x62, 0xF2, 0x7D, 0x48, 0x7B, 0xC0],
    );
    gas(
        "vpbroadcastw %r13d,%ymm3",
        &[0x62, 0xD2, 0x7D, 0x28, 0x7B, 0xDD],
    );
    gas(
        "vpbroadcastb %eax,%zmm0",
        &[0x62, 0xF2, 0x7D, 0x48, 0x7A, 0xC0],
    );
    gas(
        "vpbroadcastb %r13d,%xmm3",
        &[0x62, 0xD2, 0x7D, 0x08, 0x7A, 0xDD],
    );
    // The vector-register and memory members keep their own opcodes.
    gas(
        "vpbroadcastq %xmm1,%zmm9",
        &[0x62, 0x72, 0xFD, 0x48, 0x59, 0xC9],
    );
    gas(
        "vpbroadcastq (%rax),%zmm9",
        &[0x62, 0x72, 0xFD, 0x48, 0x59, 0x08],
    );
    gas(
        "vpbroadcastd %xmm1,%zmm9",
        &[0x62, 0x72, 0x7D, 0x48, 0x58, 0xC9],
    );
    gas(
        "vpbroadcastd (%rax),%zmm9",
        &[0x62, 0x72, 0x7D, 0x48, 0x58, 0x08],
    );
    // The widths GNU as refuses.
    refused("vpbroadcastq %eax,%zmm0", "64-bit general register");
    refused("vpbroadcastd %rax,%zmm0", "32-bit general register");
    refused("vpbroadcastw %ax,%zmm0", "32-bit general register");
    refused("vpbroadcastb %al,%zmm0", "32-bit general register");
}

/// The widening 32x32 multiplies, whose EVEX members broadcast a qword and so
/// set W where their VEX ones ignore it.
#[test]
fn widening_multiplies() {
    gas(
        "vpmuludq (%rax){1to8},%zmm1,%zmm0",
        &[0x62, 0xF1, 0xF5, 0x58, 0xF4, 0x00],
    );
    gas(
        "vpmuldq %zmm2,%zmm1,%zmm0",
        &[0x62, 0xF2, 0xF5, 0x48, 0x28, 0xC2],
    );
    gas(
        "vpmuldq 0x40(%rax),%zmm1,%zmm0",
        &[0x62, 0xF2, 0xF5, 0x48, 0x28, 0x40, 0x01],
    );
}

/// The code mode reaches an instruction's addressing, not its VEX / EVEX
/// prefix: the register forms encode identically at 16, 32 and 64 bits, and a
/// 32-bit memory operand encodes as its 64-bit counterpart does.
#[test]
fn permutes_and_broadcasts_across_code_modes() {
    #[track_caller]
    fn same(text: &str, bytes: &[u8]) {
        for mode in [Mode::Bits16, Mode::Bits32, Mode::Bits64] {
            match enc_in(text, mode) {
                Ok(got) if got == bytes => {}
                Ok(got) => panic!("{text} at {mode:?}\n  badc {got:02x?}\n  gas  {bytes:02x?}"),
                Err(e) => panic!("{text} at {mode:?}: {e}"),
            }
        }
    }
    same(
        "vpermq $0x2,%ymm3,%ymm2",
        &[0xC4, 0xE3, 0xFD, 0x00, 0xD3, 0x02],
    );
    same(
        "vpermq $0x2,%zmm3,%zmm4",
        &[0x62, 0xF3, 0xFD, 0x48, 0x00, 0xE3, 0x02],
    );
    same(
        "vpbroadcastd %eax,%zmm0",
        &[0x62, 0xF2, 0x7D, 0x48, 0x7C, 0xC0],
    );
    same(
        "vpbroadcastb %ecx,%xmm2",
        &[0x62, 0xF2, 0x7D, 0x08, 0x7A, 0xD1],
    );
    gas_in(
        "vpermq $0x39,(%eax),%ymm0",
        Mode::Bits32,
        &[0xC4, 0xE3, 0xFD, 0x00, 0x00, 0x39],
    );
}

// ------------------------------------------------------------------
// Differential sweep against the system assembler.
// ------------------------------------------------------------------

/// Cross-check every row of [`super::TABLE`] against the system assembler over
/// the operand shapes and displacements the row admits. Gated on
/// `BADC_FUZZ_ASM=1` and the presence of `cc` + `objdump`, so a bare
/// `cargo test` skips it; the golden cases above cover that run.
#[cfg(feature = "std")]
mod differential {
    use alloc::format;
    use alloc::string::{String, ToString};
    use alloc::vec::Vec;
    use std::process::Command;

    use super::super::{Form, Shape, TABLE, Tuple};

    fn enabled() -> bool {
        std::env::var("BADC_FUZZ_ASM").is_ok()
            && Command::new("cc").arg("--version").output().is_ok()
            && Command::new("objdump").arg("--version").output().is_ok()
    }

    /// AT&T name of vector register `n` at `bytes` wide.
    fn v(bytes: u32, n: u8) -> String {
        let bank = match bytes {
            16 => "xmm",
            32 => "ymm",
            _ => "zmm",
        };
        format!("%{bank}{n}")
    }

    /// AT&T name of general register `n` at `bytes` wide.
    fn g(bytes: u32, n: u8) -> String {
        const R32: &[&str] = &["%eax", "%ecx", "%edx", "%ebx"];
        const R64: &[&str] = &["%rax", "%rcx", "%rdx", "%rbx"];
        String::from(if bytes >= 8 { R64 } else { R32 }[n as usize])
    }

    /// The width of a form's r/m operand: the size of its memory operand,
    /// which is also the width of the register that may stand in its place.
    fn rm_bytes(f: Form, vl: u32) -> u32 {
        f.tuple.disp8_n(vl, f.w, false).max(16)
    }

    /// The displacements worth encoding for a scale of `n`: zero, one step,
    /// the extremes a signed byte holds, and the neighbours that must fall
    /// back to disp32.
    fn disps(n: i32) -> Vec<i32> {
        alloc::vec![0, n, 127 * n, 128 * n, -128 * n, -129 * n, n + 1]
    }

    /// The r/m operand spellings to try for one form at one vector length: a
    /// register, then each displacement, with and without a broadcast.
    fn rms(f: Form, vl: u32) -> Vec<String> {
        let mut out = Vec::new();
        out.push(if f.gpr_rm {
            g(rm_bytes(f, vl), 1)
        } else {
            v(rm_bytes(f, vl), 1)
        });
        if f.shape == Shape::RmMem {
            out.clear();
        }
        let n = f.tuple.disp8_n(vl, f.w, false) as i32;
        for d in disps(n) {
            out.push(format!("{d}(%rcx)"));
        }
        out.push("(%rdx,%r14,8)".to_string());
        out.push("64(%r13,%r14,4)".to_string());
        if matches!(f.tuple, Tuple::Full | Tuple::Half) {
            let (whole, one) = (
                f.tuple.disp8_n(vl, f.w, false),
                f.tuple.disp8_n(vl, f.w, true),
            );
            let nb = f.tuple.disp8_n(vl, f.w, true) as i32;
            for d in [nb, 127 * nb, 128 * nb] {
                out.push(format!("{d}(%rcx){{1to{}}}", whole / one));
            }
        }
        out
    }

    /// Every instruction spelling this sweep tries for one table row.
    fn cases(name: &str, f: Form) -> Vec<String> {
        let mut out = Vec::new();
        for vl in [16u32, 32, 64] {
            let dst = |n: u8| v(vl, n);
            for rm in rms(f, vl) {
                let line = match f.shape {
                    Shape::Rvm => format!("{name} {rm},{},{}", v(vl, 2), dst(0)),
                    Shape::RvmI => format!("{name} $0x1,{rm},{},{}", v(vl, 2), dst(0)),
                    Shape::Rm | Shape::RmMem => format!("{name} {rm},{}", dst(0)),
                    Shape::RmI => format!("{name} $0x1,{rm},{}", dst(0)),
                    Shape::MrI => format!("{name} $0x1,{},{rm}", v(vl, 0)),
                    Shape::VmI(_) => format!("{name} $0x1,{rm},{}", v(vl, 0)),
                    Shape::Mov => format!("{name} {rm},{}", v(vl, 0)),
                };
                out.push(line);
            }
            // The store direction of a move, and the extended register file.
            if f.shape == Shape::Mov {
                out.push(format!("{name} {},16(%rcx)", v(vl, 0)));
                if !f.gpr_rm {
                    out.push(format!("{name} {},{}", v(vl, 0), v(rm_bytes(f, vl), 1)));
                }
            }
            let hi = if f.gpr_rm {
                g(rm_bytes(f, vl), 2)
            } else {
                v(rm_bytes(f, vl), 31)
            };
            let (a, b) = (v(vl, 29), v(vl, 30));
            match f.shape {
                Shape::Rvm => {
                    out.push(format!("{name} {hi},{b},{a}"));
                    out.push(format!("{name} {hi},{b},{a}{{%k3}}"));
                    out.push(format!("{name} {hi},{b},{a}{{%k7}}{{z}}"));
                }
                Shape::RvmI => {
                    out.push(format!("{name} $0x2,{hi},{b},{a}"));
                    out.push(format!("{name} $0x2,{hi},{b},{a}{{%k5}}{{z}}"));
                }
                Shape::Rm => {
                    out.push(format!("{name} {hi},{a}"));
                    out.push(format!("{name} {hi},{a}{{%k1}}"));
                }
                Shape::RmI => out.push(format!("{name} $0x2,{hi},{a}")),
                Shape::MrI => out.push(format!("{name} $0x2,{},{hi}", v(vl, 29))),
                Shape::VmI(_) => {
                    out.push(format!("{name} $0x2,{hi},{a}"));
                    out.push(format!("{name} $0x2,{hi},{a}{{%k2}}{{z}}"));
                }
                // A scalar transfer with no vector-register pair form takes
                // only its general-register and memory spellings.
                Shape::Mov if f.gpr_rm && f.alt_op == 0 => {}
                Shape::Mov => {
                    out.push(format!("{name} {hi},{a}"));
                    out.push(format!("{name} {a},{hi}"));
                }
                Shape::RmMem => {}
            }
        }
        out
    }

    /// Assemble `lines`, dropping the ones the assembler rejects, and return
    /// the surviving lines with their bytes. Each instruction is bracketed by
    /// an eight-byte nop run so the stream splits without decoding it.
    fn assemble(mut lines: Vec<String>) -> Vec<(String, Vec<u8>)> {
        let base = crate::c5::tests::unique_temp_path("badc-evex", "table", "");
        let (s, o) = (base.with_extension("s"), base.with_extension("o"));
        let bytes = loop {
            let mut src = String::from(".text\n");
            for l in &lines {
                src.push_str("\t.byte 0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90\n\t");
                src.push_str(l);
                src.push('\n');
            }
            src.push_str("\t.byte 0x90,0x90,0x90,0x90,0x90,0x90,0x90,0x90\n");
            std::fs::write(&s, &src).expect("write assembler input");
            let out = Command::new("cc")
                .args(["-c", "-x", "assembler"])
                .arg(&s)
                .arg("-o")
                .arg(&o)
                .output()
                .expect("spawn cc");
            if out.status.success() {
                break Command::new("objdump")
                    .args(["-d", "--insn-width=16"])
                    .arg(&o)
                    .output()
                    .expect("spawn objdump")
                    .stdout;
            }
            // Errors carry a line number into the file written above: two
            // header lines precede the first instruction's `.byte` line, and
            // each instruction takes two lines.
            let text = String::from_utf8_lossy(&out.stderr).to_string();
            let mut bad: Vec<usize> = text
                .lines()
                .filter_map(|l| l.split(':').nth(1)?.parse::<usize>().ok())
                .filter_map(|n| n.checked_sub(2))
                .filter(|n| n % 2 == 1)
                .map(|n| n / 2)
                .filter(|&i| i < lines.len())
                .collect();
            bad.sort_unstable();
            bad.dedup();
            assert!(
                !bad.is_empty(),
                "cc rejected the input with no usable line numbers:\n{text}"
            );
            for i in bad.into_iter().rev() {
                lines.remove(i);
            }
        };
        let _ = std::fs::remove_file(&s);
        let _ = std::fs::remove_file(&o);
        let text = String::from_utf8_lossy(&bytes);
        let mut stream: Vec<u8> = Vec::new();
        for l in text.lines() {
            let Some(tab) = l.find(':') else { continue };
            if !l[..tab].trim_start().chars().all(|c| c.is_ascii_hexdigit())
                || l[..tab].trim().is_empty()
            {
                continue;
            }
            for tok in l[tab + 1..].split_whitespace() {
                match u8::from_str_radix(tok, 16) {
                    Ok(b) if tok.len() == 2 => stream.push(b),
                    _ => break,
                }
            }
        }
        let nop8 = [0x90u8; 8];
        let (mut out, mut i) = (Vec::new(), 0usize);
        while i < stream.len() {
            if stream[i..].starts_with(&nop8) {
                i += 8;
                let start = i;
                while i < stream.len() && !stream[i..].starts_with(&nop8) {
                    i += 1;
                }
                if i > start {
                    out.push(stream[start..i].to_vec());
                }
            } else {
                i += 1;
            }
        }
        assert_eq!(
            out.len(),
            lines.len(),
            "chunk count does not match line count"
        );
        lines.into_iter().zip(out).collect()
    }

    #[test]
    fn table_matches_system_assembler() {
        if !enabled() {
            return;
        }
        let lines: Vec<String> = TABLE.iter().flat_map(|&(n, f)| cases(n, f)).collect();
        let total = lines.len();
        let pairs = assemble(lines);
        let mut mismatch = Vec::new();
        for (text, want) in &pairs {
            match super::enc(text) {
                Ok(got) if got == *want => {}
                Ok(got) => mismatch.push(format!("{text}\n  badc {got:02x?}\n  as   {want:02x?}")),
                Err(e) => mismatch.push(format!("{text}\n  badc refused: {e}")),
            }
        }
        assert!(
            mismatch.is_empty(),
            "{} of {} compared ({total} generated) disagree with the system assembler:\n{}",
            mismatch.len(),
            pairs.len(),
            mismatch.join("\n")
        );
        assert!(
            pairs.len() > 2000,
            "only {} of {total} spellings survived assembly; the sweep is not covering the table",
            pairs.len()
        );
    }
}
