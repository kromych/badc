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
        // A `break` / `continue` in the body runs the cleanup functions of
        // every scope opened inside the loop; record the depth so the two
        // exits clean exactly those scopes.
        self.break_cleanup_depths.push(self.cleanup_scopes.len());
        self.continue_cleanup_depths.push(self.cleanup_scopes.len());
    }

    /// Open a `break`-only scope for a `switch` body. C disallows
    /// `continue` inside a switch, so the `continue` depth stays
    /// put.
    pub(super) fn enter_switch(&mut self) {
        self.loop_break_depth += 1;
        self.break_cleanup_depths.push(self.cleanup_scopes.len());
    }

    /// Close the innermost loop's `continue` scope. Stack-balanced
    /// against [`Self::enter_loop`].
    pub(super) fn close_loop_continues(&mut self) {
        self.loop_continue_depth = self.loop_continue_depth.saturating_sub(1);
        self.continue_cleanup_depths.pop();
    }

    /// Close the innermost loop's or switch's `break` scope.
    pub(super) fn close_loop_breaks(&mut self) {
        self.loop_break_depth = self.loop_break_depth.saturating_sub(1);
        self.break_cleanup_depths.pop();
    }
}
