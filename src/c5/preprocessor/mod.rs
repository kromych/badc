//! Preprocessor that runs before the lexer.
//!
//! Line-based: each input line becomes a macro-substituted line of
//! output, or a blank line for a directive or an inactive conditional
//! branch. Line counts are preserved one-for-one -- including the
//! blank fillers emitted for each consumed `\` continuation -- so
//! lexer and parser error messages keep accurate line numbers.
//!
//! Directives:
//!
//! * `#define NAME BODY` / `#define NAME(params) BODY` -- object- and
//!   function-like macros; a body may span lines with a trailing `\`.
//!   Expansion is recursive and cycle-safe. `#undef NAME` removes a
//!   definition. The CLI's `-D NAME` predefines with body `1` and
//!   `-D NAME=` with an empty body (see [`Preprocessor::define`]).
//! * `#ifdef` / `#ifndef` / `#if` / `#elif` / `#else` / `#endif`,
//!   nestable. The `#if` / `#elif` operand is a C integer constant
//!   expression evaluated at 64 bits: `defined(NAME)` / `defined
//!   NAME`, the ternary `?:`, `||`, `&&`, `| ^ &`, `== !=`,
//!   `< > <= >=`, `<< >>`, `+ - * / %`, unary `! ~ - +`, integer and
//!   character constants, and parentheses. An identifier that is not
//!   a macro evaluates to 0 (C99 6.10.1).
//! * `#include <name.h>` / `#include "name.h"` -- resolved through the
//!   filesystem search paths first (a quoted form also searches the
//!   including file's directory), then the embedded-header registry
//!   (see [`super::headers`]). Cyclic `#include` is rejected; a repeat
//!   include is dropped once the header has used `#pragma once`.
//! * `#error MESSAGE` aborts compilation; `#warning MESSAGE` reports a
//!   diagnostic and continues; `#line` (and the GNU `# NN "file"`
//!   marker) adjusts the reported line number and file name.
//!
//! Pragmas:
//!
//! * `#pragma once` -- drop further `#include` of the same header.
//! * `#pragma dylib(name, "path")` -- introduce a logical dylib the
//!   codegen attaches bindings to. `name` is the c5-side handle (e.g.
//!   `libc`); `path` is the loader search name or filesystem path
//!   (`libc.so.6`, `/usr/lib/libSystem.B.dylib`, `msvcrt.dll`).
//! * `#pragma binding(dylib_name::local_name, "real_symbol")` -- bind
//!   the c5-side identifier `local_name` to `real_symbol` exported by
//!   `dylib_name`, so a call to `local_name` lands on that import. The
//!   explicit cross-reference replaced an earlier positional "current
//!   dylib" form so reordering directives cannot rebind a function to
//!   the wrong dylib.
//! * `#pragma pack(push|pop|N)` -- struct field alignment.
//! * `#pragma GCC visibility push(vis)` / `pop` -- ELF visibility for the
//!   declarations in the pragma's extent.
//! * `#pragma intrinsic("name")` -- mark a name (e.g. `alloca`) as a
//!   compiler intrinsic.

use alloc::boxed::Box;
use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::{String, ToString};

use alloc::vec::Vec;
use core::cell::{Cell, RefCell};
use hashbrown::HashMap;

use super::codegen::{CodeModel, ElfClass, Target};
use super::error::C5Error;

/// One declared dylib plus the bindings that target it. Created
/// by `#pragma dylib(name, "path")`; populated by subsequent
/// `#pragma binding(name::c4_fn, "real_symbol")` directives that
/// reference this dylib through its `name`.
#[derive(Debug, Clone)]
pub struct DylibSpec {
    /// c5-side identifier for this dylib (e.g. `libc`, `kernel32`).
    /// Bindings reference it via their `name::c4_fn` left-hand
    /// side, so directive ordering in the header doesn't matter --
    /// a binding can sit anywhere relative to its dylib's
    /// declaration.
    pub name: String,
    /// Path or loader-search name (e.g. `/usr/lib/libSystem.B.dylib`
    /// on macOS, `libc.so.6` on Linux, `msvcrt.dll` on Windows).
    /// The codegen passes this through to the IAT entry / DT_NEEDED
    /// record verbatim.
    ///
    /// Read by tests; the codegen reaches the same path through the
    /// `ResolvedDylib` view it builds during import resolution.
    #[allow(dead_code)]
    pub path: String,
    /// Bindings whose qualifier referenced `Self::name`.
    pub bindings: Vec<Binding>,
}

/// One `#pragma binding(dylib::local_name, "real_symbol")` declaration.
/// Owned by the [`DylibSpec`] whose `name` matched the qualifier.
#[derive(Debug, Clone)]
pub struct Binding {
    /// `true` if the function's prototype ended with `, ...)` --
    /// e.g. `int printf(char *fmt, ...);`. The lowering reads
    /// this to decide whether the call site needs the
    /// platform's variadic-ABI handling (macOS arm64 stack
    /// packing, SysV `xor eax, eax`). Set by the parser when it
    /// folds a Sys symbol's prototype onto the binding; the
    /// preprocessor doesn't know about prototypes so it leaves
    /// this `false`.
    pub is_variadic: bool,
    /// Number of fixed (non-variadic) parameters from the
    /// prototype. macOS arm64 passes those in registers per
    /// standard AAPCS64; only the variadic tail spills to the
    /// stack. Set by the parser alongside `is_variadic`;
    /// meaningful only when `is_variadic == true` (otherwise
    /// the codegen reads the c5 stack directly without the
    /// register/stack split).
    pub fixed_args: usize,
    /// Return type tag (encoded the same way as `Symbol::type_` --
    /// `Ty::Char`/`Ty::Int`/`Ty::Long`/... with the unsigned bit
    /// optionally OR'd in). Set by the parser when the prototype
    /// is folded onto the binding. The codegen reads it after a
    /// libc call to decide whether the return needs sign- or
    /// zero-extension into the c5 accumulator -- msvcrt's int
    /// returns leave the upper 32 bits of RAX undefined per the
    /// Win64 ABI, so a downstream 64-bit comparison sees garbage
    /// without an explicit extension. `0` (= `Ty::Char`) when
    /// the prototype hasn't been seen yet; the codegen treats
    /// that as "no extension needed".
    pub return_type_tag: i64,
    /// True when the prototype's return type was spelled `long
    /// double`. The encoded `return_type_tag` is still
    /// `Ty::Double` (c5 stores both as f64), but the libc-call
    /// codegen needs this flag to read the result out of x87
    /// `st(0)` on SysV x86_64 instead of XMM0. False for plain
    /// `double` returns and for everything that isn't a floating
    /// scalar.
    pub returns_long_double: bool,
    /// Per-fixed-parameter type tags from the prototype (same
    /// encoding as `return_type_tag`). Captured by the parser at
    /// the same fold-site that fills `fixed_args` / `is_variadic`,
    /// then carried into `ResolvedImport` so the DWARF emitter
    /// can give each PLT trampoline a `DW_TAG_subprogram` with
    /// `DW_TAG_formal_parameter` children typed accurately
    /// Empty when the parser hasn't seen the prototype.
    pub param_types: Vec<i64>,
    /// c5-side name the source uses (e.g. `printf`).
    pub local_name: String,
    /// Symbol name exported by the dylib. Differs from `local_name`
    /// on macOS (leading `_`) and for Windows aliases like
    /// `mprotect` -> `VirtualProtect`.
    ///
    /// Read by tests; the codegen consumes the same string through
    /// the `ResolvedImport` view it builds during import resolution.
    #[allow(dead_code)]
    pub real_symbol: String,
    /// `true` when the binding names a data object rather than a
    /// callable function -- the `#pragma binding(data <lib>::<name>,
    /// "...")` form. A data import resolves to a COPY relocation that
    /// binds the host's data symbol into the image, not a PLT/GOT call
    /// slot.
    pub is_data: bool,
}

/// One function-like macro entry: parameter list + body. Object-like
/// macros are stored separately in `macros` as plain strings.
#[derive(Debug, Clone, PartialEq)]
struct FnMacro {
    /// Named parameters in source order, *not* including the `...` of
    /// a variadic macro -- variadics are flagged by `is_variadic` and
    /// the trailing arguments accessed through `__VA_ARGS__`.
    params: Vec<String>,
    body: String,
    /// `true` for `#define foo(a, ...)` -- any extra arguments are
    /// joined with `, ` and substituted for `__VA_ARGS__` in the body.
    is_variadic: bool,
    /// The variadic-tail name for the GCC named-rest form
    /// `#define foo(a, rest...)`: `Some("rest")`. The body reaches the
    /// trailing arguments through this name in addition to
    /// `__VA_ARGS__`. `None` for the standard `...` form.
    va_name: Option<String>,
}

/// Output of a successful preprocessor run: the substituted source
/// for the lexer plus the side data the codegen will pick up later.
pub(crate) struct Preprocessor {
    // Hash maps rather than BTreeMaps because the preprocessor probes
    // `macros` once per source identifier -- a tree walk's log-N
    // string-prefix compares were the leftover frontend hot spot
    // after the symbol-table fix went in.
    macros: HashMap<String, String>,
    /// Compilation target; Windows include resolution is
    /// case-insensitive, matching its filesystems.
    target: Target,
    /// The `wchar_t` in force for this unit, tracking `-fshort-wchar`
    /// through [`Self::set_unit_model`]. `#if` types an `L'...'`
    /// constant by it, and the `__WCHAR_*__` predefines report it.
    pub(super) wchar: crate::c5::codegen::WcharType,
    /// Whether plain `char` is signed in this unit, tracking
    /// `-fsigned-char` / `-funsigned-char` through
    /// [`Self::set_plain_char_signed`]. `#if` sign-extends a character
    /// constant by it, and `__CHAR_UNSIGNED__` reports it.
    pub(super) char_signed: bool,
    fn_macros: HashMap<String, FnMacro>,
    /// One entry per `#pragma dylib(name, "path")`, in the order
    /// declared. Each entry collects the bindings whose
    /// `name::c4_fn` qualifier referenced its [`DylibSpec::name`].
    pub dylibs: Vec<DylibSpec>,
    /// Index of `dylibs` by [`DylibSpec::name`]. Every `#pragma
    /// binding` looks its dylib up here; `parse_pragma_dylib` is the
    /// only site that appends to either.
    dylib_index: HashMap<String, usize>,
    /// One entry per `#pragma export(<name>)` directive, in
    /// declaration order. The compiler validates each name
    /// resolves to a function defined in this translation
    /// unit and threads the list onto `Program::exports`; the
    /// shared-object writers (Mach-O dylib, ELF .so, PE DLL)
    /// promote those symbols to externally visible entries
    /// in the symbol / export tables. Names not produced by
    /// `#pragma export(...)` keep file-scope-static linkage
    /// (the c5 default).
    pub exports: Vec<String>,
    /// Membership half of `exports`, which keeps its declaration order
    /// because the export tables are written in it.
    export_names: BTreeSet<String>,
    /// Headers that opted in to single-inclusion via `#pragma once`.
    /// A subsequent `#include` of a name in this set is dropped.
    pragma_once_files: BTreeSet<String>,
    /// Controlling macro of each processed file whose whole content sits
    /// inside one `#ifndef X` / `#endif` pair. While `X` is defined such
    /// a file contributes nothing, so a repeat `#include` of that path is
    /// dropped instead of being read and scanned again (C99 6.10.2; the
    /// same optimization gcc and clang apply).
    include_guards: HashMap<String, String>,
    /// Headers currently being expanded: the include spelling plus
    /// whether the body came from the compiler's own header set (the
    /// embedded registry or an own-header root) rather than a search
    /// path. Pushed on `#include`, popped when the header finishes.
    /// The flag drives the closed-set resolution rule in
    /// `find_include`: only a file actually served from the own set
    /// resolves its includes there first, so a foreign header whose
    /// spelling collides with a bundled name keeps `-I` order.
    include_stack: Vec<(String, bool)>,
    /// Filesystem search paths for `#include`. Probed in order
    /// before falling back to the bundled in-binary headers, so
    /// an on-disk copy of a bundled header overrides it without
    /// rebuilding badc. Plumbed in from the CLI's `-I path` flag
    /// and the driver's overlays (the source tree's
    /// `libc/include`, `$BADC_HOME/include`). Filesystem reads are
    /// gated behind `cfg(feature = "std")`; the no_std build
    /// keeps the field but never reads from it (the embedded
    /// headers are always available).
    search_paths: SearchPaths,
    /// On-disk copies of the compiler's own header set, probed by name
    /// ahead of the in-binary bodies. See `add_own_header_root`.
    own_header_roots: SearchPaths,
    /// Directories probed for `#include "..."` only (the gcc `-iquote`
    /// scope), after the including file's directory and before
    /// `search_paths`. An angle include never reads them.
    quote_search_paths: SearchPaths,
    /// System header directories probed only *after* the bundled
    /// in-binary headers, so a third-party header the embedded set
    /// lacks (`zlib.h`, `libfdt.h`) resolves against the host system
    /// while a standard header (`stdlib.h`, `stdio.h`) still comes from
    /// the embedded set -- the embedded copy carries the `#pragma
    /// binding` metadata the system copy does not, and the system copy
    /// may use constructs the dialect does not parse. Populated for a
    /// hosted native build (the driver's implicit system include path,
    /// as a compiler driver adds `/usr/include`); a cross build or a
    /// `--freestanding` / `--nostdinc` build leaves it empty.
    system_fallback_paths: SearchPaths,
    /// `-nostdinc`: withdraw the standard library headers from
    /// `#include` resolution. The bundled set and `system_fallback_paths`
    /// leave the search, so a name no `-I` / `-iquote` path carries is an
    /// error instead of resolving to badc's own libc. The compiler-owned
    /// headers ([`crate::c5::headers::COMPILER_OWNED_HEADERS`]) stay, as
    /// gcc's builtins do.
    nostdinc: bool,
    /// `-fno-builtin`: `#pragma intrinsic(name)` registers nothing, so a
    /// call spelled with the library name lowers as a call rather than as
    /// the instruction badc has for it.
    no_builtin: bool,
    /// Headers to splice in front of the user's translation unit,
    /// before any source line is preprocessed. Mirrors gcc /
    /// clang's `-include FILE` flag: each name resolves through
    /// the same search-path / embedded-header chain as a regular
    /// `#include "name"` and is processed exactly as if the user
    /// had written that directive at the top of their source.
    /// Plumbed in from the CLI's `-include FILE` flag.
    force_includes: Vec<String>,
    /// Filename label used for the top-level translation unit's
    /// `#line 1 "..."` marker. Defaults to `"<source>"` -- the CLI
    /// overrides it with the real argv path so error / warning
    /// messages report `./hello.c:5: error: ...` instead of the
    /// `<source>:5: ...` placeholder. The DWARF emitter still
    /// uses `Program::source_path` separately; this is purely the
    /// preprocessor / lexer / diagnostics view.
    source_label: String,
    /// Diagnostics accumulated during preprocessing. Drained into
    /// `Compiler::warnings` so a single `Program::warnings` list
    /// surfaces every `<file>:<line>: warning: ...` line the
    /// front end produced -- preprocessor and parser alike. Mirrors
    /// gcc / clang shape so editors' jump-to-error works out of
    /// the box.
    pub warnings: Vec<String>,
    /// Include resolutions in directive order. Populated only when
    /// [`Self::set_track_includes`] is on. Renders the gcc `-H` trace
    /// (via [`IncludeRecord::trace_line`]) and supplies the `-M`
    /// family's prerequisite list, so both read one list.
    pub include_records: Vec<IncludeRecord>,
    /// `true` when the build driver asked for include tracking (`-H`
    /// or a `-M`-family flag). Defaults to `false`; flipping it on
    /// costs one push to `include_records` per `#include` resolve
    /// attempt and nothing else.
    track_includes: bool,
    /// `true` for assembler-with-cpp input (a `.S` unit). A `#` line
    /// whose name is no directive then passes through with its tail
    /// macro-expanded, as GNU cpp does for assembler input; in C such
    /// a line is diagnosed and dropped.
    asm_source: bool,
    /// Source-declared entry-point name (`#pragma entrypoint(<id>)`).
    /// `None` means the default `main` is used; set via
    /// the pragma to opt the translation unit into a non-`main`
    /// entry like `WinMain` (Win32 `--gui`) or a custom `_start`.
    /// The compile pass reads this when resolving `entry_pc`; the
    /// PE writer reads it for the optional-header AddressOfEntryPoint.
    pub entrypoint: Option<String>,
    /// Source-declared Windows subsystem (`#pragma subsystem(<kind>)`).
    /// `None` means the default `console`. Recognised
    /// kinds today: `console` (IMAGE_SUBSYSTEM_WINDOWS_CUI = 3) and
    /// `windows` (IMAGE_SUBSYSTEM_WINDOWS_GUI = 2). The PE writer
    /// reads this to set the optional header's Subsystem field;
    /// non-PE targets keep the field at `None` and ignore it.
    pub subsystem: Option<Subsystem>,
    /// Monotonically-increasing per-translation-unit counter for
    /// the MSVC / GCC `__COUNTER__` predefine. Each expansion
    /// produces the current value as an integer literal and
    /// post-increments, letting macros mint unique identifiers
    /// per call site. Lives in a `Cell` because the substitution
    /// path takes `&self`.
    pub(crate) counter: Cell<i64>,
    /// First macro-expansion diagnostic of a substitution pass (C99
    /// 6.10.3p4 argument/parameter count mismatch). The substitution path
    /// returns a `String`, so the error is parked here and drained by the
    /// Result-returning caller (`process_named`, `eval_condition`).
    pending_error: RefCell<Option<C5Error>>,
    /// Lexed-body cache for the expansion engine, keyed by macro
    /// name and validated against the current body text, so a
    /// redefinition never serves stale tokens.
    body_toks: RefCell<hashbrown::HashMap<String, expand::CachedBody>>,
    /// One-name hidesets by macro name; a top-level invocation's
    /// result set is always `{name}`, shared here across fires.
    hs_singletons: RefCell<hashbrown::HashMap<String, alloc::rc::Rc<expand::Hideset>>>,
    /// Expansion-arena storage reused across lines.
    exp_scratch: RefCell<expand::ExpScratch>,
    /// MSVC-style `#pragma warning(disable : N)` IDs currently
    /// suppressed. Push/pop variants nest via `warning_stack`.
    /// c5 doesn't number its own warnings, so the IDs in here
    /// don't currently filter anything -- but the parse is real
    /// (typos raise a warning) and tests can read this set, which
    /// gives visibility into what the source asked to silence.
    pub(crate) warning_disabled: BTreeSet<u32>,
    /// Stack of `warning_disabled` snapshots taken at each
    /// `#pragma warning(push)`; popped by `#pragma warning(pop)`.
    pub(crate) warning_stack: Vec<BTreeSet<u32>>,
    /// Borland / Watcom-style `#pragma warn -<code>` requests.
    /// Holds the 3-letter (or longer) code strings that the source
    /// asked to disable -- the `-` form. Like `warning_disabled`
    /// above, c5 doesn't currently filter against these but the
    /// parse is real (so typos surface) and the recorded set is
    /// visible for future per-code filtering.
    pub(crate) warn_disabled: BTreeSet<alloc::string::String>,
    /// `#pragma intrinsic("name")` declarations -- a map from
    /// callable identifier to the `Intrinsic` discriminant the
    /// frontend should stamp on the matching `Symbol::intrinsic`
    /// at declaration time. Today's surface is small (`alloca`
    /// / `__builtin_alloca`); future atomics / cpuid / vector
    /// builtins plug in by adding a new `Intrinsic` enum
    /// variant in `op.rs` and a one-line entry in
    /// [`Self::parse_pragma_intrinsic`].
    pub intrinsics: alloc::collections::BTreeMap<String, i64>,
    /// Recording state for the source pass of a compile that may retry
    /// with an extended force-include list; see [`Self::process_recording`].
    /// `None` outside that pass.
    reuse: Option<Box<ReuseRecorder>>,
}

/// Insertion-ordered set of directories. `#include` probes them in
/// order, so the sequence is part of the resolution rule; the set half
/// keeps a repeated `-I` out without scanning what is already there.
#[derive(Default)]
pub(crate) struct SearchPaths {
    order: Vec<String>,
    seen: BTreeSet<String>,
}

impl SearchPaths {
    fn add(&mut self, path: &str) {
        if !self.seen.contains(path) {
            self.seen.insert(path.to_string());
            self.order.push(path.to_string());
        }
    }

    #[cfg(feature = "std")]
    pub(super) fn iter(&self) -> impl Iterator<Item = &String> {
        self.order.iter()
    }
}

/// Identifier-membership filter for the pass-reuse check. A bit set
/// keyed on a fixed hash, safe in one direction: a hit may be a false
/// positive (the retry then falls back to a full run), a miss is exact.
/// `Cell` bits, since the expansion sites record through `&Preprocessor`.
pub(crate) struct ObsFilter {
    mask: usize,
    bits: alloc::boxed::Box<[Cell<u64>]>,
}

impl ObsFilter {
    /// One bit per source byte keeps distinct identifiers sparse;
    /// clamped so tiny units stay accurate and huge ones stay cheap.
    fn sized_for(source_len: usize) -> Self {
        let bits = source_len.next_power_of_two().clamp(1 << 17, 1 << 24);
        ObsFilter {
            mask: bits - 1,
            bits: alloc::vec![Cell::new(0u64); bits / 64].into_boxed_slice(),
        }
    }

    #[inline]
    fn probes(&self, h: u64) -> [usize; 2] {
        [h as usize & self.mask, (h >> 32) as usize & self.mask]
    }

    #[inline]
    fn set(&self, h: u64) {
        for i in self.probes(h) {
            let w = &self.bits[i / 64];
            w.set(w.get() | 1u64 << (i % 64));
        }
    }

    #[inline]
    fn hit(&self, h: u64) -> bool {
        self.probes(h)
            .into_iter()
            .all(|i| self.bits[i / 64].get() & (1u64 << (i % 64)) != 0)
    }
}

/// Eight-bytes-at-a-time multiplicative hash with a mixing finalizer,
/// so both probe indices draw on well-spread bits. The filter must
/// hash identically in the recording run and the retry run, so the
/// macro map's per-instance-seeded hasher cannot key it; this runs
/// once per identifier occurrence, hence the chunked walk.
#[inline]
fn obs_hash(name: &str) -> u64 {
    const K: u64 = 0x517c_c1b7_2722_0a95;
    let bytes = name.as_bytes();
    let mut h = bytes.len() as u64;
    let (chunks, remainder) = bytes.as_chunks::<8>();
    for c in chunks {
        h = (h.rotate_left(5) ^ u64::from_le_bytes(*c)).wrapping_mul(K);
    }
    let mut tail = 0u64;
    for &b in remainder {
        tail = tail << 8 | b as u64;
    }
    h = (h.rotate_left(5) ^ tail).wrapping_mul(K);
    h ^= h >> 33;
    h = h.wrapping_mul(0xff51_afd7_ed55_8ccd);
    h ^ (h >> 33)
}

/// Live recording for the source pass; drained into [`PpReuse`].
struct ReuseRecorder {
    /// Names the pass looked up, tested in a conditional, or
    /// defined / undefined.
    filter: ObsFilter,
    /// The pass expanded `__COUNTER__`.
    counter_used: Cell<bool>,
    /// Resolution keys the pass checked against the `#pragma once` /
    /// include-guard registries.
    consulted_includes: BTreeSet<String>,
    /// `#pragma` directives feeding the side outputs the compile
    /// consumes, in source order: (args, line, filename).
    pragma_events: Vec<(String, usize, String)>,
}

/// One completed run's source pass, reusable by a re-run whose
/// force-include list extends this run's: the state at source entry,
/// what the pass observed of it, and what the pass produced.
pub(crate) struct PpReuse {
    source_text: String,
    macros: HashMap<String, String>,
    fn_macros: HashMap<String, FnMacro>,
    once_files: BTreeSet<String>,
    include_guards: HashMap<String, String>,
    counter: i64,
    warning_disabled: BTreeSet<u32>,
    warning_stack: Vec<BTreeSet<u32>>,
    warn_disabled: BTreeSet<String>,
    filter: ObsFilter,
    counter_used: bool,
    consulted_includes: BTreeSet<String>,
    pragma_events: Vec<(String, usize, String)>,
    warnings: Vec<String>,
    include_records: Vec<IncludeRecord>,
}

// Test hook: how many times the source (as opposed to the preamble or
// a reused pass) has been fully preprocessed on this thread.
#[cfg(any(test, feature = "codegen_test"))]
std::thread_local! {
    pub(crate) static FULL_SOURCE_PASSES: Cell<usize> = const { Cell::new(0) };
}

/// Windows PE subsystem selector; mirrors the `IMAGE_SUBSYSTEM_*`
/// constants from `<winnt.h>`. The PE writer uses this both for
/// the optional-header `Subsystem` field and to pick the entry
/// stub shape:
///
/// * `Console` / `Windows` -- hosted Win32 programs. The writer
///   emits a CRT-flavoured stub that imports
///   `msvcrt!__getmainargs` / `msvcrt!exit` and calls the entry
///   with `(argc, argv)` (console) or the WinMain argument set
///   (windows).
///
/// * `Native` (alias `driver`) -- NT-native usermode programs and
///   kernel-mode drivers. The loader invokes the entry directly
///   with the platform-native signature (`NtProcessStartup(PPEB)`
///   for usermode; `DriverEntry(PDRIVER_OBJECT, PUNICODE_STRING)`
///   for drivers). The PE writer suppresses the stub and points
///   `AddressOfEntryPoint` at the user's entry function.
///
/// * `EfiApplication` / `EfiBootServiceDriver` /
///   `EfiRuntimeDriver` / `EfiRom` -- UEFI binaries. The firmware
///   loader invokes the entry with
///   `(EFI_HANDLE, EFI_SYSTEM_TABLE *)`. Same passthrough
///   handling as `Native`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Subsystem {
    /// `IMAGE_SUBSYSTEM_WINDOWS_CUI` (3) -- console subsystem.
    Console,
    /// `IMAGE_SUBSYSTEM_WINDOWS_GUI` (2) -- windowed subsystem.
    Windows,
    /// `IMAGE_SUBSYSTEM_NATIVE` (1) -- NT-native usermode programs
    /// and kernel-mode drivers (.sys files). `#pragma
    /// subsystem(driver)` is an alias for this variant.
    Native,
    /// `IMAGE_SUBSYSTEM_EFI_APPLICATION` (10).
    EfiApplication,
    /// `IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER` (11).
    EfiBootServiceDriver,
    /// `IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER` (12).
    EfiRuntimeDriver,
    /// `IMAGE_SUBSYSTEM_EFI_ROM` (13).
    EfiRom,
}

/// C99 5.2.4.2.2 floating-point characteristics, in the `__FLT_*` /
/// `__DBL_*` / `__LDBL_*` spellings gcc and clang predefine and that
/// third-party headers test directly. badc's `float` is IEEE binary32
/// and `double` is IEEE binary64 on every target; the `__LDBL_*` row
/// describes the target ABI's `long double` storage format (x87
/// 80-bit on System V x86-64, binary128 on AAPCS64 ELF, binary64
/// elsewhere), values matching gcc's per target. `<float.h>` derives
/// its `FLT_*` / `DBL_*` / `LDBL_*` names from these, which keeps one
/// source of truth.
fn install_float_characteristics(macros: &mut HashMap<String, String>, target: Target) {
    const COMMON: &[(&str, &str)] = &[
        ("__FLT_RADIX__", "2"),
        ("__FLT_MANT_DIG__", "24"),
        ("__FLT_DIG__", "6"),
        ("__FLT_MIN_EXP__", "(-125)"),
        ("__FLT_MIN_10_EXP__", "(-37)"),
        ("__FLT_MAX_EXP__", "128"),
        ("__FLT_MAX_10_EXP__", "38"),
        ("__FLT_DECIMAL_DIG__", "9"),
        ("__FLT_EPSILON__", "1.19209290e-7F"),
        ("__FLT_MIN__", "1.17549435e-38F"),
        ("__FLT_MAX__", "3.40282347e+38F"),
        ("__FLT_NORM_MAX__", "3.40282347e+38F"),
        ("__FLT_DENORM_MIN__", "1.40129846e-45F"),
        ("__DBL_MANT_DIG__", "53"),
        ("__DBL_DIG__", "15"),
        ("__DBL_MIN_EXP__", "(-1021)"),
        ("__DBL_MIN_10_EXP__", "(-307)"),
        ("__DBL_MAX_EXP__", "1024"),
        ("__DBL_MAX_10_EXP__", "308"),
        ("__DBL_DECIMAL_DIG__", "17"),
        ("__DBL_EPSILON__", "2.2204460492503131e-16"),
        ("__DBL_MIN__", "2.2250738585072014e-308"),
        ("__DBL_MAX__", "1.7976931348623157e+308"),
        ("__DBL_NORM_MAX__", "1.7976931348623157e+308"),
        ("__DBL_DENORM_MIN__", "4.9406564584124654e-324"),
    ];
    // (MANT_DIG, DIG, MIN_EXP, MIN_10_EXP, MAX_EXP, MAX_10_EXP,
    //  DECIMAL_DIG, EPSILON, MIN, MAX, DENORM_MIN); MAX doubles as
    //  NORM_MAX and DECIMAL_DIG as the C99 5.2.4.2.2 __DECIMAL_DIG__.
    const LDBL_F64: (
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
    ) = (
        "53",
        "15",
        "(-1021)",
        "(-307)",
        "1024",
        "308",
        "17",
        "2.2204460492503131e-16L",
        "2.2250738585072014e-308L",
        "1.7976931348623157e+308L",
        "4.9406564584124654e-324L",
    );
    const LDBL_X87: (
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
    ) = (
        "64",
        "18",
        "(-16381)",
        "(-4931)",
        "16384",
        "4932",
        "21",
        "1.08420217248550443400745280086994171e-19L",
        "3.36210314311209350626267781732175260e-4932L",
        "1.18973149535723176502126385303097021e+4932L",
        "3.64519953188247460252840593361941982e-4951L",
    );
    const LDBL_BIN128: (
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
        &str,
    ) = (
        "113",
        "33",
        "(-16381)",
        "(-4931)",
        "16384",
        "4932",
        "36",
        "1.92592994438723585305597794258492732e-34L",
        "3.36210314311209350626267781732175260e-4932L",
        "1.18973149535723176508575932662800702e+4932L",
        "6.47517511943802511092443895822764655e-4966L",
    );
    let (mant, dig, min_exp, min_10, max_exp, max_10, dec_dig, eps, min, max, denorm) =
        match target.long_double() {
            crate::c5::codegen::LongDoubleKind::F64 => LDBL_F64,
            crate::c5::codegen::LongDoubleKind::X87 => LDBL_X87,
            crate::c5::codegen::LongDoubleKind::Binary128 => LDBL_BIN128,
        };
    let ldbl: &[(&str, &str)] = &[
        ("__LDBL_MANT_DIG__", mant),
        ("__LDBL_DIG__", dig),
        ("__LDBL_MIN_EXP__", min_exp),
        ("__LDBL_MIN_10_EXP__", min_10),
        ("__LDBL_MAX_EXP__", max_exp),
        ("__LDBL_MAX_10_EXP__", max_10),
        ("__LDBL_DECIMAL_DIG__", dec_dig),
        ("__LDBL_EPSILON__", eps),
        ("__LDBL_MIN__", min),
        ("__LDBL_MAX__", max),
        ("__LDBL_NORM_MAX__", max),
        ("__LDBL_DENORM_MIN__", denorm),
        // C99 5.2.4.2.2p11: decimal digits for the widest supported
        // format, i.e. the long double row's.
        ("__DECIMAL_DIG__", dec_dig),
    ];
    for (name, value) in COMMON.iter().chain(ldbl) {
        macros.insert((*name).to_string(), (*value).to_string());
    }
    for prefix in ["__FLT", "__DBL", "__LDBL"] {
        for trait_name in ["HAS_DENORM", "HAS_INFINITY", "HAS_QUIET_NAN"] {
            macros.insert(format!("{prefix}_{trait_name}__"), "1".to_string());
        }
    }
}

/// Install every predefine whose spelling or value follows the unit's
/// model, replacing whatever a previous call left; sole owner of these
/// names, so re-selecting leaves nothing from the other model behind.
///
/// `Elf32` on an x86 target is `-m16` / `-m32`, which gcc preprocesses
/// as i386: `__i386__` for `__x86_64__`, ILP32 for LP64, 32-bit pointer
/// / `long` / `size_t` / `wchar_t` spelling, no `__int128`, and the
/// `__code_model_32__` name for whichever `-mcmodel` names otherwise.
/// `-m16` is `-m32` code generation with a 16-bit default operand size
/// and shares its predefines. An `Elf32` AArch64 object would be
/// AArch32, which badc neither encodes nor describes; the driver
/// refuses the flag there and the target's own model stands.
///
/// `short_wchar` is `-fshort-wchar`, which narrows `wchar_t` to an
/// unsigned 16-bit type on any target; see [`Target::wchar_type`].
fn install_data_model(
    macros: &mut HashMap<String, String>,
    target: Target,
    class: ElfClass,
    code_model: CodeModel,
    short_wchar: bool,
) {
    let ilp32 = class.is32() && target.is_x86_64();
    // Both reserved spellings, as gcc has them; the unreserved `i386`
    // stays out, as bare `linux` / `unix` do.
    const X86_64_NAMES: &[&str] = &["__x86_64__", "__x86_64", "__amd64__", "__amd64"];
    const I386_NAMES: &[&str] = &["__i386__", "__i386"];
    for name in X86_64_NAMES.iter().chain(I386_NAMES).chain(&[
        "__LP64__",
        "_LP64",
        "__ILP32__",
        "_ILP32",
        "__SIZEOF_INT128__",
        "__WCHAR_TYPE__",
        "__code_model_32__",
        "__code_model_small__",
        "__code_model_kernel__",
    ]) {
        macros.remove(*name);
    }
    if target.is_x86_64() {
        for name in if ilp32 { I386_NAMES } else { X86_64_NAMES } {
            macros.insert(name.to_string(), "1".to_string());
        }
    }
    // Windows is LLP64 -- 32-bit `long`, 64-bit pointer -- so neither.
    let model_macros: &[&str] = match (ilp32, target.is_windows()) {
        (true, _) => &["__ILP32__", "_ILP32"],
        (false, false) => &["__LP64__", "_LP64"],
        (false, true) => &[],
    };
    for name in model_macros {
        macros.insert(name.to_string(), "1".to_string());
    }
    // Lets a header write `typedef __SIZE_TYPE__ size_t;` blind.
    let (size_ty, ptrdiff_ty) = match (ilp32, target.is_windows()) {
        (true, _) => ("unsigned int", "int"),
        (false, true) => ("unsigned long long", "long long"),
        (false, false) => ("unsigned long", "long"),
    };
    macros.insert("__SIZE_TYPE__".to_string(), size_ty.to_string());
    macros.insert("__PTRDIFF_TYPE__".to_string(), ptrdiff_ty.to_string());
    macros.insert("__INTPTR_TYPE__".to_string(), ptrdiff_ty.to_string());
    macros.insert("__UINTPTR_TYPE__".to_string(), size_ty.to_string());
    let ptr_bytes = if ilp32 { "4" } else { "8" };
    for name in [
        "__SIZEOF_POINTER__",
        "__SIZEOF_SIZE_T__",
        "__SIZEOF_PTRDIFF_T__",
    ] {
        macros.insert(name.to_string(), ptr_bytes.to_string());
    }
    let long_bytes = if ilp32 || target.is_windows() {
        "4"
    } else {
        "8"
    };
    macros.insert("__SIZEOF_LONG__".to_string(), long_bytes.to_string());
    // gcc leaves this undefined on i386, which has no `__int128`.
    if !ilp32 {
        macros.insert("__SIZEOF_INT128__".to_string(), "16".to_string());
    }
    // `wchar_t`'s width, underlying type and range, all from the one
    // `WcharType` the target defines, so the four predefines and the
    // `<stddef.h>` typedef that keys on `__WCHAR_TYPE__` cannot disagree.
    let wchar = target.wchar_type(short_wchar);
    macros.insert("__SIZEOF_WCHAR_T__".to_string(), wchar.bytes.to_string());
    macros.insert(
        "__WCHAR_TYPE__".to_string(),
        wchar.spelling(ilp32).to_string(),
    );
    let (wchar_max, wchar_min) = wchar.bound_macros();
    macros.insert("__WCHAR_MAX__".to_string(), wchar_max);
    macros.insert("__WCHAR_MIN__".to_string(), wchar_min);
    // gcc's x86 back end names the selected code model; the aarch64 one
    // defines no such macro. An ELFCLASS32 object is the 32-bit model
    // whatever `-mcmodel` says.
    if target.is_x86_64() {
        let model = match (ilp32, code_model) {
            (true, _) => "__code_model_32__",
            (false, CodeModel::Small) => "__code_model_small__",
            (false, CodeModel::Kernel) => "__code_model_kernel__",
        };
        macros.insert(model.to_string(), "1".to_string());
    }
}

impl Preprocessor {
    /// Build a preprocessor with the standard predefines set.
    ///
    /// Naming follows the gcc / clang / msvc convention of double
    /// underscores around tool-supplied macros so they don't
    /// collide with user identifiers:
    ///
    /// * `__BADC_VERSION__` -- the crate version, as a string
    ///   literal. Source can write `#if __BADC_VERSION__ == "0.1.0"`.
    /// * `__BADC_TARGET__` -- the canonical target id (e.g.
    ///   `"macos-aarch64"`), as a string literal. Used to gate
    ///   target-specific code at the source level.
    ///
    /// Comparing these string-literal predefines with `#if X == "..."`
    /// is a c5 extension over C99 6.10.1p4, which restricts a `#if`
    /// controlling expression to an integer constant expression; see
    /// doc/std-conformance.md.
    /// * CPU-architecture macros, all defined to `1` when active so
    ///   `#if __aarch64__` works the same way it does in gcc/clang:
    ///   * AArch64 targets get `__aarch64__` and `__arm64__` (the
    ///     latter is the Apple/clang spelling).
    ///   * x86_64 targets get `__x86_64__` and `__amd64__`.
    /// * OS macros, also defined to `1` when active, mirroring the
    ///   gcc / clang / msvc spelling so cross-platform headers
    ///   (`#ifdef __APPLE__`, `#ifdef __linux__`, `#ifdef _WIN32`)
    ///   work the way users already expect:
    ///   * macOS targets get `__APPLE__` and `__MACH__`.
    ///   * Linux targets get `__linux__` and `__unix__`.
    ///   * Windows targets get `_WIN32` (and `_WIN64`, since both of
    ///     our Windows targets are 64-bit) plus the legacy
    ///     `__BADC_WINDOWS__` we used before this commit.
    pub fn new(target_spec: &str, target: Target, crate_version: &str) -> Self {
        let mut macros: HashMap<String, String> = HashMap::new();
        let mut fn_macros: HashMap<String, FnMacro> = HashMap::new();
        let intrinsics: alloc::collections::BTreeMap<String, i64> = builtins::preseeded(target)
            .map(|(name, id)| (name.to_string(), id))
            .collect();
        // GCC `__attribute__((...))` and MSVC `__declspec(...)` are
        // declaration decorators carrying hints the dialect does not act
        // on, except for the `packed` attribute, which changes aggregate
        // layout. Both are lexer tokens parsed by
        // `skip_attribute_specifiers` rather than preprocessed away, so
        // `packed` reaches the parser and the rest is consumed in place.
        macros.insert(
            "__BADC_VERSION__".to_string(),
            format!("\"{crate_version}\""),
        );
        macros.insert("__BADC_TARGET__".to_string(), format!("\"{target_spec}\""));
        // Standard predefines (C99 sec 6.10.8). `__DATE__` and `__TIME__`
        // are seeded at badc build time; C99 says they reflect "the date
        // and time of translation", and the closest analogue for an
        // embedded library is the build time of badc itself.
        // `__STDC_HOSTED__` reflects that every supported target binds the
        // host libc, so the dialect is hosted. `__STDC_VERSION__` reports
        // C11 (201112L): the implemented surface is C99 plus the C11
        // features real code gates on this macro (`_Static_assert`,
        // `_Noreturn`, `_Atomic`, `_Thread_local`, anonymous members, and
        // `<stdatomic.h>`).
        macros.insert("__STDC__".to_string(), "1".to_string());
        macros.insert("__STDC_HOSTED__".to_string(), "1".to_string());
        macros.insert("__STDC_VERSION__".to_string(), "201112L".to_string());
        // Memory-order arguments to the __atomic_* builtins. badc always
        // emits sequential consistency, so the value only has to satisfy
        // the source's `#if`/comparison uses; the canonical GCC encoding
        // (relaxed=0 .. seq_cst=5) keeps those exact.
        for (name, val) in [
            ("__ATOMIC_RELAXED", "0"),
            ("__ATOMIC_CONSUME", "1"),
            ("__ATOMIC_ACQUIRE", "2"),
            ("__ATOMIC_RELEASE", "3"),
            ("__ATOMIC_ACQ_REL", "4"),
            ("__ATOMIC_SEQ_CST", "5"),
        ] {
            macros.insert(name.to_string(), val.to_string());
        }
        // `__GNUC__` and the rest of the GCC identity are opt-in
        // (`--gnu`, [`Self::enable_gnu`]). badc implements the GNU C
        // extensions real code gates on `__GNUC__`, but not all of them
        // (the x86 SIMD intrinsics are absent), so it does not claim the
        // macro by default; code that gates an intrinsic path on
        // `__GNUC__` plus an x86 target would otherwise fail to compile.
        // Byte-order predefines (GCC/clang form). Every supported target
        // is little-endian.
        macros.insert("__ORDER_LITTLE_ENDIAN__".to_string(), "1234".to_string());
        macros.insert("__ORDER_BIG_ENDIAN__".to_string(), "4321".to_string());
        macros.insert("__ORDER_PDP_ENDIAN__".to_string(), "3412".to_string());
        macros.insert(
            "__BYTE_ORDER__".to_string(),
            "__ORDER_LITTLE_ENDIAN__".to_string(),
        );
        // gcc/clang also define `__LITTLE_ENDIAN__` (to 1) on a
        // little-endian target; byte-order-detecting code commonly gates on
        // `#ifdef __LITTLE_ENDIAN__` directly rather than comparing
        // `__BYTE_ORDER__`. `__BIG_ENDIAN__` stays undefined.
        macros.insert("__LITTLE_ENDIAN__".to_string(), "1".to_string());
        // `__counted_by(m)` and its endian variants annotate a flexible
        // array member with its element-count field (a bounds hint, GCC 15 /
        // Clang). badc does not implement the attribute; predefine the macros
        // empty, the same fallback the kernel UAPI headers use when the
        // compiler lacks it (`__has_attribute(counted_by)` is likewise 0), so
        // a header that reaches for them without its own guard still compiles.
        for name in ["__counted_by", "__counted_by_le", "__counted_by_be"] {
            fn_macros.insert(
                name.to_string(),
                FnMacro {
                    params: alloc::vec!["m".to_string()],
                    body: String::new(),
                    is_variadic: false,
                    va_name: None,
                },
            );
        }
        // `__builtin_expect(exp, c)` is a compiler builtin in GCC,
        // available with no header; its value is the first operand.
        // Predefined here so code that never triggers the
        // `<_builtins.h>` auto-include still compiles; that header's
        // identical definition harmlessly re-registers it.
        fn_macros.insert(
            "__builtin_expect".to_string(),
            FnMacro {
                params: alloc::vec!["exp".to_string(), "c".to_string()],
                body: "(exp)".to_string(),
                is_variadic: false,
                va_name: None,
            },
        );
        // C11 6.10.8.3 conditional-feature macros. An implementation that
        // reports `__STDC_VERSION__ == 201112L` defines each of these for an
        // optional feature it does not provide; library code gates on them
        // to pick a portable fallback. badc has no variable length arrays
        // and no `_Complex` / `_Imaginary`, so it advertises both.
        // `__STDC_NO_THREADS__` is deliberately left undefined: although
        // badc ships no `<threads.h>`, real code gates the `_Thread_local`
        // storage classifier on `!defined(__STDC_NO_THREADS__)` (the two are
        // independent in C11, but the conflation is widespread), and badc
        // does support `_Thread_local`; defining the macro would suppress
        // thread-local storage. GCC and clang made the same choice while
        // they lacked `<threads.h>`. `<stdatomic.h>` is provided, so
        // `__STDC_NO_ATOMICS__` also stays undefined.
        // `__STDC_NO_VLA__` stays undefined: c5 supports C99 6.7.6.2
        // variable-length arrays (single dimension, block scope).
        macros.insert("__STDC_NO_COMPLEX__".to_string(), "1".to_string());
        // C11 6.10.8.2: `char16_t` / `char32_t` values are the UTF-16 /
        // UTF-32 code units of the character, which is what `u"..."` and
        // `U"..."` encode here.
        macros.insert("__STDC_UTF_16__".to_string(), "1".to_string());
        macros.insert("__STDC_UTF_32__".to_string(), "1".to_string());
        macros.insert(
            "__DATE__".to_string(),
            format!("\"{}\"", env!("BADC_BUILD_DATE")),
        );
        macros.insert(
            "__TIME__".to_string(),
            format!("\"{}\"", env!("BADC_BUILD_TIME")),
        );
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                macros.insert("__aarch64__".to_string(), "1".to_string());
                macros.insert("__arm64__".to_string(), "1".to_string());
                // Little-endian AArch64; gcc/clang define this and
                // arch-dispatch code keys its aarch64 branch on it.
                macros.insert("__AARCH64EL__".to_string(), "1".to_string());
            }
            Target::LinuxX64 | Target::WindowsX64 => {}
        }
        // x86 named address spaces (`int __seg_gs *p`): gcc predefines
        // these where the qualifiers are available, and an access through
        // one rides a segment-override prefix. x86-only, as the
        // qualifiers themselves are.
        if target.is_x86_64() {
            macros.insert("__SEG_FS".to_string(), "1".to_string());
            macros.insert("__SEG_GS".to_string(), "1".to_string());
        }
        // GCC/Clang define `__CHAR_UNSIGNED__` exactly when plain
        // `char` is unsigned (C99 6.2.5p15 leaves it
        // implementation-defined). Headers branch on it to choose
        // sign-extension strategy, so mirror the target's choice.
        if !target.plain_char_signed() {
            macros.insert("__CHAR_UNSIGNED__".to_string(), "1".to_string());
        }
        // GCC/Clang predefine each type's byte size so portable code can
        // select widths without <limits.h> (e.g. a pointer's bit width is
        // `__SIZEOF_POINTER__ * 8`). These are the sizes no data model
        // moves; the rest go in through `install_data_model`.
        // C99 5.2.4.2.1: CHAR_BIT is 8 on every supported target.
        macros.insert("__CHAR_BIT__".to_string(), "8".to_string());
        macros.insert("__SIZEOF_SHORT__".to_string(), "2".to_string());
        macros.insert("__SIZEOF_INT__".to_string(), "4".to_string());
        macros.insert("__SIZEOF_LONG_LONG__".to_string(), "8".to_string());
        macros.insert("__SIZEOF_FLOAT__".to_string(), "4".to_string());
        macros.insert("__SIZEOF_DOUBLE__".to_string(), "8".to_string());
        // `long double` takes the target ABI's storage size: 16 on
        // both Linux targets, 8 elsewhere. `__SIZEOF_FLOAT80__` and
        // `__SIZEOF_FLOAT128__` stay undefined with the types absent.
        macros.insert(
            "__SIZEOF_LONG_DOUBLE__".to_string(),
            target.long_double().size().to_string(),
        );
        install_float_characteristics(&mut macros, target);
        // `wint_t` is the bundled <wchar.h>'s `int` on every target.
        macros.insert("__WINT_TYPE__".to_string(), "int".to_string());
        macros.insert("__SIZEOF_WINT_T__".to_string(), "4".to_string());
        // C11 6.4.4.4p2-p4 / 7.28: `char16_t` is `uint_least16_t` and
        // `char32_t` is `uint_least32_t`. Neither tracks `wchar_t`, so
        // both hold on every target, and they name the types `u'c'` and
        // `U'c'` take.
        macros.insert("__CHAR16_TYPE__".to_string(), "unsigned short".to_string());
        macros.insert("__CHAR32_TYPE__".to_string(), "unsigned int".to_string());
        // The largest fundamental alignment: what a bare
        // `__attribute__((aligned))` resolves to and what `__int128` /
        // 16-aligned automatics are placed at.
        macros.insert("__BIGGEST_ALIGNMENT__".to_string(), "16".to_string());
        install_data_model(
            &mut macros,
            target,
            ElfClass::Elf64,
            CodeModel::Small,
            false,
        );
        match target {
            Target::MacOSAarch64 => {
                macros.insert("__APPLE__".to_string(), "1".to_string());
                macros.insert("__MACH__".to_string(), "1".to_string());
                // Deployment target, decimal MMmmpp. Matches the 11.0
                // minimum OS version stamped into LC_BUILD_VERSION;
                // <AvailabilityMacros.h> derives its version gates from it.
                macros.insert(
                    "__ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__".to_string(),
                    "110000".to_string(),
                );
            }
            Target::LinuxAarch64 | Target::LinuxX64 => {
                macros.insert("__linux__".to_string(), "1".to_string());
                macros.insert("__unix__".to_string(), "1".to_string());
                // badc links the GNU C library on Linux targets, so source
                // gating a glibc-only feature (pthread_getattr_np,
                // __GLIBC_PREREQ) keys on these instead of a degraded
                // fallback, matching a gcc/clang build here. A 2.17 baseline;
                // installed before the CLI lists so `-D`/`-U __GLIBC__` win.
                macros.insert("__GLIBC__".to_string(), "2".to_string());
                macros.insert("__GLIBC_MINOR__".to_string(), "17".to_string());
                // The feature-test state glibc's <features.h> derives when
                // no request macro is set. The bundled headers stand in for
                // glibc's, so the derivation must come from here or system
                // headers keying on it (e.g. a `struct timeval` fallback
                // guarded by `!defined(_POSIX_C_SOURCE)`) misread the
                // environment. Overridable like any predefine.
                macros.insert("_DEFAULT_SOURCE".to_string(), "1".to_string());
                macros.insert("_POSIX_SOURCE".to_string(), "1".to_string());
                macros.insert("_POSIX_C_SOURCE".to_string(), "200809L".to_string());
            }
            Target::WindowsX64 | Target::WindowsAarch64 => {
                // Target-detection macros plus the `__intN` fixed-width
                // type keywords. `__int8/16/32/64` are mingw-gcc builtins
                // on Windows -- provided independent of MSVC, and used by
                // essentially all Windows API code -- so they belong to the
                // target surface. The remaining MSVC-mimicry (`_MSC_VER`,
                // `__MINGW32__`, the `__declspec(x)` empty-decorator family,
                // the SAL annotations) stays in the opt-in `msvc_compat.h`
                // header, included per translation unit via
                // `badc -include msvc_compat.h ...`.
                macros.insert("_WIN32".to_string(), "1".to_string());
                macros.insert("_WIN64".to_string(), "1".to_string());
                macros.insert("__BADC_WINDOWS__".to_string(), "1".to_string());
                macros.insert("__int8".to_string(), "char".to_string());
                macros.insert("__int16".to_string(), "short".to_string());
                macros.insert("__int32".to_string(), "int".to_string());
                macros.insert("__int64".to_string(), "long long".to_string());
            }
        }
        Self {
            macros,
            target,
            wchar: target.wchar_type(false),
            char_signed: target.plain_char_signed(),
            fn_macros,
            dylibs: Vec::new(),
            dylib_index: HashMap::new(),
            exports: Vec::new(),
            export_names: BTreeSet::new(),
            pragma_once_files: BTreeSet::new(),
            include_guards: HashMap::new(),
            include_stack: Vec::new(),
            search_paths: SearchPaths::default(),
            own_header_roots: SearchPaths::default(),
            quote_search_paths: SearchPaths::default(),
            system_fallback_paths: SearchPaths::default(),
            nostdinc: false,
            no_builtin: false,
            force_includes: Vec::new(),
            source_label: "<source>".to_string(),
            warnings: Vec::new(),
            include_records: Vec::new(),
            track_includes: false,
            asm_source: false,
            entrypoint: None,
            subsystem: None,
            counter: Cell::new(0),
            pending_error: RefCell::new(None),
            body_toks: RefCell::new(hashbrown::HashMap::new()),
            hs_singletons: RefCell::new(hashbrown::HashMap::new()),
            exp_scratch: RefCell::new(expand::ExpScratch::default()),
            warning_disabled: BTreeSet::new(),
            warning_stack: Vec::new(),
            warn_disabled: BTreeSet::new(),
            intrinsics,
            reuse: None,
        }
    }

    /// Re-select the predefines that follow the unit's model: `-m16` /
    /// `-m32` select the i386 set through `class`, `-mcmodel` names the
    /// x86-64 model, and `-fshort-wchar` narrows `wchar_t`; see
    /// [`install_data_model`].
    pub fn set_unit_model(&mut self, class: ElfClass, model: CodeModel, short_wchar: bool) {
        self.wchar = self.target.wchar_type(short_wchar);
        install_data_model(&mut self.macros, self.target, class, model, short_wchar);
    }

    /// Select plain `char`'s signedness for this unit (`-fsigned-char` /
    /// `-funsigned-char`), moving `__CHAR_UNSIGNED__` with it so a
    /// header cannot read one answer while the front end uses another.
    pub fn set_plain_char_signed(&mut self, signed: bool) {
        self.char_signed = signed;
        if signed {
            self.macros.remove("__CHAR_UNSIGNED__");
        } else {
            self.macros
                .insert("__CHAR_UNSIGNED__".to_string(), "1".to_string());
        }
    }

    /// Define the GCC identity macros (`--gnu`). badc claims `__GNUC__`
    /// only on request because it implements most, but not all, of the
    /// GNU C surface (the x86 SIMD intrinsics are absent). Exactly one
    /// of `__GNUC_STDC_INLINE__` /
    /// `__GNUC_GNU_INLINE__` reports which inline linkage model is in
    /// force, per `gnu89_inline`; headers key the spelling of their
    /// inline declarations off it.
    /// `__VERSION__` is the compiler-identification string embedded by
    /// code such as `Py_GetCompiler`. `__STRICT_ANSI__` reports strict
    /// ISO conformance alongside `__GNUC__`, exactly as
    /// `gcc`/`clang -std=c11` does, so portable code uses the standard
    /// path for the GNU-only features badc lacks.
    pub fn enable_gnu(&mut self, gnu89_inline: bool, strict_ansi: bool) {
        // The claimed version (`crate::GNU_COMPAT_VERSION`) is 4.3.0:
        // every feature GCC 4.3 documents is backed -- `__builtin_bswap32`
        // / `__builtin_bswap64`, the `hot` / `cold` / `alloc_size` /
        // `error` / `warning` attributes, `__COUNTER__` -- and later
        // features that real code gates on their own capability macros
        // rather than on the version (`__atomic_*`, `asm goto`,
        // `_Static_assert`, `_Generic`, `__has_attribute`,
        // `__builtin_*_overflow`) are backed too.
        // The two things 4.4 adds that real code selects on the version
        // are now backed: per-function `__attribute__((target(...)))` and
        // the x86 intrinsic header family, over the SSE2 / SSSE3 /
        // SSE4.1 / AES-NI / PCLMUL / RDRAND subset the headers carry.
        // TODO: raise the claim, which needs the forced-claim measurement
        // over a corpus at each rung between 4.4 and the chosen version,
        // not just at the intrinsic surface.
        let mut compat = crate::GNU_COMPAT_VERSION.split('.');
        for name in ["__GNUC__", "__GNUC_MINOR__", "__GNUC_PATCHLEVEL__"] {
            let component = compat.next().expect("GNU_COMPAT_VERSION is x.y.z");
            self.macros.insert(name.to_string(), component.to_string());
        }
        let inline_model_macro = if gnu89_inline {
            "__GNUC_GNU_INLINE__"
        } else {
            "__GNUC_STDC_INLINE__"
        };
        self.macros
            .insert(inline_model_macro.to_string(), "1".to_string());
        // Dialect version first, then the real producer, as clang
        // spells it ("4.2.1 Compatible Clang ..."), so code that
        // embeds `__VERSION__` (`Py_GetCompiler`, sqlite's
        // "compiled by") names badc rather than claiming to be gcc.
        self.macros.insert(
            "__VERSION__".to_string(),
            alloc::format!(
                "\"{} Compatible badc {}\"",
                crate::GNU_COMPAT_VERSION,
                env!("CARGO_PKG_VERSION")
            ),
        );
        // The `__sync_*` builtins lower for these widths, so the
        // capability macros a lock-free path tests are honest. 16 stays
        // undefined: a 16-byte compare-exchange has no lowering.
        for w in [1u32, 2, 4, 8] {
            self.macros.insert(
                alloc::format!("__GCC_HAVE_SYNC_COMPARE_AND_SWAP_{w}"),
                "1".to_string(),
            );
        }
        // C11 7.17.5 lock-free property, in the GCC spelling
        // `<stdatomic.h>` and lock-free paths test. Every type named
        // here is at most 8 bytes wide on every supported target and
        // the `__atomic_*` builtins lower to a lock-free instruction at
        // those widths, so all are 2 (always lock-free).
        for name in [
            "BOOL", "CHAR", "CHAR16_T", "CHAR32_T", "WCHAR_T", "SHORT", "INT", "LONG", "LLONG",
            "POINTER",
        ] {
            self.macros.insert(
                alloc::format!("__GCC_ATOMIC_{name}_LOCK_FREE"),
                "2".to_string(),
            );
        }
        // `__atomic_test_and_set` sets the byte to 1.
        self.macros.insert(
            "__GCC_ATOMIC_TEST_AND_SET_TRUEVAL".to_string(),
            "1".to_string(),
        );
        // Report strict ISO conformance alongside `__GNUC__`, exactly as
        // `gcc`/`clang -std=c11` does, so a header takes its standard-C
        // path rather than a GNU-dialect path for any extension badc
        // does not provide. Both the plain and `__`-prefixed spellings
        // of the extensions badc does implement stay available.
        // `-std=gnu*` clears it: a header then reaches the GNU-dialect
        // declarations the dialect promises, as under gcc and clang.
        if strict_ansi {
            self.macros
                .insert("__STRICT_ANSI__".to_string(), "1".to_string());
        }
        // `=@cc<cond>` inline-asm flag outputs (GCC 6). Implemented for
        // x86 only, so the macro follows the target rather than the
        // dialect alone. gcc defines it under `-m32` too, so the test is
        // the target and not the `__x86_64__` predefine.
        if self.target.is_x86_64() {
            self.macros
                .insert("__GCC_ASM_FLAG_OUTPUTS__".to_string(), "1".to_string());
        }
    }

    /// Enable / disable include tracking. When on, every `#include`
    /// resolution -- successful, cached or missing -- appends to
    /// `include_records`, which feeds both the CLI's `-H` trace and
    /// the `-M` family's dependency output.
    pub fn set_track_includes(&mut self, enabled: bool) {
        self.track_includes = enabled;
    }

    /// Mark the input as assembler-with-cpp (a `.S` unit).
    pub fn set_asm_source(&mut self, on: bool) {
        self.asm_source = on;
    }

    /// Override the filename label used for the top-level translation
    /// unit's leading line marker. Default is `"<source>"`; the CLI
    /// passes the argv path so error messages name the file the user
    /// actually opened. No-op when the path is empty (stdin / fixture
    /// paths leave the placeholder in place).
    pub fn set_source_label(&mut self, label: &str) {
        if !label.is_empty() {
            self.source_label = label.to_string();
        }
    }

    /// Append a filesystem search path probed before the bundled
    /// headers on `#include`. Paths are tried in insertion order;
    /// the first matching `<path>/<name>` wins. Plumb in from
    /// `-I path` on the CLI; built-in defaults like `./include`
    /// can be added the same way at startup so users don't have
    /// to repeat them on every invocation.
    pub fn add_search_path(&mut self, path: &str) {
        self.search_paths.add(path);
    }

    /// Append an on-disk copy of the compiler's own header set (the
    /// source tree's `libc/include`, `$BADC_HOME/include`). A bundled
    /// name found there replaces the in-binary body, keeping one
    /// identity per header name so `#pragma once` and the include
    /// guards see a single file however the include was reached.
    pub fn add_own_header_root(&mut self, path: &str) {
        self.own_header_roots.add(path);
    }

    /// Append a `#include "..."`-only search path (the gcc `-iquote`
    /// scope). Probed after the including file's directory and before
    /// the `-I` paths; angle includes never read it.
    pub fn add_quote_path(&mut self, path: &str) {
        self.quote_search_paths.add(path);
    }

    /// Append a system header directory probed only after the bundled
    /// headers (see [`Preprocessor::system_fallback_paths`]). The
    /// driver adds the host's default system include directories here
    /// for a hosted native build, the way a compiler driver's implicit
    /// system include path resolves third-party headers without
    /// shadowing the standard headers.
    pub fn add_system_fallback_path(&mut self, path: &str) {
        self.system_fallback_paths.add(path);
    }

    /// gcc / clang `-nostdinc`: take the standard library headers off the
    /// `#include` search. See [`Preprocessor::nostdinc`].
    pub fn set_nostdinc(&mut self, on: bool) {
        self.nostdinc = on;
    }

    /// gcc / clang `-fno-builtin` / `-ffreestanding`, the preprocessor's
    /// half. See [`Preprocessor::no_builtin`].
    pub fn set_no_builtin(&mut self, on: bool) {
        self.no_builtin = on;
    }

    /// Add a header to splice in front of the user's translation
    /// unit, before any source line is preprocessed. Mirrors gcc /
    /// clang's `-include FILE` flag. The name is resolved through
    /// the same chain as a regular `#include "name"` -- filesystem
    /// search paths first (so a checked-in copy of the header
    /// wins), then the embedded registry. Order matters: multiple
    /// `-include` flags expand top-to-bottom in the order given.
    pub fn add_force_include(&mut self, name: &str) {
        self.force_includes.push(name.to_string());
    }

    /// Predefine an object-like macro from the build driver --
    /// the CLI's `-D NAME` / `-D NAME=VALUE` plumbs through here.
    /// `-D NAME` (no `=`) reaches here with body `"1"` per cpp's
    /// convention; `-D NAME=` (with `=`, empty value) reaches here
    /// with an empty body and must stay empty, matching the `#define
    /// NAME` directive -- e.g. `-DPRIVATE=` expands to nothing,
    /// not `1`. Late definitions in source still win, so a `-D X=0`
    /// followed by `#define X 1` in source ends up with `X = 1`.
    pub fn define(&mut self, name: &str, body: &str) {
        self.macros.insert(name.to_string(), body.to_string());
    }

    /// Drop a predefine -- the CLI's `-U NAME` plumbs here. Removes
    /// from both the object-like and function-like tables so a
    /// header that conditionally re-defines the same name on a
    /// different shape gets a clean slate. Object-like and fn-like
    /// macros never coexist in `cpp` (a `#define X` shadows a prior
    /// `#define X(a)` and vice versa); this mirrors that.
    pub fn undef(&mut self, name: &str) {
        self.macros.remove(name);
        self.fn_macros.remove(name);
    }

    /// Run the preprocessor over `source` and return the substituted
    /// text suitable for the lexer. Within a single source file each
    /// input line maps to exactly one output line so lexer-level
    /// error reports stay grounded in the original buffer; an
    /// `#include` directive expands to (header_lines + 1) output
    /// lines, which shifts user-source line numbers downstream of
    /// the include but keeps lines *within* a file aligned.
    pub fn process(&mut self, source: &str) -> Result<String, C5Error> {
        let mut out = String::with_capacity(source.len());
        self.process_preamble(&mut out)?;
        self.process_source(source, &mut out)?;
        Ok(out)
    }

    /// -include FILE plumbing: synthesize an `#include "name"`
    /// line per registered force-include and process them as a
    /// preamble before the user's source. Each force-include
    /// header runs with the same line-counter / `__FILE__` /
    /// search-path machinery as a regular `#include`, so a
    /// failure inside the header (say a typo'd `#pragma`) gets
    /// a diagnostic naming that header rather than the user's
    /// source. The synthesized preamble itself uses
    /// `<force-include>` as its filename label so any
    /// diagnostic targeting one of the synthesized lines
    /// points at that label and the line in the original
    /// source isn't shifted from the user's perspective.
    fn process_preamble(&mut self, out: &mut String) -> Result<(), C5Error> {
        if self.force_includes.is_empty() {
            return Ok(());
        }
        let mut preamble = String::new();
        for name in &self.force_includes.clone() {
            preamble.push_str(&format!("#include \"{name}\"\n"));
        }
        self.process_named(&preamble, "<force-include>", out)
    }

    fn process_source(&mut self, source: &str, out: &mut String) -> Result<(), C5Error> {
        #[cfg(any(test, feature = "codegen_test"))]
        FULL_SOURCE_PASSES.with(|c| c.set(c.get() + 1));
        let label = self.source_label.clone();
        self.process_named(source, &label, out)
    }

    /// As [`Self::process`], additionally recording what the source pass
    /// read of the state the preamble left, so a later run whose
    /// force-include list extends this one can prove the pass reusable
    /// ([`Self::process_reusing`]).
    pub(crate) fn process_recording(&mut self, source: &str) -> Result<(String, PpReuse), C5Error> {
        let mut out = String::with_capacity(source.len());
        self.process_preamble(&mut out)?;
        let source_start = out.len();
        let n_warnings = self.warnings.len();
        let n_records = self.include_records.len();
        let entry_macros = self.macros.clone();
        let entry_fn_macros = self.fn_macros.clone();
        let entry_once = self.pragma_once_files.clone();
        let entry_guards = self.include_guards.clone();
        let entry_counter = self.counter.get();
        let entry_warning_disabled = self.warning_disabled.clone();
        let entry_warning_stack = self.warning_stack.clone();
        let entry_warn_disabled = self.warn_disabled.clone();
        self.reuse = Some(Box::new(ReuseRecorder {
            filter: ObsFilter::sized_for(source.len()),
            counter_used: Cell::new(false),
            consulted_includes: BTreeSet::new(),
            pragma_events: Vec::new(),
        }));
        let result = self.process_source(source, &mut out);
        let rec = *self.reuse.take().expect("recorder installed above");
        result?;
        let cache = PpReuse {
            source_text: out[source_start..].to_string(),
            macros: entry_macros,
            fn_macros: entry_fn_macros,
            once_files: entry_once,
            include_guards: entry_guards,
            counter: entry_counter,
            warning_disabled: entry_warning_disabled,
            warning_stack: entry_warning_stack,
            warn_disabled: entry_warn_disabled,
            filter: rec.filter,
            counter_used: rec.counter_used.get(),
            consulted_includes: rec.consulted_includes,
            pragma_events: rec.pragma_events,
            warnings: self.warnings[n_warnings..].to_vec(),
            include_records: self.include_records[n_records..].to_vec(),
        };
        Ok((out, cache))
    }

    /// Run `process` for a force-include list extending the one `prior`
    /// was recorded under, reusing `prior`'s source pass when the
    /// extension provably cannot change it. `None` when reuse cannot be
    /// shown sound; the caller then runs a full pass on a fresh
    /// preprocessor. On `Some`, this preprocessor's side outputs are
    /// what the full run would leave.
    ///
    /// Beyond its own text and the filesystem (stable across a retry by
    /// the same assumption the full re-run makes), the source pass reads
    /// the macro tables, the once / include-guard registries, the
    /// `__COUNTER__` position and the pragma-warning state, and appends
    /// to the side outputs. Each read is checked below against what the
    /// recorded pass observed; the appends are replayed.
    pub(crate) fn process_reusing(&mut self, prior: &PpReuse) -> Option<String> {
        let mut out = String::new();
        self.process_preamble(&mut out).ok()?;
        if self.counter.get() != prior.counter && prior.counter_used {
            return None;
        }
        if self.warning_disabled != prior.warning_disabled
            || self.warning_stack != prior.warning_stack
            || self.warn_disabled != prior.warn_disabled
        {
            return None;
        }
        // Names the extension defines, redefines or undefines must be
        // ones the recorded pass never looked up, tested or (un)defined:
        // an identifier that was no macro then and is one now (or the
        // reverse, or a changed body) expands differently.
        if self.macro_delta_observed(prior) {
            return None;
        }
        // A once / guard registration for a file the pass resolved flips
        // that resolution between open and skip.
        if self
            .pragma_once_files
            .symmetric_difference(&prior.once_files)
            .any(|f| prior.consulted_includes.contains(f))
        {
            return None;
        }
        let guards_changed = self
            .include_guards
            .iter()
            .filter(|(k, v)| prior.include_guards.get(*k) != Some(*v))
            .map(|(k, _)| k)
            .chain(
                prior
                    .include_guards
                    .keys()
                    .filter(|k| !self.include_guards.contains_key(*k)),
            );
        if guards_changed
            .into_iter()
            .any(|f| prior.consulted_includes.contains(f))
        {
            return None;
        }
        // Replay the pass's side-output contributions onto this run's
        // state through the regular appliers, so ordering and conflict
        // rules hold as in a full run; a conflict the full run would
        // diagnose falls back to it.
        for (args, line, file) in &prior.pragma_events {
            self.parse_pragma(args, *line, file).ok()?;
        }
        self.warnings.extend(prior.warnings.iter().cloned());
        self.include_records
            .extend(prior.include_records.iter().cloned());
        out.push_str(&prior.source_text);
        Some(out)
    }

    /// Whether any macro-table difference against `prior`'s source-entry
    /// snapshot touches a name the recorded pass observed.
    fn macro_delta_observed(&self, prior: &PpReuse) -> bool {
        let obj = self
            .macros
            .iter()
            .filter(|(k, v)| prior.macros.get(*k) != Some(*v))
            .map(|(k, _)| k)
            .chain(
                prior
                    .macros
                    .keys()
                    .filter(|k| !self.macros.contains_key(*k)),
            );
        let func = self
            .fn_macros
            .iter()
            .filter(|(k, v)| prior.fn_macros.get(*k) != Some(*v))
            .map(|(k, _)| k)
            .chain(
                prior
                    .fn_macros
                    .keys()
                    .filter(|k| !self.fn_macros.contains_key(*k)),
            );
        obj.chain(func).any(|name| prior.filter.hit(obs_hash(name)))
    }

    /// Record `name` as observed by the source pass. Called wherever
    /// expansion, a conditional, a guard probe or a define / undef
    /// consults the macro tables.
    #[inline]
    pub(super) fn obs_note(&self, name: &str) {
        if let Some(r) = self.reuse.as_deref() {
            r.filter.set(obs_hash(name));
        }
    }

    /// Record that the source pass consumed a `__COUNTER__` value.
    #[inline]
    pub(super) fn obs_note_counter(&self) {
        if let Some(r) = self.reuse.as_deref() {
            r.counter_used.set(true);
        }
    }

    /// Recursive entry point. `filename` labels the buffer so error
    /// messages and `#pragma once` can name what they're talking
    /// about; the top-level call uses `"<source>"`, `#include`'d
    /// files use the header name (`"stdio.h"`).
    fn process_named(
        &mut self,
        source: &str,
        filename: &str,
        out: &mut String,
    ) -> Result<(), C5Error> {
        // A UTF-8 byte-order mark opening the file is accepted and
        // skipped, following gcc and clang.
        let source = source.strip_prefix('\u{feff}').unwrap_or(source);
        // c99 sec 5.1.1.2 phases 2 and 3, fused into one scan: every
        // `\\\n` joins lines so the line-by-line preprocessor never
        // sees a continuation, and comments are removed before macro
        // substitution so a `#define X 0 /* note */` body doesn't
        // emit a stray `*/` into a surrounding source comment when
        // X is referenced from inside that comment. Line counts are
        // preserved by emitting blank lines for each continuation
        // consumed, so error messages (and `__LINE__`) stay grounded
        // in the original source.
        let stripped = unfold_and_strip(source);
        let source = stripped.as_str();
        out.reserve(source.len());

        // Emit a leading line marker so the lexer attributes
        // tokens in this buffer to `(filename, 1)`. The
        // `format!` writes a GNU-style `# 1 "filename"\n` shape;
        // `parse_line_marker` in the lexer handles both the GNU
        // form and a C99 `#line N "filename"` -- they share the
        // same parsing path. Filenames with `"` or `\` get
        // backslash-escaped so they round-trip; other bytes pass
        // through verbatim (paths with embedded LF would already
        // break a thousand other things).
        out.push_str(&format_line_marker(1, filename));

        // Track the *effective* filename for `#include` restore
        // markers and `__FILE__`. This starts as `filename` (the
        // physical name we got handed) but a `#line N "other"`
        // directive in the user source can rewrite it -- and once
        // it does, every subsequent `#include` boundary in this
        // buffer needs to restore to *that* name, not back to the
        // original `filename`. The amalgamator (scripts/amalgamate.py)
        // depends on this: it puts a `#line 1 "real_path.c"` at the
        // top of each glued-in TU, then if that TU does its own
        // `#include`s the closing marker we emit when the include
        // returns must put us back inside `real_path.c`, not the
        // amalgamated container.
        let mut current_file: alloc::string::String = filename.into();

        // Source-relative line number for the current iteration. We
        // can't just use `idx_iter + 1` (the buffer's physical line)
        // because a `#line N "file"` resets the lexer's counter; if
        // we then close an `#include` with a buffer-line marker the
        // lexer snaps back to physical-buffer coordinates and every
        // subsequent attribution shifts. Track it explicitly: the
        // counter advances by 1 per processed input line, +consumed
        // for multi-line macro joins, and a `#line N` resets it to
        // `N` for the next iteration.
        let mut source_line: usize = 1;

        // `cond_stack` mirrors the nesting of `#if` / `#ifdef`. Each
        // entry is `(parent_active, this_branch_taken,
        // saw_else)`. `parent_active` is the enclosing branch's
        // active state; we AND with it so a true inner branch
        // inside a false outer branch still produces no output.
        // `saw_else` blocks a second `#else` for the same `#if`.
        let mut cond_stack: Vec<CondFrame> = Vec::new();
        let mut active = true;

        // Manual line iteration so multi-line function-like macro
        // calls -- `assert(\n  expr\n);` -- can be joined into a
        // single buffer before substitution. Per-line iteration
        // would leave the call's `(` unmatched on the first line
        // and the macro wouldn't expand. Subsequent consumed
        // lines emit blank `\n`s so error line numbers stay
        // grounded in the original source.
        let lines: Vec<&str> = source.lines().collect();
        let mut idx_iter = 0usize;
        // Watches for the `#ifndef X` / `#endif` wrapper that lets a
        // repeat `#include` of this file be dropped; see `include_guards`.
        let mut guard = IncludeGuardScan::default();
        while idx_iter < lines.len() {
            let idx = idx_iter;
            let line = lines[idx];
            let line_no = idx + 1;
            let trimmed = line.trim_start();

            // Assembler-with-cpp: a `#` line naming no directive is text,
            // not a directive; it falls through to the content path and
            // passes with its tail macro-expanded, as GNU cpp emits it
            // for assembler input.
            let parsed_hash = trimmed
                .strip_prefix('#')
                .map(|rest| (rest, parse_directive(rest.trim_start(), self.asm_source)));
            let asm_text = self.asm_source
                && matches!(&parsed_hash, Some((r, Directive::Other)) if !r.trim_start().is_empty());
            if let Some((rest, parsed)) = parsed_hash
                && !asm_text
            {
                let directive = rest.trim_start();
                guard.line(line, Some(&parsed), cond_stack.len());
                if let Some(next) = self.apply_cond_or_macro_directive(
                    &parsed,
                    active,
                    &mut cond_stack,
                    source_line,
                    line_no,
                    filename,
                )? {
                    active = next;
                    out.push('\n');
                    source_line += 1;
                    idx_iter += 1;
                    continue;
                }
                match parsed {
                    Directive::Pragma(args) => {
                        if active {
                            match parse_pragma_directive(args) {
                                PragmaDirective::Once => {
                                    self.pragma_once_files.insert(filename.to_string());
                                }
                                PragmaDirective::Other => {
                                    // `#pragma pack(...)` and `#pragma GCC
                                    // visibility ...` are source-position-
                                    // sensitive: a struct definition that
                                    // follows a `pack(1)` directive packs at
                                    // 1, but a struct AFTER a subsequent
                                    // `pack()` reverts. We can't batch those
                                    // up through the preprocessor's
                                    // `dylibs` / `bindings` accumulator the
                                    // way other pragmas are handled --
                                    // we'd lose ordering. Pass the line
                                    // through verbatim so the lexer
                                    // reaches it inline; the lexer's `#`
                                    // handler folds the directive into
                                    // its `pack_stack` / `visibility_stack`.
                                    if pragma_is_pack(args) || pragma_is_visibility(args) {
                                        out.push('#');
                                        out.push_str(directive);
                                        out.push('\n');
                                        source_line += 1;
                                        idx_iter += 1;
                                        continue;
                                    }
                                    self.parse_pragma(args, line_no, filename)?;
                                }
                            }
                        }
                    }
                    Directive::IncludeMacro(args) => {
                        if active {
                            // C99 6.10.2p4: expand the operand and
                            // reparse the result as a `<...>` /
                            // `"..."` literal include. Anything
                            // else is malformed; surface a
                            // warning and skip, matching how
                            // other unrecognised directives are
                            // handled. The spelling-faithful form
                            // keeps re-lex separators out of the
                            // header name.
                            let expanded = self.substitute_spelling(args, filename, line_no);
                            let trimmed = expanded.trim();
                            if let Some((n, quoted)) = header_name(trimmed) {
                                self.process_include(n, line_no, filename, quoted, out)?;
                                out.push_str(&format_line_marker(source_line + 1, &current_file));
                                source_line += 1;
                                idx_iter += 1;
                                continue;
                            }
                            self.warnings.push(super::error::fmt_compile_warn(
                                filename,
                                line_no,
                                &format!(
                                    "#include `{args}` expands to `{trimmed}`, \
                                     which is not a `<header>` or `\"header\"` literal"
                                ),
                            ));
                        }
                    }
                    Directive::Include { name, quoted } => {
                        if active {
                            self.process_include(name, line_no, filename, quoted, out)?;
                            // Closing marker uses `source_line + 1`
                            // (NOT `line_no + 1`) and `current_file`
                            // (NOT the static `filename` param).
                            // `source_line` tracks the user's
                            // intended source-line numbering across
                            // any prior `#line` directives in this
                            // buffer, which is what the lexer's
                            // counter actually reflects after the
                            // last marker we emitted. Using `line_no`
                            // here would snap the lexer back to
                            // physical-buffer coordinates and
                            // misattribute every subsequent emit --
                            // the bug that appears
                            // when the amalgamator started gluing
                            // multiple translation units together
                            // via `#line` markers.
                            out.push_str(&format_line_marker(source_line + 1, &current_file));
                            source_line += 1;
                            idx_iter += 1;
                            continue;
                        }
                    }
                    Directive::IncludeNext { name, quoted } => {
                        if active {
                            self.process_include_next(name, line_no, filename, quoted, out)?;
                            out.push_str(&format_line_marker(source_line + 1, &current_file));
                            source_line += 1;
                            idx_iter += 1;
                            continue;
                        }
                    }
                    Directive::Line { line, file } => {
                        if active {
                            // C99 6.10.4: `#line N` retargets the next
                            // source line's number; with `"file"` it
                            // also retargets the filename. The marker
                            // we emit replaces the `#line` line (one
                            // input line in, one marker line out),
                            // so we skip the bottom `\n` for the
                            // same reason as `#include`.
                            // Update the *effective* filename so the
                            // next `#include` returns here, not to
                            // the buffer's original `filename`. A
                            // bare `#line N` (no filename) keeps
                            // the current file -- C99 6.10.4 -- so
                            // we only rewrite when `file` is
                            // present.
                            if let Some(f) = file {
                                current_file = f.into();
                            }
                            out.push_str(&format_line_marker(line, &current_file));
                            // Next iteration's source-line counter
                            // is exactly `line` (the marker says so
                            // to the lexer, and our preprocessor
                            // tracker has to mirror that).
                            source_line = line;
                            idx_iter += 1;
                            continue;
                        }
                    }
                    Directive::LineMacro(args) => {
                        if active {
                            // C99 6.10.4: macro-expand the operand, then
                            // reparse as `#line N ["file"]`. A result
                            // that still doesn't lead with a digit
                            // sequence is malformed; warn and skip.
                            let expanded = self.substitute(args, filename, line_no);
                            let trimmed = expanded.trim();
                            let mut split = trimmed.splitn(2, char::is_whitespace);
                            if let Some(num) = split.next()
                                && let Ok(line) = num.parse::<usize>()
                            {
                                if let Some(f) = split.next().and_then(|tail| {
                                    let t = tail.trim();
                                    t.strip_prefix('"')
                                        .and_then(|s| s.strip_suffix('"'))
                                        .map(|s| s.to_string())
                                }) {
                                    current_file = f;
                                }
                                out.push_str(&format_line_marker(line, &current_file));
                                source_line = line;
                                idx_iter += 1;
                                continue;
                            }
                            self.warnings.push(super::error::fmt_compile_warn(
                                filename,
                                line_no,
                                &format!(
                                    "#line `{args}` expands to `{trimmed}`, \
                                     which is not a line number"
                                ),
                            ));
                        }
                    }
                    Directive::Other => {
                        // Unknown directive. C99 6.10.6 reserves
                        // every non-directive form for the
                        // implementation; gcc / clang surface
                        // unrecognised names as a warning and skip
                        // the line. c5 follows that shape: pull the
                        // first identifier out of the directive
                        // body so the warning names what was
                        // dropped, and let the empty-line emit
                        // below pad the line counter.
                        // A bare `#` is the C99 6.10p9 null directive:
                        // consumed without effect and without diagnostic.
                        if active && !directive.is_empty() {
                            let kw = directive
                                .split(|c: char| !c.is_ascii_alphanumeric() && c != '_')
                                .next()
                                .unwrap_or("")
                                .to_string();
                            let label = if kw.is_empty() {
                                "(empty)".to_string()
                            } else {
                                format!("`#{kw}`")
                            };
                            self.warnings.push(format!(
                                "{filename}:{line_no}: warning: \
                                 unknown preprocessor directive {label} -- ignoring"
                            ));
                        }
                    }
                    Directive::Shebang => {
                        // First-line `#!/usr/bin/env badc` shebangs --
                        // no preprocessor semantics, just skipped.
                    }
                    // Spelled out rather than `_` so a new directive
                    // variant is a compile error here as well as in
                    // `apply_cond_or_macro_directive`, which already
                    // consumed every one of these.
                    Directive::Define(..)
                    | Directive::DefineFn(..)
                    | Directive::Undef(..)
                    | Directive::Ifdef(..)
                    | Directive::Ifndef(..)
                    | Directive::If(..)
                    | Directive::Elif(..)
                    | Directive::Else
                    | Directive::Endif
                    | Directive::Error(..)
                    | Directive::Warning(..) => {
                        unreachable!("consumed by apply_cond_or_macro_directive")
                    }
                }
                out.push('\n');
                source_line += 1;
                idx_iter += 1;
                continue;
            }

            guard.line(line, None, cond_stack.len());
            if active {
                let mut buffer = String::from(line);
                let mut consumed = 1usize;
                // A function-like macro call may span lines whose arguments
                // carry preprocessor directives (C99 6.10.3p11 leaves this
                // undefined; gcc and clang process such directives as if
                // the invocation were not present, and real code relies on
                // it). Directives here work on the same conditional stack
                // as top-level ones -- an `#if` opened inside the argument
                // list may close after the call's `)`, and vice versa.
                // Directive lines never become argument text; content
                // lines join the buffer only while the current branch is
                // active.
                //
                // The scan state advances over appended bytes only;
                // re-scanning the grown buffer per joined line is
                // quadratic in the invocation length.
                let mut join = JoinScan::new();
                join.feed(&buffer, self);
                while idx + consumed < lines.len()
                    && (join.unclosed()
                        // A function-like macro name at the end of a line with
                        // its `(` on the next line is still an invocation (C99
                        // 6.10.3: white space, including newlines, may separate
                        // the name from its `(`). Join when the next line opens
                        // with `(` so the substitution sees the whole call.
                        || (join.pending_head()
                            && lines[idx + consumed].trim_start().starts_with('(')))
                {
                    let cont = lines[idx + consumed];
                    consumed += 1;
                    let dline = source_line + consumed - 1;
                    let cont_trimmed = cont.trim_start();
                    if let Some(rest) = cont_trimmed.strip_prefix('#') {
                        let parsed = parse_directive(rest.trim_start(), self.asm_source);
                        // TODO: `#include`, `#line` and `#pragma` inside an
                        // argument list are consumed without effect; their
                        // output would have to interleave with the joined
                        // expansion.
                        if let Some(next) = self.apply_cond_or_macro_directive(
                            &parsed,
                            active,
                            &mut cond_stack,
                            dline,
                            dline,
                            filename,
                        )? {
                            active = next;
                        }
                    } else if active {
                        let appended = buffer.len();
                        buffer.push('\n');
                        buffer.push_str(cont);
                        join.feed(&buffer[appended..], self);
                    }
                }
                // `__LINE__` reflects the presumed line (`source_line`),
                // which a `#line` directive can retarget (C99 6.10.4);
                // absent any `#line`, it equals the physical line.
                let substituted = self.substitute(&buffer, filename, source_line);
                // C99 6.10.9: a `_Pragma` operator in the now
                // macro-expanded text is destringized and handled as
                // the matching `#pragma` directive.
                let processed = self.apply_pragma_operators(&substituted, source_line, filename)?;
                out.push_str(&processed);
                out.push('\n');
                // Preserve source line numbering by emitting a blank
                // line for each extra source line we joined into the
                // buffer.
                for _ in 1..consumed {
                    out.push('\n');
                }
                source_line += consumed;
                idx_iter += consumed;
            } else {
                out.push('\n');
                source_line += 1;
                idx_iter += 1;
            }
        }

        self.take_pending_error()?;

        if !cond_stack.is_empty() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                "preprocessor: unterminated `#if` / `#ifdef` block",
            )));
        }

        // Only files reached through `#include` can be re-included, and
        // only they have a resolved path to key on.
        if !self.include_stack.is_empty()
            && let Some(name) = guard.finish(cond_stack.len())
        {
            self.include_guards.insert(filename.to_string(), name);
        }
        Ok(())
    }

    /// Install an object-like macro definition.
    fn apply_define(&mut self, name: &str, body: &str) {
        self.obs_note(name);
        self.macros.insert(name.to_string(), body.to_string());
        self.fn_macros.remove(name);
    }

    /// Directives whose whole effect is on the macro table or the
    /// conditional stack. Both the top-level line loop and the
    /// macro-argument line joiner dispatch through this so the two
    /// cannot drift; `None` means the directive belongs to neither
    /// group and the caller must handle it. `presumed` is the
    /// `#line`-adjusted number an `#if` expression evaluates against,
    /// `diag` the buffer line a diagnostic cites.
    fn apply_cond_or_macro_directive(
        &mut self,
        directive: &Directive<'_>,
        active: bool,
        cond_stack: &mut Vec<CondFrame>,
        presumed: usize,
        diag: usize,
        filename: &str,
    ) -> Result<Option<bool>, C5Error> {
        let mut push_branch = |taken: bool| {
            cond_stack.push(CondFrame {
                parent_active: active,
                this_branch_taken: taken,
                any_branch_taken: taken,
                saw_else: false,
            });
            taken
        };
        let next_active = match directive {
            Directive::Define(name, body) => {
                if active {
                    self.check_paste_placement(name, body, filename, diag);
                    self.apply_define(name, body);
                }
                active
            }
            Directive::DefineFn(name, params, body) => {
                if active {
                    self.check_paste_placement(name, body, filename, diag);
                    self.apply_define_fn(name, params, body);
                }
                active
            }
            Directive::Undef(name) => {
                if active {
                    self.apply_undef(name);
                }
                active
            }
            // C99 6.10.1: `#ifdef` is true when the name is defined as
            // any macro -- object-like or function-like.
            Directive::Ifdef(name) => push_branch(active && self.is_defined_name(name)),
            Directive::Ifndef(name) => push_branch(active && !self.is_defined_name(name)),
            Directive::If(expr) => {
                push_branch(active && self.eval_condition(expr, presumed, filename)?)
            }
            Directive::Elif(expr) => {
                // The expression eval needs a `&Self` while the frame
                // update borrows `cond_stack`: check eligibility
                // first, evaluate, then mutate.
                let eligible = elif_eligible(cond_stack, filename, diag)?;
                let cond = eligible && self.eval_condition(expr, presumed, filename)?;
                apply_elif(cond_stack, cond, filename, diag)?
            }
            Directive::Else => apply_else(cond_stack, filename, diag)?,
            Directive::Endif => apply_endif(cond_stack, filename, diag)?,
            Directive::Error(message) => {
                if active {
                    return Err(C5Error::Compile(super::error::fmt_compile_err(
                        filename,
                        diag,
                        &format!("#error {}", message.trim()),
                    )));
                }
                active
            }
            // gcc/clang extension, standardised in C23: same shape as
            // `#error` but compilation continues.
            Directive::Warning(message) => {
                if active {
                    self.warnings.push(super::error::fmt_compile_warn(
                        filename,
                        diag,
                        &format!("#warning {}", message.trim()),
                    ));
                }
                active
            }
            _ => return Ok(None),
        };
        Ok(Some(next_active))
    }

    /// C99 6.10.1 `defined`: any macro of either kind, plus the
    /// `__has_*` operator names the preprocessor implements and the
    /// predefines expanded from context. The context-expanded ones
    /// hold no table entry, but C99 6.10.8 makes them macros, so
    /// `#ifdef __FILE__` and the `#ifdef __COUNTER__` feature probe
    /// must see them.
    pub(super) fn is_defined_name(&self, name: &str) -> bool {
        self.obs_note(name);
        self.macros.contains_key(name)
            || self.fn_macros.contains_key(name)
            || is_operator_name(name)
            || super::preprocessor::expand::is_dynamic_predefine(name)
    }

    /// Install a function-like macro definition. A trailing `...`
    /// (C99 6.10.3) or the GCC named-rest form `name...` makes the
    /// macro variadic; the named form additionally binds the trailing
    /// arguments to `name`.
    fn apply_define_fn(&mut self, name: &str, params: &[&str], body: &str) {
        self.obs_note(name);
        let mut is_variadic = false;
        let mut va_name = None;
        let mut params = params;
        if let Some(last) = params.last().copied() {
            if last == "..." {
                is_variadic = true;
                params = &params[..params.len() - 1];
            } else if let Some(prefix) = last.strip_suffix("...") {
                let prefix = prefix.trim();
                if is_ident(prefix) {
                    is_variadic = true;
                    va_name = Some(prefix.to_string());
                    params = &params[..params.len() - 1];
                }
            }
        }
        self.fn_macros.insert(
            name.to_string(),
            FnMacro {
                params: params.iter().map(|s| s.to_string()).collect(),
                body: body.to_string(),
                is_variadic,
                va_name,
            },
        );
        self.macros.remove(name);
    }

    /// Remove a macro definition of either kind.
    fn apply_undef(&mut self, name: &str) {
        self.obs_note(name);
        self.macros.remove(name);
        self.fn_macros.remove(name);
    }

    /// Record the first macro-expansion diagnostic of a pass; later
    /// errors are dropped so the earliest source-order one wins.
    fn record_pp_error(&self, err: C5Error) {
        let mut slot = self.pending_error.borrow_mut();
        if slot.is_none() {
            *slot = Some(err);
        }
    }

    /// Drain any parked macro-expansion diagnostic.
    fn take_pending_error(&self) -> Result<(), C5Error> {
        match self.pending_error.borrow_mut().take() {
            Some(e) => Err(e),
            None => Ok(()),
        }
    }
}

pub(super) mod builtins;
mod cond;
mod directive;
mod expand;
mod include;
mod pragma;
mod text;

#[cfg(test)]
mod tests;

use builtins::is_operator_name;
use directive::{
    CondFrame, Directive, IncludeGuardScan, apply_elif, apply_else, apply_endif, elif_eligible,
    format_line_marker, header_name, parse_directive,
};
use expand::JoinScan;
pub use include::{IncludeOrigin, IncludeRecord, IncludeStatus};
use pragma::{PragmaDirective, parse_pragma_directive, pragma_is_pack, pragma_is_visibility};
use text::{is_ident, unfold_and_strip};
