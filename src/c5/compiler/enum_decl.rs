//! Enum-declaration parser.
//!
//! `enum [Tag] [{ A, B = 5, C, ... }]` registers each constant as a
//! `Token::Num` symbol so subsequent references (in expressions, in
//! array dimensions via `parse_constant_int`, etc.) resolve to the
//! enumerated value. A tagged definition also records an `EnumDef`
//! carrying the underlying integer type -- `int` normally, a narrower
//! type for `__attribute__((packed))` -- so a later bare `enum Tag`
//! reference resolves the same size. Anonymous enums skip registration;
//! their constants stay reachable as int-typed `Token::Num` symbols.
//!
//! Lives next to `compiler/mod.rs` because the cluster is
//! self-contained and the pair (`parse_enum_decl` -> `parse_enum_body`)
//! moves together. The constants loop reuses
//! `parse_constant_int` for explicit values like `B = 1 << 8`.

use alloc::string::{String, ToString};

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::types::UNSIGNED_BIT;
use super::{Compiler, EnumDef};

/// `(min, max, constants)` from a parsed enum body: the enumerator value
/// range that drives the packed underlying-type choice, plus the captured
/// name/value pairs the caller records for DWARF.
type EnumBody = (i64, i64, alloc::vec::Vec<(String, i64)>);

impl Compiler {
    /// Parse an `enum` type reference / definition and return its underlying
    /// integer type. A plain enum is `int` (C99 6.7.2.2p4); an
    /// `enum __attribute__((packed))` (per-enum `-fshort-enums`) uses the
    /// smallest integer type holding its enumerators, which changes the
    /// layout of any struct that embeds it, so the size is honored here.
    pub(super) fn parse_enum_decl(&mut self) -> Result<i64, C5Error> {
        self.next()?;
        // An attribute may sit between `enum` and the tag / body
        // (`enum __attribute__((packed)) { ... }`) or after the tag; either
        // position sets `packed`.
        let mut packed = self.skip_attribute_specifiers()?;
        // Optional tag name. Capture it so a matched body can
        // register an `EnumDef` for DWARF emission. Anonymous
        // enums (no tag) skip the registration -- their constants
        // are still int-typed `Token::Num` symbols.
        let tag_name = if self.lex.tk == Token::Id {
            let id_idx = self.lex.curr_id_idx;
            let name = self.symbols[id_idx].name.clone();
            self.next()?;
            name
        } else {
            String::new()
        };
        packed = self.skip_attribute_specifiers()? || packed;
        if self.lex.tk == '{' {
            let (min, max, captured) = self.parse_enum_body()?;
            // An attribute after the closing brace binds to the enum type
            // (`enum E { ... } __attribute__((packed))`), the position GCC
            // and Clang accept most often.
            packed = self.skip_attribute_specifiers()? || packed;
            let underlying = if packed {
                Self::packed_enum_underlying_ty(min, max)
            } else {
                Ty::Int as i64
            };
            if !tag_name.is_empty() && !captured.is_empty() {
                self.enums.push(EnumDef {
                    name: tag_name.to_string(),
                    constants: captured,
                    underlying_ty: underlying,
                });
            }
            return Ok(underlying);
        }
        // A bare `enum Tag` reference reuses the underlying type recorded at
        // the tag's definition, so a packed enum keeps its sub-int width for
        // sizeof / _Alignof and struct-field layout. Only tagged definitions
        // are recorded, so an empty tag never matches.
        if let Some(def) = self.enums.iter().rev().find(|e| e.name == tag_name) {
            return Ok(def.underlying_ty);
        }
        Ok(Ty::Int as i64)
    }

    /// The smallest integer type that represents `[min, max]`, matching
    /// GCC's packed-enum rule: unsigned when all enumerators are
    /// non-negative (sized by `max`), signed otherwise (sized by range).
    fn packed_enum_underlying_ty(min: i64, max: i64) -> i64 {
        if min >= 0 {
            if max <= 0xFF {
                Ty::Char as i64 | UNSIGNED_BIT
            } else if max <= 0xFFFF {
                Ty::Short as i64 | UNSIGNED_BIT
            } else if max <= 0xFFFF_FFFF {
                Ty::Int as i64 | UNSIGNED_BIT
            } else {
                Ty::LongLong as i64 | UNSIGNED_BIT
            }
        } else if min >= -128 && max <= 127 {
            Ty::Char as i64
        } else if min >= -32768 && max <= 32767 {
            Ty::Short as i64
        } else if min >= i32::MIN as i64 && max <= i32::MAX as i64 {
            Ty::Int as i64
        } else {
            Ty::LongLong as i64
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
        while self.lex.tk != '}' {
            if self.lex.tk != Token::Id {
                return Err(self.compile_err("bad enum identifier"));
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
            self.symbols[idx].class = Token::Num as i64;
            self.symbols[idx].type_ = Ty::Int as i64;
            self.symbols[idx].val = i;
            captured.push((name, i));
            i += 1;
            self.accept(',')?;
        }
        self.next()?; // consume `}`
        // Value range drives the packed-enum underlying-type choice; the
        // caller records the resulting EnumDef once packedness is known.
        let min = captured.iter().map(|&(_, v)| v).min().unwrap_or(0);
        let max = captured.iter().map(|&(_, v)| v).max().unwrap_or(0);
        Ok((min, max, captured))
    }
}
