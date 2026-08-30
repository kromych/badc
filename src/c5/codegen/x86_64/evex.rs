//! EVEX (AVX-512) encoding.
//!
//! The 4-byte EVEX prefix carries what VEX does plus the fields that widen the
//! register file to 32 vector registers, select an opmask, and set the vector
//! length: `R`/`X`/`B` with `R'` and `V'` for the fifth register bit, `L'L`,
//! `aaa`, `z`, and `b` (embedded broadcast). A memory operand's 8-bit
//! displacement is scaled by a factor the form's [`Tuple`] type fixes, so the
//! tuple type is a required part of every form rather than a default.
//!
//! Forms resolve by name through [`op`]; [`super::asm`] routes a mnemonic here
//! when the name is EVEX-only or when an operand (a zmm, a vector register
//! above 15, a decorator) puts the instruction out of VEX's reach. Anything
//! this table does not name is refused, not guessed. Opmask registers appear
//! as the `{%kN}` write-mask decorator and as operands of the forms marked
//! `kreg` / `krm` (the compares and tests, the mask <-> vector moves); the
//! `k*` instruction set itself is VEX-encoded and lives in [`super::asm`].

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::ir::AsmRegSize;

use super::asm::{Concrete, MemRm, XMM_BASE, YMM_BASE, ZMM_BASE, mask_reg_num};

/// Memory-operand tuple type. It fixes the factor `N` that the hardware
/// multiplies an EVEX disp8 field by (SDM Vol. 2A, Table 2-34), which depends
/// on the operand's element width, the vector length, and whether EVEX.b
/// selects an embedded broadcast.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Tuple {
    /// The memory operand is a full vector, or one element under a broadcast.
    Full,
    /// The memory operand is half a vector, or one element under a broadcast.
    Half,
    /// A full vector of memory; the form takes no broadcast.
    FullMem,
    /// One element of the given byte width.
    Elem(u8),
    /// One element whose width EVEX.W selects (4 or 8 bytes).
    ElemW,
    /// `n` elements whose width EVEX.W selects (the `x2` / `x4` / `x8`
    /// broadcasts, inserts and extracts).
    Group(u8),
    /// Half, a quarter, an eighth of a vector of memory (the packed converts).
    HalfMem,
    QuarterMem,
    EighthMem,
    /// `vmovddup`: 8 bytes at VL=128, a full vector above it.
    Dup,
}

impl Tuple {
    /// The disp8 scale factor for a `vl`-byte operation.
    fn disp8_n(self, vl: u32, w: bool, bcast: bool) -> u32 {
        let elem = if w { 8 } else { 4 };
        match self {
            Tuple::Full if bcast => elem,
            Tuple::Full => vl,
            Tuple::Half if bcast => elem,
            Tuple::Half => vl / 2,
            Tuple::FullMem => vl,
            Tuple::Elem(n) => u32::from(n),
            Tuple::ElemW => elem,
            Tuple::Group(n) => u32::from(n) * elem,
            Tuple::HalfMem => vl / 2,
            Tuple::QuarterMem => vl / 4,
            Tuple::EighthMem => vl / 8,
            Tuple::Dup if vl == 16 => 8,
            Tuple::Dup => vl,
        }
    }

    /// Whether an embedded broadcast is defined for this tuple type.
    fn broadcasts(self) -> bool {
        matches!(self, Tuple::Full | Tuple::Half)
    }
}

/// Operand arrangement of a form, in AT&T order.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Shape {
    /// `op %src2, %src1, %dst`: dst in ModRM.reg, src1 in EVEX.vvvv, src2 in
    /// r/m.
    Rvm,
    /// `op $imm8, %src2, %src1, %dst`: [`Shape::Rvm`] with a trailing byte.
    RvmI,
    /// `op %src, %dst`: dst in ModRM.reg, src in r/m, EVEX.vvvv unused.
    Rm,
    /// [`Shape::Rm`] with a memory-only source (the sub-vector broadcasts
    /// and the non-temporal load).
    RmMem,
    /// `op $imm8, %src, %dst`: [`Shape::Rm`] with a trailing byte.
    RmI,
    /// `op $imm8, %src, %dst` writing its r/m operand: src in ModRM.reg, dst in
    /// r/m (the sub-vector extracts).
    MrI,
    /// `op %src, %dst` between a register and a register or memory, with the
    /// vector register always in ModRM.reg: `opcode` loads, `store_op` stores.
    Mov,
    /// `op $imm8, %src, %dst` with the destination in EVEX.vvvv and the given
    /// opcode extension in ModRM.reg (the shifts and rotates by immediate).
    VmI(u8),
}

impl Shape {
    /// Whether the operand list of this shape leads with an immediate. It is
    /// what separates the rows of a name the ISA gives two shapes -- the lane
    /// permutes, controlled either by an immediate or by a vector of indices.
    const fn leads_imm(self) -> bool {
        matches!(self, Shape::RvmI | Shape::RmI | Shape::MrI | Shape::VmI(_))
    }
}

/// One EVEX-encodable instruction form.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) struct Form {
    pub(crate) shape: Shape,
    /// SSE-prefix selector (0 none, 1 0x66, 2 0xF3, 3 0xF2).
    pub(crate) pp: u8,
    /// Opcode map (1 = 0F, 2 = 0F38, 3 = 0F3A).
    pub(crate) map: u8,
    pub(crate) w: bool,
    pub(crate) opcode: u8,
    /// Store-direction opcode of a [`Shape::Mov`] form.
    pub(crate) store_op: u8,
    /// The r/m operand is a general register or memory, not a vector register
    /// (the scalar transfers and the element inserts / extracts).
    pub(crate) gpr_rm: bool,
    /// Prefix and opcode a `gpr_rm` form takes when both its operands are
    /// vector registers; a zero opcode means the form has no such pair.
    pub(crate) alt_pp: u8,
    pub(crate) alt_op: u8,
    /// Opcode this form takes when its r/m operand is a general register
    /// rather than a vector register or memory (the element broadcasts);
    /// a zero opcode means the form has no such member. EVEX.W selects the
    /// general register's width: 8 bytes when set, 4 otherwise.
    pub(crate) gpr_op: u8,
    /// Smallest vector length, in bytes, the form has a member at (0 for the
    /// forms defined at every length). The lane-crossing quadword permutes
    /// start at 256 bits.
    pub(crate) min_vl: u8,
    pub(crate) tuple: Tuple,
    /// The ModRM.reg operand is an opmask register, not a vector one (the
    /// compares and tests, and the mask-from-vector moves).
    pub(crate) kreg: bool,
    /// The r/m operand is an opmask register (the vector-from-mask moves).
    /// The ISA gives the mask <-> vector moves register forms only, so a
    /// [`Shape::Rm`] row with an opmask on either side takes no memory.
    pub(crate) krm: bool,
    /// Opmask register 1..7 selected by `{%kN}` (0 = none).
    pub(crate) mask: u8,
    /// `{z}`: merge-masking becomes zero-masking.
    pub(crate) zeroing: bool,
    /// `{1toN}`: the element count the operand spells (0 = no broadcast).
    pub(crate) bcast: u8,
}

const fn form(shape: Shape, pp: u8, map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    Form {
        shape,
        pp,
        map,
        w,
        opcode,
        store_op: 0,
        gpr_rm: false,
        alt_pp: 0,
        alt_op: 0,
        gpr_op: 0,
        min_vl: 0,
        tuple,
        kreg: false,
        krm: false,
        mask: 0,
        zeroing: false,
        bcast: 0,
    }
}

const fn rvm(pp: u8, map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    form(Shape::Rvm, pp, map, w, opcode, tuple)
}
const fn rvmi(pp: u8, map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    form(Shape::RvmI, pp, map, w, opcode, tuple)
}
const fn rm(pp: u8, map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    form(Shape::Rm, pp, map, w, opcode, tuple)
}
const fn rmi(pp: u8, map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    form(Shape::RmI, pp, map, w, opcode, tuple)
}
const fn mri(pp: u8, map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    form(Shape::MrI, pp, map, w, opcode, tuple)
}

/// A shift or rotate by immediate: the destination rides EVEX.vvvv and
/// `digit` the ModRM.reg opcode extension.
const fn vmi(w: bool, opcode: u8, digit: u8, tuple: Tuple) -> Form {
    form(Shape::VmI(digit), 1, 1, w, opcode, tuple)
}

/// A memory-source-only 0F38 form (the sub-vector broadcasts and the
/// non-temporal load).
const fn rmmem(w: bool, opcode: u8, tuple: Tuple) -> Form {
    form(Shape::RmMem, 1, 2, w, opcode, tuple)
}

/// A compare or test whose destination is an opmask register.
const fn krvm(pp: u8, map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    Form {
        kreg: true,
        ..rvm(pp, map, w, opcode, tuple)
    }
}
const fn krvmi(pp: u8, map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    Form {
        kreg: true,
        ..rvmi(pp, map, w, opcode, tuple)
    }
}

/// A mask <-> vector move (F3 0F38, register forms only): `to_mask` writes
/// the opmask in ModRM.reg from a vector r/m, its inverse reads one in r/m.
const fn kmove(w: bool, opcode: u8, to_mask: bool) -> Form {
    Form {
        kreg: to_mask,
        krm: !to_mask,
        ..form(Shape::Rm, 2, 2, w, opcode, Tuple::FullMem)
    }
}

/// A packed move, `load` in the register direction and `store` the other way.
const fn mov(pp: u8, w: bool, load: u8, store: u8) -> Form {
    Form {
        store_op: store,
        ..form(Shape::Mov, pp, 1, w, load, Tuple::FullMem)
    }
}

/// A non-temporal packed store (0F map): a [`Shape::Mov`] form with no load
/// direction, which a zero `opcode` marks.
const fn movnt(pp: u8, w: bool, store: u8) -> Form {
    mov(pp, w, 0, store)
}

/// A scalar transfer between a vector register and a general register or
/// memory; `alt_pp` / `alt_op` give the vector-register pair form, if any.
const fn movg(w: bool, alt_pp: u8, alt_op: u8) -> Form {
    Form {
        store_op: 0x7E,
        gpr_rm: true,
        alt_pp,
        alt_op,
        ..form(Shape::Mov, 1, 1, w, 0x6E, Tuple::ElemW)
    }
}

/// An element extract, writing a general register or memory.
const fn gmri(map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    Form {
        gpr_rm: true,
        ..form(Shape::MrI, 1, map, w, opcode, tuple)
    }
}

/// An element insert, reading a general register or memory.
const fn grvmi(map: u8, w: bool, opcode: u8, tuple: Tuple) -> Form {
    Form {
        gpr_rm: true,
        ..form(Shape::RvmI, 1, map, w, opcode, tuple)
    }
}

/// A form whose r/m operand may also be a general register, under `gpr_op`.
const fn or_gpr(f: Form, gpr_op: u8) -> Form {
    Form { gpr_op, ..f }
}

/// A form with no 128-bit member.
const fn vl256(f: Form) -> Form {
    Form { min_vl: 32, ..f }
}

/// Every EVEX form this encoder implements, as `(mnemonic, form)`. Each row
/// states its tuple type rather than defaulting one: the tuple fixes the
/// compressed displacement scale, and a wrong scale encodes cleanly while
/// addressing the wrong memory. Every row is byte-verified against GNU as by
/// the differential sweep in the tests.
#[rustfmt::skip]
const TABLE: &[(&str, Form)] = {
    use Tuple::*;
    &[
    // Packed moves. All are full-vector memory: the element width the name
    // spells selects the opmask granularity, not the displacement scale.
    ("vmovdqu8",  mov(3, false, 0x6F, 0x7F)), ("vmovdqu16", mov(3, true,  0x6F, 0x7F)),
    ("vmovdqu32", mov(2, false, 0x6F, 0x7F)), ("vmovdqu64", mov(2, true,  0x6F, 0x7F)),
    ("vmovdqa32", mov(1, false, 0x6F, 0x7F)), ("vmovdqa64", mov(1, true,  0x6F, 0x7F)),
    ("vmovups",   mov(0, false, 0x10, 0x11)), ("vmovupd",   mov(1, true,  0x10, 0x11)),
    ("vmovaps",   mov(0, false, 0x28, 0x29)), ("vmovapd",   mov(1, true,  0x28, 0x29)),
    // The non-temporal moves have one direction each: the stores write a
    // whole vector of memory from a register, `vmovntdqa` loads one.
    ("vmovntdq", movnt(1, false, 0xE7)), ("vmovntps", movnt(0, false, 0x2B)),
    ("vmovntpd", movnt(1, true, 0x2B)),  ("vmovntdqa", rmmem(false, 0x2A, FullMem)),
    // `vmovq` has a vector-register pair form under the F3 prefix; `vmovd` has
    // none, so a vector r/m is refused there.
    ("vmovd", movg(false, 0, 0)), ("vmovq", movg(true, 2, 0x7E)),
    // Bitwise and integer arithmetic on 32/64-bit elements: full vector,
    // broadcastable.
    ("vpandd",  rvm(1, 1, false, 0xDB, Full)), ("vpandq",  rvm(1, 1, true,  0xDB, Full)),
    ("vpandnd", rvm(1, 1, false, 0xDF, Full)), ("vpandnq", rvm(1, 1, true,  0xDF, Full)),
    ("vpord",   rvm(1, 1, false, 0xEB, Full)), ("vporq",   rvm(1, 1, true,  0xEB, Full)),
    ("vpxord",  rvm(1, 1, false, 0xEF, Full)), ("vpxorq",  rvm(1, 1, true,  0xEF, Full)),
    ("vpaddd",  rvm(1, 1, false, 0xFE, Full)), ("vpaddq",  rvm(1, 1, true,  0xD4, Full)),
    ("vpsubd",  rvm(1, 1, false, 0xFA, Full)), ("vpsubq",  rvm(1, 1, true,  0xFB, Full)),
    ("vpmulld", rvm(1, 2, false, 0x40, Full)), ("vpmullq", rvm(1, 2, true,  0x40, Full)),
    // The widening 32x32 multiplies read dword elements and write qword ones,
    // so their broadcast is a qword and EVEX.W is set where VEX leaves it
    // ignored.
    ("vpmuludq", rvm(1, 1, true, 0xF4, Full)), ("vpmuldq", rvm(1, 2, true, 0x28, Full)),
    ("vpminsd", rvm(1, 2, false, 0x39, Full)), ("vpminsq", rvm(1, 2, true,  0x39, Full)),
    ("vpmaxsd", rvm(1, 2, false, 0x3D, Full)), ("vpmaxsq", rvm(1, 2, true,  0x3D, Full)),
    ("vpsllvd", rvm(1, 2, false, 0x47, Full)), ("vpsllvq", rvm(1, 2, true,  0x47, Full)),
    ("vpsrlvd", rvm(1, 2, false, 0x45, Full)), ("vpsrlvq", rvm(1, 2, true,  0x45, Full)),
    ("vpsravd", rvm(1, 2, false, 0x46, Full)), ("vpsravq", rvm(1, 2, true,  0x46, Full)),
    ("vpermd",  rvm(1, 2, false, 0x36, Full)), ("vpermps", rvm(1, 2, false, 0x16, Full)),
    ("vpermi2d",  rvm(1, 2, false, 0x76, Full)), ("vpermi2q",  rvm(1, 2, true,  0x76, Full)),
    ("vpermt2d",  rvm(1, 2, false, 0x7E, Full)), ("vpermt2q",  rvm(1, 2, true,  0x7E, Full)),
    ("vpermi2ps", rvm(1, 2, false, 0x77, Full)), ("vpermi2pd", rvm(1, 2, true,  0x77, Full)),
    ("vpermt2ps", rvm(1, 2, false, 0x7F, Full)), ("vpermt2pd", rvm(1, 2, true,  0x7F, Full)),
    ("vaddps", rvm(0, 1, false, 0x58, Full)), ("vaddpd", rvm(1, 1, true,  0x58, Full)),
    ("vsubps", rvm(0, 1, false, 0x5C, Full)), ("vsubpd", rvm(1, 1, true,  0x5C, Full)),
    ("vmulps", rvm(0, 1, false, 0x59, Full)), ("vmulpd", rvm(1, 1, true,  0x59, Full)),
    ("vdivps", rvm(0, 1, false, 0x5E, Full)), ("vdivpd", rvm(1, 1, true,  0x5E, Full)),
    ("vminps", rvm(0, 1, false, 0x5D, Full)), ("vminpd", rvm(1, 1, true,  0x5D, Full)),
    ("vmaxps", rvm(0, 1, false, 0x5F, Full)), ("vmaxpd", rvm(1, 1, true,  0x5F, Full)),
    ("vunpcklps", rvm(0, 1, false, 0x14, Full)), ("vunpckhps", rvm(0, 1, false, 0x15, Full)),
    ("vunpcklpd", rvm(1, 1, true,  0x14, Full)), ("vunpckhpd", rvm(1, 1, true,  0x15, Full)),
    ("vpunpckldq", rvm(1, 1, false, 0x62, Full)), ("vpunpckhdq", rvm(1, 1, false, 0x6A, Full)),
    ("vpunpcklqdq", rvm(1, 1, true, 0x6C, Full)), ("vpunpckhqdq", rvm(1, 1, true, 0x6D, Full)),
    // Byte and word elements have no broadcast form, so their memory operand is
    // always a whole vector.
    ("vpaddb",  rvm(1, 1, false, 0xFC, FullMem)), ("vpaddw",  rvm(1, 1, false, 0xFD, FullMem)),
    ("vpsubb",  rvm(1, 1, false, 0xF8, FullMem)), ("vpsubw",  rvm(1, 1, false, 0xF9, FullMem)),
    ("vpshufb", rvm(1, 2, false, 0x00, FullMem)),
    ("vpmullw", rvm(1, 1, false, 0xD5, FullMem)), ("vpmaddwd", rvm(1, 1, false, 0xF5, FullMem)),
    // The vector AES rounds (VAES): a whole vector of memory, no broadcast.
    ("vaesenc",     rvm(1, 2, false, 0xDC, FullMem)),
    ("vaesenclast", rvm(1, 2, false, 0xDD, FullMem)),
    ("vaesdec",     rvm(1, 2, false, 0xDE, FullMem)),
    ("vaesdeclast", rvm(1, 2, false, 0xDF, FullMem)),
    // GFNI: byte elements, so W is clear and the form takes no broadcast.
    ("vgf2p8mulb", rvm(1, 2, false, 0xCF, FullMem)),
    // Scalar single / double: one element, its width from EVEX.W.
    ("vaddss", rvm(2, 1, false, 0x58, ElemW)), ("vaddsd", rvm(3, 1, true,  0x58, ElemW)),
    ("vsubss", rvm(2, 1, false, 0x5C, ElemW)), ("vsubsd", rvm(3, 1, true,  0x5C, ElemW)),
    ("vmulss", rvm(2, 1, false, 0x59, ElemW)), ("vmulsd", rvm(3, 1, true,  0x59, ElemW)),
    ("vdivss", rvm(2, 1, false, 0x5E, ElemW)), ("vdivsd", rvm(3, 1, true,  0x5E, ElemW)),
    // 3-operand with a trailing immediate.
    ("vpternlogd", rvmi(1, 3, false, 0x25, Full)), ("vpternlogq", rvmi(1, 3, true, 0x25, Full)),
    ("vpclmulqdq", rvmi(1, 3, false, 0x44, FullMem)),
    // GFNI: qword elements, so W is set and a broadcast reads one qword.
    ("vgf2p8affineqb",    rvmi(1, 3, true, 0xCE, Full)),
    ("vgf2p8affineinvqb", rvmi(1, 3, true, 0xCF, Full)),
    ("vshufps",    rvmi(0, 1, false, 0xC6, Full)), ("vshufpd", rvmi(1, 1, true, 0xC6, Full)),
    ("vpalignr",   rvmi(1, 3, false, 0x0F, FullMem)),
    // The 128-bit lane shuffles, which have no VEX form.
    ("vshufi32x4", rvmi(1, 3, false, 0x43, Full)), ("vshufi64x2", rvmi(1, 3, true, 0x43, Full)),
    ("vshuff32x4", rvmi(1, 3, false, 0x23, Full)), ("vshuff64x2", rvmi(1, 3, true, 0x23, Full)),
    ("vinserti32x4", rvmi(1, 3, false, 0x38, Group(4))),
    ("vinsertf32x4", rvmi(1, 3, false, 0x18, Group(4))),
    ("vinserti64x2", rvmi(1, 3, true,  0x38, Group(2))),
    ("vinsertf64x2", rvmi(1, 3, true,  0x18, Group(2))),
    ("vinserti64x4", rvmi(1, 3, true,  0x3A, Group(4))),
    ("vinsertf64x4", rvmi(1, 3, true,  0x1A, Group(4))),
    ("vinserti32x8", rvmi(1, 3, false, 0x3A, Group(8))),
    ("vinsertf32x8", rvmi(1, 3, false, 0x1A, Group(8))),
    // Sub-vector extracts, which write their r/m operand.
    ("vextracti32x4", mri(1, 3, false, 0x39, Group(4))),
    ("vextractf32x4", mri(1, 3, false, 0x19, Group(4))),
    ("vextracti64x2", mri(1, 3, true,  0x39, Group(2))),
    ("vextractf64x2", mri(1, 3, true,  0x19, Group(2))),
    ("vextracti64x4", mri(1, 3, true,  0x3B, Group(4))),
    ("vextractf64x4", mri(1, 3, true,  0x1B, Group(4))),
    ("vextracti32x8", mri(1, 3, false, 0x3B, Group(8))),
    ("vextractf32x8", mri(1, 3, false, 0x1B, Group(8))),
    // Element extracts, which write a general register or memory, and element
    // inserts, which read one. `vpextrw`'s register-destination form inverts
    // the shape -- the general register rides ModRM.reg there -- so it is left
    // out rather than encoded as the memory form, which writes 16 bits.
    ("vpextrb", gmri(3, false, 0x14, Elem(1))), ("vpextrd", gmri(3, false, 0x16, Elem(4))),
    ("vpextrq", gmri(3, true,  0x16, Elem(8))), ("vextractps", gmri(3, false, 0x17, Elem(4))),
    ("vpinsrb", grvmi(3, false, 0x20, Elem(1))), ("vpinsrw", grvmi(1, false, 0xC4, Elem(2))),
    ("vpinsrd", grvmi(3, false, 0x22, Elem(4))), ("vpinsrq", grvmi(3, true,  0x22, Elem(8))),
    // Shifts and rotates by immediate. The 32/64-bit element forms broadcast;
    // the 16-bit and byte-lane ones have no broadcast form.
    ("vprord", vmi(false, 0x72, 0, Full)), ("vprorq", vmi(true,  0x72, 0, Full)),
    ("vprold", vmi(false, 0x72, 1, Full)), ("vprolq", vmi(true,  0x72, 1, Full)),
    ("vpslld", vmi(false, 0x72, 6, Full)), ("vpsllq", vmi(true,  0x73, 6, Full)),
    ("vpsrld", vmi(false, 0x72, 2, Full)), ("vpsrlq", vmi(true,  0x73, 2, Full)),
    ("vpsrad", vmi(false, 0x72, 4, Full)), ("vpsraq", vmi(true,  0x72, 4, Full)),
    ("vpsllw", vmi(false, 0x71, 6, FullMem)), ("vpsrlw", vmi(false, 0x71, 2, FullMem)),
    ("vpsraw", vmi(false, 0x71, 4, FullMem)),
    ("vpslldq", vmi(false, 0x73, 7, FullMem)), ("vpsrldq", vmi(false, 0x73, 3, FullMem)),
    // 2-operand with a trailing immediate.
    ("vpshufd",   rmi(1, 1, false, 0x70, Full)),
    ("vpermilps", rmi(1, 3, false, 0x04, Full)), ("vpermilpd", rmi(1, 3, true, 0x05, Full)),
    // The lane-crossing quadword permutes take their control either as an
    // immediate (0F3A) or as a vector of indices (0F38); the two rows of each
    // name are told apart by the leading operand. Neither has a 128-bit form.
    ("vpermq",  vl256(rmi(1, 3, true, 0x00, Full))),
    ("vpermq",  vl256(rvm(1, 2, true, 0x36, Full))),
    ("vpermpd", vl256(rmi(1, 3, true, 0x01, Full))),
    ("vpermpd", vl256(rvm(1, 2, true, 0x16, Full))),
    // Sub-vector broadcasts: memory-only sources of 2, 4 or 8 elements.
    ("vbroadcasti32x2", rmmem(false, 0x59, Group(2))),
    ("vbroadcastf32x2", rmmem(false, 0x19, Group(2))),
    ("vbroadcasti32x4", rmmem(false, 0x5A, Group(4))),
    ("vbroadcastf32x4", rmmem(false, 0x1A, Group(4))),
    ("vbroadcasti64x2", rmmem(true,  0x5A, Group(2))),
    ("vbroadcastf64x2", rmmem(true,  0x1A, Group(2))),
    ("vbroadcasti64x4", rmmem(true,  0x5B, Group(4))),
    ("vbroadcastf64x4", rmmem(true,  0x1B, Group(4))),
    ("vbroadcasti32x8", rmmem(false, 0x5B, Group(8))),
    ("vbroadcastf32x8", rmmem(false, 0x1B, Group(8))),
    // Element broadcasts, packed extends and converts.
    ("vpbroadcastb", or_gpr(rm(1, 2, false, 0x78, Elem(1)), 0x7A)),
    ("vpbroadcastw", or_gpr(rm(1, 2, false, 0x79, Elem(2)), 0x7B)),
    ("vpbroadcastd", or_gpr(rm(1, 2, false, 0x58, Elem(4)), 0x7C)),
    ("vpbroadcastq", or_gpr(rm(1, 2, true,  0x59, Elem(8)), 0x7C)),
    ("vbroadcastss", rm(1, 2, false, 0x18, Elem(4))),
    ("vbroadcastsd", rm(1, 2, true,  0x19, Elem(8))),
    ("vpmovsxbw", rm(1, 2, false, 0x20, HalfMem)),
    ("vpmovzxbw", rm(1, 2, false, 0x30, HalfMem)),
    ("vpmovsxwd", rm(1, 2, false, 0x23, HalfMem)),
    ("vpmovzxwd", rm(1, 2, false, 0x33, HalfMem)),
    ("vpmovsxdq", rm(1, 2, false, 0x25, HalfMem)),
    ("vpmovzxdq", rm(1, 2, false, 0x35, HalfMem)),
    ("vpmovsxbd", rm(1, 2, false, 0x21, QuarterMem)),
    ("vpmovzxbd", rm(1, 2, false, 0x31, QuarterMem)),
    ("vpmovsxwq", rm(1, 2, false, 0x24, QuarterMem)),
    ("vpmovzxwq", rm(1, 2, false, 0x34, QuarterMem)),
    ("vpmovsxbq", rm(1, 2, false, 0x22, EighthMem)),
    ("vpmovzxbq", rm(1, 2, false, 0x32, EighthMem)),
    // Compares and tests writing an opmask register. Byte and word elements
    // have no broadcast form; the immediate compares take the predicate as a
    // trailing byte.
    ("vpcmpeqb", krvm(1, 1, false, 0x74, FullMem)), ("vpcmpeqw", krvm(1, 1, false, 0x75, FullMem)),
    ("vpcmpeqd", krvm(1, 1, false, 0x76, Full)),    ("vpcmpeqq", krvm(1, 2, true,  0x29, Full)),
    ("vpcmpgtb", krvm(1, 1, false, 0x64, FullMem)), ("vpcmpgtw", krvm(1, 1, false, 0x65, FullMem)),
    ("vpcmpgtd", krvm(1, 1, false, 0x66, Full)),    ("vpcmpgtq", krvm(1, 2, true,  0x37, Full)),
    ("vpcmpb",  krvmi(1, 3, false, 0x3F, FullMem)), ("vpcmpw",  krvmi(1, 3, true, 0x3F, FullMem)),
    ("vpcmpd",  krvmi(1, 3, false, 0x1F, Full)),    ("vpcmpq",  krvmi(1, 3, true, 0x1F, Full)),
    ("vpcmpub", krvmi(1, 3, false, 0x3E, FullMem)), ("vpcmpuw", krvmi(1, 3, true, 0x3E, FullMem)),
    ("vpcmpud", krvmi(1, 3, false, 0x1E, Full)),    ("vpcmpuq", krvmi(1, 3, true, 0x1E, Full)),
    ("vptestmb", krvm(1, 2, false, 0x26, FullMem)), ("vptestmw", krvm(1, 2, true, 0x26, FullMem)),
    ("vptestmd", krvm(1, 2, false, 0x27, Full)),    ("vptestmq", krvm(1, 2, true, 0x27, Full)),
    ("vptestnmb", krvm(2, 2, false, 0x26, FullMem)),
    ("vptestnmw", krvm(2, 2, true,  0x26, FullMem)),
    ("vptestnmd", krvm(2, 2, false, 0x27, Full)),
    ("vptestnmq", krvm(2, 2, true,  0x27, Full)),
    ("vcmpps", krvmi(0, 1, false, 0xC2, Full)),  ("vcmppd", krvmi(1, 1, true, 0xC2, Full)),
    ("vcmpss", krvmi(2, 1, false, 0xC2, ElemW)), ("vcmpsd", krvmi(3, 1, true, 0xC2, ElemW)),
    // Mask <-> vector moves.
    ("vpmovm2b", kmove(false, 0x28, false)), ("vpmovm2w", kmove(true, 0x28, false)),
    ("vpmovm2d", kmove(false, 0x38, false)), ("vpmovm2q", kmove(true, 0x38, false)),
    ("vpmovb2m", kmove(false, 0x29, true)),  ("vpmovw2m", kmove(true, 0x29, true)),
    ("vpmovd2m", kmove(false, 0x39, true)),  ("vpmovq2m", kmove(true, 0x39, true)),
    ("vcvtdq2pd",  rm(2, 1, false, 0xE6, Half)),
    ("vcvtps2pd",  rm(0, 1, false, 0x5A, Half)),
    ("vcvtdq2ps",  rm(0, 1, false, 0x5B, Full)),
    ("vcvtps2dq",  rm(1, 1, false, 0x5B, Full)),
    ("vcvttps2dq", rm(2, 1, false, 0x5B, Full)),
    ("vsqrtps",    rm(0, 1, false, 0x51, Full)), ("vsqrtpd", rm(1, 1, true, 0x51, Full)),
    ("vmovddup",   rm(3, 1, true,  0x12, Dup)),
    ]
};

/// The EVEX form of `name`, or `None` when the name has none in this table.
/// A name with several rows has one per shape, and `lead_imm` -- whether the
/// operand list leads with an immediate -- picks between them; where no row
/// agrees, the first is returned so [`encode`] reports the shape mismatch.
pub(crate) fn op(name: &str, lead_imm: bool) -> Option<Form> {
    let rows = || TABLE.iter().filter(|r| r.0 == name);
    rows()
        .find(|r| r.1.shape.leads_imm() == lead_imm)
        .or_else(|| rows().next())
        .map(|r| r.1)
}

/// Decode a vector register operand to `(number, vector length in bytes)`.
fn vreg(c: &Concrete) -> Option<(u8, u32)> {
    match *c {
        Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 32).contains(&reg) => {
            Some((reg - XMM_BASE, 16))
        }
        Concrete::Reg { reg, .. } if (YMM_BASE..YMM_BASE + 32).contains(&reg) => {
            Some((reg - YMM_BASE, 32))
        }
        Concrete::Reg { reg, .. } if (ZMM_BASE..ZMM_BASE + 32).contains(&reg) => {
            Some((reg - ZMM_BASE, 64))
        }
        _ => None,
    }
}

/// Whether a register number names something only EVEX encodes: a zmm or a
/// vector register above 15.
pub(crate) fn reg_needs_evex(reg: u8) -> bool {
    (XMM_BASE + 16..XMM_BASE + 32).contains(&reg)
        || (YMM_BASE + 16..YMM_BASE + 32).contains(&reg)
        || (ZMM_BASE..ZMM_BASE + 32).contains(&reg)
}

/// The r/m operand of a form, either a register or a memory reference.
enum Rm {
    Reg(u8),
    Mem(MemRm),
}

/// Emit the 4-byte EVEX prefix. `r`/`x`/`b` are the high (bit 3) parts of
/// ModRM.reg, SIB.index or ModRM.rm bit 4, and ModRM.rm / SIB.base; `r2` and
/// `v2` are bit 4 of ModRM.reg and of vvvv. All are stored inverted.
#[allow(clippy::too_many_arguments)]
fn emit_prefix(
    code: &mut Vec<u8>,
    (r, x, b, r2): (bool, bool, bool, bool),
    map: u8,
    w: bool,
    vvvv: u8,
    ll: u8,
    pp: u8,
    (bcast, v2): (bool, bool),
    (mask, zeroing): (u8, bool),
) {
    code.push(0x62);
    code.push(
        (u8::from(!r) << 7)
            | (u8::from(!x) << 6)
            | (u8::from(!b) << 5)
            | (u8::from(!r2) << 4)
            | (map & 7),
    );
    code.push((u8::from(w) << 7) | ((!vvvv & 0x0F) << 3) | 0x04 | pp);
    code.push(
        (u8::from(zeroing) << 7)
            | (ll << 5)
            | (u8::from(bcast) << 4)
            | (u8::from(!v2) << 3)
            | (mask & 7),
    );
}

/// Encode one EVEX instruction into `code`. Operands are in AT&T order.
pub(crate) fn encode(code: &mut Vec<u8>, f: Form, ops: &[Concrete]) -> Result<(), String> {
    let bad = |m: &str| Err(format!("inline asm: {m}"));
    // Split the operand list per shape into the trailing immediate, the
    // ModRM.reg operand, the EVEX.vvvv operand, and the r/m operand.
    // A move whose AT&T destination is not a vector register runs in the store
    // direction: the vector register stays in ModRM.reg and the opcode changes.
    let store = matches!((f.shape, ops), (Shape::Mov, [_, dst]) if vreg(dst).is_none());
    // `reg_op` is `None` where the form spells an opcode extension in ModRM.reg
    // rather than a register.
    type Split<'a> = (
        Option<i64>,
        Option<&'a Concrete>,
        Option<&'a Concrete>,
        &'a Concrete,
    );
    let (imm, reg_op, vvvv_op, rm_op): Split = match (f.shape, ops) {
        (Shape::Rvm, [src2, src1, dst]) => (None, Some(dst), Some(src1), src2),
        (Shape::RvmI, [Concrete::Imm(i), src2, src1, dst]) => {
            (Some(*i), Some(dst), Some(src1), src2)
        }
        (Shape::Rm | Shape::RmMem, [src, dst]) => (None, Some(dst), None, src),
        (Shape::RmI, [Concrete::Imm(i), src, dst]) => (Some(*i), Some(dst), None, src),
        (Shape::MrI, [Concrete::Imm(i), src, dst]) => (Some(*i), Some(src), None, dst),
        (Shape::VmI(_), [Concrete::Imm(i), src, dst]) => (Some(*i), None, Some(dst), src),
        (Shape::Mov, [src, dst]) if store => (None, Some(src), None, dst),
        (Shape::Mov, [src, dst]) => (None, Some(dst), None, src),
        _ => return bad("EVEX operand count does not match the instruction"),
    };
    // ModRM.reg holds a vector register, an opmask register on a `kreg`
    // form, or the form's opcode extension. An opmask names no vector
    // length, so it contributes none.
    let (reg, reg_vl) = match (reg_op, f.shape) {
        (None, Shape::VmI(digit)) => (digit, None),
        (Some(o), _) if f.kreg => match mask_reg_num(o) {
            Some(n) => (n, None),
            None => return bad("this instruction writes an opmask register"),
        },
        (Some(o), _) => match vreg(o) {
            Some((n, vl)) => (n, Some(vl)),
            None => return bad("EVEX destination must be a vector register"),
        },
        _ => return bad("EVEX operand count does not match the instruction"),
    };
    let (vvvv, vvvv_vl) = match vvvv_op.map(|o| vreg(o).ok_or(())) {
        None => (0, None),
        Some(Ok((n, vl))) => (n, Some(vl)),
        Some(Err(())) => return bad("EVEX second source must be a vector register"),
    };
    // A `gpr_rm` form names a general register where the others name a vector
    // one; a vector-register pair, where the form has one, takes its alternate
    // prefix and opcode.
    let mut pp = f.pp;
    let mut opcode = if store { f.store_op } else { f.opcode };
    if f.shape == Shape::Mov && opcode == 0 {
        return bad("a non-temporal store takes a memory destination");
    }
    let rm = if f.krm {
        match mask_reg_num(rm_op) {
            Some(n) => Rm::Reg(n),
            None => return bad("this instruction reads an opmask register"),
        }
    } else {
        match (vreg(rm_op), MemRm::of(rm_op), rm_op) {
            (Some(_), ..) if f.shape == Shape::RmMem => {
                return bad("this instruction takes a memory source");
            }
            (Some((n, _)), ..) if f.gpr_rm => {
                if f.alt_op == 0 {
                    return bad("this instruction takes a general register or memory");
                }
                (pp, opcode) = (f.alt_pp, f.alt_op);
                Rm::Reg(n)
            }
            (Some((n, _)), ..) => Rm::Reg(n),
            (_, _, &Concrete::Reg { reg, .. }) if f.gpr_rm && reg < 16 => Rm::Reg(reg),
            // A general register in the r/m position of a form that also
            // takes a vector one selects the form's other opcode; EVEX.W
            // fixes the register's width there.
            (_, _, &Concrete::Reg { reg, size }) if f.gpr_op != 0 && reg < 16 => {
                let want = if f.w {
                    AsmRegSize::Quad
                } else {
                    AsmRegSize::Long
                };
                if size != want {
                    return bad(if f.w {
                        "this instruction reads a 64-bit general register"
                    } else {
                        "this instruction reads a 32-bit general register"
                    });
                }
                opcode = f.gpr_op;
                Rm::Reg(reg)
            }
            // A mask <-> vector move has register forms only.
            (_, Some(_), _) if f.kreg && f.shape == Shape::Rm => {
                return bad("this instruction takes a vector register source");
            }
            (_, Some(m), _) => Rm::Mem(m),
            _ => return bad("EVEX source must be a vector register or memory"),
        }
    };
    // The vector length is the widest register the instruction names: an
    // insert or extract states one sub-vector and one full one, and L'L
    // follows the full one.
    let rm_vl = vreg(rm_op).map(|(_, vl)| vl);
    let vl = [reg_vl, vvvv_vl, rm_vl]
        .into_iter()
        .flatten()
        .max()
        .ok_or_else(|| String::from("inline asm: EVEX op names no vector register"))?;
    if vl < u32::from(f.min_vl) {
        return Err(format!(
            "inline asm: this instruction has no {}-bit form",
            vl * 8
        ));
    }
    let ll = match vl {
        16 => 0u8,
        32 => 1,
        _ => 2,
    };
    if f.mask == 0 && f.zeroing {
        return bad("`{z}` needs a `{%k1}`..`{%k7}` write mask");
    }
    if f.kreg && f.zeroing {
        return bad("`{z}` does not apply to an opmask destination");
    }
    // Validate the embedded broadcast against the tuple type: the element
    // count the operand spells must be the number the memory element repeats
    // to fill the form's memory operand.
    if f.bcast != 0 {
        if !f.tuple.broadcasts() {
            return bad("this instruction takes no `{1toN}` broadcast");
        }
        if !matches!(rm, Rm::Mem(_)) {
            return bad("`{1toN}` needs a memory operand");
        }
        let (whole, one) = (
            f.tuple.disp8_n(vl, f.w, false),
            f.tuple.disp8_n(vl, f.w, true),
        );
        if u32::from(f.bcast) != whole / one {
            return bad("`{1toN}` element count does not match the operand");
        }
    }
    let (r, r2) = (reg & 8 != 0, reg & 16 != 0);
    let (x, b) = match rm {
        // A register r/m takes its bit 4 from EVEX.X, which no SIB byte is
        // present to claim.
        Rm::Reg(n) => (n & 16 != 0, n & 8 != 0),
        Rm::Mem(m) => (m.rex_x(), m.rex_b()),
    };
    emit_prefix(
        code,
        (r, x, b, r2),
        f.map,
        f.w,
        vvvv & 0x1F,
        ll,
        pp,
        (f.bcast != 0, vvvv & 16 != 0),
        (f.mask, f.zeroing),
    );
    code.push(opcode);
    match rm {
        Rm::Reg(n) => code.push(0xC0 | ((reg & 7) << 3) | (n & 7)),
        Rm::Mem(m) => m.emit_scaled(code, reg & 7, f.tuple.disp8_n(vl, f.w, f.bcast != 0) as i32),
    }
    if let Some(i) = imm {
        code.push(i as u8);
    }
    Ok(())
}

#[cfg(test)]
mod tests;
