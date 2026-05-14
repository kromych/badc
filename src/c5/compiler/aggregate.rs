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
    UNSIGNED_BIT, is_decl_modifier, is_struct_ty, round_up, struct_id_of, struct_ptr_depth,
    struct_ty_for,
};
use super::{Compiler, StructDef, StructField};

impl Compiler {
    /// Parse a `struct Name { ... }` / `union Name { ... }` body.
    /// Pre-registers `name` (or recycles a forward declaration) so
    /// self-referential pointer fields can find the aggregate
    /// mid-definition. Field offsets are placed at each field's
    /// natural alignment (`int` packs at 4, `long` / pointer at 8,
    /// `char` at 1); the aggregate's own alignment is the max of
    /// its fields' alignments, capped at 8.
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
                return Err(self.compile_err(format!(
                    "{} `{}` already defined",
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
        while self.lex.tk != '}' {
            // Field type prefix: int, char, float, double, or struct Name.
            // Leading qualifiers / int modifiers / function specifiers
            // (`const`, `unsigned`, ...) are no-ops; track if any int
            // modifier appeared so a bare `unsigned x;` field still
            // produces an `int` field.
            let mut saw_int_mod = false;
            let mut saw_signed = false;
            let mut saw_unsigned = false;
            let mut long_count: u8 = 0;
            let mut saw_short = false;
            // Set when the field-type prefix is an anonymous
            // (no-tag) `struct { ... }` / `union { ... }` whose
            // members should promote into the enclosing struct
            // (C11 6.7.2.1p13). Stays `None` for named tags --
            // those need an explicit declarator. Checked AFTER
            // the type-prefix parse: if there's no declarator
            // (`;` next), the promotion path runs; otherwise the
            // synthesised tag stays a regular nested-struct type.
            let mut anon_aggregate_inner_id: Option<usize> = None;
            while is_decl_modifier(self.lex.tk) {
                if self.lex.tk == Token::IntMod {
                    saw_int_mod = true;
                } else if self.lex.tk == Token::Signed {
                    saw_signed = true;
                    saw_int_mod = true;
                } else if self.lex.tk == Token::Unsigned {
                    saw_unsigned = true;
                    saw_int_mod = true;
                } else if self.lex.tk == Token::Long {
                    long_count = long_count.saturating_add(1);
                    saw_int_mod = true;
                } else if self.lex.tk == Token::Short {
                    saw_short = true;
                    saw_int_mod = true;
                }
                self.next()?;
            }
            let saw_long = long_count >= 1;
            let saw_long_long = long_count >= 2;
            let field_base = if self.lex.tk == Token::Int {
                self.next()?;
                let base = if saw_long_long {
                    Ty::LongLong as i64
                } else if saw_long {
                    Ty::Long as i64
                } else if saw_short {
                    Ty::Short as i64
                } else {
                    Ty::Int as i64
                };
                if saw_unsigned {
                    base | UNSIGNED_BIT
                } else {
                    base
                }
            } else if self.lex.tk == Token::Char {
                self.next()?;
                // Mirror parse_decl_base_type: `signed char` is a
                // real 1-byte signed field; plain / unsigned char
                // is unsigned (zero-extending load).
                if saw_signed {
                    Ty::Char as i64
                } else {
                    Ty::Char as i64 | UNSIGNED_BIT
                }
            } else if self.lex.tk == Token::Void {
                self.next()?;
                // `void *p;` / `void (*fp)(...);` fields: routed
                // through the `unsigned char` encoding so the
                // pointer-arithmetic + sizeof match the
                // legacy void-as-char path. Bare `void m;` is
                // a constraint violation (incomplete type), but
                // c5 doesn't reject it here -- the declarator
                // would have to add a `*` for a real use, and
                // a hypothetical bare field would just allocate
                // 1 byte like the prior behavior did. Promoting
                // this to an error needs a separate
                // declarator-aware check; the bytecode
                // generation works either way.
                Ty::Char as i64 | UNSIGNED_BIT
            } else if self.lex.tk == Token::Float {
                self.next()?;
                Ty::Float as i64
            } else if self.lex.tk == Token::Double {
                self.next()?;
                Ty::Double as i64
            } else if self.lex.tk == Token::Struct || self.lex.tk == Token::Union {
                let nested_is_union = self.lex.tk == Token::Union;
                self.next()?;
                // Three shapes:
                //   * `struct Foo { ... }` -- named definition.
                //   * `struct Foo`         -- type use.
                //   * `struct { ... }`     -- anonymous (no tag),
                //                            inlined here. We
                //                            synthesise a unique
                //                            tag to register it
                //                            in the struct table.
                //                            If no declarator
                //                            follows (next token
                //                            is `;`), the inner
                //                            fields PROMOTE into
                //                            the enclosing scope
                //                            -- C11 6.7.2.1p13.
                let (inner_name, had_explicit_tag) = if self.lex.tk == Token::Id {
                    let name = self.symbols[self.lex.curr_id_idx].name.clone();
                    self.next()?;
                    (name, true)
                } else if self.lex.tk == '{' {
                    let kind = if nested_is_union {
                        "anon_union"
                    } else {
                        "anon_struct"
                    };
                    (
                        format!("__{kind}_{}_in_{}", self.structs.len(), name),
                        false,
                    )
                } else {
                    return Err(self.compile_err("aggregate name or `{{` expected in field type"));
                };
                let inner_id = if self.lex.tk == '{' {
                    self.parse_aggregate_body(&inner_name, nested_is_union)?
                } else {
                    self.find_or_forward_declare_struct(&inner_name)
                };
                anon_aggregate_inner_id = if had_explicit_tag {
                    None
                } else {
                    Some(inner_id)
                };
                struct_ty_for(inner_id)
            } else if self.lex.tk == Token::Enum {
                // C99 6.7.2.2: an `enum X` field collapses to plain
                // `int` in c5's type system the same way every other
                // enum reference does. Consume any tag name and the
                // optional body; the field width / alignment is the
                // 4-byte `int` fallback. Mirrors the
                // `parse_decl_base_type` enum branch so the same
                // shape works at file scope and inside a struct.
                self.next()?;
                if self.lex.tk == Token::Id {
                    self.next()?;
                }
                if self.lex.tk == '{' {
                    self.parse_enum_body()?;
                }
                Ty::Int as i64
            } else if self.is_lex_typedef_name() {
                let aliased = self.symbols[self.lex.curr_id_idx].type_;
                // C99 6.7.7 paragraph 3: a typedef name carries
                // through any array dimension on its alias. Stash
                // the count so the field-binding code below can
                // make `jmp_buf b;` lay out `long b[64];`.
                let typedef_array = self.symbols[self.lex.curr_id_idx].array_size;
                if typedef_array > 0 {
                    self.pending.typedef_base_array_size = typedef_array;
                }
                self.next()?;
                aliased
            } else if saw_int_mod {
                let base = if saw_long_long {
                    Ty::LongLong as i64
                } else if saw_long {
                    Ty::Long as i64
                } else if saw_short {
                    Ty::Short as i64
                } else {
                    Ty::Int as i64
                };
                if saw_unsigned {
                    base | UNSIGNED_BIT
                } else {
                    base
                }
            } else {
                return Err(self.compile_err("type expected in struct field"));
            };

            // Trailing modifiers: `int long`, `unsigned long long`, etc.
            while is_decl_modifier(self.lex.tk) {
                self.next()?;
            }

            // Anonymous struct/union member (C11 6.7.2.1p13). The
            // type-prefix parse just registered an anon-tagged
            // aggregate; if there's no declarator (`;` follows
            // immediately), promote each inner field into the
            // enclosing struct's namespace at the current cursor,
            // adjusting offsets, and skip the regular declarator
            // loop entirely. Real-Windows `LARGE_INTEGER` /
            // `ULARGE_INTEGER` are the canonical use site --
            // their `LowPart` / `HighPart` members live inside
            // an unnamed `struct { ... }` and must be reachable
            // as `li.LowPart` (not `li.<some-tag>.LowPart`).
            if let Some(inner_id) = anon_aggregate_inner_id
                && self.lex.tk == ';'
            {
                {
                    // Seal any pending bitfield run -- the
                    // anonymous aggregate is a regular field
                    // from the cursor's perspective.
                    bf_active = false;

                    let inner_size = self.structs[inner_id].size;
                    let pack = self.lex.current_pack();
                    let inner_align = self.structs[inner_id].align.min(pack);
                    if inner_align > struct_align {
                        struct_align = inner_align;
                    }
                    let base_offset = if is_union {
                        0
                    } else {
                        offset = round_up(offset, inner_align);
                        let off = offset;
                        offset += inner_size;
                        off
                    };
                    if is_union && inner_size > offset {
                        offset = inner_size;
                    }

                    // Copy each inner field into the outer
                    // struct's field list, rebased onto
                    // `base_offset`. Cloning here (rather than
                    // taking by reference) sidesteps the borrow
                    // conflict between reading `self.structs[inner_id]`
                    // and mutating `self.structs[struct_id]`.
                    let inner_fields = self.structs[inner_id].fields.clone();
                    for inner_field in inner_fields {
                        // Reject name collisions early -- C11
                        // says the merged namespace must be
                        // unambiguous. Real MSVC silently picks
                        // the FIRST one but warns; we mirror
                        // that by silently shadowing here too.
                        // The `LARGE_INTEGER` shape relies on
                        // exactly this (anon-struct LowPart and
                        // named-`u`-struct LowPart coexist
                        // because the latter is qualified).
                        self.structs[struct_id].fields.push(StructField {
                            name: inner_field.name,
                            offset: base_offset + inner_field.offset,
                            ty: inner_field.ty,
                            array_size: inner_field.array_size,
                            inner_array_size: inner_field.inner_array_size,
                            array_dims: inner_field.array_dims,
                            bit_offset: inner_field.bit_offset,
                            bit_width: inner_field.bit_width,
                        });
                    }

                    self.next()?; // consume `;`
                    continue;
                }
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
                let anon_bitfield_width = if self.lex.tk == ':' {
                    self.next()?;
                    let n = self.parse_constant_int()?;
                    if n < 0 {
                        return Err(self.compile_err(format!(
                            "bitfield width must be non-negative (got {n})"
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
                    if self.lex.tk == ',' {
                        self.next()?;
                        continue;
                    }
                    break;
                }

                let (id_idx, field_ty, mut field_array_size) = self.parse_declarator(field_base)?;
                // A typedef whose alias is an array contributes its
                // dimension when the declarator did not already
                // supply one (`jmp_buf b;` -> `long b[64];`). A
                // declarator that *did* spell its own dimension
                // takes precedence and the typedef count drops on
                // the floor; the explicit form is unambiguous.
                let typedef_dim = core::mem::take(&mut self.pending.typedef_base_array_size);
                if typedef_dim > 0 && field_array_size == 0 {
                    field_array_size = typedef_dim;
                }
                // Struct fields don't carry the fn-pointer lineage
                // tag on their own (the StructField record has no
                // place for it), so consume the side-channel here.
                // Without this, a struct containing a `int (*cb)(...)`
                // field leaks fn_ptr_indirection = 1 into whatever
                // declaration follows the closing `}` -- including
                // the typedef name in `typedef struct { ... } T;`,
                // which would then mistakenly treat `T *p` as a
                // function-pointer-pointer and turn `*p` into a
                // decay no-op.
                self.pending.fn_ptr_indirection.take();
                let is_aggregate_value = is_struct_ty(field_ty) && struct_ptr_depth(field_ty) == 0;
                if is_aggregate_value
                    && field_array_size == 0
                    && self.structs[struct_id_of(field_ty)].fields.is_empty()
                {
                    return Err(self.compile_err("aggregate-value field of incomplete type"));
                }
                let field_name = self.symbols[id_idx].name.clone();

                // Bitfield? `int x:N` shapes the field as N bits
                // packed into a shared 8-byte storage unit. The
                // bit-packing state above tracks whether we're
                // inside an active run.
                let mut bit_width: u32 = 0;
                let mut bit_offset: u32 = 0;
                let field_offset: usize;
                if self.lex.tk == ':' {
                    if field_array_size != 0 {
                        return Err(self.compile_err("array fields cannot also be bitfields"));
                    }
                    if is_aggregate_value {
                        return Err(self.compile_err("aggregate fields cannot also be bitfields"));
                    }
                    self.next()?;
                    let n = self.parse_constant_int()?;
                    if n <= 0 {
                        return Err(
                            self.compile_err(format!("bitfield width must be positive (got {n})"))
                        );
                    }
                    if n > 64 {
                        return Err(self.compile_err(format!("bitfield width {n} exceeds 64")));
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
                    //
                    // `#pragma pack(N)` clamps each field's natural
                    // alignment by N (and the aggregate's overall
                    // alignment). The lexer tracks the active pack
                    // value via [`Lexer::current_pack`]; default is
                    // 8 (no-op) so unpacked structs lay out exactly
                    // as before.
                    let pack = self.lex.current_pack();
                    let elem_size = self.size_of_type(field_ty);
                    let field_storage = if field_array_size > 0 {
                        elem_size * field_array_size as usize
                    } else {
                        elem_size
                    };
                    let field_align = self.align_of_type(field_ty).min(pack);
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

                let field_inner_array_size = self.symbols[id_idx].inner_array_size;
                let field_array_dims = core::mem::take(&mut self.symbols[id_idx].array_dims);
                self.structs[struct_id].fields.push(StructField {
                    name: field_name,
                    offset: field_offset,
                    ty: field_ty,
                    array_size: field_array_size,
                    inner_array_size: field_inner_array_size,
                    array_dims: field_array_dims,
                    bit_offset,
                    bit_width,
                });

                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }

            if self.lex.tk != ';' {
                return Err(self.compile_err("semicolon expected after struct field"));
            }
            self.next()?;
        }
        self.next()?; // consume `}`

        // Cap struct alignment at 8 -- the rest of the IR slots
        // 8-wide and never asks for stricter alignment, so going
        // above 8 buys nothing (and would force structurally
        // identical code to handle 16-byte SIMD-style aligns).
        // `#pragma pack(N)` further clamps the cap; field-level
        // clamping above already prevents struct_align from
        // exceeding pack, but cap here too so an empty struct
        // under `pack(1)` still ends up with align=1.
        let struct_align = struct_align.min(8).min(self.lex.current_pack());
        // Pad the struct's tail up to its alignment so consecutive
        // elements of an array preserve every field's natural
        // alignment. Empty structs floor at 1 byte (so a `struct
        // *p` always has a meaningful sizeof for pointer
        // arithmetic, matching GCC's empty-struct extension);
        // every other struct's size is whatever the field cursor
        // ended up at, rounded to the struct's own alignment.
        let total = round_up(offset, struct_align);
        self.structs[struct_id].size = total.max(1);
        self.structs[struct_id].align = struct_align;
        Ok(struct_id)
    }
}
