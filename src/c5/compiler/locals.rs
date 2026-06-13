//! Local-declaration handlers for function bodies.
//!
//! Four related methods cluster here, all dealing with the
//! "reserve frame storage + emit any initializer" responsibilities
//! of a local declaration line at function-body scope:
//!
//!   * `parse_function_body_local_decl` -- parse one declaration
//!     line at the top of a function body. Drives the per-
//!     declarator allocator dispatch (static-promote vs. stack-
//!     local) and the c4-style binding-shadow on the symbol.
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
use super::types::{UNSIGNED_BIT, is_pointer_ty, is_struct_ty, struct_id_of, struct_ptr_depth};

impl Compiler {
    pub(super) fn parse_function_body_local_decl(&mut self) -> Result<(), C5Error> {
        let mut is_static = false;
        let mut is_extern = false;
        let mut saw_specifier = false;
        while self.lex.tk == Token::Extern
            || self.lex.tk == Token::Static
            || self.lex.tk == Token::FuncSpec
            || self.lex.tk == Token::TypeQual
        {
            if self.lex.tk == Token::Static {
                is_static = true;
            }
            if self.lex.tk == Token::Extern {
                is_extern = true;
            }
            saw_specifier = true;
            self.next()?;
        }
        // C89 / K&R implicit int (`register n = ...;`): a declaration
        // that carries a storage-class or qualifier but no type names an
        // int object. Only applies after an explicit specifier so a
        // mistyped type name still surfaces as an error.
        let lbt = if !self.lex_is_type_start() && saw_specifier {
            Ty::Int as i64
        } else {
            self.parse_decl_base_type()?
        };
        // Function-prototype declaration at function-body scope
        // (C99 6.7.1 paragraph 3 allows `extern` declarations at
        // any scope): `extern T (*) name (args);` where `(*)` is
        // any run of `*` qualifying the return type. c5 has no
        // separate translation units, so the declaration is a
        // no-op; the import resolver finds the symbol via its own
        // table. Skip to the closing `;` and return.
        //
        // Snapshot before the speculative `*` walk so a plain
        // pointer-variable declaration with multiple declarators
        // (`int *p, *q;`) doesn't get its leading `*` swallowed
        // and rebound to a wider base type.
        let proto_snap = self.lex.snapshot();
        while self.lex.tk == Token::MulOp {
            self.next()?;
        }
        if self.lex.tk == Token::Id && self.lex.peek_after_whitespace(b'(') {
            self.next()?; // consume name
            self.next()?; // consume `(`
            let mut depth: i64 = 1;
            while depth > 0 && self.lex.tk != 0 {
                if self.lex.tk == '(' {
                    depth += 1;
                } else if self.lex.tk == ')' {
                    depth -= 1;
                    if depth == 0 {
                        self.next()?;
                        break;
                    }
                }
                self.next()?;
            }
            while self.lex.tk != ';' && self.lex.tk != 0 {
                self.next()?;
            }
            self.next()?;
            // `lbt` was used to drive parse_decl_base_type only;
            // for a declaration that turns out to be a function
            // prototype, the symbol table mutation lives in the
            // codegen-side import resolver, so the local-decl
            // bookkeeping (shadow_symbol, allocate_*) is skipped.
            let _ = lbt;
            return Ok(());
        }
        // Not a function prototype after all -- rewind so the
        // declarator loop below sees the `*`s and consumes them
        // per-declarator (the comma-separated path needs each
        // declarator to walk its own `*` chain).
        self.lex.restore(proto_snap);
        while self.lex.tk != ';' {
            let (loc_idx, ty, mut array_size) = self.parse_declarator(lbt)?;
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
            if typedef_dim > 0 && array_size == 0 && !is_pointer_ty(ty) {
                array_size = typedef_dim;
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
                    self.symbols[loc_idx].is_extern_decl = true;
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

            if is_static {
                self.symbols[loc_idx].class = Token::Glo as i64;
                self.symbols[loc_idx].type_ = ty;
                // Block scope with static storage (C99 6.2.4p3): the
                // symbol carries `Glo` class for its `.data` slot but
                // must be unbound at function exit so a file-scope
                // object of the same name reappears. The `Loc`-gated
                // cleanup would skip it, so mark it for restore.
                self.symbols[loc_idx].is_scope_static = true;
                self.allocate_static_local(loc_idx, ty, array_size)?;
                self.ast_emit_static_local_decl(loc_idx as u32);
            } else {
                self.symbols[loc_idx].class = Token::Loc as i64;
                self.symbols[loc_idx].type_ = ty;
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
                if self.symbols[loc_idx].class == Token::Loc as i64 {
                    let slot_off = self.symbols[loc_idx].val;
                    let scalar = self.pending_local_init_ast.take();
                    let aggregate = self.pending_local_aggregate_ast.take();
                    let runtime_elements =
                        core::mem::take(&mut self.pending_local_runtime_elements);
                    let init = if let Some(e) = scalar {
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
                    };
                    self.ast_emit_local_decl(loc_idx as u32, slot_off, init);
                } else {
                    self.pending_local_init_ast = None;
                    self.pending_local_aggregate_ast = None;
                    self.pending_local_runtime_elements.clear();
                }
            }
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

            if self.lex.tk == ',' {
                self.next()?;
            }
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
        if array_size != -1 {
            if self.size_of_type(ty) > 1 {
                self.align_data_to_8();
            }
            let off = self.data.len() as i64;
            self.symbols[loc_idx].val = off;
            for _ in 0..bytes {
                self.data.push(0);
            }
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
                    // C99 6.7.8p20 brace elision: with no per-element
                    // braces the flat value list fills consecutive struct
                    // elements, each consuming the struct's slot count.
                    let groups = self.lex.count_top_level_groups_in_array();
                    let count = if groups > 0 {
                        groups as i64
                    } else {
                        let items = self.lex.count_top_level_items_in_array();
                        let slots = self.struct_flat_init_slots(sid).max(1);
                        items.div_ceil(slots) as i64
                    };
                    self.next()?;
                    self.align_data_to_8();
                    let off = self.data.len() as i64;
                    self.symbols[loc_idx].val = off;
                    for _ in 0..(count * elem_size as i64) {
                        self.data.push(0);
                    }
                    let mut i: i64 = 0;
                    while self.lex.tk != '}' {
                        let here = off + i * elem_size as i64;
                        if self.lex.tk == '{' {
                            self.collect_struct_initializer(sid, here)?;
                        } else {
                            self.fill_struct_fields(sid, here, false)?;
                        }
                        i += 1;
                        if self.lex.tk == ',' {
                            self.next()?;
                        }
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
                if self.lex.tk != '{' {
                    return Err(self.compile_err("array initializer must start with `{{`"));
                }
                self.next()?;
                let mut i: i64 = 0;
                while self.lex.tk != '}' {
                    if i >= array_size {
                        return Err(self.compile_err(format!(
                            "too many initializers for `{}`",
                            self.symbols[loc_idx].name
                        )));
                    }
                    let here = var_offset + i * elem_size as i64;
                    if self.lex.tk == '{' {
                        self.collect_struct_initializer(sid, here)?;
                    } else {
                        self.fill_struct_fields(sid, here, false)?;
                    }
                    i += 1;
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
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
    /// `arr[i]` via an `Expr::Assign` statement the walker lowers to a
    /// global address store. A constant element is stored the same way.
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
        debug_assert!(self.lex.tk == '{');
        self.next()?; // consume `{`
        // The array Ident decays to its base address; the index is the
        // element's byte offset, matching the walker's pre-scaled
        // `Expr::Index` convention.
        let arr_ty = ty + Ty::Ptr as i64;
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
                    self.ast
                        .push_stmt(super::super::ast::Stmt::Expr(assign_id), pos);
                }
            }
            i = range_end + 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        self.next()?; // consume `}`
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
    pub(super) fn allocate_local_with_init(
        &mut self,
        loc_idx: usize,
        ty: i64,
        declared_array_size: i64,
    ) -> Result<(), C5Error> {
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
                return Err(self.compile_err(format!(
                    "array `{}` declared with empty brackets needs an initializer",
                    self.symbols[loc_idx].name
                )));
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
                    groups as i64
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
                    self.loc_offs += self.local_storage_slots(ty, count);
                    self.symbols[loc_idx].val = -self.loc_offs;
                    if self.loc_offs > self.max_loc_offs {
                        self.max_loc_offs = self.loc_offs;
                    }
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
                        self.emit_struct_local_init_runtime_at(
                            local_val,
                            i * elem_size as i64,
                            sid,
                            braced,
                        )?;
                        i += 1;
                        if self.lex.tk == ',' {
                            self.next()?;
                        }
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
                    let here = staged_off as i64 + i * elem_size as i64;
                    if self.lex.tk == '{' {
                        self.collect_struct_initializer(sid, here)?;
                    } else {
                        self.fill_struct_fields(sid, here, false)?;
                    }
                    i += 1;
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
                }
                self.next()?;
                self.symbols[loc_idx].array_size = count;
                self.loc_offs += self.local_storage_slots(ty, count);
                self.symbols[loc_idx].val = -self.loc_offs;
                if self.loc_offs > self.max_loc_offs {
                    self.max_loc_offs = self.loc_offs;
                }
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
                    self.loc_offs += self.local_storage_slots(ty, final_size);
                    self.symbols[loc_idx].val = -self.loc_offs;
                    if self.loc_offs > self.max_loc_offs {
                        self.max_loc_offs = self.loc_offs;
                    }
                    let local_val = self.symbols[loc_idx].val;
                    let var_name = self.symbols[loc_idx].name.clone();
                    self.emit_local_array_init_runtime(local_val, ty, final_size, &var_name)?;
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
            self.loc_offs += self.local_storage_slots(ty, final_size);
            self.symbols[loc_idx].val = -self.loc_offs;
            if self.loc_offs > self.max_loc_offs {
                self.max_loc_offs = self.loc_offs;
            }
            let local_val = self.symbols[loc_idx].val;
            let (start_addr, total_bytes) = self.pack_initializer_into_data(ty, &elements);
            self.emit_local_array_init(local_val, start_addr, total_bytes);
            return Ok(());
        }

        self.symbols[loc_idx].array_size = declared_array_size;
        self.loc_offs += self.local_storage_slots(ty, declared_array_size);
        self.symbols[loc_idx].val = -self.loc_offs;
        if self.loc_offs > self.max_loc_offs {
            self.max_loc_offs = self.loc_offs;
        }

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
                            self.emit_struct_local_init_runtime_at(
                                local_val,
                                i * elem_size as i64,
                                sid,
                                braced,
                            )?;
                            i += 1;
                            if self.lex.tk == ',' {
                                self.next()?;
                            }
                        }
                        self.next()?; // consume outer `}`
                        return Ok(());
                    }
                    self.next()?; // consume outer `{`
                    let mut i: i64 = 0;
                    while self.lex.tk != '}' {
                        if i >= declared_array_size {
                            return Err(self.compile_err(format!(
                                "too many initializers for array `{}` ({} > {})",
                                var_name,
                                i + 1,
                                declared_array_size
                            )));
                        }
                        let here = staged_off as i64 + i * elem_size as i64;
                        // C99 6.7.8p20: a struct element's braces may be
                        // elided, filling its fields from the flat list.
                        if self.lex.tk == '{' {
                            self.collect_struct_initializer(sid, here)?;
                        } else {
                            self.fill_struct_fields(sid, here, false)?;
                        }
                        i += 1;
                        if self.lex.tk == ',' {
                            self.next()?;
                        }
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
                    self.emit_local_array_init_runtime(
                        local_val,
                        ty,
                        declared_array_size,
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
                    self.emit_struct_local_init_runtime(local_val, sid)?;
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
        self.pending_local_init_ast = None;
        self.pending_local_aggregate_ast = None;
        self.pending_local_runtime_elements.clear();
        self.pending.init_inner_dims = alloc::vec::Vec::new();

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
                self.loc_offs += self.local_storage_slots(elem_ty, count);
                slot = -self.loc_offs;
                if self.loc_offs > self.max_loc_offs {
                    self.max_loc_offs = self.loc_offs;
                }
                if needs_runtime {
                    let full = elem_size * count as usize;
                    let zero_off = self.data.len();
                    for _ in 0..full {
                        self.data.push(0);
                    }
                    self.emit_local_array_init(slot, zero_off, full);
                    self.emit_local_array_init_runtime(slot, elem_ty, count, "<compound literal>")?;
                } else {
                    let elements = self.collect_array_initializer(elem_ty)?;
                    let (start, bytes) = self.pack_initializer_into_data(elem_ty, &elements);
                    self.emit_local_array_init(slot, start, bytes);
                }
                final_array_size = count;
            } else {
                let count = decl_array_size;
                let full = elem_size * count as usize;
                self.loc_offs += self.local_storage_slots(elem_ty, count);
                slot = -self.loc_offs;
                if self.loc_offs > self.max_loc_offs {
                    self.max_loc_offs = self.loc_offs;
                }
                if self.lex.tk == '{' && self.array_init_needs_runtime()? {
                    let zero_off = self.data.len();
                    for _ in 0..full {
                        self.data.push(0);
                    }
                    self.emit_local_array_init(slot, zero_off, full);
                    self.emit_local_array_init_runtime(slot, elem_ty, count, "<compound literal>")?;
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
            self.loc_offs += self.slots_of_type(t);
            slot = -self.loc_offs;
            if self.loc_offs > self.max_loc_offs {
                self.max_loc_offs = self.loc_offs;
            }
            let needs_runtime = self.struct_init_needs_runtime()?;
            let staged = self.data.len();
            for _ in 0..elem_size {
                self.data.push(0);
            }
            if needs_runtime {
                self.emit_local_array_init(slot, staged, elem_size);
                self.emit_struct_local_init_runtime(slot, sid)?;
            } else {
                self.collect_struct_initializer(sid, staged as i64)?;
                self.emit_local_array_init(slot, staged, elem_size);
            }
            final_array_size = 0;
            value_ty = t;
        } else {
            // Scalar compound literal `(T){ expr }`.
            self.loc_offs += self.slots_of_type(t);
            slot = -self.loc_offs;
            if self.loc_offs > self.max_loc_offs {
                self.max_loc_offs = self.loc_offs;
            }
            if self.lex.tk != '{' {
                return Err(self.compile_err("`{` expected in compound literal"));
            }
            self.next()?;
            self.expr(Token::Assign as i64)?;
            self.convert_assign_rhs(t);
            self.pending_local_init_ast = self.ast_acc;
            if self.lex.tk == ',' {
                self.next()?;
            }
            if self.lex.tk != '}' {
                return Err(self.compile_err("`}` expected to close compound literal"));
            }
            self.next()?;
            final_array_size = 0;
            value_ty = t;
        }

        let scalar = self.pending_local_init_ast.take();
        let aggregate = self.pending_local_aggregate_ast.take();
        let runtime_elements = core::mem::take(&mut self.pending_local_runtime_elements);
        let init = if let Some(e) = scalar {
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
        };

        self.ast_emit_compound_literal(slot, t, final_array_size, init);
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
            if self.lex.tk == '{' {
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
        ty: i64,
        max: i64,
        var_name: &str,
    ) -> Result<(), C5Error> {
        debug_assert!(self.lex.tk == '{');
        self.next()?; // consume `{`
        let elem_size = self.size_of_type(ty) as i64;
        let mut i: i64 = 0;
        while self.lex.tk != '}' {
            if i >= max {
                return Err(self.compile_err(format!(
                    "too many initializers for array `{}` (> {})",
                    var_name, max
                )));
            }
            // Compute &arr[i] = &arr[0] + i * elem_size.
            self.emit_lea(local_val);
            if i > 0 {
                // Inline Psh + Imm + Add (the private
                // emit_binop_with_imm helper) -- bumps the base
                // address loaded by Lea by `i * elem_size` bytes.
                self.ast_psh();
                self.emit_imm(i * elem_size);
                self.ast_binop(crate::c5::ir::BinOp::Add);
            }
            self.ast_psh();
            // Parse the element expression at assignment
            // precedence; the comma between elements is the
            // delimiter, not a comma-expression operator.
            self.expr(Token::Assign as i64)?;
            // Capture the element's AST node for the matching
            // `LocalInit::Runtime { elements: ... }` entry so the
            // walker can emit one `store_local(offset, value)`
            // per element.
            let elem_ast = self.ast_acc;
            // Float / double init into a non-float slot would
            // need a conversion op here; today c5's only narrow
            // FP storage is in struct fields (handled elsewhere),
            // so the integer-store ops match the local slot
            // width for every type we hit.
            // The AST shape is the same regardless of element
            // width or FP-vs-int -- `ast_assign` builds `Expr::Assign`
            // on top of the lvalue + rvalue the parser already
            // staged on the vstack. Walker downstream picks the
            // matching store width from `field.ty`.
            self.ast_assign();
            if let Some(value) = elem_ast {
                self.pending_local_runtime_elements
                    .push(super::super::ast::RuntimeInitElement {
                        offset: i * elem_size,
                        value,
                        ty,
                    });
            }
            i += 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        self.next()?; // consume `}`
        Ok(())
    }

    /// Emit per-field store sequences for a local-struct
    /// initializer whose entries aren't all compile-time
    /// constants. C99 6.7.8p17 specifies that designated and
    /// positional entries interleave; the cursor moves to one
    /// past the last-written field after each entry. The local
    /// slot is assumed already zeroed by the caller's Mcpy-from-
    /// staged-zeroes prelude, so omitted fields stay at the
    /// implicit `= 0` per 6.7.8p19.
    ///
    /// A struct/union member initialized by a single compatible
    /// struct expression copies the source's bytes (walker Mcpy);
    /// a brace list for such a member recurses. Nested array
    /// fields and non-constant bitfields aren't supported yet --
    /// the constant-staging path already handles them and this
    /// helper only fires when at least one entry is non-constant.
    /// A caller that hits one of those shapes in a non-constant
    /// init gets a parse error.
    pub(super) fn emit_struct_local_init_runtime(
        &mut self,
        local_val: i64,
        sid: usize,
    ) -> Result<(), C5Error> {
        self.emit_struct_local_init_runtime_at(local_val, 0, sid, true)
    }

    /// Same as `emit_struct_local_init_runtime` but writes the
    /// struct at `&local + extra_offset` rather than at
    /// `&local`. Used by the struct-array path so each element
    /// shares a single `local_val` (the array's frame base) and
    /// the per-element byte offset rides through here.
    pub(super) fn emit_struct_local_init_runtime_at(
        &mut self,
        local_val: i64,
        extra_offset: i64,
        sid: usize,
        braced: bool,
    ) -> Result<(), C5Error> {
        // With `braced` false (C99 6.7.8p20 brace elision) there is no
        // enclosing `{ }`: fill the struct's fields from the surrounding
        // flat list and return once every field is filled, leaving the
        // rest for the next element. Mirrors `fill_struct_fields`.
        if braced {
            debug_assert!(self.lex.tk == '{');
            self.next()?; // consume `{`
        }
        let mut pos: usize = 0;
        while self.lex.tk != '}' && (braced || pos < self.structs[sid].fields.len()) {
            let field_idx = if self.lex.tk == Token::Dot {
                self.next()?;
                if self.lex.tk != Token::Id {
                    return Err(self.compile_err("field name expected after `.`"));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                let outer_idx = self.structs[sid]
                    .fields
                    .iter()
                    .position(|f| f.name == field_name)
                    .ok_or_else(|| {
                        self.compile_err(format!(
                            "struct {} has no field {}",
                            self.structs[sid].name, field_name
                        ))
                    })?;
                // C99 6.7.8p7 nested designator chain. See the
                // matching branch in `collect_struct_initializer`
                // for the constant-staging variant. Computes the
                // cumulative offset / final type, then emits one
                // store at `&local + extra_offset + final_offset`.
                if self.lex.tk == Token::Dot || self.lex.tk == Token::Brak {
                    let outer = self.structs[sid].fields[outer_idx].clone();
                    let chain_base = extra_offset + outer.offset as i64;
                    let (final_offset, final_ty) =
                        self.resolve_nested_designator_chain(chain_base, outer.ty)?;
                    if self.lex.tk != Token::Assign {
                        return Err(self.compile_err("`=` expected after nested-designator chain"));
                    }
                    self.next()?;
                    self.emit_lea(local_val);
                    if final_offset > 0 {
                        self.ast_psh();
                        self.emit_imm(final_offset);
                        self.ast_binop(crate::c5::ir::BinOp::Add);
                    }
                    self.ast_psh();
                    self.expr(Token::Assign as i64)?;
                    let field_ast = self.ast_acc;
                    self.ast_assign();
                    if let Some(value) = field_ast {
                        self.pending_local_runtime_elements.push(
                            super::super::ast::RuntimeInitElement {
                                offset: final_offset,
                                value,
                                ty: final_ty,
                            },
                        );
                    }
                    pos = outer_idx + 1;
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
                    continue;
                }
                if self.lex.tk != Token::Assign {
                    return Err(
                        self.compile_err(format!("`=` expected after `.{field_name}` designator"))
                    );
                }
                self.next()?;
                outer_idx
            } else {
                pos
            };
            if field_idx >= self.structs[sid].fields.len() {
                return Err(self.compile_err(format!(
                    "too many initializers for struct {}",
                    self.structs[sid].name
                )));
            }
            let field = self.structs[sid].fields[field_idx].clone();
            if field.bit_width > 0 {
                return Err(self.compile_err("non-constant bitfield initializer not yet supported"));
            }
            if field.array_size > 0 {
                // A char-array field initialized by a string literal
                // (C99 6.7.8p14): emit a constant per-byte store for the
                // literal's characters, then zero-fill the remainder
                // (the NUL terminator is part of the fill when the array
                // has room). Mirrors the constant-staging branch in
                // `fill_struct_fields`, but as runtime store elements so
                // it composes with non-constant sibling fields.
                if self.lex.tk == '"'
                    && !self.lex.str_is_wide
                    && (field.ty & !UNSIGNED_BIT) == Ty::Char as i64
                {
                    let start_addr = self.lex.ival as usize;
                    self.next()?;
                    while self.lex.tk == '"' {
                        self.next()?;
                    }
                    self.data.push(0); // ensure NUL terminator
                    let max = field.array_size as usize;
                    let base = extra_offset + field.offset as i64;
                    for k in 0..max {
                        let b = if start_addr + k < self.data.len() {
                            self.data[start_addr + k] as i64
                        } else {
                            0
                        };
                        let value = self.ast_emit_int_lit(b, Ty::Char as i64);
                        self.pending_local_runtime_elements.push(
                            super::super::ast::RuntimeInitElement {
                                offset: base + k as i64,
                                value,
                                ty: Ty::Char as i64,
                            },
                        );
                    }
                    pos = field_idx + 1;
                    if self.lex.tk == ',' {
                        self.next()?;
                    }
                    continue;
                }
                return Err(
                    self.compile_err("non-constant array-field initializer not yet supported")
                );
            }
            // A nested struct / union member initialized by a brace list,
            // or a compound literal naming the member's type (C99
            // 6.5.2.5), recurses into per-field runtime stores at the
            // member's offset (C99 6.7.8p13). The recursion handles a
            // union the same way -- its fields share offset 0.
            self.skip_opt_compound_literal_cast()?;
            if is_struct_ty(field.ty) && struct_ptr_depth(field.ty) == 0 && self.lex.tk == '{' {
                let nested_sid = struct_id_of(field.ty);
                self.emit_struct_local_init_runtime_at(
                    local_val,
                    extra_offset + field.offset as i64,
                    nested_sid,
                    true,
                )?;
                pos = field_idx + 1;
                if self.lex.tk == ',' {
                    self.next()?;
                }
                continue;
            }
            // Scalar / pointer field. Address = &local +
            // extra_offset + field.offset; push, evaluate the
            // init expression, store with the field's natural
            // width. `extra_offset` is the per-element base
            // offset for struct-array elements (0 for plain
            // struct locals).
            self.emit_lea(local_val);
            let total_offset = extra_offset + field.offset as i64;
            if total_offset > 0 {
                self.ast_psh();
                self.emit_imm(total_offset);
                self.ast_binop(crate::c5::ir::BinOp::Add);
            }
            self.ast_psh();
            self.expr(Token::Assign as i64)?;
            // C99 6.7.8p13: a struct/union member may be initialized by a
            // single expression of compatible struct/union type; the
            // walker copies its bytes (Mcpy). A scalar value for a struct
            // member would be brace elision into the member's sub-fields
            // (6.7.8p20), which the non-constant store path doesn't model.
            if is_struct_ty(field.ty)
                && struct_ptr_depth(field.ty) == 0
                && !(is_struct_ty(self.ty) && struct_ptr_depth(self.ty) == 0)
            {
                return Err(self.compile_err(
                    "brace elision into a non-constant struct member is not supported",
                ));
            }
            let field_ast = self.ast_acc;
            self.ast_assign();
            if let Some(value) = field_ast {
                self.pending_local_runtime_elements
                    .push(super::super::ast::RuntimeInitElement {
                        offset: total_offset,
                        value,
                        ty: field.ty,
                    });
            }
            pos = field_idx + 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        if braced {
            self.next()?; // consume `}`
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
            if self.lex.tk == '{' {
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
        self.lex.restore(snap);
        Ok(needs_runtime)
    }
}
