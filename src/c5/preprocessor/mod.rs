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
//!   nestable. The operand is a C integer constant expression
//!   evaluated at 64 bits, plus `defined(NAME)` / `defined NAME`; an
//!   identifier that is no macro evaluates to 0 (C99 6.10.1).
//! * `#include <name.h>` / `#include "name.h"` -- the filesystem
//!   search paths first (the quoted form also searching the including
//!   file's directory), then the embedded registry (see
//!   [`super::headers`]). A repeat include is dropped once the header
//!   has used `#pragma once`.
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
//!   `dylib_name`, so a call to `local_name` lands on that import.
//!   Naming the dylib makes the pair order-independent.
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
use super::diag::{Code, Diagnostic, Level, Loc, Sink};
use super::error::C5Error;

/// One declared dylib plus the bindings that target it. Created
/// by `#pragma dylib(name, "path")`; populated by subsequent
/// `#pragma binding(name::c4_fn, "real_symbol")` directives that
/// reference this dylib through its `name`.
#[derive(Debug, Clone)]
pub struct DylibSpec {
    /// c5-side identifier for this dylib (`libc`, `kernel32`), named by
    /// each binding's `name::c4_fn` left-hand side.
    pub name: String,
    /// Path or loader-search name (`/usr/lib/libSystem.B.dylib`,
    /// `libc.so.6`, `msvcrt.dll`), passed through to the IAT entry /
    /// DT_NEEDED record verbatim.
    ///
    /// Read by tests; the codegen reads the same path through the
    /// `ResolvedDylib` view built during import resolution.
    #[allow(dead_code)]
    pub path: String,
    /// Bindings whose qualifier referenced `Self::name`.
    pub bindings: Vec<Binding>,
}

/// One `#pragma binding(dylib::local_name, "real_symbol")` declaration.
/// Owned by the [`DylibSpec`] whose `name` matched the qualifier.
#[derive(Debug, Clone)]
pub struct Binding {
    // The prototype fields below are filled by the parser when it folds
    // a Sys symbol's prototype onto the binding; the preprocessor sees
    // no prototypes and leaves them at their defaults.
    /// The prototype ended with `, ...)`, so the call site needs the
    /// platform's variadic ABI (macOS arm64 stack packing, SysV
    /// `xor eax, eax`).
    pub is_variadic: bool,
    /// Fixed (non-variadic) parameter count, meaningful only with
    /// `is_variadic`: AAPCS64 passes those in registers and spills only
    /// the variadic tail.
    pub fixed_args: usize,
    /// Return type, encoded as `Symbol::type_` is. The codegen reads it
    /// to decide whether a libc return needs sign- or zero-extension --
    /// the Win64 ABI leaves the upper 32 bits of RAX undefined for an
    /// `int` return, which a 64-bit comparison would then read. `0`
    /// (= `Ty::Char`) means no prototype yet, and no extension.
    pub return_type_tag: i64,
    /// The return type was spelled `long double`. `return_type_tag`
    /// stays `Ty::Double` (c5 stores both as f64); the libc-call codegen
    /// needs this to read the result from x87 `st(0)` on SysV x86-64
    /// rather than XMM0.
    pub returns_long_double: bool,
    /// Per-fixed-parameter type tags, encoded as `return_type_tag` is.
    /// Carried into `ResolvedImport` so the DWARF emitter can type each
    /// PLT trampoline's `DW_TAG_formal_parameter` children.
    pub param_types: Vec<i64>,
    /// c5-side name the source uses (e.g. `printf`).
    pub local_name: String,
    /// Symbol name exported by the dylib. Differs from `local_name` on
    /// macOS (leading `_`) and for Windows aliases (`mprotect` ->
    /// `VirtualProtect`).
    ///
    /// Read by tests; the codegen reads the same string through the
    /// `ResolvedImport` view built during import resolution.
    #[allow(dead_code)]
    pub real_symbol: String,
    /// The `#pragma binding(data <lib>::<name>, "...")` form: a data
    /// object, which resolves to a COPY relocation binding the host's
    /// symbol into the image rather than to a PLT/GOT call slot.
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
    // Hash maps rather than BTreeMaps: `macros` is probed once per
    // source identifier, where a tree walk's log-N string-prefix
    // compares measured as the frontend's hot spot.
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
    /// One entry per `#pragma export(<name>)`, in declaration order.
    /// The compiler checks each name against a function defined in this
    /// unit and threads the list onto `Program::exports`, which the
    /// shared-object writers promote to externally visible symbols.
    /// Everything else keeps the c5 default, file-scope-static linkage.
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
    /// Headers being expanded: the include spelling plus whether the
    /// body came from the compiler's own set rather than a search path.
    /// `find_include` reads the flag for its closed-set rule -- only a
    /// file served from the own set resolves its includes there first,
    /// so a foreign header whose spelling collides with a bundled name
    /// keeps `-I` order.
    include_stack: Vec<(String, bool)>,
    /// `#include` search paths (the CLI's `-I` plus the driver's
    /// overlays), probed in order before the bundled in-binary headers,
    /// so an on-disk copy of a bundled header overrides it. Read only
    /// under `cfg(feature = "std")`; the no_std build keeps the field
    /// and resolves from the embedded set.
    search_paths: SearchPaths,
    /// On-disk copies of the compiler's own header set, probed by name
    /// ahead of the in-binary bodies. See `add_own_header_root`.
    own_header_roots: SearchPaths,
    /// Directories probed for `#include "..."` only (the gcc `-iquote`
    /// scope), after the including file's directory and before
    /// `search_paths`. An angle include never reads them.
    quote_search_paths: SearchPaths,
    /// System header directories, probed only after the bundled headers:
    /// a third-party header the embedded set lacks (`zlib.h`,
    /// `libfdt.h`) resolves against the host, while a standard header
    /// keeps the embedded copy, which carries the `#pragma binding`
    /// metadata the system copy lacks. Populated for a hosted native
    /// build; empty for a cross, `--freestanding` or `--nostdinc` one.
    system_fallback_paths: SearchPaths,
    /// `-nostdinc`: the bundled set and `system_fallback_paths` leave
    /// the search, so a name no `-I` / `-iquote` path carries is an
    /// error rather than badc's own libc. The compiler-owned headers
    /// ([`crate::c5::headers::COMPILER_OWNED_HEADERS`]) stay, as gcc's
    /// builtins do.
    nostdinc: bool,
    /// `-fno-builtin`: `#pragma intrinsic(name)` registers nothing, so a
    /// call spelled with the library name lowers as a call rather than as
    /// the instruction badc has for it.
    no_builtin: bool,
    /// The `-include FILE` set: headers processed as if the user had
    /// written `#include "name"` at the top of the unit, resolved
    /// through the same chain.
    force_includes: Vec<String>,
    /// Filename for the unit's opening `#line 1 "..."` marker, hence for
    /// every diagnostic naming it. `"<source>"` until the CLI supplies
    /// the argv path. The DWARF emitter reads `Program::source_path`
    /// instead.
    source_label: String,
    /// Diagnostics from this pass and the state that resolves their
    /// level: what the command line asked for, and the diagnostic
    /// pragmas as the pass reaches them. Drained into
    /// `Compiler::warnings`, so one `Program::warnings` list carries
    /// every front-end diagnostic.
    pub sink: Sink,
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
    /// `#pragma entrypoint(<id>)`: a non-`main` entry such as `WinMain`
    /// or a custom `_start`. `None` keeps `main`. Read by the compile
    /// pass for `entry_pc` and by the PE writer for
    /// AddressOfEntryPoint.
    pub entrypoint: Option<String>,
    /// `#pragma subsystem(<kind>)`, read by the PE writer for the
    /// optional header's Subsystem field. `None` keeps `console`;
    /// non-PE targets ignore it.
    pub subsystem: Option<Subsystem>,
    /// The `__COUNTER__` predefine's per-unit counter: each expansion
    /// yields the current value and post-increments. A `Cell` because
    /// the substitution path takes `&self`.
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
    /// Borland / Watcom `#pragma warn -<code>` codes the source asked to
    /// disable. No catalogue row carries these identifiers, so the set
    /// records what the source asked for and filters nothing.
    pub(crate) warn_disabled: BTreeSet<alloc::string::String>,
    /// Diagnostic-pragma events this pass has recorded on the sink's
    /// `Control`. Read by [`Self::process_recording`] to tell whether
    /// the source pass left any.
    pub(crate) diag_pragmas: usize,
    /// `#pragma intrinsic("name")`: callable identifier to the
    /// `Intrinsic` discriminant the frontend stamps on the matching
    /// `Symbol::intrinsic`. A new one needs an `Intrinsic` variant in
    /// `op.rs` and an entry in [`Self::parse_pragma_intrinsic`].
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
    warn_disabled: BTreeSet<String>,
    /// Whether the recorded source pass left diagnostic-pragma events.
    diag_pragmas: bool,
    filter: ObsFilter,
    counter_used: bool,
    consulted_includes: BTreeSet<String>,
    pragma_events: Vec<(String, usize, String)>,
    warnings: Vec<Diagnostic>,
    include_records: Vec<IncludeRecord>,
}

// Test hook: how many times the source (as opposed to the preamble or
// a reused pass) has been fully preprocessed on this thread.
#[cfg(any(test, feature = "codegen_test"))]
std::thread_local! {
    pub(crate) static FULL_SOURCE_PASSES: Cell<usize> = const { Cell::new(0) };
}

/// Windows PE subsystem selector, mirroring `<winnt.h>`'s
/// `IMAGE_SUBSYSTEM_*`. The PE writer reads it for the optional
/// header's `Subsystem` field and for the entry stub:
///
/// * `Console` / `Windows` take a CRT stub importing
///   `msvcrt!__getmainargs` / `msvcrt!exit`, which calls the entry with
///   `(argc, argv)` or the WinMain argument set.
/// * `Native` (alias `driver`) and the `Efi*` kinds take no stub: the
///   loader invokes the entry directly with the platform signature
///   (`NtProcessStartup(PPEB)`, `DriverEntry(PDRIVER_OBJECT,
///   PUNICODE_STRING)`, `(EFI_HANDLE, EFI_SYSTEM_TABLE *)`), so
///   `AddressOfEntryPoint` points at the user's function.
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

/// C99 5.2.4.2.2 floating-point characteristics in the gcc / clang
/// `__FLT_*` / `__DBL_*` / `__LDBL_*` spellings, which third-party
/// headers test directly and `<float.h>` derives its own names from.
/// `float` is IEEE binary32 and `double` binary64 everywhere; the
/// `__LDBL_*` row follows the target ABI's `long double` (x87 80-bit
/// on System V x86-64, binary128 on AAPCS64 ELF, binary64 elsewhere),
/// matching gcc per target.
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
/// as i386: `__i386__` for `__x86_64__`, ILP32 for LP64, 32-bit
/// pointer / `long` / `size_t` / `wchar_t`, no `__int128`, and
/// `__code_model_32__`. `Elf32` never reaches an AArch64 target, which
/// would mean AArch32; the driver refuses the flag there.
///
/// `short_wchar` is `-fshort-wchar`; see [`Target::wchar_type`].
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

/// The targets one predefine row covers.
#[derive(Clone, Copy)]
enum PredefOn {
    Every,
    Aarch64,
    X86_64,
    MacOS,
    Linux,
    Windows,
    /// Targets whose plain `char` is unsigned. C99 6.2.5p15 leaves the
    /// choice to the implementation; gcc and clang report it here.
    UnsignedChar,
}

impl PredefOn {
    fn covers(self, target: Target) -> bool {
        match self {
            PredefOn::Every => true,
            PredefOn::Aarch64 => matches!(
                target,
                Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64
            ),
            PredefOn::X86_64 => target.is_x86_64(),
            PredefOn::MacOS => matches!(target, Target::MacOSAarch64),
            PredefOn::Linux => matches!(target, Target::LinuxAarch64 | Target::LinuxX64),
            PredefOn::Windows => matches!(target, Target::WindowsX64 | Target::WindowsAarch64),
            PredefOn::UnsignedChar => !target.plain_char_signed(),
        }
    }
}

/// Object-like predefines with a fixed replacement list, grouped by the
/// targets they cover. Naming follows the gcc / clang / msvc convention
/// of double underscores around tool-supplied macros so they cannot
/// collide with user identifiers. Predefines whose spelling or value
/// follows the unit's model are installed by
/// [`install_float_characteristics`] and [`install_data_model`] instead,
/// which own those names; the GCC identity set is opt-in through
/// [`Preprocessor::enable_gnu`].
static PREDEFINES: &[(PredefOn, &[(&str, &str)])] = &[
    (
        PredefOn::Every,
        &[
            // C99 6.10.8. `__DATE__` / `__TIME__` carry badc's own
            // build time, the translation time for an embedded library.
            // `__STDC_HOSTED__` holds because every target binds the
            // host libc. `__STDC_VERSION__` reports C11: the surface is
            // C99 plus the C11 features real code gates on this macro.
            ("__STDC__", "1"),
            ("__STDC_HOSTED__", "1"),
            ("__STDC_VERSION__", "201112L"),
            ("__DATE__", concat!("\"", env!("BADC_BUILD_DATE"), "\"")),
            ("__TIME__", concat!("\"", env!("BADC_BUILD_TIME"), "\"")),
            // C11 6.10.8.3: one macro per optional feature the
            // implementation lacks, which library code gates a portable
            // fallback on. `__STDC_NO_THREADS__` stays undefined
            // although badc ships no `<threads.h>`: real code gates
            // `_Thread_local` on it, and that badc does support.
            // `<stdatomic.h>` and C99 6.7.6.2 variable-length arrays are
            // provided, so their macros stay undefined too.
            ("__STDC_NO_COMPLEX__", "1"),
            // C11 6.10.8.2: `char16_t` / `char32_t` hold the UTF-16 /
            // UTF-32 code units of the character, which is what `u"..."`
            // and `U"..."` encode here.
            ("__STDC_UTF_16__", "1"),
            ("__STDC_UTF_32__", "1"),
            // Memory-order arguments to the `__atomic_*` builtins, in
            // GCC's encoding. badc always emits sequential consistency,
            // so the values only have to satisfy the source's own `#if`
            // and comparison uses.
            ("__ATOMIC_RELAXED", "0"),
            ("__ATOMIC_CONSUME", "1"),
            ("__ATOMIC_ACQUIRE", "2"),
            ("__ATOMIC_RELEASE", "3"),
            ("__ATOMIC_ACQ_REL", "4"),
            ("__ATOMIC_SEQ_CST", "5"),
            // Byte order (GCC/clang form); every supported target is
            // little-endian. gcc and clang also define
            // `__LITTLE_ENDIAN__` there, which byte-order-detecting code
            // commonly gates on directly rather than comparing
            // `__BYTE_ORDER__`. `__BIG_ENDIAN__` stays undefined.
            ("__ORDER_LITTLE_ENDIAN__", "1234"),
            ("__ORDER_BIG_ENDIAN__", "4321"),
            ("__ORDER_PDP_ENDIAN__", "3412"),
            ("__BYTE_ORDER__", "__ORDER_LITTLE_ENDIAN__"),
            ("__LITTLE_ENDIAN__", "1"),
            // Type sizes no data model moves; the rest come from
            // `install_data_model`. C99 5.2.4.2.1 fixes CHAR_BIT at 8
            // on every supported target.
            ("__CHAR_BIT__", "8"),
            ("__SIZEOF_SHORT__", "2"),
            ("__SIZEOF_INT__", "4"),
            ("__SIZEOF_LONG_LONG__", "8"),
            ("__SIZEOF_FLOAT__", "4"),
            ("__SIZEOF_DOUBLE__", "8"),
            // `wint_t` is the bundled <wchar.h>'s `int` everywhere.
            ("__WINT_TYPE__", "int"),
            ("__SIZEOF_WINT_T__", "4"),
            // C11 6.4.4.4p2-p4 / 7.28: `char16_t` is `uint_least16_t`
            // and `char32_t` is `uint_least32_t`, the types `u'c'` and
            // `U'c'` take. Neither tracks `wchar_t`.
            ("__CHAR16_TYPE__", "unsigned short"),
            ("__CHAR32_TYPE__", "unsigned int"),
            // The largest fundamental alignment: what a bare
            // `__attribute__((aligned))` resolves to and where `__int128`
            // and 16-aligned automatics are placed.
            ("__BIGGEST_ALIGNMENT__", "16"),
        ],
    ),
    (
        PredefOn::Aarch64,
        // `__arm64__` is the Apple/clang spelling. `__AARCH64EL__`
        // reports the little-endian variant, which arch-dispatch code
        // keys its aarch64 branch on.
        &[
            ("__aarch64__", "1"),
            ("__arm64__", "1"),
            ("__AARCH64EL__", "1"),
        ],
    ),
    (
        PredefOn::X86_64,
        // x86 named address spaces (`int __seg_gs *p`): gcc predefines
        // these where the qualifiers are available, and an access through
        // one rides a segment-override prefix.
        &[("__SEG_FS", "1"), ("__SEG_GS", "1")],
    ),
    (PredefOn::UnsignedChar, &[("__CHAR_UNSIGNED__", "1")]),
    (
        PredefOn::MacOS,
        &[
            ("__APPLE__", "1"),
            ("__MACH__", "1"),
            // Deployment target, decimal MMmmpp. Matches the 11.0
            // minimum OS version stamped into LC_BUILD_VERSION;
            // <AvailabilityMacros.h> derives its version gates from it.
            ("__ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__", "110000"),
        ],
    ),
    (
        PredefOn::Linux,
        &[
            ("__linux__", "1"),
            ("__unix__", "1"),
            // badc links the GNU C library on Linux, so source gating a
            // glibc-only feature (pthread_getattr_np, __GLIBC_PREREQ)
            // keys on these instead of a degraded fallback, as it would
            // for a gcc/clang build here. A 2.17 baseline.
            ("__GLIBC__", "2"),
            ("__GLIBC_MINOR__", "17"),
            // The feature-test state glibc's <features.h> derives with
            // no request macro set. The bundled headers stand in for
            // glibc's, so it has to come from here or a header keying
            // on it misreads the environment. Installed before the CLI's
            // lists, so `-D` / `-U` win.
            ("_DEFAULT_SOURCE", "1"),
            ("_POSIX_SOURCE", "1"),
            ("_POSIX_C_SOURCE", "200809L"),
        ],
    ),
    (
        PredefOn::Windows,
        // `_WIN64` holds because both Windows targets are 64-bit.
        // `__int8/16/32/64` are mingw-gcc builtins used by essentially
        // all Windows API code, so they belong to the target surface;
        // the rest of the MSVC mimicry (`_MSC_VER`, `__MINGW32__`, the
        // `__declspec(x)` decorators, the SAL annotations) stays in the
        // opt-in `msvc_compat.h`.
        &[
            ("_WIN32", "1"),
            ("_WIN64", "1"),
            ("__BADC_WINDOWS__", "1"),
            ("__int8", "char"),
            ("__int16", "short"),
            ("__int32", "int"),
            ("__int64", "long long"),
        ],
    ),
];

/// One predefine whose replacement list depends on the target or on the
/// build driver's arguments.
type DerivedPredef = (&'static str, fn(&PredefEnv<'_>) -> String);

/// Comparing the string-literal rows below with `#if X == "..."` is a c5
/// extension over C99 6.10.1p4, which restricts a `#if` controlling
/// expression to an integer constant expression; see
/// doc/std-conformance.md.
static DERIVED_PREDEFINES: &[DerivedPredef] = &[
    ("__BADC_VERSION__", |e| format!("\"{}\"", e.crate_version)),
    ("__BADC_TARGET__", |e| format!("\"{}\"", e.target_spec)),
    // `long double` takes the target ABI's storage size.
    // `__SIZEOF_FLOAT80__` and `__SIZEOF_FLOAT128__` stay undefined with
    // the types absent.
    ("__SIZEOF_LONG_DOUBLE__", |e| {
        e.target.long_double().size().to_string()
    }),
];

/// What a [`DERIVED_PREDEFINES`] body reads.
struct PredefEnv<'a> {
    target: Target,
    target_spec: &'a str,
    crate_version: &'a str,
}

/// Function-like predefines. The `__counted_by` family is a GCC 15 /
/// Clang bounds hint badc does not implement; empty is the fallback the
/// kernel UAPI headers take when the compiler lacks it, and
/// `__has_attribute(counted_by)` reports 0 to match.
/// `__builtin_expect(exp, c)` is a GCC builtin needing no header, its
/// value the first operand; it is here so a unit that never triggers
/// the `<_builtins.h>` auto-include still compiles.
static PREDEFINED_FN_MACROS: &[(&str, &[&str], &str)] = &[
    ("__counted_by", &["m"], ""),
    ("__counted_by_le", &["m"], ""),
    ("__counted_by_be", &["m"], ""),
    ("__builtin_expect", &["exp", "c"], "(exp)"),
];

impl Preprocessor {
    /// Build a preprocessor with the standard predefines installed:
    /// the [`PREDEFINES`] table for this target, the derived rows, the
    /// target's floating-point characteristics and data model, and the
    /// function-like set.
    pub fn new(target_spec: &str, target: Target, crate_version: &str) -> Self {
        let env = PredefEnv {
            target,
            target_spec,
            crate_version,
        };
        let mut macros: HashMap<String, String> = HashMap::new();
        for (on, rows) in PREDEFINES {
            if on.covers(target) {
                for (name, body) in *rows {
                    macros.insert((*name).to_string(), (*body).to_string());
                }
            }
        }
        for (name, body) in DERIVED_PREDEFINES {
            macros.insert((*name).to_string(), body(&env));
        }
        install_float_characteristics(&mut macros, target);
        install_data_model(
            &mut macros,
            target,
            ElfClass::Elf64,
            CodeModel::Small,
            false,
        );
        let fn_macros: HashMap<String, FnMacro> = PREDEFINED_FN_MACROS
            .iter()
            .map(|(name, params, body)| {
                (
                    (*name).to_string(),
                    FnMacro {
                        params: params.iter().map(|p| (*p).to_string()).collect(),
                        body: (*body).to_string(),
                        is_variadic: false,
                        va_name: None,
                    },
                )
            })
            .collect();
        let intrinsics: alloc::collections::BTreeMap<String, i64> = builtins::preseeded(target)
            .map(|(name, id)| (name.to_string(), id))
            .collect();
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
            sink: Sink::default(),
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
            warn_disabled: BTreeSet::new(),
            diag_pragmas: 0,
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

    /// Define the GCC identity macros (`--gnu`), which badc claims only
    /// on request: it implements most of the GNU C surface but not all
    /// of it. Exactly one of `__GNUC_STDC_INLINE__` /
    /// `__GNUC_GNU_INLINE__` reports the inline linkage model headers
    /// key their inline declarations on. `__STRICT_ANSI__` accompanies
    /// `__GNUC__` as under `gcc -std=c11`, so portable code takes the
    /// standard path for the GNU-only features badc lacks.
    pub fn enable_gnu(&mut self, gnu89_inline: bool, strict_ansi: bool) {
        // `crate::GNU_COMPAT_VERSION` claims 4.3.0, every feature of
        // which is backed. What 4.4 adds and real code selects on the
        // version -- per-function `__attribute__((target(...)))` and the
        // x86 intrinsic headers over the SSE2 / SSSE3 / SSE4.1 / AES-NI
        // / PCLMUL / RDRAND subset -- is backed as well.
        // TODO: raise the claim. That needs a forced-claim measurement
        // over a corpus at each rung above 4.4, not only at the
        // intrinsic surface.
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
        self.fail_on_errors()?;
        Ok(out)
    }

    /// Fail the pass when a diagnostic resolved to `Error`, which is
    /// what a `#pragma`-raised level asks for. Reported at the end of
    /// the pass rather than at the site, so the unit is read whole
    /// first.
    fn fail_on_errors(&self) -> Result<(), C5Error> {
        if !self.sink.has_errors() {
            return Ok(());
        }
        match self
            .sink
            .diagnostics()
            .iter()
            .find(|d| d.level == Level::Error)
        {
            Some(first) => Err(C5Error::Compile(first.to_string())),
            None => Ok(()),
        }
    }

    /// Process one synthesized `#include "name"` per `-include FILE`
    /// ahead of the user's source, through the same machinery a written
    /// `#include` takes, so a failure inside such a header names that
    /// header. The synthesized buffer is labelled `<force-include>`, so
    /// a diagnostic on one of its lines does not claim a line of the
    /// user's source.
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
        let n_warnings = self.sink.diagnostics().len();
        let n_records = self.include_records.len();
        let entry_macros = self.macros.clone();
        let entry_fn_macros = self.fn_macros.clone();
        let entry_once = self.pragma_once_files.clone();
        let entry_guards = self.include_guards.clone();
        let entry_counter = self.counter.get();
        let entry_warn_disabled = self.warn_disabled.clone();
        let entry_diag_pragmas = self.diag_pragmas;
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
            warn_disabled: entry_warn_disabled,
            diag_pragmas: self.diag_pragmas != entry_diag_pragmas,
            filter: rec.filter,
            counter_used: rec.counter_used.get(),
            consulted_includes: rec.consulted_includes,
            pragma_events: rec.pragma_events,
            warnings: self.sink.diagnostics()[n_warnings..].to_vec(),
            include_records: self.include_records[n_records..].to_vec(),
        };
        self.fail_on_errors()?;
        Ok((out, cache))
    }

    /// Run `process` for a force-include list extending the one `prior`
    /// was recorded under, reusing `prior`'s source pass when the
    /// extension cannot change it. `None` when that cannot be shown, and
    /// the caller runs a full pass on a fresh preprocessor; on `Some`,
    /// this preprocessor's side outputs are what a full run would leave.
    ///
    /// Beyond its own text and the filesystem, the source pass reads the
    /// macro tables, the once / include-guard registries, the
    /// `__COUNTER__` position and the pragma-warning state, and appends
    /// to the side outputs. Each read is checked below against what the
    /// recorded pass observed; the appends are replayed.
    pub(crate) fn process_reusing(&mut self, prior: &PpReuse) -> Option<String> {
        let mut out = String::new();
        self.process_preamble(&mut out).ok()?;
        if self.counter.get() != prior.counter && prior.counter_used {
            return None;
        }
        if self.warn_disabled != prior.warn_disabled {
            return None;
        }
        // The recorded pass's diagnostic pragmas are keyed on output
        // offsets, which this run's longer preamble shifts.
        if prior.diag_pragmas {
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
            let site = Site {
                file,
                line: *line,
                offset: out.len() as u32,
            };
            self.parse_pragma(args, site).ok()?;
        }
        for warning in &prior.warnings {
            self.sink.record(warning.clone());
        }
        self.include_records
            .extend(prior.include_records.iter().cloned());
        out.push_str(&prior.source_text);
        // A replayed diagnostic that resolved to an error has to fail
        // the unit; the caller's full pass reports it.
        self.fail_on_errors().ok()?;
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

    /// Report a diagnostic, resolved against the command line and the
    /// diagnostic pragmas recorded up to `site`. The pass reads the
    /// unit in output order, so every pragma that can cover `site` is
    /// already recorded when this runs.
    pub(crate) fn warn(&mut self, code: Code, site: Site<'_>, text: String) {
        self.sink.emit(code, Some(site.loc()), text);
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
        // C99 5.1.1.2 phases 2 and 3, fused into one scan: every `\\\n`
        // joins lines so the line-by-line preprocessor never sees a
        // continuation, and comments are removed before substitution so
        // a `#define X 0 /* note */` body cannot emit a stray `*/` into
        // a surrounding comment. A blank line per consumed continuation
        // preserves the one-for-one line count that `__LINE__` and every
        // diagnostic depend on.
        let stripped = unfold_and_strip(source);
        out.reserve(stripped.len());
        let mut pass = LinePass::new(self, out, filename, &stripped);
        pass.run()?;
        pass.finish()
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
        site: Site<'_>,
    ) -> Result<Option<bool>, C5Error> {
        let (diag, filename) = (site.line, site.file);
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
                    return Err(C5Error::at(
                        Code::ERROR_DIRECTIVE,
                        filename,
                        diag,
                        format!("#error {}", message.trim()),
                    ));
                }
                active
            }
            // gcc/clang extension, standardised in C23: same shape as
            // `#error` but compilation continues.
            Directive::Warning(message) => {
                if active {
                    self.warn(
                        WARNING_DIRECTIVE,
                        site,
                        format!("#warning {}", message.trim()),
                    );
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

/// The catalogue rows this pass reports. `preprocessor_codes_are_live`
/// checks each against the catalogue.
pub(crate) const UNKNOWN_DIRECTIVE: Code = Code::new(1001);
pub(crate) const WARNING_DIRECTIVE: Code = Code::new(1002);
pub(crate) const MALFORMED_DIRECTIVE: Code = Code::new(1003);
pub(crate) const UNKNOWN_PRAGMA: Code = Code::new(1004);
pub(crate) const PRAGMA_SYNTAX: Code = Code::new(1005);
pub(crate) const PRAGMA_POP_WITHOUT_PUSH: Code = Code::new(1006);
pub(crate) const UNKNOWN_WARNING_OPTION: Code = Code::new(7002);

/// Where a diagnostic from this pass points: the buffer's name and the
/// line within it, plus the position in the output that the diagnostic
/// pragmas resolve on.
#[derive(Clone, Copy)]
pub(crate) struct Site<'a> {
    pub file: &'a str,
    pub line: usize,
    pub offset: u32,
}

impl Site<'_> {
    fn loc(&self) -> Loc {
        Loc::in_unit(self.file, self.line as u32, self.offset)
    }
}

/// Whether a directive arm produced this line's output itself. When it
/// did not, the line becomes a blank filler so the output keeps one line
/// per input line.
#[derive(PartialEq)]
enum Emitted {
    Yes,
    No,
}

/// One pass of the line loop over one buffer: the output being built,
/// the conditional stack, and the presumed-location bookkeeping the
/// directive handlers share.
struct LinePass<'p, 's> {
    pp: &'p mut Preprocessor,
    out: &'p mut String,
    /// Physical buffer name: `#pragma once` identity and the file a
    /// diagnostic from this buffer names.
    filename: &'s str,
    /// File reported to the lexer. Starts at `filename`; a `#line N
    /// "other"` retargets it, and every later `#include` boundary in
    /// this buffer then restores to that name. The amalgamator depends
    /// on it: a `#line 1 "real.c"` at the top of a glued-in unit has to
    /// survive that unit's own includes.
    current_file: String,
    /// Presumed line number of the line about to be processed (C99
    /// 6.10.4). Not `idx + 1`: a `#line N` resets the lexer's counter,
    /// and a marker written in physical-buffer coordinates after that
    /// would shift every later attribution.
    presumed: usize,
    lines: Vec<&'s str>,
    idx: usize,
    /// Open `#if` / `#ifdef` frames, innermost last.
    cond: Vec<CondFrame>,
    active: bool,
    /// Watches for the `#ifndef X` / `#endif` wrapper that lets a repeat
    /// `#include` of this file be dropped; see `include_guards`.
    guard: IncludeGuardScan,
}

impl<'p, 's> LinePass<'p, 's> {
    fn new(
        pp: &'p mut Preprocessor,
        out: &'p mut String,
        filename: &'s str,
        source: &'s str,
    ) -> Self {
        // A leading marker attributes this buffer's tokens to
        // `(filename, 1)`. The lexer's `parse_line_marker` reads both
        // this GNU shape and the C99 `#line N "file"`.
        out.push_str(&format_line_marker(1, filename));
        LinePass {
            pp,
            out,
            filename,
            current_file: filename.into(),
            presumed: 1,
            // Manual line indexing so a function-like macro call
            // spanning several lines can be joined before substitution.
            lines: source.lines().collect(),
            idx: 0,
            cond: Vec::new(),
            active: true,
            guard: IncludeGuardScan::default(),
        }
    }

    fn run(&mut self) -> Result<(), C5Error> {
        while self.idx < self.lines.len() {
            let line = self.lines[self.idx];
            let line_no = self.idx + 1;
            // A `#pragma warning(suppress: N)` on an earlier line
            // covers this one; its extent ends where this line's
            // output does.
            let closing = self.pp.sink.control().has_open_suppress();
            let hash = line.trim_start().strip_prefix('#').map(|rest| {
                let spelling = rest.trim_start();
                (spelling, parse_directive(spelling, self.pp.asm_source))
            });
            // Assembler-with-cpp: a `#` line naming no directive is
            // text, not a directive; it passes through with its tail
            // macro-expanded, as GNU cpp emits it for assembler input.
            let asm_text =
                self.pp.asm_source && matches!(&hash, Some((s, Directive::Other)) if !s.is_empty());
            let depth = self.cond.len();
            match hash {
                Some((spelling, parsed)) if !asm_text => {
                    self.guard.line(line, Some(&parsed), depth);
                    self.directive(&parsed, spelling, line_no)?;
                }
                _ => {
                    self.guard.line(line, None, depth);
                    self.content(line)?;
                }
            }
            if closing {
                let end = self.out.len() as u32;
                self.pp.sink.control_mut().close_suppress(end);
            }
        }
        Ok(())
    }

    fn finish(self) -> Result<(), C5Error> {
        // A `suppress` on the buffer's last line has nothing left to
        // cover once the buffer ends.
        let end = self.out.len() as u32;
        self.pp.sink.control_mut().close_suppress(end);
        self.pp.take_pending_error()?;
        let depth = self.cond.len();
        if depth > 0 {
            return Err(C5Error::at(
                Code::DIRECTIVE,
                self.filename,
                self.presumed,
                "preprocessor: unterminated `#if` / `#ifdef` block",
            ));
        }
        // Only files reached through `#include` can be re-included, and
        // only they have a resolved path to key on.
        if !self.pp.include_stack.is_empty()
            && let Some(name) = self.guard.finish(depth)
        {
            self.pp
                .include_guards
                .insert(self.filename.to_string(), name);
        }
        Ok(())
    }

    /// Where a diagnostic raised while handling the line at `line_no`
    /// points. The offset is where the output stands, which is where
    /// this line's text is about to go.
    fn site(&self, line_no: usize) -> Site<'s> {
        Site {
            file: self.filename,
            line: line_no,
            offset: self.out.len() as u32,
        }
    }

    /// A blank filler for a directive or an inactive line, keeping the
    /// output's line count equal to the input's.
    fn blank(&mut self) {
        self.out.push('\n');
        self.presumed += 1;
    }

    /// A line marker for the presumed file at `line`.
    fn marker(&mut self, line: usize) {
        let marker = format_line_marker(line, &self.current_file);
        self.out.push_str(&marker);
    }

    fn directive(
        &mut self,
        parsed: &Directive<'_>,
        spelling: &str,
        line_no: usize,
    ) -> Result<(), C5Error> {
        let site = self.site(line_no);
        let emitted = match self.pp.apply_cond_or_macro_directive(
            parsed,
            self.active,
            &mut self.cond,
            self.presumed,
            site,
        )? {
            Some(next) => {
                self.active = next;
                Emitted::No
            }
            None => match parsed {
                Directive::Pragma(args) => self.pragma(args, spelling, site)?,
                Directive::IncludeMacro(args) => self.include_macro(args, line_no)?,
                Directive::Include { name, quoted } => {
                    self.include(name, *quoted, false, line_no)?
                }
                Directive::IncludeNext { name, quoted } => {
                    self.include(name, *quoted, true, line_no)?
                }
                Directive::Line { line, file } => self.line_directive(*line, *file),
                Directive::LineMacro(args) => self.line_macro(args, line_no),
                Directive::Other => {
                    self.unknown(spelling, line_no);
                    Emitted::No
                }
                // A first-line `#!/usr/bin/env badc`: no preprocessor
                // semantics, just skipped.
                Directive::Shebang => Emitted::No,
                // Spelled out rather than `_` so a new variant is a
                // compile error here as well as in
                // `apply_cond_or_macro_directive`, which consumed
                // every one of these.
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
            },
        };
        if emitted == Emitted::No {
            self.blank();
        }
        self.idx += 1;
        Ok(())
    }

    fn pragma(&mut self, args: &str, spelling: &str, site: Site<'_>) -> Result<Emitted, C5Error> {
        if !self.active {
            return Ok(Emitted::No);
        }
        match parse_pragma_directive(args) {
            PragmaDirective::Once => {
                let filename = self.filename.to_string();
                self.pp.pragma_once_files.insert(filename);
            }
            // `#pragma pack(...)` and `#pragma GCC visibility ...` bind
            // to their source position: a struct after `pack(1)` packs
            // at 1, one after the next `pack()` does not. Batching them
            // through the preprocessor's accumulators would lose that
            // order, so the line passes through and the lexer folds it
            // into its `pack_stack` / `visibility_stack` in place.
            PragmaDirective::Other if pragma_is_pack(args) || pragma_is_visibility(args) => {
                self.out.push('#');
                self.out.push_str(spelling);
                self.out.push('\n');
                self.presumed += 1;
                return Ok(Emitted::Yes);
            }
            PragmaDirective::Other => {
                self.pp.parse_pragma(args, site)?;
            }
        }
        Ok(Emitted::No)
    }

    /// `#include` / `#include_next` with a literal header name. The
    /// closing marker restores the *presumed* location: `source_line`
    /// tracks what the lexer's counter reflects after the last marker
    /// emitted, which a `#line` in this buffer may have retargeted.
    fn include(
        &mut self,
        name: &str,
        quoted: bool,
        next: bool,
        line_no: usize,
    ) -> Result<Emitted, C5Error> {
        if !self.active {
            return Ok(Emitted::No);
        }
        if next {
            self.pp
                .process_include_next(name, line_no, self.filename, quoted, self.out)?;
        } else {
            self.pp
                .process_include(name, line_no, self.filename, quoted, self.out)?;
        }
        self.presumed += 1;
        self.marker(self.presumed);
        Ok(Emitted::Yes)
    }

    /// C99 6.10.2p4: expand the operand and reparse the result as a
    /// `<...>` / `"..."` header name. Anything else is malformed;
    /// warn and skip, as for an unrecognised directive. The
    /// spelling-faithful expansion keeps re-lex separators out of the
    /// header name.
    fn include_macro(&mut self, args: &str, line_no: usize) -> Result<Emitted, C5Error> {
        if !self.active {
            return Ok(Emitted::No);
        }
        let expanded = self.pp.substitute_spelling(args, self.filename, line_no);
        let trimmed = expanded.trim();
        let Some((name, quoted)) = header_name(trimmed) else {
            let site = self.site(line_no);
            self.pp.warn(
                MALFORMED_DIRECTIVE,
                site,
                format!(
                    "#include `{args}` expands to `{trimmed}`, \
                     which is not a `<header>` or `\"header\"` literal"
                ),
            );
            return Ok(Emitted::No);
        };
        self.include(name, quoted, false, line_no)
    }

    /// C99 6.10.4: `#line N` retargets the next line's number, and with
    /// `"file"` the reported file too; a bare `#line N` keeps the file.
    /// The marker replaces the directive line, one for one.
    fn line_directive(&mut self, line: usize, file: Option<&str>) -> Emitted {
        if !self.active {
            return Emitted::No;
        }
        if let Some(f) = file {
            self.current_file = f.into();
        }
        self.marker(line);
        self.presumed = line;
        Emitted::Yes
    }

    /// C99 6.10.4 with an operand that is no digit sequence: expand,
    /// then reparse as `#line N ["file"]`. A result that still does not
    /// lead with a digit sequence is malformed; warn and skip.
    fn line_macro(&mut self, args: &str, line_no: usize) -> Emitted {
        if !self.active {
            return Emitted::No;
        }
        let expanded = self.pp.substitute(args, self.filename, line_no);
        let trimmed = expanded.trim();
        let mut split = trimmed.splitn(2, char::is_whitespace);
        if let Some(num) = split.next()
            && let Ok(line) = num.parse::<usize>()
        {
            if let Some(f) = split.next().and_then(|tail| {
                let t = tail.trim();
                t.strip_prefix('"').and_then(|s| s.strip_suffix('"'))
            }) {
                self.current_file = f.into();
            }
            self.marker(line);
            self.presumed = line;
            return Emitted::Yes;
        }
        let site = self.site(line_no);
        self.pp.warn(
            MALFORMED_DIRECTIVE,
            site,
            format!("#line `{args}` expands to `{trimmed}`, which is not a line number"),
        );
        Emitted::No
    }

    /// C99 6.10.6 reserves every non-directive `#` form for the
    /// implementation; gcc and clang warn and drop the line, and c5
    /// names the dropped directive in the warning. A bare `#` is the
    /// 6.10p9 null directive: consumed without effect or diagnostic.
    fn unknown(&mut self, spelling: &str, line_no: usize) {
        if !self.active || spelling.is_empty() {
            return;
        }
        let kw = spelling
            .split(|c: char| !c.is_ascii_alphanumeric() && c != '_')
            .next()
            .unwrap_or("");
        let label = if kw.is_empty() {
            "(empty)".to_string()
        } else {
            format!("`#{kw}`")
        };
        let site = self.site(line_no);
        self.pp.warn(
            UNKNOWN_DIRECTIVE,
            site,
            format!("unknown preprocessor directive {label} -- ignoring"),
        );
    }

    /// A content line: join what a multi-line macro invocation spans,
    /// substitute, and resolve any `_Pragma` operator (C99 6.10.9).
    fn content(&mut self, line: &str) -> Result<(), C5Error> {
        if !self.active {
            self.blank();
            self.idx += 1;
            return Ok(());
        }
        let (buffer, consumed) = self.join_invocation(line)?;
        // `__LINE__` reflects the presumed line, which a `#line` can
        // retarget (C99 6.10.4); absent one it is the physical line.
        let substituted = self.pp.substitute(&buffer, self.filename, self.presumed);
        let site = self.site(self.presumed);
        let processed = self.pp.apply_pragma_operators(&substituted, site)?;
        self.out.push_str(&processed);
        // One newline for the line itself, one per joined continuation,
        // so source line numbering survives the join.
        for _ in 0..consumed {
            self.out.push('\n');
        }
        self.presumed += consumed;
        self.idx += consumed;
        Ok(())
    }

    /// Join the lines a function-like macro invocation spans into one
    /// buffer, returning it and the input lines consumed; per-line
    /// substitution would leave the call's `(` unmatched.
    ///
    /// A directive inside the argument list works on the same
    /// conditional stack as a top-level one, so an `#if` opened there
    /// may close after the call's `)` and the reverse. C99 6.10.3p11
    /// leaves the case undefined; gcc and clang process such directives
    /// as if the invocation were not present. Directive lines never
    /// become argument text; content lines join only while the current
    /// branch is active.
    fn join_invocation(&mut self, first: &str) -> Result<(String, usize), C5Error> {
        let mut buffer = String::from(first);
        let mut consumed = 1usize;
        // The scan advances over appended bytes only; re-scanning the
        // grown buffer per joined line is quadratic in the invocation.
        let mut join = JoinScan::new();
        join.feed(&buffer, self.pp);
        while self.idx + consumed < self.lines.len()
            && (join.unclosed()
                // A function-like macro name at the end of a line with
                // its `(` on the next is still an invocation (C99
                // 6.10.3: white space, newlines included, may separate
                // the name from its `(`).
                || (join.pending_head()
                    && self.lines[self.idx + consumed].trim_start().starts_with('(')))
        {
            let cont = self.lines[self.idx + consumed];
            consumed += 1;
            let dline = self.presumed + consumed - 1;
            if let Some(rest) = cont.trim_start().strip_prefix('#') {
                let parsed = parse_directive(rest.trim_start(), self.pp.asm_source);
                // TODO: `#include`, `#line` and `#pragma` inside an
                // argument list are consumed without effect; their
                // output would have to interleave with the joined
                // expansion.
                let site = self.site(dline);
                if let Some(next) = self.pp.apply_cond_or_macro_directive(
                    &parsed,
                    self.active,
                    &mut self.cond,
                    dline,
                    site,
                )? {
                    self.active = next;
                }
            } else if self.active {
                let appended = buffer.len();
                buffer.push('\n');
                buffer.push_str(cont);
                join.feed(&buffer[appended..], self.pp);
            }
        }
        Ok((buffer, consumed))
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
