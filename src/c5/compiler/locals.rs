//! Local-declaration handlers for function bodies.
//!
//! One declaration line at block scope: the specifiers, then each
//! declarator's storage and its initializer. A declarator resolves to
//! one of four allocators -- a frame slot, a variable-length array's
//! runtime carve, a `static` promoted to data-segment storage, or a
//! block-scope `extern` that reserves none -- and the initializer of
//! each takes the same aggregate walk as a file-scope object's, with
//! runtime stores standing in for constant bytes where an element's
//! value is not known until the program runs.

use super::super::diag::Code;
use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::initializer::{DataStore, DesignatorRule, InitTarget};
use super::types::{
    apply_qual_bits, is_float_ty, is_floating_scalar, is_long_double_ty, is_pointer_ty,
    is_struct_value_ty, is_vector_ty, struct_id_of,
};

/// Alignment facts a block-scope declarator carries into its storage
/// allocation. Produced once per declarator by
/// [`Compiler::resolve_decl_align`].
pub(super) struct DeclAlign {
    /// The declarator's own `aligned(N)` / `_Alignas` request, 0 when absent.
    pub req_align: i64,
    /// The typedef-carried `aligned(N)` type attribute, 0 when absent or
    /// when the declared object is a pointer.
    pub type_align: i64,
    /// The object's declared alignment for `__alignof__`: the declarator
    /// request when present (it replaces a typedef-carried value, else
    /// raises the natural alignment), the typedef value otherwise (which
    /// alone may also lower). 0 when neither applies.
    pub obj_align: i64,
    /// Required alignment of the object when it has automatic storage.
    pub auto_align: i64,
    /// `auto_align` exceeds the 8-byte frame slot, so the object needs the
    /// over-aligned frame region.
    pub region_auto: bool,
    /// The request came from a variable-level GNU `aligned(N)`, which sets
    /// the alignment rather than raising it.
    pub gnu_set: bool,
}

/// A block-scope function declaration: its result type, parameters, the
/// function type its result leads to, the calling convention its type
/// names, and its result's fn-pointer lineage (`Symbol::fn_ptr_indirection`,
/// `Symbol::fn_ptr_ret_indirection`).
pub(super) struct BlockFunction {
    pub(super) ret: super::redeclaration::Spelled,
    pub(super) params: super::function::ParsedParams,
    pub(super) ret_fn: Option<(alloc::boxed::Box<crate::c5::symbol::FnType>, i64)>,
    pub(super) conv: Option<crate::c5::codegen::CallConv>,
    pub(super) lineage: (i64, i64),
}

/// Where a name's binding from outside the current function is kept.
#[derive(Clone, Copy)]
enum SavedAt {
    /// The function-top save, `h_*` on the slot.
    Top,
    /// The outermost block's save: level, position.
    Block(usize, usize),
    /// The slot itself: no scope of the function binds the name.
    Current,
}

/// One block-scope declarator as its binding step sees it: the symbol and
/// its type, the storage class the specifiers gave it, and the register
/// binding, spelling and alignment the declarator collected.
struct LocalDeclarator {
    loc_idx: usize,
    ty: i64,
    enum_tag: Option<u32>,
    array_size: i64,
    /// `array_size` is -1 for a GNU zero-length `[0]`, not for `[]`.
    zero_len: bool,
    is_static: bool,
    is_extern: bool,
    is_thread_local: bool,
    /// A block-scope `extern` that rebinds the name for its scope: no
    /// file-scope object or function of the name is visible.
    convert_extern: bool,
    /// The declarator carries `__attribute__((uninitialized))`, which opts
    /// the object out of `-ftrivial-auto-var-init`.
    uninitialized: bool,
    asm_reg: Option<crate::c5::symbol::AsmRegister>,
    base_spelling: crate::c5::symbol::DeclSpelling,
    /// `None` for a block-scope `extern`, which reserves no storage.
    decl_align: Option<DeclAlign>,
}

impl Compiler {
    /// Drain the three pending local-initializer carriers into a single
    /// `LocalInit`: a scalar AST expression, a runtime per-element store
    /// list (over an optional aggregate zero-fill), an aggregate Mcpy
    /// source, or nothing. Takes the carriers, leaving them empty.
    fn drain_pending_local_init(&mut self) -> super::super::ast::LocalInit {
        let scalar = self.pending_local_init_ast.take();
        let aggregate = self.pending_local_aggregate_ast.take();
        let runtime_elements = core::mem::take(&mut self.pending_local_runtime_elements);
        if let Some(e) = scalar {
            super::super::ast::LocalInit::Scalar(e)
        } else if !runtime_elements.is_empty() {
            super::super::ast::LocalInit::Runtime {
                zero_init: aggregate,
                elements: runtime_elements,
            }
        } else {
            match aggregate {
                Some(super::super::ast::LocalInitPrelude::Template {
                    src_data_off,
                    size_bytes,
                }) => super::super::ast::LocalInit::Aggregate {
                    src_data_off,
                    size_bytes,
                },
                Some(super::super::ast::LocalInitPrelude::Fill { byte, size_bytes }) => {
                    super::super::ast::LocalInit::Fill { byte, size_bytes }
                }
                None => super::super::ast::LocalInit::None,
            }
        }
    }

    /// Save the three pending local-initializer carriers and reset them to
    /// empty, returning the saved values. A declaration nested inside an
    /// enclosing aggregate's element initializer -- reached when an element
    /// is a statement expression that declares a local -- must not drain the
    /// outer aggregate's accumulated runtime elements when its own
    /// `finalize_local_init` runs; wrapping the inner declaration in
    /// take/restore keeps the carriers reentrant.
    #[allow(clippy::type_complexity)]
    pub(super) fn take_pending_local_carriers(
        &mut self,
    ) -> (
        Option<super::super::ast::ExprId>,
        Option<super::super::ast::LocalInitPrelude>,
        alloc::vec::Vec<super::super::ast::RuntimeInitElement>,
    ) {
        (
            self.pending_local_init_ast.take(),
            self.pending_local_aggregate_ast.take(),
            core::mem::take(&mut self.pending_local_runtime_elements),
        )
    }

    pub(super) fn restore_pending_local_carriers(
        &mut self,
        saved: (
            Option<super::super::ast::ExprId>,
            Option<super::super::ast::LocalInitPrelude>,
            alloc::vec::Vec<super::super::ast::RuntimeInitElement>,
        ),
    ) {
        self.pending_local_init_ast = saved.0;
        self.pending_local_aggregate_ast = saved.1;
        self.pending_local_runtime_elements = saved.2;
    }

    /// Assemble the pending initializer for a just-parsed declarator and
    /// emit its local declaration. A non-`Loc` binding (a redeclaration
    /// that resolved elsewhere) discards the carriers without emitting.
    pub(super) fn finalize_local_init(&mut self, loc_idx: usize) {
        // A VLA already emitted its `Decl::Vla` in `allocate_vla_local`.
        if self.symbols[loc_idx].is_vla {
            return;
        }
        if self.symbols[loc_idx].class == Token::Loc as i64 {
            let slot_off = self.symbols[loc_idx].val;
            let init = self.drain_pending_local_init();
            self.ast_emit_local_decl(loc_idx as u32, slot_off, init);
        } else {
            self.pending_local_init_ast = None;
            self.pending_local_aggregate_ast = None;
            self.pending_local_runtime_elements.clear();
        }
    }

    /// C11 6.7.5 alignment of a block-scope declarator, shared by the
    /// function-body-top and inside-block declaration paths. A static
    /// local's `.data` slot honors the request like a file-scope object; an
    /// automatic object lives in 8-byte frame slots, so a wider requirement
    /// goes to the over-aligned frame region. Consumes `pending.attrs.align`
    /// either way, so a request cannot leak onto the next declarator.
    pub(super) fn resolve_decl_align(
        &mut self,
        ty: i64,
        is_static: bool,
        base_type_align: i64,
    ) -> Result<DeclAlign, C5Error> {
        let req_align = core::mem::take(&mut self.pending.attrs.align);
        let alignas_align = core::mem::take(&mut self.pending.attrs.alignas);
        if req_align > 8 && !(req_align as usize).is_power_of_two() {
            return Err(self.compile_err(
                Code::INVALID_DECLARATION,
                format!("requested alignment {req_align} is not a power of two"),
            ));
        }
        self.check_alignas_not_weaker(ty, alignas_align)?;
        let gnu_set = req_align > alignas_align;
        // An over-alignment attribute in the type-specifier position
        // (`struct {...} __attribute__((aligned(16))) *p`) raises the pointee
        // type's alignment; a pointer object holds its own pointer-aligned
        // value, so neither it nor a typedef-carried alignment applies.
        let obj_is_pointer = is_pointer_ty(ty);
        let type_align = if obj_is_pointer {
            0
        } else {
            base_type_align.max(0)
        };
        // A variable-level GNU `aligned(N)` sets the declared alignment,
        // replacing both a typedef-carried value and the type's own; an
        // `_Alignas` request raises the natural alignment only. The typedef
        // value alone stands as given, raising or lowering.
        let obj_align = if req_align == 0 {
            type_align
        } else if gnu_set || type_align > 0 {
            req_align
        } else {
            req_align.max(self.align_of_type(ty) as i64)
        };
        // Placement keeps the type's attribute-free alignment as a floor
        // even where the declared alignment is lower.
        let floor = if gnu_set {
            self.unattributed_align_of(ty)
        } else {
            self.align_of_type(ty)
        } as i64;
        let auto_align = if is_static || obj_is_pointer {
            0
        } else {
            core::cmp::max(obj_align, floor)
        };
        // Any alignment above the 8-byte frame slot -- requested or derived
        // from the type, `__int128` and 16-aligned aggregates included --
        // goes to the over-aligned region. `auto_align` is 0 for a static
        // local and for a pointer object, so neither reaches it however wide
        // the attribute.
        // TODO: fp is 16-aligned on every target, so a 16-aligned object
        // could take an even fp-relative slot instead; the region costs it
        // the inliner's frame pooling and the coalescer's slot sharing.
        let region_auto = auto_align > 8;
        if auto_align > super::MAX_FRAME_ALIGN {
            return Err(self.compile_err(
                Code::LIMIT,
                format!(
                    "requested alignment {auto_align} exceeds the maximum for an \
                 automatic object ({}); use static storage",
                    super::MAX_FRAME_ALIGN
                ),
            ));
        }
        // A static local, or the pointee alignment a type-position attribute
        // carries, is placed like a file-scope object.
        if req_align.max(type_align) > super::MAX_STATIC_ALIGN as i64 {
            return Err(self.compile_err(
                Code::LIMIT,
                format!(
                    "requested alignment {} exceeds the supported maximum of {}",
                    req_align.max(type_align),
                    super::MAX_STATIC_ALIGN
                ),
            ));
        }
        Ok(DeclAlign {
            req_align,
            type_align,
            obj_align,
            auto_align,
            region_auto,
            gnu_set,
        })
    }

    /// C11 6.7.5p4: an `_Alignas` specifier weaker than the declared type's
    /// alignment is a constraint violation. A variable-level GNU
    /// `aligned(N)` carries no such rule and is not checked here.
    pub(super) fn check_alignas_not_weaker(
        &mut self,
        ty: i64,
        alignas_align: i64,
    ) -> Result<(), C5Error> {
        let natural = self.align_of_type(ty) as i64;
        if alignas_align > 0 && alignas_align < natural {
            return Err(self.compile_err(
                Code::INVALID_DECLARATION,
                format!(
                    "requested alignment {alignas_align} is less than the minimum \
                 alignment {natural} of the declared type"
                ),
            ));
        }
        Ok(())
    }

    /// Placement alignment of a block-scope static: the widest of the
    /// declarator request, the type's natural alignment, and an
    /// `aligned(N)` type attribute on the base. Records it on the symbol
    /// and raises the unit's `.data` alignment to match.
    pub(super) fn apply_static_local_align(&mut self, loc_idx: usize, ty: i64, a: &DeclAlign) {
        let want_align = if a.gnu_set {
            core::cmp::max(a.req_align as usize, self.unattributed_align_of(ty))
        } else {
            core::cmp::max(
                core::cmp::max(a.req_align.max(0) as usize, self.align_of_type(ty)),
                a.type_align.max(0) as usize,
            )
        };
        self.symbols[loc_idx].data_align = want_align.max(1) as i64;
        if want_align > 8 {
            self.note_static_align(want_align, self.lex.line);
            self.data_align = self.data_align.max(want_align);
        }
    }

    /// Placement alignment of a block-scope static's storage: the
    /// requirement [`Self::apply_static_local_align`] recorded, floored
    /// at the boundary every object wider than one byte takes.
    fn static_local_placement_align(&self, loc_idx: usize, ty: i64) -> usize {
        let decl_align = self.symbols[loc_idx].data_align.max(0) as usize;
        self.data_placement_align(ty, decl_align)
    }

    /// Record an over-aligned automatic object's frame slot so it is placed
    /// in the over-aligned frame region. A variable-length array's storage is
    /// carved by a 16-byte-rounded sp move, so an alignment up to 16 is
    /// already met; above it the `Decl::Vla` just pushed carries it.
    pub(super) fn record_over_aligned_local(
        &mut self,
        loc_idx: usize,
        ty: i64,
        auto_align: i64,
    ) -> Result<(), C5Error> {
        if self.symbols[loc_idx].is_vla {
            let vla = self.ast.decls.iter_mut().rev().find_map(|d| match d {
                super::super::ast::Decl::Vla { sym, align, .. } if *sym as usize == loc_idx => {
                    Some(align)
                }
                _ => None,
            });
            if let Some(align) = vla.filter(|_| auto_align > 16) {
                *align = auto_align as u32;
            }
            return Ok(());
        }
        let slot = self.symbols[loc_idx].val;
        let asz = self.symbols[loc_idx].array_size;
        let size = self.local_storage_slots(ty, asz) * 8;
        self.func_over_aligned.push((slot, auto_align, size));
        Ok(())
    }

    /// Reserve the frame slots of an automatic object no declarator names:
    /// a compound literal (C99 6.5.2.5p5) or the body's copy of a by-value
    /// aggregate parameter. A type alignment above the 8-byte slot places
    /// it in the over-aligned frame region as a named declarator's object.
    pub(super) fn reserve_object_slots(&mut self, ty: i64, slots: i64) -> Result<i64, C5Error> {
        let slots = slots.max(1);
        let slot = self.reserve_slots(slots);
        let align = self.align_of_type(ty) as i64;
        if align > 8 {
            if align > super::MAX_FRAME_ALIGN {
                return Err(self.compile_err(
                    Code::LIMIT,
                    format!(
                        "requested alignment {align} exceeds the maximum for an \
                     automatic object ({}); use static storage",
                        super::MAX_FRAME_ALIGN
                    ),
                ));
            }
            self.func_over_aligned.push((slot, align, slots * 8));
        }
        Ok(slot)
    }

    pub(super) fn record_multi_cell_temp(&mut self, slot: i64, cells: i64, ty: i64) {
        self.multi_cell_temps.push((slot, cells));
        let facts =
            super::types::ssp_classify(&self.structs, ty, 0, false, &|t| self.size_of_type(t));
        if facts.has_array && !self.array_temps.contains(&slot) {
            self.array_temps.push(slot);
        }
    }

    /// Parse one declaration inside a function body: the declaration
    /// specifiers, then a comma-separated declarator list each with an
    /// optional initializer. The innermost open scope -- `block_scopes`
    /// when a nested block or `for`-init level is open, the
    /// function-body scope (shared with the parameters, C99 6.2.1p4)
    /// otherwise -- receives the bindings and the saved outer state its
    /// exit restores. The attributes the item led with are already on
    /// `pending.attrs`.
    pub(super) fn parse_local_decl(&mut self) -> Result<(), C5Error> {
        let mut is_static = false;
        let mut is_extern = false;
        let mut is_thread_local = false;
        let mut saw_specifier = false;
        let mut qual_bits: i64 = 0;
        self.pending.base_is_const = false;
        let _ = self.take_base_spelling();
        self.pending.saw_register_storage = false;
        saw_specifier |= self.consume_local_decl_specifiers(
            &mut is_static,
            &mut is_extern,
            &mut is_thread_local,
            &mut qual_bits,
        )?;
        // C11 6.7.1: a block-scope thread-local has static storage duration.
        if is_thread_local && !is_extern {
            is_static = true;
        }
        // Implicit int (`register n = ...;`), gated on an explicit specifier
        // so a mistyped type name still surfaces as an error.
        let (base, implicit_int) = if !self.lex_is_type_start() && saw_specifier {
            (Ty::Int as i64, true)
        } else {
            let base = self.parse_decl_base_type()?;
            (base, core::mem::take(&mut self.pending.base_implicit_int))
        };
        // C99 6.7.1: specifiers may also trail the type (`int const y;`).
        self.consume_local_decl_specifiers(
            &mut is_static,
            &mut is_extern,
            &mut is_thread_local,
            &mut qual_bits,
        )?;
        if is_thread_local && !is_extern {
            is_static = true;
        }
        let lbt = apply_qual_bits(base, qual_bits);
        let base_spelling = self.take_base_spelling();
        let base_enum_tag = self.pending.base_enum_tag.take();
        // A typedef-carried type alignment applies to every declarator of
        // this declaration; an initializer's own type parses (casts,
        // `sizeof`) reset the pending carrier, so capture it once here.
        let base_type_align = self.pending.type_align;
        // A function-pointer typedef base type contributes its lineage to
        // every declarator (`fn_t a, b;`), but per-declarator symbol
        // creation consumes the carriers, so re-seed them each iteration.
        let base_fn_ptr_indirection = self.pending.fn_ptr_indirection;
        let base_fn_ptr_ret_indirection = self.pending.fn_ptr_ret_indirection;
        let base_is_function_type = self.pending.base_is_function_type;
        let base_fn_type = self.pending.fn_ptr_type.clone();
        let spec_attrs = self.pending.attrs.clone();
        while self.lex.tk != ';' {
            self.pending.attrs = spec_attrs.clone();
            self.pending.fn_ptr_indirection = base_fn_ptr_indirection;
            self.pending.fn_ptr_ret_indirection = base_fn_ptr_ret_indirection;
            self.pending.base_is_function_type = base_is_function_type;
            self.pending.fn_ptr_type = base_fn_type.clone();
            // Any declarator of the list may declare a function (C99 6.7p1).
            let base = super::redeclaration::Spelled {
                ty: lbt,
                enum_tag: base_enum_tag,
            };
            let declarator_line = self.lex.line;
            if let Some(fn_idx) = self.try_parse_block_fn_prototype(base, is_static)? {
                if implicit_int {
                    let what = super::decl_base::ImplicitInt::Declarator(fn_idx);
                    self.report_implicit_int(what, declarator_line)?;
                }
                self.accept_declarator_separator()?;
                continue;
            }
            // C99 6.7.6.2: a non-constant dimension here is a VLA. Save
            // and restore rather than set and clear: evaluating an outer
            // dimension can parse a nested block declaration (a statement
            // expression inside the dimension), and that inner declarator
            // must not clear the outer one's flag.
            let saved_vla = core::mem::replace(&mut self.pending.vla_allowed, true);
            // Filled by a declarator group holding its entity's own list.
            self.pending.fn_params = None;
            let (loc_idx, ty, mut array_size, mut zero_len) = self.parse_declarator(lbt)?;
            self.pending.vla_allowed = saved_vla;
            if implicit_int {
                let what = super::decl_base::ImplicitInt::Declarator(loc_idx);
                self.report_implicit_int(what, declarator_line)?;
            }
            self.pending.attrs.transparent_union = false;
            // C99 6.7.1p5 + 6.9.1: a declarator of bare function type (a
            // function-TYPE typedef with no pointer level) declares a
            // function, not an object; classifying it as data would make a
            // use of the name load code bytes. Bind it as
            // `try_parse_block_fn_prototype` binds the `name(params)` form.
            let spelled = super::redeclaration::Spelled {
                ty,
                enum_tag: base_enum_tag,
            };
            if self.bind_bare_function_declarator(loc_idx, spelled, is_static)?
                || self.bind_grouped_function_declarator(loc_idx, spelled, is_static)?
            {
                continue;
            }
            let asm_reg = self.parse_register_asm_binding(loc_idx, is_static, is_extern)?;
            let cleanup_fn = self.pending.attrs.cleanup.take();
            let uninitialized = core::mem::take(&mut self.pending.attrs.uninitialized);
            // Take the fn-pointer carriers before any initializer is parsed:
            // an initializer cast runs a base-type parse that clears them,
            // which would drop a variadic fn-pointer's prototype.
            let fn_type = self.take_decl_fn_type()?;
            let fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
            let fn_ptr_ret_indirection = core::mem::take(&mut self.pending.fn_ptr_ret_indirection);
            // C99 6.7.7p3: an array typedef contributes its dimension only
            // when no derivation of the declarator applied to it; `A *p`
            // points to the array. Peek without clearing so the rest of the
            // comma list keeps it. An alias of unknown size (`-1`) leaves
            // the size to the initializer, and a zero-length one is empty.
            let typedef_dim = self.pending.typedef_base_array_size;
            self.check_array_elem_align(array_size, ty, typedef_dim, base_type_align)?;
            if typedef_dim != 0 && array_size == 0 && !self.pending.base_array_taken {
                array_size = typedef_dim;
                zero_len = self.pending.typedef_base_zero_len;
                self.apply_typedef_array_dims(loc_idx);
            }
            self.ty = ty;

            // C99 6.2.1p4 / 6.2.2p4: a block-scope `extern` names the
            // file-scope entity. An existing `Glo`/`Fun` binding is that
            // entity already; any other state of the name (unbound, local,
            // parameter, enum constant, typedef) is saved and restored, with
            // in-scope references routed through `block_extern_refs`.
            let prior_class = self.symbols[loc_idx].class;
            let convert_extern =
                is_extern && prior_class != Token::Glo as i64 && prior_class != Token::Fun as i64;

            // An extern naming an existing entity declares nothing new, so
            // none of the per-declarator writes below apply to it.
            let rebinds_slot = !is_extern || convert_extern;

            // C99 6.7p3: an identifier with no linkage is declared once per
            // scope. An `extern` redeclaration has linkage and is exempt.
            if !is_extern && self.binds_in_current_scope(loc_idx) {
                return Err(
                    self.compile_err(Code::INVALID_DECLARATION, "duplicate local definition")
                );
            }
            // Save the outer binding of any name this declarator rebinds; an
            // extern naming an existing entity writes nothing to restore.
            if rebinds_slot {
                self.save_scope_binding(loc_idx);
            }
            if self.pending.attrs.maybe_unused {
                self.symbols[loc_idx].binding.maybe_unused = true;
            }

            // C99 6.7p7: an object declared with no linkage must have a
            // complete type by the end of its declarator; an enum used
            // before its definition is incomplete (6.7.2.3p2). A block-scope
            // `extern` has linkage and declares no object, so it is exempt.
            if !is_extern && self.incomplete_aggregate_tag(ty).is_some() {
                let name = self.symbols[loc_idx].name.clone();
                return Err(self.compile_err(
                    Code::INVALID_DECLARATION,
                    format!("object `{name}` has incomplete type"),
                ));
            }

            if is_extern {
                let bounds = self.declared_bounds(loc_idx, array_size, zero_len);
                let spelled = super::redeclaration::Spelled {
                    ty,
                    enum_tag: base_enum_tag,
                };
                let leads_to = fn_type.clone().filter(|_| fn_ptr_indirection > 0);
                let declared = super::redeclaration::DeclaredType::Object(
                    spelled,
                    bounds,
                    leads_to.map(|f| (f, fn_ptr_indirection)),
                );
                self.declare_linked(loc_idx, declared, self.lex.line, is_thread_local)?;
            }
            // A block-scope `extern` allocates no storage (C11 6.7.5).
            let decl_align = if is_extern {
                None
            } else {
                Some(self.resolve_decl_align(ty, is_static, base_type_align)?)
            };

            // The function type the object points to is part of its type,
            // which the initializer reads: it may name the object (C99
            // 6.2.1p7) and converts to it. Written unconditionally, so a
            // reused slot leaks no stale lineage from an outer binding.
            if rebinds_slot {
                self.symbols[loc_idx].fn_ptr_indirection = fn_ptr_indirection;
                self.symbols[loc_idx].fn_ptr_ret_indirection = fn_ptr_ret_indirection;
                self.symbols[loc_idx].fn_type = fn_type.unwrap_or_default();
            }
            self.bind_local_declarator(&LocalDeclarator {
                loc_idx,
                ty,
                enum_tag: base_enum_tag,
                array_size,
                zero_len,
                is_static,
                is_extern,
                is_thread_local,
                convert_extern,
                uninitialized,
                asm_reg,
                base_spelling,
                decl_align,
            })?;
            // `T x[]` whose initializer resolved to zero elements keeps its
            // array-ness; written after the initializer fixed the count.
            if rebinds_slot {
                self.symbols[loc_idx].is_zero_len_array =
                    array_size == -1 && self.symbols[loc_idx].array_size == 0;
            }

            // After the binding is final (the automatic branch reset
            // `was_referenced`). The attribute requires automatic storage,
            // so a static / extern declarator's cleanup is inert.
            if let Some(fn_sym) = cleanup_fn
                && !is_static
                && !is_extern
            {
                self.register_cleanup_var(loc_idx, fn_sym);
            }

            if self.pending.auto_type_single_declarator && self.lex.tk == ',' {
                return Err(self.compile_err(
                    Code::SYNTAX,
                    "`__auto_type` declaration takes a single declarator",
                ));
            }
            self.accept_declarator_separator()?;
        }
        self.next()?;
        self.pending.auto_type_single_declarator = false;
        Ok(())
    }

    pub(super) fn set_decl_site(&mut self, idx: usize) {
        let (line, file, in_user) = (
            self.lex.line,
            self.intern_source_file() as u32,
            self.in_user_source(),
        );
        self.decl_count += 1;
        let b = &mut self.symbols[idx].binding;
        (b.decl_line, b.decl_file, b.decl_in_user_source) = (line, file, in_user);
        b.decl_seq = self.decl_count;
    }

    /// Bind one block-scope declarator to storage: a block-scope `extern`
    /// names an entity and reserves nothing (C11 6.7.5), a `static` takes a
    /// `.data` or thread-local slot, and an automatic object takes a frame
    /// slot and its initializer.
    fn bind_local_declarator(&mut self, d: &LocalDeclarator) -> Result<(), C5Error> {
        if d.is_extern {
            if d.convert_extern {
                self.symbols[d.loc_idx].class = Token::Glo as i64;
                self.symbols[d.loc_idx].type_ = d.ty;
                self.symbols[d.loc_idx].incomplete_enum_tag = d.enum_tag;
                self.symbols[d.loc_idx].binding.decl_spelling = self.decl_spelling(d.base_spelling);
                self.set_decl_site(d.loc_idx);
                // Record the dimension so a subscript sees an array
                // (6.7.6.2). `-1` (unsized `extern T name[];`) is kept as
                // at file scope: an incomplete array still decays to a
                // pointer, while 0 would read the name as a scalar.
                self.symbols[d.loc_idx].array_size = d.array_size;
                // Carry no in-unit offset and leave `is_extern_decl` /
                // `linkage` untouched so the restore is exact.
                self.symbols[d.loc_idx].val = 0;
                self.symbols[d.loc_idx].block_extern_active = true;
                self.symbols[d.loc_idx].scoped_obj_decl = true;
                self.symbols[d.loc_idx].is_thread_local = d.is_thread_local;
            }
            // `weak` / `visibility("hidden")` are not part of the shadow
            // snapshot, so they reach the symbol table past the scope.
            self.apply_symbol_attributes(d.loc_idx);
        } else if d.is_static {
            self.symbols[d.loc_idx].class = Token::Glo as i64;
            self.symbols[d.loc_idx].type_ = d.ty;
            self.symbols[d.loc_idx].incomplete_enum_tag = d.enum_tag;
            self.symbols[d.loc_idx].binding.decl_spelling = self.decl_spelling(d.base_spelling);
            self.set_decl_site(d.loc_idx);
            self.symbols[d.loc_idx].is_thread_local = d.is_thread_local;
            // C99 6.2.2p6: the block-scope object has no linkage; an
            // outer extern declaration's mark must not classify it.
            self.symbols[d.loc_idx].is_extern_decl = false;
            // C99 6.2.4p3: static storage, block scope. The function-body
            // scope's restore pass is gated on class `Loc`, which a
            // static local no longer carries, so mark it; a nested block
            // unbinds it from its own shadow stack instead.
            self.symbols[d.loc_idx].is_scope_bound |= self.block_scopes.is_empty();
            // A `static const` integer folds its `.data` value into a
            // later constant expression, so `char buf[N * 2 + 1]` is a
            // fixed array rather than a VLA. Static storage plus a const
            // object type also makes the initializer the value for the
            // whole execution, as at file scope.
            let object_const = self.declared_object_is_const(d.ty);
            self.symbols[d.loc_idx].is_const_qualified =
                object_const && d.array_size == 0 && super::types::is_integer_scalar_ty(d.ty);
            self.symbols[d.loc_idx].storage_is_const = object_const;
            if let Some(a) = &d.decl_align {
                self.apply_static_local_align(d.loc_idx, d.ty, a);
                // Declared object alignment for `__alignof__` on the
                // name; distinct from the placement above, which never
                // drops below the natural alignment.
                self.symbols[d.loc_idx].type_align = a.obj_align.max(0);
            }
            self.static_duration_init += 1;
            let r = self.allocate_static_local(d.loc_idx, d.ty, d.array_size);
            self.static_duration_init -= 1;
            r?;
            self.push_block_static_record(d.loc_idx, d.ty);
            self.ast_emit_static_local_decl(d.loc_idx as u32);
        } else {
            // TR 18037 5.1.2 (GCC named address spaces): an object
            // in `__seg_gs` / `__seg_fs` needs static storage; a
            // frame slot has no segment.
            if super::types::segment_of_object_ty(d.ty).is_some() {
                return Err(self.compile_err(
                    Code::INVALID_DECLARATION,
                    "a named address space requires static storage",
                ));
            }
            self.symbols[d.loc_idx].class = Token::Loc as i64;
            self.symbols[d.loc_idx].type_ = d.ty;
            self.symbols[d.loc_idx].incomplete_enum_tag = d.enum_tag;
            self.symbols[d.loc_idx].binding.decl_spelling = self.decl_spelling(d.base_spelling);
            self.set_decl_site(d.loc_idx);
            // Unconditional write so a reused symbol slot does not leak
            // a stale binding from an outer name.
            self.symbols[d.loc_idx].asm_register = d.asm_reg;
            // Declared object alignment for `__alignof__` on the name.
            // Unconditional for the same slot-reuse reason; written
            // before the initializer parse, which may itself take
            // `__alignof__` of the name.
            self.symbols[d.loc_idx].type_align = d
                .decl_align
                .as_ref()
                .map(|a| a.obj_align.max(0))
                .unwrap_or(0);
            self.check_register_asm_init(d.asm_reg)?;
            // A `const` scalar arithmetic auto local with a constant
            // initializer records its value for the case-label /
            // `static_assert` fold (see `const_object_fold`).
            // Unconditional write so a reused slot leaks no stale
            // value from an outer binding.
            self.symbols[d.loc_idx].const_object_value = None;
            if self.declared_object_is_const(d.ty)
                && d.array_size == 0
                && d.asm_reg.is_none()
                && !super::types::is_volatile_ty(d.ty)
                && (super::types::is_integer_scalar_ty(d.ty)
                    || super::types::is_floating_scalar(d.ty))
                && self.lex.tk == Token::Assign
            {
                self.symbols[d.loc_idx].const_object_value =
                    self.try_fold_const_object_init(d.ty)?;
            }
            // `-ftrivial-auto-var-init` covers the object unless the
            // program opted it out or bound it to a register.
            let fill = if d.uninitialized || d.asm_reg.is_some() {
                None
            } else {
                self.auto_var_init.fill_byte()
            };
            // This declaration can sit inside an enclosing aggregate's
            // element initializer (an element that is a statement
            // expression), so keep the carriers reentrant.
            let saved = self.take_pending_local_carriers();
            let r = self.allocate_local_with_init(d.loc_idx, d.ty, d.array_size, d.zero_len, fill);
            if r.is_ok() {
                self.finalize_local_init(d.loc_idx);
            }
            self.restore_pending_local_carriers(saved);
            r?;
            // C11 6.7.5: an automatic object aligned past the 8-byte
            // frame slot goes in the over-aligned frame region, recorded
            // now that its slot is assigned.
            if let Some(a) = d.decl_align.as_ref().filter(|a| a.region_auto) {
                self.record_over_aligned_local(d.loc_idx, d.ty, a.auto_align)?;
            }
        }
        Ok(())
    }

    /// A declarator of bare function type -- a function-TYPE typedef with no
    /// pointer level -- declares a function, not an object (C99 6.7.1p5,
    /// 6.9.1); classifying it as data would make a use of the name load code
    /// bytes. Binds it as the `name(params)` form is bound. Returns true when
    /// the declarator was one, its separator consumed.
    fn bind_bare_function_declarator(
        &mut self,
        loc_idx: usize,
        ty: super::redeclaration::Spelled,
        is_static: bool,
    ) -> Result<bool, C5Error> {
        if !core::mem::take(&mut self.pending.bare_function_type_declarator) {
            return Ok(false);
        }
        let base = self.pending.fn_ptr_type.take().unwrap_or_default();
        self.pending.fn_ptr_indirection = None;
        self.pending.fn_ptr_ret_indirection = 0;
        if loc_idx == usize::MAX {
            self.accept_declarator_separator()?;
            return Ok(true);
        }
        // Undo the typedef's pre-decay to pointer-to-function.
        let conv = self.add_conv(base.named_conv(), self.pending.attrs.call_conv)?;
        let f = BlockFunction {
            ret: super::redeclaration::Spelled {
                ty: ty.ty - Ty::Ptr as i64,
                ..ty
            },
            params: super::function::ParsedParams::of_type(base.params),
            ret_fn: base.ret,
            conv,
            lineage: (0, 0),
        };
        self.bind_block_function(loc_idx, f, is_static)
    }

    /// A declarator whose group holds its entity's own parameter list
    /// (`int (*f(void))[3];`, `void (*g(int))(int);`) declares a function
    /// returning the type the group's derivations give (C99 6.7.5.3p1); the
    /// list has prototype scope (6.2.1p4). Returns true when the declarator
    /// was one, its separator consumed.
    fn bind_grouped_function_declarator(
        &mut self,
        loc_idx: usize,
        ty: super::redeclaration::Spelled,
        is_static: bool,
    ) -> Result<bool, C5Error> {
        let Some(params) = self.pending.fn_params.take() else {
            return Ok(false);
        };
        for &p in &params.indices {
            Self::restore_shadowed_symbol(&mut self.symbols[p]);
        }
        let ret_fn = self.take_decl_ret_fn(true);
        let fpi = self.pending.fn_ptr_indirection.take().unwrap_or(0);
        let fpri = core::mem::take(&mut self.pending.fn_ptr_ret_indirection);
        self.pending.fn_ptr_type = None;
        let f = BlockFunction {
            ret: ty,
            params,
            ret_fn,
            conv: self.pending.attrs.call_conv,
            lineage: (fpi, fpri),
        };
        self.bind_block_function(loc_idx, f, is_static)
    }

    /// Bind a block-scope function declaration and consume its separator.
    fn bind_block_function(
        &mut self,
        loc_idx: usize,
        f: BlockFunction,
        is_static: bool,
    ) -> Result<bool, C5Error> {
        self.bind_block_function_decl(loc_idx, f, is_static, None)?;
        self.accept_declarator_separator()?;
        Ok(true)
    }

    /// Bind a block-scope function declaration (C99 6.2.1p4): in the block the
    /// name denotes the function, whatever binding it hides, with the
    /// composite type of the visible declarations (6.2.7p4). The function is
    /// the entity a file-scope binding of the name denotes, a library one
    /// included; with none the declaration starts one, which the scope exits
    /// leave on the slot for the rest of the unit (6.2.2p4), or past a
    /// file-scope binding without linkage hold apart (`entity_record`).
    pub(super) fn bind_block_function_decl(
        &mut self,
        idx: usize,
        f: BlockFunction,
        is_static: bool,
        label: Option<alloc::string::String>,
    ) -> Result<(), C5Error> {
        let c = self.symbols[idx].class;
        let apart = self.names_fn_apart(idx, c);
        let ent = if apart {
            self.detached_fn_slot(idx)
        } else {
            self.fn_entity_of(idx)
        };
        let (conv, conv_named) = self.declared_conv(ent, f.conv, self.lex.line)?;
        let listed = super::redeclaration::Params::of(&f.params, false);
        let ret_fn = f.ret_fn.clone().map(|(r, d)| (*r, d));
        let declared = super::redeclaration::DeclaredType::Function(f.ret, listed, f.conv, ret_fn);
        self.declare_linked(ent, declared, self.lex.line, false)?;
        let prototyped = f.params.form == super::function::ParamForm::Prototype;
        let fresh = super::stmt::FnEntity {
            class: Token::Fun as i64,
            type_: f.ret.ty,
            incomplete_enum_tag: f.ret.enum_tag,
            val: 0,
            fn_type: crate::c5::symbol::FnType {
                params: f.params.fn_params(),
                conv,
                conv_named,
                ret: f.ret_fn,
            },
            lineage: f.lineage,
            is_extern_decl: true,
        };
        let mut keep_at = None;
        if apart {
            if !self.symbols[ent].scoped_fn_decl {
                self.set_fn_entity(ent, &fresh, is_static);
                self.symbols[ent].class = 0;
            }
            let held = self.live_fn_entity(ent);
            self.rebind_scoped(idx)?;
            self.adopt_fn_entity(idx, held);
            self.symbols[idx].entity_record = Some(ent as u32);
        } else if c == Token::Fun as i64 {
            if !self.binds_in_current_scope(idx) {
                let outer_record = self.symbols[idx].entity_record;
                self.rebind_scoped(idx)?;
                self.symbols[idx].entity_record = outer_record;
            }
        } else if c == 0 {
            self.rebind_scoped(idx)?;
            self.set_fn_entity(idx, &fresh, is_static);
            keep_at = Some(self.file_scope_state(idx));
        } else if c != Token::Sys as i64 {
            // Hiding a binding of another kind: the entity is the file-scope one.
            let at = self.file_scope_state(idx);
            let outer = self.saved_fn_entity(idx, at);
            self.rebind_scoped(idx)?;
            match outer {
                Some(Some(e)) => self.adopt_fn_entity(idx, e),
                Some(None) => {
                    self.set_fn_entity(idx, &fresh, is_static);
                    keep_at = Some(at);
                }
                None => {
                    let name = &self.symbols[idx].name;
                    let msg = format!("`{name}` redeclared as a function");
                    return Err(self.compile_err(Code::INVALID_DECLARATION, msg));
                }
            }
        }
        let slots = if ent == idx {
            &[idx][..]
        } else {
            &[ent, idx][..]
        };
        for &slot in slots {
            let sym = &mut self.symbols[slot];
            if c != 0 && c != Token::Sys as i64 && prototyped && !sym.fn_type.params.prototyped {
                sym.fn_type.params = fresh.fn_type.params.clone();
            }
            if sym.is_fun_entity() {
                (sym.fn_type.conv, sym.fn_type.conv_named) = (conv, conv_named);
            }
            sym.is_noreturn |= self.pending.attrs.noreturn;
        }
        self.apply_symbol_attributes(ent);
        if let Some(label) = label {
            self.set_asm_label(ent, label)?;
        }
        if let Some(at) = keep_at {
            self.keep_fn_entity(idx, at, &fresh);
        }
        Ok(())
    }

    /// Whether a block-scope declaration of function `idx`, bound now as
    /// `class`, follows a file-scope typedef or enumerator, which has no
    /// linkage (C99 6.2.2p4, p6).
    fn names_fn_apart(&self, idx: usize, class: i64) -> bool {
        let not_fn = class != 0 && class != Token::Fun as i64 && class != Token::Sys as i64;
        let outer = match self.file_scope_state(idx) {
            SavedAt::Top => self.symbols[idx].h_class,
            SavedAt::Block(level, at) => self.block_scopes[level][at].class().0,
            SavedAt::Current => class,
        };
        not_fn && (outer == Token::Typedef as i64 || outer == Token::Num as i64)
    }

    /// The name's detached function slot: an earlier declaration's, or new.
    fn detached_fn_slot(&mut self, idx: usize) -> usize {
        let name = self.symbols[idx].name.clone();
        let hash = crate::c5::lexer::hash_name(name.as_bytes());
        if let Some(home) = self
            .symbol_index
            .lookup_detached(&self.symbols, hash, name.as_bytes())
        {
            return home;
        }
        let home = self.fresh_name_slot(idx);
        self.symbols[home].detached = true;
        home
    }

    /// The slot a file-scope typedef or enumerator binds for the name of
    /// `idx`: a fresh one, with the declarator's shape, when `idx` holds a
    /// block-scope declaration's function past its scope (C99 6.2.2p4).
    pub(super) fn claim_file_scope_name(&mut self, idx: usize) -> usize {
        let s = &self.symbols[idx];
        if self.in_function_body() || s.class != 0 || !s.scoped_fn_decl {
            return idx;
        }
        let fresh = self.fresh_name_slot(idx);
        let held = &mut self.symbols[idx];
        held.detached = true;
        let shape = (held.inner_array_size, core::mem::take(&mut held.array_dims));
        (
            self.symbols[fresh].inner_array_size,
            self.symbols[fresh].array_dims,
        ) = shape;
        fresh
    }

    fn fresh_name_slot(&mut self, idx: usize) -> usize {
        let name = self.symbols[idx].name.clone();
        let hash = crate::c5::lexer::hash_name(name.as_bytes());
        self.symbols.push(crate::c5::symbol::Symbol {
            name,
            token: Token::Id as i64,
            ..Default::default()
        });
        self.symbol_index.record(hash);
        self.symbols.len() - 1
    }

    fn live_fn_entity(&self, idx: usize) -> super::stmt::FnEntity {
        let s = &self.symbols[idx];
        super::stmt::FnEntity {
            class: s.class,
            type_: s.type_,
            incomplete_enum_tag: s.incomplete_enum_tag,
            val: s.val,
            fn_type: s.fn_type.clone(),
            lineage: (s.fn_ptr_indirection, s.fn_ptr_ret_indirection),
            is_extern_decl: s.is_extern_decl,
        }
    }

    fn set_fn_entity(&mut self, idx: usize, e: &super::stmt::FnEntity, is_static: bool) {
        self.adopt_fn_entity(idx, e.clone());
        let sym = &mut self.symbols[idx];
        sym.scoped_fn_decl = true;
        sym.linkage = if is_static {
            crate::c5::symbol::Linkage::Internal
        } else {
            crate::c5::symbol::Linkage::External
        };
    }

    /// Bind `idx` to the function entity `e`; its val is the entity's entry.
    fn adopt_fn_entity(&mut self, idx: usize, e: super::stmt::FnEntity) {
        let sym = &mut self.symbols[idx];
        sym.class = if e.class == 0 {
            Token::Fun as i64
        } else {
            e.class
        };
        sym.type_ = e.type_;
        sym.incomplete_enum_tag = e.incomplete_enum_tag;
        sym.val = e.val;
        sym.fn_type = e.fn_type;
        (sym.fn_ptr_indirection, sym.fn_ptr_ret_indirection) = e.lineage;
        sym.is_extern_decl = e.is_extern_decl;
    }

    /// Where the binding `idx` had outside the current function is kept.
    fn file_scope_state(&self, idx: usize) -> SavedAt {
        let s = &self.symbols[idx];
        let outer = self
            .block_scopes
            .iter()
            .enumerate()
            .find_map(|(level, saves)| {
                saves
                    .iter()
                    .position(|b| b.idx == idx)
                    .map(|at| (level, at))
            });
        let (class, global_register) = match outer {
            Some((level, at)) => self.block_scopes[level][at].class(),
            None => (s.class, s.is_global_register),
        };
        let top = (class == Token::Loc as i64 && !global_register) || s.is_scope_bound;
        match outer {
            _ if top => SavedAt::Top,
            Some((level, at)) => SavedAt::Block(level, at),
            None => SavedAt::Current,
        }
    }

    /// The binding saved at `at`: `Some(Some(entity))` for a function or
    /// library binding, `Some(None)` for none, `None` for another kind.
    fn saved_fn_entity(&self, idx: usize, at: SavedAt) -> Option<Option<super::stmt::FnEntity>> {
        let s = &self.symbols[idx];
        let e = match at {
            SavedAt::Top => super::stmt::FnEntity {
                class: s.h_class,
                type_: s.h_type,
                incomplete_enum_tag: s.h_incomplete_enum_tag,
                val: s.h_val,
                fn_type: s.h_fn_type.clone(),
                lineage: (s.h_fn_ptr_indirection, s.h_fn_ptr_ret_indirection),
                is_extern_decl: s.h_is_extern_decl,
            },
            SavedAt::Block(level, at) => self.block_scopes[level][at].fn_entity(),
            SavedAt::Current => return None,
        };
        if e.class == Token::Fun as i64
            || e.class == Token::Sys as i64
            || (e.class == 0 && s.scoped_fn_decl)
        {
            Some(Some(e))
        } else if e.class == 0 {
            Some(None)
        } else {
            None
        }
    }

    /// Leave the function entity `e` started by a declaration that hid
    /// another binding in the state the scope exits restore at `at`.
    fn keep_fn_entity(&mut self, idx: usize, at: SavedAt, e: &super::stmt::FnEntity) {
        let unbound = super::stmt::FnEntity {
            class: 0,
            ..e.clone()
        };
        match at {
            SavedAt::Top => {
                let s = &mut self.symbols[idx];
                s.h_type = unbound.type_;
                s.h_incomplete_enum_tag = unbound.incomplete_enum_tag;
                s.h_fn_type = unbound.fn_type;
                (s.h_fn_ptr_indirection, s.h_fn_ptr_ret_indirection) = unbound.lineage;
                s.h_is_extern_decl = unbound.is_extern_decl;
                s.h_asm_name = s.asm_name.clone();
            }
            SavedAt::Block(level, at) => self.block_scopes[level][at].set_fn_entity(&unbound),
            SavedAt::Current => {}
        }
    }

    /// Consume a run of storage-class specifiers, function specifiers and
    /// type qualifiers, folding them into the declaration's accumulators.
    /// C99 6.7.1 lets them appear before or after the type specifier, so
    /// the caller runs this on both sides of the base-type parse. Returns
    /// whether the run consumed anything.
    fn consume_local_decl_specifiers(
        &mut self,
        is_static: &mut bool,
        is_extern: &mut bool,
        is_thread_local: &mut bool,
        qual_bits: &mut i64,
    ) -> Result<bool, C5Error> {
        let mut saw = false;
        while self.lex.tk == Token::Extern
            || self.lex.tk == Token::Static
            || self.lex.tk == Token::ThreadLocal
            || self.lex.tk == Token::FuncSpec
            || self.lex.tk == Token::Noreturn
            || self.lex.tk == Token::TypeQual
        {
            if self.lex.tk == Token::Noreturn {
                self.pending.attrs.noreturn = true;
            }
            if self.lex.tk == Token::Static {
                *is_static = true;
            }
            if self.lex.tk == Token::Extern {
                *is_extern = true;
            }
            if self.lex.tk == Token::ThreadLocal {
                *is_thread_local = true;
            }
            if self.lex_is_register_storage() {
                self.pending.saw_register_storage = true;
            }
            // `volatile` qualifies the type (C99 6.7.3); `const` is recorded
            // out of band for value folding.
            *qual_bits |= self.lex_qualifier_bits();
            self.pending.base_is_const |= self.lex_is_const_qual();
            self.pending.spell_base_restrict |= self.lex_is_restrict_qual();
            self.pending.spell_base_const |= self.lex_is_const_qual();
            saw = true;
            self.next()?;
        }
        Ok(saw)
    }

    /// Push the persistent emission record of a block-scope static: a
    /// `name.<n>` internal symbol carrying the object's offset, extent,
    /// and `used` / `section` attributes past the scope-exit restore of
    /// the scoped binding (toolchains emit the same `name.N` locals).
    /// Function close stamps `owner_ent_pc`; static DCE then treats the
    /// object as a per-instance part of its function. A thread-local's
    /// record carries a TLS offset, which the `.data` passes pass over.
    pub(super) fn push_block_static_record(&mut self, loc_idx: usize, ty: i64) {
        let final_array = self.symbols[loc_idx].array_size;
        let fam_tail = self.symbols[loc_idx].fam_init_bytes;
        let zero_len = self.symbols[loc_idx].is_zero_len_array;
        // The extent is whatever the allocator reserved. Re-deriving it
        // from the type can overstate the reservation, and an overstated
        // extent claims bytes of the following object or padding.
        let reserved = self.symbols[loc_idx].reserved_data_bytes;
        // A GNU asm-label names the object outright, so it replaces the
        // disambiguating `name.N` rather than being suffixed: the label is
        // the assembler name the declaration asked for.
        let name = match &self.symbols[loc_idx].asm_name {
            Some(label) => label.clone(),
            None => alloc::format!(
                "{}.{}",
                self.symbols[loc_idx].name,
                self.next_block_static_id
            ),
        };
        self.next_block_static_id += 1;
        let hash = crate::c5::lexer::hash_name(name.as_bytes());
        let record_idx = self.symbols.len();
        let src = &self.symbols[loc_idx];
        self.symbols.push(crate::c5::symbol::Symbol {
            name,
            token: Token::Id as i64,
            class: Token::Glo as i64,
            type_: ty,
            val: src.val,
            array_size: final_array,
            is_zero_len_array: zero_len,
            reserved_data_bytes: reserved,
            fam_init_bytes: fam_tail,
            data_align: src.data_align,
            is_thread_local: src.is_thread_local,
            linkage: crate::c5::symbol::Linkage::Internal,
            defined_here: true,
            has_initializer: true,
            runtime_initialized: src.runtime_initialized,
            storage_is_const: src.storage_is_const,
            // Declaration shape and debug facts, so an `Expr::Ident`
            // routed to the record reads what the binding declared.
            fn_type: crate::c5::symbol::FnType {
                params: crate::c5::symbol::FnParams {
                    types: src.params().to_vec(),
                    variadic: src.is_variadic(),
                    ..Default::default()
                },
                ..Default::default()
            },
            fn_ptr_indirection: src.fn_ptr_indirection,
            fn_ptr_ret_indirection: src.fn_ptr_ret_indirection,
            inner_array_size: src.inner_array_size,
            array_dims: src.array_dims.clone(),
            type_align: src.type_align,
            is_const_qualified: src.is_const_qualified,
            const_object_value: src.const_object_value,
            binding: crate::c5::symbol::BindingInfo {
                decl_spelling: src.binding.decl_spelling,
                decl_line: src.binding.decl_line,
                decl_file: src.binding.decl_file,
                decl_in_user_source: src.binding.decl_in_user_source,
                ..Default::default()
            },
            ..Default::default()
        });
        self.symbols[loc_idx].entity_record = Some(record_idx as u32);
        self.symbol_index.record(hash);
        self.apply_symbol_attributes(record_idx);
        self.pending_block_static_syms.push(record_idx);
    }

    /// Record a deferred-size block-scope static's parsed element count,
    /// as the file-scope allocator does for `T x[] = { ... };`. An empty
    /// initializer yields a zero-length array, which reserves no storage;
    /// the placement model identifies objects by start offset, so it still
    /// takes a slot of its own rather than sharing the next object's.
    fn set_deferred_static_local_count(&mut self, loc_idx: usize, count: i64) {
        self.symbols[loc_idx].array_size = count;
        self.symbols[loc_idx].is_zero_len_array = count == 0;
        self.reserve_zero_length_array_slot(loc_idx);
    }

    /// Promote a `static T name [ = init];` local to a Glo-class symbol
    /// with persistent storage. C99 6.2.4p3: the storage lasts for the
    /// program run, so a later call re-enters the same slot, while the
    /// binding lives only inside the current function's scope, which the
    /// function-body cleanup pass restores. The initializer takes the
    /// file-scope rules.
    pub(super) fn allocate_static_local(
        &mut self,
        loc_idx: usize,
        ty: i64,
        array_size: i64,
    ) -> Result<(), C5Error> {
        // Storage. Mirrors run_compile's file-scope allocator. A
        // zero-sized object (empty struct, GNU) still reserves one slot:
        // the data-DCE interval model and the named-section carve
        // identify objects by start offset, so no two may share one.
        let mut bytes = if array_size > 0 {
            let total = (self.size_of_type(ty) as i64) * array_size;
            (((total + 7) / 8) * 8).max(8)
        } else if array_size == -1 {
            // Deferred-size array: handled below after parsing init.
            0
        } else {
            (self.slots_of_type(ty) * 8).max(8)
        };
        // A flexible array member's initialized elements occupy storage
        // past `sizeof`, as at file scope; without the reservation the
        // field fill writes over whatever follows in `.data`.
        let fam_tail = self.flexible_array_init_tail_bytes(ty)?;
        if fam_tail > 0 {
            self.symbols[loc_idx].fam_init_bytes = fam_tail;
            bytes = ((bytes + fam_tail + 7) / 8) * 8;
        }
        self.symbols[loc_idx].array_size = array_size.max(0);
        // A `static _Thread_local` local lives in the TLS block (`.tdata` /
        // `.tbss`), like a file-scope thread-local, not in `.data`. One with
        // an initializer is laid out in `.data` as a static local is, the
        // initializer's staging area, and moved to the TLS block after.
        let is_tls = self.symbols[loc_idx].is_thread_local;
        let staged = is_tls && self.lex.tk == Token::Assign;
        if array_size != -1 {
            let store = if is_tls && !staged {
                DataStore::ThreadLocal
            } else {
                DataStore::Static
            };
            let align = self.static_local_placement_align(loc_idx, ty);
            let off = self.reserve_data_bytes(store, align, bytes as usize);
            self.symbols[loc_idx].val = off;
            if !is_tls || staged {
                self.symbols[loc_idx].reserved_data_bytes = bytes;
            }
        }
        if self.lex.tk == Token::Assign {
            self.next()?;
            self.parse_static_local_initializer(loc_idx, ty, array_size)?;
            if staged {
                let align = self.static_local_placement_align(loc_idx, ty);
                self.move_to_thread_local_storage(loc_idx, align)?;
            }
        }
        Ok(())
    }

    /// The initializer of a static local, entered past its `=`: the
    /// file-scope forms, into the storage reserved in `.data` (reserved
    /// here for a deferred-size array).
    fn parse_static_local_initializer(
        &mut self,
        loc_idx: usize,
        ty: i64,
        array_size: i64,
    ) -> Result<(), C5Error> {
        // A `&&label` element (GCC labels as values) is a link-time
        // constant: the data image gets a label relocation, as it
        // does for `&func`. Only a genuinely non-constant element
        // alongside one still needs stores at the declaration point.
        if self.lex.tk == '{'
            && self.array_init_has_label_addr()?
            && self.array_init_needs_runtime()?
        {
            if self.symbols[loc_idx].is_thread_local {
                return Err(self.compile_err(
                    Code::UNSUPPORTED,
                    "a label address in a `_Thread_local` initializer is not supported",
                ));
            }
            return self.emit_static_array_init_runtime(loc_idx, ty, array_size);
        }
        if array_size == -1 {
            if self.is_traversable_aggregate_ty(ty) {
                // Static-local of struct array, deferred size:
                // `static struct T xs[] = { {...}, {...}, ... };`
                // Pre-scan the source for the element count so
                // each element's storage stays contiguous even if
                // an element's parse appends a string literal to
                // `self.data`.
                let elem_size = self.size_of_type(ty);
                if self.lex.tk != '{' {
                    return Err(self.compile_err(
                        Code::INVALID_INITIALIZER,
                        "array initializer must start with `{`",
                    ));
                }
                // Rows below the outer (deferred) dimension: `T xs[][M]`.
                let inner_dims = self.inner_dims_of(loc_idx);
                let inner_dim = inner_dims.iter().product::<i64>().max(1);
                let rows = self.struct_array_init_rows(ty, &inner_dims)?;
                // Reserve before consuming `{`: lexing the first element
                // token may append a string literal's bytes, whose
                // parser-added NUL must land right after them.
                let reserved = rows * inner_dim * elem_size as i64;
                let align = self.static_local_placement_align(loc_idx, ty);
                let off = self.reserve_data_bytes(DataStore::Static, align, reserved as usize);
                self.symbols[loc_idx].val = off;
                self.symbols[loc_idx].reserved_data_bytes = reserved;
                let mut dims = alloc::vec![rows];
                dims.extend_from_slice(&inner_dims);
                self.collect_struct_array_data(ty, off, &dims)?;
                self.set_deferred_static_local_count(loc_idx, rows * inner_dim);
                if let Some(first) = self.symbols[loc_idx].array_dims.first_mut()
                    && *first == 0
                {
                    *first = rows;
                }
                while !self.data.len().is_multiple_of(8) {
                    self.data.push(0);
                }
                return Ok(());
            }
            let inner_dims = self.inner_dims_of(loc_idx);
            self.pending.init_inner_dims = inner_dims.clone();
            let mut elements = self.collect_array_initializer(ty, self.elem_fn_type(loc_idx))?;
            let final_size = Self::deferred_array_count(&mut elements, &inner_dims);
            let total_bytes = (self.size_of_type(ty) as i64) * final_size;
            let aligned = ((total_bytes + 7) / 8) * 8;
            let align = self.static_local_placement_align(loc_idx, ty);
            let off = self.reserve_data_bytes(DataStore::Static, align, aligned as usize);
            self.symbols[loc_idx].val = off;
            self.symbols[loc_idx].reserved_data_bytes = aligned;
            self.write_array_init_into_data(off, ty, &elements)?;
            self.set_deferred_static_local_count(loc_idx, final_size);
        } else if array_size > 0 && self.is_traversable_aggregate_ty(ty) {
            // Known-size static-local array of structs: the shared
            // struct-array walker fills the brace list (designators at
            // every level, positional resume at the designated rank,
            // C99 6.7.8p17); the generic array collector below would
            // treat the struct element as a scalar and write past the
            // pre-allocated region.
            let var_offset = self.symbols[loc_idx].val;
            let inner_dims = self.inner_dims_of(loc_idx);
            let inner_product: i64 = inner_dims.iter().product::<i64>().max(1);
            let group_count = array_size / inner_product;
            if self.lex.tk != '{' {
                return Err(self.compile_err(
                    Code::INVALID_INITIALIZER,
                    "array initializer must start with `{`",
                ));
            }
            self.next()?;
            let mut full_dims = alloc::vec::Vec::with_capacity(inner_dims.len() + 1);
            full_dims.push(group_count);
            full_dims.extend_from_slice(&inner_dims);
            self.collect_struct_array_entries(ty, var_offset, &full_dims)?;
        } else if array_size > 0 {
            self.pending.init_inner_dims = self.inner_dims_of(loc_idx);
            self.pending.init_target_array_size = array_size;
            let elements = self.collect_array_initializer(ty, self.elem_fn_type(loc_idx))?;
            // C99 6.7.8p2: the initializer may not provide a value for an
            // object outside the entity being initialized. The storage
            // reserved above holds `array_size` elements, so a longer list
            // would be written past it (the file-scope, automatic and
            // compound-literal paths reject it here too).
            if elements.len() as i64 > array_size {
                return Err(self.compile_err(
                    Code::INVALID_INITIALIZER,
                    format!(
                        "too many initializers for array `{}` ({} > {})",
                        self.symbols[loc_idx].name,
                        elements.len(),
                        array_size
                    ),
                ));
            }
            let var_offset = self.symbols[loc_idx].val;
            self.write_array_init_into_data(var_offset, ty, &elements)?;
        } else if self.is_traversable_aggregate_ty(ty) {
            let sid = struct_id_of(ty);
            let var_offset = self.symbols[loc_idx].val;
            // C99 6.5.2.5: `static T s = (T){ ... };` names its own
            // type; drop the redundant cast so the brace list fills
            // the struct, matching the file-scope allocator.
            self.skip_opt_compound_literal_cast()?;
            let cl_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            self.collect_struct_initializer(sid, var_offset)?;
            for _ in 0..cl_parens {
                self.accept(')')?;
            }
        } else {
            let var_offset = self.symbols[loc_idx].val;
            let target_fn = self.object_fn_type(loc_idx);
            self.parse_global_initializer(ty, var_offset, false, &target_fn)?;
        }

        Ok(())
    }

    /// Feed the token about to be consumed to an [`OperandScan`], supplying
    /// the typedef-name fact the scan cannot get from the token alone.
    fn operand_scan_advance(&self, scan: &mut OperandScan) {
        scan.advance(self.lex.tk, self.is_lex_typedef_name());
    }

    /// True if the brace-list array initializer at the current `{`
    /// contains a `&&label` element at the top level. Restores the
    /// lexer so the caller re-parses the list from the `{`.
    pub(super) fn array_init_has_label_addr(&mut self) -> Result<bool, C5Error> {
        debug_assert!(self.lex.tk == '{');
        let snap = self.lex.snapshot();
        let data_snap = self.data.len();
        self.next()?; // consume `{`
        let mut depth: i64 = 1;
        let mut found = false;
        let mut scan = OperandScan::new();
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '{' {
                depth += 1;
            } else if self.lex.tk == '}' {
                depth -= 1;
            } else if self.lex.tk == Token::Lan && !scan.ends_operand() {
                found = true;
                break;
            }
            self.operand_scan_advance(&mut scan);
            self.next()?;
        }
        self.rewind_speculation(snap, data_snap);
        Ok(found)
    }

    /// Fill a static-local array whose initializer mixes a `&&label`
    /// element with one only the running program can value, using
    /// runtime stores at the declaration point. The data image holds
    /// zeros and each element is parsed through the expression grammar,
    /// so `&&label` yields a block address. An initializer whose
    /// elements are all link-time constants takes the data image instead.
    ///
    /// C99 6.2.4p3 gives static storage duration one initialization per
    /// program run, so the stores sit behind a guard byte placed directly
    /// after the array's storage -- the same data object, so data DCE and
    /// the linker rebase move it with the array. The declaration lowers
    /// to one statement, `guard ? 0 : (e0, ..., en, guard = 1)`.
    pub(super) fn emit_static_array_init_runtime(
        &mut self,
        loc_idx: usize,
        ty: i64,
        array_size: i64,
    ) -> Result<(), C5Error> {
        self.symbols[loc_idx].runtime_initialized = true;
        let elem_size = self.size_of_type(ty) as i64;
        let count = if array_size > 0 {
            array_size
        } else {
            // Deferred size: count the elements and reserve zeroed storage.
            let (c, _) = self.scan_array_init()?;
            let align = self.static_local_placement_align(loc_idx, ty);
            let off = self.reserve_data_bytes(DataStore::Static, align, (c * elem_size) as usize);
            self.symbols[loc_idx].val = off;
            self.symbols[loc_idx].array_size = c;
            while !self.data.len().is_multiple_of(8) {
                self.data.push(0);
            }
            // The once-guard below sits past the object's extent.
            self.symbols[loc_idx].reserved_data_bytes = self.data.len() as i64 - off;
            c
        };
        let guard_off = self.data.len() as i64 - self.symbols[loc_idx].val;
        for _ in 0..8 {
            self.data.push(0);
        }
        debug_assert!(self.lex.tk == '{');
        self.next()?; // consume `{`
        // The array Ident decays to its base address; the index is the
        // element's byte offset, matching the walker's pre-scaled
        // `Expr::Index` convention.
        let arr_ty = ty + Ty::Ptr as i64;
        let mut assigns: alloc::vec::Vec<super::super::ast::ExprId> = alloc::vec::Vec::new();
        let mut i: i64 = 0;
        while self.lex.tk != '}' {
            // Optional designator: `[N] = ...` (C99 6.7.8p6) or the GCC
            // range form `[a ... b] = ...`. Sets the write cursor; a
            // range fills every slot in `[a, b]` with the same value.
            let mut range_end = i;
            if self.lex.tk == Token::Brak {
                let sub = self.take_designator_subscript(DesignatorRule::Ordered)?;
                self.expect_designator_close()?;
                self.expect_designator_assign()?;
                i = sub.lo;
                range_end = sub.hi;
            }
            if range_end >= count {
                return Err(self.compile_err(
                    Code::INVALID_INITIALIZER,
                    format!("too many initializers for `{}`", self.symbols[loc_idx].name),
                ));
            }
            if self.lex.tk == '{' {
                // TODO: descend into a brace-enclosed element and store it
                // field by field. Only a non-constant element reaches here,
                // so the list is one whose elements need runtime stores.
                return Err(self.compile_err(
                    Code::UNSUPPORTED,
                    format!(
                        "brace-enclosed element in the runtime-initialized static \
                     array `{}` is not yet supported",
                        self.symbols[loc_idx].name
                    ),
                ));
            }
            let line = self.lex.line;
            self.expr(Token::Assign as i64)?;
            self.check_initializer_expr(ty, 0, line)?;
            if let Some(rhs) = self.ast_acc.take() {
                // Fill `[i, range_end]`. A range reuses the value node;
                // the walker re-walks it per store, which is safe for the
                // side-effect-free constant / label-address values a
                // static initializer holds.
                for slot in i..=range_end {
                    let array_id = self.ast_emit_ident(loc_idx as u32, arr_ty);
                    let idx_id = self.ast_emit_int_lit(slot * elem_size, Ty::Int as i64);
                    let pos = self.ast_src_pos();
                    let index_id = self.ast.push_expr(
                        super::super::ast::Expr::Index {
                            array: array_id,
                            idx: idx_id,
                            ty,
                        },
                        pos,
                    );
                    let assign_id = self.ast.push_expr(
                        super::super::ast::Expr::Assign {
                            lhs: index_id,
                            rhs,
                            ty,
                        },
                        pos,
                    );
                    assigns.push(assign_id);
                }
            }
            i = range_end + 1;
            self.list_separator('}', "initializer")?;
        }
        self.next()?; // consume `}`
        if let Some(&first) = assigns.first() {
            use super::super::ast::Expr;
            let g_ty = Ty::Char as i64;
            let guard_at = |c: &mut Self| {
                let base = c.ast_emit_ident(loc_idx as u32, arr_ty);
                let idx = c.ast_emit_int_lit(guard_off, Ty::Int as i64);
                let pos = c.ast_src_pos();
                c.ast.push_expr(
                    Expr::Index {
                        array: base,
                        idx,
                        ty: g_ty,
                    },
                    pos,
                )
            };
            let guard_read = guard_at(self);
            let guard_lhs = guard_at(self);
            let one = self.ast_emit_int_lit(1, Ty::Int as i64);
            let pos = self.ast_src_pos();
            let guard_set = self.ast.push_expr(
                Expr::Assign {
                    lhs: guard_lhs,
                    rhs: one,
                    ty: g_ty,
                },
                pos,
            );
            let mut chain = first;
            for &e in assigns.iter().skip(1).chain(core::iter::once(&guard_set)) {
                chain = self.ast.push_expr(
                    Expr::Comma {
                        lhs: chain,
                        rhs: e,
                        ty: g_ty,
                    },
                    pos,
                );
            }
            let zero = self.ast_emit_int_lit(0, Ty::Int as i64);
            let guarded = self.ast.push_expr(
                Expr::Ternary {
                    cond: guard_read,
                    then_e: zero,
                    else_e: chain,
                    ty: Ty::Int as i64,
                    elvis: false,
                },
                pos,
            );
            self.ast
                .push_stmt(super::super::ast::Stmt::Expr(guarded), pos);
        }
        self.ast_acc = None;
        Ok(())
    }

    /// C99 6.7.6.2 variable-length array local. Reserves two hidden
    /// frame slots -- the runtime base pointer and the runtime byte
    /// count -- and records a `Decl::Vla`; the walker allocates the
    /// storage from the per-frame alloca arena. The array is not
    /// promotable and its storage is reclaimed on block exit by the
    /// scope bracket `parse_block_stmt` emits.
    fn allocate_vla_local(
        &mut self,
        loc_idx: usize,
        elem_ty: i64,
        fill: Option<u8>,
    ) -> Result<(), C5Error> {
        // C99 6.7.8p3: a VLA declaration may not carry an initializer.
        if self.lex.tk == Token::Assign {
            return Err(self.compile_err(
                Code::INVALID_INITIALIZER,
                "a variable-length array may not have an initializer",
            ));
        }
        let dim = match self.pending.vla_dim_expr.take() {
            Some(d) => d,
            None => {
                return Err(self.compile_err(
                    Code::INVALID_DECLARATION,
                    "variable-length array has no dimension",
                ));
            }
        };
        let ptr_slot = self.reserve_slots(1);
        let size_slot = self.reserve_slots(1);
        let elem_size = self.size_of_type(elem_ty) as i64;
        let s = &mut self.symbols[loc_idx];
        s.is_vla = true;
        s.type_ = elem_ty;
        s.array_size = 0;
        s.vla_ptr_slot = ptr_slot;
        s.vla_size_slot = size_slot;
        s.binding.was_written = true;
        s.binding.address_escaped = true;
        self.func_vla_decls += 1;
        self.note_jump_barrier(loc_idx, true);
        // The VLA storage comes from the per-frame alloca arena, so the
        // function reserves the arena and its bookkeeping slot.
        self.uses_alloca_in_current_fn = true;
        self.ast_emit_vla_decl(super::super::ast::Decl::Vla {
            sym: loc_idx as u32,
            elem_ty,
            elem_size,
            ptr_slot,
            size_slot,
            dim,
            fill,
            align: 0,
        });
        Ok(())
    }

    /// The rows of `inner_dims` an array of unknown size of `elem_ty` takes
    /// from the brace list at the current `{`: as many as its fill reaches
    /// (C99 6.7.8p20-p22). The fill skips the values over a scratch data
    /// tail with a row for each entry and is rolled back with what it
    /// reported and the literals it named; a list it rejects keeps that bound.
    pub(super) fn struct_array_init_rows(
        &mut self,
        elem_ty: i64,
        inner_dims: &[i64],
    ) -> Result<i64, C5Error> {
        debug_assert!(self.lex.tk == '{');
        let items = self.lex.count_top_level_items_in_array() as i64;
        let bound = self.designated_array_count(items, 1, None)?.max(items);
        let span = inner_dims.iter().product::<i64>().max(1);
        let (cp, reported) = (self.init_checkpoint(), self.sink.mark());
        let (literals, overruns) = (
            self.next_compound_literal_id,
            self.warned_string_overruns.clone(),
        );
        let measuring = core::mem::replace(&mut self.measuring_init, true);
        let scratch = self.data.len();
        let bytes = (bound * span) as usize * self.size_of_type(elem_ty);
        self.data.resize(scratch + bytes, 0);
        let mut dims = alloc::vec![bound];
        dims.extend_from_slice(inner_dims);
        let reached = self
            .next()
            .and_then(|()| self.collect_struct_array_entries(elem_ty, scratch as i64, &dims));
        self.measuring_init = measuring;
        self.restore_init_checkpoint(cp);
        self.sink.rollback(reported);
        (self.next_compound_literal_id, self.warned_string_overruns) = (literals, overruns);
        Ok(reached.map_or(bound, |high| (high + span - 1) / span))
    }

    /// Stage the constant image of an array-of-aggregate compound literal
    /// over `rows` outer elements and Mcpy its `bytes` into frame slot
    /// `slot`. The block is reserved before the list is parsed: an
    /// element's string-literal field appends to the data segment and
    /// would otherwise shift the elements after it. Omitted positions
    /// keep the zero fill (C99 6.7.8p21).
    fn stage_struct_array_literal(
        &mut self,
        slot: i64,
        elem_ty: i64,
        rows: i64,
        inner_dims: &[i64],
        bytes: usize,
    ) -> Result<(), C5Error> {
        let staged = self.stage_template_bytes(bytes);
        let mut dims = alloc::vec::Vec::with_capacity(inner_dims.len() + 1);
        dims.push(rows);
        dims.extend_from_slice(inner_dims);
        self.collect_struct_array_data(elem_ty, staged as i64, &dims)?;
        self.emit_local_array_init(slot, staged, bytes);
        Ok(())
    }

    /// Try to fold a `const` scalar arithmetic auto local's initializer
    /// to a constant of the declared type, mirroring the value GCC's
    /// case-label / `static_assert` fold reads. The lexer is at the `=`;
    /// the parse is speculative and fully rolled back so the normal
    /// initializer path re-parses and emits the store. `None` when the
    /// initializer is not a constant arithmetic expression (a runtime
    /// value, an address, a string literal).
    fn try_fold_const_object_init(
        &mut self,
        ty: i64,
    ) -> Result<Option<crate::c5::symbol::ConstObjectValue>, C5Error> {
        use super::const_expr::ConstVal;
        use crate::c5::symbol::ConstObjectValue;
        let cp = self.init_checkpoint();
        self.next()?; // `=`
        // C99 6.7.8p11: a scalar initializer may be brace-wrapped.
        let braced = self.lex.tk == '{';
        if braced {
            self.next()?;
        }
        // Chains fold too (`const unsigned a = 5; const unsigned b = a;`),
        // so the recording parse runs with the object fold enabled.
        self.const_object_fold += 1;
        let v = self.parse_const_expr_cond_val();
        self.const_object_fold -= 1;
        let mut ended = v.is_ok();
        if ended && braced {
            if self.lex.tk == ',' {
                ended = self.next().is_ok();
            }
            ended = ended && self.lex.tk == '}' && self.next().is_ok();
        }
        ended = ended && (self.lex.tk == ',' || self.lex.tk == ';');
        let rec = match v {
            Ok(val) if ended => match val {
                // An `Int` carrying a pointer type is a staged address
                // (a string literal's data offset), not a value.
                ConstVal::Int { ty: vty, .. } if is_pointer_ty(vty) => None,
                ConstVal::Int { .. } | ConstVal::Float { .. } => {
                    if super::types::is_floating_scalar(ty) {
                        let f = val.as_float();
                        let f = if self.size_of_type(ty) == 4 {
                            f as f32 as f64
                        } else {
                            f
                        };
                        Some(ConstObjectValue::FloatBits(f.to_bits()))
                    } else {
                        // Convert to the declared type (C99 6.7.8p11).
                        let bytes = self.size_of_type(ty);
                        let is_bool = super::types::strip_unsigned(ty) == Ty::Bool as i64;
                        Some(ConstObjectValue::Int(super::types::narrow_const_int(
                            bytes,
                            super::types::is_unsigned_ty(ty),
                            is_bool,
                            val.as_i128(),
                        ) as i64))
                    }
                }
                _ => None,
            },
            _ => None,
        };
        self.pending.const_expr_nonconst = false;
        self.restore_init_checkpoint(cp);
        Ok(rec)
    }

    /// Reserve frame storage for a local declarator and emit any
    /// initializer that follows, in three shapes: a non-array object of
    /// `slots_of_type(ty)` slots, a known-size array, and a
    /// deferred-size array whose initializer settles the dimension
    /// before the storage is reserved. C99 6.7.8p21 zero-fills the
    /// positions an initializer leaves; an uninitialized object keeps
    /// whatever the frame held, subject to
    /// `-ftrivial-auto-var-init`.
    pub(super) fn allocate_local_with_init(
        &mut self,
        loc_idx: usize,
        ty: i64,
        declared_array_size: i64,
        zero_len: bool,
        fill: Option<u8>,
    ) -> Result<(), C5Error> {
        if declared_array_size == super::VLA_ARRAY_SIZE {
            return self.allocate_vla_local(loc_idx, ty, fill);
        }
        // C99 6.7.9: an initializer at the declaration site counts
        // as a store from the perspective of the dead-store
        // analysis. Mark before parsing the initializer so
        // every shape below (scalar, array, struct, deferred-
        // size) routes through the same flag without per-branch
        // bookkeeping.
        if self.lex.tk == Token::Assign {
            self.symbols[loc_idx].binding.was_written = true;
            self.record_local_store(loc_idx, self.lex.line);
        }
        if declared_array_size == -1 {
            return self.allocate_deferred_size_local(loc_idx, ty, zero_len, fill);
        }

        self.symbols[loc_idx].array_size = declared_array_size;
        self.symbols[loc_idx].val =
            self.reserve_slots(self.local_storage_slots(ty, declared_array_size));

        if self.lex.tk == Token::Assign {
            self.next()?;
            let local_val = self.symbols[loc_idx].val;
            if declared_array_size > 0 {
                let var_name = self.symbols[loc_idx].name.clone();
                // Known-size local array of structs:
                // `struct T xs[N] = { {...}, ... };`. C99 6.7.8p18
                // lets each element be a brace-enclosed
                // initializer; the `collect_array_initializer`
                // path handles scalar / string elements, not
                // nested struct braces. Stage each element's
                // bytes in `self.data` and Mcpy the block into
                // the local slot.
                if self.is_traversable_aggregate_ty(ty) && self.lex.tk == '{' {
                    return self.init_local_struct_array(
                        loc_idx,
                        ty,
                        declared_array_size,
                        local_val,
                        &var_name,
                    );
                }
                // C99 6.7.8 lets auto-storage local arrays carry
                // initializers with non-constant expressions
                // ("dynamic initialization"). The pre-scan looks
                // for any identifier referring to a Loc symbol or
                // any indexed / called / address-taken shape that
                // can't fold at compile time; if found, switch to
                // the per-element runtime store path. Pure-constant
                // initializers keep the Mcpy-from-data fast path
                // and the staged on-disk image stays compact.
                let elem_size = self.size_of_type(ty);
                let full_bytes = elem_size * declared_array_size as usize;
                if self.lex.tk == '{' && self.array_init_needs_runtime()? {
                    // C99 6.7.9p21: trailing positions in a
                    // partially-initialized array receive
                    // static-storage zero-init. Seed the slot
                    // with a Mcpy from a staged zero block
                    // before the per-element runtime stores
                    // overlay the explicit prefix.
                    let zero_off = self.stage_template_bytes(full_bytes);
                    self.emit_local_array_init(local_val, zero_off, full_bytes);
                    let inner = self.inner_dims_of(loc_idx);
                    self.emit_local_array_init_runtime(
                        local_val,
                        0,
                        (ty, self.elem_fn_type(loc_idx)),
                        declared_array_size,
                        &inner,
                        &var_name,
                    )?;
                    return Ok(());
                }
                self.pending.init_inner_dims = self.inner_dims_of(loc_idx);
                self.pending.init_target_array_size = declared_array_size;
                let elements = self.collect_array_initializer(ty, self.elem_fn_type(loc_idx))?;
                let init_count = elements.len();
                let max = declared_array_size as usize;
                if init_count > max {
                    return Err(self.compile_err(
                        Code::INVALID_INITIALIZER,
                        format!(
                            "too many initializers for array `{}` ({} > {})",
                            var_name, init_count, max
                        ),
                    ));
                }
                let (start_addr, packed_bytes) = self.pack_initializer_into_data(ty, &elements)?;
                // C99 6.7.9p21: when the brace list specifies
                // fewer elements than the declared dimension, the
                // remaining positions receive static-storage
                // zero-init. Pad the staged block with zeros so
                // the single Mcpy covers the entire array.
                let total_bytes = if packed_bytes < full_bytes {
                    for _ in 0..(full_bytes - packed_bytes) {
                        self.data.push(0);
                    }
                    full_bytes
                } else {
                    packed_bytes
                };
                self.emit_local_array_init(local_val, start_addr, total_bytes);
            } else if self.is_traversable_aggregate_ty(ty) && self.lex.tk == '{' {
                // Local struct value with brace-list initializer.
                // C99 6.7.8p13: every entry may be a non-constant
                // expression. Pre-scan the brace list; if all
                // entries fold to compile-time constants, stage
                // the bytes in `self.data` and Mcpy them into the
                // local slot (fast, single transfer). Otherwise
                // first Mcpy zeros into the slot to implement the
                // "omitted fields are zero" rule (6.7.8p19), then
                // emit per-field runtime stores for each entry.
                let sid = struct_id_of(ty);
                let needs_runtime = self.struct_init_needs_runtime()?;
                let elem_size = self.size_of_type(ty);
                let staged_off = self.stage_template_bytes(elem_size);
                if needs_runtime {
                    self.emit_local_array_init(local_val, staged_off, elem_size);
                    self.emit_struct_runtime_at(local_val, 0, sid, true)?;
                } else {
                    self.collect_struct_initializer(sid, staged_off as i64)?;
                    self.emit_local_array_init(local_val, staged_off, elem_size);
                }
            } else {
                let target_fn = self.object_fn_type(loc_idx);
                self.emit_local_init_store(local_val, ty, target_fn)?;
            }
        } else {
            self.emit_auto_var_fill(loc_idx, ty, declared_array_size > 0, fill);
        }
        Ok(())
    }

    /// A deferred-size automatic array (`T x[] = ...`): the element count
    /// comes from the initializer, so the frame slot is reserved after it is
    /// parsed (C99 6.7.8p22). Also covers the GNU `T x[0]` and the
    /// initializer-less `T x[]` a declarator completes to one element;
    /// `zero_len` tells the first from the second.
    fn allocate_deferred_size_local(
        &mut self,
        loc_idx: usize,
        ty: i64,
        zero_len: bool,
        fill: Option<u8>,
    ) -> Result<(), C5Error> {
        if self.lex.tk != Token::Assign {
            // GCC zero-length array `T x[0]`: a complete type holding no
            // elements, so `sizeof` is 0. Used by compile-time-assert
            // idioms such as `char ok[-offsetof(type, f)]` and by
            // conditionally-empty buffers whose guards read
            // `sizeof(buf) != 0`. Recorded with the same zero-count
            // encoding `T x[] = {}` uses; a slot is still reserved so
            // the object has an address of its own.
            //
            // TODO: empty brackets with no initializer leave the type
            // incomplete (C99 6.7.5.2p4); the bound is completed to one
            // element rather than diagnosed.
            self.symbols[loc_idx].array_size = if zero_len { 0 } else { 1 };
            self.symbols[loc_idx].is_zero_len_array = zero_len;
            self.symbols[loc_idx].val = self.reserve_slots(self.local_storage_slots(ty, 1));
            self.emit_auto_var_fill(loc_idx, ty, true, fill);
            return Ok(());
        }
        self.next()?;
        // Deferred-size local array of structs: `struct T xs[] = { {...}, ... };`.
        // Stage each element in self.data, count them, then
        // reserve one stack frame slot block and Mcpy the
        // staged bytes into it.
        if self.is_traversable_aggregate_ty(ty) && self.lex.tk == '{' {
            // Local deferred-size struct array. Same
            // scan-then-pre-allocate sequence as the
            // file-scope path so an element's string-literal
            // field doesn't shift the next element off its
            // expected offset.
            let elem_size = self.size_of_type(ty);
            // C99 6.7.8p13: an automatic-storage struct array may
            // carry non-constant element initializers (`&local`, a
            // call, an indexed read). The constant stage-into-data +
            // Mcpy path below cannot represent those, so route to the
            // per-element runtime store path the known-size branch
            // uses. Mirrors the `struct V xs[N] = { ... }` handling.
            // Elements below a deferred outer dimension: for `T xs[][M]`
            // the list fills rows of `inner_dim` elements, as many as it
            // reaches (C99 6.7.8p22), within the storage of a bound.
            let inner_dims: alloc::vec::Vec<i64> = self.symbols[loc_idx]
                .array_dims
                .get(1..)
                .map(|s| s.to_vec())
                .unwrap_or_default();
            let inner_dim: i64 = inner_dims.iter().product::<i64>().max(1);
            let bound = self.struct_array_init_rows(ty, &inner_dims)?;
            let total = bound * inner_dim;
            let rows_of = |reached: i64| (reached + inner_dim - 1) / inner_dim;
            if self.struct_init_needs_runtime()? {
                self.symbols[loc_idx].val = self.reserve_slots(self.local_storage_slots(ty, total));
                let local_val = self.symbols[loc_idx].val;
                let var_name = self.symbols[loc_idx].name.clone();
                // Zero the whole slot (6.7.8p19 omitted-entries rule),
                // then overlay each element's explicit fields through
                // the shared runtime walker.
                let zero_off = self.stage_template_bytes(total as usize * elem_size);
                self.emit_local_array_init(local_val, zero_off, total as usize * elem_size);
                let reached = self.emit_local_array_init_runtime(
                    local_val,
                    0,
                    (ty, None),
                    total,
                    &inner_dims,
                    &var_name,
                )?;
                let rows = rows_of(reached);
                self.symbols[loc_idx].array_size = rows * inner_dim;
                if let Some(first) = self.symbols[loc_idx].array_dims.first_mut()
                    && *first == 0
                {
                    *first = rows;
                }
                return Ok(());
            }
            // Reserve the staged block before consuming `{`: lexing the
            // first element token may append a string literal's bytes,
            // whose parser-added NUL must land right after them, not
            // inside or past the block.
            let staged_off = self.stage_template_bytes((total * elem_size as i64) as usize);
            let mut dims = alloc::vec::Vec::with_capacity(inner_dims.len() + 1);
            dims.push(bound);
            dims.extend_from_slice(&inner_dims);
            self.consume(b'{', "array initializer must start with `{`")?;
            let rows = rows_of(self.collect_struct_array_entries(ty, staged_off as i64, &dims)?);
            let total = rows * inner_dim;
            self.symbols[loc_idx].array_size = total;
            self.symbols[loc_idx].val = self.reserve_slots(self.local_storage_slots(ty, total));
            let local_val = self.symbols[loc_idx].val;
            self.emit_local_array_init(local_val, staged_off, elem_size * total as usize);
            if let Some(first) = self.symbols[loc_idx].array_dims.first_mut()
                && *first == 0
            {
                *first = rows;
            }
            return Ok(());
        }
        // Deferred-size local scalar / pointer array. Pre-scan
        // the brace list to learn the element count (so storage
        // can be reserved before parsing each element) and
        // whether any element is non-constant. The latter
        // routes through the per-element runtime store path
        // required by C99 6.7.8p13 -- automatic-storage
        // arrays may carry non-constant initializers, with
        // each element initialised as if by assignment in
        // declaration order.
        if self.lex.tk == '{' {
            let (scan_count, needs_runtime) = self.scan_array_init()?;
            if needs_runtime {
                // C99 6.7.8p22: `[N]` / `[lo ... hi]` designators can
                // push the size past the positional entry count; a row
                // of a multi-dimensional array counts once per entry.
                let inner = self.inner_dims_of(loc_idx);
                let inner_span: i64 = inner.iter().product::<i64>().max(1);
                let fallback = if inner_span > 1 { 0 } else { scan_count };
                let string_rows = self.string_rows(ty, &inner);
                let rows = self.designated_array_count(fallback, inner_span, string_rows)?;
                let final_size = rows * inner_span;
                self.symbols[loc_idx].array_size = final_size;
                self.symbols[loc_idx].val =
                    self.reserve_slots(self.local_storage_slots(ty, final_size));
                let local_val = self.symbols[loc_idx].val;
                let var_name = self.symbols[loc_idx].name.clone();
                // C99 6.7.8p21: positions a designator skips receive
                // static-storage zero-init. Seed the slot from a staged
                // zero block before the per-element stores.
                let full_bytes = self.size_of_type(ty) * final_size.max(0) as usize;
                let zero_off = self.stage_template_bytes(full_bytes);
                self.emit_local_array_init(local_val, zero_off, full_bytes);
                self.emit_local_array_init_runtime(
                    local_val,
                    0,
                    (ty, self.elem_fn_type(loc_idx)),
                    final_size,
                    &inner,
                    &var_name,
                )?;
                return Ok(());
            }
            // Constant path: keep matching the legacy flow
            // exactly -- allocate from the parsed element count
            // (mirrors `let final_size = elements.len()` below)
            // rather than the pre-scanned count, so behaviour is
            // identical to before this fix when no runtime
            // expressions are present.
        }
        let inner_dims = self.inner_dims_of(loc_idx);
        self.pending.init_inner_dims = inner_dims.clone();
        let mut elements = self.collect_array_initializer(ty, self.elem_fn_type(loc_idx))?;
        let final_size = Self::deferred_array_count(&mut elements, &inner_dims);
        self.symbols[loc_idx].array_size = final_size;
        self.symbols[loc_idx].val = self.reserve_slots(self.local_storage_slots(ty, final_size));
        let local_val = self.symbols[loc_idx].val;
        let (start_addr, total_bytes) = self.pack_initializer_into_data(ty, &elements)?;
        self.emit_local_array_init(local_val, start_addr, total_bytes);
        Ok(())
    }

    /// A known-size automatic array of aggregates:
    /// `struct T xs[N] = { {...}, ... };`. C99 6.7.8p18 lets each element be
    /// brace-enclosed and 6.7.8p20 lets the braces be elided; the staged
    /// template is copied into the frame slot, with per-element stores where
    /// an entry is not a constant.
    fn init_local_struct_array(
        &mut self,
        loc_idx: usize,
        ty: i64,
        declared_array_size: i64,
        local_val: i64,
        var_name: &str,
    ) -> Result<(), C5Error> {
        let elem_size = self.size_of_type(ty);
        // Pre-scan each element's brace list: if any
        // value isn't a compile-time constant, take
        // the per-field runtime store path. Mirrors
        // the single-struct branch below.
        // The struct-init scan walks balanced braces
        // with a depth counter, so a `{ {...}, {...} }`
        // outer brace list works the same way as a
        // single-struct `{ ... }` initializer.
        let needs_runtime = self.struct_init_needs_runtime()?;
        let staged_off = self.stage_template_bytes(declared_array_size as usize * elem_size);
        if needs_runtime {
            // Zero the entire array slot in one Mcpy
            // (the "omitted entries are zero" rule of
            // 6.7.8p19), then walk the brace list and
            // emit per-element runtime stores into
            // `&local + i*elem_size + field.offset`.
            self.emit_local_array_init(
                local_val,
                staged_off,
                elem_size * declared_array_size as usize,
            );
            // The shared runtime walker recurses per inner
            // dimension and dispatches struct elements, so a
            // multi-dimensional struct array fills row by row.
            let inner = self.inner_dims_of(loc_idx);
            self.emit_local_array_init_runtime(
                local_val,
                0,
                (ty, None),
                declared_array_size,
                &inner,
                var_name,
            )?;
            return Ok(());
        }
        // The constant image goes through the static walker: a
        // multi-dimensional array's dimensions, designators and brace
        // elision are laid out as for a static object (C99 6.7.8).
        let mut dims = self.inner_dims_of(loc_idx);
        let inner_product: i64 = dims.iter().product::<i64>().max(1);
        dims.insert(0, declared_array_size / inner_product);
        self.next()?; // consume outer `{`
        self.collect_struct_array_entries(ty, staged_off as i64, &dims)?;
        self.emit_local_array_init(
            local_val,
            staged_off,
            elem_size * declared_array_size as usize,
        );
        Ok(())
    }

    /// Supply the initializer `-ftrivial-auto-var-init` gives an object
    /// declared without one: `fill` repeated over every byte. A scalar
    /// that fits a register takes it as a literal of its own type, so the
    /// slot stays as promotable as under a written initializer; an array,
    /// an aggregate, a vector or a `long double` wider than f64 takes the
    /// byte fill of `LocalInit::Fill`.
    fn emit_auto_var_fill(&mut self, loc_idx: usize, ty: i64, is_array: bool, fill: Option<u8>) {
        use super::super::ast::{Expr, LocalInitPrelude};
        let Some(byte) = fill else {
            return;
        };
        let elem_size = self.size_of_type(ty) as i64;
        let size = if is_array {
            elem_size * self.symbols[loc_idx].array_size
        } else {
            elem_size
        };
        if size <= 0 {
            return;
        }
        let repeat =
            |width: i64| -> u64 { (0..width).fold(0u64, |acc, _| (acc << 8) | u64::from(byte)) };
        let wide_long_double = is_long_double_ty(ty)
            && self.target.long_double() != crate::c5::codegen::LongDoubleKind::F64;
        let scalar = !is_array
            && size <= 8
            && !is_struct_value_ty(ty)
            && !is_vector_ty(&self.structs, ty)
            && !wide_long_double;
        if !scalar {
            self.mark_emit_other();
            self.pending_local_aggregate_ast = Some(LocalInitPrelude::Fill {
                byte,
                size_bytes: size,
            });
            return;
        }
        let expr = if is_float_ty(ty) {
            // The walker narrows the f64 image back to f32; a bit pattern
            // that is a finite f32 round-trips exactly.
            let bits = (f32::from_bits(repeat(4) as u32) as f64).to_bits();
            Expr::FloatLit { bits, ty }
        } else if is_floating_scalar(ty) {
            Expr::FloatLit {
                bits: repeat(8),
                ty,
            }
        } else {
            Expr::IntLit {
                val: repeat(size) as i64,
                ty,
            }
        };
        let pos = self.ast_src_pos();
        self.pending_local_init_ast = Some(self.ast.push_expr(expr, pos));
    }

    /// Parse a C99 6.5.2.5 block-scope compound literal `(type){ init }`
    /// with the cursor on the `{` and the `(type)` already parsed: `t` is
    /// the element, scalar or struct type and `array_dims` the bracket
    /// counts outermost first, empty for a non-array literal and
    /// `array_dims[0] == -1` for the size-from-initializer form. The
    /// literal is an unnamed object with automatic storage (6.5.2.5p5),
    /// so it takes an anonymous frame slot; the emitted
    /// `Expr::CompoundLiteral` yields its address for an array or struct
    /// (6.3.2.1p3) and the loaded value for a scalar.
    // The literal's three outputs come from one multi-branch decision;
    // binding them to its value folds that chain into a tuple expression.
    #[allow(clippy::needless_late_init)]
    pub(super) fn parse_block_compound_literal(
        &mut self,
        (t, elem_fn): (i64, Option<(crate::c5::symbol::FnType, i64)>),
        array_dims: &[i64],
    ) -> Result<(), C5Error> {
        // A compound literal reuses the three pending-init carriers as
        // scratch for its own initializer (drained below). When it appears
        // as a field / element value of an enclosing aggregate that is
        // itself accumulating runtime stores (`T t = { .a = v, .p =
        // &(P){...} }`), the enclosing declaration's carriers must survive:
        // save them here and restore before returning so the fields
        // written before the literal are not dropped. C99 6.5.2.5: the
        // literal is a distinct object, not part of the enclosing one.
        let saved_carriers = self.take_pending_local_carriers();
        self.pending.init_inner_dims = alloc::vec::Vec::new();

        // A compound literal yields its value through `ast_acc` (the
        // `Expr::CompoundLiteral` built below) and its element AST
        // through `pending_local_runtime_elements`; it must not net
        // change the parser-side vstack. The runtime field fill uses
        // transient `ast_psh`/`ast_assign` pairs whose dual-emit
        // bookkeeping can leave residual entries. When the literal is
        // parsed as a sub-expression (e.g. the right operand of a
        // binary operator), those residual entries would otherwise sit
        // on top of the caller's pushed left operand, so the wrapping
        // operator would pop the wrong vstack slot. Restore the depth
        // before returning.
        let vstack_depth = self.ast_vstack.len();

        let value_ty;
        let final_array_size;
        let slot;

        if !array_dims.is_empty() {
            let elem_ty = t;
            let elem_size = self.size_of_type(elem_ty);
            let inner_dims = &array_dims[1..];
            let inner_span: i64 = inner_dims.iter().product::<i64>().max(1);
            // C99 6.5.2.5p3: the literal is an unnamed object with the
            // initializer semantics of a named one, so an aggregate element
            // type takes the declaration's struct-array walk, which counts
            // and fills by element rather than by scalar leaf.
            let elem_is_aggregate = self.is_traversable_aggregate_ty(elem_ty);
            let mut count;
            let mut rows;
            if array_dims[0] == -1 {
                if self.lex.tk != '{' {
                    return Err(self.compile_err(Code::SYNTAX, "`{` expected in compound literal"));
                }
                let needs_runtime;
                if elem_is_aggregate {
                    rows = self.struct_array_init_rows(elem_ty, inner_dims)?;
                    needs_runtime = self.struct_init_needs_runtime()?;
                } else {
                    (rows, needs_runtime) = self.array_literal_rows(elem_ty, inner_dims)?;
                }
                count = rows * inner_span;
                slot =
                    self.reserve_object_slots(elem_ty, self.local_storage_slots(elem_ty, count))?;
                let full = elem_size * count as usize;
                if needs_runtime {
                    let zero_off = self.stage_template_bytes(full);
                    self.emit_local_array_init(slot, zero_off, full);
                    let reached = self.emit_local_array_init_runtime(
                        slot,
                        0,
                        (elem_ty, elem_fn.clone()),
                        count,
                        inner_dims,
                        "<compound literal>",
                    )?;
                    if elem_is_aggregate {
                        rows = (reached + inner_span - 1) / inner_span;
                        count = rows * inner_span;
                    }
                } else if elem_is_aggregate {
                    self.stage_struct_array_literal(slot, elem_ty, rows, inner_dims, full)?;
                } else {
                    self.pending.init_inner_dims = inner_dims.to_vec();
                    let elements = self.collect_array_initializer(elem_ty, elem_fn.clone())?;
                    self.store_literal_elements(slot, elem_ty, &elements, count, full)?;
                }
            } else {
                rows = array_dims[0];
                count = rows * inner_span;
                let full = elem_size * count as usize;
                slot =
                    self.reserve_object_slots(elem_ty, self.local_storage_slots(elem_ty, count))?;
                let needs_runtime = self.lex.tk == '{'
                    && if elem_is_aggregate {
                        self.struct_init_needs_runtime()?
                    } else {
                        self.array_init_needs_runtime()?
                    };
                if needs_runtime {
                    let zero_off = self.stage_template_bytes(full);
                    self.emit_local_array_init(slot, zero_off, full);
                    self.emit_local_array_init_runtime(
                        slot,
                        0,
                        (elem_ty, elem_fn.clone()),
                        count,
                        inner_dims,
                        "<compound literal>",
                    )?;
                } else if elem_is_aggregate {
                    // A designator past the bound is the fill's to report.
                    let items = self.lex.count_top_level_items_in_array() as i64;
                    if self.lex.tk == '{' && self.designated_array_count(items, 1, None)? <= items {
                        let supplied =
                            self.struct_array_init_rows(elem_ty, inner_dims)? * inner_span;
                        if supplied > count {
                            return Err(self.compile_err(Code::INVALID_INITIALIZER, format!(
                                "too many initializers for compound literal ({supplied} > {count})"
                            )));
                        }
                    }
                    self.stage_struct_array_literal(slot, elem_ty, rows, inner_dims, full)?;
                } else {
                    self.pending.init_target_array_size = count;
                    self.pending.init_inner_dims = inner_dims.to_vec();
                    let elements = self.collect_array_initializer(elem_ty, elem_fn.clone())?;
                    self.store_literal_elements(slot, elem_ty, &elements, count, full)?;
                }
            }
            final_array_size = count;
            // C99 6.3.2.1p3: an array compound literal used as a value
            // decays to a pointer to its first element -- a row for a
            // multi-dimensional literal.
            value_ty = if inner_dims.is_empty() {
                elem_ty + Ty::Ptr as i64
            } else {
                self.array_agg_type(elem_ty, inner_dims) + Ty::Ptr as i64
            };
        } else if self.is_traversable_aggregate_ty(t) {
            let sid = struct_id_of(t);
            let elem_size = self.size_of_type(t);
            let cl_slots = self.slots_of_type(t);
            slot = self.reserve_object_slots(t, cl_slots)?;
            if cl_slots >= 1 {
                self.record_multi_cell_temp(slot, cl_slots, t);
            }
            let needs_runtime = self.struct_init_needs_runtime()?;
            let staged = self.stage_template_bytes(elem_size);
            if needs_runtime {
                self.emit_local_array_init(slot, staged, elem_size);
                self.emit_struct_runtime_at(slot, 0, sid, true)?;
            } else {
                self.collect_struct_initializer(sid, staged as i64)?;
                self.emit_local_array_init(slot, staged, elem_size);
            }
            final_array_size = 0;
            value_ty = t;
        } else {
            // Scalar compound literal `(T){ expr }`.
            slot = self.reserve_object_slots(t, self.slots_of_type(t))?;
            if self.lex.tk != '{' {
                return Err(self.compile_err(Code::SYNTAX, "`{` expected in compound literal"));
            }
            self.next()?;
            let line = self.lex.line;
            self.expr(Token::Assign as i64)?;
            self.check_initializer_expr(t, 0, line)?;
            self.convert_assign_rhs(t);
            self.pending_local_init_ast = self.ast_acc;
            self.accept(',')?;
            if self.lex.tk != '}' {
                return Err(
                    self.compile_err(Code::SYNTAX, "`}` expected to close compound literal")
                );
            }
            self.next()?;
            final_array_size = 0;
            value_ty = t;
        }

        let init = self.drain_pending_local_init();

        // C99 6.5.2.5p5: the literal's storage lasts to the end of the
        // enclosing block. When it is evaluated inside a call argument, an
        // enclosing call's staging recycle must not reclaim its cells.
        self.commit_block_slot(slot);

        self.ast_vstack.truncate(vstack_depth);
        self.ast_emit_compound_literal(slot, t, final_array_size, init);
        // Restore the enclosing declaration's carriers (the literal's own
        // carriers were just drained into `init`).
        self.restore_pending_local_carriers(saved_carriers);
        // C99 6.3.2.1p3 exempts a `sizeof` / `typeof` operand from
        // array-to-pointer conversion, so publish the undecayed extent the
        // way a string literal does; `-1` marks a genuine zero count. A
        // multi-dimensional literal publishes the byte width and dims (the
        // element-count form cannot spell a row-typed pointee).
        if array_dims.len() > 1 {
            self.pending.last_array_decay_bytes = final_array_size * self.size_of_type(t) as i64;
            let inner_span: i64 = array_dims[1..].iter().product::<i64>().max(1);
            let mut dims = alloc::vec::Vec::with_capacity(array_dims.len());
            dims.push(final_array_size / inner_span);
            dims.extend_from_slice(&array_dims[1..]);
            self.pending.last_array_decay_dims = dims;
        } else if !array_dims.is_empty() {
            self.pending.last_array_decay_size = if final_array_size > 0 {
                final_array_size
            } else {
                -1
            };
        } else {
            // A non-array literal is no decayed array, whatever it was initialized from.
            self.drop_operand_array_decay();
        }
        self.ty = value_ty;
        Ok(())
    }

    /// Copy a constant array literal's `elements` into its `count`-element
    /// slot at `slot`, zero-padded to `full` bytes (C99 6.7.8p21).
    fn store_literal_elements(
        &mut self,
        slot: i64,
        elem_ty: i64,
        elements: &[(i128, super::initializer::InitElemReloc)],
        count: i64,
        full: usize,
    ) -> Result<(), C5Error> {
        if elements.len() as i64 > count {
            let n = elements.len();
            let text = format!("too many initializers for compound literal ({n} > {count})");
            return Err(self.compile_err(Code::INVALID_INITIALIZER, text));
        }
        let (start, packed) = self.pack_initializer_into_data(elem_ty, elements)?;
        if packed < full {
            self.data.resize(self.data.len() + full - packed, 0);
        }
        self.emit_local_array_init(slot, start, packed.max(full));
        Ok(())
    }

    /// GNU C cast to a union, `(union U)v`: the compound literal `(union
    /// U){ .m = v }` of the member `m` of `v`'s type, the operand just parsed.
    pub(super) fn union_cast_literal(
        &mut self,
        t: i64,
        m: super::StructField,
    ) -> Result<(), C5Error> {
        use super::super::ast::{
            LocalInit, LocalInitPrelude, RuntimeInitElement, RuntimeInitValue,
        };
        let slots = self.slots_of_type(t);
        let slot = self.reserve_object_slots(t, slots)?;
        self.record_multi_cell_temp(slot, slots.max(1), t);
        self.convert_assign_rhs(m.ty);
        let Some(value) = self.ast_acc else {
            return Err(self.compile_err(Code::INTERNAL, "cast to a union has no operand"));
        };
        let element = RuntimeInitElement {
            offset: m.offset as i64,
            value: RuntimeInitValue::Expr(value),
            ty: m.ty,
            bitfield: None,
        };
        let size_bytes = self.size_of_type(t) as i64;
        let init = LocalInit::Runtime {
            zero_init: Some(LocalInitPrelude::Fill {
                byte: 0,
                size_bytes,
            }),
            elements: alloc::vec![element],
        };
        self.commit_block_slot(slot);
        self.ast_emit_compound_literal(slot, t, 0, init);
        // A cast yields a value, which no lvalue path takes.
        self.ast_apply_assign_conv(t);
        self.drop_operand_array_decay();
        self.pending.object_ref = None;
        self.ty = t;
        Ok(())
    }

    /// Number of 8-byte stack slots a local declaration consumes,
    /// honouring an array dimension if present. For non-arrays this
    /// is just `slots_of_type(ty)`; for an array of N Ts the
    /// allocation is rounded up to 8-byte alignment so subsequent
    /// stack frame entries stay aligned.
    pub(super) fn local_storage_slots(&self, ty: i64, array_size: i64) -> i64 {
        if array_size > 0 {
            let bytes = (self.size_of_type(ty) as i64) * array_size;
            (bytes + 7) / 8
        } else {
            self.slots_of_type(ty)
        }
    }

    /// Inner dimensions (below the outermost) of array symbol `idx`,
    /// for the multi-dim initializer padding path. Empty for scalar /
    /// 1D arrays. The outermost dimension is dropped because the
    /// initializer fills it positionally; the remaining dims size each
    /// nested brace's sub-array.
    pub(super) fn inner_dims_of(&self, idx: usize) -> alloc::vec::Vec<i64> {
        self.symbols[idx]
            .array_dims
            .get(1..)
            .map(|s| s.to_vec())
            .unwrap_or_default()
    }

    /// True when reading symbol `idx` by value yields a runtime
    /// result rather than a constant. A file-scope (Glo) scalar or
    /// pointer object's stored value is not a constant expression
    /// (C99 6.6), so an aggregate initializer element that reads it
    /// needs the per-element runtime store path. Global arrays and
    /// functions decay to a constant address and stay constant; a
    /// preceding `&` (address-of) is also constant and is excluded by
    /// the caller. A whole-struct value read is left on the constant
    /// path because the runtime initializer doesn't lower nested
    /// struct copies yet.
    fn glo_value_read_is_runtime(&self, idx: usize) -> bool {
        let s = &self.symbols[idx];
        if s.class != Token::Glo as i64 || s.array_size != 0 || s.is_zero_len_array {
            return false;
        }
        // A non-array global read by value -- scalar load or whole-struct
        // member copy -- happens at runtime for automatic storage; the
        // constant grammar only admits addresses and folded const
        // scalars.
        true
    }

    /// Whether an identifier value in an automatic-storage initializer
    /// forces the per-member runtime-store path. Locals and file-scope
    /// scalar reads are runtime values; an address (`&id`, a function
    /// name, an array name's decay) is materialized by a runtime store
    /// so the staged template carries no absolute relocation.
    fn init_id_needs_runtime(&self, prev_was_amp: bool) -> bool {
        let s = &self.symbols[self.lex.curr_id_idx];
        if s.class == Token::Loc as i64 {
            return true;
        }
        if prev_was_amp && (s.class == Token::Glo as i64 || s.class == Token::Fun as i64) {
            return true;
        }
        if s.class == Token::Fun as i64
            || (s.class == Token::Glo as i64 && (s.array_size != 0 || s.is_zero_len_array))
        {
            return true;
        }
        self.glo_value_read_is_runtime(self.lex.curr_id_idx)
    }

    /// On `(` in an initializer pre-scan: whether it opens a compound
    /// literal whose object the element keeps a pointer to -- `&(T){...}`,
    /// or an array literal, which decays to its address (C99 6.3.2.1p3).
    /// Inside a function body the literal has automatic storage duration
    /// (6.5.2.5p5), so the aggregate holding its address fills at runtime
    /// rather than from a staged template; a literal read by value stays
    /// on the constant path. The lexer position is unchanged on return.
    fn paren_opens_escaping_literal(&mut self, prev_was_amp: bool) -> Result<bool, C5Error> {
        let snap = self.lex.snapshot();
        let staged = self.data.len();
        self.next()?;
        let mut escapes = false;
        if self.lex_is_type_start() {
            let mut array = false;
            let mut depth: i64 = 1;
            while depth > 0 && self.lex.tk != 0 {
                if self.lex.tk == '(' {
                    depth += 1;
                } else if self.lex.tk == ')' {
                    depth -= 1;
                    if depth == 0 {
                        break;
                    }
                } else if self.lex.tk == Token::Brak
                    || (self.is_lex_typedef_name()
                        && self.symbols[self.lex.curr_id_idx].array_size != 0)
                {
                    array = true;
                }
                self.next()?;
            }
            self.next()?;
            escapes = self.lex.tk == '{' && (prev_was_amp || array);
        }
        self.rewind_speculation(snap, staged);
        Ok(escapes)
    }

    /// Pre-scan an array initializer's brace list (current token
    /// must be `{`) and return `(element_count, needs_runtime)`.
    /// The count is the number of top-level (comma-separated)
    /// elements, used by the deferred-size `T xs[] = {...}` path.
    /// The runtime flag is true when any element involves a
    /// non-constant value -- a Loc-class identifier, a file-scope
    /// scalar read by value, an indexed read, a member access, or a
    /// function call.
    pub(super) fn scan_array_init(&mut self) -> Result<(i64, bool), C5Error> {
        debug_assert!(self.lex.tk == '{');
        let snap = self.lex.snapshot();
        self.next()?; // consume `{`
        let mut depth: i64 = 1;
        let mut needs_runtime = false;
        let mut count: i64 = 0;
        // Detect an empty list (`{}`) -- 0 elements rather than 1.
        let mut saw_any = false;
        // Whether the previously scanned token was a unary/binary `&`
        // (see `init_id_needs_runtime` for the address rule).
        let mut prev_was_amp = false;
        // Whether the previously scanned token was the `&&` of a label
        // address, whose operand names a label rather than an object.
        let mut prev_was_label_addr = false;
        // Tells binary `&&` from the `&&label` prefix.
        let mut scan = OperandScan::new();
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '(' && self.lex.peek_after_whitespace(b'{') {
                // A GNU statement expression `({ ... })` element is not a
                // constant expression (C99 6.6); its `{`/`}` still balance
                // the depth counter on the following iterations.
                needs_runtime = true;
                saw_any = true;
            } else if self.lex.tk == '(' && self.paren_opens_escaping_literal(prev_was_amp)? {
                needs_runtime = true;
                saw_any = true;
            } else if self.lex.tk == '{' {
                // A brace-enclosed element (`{ ... }`, possibly empty like
                // `{ }`) counts even when it holds no scalar token, so mark
                // the current element non-empty at the top level.
                if depth == 1 {
                    saw_any = true;
                }
                depth += 1;
            } else if self.lex.tk == '}' {
                depth -= 1;
                if depth == 0 {
                    if saw_any {
                        count += 1;
                    }
                    break;
                }
            } else if self.lex.tk == ',' && depth == 1 {
                if saw_any {
                    count += 1;
                }
                saw_any = false;
                prev_was_amp = false;
                prev_was_label_addr = false;
                scan = OperandScan::new();
                self.next()?;
                continue;
            } else if self.lex.tk == Token::Id {
                saw_any = true;
                if !prev_was_label_addr {
                    if self.init_id_needs_runtime(prev_was_amp) {
                        needs_runtime = true;
                    }
                    if self.lex.peek_after_whitespace(b'[') || self.lex.peek_after_whitespace(b'(')
                    {
                        needs_runtime = true;
                    }
                }
            } else if self.lex.tk == Token::Dot || self.lex.tk == Token::Arrow {
                needs_runtime = true;
                saw_any = true;
            } else if self.lex.tk == Token::Lan && !scan.ends_operand() {
                // `&&label` (GCC labels as values). The block address is a
                // link-time constant, so the element does not force the
                // runtime path. The binary logical AND shares the
                // spelling; only an operand can precede that one.
                saw_any = true;
            } else {
                saw_any = true;
            }
            prev_was_amp = self.lex.tk == Token::AndOp;
            prev_was_label_addr = self.lex.tk == Token::Lan && !scan.ends_operand();
            self.operand_scan_advance(&mut scan);
            self.next()?;
        }
        self.restore_lex(snap);
        Ok((count, needs_runtime))
    }

    /// True when an element of the array initializer under the cursor
    /// is not a compile-time constant, so the initializer needs the
    /// per-element runtime store path rather than packed bytes plus one
    /// copy. The lexer position is unchanged on return. Constant here
    /// means a literal, an enum or macro constant, a bare file-scope
    /// scalar constant, and casts and parentheses over the same;
    /// everything else -- a `Loc`-class reference, an indexed read,
    /// member access, a call, an address -- is a runtime value.
    pub(super) fn array_init_needs_runtime(&mut self) -> Result<bool, C5Error> {
        Ok(self.scan_array_init()?.1)
    }

    /// Emit per-element store sequences for a local-array
    /// initializer whose elements aren't all compile-time
    /// constants. C99 6.7.8 paragraph 13 specifies that each
    /// element is initialised as if by assignment in declaration
    /// order. Positions the brace list leaves out keep the zero
    /// seed every caller Mcpy's into the slot first (6.7.8p21).
    ///
    /// `local_val` is the base slot offset (negative, from FP);
    /// `ty` the element type; `max` the declared dimension. On
    /// entry the current token is `{`; on return it's the token
    /// after the matching `}`.
    /// `elem` is the element type and the function type an element leads
    /// to, if any. Returns the elements the list reached.
    pub(super) fn emit_local_array_init_runtime(
        &mut self,
        local_val: i64,
        base: i64,
        elem: (i64, Option<(crate::c5::symbol::FnType, i64)>),
        total_count: i64,
        inner_dims: &[i64],
        var_name: &str,
    ) -> Result<i64, C5Error> {
        let (ty, elem_fn) = elem;
        let elem_size = self.size_of_type(ty) as i64;
        // Build the full dimension list, outermost first. `inner_dims`
        // are the fixed inner dimensions (`array_dims[1..]`); the outer
        // count is the total element count divided by their product (1
        // for a one-dimensional array).
        let inner_span: i64 = inner_dims.iter().product();
        let outer = if inner_span > 0 {
            total_count / inner_span
        } else {
            total_count
        };
        let mut dims = alloc::vec::Vec::with_capacity(inner_dims.len() + 1);
        dims.push(outer.max(0));
        dims.extend_from_slice(inner_dims);
        let outer = core::mem::replace(&mut self.array_elem_fn, elem_fn);
        let r = self.fill_array_init_runtime(local_val, base, &dims, ty, elem_size, var_name);
        self.array_elem_fn = outer;
        r
    }

    /// Parse one brace level of a runtime array initializer at byte
    /// offset `base` within the local, recursing for each inner
    /// dimension. C99 6.7.8: a nested `{ ... }` opens a sub-array;
    /// brace elision (a value where a sub-array is expected) fills the
    /// sub-array's leaves in row-major order. Omitted trailing
    /// positions keep the zero seed the caller wrote (6.7.8p21). On
    /// entry the current token is `{`; on return it is the token after
    /// the matching `}`.
    fn fill_array_init_runtime(
        &mut self,
        local_val: i64,
        base: i64,
        dims: &[i64],
        ty: i64,
        elem_size: i64,
        var_name: &str,
    ) -> Result<i64, C5Error> {
        debug_assert!(self.lex.tk == '{');
        self.next()?; // consume `{`
        let child = &dims[1..];
        let total: i64 = dims.iter().product();
        // Flat element cursor; designators and entries move it the same
        // way as in `collect_array_initializer`.
        let mut cursor: i64 = 0;
        let mut reached: i64 = 0;
        while self.lex.tk != '}' {
            let desig = self.take_chained_array_designator(child)?;
            let mut range_end: i64 = 0;
            // The level the entry fills: the chain's depth for a
            // designated entry; for a positional one the outermost level
            // whose row boundary the cursor sits on (C99 6.7.8p17 resumes
            // at the subobject after the designated one).
            let level = match &desig {
                Some(d) => {
                    cursor = d.base;
                    range_end = d.range_end;
                    d.depth
                }
                None => (0..=child.len())
                    .find(|&k| {
                        let s: i64 = child[k..].iter().product();
                        s > 0 && cursor % s == 0
                    })
                    .unwrap_or(child.len()),
            };
            let sub = &child[level..];
            let span: i64 = sub.iter().product::<i64>().max(1);
            let end = if range_end > 0 {
                range_end
            } else {
                cursor + span
            };
            if end > total {
                return Err(self.compile_err(
                    Code::INVALID_INITIALIZER,
                    format!("too many initializers for array `{var_name}` (> {total})"),
                ));
            }
            // C99 6.7.8p7: the designator list may continue into the
            // element (`[i][j].field... = v`), naming a sub-object of a
            // fully indexed element; a range re-parses the chain and value
            // per element.
            if desig.as_ref().is_some_and(|d| d.element_chain) {
                if level != child.len() || !self.is_traversable_aggregate_ty(ty) {
                    return Err(
                        self.compile_err(Code::SYNTAX, "`=` expected after `[N]` designator")
                    );
                }
                let value = self.lex.snapshot();
                for e in cursor..end {
                    if e > cursor {
                        self.restore_lex(value);
                    }
                    let here = base + e * elem_size;
                    self.fill_element_field_designator_t(
                        struct_id_of(ty),
                        ty,
                        here,
                        InitTarget::Runtime {
                            local_val,
                            base: here,
                        },
                        e + 1 == end,
                    )?;
                }
                cursor = end;
                reached = reached.max(cursor);
                self.list_separator('}', "initializer")?;
                continue;
            }
            let off = base + cursor * elem_size;
            if level < child.len() {
                let string = match sub {
                    [row] => self.take_string_init(ty)?.map(|lit| (lit, *row as usize)),
                    _ => None,
                };
                if let Some((lit, row)) = string {
                    // C99 6.7.8p14: a string literal fills the row.
                    self.warn_string_overrun(&lit, row);
                    self.push_string_init_stores(off, &lit, row, ty);
                } else if self.lex.tk == '{' {
                    self.fill_array_init_runtime(local_val, off, sub, ty, elem_size, var_name)?;
                } else {
                    let rows = sub.last().copied();
                    self.fill_array_leaves_runtime(local_val, off, (span, rows), ty, elem_size)?;
                }
            } else if self.is_traversable_aggregate_ty(ty) {
                // Array-of-struct element (C99 6.7.8p17): recurse into the
                // struct initializer instead of the scalar-leaf path, which
                // would hand the element's `{` to the expression parser.
                // Reached when a struct-array MEMBER is forced onto the
                // runtime path by a non-constant element value (e.g.
                // `&mms->field[0]`); braces may be elided (6.7.8p20).
                self.emit_struct_array_element_runtime(local_val, off, struct_id_of(ty))?;
            } else if self.lex.tk == '{' {
                // C99 6.7.8p11: a scalar leaf may be brace-wrapped.
                self.next()?;
                self.emit_array_leaf_runtime(local_val, off, ty)?;
                self.accept(',')?;
                if self.lex.tk != '}' {
                    return Err(self.compile_err(
                        Code::SYNTAX,
                        "`}` expected after braced scalar initializer",
                    ));
                }
                self.next()?;
            } else {
                self.emit_array_leaf_runtime(local_val, off, ty)?;
            }
            // GNU range: the entry was evaluated once into the span at
            // `cursor`; the rest of the range copies its bytes.
            if end > cursor + span {
                self.push_runtime_range_copies(
                    off,
                    span * elem_size,
                    (end - cursor) / span - 1,
                    ty,
                );
            }
            cursor = end;
            reached = reached.max(cursor);
            self.list_separator('}', "initializer")?;
        }
        self.next()?; // consume `}`
        Ok(reached)
    }

    /// Append `extra` copy elements replicating the `span`-byte span at
    /// `src_off` to the spans that follow it -- the GNU range designator
    /// fill after its first span was stored. `ty` is the element type
    /// (the row's leaf type for a multi-dimensional row span).
    pub(super) fn push_runtime_range_copies(
        &mut self,
        src_off: i64,
        span: i64,
        extra: i64,
        ty: i64,
    ) {
        for k in 1..=extra {
            self.pending_local_runtime_elements
                .push(super::super::ast::RuntimeInitElement {
                    offset: src_off + k * span,
                    value: super::super::ast::RuntimeInitValue::Copy {
                        src_off,
                        bytes: span,
                    },
                    ty,
                    bitfield: None,
                });
        }
    }

    /// Fill up to `n` scalar leaves at consecutive offsets from `base`
    /// (a brace-elided sub-array). Stops early at `}` -- the omitted
    /// trailing positions keep the caller's zero seed (C99 6.7.8p21).
    /// A string at a boundary of its `rows` fills that row (6.7.8p14).
    pub(super) fn fill_array_leaves_runtime(
        &mut self,
        local_val: i64,
        base: i64,
        (n, rows): (i64, Option<i64>),
        ty: i64,
        elem_size: i64,
    ) -> Result<(), C5Error> {
        let mut k: i64 = 0;
        while k < n {
            if self.lex.tk == '}' {
                break;
            }
            // An aggregate element takes its own members from the same list
            // (C99 6.7.8p20), its braces elided too.
            let row = rows.filter(|&r| r > 0 && k % r == 0);
            if self.is_traversable_aggregate_ty(ty) {
                let sid = super::types::struct_id_of(ty);
                self.emit_struct_array_element_runtime(local_val, base + k * elem_size, sid)?;
                k += 1;
            } else if let Some(row) = row
                && let Some(lit) = self.take_string_init(ty)?
            {
                self.warn_string_overrun(&lit, row as usize);
                self.push_string_init_stores(base + k * elem_size, &lit, row as usize, ty);
                k += row;
            } else {
                self.emit_array_leaf_runtime(local_val, base + k * elem_size, ty)?;
                k += 1;
            }
            if !self.initializer_separator(true, k >= n)? {
                break;
            }
        }
        Ok(())
    }

    /// True when a field of the struct initializer under the cursor
    /// holds a value that is not a compile-time constant, so the
    /// initializer needs the per-field runtime store path rather than
    /// staged bytes plus one copy. The lexer position is unchanged on
    /// return. A leading designator is skipped before the value is
    /// checked; non-constants are the ones the array scanner takes --
    /// a `Loc`-class reference, a call, an indexed read, and member
    /// access through a dot or arrow that is not a designator.
    pub(super) fn struct_init_needs_runtime(&mut self) -> Result<bool, C5Error> {
        debug_assert!(self.lex.tk == '{');
        let snap = self.lex.snapshot();
        self.next()?; // consume `{`
        let mut depth: i64 = 1;
        let mut needs_runtime = false;
        // At the start of each entry (just after `{` or `,`),
        // skip an optional designator chain so the value-side
        // tokens are the ones inspected for non-constants.
        // Multiple chained designators (`.outer.inner = ...`,
        // `[5][2] = ...`) are skipped in order.
        let mut at_entry_start = true;
        // Whether the previously scanned token was `&` (address-of).
        // An address-valued member (`&g`, a function name, an array
        // name's decay) takes the runtime path: automatic storage is
        // built by stores, so the staged template carries no absolute
        // relocation (as toolchains emit; an abs-reloc-free link --
        // a vDSO or firmware stub -- rejects a template relocation).
        let mut prev_was_amp = false;
        while depth > 0 && self.lex.tk != 0 {
            // Designator skip works at any depth: nested
            // `.inner = { .x = ... }` carries its own
            // entry-start-aligned designators that must be
            // peeled off before checking the value tokens.
            if at_entry_start && (self.lex.tk == Token::Dot || self.lex.tk == Token::Brak) {
                while self.lex.tk == Token::Dot || self.lex.tk == Token::Brak {
                    if self.lex.tk == Token::Dot {
                        self.next()?; // .
                        if self.lex.tk == Token::Id {
                            self.next()?; // field name
                        }
                    } else {
                        // `[N]` -- skip the constant integer
                        // through the matching `]`.
                        self.next()?; // [
                        let mut br_depth = 1;
                        while br_depth > 0 && self.lex.tk != 0 {
                            if self.lex.tk == Token::Brak {
                                br_depth += 1;
                            } else if self.lex.tk == ']' {
                                br_depth -= 1;
                                if br_depth == 0 {
                                    self.next()?; // consume `]`
                                    break;
                                }
                            }
                            self.next()?;
                        }
                    }
                }
                if self.lex.tk == Token::Assign {
                    self.next()?; // `=`
                }
                at_entry_start = false;
                prev_was_amp = false;
                continue;
            }
            if self.lex.tk == '(' && self.lex.peek_after_whitespace(b'{') {
                // A GNU statement expression `({ ... })` element is not a
                // constant expression (C99 6.6), so the aggregate fills at
                // runtime. Its `{`/`}` still balance the depth counter on the
                // following iterations.
                needs_runtime = true;
                at_entry_start = false;
            } else if self.lex.tk == '(' && self.paren_opens_escaping_literal(prev_was_amp)? {
                needs_runtime = true;
                at_entry_start = false;
            } else if self.lex.tk == '{' {
                depth += 1;
                at_entry_start = true;
            } else if self.lex.tk == '}' {
                depth -= 1;
                if depth == 0 {
                    break;
                }
            } else if self.lex.tk == ',' {
                // `,` separator -- the next token begins a new
                // entry (positional or designator). At any
                // depth.
                at_entry_start = true;
                prev_was_amp = false;
                self.next()?;
                continue;
            } else if self.lex.tk == Token::Id {
                if self.init_id_needs_runtime(prev_was_amp) {
                    needs_runtime = true;
                }
                if self.lex.peek_after_whitespace(b'[') || self.lex.peek_after_whitespace(b'(') {
                    needs_runtime = true;
                }
                at_entry_start = false;
            } else if self.lex.tk == Token::Dot || self.lex.tk == Token::Arrow {
                // Member access on a value -- non-constant.
                // Designator dots were consumed at entry start.
                needs_runtime = true;
                at_entry_start = false;
            } else {
                at_entry_start = false;
            }
            prev_was_amp = self.lex.tk == Token::AndOp;
            self.next()?;
        }
        self.restore_lex(snap);
        Ok(needs_runtime)
    }
}

/// Tracks whether the token just consumed can end an operand, which is what
/// tells the binary `&&` from the `&&label` block-address prefix in an
/// initializer pre-scan. A closing `)` ends an operand unless it closed a
/// cast's type name, so paren groups are classified as they open.
struct OperandScan {
    ends: bool,
    /// One flag per open paren: whether the group is a cast's type name.
    parens: alloc::vec::Vec<bool>,
    /// The most recent `(` still needs its group classified.
    unclassified: bool,
    prev_was_sizeof: bool,
}

impl OperandScan {
    fn new() -> Self {
        Self {
            ends: false,
            parens: alloc::vec::Vec::new(),
            unclassified: false,
            prev_was_sizeof: false,
        }
    }

    fn ends_operand(&self) -> bool {
        self.ends
    }

    /// Consume the token at the scan cursor. `typedef_name` is true when it is
    /// an identifier bound to a typedef, which only the symbol table knows.
    fn advance(&mut self, tk: super::super::token::Tok, typedef_name: bool) {
        if self.unclassified {
            if let Some(last) = self.parens.last_mut() {
                *last = super::types::is_type_start_token(tk) || typedef_name;
            }
            self.unclassified = false;
        }
        if tk == '(' {
            // `sizeof (T)` parenthesises a type name but yields a value, so
            // its `)` ends an operand.
            self.parens.push(false);
            self.unclassified = !self.prev_was_sizeof;
            self.ends = false;
        } else if tk == ')' {
            self.ends = !self.parens.pop().unwrap_or(false);
        } else {
            self.ends = super::super::token::ends_operand(tk);
        }
        self.prev_was_sizeof = tk == Token::Sizeof || tk == Token::Alignof;
    }
}
