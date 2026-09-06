//! Symbol-version requirements for dynamic imports.
//!
//! glibc exports several symbols under more than one version: a
//! compatibility definition (`name@GLIBC_2.2.5`) and a current default
//! (`name@@GLIBC_2.14`). A reference carrying no version requirement
//! does not bind the default -- the loader accepts a definition at the
//! library's base version index outright, so the compatibility one
//! wins. The reference has to state the version it means, which the
//! ELF writer emits as `.gnu.version_r`.
//!
//! Two sources state it, neither of them the machine running the link:
//! a shared library the command line named, whose bytes the link reads
//! anyway for its export set ([`parse_export_versions`]); and the
//! target's manifest, `libc/versions/elf-<arch>.txt`, for a library the
//! target describes with no file behind it. The manifest records the
//! version at the pinned ABI floor for every name the bundled headers
//! bind; `scripts/gen_elf_symbol_versions.py` regenerates it. A name in
//! neither is left unversioned.

use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use crate::c5::codegen::Machine;

mod manifest {
    include!(concat!(env!("OUT_DIR"), "/elf_symbol_versions.rs"));
}

/// The version requirement the target's C library manifest records for
/// `symbol` in `soname`, or `None` where the manifest names no library,
/// no such symbol, or no requirement for it.
pub fn manifest_version(machine: Machine, soname: &str, symbol: &str) -> Option<&'static str> {
    let table = match machine {
        Machine::X86_64 => manifest::X86_64,
        Machine::Aarch64 => manifest::AARCH64,
    };
    let at = table
        .binary_search_by(|(s, n, _)| (*s, *n).cmp(&(soname, symbol)))
        .ok()?;
    Some(table[at].2).filter(|v| !v.is_empty())
}

const SHT_DYNSYM: u32 = 11;
const SHT_GNU_VERDEF: u32 = 0x6fff_fffd;
const SHT_GNU_VERSYM: u32 = 0x6fff_ffff;
const VER_NDX_LOCAL: u16 = 0;
const VER_NDX_GLOBAL: u16 = 1;
const VERSYM_HIDDEN: u16 = 0x8000;
const VERSYM_VERSION: u16 = 0x7fff;
const VERDEF_SIZE: usize = 20;
const VERDAUX_SIZE: usize = 8;
const SYM_SIZE: usize = 24;
const VERSYM_SIZE: usize = 2;
/// A symbol or version name past this length is malformed; the bound
/// keeps one lookup from scanning an unterminated string table.
const MAX_NAME: usize = 4096;

fn rd_u16(b: &[u8], off: usize) -> Option<u16> {
    b.get(off..off + 2)
        .map(|s| u16::from_le_bytes([s[0], s[1]]))
}

fn rd_u32(b: &[u8], off: usize) -> Option<u32> {
    b.get(off..off + 4)
        .map(|s| u32::from_le_bytes([s[0], s[1], s[2], s[3]]))
}

fn rd_u64(b: &[u8], off: usize) -> Option<u64> {
    b.get(off..off + 8)
        .map(|s| u64::from_le_bytes([s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7]]))
}

/// The NUL-terminated string at `off`, confined to the string table's
/// extent and to [`MAX_NAME`]. Both bounds matter: a section header can
/// name any offset, and one lookup per symbol into a table with no
/// terminator would otherwise cost a pass over the file each time.
fn cstr(b: &[u8], off: usize, limit: usize) -> Option<String> {
    let end = limit.min(b.len()).min(off.saturating_add(MAX_NAME));
    let s = b.get(off..end)?;
    let at = s.iter().position(|&c| c == 0)?;
    Some(String::from_utf8_lossy(&s[..at]).into_owned())
}

/// `(offset, end)` of a section's bytes, `None` when it does not lie in
/// the file.
fn extent(sh: &Shdr, len: usize) -> Option<(usize, usize)> {
    let off = usize::try_from(sh.sh_offset).ok()?;
    let end = off.checked_add(usize::try_from(sh.sh_size).ok()?)?;
    (end <= len).then_some((off, end))
}

struct Shdr {
    sh_type: u32,
    sh_offset: u64,
    sh_size: u64,
    sh_link: u32,
    sh_entsize: u64,
}

/// The default version of every export a shared object versions, read
/// from its `.gnu.version_d`, `.gnu.version` and `.dynsym`. Only
/// symbols whose default (non-hidden) versym index references a real
/// version definition (index >= 2) are recorded; base and unversioned
/// symbols are omitted. Empty when the object carries no version
/// tables, which is what a library built without them looks like.
pub fn parse_export_versions(bytes: &[u8]) -> BTreeMap<String, String> {
    parse_versioned_exports(bytes).unwrap_or_default()
}

fn parse_versioned_exports(bytes: &[u8]) -> Option<BTreeMap<String, String>> {
    // ELF64 little-endian only.
    if bytes.len() < 64 || &bytes[..4] != b"\x7fELF" || bytes[4] != 2 || bytes[5] != 1 {
        return None;
    }
    let e_shoff = rd_u64(bytes, 40)? as usize;
    let e_shentsize = rd_u16(bytes, 58)? as usize;
    let e_shnum = rd_u16(bytes, 60)? as usize;
    if e_shentsize < 64 {
        return None;
    }

    // A section header table that does not fit the file is not one.
    let table = e_shnum.checked_mul(e_shentsize)?;
    if e_shoff.checked_add(table)? > bytes.len() {
        return None;
    }
    let mut shdrs: Vec<Shdr> = Vec::with_capacity(e_shnum);
    for i in 0..e_shnum {
        let base = e_shoff + i * e_shentsize;
        shdrs.push(Shdr {
            sh_type: rd_u32(bytes, base + 4)?,
            sh_offset: rd_u64(bytes, base + 24)?,
            sh_size: rd_u64(bytes, base + 32)?,
            sh_link: rd_u32(bytes, base + 40)?,
            sh_entsize: rd_u64(bytes, base + 56)?,
        });
    }

    let dynsym = shdrs.iter().find(|s| s.sh_type == SHT_DYNSYM)?;
    let dynstr = shdrs.get(dynsym.sh_link as usize)?;
    let versym = shdrs.iter().find(|s| s.sh_type == SHT_GNU_VERSYM)?;
    let verdef = shdrs.iter().find(|s| s.sh_type == SHT_GNU_VERDEF)?;

    // Version-definition index -> name. Each Verdef's first Verdaux
    // names the version; names live in the strtab the section links to.
    let verdef_str = shdrs.get(verdef.sh_link as usize)?;
    let (str_base, str_end) = extent(verdef_str, bytes.len())?;
    let (vd_section, vd_end) = extent(verdef, bytes.len())?;
    let mut version_names: BTreeMap<u16, String> = BTreeMap::new();
    let mut vd = vd_section;
    // One entry is 20 bytes, so the section bounds the walk; `vd` only
    // moves forward, and each step is checked against that bound.
    for _ in 0..(vd_end - vd_section) / VERDEF_SIZE {
        if vd + VERDEF_SIZE > vd_end {
            break;
        }
        let vd_ndx = rd_u16(bytes, vd + 4)?;
        let vd_aux = rd_u32(bytes, vd + 12)? as usize;
        let vd_next = rd_u32(bytes, vd + 16)? as usize;
        let Some(vda_name) = vd
            .checked_add(vd_aux)
            .filter(|a| a + VERDAUX_SIZE <= vd_end)
            .and_then(|a| rd_u32(bytes, a))
        else {
            break;
        };
        // A definition whose name is not a string in the linked table is
        // not one, and neither is what follows it.
        let Some(name) = str_base
            .checked_add(vda_name as usize)
            .and_then(|at| cstr(bytes, at, str_end))
        else {
            break;
        };
        version_names.insert(vd_ndx, name);
        if vd_next < VERDEF_SIZE {
            break;
        }
        vd += vd_next;
    }

    // Walk the dynamic symbol table; for each defined symbol take the
    // version its versym entry names, unless that entry is hidden (a
    // non-default version).
    // The versym array is parallel to `.dynsym`, so the two must agree on
    // the stride; an entry size other than the ELF64 symbol's would pair
    // each name with another symbol's version.
    if dynsym.sh_entsize != SYM_SIZE as u64 {
        return None;
    }
    let (dynsym_base, dynsym_end) = extent(dynsym, bytes.len())?;
    let (dynstr_base, dynstr_end) = extent(dynstr, bytes.len())?;
    let (versym_base, versym_end) = extent(versym, bytes.len())?;
    let sym_count =
        ((dynsym_end - dynsym_base) / SYM_SIZE).min((versym_end - versym_base) / VERSYM_SIZE);
    let mut out: BTreeMap<String, String> = BTreeMap::new();
    for i in 0..sym_count {
        let sym = dynsym_base + i * SYM_SIZE;
        let st_name = rd_u32(bytes, sym)? as usize;
        let st_shndx = rd_u16(bytes, sym + 6)?;
        // Undefined entries are this library's own imports, not exports.
        if st_shndx == 0 || st_name == 0 {
            continue;
        }
        let raw = rd_u16(bytes, versym_base + i * VERSYM_SIZE)?;
        if raw & VERSYM_HIDDEN != 0 {
            continue;
        }
        let ndx = raw & VERSYM_VERSION;
        if ndx == VER_NDX_LOCAL || ndx == VER_NDX_GLOBAL {
            continue;
        }
        let Some(version) = version_names.get(&ndx) else {
            continue;
        };
        let Some(name) = dynstr_base
            .checked_add(st_name)
            .and_then(|at| cstr(bytes, at, dynstr_end))
        else {
            continue;
        };
        out.entry(name).or_insert_with(|| version.clone());
    }
    Some(out)
}

#[cfg(test)]
mod tests {
    use super::*;
    #[cfg(feature = "full")]
    use crate::c5::codegen::Target;
    #[cfg(feature = "full")]
    use crate::c5::linker::target_libc::library_bindings;
    #[cfg(feature = "full")]
    use alloc::vec::Vec;

    /// The manifest states a requirement for every name the headers can
    /// bind, so a binding added without regenerating it cannot fall back
    /// to a version the target's library does not define. `-` in the
    /// manifest is an entry: it records that the name carries none.
    ///
    /// The binding walk lives in the linker, so both directions of the
    /// check need that feature.
    #[cfg(feature = "full")]
    #[test]
    fn the_manifest_covers_every_linux_binding() {
        for (target, machine, table) in [
            (Target::LinuxX64, Machine::X86_64, manifest::X86_64),
            (Target::LinuxAarch64, Machine::Aarch64, manifest::AARCH64),
        ] {
            let mut missing: Vec<(String, String)> = Vec::new();
            for (soname, symbol) in library_bindings(target) {
                if table
                    .binary_search_by(|(s, n, _)| (*s, *n).cmp(&(soname.as_str(), symbol.as_str())))
                    .is_err()
                {
                    missing.push((soname, symbol));
                }
            }
            assert!(
                missing.is_empty(),
                "{machine:?}: libc/versions/ states no requirement for {missing:?}; \
                 regenerate with scripts/gen_elf_symbol_versions.py"
            );
        }
    }

    /// The reverse: an entry no header binds is stale data the link can
    /// never reach.
    #[cfg(feature = "full")]
    #[test]
    fn the_manifest_states_nothing_the_headers_do_not_bind() {
        for (target, table) in [
            (Target::LinuxX64, manifest::X86_64),
            (Target::LinuxAarch64, manifest::AARCH64),
        ] {
            let bound = library_bindings(target);
            let stale: Vec<&str> = table
                .iter()
                .filter(|(s, n, _)| {
                    !bound
                        .iter()
                        .any(|(soname, symbol)| soname == s && symbol == n)
                })
                .map(|(_, n, _)| *n)
                .collect();
            assert!(
                stale.is_empty(),
                "manifest entries no header binds: {stale:?}"
            );
        }
    }

    /// A symbol whose current definition postdates the library's base
    /// version has to carry that version: the loader accepts a
    /// definition at the base version index outright, so an unversioned
    /// reference to `memcpy` binds `memcpy@GLIBC_2.2.5` rather than the
    /// default `memcpy@@GLIBC_2.14`.
    #[test]
    fn a_symbol_past_the_base_version_keeps_its_own() {
        assert_eq!(
            manifest_version(Machine::X86_64, "libc.so.6", "memcpy"),
            Some("GLIBC_2.14")
        );
        assert_eq!(
            manifest_version(Machine::X86_64, "libc.so.6", "pthread_cond_init"),
            Some("GLIBC_2.3.2")
        );
    }

    /// A minimal ELF64 whose section table the caller shapes. Each entry
    /// is `(sh_type, sh_offset, sh_size, sh_link, sh_entsize)`.
    fn elf_with_sections(body: &[u8], sections: &[(u32, u64, u64, u32, u64)]) -> Vec<u8> {
        let mut out = alloc::vec![0u8; 64];
        out[..4].copy_from_slice(b"\x7fELF");
        out[4] = 2;
        out[5] = 1;
        out.extend_from_slice(body);
        let sh_off = out.len() as u64;
        for &(sh_type, offset, size, link, entsize) in sections {
            let mut e = alloc::vec![0u8; 64];
            e[4..8].copy_from_slice(&sh_type.to_le_bytes());
            e[24..32].copy_from_slice(&offset.to_le_bytes());
            e[32..40].copy_from_slice(&size.to_le_bytes());
            e[40..44].copy_from_slice(&link.to_le_bytes());
            e[56..64].copy_from_slice(&entsize.to_le_bytes());
            out.extend_from_slice(&e);
        }
        out[40..48].copy_from_slice(&sh_off.to_le_bytes());
        out[58..60].copy_from_slice(&64u16.to_le_bytes());
        out[60..62].copy_from_slice(&(sections.len() as u16).to_le_bytes());
        out
    }

    /// A version-definition table whose linked string table has no
    /// terminator yields nothing, and costs one lookup rather than one
    /// pass over the file per entry. The library is an input the command
    /// line names, so a malformed one must not decide how long the link
    /// takes.
    #[test]
    fn an_unterminated_string_table_ends_the_version_walk() {
        let blob = alloc::vec![0xAAu8; 1 << 20];
        let bytes = elf_with_sections(
            &blob,
            &[
                (0, 0, 0, 0, 0),
                (SHT_DYNSYM, 64, 24 * 4096, 2, SYM_SIZE as u64),
                (3, 64, blob.len() as u64, 0, 0),
                (SHT_GNU_VERSYM, 64, 2 * 4096, 1, VERSYM_SIZE as u64),
                (SHT_GNU_VERDEF, 64, 128 * 1024, 2, 0),
            ],
        );
        let start = std::time::Instant::now();
        assert!(parse_export_versions(&bytes).is_empty());
        assert!(
            start.elapsed().as_secs() < 5,
            "the walk scanned the file per entry"
        );
    }

    /// `.gnu.version` is parallel to `.dynsym`, so a symbol table with
    /// another entry size would pair each name with a different symbol's
    /// version. No version data is better than wrong version data.
    #[test]
    fn a_symbol_table_with_a_foreign_entry_size_yields_nothing() {
        let bytes = elf_with_sections(
            &alloc::vec![0u8; 4096],
            &[
                (0, 0, 0, 0, 0),
                (SHT_DYNSYM, 64, 4096, 2, 48),
                (3, 64, 4096, 0, 0),
                (SHT_GNU_VERSYM, 64, 512, 1, VERSYM_SIZE as u64),
                (SHT_GNU_VERDEF, 64, 20, 2, 0),
            ],
        );
        assert!(parse_export_versions(&bytes).is_empty());
    }

    /// A section that does not lie in the file names no bytes to read.
    #[test]
    fn a_section_table_outside_the_file_yields_nothing() {
        let bytes = elf_with_sections(
            &alloc::vec![0u8; 64],
            &[
                (0, 0, 0, 0, 0),
                (SHT_DYNSYM, u64::MAX - 8, 24, 2, SYM_SIZE as u64),
                (3, 64, 64, 0, 0),
                (SHT_GNU_VERSYM, 64, 8, 1, VERSYM_SIZE as u64),
                (SHT_GNU_VERDEF, 64, 20, 2, 0),
            ],
        );
        assert!(parse_export_versions(&bytes).is_empty());
    }

    /// A library with no version tables states no requirement, and a
    /// name the manifest does not carry resolves to none rather than to
    /// a neighbouring library's version.
    #[test]
    fn an_unversioned_library_and_an_unknown_name_carry_no_requirement() {
        assert_eq!(
            manifest_version(Machine::X86_64, "libdl.so.2", "dlopen"),
            None
        );
        assert_eq!(
            manifest_version(Machine::X86_64, "libc.so.6", "no_such_name"),
            None
        );
        assert_eq!(
            manifest_version(Machine::X86_64, "libnope.so.9", "memcpy"),
            None
        );
    }
}
