//! File-scope declarations.
//!
//! [`Compiler::run_compile`] is the outer loop of the parser: each
//! iteration takes one top-level item -- a `_Static_assert`, a file-scope
//! `asm`, or a declaration -- and the declaration path parses the
//! specifiers through the shared `decl_base`, then binds each declarator
//! as a typedef, a function or an object.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::decl_base;
use super::types::{
    format_signature, is_pointer_ty, is_struct_ty, is_struct_value_ty, is_void_ty, strip_unsigned,
    struct_id_of, struct_ptr_depth,
};

/// The declaration specifiers a file-scope declarator list shares: the base
/// type and its spelling, the storage classes, and the carriers a typedef
/// base contributes to every declarator of the list.
struct FileScopeDecl {
    bt: i64,
    is_typedef: bool,
    static_seen: bool,
    extern_seen: bool,
    thread_local: bool,
    base_is_enum: bool,
    base_spelling: crate::c5::symbol::DeclSpelling,
    base_type_align: i64,
    base_fn_ptr_indirection: Option<i64>,
    base_fn_ptr_ret_indirection: i64,
    base_is_function_type: bool,
    base_typedef_fn_proto: Option<(usize, bool)>,
    base_fn_ptr_param_types: Option<alloc::vec::Vec<i64>>,
}

/// What one file-scope declarator supplied: the bound symbol, the type its
/// derivations produced, and the carriers the binding paths read.
struct DeclaratorBinding {
    id_idx: usize,
    ty: i64,
    array_size: i64,
    prior_array_size: i64,
    signature_line: usize,
    declarator_is_bare_void: bool,
    fn_ptr_indirection: i64,
    fn_ptr_ret_indirection: i64,
    bare_function_type: bool,
    declarator_transparent: bool,
}

/// What the symbol table held for this name before the declarator bound it.
/// C99 6.2.7 composes the declarations of one entity, and 6.9.2 makes a
/// file-scope declaration with no initializer a tentative definition.
struct PriorDecl {
    was_sys: bool,
    was_fwd_fun: bool,
    was_tentative_glo: bool,
    prior_return_ty: i64,
    prior_params: alloc::vec::Vec<i64>,
    prior_is_variadic: bool,
}

impl Compiler {
    /// Size of a deferred-size array (`T xs[] = { ... }`) that may use
    /// array designators (`[N] = ...`, GNU `[lo ... hi] = ...`). C99
    /// 6.7.8p22: the size is one greater than the largest index
    /// initialized, whether reached positionally or by a designator. The
    /// positional group count (`fallback`) misses a designator that jumps
    /// past it, so peek the element list -- evaluating each `[expr]`
    /// designator -- and track the running index the same way the fill
    /// loop does. `inner_span` > 1 makes a run of that many unbraced
    /// values count as one entry (a flat row of a multi-dimensional
    /// array); pass 1 to count every value. Snapshot-restored, with any
    /// data / PC the constant-fold touched rewound, so the real fill
    /// re-parses from a clean state.
    pub(super) fn designated_array_count(
        &mut self,
        fallback: i64,
        inner_span: i64,
    ) -> Result<i64, C5Error> {
        let snap = self.lex.snapshot();
        let saved_data = self.data.len();
        let saved_pc = self.next_ent_pc;
        let result = self.designated_array_count_inner(fallback, inner_span);
        self.restore_lex(snap);
        self.truncate_data(saved_data);
        self.next_ent_pc = saved_pc;
        // A non-constant designator (invalid, or a shape this peek can't
        // fold) falls back to the positional count; the real fill re-parses
        // and reports any genuine error.
        Ok(result.unwrap_or(fallback))
    }

    /// Peek whether the first element of the array initializer at the
    /// current `{` is an `[N]` designator, without consuming input.
    fn array_first_element_is_designator(&mut self) -> bool {
        let snap = self.lex.snapshot();
        let saved_data = self.data.len();
        let saved_pc = self.next_ent_pc;
        let is_desig = self.next().is_ok() && self.lex.tk == Token::Brak;
        self.restore_lex(snap);
        self.truncate_data(saved_data);
        self.next_ent_pc = saved_pc;
        is_desig
    }

    fn designated_array_count_inner(
        &mut self,
        fallback: i64,
        inner_span: i64,
    ) -> Result<i64, C5Error> {
        self.next()?; // consume `{`
        let mut i: i64 = 0;
        let mut max_count = fallback;
        while self.lex.tk != '}' && self.lex.tk != 0 {
            if self.lex.tk == Token::Brak {
                self.next()?;
                i = self.parse_constant_int_folding_const_objects()?;
                // GNU `[lo ... hi]`: the entry ends at the range high.
                if self.lex.tk == Token::Ellipsis {
                    self.next()?;
                    i = i.max(self.parse_constant_int_folding_const_objects()?);
                }
                if self.lex.tk == ']' {
                    self.next()?;
                }
                if self.lex.tk == Token::Assign {
                    self.next()?;
                }
            }
            if inner_span > 1 && self.lex.tk != '{' {
                // A flat run of up to `inner_span` leaves fills one row,
                // matching the runtime fill's brace-elision absorption.
                let mut used: i64 = 0;
                loop {
                    self.skip_init_element_value()?;
                    used += 1;
                    if used >= inner_span || self.lex.tk != ',' {
                        break;
                    }
                    self.next()?;
                    if self.lex.tk == '}' {
                        break;
                    }
                }
            } else {
                self.skip_init_element_value()?;
            }
            if i + 1 > max_count {
                max_count = i + 1;
            }
            i += 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        Ok(max_count)
    }

    /// Record that a defining declaration moved a file-scope object off the
    /// storage its tentative definition reserved. C99 6.9.2 makes both
    /// declarations denote one object, so the old placement is kept for the
    /// finalize-time rebase of references that already baked it in.
    fn note_global_relocated(&mut self, id_idx: usize, was_tentative: bool, fresh: i64) {
        let s = &mut self.symbols[id_idx];
        if was_tentative && s.reserved_data_bytes > 0 && s.val != fresh {
            s.relocated_from = Some((s.val, s.reserved_data_bytes));
        }
    }

    /// Advance past one initializer element's value to the next top-level `,`
    /// or the closing `}`, tracking bracket depth so a comma nested inside a
    /// brace / paren / bracket group does not end the element early.
    pub(super) fn skip_init_element_value(&mut self) -> Result<(), C5Error> {
        let mut depth: i32 = 0;
        while self.lex.tk != 0 {
            if depth == 0 && (self.lex.tk == ',' || self.lex.tk == '}') {
                break;
            }
            if self.lex.tk == '{' || self.lex.tk == '(' || self.lex.tk == Token::Brak {
                depth += 1;
            } else if self.lex.tk == '}' || self.lex.tk == ')' || self.lex.tk == ']' {
                depth -= 1;
            }
            self.next()?;
        }
        Ok(())
    }

    /// `asm("...");` at file scope. The template goes through the same
    /// head parse as a function-body `asm` statement, then through the
    /// section-directive engine: section blocks of data directives are
    /// recorded for the object writers (references to C symbols become
    /// relocations by name). Operands, clobbers, `goto`, and
    /// instructions outside a named section are rejected.
    /// TODO: top-level instruction emission.
    fn parse_file_scope_asm(&mut self) -> Result<(), C5Error> {
        let (template, tstart, _is_volatile, is_goto) = self.parse_asm_head()?;
        self.truncate_data(tstart);
        if is_goto {
            return Err(self.compile_err("`asm goto` is not supported at file scope"));
        }
        if self.lex.tk == ':' {
            return Err(self.compile_err("inline asm operands are not supported at file scope"));
        }
        self.consume(b')', "`)` expected after inline asm")?;
        self.consume(b';', "`;` expected after file-scope `asm`")?;
        let text = core::str::from_utf8(&template)
            .map_err(|_| self.compile_err("file-scope asm template is not valid UTF-8"))?;
        self.ingest_file_scope_asm(text, true)
            .map_err(|m| self.compile_err(m))
    }

    /// Record a `.set` alias of the unit, a later assignment to the same name
    /// winning as in GNU as.
    fn set_alias(sets: &mut Vec<(String, String, i64)>, name: &str, target: &str, addend: i64) {
        let e = (String::from(name), String::from(target), addend);
        match sets.iter_mut().find(|(n, _, _)| n == name) {
            Some(slot) => *slot = e,
            None => sets.push(e),
        }
    }

    /// Run one GNU-as source unit through the section-directive engine and
    /// record it for the object writers. `globl_shortcut` routes a stream of
    /// nothing but `.globl` at C symbols, which only a translation unit has.
    ///
    /// Shared by the file-scope `asm("...")` parse and the assembler driver so
    /// both accept the same constructs and reject the rest identically.
    pub(super) fn ingest_file_scope_asm(
        &mut self,
        text: &str,
        globl_shortcut: bool,
    ) -> Result<(), String> {
        // Comment stripping, GNU as macro expansion, and the per-definition
        // rename of redefined numeric labels, once; the stored text is the
        // prepared form so the codegen materialization sees the same
        // statements the validation below does.
        let aarch64 = self.target.is_aarch64();
        let comments = if aarch64 {
            crate::c5::asm::AsmComments::A64
        } else {
            crate::c5::asm::AsmComments::X86
        };
        let prepared = crate::c5::asm::prepare_file_asm_text(text, comments)?;
        let text = prepared.as_str();
        // The stream outside pushed sections is either linkage directives only
        // (`.globl name`, applied to a C symbol) or a trampoline body (labels +
        // instructions in the default `.text` section). The first routes through
        // `.globl` collection; the second is assembled as a `.text` section.
        // The probe runs the function-scope extractor, which rejects forms
        // only the file-scope one accepts (`.text` switches, `.subsection`),
        // so its error falls through to the file-scope parse.
        let mut blocks = match crate::c5::asm::extract_asm_sections(text, aarch64) {
            Ok(Some(ex)) if globl_shortcut && ex.is_linkage_only() => {
                for name in ex.globl_names() {
                    self.pending_asm_globl.push(name.into());
                }
                ex.blocks
            }
            _ => crate::c5::asm::extract_file_scope_asm_sections(text, aarch64)?,
        };
        for b in &blocks {
            for item in &b.items {
                match item {
                    crate::c5::asm::AsmSectionItem::Data { values, .. }
                        if values.iter().any(|v| {
                            matches!(v, crate::c5::asm::AsmSectionValue::OperandConst(_))
                        }) =>
                    {
                        return Err(
                            "operand reference in file-scope asm (no operands at file scope)"
                                .into(),
                        );
                    }
                    // Unit-level symbol directives: `.weak name` binds the
                    // symbol weak wherever it is defined; `.set name, target`
                    // is an object-level alias emitted at the target's
                    // definition.
                    crate::c5::asm::AsmSectionItem::Weak(name) => {
                        if !self.asm_weak_names.contains(name) {
                            self.asm_weak_names.push(name.clone());
                        }
                    }
                    crate::c5::asm::AsmSectionItem::Global(name) => {
                        if !self.asm_global_names.contains(name) {
                            self.asm_global_names.push(name.clone());
                        }
                    }
                    crate::c5::asm::AsmSectionItem::Visibility { name, vis } => {
                        match self.asm_visibility.iter_mut().find(|(n, _)| n == name) {
                            Some(e) => e.1 = *vis,
                            None => self.asm_visibility.push((name.clone(), *vis)),
                        }
                    }
                    crate::c5::asm::AsmSectionItem::File(name) => {
                        self.asm_file_names.push(name.clone());
                    }
                    crate::c5::asm::AsmSectionItem::Ident(s) => {
                        self.asm_idents.push(s.clone());
                    }
                    crate::c5::asm::AsmSectionItem::SymSet { name, target } => {
                        Self::set_alias(&mut self.asm_sym_sets, name, target, 0);
                    }
                    // `.set name, sym + k` names the same alias at an offset.
                    // A target this unit's layout places defines the name as
                    // a label of the owning section instead; the object
                    // writer drops the alias record there.
                    crate::c5::asm::AsmSectionItem::SetExpr { name, expr } => {
                        if let Some((target, addend)) = crate::c5::asm::asm_sym_offset_expr(expr) {
                            Self::set_alias(&mut self.asm_sym_sets, name, target, addend);
                        }
                    }
                    _ => {}
                }
            }
        }
        // Assemble the section's instructions and materialize into the unit's
        // validation sink now so directive and encoding errors are diagnosed at
        // the source line; the codegen re-materializes into the object's
        // sections under the emit target's conventions. The sink spans the unit
        // so a template resolves the labels its predecessors defined, matching
        // the codegen materialization, which shares one sink per unit.
        crate::c5::codegen::encode_file_asm_section_code(&mut blocks, self.target, self.elf_class)?;
        crate::c5::asm::materialize_asm_sections(
            &blocks,
            &crate::c5::asm::AsmOperandResolver::NONE,
            &|_| None,
            &|_| None,
            aarch64,
            &mut self.asm_validate_sink,
        )?;
        self.file_asm.push(prepared);
        Ok(())
    }

    /// Clear the state one file-scope declaration owns: the `const` and
    /// spelling carriers, the attribute results and the function-specifier
    /// flags. `inline` matters even without a body -- an inline prototype
    /// must not mark the following declaration as inline when the linkage
    /// rule reads the flag.
    fn reset_file_scope_decl_state(&mut self) {
        self.pending.base_is_const = false;
        let _ = self.take_base_spelling();
        self.pending_noreturn = false;
        self.pending.attr_thread_local = false;
        self.pending.attr_dllexport = false;
        self.pending.attr_align = 0;
        self.pending.attr_alignas = 0;
        self.pending.type_align = 0;
        self.pending.attr_vector_size = 0;
        self.pending.attr_constructor = false;
        self.pending.attr_destructor = false;
        self.pending.attr_init_priority = None;
        self.pending.attr_cleanup = None;
        self.pending.attr_uninitialized = false;
        self.pending.attr_weak = false;
        self.pending.attr_call_conv = crate::c5::codegen::CallConv::Target;
        self.pending.attr_used = false;
        self.pending.attr_visibility = None;
        self.pending.attr_section = None;
        self.pending.attr_patchable_entry = None;
        self.pending.attr_no_instrument = false;
        self.pending.attr_alias = None;
        self.pending.saw_register_storage = false;
        self.pending.auto_type_single_declarator = false;
        self.pending_is_inline = false;
        self.pending_is_always_inline = false;
        self.pending_saw_inline_specifier = false;
        self.pending_is_gnu_inline = false;
        self.pending_is_naked = false;
    }

    pub(super) fn run_compile(&mut self) -> Result<(), C5Error> {
        self.next()?;
        while self.lex.tk != 0 {
            // C11 6.7.10 `_Static_assert(<expr>, "<msg>");` at
            // file scope -- consume the construct as a parse-time
            // assertion. Zero expression aborts compilation with
            // the message verbatim through the standard error path.
            if self.lex.tk == Token::StaticAssert {
                self.parse_static_assert()?;
                continue;
            }
            // `asm("...");` between declarations (C99 J.5.10 common
            // extension): the template's section data directives emit
            // into named sections of the object.
            if self.lex.tk == Token::Asm {
                self.parse_file_scope_asm()?;
                continue;
            }
            self.parse_file_scope_declaration()?;
        }
        self.resolve_pending_aliases()?;
        self.check_incomplete_definitions()?;
        // Before the asm `.globl` sweep: that directive is an explicit
        // request to export the name and outranks the inline model.
        self.resolve_inline_linkage();
        self.resolve_file_scope_asm_globl();
        self.warn_unused_static_functions();
        Ok(())
    }

    /// One file-scope declaration: the declaration specifiers, then the
    /// comma-separated declarator list and the `;` that ends it.
    fn parse_file_scope_declaration(&mut self) -> Result<(), C5Error> {
        let mut storage = decl_base::DeclStorage::default();
        self.reset_file_scope_decl_state();
        let bt = self.parse_decl_specifiers(Some(&mut storage))?;
        let decl = FileScopeDecl {
            bt,
            is_typedef: storage.is_typedef,
            static_seen: storage.is_static,
            extern_seen: storage.is_extern,
            thread_local: storage.is_thread_local,
            base_is_enum: storage.base_is_enum,
            base_spelling: self.take_base_spelling(),
            // A typedef-carried type alignment applies to every declarator;
            // an initializer's own type parses (casts, `sizeof`) reset the
            // pending carrier, so capture it once for the whole list.
            base_type_align: self.pending.type_align,
            // A function-pointer typedef base type contributes its lineage to
            // every declarator in the list (`fn_t a, b;`). Per-declarator
            // symbol creation consumes these pending fields, so they are
            // re-seeded from here each iteration; otherwise only the first
            // declarator keeps the lineage and a call through a later one
            // defaults its result type to int.
            base_fn_ptr_indirection: self.pending.fn_ptr_indirection,
            base_fn_ptr_ret_indirection: self.pending.fn_ptr_ret_indirection,
            base_is_function_type: self.pending.base_is_function_type,
            base_typedef_fn_proto: self.pending.typedef_fn_proto,
            base_fn_ptr_param_types: self.pending.fn_ptr_param_types.clone(),
        };
        let mut declarator_count = 0usize;
        while self.lex.tk != ';' && self.lex.tk != '}' {
            if self.pending.auto_type_single_declarator && declarator_count > 0 {
                return Err(self.compile_err("`__auto_type` declaration takes a single declarator"));
            }
            declarator_count += 1;
            self.parse_file_scope_declarator(&decl)?;
            self.accept_declarator_separator()?;
        }
        self.next()?;
        Ok(())
    }

    /// One declarator of a file-scope declaration: the declarator itself,
    /// then the typedef, function or object binding it names.
    fn parse_file_scope_declarator(&mut self, decl: &FileScopeDecl) -> Result<(), C5Error> {
        let &FileScopeDecl {
            bt,
            is_typedef,
            static_seen,
            extern_seen,
            base_type_align,
            ..
        } = decl;

        self.pending.fn_ptr_indirection = decl.base_fn_ptr_indirection;
        self.pending.fn_ptr_ret_indirection = decl.base_fn_ptr_ret_indirection;
        self.pending.base_is_function_type = decl.base_is_function_type;
        self.pending.typedef_fn_proto = decl.base_typedef_fn_proto;
        self.pending.fn_ptr_param_types = decl.base_fn_ptr_param_types.clone();
        // The declarator's own line -- the name and its parameter
        // list -- for diagnostics that would otherwise point at the
        // function body's opening brace parsed further below.
        let signature_line = self.lex.line;
        let (id_idx, mut ty, mut array_size) = self.parse_declarator(bt)?;
        // `register T name asm("reg")` at file scope is a GNU global
        // register variable; any other `asm(...)` suffix is the
        // assembler name and the object declaration continues
        // (initializer, attributes, `;` / `,`). A file-scope object
        // always has static storage duration (C99 6.2.4).
        if let Some(reg) =
            self.parse_declarator_asm_suffix(id_idx, static_seen || extern_seen, true)?
        {
            self.bind_file_scope_register(id_idx, ty, reg)?;
            return Ok(());
        }
        // `__declspec(dllexport)` on the declarator exports the name,
        // the equivalent of `#pragma export(name)`. resolve_exports
        // validates the name resolves to a defined function.
        if self.pending.attr_dllexport {
            self.pending.attr_dllexport = false;
            let name = self.symbols[id_idx].name.clone();
            if !self.pending_exports.contains(&name) {
                self.pending_exports.push(name);
            }
        }
        // A declarator may carry a trailing attribute before the
        // terminator (`name(args) __attribute__((...));`, an
        // initializer, a comma, or a function body's `{`).
        self.skip_attribute_specifiers()?;
        // `typedef T name __attribute__((vector_size(N)))` (and the
        // object form) binds the attribute to the declarator, not the
        // base type, so it lands here rather than at the base-type
        // sites. The leading form already consumed it, leaving 0.
        if self.pending.attr_vector_size > 0 {
            let n = core::mem::take(&mut self.pending.attr_vector_size);
            ty = self.make_vector_type(ty, n);
        }
        if let Some(m) = self.pending.attr_mode.take() {
            ty = self.apply_mode_to_type(ty, m)?;
        }
        let declarator_transparent = core::mem::take(&mut self.pending.attr_transparent_union);
        // Captured per declarator, before a nested parse (a later parameter
        // of function type) can overwrite it.
        let bare_function_type = self.pending.bare_function_type_declarator;
        self.pending.bare_function_type_declarator = false;
        // Pick up the fn-pointer indirection count
        // the declarator (or its typedef base type)
        // recorded, and store it on the symbol so a later
        // identifier load can seed the chain-depth tracker.
        let fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
        let fn_ptr_ret_indirection = core::mem::take(&mut self.pending.fn_ptr_ret_indirection);
        // C99 6.7.7p3: an array typedef contributes its dimension to a declarator
        // that supplied none. It belongs to the base type, so every declarator of
        // the list reads it; one that added a pointer level names a pointer to the
        // element type and does not (6.7.6.1). TODO: compose the multi-dimensional
        // case (`arr_t four[4]` -> `long four[4][64]`) through `array_dims`.
        let typedef_dim = self.pending.typedef_base_array_size;
        // Declarator-added dimensions over an over-aligned element
        // are rejected here for objects and typedef aliases alike.
        self.check_array_elem_align(array_size, ty, typedef_dim, base_type_align)?;
        // A fixed dimension (`> 0`) sizes the object; a deferred array
        // typedef (`typedef T X[]`, carried as `-1`) makes the object
        // a deferred array whose size the initializer fixes.
        let mut zero_len_array = self.pending.declarator_zero_len_array;
        if typedef_dim != 0 && array_size == 0 && self.pending.declarator_leading_ptr_count == 0 {
            array_size = typedef_dim;
            zero_len_array = self.pending.typedef_base_zero_len;
            self.apply_typedef_array_dims(id_idx);
        }
        self.ty = ty;
        let prior_array_size = self.symbols[id_idx].array_size;
        self.symbols[id_idx].array_size = array_size;
        // A zero-length array (`T x[0]`, or an alias of one) is a
        // complete type of size 0; the `-1` count it shares with
        // the deferred `T x[]` form cannot tell them apart.
        if array_size < 0 {
            self.symbols[id_idx].is_zero_len_array = zero_len_array;
        }
        // A `const`-qualified plain integer scalar folds its value
        // in later constant expressions (read back from `.data`).
        self.symbols[id_idx].is_const_qualified =
            self.pending.base_is_const && array_size == 0 && super::types::is_integer_scalar_ty(ty);
        // The declared object's own storage is const-qualified (C99
        // 6.7.3p5 then makes modifying it undefined, so its
        // initializer is its value for the whole execution). A
        // declarator that adds pointer indirection points the
        // qualifier at the pointee instead: `p` and `t[0]` of
        // `const char *p` / `const char *t[2]` are writable. A
        // `const` after the outermost `*` qualifies the object
        // again: `char *const p`, `const char *const t[2]`.
        self.symbols[id_idx].storage_is_const = self.pending.declarator_outer_const
            || (self.pending.base_is_const && !super::types::is_pointer_ty(ty));
        if fn_ptr_indirection > 0 {
            self.symbols[id_idx].fn_ptr_indirection = fn_ptr_indirection;
            self.symbols[id_idx].fn_ptr_ret_indirection = fn_ptr_ret_indirection;
        }
        // Inherit a variadic function-pointer prototype onto the
        // bound declarator so an indirect call through it knows
        // the callee's named-parameter count and routes the
        // variadic tail per the host variadic ABI. Only variadic
        // prototypes are recorded: a non-variadic indirect call
        // places every argument as fixed regardless, and
        // synthesising placeholder parameter types would feed the
        // call-site argument type-check a spurious mismatch.
        let fnptr_proto = self.pending.typedef_fn_proto.take();
        let mut fnptr_param_types = self.pending.fn_ptr_param_types.take();
        // The carrier holds the pointee signature of a fn-pointer typedef, so it
        // describes an object (`cb x;`) -- not a function whose return type is that
        // typedef (`cb f(args)`), and not a bare function-type declarator (`extern
        // typeof(f) f;`); both of those install a list of their own.
        let carrier_names_object = !bare_function_type || is_typedef;
        if self.lex.tk != '(' && carrier_names_object {
            if let Some(types) = fnptr_param_types.take() {
                self.symbols[id_idx].params = types;
                self.symbols[id_idx].is_variadic = matches!(fnptr_proto, Some((_, true)));
            } else if let Some((proto_fixed, true)) = fnptr_proto {
                self.symbols[id_idx].params = alloc::vec![0i64; proto_fixed];
                self.symbols[id_idx].is_variadic = true;
            }
        }
        // Carry the bare-`void` side channel onto the
        // declarator. `pending_base_was_void` was set if
        // the base type spelled `void`; it stays valid
        // for the FIRST declarator in a comma-separated
        // group only. Gate on "no leading `*` added": any
        // declarator that bumped `ty` by `Ty::Ptr` is no
        // longer scalar `void` and falls out.
        let declarator_is_bare_void = self.pending.base_was_void && is_void_ty(ty);
        // Consume the flag so the next iteration of the
        // declarator loop (`void *a, b;`) doesn't
        // re-trigger on a different declarator's shape.
        self.pending.base_was_void = false;
        // Function-returning-FP shape: parse_declarator
        // already consumed the outer function's params.
        // Synthesize the function-definition path: bind the
        // symbol as Fun, install the captured params, then
        // proceed straight into the body (the next token is
        // `{`, not `(`).
        let mut preconsumed_params = self.pending.fn_params.take();

        // typedef branch: register a type alias and skip the
        // function / global storage path entirely. Re-declaring
        // an existing typedef with the same underlying type is
        // tolerated -- amalgamated translation units routinely
        // re-emit identical typedefs through several `#include`
        // paths -- but a clashing redefinition or a clash with
        // a non-typedef symbol is rejected.
        let mut b = DeclaratorBinding {
            id_idx,
            ty,
            array_size,
            prior_array_size,
            signature_line,
            declarator_is_bare_void,
            fn_ptr_indirection,
            fn_ptr_ret_indirection,
            bare_function_type,
            declarator_transparent,
        };
        if is_typedef {
            return self.bind_file_scope_typedef(decl, &b, preconsumed_params);
        }

        // C99 6.9.1: an identifier declared with a bare function type (a
        // function-TYPE typedef used with no pointer) declares a function,
        // not an object. The base type was pre-decayed to a function
        // pointer; undo that level and route through the function path with
        // the typedef's prototype, so a following definition of the same
        // name merges as a redeclaration rather than colliding.
        if bare_function_type && preconsumed_params.is_none() && self.lex.tk != '(' {
            b.ty -= Ty::Ptr as i64;
            let types = fnptr_param_types.unwrap_or_default();
            preconsumed_params = Some(super::function::ParsedParams {
                indices: alloc::vec::Vec::new(),
                types,
                is_variadic: matches!(fnptr_proto, Some((_, true))),
                // A function-type specifier supplies a parameter type list;
                // the empty-list spelling does not reach here.
                is_prototyped: true,
            });
        }

        let prior = self.check_file_scope_redeclaration(decl, &b, preconsumed_params.is_some())?;
        if self.lex.tk == '(' || preconsumed_params.is_some() {
            self.define_file_scope_function(decl, &b, preconsumed_params, prior)
        } else {
            self.define_file_scope_object(decl, &b, prior.was_tentative_glo)
        }
    }

    /// Bind the declarator as a type alias (C99 6.7.7). A function-type
    /// spelling parses its own parameter list here; every other form takes
    /// the declarator's type and the carriers its base type contributed.
    fn bind_file_scope_typedef(
        &mut self,
        decl: &FileScopeDecl,
        b: &DeclaratorBinding,
        preconsumed_params: Option<super::function::ParsedParams>,
    ) -> Result<(), C5Error> {
        let &FileScopeDecl {
            base_is_enum,
            base_type_align,
            ..
        } = decl;
        let &DeclaratorBinding {
            id_idx,
            ty,
            fn_ptr_indirection,
            fn_ptr_ret_indirection,
            bare_function_type,
            declarator_transparent,
            declarator_is_bare_void,
            ..
        } = b;

        // `typedef RET NAME(args);` names a function type. It binds as a
        // function-pointer alias, since every use decays to one (C99 6.3.2.1p4).
        // The shared parameter parse binds each named parameter as a local; a
        // typedef has no body to scope them to, so each is restored right after.
        let (typedef_ty, typedef_fpi, typedef_params, typedef_is_fn_type) =
            if self.lex.tk == '(' && preconsumed_params.is_none() {
                self.next()?; // consume `(`
                let pp = self.parse_function_params()?;
                for &p in &pp.indices {
                    Self::restore_shadowed_symbol(&mut self.symbols[p]);
                }
                // `typedef RET NAME(args);` -- a function TYPE.
                // The type is pre-decayed to a function pointer
                // (`RET` + one pointer level); the flag lets a
                // later `NAME *p` declarator absorb the first `*`.
                let fty = ty + Ty::Ptr as i64;
                (fty, 1i64, Some(pp), true)
            } else if let Some(pp) = preconsumed_params {
                // `typedef RET (*NAME)(args);`: the `(*NAME)`
                // nested declarator already consumed the
                // pointee's parameter list into
                // `pending.fn_params`. Record the prototype on
                // the typedef so a fn-pointer variable declared
                // through it inherits the callee's variadic-ness
                // and named-parameter count.
                for &p in &pp.indices {
                    Self::restore_shadowed_symbol(&mut self.symbols[p]);
                }
                (ty, fn_ptr_indirection, Some(pp), false)
            } else {
                // An alias of a function-type typedef stays a
                // function type.
                (ty, fn_ptr_indirection, None, bare_function_type)
            };
        let prior_class = self.symbols[id_idx].class;
        let prior_type = self.symbols[id_idx].type_;
        if prior_class != 0 && prior_class != Token::Typedef as i64 {
            return Err(self.compile_err(format!(
                "typedef name `{}` clashes with prior non-typedef declaration",
                self.symbols[id_idx].name
            )));
        }
        if prior_class == Token::Typedef as i64 && prior_type != typedef_ty {
            return Err(self.compile_err(format!(
                "typedef `{}` redefined with a different type",
                self.symbols[id_idx].name
            )));
        }
        self.symbols[id_idx].class = Token::Typedef as i64;
        self.symbols[id_idx].type_ = typedef_ty;
        self.symbols[id_idx].val = 0;
        // `typedef union {...} T __attribute__((transparent_union))`:
        // a declarator-position attribute binds to the aliased union.
        if declarator_transparent && super::types::is_struct_value_ty(typedef_ty) {
            self.mark_transparent_union(super::types::struct_id_of(typedef_ty));
        }
        self.symbols[id_idx].is_void_typedef = declarator_is_bare_void;
        self.symbols[id_idx].is_enum_typedef = base_is_enum;
        self.symbols[id_idx].is_function_type = typedef_is_fn_type;
        // A function-type typedef records the calling
        // convention its declaration named, so a declarator
        // through the alias inherits it
        // (`typedef efi_status_t __efiapi f_t(void);`).
        if self.pending.attr_call_conv != crate::c5::codegen::CallConv::Target {
            self.symbols[id_idx].conv = self.pending.attr_call_conv;
        }
        // A GNU `aligned(N)` type attribute on the typedef
        // (its own declaration's attribute, else propagated
        // from an aligned typedef base) becomes the alias's
        // type alignment.
        let alias_align = if self.pending.attr_align > 0 {
            self.pending.attr_align
        } else {
            base_type_align
        };
        if alias_align > 0 && !(alias_align as u64).is_power_of_two() {
            return Err(self.compile_err(format!(
                "requested alignment {alias_align} is not a power of two"
            )));
        }
        self.symbols[id_idx].type_align = alias_align;
        if typedef_fpi > 0 {
            self.symbols[id_idx].fn_ptr_indirection = typedef_fpi;
            self.symbols[id_idx].fn_ptr_ret_indirection = fn_ptr_ret_indirection;
        }
        // The `typedef RET NAME(args)` / `typedef RET (*NAME)(args)` spellings
        // parse a list of their own; an alias of an existing function type
        // took the one its carrier held.
        if let Some(pp) = typedef_params {
            self.symbols[id_idx].params = pp.types;
            self.symbols[id_idx].is_variadic = pp.is_variadic;
        }
        Ok(())
    }

    /// The prior declarations of this name, and the C99 6.9 rules that
    /// admit another one: a `Sys` binding or a bodyless function may be
    /// re-declared, a tentative definition may be completed, and an
    /// `extern` declaration may be followed by the definition. Records the
    /// declared type and spelling on the symbol.
    fn check_file_scope_redeclaration(
        &mut self,
        decl: &FileScopeDecl,
        b: &DeclaratorBinding,
        has_preconsumed_params: bool,
    ) -> Result<PriorDecl, C5Error> {
        let &FileScopeDecl { base_spelling, .. } = decl;
        let &DeclaratorBinding { id_idx, ty, .. } = b;

        // A `Sys` binding may be re-declared as a prototype: the declaration
        // teaches the parser the signature without overriding the binding. A
        // bodyless function may be too -- an amalgamated unit repeats prototypes.
        // A second body for one function is still a duplicate.
        let was_sys = self.symbols[id_idx].class == Token::Sys as i64;
        // Forward / repeat function declarations: allowed
        // either when the next token is `(` (the regular
        // `int foo(args)` shape) OR when parse_declarator
        // already consumed the outer params for the
        // function-returning-FP shape (tk is `;` or `{`
        // depending on prototype-vs-definition).
        let was_fwd_fun = self.symbols[id_idx].class == Token::Fun as i64
            && (self.lex.tk == '(' || has_preconsumed_params);
        // C11 6.9.2: a prior `T x;` becomes the defining declaration when
        // re-declared, and the definition reuses the storage it reserved so a
        // reference already emitted against that offset still resolves. A prior
        // `extern T x[];` reserved none, so its definition takes fresh bytes.
        let was_extern_redecl = self.symbols[id_idx].class == Token::Glo as i64
            && !self.symbols[id_idx].has_initializer
            && self.symbols[id_idx].is_extern_decl
            && !self.symbols[id_idx].defined_here
            && self.lex.tk != '(';
        let was_tentative_glo = self.symbols[id_idx].class == Token::Glo as i64
            && !self.symbols[id_idx].has_initializer
            && (!self.symbols[id_idx].is_extern_decl || self.symbols[id_idx].defined_here)
            && self.lex.tk != '(';
        // C99 6.9.2: a file-scope declaration with no initializer
        // is a tentative definition. It is a redundant
        // declaration of an existing object -- whether or not
        // that object already carries an initializer -- and is
        // not an error. A second initializer is still rejected
        // because the prior symbol keeps `has_initializer`.
        let new_is_tentative_glo = self.symbols[id_idx].class == Token::Glo as i64
            && self.lex.tk != Token::Assign
            && self.lex.tk != '(';
        if self.symbols[id_idx].class != 0
            && !was_sys
            && !was_fwd_fun
            && !was_tentative_glo
            && !was_extern_redecl
            && !new_is_tentative_glo
        {
            return Err(self.compile_err("duplicate global definition"));
        }
        // Snapshot the prior signature before overwriting `type_`, so the
        // signature check has something to compare against.
        let prior_return_ty = self.symbols[id_idx].type_;
        let prior_params = self.symbols[id_idx].params.clone();
        let prior_is_variadic = self.symbols[id_idx].is_variadic;
        self.symbols[id_idx].type_ = ty;
        // For an object the spelling is the object's; for a function it is
        // the return type's.
        self.symbols[id_idx].decl_spelling = self.decl_spelling(base_spelling);
        // An explicit return type replaces the implicit-`int`
        // default (Sys binding without a prior prototype).
        self.symbols[id_idx].implicit_return_int = false;

        Ok(PriorDecl {
            was_sys,
            was_fwd_fun,
            was_tentative_glo,
            prior_return_ty,
            prior_params,
            prior_is_variadic,
        })
    }

    /// Bind the declarator as a function: the signature, then either the
    /// prototype (C99 6.7.5.3) or the definition and its body (6.9.1).
    fn define_file_scope_function(
        &mut self,
        decl: &FileScopeDecl,
        b: &DeclaratorBinding,
        preconsumed_params: Option<super::function::ParsedParams>,
        prior: PriorDecl,
    ) -> Result<(), C5Error> {
        let &FileScopeDecl {
            static_seen,
            extern_seen,
            ..
        } = decl;
        let &DeclaratorBinding {
            id_idx,
            ty,
            signature_line,
            declarator_is_bare_void,
            ..
        } = b;
        let PriorDecl {
            was_sys,
            was_fwd_fun,
            prior_return_ty,
            prior_params,
            prior_is_variadic,
            ..
        } = prior;

        if !was_sys {
            self.record_function_declaration(id_idx, static_seen, extern_seen);
        }
        // A `Sys` binding starts with a stub signature the unit's own header is
        // expected to refine, so only user-vs-user redeclarations are compared.
        // Capture the long-double return-type marker
        // before parameter parsing, which calls
        // `parse_decl_base_type` per param and clears
        // the side channel as part of its reset.
        let ret_was_long_double = self.pending.base_was_long_double;
        let mut params = if let Some(pp) = preconsumed_params {
            pp
        } else {
            self.next()?;
            self.parse_function_params()?
        };
        // A function declarator may carry a trailing attribute
        // before the prototype's `;` or the body's `{`
        // (`RET name(args) __attribute__((noreturn));`).
        self.skip_attribute_specifiers()?;
        // A GNU asm-label rename (`RET name(args) asm("name");`)
        // may sit between the declarator and the terminator, on
        // either side of the attributes.
        if self.lex.tk == Token::Asm {
            self.parse_declarator_asm_label(id_idx)?;
            self.skip_attribute_specifiers()?;
        }

        // C99 6.7.5.3p14: an empty list outside a definition supplies no parameter
        // information, so the composite type keeps the prior list (6.2.7p4); in a
        // definition the same spelling does specify "no parameters".
        let is_defining_declarator = self.lex.tk != ';' && self.lex.tk != ',';
        let keeps_prior_list =
            !params.is_prototyped && !is_defining_declarator && !prior_params.is_empty();
        if keeps_prior_list {
            params.types = prior_params.clone();
            params.is_variadic = prior_is_variadic;
        }
        self.symbols[id_idx].params = params.types.clone();
        self.symbols[id_idx].is_variadic = params.is_variadic;
        // C11 6.7.4: `_Noreturn` on any declaration marks the symbol, and the
        // reachability analysis then treats a call to it as not reaching its
        // continuation. The mark is sticky across later declarations.
        if self.pending_noreturn {
            self.symbols[id_idx].is_noreturn = true;
        }
        // `weak` / `used` / `section("name")` collected for
        // this declarator (leading or trailing) mark the
        // symbol; the object writers read them off it.
        self.apply_symbol_attributes(id_idx);
        // The body-emit path reads this to zero the accumulator before the
        // trailing return. A prototype records it too; a body that then disagrees
        // is a C99 6.7p4 violation the signature check above reports.
        if declarator_is_bare_void {
            self.symbols[id_idx].returns_void = true;
        }

        self.warn_on_signature_mismatch(
            id_idx,
            ty,
            prior_return_ty,
            &prior_params,
            prior_is_variadic,
            &params,
            was_fwd_fun,
        );
        // For Sys symbols (header-bound libc functions),
        // also fold the variadic flag onto the matching
        // `#pragma binding`. The native lowering reads
        // it when it picks the variadic ABI path (macOS
        // arm64 stack-packing, SysV `xor eax, eax`)
        // instead of consulting the symbol table at
        // codegen time -- it is out of scope by then.
        if was_sys {
            self.update_libc_binding(id_idx, &params, ty, ret_was_long_double);
        }

        if self.lex.tk == ';' || self.lex.tk == ',' {
            return self.finish_function_prototype(id_idx);
        }
        if was_sys {
            return Err(self.compile_err_at(
                signature_line,
                format!(
                    "cannot give a body to predefined library function `{}` \
                     (the per-target header's `#pragma binding` provides the \
                     implementation -- use a prototype only)",
                    self.symbols[id_idx].name
                ),
            ));
        }
        self.parse_function_definition(id_idx, params)
    }

    /// Record one file-scope declaration of a function name: its class and
    /// source position, the census the inline linkage models read (C99
    /// 6.7.4p6-p7 and GNU89), and the linkage that census implies so far.
    fn record_function_declaration(&mut self, id_idx: usize, static_seen: bool, extern_seen: bool) {
        self.symbols[id_idx].class = Token::Fun as i64;
        if self.symbols[id_idx].decl_line == 0 {
            self.symbols[id_idx].decl_line = self.lex.line;
            self.symbols[id_idx].decl_in_main_source = self.in_main_source();
        }
        // Census one file-scope declaration of this name for
        // the inline linkage models (C99 6.7.4p6-p7 and
        // GNU89); `resolve_inline_linkage` reads the totals
        // once the unit's last declaration is in. The
        // provisional linkage keeps mid-parse state consistent for a
        // `static`-vs-external decision the inline model does not affect.
        let sym = &mut self.symbols[id_idx];
        sym.saw_static_decl |= static_seen;
        match (self.pending_saw_inline_specifier, extern_seen) {
            (false, _) => sym.saw_noninline_decl = true,
            (true, false) => sym.saw_plain_inline_decl = true,
            (true, true) => sym.saw_extern_inline_decl = true,
        }
        let internal =
            sym.saw_static_decl || (!sym.saw_noninline_decl && !extern_seen && !sym.is_extern_decl);
        sym.linkage = if internal {
            crate::c5::symbol::Linkage::Internal
        } else {
            crate::c5::symbol::Linkage::External
        };
        if extern_seen {
            self.symbols[id_idx].is_extern_decl = true;
        }
        // `val` stays as it is: the walker reads it through `live_fun_val` when it
        // lowers a call, so a call placed before the body still sees the entry pc
        // the body records, and a redeclaration after the body must not overwrite
        // it.
    }

    /// C99 6.7p4 requires the declarations of one function to be
    /// compatible. An amalgamated unit can disagree by accident, which is
    /// worth surfacing but not refusing: only this declaration is in scope.
    #[allow(clippy::too_many_arguments)]
    fn warn_on_signature_mismatch(
        &mut self,
        id_idx: usize,
        ty: i64,
        prior_return_ty: i64,
        prior_params: &[i64],
        prior_is_variadic: bool,
        params: &super::function::ParsedParams,
        prior_was_known: bool,
    ) {
        // C99 6.7.5.3p14: an empty list in a non-defining declarator supplies no
        // parameter information, so it is not a claim about a signature and
        // cannot disagree with one.
        let either_unspecified = prior_params.is_empty() || params.types.is_empty();
        let return_differs = prior_return_ty != ty;
        let variadic_differs = prior_is_variadic != params.is_variadic;
        let params_differ = !either_unspecified && prior_params != params.types.as_slice();
        if prior_was_known && (return_differs || variadic_differs || params_differ) {
            let name = self.symbols[id_idx].name.clone();
            let line = self.lex.line;
            let prior_sig = format_signature(
                prior_return_ty,
                prior_params,
                prior_is_variadic,
                &self.structs,
            );
            let new_sig = format_signature(ty, &params.types, params.is_variadic, &self.structs);
            self.warn_at(
                line,
                format!(
                    "redeclaration of `{name}` differs from the previous \
                 declaration\n  previous: {prior_sig}\n  now:      {new_sig}",
                ),
            );
        }
    }

    /// Fold a libc binding's signature onto the matching `#pragma binding`:
    /// the native lowering reads the variadic ABI choice and the return
    /// convention off it, and the DWARF subprogram DIE over each PLT
    /// trampoline reads the parameter types.
    fn update_libc_binding(
        &mut self,
        id_idx: usize,
        params: &super::function::ParsedParams,
        ret_ty: i64,
        ret_is_long_double: bool,
    ) {
        let name = self.symbols[id_idx].name.clone();
        let fixed = params.types.len();
        let variadic = params.is_variadic;
        // The return type tells the codegen whether the call leaves a 32-bit
        // value with junk in the upper half of the host return register
        // (msvcrt `int` returns) and needs extending before it becomes the
        // accumulator.
        for spec in self.dylibs.iter_mut() {
            for binding in spec.bindings.iter_mut() {
                if binding.local_name == name {
                    binding.is_variadic = variadic;
                    binding.fixed_args = fixed;
                    binding.return_type_tag = ret_ty;
                    binding.returns_long_double = ret_is_long_double;
                    // Per-param types for the
                    // DWARF subprogram DIE the codegen
                    // emits over each PLT trampoline.
                    // Without these, gdb shows
                    // `in malloc ()` instead of
                    // `in malloc (size=...)`.
                    binding.param_types = params.types.clone();
                }
            }
        }
    }

    /// A bodyless declarator ends the declaration: bind an `alias("target")`
    /// to the target it names, then unbind the parameter symbols
    /// `parse_function_params` bound so a later declaration of the same
    /// names is not a duplicate.
    fn finish_function_prototype(&mut self, id_idx: usize) -> Result<(), C5Error> {
        // `alias("target")` on a bodyless declarator: the
        // declared name becomes an additional symbol for a
        // function already defined in this unit, and calls
        // through it resolve to the target's entry. A weak
        // alias is interposable -- a strong definition in
        // another object replaces it at link time -- so it
        // never binds here; the unit-end resolver keeps its
        // references symbolic.
        if let Some(target) = self.pending.attr_alias.take() {
            let tgt = (!self.symbols[id_idx].is_weak)
                .then(|| {
                    self.symbols.iter().position(|s| {
                        s.link_name() == target && s.class == Token::Fun as i64 && s.defined_here
                    })
                })
                .flatten();
            let Some(tgt) = tgt else {
                // The target may be defined later in the unit;
                // retry once the unit is complete.
                self.pending_aliases.push((id_idx, target, false));
                self.symbols[id_idx].is_alias = true;
                let bound = self.take_scope_bound();
                self.unwind_scope_bound(bound);
                return Ok(());
            };
            self.symbols[tgt].was_referenced = true;
            self.symbols[id_idx].val = self.symbols[tgt].val;
            // Defined-through-the-target: keeps the TU-end
            // extern-import pass from re-assigning a
            // placeholder pc over the resolved entry.
            self.symbols[id_idx].defined_here = true;
            self.symbols[id_idx].is_alias = true;
            let name = self.symbols[id_idx].link_name().into();
            let bind = alias_bind(&self.symbols[id_idx]);
            self.function_aliases
                .push(crate::c5::program::FunctionAlias {
                    name,
                    target,
                    bind,
                    addend: 0,
                });
        }
        // Function prototype, not a definition. C99 6.7
        // permits several declarators in one declaration,
        // so a prototype can be followed by `,` and more
        // declarators (further prototypes or objects),
        // e.g. `int f(int a), g(int a), a;`. Restore the
        // param symbols' outer class (parse_function_params
        // marked them as `Loc`) so subsequent declarations
        // of the same names don't trip the
        // duplicate-global check.
        let bound = self.take_scope_bound();
        self.unwind_scope_bound(bound);
        // On `,` consume it and let the outer loop parse
        // the next declarator; on `;` the outer loop exits
        // and `self.next()` after it consumes the `;`.
        Ok(())
    }

    /// The definition: the K&R parameter declarations, the body, and the
    /// records the walker and the debug info read off the finished frame.
    fn parse_function_definition(
        &mut self,
        id_idx: usize,
        mut params: super::function::ParsedParams,
    ) -> Result<(), C5Error> {
        self.parse_kr_parameter_declarations(&mut params)?;
        self.symbols[id_idx].params = params.types.clone();

        if self.lex.tk != '{' {
            return Err(self.compile_err("bad function definition"));
        }
        self.next()?;

        let ent_pc = self.open_function_body(id_idx, &params);
        self.copy_by_value_parameters(&params);
        self.parse_function_body_items()?;
        self.finish_function_body(ent_pc, &params)?;
        // The capture runs before the scope unwind restores the outer bindings.
        // DWARF 5 3.3.4 groups the DIEs by the subprogram's entry pc and locates
        // each at `fp_slot * 8`; slots 0 and 1 are the saved frame and return
        // address, so a parameter is `val >= 2` and a local `val < 0`.
        let param_set: alloc::collections::BTreeSet<usize> =
            params.indices.iter().copied().collect();
        let bound = self.take_scope_bound();
        let vars_start = self.record_function_variables(ent_pc, &params, &bound, &param_set);
        self.classify_function_frame(vars_start)?;
        self.warn_unused_function_bindings(&bound, &param_set);
        self.unwind_scope_bound(bound);
        Ok(())
    }

    fn parse_kr_parameter_declarations(
        &mut self,
        params: &mut super::function::ParsedParams,
    ) -> Result<(), C5Error> {
        // C99 6.9.1: an old-style (K&R) definition lists the
        // parameter names in the declarator and gives their
        // types in declarations between the `)` and the
        // body; unlisted parameters keep the default int.
        // Each declaration names one or more of the
        // parameters already bound by parse_function_params,
        // so update those symbols' types in place.
        while self.lex.tk != '{' && self.lex.tk != 0 {
            // A parameter declaration may lead with storage-
            // class specifiers (`register short *p;`) and may
            // omit the type, in which case it is int (C99
            // 6.9.1 / 6.7.2p2). Stop when the next token is
            // neither a specifier nor a type nor a parameter
            // name -- that is the function body.
            let mut saw_specifier = false;
            let mut qual_bits: i64 = 0;
            while self.lex.tk == Token::FuncSpec
                || self.lex.tk == Token::Static
                || self.lex.tk == Token::Extern
                || self.lex.tk == Token::TypeQual
            {
                qual_bits |= self.lex_qualifier_bits();
                self.next()?;
                saw_specifier = true;
            }
            let base = if self.lex_is_type_start() {
                self.parse_decl_base_type()?
            } else if saw_specifier || self.lex.tk == Token::Id {
                Ty::Int as i64
            } else {
                break;
            } | qual_bits;
            while self.lex.tk != ';' && self.lex.tk != 0 {
                let (decl_idx, mut decl_ty, decl_arr) = self.parse_declarator(base)?;
                if decl_idx != usize::MAX {
                    // An array parameter is adjusted to a
                    // pointer to the element type (6.7.5.3p7).
                    if decl_arr != 0 {
                        decl_ty += Ty::Ptr as i64;
                    }
                    if let Some(pos) = params.indices.iter().position(|&pi| pi == decl_idx) {
                        self.symbols[decl_idx].type_ = decl_ty;
                        params.types[pos] = decl_ty;
                    } else {
                        return Err(self
                            .compile_err("old-style parameter declaration names a non-parameter"));
                    }
                }
                self.accept(',')?;
            }
            self.accept(';')?;
        }
        Ok(())
    }

    /// Open the frame the body emits into: the return-type state the
    /// `return` lowering reads, the parameter slot numbering the call ABI
    /// places, the per-function counters, and the entry pc. Returns the
    /// entry pc the finished function is recorded under.
    fn open_function_body(
        &mut self,
        id_idx: usize,
        params: &super::function::ParsedParams,
    ) -> usize {
        // Track this function's declared return type
        // so the `return s` lowering knows whether to
        // emit a struct-copy through the hidden
        // out-pointer.
        let return_ty = self.symbols[id_idx].type_;
        self.current_func_return_ty = return_ty;
        self.current_func_returns_void = self.symbols[id_idx].returns_void;
        self.current_function_name = self.symbols[id_idx].name.clone();
        self.current_func_conv = self.symbols[id_idx].conv;

        // Callers push right to left, so the i'th declared parameter sits at slot
        // i + 2 and the variadic tail follows it. A struct return through the
        // out-pointer convention takes slot 2 for the hidden pointer and pushes the
        // declared parameters to 3; a host-ABI register return does not, and the
        // calling convention -- not the type alone -- decides which.
        let param_base = if matches!(
            super::struct_return_abi_conv(
                &self.structs,
                self.target,
                self.current_func_conv,
                return_ty,
            ),
            super::StructReturnAbi::OutPtr
        ) {
            3
        } else {
            2
        };
        for (i, &idx) in params.indices.iter().enumerate() {
            self.symbols[idx].val = (i as i64) + param_base;
        }

        self.loc_offs = 0;
        self.committed_loc_offs = 0;
        self.max_loc_offs = 0;
        self.multi_cell_temps.clear();
        self.func_over_aligned.clear();
        self.labels.clear();
        self.unresolved_gotos.clear();
        self.local_label_scopes.clear();
        self.func_local_addr_taken = false;
        self.uses_alloca_in_current_fn = false;
        self.func_vla_decls = 0;
        self.ast_reset();

        let ent_pc = self.next_ent_pc;
        // C99 6.2.1: a parameter sharing the function's name shadows it inside the
        // body, so the entry pc goes onto the shadowed binding the function-exit
        // cleanup restores, leaving the parameter its slot.
        if params.indices.contains(&id_idx) {
            self.symbols[id_idx].h_val = ent_pc as i64;
        } else {
            self.symbols[id_idx].val = ent_pc as i64;
        }
        self.symbols[id_idx].defined_here = true;
        if !self.pending_saw_inline_specifier {
            self.symbols[id_idx].saw_noninline_def = true;
        }
        // A body trumps any earlier `extern T f();`
        // forward declaration -- the function is now
        // defined in this translation unit.
        self.symbols[id_idx].is_extern_decl = false;

        // `__attribute__((constructor))` / `((destructor))` on
        // any declaration of this name: record it so the emit
        // path lowers it into `.init_array` / `.fini_array` and
        // the VM / JIT run it around `main`. The symbol carries
        // the merged attributes, so a prototype-only attribute
        // reaches this definition.
        if self.symbols[id_idx].is_constructor || self.symbols[id_idx].is_destructor {
            let is_destructor = self.symbols[id_idx].is_destructor;
            self.init_funcs.push(crate::c5::program::InitFunc {
                name: self.symbols[id_idx].name.clone(),
                ent_pc,
                priority: self.symbols[id_idx].init_priority,
                is_destructor,
            });
        }

        ent_pc
    }

    fn copy_by_value_parameters(&mut self, params: &super::function::ParsedParams) {
        // C99 6.5.2.2: a struct parameter is passed by value, but the caller pushed
        // its address. Copy it into a fresh local through the struct-copy intrinsic
        // and repoint the symbol, so a body-side `p.field = v` writes the copy.
        for &idx in params.indices.iter() {
            let pty = self.symbols[idx].type_;
            if !is_struct_ty(pty) || struct_ptr_depth(pty) != 0 {
                continue;
            }
            let slots = self.slots_of_type(pty);
            let param_val = self.symbols[idx].val;
            let local_val = self.reserve_slots(slots);
            if slots >= 1 {
                self.multi_cell_temps.push((local_val, slots));
            }
            // dst = &local
            self.emit_lea(local_val);
            self.ast_psh();
            // src = *param_slot -- the address the caller pushed
            self.emit_lea(param_val);
            self.mark_emit_other();
            self.mark_emit_other();
            // The symbol now points at the local copy.
            self.symbols[idx].val = local_val;
        }

        // A `float` parameter arrives as the 8-byte `f64::to_bits` of its value,
        // which the body's 4-byte load would read the low half of. Narrow it into
        // a fresh local at entry -- an 8-byte load of the slot through a 4-byte
        // store -- and repoint the symbol at that local.
        for &idx in params.indices.iter() {
            let pty = strip_unsigned(self.symbols[idx].type_);
            if pty != Ty::Float as i64 {
                continue;
            }
            let param_val = self.symbols[idx].val;
            let local_val = self.reserve_slots(1);
            // dst = &local
            self.emit_lea(local_val);
            self.ast_psh();
            // Load the caller-pushed f64::to_bits from
            // the param slot. The full 8-byte load is
            // intentional -- the caller pushed 8 bytes
            // and the f32 information lives across all
            // 8 of them (as an f64).
            self.emit_lea(param_val);
            self.mark_emit_other();
            // Narrow to f32 + write 4 bytes to the local.
            // The rounding is round-to-nearest-ties-to-
            // even, matching `f64 as f32` in Rust and
            // `cvtsd2ss` / `fcvt s, d` on the JIT path.
            self.ast_assign();
            // Symbol now points at the f32-storage local.
            self.symbols[idx].val = local_val;
        }
    }

    fn parse_function_body_items(&mut self) -> Result<(), C5Error> {
        // C99 block-scope: declarations may appear
        // anywhere a statement may. Each iteration
        // either parses a local decl (with optional
        // initializer) into the function's symbol
        // frame, or parses a statement.
        let mut top_level_ids: alloc::vec::Vec<super::super::ast::StmtId> = alloc::vec::Vec::new();
        self.stmt_expr_arena_ranges.clear();
        // C99 6.2.1: a tag declared in a function body has
        // block scope. Push a tag scope so a struct / union /
        // enum defined at the body top level is local to this
        // function -- two functions defining the same tag do
        // not collide, and a body-scope tag shadows a
        // file-scope one. Nested blocks push their own scopes
        // through parse_block_stmt.
        self.tag_scopes.push(alloc::vec::Vec::new());
        // The function body's top-level block scope for
        // `__attribute__((cleanup))` variables; cleaned on
        // fall-through (below) and on every `return`.
        self.cleanup_scopes.push(alloc::vec::Vec::new());
        // GCC local labels declared by the body's top-level
        // block; see `Compiler::resolve_label_name`.
        self.local_label_scopes.open();
        let mut at_block_start = true;
        while self.lex.tk != '}' {
            if self.lex.tk == Token::LocalLabel {
                if !at_block_start {
                    return Err(
                        self.compile_err("`__label__` must appear at the start of its block")
                    );
                }
                self.parse_local_label_decl()?;
                continue;
            }
            at_block_start = false;
            // C23 6.7.13 / 6.8: an attribute-specifier-
            // sequence may lead either a declaration or a
            // statement at the function-body top level.
            // Consume it, then dispatch on the following
            // token.
            let mut leading_maybe_unused = false;
            if self.lex.tk == Token::Attribute
                || (self.lex.tk == Token::Brak && self.lex.peek_after_whitespace(b'['))
            {
                self.pending.attr_maybe_unused = false;
                self.pending.attr_cleanup = None;
                self.pending.attr_uninitialized = false;
                self.skip_attribute_specifiers()?;
                leading_maybe_unused = self.pending.attr_maybe_unused;
                if self.lex.tk == '}' {
                    break;
                }
            }
            if self.lex.tk == Token::StaticAssert {
                // C11 6.7.10 lets static_assert sit
                // anywhere a declaration may appear,
                // including the function-body top
                // level (and the inner blocks reached
                // through parse_block_stmt).
                self.parse_static_assert()?;
            } else if self.lex.tk == Token::Typedef {
                // C99 6.7.7: a typedef may appear at the
                // function-body top level. `lex_is_type_start`
                // does not cover the `typedef` storage-class
                // keyword, so dispatch it here (the nested
                // blocks reach the same handler through
                // parse_block_stmt).
                self.parse_block_typedef()?;
            } else if self.lex_is_type_start() {
                let item_before = self.ast_stmts_snapshot();
                self.parse_local_decl(leading_maybe_unused)?;
                let item_after = self.ast.stmts.len();
                // Skip any statement-expression sub-statements
                // interleaved by an initializer; they are
                // reached through the Decl's `Expr::StmtExpr`.
                for id in item_before..item_after {
                    if self.in_stmt_expr_range(id) {
                        continue;
                    }
                    top_level_ids.push(id as super::super::ast::StmtId);
                }
                self.stmt_expr_arena_ranges
                    .retain(|&(s, _)| s < item_before);
            } else {
                let item_before = self.ast_stmts_snapshot();
                self.stmt()?;
                let item_after = self.ast.stmts.len();
                let item_id = if item_after > item_before + 1 {
                    self.ast_wrap_stmts_since(item_before)
                } else if item_after > item_before {
                    (item_after - 1) as super::super::ast::StmtId
                } else {
                    continue;
                };
                top_level_ids.push(item_id);
            }
        }
        // Fall-through / implicit return: run the body's
        // top-level `__attribute__((cleanup))` functions in
        // reverse declaration order before the synthetic return.
        if self.cleanup_scopes.last().is_some_and(|s| !s.is_empty()) {
            let pending: alloc::vec::Vec<_> = self
                .cleanup_scopes
                .last()
                .unwrap()
                .iter()
                .rev()
                .cloned()
                .collect();
            for cv in pending {
                let before = self.ast.stmts.len();
                self.push_cleanup_call(&cv);
                for id in before..self.ast.stmts.len() {
                    top_level_ids.push(id as super::super::ast::StmtId);
                }
            }
        }
        self.cleanup_scopes.pop();
        self.tag_scopes.pop();
        self.local_label_scopes.close();
        // Wrap the function's top-level stmts into a
        // Compound and pin it as `ast.body` so the
        // walker has a single tree root to descend
        // without double-walking inner-wrapped stmts.
        let body_root = self.ast_wrap_block_items(&top_level_ids);
        self.ast.body = Some(body_root);
        Ok(())
    }

    /// Close the body: the synthetic return, the dead-store flush, and the
    /// `FinishedFunction` record the walker lowers.
    fn finish_function_body(
        &mut self,
        ent_pc: usize,
        params: &super::function::ParsedParams,
    ) -> Result<(), C5Error> {
        // C99 6.8.6.4p3: a `void` function produces no value, so the accumulator
        // is zeroed before the synthetic return -- a caller that misclassifies the
        // prototype then reads 0 rather than whatever the body left. A naked
        // function returns from its own asm and takes no synthetic return.
        if self.current_func_returns_void {
            self.emit_imm(0);
        }
        self.emit_dead_stores_and_flush();
        let n_params = params.indices.len();
        let is_variadic = params.is_variadic;
        // Snapshot per-param types + the local-copy
        // slot the parser allocated for each
        // struct-by-value parameter. The walker
        // replays the C99 6.5.2.2 entry-Mcpy from
        // these so the callee operates on its own
        // copy. Scalar / pointer params end up
        // with `0` in `param_local_slots`; the
        // walker checks the slot and the type both.
        let param_tys: alloc::vec::Vec<i64> = params.types.to_vec();
        let param_local_slots: alloc::vec::Vec<i64> = params
            .indices
            .iter()
            .map(|&idx| {
                let v = self.symbols[idx].val;
                // `val < 0` -> local slot reassigned
                // by the entry-Mcpy emit; preserve
                // it. `val >= 0` -> scalar param
                // still sits in its original slot;
                // record 0 so the walker skips.
                if v < 0 { v } else { 0 }
            })
            .collect();
        let ret_ty_for_finish = self.current_func_return_ty;
        let returns_struct_finish = is_struct_value_ty(ret_ty_for_finish);
        let return_struct_size_finish = if returns_struct_finish {
            self.size_of_type(ret_ty_for_finish) as i64
        } else {
            0
        };

        // With alloca the prologue also reserves the bookkeeping slot just below
        // the regular locals, and the arena above it.
        let regular_locals = self.max_loc_offs.max(self.loc_offs);
        let alloca_top_slot_finish: i64 = if self.uses_alloca_in_current_fn {
            regular_locals + 1
        } else {
            0
        };

        // C99 6.9.1p12: warn when a value-returning function
        // may reach its closing brace without a `return value;`.
        // Run before `ast_finish_function` moves the body AST.
        self.check_non_void_fall_off();
        self.ast_finish_function(
            ent_pc,
            n_params,
            is_variadic,
            param_tys,
            param_local_slots,
            returns_struct_finish,
            return_struct_size_finish,
            ret_ty_for_finish,
            alloca_top_slot_finish,
        );
        self.current_function_name.clear();
        self.current_func_returns_void = false;

        for name in &self.unresolved_gotos {
            if !self.label_is_defined(name) {
                return Err(self.compile_err(format!(
                    "unresolved label: {}",
                    super::emit::label_display_name(name)
                )));
            }
        }

        Ok(())
    }

    /// Capture the function's parameters and locals for the debug info
    /// before the scope unwind restores their outer bindings. Returns the
    /// index the unit-wide variable list grew from.
    fn record_function_variables(
        &mut self,
        ent_pc: usize,
        params: &super::function::ParsedParams,
        bound: &[u32],
        param_set: &alloc::collections::BTreeSet<usize>,
    ) -> usize {
        // `variables` accumulates over the whole unit; this
        // function owns exactly the entries appended from here on.
        // Parameters go first, in declaration order (DWARF 5
        // 3.3.4): `bound` is symbol-table order, which follows
        // name interning across the unit, not the prototype.
        let vars_start = self.variables.len();
        let capture_order: alloc::vec::Vec<usize> = params
            .indices
            .iter()
            .copied()
            .chain(
                bound
                    .iter()
                    .map(|&bi| bi as usize)
                    .filter(|i| !param_set.contains(i)),
            )
            .collect();
        for i in capture_order {
            let sym = &self.symbols[i];
            if sym.class == Token::Loc as i64
                && sym.val != 0
                && sym.val != 1
                && !sym.name.is_empty()
            {
                let is_parameter = param_set.contains(&i);
                // C99 6.7.5.3p7: a parameter declared as
                // `T name[N]` decays to a pointer and
                // doesn't carry an array-type DIE; keep
                // `array_size` at zero for parameters.
                let array_size = if is_parameter {
                    0
                } else {
                    sym.array_size.max(0) as u32
                };
                self.variables.push(crate::c5::program::VariableInfo {
                    function_bc_pc: ent_pc as u64,
                    name: sym.name.clone(),
                    type_tag: sym.type_,
                    fp_slot: sym.val,
                    is_parameter,
                    decl_line: sym.decl_line as u32,
                    array_size,
                    decl_file: sym.decl_file,
                    fn_ptr_indirection: sym.fn_ptr_indirection,
                    params: sym.params.clone(),
                    is_variadic: sym.is_variadic,
                    array_dims: if is_parameter {
                        Vec::new()
                    } else {
                        sym.array_dims.clone()
                    },
                    decl_spelling: sym.decl_spelling,
                });
            }
        }
        // Block-scoped locals unbound at their block's exit, which the walk
        // over the function's own bindings does not see. Every pending entry
        // belongs to this function: C has no nested function definitions.
        for mut bl in core::mem::take(&mut self.pending_block_locals) {
            bl.function_bc_pc = ent_pc as u64;
            self.variables.push(bl);
        }
        // Stamp the owner on each block-scope static's
        // emission record for the same reason.
        for i in core::mem::take(&mut self.pending_block_static_syms) {
            self.symbols[i].owner_ent_pc = Some(ent_pc as u64);
        }
        vars_start
    }

    fn classify_function_frame(&mut self, vars_start: usize) -> Result<(), C5Error> {
        // A local at frame slot `fp_slot` occupying `cells` cells covers
        // `fp_slot ..= fp_slot + cells - 1`: slot coalescing reserves the interior
        // cells, which carry no slot reference of their own, and scalar promotion
        // reads the list as its candidate set. A struct-by-value parameter keeps
        // its body-visible copy in a negative slot too (C99 6.5.2.2), so the test
        // is `fp_slot < 0`, not `!is_parameter`.
        let mut multi_cell: Vec<(i64, i64)> = Vec::new();
        // Stack-protector classification of the same declared
        // objects: what the `-fstack-protector*` modes select on.
        let mut ssp = crate::c5::ir::SspFacts {
            addr_taken: self.func_local_addr_taken,
            dynamic_alloca: self.uses_alloca_in_current_fn,
            ..Default::default()
        };
        for v in &self.variables[vars_start..] {
            if v.fp_slot < 0 {
                let cells = self.local_storage_slots(v.type_tag, v.array_size as i64);
                let aggregate = is_struct_value_ty(v.type_tag) || v.array_size > 0;
                if cells > 1 || (cells == 1 && aggregate) {
                    multi_cell.push((v.fp_slot, cells));
                }
                ssp.merge(super::types::ssp_classify(
                    &self.structs,
                    v.type_tag,
                    v.array_size as i64,
                    v.array_dims.len() > 1,
                    &|t| self.size_of_type(t),
                ));
            }
        }
        // Multi-cell temporaries the parser allocated without a
        // symbol (struct call results, parameter copies, compound
        // literals); these never appear in the variable list.
        multi_cell.extend_from_slice(&self.multi_cell_temps);
        let over_aligned = core::mem::take(&mut self.func_over_aligned);
        // C11 6.7.5 + C99 6.7.6.2: an alignment above 16 is met by
        // realigning sp in the prologue, which `alloca` and a
        // variable-length array preclude (both move sp). Exactly 16
        // is met at a static frame offset and coexists with both.
        // Diagnosed here, where both facts are known, so the
        // combination reads as a source-level rejection rather
        // than reaching the walker's internal error.
        if over_aligned.iter().any(|&(_, align, _)| align > 16) && self.uses_alloca_in_current_fn {
            return Err(self.compile_err(
                "an automatic object aligned above 16 cannot share a function \
             with `alloca` or a variable-length array; use static storage",
            ));
        }
        if let Some(ff) = self.finished_functions.last_mut() {
            ff.multi_cell_slots = multi_cell;
            ff.over_aligned_slots = over_aligned;
            ff.ssp = ssp;
        }
        Ok(())
    }

    fn warn_unused_function_bindings(
        &mut self,
        bound: &[u32],
        param_set: &alloc::collections::BTreeSet<usize>,
    ) {
        // The function's own bindings only: an inner block reports its locals at
        // its own exit. Runs before the scope unwind, which overwrites the class
        // this test reads. A leading `_` suppresses the diagnostic, as under gcc
        // and clang.
        enum UnusedKind {
            Variable,
            Parameter,
            ValueSet,
        }
        let mut unused: Vec<(usize, String, UnusedKind)> = Vec::new();
        for &bi in bound {
            let i = bi as usize;
            let sym = &self.symbols[i];
            if sym.class != Token::Loc as i64
                || !sym.decl_in_main_source
                || sym.address_escaped
                || sym.was_read
                || sym.maybe_unused
                || sym.name.is_empty()
                || sym.name.starts_with('_')
            {
                continue;
            }
            let is_param = param_set.contains(&i);
            // sym.val < 0 -> stack-frame local
            // sym.val >= 2 -> parameter slot
            // (slots 0/1 are reserved for caller's
            // saved rbp / saved-ret-addr; never
            // user-visible names)
            if !is_param && sym.val >= 0 {
                continue;
            }
            // `was_referenced` separates "never mentioned" from "mentioned, but every
            // mention was a write" -- the dead-store case. A parameter is written at
            // call entry, so it takes the unused-parameter diagnostic instead.
            let kind = if sym.was_referenced && sym.was_written && !is_param {
                UnusedKind::ValueSet
            } else if is_param {
                UnusedKind::Parameter
            } else {
                UnusedKind::Variable
            };
            unused.push((sym.decl_line, sym.name.clone(), kind));
        }
        for (line, name, kind) in unused {
            let msg = match kind {
                UnusedKind::Variable => alloc::format!("unused variable `{name}`"),
                UnusedKind::Parameter => alloc::format!("unused parameter `{name}`"),
                UnusedKind::ValueSet => {
                    alloc::format!("variable `{name}` set but never used")
                }
            };
            self.warn_at(line, msg);
        }
        // Drain dead-store entries for this function's
        // locals via the shared helper -- a store that
        // reaches function exit without an intervening
        // read or branch is unambiguously dead.
        self.emit_dead_stores_and_flush();
        // Block-scope locals (`Loc`), `static` locals
        // (promoted to `Glo` but block-scoped) and an
        // `extern` that converted a bound file-scope name
        // all unbind at function exit so the outer binding
        // of the same name reappears.
    }

    /// Bind the declarator as an object: linkage and attributes, then the
    /// storage its definition reserves and the initializer that fills it
    /// (C99 6.9.2).
    /// Bind the declarator as an object: linkage and attributes, then the
    /// storage its definition reserves and the initializer that fills it
    /// (C99 6.9.2).
    fn define_file_scope_object(
        &mut self,
        decl: &FileScopeDecl,
        b: &DeclaratorBinding,
        was_tentative_glo: bool,
    ) -> Result<(), C5Error> {
        let &FileScopeDecl {
            static_seen,
            extern_seen,
            thread_local,
            base_type_align,
            ..
        } = decl;
        let &DeclaratorBinding {
            id_idx,
            ty,
            array_size,
            prior_array_size,
            signature_line,
            ..
        } = b;

        self.record_object_declaration(id_idx, static_seen, thread_local, was_tentative_glo);
        if self.bind_object_alias(id_idx, ty)? {
            return Ok(());
        }
        let decl_align = self.object_alignment(id_idx, ty, base_type_align, thread_local)?;
        let was_extern_only_decl = extern_seen && self.lex.tk != Token::Assign && array_size != -1;
        // `extern struct S s;` whose tag has no fixed size -- incomplete, or with a
        // flexible array member whose count the defining initializer fixes (C99
        // 6.7.2.1) -- reserves nothing: C99 6.9.2 makes it a pure declaration, and
        // a wrong-sized slot here would either overlap the next global or strand
        // the references emitted against it. After a prior definition the extern
        // is a redeclaration of it (6.2.2p4), which keeps its storage.
        if was_extern_only_decl
            && !self.symbols[id_idx].defined_here
            && is_struct_value_ty(ty)
            && (self.structs[struct_id_of(ty)].fields.is_empty()
                || self.flexible_array_member(struct_id_of(ty)).is_some())
        {
            // C99 6.2.2p4 + 6.9.2p2: after a prior definition in
            // this unit the extern redeclaration is a pure
            // redeclaration; the definition and its storage stand.
            if !self.symbols[id_idx].defined_here {
                self.symbols[id_idx].is_extern_decl = true;
                self.symbols[id_idx].type_ = ty;
            }
            return Ok(());
        }
        if was_extern_only_decl {
            // C99 6.2.2p4 + 6.9.2p2: `extern T x;` after a
            // prior file-scope definition (tentative or
            // initialized) redeclares the same object; the
            // definition stands.
            if !self.symbols[id_idx].defined_here {
                self.symbols[id_idx].is_extern_decl = true;
            }
        } else {
            self.symbols[id_idx].is_extern_decl = false;
            // C99 6.9.2p3: the type of a definition must not be
            // incomplete. A tentative definition's tag may be
            // completed further on in the unit, so the check runs
            // once the unit is parsed.
            if let Some(sid) = self.incomplete_aggregate_tag(ty) {
                self.pending_incomplete_objects
                    .push((id_idx, sid, signature_line));
            }
        }
        // Deferred-size array global: the dimension
        // comes from the initializer and storage is
        // reserved after parsing it. Disallow on TLS
        // globals -- the per-target rebase ordering
        // needs design work.
        if array_size == -1 {
            self.define_deferred_size_array(
                id_idx,
                ty,
                decl_align,
                thread_local,
                extern_seen,
                was_tentative_glo,
                prior_array_size,
            )
        } else {
            self.define_sized_object(
                id_idx,
                ty,
                array_size,
                decl_align,
                thread_local,
                was_tentative_glo,
                was_extern_only_decl,
            )
        }
    }

    /// C99 6.2.2: record the object, its source position and its linkage.
    /// `static` is sticky once any declaration of the name carries it.
    fn record_object_declaration(
        &mut self,
        id_idx: usize,
        static_seen: bool,
        thread_local: bool,
        was_tentative_glo: bool,
    ) {
        self.symbols[id_idx].class = Token::Glo as i64;
        // First declaration wins the source position, as it does
        // for functions; it feeds DW_AT_decl_file / decl_line.
        if self.symbols[id_idx].decl_line == 0 {
            self.symbols[id_idx].decl_line = self.lex.line;
            self.symbols[id_idx].decl_file = self.intern_source_file() as u32;
            self.symbols[id_idx].decl_in_main_source = self.in_main_source();
        }
        if !was_tentative_glo {
            self.symbols[id_idx].is_thread_local = thread_local;
        }
        // C99 6.2.2 linkage on file-scope variables.
        // `static` is sticky once seen on any earlier
        // declaration of the same name; absent that,
        // the default is external linkage. `extern T x;`
        // is captured separately so an extern-only
        // declaration can be distinguished from a
        // tentative definition at link-unit assembly.
        if static_seen {
            self.symbols[id_idx].linkage = crate::c5::symbol::Linkage::Internal;
        } else if self.symbols[id_idx].linkage != crate::c5::symbol::Linkage::Internal {
            self.symbols[id_idx].linkage = crate::c5::symbol::Linkage::External;
        }
        self.apply_symbol_attributes(id_idx);
    }

    /// `alias("target")` on an object declarator: the name is a second
    /// symbol at the target object's offset and reserves no storage of its
    /// own. Returns true when the declarator is fully bound here -- as an
    /// alias, or as a redeclaration of one (C99 6.9.2p2).
    fn bind_object_alias(&mut self, id_idx: usize, ty: i64) -> Result<bool, C5Error> {
        // `alias("target")` on an object declarator: the name
        // is an additional symbol at the target object's
        // offset. It reserves no storage of its own; the
        // regular data-symbol emission picks it up with the
        // shared offset.
        if let Some(target) = self.pending.attr_alias.take() {
            let tgt = self
                .symbols
                .iter()
                .position(|s| s.name == target && s.class == Token::Glo as i64 && s.defined_here);
            // `has_initializer` marks the alias as carrying a
            // value: a later `= init` trips the duplicate-
            // definition check like any second initializer.
            let Some(tgt) = tgt else {
                // The target may be defined later in the unit.
                self.pending_aliases.push((id_idx, target, true));
                self.symbols[id_idx].class = Token::Glo as i64;
                self.symbols[id_idx].type_ = ty;
                self.symbols[id_idx].is_alias = true;
                self.symbols[id_idx].has_initializer = true;
                return Ok(true);
            };
            self.symbols[id_idx].class = Token::Glo as i64;
            self.symbols[id_idx].type_ = ty;
            self.symbols[id_idx].val = self.symbols[tgt].val;
            Self::adopt_alias_storage(&mut self.symbols, id_idx, tgt);
            self.symbols[id_idx].defined_here = true;
            self.symbols[id_idx].is_extern_decl = false;
            self.symbols[id_idx].is_alias = true;
            self.symbols[id_idx].has_initializer = true;
            return Ok(true);
        }
        // C99 6.9.2p2: a later no-initializer declaration redeclares the
        // alias-defined object. The alias owns no storage, so reserving any
        // for it would break the binding.
        if self.symbols[id_idx].is_alias && self.lex.tk != Token::Assign {
            return Ok(true);
        }
        Ok(false)
    }

    /// C11 6.7.5: the object is placed at the strictest alignment its
    /// declarations request and its type requires. Returns the alignment
    /// the data cursor is now at.
    fn object_alignment(
        &mut self,
        id_idx: usize,
        ty: i64,
        base_type_align: i64,
        thread_local: bool,
    ) -> Result<usize, C5Error> {
        // C11 6.7.5: a requested alignment is honored on
        // file-scope objects -- the object writer aligns the
        // section to `Program::data_align` and the object's
        // offset within it via `align_data_to`. The attribute
        // requires a power of two (C11 6.7.5p3); anything past
        // the supported maximum is a diagnostic, never a silent
        // drop.
        let req_align = core::mem::take(&mut self.pending.attr_align);
        let alignas_align = core::mem::take(&mut self.pending.attr_alignas);
        if req_align > 8 && !(req_align as usize).is_power_of_two() {
            return Err(self.compile_err(format!(
                "requested alignment {req_align} is not a power of two"
            )));
        }
        if req_align > super::MAX_STATIC_ALIGN as i64 {
            return Err(self.compile_err(format!(
                "requested alignment {req_align} exceeds the supported maximum of {}",
                super::MAX_STATIC_ALIGN
            )));
        }
        // The object takes the wider of what the declarator asks for and what its
        // type requires: an `aligned(64)` member raises its whole aggregate, so
        // `struct S g;` needs a 64-aligned slot with no attribute in sight. A
        // typedef-carried `aligned(N)` raises it the same way; a pointer object
        // keeps pointer alignment.
        let type_align = if is_pointer_ty(ty) {
            0
        } else {
            base_type_align.max(0) as usize
        };
        self.check_alignas_not_weaker(ty, alignas_align)?;
        // A variable-level GNU `aligned(N)` sets the placement,
        // replacing what the type asks for; the type's
        // attribute-free alignment stays a floor. `_Alignas`
        // only raises.
        let gnu_set = req_align > alignas_align;
        let want_align = if gnu_set {
            core::cmp::max(req_align as usize, self.unattributed_align_of(ty))
        } else {
            core::cmp::max(
                core::cmp::max(req_align.max(0) as usize, self.align_of_type(ty)),
                type_align,
            )
        };
        // Declarations of one object combine to the strictest
        // alignment (C11 6.7.5, GNU attribute practice): an
        // attribute-free redeclaration must not lower the
        // recorded placement.
        self.symbols[id_idx].data_align = self.symbols[id_idx]
            .data_align
            .max(want_align.max(1) as i64);
        // Declared object alignment for `__alignof__` on the
        // name: a declarator attribute replaces a typedef-carried
        // value, else raises the natural alignment; the typedef
        // value alone stands as given (it may lower). Distinct
        // from the placement above, which never lowers.
        let obj_align = if req_align == 0 {
            type_align as i64
        } else if gnu_set || type_align > 0 {
            req_align
        } else {
            req_align.max(self.align_of_type(ty) as i64)
        };
        self.symbols[id_idx].type_align = self.symbols[id_idx].type_align.max(obj_align);
        let decl_align: usize = if want_align > 8 {
            if thread_local && (req_align > 8 || want_align > 16) {
                return Err(self.compile_err(
                    "alignment above 8 is not supported for `_Thread_local` objects",
                ));
            }
            self.data_align = self.data_align.max(want_align);
            want_align
        } else {
            8
        };
        // Align the data cursor before any of the branches
        // below reserve storage, so a tentative or zero-init
        // definition starts on the object's boundary.
        if decl_align > 8 {
            self.align_data_to(decl_align);
        }
        Ok(decl_align)
    }

    /// A deferred-size array (`T xs[]`): the initializer supplies the
    /// element count, so the storage is reserved once it is parsed.
    #[allow(clippy::too_many_arguments)]
    fn define_deferred_size_array(
        &mut self,
        id_idx: usize,
        ty: i64,
        decl_align: usize,
        thread_local: bool,
        extern_seen: bool,
        was_tentative_glo: bool,
        prior_array_size: i64,
    ) -> Result<(), C5Error> {
        if self.lex.tk != Token::Assign {
            return self.declare_deferred_size_array(
                id_idx,
                ty,
                decl_align,
                extern_seen,
                prior_array_size,
            );
        }
        if thread_local {
            return Err(self.compile_err("deferred-size `_Thread_local` arrays are not supported"));
        }
        self.next()?;
        if self.is_traversable_aggregate_ty(ty) {
            return self.define_deferred_struct_array(id_idx, ty, decl_align, was_tentative_glo);
        }
        self.pending.init_inner_dims = self.inner_dims_of(id_idx);
        let elements = self.collect_array_initializer(ty)?;
        let final_size = elements.len() as i64;
        self.symbols[id_idx].array_size = final_size;
        // `T xs[] = {}` resolves to zero elements; keep the
        // array-ness that the scalar `array_size == 0`
        // encoding would otherwise drop.
        self.symbols[id_idx].is_zero_len_array = final_size == 0;
        self.reserve_zero_length_array_slot(id_idx);
        // Patch the deferred-outer placeholder in
        // `array_dims[0]` to the resolved row count.
        // Layout: total elements = outer * inner-dims-product,
        // so the outermost count is final_size /
        // product(dims[1..]).
        if let Some(first) = self.symbols[id_idx].array_dims.first().copied()
            && first == 0
        {
            let inner_product: i64 = self.symbols[id_idx].array_dims.iter().skip(1).product();
            if inner_product > 0 {
                self.symbols[id_idx].array_dims[0] = final_size / inner_product;
            }
        }
        let total_bytes = (self.size_of_type(ty) as i64) * final_size;
        let aligned = ((total_bytes + 7) / 8) * 8;
        // C99 6.9.2: a prior tentative definition already
        // reserved storage; reuse it so references emitted
        // before this definition observe the initialized object,
        // not the tentative's separate zero copy. A
        // deferred-size tentative (`T x[];`) reserves one
        // element, so a larger initializer takes fresh storage
        // and records the move for rebasing.
        let obj_align = self.symbols[id_idx].data_align.max(1);
        let off = if was_tentative_glo
            && aligned <= self.symbols[id_idx].reserved_data_bytes
            && self.symbols[id_idx].val % obj_align == 0
        {
            self.symbols[id_idx].val
        } else {
            let eff = decl_align.max(obj_align as usize);
            if eff > 8 {
                self.align_data_to(eff);
            } else if self.size_of_type(ty) > 1 {
                self.align_data_to_8();
            }
            let fresh = self.data.len() as i64;
            self.note_global_relocated(id_idx, was_tentative_glo, fresh);
            self.symbols[id_idx].reserved_data_bytes = aligned;
            for _ in 0..aligned {
                self.data.push(0);
            }
            fresh
        };
        self.symbols[id_idx].val = off;
        self.write_array_init_into_data(off, ty, &elements)?;
        self.symbols[id_idx].has_initializer = true;
        self.symbols[id_idx].defined_here = true;
        Ok(())
    }

    /// The same array without an initializer: `extern T x[];` declares it
    /// elsewhere, and a bare `T x[];` is a tentative definition an
    /// end-of-unit completion sizes at one element (C99 6.9.2p2).
    fn declare_deferred_size_array(
        &mut self,
        id_idx: usize,
        ty: i64,
        decl_align: usize,
        extern_seen: bool,
        prior_array_size: i64,
    ) -> Result<(), C5Error> {
        // `extern T x[];` declares an array
        // whose definition (with its actual
        // size) lives in another TU. Mark
        // the symbol as undefined-here and
        // let the link step resolve the
        // address against the defining TU's
        // storage.
        if extern_seen {
            // C99 6.2.2p4: after a prior definition,
            // `extern T x[];` is a redeclaration of
            // the same object -- the definition and
            // its dimension stand.
            if self.symbols[id_idx].defined_here {
                self.symbols[id_idx].array_size = prior_array_size;
            } else {
                self.symbols[id_idx].is_extern_decl = true;
                self.symbols[id_idx].defined_here = false;
            }
            return Ok(());
        }
        // C99 6.9.2p2: a file-scope `T x[];` with no
        // `extern` and no initializer is a tentative
        // definition, and an array type left incomplete
        // at the end of the unit is completed to one
        // element. A GNU `T x[0]` is complete already and
        // holds no elements, so it keeps the zero count.
        let zero_len = self.pending.declarator_zero_len_array;
        let count = if zero_len { 0 } else { 1 };
        self.symbols[id_idx].array_size = count;
        self.symbols[id_idx].is_zero_len_array = zero_len;
        if let Some(first) = self.symbols[id_idx].array_dims.first_mut() {
            *first = count;
        }
        let elem = self.size_of_type(ty) as i64;
        let aligned = (((elem + 7) / 8) * 8).max(8);
        if decl_align > 8 {
            self.align_data_to(decl_align);
        } else if self.size_of_type(ty) > 1 {
            self.align_data_to_8();
        }
        let off = self.data.len() as i64;
        self.symbols[id_idx].val = off;
        self.symbols[id_idx].reserved_data_bytes = aligned;
        for _ in 0..aligned {
            self.data.push(0);
        }
        self.symbols[id_idx].defined_here = true;
        Ok(())
    }

    /// `struct T xs[] = { ... }`: pre-scan the brace list for the element
    /// count so every element is reserved contiguously before a string
    /// literal inside one appends to the data segment.
    fn define_deferred_struct_array(
        &mut self,
        id_idx: usize,
        ty: i64,
        decl_align: usize,
        was_tentative_glo: bool,
    ) -> Result<(), C5Error> {
        // `struct T xs[] = { {...}, {...}, ... };`
        // Pre-scan the source to count elements so
        // every element's storage is pre-reserved
        // contiguously *before* any string literal
        // inside an element gets appended to
        // `self.data` and pushes subsequent
        // elements to a non-contiguous offset.
        let elem_size = self.size_of_type(ty);
        if self.lex.tk != '{' {
            return Err(self.compile_err("array initializer must start with `{{`"));
        }
        let sid = struct_id_of(ty);
        // Elements below the outer (deferred) dimension:
        // for a 2D struct array `T xs[][M]` each top-level
        // brace is a row of `inner_dim` structs. 1 for a
        // plain `T xs[]`.
        let inner_dim: i64 = self.symbols[id_idx]
            .array_dims
            .get(1..)
            .map(|s| s.iter().product::<i64>())
            .unwrap_or(1)
            .max(1);
        // C99 6.7.8p20 brace elision: when no element
        // carries its own braces, the flat value list
        // fills consecutive struct elements, each
        // consuming the struct's scalar slot count.
        let groups = self.lex.count_top_level_groups_in_array();
        let count = if groups > 0 {
            // Braced elements: one `{ ... }` (or `[N] = {
            // ... }`) per element. A `[N]` designator may
            // raise the size past the positional count
            // (C99 6.7.8p22), so peek the designators.
            self.designated_array_count(groups as i64, 1)?
        } else {
            // Brace-elided: the flat value list fills
            // consecutive elements, each consuming the
            // struct's scalar slot count.
            let items = self.lex.count_top_level_items_in_array();
            let slots = self.struct_flat_init_slots(sid).max(1);
            let positional = items.div_ceil(slots) as i64;
            // A `[N].field = v` designated element list (no
            // braces, one element per item) raises the size
            // to the highest designated index + 1 (C99
            // 6.7.8p22), which the positional count misses.
            if self.array_first_element_is_designator() {
                self.designated_array_count(positional, 1)?
            } else {
                positional
            }
        };
        // C99 6.9.2: a prior tentative definition already
        // reserved storage; reuse it so references emitted
        // before this definition -- which baked in the
        // tentative's offset -- observe the initialized
        // object, not the tentative's separate zero copy.
        // A deferred-size tentative (`T x[];`) reserves one
        // element, so a larger initializer takes fresh
        // storage and records the move for rebasing.
        let needed = count * inner_dim * elem_size as i64;
        let obj_align = self.symbols[id_idx].data_align.max(1);
        let off = if was_tentative_glo
            && needed <= self.symbols[id_idx].reserved_data_bytes
            && self.symbols[id_idx].val % obj_align == 0
        {
            self.symbols[id_idx].val
        } else {
            self.align_data_to(decl_align.max(obj_align as usize));
            let fresh = self.data.len() as i64;
            self.note_global_relocated(id_idx, was_tentative_glo, fresh);
            self.symbols[id_idx].reserved_data_bytes = needed;
            for _ in 0..needed {
                self.data.push(0);
            }
            fresh
        };
        self.symbols[id_idx].val = off;
        // Reserve before consuming `{`: lexing the first
        // element token may append a string literal's
        // bytes, whose parser-added NUL must land right
        // after them.
        self.next()?;
        // `T xs[][M] = { ... }`: the pre-scan counts each top-level entry as a
        // row, but an entry after a chained designator resumes mid-row (C99
        // 6.7.8p17), so the walker's extent is the real outer count (p22).
        if inner_dim > 1 {
            let mut dims = alloc::vec::Vec::new();
            dims.push(count);
            dims.extend_from_slice(&self.symbols[id_idx].array_dims[1..]);
            let high = self.collect_struct_array_entries(ty, off, &dims)?;
            let rows = (high + inner_dim - 1) / inner_dim;
            if rows < count && self.data.len() as i64 == off + count * inner_dim * elem_size as i64
            {
                self.truncate_data((off + rows * inner_dim * elem_size as i64) as usize);
                self.symbols[id_idx].reserved_data_bytes = rows * inner_dim * elem_size as i64;
            }
            let total = rows * inner_dim;
            self.symbols[id_idx].array_size = total;
            self.symbols[id_idx].is_zero_len_array = total == 0;
            self.reserve_zero_length_array_slot(id_idx);
            if let Some(first) = self.symbols[id_idx].array_dims.first_mut()
                && *first == 0
            {
                *first = rows;
            }
            while !self.data.len().is_multiple_of(8) {
                self.data.push(0);
            }
            self.symbols[id_idx].has_initializer = true;
            self.symbols[id_idx].defined_here = true;
            return Ok(());
        }
        // Same walker the multi-dimensional case above
        // uses, so designators read identically at either
        // rank: `[N]`, the GCC range `[lo ... hi]`, and a
        // `.field` continuation.
        self.collect_struct_array_entries(ty, off, &[count])?;
        self.symbols[id_idx].array_size = count;
        // `struct T xs[] = {}` resolves to zero elements.
        // Keep the array-ness (the `array_size == 0`
        // scalar encoding would otherwise lose it).
        self.symbols[id_idx].is_zero_len_array = count == 0;
        self.reserve_zero_length_array_slot(id_idx);
        // Pad data to 8-byte alignment so the next
        // global doesn't land on an odd offset.
        while !self.data.len().is_multiple_of(8) {
            self.data.push(0);
        }
        self.symbols[id_idx].has_initializer = true;
        self.symbols[id_idx].defined_here = true;
        Ok(())
    }

    /// An object of known size: reserve or reuse its storage, then take the
    /// initializer that fills it.
    #[allow(clippy::too_many_arguments)]
    fn define_sized_object(
        &mut self,
        id_idx: usize,
        ty: i64,
        array_size: i64,
        decl_align: usize,
        thread_local: bool,
        was_tentative_glo: bool,
        was_extern_only_decl: bool,
    ) -> Result<(), C5Error> {
        // A zero-sized object (empty struct, GNU) still
        // reserves one slot so no two objects share a
        // start offset (mirrors the block-scope allocator).
        let mut bytes = if array_size > 0 {
            let total = (self.size_of_type(ty) as i64) * array_size;
            (((total + 7) / 8) * 8).max(8)
        } else {
            (self.slots_of_type(ty) * 8).max(8)
        };
        // A flexible array member initialized via `.<fam> =
        // {...}` needs its element bytes reserved now, before
        // the field fill appends string literals into that
        // trailing region (they would collide with the
        // member's data). Only the defining `= {` form
        // reserves extra; a bare / tentative declaration keeps
        // the fixed size.
        let fam_tail = self.flexible_array_init_tail_bytes(ty)?;
        if fam_tail > 0 {
            self.symbols[id_idx].fam_init_bytes = fam_tail;
            bytes = ((bytes + fam_tail + 7) / 8) * 8;
        }
        // C99 6.9.2: `extern T x;` is no tentative definition. Storage is still
        // reserved so the single-unit compile can write through the name; a
        // multi-unit build references the defining unit's bytes instead, leaving
        // this slot as the fallback.
        let _ = was_extern_only_decl;
        // C99 6.9.2: the definition writes into the storage the tentative
        // definition reserved, and a redundant `T x;` after a definition is a
        // redeclaration of the same object, so neither takes fresh zeroed bytes.
        // A second initializer already failed the duplicate-definition check.
        let obj_align = self.symbols[id_idx].data_align.max(1);
        let reuse_eligible = was_tentative_glo
            || (self.symbols[id_idx].defined_here && self.lex.tk != Token::Assign);
        // Prior storage is reusable only when it sits on the
        // object's (merged) alignment and spans every byte the
        // object now needs -- a tentative definition reserves
        // `sizeof`, which a flexible array member's initializer
        // outgrows. Otherwise the object moves to a fresh slot
        // below, as the deferred-size array paths do, and the
        // references already emitted are rebased onto it.
        let reuse_prior_storage = reuse_eligible
            && self.symbols[id_idx].val % obj_align == 0
            && bytes <= self.symbols[id_idx].reserved_data_bytes;
        // `extern _Thread_local T x;` (no initializer) is a
        // pure reference, not a definition: it must not
        // reserve TLS storage. The defining unit owns the
        // slot; the access resolves by symbol against the
        // merged TLS block at link time. A local slot here
        // would add a phantom per-unit copy (one TLS block
        // per object), breaking the shared-state semantics
        // and the multi-object link.
        let extern_tls_ref = thread_local && was_extern_only_decl;
        let var_offset = if extern_tls_ref {
            self.symbols[id_idx].is_extern_decl = true;
            self.symbols[id_idx].defined_here = false;
            0
        } else if reuse_prior_storage {
            self.symbols[id_idx].val
        } else if thread_local {
            let off = self.tls_data.len() as i64;
            self.symbols[id_idx].val = off;
            for _ in 0..bytes {
                self.tls_data.push(0);
            }
            off
        } else {
            let eff = decl_align.max(obj_align as usize);
            if eff > 8 {
                self.align_data_to(eff);
            } else if self.size_of_type(ty) > 1 {
                self.align_data_to_8();
            }
            let off = self.data.len() as i64;
            self.note_global_relocated(id_idx, reuse_eligible, off);
            let prior = (
                self.symbols[id_idx].val,
                self.symbols[id_idx].reserved_data_bytes,
            );
            self.symbols[id_idx].val = off;
            self.symbols[id_idx].reserved_data_bytes = bytes;
            for _ in 0..bytes {
                self.data.push(0);
            }
            // A move off a misaligned slot keeps the bytes a
            // prior defining declaration wrote there.
            if reuse_eligible && prior.1 > 0 {
                let n = prior.1.min(bytes) as usize;
                for k in 0..n {
                    self.data[off as usize + k] = self.data[prior.0 as usize + k];
                }
            }
            off
        };
        if !extern_tls_ref {
            self.symbols[id_idx].defined_here = true;
        }

        // The storage is already zeroed, so each form below fills only what the
        // initializer names.
        if self.lex.tk == Token::Assign {
            self.parse_object_initializer(id_idx, ty, array_size, var_offset, thread_local)?;
        }
        Ok(())
    }

    /// The initializer of a file-scope object: a brace list for an array or
    /// an aggregate, else the restricted constant-expression form (C99
    /// 6.7.8p4). The storage is already reserved and zeroed.
    fn parse_object_initializer(
        &mut self,
        id_idx: usize,
        ty: i64,
        array_size: i64,
        var_offset: i64,
        thread_local: bool,
    ) -> Result<(), C5Error> {
        self.next()?;
        // C99 6.5.2.5: `static T g = (T){ ... }` initialises the aggregate from a
        // compound literal of its own type; dropping the redundant cast leaves the
        // brace list below. A scalar object keeps it -- `T *p = (T[]){ ... }` and
        // `int x = (int){ v }` are the constant evaluator's, which needs the type.
        if array_size > 0 || self.is_traversable_aggregate_ty(ty) {
            self.skip_opt_compound_literal_cast()?;
        }
        // The two array branches below finish at the
        // literal's `}`; the grouping parens the strip
        // left behind close after it.
        let array_cl_parens = if array_size > 0 {
            core::mem::take(&mut self.pending.compound_lit_close_parens)
        } else {
            0
        };
        if array_size > 0 && self.is_traversable_aggregate_ty(ty) {
            if thread_local {
                return Err(
                    self.compile_err("array `_Thread_local` initialisers are not supported")
                );
            }
            // Known-size struct array: the shared
            // struct-array walker fills the brace list
            // into the pre-allocated slot (designators
            // at every level, positional resume at the
            // designated rank, C99 6.7.8p17); missing
            // trailing entries stay zero-init.
            let inner_dims = self.inner_dims_of(id_idx);
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
            for _ in 0..array_cl_parens {
                self.accept(')')?;
            }
        } else if array_size > 0 {
            if thread_local {
                return Err(
                    self.compile_err("array `_Thread_local` initialisers are not supported")
                );
            }
            self.pending.init_inner_dims = self.inner_dims_of(id_idx);
            self.pending.init_target_array_size = array_size;
            let elements = self.collect_array_initializer(ty)?;
            if elements.len() > array_size as usize {
                return Err(self.compile_err(format!(
                    "too many initializers for array `{}` ({} > {})",
                    self.symbols[id_idx].name,
                    elements.len(),
                    array_size
                )));
            }
            self.write_array_init_into_data(var_offset, ty, &elements)?;
            for _ in 0..array_cl_parens {
                self.accept(')')?;
            }
        } else if self.is_traversable_aggregate_ty(ty) {
            if thread_local {
                return Err(
                    self.compile_err("struct `_Thread_local` initialisers are not supported")
                );
            }
            let sid = struct_id_of(ty);
            // A parenthesized compound literal `((T){...})`
            // left grouping parens for the brace list to
            // close (C99 6.5.2.5).
            let cl_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            self.collect_struct_initializer(sid, var_offset)?;
            for _ in 0..cl_parens {
                self.accept(')')?;
            }
        } else {
            let cl_parens = core::mem::take(&mut self.pending.compound_lit_close_parens);
            self.parse_global_initializer(ty, var_offset, thread_local)?;
            for _ in 0..cl_parens {
                self.accept(')')?;
            }
        }
        self.symbols[id_idx].has_initializer = true;
        Ok(())
    }

    /// C99 6.9.2p3: a file-scope definition whose aggregate tag the unit
    /// never completes has no storage size. The declarator's own line is
    /// reported, not the end of the unit.
    fn check_incomplete_definitions(&mut self) -> Result<(), C5Error> {
        for (id_idx, sid, line) in core::mem::take(&mut self.pending_incomplete_objects) {
            if !self.structs[sid].is_complete {
                let name = self.symbols[id_idx].name.clone();
                return Err(
                    self.compile_err_at(line, format!("object `{name}` has incomplete type"))
                );
            }
        }
        Ok(())
    }

    /// Give external linkage to the names a file-scope `asm(".globl name");`
    /// declared. Applied once the unit is complete: the directive may precede
    /// the definition it names.
    fn resolve_file_scope_asm_globl(&mut self) {
        for name in core::mem::take(&mut self.pending_asm_globl) {
            for s in self.symbols.iter_mut() {
                if s.name == name && s.defined_here {
                    s.linkage = crate::c5::symbol::Linkage::External;
                }
            }
        }
    }

    /// Bind aliases whose target had not been defined when the declarator was
    /// parsed. The target must be defined in this unit: an alias to an
    /// undefined symbol has no address to share. A weak function alias is
    /// interposable, so its references never bind to the target's body:
    /// the symbol stays an external reference (the extern-import pass
    /// routes it by name) while the alias record still emits the weak
    /// definition at the target's address.
    fn resolve_pending_aliases(&mut self) -> Result<(), C5Error> {
        for (id_idx, target, is_object) in core::mem::take(&mut self.pending_aliases) {
            let want = if is_object { Token::Glo } else { Token::Fun } as i64;
            let tgt = self.resolved_alias_target(&target, want);
            let Some(tgt) = tgt else {
                let kind = if is_object { "an object" } else { "a function" };
                return Err(self.compile_err(format!(
                    "alias target `{target}` is not {kind} defined in this unit"
                )));
            };
            self.symbols[tgt].was_referenced = true;
            if !is_object && self.symbols[id_idx].is_weak {
                let name = self.symbols[id_idx].link_name().into();
                self.function_aliases
                    .push(crate::c5::program::FunctionAlias {
                        name,
                        target,
                        bind: crate::c5::program::AliasBind::Weak,
                        addend: 0,
                    });
                continue;
            }
            self.symbols[id_idx].val = self.symbols[tgt].val;
            self.symbols[id_idx].defined_here = true;
            self.symbols[id_idx].is_extern_decl = false;
            if is_object {
                Self::adopt_alias_storage(&mut self.symbols, id_idx, tgt);
            } else {
                let name = self.symbols[id_idx].link_name().into();
                let bind = alias_bind(&self.symbols[id_idx]);
                self.function_aliases
                    .push(crate::c5::program::FunctionAlias {
                        name,
                        target,
                        bind,
                        addend: 0,
                    });
            }
        }
        Ok(())
    }

    /// An object alias names its target's storage, so it takes the
    /// target's extent along with its offset -- the declarator may leave
    /// the count out (`extern T a[] __attribute__((alias("t")))`). The
    /// symbol table's size then describes the aliased object, which is
    /// what a consumer walking it needs: Linux's modpost reads a
    /// `MODULE_DEVICE_TABLE` alias' device table by `st_size`.
    fn adopt_alias_storage(symbols: &mut [crate::c5::symbol::Symbol], alias: usize, target: usize) {
        let (array_size, zero_len) = (
            symbols[target].array_size,
            symbols[target].is_zero_len_array,
        );
        symbols[alias].array_size = array_size;
        symbols[alias].is_zero_len_array = zero_len;
    }

    /// Symbol index the alias target `name` resolves to: a defined symbol
    /// of class `want`, following function-alias records so an alias whose
    /// target is itself an (unbound weak) alias reaches the chain's
    /// defined end.
    fn resolved_alias_target(&self, name: &str, want: i64) -> Option<usize> {
        let mut name = name;
        for _ in 0..=self.function_aliases.len() {
            if let Some(i) = self
                .symbols
                .iter()
                .position(|s| s.link_name() == name && s.class == want && s.defined_here)
            {
                return Some(i);
            }
            name = &self
                .function_aliases
                .iter()
                .find(|a| a.name == name)?
                .target;
        }
        None
    }

    /// Settle every function's inline linkage once the unit's last
    /// file-scope declaration has been censused.
    ///
    /// C99 6.7.4p6: when all of a function's file-scope declarations
    /// include `inline` without `extern`, the definition here is an
    /// inline definition and provides no external definition; the
    /// program's external definition, if it needs one, comes from
    /// another unit. GNU89 inverts that: `extern inline` is the
    /// inline-only form and a plain `inline` provides the external
    /// definition. `static` is internal in both and is decided first.
    ///
    /// An inline definition takes internal linkage, so it is neither
    /// exported nor a dead-code root: an unreferenced one drops, and a
    /// reference the inliner did not absorb binds to the unit-local
    /// copy rather than to an undefined symbol. C99 6.7.4p6 states that
    /// choice outright ("provides an alternative to an external
    /// definition, which a translator may use to implement any call to
    /// the function in the same translation unit"); gcc leaves an
    /// external reference instead, which it can because it inlines an
    /// `always_inline` body at every optimization level. badc's inliner
    /// runs only under `-O` and declines a body its candidate filter
    /// rejects, so the copy is what keeps those calls resolvable.
    ///
    /// That licence covers calls, not the address. The name keeps
    /// external linkage, so C99 6.2.2p2 requires `&f` to denote one
    /// function program-wide. The body is therefore emitted under
    /// `Symbol::inline_body_name`, a name no C identifier can spell, and
    /// the identifier stays an undefined external reference that every
    /// address site relocates against. A unit that only calls the
    /// function needs no such reference and links as before.
    fn resolve_inline_linkage(&mut self) {
        use crate::c5::symbol::{Linkage, inline_definition};
        let model = self.inline_model;
        for sym in self.symbols.iter_mut() {
            // Only names this unit declared at file scope; the census
            // bits are the record of that, and symbols the parser
            // synthesizes keep whatever linkage they were built with.
            let declared =
                sym.saw_noninline_decl || sym.saw_plain_inline_decl || sym.saw_extern_inline_decl;
            if sym.class != Token::Fun as i64 || sym.saw_static_decl || !declared {
                continue;
            }
            sym.is_inline_definition = inline_definition(sym, model);
            sym.linkage = if sym.is_inline_definition {
                Linkage::Internal
            } else {
                Linkage::External
            };
            // `.` cannot occur in a C identifier, so the body name
            // collides with nothing the source can declare.
            if sym.is_inline_definition && sym.defined_here {
                sym.inline_body_name = Some(alloc::format!("{}.inline", sym.link_name()));
            }
        }
    }

    /// Emit one `unused function` diagnostic per defined-here
    /// Token::Fun whose `was_referenced` flag is still false and
    /// whose `linkage` is `Internal`. C99 6.2.2: a `static`
    /// file-scope function is reachable only from the current
    /// translation unit, so an unreferenced one really is dead
    /// code. External-linkage functions cannot be flagged here --
    /// another TU may call them through the link-unit symbol
    /// table; the linker is responsible for the cross-TU
    /// reachability check. Names starting with `_` are suppressed
    /// (gcc / clang `-Wunused-function` convention). `main` is
    /// suppressed regardless of linkage: it is the program's
    /// entry, called by the runtime stub the codegen emits.
    fn warn_unused_static_functions(&mut self) {
        use crate::c5::symbol::Linkage;
        // A `__attribute__((constructor))` / `((destructor))` function
        // has no in-source call site but runs at startup / exit, so it is
        // not unused (matching gcc / clang, which never warn on it).
        let init_names: alloc::collections::BTreeSet<&str> =
            self.init_funcs.iter().map(|f| f.name.as_str()).collect();
        let mut unused: Vec<(usize, String)> = Vec::new();
        for sym in self.symbols.iter() {
            if sym.class != Token::Fun as i64
                || !sym.defined_here
                || sym.linkage != Linkage::Internal
                // An inline definition is internal but externally
                // declared; another unit may still call the name.
                || sym.is_inline_definition
                || sym.was_referenced
                || !sym.decl_in_main_source
                || sym.name.is_empty()
                || sym.name.starts_with('_')
                || sym.name == "main"
                || sym.is_used
                || init_names.contains(sym.name.as_str())
            {
                continue;
            }
            unused.push((sym.decl_line, sym.name.clone()));
        }
        for (line, name) in unused {
            self.warn_at(line, alloc::format!("unused function `{name}`"));
        }
    }

    /// Move the `weak` / `used` / `constructor` / `destructor` /
    /// `visibility` / `section("name")` attribute carriers collected for
    /// the current declarator onto its symbol. Shared by the function and
    /// file-scope-object paths; the object writers and the body-open
    /// `InitFunc` registration read the fields off the symbol, so an
    /// attribute written on a prototype reaches the later definition.
    pub(super) fn apply_symbol_attributes(&mut self, id_idx: usize) {
        if self.pending.attr_weak {
            self.symbols[id_idx].is_weak = true;
        }
        if self.pending.attr_used {
            self.symbols[id_idx].is_used = true;
        }
        // `ms_abi` / `sysv_abi`: the convention of the function this
        // symbol names, or of the function a function-pointer object
        // points to. Sticky across declarations like the rest, so a
        // prototype carrying it and a later definition without it agree
        // on one convention.
        if self.pending.attr_call_conv != crate::c5::codegen::CallConv::Target {
            self.symbols[id_idx].conv = self.pending.attr_call_conv;
        }
        if self.pending.attr_constructor {
            self.symbols[id_idx].is_constructor = true;
        }
        if self.pending.attr_destructor {
            self.symbols[id_idx].is_destructor = true;
        }
        if let Some(p) = self.pending.attr_init_priority {
            self.symbols[id_idx].init_priority = Some(p);
        }
        // Sticky like the rest: `gnu_inline` on any declaration selects
        // the GNU89 model for the name, whichever side of the declarator
        // the attribute was written on.
        if self.pending_is_gnu_inline {
            self.symbols[id_idx].is_gnu_inline = true;
        }
        // An explicit `visibility` attribute states the answer; without one
        // the enclosing `#pragma GCC visibility` extent supplies it.
        let hidden = self
            .pending
            .attr_visibility
            .unwrap_or_else(|| self.lex.visibility_hidden());
        if hidden {
            self.symbols[id_idx].is_hidden = true;
        }
        if let Some(sec) = self.pending.attr_section.take() {
            self.symbols[id_idx].section_name = Some(sec);
        }
        if let Some(area) = self.pending.attr_patchable_entry.take() {
            self.symbols[id_idx].patchable_function_entry = Some(area);
        }
        if self.pending.attr_no_instrument {
            self.symbols[id_idx].no_instrument_function = true;
        }
    }
}

/// Binding a `__attribute__((alias))` declarator's symbol takes: its own
/// linkage, `__attribute__((weak))` overriding.
fn alias_bind(sym: &crate::c5::symbol::Symbol) -> crate::c5::program::AliasBind {
    use crate::c5::program::AliasBind;
    if sym.is_weak {
        AliasBind::Weak
    } else if sym.linkage == crate::c5::symbol::Linkage::Internal {
        AliasBind::Local
    } else {
        AliasBind::Global
    }
}
