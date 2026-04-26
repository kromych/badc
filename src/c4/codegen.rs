use super::{C4, Op};

impl C4 {
    pub(super) fn emit_op(&mut self, op: Op) {
        self.text.push(op as i64);
    }

    pub(super) fn emit_val(&mut self, val: i64) {
        self.text.push(val);
    }
}
