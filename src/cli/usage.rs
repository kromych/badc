pub(crate) const USAGE: &str = "\
usage: badc [options] <input...> [program-args...]
       badc [options] -    [program-args...]   (read source from stdin)
       cat foo.c | badc [options]              (same -- stdin auto-detected
                                                when not a terminal)

Inputs are positional and may mix `.c` sources, `.s` / `.S`
assembly sources, c5 `.o` objects, and `.a` archives. A single
`.c` input compiles and emits a binary directly; two or more
inputs (or any `-l` / `-L` / `-c` flag) run through the cross-TU
linker. `.S` (and `.sx`) run through the preprocessor with
`__ASSEMBLER__` predefined before being assembled; `.s` is
assembled verbatim, as in gcc's suffix table.

Output mode -- pick at most one (defaults to a native binary):
  --interp                 Run under the SSA interpreter.
  --jit                    Lower in-process and call main() directly.
  --shared                 Produce a shared library (.dylib / .so /
                           .dll) exporting every #pragma export(name)
                           function.
  --list-symbols           Print built-in keywords / library calls /
                           constants and exit.
  --list-diagnostics       Print the diagnostic catalogue -- code,
                           name, default level, class, groups -- and
                           exit.
  --explain <selector>     Print one catalogue row and exit. The
                           selector is a diagnostic name, an alias, or
                           a `B` code.
  --dump-headers           Print every bundled header to stdout and
                           exit. Useful for extracting a header into
                           `./include` to override it locally.
  --install [<dir>]        Write every embedded header and the runtime
                           source under <dir> (default ~/.badc, or
                           $BADC_HOME), recreating the include/ + lib/
                           hierarchy, then exit. Later runs prefer the
                           installed copies: ~/.badc/include is searched
                           before the embedded headers and
                           ~/.badc/lib/runtime.c overrides the embedded
                           runtime, so editing an installed file changes
                           the build without rebuilding badc.
  --dump-pp, -E            Run the preprocessor on the input and
                           write the expanded source to `-o`'s path,
                           or to stdout when `-o` is absent or names
                           `-`. Mirrors gcc / clang `-E`.

Multi-TU knobs:
  -c, --compile-only       Emit a c5 `.o` per source instead of
                           linking. Output is `-o`'s path when a
                           single source is named, otherwise
                           `<stem>.o` next to each input. The
                           output is a standard ELF64 ET_REL
                           object (machine code + symbol table +
                           relocs) linkable by `ld` / `lld`.
                           Target pins at compile time.
  -L <dir>                 Archive search path for `-l<name>`.
                           Repeatable; probed in declared order.
  -l <name>                Pull `lib<name>.a` in as a static
                           library. Members are pulled in on demand.
  -Map=<file>, -Map <file> Write a GNU-ld-style link map (output
                           sections, per-input-section placement,
                           symbol addresses) to <file>. ELF output
                           only.
  --print-map              Print the link map to stdout.
  --jobs N, -jN            Compile independent `.c` sources
                           concurrently in up to 2*N worker threads
                           (capped at the source count). Output is
                           byte-identical to a sequential build and
                           diagnostics stay grouped per source in
                           source order. Defaults to the host's
                           available parallelism.

Compile knobs:
  -O, --optimize           Run the SSA optimization passes (mem2reg,
                           inlining, rotate and branch const-fold,
                           immediate dedup) and predefine `NDEBUG=1`
                           and `__OPTIMIZE__=1` (override with `-D` /
                           `-U`). Off by default. The
                           `-O1`/`-O2`/`-O3`/`-Os`/`-Oz`/`-Ofast`/`-Og`
                           forms all select this single level; `-O0`
                           disables it.
  -g, --debug              Emit DWARF debug info. Off by default;
                           adds ~10-30% to the output size.
  -g0, --no-debug          Skip DWARF emission (the default).
  --freestanding           Do not link the embedded startup runtime.
                           The image enters at the program's own entry
                           (`__c5_entry` by default, or the
                           `#pragma entrypoint` symbol), which the
                           program must define. A Linux image is a
                           static executable unless it binds a
                           shared-library symbol.

  --target=<spec>          Pick the binary format (one of
                           macos-aarch64, linux-aarch64, linux-x64,
                           windows-x64, windows-arm64). Defaults to
                           the host. Ignored under --interp / --jit
                           (those always target the host).
  -o <path>                Output path. Default depends on output
                           mode and target (.exe / .dylib / .so /
                           .dll suffixes added as appropriate). A
                           stdin source defaults to `a.bin`
                           (`a.exe` on Windows targets).
  -D NAME[=VALUE]          Predefine an object-like macro
                           (`-D X` <=> `-D X=1`).
  -U NAME                  Drop a predefine, including any
                           default predefine.
  -I path                  Add a header search path, probed before
                           the bundled headers on #include.
                           Repeatable. A badc built from its own
                           source tree also searches that tree's
                           `libc/include`, so an edited bundled
                           header overrides the embedded one.
  -iquote path             Add a search path for #include \"...\" only,
                           probed after the including file's directory
                           and before the -I paths. Repeatable.
  -fno-builtin[-<name>]    Treat a call spelled with a library
  -ffreestanding           function's own name as an ordinary call the
                           compiler may not fold, and drop the C99
                           7.1.4p2 recovery that declares an undeclared
                           library function by auto-including its
                           header. The `__builtin_` spellings keep
                           folding. -fbuiltin / -fhosted restore the
                           default.
  -nostdinc                Drop the bundled standard headers and the
                           system directories from the #include search,
                           leaving only -I, -iquote and the including
                           file's own directory. A name none of those
                           carries is an error instead of resolving to
                           badc's libc, and the auto-include retry is
                           off. The compiler's own headers
                           (`_builtins.h`, `arm_neon.h`) stay, as gcc's
                           builtins do.
  -include FILE            Splice the named header in front of the
                           source as if `#include \"FILE\"` opened
                           the translation unit. Repeatable; later
                           flags expand after earlier ones.
  -H, --show-includes      Print every #include's resolved path to
                           stderr (gcc -H shape; leading dots mark
                           nesting depth; missing headers print as
                           `! <name> (missing)`).
  -M                       Write a make dependency rule naming the
                           source and every header it opened, and
                           compile nothing. Goes to stdout unless
                           -MF (or -o) names a file.
  -MM                      As -M, but omit system headers: the
                           compiler's own header set and anything
                           resolved from a system fallback
                           directory. Headers from -I, -iquote or
                           the including file's directory are user
                           headers and stay.
  -MD                      Write the rule to a file and compile as
                           usual. The file is -MF, else the -o
                           object with its suffix replaced by `.d`,
                           else the source's base name + `.d`.
  -MMD                     As -MD with -MM's header filter. This is
                           the form kbuild uses.
  -MF file                 Write the dependency rule to `file`.
  -MT target               Name the rule's target, used verbatim.
                           Repeatable; replaces the default name.
  -MQ target               As -MT, but quote the name for make.
  -MP                      Add an empty rule for each prerequisite
                           so a deleted header does not stop make.
  -w                       Report no warning at all.
  -Wall / -Wextra          Enable a group of diagnostics, following
  -Wpedantic               gcc's split. --list-diagnostics prints the
                           group each row belongs to.
  -W<sel> / -Wno-<sel>     Report or ignore one diagnostic. A selector
                           is its name, an alias, its `B` code, or a
                           group name; an unknown one is refused.
  -Werror / -Wno-error     Report every warning as an error, or undo
                           that. The unit still parses whole and fails
                           at the end of the phase, as gcc does.
  -Werror=<sel>            Report one diagnostic as an error, or put it
  -Wno-error=<sel>         back to a warning.
  -Wa,<opt>[,<opt>]        Hand an option to the assembler. badc's
  -Xassembler <opt>        assembler is built in, so each option is
                           checked against what it implements rather
                           than passed on; an option it does not
                           implement is refused by name. `-Wa,-L`
                           (`--keep-locals`) keeps the local-label
                           temporaries -- the `.L`-prefixed names --
                           in a `-c` object's symbol table, which
                           GNU as drops without it.
  -m16 / -m32 / -m64       Code model, x86 targets only. `-m16` and
                           `-m32` preprocess the unit as i386 (`__i386__`
                           defined, `__x86_64__` not, ILP32 widths) and
                           put its object out as ELFCLASS32 / EM_386, as
                           gcc's `as --32` does; `.code16` / `.code32`
                           in the source select the encoding. badc
                           generates no i386 machine code, so a `.c`
                           source under either is refused unless -E.
  -Wp,-MD,file             The preprocessor spellings of -MD / -MMD,
  -Wp,-MMD,file            which take the output path as an operand.
                           kbuild passes dependency generation this
                           way. As in gcc, the rule keeps the
                           source-derived name; -o does not name it.
  -q, --quiet              Suppress `info:` chatter on stderr (the
                           per-source `info: compiling <path>`
                           progress line in multi-TU mode and the
                           `info: wrote file <path>` line emitted
                           after each output write). Errors and
                           warnings are unaffected.
  --export-all             Export every non-static function in native
                           output (Mach-O / ELF / PE) so a runtime
                           dlopen consumer can dlsym it without a
                           #pragma export. Applies to --shared and
                           executable output.
  --export-data            Export every non-static data global from an
                           ELF executable into .dynsym (STT_OBJECT) so a
                           dlopen'd module resolves it, the data half of
                           the toolchain's -rdynamic. Pair with
                           --export-all for full coverage.
  --gnu                    Define the GCC identity macros (__GNUC__,
                           __VERSION__, __extension__, ...). Off by
                           default: badc implements most but not all of
                           the GNU C surface, so code gating a feature
                           badc lacks (__int128) on __GNUC__ keeps
                           compiling unless this is requested.
  -std=<dialect>           Language dialect. badc compiles C99 with the
                           GNU extensions always available, so the name
                           selects only whether __STRICT_ANSI__ is
                           defined under --gnu: `gnu*` clears it, `c*` /
                           `iso*` set it, as gcc and clang do. Without
                           the flag --gnu reports strict conformance.
  -fgnu89-inline           Use the GNU89 inline linkage model: `extern
                           inline` provides no external definition and a
                           plain `inline` does. The default is C99
                           6.7.4p6, which is the inverse. Per function,
                           __attribute__((gnu_inline)) selects GNU89
                           whatever the default is. With --gnu the model
                           is reported as __GNUC_GNU_INLINE__ /
                           __GNUC_STDC_INLINE__.
  -fstrict-flex-arrays[=N] Which trailing array members
                           __builtin_object_size treats as unbounded
                           when reached through a pointer: at level 0
                           (the default, as in gcc) every one, at 1
                           those declared [], [0] or [1], at 2 those
                           declared [] or [0], at 3 only []. The bare
                           form selects level 3. A [] member is
                           unbounded at every level.
  -fno-jump-tables         Dispatch every switch through the compare
                           tree, never a jump table, so no switch takes
                           an indirect branch. -fjump-tables restores
                           the default.
  -fPIC, -fpic             Emit a position-independent `-c` object: a
  -fPIE, -fpie             switch table takes the label-difference form,
                           so no absolute relocation reaches the object.
                           Final images are position-independent either
                           way.
  -fno-pic, -fno-pie       Compile the `-c` object for a link that
                           resolves its relocations statically, keeping
                           a relocation-carrying `const` in .rodata.
                           Without it such storage goes to .data.rel.ro,
                           so the unit's remaining `const` objects keep
                           the image's read-only prefix. Implied by
                           -mcmodel=kernel.
  -fmin-function-alignment=N
                           Start every function at a multiple of N
                           bytes (a power of two), filling the gap with
                           NOPs and raising the code section's own
                           alignment to match. The default 1 packs each
                           function against its predecessor. A symbol's
                           size covers its instructions only; the fill
                           belongs to no function.
  -fpatchable-function-entry=N[,M]
                           Put N NOPs at every function entry, M of them
                           (default 0) ahead of the symbol, and record
                           the area's first byte in a per-function
                           __patchable_function_entries section linked
                           to the function's text section. A function's
                           patchable_function_entry attribute replaces
                           the pair; the alignment above applies to the
                           area's first byte. ELF targets.
  -pg                      Call the profiling entry point from every
                           function not marked no_instrument_function:
                           __fentry__ at the symbol under -mfentry (the
                           default), mcount after the prologue under
                           -mno-fentry. linux-x64 only.
  -mrecord-mcount          Record every -pg call site in an __mcount_loc
                           section.
  -mnop-mcount             Put a NOP of the call's width in each -pg
                           call's place.
  -ffixed-REG              Keep register REG out of the allocator, so no
                           compiler-chosen value lives in it. Any
                           architectural spelling names it (x9 / w9,
                           q16 / v16 / d16 / s16; rax / eax / ax / al,
                           r8 / r8d / r8w / r8b, xmm5). The ABI still
                           passes arguments and results through it, and
                           an inline-asm operand, clobber or `register`
                           variable may still name it. The stack and
                           frame pointers, the AArch64 link register and
                           the code generator's own scratch registers
                           (x16, x17, x19; r10, r11) are refused.
  -fstack-protector        Give a stack canary to every function holding
                           a character array of at least --param
                           ssp-buffer-size= bytes (default 8), or calling
                           alloca / declaring a variable-length array.
                           The canary sits between the locals and the
                           saved return address; a mismatch on return
                           calls __stack_chk_fail.
  -fstack-protector-strong Also protect a function holding an array of
                           any element type, an aggregate with an array
                           member, or an automatic object whose address
                           the body takes.
  -fstack-protector-all    Protect every function.
  -fno-stack-protector     Protect none (the default).
  --param ssp-buffer-size=N
                           Least character-array size, in bytes, that
                           -fstack-protector protects a function for.
  -mcpu=NAME[+ext...]      AArch64 CPU selection. The name picks a
                           scheduling model badc does not differentiate;
                           `+crypto` / `+aes` / `+sha2` (and their `no`
                           forms) set the __ARM_FEATURE_* macros the way
                           gcc does, with the crypto encodings always
                           available to inline asm. Another extension is
                           refused by name.
  -mstack-protector-guard=global|tls|sysreg
                           Where the guard value is read from. The
                           default follows the target: %fs:0x28 on
                           Linux/x86-64, the __stack_chk_guard object
                           elsewhere. `tls` is x86-64 only, `sysreg`
                           aarch64 only.
  -mstack-protector-guard-reg=R
                           Segment register (fs, gs) under =tls, or the
                           AArch64 system register name under =sysreg.
  -mstack-protector-guard-offset=N
                           Byte offset of the guard within the thread
                           block (=tls) or above the system register's
                           value (=sysreg).
  -mstack-protector-guard-symbol=NAME
                           Read the guard from NAME instead of
                           __stack_chk_guard. Not combinable with
                           -mstack-protector-guard-offset=.
  -ftrivial-auto-var-init=uninitialized|zero|pattern
                           Initialize every automatic object declared
                           without an initializer -- scalars,
                           aggregates, arrays and variable-length
                           arrays -- where its storage is established:
                           `zero` stores zeros, `pattern` stores the
                           byte 0xFE over it. `uninitialized` (the
                           default) leaves it as the frame held it.
                           __attribute__((uninitialized)) on an object
                           opts it out. A declaration a `goto` or
                           `switch` jumps past is not covered, as in
                           gcc. Diagnostics and the -O promotion of the
                           object are unchanged.
  -fzero-init-padding-bits=standard|unions|all
                           Which automatic initializers zero their
                           padding. Every value selects what badc
                           already emits: an aggregate initializer
                           zero-fills the whole object, padding
                           included, before storing the members, for
                           structs and unions alike.
  -fshort-wchar            Give wchar_t an unsigned 16-bit type instead
                           of the target's default, narrowing the
                           elements of L-prefixed string and character
                           literals and the __SIZEOF_WCHAR_T__ /
                           __WCHAR_TYPE__ predefines with it.
                           -fno-short-wchar restores the default, which
                           is already 16-bit on Windows.
  -fsigned-char            Make plain char signed, whatever the target
                           ABI selects. -fno-unsigned-char is a synonym.
  -funsigned-char          Make plain char unsigned, and predefine
                           __CHAR_UNSIGNED__ so <limits.h> CHAR_MIN /
                           CHAR_MAX follow. -fno-signed-char is a
                           synonym. Without either flag the target ABI
                           decides: unsigned on AArch64 ELF, signed
                           elsewhere.

VM-only knobs (require --interp):
  --track-pointers         Allocation tracking + use-after-free guard.
  --trace                  Per-instruction stdout trace (noisy).

Mutually exclusive: --interp / --jit / --shared /
--list-symbols / --dump-headers / --install all pick the output
mode; only one applies. --track-pointers and --trace require
--interp. -o has no effect under --interp / --list-symbols /
--dump-headers / --install.";
