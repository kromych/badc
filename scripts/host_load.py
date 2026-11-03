"""The host-wide lock between lanes that share a machine.

Several lanes run on one box at once: the queues' lanes and the gate's, and
on the Mac every worktree's. The phases that load the host -- a test suite
(`cargo_test.py`), a demo pool (`run_demos.py`), a kernel build
(`demos/linux/verify.py`) -- hold `~/.badc-load.lock` shared. A phase whose
tests race a timer against the scheduler holds it exclusively, so no lane's
load runs beside it.

A shared holder passes through `~/.badc-load.turnstile` first, and an
exclusive one keeps it while it waits, so shared holders that arrive after
an exclusive waiter queue behind it instead of starving it. A holder marks
its environment, and its child processes do not take the lock again: a
nested shared request behind a waiting exclusive one would wait forever.
A host without `fcntl` (Windows) takes no lock.
"""

from __future__ import annotations

import contextlib
import os
import pathlib
import time
from typing import Iterator

try:
    import fcntl
except ImportError:  # Windows
    fcntl = None

HELD = "BADC_LOAD_LOCK_HELD"


@contextlib.contextmanager
def held(exclusive: bool, directory: pathlib.Path | None = None) -> Iterator[float]:
    """Hold the host's load lock for the block; yields the seconds waited."""
    if fcntl is None or os.environ.get(HELD):
        yield 0.0
        return
    where = directory or pathlib.Path.home()
    start = time.time()
    with open(where / ".badc-load.turnstile", "a") as turnstile, open(
        where / ".badc-load.lock", "a"
    ) as lock:
        fcntl.flock(turnstile, fcntl.LOCK_EX)
        fcntl.flock(lock, fcntl.LOCK_EX if exclusive else fcntl.LOCK_SH)
        fcntl.flock(turnstile, fcntl.LOCK_UN)
        os.environ[HELD] = "exclusive" if exclusive else "shared"
        try:
            yield time.time() - start
        finally:
            del os.environ[HELD]
            fcntl.flock(lock, fcntl.LOCK_UN)
