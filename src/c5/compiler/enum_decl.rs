//! Enum-declaration parser.
//!
//! `enum [Tag] [{ A, B = 5, C, ... }]` registers each constant as a
//! `Token::Num` symbol so subsequent references (in expressions, in
//! array dimensions via `parse_constant_int`, etc.) resolve to the
//! enumerated value. The enum's tag itself is consumed without
//! registration -- in c5 every enum collapses to plain `int`, so the
//! tag carries no semantic weight; the implicit "shared scope" of
//! the constants stands in for it.
//!
//! Lives next to `compiler/mod.rs` because the cluster is
//! self-contained and the pair (`parse_enum_decl` -> `parse_enum_body`)
//! moves together. The constants loop reuses
//! `parse_constant_int` for explicit values like `B = 1 << 8`.

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;

impl Compiler {
    pub(super) fn parse_enum_decl(&mut self) -> Result<(), C5Error> {
        self.next()?;
        // Optional tag name. c5 enums collapse to int regardless,
        // so the tag is consumed without registration today (it's
        // remembered implicitly through the matched constants).
        if self.lex.tk == Token::Id {
            self.next()?;
        }
        if self.lex.tk == '{' {
            self.parse_enum_body()?;
        }
        Ok(())
    }

    /// Parse `{ A, B = 5, C, ... }` -- the constants list of an
    /// `enum`. On entry tk is `{`; on exit the closing `}` has
    /// been consumed. Each constant is registered as a
    /// `Token::Num`-class symbol with `val` set to its enumerated
    /// value, so subsequent uses (including in array dimensions
    /// via `parse_constant_int`) resolve correctly.
    pub(super) fn parse_enum_body(&mut self) -> Result<(), C5Error> {
        self.next()?; // consume `{`
        let mut i: i64 = 0;
        while self.lex.tk != '}' {
            if self.lex.tk != Token::Id {
                return Err(self.compile_err("bad enum identifier"));
            }
            let idx = self.lex.curr_id_idx;
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
            i += 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        self.next()?; // consume `}`
        Ok(())
    }
}
