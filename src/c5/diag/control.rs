//! The two layers that decide a diagnostic's level: [`Config`], what
//! the command line asked for, and [`Control`], what the diagnostic
//! pragmas ask for at one position in the translation unit.

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use super::catalog::rows;
use super::code::{Class, Code, Groups, Level, Status};

/// What a `-W<selector>` names: a group, or one diagnostic.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Selector {
    Group(Groups),
    Diagnostic(Code),
}

impl Selector {
    pub fn parse(sel: &str) -> Option<Selector> {
        if let Some(group) = Groups::from_selector(sel) {
            return Some(Selector::Group(group));
        }
        Code::from_selector(sel).map(Selector::Diagnostic)
    }
}

/// The levels the command line leaves behind. Options are applied in
/// the order they were written, so a later `-Wno-<sel>` overrides an
/// earlier `-Wall`.
#[derive(Clone, Default, Debug)]
pub struct Config {
    levels: BTreeMap<u16, Level>,
    /// `-w`.
    inhibit: bool,
    /// `-Werror` / `-Wno-error`.
    errors: bool,
    /// `-Werror=<sel>` (true) and `-Wno-error=<sel>` (false).
    per_code_errors: BTreeMap<u16, bool>,
}

impl Config {
    pub fn new() -> Self {
        Self::default()
    }

    /// `-W<sel>` / `-Wno-<sel>`. A selector naming an uncontrollable or
    /// a retired row changes nothing.
    pub fn set_level(&mut self, code: Code, level: Level) {
        if is_settable(code) {
            self.levels.insert(code.value(), level);
        }
    }

    /// `-Wall` / `-Wextra` / `-Wpedantic`: every row in the group that
    /// is below `Warning` is raised to it.
    pub fn enable_group(&mut self, group: Groups) {
        for row in rows().filter(|r| r.groups.contains(group)) {
            if is_settable(row.code) && self.stated_level(row.code) < Level::Warning {
                self.levels.insert(row.code.value(), Level::Warning);
            }
        }
    }

    /// `-w`.
    pub fn inhibit_warnings(&mut self, on: bool) {
        self.inhibit = on;
    }

    /// `-Werror` / `-Wno-error`.
    pub fn warnings_as_errors(&mut self, on: bool) {
        self.errors = on;
    }

    /// `-Werror=<sel>` / `-Wno-error=<sel>`.
    pub fn error_for(&mut self, code: Code, on: bool) {
        if is_settable(code) {
            self.per_code_errors.insert(code.value(), on);
        }
    }

    /// The level before any pragma applies.
    pub fn level(&self, code: Code) -> Level {
        if !is_settable(code) {
            return match code.status() {
                Status::Retired => Level::Ignore,
                Status::Live => code.default_level(),
            };
        }
        let pinned = self.per_code_errors.get(&code.value()).copied();
        // `-Werror=<sel>` enables the diagnostic as well as raising it.
        if pinned == Some(true) {
            return Level::Error;
        }
        let mut level = self.stated_level(code);
        if pinned == Some(false) && level == Level::Error {
            level = Level::Warning;
        }
        if level != Level::Warning {
            return level;
        }
        if self.inhibit {
            Level::Ignore
        } else if self.errors && pinned != Some(false) {
            Level::Error
        } else {
            Level::Warning
        }
    }

    /// The level the options stated, before `-w` and `-Werror`.
    fn stated_level(&self, code: Code) -> Level {
        self.levels
            .get(&code.value())
            .copied()
            .unwrap_or_else(|| code.default_level())
    }
}

/// Whether an option or a pragma may move this row's level. A hard or
/// a retired row keeps its catalogue level whatever the source asks.
fn is_settable(code: Code) -> bool {
    code.class() == Class::Controllable && code.status() == Status::Live
}

/// The extent a `#pragma warning(suppress: ...)` covers: the byte range
/// of the following line in the preprocessed translation unit.
type Extent = (u32, u32);

/// The diagnostic pragmas of one translation unit, recorded in source
/// order and resolved by position.
///
/// A `push` / `pop` pair is resolved as it is recorded: `pop` appends
/// the absolute levels the matching `push` saw, so a lookup is a binary
/// search over one code's events and never a replay of the stack.
#[derive(Clone, Default, Debug)]
pub struct Control {
    /// Per code, `(offset, level)` in ascending offset order. `None`
    /// restores the level the command line left.
    events: BTreeMap<u16, Vec<(u32, Option<Level>)>>,
    /// Per code, the one-line extents `suppress` covers.
    suppressed: BTreeMap<u16, Vec<Extent>>,
    /// Per code, the offset from which the diagnostic reports once.
    once: BTreeMap<u16, u32>,
    stack: Vec<Vec<(u16, Option<Level>)>>,
    /// Codes whose last extent is still open; see [`Self::open_suppress`].
    open: Vec<u16>,
}

impl Control {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn is_empty(&self) -> bool {
        self.events.is_empty() && self.suppressed.is_empty() && self.once.is_empty()
    }

    /// `#pragma GCC diagnostic ignored|warning|error "-W<sel>"`, and
    /// the MSVC `disable` / `default` / `enable` / `error` actions.
    pub fn set_level(&mut self, offset: u32, code: Code, level: Level) {
        self.record(offset, code, Some(level));
    }

    /// The MSVC `default` action and what a `pop` restores: the level
    /// the command line left.
    pub fn reset(&mut self, offset: u32, code: Code) {
        self.record(offset, code, None);
    }

    /// `#pragma GCC diagnostic push` / `#pragma warning(push)`.
    pub fn push(&mut self) {
        let snapshot = self
            .events
            .iter()
            .filter_map(|(code, events)| events.last().map(|(_, level)| (*code, *level)))
            .collect();
        self.stack.push(snapshot);
    }

    /// `#pragma GCC diagnostic pop` / `#pragma warning(pop)`. Reports
    /// whether a matching `push` was open, so the caller can diagnose
    /// an unbalanced pragma.
    pub fn pop(&mut self, offset: u32) -> bool {
        let Some(snapshot) = self.stack.pop() else {
            return false;
        };
        let saved: BTreeMap<u16, Option<Level>> = snapshot.into_iter().collect();
        let live: Vec<(u16, Option<Level>)> = self
            .events
            .iter()
            .filter_map(|(code, events)| events.last().map(|(_, level)| (*code, *level)))
            .collect();
        for (code, level) in live {
            let want = saved.get(&code).copied().unwrap_or(None);
            if want != level {
                self.record(offset, Code::new(code), want);
            }
        }
        true
    }

    /// `#pragma warning(suppress: N)`: the diagnostic is ignored over
    /// `extent`, the byte range of the line the pragma precedes.
    pub fn suppress(&mut self, extent: Extent, code: Code) {
        if !is_settable(code) {
            return;
        }
        self.push_extent(code, extent);
    }

    /// The same, for a pass that has not reached the end of the covered
    /// line yet: the extent stays open until [`Self::close_suppress`],
    /// so a lookup made while the pass is still inside that line is
    /// covered.
    pub fn open_suppress(&mut self, start: u32, code: Code) {
        if !is_settable(code) {
            return;
        }
        self.push_extent(code, (start, u32::MAX));
        self.open.push(code.value());
    }

    pub fn has_open_suppress(&self) -> bool {
        !self.open.is_empty()
    }

    /// End every extent [`Self::open_suppress`] left open at `end`.
    pub fn close_suppress(&mut self, end: u32) {
        for code in core::mem::take(&mut self.open) {
            if let Some(extent) = self.suppressed.get_mut(&code).and_then(|v| v.last_mut()) {
                extent.1 = end;
            }
        }
    }

    fn push_extent(&mut self, code: Code, extent: Extent) {
        let list = self.suppressed.entry(code.value()).or_default();
        debug_assert!(list.last().is_none_or(|(start, _)| *start <= extent.0));
        list.push(extent);
    }

    /// `#pragma warning(once: N)`: from `offset` on, the diagnostic is
    /// reported at most once. The sink holds the bookkeeping.
    pub fn report_once(&mut self, offset: u32, code: Code) {
        if !is_settable(code) {
            return;
        }
        self.once.entry(code.value()).or_insert(offset);
    }

    pub fn is_once(&self, code: Code, offset: u32) -> bool {
        self.once
            .get(&code.value())
            .is_some_and(|start| *start <= offset)
    }

    /// The level in effect at `offset`, starting from `base` -- what
    /// the command line left for this code.
    pub fn level_at(&self, code: Code, offset: u32, base: Level) -> Level {
        if self.is_suppressed(code, offset) {
            return Level::Ignore;
        }
        let Some(events) = self.events.get(&code.value()) else {
            return base;
        };
        let idx = events.partition_point(|(at, _)| *at <= offset);
        match idx.checked_sub(1).and_then(|i| events[i].1) {
            Some(level) => level,
            None => base,
        }
    }

    /// Whether any pragma raises `code` above [`Level::Ignore`]. A pass
    /// whose analysis is gated on the row reporting asks this as well as
    /// the command line, so a pragma can turn the analysis on where the
    /// options left it off.
    pub fn may_report(&self, code: Code) -> bool {
        self.events.get(&code.value()).is_some_and(|events| {
            events
                .iter()
                .any(|(_, level)| matches!(level, Some(l) if *l != Level::Ignore))
        })
    }

    fn is_suppressed(&self, code: Code, offset: u32) -> bool {
        let Some(extents) = self.suppressed.get(&code.value()) else {
            return false;
        };
        let idx = extents.partition_point(|(start, _)| *start <= offset);
        idx.checked_sub(1).is_some_and(|i| offset < extents[i].1)
    }

    fn record(&mut self, offset: u32, code: Code, level: Option<Level>) {
        if !is_settable(code) {
            return;
        }
        let events = self.events.entry(code.value()).or_default();
        debug_assert!(events.last().is_none_or(|(at, _)| *at <= offset));
        events.push((offset, level));
    }
}
