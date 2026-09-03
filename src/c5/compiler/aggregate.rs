//! Struct / union bodies.
//!
//! `parse_aggregate_base_type` dispatches here on `struct Tag { ... }` /
//! `union Tag { ... }` at a base-type position. The body parse consumes the
//! member list and lays it out: nothing outside this module reads the
//! layout state, so the bit-packing rules stay in one place.

use alloc::format;
use alloc::string::ToString;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::decl_base;
use super::types::{
    UNSIGNED_BIT, is_decl_modifier, is_pointer_ty, is_struct_value_ty, round_up, struct_id_of,
    struct_ty_for,
};
use super::{AnonBitfield, AnonMember, Compiler, StructDef, StructField};

/// The running layout of one aggregate body: the next offset, the alignment
/// maxima its members contribute, and the bit cursor of the current bitfield
/// run (C99 6.7.2.1).
struct AggregateLayout {
    offset: usize,
    /// Running max member alignment, which is the aggregate's own.
    align: usize,
    /// The part of it that alignment attributes contribute; the automatic-
    /// storage placement decision reads it off the StructDef.
    explicit: usize,
    /// The same max with every alignment attribute and packing request
    /// removed -- the floor a variable-level `aligned(N)` cannot go below.
    natural: usize,
    /// Inside a run of bitfields sharing a storage unit.
    bf_active: bool,
    /// Next free bit, measured from the start of the aggregate.
    bf_bit_cursor: usize,
}

impl Default for AggregateLayout {
    fn default() -> Self {
        Self {
            offset: 0,
            align: 1,
            explicit: 0,
            natural: 1,
            bf_active: false,
            bf_bit_cursor: 0,
        }
    }
}

/// The type prefix one member group shares, and the carriers a declarator
/// through it reads.
struct MemberBase {
    field_base: i64,
    field_base_is_enum: bool,
    anon_aggregate_inner_id: Option<usize>,
    group_align: usize,
    base_spelling: crate::c5::symbol::DeclSpelling,
    type_align_override: usize,
}

/// What the group's specifiers and this declarator's attributes fix about a
/// member's placement, before its own type is consulted.
struct MemberShape {
    is_union: bool,
    /// `__attribute__((packed))` on the aggregate or on the member.
    attr_packed: bool,
    /// Alignment the group's attribute asks for.
    group_align: usize,
    /// Alignment this declarator's own attribute asks for.
    decl_align: usize,
    /// Alignment a typedef base carries; it replaces the natural one.
    type_align_override: usize,
    base_is_enum: bool,
}

/// Where a member landed: its offset and placement alignment, and for a
/// bitfield the bit position and the storage unit its extraction reads
/// (C99 6.7.2.1p11). `ty` is the member's type, which an enum bitfield
/// takes unsigned.
struct MemberPlacement {
    ty: i64,
    offset: usize,
    align: usize,
    bit_offset: u32,
    bit_width: u32,
    bit_unit: usize,
}

impl Compiler {
    /// Parse a `struct Name { ... }` / `union Name { ... }` body and lay it
    /// out. A member is placed at its own alignment, or at the `aligned(N)` /
    /// `_Alignas(N)` one it asks for; the aggregate takes the maximum. A
    /// union places every member at offset 0 and takes the maximum size.
    ///
    /// On entry `tk` is `{`; on exit it is the token after the closing `}`.
    pub(super) fn parse_aggregate_body(
        &mut self,
        name: &str,
        is_union: bool,
        packed: bool,
    ) -> Result<usize, C5Error> {
        // An alignment request preceding the tag
        // (`__declspec(align(16)) struct S { ... }`) belongs to the
        // declaration, not to the first member; park it across the
        // body parse so the member checks see only member attributes.
        let decl_attr_align = core::mem::take(&mut self.pending.attr_align);
        let decl_attr_alignas = core::mem::take(&mut self.pending.attr_alignas);
        let r = self.parse_aggregate_body_inner(name, is_union, packed);
        self.pending.attr_align = self.pending.attr_align.max(decl_attr_align);
        self.pending.attr_alignas = self.pending.attr_alignas.max(decl_attr_alignas);
        r
    }

    /// Consume a pending `__attribute__((aligned(N)))` / `_Alignas(N)`
    /// carried by a member and validate it. Struct layout honors any
    /// power-of-two alignment up to `MAX_STATIC_ALIGN`, which is what the
    /// data section and static-object placement can realise; an automatic
    /// object of such a type is diagnosed at its declaration instead.
    fn take_member_align(&mut self) -> Result<i64, C5Error> {
        let m_align = core::mem::take(&mut self.pending.attr_align);
        self.pending.attr_alignas = 0;
        if m_align > 0 && !(m_align as usize).is_power_of_two() {
            return Err(
                self.compile_err(format!("member alignment {m_align} is not a power of two"))
            );
        }
        if m_align > super::MAX_STATIC_ALIGN as i64 {
            return Err(self.compile_err(format!(
                "member alignment {m_align} is not supported (at most {})",
                super::MAX_STATIC_ALIGN
            )));
        }
        Ok(m_align)
    }

    fn parse_aggregate_body_inner(
        &mut self,
        name: &str,
        is_union: bool,
        packed: bool,
    ) -> Result<usize, C5Error> {
        let struct_id = self.register_aggregate_tag(name, is_union)?;
        self.next()?; // consume `{`

        // Save the outer typedef-array carrier so a `typedef struct { fe X;
        // ... } ge;` body ending in an array-typedef field does not leak that
        // dimension into the outer declarator binding of `ge`.
        let saved_typedef_base_array_size = self.pending.typedef_base_array_size;
        let saved_typedef_base_zero_len = self.pending.typedef_base_zero_len;
        self.pending.typedef_base_array_size = 0;
        self.pending.typedef_base_zero_len = false;
        let saved_typedef_base_array_dims =
            core::mem::take(&mut self.pending.typedef_base_array_dims);
        let mut layout = AggregateLayout::default();

        while self.lex.tk != '}' {
            // C11 6.7.2.1: a static_assert-declaration may appear in the
            // struct-declaration-list. It declares no member, so handle
            // it before the field-type parse and continue.
            if self.lex.tk == Token::StaticAssert {
                self.parse_static_assert()?;
                continue;
            }
            // An empty struct-declaration (a stray `;`) declares no
            // member. gcc and clang accept it in a member list as an
            // extension, diagnosed only under `-pedantic`.
            if self.lex.tk == ';' {
                self.next()?;
                continue;
            }
            let base = self.parse_member_base_type(name)?;
            if let Some(inner_id) = base.anon_aggregate_inner_id
                && self.lex.tk == ';'
            {
                self.promote_unnamed_member(struct_id, inner_id, is_union, packed, &mut layout)?;
                self.next()?; // consume `;`
                continue;
            }

            self.parse_member_declarators(struct_id, &base, is_union, packed, &mut layout)?;

            if self.lex.tk != ';' {
                return Err(self.compile_err("semicolon expected after struct field"));
            }
            self.next()?;
        }
        self.next()?; // consume `}`
        self.pending.typedef_base_array_size = saved_typedef_base_array_size;
        self.pending.typedef_base_zero_len = saved_typedef_base_zero_len;
        self.pending.typedef_base_array_dims = saved_typedef_base_array_dims;
        self.finish_aggregate_layout(struct_id, &layout, packed);
        Ok(struct_id)
    }

    /// The comma-separated declarators sharing one type prefix. Each is
    /// routed through `parse_declarator`, so a function-pointer member
    /// (`int (*cmp)(int, int);`) and an array member (`int counts[8];`) parse
    /// under the same rules as a local or a global.
    fn parse_member_declarators(
        &mut self,
        struct_id: usize,
        base: &MemberBase,
        is_union: bool,
        packed: bool,
        layout: &mut AggregateLayout,
    ) -> Result<(), C5Error> {
        let &MemberBase {
            field_base,
            field_base_is_enum,
            group_align,
            base_spelling,
            type_align_override,
            ..
        } = base;
        // A function-pointer typedef base (`fn_t a, b;`) seeds its lineage
        // into `self.pending` once, and the per-declarator `.take()` below
        // would leave the later declarators without it; capture it here and
        // re-seed each iteration.
        let base_field_fn_ptr_indirection = self.pending.fn_ptr_indirection;
        let base_field_fn_ptr_ret_indirection = self.pending.fn_ptr_ret_indirection;
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
                    return Err(
                        self.compile_err(format!("bitfield width must be non-negative (got {n})"))
                    );
                }
                Some(n as u32)
            } else {
                None
            };

            if let Some(width) = anon_bitfield_width {
                self.place_anonymous_bitfield(
                    struct_id, field_base, width, is_union, packed, layout,
                );
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }

            self.pending.fn_ptr_indirection = base_field_fn_ptr_indirection;
            self.pending.fn_ptr_ret_indirection = base_field_fn_ptr_ret_indirection;
            self.pending.base_is_function_type = base_field_is_function_type;
            self.pending.typedef_fn_proto = base_field_typedef_fn_proto;
            self.pending.fn_ptr_param_types = base_field_fn_ptr_param_types.clone();
            // Confine `packed` to this declarator: a member-level
            // `__attribute__((packed))` (trailing the declarator, so
            // consumed inside `parse_declarator` or just below) sets
            // `pending.attr_packed`; a base-type or type-level packed
            // must not carry over to the field's own placement.
            self.pending.attr_packed = false;
            let saved_member_ctx = self.pending.in_member_declarator;
            self.pending.in_member_declarator = true;
            self.pending.member_decl_save = None;
            let declared = self.parse_declarator(field_base);
            self.pending.in_member_declarator = saved_member_ctx;
            let (id_idx, mut field_ty, mut field_array_size) = declared?;
            let mut field_zero_len = self.pending.declarator_zero_len_array;
            // A member may carry a trailing attribute
            // (`int x __attribute__((aligned(16)));`,
            // `int x __attribute__((deprecated));`). Member-level
            // `packed` clamps this field's alignment to 1 (GCC: it
            // both removes the field's leading padding and keeps it
            // from raising the aggregate's alignment), independent of
            // a struct-level `packed`.
            self.skip_attribute_specifiers()?;
            self.pending.attr_transparent_union = false;
            if let Some(m) = self.pending.attr_mode.take() {
                field_ty = self.apply_mode_to_type(field_ty, m)?;
            }
            let field_packed = core::mem::take(&mut self.pending.attr_packed);
            let m_align = self.take_member_align()?;
            // Alignment for this declarator only (a comma-list peer
            // without its own attribute keeps the group alignment).
            let decl_align = if m_align > 0 { m_align as usize } else { 0 };
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
            // A declarator-added dimension over an element whose
            // typedef-carried alignment exceeds its size cannot tile
            // (gcc rejects the same way).
            self.check_array_elem_align(
                field_array_size,
                field_ty,
                typedef_dim,
                type_align_override as i64,
            )?;
            // `!= 0` rather than `> 0`: the `-1` count covers both the
            // zero-length (`typedef T A[0]`) and deferred
            // (`typedef T A[]`) aliases, and a member of either
            // occupies no storage while still placing at the element
            // type's alignment.
            if typedef_dim != 0
                && field_array_size == 0
                && self.pending.declarator_leading_ptr_count == 0
            {
                field_array_size = typedef_dim;
                field_zero_len = typedef_dim < 0 && self.pending.typedef_base_zero_len;
                if id_idx != usize::MAX {
                    self.apply_typedef_array_dims(id_idx);
                }
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
            let field_fn_ptr_ret_indirection =
                core::mem::take(&mut self.pending.fn_ptr_ret_indirection);
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
            // A function-pointer member's `ms_abi` / `sysv_abi`
            // (`efi_status_t (__efiapi *exit)(...)`, or the typedef
            // form `efi_get_time_t __efiapi *get_time`). Consumed
            // here so it cannot leak to the next member.
            let field_conv = core::mem::take(&mut self.pending.attr_call_conv);
            let is_aggregate_value = is_struct_value_ty(field_ty);
            // C99 6.7.2.1: a member must have complete type, and an
            // array of an incomplete type is itself incomplete. Only a
            // forward-declared tag is incomplete; size cannot stand in
            // for that, since a complete empty `struct {}` and a struct
            // whose only member is a flexible array both have size 0.
            if is_aggregate_value && !self.structs[struct_id_of(field_ty)].is_complete {
                return Err(self.compile_err("aggregate-value field of incomplete type"));
            }
            let field_name = self.symbols[id_idx].name.clone();

            let shape = MemberShape {
                is_union,
                attr_packed: packed || field_packed,
                group_align,
                decl_align,
                type_align_override,
                base_is_enum: field_base_is_enum,
            };
            let placement = self.place_member_field(
                field_ty,
                field_array_size,
                is_aggregate_value,
                &shape,
                layout,
            )?;
            field_ty = placement.ty;
            let field_offset = placement.offset;
            let placed_align = placement.align;
            let bit_offset = placement.bit_offset;
            let bit_width = placement.bit_width;
            let bit_unit = placement.bit_unit;

            let field_inner_array_size = self.symbols[id_idx].inner_array_size;
            let field_array_dims = core::mem::take(&mut self.symbols[id_idx].array_dims);
            // The member's shape is now in the field record; hand the
            // ordinary-namespace symbol back to whatever declared it.
            if let Some((idx, saved)) = self.pending.member_decl_save.take() {
                self.symbols[idx] = *saved;
            }
            let field_spelling = self.decl_spelling(base_spelling);
            self.structs[struct_id].fields.push(StructField {
                name: field_name,
                offset: field_offset,
                ty: field_ty,
                array_size: field_array_size,
                inner_array_size: field_inner_array_size,
                array_dims: field_array_dims,
                zero_len: field_zero_len,
                bit_offset,
                bit_width,
                bit_unit_size: if bit_width > 0 { bit_unit as u8 } else { 0 },
                fn_ptr_indirection: field_fn_ptr_indirection,
                fn_ptr_ret_indirection: field_fn_ptr_ret_indirection,
                params: field_params,
                is_variadic: field_is_variadic,
                conv: field_conv,
                anon_union_group: 0,
                anon_struct_group: 0,
                explicit_align: group_align.max(decl_align) as u32,
                align: placed_align as u32,
                decl_spelling: field_spelling,
            });

            if self.lex.tk == ',' {
                self.next()?;
                continue;
            }
            break;
        }
        Ok(())
    }

    /// An anonymous bitfield (`int :N;`) reserves bits without naming a
    /// member. A zero width aligns the next member to the start of the next
    /// storage unit of the declared type (C99 6.7.2.1p11).
    fn place_anonymous_bitfield(
        &mut self,
        struct_id: usize,
        field_base: i64,
        width: u32,
        is_union: bool,
        packed: bool,
        layout: &mut AggregateLayout,
    ) {
        let unit = self.size_of_type(field_base).max(1);
        // Recorded so the post-body `packed` re-lay reproduces
        // the same placement: the member has no name, so
        // `fields` cannot carry it.
        let before = self.structs[struct_id].fields.len() as u32;
        self.structs[struct_id].anon_bitfields.push(AnonBitfield {
            before,
            width,
            unit: unit.min(u8::MAX as usize) as u8,
        });
        if width == 0 {
            // C99 6.7.2.1p11: a width-zero bitfield aligns
            // the next field to the start of the next
            // storage unit of the bitfield's base type.
            if !is_union {
                if !layout.bf_active {
                    layout.bf_bit_cursor = layout.offset * 8;
                }
                layout.bf_bit_cursor = round_up(layout.bf_bit_cursor, unit * 8);
                layout.offset = layout.offset.max(layout.bf_bit_cursor / 8);
            }
            layout.bf_active = false;
        } else if is_union {
            // A union member occupies its own storage from
            // offset 0; the bits round up to whole bytes.
            layout.offset = layout.offset.max((width as usize).div_ceil(8));
        } else {
            place_bitfield(
                &mut layout.offset,
                &mut layout.bf_active,
                &mut layout.bf_bit_cursor,
                unit,
                width,
            );
        }
        // Whether an unnamed bit-field's declared type raises
        // the aggregate's alignment is target-defined. Where
        // it does, a non-zero width is still clamped by
        // `packed` / `#pragma pack`, while the width-zero form
        // keeps its boundary regardless.
        if self.target.align_anon_bitfield() {
            let cap = if width == 0 {
                16
            } else if packed {
                1
            } else {
                self.lex.current_pack()
            };
            layout.align = layout.align.max(unit.min(16).min(cap));
        }
    }

    /// Place one member: a bitfield at the running bit cursor, any other at
    /// its own alignment. Both advance the layout.
    fn place_member_field(
        &mut self,
        field_ty: i64,
        field_array_size: i64,
        is_aggregate_value: bool,
        shape: &MemberShape,
        layout: &mut AggregateLayout,
    ) -> Result<MemberPlacement, C5Error> {
        let &MemberShape {
            is_union,
            attr_packed,
            group_align,
            decl_align,
            type_align_override,
            base_is_enum,
        } = shape;
        let mut field_ty = field_ty;
        let mut bit_width: u32 = 0;
        let mut bit_offset: u32 = 0;
        let mut bit_unit: usize = 0;
        let mut placed_align: usize = 0;
        let field_offset: usize;
        // Bitfield? `int x:N` shapes the field as N bits
        // packed into a shared 8-byte storage unit. The
        // bit-packing state above tracks whether we're
        // inside an active run.
        // Storage-unit width (bytes) the extraction reads for a
        // bitfield; the declared type's size. Zero for a
        // non-bitfield field.
        // Placement alignment of a non-bitfield member, recorded on
        // the field so `__alignof__` on a member lvalue reports it.
        if self.lex.tk == ':' {
            if field_array_size != 0 {
                return Err(self.compile_err("array fields cannot also be bitfields"));
            }
            // The 128-bit integer shares the aggregate machinery
            // but is a scalar type, so it takes a bitfield like
            // any other integer type.
            if is_aggregate_value && !self.is_int128_ty(field_ty) {
                return Err(self.compile_err("aggregate fields cannot also be bitfields"));
            }
            self.next()?;
            let n = self.parse_constant_int()?;
            if n <= 0 {
                return Err(self.compile_err(format!("bitfield width must be positive (got {n})")));
            }
            // C99 6.7.2.1p3: the width shall not exceed the width
            // of an object of the declared type.
            let type_bits = (self.size_of_type(field_ty).max(1) * 8) as i64;
            if n > type_bits {
                return Err(self.compile_err(format!(
                    "bitfield width {n} exceeds the {type_bits}-bit declared type"
                )));
            }
            bit_width = n as u32;
            // C99 6.7.2.1: an enum bitfield reads as unsigned (a
            // non-negative enum's underlying type is unsigned),
            // so the extraction zero-extends. A full-width enum
            // field keeps `int`; only the sub-word bitfield case
            // changes.
            if base_is_enum {
                field_ty |= UNSIGNED_BIT;
            }
            if is_union {
                // C99 6.7.2.1: a union bitfield occupies one
                // storage unit of its declared type; size and
                // align the union to it, as the non-bitfield path does.
                field_offset = 0;
                bit_offset = 0;
                bit_unit = self.size_of_type(field_ty).max(1);
                if bit_unit > layout.offset {
                    layout.offset = bit_unit;
                }
                let a = bit_unit.min(16);
                if a > layout.align {
                    layout.align = a;
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
                    &mut layout.offset,
                    &mut layout.bf_active,
                    &mut layout.bf_bit_cursor,
                    unit,
                    bit_width,
                );
                field_offset = foff;
                bit_offset = boff;
                bit_unit = unit;
                let a = unit.min(16);
                if a > layout.align {
                    layout.align = a;
                }
            }
        } else {
            // Regular (non-bitfield) field. Seal any pending
            // bitfield run so the next byte is correctly
            // aligned for a new field.
            layout.bf_active = false;

            // `__attribute__((packed))` and `#pragma pack(N)` clamp different
            // things, as they do under GCC and clang: the attribute drops a
            // member's natural alignment to 1 and leaves an explicit
            // `aligned(N)` on that member standing, while the pragma clamps
            // the finished value, explicit request included.
            let pack = self.lex.current_pack();
            let elem_size = self.size_of_type(field_ty);
            // A complete but empty `struct {}` member contributes no
            // storage (GCC), so the following member shares its
            // offset -- which is what the `__DECLARE_FLEX_ARRAY`
            // idiom (`struct {} __empty; T arr[];`) relies on. Its
            // alignment still applies: an empty type carrying
            // `aligned(N)` places the member, and raises the
            // containing type, at N.
            let is_empty_aggregate = is_struct_value_ty(field_ty)
                && self.structs[struct_id_of(field_ty)].fields.is_empty();
            let field_storage = if is_empty_aggregate {
                0
            } else if field_array_size > 0 {
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
            // `aligned(N)` raises the field above its natural
            // alignment; `#pragma pack(N)` then lowers the result,
            // explicit attribute included (GCC and clang both give
            // alignment 1 for an `aligned(64)` member under
            // `pack(1)`). A pack request above 16 packs nothing.
            // A typedef's explicit type alignment replaces the
            // field's natural alignment (it may lower it), except
            // through a pointer declarator or under `packed`,
            // which drops a type attribute to 1 (a member
            // `_Alignas` survives packing via `decl_align`).
            let natural_align = if attr_packed {
                1
            } else if type_align_override > 0 && !is_pointer_ty(field_ty) {
                type_align_override
            } else {
                self.align_of_type(field_ty)
            };
            let field_align = natural_align.max(group_align).max(decl_align).min(pack);
            placed_align = field_align;
            if field_align > layout.align {
                layout.align = field_align;
            }
            layout.natural = layout.natural.max(self.unattributed_align_of(field_ty));
            // The field's explicit alignment sources; a nested
            // aggregate contributes its own attribute-derived part.
            let mut fe = group_align.max(decl_align);
            if type_align_override > 0 && !is_pointer_ty(field_ty) && !attr_packed {
                fe = fe.max(type_align_override);
            }
            if is_struct_value_ty(field_ty) {
                fe = fe.max(self.structs[struct_id_of(field_ty)].explicit_align as usize);
            }
            layout.explicit = layout.explicit.max(fe.min(pack).min(field_align.max(1)));
            field_offset = if is_union {
                0
            } else {
                layout.offset = round_up(layout.offset, field_align);
                let off = layout.offset;
                layout.offset += field_storage;
                off
            };
            if is_union && field_storage > layout.offset {
                layout.offset = field_storage;
            }
        }
        Ok(MemberPlacement {
            ty: field_ty,
            offset: field_offset,
            align: placed_align,
            bit_offset,
            bit_width,
            bit_unit,
        })
    }

    /// Pre-register the tag, or recycle a forward declaration of it, so a
    /// self-referential pointer member finds the aggregate mid-definition.
    /// C99 6.2.1: only a tag in the same scope makes this a redefinition; one
    /// in an outer scope is shadowed by the declaration here.
    fn register_aggregate_tag(&mut self, name: &str, is_union: bool) -> Result<usize, C5Error> {
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
                    explicit_align: 0,
                    natural_align: 0,
                    fields: Vec::new(),
                    anon_bitfields: Vec::new(),
                    anon_members: Vec::new(),
                    is_union,
                    is_complete: false,
                    is_vector: false,
                    is_array: false,
                    is_anonymous: false,
                    is_transparent_union: false,
                    cast_named: false,
                });
                let id = self.structs.len() - 1;
                if let Some(scope) = self.tag_scopes.last_mut() {
                    scope.push((name.to_string(), id));
                }
                id
            }
        };
        Ok(struct_id)
    }

    /// The type prefix of one member group: the specifiers, the type they
    /// name, and the carriers a declarator through it reads (C99 6.7.2.1).
    fn parse_member_base_type(&mut self, name: &str) -> Result<MemberBase, C5Error> {
        // Reset the typedef-array carrier between field groups
        // (`jmp_buf env;` then `int code;`). The aggregate
        // parser has its own inline base-type reader and does
        // not call `parse_decl_base_type`, so the carrier
        // would otherwise leak its prior value into the next
        // group and turn an unrelated scalar field into a
        // bogus array.
        self.pending.typedef_base_array_size = 0;
        self.pending.typedef_base_zero_len = false;
        self.pending.type_align = 0;
        // Same for the debug-info spelling carriers, which the
        // inline reader below seeds itself.
        let _ = self.take_base_spelling();
        // Field type prefix: int, char, float, double, or struct Name.
        // Leading qualifiers / int modifiers / function specifiers
        // (`const`, `unsigned`, ...) are no-ops; track if any int
        // modifier appeared so a bare `unsigned x;` field still
        // produces an `int` field.
        let mut mods = decl_base::IntModifiers::default();
        // Set when the field-type prefix is a `struct` / `union`
        // whose members should promote into the enclosing struct
        // when no declarator follows: C11 6.7.2.1p13 for a no-tag
        // `struct { ... }`, and the unnamed-field extension gcc
        // spells `-fms-extensions` for a tagged one. Checked AFTER
        // the type-prefix parse: if there's no declarator (`;`
        // next), the promotion path runs; otherwise the tag stays a
        // regular nested-aggregate field type.
        let mut anon_aggregate_inner_id: Option<usize> = None;
        let mut atomic_field_base: Option<i64> = None;
        // `__attribute__((aligned(N)))` before the declarator raises the
        // alignment of every field in the group; a per-declarator one
        // (below) adds to it. Applied at field placement, not dropped.
        let mut group_align: usize = 0;
        // Qualifiers ahead of the type (`volatile int x;`). C99
        // 6.7.2p2 admits them in any order, and the trailing form
        // already folds in below, so collect the leading one too.
        let mut leading_quals: i64 = 0;
        while is_decl_modifier(self.lex.tk) {
            if self.lex.tk == Token::Attribute {
                self.skip_attribute_specifiers()?;
                let m_align = self.take_member_align()?;
                if m_align > 0 {
                    group_align = group_align.max(m_align as usize);
                }
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
            leading_quals |= self.lex_qualifier_bits();
            self.pending.spell_base_const |= self.lex_is_const_qual();
            self.pending.spell_base_restrict |= self.lex_is_restrict_qual();
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
            mods.char_tag(self.lex.char_signed)
        } else if self.lex.tk == Token::Void {
            self.next()?;
            // `void *p;` / `void (*fp)(...);` fields. Bare
            // `void m;` is a constraint violation (incomplete
            // type) c5 doesn't reject here; such a field just
            // allocates 1 byte, per the representation.
            super::types::void_ty()
        } else if self.lex.tk == Token::Float {
            self.next()?;
            Ty::Float as i64
        } else if self.lex.tk == Token::Double {
            self.next()?;
            if mods.saw_long() {
                Ty::Double as i64 | super::types::LONG_DOUBLE_BIT
            } else {
                Ty::Double as i64
            }
        } else if self.lex.tk == Token::Struct || self.lex.tk == Token::Union {
            let (ty, inner_id) = self.parse_nested_aggregate_member(name)?;
            anon_aggregate_inner_id = Some(inner_id);
            ty
        } else if self.lex.tk == Token::Enum {
            // C99 6.7.2.2: an `enum X` field is `int`, or the packed
            // underlying type for `enum __attribute__((packed))`; the
            // shared parse_enum_decl captures the tag + body for DWARF.
            // An enum bitfield reads unsigned, so field_base_is_enum
            // drives the zero-extend.
            let enum_field_ty = self.parse_enum_decl()?;
            field_base_is_enum = true;
            enum_field_ty
        } else if self.is_lex_int128_spelling() {
            // GCC `__int128` / `__uint128_t` field: a 16-byte type.
            // Needed for kernel-UAPI structs (`asm/sigcontext.h`).
            let tag = self.lex_int128_tag(mods.saw_unsigned);
            self.next()?;
            tag
        } else if self.is_lex_va_list_spelling() {
            // GCC `__builtin_va_list` field: the target's `va_list`
            // representation.
            self.next()?;
            self.builtin_va_list_tag()
        } else if !mods.saw_int_mod && self.is_lex_typedef_name() {
            // C99 6.7.2p2 forbids combining a typedef-name with `unsigned` /
            // `short` / `long` / `signed`, so after an int modifier the
            // identifier is the member's declarator name, not a type specifier.
            let (aliased, is_enum) = self.typedef_name_member_type()?;
            field_base_is_enum = is_enum;
            aliased
        } else if mods.saw_int_mod {
            mods.int_base()
        } else {
            return Err(self.compile_err("type expected in struct field"));
        };

        // Trailing specifiers: C99 6.7.2p2 admits any order, so
        // `int long` / `char unsigned` fields re-derive the base
        // tag from the folded modifiers.
        let (saw_int_mod, trailing_quals) =
            self.consume_trailing_decl_modifiers(&mut mods, None)?;
        if saw_int_mod {
            if field_base_tok == Token::Int {
                field_base = mods.int_base();
            } else if field_base_tok == Token::Char {
                field_base = mods.char_tag(self.lex.char_signed);
            } else if field_base_tok == Token::Double && mods.saw_long() {
                // `double long m;` -- the trailing-modifier spelling.
                field_base |= super::types::LONG_DOUBLE_BIT;
            }
        }
        field_base = super::types::apply_qual_bits(field_base, leading_quals | trailing_quals);
        let base_spelling = self.take_base_spelling();

        // Explicit type alignment carried by a typedef base (GNU
        // `aligned(N)`), consumed once for every declarator sharing
        // this base. Replaces the field's natural alignment below,
        // so a reducing attribute lowers it; a pointer declarator
        // through the typedef keeps pointer alignment instead.
        let type_align_override = core::mem::take(&mut self.pending.type_align) as usize;

        Ok(MemberBase {
            field_base,
            field_base_is_enum,
            anon_aggregate_inner_id,
            group_align,
            base_spelling,
            type_align_override,
        })
    }

    /// A nested `struct` / `union` member type. Three shapes reach here:
    /// a definition, a tag use, and an untagged body, which registers under
    /// a synthetic tag naming the outer aggregate. Returns the type and the
    /// registered id, which the caller keeps as the promotion candidate a
    /// declarator-less member becomes (C11 6.7.2.1p13).
    fn parse_nested_aggregate_member(&mut self, name: &str) -> Result<(i64, usize), C5Error> {
        let nested_is_union = self.lex.tk == Token::Union;
        self.next()?;
        let nested_packed = self.skip_attribute_specifiers()?;
        // Three shapes: `struct Foo { ... }` (named definition),
        // `struct Foo` (type use), and `struct { ... }` (no tag,
        // registered under a synthesised unique tag). Any of them
        // with no declarator -- next token `;` -- is an unnamed
        // member whose fields promote into the enclosing
        // aggregate.
        let mut inner_anonymous = false;
        let inner_name = if self.lex.tk == Token::Id {
            let name = self.symbols[self.lex.curr_id_idx].name.clone();
            self.next()?;
            name
        } else if self.lex.tk == '{' {
            let kind = if nested_is_union {
                "anon_union"
            } else {
                "anon_struct"
            };
            inner_anonymous = true;
            format!("__{kind}_{}_in_{}", self.structs.len(), name)
        } else {
            return Err(self.compile_err("aggregate name or `{{` expected in field type"));
        };
        let inner_id = if self.lex.tk == '{' {
            let id = self.parse_aggregate_body(&inner_name, nested_is_union, nested_packed)?;
            self.structs[id].is_anonymous = inner_anonymous;
            self.apply_post_body_attributes(id)?;
            id
        } else {
            self.find_or_forward_declare_struct(&inner_name, nested_is_union)
        };
        Ok((struct_ty_for(inner_id), inner_id))
    }

    /// A typedef-name member type: the aliased type, plus the carriers a
    /// member declared through the alias reads -- its array dimension (C99
    /// 6.7.7p3), its type alignment, and a function-pointer alias's calling
    /// convention and prototype.
    fn typedef_name_member_type(&mut self) -> Result<(i64, bool), C5Error> {
        let is_enum = self.symbols[self.lex.curr_id_idx].is_enum_typedef;
        let aliased = self.symbols[self.lex.curr_id_idx].type_;
        self.pending.spell_base_typedef = Some(self.lex.curr_id_idx as u32);
        // C99 6.7.7 paragraph 3: a typedef name carries
        // through any array dimension on its alias. Stash
        // the count so the field-binding code below can
        // make `jmp_buf b;` lay out `long b[64];`.
        let typedef_array = self.symbols[self.lex.curr_id_idx].array_size;
        if typedef_array != 0 {
            self.pending.typedef_base_array_size = typedef_array;
            self.pending.typedef_base_array_dims =
                self.symbols[self.lex.curr_id_idx].array_dims.clone();
            self.pending.typedef_base_zero_len =
                self.symbols[self.lex.curr_id_idx].is_zero_len_array;
        }
        // Carry the typedef's explicit type alignment so a field
        // declared with it lays out on the requested boundary
        // (below its natural value for a reducing `aligned(N)`).
        let typedef_align = self.symbols[self.lex.curr_id_idx].type_align;
        if typedef_align > 0 {
            self.pending.type_align = typedef_align;
        }
        // A function / function-pointer typedef carries the
        // pointed-to function's calling convention; a declarator
        // through the alias inherits it unless the declaration names
        // one of its own.
        if self.symbols[self.lex.curr_id_idx].conv != crate::c5::codegen::CallConv::Target
            && self.pending.attr_call_conv == crate::c5::codegen::CallConv::Target
        {
            self.pending.attr_call_conv = self.symbols[self.lex.curr_id_idx].conv;
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
            self.pending.fn_ptr_ret_indirection =
                self.symbols[self.lex.curr_id_idx].fn_ptr_ret_indirection;
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
        Ok((aliased, is_enum))
    }

    /// An unnamed member (a struct / union type prefix with no declarator):
    /// its fields promote into the enclosing aggregate's namespace, rebased
    /// onto the member's offset, so `li.LowPart` names them. Untagged is
    /// C11 6.7.2.1p13; tagged is the unnamed-field extension gcc spells
    /// `-fms-extensions`, which requires a complete type.
    fn promote_unnamed_member(
        &mut self,
        struct_id: usize,
        inner_id: usize,
        is_union: bool,
        packed: bool,
        layout: &mut AggregateLayout,
    ) -> Result<(), C5Error> {
        if !self.structs[inner_id].is_complete {
            return Err(self.compile_err("unnamed field has incomplete type"));
        }
        // Seal any pending bitfield run -- the
        // anonymous aggregate is a regular field
        // from the cursor's perspective.
        layout.bf_active = false;

        let inner_size = self.structs[inner_id].size;
        let pack = if packed { 1 } else { self.lex.current_pack() };
        let inner_align = self.structs[inner_id].align.min(pack);
        if inner_align > layout.align {
            layout.align = inner_align;
        }
        layout.explicit = layout
            .explicit
            .max((self.structs[inner_id].explicit_align as usize).min(inner_align.max(1)));
        layout.natural = layout.natural.max(self.structs[inner_id].natural_align);
        let base_offset = if is_union {
            0
        } else {
            layout.offset = round_up(layout.offset, inner_align);
            let off = layout.offset;
            layout.offset += inner_size;
            off
        };
        if is_union && inner_size > layout.offset {
            layout.offset = inner_size;
        }

        // Copy each inner field into the outer
        // struct's field list, rebased onto
        // `base_offset`. Cloning here (rather than
        // taking by reference) sidesteps the borrow
        // conflict between reading `self.structs[inner_id]`
        // and mutating `self.structs[struct_id]`.
        let inner_fields = self.structs[inner_id].fields.clone();
        // The promoted entries are one member for layout.
        let first = self.structs[struct_id].fields.len() as u32;
        self.structs[struct_id].anon_members.push(AnonMember {
            first,
            count: inner_fields.len() as u32,
            offset: base_offset,
            size: inner_size,
            inner: inner_id,
        });
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
            self.structs[struct_id].fields.push(StructField {
                name: inner_field.name,
                offset: base_offset + inner_field.offset,
                ty: inner_field.ty,
                array_size: inner_field.array_size,
                inner_array_size: inner_field.inner_array_size,
                array_dims: inner_field.array_dims,
                zero_len: inner_field.zero_len,
                bit_offset: inner_field.bit_offset,
                bit_width: inner_field.bit_width,
                bit_unit_size: inner_field.bit_unit_size,
                fn_ptr_indirection: inner_field.fn_ptr_indirection,
                fn_ptr_ret_indirection: inner_field.fn_ptr_ret_indirection,
                params: inner_field.params,
                is_variadic: inner_field.is_variadic,
                conv: inner_field.conv,
                anon_union_group: union_group,
                anon_struct_group: struct_group,
                explicit_align: inner_field.explicit_align,
                align: inner_field.align,
                decl_spelling: inner_field.decl_spelling,
            });
        }

        Ok(())
    }

    /// Close the body: cap the aggregate's alignment at what static
    /// placement honors, pad its tail to that alignment, and record the
    /// finished layout on the StructDef.
    fn finish_aggregate_layout(
        &mut self,
        struct_id: usize,
        layout: &AggregateLayout,
        packed: bool,
    ) {
        // Struct alignment tops out at `MAX_STATIC_ALIGN` -- the widest the
        // data section and static-object placement honor. `#pragma pack(N)`
        // further clamps the cap; field-level clamping above already prevents
        // the member alignment from exceeding pack, but cap here too so an empty
        // struct under `pack(1)` still ends up with align=1.
        // NOTE: an automatic (stack) object of an over-aligned type is
        // rejected at its declaration -- the frame uses 8-byte slots and
        // does not realign. Struct layout, static locals and globals honor
        // the full range.
        let struct_align = layout
            .align
            .min(super::MAX_STATIC_ALIGN)
            .min(self.lex.current_pack())
            .max(self.anon_zero_bitfield_align(struct_id));
        // Pad the struct's tail up to its alignment so consecutive
        // elements of an array preserve every field's natural
        // alignment. A struct with no named member -- empty, or holding
        // only a zero-width bitfield -- has size 0: that is gcc's and
        // clang's C empty-struct extension (C++ floors it at 1, C does
        // not), and the `sizeof(struct { int:-!!(e); })` compile-time
        // assertion idiom depends on the 0.
        let total = round_up(layout.offset, struct_align);
        self.structs[struct_id].size = total;
        self.structs[struct_id].align = struct_align;
        self.structs[struct_id].explicit_align = layout.explicit.min(struct_align) as u32;
        self.structs[struct_id].natural_align = layout.natural.min(super::MAX_STATIC_ALIGN);
        self.structs[struct_id].is_complete = true;
        // The leading spelling lays out exactly like the trailing one.
        // Threading `packed` into the per-member alignment above covers a
        // non-bitfield member; the bit-level packing and the alignment-1
        // result come from the same re-lay the trailing form runs.
        if packed {
            self.repack_struct(struct_id);
        }
    }

    /// Apply the attributes trailing an aggregate body
    /// (`struct S { ... } __attribute__((packed, aligned(64)));`) to the
    /// already-laid-out struct. `packed` re-lays the fields; an
    /// `aligned(N)` raises the aggregate's alignment and its tail
    /// padding, and every other attribute leaves the layout alone.
    pub(super) fn apply_post_body_attributes(&mut self, struct_id: usize) -> Result<(), C5Error> {
        if self.skip_attribute_specifiers()? {
            self.repack_struct(struct_id);
        }
        let transparent = core::mem::take(&mut self.pending.attr_transparent_union);
        let req = self.take_member_align()?;
        if req > 0 {
            let align = self.structs[struct_id].align.max(req as usize);
            self.structs[struct_id].align = align;
            self.structs[struct_id].size = round_up(self.structs[struct_id].size, align);
            self.structs[struct_id].explicit_align =
                self.structs[struct_id].explicit_align.max(req as u32);
        }
        if transparent {
            self.mark_transparent_union(struct_id);
        }
        Ok(())
    }

    /// Honor or discard a `transparent_union` request on the aggregate.
    /// GCC honors the attribute only when the union's machine mode is the
    /// first member's, mirrored here as a non-floating, non-bitfield
    /// first member whose storage covers every member; otherwise GCC
    /// warns and ignores it. An incomplete union (a typedef alias of a
    /// forward declaration) cannot be checked and takes the flag as
    /// declared.
    pub(super) fn mark_transparent_union(&mut self, struct_id: usize) {
        let def = &self.structs[struct_id];
        if def.is_union && !def.is_complete {
            self.structs[struct_id].is_transparent_union = true;
            return;
        }
        let n = def.fields.len();
        let honored = def.is_union
            && n > 0
            && def.fields[0].bit_width == 0
            && !super::types::is_floating_scalar(def.fields[0].ty)
            && (0..n)
                .map(|i| self.packed_member_storage(struct_id, i))
                .max()
                == Some(self.packed_member_storage(struct_id, 0));
        if honored {
            self.structs[struct_id].is_transparent_union = true;
        } else {
            let line = self.lex.line;
            self.warn_at(
                line,
                alloc::string::String::from("`transparent_union` attribute ignored"),
            );
        }
    }

    /// Re-lay a struct's fields with `__attribute__((packed))`
    /// semantics: no inter-member padding and an alignment of 1. Used
    /// when the attribute marker follows the body, after the fields were
    /// placed at their natural alignment. A union only loses its tail
    /// padding (members already sit at offset 0). Bitfields pack at the
    /// bit level with no storage-unit padding (the GCC/clang packed
    /// layout; C99 6.7.2.1p11 leaves the unit implementation-defined);
    /// a non-bitfield member starts at the next byte boundary.
    /// A member carrying an explicit `aligned(N)` keeps that boundary:
    /// `packed` removes natural padding, not a requested alignment.
    pub(super) fn repack_struct(&mut self, struct_id: usize) {
        self.structs[struct_id].align = 1;
        self.structs[struct_id].explicit_align = 0;
        if self.structs[struct_id].is_union {
            self.repack_union(struct_id);
            return;
        }
        let n = self.structs[struct_id].fields.len();
        let mut bit_cursor = 0usize;
        let mut max_explicit_align = self.anon_zero_bitfield_align(struct_id);
        let mut bitfields: Vec<(usize, usize)> = Vec::new();
        let anon = self.structs[struct_id].anon_bitfields.clone();
        let mut anon_pos = 0usize;
        let members = self.structs[struct_id].anon_members.clone();
        let mut mem_pos = 0usize;
        let mut i = 0usize;
        loop {
            // Replay the unnamed bit-fields declared before this member
            // so the packed layout reserves the same bits the natural
            // one did (C99 6.7.2.1p11).
            while anon_pos < anon.len() && anon[anon_pos].before as usize <= i {
                bit_cursor = Self::repack_anon_bitfield(bit_cursor, &anon[anon_pos]);
                anon_pos += 1;
            }
            // A member promoted from an anonymous struct/union moves as a
            // block: packing removes the padding between this aggregate's
            // members, not the padding inside a member's type, so the
            // entries keep their relative offsets, the cursor advances by
            // the member type's size, and the entries' own alignment
            // requests do not reach this aggregate.
            if mem_pos < members.len() && members[mem_pos].first as usize <= i {
                let m = members[mem_pos];
                let base = bit_cursor.div_ceil(8);
                bit_cursor = self.move_anon_member(struct_id, mem_pos, base) * 8;
                mem_pos += 1;
                i = i.max(m.first as usize + m.count as usize);
                continue;
            }
            if i >= n {
                break;
            }

            let (ty, array_size, bit_width, explicit_align) = {
                let f = &self.structs[struct_id].fields[i];
                (f.ty, f.array_size, f.bit_width, f.explicit_align as usize)
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
                i += 1;
                continue;
            }
            // An explicit `aligned(N)` survives packing: it still places
            // the member on its boundary and still raises the aggregate.
            let mut offset = bit_cursor.div_ceil(8);
            if explicit_align > 1 {
                offset = round_up(offset, explicit_align);
                max_explicit_align = max_explicit_align.max(explicit_align);
            }
            self.structs[struct_id].fields[i].offset = offset;
            self.structs[struct_id].fields[i].align = explicit_align.max(1) as u32;
            let storage = if array_size > 0 {
                self.size_of_type(ty) * array_size as usize
            } else if array_size < 0 {
                0
            } else {
                self.size_of_type(ty)
            };
            bit_cursor = (offset + storage) * 8;
            i += 1;
        }
        // Unnamed bit-fields trailing the last named member.
        while anon_pos < anon.len() {
            bit_cursor = Self::repack_anon_bitfield(bit_cursor, &anon[anon_pos]);
            anon_pos += 1;
        }
        let size = bit_cursor.div_ceil(8);
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
        // A surviving explicit member alignment raises the packed
        // aggregate too, so an array of it keeps every member on its
        // requested boundary.
        self.structs[struct_id].align = max_explicit_align;
        self.structs[struct_id].explicit_align = if max_explicit_align > 1 {
            max_explicit_align as u32
        } else {
            0
        };
        self.structs[struct_id].size = round_up(size, max_explicit_align);
    }

    /// Re-size a union whose body was followed by
    /// `__attribute__((packed))`. Its members already sit at offset 0,
    /// so packing only drops the tail padding the natural alignment
    /// added: the size becomes the widest member's storage. A member
    /// carrying an explicit `aligned(N)` keeps raising the union.
    fn repack_union(&mut self, struct_id: usize) {
        let n = self.structs[struct_id].fields.len();
        let members = self.structs[struct_id].anon_members.clone();
        let mut mem_pos = 0usize;
        let mut max_explicit_align = 1usize;
        let mut size = 0usize;
        let mut i = 0usize;
        loop {
            // A promoted anonymous member spans its own type's size, tail
            // padding included.
            if mem_pos < members.len() && members[mem_pos].first as usize <= i {
                let m = members[mem_pos];
                mem_pos += 1;
                size = size.max(m.offset + m.size);
                i = i.max(m.first as usize + m.count as usize);
                continue;
            }
            if i >= n {
                break;
            }
            let f = &self.structs[struct_id].fields[i];
            let (offset, bit_end, explicit_align) = (
                f.offset,
                f.bit_offset as usize + f.bit_width as usize,
                f.explicit_align as usize,
            );
            max_explicit_align = max_explicit_align.max(explicit_align);
            let storage = if bit_end > 0 {
                bit_end.div_ceil(8)
            } else {
                self.packed_member_storage(struct_id, i)
            };
            size = size.max(offset + storage);
            i += 1;
        }
        // An unnamed bit-field is a union member too: it occupies its
        // own storage from offset 0.
        for a in &self.structs[struct_id].anon_bitfields {
            size = size.max((a.width as usize).div_ceil(8));
        }
        self.structs[struct_id].align = max_explicit_align;
        self.structs[struct_id].explicit_align = if max_explicit_align > 1 {
            max_explicit_align as u32
        } else {
            0
        };
        self.structs[struct_id].size = round_up(size, max_explicit_align);
    }

    /// Alignment an aggregate's width-zero unnamed bit-fields impose, or
    /// 1 when there are none. On the targets that align to unnamed
    /// bit-fields, this boundary survives `packed` / `#pragma pack`,
    /// unlike the one a non-zero width contributes.
    fn anon_zero_bitfield_align(&self, struct_id: usize) -> usize {
        if !self.target.align_anon_bitfield() {
            return 1;
        }
        self.structs[struct_id]
            .anon_bitfields
            .iter()
            .filter(|a| a.width == 0)
            .map(|a| (a.unit as usize).min(super::MAX_STATIC_ALIGN))
            .max()
            .unwrap_or(1)
    }

    /// Advance a packed layout's bit cursor over one unnamed bit-field: a
    /// non-zero width reserves exactly that many bits (packing leaves no
    /// storage-unit padding), a zero width rounds up to the next boundary
    /// of the declared type.
    fn repack_anon_bitfield(bit_cursor: usize, a: &AnonBitfield) -> usize {
        if a.width == 0 {
            round_up(bit_cursor, (a.unit as usize).max(1) * 8)
        } else {
            bit_cursor + a.width as usize
        }
    }

    /// Rebase promoted anonymous member `idx` and its entries onto `base`,
    /// preserving the entries' offsets relative to the member's start, and
    /// return the byte just past it.
    fn move_anon_member(&mut self, struct_id: usize, idx: usize, base: usize) -> usize {
        let m = self.structs[struct_id].anon_members[idx];
        for k in m.first as usize..(m.first + m.count) as usize {
            let off = self.structs[struct_id].fields[k].offset;
            self.structs[struct_id].fields[k].offset = off - m.offset + base;
        }
        self.structs[struct_id].anon_members[idx].offset = base;
        base + m.size
    }

    /// Byte storage a non-bitfield member occupies in a packed layout:
    /// element size times count for an array, zero for a flexible-array
    /// member, the type size otherwise.
    fn packed_member_storage(&self, struct_id: usize, i: usize) -> usize {
        let f = &self.structs[struct_id].fields[i];
        let (ty, array_size) = (f.ty, f.array_size);
        if array_size > 0 {
            self.size_of_type(ty) * array_size as usize
        } else if array_size < 0 {
            0
        } else {
            self.size_of_type(ty)
        }
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
