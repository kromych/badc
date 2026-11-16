#!/usr/bin/env python3
"""Run demo smokes concurrently and report one line per demo.

The lane step of `scripts/validate_local_boxes.py` invokes this with the
lane's roster on the command line; the roster lives there. Each smoke is
an independent process fetching into its own `demos/<name>/.cache`, so
they run in a pool. `--jobs` bounds the pool width only -- every demo on
the command line runs, and the closing lines print the roster and the
width.

An entry `path@config` runs the smoke under that configuration's
environment in `DEMO_ENV`, with the arguments in `DEMO_ARGS`. The
configurations of one smoke share its cache, so they run one after another
in one pool slot, each with its own verdict. `--lane KIND` takes the gate's
roster for that lane kind instead of a list. An entry in `AFTER_POOL` runs once the pool has drained, one at a
time, with the host to itself: the pool holds the host's load lock shared
and those entries exclusively (`host_load.py`), so neither this run's pool
nor another lane's suite, pool or kernel build runs beside them.

`--dry-run` prints the schedule and runs nothing; `--self-test` checks it.
Exit status is non-zero if any demo failed.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import os
import pathlib
import subprocess
import sys
import tempfile
import threading
import time

import host_load

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

# A failing smoke's own diagnostics precede its final error line, so the
# tail has to be deep enough to carry both.
FAIL_TAIL_LINES = 60


def script(entry: str) -> str:
    return entry.partition("@")[0]


def name(entry: str) -> str:
    """`qemu` for demos/qemu/smoke.py, `qemu@O` for its `O` configuration."""
    path, _, config = entry.partition("@")
    demo = pathlib.PurePosixPath(path).parent.name
    return f"{demo}@{config}" if config else demo


def slots(entries: list[str]) -> list[list[str]]:
    """The roster as pool tasks: one per smoke, holding its entries in
    roster order, without the `AFTER_POOL` ones."""
    by_script: dict[str, list[str]] = {}
    for e in entries:
        if e not in AFTER_POOL:
            by_script.setdefault(script(e), []).append(e)
    return list(by_script.values())


def command(entry: str) -> list[str]:
    return [sys.executable, script(entry), *DEMO_ARGS.get(entry, [])]


def run_one(entry: str) -> tuple[str, int, float, str]:
    start = time.time()
    proc = subprocess.run(
        command(entry),
        cwd=REPO_ROOT,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        errors="replace",
        env={**os.environ, **DEMO_ENV.get(entry, {})},
    )
    return entry, proc.returncode, time.time() - start, proc.stdout


# The emulator demo at the two levels CI's qemu job builds: -O0, and -O,
# here with the SSA checks after every pass. Each build self-links, starts,
# and boots the published kernel bundle to a shell through the box's UEFI
# firmware, then powers off; the per-boot cap is CI's. Both name every
# knob, so the caller's environment cannot change what an entry builds.
QEMU_BOOT = {
    "BADC_QEMU_REQUIRE_RUN": "1",
    "BADC_QEMU_BOOT": "gate",
    "BADC_QEMU_BOOT_TIMEOUT": "90",
    "BADC_QEMU_REQUIRE_FIRMWARE": "1",
}
# The tcl suite and OpenSSL's, C and --asm builds, without their timer-bound
# tests, which the pool's load decides, and those tests alone once the pool
# has drained.
OPENSSL = "demos/openssl/smoke.py"
DEMO_ENV = {
    "demos/qemu/smoke.py": {**QEMU_BOOT, "BADC_QEMU_OPT": "0", "BADC_QEMU_VERIFY_SSA": "0"},
    "demos/qemu/smoke.py@O": {**QEMU_BOOT, "BADC_QEMU_OPT": "1", "BADC_QEMU_VERIFY_SSA": "1"},
    "demos/tcl/smoke.py@untimed": {"BADC_TCL_TESTS": "untimed"},
    "demos/tcl/smoke.py@timed": {"BADC_TCL_TESTS": "timed"},
    **{f"{OPENSSL}@{c}{t}": {"BADC_OPENSSL_TESTS": t} for c in ("", "asm-") for t in ("untimed", "timed")},
}
DEMO_ARGS = {f"{OPENSSL}@asm-{t}": ["--asm"] for t in ("untimed", "timed")}
AFTER_POOL = {"demos/tcl/smoke.py@timed", f"{OPENSSL}@timed", f"{OPENSSL}@asm-timed"}
# A smoke named bare runs as the configurations that divide its tests
# between the pool and the phase after it.
SPLIT = {
    "demos/tcl/smoke.py": ["demos/tcl/smoke.py@untimed", "demos/tcl/smoke.py@timed"],
    OPENSSL: [f"{OPENSSL}@untimed", f"{OPENSSL}@timed"],
    f"{OPENSSL}@asm": [f"{OPENSSL}@asm-untimed", f"{OPENSSL}@asm-timed"],
}


def openssl_config(entry: str) -> str | None:
    """`c` or `asm` for an OpenSSL entry, None for any other."""
    if script(entry) != OPENSSL:
        return None
    return "asm" if entry.partition("@")[2].startswith("asm") else "c"


def only_openssl(entries: list[str], which: str) -> list[str]:
    """The roster with the OpenSSL entries of configuration `which` (`c`,
    `asm`, or `both`) and no others."""
    return [e for e in entries if openssl_config(e) in (None, which) or which == "both"]


def expand(entries: list[str]) -> list[str]:
    """The roster with each `SPLIT` smoke as its configurations."""
    return [part for e in entries for part in SPLIT.get(e, [e])]


def after_pool(entries: list[str]) -> list[str]:
    """The `AFTER_POOL` entries, in roster order."""
    return [e for e in entries if e in AFTER_POOL]


def run_roster(
    entries: list[str], jobs: int, runner=run_one, lock_dir: pathlib.Path | None = None
) -> tuple[list[tuple[str, int, str]], list[tuple[float, str]]]:
    """Run the pool, then the `AFTER_POOL` entries alone; the failures and
    the costs."""
    failures: list[tuple[str, int, str]] = []
    costs: list[tuple[float, str]] = []
    lock = threading.Lock()

    def run_slot(slot: list[str]) -> None:
        for entry in slot:
            _, rc, secs, out = runner(entry)
            with lock:
                mark = "ok" if rc == 0 else f"FAILED (rc={rc})"
                print(f"demo {entry}: {mark} in {secs:.0f}s", flush=True)
                costs.append((secs, name(entry)))
                if rc != 0:
                    failures.append((entry, rc, out))

    with host_load.held(exclusive=False, directory=lock_dir):
        with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as pool:
            for fut in [pool.submit(run_slot, t) for t in slots(entries)]:
                fut.result()
    alone = after_pool(entries)
    if alone:
        with host_load.held(exclusive=True, directory=lock_dir) as waited:
            for entry in alone:
                print(
                    f"demo {entry}: starts after the pool, the host to itself "
                    f"(waited {waited:.0f}s for the load lock)",
                    flush=True,
                )
                run_slot([entry])
    return failures, costs


def self_test() -> int:
    """An `AFTER_POOL` entry starts once every pool entry has finished and
    another lane's shared holder of the load lock has let it go; a smoke's
    configurations run in roster order in one slot."""
    roster = [
        f"{OPENSSL}@untimed",
        f"{OPENSSL}@asm-untimed",
        f"{OPENSSL}@timed",
        f"{OPENSSL}@asm-timed",
        "demos/qemu/smoke.py",
        "demos/tcl/smoke.py@untimed",
        "demos/tcl/smoke.py@timed",
        "demos/qemu/smoke.py@O",
        "demos/lua/smoke.py",
    ]
    spans: dict[str, tuple[float, float]] = {}
    long = ("demos/tcl/smoke.py@untimed", f"{OPENSSL}@asm-untimed")

    def fake(entry: str) -> tuple[str, int, float, str]:
        start = time.time()
        time.sleep(0.3 if entry in long else 0.05)
        spans[entry] = (start, time.time())
        return entry, 0, time.time() - start, ""

    scripts = pathlib.Path(__file__).resolve().parent
    with tempfile.TemporaryDirectory() as tmp:
        released = pathlib.Path(tmp) / "released"
        other_lane = (
            f"import pathlib, sys, time; sys.path.insert(0, {str(scripts)!r}); import host_load\n"
            f"with host_load.held(False, pathlib.Path({tmp!r})):\n"
            "    print('held', flush=True); time.sleep(1.0)\n"
            f"    pathlib.Path({str(released)!r}).write_text(repr(time.time()))\n"
        )
        env = {k: v for k, v in os.environ.items() if k != host_load.HELD}
        child = subprocess.Popen(
            [sys.executable, "-c", other_lane], stdout=subprocess.PIPE, text=True, env=env
        )
        assert child.stdout is not None and child.stdout.readline().strip() == "held"
        failures, _ = run_roster(roster, 4, fake, pathlib.Path(tmp))
        child.wait()
        let_go = float(released.read_text())
    assert not failures, failures
    after = after_pool(roster)
    assert after == [f"{OPENSSL}@timed", f"{OPENSSL}@asm-timed", "demos/tcl/smoke.py@timed"]
    pool_end = max(end for e, (_, end) in spans.items() if e not in AFTER_POOL)
    # One at a time after the pool, in roster order.
    for prev, entry in zip([None, *after], after):
        start = spans[entry][0]
        assert start >= (spans[prev][1] if prev else pool_end), (entry, spans)
        # Without fcntl (Windows) nothing locks.
        assert host_load.fcntl is None or start >= let_go, (entry, let_go)
    assert spans["demos/qemu/smoke.py"][1] <= spans["demos/qemu/smoke.py@O"][0], spans
    assert spans[f"{OPENSSL}@untimed"][1] <= spans[f"{OPENSSL}@asm-untimed"][0], spans
    for entry in roster:
        asm = entry.startswith(f"{OPENSSL}@asm-")
        assert command(entry)[1:] == [script(entry), *(["--asm"] if asm else [])], entry
    # --openssl keeps one configuration's entries and every other demo.
    for which, kept in (("c", SPLIT[OPENSSL]), ("asm", SPLIT[f"{OPENSSL}@asm"]), ("both", roster[:4])):
        assert only_openssl(roster, which) == [*kept, *roster[4:]], which
    bare = expand(["demos/lua/smoke.py", "demos/tcl/smoke.py", OPENSSL, f"{OPENSSL}@asm"])
    assert bare == [
        "demos/lua/smoke.py", "demos/tcl/smoke.py@untimed", "demos/tcl/smoke.py@timed",
        f"{OPENSSL}@untimed", f"{OPENSSL}@timed", f"{OPENSSL}@asm-untimed", f"{OPENSSL}@asm-timed",
    ], bare
    print("[run_demos] self-test OK")
    return 0


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--jobs", type=int, default=4, help="concurrent demos")
    p.add_argument("--dry-run", action="store_true", help="print the schedule; run nothing")
    p.add_argument("demos", nargs="*", help="paths to smoke.py scripts, or path@config")
    p.add_argument("--lane", choices=("linux", "windows", "macos"),
                   help="the gate's roster for that lane kind, in place of a list")
    p.add_argument("--openssl", choices=("c", "asm", "both"), default="both",
                   help="the OpenSSL configuration whose entries run; the gate "
                   "gives each Linux box one (validate_local_boxes.py --openssl-plan)")
    p.add_argument("--self-test", action="store_true", help="check the schedule and exit")
    args = p.parse_args()
    if args.self_test:
        return self_test()
    if args.lane:
        if args.demos:
            p.error("--lane takes no demo list")
        import validate_local_boxes

        args.demos = [d for d, kinds in validate_local_boxes.GATING_DEMOS if args.lane in kinds]
    if not args.demos:
        p.error("no demo named")

    roster = only_openssl(expand(args.demos), args.openssl)
    unknown = [e for e in roster if "@" in e and e not in DEMO_ENV]
    if unknown:
        p.error(f"no configuration in DEMO_ENV for {' '.join(unknown)}")
    tasks = slots(roster)
    jobs = max(1, min(args.jobs, len(tasks)))
    if args.dry_run:
        for slot in tasks:
            print(f"demo phase: pool slot {' '.join(name(e) for e in slot)}")
        for entry in after_pool(roster):
            print(f"demo phase: then alone, the load lock exclusive: {name(entry)}")
        print(f"demo phase: {len(tasks)} pool slots, {jobs} at a time")
        return 0

    phase_start = time.time()
    failures, costs = run_roster(roster, jobs)

    for entry, rc, out in failures:
        lines = out.splitlines()
        cut = max(len(lines) - FAIL_TAIL_LINES, 0)
        # A verdict line above the tail is kept whatever its length.
        earlier = [ln for ln in lines[:cut] if "FAIL" in ln]
        print(f"--- {entry} FAILED (rc={rc}), its earlier FAIL lines and last "
              f"{FAIL_TAIL_LINES} lines:")
        print("\n".join([*earlier, *lines[cut:]]), flush=True)

    # The last three lines are the whole report a green step shows.
    slowest = ", ".join(f"{n} {s:.0f}s" for s, n in sorted(costs, reverse=True)[:4])
    print(f"demo phase: roster {' '.join(name(e) for e in roster)}")
    print(f"demo phase: slowest {slowest}")
    print(
        f"demo phase: {len(roster) - len(failures)}/{len(roster)} ok in "
        f"{time.time() - phase_start:.0f}s wall, {jobs} at a time",
        flush=True,
    )
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
