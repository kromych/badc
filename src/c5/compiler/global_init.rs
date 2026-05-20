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
use super::types::{UNSIGNED_BIT, is_pointer_ty, is_struct_ty, struct_id_of};

impl Compiler {
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
            self.next()?;
            if self.lex_is_type_start() {
                // Discard the cast destination type. Counted-paren
                // skip handles abstract function-pointer declarators
                // (`(SYSCALL)`, `(int (*)(int))`, etc.) without us
                // having to model the declarator grammar twice.
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
            // Parenthesised expression: recurse on the inner and
            // consume the matching `)`.
            self.parse_global_initializer(var_ty, var_offset, is_thread_local)?;
            if self.lex.tk == ')' {
                self.next()?;
            }
            return Ok(());
        }
        // Bare function reference in a global initializer:
        // `static int (*fp)() = func;`. The value is the function's
        // bytecode PC; a CodeReloc patches the slot to the runtime
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
            let bc_pc = self.symbols[sym_idx].val;
            self.next()?;
            let bytes = (bc_pc as u64).to_le_bytes();
            self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.code_relocs.push(crate::c5::program::CodeReloc {
                data_offset: var_offset as u64,
                target_bc_pc: bc_pc as u64,
            });
            self.code_reloc_sym_idx.push(sym_idx);
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
                let counter = self.next_compound_literal_id;
                self.next_compound_literal_id += 1;
                let sym_name = format!("__compound.{counter}");
                let new_idx = self.symbols.len();
                let hash = crate::c5::lexer::hash_name(sym_name.as_bytes());
                let sym = crate::c5::symbol::Symbol {
                    name: sym_name,
                    token: Token::Id as i64,
                    class: Token::Glo as i64,
                    type_: cl_ty,
                    val: off,
                    linkage: crate::c5::symbol::Linkage::Internal,
                    defined_here: true,
                    has_initializer: true,
                    ..Default::default()
                };
                self.symbols.push(sym);
                // SymbolIndex must stay in lockstep with `symbols`,
                // otherwise the next user identifier the lexer tries
                // to register lands at a stale idx and unrelated
                // identifiers vanish. The synthetic `__compound.N`
                // name is unique per TU so it can't shadow anything
                // user-visible.
                self.symbol_index.record(hash);
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
            // For an array global, scale subsequent `[N]` indexes
            // by the element size; for a scalar global the index
            // (if any) is just byte-additive, and there usually
            // isn't one.
            let elem_size = if self.symbols[target_idx].array_size > 0 {
                self.size_of_type(self.symbols[target_idx].type_) as i64
            } else {
                1
            };
            self.next()?;
            // Optional `[const_expr]` -- `&array[N]` and
            // `&array[N+M]` etc. The constant-expression evaluator
            // handles `+`, `-`, `*`, parens, `Token::Num`-class
            // identifiers (enum / `#define`d constants).
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
                target_offset += n * elem_size;
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
        if var_is_float
            && (self.lex.tk == Token::FloatNum
                || (self.lex.tk == Token::SubOp && self.lex.peek_after_whitespace_starts_digit())
                || (self.lex.tk == '(' && self.contents_until_close_paren_have_float_pub()?))
        {
            let bits = self.parse_const_float_expr()?;
            let value = bits.to_bits() as i64;
            let bytes = value.to_le_bytes();
            let segment = if is_thread_local {
                &mut self.tls_data
            } else {
                &mut self.data
            };
            let off = var_offset as usize;
            debug_assert!(off + 8 <= segment.len());
            segment[off..off + 8].copy_from_slice(&bytes);
            if is_thread_local {
                let end = off + 8;
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
        debug_assert!(off + 8 <= segment.len());
        segment[off..off + 8].copy_from_slice(&bytes);

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

        // Type-check: warn (don't error) if the constant
        // doesn't match the declared type. For now we only
        // care about pointer-vs-int mismatches the way the
        // assignment path does.
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
