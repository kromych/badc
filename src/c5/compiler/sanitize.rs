//! The runtime checks `-fsanitize=` inserts, as gcc's and clang's
//! UndefinedBehaviorSanitizer names them, with the site data their
//! handlers read in the layout those handlers take: a
//! `SourceLocation {const char *file; u32 line, column}` and, per check,
//! pointers to `TypeDescriptor {u16 kind, info; char name[]}` records.

use alloc::string::String;

use super::Compiler;
use super::types::{is_bool_ty, is_integer_scalar_ty, is_unsigned_ty};
use crate::c5::ast::SanitizeCheck;
use crate::c5::ir::BinOp;
use crate::c5::program::DataReloc;
use crate::c5::token::Token;

/// A runtime check, as `-fsanitize=` names it.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub enum Check {
    /// A signed `+`, `-` or `*` whose value its type cannot represent
    /// (C17 6.5p5).
    SignedIntegerOverflow,
}

impl Check {
    /// Every check, in the order `-fsanitize=undefined` lists them.
    pub const ALL: [Check; 1] = [Check::SignedIntegerOverflow];

    /// The spelling `-fsanitize=` takes.
    pub const fn name(self) -> &'static str {
        match self {
            Check::SignedIntegerOverflow => "signed-integer-overflow",
        }
    }

    const fn bit(self) -> u32 {
        1 << self as u32
    }

    /// The checks a `-fsanitize=` list item names: one check, or the
    /// group `undefined`; `None` for a name badc does not implement.
    pub fn named(name: &str) -> Option<u32> {
        if name == "undefined" {
            return Some(Check::ALL.iter().fold(0, |m, c| m | c.bit()));
        }
        (Check::ALL.iter())
            .find(|c| c.name() == name)
            .map(|c| c.bit())
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

    const fn traps(&self, check: Check) -> bool {
        self.trap & check.bit() != 0
    }

    const fn recovers(&self, check: Check) -> bool {
        self.recover & check.bit() != 0
    }
}

/// `TypeDescriptor::kind` of an integer type.
const TK_INTEGER: u16 = 0;

impl Compiler {
    /// Check the signed `+`, `-` or `*` whose node the accumulator holds,
    /// computed in the common type `ty`, under `-fsanitize=
    /// signed-integer-overflow`; whether a check was attached.
    pub(super) fn sanitize_overflow(&mut self, ty: i64) -> bool {
        let check = Check::SignedIntegerOverflow;
        if !self.sanitize.runs(check)
            || !is_integer_scalar_ty(ty)
            || is_unsigned_ty(ty)
            || is_bool_ty(ty)
            || !matches!(self.size_of_type(ty), 4 | 8)
        {
            return false;
        }
        let Some(id) = self.ast_acc else {
            return false;
        };
        let handler = match self.ast.expr(id) {
            crate::c5::ast::Expr::Binary { op: BinOp::Add, .. } => "__ubsan_handle_add_overflow",
            crate::c5::ast::Expr::Binary { op: BinOp::Sub, .. } => "__ubsan_handle_sub_overflow",
            crate::c5::ast::Expr::Binary { op: BinOp::Mul, .. } => "__ubsan_handle_mul_overflow",
            _ => return false,
        };
        let types = [self.ubsan_type(ty)];
        let data = self.ubsan_site(&types);
        let handler = self.ubsan_handler(check, handler);
        self.ast.checks.insert(
            id,
            SanitizeCheck {
                kind: check,
                data,
                handler,
            },
        );
        true
    }

    /// The handler `name` declared for `check`'s recovery, or `None` where
    /// the check traps.
    fn ubsan_handler(&mut self, check: Check, name: &str) -> Option<u32> {
        if self.sanitize.traps(check) {
            return None;
        }
        let (name, proto) = if self.sanitize.recovers(check) {
            (String::from(name), "void(void *, void *, void *)")
        } else {
            (
                alloc::format!("{name}_abort"),
                "_Noreturn void(void *, void *, void *)",
            )
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
