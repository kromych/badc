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
use super::super::token::Token;
use super::types::{is_struct_ty, struct_id_of, struct_ptr_depth};
use super::Compiler;

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
        while self.lex.tk != ';' as i64 {
            let (loc_idx, ty, array_size) = self.parse_declarator(lbt)?;
            self.ty = ty;
            if self.symbols[loc_idx].class == Token::Loc as i64 {
                return Err(C5Error::Compile(format!(
                    "{}: duplicate local definition",
                    self.lex.line
                )));
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
    /// covers scalars; sqlite's static locals are mostly scalar
    /// flags so this is acceptable).
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
                        return Err(C5Error::Compile(format!(
                            "{}: array initializer must start with `{{`",
                            self.lex.line
                        )));
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
                            return Err(C5Error::Compile(format!(
                                "{}: struct array element must be a brace list",
                                self.lex.line
                            )));
                        }
                        i += 1;
                        if self.lex.tk == ',' as i64 {
                            self.next()?;
                        }
                    }
                    self.next()?;
                    self.symbols[loc_idx].array_size = count;
                    while self.data.len() % 8 != 0 {
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
                return Err(C5Error::Compile(format!(
                    "{}: array `{}` declared with empty brackets needs an initializer",
                    self.lex.line, self.symbols[loc_idx].name
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
                        return Err(C5Error::Compile(format!(
                            "{}: struct array element must be a brace list",
                            self.lex.line
                        )));
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
                self.emit_local_array_init(
                    local_val,
                    staged_off,
                    elem_size * count as usize,
                );
                return Ok(());
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
                let elements = self.collect_array_initializer(ty)?;
                let init_count = elements.len();
                let max = declared_array_size as usize;
                if init_count > max {
                    return Err(C5Error::Compile(format!(
                        "{}: too many initializers for array `{}` ({} > {})",
                        self.lex.line, self.symbols[loc_idx].name, init_count, max
                    )));
                }
                let (start_addr, total_bytes) =
                    self.pack_initializer_into_data(ty, &elements);
                self.emit_local_array_init(local_val, start_addr, total_bytes);
            } else if is_struct_ty(ty)
                && struct_ptr_depth(ty) == 0
                && self.lex.tk == '{' as i64
            {
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
}
