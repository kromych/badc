//! CodeView type and symbol records, and the C13 line and file-checksum
//! subsections, for the debug model. The record layouts and constants are
//! those of Microsoft's `cvinfo.h`; the records take the forms a PDB
//! holds (`S_GPROC32` over a `LF_PROCEDURE`, closed by `S_END`).

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::string::String;
use alloc::vec::Vec;

use super::Machine;
use super::debug_model::{
    DebugInfo, Encoding, Function, Location, Member, Qualifier, Register, Scope, TagKind, Type,
    TypeId, TypeRef, Unit,
};

pub(crate) const FIRST_TYPE_INDEX: u32 = 0x1000;

// Simple type indices (cvinfo.h `TYPE_ENUM_e`).
const T_NOTYPE: u32 = 0x0000;
const T_VOID: u32 = 0x0003;
const T_CHAR: u32 = 0x0010;
const T_SHORT: u32 = 0x0011;
const T_LONG: u32 = 0x0012;
const T_QUAD: u32 = 0x0013;
const T_UCHAR: u32 = 0x0020;
const T_USHORT: u32 = 0x0021;
const T_ULONG: u32 = 0x0022;
const T_UQUAD: u32 = 0x0023;
const T_BOOL08: u32 = 0x0030;
const T_REAL32: u32 = 0x0040;
const T_REAL64: u32 = 0x0041;
const T_REAL80: u32 = 0x0042;
const T_REAL128: u32 = 0x0043;
const T_RCHAR: u32 = 0x0070;
const T_INT4: u32 = 0x0074;
const T_UINT4: u32 = 0x0075;
const T_INT8: u32 = 0x0076;
const T_UINT8: u32 = 0x0077;
const T_INT16: u32 = 0x0078;
const T_UINT16: u32 = 0x0079;
/// The pointer mode bits of a simple type index: a 32-bit and a 64-bit
/// near pointer to the type.
const T_MODE_32: u32 = 0x0400;
const T_MODE_64: u32 = 0x0600;

// Type record leaves (cvinfo.h `LEAF_ENUM_e`).
pub(crate) const LF_MODIFIER: u16 = 0x1001;
pub(crate) const LF_POINTER: u16 = 0x1002;
pub(crate) const LF_PROCEDURE: u16 = 0x1008;
pub(crate) const LF_ARGLIST: u16 = 0x1201;
pub(crate) const LF_FIELDLIST: u16 = 0x1203;
pub(crate) const LF_INDEX: u16 = 0x1404;
pub(crate) const LF_BITFIELD: u16 = 0x1205;
pub(crate) const LF_ENUMERATE: u16 = 0x1502;
pub(crate) const LF_ARRAY: u16 = 0x1503;
pub(crate) const LF_STRUCTURE: u16 = 0x1505;
pub(crate) const LF_UNION: u16 = 0x1506;
pub(crate) const LF_ENUM: u16 = 0x1507;
pub(crate) const LF_MEMBER: u16 = 0x150d;
pub(crate) const LF_FUNC_ID: u16 = 0x1601;
const LF_CHAR: u16 = 0x8000;
const LF_SHORT: u16 = 0x8001;
const LF_USHORT: u16 = 0x8002;
const LF_LONG: u16 = 0x8003;
const LF_ULONG: u16 = 0x8004;
const LF_QUADWORD: u16 = 0x8009;
const LF_UQUADWORD: u16 = 0x800a;

/// `CV_prop_t`: a forward reference.
const PROP_FWDREF: u16 = 0x0080;
/// `CV_fldattr_t`: public access.
const MEMBER_PUBLIC: u16 = 3;
/// `CV_ptrtype_e` `CV_PTR_64` and `CV_PTR_NEAR32`; the attribute word keeps
/// the size in bits 13-18 and the qualifiers in bits 9, 10 and 12.
const PTR_64: u32 = 0x0c;
const PTR_NEAR32: u32 = 0x0a;
const PTR_VOLATILE: u32 = 0x0200;
const PTR_CONST: u32 = 0x0400;
const PTR_RESTRICT: u32 = 0x1000;

// Symbol record kinds (cvinfo.h `SYM_ENUM_e`).
pub(crate) const S_END: u16 = 0x0006;
pub(crate) const S_FRAMEPROC: u16 = 0x1012;
pub(crate) const S_OBJNAME: u16 = 0x1101;
pub(crate) const S_BLOCK32: u16 = 0x1103;
pub(crate) const S_UDT: u16 = 0x1108;
pub(crate) const S_LDATA32: u16 = 0x110c;
pub(crate) const S_GDATA32: u16 = 0x110d;
pub(crate) const S_PUB32: u16 = 0x110e;
pub(crate) const S_LPROC32: u16 = 0x110f;
pub(crate) const S_GPROC32: u16 = 0x1110;
pub(crate) const S_REGREL32: u16 = 0x1111;
pub(crate) const S_PROCREF: u16 = 0x1125;
pub(crate) const S_LPROCREF: u16 = 0x1127;
pub(crate) const S_COMPILE3: u16 = 0x113c;
pub(crate) const S_LOCAL: u16 = 0x113e;

/// `CV_LVARFLAGS`: a parameter, and a variable with no storage.
const LOCAL_IS_PARAM: u16 = 0x0001;
const LOCAL_OPTIMIZED_OUT: u16 = 0x0100;

/// C13 subsection kinds (cvinfo.h `DEBUG_S_SUBSECTION_TYPE`).
pub(crate) const DEBUG_S_LINES: u32 = 0xf2;
pub(crate) const DEBUG_S_FILECHKSMS: u32 = 0xf4;

/// `CV_CFL_C`, and the `CV_CPU_TYPE_e` of each machine.
const CV_CFL_C: u32 = 0x00;
const CV_CFL_X64: u16 = 0xd0;
const CV_CFL_ARM64: u16 = 0xf6;

// `CV_HREG_e` (cvconst.h) of the frame and stack pointers.
const CV_AMD64_RBP: u16 = 334;
const CV_AMD64_RSP: u16 = 335;
const CV_ARM64_FP: u16 = 79;
const CV_ARM64_SP: u16 = 81;

/// `S_FRAMEPROC` flags: the locals and the parameters addressed off the
/// frame pointer (`encodedLocalBasePointer`, `encodedParamBasePointer`).
const FRAMEPROC_FP_BASES: u32 = (2 << 14) | (2 << 16);

/// `CV_PFLAG_NOFPO`: the procedure keeps a frame pointer.
const PROC_FRAME_POINTER: u8 = 0x01;

/// A record body under construction.
#[derive(Default)]
pub(crate) struct Rec(pub Vec<u8>);

impl Rec {
    pub(crate) fn u8(&mut self, v: u8) -> &mut Self {
        self.0.push(v);
        self
    }
    pub(crate) fn u16(&mut self, v: u16) -> &mut Self {
        self.0.extend_from_slice(&v.to_le_bytes());
        self
    }
    pub(crate) fn u32(&mut self, v: u32) -> &mut Self {
        self.0.extend_from_slice(&v.to_le_bytes());
        self
    }
    pub(crate) fn name(&mut self, s: &str) -> &mut Self {
        self.0.extend_from_slice(s.as_bytes());
        self.0.push(0);
        self
    }

    /// A numeric leaf: the value inline below `LF_NUMERIC`, else the
    /// narrowest leaf that holds it.
    pub(crate) fn numeric(&mut self, v: i128) -> &mut Self {
        if (0..0x8000).contains(&v) {
            return self.u16(v as u16);
        }
        if v >= 0 {
            if v <= i128::from(u16::MAX) {
                self.u16(LF_USHORT).u16(v as u16)
            } else if v <= i128::from(u32::MAX) {
                self.u16(LF_ULONG).u32(v as u32)
            } else {
                self.u16(LF_UQUADWORD);
                self.0.extend_from_slice(&(v as u64).to_le_bytes());
                self
            }
        } else if v >= i128::from(i8::MIN) {
            self.u16(LF_CHAR).u8(v as i8 as u8)
        } else if v >= i128::from(i16::MIN) {
            self.u16(LF_SHORT).u16(v as i16 as u16)
        } else if v >= i128::from(i32::MIN) {
            self.u16(LF_LONG).u32(v as i32 as u32)
        } else {
            self.u16(LF_QUADWORD);
            self.0.extend_from_slice(&(v as i64).to_le_bytes());
            self
        }
    }

    /// `LF_PAD3`, `LF_PAD2`, `LF_PAD1` up to a 4-byte boundary of a record
    /// whose 2-byte length field precedes the body.
    fn pad_type(&mut self) {
        let rem = (4 - (self.0.len() + 2) % 4) % 4;
        for k in (1..=rem).rev() {
            self.0.push(0xf0 | k as u8);
        }
    }
}

/// A whole type record: the length, the leaf and the body, padded to 4
/// bytes as a PDB type stream stores it.
pub(crate) fn type_record(kind: u16, body: &[u8]) -> Vec<u8> {
    let mut r = Rec(Vec::with_capacity(body.len() + 6));
    r.u16(kind);
    r.0.extend_from_slice(body);
    r.pad_type();
    let mut out = Vec::with_capacity(r.0.len() + 2);
    out.extend_from_slice(&(r.0.len() as u16).to_le_bytes());
    out.extend_from_slice(&r.0);
    out
}

/// A whole symbol record, zero-padded to 4 bytes as a PDB symbol stream
/// stores it.
pub(crate) fn symbol_record(kind: u16, body: &[u8]) -> Vec<u8> {
    let size = (4 + body.len()).next_multiple_of(4);
    let mut out = Vec::with_capacity(size);
    out.extend_from_slice(&((size - 2) as u16).to_le_bytes());
    out.extend_from_slice(&kind.to_le_bytes());
    out.extend_from_slice(body);
    out.resize(size, 0);
    out
}

/// A type stream (TPI or IPI): each distinct record once, indexed from
/// [`FIRST_TYPE_INDEX`] in insertion order.
#[derive(Default)]
pub(crate) struct TypeStream {
    pub records: Vec<Vec<u8>>,
    index: BTreeMap<Vec<u8>, u32>,
}

impl TypeStream {
    pub(crate) fn insert(&mut self, kind: u16, body: &[u8]) -> u32 {
        let rec = type_record(kind, body);
        if let Some(&ti) = self.index.get(&rec) {
            return ti;
        }
        let ti = FIRST_TYPE_INDEX + self.records.len() as u32;
        self.index.insert(rec.clone(), ti);
        self.records.push(rec);
        ti
    }
}

/// The model's types lowered into a TPI, and the function ids of an IPI.
/// An aggregate's references go to its forward declaration where a
/// pointer could close a cycle, and to its definition elsewhere.
pub(crate) struct Types<'m> {
    model: &'m DebugInfo,
    pub tpi: TypeStream,
    pub ipi: TypeStream,
    lowered: BTreeMap<TypeId, u32>,
    forward: BTreeMap<TypeId, u32>,
    active: BTreeSet<TypeId>,
    pointer_size: u32,
}

impl<'m> Types<'m> {
    pub(crate) fn new(model: &'m DebugInfo, pointer_size: u32) -> Self {
        Types {
            model,
            tpi: TypeStream::default(),
            ipi: TypeStream::default(),
            lowered: BTreeMap::new(),
            forward: BTreeMap::new(),
            active: BTreeSet::new(),
            pointer_size,
        }
    }

    /// The type index of `ty`.
    pub(crate) fn index(&mut self, ty: TypeRef) -> u32 {
        let Some(id) = ty else { return T_VOID };
        if let Some(&ti) = self.lowered.get(&id) {
            return ti;
        }
        if !self.active.insert(id) {
            // Only a malformed graph reaches its own definition by value.
            return self.forward_index(id);
        }
        let ti = self.lower(id);
        self.active.remove(&id);
        self.lowered.insert(id, ti);
        ti
    }

    fn lower(&mut self, id: TypeId) -> u32 {
        let model = self.model;
        match &model.types[id] {
            Type::Base {
                name,
                size,
                encoding,
            } => base_index(name, *size, *encoding, self.pointer_size),
            Type::Pointer { pointee, size } => self.pointer(*pointee, *size, 0),
            Type::Qualified { .. } => self.qualified(id),
            Type::Typedef { inner, .. } => self.index(*inner),
            Type::Aggregate { .. } => self.aggregate(id),
            Type::Declaration { .. } => self.forward_index(id),
            Type::Enum {
                name,
                size,
                enumerators,
            } => {
                let fields = (enumerators.iter()).map(|(n, v)| {
                    let mut f = Rec::default();
                    f.u16(LF_ENUMERATE)
                        .u16(MEMBER_PUBLIC)
                        .numeric(i128::from(*v))
                        .name(n);
                    f
                });
                let list = self.field_list(fields.collect());
                let mut r = Rec::default();
                r.u16(enumerators.len() as u16).u16(0);
                r.u32(enum_underlying(*size)).u32(list);
                r.name(name.as_deref().unwrap_or("<unnamed-enum>"));
                self.tpi.insert(LF_ENUM, &r.0)
            }
            Type::Array { element, dims } => {
                let mut ti = self.index(*element);
                let mut size = size_of(model, *element);
                for d in dims.iter().rev() {
                    size = size.saturating_mul(d.unwrap_or(0));
                    let mut r = Rec::default();
                    r.u32(ti).u32(if self.pointer_size == 8 {
                        T_UQUAD
                    } else {
                        T_ULONG
                    });
                    r.numeric(i128::from(size)).name("");
                    ti = self.tpi.insert(LF_ARRAY, &r.0);
                }
                ti
            }
            Type::Function {
                ret,
                params,
                variadic,
                ..
            } => {
                let ret = self.index(*ret);
                let mut args: Vec<u32> = params.iter().map(|p| self.index(*p)).collect();
                if *variadic {
                    args.push(T_NOTYPE);
                }
                let mut r = Rec::default();
                r.u32(args.len() as u32);
                for a in &args {
                    r.u32(*a);
                }
                let list = self.tpi.insert(LF_ARGLIST, &r.0);
                let mut p = Rec::default();
                p.u32(ret).u8(0).u8(0).u16(args.len() as u16).u32(list);
                self.tpi.insert(LF_PROCEDURE, &p.0)
            }
            Type::Unspecified => T_NOTYPE,
        }
    }

    /// The index of a reference to `pointee` through a pointer: an
    /// aggregate's forward declaration when it has a name to resolve by.
    fn pointee_index(&mut self, pointee: TypeRef) -> u32 {
        let model = self.model;
        if let Some(id) = pointee
            && let Type::Aggregate { name: Some(_), .. } = &model.types[id]
        {
            return self.forward_index(id);
        }
        self.index(pointee)
    }

    fn pointer(&mut self, pointee: TypeRef, size: u32, quals: u32) -> u32 {
        let to = match self.pointee_index(pointee) {
            T_NOTYPE => T_VOID,
            ti => ti,
        };
        if quals == 0 && to < FIRST_TYPE_INDEX && to & 0x0f00 == 0 && matches!(size, 4 | 8) {
            return to | if size == 8 { T_MODE_64 } else { T_MODE_32 };
        }
        let kind = if size == 8 { PTR_64 } else { PTR_NEAR32 };
        let mut r = Rec::default();
        r.u32(to).u32(kind | quals | (size << 13));
        self.tpi.insert(LF_POINTER, &r.0)
    }

    /// A qualified type: the qualifiers of a pointer ride its record, the
    /// others an `LF_MODIFIER` (`restrict` qualifies pointers alone).
    fn qualified(&mut self, mut id: TypeId) -> u32 {
        let model = self.model;
        let mut quals = BTreeSet::new();
        let mut inner = None;
        for _ in 0..=model.types.len() {
            match &model.types[id] {
                Type::Qualified {
                    qualifier,
                    inner: next,
                } => {
                    quals.insert(*qualifier as u8);
                    match next {
                        Some(i) => id = *i,
                        None => break,
                    }
                }
                _ => {
                    inner = Some(id);
                    break;
                }
            }
        }
        let has = |q: Qualifier| quals.contains(&(q as u8));
        if let Some(p) = model.strip(inner)
            && let Type::Pointer { pointee, size } = &model.types[p]
        {
            let bits = (if has(Qualifier::Const) { PTR_CONST } else { 0 })
                | (if has(Qualifier::Volatile) {
                    PTR_VOLATILE
                } else {
                    0
                })
                | (if has(Qualifier::Restrict) {
                    PTR_RESTRICT
                } else {
                    0
                });
            return self.pointer(*pointee, *size, bits);
        }
        let modifiers = u16::from(has(Qualifier::Const)) | u16::from(has(Qualifier::Volatile)) << 1;
        let ti = self.index(inner);
        if modifiers == 0 {
            return ti;
        }
        let mut r = Rec::default();
        r.u32(ti).u16(modifiers);
        self.tpi.insert(LF_MODIFIER, &r.0)
    }

    fn forward_index(&mut self, id: TypeId) -> u32 {
        if let Some(&ti) = self.forward.get(&id) {
            return ti;
        }
        let model = self.model;
        let (kind, name) = match &model.types[id] {
            Type::Aggregate { kind, name, .. } | Type::Declaration { kind, name } => {
                (*kind, name.as_deref())
            }
            _ => return T_NOTYPE,
        };
        let mut r = Rec::default();
        let ti = match kind {
            TagKind::Enum => {
                r.u16(0).u16(PROP_FWDREF).u32(T_INT4).u32(0);
                r.name(name.unwrap_or("<unnamed-enum>"));
                self.tpi.insert(LF_ENUM, &r.0)
            }
            TagKind::Struct | TagKind::Union => {
                r.u16(0).u16(PROP_FWDREF).u32(0);
                if kind == TagKind::Struct {
                    r.u32(0).u32(0);
                }
                r.numeric(0).name(name.unwrap_or("<unnamed-tag>"));
                self.tpi.insert(aggregate_leaf(kind), &r.0)
            }
        };
        self.forward.insert(id, ti);
        ti
    }

    /// An aggregate's definition after its field list. An anonymous member
    /// contributes its own members at their offsets, as cl describes it.
    fn aggregate(&mut self, id: TypeId) -> u32 {
        let model = self.model;
        let Type::Aggregate {
            kind,
            name,
            size,
            members,
        } = &model.types[id]
        else {
            return T_NOTYPE;
        };
        let mut flat = Vec::new();
        flatten_members(model, members, 0, &mut flat, 0);
        let mut fields = Vec::new();
        for m in &flat {
            let (offset, ti) = match m.bits {
                Some((first, width)) => {
                    // The member sits at its storage unit, the bit-field at
                    // its position there; one straddling a unit boundary
                    // (a packed aggregate) is placed at its first byte.
                    let unit = size_of(model, m.ty).clamp(1, 16);
                    let mut storage = first / (unit * 8) * unit;
                    if first - storage * 8 + u64::from(width) > unit * 8 {
                        storage = first / 8;
                    }
                    let base = self.index(m.ty);
                    let mut b = Rec::default();
                    b.u32(base).u8(width as u8).u8((first - storage * 8) as u8);
                    (storage, self.tpi.insert(LF_BITFIELD, &b.0))
                }
                None => (m.offset, self.index(m.ty)),
            };
            let mut f = Rec::default();
            f.u16(LF_MEMBER).u16(MEMBER_PUBLIC).u32(ti);
            f.numeric(i128::from(offset))
                .name(m.name.as_deref().unwrap_or(""));
            fields.push(f);
        }
        let list = self.field_list(fields);
        let mut r = Rec::default();
        r.u16(flat.len() as u16).u16(0).u32(list);
        if *kind == TagKind::Struct {
            r.u32(0).u32(0);
        }
        r.numeric(i128::from(*size))
            .name(name.as_deref().unwrap_or("<unnamed-tag>"));
        self.tpi.insert(aggregate_leaf(*kind), &r.0)
    }

    /// A field list of `members`, each padded to 4 bytes. A list past a
    /// record's 16-bit length continues through an `LF_INDEX` to the next
    /// part, which is inserted first, as a record names lower indices.
    fn field_list(&mut self, members: Vec<Rec>) -> u32 {
        const PART: usize = 0xff00;
        let mut parts: Vec<Vec<u8>> = alloc::vec![Vec::new()];
        for mut m in members {
            m.pad_type_member();
            if parts.last().is_some_and(|p| p.len() + m.0.len() > PART) {
                parts.push(Vec::new());
            }
            parts.last_mut().unwrap().extend_from_slice(&m.0);
        }
        let mut next = None;
        for part in parts.into_iter().rev() {
            let mut r = Rec(part);
            if let Some(ti) = next {
                r.u16(LF_INDEX).u16(0).u32(ti);
            }
            next = Some(self.tpi.insert(LF_FIELDLIST, &r.0));
        }
        next.unwrap_or(T_NOTYPE)
    }

    /// The IPI `LF_FUNC_ID` of a function named `name` of type `ty`.
    pub(crate) fn func_id(&mut self, name: &str, ty: TypeId) -> u32 {
        let ti = self.index(Some(ty));
        let mut r = Rec::default();
        r.u32(0).u32(ti).name(name);
        self.ipi.insert(LF_FUNC_ID, &r.0)
    }
}

impl Rec {
    /// A field-list member ends on a 4-byte boundary of the list body.
    fn pad_type_member(&mut self) {
        let rem = (4 - self.0.len() % 4) % 4;
        for k in (1..=rem).rev() {
            self.0.push(0xf0 | k as u8);
        }
    }
}

fn aggregate_leaf(kind: TagKind) -> u16 {
    if kind == TagKind::Union {
        LF_UNION
    } else {
        LF_STRUCTURE
    }
}

/// The members of an aggregate with each anonymous structure or union
/// member replaced by its own members, displaced by its offset. Nesting
/// deeper than the type count is a cycle, which stays one member.
fn flatten_members(
    model: &DebugInfo,
    members: &[Member],
    base: u64,
    out: &mut Vec<Member>,
    depth: usize,
) {
    for m in members {
        let inner = model.strip(m.ty).map(|t| &model.types[t]);
        match (m.name.as_deref(), inner) {
            (None | Some(""), Some(Type::Aggregate { members: inner, .. }))
                if m.bits.is_none() && depth < model.types.len() =>
            {
                flatten_members(model, inner, base + m.offset, out, depth + 1);
            }
            _ => out.push(Member {
                offset: base + m.offset,
                bits: m.bits.map(|(first, w)| (first + base * 8, w)),
                ..m.clone()
            }),
        }
    }
}

/// The simple type index of a base type, by its encoding, size and the
/// name that tells `long` and `long long` from `int` (LLP64 4.1).
fn base_index(name: &str, size: u32, encoding: Encoding, pointer_size: u32) -> u32 {
    let long = name.contains("long");
    let long_long = name.contains("long long");
    match (encoding, size) {
        (Encoding::Bool, 1 | 2 | 4 | 8) => T_BOOL08 + size.trailing_zeros(),
        (Encoding::SignedChar | Encoding::UnsignedChar, 1) if name == "char" => T_RCHAR,
        (Encoding::SignedChar | Encoding::Signed, 1) => T_CHAR,
        (Encoding::UnsignedChar | Encoding::Unsigned, 1) => T_UCHAR,
        (Encoding::Signed, 2) => T_SHORT,
        (Encoding::Unsigned, 2) => T_USHORT,
        (Encoding::Signed, 4) if long => T_LONG,
        (Encoding::Unsigned, 4) if long => T_ULONG,
        (Encoding::Signed, 4) => T_INT4,
        (Encoding::Unsigned, 4) => T_UINT4,
        (Encoding::Signed, 8) if long_long => T_QUAD,
        (Encoding::Unsigned, 8) if long_long => T_UQUAD,
        (Encoding::Signed, 8) => T_INT8,
        (Encoding::Unsigned, 8) => T_UINT8,
        (Encoding::Signed, 16) => T_INT16,
        (Encoding::Unsigned, 16) => T_UINT16,
        (Encoding::Float, 4) => T_REAL32,
        (Encoding::Float, 8) => T_REAL64,
        (Encoding::Float, 10 | 12) => T_REAL80,
        (Encoding::Float, 16) => T_REAL128,
        (Encoding::Address, _) => {
            T_VOID
                | if pointer_size == 8 {
                    T_MODE_64
                } else {
                    T_MODE_32
                }
        }
        _ => T_NOTYPE,
    }
}

fn enum_underlying(size: u32) -> u32 {
    match size {
        1 => T_UCHAR,
        2 => T_SHORT,
        8 => T_QUAD,
        _ => T_INT4,
    }
}

/// The size in bytes of an object of type `ty`.
pub(crate) fn size_of(model: &DebugInfo, mut ty: TypeRef) -> u64 {
    let mut count: u64 = 1;
    for _ in 0..=model.types.len() {
        let Some(id) = model.strip(ty) else { return 0 };
        let size = match &model.types[id] {
            Type::Base { size, .. } | Type::Pointer { size, .. } | Type::Enum { size, .. } => {
                u64::from(*size)
            }
            Type::Aggregate { size, .. } => *size,
            Type::Array { element, dims } => {
                let n = dims
                    .iter()
                    .fold(1u64, |s, d| s.saturating_mul(d.unwrap_or(0)));
                count = count.saturating_mul(n);
                ty = *element;
                continue;
            }
            _ => 0,
        };
        return count.saturating_mul(size);
    }
    0
}

/// Where a virtual address lies in the image: its 1-based section number
/// and its offset in that section.
pub(crate) trait AddressMap {
    fn locate(&self, va: u64) -> Option<(u16, u32)>;
}

/// The symbols of one module stream and what the global streams take
/// from it.
#[derive(Default)]
pub(crate) struct ModuleSymbols {
    /// The records past the stream's 4-byte signature.
    pub symbols: Vec<u8>,
    /// Each procedure's name, its record's offset in the stream, and
    /// whether it has external linkage.
    pub procs: Vec<(String, u32, bool)>,
    /// The `S_GDATA32`, `S_LDATA32` and `S_UDT` records the globals stream
    /// holds.
    pub globals: Vec<Vec<u8>>,
    /// The section, offset and size of each function's code.
    pub contributions: Vec<(u16, u32, u32)>,
}

/// The CodeView register a model register names on `machine`.
fn cv_register(machine: Machine, r: Register) -> u16 {
    match (machine, r) {
        (Machine::X86_64, Register::FramePointer) => CV_AMD64_RBP,
        (Machine::X86_64, Register::StackPointer) => CV_AMD64_RSP,
        (Machine::Aarch64, Register::FramePointer) => CV_ARM64_FP,
        (Machine::Aarch64, Register::StackPointer) => CV_ARM64_SP,
    }
}

/// Patches a record's 4-byte field at `at` within the symbol buffer.
fn patch_u32(buf: &mut [u8], at: usize, v: u32) {
    buf[at..at + 4].copy_from_slice(&v.to_le_bytes());
}

/// The symbol stream of `unit`: `S_OBJNAME`, `S_COMPILE3`, a procedure
/// per function with its frame, variables and blocks, and the unit's
/// objects with internal linkage.
pub(crate) fn module_symbols(
    unit: &Unit,
    types: &mut Types,
    map: &dyn AddressMap,
    machine: Machine,
) -> ModuleSymbols {
    let mut m = ModuleSymbols::default();
    let mut w = SymbolWriter {
        out: Vec::new(),
        machine,
    };
    let mut objname = Rec::default();
    objname.u32(0).name(&unit.name);
    w.push(S_OBJNAME, &objname.0);
    let mut compile = Rec::default();
    compile.u32(CV_CFL_C).u16(match machine {
        Machine::X86_64 => CV_CFL_X64,
        Machine::Aarch64 => CV_CFL_ARM64,
    });
    let version: Vec<u16> = (env!("CARGO_PKG_VERSION").split('.'))
        .map(|p| p.parse().unwrap_or(0))
        .chain(core::iter::repeat(0))
        .take(4)
        .collect();
    for _ in 0..2 {
        for &v in &version {
            compile.u16(v);
        }
    }
    let producer = if unit.producer.is_empty() {
        "badc"
    } else {
        &unit.producer
    };
    compile.name(producer);
    w.push(S_COMPILE3, &compile.0);
    for f in &unit.functions {
        let Some((seg, off)) = map.locate(f.low) else {
            continue;
        };
        let at = w.procedure(f, seg, off, types, map);
        m.procs.push((f.name.clone(), at, f.external));
        m.contributions
            .push((seg, off, f.high.saturating_sub(f.low) as u32));
    }
    for g in &unit.globals {
        let Some((seg, off)) = map.locate(g.address) else {
            continue;
        };
        let mut r = Rec::default();
        r.u32(types.index(g.ty)).u32(off).u16(seg).name(&g.name);
        if g.external {
            m.globals.push(symbol_record(S_GDATA32, &r.0));
        } else {
            w.push(S_LDATA32, &r.0);
            m.globals.push(symbol_record(S_LDATA32, &r.0));
        }
    }
    // A typedef is a symbol; a tag the unit defines is a type even where
    // no object of it is described.
    for &t in &unit.types {
        match &types.model.types[t] {
            Type::Typedef { name, inner } => {
                let mut r = Rec::default();
                r.u32(types.index(*inner)).name(name);
                m.globals.push(symbol_record(S_UDT, &r.0));
            }
            Type::Aggregate { .. } | Type::Enum { .. } => {
                types.index(Some(t));
            }
            _ => {}
        }
    }
    m.symbols = w.out;
    m
}

struct SymbolWriter {
    out: Vec<u8>,
    machine: Machine,
}

impl SymbolWriter {
    /// The stream offset of the next record: past the 4-byte signature.
    fn cursor(&self) -> u32 {
        4 + self.out.len() as u32
    }

    fn push(&mut self, kind: u16, body: &[u8]) -> u32 {
        let at = self.cursor();
        self.out.extend_from_slice(&symbol_record(kind, body));
        at
    }

    /// `S_GPROC32` / `S_LPROC32`, `S_FRAMEPROC`, the scope, `S_END`; the
    /// procedure's `pEnd` is patched once its `S_END` is placed.
    fn procedure(
        &mut self,
        f: &Function,
        seg: u16,
        off: u32,
        types: &mut Types,
        map: &dyn AddressMap,
    ) -> u32 {
        let len = f.high.saturating_sub(f.low) as u32;
        let debug_start = (f.prologue_end)
            .filter(|&p| p > f.low && p < f.high)
            .map_or(0, |p| (p - f.low) as u32);
        let fp = uses_frame_pointer(&f.scope);
        let mut r = Rec::default();
        r.u32(0).u32(0).u32(0).u32(len).u32(debug_start).u32(len);
        r.u32(types.index(Some(f.ty))).u32(off).u16(seg);
        r.u8(if fp { PROC_FRAME_POINTER } else { 0 }).name(&f.name);
        types.func_id(&f.name, f.ty);
        let kind = if f.external { S_GPROC32 } else { S_LPROC32 };
        let at = self.push(kind, &r.0);
        let mut frame = Rec::default();
        frame.u32(0).u32(0).u32(0).u32(0).u32(0).u16(0);
        frame.u32(if fp { FRAMEPROC_FP_BASES } else { 0 });
        self.push(S_FRAMEPROC, &frame.0);
        self.scope(&f.scope, at, types, map);
        let end = self.push(S_END, &[]);
        // pEnd follows the 2-byte length, 2-byte kind and pParent.
        patch_u32(&mut self.out, (at - 4) as usize + 8, end);
        at
    }

    fn scope(&mut self, s: &Scope, parent: u32, types: &mut Types, map: &dyn AddressMap) {
        for v in &s.variables {
            let ti = types.index(v.ty);
            let mut r = Rec::default();
            let address = match v.location {
                Location::Address(a) => map.locate(a),
                _ => None,
            };
            match (v.location, address) {
                (Location::RegisterRelative { base, offset }, _) => {
                    r.u32(offset as i32 as u32).u32(ti);
                    r.u16(cv_register(self.machine, base)).name(&v.name);
                    self.push(S_REGREL32, &r.0);
                }
                (_, Some((seg, off))) => {
                    r.u32(ti).u32(off).u16(seg).name(&v.name);
                    self.push(S_LDATA32, &r.0);
                }
                _ => {
                    let param = if v.is_parameter { LOCAL_IS_PARAM } else { 0 };
                    r.u32(ti).u16(param | LOCAL_OPTIMIZED_OUT).name(&v.name);
                    self.push(S_LOCAL, &r.0);
                }
            }
        }
        for b in &s.blocks {
            let Some((seg, off)) = map.locate(b.low) else {
                continue;
            };
            let mut r = Rec::default();
            r.u32(parent)
                .u32(0)
                .u32(b.high.saturating_sub(b.low) as u32);
            r.u32(off).u16(seg).name("");
            let at = self.push(S_BLOCK32, &r.0);
            self.scope(&b.scope, at, types, map);
            let end = self.push(S_END, &[]);
            patch_u32(&mut self.out, (at - 4) as usize + 8, end);
        }
    }
}

fn uses_frame_pointer(s: &Scope) -> bool {
    let fp = |v: &super::debug_model::Variable| {
        matches!(
            v.location,
            Location::RegisterRelative {
                base: Register::FramePointer,
                ..
            }
        )
    };
    s.variables.iter().any(fp) || s.blocks.iter().any(|b| uses_frame_pointer(&b.scope))
}

/// A PDB string table's offset for each string `intern` was given.
pub(crate) trait Names {
    fn intern(&mut self, s: &str) -> u32;
}

/// The C13 `DEBUG_S_FILECHKSMS` and `DEBUG_S_LINES` subsections of
/// `unit`, with the files they name, in order.
pub(crate) fn line_subsections(
    unit: &Unit,
    map: &dyn AddressMap,
    names: &mut dyn Names,
) -> (Vec<u8>, Vec<String>) {
    let mut rows: Vec<_> = (unit.lines.iter())
        .flat_map(|s| s.rows.iter().copied())
        .collect();
    rows.sort_by_key(|r| r.address);
    // File entries: the name offset, no checksum, padded to 4 bytes.
    let mut checksum_at: BTreeMap<u32, u32> = BTreeMap::new();
    let mut checksums = Rec::default();
    let mut files = Vec::new();
    let mut lines = Vec::new();
    for f in &unit.functions {
        let Some((seg, off)) = map.locate(f.low) else {
            continue;
        };
        let start = rows.partition_point(|r| r.address < f.low);
        let end = rows.partition_point(|r| r.address < f.high);
        let body = &rows[start..end];
        if body.is_empty() {
            continue;
        }
        let mut sub = Rec::default();
        sub.u32(off)
            .u16(seg)
            .u16(0)
            .u32(f.high.saturating_sub(f.low) as u32);
        let mut i = 0;
        while i < body.len() {
            let file = body[i].file;
            let run = body[i..].iter().take_while(|r| r.file == file).count();
            let entry = *checksum_at.entry(file).or_insert_with(|| {
                let name = unit.files.get(file as usize).cloned().unwrap_or_default();
                let at = checksums.0.len() as u32;
                checksums.u32(names.intern(&name)).u8(0).u8(0).u16(0);
                files.push(name);
                at
            });
            let block = &body[i..i + run];
            sub.u32(entry)
                .u32(block.len() as u32)
                .u32(12 + 8 * block.len() as u32);
            for (k, r) in block.iter().enumerate() {
                // The first row of the function starts at its first byte.
                let at = if i == 0 && k == 0 { f.low } else { r.address };
                sub.u32((at - f.low) as u32)
                    .u32(r.line.min(0x00ff_ffff) | 1 << 31);
            }
            i += run;
        }
        lines.push(sub.0);
    }
    let mut out = Vec::new();
    let mut subsection = |kind: u32, body: &[u8]| {
        out.extend_from_slice(&kind.to_le_bytes());
        out.extend_from_slice(&(body.len() as u32).to_le_bytes());
        out.extend_from_slice(body);
        out.resize(out.len().next_multiple_of(4), 0);
    };
    if !checksums.0.is_empty() {
        subsection(DEBUG_S_FILECHKSMS, &checksums.0);
    }
    for l in &lines {
        subsection(DEBUG_S_LINES, l);
    }
    (out, files)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::object::debug_model::{DebugInfo, Encoding, Member, TagKind, Type};

    #[test]
    fn numeric_leaves_take_the_narrowest_form() {
        let enc = |v: i128| {
            let mut r = Rec::default();
            r.numeric(v);
            r.0
        };
        assert_eq!(enc(0x7fff), [0xff, 0x7f]);
        assert_eq!(enc(0x8000), [0x02, 0x80, 0x00, 0x80]);
        assert_eq!(enc(0x1_0000), [0x04, 0x80, 0x00, 0x00, 0x01, 0x00]);
        assert_eq!(enc(-1), [0x00, 0x80, 0xff]);
        assert_eq!(enc(-200), [0x01, 0x80, 0x38, 0xff]);
    }

    #[test]
    fn type_records_pad_with_lf_pad_bytes() {
        // LF_MODIFIER of `int` with `const`: 4 + 2 bytes of body after the
        // leaf, padded to 12 bytes with LF_PAD2 LF_PAD1.
        let mut r = Rec::default();
        r.u32(T_INT4).u16(1);
        assert_eq!(
            type_record(LF_MODIFIER, &r.0),
            [
                0x0a, 0x00, 0x01, 0x10, 0x74, 0x00, 0x00, 0x00, 0x01, 0x00, 0xf2, 0xf1
            ]
        );
    }

    #[test]
    fn symbol_records_pad_with_zeros() {
        let mut r = Rec::default();
        r.u32(T_INT4).name("x");
        assert_eq!(
            symbol_record(S_UDT, &r.0),
            [
                0x0a, 0x00, 0x08, 0x11, 0x74, 0x00, 0x00, 0x00, b'x', 0x00, 0x00, 0x00
            ]
        );
    }

    fn model(types: Vec<Type>) -> DebugInfo {
        DebugInfo {
            units: Vec::new(),
            types,
        }
    }

    fn int() -> Type {
        Type::Base {
            name: String::from("int"),
            size: 4,
            encoding: Encoding::Signed,
        }
    }

    #[test]
    fn pointers_to_base_types_are_simple_type_indices() {
        let m = model(alloc::vec![
            int(),
            Type::Pointer {
                pointee: Some(0),
                size: 8
            },
            Type::Pointer {
                pointee: None,
                size: 8
            },
        ]);
        let mut t = Types::new(&m, 8);
        assert_eq!(t.index(Some(1)), 0x0674);
        assert_eq!(t.index(Some(2)), 0x0603);
        assert!(t.tpi.records.is_empty());
    }

    #[test]
    fn a_self_referential_struct_reaches_its_forward_declaration() {
        // struct node { int v; struct node *next; };
        let m = model(alloc::vec![
            int(),
            Type::Aggregate {
                kind: TagKind::Struct,
                name: Some(String::from("node")),
                size: 16,
                members: alloc::vec![
                    Member {
                        name: Some(String::from("v")),
                        ty: Some(0),
                        offset: 0,
                        bits: None
                    },
                    Member {
                        name: Some(String::from("next")),
                        ty: Some(2),
                        offset: 8,
                        bits: None
                    },
                ],
            },
            Type::Pointer {
                pointee: Some(1),
                size: 8
            },
        ]);
        let mut t = Types::new(&m, 8);
        let full = t.index(Some(1));
        // The forward declaration, the pointer, the field list, the
        // definition.
        assert_eq!(full, 0x1003);
        let leaf = |i: usize| u16::from_le_bytes([t.tpi.records[i][2], t.tpi.records[i][3]]);
        assert_eq!(
            (0..4).map(leaf).collect::<Vec<_>>(),
            [LF_STRUCTURE, LF_POINTER, LF_FIELDLIST, LF_STRUCTURE]
        );
        // The pointer names the forward declaration, 0x1000.
        assert_eq!(&t.tpi.records[1][4..8], &0x1000u32.to_le_bytes());
        assert_eq!(&t.tpi.records[0][6..8], &PROP_FWDREF.to_le_bytes());
    }

    #[test]
    fn a_cyclic_type_graph_lowers_without_looping() {
        // A typedef naming itself, an array of itself, and an anonymous
        // member of its own aggregate: only a malformed input says so.
        let m = model(alloc::vec![
            Type::Typedef {
                name: String::from("t"),
                inner: Some(0)
            },
            Type::Array {
                element: Some(1),
                dims: alloc::vec![Some(2)]
            },
            Type::Aggregate {
                kind: TagKind::Struct,
                name: Some(String::from("s")),
                size: 4,
                members: alloc::vec![Member {
                    name: None,
                    ty: Some(2),
                    offset: 0,
                    bits: None
                }],
            },
        ]);
        assert_eq!(m.strip(Some(0)), None);
        assert_eq!(size_of(&m, Some(1)), 0);
        let mut t = Types::new(&m, 8);
        for id in 0..3 {
            t.index(Some(id));
        }
    }

    #[test]
    fn a_field_list_past_a_record_continues_through_lf_index() {
        let enumerators = (0..12000)
            .map(|i| (alloc::format!("enumerator_{i:05}"), i))
            .collect();
        let m = model(alloc::vec![Type::Enum {
            name: Some(String::from("big")),
            size: 4,
            enumerators,
        }]);
        let mut t = Types::new(&m, 8);
        t.index(Some(0));
        let lists: Vec<&Vec<u8>> = (t.tpi.records.iter())
            .filter(|r| u16::from_le_bytes([r[2], r[3]]) == LF_FIELDLIST)
            .collect();
        assert!(lists.len() > 1);
        assert!(t.tpi.records.iter().all(|r| r.len() <= 0x1_0001));
        // Each part but the last inserted (the first) ends with an
        // `LF_INDEX` naming the part inserted before it.
        for (k, part) in lists.iter().enumerate().skip(1) {
            let tail = &part[part.len() - 8..];
            assert_eq!(&tail[..2], &LF_INDEX.to_le_bytes());
            let named = u32::from_le_bytes(tail[4..].try_into().unwrap());
            assert_eq!(named, FIRST_TYPE_INDEX + k as u32 - 1);
        }
    }

    #[test]
    fn a_const_pointer_carries_the_qualifier_in_its_record() {
        // char *const
        let m = model(alloc::vec![
            Type::Base {
                name: String::from("char"),
                size: 1,
                encoding: Encoding::SignedChar
            },
            Type::Pointer {
                pointee: Some(0),
                size: 8
            },
            Type::Qualified {
                qualifier: Qualifier::Const,
                inner: Some(1)
            },
        ]);
        let mut t = Types::new(&m, 8);
        let ti = t.index(Some(2));
        assert_eq!(ti, 0x1000);
        let rec = &t.tpi.records[0];
        assert_eq!(&rec[2..4], &LF_POINTER.to_le_bytes());
        assert_eq!(&rec[4..8], &T_RCHAR.to_le_bytes());
        assert_eq!(&rec[8..12], &(PTR_64 | PTR_CONST | 8 << 13).to_le_bytes());
    }
}
