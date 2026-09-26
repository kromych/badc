//! Diagnostic helpers (warnings, errors, type-mismatch checks).
//!
//! Centralises the gcc / clang-shape `<file>:<line>: <kind>: <msg>`
//! formatting plus the lax type-compatibility predicate that
//! [`Compiler::type_warning`] uses to decide whether a mixed
//! pointer / integer / struct assignment is worth surfacing.
//!
//! Warnings go through `Compiler::sink` and never fail the compile
//! at their site.

use super::super::ast::{BlockItem, Expr, ExprId, Stmt, StmtId, UnOp};
use super::super::diag::{Code, Loc};
use super::super::error::C5Error;
use super::super::ir::BinOp;
use super::super::ir::imm_safe_binop;
use super::super::irgen::fold_int_binop;
use super::super::token::Ty;
use super::Compiler;
use super::types::{
    UNSIGNED_BIT, bool_ptr_depth, is_bool_ty, is_floating_scalar, is_pointer_ty, is_struct_ty,
    is_struct_value_ty, is_void_ty, strip_unsigned, struct_ptr_depth, unqualified_object_ty,
};

/// A target-vs-source type mismatch reported by
/// [`Compiler::type_warning_with_flags`]. `no_conversion` marks the
/// mismatches C99 defines no conversion for: those are constraint
/// violations the call site rejects, the rest stay warnings.
#[derive(Clone, Copy)]
pub(super) struct TypeMismatch {
    pub code: Code,
    pub reason: &'static str,
    pub no_conversion: bool,
}

impl TypeMismatch {
    fn warn(code: Code, reason: &'static str) -> Option<Self> {
        Some(Self {
            code,
            reason,
            no_conversion: false,
        })
    }
}

/// The C99 6.2.5 category of an operand.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Operand {
    Integer,
    Floating,
    Pointer,
    /// `void`, a structure or union, or a GNU vector.
    Other,
}

impl Operand {
    fn arithmetic(self) -> bool {
        matches!(self, Operand::Integer | Operand::Floating)
    }
}

/// An operand category a C99 constraint requires.
#[derive(Clone, Copy)]
pub(super) enum Category {
    Scalar,
    Arithmetic,
    Integer,
}

impl Category {
    fn admits(self, operand: Operand) -> bool {
        match self {
            Category::Scalar => operand != Operand::Other,
            Category::Arithmetic => operand.arithmetic(),
            Category::Integer => operand == Operand::Integer,
        }
    }
}

/// C99 6.5.5-6.5.14 and 6.5.16.2p1-2: whether binary `op`, or `op=` when
/// `compound`, takes these operands. A pointer compared with an integer is
/// accepted, as existing practice has it.
fn binary_operands_fit(op: &str, compound: bool, l: Operand, r: Operand) -> bool {
    use Operand::{Integer, Pointer};
    let arithmetic = l.arithmetic() && r.arithmetic();
    match op {
        "*" | "/" => arithmetic,
        "%" | "<<" | ">>" | "&" | "^" | "|" => l == Integer && r == Integer,
        "+" | "-" if compound => arithmetic || (l == Pointer && r == Integer),
        "+" => arithmetic || matches!((l, r), (Pointer, Integer) | (Integer, Pointer)),
        "-" => arithmetic || (l == Pointer && matches!(r, Integer | Pointer)),
        "&&" | "||" => Category::Scalar.admits(l) && Category::Scalar.admits(r),
        _ => arithmetic || matches!((l, r), (Pointer, Integer | Pointer) | (Integer, Pointer)),
    }
}

impl Compiler {
    /// C99 6.9.1p12: reaching the closing brace of a value-returning
    /// function without executing a `return value;` leaves the value
    /// indeterminate -- undefined behavior if the caller uses it, but
    /// not a constraint violation. gcc and clang diagnose it with a
    /// warning, not an error, and the codegen synthesizes a `return 0`
    /// for the fall-through, so this is a warning too. `main` is exempt
    /// (5.1.2.2.3 supplies a default 0).
    ///
    /// The analysis reports a fall-through only when control certainly
    /// reaches the end, and only with the noreturn information available
    /// to it: a function whose last statement is a call into a
    /// `_Noreturn` callee does not fall through, but one ending in a
    /// callee whose noreturn attribute is hidden behind a macro that
    /// expands to nothing (no `__GNUC__` / `__clang__`) cannot be seen
    /// as noreturn, so a hard error would reject valid code. Constructs
    /// it does not model precisely -- `switch`, `goto`, labels -- are
    /// treated as not falling through, so the diagnostic never fires on
    /// a function that uses them.
    pub(super) fn check_non_void_fall_off(&mut self) {
        if self.current_func_returns_void || self.current_function_name == "main" {
            return;
        }
        let Some(body) = self.ast.body else {
            return;
        };
        if self.stmt_may_fall_through(body) {
            let line = self.lex.line;
            let name = self.current_function_name.clone();
            self.warn_at(
                Code::RETURN_TYPE,
                line,
                alloc::format!(
                    "control reaches end of non-void function `{name}` \
                     without returning a value"
                ),
            );
        }
    }

    /// True when control may reach the statement immediately after
    /// `id`. Returns `false` for any construct whose exit the analysis
    /// does not model precisely, so the caller's diagnostic stays
    /// conservative (no false positives).
    fn stmt_may_fall_through(&self, id: StmtId) -> bool {
        match self.ast.stmt(id) {
            Stmt::Return(_)
            | Stmt::Goto(_)
            | Stmt::CleanupJump { .. }
            | Stmt::Break
            | Stmt::Continue => false,
            // A call to a `_Noreturn` function does not reach its
            // continuation; any other expression statement does.
            Stmt::Expr(e) => !self.expr_is_noreturn_call(*e),
            Stmt::Decl(_) | Stmt::Asm { .. } => true,
            Stmt::Compound(items) => {
                // Control reaches the block's end iff it flows through
                // every item. The first item that cannot fall through
                // makes the rest unreachable.
                let mut reachable = true;
                for item in items {
                    if !reachable {
                        break;
                    }
                    reachable = match item {
                        BlockItem::Stmt(s) => self.stmt_may_fall_through(*s),
                        BlockItem::Decl(_) => true,
                    };
                }
                reachable
            }
            Stmt::If { then_s, else_s, .. } => {
                let then_ft = self.stmt_may_fall_through(*then_s);
                match else_s {
                    Some(e) => then_ft || self.stmt_may_fall_through(*e),
                    // No else: the false branch reaches the continuation.
                    None => true,
                }
            }
            // A `while` checks its condition first, so it falls through
            // whenever the condition is not a non-zero constant, or a
            // `break` targets it.
            Stmt::While { cond, body } => {
                !self.expr_is_nonzero_const(*cond) || self.stmt_has_loop_break(*body)
            }
            // A `do`/`while` runs its body before the condition, so it
            // reaches the exit test only if the body falls through to it.
            // A body that always returns never reaches `while (cond)`, so
            // the loop falls through only via a targeting `break`. This is
            // the `do { ...; return; } while (0)` macro idiom.
            Stmt::DoWhile { body, cond } => {
                (self.stmt_may_fall_through(*body) && !self.expr_is_nonzero_const(*cond))
                    || self.stmt_has_loop_break(*body)
            }
            Stmt::For { cond, body, .. } => {
                let infinite = cond.is_none_or(|c| self.expr_is_nonzero_const(c));
                !infinite || self.stmt_has_loop_break(*body)
            }
            // Switch / Labeled / Case / Default: control flow not
            // modelled precisely. Treat as not falling through so the
            // diagnostic never fires on a function that uses them.
            _ => false,
        }
    }

    /// True when `e` does not return to its continuation: a direct call
    /// to a `_Noreturn` function, or `__builtin_trap()`.
    fn expr_is_noreturn_call(&self, e: ExprId) -> bool {
        match self.ast.expr(e) {
            Expr::Call { callee, .. } => {
                let Expr::Ident { sym, .. } = self.ast.expr(*callee) else {
                    return false;
                };
                self.symbols
                    .get(*sym as usize)
                    .is_some_and(|s| s.is_noreturn)
            }
            Expr::Intrinsic { kind, .. } => *kind == crate::c5::op::Intrinsic::Trap as i64,
            _ => false,
        }
    }

    /// True when `e` is a non-zero integer constant -- an always-taken
    /// loop condition. Looks through a cast (`while ((Bool)1)`, the
    /// common boolean-macro spelling): a cast of a constant is still a
    /// constant. Treating a cast that happens to truncate to zero as
    /// non-zero would only miss a fall-through, never invent one.
    fn expr_is_nonzero_const(&self, e: ExprId) -> bool {
        match self.ast.expr(e) {
            Expr::IntLit { val, .. } => *val != 0,
            Expr::Cast { child, .. } => self.expr_is_nonzero_const(*child),
            _ => false,
        }
    }

    /// C99 6.3.2.3p3: an integer constant expression with the value 0,
    /// or such an expression cast to `void *`, is a null pointer
    /// constant. Only literal-rooted operands fold, so an operand
    /// naming an object -- `(void *)((long)x * 0l)` -- is correctly not
    /// a null pointer constant even though it evaluates to zero.
    pub(super) fn expr_is_null_pointer_constant(&self, e: ExprId) -> bool {
        self.expr_const_int(e) == Some(0)
    }

    /// Fold a literal-rooted integer constant expression. Casts are
    /// looked through without applying their conversion: the callers
    /// only compare against zero, and a cast that truncates a non-zero
    /// constant to zero is not a null pointer constant in practice.
    pub(super) fn expr_const_int(&self, e: ExprId) -> Option<i64> {
        match self.ast.expr(e) {
            Expr::IntLit { val, .. } => Some(*val),
            Expr::Sizeof(s) => Some(s.size_bytes),
            Expr::Cast { child, .. } => self.expr_const_int(*child),
            Expr::Unary { op, child, ty } => {
                let v = self.expr_const_int(*child)?;
                match op {
                    UnOp::Neg => Some(v.wrapping_neg()),
                    UnOp::BitNot => Some(!v),
                    UnOp::LogNot => Some((v == 0) as i64),
                    UnOp::Renormalize { .. } => {
                        let bytes = self.size_of_type(*ty);
                        Some(super::types::narrow_const_int(bytes, false, false, v as i128) as i64)
                    }
                    UnOp::AddrOf | UnOp::Deref => None,
                }
            }
            Expr::Binary { op, lhs, rhs, .. } => {
                // `/` and `%` are integer constant expressions (C99 6.6)
                // but are not immediate-foldable, so they are admitted
                // alongside the imm-safe set. A zero divisor is undefined
                // and thus not a constant.
                let divmod = matches!(*op, BinOp::Div | BinOp::Mod | BinOp::Divu | BinOp::Modu);
                if !imm_safe_binop(*op) && !divmod {
                    return None;
                }
                let l = self.expr_const_int(*lhs)?;
                let r = self.expr_const_int(*rhs)?;
                if divmod && r == 0 {
                    return None;
                }
                Some(fold_int_binop(*op, l, r))
            }
            // A conditional with a constant condition folds to its selected
            // arm (C99 6.6p3 exempts the unevaluated arm), so the
            // `__builtin_choose_expr`-style constant max/min idioms remain
            // null-pointer-constant material.
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                ..
            } => {
                let c = self.expr_const_int(*cond)?;
                self.expr_const_int(if c != 0 { *then_e } else { *else_e })
            }
            _ => None,
        }
    }

    /// True when the loop body contains a `break` that targets this
    /// loop. Descent stops at a nested loop or switch, which captures
    /// its own `break`.
    fn stmt_has_loop_break(&self, id: StmtId) -> bool {
        match self.ast.stmt(id) {
            Stmt::Break => true,
            Stmt::While { .. } | Stmt::DoWhile { .. } | Stmt::For { .. } | Stmt::Switch { .. } => {
                false
            }
            Stmt::Compound(items) => items.iter().any(|it| match it {
                BlockItem::Stmt(s) => self.stmt_has_loop_break(*s),
                BlockItem::Decl(_) => false,
            }),
            Stmt::If { then_s, else_s, .. } => {
                self.stmt_has_loop_break(*then_s)
                    || else_s.is_some_and(|e| self.stmt_has_loop_break(e))
            }
            Stmt::Labeled { body, .. } | Stmt::Case { body, .. } | Stmt::Default { body, .. } => {
                self.stmt_has_loop_break(*body)
            }
            _ => false,
        }
    }

    /// Report `code` at `line`. The sink resolves the level from the
    /// command line and the pragmas in effect at that position and
    /// drops the diagnostic when it is ignored; what survives lands on
    /// `Program.warnings`. Raising one to an error does not unwind --
    /// the driver fails the unit at the phase boundary.
    pub(super) fn warn_at(&mut self, code: Code, line: usize, message: alloc::string::String) {
        let (loc, source) = self.locate(line);
        self.sink.emit_with_source(code, Some(loc), message, source);
    }

    /// Report a constraint violation the parser recovers from: an
    /// error by default, lowered by `-Wno-error=<name>` or `-Wno-<name>`
    /// and the diagnostic pragmas. `Err` only at the error level, so
    /// the site continues when the user lowered it.
    pub(super) fn report_at(
        &mut self,
        code: Code,
        line: usize,
        message: alloc::string::String,
    ) -> Result<(), C5Error> {
        let (loc, source) = self.locate(line);
        self.sink
            .report_with_source(code, Some(loc), message, source)
    }

    /// The position `line` reports at -- with the unit offset the
    /// diagnostic pragmas resolve on -- and the source text it echoes.
    fn locate(&self, line: usize) -> (Loc, Option<alloc::string::String>) {
        let loc = match self.lex.line_offset(line) {
            Some(offset) => Loc::in_unit(self.lex.file.clone(), line as u32, offset),
            None => Loc::new(self.lex.file.clone(), line as u32),
        };
        let source = self
            .lex
            .line_text_by_number(line)
            .filter(|s| !s.is_empty())
            .map(alloc::string::ToString::to_string);
        (loc, source)
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
            || !self.symbols[idx].binding.decl_in_main_source
            || self.symbols[idx].binding.address_escaped
            || self.symbols[idx].name.is_empty()
            || self.symbols[idx].name.starts_with('_')
        {
            return;
        }
        let was_empty = self.symbols[idx].binding.pending_stores.is_empty();
        let prior = core::mem::take(&mut self.symbols[idx].binding.pending_stores);
        let name = self.symbols[idx].name.clone();
        for prior_line in prior {
            self.warn_at(
                Code::DEAD_STORE,
                prior_line,
                alloc::format!("dead store: value assigned to `{name}` is never read"),
            );
        }
        self.symbols[idx].binding.pending_stores.push(line);
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
        if !self.symbols[idx].binding.pending_stores.is_empty() {
            self.symbols[idx].binding.pending_stores.clear();
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
            self.symbols[idx].binding.pending_stores.clear();
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
        for idx in core::mem::take(&mut self.pending_store_symbols) {
            self.report_dead_stores(idx);
        }
    }

    /// Report the pending stores of the bindings a closing scope ends, whose objects die.
    pub(super) fn emit_scope_dead_stores(&mut self, scope: &[super::stmt::BlockShadow]) {
        if !self.warn_dead_store {
            return;
        }
        for b in scope {
            self.report_dead_stores(b.idx);
        }
    }

    fn report_dead_stores(&mut self, idx: usize) {
        let sym = &self.symbols[idx];
        if sym.binding.address_escaped || sym.name.is_empty() || sym.name.starts_with('_') {
            self.symbols[idx].binding.pending_stores.clear();
            return;
        }
        let name = sym.name.clone();
        for line in core::mem::take(&mut self.symbols[idx].binding.pending_stores) {
            self.warn_at(
                Code::DEAD_STORE,
                line,
                alloc::format!("dead store: value assigned to `{name}` is never read"),
            );
        }
    }

    /// Bound one level of parser recursion. Every recursive cycle in
    /// the grammar (expressions, constant expressions, declarators,
    /// initializer lists, statements) passes through an entry wrapped
    /// in this helper, so one counter bounds them all and
    /// pathological nesting gets a diagnostic instead of exhausting
    /// the native stack. C99 5.2.4.1 requires 63 nesting levels for
    /// expressions / declarators and 127 for blocks; 512 stays well
    /// above any real source (and above Clang's default of 256) while
    /// capping the worst-case native stack the driver must reserve.
    pub(super) fn with_nesting<T>(
        &mut self,
        construct: &'static str,
        f: impl FnOnce(&mut Self) -> Result<T, C5Error>,
    ) -> Result<T, C5Error> {
        const MAX_NEST_DEPTH: usize = 512;
        if self.nest_depth >= MAX_NEST_DEPTH {
            return Err(
                self.compile_err(Code::LIMIT, alloc::format!("{construct} nesting too deep"))
            );
        }
        self.nest_depth += 1;
        let r = f(self);
        self.nest_depth -= 1;
        r
    }

    /// A hard error at the lexer's current line, rendered as
    /// `<file>:<line>: error: <message> [B<code>]` with the source line
    /// echoed beneath it. `code` names the row the failure falls in.
    pub(super) fn compile_err(&self, code: Code, message: impl AsRef<str>) -> C5Error {
        self.compile_err_line(code, self.lex.line, message.as_ref())
    }

    /// The `-- try #include` suffix for a name a bundled header declares;
    /// empty for any other name.
    pub(super) fn include_hint(&self, name: &str) -> alloc::string::String {
        match super::super::headers::header_declaring(name) {
            Some(h) => alloc::format!(" -- try `#include <{h}>`"),
            None => alloc::string::String::new(),
        }
    }

    fn compile_err_line(&self, code: Code, line: usize, message: &str) -> C5Error {
        let (loc, source) = self.locate(line);
        let diagnostic = super::super::diag::Diagnostic::new(
            code,
            super::super::diag::Level::Error,
            Some(loc),
            message,
        )
        .with_source_line(source);
        C5Error::of(diagnostic)
    }

    /// [`Self::compile_err`] pinned to `line` rather than the lexer's
    /// current one: where the diagnostic refers back to where a
    /// structure, function or argument started.
    pub(super) fn compile_err_at(
        &self,
        code: Code,
        line: usize,
        message: impl AsRef<str>,
    ) -> C5Error {
        self.compile_err_line(code, line, message.as_ref())
    }

    /// C99 6.3.2.2p1: a `void` expression has no value to read.
    pub(super) fn reject_void_value(&self, ty: i64) -> Result<(), C5Error> {
        if is_void_ty(ty) {
            return Err(self.compile_err(Code::VOID_VALUE, "`void` expression used as a value"));
        }
        Ok(())
    }

    /// The category of an operand of type `ty`: a multi-dimensional array
    /// decays to a pointer and `__int128` is an integer type.
    pub(super) fn operand(&self, ty: i64) -> Operand {
        if is_struct_value_ty(ty) {
            if self.is_int128_ty(ty) {
                return Operand::Integer;
            }
            let def = self.structs.get(super::types::struct_id_of(ty));
            return if def.is_some_and(|s| s.is_array) {
                Operand::Pointer
            } else {
                Operand::Other
            };
        }
        if is_void_ty(ty) {
            Operand::Other
        } else if is_pointer_ty(ty) {
            Operand::Pointer
        } else if is_floating_scalar(ty) {
            Operand::Floating
        } else {
            Operand::Integer
        }
    }

    /// Reject `what`, of type `ty`, outside `category`.
    pub(super) fn require_category(
        &self,
        ty: i64,
        category: Category,
        code: Code,
        what: &str,
    ) -> Result<(), C5Error> {
        if category.admits(self.operand(ty)) {
            return Ok(());
        }
        let got = super::types::format_type(ty, &self.structs);
        let want = match category {
            Category::Scalar => "a scalar",
            Category::Arithmetic => "an arithmetic",
            Category::Integer => "an integer",
        };
        Err(self.compile_err(
            code,
            alloc::format!("{what} has type `{got}`, not {want} type"),
        ))
    }

    /// Reject binary `op`, or `op=` when `compound`, on these operand types.
    pub(super) fn require_operands(
        &self,
        op: &str,
        compound: bool,
        lhs_ty: i64,
        rhs_ty: i64,
    ) -> Result<(), C5Error> {
        if binary_operands_fit(op, compound, self.operand(lhs_ty), self.operand(rhs_ty)) {
            return Ok(());
        }
        let l = super::types::format_type(lhs_ty, &self.structs);
        let r = super::types::format_type(rhs_ty, &self.structs);
        let name = if compound {
            alloc::format!("`{op}=`")
        } else {
            alloc::format!("binary `{op}`")
        };
        Err(self.compile_err(
            Code::INVALID_OPERANDS,
            alloc::format!("invalid operands to {name} (`{l}` and `{r}`)"),
        ))
    }

    pub(super) fn type_warning(
        structs: &[super::StructDef],
        declared: i64,
        actual: i64,
        actual_is_zero_literal: bool,
    ) -> Option<TypeMismatch> {
        Self::type_warning_with_flags(structs, declared, actual, actual_is_zero_literal, false)
    }

    /// Like [`Self::type_warning`] but with an extra `actual_is_untyped_call`
    /// flag. When set, the actual rvalue came from an indirect
    /// call whose return type the dialect can't track -- silence
    /// pointer-vs-int mismatches in either direction since the
    /// register value is preserved bit-for-bit at the assignment
    /// store regardless of the tag.
    pub(super) fn type_warning_with_flags(
        structs: &[super::StructDef],
        declared: i64,
        actual: i64,
        actual_is_zero_literal: bool,
        actual_is_untyped_call: bool,
    ) -> Option<TypeMismatch> {
        // C99 6.5.16.1p1: the target may add qualifiers, and a
        // qualifier on either object is not part of the comparison.
        let declared = unqualified_object_ty(declared);
        let actual = unqualified_object_ty(actual);
        if declared == actual {
            return None;
        }
        let decl_is_struct = is_struct_ty(declared);
        let act_is_struct = is_struct_ty(actual);
        let decl_is_ptr = is_pointer_ty(declared);
        let act_is_ptr = is_pointer_ty(actual);
        // An indirect call's defaulted return type leaves the full
        // register value intact, so pointer-vs-integer is quiet in
        // either direction.
        if actual_is_untyped_call && decl_is_ptr != act_is_ptr {
            return None;
        }

        // C99 6.5.16.1p1 admits a pointer as the right operand when the
        // left has type `_Bool`; 6.3.1.2 converts it to 0 or 1.
        if is_bool_ty(declared) && bool_ptr_depth(declared) == 0 && act_is_ptr {
            return None;
        }

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
        let decl_is_char_ptr = decl_is_ptr && strip_unsigned(declared) == char_ptr;
        let act_is_char_ptr = act_is_ptr && strip_unsigned(actual) == char_ptr;
        if decl_is_char_ptr && act_is_ptr {
            return None;
        }
        if act_is_char_ptr && decl_is_ptr {
            return None;
        }

        // A pointer-to-array (aggregate-backed) accepts the flat pointer
        // spellings of the same shape -- `&arr` and a decayed row carry
        // the element-pointer tag -- so any pointer on the other side is
        // quiet, mirroring the byte-pointer rule above. Real
        // pointer-vs-integer mismatches still warn below.
        let is_array_agg_ptr = |ty: i64| {
            is_struct_ty(ty)
                && struct_ptr_depth(ty) > 0
                && structs
                    .get(super::types::struct_id_of(ty))
                    .is_some_and(|s| s.is_array)
        };
        if is_array_agg_ptr(declared) && act_is_ptr {
            return None;
        }
        if is_array_agg_ptr(actual) && decl_is_ptr {
            return None;
        }

        // The GCC 128-bit integer against an integer or pointer is a
        // value conversion (C99 6.3.1.3), not a struct mismatch.
        let is_int128 = |ty: i64| {
            is_struct_value_ty(ty)
                && structs
                    .get(super::types::struct_id_of(ty))
                    .is_some_and(|s| s.name == "__int128")
        };
        // Both sides 128-bit: the tags differ only in signedness, which is
        // an integer conversion, so this is not a mismatch at all.
        if is_int128(declared) && is_int128(actual) {
            return None;
        }
        let decl_is_object = is_struct_value_ty(declared);
        let act_is_object = is_struct_value_ty(actual);
        if is_int128(declared) != is_int128(actual) && !(decl_is_object && act_is_object) {
            return None;
        }

        // A pointer against a scalar is the same defect whatever the
        // pointee, so it is decided ahead of the aggregate rules; an
        // aggregate object on the non-pointer side still reaches them.
        if decl_is_ptr != act_is_ptr && !decl_is_object && !act_is_object {
            return match (decl_is_ptr, actual_is_zero_literal) {
                // A null pointer constant (C99 6.3.2.3p3).
                (true, true) => None,
                (true, false) => {
                    TypeMismatch::warn(Code::INT_CONVERSION, "integer assigned to pointer")
                }
                (false, _) => {
                    TypeMismatch::warn(Code::INT_CONVERSION, "pointer assigned to integer")
                }
            };
        }

        // Struct types must match exactly (when one side is a struct).
        if decl_is_struct || act_is_struct {
            // The signedness marker is not part of an aggregate's identity:
            // two tags naming the same aggregate at the same pointer depth
            // differ only by the C99 6.3.1.3 integer conversion, which the
            // scalar path does not report for a pointee either. Only that
            // marker is dropped -- a named address space on the pointee is
            // a real difference. The 128-bit integer is the aggregate this
            // reaches.
            if declared & !UNSIGNED_BIT == actual & !UNSIGNED_BIT {
                return None;
            }
            // C99 6.5.16.1p1 offers no conversion involving a structure or
            // union *object*: that is a constraint violation, while the
            // pointer-shaped mismatches do convert and stay warnings. Two
            // aggregate spellings are excluded because the mismatch would
            // not be the source's fault: a value-form array reflects a
            // missed 6.3.2.1p3 decay, and a union target keeps warning
            // severity (the call-argument path resolves `transparent_union`
            // acceptance before this reason is reported).
            let def_of = |ty: i64| structs.get(super::types::struct_id_of(ty));
            let is_array_agg = |ty: i64| def_of(ty).is_some_and(|s| s.is_array);
            let object_mismatch = (decl_is_object || act_is_object)
                && !is_array_agg(declared)
                && !is_array_agg(actual)
                && !def_of(declared).is_some_and(|s| s.is_union);
            return Some(TypeMismatch {
                code: Code::INCOMPATIBLE_STRUCT_TYPES,
                reason: "incompatible struct types",
                no_conversion: object_mismatch,
            });
        }

        // Two pointers with scalar pointees, or two arithmetic scalars:
        // the conversion is silent.
        None
    }

    /// GNU `transparent_union`: a parameter whose type is a union
    /// honoring the attribute accepts an argument compatible with any
    /// member (a null pointer constant included, for pointer members).
    /// Returns the first matching member's type -- the argument converts
    /// to it, and the honor rule makes its storage the union's -- or
    /// `None` when the parameter is no transparent union, the argument
    /// is the union itself, or nothing matches.
    pub(super) fn transparent_union_member(
        structs: &[super::StructDef],
        declared: i64,
        actual: i64,
        actual_is_zero_literal: bool,
    ) -> Option<i64> {
        let declared = unqualified_object_ty(declared);
        if !is_struct_value_ty(declared) || declared == unqualified_object_ty(actual) {
            return None;
        }
        let def = structs.get(super::types::struct_id_of(declared))?;
        if !def.is_union || !def.is_transparent_union {
            return None;
        }
        def.fields
            .iter()
            .find(|f| {
                f.array_size == 0
                    && f.bit_width == 0
                    && Self::type_warning(structs, f.ty, actual, actual_is_zero_literal).is_none()
            })
            .map(|f| f.ty)
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
        let saved_vstack = core::mem::take(&mut self.ast_vstack);
        self.ast_vstack.push(None);
        let rhs_temp = self.reserve_slots(1);
        let rhs_ty = self.ty;
        self.mark_emit_other();
        // Pop LHS off the c5 stack into `a` via Imm 0; Or.
        self.emit_imm(0);
        self.ast_binop(crate::c5::ir::BinOp::Or);
        self.ast_fpcast();
        self.ast_psh();
        // Reload RHS into `a`.
        self.emit_lea(rhs_temp);
        self.mark_emit_other();
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
