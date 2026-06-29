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
use core::cell::Cell;
use hashbrown::HashMap;

use super::codegen::Target;
use super::error::C5Error;
use super::headers::embedded_header;

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
    /// (`./include`, `./headers/include`). Filesystem reads are
    /// gated behind `cfg(feature = "std")`; the no_std build
    /// keeps the field but never reads from it (the embedded
    /// headers are always available).
    search_paths: Vec<String>,
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
        let fn_macros: HashMap<String, FnMacro> = HashMap::new();
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
            ("__builtin_unreachable", super::op::Intrinsic::Trap),
            (
                "__builtin_frame_address",
                super::op::Intrinsic::FrameAddress,
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
        macros.insert("__STDC_NO_VLA__".to_string(), "1".to_string());
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
        match target {
            Target::MacOSAarch64 => {
                macros.insert("__APPLE__".to_string(), "1".to_string());
                macros.insert("__MACH__".to_string(), "1".to_string());
            }
            Target::LinuxAarch64 | Target::LinuxX64 => {
                macros.insert("__linux__".to_string(), "1".to_string());
                macros.insert("__unix__".to_string(), "1".to_string());
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
            fn_macros,
            dylibs: Vec::new(),
            exports: Vec::new(),
            pragma_once_files: BTreeSet::new(),
            include_stack: Vec::new(),
            search_paths: Vec::new(),
            force_includes: Vec::new(),
            source_label: "<source>".to_string(),
            warnings: Vec::new(),
            include_trace: Vec::new(),
            show_includes: false,
            entrypoint: None,
            subsystem: None,
            counter: Cell::new(0),
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
        // `__builtin_types_compatible_p`, `__int128`). Reporting strict
        // ISO conformance alongside `__GNUC__` -- exactly `gcc`/`clang
        // -std=c11` -- routes portable code to the standard path for
        // those, while keeping the `__`-prefixed surface available.
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
    /// NAME` directive -- e.g. `-DSQLITE_PRIVATE=` expands to nothing,
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
                                || self.fn_macros.contains_key(name));
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
                                || self.fn_macros.contains_key(name));
                        cond_stack.push(CondFrame {
                            parent_active: active,
                            this_branch_taken: taken,
                            any_branch_taken: taken,
                            saw_else: false,
                        });
                        active = taken;
                    }
                    Directive::If(expr) => {
                        let taken = active && self.eval_condition(expr, source_line)?;
                        cond_stack.push(CondFrame {
                            parent_active: active,
                            this_branch_taken: taken,
                            any_branch_taken: taken,
                            saw_else: false,
                        });
                        active = taken;
                    }
                    Directive::Else => {
                        let frame = cond_stack.last_mut().ok_or_else(|| {
                            C5Error::Compile(super::error::fmt_compile_err(
                                filename,
                                line_no,
                                "`#else` with no matching `#if`",
                            ))
                        })?;
                        if frame.saw_else {
                            return Err(C5Error::Compile(super::error::fmt_compile_err(
                                filename,
                                line_no,
                                "duplicate `#else` for the same `#if`",
                            )));
                        }
                        frame.saw_else = true;
                        let taken = frame.parent_active && !frame.any_branch_taken;
                        frame.this_branch_taken = taken;
                        frame.any_branch_taken |= taken;
                        active = taken;
                    }
                    Directive::Elif(expr) => {
                        // The directive eval needs a `&Self`, but
                        // `cond_stack.last_mut()` borrows `self` for
                        // the frame -- evaluate the expression first
                        // and only then mutate the frame.
                        let parent_active =
                            cond_stack.last().map(|f| f.parent_active).ok_or_else(|| {
                                C5Error::Compile(super::error::fmt_compile_err(
                                    filename,
                                    line_no,
                                    "`#elif` with no matching `#if`",
                                ))
                            })?;
                        let any_taken_so_far = cond_stack
                            .last()
                            .map(|f| f.any_branch_taken)
                            .unwrap_or(false);
                        let eligible = parent_active && !any_taken_so_far;
                        let cond = if eligible {
                            self.eval_condition(expr, source_line)?
                        } else {
                            false
                        };
                        // Non-empty by the `parent_active` ok_or_else above.
                        let frame = cond_stack
                            .last_mut()
                            .expect("cond_stack non-empty after parent_active check");
                        if frame.saw_else {
                            return Err(C5Error::Compile(super::error::fmt_compile_err(
                                filename,
                                line_no,
                                "`#elif` after `#else` for the same `#if`",
                            )));
                        }
                        frame.this_branch_taken = cond;
                        frame.any_branch_taken |= cond;
                        active = cond;
                    }
                    Directive::Endif => {
                        let frame = cond_stack.pop().ok_or_else(|| {
                            C5Error::Compile(super::error::fmt_compile_err(
                                filename,
                                line_no,
                                "`#endif` with no matching `#if`",
                            ))
                        })?;
                        active = frame.parent_active;
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
                while macro_call_unclosed(&buffer, &self.fn_macros, &self.macros)
                    && idx + consumed < lines.len()
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
                                let taken =
                                    join_active && self.eval_condition(expr, source_line)?;
                                join_stack.push(CondFrame {
                                    parent_active: join_active,
                                    this_branch_taken: taken,
                                    any_branch_taken: taken,
                                    saw_else: false,
                                });
                                join_active = taken;
                            }
                            Directive::Elif(expr) => {
                                let parent_active =
                                    join_stack.last().map(|f| f.parent_active).unwrap_or(false);
                                let any_taken = join_stack
                                    .last()
                                    .map(|f| f.any_branch_taken)
                                    .unwrap_or(true);
                                let eligible = parent_active && !any_taken;
                                let cond = if eligible {
                                    self.eval_condition(expr, source_line)?
                                } else {
                                    false
                                };
                                if let Some(frame) = join_stack.last_mut() {
                                    frame.this_branch_taken = cond;
                                    frame.any_branch_taken |= cond;
                                }
                                join_active = cond;
                            }
                            Directive::Else => {
                                if let Some(frame) = join_stack.last_mut() {
                                    let taken = frame.parent_active && !frame.any_branch_taken;
                                    frame.saw_else = true;
                                    frame.this_branch_taken = taken;
                                    frame.any_branch_taken |= taken;
                                    join_active = taken;
                                }
                            }
                            Directive::Endif => {
                                if let Some(frame) = join_stack.pop() {
                                    join_active = frame.parent_active;
                                }
                            }
                            // Other directives inside a macro argument are
                            // rare and undefined; consume the line without
                            // adding it to the argument text.
                            _ => {}
                        }
                    } else if join_active {
                        buffer.push('\n');
                        buffer.push_str(cont);
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

        if !cond_stack.is_empty() {
            return Err(C5Error::Compile(crate::c5::error::fmt_internal_err(
                "preprocessor: unterminated `#if` / `#ifdef` block",
            )));
        }

        Ok(out)
    }

    /// Substitute every macro-name token in `line` with its
    /// expansion. Identifiers are recognised the same way the lexer
    /// recognises them (ASCII alpha + `_` start, alnum + `_`
    /// continue). Replacement is iterative with a per-call visited
    /// set so `#define A B` `#define B 5` chains expand fully but
    /// `#define A A` doesn't loop forever.
    ///
    /// `filename` and `line_no` feed the special predefined macros
    /// `__FILE__` and `__LINE__`, which can't live in the static
    /// `macros` table because their expansion changes on every line.
    fn substitute(&self, line: &str, filename: &str, line_no: usize) -> String {
        self.substitute_with_blocklist(line, filename, line_no, &Blocklist::Nil)
    }

    /// Process C99 6.10.9 `_Pragma` operators in already-macro-expanded
    /// text. `_Pragma ( string-literal )` is destringized (the optional
    /// `L` prefix and the surrounding quotes are removed, `\"` becomes
    /// `"`, and `\\` becomes `\`) and handled as the matching `#pragma`
    /// directive; the operator itself contributes no tokens. String and
    /// character literals in the surrounding text are copied through
    /// unchanged so a `_Pragma` substring inside one is not mistaken for
    /// the operator. A malformed operator is left in place for the lexer
    /// to diagnose.
    fn apply_pragma_operators(
        &mut self,
        text: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<String, C5Error> {
        if !text.contains("_Pragma") && !text.contains("__pragma") {
            return Ok(text.to_string());
        }
        let bytes = text.as_bytes();
        let mut out = String::with_capacity(text.len());
        let mut copied = 0usize;
        let mut i = 0usize;
        while i < bytes.len() {
            let c = bytes[i];
            if c == b'"' || c == b'\'' {
                i += 1;
                while i < bytes.len() {
                    if bytes[i] == b'\\' {
                        i += 2;
                        continue;
                    }
                    let closed = bytes[i] == c;
                    i += 1;
                    if closed {
                        break;
                    }
                }
                continue;
            }
            let is_operator = c == b'_'
                && bytes[i..].starts_with(b"_Pragma")
                && (i == 0 || !is_ident_byte(bytes[i - 1]))
                && !bytes.get(i + 7).copied().is_some_and(is_ident_byte);
            if let Some((args, next)) = is_operator
                .then(|| parse_pragma_operator_args(text, i + 7))
                .flatten()
            {
                out.push_str(&text[copied..i]);
                self.dispatch_pragma_operator(&args, line_no, filename, &mut out)?;
                i = next;
                copied = next;
                continue;
            }
            // MSVC `__pragma(tokens)`: same operator as C99 `_Pragma`, but
            // the operand is raw tokens rather than a string literal.
            let is_msvc_operator = c == b'_'
                && bytes[i..].starts_with(b"__pragma")
                && (i == 0 || !is_ident_byte(bytes[i - 1]))
                && !bytes.get(i + 8).copied().is_some_and(is_ident_byte);
            if let Some((args, next)) = is_msvc_operator
                .then(|| parse_msvc_pragma_args(text, i + 8))
                .flatten()
            {
                out.push_str(&text[copied..i]);
                self.dispatch_pragma_operator(&args, line_no, filename, &mut out)?;
                i = next;
                copied = next;
                continue;
            }
            i += 1;
        }
        out.push_str(&text[copied..]);
        Ok(out)
    }

    /// Apply a single destringized `_Pragma` operand through the same
    /// dispatch as the `#pragma` directive (see the `Directive::Pragma`
    /// arm in `process_named`). `pack(...)` is emitted as an inline
    /// `#pragma pack` directive on its own line so the lexer folds it
    /// into the pack stack at this source position.
    fn dispatch_pragma_operator(
        &mut self,
        args: &str,
        line_no: usize,
        filename: &str,
        out: &mut String,
    ) -> Result<(), C5Error> {
        match parse_pragma_directive(args) {
            PragmaDirective::Once => {
                self.pragma_once_files.insert(filename.to_string());
            }
            PragmaDirective::Other => {
                if pragma_is_pack(args) {
                    out.push_str("\n#pragma ");
                    out.push_str(args.trim());
                    out.push('\n');
                } else {
                    self.parse_pragma(args, line_no, filename)?;
                }
            }
        }
        Ok(())
    }

    /// Scan `text` for identifiers that name a macro currently
    /// in the registry, append each to `out`. Used to compute
    /// the C99 6.10.3.4 "blue paint" set after a function-like
    /// macro's arguments have been pre-expanded: any macro name
    /// surviving in the pre-expanded arg text must have fired
    /// during pre-expansion, so it must not re-fire during the
    /// body rescan.
    ///
    /// An object-like macro name always counts: if it survived
    /// pre-expansion it fired. A function-like macro name counts only
    /// when immediately followed by `(`: such a call could have fired
    /// (fn-like macros expand only when followed by `(`, C99 6.10.3p10),
    /// so its survival means it was blue-painted during pre-expansion --
    /// the self-referential `#define Py_DECREF(op) Py_DECREF(...)` idiom
    /// -- and it must stay blue-painted in the body rescan. A bare
    /// function-like name with no `(` carries no information; blue-
    /// painting it would suppress the canonical `APPLY(OP, ...)` shape
    /// where `OP` only becomes a call after substitution.
    fn collect_macro_idents_into(&self, text: &str, out: &mut alloc::vec::Vec<String>) {
        let bytes = text.as_bytes();
        let mut i = 0;
        while i < bytes.len() {
            let c = bytes[i];
            // Skip a string / char literal's encoding prefix so the `L`
            // of `L"..."` isn't collected as a macro identifier (C99
            // 6.4.5 / 6.4.4.4); the literal body falls to the quote arm.
            if let Some(plen) = literal_prefix_len(bytes, i) {
                i += plen;
                continue;
            }
            if c.is_ascii_alphabetic() || c == b'_' {
                let start = i;
                i += 1;
                while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                    i += 1;
                }
                let ident = &text[start..i];
                let counts = self.macros.contains_key(ident)
                    || (self.fn_macros.contains_key(ident) && {
                        let mut k = i;
                        while k < bytes.len() && (bytes[k] == b' ' || bytes[k] == b'\t') {
                            k += 1;
                        }
                        k < bytes.len() && bytes[k] == b'('
                    });
                if counts && !out.iter().any(|s| s == ident) {
                    out.push(ident.to_string());
                }
            } else if c == b'"' || c == b'\'' {
                let quote = c;
                i += 1;
                while i < bytes.len() && bytes[i] != quote {
                    if bytes[i] == b'\\' && i + 1 < bytes.len() {
                        i += 2;
                    } else {
                        i += 1;
                    }
                }
                if i < bytes.len() {
                    i += 1;
                }
            } else {
                i += 1;
            }
        }
    }

    /// Like [`substitute`], but `blocklist` enumerates macro names
    /// currently being expanded -- the C99 "blue paint" rule says a
    /// macro doesn't re-expand inside its own replacement list.
    /// Self-shadowing patterns (`static T name; #define name
    /// GLOBAL(T, name)`) blow the stack without this guard.
    fn substitute_with_blocklist(
        &self,
        line: &str,
        filename: &str,
        line_no: usize,
        blocklist: &Blocklist,
    ) -> String {
        // Bound the expansion nesting so a pathologically deep (but
        // blocklist-terminating) macro does not overflow the native
        // stack. Past the bound the current text is left unexpanded
        // rather than recursing further.
        if blocklist.depth() > MAX_MACRO_DEPTH {
            return line.to_string();
        }
        let bytes = line.as_bytes();
        let mut out = String::with_capacity(line.len());
        let mut i = 0;
        while i < bytes.len() {
            let c = bytes[i];
            // A string / char literal may carry an encoding prefix
            // (`L`, `u`, `U`, `u8`) that is part of the literal token,
            // not an identifier (C99 6.4.5 / 6.4.4.4). Detect it before
            // the identifier scan so a macro parameter named `L`/`u`/`U`
            // doesn't capture the prefix of an adjacent wide / UTF
            // literal. The literal body is copied verbatim below.
            if let Some(plen) = literal_prefix_len(bytes, i) {
                out.push_str(&line[i..i + plen]);
                i += plen;
                continue;
            }
            if c.is_ascii_alphabetic() || c == b'_' {
                let start = i;
                i += 1;
                while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                    i += 1;
                }
                let ident = &line[start..i];
                // C99 sec 6.10.8 dynamic predefines -- their expansion
                // depends on the current line / file, so they sit
                // outside the static macro table.
                if ident == "__LINE__" {
                    out.push_str(&format!("{line_no}"));
                    continue;
                }
                if ident == "__FILE__" {
                    out.push('"');
                    out.push_str(filename);
                    out.push('"');
                    continue;
                }
                // MSVC / GCC extension: each `__COUNTER__` use
                // expands to a monotonically increasing integer
                // literal -- 0, 1, 2, ... -- and post-increments.
                // Often paired with `##` to mint unique
                // identifiers from macros.
                if ident == "__COUNTER__" {
                    let n = self.counter.get();
                    self.counter.set(n + 1);
                    out.push_str(&format!("{n}"));
                    continue;
                }
                // C99 "blue paint": don't re-expand a name that's
                // already being expanded on the current chain.
                if blocklist.contains(ident) {
                    out.push_str(ident);
                    continue;
                }
                // Function-like macro: only expands when the next
                // non-whitespace character is `(`. The C standard
                // allows whitespace between the name and the open
                // paren at *use* sites; we follow that.
                if let Some(macro_def) = self.fn_macros.get(ident) {
                    let mut j = i;
                    while j < bytes.len() && (bytes[j] == b' ' || bytes[j] == b'\t') {
                        j += 1;
                    }
                    if j < bytes.len()
                        && bytes[j] == b'('
                        && let Some((args, after)) = parse_macro_args(&line[j..])
                    {
                        // C99 argument substitution rule: each arg is
                        // macro-expanded *before* being substituted
                        // into the body (parameters that participate
                        // in `#` or `##` are exempt, but expand_fn_macro
                        // handles those cases by reading the parameter's
                        // unexpanded text directly). Pre-expand here
                        // with `ident` not yet on the blocklist -- the
                        // outer macro's blue paint only kicks in for
                        // the rescan of the substituted body.
                        let expanded_args: Vec<String> = args
                            .iter()
                            .map(|a| {
                                self.substitute_with_blocklist(a, filename, line_no, blocklist)
                            })
                            .collect();
                        let expanded = expand_fn_macro(macro_def, &expanded_args, &args);
                        // C99 6.10.3.4 "blue paint": any macro that
                        // fired during arg pre-expansion stays on
                        // the blocklist for the body rescan, so a
                        // pre-expanded arg like `s1->symtab_section`
                        // does not re-trigger `symtab_section` after
                        // substitution. Approximate the fired set by
                        // scanning each pre-expanded arg for macro
                        // names: a name that survived in the
                        // expanded text and is still in the
                        // registry must have already expanded
                        // through pre-expansion (otherwise pre-
                        // expansion would have substituted it).
                        let mut blue_paint: alloc::vec::Vec<String> = alloc::vec::Vec::new();
                        for arg_text in &expanded_args {
                            self.collect_macro_idents_into(arg_text, &mut blue_paint);
                        }
                        let recursed = if blue_paint.is_empty() {
                            let frame = Blocklist::Cons(ident, blocklist);
                            self.substitute_with_blocklist(&expanded, filename, line_no, &frame)
                        } else {
                            let mut names: Vec<&str> = alloc::vec![ident];
                            for bp in &blue_paint {
                                let s = bp.as_str();
                                if !names.contains(&s) && !blocklist.contains(s) {
                                    names.push(s);
                                }
                            }
                            let frame = Blocklist::Many(&names, blocklist);
                            self.substitute_with_blocklist(&expanded, filename, line_no, &frame)
                        };
                        // Token-stream rescan (C99 6.10.3.4): if the
                        // function-like macro's body reduces to a
                        // single identifier and the *source* token
                        // immediately after the original invocation
                        // is `(`, the standard requires that
                        // identifier to be treated as the head of a
                        // further function-like call. Drives the
                        // common `WIDTH##_##NAME(...)` paste idiom
                        // where the pasted token is itself a macro.
                        let next_src = j + after;
                        let trimmed = recursed.trim();
                        if !trimmed.is_empty()
                            && trimmed
                                .bytes()
                                .all(|b| b.is_ascii_alphanumeric() || b == b'_')
                            && trimmed.bytes().next().is_some_and(|b| !b.is_ascii_digit())
                            && !blocklist.contains(trimmed)
                            && let Some(inner_def) = self.fn_macros.get(trimmed)
                        {
                            let mut k = next_src;
                            while k < bytes.len() && (bytes[k] == b' ' || bytes[k] == b'\t') {
                                k += 1;
                            }
                            if k < bytes.len()
                                && bytes[k] == b'('
                                && let Some((inner_args, inner_after)) =
                                    parse_macro_args(&line[k..])
                            {
                                // The inner args come from the source
                                // file's tokens after the outer
                                // invocation -- C99 6.10.3.4 paragraph 1
                                // treats those as "the rest of the
                                // source file's preprocessing tokens",
                                // so they are pre-expanded with the
                                // caller's blocklist, not with the just-
                                // completed outer macro on it.
                                let inner_expanded_args: Vec<String> = inner_args
                                    .iter()
                                    .map(|a| {
                                        self.substitute_with_blocklist(
                                            a, filename, line_no, blocklist,
                                        )
                                    })
                                    .collect();
                                let inner_body =
                                    expand_fn_macro(inner_def, &inner_expanded_args, &inner_args);
                                let deeper = Blocklist::Cons(trimmed, blocklist);
                                let inner_recursed = self.substitute_with_blocklist(
                                    &inner_body,
                                    filename,
                                    line_no,
                                    &deeper,
                                );
                                out.push_str(&inner_recursed);
                                i = k + inner_after;
                                continue;
                            }
                        }
                        out.push_str(&recursed);
                        i = next_src;
                        continue;
                    }
                }
                // Object-like expansion. Re-run substitute on the
                // result so a body that mentions a function-like
                // macro (e.g. `#define TWICE INC(INC(0))`) gets the
                // INC(...) calls expanded too. Hot path is the
                // not-a-macro case -- the early `None` saves an
                // allocation per source identifier.
                match self.expand(ident) {
                    None => out.push_str(ident),
                    Some(expanded) => {
                        let nested = Blocklist::Cons(ident, blocklist);
                        // Token-stream rescan (C99 6.10.3.4): if the
                        // expansion is a single identifier and the
                        // *source* token immediately after the
                        // original macro use is `(`, the rescan would
                        // see `expanded_ident(args)` and trigger any
                        // matching function-like macro. We don't have
                        // a true token stream so emulate this here:
                        // detect the shape and pull the args from the
                        // source directly. Drives the canonical
                        // C99 6.10.3.4 rescan shape where an
                        // object-like alias resolves to a
                        // function-like macro name -- e.g.
                        // `#define ALIAS f` followed by `ALIAS(x)`
                        // must expand to `f(x)` and then through
                        // any function-like `f` definition.
                        let trimmed = expanded.trim();
                        if !trimmed.is_empty()
                            && trimmed
                                .bytes()
                                .all(|b| b.is_ascii_alphanumeric() || b == b'_')
                            && trimmed.bytes().next().is_some_and(|b| !b.is_ascii_digit())
                            && let Some(macro_def) = self.fn_macros.get(trimmed)
                            && !nested.contains(trimmed)
                        {
                            let mut j = i;
                            while j < bytes.len() && (bytes[j] == b' ' || bytes[j] == b'\t') {
                                j += 1;
                            }
                            if j < bytes.len()
                                && bytes[j] == b'('
                                && let Some((args, after)) = parse_macro_args(&line[j..])
                            {
                                let expanded_args: Vec<String> = args
                                    .iter()
                                    .map(|a| {
                                        self.substitute_with_blocklist(
                                            a, filename, line_no, &nested,
                                        )
                                    })
                                    .collect();
                                let body_expanded =
                                    expand_fn_macro(macro_def, &expanded_args, &args);
                                let deeper = Blocklist::Cons(trimmed, &nested);
                                let recursed = self.substitute_with_blocklist(
                                    &body_expanded,
                                    filename,
                                    line_no,
                                    &deeper,
                                );
                                out.push_str(&recursed);
                                i = j + after;
                                continue;
                            }
                        }
                        out.push_str(
                            &self.substitute_with_blocklist(&expanded, filename, line_no, &nested),
                        );
                    }
                }
            } else if c == b'"' || c == b'\'' {
                // Copy string and character literals verbatim so
                // identifier-looking bytes inside them aren't
                // substituted, and so a quoted quote (`'"'` /
                // `"\"")` doesn't open the *other* literal kind. Copy
                // the byte range as a UTF-8 slice rather than byte by
                // byte: a per-byte `as char` push would re-encode each
                // byte of a multibyte sequence (`L'a'` -> two chars ->
                // four bytes), corrupting non-ASCII literal contents.
                let quote = c;
                let lit_start = i;
                i += 1;
                while i < bytes.len() && bytes[i] != quote {
                    if bytes[i] == b'\\' && i + 1 < bytes.len() {
                        i += 2;
                    } else {
                        i += 1;
                    }
                }
                if i < bytes.len() {
                    i += 1; // consume the closing quote
                }
                match core::str::from_utf8(&bytes[lit_start..i]) {
                    Ok(s) => out.push_str(s),
                    Err(_) => {
                        for &b in &bytes[lit_start..i] {
                            out.push(b as char);
                        }
                    }
                }
            } else {
                out.push(c as char);
                i += 1;
            }
        }
        out
    }

    /// Iteratively expand a single identifier through the macro
    /// table. Returns `None` if `name` isn't a macro at all -- this is
    /// the fast path for the common case (the source has way more
    /// non-macro identifiers than macro hits) and lets callers skip
    /// allocating a String just to compare it back against the input.
    fn expand(&self, name: &str) -> Option<String> {
        let first = self.macros.get(name)?;
        // We've got at least one substitution. Follow the
        // `#define A B` -> `#define B 5` chain up to a fixed depth so
        // a `#define A A` self-loop doesn't spin forever.
        let mut current = first.clone();
        for _ in 0..32 {
            match self.macros.get(&current) {
                Some(next) if next != &current => current = next.clone(),
                _ => break,
            }
        }
        Some(current)
    }

    /// `expand` but with the original name returned (allocated as a
    /// String) when nothing matched. Used by the `#if` evaluator,
    /// which runs rarely and prefers the simpler "always have a
    /// String" shape.
    fn expand_or_self(&self, name: &str) -> String {
        self.expand(name).unwrap_or_else(|| name.to_string())
    }

    /// Pre-pass for `#if` evaluation: protect every `defined(NAME)`
    /// (and `defined NAME`) by replacing it with `1` or `0` *before*
    /// macro substitution. Otherwise `substitute` would expand the
    /// argument and lose the original name. Returns a fully
    /// macro-substituted string suitable for the `#if` expression
    /// parser.
    fn expand_for_if(&self, expr: &str, line_no: usize) -> String {
        let mut out = String::with_capacity(expr.len());
        let bytes = expr.as_bytes();
        let mut i = 0;
        while i < bytes.len() {
            // Skip whitespace.
            if (bytes[i] as char).is_ascii_whitespace() {
                out.push(bytes[i] as char);
                i += 1;
                continue;
            }
            // Strip `/* ... */` block comments and `// ...` line
            // comments. They show up routinely on `#if` lines.
            if bytes[i] == b'/' && bytes.get(i + 1) == Some(&b'*') {
                i += 2;
                while i + 1 < bytes.len() && !(bytes[i] == b'*' && bytes[i + 1] == b'/') {
                    i += 1;
                }
                i = (i + 2).min(bytes.len());
                out.push(' ');
                continue;
            }
            if bytes[i] == b'/' && bytes.get(i + 1) == Some(&b'/') {
                i = bytes.len();
                continue;
            }
            // Match `defined` keyword (must be a complete word).
            if bytes[i..].starts_with(b"defined") {
                let after = i + b"defined".len();
                let prev_is_word =
                    i > 0 && (bytes[i - 1].is_ascii_alphanumeric() || bytes[i - 1] == b'_');
                let next_is_word = bytes
                    .get(after)
                    .is_some_and(|b| b.is_ascii_alphanumeric() || *b == b'_');
                if !prev_is_word && !next_is_word {
                    let mut j = after;
                    while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                        j += 1;
                    }
                    let with_paren = bytes.get(j) == Some(&b'(');
                    if with_paren {
                        j += 1;
                        while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                            j += 1;
                        }
                    }
                    let name_start = j;
                    while j < bytes.len() && (bytes[j].is_ascii_alphanumeric() || bytes[j] == b'_')
                    {
                        j += 1;
                    }
                    let name = &expr[name_start..j];
                    if with_paren {
                        while j < bytes.len() && (bytes[j] as char).is_ascii_whitespace() {
                            j += 1;
                        }
                        if bytes.get(j) == Some(&b')') {
                            j += 1;
                        }
                    }
                    if !name.is_empty() {
                        // `__has_include` / `__has_include_next` are
                        // always-available operators, so the guard
                        // `defined(__has_include)` is true.
                        let v = name == "__has_include"
                            || name == "__has_include_next"
                            || self.macros.contains_key(name)
                            || self.fn_macros.contains_key(name);
                        out.push_str(if v { "1" } else { "0" });
                        i = j;
                        continue;
                    }
                }
            }
            out.push(bytes[i] as char);
            i += 1;
        }
        // Now expand all remaining identifiers (object + function-
        // like) via the standard substitute pass. Then strip block
        // and line comments from the result -- macro bodies can
        // carry inline `/* ... */` comments that survive expansion
        // and would otherwise confuse the expression tokenizer.
        let substituted = self.substitute(&out, "<#if>", line_no);
        strip_comments(&substituted)
    }

    fn eval_condition(&self, expr: &str, line_no: usize) -> Result<bool, C5Error> {
        // Full c99 `#if` expression evaluator: integer constants,
        // identifiers (treated as 0 if undefined), `defined(X)`,
        // unary `!`, comparisons, and boolean operators with
        // standard precedence. Strings (`"..."`) round-trip as
        // their canonical form so `__BADC_TARGET__ == "macos"`
        // still works as before.
        //
        // Pre-substitute the expression through the macro table so
        // function-like macros (`__has_attribute(x)`) and chained
        // object-like macros (a config-version constant defined
        // via several layers of `#define`) expand before the
        // parser sees them. `defined(X)` is protected by a
        // pre-pass that converts it to a literal 0/1 since
        // substitute would otherwise expand X away.
        let prepared = self.expand_for_if(expr, line_no);
        let mut p = IfExprParser::new(&prepared, self);
        let v = p.parse_ternary()?;
        p.skip_ws();
        if !p.at_end() {
            // Note: `expand_if_expr` doesn't carry a `filename` --
            // it operates on a single line of an expanded `#if` /
            // `#elif` expression. Use `<unknown>` here; callers that
            // hit this case usually have a filename one frame up.
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                "<unknown>",
                line_no,
                &alloc::format!("trailing junk in `#if` expression: {:?}", p.tail()),
            )));
        }
        Ok(v.truthy())
    }

    /// Dispatches c5's pragma surface (`dylib`, `binding`,
    /// `export`, `intrinsic`, `entrypoint`, `subsystem`). `pack`
    /// and `once` are handled elsewhere and bypass this function.
    /// Any other directive is accepted with a warning.
    fn parse_pragma(&mut self, args: &str, line_no: usize, filename: &str) -> Result<(), C5Error> {
        let args = args.trim();
        if let Some(inner) = args
            .strip_prefix("dylib(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_dylib(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("binding(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_binding(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("export(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_export(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("intrinsic(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_intrinsic(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("entrypoint(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_entrypoint(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("subsystem(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_subsystem(inner.trim(), line_no, filename);
        }
        if let Some(inner) = args
            .strip_prefix("warning(")
            .and_then(|s| s.strip_suffix(')'))
        {
            return self.parse_pragma_warning(inner.trim(), line_no, filename);
        }
        // Borland / Watcom `#pragma warn -<code>` form (`-rch`,
        // `-aus`, ...). Parsed for visibility into `warn_disabled`;
        // see `parse_pragma_warn` for the syntax.
        if let Some(inner) = args.strip_prefix("warn ") {
            return self.parse_pragma_warn(inner.trim(), line_no, filename);
        }
        if args.trim() == "warn" {
            return self.parse_pragma_warn("", line_no, filename);
        }
        // `pack` and `once` are consumed elsewhere. The `GCC` / `clang`
        // vendor pragmas (diagnostic selection, `optimize`, `target`,
        // `push_options`, `loop`, ...) and the C99 6.10.6 `STDC` pragmas
        // (FP_CONTRACT, FENV_ACCESS, CX_LIMITED_RANGE) are compiler hints
        // / evaluation modes c5 does not act on. Accept them silently
        // rather than warning on every occurrence; everything else falls
        // through to the unknown-pragma warning.
        let directive = args.split('(').next().unwrap_or(args).trim();
        let head = directive.split_whitespace().next().unwrap_or("");
        if matches!(head, "pack" | "once" | "STDC" | "GCC" | "clang") {
            return Ok(());
        }
        self.warnings.push(super::error::fmt_compile_warn(
            filename,
            line_no,
            &format!("unknown `#pragma {directive}` -- ignored"),
        ));
        Ok(())
    }

    /// MSVC `#pragma warning(...)` -- the most common forms seen
    /// in code that builds under both MSVC and other compilers:
    ///
    /// * `#pragma warning(disable : N1 N2 ...)` -- silence those IDs
    /// * `#pragma warning(default : N1 ...)` -- restore default
    /// * `#pragma warning(enable : N1 ...)` -- explicitly re-enable
    /// * `#pragma warning(error : N1 ...)` -- escalate to error
    /// * `#pragma warning(once : N1 ...)` -- report only once
    /// * `#pragma warning(suppress : N1 ...)` -- suppress next stmt
    /// * `#pragma warning(push)` / `#pragma warning(push, level)`
    /// * `#pragma warning(pop)`
    ///
    /// c5's diagnostics aren't numbered the way MSVC's are, so
    /// `disable : 4267` doesn't *actually* silence anything c5
    /// emits. What this parser buys is:
    ///   1. The source's intent is recognised rather than dropped
    ///      on the floor, so future-c5 can hook up real filtering
    ///      against the recorded ID set.
    ///   2. Syntax typos surface as warnings instead of silently
    ///      no-opping.
    ///   3. `push` / `pop` track a stack of disabled-ID snapshots
    ///      so source that brackets a region of disables works
    ///      the way it does in MSVC.
    fn parse_pragma_warning(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        // `inner` is the text between the outer parens, e.g.
        // `disable : 4267 4100` or `push, 3` or `pop`.
        let inner = inner.trim();

        if inner == "push" {
            self.warning_stack.push(self.warning_disabled.clone());
            return Ok(());
        }
        // `push, <level>` -- accepted; the level is ignored
        // because c5 has no notion of overall warning levels.
        if let Some(level) = inner
            .strip_prefix("push")
            .and_then(|s| s.trim().strip_prefix(','))
        {
            let level = level.trim();
            if !level.chars().all(|c| c.is_ascii_digit()) {
                self.warnings.push(format!(
                    "{filename}:{line_no}: warning: \
                     `#pragma warning(push, <level>)` expects an integer level, \
                     got `{level}`"
                ));
                return Ok(());
            }
            self.warning_stack.push(self.warning_disabled.clone());
            return Ok(());
        }
        if inner == "pop" {
            if let Some(prev) = self.warning_stack.pop() {
                self.warning_disabled = prev;
            } else {
                self.warnings.push(format!(
                    "{filename}:{line_no}: warning: \
                     `#pragma warning(pop)` with no matching push"
                ));
            }
            return Ok(());
        }

        // Action-with-IDs forms: `<action> : N1 N2 ...`. Multiple
        // comma-separated groups are allowed (`disable: 4 ; enable: 5`)
        // -- accept the semicolon-separated form too because
        // some sources use it.
        for clause in inner.split(';') {
            let clause = clause.trim();
            if clause.is_empty() {
                continue;
            }
            let Some((action, rest)) = clause.split_once(':') else {
                self.warnings.push(format!(
                    "{filename}:{line_no}: warning: \
                     unrecognised `#pragma warning({clause})` \
                     -- expected `disable : N` / `enable : N` / \
                     `default : N` / `error : N` / `once : N` / \
                     `suppress : N` / `push` / `pop`"
                ));
                continue;
            };
            let action = action.trim();
            let ids = rest;
            let mut ids_parsed: Vec<u32> = Vec::new();
            let mut had_bad_token = false;
            for tok in ids.split_whitespace() {
                match tok.parse::<u32>() {
                    Ok(n) => ids_parsed.push(n),
                    Err(_) => {
                        self.warnings.push(format!(
                            "{filename}:{line_no}: warning: \
                             `#pragma warning({action} : {tok})` \
                             -- expected an integer warning ID"
                        ));
                        had_bad_token = true;
                    }
                }
            }
            if had_bad_token {
                continue;
            }
            match action {
                "disable" => {
                    for id in ids_parsed {
                        self.warning_disabled.insert(id);
                    }
                }
                "enable" | "default" => {
                    for id in ids_parsed {
                        self.warning_disabled.remove(&id);
                    }
                }
                "error" | "once" | "suppress" => {
                    // Recognised but currently no-op in c5: c5
                    // doesn't escalate by ID, can't "report only
                    // once" without a per-ID counter, and
                    // `suppress` is a per-statement modifier
                    // that needs lexer cooperation. Accept the
                    // syntax silently.
                }
                _ => {
                    self.warnings.push(format!(
                        "{filename}:{line_no}: warning: \
                         unrecognised `#pragma warning` action `{action}` \
                         -- expected `disable` / `enable` / `default` / \
                         `error` / `once` / `suppress`"
                    ));
                }
            }
        }
        Ok(())
    }

    /// Borland / Watcom `#pragma warn` syntax:
    ///
    /// ```text
    /// #pragma warn -rch  /* disable "unreachable code" */
    /// #pragma warn -aus  /* disable "assigned value never used" */
    /// #pragma warn +ccc  /* re-enable "condition always true/false" */
    /// #pragma warn .rch  /* restore "rch" to its default state */
    /// ```
    ///
    /// Each token is `<sign><code>` where `<sign>` is one of
    /// `-` (disable), `+` (enable), `.` (default). Multiple
    /// tokens per directive are accepted.
    ///
    /// Like the MSVC variant, c5 doesn't filter on these codes;
    /// the parse exists so the source's intent is preserved on
    /// the `warn_disabled` set rather than dropped on the floor.
    /// Empty payloads and bad sign prefixes surface as warnings.
    fn parse_pragma_warn(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let inner = inner.trim();
        if inner.is_empty() {
            self.warnings.push(format!(
                "{filename}:{line_no}: warning: \
                 `#pragma warn` with no payload -- expected \
                 `-<code>` / `+<code>` / `.<code>`"
            ));
            return Ok(());
        }
        for tok in inner.split_whitespace() {
            let (sign, code) = match tok.chars().next() {
                Some(c @ ('-' | '+' | '.')) => (c, &tok[1..]),
                _ => {
                    self.warnings.push(format!(
                        "{filename}:{line_no}: warning: \
                         `#pragma warn {tok}` -- expected a leading \
                         `-` / `+` / `.`"
                    ));
                    continue;
                }
            };
            if code.is_empty() {
                self.warnings.push(format!(
                    "{filename}:{line_no}: warning: \
                     `#pragma warn {tok}` -- code follows the sign"
                ));
                continue;
            }
            match sign {
                '-' => {
                    self.warn_disabled.insert(code.to_string());
                }
                '+' | '.' => {
                    self.warn_disabled.remove(code);
                }
                _ => unreachable!(),
            }
        }
        Ok(())
    }

    /// `#pragma entrypoint(<name>)` -- override the function the
    /// loader / `--jit` handoff jumps to. Default is `main`. The
    /// only constraint here is that `<name>` is a plain
    /// identifier; the compile pass validates the name resolves
    /// to a `Token::Fun` symbol after the parse pass, the same
    /// way `#pragma export(...)` is checked.
    ///
    /// Use cases:
    ///   * Win32 GUI apps -- `#pragma entrypoint(WinMain)` with
    ///     `#pragma subsystem(windows)` produces a PE the
    ///     Windows loader resolves to `WinMain` and the loader
    ///     skips the console-attach step.
    ///   * Custom `_start` shapes that bypass the libc CRT.
    ///   * DLL-style entry points where `DllMain` is the only
    ///     callable name (rare; today the `#pragma export`
    ///     surface covers DLLs).
    fn parse_pragma_entrypoint(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let name = inner.trim();
        if !is_ident(name) {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma entrypoint({name})` -- name must be a \
                     plain identifier"
                ),
            )));
        }
        if let Some(prev) = &self.entrypoint
            && prev != name
        {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma entrypoint({name})` conflicts with prior \
                     `#pragma entrypoint({prev})`; pick one"
                ),
            )));
        }
        self.entrypoint = Some(name.to_string());
        Ok(())
    }

    /// `#pragma intrinsic("name")` -- tag the named callable
    /// symbol as a compiler-builtin intrinsic. At
    /// declaration time the frontend stamps the matching
    /// `Symbol::intrinsic` field with the [`Intrinsic`]
    /// discriminant from `op.rs`, and the call-site lowering
    /// emits an `Inst::Intrinsic` instead of a regular call +
    /// stack-cleanup sequence. The C11 7.17 atomic operations use the
    /// same registry but lower to load / store / read-modify-write at
    /// the call site rather than to an `Inst::Intrinsic`. The arg list is
    /// expected to be a quoted string so future intrinsics
    /// whose spellings collide with c5 keywords don't trip
    /// the identifier parser; the body uses `is_ident` to
    /// stay strict.
    fn parse_pragma_intrinsic(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let raw = inner.trim();
        let name = raw.strip_prefix('"').and_then(|s| s.strip_suffix('"'));
        let Some(name) = name else {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma intrinsic({raw})` -- expected a quoted \
                     identifier, e.g. `#pragma intrinsic(\"alloca\")`"
                ),
            )));
        };
        if !is_ident(name) {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma intrinsic(\"{name}\")` -- name must be a \
                     plain identifier"
                ),
            )));
        }
        let id = match name {
            "alloca" | "__builtin_alloca" => super::op::Intrinsic::Alloca as i64,
            // C11 7.17 atomic generic operations. Lowered at the call
            // site to load / store / read-modify-write, not to an
            // `Inst::Intrinsic`.
            "atomic_load" => super::op::Intrinsic::AtomicLoad as i64,
            "atomic_store" => super::op::Intrinsic::AtomicStore as i64,
            "atomic_exchange" => super::op::Intrinsic::AtomicExchange as i64,
            "atomic_fetch_add" => super::op::Intrinsic::AtomicFetchAdd as i64,
            "atomic_fetch_sub" => super::op::Intrinsic::AtomicFetchSub as i64,
            "atomic_fetch_and" => super::op::Intrinsic::AtomicFetchAnd as i64,
            "atomic_fetch_or" => super::op::Intrinsic::AtomicFetchOr as i64,
            "atomic_fetch_xor" => super::op::Intrinsic::AtomicFetchXor as i64,
            "atomic_compare_exchange_strong" => {
                super::op::Intrinsic::AtomicCompareExchangeStrong as i64
            }
            "__c5_aarch64_setjmp" => super::op::Intrinsic::SetjmpAArch64 as i64,
            "__c5_aarch64_longjmp" => super::op::Intrinsic::LongjmpAArch64 as i64,
            "__builtin_va_start" => super::op::Intrinsic::VaStart as i64,
            "__builtin_va_arg" => super::op::Intrinsic::VaArg as i64,
            "__builtin_va_end" => super::op::Intrinsic::VaEnd as i64,
            "__builtin_va_copy" => super::op::Intrinsic::VaCopy as i64,
            "fma" => super::op::Intrinsic::Fma as i64,
            "fmaf" => super::op::Intrinsic::Fmaf as i64,
            "sqrt" => super::op::Intrinsic::Sqrt as i64,
            "sqrtf" => super::op::Intrinsic::Sqrtf as i64,
            "fabs" => super::op::Intrinsic::Fabs as i64,
            "fabsf" => super::op::Intrinsic::Fabsf as i64,
            "floor" => super::op::Intrinsic::Floor as i64,
            "floorf" => super::op::Intrinsic::Floorf as i64,
            "ceil" => super::op::Intrinsic::Ceil as i64,
            "ceilf" => super::op::Intrinsic::Ceilf as i64,
            "trunc" => super::op::Intrinsic::Trunc as i64,
            "truncf" => super::op::Intrinsic::Truncf as i64,
            "__builtin_trap" => super::op::Intrinsic::Trap as i64,
            _ => {
                return Err(C5Error::Compile(super::error::fmt_compile_err(
                    filename,
                    line_no,
                    &format!(
                        "`#pragma intrinsic(\"{name}\")` -- unknown \
                         intrinsic; supported today: alloca, \
                         __builtin_alloca, __c5_aarch64_setjmp, \
                         __c5_aarch64_longjmp, __builtin_va_start, \
                         __builtin_va_arg, __builtin_va_end, \
                         __builtin_va_copy, fma, fmaf, sqrt, sqrtf, \
                         fabs, fabsf, and the C11 atomic_* operations"
                    ),
                )));
            }
        };
        self.intrinsics.insert(name.to_string(), id);
        Ok(())
    }

    /// `#pragma subsystem(<kind>)` -- select the PE
    /// optional-header `Subsystem` value. Accepted kinds:
    ///
    ///   * `console` / `cui` -- `IMAGE_SUBSYSTEM_WINDOWS_CUI` (3,
    ///     default). Entry signature `main(argc, argv)`.
    ///   * `windows` / `gui` -- `IMAGE_SUBSYSTEM_WINDOWS_GUI` (2).
    ///     Entry signature `WinMain(hinst, prev, cmdline, show)`.
    ///   * `native` / `nt` / `driver` -- `IMAGE_SUBSYSTEM_NATIVE`
    ///     (1). NT-native usermode and kernel drivers share this
    ///     subsystem byte; the entry signature is selected by the
    ///     source, not the pragma.
    ///   * `efi_application` -- `IMAGE_SUBSYSTEM_EFI_APPLICATION`
    ///     (10).
    ///   * `efi_boot_service_driver` --
    ///     `IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER` (11).
    ///   * `efi_runtime_driver` --
    ///     `IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER` (12).
    ///   * `efi_rom` -- `IMAGE_SUBSYSTEM_EFI_ROM` (13).
    ///
    /// Accepted on non-PE targets and ignored there; the PE
    /// writer is the only consumer.
    fn parse_pragma_subsystem(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let kind = inner.trim();
        let parsed = match kind {
            "console" | "CUI" | "cui" => Subsystem::Console,
            "windows" | "GUI" | "gui" => Subsystem::Windows,
            "native" | "NATIVE" | "nt" | "NT" | "driver" | "DRIVER" => Subsystem::Native,
            "efi_application" | "efi-application" | "EFI_APPLICATION" => Subsystem::EfiApplication,
            "efi_boot_service_driver" | "efi-boot-service-driver" | "EFI_BOOT_SERVICE_DRIVER" => {
                Subsystem::EfiBootServiceDriver
            }
            "efi_runtime_driver" | "efi-runtime-driver" | "EFI_RUNTIME_DRIVER" => {
                Subsystem::EfiRuntimeDriver
            }
            "efi_rom" | "efi-rom" | "EFI_ROM" => Subsystem::EfiRom,
            _ => {
                return Err(C5Error::Compile(super::error::fmt_compile_err(
                    filename,
                    line_no,
                    &format!(
                        "`#pragma subsystem({kind})` -- expected one of \
                         `console`, `windows`, `native` (alias `driver`), \
                         `efi_application`, `efi_boot_service_driver`, \
                         `efi_runtime_driver`, `efi_rom`"
                    ),
                )));
            }
        };
        if let Some(prev) = self.subsystem
            && prev != parsed
        {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma subsystem({kind})` conflicts with prior \
                     `#pragma subsystem({prev:?})`; pick one"
                ),
            )));
        }
        self.subsystem = Some(parsed);
        Ok(())
    }

    /// `#pragma export(<name>)` -- mark a function defined in
    /// this translation unit as externally visible. The
    /// compiler validates the name resolves to a `Token::Fun`
    /// symbol after the parse pass, and the shared-object
    /// writers (`Target::*` plus the upcoming `OutputKind::SharedLibrary`
    /// shape) promote it to a real export entry.
    ///
    /// Plain identifiers only -- no quoted-name aliasing today
    /// (we'd need a syntax like `export(local_name, "real_name")`
    /// to follow the `#pragma binding(...)` shape, but the
    /// inverse direction; not needed for the initial cut).
    fn parse_pragma_export(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let name = inner.trim();
        if !is_ident(name) {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma export({name})` -- name must be a \
                 plain identifier"
                ),
            )));
        }
        if !self.exports.iter().any(|e| e == name) {
            self.exports.push(name.to_string());
        }
        Ok(())
    }

    /// `#pragma dylib(name, "path")` -- introduce a logical dylib
    /// the codegen can attach bindings to. `name` is an
    /// identifier-style c5-side handle (`libc`, `kernel32`, ...);
    /// `path` is the actual loader-search-name or filesystem path.
    fn parse_pragma_dylib(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let Some((name, path)) = inner.split_once(',') else {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                "`#pragma dylib(...)` expects two args \
                 (`name, \"path\"`)",
            )));
        };
        let name = name.trim();
        let path = path.trim().trim_matches('"');
        if name.is_empty() || path.is_empty() {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                "`#pragma dylib(...)` arg is empty",
            )));
        }
        if !is_ident(name) {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma dylib({name}, ...)` -- name must be a \
                 plain identifier"
                ),
            )));
        }
        if let Some(existing) = self.dylibs.iter().find(|d| d.name == name) {
            // Re-declaring an identical dylib is fine -- standard
            // headers (`<stdio.h>`, `<string.h>`) all bind to the
            // same `libc` / `msvcrt`, so a source that includes
            // both will hit this twice. Different paths are still
            // a hard error since they'd silently shadow each other.
            if existing.path != path {
                return Err(C5Error::Compile(super::error::fmt_compile_err(
                    filename,
                    line_no,
                    &format!(
                        "`#pragma dylib({name}, {path:?})` -- already declared with different path {:?}",
                        existing.path
                    ),
                )));
            }
            return Ok(());
        }
        self.dylibs.push(DylibSpec {
            name: name.to_string(),
            path: path.to_string(),
            bindings: Vec::new(),
        });
        Ok(())
    }

    /// `#include <name>` / `#include "name"` -- splice the named
    /// header's processed contents into the output.
    ///
    /// The header is looked up in [`super::headers::embedded_header`].
    /// Unknown names emit a warning (matching gcc / clang's
    /// "fatal error: 'X': No such file or directory" diagnostic
    /// at warning severity rather than fatal -- c5 chooses the
    /// permissive shape so legacy fixtures with cosmetic
    /// `#include`s don't break) and resolve to an empty body.
    /// Cyclic `#include` returns an error; repeat inclusion of a
    /// header that previously declared `#pragma once` returns an
    /// empty string. With [`Self::set_show_includes`] on the
    /// resolution path is appended to `include_trace` in the
    /// gcc-`-H` shape (`. file`, `.. nested`, `! missing` for
    /// the warning case).
    fn process_include(
        &mut self,
        name: &str,
        line_no: usize,
        filename: &str,
        quoted: bool,
    ) -> Result<String, C5Error> {
        // Resolution order:
        //   1. Filesystem search paths added via `add_search_path`
        //      (= the CLI's `-I` flag plus any built-in defaults).
        //      Lets a user override a bundled header by dropping
        //      the modified file at `./include/<name>` without
        //      rebuilding badc.
        //   2. Bundled in-binary header (the include_str! set in
        //      `headers.rs`).
        //   3. Missed -- emit a warning and resolve to "". The
        //      compile keeps going so a header that exists at
        //      runtime but wasn't bundled in the test binary
        //      isn't a hard failure; the user sees the warning
        //      and can decide whether the missing surface
        //      matters.
        // A quoted include (`#include "header"`) searches the
        // directory of the including file before the system search
        // paths (C99 6.10.2p2); an angle include skips that step.
        // `filename` carries the including file's path (the top-level
        // source path, or the resolved path threaded through a nested
        // include), so its parent directory is the search base.
        let source_dir = if quoted {
            include_parent_dir(filename)
        } else {
            None
        };
        // The result is owned `String` because filesystem-loaded
        // bodies don't have static lifetime; the embedded path
        // copies its `&'static str` into one to share the type. The
        // second element is the path the body resolved to, threaded
        // as the new file's name so a nested quoted include resolves
        // against the right directory.
        let resolved: Option<(String, String)> = self.find_include(name, source_dir.as_deref());
        let Some((content, resolved_path)) = resolved else {
            // Missing header. Push a warning into the same list
            // the parser uses; the caller drains it through to
            // `Program::warnings` after the compile finishes.
            self.warnings.push(format!(
                "{filename}:{line_no}: warning: include `{name}` not found, \
                 dropping (no header search path or embedded header matched)"
            ));
            if self.show_includes {
                let depth = self.include_stack.len() + 1;
                self.include_trace
                    .push(format!("{} {} (missing)", "!".repeat(depth), name));
            }
            return Ok(String::new());
        };
        // `#pragma once` dedups by the resolved path (file identity),
        // not the include spelling, so two different spellings that
        // name the same file are still included once. The handler in
        // `process_named` records the same `resolved_path`.
        if self.pragma_once_files.contains(&resolved_path) {
            if self.show_includes {
                let depth = self.include_stack.len() + 1;
                self.include_trace
                    .push(format!("{} {} (cached)", ".".repeat(depth), name));
            }
            return Ok(String::new());
        }
        if self.show_includes {
            let depth = self.include_stack.len() + 1;
            self.include_trace
                .push(format!("{} {}", ".".repeat(depth), name));
        }
        // A header may legitimately appear more than once on the active
        // include path: a guard-protected re-include where an inner header
        // pulls a guarded outer one back in. The include guard skips the body
        // on the second pass, so this must process normally rather than error.
        // Bound only the nesting depth so a truly unguarded self-include still
        // fails fast instead of recursing without limit; C99 5.2.4.1 sets 15
        // levels as the minimum a translator must support.
        const MAX_INCLUDE_DEPTH: usize = 200;
        if self.include_stack.len() >= MAX_INCLUDE_DEPTH {
            let chain = self.include_stack.join(" -> ");
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!("`#include {name}` nested too deeply (chain: {chain} -> {name})"),
            )));
        }
        self.include_stack.push(name.to_string());
        let result = self.process_named(&content, &resolved_path);
        self.include_stack.pop();
        result
    }

    /// Look `name` up and return its body plus the path it resolved
    /// to. `source_dir` is `Some` only for a quoted include; when set
    /// it is searched first (C99 6.10.2p2). Then the configured search
    /// paths (`-I` plus built-in defaults), then the embedded
    /// registry. The resolved path is the filesystem candidate that
    /// matched, or `name` for an embedded header.
    fn find_include(&self, name: &str, source_dir: Option<&str>) -> Option<(String, String)> {
        #[cfg(feature = "std")]
        {
            let join = |dir: &str| -> String {
                if dir.is_empty() {
                    name.to_string()
                } else if dir.ends_with('/') || dir.ends_with('\\') {
                    format!("{dir}{name}")
                } else {
                    format!("{dir}/{name}")
                }
            };
            // A name with its own directory component or an absolute
            // path is taken as-is; otherwise probe the source
            // directory (quoted only) then the search paths.
            if let Some(dir) = source_dir {
                let candidate = join(dir);
                if let Ok(body) = std::fs::read_to_string(&candidate) {
                    return Some((body, candidate));
                }
            }
            for path in &self.search_paths {
                let candidate = join(path);
                if let Ok(body) = std::fs::read_to_string(&candidate) {
                    return Some((body, candidate));
                }
            }
        }
        let _ = source_dir;
        embedded_header(name).map(|s| (s.to_string(), name.to_string()))
    }

    /// `#pragma binding(dylib::local_name, "real_symbol")` -- record
    /// `local_name`'s mapping to `real_symbol` inside the dylib named
    /// `dylib`. The dylib must already have been declared by a
    /// `#pragma dylib(...)`; the directives can otherwise appear in
    /// any order.
    fn parse_pragma_binding(
        &mut self,
        inner: &str,
        line_no: usize,
        filename: &str,
    ) -> Result<(), C5Error> {
        let Some((qualified, real_symbol)) = inner.split_once(',') else {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                "`#pragma binding(...)` expects two args \
                 (`dylib::local_name, \"real_symbol\"`)",
            )));
        };
        let qualified = qualified.trim();
        // `#pragma binding(data <lib>::<name>, "sym")` marks a data
        // object; the leading `data ` keyword distinguishes it from the
        // function form.
        let (is_data, qualified) = match qualified.strip_prefix("data ") {
            Some(rest) => (true, rest.trim()),
            None => (false, qualified),
        };
        let real_symbol = real_symbol.trim().trim_matches('"');
        let Some((dylib_name, local_name)) = qualified.split_once("::") else {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma binding({qualified}, ...)` -- LHS must be \
                 `dylib_name::local_name`"
                ),
            )));
        };
        let dylib_name = dylib_name.trim();
        let local_name = local_name.trim();
        if dylib_name.is_empty() || local_name.is_empty() || real_symbol.is_empty() {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                "`#pragma binding(...)` arg is empty",
            )));
        }
        let Some(dylib) = self.dylibs.iter_mut().find(|d| d.name == dylib_name) else {
            return Err(C5Error::Compile(super::error::fmt_compile_err(
                filename,
                line_no,
                &format!(
                    "`#pragma binding({dylib_name}::...)` -- no `#pragma \
                 dylib({dylib_name}, ...)` declared"
                ),
            )));
        };
        dylib.bindings.push(Binding {
            is_variadic: false,
            fixed_args: 0,
            return_type_tag: 0,
            returns_long_double: false,
            param_types: Vec::new(),
            local_name: local_name.to_string(),
            real_symbol: real_symbol.to_string(),
            is_data,
        });
        Ok(())
    }
}

/// Names currently being expanded, threaded through the recursive
/// macro substitution to implement C99 6.10.3.4 "blue paint" (a
/// macro does not re-expand while its own expansion is in flight).
/// A stack-allocated chain: the common frame adds a single name and
/// borrows its parent, so no heap allocation is needed; a frame that
/// must add several names (a function-like macro's argument pre-
/// expansion) borrows a slice instead.
enum Blocklist<'a> {
    Nil,
    Cons(&'a str, &'a Blocklist<'a>),
    Many(&'a [&'a str], &'a Blocklist<'a>),
}

impl Blocklist<'_> {
    fn contains(&self, name: &str) -> bool {
        let mut cur = self;
        loop {
            match cur {
                Blocklist::Nil => return false,
                Blocklist::Cons(n, parent) => {
                    if *n == name {
                        return true;
                    }
                    cur = parent;
                }
                Blocklist::Many(names, parent) => {
                    if names.contains(&name) {
                        return true;
                    }
                    cur = parent;
                }
            }
        }
    }

    /// Number of active expansion frames. Each nested macro expansion
    /// pushes one, so this is the substitution recursion depth.
    fn depth(&self) -> usize {
        let mut cur = self;
        let mut n = 0;
        loop {
            match cur {
                Blocklist::Nil => return n,
                Blocklist::Cons(_, parent) | Blocklist::Many(_, parent) => {
                    n += 1;
                    cur = parent;
                }
            }
        }
    }
}

/// Strip C-style `/* ... */` block comments and `// ...` line
/// comments from a single-line buffer. Used on the post-macro-
/// expansion `#if` expression where inlined comments would
/// otherwise confuse the expression tokenizer.
fn strip_comments(s: &str) -> String {
    let mut out = String::with_capacity(s.len());
    let bytes = s.as_bytes();
    let mut i = 0;
    while i < bytes.len() {
        if bytes[i] == b'/' && bytes.get(i + 1) == Some(&b'*') {
            i += 2;
            while i + 1 < bytes.len() && !(bytes[i] == b'*' && bytes[i + 1] == b'/') {
                i += 1;
            }
            i = (i + 2).min(bytes.len());
            out.push(' ');
            continue;
        }
        if bytes[i] == b'/' && bytes.get(i + 1) == Some(&b'/') {
            break;
        }
        out.push(bytes[i] as char);
        i += 1;
    }
    out
}

/// Phase-3 comment removal: strip `/* ... */` block comments and
/// `// ...` line comments from the entire source. Each comment is
/// replaced by a single space so token boundaries are preserved
/// (`a/**/b` becomes `a b`, not `ab`). Newlines inside block
/// comments stay as `\n` so line numbers and `__LINE__` are
/// faithful to the original source. Quoted strings and char
/// literals are passed through unchanged so `"//"` doesn't get
/// misread as a line comment.
fn strip_c_comments(source: &str) -> String {
    let mut out = String::with_capacity(source.len());
    let bytes = source.as_bytes();
    let mut i = 0;
    while i < bytes.len() {
        let c = bytes[i];
        if c == b'/' && bytes.get(i + 1) == Some(&b'*') {
            // Block comment.
            i += 2;
            while i + 1 < bytes.len() {
                if bytes[i] == b'*' && bytes[i + 1] == b'/' {
                    i += 2;
                    break;
                }
                if bytes[i] == b'\n' {
                    out.push('\n');
                }
                i += 1;
            }
            out.push(' ');
            continue;
        }
        if c == b'/' && bytes.get(i + 1) == Some(&b'/') {
            // Line comment -- skip to next newline (don't consume it).
            i += 2;
            while i < bytes.len() && bytes[i] != b'\n' {
                i += 1;
            }
            out.push(' ');
            continue;
        }
        if c == b'"' || c == b'\'' {
            // Pass-through quoted literal so `"//"` etc. survive.
            // Copy the byte range as a UTF-8 slice so a multibyte
            // sequence is not re-encoded byte by byte.
            let quote = c;
            let lit_start = i;
            i += 1;
            while i < bytes.len() && bytes[i] != quote {
                if bytes[i] == b'\\' && i + 1 < bytes.len() {
                    i += 2;
                } else {
                    i += 1;
                }
            }
            if i < bytes.len() {
                i += 1;
            }
            match core::str::from_utf8(&bytes[lit_start..i]) {
                Ok(s) => out.push_str(s),
                Err(_) => {
                    for &b in &bytes[lit_start..i] {
                        out.push(b as char);
                    }
                }
            }
            continue;
        }
        out.push(c as char);
        i += 1;
    }
    out
}

/// Report whether `s` (a partially assembled logical line with its
/// newlines already removed) ends inside an unterminated `/* */` block
/// comment. String and character literals and `//` line comments are
/// tracked so a `/*` appearing inside one of them does not count as a
/// comment opener.
fn ends_in_open_block_comment(s: &str) -> bool {
    let b = s.as_bytes();
    let mut i = 0;
    let mut in_str = false;
    let mut in_char = false;
    let mut in_block = false;
    while i < b.len() {
        let c = b[i];
        if in_block {
            if c == b'*' && b.get(i + 1) == Some(&b'/') {
                in_block = false;
                i += 2;
                continue;
            }
            i += 1;
            continue;
        }
        if in_str {
            if c == b'\\' {
                i += 2;
                continue;
            }
            if c == b'"' {
                in_str = false;
            }
            i += 1;
            continue;
        }
        if in_char {
            if c == b'\\' {
                i += 2;
                continue;
            }
            if c == b'\'' {
                in_char = false;
            }
            i += 1;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'*') {
            in_block = true;
            i += 2;
            continue;
        }
        if c == b'/' && b.get(i + 1) == Some(&b'/') {
            // A line comment runs to the end of the assembled line, so
            // nothing after it can leave a block comment open.
            return false;
        }
        if c == b'"' {
            in_str = true;
        } else if c == b'\'' {
            in_char = true;
        }
        i += 1;
    }
    in_block
}

/// Phase-2 line-continuation collapse: every line ending in `\\`
/// joins with the next, preserving total line count by emitting
/// blank padding lines. The c99 spec runs this before all other
/// preprocessing passes.
///
/// A physical line whose logical line ends inside an open `/* */`
/// block comment also joins with the next line even without a trailing
/// `\\`: a newline inside a block comment is comment white space, not a
/// directive terminator (C99 5.1.1.2), so a multi-line comment embedded
/// in a `\\`-continued macro definition must not split the definition.
fn unfold_line_continuations(source: &str) -> String {
    let mut out = String::with_capacity(source.len());
    let mut iter = source.lines().peekable();
    while let Some(line) = iter.next() {
        let mut joined = line.to_string();
        let mut padding = 0;
        loop {
            if joined.ends_with('\\') {
                joined.pop();
            } else if !ends_in_open_block_comment(&joined) {
                break;
            }
            padding += 1;
            match iter.next() {
                Some(next) => joined.push_str(next),
                None => break,
            }
        }
        out.push_str(&joined);
        out.push('\n');
        for _ in 0..padding {
            out.push('\n');
        }
    }
    out
}

/// Identifier check: ASCII letter or `_` to start, alnum or `_`
/// after. Used to reject `#pragma dylib(123foo, ...)` and similar
/// up-front so the codegen never has to worry about quirks in the
/// dylib `name`.
/// If `bytes[at..]` begins with a string- or char-literal encoding
/// prefix (`L`, `u`, `U`, or `u8`) immediately followed by a `"` or
/// `'` quote, return the prefix length (1 or 2). The quote itself is
/// not included. C99 6.4.5 (string literals) and 6.4.4.4 (character
/// constants) make the prefix part of the literal token; the
/// preprocessor must not treat it as an identifier.
fn literal_prefix_len(bytes: &[u8], at: usize) -> Option<usize> {
    let c = *bytes.get(at)?;
    let quote = |b: u8| b == b'"' || b == b'\'';
    match c {
        b'L' | b'U' if bytes.get(at + 1).is_some_and(|&n| quote(n)) => Some(1),
        b'u' => {
            if bytes.get(at + 1) == Some(&b'8') && bytes.get(at + 2).is_some_and(|&n| n == b'"') {
                Some(2)
            } else if bytes.get(at + 1).is_some_and(|&n| quote(n)) {
                Some(1)
            } else {
                None
            }
        }
        _ => None,
    }
}

/// Build the `#`-stringized form of a macro argument (C99 6.10.3.2):
/// the spelling is wrapped in `"`, leading and trailing white space is
/// deleted, and each internal white-space run between tokens becomes a
/// single space. White space inside a character constant or string
/// literal is preserved, and a `\` or `"` that occurs inside such a
/// literal is escaped; a `\` outside any literal is copied verbatim.
fn stringize_arg(arg: &str) -> String {
    let bytes = arg.as_bytes();
    let mut out = String::with_capacity(arg.len() + 2);
    out.push('"');
    let mut in_str = false;
    let mut in_char = false;
    let mut pending_space = false;
    let mut wrote_any = false;
    let mut i = 0;
    while i < bytes.len() {
        let c = bytes[i];
        let in_lit = in_str || in_char;
        if !in_lit && matches!(c, b' ' | b'\t' | b'\n' | b'\r' | 0x0c) {
            if wrote_any {
                pending_space = true;
            }
            i += 1;
            continue;
        }
        if pending_space {
            out.push(' ');
            pending_space = false;
        }
        if in_lit && c == b'\\' && i + 1 < bytes.len() {
            // Escape sequence inside a literal: escape the backslash,
            // then copy the escaped char (re-escaping a quote or
            // backslash). The escaped char never toggles literal state.
            out.push_str("\\\\");
            match bytes[i + 1] {
                b'"' => out.push_str("\\\""),
                b'\\' => out.push_str("\\\\"),
                n => out.push(n as char),
            }
            i += 2;
            wrote_any = true;
            continue;
        }
        match c {
            b'"' => {
                out.push_str("\\\"");
                if !in_char {
                    in_str = !in_str;
                }
            }
            b'\'' => {
                out.push('\'');
                if !in_str {
                    in_char = !in_char;
                }
            }
            // A backslash outside any literal is not escaped (C99 only
            // escapes those within character / string literals).
            _ => out.push(c as char),
        }
        wrote_any = true;
        i += 1;
    }
    out.push('"');
    out
}

fn is_ident(s: &str) -> bool {
    let mut bytes = s.bytes();
    let Some(first) = bytes.next() else {
        return false;
    };
    if !(first.is_ascii_alphabetic() || first == b'_') {
        return false;
    }
    bytes.all(|b| b.is_ascii_alphanumeric() || b == b'_')
}

fn is_ident_byte(b: u8) -> bool {
    b.is_ascii_alphanumeric() || b == b'_'
}

/// Parse the `( token-string )` operand of an MSVC `__pragma` operator,
/// starting at `start` (just past the `__pragma` keyword). Returns the
/// content between the outer parens verbatim (trimmed) and the byte
/// index just past the closing `)`, or `None` when the parens are
/// missing or unbalanced. `__pragma(X)` is the MSVC analog of C99
/// `_Pragma("X")`: the operand is raw tokens rather than a string
/// literal, so no destringizing applies. Nested parens and string /
/// char literals are tracked so an inner `)` does not close the operand.
fn parse_msvc_pragma_args(text: &str, start: usize) -> Option<(String, usize)> {
    let bytes = text.as_bytes();
    let mut i = start;
    while i < bytes.len() && bytes[i].is_ascii_whitespace() {
        i += 1;
    }
    if i >= bytes.len() || bytes[i] != b'(' {
        return None;
    }
    let inner_start = i + 1;
    let mut depth = 1usize;
    i = inner_start;
    while i < bytes.len() {
        match bytes[i] {
            b'"' | b'\'' => {
                let q = bytes[i];
                i += 1;
                while i < bytes.len() {
                    if bytes[i] == b'\\' {
                        i += 2;
                        continue;
                    }
                    let closed = bytes[i] == q;
                    i += 1;
                    if closed {
                        break;
                    }
                }
            }
            b'(' => {
                depth += 1;
                i += 1;
            }
            b')' => {
                depth -= 1;
                if depth == 0 {
                    return Some((text[inner_start..i].trim().to_string(), i + 1));
                }
                i += 1;
            }
            _ => i += 1,
        }
    }
    None
}

/// Parse the `( string-literal )` operand of a `_Pragma` operator,
/// starting at `start` (just past the `_Pragma` keyword). Returns the
/// destringized pragma text and the byte index just past the closing
/// `)`, or `None` when the operand is malformed (C99 6.10.9). The
/// optional `L` prefix is dropped, the surrounding quotes are removed,
/// and `\"` / `\\` collapse to `"` / `\`.
fn parse_pragma_operator_args(text: &str, start: usize) -> Option<(String, usize)> {
    let bytes = text.as_bytes();
    let mut i = start;
    while i < bytes.len() && bytes[i].is_ascii_whitespace() {
        i += 1;
    }
    if i >= bytes.len() || bytes[i] != b'(' {
        return None;
    }
    i += 1;
    while i < bytes.len() && bytes[i].is_ascii_whitespace() {
        i += 1;
    }
    if i < bytes.len() && bytes[i] == b'L' {
        i += 1;
    }
    if i >= bytes.len() || bytes[i] != b'"' {
        return None;
    }
    i += 1;
    let mut content: Vec<u8> = Vec::new();
    loop {
        if i >= bytes.len() {
            return None;
        }
        match bytes[i] {
            b'"' => {
                i += 1;
                break;
            }
            b'\\' if i + 1 < bytes.len() && (bytes[i + 1] == b'"' || bytes[i + 1] == b'\\') => {
                content.push(bytes[i + 1]);
                i += 2;
            }
            other => {
                content.push(other);
                i += 1;
            }
        }
    }
    let content = String::from_utf8(content).ok()?;
    while i < bytes.len() && bytes[i].is_ascii_whitespace() {
        i += 1;
    }
    if i >= bytes.len() || bytes[i] != b')' {
        return None;
    }
    i += 1;
    Some((content, i))
}

struct CondFrame {
    /// Whether the enclosing branch was active at the time of
    /// `#if` / `#ifdef`. A nested true branch inside an inactive
    /// outer branch must still be inactive.
    parent_active: bool,
    /// Whether *this* arm of the conditional emits source.
    this_branch_taken: bool,
    /// Whether *any* arm so far has emitted source. Used by
    /// `#else` to decide whether to take.
    any_branch_taken: bool,
    /// Already-seen `#else` -- a second one is a hard error.
    saw_else: bool,
}

impl CondFrame {
    // Suppress the unused field warning on `this_branch_taken` --
    // it's part of the struct's vocabulary and might be reached by
    // a future `#elif`.
    #[allow(dead_code)]
    fn _retain_field(&self) -> bool {
        self.this_branch_taken
    }
}

enum Directive<'a> {
    /// Object-like macro: `#define NAME body`.
    Define(&'a str, &'a str),
    /// Function-like macro: `#define NAME(p1, p2, ...) body`. The
    /// parens must be flush against the name -- a space (`#define
    /// NAME (...)`) parses as object-like with `(...)` as the body,
    /// matching the C standard.
    DefineFn(&'a str, Vec<&'a str>, &'a str),
    Undef(&'a str),
    Ifdef(&'a str),
    Ifndef(&'a str),
    If(&'a str),
    Else,
    /// `#elif <expr>` -- like `#else` followed by a re-evaluated
    /// `#if <expr>`, but only takes if no preceding branch did.
    Elif(&'a str),
    Endif,
    Pragma(&'a str),
    /// `#include "header"` (`quoted = true`) or `#include <header>`
    /// (`quoted = false`). A quoted include searches the directory of
    /// the including file before the system search paths (C99
    /// 6.10.2p2-3); an angle include searches only the system paths.
    Include {
        name: &'a str,
        quoted: bool,
    },
    /// `#line N` or `#line N "file"` (C99 6.10.4). The filename
    /// is optional -- bare `#line N` keeps the current file and
    /// just retargets the line counter.
    Line {
        line: usize,
        file: Option<&'a str>,
    },
    /// `#include <pp-tokens>` -- C99 6.10.2p4. The operand isn't
    /// already in `<...>` or `"..."` form, so the preprocessor
    /// has to macro-substitute the tokens before reparsing the
    /// result as one of the two literal include forms. The raw
    /// text is carried verbatim; substitution happens in the
    /// handler.
    IncludeMacro(&'a str),
    /// `#line pp-tokens` whose tokens are not already a literal line
    /// number (C99 6.10.4): the operand is macro-expanded and reparsed
    /// as `#line N ["file"]` in the handler.
    LineMacro(&'a str),
    /// `#error <message>` -- C99 sec 6.10.5. The diagnostic message is
    /// the literal text after `#error` up to the newline.
    Error(&'a str),
    /// `#warning <message>` -- gcc/clang extension, standardised in
    /// C23. Emits a `warning:` diagnostic but, unlike `#error`,
    /// compilation continues. Matches the diagnostic format every
    /// other warning site uses, so downstream tooling can scrape it.
    Warning(&'a str),
    Shebang,
    Other,
}

/// Sub-classification of `#pragma` payloads. `dylib(...)` /
/// `binding(...)` go to [`Preprocessor::parse_pragma`] and live in
/// the dylib registry; `once` is structural (it tags the *current*
/// header) and lives on the preprocessor itself.
enum PragmaDirective {
    Once,
    Other,
}

/// Format a GNU-style line marker (`# N "file"\n`) for the lexer.
/// Filenames get the minimum C-string escape (`\\` and `\"` are
/// escaped, everything else passes through). The lexer's
/// `parse_line_marker` decodes the same shape: it sets
/// `self.line = N - 1` and `self.file = file`, so the very next
/// `\n` consumed by the outer loop bumps `self.line` to `N` --
/// which means the next source line in the buffer is attributed
/// to `(file, N)`.
fn format_line_marker(line: usize, file: &str) -> String {
    let mut escaped = String::with_capacity(file.len());
    for ch in file.chars() {
        match ch {
            '\\' => escaped.push_str("\\\\"),
            '"' => escaped.push_str("\\\""),
            other => escaped.push(other),
        }
    }
    format!("# {line} \"{escaped}\"\n")
}

fn parse_pragma_directive(args: &str) -> PragmaDirective {
    if args.trim() == "once" {
        PragmaDirective::Once
    } else {
        PragmaDirective::Other
    }
}

/// True when `args` is the head of a `pack(...)` pragma -- the
/// preprocessor passes those through verbatim so the lexer can
/// fold them into its `pack_stack` at the right source position
/// (see the `Directive::Pragma` arm in `process_named`).
fn pragma_is_pack(args: &str) -> bool {
    let trimmed = args.trim_start();
    let Some(rest) = trimmed.strip_prefix("pack") else {
        return false;
    };
    // `pack(...)` -- the next non-whitespace byte must be `(`.
    // Anything else (`packfoo`, `pack_extra`) is a different
    // pragma the preprocessor still wants to silently swallow.
    rest.trim_start().starts_with('(')
}

fn parse_directive(rest: &str) -> Directive<'_> {
    if let Some(after) = rest.strip_prefix("define") {
        let after = after.trim_start();
        let (name, rest_after_name) = split_ident(after);
        // Strip `//` line comments from the macro body. Otherwise
        // `#define X 42 // a constant` would expand to "42 // a
        // constant", and the comment text would either swallow the
        // rest of the substitution line (lexer treats `//` as
        // line-comment) or land in the token stream and break
        // parsing. C `/* ... */` comments inside macro bodies
        // aren't supported elsewhere in this dialect, so we don't
        // try to strip those.
        let stripped = match rest_after_name.find("//") {
            Some(i) => &rest_after_name[..i],
            None => rest_after_name,
        };
        // Function-like form: name immediately followed by `(`. The
        // C standard requires no whitespace between the name and the
        // open paren -- a space turns it into an object-like macro
        // whose body starts with `(`. An unclosed paren falls through
        // to the object-like branch with the whole tail as the body,
        // matching how the lexer would see a syntactically broken
        // `#define`.
        if let Some(after_paren) = stripped.strip_prefix('(')
            && let Some(close) = after_paren.find(')')
        {
            let params_str = &after_paren[..close];
            let body = after_paren[close + 1..].trim();
            let params: Vec<&str> = if params_str.trim().is_empty() {
                Vec::new()
            } else {
                params_str.split(',').map(|p| p.trim()).collect()
            };
            return Directive::DefineFn(name, params, body);
        }
        return Directive::Define(name, stripped.trim());
    }
    if let Some(after) = rest.strip_prefix("undef") {
        return Directive::Undef(after.trim());
    }
    if let Some(after) = rest.strip_prefix("ifdef") {
        return Directive::Ifdef(after.trim());
    }
    if let Some(after) = rest.strip_prefix("ifndef") {
        return Directive::Ifndef(after.trim());
    }
    if let Some(after) = rest.strip_prefix("elif") {
        // `#elif EXPR` -- treated as `#else` followed by a re-evaluated
        // `#if EXPR`, but only if no preceding branch was taken.
        if after
            .chars()
            .next()
            .is_none_or(|c| !c.is_ascii_alphanumeric() && c != '_')
        {
            return Directive::Elif(after);
        }
    }
    if let Some(after) = rest.strip_prefix("if") {
        // Discriminate `#if` from `#ifdef`/`#ifndef` -- the latter
        // were caught above.
        if after
            .chars()
            .next()
            .is_none_or(|c| !c.is_ascii_alphanumeric() && c != '_')
        {
            return Directive::If(after);
        }
    }
    if rest.trim_start().starts_with("else") {
        let tail = rest.trim_start().trim_start_matches("else");
        if tail.is_empty() || tail.starts_with(char::is_whitespace) {
            return Directive::Else;
        }
    }
    if rest.trim_start().starts_with("endif") {
        let tail = rest.trim_start().trim_start_matches("endif");
        if tail.is_empty() || tail.starts_with(char::is_whitespace) {
            return Directive::Endif;
        }
    }
    if let Some(after) = rest.strip_prefix("pragma") {
        return Directive::Pragma(after.trim());
    }
    if let Some(after) = rest.strip_prefix("error") {
        // Accept `#error` with no message and `#error <text>`. C99
        // doesn't actually require any message text -- the
        // diagnostic is the directive itself -- but most users
        // expect to be able to write `#error "must be x86"`.
        if after.is_empty() || after.starts_with(char::is_whitespace) {
            return Directive::Error(after.trim_start());
        }
    }
    if let Some(after) = rest.strip_prefix("warning") {
        // `#warning <message>` -- emits a warning and continues.
        // gcc/clang extension; standardised by C23. Same shape as
        // `#error`, just a different severity.
        if after.is_empty() || after.starts_with(char::is_whitespace) {
            return Directive::Warning(after.trim_start());
        }
    }
    if let Some(after) = rest.strip_prefix("line") {
        let trimmed = after.trim();
        // Line number is required.
        let mut split = trimmed.splitn(2, char::is_whitespace);
        if let Some(num) = split.next()
            && let Ok(line) = num.parse::<usize>()
        {
            // Optional `"file"` -- strip surrounding quotes if
            // present. Anything malformed (e.g. unclosed quote)
            // falls through to `Other` and gets silently dropped,
            // matching how every other malformed directive is
            // handled.
            let file = split.next().and_then(|tail| {
                let t = tail.trim();
                t.strip_prefix('"').and_then(|s| s.strip_suffix('"'))
            });
            return Directive::Line { line, file };
        }
        // C99 6.10.4: the operand is not already a digit sequence, so
        // its tokens are macro-expanded and reparsed in the handler.
        if !trimmed.is_empty() {
            return Directive::LineMacro(trimmed);
        }
    }
    if let Some(after) = rest.strip_prefix("include") {
        let trimmed = after.trim();
        // Strip the `<...>` or `"..."` wrapping when the operand
        // is already in one of the two literal forms, recording which
        // form so the handler can apply the quoted-include source-dir
        // search.
        if let Some(name) = trimmed.strip_prefix('<').and_then(|s| s.strip_suffix('>')) {
            return Directive::Include {
                name: name.trim(),
                quoted: false,
            };
        }
        if let Some(name) = trimmed.strip_prefix('"').and_then(|s| s.strip_suffix('"')) {
            return Directive::Include {
                name: name.trim(),
                quoted: true,
            };
        }
        // C99 6.10.2p4: `#include <pp-tokens>` -- when the operand
        // isn't already a `<...>` or `"..."` literal, the
        // preprocessor expands the tokens and re-parses the
        // result as one of the two literal forms. Defer the
        // expansion to the include handler so the caller's
        // macro table is available.
        if !trimmed.is_empty() {
            return Directive::IncludeMacro(trimmed);
        }
    }
    if rest.starts_with('!') {
        return Directive::Shebang;
    }
    // GNU-style line marker: `# N "file" [flags]` -- the C99 form
    // is `#line N "file"` (handled above), but the amalgamator
    // and historic gcc preprocessors emit the keyword-less variant
    // too. Recognise it as `Directive::Line` so it doesn't trip
    // the unknown-directive warning. Trailing flag digits (1 2 3
    // 4) are GNU's enter / leave / system / extern markers; we
    // ignore them since c5 only tracks (file, line).
    let trimmed = rest.trim();
    if trimmed.chars().next().is_some_and(|c| c.is_ascii_digit()) {
        let mut split = trimmed.splitn(2, char::is_whitespace);
        if let Some(num) = split.next()
            && let Ok(line) = num.parse::<usize>()
        {
            let file = split.next().and_then(|tail| {
                let t = tail.trim_start();
                t.strip_prefix('"').and_then(|s| {
                    // Trailing flags after the closing quote are
                    // optional -- match up to the next quote and
                    // discard the rest.
                    s.find('"').map(|end| &s[..end])
                })
            });
            return Directive::Line { line, file };
        }
    }
    Directive::Other
}

/// Parent directory of an include path, or `None` when the path has
/// no directory component (a bare name, the embedded-header label, or
/// the synthetic `<force-include>` / top-level labels). Handles both
/// `/` and `\` separators. Used to resolve a quoted include against
/// the including file's directory.
fn include_parent_dir(filename: &str) -> Option<alloc::string::String> {
    // A bare filename (no directory component) names a file in the
    // current working directory, so a quoted include in it searches the
    // cwd. Return an empty directory; `find_include` joins that as a
    // cwd-relative name. `None` would skip the source-directory step and
    // miss a same-directory header.
    match filename.rfind(['/', '\\']) {
        Some(cut) => Some(filename[..cut].to_string()),
        None => Some(alloc::string::String::new()),
    }
}

/// Split off the leading identifier in `s`, returning `(ident,
/// rest)`. Used to peel the macro name from its replacement text.
fn split_ident(s: &str) -> (&str, &str) {
    let bytes = s.as_bytes();
    let mut end = 0;
    while end < bytes.len() && (bytes[end].is_ascii_alphanumeric() || bytes[end] == b'_') {
        end += 1;
    }
    (&s[..end], &s[end..])
}

/// Parse a comma-separated argument list of a function-like macro
/// invocation. `s` must start at the `(` character. Returns the args
/// (string slices, trimmed) and the byte offset of the position
/// *after* the matching `)` -- relative to `s`. Nested parentheses
/// (e.g. `MACRO(f(x), g(y))`) and string/char literals are tracked so
/// commas inside them don't split. Returns `None` if `s` doesn't open
/// with `(` or the parens are unbalanced.
fn parse_macro_args(s: &str) -> Option<(Vec<String>, usize)> {
    let bytes = s.as_bytes();
    if bytes.is_empty() || bytes[0] != b'(' {
        return None;
    }
    let mut args: Vec<String> = Vec::new();
    let mut current = String::new();
    let mut depth = 1usize;
    let mut i = 1;
    while i < bytes.len() {
        let c = bytes[i];
        match c {
            b'(' => {
                depth += 1;
                current.push('(');
                i += 1;
            }
            b')' => {
                depth -= 1;
                if depth == 0 {
                    // The closing paren ends the final argument. C99
                    // 6.10.3p4: `m()` is a single empty argument, so a
                    // one-parameter macro substitutes its parameter with
                    // nothing rather than leaving the parameter name to
                    // be rescanned. A zero-parameter macro ignores the
                    // spare empty argument at expansion.
                    args.push(current.trim().to_string());
                    return Some((args, i + 1));
                }
                current.push(')');
                i += 1;
            }
            b',' if depth == 1 => {
                args.push(current.trim().to_string());
                current.clear();
                i += 1;
            }
            b'"' | b'\'' => {
                // Copy the whole literal (including escapes) so commas
                // / parens inside don't perturb the depth counter. Use a
                // UTF-8 slice so a multibyte sequence stays intact.
                let quote = c;
                let lit_start = i;
                i += 1;
                while i < bytes.len() && bytes[i] != quote {
                    if bytes[i] == b'\\' && i + 1 < bytes.len() {
                        i += 2;
                    } else {
                        i += 1;
                    }
                }
                if i < bytes.len() {
                    i += 1;
                }
                match core::str::from_utf8(&bytes[lit_start..i]) {
                    Ok(s) => current.push_str(s),
                    Err(_) => {
                        for &b in &bytes[lit_start..i] {
                            current.push(b as char);
                        }
                    }
                }
            }
            _ => {
                current.push(c as char);
                i += 1;
            }
        }
    }
    None
}

/// True if `buffer` contains a known function-like macro name
/// followed by `(` and the matching `)` is *not* in the buffer.
/// Used by the preprocessor's main driver to decide whether the
/// next source line should be appended to the current logical
/// line so a multi-line `assert(\n  expr\n)` call expands. Quotes
/// and char literals are skipped so `"foo("` doesn't trigger.
///
/// Also accepts an object-like macro whose expansion is a single
/// identifier that *is* a function-like macro -- the C99
/// 6.10.3.4 rescan turns `STB_C_LEX_CPP_COMMENTS(if (...) ...)`
/// (where `#define STB_C_LEX_CPP_COMMENTS Y` and `#define Y(a)
/// a`) into a call on `Y`; without joining the source lines
/// here, the rescan in `substitute_with_blocklist` only sees the
/// first line and can't find the matching `)`.
fn macro_call_unclosed(
    buffer: &str,
    fn_macros: &HashMap<String, FnMacro>,
    obj_macros: &HashMap<String, String>,
) -> bool {
    let bytes = buffer.as_bytes();
    let mut i = 0;
    while i < bytes.len() {
        let c = bytes[i];
        if c == b'"' || c == b'\'' {
            let q = c;
            i += 1;
            while i < bytes.len() && bytes[i] != q {
                if bytes[i] == b'\\' && i + 1 < bytes.len() {
                    i += 2;
                } else {
                    i += 1;
                }
            }
            if i < bytes.len() {
                i += 1;
            }
            continue;
        }
        if c.is_ascii_alphabetic() || c == b'_' {
            let start = i;
            i += 1;
            while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                i += 1;
            }
            let name = &buffer[start..i];
            let direct_fn = fn_macros.contains_key(name);
            // Object-like macro that resolves to a fn-like-macro
            // identifier (single-word body). One level of
            // indirection is enough for the canonical
            // `#define ALIAS Y` followed by `Y(args)` shape;
            // deeper chains are vanishingly rare in real headers.
            let indirect_fn = !direct_fn && {
                obj_macros
                    .get(name)
                    .map(|body| {
                        let t = body.trim();
                        !t.is_empty()
                            && t.bytes().all(|b| b.is_ascii_alphanumeric() || b == b'_')
                            && t.bytes().next().is_some_and(|b| !b.is_ascii_digit())
                            && fn_macros.contains_key(t)
                    })
                    .unwrap_or(false)
            };
            if direct_fn || indirect_fn {
                let mut j = i;
                while j < bytes.len()
                    && (bytes[j] == b' ' || bytes[j] == b'\t' || bytes[j] == b'\n')
                {
                    j += 1;
                }
                if j < bytes.len() && bytes[j] == b'(' && parse_macro_args(&buffer[j..]).is_none() {
                    return true;
                }
            }
            continue;
        }
        i += 1;
    }
    false
}

/// Substitute `params` for `args` in a function-like macro body.
/// Whole-word match -- a parameter named `T` replaces only the
/// identifier `T`, never `T` inside another word like `Tx`.
///
/// Also handles the C99 macro operators:
///   - `#param` stringifies the literal argument text into a string
///     literal (with `\` and `"` escaped).
///   - `a ## b` token-pastes the two surrounding tokens after
///     substitution, dropping any whitespace around the `##`.
///   - `__VA_ARGS__` substitutes the variadic-tail args joined with
///     `, ` for variadic macros (`#define foo(...)` /
///     `#define foo(a, ...)`).
/// Value produced by the `#if`-expression evaluator.
///
/// `Int` is the c99 integer-constant case (`#if X >= 5`); `Str` is
/// the c5 extension where macros can hold quoted strings (`#if
/// __BADC_TARGET__ == "macos-aarch64"`). The two interop only via
/// equality / inequality -- mixing them in arithmetic is rejected.
#[derive(Debug, Clone)]
enum IfValue {
    Int(i64),
    Str(String),
}

impl IfValue {
    fn truthy(&self) -> bool {
        match self {
            IfValue::Int(n) => *n != 0,
            IfValue::Str(s) => !s.is_empty(),
        }
    }
    fn as_int(&self) -> i64 {
        match self {
            IfValue::Int(n) => *n,
            IfValue::Str(s) => {
                // String coerced to int: 0 unless the bytes happen
                // to parse as a number. Real c programs rarely
                // mix; this is purely defensive.
                s.parse().unwrap_or(0)
            }
        }
    }
}

/// Tiny recursive-descent parser for `#if` expressions. Mirrors the
/// c99 precedence (top to bottom):
///
///   `||` | `&&` | `|` | `^` | `&` | `== !=` | `< <= > >=` |
///   `<< >>` | `+ -` | `* / %` | unary `! - + ~` | primary
///
/// Primaries are integer literals (decimal / hex / octal with the
/// usual c99 suffixes), `defined(NAME)` / `defined NAME`, identifiers
/// (resolved through the macro table -- undefined names evaluate to
/// 0), parenthesised sub-expressions, and string literals (preserved
/// for the c5-extension `==`/`!=` shape).
/// Recursion bound for the `#if` controlling-expression parser. Each
/// level descends the full precedence cascade (a dozen frames), so the
/// bound is conservative enough to hold within a 1 MiB stack (the
/// Windows main-thread default). Real `#if` expressions nest only a few
/// parentheses deep; past the bound, deeply nested or generator-produced
/// input yields a diagnostic instead of a stack-overflow abort.
const MAX_IF_EXPR_DEPTH: usize = 100;

/// Recursion bound for macro substitution. Each expansion frame is
/// cheap, so this can sit higher than the `#if`-expression bound while
/// still keeping a pathologically deep (but blocklist-terminating)
/// expansion from overflowing the stack.
const MAX_MACRO_DEPTH: usize = 200;

struct IfExprParser<'a> {
    src: &'a str,
    pos: usize,
    pp: &'a Preprocessor,
    /// Recursion depth, bounded by [`MAX_IF_EXPR_DEPTH`]. Every recursive
    /// cycle in the grammar passes through `parse_unary`, so the bound is
    /// checked there.
    depth: usize,
}

impl<'a> IfExprParser<'a> {
    fn new(src: &'a str, pp: &'a Preprocessor) -> Self {
        Self {
            src,
            pos: 0,
            pp,
            depth: 0,
        }
    }
    fn at_end(&self) -> bool {
        self.pos >= self.src.len()
    }
    fn tail(&self) -> &str {
        &self.src[self.pos..]
    }
    fn peek_byte(&self) -> Option<u8> {
        self.src.as_bytes().get(self.pos).copied()
    }
    fn skip_ws(&mut self) {
        while let Some(b) = self.peek_byte() {
            if b.is_ascii_whitespace() {
                self.pos += 1;
            } else {
                break;
            }
        }
    }
    fn eat(&mut self, s: &str) -> bool {
        self.skip_ws();
        if self.src[self.pos..].starts_with(s) {
            self.pos += s.len();
            true
        } else {
            false
        }
    }
    fn eat_byte(&mut self, b: u8) -> bool {
        self.skip_ws();
        if self.peek_byte() == Some(b) {
            self.pos += 1;
            true
        } else {
            false
        }
    }

    fn parse_or(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_and()?;
        loop {
            self.skip_ws();
            if self.eat("||") {
                let right = self.parse_and()?;
                left = IfValue::Int((left.truthy() || right.truthy()) as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    /// C99 6.10.1p1 / 6.5.15: `#if` accepts a ternary at the top of
    /// the expression precedence. `cond ? then : else` -- both
    /// branches are evaluated unconditionally and the picked one is
    /// returned (no short-circuit semantics inside a constant
    /// expression). Right-associative, so the `else` arm recurses.
    fn parse_ternary(&mut self) -> Result<IfValue, C5Error> {
        let cond = self.parse_or()?;
        self.skip_ws();
        if !self.eat_byte(b'?') {
            return Ok(cond);
        }
        let then_v = self.parse_ternary()?;
        self.skip_ws();
        if !self.eat_byte(b':') {
            return Err(C5Error::Compile(
                "preprocessor: missing `:` in `#if` ternary expression".to_string(),
            ));
        }
        let else_v = self.parse_ternary()?;
        Ok(if cond.truthy() { then_v } else { else_v })
    }

    fn parse_and(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_bitor()?;
        loop {
            self.skip_ws();
            if self.eat("&&") {
                let right = self.parse_bitor()?;
                left = IfValue::Int((left.truthy() && right.truthy()) as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_bitor(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_bitxor()?;
        loop {
            self.skip_ws();
            // Single `|`, but only if not followed by another `|`
            // (which would be `||`, the OR operator we already handled).
            if self.peek_byte() == Some(b'|')
                && self.src.as_bytes().get(self.pos + 1) != Some(&b'|')
            {
                self.pos += 1;
                let right = self.parse_bitxor()?;
                left = IfValue::Int(left.as_int() | right.as_int());
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_bitxor(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_bitand()?;
        loop {
            self.skip_ws();
            if self.eat_byte(b'^') {
                let right = self.parse_bitand()?;
                left = IfValue::Int(left.as_int() ^ right.as_int());
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_bitand(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_eq()?;
        loop {
            self.skip_ws();
            if self.peek_byte() == Some(b'&')
                && self.src.as_bytes().get(self.pos + 1) != Some(&b'&')
            {
                self.pos += 1;
                let right = self.parse_eq()?;
                left = IfValue::Int(left.as_int() & right.as_int());
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_eq(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_rel()?;
        loop {
            self.skip_ws();
            if self.eat("==") {
                let right = self.parse_rel()?;
                left = IfValue::Int(if_value_eq(&left, &right) as i64);
            } else if self.eat("!=") {
                let right = self.parse_rel()?;
                left = IfValue::Int(!if_value_eq(&left, &right) as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_rel(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_shift()?;
        loop {
            self.skip_ws();
            if self.eat("<=") {
                let right = self.parse_shift()?;
                left = IfValue::Int((left.as_int() <= right.as_int()) as i64);
            } else if self.eat(">=") {
                let right = self.parse_shift()?;
                left = IfValue::Int((left.as_int() >= right.as_int()) as i64);
            } else if self.peek_byte() == Some(b'<')
                && self.src.as_bytes().get(self.pos + 1) != Some(&b'<')
            {
                self.pos += 1;
                let right = self.parse_shift()?;
                left = IfValue::Int((left.as_int() < right.as_int()) as i64);
            } else if self.peek_byte() == Some(b'>')
                && self.src.as_bytes().get(self.pos + 1) != Some(&b'>')
            {
                self.pos += 1;
                let right = self.parse_shift()?;
                left = IfValue::Int((left.as_int() > right.as_int()) as i64);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_shift(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_addsub()?;
        loop {
            self.skip_ws();
            if self.eat("<<") {
                let right = self.parse_addsub()?;
                // Use the wrapping bit-pattern shift so a left
                // shift past bit 63 doesn't panic. The
                // preprocessor stores both signed and unsigned
                // values in `i64` per 6.10.1p4 widest-integer
                // semantics; left shift on either type is
                // bit-pattern identical.
                let shift = (right.as_int() & 63) as u32;
                let n = (left.as_int() as u64).wrapping_shl(shift) as i64;
                left = IfValue::Int(n);
            } else if self.eat(">>") {
                let right = self.parse_addsub()?;
                // C99 6.5.7p5: the right shift of a signed
                // negative value is implementation-defined.
                // c5's preprocessor uses logical (zero-fill)
                // shift in both modes so that bit-pattern
                // literals like `ULONG_MAX >> 31` -- where
                // ULONG_MAX is stored as the wrap of `u64::MAX`
                // -- yield their unsigned answer rather than
                // the arithmetic-shift `-1`. The
                // `((ULONG_MAX >> 31) >> 31) == 3` 64-bit-host
                // probe shape standard in C library headers
                // relies on the unsigned interpretation.
                let shift = (right.as_int() & 63) as u32;
                let n = (left.as_int() as u64).wrapping_shr(shift) as i64;
                left = IfValue::Int(n);
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_addsub(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_muldiv()?;
        loop {
            self.skip_ws();
            if self.eat_byte(b'+') {
                let right = self.parse_muldiv()?;
                left = IfValue::Int(left.as_int().wrapping_add(right.as_int()));
            } else if self.eat_byte(b'-') {
                let right = self.parse_muldiv()?;
                left = IfValue::Int(left.as_int().wrapping_sub(right.as_int()));
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_muldiv(&mut self) -> Result<IfValue, C5Error> {
        let mut left = self.parse_unary()?;
        loop {
            self.skip_ws();
            if self.eat_byte(b'*') {
                let right = self.parse_unary()?;
                left = IfValue::Int(left.as_int().wrapping_mul(right.as_int()));
            } else if self.eat_byte(b'/') {
                let right = self.parse_unary()?;
                let r = right.as_int();
                left = IfValue::Int(if r == 0 { 0 } else { left.as_int() / r });
            } else if self.eat_byte(b'%') {
                let right = self.parse_unary()?;
                let r = right.as_int();
                left = IfValue::Int(if r == 0 { 0 } else { left.as_int() % r });
            } else {
                break;
            }
        }
        Ok(left)
    }

    fn parse_unary(&mut self) -> Result<IfValue, C5Error> {
        // Every recursive cycle (parentheses through the precedence
        // cascade, ternary arms, and unary chains) reaches `parse_unary`,
        // so bounding its depth bounds the whole grammar.
        self.depth += 1;
        if self.depth > MAX_IF_EXPR_DEPTH {
            self.depth -= 1;
            return Err(C5Error::Compile(
                "preprocessor: `#if` expression nested too deeply".to_string(),
            ));
        }
        let r = self.parse_unary_inner();
        self.depth -= 1;
        r
    }

    fn parse_unary_inner(&mut self) -> Result<IfValue, C5Error> {
        self.skip_ws();
        if self.eat_byte(b'!') {
            let v = self.parse_unary()?;
            return Ok(IfValue::Int((!v.truthy()) as i64));
        }
        if self.eat_byte(b'~') {
            let v = self.parse_unary()?;
            return Ok(IfValue::Int(!v.as_int()));
        }
        if self.eat_byte(b'-') {
            let v = self.parse_unary()?;
            return Ok(IfValue::Int(-v.as_int()));
        }
        if self.eat_byte(b'+') {
            return self.parse_unary();
        }
        self.parse_primary()
    }

    fn parse_primary(&mut self) -> Result<IfValue, C5Error> {
        self.skip_ws();
        if self.eat_byte(b'(') {
            let v = self.parse_ternary()?;
            self.skip_ws();
            if !self.eat_byte(b')') {
                return Err(C5Error::Compile(
                    "preprocessor: missing `)` in `#if` expression".to_string(),
                ));
            }
            return Ok(v);
        }
        if self.eat_byte(b'"') {
            // String literal -- read to closing `"`. No escape
            // handling beyond plain bytes; the c5 use cases compare
            // simple paths.
            let start = self.pos;
            while let Some(b) = self.peek_byte() {
                if b == b'"' {
                    let s = self.src[start..self.pos].to_string();
                    self.pos += 1;
                    return Ok(IfValue::Str(format!("\"{s}\"")));
                }
                self.pos += 1;
            }
            return Err(C5Error::Compile(
                "preprocessor: unterminated string in `#if` expression".to_string(),
            ));
        }
        // C11 6.4.4.4: a character constant may carry an `L`, `u`, or
        // `U` encoding prefix (`L'/'`). In a `#if` controlling
        // expression its value is the character code, so the prefix is
        // consumed and the literal read as below.
        if let Some(&p) = self.src.as_bytes().get(self.pos)
            && matches!(p, b'L' | b'u' | b'U')
            && self.src.as_bytes().get(self.pos + 1) == Some(&b'\'')
        {
            self.pos += 1;
        }
        if self.eat_byte(b'\'') {
            // Character literal -- a single byte, optionally escaped.
            // Multi-char (`'AB'`) is implementation-defined; we use
            // the last byte, which matches gcc's choice.
            let bytes = self.src.as_bytes();
            let mut acc: i64 = 0;
            while let Some(b) = self.peek_byte() {
                if b == b'\'' {
                    self.pos += 1;
                    return Ok(IfValue::Int(acc));
                }
                if b == b'\\' && self.pos + 1 < bytes.len() {
                    self.pos += 2;
                    let esc = bytes[self.pos - 1];
                    let ch = match esc {
                        b'n' => 0x0A,
                        b't' => 0x09,
                        b'r' => 0x0D,
                        b'0' => 0x00,
                        b'\\' => b'\\',
                        b'\'' => b'\'',
                        b'"' => b'"',
                        b'a' => 0x07,
                        b'b' => 0x08,
                        b'f' => 0x0C,
                        b'v' => 0x0B,
                        other => other,
                    };
                    acc = (acc << 8) | (ch as i64);
                } else {
                    acc = (acc << 8) | (b as i64);
                    self.pos += 1;
                }
            }
            return Err(C5Error::Compile(
                "preprocessor: unterminated char literal in `#if`".to_string(),
            ));
        }
        // Integer literal? Decimal, hex (0x...), or octal (0...).
        if let Some(b) = self.peek_byte() {
            if b.is_ascii_digit() {
                return self.parse_int_literal();
            }
            if b.is_ascii_alphabetic() || b == b'_' {
                return self.parse_ident_or_defined();
            }
        }
        Err(C5Error::Compile(alloc::format!(
            "preprocessor: unexpected `{}` in `#if` expression",
            self.tail().chars().next().unwrap_or(' ')
        )))
    }

    fn parse_int_literal(&mut self) -> Result<IfValue, C5Error> {
        let bytes = self.src.as_bytes();
        let start = self.pos;
        let mut radix: u32 = 10;
        if bytes.get(self.pos) == Some(&b'0') {
            if bytes.get(self.pos + 1) == Some(&b'x') || bytes.get(self.pos + 1) == Some(&b'X') {
                self.pos += 2;
                radix = 16;
            } else if bytes
                .get(self.pos + 1)
                .is_some_and(|b| (*b as char).is_ascii_digit())
            {
                self.pos += 1;
                radix = 8;
            } else {
                self.pos += 1;
            }
        }
        let body_start = self.pos;
        while let Some(b) = self.peek_byte() {
            let is_digit = match radix {
                16 => b.is_ascii_hexdigit(),
                _ => b.is_ascii_digit(),
            };
            if !is_digit {
                break;
            }
            self.pos += 1;
        }
        // Eat any integer suffix (uUlL combinations) without
        // touching the value.
        while let Some(b) = self.peek_byte() {
            if matches!(b, b'u' | b'U' | b'l' | b'L') {
                self.pos += 1;
            } else {
                break;
            }
        }
        let body = self.src[start..self.pos].trim_end_matches(['u', 'U', 'l', 'L']);
        // C99 6.10.1p4: preprocessor expressions evaluate in
        // (u)intmax_t. A literal that does not fit `i64` (the
        // signed widest type) but does fit `u64` is parsed
        // as `u64` and stored as its bit pattern in `i64`.
        // This handles `ULONG_MAX` / `UINT64_MAX` literals
        // (e.g. `18446744073709551615`) when they appear in a
        // `#if` expression on an LP64 host.
        let (digits, raw_radix) = if radix == 10 {
            (body, 10u32)
        } else if radix == 16 {
            (
                body.trim_start_matches("0x").trim_start_matches("0X"),
                16u32,
            )
        } else {
            (body.trim_start_matches('0'), radix)
        };
        let v = if digits.is_empty() {
            Ok(0i64)
        } else if let Ok(signed) = i64::from_str_radix(digits, raw_radix) {
            Ok(signed)
        } else if let Ok(unsigned) = u64::from_str_radix(digits, raw_radix) {
            Ok(unsigned as i64)
        } else {
            Err(())
        };
        let _ = body_start;
        match v {
            Ok(n) => Ok(IfValue::Int(n)),
            Err(()) => Err(C5Error::Compile(alloc::format!(
                "preprocessor: malformed integer literal {body:?} in `#if`",
            ))),
        }
    }

    fn parse_ident_or_defined(&mut self) -> Result<IfValue, C5Error> {
        let start = self.pos;
        while let Some(b) = self.peek_byte() {
            if b.is_ascii_alphanumeric() || b == b'_' {
                self.pos += 1;
            } else {
                break;
            }
        }
        let name = &self.src[start..self.pos];
        if name == "defined" {
            // `defined NAME` or `defined(NAME)` -- both are valid.
            self.skip_ws();
            let with_paren = self.eat_byte(b'(');
            self.skip_ws();
            let id_start = self.pos;
            while let Some(b) = self.peek_byte() {
                if b.is_ascii_alphanumeric() || b == b'_' {
                    self.pos += 1;
                } else {
                    break;
                }
            }
            if id_start == self.pos {
                return Err(C5Error::Compile(
                    "preprocessor: identifier expected after `defined`".to_string(),
                ));
            }
            let id = self.src[id_start..self.pos].to_string();
            if with_paren {
                self.skip_ws();
                if !self.eat_byte(b')') {
                    return Err(C5Error::Compile(
                        "preprocessor: missing `)` after `defined(NAME`".to_string(),
                    ));
                }
            }
            return Ok(IfValue::Int(self.pp.macros.contains_key(&id) as i64));
        }
        // C23 6.10.1 / universal compiler practice: `__has_include(<h>)`
        // and `__has_include("h")` evaluate to 1 when the header is
        // found on the include search path, 0 otherwise.
        // `__has_include_next` follows the same grammar; c5 resolves it
        // against the same paths.
        if name == "__has_include" || name == "__has_include_next" {
            self.skip_ws();
            if !self.eat_byte(b'(') {
                return Err(C5Error::Compile(
                    "preprocessor: `(` expected after `__has_include`".to_string(),
                ));
            }
            self.skip_ws();
            let close = if self.eat_byte(b'<') {
                b'>'
            } else if self.eat_byte(b'"') {
                b'"'
            } else {
                return Err(C5Error::Compile(
                    "preprocessor: `<header>` or \"header\" expected in `__has_include`"
                        .to_string(),
                ));
            };
            let h_start = self.pos;
            while let Some(b) = self.peek_byte() {
                if b == close {
                    break;
                }
                self.pos += 1;
            }
            let header = self.src[h_start..self.pos].to_string();
            self.eat_byte(close);
            self.skip_ws();
            if !self.eat_byte(b')') {
                return Err(C5Error::Compile(
                    "preprocessor: missing `)` in `__has_include`".to_string(),
                ));
            }
            let found = self.pp.find_include(&header, None).is_some();
            return Ok(IfValue::Int(found as i64));
        }
        // Identifier -- look up in the macro table. Function-like
        // macros are skipped (they need an argument list which the
        // preprocessor evaluator doesn't simulate). Undefined names
        // are 0 per c99 sec 6.10.1p4.
        if let Some(value) = self.pp.macros.get(name) {
            // Strip a leading/trailing quote pair to detect strings.
            if value.starts_with('"') && value.ends_with('"') {
                return Ok(IfValue::Str(value.clone()));
            }
            // Numeric? Try parsing.
            if let Ok(n) = value.parse::<i64>() {
                return Ok(IfValue::Int(n));
            }
            // The macro might itself be a name; recursively expand
            // (bounded) and try once more. The bare-identifier case
            // in c99 evaluates an undefined macro to 0; a defined
            // macro whose body isn't a number falls through to a
            // string-shaped value.
            let expanded = self.pp.expand_or_self(name);
            if let Ok(n) = expanded.parse::<i64>() {
                return Ok(IfValue::Int(n));
            }
            return Ok(IfValue::Str(expanded));
        }
        Ok(IfValue::Int(0))
    }
}

fn if_value_eq(a: &IfValue, b: &IfValue) -> bool {
    match (a, b) {
        (IfValue::Int(x), IfValue::Int(y)) => x == y,
        (IfValue::Str(x), IfValue::Str(y)) => x == y,
        (IfValue::Int(x), IfValue::Str(y)) | (IfValue::Str(y), IfValue::Int(x)) => {
            // Mixed: prefer int interpretation if the string parses,
            // else compare numerically with 0.
            y.trim_matches('"').parse::<i64>().ok() == Some(*x)
        }
    }
}

/// True when a body identifier names the variadic tail: the standard
/// `__VA_ARGS__`, or the GCC named-rest parameter (`#define foo(rest...)`
/// reaches the tail through `rest`).
fn is_va_token(def: &FnMacro, word: &str) -> bool {
    word == "__VA_ARGS__" || def.va_name.as_deref() == Some(word)
}

fn expand_fn_macro(def: &FnMacro, args: &[String], raw_args: &[String]) -> String {
    // Pre-compute the comma-joined string for __VA_ARGS__. Empty when
    // the macro isn't variadic or no trailing args were supplied. The
    // raw form (unexpanded arguments) feeds the `#` and `##` operands
    // per C99 6.10.3.1 / 6.10.3.2; the expanded form feeds ordinary
    // substitution.
    let var_start = def.params.len();
    let join_from = |src: &[String]| -> String {
        if def.is_variadic && src.len() > var_start {
            src[var_start..].join(", ")
        } else {
            String::new()
        }
    };
    let va_args_str = join_from(args);
    let raw_va_args_str = join_from(raw_args);

    let bytes = def.body.as_bytes();
    let mut out = String::with_capacity(def.body.len());
    let mut i = 0;
    // True when the next token is the right-hand operand of a `##`, so
    // it must substitute from the unexpanded argument.
    let mut after_paste = false;
    while i < bytes.len() {
        let c = bytes[i];
        if c == b'#' && i + 1 < bytes.len() && bytes[i + 1] == b'#' {
            // GNU `, ## <variadic>` comma idiom: when a comma precedes
            // `##` and the right operand is the variadic tail, this is
            // not an ordinary token paste. An empty tail deletes the
            // comma (`f(fmt, ##__VA_ARGS__)` with no extra args ->
            // `f(fmt)`); a non-empty tail keeps the comma and the tail.
            let mut k = i + 2;
            while k < bytes.len() && (bytes[k] == b' ' || bytes[k] == b'\t') {
                k += 1;
            }
            let word_start = k;
            while k < bytes.len() && (bytes[k].is_ascii_alphanumeric() || bytes[k] == b'_') {
                k += 1;
            }
            let right_is_va = def.is_variadic && is_va_token(def, &def.body[word_start..k]);
            if right_is_va && out.trim_end().ends_with(',') {
                if raw_va_args_str.is_empty() {
                    while out.ends_with(' ') || out.ends_with('\t') {
                        out.pop();
                    }
                    out.pop();
                    i = k;
                } else {
                    i = word_start;
                }
                continue;
            }
            // Ordinary token-paste: drop the `##` and any whitespace
            // bracketing it. `a ## b` joins the *tokens* before / after
            // the operator; for c5's textual preprocessor that means
            // trim trailing whitespace from what we've already emitted,
            // then skip the operator and any leading whitespace before
            // the next token.
            while out.ends_with(' ') || out.ends_with('\t') {
                out.pop();
            }
            i += 2;
            while i < bytes.len() && (bytes[i] == b' ' || bytes[i] == b'\t') {
                i += 1;
            }
            after_paste = true;
            continue;
        }
        let preceded_by_paste = after_paste;
        after_paste = false;
        if c == b'#' {
            // Stringification: `#param` -> `"<arg>"`. The C standard
            // says the operand must be a parameter; we follow that
            // and pass a stray `#` through unchanged. The operand uses
            // the unexpanded argument (C99 6.10.3.2p2).
            let mut j = i + 1;
            while j < bytes.len() && (bytes[j] == b' ' || bytes[j] == b'\t') {
                j += 1;
            }
            if j < bytes.len() && (bytes[j].is_ascii_alphabetic() || bytes[j] == b'_') {
                let start = j;
                while j < bytes.len() && (bytes[j].is_ascii_alphanumeric() || bytes[j] == b'_') {
                    j += 1;
                }
                let name = &def.body[start..j];
                let arg_text: Option<&str> = if def.is_variadic && is_va_token(def, name) {
                    Some(raw_va_args_str.as_str())
                } else if let Some(idx) = def.params.iter().position(|p| p == name) {
                    raw_args.get(idx).map(|s| s.as_str())
                } else {
                    None
                };
                if let Some(arg) = arg_text {
                    out.push_str(&stringize_arg(arg));
                    i = j;
                    continue;
                }
            }
            out.push('#');
            i += 1;
        } else if let Some(plen) = literal_prefix_len(bytes, i) {
            // An `L`/`u`/`U`/`u8` prefix belongs to the following string
            // or char literal (C99 6.4.5 / 6.4.4.4); emit it verbatim so
            // a parameter named `L`/`u`/`U` doesn't capture it. The
            // literal body is copied by the `"`/`'` arm on the next
            // iteration.
            out.push_str(&def.body[i..i + plen]);
            i += plen;
        } else if c.is_ascii_alphabetic() || c == b'_' {
            let start = i;
            i += 1;
            while i < bytes.len() && (bytes[i].is_ascii_alphanumeric() || bytes[i] == b'_') {
                i += 1;
            }
            let word = &def.body[start..i];
            // A parameter that is an operand of `##` (immediately
            // before or after the operator) substitutes from the
            // unexpanded argument (C99 6.10.3.1p1).
            let followed_by_paste = {
                let mut k = i;
                while k < bytes.len() && (bytes[k] == b' ' || bytes[k] == b'\t') {
                    k += 1;
                }
                k + 1 < bytes.len() && bytes[k] == b'#' && bytes[k + 1] == b'#'
            };
            let use_raw = preceded_by_paste || followed_by_paste;
            let params = if use_raw { raw_args } else { args };
            let va = if use_raw {
                &raw_va_args_str
            } else {
                &va_args_str
            };
            if def.is_variadic && is_va_token(def, word) {
                out.push_str(va);
            } else {
                match def.params.iter().position(|p| p == word) {
                    Some(idx) if idx < params.len() => out.push_str(&params[idx]),
                    _ => out.push_str(word),
                }
            }
        } else if c == b'"' || c == b'\'' {
            // Pass literals through unchanged so identifier-like bytes
            // inside don't get substituted. Copy the byte range as a
            // UTF-8 slice rather than byte by byte so a multibyte
            // sequence isn't re-encoded per byte (`as char` widening).
            let quote = c;
            let lit_start = i;
            i += 1;
            while i < bytes.len() && bytes[i] != quote {
                if bytes[i] == b'\\' && i + 1 < bytes.len() {
                    i += 2;
                } else {
                    i += 1;
                }
            }
            if i < bytes.len() {
                i += 1;
            }
            match core::str::from_utf8(&bytes[lit_start..i]) {
                Ok(s) => out.push_str(s),
                Err(_) => {
                    for &b in &bytes[lit_start..i] {
                        out.push(b as char);
                    }
                }
            }
        } else {
            out.push(c as char);
            i += 1;
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;

    fn process(source: &str) -> String {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.process(source).expect("preprocessor failed")
    }

    #[test]
    fn predefined_macros_expand() {
        let out = process("char *t = __BADC_TARGET__;\nchar *v = __BADC_VERSION__;\n");
        assert!(out.contains("\"macos-aarch64\""));
        assert!(out.contains("\"0.1.0\""));
    }

    #[test]
    fn gnu_identity_macros_are_opt_in() {
        // `__GNUC__` and `__STRICT_ANSI__` are undefined by default.
        let probe = "#ifdef __GNUC__\nG yes\n#else\nG no\n#endif\n\
                     #ifdef __STRICT_ANSI__\nS yes\n#else\nS no\n#endif\n";
        let out = process(probe);
        assert!(
            out.contains("G no") && out.contains("S no"),
            "default: {out}"
        );

        // `enable_gnu` (the `--gnu` flag) defines both.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.enable_gnu();
        let out = pp.process(probe).expect("preprocessor failed");
        assert!(
            out.contains("G yes") && out.contains("S yes"),
            "--gnu: {out}"
        );
    }

    #[test]
    fn vendor_and_stdc_pragmas_are_silent() {
        // GCC/clang vendor pragmas and the C99 6.10.6 STDC pragmas carry
        // no directive c5 acts on, so they must not warn.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.process(
            "#pragma GCC diagnostic push\n\
             #pragma GCC diagnostic ignored \"-Wunused\"\n\
             #pragma GCC diagnostic pop\n\
             #pragma GCC optimize(\"O2\")\n\
             #pragma clang loop unroll(disable)\n\
             #pragma STDC FP_CONTRACT OFF\n\
             int x;\n",
        )
        .expect("preprocessor failed");
        assert!(
            pp.warnings.is_empty(),
            "unexpected warnings: {:?}",
            pp.warnings
        );

        // An unrecognised pragma still surfaces a warning.
        let mut pp2 = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp2.process("#pragma frobnicate widgets\nint y;\n")
            .expect("preprocessor failed");
        assert!(!pp2.warnings.is_empty(), "unknown pragma should warn");
    }

    #[test]
    fn self_referential_function_macro_in_nested_arg() {
        // C99 6.10.3.4: a self-referential function-like macro
        // (`#define M(x) M(inner(x))`) expands once and the recurring `M`
        // is not re-expanded, while `inner` in an argument still expands.
        // The blue-paint carries the painted `M(` through a nested call.
        let out = process(
            "#define _Py_CAST(t, e) ((t)(e))\n\
             #define _PyObject_CAST(op) _Py_CAST(void*, (op))\n\
             #define GET(m) GET(_PyObject_CAST(m))\n\
             #define DECREF(o) DECREF(_PyObject_CAST(o))\n\
             void f(void *self) { DECREF(GET(self)); }\n",
        );
        assert!(
            out.contains("DECREF(((void*)((GET(((void*)((self))))))))"),
            "self-referential macros expanded wrong: {out}"
        );
        assert!(!out.contains("_PyObject_CAST"), "leftover macro: {out}");
    }

    #[test]
    fn lp64_predefined_for_lp64_targets_only() {
        let src = "#ifdef __LP64__\nint lp64;\n#endif\n#ifdef _LP64\nint _lp64;\n#endif\n";
        for t in [Target::MacOSAarch64, Target::LinuxAarch64, Target::LinuxX64] {
            let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
            let out = pp.process(src).expect("preprocessor failed");
            assert!(out.contains("int lp64;"), "{t:?} should define __LP64__");
            assert!(out.contains("int _lp64;"), "{t:?} should define _LP64");
        }
        // Windows is LLP64 (32-bit long), so neither macro is defined.
        for t in [Target::WindowsX64, Target::WindowsAarch64] {
            let mut pp = Preprocessor::new(t.id_str(), t, "0.1.0");
            let out = pp.process(src).expect("preprocessor failed");
            assert!(!out.contains("int lp64;"), "{t:?} must not define __LP64__");
        }
    }

    #[test]
    fn define_substitutes_in_subsequent_lines() {
        let out = process("#define FOO 42\nint x = FOO;\n");
        assert!(out.contains("int x = 42;"));
    }

    #[test]
    fn macro_body_block_comment_spanning_lines() {
        // A `\`-continued macro whose body holds a block comment that
        // spans a physical-line break, where the comment-opening line
        // carries no trailing `\`. The newline inside the comment must
        // not terminate the definition (C99 5.1.1.2). Before the fix the
        // body truncated at the comment and `b = 1;` leaked to file scope.
        let src = "#define M(x) \\\n    do { \\\n        /* one\n           two */ \\\n        x = 1; \\\n    } while (0)\nint after;\nM(after);\n";
        let out = process(src);
        // The whole body is one macro, so `do {` and `while (0)` land on
        // the expansion line together and `after` is the only file-scope
        // object before the expansion.
        assert!(out.contains("do {"), "macro body lost: {out:?}");
        assert!(out.contains("while (0)"), "macro tail leaked: {out:?}");
        assert!(out.contains("int after;"), "{out:?}");
    }

    #[test]
    fn block_comment_open_detector() {
        assert!(ends_in_open_block_comment("foo /* bar"));
        assert!(!ends_in_open_block_comment("foo /* bar */ baz"));
        assert!(!ends_in_open_block_comment("foo // /* not open"));
        assert!(!ends_in_open_block_comment("s = \"/*\""));
        assert!(ends_in_open_block_comment("c = '/' ; /* open"));
    }

    #[test]
    fn cli_empty_define_expands_to_nothing() {
        // `-D NAME` (no `=`) is `1`; `-D NAME=` (with `=`, empty) stays
        // empty and expands to nothing -- the cpp convention, e.g.
        // `-DSQLITE_PRIVATE=` so `SQLITE_PRIVATE void f();` is `void f();`.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.define("EMPTY", "");
        pp.define("ONE", "1");
        let out = pp
            .process("EMPTY void f(void);\nint x = ONE;\n")
            .expect("preprocessor failed");
        assert!(out.contains("void f(void);"), "got: {out:?}");
        assert!(
            !out.contains("1 void f"),
            "empty define leaked a 1: {out:?}"
        );
        assert!(out.contains("int x = 1;"));
    }

    #[test]
    fn macro_to_macro_substitution_chains() {
        let out = process("#define A B\n#define B 5\nint x = A;\n");
        assert!(out.contains("int x = 5;"));
    }

    #[test]
    fn pragma_operator_once_marks_file() {
        // C99 6.10.9: `_Pragma("once")` in the main file is handled like
        // `#pragma once` and leaves no tokens in the output.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let out = pp
            .process("_Pragma(\"once\")\nint x = 1;\n")
            .expect("preprocessor failed");
        assert!(!out.contains("_Pragma"), "operator leaked: {out:?}");
        assert!(out.contains("int x = 1;"));
    }

    #[test]
    fn pragma_operator_via_macro_stringize() {
        // The operand can be produced by the `#x` stringize feeding the
        // operator (`_Pragma(#x)`), the common `DO_PRAGMA` idiom.
        let out = process("#define DO_PRAGMA(x) _Pragma(#x)\nDO_PRAGMA(once)\nint y = 2;\n");
        assert!(!out.contains("_Pragma"), "operator leaked: {out:?}");
        assert!(out.contains("int y = 2;"));
    }

    #[test]
    fn pragma_operator_pack_emits_inline_directive() {
        // `pack` is position-sensitive, so the operator re-emits an
        // inline `#pragma pack` for the lexer to fold at this point.
        let out = process("_Pragma(\"pack(1)\")\nstruct S { char a; };\n");
        assert!(out.contains("#pragma pack(1)"), "no inline pack: {out:?}");
    }

    #[test]
    fn pragma_operator_ignored_inside_string_literal() {
        // The operator name inside a string literal is ordinary text.
        let out = process("const char *s = \"_Pragma(\\\"once\\\")\";\n");
        assert!(out.contains("\"_Pragma(\\\"once\\\")\""), "got: {out:?}");
    }

    #[test]
    fn msvc_pragma_operator_warning_leaves_no_tokens() {
        // MSVC `__pragma(tokens)` carries a `#pragma` directive with a raw
        // token operand; `warning(...)` is handled and contributes no tokens.
        let out = process("__pragma(warning(disable : 4201))\nint x = 1;\n");
        assert!(!out.contains("__pragma"), "operator leaked: {out:?}");
        assert!(out.contains("int x = 1;"));
    }

    #[test]
    fn msvc_pragma_operator_pack_emits_inline_directive() {
        // `pack` via `__pragma` re-emits an inline `#pragma pack` like the
        // C99 `_Pragma` path, so the lexer folds it at this position.
        let out = process("__pragma(pack(1))\nstruct S { char a; };\n");
        assert!(out.contains("#pragma pack(1)"), "no inline pack: {out:?}");
    }

    #[test]
    fn msvc_pragma_operator_ignored_inside_string_literal() {
        // The operator name inside a string literal is ordinary text.
        let out = process("const char *s = \"__pragma(warning(pop))\";\n");
        assert!(out.contains("\"__pragma(warning(pop))\""), "got: {out:?}");
    }

    #[test]
    fn named_rest_variadic_macro_binds_tail() {
        // `#define foo(rest...)` reaches the trailing args through `rest`.
        let out = process("#define F(args...) g(args)\nF(1, 2, 3);\n");
        assert!(out.contains("g(1, 2, 3);"), "got: {out:?}");
    }

    #[test]
    fn named_rest_variadic_macro_fixed_plus_tail() {
        let out = process("#define F(a, rest...) g(a, rest)\nF(1, 2, 3);\n");
        assert!(out.contains("g(1, 2, 3);"), "got: {out:?}");
    }

    #[test]
    fn named_rest_variadic_macro_paste_elides_comma() {
        // `, ##rest` drops the comma when the tail is empty, matching the
        // `, ##__VA_ARGS__` GNU behaviour.
        let out = process("#define F(a, rest...) g(a, ##rest)\nF(1);\nF(1, 2);\n");
        assert!(out.contains("g(1);"), "empty tail not elided: {out:?}");
        assert!(out.contains("g(1, 2);"), "non-empty tail: {out:?}");
    }

    #[test]
    fn named_rest_variadic_macro_stringize() {
        let out = process("#define S(rest...) #rest\nconst char *s = S(a, b);\n");
        assert!(out.contains("\"a, b\""), "got: {out:?}");
    }

    #[test]
    fn function_like_macro_substitutes_params() {
        let out = process("#define ADD(a, b) ((a) + (b))\nint x = ADD(1, 2);\n");
        assert!(
            out.contains("int x = ((1) + (2));"),
            "fn-like macro should substitute both params:\n{out}"
        );
    }

    #[test]
    fn function_like_macro_preserves_nested_call_args() {
        // Args with nested parens / calls shouldn't be split by the
        // top-level comma scanner.
        let out = process("#define WRAP(x) f(x)\nint y = WRAP(g(1, 2));\n");
        assert!(
            out.contains("int y = f(g(1, 2));"),
            "nested-paren args should round-trip:\n{out}"
        );
    }

    #[test]
    fn function_like_macro_only_fires_when_followed_by_paren() {
        // `va_end` style: calling with parens expands; the bare name
        // (no parens) stays a plain identifier.
        let out = process("#define NOOP(x)\nNOOP(arg);\nint NOOP;\n");
        assert!(out.contains(";\nint NOOP;"));
    }

    #[test]
    fn guarded_mutual_include_is_not_cyclic() {
        // Two headers may include each other when an include guard breaks the
        // recursion: the second pass over a guarded header skips its body
        // (C99 6.10.1 / 6.10.2). The preprocessor must process the re-include
        // rather than reject it as a cycle on the bare observation that the
        // name is already on the include path.
        use std::io::Write;
        let dir = std::env::temp_dir().join(format!("badc_pp_guard_{}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        std::fs::File::create(dir.join("a.h"))
            .unwrap()
            .write_all(b"#ifndef A_H\n#define A_H\n#include \"b.h\"\nint a_marker;\n#endif\n")
            .unwrap();
        std::fs::File::create(dir.join("b.h"))
            .unwrap()
            .write_all(b"#ifndef B_H\n#define B_H\n#include \"a.h\"\nint b_marker;\n#endif\n")
            .unwrap();
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.add_search_path(dir.to_str().unwrap());
        let out = pp
            .process("#include \"a.h\"\n")
            .expect("guarded mutual include must not be reported cyclic");
        std::fs::remove_dir_all(&dir).ok();
        assert_eq!(
            out.matches("a_marker").count(),
            1,
            "a body included once:\n{out}"
        );
        assert_eq!(
            out.matches("b_marker").count(),
            1,
            "b body included once:\n{out}"
        );
    }

    #[test]
    fn stringify_operator_quotes_argument() {
        let out = process("#define STR(x) #x\nchar *s = STR(hello world);\n");
        assert!(
            out.contains("\"hello world\""),
            "stringification should produce a string literal:\n{out}"
        );
    }

    #[test]
    fn stringify_escapes_quote_and_backslash() {
        // The arg is the string-literal token `"hi"` (a balanced-quoted
        // pair) -- macro_args parses it as one arg whose text is
        // literally `"hi"`. Stringification must wrap that in another
        // pair of quotes and escape the inner ones, yielding
        // `"\"hi\""`.
        let out = process("#define STR(x) #x\nchar *s = STR(\"hi\");\n");
        assert!(
            out.contains("\"\\\"hi\\\"\""),
            "stringification must escape `\"`:\n{out}"
        );
    }

    #[test]
    fn token_paste_joins_tokens() {
        let out = process("#define PASTE(a, b) a ## b\nint PASTE(x, y) = 0;\n");
        assert!(
            out.contains("int xy = 0;"),
            "## should produce the joined identifier:\n{out}"
        );
    }

    #[test]
    fn variadic_macro_expands_va_args() {
        let out = process("#define CALL(...) f(__VA_ARGS__)\nCALL(1, 2, 3);\n");
        assert!(
            out.contains("f(1, 2, 3);"),
            "__VA_ARGS__ should join the variadic args with `, `:\n{out}"
        );
    }

    #[test]
    fn variadic_macro_with_fixed_param() {
        let out =
            process("#define LOG(level, ...) printf(level, __VA_ARGS__)\nLOG(\"x\", 1, 2);\n");
        assert!(
            out.contains("printf(\"x\", 1, 2);"),
            "fixed param + __VA_ARGS__ should both substitute:\n{out}"
        );
    }

    #[test]
    fn fn_like_macro_recurses_through_other_macros() {
        // An object-like macro whose body contains a function-like
        // macro call should re-expand: TWICE -> INC(INC(0)) -> the
        // INC names disappear and a `+ 1` appears twice. The exact
        // paren shape depends on what each INC step adds, so the
        // test pins the structural facts rather than the literal
        // spelling.
        let out = process("#define INC(n) ((n) + 1)\n#define TWICE INC(INC(0))\nint x = TWICE;\n");
        assert!(!out.contains("INC"), "INC should be fully expanded:\n{out}");
        assert_eq!(
            out.matches("+ 1").count(),
            2,
            "two increments expected:\n{out}"
        );
    }

    #[test]
    fn define_strips_trailing_line_comment() {
        // Without the strip, the substitution would expand to
        // `int x = 42 // a constant ;` and the lexer's `//` would
        // swallow the trailing `;`, breaking parsing entirely.
        let out = process("#define FOO 42 // a constant\nint x = FOO;\n");
        assert!(
            out.contains("int x = 42;"),
            "expected `int x = 42;` after macro expansion, got:\n{out}"
        );
        assert!(!out.contains("// a constant"));
    }

    #[test]
    fn ifdef_keeps_active_branch() {
        let src = "#define FOO 1\n#ifdef FOO\nint a;\n#else\nint b;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int a;"));
        assert!(!out.contains("int b;"));
    }

    #[test]
    fn ifdef_sees_function_like_macro() {
        // C99 6.10.1: `#ifdef` / `#ifndef` test definedness for any
        // macro, including function-like ones (kept in a separate
        // table from object-like macros).
        let src = "#define F(x) ((x)+1)\n#ifdef F\nint a;\n#else\nint b;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int a;"), "#ifdef should see fn-like macro F");
        assert!(!out.contains("int b;"));
        let src2 = "#define F(x) ((x)+1)\n#ifndef F\nint a;\n#else\nint b;\n#endif\n";
        let out2 = process(src2);
        assert!(
            out2.contains("int b;"),
            "#ifndef of a defined fn-like macro takes #else"
        );
        assert!(!out2.contains("int a;"));
    }

    #[test]
    fn ifndef_keeps_inactive_branch() {
        let src = "#ifndef BAR\nint a;\n#else\nint b;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int a;"));
        assert!(!out.contains("int b;"));
    }

    #[test]
    fn if_equality_checks_macro_value() {
        let src = "#if __BADC_TARGET__ == \"macos-aarch64\"\nint mac;\n#else\nint other;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int mac;"));
        assert!(!out.contains("int other;"));
    }

    #[test]
    fn if_inequality_negates() {
        let src = "#if __BADC_TARGET__ != \"windows-x64\"\nint here;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int here;"));
    }

    #[test]
    fn nested_conditionals_respect_parent() {
        let src =
            "#ifdef ABSENT\n#ifdef __BADC_VERSION__\nint inner;\n#endif\n#endif\nint outer;\n";
        let out = process(src);
        assert!(!out.contains("int inner;"));
        assert!(out.contains("int outer;"));
    }

    #[test]
    fn pragma_records_dylib() {
        let src = "\
#pragma dylib(libfoo, \"libfoo.so\")
#pragma dylib(bar, \"bar.dll\")
";
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.process(src).unwrap();
        let entries: Vec<(&str, &str)> = pp
            .dylibs
            .iter()
            .map(|d| (d.name.as_str(), d.path.as_str()))
            .collect();
        assert_eq!(entries, vec![("libfoo", "libfoo.so"), ("bar", "bar.dll")]);
    }

    #[test]
    fn pragma_binding_attaches_to_named_dylib() {
        let src = "\
#pragma dylib(libfoo, \"libfoo.so\")
#pragma dylib(libbar, \"libbar.so\")
#pragma binding(libfoo::printf, \"_printf\")
#pragma binding(libbar::exit, \"ExitProcess\")
#pragma binding(libfoo::malloc, \"_malloc\")
";
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.process(src).unwrap();
        assert_eq!(pp.dylibs.len(), 2);
        assert_eq!(pp.dylibs[0].name, "libfoo");
        assert_eq!(pp.dylibs[0].bindings.len(), 2);
        assert_eq!(pp.dylibs[0].bindings[0].local_name, "printf");
        assert_eq!(pp.dylibs[0].bindings[0].real_symbol, "_printf");
        assert_eq!(pp.dylibs[0].bindings[1].local_name, "malloc");
        assert_eq!(pp.dylibs[1].name, "libbar");
        assert_eq!(pp.dylibs[1].bindings.len(), 1);
        assert_eq!(pp.dylibs[1].bindings[0].local_name, "exit");
        assert_eq!(pp.dylibs[1].bindings[0].real_symbol, "ExitProcess");
    }

    #[test]
    fn pragma_binding_for_undeclared_dylib_errors() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp
            .process("#pragma binding(libnothing::printf, \"_printf\")\n")
            .unwrap_err();
        assert!(format!("{err}").contains("no `#pragma dylib(libnothing, ...)`"));
    }

    #[test]
    fn pragma_binding_without_qualifier_errors() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp
            .process("#pragma dylib(libfoo, \"x\")\n#pragma binding(printf, \"p\")\n")
            .unwrap_err();
        assert!(format!("{err}").contains("LHS must be `dylib_name::local_name`"));
    }

    #[test]
    fn pragma_dylib_duplicate_errors() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp
            .process("#pragma dylib(libfoo, \"x\")\n#pragma dylib(libfoo, \"y\")\n")
            .unwrap_err();
        assert!(format!("{err}").contains("already declared"));
    }

    #[test]
    fn unmatched_endif_is_an_error() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp.process("#endif\n").unwrap_err();
        assert!(format!("{err}").contains("`#endif` with no matching `#if`"));
    }

    #[test]
    fn unterminated_block_is_an_error() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let err = pp.process("#ifdef FOO\nint x;\n").unwrap_err();
        assert!(format!("{err}").contains("unterminated"));
    }

    #[test]
    fn leading_marker_names_top_level_source() {
        // every preprocessed buffer opens with a GNU line
        // marker so the lexer attributes the first source line to
        // `(<source>, 1)` rather than letting its initial state
        // decide. Without this, an `#include` later in the buffer
        // would never have a "previous file" to return to.
        let out = process("int x;\n");
        assert!(out.starts_with("# 1 \"<source>\"\n"));
    }

    #[test]
    fn line_directive_retargets_file_and_line() {
        // `#line N "file"` rewrites the lexer's
        // `(file, line)` state so the next source line is
        // attributed to `(file, N)`.
        let out = process("#line 100 \"fakegen.c\"\nint x;\n");
        // The `#line` line itself is consumed by the marker; the
        // next non-blank output should be a `# 100 "fakegen.c"`
        // marker followed (eventually) by `int x;`.
        assert!(out.contains("# 100 \"fakegen.c\""));
        assert!(out.contains("int x;"));
    }

    #[test]
    fn line_directive_without_filename_keeps_current_file() {
        // C99 6.10.4: bare `#line N` retargets the line counter
        // but leaves the filename alone.
        let out = process("#line 50\nint x;\n");
        // The marker re-uses the current filename (`<source>`).
        assert!(out.contains("# 50 \"<source>\""));
    }

    #[test]
    fn directives_become_blank_lines_for_line_alignment() {
        // The preprocessor prepends a `# 1 "<source>"\n` GNU line
        // marker so the lexer can attribute later tokens to a
        // specific (file, line). Skip it before counting.
        let src = "#define X 1\nint a = X;\n";
        let out = process(src);
        let lines: Vec<&str> = out.lines().skip_while(|l| l.starts_with('#')).collect();
        assert_eq!(lines.len(), 2);
        assert_eq!(lines[0], "");
        assert!(lines[1].contains("int a = 1;"));
    }

    #[test]
    fn string_literals_are_not_substituted() {
        let src = "#define X 1\nchar *s = \"X is a letter\";\n";
        let out = process(src);
        assert!(out.contains("\"X is a letter\""));
    }

    #[test]
    fn defined_form_works_in_if() {
        let src = "#if defined(__BADC_VERSION__)\nint a;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int a;"));
    }

    #[test]
    fn wide_char_constant_in_if() {
        // C11 6.4.4.4: a character constant in a `#if` controlling
        // expression may carry an `L` / `u` / `U` encoding prefix.
        let src = "#define SEP L'/'\n#if SEP == '/'\nint yes;\n#else\nint no;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int yes;"), "{out:?}");
        assert!(!out.contains("int no;"), "{out:?}");
    }

    #[test]
    fn has_include_operator_in_if() {
        // C23 6.10.1: `__has_include(<header>)` is 1 when the header
        // resolves, 0 otherwise; `defined(__has_include)` is the guard.
        let src = "#if defined(__has_include) && __has_include(<stdint.h>)\nint found;\n#endif\n\
                   #if __has_include(<no_such_header_zz.h>)\nint bogus;\n#endif\n";
        let out = process(src);
        assert!(out.contains("int found;"), "{out:?}");
        assert!(!out.contains("int bogus;"), "{out:?}");
    }

    #[test]
    fn unknown_include_is_silently_dropped() {
        // Headers not in the embedded registry no-op so legacy
        // sources sprinkled with `#include <fcntl.h>` keep building
        // until a real header takes that slot. The compile keeps
        // going; the warning surfaces separately via
        // `pp.warnings`.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let out = pp
            .process("#include <not-a-real-header.h>\nint main() { return 0; }\n")
            .expect("preprocessor failed");
        assert!(out.contains("int main()"));
        assert_eq!(pp.warnings.len(), 1);
        assert!(
            pp.warnings[0].contains("not found"),
            "missing-include warning shape: {}",
            pp.warnings[0]
        );
    }

    #[test]
    fn counter_monotonically_increases() {
        // Each `__COUNTER__` expansion advances the per-TU
        // counter, starting from 0. The `##` paste here mints
        // unique identifiers, the canonical use case. Three levels
        // of indirection are required: `##` operands use the
        // unexpanded argument (C99 6.10.3.1), so the extra `CAT`
        // layer forces `__COUNTER__` to expand before the paste.
        let src = "\
#define CAT_(a, b) a##b
#define CAT(a, b)  CAT_(a, b)
#define UNIQUE(prefix) CAT(prefix, __COUNTER__)
int UNIQUE(x_);
int UNIQUE(x_);
int x_2 = __COUNTER__;
";
        let out = process(src);
        assert!(out.contains("int x_0;"), "first counter use: {out}");
        assert!(out.contains("int x_1;"), "second counter use: {out}");
        assert!(out.contains("int x_2 = 2"), "third counter use: {out}");
    }

    #[test]
    fn counter_resets_per_preprocessor_instance() {
        // Each fresh Preprocessor starts its counter at 0 -- two
        // separate translation units don't share state.
        let mut pp1 = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let out1 = pp1.process("int a = __COUNTER__;\n").unwrap();
        assert!(out1.contains("int a = 0"));
        let mut pp2 = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let out2 = pp2.process("int a = __COUNTER__;\n").unwrap();
        assert!(out2.contains("int a = 0"));
    }

    #[test]
    fn pragma_warning_disable_records_ids() {
        // `#pragma warning(disable : N N N)`. Each ID lands in
        // `warning_disabled`.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp
            .process("#pragma warning(disable : 4054 4055 4100)\n")
            .expect("preprocessor failed");
        assert!(
            pp.warnings.is_empty(),
            "expected no warnings: {:?}",
            pp.warnings
        );
        assert_eq!(
            pp.warning_disabled.iter().copied().collect::<Vec<_>>(),
            vec![4054_u32, 4055, 4100]
        );
    }

    #[test]
    fn pragma_warning_enable_clears_ids() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp
            .process(
                "#pragma warning(disable : 100 200 300)\n\
                 #pragma warning(enable : 200)\n",
            )
            .unwrap();
        assert_eq!(
            pp.warning_disabled.iter().copied().collect::<Vec<_>>(),
            vec![100_u32, 300]
        );
    }

    #[test]
    fn pragma_warning_push_pop_restores_state() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp
            .process(
                "#pragma warning(disable : 100)\n\
                 #pragma warning(push)\n\
                 #pragma warning(disable : 200)\n\
                 #pragma warning(pop)\n",
            )
            .unwrap();
        assert!(pp.warning_disabled.contains(&100));
        assert!(!pp.warning_disabled.contains(&200));
    }

    #[test]
    fn pragma_warning_pop_without_push_warns() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp.process("#pragma warning(pop)\n").unwrap();
        assert!(
            pp.warnings.iter().any(|w| w.contains("no matching push")),
            "expected unmatched-pop warning: {:?}",
            pp.warnings
        );
    }

    #[test]
    fn pragma_warning_bad_action_warns() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp.process("#pragma warning(silence : 4267)\n").unwrap();
        assert!(
            pp.warnings.iter().any(|w| w.contains("silence")),
            "expected unrecognised-action warning: {:?}",
            pp.warnings
        );
    }

    #[test]
    fn pragma_warning_bad_id_warns() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp.process("#pragma warning(disable : abc)\n").unwrap();
        assert!(
            pp.warnings
                .iter()
                .any(|w| w.contains("expected an integer")),
            "expected bad-ID warning: {:?}",
            pp.warnings
        );
    }

    #[test]
    fn pragma_warning_push_with_level_accepted() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp
            .process(
                "#pragma warning(push, 3)\n\
                 #pragma warning(disable : 100)\n\
                 #pragma warning(pop)\n",
            )
            .unwrap();
        assert!(pp.warnings.is_empty(), "got warnings: {:?}", pp.warnings);
        assert!(pp.warning_disabled.is_empty());
    }

    #[test]
    fn pragma_warn_disable_codes_recorded() {
        // Borland / Watcom form: `-<code>` per warning category
        // to silence. Multiple tokens per line are accepted.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp
            .process(
                "#pragma warn -rch\n\
                 #pragma warn -aus -csu\n",
            )
            .unwrap();
        assert!(pp.warnings.is_empty(), "got warnings: {:?}", pp.warnings);
        let codes: Vec<&str> = pp.warn_disabled.iter().map(|s| s.as_str()).collect();
        assert_eq!(codes, vec!["aus", "csu", "rch"]);
    }

    #[test]
    fn pragma_warn_plus_and_dot_clear() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp
            .process(
                "#pragma warn -rch -aus -csu\n\
                 #pragma warn +aus\n\
                 #pragma warn .csu\n",
            )
            .unwrap();
        let codes: Vec<&str> = pp.warn_disabled.iter().map(|s| s.as_str()).collect();
        assert_eq!(codes, vec!["rch"]);
    }

    #[test]
    fn pragma_warn_bad_sign_warns() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp.process("#pragma warn rch\n").unwrap();
        assert!(
            pp.warnings.iter().any(|w| w.contains("leading")),
            "expected bad-sign warning: {:?}",
            pp.warnings
        );
    }

    #[test]
    fn pragma_warn_empty_warns() {
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp.process("#pragma warn\n").unwrap();
        assert!(
            pp.warnings.iter().any(|w| w.contains("no payload")),
            "expected empty-payload warning: {:?}",
            pp.warnings
        );
    }

    #[test]
    fn unknown_directive_warns() {
        // C99 6.10.6 reserves non-directive forms for the
        // implementation; gcc / clang warn rather than fail.
        // c5 follows that shape.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        let _ = pp
            .process("#frobnicate args\nint main() { return 0; }\n")
            .expect("preprocessor failed");
        assert!(
            pp.warnings.iter().any(|w| w.contains("`#frobnicate`")),
            "expected a warning naming `#frobnicate`; got {:?}",
            pp.warnings
        );
    }

    #[test]
    fn show_includes_records_resolution_trace() {
        // gcc `-H`-shape trace -- one line per `#include`, with
        // leading dots marking nesting depth. A missing header
        // emits a `! name (missing)` line in the same trace.
        let mut pp = Preprocessor::new("macos-aarch64", Target::MacOSAarch64, "0.1.0");
        pp.set_show_includes(true);
        let _ = pp
            .process("#include <not-a-real-header.h>\nint main() { return 0; }\n")
            .expect("preprocessor failed");
        assert!(
            pp.include_trace
                .iter()
                .any(|l| l.starts_with("!") && l.contains("not-a-real-header.h")),
            "trace should mark missing header: {:?}",
            pp.include_trace
        );
    }

    #[test]
    fn quoted_include_form_is_recognised() {
        // `"foo.h"` and `<foo.h>` go through the same registry today.
        // The quoted form is still parsed -- we'd just look it up the
        // same way -- so an unknown name no-ops cleanly.
        let out = process("#include \"not-a-real-header.h\"\nint main() {}\n");
        assert!(out.contains("int main()"));
    }

    #[test]
    fn include_parent_dir_resolves_bare_filename_to_cwd() {
        // A bare source filename names a file in the current directory,
        // so a quoted include in it must search the cwd (empty dir,
        // joined cwd-relative by find_include), not be skipped.
        assert_eq!(super::include_parent_dir("src.c"), Some(String::new()));
        assert_eq!(
            super::include_parent_dir("dir/src.c"),
            Some("dir".to_string())
        );
        assert_eq!(
            super::include_parent_dir("/abs/dir/src.c"),
            Some("/abs/dir".to_string())
        );
    }
}
