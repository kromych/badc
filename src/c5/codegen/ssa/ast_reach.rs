//! AST-level function and data reachability, computed ahead of the SSA
//! walk so the walk -- and the -O passes over its bodies -- never see
//! the unit's dead functions. Mirrors [`super::shadow::compute_live_sets`]:
//! the same roots (through its `seed_reachability_roots`), the same edge
//! set, read off the AST the walker is about to consume. The SSA-level
//! pass re-derives the set from the walked bodies, and a debug assertion
//! in the caller checks that this pass never dropped a function the SSA
//! pass keeps.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use super::shadow::{Node, data_object_starts, push_asm_names, seed_reachability_roots};
use crate::c5::ast::{BlockItem, Decl, Expr, ExprId, LocalInit, RuntimeInitValue, Stmt, StmtId};
use crate::c5::program::Program;
use crate::c5::token::Token;

/// Per-function edges collected from the AST: the functions the body
/// calls or names, and the data intervals its globals address.
struct Collector<'a> {
    ast: &'a crate::c5::ast::Ast,
    symbols: &'a [crate::c5::symbol::Symbol],
    named: &'a BTreeMap<&'a str, Node>,
    fun: Vec<usize>,
    data: Vec<usize>,
    /// `data_object_starts(program)`, for the offset-to-interval map.
    starts: &'a [i64],
    data_len: i64,
}

impl<'a> Collector<'a> {
    fn interval_of(&self, off: i64) -> usize {
        match self.starts.binary_search(&off) {
            Ok(i) => i,
            Err(i) => i.saturating_sub(1),
        }
    }

    fn push(&mut self, node: Node) {
        match node {
            Node::Func(pc) => self.fun.push(pc),
            Node::Data(i) => self.data.push(i),
        }
    }

    fn asm_names(&mut self, text: &[u8]) {
        let mut found: Vec<Node> = Vec::new();
        push_asm_names(text, self.named, &mut found);
        for node in found {
            self.push(node);
        }
    }

    fn asm_block(&mut self, idx: u32) {
        let block = &self.ast.asm_blocks[idx as usize];
        for &e in &block.operand_exprs {
            self.expr(e);
        }
        self.asm_names(&block.block.template);
        for cleanups in &block.cleanups {
            for &c in cleanups {
                self.stmt(c);
            }
        }
    }

    fn stmt(&mut self, id: StmtId) {
        match &self.ast.stmts[id as usize] {
            Stmt::Compound(items) => {
                for item in items {
                    self.item(item);
                }
            }
            Stmt::Expr(e) => self.expr(*e),
            Stmt::If {
                cond,
                then_s,
                else_s,
            } => {
                self.expr(*cond);
                self.stmt(*then_s);
                if let Some(e) = else_s {
                    self.stmt(*e);
                }
            }
            Stmt::While { cond, body } => {
                self.expr(*cond);
                self.stmt(*body);
            }
            Stmt::DoWhile { body, cond } => {
                self.stmt(*body);
                self.expr(*cond);
            }
            Stmt::For {
                init,
                cond,
                post,
                body,
            } => {
                if let Some(item) = init {
                    self.item(item);
                }
                if let Some(c) = cond {
                    self.expr(*c);
                }
                if let Some(p) = post {
                    self.expr(*p);
                }
                self.stmt(*body);
            }
            Stmt::Switch { disc, body } => {
                self.expr(*disc);
                self.stmt(*body);
            }
            Stmt::Case { body, .. } | Stmt::Default { body } | Stmt::Labeled { body, .. } => {
                self.stmt(*body);
            }
            Stmt::Break | Stmt::Continue | Stmt::Goto(_) => {}
            Stmt::Return(e) => {
                if let Some(e) = e {
                    self.expr(*e);
                }
            }
            Stmt::GotoIndirect(e) => self.expr(*e),
            Stmt::Asm { text, .. } => self.asm_names(text.as_bytes()),
            Stmt::AsmGoto(idx) => self.asm_block(*idx),
            Stmt::Decl(d) => self.decl(*d),
            Stmt::VlaScopeEnter { .. } | Stmt::VlaScopeExit { .. } | Stmt::ScopeEnd(_) => {}
            Stmt::CleanupJump { cleanups, jump } => {
                for &c in cleanups {
                    self.stmt(c);
                }
                self.stmt(*jump);
            }
        }
    }

    fn item(&mut self, item: &BlockItem) {
        match item {
            BlockItem::Stmt(s) => self.stmt(*s),
            BlockItem::Decl(d) => self.decl(*d),
        }
    }

    fn decl(&mut self, id: u32) {
        match &self.ast.decls[id as usize] {
            Decl::Local { init, .. } => self.init(init),
            Decl::Vla { dim, .. } => self.expr(*dim),
            Decl::StaticLocal { .. } => {}
        }
    }

    fn init(&mut self, init: &LocalInit) {
        match init {
            LocalInit::None | LocalInit::Aggregate { .. } | LocalInit::Fill { .. } => {}
            LocalInit::Scalar(e) => self.expr(*e),
            LocalInit::Runtime { elements, .. } => {
                for el in elements {
                    if let RuntimeInitValue::Expr(e) = el.value {
                        self.expr(e);
                    }
                }
            }
        }
    }

    fn expr(&mut self, id: ExprId) {
        match &self.ast.exprs[id as usize] {
            Expr::IntLit { .. }
            | Expr::FloatLit { .. }
            | Expr::StrLit { .. }
            | Expr::LabelAddr(_)
            | Expr::Sizeof(_)
            | Expr::VlaBase { .. }
            | Expr::VlaSizeof { .. } => {}
            Expr::Ident { sym, .. } => {
                // The snapshot's class / val are the parse-time tags; the
                // walker resolves the identifier through the symbol's
                // live binding, as a later scope exit may have restored
                // it. A function name -- a direct callee or an address
                // taken -- keeps the definition (an inline one through
                // its `inline_addr_pc`), a global keeps its data.
                if let Some(s) = self.symbols.get(*sym as usize) {
                    if s.is_fun_entity() {
                        // The live pc is the symbol's `val`; an address
                        // of an inline-only body resolves to the import
                        // placeholder, which the closure drops.
                        self.fun.push(s.val as usize);
                    } else if s.class == Token::Glo as i64
                        && s.defined_here
                        && !s.is_thread_local
                        && (0..self.data_len).contains(&s.val)
                    {
                        self.data.push(self.interval_of(s.val));
                    }
                }
            }
            Expr::Unary { child, .. }
            | Expr::Cast { child, .. }
            | Expr::PreInc { lvalue: child, .. }
            | Expr::PostInc { lvalue: child, .. }
            | Expr::Member { obj: child, .. } => self.expr(*child),
            Expr::Binary { lhs, rhs, .. }
            | Expr::Comma { lhs, rhs, .. }
            | Expr::ShortCircuit { lhs, rhs, .. }
            | Expr::Assign { lhs, rhs, .. }
            | Expr::CompoundAssign { lhs, rhs, .. }
            | Expr::Index {
                array: lhs,
                idx: rhs,
                ..
            }
            | Expr::BitfieldAssign { obj: lhs, rhs, .. }
            | Expr::MemTransfer {
                dst: lhs, src: rhs, ..
            }
            | Expr::CheckedArith { a: lhs, b: rhs, .. } => {
                self.expr(*lhs);
                self.expr(*rhs);
            }
            Expr::Ternary {
                cond,
                then_e,
                else_e,
                ..
            } => {
                self.expr(*cond);
                self.expr(*then_e);
                self.expr(*else_e);
            }
            Expr::Call { callee, args, .. } => {
                self.expr(*callee);
                for &a in args {
                    self.expr(a);
                }
            }
            Expr::Intrinsic { args, .. }
            | Expr::Atomic { args, .. }
            | Expr::X86Simd { args, .. } => {
                for &a in args {
                    self.expr(a);
                }
            }
            Expr::InlineAsm(idx) => self.asm_block(*idx),
            Expr::CompoundLiteral { init, .. } => self.init(init),
            Expr::StmtExpr { block, .. } => self.stmt(*block),
        }
    }
}

/// The functions of `program` reachable from the roots
/// [`super::shadow::compute_live_sets`] starts from, with every edge the
/// SSA pass would derive read off the AST instead: a call, a name used
/// as a value, an asm template or operand, a global the body addresses,
/// and the function / data pointers `.data` holds.
pub(crate) fn reachable_functions(program: &Program) -> BTreeSet<usize> {
    let data_len = program.data.len() as i64;
    let starts = data_object_starts(program);
    let n = starts.len();
    let interval_of = |off: i64| -> usize {
        match starts.binary_search(&off) {
            Ok(i) => i,
            Err(i) => i.saturating_sub(1),
        }
    };
    let defined: BTreeSet<usize> = program
        .finished_functions
        .iter()
        .map(|f| f.ent_pc)
        .collect();

    // The names an asm template can spell, for the conservative scan.
    let mut named: BTreeMap<&str, Node> = BTreeMap::new();
    for sym in &program.symbols {
        if sym.class == Token::Glo as i64
            && sym.defined_here
            && !sym.is_thread_local
            && !sym.name.is_empty()
            && (0..data_len).contains(&sym.val)
        {
            named.insert(sym.link_name(), Node::Data(interval_of(sym.val)));
        }
    }
    for f in &program.finished_functions {
        if !f.name.is_empty() {
            named.insert(f.name.as_str(), Node::Func(f.ent_pc));
        }
    }

    // Per-function edges from the AST, and the data-side edges the
    // program records: a function pointer slot, a `&&label` slot, and
    // a data slot pointing at another object.
    let mut fun_edges: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
    let mut data_edges: BTreeMap<usize, Vec<usize>> = BTreeMap::new();
    for f in &program.finished_functions {
        let mut c = Collector {
            ast: &f.ast,
            symbols: &program.symbols,
            named: &named,
            fun: Vec::new(),
            data: Vec::new(),
            starts: &starts,
            data_len,
        };
        if let Some(body) = f.ast.body {
            c.stmt(body);
        }
        fun_edges.insert(f.ent_pc, c.fun);
        data_edges.insert(f.ent_pc, c.data);
    }
    let mut code_edges: Vec<Vec<usize>> = alloc::vec![Vec::new(); n];
    let mut data2data: Vec<Vec<usize>> = alloc::vec![Vec::new(); n];
    if n > 0 {
        let bound = |r: &&crate::c5::program::CodeReloc| {
            program.bound_trampoline(r.target_ent_pc).is_some()
        };
        for r in program.code_relocs.iter().filter(|r| !bound(r)) {
            let off = r.data_offset as i64;
            if (0..data_len).contains(&off) {
                code_edges[interval_of(off)].push(r.target_ent_pc as usize);
            }
        }
        for (off, ent_pc) in program.label_data_slots() {
            let off = off as i64;
            if (0..data_len).contains(&off) {
                code_edges[interval_of(off)].push(ent_pc);
            }
        }
        for r in &program.data_relocs {
            let (off, anchor) = (r.data_offset as i64, r.target_anchor as i64);
            if (0..data_len).contains(&off) && (0..data_len).contains(&anchor) {
                data2data[interval_of(off)].push(interval_of(anchor));
            }
        }
    }

    // Block-scope statics join their owner's edges; a `used` one whose
    // owner is never reached is unreachable, exactly as in the SSA pass.
    let (mut work, mut owner_deps) = seed_reachability_roots(
        program,
        &defined,
        data_len,
        n,
        &interval_of,
        None,
        false,
        &named,
    );
    for (owner, deps) in core::mem::take(&mut owner_deps) {
        data_edges.entry(owner).or_default().extend(deps);
    }

    let mut funcs: BTreeSet<usize> = BTreeSet::new();
    let mut data_live = alloc::vec![false; n];
    while let Some(node) = work.pop() {
        match node {
            Node::Func(pc) => {
                if !funcs.insert(pc) {
                    continue;
                }
                for &t in fun_edges.get(&pc).into_iter().flatten() {
                    if defined.contains(&t) {
                        work.push(Node::Func(t));
                    }
                }
                for &d in data_edges.get(&pc).into_iter().flatten() {
                    work.push(Node::Data(d));
                }
            }
            Node::Data(i) => {
                if data_live[i] {
                    continue;
                }
                data_live[i] = true;
                for &t in &code_edges[i] {
                    work.push(Node::Func(t));
                }
                for &d in &data2data[i] {
                    work.push(Node::Data(d));
                }
            }
        }
    }
    funcs
}
