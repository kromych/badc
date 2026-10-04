#!/usr/bin/env python3
"""Run `cargo test` with the given arguments and fail when a test binary
ends without reporting every test it announced.

cargo judges a test binary by its exit status alone. A binary that one of
its tests ends early -- a C `exit` reached in-process, `std::process::exit`
-- exits with whatever status that call passed, and a 0 there reads as
success although the tests after it never ran. libtest prints `running N
tests` before the first test and `test result: ... P passed; F failed; I
ignored; M measured; X filtered out` after the last, N counting the tests
the filters left. So every binary has to print the second line, with
P + F + I + M equal to N.

    python3 scripts/cargo_test.py --release --features full
    python3 scripts/cargo_test.py --self-test

cargo's output passes through as it arrives. The exit status is cargo's,
or 1 when cargo succeeded and a binary's count does not add up.
"""

from __future__ import annotations

import io
import re
import subprocess
import sys
from typing import BinaryIO

BINARY = re.compile(r"^\s+(Running|Doc-tests) (.+)$")
RUNNING = re.compile(r"^running (\d+) tests?$")
RESULT = re.compile(
    r"^test result: \w+\. (\d+) passed; (\d+) failed; (\d+) ignored; (\d+) measured; "
    r"\d+ filtered out"
)


def tests(n: int) -> str:
    return f"{n} test" if n == 1 else f"{n} tests"


class Tally:
    """Follows a cargo test transcript a line at a time."""

    def __init__(self) -> None:
        self.binary = "a test binary"
        self.open: tuple[str, int] | None = None
        self.problems: list[str] = []

    def line(self, text: str) -> None:
        text = text.rstrip("\r\n")
        if m := BINARY.match(text):
            self.binary = f"{m.group(1)} {m.group(2)}"
        elif m := RUNNING.match(text):
            self.close()
            self.open = (self.binary, int(m.group(1)))
        elif (m := RESULT.match(text)) and self.open:
            name, announced = self.open
            reported = sum(int(m.group(k)) for k in range(1, 5))
            if reported != announced:
                self.problems.append(f"{name}: announced {tests(announced)} and reported {reported}")
            self.open = None

    def close(self) -> None:
        if self.open:
            name, announced = self.open
            self.problems.append(
                f"{name}: announced {tests(announced)} and ended without a result line"
            )
            self.open = None

    def finish(self) -> list[str]:
        self.close()
        return self.problems


def run(argv: list[str], out: BinaryIO) -> int:
    """Run `argv`, passing its merged output through to `out`, and judge it."""
    tally = Tally()
    proc = subprocess.Popen(argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    assert proc.stdout is not None
    for raw in proc.stdout:
        out.write(raw)
        out.flush()
        tally.line(raw.decode("utf-8", "replace"))
    rc = proc.wait()
    problems = tally.finish()
    for p in problems:
        out.write(f"cargo_test.py: {p}\n".encode())
    out.flush()
    if rc != 0:
        return rc
    return 1 if problems else 0


def self_test() -> int:
    def problems(transcript: str) -> list[str]:
        tally = Tally()
        for text in transcript.splitlines():
            tally.line(text)
        return tally.finish()

    lib = "     Running unittests src/lib.rs (target/release/deps/badc-0)\n"
    done = "test result: ok. 2 passed; 0 failed; 1 ignored; 0 measured; 9 filtered out; finished\n"
    assert problems(lib + "\nrunning 3 tests\ntest a ... ok\n\n" + done) == []
    assert problems("   Doc-tests badc\n\nrunning 1 test\n" + done.replace("2 passed", "0 passed")) == []
    # A binary a test ended: its announcement has no result line, whether a
    # later binary runs or the transcript ends.
    cut = lib + "\nrunning 4474 tests\ntest a ... ok\n"
    assert problems(cut) == [
        "Running unittests src/lib.rs (target/release/deps/badc-0): announced 4474 tests "
        "and ended without a result line"
    ], problems(cut)
    assert len(problems(cut + "     Running tests/x.rs (t)\n\nrunning 3 tests\n" + done)) == 1
    assert problems(lib + "running 5 tests\n" + done) == [
        "Running unittests src/lib.rs (target/release/deps/badc-0): announced 5 tests "
        "and reported 3"
    ]
    # End to end: cargo's status wins, and a clean status with a cut binary
    # fails and says which.
    py = [sys.executable, "-c"]
    sink = io.BytesIO()
    assert run(py + ["print('running 2 tests')"], sink) == 1
    assert b"announced 2 tests and ended without a result line" in sink.getvalue()
    assert run(py + ["import sys; print('running 2 tests'); sys.exit(101)"], sink) == 101
    assert run(py + [f"print('running 3 tests'); print({done.strip()!r})"], sink) == 0
    print("[cargo_test] self-test OK")
    return 0


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    return run(["cargo", "test", *sys.argv[1:]], sys.stdout.buffer)


if __name__ == "__main__":
    sys.exit(main())
