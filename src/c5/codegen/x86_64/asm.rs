//! GCC extended inline-asm (x86_64): template parsing and instruction
//! encoding.
//!
//! [`parse_template`] turns an AT&T template into a sequence of
//! [`AsmInsn`]s with symbolic operand references (`%N`), explicit
//! registers (`%%reg`), immediates (`$imm`), explicit memory references
//! (`disp(%%reg)` / `disp(%N)`), and local labels -- numeric (`1:`,
//! `1b`/`1f`) and named (`name:`, addressable as `name(%%rip)`), with
//! the `%=` escape expanding to a per-instance number. The emitter
//! ([`super::emit`]) resolves each reference to a machine register per
//! the operand constraint, builds a [`Concrete`] operand list, and
//! calls [`encode`]. The SSA interpreter reuses the same parse to
//! evaluate the semantics, so both paths agree on operand order and
//! width.
//!
//! [`encode`] routes the general-purpose and system mnemonics through the
//! shared table encoder ([`super::table`]) via [`to_table`], transposing the
//! AT&T (`src, dst`) operands to the table's Intel (`dst, src`) order. What
//! stays here is what the table does not cover: the double-precision shifts,
//! the port I/O and privileged prefix forms, the MMX and control / debug /
//! segment register moves, and the interrupt / stack ops.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::super::ir::AsmRegSize;
use super::super::ssa::emit_common::AsmSectionItem;
use crate::c5::asm::data_directive_width;

/// Base mnemonic of a template instruction (AT&T size suffix folded
/// out into [`AsmInsn::suffix`]).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Mnemonic {
    Shld,
    Shrd,
    Shl,
    Shr,
    Sar,
    Or,
    And,
    Add,
    Sub,
    Xor,
    Mov,
    Bswap,
    Rdtscp,
    Rdtsc,
    Cpuid,
    Xgetbv,
    Nop,
    /// Port input `in al/ax/eax, dx` (variable-port form). The
    /// accumulator and DX are implicit; the operands' `a`/`d`
    /// constraints tie the values there.
    In,
    /// Port output `out dx, al/ax/eax` (variable-port form).
    Out,
    /// Software interrupt `int $imm` (int3 breakpoint is `int $3`).
    Int,
    /// Spin-loop hint `pause`.
    Pause,
    /// An operandless form whose operand size the mnemonic spells rather than
    /// implies: the flag and general-register stack pushes, whose default size
    /// is the stack's (64-bit in long mode), and the interrupt / far return,
    /// whose default is the mode's operand size. `opw` of `None` takes that
    /// default; another width takes the operand-size prefix, or REX.W for 64.
    SizedNullary {
        opcode: u8,
        opw: Option<u8>,
        stack: bool,
    },
    /// `movd` between an MMX / XMM register and a GPR / memory. The MMX form has
    /// no operand-size prefix; the XMM form (an `xmm` operand) adds the 0x66.
    Movd,
    /// An SSE2 two-operand register form `<op> %xmm_src, %xmm_dst` encoded as
    /// `<prefix> [REX] 0F [38] <opcode> /r` with the destination in ModRM.reg
    /// and the source in ModRM.rm (pxor, paddd, pand, ...). `map` selects the
    /// opcode map (1 = 0F, 2 = 0F 38).
    Sse2Rr {
        prefix: u8,
        map: u8,
        opcode: u8,
    },
    /// An SSE move `mov{dqa,dqu,aps,ups,sd,ss}` between xmm and xmm / memory. The
    /// register-register and load (memory-source) forms use `load_op`; the store
    /// (memory-destination) form uses `store_op`. The xmm register is always
    /// ModRM.reg; the other operand is r/m. A non-temporal move has only one
    /// direction, so the other opcode is `None`. `map` selects the opcode map
    /// (1 = 0F, 2 = 0F 38).
    SseMov {
        prefix: u8,
        load_op: Option<u8>,
        store_op: Option<u8>,
        map: u8,
    },
    /// An SSE two-operand form with a trailing immediate `<op> $imm8, %src,
    /// %dst`, encoded as `<prefix> [REX] 0F [38|3A] <opcode> /r ib`. The vector
    /// operand rides ModRM.reg and the other (a vector register, a general
    /// register, or memory) the r/m: normally the AT&T destination is the
    /// ModRM.reg one, and `store` reverses that for the extract family, whose
    /// destination is the r/m. `map` selects the opcode map, `w` sets REX.W for
    /// the quadword element forms. Covers pshuf{d,lw,hw}, shuf{ps,pd},
    /// palignr, pclmulqdq, pinsr*, pextr*, and sha1rnds4.
    SseRmImm {
        prefix: u8,
        map: u8,
        opcode: u8,
        w: bool,
        store: bool,
    },
    /// A packed shift `<op> $imm8, %xmm` encoded as `66 [REX] 0F <opcode>
    /// /digit ib`: the op rides ModRM.reg as an opcode extension, the
    /// (source = destination) xmm sits in r/m. `var_opcode`, where the shift
    /// has a variable-count member, encodes `<op> %xmm_count, %xmm` as
    /// `66 [REX] 0F <var_opcode> /r`; `pslldq` / `psrldq` have no such member
    /// and leave it absent.
    SseShiftImm {
        opcode: u8,
        digit: u8,
        var_opcode: Option<u8>,
    },
    /// A 3-operand VEX (AVX) op `<v-op> %{x,y}mm_src2, %{x,y}mm_src1,
    /// %{x,y}mm_dst`, encoded `VEX(vvvv=src1, L=ymm, W=w, pp) <map> <opcode>
    /// ModRM(reg=dst, rm=src2)`. `pp` is the SSE-prefix selector (0 none, 1 0x66,
    /// 2 0xF3, 3 0xF2); `map` the opcode map (1 = 0F, 2 = 0F38, 3 = 0F3A). A
    /// 2-byte VEX (C5) is emitted unless src2 is a high register (r8..15), the
    /// map is not 0F, or W is set -- those need the 3-byte form (C4).
    Vex {
        pp: u8,
        map: u8,
        w: bool,
        opcode: u8,
    },
    /// A 2-operand VEX move `v-op %src, %dst` (VEX.vvvv unused). A register or
    /// memory source into a register uses `load_op`; a register into memory uses
    /// `store_op`. Covers vmovups/vmovaps/vmovdqu/vmovdqa (128/256-bit).
    VexMov {
        pp: u8,
        load_op: u8,
        store_op: u8,
    },
    /// `vmovd` / `vmovq`: the VEX forms of `movd` / `movq`, moving the low
    /// lane of an xmm register. `w` selects the 64-bit member.
    VexMovd {
        w: bool,
    },
    /// A 2-operand VEX op `v-op %src, %dst` (VEX.vvvv unused), src a register or
    /// memory operand. Covers vsqrtps/vsqrtpd/vrcpps/vrsqrtps, the packed
    /// int<->float conversions (0F map), and the broadcasts and packed integer
    /// extends (0F38 map). VEX.L follows the destination width.
    Vex2 {
        pp: u8,
        map: u8,
        opcode: u8,
        /// Set for the 128-bit lane broadcasts, whose source under VEX has a
        /// memory form only.
        mem_only: bool,
    },
    /// A 3-operand VEX op with a trailing immediate `v-op $imm8, %src2, %src1,
    /// %dst`. Covers vshufps / vshufpd (0F map) and vperm2f128 / vpblendd /
    /// vpalignr / vinsertf128 (0F3A map).
    VexImm3 {
        pp: u8,
        map: u8,
        opcode: u8,
        /// Set for the `is4` blends, whose leading operand is a vector register
        /// carried in the top four bits of the trailing byte instead of an
        /// immediate: `v-op %mask, %src2, %src1, %dst`.
        is4: bool,
    },
    /// A 2-operand VEX op with a trailing immediate `v-op $imm8, %src, %dst`
    /// (VEX.vvvv unused). Covers vpshufd / vpshuflw / vpshufhw (0F map) and
    /// vpermilps / vpermilpd (0F3A map). `store` reverses the operand roles for
    /// the lane extracts (`vextracti128`), whose destination is the r/m and
    /// whose 256-bit source sets `L`.
    VexImm2 {
        pp: u8,
        map: u8,
        opcode: u8,
        store: bool,
    },
    /// A VEX packed shift by immediate `v-op $imm8, %src, %dst`, encoded
    /// `VEX(vvvv=dst, L, pp=66, 0F) <opcode> /digit ib`: the destination rides
    /// VEX.vvvv, the opcode extension ModRM.reg, and the source ModRM.rm.
    /// `var_opcode`, where the shift has a variable-count member, encodes
    /// `v-op %xmm_count, %src, %dst` as the ordinary 3-operand VEX
    /// `VEX(vvvv=src, L, pp=66, 0F) <var_opcode> ModRM(reg=dst, rm=count)`.
    /// The count is `xmm/m128` at every destination width, so `L` follows the
    /// destination and source alone. `vpslldq` / `vpsrldq` have no such
    /// member and leave it absent.
    VexShiftImm {
        opcode: u8,
        digit: u8,
        var_opcode: Option<u8>,
    },
    /// An operandless VEX form (`vzeroupper` / `vzeroall`): `VEX(L) 0F 77`.
    VexNullary {
        l: u8,
    },
    /// A VEX-encoded general-register op (the BMI / BMI2 set). `src2` rides
    /// ModRM.rm, `dst` ModRM.reg, and `src1` VEX.vvvv -- absent for the
    /// two-operand-plus-immediate `rorx`, whose `imm` is a trailing byte.
    /// VEX.W follows the operand width, VEX.L is zero.
    VexGpr {
        pp: u8,
        map: u8,
        opcode: u8,
        imm: bool,
        /// The AT&T source order is `src2, src1, dst` for the shift-like ops
        /// (`sarx count, src, dst`), whose VEX.vvvv holds the count, and
        /// `src1, src2, dst` for the rest.
        vvvv_first: bool,
    },
    /// A VEX element extract `v-op $imm8, %xmm_src, r/m_dst` (`vpextr*`,
    /// `vextractps`): VEX.128 with the xmm in ModRM.reg and a general register
    /// or memory in r/m, which the instruction writes. `w` selects the quadword
    /// element forms. `reg_form`, where the element has one, is the 0F-map
    /// opcode GNU as prefers for a register destination; that form reverses the
    /// roles, putting the general register in ModRM.reg.
    VexElemExtract {
        map: u8,
        opcode: u8,
        w: bool,
        reg_form: Option<u8>,
    },
    /// A VEX element insert `v-op $imm8, r/m_src, %xmm_src1, %xmm_dst`
    /// (`vpinsr*`): VEX.128 with the destination in ModRM.reg, src1 in
    /// VEX.vvvv, and a general register or memory in r/m.
    VexElemInsert {
        map: u8,
        opcode: u8,
        w: bool,
    },
    /// A VEX-encoded opmask instruction (the `k*` set except `kmov*`): every
    /// operand is an opmask register, with the destination in ModRM.reg, the
    /// r/m source last in AT&T order, and src1 in VEX.vvvv where `vvvv` is
    /// set (the 3-operand forms, which also set VEX.L). The width letter of
    /// the mnemonic fixes `pp` and `w`; `imm` is the shifts' trailing byte.
    MaskOp {
        pp: u8,
        map: u8,
        w: bool,
        opcode: u8,
        l: u8,
        vvvv: bool,
        imm: bool,
    },
    /// `kmov{b,w,d,q}`: an opmask move. The opcode and prefix follow the
    /// operand pair -- 90/91 between opmask and opmask / memory, 92/93
    /// between opmask and a 32/64-bit general register -- so only the width
    /// the size letter names rides the variant.
    Kmov {
        width: u8,
    },
    /// An EVEX-encoded (AVX-512) op. The form carries the opcode fields, the
    /// operand arrangement, the memory tuple type that fixes the compressed
    /// displacement scale, and the `{%kN}` / `{z}` / `{1toN}` decorators the
    /// operand syntax spells. See [`super::evex`].
    Evex(super::evex::Form),
    /// Privileged / model-specific operandless forms (operands, where any,
    /// ride fixed registers via the statement's constraints). `cli` / `sti`
    /// clear / set the interrupt flag; `invd` / `wbinvd` invalidate caches;
    /// `rdmsr` / `wrmsr` / `rdpmc` access MSRs / performance counters;
    /// `monitor` / `mwait` arm the monitor-wait pair.
    Cli,
    Sti,
    Invd,
    Wbinvd,
    Rdmsr,
    Wrmsr,
    Rdpmc,
    Monitor,
    Mwait,
    /// Halt, `hlt`.
    Hlt,
    /// A legacy prefix byte: `lock` (0xF0), `rep` / `repe` / `repz` (0xF3),
    /// `repne` / `repnz` (0xF2). A prefix is a statement of its own
    /// (`repe; cmpsb`) or leads the instruction it applies to on the same
    /// statement (`rep stosw`); the parser emits it as its own entry either
    /// way, so it precedes the operand-size prefix the instruction adds.
    Prefix(u8),
    /// An operandless instruction with a fixed encoding, such as `fninit`.
    Fixed(&'static [u8]),
    /// x87 subtract-and-pop: `fsubp [%st, %st(i)]` encodes DE E0+i under
    /// GNU as operand order; the bare form is `%st, %st(1)`.
    Fsubp,
    /// SSE4.2 accumulate-CRC32 (F2 0F 38 F0 / F1 /r). The accumulator is a
    /// general register in ModR/M.reg and the source the r/m; the AT&T size
    /// suffix is the source width, and only `q` widens the accumulator.
    Crc32,
    /// A string primitive (`movs` / `cmps` / `stos` / `lods` / `scas`). Its
    /// operands are the fixed `%rsi` / `%rdi` / accumulator pair, so the AT&T
    /// size suffix alone picks the opcode and the operand-size prefix.
    StringOp {
        opcode: u8,
        /// Operand width in bytes the size letter names.
        opw: u8,
    },
    /// A single-memory-operand instruction encoded as one opcode byte and a
    /// ModR/M whose reg field is the opcode extension: `fnstsw` / `fnstcw`
    /// (x87 status / control word).
    /// `osz` emits the 0x66 operand-size prefix; REX.W comes from `rex_w`
    /// and REX.B from the base register.
    MemExt {
        opcode: u8,
        ext: u8,
        osz: bool,
        rex_w: bool,
    },
    /// A far branch, `lcall` / `ljmp`. Two forms share the mnemonic: the
    /// indirect `*m16:N` through a ModR/M (FF /3, /5) and the direct
    /// `$seg, $off` immediate pair (9A, EA), which is `ptr16:16` or
    /// `ptr16:32` and has no 64-bit-mode encoding. `opw` is the offset width
    /// the AT&T suffix names, `None` for the mode default; the 0x66 prefix
    /// follows from it and a 64-bit offset takes REX.W.
    FarBranch {
        /// ModR/M.reg extension of the indirect form: 3 `lcall`, 5 `ljmp`.
        ext: u8,
        /// Opcode of the direct form: 0x9A `lcall`, 0xEA `ljmp`.
        far: u8,
        opw: Option<u8>,
    },
    /// A single-memory-operand instruction on the 0F map, the ModR/M reg field
    /// carrying the opcode extension: `cmpxchg16b` (REX.W 0F C7 /1), `ldmxcsr`
    /// / `stmxcsr` (0F AE /2, /3). REX.W comes from `rex_w`, REX.B from the
    /// base register.
    MemExt0F {
        opcode: u8,
        ext: u8,
        rex_w: bool,
    },
    /// A 0F38-map instruction reading a 128-bit memory operand into a general
    /// register held in ModR/M.reg: `invpcid` / `invvpid` (66 0F 38 82 / 81
    /// /r). The 0x66 prefix is mandatory and the operand size fixed, so there
    /// is no REX.W; REX.R extends the register, REX.B the base.
    InvMem {
        opcode: u8,
    },
    /// `xadd r, r/m` (0F C0/C1): exchange-and-add, the atomic primitive of
    /// the interlocked increment / decrement.
    Xadd,
    /// `cmpxchg r, r/m` (0F B0/B1): compare-and-exchange against the
    /// accumulator, the atomic primitive of interlocked compare-exchange.
    Cmpxchg,
    /// `inc r/m` / `dec r/m` (FF /0, /1). The single-byte 0x40+r forms are
    /// REX prefixes in 64-bit mode, so the ModRM forms are always used.
    Inc,
    Dec,
    /// Literal machine bytes, carried in [`AsmInsn::bytes`]. Produced for a
    /// template piece that is a run of hex-byte tokens (`CC; C3; 90`) or a
    /// `.byte` / `.word` / `.long` / `.quad` directive. An escape hatch for
    /// instructions the mnemonic catalogue does not cover; the bytes are
    /// emitted verbatim.
    RawBytes,
    /// A `.byte`-family data directive whose arguments reference operands
    /// (`.long %c0`), so the values resolve at emit time. The payload is the
    /// element width in bytes; the operands are the directive arguments.
    Data(u8),
    /// `.skip count, fill`: emit `count` bytes of `fill`. `count` is a
    /// constant expression over template and section labels, resolved at emit
    /// time (an ALTERNATIVE pads its old site to the replacement length). The
    /// expression text is carried in [`AsmInsn::sym_exprs`] and the fill byte
    /// in [`AsmInsn::bytes`].
    Skip,
    /// A general-purpose / system mnemonic recognized straight from the
    /// catalogue, not one of the bespoke forms above. The string is the
    /// catalogue mnemonic; [`encode`] routes it through the table encoder with
    /// a generic AT&T-to-Intel operand transpose. This is what lets inline asm
    /// reach every instruction the table encodes without a per-mnemonic arm.
    Table(&'static str),
    /// An AT&T zero/sign-extending move spelling source and destination
    /// widths (`movzbl` = `movzx r32, r/m8`, `movslq` = `movsxd r64,
    /// r/m32`). `name` is the catalogue's Intel mnemonic; the source width
    /// is applied to the r/m operand before the table encode, since AT&T
    /// syntax carries it only in the mnemonic.
    ExtMov {
        name: &'static str,
        src: AsmRegSize,
    },
}

/// One symbolic operand of a template instruction.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AsmOpnd {
    /// `%N` / `%<size>N`: operand N of the asm statement, at the named
    /// register-name size (or the operand's own width when unmodified).
    Ref { idx: u8, size: Option<AsmRegSize> },
    /// `%cN` / `%PN`: operand N substituted as a bare constant (`%c`) or a
    /// bare symbol / constant address (`%P`), without the `$` immediate
    /// syntax. Valid on an `i`-class operand; the emitter resolves a
    /// compile-time constant to an immediate and an address value to the
    /// operand's captured value (`lea` / `call` / `jmp` positions).
    RefConst { idx: u8, symbolic: bool },
    /// `%%reg`: an explicit register named in the template.
    Reg { reg: u8, size: AsmRegSize },
    /// `%ah` / `%ch` / `%dh` / `%bh`, held as the ModRM field value 4..8.
    HighReg(u8),
    /// `$imm`: a literal immediate.
    Imm(i64),
    /// `disp(%%reg)` / `disp(%N)`: an explicit memory reference written in
    /// the template -- a byte displacement off a 64-bit base register (named
    /// directly or through a register-class operand reference), with an
    /// optional scaled index (`disp(%%base, %%index, scale)`).
    Mem {
        base: AsmMemBase,
        index: Option<AsmMemBase>,
        scale: u8,
        disp: i32,
    },
    /// An absolute address with no base register: a bare displacement, written
    /// as a literal (`%%gs:0x28`, `movl %eax, 0x1234`) or as a symbol
    /// expression (`btsl $0, tr_lock`). `sym` names the instruction's
    /// displacement expression by index; otherwise `disp` is the whole
    /// address.
    AbsMem { disp: i32, sym: Option<u8> },
    /// `%cN` / `%PN` as a bare instruction operand (`%%gs:%c1`, `movq %c1, %0`):
    /// a memory reference whose displacement is the substituted operand -- AT&T
    /// marks an immediate with `$`. The emitter resolves a compile-time constant
    /// to the absolute disp32 form and a link-time address to a RIP-relative
    /// relocation.
    AbsMemRef { idx: u8, symbolic: bool },
    /// `disp(,%%index,scale)`: a scaled-index memory reference with no base
    /// register (SIB base=101, mod=00, disp32). `sym` names the instruction's
    /// displacement expression by index, taken as an absolute reference;
    /// otherwise `disp` is a literal.
    IndexMem {
        index: AsmMemBase,
        scale: u8,
        disp: i32,
        sym: Option<u8>,
    },
    /// `sym(%%base)` / `disp+sym(%%base, %%index, scale)`: a based memory
    /// reference whose displacement is the instruction's expression named by
    /// `expr`. Taken as an absolute reference through a disp32 relocation.
    SymMem {
        base: AsmMemBase,
        index: Option<AsmMemBase>,
        scale: u8,
        expr: u8,
    },
    /// `sym(%%rip)` / `(sym - 1b)(%%rip)`: a RIP-relative reference whose
    /// displacement is the instruction's expression named by `expr`. The
    /// disp32 field takes a PC-relative relocation against what the
    /// expression leaves symbolic.
    SymRipRel { expr: u8 },
    /// `%cN(%%rip)` / `%PN(%%rip)`: a RIP-relative memory reference whose
    /// displacement is an `i`-class operand substituted as a bare constant
    /// (`%c`) or a symbol / constant address (`%P`). The emitter resolves a
    /// compile-time constant to the disp32 literal and a link-time address to
    /// a RIP-relative relocation.
    RipRelRef { idx: u8, symbolic: bool },
    /// `disp(%%rip)` with a literal numeric displacement (`lea 0(%%rip), %0`
    /// in `_THIS_IP_`): the effective address is `rip + disp`, a self-relative
    /// computation the CPU performs at run time with no relocation. Distinct
    /// from [`AsmOpnd::LabelAddr`] (a template label) and from a `%a` / `%c`
    /// symbolic RIP-relative reference (which carries a relocation).
    RipRel { disp: i32 },
    /// `Nf` / `Nb`: a local-label reference (label number plus direction --
    /// `f` forward, `b` backward), the target of a `jmp` / `jcc` within the
    /// block. The emitter resolves it to a rel32 against the label definition.
    /// Named labels carry `NAMED_LABEL_BASE + intern-index` (direction is
    /// ignored: a name has exactly one definition).
    Label { num: u32, forward: bool },
    /// `LABEL(%%rip)`: the address of a template-local label, the source of a
    /// `lea`. Resolved to a RIP-relative rel32 against the label definition.
    LabelAddr { num: u32, forward: bool },
    /// `$LABEL`: the address of a template-local label as an absolute
    /// immediate (`pushq $1f`). The value is a link-time address even though
    /// the label shares `.text` with the reference, so the emitter zeroes the
    /// imm32 field and records an absolute relocation against the label's
    /// text offset. `num` / `forward` follow [`AsmOpnd::Label`].
    ImmLabel { num: u32, forward: bool },
    /// `$expr`: a symbol expression as an absolute immediate (`pushq
    /// $arch_rethook_trampoline`, `movw $_end+3, %cx`, `addq $(a - b)`).
    /// `expr` names the instruction's expression by index; the emitter zeroes
    /// the immediate field and either folds the expression into it or records
    /// an absolute relocation of the field's width.
    ImmSym { expr: u8 },
    /// `%lK`: an `asm goto` label reference by label-list index (the
    /// frontend canonicalizes `%l[name]` and operand-relative `%lN` to
    /// this form). The emitter branches to the label's target block.
    GotoLabel(u8),
}

/// Base register of an explicit template memory operand.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum AsmMemBase {
    /// An explicit `%%reg` (architectural GP number) at the width it was
    /// written, which selects the instruction's address size.
    Reg { num: u8, size: AsmRegSize },
    /// An operand reference `%N`; the emitter substitutes its assigned
    /// register.
    Ref(u8),
}

/// One instruction of a parsed template, in AT&T operand order.
#[derive(Debug, Clone)]
pub(crate) struct AsmInsn {
    pub mnemonic: Mnemonic,
    pub suffix: Option<AsmRegSize>,
    /// Segment-override prefix byte (0x64 `%%fs:`, 0x65 `%%gs:`) written on
    /// the instruction's memory operand; emitted before the opcode.
    pub seg: Option<u8>,
    /// REX byte of a `rex[.WRXB]` prefix leading the instruction on its own
    /// statement; merged into the instruction's own REX byte.
    pub rex: Option<u8>,
    pub operands: Vec<AsmOpnd>,
    /// Literal bytes for a [`Mnemonic::RawBytes`] piece; empty otherwise.
    pub bytes: Vec<u8>,
    /// Symbol expressions the instruction's relocatable fields take, named by
    /// index from the operands that carry one. A direct `call` / `jmp` /
    /// `jcc` to a bare identifier (`call schedule`) has no operands and puts
    /// its target here alone, as does a `.skip` count. An x86 instruction
    /// relocates its displacement and its immediate independently, so it may
    /// carry two (`movq $.Lresume, saved_rip(%rip)`).
    pub sym_exprs: Vec<alloc::string::String>,
    /// A local-label definition `N:` at this point; the emitter records the
    /// code offset it stands at. Such a piece carries no mnemonic operands.
    pub label_def: Option<u32>,
    /// A layout directive, which moves the location counter instead of
    /// encoding: the section engine's parse of it, laid down by the emitter.
    /// The piece carries no mnemonic.
    pub layout: Option<AsmSectionItem>,
}

/// A resolved operand: a concrete register (with its access size) or an
/// immediate. Produced by the emitter / interpreter from an [`AsmOpnd`]
/// once the operand's register assignment (or constant value) is known.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum Concrete {
    Reg {
        reg: u8,
        size: AsmRegSize,
    },
    /// A legacy high-byte register `%ah` / `%ch` / `%dh` / `%bh`, carried by
    /// its ModRM field value 4..8. Not a `Reg`: those field values mean
    /// `spl` / `bpl` / `sil` / `dil` under a REX prefix, so the two are
    /// distinct operand classes and no form carrying a REX can name one.
    HighReg(u8),
    /// A memory reference `disp(%base)` / `disp(%base, %index, scale)`:
    /// `base` holds the address, `disp` a byte displacement (0 for a
    /// memory-constrained `m` template operand).
    Mem {
        base: u8,
        index: Option<u8>,
        scale: u8,
        disp: i32,
        size: AsmRegSize,
    },
    /// An absolute displacement (`%%gs:0x28`), addressed with no base
    /// register; meaningful under a segment override.
    AbsMem {
        disp: i32,
        size: AsmRegSize,
    },
    /// A scaled-index memory reference with no base register
    /// (`disp(,%index,scale)`): SIB base=101, mod=00, disp32. `disp` is a
    /// literal or a relocation-patched symbol offset (the reloc rides the
    /// emitter side, not this operand).
    IndexMem {
        index: u8,
        scale: u8,
        disp: i32,
        size: AsmRegSize,
    },
    /// A RIP-relative reference `disp(%rip)` to a link-time symbol address:
    /// a `%a`-modified `i`-class operand naming `&global` (the x86 percpu
    /// `%%gs:%a[var]` shape). `disp` is the in-instruction displacement (0;
    /// the symbol resolves through a relocation the emitter records at the
    /// disp32 field). The reloc target and addend ride the emitter side, not
    /// this operand.
    RipRel {
        disp: i32,
        size: AsmRegSize,
    },
    Imm(i64),
}

/// Reject any `%N` template reference past the end of the operand list.
/// Both the native emitter and the interpreter index the operand list by
/// a reference's number, so the bound is checked once, up front.
pub(crate) fn check_operand_refs(insns: &[AsmInsn], n_operands: usize) -> Result<(), String> {
    for insn in insns {
        for o in &insn.operands {
            if let AsmOpnd::Ref { idx, .. } = *o
                && idx as usize >= n_operands
            {
                return Err(alloc::format!(
                    "inline asm: `%{idx}` names no operand ({n_operands} operands)"
                ));
            }
        }
    }
    Ok(())
}

/// Map the condition suffix of a `=@cc<cond>` flag-output constraint to
/// its x86_64 condition-code nibble (the value shared by `Jcc`, `SETcc`
/// and `CMOVcc`). Covers the synonym spellings GCC accepts.
pub(crate) fn flag_cond_code(cond: &str) -> Option<u8> {
    Some(match cond {
        "o" => 0x0,
        "no" => 0x1,
        "b" | "c" | "nae" => 0x2,
        "ae" | "nb" | "nc" => 0x3,
        "e" | "z" => 0x4,
        "ne" | "nz" => 0x5,
        "be" | "na" => 0x6,
        "a" | "nbe" => 0x7,
        "s" => 0x8,
        "ns" => 0x9,
        "p" | "pe" => 0xA,
        "np" | "po" => 0xB,
        "l" | "nge" => 0xC,
        "ge" | "nl" => 0xD,
        "le" | "ng" => 0xE,
        "g" | "nle" => 0xF,
        _ => return None,
    })
}

/// AT&T names of the 16 GPRs, indexed by architectural number, per access
/// size. The 8-bit row uses the REX-form low-byte names for rsp/rbp/rsi/rdi.
const GPR_Q: [&str; 16] = [
    "rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi", "r8", "r9", "r10", "r11", "r12", "r13",
    "r14", "r15",
];
const GPR_D: [&str; 16] = [
    "eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi", "r8d", "r9d", "r10d", "r11d", "r12d",
    "r13d", "r14d", "r15d",
];
const GPR_W: [&str; 16] = [
    "ax", "cx", "dx", "bx", "sp", "bp", "si", "di", "r8w", "r9w", "r10w", "r11w", "r12w", "r13w",
    "r14w", "r15w",
];
const GPR_B: [&str; 16] = [
    "al", "cl", "dl", "bl", "spl", "bpl", "sil", "dil", "r8b", "r9b", "r10b", "r11b", "r12b",
    "r13b", "r14b", "r15b",
];
/// Legacy high-byte registers, indexed by ModRM field value minus 4.
pub(crate) const GPR_HB: [&str; 4] = ["ah", "ch", "dh", "bh"];

/// ModRM field value of a legacy high-byte register name. Kept out of
/// [`reg_by_name`]: those field values also name the REX-only low-byte
/// registers, so the two are separate operand classes.
pub(crate) fn high_byte_reg_by_name(name: &str) -> Option<u8> {
    GPR_HB.iter().position(|&r| r == name).map(|i| i as u8 + 4)
}

/// AT&T name (without the `%` prefix) of a GPR by architectural number and
/// byte width, the inverse of the width tables in [`reg_by_name`]. `None` for
/// a width other than 1/2/4/8 or a number outside 0..16.
pub(crate) fn gpr_att_name(num: u8, width: u8) -> Option<&'static str> {
    let table = match width {
        8 => &GPR_Q,
        4 => &GPR_D,
        2 => &GPR_W,
        1 => &GPR_B,
        _ => return None,
    };
    table.get(num as usize).copied()
}

const BAD_VMOV_OPND: &str = "inline asm: `vmovd`/`vmovq` operand must be a \
register or memory";

/// Operand for a register named in a template, covering both register
/// classes an 8-bit name can denote.
fn named_reg_operand(name: &str) -> Option<AsmOpnd> {
    match reg_by_name(name) {
        Some((reg, size)) => Some(AsmOpnd::Reg { reg, size }),
        None => high_byte_reg_by_name(name).map(AsmOpnd::HighReg),
    }
}

/// Map an AT&T register name (without the `%` prefix) to its
/// architectural number and access size. Covers the 8/16/32/64-bit
/// names for the 16 GPRs.
pub(crate) fn reg_by_name(name: &str) -> Option<(u8, AsmRegSize)> {
    use AsmRegSize::*;
    let n = name;
    if let Some(i) = GPR_Q.iter().position(|&r| r == n) {
        return Some((i as u8, Quad));
    }
    if let Some(i) = GPR_D.iter().position(|&r| r == n) {
        return Some((i as u8, Long));
    }
    if let Some(i) = GPR_W.iter().position(|&r| r == n) {
        return Some((i as u8, Word));
    }
    if let Some(i) = GPR_B.iter().position(|&r| r == n) {
        return Some((i as u8, Byte));
    }
    // MMX registers mm0..mm7. Marked with register numbers 16..24 so they
    // never collide with the 0..16 GPRs; only `movd` reads them, masking
    // the mark back to the 0..8 ModRM.reg field.
    if let Some(rest) = n.strip_prefix("xmm")
        && let Ok(i) = rest.parse::<u8>()
        && i < 32
    {
        // XMM registers, marked with XMM_BASE so they never collide with the
        // GPRs/MMX; the SSE encode arms mask back to the ModRM field and set
        // REX.R/REX.B for xmm8..15. The size marker is unused (the mnemonic
        // fixes the operation width). xmm16..31 exist only under EVEX.
        return Some((XMM_BASE + i, Quad));
    }
    if let Some(rest) = n.strip_prefix("ymm")
        && let Ok(i) = rest.parse::<u8>()
        && i < 32
    {
        // YMM registers, marked with YMM_BASE; the VEX encode arm reads the mark
        // to set the 256-bit `L` bit and masks back to the ModRM / vvvv field.
        return Some((YMM_BASE + i, Quad));
    }
    if let Some(rest) = n.strip_prefix("zmm")
        && let Ok(i) = rest.parse::<u8>()
        && i < 32
    {
        return Some((ZMM_BASE + i, Quad));
    }
    if let Some(rest) = n.strip_prefix("mm")
        && let Ok(i) = rest.parse::<u8>()
        && i < 8
    {
        return Some((16 + i, Quad));
    }
    if n == "st" {
        return Some((ST_BASE, Quad));
    }
    if let Some(rest) = n.strip_prefix("st(")
        && let Some(d) = rest.strip_suffix(')')
        && let Ok(i) = d.parse::<u8>()
        && i < 8
    {
        return Some((ST_BASE + i, Quad));
    }
    // Control (cr0..cr15) and debug (db0..db7) registers, marked with the
    // bases below so they never collide with the GPRs. Only `mov` reads /
    // writes them, masking the mark back to the 0..16 ModRM.reg field. They
    // are inherently 64-bit in long mode. AT&T syntax spells the debug
    // registers `db0..db7` (the GAS canonical form) or `dr0..dr7`; both name
    // DR0..DR7.
    if let Some(rest) = n.strip_prefix("cr")
        && let Ok(i) = rest.parse::<u8>()
        && i < 16
    {
        return Some((CR_BASE + i, Quad));
    }
    if let Some(rest) = n.strip_prefix("db").or_else(|| n.strip_prefix("dr"))
        && let Ok(i) = rest.parse::<u8>()
        && i < 8
    {
        return Some((DR_BASE + i, Quad));
    }
    // Segment registers, marked with SEG_BASE + the architectural Sreg code
    // (ES=0, CS=1, SS=2, DS=3, FS=4, GS=5) used as the ModRM.reg field of the
    // `mov Sreg, r/m` (8C) / `mov r/m, Sreg` (8E) forms.
    let seg = ["es", "cs", "ss", "ds", "fs", "gs"];
    if let Some(i) = seg.iter().position(|&r| r == n) {
        return Some((SEG_BASE + i as u8, Word));
    }
    None
}

/// The register number a `reg_by_name` result carries for `mm0`; MMX
/// registers occupy `MMX_BASE..MMX_BASE+8`.
const MMX_BASE: u8 = 16;
/// XMM registers occupy `XMM_BASE..XMM_BASE+32`, clear of the GPR/MMX/CR/DR/SEG
/// marks below.
pub(crate) const XMM_BASE: u8 = 64;
/// YMM registers (AVX 256-bit) occupy `YMM_BASE..YMM_BASE+32`. A VEX-encoded op
/// reads the mark to set the `L` bit (256-bit) and masks back to the low xmm
/// number for ModRM / VEX.vvvv.
pub(crate) const YMM_BASE: u8 = 96;
/// ZMM registers (AVX-512 512-bit) occupy `ZMM_BASE..ZMM_BASE+32`; only EVEX
/// encodes them.
pub(crate) const ZMM_BASE: u8 = 136;
/// Opmask registers `k0`..`k7` occupy `MASK_BASE..MASK_BASE+8`.
pub(crate) const MASK_BASE: u8 = 168;
/// Control / debug / segment registers occupy the ranges below; each is
/// marked so it never collides with the 0..16 GPRs or the MMX marks.
const CR_BASE: u8 = 24;
/// x87 stack registers st / st(0)..st(7), marked so they never collide
/// with the GPR/MMX codes; only the x87 register-form arms read them.
const ST_BASE: u8 = 128;
const DR_BASE: u8 = 40;
const SEG_BASE: u8 = 48;

/// The number of an opmask register `kN`. Opmasks are deliberately absent from
/// [`reg_by_name`]: under a single `%` their spelling collides with GCC's
/// `%k<N>` operand modifier, which selects the 32-bit form of operand N and is
/// what kernel inline asm means by it. In extended asm they reach the encoder
/// as `%%kN` operands and through the `{%kN}` write-mask decorator; only the
/// file-scope parse, where basic asm makes a single `%` a register sigil,
/// reads `%kN` as a register.
fn mask_by_name(name: &str) -> Option<u8> {
    let rest = name.strip_prefix('k')?;
    rest.parse::<u8>().ok().filter(|&i| i < 8)
}

/// Whether a register number names an opmask register.
pub(crate) fn is_mask_reg(reg: u8) -> bool {
    (MASK_BASE..MASK_BASE + 8).contains(&reg)
}

/// The opmask number of a resolved operand, or `None`.
pub(crate) fn mask_reg_num(c: &Concrete) -> Option<u8> {
    match *c {
        Concrete::Reg { reg, .. } if is_mask_reg(reg) => Some(reg - MASK_BASE),
        _ => None,
    }
}

/// Operand for an opmask register named in a template. The size marker is
/// unused: the mnemonic's width letter fixes the operation width.
fn mask_reg_operand(name: &str) -> Option<AsmOpnd> {
    mask_by_name(name).map(|k| AsmOpnd::Reg {
        reg: MASK_BASE + k,
        size: AsmRegSize::Quad,
    })
}

/// Assign an x86 register number to each register operand of an
/// extended-asm statement, per its constraint. Returns a vector
/// parallel to `operands`: `Some(reg)` for a register operand, `None`
/// for a pure immediate. Fixed and matching constraints take their
/// required register; `r` operands take free registers from a fixed
/// pool (never r10 / r11, which the emitter reserves as bridge scratch,
/// nor rsp / rbp, nor any GP register named in the clobber list).
/// Shared by the emitter and the interpreter so both resolve the
/// template's `%N` references to the same registers.
pub(crate) fn assign_operand_regs(
    operands: &[crate::c5::ir::AsmOperand],
    clobber_regs: u32,
    clobber_fp_regs: u32,
) -> Result<Vec<Option<u8>>, String> {
    use crate::c5::ir::AsmConstraint as C;
    let mut assigned: Vec<Option<u8>> = alloc::vec![None; operands.len()];
    let mut used = [false; 16];
    // Fixed / bound / register-or-immediate operands take their named
    // register.
    for (i, op) in operands.iter().enumerate() {
        if let C::Fixed(r) | C::Bound(r) | C::RegOrImm(r) = op.constraint {
            assigned[i] = Some(r);
            used[r as usize] = true;
        }
    }
    // A clobbered GP register is unavailable for an operand: the template
    // overwrites it, so an operand placed there would be corrupted. Marked
    // after the fixed operands, whose register may itself be clobbered.
    for r in 0..16u8 {
        if clobber_regs & (1 << r) != 0 {
            used[r as usize] = true;
        }
    }
    // `r` operands take free pool registers; a memory operand takes one too, to
    // hold its address, and a flag output one to receive its `setcc` result.
    // Every pool register is byte addressable under REX, as `setcc` requires.
    // rbx and r12..r15 are callee-saved but usable: the emitter saves and
    // restores every operand register in the frame's asm scratch region, so a
    // callee-saved register is preserved across the block. rsp / rbp / r10 /
    // r11 are excluded (stack pointer, frame pointer the scratch region is
    // addressed through, and the emitter's own bridge scratch).
    let pool = [0u8, 3, 1, 2, 6, 7, 8, 9, 12, 13, 14, 15];
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Reg | C::Mem | C::Flags(_)) {
            let r = pool
                .iter()
                .copied()
                .find(|&r| !used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of registers for operands"))?;
            used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    // `x` operands take an XMM register (xmm0..15). The GP and XMM files are
    // independent, so a number here does not clash with a GP assignment; the
    // emitter tells them apart by the operand's constraint. Skip any xmm named
    // in the clobber list.
    let mut fp_used = [false; 16];
    for r in 0..16u8 {
        if clobber_fp_regs & (1 << r) != 0 {
            fp_used[r as usize] = true;
        }
    }
    for (i, op) in operands.iter().enumerate() {
        if matches!(op.constraint, C::Fp) {
            let r = (0u8..16)
                .find(|&r| !fp_used[r as usize])
                .ok_or_else(|| String::from("inline asm: out of XMM registers for operands"))?;
            fp_used[r as usize] = true;
            assigned[i] = Some(r);
        }
    }
    // Matching constraints alias the register of the operand they name
    // (an earlier output, already assigned above).
    for i in 0..operands.len() {
        if let C::Match(n) = operands[i].constraint {
            let r = assigned.get(n as usize).copied().flatten().ok_or_else(|| {
                String::from("inline asm: matching constraint on a non-register operand")
            })?;
            assigned[i] = Some(r);
        }
    }
    Ok(assigned)
}

/// Known base mnemonic for a template token, if any.
/// The string primitives as `(base name, byte-form opcode, has-quad-form)`.
/// Their operands are the fixed string-pointer, accumulator, and `%dx` port
/// registers, so the whole encoding is the opcode plus an operand-size prefix:
/// the byte form is the opcode itself, and the wider forms are `opcode + 1`
/// under 0x66 (word) or REX.W (quad). The size always comes from the AT&T
/// suffix, which is part of the name here rather than a separate suffix, so
/// `movsbl` stays a sign-extending move and never parses as `movsb` plus a
/// long suffix. The port-I/O members `ins` / `outs` have no 64-bit form (port
/// width is at most 32 bits), hence no quad suffix.
const STRING_OPS: &[(&str, u8, bool)] = &[
    ("movs", 0xA4, true),
    ("cmps", 0xA6, true),
    ("stos", 0xAA, true),
    ("lods", 0xAC, true),
    ("scas", 0xAE, true),
    ("ins", 0x6C, false),
    ("outs", 0x6E, false),
];

/// An operandless form whose AT&T spelling names its operand size.
fn sized_nullary(name: &str) -> Option<Mnemonic> {
    let (base, opw) = match name.as_bytes().last() {
        Some(b'w') => (&name[..name.len() - 1], Some(2)),
        Some(b'l' | b'd') => (&name[..name.len() - 1], Some(4)),
        Some(b'q') => (&name[..name.len() - 1], Some(8)),
        _ => (name, None),
    };
    let (opcode, stack) = match base {
        "pushf" => (0x9C, true),
        "popf" => (0x9D, true),
        "pusha" => (0x60, true),
        "popa" => (0x61, true),
        "iret" => (0xCF, false),
        "lret" => (0xCB, false),
        _ => return None,
    };
    Some(Mnemonic::SizedNullary { opcode, opw, stack })
}

fn string_op(name: &str) -> Option<Mnemonic> {
    let (base, suffix) = name.split_at(name.len().checked_sub(1)?);
    let &(_, op, quad) = STRING_OPS.iter().find(|(n, ..)| *n == base)?;
    let (opcode, opw) = match suffix {
        "b" => (op, 1),
        "w" => (op + 1, 2),
        "l" => (op + 1, 4),
        "q" if quad => (op + 1, 8),
        _ => return None,
    };
    Some(Mnemonic::StringOp { opcode, opw })
}

fn mnemonic_by_name(name: &str) -> Option<Mnemonic> {
    // The flag / general-register stack pushes and the interrupt / far return
    // spell their operand size in the mnemonic and take no operands; the
    // catalogue is generated for long mode and carries only some of the
    // spellings, so all of them resolve here.
    if let Some(m) = sized_nullary(name) {
        return Some(m);
    }
    Some(match name {
        "shld" => Mnemonic::Shld,
        "shrd" => Mnemonic::Shrd,
        "shl" | "sal" => Mnemonic::Shl,
        "shr" => Mnemonic::Shr,
        "sar" => Mnemonic::Sar,
        "or" => Mnemonic::Or,
        "and" => Mnemonic::And,
        "add" => Mnemonic::Add,
        "sub" => Mnemonic::Sub,
        "xor" => Mnemonic::Xor,
        "mov" => Mnemonic::Mov,
        "bswap" => Mnemonic::Bswap,
        "rdtscp" => Mnemonic::Rdtscp,
        "rdtsc" => Mnemonic::Rdtsc,
        "cpuid" => Mnemonic::Cpuid,
        "xgetbv" => Mnemonic::Xgetbv,
        "nop" => Mnemonic::Nop,
        "in" => Mnemonic::In,
        "out" => Mnemonic::Out,
        "int" => Mnemonic::Int,
        "pause" => Mnemonic::Pause,
        "movd" => Mnemonic::Movd,
        "cli" => Mnemonic::Cli,
        "sti" => Mnemonic::Sti,
        "invd" => Mnemonic::Invd,
        "wbinvd" => Mnemonic::Wbinvd,
        // TLB / PCID / VPID invalidation reading a 128-bit descriptor in memory
        // into a register (66 0F 38 82 / 81 /r).
        "invpcid" => Mnemonic::InvMem { opcode: 0x82 },
        "invvpid" => Mnemonic::InvMem { opcode: 0x81 },
        "invept" => Mnemonic::InvMem { opcode: 0x80 },
        "rdmsr" => Mnemonic::Rdmsr,
        "wrmsr" => Mnemonic::Wrmsr,
        "rdpmc" => Mnemonic::Rdpmc,
        "monitor" => Mnemonic::Monitor,
        "mwait" => Mnemonic::Mwait,
        "hlt" => Mnemonic::Hlt,
        "lock" => Mnemonic::Prefix(0xF0),
        "rep" | "repe" | "repz" => Mnemonic::Prefix(0xF3),
        "repne" | "repnz" => Mnemonic::Prefix(0xF2),
        // Segment overrides lead the instruction they apply to, the same
        // shape as `lock` / `rep`. The name is a register only in an operand
        // position, which this table is never consulted for. `es` and `ss`
        // are omitted: 64-bit mode ignores them and GNU as rejects both.
        "cs" => Mnemonic::Prefix(0x2E),
        "ds" => Mnemonic::Prefix(0x3E),
        "fs" => Mnemonic::Prefix(0x64),
        "gs" => Mnemonic::Prefix(0x65),
        // Protection-key register write (the read form is catalogued).
        "wrpkru" => Mnemonic::Fixed(&[0x0F, 0x01, 0xEF]),
        "crc32" => Mnemonic::Crc32,
        "fninit" => Mnemonic::Fixed(&[0xDB, 0xE3]),
        // x87 wait-for-pending-exceptions (WAIT/FWAIT) and clear-exceptions.
        "fwait" | "wait" => Mnemonic::Fixed(&[0x9B]),
        "fnclex" => Mnemonic::Fixed(&[0xDB, 0xE2]),
        // MMX state clear.
        "emms" => Mnemonic::Fixed(&[0x0F, 0x77]),
        // x87 subtract-and-pop register form; AT&T operand order (GNU as
        // encodes `fsubp %st, %st(i)` as DE E0+i).
        "fsubp" => Mnemonic::Fsubp,
        // x87 store status / control word to memory (DD /7, D9 /7).
        "fnstsw" => Mnemonic::MemExt {
            opcode: 0xDD,
            ext: 7,
            osz: false,
            rex_w: false,
        },
        "fnstcw" => Mnemonic::MemExt {
            opcode: 0xD9,
            ext: 7,
            osz: false,
            rex_w: false,
        },
        // x87 divide / multiply by a 64-bit float in memory (DC /6, DC /1)
        // and integer store-and-pop to a 32-bit memory slot (DB /3).
        "fdivl" => Mnemonic::MemExt {
            opcode: 0xDC,
            ext: 6,
            osz: false,
            rex_w: false,
        },
        "fmull" => Mnemonic::MemExt {
            opcode: 0xDC,
            ext: 1,
            osz: false,
            rex_w: false,
        },
        "fistpl" => Mnemonic::MemExt {
            opcode: 0xDB,
            ext: 3,
            osz: false,
            rex_w: false,
        },
        "fildl" => Mnemonic::MemExt {
            opcode: 0xDB,
            ext: 0,
            osz: false,
            rex_w: false,
        },
        // x87 load / store-and-pop of a 64-bit float in memory (DD /0, DD /3);
        // the AT&T `l` suffix selects the m64 operand.
        "fldl" => Mnemonic::MemExt {
            opcode: 0xDD,
            ext: 0,
            osz: false,
            rex_w: false,
        },
        "fstpl" => Mnemonic::MemExt {
            opcode: 0xDD,
            ext: 3,
            osz: false,
            rex_w: false,
        },
        // SSE control/status register load / store (0F AE /2, /3).
        "ldmxcsr" => Mnemonic::MemExt0F {
            opcode: 0xAE,
            ext: 2,
            rex_w: false,
        },
        "stmxcsr" => Mnemonic::MemExt0F {
            opcode: 0xAE,
            ext: 3,
            rex_w: false,
        },
        // Far branch: FF /3 indirect and 9A direct for `lcall`, FF /5 and EA
        // for `ljmp`. The AT&T suffix sets the offset width, absent it the
        // mode default.
        "lcall" | "lcallw" | "lcalll" | "lcallq" | "ljmp" | "ljmpw" | "ljmpl" | "ljmpq" => {
            let (ext, far, sfx) = match name.strip_prefix("lcall") {
                Some(s) => (3, 0x9A, s),
                None => (5, 0xEA, &name["ljmp".len()..]),
            };
            Mnemonic::FarBranch {
                ext,
                far,
                opw: match sfx {
                    "w" => Some(2),
                    "l" => Some(4),
                    "q" => Some(8),
                    _ => None,
                },
            }
        }
        "xadd" => Mnemonic::Xadd,
        "cmpxchg" => Mnemonic::Cmpxchg,
        // 128-bit compare-and-exchange against rDX:rAX (REX.W 0F C7 /1).
        "cmpxchg16b" => Mnemonic::MemExt0F {
            opcode: 0xC7,
            ext: 1,
            rex_w: true,
        },
        "inc" => Mnemonic::Inc,
        "dec" => Mnemonic::Dec,
        _ => {
            return rex_prefix_byte(name)
                .map(Mnemonic::Prefix)
                .or_else(|| string_op(name))
                .or_else(|| sse2_op(name))
                .or_else(|| sse_mov(name))
                .or_else(|| sse_imm(name))
                .or_else(|| vex_op(name))
                .or_else(|| mask_op(name))
                .or_else(|| super::evex::op(name).map(Mnemonic::Evex));
        }
    })
}

/// The REX byte of the `rex[.WRXB]` prefix spelling. The letters name the
/// bits of `0100WRXB` and appear in that order, each at most once, as GNU as
/// spells them.
fn rex_prefix_byte(name: &str) -> Option<u8> {
    let rest = name.strip_prefix("rex")?;
    if rest.is_empty() {
        return Some(0x40);
    }
    let letters = rest.strip_prefix('.').filter(|l| !l.is_empty())?;
    let (mut bits, mut next) = (0x40u8, 0usize);
    for c in letters.bytes() {
        let i = b"WRXB"
            .iter()
            .position(|&w| w == c.to_ascii_uppercase())
            .filter(|&i| i >= next)?;
        bits |= 1 << (3 - i);
        next = i + 1;
    }
    Some(bits)
}

/// Merge an explicit REX prefix into the instruction encoded from `at`: the
/// bits join the instruction's own REX byte, which follows the legacy
/// prefixes and precedes the opcode, as GNU as merges them. A VEX / EVEX
/// encoding carries the same bits in its own prefix and admits no REX byte.
pub(crate) fn splice_rex(code: &mut Vec<u8>, at: usize, rex: u8) -> Result<(), String> {
    let mut i = at;
    while i < code.len()
        && matches!(
            code[i],
            0x66 | 0x67 | 0xF0 | 0xF2 | 0xF3 | 0x26 | 0x2E | 0x36 | 0x3E | 0x64 | 0x65
        )
    {
        i += 1;
    }
    match code.get(i) {
        Some(&b) if (0x40..=0x4F).contains(&b) => code[i] = b | (rex & 0x0F),
        Some(0xC4 | 0xC5 | 0x62) => {
            return Err(String::from(
                "inline asm: a `rex` prefix is invalid with a VEX / EVEX instruction",
            ));
        }
        _ => code.insert(i, rex),
    }
    Ok(())
}

/// SSE2 two-xmm register ops as `(name, mandatory-prefix, 0F-opcode)`; a zero
/// prefix is the no-mandatory-prefix packed-single form. A table rather than a
/// per-op match arm since they all share the `Sse2Rr` encoding. Byte-verified
/// against clang.
fn sse2_op(name: &str) -> Option<Mnemonic> {
    // The 0F38 map: SSSE3 / SSE4.1 byte ops (66-prefixed), the AES round set
    // (66-prefixed), and the SHA extensions (no mandatory prefix).
    #[rustfmt::skip]
    const OPS38: &[(&str, u8, u8)] = &[
        ("pshufb", 0x66, 0x00), ("phaddw", 0x66, 0x01), ("phaddd", 0x66, 0x02),
        ("psignb", 0x66, 0x08), ("psignw", 0x66, 0x09), ("psignd", 0x66, 0x0A),
        ("pmulhrsw", 0x66, 0x0B), ("pblendvb", 0x66, 0x10), ("pabsb", 0x66, 0x1C),
        ("pabsw", 0x66, 0x1D), ("pabsd", 0x66, 0x1E),
        ("pmovsxbw", 0x66, 0x20), ("pmovsxbd", 0x66, 0x21), ("pmovsxbq", 0x66, 0x22),
        ("pmovsxwd", 0x66, 0x23), ("pmovsxwq", 0x66, 0x24), ("pmovsxdq", 0x66, 0x25),
        ("pmuldq", 0x66, 0x28), ("pcmpeqq", 0x66, 0x29), ("packusdw", 0x66, 0x2B),
        ("pmovzxbw", 0x66, 0x30), ("pmovzxbd", 0x66, 0x31), ("pmovzxbq", 0x66, 0x32),
        ("pmovzxwd", 0x66, 0x33), ("pmovzxwq", 0x66, 0x34), ("pmovzxdq", 0x66, 0x35),
        ("pminsb", 0x66, 0x38), ("pminsd", 0x66, 0x39), ("pminuw", 0x66, 0x3A),
        ("pminud", 0x66, 0x3B), ("pmaxsb", 0x66, 0x3C), ("pmaxsd", 0x66, 0x3D),
        ("pmaxuw", 0x66, 0x3E), ("pmaxud", 0x66, 0x3F), ("pmulld", 0x66, 0x40),
        ("ptest", 0x66, 0x17),
        ("aesimc", 0x66, 0xDB), ("aesenc", 0x66, 0xDC), ("aesenclast", 0x66, 0xDD),
        ("aesdec", 0x66, 0xDE), ("aesdeclast", 0x66, 0xDF),
        ("sha1nexte", 0, 0xC8), ("sha1msg1", 0, 0xC9), ("sha1msg2", 0, 0xCA),
        ("sha256rnds2", 0, 0xCB), ("sha256msg1", 0, 0xCC), ("sha256msg2", 0, 0xCD),
    ];
    if let Some(&(_, prefix, opcode)) = OPS38.iter().find(|(n, _, _)| *n == name) {
        return Some(Mnemonic::Sse2Rr {
            prefix,
            map: 2,
            opcode,
        });
    }
    #[rustfmt::skip]
    const OPS: &[(&str, u8, u8)] = &[
        // Integer (0x66 prefix).
        ("pxor", 0x66, 0xEF), ("pand", 0x66, 0xDB), ("por", 0x66, 0xEB), ("pandn", 0x66, 0xDF),
        ("paddb", 0x66, 0xFC), ("paddw", 0x66, 0xFD), ("paddd", 0x66, 0xFE), ("paddq", 0x66, 0xD4),
        ("psubb", 0x66, 0xF8), ("psubw", 0x66, 0xF9), ("psubd", 0x66, 0xFA), ("psubq", 0x66, 0xFB),
        ("pmullw", 0x66, 0xD5), ("pmuludq", 0x66, 0xF4), ("pmaddwd", 0x66, 0xF5), ("pmulhw", 0x66, 0xE5),
        ("pcmpeqb", 0x66, 0x74), ("pcmpeqw", 0x66, 0x75), ("pcmpeqd", 0x66, 0x76),
        ("pcmpgtb", 0x66, 0x64), ("pcmpgtw", 0x66, 0x65), ("pcmpgtd", 0x66, 0x66),
        ("pminub", 0x66, 0xDA), ("pmaxub", 0x66, 0xDE),
        ("packsswb", 0x66, 0x63), ("packssdw", 0x66, 0x6B), ("packuswb", 0x66, 0x67),
        ("punpcklbw", 0x66, 0x60), ("punpcklwd", 0x66, 0x61), ("punpckldq", 0x66, 0x62),
        ("punpckhbw", 0x66, 0x68), ("punpckhwd", 0x66, 0x69), ("punpckhdq", 0x66, 0x6A),
        ("punpcklqdq", 0x66, 0x6C), ("punpckhqdq", 0x66, 0x6D),
        // Scalar double (0xF2) / single (0xF3).
        ("addsd", 0xF2, 0x58), ("subsd", 0xF2, 0x5C), ("mulsd", 0xF2, 0x59), ("divsd", 0xF2, 0x5E),
        ("minsd", 0xF2, 0x5D), ("maxsd", 0xF2, 0x5F), ("sqrtsd", 0xF2, 0x51),
        ("addss", 0xF3, 0x58), ("subss", 0xF3, 0x5C), ("mulss", 0xF3, 0x59), ("divss", 0xF3, 0x5E),
        ("minss", 0xF3, 0x5D), ("maxss", 0xF3, 0x5F), ("sqrtss", 0xF3, 0x51),
        // Packed single (no prefix) / double (0x66).
        ("addps", 0, 0x58), ("subps", 0, 0x5C), ("mulps", 0, 0x59), ("divps", 0, 0x5E),
        ("minps", 0, 0x5D), ("maxps", 0, 0x5F), ("sqrtps", 0, 0x51),
        ("andps", 0, 0x54), ("andnps", 0, 0x55), ("orps", 0, 0x56), ("xorps", 0, 0x57),
        ("unpcklps", 0, 0x14), ("unpckhps", 0, 0x15),
        // Packed int <-> single-float conversions (cvtdq2ps / cvtps2dq / cvttps2dq).
        ("cvtdq2ps", 0, 0x5B), ("cvtps2dq", 0x66, 0x5B), ("cvttps2dq", 0xF3, 0x5B),
        ("addpd", 0x66, 0x58), ("subpd", 0x66, 0x5C), ("mulpd", 0x66, 0x59), ("divpd", 0x66, 0x5E),
        ("andpd", 0x66, 0x54), ("orpd", 0x66, 0x56), ("xorpd", 0x66, 0x57),
        ("unpcklpd", 0x66, 0x14), ("unpckhpd", 0x66, 0x15),
    ];
    OPS.iter()
        .find(|(n, _, _)| *n == name)
        .map(|&(_, prefix, opcode)| Mnemonic::Sse2Rr {
            prefix,
            map: 1,
            opcode,
        })
}

/// One row of the SSE move table.
struct SseMovRow {
    name: &'static str,
    prefix: u8,
    load_op: Option<u8>,
    store_op: Option<u8>,
    map: u8,
}

/// SSE move ops: the register-register and load forms use the load opcode,
/// the store form the store one. The non-temporal moves have a single
/// direction; `movntdqa` is the only load among them and the only one in the
/// 0F 38 map.
fn sse_mov(name: &str) -> Option<Mnemonic> {
    const fn row(
        name: &'static str,
        prefix: u8,
        load_op: Option<u8>,
        store_op: Option<u8>,
        map: u8,
    ) -> SseMovRow {
        SseMovRow {
            name,
            prefix,
            load_op,
            store_op,
            map,
        }
    }
    #[rustfmt::skip]
    const MOVS: &[SseMovRow] = &[
        row("movdqa",   0x66, Some(0x6F), Some(0x7F), 1),
        row("movdqu",   0xF3, Some(0x6F), Some(0x7F), 1),
        row("movaps",   0x00, Some(0x28), Some(0x29), 1),
        row("movups",   0x00, Some(0x10), Some(0x11), 1),
        row("movsd",    0xF2, Some(0x10), Some(0x11), 1),
        row("movss",    0xF3, Some(0x10), Some(0x11), 1),
        row("movntdqa", 0x66, Some(0x2A), None,       2),
        row("movntdq",  0x66, None,       Some(0xE7), 1),
        row("movntps",  0x00, None,       Some(0x2B), 1),
        row("movntpd",  0x66, None,       Some(0x2B), 1),
    ];
    MOVS.iter()
        .find(|r| r.name == name)
        .map(|r| Mnemonic::SseMov {
            prefix: r.prefix,
            load_op: r.load_op,
            store_op: r.store_op,
            map: r.map,
        })
}

/// SSE immediate-operand ops: the packed shuffles `pshuf{d,lw,hw}` (opcode 0x70,
/// the prefix selecting the variant) and the shifts-by-immediate `ps{ll,rl,ra}
/// {w,d,q}` / `ps{ll,rl}dq` (opcode 0x71/0x72/0x73, a `/digit` opcode extension).
fn sse_imm(name: &str) -> Option<Mnemonic> {
    // Immediate ops as `(name, prefix, map, opcode, W, store)`: pshuf* select
    // by prefix over opcode 0x70; shuf{ps,pd} use opcode 0xC6; the 0F3A map
    // holds the lane / element ops, of which the extracts write their r/m.
    #[rustfmt::skip]
    const IMMS: &[(&str, u8, u8, u8, bool, bool)] = &[
        ("pshufd", 0x66, 1, 0x70, false, false),
        ("pshuflw", 0xF2, 1, 0x70, false, false),
        ("pshufhw", 0xF3, 1, 0x70, false, false),
        ("shufps", 0, 1, 0xC6, false, false), ("shufpd", 0x66, 1, 0xC6, false, false),
        ("palignr", 0x66, 3, 0x0F, false, false),
        ("pclmulqdq", 0x66, 3, 0x44, false, false),
        ("blendps", 0x66, 3, 0x0C, false, false), ("blendpd", 0x66, 3, 0x0D, false, false),
        ("pblendw", 0x66, 3, 0x0E, false, false),
        ("aeskeygenassist", 0x66, 3, 0xDF, false, false),
        ("sha1rnds4", 0, 3, 0xCC, false, false),
        ("pinsrb", 0x66, 3, 0x20, false, false), ("pinsrd", 0x66, 3, 0x22, false, false),
        ("pinsrq", 0x66, 3, 0x22, true, false),
        ("pextrb", 0x66, 3, 0x14, false, true), ("pextrd", 0x66, 3, 0x16, false, true),
        ("pextrq", 0x66, 3, 0x16, true, true), ("extractps", 0x66, 3, 0x17, false, true),
        // The word element pair takes the 0F map: the general register is
        // ModRM.reg for the extract and ModRM.r/m for the insert.
        ("pextrw", 0x66, 1, 0xC5, false, false), ("pinsrw", 0x66, 1, 0xC4, false, false),
    ];
    if let Some(&(_, prefix, map, opcode, w, store)) = IMMS.iter().find(|r| r.0 == name) {
        return Some(Mnemonic::SseRmImm {
            prefix,
            map,
            opcode,
            w,
            store,
        });
    }
    // `(name, immediate opcode, /digit, variable-count opcode)`.
    #[rustfmt::skip]
    const SHIFTS: &[(&str, u8, u8, Option<u8>)] = &[
        ("psllw", 0x71, 6, Some(0xF1)), ("pslld", 0x72, 6, Some(0xF2)), ("psllq", 0x73, 6, Some(0xF3)),
        ("psrlw", 0x71, 2, Some(0xD1)), ("psrld", 0x72, 2, Some(0xD2)), ("psrlq", 0x73, 2, Some(0xD3)),
        ("psraw", 0x71, 4, Some(0xE1)), ("psrad", 0x72, 4, Some(0xE2)),
        ("pslldq", 0x73, 7, None), ("psrldq", 0x73, 3, None),
    ];
    SHIFTS
        .iter()
        .find(|(n, _, _, _)| *n == name)
        .map(|&(_, opcode, digit, var_opcode)| Mnemonic::SseShiftImm {
            opcode,
            digit,
            var_opcode,
        })
}

/// 3-operand VEX (AVX) ops as `(name, pp, 0F-opcode)`, where `pp` selects the
/// SSE prefix (0 none, 1 0x66, 2 0xF3, 3 0xF2). All are 0F-map, VEX.W 0. The
/// non-destructive 3-operand form `v-op %src2, %src1, %dst` mirrors the SSE
/// two-operand op with an extra source. Byte-verified against clang.
fn vex_op(name: &str) -> Option<Mnemonic> {
    // The upper-lane clears take no operands.
    if let Some(l) = match name {
        "vzeroupper" => Some(0u8),
        "vzeroall" => Some(1),
        _ => None,
    } {
        return Some(Mnemonic::VexNullary { l });
    }
    // VEX general-register ops as `(name, pp, map, opcode, imm, vvvv_first)`:
    // the BMI / BMI2 set, which encodes with VEX but names no vector register.
    #[rustfmt::skip]
    const GPR: &[(&str, u8, u8, u8, bool, bool)] = &[
        ("rorx", 3, 3, 0xF0, true, false),
        ("andn", 0, 2, 0xF2, false, false), ("mulx", 3, 2, 0xF6, false, false),
        ("bzhi", 0, 2, 0xF5, false, true), ("pdep", 3, 2, 0xF5, false, false),
        ("pext", 2, 2, 0xF5, false, false),
        ("sarx", 2, 2, 0xF7, false, true), ("shlx", 1, 2, 0xF7, false, true),
        ("shrx", 3, 2, 0xF7, false, true),
    ];
    if let Some(&(_, pp, map, opcode, imm, vvvv_first)) = GPR.iter().find(|r| r.0 == name) {
        return Some(Mnemonic::VexGpr {
            pp,
            map,
            opcode,
            imm,
            vvvv_first,
        });
    }
    // VEX packed shifts as `(name, immediate opcode, /digit, variable-count
    // opcode)`; the immediate form puts the destination in VEX.vvvv, so they
    // are their own shape.
    #[rustfmt::skip]
    const SHIFTS: &[(&str, u8, u8, Option<u8>)] = &[
        ("vpsllw", 0x71, 6, Some(0xF1)), ("vpslld", 0x72, 6, Some(0xF2)), ("vpsllq", 0x73, 6, Some(0xF3)),
        ("vpsrlw", 0x71, 2, Some(0xD1)), ("vpsrld", 0x72, 2, Some(0xD2)), ("vpsrlq", 0x73, 2, Some(0xD3)),
        ("vpsraw", 0x71, 4, Some(0xE1)), ("vpsrad", 0x72, 4, Some(0xE2)),
        ("vpslldq", 0x73, 7, None), ("vpsrldq", 0x73, 3, None),
    ];
    if let Some(&(_, opcode, digit, var_opcode)) = SHIFTS.iter().find(|(n, _, _, _)| *n == name) {
        return Some(Mnemonic::VexShiftImm {
            opcode,
            digit,
            var_opcode,
        });
    }
    if let "vmovd" | "vmovq" = name {
        return Some(Mnemonic::VexMovd { w: name == "vmovq" });
    }
    // 2-operand VEX moves as `(pp, load-op, store-op)`.
    let mov = match name {
        "vmovups" => Some((0u8, 0x10u8, 0x11u8)),
        "vmovupd" => Some((1, 0x10, 0x11)),
        "vmovaps" => Some((0, 0x28, 0x29)),
        "vmovapd" => Some((1, 0x28, 0x29)),
        "vmovdqu" => Some((2, 0x6F, 0x7F)),
        "vmovdqa" => Some((1, 0x6F, 0x7F)),
        _ => None,
    };
    if let Some((pp, load_op, store_op)) = mov {
        return Some(Mnemonic::VexMov {
            pp,
            load_op,
            store_op,
        });
    }
    // 2-operand VEX compute (single source) as `(pp, map, opcode)`. The 0F38
    // entries are the broadcasts: an xmm / memory source replicated across the
    // destination lanes.
    let two = match name {
        "vsqrtps" => Some((0u8, 1u8, 0x51u8)),
        "vsqrtpd" => Some((1, 1, 0x51)),
        "vrcpps" => Some((0, 1, 0x53)),
        "vrsqrtps" => Some((0, 1, 0x52)),
        "vcvtdq2ps" => Some((0, 1, 0x5B)),
        "vcvtps2dq" => Some((1, 1, 0x5B)),
        "vcvttps2dq" => Some((2, 1, 0x5B)),
        "vcvtdq2pd" => Some((2, 1, 0xE6)),
        "vcvtps2pd" => Some((0, 1, 0x5A)),
        "vmovddup" => Some((3, 1, 0x12)),
        "vbroadcastss" => Some((1, 2, 0x18)),
        "vbroadcastsd" => Some((1, 2, 0x19)),
        "vpbroadcastb" => Some((1, 2, 0x78)),
        "vpbroadcastw" => Some((1, 2, 0x79)),
        "vpbroadcastd" => Some((1, 2, 0x58)),
        "vpbroadcastq" => Some((1, 2, 0x59)),
        // Packed integer absolute value (0F38, 66); VEX.L follows the
        // destination as for the broadcasts.
        "vpabsb" => Some((1, 2, 0x1C)),
        "vpabsw" => Some((1, 2, 0x1D)),
        "vpabsd" => Some((1, 2, 0x1E)),
        // Both operands are sources; the second AT&T one is ModRM.reg and
        // fixes VEX.L, as for the single-source ops above.
        "vptest" => Some((1, 2, 0x17)),
        _ => None,
    };
    if let Some((pp, map, opcode)) = two {
        return Some(Mnemonic::Vex2 {
            pp,
            map,
            opcode,
            mem_only: false,
        });
    }
    // The packed integer extends (0F38, 66) as `(name, opcode)`: an xmm or
    // memory source widened into the destination lanes, so VEX.L follows the
    // destination. The source / destination element pairs run bw, bd, bq, wd,
    // wq, dq, sign-extending from 0x20 and zero-extending from 0x30.
    #[rustfmt::skip]
    const EXT: &[(&str, u8)] = &[
        ("vpmovsxbw", 0x20), ("vpmovsxbd", 0x21), ("vpmovsxbq", 0x22),
        ("vpmovsxwd", 0x23), ("vpmovsxwq", 0x24), ("vpmovsxdq", 0x25),
        ("vpmovzxbw", 0x30), ("vpmovzxbd", 0x31), ("vpmovzxbq", 0x32),
        ("vpmovzxwd", 0x33), ("vpmovzxwq", 0x34), ("vpmovzxdq", 0x35),
    ];
    if let Some(&(_, opcode)) = EXT.iter().find(|(n, _)| *n == name) {
        return Some(Mnemonic::Vex2 {
            pp: 1,
            map: 2,
            opcode,
            mem_only: false,
        });
    }
    // The 128-bit lane broadcasts and the non-temporal load (0F38, 66), all
    // memory-source only.
    if let Some(opcode) = match name {
        "vbroadcastf128" => Some(0x1Au8),
        "vbroadcasti128" => Some(0x5A),
        "vmovntdqa" => Some(0x2A),
        _ => None,
    } {
        return Some(Mnemonic::Vex2 {
            pp: 1,
            map: 2,
            opcode,
            mem_only: true,
        });
    }
    #[rustfmt::skip]
    const OPS: &[(&str, u8, u8)] = &[
        // Packed single (no prefix).
        ("vaddps", 0, 0x58), ("vsubps", 0, 0x5C), ("vmulps", 0, 0x59), ("vdivps", 0, 0x5E),
        ("vminps", 0, 0x5D), ("vmaxps", 0, 0x5F),
        ("vandps", 0, 0x54), ("vandnps", 0, 0x55), ("vorps", 0, 0x56), ("vxorps", 0, 0x57),
        ("vunpcklps", 0, 0x14), ("vunpckhps", 0, 0x15),
        // Packed double (0x66).
        ("vaddpd", 1, 0x58), ("vsubpd", 1, 0x5C), ("vmulpd", 1, 0x59), ("vdivpd", 1, 0x5E),
        ("vminpd", 1, 0x5D), ("vmaxpd", 1, 0x5F),
        ("vandpd", 1, 0x54), ("vorpd", 1, 0x56), ("vxorpd", 1, 0x57),
        ("vunpcklpd", 1, 0x14), ("vunpckhpd", 1, 0x15),
        // Packed integer (0x66).
        ("vpaddb", 1, 0xFC), ("vpaddw", 1, 0xFD), ("vpaddd", 1, 0xFE), ("vpaddq", 1, 0xD4),
        ("vpsubb", 1, 0xF8), ("vpsubw", 1, 0xF9), ("vpsubd", 1, 0xFA), ("vpsubq", 1, 0xFB),
        ("vpand", 1, 0xDB), ("vpandn", 1, 0xDF), ("vpor", 1, 0xEB), ("vpxor", 1, 0xEF),
        ("vpcmpeqb", 1, 0x74), ("vpcmpeqw", 1, 0x75), ("vpcmpeqd", 1, 0x76),
        ("vpcmpgtb", 1, 0x64), ("vpcmpgtw", 1, 0x65), ("vpcmpgtd", 1, 0x66),
        ("vpunpckldq", 1, 0x62), ("vpunpckhdq", 1, 0x6A),
        ("vpunpcklqdq", 1, 0x6C), ("vpunpckhqdq", 1, 0x6D),
        ("vpmullw", 1, 0xD5), ("vpmaddwd", 1, 0xF5), ("vpmulhw", 1, 0xE5),
        ("vpmuludq", 1, 0xF4),
        // Scalar single (0xF3) / double (0xF2).
        ("vaddss", 2, 0x58), ("vsubss", 2, 0x5C), ("vmulss", 2, 0x59), ("vdivss", 2, 0x5E),
        ("vaddsd", 3, 0x58), ("vsubsd", 3, 0x5C), ("vmulsd", 3, 0x59), ("vdivsd", 3, 0x5E),
    ];
    if let Some(&(_, pp, opcode)) = OPS.iter().find(|(n, _, _)| *n == name) {
        return Some(Mnemonic::Vex {
            pp,
            map: 1,
            w: false,
            opcode,
        });
    }
    // 3-operand VEX on the 0F38 map (all 66-prefixed) as `(name, W, opcode)`:
    // the SSE4.1 multiplies, the variable shifts, vpermd, and the FMA set.
    // W selects the element width (0 = dword / single, 1 = qword / double).
    #[rustfmt::skip]
    const OPS38: &[(&str, bool, u8)] = &[
        ("vpmulld", false, 0x40), ("vpmuldq", false, 0x28),
        ("vpsllvd", false, 0x47), ("vpsrlvd", false, 0x45), ("vpsravd", false, 0x46),
        ("vpsllvq", true, 0x47), ("vpsrlvq", true, 0x45),
        ("vpermd", false, 0x36), ("vpermps", false, 0x16), ("vpshufb", false, 0x00),
        ("vpsignb", false, 0x08), ("vpsignw", false, 0x09), ("vpsignd", false, 0x0A),
        ("vpcmpeqq", false, 0x29), ("vpackusdw", false, 0x2B),
        ("vpminsb", false, 0x38), ("vpminsd", false, 0x39),
        ("vpmaxsb", false, 0x3C), ("vpmaxsd", false, 0x3D),
        ("vaesenc", false, 0xDC), ("vaesenclast", false, 0xDD),
        ("vaesdec", false, 0xDE), ("vaesdeclast", false, 0xDF),
        ("vfmadd132ps", false, 0x98), ("vfmadd213ps", false, 0xA8), ("vfmadd231ps", false, 0xB8),
        ("vfmadd132pd", true, 0x98), ("vfmadd213pd", true, 0xA8), ("vfmadd231pd", true, 0xB8),
        ("vfmsub132ps", false, 0x9A), ("vfmsub213ps", false, 0xAA), ("vfmsub231ps", false, 0xBA),
        ("vfmsub132pd", true, 0x9A), ("vfmsub213pd", true, 0xAA), ("vfmsub231pd", true, 0xBA),
        ("vfnmadd132ps", false, 0x9C), ("vfnmadd213ps", false, 0xAC), ("vfnmadd231ps", false, 0xBC),
        ("vfnmadd132pd", true, 0x9C), ("vfnmadd213pd", true, 0xAC), ("vfnmadd231pd", true, 0xBC),
        ("vfnmsub132ps", false, 0x9E), ("vfnmsub213ps", false, 0xAE), ("vfnmsub231ps", false, 0xBE),
        ("vfnmsub132pd", true, 0x9E), ("vfnmsub213pd", true, 0xAE), ("vfnmsub231pd", true, 0xBE),
    ];
    if let Some(&(_, w, opcode)) = OPS38.iter().find(|(n, _, _)| *n == name) {
        return Some(Mnemonic::Vex {
            pp: 1,
            map: 2,
            w,
            opcode,
        });
    }
    // Immediate ops as `(pp, map, opcode)`. 3-operand: vshuf{ps,pd} (0F C6) and
    // the 0F3A lane ops. 2-operand: vpshuf{d,lw,hw} (0F 70), vpermil{ps,pd},
    // and the lane extracts, which write their r/m operand. TODO: EVEX /
    // AVX-512 forms need their own encoding shape.
    let imm3 = match name {
        "vshufps" => Some((0u8, 1u8, 0xC6u8)),
        "vshufpd" => Some((1, 1, 0xC6)),
        "vperm2f128" => Some((1, 3, 0x06)),
        "vperm2i128" => Some((1, 3, 0x46)),
        "vpblendd" => Some((1, 3, 0x02)),
        "vpalignr" => Some((1, 3, 0x0F)),
        "vinsertf128" => Some((1, 3, 0x18)),
        "vinserti128" => Some((1, 3, 0x38)),
        "vpclmulqdq" => Some((1, 3, 0x44)),
        "vpblendw" => Some((1, 3, 0x0E)),
        _ => None,
    };
    if let Some((pp, map, opcode)) = imm3 {
        return Some(Mnemonic::VexImm3 {
            pp,
            map,
            opcode,
            is4: false,
        });
    }
    // The is4 blends (0F3A, 66, W0): a four-register form whose leading AT&T
    // operand is the mask, held in the top four bits of the trailing byte.
    if let Some(opcode) = match name {
        "vblendvps" => Some(0x4Au8),
        "vblendvpd" => Some(0x4B),
        "vpblendvb" => Some(0x4C),
        _ => None,
    } {
        return Some(Mnemonic::VexImm3 {
            pp: 1,
            map: 3,
            opcode,
            is4: true,
        });
    }
    if let Some(opcode) = match name {
        "vextractf128" => Some(0x19u8),
        "vextracti128" => Some(0x39),
        _ => None,
    } {
        return Some(Mnemonic::VexImm2 {
            pp: 1,
            map: 3,
            opcode,
            store: true,
        });
    }
    // The element extracts as `(name, map, opcode, W, register-form opcode)`
    // and the inserts as `(name, map, opcode, W)`. Their r/m operand is a
    // general register or memory, so they are their own shape.
    #[rustfmt::skip]
    const EXTRACT: &[(&str, u8, u8, bool, Option<u8>)] = &[
        ("vpextrb", 3, 0x14, false, None), ("vpextrw", 3, 0x15, false, Some(0xC5)),
        ("vpextrd", 3, 0x16, false, None), ("vpextrq", 3, 0x16, true,  None),
        ("vextractps", 3, 0x17, false, None),
    ];
    if let Some(&(_, map, opcode, w, reg_form)) = EXTRACT.iter().find(|r| r.0 == name) {
        return Some(Mnemonic::VexElemExtract {
            map,
            opcode,
            w,
            reg_form,
        });
    }
    #[rustfmt::skip]
    const INSERT: &[(&str, u8, u8, bool)] = &[
        ("vpinsrb", 3, 0x20, false), ("vpinsrw", 1, 0xC4, false),
        ("vpinsrd", 3, 0x22, false), ("vpinsrq", 3, 0x22, true),
    ];
    if let Some(&(_, map, opcode, w)) = INSERT.iter().find(|r| r.0 == name) {
        return Some(Mnemonic::VexElemInsert { map, opcode, w });
    }
    let imm2 = match name {
        "vpshufd" => Some((1u8, 1u8, 0x70u8)),
        "vpshuflw" => Some((3, 1, 0x70)),
        "vpshufhw" => Some((2, 1, 0x70)),
        "vpermilps" => Some((1, 3, 0x04)),
        "vpermilpd" => Some((1, 3, 0x05)),
        _ => None,
    };
    imm2.map(|(pp, map, opcode)| Mnemonic::VexImm2 {
        pp,
        map,
        opcode,
        store: false,
    })
}

/// The opmask-register instruction set (VEX-encoded, SDM "KADDW" .. "KXORW"
/// pages). The width letter fixes the prefix selections: on the 0F map the
/// byte and dword forms take 0x66 and the dword and qword forms VEX.W; the
/// shifts pair the widths per opcode on the 0F3A map under a constant 0x66.
fn mask_op(name: &str) -> Option<Mnemonic> {
    let width = |letter: &str| match letter {
        "b" => Some(1u8),
        "w" => Some(2),
        "d" => Some(4),
        "q" => Some(8),
        _ => None,
    };
    if let Some(rest) = name.strip_prefix("kmov") {
        return Some(Mnemonic::Kmov {
            width: width(rest)?,
        });
    }
    if let Some(rest) = name.strip_prefix("kshift") {
        let (base, rest) = match rest.split_at_checked(1)? {
            ("l", r) => (0x32u8, r),
            ("r", r) => (0x30, r),
            _ => return None,
        };
        let w = width(rest)?;
        return Some(Mnemonic::MaskOp {
            pp: 1,
            map: 3,
            w: matches!(w, 2 | 8),
            opcode: base + u8::from(matches!(w, 4 | 8)),
            l: 0,
            vvvv: false,
            imm: true,
        });
    }
    // The unpacks spell a width pair; each is its own row.
    let m = |pp, w, l, opcode| {
        Some(Mnemonic::MaskOp {
            pp,
            map: 1,
            w,
            opcode,
            l,
            vvvv: l == 1,
            imm: false,
        })
    };
    if let Some(v) = match name {
        "kunpckbw" => m(1, false, 1, 0x4B),
        "kunpckwd" => m(0, false, 1, 0x4B),
        "kunpckdq" => m(0, true, 1, 0x4B),
        _ => None,
    } {
        return Some(v);
    }
    // 0F-map families as `(base, opcode, 3-operand)`; the 3-operand forms
    // set VEX.L.
    const OPS: &[(&str, u8, bool)] = &[
        ("kand", 0x41, true),
        ("kandn", 0x42, true),
        ("kor", 0x45, true),
        ("kxnor", 0x46, true),
        ("kxor", 0x47, true),
        ("kadd", 0x4A, true),
        ("knot", 0x44, false),
        ("kortest", 0x98, false),
        ("ktest", 0x99, false),
    ];
    let (base, letter) = name.split_at_checked(name.len().checked_sub(1)?)?;
    let &(_, opcode, three) = OPS.iter().find(|r| r.0 == base)?;
    let w = width(letter)?;
    m(
        u8::from(matches!(w, 1 | 4)),
        matches!(w, 4 | 8),
        u8::from(three),
        opcode,
    )
}

/// If `movq src, dst` involves an XMM register, encode the SSE quadword move and
/// return true; otherwise (a plain GP move) return false. The forms: GP64<->xmm
/// (66 REX.W 0F 6E/7E), xmm<->xmm and mem->xmm load (F3 0F 7E), xmm->mem store
/// (66 0F D6). The xmm is always ModRM.reg; the other operand is r/m.
fn movq_xmm(
    code: &mut Vec<u8>,
    mode: super::table::Mode,
    addr: u8,
    src: Concrete,
    dst: Concrete,
) -> Result<bool, String> {
    let xmm = |c: &Concrete| match c {
        Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
            Some(*reg - XMM_BASE)
        }
        _ => None,
    };
    let (sx, dx) = (xmm(&src), xmm(&dst));
    match (sx, dx, src, dst) {
        // GP -> xmm.
        (None, Some(d), Concrete::Reg { reg: g, .. }, _) => {
            code.push(0x66);
            code.push(rex(true, d >= 8, false, g >= 8));
            code.extend_from_slice(&[0x0F, 0x6E]);
            code.push(modrm_reg(d & 7, g & 7));
        }
        // xmm -> GP.
        (Some(s), None, _, Concrete::Reg { reg: g, .. }) => {
            code.push(0x66);
            code.push(rex(true, s >= 8, false, g >= 8));
            code.extend_from_slice(&[0x0F, 0x7E]);
            code.push(modrm_reg(s & 7, g & 7));
        }
        // xmm -> xmm.
        (Some(s), Some(d), _, _) => {
            code.push(0xF3);
            if d >= 8 || s >= 8 {
                code.push(rex(false, d >= 8, false, s >= 8));
            }
            code.extend_from_slice(&[0x0F, 0x7E]);
            code.push(modrm_reg(d & 7, s & 7));
        }
        // mem -> xmm (load).
        (None, Some(d), ref m, _) if MemRm::of(m).is_some() => {
            let Some(mr) = MemRm::of(m) else {
                return Ok(false);
            };
            code.push(0xF3);
            if d >= 8 || mr.rex_x() || mr.rex_b() {
                code.push(rex(false, d >= 8, mr.rex_x(), mr.rex_b()));
            }
            code.extend_from_slice(&[0x0F, 0x7E]);
            mr.emit(code, mode, addr, d & 7)?;
        }
        // xmm -> mem (store).
        (Some(s), None, _, ref m) if MemRm::of(m).is_some() => {
            let Some(mr) = MemRm::of(m) else {
                return Ok(false);
            };
            code.push(0x66);
            if s >= 8 || mr.rex_x() || mr.rex_b() {
                code.push(rex(false, s >= 8, mr.rex_x(), mr.rex_b()));
            }
            code.extend_from_slice(&[0x0F, 0xD6]);
            mr.emit(code, mode, addr, s & 7)?;
        }
        // No xmm operand: a plain GP move.
        _ => return Ok(false),
    }
    Ok(true)
}

/// If `movq src, dst` involves an MMX register, encode the MMX quadword move
/// and return true. The forms: mm<->mm and mem->mm load (0F 6F), mm->mem
/// store (0F 7F), GP64<->mm (REX.W 0F 6E/7E). The mm register is always
/// ModRM.reg; the other operand is r/m.
fn movq_mmx(
    code: &mut Vec<u8>,
    mode: super::table::Mode,
    addr: u8,
    src: Concrete,
    dst: Concrete,
) -> Result<bool, String> {
    let mm = |c: &Concrete| match c {
        Concrete::Reg { reg, .. } if (MMX_BASE..MMX_BASE + 8).contains(reg) => {
            Some(*reg - MMX_BASE)
        }
        _ => None,
    };
    match (mm(&src), mm(&dst), src, dst) {
        // mm -> mm and mem -> mm use the load opcode with dst in ModRM.reg.
        (Some(s), Some(d), _, _) => {
            code.extend_from_slice(&[0x0F, 0x6F]);
            code.push(modrm_reg(d, s));
        }
        (None, Some(d), ref m, _) if MemRm::of(m).is_some() => {
            let Some(mr) = MemRm::of(m) else {
                return Ok(false);
            };
            if mr.rex_x() || mr.rex_b() {
                code.push(rex(false, false, mr.rex_x(), mr.rex_b()));
            }
            code.extend_from_slice(&[0x0F, 0x6F]);
            mr.emit(code, mode, addr, d)?;
        }
        (Some(s), None, _, ref m) if MemRm::of(m).is_some() => {
            let Some(mr) = MemRm::of(m) else {
                return Ok(false);
            };
            if mr.rex_x() || mr.rex_b() {
                code.push(rex(false, false, mr.rex_x(), mr.rex_b()));
            }
            code.extend_from_slice(&[0x0F, 0x7F]);
            mr.emit(code, mode, addr, s)?;
        }
        (None, Some(d), Concrete::Reg { reg: g, .. }, _) if g < MMX_BASE => {
            code.push(rex(true, false, false, g >= 8));
            code.extend_from_slice(&[0x0F, 0x6E]);
            code.push(modrm_reg(d, g & 7));
        }
        (Some(s), None, _, Concrete::Reg { reg: g, .. }) if g < MMX_BASE => {
            code.push(rex(true, false, false, g >= 8));
            code.extend_from_slice(&[0x0F, 0x7E]);
            code.push(modrm_reg(s, g & 7));
        }
        _ => return Ok(false),
    }
    Ok(true)
}

/// The catalogue mnemonic matching `name`, as a `'static` string, or `None`.
/// Lets a mnemonic the table encodes but that has no bespoke [`Mnemonic`]
/// variant still be parsed and routed through the table.
fn table_mnemonic(name: &str) -> Option<&'static str> {
    // The catalogue is sorted by mnemonic; binary-search rather than scan.
    let forms = super::isa_x86_table::FORMS;
    let start = forms.partition_point(|f| f.mnemonic < name);
    forms.get(start).map(|f| f.mnemonic).filter(|&m| m == name)
}

/// The lower-case spelling of a mnemonic token, or `None` when the token is
/// already the spelling to resolve. GNU as matches mnemonics without regard to
/// case; symbol names are case-sensitive, so a token is folded only when it is
/// not a mnemonic as written and the folded spelling is one.
pub(crate) fn fold_mnemonic_case(tok: &str) -> Option<alloc::string::String> {
    if !tok.bytes().any(|c| c.is_ascii_uppercase()) || split_mnemonic_exact(tok).is_some() {
        return None;
    }
    let lower = tok.to_ascii_lowercase();
    split_mnemonic_exact(&lower).is_some().then_some(lower)
}

/// Resolve a mnemonic token to its base form plus any AT&T size suffix,
/// folding case as GNU as does.
fn split_mnemonic(tok: &str) -> Option<(Mnemonic, Option<AsmRegSize>)> {
    match split_mnemonic_exact(tok) {
        Some(m) => Some(m),
        None => split_mnemonic_exact(&fold_mnemonic_case(tok)?),
    }
}

/// Resolve a mnemonic token to its base form plus any AT&T size suffix.
/// A trailing `b`/`w`/`l`/`q` is a suffix only when the token is not a
/// mnemonic as written (so `shl` stays `shl`, but `bswapl` is
/// `bswap` + long). A token that is not a bespoke mnemonic but names a
/// catalogue instruction resolves to [`Mnemonic::Table`].
fn split_mnemonic_exact(tok: &str) -> Option<(Mnemonic, Option<AsmRegSize>)> {
    if let Some(m) = mnemonic_by_name(tok) {
        return Some((m, None));
    }
    // AT&T reads the size letter on a stack op as a suffix of `push` / `pop`.
    // The catalogue also carries Intel's own `pushw` spelling (its imm16 row
    // only), which must not swallow the suffix, so these skip the whole-name
    // match and take the split below.
    let att_suffixed = matches!(tok, "pushw" | "pushl" | "pushq" | "popw" | "popl" | "popq");
    if !att_suffixed && let Some(name) = table_mnemonic(tok) {
        return Some((Mnemonic::Table(name), None));
    }
    // Unsuffixed flag push / pop: in 64-bit mode the operand size defaults to
    // 64-bit, so these name the `q` forms. The catalogue is Intel-syntax and
    // carries only the explicitly sized spellings.
    if let Some(sized) = match tok {
        "pushf" => Some("pushfq"),
        "popf" => Some("popfq"),
        // GNU as spellings of the two undefined-opcode instructions. Checked
        // before the size-suffix split, which would otherwise read `ud2b` as
        // `ud2` with a byte suffix.
        "ud2a" => Some("ud2"),
        "ud2b" => Some("ud1"),
        // Flag aliases of the `loop` conditionals.
        "loopz" => Some("loope"),
        "loopnz" => Some("loopne"),
        _ => None,
    } {
        return Some((Mnemonic::Table(table_mnemonic(sized)?), None));
    }
    // The narrower counter widths of the `E3 rel8` branch. The catalogue row
    // is `jrcxz`; these differ from it only by the address-size prefix, which
    // the encoder selects from the mode, so they carry no row of their own.
    if let Some(name) = match tok {
        "jcxz" => Some("jcxz"),
        "jecxz" => Some("jecxz"),
        _ => None,
    } {
        return Some((Mnemonic::Table(name), None));
    }
    // AT&T zero/sign-extending moves; the second width letter is the
    // operation width, the first rides the mnemonic to the r/m operand.
    {
        use AsmRegSize::{Byte, Long, Quad, Word};
        let ext = |name: &'static str, src: AsmRegSize, dst: AsmRegSize| {
            Some((Mnemonic::ExtMov { name, src }, Some(dst)))
        };
        let m = match tok {
            "movzbw" => ext("movzx", Byte, Word),
            "movzbl" => ext("movzx", Byte, Long),
            "movzbq" => ext("movzx", Byte, Quad),
            "movzwl" => ext("movzx", Word, Long),
            "movzwq" => ext("movzx", Word, Quad),
            "movsbw" => ext("movsx", Byte, Word),
            "movsbl" => ext("movsx", Byte, Long),
            "movsbq" => ext("movsx", Byte, Quad),
            "movswl" => ext("movsx", Word, Long),
            "movswq" => ext("movsx", Word, Quad),
            "movslq" => ext("movsxd", Long, Quad),
            _ => None,
        };
        if m.is_some() {
            return m;
        }
    }
    let (base, suffix) = match tok.as_bytes().last() {
        Some(b'b') => (&tok[..tok.len() - 1], Some(AsmRegSize::Byte)),
        Some(b'w') => (&tok[..tok.len() - 1], Some(AsmRegSize::Word)),
        Some(b'l') => (&tok[..tok.len() - 1], Some(AsmRegSize::Long)),
        Some(b'q') => (&tok[..tok.len() - 1], Some(AsmRegSize::Quad)),
        _ => return None,
    };
    if let Some(m) = mnemonic_by_name(base) {
        // A string primitive carries its size in its own name, so a further
        // suffix does not apply: `movsbl` is a sign-extending move, not
        // `movsb` widened to long. A prefix has no operand to size, so a
        // suffixed spelling of one (`rex.BW`, `lockw`) is no mnemonic.
        if matches!(m, Mnemonic::StringOp { .. } | Mnemonic::Prefix(_)) {
            return None;
        }
        return Some((m, suffix));
    }
    table_mnemonic(base).map(|name| (Mnemonic::Table(name), suffix))
}

/// A GNU-as label reference: a numeric local `Nf` / `Nb` (digits then a single
/// direction letter) or a named label from `labels`. Returns the label number
/// and direction (a name has one definition, so its direction is forward).
fn parse_label_ref(tok: &str, labels: &[&str]) -> Option<(u32, bool)> {
    if let Some((digits, dir)) = tok
        .strip_suffix('f')
        .map(|d| (d, true))
        .or_else(|| tok.strip_suffix('b').map(|d| (d, false)))
        && !digits.is_empty()
        && digits.bytes().all(|c| c.is_ascii_digit())
        && let Ok(num) = digits.parse::<u32>()
    {
        return Some((num, dir));
    }
    labels
        .iter()
        .position(|&n| n == tok)
        .map(|idx| (NAMED_LABEL_BASE + idx as u32, true))
}

/// Parse one operand token (already trimmed). `labels` is the template's
/// named-label intern table (from the definition pre-scan); a bare token
/// matching an entry is a local-label reference, not a symbol. `file_scope`
/// selects the basic-asm reading of a single `%`, where `%kN` is an opmask
/// register rather than GCC's operand modifier.
fn parse_operand(tok: &str, labels: &[&str], file_scope: bool) -> Result<AsmOpnd, String> {
    // A leading `*` is AT&T's indirect-branch marker (`jmp *%rax`,
    // `call *8(%rbx)`); the operand kind alone selects the encoding.
    let tok = tok.strip_prefix('*').unwrap_or(tok);
    let bytes = tok.as_bytes();
    if let Some(rest) = tok.strip_prefix('$') {
        if let Some(v) = parse_int(rest) {
            return Ok(AsmOpnd::Imm(v));
        }
        // `$LABEL`: the label's address as an absolute immediate (`pushq $1f`).
        if let Some((num, forward)) = parse_label_ref(rest, labels) {
            return Ok(AsmOpnd::ImmLabel { num, forward });
        }
        return Err(format!("inline asm: bad immediate `{tok}`"));
    }
    // x87 stack registers spell an index in parentheses (`%%st(1)`):
    // register syntax, not a memory reference.
    if let Some(body) = tok.strip_prefix("%%").or_else(|| tok.strip_prefix('%'))
        && body.starts_with("st(")
        && let Some(op) = named_reg_operand(body)
    {
        return Ok(op);
    }
    // `prefix(inner)`: a memory reference (displacement off a base register)
    // or, with an `(%rip)` base, the address of a template-local label.
    // The reference's `(` is the one matching the trailing `)`, not the first
    // in the token: a displacement may itself be a parenthesized expression.
    if let Some(open) = matching_open_paren(tok) {
        return parse_mem_operand(&tok[..open], &tok[open + 1..tok.len() - 1], labels)
            .ok_or_else(|| format!("inline asm: unsupported operand `{tok}`"));
    }
    // A local-label reference `Nf` / `Nb` (jmp / jcc target) or a named label.
    if let Some((num, forward)) = parse_label_ref(tok, labels) {
        return Ok(AsmOpnd::Label { num, forward });
    }
    if let Some(rest) = tok.strip_prefix("%%") {
        return named_reg_operand(rest)
            .or_else(|| mask_reg_operand(rest))
            .ok_or_else(|| format!("inline asm: unknown register `{tok}`"));
    }
    if bytes.first() == Some(&b'%') {
        let body = &tok[1..];
        // A single `%` before a register name is an explicit register. GCC
        // uses this in *basic* asm (no operand list); extended asm spells it
        // `%%reg`. Operand references (`%0`, `%w1`) are never register names,
        // so trying the register table first is unambiguous -- except for
        // `%k0`..`%k7`, which extended asm reads as the operand modifier and
        // only basic asm reads as opmask registers.
        if let Some(op) = named_reg_operand(body) {
            return Ok(op);
        }
        if file_scope && let Some(op) = mask_reg_operand(body) {
            return Ok(op);
        }
        // `%lK`: an `asm goto` label-list reference.
        if let Some(digits) = body.strip_prefix('l')
            && !digits.is_empty()
            && digits.bytes().all(|c| c.is_ascii_digit())
        {
            let k: u8 = digits
                .parse()
                .map_err(|_| format!("inline asm: bad goto-label reference `{tok}`"))?;
            return Ok(AsmOpnd::GotoLabel(k));
        }
        // `%cN` / `%PN`: a bare-constant / bare-symbol substitution.
        if let Some(&m) = body.as_bytes().first()
            && matches!(m, b'c' | b'P')
            && body.len() > 1
            && body[1..].bytes().all(|c| c.is_ascii_digit())
        {
            let idx: u8 = body[1..]
                .parse()
                .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
            return Ok(AsmOpnd::RefConst {
                idx,
                symbolic: m == b'P',
            });
        }
        // `%aN`: operand N rendered as an address reference. The operand holds
        // an address in a general register, so this is the base-only memory
        // form `(%reg)`. GCC may instead fold a constant displacement or a
        // symbol into the addressing expression (`64(%rdi)`, `sym(%rip)`);
        // the register form names the same address.
        if let Some(digits) = body.strip_prefix('a')
            && !digits.is_empty()
            && digits.bytes().all(|c| c.is_ascii_digit())
        {
            let idx: u8 = digits
                .parse()
                .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
            return Ok(AsmOpnd::Mem {
                base: AsmMemBase::Ref(idx),
                index: None,
                scale: 1,
                disp: 0,
            });
        }
        // `%N` or `%<size>N`. A leading size modifier is a single
        // letter b/w/k/q before the operand digits.
        let (size, digits) = match body.as_bytes().first() {
            Some(&b'b') if body.len() > 1 => (Some(AsmRegSize::Byte), &body[1..]),
            Some(&b'w') if body.len() > 1 => (Some(AsmRegSize::Word), &body[1..]),
            Some(&b'k') if body.len() > 1 => (Some(AsmRegSize::Long), &body[1..]),
            Some(&b'q') if body.len() > 1 => (Some(AsmRegSize::Quad), &body[1..]),
            _ => (None, body),
        };
        let idx: u8 = digits
            .parse()
            .map_err(|_| format!("inline asm: bad operand reference `{tok}`"))?;
        return Ok(AsmOpnd::Ref { idx, size });
    }
    Err(format!("inline asm: unsupported operand `{tok}`"))
}

/// Split an operand list on commas, but not commas inside `(...)` (a
/// scaled-index memory operand carries its own commas, as in
/// `8(%%rax, %%rbx, 4)`).
fn split_asm_operands(rest: &str) -> Vec<&str> {
    let mut out = Vec::new();
    let (mut depth, mut start) = (0i32, 0usize);
    // A character constant is opaque: `movb $',', %al` has one comma
    // separator, not two.
    let mut quoted = false;
    let mut esc = false;
    for (i, c) in rest.char_indices() {
        if quoted {
            match c {
                _ if esc => esc = false,
                '\\' => esc = true,
                '\'' => quoted = false,
                _ => {}
            }
            continue;
        }
        match c {
            '\'' => quoted = true,
            '(' => depth += 1,
            ')' => depth -= 1,
            ',' if depth == 0 => {
                out.push(rest[start..i].trim());
                start = i + 1;
            }
            _ => {}
        }
    }
    let last = rest[start..].trim();
    if !last.is_empty() {
        out.push(last);
    }
    out
}

/// Mnemonics whose bare (non-`$`) operand is the address itself rather than a
/// reference to be dereferenced: `lea` computes it, the branches transfer to
/// it.
fn takes_bare_address(mnem: &str) -> bool {
    matches!(
        mnem,
        "lea"
            | "leaw"
            | "leal"
            | "leaq"
            | "call"
            | "callw"
            | "calll"
            | "callq"
            | "jmp"
            | "jmpw"
            | "jmpl"
            | "jmpq"
    ) || super::emit::jcc_cond(mnem).is_some()
        || super::emit::short_branch_opcode(mnem).is_some()
}

/// Segment-override prefix byte for a leading `%%fs:` / `%%gs:` (or the
/// single-`%` basic-asm spelling), with the remainder of the token.
fn split_seg_prefix(tok: &str) -> Option<(u8, &str)> {
    for (name, byte) in [
        ("es:", 0x26u8),
        ("cs:", 0x2E),
        ("ss:", 0x36),
        ("ds:", 0x3E),
        ("fs:", 0x64),
        ("gs:", 0x65),
    ] {
        if let Some(rest) = tok
            .strip_prefix("%%")
            .or_else(|| tok.strip_prefix('%'))
            .and_then(|t| t.strip_prefix(name))
        {
            return Some((byte, rest));
        }
    }
    None
}

/// Strip the register sigil from a memory-operand register token: the
/// extended-asm `%%` or the basic-asm `%`, with the whitespace GNU as allows
/// between the sigil and the name (the kernel's `_ASM_RIP(x)` expands to
/// `x (% rip)`) removed.
fn strip_reg_sigil(tok: &str) -> Option<&str> {
    let t = tok.trim();
    Some(
        t.strip_prefix("%%")
            .or_else(|| t.strip_prefix('%'))?
            .trim_start(),
    )
}

/// Parse a base / index register of a memory operand: `%%reg` (a word, long or
/// quad GP name -- the width selects the address size) or an operand reference
/// `%N` (an optional `q` size letter is the 64-bit name the address requires
/// anyway).
fn parse_mem_base(tok: &str) -> Option<AsmMemBase> {
    let body = strip_reg_sigil(tok)?;
    let digits = body.strip_prefix('q').unwrap_or(body);
    if !digits.is_empty() && digits.bytes().all(|c| c.is_ascii_digit()) {
        return Some(AsmMemBase::Ref(digits.parse().ok()?));
    }
    let (num, size) = reg_by_name(body)?;
    if num >= 16 || size == AsmRegSize::Byte {
        return None;
    }
    Some(AsmMemBase::Reg { num, size })
}

/// Byte offset of the `(` matching a token's trailing `)`, or `None` when the
/// token does not end in a balanced parenthesized group.
fn matching_open_paren(tok: &str) -> Option<usize> {
    if !tok.ends_with(')') {
        return None;
    }
    let b = tok.as_bytes();
    let mut depth = 0i32;
    for i in (0..b.len()).rev() {
        match b[i] {
            b')' => depth += 1,
            b'(' => {
                depth -= 1;
                if depth == 0 {
                    return Some(i);
                }
            }
            _ => {}
        }
    }
    None
}

/// Parse `prefix(inner)`: the `disp(%%reg)` / `disp(%N)` /
/// `disp(%%base, %%index, scale)` memory forms and the `LABEL(%rip)`
/// label-address form. `None` for shapes not modelled.
fn parse_mem_operand(prefix: &str, inner: &str, labels: &[&str]) -> Option<AsmOpnd> {
    let prefix = strip_outer_parens(prefix);
    let inner = inner.trim();
    // `(base, index, scale)`: a SIB form. The bare `(base, index)` defaults
    // the scale to 1.
    let parts = split_asm_operands(inner);
    if parts.len() >= 2 {
        if parts.len() > 3 {
            return None;
        }
        let disp = if prefix.is_empty() {
            0i32
        } else {
            i32::try_from(parse_int(prefix)?).ok()?
        };
        let index = parse_mem_base(parts[1])?;
        let scale = match parts.get(2) {
            Some(s) => match parse_int(s)? {
                v @ (1 | 2 | 4 | 8) => v as u8,
                _ => return None,
            },
            None => 1,
        };
        // An empty base field (`disp(,%index,scale)`) is the no-base
        // scaled-index form: SIB base=101, mod=00, disp32.
        if parts[0].trim().is_empty() {
            return Some(AsmOpnd::IndexMem {
                index,
                scale,
                disp,
                sym: None,
            });
        }
        return Some(AsmOpnd::Mem {
            base: parse_mem_base(parts[0])?,
            index: Some(index),
            scale,
            disp,
        });
    }
    let reg_body = strip_reg_sigil(inner)?;
    // `(%dx)`: the variable I/O port of in/out/ins/outs. dx is the only
    // register the port parentheses name; it denotes the same port as the bare
    // `%dx` spelling, so it resolves to that register operand.
    if prefix.is_empty() && reg_by_name(reg_body) == Some((2, AsmRegSize::Word)) {
        return Some(AsmOpnd::Reg {
            reg: 2,
            size: AsmRegSize::Word,
        });
    }
    if reg_body == "rip" {
        // The address of a template-local label (named or `Nf` / `Nb`).
        if let Some(idx) = labels.iter().position(|&n| n == prefix) {
            return Some(AsmOpnd::LabelAddr {
                num: NAMED_LABEL_BASE + idx as u32,
                forward: true,
            });
        }
        if let Some((digits, forward)) = prefix
            .strip_suffix('f')
            .map(|d| (d, true))
            .or_else(|| prefix.strip_suffix('b').map(|d| (d, false)))
            && !digits.is_empty()
            && digits.bytes().all(|c| c.is_ascii_digit())
        {
            return Some(AsmOpnd::LabelAddr {
                num: digits.parse().ok()?,
                forward,
            });
        }
        // `%cN(%%rip)` / `%PN(%%rip)`: the displacement is an operand
        // reference, resolved at emit (a constant becomes the disp32 literal,
        // an address a RIP-relative relocation).
        if let Some(body) = prefix.strip_prefix('%')
            && let Some(&m) = body.as_bytes().first()
            && matches!(m, b'c' | b'P')
            && body.len() > 1
            && body[1..].bytes().all(|c| c.is_ascii_digit())
        {
            return Some(AsmOpnd::RipRelRef {
                idx: body[1..].parse().ok()?,
                symbolic: m == b'P',
            });
        }
        // A literal-displacement RIP-relative reference `disp(%rip)`: the
        // address is `rip + disp`, computed at run time with no relocation. An
        // empty displacement is zero.
        let disp = if prefix.is_empty() {
            0
        } else {
            i32::try_from(parse_int(prefix)?).ok()?
        };
        return Some(AsmOpnd::RipRel { disp });
    }
    let disp = if prefix.is_empty() {
        0i32
    } else {
        i32::try_from(parse_int(prefix)?).ok()?
    };
    // An operand-reference base `%N` or an explicit base register at the
    // width it was written; the width selects the instruction's address size.
    Some(AsmOpnd::Mem {
        base: parse_mem_base(inner)?,
        index: None,
        scale: 1,
        disp,
    })
}

/// Drop parentheses enclosing a whole memory-operand displacement. The
/// displacement is an expression, so `(2f)(%rip)` and `2f(%rip)` name the
/// same address; the same holds for a symbol or an integer.
fn strip_outer_parens(s: &str) -> &str {
    let mut s = s.trim();
    while matching_open_paren(s) == Some(0) {
        s = s[1..s.len() - 1].trim();
    }
    s
}

/// Parse a decimal or `0x`-hex integer, optionally signed.
fn parse_int(s: &str) -> Option<i64> {
    crate::c5::asm::eval_const_expr(s.trim())
}

/// The location expression of an operand, or `None` when the text holds no
/// location: an integer constant, a register name, a lone template label
/// reference (which has its own operand forms), or an operand reference.
/// Anything else the assembler's expression grammar accepts and that names
/// at least one symbol or template label is returned as written; the
/// evaluator resolves it once the layout is known, folding a same-section
/// difference and relocating what is left.
fn sym_disp_expr<'a>(prefix: &'a str, labels: &[&str]) -> Option<&'a str> {
    let prefix = prefix.trim();
    // `%` in a displacement is a register or an operand reference, never a
    // link-time symbol.
    if prefix.is_empty()
        || prefix.contains('%')
        || parse_int(prefix).is_some()
        // A lone label reference has its own operand forms, parenthesized
        // (`lea (2f)(%rip)`) as much as bare.
        || parse_label_ref(strip_outer_parens(prefix), labels).is_some()
    {
        return None;
    }
    let named = core::cell::Cell::new(false);
    let resolve = |t: &str| {
        named.set(
            named.get()
                || crate::c5::asm::is_asm_symbol_template(t)
                || parse_label_ref(t, labels).is_some(),
        );
        Some(crate::c5::asm::AsmExprLeaf::Abs(0))
    };
    let ctx = crate::c5::asm::AsmExprCtx {
        resolve: &resolve,
        const_of: &|_| None,
        lax_div: true,
    };
    crate::c5::asm::eval_asm_value(prefix, &ctx).ok()?;
    named.get().then_some(prefix)
}

/// Parse a memory reference whose displacement carries a link-time symbol:
/// the RIP-relative `sym(%rip)`, the no-base `sym(,%index,scale)`, and the
/// based `disp+sym(%base[, %index, scale])` forms. Returns the displacement
/// expression and the operand, which names it by the index `expr` the caller
/// gives it; `None` for any other shape.
fn parse_sym_mem<'a>(tok: &'a str, labels: &[&str], expr: u8) -> Option<(&'a str, AsmOpnd)> {
    let open = matching_open_paren(tok)?;
    let prefix = tok[..open].trim();
    let inner = tok[open + 1..tok.len() - 1].trim();
    let sym = sym_disp_expr(prefix, labels)?;
    if strip_reg_sigil(inner) == Some("rip") {
        return Some((sym, AsmOpnd::SymRipRel { expr }));
    }
    let parts = split_asm_operands(inner);
    if parts.len() > 3 {
        return None;
    }
    let (base, index_scale) = if parts.len() >= 2 {
        let index = parse_mem_base(parts[1])?;
        let scale = match parts.get(2) {
            Some(s) => match parse_int(s)? {
                v @ (1 | 2 | 4 | 8) => v as u8,
                _ => return None,
            },
            None => 1,
        };
        let base = match parts[0].trim() {
            "" => None,
            b => Some(parse_mem_base(b)?),
        };
        (base, Some((index, scale)))
    } else {
        (Some(parse_mem_base(inner)?), None)
    };
    let opnd = match (base, index_scale) {
        (None, Some((index, scale))) => AsmOpnd::IndexMem {
            index,
            scale,
            disp: 0,
            sym: Some(expr),
        },
        (Some(base), index_scale) => AsmOpnd::SymMem {
            base,
            index: index_scale.map(|(i, _)| i),
            scale: index_scale.map(|(_, s)| s).unwrap_or(1),
            expr,
        },
        (None, None) => return None,
    };
    Some((sym, opnd))
}

/// Parse an alignment directive body through the grammar the section engine
/// reads, so a template and a named section admit the same forms. On x86
/// `.align` takes a byte count.
fn parse_align_directive(name: &str, rest: &str) -> Result<AsmSectionItem, String> {
    use super::super::ssa::emit_common as ec;
    match ec::parse_stream_layout_item(name, rest.trim(), false) {
        Some(Ok(item @ AsmSectionItem::Align { .. })) => Ok(item),
        Some(Err(e)) => Err(e),
        _ => Err(format!("inline asm: bad alignment `{rest}`")),
    }
}

/// Literal machine bytes for a raw-byte template piece, or `None` when the
/// piece is a mnemonic instruction. Two forms are recognised:
///
/// * a run of bare 2-hex-digit tokens (`CC C3 90`), each a byte value, and
/// * a `.byte` / `.word` / `.long` / `.quad` directive whose comma-separated
///   arguments are integer constants emitted little-endian at the directive's
///   width (the assembler idiom for hand-placed data).
///
/// The bare form reads its tokens as hexadecimal (so `90` is `0x90`); the
/// directive form reads C-style integer constants (`0x`-prefixed or decimal).
/// A directive with an argument that is not constant is not a raw-byte piece;
/// its values resolve at emit time.
fn parse_raw_bytes(piece: &str) -> Option<Vec<u8>> {
    let width = data_directive_width(piece.split_whitespace().next()?);
    if let Some(w) = width {
        let args = piece[piece.find(char::is_whitespace)?..].trim();
        let mut out = Vec::new();
        for a in args.split(',') {
            let v = parse_int(a.trim())?;
            out.extend_from_slice(&(v as u64).to_le_bytes()[..w]);
        }
        return Some(out);
    }
    // Bare hex-byte run: every whitespace-delimited token must be exactly two
    // hex digits, so a normal mnemonic (letters) is never mistaken for one.
    let tokens: Vec<&str> = piece.split_whitespace().collect();
    if !tokens.is_empty()
        && tokens
            .iter()
            .all(|t| t.len() == 2 && t.bytes().all(|b| b.is_ascii_hexdigit()))
    {
        let bytes = tokens
            .iter()
            .map(|t| u8::from_str_radix(t, 16).unwrap())
            .collect();
        return Some(bytes);
    }
    None
}

pub(crate) use crate::c5::asm::{NAMED_LABEL_BASE, scan_label_names, split_label_def};

/// Parse an AT&T extended-asm template into its instruction sequence.
/// Instructions are separated by `;` or newlines; operands by commas.
pub(crate) fn parse_template(tmpl: &[u8]) -> Result<Vec<AsmInsn>, String> {
    parse_template_in(tmpl, false)
}

/// Parse file-scope / section-unit asm text. Basic asm has no operand list,
/// so `%kN` is an opmask register there; everything else parses as
/// [`parse_template`] parses it.
pub(crate) fn parse_file_template(tmpl: &[u8]) -> Result<Vec<AsmInsn>, String> {
    parse_template_in(tmpl, true)
}

fn parse_template_in(tmpl: &[u8], file_scope: bool) -> Result<Vec<AsmInsn>, String> {
    let text =
        core::str::from_utf8(tmpl).map_err(|_| String::from("inline asm: non-UTF8 template"))?;
    let stripped;
    let text = match crate::c5::asm::strip_asm_comments(text, crate::c5::asm::AsmComments::X86) {
        Some(t) => {
            stripped = t;
            stripped.as_str()
        }
        None => text,
    };
    let expanded;
    let text = match crate::c5::asm::expand_template_uniq(text) {
        Some(t) => {
            expanded = t;
            expanded.as_str()
        }
        None => text,
    };
    // Pre-scan the label definitions so operand parsing can tell a local
    // label from a symbol; named labels intern in definition order.
    let names = scan_label_names(text);
    if let Some(dup) = crate::c5::asm::duplicate_label_name(text) {
        return Err(format!("inline asm: symbol `{dup}` is already defined"));
    }
    let mut insns = Vec::new();
    for piece in crate::c5::asm::split_asm_statements(text) {
        let mut piece = piece.trim();
        if piece.is_empty() {
            continue;
        }
        // A leading label definition marks this point; the rest of the
        // piece, if any, follows on the same line.
        while let Some((name, rest)) = split_label_def(piece) {
            let num = if name.as_bytes()[0].is_ascii_digit() {
                let n: u32 = name
                    .parse()
                    .ok()
                    .filter(|&n| n < NAMED_LABEL_BASE)
                    .ok_or_else(|| format!("inline asm: bad label `{piece}`"))?;
                n
            } else {
                // The pre-scan interned every named definition.
                NAMED_LABEL_BASE + names.iter().position(|&n| n == name).unwrap() as u32
            };
            insns.push(AsmInsn {
                mnemonic: Mnemonic::RawBytes,
                suffix: None,
                seg: None,
                rex: None,
                operands: Vec::new(),
                bytes: Vec::new(),
                sym_exprs: Vec::new(),
                label_def: Some(num),
                layout: None,
            });
            piece = rest.trim();
        }
        if piece.is_empty() {
            continue;
        }
        // `.cfi_*` directives describe unwind state to a DWARF consumer and
        // carry no code bytes. badc emits no unwind info for asm bodies, so
        // they are accepted and ignored.
        if piece.starts_with(".cfi_") {
            continue;
        }
        // A `.byte`-family directive whose arguments are not all constant:
        // an operand reference (`.long %c0`) or an expression over template
        // labels (`.byte 662b-661b`) resolves its value at emit time.
        if let Some((tok, rest)) = piece.split_once(char::is_whitespace)
            && let Some(w) = data_directive_width(tok)
            && parse_raw_bytes(piece).is_none()
        {
            let mut operands = Vec::new();
            let mut sym_exprs = Vec::new();
            for a in rest.split(',') {
                // Directive arguments are bare integers, not `$`-prefixed.
                let a = a.trim();
                operands.push(match parse_int(a) {
                    Some(v) => AsmOpnd::Imm(v),
                    None if a.contains('%') => parse_operand(a, &names, file_scope)?,
                    None => {
                        let expr = sym_disp_expr(a, &names).ok_or_else(|| {
                            format!("inline asm: bad `{tok}`-directive value `{a}`")
                        })?;
                        let idx = u8::try_from(sym_exprs.len())
                            .map_err(|_| String::from("inline asm: too many symbol operands"))?;
                        sym_exprs.push(String::from(expr));
                        AsmOpnd::ImmSym { expr: idx }
                    }
                });
            }
            insns.push(AsmInsn {
                mnemonic: Mnemonic::Data(w as u8),
                suffix: None,
                seg: None,
                rex: None,
                operands,
                bytes: Vec::new(),
                sym_exprs,
                label_def: None,
                layout: None,
            });
            continue;
        }
        // A raw-byte piece (hex-byte run or `.byte`-family directive) emits its
        // bytes verbatim with no operands.
        if let Some(bytes) = parse_raw_bytes(piece) {
            insns.push(AsmInsn {
                mnemonic: Mnemonic::RawBytes,
                suffix: None,
                seg: None,
                rex: None,
                operands: Vec::new(),
                bytes,
                sym_exprs: Vec::new(),
                label_def: None,
                layout: None,
            });
            continue;
        }
        // The space-and-fill family (`.skip` / `.space` / `.zero` / `.fill`)
        // repeats a unit of bytes. The count is a constant expression over
        // labels resolved at emit time (an ALTERNATIVE pads its old site to the
        // replacement length); `bytes` carries the unit to repeat.
        if let Some((dir, rest)) = piece
            .split_once(char::is_whitespace)
            .or(Some((piece, "")))
            .filter(|(d, _)| super::super::ssa::emit_common::is_fill_directive(d))
        {
            let (count_expr, unit, value) =
                super::super::ssa::emit_common::parse_fill_operands(dir, rest.trim())?;
            insns.push(AsmInsn {
                mnemonic: Mnemonic::Skip,
                suffix: None,
                seg: None,
                rex: None,
                operands: Vec::new(),
                bytes: (value as u64).to_le_bytes()[..unit as usize].to_vec(),
                sym_exprs: alloc::vec![String::from(count_expr)],
                label_def: None,
                layout: None,
            });
            continue;
        }
        // The alignment directives inside the code stream pad to an alignment
        // boundary (a `.pushsection` block handles these on its own path).
        let (dir_tok, dir_rest) = match piece.split_once(char::is_whitespace) {
            Some((t, r)) => (t, r.trim()),
            None => (piece, ""),
        };
        if super::super::ssa::emit_common::align_directive(dir_tok).is_some() {
            insns.push(AsmInsn {
                mnemonic: Mnemonic::RawBytes,
                suffix: None,
                seg: None,
                rex: None,
                operands: Vec::new(),
                bytes: Vec::new(),
                sym_exprs: Vec::new(),
                label_def: None,
                layout: Some(parse_align_directive(dir_tok, dir_rest)?),
            });
            continue;
        }
        // Mnemonic is the first whitespace-delimited token; the operand
        // list is the remainder, comma-separated.
        let (mut mnem_tok, mut rest) = match piece.find(char::is_whitespace) {
            Some(p) => (&piece[..p], piece[p..].trim()),
            None => (piece, ""),
        };
        // A prefix may lead the instruction it applies to on the same
        // statement (`rep stosw`, `lock xaddl ...`) as well as stand alone
        // (`repe; cmpsb`). Emit each leading prefix as its own entry and
        // carry on with the rest of the statement. A REX prefix is the
        // exception: leading an instruction it merges into that
        // instruction's own REX byte, as GNU as merges it, and only a
        // statement of its own deposits a byte.
        let mut rex = None;
        while !rest.is_empty()
            && let Some((Mnemonic::Prefix(b), None)) = split_mnemonic(mnem_tok)
        {
            if (0x40..=0x4F).contains(&b) {
                rex = Some(rex.unwrap_or(0x40u8) | b);
            } else {
                insns.push(AsmInsn {
                    mnemonic: Mnemonic::Prefix(b),
                    suffix: None,
                    seg: None,
                    rex: None,
                    operands: Vec::new(),
                    bytes: Vec::new(),
                    sym_exprs: Vec::new(),
                    label_def: None,
                    layout: None,
                });
            }
            (mnem_tok, rest) = match rest.find(char::is_whitespace) {
                Some(p) => (&rest[..p], rest[p..].trim()),
                None => (rest, ""),
            };
        }
        // The rest of the statement reads the mnemonic as text (the direct
        // branches below), so resolve its case once here.
        let folded = fold_mnemonic_case(mnem_tok);
        let mnem_tok = folded.as_deref().unwrap_or(mnem_tok);
        let (mnemonic, suffix) = split_mnemonic(mnem_tok)
            .ok_or_else(|| format!("inline asm: unsupported instruction `{mnem_tok}`"))?;
        // A direct `call` / `jmp` / `jcc` to a symbol name or to an expression
        // over symbols and labels (`call schedule`, `jmp sym + 4`) is a symbol
        // reference; the target is resolved to a rel32 by a relocation, not
        // parsed as a register / immediate / memory operand. A name the
        // template defines as a label resolves locally instead. The name may
        // embed operand references (`call __get_user_%c0`), which are
        // substituted at emit time, so the text is kept verbatim here.
        let is_symbol_target = !rest.is_empty()
            && (crate::c5::asm::is_asm_symbol_template(rest)
                || crate::c5::asm::is_asm_branch_expr(rest))
            && reg_by_name(rest).is_none()
            && !names.contains(&rest);
        if (matches!(
            mnem_tok,
            "call" | "callw" | "calll" | "callq" | "jmp" | "jmpw" | "jmpl" | "jmpq"
        ) || super::emit::jcc_cond(mnem_tok).is_some()
            || super::emit::short_branch_opcode(mnem_tok).is_some())
            && is_symbol_target
        {
            insns.push(AsmInsn {
                mnemonic,
                suffix,
                seg: None,
                rex,
                operands: Vec::new(),
                bytes: Vec::new(),
                sym_exprs: alloc::vec![alloc::string::String::from(rest)],
                label_def: None,
                layout: None,
            });
            continue;
        }
        let mut operands = Vec::new();
        let mut seg: Option<u8> = None;
        // Displacement and immediate expressions the operands name by index.
        let mut sym_exprs: Vec<String> = Vec::new();
        // `{%kN}` / `{z}` / `{1toN}` decorate an operand but encode as EVEX
        // prefix fields, so they are collected per instruction.
        let mut decor = EvexDecor::default();
        if !rest.is_empty() {
            for op in split_asm_operands(rest) {
                let op = strip_evex_decorators(op, &mut decor)?;
                // A `%%fs:` / `%%gs:` segment override rides the instruction
                // (one memory operand per instruction); the remainder is the
                // memory reference, a bare integer being an absolute
                // displacement.
                let tok = match split_seg_prefix(op) {
                    Some((byte, rem)) => {
                        if seg.is_some_and(|s| s != byte) {
                            return Err(String::from("inline asm: conflicting segment overrides"));
                        }
                        seg = Some(byte);
                        if let Some(v) = parse_int(rem) {
                            let disp = i32::try_from(v)
                                .map_err(|_| format!("inline asm: bad displacement `{op}`"))?;
                            operands.push(AsmOpnd::AbsMem { disp, sym: None });
                            continue;
                        }
                        rem
                    }
                    None => op,
                };
                // AT&T's indirect-branch marker `*` selects no encoding of
                // its own -- the operand kind does -- so it is stripped
                // before the operand forms are matched. It does decide how
                // a bare address reads: `jmp 0x1234` branches there,
                // `jmp *0x1234` through the word stored there.
                let (tok, indirect) = match tok.strip_prefix('*') {
                    Some(rest) => (rest, true),
                    None => (tok, false),
                };
                let next = u8::try_from(sym_exprs.len())
                    .map_err(|_| String::from("inline asm: too many symbol operands"))?;
                // `$expr`: a symbol expression the instruction takes as an
                // absolute immediate, distinct from a `$int` / `$Nf` label.
                if let Some(expr) = tok.strip_prefix('$')
                    && parse_int(expr).is_none()
                    && reg_by_name(expr).is_none()
                    && let Some(sym) = sym_disp_expr(strip_outer_parens(expr), &names)
                {
                    sym_exprs.push(String::from(sym));
                    operands.push(AsmOpnd::ImmSym { expr: next });
                    continue;
                }
                // `sym(,%index,scale)` / `disp+sym(%base)`: a memory reference
                // whose displacement is a symbol expression; the operand marks
                // where its disp32 field goes.
                if let Some((sym, opnd)) = parse_sym_mem(tok, &names, next) {
                    sym_exprs.push(String::from(sym));
                    operands.push(opnd);
                    continue;
                }
                // A bare address with no base register: AT&T spells an
                // absolute memory reference without the `$` an immediate
                // carries. The literal form is the whole address; a symbol
                // form takes a relocation in the displacement field.
                if (indirect || !takes_bare_address(mnem_tok)) && !tok.starts_with('%') {
                    if let Some(v) = parse_int(tok)
                        && let Ok(disp) = i32::try_from(v)
                    {
                        operands.push(AsmOpnd::AbsMem { disp, sym: None });
                        continue;
                    }
                    if let Some(sym) = sym_disp_expr(tok, &names) {
                        sym_exprs.push(String::from(sym));
                        operands.push(AsmOpnd::AbsMem {
                            disp: 0,
                            sym: Some(next),
                        });
                        continue;
                    }
                }
                // A bare `%cN` / `%PN` dereferences, except where the
                // instruction consumes the value as an address.
                operands.push(match parse_operand(tok, &names, file_scope)? {
                    AsmOpnd::RefConst { idx, symbolic } if !takes_bare_address(mnem_tok) => {
                        AsmOpnd::AbsMemRef { idx, symbolic }
                    }
                    o => o,
                });
            }
        }
        let mnemonic = resolve_evex(mnemonic, mnem_tok, &operands, decor)?;
        insns.push(AsmInsn {
            mnemonic,
            suffix,
            seg,
            rex,
            operands,
            bytes: Vec::new(),
            sym_exprs,
            label_def: None,
            layout: None,
        });
    }
    Ok(insns)
}

/// The EVEX decorators an instruction's operands spell.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
struct EvexDecor {
    /// Opmask register 1..8 from `{%kN}` (0 = none).
    mask: u8,
    /// `{z}` zeroing.
    zeroing: bool,
    /// `{1toN}` element count (0 = none).
    bcast: u8,
}

impl EvexDecor {
    fn any(self) -> bool {
        self != EvexDecor::default()
    }
}

/// Strip the `{...}` decorator groups from an operand token, recording them in
/// `decor`. A group standing alone is a rounding-mode or SAE control, which
/// this encoder does not implement.
fn strip_evex_decorators<'a>(op: &'a str, decor: &mut EvexDecor) -> Result<&'a str, String> {
    let mut tok = op.trim_end();
    while let Some(body) = tok.strip_suffix('}') {
        let Some(at) = body.rfind('{') else {
            return Err(format!("inline asm: unbalanced `{{` in operand `{op}`"));
        };
        let (head, group) = (body[..at].trim_end(), &body[at + 1..]);
        match group {
            "z" => decor.zeroing = true,
            // `{%kN}` or, in extended asm, the escaped `{%%kN}`.
            _ if group.starts_with("%k") || group.starts_with("%%k") => {
                let name = group.strip_prefix("%%").unwrap_or(&group[1..]);
                let Some(k) = mask_by_name(name) else {
                    return Err(format!("inline asm: `{{{group}}}` names no mask register"));
                };
                if k == 0 {
                    return Err(String::from("inline asm: `%k0` is not a write mask"));
                }
                decor.mask = k;
            }
            _ if group.starts_with("1to") => {
                let n: u8 = group[3..]
                    .parse()
                    .map_err(|_| format!("inline asm: bad broadcast `{{{group}}}`"))?;
                decor.bcast = n;
            }
            _ => {
                return Err(format!(
                    "inline asm: `{{{group}}}` (EVEX rounding / SAE control) is not supported"
                ));
            }
        }
        if head.is_empty() {
            return Err(format!(
                "inline asm: `{{{group}}}` decorates no operand; EVEX rounding / SAE controls \
                 are not supported"
            ));
        }
        tok = head;
    }
    Ok(tok)
}

/// Settle a vector instruction's encoding. VEX stays where it reaches; a
/// mnemonic that names an EVEX-only register (zmm, xmm/ymm16..31), carries a
/// decorator, or takes an operand its VEX form has no encoding for must go
/// EVEX, and a name with no EVEX form in the table is refused rather than
/// truncated onto VEX.
fn resolve_evex(
    mnemonic: Mnemonic,
    name: &str,
    operands: &[AsmOpnd],
    decor: EvexDecor,
) -> Result<Mnemonic, String> {
    // An opmask operand of a vector instruction (a compare or test
    // destination, a mask <-> vector move) has only an EVEX form; the `k*`
    // set itself is VEX-encoded and keeps its own arms.
    let native_mask = matches!(mnemonic, Mnemonic::MaskOp { .. } | Mnemonic::Kmov { .. });
    let evex_reg = operands.iter().any(|o| match *o {
        AsmOpnd::Reg { reg, .. } => {
            super::evex::reg_needs_evex(reg) || (!native_mask && is_mask_reg(reg))
        }
        _ => false,
    });
    // The VEX packed shift by immediate reads its source from a register only;
    // AVX-512 added the memory-source form. The count of a variable-count
    // shift is the one memory position VEX does encode, so memory there keeps
    // the VEX form.
    let is_mem = |o: &AsmOpnd| {
        matches!(
            o,
            AsmOpnd::Mem { .. }
                | AsmOpnd::AbsMem { .. }
                | AsmOpnd::IndexMem { .. }
                | AsmOpnd::SymMem { .. }
        )
    };
    let evex_only_operand = match mnemonic {
        Mnemonic::VexShiftImm { var_opcode, .. } => {
            let count_mem = operands.first().is_some_and(&is_mem);
            operands.iter().any(is_mem) && !(var_opcode.is_some() && count_mem)
        }
        _ => false,
    };
    let mut f = match mnemonic {
        Mnemonic::Evex(f) => f,
        _ if evex_reg || evex_only_operand || decor.any() => {
            super::evex::op(name).ok_or_else(|| {
                format!("inline asm: `{name}` has no EVEX (AVX-512) form these operands can take")
            })?
        }
        _ => return Ok(mnemonic),
    };
    (f.mask, f.zeroing, f.bcast) = (decor.mask, decor.zeroing, decor.bcast);
    Ok(Mnemonic::Evex(f))
}

// ------------------------------------------------------------------
// Encoding primitives (local copies of the shared REX / ModR/M
// helpers so this module needs no wider visibility into `encode`).
// ------------------------------------------------------------------

/// Emit a VEX prefix. `r`/`x`/`b` are the (non-inverted) high bits of ModRM.reg,
/// SIB.index, and ModRM.rm/base; VEX stores them inverted. `map` is the opcode
/// map (1 = 0F, 2 = 0F38, 3 = 0F3A), `w` the VEX.W bit, `vvvv` the src1
/// register 0..15 (inverted here), `l` the 256-bit bit, `pp` the SSE-prefix
/// selector (0/1/2/3). Uses the 2-byte form (C5) when x, b, and w are clear and
/// the map is 0F; else the 3-byte form (C4).
#[allow(clippy::too_many_arguments)]
fn emit_vex(
    code: &mut Vec<u8>,
    r: bool,
    x: bool,
    b: bool,
    map: u8,
    w: bool,
    vvvv: u8,
    l: u8,
    pp: u8,
) {
    let inv_vvvv = !vvvv & 0x0F;
    if !x && !b && !w && map == 1 {
        code.push(0xC5);
        code.push((u8::from(!r) << 7) | (inv_vvvv << 3) | (l << 2) | pp);
    } else {
        code.push(0xC4);
        code.push((u8::from(!r) << 7) | (u8::from(!x) << 6) | (u8::from(!b) << 5) | map);
        code.push((u8::from(w) << 7) | (inv_vvvv << 3) | (l << 2) | pp);
    }
}

/// Decode a [`Concrete`] xmm / ymm register to `(number, is_ymm)`. VEX reaches
/// only the low sixteen of each bank; xmm/ymm16..31 and zmm are EVEX-only and
/// are rejected here so a VEX arm never truncates one.
fn vec_reg(c: &Concrete) -> Option<(u8, bool)> {
    match c {
        Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
            Some((*reg - XMM_BASE, false))
        }
        Concrete::Reg { reg, .. } if (YMM_BASE..YMM_BASE + 16).contains(reg) => {
            Some((*reg - YMM_BASE, true))
        }
        _ => None,
    }
}

fn rex(w: bool, r: bool, x: bool, b: bool) -> u8 {
    let mut v = 0x40;
    if w {
        v |= 0x08;
    }
    if r {
        v |= 0x04;
    }
    if x {
        v |= 0x02;
    }
    if b {
        v |= 0x01;
    }
    v
}

fn modrm_reg(reg: u8, rm: u8) -> u8 {
    // Register-direct form (mod = 11).
    0xC0 | ((reg & 7) << 3) | (rm & 7)
}

/// The disp8 field of a memory reference, or `None` when the displacement
/// needs the disp32 form. `n` is the scale the hardware multiplies the field
/// by: 1 everywhere but EVEX, where the tuple type fixes it, so a
/// displacement encodes as disp8 only when it is a multiple of `n` and the
/// quotient fits a signed byte.
pub(super) fn disp8_of(disp: i32, n: i32) -> Option<i8> {
    debug_assert!(n > 0);
    (disp % n == 0)
        .then(|| disp / n)
        .and_then(|q| i8::try_from(q).ok())
}

/// Emit a ModR/M (plus SIB / displacement as the base register and `disp`
/// require) for a `disp(%base)` memory reference with ModRM.reg = `reg`.
/// REX.B for `base >= 8` and any operand-size prefix are emitted by the
/// caller. rbp / r13 (rm=101) have no mod=00 form (that means RIP-relative),
/// so a zero displacement still encodes as disp8=0 there; rsp / r12 (rm=100)
/// take a no-index SIB byte. `n` is the disp8 scale (see [`disp8_of`]).
fn modrm_mem(code: &mut Vec<u8>, reg: u8, base: u8, disp: i32, n: i32) {
    let rm = base & 7;
    let d8 = disp8_of(disp, n);
    let mod_: u8 = if disp == 0 && rm != 5 {
        0
    } else if d8.is_some() {
        1
    } else {
        2
    };
    code.push((mod_ << 6) | ((reg & 7) << 3) | rm);
    if rm == 4 {
        code.push(0x24);
    }
    match mod_ {
        1 => code.push(d8.unwrap_or_default() as u8),
        2 => code.extend_from_slice(&disp.to_le_bytes()),
        _ => {}
    }
}

/// The r/m addressing of a memory operand for the arms below: `disp(%base)`,
/// the scaled-index forms, the RIP-relative one, and the absolute address.
#[derive(Clone, Copy)]
pub(super) struct MemRm {
    /// Base register, or `None` for a RIP-relative, absolute, or base-less
    /// scaled-index reference.
    base: Option<u8>,
    /// Scaled index register and its scale.
    index: Option<(u8, u8)>,
    disp: i32,
    /// A reference with no base and no index is RIP-relative when set and an
    /// absolute address otherwise.
    riprel: bool,
}

impl MemRm {
    pub(super) fn of(c: &Concrete) -> Option<MemRm> {
        match *c {
            Concrete::Mem {
                base,
                index,
                scale,
                disp,
                ..
            } => Some(MemRm {
                base: Some(base),
                index: index.map(|i| (i, scale)),
                disp,
                riprel: false,
            }),
            Concrete::IndexMem {
                index, scale, disp, ..
            } => Some(MemRm {
                base: None,
                index: Some((index, scale)),
                disp,
                riprel: false,
            }),
            Concrete::RipRel { disp, .. } => Some(MemRm {
                base: None,
                index: None,
                disp,
                riprel: true,
            }),
            Concrete::AbsMem { disp, .. } => Some(MemRm {
                base: None,
                index: None,
                disp,
                riprel: false,
            }),
            _ => None,
        }
    }

    /// REX.B, set by a high base register. A base-less reference names none.
    pub(super) fn rex_b(self) -> bool {
        self.base.is_some_and(|b| b >= 8)
    }

    /// REX.X, set by a high index register.
    pub(super) fn rex_x(self) -> bool {
        self.index.is_some_and(|(i, _)| i >= 8)
    }

    /// Emit the ModR/M (plus SIB / displacement) with ModRM.reg = `reg` at
    /// address size `addr`, routing a 16-bit address through the fixed
    /// base / index pairs. RIP-relative is mod=00, r/m=101 with a disp32; an
    /// absolute address is mod=00, r/m=110 with a disp16 at the 16-bit
    /// address size and mod=00, r/m=101 with a disp32 outside long mode,
    /// where that encoding is not RIP-relative.
    fn emit(
        self,
        code: &mut Vec<u8>,
        mode: super::table::Mode,
        addr: u8,
        reg: u8,
    ) -> Result<(), String> {
        if addr == 2 {
            if self.riprel {
                return Err(String::from(
                    "inline asm: RIP-relative addressing exists only in 64-bit mode",
                ));
            }
            let (bytes, n) = super::table::modrm_mem16(reg, self.base, self.index, self.disp)?;
            code.extend_from_slice(&bytes[..n]);
        } else if (self.base, self.index, self.riprel) == (None, None, false)
            && mode != super::table::Mode::Bits64
        {
            code.push(((reg & 7) << 3) | 5);
            code.extend_from_slice(&self.disp.to_le_bytes());
        } else {
            self.emit_scaled(code, reg, 1);
        }
        Ok(())
    }

    /// As [`MemRm::emit`], with `n` the EVEX disp8 scale (see [`disp8_of`]).
    /// RIP-relative and the long-mode absolute form (mod=00, r/m=100, SIB
    /// base=101 index=100) take a disp32 whatever the tuple type, so `n` does
    /// not reach them.
    pub(super) fn emit_scaled(self, code: &mut Vec<u8>, reg: u8, n: i32) {
        match (self.base, self.index) {
            (Some(base), None) => modrm_mem(code, reg, base, self.disp, n),
            (base, Some((index, scale))) => modrm_sib(code, reg, base, index, scale, self.disp, n),
            (None, None) => {
                if self.riprel {
                    code.push(((reg & 7) << 3) | 5);
                } else {
                    code.push(((reg & 7) << 3) | 4);
                    code.push(0x25);
                }
                code.extend_from_slice(&self.disp.to_le_bytes());
            }
        }
    }
}

/// Emit the ModR/M + SIB + displacement of a scaled-index reference. A
/// base-less one is mod=00 with SIB.base=101 and a disp32 (the absolute
/// `disp(,%index,scale)` form); rbp / r13 as a base has no zero-displacement
/// encoding, so it takes a disp8 of zero. `n` is the disp8 scale (see
/// [`disp8_of`]).
fn modrm_sib(
    code: &mut Vec<u8>,
    reg: u8,
    base: Option<u8>,
    index: u8,
    scale: u8,
    disp: i32,
    n: i32,
) {
    let log_scale = match scale {
        1 => 0u8,
        2 => 1,
        4 => 2,
        _ => 3,
    };
    let d8 = disp8_of(disp, n);
    let mod_: u8 = match base {
        None => 0,
        Some(b) if disp == 0 && (b & 7) != 5 => 0,
        Some(_) if d8.is_some() => 1,
        Some(_) => 2,
    };
    code.push((mod_ << 6) | ((reg & 7) << 3) | 4);
    code.push((log_scale << 6) | ((index & 7) << 3) | base.map_or(5, |b| b & 7));
    match mod_ {
        1 => code.push(d8.unwrap_or_default() as u8),
        _ if base.is_none() || mod_ == 2 => code.extend_from_slice(&disp.to_le_bytes()),
        _ => {}
    }
}

/// Emit any needed operand-size / REX prefix for an instruction whose
/// operands are `size`-wide and use ModR/M.reg = `reg`, r/m = `rm`.
/// The 16-bit operand-size prefix (0x66) precedes REX per the SDM.
fn prefix_rex(code: &mut Vec<u8>, mode: super::table::Mode, size: AsmRegSize, reg: u8, rm: u8) {
    // The operand-size prefix selects the width that is not the mode default.
    if size != AsmRegSize::Byte && size != AsmRegSize::Quad && size.bytes() != mode.opsize() {
        code.push(0x66);
    }
    let w = size == AsmRegSize::Quad;
    let r = reg >= 8;
    let b = rm >= 8;
    // A byte operation naming spl/bpl/sil/dil (register numbers 4..8) needs
    // a REX prefix to select the new byte registers rather than ah/ch/dh/bh.
    let byte_rex = size == AsmRegSize::Byte && ((4..8).contains(&reg) || (4..8).contains(&rm));
    if w || r || b || byte_rex {
        code.push(rex(w, r, false, b));
    }
}

/// Map a template instruction to the table encoder's mnemonic name and its
/// operands in Intel (`dst, src`) order, or `None` when this mnemonic keeps its
/// bespoke encoding below. Template operands are AT&T (`src, dst`), so a
/// two-operand form is transposed; a shift's count operand moves after the
/// destination, and an omitted count becomes the implicit `1`. Instructions
/// naming a control / debug / segment / MMX register (marked `reg >= 16`) stay
/// on the bespoke path.
fn to_table(
    mnemonic: Mnemonic,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Option<(&'static str, Option<u8>, Vec<super::table::Opnd>)> {
    use super::table::Opnd;
    use Mnemonic as M;
    // A catalogue-passthrough mnemonic carries its own name; arrange the AT&T
    // operands into the table's Intel order by arity and route straight through.
    if let M::Table(name) = mnemonic {
        return to_table_generic(name, suffix, ops);
    }
    let name = match mnemonic {
        M::Add => "add",
        M::Sub => "sub",
        M::And => "and",
        M::Or => "or",
        M::Xor => "xor",
        M::Mov => "mov",
        M::Shl => "shl",
        M::Shr => "shr",
        M::Sar => "sar",
        M::Bswap => "bswap",
        M::Xadd => "xadd",
        M::Cmpxchg => "cmpxchg",
        M::Inc => "inc",
        M::Dec => "dec",
        M::Rdtsc => "rdtsc",
        M::Rdtscp => "rdtscp",
        M::Cpuid => "cpuid",
        M::Xgetbv => "xgetbv",
        M::Nop => "nop",
        M::Cli => "cli",
        M::Sti => "sti",
        M::Invd => "invd",
        M::Wbinvd => "wbinvd",
        M::Rdmsr => "rdmsr",
        M::Wrmsr => "wrmsr",
        M::Rdpmc => "rdpmc",
        M::Monitor => "monitor",
        M::Mwait => "mwait",
        M::Hlt => "hlt",
        _ => return None,
    };
    if ops
        .iter()
        .any(|o| matches!(o, Concrete::Reg { reg, .. } if *reg >= MMX_BASE))
    {
        return None;
    }
    let cvt = table_opnd;
    let tops: Vec<Opnd> = match mnemonic {
        M::Rdtsc
        | M::Rdtscp
        | M::Cpuid
        | M::Xgetbv
        | M::Nop
        | M::Cli
        | M::Sti
        | M::Invd
        | M::Wbinvd
        | M::Rdmsr
        | M::Wrmsr
        | M::Rdpmc
        | M::Monitor
        | M::Mwait
        | M::Hlt => Vec::new(),
        M::Bswap | M::Inc | M::Dec => match ops {
            [rm] => alloc::vec![cvt(rm)],
            _ => return None,
        },
        M::Shl | M::Shr | M::Sar => match ops {
            [dst] => alloc::vec![cvt(dst), Opnd::Imm(1)],
            [count, dst] => {
                let c = match *count {
                    Concrete::Imm(v) => Opnd::Imm(v),
                    // The shift count is CL regardless of the register's name.
                    Concrete::Reg { reg: 1, .. } => Opnd::Reg { num: 1, width: 1 },
                    _ => return None,
                };
                alloc::vec![cvt(dst), c]
            }
            _ => return None,
        },
        // ALU / mov / xadd / cmpxchg: AT&T `op src, dst` -> Intel `op dst, src`.
        _ => match ops {
            [src, dst] => alloc::vec![cvt(dst), cvt(src)],
            _ => return None,
        },
    };
    Some((name, suffix.map(|s| s.bytes()), tops))
}

/// Arrange the operands of a catalogue-passthrough mnemonic
/// ([`Mnemonic::Table`]) into the table's Intel order, by arity: no operands
/// stay empty, a unary form passes its operand, a two-operand form transposes
/// AT&T `src, dst` to `dst, src`, and a shift / rotate takes its count (CL or an
/// immediate) after the destination with an omitted count meaning `1`. Operands
/// naming a register with no catalogue form (MMX / control / debug / segment,
/// `reg >= MMX_BASE`) return `None`.
fn to_table_generic(
    name: &'static str,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Option<(&'static str, Option<u8>, Vec<super::table::Opnd>)> {
    use super::table::Opnd;
    if ops
        .iter()
        .any(|o| matches!(o, Concrete::Reg { reg, .. } if *reg >= MMX_BASE))
    {
        return None;
    }
    let shift_like = matches!(
        name,
        "shl" | "shr" | "sar" | "sal" | "rol" | "ror" | "rcl" | "rcr"
    );
    let tops = match ops {
        [] => Vec::new(),
        [rm] if shift_like => alloc::vec![table_opnd(rm), Opnd::Imm(1)],
        [rm] => alloc::vec![table_opnd(rm)],
        [count, dst] if shift_like => {
            let c = match *count {
                Concrete::Imm(v) => Opnd::Imm(v),
                // The shift / rotate count is CL regardless of the register's name.
                Concrete::Reg { reg: 1, .. } => Opnd::Reg { num: 1, width: 1 },
                _ => return None,
            };
            alloc::vec![table_opnd(dst), c]
        }
        // `imul $imm, %reg` is the three-operand form with the destination
        // repeated as the source; only the two-operand spelling reaches here,
        // since the catalogue has no immediate row of arity two.
        [Concrete::Imm(v), dst] if name == "imul" => {
            alloc::vec![table_opnd(dst), table_opnd(dst), Opnd::Imm(*v)]
        }
        [src, dst] => alloc::vec![table_opnd(dst), table_opnd(src)],
        [src, rm, dst] => alloc::vec![table_opnd(dst), table_opnd(rm), table_opnd(src)],
        _ => return None,
    };
    Some((name, suffix.map(|s| s.bytes()), tops))
}

/// Convert a resolved operand to the table encoder's operand form.
fn table_opnd(c: &Concrete) -> super::table::Opnd {
    use super::table::Opnd;
    match *c {
        Concrete::Reg { reg, size } => Opnd::Reg {
            num: reg,
            width: size.bytes(),
        },
        Concrete::HighReg(n) => Opnd::HighByteReg(n),
        Concrete::Mem {
            base,
            index,
            scale,
            disp,
            size,
        } => Opnd::Mem {
            base,
            index,
            scale,
            disp,
            width: size.bytes(),
        },
        Concrete::AbsMem { disp, size } => Opnd::AbsMem {
            disp,
            width: size.bytes(),
        },
        Concrete::IndexMem {
            index,
            scale,
            disp,
            size,
        } => Opnd::IndexMem {
            index,
            scale,
            disp,
            width: size.bytes(),
        },
        Concrete::RipRel { disp, size } => Opnd::RipRel {
            disp,
            width: size.bytes(),
        },
        Concrete::Imm(v) => Opnd::Imm(v),
    }
}

/// Bytes an encoding places after its immediate field. x86 puts the immediate
/// last, save for the direct far branch, whose 16-bit selector trails the
/// offset. The emitter needs it to settle a symbol immediate's field width by
/// re-encoding.
pub(crate) fn imm_field_tail(mnemonic: Mnemonic) -> usize {
    match mnemonic {
        Mnemonic::FarBranch { .. } => 2,
        _ => 0,
    }
}

/// Address size of an instruction's memory operand in bytes: the width of the
/// base or index register it names, or the mode default when the operand names
/// no register or the register comes from a template operand (always 64-bit).
/// `encode_in` emits the `67` prefix when this differs from the mode default.
pub(crate) fn addr_size(insn: &AsmInsn, mode: super::table::Mode) -> u8 {
    let of = |b: AsmMemBase| match b {
        AsmMemBase::Reg { size, .. } => Some(size.bytes()),
        AsmMemBase::Ref(_) => None,
    };
    insn.operands
        .iter()
        .find_map(|o| match *o {
            AsmOpnd::Mem { base, index, .. } | AsmOpnd::SymMem { base, index, .. } => {
                of(base).or_else(|| index.and_then(of))
            }
            AsmOpnd::IndexMem { index, .. } => of(index),
            _ => None,
        })
        .unwrap_or_else(|| mode.addrsize())
}

/// Encode one resolved instruction into `code` in 64-bit mode. Operands are in
/// AT&T order; `addr` is the address size in bytes the memory operand was
/// written at, from [`addr_size`]. Returns an error for an unsupported
/// mnemonic / operand form.
pub(crate) fn encode(
    code: &mut Vec<u8>,
    addr: u8,
    mnemonic: Mnemonic,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Result<(), String> {
    encode_in(
        code,
        super::table::Mode::Bits64,
        addr,
        mnemonic,
        suffix,
        ops,
    )
}

/// `mov` between the accumulator and an absolute address: the `A0`..`A3`
/// moffs forms, one byte shorter than the ModRM ones, which is what GNU as
/// selects outside long mode. In long mode the moffs address is 64 bits, a
/// width only the `movabs` spelling reaches, so a plain `mov` there keeps the
/// ModRM form. Returns whether the instruction was encoded.
fn mov_moffs(
    code: &mut Vec<u8>,
    mode: super::table::Mode,
    addr: u8,
    mnemonic: Mnemonic,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> bool {
    if mode == super::table::Mode::Bits64 || !matches!(mnemonic, Mnemonic::Mov) {
        return false;
    }
    let acc = |c: &Concrete| match *c {
        Concrete::Reg { reg: 0, size } => Some(size),
        _ => None,
    };
    let abs = |c: &Concrete| match *c {
        Concrete::AbsMem { disp, size } => Some((disp, size)),
        _ => None,
    };
    let (store, (disp, msize), rsize) = match ops {
        [src, dst] => match (acc(src), abs(dst), abs(src), acc(dst)) {
            (Some(r), Some(m), ..) => (true, m, r),
            (_, _, Some(m), Some(r)) => (false, m, r),
            _ => return false,
        },
        _ => return false,
    };
    // The accumulator and the memory operand must agree on the width, and it
    // must be one the mode encodes without REX.
    if msize != rsize || suffix.is_some_and(|s| s != rsize) || rsize == AsmRegSize::Quad {
        return false;
    }
    let byte = rsize == AsmRegSize::Byte;
    if !byte && (rsize == AsmRegSize::Word) != (mode == super::table::Mode::Bits16) {
        code.push(0x66);
    }
    if addr != mode.addrsize() {
        code.push(0x67);
    }
    code.push(match (byte, store) {
        (true, false) => 0xA0,
        (false, false) => 0xA1,
        (true, true) => 0xA2,
        (false, true) => 0xA3,
    });
    code.extend_from_slice(&(disp as u32).to_le_bytes()[..addr as usize]);
    true
}

/// Encode one resolved instruction in `mode`. `addr` is the address size in
/// bytes the instruction's memory operand was written at.
pub(crate) fn encode_in(
    code: &mut Vec<u8>,
    mode: super::table::Mode,
    addr: u8,
    mnemonic: Mnemonic,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Result<(), String> {
    if mov_moffs(code, mode, addr, mnemonic, suffix, ops) {
        return Ok(());
    }
    // An AT&T extending move: the spelled source width lands on the r/m
    // operand (AT&T first), then the catalogue encodes the Intel form.
    if let Mnemonic::ExtMov { name, src } = mnemonic {
        let mut ops = ops.to_vec();
        if let Some(o) = ops.first_mut() {
            match o {
                Concrete::Reg { size, .. }
                | Concrete::Mem { size, .. }
                | Concrete::AbsMem { size, .. }
                | Concrete::IndexMem { size, .. }
                | Concrete::RipRel { size, .. } => *size = src,
                Concrete::HighReg(_) | Concrete::Imm(_) => {}
            }
        }
        return encode_in(code, mode, addr, Mnemonic::Table(name), suffix, &ops);
    }
    // Mnemonics the table encoder covers route through it; the operands are
    // resolved to Intel order first.
    if let Some((name, width, tops)) = to_table(mnemonic, suffix, ops) {
        // The inline-asm path holds the mnemonic as text (a parsed token); map
        // it to the catalogue enum at this one boundary.
        let mnem = super::table::Mnem::from_name(name)
            .ok_or_else(|| format!("inline asm: unknown catalogue mnemonic `{name}`"))?;
        code.extend_from_slice(&super::table::encode_in(mode, addr, mnem, width, &tops)?);
        return Ok(());
    }
    let at = code.len();
    encode_bespoke(code, mode, addr, mnemonic, suffix, ops)?;
    // Outside long mode a REX byte is an `inc` / `dec` opcode, not a prefix, so
    // a bespoke form that emitted one has no encoding in this mode. Skipping
    // the legacy prefixes locates the byte the decoder would read as REX.
    if mode != super::table::Mode::Bits64 {
        let opcode = code[at..]
            .iter()
            .find(|b| {
                !matches!(
                    b,
                    0x66 | 0x67 | 0xF0 | 0xF2 | 0xF3 | 0x26 | 0x2E | 0x36 | 0x3E | 0x64 | 0x65
                )
            })
            .copied();
        if opcode.is_some_and(|b| (0x40..0x50).contains(&b)) {
            code.truncate(at);
            return Err(format!(
                "inline asm: `{mnemonic:?}` needs a REX prefix, which 16- and 32-bit modes have not"
            ));
        }
    }
    Ok(())
}

/// The forms the catalogue does not carry: the double-precision shifts, the
/// port I/O and privileged prefix forms, the MMX and control / debug / segment
/// register moves, and the interrupt / stack ops.
fn encode_bespoke(
    code: &mut Vec<u8>,
    mode: super::table::Mode,
    addr: u8,
    mnemonic: Mnemonic,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
) -> Result<(), String> {
    // Address-size prefix: `67` selects the non-default address size, ahead
    // of any operand-size prefix an arm emits. A form with no memory operand
    // addresses nothing and takes none.
    if addr != mode.addrsize()
        && ops.iter().any(|o| {
            matches!(
                o,
                Concrete::Mem { .. } | Concrete::AbsMem { .. } | Concrete::IndexMem { .. }
            )
        })
    {
        code.push(0x67);
    }
    match mnemonic {
        // Raw bytes carry their payload on the `AsmInsn`, not in `ops`; the
        // caller emits them directly and never routes them here.
        Mnemonic::RawBytes => Err(String::from(
            "inline asm: raw bytes not routed through encode",
        )),
        Mnemonic::Pause => {
            code.extend_from_slice(&[0xF3, 0x90]);
            Ok(())
        }
        Mnemonic::Prefix(b) => {
            // The instruction it applies to is the next entry, so the prefix
            // byte precedes any operand-size prefix that instruction emits.
            code.push(b);
            Ok(())
        }
        Mnemonic::Fixed(bytes) => {
            code.extend_from_slice(bytes);
            Ok(())
        }
        Mnemonic::Crc32 => {
            // AT&T `crc32<w> src, acc`: the accumulator in ModR/M.reg, the
            // source (register or memory) the r/m. The encoded forms are
            // `r32, r/m8|r/m16|r/m32` and `r64, r/m8|r/m64`, so REX.W is the
            // accumulator width and the source width must equal it unless the
            // source is a byte. A register source names its own width; the
            // size suffix supplies it for a memory source and must not
            // contradict a register one. The 0x66 prefix for a 16-bit source
            // and REX precede the F2 mandatory prefix in the order GNU as
            // emits.
            let [src, dst] = two(ops)?;
            let (acc, acc_size) = as_reg(dst)?;
            if acc >= MMX_BASE || !matches!(acc_size, AsmRegSize::Long | AsmRegSize::Quad) {
                return Err(String::from(
                    "inline asm: `crc32` takes a 32- or 64-bit general register accumulator",
                ));
            }
            let (rm, rm_size, rm_x, rm_b) = match src {
                Concrete::Reg { reg, size } if reg < MMX_BASE => {
                    (Ok(reg), Some(size), false, reg >= 8)
                }
                _ => match MemRm::of(&src) {
                    Some(mr) => (Err(mr), None, mr.rex_x(), mr.rex_b()),
                    None => {
                        return Err(String::from(
                            "inline asm: register or memory source expected for `crc32`",
                        ));
                    }
                },
            };
            let w = match (rm_size, suffix) {
                (Some(rs), Some(s)) if rs != s => {
                    return Err(String::from(
                        "inline asm: `crc32` size suffix disagrees with its source register",
                    ));
                }
                (Some(rs), _) => rs,
                (None, Some(s)) => s,
                (None, None) => acc_size,
            };
            let rex_w = acc_size == AsmRegSize::Quad;
            if w != AsmRegSize::Byte && (w == AsmRegSize::Quad) != rex_w {
                return Err(String::from(
                    "inline asm: `crc32` source width does not pair with its accumulator",
                ));
            }
            if w == AsmRegSize::Word {
                code.push(0x66);
            }
            code.push(0xF2);
            // spl/bpl/sil/dil as a byte source need a REX to select them over
            // ah/ch/dh/bh; the accumulator is never a byte register here.
            let byte_rex = w == AsmRegSize::Byte && matches!(rm, Ok(reg) if (4..8).contains(&reg));
            if rex_w || acc >= 8 || rm_x || rm_b || byte_rex {
                code.push(rex(rex_w, acc >= 8, rm_x, rm_b));
            }
            let opcode = if w == AsmRegSize::Byte { 0xF0 } else { 0xF1 };
            code.extend_from_slice(&[0x0F, 0x38, opcode]);
            match rm {
                Ok(reg) => code.push(modrm_reg(acc, reg)),
                Err(mr) => mr.emit(code, mode, addr, acc)?,
            }
            Ok(())
        }
        Mnemonic::Fsubp => {
            let i = match ops {
                [] => Some(1),
                [Concrete::Reg { reg: s, .. }, Concrete::Reg { reg: d, .. }] if *s == ST_BASE => {
                    d.checked_sub(ST_BASE).filter(|&i| i < 8)
                }
                _ => None,
            };
            let Some(i) = i else {
                return Err(String::from(
                    "inline asm: `fsubp` takes `%st, %st(i)` or no operands",
                ));
            };
            code.extend_from_slice(&[0xDE, 0xE0 + i]);
            Ok(())
        }
        Mnemonic::StringOp { opcode, opw } => {
            // The size letter alone fixes the operand width; the prefix
            // selects it when it is not the mode default.
            if opw == 2 || opw == 4 {
                if opw != mode.opsize() {
                    code.push(0x66);
                }
            } else if opw == 8 {
                code.push(rex(true, false, false, false));
            }
            code.push(opcode);
            Ok(())
        }
        Mnemonic::MemExt {
            opcode,
            ext,
            osz,
            rex_w,
        } => {
            let Some(mr) = ops.first().and_then(MemRm::of) else {
                return Err(String::from(
                    "inline asm: this instruction takes a memory operand",
                ));
            };
            if osz {
                code.push(0x66);
            }
            if rex_w || mr.rex_x() || mr.rex_b() {
                code.push(rex(rex_w, false, mr.rex_x(), mr.rex_b()));
            }
            code.push(opcode);
            mr.emit(code, mode, addr, ext)?;
            Ok(())
        }
        Mnemonic::FarBranch { ext, far, opw } => {
            let w = opw.unwrap_or(mode.opsize());
            // `$seg, $off`: AT&T writes the selector first, the encoding puts
            // the offset first. The direct form is invalid in 64-bit mode.
            if let [Concrete::Imm(seg), Concrete::Imm(off)] = *ops {
                if mode == super::table::Mode::Bits64 {
                    return Err(String::from(
                        "inline asm: the direct far branch has no 64-bit-mode encoding",
                    ));
                }
                if w != 2 && w != 4 {
                    return Err(String::from(
                        "inline asm: a direct far branch takes a 16- or 32-bit offset",
                    ));
                }
                // The offset must fit the field either signed or unsigned; the
                // selector is truncated, as GNU as does.
                let bits = u32::from(w) * 8;
                if off >> bits != 0 && off >> bits != -1 {
                    return Err(format!(
                        "inline asm: far branch offset `{off}` does not fit {bits} bits"
                    ));
                }
                if w != mode.opsize() {
                    code.push(0x66);
                }
                code.push(far);
                code.extend_from_slice(&(off as u64).to_le_bytes()[..w as usize]);
                code.extend_from_slice(&(seg as u16).to_le_bytes());
                return Ok(());
            }
            let Some(mr) = ops.first().and_then(MemRm::of) else {
                return Err(String::from(
                    "inline asm: a far branch takes a memory operand or `$seg, $off`",
                ));
            };
            if (w == 2 || w == 4) && w != mode.opsize() {
                code.push(0x66);
            }
            let rex_w = w == 8;
            if rex_w || mr.rex_x() || mr.rex_b() {
                code.push(rex(rex_w, false, mr.rex_x(), mr.rex_b()));
            }
            code.push(0xFF);
            mr.emit(code, mode, addr, ext)?;
            Ok(())
        }
        Mnemonic::MemExt0F { opcode, ext, rex_w } => {
            let Some(mr) = ops.first().and_then(MemRm::of) else {
                return Err(String::from(
                    "inline asm: this instruction takes a memory operand",
                ));
            };
            if rex_w || mr.rex_x() || mr.rex_b() {
                code.push(rex(rex_w, false, mr.rex_x(), mr.rex_b()));
            }
            code.push(0x0F);
            code.push(opcode);
            mr.emit(code, mode, addr, ext)?;
            Ok(())
        }
        Mnemonic::InvMem { opcode } => {
            // AT&T `<op> m128, r64`: the register in ModR/M.reg, the 128-bit
            // descriptor in memory the r/m. 66-prefixed with the operand size
            // fixed, so no REX.W.
            let [mem, reg] = two(ops)?;
            let (gpr, _) = as_reg(reg)?;
            if gpr >= MMX_BASE {
                return Err(String::from(
                    "inline asm: general register expected for this instruction",
                ));
            }
            let Some(mr) = MemRm::of(&mem) else {
                return Err(String::from(
                    "inline asm: this instruction takes a memory operand",
                ));
            };
            code.push(0x66);
            if gpr >= 8 || mr.rex_x() || mr.rex_b() {
                code.push(rex(false, gpr >= 8, mr.rex_x(), mr.rex_b()));
            }
            code.extend_from_slice(&[0x0F, 0x38, opcode]);
            mr.emit(code, mode, addr, gpr & 7)?;
            Ok(())
        }
        Mnemonic::SizedNullary { opcode, opw, stack } => {
            let dflt = if stack {
                mode.stack_opsize()
            } else {
                mode.opsize()
            };
            // `lret $imm` is the far return's CA iw form; the other members
            // take no operands.
            let imm = match (opcode, ops) {
                (_, []) => None,
                (0xCB, [Concrete::Imm(v)]) => Some(*v),
                (0xCB, _) => {
                    return Err(String::from(
                        "inline asm: `lret` takes an immediate or no operand",
                    ));
                }
                _ => {
                    return Err(String::from("inline asm: this mnemonic takes no operands"));
                }
            };
            match opw.unwrap_or(dflt) {
                w if w == dflt => {}
                8 => code.push(rex(true, false, false, false)),
                _ => code.push(0x66),
            }
            match imm {
                None => code.push(opcode),
                Some(v) => {
                    if !(-0x8000..=0xffff).contains(&v) {
                        return Err(format!(
                            "inline asm: far return immediate `{v}` does not fit 16 bits"
                        ));
                    }
                    code.push(0xCA);
                    code.extend_from_slice(&(v as u16).to_le_bytes());
                }
            }
            Ok(())
        }
        Mnemonic::Int => {
            // `int $imm`: int3 (imm 3) is the one-byte 0xCC breakpoint;
            // any other vector is 0xCD ib.
            match ops.first() {
                Some(Concrete::Imm(3)) => code.push(0xCC),
                Some(Concrete::Imm(n)) => code.extend_from_slice(&[0xCD, *n as u8]),
                _ => return Err(String::from("inline asm: `int` needs an immediate vector")),
            }
            Ok(())
        }
        Mnemonic::Movd => {
            // One operand is a vector register (MMX MMX_BASE..+8 or XMM
            // XMM_BASE..+16), the other a GPR / memory. `movd %vec, %gp` stores
            // (0F 7E /r), `movd %gp, %vec` loads (0F 6E /r). The vector register
            // is the ModRM.reg field, the GPR / memory the r/m. MMX has no
            // prefix; XMM adds 0x66. movd is 32-bit (no REX.W); a high XMM sets
            // REX.R, a high GPR / base REX.B.
            let [a, b] = two(ops)?;
            let vec = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (MMX_BASE..MMX_BASE + 8).contains(reg) => {
                    Some((*reg - MMX_BASE, false))
                }
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some((*reg - XMM_BASE, true))
                }
                _ => None,
            };
            let ((v_field, is_xmm), other, opcode) = if let Some(v) = vec(&a) {
                (v, b, 0x7E)
            } else if let Some(v) = vec(&b) {
                (v, a, 0x6E)
            } else {
                return Err(String::from("inline asm: `movd` needs one MMX/XMM operand"));
            };
            if is_xmm {
                code.push(0x66);
            }
            match other {
                Concrete::Reg { reg: gp_reg, .. } => {
                    if v_field >= 8 || gp_reg >= 8 {
                        code.push(rex(false, v_field >= 8, false, gp_reg >= 8));
                    }
                    code.extend_from_slice(&[0x0F, opcode]);
                    code.push(modrm_reg(v_field & 7, gp_reg & 7));
                }
                _ => {
                    let Some(mr) = MemRm::of(&other) else {
                        return Err(String::from(
                            "inline asm: `movd` operand must be a register or memory",
                        ));
                    };
                    if v_field >= 8 || mr.rex_x() || mr.rex_b() {
                        code.push(rex(false, v_field >= 8, mr.rex_x(), mr.rex_b()));
                    }
                    code.extend_from_slice(&[0x0F, opcode]);
                    mr.emit(code, mode, addr, v_field & 7)?;
                }
            }
            Ok(())
        }
        Mnemonic::Sse2Rr {
            prefix,
            map,
            opcode,
        } => {
            // `<op> %xmm_src/mem, %xmm_dst`: <prefix> [REX] 0F [38] <opcode> /r,
            // with the AT&T destination in ModRM.reg and the source (an xmm
            // register or a `(%base)` memory operand) in r/m. A high destination
            // sets REX.R, a high source register / base REX.B.
            let [src, dst] = two(ops)?;
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            let Some(d) = xmm(&dst) else {
                return Err(String::from(
                    "inline asm: this SSE op's destination must be an XMM register",
                ));
            };
            // A zero prefix means the no-mandatory-prefix packed forms (addps,
            // xorps, the SHA extensions); 0x66/0xF2/0xF3 select the double /
            // scalar / integer variants.
            if prefix != 0 {
                code.push(prefix);
            }
            let escape = |code: &mut Vec<u8>| {
                code.push(0x0F);
                if map == 2 {
                    code.push(0x38);
                }
            };
            match (xmm(&src), MemRm::of(&src)) {
                (Some(s), _) => {
                    if d >= 8 || s >= 8 {
                        code.push(rex(false, d >= 8, false, s >= 8));
                    }
                    escape(code);
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, s & 7));
                }
                (None, Some(mr)) => {
                    if d >= 8 || mr.rex_x() || mr.rex_b() {
                        code.push(rex(false, d >= 8, mr.rex_x(), mr.rex_b()));
                    }
                    escape(code);
                    code.push(opcode);
                    mr.emit(code, mode, addr, d & 7)?;
                }
                (None, None) => {
                    return Err(String::from(
                        "inline asm: this SSE op's source must be an XMM register or memory",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::SseMov {
            prefix,
            load_op,
            store_op,
            map,
        } => {
            // `mov* %src, %dst`: the xmm register is always ModRM.reg; a
            // `(%base)` memory operand is r/m. reg<-reg and reg<-mem (load) use
            // load_op, mem<-reg (store) store_op.
            let [src, dst] = two(ops)?;
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            if prefix != 0 {
                code.push(prefix);
            }
            let dir = |op: Option<u8>, what: &str| {
                op.ok_or_else(|| alloc::format!("inline asm: this SSE move has no {what} form"))
            };
            let opcode = |code: &mut Vec<u8>, op: u8| {
                code.push(0x0F);
                if map == 2 {
                    code.push(0x38);
                }
                code.push(op);
            };
            match (xmm(&src), MemRm::of(&src), xmm(&dst), MemRm::of(&dst)) {
                (Some(sn), _, Some(dn), _) => {
                    let op = dir(load_op, "register")?;
                    if dn >= 8 || sn >= 8 {
                        code.push(rex(false, dn >= 8, false, sn >= 8));
                    }
                    opcode(code, op);
                    code.push(modrm_reg(dn & 7, sn & 7));
                }
                (None, Some(mr), Some(dn), _) => {
                    let op = dir(load_op, "load")?;
                    if dn >= 8 || mr.rex_x() || mr.rex_b() {
                        code.push(rex(false, dn >= 8, mr.rex_x(), mr.rex_b()));
                    }
                    opcode(code, op);
                    mr.emit(code, mode, addr, dn & 7)?;
                }
                (Some(sn), _, None, Some(mr)) => {
                    let op = dir(store_op, "store")?;
                    if sn >= 8 || mr.rex_x() || mr.rex_b() {
                        code.push(rex(false, sn >= 8, mr.rex_x(), mr.rex_b()));
                    }
                    opcode(code, op);
                    mr.emit(code, mode, addr, sn & 7)?;
                }
                _ => {
                    return Err(String::from(
                        "inline asm: SSE move needs an xmm register with an xmm or memory operand",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::SseRmImm {
            prefix,
            map,
            opcode,
            w,
            store,
        } => {
            // `<op> $imm, %src, %dst`: <prefix> [REX] 0F [38|3A] <opcode> /r ib.
            // The vector operand is ModRM.reg: the AT&T destination normally,
            // the source for the extracts, whose r/m is the destination.
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            let [imm, src, dst] = ops else {
                return Err(String::from(
                    "inline asm: this SSE op needs $imm, %src, %dst",
                ));
            };
            let Concrete::Imm(ib) = imm else {
                return Err(String::from("inline asm: SSE immediate expected"));
            };
            let (vector, other) = if store { (src, dst) } else { (dst, src) };
            // ModRM.reg holds the vector operand, or a general register for
            // the `0F C5` word extract, whose r/m holds the vector.
            let Some(v) = xmm(vector).or(match vector {
                Concrete::Reg { reg, .. } if *reg < 16 => Some(*reg),
                _ => None,
            }) else {
                return Err(String::from(
                    "inline asm: this SSE op's vector operand must be an XMM register",
                ));
            };
            if prefix != 0 {
                code.push(prefix);
            }
            // The r/m operand is an XMM register, a general register (the
            // insert / extract element forms), or memory.
            let gp = match other {
                Concrete::Reg { reg, .. } if xmm(other).is_none() => Some(*reg),
                _ => None,
            };
            let escape = |code: &mut Vec<u8>| {
                code.push(0x0F);
                match map {
                    2 => code.push(0x38),
                    3 => code.push(0x3A),
                    _ => {}
                }
            };
            match (xmm(other).or(gp), MemRm::of(other)) {
                (Some(o), _) => {
                    if w || v >= 8 || o >= 8 {
                        code.push(rex(w, v >= 8, false, o >= 8));
                    }
                    escape(code);
                    code.push(opcode);
                    code.push(modrm_reg(v & 7, o & 7));
                }
                (None, Some(mr)) => {
                    if w || v >= 8 || mr.rex_x() || mr.rex_b() {
                        code.push(rex(w, v >= 8, mr.rex_x(), mr.rex_b()));
                    }
                    escape(code);
                    code.push(opcode);
                    mr.emit(code, mode, addr, v & 7)?;
                }
                (None, None) => {
                    return Err(String::from(
                        "inline asm: this SSE op's other operand must be a register or memory",
                    ));
                }
            }
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::SseShiftImm {
            opcode,
            digit,
            var_opcode,
        } => {
            // `<op> $imm, %xmm`: 66 [REX.B] 0F <opcode> /digit ib. The opcode
            // extension `digit` rides ModRM.reg, the xmm sits in r/m.
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            let [imm, reg] = ops else {
                return Err(String::from("inline asm: packed shift needs $imm, %xmm"));
            };
            let Some(r) = xmm(reg) else {
                return Err(String::from("inline asm: packed shift operand must be xmm"));
            };
            // `<op> %xmm_count, %xmm`: 66 [REX] 0F <var_opcode> /r, the
            // destination in ModRM.reg and the count in r/m.
            let Concrete::Imm(ib) = imm else {
                let Some(var) = var_opcode else {
                    return Err(String::from("inline asm: packed shift immediate expected"));
                };
                let (reg_count, mem_count) = (xmm(imm), MemRm::of(imm));
                let (x, b) = match (reg_count, &mem_count) {
                    (Some(c), _) => (false, c >= 8),
                    (None, Some(mr)) => (mr.rex_x(), mr.rex_b()),
                    (None, None) => {
                        return Err(String::from(
                            "inline asm: packed shift count must be an immediate, xmm or memory",
                        ));
                    }
                };
                code.push(0x66);
                if r >= 8 || x || b {
                    code.push(rex(false, r >= 8, x, b));
                }
                code.extend_from_slice(&[0x0F, var]);
                match (reg_count, mem_count) {
                    (Some(c), _) => code.push(modrm_reg(r & 7, c & 7)),
                    (None, Some(mr)) => mr.emit(code, mode, addr, r & 7)?,
                    (None, None) => unreachable!("checked above"),
                }
                return Ok(());
            };
            code.push(0x66);
            if r >= 8 {
                code.push(rex(false, false, false, true));
            }
            code.extend_from_slice(&[0x0F, opcode]);
            code.push(modrm_reg(digit, r & 7));
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::MaskOp {
            pp,
            map,
            w,
            opcode,
            l,
            vvvv,
            imm,
        } => {
            let bad =
                || String::from("inline asm: an opmask instruction takes `%k0`..`%k7` operands");
            let (ib, rest) = match (imm, ops) {
                (true, [Concrete::Imm(v), rest @ ..]) => (Some(*v as u8), rest),
                (true, _) => {
                    return Err(String::from(
                        "inline asm: an opmask shift takes an immediate count",
                    ));
                }
                (false, _) => (None, ops),
            };
            let (src2, src1, dst) = match (vvvv, rest) {
                (true, [s2, s1, d]) => (s2, Some(s1), d),
                (false, [s, d]) => (s, None, d),
                _ => return Err(String::from("inline asm: opmask operand count")),
            };
            let (Some(rm), Some(reg)) = (mask_reg_num(src2), mask_reg_num(dst)) else {
                return Err(bad());
            };
            let v = match src1 {
                Some(o) => mask_reg_num(o).ok_or_else(bad)?,
                None => 0,
            };
            emit_vex(code, false, false, false, map, w, v, l, pp);
            code.push(opcode);
            code.push(modrm_reg(reg, rm));
            code.extend(ib);
            Ok(())
        }
        Mnemonic::Kmov { width } => {
            let [src, dst] = two(ops)?;
            // Prefix selections: `(pp, w)` of the opmask / memory pair
            // (90 load, 91 store) and of the general-register pair (92 in,
            // 93 out). The general register is 32-bit except under `kmovq`.
            let (kpp, kw) = (u8::from(matches!(width, 1 | 4)), width >= 4);
            let gpp = match width {
                1 => 1,
                2 => 0,
                _ => 3,
            };
            let gw = width == 8;
            let gpr = |c: &Concrete| match *c {
                Concrete::Reg { reg, size } if reg < MMX_BASE => Some((reg, size)),
                _ => None,
            };
            let gsize = if width == 8 {
                AsmRegSize::Quad
            } else {
                AsmRegSize::Long
            };
            let check = |s: AsmRegSize| {
                (s == gsize).then_some(()).ok_or_else(|| {
                    format!(
                        "inline asm: `kmov` takes a {}-bit general register",
                        gsize.bytes() * 8
                    )
                })
            };
            match (mask_reg_num(&src), mask_reg_num(&dst)) {
                (Some(s), Some(d)) => {
                    emit_vex(code, false, false, false, 1, kw, 0, 0, kpp);
                    code.extend([0x90, modrm_reg(d, s)]);
                }
                (None, Some(d)) => {
                    if let Some((g, size)) = gpr(&src) {
                        check(size)?;
                        emit_vex(code, false, false, g >= 8, 1, gw, 0, 0, gpp);
                        code.extend([0x92, modrm_reg(d, g)]);
                    } else {
                        let mr = MemRm::of(&src)
                            .ok_or_else(|| String::from("inline asm: bad `kmov` source operand"))?;
                        emit_vex(code, false, mr.rex_x(), mr.rex_b(), 1, kw, 0, 0, kpp);
                        code.push(0x90);
                        mr.emit(code, mode, addr, d)?;
                    }
                }
                (Some(s), None) => {
                    if let Some((g, size)) = gpr(&dst) {
                        check(size)?;
                        emit_vex(code, g >= 8, false, false, 1, gw, 0, 0, gpp);
                        code.extend([0x93, modrm_reg(g, s)]);
                    } else {
                        let mr = MemRm::of(&dst).ok_or_else(|| {
                            String::from("inline asm: bad `kmov` destination operand")
                        })?;
                        emit_vex(code, false, mr.rex_x(), mr.rex_b(), 1, kw, 0, 0, kpp);
                        code.push(0x91);
                        mr.emit(code, mode, addr, s)?;
                    }
                }
                (None, None) => {
                    return Err(String::from(
                        "inline asm: `kmov` needs an opmask register operand",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::Vex { pp, map, w, opcode } => {
            // 3-operand VEX: dst in ModRM.reg, src1 in VEX.vvvv (inverted), src2
            // in ModRM.rm. `L` is set when any operand is a ymm.
            let [src2, src1, dst] = ops else {
                return Err(String::from("inline asm: VEX op needs %src2, %src1, %dst"));
            };
            let (Some((d, dy)), Some((s1, s1y))) = (vec_reg(dst), vec_reg(src1)) else {
                return Err(String::from("inline asm: VEX dst / src1 must be xmm/ymm"));
            };
            match src2 {
                _ if vec_reg(src2).is_some() => {
                    let (s2, s2y) = vec_reg(src2).unwrap();
                    let l = u8::from(dy || s1y || s2y);
                    emit_vex(code, d >= 8, false, s2 >= 8, map, w, s1, l, pp);
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, s2 & 7));
                }
                _ => {
                    // src2 is a memory operand: VEX.B carries the base's high bit;
                    // L comes from the register operands.
                    let Some(mr) = MemRm::of(src2) else {
                        return Err(String::from(
                            "inline asm: VEX src2 must be xmm/ymm or memory",
                        ));
                    };
                    let l = u8::from(dy || s1y);
                    emit_vex(code, d >= 8, mr.rex_x(), mr.rex_b(), map, w, s1, l, pp);
                    code.push(opcode);
                    mr.emit(code, mode, addr, d & 7)?;
                }
            }
            Ok(())
        }
        Mnemonic::VexMovd { w } => {
            // The destination register rides ModRM.reg and the source the r/m,
            // as for the legacy `movd`. A general-register operand takes the
            // 66 map with VEX.W selecting the width; the xmm-to-xmm and
            // memory-load forms of `vmovq` take F3 7E, and its memory store
            // 66 D6. VEX.vvvv is unused (1111, passed as 0).
            let [src, dst] = two(ops)?;
            let xmm = |c: &Concrete| match c {
                Concrete::Reg { reg, .. } if (XMM_BASE..XMM_BASE + 16).contains(reg) => {
                    Some(*reg - XMM_BASE)
                }
                _ => None,
            };
            // A general-register transfer's width is the register's, whichever
            // of the two spellings names it: GNU as takes `vmovd %rcx, %xmm0`
            // as the 64-bit transfer.
            let gpr = |c: &Concrete| match c {
                Concrete::Reg { reg, size } if *reg < MMX_BASE => {
                    Some((*reg, w || *size == AsmRegSize::Quad))
                }
                _ => None,
            };
            // VEX.W selects the width of a general-register transfer only;
            // the xmm and memory forms are W-ignored and take the 2-byte VEX.
            let vex = |code: &mut Vec<u8>, r, x, b, pp, w| emit_vex(code, r, x, b, 1, w, 0, 0, pp);
            match (xmm(&src), xmm(&dst)) {
                // xmm to xmm: the 64-bit member only, F3 7E, destination in
                // ModRM.reg.
                (Some(s), Some(d)) if w => {
                    vex(code, d >= 8, false, s >= 8, 2, false);
                    code.push(0x7E);
                    code.push(modrm_reg(d & 7, s & 7));
                }
                (_, Some(d)) => match gpr(&src) {
                    Some((g, gw)) => {
                        vex(code, d >= 8, false, g >= 8, 1, gw);
                        code.push(0x6E);
                        code.push(modrm_reg(d & 7, g & 7));
                    }
                    None => {
                        let mr = MemRm::of(&src).ok_or(BAD_VMOV_OPND)?;
                        // A memory load of the 64-bit member is F3 7E; the
                        // 32-bit member keeps the 66 6E form.
                        let pp = if w { 2 } else { 1 };
                        vex(code, d >= 8, mr.rex_x(), mr.rex_b(), pp, false);
                        code.push(if w { 0x7E } else { 0x6E });
                        mr.emit(code, mode, addr, d & 7)?;
                    }
                },
                (Some(s), None) => match gpr(&dst) {
                    Some((g, gw)) => {
                        vex(code, s >= 8, false, g >= 8, 1, gw);
                        code.push(0x7E);
                        code.push(modrm_reg(s & 7, g & 7));
                    }
                    None => {
                        let mr = MemRm::of(&dst).ok_or(BAD_VMOV_OPND)?;
                        vex(code, s >= 8, mr.rex_x(), mr.rex_b(), 1, false);
                        code.push(if w { 0xD6 } else { 0x7E });
                        mr.emit(code, mode, addr, s & 7)?;
                    }
                },
                _ => {
                    return Err(String::from(
                        "inline asm: `vmovd`/`vmovq` needs an xmm operand",
                    ));
                }
            }
            Ok(())
        }
        Mnemonic::VexMov {
            pp,
            load_op,
            store_op,
        } => {
            // 2-operand VEX move (VEX.vvvv = 1111, passed as 0 to `emit_vex`).
            let [src, dst] = two(ops)?;
            if let Some((d, dy)) = vec_reg(&dst) {
                // reg-reg or load: the destination register rides ModRM.reg.
                match &src {
                    _ if vec_reg(&src).is_some() => {
                        let (s, sy) = vec_reg(&src).unwrap();
                        // Between registers the two directions encode the same
                        // move, and only VEX.B forces the 3-byte prefix, so a
                        // high source into a low destination takes the store
                        // opcode. GNU as makes the same choice.
                        let (op, r, m) = if s >= 8 && d < 8 {
                            (store_op, s, d)
                        } else {
                            (load_op, d, s)
                        };
                        emit_vex(
                            code,
                            r >= 8,
                            false,
                            m >= 8,
                            1,
                            false,
                            0,
                            u8::from(dy || sy),
                            pp,
                        );
                        code.push(op);
                        code.push(modrm_reg(r & 7, m & 7));
                    }
                    _ => {
                        let Some(mr) = MemRm::of(&src) else {
                            return Err(String::from(
                                "inline asm: VEX move source must be xmm/ymm/mem",
                            ));
                        };
                        emit_vex(
                            code,
                            d >= 8,
                            mr.rex_x(),
                            mr.rex_b(),
                            1,
                            false,
                            0,
                            u8::from(dy),
                            pp,
                        );
                        code.push(load_op);
                        mr.emit(code, mode, addr, d & 7)?;
                    }
                }
            } else if let (Some((s, sy)), Some(mr)) = (vec_reg(&src), MemRm::of(&dst)) {
                // store: the source register rides ModRM.reg, memory the r/m.
                emit_vex(
                    code,
                    s >= 8,
                    mr.rex_x(),
                    mr.rex_b(),
                    1,
                    false,
                    0,
                    u8::from(sy),
                    pp,
                );
                code.push(store_op);
                mr.emit(code, mode, addr, s & 7)?;
            } else {
                return Err(String::from("inline asm: unsupported VEX move operands"));
            }
            Ok(())
        }
        Mnemonic::Vex2 {
            pp,
            map,
            opcode,
            mem_only,
        } => {
            // 2-operand VEX op (VEX.vvvv = 1111), src a register or memory.
            let [src, dst] = two(ops)?;
            let Some((d, dy)) = vec_reg(&dst) else {
                return Err(String::from("inline asm: VEX2 destination must be xmm/ymm"));
            };
            if mem_only && vec_reg(&src).is_some() {
                return Err(String::from(
                    "inline asm: a 128-bit lane broadcast takes a memory source",
                ));
            }
            match &src {
                _ if vec_reg(&src).is_some() => {
                    let (s, sy) = vec_reg(&src).unwrap();
                    emit_vex(
                        code,
                        d >= 8,
                        false,
                        s >= 8,
                        map,
                        false,
                        0,
                        u8::from(dy || sy),
                        pp,
                    );
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, s & 7));
                }
                _ => {
                    let Some(mr) = MemRm::of(&src) else {
                        return Err(String::from(
                            "inline asm: VEX2 source must be xmm/ymm or memory",
                        ));
                    };
                    emit_vex(
                        code,
                        d >= 8,
                        mr.rex_x(),
                        mr.rex_b(),
                        map,
                        false,
                        0,
                        u8::from(dy),
                        pp,
                    );
                    code.push(opcode);
                    mr.emit(code, mode, addr, d & 7)?;
                }
            }
            Ok(())
        }
        Mnemonic::VexImm3 {
            pp,
            map,
            opcode,
            is4,
        } => {
            // `v-op $imm, %src2, %src1, %dst`: the 3-operand VEX with a trailing
            // immediate byte; src2 may be a register or memory operand. Under
            // `is4` the leading operand is the mask register, whose number rides
            // the top four bits of that byte.
            let [lead, src2, src1, dst] = ops else {
                return Err(String::from(if is4 {
                    "inline asm: VEX blend needs %mask, %src2, %src1, %dst"
                } else {
                    "inline asm: VEX shuffle needs $imm, %src2, %src1, %dst"
                }));
            };
            let (tail, leady) = if is4 {
                let Some((m, my)) = vec_reg(lead) else {
                    return Err(String::from("inline asm: VEX blend mask must be xmm/ymm"));
                };
                (m << 4, my)
            } else {
                let Concrete::Imm(ib) = lead else {
                    return Err(String::from("inline asm: VEX shuffle immediate expected"));
                };
                (*ib as u8, false)
            };
            let (Some((d, dy)), Some((s1, s1y))) = (vec_reg(dst), vec_reg(src1)) else {
                return Err(String::from(
                    "inline asm: VEX shuffle dst / src1 must be xmm/ymm",
                ));
            };
            match src2 {
                _ if vec_reg(src2).is_some() => {
                    let (s2, s2y) = vec_reg(src2).unwrap();
                    let l = u8::from(dy || s1y || s2y || leady);
                    emit_vex(code, d >= 8, false, s2 >= 8, map, false, s1, l, pp);
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, s2 & 7));
                }
                _ => {
                    let Some(mr) = MemRm::of(src2) else {
                        return Err(String::from(
                            "inline asm: VEX shuffle src2 must be xmm/ymm or memory",
                        ));
                    };
                    let l = u8::from(dy || s1y || leady);
                    emit_vex(code, d >= 8, mr.rex_x(), mr.rex_b(), map, false, s1, l, pp);
                    code.push(opcode);
                    mr.emit(code, mode, addr, d & 7)?;
                }
            }
            code.push(tail);
            Ok(())
        }
        Mnemonic::VexImm2 {
            pp,
            map,
            opcode,
            store,
        } => {
            // `v-op $imm, %src, %dst`: a 2-operand VEX (VEX.vvvv = 1111) + imm.
            // ModRM.reg holds the AT&T destination, or the source for a lane
            // extract, whose r/m is the destination; the other operand may be a
            // register or memory. `L` follows the ModRM.reg operand's width,
            // which for an extract is the wide source.
            let [imm, src, dst] = ops else {
                return Err(String::from(
                    "inline asm: VEX shuffle needs $imm, %src, %dst",
                ));
            };
            let Concrete::Imm(ib) = imm else {
                return Err(String::from("inline asm: VEX shuffle immediate expected"));
            };
            let (in_reg, in_rm) = if store { (src, dst) } else { (dst, src) };
            let Some((r, ry)) = vec_reg(in_reg) else {
                return Err(String::from(
                    "inline asm: VEX shuffle register operand must be xmm/ymm",
                ));
            };
            match in_rm {
                _ if vec_reg(in_rm).is_some() => {
                    let (m, my) = vec_reg(in_rm).unwrap();
                    let l = u8::from(ry || (my && !store));
                    emit_vex(code, r >= 8, false, m >= 8, map, false, 0, l, pp);
                    code.push(opcode);
                    code.push(modrm_reg(r & 7, m & 7));
                }
                _ => {
                    let Some(mr) = MemRm::of(in_rm) else {
                        return Err(String::from(
                            "inline asm: VEX shuffle source must be xmm/ymm or memory",
                        ));
                    };
                    emit_vex(
                        code,
                        r >= 8,
                        mr.rex_x(),
                        mr.rex_b(),
                        map,
                        false,
                        0,
                        u8::from(ry),
                        pp,
                    );
                    code.push(opcode);
                    mr.emit(code, mode, addr, r & 7)?;
                }
            }
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::VexShiftImm {
            opcode,
            digit,
            var_opcode,
        } => {
            // `v-op $imm, %src, %dst`: VEX(vvvv=dst, L, pp=66, 0F) <opcode>
            // /digit ib. The destination rides VEX.vvvv, the opcode extension
            // ModRM.reg, and the source ModRM.rm.
            let [imm, src, dst] = ops else {
                return Err(String::from(
                    "inline asm: VEX packed shift needs $imm, %src, %dst",
                ));
            };
            let (Some((d, dy)), Some((s, sy))) = (vec_reg(dst), vec_reg(src)) else {
                return Err(String::from(
                    "inline asm: VEX packed shift operands must be xmm/ymm",
                ));
            };
            // `v-op %xmm_count, %src, %dst`: the count is xmm/m128 whatever
            // the destination width, so it takes ModRM.rm and the source
            // VEX.vvvv, and L follows destination and source.
            let Concrete::Imm(ib) = imm else {
                let Some(var) = var_opcode else {
                    return Err(String::from(
                        "inline asm: VEX packed shift immediate expected",
                    ));
                };
                let l = u8::from(dy || sy);
                match vec_reg(imm) {
                    Some((c, false)) => {
                        emit_vex(code, d >= 8, false, c >= 8, 1, false, s, l, 1);
                        code.push(var);
                        code.push(modrm_reg(d & 7, c & 7));
                    }
                    Some(_) => {
                        return Err(String::from("inline asm: VEX packed shift count is xmm"));
                    }
                    None => {
                        let Some(mr) = MemRm::of(imm) else {
                            return Err(String::from(
                                "inline asm: VEX packed shift count must be an immediate, \
                                 xmm or memory",
                            ));
                        };
                        emit_vex(code, d >= 8, mr.rex_x(), mr.rex_b(), 1, false, s, l, 1);
                        code.push(var);
                        mr.emit(code, mode, addr, d & 7)?;
                    }
                }
                return Ok(());
            };
            emit_vex(
                code,
                false,
                false,
                s >= 8,
                1,
                false,
                d,
                u8::from(dy || sy),
                1,
            );
            code.push(opcode);
            code.push(modrm_reg(digit, s & 7));
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::VexElemExtract {
            map,
            opcode,
            w,
            reg_form,
        } => {
            let [Concrete::Imm(ib), src, dst] = ops else {
                return Err(String::from(
                    "inline asm: VEX element extract needs $imm, %xmm, r/m",
                ));
            };
            let Some((s, false)) = vec_reg(src) else {
                return Err(String::from(
                    "inline asm: VEX element extract source must be xmm",
                ));
            };
            match (dst, reg_form) {
                // The word extract's 0F-map form takes the general register in
                // ModRM.reg and the xmm in r/m.
                (Concrete::Reg { reg: g, .. }, Some(op0f)) if *g < 16 => {
                    emit_vex(code, *g >= 8, false, s >= 8, 1, w, 0, 0, 1);
                    code.push(op0f);
                    code.push(modrm_reg(*g & 7, s & 7));
                }
                (Concrete::Reg { reg: g, .. }, _) if *g < 16 => {
                    emit_vex(code, s >= 8, false, *g >= 8, map, w, 0, 0, 1);
                    code.push(opcode);
                    code.push(modrm_reg(s & 7, *g & 7));
                }
                _ => {
                    let Some(mr) = MemRm::of(dst) else {
                        return Err(String::from(
                            "inline asm: VEX element extract destination must be a general \
                             register or memory",
                        ));
                    };
                    emit_vex(code, s >= 8, mr.rex_x(), mr.rex_b(), map, w, 0, 0, 1);
                    code.push(opcode);
                    mr.emit(code, mode, addr, s & 7)?;
                }
            }
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::VexElemInsert { map, opcode, w } => {
            let [Concrete::Imm(ib), src2, src1, dst] = ops else {
                return Err(String::from(
                    "inline asm: VEX element insert needs $imm, r/m, %xmm, %xmm",
                ));
            };
            let (Some((d, false)), Some((s1, false))) = (vec_reg(dst), vec_reg(src1)) else {
                return Err(String::from(
                    "inline asm: VEX element insert dst / src1 must be xmm",
                ));
            };
            match src2 {
                Concrete::Reg { reg: g, .. } if *g < 16 => {
                    emit_vex(code, d >= 8, false, *g >= 8, map, w, s1, 0, 1);
                    code.push(opcode);
                    code.push(modrm_reg(d & 7, *g & 7));
                }
                _ => {
                    let Some(mr) = MemRm::of(src2) else {
                        return Err(String::from(
                            "inline asm: VEX element insert source must be a general register \
                             or memory",
                        ));
                    };
                    emit_vex(code, d >= 8, mr.rex_x(), mr.rex_b(), map, w, s1, 0, 1);
                    code.push(opcode);
                    mr.emit(code, mode, addr, d & 7)?;
                }
            }
            code.push(*ib as u8);
            Ok(())
        }
        Mnemonic::Evex(f) => super::evex::encode(code, f, ops),
        Mnemonic::VexNullary { l } => {
            if !ops.is_empty() {
                return Err(String::from("inline asm: this VEX op takes no operands"));
            }
            emit_vex(code, false, false, false, 1, false, 0, l, 0);
            code.push(0x77);
            Ok(())
        }
        Mnemonic::VexGpr {
            pp,
            map,
            opcode,
            imm,
            vvvv_first,
        } => {
            let gpr = |c: &Concrete| match *c {
                Concrete::Reg { reg, size } if reg < MMX_BASE => Some((reg, size)),
                _ => None,
            };
            // `rorx $imm, src2, dst` binds no VEX.vvvv; the rest are
            // `src, src, dst` with one of the two sources in VEX.vvvv.
            let (ib, src2, src1, dst) = match (imm, ops) {
                (true, [i, s2, d]) => (Some(i), s2, None, d),
                (false, [a, b, d]) if vvvv_first => (None, b, Some(a), d),
                (false, [a, b, d]) => (None, a, Some(b), d),
                _ => {
                    return Err(String::from(
                        "inline asm: bad operand count for this VEX op",
                    ));
                }
            };
            let Some((dn, size)) = gpr(dst) else {
                return Err(String::from(
                    "inline asm: this VEX op's destination must be a general register",
                ));
            };
            let vvvv = match src1 {
                Some(s) => match gpr(s) {
                    Some((n, _)) => n,
                    None => {
                        return Err(String::from(
                            "inline asm: this VEX op's source must be a general register",
                        ));
                    }
                },
                None => 0,
            };
            let w = size == AsmRegSize::Quad;
            match gpr(src2) {
                Some((sn, _)) => {
                    emit_vex(code, dn >= 8, false, sn >= 8, map, w, vvvv, 0, pp);
                    code.push(opcode);
                    code.push(modrm_reg(dn & 7, sn & 7));
                }
                None => {
                    let Some(mr) = MemRm::of(src2) else {
                        return Err(String::from(
                            "inline asm: this VEX op's source must be a register or memory",
                        ));
                    };
                    emit_vex(code, dn >= 8, mr.rex_x(), mr.rex_b(), map, w, vvvv, 0, pp);
                    code.push(opcode);
                    mr.emit(code, mode, addr, dn & 7)?;
                }
            }
            if let Some(Concrete::Imm(v)) = ib {
                code.push(*v as u8);
            }
            Ok(())
        }
        Mnemonic::In | Mnemonic::Out => {
            // AT&T `in port, acc` / `out acc, port`. The accumulator
            // (AL/AX/EAX) is implicit; only the width and the port form
            // select the opcode. Width comes from the suffix (inb/inw/inl),
            // else the accumulator operand.
            let is_in = matches!(mnemonic, Mnemonic::In);
            let (port, acc) = if is_in {
                (ops.first(), ops.get(1))
            } else {
                (ops.get(1), ops.first())
            };
            let size = suffix
                .or(acc.and_then(|o| match o {
                    Concrete::Reg { size, .. } => Some(*size),
                    _ => None,
                }))
                .unwrap_or(AsmRegSize::Long);
            if size == AsmRegSize::Word {
                code.push(0x66);
            }
            let byte = size == AsmRegSize::Byte;
            match port {
                // Immediate-port form: E4/E5 (in), E6/E7 (out), imm8 port.
                Some(Concrete::Imm(p)) if (0..=255).contains(p) => {
                    code.push(match (is_in, byte) {
                        (true, true) => 0xE4,
                        (true, false) => 0xE5,
                        (false, true) => 0xE6,
                        (false, false) => 0xE7,
                    });
                    code.push(*p as u8);
                }
                // Variable-port form: EC/ED (in), EE/EF (out), port in dx.
                _ => code.push(match (is_in, byte) {
                    (true, true) => 0xEC,
                    (true, false) => 0xED,
                    (false, true) => 0xEE,
                    (false, false) => 0xEF,
                }),
            }
            Ok(())
        }
        Mnemonic::Shld | Mnemonic::Shrd => {
            // AT&T `shld count, src, dst` -> Intel `SHLD dst, src, count`.
            let [count, src, dst] = three(ops)?;
            let (src_reg, ssz) = as_reg(src)?;
            let (dst_reg, dsz) = as_reg(dst)?;
            let size = suffix.unwrap_or(if dsz == AsmRegSize::Byte { ssz } else { dsz });
            let (op_cl, op_imm) = if mnemonic == Mnemonic::Shld {
                (0xA5u8, 0xA4u8)
            } else {
                (0xADu8, 0xACu8)
            };
            prefix_rex(code, mode, size, src_reg, dst_reg);
            code.push(0x0F);
            match count {
                Concrete::Imm(v) => {
                    code.push(op_imm);
                    code.push(modrm_reg(src_reg, dst_reg));
                    code.push((v & 0xFF) as u8);
                }
                Concrete::HighReg(_) => {
                    return Err(String::from(
                        "inline asm: double-shift count must be CL or an immediate",
                    ));
                }
                Concrete::Reg { reg, .. } => {
                    if reg != 1 {
                        return Err(String::from(
                            "inline asm: double-shift count must be CL or an immediate",
                        ));
                    }
                    code.push(op_cl);
                    code.push(modrm_reg(src_reg, dst_reg));
                }
                Concrete::Mem { .. }
                | Concrete::AbsMem { .. }
                | Concrete::RipRel { .. }
                | Concrete::IndexMem { .. } => {
                    return Err(String::from("inline asm: double-shift count in memory"));
                }
            }
            Ok(())
        }
        // Only control / debug / segment register moves reach here; the general
        // register / memory / immediate moves route through the table encoder.
        //   read  cr/dr -> gpr, seg -> r/m16 : 0F 20 / 0F 21 / 8C
        //   write gpr -> cr/dr, r/m16 -> seg : 0F 22 / 0F 23 / 8E
        Mnemonic::Mov => {
            let [src, dst] = two(ops)?;
            // `movq` with an XMM operand is the SSE quadword move, with an
            // MMX operand the MMX quadword move; neither is a GP mov.
            if movq_xmm(code, mode, addr, src, dst)? || movq_mmx(code, mode, addr, src, dst)? {
                return Ok(());
            }
            {
                let class = |c: &Concrete| -> Option<(u8, u8)> {
                    let Concrete::Reg { reg, .. } = c else {
                        return None;
                    };
                    if (CR_BASE..CR_BASE + 16).contains(reg) {
                        Some((reg - CR_BASE, b'c'))
                    } else if (DR_BASE..DR_BASE + 8).contains(reg) {
                        Some((reg - DR_BASE, b'd'))
                    } else if (SEG_BASE..SEG_BASE + 6).contains(reg) {
                        Some((reg - SEG_BASE, b's'))
                    } else {
                        None
                    }
                };
                let special = match (class(&src), class(&dst)) {
                    (Some(s), None) => Some((s.0, s.1, true)),
                    (None, Some(d)) => Some((d.0, d.1, false)),
                    (Some(_), Some(_)) => {
                        return Err(String::from(
                            "inline asm: mov between two special registers",
                        ));
                    }
                    (None, None) => None,
                };
                if let Some((spec_idx, kind, spec_is_src)) = special {
                    let other = if spec_is_src { dst } else { src };
                    // The segment moves take a memory r/m, whose width the
                    // opcode fixes at 16 bits: no operand-size prefix, and a
                    // REX only where the address registers need one.
                    if kind == b's'
                        && let Some(mr) = MemRm::of(&other)
                    {
                        if mr.rex_x() || mr.rex_b() {
                            code.push(rex(false, false, mr.rex_x(), mr.rex_b()));
                        }
                        code.push(if spec_is_src { 0x8C } else { 0x8E });
                        mr.emit(code, mode, addr, spec_idx)?;
                        return Ok(());
                    }
                    let (gp, gp_size) = as_reg(other)?;
                    if gp >= MMX_BASE {
                        return Err(String::from(
                            "inline asm: mov special-register GPR expected",
                        ));
                    }
                    if kind == b's' {
                        // 8C stores a selector to r/m, 8E loads one. Both move
                        // 16 bits, so REX.W adds nothing; 8E's source width is
                        // the opcode's, so only 8C takes an operand-size prefix.
                        if spec_is_src
                            && !matches!(gp_size, AsmRegSize::Byte | AsmRegSize::Quad)
                            && gp_size.bytes() != mode.opsize()
                        {
                            code.push(0x66);
                        }
                        if gp >= 8 {
                            code.push(rex(false, false, false, true));
                        }
                        code.push(if spec_is_src { 0x8C } else { 0x8E });
                    } else {
                        // Control / debug moves are inherently 64-bit; REX.W is
                        // unused. REX.R extends the special register (cr8+),
                        // REX.B the GPR.
                        let base: u8 = if kind == b'c' { 0x20 } else { 0x21 };
                        if spec_idx >= 8 || gp >= 8 {
                            code.push(rex(false, spec_idx >= 8, false, gp >= 8));
                        }
                        code.push(0x0F);
                        code.push(if spec_is_src { base } else { base + 2 });
                    }
                    code.push(modrm_reg(spec_idx, gp));
                    return Ok(());
                }
            }
            Err(String::from("inline asm: unsupported mov operands"))
        }
        // The delegated general-purpose / system mnemonics are handled by the
        // table encoder above; reaching here means the catalogue has no form
        // matching these operands. A push / pop of a segment register is the
        // one such form with a fixed encoding, so try it before reporting the
        // mnemonic as written.
        Mnemonic::Table(name) => {
            segment_stack_op(code, name, suffix, ops, mode).unwrap_or_else(|| {
                Err(format!(
                    "inline asm: `{name}` has no x86-64 encoding for these operands"
                ))
            })
        }
        _ => Err(format!(
            "inline asm: unsupported instruction `{mnemonic:?}`"
        )),
    }
}

/// Push / pop of a segment register (`pushw %fs`, `popw %ds`), the one stack
/// form the table's general-register / memory / immediate push / pop do not
/// carry. Only FS/GS have a 64-bit-mode encoding: 0F A0 / A1 (FS) and 0F A8 /
/// A9 (GS); the ES/CS/SS/DS one-byte forms are invalid in 64-bit mode, so the
/// assembler rejects them and this does too. A `w` mnemonic or size suffix
/// adds the 0x66 operand-size prefix. Returns `None` when the mnemonic is not
/// push / pop or the operand is not an FS/GS register, leaving the caller to
/// report the mnemonic unencodable.
fn segment_stack_op(
    code: &mut Vec<u8>,
    name: &str,
    suffix: Option<AsmRegSize>,
    ops: &[Concrete],
    mode: super::table::Mode,
) -> Option<Result<(), String>> {
    let is_pop = match name {
        "push" | "pushw" | "pushl" | "pushq" => false,
        "pop" | "popw" | "popl" | "popq" => true,
        _ => return None,
    };
    let [Concrete::Reg { reg, .. }] = ops else {
        return None;
    };
    let sreg = reg.checked_sub(SEG_BASE).filter(|&s| s < 6)?;
    // A size letter or suffix names the stack operand size; without one it is
    // the mode default. Only the non-default width takes the `66` prefix.
    let opw = match name.as_bytes().last() {
        Some(b'w') => Some(2),
        Some(b'l') => Some(4),
        Some(b'q') => Some(8),
        _ => suffix.map(|s| s.bytes()),
    };
    let dflt = match mode {
        super::table::Mode::Bits16 => 2,
        super::table::Mode::Bits32 => 4,
        super::table::Mode::Bits64 => 8,
    };
    if opw.is_some_and(|w| w != dflt) {
        code.push(0x66);
    }
    // FS is Sreg 4, GS is Sreg 5, on the 0F map; es / cs / ss / ds are legacy
    // one-byte opcodes that long mode does not decode.
    if sreg >= 4 {
        code.extend_from_slice(&[0x0F, 0xA0 + (sreg - 4) * 8 + u8::from(is_pop)]);
    } else if mode == super::table::Mode::Bits64 {
        return None;
    } else if sreg == 1 && is_pop {
        // `pop %cs` has no encoding.
        return None;
    } else {
        code.push(0x06 + sreg * 8 + u8::from(is_pop));
    }
    Some(Ok(()))
}

fn as_reg(op: Concrete) -> Result<(u8, AsmRegSize), String> {
    match op {
        Concrete::Reg { reg, size } => Ok((reg, size)),
        // A high-byte register reaches only the catalogue path; the bespoke
        // arms encode forms that cannot name one.
        Concrete::HighReg(_) => Err(String::from(
            "inline asm: high-byte register is not an operand of this instruction",
        )),
        Concrete::Mem { .. }
        | Concrete::AbsMem { .. }
        | Concrete::RipRel { .. }
        | Concrete::IndexMem { .. } => Err(String::from("inline asm: unexpected memory operand")),
        Concrete::Imm(_) => Err(String::from("inline asm: register operand expected")),
    }
}

fn two(ops: &[Concrete]) -> Result<[Concrete; 2], String> {
    if ops.len() != 2 {
        return Err(String::from("inline asm: instruction needs two operands"));
    }
    Ok([ops[0], ops[1]])
}

fn three(ops: &[Concrete]) -> Result<[Concrete; 3], String> {
    if ops.len() != 3 {
        return Err(String::from("inline asm: instruction needs three operands"));
    }
    Ok([ops[0], ops[1], ops[2]])
}

#[cfg(test)]
mod tests {
    use super::*;

    fn enc(m: Mnemonic, suffix: Option<AsmRegSize>, ops: &[Concrete]) -> Vec<u8> {
        let mut c = Vec::new();
        encode(&mut c, 8, m, suffix, ops).unwrap();
        c
    }

    fn raw(tmpl: &[u8]) -> Vec<u8> {
        // Concatenate the bytes of every piece; `;`-separated hex bytes parse
        // as one raw-byte piece each.
        let mut out = Vec::new();
        for i in parse_template(tmpl).unwrap() {
            assert_eq!(i.mnemonic, Mnemonic::RawBytes);
            out.extend_from_slice(&i.bytes);
        }
        out
    }

    /// Parse a template of explicit-operand instructions (no `%N` refs),
    /// resolve them the way the emitter does (memory width from the suffix,
    /// else a GP register operand, else the mode's default operand size), and
    /// encode. For templates whose expected bytes are byte-verified against
    /// clang.
    pub(super) fn asm_bytes(tmpl: &[u8]) -> Vec<u8> {
        mode_asm_bytes(super::super::table::Mode::Bits64, tmpl).unwrap()
    }

    /// As [`asm_bytes`], encoded in `mode`, returning the encode error.
    fn mode_asm_bytes(mode: super::super::table::Mode, tmpl: &[u8]) -> Result<Vec<u8>, String> {
        let mut out = Vec::new();
        for insn in parse_template(tmpl).unwrap() {
            let mem_size = insn.suffix.or_else(|| {
                insn.operands.iter().find_map(|o| match *o {
                    AsmOpnd::HighReg(_) => Some(AsmRegSize::Byte),
                    AsmOpnd::Reg { reg, size } if reg < 16 => Some(size),
                    _ => None,
                })
            });
            let default_size = AsmRegSize::from_width(mode.stack_opsize());
            let reg_of = |b: AsmMemBase| match b {
                AsmMemBase::Reg { num, .. } => num,
                AsmMemBase::Ref(_) => panic!("explicit-register template expected"),
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
                        size: mem_size.unwrap_or(default_size),
                    },
                    AsmOpnd::AbsMem { disp, .. } => Concrete::AbsMem {
                        disp,
                        size: mem_size.unwrap_or(default_size),
                    },
                    other => panic!("unexpected operand {other:?}"),
                })
                .collect();
            let at = out.len();
            if let Some(seg) = insn.seg {
                out.push(seg);
            }
            encode_in(
                &mut out,
                mode,
                addr_size(&insn, mode),
                insn.mnemonic,
                insn.suffix,
                &ops,
            )?;
            if let Some(rex) = insn.rex {
                splice_rex(&mut out, at, rex).unwrap();
            }
        }
        Ok(out)
    }

    /// One operandless template encoded in `mode`, for the forms whose width
    /// the mnemonic spells and the mode's default decides.
    fn nullary_bytes(mode: super::super::table::Mode, tmpl: &[u8]) -> Vec<u8> {
        let mut out = Vec::new();
        for insn in parse_template(tmpl).unwrap() {
            let ops: Vec<Concrete> = insn
                .operands
                .iter()
                .map(|o| match *o {
                    AsmOpnd::Reg { reg, size } => Concrete::Reg { reg, size },
                    other => panic!("unexpected operand {other:?}"),
                })
                .collect();
            encode_in(
                &mut out,
                mode,
                mode.addrsize(),
                insn.mnemonic,
                insn.suffix,
                &ops,
            )
            .unwrap();
        }
        out
    }

    /// The forms whose operand size the mnemonic spells and the mode's default
    /// decides: the flag and general-register stack pushes, the interrupt and
    /// far returns, and the segment-register pushes. Bytes measured with GNU
    /// as 2.46.1 under each `.code` directive.
    #[test]
    fn mode_dependent_nullary_forms_match_gnu_as() {
        use super::super::table::Mode::{Bits16, Bits32, Bits64};
        #[rustfmt::skip]
        let cases: &[(super::super::table::Mode, &[u8], &[u8])] = &[
            (Bits16, b"pushf",       &[0x9C]),
            (Bits16, b"pushfw",      &[0x9C]),
            (Bits16, b"pushfl",      &[0x66, 0x9C]),
            (Bits16, b"popf",        &[0x9D]),
            (Bits16, b"popfl",       &[0x66, 0x9D]),
            (Bits16, b"pusha",       &[0x60]),
            (Bits16, b"pushal",      &[0x66, 0x60]),
            (Bits16, b"popal",       &[0x66, 0x61]),
            (Bits16, b"iret",        &[0xCF]),
            (Bits16, b"iretw",       &[0xCF]),
            (Bits16, b"iretl",       &[0x66, 0xCF]),
            (Bits16, b"lret",        &[0xCB]),
            (Bits16, b"lretl",       &[0x66, 0xCB]),
            (Bits16, b"pushw %%ds",  &[0x1E]),
            (Bits16, b"popw %%ds",   &[0x1F]),
            (Bits16, b"popw %%es",   &[0x07]),
            (Bits16, b"pushw %%fs",  &[0x0F, 0xA0]),
            (Bits32, b"pushf",       &[0x9C]),
            (Bits32, b"pushfl",      &[0x9C]),
            (Bits32, b"pushfw",      &[0x66, 0x9C]),
            (Bits32, b"pushal",      &[0x60]),
            (Bits32, b"iret",        &[0xCF]),
            (Bits32, b"iretw",       &[0x66, 0xCF]),
            (Bits32, b"lret",        &[0xCB]),
            (Bits32, b"lretw",       &[0x66, 0xCB]),
            (Bits64, b"pushf",       &[0x9C]),
            (Bits64, b"pushfq",      &[0x9C]),
            (Bits64, b"pushfw",      &[0x66, 0x9C]),
            (Bits64, b"iret",        &[0xCF]),
            (Bits64, b"iretq",       &[0x48, 0xCF]),
            (Bits64, b"iretw",       &[0x66, 0xCF]),
            (Bits64, b"lretq",       &[0x48, 0xCB]),
            (Bits64, b"pushw %%fs",  &[0x66, 0x0F, 0xA0]),
            (Bits64, b"pushq %%fs",  &[0x0F, 0xA0]),
            (Bits32, b"pushw %%fs",  &[0x66, 0x0F, 0xA0]),
            (Bits32, b"pushl %%fs",  &[0x0F, 0xA0]),
            (Bits32, b"pushw %%ds",  &[0x66, 0x1E]),
            (Bits32, b"pushl %%ds",  &[0x1E]),
        ];
        for (mode, tmpl, want) in cases {
            let got = nullary_bytes(*mode, tmpl);
            assert_eq!(
                got.as_slice(),
                *want,
                "{mode:?} {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
        // `push %ds` has no long-mode encoding, and `pop %cs` none at all.
        let ds = [Concrete::Reg {
            reg: SEG_BASE + 3,
            size: AsmRegSize::Word,
        }];
        let cs = [Concrete::Reg {
            reg: SEG_BASE + 1,
            size: AsmRegSize::Word,
        }];
        let mut out = Vec::new();
        assert!(
            encode_in(
                &mut out,
                super::super::table::Mode::Bits64,
                8,
                Mnemonic::Table("push"),
                Some(AsmRegSize::Word),
                &ds
            )
            .is_err()
        );
        assert!(
            encode_in(
                &mut out,
                super::super::table::Mode::Bits16,
                2,
                Mnemonic::Table("pop"),
                Some(AsmRegSize::Word),
                &cs
            )
            .is_err()
        );
    }

    /// The stack-adjusting returns (`ret $imm` C2 iw, `lret` / `retf` `$imm`
    /// CA iw) and the bespoke single-memory-operand forms over an absolute
    /// address. Bytes measured with GNU as 2.46 under each `.code` directive.
    #[test]
    fn ret_imm_and_absolute_memory_forms_match_gnu_as() {
        use super::super::table::Mode::{Bits16, Bits32, Bits64};
        #[rustfmt::skip]
        let cases: &[(super::super::table::Mode, &[u8], &[u8])] = &[
            (Bits64, b"ret $8",            &[0xC2, 0x08, 0x00]),
            (Bits64, b"retw $8",           &[0x66, 0xC2, 0x08, 0x00]),
            (Bits64, b"retq $8",           &[0xC2, 0x08, 0x00]),
            (Bits64, b"ret $-2",           &[0xC2, 0xFE, 0xFF]),
            (Bits64, b"ret $65535",        &[0xC2, 0xFF, 0xFF]),
            (Bits64, b"lret $8",           &[0xCA, 0x08, 0x00]),
            (Bits64, b"lretw $8",          &[0x66, 0xCA, 0x08, 0x00]),
            (Bits64, b"lretl $8",          &[0xCA, 0x08, 0x00]),
            (Bits64, b"lretq $8",          &[0x48, 0xCA, 0x08, 0x00]),
            (Bits64, b"retf $8",           &[0xCA, 0x08, 0x00]),
            (Bits16, b"ret $2",            &[0xC2, 0x02, 0x00]),
            (Bits16, b"retl $2",           &[0x66, 0xC2, 0x02, 0x00]),
            (Bits16, b"lret $2",           &[0xCA, 0x02, 0x00]),
            (Bits16, b"lretw $2",          &[0xCA, 0x02, 0x00]),
            (Bits16, b"lretl $2",          &[0x66, 0xCA, 0x02, 0x00]),
            (Bits32, b"ret $2",            &[0xC2, 0x02, 0x00]),
            (Bits32, b"retw $2",           &[0x66, 0xC2, 0x02, 0x00]),
            (Bits32, b"lret $2",           &[0xCA, 0x02, 0x00]),
            (Bits32, b"lretw $2",          &[0x66, 0xCA, 0x02, 0x00]),
            (Bits16, b"ljmp *0x1234",      &[0xFF, 0x2E, 0x34, 0x12]),
            (Bits16, b"ljmpw *0x1234",     &[0xFF, 0x2E, 0x34, 0x12]),
            (Bits16, b"ljmpl *0x1234",     &[0x66, 0xFF, 0x2E, 0x34, 0x12]),
            (Bits16, b"lcall *0x1234",     &[0xFF, 0x1E, 0x34, 0x12]),
            (Bits32, b"ljmp *0x1234",      &[0xFF, 0x2D, 0x34, 0x12, 0x00, 0x00]),
            (Bits64, b"ljmp *0x1234",      &[0xFF, 0x2C, 0x25, 0x34, 0x12, 0x00, 0x00]),
            (Bits64, b"lcall *0x1234",     &[0xFF, 0x1C, 0x25, 0x34, 0x12, 0x00, 0x00]),
            (Bits16, b"fnstcw 0x469",      &[0xD9, 0x3E, 0x69, 0x04]),
            (Bits16, b"fnstsw 0x469",      &[0xDD, 0x3E, 0x69, 0x04]),
            (Bits16, b"fldl 0x1234",       &[0xDD, 0x06, 0x34, 0x12]),
            (Bits32, b"fnstcw 0x469",      &[0xD9, 0x3D, 0x69, 0x04, 0x00, 0x00]),
            (Bits32, b"ldmxcsr 0x1234",    &[0x0F, 0xAE, 0x15, 0x34, 0x12, 0x00, 0x00]),
            (Bits64, b"fnstcw 0x469",      &[0xD9, 0x3C, 0x25, 0x69, 0x04, 0x00, 0x00]),
            (Bits64, b"fldl 0x1234",       &[0xDD, 0x04, 0x25, 0x34, 0x12, 0x00, 0x00]),
            (Bits64, b"fstpl 0x1234",      &[0xDD, 0x1C, 0x25, 0x34, 0x12, 0x00, 0x00]),
            (Bits64, b"ldmxcsr 0x1234",    &[0x0F, 0xAE, 0x14, 0x25, 0x34, 0x12, 0x00, 0x00]),
            (Bits64, b"stmxcsr 0x1234",    &[0x0F, 0xAE, 0x1C, 0x25, 0x34, 0x12, 0x00, 0x00]),
            (Bits64, b"cmpxchg16b 0x1234", &[0x48, 0x0F, 0xC7, 0x0C, 0x25, 0x34, 0x12, 0x00, 0x00]),
            (Bits64, b"invpcid 0x1234, %%rax",
                     &[0x66, 0x0F, 0x38, 0x82, 0x04, 0x25, 0x34, 0x12, 0x00, 0x00]),
        ];
        for (mode, tmpl, want) in cases {
            let got = mode_asm_bytes(*mode, tmpl).unwrap();
            assert_eq!(
                got.as_slice(),
                *want,
                "{mode:?} {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
        // The 16-bit immediate field bounds the value, as GNU as enforces;
        // the other sized-nullary forms take no operands at all.
        for (mode, tmpl) in [
            (Bits64, b"ret $65536".as_slice()),
            (Bits64, b"lret $65536"),
            (Bits64, b"iret $8"),
            (Bits64, b"pushf $8"),
        ] {
            assert!(mode_asm_bytes(mode, tmpl).is_err(), "{tmpl:?}");
        }
    }

    #[test]
    fn explicit_memory_operands() {
        // Every addressing shape vs clang: disp0 / disp8 / disp32, negative
        // displacements, and the rbp/r13 (no mod=00 form) and rsp/r12 (SIB)
        // corners. Expected bytes from `clang --target=x86_64-unknown-linux-gnu`.
        #[rustfmt::skip]
        let cases: &[(&[u8], &[u8])] = &[
            (b"mov %%rbx, (%%rdx)",      &[0x48, 0x89, 0x1a]),
            (b"mov %%rbp, 8(%%rdx)",     &[0x48, 0x89, 0x6a, 0x08]),
            (b"mov %%r12, 16(%%rdx)",    &[0x4c, 0x89, 0x62, 0x10]),
            (b"mov %%rsp, 24(%%rdx)",    &[0x48, 0x89, 0x62, 0x18]),
            (b"movq (%%rax), %%rbx",     &[0x48, 0x8b, 0x18]),
            (b"movq 72(%%rax), %%rsi",   &[0x48, 0x8b, 0x70, 0x48]),
            (b"mov %%rax, (%%rsp)",      &[0x48, 0x89, 0x04, 0x24]),
            (b"mov %%rax, 8(%%rsp)",     &[0x48, 0x89, 0x44, 0x24, 0x08]),
            (b"mov %%rax, (%%rbp)",      &[0x48, 0x89, 0x45, 0x00]),
            (b"mov %%rax, -16(%%rbp)",   &[0x48, 0x89, 0x45, 0xf0]),
            (b"mov %%rax, (%%r12)",      &[0x49, 0x89, 0x04, 0x24]),
            (b"mov %%rax, 8(%%r12)",     &[0x49, 0x89, 0x44, 0x24, 0x08]),
            (b"mov %%rax, (%%r13)",      &[0x49, 0x89, 0x45, 0x00]),
            (b"mov %%rax, -8(%%r13)",    &[0x49, 0x89, 0x45, 0xf8]),
            (b"mov %%rax, 127(%%rdx)",   &[0x48, 0x89, 0x42, 0x7f]),
            (b"mov %%rax, 128(%%rdx)",   &[0x48, 0x89, 0x82, 0x80, 0x00, 0x00, 0x00]),
            (b"mov %%rax, -128(%%rdx)",  &[0x48, 0x89, 0x42, 0x80]),
            (b"mov %%rax, -129(%%rdx)",  &[0x48, 0x89, 0x82, 0x7f, 0xff, 0xff, 0xff]),
            (b"mov %%rax, 4096(%%r15)",  &[0x49, 0x89, 0x87, 0x00, 0x10, 0x00, 0x00]),
            (b"movl %%ebx, 4(%%rdx)",    &[0x89, 0x5a, 0x04]),
            (b"movw %%ax, 2(%%rdx)",     &[0x66, 0x89, 0x42, 0x02]),
            (b"movb %%al, 1(%%rdx)",     &[0x88, 0x42, 0x01]),
            (b"movb %%al, 1(%%r13)",     &[0x41, 0x88, 0x45, 0x01]),
            (b"addq $7, 16(%%rdx)",      &[0x48, 0x83, 0x42, 0x10, 0x07]),
            (b"incq (%%r13)",            &[0x49, 0xff, 0x45, 0x00]),
            // Indirect branches through a register.
            (b"jmp *%%rdx",              &[0xff, 0xe2]),
            (b"jmp *%%r9",               &[0x41, 0xff, 0xe1]),
            (b"call *%%rax",             &[0xff, 0xd0]),
            // SSE moves / ops with a displaced memory operand (the bespoke
            // encode arms, not the table).
            (b"movdqa %%xmm1, 16(%%rdx)", &[0x66, 0x0f, 0x7f, 0x4a, 0x10]),
            (b"movdqa 32(%%rsp), %%xmm2", &[0x66, 0x0f, 0x6f, 0x54, 0x24, 0x20]),
            (b"movups %%xmm3, -16(%%rbp)", &[0x0f, 0x11, 0x5d, 0xf0]),
            (b"paddd 8(%%rcx), %%xmm5",  &[0x66, 0x0f, 0xfe, 0x69, 0x08]),
        ];
        for (tmpl, want) in cases {
            assert_eq!(
                asm_bytes(tmpl),
                *want,
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
    }

    #[test]
    fn byte_word_imm_to_memory_alu() {
        // The 80 / 66 81 / 66 83 /digit immediate-to-memory family plus
        // mov (C6 / 66 C7) and test (F6 / 66 F7), with the access width
        // taken from the AT&T suffix or a register operand. Expected bytes
        // from `clang --target=x86_64-unknown-linux-gnu`.
        #[rustfmt::skip]
        let cases: &[(&[u8], &[u8])] = &[
            (b"addb $0x11, 16(%%rdx)",   &[0x80, 0x42, 0x10, 0x11]),
            (b"orb $0x22, (%%rdx)",      &[0x80, 0x0a, 0x22]),
            (b"adcb $0x33, (%%rdx)",     &[0x80, 0x12, 0x33]),
            (b"sbbb $0x44, (%%rdx)",     &[0x80, 0x1a, 0x44]),
            (b"andb $0x55, (%%rdx)",     &[0x80, 0x22, 0x55]),
            (b"subb $0x66, (%%rdx)",     &[0x80, 0x2a, 0x66]),
            (b"xorb $0x80, (%%rdx)",     &[0x80, 0x32, 0x80]),
            (b"cmpb $0x77, (%%rdx)",     &[0x80, 0x3a, 0x77]),
            (b"movb $0x42, (%%rdx)",     &[0xc6, 0x02, 0x42]),
            (b"testb $0x01, (%%rdx)",    &[0xf6, 0x02, 0x01]),
            (b"addw $0x1111, 16(%%rdx)", &[0x66, 0x81, 0x42, 0x10, 0x11, 0x11]),
            (b"orw $0x2222, (%%rdx)",    &[0x66, 0x81, 0x0a, 0x22, 0x22]),
            (b"adcw $0x3333, (%%rdx)",   &[0x66, 0x81, 0x12, 0x33, 0x33]),
            (b"sbbw $0x4444, (%%rdx)",   &[0x66, 0x81, 0x1a, 0x44, 0x44]),
            (b"andw $0x5555, (%%rdx)",   &[0x66, 0x81, 0x22, 0x55, 0x55]),
            (b"subw $0x6666, (%%rdx)",   &[0x66, 0x81, 0x2a, 0x66, 0x66]),
            (b"xorw $0x8000, (%%rdx)",   &[0x66, 0x81, 0x32, 0x00, 0x80]),
            (b"cmpw $0x7777, (%%rdx)",   &[0x66, 0x81, 0x3a, 0x77, 0x77]),
            (b"movw $0x4242, (%%rdx)",   &[0x66, 0xc7, 0x02, 0x42, 0x42]),
            (b"testw $0x0101, (%%rdx)",  &[0x66, 0xf7, 0x02, 0x01, 0x01]),
            // A small word immediate takes the 83 imms8 short form.
            (b"addw $8, (%%rdx)",        &[0x66, 0x83, 0x02, 0x08]),
            // REX.B bases (r13 forces disp8=0, r12 forces a SIB).
            (b"xorb $0x80, (%%r13)",     &[0x41, 0x80, 0x75, 0x00, 0x80]),
            (b"xorw $0x8000, 3(%%r12)",  &[0x66, 0x41, 0x81, 0x74, 0x24, 0x03, 0x00, 0x80]),
            // No suffix: a register operand fixes the access width.
            (b"xor %%bl, (%%rdx)",       &[0x30, 0x1a]),
            (b"xor %%cx, (%%rdx)",       &[0x66, 0x31, 0x0a]),
            // The same width selection drives the unary and shift groups.
            (b"notb (%%rdx)",            &[0xf6, 0x12]),
            (b"negb (%%rdx)",            &[0xf6, 0x1a]),
            (b"incb (%%rdx)",            &[0xfe, 0x02]),
            (b"decb (%%rdx)",            &[0xfe, 0x0a]),
            (b"shlb $3, (%%rdx)",        &[0xc0, 0x22, 0x03]),
            (b"shrw $3, (%%rdx)",        &[0x66, 0xc1, 0x2a, 0x03]),
            (b"notw (%%rdx)",            &[0x66, 0xf7, 0x12]),
            (b"incw (%%rdx)",            &[0x66, 0xff, 0x02]),
        ];
        for (tmpl, want) in cases {
            assert_eq!(
                asm_bytes(tmpl),
                *want,
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
    }

    #[test]
    fn segment_and_sib_operands() {
        // Segment-override and scaled-index forms vs clang
        // (`clang --target=x86_64-unknown-linux-gnu`).
        #[rustfmt::skip]
        let cases: &[(&[u8], &[u8])] = &[
            // %%gs:disp absolute (mod=00 rm=100, SIB 0x25, disp32), the
            // seg prefix first (before 66 / REX).
            (b"movq %%gs:0x28, %%rax", &[0x65, 0x48, 0x8b, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00]),
            (b"movl %%gs:0x10, %%ecx", &[0x65, 0x8b, 0x0c, 0x25, 0x10, 0x00, 0x00, 0x00]),
            (b"movq %%rbx, %%gs:0x28", &[0x65, 0x48, 0x89, 0x1c, 0x25, 0x28, 0x00, 0x00, 0x00]),
            (b"movq %%fs:0x0, %%r9",   &[0x64, 0x4c, 0x8b, 0x0c, 0x25, 0x00, 0x00, 0x00, 0x00]),
            (b"addq $1, %%gs:0x30",
             &[0x65, 0x48, 0x83, 0x04, 0x25, 0x30, 0x00, 0x00, 0x00, 0x01]),
            (b"movw %%gs:0x40, %%dx",  &[0x65, 0x66, 0x8b, 0x14, 0x25, 0x40, 0x00, 0x00, 0x00]),
            (b"movb %%gs:0x5, %%al",   &[0x65, 0x8a, 0x04, 0x25, 0x05, 0x00, 0x00, 0x00]),
            (b"movq %%gs:0x28, %%r12", &[0x65, 0x4c, 0x8b, 0x24, 0x25, 0x28, 0x00, 0x00, 0x00]),
            // Segment prefix on a based reference.
            (b"movq %%gs:8(%%rdx), %%rax", &[0x65, 0x48, 0x8b, 0x42, 0x08]),
            // SIB forms `disp(%%base, %%index, scale)` / `(%%base, %%index)`.
            (b"movq (%%rax,%%rbx,4), %%rcx",    &[0x48, 0x8b, 0x0c, 0x98]),
            (b"movq 8(%%rax,%%rbx,8), %%rcx",   &[0x48, 0x8b, 0x4c, 0xd8, 0x08]),
            (b"movl -4(%%r8,%%r9,2), %%edx",    &[0x43, 0x8b, 0x54, 0x48, 0xfc]),
            (b"movq (%%rax,%%rbx), %%rcx",      &[0x48, 0x8b, 0x0c, 0x18]),
            (b"leaq (%%rax,%%rbx,4), %%rcx",    &[0x48, 0x8d, 0x0c, 0x98]),
            (b"movq %%rcx, 16(%%rsp,%%rdx)",    &[0x48, 0x89, 0x4c, 0x14, 0x10]),
            (b"movb %%cl, 3(%%rbp,%%rdi,2)",    &[0x88, 0x4c, 0x7d, 0x03]),
        ];
        for (tmpl, want) in cases {
            assert_eq!(
                asm_bytes(tmpl),
                *want,
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
    }

    #[test]
    fn const_modifier_refs() {
        // `%cN` / `%PN` parse to bare-constant operand references.
        let insns = parse_template(b"lea %P0, %%rax").unwrap();
        assert_eq!(
            insns[0].operands[0],
            AsmOpnd::RefConst {
                idx: 0,
                symbolic: true
            }
        );
        // A data directive referencing an operand defers to emit time,
        // carrying the directive width.
        let insns = parse_template(b".long %c0").unwrap();
        assert_eq!(insns[0].mnemonic, Mnemonic::Data(4));
        assert_eq!(
            insns[0].operands[0],
            AsmOpnd::RefConst {
                idx: 0,
                symbolic: false
            }
        );
        let insns = parse_template(b".quad %c1, 7").unwrap();
        assert_eq!(insns[0].mnemonic, Mnemonic::Data(8));
        assert_eq!(insns[0].operands[1], AsmOpnd::Imm(7));
        // A constant-only directive stays on the raw-byte path.
        let insns = parse_template(b".long 42").unwrap();
        assert_eq!(insns[0].mnemonic, Mnemonic::RawBytes);
    }

    #[test]
    fn uniq_escape_and_labels() {
        // `%=` gets one number per parse, shared across the template; the
        // label definition and the `lea LABEL(%rip)` reference intern to the
        // same named-label id.
        let insns =
            parse_template(b"lea LJMPRET%=(%%rip), %%rcx\n\tmov %%rbx, (%%rdx)\n\tLJMPRET%=:\n\t")
                .unwrap();
        let AsmOpnd::LabelAddr { num, .. } = insns[0].operands[0] else {
            panic!("lea operand should be a label address");
        };
        assert!(num >= NAMED_LABEL_BASE);
        assert_eq!(insns[2].label_def, Some(num));
        // `.cfi_*` directives parse to nothing.
        let insns =
            parse_template(b".cfi_def_cfa %%rdx, 0\n\t.cfi_offset %%rbx, 0\n\tnop").unwrap();
        assert_eq!(insns.len(), 1);
        assert_eq!(insns[0].mnemonic, Mnemonic::Nop);
        // A jump to a named label parses as a label operand, not a symbol.
        let insns = parse_template(b"jmp done%=\n\tnop\n\tdone%=:").unwrap();
        assert!(insns[0].sym_exprs.is_empty());
        assert!(matches!(insns[0].operands[0], AsmOpnd::Label { .. }));
        // Numeric-label addresses take a direction suffix.
        let insns = parse_template(b"1:\n\tlea 1b(%%rip), %%rax").unwrap();
        assert!(matches!(
            insns[1].operands[0],
            AsmOpnd::LabelAddr {
                num: 1,
                forward: false
            }
        ));
    }

    #[test]
    fn rip_relative_numeric_displacement() {
        // `disp(%%rip)` with a literal displacement is a self-relative address
        // (`_THIS_IP_`'s `lea 0(%%rip), %0`), distinct from the `LABEL(%%rip)`
        // label-address form. Zero, decimal, and hex displacements parse; a
        // bare `Nb`/`Nf` before `(%%rip)` stays a numeric-label address.
        let insns = parse_template(b"lea 0(%%rip), %0").unwrap();
        assert_eq!(insns[0].operands[0], AsmOpnd::RipRel { disp: 0 });
        let insns = parse_template(b"movl 16(%%rip), %%eax").unwrap();
        assert_eq!(insns[0].operands[0], AsmOpnd::RipRel { disp: 16 });
        let insns = parse_template(b"lea 0x20(%%rip), %%rax").unwrap();
        assert_eq!(insns[0].operands[0], AsmOpnd::RipRel { disp: 0x20 });
        let insns = parse_template(b"1:\n\tlea 1b(%%rip), %%rax").unwrap();
        assert!(matches!(
            insns[1].operands[0],
            AsmOpnd::LabelAddr { num: 1, .. }
        ));
    }

    #[test]
    fn port_dx_parenthesized() {
        // `(%dx)` names the variable I/O port, the same operand as bare
        // `%dx`; both `%%` and the basic-asm single-`%` spellings parse.
        // Encodings are the fixed EC..EF family (66-prefixed at word width).
        let dx = AsmOpnd::Reg {
            reg: 2,
            size: AsmRegSize::Word,
        };
        let insns = parse_template(b"inb (%%dx), %%al").unwrap();
        assert_eq!(insns[0].operands[0], dx);
        let insns = parse_template(b"outl %%eax, (%dx)").unwrap();
        assert_eq!(insns[0].operands[1], dx);
        let port = Concrete::Reg {
            reg: 2,
            size: AsmRegSize::Word,
        };
        let al = Concrete::Reg {
            reg: 0,
            size: AsmRegSize::Byte,
        };
        assert_eq!(
            enc(Mnemonic::In, Some(AsmRegSize::Byte), &[port, al]),
            [0xEC]
        );
        assert_eq!(
            enc(Mnemonic::Out, Some(AsmRegSize::Word), &[al, port]),
            [0x66, 0xEF]
        );
    }

    #[test]
    fn const_modifier_riprel() {
        // `%cN(%%rip)` / `%PN(%%rip)`: the displacement is an `i`-class
        // operand substituted bare (no `$`), resolved at emit time.
        let insns = parse_template(b"movl %c1(%%rip), %0").unwrap();
        assert_eq!(
            insns[0].operands[0],
            AsmOpnd::RipRelRef {
                idx: 1,
                symbolic: false
            }
        );
        let insns = parse_template(b"movq %P2(%%rip), %%rax").unwrap();
        assert_eq!(
            insns[0].operands[0],
            AsmOpnd::RipRelRef {
                idx: 2,
                symbolic: true
            }
        );
    }

    #[test]
    fn no_base_scaled_index() {
        // `disp(,%index,scale)`: SIB with no base (base=101, mod=00, disp32).
        // An r8+ index sets REX.X; a symbol displacement parses only with the
        // name carried on the instruction for the emitter's relocation.
        let insns = parse_template(b"movq 8(,%1,8), %0").unwrap();
        assert_eq!(
            insns[0].operands[0],
            AsmOpnd::IndexMem {
                index: AsmMemBase::Ref(1),
                scale: 8,
                disp: 8,
                sym: None
            }
        );
        let insns = parse_template(b"movq tab(,%%rcx,4), %%rbx").unwrap();
        assert_eq!(insns[0].sym_exprs, ["tab"]);
        assert_eq!(
            insns[0].operands[0],
            AsmOpnd::IndexMem {
                index: AsmMemBase::Reg {
                    num: 1,
                    size: AsmRegSize::Quad
                },
                scale: 4,
                disp: 0,
                sym: Some(0)
            }
        );
        // movq (,%r9,4), %rax -- REX.X extends the index register.
        let ops = [
            Concrete::IndexMem {
                index: 9,
                scale: 4,
                disp: 0,
                size: AsmRegSize::Quad,
            },
            Concrete::Reg {
                reg: 0,
                size: AsmRegSize::Quad,
            },
        ];
        assert_eq!(
            enc(Mnemonic::Mov, Some(AsmRegSize::Quad), &ops),
            [0x4A, 0x8B, 0x04, 0x8D, 0, 0, 0, 0]
        );
    }

    #[test]
    fn symbol_riprel_displacement() {
        // `sym(%rip)` / `(sym + disp)(%rip)`: a RIP-relative reference to a
        // link-time symbol, the name on the instruction, the folded constant
        // in the operand; a segment override rides the instruction.
        let insns = parse_template(b"sarq $5, %%gs:(percpu_obj + 16)(%%rip)").unwrap();
        assert_eq!(insns[0].seg, Some(0x65));
        assert_eq!(insns[0].sym_exprs, ["(percpu_obj + 16)"]);
        assert_eq!(insns[0].operands[0], AsmOpnd::Imm(5));
        assert_eq!(insns[0].operands[1], AsmOpnd::SymRipRel { expr: 0 });
        // The single-`%` basic-asm spelling and the unparenthesized form.
        let insns = parse_template(b"movq obj+8(%rip), %rax").unwrap();
        assert_eq!(insns[0].sym_exprs, ["obj+8"]);
        assert_eq!(insns[0].operands[0], AsmOpnd::SymRipRel { expr: 0 });
        let insns = parse_template(b"leaq (obj - 8)(%%rip), %%rdx").unwrap();
        assert_eq!(insns[0].sym_exprs, ["(obj - 8)"]);
        assert_eq!(insns[0].operands[0], AsmOpnd::SymRipRel { expr: 0 });
        // A template-local label keeps the label-address form; a literal
        // displacement keeps the relocation-free form.
        let insns = parse_template(b"lbl:\n\tleaq lbl(%%rip), %%rax").unwrap();
        assert!(matches!(insns[1].operands[0], AsmOpnd::LabelAddr { .. }));
        let insns = parse_template(b"movq 8(%%rip), %%rax").unwrap();
        assert_eq!(insns[0].operands[0], AsmOpnd::RipRel { disp: 8 });
    }

    #[test]
    fn align_directives() {
        // `.align` / `.balign` take a byte count on x86; `.p2align` an
        // exponent. Fill and max-skip operands carry through, and the `w` /
        // `l` spellings widen the fill unit without changing the alignment
        // operand's convention.
        use crate::c5::codegen::ssa::emit_common::{AlignFill, AlignSpec, AsmSectionItem};
        let align = |n: u32, fill, max| {
            Some(AsmSectionItem::Align {
                spec: AlignSpec::Bytes(n),
                fill,
                max,
            })
        };
        let fill = |value: u32, width: u8| Some(AlignFill { value, width });
        let cases: &[(&[u8], Option<AsmSectionItem>)] = &[
            (b".align 8", align(8, None, None)),
            (b".p2align 4,,7", align(16, None, Some(7))),
            (b".balign 16, 0x90", align(16, fill(0x90, 1), None)),
            (
                b".p2alignl 4, 0x12345678",
                align(16, fill(0x12345678, 4), None),
            ),
            (
                b".balignw 16, 0x1234, 3",
                align(16, fill(0x1234, 2), Some(3)),
            ),
            // A zero count is an alignment of one, which moves nothing.
            (b".align 0", align(1, None, None)),
            (b".balign 0", align(1, None, None)),
        ];
        for (tmpl, want) in cases {
            let insns = parse_template(tmpl).unwrap();
            assert_eq!(
                &insns[0].layout,
                want,
                "template {}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
        // An operand over labels is kept for the emitter to settle where the
        // directive stands.
        let insns = parse_template(b"nop\n\t1:\n\t.balign 1b-.").unwrap();
        assert!(matches!(
            insns.last().unwrap().layout,
            Some(AsmSectionItem::Align {
                spec: AlignSpec::Expr { pow2: false, .. },
                ..
            })
        ));
        // A non-power-of-two byte count is rejected, and GNU as has no
        // `.alignw` / `.alignl`.
        for t in [
            b".align 3".as_slice(),
            b".alignl 8".as_slice(),
            b".alignw 8".as_slice(),
        ] {
            assert!(
                parse_template(t).is_err(),
                "{}",
                core::str::from_utf8(t).unwrap()
            );
        }
    }

    #[test]
    fn raw_byte_templates() {
        // Bare hex-byte run: each token is one byte (read as hex, so `90` is
        // 0x90). `;` and whitespace both separate.
        assert_eq!(raw(b"CC; C3; 90"), [0xCC, 0xC3, 0x90]);
        assert_eq!(raw(b"cc c3 90"), [0xCC, 0xC3, 0x90]);
        // `.byte` / `.word` / `.long` / `.quad` directives, little-endian at
        // the directive width; C-style integer constants.
        assert_eq!(raw(b".byte 0x48, 0x89, 0xd8"), [0x48, 0x89, 0xd8]);
        assert_eq!(raw(b".word 0x1234"), [0x34, 0x12]);
        assert_eq!(raw(b".long 0xdeadbeef"), [0xef, 0xbe, 0xad, 0xde]);
        assert_eq!(raw(b".byte 144"), [0x90]); // decimal in the directive form
        // A run of hex bytes and a mnemonic can share one template.
        let mixed = parse_template(b".byte 0x90; nop").unwrap();
        assert_eq!(mixed.len(), 2);
        assert_eq!(mixed[0].mnemonic, Mnemonic::RawBytes);
        assert_eq!(mixed[1].mnemonic, Mnemonic::Nop);
        // A single alphabetic token stays a mnemonic, not a raw byte.
        assert_eq!(parse_template(b"nop").unwrap()[0].mnemonic, Mnemonic::Nop);
    }

    #[test]
    fn sse2_xmm_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let gp = |n: u8| Concrete::Reg {
            reg: n,
            size: AsmRegSize::Long,
        };
        let sse = |prefix, opcode| Mnemonic::Sse2Rr {
            prefix,
            map: 1,
            opcode,
        };
        // Two-xmm SSE2: `<prefix> [REX] 0F <opcode>` with ModRM.reg = dst,
        // rm = src (AT&T `op src, dst`, ops in source-first order).
        assert_eq!(
            enc(sse(0x66, 0xEF), None, &[xmm(1), xmm(2)]),
            [0x66, 0x0F, 0xEF, 0xD1]
        ); // pxor %xmm1,%xmm2
        assert_eq!(
            enc(sse(0x66, 0xFE), None, &[xmm(1), xmm(2)]),
            [0x66, 0x0F, 0xFE, 0xD1]
        ); // paddd
        assert_eq!(
            enc(sse(0x66, 0xD4), None, &[xmm(3), xmm(4)]),
            [0x66, 0x0F, 0xD4, 0xE3]
        ); // paddq %xmm3,%xmm4
        assert_eq!(
            enc(sse(0x66, 0x6F), None, &[xmm(1), xmm(2)]),
            [0x66, 0x0F, 0x6F, 0xD1]
        ); // movdqa
        assert_eq!(
            enc(sse(0x66, 0xEF), None, &[xmm(9), xmm(10)]),
            [0x66, 0x45, 0x0F, 0xEF, 0xD1]
        ); // pxor high xmm -> REX.R+REX.B
        // movd GP<->xmm: the xmm form of the MMX movd adds the 0x66 prefix; the
        // vector register is ModRM.reg, the GPR rm.
        assert_eq!(
            enc(Mnemonic::Movd, None, &[gp(0), xmm(0)]),
            [0x66, 0x0F, 0x6E, 0xC0]
        ); // movd %eax,%xmm0
        assert_eq!(
            enc(Mnemonic::Movd, None, &[xmm(0), gp(0)]),
            [0x66, 0x0F, 0x7E, 0xC0]
        ); // movd %xmm0,%eax
        assert_eq!(
            enc(Mnemonic::Movd, None, &[gp(9), xmm(3)]),
            [0x66, 0x41, 0x0F, 0x6E, 0xD9]
        ); // movd %r9d,%xmm3 -> REX.B
        // A non-xmm operand pair is rejected.
        assert!(encode(&mut Vec::new(), 8, sse(0x66, 0xEF), None, &[gp(0), gp(1)]).is_err());
        // The prefix byte selects the variant: 0xF2/0xF3 scalar, 0x66 packed
        // double, and a zero prefix the no-prefix packed single (no leading
        // byte).
        assert_eq!(
            enc(sse(0xF2, 0x58), None, &[xmm(1), xmm(2)]),
            [0xF2, 0x0F, 0x58, 0xD1]
        ); // addsd
        assert_eq!(
            enc(sse(0, 0x58), None, &[xmm(3), xmm(4)]),
            [0x0F, 0x58, 0xE3]
        ); // addps (no mandatory prefix)
        // The mnemonic table resolves names to their Sse2Rr encoding.
        assert_eq!(
            sse2_op("addsd"),
            Some(Mnemonic::Sse2Rr {
                prefix: 0xF2,
                map: 1,
                opcode: 0x58
            })
        );
        assert_eq!(
            sse2_op("xorps"),
            Some(Mnemonic::Sse2Rr {
                prefix: 0,
                map: 1,
                opcode: 0x57
            })
        );
        assert_eq!(sse2_op("not_an_sse_op"), None);
        // Integer pack / multiply-add / high-multiply / high-unpack forms
        // (byte-verified against clang: `<66> 0F <op> C1` for src=xmm1,dst=xmm0).
        for (name, op) in [
            ("packsswb", 0x63u8),
            ("packssdw", 0x6B),
            ("packuswb", 0x67),
            ("pmaddwd", 0xF5),
            ("pmulhw", 0xE5),
            ("punpckhbw", 0x68),
            ("punpckhwd", 0x69),
        ] {
            assert_eq!(
                sse2_op(name),
                Some(Mnemonic::Sse2Rr {
                    prefix: 0x66,
                    map: 1,
                    opcode: op
                })
            );
            assert_eq!(
                enc(sse(0x66, op), None, &[xmm(1), xmm(0)]),
                [0x66, 0x0F, op, 0xC1]
            );
        }
        // Packed-single float ops: unpck/sqrt (no prefix) and the int<->float
        // convert trio (cvtdq2ps none, cvtps2dq 0x66, cvttps2dq 0xF3). Prefix 0
        // emits no leading byte. Byte-exact vs clang.
        for (name, prefix, op) in [
            ("unpcklps", 0u8, 0x14u8),
            ("unpckhps", 0, 0x15),
            ("sqrtps", 0, 0x51),
            ("cvtdq2ps", 0, 0x5B),
            ("cvtps2dq", 0x66, 0x5B),
            ("cvttps2dq", 0xF3, 0x5B),
        ] {
            assert_eq!(
                sse2_op(name),
                Some(Mnemonic::Sse2Rr {
                    prefix,
                    map: 1,
                    opcode: op
                })
            );
            let got = enc(sse(prefix, op), None, &[xmm(1), xmm(0)]);
            if prefix == 0 {
                assert_eq!(got, [0x0F, op, 0xC1]);
            } else {
                assert_eq!(got, [prefix, 0x0F, op, 0xC1]);
            }
        }
        // A `(%base)` memory source rides r/m through modrm_mem; a high
        // destination still sets REX.R, a high base REX.B.
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size: AsmRegSize::Quad,
        };
        assert_eq!(
            enc(sse(0x66, 0xFE), None, &[mem(0), xmm(0)]),
            [0x66, 0x0F, 0xFE, 0x00]
        ); // paddd (%rax),%xmm0
        assert_eq!(
            enc(sse(0xF2, 0x58), None, &[mem(0), xmm(3)]),
            [0xF2, 0x0F, 0x58, 0x18]
        ); // addsd (%rax),%xmm3
        assert_eq!(
            enc(sse(0x66, 0xFE), None, &[mem(0), xmm(9)]),
            [0x66, 0x44, 0x0F, 0xFE, 0x08]
        ); // paddd (%rax),%xmm9 -> REX.R
    }

    #[test]
    fn sse_mov_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size: AsmRegSize::Quad,
        };
        let mov = |p, l, s| Mnemonic::SseMov {
            prefix: p,
            load_op: Some(l),
            store_op: Some(s),
            map: 1,
        };
        // reg-reg and load use the load opcode; store uses the store opcode; the
        // xmm register is always ModRM.reg.
        assert_eq!(
            enc(mov(0, 0x28, 0x29), None, &[xmm(1), xmm(2)]),
            [0x0F, 0x28, 0xD1]
        ); // movaps %xmm1,%xmm2
        assert_eq!(
            enc(mov(0x66, 0x6F, 0x7F), None, &[mem(0), xmm(0)]),
            [0x66, 0x0F, 0x6F, 0x00]
        ); // movdqa (%rax),%xmm0
        assert_eq!(
            enc(mov(0x66, 0x6F, 0x7F), None, &[xmm(0), mem(0)]),
            [0x66, 0x0F, 0x7F, 0x00]
        ); // movdqa %xmm0,(%rax)
        assert_eq!(
            enc(mov(0xF2, 0x10, 0x11), None, &[xmm(4), mem(0)]),
            [0xF2, 0x0F, 0x11, 0x20]
        ); // movsd %xmm4,(%rax)
        // The mov table resolves names to their SseMov encoding.
        assert_eq!(
            sse_mov("movdqa"),
            Some(Mnemonic::SseMov {
                prefix: 0x66,
                load_op: Some(0x6F),
                store_op: Some(0x7F),
                map: 1,
            })
        );
        assert_eq!(sse_mov("not_a_mov"), None);
        // The non-temporal moves have one direction each; `movntdqa` is the
        // only load and the only 0F 38 form. Encodings match the assembler.
        let nt = |n: &str| sse_mov(n).unwrap();
        assert_eq!(
            enc(nt("movntdqa"), None, &[mem(0), xmm(1)]),
            [0x66, 0x0F, 0x38, 0x2A, 0x08]
        ); // movntdqa (%rax),%xmm1
        // A high xmm takes REX.R ahead of the map bytes, not between them.
        assert_eq!(
            enc(
                nt("movntdqa"),
                None,
                &[
                    Concrete::Mem {
                        base: 0,
                        index: None,
                        scale: 1,
                        disp: 16,
                        size: AsmRegSize::Quad
                    },
                    xmm(9)
                ]
            ),
            [0x66, 0x44, 0x0F, 0x38, 0x2A, 0x48, 0x10]
        ); // movntdqa 16(%rax),%xmm9
        assert_eq!(
            enc(nt("movntdq"), None, &[xmm(1), mem(0)]),
            [0x66, 0x0F, 0xE7, 0x08]
        ); // movntdq %xmm1,(%rax)
        assert_eq!(
            enc(nt("movntps"), None, &[xmm(1), mem(0)]),
            [0x0F, 0x2B, 0x08]
        ); // movntps %xmm1,(%rax)
        assert_eq!(
            enc(nt("movntpd"), None, &[xmm(1), mem(0)]),
            [0x66, 0x0F, 0x2B, 0x08]
        ); // movntpd %xmm1,(%rax)
        // A direction the instruction does not have is rejected, not encoded
        // as the other one.
        assert!(encode(&mut Vec::new(), 8, nt("movntdqa"), None, &[xmm(1), mem(0)]).is_err());
        assert!(encode(&mut Vec::new(), 8, nt("movntdq"), None, &[mem(0), xmm(1)]).is_err());
    }

    #[test]
    fn sse_imm_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let imm = Concrete::Imm;
        // pshuf*: <prefix> 0F 70 /r ib, dst in ModRM.reg, src in r/m.
        assert_eq!(
            enc(
                Mnemonic::SseRmImm {
                    prefix: 0x66,
                    map: 1,
                    opcode: 0x70,
                    w: false,
                    store: false,
                },
                None,
                &[imm(0x1b), xmm(1), xmm(2)]
            ),
            [0x66, 0x0F, 0x70, 0xD1, 0x1B]
        ); // pshufd $0x1b,%xmm1,%xmm2
        assert_eq!(
            enc(
                Mnemonic::SseRmImm {
                    prefix: 0xF2,
                    map: 1,
                    opcode: 0x70,
                    w: false,
                    store: false,
                },
                None,
                &[imm(0x4e), xmm(1), xmm(2)]
            ),
            [0xF2, 0x0F, 0x70, 0xD1, 0x4E]
        ); // pshuflw
        assert_eq!(
            enc(
                Mnemonic::SseRmImm {
                    prefix: 0x66,
                    map: 1,
                    opcode: 0x70,
                    w: false,
                    store: false,
                },
                None,
                &[imm(0x1b), xmm(9), xmm(10)]
            ),
            [0x66, 0x45, 0x0F, 0x70, 0xD1, 0x1B]
        ); // high xmm -> REX.R+REX.B
        // shift-by-imm: 66 0F opcode /digit ib; the digit is the opcode
        // extension in ModRM.reg, the xmm in r/m.
        assert_eq!(
            enc(
                Mnemonic::SseShiftImm {
                    opcode: 0x72,
                    digit: 6,
                    var_opcode: Some(0xF2),
                },
                None,
                &[imm(3), xmm(0)]
            ),
            [0x66, 0x0F, 0x72, 0xF0, 0x03]
        ); // pslld $3,%xmm0
        assert_eq!(
            enc(
                Mnemonic::SseShiftImm {
                    opcode: 0x73,
                    digit: 3,
                    var_opcode: None,
                },
                None,
                &[imm(8), xmm(1)]
            ),
            [0x66, 0x0F, 0x73, 0xD9, 0x08]
        ); // psrldq $8,%xmm1
        assert_eq!(
            enc(
                Mnemonic::SseShiftImm {
                    opcode: 0x72,
                    digit: 6,
                    var_opcode: Some(0xF2),
                },
                None,
                &[imm(3), xmm(11)]
            ),
            [0x66, 0x41, 0x0F, 0x72, 0xF3, 0x03]
        ); // high xmm -> REX.B
        // The tables resolve names.
        assert_eq!(
            sse_imm("pshufd"),
            Some(Mnemonic::SseRmImm {
                prefix: 0x66,
                map: 1,
                opcode: 0x70,
                w: false,
                store: false,
            })
        );
        // shuf{ps,pd}: opcode 0xC6, ps with no prefix, pd with 0x66. Byte-exact
        // vs clang: `0f c6 c1 1b` and `66 0f c6 c1 01`.
        assert_eq!(
            sse_imm("shufps"),
            Some(Mnemonic::SseRmImm {
                prefix: 0,
                map: 1,
                opcode: 0xC6,
                w: false,
                store: false,
            })
        );
        assert_eq!(
            enc(
                Mnemonic::SseRmImm {
                    prefix: 0,
                    map: 1,
                    opcode: 0xC6,
                    w: false,
                    store: false,
                },
                None,
                &[imm(0x1b), xmm(1), xmm(0)]
            ),
            [0x0F, 0xC6, 0xC1, 0x1B]
        ); // shufps $0x1b,%xmm1,%xmm0
        assert_eq!(
            enc(
                Mnemonic::SseRmImm {
                    prefix: 0x66,
                    map: 1,
                    opcode: 0xC6,
                    w: false,
                    store: false,
                },
                None,
                &[imm(1), xmm(1), xmm(0)]
            ),
            [0x66, 0x0F, 0xC6, 0xC1, 0x01]
        ); // shufpd $1,%xmm1,%xmm0
        assert_eq!(
            sse_imm("psllq"),
            Some(Mnemonic::SseShiftImm {
                opcode: 0x73,
                digit: 6,
                var_opcode: Some(0xF3),
            })
        );
        assert_eq!(sse_imm("not_an_op"), None);
    }

    #[test]
    fn movq_xmm_forms() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let gp = |n: u8| Concrete::Reg {
            reg: n,
            size: AsmRegSize::Quad,
        };
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size: AsmRegSize::Quad,
        };
        let mov = |ops: &[Concrete]| enc(Mnemonic::Mov, None, ops);
        // GP64<->xmm: 66 REX.W 0F 6E/7E.
        assert_eq!(mov(&[gp(0), xmm(0)]), [0x66, 0x48, 0x0F, 0x6E, 0xC0]); // movq %rax,%xmm0
        assert_eq!(mov(&[xmm(0), gp(0)]), [0x66, 0x48, 0x0F, 0x7E, 0xC0]); // movq %xmm0,%rax
        assert_eq!(mov(&[gp(9), xmm(3)]), [0x66, 0x49, 0x0F, 0x6E, 0xD9]); // movq %r9,%xmm3
        // xmm<->xmm and mem->xmm load: F3 0F 7E; xmm->mem store: 66 0F D6.
        assert_eq!(mov(&[xmm(0), xmm(1)]), [0xF3, 0x0F, 0x7E, 0xC8]); // movq %xmm0,%xmm1
        assert_eq!(mov(&[mem(0), xmm(0)]), [0xF3, 0x0F, 0x7E, 0x00]); // movq (%rax),%xmm0
        assert_eq!(mov(&[xmm(0), mem(0)]), [0x66, 0x0F, 0xD6, 0x00]); // movq %xmm0,(%rax)
        assert_eq!(mov(&[xmm(9), xmm(10)]), [0xF3, 0x45, 0x0F, 0x7E, 0xD1]); // high xmm
        // A plain GP move (no xmm) still encodes normally.
        assert_eq!(mov(&[gp(0), gp(3)]), [0x48, 0x89, 0xC3]); // movq %rax,%rbx
    }

    #[test]
    fn movq_mmx_forms() {
        // Byte-exact vs GNU as: mm<->mem (0F 7F / 6F), mm<->mm (0F 6F),
        // GP64<->mm (REX.W 0F 6E/7E), and the WAIT prefix byte.
        assert_eq!(asm_bytes(b"movq %%mm0, (%%rdi)"), [0x0F, 0x7F, 0x07]);
        assert_eq!(asm_bytes(b"movq (%%rdi), %%mm1"), [0x0F, 0x6F, 0x0F]);
        assert_eq!(asm_bytes(b"movq %%mm2, %%mm3"), [0x0F, 0x6F, 0xDA]);
        assert_eq!(asm_bytes(b"movq %%mm4, %%rax"), [0x48, 0x0F, 0x7E, 0xE0]);
        assert_eq!(asm_bytes(b"movq %%rax, %%mm5"), [0x48, 0x0F, 0x6E, 0xE8]);
        assert_eq!(
            asm_bytes(b"movq %%mm0, 8(%%r10)"),
            [0x41, 0x0F, 0x7F, 0x42, 0x08]
        );
        assert_eq!(asm_bytes(b"fwait"), [0x9B]);
        assert_eq!(asm_bytes(b"fninit"), [0xDB, 0xE3]);
    }

    #[test]
    fn x87_and_invept_forms() {
        // Byte-exact vs GNU as: fnclex (DB E2), fdivl m64 (DC /6), and
        // invept r64, m128 (66 0F 38 80 /r).
        assert_eq!(asm_bytes(b"fnclex"), [0xDB, 0xE2]);
        assert_eq!(asm_bytes(b"fdivl (%%rax)"), [0xDC, 0x30]);
        assert_eq!(asm_bytes(b"fdivl 8(%%rbx)"), [0xDC, 0x73, 0x08]);
        assert_eq!(
            asm_bytes(b"invept (%%rdi), %%rax"),
            [0x66, 0x0F, 0x38, 0x80, 0x07]
        );
    }

    #[test]
    fn port_io_variable_form() {
        // `in`/`out` DX-port form: width from the AT&T suffix; word takes
        // the 0x66 prefix. Registers are implicit (accumulator + DX).
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Byte), &[]), [0xEC]);
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Word), &[]), [0x66, 0xED]);
        assert_eq!(enc(Mnemonic::In, Some(AsmRegSize::Long), &[]), [0xED]);
        assert_eq!(enc(Mnemonic::Out, Some(AsmRegSize::Byte), &[]), [0xEE]);
        assert_eq!(
            enc(Mnemonic::Out, Some(AsmRegSize::Word), &[]),
            [0x66, 0xEF]
        );
        assert_eq!(enc(Mnemonic::Out, Some(AsmRegSize::Long), &[]), [0xEF]);
    }

    #[test]
    fn catalogue_passthrough() {
        let q = AsmRegSize::Quad;
        let rax = Concrete::Reg { reg: 0, size: q };
        let rbx = Concrete::Reg { reg: 3, size: q };
        // A non-bespoke catalogue mnemonic parses to Mnemonic::Table, stripping
        // an AT&T size suffix; an unknown token stays unresolved.
        assert_eq!(split_mnemonic("cmp"), Some((Mnemonic::Table("cmp"), None)));
        assert_eq!(
            split_mnemonic("negq"),
            Some((Mnemonic::Table("neg"), Some(q)))
        );
        assert_eq!(split_mnemonic("bogusxyz"), None);
        // Encodings match the assembler (the table is the same core the
        // differential sweep checks): neg/not (F7 /3,/2), and AT&T
        // `op src, dst` transposed to Intel for cmp (39 /r) and adc (11 /r).
        assert_eq!(
            enc(Mnemonic::Table("neg"), None, &[rax]),
            [0x48, 0xF7, 0xD8]
        );
        assert_eq!(
            enc(Mnemonic::Table("not"), None, &[rax]),
            [0x48, 0xF7, 0xD0]
        );
        assert_eq!(
            enc(Mnemonic::Table("cmp"), None, &[rbx, rax]),
            [0x48, 0x39, 0xD8]
        );
        assert_eq!(
            enc(Mnemonic::Table("adc"), None, &[rbx, rax]),
            [0x48, 0x11, 0xD8]
        );
        // A rotate takes its count after the destination; `rol $1` selects the
        // D1 /0 rotate-by-one short form, `rol $4` the C1 /0 immediate form.
        assert_eq!(
            enc(Mnemonic::Table("rol"), None, &[Concrete::Imm(1), rax]),
            [0x48, 0xD1, 0xC0]
        );
        assert_eq!(
            enc(Mnemonic::Table("rol"), None, &[Concrete::Imm(4), rax]),
            [0x48, 0xC1, 0xC0, 0x04]
        );
    }

    #[test]
    fn system_ops_encoding() {
        assert_eq!(enc(Mnemonic::Pause, None, &[]), [0xF3, 0x90]);
        assert_eq!(
            enc(
                Mnemonic::SizedNullary {
                    opcode: 0x9C,
                    opw: Some(8),
                    stack: true
                },
                None,
                &[]
            ),
            [0x9C]
        );
        assert_eq!(enc(Mnemonic::Int, None, &[Concrete::Imm(3)]), [0xCC]);
        assert_eq!(
            enc(Mnemonic::Int, None, &[Concrete::Imm(0x20)]),
            [0xCD, 0x20]
        );
        // pop rax = 0x58; pop r8 = REX.B 0x58.
        let rax = Concrete::Reg {
            reg: 0,
            size: AsmRegSize::Quad,
        };
        let r8 = Concrete::Reg {
            reg: 8,
            size: AsmRegSize::Quad,
        };
        assert_eq!(enc(Mnemonic::Table("pop"), None, &[rax]), [0x58]);
        assert_eq!(enc(Mnemonic::Table("pop"), None, &[r8]), [0x41, 0x58]);
    }

    /// Unsuffixed `pushf` / `popf` take the 64-bit operand size, and the AT&T
    /// word-suffixed push / pop of a register take the operand-size prefix.
    /// Bytes match gcc and clang for the same templates.
    #[test]
    fn flag_and_word_push_pop_encoding() {
        assert_eq!(asm_bytes(b"pushf"), [0x9C]);
        assert_eq!(asm_bytes(b"popf"), [0x9D]);
        assert_eq!(asm_bytes(b"pushfq"), [0x9C]);
        assert_eq!(asm_bytes(b"popfq"), [0x9D]);
        assert_eq!(asm_bytes(b"pushfw"), [0x66, 0x9C]);
        assert_eq!(asm_bytes(b"popfw"), [0x66, 0x9D]);
        // `pushw %ax` is `push` at word width; the Intel-syntax catalogue
        // entry named `pushw` covers only the imm16 row, which still encodes.
        assert_eq!(asm_bytes(b"pushw %%ax"), [0x66, 0x50]);
        assert_eq!(asm_bytes(b"popw %%ax"), [0x66, 0x58]);
        assert_eq!(asm_bytes(b"pushw %%cx"), [0x66, 0x51]);
        assert_eq!(asm_bytes(b"pushw $0x1234"), [0x66, 0x68, 0x34, 0x12]);
        assert_eq!(asm_bytes(b"push %%rax"), [0x50]);
        assert_eq!(asm_bytes(b"pop %%rax"), [0x58]);
    }

    #[test]
    fn port_io_mnemonic_parse() {
        // AT&T `inb`/`inw`/`inl`, `outb`/... split to (In/Out, size).
        assert_eq!(
            split_mnemonic("inb"),
            Some((Mnemonic::In, Some(AsmRegSize::Byte)))
        );
        assert_eq!(
            split_mnemonic("inl"),
            Some((Mnemonic::In, Some(AsmRegSize::Long)))
        );
        assert_eq!(
            split_mnemonic("outb"),
            Some((Mnemonic::Out, Some(AsmRegSize::Byte)))
        );
        assert_eq!(split_mnemonic("in"), Some((Mnemonic::In, None)));
    }

    #[test]
    fn assign_fp_operands_to_xmm() {
        use crate::c5::ir::{AsmConstraint as C, AsmOperand};
        let op = |constraint| AsmOperand {
            constraint,
            is_output: false,
            is_rw: false,
            width: 16,
            seg: crate::c5::ir::AsmSeg::None,
        };
        // `x` operands take xmm0, xmm1, ... from a file independent of the GPRs,
        // so a mixed GP + xmm operand list assigns each from its own pool.
        let ops = [op(C::Reg), op(C::Fp), op(C::Reg), op(C::Fp)];
        let a = assign_operand_regs(&ops, 0, 0).unwrap();
        assert_eq!(a, [Some(0), Some(0), Some(3), Some(1)]); // rax, xmm0, rbx, xmm1
        // An xmm named in the clobber list is skipped: xmm0 clobbered pushes the
        // first `x` operand onto xmm1.
        let a = assign_operand_regs(&[op(C::Fp), op(C::Fp)], 0, 1 << 0).unwrap();
        assert_eq!(a, [Some(1), Some(2)]);
    }

    #[test]
    fn clobbered_gp_registers_are_excluded_from_the_operand_pool() {
        use crate::c5::ir::{AsmConstraint as C, AsmOperand};
        let op = |constraint| AsmOperand {
            constraint,
            is_output: false,
            is_rw: false,
            width: 8,
            seg: crate::c5::ir::AsmSeg::None,
        };
        // Pool order is rax(0) rbx(3) rcx(1) rdx(2) rsi(6) rdi(7) r8(8) r9(9)
        // r12(12) r13(13) r14(14) r15(15). With rax/rbx/rcx/rdx clobbered,
        // three `r` operands skip them and land on rsi/rdi/r8 rather than
        // reusing a clobbered register.
        let clob = (1 << 0) | (1 << 3) | (1 << 1) | (1 << 2);
        let gp = [op(C::Reg), op(C::Reg), op(C::Reg)];
        let a = assign_operand_regs(&gp, clob, 0).unwrap();
        assert_eq!(a, [Some(6), Some(7), Some(8)]);
        // An asm that calls out clobbers the caller-saved bank
        // (rax rcx rdx rsi rdi r8 r9); its `r` operands then take the
        // callee-saved registers rbx r12..r15, which the emitter saves and
        // restores around the block.
        let caller_saved = [0u8, 1, 2, 6, 7, 8, 9]
            .iter()
            .fold(0u32, |m, &r| m | (1 << r));
        let five = [op(C::Reg), op(C::Reg), op(C::Reg), op(C::Reg), op(C::Reg)];
        let a = assign_operand_regs(&five, caller_saved, 0).unwrap();
        assert_eq!(a, [Some(3), Some(12), Some(13), Some(14), Some(15)]);
        // A clobber list covering every pool register leaves nothing to assign;
        // reject rather than reuse a clobbered register.
        let all = [0u8, 3, 1, 2, 6, 7, 8, 9, 12, 13, 14, 15]
            .iter()
            .fold(0u32, |m, &r| m | (1 << r));
        assert!(assign_operand_regs(&[op(C::Reg)], all, 0).is_err());
    }

    #[test]
    fn vex_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let ymm = |n: u8| Concrete::Reg {
            reg: YMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let vex = |pp, opcode| Mnemonic::Vex {
            pp,
            map: 1,
            w: false,
            opcode,
        };
        // 3-operand VEX, AT&T `v-op %src2, %src1, %dst`. Byte-exact vs clang.
        // vaddps %xmm2,%xmm1,%xmm0: 2-byte VEX.
        assert_eq!(
            enc(vex(0, 0x58), None, &[xmm(2), xmm(1), xmm(0)]),
            [0xC5, 0xF0, 0x58, 0xC2]
        );
        // ymm sets the L bit.
        assert_eq!(
            enc(vex(0, 0x58), None, &[ymm(2), ymm(1), ymm(0)]),
            [0xC5, 0xF4, 0x58, 0xC2]
        );
        // A high src2 needs the 3-byte VEX (C4) form for VEX.B.
        assert_eq!(
            enc(vex(0, 0x58), None, &[xmm(10), xmm(9), xmm(8)]),
            [0xC4, 0x41, 0x30, 0x58, 0xC2]
        );
        // pp selects the SSE prefix: 0x66 (vpaddd), 0xF3 (vaddss).
        assert_eq!(
            enc(vex(1, 0xFE), None, &[xmm(2), xmm(1), xmm(0)]),
            [0xC5, 0xF1, 0xFE, 0xC2]
        );
        assert_eq!(
            enc(vex(2, 0x58), None, &[xmm(2), xmm(1), xmm(0)]),
            [0xC5, 0xF2, 0x58, 0xC2]
        );
        // vmulsd %xmm12,%xmm1,%xmm3: 3-byte VEX (high src2), pp = 0xF2.
        assert_eq!(
            enc(vex(3, 0x59), None, &[xmm(12), xmm(1), xmm(3)]),
            [0xC4, 0xC1, 0x73, 0x59, 0xDC]
        );
        // vpmulld: 0F38 map forces the 3-byte VEX (c4 e2 71 40 c2 for
        // %xmm2,%xmm1,%xmm0). vshufps: 3-operand + imm. vpshufd: 2-operand + imm.
        assert_eq!(
            enc(
                Mnemonic::Vex {
                    pp: 1,
                    map: 2,
                    w: false,
                    opcode: 0x40
                },
                None,
                &[xmm(2), xmm(1), xmm(0)]
            ),
            [0xC4, 0xE2, 0x71, 0x40, 0xC2]
        );
        assert_eq!(
            enc(
                Mnemonic::VexImm3 {
                    pp: 0,
                    map: 1,
                    opcode: 0xC6,
                    is4: false
                },
                None,
                &[Concrete::Imm(0x1b), xmm(2), xmm(1), xmm(0)]
            ),
            [0xC5, 0xF0, 0xC6, 0xC2, 0x1B]
        );
        assert_eq!(
            enc(
                Mnemonic::VexImm2 {
                    pp: 1,
                    map: 1,
                    opcode: 0x70,
                    store: false
                },
                None,
                &[Concrete::Imm(0x1b), xmm(1), xmm(0)]
            ),
            [0xC5, 0xF9, 0x70, 0xC1, 0x1B]
        );
        // The table resolves names.
        assert_eq!(
            vex_op("vaddps"),
            Some(Mnemonic::Vex {
                pp: 0,
                map: 1,
                w: false,
                opcode: 0x58
            })
        );
        assert_eq!(
            vex_op("vpmulld"),
            Some(Mnemonic::Vex {
                pp: 1,
                map: 2,
                w: false,
                opcode: 0x40
            })
        );
        assert_eq!(
            vex_op("vshufps"),
            Some(Mnemonic::VexImm3 {
                pp: 0,
                map: 1,
                opcode: 0xC6,
                is4: false
            })
        );
        assert_eq!(vex_op("not_a_vex"), None);
        // 2-operand VEX moves (VEX.vvvv = 1111): reg-reg uses load_op, a store
        // to memory uses store_op. Byte-exact vs clang.
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size: AsmRegSize::Quad,
        };
        let vmov = |pp, load_op, store_op| Mnemonic::VexMov {
            pp,
            load_op,
            store_op,
        };
        // vmovdqu %ymm1,%ymm0 (F3, L=1): c5 fe 6f c1.
        assert_eq!(
            enc(vmov(2, 0x6F, 0x7F), None, &[ymm(1), ymm(0)]),
            [0xC5, 0xFE, 0x6F, 0xC1]
        );
        // vmovdqu %ymm0,(%rax) store: c5 fe 7f 00.
        assert_eq!(
            enc(vmov(2, 0x6F, 0x7F), None, &[ymm(0), mem(0)]),
            [0xC5, 0xFE, 0x7F, 0x00]
        );
        // vmovups (%rcx),%ymm2 load (no prefix): c5 fc 10 11.
        assert_eq!(
            enc(vmov(0, 0x10, 0x11), None, &[mem(1), ymm(2)]),
            [0xC5, 0xFC, 0x10, 0x11]
        );
        // 2-operand VEX compute: vsqrtps %ymm1,%ymm0: c5 fc 51 c1.
        assert_eq!(
            enc(
                Mnemonic::Vex2 {
                    pp: 0,
                    map: 1,
                    opcode: 0x51,
                    mem_only: false
                },
                None,
                &[ymm(1), ymm(0)]
            ),
            [0xC5, 0xFC, 0x51, 0xC1]
        );
        // 3-operand VEX with a memory src2: vaddps (%rax),%ymm1,%ymm0: c5 f4 58 00.
        assert_eq!(
            enc(vex(0, 0x58), None, &[mem(0), ymm(1), ymm(0)]),
            [0xC5, 0xF4, 0x58, 0x00]
        );
        assert_eq!(
            vex_op("vmovdqu"),
            Some(Mnemonic::VexMov {
                pp: 2,
                load_op: 0x6F,
                store_op: 0x7F
            })
        );
        assert_eq!(
            vex_op("vsqrtps"),
            Some(Mnemonic::Vex2 {
                pp: 0,
                map: 1,
                opcode: 0x51,
                mem_only: false
            })
        );
    }

    #[test]
    fn vex_0f38_0f3a_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let ymm = |n: u8| Concrete::Reg {
            reg: YMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let mem = |base: u8| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp: 0,
            size: AsmRegSize::Quad,
        };
        let e = |name: &str, ops: &[Concrete]| enc(vex_op(name).unwrap(), None, ops);
        // 0F38 variable shifts: W selects dword (0) / qword (1) elements.
        // Byte-exact vs clang.
        assert_eq!(
            e("vpsllvd", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0x47, 0xC2]
        );
        assert_eq!(
            e("vpsllvd", &[ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE2, 0x75, 0x47, 0xC2]
        );
        assert_eq!(
            e("vpsllvd", &[xmm(10), xmm(9), xmm(8)]),
            [0xC4, 0x42, 0x31, 0x47, 0xC2]
        );
        assert_eq!(
            e("vpsrlvd", &[ymm(12), ymm(11), ymm(10)]),
            [0xC4, 0x42, 0x25, 0x45, 0xD4]
        );
        assert_eq!(
            e("vpsravd", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0x46, 0xC2]
        );
        assert_eq!(
            e("vpsllvq", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0xF1, 0x47, 0xC2]
        );
        assert_eq!(
            e("vpsrlvq", &[ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE2, 0xF5, 0x45, 0xC2]
        );
        assert_eq!(
            e("vpsllvd", &[mem(0), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0x47, 0x00]
        );
        // vpermd (ymm only).
        assert_eq!(
            e("vpermd", &[ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE2, 0x75, 0x36, 0xC2]
        );
        // FMA: ps is W0, pd W1; one op per 132/213/231 group plus a memory
        // source and high registers.
        assert_eq!(
            e("vfmadd132ps", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0x98, 0xC2]
        );
        assert_eq!(
            e("vfmadd213ps", &[ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE2, 0x75, 0xA8, 0xC2]
        );
        assert_eq!(
            e("vfmadd231pd", &[ymm(12), ymm(9), ymm(8)]),
            [0xC4, 0x42, 0xB5, 0xB8, 0xC4]
        );
        assert_eq!(
            e("vfmsub213pd", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0xF1, 0xAA, 0xC2]
        );
        assert_eq!(
            e("vfnmadd231ps", &[xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x71, 0xBC, 0xC2]
        );
        assert_eq!(
            e("vfnmsub132ps", &[xmm(10), xmm(9), xmm(8)]),
            [0xC4, 0x42, 0x31, 0x9E, 0xC2]
        );
        assert_eq!(
            e("vfmadd231pd", &[mem(8), ymm(1), ymm(0)]),
            [0xC4, 0xC2, 0xF5, 0xB8, 0x00]
        );
        // 0F38 broadcasts (2-operand): L follows the destination.
        assert_eq!(
            e("vpbroadcastb", &[xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x79, 0x78, 0xC1]
        );
        assert_eq!(
            e("vpbroadcastw", &[xmm(1), ymm(0)]),
            [0xC4, 0xE2, 0x7D, 0x79, 0xC1]
        );
        assert_eq!(
            e("vpbroadcastd", &[xmm(9), ymm(8)]),
            [0xC4, 0x42, 0x7D, 0x58, 0xC1]
        );
        assert_eq!(
            e("vpbroadcastq", &[xmm(1), xmm(0)]),
            [0xC4, 0xE2, 0x79, 0x59, 0xC1]
        );
        assert_eq!(
            e("vpbroadcastd", &[mem(0), ymm(0)]),
            [0xC4, 0xE2, 0x7D, 0x58, 0x00]
        );
        assert_eq!(
            e("vbroadcastss", &[mem(9), ymm(2)]),
            [0xC4, 0xC2, 0x7D, 0x18, 0x11]
        );
        // 0F3A immediate forms.
        assert_eq!(
            e("vpermilps", &[Concrete::Imm(0x1b), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x79, 0x04, 0xC1, 0x1B]
        );
        assert_eq!(
            e("vpermilps", &[Concrete::Imm(0x1b), xmm(9), xmm(8)]),
            [0xC4, 0x43, 0x79, 0x04, 0xC1, 0x1B]
        );
        assert_eq!(
            e("vpermilpd", &[Concrete::Imm(0x5), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x7D, 0x05, 0xC1, 0x05]
        );
        assert_eq!(
            e("vpermilps", &[Concrete::Imm(0x1b), mem(0), xmm(0)]),
            [0xC4, 0xE3, 0x79, 0x04, 0x00, 0x1B]
        );
        assert_eq!(
            e("vperm2f128", &[Concrete::Imm(0x21), ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x06, 0xC2, 0x21]
        );
        assert_eq!(
            e(
                "vperm2f128",
                &[Concrete::Imm(0x21), ymm(10), ymm(9), ymm(8)]
            ),
            [0xC4, 0x43, 0x35, 0x06, 0xC2, 0x21]
        );
        assert_eq!(
            e("vpblendd", &[Concrete::Imm(0x8), xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x71, 0x02, 0xC2, 0x08]
        );
        assert_eq!(
            e("vpblendd", &[Concrete::Imm(0xa1), ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x02, 0xC2, 0xA1]
        );
        assert_eq!(
            e("vpalignr", &[Concrete::Imm(0x4), xmm(10), xmm(9), xmm(8)]),
            [0xC4, 0x43, 0x31, 0x0F, 0xC2, 0x04]
        );
        assert_eq!(
            e("vpalignr", &[Concrete::Imm(0x4), mem(0), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x71, 0x0F, 0x00, 0x04]
        );
        assert_eq!(
            e("vinsertf128", &[Concrete::Imm(0x1), xmm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x18, 0xC2, 0x01]
        );
        assert_eq!(
            e("vinsertf128", &[Concrete::Imm(0x1), mem(0), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x18, 0x00, 0x01]
        );
    }

    /// The is4 blends (VEX.NDS.128/256.66.0F3A.W0 4C / 4A / 4B /r /is4). AT&T
    /// orders the operands mask, src2, src1, dst: the mask occupies the top four
    /// bits of the trailing byte, src1 VEX.vvvv, src2 ModRM.r/m, dst ModRM.reg.
    /// Bytes measured with GNU as 2.46.1.
    #[test]
    fn vex_is4_blend_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let ymm = |n: u8| Concrete::Reg {
            reg: YMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let mem = |base: u8, index: Option<u8>, scale: u8, disp: i32| Concrete::Mem {
            base,
            index,
            scale,
            disp,
            size: AsmRegSize::Quad,
        };
        let e = |name: &str, ops: &[Concrete]| enc(vex_op(name).unwrap(), None, ops);
        // vpblendvb %xmm3,%xmm2,%xmm1,%xmm0 / the ymm form (L=1).
        assert_eq!(
            e("vpblendvb", &[xmm(3), xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x71, 0x4C, 0xC2, 0x30]
        );
        assert_eq!(
            e("vpblendvb", &[ymm(3), ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x4C, 0xC2, 0x30]
        );
        // vblendvps / vblendvpd share the shape at 0x4A / 0x4B.
        assert_eq!(
            e("vblendvps", &[xmm(3), xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x71, 0x4A, 0xC2, 0x30]
        );
        assert_eq!(
            e("vblendvpd", &[xmm(3), xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x71, 0x4B, 0xC2, 0x30]
        );
        assert_eq!(
            e("vblendvpd", &[ymm(3), ymm(2), ymm(1), ymm(0)]),
            [0xC4, 0xE3, 0x75, 0x4B, 0xC2, 0x30]
        );
        assert_eq!(
            e("vblendvps", &[ymm(11), ymm(10), ymm(9), ymm(8)]),
            [0xC4, 0x43, 0x35, 0x4A, 0xC2, 0xB0]
        );
        // A high register in each field on its own: the mask has no prefix bit
        // and carries all four of its bits in the is4 byte, the destination
        // sets VEX.R, src2 VEX.B, and src1 rides VEX.vvvv.
        assert_eq!(
            e("vpblendvb", &[xmm(11), xmm(2), xmm(1), xmm(0)]),
            [0xC4, 0xE3, 0x71, 0x4C, 0xC2, 0xB0]
        );
        assert_eq!(
            e("vpblendvb", &[xmm(3), xmm(2), xmm(1), xmm(9)]),
            [0xC4, 0x63, 0x71, 0x4C, 0xCA, 0x30]
        );
        assert_eq!(
            e("vpblendvb", &[xmm(3), xmm(10), xmm(1), xmm(0)]),
            [0xC4, 0xC3, 0x71, 0x4C, 0xC2, 0x30]
        );
        assert_eq!(
            e("vpblendvb", &[xmm(3), xmm(2), xmm(12), xmm(0)]),
            [0xC4, 0xE3, 0x19, 0x4C, 0xC2, 0x30]
        );
        assert_eq!(
            e("vpblendvb", &[xmm(15), xmm(14), xmm(13), xmm(12)]),
            [0xC4, 0x43, 0x11, 0x4C, 0xE6, 0xF0]
        );
        // A memory src2: the is4 byte follows the displacement.
        // vpblendvb %xmm3,-16(%rsi,%rdx),%xmm1,%xmm1.
        assert_eq!(
            e(
                "vpblendvb",
                &[xmm(3), mem(6, Some(2), 1, -16), xmm(1), xmm(1)]
            ),
            [0xC4, 0xE3, 0x71, 0x4C, 0x4C, 0x16, 0xF0, 0x30]
        );
        // vpblendvb %xmm3,(%rax,%rbx,4),%xmm1,%xmm2.
        assert_eq!(
            e(
                "vpblendvb",
                &[xmm(3), mem(0, Some(3), 4, 0), xmm(1), xmm(2)]
            ),
            [0xC4, 0xE3, 0x71, 0x4C, 0x14, 0x98, 0x30]
        );
        // vpblendvb %ymm3,128(%r12,%r13,8),%ymm1,%ymm2: high base and index,
        // disp32.
        assert_eq!(
            e(
                "vpblendvb",
                &[ymm(3), mem(12, Some(13), 8, 128), ymm(1), ymm(2)]
            ),
            [
                0xC4, 0x83, 0x75, 0x4C, 0x94, 0xEC, 0x80, 0x00, 0x00, 0x00, 0x30
            ]
        );
        // vpblendvb %xmm3,16(%rsp),%xmm1,%xmm2: an rsp base forces a SIB.
        assert_eq!(
            e("vpblendvb", &[xmm(3), mem(4, None, 1, 16), xmm(1), xmm(2)]),
            [0xC4, 0xE3, 0x71, 0x4C, 0x54, 0x24, 0x10, 0x30]
        );
        // vblendvps %ymm3,(%r11),%ymm1,%ymm2 / vblendvpd %xmm3,8(%rbp),%xmm1,%xmm2.
        assert_eq!(
            e("vblendvps", &[ymm(3), mem(11, None, 1, 0), ymm(1), ymm(2)]),
            [0xC4, 0xC3, 0x75, 0x4A, 0x13, 0x30]
        );
        assert_eq!(
            e("vblendvpd", &[xmm(3), mem(5, None, 1, 8), xmm(1), xmm(2)]),
            [0xC4, 0xE3, 0x71, 0x4B, 0x55, 0x08, 0x30]
        );
        // The parse path takes the four-register form as spelled in AT&T.
        assert_eq!(
            asm_bytes(b"vpblendvb %%xmm3, -16(%%rsi,%%rdx), %%xmm1, %%xmm1"),
            [0xC4, 0xE3, 0x71, 0x4C, 0x4C, 0x16, 0xF0, 0x30]
        );
        assert_eq!(
            asm_bytes(b"vblendvps %%ymm11, %%ymm10, %%ymm9, %%ymm8"),
            [0xC4, 0x43, 0x35, 0x4A, 0xC2, 0xB0]
        );
        // The table resolves the group; the immediate members keep their shape.
        assert_eq!(
            vex_op("vpblendvb"),
            Some(Mnemonic::VexImm3 {
                pp: 1,
                map: 3,
                opcode: 0x4C,
                is4: true
            })
        );
        assert_eq!(
            vex_op("vblendvps"),
            Some(Mnemonic::VexImm3 {
                pp: 1,
                map: 3,
                opcode: 0x4A,
                is4: true
            })
        );
        assert_eq!(
            vex_op("vblendvpd"),
            Some(Mnemonic::VexImm3 {
                pp: 1,
                map: 3,
                opcode: 0x4B,
                is4: true
            })
        );
        assert_eq!(
            vex_op("vpblendw"),
            Some(Mnemonic::VexImm3 {
                pp: 1,
                map: 3,
                opcode: 0x0E,
                is4: false
            })
        );
        // The mask slot takes a register, not an immediate, and the form needs
        // all four operands.
        let mut c = Vec::new();
        assert!(
            encode(
                &mut c,
                8,
                vex_op("vpblendvb").unwrap(),
                None,
                &[Concrete::Imm(0x30), xmm(2), xmm(1), xmm(0)]
            )
            .is_err()
        );
        assert!(
            encode(
                &mut c,
                8,
                vex_op("vpblendvb").unwrap(),
                None,
                &[xmm(2), xmm(1), xmm(0)]
            )
            .is_err()
        );
    }

    /// The 128-bit lane broadcasts and the packed integer extends
    /// (VEX.66.0F38.W0). Both take an xmm or memory source and set VEX.L from
    /// the destination width; the lane broadcasts have no register-source
    /// form. Bytes measured with GNU as 2.46.1.
    #[test]
    fn vex_lane_broadcast_and_extend_ops() {
        let xmm = |n: u8| Concrete::Reg {
            reg: XMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let ymm = |n: u8| Concrete::Reg {
            reg: YMM_BASE + n,
            size: AsmRegSize::Quad,
        };
        let mem = |base: u8, disp: i32| Concrete::Mem {
            base,
            index: None,
            scale: 1,
            disp,
            size: AsmRegSize::Quad,
        };
        let e = |name: &str, ops: &[Concrete]| enc(vex_op(name).unwrap(), None, ops);
        assert_eq!(
            e("vbroadcasti128", &[mem(0, 0), ymm(0)]),
            [0xC4, 0xE2, 0x7D, 0x5A, 0x00]
        );
        assert_eq!(
            e("vbroadcasti128", &[mem(1, -48), ymm(7)]),
            [0xC4, 0xE2, 0x7D, 0x5A, 0x79, 0xD0]
        );
        assert_eq!(
            e("vbroadcasti128", &[mem(12, 32), ymm(11)]),
            [0xC4, 0x42, 0x7D, 0x5A, 0x5C, 0x24, 0x20]
        );
        assert_eq!(
            e("vbroadcastf128", &[mem(0, 0), ymm(0)]),
            [0xC4, 0xE2, 0x7D, 0x1A, 0x00]
        );
        let mut c = Vec::new();
        assert!(
            encode(
                &mut c,
                8,
                vex_op("vbroadcasti128").unwrap(),
                None,
                &[xmm(1), ymm(0)]
            )
            .is_err()
        );
        // The extends over every source / destination element pair, sign at
        // 0x20 + n and zero at 0x30 + n.
        #[rustfmt::skip]
        let ext = [
            ("vpmovsxbw", 0x20u8), ("vpmovsxbd", 0x21), ("vpmovsxbq", 0x22),
            ("vpmovsxwd", 0x23), ("vpmovsxwq", 0x24), ("vpmovsxdq", 0x25),
            ("vpmovzxbw", 0x30), ("vpmovzxbd", 0x31), ("vpmovzxbq", 0x32),
            ("vpmovzxwd", 0x33), ("vpmovzxwq", 0x34), ("vpmovzxdq", 0x35),
        ];
        for (name, opcode) in ext {
            assert_eq!(
                e(name, &[xmm(1), ymm(0)]),
                [0xC4, 0xE2, 0x7D, opcode, 0xC1],
                "{name}"
            );
        }
        // An xmm destination clears L; the source stays 128-bit either way.
        assert_eq!(
            e("vpmovzxbd", &[xmm(9), xmm(2)]),
            [0xC4, 0xC2, 0x79, 0x31, 0xD1]
        );
        assert_eq!(
            e("vpmovzxbd", &[mem(0, 0), ymm(8)]),
            [0xC4, 0x62, 0x7D, 0x31, 0x00]
        );
        assert_eq!(
            e("vpmovzxbw", &[mem(0, 0), ymm(0)]),
            [0xC4, 0xE2, 0x7D, 0x30, 0x00]
        );
        assert_eq!(
            e("vpmovsxbw", &[mem(12, 0), xmm(0)]),
            [0xC4, 0xC2, 0x79, 0x20, 0x04, 0x24]
        );
        assert_eq!(
            e("vpmovzxwd", &[mem(12, 32), ymm(11)]),
            [0xC4, 0x42, 0x7D, 0x33, 0x5C, 0x24, 0x20]
        );
    }

    /// The SSE / AVX rows the distribution-configuration kernel names:
    /// `lib/raid6/{sse2,avx2,avx512}.c`, `arch/x86/crypto/camellia-aesni-avx*`,
    /// `arch/x86/crypto/aes-gcm-{aesni,vaes-avx2}-x86_64.S`,
    /// `lib/crypto/x86/{nh-avx2,poly1305-x86_64-cryptogams}.S`,
    /// `lib/crc/x86/crc16-msb-pclmul.S` and
    /// `net/netfilter/nft_set_pipapo_avx2.c`. Bytes measured with GNU as
    /// 2.46.1.
    #[test]
    fn kernel_simd_rows() {
        #[rustfmt::skip]
        let cases: &[(&[u8], &[u8])] = &[
            (b"pcmpgtb %%xmm1, %%xmm0", &[0x66, 0x0F, 0x64, 0xC1]),
            (b"pcmpgtb 16(%%rsi), %%xmm9", &[0x66, 0x44, 0x0F, 0x64, 0x4E, 0x10]),
            (b"pcmpgtw %%xmm3, %%xmm12", &[0x66, 0x44, 0x0F, 0x65, 0xE3]),
            (b"ptest %%xmm0, %%xmm4", &[0x66, 0x0F, 0x38, 0x17, 0xE0]),
            (b"ptest (%%rdi), %%xmm11", &[0x66, 0x44, 0x0F, 0x38, 0x17, 0x1F]),
            (b"vpcmpgtb %%xmm11, %%xmm12, %%xmm13", &[0xC4, 0x41, 0x19, 0x64, 0xEB]),
            (b"vpcmpgtb %%ymm11, %%ymm12, %%ymm13", &[0xC4, 0x41, 0x1D, 0x64, 0xEB]),
            (b"vpcmpgtw %%xmm1, %%xmm2, %%xmm3", &[0xC5, 0xE9, 0x65, 0xD9]),
            (b"vpcmpeqb %%ymm0, %%ymm1, %%ymm2", &[0xC5, 0xF5, 0x74, 0xD0]),
            (b"vpcmpeqw %%xmm0, %%xmm1, %%xmm2", &[0xC5, 0xF1, 0x75, 0xD0]),
            (b"vpmuludq %%ymm12, %%ymm8, %%ymm8", &[0xC4, 0x41, 0x3D, 0xF4, 0xC4]),
            (b"vpmuludq %%xmm5, %%xmm14, %%xmm10", &[0xC5, 0x09, 0xF4, 0xD5]),
            (b"vpmulhw %%xmm5, %%xmm14, %%xmm10", &[0xC5, 0x09, 0xE5, 0xD5]),
            (b"vptest %%xmm1, %%xmm0", &[0xC4, 0xE2, 0x79, 0x17, 0xC1]),
            (b"vptest %%ymm1, %%ymm0", &[0xC4, 0xE2, 0x7D, 0x17, 0xC1]),
            (b"vptest (%%rax), %%ymm3", &[0xC4, 0xE2, 0x7D, 0x17, 0x18]),
            (b"vmovntdqa (%%rsi), %%ymm0", &[0xC4, 0xE2, 0x7D, 0x2A, 0x06]),
            (b"vmovntdqa 32(%%rdi), %%xmm3", &[0xC4, 0xE2, 0x79, 0x2A, 0x5F, 0x20]),
            (b"vmovntdqa (%%r11), %%ymm12", &[0xC4, 0x42, 0x7D, 0x2A, 0x23]),
            // The word element pair takes the 0F map, with the general
            // register in ModRM.reg for the extract and in r/m for the insert.
            (b"pextrw $3, %%xmm0, %%eax", &[0x66, 0x0F, 0xC5, 0xC0, 0x03]),
            (b"pextrw $7, %%xmm9, %%r10d", &[0x66, 0x45, 0x0F, 0xC5, 0xD1, 0x07]),
            (b"pinsrw $2, %%eax, %%xmm3", &[0x66, 0x0F, 0xC4, 0xD8, 0x02]),
            (b"pinsrw $5, %%r11d, %%xmm12", &[0x66, 0x45, 0x0F, 0xC4, 0xE3, 0x05]),
        ];
        for (tmpl, want) in cases {
            assert_eq!(
                asm_bytes(tmpl),
                *want,
                "{}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
    }

    /// The rows the instruction-set database omits or spells with an explicit
    /// ModRM byte: SGX's leaf dispatch (`arch/x86/kernel/cpu/sgx/*.c`,
    /// `arch/x86/entry/vdso/vdso64/vsgx.S`) and the shadow-stack stores
    /// (`arch/x86/kernel/shstk.c`). Bytes measured with GNU as 2.46.1.
    #[test]
    fn sgx_and_shadow_stack_rows() {
        #[rustfmt::skip]
        let cases: &[(&[u8], &[u8])] = &[
            (b"encls", &[0x0F, 0x01, 0xCF]),
            (b"enclu", &[0x0F, 0x01, 0xD7]),
            (b"enclv", &[0x0F, 0x01, 0xC0]),
            (b"wrssd %%eax, (%%rdi)", &[0x0F, 0x38, 0xF6, 0x07]),
            (b"wrssq %%rax, 8(%%rdi)", &[0x48, 0x0F, 0x38, 0xF6, 0x47, 0x08]),
            (b"wrussd %%r10d, (%%rbx)", &[0x66, 0x44, 0x0F, 0x38, 0xF5, 0x13]),
            (b"aadd %%eax, (%%rdi)", &[0x0F, 0x38, 0xFC, 0x07]),
            (b"aand %%rax, (%%rdi)", &[0x66, 0x48, 0x0F, 0x38, 0xFC, 0x07]),
            (b"movrs (%%rsi), %%rax", &[0x48, 0x0F, 0x38, 0x8B, 0x06]),
        ];
        for (tmpl, want) in cases {
            assert_eq!(
                asm_bytes(tmpl),
                *want,
                "{}",
                core::str::from_utf8(tmpl).unwrap()
            );
        }
    }

    /// GNU as matches mnemonics without regard to case;
    /// `arch/x86/kernel/ftrace_64.S` writes `CALL`. A token that is not a
    /// mnemonic in either case stays unresolved.
    #[test]
    fn mnemonic_case_is_folded() {
        assert_eq!(asm_bytes(b"NOP"), [0x90]);
        assert_eq!(asm_bytes(b"RET"), [0xC3]);
        assert_eq!(asm_bytes(b"MOVQ %%rax, %%rbx"), [0x48, 0x89, 0xC3]);
        assert_eq!(
            asm_bytes(b"PTEST %%xmm1, %%xmm0"),
            [0x66, 0x0F, 0x38, 0x17, 0xC1]
        );
        // A direct branch to a symbol keeps that shape through the fold.
        let insns = parse_template(b"CALL .Ldo_rebalance").unwrap();
        assert_eq!(insns.len(), 1);
        assert_eq!(insns[0].sym_exprs, [String::from(".Ldo_rebalance")]);
        assert!(parse_template(b"ANNOTATE type=2").is_err());
    }

    /// `mov %seg, r/m16` (8C) and `mov r/m16, %seg` (8E). A memory operand is
    /// 16-bit by opcode, so it takes no operand-size prefix; a 32-bit base
    /// adds the address-size prefix, and an 8C register destination keeps the
    /// width its name spells. Neither direction takes REX.W, and 8E takes no
    /// operand-size prefix. Bytes measured with GNU as 2.46.1.
    #[test]
    fn segment_register_moves() {
        let sreg = |n: u8| Concrete::Reg {
            reg: SEG_BASE + n,
            size: AsmRegSize::Word,
        };
        let gp = |reg: u8, size: AsmRegSize| Concrete::Reg { reg, size };
        let mem = |base: u8, index: Option<u8>, scale: u8, disp: i32| Concrete::Mem {
            base,
            index,
            scale,
            disp,
            size: AsmRegSize::Word,
        };
        let e = |addr: u8, ops: &[Concrete]| {
            let mut c = Vec::new();
            encode_in(
                &mut c,
                super::super::table::Mode::Bits64,
                addr,
                Mnemonic::Mov,
                Some(AsmRegSize::Word),
                ops,
            )
            .unwrap();
            c
        };
        // movw %cs, 4(%eax) / 4(%rax): the 32-bit base takes 0x67.
        assert_eq!(
            e(4, &[sreg(1), mem(0, None, 1, 4)]),
            [0x67, 0x8C, 0x48, 0x04]
        );
        assert_eq!(e(8, &[sreg(1), mem(0, None, 1, 4)]), [0x8C, 0x48, 0x04]);
        // movw %ds, 8(%r12,%rbx,4): a high base takes REX.B, not REX.W.
        assert_eq!(
            e(8, &[sreg(3), mem(12, Some(3), 4, 8)]),
            [0x41, 0x8C, 0x5C, 0x9C, 0x08]
        );
        // movw 4(%rax), %ds loads the selector.
        assert_eq!(e(8, &[mem(0, None, 1, 4), sreg(3)]), [0x8E, 0x58, 0x04]);
        // The register forms: the 8C destination width alone selects 0x66.
        let mov = |ops: &[Concrete]| enc(Mnemonic::Mov, None, ops);
        assert_eq!(mov(&[sreg(3), gp(0, AsmRegSize::Word)]), [0x66, 0x8C, 0xD8]);
        assert_eq!(mov(&[sreg(1), gp(0, AsmRegSize::Long)]), [0x8C, 0xC8]);
        // mov %ds, %rax / mov %rax, %ds: a 64-bit GPR encodes as the 32-bit
        // one, the opcode moving 16 bits and zero-extending.
        assert_eq!(mov(&[sreg(3), gp(0, AsmRegSize::Quad)]), [0x8C, 0xD8]);
        assert_eq!(mov(&[gp(0, AsmRegSize::Quad), sreg(3)]), [0x8E, 0xD8]);
        // mov %ax, %ds / mov %eax, %ds: 8E reads 16 bits whatever the name.
        assert_eq!(mov(&[gp(0, AsmRegSize::Word), sreg(3)]), [0x8E, 0xD8]);
        assert_eq!(mov(&[gp(0, AsmRegSize::Long), sreg(3)]), [0x8E, 0xD8]);
        // A high GPR takes REX.B in both directions; %r8w keeps 8C's 0x66.
        assert_eq!(mov(&[sreg(4), gp(8, AsmRegSize::Quad)]), [0x41, 0x8C, 0xE0]);
        assert_eq!(mov(&[sreg(4), gp(8, AsmRegSize::Long)]), [0x41, 0x8C, 0xE0]);
        assert_eq!(
            mov(&[sreg(4), gp(8, AsmRegSize::Word)]),
            [0x66, 0x41, 0x8C, 0xE0]
        );
        assert_eq!(mov(&[gp(8, AsmRegSize::Quad), sreg(4)]), [0x41, 0x8E, 0xE0]);
        assert_eq!(mov(&[gp(8, AsmRegSize::Word), sreg(4)]), [0x41, 0x8E, 0xE0]);
    }

    /// A 32-bit base or index takes the `67` address-size prefix in 64-bit
    /// mode, ahead of the operand-size prefix and REX. Bytes measured with
    /// GNU as 2.46.1.
    #[test]
    fn address_size_prefix_follows_the_base_register_width() {
        let gas: &[(&[u8], &[u8])] = &[
            (b"movl 2(%eax), %ebx", &[0x67, 0x8B, 0x58, 0x02]),
            (b"movl (%eax), %ebx", &[0x67, 0x8B, 0x18]),
            (b"movl (%eax,%ecx,4), %ebx", &[0x67, 0x8B, 0x1C, 0x88]),
            (
                b"movl 8(%eax,%ecx,8), %ebx",
                &[0x67, 0x8B, 0x5C, 0xC8, 0x08],
            ),
            (b"movl 2(%r8d), %ebx", &[0x67, 0x41, 0x8B, 0x58, 0x02]),
            (b"movl (%r8d,%r9d,2), %ebx", &[0x67, 0x43, 0x8B, 0x1C, 0x48]),
            (b"movl 2(%esp), %ebx", &[0x67, 0x8B, 0x5C, 0x24, 0x02]),
            (b"movl 2(%ebp), %ebx", &[0x67, 0x8B, 0x5D, 0x02]),
            (b"movq 2(%eax), %rbx", &[0x67, 0x48, 0x8B, 0x58, 0x02]),
            (b"movw 2(%eax), %bx", &[0x67, 0x66, 0x8B, 0x58, 0x02]),
            (b"movb 2(%eax), %bl", &[0x67, 0x8A, 0x58, 0x02]),
            (b"leal 4(%eax), %ebx", &[0x67, 0x8D, 0x58, 0x04]),
            (b"addl $1, 2(%eax)", &[0x67, 0x83, 0x40, 0x02, 0x01]),
            (b"movl %ebx, 2(%eax)", &[0x67, 0x89, 0x58, 0x02]),
            (b"movl %gs:2(%eax), %ebx", &[0x65, 0x67, 0x8B, 0x58, 0x02]),
            // A 64-bit base is the mode default and takes no prefix.
            (b"movl 2(%rax), %ebx", &[0x8B, 0x58, 0x02]),
            (b"movl (%rax,%rcx,4), %ebx", &[0x8B, 0x1C, 0x88]),
        ];
        for (text, want) in gas {
            assert_eq!(
                asm_bytes(text),
                *want,
                "{}",
                core::str::from_utf8(text).unwrap()
            );
        }
    }
}

#[cfg(test)]
mod string_and_prefix_tests {
    use super::tests::asm_bytes;
    use super::*;

    /// The string primitives over every AT&T size suffix. The byte form is
    /// the bare opcode; the wider forms take `opcode + 1` under 0x66 (word)
    /// or REX.W (quad). Byte-verified against clang.
    #[test]
    fn string_primitives() {
        for (tmpl, want) in [
            ("movsb", &[0xA4][..]),
            ("movsw", &[0x66, 0xA5]),
            ("movsl", &[0xA5]),
            ("movsq", &[0x48, 0xA5]),
            ("cmpsb", &[0xA6]),
            ("cmpsw", &[0x66, 0xA7]),
            ("cmpsl", &[0xA7]),
            ("cmpsq", &[0x48, 0xA7]),
            ("stosb", &[0xAA]),
            ("stosw", &[0x66, 0xAB]),
            ("stosl", &[0xAB]),
            ("stosq", &[0x48, 0xAB]),
            ("lodsb", &[0xAC]),
            ("lodsw", &[0x66, 0xAD]),
            ("lodsl", &[0xAD]),
            ("lodsq", &[0x48, 0xAD]),
            ("scasb", &[0xAE]),
            ("scasw", &[0x66, 0xAF]),
            ("scasl", &[0xAF]),
            ("scasq", &[0x48, 0xAF]),
        ] {
            assert_eq!(asm_bytes(tmpl.as_bytes()), want, "{tmpl}");
        }
    }

    /// The string port-I/O primitives over their AT&T size suffixes, plain and
    /// under `rep`. Byte and dword are the bare opcode; the word form takes
    /// `opcode + 1` under 0x66. There is no 64-bit form (port width is at most
    /// 32 bits). Byte-verified against clang.
    #[test]
    fn string_io_primitives() {
        for (tmpl, want) in [
            ("insb", &[0x6C][..]),
            ("insw", &[0x66, 0x6D]),
            ("insl", &[0x6D]),
            ("outsb", &[0x6E]),
            ("outsw", &[0x66, 0x6F]),
            ("outsl", &[0x6F]),
            ("rep insb", &[0xF3, 0x6C]),
            ("rep insw", &[0xF3, 0x66, 0x6D]),
            ("rep insl", &[0xF3, 0x6D]),
            ("rep outsb", &[0xF3, 0x6E]),
            ("rep outsw", &[0xF3, 0x66, 0x6F]),
            ("rep outsl", &[0xF3, 0x6F]),
        ] {
            assert_eq!(asm_bytes(tmpl.as_bytes()), want, "{tmpl}");
        }
        assert_eq!(split_mnemonic("insq"), None);
        assert_eq!(split_mnemonic("outsq"), None);
    }

    /// A prefix stands alone as a statement or leads its instruction on the
    /// same statement; either way the prefix byte comes first, before the
    /// operand-size prefix the instruction emits. Byte-verified against
    /// clang (`rep stosw` is `f3 66 ab`, not `66 f3 ab`).
    #[test]
    fn prefixes_compose_with_the_next_instruction() {
        assert_eq!(asm_bytes(b"repe; cmpsb"), [0xF3, 0xA6]);
        assert_eq!(asm_bytes(b"repe cmpsb"), [0xF3, 0xA6]);
        assert_eq!(asm_bytes(b"rep; stosl"), [0xF3, 0xAB]);
        assert_eq!(asm_bytes(b"rep stosw"), [0xF3, 0x66, 0xAB]);
        assert_eq!(asm_bytes(b"repz cmpsb"), [0xF3, 0xA6]);
        assert_eq!(asm_bytes(b"repne scasb"), [0xF2, 0xAE]);
        assert_eq!(asm_bytes(b"repnz scasb"), [0xF2, 0xAE]);
        assert_eq!(asm_bytes(b"rep movsq"), [0xF3, 0x48, 0xA5]);
        // `lock` is the same mechanism and keeps its standalone form.
        assert_eq!(asm_bytes(b"lock; stosb"), [0xF0, 0xAA]);
    }

    /// `fninit` and the x87 / far-call memory forms. Byte-verified against
    /// clang.
    #[test]
    fn fninit_and_memory_extension_forms() {
        assert_eq!(asm_bytes(b"fninit"), [0xDB, 0xE3]);
        assert_eq!(asm_bytes(b"fnstsw (%rax)"), [0xDD, 0x38]);
        assert_eq!(asm_bytes(b"fnstcw (%rax)"), [0xD9, 0x38]);
        assert_eq!(asm_bytes(b"fnstsw 8(%rbx)"), [0xDD, 0x7B, 0x08]);
        assert_eq!(asm_bytes(b"lcallw *(%rax)"), [0x66, 0xFF, 0x18]);
        assert_eq!(asm_bytes(b"lcallw *8(%rbx)"), [0x66, 0xFF, 0x5B, 0x08]);
        assert_eq!(asm_bytes(b"lcall *(%rax)"), [0xFF, 0x18]);
        assert_eq!(asm_bytes(b"lcalll *(%rax)"), [0xFF, 0x18]);
        // The `q` spelling is LLVM's, which its disassembler also prints;
        // GNU as has no far-branch `q` suffix and writes the same encoding
        // `rex.W lcall`. Both are accepted.
        assert_eq!(asm_bytes(b"lcallq *(%rax)"), [0x48, 0xFF, 0x18]);
        assert_eq!(asm_bytes(b"rex.W lcall *(%rax)"), [0x48, 0xFF, 0x18]);
        // x87 load / store-and-pop of a 64-bit float (DD /0, DD /3).
        assert_eq!(asm_bytes(b"fldl (%rax)"), [0xDD, 0x00]);
        assert_eq!(asm_bytes(b"fldl 8(%rbx)"), [0xDD, 0x43, 0x08]);
        assert_eq!(asm_bytes(b"fldl (%r14)"), [0x41, 0xDD, 0x06]);
        assert_eq!(asm_bytes(b"fstpl (%rax)"), [0xDD, 0x18]);
        assert_eq!(asm_bytes(b"fstpl 8(%rbx)"), [0xDD, 0x5B, 0x08]);
        assert_eq!(asm_bytes(b"fstpl (%r14)"), [0x41, 0xDD, 0x1E]);
        // Far indirect jump (FF /5); the AT&T suffix sets the operand size.
        // `ljmpq` is LLVM's spelling of the 64-bit offset form, kept beside
        // GNU as's `rex.W ljmp`.
        assert_eq!(asm_bytes(b"ljmpl *(%rax)"), [0xFF, 0x28]);
        assert_eq!(asm_bytes(b"ljmpq *(%rax)"), [0x48, 0xFF, 0x28]);
        assert_eq!(asm_bytes(b"rex.W ljmp *(%rax)"), [0x48, 0xFF, 0x28]);
        assert_eq!(asm_bytes(b"ljmpl *(%r13)"), [0x41, 0xFF, 0x6D, 0x00]);
        assert_eq!(asm_bytes(b"ljmpw *(%rax)"), [0x66, 0xFF, 0x28]);
    }

    /// The `rex[.WRXB]` prefix. Leading an instruction on one statement its
    /// bits merge into that instruction's own REX byte; a statement of its
    /// own deposits the byte and the next instruction encodes independently.
    /// The letters name the bits in W, R, X, B order. Bytes measured with
    /// GNU as 2.46.1.
    #[test]
    fn rex_prefix_forms_match_gnu_as() {
        assert_eq!(asm_bytes(b"rex.W ljmp *(%rax)"), [0x48, 0xFF, 0x28]);
        // The prefix's B joins the instruction's own REX, so one byte
        // carries both and the operand register is extended.
        assert_eq!(asm_bytes(b"rex.WB ljmp *(%rax)"), [0x49, 0xFF, 0x28]);
        assert_eq!(asm_bytes(b"rex.W ljmp *(%r13)"), [0x49, 0xFF, 0x6D, 0x00]);
        assert_eq!(asm_bytes(b"rex ljmp *(%rax)"), [0x40, 0xFF, 0x28]);
        assert_eq!(asm_bytes(b"rex.R ljmp *(%rax)"), [0x44, 0xFF, 0x28]);
        assert_eq!(asm_bytes(b"rex.W nop"), [0x48, 0x90]);
        assert_eq!(asm_bytes(b"rex.wb nop"), [0x49, 0x90]);
        // Standalone, and so unmerged: the `ljmp` keeps its own REX.B.
        assert_eq!(
            asm_bytes(b"rex.W; ljmp *(%r13)"),
            [0x48, 0x41, 0xFF, 0x6D, 0x00]
        );
        // The prefix rides behind the mandatory and size prefixes, where the
        // instruction's own REX sits.
        assert_eq!(
            asm_bytes(b"rex.B movsd (%rax), %xmm0"),
            [0xF2, 0x41, 0x0F, 0x10, 0x00]
        );
        // Letters out of order name no prefix.
        assert!(split_mnemonic("rex.BW").is_none());
        assert!(split_mnemonic("rex.WW").is_none());
        assert!(split_mnemonic("rex.").is_none());
    }

    /// System / SSE-control / invalidation memory forms on the 0F and 0F38
    /// maps. Byte-verified against clang.
    #[test]
    fn system_memory_extension_forms() {
        // 128-bit compare-and-exchange (REX.W 0F C7 /1), bare and lock-prefixed.
        assert_eq!(asm_bytes(b"cmpxchg16b (%rax)"), [0x48, 0x0F, 0xC7, 0x08]);
        assert_eq!(
            asm_bytes(b"cmpxchg16b (%r12)"),
            [0x49, 0x0F, 0xC7, 0x0C, 0x24]
        );
        assert_eq!(
            asm_bytes(b"cmpxchg16b 8(%rbx)"),
            [0x48, 0x0F, 0xC7, 0x4B, 0x08]
        );
        assert_eq!(
            asm_bytes(b"lock; cmpxchg16b (%rax)"),
            [0xF0, 0x48, 0x0F, 0xC7, 0x08]
        );
        // SSE control/status register load / store (0F AE /2, /3).
        assert_eq!(asm_bytes(b"ldmxcsr (%rax)"), [0x0F, 0xAE, 0x10]);
        assert_eq!(asm_bytes(b"ldmxcsr (%r13)"), [0x41, 0x0F, 0xAE, 0x55, 0x00]);
        assert_eq!(asm_bytes(b"stmxcsr (%rax)"), [0x0F, 0xAE, 0x18]);
        assert_eq!(
            asm_bytes(b"stmxcsr 128(%rdx)"),
            [0x0F, 0xAE, 0x9A, 0x80, 0x00, 0x00, 0x00]
        );
        // PCID / VPID invalidation reading a 128-bit descriptor (66 0F 38 82 /
        // 81 /r): the register in ModR/M.reg, the descriptor the r/m.
        assert_eq!(
            asm_bytes(b"invpcid (%rax), %rbx"),
            [0x66, 0x0F, 0x38, 0x82, 0x18]
        );
        assert_eq!(
            asm_bytes(b"invpcid (%r10), %r11"),
            [0x66, 0x45, 0x0F, 0x38, 0x82, 0x1A]
        );
        assert_eq!(
            asm_bytes(b"invpcid 16(%rbp), %rsi"),
            [0x66, 0x0F, 0x38, 0x82, 0x75, 0x10]
        );
        assert_eq!(
            asm_bytes(b"invvpid (%rax), %rbx"),
            [0x66, 0x0F, 0x38, 0x81, 0x18]
        );
        assert_eq!(
            asm_bytes(b"invvpid (%r10), %r11"),
            [0x66, 0x45, 0x0F, 0x38, 0x81, 0x1A]
        );
    }

    /// Segment-register push / pop. Only FS/GS have a 64-bit-mode encoding
    /// (0F A0 / A1, 0F A8 / A9); a `w` suffix adds the 0x66 operand-size
    /// prefix. Byte-verified against clang. The ES/CS/SS/DS forms are invalid
    /// in 64-bit mode, so the assembler rejects them and so does this.
    #[test]
    fn segment_register_push_pop() {
        assert_eq!(asm_bytes(b"push %fs"), [0x0F, 0xA0]);
        assert_eq!(asm_bytes(b"pop %fs"), [0x0F, 0xA1]);
        assert_eq!(asm_bytes(b"push %gs"), [0x0F, 0xA8]);
        assert_eq!(asm_bytes(b"pop %gs"), [0x0F, 0xA9]);
        assert_eq!(asm_bytes(b"pushw %fs"), [0x66, 0x0F, 0xA0]);
        assert_eq!(asm_bytes(b"popw %fs"), [0x66, 0x0F, 0xA1]);
        assert_eq!(asm_bytes(b"pushw %gs"), [0x66, 0x0F, 0xA8]);
        assert_eq!(asm_bytes(b"popw %gs"), [0x66, 0x0F, 0xA9]);
        // A `q` suffix is the 64-bit default: no operand-size prefix.
        assert_eq!(asm_bytes(b"pushq %fs"), [0x0F, 0xA0]);
        // ES(0) / CS(1) / SS(2) / DS(3) have no 64-bit push / pop encoding.
        let rejects = |tok: &str, sreg: u8| {
            let (m, sfx) = split_mnemonic(tok).unwrap();
            let mut c = Vec::new();
            encode(
                &mut c,
                8,
                m,
                sfx,
                &[Concrete::Reg {
                    reg: SEG_BASE + sreg,
                    size: AsmRegSize::Word,
                }],
            )
            .is_err()
        };
        assert!(rejects("pushw", 0));
        assert!(rejects("popw", 3));
        assert!(rejects("push", 2));
        assert!(rejects("pop", 1));
    }

    /// A string primitive names its own size, so a further AT&T suffix does
    /// not apply: `movsbl` is a sign-extending move rather than `movsb`
    /// widened to long.
    #[test]
    fn string_primitive_takes_no_further_suffix() {
        assert!(matches!(
            split_mnemonic("movsb"),
            Some((Mnemonic::StringOp { .. }, None))
        ));
        assert!(matches!(
            split_mnemonic("movsbl"),
            Some((Mnemonic::ExtMov { name: "movsx", .. }, _))
        ));
        assert!(matches!(
            split_mnemonic("movswl"),
            Some((Mnemonic::ExtMov { name: "movsx", .. }, _))
        ));
    }

    /// The FDIV-bug probe's x87 sequence, byte-exact vs GNU as.
    #[test]
    fn x87_fdiv_bug_probe_forms() {
        assert_eq!(asm_bytes(b"fmull (%%rax)"), [0xDC, 0x08]);
        assert_eq!(asm_bytes(b"fistpl (%%rax)"), [0xDB, 0x18]);
        assert_eq!(asm_bytes(b"fistpl 4(%%rbx)"), [0xDB, 0x5B, 0x04]);
        assert_eq!(asm_bytes(b"fsubp %%st,%%st(1)"), [0xDE, 0xE1]);
        assert_eq!(asm_bytes(b"fsubp"), [0xDE, 0xE1]);
        assert_eq!(asm_bytes(b"fildl (%%rax)"), [0xDB, 0x00]);
        assert_eq!(asm_bytes(b"emms"), [0x0F, 0x77]);
    }

    /// AT&T extending moves, byte-exact vs GNU as.
    #[test]
    fn extending_move_forms() {
        assert_eq!(
            asm_bytes(b"movzbl (%%rdi,%%rax), %%ecx"),
            [0x0F, 0xB6, 0x0C, 0x07]
        );
        assert_eq!(asm_bytes(b"movzbl (%%rdi), %%eax"), [0x0F, 0xB6, 0x07]);
        assert_eq!(asm_bytes(b"movsbl %%al, %%edx"), [0x0F, 0xBE, 0xD0]);
        assert_eq!(
            asm_bytes(b"movzwl 2(%%rsi), %%eax"),
            [0x0F, 0xB7, 0x46, 0x02]
        );
        assert_eq!(asm_bytes(b"movslq %%ecx, %%rax"), [0x48, 0x63, 0xC1]);
        assert_eq!(asm_bytes(b"movzbq %%dl, %%r9"), [0x4C, 0x0F, 0xB6, 0xCA]);
        assert_eq!(asm_bytes(b"movswq %%ax, %%rbx"), [0x48, 0x0F, 0xBF, 0xD8]);
    }

    /// The template shapes the sweep reported, end to end.
    #[test]
    fn reported_template_shapes() {
        assert_eq!(asm_bytes(b"repe; cmpsb"), [0xF3, 0xA6]);
        assert_eq!(
            asm_bytes(b"fninit ; fnstsw (%rax) ; fnstcw (%rbx)"),
            [0xDB, 0xE3, 0xDD, 0x38, 0xD9, 0x3B]
        );
        assert_eq!(asm_bytes(b"stosw \n\t rep;stosl"), [0x66, 0xAB, 0xF3, 0xAB]);
    }

    #[test]
    fn skip_directive_carries_count_and_fill() {
        // `.skip count, fill` parses to a `Skip` mnemonic; the count expression
        // is kept verbatim (its labels resolve at emit time) and the fill byte
        // is separated out. A missing fill defaults to zero.
        let insns = parse_template(
            b".skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90",
        )
        .unwrap();
        assert_eq!(insns.len(), 1);
        assert!(matches!(insns[0].mnemonic, Mnemonic::Skip));
        assert_eq!(insns[0].bytes, [0x90]);
        assert_eq!(
            insns[0].sym_exprs,
            ["-(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b))"]
        );
        let plain = parse_template(b".skip 8").unwrap();
        assert!(matches!(plain[0].mnemonic, Mnemonic::Skip));
        assert_eq!(plain[0].bytes, [0]);
        assert_eq!(plain[0].sym_exprs, ["8"]);
    }
}
