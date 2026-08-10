//! On-disk ELF record shapes and the class oracle that selects
//! between them.
//!
//! Single definition site for the whole compiler: the object writer,
//! the script linker, and the readers all decode and encode through
//! [`ElfClass`], so a 32-bit object badc writes and a 32-bit object it
//! reads agree on record widths, field order, and the `r_info` split
//! by construction.
//!
//! In-memory records are always the ELF64 shapes -- the wider of the
//! two. Readers widen an ELF32 record into its ELF64 counterpart on
//! decode; the writers here narrow it again on encode. Only those two
//! steps are class-dependent.

#[cfg(feature = "native-emit")]
use alloc::vec::Vec;

#[cfg(feature = "native-emit")]
use crate::c5::layout::write_struct;

/// ELF class of an object or image. Fixes the width of every on-disk
/// record the readers decode and the writers emit.
#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
pub enum ElfClass {
    Elf32,
    #[default]
    Elf64,
}

impl ElfClass {
    /// `e_ident[EI_CLASS]`.
    pub fn ei_class(self) -> u8 {
        match self {
            ElfClass::Elf32 => 1,
            ElfClass::Elf64 => 2,
        }
    }
    pub fn from_ei_class(b: u8) -> Option<ElfClass> {
        match b {
            1 => Some(ElfClass::Elf32),
            2 => Some(ElfClass::Elf64),
            _ => None,
        }
    }
    pub fn is32(self) -> bool {
        self == ElfClass::Elf32
    }
    /// Width of an address / offset field.
    pub fn addr_size(self) -> u64 {
        if self.is32() { 4 } else { 8 }
    }
    pub fn ehdr_size(self) -> u64 {
        if self.is32() { 52 } else { 64 }
    }
    pub fn phdr_size(self) -> u64 {
        if self.is32() { 32 } else { 56 }
    }
    pub fn shdr_size(self) -> u64 {
        if self.is32() { 40 } else { 64 }
    }
    pub fn sym_size(self) -> u64 {
        if self.is32() { 16 } else { 24 }
    }
    pub fn rel_size(self) -> u64 {
        if self.is32() { 8 } else { 16 }
    }
    pub fn rela_size(self) -> u64 {
        if self.is32() { 12 } else { 24 }
    }
    pub fn dyn_size(self) -> u64 {
        if self.is32() { 8 } else { 16 }
    }
    /// `r_info` split: ELF32 keeps the type in the low byte.
    pub fn reloc_info(self, sym: u32, rtype: u32) -> u64 {
        if self.is32() {
            ((sym as u64) << 8) | (rtype as u64 & 0xff)
        } else {
            ((sym as u64) << 32) | rtype as u64
        }
    }
    pub fn reloc_sym(self, info: u64) -> u32 {
        if self.is32() {
            (info >> 8) as u32
        } else {
            (info >> 32) as u32
        }
    }
    pub fn reloc_type(self, info: u64) -> u32 {
        if self.is32() {
            (info & 0xff) as u32
        } else {
            info as u32
        }
    }
    /// Little-endian encoding of an address-width value.
    pub fn addr_bytes(self, v: u64) -> [u8; 8] {
        if self.is32() {
            let b = (v as u32).to_le_bytes();
            [b[0], b[1], b[2], b[3], 0, 0, 0, 0]
        } else {
            v.to_le_bytes()
        }
    }
}

// On-disk records as `#[repr(C)]` structs. The struct layout matches
// the ELF spec verbatim because every field is naturally aligned at
// the offset the spec calls out and the platforms badc targets are
// little-endian, so field byte-order matches on-disk order. The size
// asserts at the bottom of the block lock the layouts.
#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct Elf64Ehdr {
    pub(crate) e_ident: [u8; 16],
    pub(crate) e_type: u16,
    pub(crate) e_machine: u16,
    pub(crate) e_version: u32,
    pub(crate) e_entry: u64,
    pub(crate) e_phoff: u64,
    pub(crate) e_shoff: u64,
    pub(crate) e_flags: u32,
    pub(crate) e_ehsize: u16,
    pub(crate) e_phentsize: u16,
    pub(crate) e_phnum: u16,
    pub(crate) e_shentsize: u16,
    pub(crate) e_shnum: u16,
    pub(crate) e_shstrndx: u16,
}

#[repr(C)]
#[derive(Debug, Clone, Copy, Default)]
pub(crate) struct Elf64Shdr {
    pub(crate) sh_name: u32,
    pub(crate) sh_type: u32,
    pub(crate) sh_flags: u64,
    pub(crate) sh_addr: u64,
    pub(crate) sh_offset: u64,
    pub(crate) sh_size: u64,
    pub(crate) sh_link: u32,
    pub(crate) sh_info: u32,
    pub(crate) sh_addralign: u64,
    pub(crate) sh_entsize: u64,
}

#[repr(C)]
#[derive(Debug, Clone, Copy, Default)]
pub(crate) struct Elf64Sym {
    pub(crate) st_name: u32,
    pub(crate) st_info: u8,
    pub(crate) st_other: u8,
    pub(crate) st_shndx: u16,
    pub(crate) st_value: u64,
    pub(crate) st_size: u64,
}

#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct Elf64Rel {
    pub(crate) r_offset: u64,
    pub(crate) r_info: u64,
}

#[repr(C)]
#[derive(Debug, Clone, Copy, Default)]
pub(crate) struct Elf64Rela {
    pub(crate) r_offset: u64,
    pub(crate) r_info: u64,
    pub(crate) r_addend: i64,
}

#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct Elf32Ehdr {
    pub(crate) e_ident: [u8; 16],
    pub(crate) e_type: u16,
    pub(crate) e_machine: u16,
    pub(crate) e_version: u32,
    pub(crate) e_entry: u32,
    pub(crate) e_phoff: u32,
    pub(crate) e_shoff: u32,
    pub(crate) e_flags: u32,
    pub(crate) e_ehsize: u16,
    pub(crate) e_phentsize: u16,
    pub(crate) e_phnum: u16,
    pub(crate) e_shentsize: u16,
    pub(crate) e_shnum: u16,
    pub(crate) e_shstrndx: u16,
}

#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct Elf32Shdr {
    pub(crate) sh_name: u32,
    pub(crate) sh_type: u32,
    pub(crate) sh_flags: u32,
    pub(crate) sh_addr: u32,
    pub(crate) sh_offset: u32,
    pub(crate) sh_size: u32,
    pub(crate) sh_link: u32,
    pub(crate) sh_info: u32,
    pub(crate) sh_addralign: u32,
    pub(crate) sh_entsize: u32,
}

/// ELF32 symbol: the value and size fields sit before `st_info`,
/// unlike the ELF64 record.
#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct Elf32Sym {
    pub(crate) st_name: u32,
    pub(crate) st_value: u32,
    pub(crate) st_size: u32,
    pub(crate) st_info: u8,
    pub(crate) st_other: u8,
    pub(crate) st_shndx: u16,
}

#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct Elf32Rel {
    pub(crate) r_offset: u32,
    pub(crate) r_info: u32,
}

#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub(crate) struct Elf32Rela {
    pub(crate) r_offset: u32,
    pub(crate) r_info: u32,
    pub(crate) r_addend: i32,
}

impl From<Elf32Ehdr> for Elf64Ehdr {
    fn from(e: Elf32Ehdr) -> Elf64Ehdr {
        Elf64Ehdr {
            e_ident: e.e_ident,
            e_type: e.e_type,
            e_machine: e.e_machine,
            e_version: e.e_version,
            e_entry: e.e_entry as u64,
            e_phoff: e.e_phoff as u64,
            e_shoff: e.e_shoff as u64,
            e_flags: e.e_flags,
            e_ehsize: e.e_ehsize,
            e_phentsize: e.e_phentsize,
            e_phnum: e.e_phnum,
            e_shentsize: e.e_shentsize,
            e_shnum: e.e_shnum,
            e_shstrndx: e.e_shstrndx,
        }
    }
}

impl From<Elf32Shdr> for Elf64Shdr {
    fn from(s: Elf32Shdr) -> Elf64Shdr {
        Elf64Shdr {
            sh_name: s.sh_name,
            sh_type: s.sh_type,
            sh_flags: s.sh_flags as u64,
            sh_addr: s.sh_addr as u64,
            sh_offset: s.sh_offset as u64,
            sh_size: s.sh_size as u64,
            sh_link: s.sh_link,
            sh_info: s.sh_info,
            sh_addralign: s.sh_addralign as u64,
            sh_entsize: s.sh_entsize as u64,
        }
    }
}

const _: () = {
    assert!(core::mem::size_of::<Elf64Ehdr>() == 64);
    assert!(core::mem::size_of::<Elf64Shdr>() == 64);
    assert!(core::mem::size_of::<Elf64Sym>() == 24);
    assert!(core::mem::size_of::<Elf64Rel>() == 16);
    assert!(core::mem::size_of::<Elf64Rela>() == 24);
    assert!(core::mem::size_of::<Elf32Ehdr>() == 52);
    assert!(core::mem::size_of::<Elf32Shdr>() == 40);
    assert!(core::mem::size_of::<Elf32Sym>() == 16);
    assert!(core::mem::size_of::<Elf32Rel>() == 8);
    assert!(core::mem::size_of::<Elf32Rela>() == 12);
};

/// Append `e` at the class's width. The ELF32 header narrows the
/// address-width fields; every other field keeps its width and order.
#[cfg(feature = "native-emit")]
pub(crate) fn write_ehdr(class: ElfClass, e: &Elf64Ehdr, out: &mut Vec<u8>) {
    match class {
        ElfClass::Elf64 => write_struct(out, e),
        ElfClass::Elf32 => write_struct(
            out,
            &Elf32Ehdr {
                e_ident: e.e_ident,
                e_type: e.e_type,
                e_machine: e.e_machine,
                e_version: e.e_version,
                e_entry: e.e_entry as u32,
                e_phoff: e.e_phoff as u32,
                e_shoff: e.e_shoff as u32,
                e_flags: e.e_flags,
                e_ehsize: e.e_ehsize,
                e_phentsize: e.e_phentsize,
                e_phnum: e.e_phnum,
                e_shentsize: e.e_shentsize,
                e_shnum: e.e_shnum,
                e_shstrndx: e.e_shstrndx,
            },
        ),
    }
}

/// Append `s` at the class's width.
#[cfg(feature = "native-emit")]
pub(crate) fn write_shdr(class: ElfClass, s: &Elf64Shdr, out: &mut Vec<u8>) {
    match class {
        ElfClass::Elf64 => write_struct(out, s),
        ElfClass::Elf32 => write_struct(
            out,
            &Elf32Shdr {
                sh_name: s.sh_name,
                sh_type: s.sh_type,
                sh_flags: s.sh_flags as u32,
                sh_addr: s.sh_addr as u32,
                sh_offset: s.sh_offset as u32,
                sh_size: s.sh_size as u32,
                sh_link: s.sh_link,
                sh_info: s.sh_info,
                sh_addralign: s.sh_addralign as u32,
                sh_entsize: s.sh_entsize as u32,
            },
        ),
    }
}

/// Append `s` at the class's width. `Elf32_Sym` reorders the record:
/// value and size come before `st_info`.
#[cfg(feature = "native-emit")]
pub(crate) fn write_sym(class: ElfClass, s: &Elf64Sym, out: &mut Vec<u8>) {
    match class {
        ElfClass::Elf64 => write_struct(out, s),
        ElfClass::Elf32 => write_struct(
            out,
            &Elf32Sym {
                st_name: s.st_name,
                st_value: s.st_value as u32,
                st_size: s.st_size as u32,
                st_info: s.st_info,
                st_other: s.st_other,
                st_shndx: s.st_shndx,
            },
        ),
    }
}
