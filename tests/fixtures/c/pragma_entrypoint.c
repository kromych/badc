// gh #55: `#pragma entrypoint(<name>)` overrides the default
// `main` entry. Used for `WinMain` (gh #32 GUI subsystem),
// custom `_start`, or DLL-style entries. The pragma redirects
// the compiler's entry-point lookup; the named symbol must
// resolve to a function in this translation unit (same rule as
// `#pragma export(...)` exports).
#include <stdio.h>

#pragma entrypoint(custom_entry)

int custom_entry(void) {
    return 23;
}

// `main` is intentionally absent. Without the pragma, c5 would
// reject this TU at link time with `main() not defined`.
