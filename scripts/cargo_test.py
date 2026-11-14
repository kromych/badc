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

libtest names a test still running after 60 seconds. One still running
`HUNG_SECONDS` after that is taken as hung: the run's process group is
stopped and the test named, so a compiler that loops fails the suite
instead of holding the host, and the load lock with it, until someone
looks.
"""

from __future__ import annotations

import io
import os
import re
import signal
import subprocess
import sys
import threading
import time
from typing import BinaryIO

import host_load

BINARY = re.compile(r"^\s+(Running|Doc-tests) (.+)$")
RUNNING = re.compile(r"^running (\d+) tests?$")
RESULT = re.compile(
    r"^test result: \w+\. (\d+) passed; (\d+) failed; (\d+) ignored; (\d+) measured; "
    r"\d+ filtered out"
)


SLOW = re.compile(r"^test (\S+) has been running for over \d+ seconds$")
DONE = re.compile(r"^test (\S+) \.\.\. ")
# Past libtest's own 60-second notice.
HUNG_SECONDS = 1800


def tests(n: int) -> str:
    return f"{n} test" if n == 1 else f"{n} tests"


class Tally:
    """Follows a cargo test transcript a line at a time."""

    def __init__(self) -> None:
        self.binary = "a test binary"
        self.open: tuple[str, int] | None = None
        self.problems: list[str] = []
        # Tests libtest named as slow, with when it did, until they finish.
        self.slow: dict[str, float] = {}

    def line(self, text: str, now: float = 0.0) -> None:
        text = text.rstrip("\r\n")
        if m := SLOW.match(text):
            self.slow.setdefault(m.group(1), now)
        elif m := DONE.match(text):
            self.slow.pop(m.group(1), None)
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

    def hung(self, now: float, limit: float) -> list[str]:
        """The slow tests still running `limit` seconds after libtest named them."""
        return sorted(t for t, since in self.slow.items() if now - since > limit)


def stop(proc: subprocess.Popen) -> None:
    """Stop `proc` and the test binaries and compilers it started."""
    if os.name == "nt":
        subprocess.run(["taskkill", "/F", "/T", "/PID", str(proc.pid)], capture_output=True)
    else:
        os.killpg(proc.pid, signal.SIGKILL)


def run(argv: list[str], out: BinaryIO, limit: float = HUNG_SECONDS) -> int:
    """Run `argv`, passing its merged output through to `out`, and judge it."""
    tally = Tally()
    group = {"creationflags": subprocess.CREATE_NEW_PROCESS_GROUP} if os.name == "nt" else {
        "start_new_session": True
    }
    proc = subprocess.Popen(argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, **group)
    assert proc.stdout is not None
    hung: list[str] = []
    lock = threading.Lock()
    ended = threading.Event()

    def watch() -> None:
        while not ended.wait(min(30.0, limit / 4)):
            with lock:
                hung[:] = tally.hung(time.monotonic(), limit)
            if hung:
                stop(proc)
                return

    watcher = threading.Thread(target=watch, daemon=True)
    watcher.start()
    # The run has a group of its own, which a terminal's interrupt or a
    # stopped gate lane no longer reaches, so the wrapper passes them on.
    def interrupted(signum, _frame) -> None:
        stop(proc)
        sys.exit(128 + signum)

    previous = {
        s: signal.signal(s, interrupted)
        for s in (signal.SIGINT, signal.SIGTERM)
        if threading.current_thread() is threading.main_thread()
    }
    try:
        for raw in proc.stdout:
            out.write(raw)
            out.flush()
            with lock:
                tally.line(raw.decode("utf-8", "replace"), time.monotonic())
        rc = proc.wait()
    finally:
        for s, h in previous.items():
            signal.signal(s, h)
    ended.set()
    watcher.join()
    problems = tally.finish()
    for t in hung:
        problems.append(f"{t} ran past {int(limit)} seconds after libtest's notice; the run was stopped")
    for p in problems:
        out.write(f"cargo_test.py: {p}\n".encode())
    out.flush()
    if hung:
        return 1
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
    # A test libtest named as slow and still running past the limit stops the
    # run and is named; one that finishes in time is not.
    tally = Tally()
    tally.line("test a::slow has been running for over 60 seconds", 10.0)
    tally.line("test b::quick has been running for over 60 seconds", 10.0)
    tally.line("test b::quick ... ok", 20.0)
    assert tally.hung(50.0, 30.0) == ["a::slow"] and tally.hung(30.0, 30.0) == []
    sink = io.BytesIO()
    spin = "import time; print('running 1 test'); print('test x::spin has been running for over 60 seconds', flush=True); time.sleep(600)"
    t0 = time.monotonic()
    assert run(py + [spin], sink, limit=1.0) == 1
    assert time.monotonic() - t0 < 60, "the hung run was not stopped"
    assert b"x::spin ran past 1 seconds" in sink.getvalue(), sink.getvalue()
    print("[cargo_test] self-test OK")
    return 0


def main() -> int:
    if sys.argv[1:] == ["--self-test"]:
        return self_test()
    # A suite loads the host; a timer-bound demo phase waits for it.
    with host_load.held(exclusive=False):
        return run(["cargo", "test", *sys.argv[1:]], sys.stdout.buffer)


if __name__ == "__main__":
    sys.exit(main())
