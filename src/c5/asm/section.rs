//! The section data model: the items a parsed directive produces, the
//! sections and symbols they accumulate into, the relocation and branch
//! records a section carries, and the field patching that writes a
//! resolved value back into an encoded instruction.

use super::*;
use crate::c5::codegen::map_syms::{MapClass, MapMarks};
use crate::c5::codegen::ssa::cfi;

// ------------------------------------------------------------------
// In-template assembler sections: `.pushsection` / `.section` data
// directives accumulated into named sections of the emitted object.
// Shared by both arch template parsers; the emitter resolves operand
// and label references and appends the finished [`AsmSection`]s to the
// build's section sink.
// ------------------------------------------------------------------

/// One value of a section data directive.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSectionValue {
    /// Held at 128 bits so `.octa` carries its full field.
    Const(i128),
    /// `%N` / `%cN` / `%c[name]` (canonicalized): the operand's
    /// compile-time constant.
    OperandConst(u8),
    /// A template label (`1b`, `name`) or a symbol, optionally PC-relative
    /// (`ref - .`) and carrying a constant addend (`func - (. + 4)`, a
    /// static-call trampoline's `jmp.d32`; `1b - %c2 - .`, the user-pointer
    /// bound). The emitter resolves a template label to a text offset; an
    /// unknown name is a symbol reference. `addend` is a constant expression
    /// (literals and `%cN` operand constants) evaluated at materialize time,
    /// empty when absent.
    Ref {
        name: alloc::string::String,
        pcrel: bool,
        addend: alloc::string::String,
    },
    /// `label_a - label_b`: the byte distance between two template-label
    /// definitions. Both resolve to text offsets at materialize time, so the
    /// difference is a compile-time constant stored in the field. Either
    /// label may be a forward or a backward reference.
    LabelDiff {
        minuend: alloc::string::String,
        subtrahend: alloc::string::String,
    },
    /// A constant expression mixing integer literals with `%N` operand
    /// constants (`(1 << 15) | (%0)`). Stored as text and evaluated at
    /// materialize time, where the operand constants are known.
    Expr(alloc::string::String),
    /// A general expression over locations -- labels, the location counter
    /// `.`, and constants under the full operator set (`(end - .) / 8`).
    /// Evaluated at materialize time under GNU as value rules: a same-space
    /// difference folds, a lone location or symbol relocates, a base minus a
    /// location of the deposit space is PC-relative.
    LocExpr(alloc::string::String),
    /// A relocation whose base is an `i`-class operand naming a link-time
    /// address (`%cN`) or an `asm goto` label (`%lN`), optionally with a
    /// constant addend and `- .` PC-relative. `%c0 + %c1 - .` (a static-key
    /// jump entry) folds `%c1` into the addend; `.long %c0 - .` (the bug
    /// table's file pointer) has no addend.
    OperandReloc {
        idx: u8,
        /// `%l` (an `asm goto` label) rather than `%c` (an operand address).
        goto: bool,
        /// Constant addend expression (operand constants + literals), empty
        /// when absent.
        addend: alloc::string::String,
        pcrel: bool,
    },
}

/// One item of an in-template section block, in source order.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSectionItem {
    /// A `.byte`-family directive: element width plus its values.
    Data {
        width: u8,
        values: alloc::vec::Vec<AsmSectionValue>,
    },
    /// An alignment directive. `spec` is the byte alignment, or the
    /// expression the layout resolves one from. `fill` is an explicit fill
    /// unit; `None` selects the default (the target NOP in an executable
    /// section, zero otherwise). `max` is the GNU as maximum skip: the
    /// alignment is dropped when it would need more than `max` bytes.
    Align {
        spec: AlignSpec,
        fill: Option<AlignFill>,
        max: Option<u32>,
    },
    /// `.org n[, fill]`: pad to section offset `n` with `fill`, zero by
    /// default.
    Org(u32, u8),
    /// `.org label + expr[, fill]`: pad to a section-local label's offset plus
    /// a constant expression (`.org 2b + %c3`, the `__bug_table` entry size).
    /// The label and expression resolve at materialize time.
    OrgLabel {
        label: alloc::string::String,
        addend: alloc::string::String,
        fill: u8,
    },
    /// `.org expr[, fill]` over locations (`.org . - (664b-663b) +
    /// (662b-661b)`, the alternatives length equalizer): the target offset is
    /// the expression's value, an absolute or a location of this section.
    OrgExpr(alloc::string::String, u8),
    /// `.rept count` whose count reads section labels, deferred past macro
    /// expansion; the body repeats `count` times at layout.
    Rept {
        count: alloc::string::String,
        items: alloc::vec::Vec<AsmSectionItem>,
    },
    /// `.skip` / `.space` / `.zero` / `.fill`: `count` repetitions of the low
    /// `unit` bytes of `value`. `.skip n, f` and `.space n, f` repeat the fill
    /// byte, `.zero n` fixes the value at zero, `.fill r, s, v` gives all
    /// three. GNU as renders the value as the low bytes of a zero-extended
    /// 32-bit number, so a unit above four pads with zeros. `count` is an
    /// expression resolved at materialize time.
    Fill {
        count: alloc::string::String,
        unit: u8,
        value: u32,
    },
    /// `.ascii` / `.asciz` / `.string` payload (NUL included when the
    /// directive appends one).
    Bytes(alloc::vec::Vec<u8>),
    /// `name:`: a label defining a symbol at the current section offset.
    Label(alloc::string::String),
    /// `.globl name` / `.global name`: give the named label external
    /// binding. May precede or follow the label's definition.
    Global(alloc::string::String),
    /// `.file "name"`: the unit's STT_FILE symbol name. The numbered
    /// DWARF form (`.file N "name"`) is line-table input and stays
    /// ignored, as it sets no symbol in GNU as either.
    File(alloc::string::String),
    /// `.ident "text"`: one `.comment` string.
    Ident(alloc::string::String),
    /// `.local name`: force local binding. A section label is local by
    /// default, so this only cancels a `.globl` on the same name.
    Local(alloc::string::String),
    /// `.hidden` / `.internal` / `.protected name`: the `st_other` visibility.
    /// Visibility is a unit-level property of the name, independent of which
    /// section defines it.
    Visibility {
        name: alloc::string::String,
        vis: crate::c5::program::SymVisibility,
    },
    /// `.type name, @function|@object`: set the named label's ELF symbol
    /// type. The label must be defined in this section.
    Type {
        name: alloc::string::String,
        sym_type: AsmSymType,
    },
    /// `.size name, expr`: set the named label's `st_size`. `expr` is a
    /// byte count -- a constant or a difference `. - name` whose terms are
    /// the current section offset (`.`) or a section label, evaluated at
    /// materialize time.
    Size {
        name: alloc::string::String,
        expr: alloc::string::String,
    },
    /// A single instruction line inside an executable (`"ax"`) section, as
    /// source text -- the x86 ALTERNATIVE replacement (`call %c[new]`) that
    /// lands in `.altinstr_replacement`. The arch backend encodes it to
    /// `CodeBytes` before layout (`encode_x86_asm_section_code`); one still
    /// text at layout is a target that does not assemble replacement code.
    Code(alloc::string::String),
    /// A replacement instruction encoded to machine bytes, with its
    /// relocations at offsets within those bytes (the layout rebases them by
    /// the item's section offset). Produced from `Code` by the arch backend.
    /// `short` is a narrower encoding of the same branch, taken when the
    /// layout finds the target in this section within the short field's
    /// reach.
    CodeBytes {
        bytes: alloc::vec::Vec<u8>,
        relocs: alloc::vec::Vec<AsmSectionReloc>,
        short: Option<AsmShortBranch>,
    },
    /// `.weak name`: weak symbol binding. The materializer marks a label
    /// defined in this statement's sections; a name defined elsewhere in the
    /// unit (or nowhere) is returned to the caller as a unit-level weak name.
    Weak(alloc::string::String),
    /// `.set name, sym` / `.equ name, sym`: `name` aliases the symbol `sym`.
    /// Constant assignments are consumed by the macro expander; only the
    /// symbol-valued form reaches the section parser. Returned to the caller;
    /// the object writer emits the alias at the target's definition.
    SymSet {
        name: alloc::string::String,
        target: alloc::string::String,
    },
    /// `.set name, expr` whose value is an expression over section-local
    /// locations (`.set .Lsz, . - f`) rather than a constant or a plain
    /// symbol. `name` takes the expression's value at the assignment, and
    /// expressions materialized afterwards resolve the name to it.
    SetExpr {
        name: alloc::string::String,
        expr: alloc::string::String,
    },
    /// `.set name, <constant>`, which GNU as records as an absolute symbol.
    /// The expander folds a constant assignment into the expressions that
    /// read it and re-emits the statement only for a name the unit gave
    /// external linkage, which is where the symbol is what a reader needs.
    AbsSet {
        name: alloc::string::String,
        value: i64,
    },
    /// An AArch64 literal pool: the values the `ldr Rt, =value` loads since
    /// the previous flush deposit here. Parsed from `.ltorg` with no entries;
    /// the arch backend assigns them before layout, and also appends one at
    /// the end of each section, which is where GNU as flushes what `.ltorg`
    /// did not.
    LiteralPool(alloc::vec::Vec<AsmPoolEntry>),
    /// A `.if` whose condition reads section labels and whose branches emit
    /// no bytes, so the layout that values the condition cannot depend on the
    /// outcome. Evaluated after layout; the first arm whose condition holds
    /// raises its `.error`.
    CondDiag(alloc::vec::Vec<AsmCondArm>),
    /// A `.cfi_*` directive. It deposits no bytes; the section offset it
    /// reaches is the point its unwind rule takes effect from, so the
    /// materializer records the pair and the frame tables are built from the
    /// unit's whole stream.
    Cfi(cfi::CfiOp),
    /// `.reloc offset, TYPE, sym + addend`: a relocation of a named ELF type
    /// at a section-relative offset, deposited without a field of its own.
    Reloc {
        offset: u32,
        rtype: u32,
        target: alloc::string::String,
        addend: i64,
    },
}

/// One branch of a deferred conditional. `tok` is the `.if`-family directive
/// that opened the branch, empty for `.else`; `error` is the diagnostic the
/// branch raises, absent when it raises none.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmCondArm {
    pub tok: alloc::string::String,
    pub cond: alloc::string::String,
    pub error: Option<alloc::string::String>,
}

/// One AArch64 literal-pool entry. `label` is the synthetic symbol the
/// loads' 19-bit displacements resolve against; several loads share an
/// entry when they request the same width and value.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmPoolEntry {
    /// Entry width in bytes: 4, 8, or 16.
    pub size: u8,
    pub label: alloc::string::String,
    pub value: AsmPoolValue,
}

/// A literal-pool entry's value: a constant truncated to the entry width, or
/// a link-time address the entry relocates to.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmPoolValue {
    Const(i128),
    Sym {
        name: alloc::string::String,
        addend: i64,
    },
}

/// Offsets a literal pool's entries take when flushed at `at`, and the
/// offset just past the pool. GNU as deposits the entries in width-ascending
/// groups, keeps first-reference order within a group, and aligns each group
/// to its own width.
pub(crate) fn literal_pool_layout(
    entries: &[AsmPoolEntry],
    at: i64,
) -> (alloc::vec::Vec<i64>, i64) {
    let mut offs = alloc::vec![0i64; entries.len()];
    let mut at = at;
    for size in [4u8, 8, 16] {
        for i in (0..entries.len()).filter(|&i| entries[i].size == size) {
            at += align_gap(at, size as i64, None);
            offs[i] = at;
            at += size as i64;
        }
    }
    (offs, at)
}

/// A parsed `.pushsection` / `.section` block of a template.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSectionBlock {
    pub name: alloc::string::String,
    /// Flag letters from the `"flags"` argument (`a`, `w`, `x`, ...).
    pub flags: alloc::string::String,
    /// `@type` / `%type` argument (`progbits`, `nobits`, ...), if any.
    pub sh_type: Option<alloc::string::String>,
    /// `.subsection` number. Subsections share the section's identity and
    /// space; layout orders a section's blocks by this number, so
    /// subsection 1 lands after every subsection-0 block.
    pub subsection: u32,
    pub items: alloc::vec::Vec<AsmSectionItem>,
}

/// Instruction-field flavor of a section relocation. `Data` is a plain
/// data field described by `pcrel` / `branch` / `signed`; the AArch64
/// kinds name the instruction field the value patches. The PC-relative
/// kinds resolve at materialize time when the target is a local label of
/// the same section (GNU as emits no relocation there; a global or weak
/// name may bind to another definition at link time, so a reference to
/// one keeps its relocation); the page/lo12 kinds always reach the
/// object writer.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum AsmRelocKind {
    #[default]
    Data,
    /// 26-bit branch (`b` / `bl`); `link` selects CALL26 over JUMP26.
    A64Branch26 { link: bool },
    /// 19-bit conditional branch (`b.cond`, `cbz`, `cbnz`).
    A64Condbr19,
    /// 14-bit test-bit branch (`tbz`, `tbnz`).
    A64Tstbr14,
    /// `adr` 21-bit byte displacement.
    A64Adr21,
    /// `adrp` 21-bit page displacement.
    A64AdrpPage21,
    /// `add Rd, Rn, :lo12:sym` low-12 absolute immediate.
    A64AddLo12,
    /// Load/store `:lo12:` scaled immediate; the access size in bytes.
    A64LdstLo12(u8),
    /// `ldr Rt, label` 19-bit literal load displacement.
    A64LdrLit19,
    /// `movz` / `movk` with `:abs_gN[_s|_nc]:` -- one 16-bit group of an
    /// absolute value. `check` is the value width GNU as admits when the
    /// expression folds here; the link applies the ABI's own, which is
    /// wider for the signed forms.
    A64MovwAbs {
        group: u8,
        signed: bool,
        check: Option<u32>,
    },
    /// A relaxable x86 jump displacement (`jmp` / `jcc`). GNU as computes it
    /// while relaxing the branch, which resolves any same-section target
    /// whatever its binding; only a weak one, which the link may rebind,
    /// keeps the long form and its relocation. `call` is not relaxable and
    /// takes `Data`, where a global target does keep its relocation.
    JumpRel,
    /// `.reloc`: the ELF relocation type is named in the source, and the
    /// section deposits no field for it.
    Explicit(u32),
}

impl AsmRelocKind {
    /// Whether the field's value is measured from the field's own address. A
    /// data field carries that on the relocation's `pcrel` flag; an
    /// instruction field carries it in the kind, the page and low-12 forms
    /// being the ones that resolve against a link-time address instead.
    pub(crate) fn self_relative(self) -> bool {
        matches!(
            self,
            AsmRelocKind::A64Branch26 { .. }
                | AsmRelocKind::A64Condbr19
                | AsmRelocKind::A64Tstbr14
                | AsmRelocKind::A64Adr21
                | AsmRelocKind::A64LdrLit19
        )
    }
}

/// A relocation of a materialized section against the object.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSectionReloc {
    /// Byte offset of the field within the section. For an AArch64
    /// instruction kind, the offset of the instruction word.
    pub offset: u32,
    /// Field width in bytes (4 or 8).
    pub width: u8,
    /// Instruction-field flavor; `Data` for a data directive's field.
    pub kind: AsmRelocKind,
    /// PC-relative (`ref - .`) rather than absolute.
    pub pcrel: bool,
    /// A branch reloc reaching its symbol through the PLT slot
    /// (`R_X86_64_PLT32`) rather than a plain PC-relative data reference
    /// (`R_X86_64_PC32`). Set for a replacement instruction's direct
    /// `call` / `jmp` to a symbol; a data reference leaves it clear.
    pub branch: bool,
    /// A sign-extended absolute 32-bit field (`R_X86_64_32S`) rather than the
    /// zero-extended `R_X86_64_32` a data directive takes. Set for a `push
    /// $symbol` immediate, whose imm32 the CPU sign-extends. Only meaningful
    /// for an absolute 4-byte x86_64 field.
    pub signed: bool,
    pub target: AsmSectionTarget,
    pub addend: i64,
}

/// A direct branch's short encoding, supplied by the arch encoder next to
/// the long one. The two differ only in the displacement field's width, so
/// a single relocation describes the short form; the layout selects it when
/// the target is a label of the branch's own section within the narrow
/// field's reach. GNU as makes the same choice by the same rule; a
/// non-branch field's width is settled earlier, when the instruction is
/// parsed ([`AsmParseFold`]).
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmShortBranch {
    pub bytes: alloc::vec::Vec<u8>,
    pub reloc: AsmSectionReloc,
}

/// Relocation target of a section field.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSectionTarget {
    /// A byte offset into the emitted text (a resolved template label).
    Text(usize),
    /// A named symbol.
    Symbol(alloc::string::String),
    /// An expression over symbols and labels written in an instruction
    /// operand (`$(sym - base)`, `(sym - 1b)(%ecx)`). Evaluated where the
    /// section materializes and the layout is known: a result with no
    /// symbolic term left is folded into the field, one with a symbol
    /// becomes a relocation against it. It never reaches the object writer.
    Expr(alloc::string::String),
    /// A byte offset into the emitted data image (an `i`-class operand
    /// naming a link-time address, `.long %c0 - .`). Resolved against the
    /// `.data` / `.bss` section symbol like a `DataFixup`.
    Data(u64),
    /// An `asm goto` label's block (`.long %l0 - .`, a static-key jump
    /// entry). The block's text offset is not known when the section
    /// materializes -- the walker leaves `start_pc` at 0 and the block is
    /// laid out later -- so the block index is carried here and rewritten to
    /// [`Self::Text`] once the function's `block_offsets` are final. It never
    /// reaches the object writer.
    TextBlock(u32),
    /// A label in a deferred replacement region (the AArch64 ALTERNATIVE
    /// `.subsection`), appended to `.text` after the enclosing function body.
    /// The region's final text base is not known when the section
    /// materializes, so the region index and the label's byte offset within
    /// the region are carried here and rewritten to [`Self::Text`] once the
    /// region is placed (see [`resolve_asm_deferred_relocs`]). It never
    /// reaches the object writer.
    DeferredText { region: u32, off: u32 },
    /// A byte offset within the section the relocation itself lives in
    /// (`.quad .`): the writer resolves it against that section's own
    /// symbol.
    OwnSection(u32),
    /// The start of a named section, by its identity key: a bare section
    /// name used as a symbol. The writer resolves it against that
    /// section's own symbol.
    SectionStart(alloc::string::String),
}

/// Where a template label a section field references is defined. `label_off`
/// returns this so a `.word 663f - .` in the AArch64 ALTERNATIVE
/// `.altinstructions` entry relocates against the replacement's eventual
/// text offset rather than an emitted-stream offset.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum LabelLoc {
    /// Final byte offset in the emitted text (the main instruction stream).
    Text(usize),
    /// A label in a deferred replacement region: region index plus the
    /// label's byte offset within it.
    Deferred { region: u32, off: usize },
}

/// The address space a location-valued expression term lives in; two terms
/// fold to a constant difference only when they share one. Distinguishes the
/// emitted text stream, a deferred replacement region, and a named section.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSpace {
    Text,
    Deferred(u32),
    /// A named section, by its `(name, flags, sh_type)` key.
    Section(alloc::string::String),
    /// A run of parse-time fixed-size items, numbered by [`AsmParseFold`].
    /// Two labels of one run are a constant apart in every layout.
    Frag(u32),
}

/// Patch a PC-relative instruction field whose target resolved within the
/// section, so no relocation is emitted (as GNU as resolves same-section
/// fixups). `disp` is target plus addend minus the field's own offset.
/// Returns `false` for a kind that must keep its relocation: an absolute
/// data field, and the page / lo12 forms whose value is a link-time
/// address.
pub(crate) fn patch_asm_insn_field(
    buf: &mut [u8],
    at: usize,
    kind: AsmRelocKind,
    pcrel: bool,
    width: u8,
    disp: i64,
) -> Result<bool, alloc::string::String> {
    let words = |bits: u32| -> Result<u32, alloc::string::String> {
        if disp % 4 != 0 {
            return Err(alloc::string::String::from(
                "inline asm: branch target is not word-aligned",
            ));
        }
        let w = disp / 4;
        let lim = 1i64 << (bits - 1);
        if !(-lim..lim).contains(&w) {
            return Err(alloc::string::String::from(
                "inline asm: branch target out of range",
            ));
        }
        Ok((w as u32) & ((1u32 << bits) - 1))
    };
    let or_word = |buf: &mut [u8], v: u32| {
        let w = u32::from_le_bytes(buf[at..at + 4].try_into().expect("4-byte field")) | v;
        buf[at..at + 4].copy_from_slice(&w.to_le_bytes());
    };
    match kind {
        // A same-section PC-relative reference resolves here, at whatever
        // width the field is: 2 bytes for a `.code16` near branch, 1 for a
        // short one. Leaving it to a relocation would work but would put
        // one in the object for a distance the assembler already knows.
        AsmRelocKind::Data | AsmRelocKind::JumpRel if pcrel && matches!(width, 1 | 2 | 4) => {
            let w = width as usize;
            let lim = 1i64 << (8 * w - 1);
            if !(-lim..lim).contains(&disp) {
                return Err(alloc::string::String::from(
                    "inline asm: PC-relative field out of range",
                ));
            }
            buf[at..at + w].copy_from_slice(&disp.to_le_bytes()[..w]);
            Ok(true)
        }
        AsmRelocKind::Data | AsmRelocKind::JumpRel => Ok(false),
        AsmRelocKind::A64Branch26 { .. } => {
            or_word(buf, words(26)?);
            Ok(true)
        }
        AsmRelocKind::A64Condbr19 | AsmRelocKind::A64LdrLit19 => {
            or_word(buf, words(19)? << 5);
            Ok(true)
        }
        AsmRelocKind::A64Tstbr14 => {
            or_word(buf, words(14)? << 5);
            Ok(true)
        }
        AsmRelocKind::A64Adr21 => {
            if !(-(1i64 << 20)..(1i64 << 20)).contains(&disp) {
                return Err(alloc::string::String::from(
                    "inline asm: `adr` target out of range",
                ));
            }
            let d = disp as u32;
            or_word(buf, ((d & 3) << 29) | (((d >> 2) & 0x7_FFFF) << 5));
            Ok(true)
        }
        // `.reloc` names no field, so there is nothing to patch and the
        // relocation always reaches the object writer.
        AsmRelocKind::A64AdrpPage21
        | AsmRelocKind::A64AddLo12
        | AsmRelocKind::A64LdstLo12(_)
        | AsmRelocKind::A64MovwAbs { .. }
        | AsmRelocKind::Explicit(_) => Ok(false),
    }
}

/// Store the constant an operand expression folded to into its field, the
/// relocation the field would otherwise have taken standing for its width
/// and flavor. A `Data` field takes the value little-endian at its own
/// width; an instruction-field kind takes the same encoding a PC-relative
/// patch writes, the field being the same one. A kind whose value is a
/// link-time address has no constant form and is rejected rather than
/// encoded wrong.
pub(crate) fn store_asm_insn_const(
    buf: &mut [u8],
    at: usize,
    r: &AsmSectionReloc,
    v: i64,
) -> Result<(), alloc::string::String> {
    if r.kind == AsmRelocKind::Data {
        if !value_fits_width(v, r.width) {
            return Err(alloc::format!(
                "value {v} does not fit a {}-byte field",
                r.width
            ));
        }
        let w = r.width as usize;
        buf[at..at + w].copy_from_slice(&v.to_le_bytes()[..w]);
        return Ok(());
    }
    // A MOVW group has a constant form: the value's own group goes in the
    // immediate, as GNU as resolves it when the expression folds. The
    // checked forms reject a value outside the width the specifier names.
    if let AsmRelocKind::A64MovwAbs {
        group,
        signed,
        check,
    } = r.kind
    {
        use crate::c5::codegen::aarch64::patch;
        let word = u32::from_le_bytes(buf[at..at + 4].try_into().expect("4-byte field"));
        let word = patch::movw_const_word(word, group, signed, check, v)?;
        buf[at..at + 4].copy_from_slice(&word.to_le_bytes());
        return Ok(());
    }
    patch_asm_insn_field(buf, at, r.kind, true, r.width, v)?
        .then_some(())
        .ok_or_else(|| alloc::string::String::from("expression has no constant form in this field"))
}

/// A materialized named section: bytes plus relocations, accumulated
/// across the unit's inline-asm statements. The object writers append
/// one output section per distinct `(name, flags, sh_type)`.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmSection {
    pub name: alloc::string::String,
    pub flags: alloc::string::String,
    pub sh_type: Option<alloc::string::String>,
    pub bytes: alloc::vec::Vec<u8>,
    pub relocs: alloc::vec::Vec<AsmSectionReloc>,
    /// Labels defined in the section; each becomes a symbol whose section
    /// index is this section and whose value is `offset` within it.
    pub labels: alloc::vec::Vec<AsmSectionLabel>,
    /// Largest `.balign` seen; the object writer aligns the section.
    pub align: u32,
    /// Whether the section's last byte-emitting item was an instruction.
    /// x86 alignment padding depends on it (see
    /// [`push_x86_exec_align_fill`]); the state carries across the blocks
    /// that merge into one section. A fresh section starts at the
    /// assembler's section-start boundary.
    pub after_insn: bool,
    /// The mapping state GNU as tracks per section: none before any
    /// content, then data or instructions. On AArch64 an instruction
    /// emitted while it is data is aligned to 4 first.
    pub map_state: Option<MapClass>,
    /// Code / data run starts, for the AArch64 mapping symbols the object
    /// writer emits.
    pub map: MapMarks,
}

/// Offset marking a `.globl` seen before its label definition.
pub(crate) const PENDING_LABEL: u32 = u32::MAX;

/// ELF symbol type set by a section's `.type name, @function|@object`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum AsmSymType {
    #[default]
    NoType,
    Func,
    Object,
}

/// Binding a symbol directive requests; `Default` leaves the symbol's own.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum AsmSymBind {
    #[default]
    Default,
    Global,
    Local,
    Weak,
}

/// The value a `.set` / `.equ` / `.equiv` outside any section assigned: a
/// constant, which binds the name `SHN_ABS`, or another symbol at a byte
/// offset, whose definition the name takes.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmSymValue {
    Abs(i64),
    Sym(alloc::string::String, i64),
}

/// A symbol directive an asm template carried outside any section. GNU as
/// scopes `.globl` / `.local` / `.weak` / `.type` / `.size` and the
/// assignments to the unit, so the name may be defined by this template's
/// code stream, by another statement's section, by C, or by nothing in the
/// unit. TODO `.globl` on a C symbol of the unit: the linkage split is
/// decided from the parse, which a function-scope template runs after. The
/// file-scope parse applies it.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub(crate) struct AsmSymDecl {
    pub name: alloc::string::String,
    pub bind: AsmSymBind,
    pub sym_type: AsmSymType,
    pub size: Option<u64>,
    /// Assigned value, when a `.set` family directive named it.
    pub value: Option<AsmSymValue>,
}

/// A label defined inside a named section.
#[derive(Debug, Clone, Default, PartialEq, Eq)]
pub(crate) struct AsmSectionLabel {
    pub name: alloc::string::String,
    /// Byte offset of the definition within the section's own bytes.
    pub offset: u32,
    /// `.globl`-declared: external rather than local binding.
    pub global: bool,
    /// `.weak`-declared: weak rather than global or local binding.
    pub weak: bool,
    /// Symbol type from a `.type` directive (`STT_NOTYPE` when absent).
    pub sym_type: AsmSymType,
    /// `st_size` from a `.size` directive; `None` leaves it zero.
    pub size: Option<u64>,
    /// Value of a `.set` / `=` assignment that folded to a constant. The
    /// symbol is `SHN_ABS` and `offset` does not apply, as in GNU as.
    pub absolute: Option<i64>,
}

/// A snapshot of the accumulated section sink, taken before a function
/// body is laid out. `materialize_asm_sections` merges into existing
/// sections, so a branch-relaxation re-emit or a bailed emit needs to
/// undo the merge; a plain length truncation of the outer vector would
/// leave the appended bytes / relocs / labels in a pre-existing section.
pub(crate) struct AsmSectionsSnapshot {
    pub(crate) len: usize,
    /// The declarations verbatim: a merge onto an entry that predates the
    /// snapshot is not undone by a length truncation.
    pub(crate) decls: alloc::vec::Vec<AsmSymDecl>,
    /// Recorded `.cfi_*` directives at the snapshot, so a re-laid-out
    /// function does not describe its frame twice.
    pub(crate) cfi: usize,
    /// Per section: bytes, relocs, labels, alignment, instruction-boundary
    /// state, mapping state.
    pub(crate) per_section: alloc::vec::Vec<(usize, usize, usize, u32, bool, Option<MapClass>)>,
}

/// The `(name, flags, sh_type)` identity key of a section block, as the
/// measurement map and the expression spaces use it. Subsections share the
/// key: they are ordered blocks of one section.
pub(crate) fn section_key(b: &AsmSectionBlock) -> alloc::string::String {
    alloc::format!("{}\u{0}{}\u{0}{:?}", b.name, b.flags, b.sh_type)
}

/// The same identity key for a section already in the sink.
pub(crate) fn section_key_of(s: &AsmSection) -> alloc::string::String {
    alloc::format!("{}\u{0}{}\u{0}{:?}", s.name, s.flags, s.sh_type)
}

/// Block processing order: stable by subsection number, so a section's
/// subsection-1 blocks lay out after every subsection-0 block while blocks
/// of one subsection keep their source order. Measurement and
/// materialization must walk the same order.
pub(crate) fn subsection_order(blocks: &[AsmSectionBlock]) -> alloc::vec::Vec<usize> {
    let mut order: alloc::vec::Vec<usize> = (0..blocks.len()).collect();
    order.sort_by_key(|&i| blocks[i].subsection);
    order
}
