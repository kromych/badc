#!/usr/bin/env python3
"""Publish one perf run into the data repository the performance page reads.

`tests/perf/run.py --json` writes what a run measured; this places that file
in a checkout of `badc-perf-data` under the commit it measured, updates the
index the page charts, and points the run's branch at it.

    perf_publish.py --data perf.json --repo ../badc-perf-data \\
        --sha <badc commit> --branch master --runner ubuntu-latest \\
        [--image ubuntu-24.04] [--benches cpython_cmp.md] [--run-id N]

Layout, with the commit sharded so no directory grows past what the contents
API lists in one page:

    runs/<sha[0:2]>/<sha[2:4]>/<sha>/<runner>.json
    branches/<branch>                 symlink to that directory
    index.json                        one record per run, newest first

The page derives a run's path from a commit with no listing call, follows
`branches/<name>` for the newest run on a branch (GitHub's raw serves a
symlink as its target path, so that is one extra fetch), and reads
`index.json` for the series. Committing is this tool's job; pushing is the
caller's.

This is the one place the record envelope is written -- `schema`, `commit`,
`machine.runner`, `machine.image`, `provenance` -- so a measured run and a run
recovered by `perf_backfill.py` cannot drift apart in shape. A field whose
value the caller does not supply is left out rather than written empty.

The record states the contract its producer filled: 3 where the harness
measured the run and stated each leg's flags, 2 where a recovered run carries
compiler names alone. A record lists the compilers that ran on that machine
and no others.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

INDEX = "index.json"
# What a record a producer hands over without a schema of its own is filed
# as. The index keeps its own number: 3 changed the compiler entries of a
# record and nothing in the index's entries.
RECORD_SCHEMA = 3
INDEX_SCHEMA = 2
REPO = "kromych/badc"

# `demos/python/compare_compilers.py` builds CPython four times and prints one
# row per build. Of its columns only `bench (ms)` is a measurement this record
# can state exactly: the sizes are floor-divided by 1024 and the compile
# seconds carry one decimal, and a bench record holds neither a KiB count nor
# a compile time.
CPYTHON_HEAD = re.compile(r"^## CPython build comparison \((.+)\)$")
CPYTHON_COLS = ("| compiler | compile (s) | .text (KiB) | .data (KiB) "
                "| .bss (KiB) | file (KiB) | bench (ms) |")
CPYTHON_SUITE = "cpython"
# The comparison reports one number per build, so one record per compiler.
CPYTHON_BENCH = "microbench"
# The comparison names its legs by optimization level, the fixture table by
# the flags taken: `clang no-O` compiles with `-O0` and `clang -O` with
# `-O2 -DNDEBUG`, which is what that table's two clang rows are.
BENCH_COMPILERS = {
    "badc no-O": "badc",
    "badc -O": "badc -O",
    "clang no-O": "clang -O0",
    "clang -O": "clang -O2",
}
# The heading names the badc target the comparison built for; a record states
# the architecture it ran on, so the two have to agree before the numbers are
# filed under it.
TARGET_ARCH = {
    "linux-x64": "x86_64",
    "windows-x64": "x86_64",
    "linux-aarch64": "aarch64",
    "macos-aarch64": "aarch64",
    "windows-arm64": "aarch64",
}
# `platform.machine()` answers with the host's own spelling.
ARCH_ALIAS = {"arm64": "aarch64", "amd64": "x86_64", "x64": "x86_64",
              "AMD64": "x86_64"}


def run_path(sha: str, runner: str) -> str:
    return f"runs/{sha[0:2]}/{sha[2:4]}/{sha}/{runner}.json"


def git(repo: Path, *args: str, stdin: str = "") -> str:
    r = subprocess.run(["git", "-C", str(repo), *args], capture_output=True,
                       text=True, input=stdin)
    if r.returncode != 0:
        sys.exit(f"git {' '.join(args)}: {r.stderr.strip()}")
    return r.stdout.strip()


def make_symlink(link: Path, target: str) -> None:
    link.symlink_to(target)


def link_branch(repo: Path, branch: str, target: Path) -> str:
    """Point `branches/<branch>` at a run directory and return the path to
    stage, empty when this staged it already. A host that refuses to create a
    symlink -- Windows without the privilege it takes -- gets the same entry
    written through git, since the repository has to hold a symlink either
    way."""
    link = repo / "branches" / branch
    link.parent.mkdir(parents=True, exist_ok=True)
    rel = os.path.relpath(target, link.parent).replace(os.sep, "/")
    if link.is_symlink() or link.exists():
        link.unlink()
    try:
        make_symlink(link, rel)
        return f"branches/{branch}"
    except OSError as e:
        print(f"branches/{branch}: {e}; staging the link through git")
        blob = git(repo, "hash-object", "-w", "--stdin", stdin=rel)
        git(repo, "update-index", "--add", "--cacheinfo",
            f"120000,{blob},branches/{branch}")
        return ""


def load_index(repo: Path) -> list[dict]:
    path = repo / INDEX
    if not path.is_file():
        return []
    try:
        doc = json.loads(path.read_text())
    except json.JSONDecodeError as e:
        sys.exit(f"{path}: {e}")
    return doc.get("runs", [])


def parse_cpython(source) -> dict | None:
    """The CPython comparison as bench records, or None when the text holds no
    such table. `source` is the script's own output or the lines of a job log
    with their timestamps stripped."""
    lines = source.splitlines() if isinstance(source, str) else list(source)
    target = ""
    head = -1
    for n, line in enumerate(lines):
        m = CPYTHON_HEAD.match(line.strip())
        if m:
            target, head = m.group(1), n
            break
    if head < 0:
        return None
    benches: list[dict] = []
    unmeasured = 0
    seen_cols = False
    for line in lines[head + 1:]:
        body = line.strip()
        if not body:
            continue
        if not seen_cols:
            # Only the table follows the heading; anything else means this is
            # not the output this parser knows.
            if body != CPYTHON_COLS:
                return None
            seen_cols = True
            continue
        if not body.startswith("|"):
            break
        if body.startswith("|---") or body.startswith("| ---"):
            continue
        cells = [c.strip() for c in body.strip("|").split("|")]
        if len(cells) != 7:
            return None
        # A failed build prints FAIL for its compile time and leaves the
        # rest empty; a failed benchmark prints FAIL for itself alone.
        try:
            run_ms = float(cells[6])
        except ValueError:
            unmeasured += 1
            continue
        benches.append({
            "suite": CPYTHON_SUITE,
            "name": CPYTHON_BENCH,
            "compiler": BENCH_COMPILERS.get(cells[0], cells[0]),
            "run_ms": run_ms,
        })
    if not seen_cols:
        return None
    return {"target": target, "benches": benches, "unmeasured": unmeasured}


def benches_from(source, arch: str = "") -> tuple[list[dict], str]:
    """The bench records a comparison output carries, and a note naming what
    was left out. An empty note means everything the table stated was taken."""
    table = parse_cpython(source)
    if table is None:
        return [], "no CPython comparison table"
    want = TARGET_ARCH.get(table["target"], "")
    arch = ARCH_ALIAS.get(arch, arch)
    if arch and want and want != arch:
        return [], (f"CPython table built for {table['target']}, "
                    f"run measured on {arch}")
    note = ""
    if table["unmeasured"]:
        note = f"{table['unmeasured']} CPython row(s) without a benchmark"
    return table["benches"], note


def stamp(data: dict, sha: str, branch: str, runner: str, image: str = "",
          run_id: str = "") -> dict:
    """The record as it is filed: what the harness measured, plus what only
    the publisher knows -- the commit, the runner label and image, and, for a
    run this tool did not recover, that it was measured here. The schema is
    the producer's own where it states one."""
    machine = dict(data.get("machine") or {})
    machine["runner"] = runner
    if image:
        machine["image"] = image
    machine = {k: v for k, v in machine.items() if v not in ("", None)}
    provenance = dict(data.get("provenance") or {})
    if not provenance:
        provenance = {"source": "measured"}
        if run_id:
            provenance["run_id"] = run_id
            provenance["url"] = (f"https://github.com/{REPO}/actions/runs/"
                                 f"{run_id}")
    # An Actions id is a number in the API and text everywhere else.
    for key in ("run_id", "job_id"):
        if key in provenance:
            provenance[key] = str(provenance[key])
    doc = {
        "schema": int(data.get("schema") or RECORD_SCHEMA),
        "taken": data.get("taken", ""),
        "commit": {"sha": sha, "branch": branch},
        "machine": machine,
    }
    for key in ("runs_per_fixture", "compilers", "fixtures", "results",
                "benches"):
        if data.get(key) not in (None, [], ""):
            doc[key] = data[key]
    doc["provenance"] = provenance
    return doc


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--data", type=Path, help="a run.py --json file")
    ap.add_argument("--repo", type=Path, help="badc-perf-data checkout")
    ap.add_argument("--sha", help="the badc commit the run measured")
    ap.add_argument("--branch", help="the branch that commit is on")
    ap.add_argument("--runner", help="the runner label, or `local` off CI")
    ap.add_argument("--image", default="", help="the runner image, when known")
    ap.add_argument("--benches", type=Path, action="append", default=[],
                    metavar="PATH",
                    help="output of demos/python/compare_compilers.py")
    ap.add_argument("--run-id", help="the Actions run id, for the link back")
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args(argv)
    if args.self_test:
        return self_test()
    for need in ("data", "repo", "sha", "branch", "runner"):
        if getattr(args, need) is None:
            ap.error(f"--{need.replace('_', '-')} is required")

    if len(args.sha) != 40 or not all(c in "0123456789abcdef" for c in args.sha):
        sys.exit(f"--sha takes a full commit hash, not {args.sha!r}")
    data = json.loads(args.data.read_text())
    doc = stamp(data, args.sha, args.branch, args.runner, args.image,
                args.run_id or "")

    for path in args.benches:
        if not path.is_file():
            print(f"no bench output at {path}")
            continue
        benches, note = benches_from(path.read_text(),
                                     doc["machine"].get("arch", ""))
        if note:
            print(f"{path}: {note}")
        if benches:
            doc.setdefault("benches", []).extend(benches)

    rel = run_path(args.sha, args.runner)
    dst = args.repo / rel
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(json.dumps(doc, indent=1) + "\n")

    # The branch points at the run directory rather than one runner's file, so
    # a reader finds every runner of that run through one link.
    staged = link_branch(args.repo, args.branch, dst.parent)

    runs = [r for r in load_index(args.repo)
            if not (r.get("sha") == args.sha and r.get("runner") == args.runner)]
    runs.append({
        "sha": args.sha,
        "branch": args.branch,
        "runner": args.runner,
        "taken": doc["taken"],
        "machine": doc["machine"],
        "path": rel,
        "run_id": args.run_id or doc["provenance"].get("run_id", ""),
        "source": doc["provenance"]["source"],
    })
    # Newest first by when a run was taken, not by when it was filed: the
    # two lanes of one CI run finish in either order.
    runs.sort(key=lambda r: (r.get("taken", ""), r.get("sha", ""),
                             r.get("runner", "")), reverse=True)
    (args.repo / INDEX).write_text(
        json.dumps({"schema": INDEX_SCHEMA, "runs": runs}, indent=1) + "\n")

    git(args.repo, "add", "-A", rel, INDEX, *([staged] if staged else []))
    if not git(args.repo, "status", "--porcelain"):
        print("nothing to commit")
        return 0
    # A record the harness wrote carries no provenance of its own; one
    # recovered from elsewhere names its source, and the subject says so.
    subject = f"{args.sha[:12]} {args.runner}: perf run from {doc['taken']}"
    if doc["provenance"]["source"] != "measured":
        subject += " (recovered)"
    git(args.repo, "-c", "user.name=badc perf", "-c", "user.email=perf@badc.dev",
        "commit", "-q", "-m", subject)
    print(f"committed {rel} ({len(runs)} runs in the index)")
    return 0


SAMPLE = Path(__file__).resolve().parent.parent / "tests" / "perf" / \
    "cpython_cmp_sample.md"


def self_test() -> int:
    """The bench parser over a captured `compare_compilers.py` output, and the
    envelope over a run filed into a scratch repository."""
    table = parse_cpython(SAMPLE.read_text())
    assert table is not None, "the sample holds a CPython table"
    assert table["target"] == "linux-x64", table["target"]
    assert table["unmeasured"] == 1, table["unmeasured"]
    # The sample is the table of job 89761388392, whose `badc -O` build linked
    # but whose benchmark did not run: three rows state a time, one does not.
    assert table["benches"] == [
        {"suite": "cpython", "name": "microbench", "compiler": "badc",
         "run_ms": 2241.993},
        {"suite": "cpython", "name": "microbench", "compiler": "clang -O0",
         "run_ms": 1451.948},
        {"suite": "cpython", "name": "microbench", "compiler": "clang -O2",
         "run_ms": 56.176},
    ], table["benches"]
    # The sizes and the compile seconds the same rows carry are KiB-rounded
    # and one-decimal; no bench record states them.
    assert all(set(b) == {"suite", "name", "compiler", "run_ms"}
               for b in table["benches"])

    benches, note = benches_from(SAMPLE.read_text(), "x86_64")
    assert len(benches) == 3 and "without a benchmark" in note, note
    benches, note = benches_from(SAMPLE.read_text(), "aarch64")
    assert benches == [] and "linux-x64" in note, note
    assert benches_from("nothing here")[0] == []
    # A table whose columns are not the ones this parser knows is not read as
    # if it were.
    assert parse_cpython("## CPython build comparison (linux-x64)\n"
                         "| compiler | bench (ms) |\n") is None

    measured = {
        "schema": 3,
        "taken": "2026-09-19T23:57:48Z",
        "machine": {"system": "Linux", "arch": "x86_64", "cpu": "",
                    "runner": "local"},
        "runs_per_fixture": 3,
        "compilers": [
            {"name": "badc -O", "flags": ["-O"]},
            {"name": "gcc -O2", "version": "gcc (Ubuntu 13.3.0) 13.3.0",
             "flags": ["-O2", "-DNDEBUG"]},
            {"name": "gcc -O2 -march=x86-64-v3",
             "version": "gcc (Ubuntu 13.3.0) 13.3.0",
             "flags": ["-O2", "-DNDEBUG", "-march=x86-64-v3"],
             "level": "x86-64-v3"},
        ],
        "fixtures": ["fib.c"],
        "results": [{"fixture": "fib.c", "compiler": "badc -O",
                     "run_ms": 103.0, "compile_ms": 32.2,
                     "binary_bytes": 18224}],
    }
    doc = stamp(measured, "a" * 40, "master", "ubuntu-latest",
                "ubuntu-24.04", "42")
    assert doc["schema"] == 3
    # Two legs of one compiler are two entries; the envelope carries the
    # compiler list through whatever it holds.
    assert doc["compilers"] == measured["compilers"], doc["compilers"]
    assert doc["commit"] == {"sha": "a" * 40, "branch": "master"}
    assert doc["machine"] == {"system": "Linux", "arch": "x86_64",
                              "runner": "ubuntu-latest",
                              "image": "ubuntu-24.04"}, doc["machine"]
    assert doc["provenance"] == {
        "source": "measured", "run_id": "42",
        "url": f"https://github.com/{REPO}/actions/runs/42"}, doc["provenance"]
    assert "benches" not in doc
    # A recovered record keeps the provenance its recoverer wrote, with the
    # Actions ids spelled as the schema spells them.
    kept = stamp({"taken": "t", "machine": {"arch": "aarch64"},
                  "provenance": {"source": "github-actions-job-log",
                                 "run_id": 12, "job_id": 34}},
                 "b" * 40, "master", "ubuntu-24.04-arm")
    assert kept["provenance"]["source"] == "github-actions-job-log"
    assert kept["provenance"]["run_id"] == "12", kept["provenance"]
    assert kept["provenance"]["job_id"] == "34", kept["provenance"]
    assert "image" not in kept["machine"]
    # A producer that states no schema is filed as the current one; one that
    # states 2 -- a run recovered from a log, whose compilers are names alone
    # -- keeps saying 2.
    assert kept["schema"] == RECORD_SCHEMA, kept["schema"]
    assert stamp({"schema": 2, "taken": "t", "machine": {},
                  "compilers": [{"name": "clang -O2"}]},
                 "b" * 40, "master", "r")["schema"] == 2

    with tempfile.TemporaryDirectory() as tmp:
        repo = Path(tmp) / "data"
        repo.mkdir()
        git(repo, "init", "-q", "-b", "main")
        data = Path(tmp) / "perf.json"
        data.write_text(json.dumps(measured))
        arm_data = Path(tmp) / "perf-arm.json"
        arm_data.write_text(json.dumps(
            {**measured, "machine": {**measured["machine"],
                                     "arch": "aarch64"}}))
        for runner, src in (("ubuntu-latest", data),
                            ("ubuntu-24.04-arm", arm_data)):
            rc = main(["--data", str(src), "--repo", str(repo),
                       "--sha", "c" * 40, "--branch", "topic",
                       "--runner", runner, "--image", "ubuntu-24.04",
                       "--benches", str(SAMPLE), "--run-id", "7"])
            assert rc == 0, rc
        filed = json.loads(
            (repo / run_path("c" * 40, "ubuntu-latest")).read_text())
        assert filed["schema"] == 3 and filed["commit"]["branch"] == "topic"
        assert filed["benches"][0]["suite"] == "cpython", filed["benches"]
        assert [c["name"] for c in filed["compilers"]] == [
            "badc -O", "gcc -O2", "gcc -O2 -march=x86-64-v3"], \
            filed["compilers"]
        # The arm run measured on aarch64 takes no x86-64 CPython table.
        arm = json.loads(
            (repo / run_path("c" * 40, "ubuntu-24.04-arm")).read_text())
        assert "benches" not in arm, arm.get("benches")
        index = json.loads((repo / INDEX).read_text())
        assert index["schema"] == 2 and len(index["runs"]) == 2
        assert index["runs"][0]["machine"]["image"] == "ubuntu-24.04"
        assert index["runs"][0]["source"] == "measured"
        link = repo / "branches" / "topic"
        assert link.is_symlink() and link.resolve().name == "c" * 40
        # A run taken earlier lands behind them however late it is filed.
        older = Path(tmp) / "older.json"
        older.write_text(json.dumps({**measured,
                                     "taken": "2026-09-01T00:00:00Z"}))
        main(["--data", str(older), "--repo", str(repo), "--sha", "d" * 40,
              "--branch", "topic", "--runner", "ubuntu-latest"])
        index = json.loads((repo / INDEX).read_text())
        taken = [r["taken"] for r in index["runs"]]
        assert taken == sorted(taken, reverse=True), taken
        # Refiling the same run replaces its entry instead of adding one.
        main(["--data", str(data), "--repo", str(repo), "--sha", "c" * 40,
              "--branch", "topic", "--runner", "ubuntu-latest"])
        index = json.loads((repo / INDEX).read_text())
        assert len(index["runs"]) == 3, index["runs"]
        assert len(git(repo, "log", "--oneline").splitlines()) == 4

        # A host that will not create a symlink -- Windows without the
        # privilege it takes -- files the same entry through git, so the
        # repository holds a symlink wherever the run was published from.
        def refuse(link: Path, target: str) -> None:
            raise OSError("operation not permitted")

        global make_symlink
        real, make_symlink = make_symlink, refuse
        try:
            rc = main(["--data", str(data), "--repo", str(repo),
                       "--sha", "e" * 40, "--branch", "topic",
                       "--runner", "ubuntu-latest"])
        finally:
            make_symlink = real
        assert rc == 0, rc
        entry = git(repo, "ls-files", "-s", "branches/topic").split()
        assert entry[0] == "120000", entry
        assert git(repo, "cat-file", "-p", entry[1]) == \
            f"../runs/ee/ee/{'e' * 40}", entry
        assert not (repo / "branches" / "topic").exists()
    print("[perf_publish] self-test OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
