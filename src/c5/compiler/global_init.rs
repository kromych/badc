//! Global / TLS initializer parser.
//!
//! `parse_global_initializer` lives here because the body is the
//! whole self-contained branch table for the right-hand side of a
//! file-scope `=` -- function pointer, string literal, address-of-
//! global with optional array index, or a constant expression. None
//! of the cases call back into the rest of the compiler beyond
//! `parse_const_expr_or` / `parse_constant_int` (already in
//! `const_expr.rs`) and the small `size_of_type` / `warn` /
//! `type_warning` helpers.
//!
//! Splitting it out keeps `compiler/mod.rs` from carrying the
//! reloc-emit details for every supported initializer shape: the
//! file-scope writer logic, the special `_Thread_local` rejections
//! for the cases that don't have a stable address at link time, and
//! the type-mismatch warning. mod.rs's only remaining role is to
//! call `parse_global_initializer` from the file-scope decl loop.

use alloc::format;

use super::super::error::C5Error;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{UNSIGNED_BIT, is_pointer_ty, is_struct_ty, struct_id_of, struct_ptr_depth};

impl Compiler {
    /// After a leading `(TYPE)` cast in a global initializer, returns
    /// true when the cast applies to a relocation-bearing leaf (`&x`, a
    /// string literal, or a function / global-array name) rather than an
    /// arithmetic value. Reloc leaves keep the address-folding path; an
    /// arithmetic cast must instead reach the const-expr evaluator, which
    /// narrows per C99 6.3.1.3. Entry is positioned just inside the cast
    /// paren (depth 1); the lexer is restored before returning.
    fn post_cast_is_reloc_leaf(&mut self) -> Result<bool, C5Error> {
        let snap = self.lex.snapshot();
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
        while self.lex.tk == '(' {
            self.next()?;
        }
        let reloc = self.lex.tk == Token::AndOp
            || self.lex.tk == '"'
            || (self.lex.tk == Token::Id && {
                let c = self.symbols[self.lex.curr_id_idx].class;
                c == Token::Fun as i64
                    || c == Token::Sys as i64
                    || (c == Token::Glo as i64
                        && self.symbols[self.lex.curr_id_idx].array_size != 0)
            });
        self.lex.restore(snap);
        Ok(reloc)
    }

    /// Parse a global / TLS initializer's right-hand side and
    /// stash the bytes into [`Self::data`] / [`Self::tls_data`]
    /// at `var_offset`. The grammar is intentionally narrow --
    /// integer constants (with optional unary `-`) and
    /// `&<global-name>`. Anything else surfaces a clear "bad
    /// global initializer" diagnostic so the parser stays
    /// honest about what it accepts.
    pub(super) fn parse_global_initializer(
        &mut self,
        var_ty: i64,
        var_offset: i64,
        is_thread_local: bool,
    ) -> Result<(), C5Error> {
        let line = self.lex.line;
        // C99 6.7.8p11 allows a scalar initializer to be enclosed
        // in a single pair of braces: `int x = { 42 };`. Adjacent
        // string-literal concatenation may produce a multi-piece
        // RHS the lexer joins before this parser sees it. Strip
        // the wrapper and recurse.
        if self.lex.tk == '{' {
            self.next()?;
            self.parse_global_initializer(var_ty, var_offset, is_thread_local)?;
            // A trailing `,` before `}` is allowed in C99.
            if self.lex.tk == ',' {
                self.next()?;
            }
            if self.lex.tk != '}' {
                return Err(self.compile_err_at(
                    line,
                    "scalar initializer wrapped in `{{ ... }}` must hold a single value",
                ));
            }
            self.next()?; // consume `}`
            return Ok(());
        }
        // Optional `(TYPE)` cast prefix. const-init only cares about
        // the resulting value, not the cast type, so we skip the
        // type spec and re-enter from the post-cast token. Common
        // in dispatch tables that cast each entry to a stub type
        // (`(SYSCALL)funcname`).
        // Detection is the same `lex_is_type_start` predicate the
        // runtime cast handler in `expr()` uses; if the inner token
        // isn't a type start, this is a parenthesised expression --
        // recurse on the inner and require the closing `)`.
        if self.lex.tk == '(' {
            let pre_paren = self.lex.snapshot();
            self.next()?;
            if self.lex_is_type_start() {
                // A leading `(TYPE)` cast. When it applies to a
                // relocation leaf (`&x`, a string, a function or
                // global-array name) the value is the leaf's address and
                // the cast type is irrelevant, so skip the cast tokens and
                // recurse (the abstract-declarator grammar need not be
                // modelled twice). When it casts an arithmetic operand the
                // cast narrows (C99 6.3.1.3), so route the whole expression
                // through the const-expr evaluator below, which applies the
                // narrowing, instead of discarding the cast.
                if self.post_cast_is_reloc_leaf()? {
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
                    return self.parse_global_initializer(var_ty, var_offset, is_thread_local);
                }
                self.lex.restore(pre_paren);
            } else {
                // Parenthesised expression. Peek past the matching `)`: a
                // trailing operator means the parentheses wrap a sub-operand of a
                // larger constant expression (`(1) << 5`), which the
                // constant-expression evaluator below folds with full operator
                // precedence. A complete value -- `(&x)`, `(func)`, `(123)`, with
                // `,` / `;` / `}` next -- keeps the local recursion that handles
                // address and function-reference constants.
                let after_open = self.lex.snapshot();
                let mut depth: i64 = 1;
                while depth > 0 && self.lex.tk != 0 {
                    if self.lex.tk == '(' {
                        depth += 1;
                    } else if self.lex.tk == ')' {
                        depth -= 1;
                    }
                    self.next()?;
                }
                let trailing_operator = !(self.lex.tk == ','
                    || self.lex.tk == ';'
                    || self.lex.tk == '}'
                    || self.lex.tk == ')'
                    || self.lex.tk == 0);
                if trailing_operator {
                    // Re-parse the whole initializer through the float / integer
                    // constant-expression path below.
                    self.lex.restore(pre_paren);
                } else {
                    self.lex.restore(after_open);
                    self.parse_global_initializer(var_ty, var_offset, is_thread_local)?;
                    if self.lex.tk == ')' {
                        self.next()?;
                    }
                    return Ok(());
                }
            }
        }
        // Bare function reference in a global initializer:
        // `static int (*fp)() = func;`. The value is the function's
        // ent_pc; a CodeReloc patches the slot to the runtime
        // code address at load time. Token::Sys (a libc-bound name)
        // routes through `ensure_sys_trampoline_sym` first to get a
        // synthetic Token::Fun whose val is filled in later by
        // `emit_sys_trampolines`; from that point on it follows the
        // same CodeReloc path as a user-defined function.
        if self.lex.tk == Token::Id
            && (self.symbols[self.lex.curr_id_idx].class == Token::Fun as i64
                || self.symbols[self.lex.curr_id_idx].class == Token::Sys as i64)
        {
            if is_thread_local {
                return Err(self.compile_err_at(
                    line,
                    "function-pointer initializer for `_Thread_local` not supported",
                ));
            }
            let mut sym_idx = self.lex.curr_id_idx;
            if self.symbols[sym_idx].class == Token::Sys as i64 {
                sym_idx = self.ensure_sys_trampoline_sym(sym_idx);
            }
            self.symbols[sym_idx].was_referenced = true;
            let ent_pc = self.symbols[sym_idx].val;
            self.next()?;
            let bytes = (ent_pc as u64).to_le_bytes();
            self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.code_relocs.push(crate::c5::program::CodeReloc {
                data_offset: var_offset as u64,
                target_ent_pc: ent_pc as u64,
            });
            self.code_reloc_sym_idx.push(sym_idx);
            return Ok(());
        }
        // Bare global array reference in a pointer initializer:
        // `int arr[N] = ...; int *p = arr;`. C99 6.3.2.1p3: an
        // lvalue of array type decays to a pointer to its first
        // element in every non-lvalue context, including a
        // global initializer. Emit the same `DataReloc` shape as
        // `&arr[0]` would: the slot holds the array's
        // data-segment offset; the writer / linker patches the
        // runtime VA at image-load time.
        if self.lex.tk == Token::Id
            && self.symbols[self.lex.curr_id_idx].class == Token::Glo as i64
            && self.symbols[self.lex.curr_id_idx].array_size != 0
            && is_pointer_ty(var_ty)
        {
            if is_thread_local {
                return Err(self.compile_err_at(
                    line,
                    "array-decay initializer for `_Thread_local` not supported",
                ));
            }
            let target_idx = self.lex.curr_id_idx;
            self.symbols[target_idx].was_referenced = true;
            self.next()?;
            // An extern array (`extern T a[]`) decays to a link-time
            // reference resolved by name; a local array decays to its own
            // data-segment offset.
            let t = &self.symbols[target_idx];
            let is_extern_data = t.is_extern_decl
                && t.linkage == crate::c5::symbol::Linkage::External
                && !t.has_initializer;
            if is_extern_data {
                let name = self.symbols[target_idx].name.clone();
                self.extern_data_relocs
                    .push(crate::c5::program::ExternDataReloc {
                        data_offset: var_offset as u64,
                        symbol_name: name,
                        addend: 0,
                    });
                return Ok(());
            }
            let target_offset = self.symbols[target_idx].val;
            let bytes = (target_offset as u64).to_le_bytes();
            self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.data_relocs.push(crate::c5::program::DataReloc {
                data_offset: var_offset as u64,
                target_offset: target_offset as u64,
            });
            self.data_reloc_sym_idx.push(target_idx);
            return Ok(());
        }
        // String literal in a `char *p` global initializer.
        if self.lex.tk == '"' && is_pointer_ty(var_ty) {
            if is_thread_local {
                return Err(self.compile_err_at(
                    line,
                    "string-literal initializer for `_Thread_local` not supported",
                ));
            }
            let addr = self.lex.ival;
            self.next()?;
            while self.lex.tk == '"' {
                self.next()?;
            }
            self.data.push(0);
            let bytes = (addr as u64).to_le_bytes();
            self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.data_relocs.push(crate::c5::program::DataReloc {
                data_offset: var_offset as u64,
                target_offset: addr as u64,
            });
            // String-literal target -- no originating
            // symbol; sentinel marks the entry as
            // intra-unit only.
            self.data_reloc_sym_idx.push(usize::MAX);
            return Ok(());
        }
        // `&<global>` -- address-of-global pointer init.
        if self.lex.tk == Token::AndOp {
            if is_thread_local {
                return Err(self.compile_err_at(
                    line,
                    "address-of-global initializer for `_Thread_local` \
                     not yet supported (the rebase / .reloc ordering against \
                     the TLS template needs design work; integer / NULL \
                     initializers are fine)",
                ));
            }
            self.next()?;
            // `&(T){...}` -- C99 6.5.2.5 compound literal in a
            // file-scope initializer. Synthesize an anonymous
            // internal-linkage symbol of type `T`, route its bytes
            // through `collect_struct_initializer`, and write a
            // data reloc from this global's slot to the synthetic
            // symbol's offset.
            if self.lex.tk == '(' {
                self.next()?;
                if !self.lex_is_type_start() {
                    return Err(self.compile_err_at(
                        line,
                        "expected type name in `&(T){{...}}` compound literal",
                    ));
                }
                let mut cl_ty = self.parse_decl_base_type()?;
                while self.lex.tk == Token::MulOp {
                    self.next()?;
                    cl_ty += Ty::Ptr as i64;
                }
                if self.lex.tk != ')' {
                    return Err(
                        self.compile_err_at(line, "`)` expected to close compound-literal type")
                    );
                }
                self.next()?;
                if self.lex.tk != '{' {
                    return Err(self.compile_err_at(
                        line,
                        "`{{` expected to start compound-literal initializer",
                    ));
                }
                if !is_struct_ty(cl_ty) {
                    return Err(self.compile_err_at(
                        line,
                        "compound literal of non-struct type is not yet supported in global init",
                    ));
                }
                self.align_data_to_8();
                let size = self.size_of_type(cl_ty);
                let aligned = size.div_ceil(8) * 8;
                let off = self.data.len() as i64;
                for _ in 0..aligned {
                    self.data.push(0);
                }
                let new_idx = self.intern_compound_literal_symbol(off, cl_ty);
                self.collect_struct_initializer(struct_id_of(cl_ty), off)?;
                let bytes = (off as u64).to_le_bytes();
                self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
                self.data_relocs.push(crate::c5::program::DataReloc {
                    data_offset: var_offset as u64,
                    target_offset: off as u64,
                });
                self.data_reloc_sym_idx.push(new_idx);
                return Ok(());
            }
            if self.lex.tk != Token::Id {
                return Err(
                    self.compile_err_at(line, "identifier expected after `&` in initializer")
                );
            }
            let target_idx = self.lex.curr_id_idx;
            let target_class = self.symbols[target_idx].class;
            // `&func` (C99 6.3.2.1p4): the address-of operator on a
            // function designator yields the same function-pointer
            // value as the bare name, so route it through the same
            // CodeReloc path as `static int (*fp)() = func;`.
            if target_class == Token::Fun as i64 || target_class == Token::Sys as i64 {
                if is_thread_local {
                    return Err(self.compile_err_at(
                        line,
                        "function-pointer initializer for `_Thread_local` not supported",
                    ));
                }
                let mut sym_idx = target_idx;
                if target_class == Token::Sys as i64 {
                    sym_idx = self.ensure_sys_trampoline_sym(sym_idx);
                }
                self.symbols[sym_idx].was_referenced = true;
                let ent_pc = self.symbols[sym_idx].val;
                self.next()?;
                let bytes = (ent_pc as u64).to_le_bytes();
                self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
                self.code_relocs.push(crate::c5::program::CodeReloc {
                    data_offset: var_offset as u64,
                    target_ent_pc: ent_pc as u64,
                });
                self.code_reloc_sym_idx.push(sym_idx);
                return Ok(());
            }
            if target_class != Token::Glo as i64 {
                return Err(self.compile_err_at(
                    line,
                    format!(
                        "`&{}` in a global initializer requires a \
                     non-thread_local global; the right-hand side is \
                     class={target_class}",
                        self.symbols[target_idx].name
                    ),
                ));
            }
            if self.symbols[target_idx].is_thread_local {
                return Err(self.compile_err_at(
                    line,
                    format!(
                        "`&{}` -- can't take the address of a \
                     `_Thread_local` global in a static initializer; the \
                     per-thread address isn't fixed at link time",
                        self.symbols[target_idx].name
                    ),
                ));
            }
            let mut target_offset = self.symbols[target_idx].val;
            self.next()?;
            // C99 6.6: the address of any array element or struct member of
            // a static-storage object is an address constant. Walk the
            // designator suffix -- a sequence of `[const]` subscripts and
            // `.field` selections -- tracking the current type and its
            // array dimensions. A subscript at level `i` strides by
            // `product(array_dims[i+1..]) * sizeof(element)` (the first
            // index spans whole sub-arrays, the innermost an element, C99
            // 6.5.2.1p2; an empty `array_dims` is the 1D case); a member
            // adds its byte offset and moves the current type to the
            // field. The accumulated byte offset is the address constant.
            let mut cur_ty = self.symbols[target_idx].type_;
            let mut cur_dims = self.symbols[target_idx].array_dims.clone();
            let mut level = 0usize;
            loop {
                if self.lex.tk == Token::Brak {
                    self.next()?;
                    let n = self.parse_constant_int()?;
                    if self.lex.tk != ']' {
                        return Err(self.compile_err_at(
                            line,
                            format!(
                                "close bracket expected in `&{}[...]`",
                                self.symbols[target_idx].name
                            ),
                        ));
                    }
                    self.next()?;
                    let elem_size = self.size_of_type(cur_ty) as i64;
                    let stride = if level < cur_dims.len() {
                        cur_dims[level + 1..].iter().product::<i64>() * elem_size
                    } else {
                        elem_size
                    };
                    target_offset += n * stride;
                    level += 1;
                } else if self.lex.tk == Token::Dot {
                    if !is_struct_ty(cur_ty) || struct_ptr_depth(cur_ty) != 0 {
                        return Err(self.compile_err_at(
                            line,
                            "`.` on a non-struct value in a constant address",
                        ));
                    }
                    self.next()?;
                    if self.lex.tk != Token::Id {
                        return Err(self
                            .compile_err_at(line, "field name expected after `.` in initializer"));
                    }
                    let field_name = self.symbols[self.lex.curr_id_idx].name.clone();
                    let sid = struct_id_of(cur_ty);
                    let Some(field) = self.structs[sid]
                        .fields
                        .iter()
                        .find(|f| f.name == field_name)
                        .cloned()
                    else {
                        return Err(self.compile_err_at(
                            line,
                            format!(
                                "struct {} has no field {field_name}",
                                self.structs[sid].name
                            ),
                        ));
                    };
                    target_offset += field.offset as i64;
                    cur_ty = field.ty;
                    cur_dims = field.array_dims.clone();
                    level = 0;
                    self.next()?;
                } else {
                    break;
                }
            }
            // A target defined in another translation unit (`extern T g;`
            // with no definition here) is resolved by name at link time;
            // `target_offset` is the byte offset added to its address
            // (the symbol's own `val` is 0 for an extern). The slot stays
            // zero until the link resolves it.
            {
                let t = &self.symbols[target_idx];
                let is_extern_data = t.is_extern_decl
                    && t.linkage == crate::c5::symbol::Linkage::External
                    && !t.has_initializer;
                if is_extern_data {
                    self.symbols[target_idx].was_referenced = true;
                    let name = self.symbols[target_idx].name.clone();
                    self.extern_data_relocs
                        .push(crate::c5::program::ExternDataReloc {
                            data_offset: var_offset as u64,
                            symbol_name: name,
                            // `target_offset` started at the symbol's own
                            // `val` (a parse-time tentative slot that is
                            // cleared at finalize); the addend is the
                            // index/byte offset alone.
                            addend: target_offset - self.symbols[target_idx].val,
                        });
                    return Ok(());
                }
            }
            // Write the target's data-segment offset into the
            // slot. The VM reads this directly because its
            // pointers are small data offsets (no image-base
            // arithmetic). The native writers overwrite this
            // with the target's absolute VA at write time --
            // ELF (ET_EXEC) writes a fully-resolved VA; Mach-O
            // and PE write the preferred VA and emit a
            // dynamic relocation (rebase opcode / .reloc DIR64
            // entry) so the loader can patch in the slide
            // delta.
            let bytes = (target_offset as u64).to_le_bytes();
            self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.data_relocs.push(crate::c5::program::DataReloc {
                data_offset: var_offset as u64,
                target_offset: target_offset as u64,
            });
            self.data_reloc_sym_idx.push(target_idx);
            return Ok(());
        }

        // Float / double scalar global with a constant-foldable
        // float expression: `static float gamma = 1.0f / 2.2f;` and
        // similar. The integer constant evaluator can't see through
        // `/`, `*`, etc. on float operands, so route through the
        // f64 folder in initializer.rs. The result is stored as the
        // full 8 bytes the slot was sized for; a future
        // f32-narrow-storage path would shrink it for `float`.
        let var_is_float = {
            let stripped = var_ty & !UNSIGNED_BIT;
            stripped == Ty::Float as i64 || stripped == Ty::Double as i64
        };
        // A float literal, a parenthesised float expression, or either of
        // those behind a leading unary sign signals a float-valued
        // initializer that must route through the f64 folder rather than
        // the integer evaluator (whose `value as f64` would coerce a
        // float result to an integer first). `-INFINITY` expands to
        // `-(1.0e+308 * 10.0)`, so the sign precedes a parenthesised
        // float expression.
        let init_is_float = if !var_is_float {
            false
        } else if self.lex.tk == Token::FloatNum {
            true
        } else if self.lex.tk == '(' {
            self.contents_until_close_paren_have_float_pub()?
        } else if self.lex.tk == Token::SubOp || self.lex.tk == Token::AddOp {
            let snap = self.lex.snapshot();
            self.next()?;
            let ahead = self.lex.tk == Token::FloatNum
                || (self.lex.tk == '(' && self.contents_until_close_paren_have_float_pub()?);
            self.lex.restore(snap);
            ahead
        } else {
            false
        };
        if init_is_float {
            let bits = self.parse_const_expr_add_val()?.as_float();
            // A `float` slot is 4 bytes: narrow the f64 constant to
            // the f32 pattern, otherwise the low 4 bytes of the f64
            // bits (zero for many values) land in the slot. `double`
            // keeps the full 8-byte pattern.
            let value = self.to_storage_bits(
                bits.to_bits() as i64,
                super::initializer::InitElemReloc::Float64Bits,
                var_ty,
            );
            let size = self.size_of_type(var_ty);
            let bytes = value.to_le_bytes();
            let segment = if is_thread_local {
                &mut self.tls_data
            } else {
                &mut self.data
            };
            let off = var_offset as usize;
            debug_assert!(off + size <= segment.len());
            segment[off..off + size].copy_from_slice(&bytes[..size]);
            if is_thread_local {
                let end = off + size;
                if end > self.tls_init_size {
                    self.tls_init_size = end;
                }
            }
            return Ok(());
        }

        // Constant expression, evaluated at compile time. Handles
        // integer literals, unary `+`/`-`, casts (`(size_t)expr`),
        // arithmetic, parens, identifiers bound as `Token::Num`
        // (enum / `#define`d constants), and the offsetof shape.
        let value = self.parse_const_expr_or()?;

        // C99 6.7.8p11 / 6.3.1.4: an integer constant initializing a
        // floating object is converted to the floating value; storing
        // the integer's bit pattern would leave a denormal. Narrow to
        // the slot's width (f32 for `float`, f64 for `double`).
        let value = if var_is_float {
            self.to_storage_bits(
                (value as f64).to_bits() as i64,
                super::initializer::InitElemReloc::Float64Bits,
                var_ty,
            )
        } else {
            value
        };
        let write_size = if var_is_float {
            self.size_of_type(var_ty)
        } else {
            8
        };

        let bytes = value.to_le_bytes();
        let segment = if is_thread_local {
            &mut self.tls_data
        } else {
            &mut self.data
        };
        let off = var_offset as usize;
        // Both segments preallocated 8 zero bytes for this
        // variable; we overwrite the slot with the
        // initializer's bytes.
        debug_assert!(off + write_size <= segment.len());
        segment[off..off + write_size].copy_from_slice(&bytes[..write_size]);

        if is_thread_local {
            // Move the .tdata/.tbss boundary so this slot is
            // part of the loader's initial template. Once any
            // TLS init lands, every TLS byte before it (and
            // the trailing zero-init bytes too, eventually)
            // gets routed through the template path; that's
            // fine because the bytes are still byte-for-byte
            // correct. Per-format writers handle the layout.
            let end = off + 8;
            if end > self.tls_init_size {
                self.tls_init_size = end;
            }
        }

        // Type-check: warn (don't error) if the constant doesn't match
        // the declared type. Only pointer-vs-int mismatches are
        // diagnosed here, matching the assignment path.
        let init_ty = if value == 0 { 0 } else { Ty::Int as i64 };
        if let Some(reason) = Self::type_warning(var_ty, init_ty, value == 0) {
            let var_s = super::types::format_type(var_ty, &self.structs);
            let init_s = super::types::format_type(init_ty, &self.structs);
            self.warn_at(
                line,
                format!("{reason} in global initializer (var={var_s}, value={init_s})"),
            );
        }
        Ok(())
    }
}
