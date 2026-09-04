//! Where a site reports a diagnostic, and where the resolved level is
//! decided.

use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::code::{Code, Level};
use super::control::{Config, Control};
use super::message::{Diagnostic, Loc};
use crate::c5::error::C5Error;

/// Resolves each reported diagnostic against the command line and the
/// pragmas, keeps the ones that survive, and counts the errors.
///
/// A raised warning does not unwind: the sink counts it and the caller
/// asks at a phase boundary, which is what `-Werror` does in gcc.
#[derive(Clone, Default, Debug)]
pub struct Sink {
    config: Config,
    control: Control,
    emitted: Vec<Diagnostic>,
    errors: usize,
    /// Codes a `once` pragma has already spent.
    spent: Vec<u16>,
}

impl Sink {
    pub fn new(config: Config, control: Control) -> Self {
        Self {
            config,
            control,
            emitted: Vec::new(),
            errors: 0,
            spent: Vec::new(),
        }
    }

    pub fn config(&self) -> &Config {
        &self.config
    }

    /// Install what the command line asked for. The pragmas recorded
    /// so far keep their events; only the base level changes.
    pub fn set_config(&mut self, config: Config) {
        self.config = config;
    }

    pub fn control(&self) -> &Control {
        &self.control
    }

    /// The pragma events, for the pass that records them as it reads
    /// the translation unit.
    pub fn control_mut(&mut self) -> &mut Control {
        &mut self.control
    }

    /// The recorded pragma events, for the next pass over the same
    /// translation unit. The offsets are positions in that unit, so
    /// only a pass reading the same text may take them.
    pub fn into_control(self) -> Control {
        self.control
    }

    /// Append a diagnostic whose level is already resolved. Used where
    /// a pass replays what an earlier run of the same text produced.
    pub fn record(&mut self, diagnostic: Diagnostic) {
        if diagnostic.level == Level::Error {
            self.errors += 1;
        }
        self.emitted.push(diagnostic);
    }

    /// The level `code` resolves to at `loc`: the command line, then
    /// the pragmas in effect at the position, if the location carries
    /// one.
    pub fn level(&self, code: Code, loc: Option<&Loc>) -> Level {
        let base = self.config.level(code);
        match loc.and_then(|l| l.offset) {
            Some(offset) => self.control.level_at(code, offset, base),
            None => base,
        }
    }

    /// Report a diagnostic. An ignored one is dropped; the rest are
    /// recorded with the level they resolved to.
    pub fn emit(&mut self, code: Code, loc: Option<Loc>, text: impl Into<String>) -> Level {
        self.emit_with_source(code, loc, text, None)
    }

    /// [`Self::emit`] for a site that can echo the source line the
    /// diagnostic points at.
    pub fn emit_with_source(
        &mut self,
        code: Code,
        loc: Option<Loc>,
        text: impl Into<String>,
        source_line: Option<String>,
    ) -> Level {
        let level = self.level(code, loc.as_ref());
        if level == Level::Ignore || !self.spend_once(code, loc.as_ref()) {
            return Level::Ignore;
        }
        if level == Level::Error {
            self.errors += 1;
        }
        self.emitted
            .push(Diagnostic::new(code, level, loc, text.into()).with_source_line(source_line));
        level
    }

    /// Report a diagnostic whose site can continue when the user lowers
    /// it. `Err` comes back only when the effective level is `Error`.
    pub fn report(
        &mut self,
        code: Code,
        loc: Option<Loc>,
        text: impl Into<String>,
    ) -> Result<(), C5Error> {
        if self.emit(code, loc, text) != Level::Error {
            return Ok(());
        }
        match self.emitted.last() {
            Some(diagnostic) => Err(C5Error::Compile(diagnostic.to_string())),
            None => Ok(()),
        }
    }

    pub fn has_errors(&self) -> bool {
        self.errors > 0
    }

    pub fn errors(&self) -> usize {
        self.errors
    }

    pub fn diagnostics(&self) -> &[Diagnostic] {
        &self.emitted
    }

    pub fn take(&mut self) -> Vec<Diagnostic> {
        core::mem::take(&mut self.emitted)
    }

    /// Whether a `once` pragma still allows this diagnostic through.
    fn spend_once(&mut self, code: Code, loc: Option<&Loc>) -> bool {
        let Some(offset) = loc.and_then(|l| l.offset) else {
            return true;
        };
        if !self.control.is_once(code, offset) {
            return true;
        }
        if self.spent.contains(&code.value()) {
            return false;
        }
        self.spent.push(code.value());
        true
    }
}
