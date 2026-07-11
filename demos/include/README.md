# Vendored third-party headers

Header-only declarations for third-party libraries that real-world C programs
`#include` but that are not part of the C standard library and so are not in
badc's embedded header set (`headers/include/`). badc's include search is
hermetic -- it consults its embedded headers plus explicit `-I` paths, never
the host's default system include directories -- so a program that uses one of
these libraries cannot find its header unless it is provided explicitly.

Point badc at this directory to build such programs:

    badc -I demos/include prog.c ...

Only the API declarations are needed to compile a translation unit; the
library implementation is supplied at link time as usual.

## Contents

| Header(s)                                | Library | License        |
|------------------------------------------|---------|----------------|
| `zlib.h`, `zconf.h`                      | zlib    | zlib           |
| `libfdt.h`, `fdt.h`, `libfdt_env.h`      | libfdt  | BSD-2-Clause   |

Each header is the upstream file with only host-platform specifics removed so
it parses the same for every badc target:

- `zlib.h`: the `#ifdef __APPLE__ #include <Availability.h>` branch and the
  `__API_AVAILABLE(...)` availability annotations carry no meaning for the API
  declarations, so the include is dropped and the macro is defined away
  unconditionally.

The remaining includes resolve to standard headers already in badc's embedded
set (`stdint.h`, `string.h`, `stddef.h`, ...), so the set is self-contained.
