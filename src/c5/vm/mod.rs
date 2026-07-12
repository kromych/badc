use alloc::string::{String, ToString};
use alloc::vec::Vec;

use super::Target;
use super::error::C5Error;
use super::host::Host;
use super::ir::FunctionSsa;
use super::program::Program;

pub(crate) mod eval;
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
    /// Cross-TU placeholder ent_pc -> symbol name for every
    /// declared-but-undefined extern function. `run` refuses any
    /// reference to these, mirroring the linker.
    extern_fn_names: alloc::collections::BTreeMap<usize, String>,
    /// `(name, defined_here)` per parser symbol, indexed by the
    /// sym idx the `FunctionSsa::extern_*_refs` tables carry.
    symbol_defs: Vec<(String, bool)>,
    /// Local names bound to host data (`#pragma binding(data ...)`).
    data_binding_locals: alloc::collections::BTreeSet<String>,
    /// `target_ent_pc` of every static-initializer function
    /// pointer, checked against `extern_fn_names` at `run`.
    code_reloc_pcs: Vec<usize>,
    /// Constructor entry pcs (`__attribute__((constructor))`), ordered as
    /// they run before the entry: prioritized ascending, then
    /// unprioritized. The native path runs these through `.init_array`;
    /// the VM calls them itself before `main`.
    init_pcs: Vec<usize>,
    /// Destructor entry pcs, in the same order; the VM runs them in
    /// reverse after the entry returns (a direct `exit()` bypasses them,
    /// as the VM has no atexit chain).
    fini_pcs: Vec<usize>,
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
        // Lift the program to SSA up front so `Vm::run` can
        // dispatch into the interpreter directly. Failures here
        // (walker compile errors, etc.) are deferred to `run`
        // because `with_host` doesn't return `Result`.
        let ssa_funcs = super::codegen::ssa::shadow::produce_ssa_funcs(&program, Target::host());
        let binding_names = program
            .dylibs
            .iter()
            .flat_map(|d| d.bindings.iter().map(|b| b.local_name.clone()))
            .collect();
        let extern_fn_names = program
            .extern_function_imports
            .iter()
            .map(|(pc, name)| (*pc, name.clone()))
            .collect();
        let symbol_defs = program
            .symbols
            .iter()
            .map(|s| (s.name.clone(), s.defined_here))
            .collect();
        let data_binding_locals = program
            .dylibs
            .iter()
            .flat_map(|d| d.bindings.iter())
            .filter(|b| b.is_data)
            .map(|b| b.local_name.clone())
            .collect();
        let code_reloc_pcs = program
            .code_relocs
            .iter()
            .map(|r| r.target_ent_pc as usize)
            .collect();
        // Constructors / destructors, ordered as the native `.init_array`
        // path runs them: prioritized ascending, then unprioritized (a
        // stable sort keeps source order within a priority).
        let order_init = |dtor: bool| -> Vec<usize> {
            let mut v: Vec<&crate::c5::program::InitFunc> = program
                .init_funcs
                .iter()
                .filter(|f| f.is_destructor == dtor)
                .collect();
            v.sort_by_key(|f| (f.priority.is_none(), f.priority.unwrap_or(0)));
            v.into_iter().map(|f| f.ent_pc).collect()
        };
        let init_pcs = order_init(false);
        let fini_pcs = order_init(true);
        // Concatenate the TLS block onto the data segment so
        // `Inst::TlsAddr` resolutions ride the existing data-side
        // access checks. The starting offset is captured before
        // the TLS bytes are appended.
        let mut data = program.data;
        // Apply CodeReloc entries: a function-pointer initializer in
        // the data segment is patched to `CODE_ADDR_TAG | ent_pc` --
        // the same encoding an `Inst::ImmCode` materializes and a
        // runtime store of a function reference writes -- so a value
        // loaded from the slot compares equal to the function symbol
        // and the indirect-call dispatch recognises it as a code
        // address. The compiler emits a placeholder plus a CodeReloc
        // because the tag constant lives in this crate; we patch each
        // slot here at VM construction time.
        for r in &program.code_relocs {
            let off = r.data_offset as usize;
            let runtime = ssa::CODE_ADDR_TAG as u64 | r.target_ent_pc;
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
            extern_fn_names,
            symbol_defs,
            data_binding_locals,
            code_reloc_pcs,
            init_pcs,
            fini_pcs,
        }
    }

    /// Refuse any reference to a symbol with no definition in
    /// this unit before execution starts, mirroring the linker's
    /// undefined-symbol diagnosis. Without this, a call whose
    /// placeholder pc collides with a real `ent_pc` dispatches to
    /// the wrong function and an extern object reads a zero slot.
    fn check_extern_refs(&self, funcs: &[FunctionSsa]) -> Result<(), C5Error> {
        use super::ir::Inst;
        let undef =
            |name: &str| C5Error::Runtime(alloc::format!("undefined reference to `{name}`"));
        for f in funcs {
            for inst in &f.insts {
                let pc = match inst {
                    Inst::Call { target_pc, .. } => *target_pc,
                    Inst::ImmCode(pc) => *pc,
                    _ => continue,
                };
                if let Some(name) = self.extern_fn_names.get(&pc) {
                    return Err(undef(name));
                }
            }
            // `target_pc == 0` call / code-address sites record the
            // parser sym; the sentinel is ambiguous (the first
            // function's ent_pc is also 0), so consult the symbol.
            for &(_, sym) in f.extern_call_refs.iter().chain(&f.extern_imm_code_refs) {
                if let Some((name, defined)) = self.symbol_defs.get(sym as usize)
                    && !defined
                {
                    return Err(undef(name));
                }
            }
            for &(_, sym) in f.extern_imm_data_refs.iter().chain(&f.extern_tls_refs) {
                let Some((name, defined)) = self.symbol_defs.get(sym as usize) else {
                    continue;
                };
                if *defined {
                    continue;
                }
                if self.data_binding_locals.contains(name) {
                    return Err(C5Error::Runtime(alloc::format!(
                        "`{name}` is bound to host data; the interpreter cannot \
                         reach host memory (use --jit or compile natively)"
                    )));
                }
                return Err(undef(name));
            }
        }
        for pc in &self.code_reloc_pcs {
            if let Some(name) = self.extern_fn_names.get(pc) {
                return Err(undef(name));
            }
        }
        Ok(())
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
    /// the program's static initialisers and double-invoke the
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
        self.check_extern_refs(funcs)?;
        ssa::run_program_with_args_tracked(
            funcs,
            &self.data,
            &self.binding_names,
            self.tls_base,
            self.entry_pc,
            &mut self.host,
            &self.args,
            self.track_pointers,
            &self.init_pcs,
            &self.fini_pcs,
        )
    }
}
