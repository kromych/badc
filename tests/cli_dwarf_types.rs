//! DWARF type-description tests for `-c -g` output.
//!
//! Each test compiles one translation unit to an ELF64 ET_REL object
//! with `--target=linux-x64` and reads the emitted `.debug_abbrev` +
//! `.debug_info` directly, so the assertions are on DIE tags and
//! attribute values rather than on a dumper's rendering. The target is
//! pinned so the tests run on any host.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};
use std::process::Command;

// ---- DWARF 4 constants the emitter uses ----

const DW_TAG_ARRAY_TYPE: u64 = 0x01;
const DW_TAG_ENUMERATION_TYPE: u64 = 0x04;
const DW_TAG_POINTER_TYPE: u64 = 0x0f;
const DW_TAG_STRUCTURE_TYPE: u64 = 0x13;
const DW_TAG_SUBROUTINE_TYPE: u64 = 0x15;
const DW_TAG_UNION_TYPE: u64 = 0x17;
const DW_TAG_UNSPECIFIED_PARAMETERS: u64 = 0x18;
const DW_TAG_SUBRANGE_TYPE: u64 = 0x21;
const DW_TAG_BASE_TYPE: u64 = 0x24;
const DW_TAG_MEMBER: u64 = 0x0d;
const DW_TAG_VARIABLE: u64 = 0x34;
const DW_TAG_FORMAL_PARAMETER: u64 = 0x05;
const DW_TAG_SUBPROGRAM: u64 = 0x2e;

const DW_AT_LOCATION: u64 = 0x02;
const DW_AT_NAME: u64 = 0x03;
const DW_AT_BYTE_SIZE: u64 = 0x0b;
const DW_AT_UPPER_BOUND: u64 = 0x2f;
const DW_AT_EXTERNAL: u64 = 0x3f;
const DW_AT_DECLARATION: u64 = 0x3c;
const DW_AT_TYPE: u64 = 0x49;
const DW_AT_DATA_MEMBER_LOCATION: u64 = 0x38;
const DW_AT_PROTOTYPED: u64 = 0x27;
const DW_AT_DECL_LINE: u64 = 0x3b;

const DW_OP_ADDR: u8 = 0x03;
const DW_OP_CONST8U: u8 = 0x0e;
const DW_OP_GNU_PUSH_TLS_ADDRESS: u8 = 0xe0;

// ---- driver ----

fn badc() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_badc"))
}

fn tempdir(name: &str) -> PathBuf {
    let mut p = std::env::temp_dir();
    p.push(format!("badc-dwarf-types-{name}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&p);
    std::fs::create_dir_all(&p).expect("create temp dir");
    p
}

/// Compile `body` to an ET_REL object with debug info and return its
/// parsed compile unit.
fn compile_unit(name: &str, body: &str) -> Unit {
    let dir = tempdir(name);
    let src = dir.join("a.c");
    std::fs::write(&src, body).expect("write source");
    let obj = dir.join("a.o");
    let out = Command::new(badc())
        .arg("-g")
        .arg("--gnu")
        .arg("--target=linux-x64")
        .arg("-c")
        .arg(&src)
        .arg("-o")
        .arg(&obj)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "compile failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let unit = parse_object(&obj);
    let _ = std::fs::remove_dir_all(&dir);
    unit
}

// ---- ELF + DWARF reading ----

fn u16le(b: &[u8], off: usize) -> u16 {
    u16::from_le_bytes([b[off], b[off + 1]])
}

fn u32le(b: &[u8], off: usize) -> u32 {
    u32::from_le_bytes([b[off], b[off + 1], b[off + 2], b[off + 3]])
}

fn u64le(b: &[u8], off: usize) -> u64 {
    let mut v = [0u8; 8];
    v.copy_from_slice(&b[off..off + 8]);
    u64::from_le_bytes(v)
}

/// The named section's runtime address, file offset and size in a
/// little-endian ELF64 object.
fn section_header(elf: &[u8], want: &str) -> (u64, usize, usize) {
    assert_eq!(&elf[..4], b"\x7fELF", "not an ELF object");
    let shoff = u64le(elf, 0x28) as usize;
    let shentsize = u16le(elf, 0x3a) as usize;
    let shnum = u16le(elf, 0x3c) as usize;
    let shstrndx = u16le(elf, 0x3e) as usize;
    let strtab = {
        let sh = shoff + shstrndx * shentsize;
        let off = u64le(elf, sh + 0x18) as usize;
        let size = u64le(elf, sh + 0x20) as usize;
        elf[off..off + size].to_vec()
    };
    for i in 0..shnum {
        let sh = shoff + i * shentsize;
        let name_off = u32le(elf, sh) as usize;
        let end = strtab[name_off..].iter().position(|&c| c == 0).unwrap();
        if &strtab[name_off..name_off + end] == want.as_bytes() {
            return (
                u64le(elf, sh + 0x10),
                u64le(elf, sh + 0x18) as usize,
                u64le(elf, sh + 0x20) as usize,
            );
        }
    }
    panic!("section {want} not found");
}

/// The named section's bytes.
fn section(elf: &[u8], want: &str) -> Vec<u8> {
    let (_, off, size) = section_header(elf, want);
    elf[off..off + size].to_vec()
}

struct Reader<'a> {
    b: &'a [u8],
    p: usize,
}

impl<'a> Reader<'a> {
    fn new(b: &'a [u8]) -> Self {
        Reader { b, p: 0 }
    }
    fn u8(&mut self) -> u8 {
        let v = self.b[self.p];
        self.p += 1;
        v
    }
    fn uleb(&mut self) -> u64 {
        let (mut v, mut shift) = (0u64, 0u32);
        loop {
            let byte = self.u8();
            v |= ((byte & 0x7f) as u64) << shift;
            if byte & 0x80 == 0 {
                return v;
            }
            shift += 7;
        }
    }
    fn sleb(&mut self) -> i64 {
        let (mut v, mut shift) = (0i64, 0u32);
        loop {
            let byte = self.u8();
            v |= ((byte & 0x7f) as i64) << shift;
            shift += 7;
            if byte & 0x80 == 0 {
                if shift < 64 && byte & 0x40 != 0 {
                    v |= -1i64 << shift;
                }
                return v;
            }
        }
    }
    fn take(&mut self, n: usize) -> &'a [u8] {
        let s = &self.b[self.p..self.p + n];
        self.p += n;
        s
    }
    fn cstr(&mut self) -> String {
        let start = self.p;
        while self.b[self.p] != 0 {
            self.p += 1;
        }
        let s = String::from_utf8_lossy(&self.b[start..self.p]).into_owned();
        self.p += 1;
        s
    }
}

#[derive(Clone)]
struct Abbrev {
    tag: u64,
    has_children: bool,
    attrs: Vec<(u64, u64)>,
}

fn parse_abbrev(bytes: &[u8]) -> BTreeMap<u64, Abbrev> {
    let mut out = BTreeMap::new();
    let mut r = Reader::new(bytes);
    loop {
        let code = r.uleb();
        if code == 0 {
            return out;
        }
        let tag = r.uleb();
        let has_children = r.u8() == 1;
        let mut attrs = Vec::new();
        loop {
            let (at, form) = (r.uleb(), r.uleb());
            if at == 0 && form == 0 {
                break;
            }
            attrs.push((at, form));
        }
        out.insert(
            code,
            Abbrev {
                tag,
                has_children,
                attrs,
            },
        );
    }
}

#[derive(Clone, Debug, PartialEq)]
enum Val {
    Str(String),
    Uint(u64),
    Int(i64),
    Ref(u32),
    Flag,
    Block(Vec<u8>),
}

impl Val {
    fn as_uint(&self) -> u64 {
        match self {
            Val::Uint(v) => *v,
            Val::Int(v) => *v as u64,
            other => panic!("expected an integer attribute, got {other:?}"),
        }
    }
    fn as_str(&self) -> &str {
        match self {
            Val::Str(s) => s,
            other => panic!("expected a string attribute, got {other:?}"),
        }
    }
    fn as_ref(&self) -> u32 {
        match self {
            Val::Ref(v) => *v,
            other => panic!("expected a reference attribute, got {other:?}"),
        }
    }
}

#[derive(Clone)]
struct Die {
    offset: u32,
    /// `.debug_info` offset of the owning compile unit's header.
    /// `DW_FORM_ref4` is relative to it.
    cu_base: u32,
    tag: u64,
    depth: usize,
    attrs: Vec<(u64, Val)>,
}

impl Die {
    fn at(&self, name: u64) -> Option<&Val> {
        self.attrs.iter().find(|(a, _)| *a == name).map(|(_, v)| v)
    }
    fn name(&self) -> Option<&str> {
        self.at(DW_AT_NAME).map(|v| v.as_str())
    }
}

struct Unit {
    dies: Vec<Die>,
}

impl Unit {
    /// The one DIE with `tag` and `DW_AT_name == name`.
    fn named(&self, tag: u64, name: &str) -> &Die {
        let mut it = self
            .dies
            .iter()
            .filter(|d| d.tag == tag && d.name() == Some(name));
        let found = it.next().unwrap_or_else(|| {
            panic!(
                "no DIE with tag 0x{tag:x} named `{name}`\n{}",
                self.render()
            )
        });
        assert!(
            it.next().is_none(),
            "more than one DIE with tag 0x{tag:x} named `{name}`"
        );
        found
    }

    fn find(&self, offset: u32) -> &Die {
        self.dies
            .iter()
            .find(|d| d.offset == offset)
            .unwrap_or_else(|| panic!("no DIE at 0x{offset:x}\n{}", self.render()))
    }

    /// The DIE `die`'s `DW_AT_type` names. `DW_FORM_ref4` is relative
    /// to the owning unit's header.
    fn type_of(&self, die: &Die) -> &Die {
        let r = die
            .at(DW_AT_TYPE)
            .unwrap_or_else(|| panic!("DIE has no DW_AT_type\n{}", self.render()))
            .as_ref();
        self.find(die.cu_base + r)
    }

    /// Direct children of `die`, in order.
    fn children(&self, die: &Die) -> Vec<&Die> {
        let start = self
            .dies
            .iter()
            .position(|d| d.offset == die.offset)
            .unwrap();
        self.dies[start + 1..]
            .iter()
            .take_while(|d| d.depth > die.depth)
            .filter(|d| d.depth == die.depth + 1)
            .collect()
    }

    fn members(&self, die: &Die) -> Vec<&Die> {
        self.children(die)
            .into_iter()
            .filter(|d| d.tag == DW_TAG_MEMBER)
            .collect()
    }

    fn member(&self, die: &Die, name: &str) -> &Die {
        self.members(die)
            .into_iter()
            .find(|d| d.name() == Some(name))
            .unwrap_or_else(|| {
                panic!(
                    "aggregate `{}` has no member `{name}`\n{}",
                    die.name().unwrap_or("<anon>"),
                    self.render()
                )
            })
    }

    fn render(&self) -> String {
        let mut s = String::new();
        for d in &self.dies {
            s.push_str(&format!(
                "0x{:04x}{:indent$} tag=0x{:x} {:?}\n",
                d.offset,
                "",
                d.tag,
                d.attrs,
                indent = d.depth * 2
            ));
        }
        s
    }
}

/// Walk every compile unit in the object's `.debug_info`. A `-c`
/// object holds one; a linked image holds the units it merged, each
/// with its own abbreviation table.
fn parse_object(path: &Path) -> Unit {
    let elf = std::fs::read(path).expect("read object");
    let info = section(&elf, ".debug_info");
    let abbrev_section = section(&elf, ".debug_abbrev");
    let mut dies = Vec::new();
    let mut cu_base = 0usize;
    while cu_base + 11 <= info.len() {
        // unit_length(4) + version(2) + abbrev_offset(4) + address_size(1).
        let unit_length = u32le(&info, cu_base) as usize;
        let unit_end = cu_base + 4 + unit_length;
        assert_eq!(u16le(&info, cu_base + 4), 4, "expected DWARF 4");
        let abbrev_off = u32le(&info, cu_base + 6) as usize;
        let addr_size = info[cu_base + 10] as usize;
        let abbrevs = parse_abbrev(&abbrev_section[abbrev_off..]);
        let mut r = Reader::new(&info);
        r.p = cu_base + 11;
        let mut depth = 0usize;
        while r.p < unit_end {
            let offset = r.p as u32;
            let code = r.uleb();
            if code == 0 {
                if depth == 0 {
                    break;
                }
                depth -= 1;
                continue;
            }
            let ab = abbrevs
                .get(&code)
                .unwrap_or_else(|| panic!("abbrev code {code} not in the table"));
            let mut attrs = Vec::new();
            for &(at, form) in &ab.attrs {
                let v = match form {
                    0x01 => Val::Uint(u64le(r.take(addr_size), 0)), // addr
                    0x06 => Val::Uint(u32le(r.take(4), 0) as u64),  // data4
                    0x07 => Val::Uint(u64le(r.take(8), 0)),         // data8
                    0x08 => Val::Str(r.cstr()),                     // string
                    0x0b => Val::Uint(r.u8() as u64),               // data1
                    0x0d => Val::Int(r.sleb()),                     // sdata
                    0x0f => Val::Uint(r.uleb()),                    // udata
                    0x13 => Val::Ref(u32le(r.take(4), 0)),          // ref4
                    0x17 => Val::Uint(u32le(r.take(4), 0) as u64),  // sec_offset
                    0x18 => {
                        let n = r.uleb() as usize;
                        Val::Block(r.take(n).to_vec())
                    } // exprloc
                    0x19 => Val::Flag,                              // flag_present
                    other => panic!("unhandled DW_FORM 0x{other:x}"),
                };
                attrs.push((at, v));
            }
            dies.push(Die {
                offset,
                cu_base: cu_base as u32,
                tag: ab.tag,
                depth,
                attrs,
            });
            if ab.has_children {
                depth += 1;
            }
        }
        cu_base = unit_end;
    }
    Unit { dies }
}

// ---- tests ----

/// A member whose type is only forward-declared here keeps its DIE:
/// the emitter resolves member type references through a layout pass,
/// so no emission order can drop one.
#[test]
fn member_of_forward_declared_pointer_type_is_emitted() {
    let u = compile_unit(
        "fwd-member",
        "struct opaque;\n\
         struct wrap { struct opaque *p; int x; };\n\
         int use(void) { struct wrap w; return w.x; }\n",
    );
    let wrap = u.named(DW_TAG_STRUCTURE_TYPE, "wrap");
    let names: Vec<_> = u.members(wrap).iter().map(|m| m.name().unwrap()).collect();
    assert_eq!(names, ["p", "x"]);
    let p = u.member(wrap, "p");
    assert_eq!(p.at(DW_AT_DATA_MEMBER_LOCATION).unwrap().as_uint(), 0);
    let ptr = u.type_of(p);
    assert_eq!(ptr.tag, DW_TAG_POINTER_TYPE);
    assert_eq!(u.type_of(ptr).name(), Some("opaque"));
}

/// Two aggregates that reach each other only through pointers both
/// keep every member, whichever order they are written in.
#[test]
fn mutually_recursive_aggregates_keep_every_member() {
    let u = compile_unit(
        "mutual",
        "struct b;\n\
         struct a { struct b *bp; int x; };\n\
         struct b { struct a *ap; int y; };\n\
         int use(void) { struct a s; struct b t; return s.x + t.y; }\n",
    );
    for (agg, want) in [("a", ["bp", "x"]), ("b", ["ap", "y"])] {
        let d = u.named(DW_TAG_STRUCTURE_TYPE, agg);
        let names: Vec<_> = u.members(d).iter().map(|m| m.name().unwrap()).collect();
        assert_eq!(names, want, "members of struct {agg}");
    }
}

/// `long long` has a base type; before it did not, and a member of
/// that type was dropped from its aggregate.
#[test]
fn long_long_member_has_a_base_type() {
    let u = compile_unit(
        "longlong",
        "struct s { long long a; unsigned long long b; };\n\
         int use(void) { struct s v; return (int)v.a; }\n",
    );
    let s = u.named(DW_TAG_STRUCTURE_TYPE, "s");
    let names: Vec<_> = u.members(s).iter().map(|m| m.name().unwrap()).collect();
    assert_eq!(names, ["a", "b"]);
    for (m, want) in [("a", "long long"), ("b", "unsigned long long")] {
        let t = u.type_of(u.member(s, m));
        assert_eq!(t.tag, DW_TAG_BASE_TYPE);
        assert_eq!(t.name(), Some(want));
        assert_eq!(t.at(DW_AT_BYTE_SIZE).unwrap().as_uint(), 8);
    }
}

/// An object with static storage duration gets a compile-unit-scope
/// `DW_TAG_variable`, and the types only it reaches get DIEs.
#[test]
fn static_storage_objects_get_a_variable_die() {
    let u = compile_unit(
        "globals",
        "struct only_global { int a; long b; char c; };\n\
         struct only_global g;\n\
         static struct only_global sg;\n\
         int touch(void) { return g.a + sg.a; }\n",
    );
    let g = u.named(DW_TAG_VARIABLE, "g");
    assert_eq!(g.depth, 1, "a file-scope object is a child of the CU");
    assert!(g.at(DW_AT_EXTERNAL).is_some(), "`g` has external linkage");
    assert_eq!(g.at(DW_AT_DECL_LINE).unwrap().as_uint(), 2);
    // DW_AT_location is DW_OP_addr over a target-sized address.
    let loc = match g.at(DW_AT_LOCATION).unwrap() {
        Val::Block(b) => b.clone(),
        other => panic!("expected an exprloc location, got {other:?}"),
    };
    assert_eq!(loc.len(), 9);
    assert_eq!(loc[0], DW_OP_ADDR);
    // The aggregate reached only through the two objects is described.
    let ty = u.type_of(g);
    assert_eq!(ty.tag, DW_TAG_STRUCTURE_TYPE);
    assert_eq!(ty.name(), Some("only_global"));
    let names: Vec<_> = u.members(ty).iter().map(|m| m.name().unwrap()).collect();
    assert_eq!(names, ["a", "b", "c"]);

    let sg = u.named(DW_TAG_VARIABLE, "sg");
    assert!(
        sg.at(DW_AT_EXTERNAL).is_none(),
        "`static` has internal linkage, so no DW_AT_external"
    );
    assert_eq!(
        sg.at(DW_AT_TYPE).unwrap().as_ref(),
        g.at(DW_AT_TYPE).unwrap().as_ref()
    );
}

/// An aggregate the source left unnamed carries no `DW_AT_name`; a
/// synthesized one would carry a parse-order serial that names the
/// same type differently in two units.
#[test]
fn anonymous_aggregates_have_no_name() {
    let u = compile_unit(
        "anon",
        "struct outer { int head; struct { int x; union { int u; long v; } in2; } inner; };\n\
         int use(void) { struct outer o; o.head = 0; return o.inner.x; }\n",
    );
    let outer = u.named(DW_TAG_STRUCTURE_TYPE, "outer");
    let inner = u.type_of(u.member(outer, "inner"));
    assert_eq!(inner.tag, DW_TAG_STRUCTURE_TYPE);
    assert_eq!(inner.name(), None, "an untagged struct has no DW_AT_name");
    assert_eq!(inner.at(DW_AT_BYTE_SIZE).unwrap().as_uint(), 16);
    let in2 = u.type_of(u.member(inner, "in2"));
    assert_eq!(in2.tag, DW_TAG_UNION_TYPE);
    assert_eq!(in2.name(), None, "an untagged union has no DW_AT_name");
    // Nothing anywhere in the unit carries a synthesized tag.
    for d in &u.dies {
        if let Some(n) = d.name() {
            assert!(
                !n.starts_with("__anon_") && !n.starts_with("__anon_struct") && !n.contains("_in_"),
                "synthesized tag `{n}` reached the DWARF"
            );
        }
    }
}

/// An array member is described by an array type over the element
/// type, with one subrange per dimension.
#[test]
fn array_members_are_described_as_arrays() {
    let u = compile_unit(
        "arrays",
        "struct elem { int a; int b; };\n\
         struct holder { struct elem arr[8]; int m2[3][4]; int tail; };\n\
         int use(void) { struct holder h; return h.arr[0].a + h.tail; }\n",
    );
    let holder = u.named(DW_TAG_STRUCTURE_TYPE, "holder");
    let arr = u.type_of(u.member(holder, "arr"));
    assert_eq!(arr.tag, DW_TAG_ARRAY_TYPE);
    assert_eq!(u.type_of(arr).name(), Some("elem"));
    let bounds: Vec<u64> = u
        .children(arr)
        .iter()
        .map(|d| {
            assert_eq!(d.tag, DW_TAG_SUBRANGE_TYPE);
            d.at(DW_AT_UPPER_BOUND).unwrap().as_uint()
        })
        .collect();
    assert_eq!(bounds, [7], "DW_AT_upper_bound is the last in-bounds index");

    // A multidimensional member is one array type with one subrange
    // per dimension, outermost first.
    let m2 = u.type_of(u.member(holder, "m2"));
    assert_eq!(m2.tag, DW_TAG_ARRAY_TYPE);
    assert_eq!(u.type_of(m2).name(), Some("int"));
    let bounds: Vec<u64> = u
        .children(m2)
        .iter()
        .map(|d| d.at(DW_AT_UPPER_BOUND).unwrap().as_uint())
        .collect();
    assert_eq!(bounds, [2, 3]);
}

/// A flexible array member's extent is unknown, which DWARF spells as
/// a subrange with no bound rather than as a one-element array.
#[test]
fn flexible_array_member_has_an_unbounded_subrange() {
    let u = compile_unit(
        "flex",
        "struct flex { int n; char data[]; };\n\
         int use(void) { struct flex f; return f.n; }\n",
    );
    let flex = u.named(DW_TAG_STRUCTURE_TYPE, "flex");
    let data = u.type_of(u.member(flex, "data"));
    assert_eq!(data.tag, DW_TAG_ARRAY_TYPE);
    assert_eq!(u.type_of(data).name(), Some("char"));
    let subranges = u.children(data);
    assert_eq!(subranges.len(), 1);
    assert_eq!(subranges[0].tag, DW_TAG_SUBRANGE_TYPE);
    assert!(
        subranges[0].at(DW_AT_UPPER_BOUND).is_none(),
        "an unspecified bound carries no DW_AT_upper_bound"
    );
}

/// A type the unit only forward-declares is a declaration, not a
/// zero-sized definition: absent `DW_AT_byte_size` means unknown,
/// while `DW_AT_byte_size (0)` means empty.
#[test]
fn forward_declared_aggregate_is_a_declaration() {
    let u = compile_unit(
        "declaration",
        "struct opaque;\n\
         union uopaque;\n\
         struct wrap { struct opaque *p; union uopaque *q; int x; };\n\
         int use(void) { struct wrap w; return w.x; }\n",
    );
    for (tag, name) in [
        (DW_TAG_STRUCTURE_TYPE, "opaque"),
        (DW_TAG_UNION_TYPE, "uopaque"),
    ] {
        let d = u.named(tag, name);
        assert!(
            d.at(DW_AT_DECLARATION).is_some(),
            "`{name}` is incomplete here, so it carries DW_AT_declaration"
        );
        assert!(
            d.at(DW_AT_BYTE_SIZE).is_none(),
            "`{name}` has no known size, so it carries no DW_AT_byte_size"
        );
        assert!(u.members(d).is_empty());
    }
    // A complete empty aggregate keeps a size and no declaration flag.
    let wrap = u.named(DW_TAG_STRUCTURE_TYPE, "wrap");
    assert!(wrap.at(DW_AT_DECLARATION).is_none());
    assert_eq!(wrap.at(DW_AT_BYTE_SIZE).unwrap().as_uint(), 24);
}

/// A function-pointer member points at a subroutine type carrying the
/// signature, not at the return type.
#[test]
fn function_pointer_members_have_a_subroutine_type() {
    let u = compile_unit(
        "fnptr",
        "struct ops {\n\
           int (*fn)(int, char *);\n\
           void (*vfn)(void);\n\
           int (*var)(const char *, ...);\n\
           int (**ppfn)(int);\n\
           int x;\n\
         };\n\
         int use(void) { struct ops o; return o.x; }\n",
    );
    let ops = u.named(DW_TAG_STRUCTURE_TYPE, "ops");

    let fn_ptr = u.type_of(u.member(ops, "fn"));
    assert_eq!(fn_ptr.tag, DW_TAG_POINTER_TYPE);
    assert_eq!(fn_ptr.at(DW_AT_BYTE_SIZE).unwrap().as_uint(), 8);
    let sub = u.type_of(fn_ptr);
    assert_eq!(sub.tag, DW_TAG_SUBROUTINE_TYPE);
    assert!(sub.at(DW_AT_PROTOTYPED).is_some());
    assert_eq!(u.type_of(sub).name(), Some("int"), "return type");
    let params = u.children(sub);
    assert_eq!(params.len(), 2);
    assert!(params.iter().all(|p| p.tag == DW_TAG_FORMAL_PARAMETER));
    assert_eq!(u.type_of(params[0]).name(), Some("int"));
    assert_eq!(u.type_of(u.type_of(params[1])).name(), Some("char"));

    // `void (*)(void)`: no return type, no parameters.
    let vsub = u.type_of(u.type_of(u.member(ops, "vfn")));
    assert_eq!(vsub.tag, DW_TAG_SUBROUTINE_TYPE);
    assert!(
        vsub.at(DW_AT_TYPE).is_none(),
        "a void-returning subroutine type has no DW_AT_type"
    );
    assert!(u.children(vsub).is_empty());

    // The trailing `...` of a variadic prototype.
    let vasub = u.type_of(u.type_of(u.member(ops, "var")));
    let kinds: Vec<u64> = u.children(vasub).iter().map(|d| d.tag).collect();
    assert_eq!(
        kinds,
        [DW_TAG_FORMAL_PARAMETER, DW_TAG_UNSPECIFIED_PARAMETERS]
    );

    // A pointer to a function pointer keeps both levels.
    let pp = u.type_of(u.member(ops, "ppfn"));
    assert_eq!(pp.tag, DW_TAG_POINTER_TYPE);
    let inner = u.type_of(pp);
    assert_eq!(inner.tag, DW_TAG_POINTER_TYPE);
    assert_eq!(u.type_of(inner).tag, DW_TAG_SUBROUTINE_TYPE);
}

/// `void *` is a pointer with no `DW_AT_type`, not a pointer to a
/// character type.
#[test]
fn void_pointer_has_no_pointee_type() {
    let u = compile_unit(
        "voidptr",
        "struct vp { void *p; char *c; int y; };\n\
         int use(void) { struct vp v; return v.y; }\n",
    );
    let vp = u.named(DW_TAG_STRUCTURE_TYPE, "vp");
    let p = u.type_of(u.member(vp, "p"));
    assert_eq!(p.tag, DW_TAG_POINTER_TYPE);
    assert!(
        p.at(DW_AT_TYPE).is_none(),
        "an untyped pointer carries no DW_AT_type"
    );
    let c = u.type_of(u.member(vp, "c"));
    assert_eq!(u.type_of(c).name(), Some("char"));
}

/// After a badc link, a static-storage object's `DW_OP_addr` holds the
/// object's runtime address: the linker defers the data-image slot the
/// way it defers a text one, and the writer commits it. Covers an
/// internal-linkage object in a second translation unit, whose address
/// only the link resolves.
#[test]
fn linked_image_locations_name_the_object() {
    let dir = tempdir("linked-globals");
    let a = dir.join("a.c");
    let b = dir.join("b.c");
    std::fs::write(
        &a,
        "struct rec { int a; long b; };\n\
         struct rec g_data = { 1, 2 };\n\
         extern int helper(void);\n\
         int main(void) { return helper() + g_data.a; }\n",
    )
    .expect("write a.c");
    std::fs::write(
        &b,
        "static int counter = 7;\nint helper(void) { return counter; }\n",
    )
    .expect("write b.c");
    for src in [&a, &b] {
        let out = Command::new(badc())
            .arg("-g")
            .arg("--target=linux-x64")
            .arg("-c")
            .arg(src)
            .current_dir(&dir)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "compile failed: {}",
            String::from_utf8_lossy(&out.stderr)
        );
    }
    let exe = dir.join("prog");
    let out = Command::new(badc())
        .arg("-g")
        .arg("--target=linux-x64")
        .arg("-o")
        .arg(&exe)
        .arg(dir.join("a.o"))
        .arg(dir.join("b.o"))
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "link failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let elf = std::fs::read(&exe).expect("read image");
    let u = parse_object(&exe);
    let (data_addr, data_off, data_size) = section_header(&elf, ".data");
    // `struct rec { int a; long b; }` initialized to { 1, 2 }, and a
    // second unit's `static int counter = 7`.
    for (name, want) in [("g_data", vec![1i64, 2]), ("counter", vec![7])] {
        let v = u.named(DW_TAG_VARIABLE, name);
        let loc = match v.at(DW_AT_LOCATION).unwrap() {
            Val::Block(bytes) => bytes.clone(),
            other => panic!("expected an exprloc location, got {other:?}"),
        };
        assert_eq!(loc[0], DW_OP_ADDR);
        let addr = u64le(&loc, 1);
        assert!(
            (data_addr..data_addr + data_size as u64).contains(&addr),
            "`{name}` at 0x{addr:x} is outside .data [0x{data_addr:x}, \
             0x{:x})",
            data_addr + data_size as u64
        );
        let at = data_off + (addr - data_addr) as usize;
        assert_eq!(u32le(&elf, at) as i64, want[0], "`{name}` first word");
        if want.len() > 1 {
            assert_eq!(u64le(&elf, at + 8) as i64, want[1], "`{name}` second");
        }
    }
}

/// Every member of every aggregate in the unit is described, and the
/// enum DIEs the emitter writes after the type block stay intact.
#[test]
fn no_member_is_dropped_and_enums_survive() {
    let u = compile_unit(
        "coverage",
        "enum color { RED = 0, GREEN = 1 };\n\
         struct deep;\n\
         struct wide {\n\
           struct deep *d; long long ll; void *v; char s[4];\n\
           int (*cb)(void); unsigned bits : 3; enum color col;\n\
         };\n\
         struct deep { struct wide *w; int z; };\n\
         int use(void) { struct wide x; return x.ll != 0; }\n",
    );
    let wide = u.named(DW_TAG_STRUCTURE_TYPE, "wide");
    let names: Vec<_> = u.members(wide).iter().map(|m| m.name().unwrap()).collect();
    assert_eq!(names, ["d", "ll", "v", "s", "cb", "bits", "col"]);
    let deep = u.named(DW_TAG_STRUCTURE_TYPE, "deep");
    let names: Vec<_> = u.members(deep).iter().map(|m| m.name().unwrap()).collect();
    assert_eq!(names, ["w", "z"]);
    let color = u.named(DW_TAG_ENUMERATION_TYPE, "color");
    assert_eq!(u.children(color).len(), 2);
}

/// C11 6.7.2.1p13 promotes an anonymous struct's or union's members
/// into the enclosing aggregate's namespace. The description keeps the
/// nesting: an unnamed `DW_TAG_member` whose type is the anonymous
/// aggregate, at the offset the promoted members start from.
#[test]
fn anonymous_members_nest_under_an_unnamed_member() {
    let u = compile_unit(
        "anon-member",
        "struct outer2 {\n\
           int head;\n\
           union { int a; long b; };\n\
           struct { int c; int d; };\n\
           int tail;\n\
         };\n\
         struct outer2 g_outer;\n\
         int use(void) { return g_outer.a + g_outer.c; }\n",
    );
    let outer = u.named(DW_TAG_STRUCTURE_TYPE, "outer2");
    let members = u.members(outer);
    let shape: Vec<(Option<&str>, u64)> = members
        .iter()
        .map(|m| {
            (
                m.name(),
                m.at(DW_AT_DATA_MEMBER_LOCATION).unwrap().as_uint(),
            )
        })
        .collect();
    assert_eq!(
        shape,
        [(Some("head"), 0), (None, 8), (None, 16), (Some("tail"), 24)]
    );
    let anon_union = u.type_of(members[1]);
    assert_eq!(anon_union.tag, DW_TAG_UNION_TYPE);
    assert_eq!(anon_union.name(), None);
    assert_eq!(anon_union.at(DW_AT_BYTE_SIZE).unwrap().as_uint(), 8);
    let names: Vec<_> = u
        .members(anon_union)
        .iter()
        .map(|m| m.name().unwrap())
        .collect();
    assert_eq!(names, ["a", "b"]);
    let anon_struct = u.type_of(members[2]);
    assert_eq!(anon_struct.tag, DW_TAG_STRUCTURE_TYPE);
    assert_eq!(anon_struct.name(), None);
    let placed: Vec<(&str, u64)> = u
        .members(anon_struct)
        .iter()
        .map(|m| {
            (
                m.name().unwrap(),
                m.at(DW_AT_DATA_MEMBER_LOCATION).unwrap().as_uint(),
            )
        })
        .collect();
    assert_eq!(placed, [("c", 0), ("d", 4)]);
}

/// One anonymous aggregate nested in another keeps both levels, in
/// either tag order, with each level's members placed against the
/// level that holds them.
#[test]
fn nested_anonymous_members_keep_every_level() {
    let u = compile_unit(
        "anon-nested",
        "struct nest { int head; struct { union { int x; long y; }; int z; }; int tail; };\n\
         struct unest { int head; union { struct { int p; int q; }; long r; }; int tail; };\n\
         struct nest g_nest;\n\
         struct unest g_unest;\n\
         int use(void) { return g_nest.x + g_nest.z + g_unest.p + (int)g_unest.r; }\n",
    );
    let nest = u.members(u.named(DW_TAG_STRUCTURE_TYPE, "nest"));
    assert_eq!(nest.len(), 3);
    assert_eq!(nest[1].at(DW_AT_DATA_MEMBER_LOCATION).unwrap().as_uint(), 8);
    let inner = u.type_of(nest[1]);
    assert_eq!(inner.tag, DW_TAG_STRUCTURE_TYPE);
    let inner_members = u.members(inner);
    assert_eq!(inner_members.len(), 2);
    assert_eq!(inner_members[0].name(), None);
    assert_eq!(
        inner_members[0]
            .at(DW_AT_DATA_MEMBER_LOCATION)
            .unwrap()
            .as_uint(),
        0
    );
    assert_eq!(inner_members[1].name(), Some("z"));
    let deepest = u.type_of(inner_members[0]);
    assert_eq!(deepest.tag, DW_TAG_UNION_TYPE);
    let names: Vec<_> = u
        .members(deepest)
        .iter()
        .map(|m| m.name().unwrap())
        .collect();
    assert_eq!(names, ["x", "y"]);

    let unest = u.members(u.named(DW_TAG_STRUCTURE_TYPE, "unest"));
    assert_eq!(unest.len(), 3);
    let arm = u.type_of(unest[1]);
    assert_eq!(arm.tag, DW_TAG_UNION_TYPE);
    let arms = u.members(arm);
    assert_eq!(arms.len(), 2);
    assert_eq!(arms[0].name(), None);
    assert_eq!(arms[1].name(), Some("r"));
    assert_eq!(u.type_of(arms[0]).tag, DW_TAG_STRUCTURE_TYPE);
}

/// `DW_AT_external` says the name is visible outside the compilation
/// unit (DWARF 4 3.3.1), which C99 6.2.2p3 denies a `static`
/// definition.
#[test]
fn static_function_has_no_external_attribute() {
    let u = compile_unit(
        "linkage",
        "static int stat_fn(void) { return 1; }\n\
         static int stat_local(int n) { int t = n; return t; }\n\
         int touch(void) { return stat_fn() + stat_local(2); }\n",
    );
    for name in ["stat_fn", "stat_local"] {
        assert!(
            u.named(DW_TAG_SUBPROGRAM, name)
                .at(DW_AT_EXTERNAL)
                .is_none(),
            "`{name}` has internal linkage, so no DW_AT_external"
        );
    }
    assert!(
        u.named(DW_TAG_SUBPROGRAM, "touch")
            .at(DW_AT_EXTERNAL)
            .is_some(),
        "`touch` has external linkage"
    );
}

/// A function-pointer parameter or local is a pointer to a
/// `DW_TAG_subroutine_type`, not a pointer to the return type, and a
/// multidimensional local array carries one subrange per dimension.
#[test]
fn function_pointer_locals_have_a_subroutine_type() {
    let u = compile_unit(
        "fnptr-local",
        "int apply(int (*fn)(int, long), int x) {\n\
           int (*g)(int, long) = fn;\n\
           int m[3][4];\n\
           m[2][3] = x;\n\
           return g(x, 1) + m[2][3];\n\
         }\n",
    );
    let apply = u.named(DW_TAG_SUBPROGRAM, "apply");
    let child = |tag: u64, name: &str| {
        u.children(apply)
            .into_iter()
            .find(|d| d.tag == tag && d.name() == Some(name))
            .unwrap_or_else(|| panic!("`apply` has no child `{name}`"))
    };
    let fn_param = child(DW_TAG_FORMAL_PARAMETER, "fn");
    let local = child(DW_TAG_VARIABLE, "g");
    assert_eq!(
        fn_param.at(DW_AT_TYPE).unwrap().as_ref(),
        local.at(DW_AT_TYPE).unwrap().as_ref(),
        "the parameter and the local have one type"
    );
    let ptr = u.type_of(fn_param);
    assert_eq!(ptr.tag, DW_TAG_POINTER_TYPE);
    let sub = u.type_of(ptr);
    assert_eq!(sub.tag, DW_TAG_SUBROUTINE_TYPE);
    assert!(sub.at(DW_AT_PROTOTYPED).is_some());
    assert_eq!(u.type_of(sub).name(), Some("int"), "return type");
    let params: Vec<&str> = u
        .children(sub)
        .into_iter()
        .filter(|d| d.tag == DW_TAG_FORMAL_PARAMETER)
        .map(|d| u.type_of(d).name().unwrap())
        .collect();
    assert_eq!(params, ["int", "long"]);

    let arr = u.type_of(child(DW_TAG_VARIABLE, "m"));
    assert_eq!(arr.tag, DW_TAG_ARRAY_TYPE);
    let bounds: Vec<u64> = u
        .children(arr)
        .into_iter()
        .filter(|d| d.tag == DW_TAG_SUBRANGE_TYPE)
        .map(|d| d.at(DW_AT_UPPER_BOUND).unwrap().as_uint())
        .collect();
    assert_eq!(bounds, [2, 3]);
}

/// A `_Thread_local` object (C11 6.2.4p4) gets a compile-unit-scope
/// `DW_TAG_variable` like any other object with static storage
/// duration. On the ELF x86_64 surface its location pushes the
/// thread-block offset and lets the consumer add the thread pointer.
#[test]
fn thread_local_objects_get_a_variable_die() {
    let u = compile_unit(
        "tls",
        "_Thread_local int tls_v = 3;\n\
         static _Thread_local long tls_s;\n\
         int touch(void) { return tls_v + (int)tls_s; }\n",
    );
    let v = u.named(DW_TAG_VARIABLE, "tls_v");
    assert_eq!(v.depth, 1, "a file-scope object is a child of the CU");
    assert!(v.at(DW_AT_EXTERNAL).is_some());
    assert_eq!(u.type_of(v).name(), Some("int"));
    let loc = match v.at(DW_AT_LOCATION).unwrap() {
        Val::Block(b) => b.clone(),
        other => panic!("expected an exprloc location, got {other:?}"),
    };
    assert_eq!(loc.len(), 10);
    assert_eq!(loc[0], DW_OP_CONST8U);
    assert_eq!(loc[9], DW_OP_GNU_PUSH_TLS_ADDRESS);

    let s = u.named(DW_TAG_VARIABLE, "tls_s");
    assert!(
        s.at(DW_AT_EXTERNAL).is_none(),
        "`static` has internal linkage, so no DW_AT_external"
    );
    assert_eq!(u.type_of(s).name(), Some("long"));
}
