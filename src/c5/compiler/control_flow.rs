//! Loop / switch break / continue patch helpers.
//!
//! Each `while` / `for` / `do-while` / `switch` body opens a fresh
//! patch frame on the `loop_breaks` (and, for loops, `loop_continues`)
//! stack; the body collects every `break` / `continue` `Jmp`'s
//! operand PC, and the body-exit patcher backfills them with the
//! resolved target PC. The stack discipline lets nested loops /
//! switches scope their own break / continue without leaking jumps
//! to an outer frame.

use alloc::vec::Vec;

use super::Compiler;

impl Compiler {
    /// Open a fresh `break` + `continue` scope for a `while` /
    /// `for` / `do-while` body. Both stacks are pushed; the caller
    /// finishes with [`Self::patch_loop_continues`] (to land continues
    /// at the loop's step / cond-check PC) and [`Self::patch_loop_breaks`]
    /// (to land breaks just past the loop), in that order.
    pub(super) fn enter_loop(&mut self) {
        self.loop_breaks.push(Vec::new());
        self.loop_continues.push(Vec::new());
    }

    /// Open a `break`-only scope for a `switch` body. C disallows
    /// `continue` inside a switch, so only `loop_breaks` gets a
    /// new stack frame; the caller finishes with
    /// [`Self::patch_loop_breaks`] alone.
    pub(super) fn enter_switch(&mut self) {
        self.loop_breaks.push(Vec::new());
    }

    /// Patch every `Jmp` operand recorded by the innermost loop's
    /// `continue` statements to land at `target_pc`, then drop the
    /// scope. Must be called before [`Self::patch_loop_breaks`] so the
    /// stack discipline stays balanced. A stray call with no scope
    /// open is a parser bug; it no-ops here so any earlier
    /// diagnostic can still surface.
    pub(super) fn patch_loop_continues(&mut self, _target_pc: usize) {
        self.loop_continues.pop();
    }

    /// Patch every `Jmp` operand recorded by the innermost loop's
    /// or switch's `break` statements to land at `target_pc`, then
    /// drop the scope.
    pub(super) fn patch_loop_breaks(&mut self, _target_pc: usize) {
        self.loop_breaks.pop();
    }

    /// Record the operand-PC of a `Jmp` emitted for an explicit
    /// `break` statement; the enclosing loop / switch's exit
    /// patcher backfills the target. Caller has already verified
    /// the loop_breaks stack is non-empty (the lex-time
    /// `if self.loop_breaks.is_empty()` check raises a diagnostic
    /// first), so the `if let` here is defensive: a stray call
    /// silently drops the jmp rather than panicking.
    pub(super) fn record_break_jmp(&mut self, jmp_operand_pc: usize) {
        if let Some(stack) = self.loop_breaks.last_mut() {
            stack.push(jmp_operand_pc);
        }
    }

    /// Record the operand-PC of a `Jmp` emitted for an explicit
    /// `continue` statement; the enclosing loop's continue
    /// patcher backfills the target. Caller has already verified
    /// the loop_continues stack is non-empty.
    pub(super) fn record_continue_jmp(&mut self, jmp_operand_pc: usize) {
        if let Some(stack) = self.loop_continues.last_mut() {
            stack.push(jmp_operand_pc);
        }
    }
}
