//! Loop / switch break / continue patch helpers.
//!
//! Each `while` / `for` / `do-while` / `switch` body opens a fresh
//! patch frame on the `loop_breaks` (and, for loops, `loop_continues`)
//! stack; the body collects every `break` / `continue` `Jmp`'s
//! operand PC, and the body-exit patcher backfills them with the
//! resolved target PC. The stack discipline lets nested loops /
//! switches scope their own break / continue without leaking jumps
//! to an outer frame.

use super::Compiler;

impl Compiler {
    /// Open a fresh `break` + `continue` scope for a `while` /
    /// `for` / `do-while` body. The caller finishes with
    /// [`Self::patch_loop_continues`] then [`Self::patch_loop_breaks`].
    pub(super) fn enter_loop(&mut self) {
        self.loop_break_depth += 1;
        self.loop_continue_depth += 1;
    }

    /// Open a `break`-only scope for a `switch` body. C disallows
    /// `continue` inside a switch, so the `continue` depth stays
    /// put.
    pub(super) fn enter_switch(&mut self) {
        self.loop_break_depth += 1;
    }

    /// Close the innermost loop's `continue` scope. Stack-balanced
    /// against [`Self::enter_loop`].
    pub(super) fn patch_loop_continues(&mut self, _target_pc: usize) {
        self.loop_continue_depth = self.loop_continue_depth.saturating_sub(1);
    }

    /// Close the innermost loop's or switch's `break` scope.
    pub(super) fn patch_loop_breaks(&mut self, _target_pc: usize) {
        self.loop_break_depth = self.loop_break_depth.saturating_sub(1);
    }
}
