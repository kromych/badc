//! Script symbols and linker-script expression evaluation.

use crate::c5::linker::lds::{AssignOp, Assignment, BinOp, Expr, UnOp};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use hashbrown::HashSet;

use super::{
    Att, LdsLinker, SHF_TLS, SHN_ABS, SHN_COMMON, SHN_UNDEF, STT_NOTYPE, ScriptSym, SecFate, Stmt,
    Val, align_up,
};

/// Every symbol name an expression reads.
fn collect_symbols(e: &Expr, out: &mut HashSet<String>) {
    match e {
        Expr::Symbol(n) => {
            out.insert(n.clone());
        }
        Expr::Unary(_, a) | Expr::AlignDot(a) | Expr::Absolute(a) | Expr::Assert(a, _) => {
            collect_symbols(a, out)
        }
        Expr::Binary(_, a, b) | Expr::Align2(a, b) | Expr::Min(a, b) | Expr::Max(a, b) => {
            collect_symbols(a, out);
            collect_symbols(b, out);
        }
        Expr::Ternary(a, b, c) => {
            collect_symbols(a, out);
            collect_symbols(b, out);
            collect_symbols(c, out);
        }
        _ => {}
    }
}

impl<'a> LdsLinker<'a> {
    pub(super) fn exec_assignment(&mut self, a: &Assignment, after_sections: bool) {
        if a.symbol == "." {
            let v = self.eval(&a.value).v;
            let new = self.apply_assign_op(self.dot, a.op, v);
            if after_sections {
                return; // `. = ASSERT(...)` after SECTIONS: check only
            }
            self.dot = new;
            return;
        }
        if a.provide {
            // PROVIDE defines only referenced, otherwise-undefined
            // symbols; an inactive PROVIDE never evaluates its value.
            if self.globals.contains_key(&a.symbol) || !self.referenced.contains(&a.symbol) {
                return;
            }
            // An active PROVIDE's expression references what it names,
            // so a chain of them resolves on the following pass.
            collect_symbols(&a.value, &mut self.referenced);
        }
        if a.symbol.trim_start_matches('_') == "end" {
            self.found_end = true;
        }
        let cur = self.lookup(&a.symbol);
        let rhs = self.eval(&a.value);
        let value = match a.op {
            AssignOp::Set => rhs,
            _ => {
                let base = cur.map(|v| v.v).unwrap_or(0);
                Val {
                    v: self.apply_assign_op(base, a.op, rhs.v),
                    att: rhs.att,
                }
            }
        };
        // Computed every pass: the dynamic-fixup sizing consults the
        // previous pass's table before the final one runs.
        let final_out = if value.att == Att::DotAbs {
            self.section_for_dot()
        } else {
            None
        };
        let kind = self.assigned_sym_type(a);
        self.script_now.insert(
            a.symbol.clone(),
            ScriptSym {
                val: value,
                hidden: a.hidden,
                kind,
                final_out,
                vis: None,
            },
        );
    }

    /// Type a script-defined symbol takes from its expression. bfd
    /// copies the source symbol's type when the expression names one
    /// symbol and nothing else (ldexp.c's `expld.assign_src`, applied
    /// through `bfd_copy_link_hash_symbol_type`); a compound
    /// expression leaves the symbol untyped. An operator assignment
    /// reads the destination, so it names that symbol too.
    fn assigned_sym_type(&self, a: &Assignment) -> u8 {
        let mut names: HashSet<String> = HashSet::new();
        collect_symbols(&a.value, &mut names);
        if a.op != AssignOp::Set {
            names.insert(a.symbol.clone());
        }
        if names.len() != 1 {
            return STT_NOTYPE;
        }
        let Some(name) = names.iter().next() else {
            return STT_NOTYPE;
        };
        match self.globals.get(name) {
            Some(&(oi, si)) => self.objects[oi].symbols[si].kind(),
            None => STT_NOTYPE,
        }
    }

    /// ld's section_for_dot: the symtab section for a symbol assigned
    /// from the location counter outside any output section.
    /// Assignments attach to the previous allocated section, except
    /// that after a top-level dot assignment (or before any section)
    /// they attach to the section following the statement; past the
    /// `end` assignment the previous section wins again. The walks
    /// skip removed and non-allocated sections.
    fn section_for_dot(&self) -> Option<usize> {
        // `removed` is only settled after the last pass; an empty
        // section is already known stripped here (sizes converged).
        let stripped = |oi: usize| self.outs[oi].size == 0 || self.outs[oi].name == "/DISCARD/";
        let is_alloc =
            |oi: usize| self.outs[oi].alloc && !stripped(oi) && self.outs[oi].flags & SHF_TLS == 0;
        let opens: Vec<usize> = self
            .stmts
            .iter()
            .filter_map(|s| match s {
                Stmt::Open(oi) => Some(*oi),
                _ => None,
            })
            .collect();
        if self.dot_section.is_none() || self.prefer_next {
            let mut nxt = self
                .stmts
                .iter()
                .skip(self.cur_stmt + 1)
                .filter_map(|s| match s {
                    Stmt::Open(oi) => Some(*oi),
                    _ => None,
                })
                .peekable();
            let mut os = nxt.next();
            while let Some(o) = os {
                if !self.after_end[o] && stripped(o) {
                    os = nxt.next();
                } else {
                    break;
                }
            }
            if self.dot_section.is_none() || os.is_none_or(|o| !self.after_end[o]) {
                // Walk backward from the found section (or the last
                // one) to the nearest allocated section.
                let start = match os {
                    Some(o) => opens.iter().position(|&x| x == o)?,
                    None => opens.len().checked_sub(1)?,
                };
                return opens[..=start].iter().rev().copied().find(|&o| is_alloc(o));
            }
        }
        let s = self.dot_section?;
        let pos = opens.iter().position(|&x| x == s)?;
        if let Some(o) = opens[..=pos].iter().rev().copied().find(|&o| is_alloc(o)) {
            return Some(o);
        }
        opens.iter().copied().find(|&o| is_alloc(o))
    }

    fn apply_assign_op(&self, base: u64, op: AssignOp, v: u64) -> u64 {
        match op {
            AssignOp::Set => v,
            AssignOp::Add => base.wrapping_add(v),
            AssignOp::Sub => base.wrapping_sub(v),
            AssignOp::Mul => base.wrapping_mul(v),
            AssignOp::Div => {
                if v == 0 {
                    0
                } else {
                    ((base as i64) / (v as i64)) as u64
                }
            }
            AssignOp::Shl => base.wrapping_shl(v as u32),
            AssignOp::Shr => base.wrapping_shr(v as u32),
            AssignOp::And => base & v,
            AssignOp::Or => base | v,
        }
    }

    pub(super) fn exec_assert(&mut self, e: &Expr, msg: &str) {
        let v = self.eval(e);
        if self.final_pass && v.v == 0 {
            self.errors.push(format!("assertion failed: {msg}"));
        }
    }

    fn lookup(&mut self, name: &str) -> Option<Val> {
        if name == "." {
            // Inside an output section dot is section-relative;
            // outside it is absolute and marks the evaluation so a
            // defined symbol can still pick up a symtab section
            // through section_for_dot.
            let att = match self.cur_out {
                Some(o) => Att::Out(o),
                None => Att::DotAbs,
            };
            return Some(Val { v: self.dot, att });
        }
        if let Some(s) = self.script_now.get(name) {
            return Some(s.val.as_reference());
        }
        if let Some(&(oi, si)) = self.globals.get(name)
            && let Some(v) = self.object_sym_val(oi, si)
        {
            return Some(v);
        }
        if let Some(s) = self.script_prev.get(name) {
            return Some(s.val.as_reference());
        }
        None
    }

    /// Value of a defined object symbol under the current pass's
    /// placement (falling back to the previous pass for sections not
    /// yet placed this pass).
    fn object_sym_val(&self, oi: usize, si: usize) -> Option<Val> {
        let sym = &self.objects[oi].symbols[si];
        match sym.shndx as u16 {
            SHN_ABS => Some(Val::abs(sym.value)),
            SHN_UNDEF | SHN_COMMON => None,
            _ => {
                let sec = *self.objects[oi].shndx_map.get(&sym.shndx)?;
                let i = self.insec_index(oi, sec);
                match self.fates[i] {
                    SecFate::Placed { out } => {
                        // Sections placed earlier in this pass carry
                        // exact values; later ones fall back to the
                        // previous pass's placement, which matches at
                        // convergence.
                        let off = self.placed_off(i, sym.value)?;
                        let base = if let Some(&pl) = self.merge_of.get(&i) {
                            self.placements[self.pools[pl].rep].off
                        } else {
                            self.placements[i].off
                        };
                        Some(Val {
                            v: self.outs[out].addr.wrapping_add(base).wrapping_add(off),
                            att: Att::Out(out),
                        })
                    }
                    _ => None,
                }
            }
        }
    }

    pub(super) fn eval(&mut self, e: &Expr) -> Val {
        self.eval_with_dot(e, self.dot)
    }

    pub(super) fn eval_with_dot(&mut self, e: &Expr, dot: u64) -> Val {
        let saved = self.dot;
        self.dot = dot;
        let v = self.eval_inner(e);
        self.dot = saved;
        v
    }

    fn eval_inner(&mut self, e: &Expr) -> Val {
        match e {
            Expr::Number(n) => Val::abs(*n),
            Expr::Symbol(name) => match self.lookup(name) {
                Some(v) => v,
                // `CONSTANT(...)` lowers to these names.
                None if name == "MAXPAGESIZE" => Val::abs(self.opts.max_page_size),
                None if name == "COMMONPAGESIZE" => Val::abs(self.common_page_size()),
                None => {
                    if self.final_pass {
                        self.undefined.insert(name.clone());
                    }
                    Val::abs(0)
                }
            },
            Expr::Unary(op, a) => {
                let a = self.eval_inner(a);
                let v = match op {
                    UnOp::Neg => a.v.wrapping_neg(),
                    UnOp::Not => (a.v == 0) as u64,
                    UnOp::BitNot => !a.v,
                };
                Val::abs(v)
            }
            Expr::Binary(op, a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                let v = match op {
                    BinOp::Add => a.v.wrapping_add(b.v),
                    BinOp::Sub => a.v.wrapping_sub(b.v),
                    BinOp::Mul => a.v.wrapping_mul(b.v),
                    BinOp::Div => {
                        if b.v == 0 {
                            if self.final_pass {
                                self.errors.push("division by zero in script".to_string());
                            }
                            0
                        } else {
                            ((a.v as i64) / (b.v as i64)) as u64
                        }
                    }
                    BinOp::Rem => {
                        if b.v == 0 {
                            0
                        } else {
                            ((a.v as i64) % (b.v as i64)) as u64
                        }
                    }
                    BinOp::Shl => a.v.wrapping_shl(b.v as u32),
                    BinOp::Shr => a.v.wrapping_shr(b.v as u32),
                    BinOp::Eq => (a.v == b.v) as u64,
                    BinOp::Ne => (a.v != b.v) as u64,
                    BinOp::Lt => (a.v < b.v) as u64,
                    BinOp::Le => (a.v <= b.v) as u64,
                    BinOp::Gt => (a.v > b.v) as u64,
                    BinOp::Ge => (a.v >= b.v) as u64,
                    BinOp::BitAnd => a.v & b.v,
                    BinOp::BitOr => a.v | b.v,
                    BinOp::BitXor => a.v ^ b.v,
                    BinOp::LogAnd => ((a.v != 0) && (b.v != 0)) as u64,
                    BinOp::LogOr => ((a.v != 0) || (b.v != 0)) as u64,
                };
                // Section-relative + absolute keeps the section;
                // difference of two section values is absolute.
                let att = match (op, a.att, b.att) {
                    (BinOp::Add, Att::Out(s), Att::Abs) => Att::Out(s),
                    (BinOp::Add, Att::Abs, Att::Out(s)) => Att::Out(s),
                    (BinOp::Sub, Att::Out(s), Att::Abs) => Att::Out(s),
                    // A dot address plus/minus a number stays a dot
                    // address; any other combination is a number.
                    (BinOp::Add, Att::DotAbs, Att::Abs) => Att::DotAbs,
                    (BinOp::Add, Att::Abs, Att::DotAbs) => Att::DotAbs,
                    (BinOp::Sub, Att::DotAbs, Att::Abs) => Att::DotAbs,
                    _ => Att::Abs,
                };
                Val { v, att }
            }
            Expr::Ternary(c, t, f) => {
                let c = self.eval_inner(c);
                if c.v != 0 {
                    self.eval_inner(t)
                } else {
                    self.eval_inner(f)
                }
            }
            Expr::AlignDot(a) => {
                let a = self.eval_inner(a);
                let att = match self.cur_out {
                    Some(o) => Att::Out(o),
                    None => Att::DotAbs,
                };
                Val {
                    v: align_up(self.dot, a.v),
                    att,
                }
            }
            Expr::Align2(v, a) => {
                let (v, a) = (self.eval_inner(v), self.eval_inner(a));
                Val {
                    v: align_up(v.v, a.v),
                    att: v.att,
                }
            }
            Expr::Absolute(a) => Val::abs(self.eval_inner(a).v),
            Expr::Addr(name) => match self.find_out(name) {
                Some(oi) => Val {
                    v: self.outs[oi].addr,
                    att: Att::Out(oi),
                },
                None => {
                    if self.final_pass {
                        self.errors
                            .push(format!("ADDR({name}): no such output section"));
                    }
                    Val::abs(0)
                }
            },
            Expr::Loadaddr(name) => match self.find_out(name) {
                Some(oi) => Val::abs(self.outs[oi].lma),
                None => {
                    if self.final_pass {
                        self.errors
                            .push(format!("LOADADDR({name}): no such output section"));
                    }
                    Val::abs(0)
                }
            },
            Expr::Sizeof(name) => Val::abs(
                self.find_out(name)
                    .map(|oi| self.outs[oi].size)
                    .unwrap_or(0),
            ),
            Expr::Alignof(name) => Val::abs(
                self.find_out(name)
                    .map(|oi| self.outs[oi].align)
                    .unwrap_or(0),
            ),
            Expr::SizeofHeaders => {
                let phnum = self.phdr_count_estimate();
                Val::abs(self.class.ehdr_size() + phnum as u64 * self.class.phdr_size())
            }
            Expr::Defined(name) => {
                let defined = self.script_now.contains_key(name)
                    || self.script_prev.contains_key(name)
                    || self.globals.contains_key(name);
                Val::abs(defined as u64)
            }
            Expr::Min(a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                Val::abs(a.v.min(b.v))
            }
            Expr::Max(a, b) => {
                let (a, b) = (self.eval_inner(a), self.eval_inner(b));
                Val::abs(a.v.max(b.v))
            }
            Expr::Assert(inner, msg) => {
                let v = self.eval_inner(inner);
                if self.final_pass && v.v == 0 {
                    self.errors.push(format!("assertion failed: {msg}"));
                }
                v
            }
        }
    }
}
