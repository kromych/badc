//! Loop-idiom recognition for the counted element copy and fill.
//!
//! A counted loop whose body is one element store computes the same
//! result as a single memory transfer over the byte range it walks:
//! either a read of the matching element of a second array (copy) or a
//! loop-invariant value (fill). The rewrite emits what
//! `__builtin_memcpy` / `__builtin_memset` already lower to -- an
//! inline expansion for a constant byte count within the expansion
//! caps, otherwise a call to the library function of the same name.
//!
//! Two loop shapes are recognized. The indexed one,
//! `for (<init>; i < limit; i++) dst[i] = src[i];` (copy) and the same
//! header over `dst[i] = value;` (fill), becomes
//! `{ <init>; if (i < limit) { <transfer>; i = limit; } }`: the loop's
//! own controlling expression guards the transfer, so a zero or
//! negative trip count behaves as it did, and the trailing assignment
//! restores the value the loop leaves in `i` (skipped where the
//! for-init declares it, C99 6.8.5.3). The pointer-walking one,
//! `while (c > k - 1) { dst[0] = src[0]; ...; dst += k; src += k;
//! c -= k; }`, transfers the `c` rounded down to a multiple of `k`
//! elements its test admits and advances the three control variables
//! past them. TODO: the spellings that step the counter in the
//! controlling expression (`while (c--)`) need a side-effect-free test
//! of their own before the loop can be kept as the guard's false arm.
//!
//! Proof obligations, all checked before the rewrite:
//!
//! * no volatile access -- an access to a volatile object may not be
//!   coalesced (C99 5.1.2.3p2);
//! * one effect only: the body is the recognized set of assignments and
//!   nothing else, so the loop calls nothing, stores nowhere else, and
//!   has no exit of its own;
//! * the loop's stores cannot reach the values the transfer reads. A
//!   store through `dst[i]` stays inside the object `dst` designates
//!   (C99 6.5.6p8), so where `dst` names a declared array every other
//!   declared object is out of its reach; where `dst` is a pointer the
//!   control values must be locals whose address the function never
//!   takes, which leaves no pointer that could designate them;
//! * non-overlap for the copy (C99 7.21.2.1), either proved or tested.
//!   Two distinct declared array objects cannot overlap, and copy
//!   between them. Anything else is versioned on
//!   `(size_t)dst - (size_t)src >= bytes`, which holds exactly when the
//!   ascending element loop and `memmove` agree: above it the objects
//!   are disjoint, and the wrapped difference a destination below its
//!   source produces is a range the ascending loop reads before it
//!   writes. Below it the loop replicates and the original runs.
//!   `memcpy` is not the transfer there -- it takes disjoint objects
//!   only, which one compare does not establish. TODO: prove
//!   disjointness from `restrict` (C99 6.7.3.1) once the type encoding
//!   records it, and skip the version;
//! * element widths are the 1/2/4/8 bytes the transfer machinery
//!   handles, and a copy's element types agree, so the assignment
//!   converts nothing and stores the bytes it loaded. Aggregates are
//!   excluded: their assignment is itself a transfer, not an element
//!   store. A fill's value has to be one `memset` writes the same bytes
//!   for -- any integer value for a one-byte element, and for a wider
//!   one a constant whose stored representation repeats a single byte.
//!
//! Runs under `-O`, once the body is parsed: the address scan the third
//! obligation needs covers the whole function only then.

use alloc::collections::BTreeSet;
use alloc::vec::Vec;

use super::super::ast::expr_ty;
use super::super::ast::{
    BlockItem, Decl, Expr, ExprId, LocalInit, MemTransferOp, SLOT_ALIGN, SrcPos, Stmt, StmtId, UnOp,
};
use super::super::ir::BinOp;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::expr::{MAX_MEM_TRANSFER_ALIGN, mem_transfer_fits};
use super::types::{
    UNSIGNED_BIT, VOLATILE_MASK, is_bool_ty, is_floating_ty, is_pointer_ty, is_struct_value_ty,
    is_unsigned_ty, narrow_const_int,
};

/// A counted loop that passed the shape match: `for (init; i < limit;
/// i++)` with an induction variable wide enough not to wrap before the
/// limit.
struct Counted {
    /// The induction variable's `Ident` node, reused as the guard's
    /// operand and the final-value assignment's target.
    iv: ExprId,
    iv_sym: u32,
    iv_val: i64,
    iv_ty: i64,
    /// Constant the for-init assigns to the induction variable.
    start: Option<i64>,
    /// True when the for-init declares the induction variable, whose
    /// scope then ends with the loop.
    declares_iv: bool,
    limit: ExprId,
    limit_const: Option<i64>,
    /// The comparison is unsigned, so the trip count is the difference
    /// of the zero-extended operands.
    unsigned_cmp: bool,
    cond: ExprId,
    init: Option<BlockItem>,
}

/// A loop that walks two pointers and a counter by a fixed number of
/// elements per iteration.
struct Walk {
    cond: ExprId,
    counter: ExprId,
    counter_ty: i64,
    /// Elements the body copies, and the amount it subtracts from the
    /// counter, per iteration.
    step: i64,
    dst: ExprId,
    src: ExprId,
    width: i64,
}

/// Largest number of element copies a blocked body may hold.
const MAX_WALK_STEP: i64 = 8;

/// How a copy's non-overlap is discharged.
#[derive(Clone, Copy, PartialEq)]
enum Overlap {
    /// Two distinct declared array objects.
    Proved,
    /// Versioned on a runtime disjointness test.
    Runtime,
}

/// The transfer a matched body denotes.
struct Transfer {
    op: MemTransferOp,
    /// Base pointer of the destination, and its declared object when
    /// the base names an array.
    dst: ExprId,
    dst_object: Option<u32>,
    /// Source base pointer for a copy, the stored value for a fill.
    src: ExprId,
    /// Fill byte, where the stored value is a constant. `None` leaves
    /// the value to `src`.
    fill_byte: Option<i64>,
    /// Byte offset of the loop's first element, as the subscript
    /// expression the body already carries.
    idx: ExprId,
    width: i64,
    align: u32,
    overlap: Overlap,
}

/// The statements that replace a matched loop:
/// `{ <init>; if (<cond>) { if (<guard>) { <body> } else <fallback> } }`,
/// each part dropped where it is not needed.
struct Rewrite {
    init: Option<BlockItem>,
    cond: Option<ExprId>,
    guard: Option<ExprId>,
    body: Vec<ExprId>,
    fallback: Option<StmtId>,
}

/// Low `width` bytes.
fn mask(width: i64) -> u64 {
    u64::MAX >> (64 - width * 8)
}

impl Compiler {
    /// Rewrite every recognized copy / fill loop in the function whose
    /// body was just parsed.
    pub(super) fn rewrite_loop_idioms(&mut self) {
        if !self.optimize || self.ast.body.is_none() {
            return;
        }
        // An inline-asm memory operand reaches a local without an `&`
        // node for the address scan to find.
        if !self.ast.asm_blocks.is_empty()
            || self
                .ast
                .stmts
                .iter()
                .any(|s| matches!(s, Stmt::Asm { .. } | Stmt::AsmGoto(_)))
        {
            return;
        }
        let loops: Vec<StmtId> = self
            .ast
            .stmts
            .iter()
            .enumerate()
            .filter(|(_, s)| matches!(s, Stmt::For { .. } | Stmt::While { .. }))
            .map(|(i, _)| i as StmtId)
            .collect();
        if loops.is_empty() {
            return;
        }
        let escaped = self.escaped_symbols();
        for id in loops {
            self.try_rewrite_loop(id, &escaped);
        }
    }

    /// Symbols whose address the function takes. Keyed by symbol index,
    /// which is a name rather than an object: a shadowed declaration of
    /// the same name shares the entry, which only over-approximates.
    fn escaped_symbols(&self) -> BTreeSet<u32> {
        let mut set = BTreeSet::new();
        let mark = |set: &mut BTreeSet<u32>, e: ExprId| {
            if let Some(sym) = self.ident_sym(e) {
                set.insert(sym);
            }
        };
        for e in &self.ast.exprs {
            match e {
                Expr::Unary {
                    op: UnOp::AddrOf,
                    child,
                    ..
                } => mark(&mut set, *child),
                // The walker takes the address of an identifier operand
                // of these without an `&` node in the tree.
                Expr::Intrinsic { args, .. } | Expr::Atomic { args, .. } => {
                    for a in args {
                        mark(&mut set, *a);
                    }
                }
                Expr::CheckedArith { dst, .. } => mark(&mut set, *dst),
                _ => {}
            }
        }
        set
    }

    /// The identifier an expression reads, through value-preserving
    /// casts. `None` for any other shape.
    fn ident_sym(&self, e: ExprId) -> Option<u32> {
        match self.ast.expr(e) {
            Expr::Ident { sym, .. } => Some(*sym),
            Expr::Cast { child, .. } => self.ident_sym(*child),
            _ => None,
        }
    }

    fn try_rewrite_loop(&mut self, id: StmtId, escaped: &BTreeSet<u32>) -> Option<()> {
        let rewrite = match self.ast.stmt(id) {
            Stmt::For { .. } => self.plan_counted(id, escaped),
            _ => None,
        }
        .or_else(|| self.plan_walk(id, escaped))?;
        let pos = self.ast.stmt_src[id as usize];
        self.commit(id, rewrite, pos);
        Some(())
    }

    fn plan_counted(&mut self, id: StmtId, escaped: &BTreeSet<u32>) -> Option<Rewrite> {
        let loop_ = self.match_counted(id)?;
        let xfer = self.match_body(id, &loop_)?;
        self.check_effects(&loop_, &xfer, escaped)?;
        // A version's guard and kept loop are a fixed cost, taken
        // against an unknown trip count only: a constant one is already
        // what the unroller reduces, and the transfer that replaces it
        // would bar the promotion of a local array it writes.
        if xfer.overlap == Overlap::Runtime && self.const_bytes(&loop_, &xfer)?.is_some() {
            return None;
        }
        let pos = self.ast.stmt_src[id as usize];
        let call = self.build_transfer(&loop_, &xfer, pos)?;
        let mut body = alloc::vec![call];
        if !loop_.declares_iv {
            body.push(self.ast.push_expr(
                Expr::Assign {
                    lhs: loop_.iv,
                    rhs: loop_.limit,
                    ty: loop_.iv_ty,
                },
                pos,
            ));
        }
        // A constant trip count that reached here is positive; the
        // guard would fold, so it is left out.
        let taken = loop_.start.is_some() && loop_.limit_const.is_some();
        let (guard, fallback) = match xfer.overlap {
            Overlap::Proved => (None, None),
            Overlap::Runtime => {
                let bytes = self.count_expr(&loop_, &xfer, pos);
                let g = self.disjoint_guard(xfer.dst, xfer.src, bytes, pos);
                // The for-init has moved out of the loop, so the copy
                // the guard declines runs without it.
                let Stmt::For {
                    cond, post, body, ..
                } = *self.ast.stmt(id)
                else {
                    return None;
                };
                let f = self.ast.push_stmt(
                    Stmt::For {
                        init: None,
                        cond,
                        post,
                        body,
                    },
                    pos,
                );
                (Some(g), Some(f))
            }
        };
        Some(Rewrite {
            init: loop_.init,
            cond: (!taken).then_some(loop_.cond),
            guard,
            body,
            fallback,
        })
    }

    /// Match `for (init; i < limit; i++)`.
    fn match_counted(&self, id: StmtId) -> Option<Counted> {
        let Stmt::For {
            init,
            cond: Some(cond),
            post: Some(post),
            ..
        } = *self.ast.stmt(id)
        else {
            return None;
        };
        let (cmp, lhs, rhs) = match self.ast.expr(cond) {
            Expr::Binary { op, lhs, rhs, .. } => (*op, *lhs, *rhs),
            _ => return None,
        };
        let unsigned_cmp = match cmp {
            BinOp::Lt => false,
            BinOp::Ult => true,
            _ => return None,
        };
        let Expr::Ident {
            sym: iv_sym,
            ty: iv_ty,
            val: iv_val,
            ..
        } = *self.ast.expr(lhs)
        else {
            return None;
        };
        // `i++` on a narrower type wraps before it reaches a wider
        // limit, which no single transfer reproduces.
        if self.size_of_type(iv_ty) < 4 {
            return None;
        }
        // The step must be exactly one element position.
        let steps = match self.ast.expr(post) {
            Expr::PreInc { lvalue, by: 1, .. } | Expr::PostInc { lvalue, by: 1, .. } => {
                matches!(self.ast.expr(*lvalue),
                    Expr::Ident { sym, val, .. } if *sym == iv_sym && *val == iv_val)
            }
            _ => false,
        };
        if !steps {
            return None;
        }
        let (start, declares_iv) = self.init_start(init, iv_sym, iv_val);
        Some(Counted {
            iv: lhs,
            iv_sym,
            iv_val,
            iv_ty,
            start,
            declares_iv,
            limit: rhs,
            limit_const: self.const_operand(rhs),
            unsigned_cmp,
            cond,
            init,
        })
    }

    /// Value of a constant operand, with each cast's own conversion
    /// applied (C99 6.3.1.3) -- the value the loop's comparison sees.
    fn const_operand(&self, e: ExprId) -> Option<i64> {
        match self.ast.expr(e) {
            Expr::IntLit { val, .. } => Some(*val),
            Expr::Sizeof(s) => Some(s.size_bytes),
            // The parser leaves a subscript's and a pointer step's
            // element scaling as a product of two literals.
            Expr::Binary { op, lhs, rhs, ty } => {
                let (a, b) = (self.const_operand(*lhs)?, self.const_operand(*rhs)?);
                let v = match op {
                    BinOp::Add => a.checked_add(b),
                    BinOp::Sub => a.checked_sub(b),
                    BinOp::Mul => a.checked_mul(b),
                    _ => None,
                }?;
                self.narrow_to(*ty, v)
            }
            Expr::Cast { child, to_ty } => {
                let v = self.const_operand(*child)?;
                self.narrow_to(*to_ty, v)
            }
            _ => None,
        }
    }

    /// `v` as the type converts it (C99 6.3.1.3). `None` for a type no
    /// integer conversion applies to.
    fn narrow_to(&self, ty: i64, v: i64) -> Option<i64> {
        if is_floating_ty(ty) || is_struct_value_ty(ty) {
            return None;
        }
        let bytes = self.size_of_type(ty);
        i64::try_from(narrow_const_int(
            bytes,
            is_unsigned_ty(ty),
            is_bool_ty(ty),
            i128::from(v),
        ))
        .ok()
    }

    /// The constant the for-init leaves in the induction variable, and
    /// whether the init declares it.
    fn init_start(&self, init: Option<BlockItem>, sym: u32, val: i64) -> (Option<i64>, bool) {
        let Some(BlockItem::Stmt(s)) = init else {
            return (None, false);
        };
        match self.ast.stmt(s) {
            Stmt::Expr(e) => match self.ast.expr(*e) {
                Expr::Assign { lhs, rhs, .. } => match self.ast.expr(*lhs) {
                    Expr::Ident {
                        sym: s2, val: v2, ..
                    } if *s2 == sym && *v2 == val => (self.const_operand(*rhs), false),
                    _ => (None, false),
                },
                _ => (None, false),
            },
            Stmt::Decl(d) => match &self.ast.decls[*d as usize] {
                Decl::Local {
                    sym: s2,
                    slot_off,
                    init,
                    ..
                } if *s2 == sym && *slot_off == val => {
                    let start = match init {
                        LocalInit::Scalar(e) => self.const_operand(*e),
                        _ => None,
                    };
                    (start, true)
                }
                _ => (None, false),
            },
            _ => (None, false),
        }
    }

    /// Match the body against `dst[i] = src[i]` / `dst[i] = value`.
    fn match_body(&self, id: StmtId, loop_: &Counted) -> Option<Transfer> {
        let Stmt::For { body, .. } = *self.ast.stmt(id) else {
            return None;
        };
        let (lhs, rhs) = match self.ast.stmt(self.single_stmt(body)?) {
            Stmt::Expr(e) => match self.ast.expr(*e) {
                Expr::Assign { lhs, rhs, .. } => (*lhs, *rhs),
                _ => return None,
            },
            _ => return None,
        };
        let (dst, idx, elem_ty) = self.match_subscript(lhs, loop_)?;
        let width = self.transfer_width(elem_ty)?;
        let (dst_base, dst_object) = self.base_object(dst)?;
        let align = self.pointee_align(dst, elem_ty)?;
        if let Some((src, _, src_ty)) = self.match_subscript(rhs, loop_) {
            // Equal element types: the assignment converts nothing, so
            // the store writes back the bytes the load read.
            if src_ty != elem_ty || self.transfer_width(src_ty)? != width {
                return None;
            }
            let (src_base, src_object) = self.base_object(src)?;
            // Distinct declared array objects cannot overlap. One base
            // read twice cannot be disjoint from itself, so no test
            // decides it; anything else takes the runtime one.
            let overlap = match (dst_object, src_object) {
                (Some(a), Some(b)) if a != b => Overlap::Proved,
                _ if self.ident_sym(dst_base) == self.ident_sym(src_base) => return None,
                _ => Overlap::Runtime,
            };
            return Some(Transfer {
                op: match overlap {
                    Overlap::Proved => MemTransferOp::Copy,
                    Overlap::Runtime => MemTransferOp::Move,
                },
                dst: dst_base,
                dst_object,
                src: src_base,
                fill_byte: None,
                idx,
                width,
                align: align.min(self.pointee_align(src, src_ty)?),
                overlap,
            });
        }
        let fill_byte = self.fill_value(rhs, elem_ty, width, loop_)?;
        Some(Transfer {
            op: MemTransferOp::Fill,
            dst: dst_base,
            dst_object,
            src: rhs,
            fill_byte,
            idx,
            width,
            align,
            overlap: Overlap::Proved,
        })
    }

    /// The single statement a body reduces to, unwrapping the compound
    /// a braced body builds.
    fn single_stmt(&self, mut id: StmtId) -> Option<StmtId> {
        for _ in 0..4 {
            match self.ast.stmt(id) {
                Stmt::Compound(items) => match items.as_slice() {
                    [BlockItem::Stmt(inner)] => id = *inner,
                    _ => return None,
                },
                _ => return Some(id),
            }
        }
        None
    }

    /// Match `base[i]` where the subscript is the induction variable
    /// scaled by the element width. Yields the base expression, the
    /// scaled subscript, and the element type.
    fn match_subscript(&self, e: ExprId, loop_: &Counted) -> Option<(ExprId, ExprId, i64)> {
        let Expr::Index { array, idx, ty } = *self.ast.expr(e) else {
            return None;
        };
        let width = self.size_of_type(ty) as i64;
        if !self.scaled_iv(idx, width, loop_) {
            return None;
        }
        Some((array, idx, ty))
    }

    /// Whether `idx` is the induction variable scaled by `width`.
    fn scaled_iv(&self, idx: ExprId, width: i64, loop_: &Counted) -> bool {
        let is_iv = |e: ExprId| self.is_iv(e, loop_);
        match self.ast.expr(idx) {
            Expr::Binary {
                op: BinOp::Mul,
                lhs,
                rhs,
                ..
            } => {
                let scale = |e: ExprId| self.const_operand(e) == Some(width);
                (is_iv(*lhs) && scale(*rhs)) || (is_iv(*rhs) && scale(*lhs))
            }
            _ => width == 1 && is_iv(idx),
        }
    }

    /// Element width, for the scalar types whose store is a byte move.
    fn transfer_width(&self, ty: i64) -> Option<i64> {
        if ty & VOLATILE_MASK != 0 || is_struct_value_ty(ty) {
            return None;
        }
        match self.size_of_type(ty) as i64 {
            w @ (1 | 2 | 4 | 8) => Some(w),
            _ => None,
        }
    }

    /// Endpoint alignment the base guarantees, capped at the widest
    /// access the expansion uses: a declared local array starts at a
    /// frame slot, any other base only guarantees its pointee type's
    /// alignment (C99 6.3.2.3p7). `None` when the base is
    /// volatile-qualified at any level.
    fn pointee_align(&self, base: ExprId, elem_ty: i64) -> Option<u32> {
        let ty = expr_ty(self.ast.expr(base))?;
        if ty & VOLATILE_MASK != 0 {
            return None;
        }
        let slot = matches!(self.ast.expr(base),
            Expr::Ident { class, array_size, .. }
                if *array_size != 0 && *class == Token::Loc as i64);
        let align = if slot {
            SLOT_ALIGN
        } else {
            self.align_of_type(elem_ty) as u32
        };
        Some(align.clamp(1, MAX_MEM_TRANSFER_ALIGN))
    }

    /// Resolve a base pointer to the identifier it reads. The second
    /// element is the symbol of a declared array object, whose bounds
    /// confine every store through the base.
    fn base_object(&self, base: ExprId) -> Option<(ExprId, Option<u32>)> {
        match self.ast.expr(base) {
            Expr::Ident {
                sym, array_size, ..
            } => Some((base, (*array_size != 0).then_some(*sym))),
            Expr::Cast { child, .. } => {
                let (_, object) = self.base_object(*child)?;
                Some((base, object))
            }
            _ => None,
        }
    }

    /// Whether the stored value is one `memset` writes, and the
    /// constant byte where it is one. A one-byte integer element passes
    /// its runtime value through (`None`); any wider element takes a
    /// constant whose stored representation repeats one byte.
    fn fill_value(
        &self,
        value: ExprId,
        elem_ty: i64,
        width: i64,
        loop_: &Counted,
    ) -> Option<Option<i64>> {
        // A value that moves with the loop is not one fill value.
        if self.reads_iv(value, loop_) {
            return None;
        }
        let leaf = self.simple_value(value)?;
        let float_elem = is_floating_ty(elem_ty);
        let stored = match self.ast.expr(leaf) {
            // C99 6.2.6.1: the wider store repeats one byte only when
            // every byte of the stored representation is that byte. A
            // floating element stores the conversion's bytes, of which
            // only zero is known here.
            Expr::IntLit { val, .. } if !float_elem => (*val as u64) & mask(width),
            Expr::IntLit { val: 0, .. } | Expr::FloatLit { bits: 0, .. } => 0,
            _ if width == 1 && !float_elem => {
                let ty = expr_ty(self.ast.expr(leaf))?;
                // The conversion to the element type has to be the byte
                // `memset` writes, which rules out a floating operand.
                if is_floating_ty(ty) || is_struct_value_ty(ty) {
                    return None;
                }
                return Some(None);
            }
            _ => return None,
        };
        let byte = stored & 0xff;
        let pattern = (0..width).fold(0u64, |acc, i| acc | (byte << (i * 8)));
        (stored == pattern).then_some(Some(byte as i64))
    }

    /// An identifier read or a constant, through casts.
    fn simple_value(&self, e: ExprId) -> Option<ExprId> {
        match self.ast.expr(e) {
            Expr::IntLit { .. } | Expr::FloatLit { .. } | Expr::Ident { .. } => Some(e),
            Expr::Cast { child, .. } => self.simple_value(*child),
            _ => None,
        }
    }

    fn is_iv(&self, e: ExprId, loop_: &Counted) -> bool {
        matches!(self.ast.expr(e),
            Expr::Ident { sym, val, .. } if *sym == loop_.iv_sym && *val == loop_.iv_val)
    }

    fn reads_iv(&self, e: ExprId, loop_: &Counted) -> bool {
        match self.ast.expr(e) {
            Expr::Cast { child, .. } => self.reads_iv(*child, loop_),
            _ => self.is_iv(e, loop_),
        }
    }

    /// The loop makes no effect the transfer does not, and the transfer
    /// reads nothing the loop's stores can reach.
    fn check_effects(
        &self,
        loop_: &Counted,
        xfer: &Transfer,
        escaped: &BTreeSet<u32>,
    ) -> Option<()> {
        let mut reads = alloc::vec![loop_.iv, loop_.limit, xfer.dst];
        // A constant fill byte is not read from anywhere.
        if xfer.fill_byte.is_none() {
            reads.push(xfer.src);
        }
        for e in reads {
            if !self.unreachable_by_store(e, xfer.dst_object, escaped) {
                return None;
            }
        }
        Some(())
    }

    /// Whether the loop's stores can be proved not to write the object
    /// `e` reads.
    fn unreachable_by_store(
        &self,
        e: ExprId,
        dst_object: Option<u32>,
        escaped: &BTreeSet<u32>,
    ) -> bool {
        if expr_ty(self.ast.expr(e)).is_none_or(|ty| ty & VOLATILE_MASK != 0) {
            return false;
        }
        match self.ast.expr(e) {
            Expr::IntLit { .. } | Expr::FloatLit { .. } => true,
            Expr::Cast { child, .. } => self.unreachable_by_store(*child, dst_object, escaped),
            Expr::Ident {
                sym,
                class,
                array_size,
                ..
            } => {
                // An array's value is its address, which no store
                // produces; a store confined to one object leaves every
                // other declared object alone.
                if *array_size != 0 || dst_object.is_some_and(|o| o != *sym) {
                    return true;
                }
                *class == Token::Loc as i64 && !escaped.contains(sym)
            }
            _ => false,
        }
    }

    fn plan_walk(&mut self, id: StmtId, escaped: &BTreeSet<u32>) -> Option<Rewrite> {
        let walk = self.match_walk(id)?;
        for e in [walk.counter, walk.dst, walk.src] {
            if !self.unreachable_by_store(e, None, escaped) {
                return None;
            }
        }
        // The transfer's count is the counter, which no constant
        // expansion covers; only the library form applies.
        let callee = self.mem_transfer_lib_symbol(MemTransferOp::Move)?;
        let pos = self.ast.stmt_src[id as usize];
        let elems = self.walk_elements(&walk, pos);
        let size_t = self.size_t_ty();
        let bytes = if walk.width == 1 {
            elems
        } else {
            let w = self.ast.push_expr(
                Expr::IntLit {
                    val: walk.width,
                    ty: size_t,
                },
                pos,
            );
            self.ast.push_expr(
                Expr::Binary {
                    op: BinOp::Mul,
                    lhs: elems,
                    rhs: w,
                    ty: size_t,
                },
                pos,
            )
        };
        let guard = self.disjoint_guard(walk.dst, walk.src, bytes, pos);
        let ptr_ty = Ty::Char as i64 + UNSIGNED_BIT + Ty::Ptr as i64;
        self.symbols[callee].was_referenced = true;
        let callee_ty = self.symbols[callee].type_;
        let callee = self.ast_synthesize_callee(callee as u32, callee_ty);
        let call = self.ast.push_expr(
            Expr::Call {
                callee,
                args: alloc::vec![walk.dst, walk.src, bytes],
                ty: ptr_ty,
            },
            pos,
        );
        // The counter goes last: the pointer steps read it.
        let step_elems = self.ast.push_expr(
            Expr::Cast {
                child: elems,
                to_ty: walk.counter_ty,
            },
            pos,
        );
        let body = alloc::vec![
            call,
            self.step_by(BinOp::Add, walk.dst, bytes, pos),
            self.step_by(BinOp::Add, walk.src, bytes, pos),
            self.step_by(BinOp::Sub, walk.counter, step_elems, pos),
        ];
        let fallback = self.ast.stmt(id).clone();
        let fallback = self.ast.push_stmt(fallback, pos);
        Some(Rewrite {
            init: None,
            cond: Some(walk.cond),
            guard: Some(guard),
            body,
            fallback: Some(fallback),
        })
    }

    /// `lvalue op= by`, in the lvalue's own type.
    fn step_by(&mut self, op: BinOp, lvalue: ExprId, by: ExprId, pos: SrcPos) -> ExprId {
        let ty = expr_ty(self.ast.expr(lvalue)).unwrap_or(Ty::Long as i64);
        self.ast.push_expr(
            Expr::CompoundAssign {
                op,
                lhs: lvalue,
                rhs: by,
                ty,
            },
            pos,
        )
    }

    /// Elements the walk transfers, as a `size_t`: the counter rounded
    /// down to a multiple of the step. The loop's own test proves the
    /// counter at least one step, so the conversion is exact.
    fn walk_elements(&mut self, walk: &Walk, pos: SrcPos) -> ExprId {
        let size_t = self.size_t_ty();
        let c = self.ast.push_expr(
            Expr::Cast {
                child: walk.counter,
                to_ty: size_t,
            },
            pos,
        );
        if walk.step == 1 {
            return c;
        }
        let lit = |s: &mut Self, val: i64| s.ast.push_expr(Expr::IntLit { val, ty: size_t }, pos);
        let bin = |s: &mut Self, op, lhs, rhs| {
            s.ast.push_expr(
                Expr::Binary {
                    op,
                    lhs,
                    rhs,
                    ty: size_t,
                },
                pos,
            )
        };
        if walk.step & (walk.step - 1) == 0 {
            let mask = lit(self, walk.step - 1);
            let rem = bin(self, BinOp::And, c, mask);
            return bin(self, BinOp::Sub, c, rem);
        }
        let k = lit(self, walk.step);
        let whole = bin(self, BinOp::Divu, c, k);
        let k = lit(self, walk.step);
        bin(self, BinOp::Mul, whole, k)
    }

    /// Match `while (c > k - 1) { dst[0] = src[0]; ...; dst += k;
    /// src += k; c -= k; }` and the `>=` spelling of the same test.
    fn match_walk(&self, id: StmtId) -> Option<Walk> {
        let (cond, body) = match *self.ast.stmt(id) {
            Stmt::While { cond, body } => (cond, body),
            Stmt::For {
                init: None,
                cond: Some(cond),
                post: None,
                body,
            } => (cond, body),
            _ => return None,
        };
        let Expr::Binary { op, lhs, rhs, .. } = *self.ast.expr(cond) else {
            return None;
        };
        let Expr::Ident {
            sym: counter_sym,
            val: counter_val,
            ty: counter_ty,
            ..
        } = *self.ast.expr(lhs)
        else {
            return None;
        };
        if counter_ty & VOLATILE_MASK != 0
            || is_floating_ty(counter_ty)
            || is_struct_value_ty(counter_ty)
            || is_pointer_ty(counter_ty)
        {
            return None;
        }
        // Both tests hold exactly while a whole step is left.
        let bound = self.const_operand(rhs)?;
        let step = match op {
            BinOp::Gt | BinOp::Ugt => bound.checked_add(1)?,
            BinOp::Ge | BinOp::Uge => bound,
            _ => return None,
        };
        if !(1..=MAX_WALK_STEP).contains(&step) {
            return None;
        }
        let items = match self.ast.stmt(body) {
            Stmt::Compound(items) => items.as_slice(),
            _ => return None,
        };
        let (copies, steps) = items.split_at_checked(step as usize)?;
        if steps.len() != 3 {
            return None;
        }
        let mut bases: Option<(ExprId, ExprId, i64, i64)> = None;
        let mut covered = 0u32;
        for item in copies {
            let (d, s, off, ty) = self.match_walk_elem(*item)?;
            let width = self.transfer_width(ty)?;
            let (dst, src, elem_ty, _) = *bases.get_or_insert((d, s, ty, width));
            if ty != elem_ty
                || self.ident_key(d)? != self.ident_key(dst)?
                || self.ident_key(s)? != self.ident_key(src)?
            {
                return None;
            }
            // Each element position exactly once: the transfer covers
            // the range whatever order the body stores it in.
            if off < 0 || off % width != 0 || off / width >= step {
                return None;
            }
            let bit = 1u32 << (off / width);
            if covered & bit != 0 {
                return None;
            }
            covered |= bit;
        }
        let (dst, src, elem_ty, width) = bases?;
        let (dst_key, src_key) = (self.ident_key(dst)?, self.ident_key(src)?);
        if dst_key == src_key {
            return None;
        }
        // A base whose own type is volatile-qualified is read once per
        // iteration; `pointee_align` reports that as no alignment.
        self.pointee_align(dst, elem_ty)?;
        self.pointee_align(src, elem_ty)?;
        let want = [
            (dst_key, step * width),
            (src_key, step * width),
            ((counter_sym, counter_val), -step),
        ];
        let mut matched = 0u32;
        for item in steps {
            let (target, by) = self.match_step(*item)?;
            let key = self.ident_key(target)?;
            let i = want.iter().position(|w| *w == (key, by))?;
            if matched & (1 << i) != 0 {
                return None;
            }
            matched |= 1 << i;
        }
        Some(Walk {
            cond,
            counter: lhs,
            counter_ty,
            step,
            dst,
            src,
            width,
        })
    }

    /// The identifier an expression reads, as the name / storage pair
    /// that tells two declarations of one name apart.
    fn ident_key(&self, e: ExprId) -> Option<(u32, i64)> {
        match self.ast.expr(e) {
            Expr::Ident { sym, val, .. } => Some((*sym, *val)),
            Expr::Cast { child, .. } => self.ident_key(*child),
            _ => None,
        }
    }

    /// One `dst[j] = src[j]` of a blocked body: the two base
    /// expressions, the byte offset they share, and the element type.
    fn match_walk_elem(&self, item: BlockItem) -> Option<(ExprId, ExprId, i64, i64)> {
        let BlockItem::Stmt(s) = item else {
            return None;
        };
        let Stmt::Expr(e) = *self.ast.stmt(s) else {
            return None;
        };
        let Expr::Assign { lhs, rhs, .. } = *self.ast.expr(e) else {
            return None;
        };
        let (dst, doff, dty) = self.match_offset(lhs)?;
        let (src, soff, sty) = self.match_offset(rhs)?;
        (doff == soff && dty == sty).then_some((dst, src, doff, dty))
    }

    /// `base[<constant>]` or `*base`: the base, its constant byte
    /// offset, and the element type.
    fn match_offset(&self, e: ExprId) -> Option<(ExprId, i64, i64)> {
        match *self.ast.expr(e) {
            Expr::Index { array, idx, ty } => Some((array, self.const_operand(idx)?, ty)),
            Expr::Unary {
                op: UnOp::Deref,
                child,
                ty,
            } => Some((child, 0, ty)),
            _ => None,
        }
    }

    /// `x += <constant>` and its `-=` / `++` / `--` spellings: the
    /// identifier stepped, and the signed amount.
    fn match_step(&self, item: BlockItem) -> Option<(ExprId, i64)> {
        let BlockItem::Stmt(s) = item else {
            return None;
        };
        let Stmt::Expr(e) = *self.ast.stmt(s) else {
            return None;
        };
        match *self.ast.expr(e) {
            Expr::CompoundAssign { op, lhs, rhs, .. } => {
                let by = self.const_operand(rhs)?;
                match op {
                    BinOp::Add => Some((lhs, by)),
                    BinOp::Sub => Some((lhs, by.checked_neg()?)),
                    _ => None,
                }
            }
            Expr::PreInc { lvalue, by, .. } | Expr::PostInc { lvalue, by, .. } => {
                Some((lvalue, by))
            }
            _ => None,
        }
    }

    /// The transfer's byte count where the loop's endpoints are both
    /// constant. The outer `None` declines the loop: an empty count, or
    /// one that does not fit.
    fn const_bytes(&self, loop_: &Counted, xfer: &Transfer) -> Option<Option<i64>> {
        match (loop_.start, loop_.limit_const) {
            (Some(s), Some(l)) if l > s => Some(Some(l.checked_sub(s)?.checked_mul(xfer.width)?)),
            (Some(_), Some(_)) => None,
            _ => Some(None),
        }
    }

    /// The transfer's byte count as a `size_t` expression.
    fn count_expr(&mut self, loop_: &Counted, xfer: &Transfer, pos: SrcPos) -> ExprId {
        match self.const_bytes(loop_, xfer).flatten() {
            Some(n) => {
                let ty = self.size_t_ty();
                self.ast.push_expr(Expr::IntLit { val: n, ty }, pos)
            }
            None => self.trip_bytes(loop_, xfer.width, pos),
        }
    }

    /// `(size_t)dst - (size_t)src >= bytes`. The difference is taken in
    /// the unsigned address type, so a destination below its source
    /// wraps above any count and passes: an ascending copy reads every
    /// byte there before a store can reach it.
    fn disjoint_guard(&mut self, dst: ExprId, src: ExprId, bytes: ExprId, pos: SrcPos) -> ExprId {
        let size_t = self.size_t_ty();
        let d = self.ast.push_expr(
            Expr::Cast {
                child: dst,
                to_ty: size_t,
            },
            pos,
        );
        let s = self.ast.push_expr(
            Expr::Cast {
                child: src,
                to_ty: size_t,
            },
            pos,
        );
        let diff = self.ast.push_expr(
            Expr::Binary {
                op: BinOp::Sub,
                lhs: d,
                rhs: s,
                ty: size_t,
            },
            pos,
        );
        self.ast.push_expr(
            Expr::Binary {
                op: BinOp::Uge,
                lhs: diff,
                rhs: bytes,
                ty: Ty::Int as i64,
            },
            pos,
        )
    }

    /// Build the transfer expression, or `None` when neither the inline
    /// expansion nor the library call is available for it.
    fn build_transfer(&mut self, loop_: &Counted, xfer: &Transfer, pos: SrcPos) -> Option<ExprId> {
        let ptr_ty = Ty::Char as i64 + UNSIGNED_BIT + Ty::Ptr as i64;
        let bytes = self.const_bytes(loop_, xfer)?;
        // The loop's first element sits at `start * width` from the
        // base; a constant start folds the offset, a runtime one reuses
        // the subscript the body already scales.
        let offset = |c: &mut Self, base: ExprId| match loop_.start {
            Some(0) => base,
            Some(s) => {
                let off = c.ast.push_expr(
                    Expr::IntLit {
                        val: s * xfer.width,
                        ty: Ty::Long as i64,
                    },
                    pos,
                );
                c.ast.push_expr(
                    Expr::Binary {
                        op: BinOp::Add,
                        lhs: base,
                        rhs: off,
                        ty: ptr_ty,
                    },
                    pos,
                )
            }
            None => c.ast.push_expr(
                Expr::Binary {
                    op: BinOp::Add,
                    lhs: base,
                    rhs: xfer.idx,
                    ty: ptr_ty,
                },
                pos,
            ),
        };
        // The transfer starts at `start * width` from the base, which
        // only keeps as much of the endpoint alignment as it divides.
        let align = match loop_.start {
            Some(s) if s * xfer.width != 0 => xfer
                .align
                .min(1 << (s * xfer.width).trailing_zeros().min(3)),
            _ => xfer.align,
        };
        if let Some(n) = bytes
            && mem_transfer_fits(xfer.op, n, align)
        {
            let dst = offset(self, xfer.dst);
            let src = match xfer.op {
                MemTransferOp::Fill => self.fill_operand(xfer, pos),
                _ => offset(self, xfer.src),
            };
            return Some(self.ast.push_expr(
                Expr::MemTransfer {
                    op: xfer.op,
                    dst,
                    src,
                    size: n,
                    align,
                    ty: ptr_ty,
                },
                pos,
            ));
        }
        let callee = self.mem_transfer_lib_symbol(xfer.op)?;
        let dst = offset(self, xfer.dst);
        let src = match xfer.op {
            MemTransferOp::Fill => self.fill_operand(xfer, pos),
            _ => offset(self, xfer.src),
        };
        let count = match bytes {
            Some(n) => self.ast.push_expr(
                Expr::IntLit {
                    val: n,
                    ty: self.size_t_ty(),
                },
                pos,
            ),
            None => self.trip_bytes(loop_, xfer.width, pos),
        };
        self.symbols[callee].was_referenced = true;
        let callee_ty = self.symbols[callee].type_;
        let callee = self.ast_synthesize_callee(callee as u32, callee_ty);
        Some(self.ast.push_expr(
            Expr::Call {
                callee,
                args: alloc::vec![dst, src, count],
                ty: ptr_ty,
            },
            pos,
        ))
    }

    /// The fill's value operand as C99 7.21.6.1 takes it: an `int`
    /// whose low byte is stored.
    fn fill_operand(&mut self, xfer: &Transfer, pos: SrcPos) -> ExprId {
        let int_ty = Ty::Int as i64;
        match xfer.fill_byte {
            Some(val) => self.ast.push_expr(Expr::IntLit { val, ty: int_ty }, pos),
            None => self.ast.push_expr(
                Expr::Cast {
                    child: xfer.src,
                    to_ty: int_ty,
                },
                pos,
            ),
        }
    }

    /// `(limit - i) * width` as a `size_t`, in the width and signedness
    /// the loop's comparison converted its operands to, so the
    /// difference is the trip count whenever the guard holds.
    fn trip_bytes(&mut self, loop_: &Counted, width: i64, pos: SrcPos) -> ExprId {
        let wide = Ty::LongLong as i64 | if loop_.unsigned_cmp { UNSIGNED_BIT } else { 0 };
        let limit = self.ast.push_expr(
            Expr::Cast {
                child: loop_.limit,
                to_ty: wide,
            },
            pos,
        );
        let iv = self.ast.push_expr(
            Expr::Cast {
                child: loop_.iv,
                to_ty: wide,
            },
            pos,
        );
        let mut trips = self.ast.push_expr(
            Expr::Binary {
                op: BinOp::Sub,
                lhs: limit,
                rhs: iv,
                ty: wide,
            },
            pos,
        );
        if width > 1 {
            let w = self.ast.push_expr(
                Expr::IntLit {
                    val: width,
                    ty: wide,
                },
                pos,
            );
            trips = self.ast.push_expr(
                Expr::Binary {
                    op: BinOp::Mul,
                    lhs: trips,
                    rhs: w,
                    ty: wide,
                },
                pos,
            );
        }
        let size_t = self.size_t_ty();
        self.ast.push_expr(
            Expr::Cast {
                child: trips,
                to_ty: size_t,
            },
            pos,
        )
    }

    /// Put the planned statements in the loop's place.
    fn commit(&mut self, id: StmtId, r: Rewrite, pos: SrcPos) {
        let items: Vec<BlockItem> = r
            .body
            .into_iter()
            .map(|e| BlockItem::Stmt(self.ast.push_stmt(Stmt::Expr(e), pos)))
            .collect();
        let mut inner = self.ast.push_stmt(Stmt::Compound(items), pos);
        if let Some(guard) = r.guard {
            inner = self.ast.push_stmt(
                Stmt::If {
                    cond: guard,
                    then_s: inner,
                    else_s: r.fallback,
                },
                pos,
            );
        }
        if let Some(cond) = r.cond {
            inner = self.ast.push_stmt(
                Stmt::If {
                    cond,
                    then_s: inner,
                    else_s: None,
                },
                pos,
            );
        }
        let mut outer: Vec<BlockItem> = Vec::new();
        if let Some(init) = r.init {
            outer.push(init);
        }
        outer.push(BlockItem::Stmt(inner));
        self.ast.stmts[id as usize] = Stmt::Compound(outer);
    }
}
