//! gcc's `-Wenum-conversion` (c-typeck.cc `convert_for_assignment`): the
//! value's original type, which an enumeration constant, a bit-field read
//! and two conditional arms keep, is another enumerated type than the target.

use super::super::ast::{BitfieldDesc, Expr, ExprId, expr_ty};
use super::super::diag::Code;
use super::Compiler;
use super::types::{enum_id_of, enum_ty, format_type, ptr_depth_of, unqualified_version_ty};

fn is_enum_value_ty(ty: i64) -> bool {
    enum_id_of(ty).is_some() && ptr_depth_of(ty) == 0
}

/// The first arm's enumerated type when both arms have it.
pub(super) fn common_enum(a: Option<i64>, b: Option<i64>) -> Option<i64> {
    let (a, b) = (a?, b?);
    (enum_id_of(a) == enum_id_of(b)).then_some(a)
}

/// The enumerated type of a value of type `ty` keeping `recorded`.
pub(super) fn original_enum(recorded: Option<i64>, ty: i64) -> Option<i64> {
    recorded.or(Some(ty)).filter(|&t| is_enum_value_ty(t))
}

impl Compiler {
    /// The complete enumeration constant symbol `idx` belongs to.
    pub(super) fn enumeration_of_constant(&self, idx: usize) -> Option<i64> {
        let id = self.symbols[idx].enumeration? as usize;
        self.structs[id].enum_underlying.map(|u| enum_ty(u, id))
    }

    pub(super) fn set_expr_enum(&mut self, id: Option<ExprId>, ty: Option<i64>) {
        if let Some(id) = id {
            self.expr_enums.insert(id, ty);
        }
    }

    /// The enumerated type of `id`'s original type: recorded, a bit-field
    /// read's declared type, a comma's right operand's, or its own type.
    pub(super) fn expr_enum(&self, id: ExprId) -> Option<i64> {
        if let Some(&ty) = self.expr_enums.get(&id) {
            return ty;
        }
        let ty = match (self.ast.expr(id), self.bitfield_of(id)) {
            (Expr::Comma { rhs, .. }, _) => return self.expr_enum(*rhs),
            (Expr::Member { .. }, Some(desc)) => desc.ty,
            (_, Some(desc)) => self.bitfield_ty(&desc)?,
            (e, None) => expr_ty(e)?,
        };
        is_enum_value_ty(ty).then_some(ty)
    }

    /// The bit-field `id` reads, stores or increments.
    fn bitfield_of(&self, id: ExprId) -> Option<BitfieldDesc> {
        let lvalue = match self.ast.expr(id) {
            Expr::BitfieldAssign { bitfield, .. } => return Some(*bitfield),
            Expr::PreInc { lvalue, .. }
            | Expr::PostInc { lvalue, .. }
            | Expr::CompoundAssign { lhs: lvalue, .. } => *lvalue,
            _ => id,
        };
        match self.ast.expr(lvalue) {
            Expr::Member { bitfield, .. } => *bitfield,
            _ => None,
        }
    }

    /// gcc types a bit-field narrower than its declared type by its width.
    fn full_width(&self, bits: u32, ty: i64) -> bool {
        bits as usize == self.size_of_type(ty) * 8
    }

    fn bitfield_ty(&self, desc: &BitfieldDesc) -> Option<i64> {
        self.full_width(desc.bit_width.into(), desc.ty)
            .then_some(desc.ty)
    }

    /// gcc's type of the initializer value `e`.
    pub(super) fn init_value_ty(&self, e: ExprId) -> Option<i64> {
        match self.bitfield_of(e) {
            Some(desc) => self.bitfield_ty(&desc),
            None => expr_ty(self.ast.expr(e)),
        }
    }

    /// gcc stores an initializer of a type compatible with the object's
    /// with no conversion (c-typeck.cc `digest_init`).
    pub(super) fn initializes_as_is(&self, value_ty: i64, to: i64) -> bool {
        self.tags_compatible(unqualified_version_ty(value_ty), unqualified_version_ty(to))
    }

    /// Warns when the enumerated type `from` converts to the enumerated
    /// type `to`, a bit-field of `bits` bits when that is not zero.
    pub(super) fn check_enum_conversion(
        &mut self,
        from: Option<i64>,
        to: i64,
        bits: u32,
        line: usize,
    ) {
        let Some(from) = from.filter(|&f| is_enum_value_ty(f)) else {
            return;
        };
        if !is_enum_value_ty(to)
            || enum_id_of(from) == enum_id_of(to)
            || (bits != 0 && !self.full_width(bits, to))
        {
            return;
        }
        let text = alloc::format!(
            "implicit conversion from `{}` to `{}`",
            format_type(from, &self.structs),
            format_type(to, &self.structs)
        );
        self.warn_at(Code::ENUM_CONVERSION, line, text);
    }
}
