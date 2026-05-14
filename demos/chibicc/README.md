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

Every TU compiles, the multi-TU link succeeds, and the produced
chibicc binary matches the gcc-built reference byte-for-byte on
the self-host sample suite. See `self_host.py` for the parity
check; `smoke.py` covers per-TU compile + link.

Per-TU status:

| TU             | Status   |
|----------------|----------|
| `chibicc.h`    | parses   |
| `hashmap.c`    | compiles |
| `codegen.c`    | compiles |
| `tokenize.c`   | compiles |
| `strings.c`    | compiles |
| `preprocess.c` | compiles |
| `main.c`       | compiles |
| `unicode.c`    | compiles |
| `type.c`       | compiles |
| `parse.c`      | compiles |

Bringup landed by closing five gaps in the c5 dialect:

1. **POSIX libc bindings** -- new headers `<strings.h>`,
   `<libgen.h>`, `<glob.h>`, `<sys/wait.h>`; bindings for
   `strndup`, `open_memstream`, `strtold`, `execvp`, `_exit`,
   `ctime_r`.
2. **Binary integer literals** (`0b...` / `0B...`) -- lexer
   branch beside the hex path.
3. **Compound literals** at file scope (`&(Type){...}`) --
   anonymous internal-linkage symbol synthesized for the
   backing storage; reloc points at it.
4. **Deferred-outer multi-dim arrays** (`T arr[][N]`) --
   declarator now populates `array_dims` with a placeholder
   for the outer dim and run_compile patches it once the
   initializer count is known.
5. **`sizeof(*arr)` decay clear** -- the unary `*` handler
   now clears `last_array_decay_size` so `sizeof(*arr)`
   reports `sizeof(elem)` rather than `N * sizeof(elem)`.

chibicc's body does NOT exercise the features the README
originally flagged as deeper gaps (GNU statement expressions,
alloca, VLA, `_Atomic`, asm). It parses them as input but
doesn't use them itself, so they remain out of scope for the
self-host loop. `long double` shows up as a field in
`Token`/`Node` and once via `strtold`; the c5 dialect accepts
the type as 8-byte storage (alias for `double`), which is
internally consistent in chibicc's own use of those fields and
preserves the self-host fixed point.

## Layout

* `setup.py` -- fetch the source tarball from the vendor-deps
  release; idempotent.
* `chibicc.h`, `*.c` -- vendored upstream sources (gitignored
  out of band; `setup.py` is the source of truth for what they
  are).
* `smoke.py` -- build-only smoke harness. Tracks per-TU
  compile state, exits 0 when every TU compiles cleanly and
  the multi-TU link emits a working binary.
* `self_host.py` -- parity check: builds chibicc with both gcc
  and badc, runs each on a curated sample suite, asserts the
  emitted `.s` files are byte-identical and the linked binaries
  return the same exit code. Linux x86_64 only (chibicc emits
  SysV x86_64 GAS).
