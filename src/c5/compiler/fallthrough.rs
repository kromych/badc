//! gcc's `-Wimplicit-fallthrough=5`: a `case` or `default` label that the
//! statement before it reaches by completing normally, unless that
//! statement is a `fallthrough` attribute declaration. Levels 1 to 4 also
//! take a comment as the annotation, and the preprocessor drops comments,
//! so only level 5 is implemented.

use super::super::ast::{BlockItem, Expr, ExprId, Stmt, StmtId};
use super::super::diag::Code;
use super::Compiler;

/// How control leaves a statement: past its end, only by jumps, returns
/// and calls that do not return, or through the `fallthrough` annotation.
#[derive(Clone, Copy, PartialEq)]
enum Exit {
    Falls,
    Leaves,
    Annotated,
}

impl Compiler {
    /// Report each label of the switch body `body` that falls through.
    pub(super) fn check_fallthrough(&mut self, body: StmtId) {
        if !self.sink.may_emit(Code::IMPLICIT_FALLTHROUGH) {
            return;
        }
        let mut lines = alloc::vec::Vec::new();
        self.fallthrough_sites(body, &mut lines);
        for line in lines {
            let text = "this statement may fall through".into();
            self.warn_at(Code::IMPLICIT_FALLTHROUGH, line as usize, text);
        }
    }

    /// The lines of the statements in `id` falling into a label of its switch.
    fn fallthrough_sites(&self, id: StmtId, out: &mut alloc::vec::Vec<u32>) {
        match self.ast.stmt(id) {
            Stmt::Compound(items) => {
                let stmts: alloc::vec::Vec<StmtId> = items
                    .iter()
                    .filter_map(|i| match i {
                        BlockItem::Stmt(s) => Some(*s),
                        BlockItem::Decl(_) => None,
                    })
                    .collect();
                for (i, pair) in stmts.windows(2).enumerate() {
                    if self.is_label_site(pair[1])
                        && !self.is_empty_label(pair[0])
                        && !self.lands_on_exit(pair[1], i + 2 == stmts.len())
                        && self.exit_of(pair[0]) == Exit::Falls
                    {
                        out.push(self.last_line(pair[0]));
                    }
                }
                for &s in &stmts {
                    self.fallthrough_sites(s, out);
                }
            }
            Stmt::Case { body, .. } | Stmt::Default { body } | Stmt::Labeled { body, .. } => {
                self.fallthrough_sites(*body, out)
            }
            Stmt::If { then_s, else_s, .. } => {
                self.fallthrough_sites(*then_s, out);
                if let Some(e) = else_s {
                    self.fallthrough_sites(*e, out);
                }
            }
            Stmt::While { body, .. } | Stmt::DoWhile { body, .. } | Stmt::For { body, .. } => {
                self.fallthrough_sites(*body, out)
            }
            _ => {}
        }
    }

    fn is_label_site(&self, id: StmtId) -> bool {
        match self.ast.stmt(id) {
            Stmt::Case { .. } | Stmt::Default { .. } => true,
            Stmt::Labeled { body, .. } => self.is_label_site(*body),
            _ => false,
        }
    }

    /// gcc passes over a label whose statement leaves at once by `break`,
    /// `goto` or a bare `return`, and an empty one ending the switch.
    fn lands_on_exit(&self, site: StmtId, last: bool) -> bool {
        match self.ast.stmt(site) {
            Stmt::Case { body, .. } | Stmt::Default { body } | Stmt::Labeled { body, .. } => {
                self.lands_on_exit(*body, last)
            }
            Stmt::Break | Stmt::Goto(_) | Stmt::Return(None) => true,
            Stmt::Compound(items) => last && items.is_empty(),
            _ => false,
        }
    }

    /// A label with an empty statement: nothing runs before the next label.
    fn is_empty_label(&self, id: StmtId) -> bool {
        match self.ast.stmt(id) {
            Stmt::Case { body, .. } | Stmt::Default { body } | Stmt::Labeled { body, .. } => {
                self.is_empty_label(*body)
            }
            Stmt::Compound(items) => items.is_empty() && !self.fallthrough_marks.contains(&id),
            _ => false,
        }
    }

    /// The line of the statement control runs last in `id`.
    fn last_line(&self, id: StmtId) -> u32 {
        match self.ast.stmt(id) {
            Stmt::Case { body, .. }
            | Stmt::Default { body }
            | Stmt::Labeled { body, .. }
            | Stmt::Switch { body, .. } => self.last_line(*body),
            Stmt::Compound(items) => {
                let synthetic = |s: StmtId| {
                    matches!(
                        self.ast.stmt(s),
                        Stmt::ScopeEnd(_) | Stmt::VlaScopeExit { .. }
                    )
                };
                match items.iter().rev().find_map(|i| match i {
                    BlockItem::Stmt(s) if !synthetic(*s) => Some(*s),
                    _ => None,
                }) {
                    Some(s) => self.last_line(s),
                    None => self.ast.stmt_src[id as usize].line,
                }
            }
            _ => self.ast.stmt_src[id as usize].line,
        }
    }

    fn exit_of(&self, id: StmtId) -> Exit {
        if self.fallthrough_marks.contains(&id) {
            return Exit::Annotated;
        }
        let falls = |b: bool| if b { Exit::Falls } else { Exit::Leaves };
        match self.ast.stmt(id) {
            // What follows a statement that leaves is reached only through
            // a label: the scope's end and its cleanups are not.
            Stmt::Compound(items) => items.iter().fold(Exit::Falls, |exit, item| match item {
                BlockItem::Stmt(s)
                    if exit == Exit::Falls
                        || matches!(
                            self.ast.stmt(*s),
                            Stmt::Case { .. } | Stmt::Default { .. } | Stmt::Labeled { .. }
                        ) =>
                {
                    self.exit_of(*s)
                }
                _ => exit,
            }),
            Stmt::Expr(e) => falls(!self.never_returns(*e)),
            Stmt::If { then_s, else_s, .. } => {
                let then_exit = self.exit_of(*then_s);
                let else_exit = else_s.map_or(Exit::Falls, |e| self.exit_of(e));
                if then_exit == Exit::Falls || else_exit == Exit::Falls {
                    Exit::Falls
                } else {
                    then_exit.max_leaving(else_exit)
                }
            }
            // gcc's lowering ends an endless loop in its back edge, whatever
            // `break` it holds, and a `do` loop in its body's last statement.
            Stmt::While { cond, .. } => falls(!self.always_true(Some(*cond))),
            Stmt::For { cond, .. } => falls(!self.always_true(*cond)),
            Stmt::DoWhile { body, cond } => {
                falls(!self.always_true(Some(*cond)) && self.exit_of(*body) == Exit::Falls)
            }
            Stmt::Switch { body, .. } => {
                falls(self.breaks_out(*body) || self.exit_of(*body) == Exit::Falls)
            }
            Stmt::Case { body, .. } | Stmt::Default { body } | Stmt::Labeled { body, .. } => {
                self.exit_of(*body)
            }
            Stmt::Break | Stmt::Continue | Stmt::Return(_) | Stmt::Goto(_) => Exit::Leaves,
            Stmt::GotoIndirect(_) => Exit::Leaves,
            _ => Exit::Falls,
        }
    }

    /// A call of a function declared not to return, or of `__builtin_trap`.
    fn never_returns(&self, e: ExprId) -> bool {
        match self.ast.expr(e) {
            Expr::Cast { child, .. } => self.never_returns(*child),
            Expr::Comma { rhs, .. } => self.never_returns(*rhs),
            Expr::Intrinsic { kind, .. } => crate::c5::op::Intrinsic::is_noreturn(*kind),
            Expr::Call { callee, .. } => match self.ast.expr(*callee) {
                Expr::Ident { sym, .. } => self.symbols[*sym as usize].is_noreturn,
                _ => false,
            },
            _ => false,
        }
    }

    fn always_true(&self, cond: Option<ExprId>) -> bool {
        cond.is_none_or(|c| self.expr_const_int(c).is_some_and(|v| v != 0))
    }

    /// A `break` in the switch body `id` that leaves the switch.
    fn breaks_out(&self, id: StmtId) -> bool {
        match self.ast.stmt(id) {
            Stmt::Break => true,
            Stmt::Compound(items) => items.iter().any(|i| match i {
                BlockItem::Stmt(s) => self.breaks_out(*s),
                BlockItem::Decl(_) => false,
            }),
            Stmt::If { then_s, else_s, .. } => {
                self.breaks_out(*then_s) || else_s.is_some_and(|e| self.breaks_out(e))
            }
            Stmt::Case { body, .. } | Stmt::Default { body } | Stmt::Labeled { body, .. } => {
                self.breaks_out(*body)
            }
            _ => false,
        }
    }
}

impl Exit {
    fn max_leaving(self, other: Exit) -> Exit {
        if self == Exit::Annotated || other == Exit::Annotated {
            Exit::Annotated
        } else {
            Exit::Leaves
        }
    }
}
