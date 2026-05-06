//! Struct / union body parser.
//!
//! Lives next to `compiler/mod.rs` because the recursive descent for
//! a `struct Foo { ... }` definition is the longest single method in
//! the parser and is fully self-contained -- it consumes the body
//! tokens, runs the field-layout pass (with bitfield bit-packing
//! state), and registers the struct in `self.structs`. Nothing else
//! in the compiler reaches into the layout state, so isolating it
//! here keeps the bit-packing invariants in one place.
//!
//! Caller is `parse_decl_base_type` in `compiler/mod.rs`, which
//! recognises `struct Tag { ... }` / `union Tag { ... }` at the
//! base-type position and dispatches here.

use alloc::format;
use alloc::string::ToString;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::types::{
    is_decl_modifier, is_struct_ty, round_up, struct_id_of, struct_ptr_depth, struct_ty_for,
};
use super::{Compiler, StructDef, StructField};

impl Compiler {
    /// Parse a `struct Name { ... }` / `union Name { ... }` body.
    /// Pre-registers `name` (or recycles a forward declaration) so
    /// self-referential pointer fields can find the aggregate
    /// mid-definition. Field offsets are placed at each field's
    /// natural alignment under M31 (`int` packs at 4, `long` /
    /// pointer at 8, `char` at 1); the aggregate's own alignment is
    /// the max of its fields' alignments, capped at 8.
    ///
    /// On entry `tk` is `{`; on exit `tk` is the token AFTER the
    /// closing `}` (typically `;`).
    ///
    /// Layout pass shared by `struct` and `union` definitions. The
    /// only difference is that union members all sit at offset 0
    /// and the aggregate's size is `max(field size)` rather than
    /// the sum. Member access otherwise reuses the struct field
    /// path.
    pub(super) fn parse_aggregate_body(
        &mut self,
        name: &str,
        is_union: bool,
    ) -> Result<usize, C5Error> {
        // Pre-register or recycle a forward declaration so
        // self-referential pointer fields can find this aggregate
        // mid-definition. If the tag already exists with a populated
        // body, this is a duplicate definition and we error.
        let struct_id = match self.find_struct_id(name) {
            Some(id) if self.structs[id].fields.is_empty() => {
                self.structs[id].is_union = is_union;
                id
            }
            Some(_) => {
                return Err(C5Error::Compile(format!(
                    "{}: {} `{}` already defined",
                    self.lex.line,
                    if is_union { "union" } else { "struct" },
                    name
                )));
            }
            None => {
                self.structs.push(StructDef {
                    name: name.to_string(),
                    size: 0,
                    align: 1,
                    fields: Vec::new(),
                    is_union,
                });
                self.structs.len() - 1
            }
        };

        self.next()?; // consume `{`

        let mut offset = 0usize;
        // Running max field alignment for the aggregate. Each
        // non-bitfield field bumps this if its natural alignment
        // exceeds the running max. The final struct alignment is
        // capped at 8 because the rest of c5's IR slots at 8.
        let mut struct_align: usize = 1;
        // Bit-packing state for contiguous bitfields. When
        // `bf_active` is true, `bf_storage_offset` is the byte
        // offset of the current 8-byte storage unit and
        // `bf_next_bit` is the next free bit position within it.
        // A non-bitfield field or a bitfield that doesn't fit
        // closes the unit.
        let mut bf_active = false;
        let mut bf_storage_offset: usize = 0;
        let mut bf_next_bit: u32 = 0;
        while self.lex.tk != '}' as i64 {
            // Field type prefix: int, char, float, double, or struct Name.
            // Leading qualifiers / int modifiers / function specifiers
            // (`const`, `unsigned`, ...) are no-ops; track if any int
            // modifier appeared so a bare `unsigned x;` field still
            // produces an `int` field.
            let mut saw_int_mod = false;
            let mut saw_signed = false;
            while is_decl_modifier(self.lex.tk) {
                if self.lex.tk == Token::IntMod as i64 {
                    saw_int_mod = true;
                } else if self.lex.tk == Token::Signed as i64 {
                    saw_signed = true;
                    saw_int_mod = true;
                }
                self.next()?;
            }
            let field_base = if self.lex.tk == Token::Int as i64 {
                self.next()?;
                Ty::Int as i64
            } else if self.lex.tk == Token::Char as i64 {
                self.next()?;
                // Mirror parse_decl_base_type: `signed char` field
                // gets promoted to int so negative byte values load
                // sign-extended. Plain / unsigned char stays 1 byte.
                if saw_signed {
                    Ty::Int as i64
                } else {
                    Ty::Char as i64
                }
            } else if self.lex.tk == Token::Float as i64 {
                self.next()?;
                Ty::Float as i64
            } else if self.lex.tk == Token::Double as i64 {
                self.next()?;
                Ty::Double as i64
            } else if self.lex.tk == Token::Struct as i64
                || self.lex.tk == Token::Union as i64
            {
                let nested_is_union = self.lex.tk == Token::Union as i64;
                self.next()?;
                // Three shapes:
                //   * `struct Foo { ... }` -- named definition.
                //   * `struct Foo`         -- type use.
                //   * `struct { ... }`     -- anonymous (no tag),
                //                            inlined here. We
                //                            synthesise a unique
                //                            tag to register it
                //                            in the struct table.
                let inner_name = if self.lex.tk == Token::Id as i64 {
                    let name = self.symbols[self.lex.curr_id_idx].name.clone();
                    self.next()?;
                    name
                } else if self.lex.tk == '{' as i64 {
                    let kind = if nested_is_union { "anon_union" } else { "anon_struct" };
                    format!("__{kind}_{}_in_{}", self.structs.len(), name)
                } else {
                    return Err(C5Error::Compile(format!(
                        "{}: aggregate name or `{{` expected in field type",
                        self.lex.line
                    )));
                };
                let inner_id = if self.lex.tk == '{' as i64 {
                    self.parse_aggregate_body(&inner_name, nested_is_union)?
                } else {
                    self.find_or_forward_declare_struct(&inner_name)
                };
                struct_ty_for(inner_id)
            } else if self.is_lex_typedef_name() {
                let aliased = self.symbols[self.lex.curr_id_idx].type_;
                self.next()?;
                aliased
            } else if saw_int_mod {
                Ty::Int as i64
            } else {
                return Err(C5Error::Compile(format!(
                    "{}: type expected in struct field",
                    self.lex.line
                )));
            };

            // Trailing modifiers: `int long`, `unsigned long long`, etc.
            while is_decl_modifier(self.lex.tk) {
                self.next()?;
            }

            // One or more comma-separated declarators sharing the prefix.
            // Routed through `parse_declarator` so function-pointer
            // fields (`int (*xCompare)(int, int);`) and array fields
            // (`int counts[8];`) parse with the same rules as locals
            // and globals.
            loop {
                // Anonymous bitfield (`int :N;`) -- skips a name and
                // just reserves bits for padding. Detected by `:`
                // appearing in declarator position.
                let anon_bitfield_width = if self.lex.tk == ':' as i64 {
                    self.next()?;
                    let n = self.parse_constant_int()?;
                    if n < 0 {
                        return Err(C5Error::Compile(format!(
                            "{}: bitfield width must be non-negative (got {n})",
                            self.lex.line
                        )));
                    }
                    Some(n as u32)
                } else {
                    None
                };

                if let Some(width) = anon_bitfield_width {
                    if width == 0 {
                        // C99 `:0` -- explicit alignment to next storage unit.
                        if bf_active && !is_union {
                            offset = bf_storage_offset + 8;
                        }
                        bf_active = false;
                    } else if !is_union {
                        // Allocate or extend a bitfield run for the padding.
                        if !bf_active || bf_next_bit + width > 64 {
                            offset = round_up(offset, 8);
                            bf_storage_offset = offset;
                            offset += 8;
                            bf_next_bit = 0;
                            bf_active = true;
                        }
                        bf_next_bit += width;
                    }
                    if self.lex.tk == ',' as i64 {
                        self.next()?;
                        continue;
                    }
                    break;
                }

                let (id_idx, field_ty, field_array_size) =
                    self.parse_declarator(field_base)?;
                let is_aggregate_value =
                    is_struct_ty(field_ty) && struct_ptr_depth(field_ty) == 0;
                if is_aggregate_value
                    && field_array_size == 0
                    && self.structs[struct_id_of(field_ty)].fields.is_empty()
                {
                    return Err(C5Error::Compile(format!(
                        "{}: aggregate-value field of incomplete type",
                        self.lex.line
                    )));
                }
                let field_name = self.symbols[id_idx].name.clone();

                // Bitfield? `int x:N` shapes the field as N bits
                // packed into a shared 8-byte storage unit. The
                // bit-packing state above tracks whether we're
                // inside an active run.
                let mut bit_width: u32 = 0;
                let mut bit_offset: u32 = 0;
                let field_offset: usize;
                if self.lex.tk == ':' as i64 {
                    if field_array_size != 0 {
                        return Err(C5Error::Compile(format!(
                            "{}: array fields cannot also be bitfields",
                            self.lex.line
                        )));
                    }
                    if is_aggregate_value {
                        return Err(C5Error::Compile(format!(
                            "{}: aggregate fields cannot also be bitfields",
                            self.lex.line
                        )));
                    }
                    self.next()?;
                    let n = self.parse_constant_int()?;
                    if n <= 0 {
                        return Err(C5Error::Compile(format!(
                            "{}: bitfield width must be positive (got {n})",
                            self.lex.line
                        )));
                    }
                    if n > 64 {
                        return Err(C5Error::Compile(format!(
                            "{}: bitfield width {n} exceeds 64",
                            self.lex.line
                        )));
                    }
                    bit_width = n as u32;
                    if is_union {
                        field_offset = 0;
                        bit_offset = 0;
                    } else {
                        if !bf_active || bf_next_bit + bit_width > 64 {
                            offset = round_up(offset, 8);
                            bf_storage_offset = offset;
                            offset += 8;
                            bf_next_bit = 0;
                            bf_active = true;
                        }
                        field_offset = bf_storage_offset;
                        bit_offset = bf_next_bit;
                        bf_next_bit += bit_width;
                    }
                } else {
                    // Regular (non-bitfield) field. Seal any pending
                    // bitfield run so the next byte is correctly
                    // aligned for a new field.
                    bf_active = false;

                    // Layout: struct fields advance the cursor at
                    // their natural alignment (M31). `int` fields
                    // pack 4 bytes; `long` / pointer fields use 8;
                    // `char` packs at 1; struct fields inherit
                    // their nested alignment. Union fields all sit
                    // at offset 0 and contribute their size to the
                    // running max.
                    let elem_size = self.size_of_type(field_ty);
                    let field_storage = if field_array_size > 0 {
                        elem_size * field_array_size as usize
                    } else {
                        elem_size
                    };
                    let field_align = self.align_of_type(field_ty);
                    if field_align > struct_align {
                        struct_align = field_align;
                    }
                    field_offset = if is_union {
                        0
                    } else {
                        offset = round_up(offset, field_align);
                        let off = offset;
                        offset += field_storage;
                        off
                    };
                    if is_union && field_storage > offset {
                        offset = field_storage;
                    }
                }

                self.structs[struct_id].fields.push(StructField {
                    name: field_name,
                    offset: field_offset,
                    ty: field_ty,
                    array_size: field_array_size,
                    bit_offset,
                    bit_width,
                });

                if self.lex.tk == ',' as i64 {
                    self.next()?;
                    continue;
                }
                break;
            }

            if self.lex.tk != ';' as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: semicolon expected after struct field",
                    self.lex.line
                )));
            }
            self.next()?;
        }
        self.next()?; // consume `}`

        // Cap struct alignment at 8 -- the rest of the IR slots
        // 8-wide and never asks for stricter alignment, so going
        // above 8 buys nothing (and would force structurally
        // identical code to handle 16-byte SIMD-style aligns).
        let struct_align = struct_align.min(8);
        // Pad the struct's tail up to its alignment so consecutive
        // elements of an array preserve every field's natural
        // alignment. Empty / one-byte structs stay at the c5 floor
        // of 8 bytes (no zero-sized aggregates).
        let total = round_up(offset, struct_align);
        self.structs[struct_id].size = total.max(8);
        self.structs[struct_id].align = struct_align;
        Ok(struct_id)
    }
}
