//! Resolve the default GNU symbol version of each dynamic import by
//! reading the providing shared object's `.gnu.version_d` (Verdef),
//! `.gnu.version` (versym), and `.dynsym`.
//!
//! glibc exports several symbols under more than one version: an old
//! compatibility definition (`name@GLIBC_2.2.5`) and a current default
//! (`name@@GLIBC_2.3.2`). An undefined reference that carries no version
//! requirement does not reliably bind the default -- the dynamic linker
//! may select the compatibility definition, whose behaviour differs
//! (e.g. the old `pthread_cond_init` rejects a CLOCK_MONOTONIC condattr
//! with EINVAL). A real linker records a version requirement against the
//! symbol's default version; this module recovers that version so the
//! ELF writer can emit the matching `.gnu.version_r`.
//!
//! Host-library reading. The version a symbol exports is library- and
//! symbol-specific, so the providing `.so` must be read. This runs on
//! the link host against the host's libraries (the native case: the
//! build and run libc are the same). When a library cannot be located
//! or parsed, its imports are left unversioned -- the prior behaviour.

#![cfg(feature = "std")]

use alloc::collections::BTreeMap;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::codegen::Machine;

const SHT_DYNSYM: u32 = 11;
const SHT_GNU_VERDEF: u32 = 0x6fff_fffd;
const SHT_GNU_VERSYM: u32 = 0x6fff_ffff;
const EM_X86_64: u16 = 62;
const EM_AARCH64: u16 = 183;
const VER_NDX_LOCAL: u16 = 0;
const VER_NDX_GLOBAL: u16 = 1;
const VERSYM_HIDDEN: u16 = 0x8000;
const VERSYM_VERSION: u16 = 0x7fff;

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

fn cstr(b: &[u8], off: usize) -> Option<String> {
    let s = b.get(off..)?;
    let end = s.iter().position(|&c| c == 0).unwrap_or(s.len());
    Some(String::from_utf8_lossy(&s[..end]).into_owned())
}

struct Shdr {
    sh_type: u32,
    sh_offset: u64,
    sh_size: u64,
    sh_link: u32,
    sh_entsize: u64,
}

/// Parse one shared object, returning a map from exported symbol name
/// to its default version string. Only symbols whose default (non-
/// hidden) versym index references a real version definition (index
/// >= 2) are recorded; base/unversioned symbols are omitted.
fn parse_so_default_versions(
    bytes: &[u8],
    expect_machine: u16,
) -> Option<BTreeMap<String, String>> {
    // ELF64 little-endian only.
    if bytes.len() < 64 || &bytes[..4] != b"\x7fELF" || bytes[4] != 2 || bytes[5] != 1 {
        return None;
    }
    if rd_u16(bytes, 18)? != expect_machine {
        return None;
    }
    let e_shoff = rd_u64(bytes, 40)? as usize;
    let e_shentsize = rd_u16(bytes, 58)? as usize;
    let e_shnum = rd_u16(bytes, 60)? as usize;
    if e_shentsize < 64 {
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
    let verdef_str_base = verdef_str.sh_offset as usize;
    let mut version_names: BTreeMap<u16, String> = BTreeMap::new();
    let vd_section = verdef.sh_offset as usize;
    let mut vd_off = 0usize;
    loop {
        let vd = vd_section + vd_off;
        let vd_ndx = rd_u16(bytes, vd + 4)?;
        let vd_aux = rd_u32(bytes, vd + 12)? as usize;
        let vd_next = rd_u32(bytes, vd + 16)? as usize;
        let vda_name = rd_u32(bytes, vd + vd_aux)? as usize;
        if let Some(name) = cstr(bytes, verdef_str_base + vda_name) {
            version_names.insert(vd_ndx, name);
        }
        if vd_next == 0 {
            break;
        }
        vd_off += vd_next;
        if vd_off >= verdef.sh_size as usize {
            break;
        }
    }

    // Walk the dynamic symbol table; for each defined symbol take the
    // version its versym entry names, unless that entry is hidden (a
    // non-default version).
    let sym_count = (dynsym.sh_size / dynsym.sh_entsize.max(24)) as usize;
    let dynsym_base = dynsym.sh_offset as usize;
    let dynstr_base = dynstr.sh_offset as usize;
    let versym_base = versym.sh_offset as usize;
    let mut out: BTreeMap<String, String> = BTreeMap::new();
    for i in 0..sym_count {
        let sym = dynsym_base + i * 24;
        let st_name = rd_u32(bytes, sym)? as usize;
        let st_shndx = rd_u16(bytes, sym + 6)?;
        // Undefined entries are this library's own imports, not exports.
        if st_shndx == 0 || st_name == 0 {
            continue;
        }
        let raw = rd_u16(bytes, versym_base + i * 2)?;
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
        let Some(name) = cstr(bytes, dynstr_base + st_name) else {
            continue;
        };
        out.entry(name).or_insert_with(|| version.clone());
    }
    Some(out)
}

/// Standard search directories for a bare soname, ordered as the
/// platform's dynamic linker would prefer. `LD_LIBRARY_PATH` entries,
/// if any, take precedence.
fn search_dirs(machine: Machine) -> Vec<String> {
    let mut dirs: Vec<String> = Vec::new();
    if let Ok(p) = std::env::var("LD_LIBRARY_PATH") {
        for d in p.split(':').filter(|d| !d.is_empty()) {
            dirs.push(d.to_string());
        }
    }
    let fixed: &[&str] = match machine {
        Machine::X86_64 => &[
            "/lib/x86_64-linux-gnu",
            "/usr/lib/x86_64-linux-gnu",
            "/lib64",
            "/usr/lib64",
            "/lib",
            "/usr/lib",
        ],
        Machine::Aarch64 => &[
            "/lib/aarch64-linux-gnu",
            "/usr/lib/aarch64-linux-gnu",
            "/lib",
            "/usr/lib",
            "/lib64",
            "/usr/lib64",
        ],
    };
    for d in fixed {
        dirs.push(d.to_string());
    }
    dirs
}

fn locate_so(soname: &str, machine: Machine) -> Option<Vec<u8>> {
    if soname.contains('/') {
        return std::fs::read(soname).ok();
    }
    for dir in search_dirs(machine) {
        let path = alloc::format!("{dir}/{soname}");
        if let Ok(bytes) = std::fs::read(&path) {
            return Some(bytes);
        }
    }
    None
}

/// Resolve the default version of each import against its providing
/// library. Returns a vector parallel to `imports`: `Some((soname,
/// version))` when the symbol is a versioned default export, `None`
/// otherwise (unversioned symbol, or library not found / not parseable).
pub fn resolve_import_versions(
    imports: &[String],
    dylibs: &[String],
    import_dylib_map: &BTreeMap<String, u32>,
    machine: Machine,
) -> Vec<Option<(String, String)>> {
    let expect_machine = match machine {
        Machine::X86_64 => EM_X86_64,
        Machine::Aarch64 => EM_AARCH64,
    };
    // Parse each library at most once.
    let mut lib_versions: BTreeMap<String, Option<BTreeMap<String, String>>> = BTreeMap::new();
    let mut parse = |soname: &str| -> Option<BTreeMap<String, String>> {
        if let Some(cached) = lib_versions.get(soname) {
            return cached.clone();
        }
        let parsed = locate_so(soname, machine)
            .and_then(|bytes| parse_so_default_versions(&bytes, expect_machine));
        lib_versions.insert(soname.to_string(), parsed.clone());
        parsed
    };

    let mut out: Vec<Option<(String, String)>> = Vec::with_capacity(imports.len());
    for name in imports {
        // The import's recorded library, else any library that exports
        // the symbol (first match in declaration order).
        let mut resolved: Option<(String, String)> = None;
        let preferred = import_dylib_map
            .get(name)
            .and_then(|&idx| dylibs.get(idx as usize));
        let candidates = preferred
            .into_iter()
            .chain(dylibs.iter().filter(|s| Some(*s) != preferred));
        for soname in candidates {
            if let Some(version) = parse(soname).as_ref().and_then(|m| m.get(name)) {
                resolved = Some((soname.clone(), version.clone()));
                break;
            }
        }
        out.push(resolved);
    }
    out
}
