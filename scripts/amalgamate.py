#!/usr/bin/env python3
"""Concatenate C translation units into a single source with `#line`
markers preserving per-file attribution.

c5 still reads exactly one input file per invocation, so multi-file
projects today either need a wrapper that drives badc once per TU
and links the results (we don't ship a linker) or they pre-glue
their inputs into a single file. SQLite's amalgamation is the
canonical example. Pre-gluing with bare `cat` works at runtime but
gives the debugger the wrong filename: lldb attributes everything
to `combined.c` because that's literally the file c5 saw, with one
giant line column running through it. With this script the
combined output opens each TU's content with a `#line 1 "<path>"`
directive, the lexer's GNU-marker handling (#49, #51) picks them
up, and DWARF emits a real `DW_LNS_set_file` transition at every
boundary -- so `b sqlite3ExprAffinity` reports `sqlite3.c:112664`
even though the compiler's input was a single concatenated file.

This is a stop-gap until c5 grows real separate-compilation. When
that lands the only thing that needs to change here is the README,
not the markers themselves -- they're standard C99.

Usage:
    amalgamate.py -o combined.c a.c b.c c.c
    amalgamate.py -o - a.c b.c | badc -    # pipe straight into the compiler

`-o` is required; pass `-` to write the result to stdout (handy
for pipelines that don't want a temp file). Files are emitted in
the order given on the command line. Each input must end with a
newline; if it doesn't, we add one before the next file's marker
so the marker lands on its own line.
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


def escape_filename(name: str) -> str:
    """Escape filename bytes for inclusion inside a C string
    literal: backslash and double-quote get a leading backslash;
    everything else passes through. Paths with embedded LF would
    already break a thousand other things, so we don't try to
    handle them here."""
    return name.replace("\\", "\\\\").replace('"', '\\"')


def emit_line_marker(target: int, filename: str) -> str:
    """C99 `#line N "file"` -- the lexer subtracts one and the
    trailing `\\n` bumps to the target. We use the C99 shape (with
    the `line` keyword) rather than GCC's bare `# N "file"` because
    it round-trips cleanly through any preprocessor a downstream
    tool might point at the output."""
    return f'#line {target} "{escape_filename(filename)}"\n'


def amalgamate(inputs: list[Path], display_paths: list[str] | None = None) -> str:
    """Concatenate `inputs` into one buffer with leading
    `#line 1 "src"` markers per file.

    `display_paths`, if provided, supplies the path that goes into
    each marker. The default uses the input's path string verbatim;
    callers that want stable cross-machine filenames (e.g. for
    reproducible builds) can pass project-relative paths there.
    """
    if display_paths is None:
        display_paths = [str(p) for p in inputs]
    if len(display_paths) != len(inputs):
        raise ValueError("display_paths length mismatch")

    out: list[str] = []
    for path, display in zip(inputs, display_paths):
        body = path.read_text(encoding="utf-8")
        out.append(emit_line_marker(1, display))
        out.append(body)
        # Guarantee a newline before the next marker so the marker
        # lands on its own line. We don't *strip* trailing blank
        # lines -- the input's last line should still appear at the
        # number the user wrote it on.
        if not body.endswith("\n"):
            out.append("\n")
    return "".join(out)


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(
        description="Concatenate C TUs with #line markers for c5.",
    )
    parser.add_argument(
        "-o",
        "--output",
        required=True,
        help="Path to write the amalgamated source. Use '-' for stdout.",
    )
    parser.add_argument(
        "--rel",
        action="store_true",
        help=(
            "Use each input's path *relative to the output's parent "
            "directory* in the #line markers. Helps reproducible "
            "builds where the absolute path on the build machine "
            "shouldn't leak into DWARF."
        ),
    )
    parser.add_argument(
        "inputs",
        nargs="+",
        type=Path,
        help="Source files to glue, in the order they should appear.",
    )
    args = parser.parse_args(argv)

    inputs: list[Path] = args.inputs
    for p in inputs:
        if not p.is_file():
            print(f"amalgamate: not a file: {p}", file=sys.stderr)
            return 2

    write_to_stdout = args.output == "-"
    if args.rel and not write_to_stdout:
        out_parent = Path(args.output).resolve().parent
        display = []
        for p in inputs:
            try:
                display.append(str(p.resolve().relative_to(out_parent)))
            except ValueError:
                # Input lives outside the output's tree -- fall back
                # to the user-supplied path string. Better an
                # absolute path in the marker than a crash.
                display.append(str(p))
    elif args.rel:
        # `--rel` against stdout doesn't have an "output parent"
        # to anchor on; fall back to cwd-relative paths so the
        # builder can still run amalgamator | badc - cleanly.
        cwd = Path.cwd().resolve()
        display = []
        for p in inputs:
            try:
                display.append(str(p.resolve().relative_to(cwd)))
            except ValueError:
                display.append(str(p))
    else:
        display = [str(p) for p in inputs]

    combined = amalgamate(inputs, display)
    if write_to_stdout:
        # `sys.stdout.write` re-encodes through the locale codec
        # (cp1252 on Windows runners), which corrupts non-ASCII
        # bytes such as the U+2014 em-dash in MonoCypher's
        # license header. Write the bytes directly to bypass
        # the locale path.
        sys.stdout.buffer.write(combined.encode("utf-8"))
    else:
        Path(args.output).write_text(combined, encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
