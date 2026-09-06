#!/usr/bin/env python3
"""Exclusive use of a kernel build tree.

A build writes into the tree and ``make clean`` removes its generated sources,
so two runs sharing one tree delete each other's inputs; what surfaces is a
compiler reading a source that is no longer there, at whichever unit the two
overlapped on. The gate names one cached tree per box, so two runs meet there
by default.

``exclusive`` takes an advisory ``flock`` on a file in the tree and keeps it
for the process; the kernel drops it when the holder exits, so an interrupted
run leaves nothing to clear. A second run is refused rather than queued:
queuing looks like a hang for as long as a kernel build takes.
"""

from __future__ import annotations

import fcntl
import os
import sys
import tempfile
import time
from pathlib import Path
from typing import IO

LOCK_NAME = ".badc-tree-lock"

# The taken locks, kept so a caller that ignores the handle still holds them.
_held: list[IO[str]] = []


def holder(tree: Path) -> str | None:
    """Who holds `tree`, or None if nothing does. The probe takes the
    lock only to release it, so a free tree stays free; a lock held by
    another open file description -- this process's included -- refuses
    it, same as `exclusive`."""
    lock = tree / LOCK_NAME
    if not lock.is_file():
        return None
    with lock.open("a+") as fh:
        try:
            fcntl.flock(fh, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except OSError:
            fh.seek(0)
            return fh.read().strip() or "an unnamed run"
    return None


def exclusive(tree: Path, what: str) -> IO[str]:
    """Hold `tree` for this process, or exit naming the run that holds it."""
    fh = (tree / LOCK_NAME).open("a+")
    try:
        fcntl.flock(fh, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except OSError:
        fh.seek(0)
        holder = fh.read().strip() or "an unnamed run"
        sys.exit(f"linux: {tree} is in use by {holder}; one run at a time "
                 f"writes a tree -- wait for it, or use a tree of your own")
    fh.seek(0)
    fh.truncate()
    fh.write(f"{what}, pid {os.getpid()}, since "
             f"{time.strftime('%Y-%m-%d %H:%M:%S')}\n")
    fh.flush()
    _held.append(fh)
    return fh


def release(fh: IO[str]) -> None:
    """Drop a hold taken by `exclusive`."""
    fh.close()
    _held.remove(fh)


def self_test() -> None:
    """A second holder is refused and told whose the tree is; a released
    tree is takeable again. flock is per open file description, so one
    process asking twice is refused exactly as two processes are."""
    with tempfile.TemporaryDirectory() as d:
        tree = Path(d)
        first = exclusive(tree, "first run")
        try:
            exclusive(tree, "second run")
        except SystemExit as e:
            assert "first run" in str(e) and str(tree) in str(e), e
        else:
            raise AssertionError("a second holder was not refused")
        assert "first run" in (holder(tree) or ""), holder(tree)
        release(first)
        assert holder(tree) is None
        release(exclusive(tree, "third run"))
        assert holder(Path(d) / "absent") is None


if __name__ == "__main__":
    self_test()
    print("linux ktree: self-test ok", flush=True)
