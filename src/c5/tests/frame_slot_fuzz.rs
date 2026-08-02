//! Differential harness over frame storage filled from outside the
//! instruction tape.
//!
//! A by-value aggregate parameter homed to the frame
//! (`FunctionSsa::param_local_slots`), the hidden return pointer
//! (`indirect_result_slot`), and the caller-side temporary an aggregate
//! return materialises into (a call's `ret_slot_local`) all hold bytes
//! that no store in the owning function's instruction sequence names. A
//! pass that concludes "nothing writes this slot" from the tape alone is
//! wrong about all three, and such wrong code survives every pass-level
//! unit test.
//!
//! Programs are generated from a seeded shape and evaluated four ways: an
//! exact model of the program, badc at -O0, badc at -O, and a reference C
//! compiler. Any disagreement is reported with the seed, the reduced
//! shape, and the reduced source.
//!
//! Every generated program has exactly one defined answer. Integer
//! arithmetic is unsigned throughout (C99 6.2.5p9), there is no division
//! or variable shift, every object is `= {0}` at its declaration or the
//! whole result of a call that fills every field, no expression contains
//! more than one call or any assignment, every loop has a constant trip
//! count over its own counter, the call graph is a DAG, and a float
//! field only ever holds a small non-negative integer. See [`Scalar`],
//! [`Expr`], and [`Body`].
//!
//! A bare `cargo test` runs a fixed cheap sweep. `BADC_FUZZ_FRAME=1`
//! selects the deep sweep; `BADC_FUZZ_FRAME_ITERS` and
//! `BADC_FUZZ_FRAME_SEED` override the count and the seed base, and
//! `BADC_FUZZ_FRAME_TRACE=1` prints each index and seed before its run.

#![cfg(any(
    all(
        target_os = "linux",
        any(target_arch = "aarch64", target_arch = "x86_64")
    ),
    all(target_os = "macos", target_arch = "aarch64"),
))]

use std::fmt::Write as _;
use std::sync::OnceLock;

use crate::c5::codegen::abi_classify::{AggClass, FlatField, ScalarKind, classify_aggregate};
use crate::c5::codegen::ssa::reg_alloc::with_pool_size_override;
use crate::{Compiler, NativeOptions, jit_run_with_options};

// ---------------------------------------------------------------- prng

/// SplitMix64. Reproducible across hosts and rustc versions, which the
/// seed-based failure report depends on.
struct Rng(u64);

impl Rng {
    fn new(seed: u64) -> Self {
        Rng(seed)
    }
    fn next(&mut self) -> u64 {
        self.0 = self.0.wrapping_add(0x9e37_79b9_7f4a_7c15);
        let mut z = self.0;
        z = (z ^ (z >> 30)).wrapping_mul(0xbf58_476d_1ce4_e5b9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94d0_49bb_1331_11eb);
        z ^ (z >> 31)
    }
    fn below(&mut self, n: usize) -> usize {
        (self.next() % n as u64) as usize
    }
    /// Inclusive on both ends.
    fn range(&mut self, lo: usize, hi: usize) -> usize {
        lo + self.below(hi - lo + 1)
    }
    fn pick<'a, T>(&mut self, xs: &'a [T]) -> &'a T {
        &xs[self.below(xs.len())]
    }
    fn odds(&mut self, percent: usize) -> bool {
        self.below(100) < percent
    }
}

// --------------------------------------------------------------- types

/// Leaf scalar type of a generated aggregate. Integer leaves are all
/// unsigned, so C99 6.2.5p9 makes their arithmetic and every narrowing
/// conversion wrap. Float leaves hold a small non-negative integer
/// (`domain`), which every conversion in and out reproduces exactly and
/// which no `FLT_EVAL_METHOD` can perturb.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Scalar {
    U8,
    U16,
    U32,
    U64,
    F32,
    F64,
}

impl Scalar {
    fn c_type(self) -> &'static str {
        match self {
            Scalar::U8 => "unsigned char",
            Scalar::U16 => "unsigned short",
            Scalar::U32 => "unsigned int",
            Scalar::U64 => "unsigned long long",
            Scalar::F32 => "float",
            Scalar::F64 => "double",
        }
    }
    fn size(self) -> u32 {
        match self {
            Scalar::U8 => 1,
            Scalar::U16 => 2,
            Scalar::U32 | Scalar::F32 => 4,
            Scalar::U64 | Scalar::F64 => 8,
        }
    }
    /// Mask applied to every value stored into a leaf of this type.
    fn domain(self) -> u64 {
        match self {
            Scalar::U8 => 0xff,
            Scalar::U16 => 0xffff,
            Scalar::U32 => 0xffff_ffff,
            Scalar::U64 => u64::MAX,
            Scalar::F32 => 0x3ff,
            Scalar::F64 => 0xffff,
        }
    }
    fn is_fp(self) -> bool {
        matches!(self, Scalar::F32 | Scalar::F64)
    }
    /// Every integer below this is exactly representable in the type.
    fn exact_limit(self) -> u64 {
        match self {
            Scalar::F32 => 1 << 24,
            Scalar::F64 => 1 << 53,
            _ => u64::MAX,
        }
    }
    fn abi_kind(self) -> ScalarKind {
        match self {
            Scalar::F32 => ScalarKind::F32,
            Scalar::F64 => ScalarKind::F64,
            _ => ScalarKind::Int,
        }
    }
}

#[derive(Clone, Debug)]
enum Member {
    Sc(Scalar),
    Arr(Scalar, usize),
    Agg(usize),
}

#[derive(Clone, Debug)]
struct LeafInfo {
    /// Access suffix from the object, e.g. `.f1.f0[2]`.
    path: String,
    sc: Scalar,
    offset: u32,
}

#[derive(Clone, Debug)]
struct AggTy {
    members: Vec<Member>,
    leaves: Vec<LeafInfo>,
    size: u32,
    align: u32,
}

impl AggTy {
    fn build(members: Vec<Member>, types: &[AggTy]) -> AggTy {
        let mut leaves = Vec::new();
        let (mut size, mut align) = (0u32, 1u32);
        for (i, m) in members.iter().enumerate() {
            let (msize, malign) = match m {
                Member::Sc(sc) => (sc.size(), sc.size()),
                Member::Arr(sc, n) => (sc.size() * *n as u32, sc.size()),
                Member::Agg(t) => (types[*t].size, types[*t].align),
            };
            size = size.next_multiple_of(malign);
            align = align.max(malign);
            let base = size;
            match m {
                Member::Sc(sc) => leaves.push(LeafInfo {
                    path: format!(".f{i}"),
                    sc: *sc,
                    offset: base,
                }),
                Member::Arr(sc, n) => {
                    for k in 0..*n {
                        leaves.push(LeafInfo {
                            path: format!(".f{i}[{k}]"),
                            sc: *sc,
                            offset: base + sc.size() * k as u32,
                        });
                    }
                }
                Member::Agg(t) => {
                    for sub in &types[*t].leaves {
                        leaves.push(LeafInfo {
                            path: format!(".f{i}{}", sub.path),
                            sc: sub.sc,
                            offset: base + sub.offset,
                        });
                    }
                }
            }
            size += msize;
        }
        size = size.next_multiple_of(align).max(1);
        AggTy {
            members,
            leaves,
            size,
            align,
        }
    }

    fn flat_fields(&self) -> Vec<FlatField> {
        self.leaves
            .iter()
            .map(|l| FlatField {
                offset: l.offset,
                size: l.sc.size(),
                kind: l.sc.abi_kind(),
            })
            .collect()
    }
}

// ---------------------------------------------------------- program ir

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum BinKind {
    Add,
    Sub,
    Mul,
    Xor,
    And,
    Or,
}

impl BinKind {
    fn c_op(self) -> &'static str {
        match self {
            BinKind::Add => "+",
            BinKind::Sub => "-",
            BinKind::Mul => "*",
            BinKind::Xor => "^",
            BinKind::And => "&",
            BinKind::Or => "|",
        }
    }
    fn apply(self, a: u64, b: u64) -> u64 {
        match self {
            BinKind::Add => a.wrapping_add(b),
            BinKind::Sub => a.wrapping_sub(b),
            BinKind::Mul => a.wrapping_mul(b),
            BinKind::Xor => a ^ b,
            BinKind::And => a & b,
            BinKind::Or => a | b,
        }
    }
}

/// A pure `unsigned long long` expression. No call, no assignment, so
/// C99 6.5p2's unsequenced-modification rule and 6.5p3's unspecified
/// operand order cannot make one ambiguous.
#[derive(Clone, Debug)]
enum Expr {
    Const(u64),
    Var(u16),
    Leaf(u16, u16),
    Bin(BinKind, Box<Expr>, Box<Expr>),
    Shift(bool, Box<Expr>, u8),
}

#[derive(Clone, Debug)]
enum Arg {
    Scalar(Expr),
    ByVal(u16),
    Ptr(u16),
}

#[derive(Clone, Debug)]
enum Stmt {
    SetLeaf {
        obj: u16,
        leaf: u16,
        expr: Expr,
    },
    /// `dst.leaf = (T)((T)(masked a) + (T)(masked b))`: an FP add whose
    /// operands are both re-masked into `domain`, so the sum is at most
    /// `2 * domain` and stays exact.
    FpAdd {
        dst: u16,
        dleaf: u16,
        a: (u16, u16),
        b: (u16, u16),
    },
    CopyAgg {
        dst: u16,
        src: u16,
    },
    /// `struct Sn t = h(..);` -- the caller-side temporary named only by
    /// the call's `ret_slot_local`.
    CallAggDecl {
        obj: u16,
        callee: u16,
        args: Vec<Arg>,
    },
    CallAggAssign {
        obj: u16,
        callee: u16,
        args: Vec<Arg>,
    },
    /// `s = (unsigned long long)h(..).f;` -- a member read of a call
    /// rvalue, which has the same temporary but no named object.
    CallAggMember {
        dst: u16,
        callee: u16,
        args: Vec<Arg>,
        leaf: u16,
    },
    CallScalar {
        dst: u16,
        callee: u16,
        args: Vec<Arg>,
    },
    CallVoid {
        callee: u16,
        args: Vec<Arg>,
    },
    Mix {
        expr: Expr,
    },
    Loop {
        count: u8,
        body: Vec<Stmt>,
    },
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Decl {
    Param,
    ZeroAgg,
    ScalarVar,
    /// Declared by the `CallAggDecl` that fills it.
    CallTemp,
}

#[derive(Clone, Debug)]
struct Obj {
    name: String,
    /// Aggregate type, for an aggregate or pointer-to-aggregate object.
    ty: Option<usize>,
    deref: bool,
    decl: Decl,
}

impl Obj {
    fn access(&self, path: &str) -> String {
        if self.deref {
            format!("{}->{}", self.name, &path[1..])
        } else {
            format!("{}{}", self.name, path)
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Ret {
    Void,
    Scalar,
    Agg(usize),
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum PKind {
    Scalar,
    ByVal(usize),
    Ptr(usize),
}

/// One function body. Every aggregate object is either `= {0}` at its
/// declaration or the whole result of a call that fills every leaf of
/// its return object, so no read can reach an indeterminate value.
#[derive(Clone, Debug)]
struct Body {
    objs: Vec<Obj>,
    stmts: Vec<Stmt>,
    acc: u16,
    acc_seed: u64,
    /// Aggregate a `Ret::Agg` body returns.
    ret_obj: Option<u16>,
}

#[derive(Clone, Debug)]
struct Helper {
    ret: Ret,
    params: Vec<PKind>,
    body: Body,
}

#[derive(Clone, Debug)]
struct Prog {
    types: Vec<AggTy>,
    helpers: Vec<Helper>,
    main: Body,
}

// --------------------------------------------------------------- shape

/// Generation knobs. The failure reducer walks this struct, so every
/// field must be independently lowerable towards a smaller program.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
struct Shape {
    seed: u64,
    n_types: usize,
    max_fields: usize,
    n_helpers: usize,
    stmts: usize,
    nest: bool,
    arrays: bool,
    floats: bool,
    ptr_args: bool,
    by_value_args: bool,
    loops: bool,
    /// Filler statements appended to roughly half the helpers. A callee
    /// past the inliner's body cap keeps its call sites, and only a
    /// surviving call carries a `ret_slot_local`; a program built purely
    /// from inlinable helpers never produces one.
    bulk: usize,
    /// Register-pressure caps applied to the badc legs. `0` means the
    /// full register file.
    max_gpr: usize,
    max_fpr: usize,
}

impl Shape {
    fn from_seed(seed: u64) -> Shape {
        let mut r = Rng::new(seed);
        Shape {
            seed,
            n_types: r.range(1, 3),
            // Straddles `usable_gpr_count` on both supported arches:
            // the split budget is the whole GPR file, so a 1-field and a
            // 12-leaf aggregate sit on opposite sides of it.
            max_fields: r.range(1, 9),
            n_helpers: r.range(1, 5),
            stmts: r.range(2, 10),
            nest: r.odds(45),
            arrays: r.odds(45),
            floats: r.odds(60),
            ptr_args: r.odds(55),
            by_value_args: r.odds(80),
            loops: r.odds(40),
            bulk: if r.odds(75) { r.range(12, 24) } else { 0 },
            max_gpr: 0,
            max_fpr: 0,
        }
    }

    fn with_pressure(mut self, gpr: usize, fpr: usize) -> Shape {
        self.max_gpr = gpr;
        self.max_fpr = fpr;
        self
    }
}

// ----------------------------------------------------------- generator

const MAX_LEAVES: usize = 14;

fn pick_scalar(r: &mut Rng, floats: bool) -> Scalar {
    const INTS: [Scalar; 4] = [Scalar::U8, Scalar::U16, Scalar::U32, Scalar::U64];
    const ALL: [Scalar; 6] = [
        Scalar::U8,
        Scalar::U16,
        Scalar::U32,
        Scalar::U64,
        Scalar::F32,
        Scalar::F64,
    ];
    if floats {
        *r.pick(&ALL)
    } else {
        *r.pick(&INTS)
    }
}

fn gen_types(r: &mut Rng, shape: &Shape) -> Vec<AggTy> {
    let mut types: Vec<AggTy> = Vec::new();
    for t in 0..shape.n_types {
        let want = r.range(1, shape.max_fields);
        let mut members = Vec::new();
        let mut leaves = 0usize;
        for _ in 0..want {
            if leaves >= MAX_LEAVES {
                break;
            }
            let roll = r.below(100);
            let m = if shape.nest && t > 0 && roll < 20 {
                let s = r.below(t);
                if leaves + types[s].leaves.len() > MAX_LEAVES {
                    Member::Sc(pick_scalar(r, shape.floats))
                } else {
                    Member::Agg(s)
                }
            } else if shape.arrays && roll < 40 {
                let n = r.range(1, 4).min(MAX_LEAVES - leaves);
                Member::Arr(pick_scalar(r, shape.floats), n)
            } else {
                Member::Sc(pick_scalar(r, shape.floats))
            };
            leaves += match &m {
                Member::Sc(_) => 1,
                Member::Arr(_, n) => *n,
                Member::Agg(s) => types[*s].leaves.len(),
            };
            members.push(m);
        }
        if members.is_empty() {
            members.push(Member::Sc(pick_scalar(r, shape.floats)));
        }
        types.push(AggTy::build(members, &types));
    }
    types
}

/// Builds the object table every body starts with: parameters, then one
/// zero-initialised aggregate per type, then the scalar variables. The
/// per-type locals guarantee every call site can find an argument of the
/// type it needs without a search that could fail.
fn base_objs(params: &[PKind], types: &[AggTy], scalars: usize) -> (Vec<Obj>, u16) {
    let mut objs = Vec::new();
    for (i, p) in params.iter().enumerate() {
        let (ty, deref) = match p {
            PKind::Scalar => (None, false),
            PKind::ByVal(t) => (Some(*t), false),
            PKind::Ptr(t) => (Some(*t), true),
        };
        objs.push(Obj {
            name: format!("p{i}"),
            ty,
            deref,
            decl: Decl::Param,
        });
    }
    for (t, _) in types.iter().enumerate() {
        objs.push(Obj {
            name: format!("o{t}"),
            ty: Some(t),
            deref: false,
            decl: Decl::ZeroAgg,
        });
    }
    let acc = objs.len() as u16;
    objs.push(Obj {
        name: "acc".to_string(),
        ty: None,
        deref: false,
        decl: Decl::ScalarVar,
    });
    for i in 0..scalars {
        objs.push(Obj {
            name: format!("s{i}"),
            ty: None,
            deref: false,
            decl: Decl::ScalarVar,
        });
    }
    (objs, acc)
}

struct GenCtx<'a> {
    types: &'a [AggTy],
    /// Helpers already generated; a body may call only these, so the
    /// call graph is acyclic and evaluation terminates.
    helpers: &'a [Helper],
}

fn scalar_objs(objs: &[Obj]) -> Vec<u16> {
    objs.iter()
        .enumerate()
        .filter(|(_, o)| o.ty.is_none())
        .map(|(i, _)| i as u16)
        .collect()
}

/// Aggregate objects of type `t` that are visible at this point.
fn objs_of_type(objs: &[Obj], visible: &[u16], t: usize) -> Vec<u16> {
    visible
        .iter()
        .copied()
        .filter(|&i| objs[i as usize].ty == Some(t))
        .collect()
}

/// Build a pure expression of bounded depth. Every leaf read is cast to
/// `unsigned long long`, every operator is wrapping or bitwise, and
/// shift counts are literals below 64, so the value is always defined.
fn gen_expr(r: &mut Rng, ctx: &GenCtx, objs: &[Obj], visible: &[u16], depth: u32) -> Expr {
    let scalars = scalar_objs(objs);
    if depth == 0 || r.odds(35) {
        let leaves: Vec<(u16, u16)> = visible
            .iter()
            .filter_map(|&i| objs[i as usize].ty.map(|t| (i, t)))
            .flat_map(|(i, t)| (0..ctx.types[t].leaves.len()).map(move |l| (i, l as u16)))
            .collect();
        return if !leaves.is_empty() && r.odds(60) {
            let (o, l) = *r.pick(&leaves);
            Expr::Leaf(o, l)
        } else if !scalars.is_empty() && r.odds(50) {
            Expr::Var(*r.pick(&scalars))
        } else {
            Expr::Const(r.next() >> r.below(48) as u32)
        };
    }
    if r.odds(25) {
        let e = gen_expr(r, ctx, objs, visible, depth - 1);
        Expr::Shift(r.odds(50), Box::new(e), r.range(1, 31) as u8)
    } else {
        const OPS: [BinKind; 6] = [
            BinKind::Add,
            BinKind::Sub,
            BinKind::Mul,
            BinKind::Xor,
            BinKind::And,
            BinKind::Or,
        ];
        let op = *r.pick(&OPS);
        let a = gen_expr(r, ctx, objs, visible, depth - 1);
        let b = gen_expr(r, ctx, objs, visible, depth - 1);
        Expr::Bin(op, Box::new(a), Box::new(b))
    }
}

fn gen_args(
    r: &mut Rng,
    ctx: &GenCtx,
    objs: &[Obj],
    visible: &[u16],
    params: &[PKind],
) -> Option<Vec<Arg>> {
    let mut args = Vec::new();
    for p in params {
        match p {
            PKind::Scalar => args.push(Arg::Scalar(gen_expr(r, ctx, objs, visible, 2))),
            PKind::ByVal(t) => {
                let cands = objs_of_type(objs, visible, *t);
                args.push(Arg::ByVal(*r.pick(cands.get(..)?)));
            }
            PKind::Ptr(t) => {
                let cands = objs_of_type(objs, visible, *t);
                args.push(Arg::Ptr(*r.pick(cands.get(..)?)));
            }
        }
    }
    Some(args)
}

/// Emit `n` statements into `stmts`, appending call temporaries to
/// `objs` / `visible` as they are declared. `nested` forbids the
/// declaring forms so a loop body cannot introduce an object the
/// statements after the loop would reference out of scope.
#[allow(clippy::too_many_arguments)]
fn gen_stmts(
    r: &mut Rng,
    ctx: &GenCtx,
    objs: &mut Vec<Obj>,
    visible: &mut Vec<u16>,
    stmts: &mut Vec<Stmt>,
    n: usize,
    nested: bool,
) {
    for _ in 0..n {
        let roll = r.below(100);
        if roll < 26 && !ctx.helpers.is_empty() {
            let callee = r.below(ctx.helpers.len());
            let h = &ctx.helpers[callee];
            let Some(args) = gen_args(r, ctx, objs, visible, &h.params) else {
                continue;
            };
            let scalars = scalar_objs(objs);
            match h.ret {
                Ret::Void => stmts.push(Stmt::CallVoid {
                    callee: callee as u16,
                    args,
                }),
                Ret::Scalar => stmts.push(Stmt::CallScalar {
                    dst: *r.pick(&scalars),
                    callee: callee as u16,
                    args,
                }),
                Ret::Agg(t) => {
                    let form = r.below(100);
                    if form < 40 && !nested {
                        let obj = objs.len() as u16;
                        objs.push(Obj {
                            name: format!("t{obj}"),
                            ty: Some(t),
                            deref: false,
                            decl: Decl::CallTemp,
                        });
                        stmts.push(Stmt::CallAggDecl {
                            obj,
                            callee: callee as u16,
                            args,
                        });
                        visible.push(obj);
                    } else if form < 70 {
                        let cands = objs_of_type(objs, visible, t);
                        if cands.is_empty() {
                            continue;
                        }
                        stmts.push(Stmt::CallAggAssign {
                            obj: *r.pick(&cands),
                            callee: callee as u16,
                            args,
                        });
                    } else {
                        let leaf = r.below(ctx.types[t].leaves.len()) as u16;
                        stmts.push(Stmt::CallAggMember {
                            dst: *r.pick(&scalars),
                            callee: callee as u16,
                            args,
                            leaf,
                        });
                    }
                }
            }
            continue;
        }
        if roll < 40 {
            let writable: Vec<u16> = visible
                .iter()
                .copied()
                .filter(|&i| objs[i as usize].ty.is_some())
                .collect();
            if writable.is_empty() {
                continue;
            }
            let obj = *r.pick(&writable);
            let t = objs[obj as usize].ty.unwrap();
            let leaf = r.below(ctx.types[t].leaves.len()) as u16;
            let expr = gen_expr(r, ctx, objs, visible, 2);
            stmts.push(Stmt::SetLeaf { obj, leaf, expr });
            continue;
        }
        if roll < 48 {
            let fp: Vec<(u16, u16, Scalar)> = visible
                .iter()
                .filter_map(|&i| objs[i as usize].ty.map(|t| (i, t)))
                .flat_map(|(i, t)| {
                    ctx.types[t]
                        .leaves
                        .iter()
                        .enumerate()
                        .filter(|(_, l)| l.sc.is_fp())
                        .map(move |(k, l)| (i, k as u16, l.sc))
                })
                .collect();
            if fp.len() >= 2 {
                let (dst, dleaf, sc) = *r.pick(&fp);
                let same: Vec<(u16, u16, Scalar)> =
                    fp.iter().copied().filter(|(_, _, s)| *s == sc).collect();
                if same.len() >= 2 {
                    let a = *r.pick(&same);
                    let b = *r.pick(&same);
                    stmts.push(Stmt::FpAdd {
                        dst,
                        dleaf,
                        a: (a.0, a.1),
                        b: (b.0, b.1),
                    });
                    continue;
                }
            }
        }
        if roll < 56 {
            let by_type: Vec<(u16, usize)> = visible
                .iter()
                .filter_map(|&i| objs[i as usize].ty.map(|t| (i, t)))
                .collect();
            let pairs: Vec<(u16, u16)> = by_type
                .iter()
                .flat_map(|(d, dt)| {
                    by_type
                        .iter()
                        .filter(move |(s, st)| st == dt && s != d)
                        .map(move |(s, _)| (*d, *s))
                })
                .collect();
            if !pairs.is_empty() {
                let (dst, src) = *r.pick(&pairs);
                stmts.push(Stmt::CopyAgg { dst, src });
                continue;
            }
        }
        if roll < 66 && !nested {
            let count = r.range(2, 5) as u8;
            let mut body = Vec::new();
            let mut inner = visible.clone();
            let inner_n = r.range(1, 3);
            gen_stmts(r, ctx, objs, &mut inner, &mut body, inner_n, true);
            if !body.is_empty() {
                stmts.push(Stmt::Loop { count, body });
                continue;
            }
        }
        stmts.push(Stmt::Mix {
            expr: gen_expr(r, ctx, objs, visible, 3),
        });
    }
}

/// Two leaves of `ty` that share an eightbyte, else the first two, else
/// `None`.
fn paired_leaves(ty: &AggTy) -> Option<(u16, u16)> {
    for a in 0..ty.leaves.len() {
        for b in a + 1..ty.leaves.len() {
            if ty.leaves[a].offset / 8 == ty.leaves[b].offset / 8 {
                return Some((a as u16, b as u16));
            }
        }
    }
    (ty.leaves.len() >= 2).then_some((0, 1))
}

fn gen_body(
    r: &mut Rng,
    ctx: &GenCtx,
    params: &[PKind],
    ret: Ret,
    stmt_budget: usize,
    bulk: usize,
    top_level: bool,
) -> Body {
    let scalars = r.range(1, 3);
    let (mut objs, acc) = base_objs(params, ctx.types, scalars);
    let ret_obj = match ret {
        Ret::Agg(t) => {
            let idx = objs.len() as u16;
            objs.push(Obj {
                name: "rv".to_string(),
                ty: Some(t),
                deref: false,
                decl: Decl::ZeroAgg,
            });
            Some(idx)
        }
        _ => None,
    };
    let mut visible: Vec<u16> = (0..objs.len() as u16).collect();
    let mut stmts = Vec::new();
    // The promotion pass only runs on a function that absorbed a splice
    // or an unrolled loop, so every body but the leaf helper itself
    // starts with a call to it. Without that the -O leg never reaches
    // the pass this harness exists to exercise.
    if !ctx.helpers.is_empty() {
        stmts.push(Stmt::CallScalar {
            dst: acc,
            callee: 0,
            args: vec![Arg::Scalar(gen_expr(r, ctx, &objs, &visible, 2))],
        });
    }
    let n = if top_level {
        stmt_budget
    } else {
        stmt_budget.clamp(1, 6)
    };
    gen_stmts(r, ctx, &mut objs, &mut visible, &mut stmts, n, false);
    // Filler that pushes the body past the inliner's body cap. Every
    // term reads live state, so the folder cannot collapse it back
    // under the cap.
    for _ in 0..bulk {
        let e = gen_expr(r, ctx, &objs, &visible, 1);
        stmts.push(Stmt::Mix {
            expr: Expr::Bin(BinKind::Add, Box::new(Expr::Var(acc)), Box::new(e)),
        });
    }
    // Read a field pair out of every object the tape never stores to (a
    // by-value parameter's prologue copy, an aggregate return's
    // caller-side temporary). Two fields inside one eightbyte force a
    // field-splitting promotion off the object's own cells and onto
    // fresh slots, where storage nothing wrote becomes observable.
    let pairs: Vec<(u16, u16, u16)> = objs
        .iter()
        .enumerate()
        .filter(|(_, o)| !o.deref && matches!(o.decl, Decl::Param | Decl::CallTemp))
        .filter_map(|(i, o)| o.ty.map(|t| (i as u16, t)))
        .filter_map(|(i, t)| paired_leaves(&ctx.types[t]).map(|(a, b)| (i, a, b)))
        .collect();
    for (obj, a, b) in pairs {
        stmts.push(Stmt::Mix {
            expr: Expr::Bin(
                BinKind::Xor,
                Box::new(Expr::Leaf(obj, a)),
                Box::new(Expr::Leaf(obj, b)),
            ),
        });
    }
    // A `Ret::Agg` body must define every leaf of its result even when
    // the random statements did not touch it; `rv` is `= {0}`, so this
    // only sharpens the value, it is not a definedness requirement.
    if let Some(rv) = ret_obj {
        let t = objs[rv as usize].ty.unwrap();
        for leaf in 0..ctx.types[t].leaves.len() {
            stmts.push(Stmt::SetLeaf {
                obj: rv,
                leaf: leaf as u16,
                expr: gen_expr(r, ctx, &objs, &visible, 2),
            });
        }
    }
    Body {
        objs,
        stmts,
        acc,
        acc_seed: r.next(),
        ret_obj,
    }
}

/// A scalar leaf helper: no aggregate local, one statement, the one
/// shape reliably under the inliner's body cap. Every other body calls
/// it, because the promotion pass only runs on a function that absorbed
/// a splice.
fn leaf_helper(seed: u64) -> Helper {
    let objs = vec![
        Obj {
            name: "p0".to_string(),
            ty: None,
            deref: false,
            decl: Decl::Param,
        },
        Obj {
            name: "acc".to_string(),
            ty: None,
            deref: false,
            decl: Decl::ScalarVar,
        },
    ];
    Helper {
        ret: Ret::Scalar,
        params: vec![PKind::Scalar],
        body: Body {
            objs,
            stmts: vec![Stmt::Mix {
                expr: Expr::Bin(
                    BinKind::Mul,
                    Box::new(Expr::Var(0)),
                    Box::new(Expr::Const(0x9e37_79b9_7f4a_7c15)),
                ),
            }],
            acc: 1,
            acc_seed: seed,
            ret_obj: None,
        },
    }
}

fn generate(shape: &Shape) -> Prog {
    let mut r = Rng::new(shape.seed);
    let types = gen_types(&mut r, shape);
    let mut helpers: Vec<Helper> = Vec::new();
    helpers.push(leaf_helper(r.next()));
    for h in 1..shape.n_helpers + 1 {
        let mut params = Vec::new();
        let np = r.range(0, 3);
        for _ in 0..np {
            let roll = r.below(100);
            if shape.ptr_args && roll < 25 {
                params.push(PKind::Ptr(r.below(types.len())));
            } else if shape.by_value_args && roll < 70 {
                params.push(PKind::ByVal(r.below(types.len())));
            } else {
                params.push(PKind::Scalar);
            }
        }
        let has_ptr = params.iter().any(|p| matches!(p, PKind::Ptr(_)));
        let ret = match r.below(100) {
            0..=59 => Ret::Agg(r.below(types.len())),
            60..=84 => Ret::Scalar,
            _ if has_ptr => Ret::Void,
            _ => Ret::Scalar,
        };
        let ctx = GenCtx {
            types: &types,
            helpers: &helpers,
        };
        // Alternate: the even helpers are kept short enough to inline (a
        // caller needs one spliced callee for the promotion pass to run
        // on it at all), the odd ones are pushed past the body cap.
        let (budget, bulk) = if h % 2 == 1 {
            (shape.stmts, shape.bulk)
        } else {
            (shape.stmts.min(2), 0)
        };
        let body = gen_body(&mut r, &ctx, &params, ret, budget, bulk, false);
        helpers.push(Helper { ret, params, body });
    }
    let ctx = GenCtx {
        types: &types,
        helpers: &helpers,
    };
    let main = gen_body(&mut r, &ctx, &[], Ret::Scalar, shape.stmts + 4, 0, true);
    Prog {
        types,
        helpers,
        main,
    }
}

// ------------------------------------------------------------ renderer

/// Renders one generated program. `pfx` prefixes every file-scope name
/// so several programs can share a translation unit, which is what lets
/// the reference-compiler leg amortise one compile and one process
/// launch over a whole batch.
struct Ctx<'a> {
    p: &'a Prog,
    pfx: &'a str,
}

fn render_expr(c: &Ctx, b: &Body, e: &Expr, out: &mut String) {
    match e {
        Expr::Const(k) => {
            let _ = write!(out, "{k:#x}ull");
        }
        Expr::Var(i) => out.push_str(&b.objs[*i as usize].name),
        Expr::Leaf(o, l) => {
            let obj = &b.objs[*o as usize];
            let t = obj.ty.expect("leaf read of a scalar object");
            let _ = write!(
                out,
                "(unsigned long long)({})",
                obj.access(&c.p.types[t].leaves[*l as usize].path)
            );
        }
        Expr::Bin(op, a, r) => {
            out.push('(');
            render_expr(c, b, a, out);
            let _ = write!(out, " {} ", op.c_op());
            render_expr(c, b, r, out);
            out.push(')');
        }
        Expr::Shift(left, a, n) => {
            out.push('(');
            render_expr(c, b, a, out);
            let _ = write!(out, " {} {n})", if *left { "<<" } else { ">>" });
        }
    }
}

fn render_args(c: &Ctx, b: &Body, args: &[Arg], out: &mut String) {
    out.push('(');
    for (i, a) in args.iter().enumerate() {
        if i > 0 {
            out.push_str(", ");
        }
        match a {
            Arg::Scalar(e) => render_expr(c, b, e, out),
            Arg::ByVal(o) => out.push_str(&b.objs[*o as usize].deref_name()),
            Arg::Ptr(o) => {
                let obj = &b.objs[*o as usize];
                if obj.deref {
                    out.push_str(&obj.name);
                } else {
                    let _ = write!(out, "&{}", obj.name);
                }
            }
        }
    }
    out.push(')');
}

fn render_set_leaf(c: &Ctx, b: &Body, obj: u16, leaf: u16, e: &Expr, ind: usize, out: &mut String) {
    let o = &b.objs[obj as usize];
    let t = o.ty.expect("leaf store to a scalar object");
    let li = &c.p.types[t].leaves[leaf as usize];
    let _ = write!(
        out,
        "{:ind$}{} = ({})(",
        "",
        o.access(&li.path),
        li.sc.c_type()
    );
    if li.sc.is_fp() {
        out.push('(');
        render_expr(c, b, e, out);
        let _ = write!(out, ") & {:#x}ull", li.sc.domain());
    } else {
        render_expr(c, b, e, out);
    }
    out.push_str(");\n");
}

fn render_stmt(c: &Ctx, b: &Body, s: &Stmt, ind: usize, out: &mut String) {
    match s {
        Stmt::SetLeaf { obj, leaf, expr } => render_set_leaf(c, b, *obj, *leaf, expr, ind, out),
        Stmt::FpAdd {
            dst,
            dleaf,
            a,
            b: rhs,
        } => {
            let o = &b.objs[*dst as usize];
            let li = &c.p.types[o.ty.unwrap()].leaves[*dleaf as usize];
            let ty = li.sc.c_type();
            let mask = li.sc.domain();
            let side = |x: &(u16, u16)| {
                let so = &b.objs[x.0 as usize];
                let sl = &c.p.types[so.ty.unwrap()].leaves[x.1 as usize];
                format!(
                    "({ty})((unsigned long long)({}) & {mask:#x}ull)",
                    so.access(&sl.path)
                )
            };
            let _ = writeln!(
                out,
                "{:ind$}{} = ({ty})({} + {});",
                "",
                o.access(&li.path),
                side(a),
                side(rhs)
            );
        }
        Stmt::CopyAgg { dst, src } => {
            let _ = writeln!(
                out,
                "{:ind$}{} = {};",
                "",
                b.objs[*dst as usize].deref_name(),
                b.objs[*src as usize].deref_name()
            );
        }
        Stmt::CallAggDecl { obj, callee, args } => {
            let o = &b.objs[*obj as usize];
            let _ = write!(
                out,
                "{:ind$}struct {}S{} {} = {}h{callee}",
                "",
                c.pfx,
                o.ty.unwrap(),
                o.name,
                c.pfx
            );
            render_args(c, b, args, out);
            out.push_str(";\n");
        }
        Stmt::CallAggAssign { obj, callee, args } => {
            let _ = write!(
                out,
                "{:ind$}{} = {}h{callee}",
                "",
                b.objs[*obj as usize].deref_name(),
                c.pfx
            );
            render_args(c, b, args, out);
            out.push_str(";\n");
        }
        Stmt::CallAggMember {
            dst,
            callee,
            args,
            leaf,
        } => {
            let t = match c.p.helpers[*callee as usize].ret {
                Ret::Agg(t) => t,
                _ => unreachable!("aggregate member of a non-aggregate return"),
            };
            let _ = write!(
                out,
                "{:ind$}{} = (unsigned long long)({}h{callee}",
                "",
                b.objs[*dst as usize].name,
                c.pfx
            );
            render_args(c, b, args, out);
            let _ = writeln!(out, "{});", c.p.types[t].leaves[*leaf as usize].path);
        }
        Stmt::CallScalar { dst, callee, args } => {
            let _ = write!(
                out,
                "{:ind$}{} = {}h{callee}",
                "",
                b.objs[*dst as usize].name,
                c.pfx
            );
            render_args(c, b, args, out);
            out.push_str(";\n");
        }
        Stmt::CallVoid { callee, args } => {
            let _ = write!(out, "{:ind$}{}h{callee}", "", c.pfx);
            render_args(c, b, args, out);
            out.push_str(";\n");
        }
        Stmt::Mix { expr } => {
            let _ = write!(out, "{:ind$}acc = (acc * 0x100000001b3ull) ^ (", "");
            render_expr(c, b, expr, out);
            out.push_str(");\n");
        }
        Stmt::Loop { count, body } => {
            let _ = writeln!(out, "{:ind$}for (i = 0; i < {count}; i++) {{", "");
            for s in body {
                render_stmt(c, b, s, ind + 4, out);
            }
            let _ = writeln!(out, "{:ind$}}}", "");
        }
    }
}

impl Obj {
    /// The object itself as an lvalue (`(*p)` for a pointer parameter).
    fn deref_name(&self) -> String {
        if self.deref {
            format!("(*{})", self.name)
        } else {
            self.name.clone()
        }
    }
}

fn render_body(c: &Ctx, b: &Body, ret: Ret, out: &mut String) {
    let _ = writeln!(out, "    int i = 0;");
    let _ = writeln!(out, "    unsigned long long acc = {:#x}ull;", b.acc_seed);
    for o in &b.objs {
        match o.decl {
            Decl::ZeroAgg => {
                let _ = writeln!(
                    out,
                    "    struct {}S{} {} = {{0}};",
                    c.pfx,
                    o.ty.unwrap(),
                    o.name
                );
            }
            Decl::ScalarVar if o.name != "acc" => {
                let _ = writeln!(out, "    unsigned long long {} = 0;", o.name);
            }
            _ => {}
        }
    }
    let _ = writeln!(out, "    (void)i;");
    for s in &b.stmts {
        render_stmt(c, b, s, 4, out);
    }
    match ret {
        Ret::Void => {}
        Ret::Scalar => out.push_str("    return acc;\n"),
        Ret::Agg(_) => {
            let _ = writeln!(
                out,
                "    return {};",
                b.objs[b.ret_obj.unwrap() as usize].name
            );
        }
    }
}

/// One program as a translation-unit fragment: its aggregate types, its
/// helpers, and `<pfx>run`, which returns the raw 64-bit accumulator.
fn render_unit(p: &Prog, pfx: &str) -> String {
    let c = Ctx { p, pfx };
    let mut out = String::new();
    for (t, ty) in p.types.iter().enumerate() {
        let _ = writeln!(out, "struct {pfx}S{t} {{");
        for (i, m) in ty.members.iter().enumerate() {
            match m {
                Member::Sc(sc) => {
                    let _ = writeln!(out, "    {} f{i};", sc.c_type());
                }
                Member::Arr(sc, n) => {
                    let _ = writeln!(out, "    {} f{i}[{n}];", sc.c_type());
                }
                Member::Agg(s) => {
                    let _ = writeln!(out, "    struct {pfx}S{s} f{i};");
                }
            }
        }
        out.push_str("};\n");
    }
    out.push('\n');
    for (h, hf) in p.helpers.iter().enumerate() {
        let ret = match hf.ret {
            Ret::Void => "void".to_string(),
            Ret::Scalar => "unsigned long long".to_string(),
            Ret::Agg(t) => format!("struct {pfx}S{t}"),
        };
        let _ = write!(out, "static {ret} {pfx}h{h}(");
        if hf.params.is_empty() {
            out.push_str("void");
        }
        for (i, pk) in hf.params.iter().enumerate() {
            if i > 0 {
                out.push_str(", ");
            }
            match pk {
                PKind::Scalar => {
                    let _ = write!(out, "unsigned long long p{i}");
                }
                PKind::ByVal(t) => {
                    let _ = write!(out, "struct {pfx}S{t} p{i}");
                }
                PKind::Ptr(t) => {
                    let _ = write!(out, "struct {pfx}S{t} *p{i}");
                }
            }
        }
        out.push_str(") {\n");
        render_body(&c, &hf.body, hf.ret, &mut out);
        out.push_str("}\n\n");
    }
    let _ = writeln!(out, "unsigned long long {pfx}run(void) {{");
    render_body(&c, &p.main, Ret::Scalar, &mut out);
    out.push_str("}\n");
    out
}

const FOLD_C: &str = "\
    acc ^= acc >> 33;
    acc *= 0xff51afd7ed558ccdull;
    acc ^= acc >> 33;
";

/// The badc legs compile this: one program plus a `main` that folds the
/// accumulator into an exit code.
fn render_standalone(p: &Prog) -> String {
    let mut out = render_unit(p, "");
    out.push_str("\nint main(void) {\n    unsigned long long acc = run();\n");
    out.push_str(FOLD_C);
    out.push_str("    return (int)(unsigned int)(acc & 0x7fffffffull);\n}\n");
    out
}

/// One translation unit holding `progs` side by side, printing each
/// accumulator in order.
fn render_batch(progs: &[Case]) -> String {
    let mut out = String::from("int printf(const char *, ...);\n\n");
    for (i, case) in progs.iter().enumerate() {
        out.push_str(&render_unit(&case.prog, &format!("g{i}_")));
        out.push('\n');
    }
    out.push_str("int main(void) {\n");
    for i in 0..progs.len() {
        let _ = writeln!(out, "    printf(\"%llu\\n\", g{i}_run());");
    }
    out.push_str("    return 0;\n}\n");
    out
}

// --------------------------------------------------------------- model

/// Exact evaluation of the same IR the renderer prints. Integer leaves
/// wrap like C's unsigned types; float leaves are asserted to stay in
/// the exactly-representable integer range, which is what makes the
/// model and the compiled program agree bit for bit.
struct Machine<'a> {
    prog: &'a Prog,
    arena: Vec<Vec<u64>>,
}

enum ArgVal {
    Sc(u64),
    Agg(Vec<u64>),
    Ptr(usize),
}

enum RetVal {
    None,
    Sc(u64),
    Agg(Vec<u64>),
}

struct Frame {
    agg: Vec<usize>,
    sc: Vec<u64>,
}

impl Machine<'_> {
    fn store(&mut self, slot: usize, leaf: usize, sc: Scalar, v: u64) {
        let v = v & sc.domain();
        assert!(
            !sc.is_fp() || v < sc.exact_limit(),
            "float leaf value {v} is not exactly representable"
        );
        self.arena[slot][leaf] = v;
    }

    fn eval(&self, f: &Frame, e: &Expr) -> u64 {
        match e {
            Expr::Const(k) => *k,
            Expr::Var(i) => f.sc[*i as usize],
            Expr::Leaf(o, l) => self.arena[f.agg[*o as usize]][*l as usize],
            Expr::Bin(op, a, c) => op.apply(self.eval(f, a), self.eval(f, c)),
            Expr::Shift(left, a, n) => {
                let v = self.eval(f, a);
                if *left { v << *n } else { v >> *n }
            }
        }
    }

    fn arg_vals(&self, f: &Frame, args: &[Arg]) -> Vec<ArgVal> {
        args.iter()
            .map(|a| match a {
                Arg::Scalar(e) => ArgVal::Sc(self.eval(f, e)),
                Arg::ByVal(o) => ArgVal::Agg(self.arena[f.agg[*o as usize]].clone()),
                Arg::Ptr(o) => ArgVal::Ptr(f.agg[*o as usize]),
            })
            .collect()
    }

    fn run_stmts(&mut self, b: &Body, f: &mut Frame, stmts: &[Stmt]) {
        for s in stmts {
            match s {
                Stmt::SetLeaf { obj, leaf, expr } => {
                    let t = b.objs[*obj as usize].ty.unwrap();
                    let sc = self.prog.types[t].leaves[*leaf as usize].sc;
                    let v = self.eval(f, expr);
                    self.store(f.agg[*obj as usize], *leaf as usize, sc, v);
                }
                Stmt::FpAdd {
                    dst,
                    dleaf,
                    a,
                    b: rhs,
                } => {
                    let dt = b.objs[*dst as usize].ty.unwrap();
                    let sc = self.prog.types[dt].leaves[*dleaf as usize].sc;
                    let side = |x: &(u16, u16)| {
                        let st = b.objs[x.0 as usize].ty.unwrap();
                        let m = self.prog.types[st].leaves[x.1 as usize].sc.domain();
                        self.arena[f.agg[x.0 as usize]][x.1 as usize] & m
                    };
                    let v = side(a) + side(rhs);
                    assert!(v < sc.exact_limit(), "float add {v} left the exact range");
                    self.arena[f.agg[*dst as usize]][*dleaf as usize] = v;
                }
                Stmt::CopyAgg { dst, src } => {
                    let v = self.arena[f.agg[*src as usize]].clone();
                    self.arena[f.agg[*dst as usize]] = v;
                }
                Stmt::CallAggDecl { obj, callee, args }
                | Stmt::CallAggAssign { obj, callee, args } => {
                    let vals = self.arg_vals(f, args);
                    match self.call(*callee as usize, vals) {
                        RetVal::Agg(v) => self.arena[f.agg[*obj as usize]] = v,
                        _ => unreachable!("aggregate call form on a non-aggregate return"),
                    }
                }
                Stmt::CallAggMember {
                    dst,
                    callee,
                    args,
                    leaf,
                } => {
                    let vals = self.arg_vals(f, args);
                    match self.call(*callee as usize, vals) {
                        RetVal::Agg(v) => f.sc[*dst as usize] = v[*leaf as usize],
                        _ => unreachable!("member read of a non-aggregate return"),
                    }
                }
                Stmt::CallScalar { dst, callee, args } => {
                    let vals = self.arg_vals(f, args);
                    match self.call(*callee as usize, vals) {
                        RetVal::Sc(v) => f.sc[*dst as usize] = v,
                        _ => unreachable!("scalar call form on a non-scalar return"),
                    }
                }
                Stmt::CallVoid { callee, args } => {
                    let vals = self.arg_vals(f, args);
                    self.call(*callee as usize, vals);
                }
                Stmt::Mix { expr } => {
                    let v = self.eval(f, expr);
                    f.sc[b.acc as usize] = f.sc[b.acc as usize].wrapping_mul(0x100000001b3) ^ v;
                }
                Stmt::Loop { count, body } => {
                    for _ in 0..*count {
                        self.run_stmts(b, f, body);
                    }
                }
            }
        }
    }

    fn enter(&mut self, b: &Body, args: Vec<ArgVal>) -> Frame {
        let mut f = Frame {
            agg: vec![usize::MAX; b.objs.len()],
            sc: vec![0; b.objs.len()],
        };
        let mut args = args.into_iter();
        for (i, o) in b.objs.iter().enumerate() {
            match (o.decl, o.ty) {
                (Decl::Param, Some(_)) => match args.next() {
                    Some(ArgVal::Agg(v)) => {
                        self.arena.push(v);
                        f.agg[i] = self.arena.len() - 1;
                    }
                    Some(ArgVal::Ptr(slot)) => f.agg[i] = slot,
                    _ => unreachable!("aggregate parameter without an aggregate argument"),
                },
                (Decl::Param, None) => match args.next() {
                    Some(ArgVal::Sc(v)) => f.sc[i] = v,
                    _ => unreachable!("scalar parameter without a scalar argument"),
                },
                (_, Some(t)) => {
                    self.arena.push(vec![0; self.prog.types[t].leaves.len()]);
                    f.agg[i] = self.arena.len() - 1;
                }
                (_, None) => {}
            }
        }
        f.sc[b.acc as usize] = b.acc_seed;
        f
    }

    fn call(&mut self, id: usize, args: Vec<ArgVal>) -> RetVal {
        let h = &self.prog.helpers[id];
        let mark = self.arena.len();
        let mut f = self.enter(&h.body, args);
        self.run_stmts(&h.body, &mut f, &h.body.stmts);
        let out = match h.ret {
            Ret::Void => RetVal::None,
            Ret::Scalar => RetVal::Sc(f.sc[h.body.acc as usize]),
            Ret::Agg(_) => RetVal::Agg(self.arena[f.agg[h.body.ret_obj.unwrap() as usize]].clone()),
        };
        // Frames the callee owns die here; a pointer argument aliases a
        // caller slot below the mark, so truncation cannot orphan one.
        self.arena.truncate(mark);
        out
    }
}

/// The raw accumulator `run()` produces.
fn model_acc(p: &Prog) -> u64 {
    let mut m = Machine {
        prog: p,
        arena: Vec::new(),
    };
    let mut f = m.enter(&p.main, Vec::new());
    m.run_stmts(&p.main, &mut f, &p.main.stmts);
    f.sc[p.main.acc as usize]
}

fn fold(mut acc: u64) -> i32 {
    acc ^= acc >> 33;
    acc = acc.wrapping_mul(0xff51afd7ed558ccd);
    acc ^= acc >> 33;
    (acc & 0x7fff_ffff) as i32
}

// ------------------------------------------------------------- oracles

struct Case {
    shape: Shape,
    prog: Prog,
    src: String,
    acc: u64,
}

fn make_case(shape: &Shape) -> Case {
    let prog = generate(shape);
    let src = render_standalone(&prog);
    let acc = model_acc(&prog);
    Case {
        shape: *shape,
        prog,
        src,
        acc,
    }
}

#[derive(Debug)]
struct Divergence {
    shape: Shape,
    source: String,
    values: Vec<(String, String)>,
}

/// Wall-clock allowance for one badc leg. A generated program runs in
/// microseconds; anything near this is a defect, not load.
const LEG_TIMEOUT: std::time::Duration = std::time::Duration::from_secs(10);

/// Run one leg on its own thread and give up after [`LEG_TIMEOUT`]. Wrong
/// code can turn a bounded loop unbounded and an in-process JIT cannot
/// be interrupted, so reporting the timeout keeps the sweep diagnosable
/// instead of hanging the test runner. The abandoned thread spins until
/// the process exits, by which point the run is already failing.
fn jit_value(src: &str, optimize: bool, gpr: usize, fpr: usize) -> Result<i32, String> {
    let (tx, rx) = std::sync::mpsc::channel();
    let owned = src.to_string();
    std::thread::spawn(move || {
        let _ = tx.send(jit_value_inner(&owned, optimize, gpr, fpr));
    });
    rx.recv_timeout(LEG_TIMEOUT)
        .unwrap_or_else(|_| Err(format!("did not terminate within {LEG_TIMEOUT:?}")))
}

fn jit_value_inner(src: &str, optimize: bool, gpr: usize, fpr: usize) -> Result<i32, String> {
    let program = Compiler::new(src.to_string())
        .compile()
        .map_err(|e| format!("compile: {e}"))?;
    let mut opts = NativeOptions::new();
    if optimize {
        opts = opts.with_optimize();
    }
    let argv = ["frame-slot-fuzz".to_string()];
    let run = || jit_run_with_options(&program, &argv, opts).map_err(|e| format!("jit: {e}"));
    if gpr == 0 {
        run()
    } else {
        with_pool_size_override(gpr, fpr, run)
    }
}

/// badc at both optimization levels against the model.
fn badc_check(case: &Case) -> Option<Divergence> {
    let want = fold(case.acc);
    let mut values = vec![("model".to_string(), format!("{want}"))];
    let mut bad = false;
    for (label, optimize) in [("badc -O0", false), ("badc -O", true)] {
        match jit_value(
            &case.src,
            optimize,
            case.shape.max_gpr,
            case.shape.max_fpr,
        ) {
            Ok(v) => {
                values.push((label.to_string(), format!("{v}")));
                bad |= v != want;
            }
            Err(e) => {
                values.push((label.to_string(), e));
                bad = true;
            }
        }
    }
    bad.then(|| Divergence {
        shape: case.shape,
        source: case.src.clone(),
        values,
    })
}

/// Reference compiler, resolved once: `$CC` if set, else the first of
/// `cc` / `clang` / `gcc` that runs.
fn reference_cc() -> Option<&'static str> {
    static CC: OnceLock<Option<String>> = OnceLock::new();
    CC.get_or_init(|| {
        let mut cands: Vec<String> = Vec::new();
        if let Ok(v) = std::env::var("CC") {
            cands.push(v);
        }
        cands.extend(["cc", "clang", "gcc"].iter().map(|s| s.to_string()));
        cands.into_iter().find(|c| {
            std::process::Command::new(c)
                .arg("--version")
                .stdout(std::process::Stdio::null())
                .stderr(std::process::Stdio::null())
                .status()
                .map(|s| s.success())
                .unwrap_or(false)
        })
    })
    .as_deref()
}

/// Build and run one batch under the reference compiler and return the
/// accumulator each program produced. A rejected batch is an error: the
/// generator is only allowed to emit strictly conforming C, so a
/// diagnostic means the shape space, not the compiler under test, is
/// wrong.
fn reference_accs(cc: &str, cases: &[Case], tag: u64) -> Result<Vec<u64>, String> {
    let dir = std::env::temp_dir().join(format!("badc-frame-slot-fuzz-{}", std::process::id()));
    std::fs::create_dir_all(&dir).map_err(|e| format!("temp dir: {e}"))?;
    let c = dir.join(format!("b{tag}.c"));
    let exe = dir.join(format!("b{tag}.bin"));
    std::fs::write(&c, render_batch(cases)).map_err(|e| format!("write: {e}"))?;
    let built = std::process::Command::new(cc)
        .args(["-std=c99", "-pedantic-errors", "-O0", "-o"])
        .arg(&exe)
        .arg(&c)
        .output()
        .map_err(|e| format!("spawn {cc}: {e}"))?;
    let result = if built.status.success() {
        match std::process::Command::new(&exe).output() {
            Ok(o) if o.status.success() => String::from_utf8_lossy(&o.stdout)
                .lines()
                .map(|l| l.trim().parse::<u64>().map_err(|e| format!("{l:?}: {e}")))
                .collect(),
            Ok(o) => Err(format!("batch exited {:?}", o.status)),
            Err(e) => Err(format!("run: {e}")),
        }
    } else {
        Err(format!(
            "{cc} rejected the batch:\n{}",
            String::from_utf8_lossy(&built.stderr)
        ))
    };
    let _ = std::fs::remove_file(&c);
    let _ = std::fs::remove_file(&exe);
    result
}

/// Compare a batch against the model. The reference sees the full
/// 64-bit accumulator, not the folded exit code.
fn reference_check(cases: &[Case], tag: u64) -> Option<Divergence> {
    if cases.is_empty() {
        return None;
    }
    let cc = reference_cc()?;
    match reference_accs(cc, cases, tag) {
        Ok(accs) if accs.len() == cases.len() => {
            for (case, got) in cases.iter().zip(accs) {
                if got != case.acc {
                    return Some(Divergence {
                        shape: case.shape,
                        source: case.src.clone(),
                        values: vec![
                            ("model".to_string(), format!("{:#x}", case.acc)),
                            (format!("{cc} -O0"), format!("{got:#x}")),
                        ],
                    });
                }
            }
            None
        }
        Ok(accs) => Some(Divergence {
            shape: cases[0].shape,
            source: cases[0].src.clone(),
            values: vec![(
                format!("{cc} -O0"),
                format!("{} results for {} programs", accs.len(), cases.len()),
            )],
        }),
        Err(e) => Some(Divergence {
            shape: cases[0].shape,
            source: cases[0].src.clone(),
            values: vec![(format!("{cc} -O0"), e)],
        }),
    }
}

#[derive(Clone, Copy)]
struct Checks {
    reference: bool,
}

fn check(shape: &Shape, checks: Checks) -> Option<Divergence> {
    let case = make_case(shape);
    badc_check(&case).or_else(|| {
        if checks.reference {
            reference_check(std::slice::from_ref(&case), shape.seed)
        } else {
            None
        }
    })
}

// --------------------------------------------------------------- reduce

/// Greedy one-pass minimisation over the shape knobs. Each candidate is
/// regenerated from the same seed, so a kept step stays reproducible on
/// its own.
fn reduce(shape: &Shape, checks: Checks) -> Shape {
    let mut best = *shape;
    let ints: [fn(&mut Shape) -> &mut usize; 5] = [
        |s| &mut s.n_helpers,
        |s| &mut s.stmts,
        |s| &mut s.bulk,
        |s| &mut s.max_fields,
        |s| &mut s.n_types,
    ];
    for get in ints {
        loop {
            let mut cand = best;
            let v = get(&mut cand);
            if *v <= 1 {
                break;
            }
            *v -= 1;
            if check(&cand, checks).is_some() {
                best = cand;
            } else {
                break;
            }
        }
    }
    let flags: [fn(&mut Shape) -> &mut bool; 6] = [
        |s| &mut s.loops,
        |s| &mut s.nest,
        |s| &mut s.arrays,
        |s| &mut s.floats,
        |s| &mut s.ptr_args,
        |s| &mut s.by_value_args,
    ];
    for get in flags {
        let mut cand = best;
        let f = get(&mut cand);
        if !*f {
            continue;
        }
        *f = false;
        if check(&cand, checks).is_some() {
            best = cand;
        }
    }
    best
}

fn report(d: Divergence, checks: Checks) -> String {
    let reduced = reduce(&d.shape, checks);
    let d = check(&reduced, checks).unwrap_or(d);
    let mut msg = String::new();
    let _ = writeln!(
        msg,
        "frame-slot differential failure\n  seed  {:#018x}\n  shape {:?}",
        d.shape.seed, d.shape
    );
    for (k, v) in &d.values {
        let _ = writeln!(msg, "  {k:>12} = {v}");
    }
    let _ = writeln!(msg, "--- reduced program ---\n{}", d.source);
    msg
}

// --------------------------------------------------------------- driver

fn deep() -> bool {
    std::env::var_os("BADC_FUZZ_FRAME").is_some()
}

fn seed_base() -> u64 {
    std::env::var("BADC_FUZZ_FRAME_SEED")
        .ok()
        .and_then(|v| v.parse::<u64>().ok())
        .unwrap_or(0x5f37_1eaf_0000_0000)
}

fn budget(cheap: usize, deep_default: usize) -> usize {
    if let Ok(v) = std::env::var("BADC_FUZZ_FRAME_ITERS")
        && let Ok(n) = v.parse::<usize>()
    {
        return n;
    }
    if deep() { deep_default } else { cheap }
}

/// Programs per reference batch. One compile and one process launch per
/// batch, so this is the unit that amortises both.
const REF_BATCH: usize = 48;

fn seed_at(base: u64, i: usize) -> u64 {
    Rng::new(base ^ (i as u64).wrapping_mul(0x9e37_79b9_7f4a_7c15)).next()
}

/// Sweep `count` seeds from `base`. `reference` also runs each program
/// under the reference compiler, batched.
fn sweep(base: u64, count: usize, reference: bool, adjust: impl Fn(u64, Shape) -> Shape) {
    let checks = Checks { reference };
    let mut batch: Vec<Case> = Vec::new();
    let flush = |batch: &mut Vec<Case>, tag: u64, upto: usize| {
        if reference && let Some(d) = reference_check(batch, tag) {
            panic!("program <= {upto} of {count}\n{}", report(d, checks));
        }
        batch.clear();
    };
    let trace = std::env::var_os("BADC_FUZZ_FRAME_TRACE").is_some();
    for i in 0..count {
        let seed = seed_at(base, i);
        if trace {
            eprintln!("frame-slot program {i} seed {seed:#018x}");
        }
        let case = make_case(&adjust(seed, Shape::from_seed(seed)));
        if let Some(d) = badc_check(&case) {
            panic!("program {i} of {count}\n{}", report(d, checks));
        }
        if reference {
            batch.push(case);
            if batch.len() >= REF_BATCH {
                flush(&mut batch, seed, i);
            }
        }
    }
    flush(&mut batch, base, count - 1);
}

#[test]
fn frame_slot_shapes() {
    sweep(seed_base(), budget(48, 4000), false, |_, s| s);
}

/// The same shape space under register-pressure caps: the caps move
/// `usable_gpr_count`, which is the promotion budget, so a shape
/// admitted at full pressure may be declined here and vice versa.
#[test]
fn frame_slot_shapes_under_pressure() {
    const CAPS: [(usize, usize); 4] = [(2, 2), (3, 2), (6, 4), (8, 8)];
    sweep(seed_base() ^ 0x1111, budget(48, 4000), false, |seed, s| {
        let (g, f) = CAPS[(seed >> 7) as usize % CAPS.len()];
        s.with_pressure(g, f)
    });
}

/// The reference-compiler leg, which validates the model itself across
/// the shape space and catches a badc that is wrong at both levels.
#[test]
fn frame_slot_shapes_vs_reference() {
    if reference_cc().is_none() {
        return;
    }
    sweep(seed_base() ^ 0x2222, budget(REF_BATCH, 2000), true, |_, s| s);
}

/// The generator must keep producing the shapes this harness exists for.
/// Counts are structural, so this runs without compiling anything.
#[test]
fn shape_space_covers_the_class() {
    let abi = crate::Target::host().abi();
    let (mut ret_temp, mut by_val, mut ptr_par, mut sret, mut in_regs, mut fp_leaf) =
        (0, 0, 0, 0, 0, 0);
    let mut leaf_hist = [0usize; MAX_LEAVES + 1];
    for i in 0..600usize {
        let p = generate(&Shape::from_seed(seed_at(0xa5a5, i)));
        for ty in &p.types {
            leaf_hist[ty.leaves.len()] += 1;
            fp_leaf += ty.leaves.iter().filter(|l| l.sc.is_fp()).count();
            match classify_aggregate(ty.size, ty.align, &ty.flat_fields(), abi, true) {
                AggClass::ReturnIndirect => sret += 1,
                AggClass::Regs(_) => in_regs += 1,
                _ => {}
            }
        }
        for h in &p.helpers {
            by_val += h
                .params
                .iter()
                .filter(|p| matches!(p, PKind::ByVal(_)))
                .count();
            ptr_par += h
                .params
                .iter()
                .filter(|p| matches!(p, PKind::Ptr(_)))
                .count();
        }
        ret_temp += count_ret_temps(&p);
    }
    assert!(ret_temp > 500, "aggregate-return temporaries: {ret_temp}");
    assert!(by_val > 200, "by-value aggregate parameters: {by_val}");
    assert!(ptr_par > 50, "pointer parameters: {ptr_par}");
    assert!(sret > 50, "aggregates returned indirectly: {sret}");
    assert!(in_regs > 50, "aggregates returned in registers: {in_regs}");
    assert!(fp_leaf > 200, "floating-point leaves: {fp_leaf}");
    // The promotion budget is the usable GPR file, so the leaf counts
    // must reach both sides of it.
    let small: usize = leaf_hist[1..=6].iter().sum();
    let large: usize = leaf_hist[7..].iter().sum();
    assert!(small > 100 && large > 100, "leaf histogram {leaf_hist:?}");
}

fn count_ret_temps(p: &Prog) -> usize {
    fn walk(stmts: &[Stmt]) -> usize {
        stmts
            .iter()
            .map(|s| match s {
                Stmt::CallAggDecl { .. }
                | Stmt::CallAggAssign { .. }
                | Stmt::CallAggMember { .. } => 1,
                Stmt::Loop { body, .. } => walk(body),
                _ => 0,
            })
            .sum()
    }
    walk(&p.main.stmts) + p.helpers.iter().map(|h| walk(&h.body.stmts)).sum::<usize>()
}

/// Prints the program a reported seed generates, for feeding to the
/// compiler by hand:
/// `BADC_FUZZ_FRAME_SEED=<seed> cargo test --lib frame_slot_print -- --ignored --nocapture`
#[test]
#[ignore = "prints a program instead of asserting"]
fn frame_slot_print() {
    let shape = Shape::from_seed(seed_base());
    let prog = generate(&shape);
    println!("/* {shape:?} model_acc = {:#x} */", model_acc(&prog));
    println!("{}", render_standalone(&prog));
}

/// A seed must reproduce byte-for-byte, on any host: the failure report
/// is a seed plus a shape, and nothing else.
#[test]
fn generation_is_deterministic() {
    for i in 0..64usize {
        let shape = Shape::from_seed(seed_at(7, i));
        let a = generate(&shape);
        let b = generate(&shape);
        assert_eq!(
            render_standalone(&a),
            render_standalone(&b),
            "render differs for {shape:?}"
        );
        assert_eq!(model_acc(&a), model_acc(&b), "model differs for {shape:?}");
    }
}
