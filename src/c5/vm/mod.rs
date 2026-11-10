use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::error::C5Error;
use super::host::Host;
use super::ir::FunctionSsa;
use super::program::Program;

pub(crate) mod eval;
mod fenv;
mod link;
mod ssa;

/// Whether the VM prints each SSA instruction it executes to stderr --
/// the function, the block and the instruction -- during `run`. Only
/// honored under the `std` feature.
///
/// Replaces what used to be a bare `bool` parameter to `Vm::new` --
/// `Vm::new(prog, true)` left the reader guessing what the second
/// argument toggled.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum Trace {
    #[default]
    Off,
    On,
}

/// Virtual machine that executes a [`Program`]. The interpreter
/// walks the per-function [`FunctionSsa`] lift produced by
/// `produce_ssa_funcs`; `data` carries the program's static
/// segment + the concatenated TLS block; `host` plumbs IO and
/// libdl through the [`Host`] trait.
pub struct Vm<H: Host> {
    pub(crate) data: Vec<u8>,
    /// The stdio block in `data`.
    stdio: usize,
    entry_pc: usize,
    host: H,
    #[cfg_attr(not(feature = "std"), allow(dead_code))]
    trace: Trace,
    /// Arguments passed to `main(int argc, char **argv)`. Empty by default;
    /// populated via [`Vm::with_args`].
    args: Vec<String>,
    /// Flat list of `local_name`s in `#pragma binding(...)` declaration
    /// order -- the same enumeration the parser used when assigning
    /// each `Inst::CallExt`'s `binding_idx`. The SSA interpreter
    /// resolves a binding by index into this list.
    binding_names: Vec<String>,
    /// When true, every heap-side load / store / bulk-copy goes
    /// through the SSA-VM's allocations check; `free` validates
    /// its argument. Set by [`Vm::with_pointer_tracking`].
    track_pointers: bool,
    /// Base address (within `data`) of the thread-local block.
    /// `Inst::TlsAddr N` resolves to `tls_base + N`. The VM is
    /// single-threaded, so the per-thread isolation native
    /// targets get from `TPIDR_EL0` / `fs:0` isn't reproduced
    /// here -- TLS just behaves like a regular global.
    tls_base: usize,
    /// Pre-lifted SSA functions, populated by `with_host` so
    /// `Vm::run` can dispatch into the interpreter. Lift failures
    /// (walker compile errors, etc.) are deferred to `run`
    /// because `with_host` doesn't return `Result`.
    ssa_funcs: Result<Vec<FunctionSsa>, C5Error>,
    /// Constructor entry pcs (`__attribute__((constructor))`), ordered as
    /// they run before the entry: prioritized ascending, then
    /// unprioritized. The native path runs these through `.init_array`;
    /// the VM calls them itself before `main`.
    init_pcs: Vec<usize>,
    /// Destructor entry pcs, in the same order; the VM runs them in
    /// reverse after the entry returns (a direct `exit()` bypasses them,
    /// as the VM has no atexit chain).
    fini_pcs: Vec<usize>,
    /// The target the program was compiled for, whose assembler syntax
    /// the inline asm templates are written in.
    target: super::codegen::Target,
}

/// The link step for the interpreter's own C library: a call to a function
/// the unit declares, neither defines nor binds, and `ssa::interp_supplies`
/// names becomes the `CallExt` a binding would have made, its name appended
/// to `binding_names`. Taking such a function's address stays undefined.
fn bind_interpreter_library(
    program: &Program,
    funcs: &mut [FunctionSsa],
    weak_fn_pcs: &alloc::collections::BTreeSet<usize>,
    binding_names: &mut Vec<String>,
) {
    use super::ir::Inst;
    let mut index = |name: &str| -> i64 {
        let i = match binding_names.iter().position(|n| n == name) {
            Some(i) => i,
            None => {
                binding_names.push(name.to_string());
                binding_names.len() - 1
            }
        };
        i as i64
    };
    let placeholders: alloc::collections::BTreeMap<usize, String> = (program
        .extern_function_imports)
        .iter()
        .filter(|(pc, name)| !weak_fn_pcs.contains(pc) && ssa::interp_supplies(name))
        .map(|(pc, name)| (*pc, name.clone()))
        .collect();
    let to_call_ext = |inst: &mut Inst, binding_idx: i64| {
        if let Inst::Call {
            args,
            fp_arg_mask,
            low_word_args,
            arg_widths,
            fp_return,
            arg_aggs,
            ret_agg,
            ret_slot_local,
            ..
        } = inst
        {
            *inst = Inst::CallExt {
                binding_idx,
                args: core::mem::take(args),
                fp_arg_mask: core::mem::take(fp_arg_mask),
                low_word_args: *low_word_args,
                arg_widths: core::mem::take(arg_widths),
                fp_return: *fp_return,
                arg_aggs: core::mem::take(arg_aggs),
                ret_agg: *ret_agg,
                ret_slot_local: *ret_slot_local,
            };
        }
    };
    for f in funcs {
        for (v, sym) in core::mem::take(&mut f.extern_call_refs) {
            let supplied = program
                .symbols
                .get(sym as usize)
                .filter(|s| !s.defined_here && !s.is_weak && ssa::interp_supplies(&s.name));
            match supplied {
                Some(s) => to_call_ext(&mut f.insts[v as usize], index(&s.name)),
                None => f.extern_call_refs.push((v, sym)),
            }
        }
        for inst in &mut f.insts {
            let name = match inst {
                Inst::Call { target_pc, .. } => placeholders.get(target_pc).cloned(),
                _ => None,
            };
            if let Some(name) = name {
                to_call_ext(inst, index(&name));
            }
        }
    }
}

/// `Vm::new` is only available with the `std` feature; it picks the
/// `StdHost` adapter as the default. In `no_std`, callers must use
/// [`Vm::with_host`] and supply their own host.
#[cfg(feature = "std")]
impl Vm<super::host::StdHost> {
    /// Construct a `Vm` with the default (std-backed) host. Trace is
    /// off by default -- chain [`Vm::with_trace`] to opt in.
    pub fn new(program: Program) -> Self {
        Self::with_host(program, super::host::StdHost::default())
    }
}

impl<H: Host> Vm<H> {
    /// Construct a `Vm` with an explicit `Host`. Required in `no_std`
    /// where there's no default; convenient in `std` for tests that
    /// want to stub IO. Trace defaults to off.
    /// The target's on-demand sources join as [`Vm::with_sources`] joins them.
    pub fn with_host(program: Program, host: H) -> Self {
        #[cfg(feature = "full")]
        {
            let sources = crate::c5::linker::OnDemandSources::new(
                program.target,
                crate::c5::compiler::CompileOptions::default(),
            );
            Self::linked(program, host, Some(&sources))
        }
        #[cfg(not(feature = "full"))]
        Self::linked(program, host, None)
    }

    /// [`Vm::with_host`] joining `sources` as a native link joins them, for
    /// the names the interpreter's own library does not supply.
    #[cfg(feature = "full")]
    pub fn with_sources(
        program: Program,
        host: H,
        sources: &crate::c5::linker::OnDemandSources,
    ) -> Self {
        Self::linked(program, host, Some(sources))
    }

    /// Execution is the link step: lift the program and its members, join them.
    fn linked(program: Program, host: H, sources: link::Sources<'_>) -> Self {
        let target = program.target;
        let linked = link::VmUnit::lift(program).and_then(|unit| {
            let units = link::join_on_demand(unit, sources)?;
            link::link(units)
        });
        let (ssa_funcs, linked) = match linked {
            Ok(mut l) => (Ok(core::mem::take(&mut l.funcs)), l),
            Err(e) => (Err(e), link::Linked::default()),
        };
        Self {
            data: linked.data,
            stdio: linked.stdio,
            entry_pc: linked.entry_pc,
            host,
            trace: Trace::Off,
            args: Vec::new(),
            binding_names: linked.binding_names,
            track_pointers: false,
            tls_base: linked.tls_base,
            ssa_funcs,
            init_pcs: linked.init_pcs,
            fini_pcs: linked.fini_pcs,
            target,
        }
    }

    /// Enable per-instruction trace output. Mirrors
    /// [`Vm::with_pointer_tracking`]: the absence of the call leaves
    /// the feature off, calling once turns it on. There's no `off`
    /// builder -- just don't call this.
    pub fn with_trace(mut self) -> Self {
        self.trace = Trace::On;
        self
    }

    /// Set the argv list seen by `main`. Conventional first entry is the
    /// program name. Builder-style: `Vm::new(p, false).with_args(["x", "y"])`.
    pub fn with_args<I, S>(mut self, args: I) -> Self
    where
        I: IntoIterator<Item = S>,
        S: Into<String>,
    {
        self.args = args.into_iter().map(Into::into).collect();
        self
    }

    /// Enable runtime tracking of heap allocations. With this on, every
    /// load/store into the heap region is checked against the allocation
    /// table and produces a `Runtime` error on use-after-free, double-free,
    /// or out-of-bounds access. Off by default -- the checks add a per-access
    /// linear scan over the allocations list.
    pub fn with_pointer_tracking(mut self) -> Self {
        self.track_pointers = true;
        self
    }

    /// Execute the program. Consumes the VM because `run` moves
    /// `data`, `host`, and the pre-lifted `ssa_funcs` into the
    /// interpreter; the resulting heap state is not retained
    /// on the `Vm` instance, so reusing it would re-run from
    /// the program's static initializers and double-invoke the
    /// host's TLS / atexit hooks. Build a fresh `Vm` for each
    /// run.
    pub fn run(mut self) -> Result<i64, C5Error> {
        // `with_host` already pre-lifted every function into
        // `ssa_funcs`; surface lift errors here so callers see a
        // clean `Result` boundary instead of a panic at
        // construction time.
        let funcs = self.ssa_funcs.as_ref().map_err(|e| e.clone())?;
        if funcs.is_empty() {
            return Err(C5Error::Runtime("empty program".to_string()));
        }
        ssa::run_program_with_args_tracked(
            funcs,
            (&self.data, self.stdio),
            &self.binding_names,
            self.tls_base,
            self.entry_pc,
            &mut self.host,
            &self.args,
            self.track_pointers,
            self.trace == Trace::On,
            &self.init_pcs,
            &self.fini_pcs,
            self.target,
        )
    }
}
