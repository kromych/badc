//! The runtime checks `-fsanitize=` inserts, as gcc's and clang's
//! UndefinedBehaviorSanitizer names them, with the site data their
//! handlers read in the layout those handlers take: a
//! `SourceLocation {const char *file; u32 line, column}` and, per check,
//! pointers to `TypeDescriptor {u16 kind, info; char name[]}` records.

use alloc::string::String;

use super::Compiler;
use super::types::{is_bool_ty, is_integer_scalar_ty, is_unsigned_ty};
use crate::c5::ast::{ExprId, SanitizeCheck};
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
}

impl Check {
    /// Every check, in the order `-fsanitize=undefined` lists them.
    pub const ALL: [Check; 4] = [
        Check::SignedIntegerOverflow,
        Check::ShiftBase,
        Check::ShiftExponent,
        Check::IntegerDivideByZero,
    ];

    /// The spelling `-fsanitize=` takes.
    pub const fn name(self) -> &'static str {
        match self {
            Check::SignedIntegerOverflow => "signed-integer-overflow",
            Check::ShiftBase => "shift-base",
            Check::ShiftExponent => "shift-exponent",
            Check::IntegerDivideByZero => "integer-divide-by-zero",
        }
    }

    pub const fn bit(self) -> u32 {
        1 << self as u32
    }

    /// The checks a `-fsanitize=` list item names: one check, the group
    /// `shift`, or the group `undefined`; `None` for a name badc does not
    /// implement.
    pub fn named(name: &str) -> Option<u32> {
        match name {
            "undefined" => Some(Check::ALL.iter().fold(0, |m, c| m | c.bit())),
            "shift" => Some(Check::ShiftBase.bit() | Check::ShiftExponent.bit()),
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
            recover: Check::named("undefined").unwrap_or(0),
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

    /// Check the shift whose node the accumulator holds, of a left operand
    /// promoted to `ty` by an amount of type `amount_ty`, under
    /// `-fsanitize=shift-exponent` and, for a signed left shift,
    /// `-fsanitize=shift-base`.
    pub(super) fn sanitize_shift(&mut self, ty: i64, amount_ty: i64) {
        let Some(id) = self.ast_acc else {
            return;
        };
        let left = matches!(
            self.ast.expr(id),
            crate::c5::ast::Expr::Binary { op: BinOp::Shl, .. }
        );
        let base = if left && !is_unsigned_ty(ty) {
            Check::ShiftBase.bit()
        } else {
            0
        };
        let checks = (Check::ShiftExponent.bit() | base) & self.sanitize.enabled;
        if checks == 0 || !is_integer_scalar_ty(ty) || !matches!(self.size_of_type(ty), 4 | 8) {
            return;
        }
        let handler = "__ubsan_handle_shift_out_of_bounds";
        self.attach_check(id, checks, handler, &[ty, amount_ty], 2);
    }

    /// Check the `/` or `%` whose node the accumulator holds, computed in
    /// `ty`, under `-fsanitize=integer-divide-by-zero` and, for a signed
    /// type, `-fsanitize=signed-integer-overflow` (the type's minimum by
    /// -1); whether a check was attached.
    pub(super) fn sanitize_divide(&mut self, ty: i64) -> bool {
        let Some(id) = self.ast_acc else {
            return false;
        };
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
        let file = self.ubsan_file();
        let (line, column) = self.operator_at;
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
    fn ubsan_type(&mut self, ty: i64) -> i64 {
        if let Some(&at) = self.ubsan_types.get(&ty) {
            return at;
        }
        let bits = 8 * self.size_of_type(ty) as u16;
        let info = (bits.trailing_zeros() as u16) << 1 | u16::from(!is_unsigned_ty(ty));
        let name = match super::types::without_enum(ty) {
            t if t == crate::c5::token::Ty::Long as i64 => "'long'",
            t if t == crate::c5::token::Ty::LongLong as i64 => "'long long'",
            _ if bits == 64 => "'long long'",
            _ => "'int'",
        };
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
