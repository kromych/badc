//! Local-declaration handlers for function bodies.
//!
//! Four related methods cluster here, all dealing with the
//! "reserve frame storage + emit any initializer" responsibilities
//! of a local declaration line at function-body scope:
//!
//!   * `parse_local_decl` -- parse one declaration
//!     line at the top of a function body. Drives the per-
//!     declarator allocator dispatch (static-promote vs. stack-
//!     local).
//!   * `allocate_static_local` -- promote a `static T name;` to a
//!     `Glo`-class symbol with persistent data-segment storage and
//!     parse any initializer following file-scope rules.
//!   * `allocate_local_with_init` -- reserve frame storage for a
//!     stack local and emit any initializer that follows. Handles
//!     the three shapes (non-array, known-size array, deferred-
//!     size array) plus the special `struct T xs[] = {...};` and
//!     `struct T s = {...};` paths that stage bytes through
//!     `self.data` so the runtime Mcpy ends up with the right
//!     contents.
//!   * `local_storage_slots` -- per-declarator slot count, honoring
//!     array dimension if present.
//!
//! Sibling to the initializer / aggregate / declarator modules
//! because the stack-frame allocation logic is the natural unit
//! to keep together; nothing outside this cluster cares about
//! `loc_offs` book-keeping.

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::initializer::InitTarget;
use super::types::{apply_qual_bits, is_pointer_ty, is_struct_value_ty, struct_id_of};

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
                Some(super::super::ast::LocalInitPrelude::Zero { size_bytes }) => {
                    super::super::ast::LocalInit::Zero { size_bytes }
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
    /// goes to the over-aligned frame region. Consumes `pending.attr_align`
    /// either way, so a request cannot leak onto the next declarator.
    pub(super) fn resolve_decl_align(
        &mut self,
        ty: i64,
        is_static: bool,
        base_type_align: i64,
    ) -> Result<DeclAlign, C5Error> {
        let req_align = core::mem::take(&mut self.pending.attr_align);
        let alignas_align = core::mem::take(&mut self.pending.attr_alignas);
        if req_align > 8 && !(req_align as usize).is_power_of_two() {
            return Err(self.compile_err(format!(
                "requested alignment {req_align} is not a power of two"
            )));
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
        let region_auto = auto_align > 8;
        if auto_align > super::MAX_FRAME_ALIGN {
            return Err(self.compile_err(format!(
                "requested alignment {auto_align} exceeds the maximum for an \
                 automatic object ({}); use static storage",
                super::MAX_FRAME_ALIGN
            )));
        }
        // A static local, or the pointee alignment a type-position attribute
        // carries, is placed like a file-scope object.
        if req_align.max(type_align) > super::MAX_STATIC_ALIGN as i64 {
            return Err(self.compile_err(format!(
                "requested alignment {} exceeds the supported maximum of {}",
                req_align.max(type_align),
                super::MAX_STATIC_ALIGN
            )));
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
            return Err(self.compile_err(format!(
                "requested alignment {alignas_align} is less than the minimum \
                 alignment {natural} of the declared type"
            )));
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
            self.align_data_to(want_align);
            self.data_align = self.data_align.max(want_align);
        }
    }

    /// Record an over-aligned automatic object's frame slot so it is placed
    /// in the over-aligned frame region. A variable-length array's storage is
    /// carved by a 16-byte-rounded sp move, so an element alignment up to 16
    /// is already met and needs no record; above 16 the storage cannot be
    /// placed and is rejected.
    pub(super) fn record_over_aligned_local(
        &mut self,
        loc_idx: usize,
        ty: i64,
        auto_align: i64,
    ) -> Result<(), C5Error> {
        if self.symbols[loc_idx].is_vla {
            if auto_align <= 16 {
                return Ok(());
            }
            return Err(self.compile_err(
                "an over-aligned variable-length array is not supported; \
                 use static storage or a fixed size",
            ));
        }
        let slot = self.symbols[loc_idx].val;
        let asz = self.symbols[loc_idx].array_size;
        let size = self.local_storage_slots(ty, asz) * 8;
        self.func_over_aligned.push((slot, auto_align, size));
        Ok(())
    }

    /// Parse one declaration inside a function body: the declaration
    /// specifiers, then a comma-separated declarator list each with an
    /// optional initializer. The innermost open scope -- `block_scopes`
    /// when a nested block or `for`-init level is open, the
    /// function-body scope (shared with the parameters, C99 6.2.1p4)
    /// otherwise -- receives the bindings and the saved outer state its
    /// exit restores.
    pub(super) fn parse_local_decl(&mut self, maybe_unused: bool) -> Result<(), C5Error> {
        let mut is_static = false;
        let mut is_extern = false;
        let mut is_thread_local = false;
        let mut saw_specifier = false;
        let mut qual_bits: i64 = 0;
        // Reset the per-declaration carriers; a stale one from the
        // enclosing function would bleed onto a static's emission record.
        self.pending.base_is_const = false;
        let _ = self.take_base_spelling();
        self.pending.saw_register_storage = false;
        self.pending.attr_used = false;
        self.pending.attr_section = None;
        self.pending.attr_patchable_entry = None;
        self.pending.attr_no_instrument = false;
        self.pending.attr_weak = false;
        self.pending.attr_visibility = None;
        self.pending.attr_constructor = false;
        self.pending.attr_destructor = false;
        self.pending.attr_init_priority = None;
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
        // K&R implicit int (`register n = ...;`). Gated on an explicit
        // specifier so a mistyped type name still surfaces as an error.
        let base = if !self.lex_is_type_start() && saw_specifier {
            Ty::Int as i64
        } else {
            self.parse_decl_base_type()?
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
        let base_typedef_fn_proto = self.pending.typedef_fn_proto;
        let base_fn_ptr_param_types = self.pending.fn_ptr_param_types.clone();
        // C99 6.7p1 / 6.2.2p5: a block-scope `[*]name(params);` is a
        // function declaration with external (internal if `static`)
        // linkage; bind it and let the call resolve at link time.
        if self.try_parse_block_fn_prototype(lbt, is_static)? {
            return Ok(());
        }
        // A leading `cleanup(fn)` applies to every declarator; one written
        // after a declarator applies to it alone.
        let leading_cleanup = self.pending.attr_cleanup.take();
        while self.lex.tk != ';' {
            self.pending.fn_ptr_indirection = base_fn_ptr_indirection;
            self.pending.fn_ptr_ret_indirection = base_fn_ptr_ret_indirection;
            self.pending.base_is_function_type = base_is_function_type;
            self.pending.typedef_fn_proto = base_typedef_fn_proto;
            self.pending.fn_ptr_param_types = base_fn_ptr_param_types.clone();
            // C99 6.7.6.2: a non-constant dimension here is a VLA. Save
            // and restore rather than set and clear: evaluating an outer
            // dimension can parse a nested block declaration (a statement
            // expression inside the dimension), and that inner declarator
            // must not clear the outer one's flag.
            let saved_vla = core::mem::replace(&mut self.pending.vla_allowed, true);
            let (loc_idx, ty, mut array_size) = self.parse_declarator(lbt)?;
            self.pending.vla_allowed = saved_vla;
            // C99 6.7.1p5 + 6.9.1: a declarator of bare function type (a
            // function-TYPE typedef with no pointer level) declares a
            // function, not an object; classifying it as data would make a
            // use of the name load code bytes. Bind it as
            // `try_parse_block_fn_prototype` binds the `name(params)` form.
            if core::mem::take(&mut self.pending.bare_function_type_declarator) {
                let params = self.pending.fn_ptr_param_types.take().unwrap_or_default();
                let is_variadic = self
                    .pending
                    .typedef_fn_proto
                    .take()
                    .map(|(_, variadic)| variadic)
                    .unwrap_or(false);
                self.pending.fn_ptr_indirection = None;
                self.pending.fn_ptr_ret_indirection = 0;
                if loc_idx == usize::MAX {
                    self.accept_declarator_separator()?;
                    continue;
                }
                let c = self.symbols[loc_idx].class;
                let known = c == Token::Sys as i64
                    || c == Token::Fun as i64
                    || c == Token::Glo as i64
                    || c == Token::Loc as i64;
                if !known {
                    // The name has block scope (C99 6.2.1p4); the
                    // declared entity survives the unbind on the slot.
                    self.rebind_scoped(loc_idx)?;
                    let sym = &mut self.symbols[loc_idx];
                    sym.class = Token::Fun as i64;
                    sym.scoped_fn_decl = true;
                    // Undo the typedef's pre-decay to pointer-to-function.
                    sym.type_ = ty - Ty::Ptr as i64;
                    sym.params = params;
                    sym.is_variadic = is_variadic;
                    sym.is_extern_decl = true;
                    sym.linkage = if is_static {
                        crate::c5::symbol::Linkage::Internal
                    } else {
                        crate::c5::symbol::Linkage::External
                    };
                }
                // The declaration names the file-scope entity unless it
                // shadows a local; attributes (`weak`, visibility) attach
                // to that entity, as on the extern-object path.
                if c != Token::Loc as i64 {
                    self.apply_symbol_attributes(loc_idx);
                }
                self.accept_declarator_separator()?;
                continue;
            }
            let asm_reg = self.parse_register_asm_binding(loc_idx, is_static, is_extern)?;
            // Trailing cleanup wins for this declarator; else the leading one.
            let cleanup_fn = self.pending.attr_cleanup.take().or(leading_cleanup);
            if maybe_unused && loc_idx != usize::MAX {
                self.symbols[loc_idx].maybe_unused = true;
            }
            // Take the fn-pointer carriers before any initializer is parsed:
            // an initializer cast runs a base-type parse that clears them,
            // which would drop a variadic fn-pointer's prototype.
            let fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
            let fn_ptr_ret_indirection = core::mem::take(&mut self.pending.fn_ptr_ret_indirection);
            let fnptr_proto = self.pending.typedef_fn_proto.take();
            let fnptr_param_types = self.pending.fn_ptr_param_types.take();
            // C99 6.7.7p3 + 6.7.6.1: an array typedef contributes its
            // dimension only when the declarator stayed at the element type;
            // a `*` names a pointer-to-element and the dimension belongs to
            // the pointee. Peek without clearing so the rest of the comma
            // list keeps it.
            let typedef_dim = self.pending.typedef_base_array_size;
            self.check_array_elem_align(array_size, ty, typedef_dim, base_type_align)?;
            if typedef_dim > 0 && array_size == 0 && self.pending.declarator_leading_ptr_count == 0
            {
                array_size = typedef_dim;
                self.apply_typedef_array_dims(loc_idx);
            }
            self.ty = ty;

            // C99 6.2.1p4 / 6.2.2p4: a block-scope `extern` names the
            // file-scope entity. Three prior states differ -- an existing
            // `Glo`/`Fun` binding is that entity already; a never-declared
            // name (`Id`) is converted and left bound past the scope, since
            // this is its only binding; any other bound name (local,
            // parameter, enum constant, typedef) must be saved and restored,
            // with in-scope references routed through `block_extern_refs`.
            let prior_class = self.symbols[loc_idx].class;
            let convert_extern =
                is_extern && prior_class != Token::Glo as i64 && prior_class != Token::Fun as i64;
            let extern_shadows_binding = convert_extern && prior_class != Token::Id as i64;

            // An extern naming an existing entity declares nothing new, so
            // none of the per-declarator writes below apply to it.
            let rebinds_slot = !is_extern || convert_extern;

            // C99 6.7p3: an identifier with no linkage is declared once per
            // scope. An `extern` redeclaration has linkage and is exempt.
            if !is_extern && self.binds_in_current_scope(loc_idx) {
                return Err(self.compile_err("duplicate local definition"));
            }
            // Save the outer binding of any name this declarator rebinds.
            // The two exempt cases both leave nothing to restore: an extern
            // naming an existing entity writes nothing, and one naming a
            // never-declared name is deliberately left bound past the scope.
            if !is_extern || extern_shadows_binding {
                self.save_scope_binding(loc_idx);
            }

            // C99 6.7p7: an object declared with no linkage must have a
            // complete type by the end of its declarator. A block-scope
            // `extern` has linkage and declares no object, so it is exempt.
            if !is_extern && self.incomplete_aggregate_tag(ty).is_some() {
                let name = self.symbols[loc_idx].name.clone();
                return Err(self.compile_err(format!("object `{name}` has incomplete type")));
            }

            // A block-scope `extern` allocates no storage (C11 6.7.5).
            let decl_align = if is_extern {
                None
            } else {
                Some(self.resolve_decl_align(ty, is_static, base_type_align)?)
            };

            if is_extern {
                if convert_extern {
                    self.symbols[loc_idx].class = Token::Glo as i64;
                    self.symbols[loc_idx].type_ = ty;
                    self.symbols[loc_idx].decl_spelling = self.decl_spelling(base_spelling);
                    // Record the dimension so a subscript sees an array
                    // (6.7.6.2). `-1` (unsized `extern T name[];`) is kept as
                    // at file scope: an incomplete array still decays to a
                    // pointer, while 0 would read the name as a scalar.
                    self.symbols[loc_idx].array_size = array_size;
                    if extern_shadows_binding {
                        // Carry no in-unit offset and leave `is_extern_decl`
                        // / `linkage` untouched so the restore is exact.
                        self.symbols[loc_idx].val = 0;
                        self.symbols[loc_idx].block_extern_active = true;
                    } else {
                        // External linkage routes `&name` to a name-keyed
                        // relocation; without it every block-scope extern
                        // collapses onto the same `.data` base.
                        self.symbols[loc_idx].is_extern_decl = true;
                        self.symbols[loc_idx].linkage = crate::c5::symbol::Linkage::External;
                    }
                }
                // `weak` / `visibility("hidden")` are not part of the shadow
                // snapshot, so they persist to the object symbol table. A
                // shadowed bound name never reaches it, so skip that case.
                if !extern_shadows_binding {
                    self.apply_symbol_attributes(loc_idx);
                }
            } else if is_static {
                self.symbols[loc_idx].class = Token::Glo as i64;
                self.symbols[loc_idx].type_ = ty;
                self.symbols[loc_idx].decl_spelling = self.decl_spelling(base_spelling);
                self.symbols[loc_idx].is_thread_local = is_thread_local;
                // C99 6.2.4p3: static storage, block scope. The function-body
                // scope's restore pass is gated on class `Loc`, which a
                // static local no longer carries, so mark it; a nested block
                // unbinds it from its own shadow stack instead.
                self.symbols[loc_idx].is_scope_bound |= self.block_scopes.is_empty();
                // A `static const` integer folds its `.data` value into a
                // later constant expression, so `char buf[N * 2 + 1]` is a
                // fixed array rather than a VLA. Static storage plus a const
                // object type also makes the initializer the value for the
                // whole execution, as at file scope.
                self.symbols[loc_idx].is_const_qualified = self.pending.base_is_const
                    && array_size == 0
                    && super::types::is_integer_scalar_ty(ty);
                self.symbols[loc_idx].storage_is_const = self.pending.declarator_outer_const
                    || (self.pending.base_is_const && !super::types::is_pointer_ty(ty));
                if let Some(a) = &decl_align {
                    self.apply_static_local_align(loc_idx, ty, a);
                    // Declared object alignment for `__alignof__` on the
                    // name; distinct from the placement above, which never
                    // drops below the natural alignment.
                    self.symbols[loc_idx].type_align = a.obj_align.max(0);
                }
                self.static_duration_init += 1;
                let r = self.allocate_static_local(loc_idx, ty, array_size);
                self.static_duration_init -= 1;
                r?;
                self.push_block_static_record(loc_idx, ty);
                self.ast_emit_static_local_decl(loc_idx as u32);
            } else {
                // TR 18037 5.1.2 (GCC named address spaces): an object
                // in `__seg_gs` / `__seg_fs` needs static storage; a
                // frame slot has no segment.
                if super::types::segment_of_object_ty(ty).is_some() {
                    return Err(self.compile_err("a named address space requires static storage"));
                }
                self.symbols[loc_idx].class = Token::Loc as i64;
                self.symbols[loc_idx].type_ = ty;
                self.symbols[loc_idx].decl_spelling = self.decl_spelling(base_spelling);
                self.symbols[loc_idx].was_referenced = false;
                self.symbols[loc_idx].decl_line = self.lex.line;
                let decl_file = self.intern_source_file() as u32;
                self.symbols[loc_idx].decl_file = decl_file;
                self.symbols[loc_idx].decl_in_main_source = self.in_main_source();
                // Unconditional write so a reused symbol slot does not leak
                // a stale binding from an outer name.
                self.symbols[loc_idx].asm_register = asm_reg;
                // Declared object alignment for `__alignof__` on the name.
                // Unconditional for the same slot-reuse reason; written
                // before the initializer parse, which may itself take
                // `__alignof__` of the name.
                self.symbols[loc_idx].type_align =
                    decl_align.as_ref().map(|a| a.obj_align.max(0)).unwrap_or(0);
                self.check_register_asm_init(asm_reg)?;
                // A `const` scalar arithmetic auto local with a constant
                // initializer records its value for the case-label /
                // `static_assert` fold (see `const_object_fold`).
                // Unconditional write so a reused slot leaks no stale
                // value from an outer binding.
                self.symbols[loc_idx].const_object_value = None;
                if self.pending.base_is_const
                    && array_size == 0
                    && asm_reg.is_none()
                    && !super::types::is_volatile_ty(ty)
                    && (super::types::is_integer_scalar_ty(ty)
                        || super::types::is_floating_scalar(ty))
                    && self.lex.tk == Token::Assign
                {
                    self.symbols[loc_idx].const_object_value =
                        self.try_fold_const_object_init(ty)?;
                }
                // This declaration can sit inside an enclosing aggregate's
                // element initializer (an element that is a statement
                // expression), so keep the carriers reentrant.
                let saved = self.take_pending_local_carriers();
                let r = self.allocate_local_with_init(loc_idx, ty, array_size);
                if r.is_ok() {
                    self.finalize_local_init(loc_idx);
                }
                self.restore_pending_local_carriers(saved);
                r?;
                // C11 6.7.5: an automatic object aligned past the 8-byte
                // frame slot goes in the over-aligned frame region, recorded
                // now that its slot is assigned.
                if let Some(a) = decl_align.as_ref().filter(|a| a.region_auto) {
                    self.record_over_aligned_local(loc_idx, ty, a.auto_align)?;
                }
            }
            // Written after any initializer parse, so an init expression's
            // own symbol lookups cannot clobber them, and unconditionally, so
            // a reused slot leaks no stale flag from an outer binding. `T x[]`
            // whose initializer resolved to zero elements keeps its
            // array-ness through `is_zero_len_array`; the fn-pointer
            // prototype is inherited only when variadic, since a non-variadic
            // indirect call places every argument as fixed and placeholder
            // parameter types would fail the argument check.
            if rebinds_slot {
                self.symbols[loc_idx].is_zero_len_array =
                    array_size == -1 && self.symbols[loc_idx].array_size == 0;
                self.symbols[loc_idx].fn_ptr_indirection = fn_ptr_indirection;
                self.symbols[loc_idx].fn_ptr_ret_indirection = fn_ptr_ret_indirection;
                if let Some(types) = fnptr_param_types {
                    self.symbols[loc_idx].params = types;
                    self.symbols[loc_idx].is_variadic = matches!(fnptr_proto, Some((_, true)));
                } else if let Some((proto_fixed, true)) = fnptr_proto {
                    self.symbols[loc_idx].params = alloc::vec![0i64; proto_fixed];
                    self.symbols[loc_idx].is_variadic = true;
                }
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
                return Err(self.compile_err("`__auto_type` declaration takes a single declarator"));
            }
            self.accept_declarator_separator()?;
        }
        self.next()?;
        self.pending.auto_type_single_declarator = false;
        Ok(())
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
            || self.lex.tk == Token::TypeQual
        {
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

    /// Promote a `static T name [ = init];` local to a Glo-class
    /// global with persistent storage in the data segment. The
    /// symbol's binding lives only inside the current function's
    /// scope (the function-body cleanup pass restores `h_class`
    /// etc.); the storage itself stays allocated for the program
    /// lifetime, so subsequent calls re-enter the same slot.
    ///
    /// The initializer follows file-scope rules -- integer
    /// constants, string literals, &globals, or a brace list for
    /// arrays. Function-pointer init values aren't yet supported
    /// for static locals (the file-scope path handles them, but
    /// the routing through `parse_global_initializer` here only
    /// covers scalars).
    /// Push the persistent emission record of a block-scope static: a
    /// `name.<n>` internal symbol carrying the object's offset, extent,
    /// and `used` / `section` attributes past the scope-exit restore of
    /// the scoped binding (toolchains emit the same `name.N` locals).
    /// Function close stamps `owner_ent_pc`; static DCE then treats the
    /// object as a per-instance part of its function. Thread-locals are
    /// skipped: their `val` is a TLS offset outside the `.data` model.
    pub(super) fn push_block_static_record(&mut self, loc_idx: usize, ty: i64) {
        if self.symbols[loc_idx].is_thread_local {
            return;
        }
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
        self.symbols.push(crate::c5::symbol::Symbol {
            name,
            token: Token::Id as i64,
            class: Token::Glo as i64,
            type_: ty,
            val: self.symbols[loc_idx].val,
            array_size: final_array,
            is_zero_len_array: zero_len,
            reserved_data_bytes: reserved,
            fam_init_bytes: fam_tail,
            data_align: self.symbols[loc_idx].data_align,
            linkage: crate::c5::symbol::Linkage::Internal,
            defined_here: true,
            has_initializer: true,
            runtime_initialized: self.symbols[loc_idx].runtime_initialized,
            storage_is_const: self.symbols[loc_idx].storage_is_const,
            ..Default::default()
        });
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
        // `.tbss`), like a file-scope thread-local, not in `.data`.
        let is_tls = self.symbols[loc_idx].is_thread_local;
        if array_size != -1 {
            if is_tls {
                let off = self.tls_data.len() as i64;
                self.symbols[loc_idx].val = off;
                for _ in 0..bytes {
                    self.tls_data.push(0);
                }
            } else {
                if self.size_of_type(ty) > 1 {
                    self.align_data_to_8();
                }
                let off = self.data.len() as i64;
                self.symbols[loc_idx].val = off;
                self.symbols[loc_idx].reserved_data_bytes = bytes;
                for _ in 0..bytes {
                    self.data.push(0);
                }
            }
        }

        // The initializer path below writes into `.data`; a thread-local's
        // slot is in `tls_data`, so an initialized block-scope thread-local
        // would land in the wrong segment. It is not needed by current
        // consumers (which declare uninitialized `static __thread` objects),
        // so reject it rather than mis-place the bytes.
        if is_tls && self.lex.tk == Token::Assign {
            return Err(self.compile_err(
                "an initializer on a block-scope `_Thread_local` object is not yet supported",
            ));
        }
        if self.lex.tk == Token::Assign {
            self.next()?;
            // A `&&label` element (GCC labels as values) is a link-time
            // constant: the data image gets a label relocation, as it
            // does for `&func`. Only a genuinely non-constant element
            // alongside one still needs stores at the declaration point.
            if self.lex.tk == '{'
                && self.array_init_has_label_addr()?
                && self.array_init_needs_runtime()?
            {
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
                        return Err(self.compile_err("array initializer must start with `{{`"));
                    }
                    let sid = struct_id_of(ty);
                    // Elements below the outer (deferred) dimension: for a 2D
                    // struct array `T xs[][M]` each top-level brace is a row of
                    // `inner_dim` structs. 1 for a plain `T xs[]`.
                    let inner_dim: i64 = self.symbols[loc_idx]
                        .array_dims
                        .get(1..)
                        .map(|s| s.iter().product::<i64>())
                        .unwrap_or(1)
                        .max(1);
                    // C99 6.7.8p20 brace elision: with no per-element
                    // braces the flat value list fills consecutive struct
                    // elements, each consuming the struct's slot count.
                    let groups = self.lex.count_top_level_groups_in_array();
                    let count = if groups > 0 {
                        // `[N]` designators can push the size past the
                        // positional group count (C99 6.7.8p22).
                        self.designated_array_count(groups as i64, 1)?
                    } else {
                        let items = self.lex.count_top_level_items_in_array();
                        let slots = self.struct_flat_init_slots(sid).max(1);
                        items.div_ceil(slots) as i64
                    };
                    // Reserve before consuming `{`: lexing the first element
                    // token may append a string literal's bytes, whose
                    // parser-added NUL must land right after them.
                    self.align_data_to_8();
                    let off = self.data.len() as i64;
                    self.symbols[loc_idx].val = off;
                    self.symbols[loc_idx].reserved_data_bytes =
                        count * inner_dim * elem_size as i64;
                    for _ in 0..(count * inner_dim * elem_size as i64) {
                        self.data.push(0);
                    }
                    self.next()?;
                    // Multi-dimensional struct array: fill the rows below the
                    // deferred outer dimension through the shared struct-array
                    // walker (designators at every level). The pre-scan counts
                    // each top-level entry as a row, but an entry after a
                    // chained designator resumes mid-row (C99 6.7.8p17), so
                    // the walker's extent is the real outer count (p22).
                    if inner_dim > 1 {
                        let mut dims = alloc::vec::Vec::new();
                        dims.push(count);
                        dims.extend_from_slice(&self.symbols[loc_idx].array_dims[1..]);
                        let high = self.collect_struct_array_entries(ty, off, &dims)?;
                        let rows = (high + inner_dim - 1) / inner_dim;
                        if rows < count
                            && self.data.len() as i64 == off + count * inner_dim * elem_size as i64
                        {
                            self.truncate_data(
                                (off + rows * inner_dim * elem_size as i64) as usize,
                            );
                            self.symbols[loc_idx].reserved_data_bytes =
                                rows * inner_dim * elem_size as i64;
                        }
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
                    let mut i: i64 = 0;
                    while self.lex.tk != '}' {
                        // C99 6.7.8p7 `[N] =` (or GNU `[lo ... hi] =`)
                        // designator jumps the cursor; `[N].field... =`
                        // initializes one member of each designated element.
                        if let Some((lo, hi, chain)) = self.take_array_element_designator(count)? {
                            if chain || hi > lo {
                                self.fill_element_range(
                                    sid,
                                    ty,
                                    off,
                                    elem_size as i64,
                                    lo..=hi,
                                    chain,
                                )?;
                                i = hi + 1;
                                self.accept(',')?;
                                continue;
                            }
                            i = lo;
                        }
                        let here = off + i * elem_size as i64;
                        self.init_struct_array_element(sid, here)?;
                        i += 1;
                        self.accept(',')?;
                    }
                    self.next()?;
                    self.set_deferred_static_local_count(loc_idx, count);
                    while !self.data.len().is_multiple_of(8) {
                        self.data.push(0);
                    }
                    return Ok(());
                }
                self.pending.init_inner_dims = self.inner_dims_of(loc_idx);
                let elements = self.collect_array_initializer(ty)?;
                let final_size = elements.len() as i64;
                let total_bytes = (self.size_of_type(ty) as i64) * final_size;
                let aligned = ((total_bytes + 7) / 8) * 8;
                if self.size_of_type(ty) > 1 {
                    self.align_data_to_8();
                }
                let off = self.data.len() as i64;
                self.symbols[loc_idx].val = off;
                self.symbols[loc_idx].reserved_data_bytes = aligned;
                for _ in 0..aligned {
                    self.data.push(0);
                }
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
                    return Err(self.compile_err("array initializer must start with `{{`"));
                }
                self.next()?;
                let mut full_dims = alloc::vec::Vec::with_capacity(inner_dims.len() + 1);
                full_dims.push(group_count);
                full_dims.extend_from_slice(&inner_dims);
                self.collect_struct_array_entries(ty, var_offset, &full_dims)?;
            } else if array_size > 0 {
                self.pending.init_inner_dims = self.inner_dims_of(loc_idx);
                self.pending.init_target_array_size = array_size;
                let elements = self.collect_array_initializer(ty)?;
                // C99 6.7.8p2: the initializer may not provide a value for an
                // object outside the entity being initialized. The storage
                // reserved above holds `array_size` elements, so a longer list
                // would be written past it (the file-scope, automatic and
                // compound-literal paths reject it here too).
                if elements.len() as i64 > array_size {
                    return Err(self.compile_err(format!(
                        "too many initializers for array `{}` ({} > {})",
                        self.symbols[loc_idx].name,
                        elements.len(),
                        array_size
                    )));
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
                self.parse_global_initializer(ty, var_offset, false)?;
            }
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
        self.restore_lex(snap);
        self.truncate_data(data_snap);
        Ok(found)
    }

    /// Fill a static-local array whose initializer mixes a `&&label`
    /// element with one whose value only the running program knows, using
    /// runtime stores at the declaration point. The data image holds
    /// zeros; each element is parsed through the expression grammar (so
    /// `&&label` yields a block-address node) and stored into `arr[i]` via
    /// an `Expr::Assign` the walker lowers to a global address store. A
    /// constant element is stored the same way. An initializer whose
    /// elements are all link-time constants goes through the data image
    /// and its relocations instead.
    ///
    /// C99 6.2.4p3: static storage duration means one initialization for
    /// the whole program run, so the stores are wrapped in a hidden
    /// once-guard: a guard byte placed directly after the array's storage
    /// (same data object -- no object start in between -- so data DCE and
    /// linker rebase move it with the array). The whole declaration
    /// lowers to a single statement `guard ? 0 : (e0, ..., en, guard = 1)`
    /// because the enclosing declaration parse captures every pushed
    /// stmt id as a top-level block item.
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
            self.align_data_to_8();
            let off = self.data.len() as i64;
            self.symbols[loc_idx].val = off;
            self.symbols[loc_idx].array_size = c;
            for _ in 0..(c * elem_size) {
                self.data.push(0);
            }
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
                self.next()?;
                let a = self.parse_constant_int_folding_const_objects()?;
                if a < 0 {
                    return Err(self.compile_err(format!(
                        "array designator index must be non-negative (got {a})"
                    )));
                }
                let mut b = a;
                if self.lex.tk == Token::Ellipsis {
                    self.next()?;
                    b = self.parse_constant_int_folding_const_objects()?;
                    if b < a {
                        return Err(self.compile_err(format!(
                            "array range designator high {b} below low {a}"
                        )));
                    }
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("`]` expected after array designator index"));
                }
                self.next()?;
                if self.lex.tk != Token::Assign {
                    return Err(self.compile_err("`=` expected after array designator"));
                }
                self.next()?;
                i = a;
                range_end = b;
            }
            if range_end >= count {
                return Err(self.compile_err(format!(
                    "too many initializers for `{}`",
                    self.symbols[loc_idx].name
                )));
            }
            if self.lex.tk == '{' {
                // TODO: descend into a brace-enclosed element and store it
                // field by field. Only a non-constant element reaches here,
                // so the list is one whose elements need runtime stores.
                return Err(self.compile_err(format!(
                    "brace-enclosed element in the runtime-initialized static \
                     array `{}` is not yet supported",
                    self.symbols[loc_idx].name
                )));
            }
            self.expr(Token::Assign as i64)?;
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
            self.accept(',')?;
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

    /// Reserve frame storage for a local declarator and emit any
    /// initializer that follows. Three shapes:
    ///   * non-array: `slots_of_type(ty)` slots; optional scalar /
    ///     pointer / struct initializer via `emit_local_init_store`.
    ///   * known-size array (`int xs[5] = {...};` /
    ///     `char buf[16] = "...";`): allocate `array_size *
    ///     elem_size` bytes; the optional initializer populates the
    ///     leading positions, the rest is left in whatever state
    ///     the stack frame had on entry (c5 doesn't yet zero-init
    ///     local arrays beyond what the initializer covers).
    ///   * deferred-size array (`int xs[] = {...};`): the
    ///     initializer determines the dimension first, then storage
    ///     is reserved.
    /// C99 6.7.6.2 variable-length array local. Reserves two hidden
    /// frame slots -- the runtime base pointer and the runtime byte
    /// count -- and records a `Decl::Vla`; the walker allocates the
    /// storage from the per-frame alloca arena. The array is not
    /// promotable and its storage is reclaimed on block exit by the
    /// scope bracket `parse_block_stmt` emits.
    fn allocate_vla_local(&mut self, loc_idx: usize, elem_ty: i64) -> Result<(), C5Error> {
        // C99 6.7.8p3: a VLA declaration may not carry an initializer.
        if self.lex.tk == Token::Assign {
            return Err(self.compile_err("a variable-length array may not have an initializer"));
        }
        let dim = match self.pending.vla_dim_expr.take() {
            Some(d) => d,
            None => return Err(self.compile_err("variable-length array has no dimension")),
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
        s.was_written = true;
        s.address_escaped = true;
        self.func_vla_decls += 1;
        // The VLA storage comes from the per-frame alloca arena, so the
        // function reserves the arena and its bookkeeping slot.
        self.uses_alloca_in_current_fn = true;
        self.ast_emit_vla_decl(loc_idx as u32, elem_ty, elem_size, ptr_slot, size_slot, dim);
        Ok(())
    }

    /// Count the elements the brace list at the current `{` holds for
    /// a struct array, walking entry types the same way the fill loop
    /// does: an expression of the element type is one element (C99
    /// 6.7.8p13); other values flat-fill fields, one element per
    /// `struct_flat_init_slots` run (6.7.8p20). Restores the lexer.
    /// `None` when a designator or brace entry appears -- those lists
    /// keep the caller's group- or slot-based estimate.
    fn count_struct_array_init_elems(&mut self, sid: usize) -> Result<Option<i64>, C5Error> {
        debug_assert!(self.lex.tk == '{');
        let snap = self.lex.snapshot();
        // The token walk appends string-literal bytes to `data`; rewind
        // them on exit as `designated_array_count` does.
        let saved_data = self.data.len();
        let saved_pc = self.next_ent_pc;
        let slots = self.struct_flat_init_slots(sid).max(1) as i64;
        self.next()?; // `{`
        let mut elems: i64 = 0;
        let mut fields: i64 = 0;
        let mut walked = Some(());
        while self.lex.tk != '}' && self.lex.tk != 0 {
            if self.lex.tk == '{' || self.lex.tk == Token::Brak || self.lex.tk == Token::Dot {
                walked = None;
                break;
            }
            let is_elem = match self.peek_expr_type() {
                Ok(t) => is_struct_value_ty(t) && struct_id_of(t) == sid,
                Err(_) => false,
            };
            if is_elem {
                if fields > 0 {
                    elems += 1;
                    fields = 0;
                }
                elems += 1;
            } else {
                fields += 1;
                if fields == slots {
                    elems += 1;
                    fields = 0;
                }
            }
            self.skip_init_element_value()?;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        if fields > 0 {
            elems += 1;
        }
        self.truncate_data(saved_data);
        self.next_ent_pc = saved_pc;
        self.restore_lex(snap);
        Ok(walked.map(|_| elems))
    }

    /// If the next brace-list entry is an array designator `[N]` or a
    /// GNU range `[lo ... hi]`, consume it and return `(lo, hi, chain)`
    /// (`hi == lo` for the single form). A following `= value` consumes
    /// the `=` and returns `chain == false`; a C99 6.7.8p7 designator
    /// list continuing into the element (`[N].field... =`) leaves the
    /// cursor on the `.`/`[` and returns `chain == true` for the caller
    /// to resolve. Shared by the deferred-local struct-array fill loops
    /// -- the file-scope path carries the same logic inline.
    fn take_array_element_designator(
        &mut self,
        count: i64,
    ) -> Result<Option<(i64, i64, bool)>, C5Error> {
        if self.lex.tk != Token::Brak {
            return Ok(None);
        }
        self.next()?; // `[`
        let idx = self.parse_constant_int_folding_const_objects()?;
        let mut hi = idx;
        if self.lex.tk == Token::Ellipsis {
            self.next()?;
            hi = self.parse_constant_int_folding_const_objects()?;
        }
        if idx < 0 || hi < idx || hi >= count {
            return Err(self.compile_err(format!(
                "array designator index {idx}..{hi} out of bounds [0, {count})"
            )));
        }
        if self.lex.tk != ']' {
            return Err(self.compile_err("`]` expected after array designator index"));
        }
        self.next()?; // `]`
        if self.lex.tk == Token::Dot || self.lex.tk == Token::Brak {
            return Ok(Some((idx, hi, true)));
        }
        if self.lex.tk != Token::Assign {
            return Err(self.compile_err("`=` expected after `[N]` designator"));
        }
        self.next()?; // `=`
        Ok(Some((idx, hi, false)))
    }

    /// Fill elements `lo..=hi` of a struct array staged in `self.data`
    /// from one source-level entry, re-parsing the entry per element
    /// through a lexer snapshot. `chain` selects the designator-chain
    /// form (`.field... = v`, cursor on the `.`) over the plain value
    /// form (`{ ... }` or a flat field list, cursor on the value).
    fn fill_element_range(
        &mut self,
        sid: usize,
        ty: i64,
        base: i64,
        elem_size: i64,
        range: core::ops::RangeInclusive<i64>,
        chain: bool,
    ) -> Result<(), C5Error> {
        let hi = *range.end();
        for e in range {
            let snap = self.lex.snapshot();
            let here = base + e * elem_size;
            if chain {
                self.fill_element_field_designator(sid, ty, here)?;
            } else {
                self.init_struct_array_element(sid, here)?;
            }
            if e < hi {
                self.restore_lex(snap);
            }
        }
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
                ConstVal::Int { .. } | ConstVal::Float(_) => {
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

    pub(super) fn allocate_local_with_init(
        &mut self,
        loc_idx: usize,
        ty: i64,
        declared_array_size: i64,
    ) -> Result<(), C5Error> {
        if declared_array_size == super::VLA_ARRAY_SIZE {
            return self.allocate_vla_local(loc_idx, ty);
        }
        // C99 6.7.9: an initializer at the declaration site counts
        // as a store from the perspective of the dead-store
        // analysis. Mark before parsing the initializer so
        // every shape below (scalar, array, struct, deferred-
        // size) routes through the same flag without per-branch
        // bookkeeping.
        if self.lex.tk == Token::Assign {
            self.symbols[loc_idx].was_written = true;
            self.record_local_store(loc_idx, self.lex.line);
        }
        if declared_array_size == -1 {
            if self.lex.tk != Token::Assign {
                // GCC zero-length array `T x[0]`: a complete type holding no
                // elements, so `sizeof` is 0. Used by compile-time-assert
                // idioms such as `char ok[-offsetof(type, f)]` and by
                // conditionally-empty buffers whose guards read
                // `sizeof(buf) != 0`. Recorded with the same zero-count
                // encoding `T x[] = {}` uses; a slot is still reserved so
                // the object has an address of its own.
                //
                // Empty brackets without an initializer leave the type
                // incomplete. c5 completes it to one element rather than
                // diagnosing it.
                let zero_len = self.pending.declarator_zero_len_array;
                self.symbols[loc_idx].array_size = if zero_len { 0 } else { 1 };
                self.symbols[loc_idx].is_zero_len_array = zero_len;
                self.symbols[loc_idx].val = self.reserve_slots(self.local_storage_slots(ty, 1));
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
                let sid = struct_id_of(ty);
                // C99 6.7.8p20 brace elision: with no per-element braces
                // the flat value list fills consecutive struct elements,
                // each consuming the struct's slot count.
                let groups = self.lex.count_top_level_groups_in_array();
                let count = if groups > 0 {
                    // `[N]` designators can push the size past the positional
                    // group count (C99 6.7.8p22); the file-scope path uses the
                    // same pre-scan.
                    self.designated_array_count(groups as i64, 1)?
                } else if let Some(n) = self.count_struct_array_init_elems(sid)? {
                    // Entries may be element-typed expressions (one
                    // element each, C99 6.7.8p13) mixed with flat field
                    // values; count by walking entry types.
                    n
                } else {
                    let items = self.lex.count_top_level_items_in_array();
                    let slots = self.struct_flat_init_slots(sid).max(1);
                    items.div_ceil(slots) as i64
                };
                // C99 6.7.8p13: an automatic-storage struct array may
                // carry non-constant element initializers (`&local`, a
                // call, an indexed read). The constant stage-into-data +
                // Mcpy path below cannot represent those, so route to the
                // per-element runtime store path the known-size branch
                // uses. Mirrors the `struct V xs[N] = { ... }` handling.
                // Elements below a deferred outer dimension: for `T xs[][M]`
                // each counted top-level group is a row of `inner_dim`
                // elements (C99 6.7.8p22 sizes the outer dimension from the
                // group count).
                let inner_dims: alloc::vec::Vec<i64> = self.symbols[loc_idx]
                    .array_dims
                    .get(1..)
                    .map(|s| s.to_vec())
                    .unwrap_or_default();
                let inner_dim: i64 = inner_dims.iter().product::<i64>().max(1);
                let total = count * inner_dim;
                if self.struct_init_needs_runtime()? {
                    self.symbols[loc_idx].array_size = total;
                    self.symbols[loc_idx].val =
                        self.reserve_slots(self.local_storage_slots(ty, total));
                    let local_val = self.symbols[loc_idx].val;
                    let var_name = self.symbols[loc_idx].name.clone();
                    // Zero the whole slot (6.7.8p19 omitted-entries rule),
                    // then overlay each element's explicit fields through
                    // the shared runtime walker.
                    self.align_data_to_8();
                    let zero_off = self.data.len();
                    for _ in 0..(total as usize * elem_size) {
                        self.data.push(0);
                    }
                    self.emit_local_array_init(local_val, zero_off, total as usize * elem_size);
                    self.emit_local_array_init_runtime(
                        local_val,
                        0,
                        ty,
                        total,
                        &inner_dims,
                        &var_name,
                    )?;
                    if let Some(first) = self.symbols[loc_idx].array_dims.first_mut()
                        && *first == 0
                    {
                        *first = count;
                    }
                    return Ok(());
                }
                // Reserve the staged block before consuming `{`: lexing the
                // first element token may append a string literal's bytes,
                // whose parser-added NUL must land right after them, not
                // inside or past the block.
                self.align_data_to_8();
                let staged_off = self.data.len();
                for _ in 0..(total * elem_size as i64) {
                    self.data.push(0);
                }
                let mut dims = alloc::vec::Vec::with_capacity(inner_dims.len() + 1);
                dims.push(count);
                dims.extend_from_slice(&inner_dims);
                self.collect_struct_array_data(ty, staged_off as i64, &dims)?;
                self.symbols[loc_idx].array_size = total;
                self.symbols[loc_idx].val = self.reserve_slots(self.local_storage_slots(ty, total));
                let local_val = self.symbols[loc_idx].val;
                self.emit_local_array_init(local_val, staged_off, elem_size * total as usize);
                if let Some(first) = self.symbols[loc_idx].array_dims.first_mut()
                    && *first == 0
                {
                    *first = count;
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
                    let rows = self.designated_array_count(fallback, inner_span)?;
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
                    self.align_data_to_8();
                    let zero_off = self.data.len();
                    for _ in 0..full_bytes {
                        self.data.push(0);
                    }
                    self.emit_local_array_init(local_val, zero_off, full_bytes);
                    self.emit_local_array_init_runtime(
                        local_val, 0, ty, final_size, &inner, &var_name,
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
            self.pending.init_inner_dims = self.inner_dims_of(loc_idx);
            let elements = self.collect_array_initializer(ty)?;
            let final_size = elements.len() as i64;
            self.symbols[loc_idx].array_size = final_size;
            self.symbols[loc_idx].val =
                self.reserve_slots(self.local_storage_slots(ty, final_size));
            let local_val = self.symbols[loc_idx].val;
            let (start_addr, total_bytes) = self.pack_initializer_into_data(ty, &elements)?;
            self.emit_local_array_init(local_val, start_addr, total_bytes);
            return Ok(());
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
                    let elem_size = self.size_of_type(ty);
                    let sid = struct_id_of(ty);
                    // Pre-scan each element's brace list: if any
                    // value isn't a compile-time constant, take
                    // the per-field runtime store path. Mirrors
                    // the single-struct branch below.
                    // The struct-init scan walks balanced braces
                    // with a depth counter, so a `{ {...}, {...} }`
                    // outer brace list works the same way as a
                    // single-struct `{ ... }` initializer.
                    let needs_runtime = self.struct_init_needs_runtime()?;
                    self.align_data_to_8();
                    let staged_off = self.data.len();
                    for _ in 0..(declared_array_size as usize * elem_size) {
                        self.data.push(0);
                    }
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
                            ty,
                            declared_array_size,
                            &inner,
                            &var_name,
                        )?;
                        return Ok(());
                    }
                    // A multi-dimensional array's top-level groups are
                    // inner sub-arrays, not single structs; each spans the
                    // product of the inner dimensions (C99 6.7.8). Mirror
                    // the static-local path: recurse per inner dimension.
                    let inner_dims = self.inner_dims_of(loc_idx);
                    let inner_product: i64 = inner_dims.iter().product::<i64>().max(1);
                    let group_stride = elem_size as i64 * inner_product;
                    let group_count = declared_array_size / inner_product;
                    self.next()?; // consume outer `{`
                    let mut i: i64 = 0;
                    while self.lex.tk != '}' {
                        // C99 6.7.8p6/p7 array designator. A single `[N] =`
                        // jumps the outer cursor and fills a whole row; a
                        // multi-dimensional `[i][j]... = { ... }` indexes every
                        // dimension down to a single struct element.
                        if self.lex.tk == Token::Brak {
                            self.next()?; // `[`
                            let desig = self.parse_constant_int_folding_const_objects()?;
                            // GNU range designator `[lo ... hi]`.
                            let mut desig_hi = desig;
                            if self.lex.tk == Token::Ellipsis {
                                self.next()?;
                                desig_hi = self.parse_constant_int_folding_const_objects()?;
                            }
                            if self.lex.tk != ']' {
                                return Err(
                                    self.compile_err("`]` expected after array designator index")
                                );
                            }
                            self.next()?; // `]`
                            if desig < 0 || desig_hi < desig || desig_hi >= group_count {
                                return Err(self.compile_err(format!(
                                    "array designator index {desig}..{desig_hi} out of bounds [0, {group_count})"
                                )));
                            }
                            if self.lex.tk == Token::Brak && desig_hi == desig {
                                // Each inner subscript scales by the product of
                                // the dimensions below it; the outer `desig`
                                // scales by the whole inner product.
                                let mut elem = desig * inner_product;
                                let mut d = 0usize;
                                while self.lex.tk == Token::Brak {
                                    self.next()?; // `[`
                                    let n = self.parse_constant_int_folding_const_objects()?;
                                    if self.lex.tk != ']' {
                                        return Err(self.compile_err(
                                            "`]` expected after array designator index",
                                        ));
                                    }
                                    self.next()?; // `]`
                                    if d >= inner_dims.len() || n < 0 || n >= inner_dims[d] {
                                        return Err(self.compile_err(format!(
                                            "array designator index {n} out of bounds"
                                        )));
                                    }
                                    let scale: i64 =
                                        inner_dims.iter().skip(d + 1).product::<i64>().max(1);
                                    elem += n * scale;
                                    d += 1;
                                }
                                if d != inner_dims.len() {
                                    return Err(self.compile_err(
                                        "multi-dimensional `[i][j]` designator must index every dimension",
                                    ));
                                }
                                // C99 6.7.8p7: the designator list may continue
                                // into the element (`[i][j].field... = v`).
                                if self.lex.tk == Token::Dot {
                                    let here = staged_off as i64 + elem * elem_size as i64;
                                    self.fill_element_field_designator(sid, ty, here)?;
                                    i = desig + 1;
                                    self.accept(',')?;
                                    continue;
                                }
                                if self.lex.tk != Token::Assign {
                                    return Err(
                                        self.compile_err("`=` expected after `[i][j]` designator")
                                    );
                                }
                                self.next()?; // `=`
                                let here = staged_off as i64 + elem * elem_size as i64;
                                self.init_struct_array_element(sid, here)?;
                                i = desig + 1;
                                self.accept(',')?;
                                continue;
                            }
                            // C99 6.7.8p7 member chain on the designated
                            // element(s) (`[N].field... = v`; 1-D elements
                            // only, a row of a multi-dimensional array is
                            // not a struct object).
                            if self.lex.tk == Token::Dot && inner_dims.is_empty() {
                                self.fill_element_range(
                                    sid,
                                    ty,
                                    staged_off as i64,
                                    group_stride,
                                    desig..=desig_hi,
                                    true,
                                )?;
                                i = desig_hi + 1;
                                self.accept(',')?;
                                continue;
                            }
                            if self.lex.tk != Token::Assign {
                                return Err(self.compile_err("`=` expected after `[N]` designator"));
                            }
                            self.next()?; // `=`
                            // A range fills each designated element from the
                            // same re-parsed entry.
                            if desig_hi > desig && inner_dims.is_empty() {
                                self.fill_element_range(
                                    sid,
                                    ty,
                                    staged_off as i64,
                                    group_stride,
                                    desig..=desig_hi,
                                    false,
                                )?;
                                i = desig_hi + 1;
                                self.accept(',')?;
                                continue;
                            }
                            i = desig;
                        }
                        if i >= group_count {
                            return Err(self.compile_err(format!(
                                "too many initializers for array `{}` ({} > {})",
                                var_name,
                                i + 1,
                                group_count
                            )));
                        }
                        let here = staged_off as i64 + i * group_stride;
                        // C99 6.7.8p20: a struct element's braces may be
                        // elided, filling its fields from the flat list.
                        if !inner_dims.is_empty() {
                            if self.lex.tk == '{' {
                                self.collect_struct_array_data(ty, here, &inner_dims)?;
                            } else {
                                // C99 6.7.9p20: a row whose braces are elided takes
                                // its elements from this list and leaves the rest.
                                self.collect_struct_array_entries_braced(
                                    ty,
                                    here,
                                    &inner_dims,
                                    false,
                                )?;
                            }
                        } else {
                            self.init_struct_array_element(sid, here)?;
                        }
                        i += 1;
                        self.accept(',')?;
                    }
                    self.next()?; // consume `}`
                    self.emit_local_array_init(
                        local_val,
                        staged_off,
                        elem_size * declared_array_size as usize,
                    );
                    return Ok(());
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
                    self.align_data_to_8();
                    let zero_off = self.data.len();
                    for _ in 0..full_bytes {
                        self.data.push(0);
                    }
                    self.emit_local_array_init(local_val, zero_off, full_bytes);
                    let inner = self.inner_dims_of(loc_idx);
                    self.emit_local_array_init_runtime(
                        local_val,
                        0,
                        ty,
                        declared_array_size,
                        &inner,
                        &var_name,
                    )?;
                    return Ok(());
                }
                self.pending.init_inner_dims = self.inner_dims_of(loc_idx);
                self.pending.init_target_array_size = declared_array_size;
                let elements = self.collect_array_initializer(ty)?;
                let init_count = elements.len();
                let max = declared_array_size as usize;
                if init_count > max {
                    return Err(self.compile_err(format!(
                        "too many initializers for array `{}` ({} > {})",
                        var_name, init_count, max
                    )));
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
                self.align_data_to_8();
                let staged_off = self.data.len();
                for _ in 0..elem_size {
                    self.data.push(0);
                }
                if needs_runtime {
                    self.emit_local_array_init(local_val, staged_off, elem_size);
                    self.emit_struct_runtime_at(local_val, 0, sid, true)?;
                } else {
                    self.collect_struct_initializer(sid, staged_off as i64)?;
                    self.emit_local_array_init(local_val, staged_off, elem_size);
                }
            } else {
                self.emit_local_init_store(local_val, ty)?;
            }
        }
        Ok(())
    }

    /// Parse a C99 6.5.2.5 block-scope compound literal `(type){
    /// init }`. The `(type)` has already been parsed (`t` is the
    /// element / scalar / struct type; `array_dims` lists the bracket
    /// counts outermost first, empty for a non-array literal, with
    /// `array_dims[0] == -1` for the size-from-initializer `[]` form).
    /// The lexer is at the opening `{`. Reserves an anonymous frame
    /// slot (automatic storage, 6.5.2.5p5), captures the initializer
    /// through the shared local-init helpers, and emits an
    /// `Expr::CompoundLiteral` whose value is the object's address
    /// (array decays per 6.3.2.1p3, struct yields its address) or the
    /// loaded scalar.
    // The literal's three outputs come from one multi-branch decision;
    // binding them to its value folds that chain into a tuple expression.
    #[allow(clippy::needless_late_init)]
    pub(super) fn parse_block_compound_literal(
        &mut self,
        t: i64,
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
            let count;
            if array_dims[0] == -1 {
                if self.lex.tk != '{' {
                    return Err(self.compile_err("`{` expected in compound literal"));
                }
                let (scan_count, needs_runtime) = self.scan_array_init()?;
                // C99 6.7.8p22: designators can push the size past the
                // positional entry count; brace elision folds a flat run
                // into one row of the inner span. The scan count tallies
                // leaves, not rows, so it is no floor for a multi-dim
                // literal.
                let fallback = if inner_span > 1 { 0 } else { scan_count };
                let rows = self.designated_array_count(fallback, inner_span)?;
                count = rows * inner_span;
                slot = self.reserve_slots(self.local_storage_slots(elem_ty, count));
                if needs_runtime {
                    let full = elem_size * count as usize;
                    self.align_data_to_8();
                    let zero_off = self.data.len();
                    for _ in 0..full {
                        self.data.push(0);
                    }
                    self.emit_local_array_init(slot, zero_off, full);
                    self.emit_local_array_init_runtime(
                        slot,
                        0,
                        elem_ty,
                        count,
                        inner_dims,
                        "<compound literal>",
                    )?;
                } else {
                    self.pending.init_inner_dims = inner_dims.to_vec();
                    let elements = self.collect_array_initializer(elem_ty)?;
                    let full = elem_size * count as usize;
                    let (start, packed) = self.pack_initializer_into_data(elem_ty, &elements)?;
                    // C99 6.7.8p21: positions the list leaves out are
                    // zero; pad so the single Mcpy covers the object.
                    let total = if packed < full {
                        for _ in 0..(full - packed) {
                            self.data.push(0);
                        }
                        full
                    } else {
                        packed
                    };
                    self.emit_local_array_init(slot, start, total);
                }
            } else {
                count = array_dims[0] * inner_span;
                let full = elem_size * count as usize;
                slot = self.reserve_slots(self.local_storage_slots(elem_ty, count));
                if self.lex.tk == '{' && self.array_init_needs_runtime()? {
                    self.align_data_to_8();
                    let zero_off = self.data.len();
                    for _ in 0..full {
                        self.data.push(0);
                    }
                    self.emit_local_array_init(slot, zero_off, full);
                    self.emit_local_array_init_runtime(
                        slot,
                        0,
                        elem_ty,
                        count,
                        inner_dims,
                        "<compound literal>",
                    )?;
                } else {
                    self.pending.init_target_array_size = count;
                    self.pending.init_inner_dims = inner_dims.to_vec();
                    let elements = self.collect_array_initializer(elem_ty)?;
                    if elements.len() as i64 > count {
                        return Err(self.compile_err(format!(
                            "too many initializers for compound literal ({} > {count})",
                            elements.len()
                        )));
                    }
                    let (start, packed) = self.pack_initializer_into_data(elem_ty, &elements)?;
                    let total = if packed < full {
                        for _ in 0..(full - packed) {
                            self.data.push(0);
                        }
                        full
                    } else {
                        packed
                    };
                    self.emit_local_array_init(slot, start, total);
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
            slot = self.reserve_slots(cl_slots);
            if cl_slots >= 1 {
                self.multi_cell_temps.push((slot, cl_slots));
            }
            let needs_runtime = self.struct_init_needs_runtime()?;
            self.align_data_to_8();
            let staged = self.data.len();
            for _ in 0..elem_size {
                self.data.push(0);
            }
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
            slot = self.reserve_slots(self.slots_of_type(t));
            if self.lex.tk != '{' {
                return Err(self.compile_err("`{` expected in compound literal"));
            }
            self.next()?;
            self.expr(Token::Assign as i64)?;
            self.convert_assign_rhs(t);
            self.pending_local_init_ast = self.ast_acc;
            self.accept(',')?;
            if self.lex.tk != '}' {
                return Err(self.compile_err("`}` expected to close compound literal"));
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
        }
        self.ty = value_ty;
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

    /// Pre-scan an array initializer's brace list (current token
    /// must be `{`) for any element that isn't a compile-time
    /// constant. Returns true if the initializer needs the
    /// per-element runtime store path; false if the existing
    /// pack-into-data + Mcpy path suffices. The scan snapshots /
    /// restores the lexer so token position is unchanged on
    /// return.
    ///
    /// Constants for this check: integer / float / string
    /// literals, enum / `#define` constants (class == Num), bare
    /// file-scope scalar constants, and any cast or paren
    /// expression composed of the same. Runtime values: Loc-class
    /// references, indexed reads (`id[...]`), member access
    /// (`.` / `->`), calls, and any address (`&id`, a function
    /// name, an array's decay -- see `init_id_needs_runtime`).
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
    pub(super) fn emit_local_array_init_runtime(
        &mut self,
        local_val: i64,
        base: i64,
        ty: i64,
        total_count: i64,
        inner_dims: &[i64],
        var_name: &str,
    ) -> Result<(), C5Error> {
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
        self.fill_array_init_runtime(local_val, base, &dims, ty, elem_size, var_name)
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
    ) -> Result<(), C5Error> {
        debug_assert!(self.lex.tk == '{');
        self.next()?; // consume `{`
        let child = &dims[1..];
        let total: i64 = dims.iter().product();
        // Flat element cursor; designators and entries move it the same
        // way as in `collect_array_initializer`.
        let mut cursor: i64 = 0;
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
                return Err(self.compile_err(format!(
                    "too many initializers for array `{var_name}` (> {total})"
                )));
            }
            // C99 6.7.8p7: the designator list may continue into the
            // element (`[i][j].field... = v`), naming a sub-object of a
            // fully indexed element; a range re-parses the chain and value
            // per element.
            if desig.as_ref().is_some_and(|d| d.element_chain) {
                if level != child.len() || !self.is_traversable_aggregate_ty(ty) {
                    return Err(self.compile_err("`=` expected after `[N]` designator"));
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
                    )?;
                }
                cursor = end;
                self.accept(',')?;
                continue;
            }
            let off = base + cursor * elem_size;
            if level < child.len() {
                if self.lex.tk == '{' {
                    self.fill_array_init_runtime(local_val, off, sub, ty, elem_size, var_name)?;
                } else {
                    self.fill_array_leaves_runtime(local_val, off, span, ty, elem_size)?;
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
                    return Err(self.compile_err("`}` expected after braced scalar initializer"));
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
            self.accept(',')?;
        }
        self.next()?; // consume `}`
        Ok(())
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
    pub(super) fn fill_array_leaves_runtime(
        &mut self,
        local_val: i64,
        base: i64,
        n: i64,
        ty: i64,
        elem_size: i64,
    ) -> Result<(), C5Error> {
        let mut k: i64 = 0;
        while k < n {
            if self.lex.tk == '}' {
                break;
            }
            self.emit_array_leaf_runtime(local_val, base + k * elem_size, ty)?;
            k += 1;
            if k < n && self.lex.tk == ',' {
                self.next()?;
            }
        }
        Ok(())
    }

    /// Pre-scan a struct initializer's brace list (current token
    /// must be `{`) for any field whose value isn't a compile-
    /// time constant. Returns true if the initializer needs the
    /// per-field runtime store path; false if the existing
    /// stage-into-data + Mcpy path suffices. The scan snapshots
    /// / restores the lexer so token position is unchanged on
    /// return.
    ///
    /// Designators (`.field = ...` and `[N] = ...`) at the top
    /// of an entry are skipped before checking the value -- they
    /// don't make the initializer non-constant on their own.
    /// Non-constants for this check mirror the array scanner:
    /// references to Loc-class symbols, function calls, indexed
    /// reads, and member access through a non-designator dot /
    /// arrow.
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
