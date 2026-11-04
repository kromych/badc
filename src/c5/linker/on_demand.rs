//! The compiler-runtime and C-library sources a native link offers as its
//! last archive, compiled to programs an in-process run joins to its unit.

use alloc::collections::BTreeSet;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use crate::c5::codegen::Target;
use crate::c5::compiler::{CompileOptions, Compiler};
use crate::c5::error::C5Error;
use crate::c5::program::Program;

/// One source, compiled, with the external names it defines.
pub(crate) struct Member {
    pub(crate) program: Program,
    pub(crate) strong: BTreeSet<String>,
    pub(crate) weak: BTreeSet<String>,
}

/// The on-demand sources for one target, compiled once a run needs them.
pub struct OnDemandSources {
    target: Target,
    options: CompileOptions,
    /// Labels and texts in the native link's order.
    sources: Vec<(String, &'static str)>,
    members: core::cell::OnceCell<Result<Vec<Member>, C5Error>>,
}

impl OnDemandSources {
    /// The sources for `target`, compiled under `options`.
    pub fn new(target: Target, options: CompileOptions) -> Self {
        let sources = (crate::c5::runtime::embedded_compiler_rt().iter())
            .map(|e| ("compiler-rt", e))
            .chain(
                crate::c5::runtime::embedded_libc()
                    .iter()
                    .map(|e| ("libc", e)),
            )
            .map(|(dir, (name, body))| (alloc::format!("<{dir}/{name}>"), *body))
            .collect();
        Self {
            target,
            options,
            sources,
            members: core::cell::OnceCell::new(),
        }
    }

    #[cfg(test)]
    pub(crate) fn of(target: Target, sources: &[(&str, &'static str)]) -> Self {
        Self {
            target,
            options: CompileOptions::default(),
            sources: (sources.iter()).map(|&(l, b)| (l.to_string(), b)).collect(),
            members: core::cell::OnceCell::new(),
        }
    }

    /// The members defining anything for the target.
    pub(crate) fn members(&self) -> Result<&[Member], C5Error> {
        let compiled = self.members.get_or_init(|| self.compile());
        compiled.as_deref().map_err(Clone::clone)
    }

    fn compile(&self) -> Result<Vec<Member>, C5Error> {
        let (target, options) = (self.target, &self.options);
        let compile = |(label, body): &(String, &str)| {
            let options = (options.clone())
                .with_source_label(label.clone())
                .with_no_entry_point(true);
            let program = Compiler::with_options(body.to_string(), target, options).compile()?;
            let (strong, weak) = program.external_definitions();
            Ok(Member {
                program,
                strong,
                weak,
            })
        };
        let members: Vec<Member> = std::thread::scope(|scope| {
            let jobs: Vec<_> = (self.sources.iter())
                .map(|source| scope.spawn(move || compile(source)))
                .collect();
            (jobs.into_iter())
                .map(|job| job.join().unwrap_or_else(|p| std::panic::resume_unwind(p)))
                .collect::<Result<_, C5Error>>()
        })?;
        Ok(members
            .into_iter()
            .filter(|m| !m.strong.is_empty() || !m.weak.is_empty())
            .collect())
    }
}

/// Pull, as a link rescans an archive, each member strongly defining a name
/// in `undefined` until a pass pulls none; `pull(i)` joins member `i` and
/// returns the strong references it leaves undefined.
pub(crate) fn select(
    members: &[Member],
    defined: &mut BTreeSet<String>,
    undefined: &mut BTreeSet<String>,
    mut pull: impl FnMut(usize) -> Result<Vec<String>, C5Error>,
) -> Result<(), C5Error> {
    let mut pulled = alloc::vec![false; members.len()];
    loop {
        let mut progress = false;
        for (i, m) in members.iter().enumerate() {
            if pulled[i] || !m.strong.iter().any(|n| undefined.contains(n)) {
                continue;
            }
            pulled[i] = true;
            progress = true;
            for n in m.strong.iter().chain(&m.weak) {
                undefined.remove(n);
                defined.insert(n.clone());
            }
            for n in pull(i)? {
                if !defined.contains(&n) {
                    undefined.insert(n);
                }
            }
        }
        if !progress {
            return Ok(());
        }
    }
}
