#!/usr/bin/env python3
"""Bucket a `perf script` call-graph dump into compiler phases.

Flat symbol shares misattribute allocator, memcpy and hash-table time to the
runtime rather than to the phase that spent it. This walks each sample's
stack from the leaf outward and charges it to the first frame that matches a
phase pattern, so library time lands on its caller.

Input: `perf script -i <data> -F comm,ip,sym,dso` output.
"""

from __future__ import annotations

import argparse
import re
import sys
from collections import Counter
from pathlib import Path

# Ordered: the first pattern matching a frame decides the bucket. Patterns
# are matched against the demangled symbol as perf prints it.
PHASES: list[tuple[str, str]] = [
    ("preprocess", r"badc::c5::preprocessor::"),
    ("lex", r"badc::c5::(lexer|token)"),
    # Inline-asm section materialization lives in emit_common but runs for
    # file-scope asm during the front end, so it has to be charged before
    # the ssa-emit rule below or it reads as codegen time.
    ("asm-sections", r"(materialize_(file_)?asm|measure_(round|asm_section|fill)"
                     r"|AsmSection|asm_(non_local|weak_only)_names|section_name_keys)"),
    ("regalloc", r"badc::c5::codegen::ssa::(reg_alloc|liveness|phi_class|slot_coalesce|shadow)"),
    ("ssa-build", r"badc::c5::codegen::ssa::(build|mem2reg)"),
    ("optimizer", r"badc::c5::codegen::passes::"),
    ("ssa-emit", r"badc::c5::codegen::ssa::(emit_common|native|mod)"),
    ("encode", r"badc::c5::codegen::(x86_64|aarch64|abi_classify|jit|mod)"),
    ("object-write", r"badc::c5::object::"),
    ("linker", r"badc::c5::linker::"),
    ("parse+sema+ir", r"badc::c5::(compiler|ir|layout|symbol|program|types|headers|runtime|error|host|op)"),
    ("vm", r"badc::c5::vm::"),
    ("driver", r"badc::(run|main|ingest|CompileOptions|Compiler)|^badc::[a-z_]+$"),
]
COMPILED = [(name, re.compile(pat)) for name, pat in PHASES]


def bucket(frames: list[str]) -> str:
    for f in frames:
        for name, rx in COMPILED:
            if rx.search(f):
                return name
    for f in frames:
        if "start_thread" in f or "__libc_start" in f or "clone3" in f:
            return "startup/teardown"
    return "unattributed"


def leaf_bucket(frames: list[str]) -> str:
    """Coarse leaf classification, for the share of a phase that is spent in
    allocator or bulk-memory routines rather than compiler code."""
    if not frames:
        return "?"
    f = frames[0]
    if re.search(r"malloc|free|realloc|calloc|_int_|arena|tcache|mmap|munmap|brk", f):
        return "alloc"
    if re.search(r"memcpy|memset|memmove|memchr|memcmp|strlen|__memmove|__memset", f):
        return "memops"
    if re.search(r"hashbrown|BTree|HashMap|Vec<|RawTable|foldhash|rustc_hash", f):
        return "containers"
    if f.startswith("[k]") or "entry_SYSCALL" in f or "do_syscall" in f:
        return "kernel"
    return "other"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("script", type=Path, help="output of `perf script`")
    ap.add_argument("--leaf-of", help="also break this phase down by leaf class")
    ap.add_argument("--leaf-top", type=int, default=25,
                    help="leaf symbols to print for --leaf-of")
    args = ap.parse_args()

    counts: Counter = Counter()
    leafclass: Counter = Counter()
    leafsym: Counter = Counter()
    total = 0
    frames: list[str] = []

    def flush() -> None:
        nonlocal total, frames
        if not frames:
            return
        b = bucket(frames)
        counts[b] += 1
        total += 1
        if args.leaf_of and b == args.leaf_of:
            leafclass[leaf_bucket(frames)] += 1
            leafsym[frames[0][:110]] += 1
        frames = []

    with open(args.script, errors="replace") as fh:
        for line in fh:
            if not line.strip():
                flush()
                continue
            if not (line.startswith("\t") or line.startswith(" ")):
                # Sample header line: `comm pid [cpu] time: period event:`
                flush()
                continue
            parts = line.strip().split(None, 1)
            if len(parts) < 2:
                continue
            sym = parts[1]
            sym = re.sub(r"\s*\([^)]*\)\s*$", "", sym).strip()
            frames.append(sym)
    flush()

    if not total:
        sys.exit("perf_phases: no samples parsed")
    print(f"samples: {total}")
    print(f"{'phase':<20} {'samples':>9} {'share':>7}")
    for name, n in counts.most_common():
        print(f"{name:<20} {n:>9} {100.0 * n / total:>6.2f}%")
    if args.leaf_of:
        sub = sum(leafclass.values())
        print(f"\nleaf classes within {args.leaf_of} ({sub} samples)")
        for name, n in leafclass.most_common():
            print(f"  {name:<14} {n:>8} {100.0 * n / sub:>6.2f}%")
        print(f"\ntop leaf symbols within {args.leaf_of}")
        for name, n in leafsym.most_common(args.leaf_top):
            print(f"  {100.0 * n / sub:>6.2f}%  {name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
