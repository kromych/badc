//! A unit's machine-code buffer and the spill store its bytes end with.
//!
//! An instruction whose result is placed in a spill slot computes it into a
//! scratch register and stores it. The scratch still holds the value at the
//! end of the store, so an operand read of that slot by the next instruction
//! can take the register instead of a load. That holds while nothing was
//! emitted after the store, no block starts there, and no branch the storing
//! instruction emitted lands there; the buffer records the store and every
//! branch so the emitters can tell. It also records the frame slots the
//! lowerings borrowed, which the frame then reserves.

use alloc::vec::Vec;

use super::super::listing::{Operand, Text};

/// The register class and width of a spill store, which a reload must match.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(crate) enum SpillWidth {
    /// A general-purpose register, all of it.
    Int,
    /// The low 8 bytes of a vector register, holding a scalar.
    Scalar,
    /// A whole vector register of this many bytes.
    Vector(u8),
}

#[derive(Clone, Copy)]
struct SpillStore {
    /// The buffer's length after the store and any padding emitted after it.
    at: usize,
    /// Where the store's bytes end, and their copy.
    end: usize,
    bytes: [u8; 16],
    len: u8,
    base: u8,
    disp: i32,
    reg: u8,
    width: SpillWidth,
}

/// The scratch registers a site's lowering may write, and for each one that
/// holds a value live across the site, the frame slot `(base, disp)` that
/// keeps the value while the lowering borrows the register.
#[derive(Clone, Copy, Debug, Default, PartialEq, Eq)]
pub(crate) struct ScratchPlan {
    pub(crate) regs: [u8; 2],
    pub(crate) keep: [Option<(u8, i32)>; 2],
}

/// A borrowed scratch register and the slot `(base, disp)` keeping its value.
pub(crate) type Borrowed = (u8, (u8, i32));

impl ScratchPlan {
    /// Two registers that hold no value at any site.
    pub(crate) const fn free(regs: [u8; 2]) -> Self {
        Self {
            regs,
            keep: [None; 2],
        }
    }
}

#[derive(Default)]
pub(crate) struct CodeBuf {
    bytes: Vec<u8>,
    stored: Option<SpillStore>,
    /// A branch was emitted since the current instruction began.
    branched: bool,
    /// Where the current instruction's bytes begin.
    inst_start: usize,
    /// The keep slots the lowerings took since [`Self::take_kept`], one bit each.
    kept: u32,
    /// The current site's plan; the target's default with none set.
    scratch: Option<ScratchPlan>,
    /// The plan outside the sites, which a site's end restores.
    between: Option<ScratchPlan>,
    /// The borrowed scratch registers whose values the site has stored.
    scratch_kept: [bool; 2],
    /// The site took a scratch register its plan has none for, or borrowed
    /// one after a branch, where the store keeping its value would not run
    /// on every path.
    fault: bool,
    /// The registers ended sites borrowed and did not reload yet: their
    /// values are in the slots until a later site or a flush reloads them.
    pending: [Option<Borrowed>; 2],
    /// The x86-64 function being emitted keeps its control transfers off
    /// 32-byte boundaries.
    pub(crate) windows: BranchWindows,
    /// Each instruction's text, when a listing is asked for.
    #[cfg(feature = "listing")]
    listing: Option<alloc::boxed::Box<super::super::listing::Listing>>,
}

/// x86-64 `-mbranches-within-32B-boundaries`, and under `-O` in the blocks
/// that run repeatedly: a branch group -- a jump, a call, a return, or the
/// flag-setting instruction a conditional jump fuses with through the jump
/// -- padded so that it neither crosses nor ends on a 32-byte boundary, which
/// a core with the update for Intel erratum SKX102 otherwise decodes on every
/// pass through. Function entries are 32-byte aligned, so the offset in the
/// buffer places the boundaries.
#[derive(Default)]
pub(crate) struct BranchWindows {
    pub(crate) on: bool,
    /// Per local-branch group, keyed by its first branch's emission index,
    /// its length in the previous pass, 0 where unknown. A pass shortens
    /// branches only, so the length bounds the group's length in the next
    /// pass. A call, a return or a jump out of the function has one length.
    pub(crate) prev: Vec<u8>,
    pub(crate) now: Vec<u8>,
    /// Each group's start and the padding it can take ahead of it, in this
    /// pass's layout, in order.
    pub(crate) starts: Vec<(usize, usize)>,
    /// Where the open group starts, and its index among this pass's opens.
    pub(crate) open: Option<usize>,
    pub(crate) open_index: usize,
    /// This pass's opens so far.
    pub(crate) opens: usize,
    /// Per open, in the order the pass opens them, whether a branch closed
    /// it: a group opened at a flag-setting instruction is left when its
    /// block ends without the jump. Only an open the previous pass closed
    /// pads, so every padding is one `relax_branches` counted, where it
    /// counted it.
    pub(crate) closed_prev: Vec<bool>,
    pub(crate) closed_now: Vec<bool>,
    /// Per block, whether its groups are padded; empty pads every block.
    pub(crate) pad: Vec<bool>,
    /// Whether the code being emitted pads.
    pub(crate) here: bool,
}

impl CodeBuf {
    pub(crate) fn into_bytes(self) -> Vec<u8> {
        self.bytes
    }

    /// A buffer that records each instruction's text when `listing` is set.
    pub(crate) fn listed(listing: bool) -> Self {
        #[allow(unused_mut)]
        let mut code = Self::default();
        #[cfg(feature = "listing")]
        if listing {
            code.listing = Some(alloc::boxed::Box::default());
        }
        let _ = listing;
        code
    }

    /// An empty buffer to try an encoding in, recording text when this one
    /// does; [`Self::append`] keeps what it took.
    pub(crate) fn probe(&self) -> Self {
        Self::listed(self.listing())
    }

    /// Append `other`'s bytes and their text.
    pub(crate) fn append(&mut self, other: CodeBuf) {
        #[cfg(feature = "listing")]
        if let (Some(l), Some(o)) = (self.listing.as_deref_mut(), other.listing) {
            l.append(*o, self.bytes.len());
        }
        self.bytes.extend_from_slice(&other.bytes);
    }

    /// The text recorded so far, which the buffer stops recording.
    #[cfg(feature = "listing")]
    pub(crate) fn take_listing(&mut self) -> Option<super::super::listing::Listing> {
        self.listing.take().map(|l| *l)
    }

    /// Whether each instruction's text is recorded.
    #[inline(always)]
    pub(crate) fn listing(&self) -> bool {
        #[cfg(feature = "listing")]
        return self.listing.is_some();
        #[cfg(not(feature = "listing"))]
        false
    }

    /// The instruction whose bytes run from `at` to the end reads `text`.
    #[inline(always)]
    pub(crate) fn describe<T: Into<Text>>(&mut self, at: usize, text: impl FnOnce() -> T) {
        #[cfg(feature = "listing")]
        if let Some(l) = self.listing.as_deref_mut() {
            l.push(at, self.bytes.len(), text().into());
        }
        #[cfg(not(feature = "listing"))]
        let _ = (at, text);
    }

    /// The operand slot of the instruction last described names `operand`.
    #[inline(always)]
    pub(crate) fn name_last(&mut self, operand: impl FnOnce() -> Operand) {
        #[cfg(feature = "listing")]
        if let Some(l) = self.listing.as_deref_mut() {
            l.name_last(operand());
        }
        #[cfg(not(feature = "listing"))]
        let _ = operand;
    }

    /// The bytes from `at` on are a prefix of the next instruction described,
    /// whose text `amend` rewrites with `arg`.
    #[inline(always)]
    pub(crate) fn prefix_next(&mut self, at: usize, amend: super::super::listing::Amend, arg: u8) {
        #[cfg(feature = "listing")]
        if let Some(l) = self.listing.as_deref_mut() {
            l.prefix_next(at, amend, arg);
        }
        #[cfg(not(feature = "listing"))]
        let _ = (at, amend, arg);
    }

    /// The operand slot of the instruction at `at` names `operand`.
    #[inline(always)]
    pub(crate) fn name_at(&mut self, at: usize, operand: impl FnOnce() -> Operand) {
        #[cfg(feature = "listing")]
        if let Some(l) = self.listing.as_deref_mut() {
            l.name_at(at, operand());
        }
        #[cfg(not(feature = "listing"))]
        let _ = (at, operand);
    }

    /// Block `block` begins here.
    #[inline(always)]
    pub(crate) fn label_block(&mut self, block: u32) {
        #[cfg(feature = "listing")]
        if let Some(l) = self.listing.as_deref_mut() {
            l.label(self.bytes.len(), block);
        }
        #[cfg(not(feature = "listing"))]
        let _ = block;
    }

    /// An instruction's lowering begins: branches before it land nowhere in it.
    pub(crate) fn begin_instruction(&mut self) {
        self.branched = false;
        self.inst_start = self.bytes.len();
    }

    /// The 4-byte words the current instruction emitted ahead of `end`, for
    /// a target of fixed-width instructions to find its branches among.
    pub(crate) fn instruction_words(&self, end: usize) -> impl Iterator<Item = u32> + '_ {
        let from = self.inst_start.min(end);
        self.bytes[from..end]
            .as_chunks::<4>()
            .0
            .iter()
            .map(|&w| u32::from_le_bytes(w))
    }

    /// A block begins here, which a branch may enter.
    pub(crate) fn begin_block(&mut self) {
        self.stored = None;
    }

    pub(crate) fn note_branch(&mut self) {
        self.branched = true;
    }

    /// A lowering keeps a register in keep slot `k`.
    pub(crate) fn note_kept(&mut self, k: u32) {
        self.kept |= 1 << k;
    }

    /// The keep slots taken since the last call, which it clears.
    pub(crate) fn take_kept(&mut self) -> u32 {
        core::mem::take(&mut self.kept)
    }

    pub(crate) fn scratch_plan(&self) -> Option<ScratchPlan> {
        self.scratch
    }

    /// The plan of the site whose lowering follows, until its end: a
    /// branch ahead of it lands nowhere in it.
    pub(crate) fn set_scratch(&mut self, plan: Option<ScratchPlan>) {
        self.scratch = plan;
        self.branched = false;
    }

    /// The plan outside the sites of the code that follows.
    pub(crate) fn set_scratch_between(&mut self, plan: Option<ScratchPlan>) {
        self.between = plan;
        self.scratch = plan;
        self.pending = [None; 2];
    }

    /// The borrowed registers not reloaded yet, which the caller reloads or
    /// carries into the next site.
    pub(crate) fn take_pending(&mut self) -> [Option<Borrowed>; 2] {
        core::mem::take(&mut self.pending)
    }

    pub(crate) fn pending(&self) -> [Option<Borrowed>; 2] {
        self.pending
    }

    pub(crate) fn set_pending(&mut self, pending: [Option<Borrowed>; 2]) {
        self.pending = pending;
    }

    /// Scratch `k` of the site already keeps the value its register held, a
    /// register an earlier site borrowed into the same slot.
    pub(crate) fn carry_scratch(&mut self, k: usize) {
        self.scratch_kept[k] = true;
    }

    /// Scratch `k` is taken: true when its register is borrowed and its value
    /// still has to be stored, which must precede any branch of the site.
    pub(crate) fn take_scratch(&mut self, k: usize) -> bool {
        if self.scratch.is_none_or(|p| p.keep[k].is_none()) || self.scratch_kept[k] {
            return false;
        }
        self.scratch_kept[k] = true;
        self.fault |= self.branched;
        true
    }

    /// The site took a scratch register its plan has none for.
    pub(crate) fn scratch_fault(&mut self) {
        self.fault = true;
    }

    /// End the site: the borrowed scratch registers it stored, which its end
    /// reloads, and whether it faulted.
    pub(crate) fn end_scratch(&mut self) -> ([Option<Borrowed>; 2], bool) {
        let mut out = [None; 2];
        for (k, o) in out.iter_mut().enumerate() {
            if self.scratch_kept[k]
                && let Some(p) = self.scratch
            {
                *o = p.keep[k].map(|slot| (p.regs[k], slot));
            }
        }
        let fault = self.fault;
        self.scratch_kept = [false; 2];
        self.fault = false;
        self.scratch = self.between;
        (out, fault)
    }

    /// The bytes from `start` to the end are a store of register `reg` to
    /// `[base + disp]`. A branch emitted earlier in the instruction may land
    /// after the store, so the register is known to hold the slot only when
    /// there was none.
    pub(crate) fn spill_stored(
        &mut self,
        start: usize,
        base: u8,
        disp: i32,
        reg: u8,
        width: SpillWidth,
    ) {
        let end = self.bytes.len();
        let len = end - start;
        self.stored = None;
        if self.branched || len > 16 {
            return;
        }
        let mut bytes = [0u8; 16];
        bytes[..len].copy_from_slice(&self.bytes[start..end]);
        self.stored = Some(SpillStore {
            at: end,
            end,
            bytes,
            len: len as u8,
            base,
            disp,
            reg,
            width,
        });
    }

    /// The register the bytes end storing to `[base + disp]` at `width`.
    pub(crate) fn holding(&self, base: u8, disp: i32, width: SpillWidth) -> Option<u8> {
        let s = self.stored.as_ref()?;
        let len = usize::from(s.len);
        (s.at == self.bytes.len()
            && (s.base, s.disp, s.width) == (base, disp, width)
            && self.bytes.get(s.end - len..s.end) == Some(&s.bytes[..len]))
        .then_some(s.reg)
    }

    /// Emit padding that executes as no-ops, which leaves a register's
    /// content as it was.
    pub(crate) fn pad(&mut self, emit: impl FnOnce(&mut CodeBuf)) {
        let from = self.bytes.len();
        emit(self);
        let to = self.bytes.len();
        if let Some(s) = self.stored.as_mut().filter(|s| s.at == from) {
            s.at = to;
        }
    }

    /// Drop the bytes from `len` on, and the text of each instruction in them.
    pub(crate) fn truncate(&mut self, len: usize) {
        self.stored = None;
        self.bytes.truncate(len);
        #[cfg(feature = "listing")]
        if let Some(l) = self.listing.as_deref_mut() {
            l.truncate(len);
        }
    }

    /// The bytes from `at` on, which leave the buffer with their text.
    pub(crate) fn split_off(&mut self, at: usize) -> Vec<u8> {
        self.stored = None;
        #[cfg(feature = "listing")]
        if let Some(l) = self.listing.as_deref_mut() {
            l.truncate(at);
        }
        self.bytes.split_off(at)
    }
}

impl From<Vec<u8>> for CodeBuf {
    fn from(bytes: Vec<u8>) -> Self {
        CodeBuf {
            bytes,
            ..Self::default()
        }
    }
}

impl core::fmt::Debug for CodeBuf {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        self.bytes.fmt(f)
    }
}

impl core::ops::Deref for CodeBuf {
    type Target = Vec<u8>;
    fn deref(&self) -> &Vec<u8> {
        &self.bytes
    }
}

impl core::ops::DerefMut for CodeBuf {
    fn deref_mut(&mut self) -> &mut Vec<u8> {
        &mut self.bytes
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn stored_at(code: &mut CodeBuf) {
        let start = code.len();
        code.extend_from_slice(&[0x4c, 0x89, 0x54, 0x24, 0x40]);
        code.spill_stored(start, 4, 0x40, 10, SpillWidth::Int);
    }

    #[test]
    fn a_spill_store_holds_until_anything_follows() {
        let mut code = CodeBuf::default();
        stored_at(&mut code);
        assert_eq!(code.holding(4, 0x40, SpillWidth::Int), Some(10));
        assert_eq!(code.holding(4, 0x48, SpillWidth::Int), None);
        assert_eq!(code.holding(4, 0x40, SpillWidth::Scalar), None);
        code.pad(|b| b.push(0x90));
        assert_eq!(code.holding(4, 0x40, SpillWidth::Int), Some(10));
        code.push(0x90);
        assert_eq!(code.holding(4, 0x40, SpillWidth::Int), None);
    }

    #[test]
    fn a_branch_or_a_block_start_forgets_the_store() {
        let mut code = CodeBuf::default();
        code.begin_instruction();
        code.note_branch();
        stored_at(&mut code);
        assert_eq!(code.holding(4, 0x40, SpillWidth::Int), None);
        code.begin_instruction();
        stored_at(&mut code);
        code.begin_block();
        assert_eq!(code.holding(4, 0x40, SpillWidth::Int), None);
    }

    #[test]
    fn rewritten_bytes_forget_the_store() {
        let mut code = CodeBuf::default();
        stored_at(&mut code);
        let n = code.len();
        code[n - 1] = 0x48;
        assert_eq!(code.holding(4, 0x40, SpillWidth::Int), None);
        code[n - 1] = 0x40;
        code.truncate(n - 1);
        code.push(0x40);
        assert_eq!(code.holding(4, 0x40, SpillWidth::Int), None);
    }
}
