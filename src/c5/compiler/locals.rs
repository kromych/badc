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
use super::super::op::Op;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{UNSIGNED_BIT, is_struct_ty, struct_id_of, struct_ptr_depth};

impl Compiler {
    pub(super) fn parse_function_body_local_decl(&mut self) -> Result<(), C5Error> {
        let mut is_static = false;
        while self.lex.tk == Token::Extern || self.lex.tk == Token::Static {
            if self.lex.tk == Token::Static {
                is_static = true;
            }
            self.next()?;
        }
        let lbt = self.parse_decl_base_type()?;
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
            // Array typedef carries its dimension when the
            // declarator did not supply one (C99 6.7.7 p3).
            let typedef_dim = core::mem::take(&mut self.pending.typedef_base_array_size);
            if typedef_dim > 0 && array_size == 0 {
                array_size = typedef_dim;
            }
            self.ty = ty;
            if self.symbols[loc_idx].class == Token::Loc as i64 {
                return Err(self.compile_err("duplicate local definition"));
            }

            self.shadow_symbol(loc_idx);

            if is_static {
                self.symbols[loc_idx].class = Token::Glo as i64;
                self.symbols[loc_idx].type_ = ty;
                self.allocate_static_local(loc_idx, ty, array_size)?;
            } else {
                self.symbols[loc_idx].class = Token::Loc as i64;
                self.symbols[loc_idx].type_ = ty;
                self.allocate_local_with_init(loc_idx, ty, array_size)?;
            }
            // Unconditional write: a stale fn-ptr lineage from a
            // prior binding of this name must not leak into a
            // plain scalar/pointer rebind, or the unary `*` handler
            // mistakes a `*p = ...` for a fn-ptr decay no-op (the
            // `shadow_symbol` saved the prior value into
            // `h_fn_ptr_indirection`, so block-exit will restore it).
            self.symbols[loc_idx].fn_ptr_indirection = fn_ptr_indirection;

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
                    let count = self.lex.count_top_level_groups_in_array() as i64;
                    self.next()?;
                    self.align_data_to_8();
                    let off = self.data.len() as i64;
                    self.symbols[loc_idx].val = off;
                    for _ in 0..(count * elem_size as i64) {
                        self.data.push(0);
                    }
                    let sid = struct_id_of(ty);
                    let mut i: i64 = 0;
                    while self.lex.tk != '}' {
                        let here = off + i * elem_size as i64;
                        if self.lex.tk == '{' {
                            self.collect_struct_initializer(sid, here)?;
                        } else {
                            return Err(
                                self.compile_err("struct array element must be a brace list")
                            );
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
                self.pending.init_inner_dim = self.symbols[loc_idx].inner_array_size;
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
            } else if array_size > 0 {
                self.pending.init_inner_dim = self.symbols[loc_idx].inner_array_size;
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
                // Local deferred-size struct array. Same scan-then-
                // pre-allocate dance as the file-scope path so an
                // element's string-literal field doesn't shift the
                // next element off its expected offset.
                let elem_size = self.size_of_type(ty);
                let count = self.lex.count_top_level_groups_in_array() as i64;
                let staged_off = self.data.len();
                self.next()?;
                for _ in 0..(count * elem_size as i64) {
                    self.data.push(0);
                }
                let sid = struct_id_of(ty);
                let mut i: i64 = 0;
                while self.lex.tk != '}' {
                    let here = staged_off as i64 + i * elem_size as i64;
                    if self.lex.tk == '{' {
                        self.collect_struct_initializer(sid, here)?;
                    } else {
                        return Err(self.compile_err("struct array element must be a brace list"));
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
            self.pending.init_inner_dim = self.symbols[loc_idx].inner_array_size;
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
                // C99 6.7.8 lets auto-storage local arrays carry
                // initializers with non-constant expressions
                // ("dynamic initialization"). The pre-scan looks
                // for any identifier referring to a Loc symbol or
                // any indexed / called / address-taken shape that
                // can't fold at compile time; if found, switch to
                // the per-element runtime store path. Pure-constant
                // initializers keep the Mcpy-from-data fast path
                // and the staged on-disk image stays compact.
                if self.lex.tk == '{' && self.array_init_needs_runtime()? {
                    self.emit_local_array_init_runtime(
                        local_val,
                        ty,
                        declared_array_size,
                        &var_name,
                    )?;
                    return Ok(());
                }
                self.pending.init_inner_dim = self.symbols[loc_idx].inner_array_size;
                let elements = self.collect_array_initializer(ty)?;
                let init_count = elements.len();
                let max = declared_array_size as usize;
                if init_count > max {
                    return Err(self.compile_err(format!(
                        "too many initializers for array `{}` ({} > {})",
                        var_name, init_count, max
                    )));
                }
                let (start_addr, total_bytes) = self.pack_initializer_into_data(ty, &elements);
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

    /// Pre-scan an array initializer's brace list (current token
    /// must be `{`) and return `(element_count, needs_runtime)`.
    /// The count is the number of top-level (comma-separated)
    /// elements, used by the deferred-size `T xs[] = {...}` path.
    /// The runtime flag is true when any element involves a
    /// non-constant value -- a Loc-class identifier, an indexed
    /// read, a member access, or a function call.
    pub(super) fn scan_array_init(&mut self) -> Result<(i64, bool), C5Error> {
        debug_assert!(self.lex.tk == '{');
        let snap = self.lex.snapshot();
        self.next()?; // consume `{`
        let mut depth: i64 = 1;
        let mut needs_runtime = false;
        let mut count: i64 = 0;
        // Detect an empty list (`{}`) -- 0 elements rather than 1.
        let mut saw_any = false;
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
                self.next()?;
                continue;
            } else if self.lex.tk == Token::Id {
                saw_any = true;
                let class = self.symbols[self.lex.curr_id_idx].class;
                if class == Token::Loc as i64 {
                    needs_runtime = true;
                }
                if self.lex.peek_after_whitespace(b'[') || self.lex.peek_after_whitespace(b'(') {
                    needs_runtime = true;
                }
            } else if self.lex.tk == Token::Dot || self.lex.tk == Token::Arrow {
                needs_runtime = true;
                saw_any = true;
            } else {
                saw_any = true;
            }
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
        let store_op = match elem_size {
            1 => Op::Sc,
            2 => Op::Sh,
            4 => Op::Sw,
            _ => Op::Si,
        };
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
                self.emit_op(Op::Psh);
                self.emit_imm(i * elem_size);
                self.emit_op(Op::Add);
            }
            self.emit_op(Op::Psh);
            // Parse the element expression at assignment
            // precedence; the comma between elements is the
            // delimiter, not a comma-expression operator.
            self.expr(Token::Assign as i64)?;
            // Float / double init into a non-float slot would
            // need a conversion op here; today c5's only narrow
            // FP storage is in struct fields (handled elsewhere),
            // so the integer-store ops match the local slot
            // width for every type we hit.
            let unsigned = (ty & UNSIGNED_BIT) != 0;
            let _ = unsigned; // bit kept for future narrowing-store dispatch
            // Float / double element: the Si store widens to the
            // full 8-byte slot and the FP bits survive intact
            // because c5 holds doubles in 64-bit accumulator
            // registers. A float (4-byte) element would still
            // need an explicit cvt to single-precision; today no
            // smoke target hits that shape.
            let is_fp = (ty & !UNSIGNED_BIT) == Ty::Float as i64
                || (ty & !UNSIGNED_BIT) == Ty::Double as i64;
            if is_fp {
                self.emit_op(Op::Si);
            } else {
                self.emit_op(store_op);
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
    /// Nested array fields, nested struct values, bitfields, and
    /// string-literal char-array fields aren't supported yet --
    /// the constant-staging path already handles them and this
    /// helper only fires when at least one entry is non-constant.
    /// A caller that hits one of those shapes in a non-constant
    /// init gets a parse error.
    pub(super) fn emit_struct_local_init_runtime(
        &mut self,
        local_val: i64,
        sid: usize,
    ) -> Result<(), C5Error> {
        debug_assert!(self.lex.tk == '{');
        self.next()?; // consume `{`
        let mut pos: usize = 0;
        while self.lex.tk != '}' {
            let field_idx = if self.lex.tk == Token::Dot {
                self.next()?;
                if self.lex.tk != Token::Id {
                    return Err(self.compile_err("field name expected after `.`"));
                }
                let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                self.next()?;
                if self.lex.tk != Token::Assign {
                    return Err(
                        self.compile_err(format!("`=` expected after `.{field_name}` designator"))
                    );
                }
                self.next()?;
                self.structs[sid]
                    .fields
                    .iter()
                    .position(|f| f.name == field_name)
                    .ok_or_else(|| {
                        self.compile_err(format!(
                            "struct {} has no field {}",
                            self.structs[sid].name, field_name
                        ))
                    })?
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
                return Err(
                    self.compile_err("non-constant array-field initializer not yet supported")
                );
            }
            if is_struct_ty(field.ty) && struct_ptr_depth(field.ty) == 0 && self.lex.tk == '{' {
                return Err(self.compile_err(
                    "non-constant nested-struct-field initializer not yet supported",
                ));
            }
            // Scalar / pointer field. Address = &local + field.offset;
            // push, evaluate the init expression, store with the
            // field's natural width.
            self.emit_lea(local_val);
            if field.offset > 0 {
                self.emit_op(Op::Psh);
                self.emit_imm(field.offset as i64);
                self.emit_op(Op::Add);
            }
            self.emit_op(Op::Psh);
            self.expr(Token::Assign as i64)?;
            let elem_size = self.size_of_type(field.ty);
            let store_op = match elem_size {
                1 => Op::Sc,
                2 => Op::Sh,
                4 => Op::Sw,
                _ => Op::Si,
            };
            self.emit_op(store_op);
            pos = field_idx + 1;
            if self.lex.tk == ',' {
                self.next()?;
            }
        }
        self.next()?; // consume `}`
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
                self.next()?;
                continue;
            } else if self.lex.tk == Token::Id {
                let class = self.symbols[self.lex.curr_id_idx].class;
                if class == Token::Loc as i64 {
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
            self.next()?;
        }
        self.lex.restore(snap);
        Ok(needs_runtime)
    }
}
