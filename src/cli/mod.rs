//! The `badc` command-line driver: argument parsing, the output
//! modes, and the diagnostics they print.

mod args;
mod compile;
mod deps;
mod diag;
mod driver;
mod dump;
mod inputs;
mod options;
mod output;
mod paths;
mod script_link;
mod stats;
mod usage;

pub(crate) use compile::DRIVER_STACK_SIZE;
pub(crate) use driver::run;
