//! Microsoft structured exception handling statements and MSVC's placement
//! rules for them and their intrinsics. A jump out of a `__finally` body,
//! undefined during termination handling, is refused.

use alloc::format;
use alloc::vec::Vec;

use super::super::ast::{SehFunclet, SehHandler, Stmt, StmtId};
use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::ms_intrinsic::Op;
use super::super::token::Token;
use super::Compiler;
use super::diag::Category;
use super::stmt::Cleanup;

/// The filter value that runs the `__except` body.
const EXCEPTION_EXECUTE_HANDLER: i64 = 1;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub(super) enum SehPart {
    Try,
    Filter,
    Except,
    Finally,
}

impl SehPart {
    fn keyword(self) -> &'static str {
        match self {
            SehPart::Try => "`__try`",
            SehPart::Filter | SehPart::Except => "`__except`",
            SehPart::Finally => "`__finally`",
        }
    }

    pub(super) fn block(self) -> &'static str {
        match self {
            SehPart::Try => "a `__try` block",
            SehPart::Filter => "an `__except` filter",
            SehPart::Except => "an `__except` block",
            SehPart::Finally => "a `__finally` block",
        }
    }
}

/// An open part, with the `break` and `continue` depths at its start: a
/// `break` or `continue` at the same depth leaves it. A `__try` body's
/// cleanup scope is `cleanup_scopes[cleanup_depth]`.
#[derive(Clone, Copy)]
pub(super) struct SehContext {
    part: SehPart,
    break_depth: usize,
    continue_depth: usize,
    cleanup_depth: usize,
}

impl Compiler {
    /// `__try { ... } __except (filter) { ... }` or `__try { ... }
    /// __finally { ... }`, at the `__try` keyword. A jump out of the body
    /// runs the `__finally` block, which the body's scope holds as its
    /// cleanup before the handler is known; for an `__except` the walk
    /// runs nothing.
    pub(super) fn parse_seh_try(&mut self) -> Result<(), C5Error> {
        let pos = self.ast_src_pos();
        self.next()?;
        let index = self.seh_trys;
        self.seh_trys += 1;
        let body = self.parse_seh_block(SehPart::Try, Some(Cleanup::Finally(index)))?;
        let handler = if self.lex.tk == Token::SehExcept {
            self.next()?;
            self.consume(b'(', "`(` expected after `__except`")?;
            self.enter_seh_part(SehPart::Filter);
            // The slots the filter reserves are its funclet's own.
            let (slot_base, outer_max) = (self.loc_offs, self.max_loc_offs);
            self.max_loc_offs = slot_base;
            self.parse_full_expr()?;
            let slot_end = self.max_loc_offs;
            self.max_loc_offs = outer_max.max(slot_end);
            self.seh_contexts.pop();
            let filter = self.ast_acc;
            let what = "filter expression of `__except`";
            self.require_category(
                self.ty,
                Category::Integer,
                Code::CONTROLLING_EXPRESSION,
                what,
            )?;
            self.consume(b')', "`)` expected after the `__except` filter")?;
            self.flush_pending_stores();
            // cl's scope table names EXCEPTION_EXECUTE_HANDLER as the constant
            // 1 and every other filter, a constant one included, by a funclet.
            let funclet = filter
                .filter(|&f| self.ast.folded_int(f) != Some(EXCEPTION_EXECUTE_HANDLER))
                .map(|_| self.seh_funclet(slot_base, slot_end));
            let body = self.parse_seh_block(SehPart::Except, None)?;
            filter.map(|filter| SehHandler::Except {
                filter,
                body,
                funclet,
            })
        } else if self.lex.tk == Token::SehFinally {
            self.next()?;
            // The block is a funclet; the slots it reserves are its own.
            let (slot_base, outer_max) = (self.loc_offs, self.max_loc_offs);
            let mut funclet = self.seh_funclet(slot_base, slot_base);
            self.max_loc_offs = slot_base;
            let body = self.parse_seh_block(SehPart::Finally, None)?;
            funclet.slot_end = self.max_loc_offs;
            self.max_loc_offs = outer_max.max(funclet.slot_end);
            Some(SehHandler::Finally { body, funclet })
        } else {
            return Err(self.compile_err(
                Code::SYNTAX,
                "`__except` or `__finally` expected after a `__try` block",
            ));
        };
        if let Some(handler) = handler {
            let stmt = Stmt::SehTry {
                body,
                handler,
                index,
            };
            self.ast.push_stmt(stmt, pos);
        }
        Ok(())
    }

    /// The function's next funclet, numbered in source order as cl numbers
    /// them.
    fn seh_funclet(&mut self, slot_base: i64, slot_end: i64) -> SehFunclet {
        self.seh_funclets += 1;
        SehFunclet {
            index: self.seh_funclets - 1,
            slot_base,
            slot_end,
        }
    }

    /// The compound statement of `part`, in a scope no jump may enter whose
    /// exit runs `cleanup`.
    fn parse_seh_block(
        &mut self,
        part: SehPart,
        cleanup: Option<Cleanup>,
    ) -> Result<StmtId, C5Error> {
        if self.lex.tk != '{' {
            let text = format!("`{{` expected after {}", part.keyword());
            return Err(self.compile_err(Code::SYNTAX, text));
        }
        self.enter_seh_part(part);
        self.open_seh_scope(part);
        if let Some(scope) = self.cleanup_scopes.last_mut() {
            scope.vars.extend(cleanup);
        }
        let before = self.ast_stmts_snapshot();
        self.stmt()?;
        let body = self.ast_wrap_stmts_since(before);
        self.cleanup_scopes.pop();
        self.seh_contexts.pop();
        Ok(body)
    }

    fn enter_seh_part(&mut self, part: SehPart) {
        self.seh_contexts.push(SehContext {
            part,
            break_depth: self.loop_break_depth,
            continue_depth: self.loop_continue_depth,
            cleanup_depth: self.cleanup_scopes.len(),
        });
    }

    /// `__leave;`, at the keyword: to the end of the innermost enclosing
    /// `__try` body, which may not lie outside a `__finally` body, running
    /// the cleanups of the scopes it leaves inside the body.
    pub(super) fn parse_seh_leave(&mut self) -> Result<(), C5Error> {
        let Some(at) = self
            .seh_contexts
            .iter()
            .rposition(|c| c.part == SehPart::Try)
        else {
            return Err(
                self.compile_err(Code::INVALID_STATEMENT, "`__leave` outside a `__try` block")
            );
        };
        if let Some(c) = (self.seh_contexts[at..].iter())
            .find(|c| matches!(c.part, SehPart::Finally | SehPart::Filter))
        {
            return Err(self.seh_exit("`__leave`", c.part));
        }
        let pos = self.ast_src_pos();
        self.next()?;
        self.consume(b';', "semicolon expected after `__leave`")?;
        let start = self.ast.stmts.len();
        self.emit_cleanups_above(self.seh_contexts[at].cleanup_depth + 1);
        self.ast.push_stmt(Stmt::SehLeave, pos);
        self.coalesce_exit_since(start);
        Ok(())
    }

    /// Refuse a `break`, `continue` or (`depth` `None`) `return` that leaves
    /// a `__finally` body or an `__except` filter, which is a function of
    /// its own.
    pub(super) fn check_seh_exit(&self, what: &str, depth: Option<Depth>) -> Result<(), C5Error> {
        let left = self.seh_contexts.iter().find(|c| {
            matches!(c.part, SehPart::Finally | SehPart::Filter)
                && match depth {
                    None => true,
                    Some(Depth::Break) => c.break_depth == self.loop_break_depth,
                    Some(Depth::Continue) => c.continue_depth == self.loop_continue_depth,
                }
        });
        match left {
            Some(c) => Err(self.seh_exit(what, c.part)),
            None => Ok(()),
        }
    }

    /// Refuse a `goto` or a `__try` statement in an `__except` filter.
    pub(super) fn check_seh_filter(&self, what: &str) -> Result<(), C5Error> {
        if self.seh_contexts.iter().any(|c| c.part == SehPart::Filter) {
            let text = format!("{what} in an `__except` filter");
            return Err(self.compile_err(Code::INVALID_STATEMENT, text));
        }
        Ok(())
    }

    fn seh_exit(&self, what: &str, part: SehPart) -> C5Error {
        let text = format!("{what} jumps out of {}", part.block());
        self.compile_err(Code::INVALID_STATEMENT, text)
    }

    /// Refuse `_exception_code`, `_exception_info` or `_abnormal_termination`
    /// (`op`, spelled `name`) outside the part that supplies its value.
    pub(super) fn check_seh_intrinsic(&self, op: Op, name: &str) -> Result<(), C5Error> {
        let parts: &[SehPart] = match op {
            Op::ExceptionCode => &[SehPart::Filter, SehPart::Except],
            Op::ExceptionInfo => &[SehPart::Filter],
            Op::AbnormalTermination => &[SehPart::Finally],
            _ => return Ok(()),
        };
        if self.seh_contexts.iter().any(|c| parts.contains(&c.part)) {
            return Ok(());
        }
        let place: Vec<_> = parts.iter().map(|p| p.block()).collect();
        let text = format!("`{name}` is only allowed in {}", place.join(" or "));
        Err(self.compile_err(Code::INVALID_STATEMENT, text))
    }
}

/// Which loop-exit depth a statement is checked against.
#[derive(Clone, Copy)]
pub(super) enum Depth {
    Break,
    Continue,
}
