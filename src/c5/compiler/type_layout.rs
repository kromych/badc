//! Type / layout helpers: sizes, alignments, struct lookup, and the
//! "is this token a type?" predicate.
//!
//! All read-mostly inspectors over the compiler's `structs` table
//! plus the lexer's current-token state. Centralised here so the
//! per-`ty` size/align/slot rules and the target-dependent `long`
//! width override live in one place; callers across the parser
//! family reach for these via `self.size_of_type(...)` etc.

use alloc::string::ToString;
use alloc::vec::Vec;

use super::super::codegen::Target;
use super::super::codegen::abi_classify::{FlatField, ScalarKind};
use super::super::ir::AggDesc;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::StructDef;
use super::types::{
    UNSIGNED_BIT, is_pointer_ty, is_struct_ty, is_type_start_token, pointee_size_no_struct,
    struct_id_of, struct_ptr_depth,
};

impl Compiler {
    /// Element size in bytes for a pointer type. Pointer-to-struct
    /// looks up the struct's real size; everything else falls back
    /// to the static [`pointee_size_no_struct`] (1 for `char*`, 8
    /// for any other pointer level), with one target-dependent
    /// override: `long *` is 4 bytes on LLP64 (Windows) and 8
    /// bytes on LP64 (Linux / macOS).
    pub(super) fn pointee_size(&self, ptr_ty: i64) -> i64 {
        if is_struct_ty(ptr_ty) && struct_ptr_depth(ptr_ty) == 1 {
            // Single-level pointer-to-struct: the pointee is the
            // struct value, whose size lives in the struct table.
            return self.structs[struct_id_of(ptr_ty)].size as i64;
        }
        let stripped = ptr_ty & !UNSIGNED_BIT;
        if stripped == (Ty::Long as i64) + (Ty::Ptr as i64) && self.target.is_windows() {
            return 4;
        }
        pointee_size_no_struct(ptr_ty)
    }

    /// True if pointer arithmetic on `ptr_ty` scales the offset by
    /// the pointee's byte size. False only for `char*` (one byte
    /// per element, no scaling). Replaces the old fixed-8 check
    /// which got struct-pointer scaling wrong.
    pub(super) fn is_ptr_scaling_nontrivial(&self, ptr_ty: i64) -> bool {
        is_pointer_ty(ptr_ty) && self.pointee_size(ptr_ty) > 1
    }

    /// Step size used by `++` / `--` on a value of `ty`: the
    /// pointee size for a pointer (so `p++` advances by exactly
    /// `sizeof(*p)`), or `1` for any non-pointer scalar.
    pub(super) fn pointee_step(&self, ty: i64) -> i64 {
        if is_pointer_ty(ty) {
            self.pointee_size(ty)
        } else {
            1
        }
    }

    /// Pointer-arithmetic stride for `ty`. A pointer-to-array
    /// `T (*p)[N]` carries the flat type of a `T*`, so `fallback`
    /// (`pointee_size` / `pointee_step`) scales by `sizeof(T)` rather
    /// than `sizeof(T[N])`. The array's per-element size is seeded
    /// into the multi-dim stride snapshot when the operand is loaded
    /// or an array decays; `seeded_stride` is that value (0 when the
    /// operand is a plain pointer). When it is set, it is the correct
    /// stride; otherwise fall back.
    pub(super) fn pointer_to_array_arith_stride(
        &self,
        seeded_stride: i64,
        ty: i64,
        fallback: i64,
    ) -> i64 {
        if is_pointer_ty(ty) && seeded_stride > 1 {
            seeded_stride
        } else {
            fallback
        }
    }

    /// Look up a tag in scope, searching from the innermost block
    /// outward (C99 6.2.1: tags have block scope). An inner `struct T`
    /// shadows an outer one declared at a wider scope.
    pub(super) fn find_struct_id(&self, name: &str) -> Option<usize> {
        for scope in self.tag_scopes.iter().rev() {
            if let Some((_, id)) = scope.iter().rev().find(|(n, _)| n == name) {
                return Some(*id);
            }
        }
        None
    }

    /// Look up a tag only in the current (innermost) scope. The body
    /// of a struct definition uses this to decide whether the tag is
    /// a redefinition (same scope) or a fresh declaration shadowing
    /// an outer one.
    pub(super) fn find_struct_id_in_current_scope(&self, name: &str) -> Option<usize> {
        self.tag_scopes.last().and_then(|scope| {
            scope
                .iter()
                .rev()
                .find(|(n, _)| n == name)
                .map(|(_, id)| *id)
        })
    }

    /// Find an existing struct tag by name or register a fresh
    /// forward declaration (size 0, no fields) and return that.
    /// Used by every type-position that mentions `struct Foo`
    /// before the struct's body has been seen -- common idioms
    /// like `typedef struct Foo Foo;` and `struct Foo *p;` rely
    /// on this.
    pub(super) fn find_or_forward_declare_struct(&mut self, name: &str) -> usize {
        if let Some(id) = self.find_struct_id(name) {
            return id;
        }
        self.structs.push(StructDef {
            name: name.to_string(),
            size: 0,
            align: 1,
            fields: Vec::new(),
            is_union: false,
        });
        let id = self.structs.len() - 1;
        if let Some(scope) = self.tag_scopes.last_mut() {
            scope.push((name.to_string(), id));
        }
        id
    }

    /// True when the current lexer position starts a type. The free
    /// function `is_type_start_token` covers the keyword tokens
    /// (`int`, `char`, `const`, ...); this method extends it by
    /// recognising any identifier whose symbol carries
    /// `class == Token::Typedef` -- shapes like
    /// `typedef struct X X; X *p;` would otherwise misparse as
    /// `Int p;`.
    pub(super) fn lex_is_type_start(&self) -> bool {
        is_type_start_token(self.lex.tk)
            || self.is_lex_typedef_name()
            // A leading C23 `[[ ... ]]` attribute introduces a
            // declaration (`[[noreturn]] void f(void);`).
            || (self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'['))
    }

    /// True when the current lexer token is an identifier bound to a
    /// typedef. A separate predicate so callers that want only the
    /// typedef case (e.g. `parse_decl_base_type`) can check without
    /// also matching keyword type-starts.
    pub(super) fn is_lex_typedef_name(&self) -> bool {
        self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class == Token::Typedef as i64
    }

    /// Size in bytes of a value of the given `ty`.
    ///   * pointers (any base type)  -> 8
    ///   * scalar `char`             -> 1
    ///   * scalar `short`            -> 2
    ///   * scalar `int`              -> 4 (32-bit signed)
    ///   * scalar `long`             -> 4 on Windows (LLP64), 8 on Unix (LP64)
    ///   * scalar `long long`        -> 8
    ///   * scalar `float`            -> 4 (IEEE 754 single-precision; the
    ///     accumulator widens to f64 across the `LoadKind::F32` load and
    ///     narrows back across the 4-byte float store, so c5-internal
    ///     arithmetic keeps using the existing f64 op set without
    ///     re-tagging)
    ///   * scalar `double`           -> 8
    ///   * struct values             -> recorded in the struct table
    pub(super) fn size_of_type(&self, ty: i64) -> usize {
        // Unsigned bit is orthogonal to width: `unsigned char` is
        // still 1 byte, `unsigned int` is still 4 bytes. Strip it
        // before consulting the band identity.
        let ty = ty & !UNSIGNED_BIT;
        if is_struct_ty(ty) {
            if struct_ptr_depth(ty) > 0 {
                8
            } else {
                self.structs[struct_id_of(ty)].size
            }
        } else if ty == Ty::Bool as i64 {
            // C99 6.2.5p2 / 6.5.3.4: `_Bool` is a 1-byte object.
            1
        } else if ty == Ty::Char as i64 {
            1
        } else if ty == Ty::Short as i64 {
            2
        } else if ty == Ty::Int as i64 {
            4
        } else if ty == Ty::Float as i64 {
            // C99 says `sizeof(float)` is implementation-defined but
            // every mainstream target picks IEEE 754 single (4 bytes).
            // `float *` (and any deeper pointer-to-float) stays at 8
            // bytes -- that's the pointer's width, not the pointee's
            // -- and falls through to the catch-all at the end.
            4
        } else if ty == Ty::Long as i64 {
            // Per-target: LP64 (Linux / macOS) -> 8; LLP64
            // (Windows) -> 4. The `long long` spelling stays at
            // 8 bytes everywhere via `Ty::LongLong`.
            if self.target.is_windows() { 4 } else { 8 }
        } else {
            // `long long`, `double`, all pointers (long long*, long*,
            // int*, char*, short*, float*, double*, ...) -- 8 bytes each.
            8
        }
    }

    /// Natural alignment (in bytes) for a value of the given `ty`.
    /// Mirrors the C alignment rule: the value lives on a boundary
    /// equal to its size for scalars (`char` = 1, `int` = 4,
    /// `long` / pointer = 8). Struct values inherit the max
    /// alignment of their fields, but c5 currently caps struct
    /// alignment at 8 to match the rest of the IR's slot model.
    pub(super) fn align_of_type(&self, ty: i64) -> usize {
        let ty = ty & !UNSIGNED_BIT;
        if ty == Ty::Float as i64 {
            // `float` is 4 bytes; its natural alignment matches.
            // Same rule the rest of the integer / pointer family
            // follows: alignment = sizeof for the scalar variant.
            return 4;
        }
        if is_struct_ty(ty) {
            if struct_ptr_depth(ty) > 0 {
                8
            } else {
                // Struct alignment = max field alignment, capped at 8.
                // Computed eagerly during layout so we don't have to
                // walk every nested struct on each call.
                self.structs[struct_id_of(ty)].align.max(1)
            }
        } else if ty == Ty::Bool as i64 || ty == Ty::Char as i64 {
            1
        } else if ty == Ty::Short as i64 {
            2
        } else if ty == Ty::Int as i64 {
            4
        } else if ty == Ty::Long as i64 {
            if self.target.is_windows() { 4 } else { 8 }
        } else {
            8
        }
    }

    /// Number of c5 stack slots required to hold a value of `ty`.
    /// Each c5 slot is 8 bytes; struct values may span several. The
    /// existing scalar / pointer paths always return 1, so existing
    /// `loc_offs += 1` patterns map to `loc_offs += slots_of(ty)`
    /// without changing emit semantics.
    pub(super) fn slots_of_type(&self, ty: i64) -> i64 {
        if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
            // Struct fields are 8-byte aligned (see parse_struct_body),
            // so the size is already a multiple of 8 -- the +7 round
            // is defensive in case a future change adds sub-8-byte
            // packing.
            ((self.structs[struct_id_of(ty)].size as i64) + 7) / 8
        } else {
            1
        }
    }
}

/// Byte width of a non-struct scalar / pointer `ty`, used when
/// flattening an aggregate's array fields into per-element leaves.
/// Mirrors the scalar cases of [`Compiler::size_of_type`]; the
/// `long` width follows the target data model (LP64 vs LLP64).
fn flat_scalar_size(ty: i64, target: Target) -> u32 {
    if is_pointer_ty(ty) {
        return 8;
    }
    let bare = ty & !UNSIGNED_BIT;
    if bare == Ty::Bool as i64 || bare == Ty::Char as i64 {
        1
    } else if bare == Ty::Short as i64 {
        2
    } else if bare == Ty::Int as i64 || bare == Ty::Float as i64 {
        4
    } else if bare == Ty::Long as i64 {
        if target.is_windows() { 4 } else { 8 }
    } else {
        8
    }
}

/// Flatten an aggregate's leaf scalar fields into `out` as
/// `(offset, size, kind)` triples relative to `base_off`, recursing
/// through nested struct / union values and expanding array fields to
/// one entry per element. Union members overlap at the same offsets,
/// which is what the host-ABI classifier needs (an eightbyte covering
/// any integer member is INTEGER). Bitfields and pointers flatten to
/// `Int`; scalar `float` / `double` to `F32` / `F64`. Free function so
/// the AST walker (which holds only `&[StructDef]`, not a `Compiler`)
/// can build the `AggDesc` the host-ABI classifier consumes.
pub(crate) fn flatten_struct_fields(
    structs: &[StructDef],
    target: Target,
    struct_id: usize,
    base_off: u32,
    out: &mut Vec<FlatField>,
) {
    let sd = &structs[struct_id];
    for f in &sd.fields {
        let elem_ty = f.ty;
        let is_struct_value = is_struct_ty(elem_ty) && struct_ptr_depth(elem_ty) == 0;
        let elem_size = if is_struct_value {
            structs[struct_id_of(elem_ty)].size as u32
        } else {
            flat_scalar_size(elem_ty, target)
        };
        let count = if f.array_size > 0 {
            f.array_size as u32
        } else {
            1
        };
        for i in 0..count {
            let off = base_off + f.offset as u32 + i * elem_size;
            if is_struct_value {
                flatten_struct_fields(structs, target, struct_id_of(elem_ty), off, out);
            } else {
                let bare = elem_ty & !UNSIGNED_BIT;
                let kind = if is_pointer_ty(elem_ty) {
                    ScalarKind::Int
                } else if bare == Ty::Float as i64 {
                    ScalarKind::F32
                } else if bare == Ty::Double as i64 {
                    ScalarKind::F64
                } else {
                    ScalarKind::Int
                };
                out.push(FlatField {
                    offset: off,
                    size: elem_size,
                    kind,
                });
            }
        }
    }
}

/// Build the host-ABI [`AggDesc`] for a by-value aggregate of `ty`,
/// or `None` when `ty` is not a by-value struct the current phase
/// routes through the host ABI. Phase 1 covers AArch64 aggregates of
/// at most 16 bytes (AAPCS64 register / HFA classes); every other
/// case keeps the existing c5 by-address convention.
pub(crate) fn host_abi_agg_desc(structs: &[StructDef], target: Target, ty: i64) -> Option<AggDesc> {
    if !matches!(
        target,
        Target::MacOSAarch64
            | Target::LinuxAarch64
            | Target::WindowsAarch64
            | Target::LinuxX64
            | Target::WindowsX64
    ) {
        return None;
    }
    if !is_struct_ty(ty) || struct_ptr_depth(ty) != 0 {
        return None;
    }
    let id = struct_id_of(ty);
    if id >= structs.len() {
        return None;
    }
    let size = structs[id].size as u32;
    if size == 0 {
        return None;
    }
    let aarch64 = matches!(
        target,
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64
    );
    let align = (structs[id].align.max(1)) as u32;
    let mut fields = Vec::new();
    flatten_struct_fields(structs, target, id, 0, &mut fields);
    // AAPCS64 6.8.2: a homogeneous floating-point aggregate (1..4 members
    // all the same FP type) passes in the FP argument bank, up to four
    // registers -- a four-`double` HFA is 32 bytes, past the by-reference
    // threshold. Admit it on AArch64 ahead of the size / FP-class gates.
    let is_hfa = aarch64 && crate::c5::codegen::abi_classify::hfa_member_layout(&fields).is_some();
    if !is_hfa {
        if matches!(target, Target::WindowsX64) {
            // Win64: only a 1-, 2-, 4-, or 8-byte aggregate is passed by
            // value in a register; larger ones go by implicit reference,
            // which keeps the by-address convention.
            if !matches!(size, 1 | 2 | 4 | 8) {
                return None;
            }
        } else if size > 16 && !matches!(target, Target::LinuxX64) {
            // AArch64 passes a larger non-HFA aggregate by reference; the c5
            // by-address convention already matches. System V x86_64 passes
            // it inline on the stack (MEMORY class), handled by the marshal.
            return None;
        }
        // An aggregate with a floating-point member keeps the by-address
        // convention for arguments. The System V xmm-eightbyte argument emit
        // (marshal + prologue) is in place and handles the register/stack
        // cases, but enabling it surfaces a parameter-passing bug not yet
        // localized, so FP-aggregate arguments stay by-address for now; the
        // FP-aggregate *return* path (xmm0/xmm1) is unaffected and enabled.
        // TODO: System V FP-eightbyte aggregate arguments via xmm.
        if fields.iter().any(|f| f.kind != ScalarKind::Int) {
            return None;
        }
    }
    Some(AggDesc {
        size,
        align,
        fields,
    })
}

/// How a function returns a value of its declared return type.
#[derive(Clone)]
pub(crate) enum StructReturnAbi {
    /// Scalar / void / pointer return -- not a by-value aggregate.
    NotStruct,
    /// c5 by-address convention: the caller passes a result-temp
    /// pointer as a hidden argument and the callee writes through it.
    /// Used on non-host targets and for aggregates the host-ABI path
    /// does not yet cover (floating-point / mixed members).
    OutPtr,
    /// AAPCS64 6.9: an aggregate of at most 16 bytes returned in the
    /// general-purpose result registers (x0, x1).
    Regs(AggDesc),
    /// AAPCS64 6.9: an aggregate larger than 16 bytes returned through
    /// the caller-supplied indirect-result register x8.
    Indirect(AggDesc),
}

/// Classify a function's return-value convention from its declared
/// return type. Integer-class AArch64 aggregates use the host ABI
/// (registers or x8); every other aggregate keeps the c5 out-pointer
/// convention. See [`host_abi_agg_desc`] for the argument-side gate.
pub(crate) fn struct_return_abi(structs: &[StructDef], target: Target, ty: i64) -> StructReturnAbi {
    if !is_struct_ty(ty) || struct_ptr_depth(ty) != 0 {
        return StructReturnAbi::NotStruct;
    }
    let aarch64 = matches!(
        target,
        Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64
    );
    let win64 = matches!(target, Target::WindowsX64);
    if !aarch64 && !matches!(target, Target::LinuxX64 | Target::WindowsX64) {
        return StructReturnAbi::OutPtr;
    }
    let id = struct_id_of(ty);
    if id >= structs.len() {
        return StructReturnAbi::OutPtr;
    }
    let size = structs[id].size as u32;
    if size == 0 {
        return StructReturnAbi::OutPtr;
    }
    let align = (structs[id].align.max(1)) as u32;
    let mut fields = Vec::new();
    flatten_struct_fields(structs, target, id, 0, &mut fields);
    // AAPCS64 6.9: a homogeneous floating-point aggregate returns in up to
    // four consecutive FP registers (v0..v3), independent of the 16-byte
    // integer-register threshold -- a four-`double` HFA is 32 bytes. The
    // emit places each member by its `hfa_member_layout` offset.
    if aarch64 && crate::c5::codegen::abi_classify::hfa_member_layout(&fields).is_some() {
        return StructReturnAbi::Regs(AggDesc {
            size,
            align,
            fields,
        });
    }
    // A <=16B aggregate returns in registers: System V AMD64 3.2.3 places
    // each eightbyte in the integer (rax/rdx) or SSE (xmm0/xmm1) bank per its
    // classification, and the emit reads the per-eightbyte class to pick the
    // bank. An eightbyte shared by integer and FP members classifies as
    // Integer and returns in the integer registers bit-for-bit.
    let desc = AggDesc {
        size,
        align,
        fields,
    };
    if win64 {
        // Win64: a 1-, 2-, 4-, or 8-byte aggregate returns by value in
        // rax; any other size returns through a caller-allocated buffer
        // whose pointer is the hidden first integer argument (rcx),
        // returned in rax -- the c5 out-pointer convention already
        // matches that, so keep it.
        if matches!(size, 1 | 2 | 4 | 8) {
            StructReturnAbi::Regs(desc)
        } else {
            StructReturnAbi::OutPtr
        }
    } else if size <= 16 {
        // AAPCS64 6.9 x0/x1; System V AMD64 3.2.3 rax/rdx.
        StructReturnAbi::Regs(desc)
    } else if aarch64 {
        // AAPCS64: > 16 bytes returns through the x8 indirect-result
        // register.
        StructReturnAbi::Indirect(desc)
    } else {
        // System V AMD64 MEMORY class: the caller passes a hidden
        // result pointer as the first integer argument and the callee
        // returns it -- the c5 out-pointer convention already matches,
        // so keep it.
        StructReturnAbi::OutPtr
    }
}
