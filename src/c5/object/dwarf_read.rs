//! A reader of a linked image's DWARF (versions 2 to 5) into the
//! [`debug_model`](super::debug_model). A unit the reader cannot decode
//! is left out; nothing in the sections makes it fail.

use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use super::Machine;
use super::debug_model::{
    Block, DebugInfo, Encoding, Function, Global, LineRow, LineSequence, Location, Member,
    Qualifier, Register, Scope, TagKind, Type, TypeId, TypeRef, Unit, Variable,
};

/// The sections the reader takes, by contents; an absent one is empty.
#[derive(Clone, Copy, Default)]
pub(crate) struct Sections<'a> {
    pub info: &'a [u8],
    pub abbrev: &'a [u8],
    pub str: &'a [u8],
    pub line: &'a [u8],
    pub line_str: &'a [u8],
}

pub(crate) fn read(s: &Sections, machine: Machine) -> DebugInfo {
    let mut info = DebugInfo::default();
    let mut at = 0usize;
    while at < s.info.len() {
        let Some(header) = UnitHeader::parse(s.info, at) else {
            break;
        };
        if let Some(dies) = parse_dies(s, &header) {
            let mut reader = UnitReader {
                s,
                machine,
                header: &header,
                index: dies
                    .iter()
                    .enumerate()
                    .map(|(i, d)| (d.offset, i))
                    .collect(),
                dies,
                types: BTreeMap::new(),
                info: &mut info,
            };
            if let Some(unit) = reader.unit() {
                info.units.push(unit);
            }
        }
        at = header.end;
    }
    info.mark_prologue_ends();
    info
}

const DW_TAG_ARRAY_TYPE: u16 = 0x01;
const DW_TAG_ENUMERATION_TYPE: u16 = 0x04;
const DW_TAG_FORMAL_PARAMETER: u16 = 0x05;
const DW_TAG_LEXICAL_BLOCK: u16 = 0x0b;
const DW_TAG_MEMBER: u16 = 0x0d;
const DW_TAG_POINTER_TYPE: u16 = 0x0f;
const DW_TAG_REFERENCE_TYPE: u16 = 0x10;
const DW_TAG_COMPILE_UNIT: u16 = 0x11;
const DW_TAG_STRUCTURE_TYPE: u16 = 0x13;
const DW_TAG_SUBROUTINE_TYPE: u16 = 0x15;
const DW_TAG_TYPEDEF: u16 = 0x16;
const DW_TAG_UNION_TYPE: u16 = 0x17;
const DW_TAG_UNSPECIFIED_PARAMETERS: u16 = 0x18;
const DW_TAG_SUBRANGE_TYPE: u16 = 0x21;
const DW_TAG_BASE_TYPE: u16 = 0x24;
const DW_TAG_CONST_TYPE: u16 = 0x26;
const DW_TAG_ENUMERATOR: u16 = 0x28;
const DW_TAG_SUBPROGRAM: u16 = 0x2e;
const DW_TAG_VARIABLE: u16 = 0x34;
const DW_TAG_VOLATILE_TYPE: u16 = 0x35;
const DW_TAG_RESTRICT_TYPE: u16 = 0x37;
const DW_TAG_ATOMIC_TYPE: u16 = 0x47;

const DW_AT_LOCATION: u16 = 0x02;
const DW_AT_NAME: u16 = 0x03;
const DW_AT_BYTE_SIZE: u16 = 0x0b;
const DW_AT_BIT_OFFSET: u16 = 0x0c;
const DW_AT_BIT_SIZE: u16 = 0x0d;
const DW_AT_STMT_LIST: u16 = 0x10;
const DW_AT_LOW_PC: u16 = 0x11;
const DW_AT_HIGH_PC: u16 = 0x12;
const DW_AT_COMP_DIR: u16 = 0x1b;
const DW_AT_CONST_VALUE: u16 = 0x1c;
const DW_AT_UPPER_BOUND: u16 = 0x2f;
const DW_AT_PRODUCER: u16 = 0x25;
const DW_AT_PROTOTYPED: u16 = 0x27;
const DW_AT_ABSTRACT_ORIGIN: u16 = 0x31;
const DW_AT_COUNT: u16 = 0x37;
const DW_AT_DATA_MEMBER_LOCATION: u16 = 0x38;
const DW_AT_DECLARATION: u16 = 0x3c;
const DW_AT_ENCODING: u16 = 0x3e;
const DW_AT_EXTERNAL: u16 = 0x3f;
const DW_AT_FRAME_BASE: u16 = 0x40;
const DW_AT_SPECIFICATION: u16 = 0x47;
const DW_AT_TYPE: u16 = 0x49;
const DW_AT_DATA_BIT_OFFSET: u16 = 0x6b;

const DW_OP_ADDR: u8 = 0x03;
const DW_OP_PLUS_UCONST: u8 = 0x23;
const DW_OP_REG0: u8 = 0x50;
const DW_OP_BREG0: u8 = 0x70;
const DW_OP_FBREG: u8 = 0x91;

/// A unit header: where its DIEs start and end, and the widths they use.
struct UnitHeader {
    offset: usize,
    dies: usize,
    end: usize,
    version: u16,
    abbrev: usize,
    addr_size: u8,
    offset_size: u8,
}

impl UnitHeader {
    fn parse(info: &[u8], offset: usize) -> Option<Self> {
        let mut c = Cursor::at(info, offset);
        let (length, offset_size) = c.initial_length()?;
        let end = c.p.checked_add(usize::try_from(length).ok()?)?;
        if end > info.len() {
            return None;
        }
        let version = c.u16()?;
        let (abbrev, addr_size) = if version >= 5 {
            let unit_type = c.u8()?;
            let addr_size = c.u8()?;
            let abbrev = c.sized(offset_size)?;
            // DW_UT_skeleton and DW_UT_split_compile carry a DWO id, the
            // type units a signature and a type offset.
            c.p += match unit_type {
                0x04 | 0x05 => 8,
                0x02 | 0x06 => 8 + offset_size as usize,
                _ => 0,
            };
            (abbrev, addr_size)
        } else {
            (c.sized(offset_size)?, c.u8()?)
        };
        (2..=5).contains(&version).then_some(UnitHeader {
            offset,
            dies: c.p,
            end,
            version,
            abbrev: usize::try_from(abbrev).ok()?,
            addr_size,
            offset_size,
        })
    }
}

#[derive(Clone, Copy)]
struct AttrSpec {
    at: u16,
    form: u16,
    implicit: i64,
}

struct Abbrev {
    tag: u16,
    children: bool,
    attrs: Vec<AttrSpec>,
}

fn parse_abbrevs(bytes: &[u8], at: usize) -> Option<BTreeMap<u64, Abbrev>> {
    let mut c = Cursor::at(bytes, at);
    let mut out = BTreeMap::new();
    loop {
        let code = c.uleb()?;
        if code == 0 {
            return Some(out);
        }
        let tag = u16::try_from(c.uleb()?).ok()?;
        let children = c.u8()? != 0;
        let mut attrs = Vec::new();
        loop {
            let (at, form) = (c.uleb()?, c.uleb()?);
            if at == 0 && form == 0 {
                break;
            }
            let implicit = if form == 0x21 { c.sleb()? } else { 0 };
            attrs.push(AttrSpec {
                at: u16::try_from(at).ok()?,
                form: u16::try_from(form).ok()?,
                implicit,
            });
        }
        out.insert(
            code,
            Abbrev {
                tag,
                children,
                attrs,
            },
        );
    }
}

#[derive(Clone, Copy, Debug)]
enum Value<'a> {
    /// `DW_FORM_addr`.
    Address(u64),
    Unsigned(u64),
    Signed(i64),
    Str(&'a [u8]),
    /// A `.debug_info` offset.
    Ref(usize),
    Block(&'a [u8]),
    /// A form naming an entry of a table the reader does not take.
    Opaque,
}

struct Die<'a> {
    offset: usize,
    tag: u16,
    children: Vec<usize>,
    attrs: Vec<(u16, Value<'a>)>,
}

impl<'a> Die<'a> {
    fn attr(&self, at: u16) -> Option<Value<'a>> {
        self.attrs.iter().find(|(a, _)| *a == at).map(|&(_, v)| v)
    }
}

fn parse_dies<'a>(s: &Sections<'a>, h: &UnitHeader) -> Option<Vec<Die<'a>>> {
    let abbrevs = parse_abbrevs(s.abbrev, h.abbrev)?;
    let mut c = Cursor::at(&s.info[..h.end], h.dies);
    let mut dies: Vec<Die> = Vec::new();
    let mut stack: Vec<usize> = Vec::new();
    while c.p < h.end {
        let offset = c.p;
        let code = c.uleb()?;
        if code == 0 {
            if stack.pop().is_none() {
                break;
            }
            continue;
        }
        let ab = abbrevs.get(&code)?;
        let mut attrs = Vec::with_capacity(ab.attrs.len());
        for spec in &ab.attrs {
            attrs.push((spec.at, read_value(&mut c, s, h, spec.form, spec.implicit)?));
        }
        let idx = dies.len();
        let parent = stack.last().copied();
        if let Some(p) = parent {
            dies[p].children.push(idx);
        }
        dies.push(Die {
            offset,
            tag: ab.tag,
            children: Vec::new(),
            attrs,
        });
        if ab.children {
            stack.push(idx);
        } else if parent.is_none() {
            break;
        }
    }
    Some(dies)
}

fn read_value<'a>(
    c: &mut Cursor<'a>,
    s: &Sections<'a>,
    h: &UnitHeader,
    form: u16,
    implicit: i64,
) -> Option<Value<'a>> {
    let unit_ref = |off: u64| {
        Some(Value::Ref(
            h.offset.checked_add(usize::try_from(off).ok()?)?,
        ))
    };
    let string_at = |table: &'a [u8], off: u64| -> Option<Value<'a>> {
        let mut t = Cursor::at(table, usize::try_from(off).ok()?);
        Some(Value::Str(t.cstr()?))
    };
    let block = |c: &mut Cursor<'a>, n: u64| Some(Value::Block(c.take(usize::try_from(n).ok()?)?));
    Some(match form {
        0x01 => Value::Address(c.sized(h.addr_size)?),
        0x03 => {
            let n = c.u16()?;
            block(c, n.into())?
        }
        0x04 => {
            let n = c.u32()?;
            block(c, n.into())?
        }
        0x05 => Value::Unsigned(c.u16()?.into()),
        0x06 => Value::Unsigned(c.u32()?.into()),
        0x07 => Value::Unsigned(c.u64()?),
        0x08 => Value::Str(c.cstr()?),
        0x09 | 0x18 => {
            let n = c.uleb()?;
            block(c, n)?
        }
        0x0a => {
            let n = c.u8()?;
            block(c, n.into())?
        }
        0x0b | 0x0c => Value::Unsigned(c.u8()?.into()),
        0x0d => Value::Signed(c.sleb()?),
        0x0e => string_at(s.str, c.sized(h.offset_size)?)?,
        0x0f => Value::Unsigned(c.uleb()?),
        0x10 => {
            let size = if h.version == 2 {
                h.addr_size
            } else {
                h.offset_size
            };
            Value::Ref(usize::try_from(c.sized(size)?).ok()?)
        }
        0x11 => unit_ref(c.u8()?.into())?,
        0x12 => unit_ref(c.u16()?.into())?,
        0x13 => unit_ref(c.u32()?.into())?,
        0x14 => unit_ref(c.u64()?)?,
        0x15 => unit_ref(c.uleb()?)?,
        0x16 => {
            let form = u16::try_from(c.uleb()?).ok()?;
            return read_value(c, s, h, form, 0);
        }
        0x17 => Value::Unsigned(c.sized(h.offset_size)?),
        0x19 => Value::Unsigned(1),
        0x1a | 0x1b | 0x22 | 0x23 | 0x1f01 | 0x1f02 => {
            c.uleb()?;
            Value::Opaque
        }
        0x1c => {
            c.u32()?;
            Value::Opaque
        }
        0x1d | 0x1f20 | 0x1f21 => {
            c.sized(h.offset_size)?;
            Value::Opaque
        }
        0x1e => {
            c.take(16)?;
            Value::Opaque
        }
        0x1f => string_at(s.line_str, c.sized(h.offset_size)?)?,
        0x20 | 0x24 => {
            c.u64()?;
            Value::Opaque
        }
        0x21 => Value::Signed(implicit),
        // strx1..strx4 and addrx1..addrx4.
        0x25..=0x2c => {
            c.take(usize::from((form - 0x25) % 4 + 1))?;
            Value::Opaque
        }
        _ => return None,
    })
}

fn text(v: Option<Value>) -> Option<String> {
    match v? {
        Value::Str(b) => Some(String::from_utf8_lossy(b).into_owned()),
        _ => None,
    }
}

fn unsigned(v: Option<Value>) -> Option<u64> {
    match v? {
        Value::Address(u) | Value::Unsigned(u) => Some(u),
        Value::Signed(i) => u64::try_from(i).ok(),
        // DWARF 2 member locations: `DW_OP_plus_uconst n`.
        Value::Block(b) if b.first() == Some(&DW_OP_PLUS_UCONST) => Cursor::at(b, 1).uleb(),
        _ => None,
    }
}

fn signed(v: Option<Value>) -> Option<i64> {
    match v? {
        Value::Unsigned(u) => Some(u as i64),
        Value::Signed(i) => Some(i),
        _ => None,
    }
}

fn flag(v: Option<Value>) -> bool {
    unsigned(v).is_some_and(|u| u != 0)
}

/// `[low, high)` of a DIE whose `DW_AT_high_pc` is an address or, as a
/// constant, an offset from `DW_AT_low_pc` (DWARF 4 2.17.2).
fn pc_range(d: &Die) -> Option<(u64, u64)> {
    let low = unsigned(d.attr(DW_AT_LOW_PC))?;
    let high = match d.attr(DW_AT_HIGH_PC)? {
        Value::Address(a) => a,
        v => low.checked_add(unsigned(Some(v))?)?,
    };
    Some((low, high))
}

/// The address `DW_OP_addr a`, the whole expression, names.
fn address_expr(expr: &[u8], addr_size: u8) -> Option<u64> {
    let mut c = Cursor::at(expr, 0);
    (c.u8()? == DW_OP_ADDR).then_some(())?;
    let a = c.sized(addr_size)?;
    (c.p == expr.len()).then_some(a)
}

struct UnitReader<'s, 'a> {
    s: &'s Sections<'a>,
    machine: Machine,
    header: &'s UnitHeader,
    dies: Vec<Die<'a>>,
    index: BTreeMap<usize, usize>,
    /// The type each DIE offset of the unit was read as.
    types: BTreeMap<usize, TypeRef>,
    info: &'s mut DebugInfo,
}

impl<'a> UnitReader<'_, 'a> {
    fn die(&self, i: usize) -> &Die<'a> {
        &self.dies[i]
    }

    fn children(&self, i: usize) -> Vec<usize> {
        self.dies[i].children.clone()
    }

    /// `at` of DIE `i`, or of the declaration or abstract instance it
    /// completes.
    fn inherited(&self, mut i: usize, at: u16) -> Option<Value<'a>> {
        for _ in 0..8 {
            let d = &self.dies[i];
            if let Some(v) = d.attr(at) {
                return Some(v);
            }
            match d
                .attr(DW_AT_SPECIFICATION)
                .or(d.attr(DW_AT_ABSTRACT_ORIGIN))
            {
                Some(Value::Ref(off)) => i = *self.index.get(&off)?,
                _ => return None,
            }
        }
        None
    }

    fn name(&self, i: usize) -> Option<String> {
        text(self.inherited(i, DW_AT_NAME))
    }

    fn unit(&mut self) -> Option<Unit> {
        let cu = self.dies.first()?;
        if cu.tag != DW_TAG_COMPILE_UNIT {
            return None;
        }
        let mut unit = Unit {
            name: text(cu.attr(DW_AT_NAME)).unwrap_or_default(),
            producer: text(cu.attr(DW_AT_PRODUCER)).unwrap_or_default(),
            ..Unit::default()
        };
        let comp_dir = text(cu.attr(DW_AT_COMP_DIR));
        let stmt_list = unsigned(cu.attr(DW_AT_STMT_LIST)).and_then(|o| usize::try_from(o).ok());
        if let Some((files, lines)) =
            stmt_list.and_then(|off| read_line_program(self.s, off, self.header.addr_size))
        {
            // A relative name is relative to the compilation directory.
            unit.files = (files.iter())
                .map(|f| join_path(comp_dir.as_deref(), f))
                .collect();
            unit.lines = lines;
        }
        for child in self.children(0) {
            match self.die(child).tag {
                DW_TAG_SUBPROGRAM => {
                    if let Some(f) = self.function(child) {
                        unit.functions.push(f);
                    }
                }
                DW_TAG_VARIABLE => {
                    if let Some(g) = self.global(child) {
                        unit.globals.push(g);
                    }
                }
                DW_TAG_TYPEDEF
                | DW_TAG_STRUCTURE_TYPE
                | DW_TAG_UNION_TYPE
                | DW_TAG_ENUMERATION_TYPE => {
                    if let Some(t) = self.type_at(self.die(child).offset) {
                        unit.types.push(t);
                    }
                }
                _ => {}
            }
        }
        Some(unit)
    }

    fn global(&mut self, i: usize) -> Option<Global> {
        let Some(Value::Block(expr)) = self.die(i).attr(DW_AT_LOCATION) else {
            return None;
        };
        let address = address_expr(expr, self.header.addr_size)?;
        Some(Global {
            name: self.name(i)?,
            ty: self.type_of(i),
            address,
            external: flag(self.inherited(i, DW_AT_EXTERNAL)),
        })
    }

    fn function(&mut self, i: usize) -> Option<Function> {
        let d = self.die(i);
        let (low, high) = pc_range(d)?;
        let frame_base = match d.attr(DW_AT_FRAME_BASE) {
            Some(Value::Block(expr)) => self.register_expr(expr),
            _ => None,
        };
        let t = self.subroutine(i);
        Some(Function {
            name: self.name(i).unwrap_or_default(),
            low,
            high,
            prologue_end: None,
            external: flag(self.inherited(i, DW_AT_EXTERNAL)),
            ty: self.push(t),
            scope: self.scope(i, frame_base),
        })
    }

    /// The variables and nested blocks under DIE `i`.
    fn scope(&mut self, i: usize, frame_base: Option<(Register, i64)>) -> Scope {
        let mut scope = Scope::default();
        for child in self.children(i) {
            let tag = self.die(child).tag;
            match tag {
                DW_TAG_FORMAL_PARAMETER | DW_TAG_VARIABLE => {
                    let Some(name) = self.name(child) else {
                        continue;
                    };
                    let location = match self.die(child).attr(DW_AT_LOCATION) {
                        Some(Value::Block(expr)) => self.location(expr, frame_base),
                        _ => Location::Unavailable,
                    };
                    scope.variables.push(Variable {
                        name,
                        ty: self.type_of(child),
                        is_parameter: tag == DW_TAG_FORMAL_PARAMETER,
                        location,
                    });
                }
                DW_TAG_LEXICAL_BLOCK => {
                    let range = pc_range(self.die(child));
                    let inner = self.scope(child, frame_base);
                    match range {
                        Some((low, high)) => scope.blocks.push(Block {
                            low,
                            high,
                            scope: inner,
                        }),
                        // A block without one contiguous range keeps its
                        // variables in the enclosing scope.
                        None => {
                            scope.variables.extend(inner.variables);
                            scope.blocks.extend(inner.blocks);
                        }
                    }
                }
                _ => {}
            }
        }
        scope
    }

    /// A register-based frame base: `DW_OP_reg<n>` or `DW_OP_breg<n> k`.
    fn register_expr(&self, expr: &[u8]) -> Option<(Register, i64)> {
        let op = *expr.first()?;
        let (reg, offset) = match op {
            DW_OP_REG0..=0x6f if expr.len() == 1 => (op - DW_OP_REG0, 0),
            DW_OP_BREG0..=0x8f => {
                let mut c = Cursor::at(expr, 1);
                let k = c.sleb()?;
                (c.p == expr.len()).then_some((op - DW_OP_BREG0, k))?
            }
            _ => return None,
        };
        Some((self.register(reg)?, offset))
    }

    /// The DWARF register numbers of the psABI supplements (x86-64 3.6.2,
    /// AArch64 DWARF 4.1).
    fn register(&self, dwarf: u8) -> Option<Register> {
        match (self.machine, dwarf) {
            (Machine::X86_64, 6) | (Machine::Aarch64, 29) => Some(Register::FramePointer),
            (Machine::X86_64, 7) | (Machine::Aarch64, 31) => Some(Register::StackPointer),
            _ => None,
        }
    }

    fn location(&self, expr: &[u8], frame_base: Option<(Register, i64)>) -> Location {
        if let Some(a) = address_expr(expr, self.header.addr_size) {
            return Location::Address(a);
        }
        let mut c = Cursor::at(expr, 1);
        let relative = match expr.first() {
            Some(&DW_OP_FBREG) => frame_base.zip(c.sleb()).map(|((r, k), n)| (r, k + n)),
            Some(&op @ DW_OP_BREG0..=0x8f) => self.register(op - DW_OP_BREG0).zip(c.sleb()),
            _ => None,
        };
        match relative {
            Some((base, offset)) if c.p == expr.len() => {
                Location::RegisterRelative { base, offset }
            }
            _ => Location::Unavailable,
        }
    }

    fn type_of(&mut self, i: usize) -> TypeRef {
        match self.inherited(i, DW_AT_TYPE) {
            Some(Value::Ref(off)) => self.type_at(off),
            _ => None,
        }
    }

    fn push(&mut self, t: Type) -> TypeId {
        self.info.types.push(t);
        self.info.types.len() - 1
    }

    /// The type the DIE at `.debug_info` offset `off` describes; `None`
    /// for `void` and for a DIE outside the unit.
    fn type_at(&mut self, off: usize) -> TypeRef {
        if let Some(&t) = self.types.get(&off) {
            return t;
        }
        let i = *self.index.get(&off)?;
        // Reserved before the walk, so a cycle through a member's pointer
        // ends at the slot.
        let id = self.push(Type::Unspecified);
        self.types.insert(off, Some(id));
        let t = self.describe(i);
        self.info.types[id] = t;
        Some(id)
    }

    /// A [`Type::Function`] for the subprogram or subroutine type DIE `i`.
    fn subroutine(&mut self, i: usize) -> Type {
        let ret = self.type_of(i);
        let mut params = Vec::new();
        let mut variadic = false;
        for child in self.children(i) {
            match self.die(child).tag {
                DW_TAG_FORMAL_PARAMETER => {
                    let t = self.type_of(child);
                    params.push(t);
                }
                DW_TAG_UNSPECIFIED_PARAMETERS => variadic = true,
                _ => {}
            }
        }
        let prototyped = flag(self.inherited(i, DW_AT_PROTOTYPED));
        Type::Function {
            ret,
            params,
            variadic: variadic && prototyped,
            prototyped,
        }
    }

    fn describe(&mut self, i: usize) -> Type {
        let d = self.die(i);
        let tag = d.tag;
        let size = unsigned(d.attr(DW_AT_BYTE_SIZE));
        let declaration = flag(d.attr(DW_AT_DECLARATION));
        let encoding = unsigned(d.attr(DW_AT_ENCODING));
        let name = self.name(i);
        let kind = match tag {
            DW_TAG_STRUCTURE_TYPE => TagKind::Struct,
            DW_TAG_UNION_TYPE => TagKind::Union,
            _ => TagKind::Enum,
        };
        match tag {
            DW_TAG_BASE_TYPE => {
                let encoding = match encoding {
                    Some(0x01) => Encoding::Address,
                    Some(0x02) => Encoding::Bool,
                    Some(0x04) => Encoding::Float,
                    Some(0x05) => Encoding::Signed,
                    Some(0x06) => Encoding::SignedChar,
                    Some(0x07) => Encoding::Unsigned,
                    Some(0x08) => Encoding::UnsignedChar,
                    _ => return Type::Unspecified,
                };
                Type::Base {
                    name: name.unwrap_or_default(),
                    size: size.unwrap_or(0) as u32,
                    encoding,
                }
            }
            DW_TAG_POINTER_TYPE | DW_TAG_REFERENCE_TYPE => Type::Pointer {
                pointee: self.type_of(i),
                size: size.map_or(u32::from(self.header.addr_size), |s| s as u32),
            },
            DW_TAG_CONST_TYPE | DW_TAG_VOLATILE_TYPE | DW_TAG_RESTRICT_TYPE => Type::Qualified {
                qualifier: match tag {
                    DW_TAG_CONST_TYPE => Qualifier::Const,
                    DW_TAG_VOLATILE_TYPE => Qualifier::Volatile,
                    _ => Qualifier::Restrict,
                },
                inner: self.type_of(i),
            },
            DW_TAG_ATOMIC_TYPE => match self.type_of(i) {
                Some(inner) => self.info.types[inner].clone(),
                None => Type::Unspecified,
            },
            DW_TAG_TYPEDEF => Type::Typedef {
                name: name.unwrap_or_default(),
                inner: self.type_of(i),
            },
            DW_TAG_STRUCTURE_TYPE | DW_TAG_UNION_TYPE | DW_TAG_ENUMERATION_TYPE if declaration => {
                Type::Declaration { kind, name }
            }
            DW_TAG_STRUCTURE_TYPE | DW_TAG_UNION_TYPE => {
                let mut members = Vec::new();
                for child in self.children(i) {
                    if self.die(child).tag == DW_TAG_MEMBER {
                        members.push(self.member(child));
                    }
                }
                Type::Aggregate {
                    kind,
                    name,
                    size: size.unwrap_or(0),
                    members,
                }
            }
            DW_TAG_ENUMERATION_TYPE => {
                let enumerators = (self.dies[i].children.iter())
                    .map(|&c| &self.dies[c])
                    .filter(|e| e.tag == DW_TAG_ENUMERATOR)
                    .filter_map(|e| {
                        Some((
                            text(e.attr(DW_AT_NAME))?,
                            signed(e.attr(DW_AT_CONST_VALUE))?,
                        ))
                    })
                    .collect();
                Type::Enum {
                    name,
                    size: size.unwrap_or(4) as u32,
                    enumerators,
                }
            }
            DW_TAG_ARRAY_TYPE => {
                let mut dims: Vec<Option<u64>> = (self.dies[i].children.iter())
                    .map(|&c| &self.dies[c])
                    .filter(|r| r.tag == DW_TAG_SUBRANGE_TYPE)
                    .map(|r| {
                        unsigned(r.attr(DW_AT_COUNT))
                            .or_else(|| unsigned(r.attr(DW_AT_UPPER_BOUND)).map(|u| u + 1))
                    })
                    .collect();
                if dims.is_empty() {
                    dims.push(None);
                }
                Type::Array {
                    element: self.type_of(i),
                    dims,
                }
            }
            DW_TAG_SUBROUTINE_TYPE => self.subroutine(i),
            _ => Type::Unspecified,
        }
    }

    fn member(&mut self, i: usize) -> Member {
        let d = self.die(i);
        let offset = unsigned(d.attr(DW_AT_DATA_MEMBER_LOCATION)).unwrap_or(0);
        let bits = match (
            unsigned(d.attr(DW_AT_BIT_SIZE)),
            unsigned(d.attr(DW_AT_DATA_BIT_OFFSET)),
        ) {
            (Some(w), Some(first)) => Some((first, w as u32)),
            // DWARF 2 counts `DW_AT_bit_offset` from the storage unit's
            // most significant bit (DWARF 4 D.2.8).
            (Some(w), None) => {
                let unit_bits = unsigned(d.attr(DW_AT_BYTE_SIZE)).unwrap_or(4) * 8;
                let msb = unsigned(d.attr(DW_AT_BIT_OFFSET)).unwrap_or(0);
                (unit_bits.checked_sub(msb + w)).map(|lsb| (offset * 8 + lsb, w as u32))
            }
            _ => None,
        };
        Member {
            name: text(d.attr(DW_AT_NAME)),
            ty: self.type_of(i),
            offset: bits.map_or(offset, |(first, _)| first / 8),
            bits,
        }
    }
}

/// The file table and the row sequences of the line program at `off`.
fn read_line_program<'a>(
    s: &Sections<'a>,
    off: usize,
    addr_size: u8,
) -> Option<(Vec<String>, Vec<LineSequence>)> {
    let mut c = Cursor::at(s.line, off);
    let (length, offset_size) = c.initial_length()?;
    let end = c.p.checked_add(usize::try_from(length).ok()?)?;
    if end > s.line.len() {
        return None;
    }
    let version = c.u16()?;
    if version >= 5 {
        c.take(2)?; // address_size, segment_selector_size
    }
    let header_length = usize::try_from(c.sized(offset_size)?).ok()?;
    let program = c.p.checked_add(header_length)?;
    let min_inst = u64::from(c.u8()?);
    if version >= 4 {
        c.u8()?; // maximum_operations_per_instruction
    }
    c.u8()?; // default_is_stmt
    let line_base = c.u8()? as i8;
    let line_range = c.u8()?.max(1);
    let opcode_base = c.u8()?;
    let lengths = c.take(usize::from(opcode_base.saturating_sub(1)))?;
    let files = if version >= 5 {
        let h = UnitHeader {
            offset: 0,
            dies: 0,
            end: 0,
            version,
            abbrev: 0,
            addr_size,
            offset_size,
        };
        let dirs = v5_entries(&mut c, s, &h, &[])?;
        v5_entries(&mut c, s, &h, &dirs)?
    } else {
        v4_file_names(&mut c)?
    };
    // DWARF 5 numbers files from 0, the earlier versions from 1.
    let file_base = u64::from(version < 5);
    let mut c = Cursor::at(&s.line[..end], program);
    let mut seqs = Vec::new();
    let mut seq = LineSequence::default();
    let (mut addr, mut file, mut line, mut prologue_end) = (0u64, 1u64, 1i64, false);
    let row = |seq: &mut LineSequence, addr: u64, file: u64, line: i64, pe: bool| {
        if let (Some(f), Ok(l)) = (file.checked_sub(file_base), u32::try_from(line)) {
            seq.rows.push(LineRow {
                address: addr,
                file: f as u32,
                line: l,
                prologue_end: pe,
            });
        }
    };
    while c.p < end {
        let op = c.u8()?;
        if op >= opcode_base {
            let adj = op - opcode_base;
            addr = addr.wrapping_add(u64::from(adj / line_range) * min_inst);
            line += i64::from(line_base) + i64::from(adj % line_range);
            row(&mut seq, addr, file, line, prologue_end);
            prologue_end = false;
            continue;
        }
        match op {
            0 => {
                let len = usize::try_from(c.uleb()?).ok()?;
                let mut e = Cursor::at(c.take(len)?, 0);
                match e.u8()? {
                    1 => {
                        seq.end = addr;
                        seqs.push(core::mem::take(&mut seq));
                        (addr, file, line, prologue_end) = (0, 1, 1, false);
                    }
                    2 => addr = e.sized(addr_size)?,
                    _ => {}
                }
            }
            1 => {
                row(&mut seq, addr, file, line, prologue_end);
                prologue_end = false;
            }
            2 => addr = addr.wrapping_add(c.uleb()? * min_inst),
            3 => line += c.sleb()?,
            4 => file = c.uleb()?,
            8 => addr = addr.wrapping_add(u64::from((255 - opcode_base) / line_range) * min_inst),
            9 => addr = addr.wrapping_add(u64::from(c.u16()?)),
            10 => prologue_end = true,
            _ => {
                for _ in 0..*lengths.get(usize::from(op) - 1)? {
                    c.uleb()?;
                }
            }
        }
    }
    Some((files, seqs))
}

/// The DWARF 2-4 `include_directories` and `file_names` lists, the
/// directory joined to each name.
fn v4_file_names(c: &mut Cursor) -> Option<Vec<String>> {
    let mut dirs: Vec<String> = Vec::new();
    loop {
        let d = c.cstr()?;
        if d.is_empty() {
            break;
        }
        dirs.push(String::from_utf8_lossy(d).into_owned());
    }
    let mut files = Vec::new();
    loop {
        let name = c.cstr()?;
        if name.is_empty() {
            return Some(files);
        }
        let dir = c.uleb()?;
        c.uleb()?; // mtime
        c.uleb()?; // length
        let dir = dir.checked_sub(1).and_then(|d| dirs.get(d as usize));
        files.push(join_path(
            dir.map(String::as_str),
            &String::from_utf8_lossy(name),
        ));
    }
}

/// One DWARF 5 directory or file name table (DWARF 5 6.2.4), each path
/// joined to the directory `dirs` holds for it.
fn v5_entries<'a>(
    c: &mut Cursor<'a>,
    s: &Sections<'a>,
    h: &UnitHeader,
    dirs: &[String],
) -> Option<Vec<String>> {
    let n_formats = c.u8()?;
    let mut formats = Vec::new();
    for _ in 0..n_formats {
        formats.push((c.uleb()?, u16::try_from(c.uleb()?).ok()?));
    }
    let mut out = Vec::new();
    for _ in 0..c.uleb()? {
        let (mut name, mut dir) = (String::new(), None);
        for &(content, form) in &formats {
            let v = read_value(c, s, h, form, 0)?;
            match content {
                1 => name = text(Some(v)).unwrap_or_default(),
                2 => dir = unsigned(Some(v)),
                _ => {}
            }
        }
        let dir = dir.and_then(|d| dirs.get(d as usize)).map(String::as_str);
        out.push(join_path(dir, &name));
    }
    Some(out)
}

fn join_path(dir: Option<&str>, name: &str) -> String {
    let absolute = name.starts_with(['/', '\\']) || name.as_bytes().get(1) == Some(&b':');
    match dir {
        Some(d) if !d.is_empty() && !absolute => {
            let sep = if d.contains('\\') { '\\' } else { '/' };
            alloc::format!("{}{sep}{name}", d.trim_end_matches(['/', '\\']))
        }
        _ => String::from(name),
    }
}

/// A bounds-checked little-endian reader.
struct Cursor<'a> {
    b: &'a [u8],
    p: usize,
}

impl<'a> Cursor<'a> {
    fn at(b: &'a [u8], p: usize) -> Self {
        Cursor { b, p }
    }

    fn take(&mut self, n: usize) -> Option<&'a [u8]> {
        let s = self.b.get(self.p..self.p.checked_add(n)?)?;
        self.p += n;
        Some(s)
    }

    fn u8(&mut self) -> Option<u8> {
        Some(self.take(1)?[0])
    }

    fn u16(&mut self) -> Option<u16> {
        Some(u16::from_le_bytes(self.take(2)?.try_into().ok()?))
    }

    fn u32(&mut self) -> Option<u32> {
        Some(u32::from_le_bytes(self.take(4)?.try_into().ok()?))
    }

    fn u64(&mut self) -> Option<u64> {
        Some(u64::from_le_bytes(self.take(8)?.try_into().ok()?))
    }

    fn sized(&mut self, n: u8) -> Option<u64> {
        match n {
            1 => self.u8().map(u64::from),
            2 => self.u16().map(u64::from),
            4 => self.u32().map(u64::from),
            8 => self.u64(),
            _ => None,
        }
    }

    /// A unit length and the offset size its format implies (DWARF 4 7.4).
    fn initial_length(&mut self) -> Option<(u64, u8)> {
        match self.u32()? {
            0xffff_ffff => Some((self.u64()?, 8)),
            n if n < 0xffff_fff0 => Some((u64::from(n), 4)),
            _ => None,
        }
    }

    fn uleb(&mut self) -> Option<u64> {
        let (mut v, mut shift) = (0u64, 0u32);
        loop {
            let byte = self.u8()?;
            if shift < 64 {
                v |= u64::from(byte & 0x7f) << shift;
            }
            shift += 7;
            if byte & 0x80 == 0 {
                return Some(v);
            }
        }
    }

    fn sleb(&mut self) -> Option<i64> {
        let (mut v, mut shift) = (0i64, 0u32);
        loop {
            let byte = self.u8()?;
            if shift < 64 {
                v |= i64::from(byte & 0x7f) << shift;
            }
            shift += 7;
            if byte & 0x80 == 0 {
                if shift < 64 && byte & 0x40 != 0 {
                    v |= -1i64 << shift;
                }
                return Some(v);
            }
        }
    }

    fn cstr(&mut self) -> Option<&'a [u8]> {
        let rest = self.b.get(self.p..)?;
        let n = rest.iter().position(|&c| c == 0)?;
        self.p += n + 1;
        Some(&rest[..n])
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::c5::codegen::ssa::cfi::{write_sleb128, write_uleb128};

    /// One abbreviation: code, tag, children, `(attribute, form)` pairs.
    fn abbrev(out: &mut Vec<u8>, code: u64, tag: u16, children: bool, attrs: &[(u16, u16)]) {
        write_uleb128(out, code);
        write_uleb128(out, tag.into());
        out.push(u8::from(children));
        for &(a, f) in attrs {
            write_uleb128(out, a.into());
            write_uleb128(out, f.into());
        }
        out.extend_from_slice(&[0, 0]);
    }

    fn cstr(out: &mut Vec<u8>, s: &str) {
        out.extend_from_slice(s.as_bytes());
        out.push(0);
    }

    /// A DWARF 4 unit as the relocatable emitter writes one, the
    /// relocations applied: `int f(int x)` at 0x1000..0x1010 with frame
    /// base `DW_OP_reg6`, `x` at `DW_OP_fbreg -20`, and `struct node {
    /// struct node *next; unsigned bits : 3; }`; and its line program with a
    /// `prologue_end` row at 0x1004.
    fn unit_sections() -> (Vec<u8>, Vec<u8>, Vec<u8>, Vec<u8>) {
        let mut ab = Vec::new();
        abbrev(
            &mut ab,
            1,
            DW_TAG_COMPILE_UNIT,
            true,
            &[(0x03, 0x0e), (0x25, 0x08), (0x10, 0x17)],
        );
        abbrev(
            &mut ab,
            2,
            DW_TAG_BASE_TYPE,
            false,
            &[(0x03, 0x08), (0x0b, 0x0b), (0x3e, 0x0b)],
        );
        abbrev(
            &mut ab,
            3,
            DW_TAG_SUBPROGRAM,
            true,
            &[
                (0x03, 0x08),
                (0x11, 0x01),
                (0x12, 0x07),
                (0x40, 0x18),
                (0x3f, 0x19),
                (0x27, 0x0c),
                (0x49, 0x13),
            ],
        );
        abbrev(
            &mut ab,
            4,
            DW_TAG_FORMAL_PARAMETER,
            false,
            &[(0x03, 0x08), (0x49, 0x13), (0x02, 0x18)],
        );
        abbrev(
            &mut ab,
            5,
            DW_TAG_STRUCTURE_TYPE,
            true,
            &[(0x03, 0x08), (0x0b, 0x0b)],
        );
        abbrev(
            &mut ab,
            6,
            DW_TAG_MEMBER,
            false,
            &[(0x03, 0x08), (0x49, 0x13), (0x38, 0x0b)],
        );
        abbrev(
            &mut ab,
            7,
            DW_TAG_POINTER_TYPE,
            false,
            &[(0x0b, 0x0b), (0x49, 0x13)],
        );
        abbrev(
            &mut ab,
            8,
            DW_TAG_MEMBER,
            false,
            &[(0x03, 0x08), (0x49, 0x13), (0x6b, 0x0b), (0x0d, 0x0b)],
        );
        ab.push(0);
        let strs = b"\0a.c\0".to_vec();
        // A `DW_FORM_ref4` slot, filled once its target is placed.
        let ref4 = |d: &mut Vec<u8>| {
            d.extend_from_slice(&[0; 4]);
            d.len() - 4
        };
        let mut d = vec![0u8; 11];
        d.push(1);
        d.extend_from_slice(&1u32.to_le_bytes());
        cstr(&mut d, "t");
        d.extend_from_slice(&0u32.to_le_bytes());
        let int_at = d.len();
        d.push(2);
        cstr(&mut d, "int");
        d.extend_from_slice(&[4, 0x05]);
        let unsigned_at = d.len();
        d.push(2);
        cstr(&mut d, "unsigned");
        d.extend_from_slice(&[4, 0x07]);
        let node_at = d.len();
        d.push(5);
        cstr(&mut d, "node");
        d.push(16);
        d.push(6);
        cstr(&mut d, "next");
        let next_ty = ref4(&mut d);
        d.push(0);
        d.push(8);
        cstr(&mut d, "bits");
        let bits_ty = ref4(&mut d);
        d.extend_from_slice(&[64, 3]);
        d.push(0);
        let ptr_at = d.len();
        d.extend_from_slice(&[7, 8]);
        let ptr_ty = ref4(&mut d);
        d.push(3);
        cstr(&mut d, "f");
        d.extend_from_slice(&0x1000u64.to_le_bytes());
        d.extend_from_slice(&0x10u64.to_le_bytes());
        d.extend_from_slice(&[1, 0x56, 1]);
        let ret_ty = ref4(&mut d);
        d.push(4);
        cstr(&mut d, "x");
        let x_ty = ref4(&mut d);
        let mut loc = vec![DW_OP_FBREG];
        write_sleb128(&mut loc, -20);
        d.push(loc.len() as u8);
        d.extend_from_slice(&loc);
        d.extend_from_slice(&[0, 0]);
        for (slot, target) in [
            (next_ty, ptr_at),
            (bits_ty, unsigned_at),
            (ptr_ty, node_at),
            (ret_ty, int_at),
            (x_ty, int_at),
        ] {
            d[slot..slot + 4].copy_from_slice(&(target as u32).to_le_bytes());
        }
        let len = (d.len() - 4) as u32;
        d[0..4].copy_from_slice(&len.to_le_bytes());
        d[4..6].copy_from_slice(&4u16.to_le_bytes());
        d[10] = 8;

        let mut hdr = vec![1, 1, 1, (-1i8) as u8, 14, 13];
        hdr.extend_from_slice(&[0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1]);
        hdr.push(0);
        cstr(&mut hdr, "a.c");
        hdr.extend_from_slice(&[0, 0, 0, 0]);
        let mut prog = vec![0, 9, 2];
        prog.extend_from_slice(&0x1000u64.to_le_bytes());
        prog.push(1); // copy: line 1
        prog.extend_from_slice(&[2, 4, 3, 1, 10, 1]); // +4, line 2, prologue_end
        prog.extend_from_slice(&[2, 12, 0, 1, 1]); // to 0x1010, end_sequence
        let mut line = Vec::new();
        line.extend_from_slice(&((2 + 4 + hdr.len() + prog.len()) as u32).to_le_bytes());
        line.extend_from_slice(&4u16.to_le_bytes());
        line.extend_from_slice(&(hdr.len() as u32).to_le_bytes());
        line.extend_from_slice(&hdr);
        line.extend_from_slice(&prog);
        (d, ab, strs, line)
    }

    #[test]
    fn a_unit_reads_into_functions_types_and_lines() {
        let (info, abbrev, str, line) = unit_sections();
        let s = Sections {
            info: &info,
            abbrev: &abbrev,
            str: &str,
            line: &line,
            line_str: &[],
        };
        let m = read(&s, Machine::X86_64);
        assert_eq!(m.units.len(), 1);
        let u = &m.units[0];
        assert_eq!((u.name.as_str(), u.producer.as_str()), ("a.c", "t"));
        assert_eq!(u.files, ["a.c"]);
        let f = &u.functions[0];
        assert_eq!((f.name.as_str(), f.low, f.high), ("f", 0x1000, 0x1010));
        assert!(f.external);
        assert_eq!(f.prologue_end, Some(0x1004));
        let x = &f.scope.variables[0];
        assert!(x.is_parameter);
        assert_eq!(
            x.location,
            Location::RegisterRelative {
                base: Register::FramePointer,
                offset: -20
            }
        );
        let Type::Function { ret, params, .. } = &m.types[f.ty] else {
            panic!("{:?}", m.types[f.ty]);
        };
        assert_eq!((*ret, params.as_slice()), (x.ty, &[x.ty][..]));
        let rows: Vec<(u64, u32, bool)> = (u.lines[0].rows.iter())
            .map(|r| (r.address, r.line, r.prologue_end))
            .collect();
        assert_eq!(rows, [(0x1000, 1, false), (0x1004, 2, true)]);
        assert_eq!(u.lines[0].end, 0x1010);
        // The struct, through its member's pointer, back to itself.
        let node =
            u.types.iter().copied().find(
                |&t| matches!(&m.types[t], Type::Aggregate { name: Some(n), .. } if n == "node"),
            );
        let Some(Type::Aggregate { members, size, .. }) = node.map(|t| &m.types[t]) else {
            panic!("no `struct node`: {:?}", m.types);
        };
        assert_eq!(*size, 16);
        let Some(Type::Pointer { pointee, size: 8 }) = members[0].ty.map(|t| &m.types[t]) else {
            panic!("{:?}", members[0]);
        };
        assert_eq!(*pointee, node);
        assert_eq!((members[1].offset, members[1].bits), (8, Some((64, 3))));
    }

    #[test]
    fn a_truncated_unit_is_left_out() {
        let (info, abbrev, str, line) = unit_sections();
        for cut in [5, 30, info.len() - 3] {
            let s = Sections {
                info: &info[..cut],
                abbrev: &abbrev,
                str: &str,
                line: &line,
                line_str: &[],
            };
            assert!(read(&s, Machine::X86_64).units.is_empty(), "cut at {cut}");
        }
        let s = Sections {
            info: &info,
            abbrev: &abbrev[..10],
            str: &str,
            line: &line,
            line_str: &[],
        };
        assert!(read(&s, Machine::X86_64).units.is_empty());
        // A unit whose line program is cut keeps its functions.
        let s = Sections {
            info: &info,
            abbrev: &abbrev,
            str: &str,
            line: &line[..20],
            line_str: &[],
        };
        let m = read(&s, Machine::X86_64);
        assert_eq!(m.units[0].functions.len(), 1);
        assert!(m.units[0].lines.is_empty());
    }
}
