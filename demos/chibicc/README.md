# chibicc

Rui Ueyama's small self-hosting C compiler vendored as a real
substantial multi-TU exerciser for badc's cross-translation-unit
linker. Eleven `.c`/`.h` files (~230 KB) that, when compiled
through badc, would produce a working C compiler binary.

Source is pinned at the project's last `main`-branch commit
(2020-12-07, `90d1f7f`); chibicc is a research project with no
versioned releases and no recent activity, so the pin is stable.
Pulled through the badc vendor-deps mirror -- see
[`setup.py`](setup.py).

## Bringup status

This is a **work-in-progress** bringup. The chibicc source pre-
dates c5 by several years and uses C99 / C11 / GNU features the
c5 dialect doesn't currently implement. Per-TU survey of what
compiles unmodified through badc today:

| TU             | Status   | First blocker                       |
|----------------|----------|-------------------------------------|
| `chibicc.h`    | parses   | (header)                            |
| `hashmap.c`    | compiles |                                     |
| `codegen.c`    | compiles |                                     |
| `tokenize.c`   | blocked  | `strncasecmp` binding missing       |
| `strings.c`    | blocked  | `open_memstream` binding missing    |
| `preprocess.c` | blocked  | `strndup` binding missing           |
| `main.c`       | blocked  | `dirname` binding missing           |
| `unicode.c`    | blocked  | `0b...` binary integer literals     |
| `type.c`       | blocked  | compound literals (`&(Type){...}`)  |
| `parse.c`      | blocked  | compound literals (`&(Scope){}`)    |

Already-landed fixes on this branch:

* `<stdbool.h>` -- maps `bool` -> `_Bool` (C99 7.16).
* `<stdnoreturn.h>` -- defines `noreturn` macro (C11 7.23).
* `_Noreturn` / `noreturn` accepted as no-op function specifiers.

Each remaining blocker tracks a real gap in the c5 dialect:

* **POSIX libc bindings** -- `<strings.h>` (`strncasecmp`,
  `strcasecmp`), `<string.h>` `strndup`, `<stdio.h>`
  `open_memstream`, `<libgen.h>` `dirname` / `basename`,
  `<glob.h>` `glob`, `<sys/wait.h>` `waitpid`. Each is a single
  `#pragma binding` line plus a header.
* **Binary integer literals** (`0b1010`) -- C23 / GNU; small
  lexer extension.
* **Compound literals** -- `(struct Foo){.x=1}` at every position
  including the global initializer that chibicc relies on (every
  base-type Type DIE is a `&(Type){...}`). Documented in
  `c99-gaps.md` as severity-3 rejected.

Beyond the per-TU blockers above, the codegen will also need:

* **`long double`** -- chibicc's `Token`, `Type`, `Node` carry
  a `long double fval` and the parser performs arithmetic in
  long-double precision for FP constant folding. c5 has no
  long-double pipeline.
* **GNU statement expressions** (`({ ... })`), labels-as-values,
  computed goto -- used in error-reporting macros and the
  parser's expression-folding helpers.
* **`alloca`** -- chibicc uses it for VLAs and intermediate
  buffers.
* **VLA** (`int xs[n]` with runtime `n`) -- chibicc supports
  them in user code and emits dedicated codegen.
* **`_Atomic`** -- the parser surfaces ND_CAS / ND_EXCH for
  C11 atomics. Distinct semantic; needs real codegen.
* **`asm`** -- one inline-asm string in chibicc's codegen.

## Layout

* `setup.py` -- fetch the source tarball from the vendor-deps
  release; idempotent.
* `chibicc.h`, `*.c` -- vendored upstream sources (gitignored
  out of band; `setup.py` is the source of truth for what they
  are).
* `smoke.py` -- build-only smoke harness. Tracks per-TU
  compile state and reports a summary. Returns 0 only when
  every TU compiles cleanly; until the blockers above are
  closed, expect non-zero.
