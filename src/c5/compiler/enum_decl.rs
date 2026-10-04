//! Enum-declaration parser.
//!
//! `enum [Tag] [{ A, B = 5, C, ... }]` registers each constant as a
//! `Token::Num` symbol so subsequent references (in expressions, in
//! array dimensions via `parse_constant_int`, etc.) resolve to the
//! enumerated value. The tag lives in the scoped tag table with the
//! struct and union tags; its entry records the underlying integer type
//! the list chooses -- `int` when every value fits, wider / unsigned
//! otherwise, a narrower type for `__attribute__((packed))` -- which a
//! later `enum Tag` names. A definition also records an `EnumDef` for the
//! DWARF emitters; an untagged one is recorded under the empty name.
//!
//! Lives next to `compiler/mod.rs` because the cluster is
//! self-contained and the pair (`parse_enum_decl` -> `parse_enum_body`)
//! moves together. The constants loop reuses
//! `parse_constant_int` for explicit values like `B = 1 << 8`.

use super::super::diag::Code;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::symbol::{FnParams, FnType};
use super::super::token::{Token, Ty};
use super::types::{UNSIGNED_BIT, enum_ty, rebase_enum_placeholder, struct_ty_for};
use super::{Compiler, EnumDef};

/// The definition of an enum tag, applied to the types an earlier use of
/// the tag built on its incomplete entry. Each applied tag is cleared, since
/// the placeholder is gone once rewritten.
pub(super) struct EnumCompletion {
    tag: u32,
    underlying: i64,
}

impl EnumCompletion {
    pub(super) fn ty(&self, ty: &mut i64, tag: &mut Option<u32>) {
        if *tag == Some(self.tag) {
            *ty = rebase_enum_placeholder(*ty, self.tag as usize, self.underlying);
            *tag = None;
        }
    }

    /// The parameter types `tags` marks with this enum's placeholder.
    pub(super) fn list(&self, types: &mut [i64], tags: &mut Vec<(usize, u32)>) {
        tags.retain(|&(pos, t)| {
            let own = t == self.tag;
            if own && let Some(ty) = types.get_mut(pos) {
                *ty = rebase_enum_placeholder(*ty, self.tag as usize, self.underlying);
            }
            !own
        });
    }

    pub(super) fn params(&self, p: &mut FnParams) {
        self.list(&mut p.types, &mut p.enum_tags);
    }

    /// The function types a returned pointer leads to.
    pub(super) fn chain(&self, ret: &mut Option<(alloc::boxed::Box<FnType>, i64)>) {
        if let Some((f, _)) = ret {
            self.params(&mut f.params);
            self.chain(&mut f.ret);
        }
    }
}

/// `(min, max, constants)` from a parsed enum body: the enumerator value
/// range that drives the packed underlying-type choice, plus the captured
/// name/value pairs the caller records for DWARF.
type EnumBody = (i64, i64, alloc::vec::Vec<(String, i64)>);

/// The integer type compatible with an enum whose values span
/// `[min, max]`. C99 6.7.2.2p4 leaves the choice to the
/// implementation; GCC picks `unsigned int` whenever no enumerator is
/// negative (widening to the 64-bit type `wide` when a value exceeds it)
/// and `int` otherwise, so an all-non-negative enum compares, divides,
/// and converts as an unsigned type.
fn enum_compatible_ty(min: i64, max: i64, wide: i64) -> i64 {
    if min < 0 {
        if min >= i32::MIN as i64 && max <= i32::MAX as i64 {
            Ty::Int as i64
        } else {
            wide
        }
    } else if max <= u32::MAX as i64 {
        Ty::Int as i64 | UNSIGNED_BIT
    } else {
        wide | UNSIGNED_BIT
    }
}

/// The type of one enumerator constant. Within a 32-bit enum GCC
/// types each constant by its own value -- `int` when it fits (C99
/// 6.7.2.2p3), `unsigned int` for the wider extension values -- while
/// every constant of an enum needing a 64-bit type takes that type.
fn enumerator_constant_ty(v: i64, enum_ty: i64) -> i64 {
    if (enum_ty & !UNSIGNED_BIT) != Ty::Int as i64 {
        enum_ty
    } else if v >= i32::MIN as i64 && v <= i32::MAX as i64 {
        Ty::Int as i64
    } else {
        Ty::Int as i64 | UNSIGNED_BIT
    }
}

impl Compiler {
    /// Parse an `enum` type reference / definition and return the enumerated
    /// type -- its underlying integer type with the enum's identity -- or,
    /// with the tag, the tag's entry when it has no definition yet. A plain
    /// enum takes `enum_compatible_ty` (C99 6.7.2.2p4 leaves the choice
    /// open; `int` when every value fits); an `enum __attribute__((packed))`
    /// (per-enum `-fshort-enums`) uses the smallest integer type holding its
    /// enumerators, which changes the layout of any struct that embeds it,
    /// so the size is honored here.
    pub(super) fn parse_enum_decl(&mut self) -> Result<(i64, Option<u32>), C5Error> {
        self.next()?;
        // An attribute may sit between `enum` and the tag / body
        // (`enum __attribute__((packed)) { ... }`) or after the tag; either
        // position sets `packed`.
        let mut packed = self.skip_attribute_specifiers()?;
        // Optional tag name; a definition registers its `EnumDef` under
        // it, empty for an untagged enum.
        let tag_name = if self.lex.tk == Token::Id {
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;
            Some(name)
        } else {
            None
        };
        packed = self.skip_attribute_specifiers()? || packed;
        if self.lex.tk == '{' {
            // The tag's scope begins before the list (C99 6.2.1p7). An
            // untagged enumeration is a type of its own all the same
            // (6.7.2.2p4), on an entry no tag names.
            let id = match &tag_name {
                Some(name) => self.define_enum_tag(name)?,
                None => {
                    self.structs
                        .push(super::StructDef::incomplete_tag("", false, true));
                    self.structs.len() - 1
                }
            };
            let (min, max, captured) = self.parse_enum_body()?;
            // An attribute after the closing brace binds to the enum type
            // (`enum E { ... } __attribute__((packed))`), the position GCC
            // and Clang accept most often.
            packed = self.skip_attribute_specifiers()? || packed;
            self.pending.attr_transparent_union = false;
            let underlying = if let Some(m) = self.pending.attr_mode.take() {
                // `mode(M)` fixes the enum's width outright; the
                // enumerators must fit, as GCC requires.
                let base = enum_compatible_ty(min, max, self.enum_wide_ty());
                let ty = self.apply_mode_to_type(base, m)?;
                let bits = self.size_of_type(ty) as u32 * 8;
                let fits = if min < 0 {
                    bits >= 64 || (min >= -(1i64 << (bits - 1)) && max < (1i64 << (bits - 1)))
                } else {
                    bits >= 64 || max < (1i64 << bits)
                };
                if !fits {
                    return Err(self.compile_err(
                        Code::INVALID_DECLARATION,
                        "specified mode too small for enumerated values",
                    ));
                }
                ty
            } else if packed {
                Self::packed_enum_underlying_ty(min, max, self.enum_wide_ty())
            } else {
                enum_compatible_ty(min, max, self.enum_wide_ty())
            };
            if !captured.is_empty() {
                self.enums.push(EnumDef {
                    name: tag_name.unwrap_or_default(),
                    constants: captured,
                    underlying_ty: underlying,
                });
            }
            self.structs[id].enum_underlying = Some(underlying);
            self.complete_enum_placeholders(id as u32, underlying);
            return Ok((enum_ty(underlying, id), None));
        }
        let Some(name) = tag_name else {
            return Err(self.compile_err(Code::SYNTAX, "enum name or `{` expected"));
        };
        // `enum Tag` names the visible tag's type: the integer type its
        // definition chose, so a packed enum keeps its sub-int width, with
        // the tag's identity. With no tag visible, GNU C declares an
        // incomplete enum here, which C99 6.7.2.3p2 does not allow.
        let id = match self.find_tag(&name) {
            Some(id) => {
                self.check_tag_kind(id, "enum")?;
                id
            }
            None => self.declare_tag(&name, false, true),
        };
        if let Some(underlying) = self.structs[id].enum_underlying {
            return Ok((enum_ty(underlying, id), None));
        }
        // The incomplete type is the tag's entry, which the checks for an
        // incomplete struct reject where a complete type is required. The
        // declarations built on it record the tag, and the definition
        // rewrites their types.
        let tag = id as u32;
        if !self.enum_placeholder_tags.contains(&tag) {
            self.enum_placeholder_tags.push(tag);
        }
        Ok((struct_ty_for(id), Some(tag)))
    }

    /// The tag entry an enum definition completes: a declaration of the tag
    /// in the current scope, or a fresh one that hides any outer tag.
    fn define_enum_tag(&mut self, name: &str) -> Result<usize, C5Error> {
        let Some(id) = self.find_tag_in_current_scope(name) else {
            return Ok(self.declare_tag(name, false, true));
        };
        self.check_tag_kind(id, "enum")?;
        if self.structs[id].enum_underlying.is_some() {
            return Err(self.compile_err(
                Code::INVALID_DECLARATION,
                alloc::format!("enum `{name}` already defined"),
            ));
        }
        Ok(id)
    }

    /// C99 6.7.2.2p4: the definition of enum tag `tag` completes the type
    /// its earlier uses named through the tag's entry. Rewrites the
    /// objects, functions, parameters and members declared through it,
    /// and the outer bindings an open scope shadows. A tentative definition
    /// declared through it is sized when the unit ends.
    fn complete_enum_placeholders(&mut self, tag: u32, underlying: i64) {
        let Some(at) = self.enum_placeholder_tags.iter().position(|&t| t == tag) else {
            return;
        };
        self.enum_placeholder_tags.swap_remove(at);
        let c = EnumCompletion { tag, underlying };
        for s in &mut self.symbols {
            c.ty(&mut s.type_, &mut s.incomplete_enum_tag);
            c.ty(&mut s.h_type, &mut s.h_incomplete_enum_tag);
            c.list(&mut s.params, &mut s.param_enum_tags);
            c.list(&mut s.h_params, &mut s.h_param_enum_tags);
            c.chain(&mut s.ret_fn);
            c.chain(&mut s.h_ret_fn);
        }
        for b in self.block_scopes.iter_mut().flatten() {
            b.complete_enum(&c);
        }
        for f in self.structs.iter_mut().flat_map(|s| s.fields.iter_mut()) {
            c.ty(&mut f.ty, &mut f.enum_tag);
            c.list(&mut f.params, &mut f.param_enum_tags);
            c.chain(&mut f.ret_fn);
        }
    }

    /// The 64-bit type an enum widens to: `long` where it is 64 bits wide,
    /// as gcc and clang choose, `long long` where `long` is 32.
    fn enum_wide_ty(&self) -> i64 {
        if self.target.long_width_bytes() == 8 {
            Ty::Long as i64
        } else {
            Ty::LongLong as i64
        }
    }

    /// The smallest integer type that represents `[min, max]`, matching
    /// GCC's packed-enum rule: unsigned when all enumerators are
    /// non-negative (sized by `max`), signed otherwise (sized by range).
    fn packed_enum_underlying_ty(min: i64, max: i64, wide: i64) -> i64 {
        if min >= 0 {
            if max <= 0xFF {
                Ty::Char as i64 | UNSIGNED_BIT
            } else if max <= 0xFFFF {
                Ty::Short as i64 | UNSIGNED_BIT
            } else if max <= 0xFFFF_FFFF {
                Ty::Int as i64 | UNSIGNED_BIT
            } else {
                wide | UNSIGNED_BIT
            }
        } else if min >= -128 && max <= 127 {
            Ty::Char as i64
        } else if min >= -32768 && max <= 32767 {
            Ty::Short as i64
        } else if min >= i32::MIN as i64 && max <= i32::MAX as i64 {
            Ty::Int as i64
        } else {
            wide
        }
    }

    /// Parse `{ A, B = 5, C, ... }` -- the constants list of an
    /// `enum`. On entry tk is `{`; on exit the closing `}` has
    /// been consumed. Each constant is registered as a
    /// `Token::Num`-class symbol with `val` set to its enumerated
    /// value, so subsequent uses (including in array dimensions
    /// via `parse_constant_int`) resolve correctly.
    pub(super) fn parse_enum_body(&mut self) -> Result<EnumBody, C5Error> {
        self.next()?; // consume `{`
        let mut i: i64 = 0;
        let mut captured: alloc::vec::Vec<(String, i64)> = alloc::vec::Vec::new();
        let mut sym_indexes: alloc::vec::Vec<usize> = alloc::vec::Vec::new();
        while self.lex.tk != '}' {
            if self.lex.tk != Token::Id {
                return Err(self.compile_err(Code::SYNTAX, "bad enum identifier"));
            }
            let idx = self.lex.curr_id_idx;
            let name = self.symbols[idx].name.clone();
            self.next()?;
            if self.lex.tk == Token::Assign {
                self.next()?;
                // Constant expression -- handles literals, unary
                // signs, parens, casts, shifts (`1 << 8`), the
                // conditional operator, and identifiers bound to
                // prior `Token::Num` enum entries / `#define`d
                // constants.
                i = self.parse_constant_int()?;
            }
            // Inside a function the enumerator has block scope (C99
            // 6.2.1p4): a name the current scope already declared is a
            // redeclaration (6.7p3); otherwise the outer binding is
            // saved and restored at scope exit. File scope binds
            // permanently.
            self.rebind_scoped(idx)?;
            self.symbols[idx].class = Token::Num as i64;
            self.symbols[idx].incomplete_enum_tag = None;
            // During the body the constant carries its value's own type
            // so a reference from a later enumerator converts correctly;
            // the whole list is restamped below once the range is known.
            self.symbols[idx].type_ =
                enumerator_constant_ty(i, enum_compatible_ty(i, i, self.enum_wide_ty()));
            self.symbols[idx].val = i;
            captured.push((name, i));
            sym_indexes.push(idx);
            i += 1;
            self.list_separator('}', "enumerator")?;
        }
        self.next()?; // consume `}`
        // Value range drives the packed-enum underlying-type choice; the
        // caller records the resulting EnumDef once packedness is known.
        let min = captured.iter().map(|&(_, v)| v).min().unwrap_or(0);
        let max = captured.iter().map(|&(_, v)| v).max().unwrap_or(0);
        // On completion each constant is restamped against the whole
        // range: per-value within a 32-bit enum, the enum's own 64-bit
        // type otherwise (GCC). `packed` narrows only the enum type,
        // never the constants.
        let compatible = enum_compatible_ty(min, max, self.enum_wide_ty());
        for (&idx, &(_, v)) in sym_indexes.iter().zip(&captured) {
            self.symbols[idx].type_ = enumerator_constant_ty(v, compatible);
        }
        Ok((min, max, captured))
    }
}
