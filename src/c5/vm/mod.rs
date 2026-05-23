use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::Target;
use super::error::C5Error;
use super::host::Host;
use super::ir::FunctionSsa;
use super::program::Program;

mod ssa;

/// Whether the VM should emit a per-instruction trace to the host's
/// stdout during `run`. Only honoured under the `std` feature; in
/// `no_std` the trace branch is cfg'd out.
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
    pub fn with_host(program: Program, host: H) -> Self {
        // Lift the program to SSA up front -- cheap relative to
        // running the VM and lets `Vm::run` dispatch into the
        // SSA interpreter when `BADC_VM_SSA=1`. Failures here
        // (walker compile errors, etc.) are deferred to `run`
        // because `with_host` doesn't return `Result`.
        let ssa_funcs = super::codegen::ssa_shadow::produce_ssa_funcs(&program, Target::host());
        let binding_names = program
            .dylibs
            .iter()
            .flat_map(|d| d.bindings.iter().map(|b| b.local_name.clone()))
            .collect();
        // Concatenate the TLS block onto the data segment so
        // Op::TlsLea N can resolve to `tls_base + N` and ride the
        // existing data-side access checks. The starting offset is
        // captured before the TLS bytes are appended.
        let mut data = program.data;
        // Apply CodeReloc entries: function-pointer initializers in
        // the data segment store `CODE_BASE + bc_pc` so Op::Jsri
        // recognises the slot's value as a code address. The
        // compiler can't bake this in directly because the VM's
        // CODE_BASE constant lives in this crate; we patch each
        // slot here at VM construction time.
        for r in &program.code_relocs {
            let off = r.data_offset as usize;
            let runtime = (super::CODE_BASE as u64).wrapping_add(r.target_bc_pc);
            data[off..off + 8].copy_from_slice(&runtime.to_le_bytes());
        }
        let tls_base = data.len();
        data.extend_from_slice(&program.tls_data);
        Self {
            data,
            entry_pc: program.entry_pc,
            host,
            trace: Trace::Off,
            args: Vec::new(),
            binding_names,
            track_pointers: false,
            tls_base,
            ssa_funcs,
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

    /// Execute the program. Consumes the VM because `run` mutates `text`
    /// (appending the bootstrap), `data` (staging argv), and the recorded
    /// `static_end`/heap state -- invoking it twice would corrupt those
    /// invariants. Build a fresh `Vm` for each run.
    pub fn run(mut self) -> Result<i64, C5Error> {
        // `with_host` already pre-lifted every function into
        // `ssa_funcs`; surface lift errors here so callers see a
        // clean `Result` boundary instead of a panic at
        // construction time.
        let funcs = self.ssa_funcs.as_ref().map_err(|e| e.clone())?;
        if funcs.is_empty() {
            return Err(C5Error::Runtime("empty program".to_string()));
        }
        #[cfg(feature = "std")]
        if std::env::var("BADC_DUMP_VM_SSA").is_ok() {
            for f in funcs {
                eprintln!(
                    "fn ent_pc={} n_params={} locals={} vstack_slots={}",
                    f.ent_pc, f.n_params, f.locals, f.vstack_slots
                );
                for (b, blk) in f.blocks.iter().enumerate() {
                    eprintln!(
                        "  block {b}: insts {:?} term {:?}",
                        blk.inst_range, blk.terminator
                    );
                    for v in blk.inst_range.clone() {
                        eprintln!("    v{v}: {:?}", f.insts[v as usize]);
                    }
                }
            }
        }
        ssa::run_program_with_args_tracked(
            funcs,
            &self.data,
            &self.binding_names,
            self.tls_base,
            self.entry_pc,
            &mut self.host,
            &self.args,
            self.track_pointers,
        )
    }
}
