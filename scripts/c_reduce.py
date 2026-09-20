#!/usr/bin/env python3
"""Shrink a C source while a command keeps failing the same way.

`cvise` and `creduce` do this better and should be used where they are
installed; Homebrew carries neither under those names, and a filed csmith case
is several hundred lines that nobody reads unreduced. This is the small version
of the same idea: delete a brace-balanced region, keep the deletion when the
command still fails the way it did at the start, repeat until nothing more can
go. On the case that opened this harness it took 3939 lines to 46 in four
passes.

The interestingness test is a command. `{}` in it is replaced by the candidate
file's path; without a `{}` the candidate is appended. The case stays
interesting while the command's exit status matches (any non-zero status by
default, `--expect-status` for one in particular) and its output matches
`--expect`, which defaults to the panic location and message shape of the first
run -- so a reduction that trades one panic for another is rejected.

    scripts/c_reduce.py case.c -o small.c -- \\
        badc -O0 -w -I /usr/include/csmith-2.3.0 -o /dev/null {}

The reduced source is not compilable C in general: a reduction that keeps the
failure is what is wanted, not one that keeps the program meaningful. Check
what comes out before filing it.
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
import tempfile
from pathlib import Path

PANIC_RE = re.compile(r"panicked at ([^\s:]+(?::\d+)+)")


def run(command: list[str], candidate: Path, timeout: float) -> tuple[int, str]:
    argv = [part.replace("{}", str(candidate)) for part in command]
    if not any("{}" in part for part in command):
        argv = argv + [str(candidate)]
    try:
        done = subprocess.run(
            argv, capture_output=True, text=True, errors="replace", timeout=timeout
        )
    except subprocess.TimeoutExpired:
        return 124, "timed out"
    return done.returncode, done.stdout + done.stderr


def expectation(output: str) -> str:
    """What must keep happening: the panic site, else the first error line."""
    panic = PANIC_RE.search(output)
    if panic:
        return re.escape(panic.group(1))
    for line in output.splitlines():
        if "error" in line.lower():
            return re.escape(line.strip()[:80])
    return ""


def interesting(
    text: str,
    command: list[str],
    workdir: Path,
    expect: re.Pattern[str],
    status: int | None,
    timeout: float,
) -> bool:
    candidate = workdir / "candidate.c"
    candidate.write_text(text, encoding="utf-8")
    code, output = run(command, candidate, timeout)
    if status is None:
        if code == 0:
            return False
    elif code != status:
        return False
    return bool(expect.search(output)) if expect.pattern else True


def top_level_regions(lines: list[str]) -> list[tuple[int, int]]:
    """Half-open line ranges that are brace-balanced at depth zero.

    A function definition, a struct or union declaration and a global
    declaration each come out as one region, which is the granularity csmith
    output reduces at: its declarations are independent.
    """
    regions: list[tuple[int, int]] = []
    depth = 0
    start = 0
    for index, line in enumerate(lines):
        if depth == 0 and not line.strip():
            start = index + 1
            continue
        depth += line.count("{") - line.count("}")
        if depth <= 0 and (line.rstrip().endswith((";", "}")) or depth < 0):
            depth = 0
            regions.append((start, index + 1))
            start = index + 1
    if start < len(lines):
        regions.append((start, len(lines)))
    return [(a, b) for a, b in regions if b > a]


def balanced(lines: list[str]) -> bool:
    return sum(line.count("{") - line.count("}") for line in lines) == 0


def widths(count: int) -> list[int]:
    """Window sizes to try, largest first, down to a single line."""
    sizes = []
    width = max(1, count // 2)
    while width > 4:
        sizes.append(width)
        width //= 2
    return sizes + [4, 3, 2, 1]


def reduce_source(
    text: str,
    command: list[str],
    workdir: Path,
    expect: re.Pattern[str],
    status: int | None,
    timeout: float,
    passes: int,
    verbose: bool,
) -> str:
    lines = text.splitlines(keepends=True)
    for round_index in range(passes):
        before = len(lines)
        for start, end in sorted(
            top_level_regions(lines), key=lambda r: r[1] - r[0], reverse=True
        ):
            if end > len(lines):
                continue
            candidate = lines[:start] + lines[end:]
            if candidate and interesting(
                "".join(candidate), command, workdir, expect, status, timeout
            ):
                lines = candidate
        for width in widths(len(lines)):
            # A narrow window slides by one line: a two-line declaration left
            # over from the region pass sits at an odd offset as often as not,
            # and only an unaligned window can reach it.
            step = 1 if width <= 4 else width
            index = 0
            while index + width <= len(lines):
                chunk = lines[index : index + width]
                candidate = lines[:index] + lines[index + width :]
                if (
                    balanced(chunk)
                    and candidate
                    and interesting(
                        "".join(candidate), command, workdir, expect, status, timeout
                    )
                ):
                    lines = candidate
                    continue
                index += step
        if verbose:
            print(f"pass {round_index + 1}: {before} -> {len(lines)} lines")
        if len(lines) == before:
            break
    return "".join(lines)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("source", nargs="?", help="the C source to shrink")
    parser.add_argument("-o", "--out", help="where to write it (default: stdout)")
    parser.add_argument("--expect", help="regex the output must keep matching")
    parser.add_argument("--expect-status", type=int, help="status it must keep")
    parser.add_argument("--timeout", type=float, default=60.0)
    parser.add_argument("--passes", type=int, default=8)
    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("command", nargs="*", help="the interestingness test")
    args = parser.parse_args(argv)
    if args.self_test:
        return self_test()
    if not args.source or not args.command:
        parser.error("a source and a command are required")

    source = Path(args.source)
    text = source.read_text(encoding="utf-8", errors="replace")
    with tempfile.TemporaryDirectory(prefix="badc-reduce-") as tmp:
        workdir = Path(tmp)
        (workdir / "candidate.c").write_text(text, encoding="utf-8")
        code, output = run(args.command, workdir / "candidate.c", args.timeout)
        if args.expect_status is None and code == 0:
            print("the command succeeded on the original; nothing to reduce", file=sys.stderr)
            return 2
        pattern = re.compile(args.expect or expectation(output))
        if args.verbose:
            print(f"status {code}, expectation /{pattern.pattern}/")
        small = reduce_source(
            text,
            args.command,
            workdir,
            pattern,
            args.expect_status,
            args.timeout,
            args.passes,
            args.verbose,
        )
    kept = len(small.splitlines())
    print(
        f"{len(text.splitlines())} -> {kept} lines", file=sys.stderr
    )
    if args.out:
        Path(args.out).write_text(small, encoding="utf-8")
    else:
        sys.stdout.write(small)
    return 0


def self_test() -> int:
    failures: list[str] = []

    def check(name: str, got: object, want: object) -> None:
        if got != want:
            failures.append(f"{name}: got {got!r}, want {want!r}")

    source = (
        "int keep_me;\n"
        "struct S { int a; int b; };\n"
        "static int helper(int x)\n"
        "{\n"
        "    return x + 1;\n"
        "}\n"
        "int trigger(void)\n"
        "{\n"
        "    return 0;\n"
        "}\n"
    )
    lines = source.splitlines(keepends=True)
    regions = top_level_regions(lines)
    check("every region is brace-balanced", all(balanced(lines[a:b]) for a, b in regions), True)
    check("a function is one region", (2, 6) in regions, True)
    check(
        "a declaration is one region",
        (0, 1) in regions and (1, 2) in regions,
        True,
    )
    check(
        "panic expectation",
        expectation("thread 'main' panicked at src/c5/x.rs:1:2:\nboom\n"),
        re.escape("src/c5/x.rs:1:2"),
    )
    check(
        "error expectation",
        expectation("a.c:1: error: bad expression [B2020]"),
        re.escape("a.c:1: error: bad expression [B2020]"),
    )

    with tempfile.TemporaryDirectory() as tmp:
        workdir = Path(tmp)
        probe = workdir / "probe.py"
        probe.write_text(
            "import sys\n"
            "text = open(sys.argv[1]).read()\n"
            "if 'trigger' in text:\n"
            "    sys.stderr.write(\"panicked at src/c5/x.rs:1:2\\n\")\n"
            "    sys.exit(101)\n"
            "sys.exit(0)\n",
            encoding="utf-8",
        )
        command = [sys.executable, str(probe), "{}"]
        small = reduce_source(
            source,
            command,
            workdir,
            re.compile(re.escape("src/c5/x.rs:1:2")),
            None,
            30.0,
            8,
            False,
        )
        check("the reduction keeps the trigger", "trigger" in small, True)
        check("the reduction drops what does not matter", "keep_me" in small, False)
        check("the reduction drops the unrelated helper", "helper" in small, False)
        check("the reduction is smaller", len(small) < len(source), True)

    for failure in failures:
        print(f"FAIL {failure}")
    print(f"c_reduce self-test: {'FAILED' if failures else 'ok'}")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
