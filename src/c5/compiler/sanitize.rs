//! The runtime checks `-fsanitize=` inserts, as gcc's and clang's
//! UndefinedBehaviorSanitizer names them, with the site data their
//! handlers read in the layout those handlers take: a
//! `SourceLocation {const char *file; u32 line, column}` and, per check,
//! pointers to `TypeDescriptor {u16 kind, info; char name[]}` records.

use alloc::string::String;

use super::Compiler;
use super::types::{
    is_bool_ty, is_float_ty, is_floating_scalar, is_integer_scalar_ty, is_unsigned_ty,
};
use crate::c5::ast::{Expr, ExprId, SanitizeCheck, ValueCheck, ValueTest};
use crate::c5::ir::BinOp;
use crate::c5::program::DataReloc;
use crate::c5::token::Token;

/// A runtime check, as `-fsanitize=` names it.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Check {
    /// A signed `+`, `-`, `*`, negation, or `/` or `%` of the type's
    /// minimum by -1, whose value its type cannot represent (C17 6.5p5).
    SignedIntegerOverflow,
    /// A left shift of a negative signed value, or of a value the result
    /// type cannot represent shifted (C17 6.5.7p4).
    ShiftBase,
    /// A shift by a negative amount or by the promoted left operand's
    /// width or more (C17 6.5.7p3).
    ShiftExponent,
    /// An integer `/` or `%` by zero (C17 6.5.5p5).
    IntegerDivideByZero,
    /// A load of an enumerated type outside its values. A C enumeration
    /// holds every value of its compatible integer type (C17 6.7.2.2p4), so
    /// no C load is out of range and the check inserts nothing.
    Enum,
    /// A subscript of an array of known bound past it (C17 6.5.6p8), but
    /// for a trailing member taken to extend past its bound; clang's
    /// `array-bounds`. An address one past the last element is in bounds.
    Bounds,
    /// [`Check::Bounds`] on those trailing members as well.
    BoundsStrict,
    /// A load of a `_Bool` whose byte is neither 0 nor 1 (C17 6.2.6.1p5,
    /// a trap representation).
    Bool,
    /// An access through a null pointer (C17 6.5.3.2p4).
    Null,
    /// Pointer arithmetic on a null pointer, or whose result wraps around
    /// the address space (C17 6.5.6p8).
    PointerOverflow,
    /// An access through an address not aligned for its type (C17
    /// 6.3.2.3p7); for a member, the alignment the containing structure's
    /// and the member offset's give.
    Alignment,
    /// A floating value converted to an integer type it lies outside the
    /// range of, its fraction discarded (C17 6.3.1.4p1).
    FloatCastOverflow,
    /// A variable-length array bound that is not positive (C17 6.7.6.2p5).
    VlaBound,
    /// A `__builtin_unreachable()` reached: its handler reports it and ends
    /// the program.
    Unreachable,
    /// Flowing off the end of a value-returning function, undefined in C++;
    /// in C only a use of the value is (C17 6.9.1p12), so the check inserts
    /// nothing.
    Return,
    /// An unsigned `+`, `-`, `*` or negation whose value its type cannot
    /// represent: defined, reduced modulo (C17 6.2.5p9); clang's check.
    UnsignedIntegerOverflow,
    /// An implicit conversion of an unsigned integer to a narrower unsigned
    /// type that changes the value (C17 6.3.1.3p2: defined, reduced modulo).
    ImplicitUnsignedIntegerTruncation,
    /// An implicit conversion to a narrower integer type, either one
    /// signed, that changes the value (C17 6.3.1.3p2-p3).
    ImplicitSignedIntegerTruncation,
    /// `__builtin_clz` or `__builtin_ctz`, or a wider form, of 0, whose
    /// count is undefined.
    Builtin,
    /// A null argument to a parameter `nonnull` names.
    NonnullAttribute,
    /// A null returned from a function declared `returns_nonnull`.
    ReturnsNonnullAttribute,
    /// A dereference of an object's address with fewer bytes left than the
    /// access reads or writes: `*(T *)&obj` of an `obj` smaller than `T`.
    ObjectSize,
}

impl Check {
    /// Every check: those `-fsanitize=undefined` lists, in its order, then
    /// clang's checks of defined behavior.
    pub const ALL: [Check; 22] = [
        Check::SignedIntegerOverflow,
        Check::ShiftBase,
        Check::ShiftExponent,
        Check::IntegerDivideByZero,
        Check::Enum,
        Check::Bounds,
        Check::BoundsStrict,
        Check::Bool,
        Check::Null,
        Check::PointerOverflow,
        Check::Alignment,
        Check::ObjectSize,
        Check::FloatCastOverflow,
        Check::VlaBound,
        Check::Unreachable,
        Check::Return,
        Check::UnsignedIntegerOverflow,
        Check::ImplicitUnsignedIntegerTruncation,
        Check::ImplicitSignedIntegerTruncation,
        Check::Builtin,
        Check::NonnullAttribute,
        Check::ReturnsNonnullAttribute,
    ];

    /// The spelling `-fsanitize=` takes.
    pub const fn name(self) -> &'static str {
        match self {
            Check::SignedIntegerOverflow => "signed-integer-overflow",
            Check::ShiftBase => "shift-base",
            Check::ShiftExponent => "shift-exponent",
            Check::IntegerDivideByZero => "integer-divide-by-zero",
            Check::Enum => "enum",
            Check::Bounds => "bounds",
            Check::BoundsStrict => "bounds-strict",
            Check::Bool => "bool",
            Check::Null => "null",
            Check::PointerOverflow => "pointer-overflow",
            Check::Alignment => "alignment",
            Check::FloatCastOverflow => "float-cast-overflow",
            Check::VlaBound => "vla-bound",
            Check::Unreachable => "unreachable",
            Check::Return => "return",
            Check::UnsignedIntegerOverflow => "unsigned-integer-overflow",
            Check::ImplicitUnsignedIntegerTruncation => "implicit-unsigned-integer-truncation",
            Check::ImplicitSignedIntegerTruncation => "implicit-signed-integer-truncation",
            Check::Builtin => "builtin",
            Check::NonnullAttribute => "nonnull-attribute",
            Check::ReturnsNonnullAttribute => "returns-nonnull-attribute",
            Check::ObjectSize => "object-size",
        }
    }

    pub const fn bit(self) -> u32 {
        1 << self as u32
    }

    /// The groups a `-fsanitize=` list item may name, besides a check.
    pub const GROUPS: [&'static str; 8] = [
        "undefined",
        "integer",
        "shift",
        "array-bounds",
        "implicit-conversion",
        "implicit-integer-conversion",
        "implicit-integer-truncation",
        "implicit-integer-arithmetic-value-change",
    ];

    /// The checks a `-fsanitize=` list item names: one check, another name
    /// for one, or a group: `shift`; `undefined`, the checks of undefined
    /// behavior but `bounds-strict`; `integer`, the integer checks; and the
    /// implicit-conversion groups. `None` for a name that is neither.
    pub fn named(name: &str) -> Option<u32> {
        let truncation = Check::ImplicitUnsignedIntegerTruncation.bit()
            | Check::ImplicitSignedIntegerTruncation.bit();
        let defined = truncation | Check::UnsignedIntegerOverflow.bit();
        match name {
            "undefined" => Some(
                (Check::ALL.iter())
                    .filter(|&&c| c != Check::BoundsStrict && c.bit() & defined == 0)
                    .fold(0, |m, c| m | c.bit()),
            ),
            "integer" => Some(
                defined
                    | Check::SignedIntegerOverflow.bit()
                    | Check::ShiftBase.bit()
                    | Check::ShiftExponent.bit()
                    | Check::IntegerDivideByZero.bit(),
            ),
            "implicit-integer-truncation"
            | "implicit-integer-conversion"
            | "implicit-conversion" => Some(truncation),
            "implicit-integer-arithmetic-value-change" => {
                Some(Check::ImplicitSignedIntegerTruncation.bit())
            }
            "shift" => Some(Check::ShiftBase.bit() | Check::ShiftExponent.bit()),
            "array-bounds" => Some(Check::Bounds.bit()),
            _ => (Check::ALL.iter())
                .find(|c| c.name() == name)
                .map(|c| c.bit()),
        }
    }
}

/// The checks a unit runs, and of those, the ones that trap instead of
/// calling a handler and the ones whose handler returns; by default every
/// handler returns.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Sanitize {
    pub enabled: u32,
    pub trap: u32,
    /// Checks whose handler returns; the others call its `_abort` form.
    pub recover: u32,
}

impl Default for Sanitize {
    fn default() -> Self {
        Sanitize {
            enabled: 0,
            trap: 0,
            recover: Check::ALL.iter().fold(0, |m, c| m | c.bit()),
        }
    }
}

impl Sanitize {
    /// Whether `check` runs.
    pub const fn runs(&self, check: Check) -> bool {
        self.enabled & check.bit() != 0
    }
}

/// `TypeDescriptor::kind` of an integer type.
const TK_INTEGER: u16 = 0;
/// `TypeDescriptor::kind` of a floating type.
const TK_FLOAT: u16 = 1;
/// `TypeMismatchData::TypeCheckKind` of a load, a store, and the access of
/// a member through the containing structure's address.
const TCK_LOAD: u8 = 0;
const TCK_STORE: u8 = 1;
const TCK_MEMBER_ACCESS: u8 = 3;
/// `TypeDescriptor::kind` of a type the handlers know by its name alone.
const TK_UNKNOWN: u16 = 0xffff;

impl Compiler {
    /// Check the `+`, `-` or `*` whose node the accumulator holds, computed
    /// in the common type `ty`, under `-fsanitize=signed-integer-overflow` or
    /// `unsigned-integer-overflow`; whether a check was attached.
    pub(super) fn sanitize_overflow(&mut self, ty: i64) -> bool {
        let Some(id) = self.ast_acc else {
            return false;
        };
        let op = match self.ast.expr(id) {
            crate::c5::ast::Expr::Binary { op, .. } => Some(*op),
            _ => return false,
        };
        self.sanitize_arith(id, op, ty)
    }

    /// Check the operation at node `id` -- `op` (`+`, `-`, `*`), or a
    /// negation for `None` -- computed in `ty`, under
    /// `-fsanitize=signed-integer-overflow` or, of an unsigned `ty`,
    /// `unsigned-integer-overflow`; whether a check was attached. The
    /// operator is the last one [`Self::operator_at`] recorded.
    pub(super) fn sanitize_arith(&mut self, id: ExprId, op: Option<BinOp>, ty: i64) -> bool {
        let check = match is_unsigned_ty(ty) {
            true => Check::UnsignedIntegerOverflow,
            false => Check::SignedIntegerOverflow,
        };
        if !self.sanitize.runs(check)
            || !is_integer_scalar_ty(ty)
            || is_bool_ty(ty)
            || !matches!(self.size_of_type(ty), 4 | 8)
        {
            return false;
        }
        let handler = match op {
            Some(BinOp::Add) => "__ubsan_handle_add_overflow",
            Some(BinOp::Sub) => "__ubsan_handle_sub_overflow",
            Some(BinOp::Mul) => "__ubsan_handle_mul_overflow",
            None => "__ubsan_handle_negate_overflow",
            _ => return false,
        };
        let values = if op.is_some() { 2 } else { 1 };
        self.attach_check(id, check.bit(), handler, &[ty], values);
        true
    }

    /// The operator of the binary or compound-assignment node `id`.
    fn node_op(&self, id: ExprId) -> Option<BinOp> {
        use crate::c5::ast::Expr;
        match self.ast.expr(id) {
            Expr::Binary { op, .. } | Expr::CompoundAssign { op, .. } => Some(*op),
            _ => None,
        }
    }

    /// Check the shift at node `id`, a binary operator or a compound
    /// assignment, of a left operand promoted to `ty` by an amount of type
    /// `amount_ty`, under `-fsanitize=shift-exponent` and, for a signed
    /// left shift, `-fsanitize=shift-base`; whether a check was attached.
    pub(super) fn sanitize_shift(&mut self, id: ExprId, ty: i64, amount_ty: i64) -> bool {
        let left = self.node_op(id) == Some(BinOp::Shl);
        let base = if left && !is_unsigned_ty(ty) {
            Check::ShiftBase.bit()
        } else {
            0
        };
        let checks = (Check::ShiftExponent.bit() | base) & self.sanitize.enabled;
        if checks == 0 || !is_integer_scalar_ty(ty) || !matches!(self.size_of_type(ty), 4 | 8) {
            return false;
        }
        let handler = "__ubsan_handle_shift_out_of_bounds";
        self.attach_check(id, checks, handler, &[ty, amount_ty], 2);
        true
    }

    /// Check the `/` or `%` at node `id`, a binary operator or a compound
    /// assignment, computed in `ty`, under `-fsanitize=integer-divide-by-zero`
    /// and, for a signed type, `-fsanitize=signed-integer-overflow` (the
    /// type's minimum by -1); whether a check was attached.
    pub(super) fn sanitize_divide(&mut self, id: ExprId, ty: i64) -> bool {
        let overflow = if is_unsigned_ty(ty) {
            0
        } else {
            Check::SignedIntegerOverflow.bit()
        };
        let checks = (Check::IntegerDivideByZero.bit() | overflow) & self.sanitize.enabled;
        if checks == 0 || !is_integer_scalar_ty(ty) || !matches!(self.size_of_type(ty), 4 | 8) {
            return false;
        }
        self.attach_check(id, checks, "__ubsan_handle_divrem_overflow", &[ty], 2);
        true
    }

    /// Whether the parse tracks the object an expression designates
    /// ([`super::ObjectRef`]): inside a `__builtin_object_size` operand, and
    /// under the checks that read it -- a bounds check, which holds a
    /// subscript to the array's bound, and `object-size`.
    pub(super) fn tracks_objects(&self) -> bool {
        let tracked = [
            Check::Bounds,
            Check::BoundsStrict,
            Check::Null,
            Check::Alignment,
            Check::ObjectSize,
        ];
        self.pending.object_size_operands > 0
            || tracked
                .iter()
                .any(|&c| self.sanitize.enabled & c.bit() != 0)
    }

    /// Check the address the dereference or subscript node `id` accesses, a
    /// `ty` object aligned to `align`, under `-fsanitize=null` and
    /// `alignment`, at `at`. Where the operand `base` designates is a named
    /// object the address is not null, and is aligned unless a cast gave the
    /// dereference its type. Under `object-size` a dereference of an
    /// object's address with fewer bytes left than `ty` fails. The access is
    /// a load until [`Self::settle_access_checks`] finds it stored.
    pub(super) fn sanitize_access(
        &mut self,
        id: ExprId,
        base: Option<super::ObjectRef>,
        (ty, align): (i64, i64),
        at: (u32, u32),
    ) {
        if self.unevaluated > 0 {
            return;
        }
        let named = base.is_some_and(|r| r.addr && !r.via_pointer);
        let (deref, cast) = match self.ast.expr(id) {
            Expr::Unary {
                op: crate::c5::ast::UnOp::Deref,
                child,
                ..
            } => (true, matches!(self.ast.expr(*child), Expr::Cast { .. })),
            _ => (false, false),
        };
        let room = base
            .and_then(|r| r.whole.filter(|_| r.addr))
            .map(|e| e.remaining());
        let short = deref
            && self.sanitize.runs(Check::ObjectSize)
            && room.is_some_and(|left| left < self.size_of_type(ty) as i64);
        if named && !cast && !short {
            return;
        }
        let tests = (!named, !named || cast, short);
        if let Some(check) = self.access_check((ty, Some(id)), align, TCK_LOAD, at, tests) {
            self.ast.access_checks.insert(id, check);
        }
    }

    /// Check the pointer arithmetic at node `id` -- `+` or `-` of an integer,
    /// a subscript, `+=`, `-=`, `++` or `--` -- by the byte offset node
    /// `offset`, at `at`, under `-fsanitize=pointer-overflow`. An offset
    /// that folds to 0 takes no check.
    pub(super) fn sanitize_pointer_step(
        &mut self,
        id: ExprId,
        offset: Option<ExprId>,
        at: (u32, u32),
    ) {
        let check = Check::PointerOverflow;
        if !self.sanitize.runs(check) || self.unevaluated > 0 {
            return;
        }
        if offset.is_some_and(|o| self.ast_const_value(o).is_some_and(|(v, _)| v == 0)) {
            return;
        }
        let data = self.ubsan_site_at(at, &[]);
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_pointer_overflow", 2);
        let checks = check.bit();
        let check = SanitizeCheck {
            checks,
            data,
            handler,
        };
        self.ast.checks.insert(id, check);
    }

    /// Check the member access at node `member`, of the field `(ty, off)`
    /// of the structure type `record`, whose operand `obj` is the
    /// structure's address (`->`) or the structure (`.`): the structure's
    /// address, at the member name `at` for `->` and
    /// where the operand begins (`begin`) for `.` of a dereference, then the
    /// member's. A `.` operand that is a named object takes no check, nor a
    /// structure address that is a constant.
    pub(super) fn sanitize_member(
        &mut self,
        (obj, member): (ExprId, Option<ExprId>),
        (record, arrow): (i64, bool),
        (ty, off): (i64, i64),
        (at, begin): ((u32, u32), (u32, u32)),
    ) {
        if self.unevaluated > 0 {
            return;
        }
        let record_align = self.align_of_type(record) as i64;
        let base_align = if arrow {
            let constant = match self.ast.expr(obj) {
                Expr::Cast { child, .. } => self.ast_const_value(*child).is_some(),
                _ => self.ast_const_value(obj).is_some(),
            };
            if !constant
                && let Some(check) = self.access_check(
                    (record, None),
                    record_align,
                    TCK_MEMBER_ACCESS,
                    at,
                    (true, true, false),
                )
            {
                self.ast.value_checks.entry(obj).or_default().push(check);
            }
            record_align
        } else {
            let deref = matches!(
                self.ast.expr(obj),
                Expr::Unary {
                    op: crate::c5::ast::UnOp::Deref,
                    ..
                }
            );
            let Some(check) = self.ast.access_checks.get(&obj).copied() else {
                return;
            };
            let data = check.check.data as usize;
            self.data[data + 25] = TCK_MEMBER_ACCESS;
            if deref {
                self.data[data + 8..data + 12].copy_from_slice(&begin.0.to_le_bytes());
                self.data[data + 12..data + 16].copy_from_slice(&begin.1.to_le_bytes());
            }
            1 << self.data[data + 24]
        };
        // The alignment the structure's address and the offset give.
        let align = match off {
            0 => base_align,
            _ => base_align.min(1 << off.trailing_zeros()),
        };
        if let Some(member) = member
            && let Some(check) =
                self.access_check((ty, Some(member)), align, TCK_LOAD, at, (true, true, false))
        {
            self.ast.access_checks.insert(member, check);
        }
    }

    /// The check of an access of a `ty` object aligned to `align` at `at`,
    /// by the node `node` where it names a pointer to a function: clang's
    /// `TypeMismatchDataV1`, the site, the type, the alignment's log2 and
    /// the access `kind`, testing the address for null and alignment where
    /// asked; `short` fails the access, its object too small. A volatile
    /// access is not checked.
    fn access_check(
        &mut self,
        (ty, node): (i64, Option<ExprId>),
        align: i64,
        kind: u8,
        at: (u32, u32),
        (null, aligned, short): (bool, bool, bool),
    ) -> Option<ValueCheck> {
        if super::types::is_volatile_object_ty(ty) {
            return None;
        }
        let null = null && self.sanitize.runs(Check::Null);
        let aligned = aligned && self.sanitize.runs(Check::Alignment) && align > 1;
        let checks = [
            (null, Check::Null),
            (aligned, Check::Alignment),
            (short, Check::ObjectSize),
        ]
        .iter()
        .filter(|(on, _)| *on)
        .fold(0, |m, (_, c)| m | c.bit());
        if checks == 0 {
            return None;
        }
        let types = [self.ubsan_object_type(ty, node)];
        let data = self.ubsan_site_at(at, &types);
        self.data.resize(self.data.len() + 8, 0);
        // The alignment the handler holds the address to: 1 unchecked.
        let checked = if aligned { align } else { 1 };
        self.data[data as usize + 24] = checked.trailing_zeros() as u8;
        self.data[data as usize + 25] = kind;
        let handler = self.ubsan_handler(checks, "__ubsan_handle_type_mismatch_v1", 1);
        let check = SanitizeCheck {
            checks,
            data,
            handler,
        };
        let align_mask = if aligned { align as u64 - 1 } else { 0 };
        let test = ValueTest::Pointer {
            null,
            align_mask,
            short,
        };
        Some(ValueCheck { check, test })
    }

    /// Settle the function's access checks once its body is parsed: the
    /// lvalue an assignment, a compound assignment or an increment writes
    /// is a store, and the operand of `&` is not accessed (C17 6.5.3.2p3).
    pub(super) fn settle_access_checks(&mut self) {
        if self.ast.access_checks.is_empty() {
            return;
        }
        let mut stored = alloc::vec::Vec::new();
        let mut addressed = alloc::vec::Vec::new();
        for e in &self.ast.exprs {
            match e {
                Expr::Assign { lhs, .. }
                | Expr::CompoundAssign { lhs, .. }
                | Expr::PreInc { lvalue: lhs, .. }
                | Expr::PostInc { lvalue: lhs, .. } => stored.push(*lhs),
                Expr::Unary {
                    op: crate::c5::ast::UnOp::AddrOf,
                    child,
                    ..
                } => addressed.push(*child),
                _ => {}
            }
        }
        for id in addressed {
            self.ast.access_checks.remove(&id);
        }
        for id in stored {
            if let Some(check) = self.ast.access_checks.get(&id) {
                self.data[check.check.data as usize + 25] = TCK_STORE;
            }
        }
    }

    /// Check the subscript at node `subscript`, by the index node `index`
    /// of type `index_ty`, of the array `base` designates, whose elements
    /// of type `elem_ty` are `stride` bytes, under `-fsanitize=bounds` or
    /// `bounds-strict`. The site is where the subscripted expression
    /// begins, `begin`.
    pub(super) fn sanitize_subscript(
        &mut self,
        base: super::ObjectRef,
        (subscript, index): (ExprId, ExprId),
        (index_ty, elem_ty): (i64, i64),
        stride: i64,
        begin: (u32, u32),
    ) {
        let check = if self.sanitize.runs(Check::BoundsStrict) {
            Check::BoundsStrict
        } else if self.sanitize.runs(Check::Bounds) && !base.flexible {
            Check::Bounds
        } else {
            return;
        };
        let Some(bytes) = base.bound.filter(|_| base.addr && stride > 0) else {
            return;
        };
        let len = (bytes / stride) as u64;
        let types = [
            self.ubsan_array_type(elem_ty, len),
            self.ubsan_type(index_ty),
        ];
        let data = self.ubsan_site_at(begin, &types);
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_out_of_bounds", 1);
        let check = SanitizeCheck {
            checks: check.bit(),
            data,
            handler,
        };
        let test = ValueTest::Index {
            len,
            one_past: false,
        };
        let checks = self.ast.value_checks.entry(index).or_default();
        checks.push(ValueCheck { check, test });
        self.bounds_subscript = Some((subscript, index));
    }

    /// Check the variable-length array bound at node `dim`, of type `ty`, which
    /// begins at `at`, under `-fsanitize=vla-bound`: above 0, or for an
    /// unsigned bound not 0.
    pub(super) fn sanitize_vla_bound(&mut self, dim: ExprId, ty: i64, at: (u32, u32)) {
        let check = Check::VlaBound;
        if !self.sanitize.runs(check) || !is_integer_scalar_ty(ty) {
            return;
        }
        let types = [self.ubsan_type(ty)];
        let data = self.ubsan_site_at(at, &types);
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_vla_bound_not_positive", 1);
        let check = SanitizeCheck {
            checks: check.bit(),
            data,
            handler,
        };
        let test = ValueTest::Positive {
            signed: !is_unsigned_ty(ty),
        };
        let checks = self.ast.value_checks.entry(dim).or_default();
        checks.push(ValueCheck { check, test });
    }

    /// Check the operand `arg` of `__builtin_clz` (`clz`) or `__builtin_ctz`,
    /// or of a wider form, at `at`, under `-fsanitize=builtin`: not 0.
    pub(super) fn sanitize_builtin(&mut self, arg: ExprId, clz: bool, at: (u32, u32)) {
        let check = Check::Builtin;
        if !self.sanitize.runs(check) {
            return;
        }
        // `InvalidBuiltinData`: the location, then the kind (1 for clz).
        let data = self.ubsan_site_at(at, &[]);
        self.data.resize(self.data.len() + 8, 0);
        self.data[data as usize + 16] = u8::from(clz);
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_invalid_builtin", 0);
        let check = SanitizeCheck {
            checks: check.bit(),
            data,
            handler,
        };
        let test = ValueTest::NonZero { site: None };
        let checks = self.ast.value_checks.entry(arg).or_default();
        checks.push(ValueCheck { check, test });
    }

    /// Check argument `number` (1-based), node `arg` beginning at `at`, of a
    /// call to a function whose `nonnull` at `attr` names it, under
    /// `-fsanitize=nonnull-attribute`: not null.
    pub(super) fn sanitize_nonnull_arg(
        &mut self,
        arg: ExprId,
        number: u32,
        attr: (u32, u32, u32),
        at: (u32, u32),
    ) {
        let check = Check::NonnullAttribute;
        if !self.sanitize.runs(check) || self.unevaluated != 0 {
            return;
        }
        // `NonNullArgData`: the location, the attribute's, the number.
        let data = self.ubsan_site_at(at, &[]);
        self.data.resize(self.data.len() + 24, 0);
        self.ubsan_location(data + 16, attr);
        let n = data as usize + 32;
        self.data[n..n + 4].copy_from_slice(&number.to_le_bytes());
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_nonnull_arg", 0);
        let check = SanitizeCheck {
            checks: check.bit(),
            data,
            handler,
        };
        let test = ValueTest::NonZero { site: None };
        let checks = self.ast.value_checks.entry(arg).or_default();
        checks.push(ValueCheck { check, test });
    }

    /// Check the value node `value` a `return` at `at` gives a function whose
    /// `returns_nonnull` is at `attr`, under
    /// `-fsanitize=returns-nonnull-attribute`: not null.
    pub(super) fn sanitize_nonnull_return(
        &mut self,
        value: ExprId,
        attr: (u32, u32, u32),
        at: (u32, u32),
    ) {
        let check = Check::ReturnsNonnullAttribute;
        if !self.sanitize.runs(check) {
            return;
        }
        // `NonNullReturnData` holds the attribute's location; the handler
        // takes the statement's beside it.
        self.align_data_to(8);
        let data = self.data.len() as i64;
        self.data.resize(self.data.len() + 16, 0);
        self.data_object_starts.push(data);
        self.ubsan_location(data, attr);
        let site = self.ubsan_site_at(at, &[]);
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_nonnull_return_v1", 1);
        let check = SanitizeCheck {
            checks: check.bit(),
            data,
            handler,
        };
        let test = ValueTest::NonZero { site: Some(site) };
        let checks = self.ast.value_checks.entry(value).or_default();
        checks.push(ValueCheck { check, test });
    }

    /// Report the `__builtin_unreachable()` call at node `id`, which begins
    /// at `at`, where it is reached, under `-fsanitize=unreachable`. Its
    /// handler ends the program, whatever the recovery: it has no form that
    /// returns.
    pub(super) fn sanitize_unreachable(&mut self, id: ExprId, at: (u32, u32)) {
        let check = Check::Unreachable;
        if !self.sanitize.runs(check) {
            return;
        }
        let data = self.ubsan_site_at(at, &[]);
        let handler = (self.sanitize.trap & check.bit() == 0).then(|| {
            let name = "__ubsan_handle_builtin_unreachable";
            let slot = self.resolve_symbol_named(&alloc::format!("{name}.libcall"));
            self.ubsan_handlers
                .insert(slot, (String::from(name), "_Noreturn void(void *)"));
            slot as u32
        });
        let checks = check.bit();
        let check = SanitizeCheck {
            checks,
            data,
            handler,
        };
        self.ast.checks.insert(id, check);
    }

    /// Check the `_Bool` the node `id` of type `ty` loads wherever it is read
    /// as an rvalue, under `-fsanitize=bool`; the site is
    /// [`super::Compiler::lvalue_at`].
    pub(super) fn sanitize_bool_load(&mut self, id: ExprId, ty: i64) {
        let check = Check::Bool;
        if !self.sanitize.runs(check) || !is_bool_ty(ty) || super::types::bool_ptr_depth(ty) != 0 {
            return;
        }
        let types = [self.ubsan_type(ty)];
        let data = self.ubsan_site_at(self.lvalue_at, &types);
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_load_invalid_value", 1);
        let check = SanitizeCheck {
            checks: check.bit(),
            data,
            handler,
        };
        let test = ValueTest::Bool;
        self.ast
            .value_checks
            .entry(id)
            .or_default()
            .push(ValueCheck { check, test });
    }

    /// Check the integer value of node `e`, of type `from`, where its
    /// implicit conversion to the narrower `to` changes it, at the start of
    /// `e` (`at`), under the implicit truncation checks.
    pub(super) fn sanitize_conversion(&mut self, e: ExprId, from: i64, to: i64, at: (u32, u32)) {
        if let Some(check) = self.float_cast_check(from, to, at) {
            self.ast.value_checks.entry(e).or_default().push(check);
            return;
        }
        let Some(test) = self.truncation_test(from, to) else {
            return;
        };
        let check = self.conversion_check(test, from, to, at);
        self.ast.value_checks.entry(e).or_default().push(check);
    }

    /// [`Self::sanitize_conversion`] of the value the compound assignment or
    /// increment `id` computes in `from` and stores into its `to` lvalue,
    /// at its operator.
    pub(super) fn sanitize_stored_conversion(&mut self, id: ExprId, from: i64, to: i64) {
        if let Some(check) = self.float_cast_check(from, to, self.operator_at) {
            self.ast.store_checks.insert(id, check);
            return;
        }
        let Some(test) = self.truncation_test(from, to) else {
            return;
        };
        let check = self.conversion_check(test, from, to, self.operator_at);
        self.ast.store_checks.insert(id, check);
    }

    /// Check the operand node `e` of the cast `(to)` beginning at `at`, of
    /// the floating type `from`, under `-fsanitize=float-cast-overflow`.
    pub(super) fn sanitize_cast(&mut self, e: ExprId, from: i64, to: i64, at: (u32, u32)) {
        if let Some(check) = self.float_cast_check(from, to, at) {
            self.ast.value_checks.entry(e).or_default().push(check);
        }
    }

    /// The check of a value of the floating type `from` converted to the
    /// integer type `to` at `at`, under `-fsanitize=float-cast-overflow`:
    /// the values whose fraction discarded fits `to`, between -2^(n-1) - 1
    /// and 2^(n-1) for a signed `to` of `n` bits, between -1 and 2^n for an
    /// unsigned one, both open; -2^63 - 1 is no `double`, so a signed 64-bit
    /// `to` holds -2^63 and up. clang's `FloatCastOverflowDataV2`: the site
    /// and the two types.
    fn float_cast_check(&mut self, from: i64, to: i64, at: (u32, u32)) -> Option<ValueCheck> {
        let check = Check::FloatCastOverflow;
        if !self.sanitize.runs(check)
            || !is_floating_scalar(from)
            || !is_integer_scalar_ty(to)
            || is_bool_ty(to)
        {
            return None;
        }
        let bits = 8 * self.size_of_type(to) as i32;
        if !matches!(bits, 8 | 16 | 32 | 64) {
            return None;
        }
        // 2^n, exact, from its exponent bits.
        let pow2 = |n: i32| f64::from_bits(((1023 + n) as u64) << 52);
        let (lo, hi, lo_inclusive) = match (is_unsigned_ty(to), bits) {
            (true, _) => (-1.0, pow2(bits), false),
            (false, 64) => (-pow2(63), pow2(63), true),
            (false, _) => (-pow2(bits - 1) - 1.0, pow2(bits - 1), false),
        };
        let types = [self.ubsan_type(from), self.ubsan_type(to)];
        let data = self.ubsan_site_at(at, &types);
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_float_cast_overflow", 1);
        let check = SanitizeCheck {
            checks: check.bit(),
            data,
            handler,
        };
        let test = ValueTest::FloatRange {
            lo: f64::to_bits(lo),
            hi: f64::to_bits(hi),
            lo_inclusive,
            single: is_float_ty(from),
        };
        Some(ValueCheck { check, test })
    }

    /// The test of an integer `from` converted to `to` where that can lose
    /// bits and the check that applies runs: `to` narrower and not `_Bool`.
    fn truncation_test(&self, from: i64, to: i64) -> Option<ValueTest> {
        if !is_integer_scalar_ty(from) || !is_integer_scalar_ty(to) || is_bool_ty(to) {
            return None;
        }
        let (fb, tb) = (8 * self.size_of_type(from), 8 * self.size_of_type(to));
        let (fs, ts) = (!is_unsigned_ty(from), !is_unsigned_ty(to));
        let check = match fs || ts {
            true => Check::ImplicitSignedIntegerTruncation,
            false => Check::ImplicitUnsignedIntegerTruncation,
        };
        (tb < fb && fb <= 64 && self.sanitize.runs(check)).then_some(ValueTest::Truncation {
            from: (fb as u8, fs),
            to: (tb as u8, ts),
        })
    }

    /// The check of `test`: clang's `ImplicitConversionData`, the site and
    /// the two types, then the kind -- 1 for an unsigned truncation, 2 for a
    /// signed one -- and the bit-field width, 0.
    fn conversion_check(
        &mut self,
        test: ValueTest,
        from: i64,
        to: i64,
        at: (u32, u32),
    ) -> ValueCheck {
        let ValueTest::Truncation {
            from: (_, fs),
            to: (_, ts),
        } = test
        else {
            unreachable!("a truncation test")
        };
        let check = match fs || ts {
            true => Check::ImplicitSignedIntegerTruncation,
            false => Check::ImplicitUnsignedIntegerTruncation,
        };
        let types = [self.ubsan_type(from), self.ubsan_type(to)];
        let data = self.ubsan_site_at(at, &types);
        self.data.resize(self.data.len() + 8, 0);
        self.data[data as usize + 32] = if fs || ts { 2 } else { 1 };
        let handler = self.ubsan_handler(check.bit(), "__ubsan_handle_implicit_conversion", 2);
        let check = SanitizeCheck {
            checks: check.bit(),
            data,
            handler,
        };
        ValueCheck { check, test }
    }

    /// `&` of the node `operand`: a subscript checked last admits the
    /// address one past the last element (C17 6.5.6p8).
    pub(super) fn sanitize_address_of(&mut self, operand: ExprId) {
        let Some((subscript, index)) = self.bounds_subscript else {
            return;
        };
        if subscript != operand {
            return;
        }
        for check in self.ast.value_checks.get_mut(&index).into_iter().flatten() {
            if let ValueTest::Index { one_past, .. } = &mut check.test {
                *one_past = true;
            }
        }
    }

    /// Attach `checks` to node `id`: the site data naming `types`, and
    /// `handler` taking it and `values` operands.
    fn attach_check(
        &mut self,
        id: ExprId,
        checks: u32,
        handler: &str,
        types: &[i64],
        values: usize,
    ) {
        let types: alloc::vec::Vec<i64> = types.iter().map(|&t| self.ubsan_type(t)).collect();
        let data = self.ubsan_site(&types);
        let handler = self.ubsan_handler(checks, handler, values);
        self.ast.checks.insert(
            id,
            SanitizeCheck {
                checks,
                data,
                handler,
            },
        );
    }

    /// The handler `name`, taking the site data and `values` operands,
    /// declared for `check`'s recovery, or `None` where the check traps.
    /// A node's checks share one handler: it traps where every one of them
    /// traps, and returns where every one recovers.
    fn ubsan_handler(&mut self, checks: u32, name: &str, values: usize) -> Option<u32> {
        if self.sanitize.trap & checks == checks {
            return None;
        }
        let proto = match values {
            0 => "void(void *)",
            1 => "void(void *, void *)",
            _ => "void(void *, void *, void *)",
        };
        let (name, proto) = if self.sanitize.recover & checks == checks {
            (String::from(name), proto)
        } else {
            let noreturn = match values {
                0 => "_Noreturn void(void *)",
                1 => "_Noreturn void(void *, void *)",
                _ => "_Noreturn void(void *, void *, void *)",
            };
            (alloc::format!("{name}_abort"), noreturn)
        };
        let slot = self.resolve_symbol_named(&alloc::format!("{name}.libcall"));
        self.ubsan_handlers.insert(slot, (name, proto));
        Some(slot as u32)
    }

    /// Declare at file scope the handlers the unit's checks call, as
    /// [`Self::declare_atomic_libcalls`] declares its library calls: a
    /// declaration made inside a function would end with its scope.
    pub(super) fn declare_ubsan_handlers(&mut self) {
        for (slot, (name, proto)) in core::mem::take(&mut self.ubsan_handlers) {
            let (ret, params, noreturn) = self.prototype_types(proto);
            let sym = &mut self.symbols[slot];
            sym.class = Token::Fun as i64;
            sym.type_ = ret;
            sym.set_fn_params(params);
            sym.asm_name = Some(name);
            sym.linkage = crate::c5::symbol::Linkage::External;
            sym.defined_here = false;
            sym.is_noreturn = noreturn;
        }
    }

    /// The data a handler reads for the operation at the last operator:
    /// its `SourceLocation`, then a pointer to each of `types`' descriptors.
    fn ubsan_site(&mut self, types: &[i64]) -> i64 {
        self.ubsan_site_at(self.operator_at, types)
    }

    /// [`Self::ubsan_site`] at line and column `(line, column)`.
    fn ubsan_site_at(&mut self, (line, column): (u32, u32), types: &[i64]) -> i64 {
        let file = self.ubsan_file();
        self.align_data_to(8);
        let site = self.data.len() as i64;
        self.data.resize(self.data.len() + 16 + 8 * types.len(), 0);
        self.data_object_starts.push(site);
        self.data_pointer(site, file);
        let at = site as usize + 8;
        self.data[at..at + 4].copy_from_slice(&line.to_le_bytes());
        self.data[at + 4..at + 8].copy_from_slice(&column.to_le_bytes());
        for (k, &descriptor) in types.iter().enumerate() {
            self.data_pointer(site + 16 + 8 * k as i64, descriptor);
        }
        site
    }

    /// Record the address of the data object at `target` in the 8-byte
    /// slot at `slot`.
    fn data_pointer(&mut self, slot: i64, target: i64) {
        let at = slot as usize;
        self.data[at..at + 8].copy_from_slice(&(target as u64).to_le_bytes());
        self.note_init_reloc(at);
        self.data_relocs.push(DataReloc {
            data_offset: slot as u64,
            target_offset: target as u64,
            target_anchor: target as u64,
            target_sym: None,
        });
    }

    /// Write the `SourceLocation` of `(file, line, column)`, a file of
    /// `source_files`, into the 16 bytes at `slot`.
    fn ubsan_location(&mut self, slot: i64, (file, line, column): (u32, u32, u32)) {
        let name = self.source_files[file as usize].clone();
        let name = self.ubsan_file_named(name);
        self.data_pointer(slot, name);
        let at = slot as usize + 8;
        self.data[at..at + 4].copy_from_slice(&line.to_le_bytes());
        self.data[at + 4..at + 8].copy_from_slice(&column.to_le_bytes());
    }

    /// The unit's file name, as a handler prints it, once per name.
    fn ubsan_file(&mut self) -> i64 {
        self.ubsan_file_named(self.lex.file.clone())
    }

    /// The name `name`, as a handler prints it, once per name.
    fn ubsan_file_named(&mut self, name: String) -> i64 {
        if let Some(&at) = self.ubsan_files.get(&name) {
            return at;
        }
        let at = self.data.len() as i64;
        self.data.extend_from_slice(name.as_bytes());
        self.data.push(0);
        self.data_object_starts.push(at);
        self.ubsan_files.insert(name, at);
        at
    }

    /// The `TypeDescriptor` of an array of `len` elements of `elem_ty`,
    /// named as C spells the type: `'int[10]'`, `'int[3][5]'`.
    fn ubsan_array_type(&mut self, elem_ty: i64, len: u64) -> i64 {
        let elem = clang_spelling(&super::types::format_type(
            super::types::unqualified_version_ty(elem_ty),
            &self.structs,
        ));
        let name = match elem.find('[') {
            Some(i) => alloc::format!("'{}[{len}]{}'", elem[..i].trim_end(), &elem[i..]),
            None => alloc::format!("'{elem}[{len}]'"),
        };
        self.type_descriptor((name, TK_UNKNOWN, 0))
    }

    /// The `TypeDescriptor` of a value of type `ty`, named as C spells the
    /// type, unqualified and an enumeration's by its compatible integer type.
    fn ubsan_type(&mut self, ty: i64) -> i64 {
        let bare = super::types::unqualified_version_ty(super::types::without_enum(ty));
        let name = clang_spelling(&super::types::format_type(bare, &self.structs));
        let name = alloc::format!("'{name}'");
        let (kind, info) = self.descriptor_kind(ty);
        self.type_descriptor((name, kind, info))
    }

    /// The `TypeDescriptor` of an object of type `ty`, named as declared,
    /// qualifiers and all; a pointer to
    /// a function by the function type the node `node` has.
    fn ubsan_object_type(&mut self, ty: i64, node: Option<ExprId>) -> i64 {
        let spelled = match node.and_then(|id| self.expr_fn(id)) {
            Some((f, depth)) if depth >= 1 => self.fn_type_text(ty, &f, depth),
            _ => super::types::format_type(ty, &self.structs),
        };
        let name = clang_spelling(&spelled);
        let name = alloc::format!("'{name}'");
        let (kind, info) = self.descriptor_kind(ty);
        self.type_descriptor((name, kind, info))
    }

    /// A `TypeDescriptor`'s kind and `info` word for `ty`. An integer type's
    /// `info` is its width's log2 shifted left by one with the signedness in
    /// bit 0; a floating type's is the width of the value a check passes,
    /// `float`'s 32 bits and 64 for the others, as badc computes in
    /// `double` precision; any other type's kind is unknown.
    fn descriptor_kind(&self, ty: i64) -> (u16, u16) {
        if is_floating_scalar(ty) {
            (TK_FLOAT, if is_float_ty(ty) { 32 } else { 64 })
        } else if !is_integer_scalar_ty(ty) {
            (TK_UNKNOWN, 0)
        } else {
            let bits = 8 * self.size_of_type(ty) as u16;
            let info = (bits.trailing_zeros() as u16) << 1 | u16::from(!is_unsigned_ty(ty));
            (TK_INTEGER, info)
        }
    }

    /// The `TypeDescriptor` carrying `name`, `kind` and `info`, once per
    /// unit.
    fn type_descriptor(&mut self, key: (String, u16, u16)) -> i64 {
        if let Some(&at) = self.ubsan_types.get(&key) {
            return at;
        }
        self.align_data_to(2);
        let at = self.data.len() as i64;
        self.data.extend_from_slice(&key.1.to_le_bytes());
        self.data.extend_from_slice(&key.2.to_le_bytes());
        self.data.extend_from_slice(key.0.as_bytes());
        self.data.push(0);
        self.data_object_starts.push(at);
        self.ubsan_types.insert(key, at);
        at
    }
}

/// The type `text` spells, in a report's form: a space before a
/// pointer declarator that follows a name and none after a `*` (`int *`,
/// `int *const *`, `int (*)[4]`).
fn clang_spelling(text: &str) -> String {
    let mut out = String::with_capacity(text.len() + 4);
    let mut prev = ' ';
    let mut chars = text.chars().peekable();
    while let Some(c) = chars.next() {
        if c == ' ' && prev == '*' {
            continue;
        }
        let declarator = c == '*' || (c == '(' && chars.peek() == Some(&'*'));
        if declarator && (prev.is_ascii_alphanumeric() || prev == '_') {
            out.push(' ');
        }
        out.push(c);
        prev = c;
    }
    out
}
