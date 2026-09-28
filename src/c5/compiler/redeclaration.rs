//! Declarations of an identifier with linkage: C99 6.7p4 and 6.2.7p2 require
//! compatible types and 6.9p3 one function body. The composite type (6.2.7p3)
//! is kept per identifier, across block and file scope.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use super::super::diag::Code;
use super::super::error::C5Error;
use super::super::token::Ty;
use super::Compiler;
use super::function::{ParamForm, ParsedParams};
use super::types::{
    VOLATILE_BIT, VOLATILE_INNER_BIT, VOLATILE_MASK, format_signature, format_type,
    is_const_object_ty, is_void_ty, rebase_placeholder_int, strip_object_const, strip_unsigned,
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

/// A function type's parameter information (C99 6.7.5.3p14), by [`ParamForm`].
#[derive(Clone, Debug)]
pub(super) enum Params {
    Unspecified,
    Prototype(Vec<Spelled>, bool),
    IdentifierList(Vec<Spelled>),
}

impl Params {
    pub(super) fn of(params: &ParsedParams, defining: bool) -> Self {
        let types = params.spelled();
        match params.form {
            ParamForm::Empty if !defining => Params::Unspecified,
            ParamForm::Empty | ParamForm::IdentifierList => Params::IdentifierList(types),
            ParamForm::Prototype => Params::Prototype(types, params.is_variadic),
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
/// type and bounds (outermost first, `-1` unspecified), or a function's.
#[derive(Clone, Debug)]
pub(super) enum DeclaredType {
    Object(Spelled, Vec<i64>),
    Function(Spelled, Params),
}

/// What a function definition adds to its type: its line and its GNU forms.
pub(super) struct Definition {
    pub(super) ret: Spelled,
    pub(super) line: usize,
    pub(super) implicit_int: bool,
    pub(super) extern_inline: bool,
}

/// Composite type, first declaration, and body position with its `extern inline`.
pub(super) struct LinkedEntity {
    ty: DeclaredType,
    at: (usize, u16),
    body: Option<((usize, u16), bool)>,
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

/// A tag qualified `volatile` at its outermost derivation does not record
/// whether an inner one is too, so only what both tags record is compared.
fn volatile_agrees(a: i64, b: i64, own: bool) -> bool {
    let outer = |t: i64| t & VOLATILE_BIT != 0 && t & VOLATILE_INNER_BIT == 0;
    if own && outer(a) != outer(b) {
        return false;
    }
    outer(a) || outer(b) || (a & VOLATILE_INNER_BIT) == (b & VOLATILE_INNER_BIT)
}

fn compose(prior: DeclaredType, new: DeclaredType) -> DeclaredType {
    match (prior, new) {
        (DeclaredType::Object(ty, a), DeclaredType::Object(_, b)) => {
            let bounds = a.iter().zip(&b).map(|(&x, &y)| if x < 0 { y } else { x });
            DeclaredType::Object(ty, bounds.collect())
        }
        (DeclaredType::Function(ret, p), DeclaredType::Function(_, q)) if q.rank() > p.rank() => {
            DeclaredType::Function(ret, q)
        }
        (prior, _) => prior,
    }
}

impl Compiler {
    /// Check a declaration of `idx` against the earlier ones and fold it in.
    pub(super) fn declare_linked(
        &mut self,
        idx: usize,
        new: DeclaredType,
        line: usize,
    ) -> Result<(), C5Error> {
        self.fold_linked(idx, new, line, false)
    }

    /// A function definition: its type, then the one body 6.9p3 and 6.9p5 admit;
    /// a GNU `extern inline` body serves inlining and yields to a later one.
    pub(super) fn define_linked_function(
        &mut self,
        idx: usize,
        def: Definition,
        params: Params,
    ) -> Result<(), C5Error> {
        let new = DeclaredType::Function(def.ret, params);
        self.fold_linked(idx, new, def.line, def.implicit_int)?;
        // GNU: the implicit `int` keeps the declared return type.
        if def.implicit_int
            && let Some(LinkedEntity {
                ty: DeclaredType::Function(ret, _),
                ..
            }) = self.linked_entities.get(&idx)
        {
            let ret = self.resolve_spelling(*ret);
            self.symbols[idx].type_ = ret.ty;
            self.symbols[idx].incomplete_enum_tag = ret.enum_tag;
        }
        let at = (def.line, self.intern_source_file());
        let prior = self
            .linked_entities
            .get_mut(&idx)
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
        match self.linked_entities.get(&idx).map(|e| &e.ty) {
            Some(DeclaredType::Function(_, Params::Prototype(t, false)))
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
                self.linked_entities.get(&idx).map(|e| &e.ty),
                Some(DeclaredType::Function(_, Params::Prototype(..)))
            )
    }

    /// An initializer fixed an unspecified array bound (C99 6.7.8p22).
    pub(super) fn complete_linked_bound(&mut self, idx: usize) {
        let count = match self.symbols[idx].array_dims.as_slice() {
            [outer, _, ..] => *outer,
            _ => self.symbols[idx].array_size,
        };
        if let Some(LinkedEntity {
            ty: DeclaredType::Object(_, bounds),
            ..
        }) = self.linked_entities.get_mut(&idx)
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
    /// definition took `int` and keeps the tag; once the definition fixes
    /// the type, the spelling reads it and drops the tag.
    pub(super) fn resolve_spelling(&self, s: Spelled) -> Spelled {
        let underlying = s
            .enum_tag
            .and_then(|tag| self.enum_tag_underlying(&self.symbols[tag as usize].name));
        match underlying {
            Some(underlying) => Spelled::plain(rebase_placeholder_int(s.ty, underlying)),
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
    ) -> Result<(), C5Error> {
        let at = (line, self.intern_source_file());
        let Some(prior) = self.linked_entities.remove(&idx) else {
            let entity = LinkedEntity {
                ty: new,
                at,
                body: None,
            };
            self.linked_entities.insert(idx, entity);
            return Ok(());
        };
        let verdict = match (&prior.ty, &new) {
            (DeclaredType::Object(ta, da), DeclaredType::Object(tb, db)) => {
                let bounds = da.len() == db.len()
                    && da.iter().zip(db).all(|(&x, &y)| x < 0 || y < 0 || x == y);
                if bounds && self.tags_agree(self.spelled_ty(*ta), self.spelled_ty(*tb), true) {
                    Verdict::Compatible
                } else {
                    Verdict::Conflict
                }
            }
            (DeclaredType::Function(ra, pa), DeclaredType::Function(rb, pb)) => {
                // GNU: an implicit `int` definition of a function declared `void`.
                let gnu_void = implicit_int && is_void_ty(ra.ty);
                let rb = if gnu_void { *ra } else { *rb };
                match self.function_verdict((*ra, pa), (rb, pb)) {
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
                return Err(self.compile_err_at(
                    Code::INVALID_DECLARATION,
                    line,
                    format!(
                        "conflicting types for `{name}`\n  previous: {was} ({file}:{prior_line})\n  \
                         now:      {now}"
                    ),
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
            .insert(idx, LinkedEntity { ty, ..prior });
        Ok(())
    }

    fn function_verdict(
        &self,
        (ra, pa): (Spelled, &Params),
        (rb, pb): (Spelled, &Params),
    ) -> Verdict {
        let (ra, rb) = (self.spelled_ty(ra), self.spelled_ty(rb));
        if !self.tags_agree(strip_object_const(ra), strip_object_const(rb), false) {
            return Verdict::Conflict;
        }
        match self.params_verdict(pa, pb) {
            // C17 6.7.6.3p5 drops a return type's qualifiers; C99 6.7.3p9 does not.
            Verdict::Compatible if is_const_object_ty(ra) != is_const_object_ty(rb) => {
                Verdict::Extension
            }
            v => v,
        }
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
            (Prototype(a, va), Prototype(b, vb)) => {
                verdict(va == vb && a.len() == b.len() && a.iter().zip(b).all(|(x, y)| agree(x, y)))
            }
            (Prototype(t, v), Unspecified) | (Unspecified, Prototype(t, v)) => {
                verdict(!*v && t.iter().all(|p| promoted(value(p)) == value(p)))
            }
            (Prototype(p, v), IdentifierList(k)) | (IdentifierList(k), Prototype(p, v)) => {
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

    /// C99 6.2.7p1 over two tags.
    fn tags_agree(&self, a: i64, b: i64, own: bool) -> bool {
        if !volatile_agrees(a, b, own) {
            return false;
        }
        let (a, b) = (a & !VOLATILE_MASK, b & !VOLATILE_MASK);
        a == b
            || self.tags_compatible(a, b)
            || self.is_row_pointer(a, b)
            || self.is_row_pointer(b, a)
    }

    /// `T a[][N]` as a parameter keeps only the element pointer in its tag.
    fn is_row_pointer(&self, row: i64, flat: i64) -> bool {
        self.ptr_array_id_depth1(row).is_some_and(|id| {
            (self.structs[id].fields[0].ty & !VOLATILE_MASK) + Ty::Ptr as i64 == flat
        })
    }

    fn describe(&self, ty: &DeclaredType) -> String {
        let name = |s: &Spelled| format_type(self.spelled_ty(*s), &self.structs);
        match ty {
            DeclaredType::Object(t, bounds) if bounds.is_empty() => name(t),
            DeclaredType::Object(t, bounds) => {
                let dim = |&b: &i64| {
                    if b < 0 {
                        String::from("[]")
                    } else {
                        format!("[{b}]")
                    }
                };
                format!("{} {}", name(t), bounds.iter().map(dim).collect::<String>())
            }
            DeclaredType::Function(ret, Params::Unspecified) => format!("{} ()", name(ret)),
            DeclaredType::Function(ret, Params::IdentifierList(t)) => {
                let list: Vec<String> = t.iter().map(name).collect();
                format!(
                    "{} ({}) in an old-style definition",
                    name(ret),
                    list.join(", ")
                )
            }
            DeclaredType::Function(ret, Params::Prototype(t, v)) => {
                let types: Vec<i64> = t.iter().map(|s| self.spelled_ty(*s)).collect();
                format_signature(self.spelled_ty(*ret), &types, *v, &self.structs)
            }
        }
    }
}
