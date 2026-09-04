//! The catalogue: one row per diagnostic, and the accessors generated
//! from it.
//!
//! Canonical names reuse gcc's and clang's spellings wherever the
//! diagnostic corresponds, so an existing `#pragma GCC diagnostic
//! ignored "-W..."` in real source applies. Aliases accept the other
//! compilers' identifiers as selectors: gcc and clang names where they
//! differ, and MSVC numbers spelled with their letter prefix (`C4101`,
//! `D9002`), which `#pragma warning(...)` spells bare. Only the
//! canonical name and the `B` code are ever printed.

use alloc::format;

use super::code::{Class, Code, Groups, Level, Status};

/// One catalogue entry. The code and the name are the published
/// contract and never change; the default level and the groups may.
#[derive(Clone, Copy, Debug)]
pub struct Row {
    pub code: Code,
    pub name: &'static str,
    pub aliases: &'static [&'static str],
    pub default_level: Level,
    pub class: Class,
    pub groups: Groups,
    pub status: Status,
    pub description: &'static str,
}

macro_rules! catalog {
    ($(
        $code:literal, $name:literal, [$($alias:literal),*], $level:ident, $class:ident,
        [$($group:ident),*], $status:ident, $desc:literal;
    )*) => {
        static ROWS: &[Row] = &[$(Row {
            code: Code::new($code),
            name: $name,
            aliases: &[$($alias),*],
            default_level: Level::$level,
            class: Class::$class,
            groups: Groups::union_all(&[$(Groups::$group),*]),
            status: Status::$status,
            description: $desc,
        }),*];
    };
}

// A row is: code, canonical name, aliases, default level, class,
// groups, status, description. Groups say what a `-W` selector turns
// on, so only a controllable row carries them: a row that only a group
// turns on defaults to `Ignore`, which is what enabling the group
// raises.
catalog! {
    2001, "unused-variable", [], Ignore, Controllable,
        [ALL], Live,
        "a variable declared and never used";
    2002, "unused-parameter", [], Ignore, Controllable,
        [EXTRA], Live,
        "a parameter never used in the function body";
    2003, "unused-but-set-variable", [], Ignore, Controllable,
        [ALL], Live,
        "a variable that is only ever assigned to";
    2004, "unused-function", [], Ignore, Controllable,
        [ALL], Live,
        "a function with internal linkage that is defined and never referenced";
    2005, "implicit-function-declaration", [], Warning, Controllable,
        [DEFAULT], Live,
        "a function used before a prototype declares it, so its return type is `int`";
    2006, "undefined-function", [], Warning, Controllable,
        [DEFAULT], Live,
        "an initializer names a function this unit neither defines nor declares `extern`";
    2007, "redeclaration-mismatch", [], Warning, Controllable,
        [DEFAULT], Live,
        "a redeclaration whose signature differs from the previous one";
    2008, "attributes", ["ignored-attributes"], Warning, Controllable,
        [DEFAULT], Live,
        "an attribute the declaration cannot carry, so it is ignored";
    2009, "ignored-asm-label", [], Warning, Controllable,
        [DEFAULT], Live,
        "an assembler name on a declaration that has no symbol to rename";
    2010, "shadowed-binding", [], Warning, Controllable,
        [DEFAULT], Live,
        "a `#pragma binding` for a name an earlier binding already claimed";
    3001, "int-conversion", [], Warning, Controllable,
        [DEFAULT], Live,
        "an integer and a pointer exchanged with no cast";
    3002, "incompatible-struct-types", [], Warning, Controllable,
        [DEFAULT], Live,
        "an aggregate used where a different aggregate type is expected";
    3003, "return-type", [], Ignore, Controllable,
        [ALL], Live,
        "control reaches the end of a value-returning function";
    3004, "too-few-arguments", [], Warning, Controllable,
        [DEFAULT], Live,
        "a call passing fewer arguments than the prototype declares";
    3005, "too-many-arguments", [], Warning, Controllable,
        [DEFAULT], Live,
        "a call passing more arguments than the prototype declares";
    3006, "long-double-abi", ["psabi"], Warning, Controllable,
        [DEFAULT], Live,
        "a `long double` argument passed in a format this target's ABI does not use";
    3007, "dead-store", [], Ignore, Controllable,
        [], Live,
        "a value assigned to a local and replaced before any read";
    7001, "unknown-argument", ["D9002"], Error, Hard,
        [], Live,
        "command-line option or operand the driver does not implement";
    7002, "unknown-warning-option", ["pragmas"], Warning, Controllable,
        [DEFAULT], Live,
        "a diagnostic pragma names a selector that is not in the catalogue";
    7003, "unused-command-line-argument", [], Ignore, Controllable,
        [ALL, EXTRA], Live,
        "an accepted option that selects nothing in the mode the command line picked";
    7004, "no-input-files", [], Error, Hard,
        [], Live,
        "the command line names nothing to compile, assemble or link";
    7005, "input-unreadable", [], Error, Hard,
        [], Live,
        "an input file the driver cannot read";
    7006, "output-unwritable", [], Error, Hard,
        [], Live,
        "the driver cannot write the file it was asked to produce";
    7007, "unsupported-option", [], Error, Controllable,
        [DEFAULT], Live,
        "an option badc parses but declines in the mode the command line picked";
    7008, "link-pragma-ignored", [], Warning, Controllable,
        [DEFAULT], Live,
        "a link request from a source pragma that an object file does not carry";
    7009, "cross-target-output", [], Warning, Note,
        [], Live,
        "the image is for another host and will not run where it was built";
}

/// Every row, in catalogue order.
pub fn rows() -> impl Iterator<Item = &'static Row> {
    ROWS.iter()
}

/// The accessors the catalogue generates. `Code` is constructible only
/// from a row, so every lookup here resolves; the fallbacks keep the
/// accessors total without a panic path.
impl Code {
    pub fn row(self) -> Option<&'static Row> {
        ROWS.iter().find(|r| r.code == self)
    }

    pub fn name(self) -> &'static str {
        self.row().map_or("", |r| r.name)
    }

    pub fn default_level(self) -> Level {
        self.row().map_or(Level::Error, |r| r.default_level)
    }

    pub fn class(self) -> Class {
        self.row().map_or(Class::Hard, |r| r.class)
    }

    pub fn groups(self) -> Groups {
        self.row().map_or(Groups::NONE, |r| r.groups)
    }

    pub fn status(self) -> Status {
        self.row().map_or(Status::Live, |r| r.status)
    }

    pub fn description(self) -> &'static str {
        self.row().map_or("", |r| r.description)
    }

    pub fn is_retired(self) -> bool {
        self.status() == Status::Retired
    }

    /// Resolve a selector: the canonical name, an alias, or the `B`
    /// code as printed. The `-W` / `-Wno-` prefix and the `error=`
    /// head belong to the option grammar and the caller strips them.
    pub fn from_selector(sel: &str) -> Option<Code> {
        if let Some(digits) = sel.strip_prefix('B')
            && digits.len() == 4
            && let Ok(value) = digits.parse::<u16>()
        {
            return Code::new(value).row().map(|r| r.code);
        }
        ROWS.iter()
            .find(|r| r.name == sel || r.aliases.contains(&sel))
            .map(|r| r.code)
    }

    /// Resolve a bare MSVC warning number, which is how
    /// `#pragma warning(...)` spells one. The row lists it with the
    /// `C` prefix badc's own selector grammar takes.
    pub fn from_msvc_number(number: u32) -> Option<Code> {
        Code::from_selector(&format!("C{number}"))
    }
}

/// The codes report sites name. A test checks each against its row, so
/// a site never looks a name up at run time.
impl Code {
    pub const UNUSED_VARIABLE: Code = Code::new(2001);
    pub const UNUSED_PARAMETER: Code = Code::new(2002);
    pub const UNUSED_BUT_SET_VARIABLE: Code = Code::new(2003);
    pub const UNUSED_FUNCTION: Code = Code::new(2004);
    pub const IMPLICIT_FUNCTION_DECLARATION: Code = Code::new(2005);
    pub const UNDEFINED_FUNCTION: Code = Code::new(2006);
    pub const REDECLARATION_MISMATCH: Code = Code::new(2007);
    pub const ATTRIBUTES: Code = Code::new(2008);
    pub const IGNORED_ASM_LABEL: Code = Code::new(2009);
    pub const SHADOWED_BINDING: Code = Code::new(2010);
    pub const INT_CONVERSION: Code = Code::new(3001);
    pub const INCOMPATIBLE_STRUCT_TYPES: Code = Code::new(3002);
    pub const RETURN_TYPE: Code = Code::new(3003);
    pub const TOO_FEW_ARGUMENTS: Code = Code::new(3004);
    pub const TOO_MANY_ARGUMENTS: Code = Code::new(3005);
    pub const LONG_DOUBLE_ABI: Code = Code::new(3006);
    pub const DEAD_STORE: Code = Code::new(3007);
    pub const LINK_PRAGMA_IGNORED: Code = Code::new(7008);
}
