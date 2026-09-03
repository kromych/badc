//! Structured diagnostics: one identity per diagnostic, one place that
//! decides its severity, and one place that prints it.
//!
//! A site reports through a [`Sink`], which resolves the level from the
//! catalogue default, then the command line ([`Config`]), then the
//! diagnostic pragmas in effect at the source position ([`Control`]).
//! Whatever survives is a [`Diagnostic`], printed by [`Diagnostic::render`].
//!
//! The catalogue carries the driver rows. The preprocessor, front end,
//! assembler, object writer and linker rows arrive with the sites that
//! emit them; `pedantic` has no driver row, since no command-line
//! diagnostic is about ISO C conformance, and fills in with them.

mod catalog;
mod code;
mod control;
mod message;
mod print;
mod sink;

#[cfg(test)]
mod tests;

pub use catalog::{Row, rows};
pub use code::{Class, Code, Groups, Level, Status};
pub use control::{Config, Control, Selector};
pub use message::{Diagnostic, Loc};
pub use print::{RESET, Severity, explain, list_catalog};
pub use sink::Sink;
