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
//! * `#pragma intrinsic("name")` -- mark a name (e.g. `alloca`) as a
//!   compiler intrinsic.

use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::{String, ToString};

use alloc::vec::Vec;
use core::cell::{Cell, RefCell};
use hashbrown::HashMap;

use super::codegen::Target;
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
#[derive(Debug, Clone)]
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
    fn_macros: HashMap<String, FnMacro>,
    /// One entry per `#pragma dylib(name, "path")`, in the order
    /// declared. Each entry collects the bindings whose
    /// `name::c4_fn` qualifier referenced its [`DylibSpec::name`].
    pub dylibs: Vec<DylibSpec>,
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
    /// Headers that opted in to single-inclusion via `#pragma once`.
    /// A subsequent `#include` of a name in this set is dropped.
    pragma_once_files: BTreeSet<String>,
    /// Names of headers currently being expanded, used to break
    /// cycles. Pushed on `#include`, popped when we finish processing
    /// the header.
    include_stack: Vec<String>,
    /// Filesystem search paths for `#include`. Probed in order
    /// before falling back to the bundled in-binary headers, so
    /// a user can `cp $(badc --dump-headers) ./include/...` and
    /// override one without rebuilding badc. Plumbed in from the
    /// CLI's `-I path` flag and any built-in defaults
    /// (`./include`, `./libc/include`). Filesystem reads are
    /// gated behind `cfg(feature = "std")`; the no_std build
    /// keeps the field but never reads from it (the embedded
    /// headers are always available).
    search_paths: Vec<String>,
    /// Directories probed for `#include "..."` only (the gcc `-iquote`
    /// scope), after the including file's directory and before
    /// `search_paths`. An angle include never reads them.
    quote_search_paths: Vec<String>,
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
    system_fallback_paths: Vec<String>,
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
    /// Include-resolution trace. Populated only when
    /// [`Self::set_show_includes`] is on; matches gcc `-H`'s shape:
    /// one `". stdio.h"` / `".. stddef.h"` line per `#include`,
    /// where the leading dots mark nesting depth. The CLI's `-H` /
    /// `--show-includes` flag flushes this list to stderr after
    /// preprocessing finishes.
    pub include_trace: Vec<String>,
    /// `true` when the build driver asked for include tracing.
    /// Defaults to `false`; flipping it on costs one push to
    /// `include_trace` per `#include` resolve attempt and nothing
    /// else.
    show_includes: bool,
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
    /// std-conformance.md.
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
        // GCC bit-count / byte-swap builtins are available with no header
        // (they are compiler builtins, not library functions), matching
        // gcc/clang. The call-site lowering in the walker expands each to a
        // portable shift / mask sequence. __builtin_unreachable marks a
        // point control must not reach; it lowers to the trap intrinsic so
        // a reached unreachable aborts rather than continuing.
        let mut intrinsics: alloc::collections::BTreeMap<String, i64> =
            alloc::collections::BTreeMap::new();
        for (name, kind) in [
            ("__builtin_clz", super::op::Intrinsic::Clz),
            ("__builtin_ctz", super::op::Intrinsic::Ctz),
            ("__builtin_popcount", super::op::Intrinsic::Popcount),
            ("__builtin_clzll", super::op::Intrinsic::Clzll),
            ("__builtin_ctzll", super::op::Intrinsic::Ctzll),
            ("__builtin_popcountll", super::op::Intrinsic::Popcountll),
            ("__builtin_bswap16", super::op::Intrinsic::Bswap16),
            ("__builtin_bswap32", super::op::Intrinsic::Bswap32),
            ("__builtin_bswap64", super::op::Intrinsic::Bswap64),
            ("__builtin_clrsb", super::op::Intrinsic::Clrsb),
            ("__builtin_clrsbll", super::op::Intrinsic::Clrsbll),
            ("__builtin_parity", super::op::Intrinsic::Parity),
            ("__builtin_parityll", super::op::Intrinsic::Parityll),
            ("__builtin_ffs", super::op::Intrinsic::Ffs),
            ("__builtin_ffsll", super::op::Intrinsic::Ffsll),
            ("__builtin_unreachable", super::op::Intrinsic::Trap),
            (
                "__builtin_frame_address",
                super::op::Intrinsic::FrameAddress,
            ),
            (
                "__builtin_return_address",
                super::op::Intrinsic::ReturnAddress,
            ),
        ] {
            intrinsics.insert(name.to_string(), kind as i64);
        }
        // The `l` (long) bit-builtins operate on `unsigned long`, whose
        // width is the target's: 8 bytes on LP64 (so they match the
        // `ll` 64-bit intrinsics), 4 bytes on LLP64 (so they match the
        // plain 32-bit intrinsics).
        let (clzl, ctzl, popcountl) = if target.long_width_bytes() == 8 {
            (
                super::op::Intrinsic::Clzll,
                super::op::Intrinsic::Ctzll,
                super::op::Intrinsic::Popcountll,
            )
        } else {
            (
                super::op::Intrinsic::Clz,
                super::op::Intrinsic::Ctz,
                super::op::Intrinsic::Popcount,
            )
        };
        intrinsics.insert("__builtin_clzl".to_string(), clzl as i64);
        intrinsics.insert("__builtin_ctzl".to_string(), ctzl as i64);
        intrinsics.insert("__builtin_popcountl".to_string(), popcountl as i64);
        let clrsbl = if target.long_width_bytes() == 8 {
            super::op::Intrinsic::Clrsbll
        } else {
            super::op::Intrinsic::Clrsb
        };
        intrinsics.insert("__builtin_clrsbl".to_string(), clrsbl as i64);
        let parityl = if target.long_width_bytes() == 8 {
            super::op::Intrinsic::Parityll
        } else {
            super::op::Intrinsic::Parity
        };
        intrinsics.insert("__builtin_parityl".to_string(), parityl as i64);
        let ffsl = if target.long_width_bytes() == 8 {
            super::op::Intrinsic::Ffsll
        } else {
            super::op::Intrinsic::Ffs
        };
        intrinsics.insert("__builtin_ffsl".to_string(), ffsl as i64);
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
        // (`__int128` is absent), so it does not claim the macro by
        // default; code that gates a 128-bit path on `__GNUC__` plus a
        // 64-bit target would otherwise fail to compile.
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
            Target::LinuxX64 | Target::WindowsX64 => {
                macros.insert("__x86_64__".to_string(), "1".to_string());
                macros.insert("__amd64__".to_string(), "1".to_string());
            }
        }
        // GCC/Clang define `__CHAR_UNSIGNED__` exactly when plain
        // `char` is unsigned (C99 6.2.5p15 leaves it
        // implementation-defined). Headers branch on it to choose
        // sign-extension strategy, so mirror the target's choice.
        if !target.plain_char_signed() {
            macros.insert("__CHAR_UNSIGNED__".to_string(), "1".to_string());
        }
        // LP64 data model: 64-bit `long` and 64-bit pointer. GCC and
        // Clang predefine `__LP64__` and `_LP64` on every LP64 target,
        // and code that selects a 64-bit-wide integer type branches on
        // them. Windows is LLP64 (32-bit `long`), so it is excluded.
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::LinuxX64 => {
                macros.insert("__LP64__".to_string(), "1".to_string());
                macros.insert("_LP64".to_string(), "1".to_string());
            }
            Target::WindowsX64 | Target::WindowsAarch64 => {}
        }
        // GCC/Clang predefine the underlying type of size_t / ptrdiff_t /
        // intptr_t so headers can `typedef __SIZE_TYPE__ size_t;` without
        // knowing the data model. Spelling follows LP64 vs LLP64.
        let (size_ty, ptrdiff_ty) = match target {
            Target::WindowsX64 | Target::WindowsAarch64 => ("unsigned long long", "long long"),
            _ => ("unsigned long", "long"),
        };
        macros.insert("__SIZE_TYPE__".to_string(), size_ty.to_string());
        macros.insert("__PTRDIFF_TYPE__".to_string(), ptrdiff_ty.to_string());
        macros.insert("__INTPTR_TYPE__".to_string(), ptrdiff_ty.to_string());
        macros.insert("__UINTPTR_TYPE__".to_string(), size_ty.to_string());
        // GCC/Clang predefine each type's byte size so portable code can
        // select widths without <limits.h> (e.g. a pointer's bit width is
        // `__SIZEOF_POINTER__ * 8`). All badc targets are 64-bit, so the
        // pointer / size_t / ptrdiff_t sizes are 8; `long` and `wchar_t`
        // follow the data model (LLP64 Windows narrows both).
        macros.insert("__SIZEOF_SHORT__".to_string(), "2".to_string());
        macros.insert("__SIZEOF_INT__".to_string(), "4".to_string());
        macros.insert("__SIZEOF_LONG_LONG__".to_string(), "8".to_string());
        macros.insert("__SIZEOF_POINTER__".to_string(), "8".to_string());
        macros.insert("__SIZEOF_SIZE_T__".to_string(), "8".to_string());
        macros.insert("__SIZEOF_PTRDIFF_T__".to_string(), "8".to_string());
        macros.insert("__SIZEOF_FLOAT__".to_string(), "4".to_string());
        macros.insert("__SIZEOF_DOUBLE__".to_string(), "8".to_string());
        let (long_bytes, wchar_bytes) = match target {
            Target::WindowsX64 | Target::WindowsAarch64 => ("4", "2"),
            _ => ("8", "4"),
        };
        macros.insert("__SIZEOF_LONG__".to_string(), long_bytes.to_string());
        macros.insert("__SIZEOF_WCHAR_T__".to_string(), wchar_bytes.to_string());
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
            fn_macros,
            dylibs: Vec::new(),
            exports: Vec::new(),
            pragma_once_files: BTreeSet::new(),
            include_stack: Vec::new(),
            search_paths: Vec::new(),
            quote_search_paths: Vec::new(),
            system_fallback_paths: Vec::new(),
            force_includes: Vec::new(),
            source_label: "<source>".to_string(),
            warnings: Vec::new(),
            include_trace: Vec::new(),
            show_includes: false,
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
        }
    }

    /// Define the GCC identity macros (`--gnu`). badc claims `__GNUC__`
    /// only on request because it implements most, but not all, of the
    /// GNU C surface (`__int128` is absent). `__GNUC_STDC_INLINE__`
    /// reports ISO C99 inline semantics (not the GNU89 dialect);
    /// `__VERSION__` is the compiler-identification string embedded by
    /// code such as `Py_GetCompiler`. `__STRICT_ANSI__` reports strict
    /// ISO conformance alongside `__GNUC__`, exactly as
    /// `gcc`/`clang -std=c11` does, so portable code uses the standard
    /// path for the GNU-only features badc lacks.
    pub fn enable_gnu(&mut self) {
        self.macros.insert("__GNUC__".to_string(), "4".to_string());
        self.macros
            .insert("__GNUC_MINOR__".to_string(), "2".to_string());
        self.macros
            .insert("__GNUC_PATCHLEVEL__".to_string(), "1".to_string());
        self.macros
            .insert("__GNUC_STDC_INLINE__".to_string(), "1".to_string());
        self.macros
            .insert("__VERSION__".to_string(), "\"4.2.1\"".to_string());
        // badc backs the `__`-prefixed GNU extensions but not the ones a
        // GNU dialect gates on `!__STRICT_ANSI__` (`typeof` of an array,
        // `__int128`). Reporting strict ISO conformance alongside
        // `__GNUC__` -- exactly `gcc`/`clang -std=c11` -- routes portable
        // code to the standard path for those, while keeping the
        // `__`-prefixed surface available. (`__builtin_types_compatible_p`
        // is now backed by the compiler, so code gating on it works
        // regardless of this macro.)
        self.macros
            .insert("__STRICT_ANSI__".to_string(), "1".to_string());
    }

    /// Enable / disable gcc-`-H`-style include tracing. When on,
    /// every `#include` resolution -- successful or missing --
    /// emits a line into `include_trace`; the CLI's `-H` /
    /// `--show-includes` flag flushes the list to stderr after
    /// preprocessing.
    pub fn set_show_includes(&mut self, enabled: bool) {
        self.show_includes = enabled;
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
        if !self.search_paths.iter().any(|p| p == path) {
            self.search_paths.push(path.to_string());
        }
    }

    /// Append a `#include "..."`-only search path (the gcc `-iquote`
    /// scope). Probed after the including file's directory and before
    /// the `-I` paths; angle includes never read it.
    pub fn add_quote_path(&mut self, path: &str) {
        if !self.quote_search_paths.iter().any(|p| p == path) {
            self.quote_search_paths.push(path.to_string());
        }
    }

    /// Append a system header directory probed only after the bundled
    /// headers (see [`Preprocessor::system_fallback_paths`]). The
    /// driver adds the host's default system include directories here
    /// for a hosted native build, the way a compiler driver's implicit
    /// system include path resolves third-party headers without
    /// shadowing the standard headers.
    pub fn add_system_fallback_path(&mut self, path: &str) {
        if !self.system_fallback_paths.iter().any(|p| p == path) {
            self.system_fallback_paths.push(path.to_string());
        }
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
        // -include FILE plumbing: synthesize an `#include "name"`
        // line per registered force-include and process them as a
        // preamble before the user's source. Each force-include
        // header runs with the same line-counter / `__FILE__` /
        // search-path machinery as a regular `#include`, so a
        // failure inside the header (say a typo'd `#pragma`) gets
        // a diagnostic naming that header rather than the user's
        // source. The synthesized preamble itself uses
        // `<force-include>` as its filename label so any
        // diagnostic targeting one of the synthesized lines
        // points at that label and the line in the original
        // source isn't shifted from the user's perspective.
        if !self.force_includes.is_empty() {
            let mut preamble = String::new();
            for name in &self.force_includes.clone() {
                preamble.push_str(&format!("#include \"{name}\"\n"));
            }
            let mut combined = self.process_named(&preamble, "<force-include>")?;
            let label = self.source_label.clone();
            combined.push_str(&self.process_named(source, &label)?);
            return Ok(combined);
        }
        let label = self.source_label.clone();
        self.process_named(source, &label)
    }

    /// Recursive entry point. `filename` labels the buffer so error
    /// messages and `#pragma once` can name what they're talking
    /// about; the top-level call uses `"<source>"`, `#include`'d
    /// files use the header name (`"stdio.h"`).
    fn process_named(&mut self, source: &str, filename: &str) -> Result<String, C5Error> {
        // A UTF-8 byte-order mark opening the file is accepted and
        // skipped, following gcc and clang.
        let source = source.strip_prefix('\u{feff}').unwrap_or(source);
        // c99 sec 5.1.1.2 phase 2: every `\\\n` joins lines. We do this
        // up-front so the line-by-line preprocessor never sees a
        // continuation. Line counts are preserved by emitting blank
        // lines for each continuation consumed, so error messages
        // (and `__LINE__`) stay grounded in the original source.
        let unfolded = unfold_line_continuations(source);
        // c99 sec 5.1.1.2 phase 3: remove comments. Done before macro
        // substitution so a `#define X 0 /* note */` body doesn't
        // emit a stray `*/` into a surrounding source comment when
        // X is referenced from inside that comment. Inline-commented
        // numeric `#define`s referenced from doc-comment blocks are
        // a common pattern; without this pass the macro expansion's
        // `*/` closes the surrounding `/* ... */` early and the
        // lexer sees comment tail text as code.
        let stripped = strip_c_comments(&unfolded);
        let source = stripped.as_str();
        let mut out = String::with_capacity(source.len());

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
        while idx_iter < lines.len() {
            let idx = idx_iter;
            let line = lines[idx];
            let line_no = idx + 1;
            let trimmed = line.trim_start();

            if let Some(rest) = trimmed.strip_prefix('#') {
                let directive = rest.trim_start();
                match parse_directive(directive) {
                    Directive::Define(name, body) => {
                        if active {
                            self.macros.insert(name.to_string(), body.to_string());
                            self.fn_macros.remove(name);
                        }
                    }
                    Directive::DefineFn(name, mut params, body) => {
                        if active {
                            // A trailing `...` (C99 6.10.3) or the GCC
                            // named-rest form `name...` makes the macro
                            // variadic; the named form additionally binds
                            // the trailing arguments to `name`.
                            let mut is_variadic = false;
                            let mut va_name = None;
                            if let Some(last) = params.last().copied() {
                                if last == "..." {
                                    is_variadic = true;
                                    params.pop();
                                } else if let Some(prefix) = last.strip_suffix("...") {
                                    let prefix = prefix.trim();
                                    if is_ident(prefix) {
                                        is_variadic = true;
                                        va_name = Some(prefix.to_string());
                                        params.pop();
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
                    }
                    Directive::Undef(name) => {
                        if active {
                            self.macros.remove(name);
                            self.fn_macros.remove(name);
                        }
                    }
                    Directive::Ifdef(name) => {
                        // C99 6.10.1: `#ifdef` is true when the name is
                        // defined as any macro -- object-like or
                        // function-like.
                        let taken = active
                            && (self.macros.contains_key(name)
                                || self.fn_macros.contains_key(name)
                                || is_builtin_operator_name(name));
                        cond_stack.push(CondFrame {
                            parent_active: active,
                            this_branch_taken: taken,
                            any_branch_taken: taken,
                            saw_else: false,
                        });
                        active = taken;
                    }
                    Directive::Ifndef(name) => {
                        let taken = active
                            && !(self.macros.contains_key(name)
                                || self.fn_macros.contains_key(name)
                                || is_builtin_operator_name(name));
                        cond_stack.push(CondFrame {
                            parent_active: active,
                            this_branch_taken: taken,
                            any_branch_taken: taken,
                            saw_else: false,
                        });
                        active = taken;
                    }
                    Directive::If(expr) => {
                        let taken = active && self.eval_condition(expr, source_line, filename)?;
                        cond_stack.push(CondFrame {
                            parent_active: active,
                            this_branch_taken: taken,
                            any_branch_taken: taken,
                            saw_else: false,
                        });
                        active = taken;
                    }
                    Directive::Else => {
                        active = apply_else(&mut cond_stack, filename, line_no)?;
                    }
                    Directive::Elif(expr) => {
                        // The directive eval needs a `&Self`, but the
                        // frame update borrows `cond_stack` -- check
                        // eligibility first, evaluate, then mutate.
                        let eligible = elif_eligible(&cond_stack, filename, line_no)?;
                        let cond = eligible && self.eval_condition(expr, source_line, filename)?;
                        active = apply_elif(&mut cond_stack, cond, filename, line_no)?;
                    }
                    Directive::Endif => {
                        active = apply_endif(&mut cond_stack, filename, line_no)?;
                    }
                    Directive::Pragma(args) => {
                        if active {
                            match parse_pragma_directive(args) {
                                PragmaDirective::Once => {
                                    self.pragma_once_files.insert(filename.to_string());
                                }
                                PragmaDirective::Other => {
                                    // `#pragma pack(...)` is source-position-
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
                                    // its `pack_stack`.
                                    if pragma_is_pack(args) {
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
                            // handled.
                            let expanded = self.substitute(args, filename, line_no);
                            let trimmed = expanded.trim();
                            let name = trimmed
                                .strip_prefix('<')
                                .and_then(|s| s.strip_suffix('>'))
                                .map(|n| (n, false))
                                .or_else(|| {
                                    trimmed
                                        .strip_prefix('"')
                                        .and_then(|s| s.strip_suffix('"'))
                                        .map(|n| (n, true))
                                });
                            if let Some((n, quoted)) = name {
                                let included =
                                    self.process_include(n.trim(), line_no, filename, quoted)?;
                                out.push_str(&included);
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
                            let included = self.process_include(name, line_no, filename, quoted)?;
                            out.push_str(&included);
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
                            let included =
                                self.process_include_next(name, line_no, filename, quoted)?;
                            out.push_str(&included);
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
                    Directive::Error(message) => {
                        // C99 sec 6.10.5: `#error` produces a compile-time
                        // diagnostic. The text after the directive name,
                        // up to the newline, is the diagnostic message;
                        // we surface it verbatim through the standard
                        // C5Error path so the same downstream tooling
                        // that reports lexer / parser failures handles
                        // it.
                        if active {
                            return Err(C5Error::Compile(super::error::fmt_compile_err(
                                filename,
                                line_no,
                                &format!("#error {}", message.trim()),
                            )));
                        }
                    }
                    Directive::Warning(message) => {
                        // gcc/clang extension; standardised in C23.
                        // Same shape as `#error` but emits a
                        // `warning:` diagnostic and lets compilation
                        // continue. Goes into the preprocessor's
                        // warning bag so the CLI surfaces it through
                        // the same TTY-colorising path as
                        // type-mismatch and tentative-decl warnings.
                        if active {
                            self.warnings.push(super::error::fmt_compile_warn(
                                filename,
                                line_no,
                                &format!("#warning {}", message.trim()),
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
                        if active {
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
                }
                out.push('\n');
                source_line += 1;
                idx_iter += 1;
                continue;
            }

            if active {
                let mut buffer = String::from(line);
                let mut consumed = 1usize;
                // A function-like macro call may span lines whose arguments
                // carry conditional directives (C99 6.10.3p11 leaves this
                // undefined, but the common toolchains evaluate them and
                // real code relies on it). Track a local conditional state
                // so only the active branch's lines join the argument
                // buffer; directive lines never become argument text.
                let mut join_stack: Vec<CondFrame> = Vec::new();
                let mut join_active = true;
                // The scan state advances over appended bytes only;
                // re-scanning the grown buffer per joined line is
                // quadratic in the invocation length.
                let mut join = JoinScan::new();
                join.feed(&buffer, &self.fn_macros, &self.macros);
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
                    let cont_trimmed = cont.trim_start();
                    if let Some(rest) = cont_trimmed.strip_prefix('#') {
                        match parse_directive(rest.trim_start()) {
                            Directive::Ifdef(name) => {
                                let taken = join_active
                                    && (self.macros.contains_key(name)
                                        || self.fn_macros.contains_key(name));
                                join_stack.push(CondFrame {
                                    parent_active: join_active,
                                    this_branch_taken: taken,
                                    any_branch_taken: taken,
                                    saw_else: false,
                                });
                                join_active = taken;
                            }
                            Directive::Ifndef(name) => {
                                let taken = join_active
                                    && !(self.macros.contains_key(name)
                                        || self.fn_macros.contains_key(name));
                                join_stack.push(CondFrame {
                                    parent_active: join_active,
                                    this_branch_taken: taken,
                                    any_branch_taken: taken,
                                    saw_else: false,
                                });
                                join_active = taken;
                            }
                            Directive::If(expr) => {
                                let taken = join_active
                                    && self.eval_condition(expr, source_line, filename)?;
                                join_stack.push(CondFrame {
                                    parent_active: join_active,
                                    this_branch_taken: taken,
                                    any_branch_taken: taken,
                                    saw_else: false,
                                });
                                join_active = taken;
                            }
                            // An `#elif` / `#else` / `#endif` with no
                            // frame opened inside the argument list
                            // belongs to the conditional enclosing the
                            // macro call; apply it to the outer stack so
                            // argument gathering resumes in the right
                            // branch and the outer frame still closes.
                            Directive::Elif(expr) => {
                                let stack = if join_stack.is_empty() {
                                    &mut cond_stack
                                } else {
                                    &mut join_stack
                                };
                                let eligible = elif_eligible(stack, filename, source_line)?;
                                let cond =
                                    eligible && self.eval_condition(expr, source_line, filename)?;
                                let taken = apply_elif(stack, cond, filename, source_line)?;
                                if join_stack.is_empty() {
                                    active = taken;
                                }
                                join_active = taken;
                            }
                            Directive::Else => {
                                let stack = if join_stack.is_empty() {
                                    &mut cond_stack
                                } else {
                                    &mut join_stack
                                };
                                let taken = apply_else(stack, filename, source_line)?;
                                if join_stack.is_empty() {
                                    active = taken;
                                }
                                join_active = taken;
                            }
                            Directive::Endif => {
                                if let Some(frame) = join_stack.pop() {
                                    join_active = frame.parent_active;
                                } else {
                                    active = apply_endif(&mut cond_stack, filename, source_line)?;
                                    join_active = active;
                                }
                            }
                            // Other directives inside a macro argument are
                            // rare and undefined; consume the line without
                            // adding it to the argument text.
                            _ => {}
                        }
                    } else if join_active {
                        let appended = buffer.len();
                        buffer.push('\n');
                        buffer.push_str(cont);
                        join.feed(&buffer[appended..], &self.fn_macros, &self.macros);
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

        Ok(out)
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

mod cond;
mod directive;
mod expand;
mod include;
mod pragma;
mod text;

#[cfg(test)]
mod tests;

use cond::is_builtin_operator_name;
use directive::{
    apply_elif, apply_else, apply_endif, elif_eligible, format_line_marker, parse_directive,
    CondFrame, Directive,
};
use expand::JoinScan;
use pragma::{parse_pragma_directive, pragma_is_pack, PragmaDirective};
use text::{is_ident, strip_c_comments, unfold_line_continuations};

