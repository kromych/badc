//! Assembler expression evaluation: the location-value domain a `.set`,
//! a data directive operand or an instruction field expression folds
//! into, the GNU as operator grouping over it, and the constant-only
//! entry points the template parsers use.

use super::*;
// Assembler code still held by the SSA emit substrate; folds in as the
// remaining groups move over.
use crate::c5::codegen::ssa::emit_common::{AsmBindingNames, AsmSectionTarget, AsmSpace};

/// One symbolic term of an expression value: where the location lives when
/// it is laid out in this unit (`None` for an undefined symbol), and the
/// relocation target a field referencing it takes. The offset participates
/// in same-space folding only; a relocation's addend never includes it,
/// because the target itself carries the position.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmExprTerm {
    pub space: Option<(AsmSpace, i64)>,
    pub target: AsmSectionTarget,
}

/// An assembler expression value, as GNU as models it: a constant plus at
/// most one added and one subtracted symbolic base. Same-space bases cancel
/// into the constant; any richer combination is rejected.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) struct AsmExprValue {
    pub(crate) add: i64,
    pub(crate) pos: Option<AsmExprTerm>,
    pub(crate) neg: Option<AsmExprTerm>,
}

impl AsmExprValue {
    /// The symbol this value names when it is a single term with nothing
    /// subtracted from it -- the shape whose PC-relativity comes from the
    /// encoding rather than from a difference written in the source.
    fn lone_symbol(&self) -> Option<&str> {
        match (&self.pos, &self.neg) {
            (Some(t), None) => match &t.target {
                AsmSectionTarget::Symbol(n) => Some(n.as_str()),
                _ => None,
            },
            _ => None,
        }
    }

    /// The constant part of the value.
    fn constant(&self) -> i64 {
        self.add
    }
}

/// The constant distance from `n` to `p`: locations of one space differ by
/// their offsets, two references to one undefined symbol cancel.
fn term_distance(p: &AsmExprTerm, n: &AsmExprTerm) -> Option<i64> {
    match (&p.space, &n.space) {
        (Some((ps, po)), Some((ns, no))) if ps == ns => Some(po - no),
        (None, None) if p.target == n.target => Some(0),
        _ => None,
    }
}

/// A resolved leaf of an expression: an absolute value (a literal, an
/// operand constant, a `.set` symbol) or a location-valued term.
pub(crate) enum AsmExprLeaf {
    Abs(i64),
    Loc(AsmExprTerm),
}

/// Leaf resolution for [`eval_asm_value`]. `resolve` answers identifiers and
/// the location counter `"."`; an unresolved identifier is an undefined
/// symbol. `const_of` answers `%N` operand references. `lax_div` folds a
/// division or remainder by zero to zero instead of failing, for the
/// parse-time syntax check that runs with placeholder leaf values.
pub(crate) struct AsmExprCtx<'a> {
    pub resolve: &'a dyn Fn(&str) -> Option<AsmExprLeaf>,
    pub const_of: &'a dyn Fn(u8) -> Option<i64>,
    pub lax_div: bool,
}

/// What a fully evaluated expression deposits: a folded constant, or a
/// relocation with the addend the object writer applies on top of the
/// target's own position.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmResolved {
    Abs(i64),
    Reloc {
        target: AsmSectionTarget,
        addend: i64,
        pcrel: bool,
    },
}

/// What an instruction field's expression target resolves to against the
/// layout. `pcrel` is `None` where the encoding's own PC-relativity stands:
/// the reference names a symbol the link binds, so the field keeps the
/// relocation the encoding asked for.
#[derive(Debug, Clone, PartialEq, Eq)]
pub(crate) enum AsmFieldTarget {
    Abs(i64),
    Reloc {
        target: AsmSectionTarget,
        addend: i64,
        pcrel: Option<bool>,
    },
}

impl AsmExprValue {
    pub(crate) fn abs(v: i64) -> Self {
        AsmExprValue {
            add: v,
            pos: None,
            neg: None,
        }
    }
    pub(crate) fn from_term(t: AsmExprTerm) -> Self {
        AsmExprValue {
            add: 0,
            pos: Some(t),
            neg: None,
        }
    }
    pub(crate) fn to_abs(&self) -> Option<i64> {
        (self.pos.is_none() && self.neg.is_none()).then_some(self.add)
    }
    /// Combine `self + rhs` (`self - rhs` when `sub`), cancelling a positive
    /// against a negative base defined in one space.
    pub(crate) fn combine(mut self, rhs: Self, sub: bool) -> Result<Self, alloc::string::String> {
        let (rpos, rneg) = if sub {
            (rhs.neg, rhs.pos)
        } else {
            (rhs.pos, rhs.neg)
        };
        self.add = self
            .add
            .checked_add(if sub {
                rhs.add.checked_neg().ok_or("overflow")?
            } else {
                rhs.add
            })
            .ok_or("overflow in expression")?;
        let place = |slot: &mut Option<AsmExprTerm>,
                     t: Option<AsmExprTerm>|
         -> Result<(), alloc::string::String> {
            match t {
                None => Ok(()),
                Some(t) if slot.is_none() => {
                    *slot = Some(t);
                    Ok(())
                }
                Some(_) => Err(alloc::string::String::from(
                    "expression combines two symbols",
                )),
            }
        };
        place(&mut self.pos, rpos)?;
        place(&mut self.neg, rneg)?;
        // A positive and a negative location in one space are a constant
        // distance; fold them so the bases free up. Two references to one
        // undefined symbol cancel outright (GNU as folds `x - x`, which is
        // what lets `.if \base == %rsp` compare register text).
        if let (Some(p), Some(n)) = (&self.pos, &self.neg)
            && let Some(delta) = term_distance(p, n)
        {
            self.add += delta;
            self.pos = None;
            self.neg = None;
        }
        Ok(self)
    }
}

/// Resolve an evaluated expression at its deposit point. `deposit` names the
/// space and offset the value lands at; a subtracted base defined in that
/// space makes the result PC-relative (`ref - .`), with the distance between
/// the base and the field folded into the addend.
pub(crate) fn resolve_asm_value(
    v: AsmExprValue,
    deposit: Option<(&AsmSpace, i64)>,
) -> Result<AsmResolved, alloc::string::String> {
    match (v.pos, v.neg) {
        (None, None) => Ok(AsmResolved::Abs(v.add)),
        (Some(p), None) => Ok(AsmResolved::Reloc {
            target: p.target,
            addend: v.add,
            pcrel: false,
        }),
        (Some(p), Some(n)) => {
            let Some((dspace, doff)) = deposit else {
                return Err(alloc::string::String::from(
                    "expression subtracts a symbol outside a data field",
                ));
            };
            match n.space {
                Some((ns, no)) if ns == *dspace => Ok(AsmResolved::Reloc {
                    target: p.target,
                    addend: v.add + (doff - no),
                    pcrel: true,
                }),
                Some(_) => Err(alloc::string::String::from(
                    "label difference crosses sections and is not PC-relative",
                )),
                None => Err(alloc::string::String::from(
                    "expression subtracts an undefined symbol",
                )),
            }
        }
        (None, Some(_)) => Err(alloc::string::String::from(
            "expression subtracts a symbol from a constant",
        )),
    }
}

/// Resolve an instruction field's expression target at `place` in `space`:
/// the expression plus the encoding's own addend, made PC-relative where the
/// field measures from itself. GNU as folds a difference of symbols whatever
/// their binding, but a lone symbol the link binds keeps its relocation, so
/// naming it leaves the encoding's PC-relativity in place.
pub(crate) fn resolve_asm_field_expr(
    text: &str,
    ctx: &AsmExprCtx,
    space: &AsmSpace,
    place: i64,
    addend: i64,
    self_rel: bool,
    non_local: &AsmBindingNames<'_>,
) -> Result<AsmFieldTarget, alloc::string::String> {
    let named = |e: alloc::string::String| alloc::format!("inline asm: `{text}`: {e}");
    let mut v = eval_asm_value(text, ctx)
        .and_then(|v| v.combine(AsmExprValue::abs(addend), false))
        .map_err(named)?;
    if let Some(n) = v.lone_symbol().filter(|n| non_local.contains(n)) {
        return Ok(AsmFieldTarget::Reloc {
            target: AsmSectionTarget::Symbol(alloc::string::String::from(n)),
            addend: v.constant(),
            pcrel: None,
        });
    }
    if self_rel {
        v = v
            .combine(
                AsmExprValue::from_term(AsmExprTerm {
                    space: Some((space.clone(), place)),
                    target: AsmSectionTarget::OwnSection(place as u32),
                }),
                true,
            )
            .map_err(named)?;
    }
    Ok(
        match resolve_asm_value(v, Some((space, place))).map_err(named)? {
            AsmResolved::Abs(c) => AsmFieldTarget::Abs(c),
            AsmResolved::Reloc {
                target,
                addend,
                pcrel,
            } => AsmFieldTarget::Reloc {
                target,
                addend,
                pcrel: Some(pcrel),
            },
        },
    )
}

/// Split an operand expression into one symbol and a constant addend. This
/// is what a field outside a materialized section can carry: the in-function
/// relocation channels name a symbol and an offset, with no layout to fold a
/// label difference against. `None` for any richer expression.
pub(crate) fn asm_expr_sym_addend(expr: &str) -> Option<(alloc::string::String, i64)> {
    let ctx = AsmExprCtx {
        resolve: &|_| None,
        const_of: &|_| None,
        lax_div: false,
    };
    match resolve_asm_value(eval_asm_value(expr, &ctx).ok()?, None).ok()? {
        AsmResolved::Reloc {
            target: AsmSectionTarget::Symbol(name),
            addend,
            pcrel: false,
        } => Some((name, addend)),
        _ => None,
    }
}

/// Evaluate an assembler integer constant expression: decimal / hex literals
/// combined with the C operators an assembler accepts, and parentheses.
/// Returns `None` when the text is not a self-contained constant, which is
/// how a label or symbol reference is distinguished from an expression.
pub(crate) fn eval_const_expr(s: &str) -> Option<i64> {
    eval_const_expr_ops(s, &|_| None)
}

/// Evaluate a constant expression whose leaves may include `%N` / `%cN` /
/// `%PN` operand references, resolved through `op` (an operand's compile-time
/// constant). With `op` yielding `None` this is the literal-only evaluator
/// above; a section value defers `op` to materialize time, where the operand
/// constants are known.
pub(crate) fn eval_const_expr_ops(s: &str, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    let ctx = AsmExprCtx {
        resolve: &|_| None,
        const_of: op,
        lax_div: false,
    };
    eval_asm_value(s, &ctx).ok().and_then(|v| v.to_abs())
}

/// Evaluate an assembler `.if` condition: a constant expression whose result
/// may come from the comparison (-1/0) and logical (1/0) operators. A
/// non-zero result is true. `None` when the condition is not a constant.
pub(crate) fn eval_asm_if_condition(s: &str) -> Option<i64> {
    eval_asm_count(s, &|_| None)
}

/// Evaluate a constant expression whose leaves may include `%N` / `%cN`
/// operand references, resolved through `op`. This is the form a
/// `.skip` / `.fill` count takes.
pub(crate) fn eval_asm_count(s: &str, op: &dyn Fn(u8) -> Option<i64>) -> Option<i64> {
    eval_const_expr_ops(s, op)
}

/// Evaluate a GNU as constant expression whose leaves may be label
/// references, resolved through `resolve` (a label name to its value). The
/// alternatives `.skip` count mixes template-label and section-label
/// differences (`-(((775f-774f)-(772b-771b)) > 0) * (...)`). `None` when a
/// leaf is unresolved or the result is not a constant.
pub(crate) fn eval_asm_expr_with_labels(
    expr: &str,
    resolve: &dyn Fn(&str) -> Option<i64>,
) -> Option<i64> {
    let ctx = AsmExprCtx {
        resolve: &|t| resolve(t).map(AsmExprLeaf::Abs),
        const_of: &|_| None,
        lax_div: false,
    };
    eval_asm_value(expr, &ctx).ok().and_then(|v| v.to_abs())
}

/// Whether `tok` is a well-formed GNU as expression whose value only the
/// layout knows. Every leaf stands in as zero, so this checks grammar alone.
pub(crate) fn is_asm_layout_expr(tok: &str) -> bool {
    let ctx = AsmExprCtx {
        resolve: &|_| Some(AsmExprLeaf::Abs(0)),
        const_of: &|_| None,
        lax_div: true,
    };
    !tok.is_empty() && eval_asm_value(tok, &ctx).is_ok()
}

fn skip_ws(b: &[u8], i: &mut usize) {
    while *i < b.len() && b[*i].is_ascii_whitespace() {
        *i += 1;
    }
}

/// Evaluate an assembler expression over the location-value domain. The
/// operator grouping is GNU as's: `* / % << >>` bind tightest, then
/// `| & ^`, then `+ -`, then the comparisons (yielding -1/0), then `&&`
/// and `||` (yielding 1/0). Only `+` and `-` operate on symbolic terms;
/// every other operator requires absolute operands.
pub(crate) fn eval_asm_value(
    s: &str,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let b = s.as_bytes();
    let mut i = 0usize;
    let v = val_logor(b, s, &mut i, ctx)?;
    skip_ws(b, &mut i);
    if i != b.len() {
        return Err(alloc::format!("junk `{}` after expression", &s[i..]));
    }
    Ok(v)
}

/// Require an absolute operand for a non-additive operator.
fn val_abs(v: AsmExprValue, opname: &str) -> Result<i64, alloc::string::String> {
    v.to_abs()
        .ok_or_else(|| alloc::format!("operand of `{opname}` is not absolute"))
}

fn val_logor(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_logand(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        if b.get(*i) == Some(&b'|') && b.get(*i + 1) == Some(&b'|') {
            *i += 2;
            let rhs = val_logand(b, s, i, ctx)?;
            v = AsmExprValue::abs(((val_abs(v, "||")? != 0) || (val_abs(rhs, "||")? != 0)) as i64);
        } else {
            return Ok(v);
        }
    }
}

fn val_logand(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_relational(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        if b.get(*i) == Some(&b'&') && b.get(*i + 1) == Some(&b'&') {
            *i += 2;
            let rhs = val_relational(b, s, i, ctx)?;
            v = AsmExprValue::abs(((val_abs(v, "&&")? != 0) && (val_abs(rhs, "&&")? != 0)) as i64);
        } else {
            return Ok(v);
        }
    }
}

fn val_relational(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_add(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        let (rel, len): (fn(i64, i64) -> bool, usize) = match (b.get(*i), b.get(*i + 1)) {
            (Some(b'='), Some(b'=')) => (|a, c| a == c, 2),
            (Some(b'!'), Some(b'=')) => (|a, c| a != c, 2),
            (Some(b'<'), Some(b'>')) => (|a, c| a != c, 2),
            (Some(b'<'), Some(b'=')) => (|a, c| a <= c, 2),
            (Some(b'>'), Some(b'=')) => (|a, c| a >= c, 2),
            (Some(b'<'), n) if n != Some(&b'<') => (|a, c| a < c, 1),
            (Some(b'>'), n) if n != Some(&b'>') => (|a, c| a > c, 1),
            _ => return Ok(v),
        };
        let equality = matches!(
            (b[*i], b.get(*i + 1)),
            (b'=', _) | (b'!', _) | (b'<', Some(b'>'))
        );
        *i += len;
        let rhs = val_add(b, s, i, ctx)?;
        // GNU as yields -1 (all bits set) for a true comparison, 0 for false;
        // the alternatives `.skip` padding `-((rlen-slen) > 0) * (rlen-slen)`
        // relies on the -1 to recover a positive count. The comparison is of
        // the difference against zero, so same-space terms cancel first. An
        // equality between two undefined symbols compares the symbols, which
        // GNU as reads as unequal (`.if \base == %rsp` with two register
        // names); a residual term that is a location in this unit is a
        // distance the comparison cannot take before the layout gives it one.
        let d = v.combine(rhs, true)?;
        let undefined = |t: &Option<AsmExprTerm>| t.as_ref().is_none_or(|t| t.space.is_none());
        let truth = match d.to_abs() {
            Some(d) => rel(d, 0),
            None if equality && undefined(&d.pos) && undefined(&d.neg) => rel(1, 0),
            None => {
                return Err(alloc::string::String::from(
                    "operand of `comparison` is not absolute",
                ));
            }
        };
        v = AsmExprValue::abs(if truth { -1 } else { 0 });
    }
}

fn val_add(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_bitgroup(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        let sub = match b.get(*i) {
            Some(b'+') => false,
            Some(b'-') => true,
            _ => return Ok(v),
        };
        *i += 1;
        let rhs = val_bitgroup(b, s, i, ctx)?;
        v = v.combine(rhs, sub)?;
    }
}

/// `| & ^` share one precedence level in GNU as, associating left.
fn val_bitgroup(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_mul(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        let op = match b.get(*i) {
            Some(&c @ b'|') if b.get(*i + 1) != Some(&b'|') => c,
            Some(&c @ b'&') if b.get(*i + 1) != Some(&b'&') => c,
            Some(&c @ b'^') => c,
            _ => return Ok(v),
        };
        *i += 1;
        let rhs = val_mul(b, s, i, ctx)?;
        let (a, c) = (val_abs(v, "bitwise op")?, val_abs(rhs, "bitwise op")?);
        v = AsmExprValue::abs(match op {
            b'|' => a | c,
            b'&' => a & c,
            _ => a ^ c,
        });
    }
}

/// `* / % << >>` share the tightest binary level in GNU as.
fn val_mul(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    let mut v = val_unary(b, s, i, ctx)?;
    loop {
        skip_ws(b, i);
        let op = match (b.get(*i), b.get(*i + 1)) {
            (Some(&c @ (b'*' | b'/' | b'%')), _) => {
                *i += 1;
                c
            }
            (Some(b'<'), Some(b'<')) => {
                *i += 2;
                b'l'
            }
            (Some(b'>'), Some(b'>')) => {
                *i += 2;
                b'r'
            }
            _ => return Ok(v),
        };
        let rhs = val_unary(b, s, i, ctx)?;
        let (a, c) = (val_abs(v, "arithmetic op")?, val_abs(rhs, "arithmetic op")?);
        let r = match op {
            b'*' => a.checked_mul(c).ok_or("overflow in expression")?,
            b'/' | b'%' if c == 0 => {
                if !ctx.lax_div {
                    return Err(alloc::string::String::from("division by zero"));
                }
                0
            }
            b'/' => a.wrapping_div(c),
            b'%' => a.wrapping_rem(c),
            _ => {
                if !(0..64).contains(&c) {
                    return Err(alloc::format!("shift count {c} out of range"));
                }
                // GNU as shifts the 64-bit value, so `>>` does not replicate
                // the sign bit: `~0 >> 63` is 1, not -1.
                if op == b'l' {
                    a << c
                } else {
                    ((a as u64) >> c) as i64
                }
            }
        };
        v = AsmExprValue::abs(r);
    }
}

fn val_unary(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    skip_ws(b, i);
    match b.get(*i) {
        Some(b'-') => {
            *i += 1;
            AsmExprValue::abs(0).combine(val_unary(b, s, i, ctx)?, true)
        }
        Some(b'+') => {
            *i += 1;
            val_unary(b, s, i, ctx)
        }
        Some(b'~') => {
            *i += 1;
            Ok(AsmExprValue::abs(!val_abs(val_unary(b, s, i, ctx)?, "~")?))
        }
        // Prefix logical negation, yielding 1/0; `!=` in operand position is
        // the relational operator.
        Some(b'!') if b.get(*i + 1) != Some(&b'=') => {
            *i += 1;
            Ok(AsmExprValue::abs(
                (val_abs(val_unary(b, s, i, ctx)?, "!")? == 0) as i64,
            ))
        }
        Some(b'(') => {
            *i += 1;
            let v = val_logor(b, s, i, ctx)?;
            skip_ws(b, i);
            if b.get(*i) != Some(&b')') {
                return Err(alloc::string::String::from("missing `)` in expression"));
            }
            *i += 1;
            Ok(v)
        }
        // `%N` / `%cN` / `%PN`: an operand's compile-time constant. Any
        // other `%name` is a symbol, as GNU as reads it in an expression
        // (`.if \base == %rsp` compares two references to one symbol).
        Some(b'%') => {
            let pct = *i;
            *i += 1;
            let modifier = matches!(b.get(*i), Some(b'c' | b'P'));
            if modifier {
                *i += 1;
            }
            let start = *i;
            while *i < b.len() && b[*i].is_ascii_digit() {
                *i += 1;
            }
            if *i == start {
                let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
                *i = pct + 1;
                while *i < b.len() && ident(b[*i]) {
                    *i += 1;
                }
                if *i == pct + 1 {
                    return Err(alloc::string::String::from(
                        "bad operand reference in expression",
                    ));
                }
                return Ok(AsmExprValue::from_term(AsmExprTerm {
                    space: None,
                    target: AsmSectionTarget::Symbol(alloc::string::String::from(&s[pct..*i])),
                }));
            }
            let idx: u8 = s
                .get(start..*i)
                .and_then(|t| t.parse().ok())
                .ok_or("bad operand reference in expression")?;
            (ctx.const_of)(idx)
                .map(AsmExprValue::abs)
                .ok_or_else(|| alloc::format!("operand %{idx} is not a constant"))
        }
        _ => val_leaf(b, s, i, ctx),
    }
}

/// A leaf: a literal, the location counter `.`, a numeric-label reference
/// (`14472b`), or an identifier -- a `.set` symbol, a label, or an
/// undefined symbol.
fn val_leaf(
    b: &[u8],
    s: &str,
    i: &mut usize,
    ctx: &AsmExprCtx,
) -> Result<AsmExprValue, alloc::string::String> {
    skip_ws(b, i);
    if let Some((v, next)) = parse_asm_char_const(b, *i) {
        *i = next;
        return Ok(AsmExprValue::abs(v));
    }
    let ident = |c: u8| c.is_ascii_alphanumeric() || matches!(c, b'_' | b'.' | b'$');
    let start = *i;
    while *i < b.len() && ident(b[*i]) {
        *i += 1;
    }
    if *i == start {
        return Err(alloc::format!(
            "expression expected at `{}`",
            &s[start..s.len().min(start + 12)]
        ));
    }
    let tok = &s[start..*i];
    let leaf_of = |tok: &str| -> Result<AsmExprValue, alloc::string::String> {
        match (ctx.resolve)(tok) {
            Some(AsmExprLeaf::Abs(v)) => Ok(AsmExprValue::abs(v)),
            Some(AsmExprLeaf::Loc(t)) => Ok(AsmExprValue::from_term(t)),
            // An unresolved name is an undefined symbol: a bare term the
            // deposit turns into a relocation (or rejects where an absolute
            // value is required).
            None => Ok(AsmExprValue::from_term(AsmExprTerm {
                space: None,
                target: AsmSectionTarget::Symbol(alloc::string::String::from(tok)),
            })),
        }
    };
    if tok == "." {
        return match (ctx.resolve)(".") {
            Some(AsmExprLeaf::Abs(v)) => Ok(AsmExprValue::abs(v)),
            Some(AsmExprLeaf::Loc(t)) => Ok(AsmExprValue::from_term(t)),
            None => Err(alloc::string::String::from(
                "the location counter `.` is not available here",
            )),
        };
    }
    if tok.as_bytes()[0].is_ascii_digit() {
        // A digit run ending in `b` / `f` is a numeric-label reference,
        // except a binary literal (`0b101`).
        if let Some(digits) = numeric_label_digits(tok)
            && digits.len() < tok.len()
            && !(tok.len() > 2 && (tok.starts_with("0b") || tok.starts_with("0B")))
        {
            return leaf_of(tok);
        }
        return parse_asm_number(tok)
            .map(AsmExprValue::abs)
            .ok_or_else(|| alloc::format!("bad numeric literal `{tok}`"));
    }
    leaf_of(tok)
}

/// Parse a GNU as character constant `'c'` at `at`, returning its value and
/// the index past it. The escapes are C's plus GNU as's octal and hex forms.
/// GNU as also accepts the unterminated `'c` spelling.
pub(crate) fn parse_asm_char_const(b: &[u8], at: usize) -> Option<(i64, usize)> {
    if b.get(at) != Some(&b'\'') {
        return None;
    }
    let mut i = at + 1;
    let c = *b.get(i)?;
    i += 1;
    let v = if c != b'\\' {
        c as i64
    } else {
        let e = *b.get(i)?;
        i += 1;
        match e {
            b'n' => 10,
            b't' => 9,
            b'r' => 13,
            b'b' => 8,
            b'f' => 12,
            b'v' => 11,
            b'a' => 7,
            b'e' => 27,
            b'x' | b'X' => {
                let start = i;
                let mut v: i64 = 0;
                while let Some(d) = b.get(i).and_then(|c| (*c as char).to_digit(16)) {
                    v = (v << 4) | d as i64;
                    i += 1;
                }
                if i == start {
                    return None;
                }
                v & 0xff
            }
            b'0'..=b'7' => {
                let mut v = (e - b'0') as i64;
                for _ in 0..2 {
                    match b.get(i) {
                        Some(d @ b'0'..=b'7') => {
                            v = (v << 3) | (d - b'0') as i64;
                            i += 1;
                        }
                        _ => break,
                    }
                }
                v & 0xff
            }
            other => other as i64,
        }
    };
    if b.get(i) == Some(&b'\'') {
        i += 1;
    }
    Some((v, i))
}

/// Parse an assembler integer literal: decimal, `0x` hex, `0b` binary, or
/// `0`-prefixed octal, with the C suffixes accepted and ignored. The value
/// wraps at 64 bits, as GNU as computes.
pub(crate) fn parse_asm_number(t: &str) -> Option<i64> {
    let t = t.trim_end_matches(['u', 'U', 'l', 'L']);
    let (radix, digits) = if let Some(h) = t.strip_prefix("0x").or_else(|| t.strip_prefix("0X")) {
        (16, h)
    } else if let Some(bin) = t.strip_prefix("0b").or_else(|| t.strip_prefix("0B")) {
        (2, bin)
    } else if t.len() > 1 && t.starts_with('0') {
        (8, &t[1..])
    } else {
        (10, t)
    };
    if digits.is_empty() {
        return None;
    }
    u64::from_str_radix(digits, radix).ok().map(|v| v as i64)
}

/// Evaluate a data-directive value as a 128-bit constant. A literal too wide
/// for 64 bits parses directly (GNU as accepts a bignum wherever the
/// directive's field can hold it); anything else falls back to the 64-bit
/// expression evaluator and sign-extends, as GNU as does for `.octa -1`.
pub(crate) fn eval_const_expr_wide(s: &str) -> Option<i128> {
    let t = s.trim();
    let digits = t.trim_end_matches(['u', 'U', 'l', 'L']);
    if let Some(h) = digits
        .strip_prefix("0x")
        .or_else(|| digits.strip_prefix("0X"))
        && !h.is_empty()
        && let Ok(v) = u128::from_str_radix(h, 16)
    {
        return Some(v as i128);
    }
    eval_const_expr(t).map(i128::from)
}

/// Append the low `width` bytes of a value, little-endian. A field wider than
/// the evaluated expression takes its sign extension.
pub(crate) fn push_le(out: &mut alloc::vec::Vec<u8>, value: i128, width: usize) {
    out.extend_from_slice(&value.to_le_bytes()[..width]);
}

#[cfg(test)]
mod const_expr_tests {
    use super::eval_const_expr;

    #[test]
    fn literals_and_arithmetic() {
        assert_eq!(eval_const_expr("42"), Some(42));
        assert_eq!(eval_const_expr("0x1F"), Some(31));
        assert_eq!(eval_const_expr("0X10"), Some(16));
        assert_eq!(eval_const_expr("-7"), Some(-7));
        assert_eq!(eval_const_expr("  12  "), Some(12));
        // The feature-word encoding an assembler folds for a section value.
        assert_eq!(eval_const_expr("(16*32+22)"), Some(534));
        // Displacement expressions in a memory operand.
        assert_eq!(eval_const_expr("0*8"), Some(0));
        assert_eq!(eval_const_expr("3*8"), Some(24));
    }

    #[test]
    fn precedence_and_grouping() {
        assert_eq!(eval_const_expr("2+3*4"), Some(14));
        assert_eq!(eval_const_expr("(2+3)*4"), Some(20));
        assert_eq!(eval_const_expr("1<<3"), Some(8));
        assert_eq!(eval_const_expr("(1<<3)|2"), Some(10));
        assert_eq!(eval_const_expr("0xF0|0x0F"), Some(255));
        assert_eq!(eval_const_expr("0xFF&0x0F"), Some(15));
        assert_eq!(eval_const_expr("5^3"), Some(6));
        assert_eq!(eval_const_expr("~0"), Some(-1));
        assert_eq!(eval_const_expr("-(2+3)"), Some(-5));
        assert_eq!(eval_const_expr("17%5"), Some(2));
        assert_eq!(eval_const_expr("17/5"), Some(3));
        assert_eq!(eval_const_expr("1<<3|2"), Some(10));
        assert_eq!(eval_const_expr("64>>2"), Some(16));
        // C-style integer suffixes, as GNU as accepts (`mov $(1U << 8)`);
        // a numeric label reference (`1b` / `2f`) stays a non-constant.
        assert_eq!(eval_const_expr("(1U << 8)"), Some(256));
        assert_eq!(eval_const_expr("2UL"), Some(2));
        assert_eq!(eval_const_expr("3ull + 1"), Some(4));
    }

    /// Anything that is not a self-contained constant yields `None`, which is
    /// how a label or symbol reference stays distinguishable.
    #[test]
    fn non_constants_reject() {
        assert_eq!(eval_const_expr("foo"), None);
        assert_eq!(eval_const_expr("1b"), None);
        assert_eq!(eval_const_expr("775f-774f"), None);
        assert_eq!(eval_const_expr(""), None);
        assert_eq!(eval_const_expr("(1+2"), None);
        assert_eq!(eval_const_expr("1+"), None);
        assert_eq!(eval_const_expr("1/0"), None);
        assert_eq!(eval_const_expr("1%0"), None);
        assert_eq!(eval_const_expr("1<<64"), None);
        assert_eq!(eval_const_expr("2 3"), None);
    }
}
