//! Microsoft structured exception handling statements and MSVC's placement
//! rules for them and their intrinsics. A jump out of a `__finally` body,
//! undefined during termination handling, is refused.

use alloc::format;
use alloc::vec::Vec;

use super::super::ast::{SehHandler, Stmt, StmtId};
use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::ms_intrinsic::Op;
use super::super::token::Token;
use super::Compiler;
use super::diag::Category;

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
/// `break` or `continue` at the same depth leaves it.
#[derive(Clone, Copy)]
pub(super) struct SehContext {
    part: SehPart,
    break_depth: usize,
    continue_depth: usize,
}

impl Compiler {
    /// `__try { ... } __except (filter) { ... }` or `__try { ... }
    /// __finally { ... }`, at the `__try` keyword.
    pub(super) fn parse_seh_try(&mut self) -> Result<(), C5Error> {
        let pos = self.ast_src_pos();
        self.next()?;
        let body = self.parse_seh_block(SehPart::Try)?;
        let handler = if self.lex.tk == Token::SehExcept {
            self.next()?;
            self.consume(b'(', "`(` expected after `__except`")?;
            self.enter_seh_part(SehPart::Filter);
            self.parse_full_expr()?;
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
            let body = self.parse_seh_block(SehPart::Except)?;
            filter.map(|filter| SehHandler::Except { filter, body })
        } else if self.lex.tk == Token::SehFinally {
            self.next()?;
            Some(SehHandler::Finally(self.parse_seh_block(SehPart::Finally)?))
        } else {
            return Err(self.compile_err(
                Code::SYNTAX,
                "`__except` or `__finally` expected after a `__try` block",
            ));
        };
        if let Some(handler) = handler {
            self.ast.push_stmt(Stmt::SehTry { body, handler }, pos);
        }
        Ok(())
    }

    /// The compound statement of `part`, in a scope no jump may enter.
    fn parse_seh_block(&mut self, part: SehPart) -> Result<StmtId, C5Error> {
        if self.lex.tk != '{' {
            let text = format!("`{{` expected after {}", part.keyword());
            return Err(self.compile_err(Code::SYNTAX, text));
        }
        self.enter_seh_part(part);
        self.open_seh_scope(part);
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
        });
    }

    /// `__leave;`, at the keyword: to the end of the innermost enclosing
    /// `__try` body, which may not lie outside a `__finally` body.
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
        if self.seh_contexts[at..]
            .iter()
            .any(|c| c.part == SehPart::Finally)
        {
            return Err(self.seh_finally_exit("`__leave`"));
        }
        let pos = self.ast_src_pos();
        self.next()?;
        self.consume(b';', "semicolon expected after `__leave`")?;
        self.ast.push_stmt(Stmt::SehLeave, pos);
        Ok(())
    }

    /// Refuse a `break`, `continue` or (`depth` `None`) `return` that leaves
    /// a `__finally` body.
    pub(super) fn check_seh_exit(&self, what: &str, depth: Option<Depth>) -> Result<(), C5Error> {
        let leaves = self.seh_contexts.iter().any(|c| {
            c.part == SehPart::Finally
                && match depth {
                    None => true,
                    Some(Depth::Break) => c.break_depth == self.loop_break_depth,
                    Some(Depth::Continue) => c.continue_depth == self.loop_continue_depth,
                }
        });
        if leaves {
            return Err(self.seh_finally_exit(what));
        }
        Ok(())
    }

    fn seh_finally_exit(&self, what: &str) -> C5Error {
        let text = format!("{what} jumps out of a `__finally` block");
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
