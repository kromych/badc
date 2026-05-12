#!/usr/bin/env python3
"""Patch `stb_vorbis.c` with per-function and per-`return error(...)`
trace prints so a clang-built and a c5-built copy of the same TU
can be diffed line-by-line to localize the first point at which c5's
codegen diverges from a reference compiler.

The script is intentionally minimal: it reads the upstream-vendored
`demos/stb/stb_vorbis.c`, writes a patched copy beside it at
`stb_vorbis.traced.c`, and exits. The patched file:

* `#include <stdio.h>` at the very top (idempotent if already present).
* Insets a `fprintf(stderr, "TRACE_ENTER func=%s line=%d\\n", ...)`
  call at the first `{` of every `static` function definition.
* Wraps every `return error(f, ...)` site with a print of the source
  line and error code.

To rebuild the smoke driver against the patched file, the caller swaps
the `stb_vorbis.c` include for `stb_vorbis.traced.c`. The diff harness
(`tools/diff_vorbis/diff_run.sh`) does this automatically.

Idempotent: running twice on the same source produces the same patch.
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_SRC = REPO_ROOT / "demos" / "stb" / "stb_vorbis.c"


# Match a static function definition's opening line, e.g.
#   `static int stbi__refill(stb_vorbis *f)`
# or
#   `static stb_vorbis *stb_vorbis_open_memory(...)`
# followed (on the same or next line) by `{`. We capture the function
# name so the trace can print it.
FN_RE = re.compile(
    r"^(static\s+(?:[\w*\s]+?)\s*(\b[A-Za-z_][\w]*)\s*\([^;]*?\))\s*\n\{",
    re.MULTILINE,
)


def patch(src: str) -> str:
    out = src
    # Ensure <stdio.h> is reachable; stb_vorbis.c already pulls in
    # most of libc, but be defensive in case STB_VORBIS_NO_STDIO is
    # set.
    if "#include <stdio.h>" not in out:
        out = "#include <stdio.h>\n" + out

    # Trace ENTER for every static function definition.
    def inject_enter(m: re.Match[str]) -> str:
        signature = m.group(1)
        name = m.group(2)
        return (
            f"{signature}\n{{\n"
            f'    fprintf(stderr, "TRACE_ENTER %s line=%d\\n", "{name}", __LINE__);\n'
        )

    out = FN_RE.sub(inject_enter, out)

    # Wrap `return error(f, X)` with a print of the source line and
    # X. The replacement is a brace-block so `if (cond) return
    # error(f, X);` still parses as a single statement after the
    # rewrite. `do { ... } while (0)` would also work; the brace
    # block is shorter.
    out = re.sub(
        r"return\s+error\s*\(\s*f\s*,\s*([A-Za-z_]\w*)\s*\)\s*;",
        r'{ fprintf(stderr, "TRACE_ERR line=%d e=%s\\n", __LINE__, "\1"); '
        r"return error(f, \1); }",
        out,
    )

    return out


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--src", type=Path, default=DEFAULT_SRC, help="source stb_vorbis.c"
    )
    parser.add_argument(
        "--out",
        type=Path,
        default=None,
        help="output path (default: <src>.traced.c)",
    )
    args = parser.parse_args()

    src_path = args.src
    if not src_path.exists():
        print(f"error: {src_path} not found", file=sys.stderr)
        return 1
    src = src_path.read_text()
    patched = patch(src)
    out_path = args.out or src_path.with_suffix(".traced.c")
    out_path.write_text(patched)
    print(f"wrote {out_path} ({len(patched)} bytes)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
