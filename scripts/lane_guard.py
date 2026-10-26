#!/usr/bin/env python3
"""Keep two gate runs out of one box tree.

A lane's steps run on the box under the shell that reads the lane script;
stopping the gate on the Mac does not stop that shell, which runs its
current step to the end. The next run's checkout would rewrite the tree
underneath it, and the two runs would share test files, caches and the
snapshot directory.

`hold` records the lane shell (this process's parent) in `.gate-lane`;
`check` exits 75 while the recorded shell is still running; `release`
removes the record. Run from the box tree.
"""
from __future__ import annotations

import os
import pathlib
import subprocess
import sys

RECORD = pathlib.Path(".gate-lane")
BUSY = 75


def identity(pid: int) -> str | None:
    """What tells the process apart from a later one with the same pid: its
    start time on Linux, its image name on Windows; None once it is gone."""
    if os.name == "nt":
        out = subprocess.run(
            ["tasklist", "/FI", f"PID eq {pid}", "/FO", "CSV", "/NH"],
            capture_output=True, text=True,
        ).stdout
        for line in out.splitlines():
            fields = [f.strip('"') for f in line.split('","')]
            if len(fields) > 1 and fields[1] == str(pid):
                return fields[0].lower()
        return None
    try:
        stat = pathlib.Path(f"/proc/{pid}/stat").read_text()
    except OSError:
        try:
            os.kill(pid, 0)
        except OSError:
            return None
        return "alive"
    return stat.rsplit(")", 1)[1].split()[19]


def main() -> int:
    action = sys.argv[1] if len(sys.argv) > 1 else ""
    if action == "hold":
        pid = os.getppid()
        RECORD.write_text(f"{pid} {identity(pid) or ''}\n")
        return 0
    if action == "release":
        RECORD.unlink(missing_ok=True)
        return 0
    if action != "check":
        print("usage: lane_guard.py hold|check|release", file=sys.stderr)
        return 2
    try:
        pid_s, _, held = RECORD.read_text().strip().partition(" ")
        pid = int(pid_s)
    except (OSError, ValueError):
        return 0
    now = identity(pid)
    if now is None or (held and now != held):
        return 0
    print(
        f"a previous gate run's lane is still running in {os.getcwd()} (pid {pid}); "
        "wait for it to end or stop it, then rerun"
    )
    return BUSY


if __name__ == "__main__":
    sys.exit(main())
