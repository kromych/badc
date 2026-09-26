//! The scopes a jump leaves and enters. A jump runs the `cleanup` functions
//! of the variables in scope at it and not at its label, latest declared
//! first. It may not pass a VLA declaration (C99 6.8.6.1p1, 6.8.4.2p2) or, as
//! clang rules, a cleanup declaration into its scope, nor enter a statement
//! expression.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::ast::{LabelId, Stmt, StmtId};
use super::super::diag::Code;
use super::super::error::C5Error;
use super::Compiler;
use super::stmt::CleanupVar;

/// An open scope: its id and its cleanup variables, in declaration order.
pub(super) struct CleanupScope {
    pub(super) id: u32,
    pub(super) vars: Vec<CleanupVar>,
}

/// A scope's barrier declarations as (name, is a VLA, line), and whether it
/// is a statement expression's block.
#[derive(Default)]
pub(super) struct ScopeBarriers {
    decls: Vec<(String, bool, usize)>,
    stmt_expr: bool,
}

/// A program point: per open scope, outermost first, its id and how many of
/// its cleanup variables and barrier declarations precede the point.
#[derive(Clone)]
pub(super) struct JumpPoint(Vec<(u32, u32, u32)>);

/// A jump's target: a label, any address-taken label, or label `i` of `asm`.
#[derive(Clone, Copy)]
pub(super) enum Target {
    Label(LabelId),
    Computed,
    Asm { asm: u32, i: usize, label: LabelId },
}

struct PendingJump {
    stmt: StmtId,
    target: Target,
    from: JumpPoint,
    /// The cleanup variables in scope at the jump, outermost first.
    active: Vec<CleanupVar>,
    line: usize,
}

#[derive(Default)]
pub(super) struct Jumps {
    scopes: Vec<ScopeBarriers>,
    labels: BTreeMap<LabelId, JumpPoint>,
    label_addrs: BTreeSet<LabelId>,
    pending: Vec<PendingJump>,
    switches: Vec<JumpPoint>,
}

impl Compiler {
    pub(super) fn open_cleanup_scope(&mut self, stmt_expr: bool) {
        let id = self.jumps.scopes.len() as u32;
        self.jumps.scopes.push(ScopeBarriers {
            decls: Vec::new(),
            stmt_expr,
        });
        self.cleanup_scopes.push(CleanupScope {
            id,
            vars: Vec::new(),
        });
    }

    /// Declaration `sym`, a VLA or cleanup variable, bars jumps into its scope.
    pub(super) fn note_jump_barrier(&mut self, sym: usize, vla: bool) {
        if let Some(s) = self.cleanup_scopes.last() {
            let name = self.symbols[sym].name.clone();
            let line = self.lex.line;
            self.jumps.scopes[s.id as usize]
                .decls
                .push((name, vla, line));
        }
    }

    fn jump_point(&self) -> JumpPoint {
        JumpPoint(
            self.cleanup_scopes
                .iter()
                .map(|s| {
                    let barriers = self.jumps.scopes[s.id as usize].decls.len();
                    (s.id, s.vars.len() as u32, barriers as u32)
                })
                .collect(),
        )
    }

    pub(super) fn note_label(&mut self, label: LabelId) {
        let at = self.jump_point();
        self.jumps.labels.insert(label, at);
    }

    pub(super) fn note_label_addr(&mut self, label: LabelId) {
        self.jumps.label_addrs.insert(label);
    }

    pub(super) fn note_jump(&mut self, stmt: StmtId, target: Target, line: usize) {
        let from = self.jump_point();
        let active = self
            .cleanup_scopes
            .iter()
            .flat_map(|s| s.vars.iter().cloned())
            .collect();
        self.jumps.pending.push(PendingJump {
            stmt,
            target,
            from,
            active,
            line,
        });
    }

    pub(super) fn enter_switch_body(&mut self) {
        let at = self.jump_point();
        self.jumps.switches.push(at);
    }

    pub(super) fn leave_switch_body(&mut self) {
        self.jumps.switches.pop();
    }

    /// Reject a `case` or `default` on `line` in a scope its switch may not enter.
    pub(super) fn check_switch_label(&self, line: usize) -> Result<(), C5Error> {
        let Some(from) = self.jumps.switches.last() else {
            return Ok(());
        };
        match self.entry_violation(from, &self.jump_point()) {
            Some(what) => {
                let msg = format!("`switch` jumps into {what}");
                Err(self.compile_err_at(Code::INVALID_STATEMENT, line, msg))
            }
            None => Ok(()),
        }
    }

    /// What `to` is inside that `from` is not: a statement expression, or
    /// the scope of a barrier declaration past the declaration.
    fn entry_violation(&self, from: &JumpPoint, to: &JumpPoint) -> Option<String> {
        let k = shared(from, to);
        if k > 0 {
            let (id, _, passed) = from.0[k - 1];
            if to.0[k - 1].2 > passed {
                return Some(self.barrier(id, passed));
            }
        }
        for &(id, _, passed) in &to.0[k..] {
            if self.jumps.scopes[id as usize].stmt_expr {
                return Some("a statement expression".into());
            }
            if passed > 0 {
                return Some(self.barrier(id, 0));
            }
        }
        None
    }

    fn barrier(&self, id: u32, i: u32) -> String {
        let (name, vla, line) = &self.jumps.scopes[id as usize].decls[i as usize];
        let what = if *vla {
            "a variably modified type"
        } else {
            "a cleanup function"
        };
        format!("the scope of `{name}`, declared with {what} at line {line}")
    }

    /// At the end of the body: attach each jump's cleanups and reject the jumps
    /// no scope admits. A computed `goto` reaches every address-taken label.
    pub(super) fn resolve_jumps(&mut self) -> Result<(), C5Error> {
        self.ast.label_addrs = self.jumps.label_addrs.iter().copied().collect();
        let pending = core::mem::take(&mut self.jumps.pending);
        // Jumps to one label running one list share its calls.
        let mut shared: BTreeMap<(LabelId, Vec<CleanupVar>), Vec<StmtId>> = BTreeMap::new();
        for j in &pending {
            let (targets, what): (Vec<LabelId>, _) = match j.target {
                Target::Label(l) => (alloc::vec![l], "`goto`"),
                Target::Computed => (self.ast.label_addrs.clone(), "computed `goto`"),
                Target::Asm { label, .. } => (alloc::vec![label], "`asm goto`"),
            };
            let mut run: Option<Vec<CleanupVar>> = None;
            for l in targets {
                let Some(to) = self.jumps.labels.get(&l) else {
                    continue;
                };
                if let Some(into) = self.entry_violation(&j.from, to) {
                    let msg = format!("{what} jumps into {into}");
                    return Err(self.compile_err_at(Code::INVALID_STATEMENT, j.line, msg));
                }
                let list = cleanups_left(j, to);
                if run.as_ref().is_some_and(|r| *r != list) {
                    let msg = "computed `goto` leaves scopes whose cleanup functions depend on \
                               its target";
                    return Err(self.compile_err_at(Code::INVALID_STATEMENT, j.line, msg));
                }
                run = Some(list);
            }
            if let Some(list) = run.filter(|l| !l.is_empty()) {
                let calls = match j.target {
                    Target::Computed => self.cleanup_calls(j.stmt, &list),
                    Target::Label(l) | Target::Asm { label: l, .. } => shared
                        .entry((l, list))
                        .or_insert_with_key(|k| self.cleanup_calls(j.stmt, &k.1))
                        .clone(),
                };
                match j.target {
                    Target::Asm { asm, i, .. } => {
                        self.ast.asm_blocks[asm as usize].cleanups[i] = calls;
                    }
                    _ => {
                        let pos = self.ast.stmt_src[j.stmt as usize];
                        let jump = self.ast.stmts[j.stmt as usize].clone();
                        let jump = self.ast.push_stmt(jump, pos);
                        self.ast.stmts[j.stmt as usize] = Stmt::CleanupJump {
                            cleanups: calls,
                            jump,
                        };
                    }
                }
            }
        }
        Ok(())
    }

    /// The call statements running `list`, placed at jump statement `stmt`.
    fn cleanup_calls(&mut self, stmt: StmtId, list: &[CleanupVar]) -> Vec<StmtId> {
        let pos = self.ast.stmt_src[stmt as usize];
        let mut calls = Vec::with_capacity(list.len());
        for cv in list {
            self.push_cleanup_call(cv);
            let id = self.ast.stmts.len() - 1;
            self.ast.stmt_src[id] = pos;
            calls.push(id as StmtId);
        }
        calls
    }
}

/// How many outer scopes `a` and `b` share.
fn shared(a: &JumpPoint, b: &JumpPoint) -> usize {
    a.0.iter().zip(&b.0).take_while(|(x, y)| x.0 == y.0).count()
}

/// The cleanup variables in scope at the jump and not at `to`, latest
/// declared first.
fn cleanups_left(j: &PendingJump, to: &JumpPoint) -> Vec<CleanupVar> {
    let k = shared(&j.from, to);
    let mut kept: usize = j.from.0[..k.saturating_sub(1)]
        .iter()
        .map(|l| l.1 as usize)
        .sum();
    if k > 0 {
        kept += j.from.0[k - 1].1.min(to.0[k - 1].1) as usize;
    }
    j.active[kept..].iter().rev().cloned().collect()
}
