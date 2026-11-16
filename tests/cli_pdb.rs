//! Program databases for `-g` PE links.
//!
//! Each test links a small program for windows-x64 and windows-arm64 and
//! reads the image's debug directory and the PDB beside it directly: the
//! MSF stream directory, the PDB info stream, the DBI module list, a
//! module's CodeView symbols and C13 line table, and the TPI records.
//! When `llvm-pdbutil` / `llvm-readobj` are on PATH they read the same
//! files; a missing tool skips its check.

use std::path::{Path, PathBuf};
use std::process::Command;

mod common;
use common::TempDir;

const S_GPROC32: u16 = 0x1110;
const S_LPROC32: u16 = 0x110f;
const S_REGREL32: u16 = 0x1111;
const S_LOCAL: u16 = 0x113e;
const S_END: u16 = 0x0006;
const LF_STRUCTURE: u16 = 0x1505;
const LF_POINTER: u16 = 0x1002;
const LF_PROCEDURE: u16 = 0x1008;
const S_UDT: u16 = 0x1108;
const DEBUG_S_LINES: u32 = 0xf2;

const SOURCE: &str = "struct pair { int first; long second; struct pair *link; };\n\
typedef struct pair pair_t;\n\
static int bump(int v) {\n\
    int w = v + 1;\n\
    return w;\n\
}\n\
int main(void) {\n\
    pair_t p = { 1, 2, 0 };\n\
    int total = bump(p.first) + (int)p.second;\n\
    return total == 4 ? 0 : 1;\n\
}\n";

/// Each PE target, its COFF machine, and the CodeView number of its
/// frame pointer (cvconst.h `CV_AMD64_RBP`, `CV_ARM64_FP`).
const TARGETS: [(&str, u16, u16); 2] =
    [("windows-x64", 0x8664, 334), ("windows-arm64", 0xaa64, 79)];

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

fn link(dir: &Path, target: &str, extra: &[&str]) -> std::process::Output {
    link_source(dir, target, extra, SOURCE)
}

fn link_source(dir: &Path, target: &str, extra: &[&str], source: &str) -> std::process::Output {
    link_sources(dir, target, extra, &[("a.c", source)])
}

/// Link the units `sources` names into `dir/a.exe`.
fn link_sources(
    dir: &Path,
    target: &str,
    extra: &[&str],
    sources: &[(&str, &str)],
) -> std::process::Output {
    let mut srcs = Vec::new();
    for (name, text) in sources {
        srcs.push(dir.join(name));
        std::fs::write(dir.join(name), text).expect("write source");
    }
    let out = Command::new(badc())
        .arg("-q")
        .arg(format!("--target={target}"))
        .args(extra)
        .args(&srcs)
        .arg("-o")
        .arg(dir.join("a.exe"))
        .current_dir(dir)
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "{target}: link failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    out
}

fn u16le(b: &[u8], at: usize) -> u16 {
    u16::from_le_bytes(b[at..at + 2].try_into().unwrap())
}

fn u32le(b: &[u8], at: usize) -> u32 {
    u32::from_le_bytes(b[at..at + 4].try_into().unwrap())
}

fn cstr(b: &[u8], at: usize) -> String {
    let end = b[at..]
        .iter()
        .position(|&c| c == 0)
        .map_or(b.len(), |n| at + n);
    String::from_utf8_lossy(&b[at..end]).into_owned()
}

/// The image's CodeView debug record: GUID, age and PDB path, or `None`
/// when the debug directory is empty.
fn rsds(image: &[u8]) -> Option<([u8; 16], u32, String)> {
    let pe = u32le(image, 0x3c) as usize;
    let sections = u16le(image, pe + 6) as usize;
    let optional = pe + 24;
    let table = optional + u16le(image, pe + 20) as usize;
    // PE32+: the data directories start 112 bytes in; the debug one is
    // the seventh.
    let (rva, size) = (
        u32le(image, optional + 112 + 48),
        u32le(image, optional + 116 + 48),
    );
    if size == 0 {
        return None;
    }
    let file_off = (0..sections)
        .map(|i| table + 40 * i)
        .find_map(|h| {
            let (vsize, va, raw) = (
                u32le(image, h + 8),
                u32le(image, h + 12),
                u32le(image, h + 20),
            );
            (rva >= va && rva < va + vsize).then(|| (rva - va + raw) as usize)
        })
        .expect("the debug directory lies in a section");
    assert_eq!(u32le(image, file_off + 12), 2, "IMAGE_DEBUG_TYPE_CODEVIEW");
    let rec = u32le(image, file_off + 24) as usize;
    assert_eq!(&image[rec..rec + 4], b"RSDS");
    let guid = image[rec + 4..rec + 20].try_into().unwrap();
    Some((guid, u32le(image, rec + 20), cstr(image, rec + 24)))
}

/// The streams of an MSF file.
fn streams(pdb: &[u8]) -> Vec<Vec<u8>> {
    assert_eq!(&pdb[..24], b"Microsoft C/C++ MSF 7.00");
    let block = u32le(pdb, 32) as usize;
    assert_eq!(
        pdb.len(),
        u32le(pdb, 40) as usize * block,
        "the file is NumBlocks blocks"
    );
    let dir_len = u32le(pdb, 44) as usize;
    let map = u32le(pdb, 52) as usize * block;
    let mut dir = Vec::new();
    for k in 0..dir_len.div_ceil(block) {
        let b = u32le(pdb, map + 4 * k) as usize * block;
        dir.extend_from_slice(&pdb[b..b + block]);
    }
    let n = u32le(&dir, 0) as usize;
    let sizes: Vec<usize> = (0..n).map(|i| u32le(&dir, 4 + 4 * i) as usize).collect();
    let mut at = 4 + 4 * n;
    sizes
        .iter()
        .map(|&size| {
            let mut s = Vec::with_capacity(size);
            for _ in 0..size.div_ceil(block) {
                let b = u32le(&dir, at) as usize * block;
                at += 4;
                s.extend_from_slice(&pdb[b..b + block]);
            }
            s.truncate(size);
            s
        })
        .collect()
}

struct Module {
    name: String,
    stream: usize,
    sym_bytes: usize,
    c13_bytes: usize,
}

/// The DBI stream's machine and module list.
fn modules(dbi: &[u8]) -> (u16, Vec<Module>) {
    assert_eq!(u32le(dbi, 0), 0xffff_ffff);
    let modi_len = u32le(dbi, 24) as usize;
    let mut out = Vec::new();
    let mut at = 64;
    while at < 64 + modi_len {
        let name = cstr(dbi, at + 64);
        let obj_at = at + 64 + name.len() + 1;
        let obj = cstr(dbi, obj_at);
        out.push(Module {
            stream: u16le(dbi, at + 34) as usize,
            sym_bytes: u32le(dbi, at + 36) as usize,
            c13_bytes: u32le(dbi, at + 44) as usize,
            name,
        });
        at = (obj_at + obj.len() + 1).next_multiple_of(4);
    }
    (u16le(dbi, 58), out)
}

/// Each symbol record of a module stream: its offset, kind and body.
fn symbols(stream: &[u8], end: usize) -> Vec<(usize, u16, &[u8])> {
    assert_eq!(u32le(stream, 0), 4, "CV_SIGNATURE_C13");
    let mut out = Vec::new();
    let mut at = 4;
    while at < end {
        let len = u16le(stream, at) as usize;
        assert_eq!((len + 2) % 4, 0, "a module's records are 4-byte aligned");
        out.push((at, u16le(stream, at + 2), &stream[at + 4..at + 2 + len]));
        at += 2 + len;
    }
    out
}

/// One `DEBUG_S_LINES` subsection: the section offset, the code size and
/// each line entry's offset and line number.
type LineBlock = (u32, u32, Vec<(u32, u32)>);

fn line_blocks(c13: &[u8]) -> Vec<LineBlock> {
    let mut out = Vec::new();
    let mut at = 0;
    while at < c13.len() {
        let (kind, len) = (u32le(c13, at), u32le(c13, at + 4) as usize);
        let body = &c13[at + 8..at + 8 + len];
        if kind == DEBUG_S_LINES {
            let mut entries = Vec::new();
            let mut b = 12;
            while b < body.len() {
                let n = u32le(body, b + 4) as usize;
                for k in 0..n {
                    let e = b + 12 + 8 * k;
                    entries.push((u32le(body, e), u32le(body, e + 4) & 0x00ff_ffff));
                }
                b += u32le(body, b + 8) as usize;
            }
            out.push((u32le(body, 0), u32le(body, 8), entries));
        }
        at += (8 + len).next_multiple_of(4);
    }
    out
}

#[test]
fn a_debug_link_names_its_pdb_and_the_pdb_describes_the_program() {
    for (target, machine, frame_register) in TARGETS {
        let dir = TempDir::new(&format!("badc-pdb-{target}"));
        link(&dir, target, &["-g"]);
        let image = std::fs::read(dir.join("a.exe")).unwrap();
        let pdb = std::fs::read(dir.join("a.pdb")).expect("a.pdb beside a.exe");
        let (guid, age, path) = rsds(&image).expect("a debug directory entry");
        assert!(Path::new(&path).is_absolute(), "{target}: {path}");
        assert!(path.ends_with("a.pdb"), "{target}: {path}");
        let s = streams(&pdb);
        assert_eq!(
            &s[1][12..28],
            &guid,
            "{target}: the PDB info GUID is the image's"
        );
        assert_eq!(u32le(&s[1], 8), age);

        let (dbi_machine, mods) = modules(&s[3]);
        assert_eq!(dbi_machine, machine, "{target}");
        let m = (mods.iter())
            .find(|m| m.name.ends_with("a.c"))
            .unwrap_or_else(|| panic!("{target}: no module for a.c"));
        let stream = &s[m.stream];
        let syms = symbols(stream, m.sym_bytes);
        let proc_named = |want: &str| {
            syms.iter().find(|(_, kind, body)| {
                matches!(*kind, S_GPROC32 | S_LPROC32) && cstr(body, 35) == want
            })
        };
        let (main_at, main_kind, main_body) = *proc_named("main").expect("main");
        let (_, bump_kind, _) = *proc_named("bump").expect("bump");
        assert_eq!(
            (main_kind, bump_kind),
            (S_GPROC32, S_LPROC32),
            "{target}: linkage"
        );
        // pEnd names the procedure's S_END.
        let end = u32le(main_body, 4) as usize;
        assert!(
            syms.iter()
                .any(|&(at, kind, _)| at == end && kind == S_END && at > main_at)
        );
        let main_size = u32le(main_body, 12);
        // A frame slot is described off the frame pointer; a value no
        // slot holds is an `S_LOCAL` flagged optimized out.
        let locals: Vec<(String, Option<u16>)> = (syms.iter())
            .filter(|&&(at, _, _)| at > main_at && at < end)
            .filter_map(|&(_, kind, body)| match kind {
                S_REGREL32 => Some((cstr(body, 10), Some(u16le(body, 8)))),
                S_LOCAL if u16le(body, 4) & 0x100 != 0 => Some((cstr(body, 6), None)),
                _ => None,
            })
            .collect();
        assert!(
            locals.contains(&(String::from("p"), Some(frame_register))),
            "{target}: `p` off the frame pointer in {locals:?}"
        );
        assert!(
            locals
                .iter()
                .any(|(n, reg)| n == "total" && reg.is_none_or(|r| r == frame_register)),
            "{target}: no `total` in {locals:?}"
        );

        // main's line block starts at its first byte and stays inside it.
        let c13 = &stream[m.sym_bytes..m.sym_bytes + m.c13_bytes];
        let main_off = u32le(main_body, 28);
        let (_, size, entries) = (line_blocks(c13).into_iter())
            .find(|b| b.0 == main_off)
            .expect("a line block for main");
        assert_eq!(size, main_size);
        assert_eq!(
            entries[0].0, 0,
            "{target}: main's lines start at its first byte"
        );
        assert!(entries.windows(2).all(|w| w[0].0 <= w[1].0));
        assert!(entries.iter().all(|e| e.0 < size));
        // main spans lines 7 to 11; line 9 has code.
        assert!(
            entries.iter().all(|e| (7..=11).contains(&e.1)),
            "{target}: {entries:?}"
        );
        assert!(entries.iter().any(|e| e.1 == 9), "{target}: {entries:?}");

        // The struct's definition is in the TPI, apart from its forward
        // declaration.
        let tpi = &s[2];
        let mut at = u32le(tpi, 4) as usize;
        let mut defined = false;
        while at < tpi.len() {
            let len = u16le(tpi, at) as usize;
            let rec = &tpi[at..at + 2 + len];
            if u16le(rec, 2) == LF_STRUCTURE && u16le(rec, 6) & 0x80 == 0 {
                defined |= cstr(rec, 22) == "pair";
            }
            at += 2 + len;
        }
        assert!(defined, "{target}: `struct pair` is defined in the TPI");
    }
}

#[test]
fn the_pdb_is_the_same_on_a_rebuild() {
    for (target, ..) in TARGETS {
        let dir = TempDir::new(&format!("badc-pdb-rebuild-{target}"));
        link(&dir, target, &["-g"]);
        let first = (
            std::fs::read(dir.join("a.exe")),
            std::fs::read(dir.join("a.pdb")),
        );
        link(&dir, target, &["-g"]);
        let second = (
            std::fs::read(dir.join("a.exe")),
            std::fs::read(dir.join("a.pdb")),
        );
        assert_eq!(first.0.unwrap(), second.0.unwrap(), "{target}: image");
        assert_eq!(first.1.unwrap(), second.1.unwrap(), "{target}: PDB");
    }
}

/// The type records of a TPI stream, by index from 0x1000.
fn type_records(tpi: &[u8]) -> Vec<&[u8]> {
    let mut out = Vec::new();
    let mut at = u32le(tpi, 4) as usize;
    while at < tpi.len() {
        let len = u16le(tpi, at) as usize;
        out.push(&tpi[at..at + 2 + len]);
        at += 2 + len;
    }
    out
}

/// The `S_UDT` records of the symbol-record stream the DBI names: each
/// name and type index.
fn udts(s: &[Vec<u8>]) -> Vec<(String, u32)> {
    let records = &s[u16le(&s[3], 20) as usize];
    let mut out = Vec::new();
    let mut at = 0;
    while at < records.len() {
        let len = u16le(records, at) as usize;
        if u16le(records, at + 2) == S_UDT {
            out.push((cstr(records, at + 8), u32le(records, at + 4)));
        }
        at += 2 + len;
    }
    out
}

const OBJECT_HEADER: &str = "typedef struct _object PyObject;\n\
typedef struct _typeobject PyTypeObject;\n\
struct _object { long ob_refcnt; PyTypeObject *ob_type; };\n\
typedef PyObject *(*newfunc)(PyTypeObject *);\n\
PyObject *make(PyTypeObject *t);\n";

/// Two units sharing a self-referential struct pair, typedefs of them, and
/// function pointers whose return type is spelled with a typedef; one
/// unit completes `struct _typeobject`, the other leaves it incomplete. The
/// PDB holds one definition of each struct, and one `S_UDT` per typedef
/// naming the type the typedef stands for.
#[test]
fn units_sharing_a_typedef_of_a_struct_share_one_definition() {
    let a = String::from(OBJECT_HEADER)
        + "struct _typeobject {\n\
               PyObject ob_base;\n\
               const char *tp_name;\n\
               newfunc tp_new;\n\
               PyObject *(*tp_repr)(PyObject *);\n\
           };\n\
           static PyObject *repr(PyObject *o) { return o; }\n\
           PyTypeObject type_a = { { 1, 0 }, \"a\", 0, repr };\n\
           int main(void) { PyObject *o = make(&type_a); return o->ob_type == &type_a ? 0 : 1; }\n";
    let b = String::from(OBJECT_HEADER)
        + "static PyObject storage;\n\
           static PyObject *(*hook)(PyObject *);\n\
           PyObject *make(PyTypeObject *t) {\n\
               storage.ob_type = t;\n\
               return hook ? hook(&storage) : &storage;\n\
           }\n";
    for (target, ..) in TARGETS {
        let dir = TempDir::new(&format!("badc-pdb-merge-{target}"));
        link_sources(&dir, target, &["-g"], &[("a.c", &a), ("b.c", &b)]);
        let s = streams(&std::fs::read(dir.join("a.pdb")).expect("a.pdb"));
        let (_, mods) = modules(&s[3]);
        assert!(
            mods.iter().any(|m| m.name.ends_with("a.c"))
                && mods.iter().any(|m| m.name.ends_with("b.c"))
        );
        let types = type_records(&s[2]);
        let record = |ti: u32| types[(ti - 0x1000) as usize];
        let kind = |ti: u32| u16le(record(ti), 2);
        let definitions = |name: &str| {
            (types.iter())
                .filter(|r| {
                    u16le(r, 2) == LF_STRUCTURE && u16le(r, 6) & 0x80 == 0 && cstr(r, 22) == name
                })
                .count()
        };
        assert_eq!(definitions("_object"), 1, "{target}");
        assert_eq!(definitions("_typeobject"), 1, "{target}");
        let udts = udts(&s);
        let udt = |name: &str| {
            let found: Vec<u32> = udts.iter().filter(|u| u.0 == name).map(|u| u.1).collect();
            assert_eq!(found.len(), 1, "{target}: S_UDT {name}: {found:x?}");
            found[0]
        };
        for (name, tag) in [("PyObject", "_object"), ("PyTypeObject", "_typeobject")] {
            let ti = udt(name);
            assert_eq!(kind(ti), LF_STRUCTURE, "{target}: {name}");
            assert_eq!(
                u16le(record(ti), 6) & 0x80,
                0,
                "{target}: {name} names the definition"
            );
            assert_eq!(cstr(record(ti), 22), tag, "{target}");
        }
        let newfunc = udt("newfunc");
        assert_eq!(kind(newfunc), LF_POINTER, "{target}");
        assert_eq!(kind(u32le(record(newfunc), 4)), LF_PROCEDURE, "{target}");
    }
}

/// A structure without members (the GNU C extension) has an empty field
/// list, a record of its 4-byte prefix alone.
#[test]
fn a_structure_without_members_links_with_its_pdb() {
    let source = "struct empty {};\nstruct empty e;\nint main(void) { return 0; }\n";
    for (target, ..) in TARGETS {
        let dir = TempDir::new(&format!("badc-pdb-empty-{target}"));
        link_source(&dir, target, &["-g"], source);
        let s = streams(&std::fs::read(dir.join("a.pdb")).expect("a.pdb"));
        let (_, mods) = modules(&s[3]);
        assert!(mods.iter().any(|m| m.name.ends_with("a.c")), "{target}");
    }
}

/// An embedded runtime source is a module named by a relative path with
/// the target's separator, as the debugger shows a source location.
#[test]
fn an_embedded_source_module_is_named_by_a_relative_path() {
    let source = "#include <stdio.h>\nint main(void) { printf(\"%5.2f\\n\", 1.5); return 0; }\n";
    for (target, ..) in TARGETS {
        let dir = TempDir::new(&format!("badc-pdb-embedded-{target}"));
        link_source(&dir, target, &["-g"], source);
        let s = streams(&std::fs::read(dir.join("a.pdb")).expect("a.pdb"));
        let (_, mods) = modules(&s[3]);
        let names: Vec<&str> = mods.iter().map(|m| m.name.as_str()).collect();
        assert!(names.contains(&"runtime\\runtime.c"), "{target}: {names:?}");
        assert!(names.contains(&"libc\\printf_ext.c"), "{target}: {names:?}");
        assert!(
            !names.iter().any(|n| n.contains('<')),
            "{target}: {names:?}"
        );
    }
}

#[test]
fn no_pdb_without_debug_info() {
    for (target, ..) in TARGETS {
        for flags in [&[][..], &["-g", "-Wl,-S"][..]] {
            let dir = TempDir::new(&format!("badc-pdb-none-{target}"));
            link(&dir, target, flags);
            assert!(!dir.join("a.pdb").exists(), "{target} {flags:?}");
            let image = std::fs::read(dir.join("a.exe")).unwrap();
            assert!(
                rsds(&image).is_none(),
                "{target} {flags:?}: a debug directory"
            );
        }
    }
}

/// `llvm-pdbutil` reads every stream the brief names without an error,
/// and `llvm-readobj` finds the debug directory's PDB path.
#[test]
fn llvm_tools_read_the_pdb() {
    for (target, ..) in TARGETS {
        let dir = TempDir::new(&format!("badc-pdb-llvm-{target}"));
        link(&dir, target, &["-g"]);
        let pdb = dir.join("a.pdb");
        let dump = Command::new("llvm-pdbutil")
            .args([
                "dump", "-summary", "-streams", "-modules", "-symbols", "-types", "-ids",
            ])
            .args([
                "-l",
                "-publics",
                "-globals",
                "-section-contribs",
                "-section-map",
            ])
            .arg(&pdb)
            .output();
        if let Ok(out) = dump {
            let text = String::from_utf8_lossy(&out.stdout).into_owned()
                + &String::from_utf8_lossy(&out.stderr);
            assert!(out.status.success(), "{target}: {text}");
            assert!(!text.to_lowercase().contains("error"), "{target}: {text}");
            for want in [
                "S_GPROC32 [",
                "`main`",
                "S_LPROCREF",
                "S_PUB32",
                "LF_STRUCTURE",
                "a.c",
            ] {
                assert!(text.contains(want), "{target}: no {want} in\n{text}");
            }
        }
        let readobj = Command::new("llvm-readobj")
            .arg("--coff-debug-directory")
            .arg(dir.join("a.exe"))
            .output();
        if let Ok(out) = readobj {
            let text = String::from_utf8_lossy(&out.stdout);
            assert!(text.contains("PDBAge: 1"), "{target}: {text}");
            assert!(text.contains("a.pdb"), "{target}: {text}");
        }
    }
}
