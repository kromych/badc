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
use super::types::is_pointer_ty;

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
        // Optional `(TYPE)` cast prefix. const-init only cares about
        // the resulting value, not the cast type, so we skip the
        // type spec and re-enter from the post-cast token. Common
        // in dispatch tables that cast each entry to a stub type
        // (`(SYSCALL)funcname`).
        // Detection is the same `lex_is_type_start` predicate the
        // runtime cast handler in `expr()` uses; if the inner token
        // isn't a type start, this is a parenthesised expression --
        // recurse on the inner and require the closing `)`.
        if self.lex.tk == '(' as i64 {
            self.next()?;
            if self.lex_is_type_start() {
                // Discard the cast destination type. Counted-paren
                // skip handles abstract function-pointer declarators
                // (`(SYSCALL)`, `(int (*)(int))`, etc.) without us
                // having to model the declarator grammar twice.
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
                return self.parse_global_initializer(var_ty, var_offset, is_thread_local);
            }
            // Parenthesised expression: recurse on the inner and
            // consume the matching `)`.
            self.parse_global_initializer(var_ty, var_offset, is_thread_local)?;
            if self.lex.tk == ')' as i64 {
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
        if self.lex.tk == Token::Id as i64
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
        if self.lex.tk == '"' as i64 && is_pointer_ty(var_ty) {
            if is_thread_local {
                return Err(self.compile_err_at(
                    line,
                    "string-literal initializer for `_Thread_local` not supported",
                ));
            }
            let addr = self.lex.ival;
            self.next()?;
            while self.lex.tk == '"' as i64 {
                self.next()?;
            }
            self.data.push(0);
            let bytes = (addr as u64).to_le_bytes();
            self.data[var_offset as usize..var_offset as usize + 8].copy_from_slice(&bytes);
            self.data_relocs.push(crate::c5::program::DataReloc {
                data_offset: var_offset as u64,
                target_offset: addr as u64,
            });
            return Ok(());
        }
        // `&<global>` -- address-of-global pointer init.
        if self.lex.tk == Token::AndOp as i64 {
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
            if self.lex.tk != Token::Id as i64 {
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
            if self.lex.tk == Token::Brak as i64 {
                self.next()?;
                let n = self.parse_constant_int()?;
                if self.lex.tk != ']' as i64 {
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
            self.warn_at(
                line,
                format!("{reason} in global initializer (var={var_ty}, value={init_ty})"),
            );
        }
        Ok(())
    }
}
