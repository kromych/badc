//! Local-declaration handlers for function bodies.
//!
//! Four related methods cluster here, all dealing with the
//! "reserve frame storage + emit any initializer" responsibilities
//! of a local declaration line at function-body scope:
//!
//!   * `parse_function_body_local_decl` -- parse one declaration
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
use super::types::{is_pointer_ty, is_struct_ty, struct_id_of, struct_ptr_depth};

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
        } else if let Some((src, size)) = aggregate {
            super::super::ast::LocalInit::Aggregate {
                src_data_off: src,
                size_bytes: size,
            }
        } else {
            super::super::ast::LocalInit::None
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
        Option<(i64, i64)>,
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
            Option<(i64, i64)>,
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

    /// Parse the GCC declarator suffix `asm("reg")` on a block-scope
    /// declaration and resolve the register name for the current
    /// target. Only the `register`-class automatic form is modelled;
    /// GCC's other use of the suffix (a linkage-name rename) is TODO.
    /// The named register must be one the inline-asm operand pool can
    /// carry: x86-64 GPRs minus rsp / rbp / r10 / r11 (emit scratch),
    /// AArch64 x0..x15 (x16 / x17 are emit scratch).
    fn parse_register_asm_suffix(
        &mut self,
        is_register: bool,
        is_static: bool,
        is_extern: bool,
    ) -> Result<u8, C5Error> {
        self.next()?; // consume `asm`
        self.consume(b'(', "`(` expected after declarator `asm`")?;
        if self.lex.tk != '"' {
            return Err(self.compile_err("declarator `asm`: register name string expected"));
        }
        let nstart = self.lex.ival as usize;
        self.next()?; // consume the string
        let name_bytes: alloc::vec::Vec<u8> = self.data[nstart..].to_vec();
        self.data.truncate(nstart);
        self.consume(b')', "`)` expected after declarator `asm(\"...\")`")?;
        if !is_register || is_static || is_extern {
            return Err(self.compile_err("declarator `asm` is only supported on `register` locals"));
        }
        let name = core::str::from_utf8(&name_bytes).unwrap_or("");
        let name = name.trim_start_matches('%');
        let reg = if self.target.is_aarch64() {
            match super::super::codegen::aarch64::asm::clobber_reg_name(name) {
                Some((false, num)) if num < 16 => Some(num),
                _ => None,
            }
        } else {
            match super::super::codegen::x86_64::asm::reg_by_name(name) {
                Some((num, _)) if num < 16 && !matches!(num, 4 | 5 | 10 | 11) => Some(num),
                _ => None,
            }
        };
        match reg {
            Some(r) => Ok(r),
            None => Err(self.compile_err(alloc::format!(
                "declarator `asm`: `{name}` is not a supported register for this target"
            ))),
        }
    }

    pub(super) fn parse_function_body_local_decl(
        &mut self,
        maybe_unused: bool,
    ) -> Result<(), C5Error> {
        let mut is_static = false;
        let mut is_extern = false;
        // Block-scope `_Thread_local` / `__thread` gives a `static` object
        // thread storage duration (C11 6.7.1).
        let mut is_thread_local = false;
        // `register` storage class: gates the `asm("reg")` declarator
        // suffix (GCC register-asm variables).
        let mut is_register = false;
        let mut saw_specifier = false;
        let mut qual_bits: i64 = 0;
        // Reset the const carrier for this declaration; the leading
        // qualifier loop here consumes `const` (a TypeQual) before the
        // base-type parse, so record it as we go.
        self.pending.base_is_const = false;
        while self.lex.tk == Token::Extern
            || self.lex.tk == Token::Static
            || self.lex.tk == Token::ThreadLocal
            || self.lex.tk == Token::FuncSpec
            || self.lex.tk == Token::TypeQual
        {
            if self.lex.tk == Token::Static {
                is_static = true;
            }
            if self.lex.tk == Token::Extern {
                is_extern = true;
            }
            if self.lex.tk == Token::ThreadLocal {
                is_thread_local = true;
            }
            if self.lex.tk == Token::FuncSpec
                && self.symbols[self.lex.curr_id_idx].name == "register"
            {
                is_register = true;
            }
            // `volatile` qualifies the declared type (C99 6.7.3); `const`
            // is recorded out-of-band for value folding.
            qual_bits |= self.lex_volatile_bit();
            self.pending.base_is_const |= self.lex_is_const_qual();
            saw_specifier = true;
            self.next()?;
        }
        // A block-scope thread-local has static storage duration.
        if is_thread_local && !is_extern {
            is_static = true;
        }
        // C89 / K&R implicit int (`register n = ...;`): a declaration
        // that carries a storage-class or qualifier but no type names an
        // int object. Only applies after an explicit specifier so a
        // mistyped type name still surfaces as an error.
        let base = if !self.lex_is_type_start() && saw_specifier {
            Ty::Int as i64
        } else {
            self.parse_decl_base_type()?
        };
        // C99 6.7.1: a storage-class or qualifier specifier may trail the
        // type specifier (`INTN STATIC x;`, `int const y;`). Consume any that
        // follow the base type; the leading run handles the usual order.
        while self.lex.tk == Token::Extern
            || self.lex.tk == Token::Static
            || self.lex.tk == Token::ThreadLocal
            || self.lex.tk == Token::FuncSpec
            || self.lex.tk == Token::TypeQual
        {
            if self.lex.tk == Token::Static {
                is_static = true;
            }
            if self.lex.tk == Token::Extern {
                is_extern = true;
            }
            if self.lex.tk == Token::ThreadLocal {
                is_thread_local = true;
            }
            if self.lex.tk == Token::FuncSpec
                && self.symbols[self.lex.curr_id_idx].name == "register"
            {
                is_register = true;
            }
            qual_bits |= self.lex_volatile_bit();
            self.pending.base_is_const |= self.lex_is_const_qual();
            self.next()?;
        }
        if is_thread_local && !is_extern {
            is_static = true;
        }
        let lbt = base | qual_bits;
        // A function-pointer typedef base type contributes its lineage to
        // every declarator in the list (`fn_t a, b;` makes both a and b
        // function pointers). The per-declarator symbol creation consumes
        // these pending fields, so capture them and re-seed each iteration;
        // otherwise only the first declarator keeps the lineage and a call
        // through a later one defaults its result type to int.
        let base_fn_ptr_indirection = self.pending.fn_ptr_indirection;
        let base_is_function_type = self.pending.base_is_function_type;
        let base_typedef_fn_proto = self.pending.typedef_fn_proto;
        let base_fn_ptr_param_types = self.pending.fn_ptr_param_types.clone();
        // C99 6.7p1 / 6.2.2p5: a block-scope `[*]name(params);` is a
        // function declaration with external (internal if `static`)
        // linkage; bind it and let the call resolve at link time.
        if self.try_parse_block_fn_prototype(lbt, is_static)? {
            return Ok(());
        }
        // `__attribute__((cleanup(fn)))` leading the declaration applies to
        // every declarator (the scope-guard / auto-cleanup idiom).
        let leading_cleanup = self.pending.attr_cleanup.take();
        while self.lex.tk != ';' {
            // Re-seed the base type's function-pointer lineage for this
            // declarator; the previous declarator's symbol creation took it.
            self.pending.fn_ptr_indirection = base_fn_ptr_indirection;
            self.pending.base_is_function_type = base_is_function_type;
            self.pending.typedef_fn_proto = base_typedef_fn_proto;
            self.pending.fn_ptr_param_types = base_fn_ptr_param_types.clone();
            // C99 6.7.6.2: a non-constant array dimension at block scope
            // is a variable-length array.
            self.pending.vla_allowed = true;
            let (loc_idx, ty, mut array_size) = self.parse_declarator(lbt)?;
            self.pending.vla_allowed = false;
            // GCC declarator suffix `asm("reg")`: a register-asm
            // variable. Only the register-class local form is
            // modelled (the binding is honored for `r`-class asm
            // operands); the rename form on other declarators is
            // TODO.
            let asm_reg = if self.lex.tk == Token::Asm {
                Some(self.parse_register_asm_suffix(is_register, is_static, is_extern)?)
            } else {
                None
            };
            // Trailing cleanup wins for this declarator; else the leading one.
            let cleanup_fn = self.pending.attr_cleanup.take().or(leading_cleanup);
            // C23 6.7.13.5 `[[maybe_unused]]` / GNU
            // `__attribute__((unused))` on the declaration suppresses
            // the unused-variable diagnostic for the names it declares.
            if maybe_unused && loc_idx != usize::MAX {
                self.symbols[loc_idx].maybe_unused = true;
            }
            // Function-pointer lineage carries through to local
            // bindings -- pick up the side-channel parse_declarator
            // (or the typedef base type) populated. Used by the
            // unary `*` handler to recognise function-pointer
            // decay (C99 6.3.2.1p4) as a no-op rather than a
            // through-pointer load.
            let fn_ptr_indirection = self.pending.fn_ptr_indirection.take().unwrap_or(0);
            // Capture the function-pointer prototype before the initializer
            // is parsed: an initializer cast (`= (void *)f`) runs a base-type
            // parse that clears these pending fields, so reading them after
            // `allocate_local_with_init` would lose a variadic fn-pointer's
            // prototype and emit the indirect call as non-variadic.
            let fnptr_proto = self.pending.typedef_fn_proto.take();
            let fnptr_param_types = self.pending.fn_ptr_param_types.take();
            // Array typedef carries its dimension when the
            // declarator stayed at the typedef's element type --
            // i.e., no `[N]` brackets and no leading `*`. A
            // declarator that added a pointer level (`T *p` where
            // `T` is an array typedef) names a pointer to the
            // typedef's element type; the array dimension is part
            // of the pointee and must not be re-applied to the
            // declarator (C99 6.7.7p3 + 6.7.6.1). Peek the
            // carrier without clearing so every declarator in the
            // comma list sees the same dimension; the outer
            // parse_block / decl-loop resets it on the next
            // declaration.
            let typedef_dim = self.pending.typedef_base_array_size;
            if typedef_dim > 0 && array_size == 0 && self.pending.declarator_leading_ptr_count == 0
            {
                array_size = typedef_dim;
                self.apply_typedef_array_dims(loc_idx);
            }
            self.ty = ty;
            // C99 6.2.2p4: a block-scope `extern` declaration of an
            // object has external linkage and refers to the file-scope
            // object of the same name; it allocates no local storage and
            // does not shadow the outer binding. Leave an existing
            // file-scope (Glo) or function binding intact; otherwise
            // record an undefined external reference the linker resolves.
            if is_extern {
                if self.symbols[loc_idx].class != Token::Glo as i64
                    && self.symbols[loc_idx].class != Token::Fun as i64
                {
                    self.symbols[loc_idx].class = Token::Glo as i64;
                    self.symbols[loc_idx].type_ = ty;
                    // `extern T name[N];` names an array; record its dimension
                    // so a subscript decays it to a pointer (6.7.6.2) rather
                    // than seeing a scalar. The declarator parse has already
                    // set `inner_array_size` for a multi-dimensional extern.
                    self.symbols[loc_idx].array_size = array_size.max(0);
                    self.symbols[loc_idx].is_extern_decl = true;
                    // External linkage is what routes `&name` through
                    // `live_glo_addr`'s `GloAddr::Extern` arm to a
                    // name-keyed `extern_imm_data_refs` relocation. Without
                    // it the address producer falls back to the tentative
                    // `val` (0 for an object defined in another unit), so
                    // every block-scope extern collapses to the same
                    // `.data` base address.
                    self.symbols[loc_idx].linkage = crate::c5::symbol::Linkage::External;
                }
                if self.lex.tk == ',' {
                    self.next()?;
                    continue;
                }
                break;
            }
            if self.symbols[loc_idx].class == Token::Loc as i64 {
                return Err(self.compile_err("duplicate local definition"));
            }

            self.shadow_symbol(loc_idx);

            // C11 6.7.5 on block-scope objects: a static local's `.data`
            // slot honors the requested alignment like a file-scope object;
            // an automatic object lives in 8-byte frame slots (no stack
            // realignment), so a larger request there is a diagnostic. The
            // attribute requires a power of two.
            let req_align = core::mem::take(&mut self.pending.attr_align);
            if req_align > 8 && !(req_align as usize).is_power_of_two() {
                return Err(self.compile_err(format!(
                    "requested alignment {req_align} is not a power of two"
                )));
            }
            // An over-alignment attribute in the type-specifier position
            // (`struct {...} __attribute__((aligned(16))) *p`) raises the
            // pointee type's alignment; a pointer object holds its own
            // pointer-aligned value, so the request does not apply to it.
            let obj_is_pointer = is_pointer_ty(ty);
            if (req_align > 8 && !is_static && !obj_is_pointer)
                || req_align > super::MAX_STATIC_ALIGN as i64
            {
                return Err(self.compile_err(format!(
                    "requested alignment {req_align} is not supported here \
                     (automatic objects align to 8, static objects to at most {})",
                    super::MAX_STATIC_ALIGN
                )));
            }

            if is_static {
                self.symbols[loc_idx].class = Token::Glo as i64;
                self.symbols[loc_idx].type_ = ty;
                self.symbols[loc_idx].is_thread_local = is_thread_local;
                // Block scope with static storage (C99 6.2.4p3): the
                // symbol carries `Glo` class for its `.data` slot but
                // must be unbound at function exit so a file-scope
                // object of the same name reappears. The `Loc`-gated
                // cleanup would skip it, so mark it for restore.
                self.symbols[loc_idx].is_scope_static = true;
                // A block-scope `static const` integer folds its value in
                // later constant expressions (read from `.data`), so
                // `char buf[N * 2 + 1]` is a fixed array, not a VLA.
                self.symbols[loc_idx].is_const_qualified = self.pending.base_is_const
                    && array_size == 0
                    && super::types::is_integer_scalar_ty(ty);
                if req_align > 8 {
                    self.align_data_to(req_align as usize);
                    self.data_align = self.data_align.max(req_align as usize);
                }
                self.allocate_static_local(loc_idx, ty, array_size)?;
                self.ast_emit_static_local_decl(loc_idx as u32);
            } else {
                self.symbols[loc_idx].class = Token::Loc as i64;
                self.symbols[loc_idx].type_ = ty;
                self.symbols[loc_idx].asm_reg = asm_reg;
                self.symbols[loc_idx].was_referenced = false;
                self.symbols[loc_idx].decl_line = self.lex.line;
                let decl_file = self.intern_source_file() as u32;
                self.symbols[loc_idx].decl_file = decl_file;
                self.symbols[loc_idx].decl_in_main_source = self.in_main_source();
                self.pending_local_init_ast = None;
                self.pending_local_aggregate_ast = None;
                self.pending_local_runtime_elements.clear();
                self.allocate_local_with_init(loc_idx, ty, array_size)?;
                // Dual-emit: push `Decl::Local { sym, slot_off,
                // init }`. The init flavour comes from whichever
                // cross-helper carry the inner allocator filled:
                // * scalar carry  -> `LocalInit::Scalar(ExprId)`
                // * aggregate     -> `LocalInit::Aggregate`     (Mcpy)
                // * runtime elems -> `LocalInit::Runtime`       (per-element stores,
                //                                                 plus the optional
                //                                                 Mcpy-zero prelude
                //                                                 from `aggregate`)
                // Static locals (promoted to Glo class) skip --
                // their storage is laid out in .data at TU-load
                // time, not in the function's frame.
                self.finalize_local_init(loc_idx);
            }
            // A deferred-size local (`T x[]`, `array_size == -1`) whose
            // initializer resolved to zero elements is a zero-length array:
            // keep the array-ness the `array_size == 0` scalar encoding
            // would drop, so it still decays to a pointer and `sizeof` is 0.
            // Assigned (not just set) so a reused symbol slot does not leak
            // a stale flag from an outer binding of the same name.
            self.symbols[loc_idx].is_zero_len_array =
                array_size == -1 && self.symbols[loc_idx].array_size == 0;
            // Unconditional write: a stale fn-ptr lineage from a
            // prior binding of this name must not leak into a
            // plain scalar/pointer rebind, or the unary `*` handler
            // mistakes a `*p = ...` for a fn-ptr decay no-op (the
            // `shadow_symbol` saved the prior value into
            // `h_fn_ptr_indirection`, so block-exit will restore it).
            self.symbols[loc_idx].fn_ptr_indirection = fn_ptr_indirection;
            // Inherit a variadic function-pointer prototype onto the
            // local so an indirect call through it knows the callee's
            // named-parameter count and routes the variadic tail per
            // the host variadic ABI. Only variadic prototypes are
            // recorded: a non-variadic indirect call places every
            // argument as fixed regardless, and synthesising
            // placeholder parameter types would feed the call-site
            // argument type-check a spurious mismatch.
            if let Some(types) = fnptr_param_types {
                self.symbols[loc_idx].params = types;
                self.symbols[loc_idx].is_variadic = matches!(fnptr_proto, Some((_, true)));
            } else if let Some((proto_fixed, true)) = fnptr_proto {
                self.symbols[loc_idx].params = alloc::vec![0i64; proto_fixed];
                self.symbols[loc_idx].is_variadic = true;
            }

            // Register `__attribute__((cleanup))` after the binding is
            // final (the automatic branch reset `was_referenced`). It
            // requires automatic storage (C has no such feature; the
            // GCC/Clang extension), so a static / extern declarator's
            // cleanup is inert.
            if let Some(fn_sym) = cleanup_fn
                && !is_static
                && !is_extern
            {
                self.register_cleanup_var(loc_idx, fn_sym);
            }

            self.accept(',')?;
        }
        self.next()?;
        Ok(())
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
    pub(super) fn allocate_static_local(
        &mut self,
        loc_idx: usize,
        ty: i64,
        array_size: i64,
    ) -> Result<(), C5Error> {
        // Storage. Mirrors run_compile's file-scope allocator.
        let bytes = if array_size > 0 {
            let total = (self.size_of_type(ty) as i64) * array_size;
            ((total + 7) / 8) * 8
        } else if array_size == -1 {
            // Deferred-size array: handled below after parsing init.
            0
        } else {
            self.slots_of_type(ty) * 8
        };
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
            // A `&&label` element (GCC labels as values) is a block address
            // known only once the function is emitted, so a static array
            // carrying one is left zero in the data image and filled by
            // runtime stores at the declaration point.
            if self.lex.tk == '{' && self.array_init_has_label_addr()? {
                return self.emit_static_array_init_runtime(loc_idx, ty, array_size);
            }
            if array_size == -1 {
                if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
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
                        self.designated_array_count(groups as i64)?
                    } else {
                        let items = self.lex.count_top_level_items_in_array();
                        let slots = self.struct_flat_init_slots(sid).max(1);
                        items.div_ceil(slots) as i64
                    };
                    self.next()?;
                    self.align_data_to_8();
                    let off = self.data.len() as i64;
                    self.symbols[loc_idx].val = off;
                    for _ in 0..(count * inner_dim * elem_size as i64) {
                        self.data.push(0);
                    }
                    // 2D struct array: each top-level brace is a row of
                    // `inner_dim` fully-braced structs; the 1D loop below would
                    // misread a row as one struct.
                    if inner_dim > 1 {
                        let mut row: i64 = 0;
                        while self.lex.tk != '}' {
                            if self.lex.tk != '{' {
                                return Err(self.compile_err(
                                    "row of a 2D struct array must be brace-enclosed",
                                ));
                            }
                            self.next()?; // row `{`
                            let mut j: i64 = 0;
                            while self.lex.tk != '}' {
                                if j >= inner_dim {
                                    return Err(self
                                        .compile_err("too many initializers in struct-array row"));
                                }
                                let here = off + (row * inner_dim + j) * elem_size as i64;
                                if self.lex.tk == '{' {
                                    self.collect_struct_initializer(sid, here)?;
                                } else {
                                    self.fill_struct_fields(sid, here, false)?;
                                }
                                j += 1;
                                self.accept(',')?;
                            }
                            self.next()?; // row `}`
                            row += 1;
                            self.accept(',')?;
                        }
                        self.next()?; // outer `}`
                        self.symbols[loc_idx].array_size = count * inner_dim;
                        if let Some(first) = self.symbols[loc_idx].array_dims.first_mut()
                            && *first == 0
                        {
                            *first = count;
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
                        if self.lex.tk == '{' {
                            self.collect_struct_initializer(sid, here)?;
                        } else {
                            self.fill_struct_fields(sid, here, false)?;
                        }
                        i += 1;
                        self.accept(',')?;
                    }
                    self.next()?;
                    self.symbols[loc_idx].array_size = count;
                    while !self.data.len().is_multiple_of(8) {
                        self.data.push(0);
                    }
                    return Ok(());
                }
                self.pending.init_inner_dims = self.inner_dims_of(loc_idx);
                let elements = self.collect_array_initializer(ty)?;
                let final_size = elements.len() as i64;
                self.symbols[loc_idx].array_size = final_size;
                let total_bytes = (self.size_of_type(ty) as i64) * final_size;
                let aligned = ((total_bytes + 7) / 8) * 8;
                if self.size_of_type(ty) > 1 {
                    self.align_data_to_8();
                }
                let off = self.data.len() as i64;
                self.symbols[loc_idx].val = off;
                for _ in 0..aligned {
                    self.data.push(0);
                }
                self.write_array_init_into_data(off, ty, &elements);
            } else if array_size > 0 && is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                // Known-size static-local array of structs. Each element
                // is a (possibly brace-elided, C99 6.7.8p20) struct
                // initializer; the generic array collector below would
                // treat the struct element as a scalar and write past the
                // pre-allocated region.
                let sid = struct_id_of(ty);
                let elem_size = self.size_of_type(ty);
                let var_offset = self.symbols[loc_idx].val;
                // A multi-dimensional array's element is itself an array of
                // structs; each top-level group spans the inner dimensions.
                let inner_dims = self.inner_dims_of(loc_idx);
                let inner_product: i64 = inner_dims.iter().product::<i64>().max(1);
                let group_stride = elem_size as i64 * inner_product;
                let group_count = array_size / inner_product;
                if self.lex.tk != '{' {
                    return Err(self.compile_err("array initializer must start with `{{`"));
                }
                self.next()?;
                let mut i: i64 = 0;
                while self.lex.tk != '}' {
                    // C99 6.7.8p6/p7 array designator. A single `[N] =`
                    // jumps the outer cursor and fills a whole row; a
                    // multi-dimensional `[i][j]... = { ... }` indexes every
                    // dimension down to a single struct element.
                    if self.lex.tk == Token::Brak {
                        self.next()?; // `[`
                        let desig = self.parse_constant_int()?;
                        // GNU range designator `[lo ... hi]`.
                        let mut desig_hi = desig;
                        if self.lex.tk == Token::Ellipsis {
                            self.next()?;
                            desig_hi = self.parse_constant_int()?;
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
                            // Multi-dimensional element designator: each inner
                            // subscript scales by the product of the dimensions
                            // below it; the outer `desig` scales by the whole
                            // inner product.
                            let mut elem = desig * inner_product;
                            let mut d = 0usize;
                            while self.lex.tk == Token::Brak {
                                self.next()?; // `[`
                                let n = self.parse_constant_int()?;
                                if self.lex.tk != ']' {
                                    return Err(self
                                        .compile_err("`]` expected after array designator index"));
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
                                let here = var_offset + elem * elem_size as i64;
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
                            let here = var_offset + elem * elem_size as i64;
                            if self.lex.tk == '{' {
                                self.collect_struct_initializer(sid, here)?;
                            } else {
                                self.fill_struct_fields(sid, here, false)?;
                            }
                            i = desig + 1;
                            self.accept(',')?;
                            continue;
                        }
                        // C99 6.7.8p7 member chain on the designated
                        // element(s) (`[N].field... = v`; 1-D elements only,
                        // a row of a multi-dimensional array is not a
                        // struct object).
                        if self.lex.tk == Token::Dot && inner_dims.is_empty() {
                            self.fill_element_range(
                                sid,
                                ty,
                                var_offset,
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
                                var_offset,
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
                            "too many initializers for `{}`",
                            self.symbols[loc_idx].name
                        )));
                    }
                    let here = var_offset + i * group_stride;
                    if !inner_dims.is_empty() {
                        self.collect_struct_array_data(sid, here, &inner_dims, elem_size as i64)?;
                    } else if self.lex.tk == '{' {
                        self.collect_struct_initializer(sid, here)?;
                    } else {
                        self.fill_struct_fields(sid, here, false)?;
                    }
                    i += 1;
                    self.accept(',')?;
                }
                self.next()?; // consume `}`
            } else if array_size > 0 {
                self.pending.init_inner_dims = self.inner_dims_of(loc_idx);
                self.pending.init_target_array_size = array_size;
                let elements = self.collect_array_initializer(ty)?;
                let var_offset = self.symbols[loc_idx].val;
                self.write_array_init_into_data(var_offset, ty, &elements);
            } else if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                let sid = struct_id_of(ty);
                let var_offset = self.symbols[loc_idx].val;
                self.collect_struct_initializer(sid, var_offset)?;
            } else {
                let var_offset = self.symbols[loc_idx].val;
                self.parse_global_initializer(ty, var_offset, false)?;
            }
        }

        Ok(())
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
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '{' {
                depth += 1;
            } else if self.lex.tk == '}' {
                depth -= 1;
            } else if self.lex.tk == Token::Lan {
                found = true;
                break;
            }
            self.next()?;
        }
        self.lex.restore(snap);
        self.data.truncate(data_snap);
        Ok(found)
    }

    /// Fill a static-local array whose initializer contains a `&&label`
    /// element with runtime stores at the declaration point. The data
    /// image holds zeros; each element is parsed through the expression
    /// grammar (so `&&label` yields a block-address node) and stored into
    /// `arr[i]` via an `Expr::Assign` the walker lowers to a global
    /// address store. A constant element is stored the same way.
    ///
    /// C99 6.2.4p3: static storage duration means one initialization for
    /// the whole program run, so the stores are wrapped in a hidden
    /// once-guard: a guard byte placed directly after the array's storage
    /// (same data object -- no object start in between -- so data DCE and
    /// linker rebase move it with the array). The whole declaration
    /// lowers to a single statement `guard ? 0 : (e0, ..., en, guard = 1)`
    /// because the enclosing declaration parse captures every pushed
    /// stmt id as a top-level block item.
    /// TODO: the generic fix resolves `&&label` elements in the data
    /// image via label relocations, removing the runtime stores.
    pub(super) fn emit_static_array_init_runtime(
        &mut self,
        loc_idx: usize,
        ty: i64,
        array_size: i64,
    ) -> Result<(), C5Error> {
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
                let a = self.parse_constant_int()?;
                if a < 0 {
                    return Err(self.compile_err(format!(
                        "array designator index must be non-negative (got {a})"
                    )));
                }
                let mut b = a;
                if self.lex.tk == Token::Ellipsis {
                    self.next()?;
                    b = self.parse_constant_int()?;
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
        let idx = self.parse_constant_int()?;
        let mut hi = idx;
        if self.lex.tk == Token::Ellipsis {
            self.next()?;
            hi = self.parse_constant_int()?;
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
            } else if self.lex.tk == '{' {
                self.collect_struct_initializer(sid, here)?;
            } else {
                self.fill_struct_fields(sid, here, false)?;
            }
            if e < hi {
                self.lex.restore(snap);
            }
        }
        Ok(())
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
                // GCC zero-length array `T x[0]`: the declarator folds `[0]`
                // to the -1 sentinel (it otherwise behaves like a flexible
                // array member). As a local with no initializer this is a
                // valid empty array, used by compile-time-assert idioms such
                // as `char offset_must_be_zero[-offsetof(type, f)]` --
                // a first member gives `[0]` (accepted here), a non-first
                // member a negative dimension the declarator already rejects.
                // Reserve a minimal slot; the array holds no elements and is
                // normally unused.
                self.symbols[loc_idx].array_size = 1;
                self.symbols[loc_idx].val = self.reserve_slots(self.local_storage_slots(ty, 1));
                return Ok(());
            }
            self.next()?;
            // Deferred-size local array of structs: `struct T xs[] = { {...}, ... };`.
            // Stage each element in self.data, count them, then
            // reserve one stack frame slot block and Mcpy the
            // staged bytes into it.
            if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 && self.lex.tk == '{' {
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
                    self.designated_array_count(groups as i64)?
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
                if self.struct_init_needs_runtime()? {
                    self.symbols[loc_idx].array_size = count;
                    self.symbols[loc_idx].val =
                        self.reserve_slots(self.local_storage_slots(ty, count));
                    let local_val = self.symbols[loc_idx].val;
                    let var_name = self.symbols[loc_idx].name.clone();
                    // Zero the whole slot (6.7.8p19 omitted-entries rule),
                    // then overlay each element's explicit fields.
                    let zero_off = self.data.len();
                    for _ in 0..(count as usize * elem_size) {
                        self.data.push(0);
                    }
                    self.emit_local_array_init(local_val, zero_off, count as usize * elem_size);
                    self.next()?; // consume outer `{`
                    let mut i: i64 = 0;
                    while self.lex.tk != '}' {
                        // C99 6.7.8p7 `[N] =` designator jumps the cursor.
                        // TODO: member chains (`[N].field =`) and ranges
                        // with runtime element values route through
                        // per-field stores.
                        if let Some((idx, hi, chain)) = self.take_array_element_designator(count)? {
                            if chain || hi > idx {
                                return Err(self.compile_err(
                                    "`[N].field` / range designator requires constant \
                                     element values",
                                ));
                            }
                            i = idx;
                        }
                        if i >= count {
                            return Err(self.compile_err(format!(
                                "too many initializers for array `{}` ({} > {})",
                                var_name,
                                i + 1,
                                count
                            )));
                        }
                        // C99 6.7.8p20: an element's braces may be elided;
                        // the runtime path fills the struct's fields from
                        // the flat list.
                        let braced = self.lex.tk == '{';
                        self.emit_struct_runtime_at(local_val, i * elem_size as i64, sid, braced)?;
                        i += 1;
                        self.accept(',')?;
                    }
                    self.next()?; // consume outer `}`
                    return Ok(());
                }
                let staged_off = self.data.len();
                self.next()?;
                for _ in 0..(count * elem_size as i64) {
                    self.data.push(0);
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
                                staged_off as i64,
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
                    let here = staged_off as i64 + i * elem_size as i64;
                    if self.lex.tk == '{' {
                        self.collect_struct_initializer(sid, here)?;
                    } else {
                        self.fill_struct_fields(sid, here, false)?;
                    }
                    i += 1;
                    self.accept(',')?;
                }
                self.next()?;
                self.symbols[loc_idx].array_size = count;
                self.symbols[loc_idx].val = self.reserve_slots(self.local_storage_slots(ty, count));
                let local_val = self.symbols[loc_idx].val;
                self.emit_local_array_init(local_val, staged_off, elem_size * count as usize);
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
                let (final_size, needs_runtime) = self.scan_array_init()?;
                if needs_runtime {
                    self.symbols[loc_idx].array_size = final_size;
                    self.symbols[loc_idx].val =
                        self.reserve_slots(self.local_storage_slots(ty, final_size));
                    let local_val = self.symbols[loc_idx].val;
                    let var_name = self.symbols[loc_idx].name.clone();
                    let inner = self.inner_dims_of(loc_idx);
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
            let (start_addr, total_bytes) = self.pack_initializer_into_data(ty, &elements);
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
                if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 && self.lex.tk == '{' {
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
                        self.next()?; // consume outer `{`
                        let mut i: i64 = 0;
                        while self.lex.tk != '}' {
                            // C99 6.7.8p7 `[N] =` designator jumps the cursor.
                            // TODO: member chains (`[N].field =`) and ranges
                            // with runtime element values route through
                            // per-field stores.
                            if let Some((idx, hi, chain)) =
                                self.take_array_element_designator(declared_array_size)?
                            {
                                if chain || hi > idx {
                                    return Err(self.compile_err(
                                        "`[N].field` / range designator requires constant \
                                         element values",
                                    ));
                                }
                                i = idx;
                            }
                            if i >= declared_array_size {
                                return Err(self.compile_err(format!(
                                    "too many initializers for array `{}` ({} > {})",
                                    var_name,
                                    i + 1,
                                    declared_array_size
                                )));
                            }
                            // C99 6.7.8p20: an element's braces may be
                            // elided; the runtime path fills the struct's
                            // fields from the flat list.
                            let braced = self.lex.tk == '{';
                            self.emit_struct_runtime_at(
                                local_val,
                                i * elem_size as i64,
                                sid,
                                braced,
                            )?;
                            i += 1;
                            self.accept(',')?;
                        }
                        self.next()?; // consume outer `}`
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
                            let desig = self.parse_constant_int()?;
                            // GNU range designator `[lo ... hi]`.
                            let mut desig_hi = desig;
                            if self.lex.tk == Token::Ellipsis {
                                self.next()?;
                                desig_hi = self.parse_constant_int()?;
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
                                    let n = self.parse_constant_int()?;
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
                                if self.lex.tk == '{' {
                                    self.collect_struct_initializer(sid, here)?;
                                } else {
                                    self.fill_struct_fields(sid, here, false)?;
                                }
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
                            self.collect_struct_array_data(
                                sid,
                                here,
                                &inner_dims,
                                elem_size as i64,
                            )?;
                        } else if self.lex.tk == '{' {
                            self.collect_struct_initializer(sid, here)?;
                        } else {
                            self.fill_struct_fields(sid, here, false)?;
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
                let (start_addr, packed_bytes) = self.pack_initializer_into_data(ty, &elements);
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
            } else if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 && self.lex.tk == '{' {
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
    /// element / scalar / struct type; `is_array` / `decl_array_size`
    /// describe an array declarator, with `decl_array_size == -1`
    /// for the size-from-initializer `[]` form). The lexer is at the
    /// opening `{`. Reserves an anonymous frame slot (automatic
    /// storage, 6.5.2.5p5), captures the initializer through the
    /// shared local-init helpers, and emits an `Expr::CompoundLiteral`
    /// whose value is the object's address (array decays per 6.3.2.1p3,
    /// struct yields its address) or the loaded scalar.
    pub(super) fn parse_block_compound_literal(
        &mut self,
        t: i64,
        is_array: bool,
        decl_array_size: i64,
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

        if is_array {
            let elem_ty = t;
            let elem_size = self.size_of_type(elem_ty);
            if decl_array_size == -1 {
                if self.lex.tk != '{' {
                    return Err(self.compile_err("`{` expected in compound literal"));
                }
                let (count, needs_runtime) = self.scan_array_init()?;
                slot = self.reserve_slots(self.local_storage_slots(elem_ty, count));
                if needs_runtime {
                    let full = elem_size * count as usize;
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
                        &[],
                        "<compound literal>",
                    )?;
                } else {
                    let elements = self.collect_array_initializer(elem_ty)?;
                    let (start, bytes) = self.pack_initializer_into_data(elem_ty, &elements);
                    self.emit_local_array_init(slot, start, bytes);
                }
                final_array_size = count;
            } else {
                let count = decl_array_size;
                let full = elem_size * count as usize;
                slot = self.reserve_slots(self.local_storage_slots(elem_ty, count));
                if self.lex.tk == '{' && self.array_init_needs_runtime()? {
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
                        &[],
                        "<compound literal>",
                    )?;
                } else {
                    self.pending.init_target_array_size = count;
                    let elements = self.collect_array_initializer(elem_ty)?;
                    if elements.len() as i64 > count {
                        return Err(self.compile_err(format!(
                            "too many initializers for compound literal ({} > {count})",
                            elements.len()
                        )));
                    }
                    let (start, packed) = self.pack_initializer_into_data(elem_ty, &elements);
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
                final_array_size = count;
            }
            // C99 6.3.2.1p3: an array compound literal used as a
            // value decays to a pointer to its first element.
            value_ty = elem_ty + Ty::Ptr as i64;
        } else if is_struct_ty(t) && struct_ptr_depth(t) == 0 {
            let sid = struct_id_of(t);
            let elem_size = self.size_of_type(t);
            let cl_slots = self.slots_of_type(t);
            slot = self.reserve_slots(cl_slots);
            if cl_slots > 1 {
                self.multi_cell_temps.push((slot, cl_slots));
            }
            let needs_runtime = self.struct_init_needs_runtime()?;
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
        if s.class != Token::Glo as i64 || s.array_size > 0 {
            return false;
        }
        !(is_struct_ty(s.type_) && struct_ptr_depth(s.type_) == 0)
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
        // Whether the previously scanned token was a unary/binary `&`;
        // a global read in `&global` is a constant address.
        let mut prev_was_amp = false;
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
                self.next()?;
                continue;
            } else if self.lex.tk == Token::Id {
                saw_any = true;
                let class = self.symbols[self.lex.curr_id_idx].class;
                if class == Token::Loc as i64 {
                    needs_runtime = true;
                }
                if !prev_was_amp && self.glo_value_read_is_runtime(self.lex.curr_id_idx) {
                    needs_runtime = true;
                }
                if self.lex.peek_after_whitespace(b'[') || self.lex.peek_after_whitespace(b'(') {
                    needs_runtime = true;
                }
            } else if self.lex.tk == Token::Dot || self.lex.tk == Token::Arrow {
                needs_runtime = true;
                saw_any = true;
            } else if self.lex.tk == Token::Lan {
                // `&&label` (GCC labels as values): the block address is
                // not known until the function is emitted, so the element
                // is filled by a runtime store rather than a constant.
                needs_runtime = true;
                saw_any = true;
            } else {
                saw_any = true;
            }
            prev_was_amp = self.lex.tk == Token::AndOp;
            self.next()?;
        }
        self.lex.restore(snap);
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
    /// literals, address-of-global (`&id`), enum / `#define`
    /// constants (class == Num), bare globals / functions /
    /// syscall stubs (class == Glo / Fun / Sys), and any cast or
    /// paren expression composed of the same. Non-constants:
    /// references to Loc-class symbols (parameters or locals),
    /// indexed reads (`id[...]`), member access (`.` / `->`),
    /// and function calls (`id(args)`).
    pub(super) fn array_init_needs_runtime(&mut self) -> Result<bool, C5Error> {
        Ok(self.scan_array_init()?.1)
    }

    /// Emit per-element store sequences for a local-array
    /// initializer whose elements aren't all compile-time
    /// constants. C99 6.7.8 paragraph 13 specifies that each
    /// element is initialised as if by assignment in declaration
    /// order. Elements past the brace list keep whatever the
    /// stack frame had on entry (c5 doesn't zero-pad locals
    /// today; matches the constant-init path's behaviour).
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
        let count = dims[0];
        let sub_span: i64 = dims[1..].iter().product();
        let sub_bytes = sub_span * elem_size;
        let mut i: i64 = 0;
        while self.lex.tk != '}' {
            // C99 6.7.8p6 array designator `[N] = ...`: reposition the
            // write cursor; subsequent positional entries continue from
            // there. Mirrors the constant path in
            // `collect_array_initializer`.
            if self.lex.tk == Token::Brak {
                self.next()?; // consume `[`
                let n = self.parse_constant_int()?;
                if n < 0 {
                    return Err(self.compile_err(format!(
                        "array designator index must be non-negative (got {n})"
                    )));
                }
                if self.lex.tk == Token::Ellipsis {
                    return Err(self.compile_err(
                        "range designator in a non-constant array initializer is not yet supported",
                    ));
                }
                if self.lex.tk != ']' {
                    return Err(self.compile_err("`]` expected after array designator index"));
                }
                self.next()?; // consume `]`
                if self.lex.tk != Token::Assign {
                    return Err(self.compile_err("`=` expected after `[N]` designator"));
                }
                self.next()?; // consume `=`
                i = n;
            }
            if i >= count {
                return Err(self.compile_err(format!(
                    "too many initializers for array `{}` (> {})",
                    var_name, count
                )));
            }
            let off = base + i * sub_bytes;
            if dims.len() > 1 {
                if self.lex.tk == '{' {
                    self.fill_array_init_runtime(
                        local_val,
                        off,
                        &dims[1..],
                        ty,
                        elem_size,
                        var_name,
                    )?;
                } else {
                    self.fill_array_leaves_runtime(local_val, off, sub_span, ty, elem_size)?;
                }
            } else if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 {
                // Array-of-struct element (C99 6.7.8p17): recurse into the
                // struct initializer instead of the scalar-leaf path, which
                // would hand the element's `{` to the expression parser.
                // Reached when a struct-array MEMBER is forced onto the
                // runtime path by a non-constant element value (e.g.
                // `&mms->field[0]`); braces may be elided (6.7.8p20).
                let braced = self.lex.tk == '{';
                self.emit_struct_runtime_at(local_val, off, struct_id_of(ty), braced)?;
            } else {
                self.emit_array_leaf_runtime(local_val, off, ty)?;
            }
            i += 1;
            self.accept(',')?;
        }
        self.next()?; // consume `}`
        Ok(())
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
        // Whether the previously scanned token was `&` (address-of):
        // a global read in `&global` is a constant address.
        let mut prev_was_amp = false;
        // Per-value tracking: a bare `&global` (or `&g + const`) is a
        // link-time constant the data path handles, but an address
        // combined with a bitwise / shift operator (the address-tagging
        // idiom `(uintptr_t)&g | tag`) is not, so it needs the runtime
        // path. Both flags reset at each value boundary.
        let mut value_has_addr = false;
        let mut value_has_bitop = false;
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
                value_has_addr = false;
                value_has_bitop = false;
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
                value_has_addr = false;
                value_has_bitop = false;
                self.next()?;
                continue;
            } else if self.lex.tk == Token::Id {
                let class = self.symbols[self.lex.curr_id_idx].class;
                if class == Token::Loc as i64 {
                    needs_runtime = true;
                }
                if prev_was_amp {
                    value_has_addr = true;
                    if value_has_bitop {
                        needs_runtime = true;
                    }
                } else if self.glo_value_read_is_runtime(self.lex.curr_id_idx) {
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
                if self.lex.tk == Token::OrOp
                    || self.lex.tk == Token::XorOp
                    || self.lex.tk == Token::ShlOp
                    || self.lex.tk == Token::ShrOp
                {
                    value_has_bitop = true;
                    if value_has_addr {
                        needs_runtime = true;
                    }
                }
                at_entry_start = false;
            }
            prev_was_amp = self.lex.tk == Token::AndOp;
            self.next()?;
        }
        self.lex.restore(snap);
        Ok(needs_runtime)
    }
}
