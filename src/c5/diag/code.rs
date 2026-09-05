//! Diagnostic identity: the code, the severity it resolves to, the
//! class that says whether an option may change it, and the group bits
//! a `-W<group>` selector expands to.

use core::fmt;

/// A diagnostic's stable identity, printed `B<code>`. A code is
/// allocated once and never reused or renumbered. The numeric ranges
/// are a reading aid, not a rule: 1xxx preprocessor and lexer, 2xxx
/// syntax and declarations, 3xxx constraints and types, 4xxx IR and
/// codegen limits, 5xxx assembler, 6xxx object writers and linker,
/// 7xxx driver, 9xxx internal.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Debug)]
pub struct Code(u16);

impl Code {
    pub(crate) const fn new(value: u16) -> Self {
        Self(value)
    }

    pub const fn value(self) -> u16 {
        self.0
    }
}

impl fmt::Display for Code {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "B{:04}", self.0)
    }
}

/// What a diagnostic does when it fires. This is the axis the user
/// changes, which is why neither the code nor the name encodes it.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Debug)]
pub enum Level {
    Ignore,
    Warning,
    Error,
}

impl Level {
    pub const fn as_str(self) -> &'static str {
        match self {
            Level::Ignore => "ignore",
            Level::Warning => "warning",
            Level::Error => "error",
        }
    }
}

/// Whether an option or a pragma may change a diagnostic's level.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Class {
    /// `-W`, `-Werror=`, `-Wno-error=` and the diagnostic pragmas
    /// select it.
    Controllable,
    /// Always an error: no resynchronisation point, a broken internal
    /// invariant, or a failed link.
    Hard,
    /// Advisory. Prints `note:`, and no option changes it.
    Note,
}

impl Class {
    pub const fn as_str(self) -> &'static str {
        match self {
            Class::Controllable => "controllable",
            Class::Hard => "hard",
            Class::Note => "note",
        }
    }
}

/// Whether any site emits the diagnostic. A retired code keeps its row
/// so the code is never reused, and its selector is accepted with no
/// effect so an existing build script keeps working.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Status {
    Live,
    Retired,
}

impl Status {
    pub const fn as_str(self) -> &'static str {
        match self {
            Status::Live => "live",
            Status::Retired => "retired",
        }
    }
}

/// The group selectors a row belongs to. `DEFAULT` is what a bare
/// `badc file.c` reports; the rest are what `-Wall`, `-Wextra` and
/// `-Wpedantic` turn on, following gcc's split.
#[derive(Clone, Copy, PartialEq, Eq, Default, Debug)]
pub struct Groups(u8);

impl Groups {
    pub const NONE: Groups = Groups(0);
    pub const DEFAULT: Groups = Groups(1 << 0);
    pub const ALL: Groups = Groups(1 << 1);
    pub const EXTRA: Groups = Groups(1 << 2);
    pub const PEDANTIC: Groups = Groups(1 << 3);

    /// The `-W<name>` spellings that expand to a group. `default` is
    /// not among them: it names the rows no option has to ask for.
    pub const SELECTABLE: [(Groups, &'static str); 3] = [
        (Groups::ALL, "all"),
        (Groups::EXTRA, "extra"),
        (Groups::PEDANTIC, "pedantic"),
    ];

    const NAMED: [(Groups, &'static str); 4] = [
        (Groups::DEFAULT, "default"),
        (Groups::ALL, "all"),
        (Groups::EXTRA, "extra"),
        (Groups::PEDANTIC, "pedantic"),
    ];

    pub(crate) const fn union_all(parts: &[Groups]) -> Groups {
        let mut bits = 0u8;
        let mut i = 0;
        while i < parts.len() {
            bits |= parts[i].0;
            i += 1;
        }
        Groups(bits)
    }

    pub const fn contains(self, other: Groups) -> bool {
        self.0 & other.0 == other.0
    }

    pub const fn is_empty(self) -> bool {
        self.0 == 0
    }

    pub fn from_selector(name: &str) -> Option<Groups> {
        Groups::SELECTABLE
            .iter()
            .find(|(_, n)| *n == name)
            .map(|(g, _)| *g)
    }

    /// The names this set carries, in `NAMED` order.
    pub fn names(self) -> impl Iterator<Item = &'static str> {
        Groups::NAMED
            .into_iter()
            .filter(move |(g, _)| self.contains(*g))
            .map(|(_, n)| n)
    }
}
