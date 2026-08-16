#!/usr/bin/env python3
"""Summary of the diagnostics badc wrote on invocations that succeeded.

A warning comes with `rc == 0`, so a build driver that reads only the exit
status observes none. buildcc.py and ldshim.py append what badc wrote on a
successful compile or link to ``$BADC_WARN_LOG``, one line per diagnostic
line, tagged `cc`/`ld` and the unit; this reads that log back.

A defconfig build produces tens of thousands of lines, so the reported form
is a count per cause: the message with its site folded out. Every cause is
listed however rare, so one warning among thousands stays visible.

``--self-test`` checks the folding and the reader and takes no build.
"""

from __future__ import annotations

import collections
import re
import sys
import tempfile
from pathlib import Path

# A diagnostic's variable parts: the names badc quotes (gcc's `name' form
# included) and standalone numbers. A digit inside a word (I64) is part of
# the cause, not a site, so only whole numbers fold.
QUOTED = re.compile(r"`[^`']*'|`[^`]*`|'[^']*'|\"[^\"]*\"")
NUMBER = re.compile(r"\b\d+\b")
SEVERITIES = ("warning", "error", "note")


def category(line: str) -> tuple[str, str]:
    """A diagnostic line's severity and its cause with the site folded out.

    badc writes `<file>:<line>: warning: <msg>`, `badc: warning: <msg>` and
    `badc-ld: warning: <msg>`; the leftmost severity word separates the
    location from the message in all three. A line with no severity is
    reported under `other` rather than dropped."""
    text = " ".join(line.split())
    hits = [(text.find(f"{s}: "), s) for s in SEVERITIES if f"{s}: " in text]
    severity, message = "other", text
    if hits:
        at, severity = min(hits)
        message = text[at + len(severity) + 2:]
    return severity, NUMBER.sub("N", QUOTED.sub("_", message))


def read(path: Path) -> tuple[collections.Counter, set[str]]:
    """Count a log's diagnostics by (shim, severity, cause), with the set of
    units that produced one.

    badc echoes the offending source under a diagnostic; that line has no
    severity and belongs to the one above it, but only within the same unit
    -- the log interleaves them. A stray line under no diagnostic counts
    under `other`."""
    counts: collections.Counter = collections.Counter()
    sites: set[str] = set()
    current: str | None = None
    if not path.exists():
        return counts, sites
    for line in path.read_text(errors="replace").splitlines():
        kind, _, rest = line.partition("\t")
        site, _, diag = rest.partition("\t")
        if not diag:
            continue
        severity, cause = category(diag)
        if severity == "other" and current == f"{kind}\t{site}":
            continue
        current = f"{kind}\t{site}" if severity != "other" else None
        counts[(kind, severity, cause)] += 1
        sites.add(f"{kind}:{site}")
    return counts, sites


def summary(path: Path) -> tuple[collections.Counter, list[str]]:
    """The counts and the lines a driver logs for them."""
    counts, sites = read(path)
    lines = [f"badc diagnostics: {sum(counts.values())} from {len(sites)} "
             f"units/links, {len(counts)} distinct (raw: {path})"]
    lines += [f"  {kind} {severity}: {n} x {cause}"
              for (kind, severity, cause), n in counts.most_common()]
    return counts, lines


def self_test() -> None:
    inline = ("badc: warning: `sk_msg_sg_copy` is marked always_inline "
              "but was not inlined: callee is recursive")
    assert category(inline) == (
        "warning",
        "_ is marked always_inline but was not inlined: callee is recursive")
    assert category(inline) == category(inline.replace("sk_msg_sg_copy", "_x"))
    assert category("kernel/fork.c:1234: warning: unused variable `p'") \
        == ("warning", "unused variable _")
    assert category("badc-ld: warning: orphan section `.foo' from `a.o' "
                    "being placed in section `.bar'") \
        == ("warning", "orphan section _ from _ being placed in section _")
    assert category("something badc said") == ("other", "something badc said")
    assert category("badc: warning: disallowed inst SegLoad { addr: 7, "
                    "kind: I64, seg: Gs }")[1] == (
        "disallowed inst SegLoad { addr: N, kind: I64, seg: Gs }")

    with tempfile.TemporaryDirectory() as d:
        path = Path(d) / "warnings.txt"
        # Two units, each a diagnostic plus the source line badc echoes
        # under it, then a stray line no diagnostic precedes.
        path.write_text(
            "cc\ta.c\ta.c:1: warning: unused parameter `x`\n"
            "cc\ta.c\tint x)\n"
            "cc\tb.c\ta.c:9: warning: unused parameter `y`\n"
            "cc\tb.c\tint y)\n"
            "ld\tvmlinux\tsomething else\n")
        counts, sites = read(path)
        assert counts == collections.Counter({
            ("cc", "warning", "unused parameter _"): 2,
            ("ld", "other", "something else"): 1,
        }), counts
        assert sites == {"cc:a.c", "cc:b.c", "ld:vmlinux"}, sites
        assert len(summary(path)[1]) == 3


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        self_test()
        print("linux diags: self-test ok", flush=True)
        raise SystemExit(0)
    if len(sys.argv) != 2:
        raise SystemExit("usage: diags.py <warnings log> | --self-test")
    for line in summary(Path(sys.argv[1]))[1]:
        print(line, flush=True)
