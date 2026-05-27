//! Diagnostic helpers (warnings, errors, type-mismatch checks).
//!
//! Centralises the gcc / clang-shape `<file>:<line>: <kind>: <msg>`
//! formatting plus the lax type-compatibility predicate that
//! [`Compiler::type_warning`] uses to decide whether a mixed
//! pointer / integer / struct assignment is worth surfacing.
//!
//! Warnings are accumulated on `Compiler::warnings` and never fail
//! the compile -- c4 is permissive by design and many idioms
//! (`NULL = 0`, `void *` ~ `char *`) would otherwise drown the
//! output. Errors short-circuit through `C5Error::Compile`.

use super::super::ast::Expr;
use super::super::error::C5Error;
use super::super::op::ScalarLoadKind;
use super::super::token::Ty;
use super::Compiler;
use super::types::{
    UNSIGNED_BIT, is_floating_scalar, is_pointer_ty, is_struct_ty, struct_ptr_depth,
};

impl Compiler {
    /// Append a type-checking / signature-mismatch warning. We never
    /// fail compilation on these -- the codegen has enough info to
    /// keep going, and refusing every type squabble would be hostile
    /// to amalgamated code that almost-but-not-quite agrees with
    /// itself. Callers grab the list off `Program.warnings` after
    /// `compile()`.
    ///
    /// The output shape mirrors gcc / clang:
    ///   `<file>:<line>: warning: <message>`
    /// so jump-to-error in editors works out of the box, and the CLI
    /// can color the `warning:` word when stderr is a TTY.
    pub(super) fn warn_at(&mut self, line: usize, message: alloc::string::String) {
        let file = &self.lex.file;
        self.warnings
            .push(alloc::format!("{file}:{line}: warning: {message}"));
    }

    /// Whether the lexer's current file matches the primary
    /// translation-unit source. Used at declaration sites to set
    /// `Symbol::decl_in_main_source` so the unused-symbol
    /// diagnostics emitted at block / TU exit can skip
    /// declarations that landed via `#include`d headers. When the
    /// caller (`CompileOptions::source_label`) didn't supply a
    /// label, the preprocessor's `"<source>"` placeholder stands
    /// in for the primary file.
    pub(super) fn in_main_source(&self) -> bool {
        let main = if self.source_label.is_empty() {
            "<source>"
        } else {
            self.source_label.as_str()
        };
        self.lex.file == main
    }

    /// Record that the parser just emitted a store to local
    /// symbol `idx`. The push appends `line` to the symbol's
    /// `pending_stores` list and registers the symbol index in
    /// the function-level `pending_store_symbols` set when it
    /// wasn't already present. If the symbol already had pending
    /// stores, the prior values were overwritten without an
    /// intervening read and each line is emitted as a dead-store
    /// diagnostic before the new entry is pushed.
    pub(super) fn record_local_store(&mut self, idx: usize, line: usize) {
        if !self.warn_dead_store
            || !self.symbols[idx].decl_in_main_source
            || self.symbols[idx].address_escaped
            || self.symbols[idx].name.is_empty()
            || self.symbols[idx].name.starts_with('_')
        {
            return;
        }
        let was_empty = self.symbols[idx].pending_stores.is_empty();
        let prior = core::mem::take(&mut self.symbols[idx].pending_stores);
        let name = self.symbols[idx].name.clone();
        for prior_line in prior {
            self.warn_at(
                prior_line,
                alloc::format!("dead store: value assigned to `{name}` is never read"),
            );
        }
        self.symbols[idx].pending_stores.push(line);
        if was_empty && !self.pending_store_symbols.contains(&idx) {
            self.pending_store_symbols.push(idx);
        }
    }

    /// Record that a load of local symbol `idx` tagged the
    /// trailing scalar load. Drops the symbol's pending-store
    /// list -- the value the most recent store wrote was just
    /// consumed.
    pub(super) fn record_local_read(&mut self, idx: usize) {
        if !self.warn_dead_store {
            return;
        }
        if !self.symbols[idx].pending_stores.is_empty() {
            self.symbols[idx].pending_stores.clear();
        }
    }

    /// Conservatively drop every symbol's pending-store list at
    /// a non-terminal control-flow boundary (branch, call).
    /// Without flow analysis, a store followed by a branch may
    /// be live or dead depending on which successor runs;
    /// dropping the entries silently avoids false positives.
    pub(super) fn flush_pending_stores(&mut self) {
        if !self.warn_dead_store {
            return;
        }
        for idx in core::mem::take(&mut self.pending_store_symbols) {
            self.symbols[idx].pending_stores.clear();
        }
    }

    /// Emit one dead-store diagnostic per pending entry, then
    /// clear. Called at function-terminating points (return,
    /// tail-call) where no successor exists -- every
    /// pending store is unambiguously dead because nothing
    /// further runs to read the value.
    pub(super) fn emit_dead_stores_and_flush(&mut self) {
        if !self.warn_dead_store {
            return;
        }
        let drained = core::mem::take(&mut self.pending_store_symbols);
        for idx in drained {
            let sym = &self.symbols[idx];
            if sym.address_escaped
                || sym.name.is_empty()
                || sym.name.starts_with('_')
                || sym.pending_stores.is_empty()
            {
                self.symbols[idx].pending_stores.clear();
                continue;
            }
            let name = sym.name.clone();
            let lines = core::mem::take(&mut self.symbols[idx].pending_stores);
            for line in lines {
                self.warn_at(
                    line,
                    alloc::format!("dead store: value assigned to `{name}` is never read"),
                );
            }
        }
    }

    /// Build a `C5Error::Compile` whose message follows the
    /// gcc / clang-shape convention everything else in this codebase
    /// uses for diagnostics:
    ///   `<file>:<line>: error: <message>`
    /// Pulls `<file>` / `<line>` out of `self.lex` so call sites
    /// don't have to thread them through every `format!`.
    pub(super) fn compile_err(&self, message: impl AsRef<str>) -> C5Error {
        C5Error::Compile(super::super::error::fmt_compile_err(
            &self.lex.file,
            self.lex.line,
            message.as_ref(),
        ))
    }

    /// Same shape as [`Self::compile_err`] but lets the caller pin
    /// the line to a value that isn't the lexer's current one --
    /// useful when a diagnostic refers back to where a structure /
    /// function / argument *started*, not where the parser noticed
    /// the problem.
    pub(super) fn compile_err_at(&self, line: usize, message: impl AsRef<str>) -> C5Error {
        C5Error::Compile(super::super::error::fmt_compile_err(
            &self.lex.file,
            line,
            message.as_ref(),
        ))
    }

    /// Test whether `actual` is assignable / passable where `declared`
    /// is expected. Returns a human-readable warning string when they
    /// don't match under badc's rules; `None` when they do.
    ///
    /// Compatibility is intentionally lax -- c4 itself does no checking,
    /// so jumping straight to ISO-C strictness would drown the suite.
    /// What we *do* catch:
    ///   * pointer <-> non-zero scalar (one side a pointer, the other an
    ///     integer that isn't a literal 0)
    ///   * struct of different concrete types
    ///   * struct value vs anything non-struct
    ///
    /// What we deliberately *don't* catch (yet):
    ///   * pointer base mismatch (`int*` <-> `char*`); both pointers, both
    ///     fit in a register, common in c5 idioms
    ///   * char <-> int width difference; c convention
    ///
    /// `actual_is_zero_literal` is a hint from the caller -- when an
    /// expression compiles to exactly `Imm 0`, treat the value as the
    /// NULL pointer for the purposes of this check.
    pub(super) fn type_warning(
        declared: i64,
        actual: i64,
        actual_is_zero_literal: bool,
    ) -> Option<&'static str> {
        Self::type_warning_with_flags(declared, actual, actual_is_zero_literal, false)
    }

    /// Like [`Self::type_warning`] but with an extra `actual_is_untyped_call`
    /// flag. When set, the actual rvalue came from an indirect
    /// call whose return type the dialect can't track -- silence
    /// pointer-vs-int mismatches in either direction since the
    /// register value is preserved bit-for-bit at the assignment
    /// store regardless of the tag.
    pub(super) fn type_warning_with_flags(
        declared: i64,
        actual: i64,
        actual_is_zero_literal: bool,
        actual_is_untyped_call: bool,
    ) -> Option<&'static str> {
        if declared == actual {
            return None;
        }
        if actual_is_untyped_call {
            // Indirect call's defaulted return type. The call
            // leaves the full 64-bit register value intact, so
            // pointer-vs-int doesn't truncate anything in
            // practice. Quiet either direction.
            let decl_is_ptr = is_pointer_ty(declared);
            let act_is_ptr = is_pointer_ty(actual);
            if (decl_is_ptr && !act_is_ptr) || (!decl_is_ptr && act_is_ptr) {
                return None;
            }
            // Also accept struct-pointer <-> int the same way.
            if is_struct_ty(declared) && struct_ptr_depth(declared) > 0 && !act_is_ptr {
                return None;
            }
        }
        let decl_is_struct = is_struct_ty(declared);
        let act_is_struct = is_struct_ty(actual);
        let decl_is_ptr = is_pointer_ty(declared);
        let act_is_ptr = is_pointer_ty(actual);

        // C's `void *` rule: a pointer to `char` (which c5 uses as
        // its `void *`) is freely interconvertible with any other
        // pointer type. The dialect's headers declare libc functions
        // like `memset(char *, int, int)` and `malloc -> char *`;
        // real-world C routinely passes struct pointers to memset
        // and assigns malloc's result to struct* variables. Without
        // this rule every such site fires "incompatible struct
        // types" / "pointer assigned to integer" noise.
        let char_ptr = (Ty::Char as i64) + (Ty::Ptr as i64);
        // Strip UNSIGNED_BIT before comparing: `char *` (which c5
        // treats as unsigned), `signed char *`, and `unsigned char *`
        // are all interchangeable here -- the compatibility rule
        // is "is this any kind of byte pointer?", not "do the
        // signedness tags line up".
        let decl_is_char_ptr = decl_is_ptr && (declared & !UNSIGNED_BIT) == char_ptr;
        let act_is_char_ptr = act_is_ptr && (actual & !UNSIGNED_BIT) == char_ptr;
        if decl_is_char_ptr && act_is_ptr {
            return None;
        }
        if act_is_char_ptr && decl_is_ptr {
            return None;
        }

        // Struct types must match exactly (when one side is a struct).
        if decl_is_struct || act_is_struct {
            // Already returned None above when declared == actual; if we
            // reach here, the struct sides differ. But allow struct
            // pointer vs untyped 0 (NULL).
            if (decl_is_ptr && actual_is_zero_literal) || (act_is_ptr && declared == 0) {
                return None;
            }
            return Some("incompatible struct types");
        }

        match (decl_is_ptr, act_is_ptr) {
            // Both pointers (any base/depth) -- fine.
            (true, true) => None,
            // Pointer <-> literal 0: NULL idiom.
            (true, false) if actual_is_zero_literal => None,
            // Pointer <-> non-zero integer: warn.
            (true, false) => Some("integer assigned to pointer"),
            (false, true) => Some("pointer assigned to integer"),
            // Both numeric (char vs int) -- c convention, silent.
            (false, false) => None,
        }
    }

    /// Reconcile mixed int/float operands for an arithmetic /
    /// comparison op so the matching FP op can run. Two shapes
    /// need a lift:
    ///   * LHS float, RHS int: RHS is in `a`; apply the int-to-
    ///     float cast in place to lift it to f64.
    ///   * LHS int, RHS float: LHS is on the c5 stack and `a`
    ///     holds the float RHS. Spill RHS to a temp through the
    ///     store-local emit, recover LHS into `a` via `Imm 0;
    ///     Or` (Or pops the stack into `a`), lift LHS through
    ///     int-to-float, push, then reload RHS into `a`. Net
    ///     effect mirrors the float-float pattern.
    ///
    /// Returns `Ok(())` for both-float and both-int cases (no
    /// emit). The caller's `is_floating_scalar(t) ||
    /// is_floating_scalar(self.ty)` gate decides whether to use
    /// the FP op afterwards; on return `self.ty` is the lifted
    /// RHS's type when a lift happened.
    pub(super) fn require_both_float(&mut self, lhs: i64, _op: &str) -> Result<(), C5Error> {
        let lhs_is_fp = is_floating_scalar(lhs);
        let rhs_is_fp = is_floating_scalar(self.ty);
        if lhs_is_fp == rhs_is_fp {
            return Ok(());
        }
        if lhs_is_fp && !rhs_is_fp {
            self.ast_fpcast();
            self.ty = lhs;
            // Dual-emit: wrap `ast_acc` in an `Expr::Cast { to_ty
            // = lhs }` so the walker sees the implicit lift and
            // emits the matching `Inst::FpCast(IntToFp)` before
            // the wrapping FP binop runs.
            self.ast_apply_assign_conv(lhs);
            return Ok(());
        }
        // !lhs_is_fp && rhs_is_fp -- spill float RHS, lift int LHS.
        // Snapshot the AST operands first: lhs is the int sitting
        // on the parser-side vstack, rhs is the float currently
        // in `ast_acc`. The intermediate store-local / immediate /
        // Or / int-to-float / push / address-of-local / load
        // emits route through the AST tracker and pop / push the
        // AST vstack the outer call must preserve. Drain the outer
        // vstack into a side buffer, push a single `None` sentinel
        // for the inner ops to consume, run the sequence, then
        // restore.
        // Finally rebuild the AST so the walker sees
        // `Expr::Cast { lhs_int_ast, to_ty = rhs_fp }` on the
        // vstack and the rhs float ast back on `ast_acc`.
        let lhs_ast = self.ast_vstack.pop().flatten();
        let rhs_ast = self.ast_acc.take();
        let saved_vstack: alloc::vec::Vec<_> = self.ast_vstack.drain(..).collect();
        self.ast_vstack.push(None);
        self.loc_offs += 1;
        if self.loc_offs > self.max_loc_offs {
            self.max_loc_offs = self.loc_offs;
        }
        let rhs_temp = -self.loc_offs;
        let rhs_ty = self.ty;
        self.mark_emit_other();
        // Pop LHS off the c5 stack into `a` via Imm 0; Or.
        self.emit_imm(0);
        self.ast_binop(crate::c5::ir::BinOp::Or);
        self.ast_fpcast();
        self.ast_psh();
        // Reload RHS into `a`.
        self.emit_lea(rhs_temp);
        self.emit_op(ScalarLoadKind::Li);
        self.ty = rhs_ty;
        self.ast_vstack.clear();
        self.ast_vstack.extend(saved_vstack);
        if let Some(lhs_int) = lhs_ast {
            let pos = self.ast_src_pos();
            let casted = self.ast.push_expr(
                Expr::Cast {
                    child: lhs_int,
                    to_ty: rhs_ty,
                },
                pos,
            );
            self.ast_vstack.push(Some(casted));
        } else {
            self.ast_vstack.push(None);
        }
        self.ast_acc = rhs_ast;
        Ok(())
    }
}
