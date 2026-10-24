//! Declarations of an identifier with linkage: C99 6.7p4 and 6.2.7p2 require
//! compatible types and 6.9p3 one function body. The composite type (6.2.7p3)
//! is kept per identifier, across block and file scope.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::codegen::CallConv;
use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::symbol::FnType;
use super::super::token::Ty;
use super::Compiler;
use super::function::{ParamForm, ParsedParams};
use super::types::{
    VOL_LVL_MASK, VOLATILE_MASK, fn_type_spelling, format_signature, format_type, is_void_ty,
    rebase_enum_placeholder, strip_object_const, strip_unsigned, unqualified_version_ty,
};

/// A type as a declaration spelled it: the tag, and the enum tag it named
/// while that enum was incomplete. Such a use took `int`; the tag and its
/// completion are one type (C99 6.7.2.3p1), so the comparison reads the
/// definition once there is one.
#[derive(Clone, Copy, Debug)]
pub(super) struct Spelled {
    pub(super) ty: i64,
    pub(super) enum_tag: Option<u32>,
}

impl Spelled {
    pub(super) fn plain(ty: i64) -> Self {
        Spelled { ty, enum_tag: None }
    }
}

/// The function type a type leads to and the pointer levels above it,
/// which its tag does not spell.
pub(super) type FnSig = Option<(FnType, i64)>;

/// A function type's parameter information (C99 6.7.5.3p14), by [`ParamForm`];
/// a prototype keeps the function types its parameters lead to.
#[derive(Clone, Debug)]
pub(super) enum Params {
    Unspecified,
    Prototype(Vec<Spelled>, bool, Vec<(usize, FnType, i64)>),
    IdentifierList(Vec<Spelled>),
}

impl Params {
    pub(super) fn of(params: &ParsedParams, defining: bool) -> Self {
        let types = params.spelled();
        match params.form {
            ParamForm::Empty if !defining => Params::Unspecified,
            ParamForm::Empty | ParamForm::IdentifierList => Params::IdentifierList(types),
            ParamForm::Prototype => {
                Params::Prototype(types, params.is_variadic, params.fn_types.clone())
            }
        }
    }

    /// The list a composite type keeps: the one saying the most.
    fn rank(&self) -> u8 {
        match self {
            Params::Unspecified => 0,
            Params::IdentifierList(_) => 1,
            Params::Prototype(..) => 2,
        }
    }
}

/// The type one declaration gives an identifier with linkage: an object's
/// type, bounds (outermost first, `-1` unspecified) and the function type it
/// leads to, or a function's, with the calling convention an attribute named
/// and the function type its result leads to.
#[derive(Clone, Debug)]
pub(super) enum DeclaredType {
    Object(Spelled, Vec<i64>, FnSig),
    Function(Spelled, Params, Option<CallConv>, FnSig),
}

/// What a function definition adds to its type: its line and its GNU forms.
pub(super) struct Definition {
    pub(super) ret: Spelled,
    pub(super) ret_fn: FnSig,
    pub(super) conv: Option<CallConv>,
    pub(super) line: usize,
    pub(super) implicit_int: bool,
    pub(super) extern_inline: bool,
}

/// Composite type, first declaration, body position with its `extern inline`,
/// and whether the declarations name a thread-local object.
pub(super) struct LinkedEntity {
    ty: DeclaredType,
    at: (usize, u16),
    body: Option<((usize, u16), bool)>,
    thread_local: bool,
}

/// `Extension`: incompatible under C99, accepted by existing practice.
#[derive(Clone, Copy, PartialEq)]
enum Verdict {
    Compatible,
    Extension,
    Conflict,
}

/// C99 6.5.2.2p6: the default argument promotions.
fn promoted(ty: i64) -> i64 {
    let bare = strip_unsigned(ty);
    if bare == Ty::Float as i64 {
        Ty::Double as i64
    } else if [Ty::Char, Ty::Short, Ty::Bool]
        .iter()
        .any(|&t| bare == t as i64)
    {
        Ty::Int as i64
    } else {
        ty
    }
}

fn compose(prior: DeclaredType, new: DeclaredType) -> DeclaredType {
    match (prior, new) {
        (DeclaredType::Object(ty, a, f), DeclaredType::Object(_, b, g)) => {
            let bounds = a.iter().zip(&b).map(|(&x, &y)| if x < 0 { y } else { x });
            DeclaredType::Object(ty, bounds.collect(), f.or(g))
        }
        (DeclaredType::Function(ret, p, c, f), DeclaredType::Function(_, q, d, g)) => {
            let params = if q.rank() > p.rank() { q } else { p };
            DeclaredType::Function(ret, params, c.or(d), f.or(g))
        }
        (prior, _) => prior,
    }
}

impl Compiler {
    /// The convention a declaration of function `idx` naming `named` gives
    /// it, and whether one of its declarations named it: the first's, in any
    /// scope, as in gcc and clang; a later one naming another is an error.
    pub(super) fn declared_conv(
        &self,
        idx: usize,
        named: Option<CallConv>,
        line: usize,
    ) -> Result<(CallConv, bool), C5Error> {
        let earlier = match self.linked(idx).map(|e| &e.ty) {
            Some(DeclaredType::Function(_, _, c, _)) => *c,
            _ => return Ok((named.unwrap_or_default(), named.is_some())),
        };
        let conv = earlier.unwrap_or_default();
        match named {
            Some(n) if n != conv => {
                let spell = |c| match self.target.abi_row(c) {
                    crate::Target::WindowsX64 => "ms_abi",
                    _ => "sysv_abi",
                };
                let text = format!(
                    "conflicting calling conventions for `{}`: declared `{}`, now `{}`",
                    self.symbols[idx].name,
                    spell(conv),
                    spell(n)
                );
                Err(self.compile_err_at(Code::INVALID_DECLARATION, line, text))
            }
            _ => Ok((conv, earlier.or(named).is_some())),
        }
    }

    /// Check a declaration of `idx` against the earlier ones and fold it in.
    pub(super) fn declare_linked(
        &mut self,
        idx: usize,
        new: DeclaredType,
        line: usize,
        thread_local: bool,
    ) -> Result<(), C5Error> {
        self.fold_linked(idx, new, line, false, thread_local)
    }

    /// A function definition: its type, then the one body 6.9p3 and 6.9p5 admit;
    /// a GNU `extern inline` body serves inlining and yields to a later one.
    pub(super) fn define_linked_function(
        &mut self,
        idx: usize,
        def: Definition,
        params: Params,
    ) -> Result<(), C5Error> {
        let new = DeclaredType::Function(def.ret, params, def.conv, def.ret_fn);
        self.fold_linked(idx, new, def.line, def.implicit_int, false)?;
        // GNU: the implicit `int` keeps the declared return type.
        if def.implicit_int
            && let Some(LinkedEntity {
                ty: DeclaredType::Function(ret, ..),
                ..
            }) = self.linked(idx)
        {
            let ret = self.resolve_spelling(*ret);
            self.symbols[idx].type_ = ret.ty;
            self.symbols[idx].incomplete_enum_tag = ret.enum_tag;
        }
        let at = (def.line, self.intern_source_file());
        let prior = self
            .linked_entities
            .get_mut(self.symbols[idx].name.as_str())
            .and_then(|e| e.body.replace((at, def.extern_inline)));
        match prior {
            Some(((line, file), extern_inline)) if !extern_inline || def.extern_inline => Err(self
                .compile_err_at(
                    Code::INVALID_DECLARATION,
                    def.line,
                    format!(
                        "redefinition of `{}`\n  previous definition: {}:{line}",
                        self.symbols[idx].name, self.source_files[file as usize]
                    ),
                )),
            _ => Ok(()),
        }
    }

    /// The types an old-style definition's arguments arrive as, which its
    /// entry converts to the declared ones (C99 6.9.1p10): those of a prior
    /// prototype (6.7.5.3p15), else the declared types after the default
    /// argument promotions (6.5.2.2p6).
    pub(super) fn old_style_arrival_tys(&self, idx: usize, declared: &[i64]) -> Vec<i64> {
        match self.linked(idx).map(|e| &e.ty) {
            Some(DeclaredType::Function(_, Params::Prototype(t, false, _), ..))
                if t.len() == declared.len() =>
            {
                t.iter().map(|s| self.spelled_ty(*s)).collect()
            }
            _ => declared.iter().map(|&t| promoted(t)).collect(),
        }
    }

    /// Whether a declaration's function type has a prototype (C99 6.2.7p3,
    /// 6.9.1p7): a parameter type list, its own or a prior declaration's.
    pub(super) fn has_prototype(&self, idx: usize, params: &ParsedParams) -> bool {
        !matches!(params.form, ParamForm::Empty | ParamForm::IdentifierList)
            || matches!(
                self.linked(idx).map(|e| &e.ty),
                Some(DeclaredType::Function(_, Params::Prototype(..), ..))
            )
    }

    /// An initializer fixed an unspecified array bound (C99 6.7.8p22).
    pub(super) fn complete_linked_bound(&mut self, idx: usize) {
        let count = match self.symbols[idx].array_dims.as_slice() {
            [outer, _, ..] => *outer,
            _ => self.symbols[idx].array_size,
        };
        if let Some(LinkedEntity {
            ty: DeclaredType::Object(_, bounds, _),
            ..
        }) = self
            .linked_entities
            .get_mut(self.symbols[idx].name.as_str())
            && let Some(outer) = bounds.first_mut().filter(|b| **b < 0)
        {
            *outer = count;
        }
    }

    /// The array bounds the declarator just parsed gave `idx`.
    pub(super) fn declared_bounds(&self, idx: usize, array_size: i64, zero_len: bool) -> Vec<i64> {
        let dims = &self.symbols[idx].array_dims;
        if dims.len() >= 2 {
            let open = array_size < 0 && dims[0] == 0;
            let bound = |(i, &d): (usize, &i64)| if i == 0 && open { -1 } else { d };
            dims.iter().enumerate().map(bound).collect()
        } else if array_size == 0 {
            Vec::new()
        } else if array_size < 0 {
            alloc::vec![if zero_len { 0 } else { -1 }]
        } else {
            alloc::vec![array_size]
        }
    }

    /// What a spelling denotes now: a use of an enum tag before its
    /// definition took the tag's incomplete entry and keeps the tag; once
    /// the definition fixes the type, the spelling reads it and drops the tag.
    pub(super) fn resolve_spelling(&self, s: Spelled) -> Spelled {
        let tag = s.enum_tag.map(|tag| tag as usize);
        match tag.and_then(|id| Some((id, self.structs[id].enum_underlying?))) {
            Some((id, underlying)) => Spelled::plain(rebase_enum_placeholder(s.ty, id, underlying)),
            None => s,
        }
    }

    pub(super) fn spelled_ty(&self, s: Spelled) -> i64 {
        self.resolve_spelling(s).ty
    }

    fn fold_linked(
        &mut self,
        idx: usize,
        new: DeclaredType,
        line: usize,
        implicit_int: bool,
        thread_local: bool,
    ) -> Result<(), C5Error> {
        let at = (line, self.intern_source_file());
        let key = self.symbols[idx].name.clone();
        let Some(prior) = self.linked_entities.remove(&key) else {
            let entity = LinkedEntity {
                ty: new,
                at,
                body: None,
                thread_local,
            };
            self.linked_entities.insert(key, entity);
            return Ok(());
        };
        // C11 6.7.1p3: `_Thread_local` is in every declaration of an object
        // or in none of them.
        if prior.thread_local != thread_local
            && matches!(
                (&prior.ty, &new),
                (DeclaredType::Object(..), DeclaredType::Object(..))
            )
        {
            let (now, was) = if thread_local {
                ("thread-local", "non-thread-local")
            } else {
                ("non-thread-local", "thread-local")
            };
            let (prior_line, file) = prior.at;
            let file = &self.source_files[file as usize];
            return Err(self.compile_err_at(
                Code::INVALID_DECLARATION,
                line,
                format!(
                    "{now} declaration of `{}` follows {was} declaration\n  previous: {file}:{prior_line}",
                    self.symbols[idx].name
                ),
            ));
        }
        let verdict = match (&prior.ty, &new) {
            (DeclaredType::Object(ta, da, fa), DeclaredType::Object(tb, db, fb)) => {
                let bounds = da.len() == db.len()
                    && da.iter().zip(db).all(|(&x, &y)| x < 0 || y < 0 || x == y);
                if bounds
                    && self.tags_agree(self.spelled_ty(*ta), self.spelled_ty(*tb), true)
                    && self.sigs_agree(fa, fb)
                {
                    Verdict::Compatible
                } else {
                    Verdict::Conflict
                }
            }
            (DeclaredType::Function(ra, pa, _, fa), DeclaredType::Function(rb, pb, _, fb)) => {
                // GNU: an implicit `int` definition of a function declared `void`.
                let gnu_void = implicit_int && is_void_ty(ra.ty);
                let rb = if gnu_void { *ra } else { *rb };
                match self.function_verdict((*ra, pa), (rb, pb)) {
                    _ if !self.sigs_agree(fa, fb) => Verdict::Conflict,
                    Verdict::Compatible if gnu_void => Verdict::Extension,
                    v => v,
                }
            }
            _ => Verdict::Conflict,
        };
        if verdict != Verdict::Compatible {
            let name = self.symbols[idx].name.clone();
            let (was, now) = (self.describe(&prior.ty), self.describe(&new));
            if verdict == Verdict::Conflict {
                let (prior_line, file) = prior.at;
                let file = &self.source_files[file as usize];
                let what = match (&prior.ty, &new) {
                    (DeclaredType::Object(..), DeclaredType::Object(..))
                    | (DeclaredType::Function(..), DeclaredType::Function(..)) => {
                        format!("conflicting types for `{name}`")
                    }
                    _ => format!("`{name}` redeclared as a different kind of symbol"),
                };
                return Err(self.compile_err_at(
                    Code::INVALID_DECLARATION,
                    line,
                    format!("{what}\n  previous: {was} ({file}:{prior_line})\n  now:      {now}"),
                ));
            }
            self.warn_at(
                Code::REDECLARATION_MISMATCH,
                line,
                format!(
                    "redeclaration of `{name}` differs from the previous declaration\n  \
                     previous: {was}\n  now:      {now}"
                ),
            );
        }
        let ty = compose(prior.ty, new);
        self.linked_entities
            .insert(key, LinkedEntity { ty, ..prior });
        Ok(())
    }

    /// What the declarations of `idx`'s identifier with linkage gave it.
    fn linked(&self, idx: usize) -> Option<&LinkedEntity> {
        self.linked_entities.get(self.symbols[idx].name.as_str())
    }

    fn function_verdict(
        &self,
        (ra, pa): (Spelled, &Params),
        (rb, pb): (Spelled, &Params),
    ) -> Verdict {
        // C17 6.7.6.3p5: a function returns the unqualified version of its
        // declared type, which gcc applies in every mode.
        let ret = |s: Spelled| unqualified_version_ty(self.spelled_ty(s));
        if !self.tags_agree(ret(ra), ret(rb), false) {
            return Verdict::Conflict;
        }
        self.params_verdict(pa, pb)
    }

    /// C99 6.7.5.3p15.
    fn params_verdict(&self, prior: &Params, new: &Params) -> Verdict {
        use Params::{IdentifierList, Prototype, Unspecified};
        let value = |s: &Spelled| strip_object_const(self.spelled_ty(*s));
        let agree = |a: &Spelled, b: &Spelled| self.tags_agree(value(a), value(b), false);
        let verdict = |ok: bool| {
            if ok {
                Verdict::Compatible
            } else {
                Verdict::Conflict
            }
        };
        match (prior, new) {
            (Prototype(a, va, fa), Prototype(b, vb, fb)) => verdict(
                va == vb
                    && a.len() == b.len()
                    && a.iter().zip(b).all(|(x, y)| agree(x, y))
                    && self.param_sigs_agree(fa, fb),
            ),
            (Prototype(t, v, _), Unspecified) | (Unspecified, Prototype(t, v, _)) => {
                verdict(!*v && t.iter().all(|p| promoted(value(p)) == value(p)))
            }
            (Prototype(p, v, _), IdentifierList(k)) | (IdentifierList(k), Prototype(p, v, _)) => {
                if *v || p.len() != k.len() {
                    return Verdict::Conflict;
                }
                let ahead = matches!(prior, Prototype(..));
                p.iter().zip(k).fold(Verdict::Compatible, |acc, (pt, kt)| {
                    if acc == Verdict::Conflict
                        || self.tags_agree(value(pt), promoted(value(kt)), false)
                    {
                        acc
                    } else if ahead && agree(pt, kt) {
                        // GNU: a prototype ahead of the definition names the
                        // type before the promotion.
                        Verdict::Extension
                    } else {
                        Verdict::Conflict
                    }
                })
            }
            _ => Verdict::Compatible,
        }
    }

    /// The function types two types lead to are compatible (C99 6.7.5.3p15)
    /// at the same pointer level; a declaration that recorded none agrees.
    fn sigs_agree(&self, a: &FnSig, b: &FnSig) -> bool {
        match (a, b) {
            (Some((fa, da)), Some((fb, db))) => da == db && self.fn_types_agree(fa, fb),
            _ => true,
        }
    }

    /// The parameters at the same positions lead to compatible function
    /// types, and the same ones lead to one.
    fn param_sigs_agree(&self, a: &[(usize, FnType, i64)], b: &[(usize, FnType, i64)]) -> bool {
        let at = |list: &[(usize, FnType, i64)], pos| {
            list.iter()
                .find(|(p, ..)| *p == pos)
                .map(|(_, f, d)| (f.clone(), *d))
        };
        let positions = a.iter().chain(b).map(|&(p, ..)| p);
        positions.into_iter().all(|p| match (at(a, p), at(b, p)) {
            (Some(x), Some(y)) => self.sigs_agree(&Some(x), &Some(y)),
            _ => false,
        })
    }

    /// C99 6.7.5.3p15 over the parts of two function types their tags leave
    /// out, the calling convention included; with no prototype on either
    /// side the parameters are not compared.
    fn fn_types_agree(&self, a: &FnType, b: &FnType) -> bool {
        let value = |t: i64| strip_object_const(t);
        let (pa, pb) = (&a.params, &b.params);
        let params = !pa.prototyped
            || !pb.prototyped
            || (pa.variadic == pb.variadic
                && pa.types.len() == pb.types.len()
                && (pa.types.iter().zip(&pb.types))
                    .all(|(&x, &y)| self.tags_agree(value(x), value(y), false))
                && self.param_sigs_agree(&pa.fn_types, &pb.fn_types));
        let ret = match (&a.ret, &b.ret) {
            (Some((fa, da)), Some((fb, db))) => da == db && self.fn_types_agree(fa, fb),
            (None, None) => true,
            _ => false,
        };
        params && ret && self.target.abi_row(a.conv) == self.target.abi_row(b.conv)
    }

    /// C99 6.2.7p1 over two tags; the type's own qualifiers take part when
    /// `own`.
    fn tags_agree(&self, a: i64, b: i64, own: bool) -> bool {
        let (a, b) = if own {
            (a, b)
        } else {
            (unqualified_version_ty(a), unqualified_version_ty(b))
        };
        if a & VOL_LVL_MASK != b & VOL_LVL_MASK {
            return false;
        }
        let (a, b) = (a & !VOLATILE_MASK, b & !VOLATILE_MASK);
        a == b || self.tags_compatible(a, b)
    }

    fn describe(&self, ty: &DeclaredType) -> String {
        let name = |s: &Spelled| format_type(self.spelled_ty(*s), &self.structs);
        match ty {
            DeclaredType::Object(t, bounds, Some((f, depth))) if bounds.is_empty() => {
                fn_type_spelling(self.spelled_ty(*t), f, *depth, &self.structs)
            }
            DeclaredType::Object(t, bounds, _) if bounds.is_empty() => name(t),
            DeclaredType::Object(t, bounds, _) => {
                let dim = |&b: &i64| {
                    if b < 0 {
                        String::from("[]")
                    } else {
                        format!("[{b}]")
                    }
                };
                format!("{} {}", name(t), bounds.iter().map(dim).collect::<String>())
            }
            DeclaredType::Function(ret, Params::Unspecified, ..) => format!("{} ()", name(ret)),
            DeclaredType::Function(ret, Params::IdentifierList(t), ..) => {
                let list: Vec<String> = t.iter().map(name).collect();
                format!(
                    "{} ({}) in an old-style definition",
                    name(ret),
                    list.join(", ")
                )
            }
            DeclaredType::Function(ret, Params::Prototype(t, v, _), ..) => {
                let types: Vec<i64> = t.iter().map(|s| self.spelled_ty(*s)).collect();
                format_signature(self.spelled_ty(*ret), &types, *v, &self.structs)
            }
        }
    }
}
