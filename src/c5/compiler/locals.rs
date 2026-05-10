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
        while self.lex.tk == Token::Extern as i64 || self.lex.tk == Token::Static as i64 {
            if self.lex.tk == Token::Static as i64 {
                is_static = true;
            }
            self.next()?;
        }
        let lbt = self.parse_decl_base_type()?;
        // Function-prototype declaration at function-body scope:
        // `extern int foo(int);` -- the next two tokens are an
        // identifier and `(`, and what follows is a parameter list
        // ending with `);`. c5 has no separate translation units,
        // so the declaration is a no-op; the import resolver finds
        // the symbol via its own table. Skip to the `;` and return.
        // Mirrors the matching branch in `parse_block_local_decl`
        // for `{` blocks nested below the function body's top
        // level.
        if self.lex.tk == Token::Id as i64 && self.lex.peek_after_whitespace(b'(') {
            self.next()?; // consume name
            self.next()?; // consume `(`
            let mut depth: i64 = 1;
            while depth > 0 && self.lex.tk != 0 {
                if self.lex.tk == '(' as i64 {
                    depth += 1;
                } else if self.lex.tk == ')' as i64 {
                    depth -= 1;
                    if depth == 0 {
                        self.next()?;
                        break;
                    }
                }
                self.next()?;
            }
            while self.lex.tk != ';' as i64 && self.lex.tk != 0 {
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
        while self.lex.tk != ';' as i64 {
            let (loc_idx, ty, array_size) = self.parse_declarator(lbt)?;
            // gh #19 fn-pointer lineage carries through to local
            // bindings -- pick up the side-channel parse_declarator
            // (or the typedef base type) populated.
            let fn_ptr_indirection = self.pending_fn_ptr_indirection.take().unwrap_or(0);
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

            if self.lex.tk == ',' as i64 {
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

        if self.lex.tk == Token::Assign as i64 {
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
                    if self.lex.tk != '{' as i64 {
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
                    while self.lex.tk != '}' as i64 {
                        let here = off + i * elem_size as i64;
                        if self.lex.tk == '{' as i64 {
                            self.collect_struct_initializer(sid, here)?;
                        } else {
                            return Err(
                                self.compile_err("struct array element must be a brace list")
                            );
                        }
                        i += 1;
                        if self.lex.tk == ',' as i64 {
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
            if self.lex.tk != Token::Assign as i64 {
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
            if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 && self.lex.tk == '{' as i64 {
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
                while self.lex.tk != '}' as i64 {
                    let here = staged_off as i64 + i * elem_size as i64;
                    if self.lex.tk == '{' as i64 {
                        self.collect_struct_initializer(sid, here)?;
                    } else {
                        return Err(self.compile_err("struct array element must be a brace list"));
                    }
                    i += 1;
                    if self.lex.tk == ',' as i64 {
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
            // routes through the per-element runtime store path,
            // which stb_image_write's `head1[]` (inside
            // `stbi_write_jpg_to_func`) needs: that array's first
            // bytes are literal magic numbers but later positions
            // are runtime expressions like
            // `(unsigned char)(height>>8)`.
            if self.lex.tk == '{' as i64 {
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

        if self.lex.tk == Token::Assign as i64 {
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
                if self.lex.tk == '{' as i64 && self.array_init_needs_runtime()? {
                    self.emit_local_array_init_runtime(
                        local_val,
                        ty,
                        declared_array_size,
                        &var_name,
                    )?;
                    return Ok(());
                }
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
            } else if is_struct_ty(ty) && struct_ptr_depth(ty) == 0 && self.lex.tk == '{' as i64 {
                // Local struct value with brace-list initializer.
                // Stage the bytes in `self.data` (so the bit
                // pattern is shared across calls), then emit a
                // Mcpy from the staged buffer to the local slot.
                let elem_size = self.size_of_type(ty);
                let staged_off = self.data.len();
                for _ in 0..elem_size {
                    self.data.push(0);
                }
                let sid = struct_id_of(ty);
                self.collect_struct_initializer(sid, staged_off as i64)?;
                self.emit_local_array_init(local_val, staged_off, elem_size);
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
        debug_assert!(self.lex.tk == '{' as i64);
        let snap = self.lex.snapshot();
        self.next()?; // consume `{`
        let mut depth: i64 = 1;
        let mut needs_runtime = false;
        let mut count: i64 = 0;
        // Detect an empty list (`{}`) -- 0 elements rather than 1.
        let mut saw_any = false;
        while depth > 0 && self.lex.tk != 0 {
            if self.lex.tk == '{' as i64 {
                depth += 1;
            } else if self.lex.tk == '}' as i64 {
                depth -= 1;
                if depth == 0 {
                    if saw_any {
                        count += 1;
                    }
                    break;
                }
            } else if self.lex.tk == ',' as i64 && depth == 1 {
                if saw_any {
                    count += 1;
                }
                saw_any = false;
                self.next()?;
                continue;
            } else if self.lex.tk == Token::Id as i64 {
                saw_any = true;
                let class = self.symbols[self.lex.curr_id_idx].class;
                if class == Token::Loc as i64 {
                    needs_runtime = true;
                }
                if self.lex.peek_after_whitespace(b'[') || self.lex.peek_after_whitespace(b'(') {
                    needs_runtime = true;
                }
            } else if self.lex.tk == Token::Dot as i64 || self.lex.tk == Token::Arrow as i64 {
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
        debug_assert!(self.lex.tk == '{' as i64);
        self.next()?; // consume `{`
        let elem_size = self.size_of_type(ty) as i64;
        let store_op = match elem_size {
            1 => Op::Sc,
            2 => Op::Sh,
            4 => Op::Sw,
            _ => Op::Si,
        };
        let mut i: i64 = 0;
        while self.lex.tk != '}' as i64 {
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
            if self.lex.tk == ',' as i64 {
                self.next()?;
            }
        }
        self.next()?; // consume `}`
        Ok(())
    }
}
