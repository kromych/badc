//! The runtime checks `-fsanitize=` inserts, as gcc's and clang's
//! UndefinedBehaviorSanitizer names them, with the site data their
//! handlers read in the layout those handlers take: a
//! `SourceLocation {const char *file; u32 line, column}` and, per check,
//! pointers to `TypeDescriptor {u16 kind, info; char name[]}` records.

use alloc::string::String;

use super::Compiler;
use super::types::{is_bool_ty, is_integer_scalar_ty, is_unsigned_ty};
use crate::c5::ast::{ExprId, SanitizeCheck, ValueCheck, ValueTest};
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
    /// no C load is out of range and the check inserts nothing, as gcc's and
    /// clang's do in C.
    Enum,
    /// A subscript of an array of known bound past it (C17 6.5.6p8), but
    /// for a trailing member gcc lets extend past its bound; clang's
    /// `array-bounds`. An address one past the last element is in bounds.
    Bounds,
    /// [`Check::Bounds`] on those trailing members as well.
    BoundsStrict,
    /// A load of a `_Bool` whose byte is neither 0 nor 1 (C17 6.2.6.1p5,
    /// a trap representation).
    Bool,
    /// An implicit conversion of an unsigned integer to a narrower unsigned
    /// type that changes the value (C17 6.3.1.3p2: defined, reduced modulo).
    ImplicitUnsignedIntegerTruncation,
    /// An implicit conversion to a narrower integer type, either one
    /// signed, that changes the value (C17 6.3.1.3p2-p3).
    ImplicitSignedIntegerTruncation,
}

impl Check {
    /// Every check: those `-fsanitize=undefined` lists, in its order, then
    /// clang's implicit-conversion checks.
    pub const ALL: [Check; 10] = [
        Check::SignedIntegerOverflow,
        Check::ShiftBase,
        Check::ShiftExponent,
        Check::IntegerDivideByZero,
        Check::Enum,
        Check::Bounds,
        Check::BoundsStrict,
        Check::Bool,
        Check::ImplicitUnsignedIntegerTruncation,
        Check::ImplicitSignedIntegerTruncation,
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
            Check::ImplicitUnsignedIntegerTruncation => "implicit-unsigned-integer-truncation",
            Check::ImplicitSignedIntegerTruncation => "implicit-signed-integer-truncation",
        }
    }

    pub const fn bit(self) -> u32 {
        1 << self as u32
    }

    /// The checks a `-fsanitize=` list item names: one check, clang's name
    /// for one, or a group: `shift`; `undefined`, which leaves out
    /// `bounds-strict` as gcc's does and the implicit conversions, defined
    /// behavior, as clang's does; and clang's implicit-conversion groups,
    /// of which badc implements the truncations. `None` for a name badc does
    /// not implement.
    pub fn named(name: &str) -> Option<u32> {
        let truncation = Check::ImplicitUnsignedIntegerTruncation.bit()
            | Check::ImplicitSignedIntegerTruncation.bit();
        match name {
            "undefined" => Some(
                (Check::ALL.iter())
                    .filter(|&&c| c != Check::BoundsStrict && c.bit() & truncation == 0)
                    .fold(0, |m, c| m | c.bit()),
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
/// calling a handler and the ones whose handler returns, as gcc and clang
/// default it: every handler returns.
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
/// `TypeDescriptor::kind` of a type the handlers know by its name alone.
const TK_UNKNOWN: u16 = 0xffff;

impl Compiler {
    /// Check the signed `+`, `-` or `*` whose node the accumulator holds,
    /// computed in the common type `ty`, under `-fsanitize=
    /// signed-integer-overflow`; whether a check was attached.
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

    /// Check the signed operation at node `id` -- `op` (`+`, `-`, `*`), or
    /// a negation for `None` -- computed in `ty`, under
    /// `-fsanitize=signed-integer-overflow`; whether a check was attached.
    /// The operator is the last one [`Self::operator_at`] recorded.
    pub(super) fn sanitize_arith(&mut self, id: ExprId, op: Option<BinOp>, ty: i64) -> bool {
        let check = Check::SignedIntegerOverflow;
        if !self.sanitize.runs(check)
            || !is_integer_scalar_ty(ty)
            || is_unsigned_ty(ty)
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
    /// under a bounds check, which holds a subscript to the array's bound.
    pub(super) fn tracks_objects(&self) -> bool {
        self.pending.object_size_operands > 0
            || self.sanitize.enabled & (Check::Bounds.bit() | Check::BoundsStrict.bit()) != 0
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
        let Some(test) = self.truncation_test(from, to) else {
            return;
        };
        let check = self.conversion_check(test, from, to, self.operator_at);
        self.ast.store_checks.insert(id, check);
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
            1 => "void(void *, void *)",
            _ => "void(void *, void *, void *)",
        };
        let (name, proto) = if self.sanitize.recover & checks == checks {
            (String::from(name), proto)
        } else {
            let noreturn = match values {
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

    /// The unit's file name, as a handler prints it, once per name.
    fn ubsan_file(&mut self) -> i64 {
        let name = self.lex.file.clone();
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

    /// The `TypeDescriptor` of the integer type `ty`, once per type: the
    /// kind, the width's log2 shifted left by one with the signedness in
    /// bit 0, and the type's name in single quotes.
    /// The `TypeDescriptor` of an array of `len` elements of `elem_ty`,
    /// named as C spells the type: `'int[10]'`, `'int[3][5]'`.
    fn ubsan_array_type(&mut self, elem_ty: i64, len: u64) -> i64 {
        let elem =
            super::types::format_type(super::types::unqualified_version_ty(elem_ty), &self.structs);
        let name = match elem.find('[') {
            Some(i) => alloc::format!("'{}[{len}]{}'", elem[..i].trim_end(), &elem[i..]),
            None => alloc::format!("'{elem}[{len}]'"),
        };
        if let Some(&at) = self.ubsan_arrays.get(&name) {
            return at;
        }
        self.align_data_to(2);
        let at = self.data.len() as i64;
        self.data.extend_from_slice(&TK_UNKNOWN.to_le_bytes());
        self.data.extend_from_slice(&0u16.to_le_bytes());
        self.data.extend_from_slice(name.as_bytes());
        self.data.push(0);
        self.data_object_starts.push(at);
        self.ubsan_arrays.insert(name, at);
        at
    }

    fn ubsan_type(&mut self, ty: i64) -> i64 {
        if let Some(&at) = self.ubsan_types.get(&ty) {
            return at;
        }
        let bits = 8 * self.size_of_type(ty) as u16;
        let info = (bits.trailing_zeros() as u16) << 1 | u16::from(!is_unsigned_ty(ty));
        // The type as C spells it, unqualified and an enumeration's by its
        // compatible integer type.
        let bare = super::types::unqualified_version_ty(super::types::without_enum(ty));
        let name = alloc::format!("'{}'", super::types::format_type(bare, &self.structs));
        self.align_data_to(2);
        let at = self.data.len() as i64;
        self.data.extend_from_slice(&TK_INTEGER.to_le_bytes());
        self.data.extend_from_slice(&info.to_le_bytes());
        self.data.extend_from_slice(name.as_bytes());
        self.data.push(0);
        self.data_object_starts.push(at);
        self.ubsan_types.insert(ty, at);
        at
    }
}
