//! ELF relocation type numbers.
//!
//! x86_64 values follow the System V AMD64 psABI relocation table;
//! aarch64 values follow `ELF for the Arm 64-bit Architecture`
//! (AArch64), relocation-code table. Single definition site for the
//! whole compiler: the object writers emit these numbers and the
//! linker matches on them, so a copy that drifts makes the linker
//! apply a relocation under another type's rule with no diagnostic.

use alloc::format;
use alloc::string::String;

// ---- x86_64 ----
pub(crate) const R_X86_64_64: u32 = 1;
pub(crate) const R_X86_64_PC32: u32 = 2;
pub(crate) const R_X86_64_PLT32: u32 = 4;
pub(crate) const R_X86_64_COPY: u32 = 5;
pub(crate) const R_X86_64_GLOB_DAT: u32 = 6;
pub(crate) const R_X86_64_JUMP_SLOT: u32 = 7;
pub(crate) const R_X86_64_RELATIVE: u32 = 8;
pub(crate) const R_X86_64_GOTPCREL: u32 = 9;
pub(crate) const R_X86_64_32: u32 = 10;
pub(crate) const R_X86_64_32S: u32 = 11;
pub(crate) const R_X86_64_16: u32 = 12;
pub(crate) const R_X86_64_8: u32 = 14;
pub(crate) const R_X86_64_PC16: u32 = 13;
pub(crate) const R_X86_64_DTPOFF64: u32 = 17;
pub(crate) const R_X86_64_TPOFF32: u32 = 23;
pub(crate) const R_X86_64_PC64: u32 = 24;
pub(crate) const R_X86_64_REX_GOTPCRELX: u32 = 42;

// ---- i386 ----
pub(crate) const R_386_32: u32 = 1;
pub(crate) const R_386_PC32: u32 = 2;
pub(crate) const R_386_GOT32: u32 = 3;
pub(crate) const R_386_PLT32: u32 = 4;
pub(crate) const R_386_COPY: u32 = 5;
pub(crate) const R_386_GLOB_DAT: u32 = 6;
pub(crate) const R_386_JUMP_SLOT: u32 = 7;
pub(crate) const R_386_RELATIVE: u32 = 8;
pub(crate) const R_386_GOTOFF: u32 = 9;
pub(crate) const R_386_GOTPC: u32 = 10;
pub(crate) const R_386_16: u32 = 20;
pub(crate) const R_386_PC16: u32 = 21;
pub(crate) const R_386_8: u32 = 22;
pub(crate) const R_386_PC8: u32 = 23;

// ---- aarch64 ----
pub(crate) const R_AARCH64_ABS64: u32 = 257;
pub(crate) const R_AARCH64_ABS32: u32 = 258;
pub(crate) const R_AARCH64_PREL64: u32 = 260;
pub(crate) const R_AARCH64_PREL32: u32 = 261;
pub(crate) const R_AARCH64_LD_PREL_LO19: u32 = 273;
pub(crate) const R_AARCH64_ADR_PREL_LO21: u32 = 274;
pub(crate) const R_AARCH64_ADR_PREL_PG_HI21: u32 = 275;
pub(crate) const R_AARCH64_TSTBR14: u32 = 279;
pub(crate) const R_AARCH64_CONDBR19: u32 = 280;
pub(crate) const R_AARCH64_ADD_ABS_LO12_NC: u32 = 277;
pub(crate) const R_AARCH64_LDST8_ABS_LO12_NC: u32 = 278;
pub(crate) const R_AARCH64_JUMP26: u32 = 282;
pub(crate) const R_AARCH64_CALL26: u32 = 283;
pub(crate) const R_AARCH64_LDST16_ABS_LO12_NC: u32 = 284;
pub(crate) const R_AARCH64_LDST32_ABS_LO12_NC: u32 = 285;
pub(crate) const R_AARCH64_LDST64_ABS_LO12_NC: u32 = 286;
pub(crate) const R_AARCH64_LDST128_ABS_LO12_NC: u32 = 299;
pub(crate) const R_AARCH64_ADR_GOT_PAGE: u32 = 311;
pub(crate) const R_AARCH64_LD64_GOT_LO12_NC: u32 = 312;
pub(crate) const R_AARCH64_TLSLE_ADD_TPREL_HI12: u32 = 549;
pub(crate) const R_AARCH64_TLSLE_ADD_TPREL_LO12_NC: u32 = 551;
pub(crate) const R_AARCH64_COPY: u32 = 1024;
pub(crate) const R_AARCH64_GLOB_DAT: u32 = 1025;
pub(crate) const R_AARCH64_JUMP_SLOT: u32 = 1026;
pub(crate) const R_AARCH64_RELATIVE: u32 = 1027;
pub(crate) const R_AARCH64_TLS_DTPREL64: u32 = 1029;

/// Access size in bytes that an `R_AARCH64_LDST<n>_ABS_LO12_NC`
/// relocation scales its immediate by, or `None` for any other type.
/// The ABI defines the field as bits `[11:log2(n)]` of `S + A`, which
/// matches the scaling of the unsigned-offset load/store immediate.
pub(crate) fn aarch64_ldst_lo12_scale(rtype: u32) -> Option<u32> {
    match rtype {
        R_AARCH64_LDST8_ABS_LO12_NC => Some(1),
        R_AARCH64_LDST16_ABS_LO12_NC => Some(2),
        R_AARCH64_LDST32_ABS_LO12_NC => Some(4),
        R_AARCH64_LDST64_ABS_LO12_NC => Some(8),
        R_AARCH64_LDST128_ABS_LO12_NC => Some(16),
        _ => None,
    }
}

/// `R_X86_64_<NAME> (<n>)` for an ABI-assigned type, `relocation
/// type <n>` otherwise. Diagnostics name a relocation the way
/// `readelf -r` prints it.
pub(crate) fn x86_64_reloc_desc(rtype: u32) -> String {
    desc(X86_64_RELOC_NAMES, rtype)
}

/// aarch64 counterpart of [`x86_64_reloc_desc`].
pub(crate) fn aarch64_reloc_desc(rtype: u32) -> String {
    desc(AARCH64_RELOC_NAMES, rtype)
}

/// i386 counterpart of [`x86_64_reloc_desc`].
pub(crate) fn i386_reloc_desc(rtype: u32) -> String {
    desc(I386_RELOC_NAMES, rtype)
}

/// Byte width of the field an `R_386_*` relocation reads and writes, or
/// `None` for a type that touches no field. i386 uses `SHT_REL`, so the
/// width is also what the implicit addend is read at.
pub(crate) fn i386_field_width(rtype: u32) -> Option<u32> {
    match rtype {
        R_386_8 | R_386_PC8 => Some(1),
        R_386_16 | R_386_PC16 => Some(2),
        R_386_32 | R_386_PC32 | R_386_GOT32 | R_386_PLT32 | R_386_GLOB_DAT | R_386_JUMP_SLOT
        | R_386_RELATIVE | R_386_GOTOFF | R_386_GOTPC | R_386_COPY => Some(4),
        _ => None,
    }
}

fn desc(names: &[(u32, &str)], rtype: u32) -> String {
    match names.iter().find(|(v, _)| *v == rtype) {
        Some((_, name)) => format!("{name} ({rtype})"),
        None => format!("relocation type {rtype}"),
    }
}

/// SysV AMD64 psABI relocation numbering, in ABI order.
pub(crate) static X86_64_RELOC_NAMES: &[(u32, &str)] = &[
    (0, "R_X86_64_NONE"),
    (1, "R_X86_64_64"),
    (2, "R_X86_64_PC32"),
    (3, "R_X86_64_GOT32"),
    (4, "R_X86_64_PLT32"),
    (5, "R_X86_64_COPY"),
    (6, "R_X86_64_GLOB_DAT"),
    (7, "R_X86_64_JUMP_SLOT"),
    (8, "R_X86_64_RELATIVE"),
    (9, "R_X86_64_GOTPCREL"),
    (10, "R_X86_64_32"),
    (11, "R_X86_64_32S"),
    (12, "R_X86_64_16"),
    (13, "R_X86_64_PC16"),
    (14, "R_X86_64_8"),
    (15, "R_X86_64_PC8"),
    (16, "R_X86_64_DTPMOD64"),
    (17, "R_X86_64_DTPOFF64"),
    (18, "R_X86_64_TPOFF64"),
    (19, "R_X86_64_TLSGD"),
    (20, "R_X86_64_TLSLD"),
    (21, "R_X86_64_DTPOFF32"),
    (22, "R_X86_64_GOTTPOFF"),
    (23, "R_X86_64_TPOFF32"),
    (24, "R_X86_64_PC64"),
    (25, "R_X86_64_GOTOFF64"),
    (26, "R_X86_64_GOTPC32"),
    (27, "R_X86_64_GOT64"),
    (28, "R_X86_64_GOTPCREL64"),
    (29, "R_X86_64_GOTPC64"),
    (30, "R_X86_64_GOTPLT64"),
    (31, "R_X86_64_PLTOFF64"),
    (32, "R_X86_64_SIZE32"),
    (33, "R_X86_64_SIZE64"),
    (34, "R_X86_64_GOTPC32_TLSDESC"),
    (35, "R_X86_64_TLSDESC_CALL"),
    (36, "R_X86_64_TLSDESC"),
    (37, "R_X86_64_IRELATIVE"),
    (38, "R_X86_64_RELATIVE64"),
    (41, "R_X86_64_GOTPCRELX"),
    (42, "R_X86_64_REX_GOTPCRELX"),
];

/// Intel386 psABI relocation numbering, in ABI order.
pub(crate) static I386_RELOC_NAMES: &[(u32, &str)] = &[
    (0, "R_386_NONE"),
    (1, "R_386_32"),
    (2, "R_386_PC32"),
    (3, "R_386_GOT32"),
    (4, "R_386_PLT32"),
    (5, "R_386_COPY"),
    (6, "R_386_GLOB_DAT"),
    (7, "R_386_JMP_SLOT"),
    (8, "R_386_RELATIVE"),
    (9, "R_386_GOTOFF"),
    (10, "R_386_GOTPC"),
    (11, "R_386_32PLT"),
    (14, "R_386_TLS_TPOFF"),
    (15, "R_386_TLS_IE"),
    (16, "R_386_TLS_GOTIE"),
    (17, "R_386_TLS_LE"),
    (18, "R_386_TLS_GD"),
    (19, "R_386_TLS_LDM"),
    (20, "R_386_16"),
    (21, "R_386_PC16"),
    (22, "R_386_8"),
    (23, "R_386_PC8"),
    (24, "R_386_TLS_GD_32"),
    (25, "R_386_TLS_GD_PUSH"),
    (26, "R_386_TLS_GD_CALL"),
    (27, "R_386_TLS_GD_POP"),
    (28, "R_386_TLS_LDM_32"),
    (29, "R_386_TLS_LDM_PUSH"),
    (30, "R_386_TLS_LDM_CALL"),
    (31, "R_386_TLS_LDM_POP"),
    (32, "R_386_TLS_LDO_32"),
    (33, "R_386_TLS_IE_32"),
    (34, "R_386_TLS_LE_32"),
    (35, "R_386_TLS_DTPMOD32"),
    (36, "R_386_TLS_DTPOFF32"),
    (37, "R_386_TLS_TPOFF32"),
    (38, "R_386_SIZE32"),
    (42, "R_386_IRELATIVE"),
    (43, "R_386_GOT32X"),
];

/// AArch64 ELF ABI relocation numbering, in ABI order.
pub(crate) static AARCH64_RELOC_NAMES: &[(u32, &str)] = &[
    (0, "R_AARCH64_NONE"),
    (257, "R_AARCH64_ABS64"),
    (258, "R_AARCH64_ABS32"),
    (259, "R_AARCH64_ABS16"),
    (260, "R_AARCH64_PREL64"),
    (261, "R_AARCH64_PREL32"),
    (262, "R_AARCH64_PREL16"),
    (263, "R_AARCH64_MOVW_UABS_G0"),
    (264, "R_AARCH64_MOVW_UABS_G0_NC"),
    (265, "R_AARCH64_MOVW_UABS_G1"),
    (266, "R_AARCH64_MOVW_UABS_G1_NC"),
    (267, "R_AARCH64_MOVW_UABS_G2"),
    (268, "R_AARCH64_MOVW_UABS_G2_NC"),
    (269, "R_AARCH64_MOVW_UABS_G3"),
    (270, "R_AARCH64_MOVW_SABS_G0"),
    (271, "R_AARCH64_MOVW_SABS_G1"),
    (272, "R_AARCH64_MOVW_SABS_G2"),
    (273, "R_AARCH64_LD_PREL_LO19"),
    (274, "R_AARCH64_ADR_PREL_LO21"),
    (275, "R_AARCH64_ADR_PREL_PG_HI21"),
    (276, "R_AARCH64_ADR_PREL_PG_HI21_NC"),
    (277, "R_AARCH64_ADD_ABS_LO12_NC"),
    (278, "R_AARCH64_LDST8_ABS_LO12_NC"),
    (279, "R_AARCH64_TSTBR14"),
    (280, "R_AARCH64_CONDBR19"),
    (282, "R_AARCH64_JUMP26"),
    (283, "R_AARCH64_CALL26"),
    (284, "R_AARCH64_LDST16_ABS_LO12_NC"),
    (285, "R_AARCH64_LDST32_ABS_LO12_NC"),
    (286, "R_AARCH64_LDST64_ABS_LO12_NC"),
    (287, "R_AARCH64_MOVW_PREL_G0"),
    (288, "R_AARCH64_MOVW_PREL_G0_NC"),
    (289, "R_AARCH64_MOVW_PREL_G1"),
    (290, "R_AARCH64_MOVW_PREL_G1_NC"),
    (291, "R_AARCH64_MOVW_PREL_G2"),
    (292, "R_AARCH64_MOVW_PREL_G2_NC"),
    (293, "R_AARCH64_MOVW_PREL_G3"),
    (299, "R_AARCH64_LDST128_ABS_LO12_NC"),
    (300, "R_AARCH64_MOVW_GOTOFF_G0"),
    (301, "R_AARCH64_MOVW_GOTOFF_G0_NC"),
    (302, "R_AARCH64_MOVW_GOTOFF_G1"),
    (303, "R_AARCH64_MOVW_GOTOFF_G1_NC"),
    (304, "R_AARCH64_MOVW_GOTOFF_G2"),
    (305, "R_AARCH64_MOVW_GOTOFF_G2_NC"),
    (306, "R_AARCH64_MOVW_GOTOFF_G3"),
    (307, "R_AARCH64_GOTREL64"),
    (308, "R_AARCH64_GOTREL32"),
    (309, "R_AARCH64_GOT_LD_PREL19"),
    (310, "R_AARCH64_LD64_GOTOFF_LO15"),
    (311, "R_AARCH64_ADR_GOT_PAGE"),
    (312, "R_AARCH64_LD64_GOT_LO12_NC"),
    (313, "R_AARCH64_LD64_GOTPAGE_LO15"),
    (512, "R_AARCH64_TLSGD_ADR_PREL21"),
    (513, "R_AARCH64_TLSGD_ADR_PAGE21"),
    (514, "R_AARCH64_TLSGD_ADD_LO12_NC"),
    (515, "R_AARCH64_TLSGD_MOVW_G1"),
    (516, "R_AARCH64_TLSGD_MOVW_G0_NC"),
    (517, "R_AARCH64_TLSLD_ADR_PREL21"),
    (518, "R_AARCH64_TLSLD_ADR_PAGE21"),
    (519, "R_AARCH64_TLSLD_ADD_LO12_NC"),
    (520, "R_AARCH64_TLSLD_MOVW_G1"),
    (521, "R_AARCH64_TLSLD_MOVW_G0_NC"),
    (522, "R_AARCH64_TLSLD_LD_PREL19"),
    (523, "R_AARCH64_TLSLD_MOVW_DTPREL_G2"),
    (524, "R_AARCH64_TLSLD_MOVW_DTPREL_G1"),
    (525, "R_AARCH64_TLSLD_MOVW_DTPREL_G1_NC"),
    (526, "R_AARCH64_TLSLD_MOVW_DTPREL_G0"),
    (527, "R_AARCH64_TLSLD_MOVW_DTPREL_G0_NC"),
    (528, "R_AARCH64_TLSLD_ADD_DTPREL_HI12"),
    (529, "R_AARCH64_TLSLD_ADD_DTPREL_LO12"),
    (530, "R_AARCH64_TLSLD_ADD_DTPREL_LO12_NC"),
    (531, "R_AARCH64_TLSLD_LDST8_DTPREL_LO12"),
    (532, "R_AARCH64_TLSLD_LDST8_DTPREL_LO12_NC"),
    (533, "R_AARCH64_TLSLD_LDST16_DTPREL_LO12"),
    (534, "R_AARCH64_TLSLD_LDST16_DTPREL_LO12_NC"),
    (535, "R_AARCH64_TLSLD_LDST32_DTPREL_LO12"),
    (536, "R_AARCH64_TLSLD_LDST32_DTPREL_LO12_NC"),
    (537, "R_AARCH64_TLSLD_LDST64_DTPREL_LO12"),
    (538, "R_AARCH64_TLSLD_LDST64_DTPREL_LO12_NC"),
    (539, "R_AARCH64_TLSIE_MOVW_GOTTPREL_G1"),
    (540, "R_AARCH64_TLSIE_MOVW_GOTTPREL_G0_NC"),
    (541, "R_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21"),
    (542, "R_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC"),
    (543, "R_AARCH64_TLSIE_LD_GOTTPREL_PREL19"),
    (544, "R_AARCH64_TLSLE_MOVW_TPREL_G2"),
    (545, "R_AARCH64_TLSLE_MOVW_TPREL_G1"),
    (546, "R_AARCH64_TLSLE_MOVW_TPREL_G1_NC"),
    (547, "R_AARCH64_TLSLE_MOVW_TPREL_G0"),
    (548, "R_AARCH64_TLSLE_MOVW_TPREL_G0_NC"),
    (549, "R_AARCH64_TLSLE_ADD_TPREL_HI12"),
    (550, "R_AARCH64_TLSLE_ADD_TPREL_LO12"),
    (551, "R_AARCH64_TLSLE_ADD_TPREL_LO12_NC"),
    (552, "R_AARCH64_TLSLE_LDST8_TPREL_LO12"),
    (553, "R_AARCH64_TLSLE_LDST8_TPREL_LO12_NC"),
    (554, "R_AARCH64_TLSLE_LDST16_TPREL_LO12"),
    (555, "R_AARCH64_TLSLE_LDST16_TPREL_LO12_NC"),
    (556, "R_AARCH64_TLSLE_LDST32_TPREL_LO12"),
    (557, "R_AARCH64_TLSLE_LDST32_TPREL_LO12_NC"),
    (558, "R_AARCH64_TLSLE_LDST64_TPREL_LO12"),
    (559, "R_AARCH64_TLSLE_LDST64_TPREL_LO12_NC"),
    (560, "R_AARCH64_TLSDESC_LD_PREL19"),
    (561, "R_AARCH64_TLSDESC_ADR_PREL21"),
    (562, "R_AARCH64_TLSDESC_ADR_PAGE21"),
    (563, "R_AARCH64_TLSDESC_LD64_LO12"),
    (564, "R_AARCH64_TLSDESC_ADD_LO12"),
    (565, "R_AARCH64_TLSDESC_OFF_G1"),
    (566, "R_AARCH64_TLSDESC_OFF_G0_NC"),
    (567, "R_AARCH64_TLSDESC_LDR"),
    (568, "R_AARCH64_TLSDESC_ADD"),
    (569, "R_AARCH64_TLSDESC_CALL"),
    (570, "R_AARCH64_TLSLE_LDST128_TPREL_LO12"),
    (571, "R_AARCH64_TLSLE_LDST128_TPREL_LO12_NC"),
    (572, "R_AARCH64_TLSLD_LDST128_DTPREL_LO12"),
    (573, "R_AARCH64_TLSLD_LDST128_DTPREL_LO12_NC"),
    (1024, "R_AARCH64_COPY"),
    (1025, "R_AARCH64_GLOB_DAT"),
    (1026, "R_AARCH64_JUMP_SLOT"),
    (1027, "R_AARCH64_RELATIVE"),
    (1028, "R_AARCH64_TLS_DTPMOD"),
    (1029, "R_AARCH64_TLS_DTPREL"),
    (1030, "R_AARCH64_TLS_TPREL"),
    (1031, "R_AARCH64_TLSDESC"),
    (1032, "R_AARCH64_IRELATIVE"),
];

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::format;

    /// Every named constant must carry the number the ABI table
    /// assigns to that name. Catches a constant transcribed from the
    /// wrong table row -- the defect class that let the linker match
    /// an incoming relocation under a neighbouring type's arm.
    #[test]
    fn constants_match_the_abi_numbering() {
        let check = |names: &[(u32, &str)], value: u32, name: &str| {
            let expected = names
                .iter()
                .find(|(_, n)| *n == name)
                .unwrap_or_else(|| panic!("{name} missing from the ABI table"))
                .0;
            assert_eq!(value, expected, "{name} must be {expected}, not {value}");
        };
        let x = |value, name| check(X86_64_RELOC_NAMES, value, name);
        x(R_X86_64_64, "R_X86_64_64");
        x(R_X86_64_PC32, "R_X86_64_PC32");
        x(R_X86_64_PLT32, "R_X86_64_PLT32");
        x(R_X86_64_COPY, "R_X86_64_COPY");
        x(R_X86_64_GLOB_DAT, "R_X86_64_GLOB_DAT");
        x(R_X86_64_JUMP_SLOT, "R_X86_64_JUMP_SLOT");
        x(R_X86_64_RELATIVE, "R_X86_64_RELATIVE");
        x(R_X86_64_GOTPCREL, "R_X86_64_GOTPCREL");
        x(R_X86_64_32, "R_X86_64_32");
        x(R_X86_64_32S, "R_X86_64_32S");
        x(R_X86_64_TPOFF32, "R_X86_64_TPOFF32");
        x(R_X86_64_PC64, "R_X86_64_PC64");
        x(R_X86_64_REX_GOTPCRELX, "R_X86_64_REX_GOTPCRELX");
        let a = |value, name| check(AARCH64_RELOC_NAMES, value, name);
        a(R_AARCH64_ABS64, "R_AARCH64_ABS64");
        a(R_AARCH64_ABS32, "R_AARCH64_ABS32");
        a(R_AARCH64_PREL64, "R_AARCH64_PREL64");
        a(R_AARCH64_PREL32, "R_AARCH64_PREL32");
        a(R_AARCH64_ADR_PREL_PG_HI21, "R_AARCH64_ADR_PREL_PG_HI21");
        a(R_AARCH64_ADD_ABS_LO12_NC, "R_AARCH64_ADD_ABS_LO12_NC");
        a(R_AARCH64_LDST8_ABS_LO12_NC, "R_AARCH64_LDST8_ABS_LO12_NC");
        a(R_AARCH64_JUMP26, "R_AARCH64_JUMP26");
        a(R_AARCH64_CALL26, "R_AARCH64_CALL26");
        a(R_AARCH64_LDST16_ABS_LO12_NC, "R_AARCH64_LDST16_ABS_LO12_NC");
        a(R_AARCH64_LDST32_ABS_LO12_NC, "R_AARCH64_LDST32_ABS_LO12_NC");
        a(R_AARCH64_LDST64_ABS_LO12_NC, "R_AARCH64_LDST64_ABS_LO12_NC");
        a(
            R_AARCH64_LDST128_ABS_LO12_NC,
            "R_AARCH64_LDST128_ABS_LO12_NC",
        );
        a(R_AARCH64_ADR_GOT_PAGE, "R_AARCH64_ADR_GOT_PAGE");
        a(R_AARCH64_LD64_GOT_LO12_NC, "R_AARCH64_LD64_GOT_LO12_NC");
        a(
            R_AARCH64_TLSLE_ADD_TPREL_HI12,
            "R_AARCH64_TLSLE_ADD_TPREL_HI12",
        );
        a(
            R_AARCH64_TLSLE_ADD_TPREL_LO12_NC,
            "R_AARCH64_TLSLE_ADD_TPREL_LO12_NC",
        );
        a(R_AARCH64_COPY, "R_AARCH64_COPY");
        a(R_AARCH64_GLOB_DAT, "R_AARCH64_GLOB_DAT");
        a(R_AARCH64_JUMP_SLOT, "R_AARCH64_JUMP_SLOT");
        a(R_AARCH64_RELATIVE, "R_AARCH64_RELATIVE");
    }

    /// The ABI assigns one name per number; a duplicate would mean a
    /// transcription slip that hides one of the two entries.
    #[test]
    fn abi_tables_are_strictly_ascending() {
        for names in [X86_64_RELOC_NAMES, AARCH64_RELOC_NAMES] {
            for w in names.windows(2) {
                assert!(w[0].0 < w[1].0, "{:?} then {:?} out of order", w[0], w[1]);
            }
        }
    }

    /// The bundled `<elf.h>` publishes the same relocation tables to
    /// user code that these constants drive the object writers with. One
    /// numbering, two consumers: a value that disagrees would make a
    /// program badc compiles read its own relocations under the wrong
    /// name.
    #[test]
    fn bundled_elf_header_agrees_with_the_abi_tables() {
        use alloc::string::ToString;
        let header = crate::c5::headers::embedded_headers()
            .iter()
            .find(|(name, _)| *name == "elf.h")
            .expect("elf.h is part of the embedded set")
            .1;
        let mut checked = 0;
        for line in header.lines() {
            let rest = match line.strip_prefix("#define R_") {
                Some(r) => r,
                None => continue,
            };
            let mut it = rest.split_whitespace();
            let (name, value) = match (it.next(), it.next()) {
                (Some(n), Some(v)) => ("R_".to_string() + n, v),
                _ => continue,
            };
            let table = if name.starts_with("R_X86_64_") {
                X86_64_RELOC_NAMES
            } else if name.starts_with("R_AARCH64_") {
                AARCH64_RELOC_NAMES
            } else {
                continue;
            };
            let Some(&(expected, _)) = table.iter().find(|(_, n)| *n == name) else {
                continue;
            };
            let got: u32 = value.parse().expect("decimal relocation number");
            assert_eq!(
                got, expected,
                "<elf.h> {name} is {got}, ABI table says {expected}"
            );
            checked += 1;
        }
        assert!(
            checked >= 100,
            "expected the header to publish the relocation tables, matched {checked}"
        );
    }

    #[test]
    fn unassigned_numbers_describe_themselves() {
        assert_eq!(aarch64_reloc_desc(287), "R_AARCH64_MOVW_PREL_G0 (287)");
        assert_eq!(x86_64_reloc_desc(4), "R_X86_64_PLT32 (4)");
        assert_eq!(
            format!("{}", aarch64_reloc_desc(9999)),
            "relocation type 9999"
        );
    }
}
