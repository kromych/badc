//! A unit's machine-code buffer and the spill store its bytes end with.
//!
//! An instruction whose result is placed in a spill slot computes it into a
//! scratch register and stores it. The scratch still holds the value at the
//! end of the store, so an operand read of that slot by the next instruction
//! can take the register instead of a load. That holds while nothing was
//! emitted after the store, no block starts there, and no branch the storing
//! instruction emitted lands there; the buffer records the store and every
//! branch so the emitters can tell.

use alloc::vec::Vec;

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

#[derive(Default)]
pub(crate) struct CodeBuf {
    bytes: Vec<u8>,
    stored: Option<SpillStore>,
    /// A branch was emitted since the current instruction began.
    branched: bool,
    /// Where the current instruction's bytes begin.
    inst_start: usize,
}

impl CodeBuf {
    pub(crate) fn into_bytes(self) -> Vec<u8> {
        self.bytes
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
    pub(crate) fn pad(&mut self, emit: impl FnOnce(&mut Vec<u8>)) {
        let from = self.bytes.len();
        emit(&mut self.bytes);
        let to = self.bytes.len();
        if let Some(s) = self.stored.as_mut().filter(|s| s.at == from) {
            s.at = to;
        }
    }

    pub(crate) fn truncate(&mut self, len: usize) {
        self.stored = None;
        self.bytes.truncate(len);
    }

    pub(crate) fn split_off(&mut self, at: usize) -> Vec<u8> {
        self.stored = None;
        self.bytes.split_off(at)
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
