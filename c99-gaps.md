# Gaps to C99

Snapshot updated after M27 (bitfields) lands. The c5
dialect is a deliberately small subset of C with extras for
the compiler's own use; this document catalogues the C99
features that aren't supported, organized by spec section,
so anyone evaluating "can I compile <real codebase> with
badc?" knows what they'd hit.

The labels mean:
- **missing**: feature isn't accepted at all -- the parser
  rejects it or the lowering refuses.
- **partial**: a useful subset works; the rest needs a
  separate milestone.
- **diverges**: c5 behaves differently from C99, on purpose.
  Unmodified C source may compile but produce a different
  result.

Severity is from the perspective of a portability project
trying to compile mainstream open-source C. Severity 1
(blocks almost everything), 2 (blocks much real code), 3
(blocks specific idioms), 4 (workaround exists), 5 (nice
to have).

## §6.2 Concepts

### Linkage and storage classes
- `extern` and `static` (file scope and function scope) --
  **partial**. Recognized as no-op storage-class prefixes
  (M12) so unmodified headers compile, but they have no
  semantic effect: every c5 symbol already has internal
  linkage, and `static` locals retain automatic storage
  duration. Programs relying on persistent function-scope
  static variables behave incorrectly (the local resets
  every call). Severity: 2.
- `register`, `auto` -- **missing**. `auto` is the default;
  `register` is ignored by most modern compilers anyway.
  Severity: 5.
- `inline` -- **missing**. Severity: 4 (most codebases
  fall back to plain functions when `inline` is undefined).
- `_Thread_local` -- **supported** (M7-M8 + M14, every
  target). Initialisers limited to scalars + NULL today;
  pointer-to-global TLS init is deferred (the rebase
  ordering against the per-thread template needs design
  work).
- Multiple translation units -- **missing**. `badc` compiles
  a single source file at a time; `extern int x;` in one
  TU and `int x;` in another can't be linked together.
  Severity: 1 for any non-trivial project.

### Object lifetimes
- File-scope and block-scope storage durations -- supported.
- "Allocated" duration via `malloc` / `free` -- supported
  via libc bindings (M0).
- Static-storage block-scope (`static int counter;` in a
  function) -- **diverges**: silently treated as automatic.
  Severity: 2.

## §6.3 Conversions

- Integer promotions, usual arithmetic conversions for
  scalars -- supported.
- Float-to-int / int-to-float casts -- supported (M3).
- Pointer conversions -- supported, with a warn-not-error
  policy on int-to-pointer assignments (matches the c4
  legacy).
- Function-pointer / object-pointer conversions -- supported.
- Implicit conversions in function calls (e.g.,
  `int -> long`, `float -> double`) -- **partial**. The
  c5 dialect treats `int` as 64-bit (no `long` distinction);
  `float` and `double` are real but `1.0f` doesn't promote
  to `double` in variadic calls. Severity: 3.

## §6.4 Lexical elements

### Keywords / reserved words
- Recognized: `char`, `else`, `enum`, `for`, `if`, `int`,
  `return`, `sizeof`, `while`, `do`, `break`, `continue`,
  `goto`, `switch`, `case`, `default`, `struct`, `void`,
  `float`, `double`, `_Thread_local`, `extern`, `static`.
- Recognised as no-op (M19): `const`, `volatile`,
  `restrict`, `__restrict`, `__restrict__`, `signed`,
  `unsigned`, `short`, `long`, `_Bool`, `register`,
  `auto`, `inline`, `__inline`, `__inline__`. The lexer
  consumes them at every declaration position; semantics
  are unchanged (every integer is still 64-bit, no
  const-correctness checks, no inline expansion).
  Programs relying on 32-bit overflow or const-checks
  diverge silently -- see the §6.7 type-specifier and §J
  notes for what that means in practice.
- `typedef` -- **supported** (M23 + M23b). The lexer
  accepts the keyword and the parser registers a typedef
  name as a type alias for any underlying type. Shapes:
  primitive aliases (`typedef int u32;`), pointer aliases
  (`typedef char *str;`), forward struct + alias (`typedef
  struct Foo Foo;`), single-declaration struct + alias
  (`typedef struct Foo {...} Foo;`), function-pointer
  aliases (`typedef int (*Compare)(int, int);`), and
  typedef-name use in every type position (parameter,
  return, struct field, cast, sizeof). The
  `(*Name)(args)` declarator shape also works in
  parameter and struct-field positions; the trailing
  parameter list is parsed and discarded since c5
  doesn't yet record function-pointer signatures.
  Calling through an FP-typed struct field directly
  (`s.cb(args)`) still requires copying the field to a
  local first -- the c5 expression chain only enters the
  call branch on a bare identifier today.
- `union` -- **partial** (M26). Lexer recognises the
  keyword; parser shares the struct tag table and the
  field-access path. Layout: every member at offset 0,
  total size = max(member size). Forward declarations,
  pointer-to-union, typedef-of-union, and union as a
  struct field all work. Bitfields inside a union are
  still missing (those fall under §6.7.2.1). Severity:
  resolved for the common tagged-union pattern.
- **Missing**: `_Complex`, `_Imaginary`. Severity 5.

### Identifiers
- ASCII identifiers up to a generous internal limit --
  supported.
- Universal character names (`А`) in identifiers --
  **missing**. Severity: 5.

### Constants
- Integer literals: decimal, hex (`0x...`), octal (`0...`),
  char (`'A'`) -- supported.
- Integer suffix: `u`, `U`, `l`, `L`, `ll`, `LL`, `ULL`,
  any combination -- **supported** (M20). The suffix is
  consumed by the lexer; the value is preserved as a 64-bit
  integer. Severity: resolved.
- Floating literals: decimal (`1.5`), exponent (`1e10`),
  fractional (`.5`), `f`/`F` suffix -- supported.
- Hex floats (`0x1p10`) -- **missing**. Severity: 5.
- String literals: standard escape sequences (`\n`, `\t`,
  `\\`, `\"`, `\0`, octal, hex) -- supported.
- Wide string literals (`L"..."`) -- **missing**. Severity:
  4.
- Concatenation of adjacent string literals -- supported.
- `__func__` -- **missing**. Severity: 4.
- `__FILE__`, `__LINE__`, `__DATE__`, `__TIME__`, `__STDC__`
  -- **supported** (M21). `__FILE__` and `__LINE__` are
  evaluated per line during preprocessor substitution.
  `__DATE__` and `__TIME__` are seeded once at badc build
  time (since the library is no_std-friendly and can't
  reach the system clock at preprocess time); their
  expansion follows the C99 formats `"Mmm dd yyyy"` and
  `"hh:mm:ss"`. `__STDC__` is the constant `1`.
  `__STDC_VERSION__` and `__STDC_HOSTED__` are still
  missing; the dialect doesn't claim conformance to a
  specific C standard year.

### Punctuators
- Standard set -- supported (`+ - * / % = == != < > <= >= ! & | ^ << >> && || , ; : { } ( ) [ ] -> . ... ?`).
- Digraphs / trigraphs (`<:`, `??/`) -- **missing**. Severity:
  5 (deprecated since C99; rare in modern source).

### Header names
- `<name>` and `"name"` forms -- supported (M0
  preprocessor).
- Header search path -- **partial**. `badc` ships its own
  `headers/include/` set bundled with the binary; user
  search paths via `-I` aren't a CLI option. Severity: 3.

## §6.5 Expressions

### Operators
- Arithmetic, bitwise, logical, comparison, assignment,
  conditional `? :`, comma -- supported.
- Compound assignment (`+=`, `-=`, ...) -- supported.
- `++` and `--`, prefix and postfix -- supported (integer);
  float `++/--` is **missing** (deferred until the
  immediate-form Op:: lowering grows a float branch).
  Severity: 5.
- `sizeof` of types and expressions -- supported.
- `_Alignof`, `_Alignas` -- **missing**. Severity: 4.

### Casts
- Scalar casts -- supported (`(int)`, `(float)`,
  `(struct Foo *)`, etc.).
- Compound literals (`(struct Foo){.x = 1, .y = 2}`) --
  **missing**. Severity: 3.

### Pointer arithmetic
- `p + n`, `p - n`, `p - q`, indexing -- supported.
- Pointer comparison (`<`, `>`) -- **partial**: equality /
  inequality work; ordered comparisons against 0 work, but
  ordered comparisons between two pointers haven't been
  exhaustively validated. Severity: 4.
- Pointer-to-function call via `fp(...)` -- supported via
  `Op::Jsri`.

### Struct/union member access
- `.` and `->` for structs -- supported (M5/M6).
- Unions -- **supported** (M26). See §6.4 keywords for
  layout details.
- Bitfields -- **supported** (M27). `int x:N;` packs into
  shared 8-byte storage units; reads emit `Li; Shr; And`,
  writes emit a load-clear-shift-or-store sequence that
  preserves adjacent bits. Anonymous (`int :N;`) and
  zero-width (`int :0;`) forms are accepted as alignment
  hints. The read path doesn't sign-extend (signed and
  unsigned bitfields produce the same unsigned-mask
  value), which diverges from strict C signed-bitfield
  semantics; in practice every sqlite-shaped use is a
  flag or small unsigned count, where the difference is
  unobservable. Bitfields can't be members of an array.
- Bitfields -- **supported** (M27). See §6.4 keywords
  for layout details.

## §6.6 Constant expressions

- Integer constants -- supported.
- Address constants (e.g., `&global` in initializers) --
  supported (M13).
- Constant expressions in array sizes -- **partial**
  (M25). Today only integer literals (with optional
  unary `-`) and identifiers bound to compile-time
  integer constants (enum values, `#define`d numeric
  macros) are accepted. General arithmetic
  (`int xs[N + 1]`) needs a constant-expression
  evaluator. Severity: 3.
- Constant expressions in static initializers (general
  arithmetic, casts) -- **partial**: integer constants
  (with optional unary `-`) and `&global` are accepted;
  `(int)(1.5 * 2)` etc. aren't.

## §6.7 Declarations

### Type specifiers
- `void` (recognized as an alias for `char`-shaped void
  pointers; used for `void *` and `void` returns) --
  **partial**. `void` is internally equivalent to `char`
  in c5; `void f(void)` parses but a `void`-returning
  function still produces a value (the unused
  accumulator). Severity: 3.
- `char`, `int`, `float`, `double` -- supported.
- `signed` / `unsigned` / `short` / `long` -- **partial**
  (M19): consumed by the lexer, no width effect. Every
  integer is still 64-bit; programs that depend on 32-bit
  overflow semantics for `int` or 16-bit overflow for
  `short` still diverge silently. See §J for the layout
  c5 actually uses.
- `_Bool` -- **partial** (M19): tokenizes; treated as
  `int` (i.e. 64-bit, full integer range, not 0/1
  normalised). Programs that rely on `_Bool` storing
  exactly 0 or 1 will diverge.
- `_Complex`, `_Imaginary` -- **missing**.

### Type qualifiers
- `const`, `volatile`, `restrict` -- **partial** (M19):
  recognised at every declaration / qualifier position
  (file-scope decl, struct field, parameter, pointer
  level, cast type-name, sizeof type-name) and consumed
  as a no-op. No const-correctness, no
  reordering-barrier, no aliasing assumptions. Severity:
  2 -> 4 with M19 (most surface code now lexes; only the
  pathological cases that depend on the qualifier's
  optimization or diagnostic effect diverge).

### Function specifiers
- `inline` -- **partial** (M19): tokenizes, accepted at
  every declaration position, no inline expansion.
- `register`, `auto` -- **partial** (M19): tokenize and
  are consumed as no-ops at every declaration position.
- `_Noreturn` (C11, listed for completeness) --
  **missing**.

### Initializers
- Scalar initializer for globals -- supported (M13).
- Pointer-to-global initializer -- supported (M13).
- Local variable initializers (`int x = 5;` inside a
  function) -- **supported** (M24). The parser emits a
  `Lea local; Psh; <expr>; Si | Sc | Mcpy` sequence after
  setting up the local. Multiple declarators with mixed
  init (`int a = 1, b, c = 3;`) and pointer / struct
  initializers all work. Aggregate / brace-enclosed
  initializers (`{ .x = 1 }`) are M28.
- Aggregate initializers for arrays -- **partial**
  (M28a). String-literal init for char arrays (`char buf[]
  = "hello"`, `char buf[16] = "hi"`) and brace-list init
  for arrays of integers and pointers (`int xs[] = {1, 2,
  3}`, `char *names[] = {"foo", "bar"}`) work at both file
  scope and function scope. Empty-bracket form
  (`int xs[] = ...`) infers the dimension from the
  initializer. Trailing zeros: file-scope arrays are
  zero-initialised by allocation; function-scope arrays
  initialise only the explicit positions, the rest stays
  in whatever state the stack frame held.
- Aggregate initializers for structs (`{ .field = ... }`,
  positional, mixed) -- **supported** (M28b) at file
  scope. Each field value can be an integer constant, a
  string literal (recorded as a DataReloc so the per-format
  writers patch the slot to the runtime data address), a
  `&global` (DataReloc), or a function name (CodeReloc --
  the writers patch the slot to the runtime code address
  via the new `Program::code_relocs` channel). Sqlite's
  vtable shape (struct of int + function-pointer fields,
  designated init at file scope) compiles and runs on all
  five native targets. Function-scope struct designated
  init isn't yet covered.
- String-literal initializers for char arrays --
  **supported** (M28a). `char buf[] = "hi"` (size
  inferred) and `char buf[N] = "..."` (explicit size
  with trailing zeros) work at both file and function
  scope.

### typedef
- **supported** (M23 + M23b). Function-pointer typedefs
  and the `(*Name)(args)` declarator shape are in.
  See §6.4 keywords for the full list.

### Tags / declarators
- struct tags -- supported.
- union -- supported (M26).
- enum tags -- **supported** (M30). `enum Foo { A, B, C };`
  registers each constant as a `Token::Num` with its
  enumerated value; `enum Foo` is then a valid type spec
  (resolves to `int`, since c5 has a single 64-bit integer
  representation) in parameter / return / local /
  array-dimension positions. Negative initializers
  (`enum { N = -1 }`) work via the constant-expression
  path. The tag itself isn't yet bound for cross-tag
  forward declarations -- a feature few real codebases
  use, deferred.

## §6.7.2.1 Structure / union specifiers

- Struct definitions, member access, struct-by-value
  parameters and return -- supported (M5-M9, with the
  caveat that the M9 ABI is a c5-internal one rather than
  SysV / Win64 / AAPCS64). Calling a libc function that
  takes / returns a struct is refused at compile time
  (M9 final commit) until the platform ABIs land.
  Severity: 2 for cross-format binary compatibility, 3 for
  internal struct use.
- Union -- **missing**. Severity: 2.
- Bitfields -- **supported** (M27). See §6.4 keywords
  for layout details.
- Anonymous structs / unions -- **missing**. Severity: 4.
- Forward struct declarations -- **supported** (M23).
  First mention of `struct Foo` (in `struct Foo;`,
  `struct Foo *p;`, `typedef struct Foo Foo;`, or any
  field type) auto-registers an opaque struct entry; a
  later `struct Foo { ... }` body fills it in. Field
  access on an opaque struct value still errors at the
  access site (the struct has no fields to look up).

## §6.7.5 Declarators

- Pointer types (`*`, `**`, ...) -- supported.
- Function declarators with parameter list -- supported,
  including `...` variadic.
- Function declarators with K&R-style identifier list --
  **missing**. Severity: 5.
- Array declarators (`int a[10]`, `int a[]`) --
  **partial** (M25). Stack arrays, global arrays, struct
  fields that are arrays, and `int xs[]` in parameter
  position (decays to `int *xs`) all parse and run.
  Indexing scales by the real element size, so `struct
  Foo arr[N]; arr[i].field` lands at the correct address
  even for structs larger than 8 bytes. `sizeof(arr)`
  returns `N * sizeof(elem)` via a sizeof-time lookahead
  on bare-identifier operands. Multi-dim arrays
  (`int xs[N][M]`), brace initializers (`int xs[] = {1, 2,
  3};`), and string-literal init for char arrays
  (`char buf[16] = "hi";`) are deferred to follow-ups
  (multi-dim and aggregate init in M28).
- VLAs (`int a[n]`) -- **missing** (C99 specific).
  Severity: 4.

## §6.7.7 Type names

- `<type-spec> <abstract-decl>` shape (`int *`,
  `struct Foo *`) -- supported in casts and `sizeof(...)`.
- Function-type abstract declarators -- **partial**
  (M23b). The `int (*)(int, int)` form parses inside
  declarators (typedef target, parameter type, struct
  field). Standalone abstract declarators in `sizeof`
  / casts (`(int(*)(int))ptr`) aren't yet supported.

## §6.8 Statements and blocks

- Compound statements with locals at the top -- supported.
- Local declarations interleaved with statements (C99
  block-scope) -- **supported** (M24). Both the function
  body's outer `{ ... }` and any nested block-stmt now
  alternate between decl and stmt parsing. Decls inside a
  nested block shadow outer bindings and restore on
  block exit.
- `if`, `else`, `while`, `do-while`, `for`, `switch`,
  `case`, `default`, `break`, `continue`, `goto`,
  `return` -- supported.
- `for ( int i = 0; ... )` (C99 for-init declaration) --
  **missing**. The for-init slot still expects an
  expression. Workaround: declare the variable in the
  enclosing block, then `for (i = 0; ...)`. Severity: 4
  (sqlite is pre-C99 and doesn't use this shape).
- `restrict`-qualified locals -- **missing**.

## §6.9 External definitions

- Function definitions -- supported, with an optional
  `#pragma export(<name>)` directive (M15-M18) marking
  symbols for `dlsym` / `GetProcAddress` lookup.
- Global object definitions -- supported (M13 added
  initializers).
- Translation-unit boundaries -- **missing** (single TU
  per `badc` invocation; no separate compilation /
  linking).

## §6.10 Preprocessing directives

- `#include` (`<...>` and `"..."`) -- supported.
- `#define` of object-like macros, with replacement-list
  substitution -- supported.
- Function-like macros (`#define foo(x) ...`) --
  supported.
- `#undef` -- supported.
- `#if`, `#ifdef`, `#ifndef`, `#elif`, `#else`,
  `#endif` -- supported.
- `defined(...)` operator -- supported.
- `#error` -- **supported** (M21). The directive raises a
  `C5Error::Compile` carrying the directive's message text
  along with the `<filename>:<line>` position. Inactive
  branches (`#if 0` / `#ifdef MISSING`) skip the directive,
  matching the C standard.
- `#pragma`-defined directives:
  - `#pragma once` -- supported.
  - `#pragma dylib(name, "path")` -- c5 extension
    (declares an external library).
  - `#pragma binding(name::local, "real")` -- c5
    extension (binds a local name to a dylib symbol).
  - `#pragma export(name)` -- c5 extension (marks a
    function for shared-library export).
- `_Pragma(...)` operator -- **missing**. Severity: 5.
- `#line` -- **missing**. Severity: 5 (mostly for
  generated code).
- Variadic macros (`#define foo(...)`,
  `__VA_ARGS__`) -- **supported** (M22). Both the
  `(args...)` -only form and the `(fixed, ...)` form work;
  `__VA_ARGS__` substitutes the comma-joined trailing args.
  GCC's named-rest extension (`#define foo(args...)`) is
  not supported -- the parameter must be the literal `...`.
- `#`, `##` operators -- **supported** (M22). `#param`
  yields a string literal of the argument's text with
  `\` and `"` escaped; `a ## b` token-pastes by trimming
  whitespace around the operator.
- `__FILE__`, `__LINE__`, `__DATE__`, `__TIME__`,
  `__STDC__` -- **supported** (M21). See §6.4 for details.

## §7 Library

- Standard headers (`<stdio.h>`, `<stdlib.h>`,
  `<string.h>`, `<unistd.h>`, `<fcntl.h>`,
  `<dlfcn.h>`, `<pthread.h>`, `<sys/mman.h>`) -- bundled
  in `headers/include/`, with `#pragma binding` declarations
  routing each c5-side name to the per-target loader symbol.
- Function repertoire -- only what the bundled headers
  declare. This is a tiny subset of C99's runtime library:
  - I/O: `printf`, `fopen` / `fread` / `fwrite` / `fclose`,
    `read` / `write` / `open` / `close`. **Missing**:
    `scanf`, `sscanf`, `fprintf`, `vprintf`, `puts`,
    `gets` (deprecated anyway), `setvbuf`, `fflush`,
    `fseek` / `ftell`, `feof` / `ferror`, `fgetc` /
    `fputc` and most other stdio.
  - String: `memcpy`, `memset`, `memcmp`. **Missing**:
    `strlen`, `strcpy` / `strncpy`, `strcat` / `strncat`,
    `strcmp` / `strncmp`, `strchr` / `strrchr`,
    `strstr`, `strtok`, `sprintf`, `snprintf`,
    `strerror`. (Reachable via `dlsym`, see below.)
  - Memory: `malloc`, `free`. **Missing**: `calloc`,
    `realloc`, `aligned_alloc`.
  - Math: `<math.h>` not bundled. `<stdlib.h>::abs` etc.
    aren't bound either. Severity: 2.
  - `<errno.h>`, `<setjmp.h>`, `<signal.h>`, `<time.h>`,
    `<locale.h>`, `<assert.h>`, `<ctype.h>` -- no
    bundled headers.
- `dlopen`/`dlsym` escape hatch -- supported. Anything in
  the running process's address space (including
  unbundled libc functions like `strlen`) is reachable
  via `dlsym(dlopen(NULL, RTLD_NOW), "strlen")`.

## §J Common implementation-defined behaviour
(non-normative; included because it shapes user expectations)

- Integer width / sign: every integer in c5 is signed
  64-bit. Programs that rely on `unsigned int` wrap
  semantics or `int32_t`-shaped overflow will diverge.
- `char` signedness: signed (matching `int`).
- Pointer width: 64-bit.
- Endianness: every host badc supports is little-endian.
- Float rounding mode: IEEE 754 default (round-to-nearest,
  ties-to-even).

## Severity-1 ("almost everything blocks") features

These are the ones I'd implement first if the goal is "can
this codebase compile":

1. ~~Arrays as language types~~ -- landed in M25.
   `int a[10]`, indexing, array-to-pointer decay,
   struct-array fields, `sizeof(arr)`, and pointer
   arithmetic with correct per-element scaling for
   struct pointers all work. Multi-dim and aggregate
   initializers are still missing.
2. **Multiple translation units** (separate compilation
   of multiple `.c` files plus a linking step). Without
   these, you can build small programs but not anything
   library-shaped beyond what `#include` plus a single
   `main` allows.

## Severity-2 cluster

Each of these breaks specific real-world patterns; they
roughly tie for "next priority":

3. `const`, `volatile`, `restrict` -- accepted as no-op
   tokens. Today the lexer doesn't recognise them as
   keywords at all, so headers like `string.h` from the
   real glibc would fail to tokenise.
4. ~~`typedef`~~ -- landed in M23. Real headers tokenise
   and parse; primitive / pointer / struct typedefs work.
   Function-pointer typedefs are still missing.
5. `signed` / `unsigned` / `short` / `long`. Today every
   integer is 64-bit; programs expecting 32-bit overflow
   semantics will misbehave silently.
6. ~~`union`~~ -- landed in M26. Tagged-union idioms
   work; bitfields inside a union are still missing.
7. `#error`, `#`, `##`, `__VA_ARGS__`. Macros with
   arity-checking diagnostics, format-string stringification,
   and variadic delegations rely on these.
8. ~~C99 block-scope decls~~ -- landed in M24. Decls
   may appear anywhere a statement may. for-init decls
   (`for (int i = 0; ...)`) still missing.
9. Aggregate initializers -- **supported** at file
   scope (M28a + M28b). Array brace-list, string-literal,
   struct designated and positional, mixed forms, and
   function-pointer fields with the new CodeReloc
   relocation. Function-scope struct/designated init is
   still missing.
10. ~~Local variable initializers~~ -- landed in M24.
11. `static` locals with persistent storage duration.
    Today they silently become automatic locals.
12. Real platform ABI for libc `struct`-by-value (`div`,
    `gmtime`, ...). The c5-internal struct ABI works for
    c5-to-c5 calls; cross-ABI calls today error at compile
    time (M9). 

## Pieces unique to c5 (worth keeping)

These don't exist in C99 and shouldn't go away:

- `#pragma dylib`, `#pragma binding`, `#pragma export` --
  the per-target loader-symbol-resolution and shared-library
  export story.
- The bytecode interpreter (`--interp`) with pointer
  tracking and code-vs-data separation. No equivalent in
  any standard C compiler.
- The in-process JIT (`--jit`).
- `#pragma once` (a near-universal extension; not in C99).
- The `__BADC_*` predefines (`__BADC_VERSION__`,
  `__BADC_TARGET__`, `__BADC_WINDOWS__`).

## Beyond C99 (C11/C17 features worth flagging)

Listed for awareness; these aren't in C99 but are
ubiquitous in modern C:

- `_Generic` selection.
- `_Atomic`.
- `_Thread_local` -- already supported.
- `_Static_assert`.
- Anonymous struct / union members.
- `_Noreturn`.

## Summary

The c5 dialect supports a coherent subset of C oriented
around c4-style scalar / pointer / struct programming with
a working preprocessor, real native codegen for five
targets, full TLS, and now (M15-M18) shared-library output
on every format. The biggest gaps are **arrays as types**
and **multiple translation units**; everything else is
either niche enough to skip or has a clear path forward.
