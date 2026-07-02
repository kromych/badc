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
use super::decl_base;
use super::types::{
    UNSIGNED_BIT, is_decl_modifier, is_pointer_ty, is_struct_ty, round_up, struct_id_of,
    struct_ptr_depth, struct_ty_for,
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
        packed: bool,
    ) -> Result<usize, C5Error> {
        // Pre-register or recycle a forward declaration so
        // self-referential pointer fields can find this aggregate
        // mid-definition. C99 6.2.1: only a tag in the SAME scope
        // makes this a redefinition; a tag of the same name in an
        // outer scope is shadowed by a fresh declaration here.
        let struct_id = match self.find_struct_id_in_current_scope(name) {
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
                let id = self.structs.len() - 1;
                if let Some(scope) = self.tag_scopes.last_mut() {
                    scope.push((name.to_string(), id));
                }
                id
            }
        };

        self.next()?; // consume `{`

        // Save the outer typedef-array carrier so a `typedef
        // struct { fe X; ... } ge;` body that ends with an
        // array-typedef field does not leak that dimension into
        // the outer declarator binding of `ge`. Restored just
        // before this function returns.
        let saved_typedef_base_array_size = self.pending.typedef_base_array_size;
        self.pending.typedef_base_array_size = 0;

        let mut offset = 0usize;
        // Running max field alignment for the aggregate. Each
        // non-bitfield field bumps this if its natural alignment
        // exceeds the running max. The final struct alignment is
        // capped at 8 because the rest of c5's IR slots at 8.
        let mut struct_align: usize = 1;
        // Bit-packing state for contiguous bitfields. `bf_bit_cursor`
        // is the next free bit position measured from the start of the
        // aggregate; the run begins at `offset * 8` when `bf_active`
        // turns true. Each bitfield is placed at the cursor and bumped
        // to the next storage-unit boundary of its declared type only
        // when it would otherwise straddle one (the SysV AMD64 / AAPCS64
        // rule gcc and clang follow), so a smaller-typed bitfield can
        // share the bits left in a larger-typed neighbour's unit.
        let mut bf_active = false;
        let mut bf_bit_cursor: usize = 0;
        // Set once any field is declared. The empty-aggregate floor to
        // 1 byte below applies only to a truly fieldless `struct {}`; an
        // aggregate with members whose sizes sum to 0 (flexible /
        // zero-length arrays, or nested size-0 aggregates) has size 0
        // (gcc / clang), and flooring it would add a spurious byte that
        // mis-pads any enclosing aggregate.
        let mut saw_field = false;
        while self.lex.tk != '}' {
            // C11 6.7.2.1: a static_assert-declaration may appear in the
            // struct-declaration-list. It declares no member, so handle
            // it before the field-type parse and continue.
            if self.lex.tk == Token::StaticAssert {
                self.parse_static_assert()?;
                continue;
            }
            // Reset the typedef-array carrier between field groups
            // (`jmp_buf env;` then `int code;`). The aggregate
            // parser has its own inline base-type reader and does
            // not call `parse_decl_base_type`, so the carrier
            // would otherwise leak its prior value into the next
            // group and turn an unrelated scalar field into a
            // bogus array.
            self.pending.typedef_base_array_size = 0;
            // Field type prefix: int, char, float, double, or struct Name.
            // Leading qualifiers / int modifiers / function specifiers
            // (`const`, `unsigned`, ...) are no-ops; track if any int
            // modifier appeared so a bare `unsigned x;` field still
            // produces an `int` field.
            let mut mods = decl_base::IntModifiers::default();
            // Set when the field-type prefix is an anonymous
            // (no-tag) `struct { ... }` / `union { ... }` whose
            // members should promote into the enclosing struct
            // (C11 6.7.2.1p13). Stays `None` for named tags --
            // those need an explicit declarator. Checked AFTER
            // the type-prefix parse: if there's no declarator
            // (`;` next), the promotion path runs; otherwise the
            // synthesised tag stays a regular nested-struct type.
            let mut anon_aggregate_inner_id: Option<usize> = None;
            let mut atomic_field_base: Option<i64> = None;
            while is_decl_modifier(self.lex.tk) {
                if self.lex.tk == Token::Attribute {
                    self.skip_attribute_specifiers()?;
                    continue;
                }
                if self.lex.tk == Token::Atomic && self.lex.peek_after_whitespace(b'(') {
                    // C11 6.7.2.4 atomic type specifier `_Atomic(type-name)`
                    // as a field base type (distinct from the `_Atomic`
                    // qualifier consumed as a no-op below).
                    atomic_field_base = self.try_parse_atomic_type_specifier()?;
                    continue;
                }
                if self.try_consume_int_modifier(&mut mods)? {
                    continue;
                }
                self.next()?;
            }
            // Set when the field's base type is an `enum` (directly or
            // through an enum typedef). An enum bitfield reads as
            // unsigned, so a value with the field's high bit set
            // zero-extends rather than sign-extends.
            let mut field_base_is_enum = false;
            let field_base_tok = self.lex.tk;
            let mut field_base = if let Some(inner) = atomic_field_base {
                inner
            } else if self.lex.tk == Token::Typeof {
                // `typeof ( ... ) member;` (C23 6.7.2.5): the operand's
                // type is the member's type.
                self.parse_typeof_specifier()?
            } else if self.lex.tk == Token::Int {
                self.next()?;
                mods.int_base()
            } else if self.lex.tk == Token::Char {
                self.next()?;
                mods.char_tag(self.target.plain_char_signed())
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
                // this to an error needs a separate declarator-
                // aware check; codegen handles either shape.
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
                let nested_packed = self.skip_attribute_specifiers()?;
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
                    let id =
                        self.parse_aggregate_body(&inner_name, nested_is_union, nested_packed)?;
                    if self.skip_attribute_specifiers()? {
                        self.repack_struct(id);
                    }
                    id
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
                // C99 6.7.2.2: an `enum X` field collapses to `int`; the
                // shared parse_enum_decl captures the tag + body for
                // DWARF. An enum bitfield reads unsigned, so
                // field_base_is_enum drives the zero-extend.
                self.parse_enum_decl()?;
                field_base_is_enum = true;
                Ty::Int as i64
            } else if !mods.saw_int_mod && self.is_lex_typedef_name() {
                // Guarded by `!saw_int_mod`: C99 6.7.2p2 forbids
                // combining a typedef-name with `unsigned`/`short`/
                // `long`/`signed`, so after an int-modifier the
                // following typedef-name is the field's declarator
                // identifier (a redeclared name), not a type-specifier.
                if self.symbols[self.lex.curr_id_idx].is_enum_typedef {
                    field_base_is_enum = true;
                }
                let aliased = self.symbols[self.lex.curr_id_idx].type_;
                // C99 6.7.7 paragraph 3: a typedef name carries
                // through any array dimension on its alias. Stash
                // the count so the field-binding code below can
                // make `jmp_buf b;` lay out `long b[64];`.
                let typedef_array = self.symbols[self.lex.curr_id_idx].array_size;
                if typedef_array > 0 {
                    self.pending.typedef_base_array_size = typedef_array;
                }
                // Carry the typedef's fn-pointer lineage forward
                // (mirrors `decl_base.rs` for the non-aggregate
                // path) so a `typedef RET (*fn_t)(args); struct {
                // fn_t cb; }` field records `fn_ptr_indirection =
                // 1`. Without it the StructField loses the tag and
                // `(*s.cb)(...)` looks like a regular pointer
                // deref rather than the C99 6.3.2.1p4 fn-pointer
                // decay no-op, so the call jumps to garbage.
                let typedef_fpi = self.symbols[self.lex.curr_id_idx].fn_ptr_indirection;
                if typedef_fpi > 0 {
                    self.pending.fn_ptr_indirection = Some(typedef_fpi);
                    self.pending.base_is_function_type =
                        self.symbols[self.lex.curr_id_idx].is_function_type;
                    // Carry the typedef's pointed-to prototype (parameter
                    // types + variadic flag) so `s.cb(args)` narrows each
                    // argument to its declared type and splits fixed vs
                    // variadic arguments per the host variadic ABI. Mirrors
                    // the non-aggregate path in `decl_base.rs`.
                    self.pending.typedef_fn_proto = Some((
                        self.symbols[self.lex.curr_id_idx].params.len(),
                        self.symbols[self.lex.curr_id_idx].is_variadic,
                    ));
                    self.pending.fn_ptr_param_types =
                        Some(self.symbols[self.lex.curr_id_idx].params.clone());
                }
                self.next()?;
                aliased
            } else if mods.saw_int_mod {
                mods.int_base()
            } else {
                return Err(self.compile_err("type expected in struct field"));
            };

            // Trailing specifiers: C99 6.7.2p2 admits any order, so
            // `int long` / `char unsigned` fields re-derive the base
            // tag from the folded modifiers.
            let (saw_int_mod, trailing_quals) = self.consume_trailing_decl_modifiers(&mut mods)?;
            if saw_int_mod {
                if field_base_tok == Token::Int {
                    field_base = mods.int_base();
                } else if field_base_tok == Token::Char {
                    field_base = mods.char_tag(self.target.plain_char_signed());
                }
            }
            field_base |= trailing_quals;

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
                    let pack = if packed { 1 } else { self.lex.current_pack() };
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
                        // Members of one anonymous union share a single
                        // positional initializer slot; tag them with the
                        // inner aggregate's id so the initializer groups
                        // them. Anonymous-struct members keep distinct
                        // positions, so they propagate any group tag they
                        // already carry (a union nested inside).
                        // An anonymous union groups its members so a brace
                        // selects one; an anonymous struct groups its members
                        // so a brace fills them all in order. Tag with the
                        // matching id and propagate any group the inner field
                        // already carries (a nested anonymous aggregate).
                        let (union_group, struct_group) = if self.structs[inner_id].is_union {
                            (inner_id as u32 + 1, inner_field.anon_struct_group)
                        } else {
                            (inner_field.anon_union_group, inner_id as u32 + 1)
                        };
                        saw_field = true;
                        self.structs[struct_id].fields.push(StructField {
                            name: inner_field.name,
                            offset: base_offset + inner_field.offset,
                            ty: inner_field.ty,
                            array_size: inner_field.array_size,
                            inner_array_size: inner_field.inner_array_size,
                            array_dims: inner_field.array_dims,
                            bit_offset: inner_field.bit_offset,
                            bit_width: inner_field.bit_width,
                            bit_unit_size: inner_field.bit_unit_size,
                            fn_ptr_indirection: inner_field.fn_ptr_indirection,
                            params: inner_field.params,
                            is_variadic: inner_field.is_variadic,
                            anon_union_group: union_group,
                            anon_struct_group: struct_group,
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
            //
            // A function-pointer typedef base (`fn_t a, b;`) seeds its
            // lineage once into `self.pending`; the per-declarator
            // `.take()` below would zero it for declarators after the
            // first. Capture and re-seed each iteration. Only the two
            // typedef-derived fields are restored; `fn_ptr_param_types`
            // is a per-declarator output of `parse_declarator`.
            let base_field_fn_ptr_indirection = self.pending.fn_ptr_indirection;
            let base_field_is_function_type = self.pending.base_is_function_type;
            // A function-pointer typedef base (`fn_t cb;`) seeds its
            // prototype (parameter types + variadic flag) once; a nested
            // base-type parse inside `parse_declarator` would clear it, and
            // the per-declarator `.take()` zeros it for declarators after
            // the first. Capture and re-seed each iteration so a typedef'd
            // fn-pointer field inherits the prototype the same way a local
            // does (an inline declarator prototype still overrides it).
            let base_field_typedef_fn_proto = self.pending.typedef_fn_proto;
            let base_field_fn_ptr_param_types = self.pending.fn_ptr_param_types.clone();
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
                    let unit = self.size_of_type(field_base).max(1);
                    if width == 0 {
                        // C99 6.7.2.1p11: a width-zero bitfield aligns
                        // the next field to the start of the next
                        // storage unit of the bitfield's base type.
                        if !is_union {
                            if !bf_active {
                                bf_bit_cursor = offset * 8;
                            }
                            bf_bit_cursor = round_up(bf_bit_cursor, unit * 8);
                            offset = offset.max(bf_bit_cursor / 8);
                        }
                        bf_active = false;
                    } else if !is_union {
                        place_bitfield(
                            &mut offset,
                            &mut bf_active,
                            &mut bf_bit_cursor,
                            unit,
                            width,
                        );
                        let a = unit.min(8);
                        if a > struct_align {
                            struct_align = a;
                        }
                    }
                    if self.lex.tk == ',' {
                        self.next()?;
                        continue;
                    }
                    break;
                }

                self.pending.fn_ptr_indirection = base_field_fn_ptr_indirection;
                self.pending.base_is_function_type = base_field_is_function_type;
                self.pending.typedef_fn_proto = base_field_typedef_fn_proto;
                self.pending.fn_ptr_param_types = base_field_fn_ptr_param_types.clone();
                let (id_idx, mut field_ty, mut field_array_size) =
                    self.parse_declarator(field_base)?;
                // A member may carry a trailing attribute
                // (`int x __attribute__((deprecated));`).
                self.skip_attribute_specifiers()?;
                // A typedef whose alias is an array contributes
                // its dimension when the declarator stayed at the
                // typedef's element type (`jmp_buf b;` ->
                // `long b[64];`). A declarator that added a
                // pointer level (`jmp_buf *p;`) names a pointer
                // to the element type; the array dimension is
                // part of the pointee and must not re-apply.
                // Peek the carrier without clearing so every
                // field in a comma list sees the dimension; the
                // carrier is reset when the next field's base
                // type is parsed.
                let typedef_dim = self.pending.typedef_base_array_size;
                if typedef_dim > 0 && field_array_size == 0 && !is_pointer_ty(field_ty) {
                    field_array_size = typedef_dim;
                }
                // Capture the fn-pointer lineage tag from the
                // declarator (set by the function-pointer branch
                // of `parse_declarator`) into the field record so
                // a later `s.cb(...)` / `(*s.cb)(...)` access can
                // recognise the C99 6.3.2.1p4 decay no-op. Always
                // consume the side-channel: leaking it across the
                // closing `}` would mistreat the typedef name in
                // `typedef struct { ... } T;` as a fn-pointer
                // alias.
                let field_fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
                // Capture the function-pointer field's parameter prototype
                // (set by the same declarator branch) so a later
                // `s.fp(args)` narrows its arguments. Always consume the
                // side-channel so it cannot leak to the next field.
                let field_params = self.pending.fn_ptr_param_types.take().unwrap_or_default();
                // A variadic function-pointer field carries the variadic
                // flag from the same prototype (the inline declarator or
                // the re-seeded typedef base) so `s.fp(args)` splits its
                // arguments at the fixed-parameter count. Consume the
                // side-channel so it cannot leak to the next field.
                let field_is_variadic = !field_params.is_empty()
                    && matches!(self.pending.typedef_fn_proto.take(), Some((_, true)));
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
                // Storage-unit width (bytes) the extraction reads for a
                // bitfield; the declared type's size. Zero for a
                // non-bitfield field.
                let mut bit_unit: usize = 0;
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
                    // C99 6.7.2.1: an enum bitfield reads as unsigned (a
                    // non-negative enum's underlying type is unsigned),
                    // so the extraction zero-extends. A full-width enum
                    // field keeps `int`; only the sub-word bitfield case
                    // changes.
                    if field_base_is_enum {
                        field_ty |= UNSIGNED_BIT;
                    }
                    if is_union {
                        // C99 6.7.2.1: a union bitfield occupies one
                        // storage unit of its declared type; size and
                        // align the union to it, as the non-bitfield path does.
                        field_offset = 0;
                        bit_offset = 0;
                        bit_unit = self.size_of_type(field_ty).max(1);
                        if bit_unit > offset {
                            offset = bit_unit;
                        }
                        let a = bit_unit.min(8);
                        if a > struct_align {
                            struct_align = a;
                        }
                    } else {
                        // C99 6.7.2.1p11 / p13: the bitfield's
                        // addressable storage unit is implementation
                        // defined. Place it at the running bit cursor,
                        // its addressable unit sized at the declared
                        // type; bump to the next such unit only when it
                        // would straddle one.
                        let unit = self.size_of_type(field_ty).max(1);
                        let (foff, boff) = place_bitfield(
                            &mut offset,
                            &mut bf_active,
                            &mut bf_bit_cursor,
                            unit,
                            bit_width,
                        );
                        field_offset = foff;
                        bit_offset = boff;
                        bit_unit = unit;
                        let a = unit.min(8);
                        if a > struct_align {
                            struct_align = a;
                        }
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
                    let pack = if packed { 1 } else { self.lex.current_pack() };
                    let elem_size = self.size_of_type(field_ty);
                    let field_storage = if field_array_size > 0 {
                        elem_size * field_array_size as usize
                    } else if field_array_size < 0 {
                        // Flexible array member (`T v[]`, C99
                        // 6.7.2.1p16): contributes no storage to the
                        // struct size (it may still raise the struct's
                        // alignment via `field_align` below).
                        0
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
                saw_field = true;
                self.structs[struct_id].fields.push(StructField {
                    name: field_name,
                    offset: field_offset,
                    ty: field_ty,
                    array_size: field_array_size,
                    inner_array_size: field_inner_array_size,
                    array_dims: field_array_dims,
                    bit_offset,
                    bit_width,
                    bit_unit_size: if bit_width > 0 { bit_unit as u8 } else { 0 },
                    fn_ptr_indirection: field_fn_ptr_indirection,
                    params: field_params,
                    is_variadic: field_is_variadic,
                    anon_union_group: 0,
                    anon_struct_group: 0,
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
        self.pending.typedef_base_array_size = saved_typedef_base_array_size;

        // Cap struct alignment at 8 -- the rest of the IR slots
        // 8-wide and never asks for stricter alignment, so going
        // above 8 buys nothing (and would force structurally
        // identical code to handle 16-byte SIMD-style aligns).
        // `#pragma pack(N)` further clamps the cap; field-level
        // clamping above already prevents struct_align from
        // exceeding pack, but cap here too so an empty struct
        // under `pack(1)` still ends up with align=1.
        // TODO: honor `_Alignas(N)` / `__attribute__((aligned(N)))`
        // for N > 8. The attribute specifiers are parsed and consumed
        // (`skip_attribute_specifiers`) but the requested alignment is
        // dropped here; supporting it requires over-aligned stack
        // slots and global placement, which the 8-wide slot model does
        // not yet represent.
        let struct_align =
            struct_align
                .min(8)
                .min(if packed { 1 } else { self.lex.current_pack() });
        // Pad the struct's tail up to its alignment so consecutive
        // elements of an array preserve every field's natural
        // alignment. Empty structs floor at 1 byte (so a `struct
        // *p` always has a meaningful sizeof for pointer
        // arithmetic, matching GCC's empty-struct extension);
        // every other struct's size is whatever the field cursor
        // ended up at, rounded to the struct's own alignment.
        let total = round_up(offset, struct_align);
        // A genuinely empty aggregate floors at 1 byte so `struct *p`
        // has a meaningful sizeof for pointer arithmetic (matching GCC's
        // empty-struct extension); an aggregate with a flexible-array
        // member legitimately has size 0 when nothing precedes it (gcc /
        // clang) and must not be floored.
        self.structs[struct_id].size = if saw_field { total } else { total.max(1) };
        self.structs[struct_id].align = struct_align;
        Ok(struct_id)
    }

    /// Re-lay a struct's fields with `__attribute__((packed))`
    /// semantics: no inter-member padding and an alignment of 1. Used
    /// when the attribute marker follows the body, after the fields were
    /// placed at their natural alignment. A union only loses its tail
    /// padding (members already sit at offset 0). Bitfields pack at the
    /// bit level with no storage-unit padding (the GCC/clang packed
    /// layout; C99 6.7.2.1p11 leaves the unit implementation-defined);
    /// a non-bitfield member starts at the next byte boundary.
    pub(super) fn repack_struct(&mut self, struct_id: usize) {
        self.structs[struct_id].align = 1;
        if self.structs[struct_id].is_union {
            return;
        }
        let n = self.structs[struct_id].fields.len();
        let mut bit_cursor = 0usize;
        let mut bitfields: Vec<(usize, usize)> = Vec::new();
        for i in 0..n {
            let (ty, array_size, bit_width) = {
                let f = &self.structs[struct_id].fields[i];
                (f.ty, f.array_size, f.bit_width)
            };
            if bit_width > 0 {
                // TODO: a field whose bits would span more than an
                // 8-byte load window (start % 8 + width > 64) is bumped
                // to the next byte; gcc packs it contiguously.
                if bit_cursor % 8 + bit_width as usize > 64 {
                    bit_cursor = round_up(bit_cursor, 8);
                }
                bitfields.push((i, bit_cursor));
                bit_cursor += bit_width as usize;
                continue;
            }
            let offset = bit_cursor.div_ceil(8);
            self.structs[struct_id].fields[i].offset = offset;
            let storage = if array_size > 0 {
                self.size_of_type(ty) * array_size as usize
            } else if array_size < 0 {
                0
            } else {
                self.size_of_type(ty)
            };
            bit_cursor = (offset + storage) * 8;
        }
        let size = bit_cursor.div_ceil(8).max(1);
        // Each bitfield's addressable unit is the smallest 1/2/4/8-byte
        // window covering its bits, slid back when it would extend past
        // the struct's tail (a packed struct has no tail padding to
        // absorb the read-modify-write span).
        for (i, bit_start) in bitfields {
            let width = self.structs[struct_id].fields[i].bit_width as usize;
            let unit = (bit_start % 8 + width).div_ceil(8).next_power_of_two();
            let mut off = bit_start / 8;
            if off + unit > size && unit <= size {
                off = size - unit;
            }
            let f = &mut self.structs[struct_id].fields[i];
            f.offset = off;
            f.bit_offset = (bit_start - off * 8) as u32;
            f.bit_unit_size = unit as u8;
        }
        self.structs[struct_id].size = size;
    }
}

/// Place a bitfield of declared-type size `unit` bytes and `width` bits
/// at the running `bit_cursor` (bit position from the aggregate start),
/// bumping it to the next `unit`-byte storage-unit boundary only when
/// the field would otherwise straddle one (the SysV AMD64 / AAPCS64
/// rule). Begins the run at `offset * 8` when not already `active`,
/// advances `offset` to the highest byte the run reaches, and returns
/// the field's `(byte offset of its addressable unit, bit offset within
/// that unit)`.
fn place_bitfield(
    offset: &mut usize,
    active: &mut bool,
    bit_cursor: &mut usize,
    unit: usize,
    width: u32,
) -> (usize, u32) {
    if !*active {
        *bit_cursor = *offset * 8;
        *active = true;
    }
    let unit_bits = unit * 8;
    if *bit_cursor % unit_bits + width as usize > unit_bits {
        *bit_cursor = round_up(*bit_cursor, unit_bits);
    }
    let field_offset = (*bit_cursor / unit_bits) * unit;
    let bit_offset = (*bit_cursor % unit_bits) as u32;
    *bit_cursor += width as usize;
    *offset = (*offset).max(bit_cursor.div_ceil(8));
    (field_offset, bit_offset)
}
