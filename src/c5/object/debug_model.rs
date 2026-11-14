//! An image's debug information in no container format: its compilation
//! units' functions, scopes, variables and line rows over one type graph.
//! The DWARF reader fills it; the CodeView writer reads it.

use alloc::string::String;
use alloc::vec::Vec;

pub(crate) type TypeId = usize;

/// A type reference; `None` is `void`.
pub(crate) type TypeRef = Option<TypeId>;

#[derive(Default, Debug)]
pub(crate) struct DebugInfo {
    pub units: Vec<Unit>,
    pub types: Vec<Type>,
}

/// How a base type's bits are read (DWARF 4 7.8, `DW_ATE_*`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Encoding {
    Signed,
    Unsigned,
    SignedChar,
    UnsignedChar,
    Bool,
    Float,
    Address,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum TagKind {
    Struct,
    Union,
    Enum,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Qualifier {
    Const,
    Volatile,
    Restrict,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct Member {
    /// `None` for an anonymous structure or union member (C11 6.7.2.1p13).
    pub name: Option<String>,
    pub ty: TypeRef,
    pub offset: u64,
    /// A bit-field's first bit from the start of the aggregate, its width.
    pub bits: Option<(u64, u32)>,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) enum Type {
    Base {
        name: String,
        size: u32,
        encoding: Encoding,
    },
    Pointer {
        pointee: TypeRef,
        size: u32,
    },
    Qualified {
        qualifier: Qualifier,
        inner: TypeRef,
    },
    Typedef {
        name: String,
        inner: TypeRef,
    },
    Aggregate {
        kind: TagKind,
        name: Option<String>,
        size: u64,
        members: Vec<Member>,
    },
    /// A tag the unit declares without completing it (C99 6.7.2.3).
    Declaration {
        kind: TagKind,
        name: Option<String>,
    },
    Enum {
        name: Option<String>,
        size: u32,
        enumerators: Vec<(String, i64)>,
    },
    /// Each dimension's count, outermost first; `None` is unknown.
    Array {
        element: TypeRef,
        dims: Vec<Option<u64>>,
    },
    Function {
        ret: TypeRef,
        params: Vec<TypeRef>,
        variadic: bool,
        prototyped: bool,
    },
    Unspecified,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Register {
    FramePointer,
    StackPointer,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum Location {
    /// `offset` bytes from the value `base` holds in the function's body.
    RegisterRelative {
        base: Register,
        offset: i64,
    },
    Address(u64),
    Unavailable,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct Variable {
    pub name: String,
    pub ty: TypeRef,
    pub is_parameter: bool,
    pub location: Location,
}

#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub(crate) struct Scope {
    pub variables: Vec<Variable>,
    pub blocks: Vec<Block>,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct Block {
    pub low: u64,
    pub high: u64,
    pub scope: Scope,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct Function {
    pub name: String,
    pub low: u64,
    pub high: u64,
    /// The first address past the prologue, where a breakpoint stops.
    pub prologue_end: Option<u64>,
    pub external: bool,
    /// A [`Type::Function`].
    pub ty: TypeId,
    pub scope: Scope,
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub(crate) struct Global {
    pub name: String,
    pub ty: TypeRef,
    pub address: u64,
    pub external: bool,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) struct LineRow {
    pub address: u64,
    pub file: u32,
    pub line: u32,
    pub prologue_end: bool,
}

/// Rows of ascending address; the last row covers up to `end`.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub(crate) struct LineSequence {
    pub rows: Vec<LineRow>,
    pub end: u64,
}

#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub(crate) struct Unit {
    pub name: String,
    pub producer: String,
    pub files: Vec<String>,
    pub functions: Vec<Function>,
    pub globals: Vec<Global>,
    /// The typedefs and tagged types the unit declares at file scope.
    pub types: Vec<TypeId>,
    pub lines: Vec<LineSequence>,
}

impl DebugInfo {
    /// `ty` with its typedefs and qualifiers looked through; a chain that
    /// does not end, which only a malformed input describes, is `void`.
    pub(crate) fn strip(&self, mut ty: TypeRef) -> TypeRef {
        for _ in 0..=self.types.len() {
            match ty.map(|id| &self.types[id]) {
                Some(Type::Typedef { inner, .. } | Type::Qualified { inner, .. }) => ty = *inner,
                _ => return ty,
            }
        }
        None
    }

    /// Each function's first row flagged `prologue_end`, else its first
    /// row past its entry.
    pub(crate) fn mark_prologue_ends(&mut self) {
        for unit in &mut self.units {
            let mut rows: Vec<LineRow> = (unit.lines.iter())
                .flat_map(|s| s.rows.iter().copied())
                .collect();
            rows.sort_by_key(|r| r.address);
            for f in &mut unit.functions {
                let start = rows.partition_point(|r| r.address < f.low);
                let end = rows.partition_point(|r| r.address < f.high);
                let body = &rows[start..end];
                f.prologue_end = (body.iter().find(|r| r.prologue_end))
                    .or_else(|| body.iter().find(|r| r.address > f.low))
                    .map(|r| r.address);
            }
        }
    }
}
