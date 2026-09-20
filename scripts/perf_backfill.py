#!/usr/bin/env python3
"""Recover the perf runs CI already measured into the data repository.

`tests/perf/run.py` prints its table into the log of CI's
`perf comparison (<runner>)` job and nowhere else, so every run that predates
`perf_publish.py` exists only there, for as long as Actions keeps the log.
This walks the CI runs in that window, parses the table out of each perf job's
log and files one record per (commit, runner) through `perf_publish.py`.

    perf_backfill.py --repo ../badc-perf-data --cache ~/.cache/badc-perf

A recovered record is the shape `run.py --json` writes minus what the log does
not carry: no `compile_ms` (the harness began timing compiles on 2026-09-19),
no CPU model, and no compiler versions. The page skips a metric a run does not
have. Each record carries `provenance` naming the job log it came from, so a
reader tells a recovered run from a measured one.

The same log carries the CPython build comparison, whose benchmark column
becomes the record's `benches`; its sizes and compile seconds are rounded in
print and no record states them.

The walk is resumable: listings and logs land under `--cache`, and a commit
already filed in the data repository is skipped unless `--force` says
otherwise.
"""

from __future__ import annotations

import argparse
import gzip
import hashlib
import json
import re
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(Path(__file__).resolve().parent))
import perf_publish  # noqa: E402

REPO = "kromych/badc"
WORKFLOW = "ci.yml"
# The matrix labels of the perf job. A label fixes the machine class GitHub
# allocates, hence the architecture; the log names neither.
RUNNERS = {"ubuntu-latest": "x86_64", "ubuntu-24.04-arm": "aarch64"}
JOB_NAME = "perf comparison ({runner})"
# Actions keeps a job log this long; older jobs answer 410.
RETENTION_DAYS = 90

# The log is UTF-8 with a byte-order mark on its first line.
TIMESTAMPED = re.compile(r"^\uFEFF?(\d{4}-\d\d-\d\dT[\d:.]+Z) ?(.*)$")
ANSI = re.compile(r"\x1b\[[0-9;]*m")
TABLE_START = "## perf comparison"
TABLE_HEAD = "| compiler | median (ms) | binary (bytes) | vs badc -O |"
ROW = re.compile(r"^\|\s*(.+?)\s*\|\s*([\d.]+)\s*\|\s*([\d,]+)\s*\|")
IMAGE = re.compile(r"^Image: (\S+)$")
RUNS_PER_FIXTURE = re.compile(r"^RUNS_PER_FIXTURE\s*=\s*(\d+)$", re.M)


@dataclass
class Job:
    sha: str
    branch: str
    runner: str
    run_id: int
    job_id: int
    conclusion: str
    started_at: str


class Fetcher:
    """`gh` with a cache on disk and a count of what the walk cost."""

    def __init__(self, cache: Path) -> None:
        self.cache = cache
        self.calls = 0
        self.bytes = 0

    def _gh(self, args: list[str]) -> bytes:
        r = subprocess.run(["gh", *args], capture_output=True)
        self.calls += 1
        self.bytes += len(r.stdout)
        if r.returncode != 0:
            raise RuntimeError(r.stderr.decode(errors="replace").strip())
        return r.stdout

    def api(self, path: str, rel: str) -> dict:
        dst = self.cache / rel
        if not dst.is_file():
            dst.parent.mkdir(parents=True, exist_ok=True)
            dst.write_bytes(self._gh(["api", path]))
        return json.loads(dst.read_text())

    def graphql(self, query: str, rel: str) -> dict:
        dst = self.cache / rel
        if not dst.is_file():
            dst.parent.mkdir(parents=True, exist_ok=True)
            dst.write_bytes(self._gh(
                ["api", "graphql", "-F", f"owner={REPO.split('/')[0]}",
                 "-F", f"name={REPO.split('/')[1]}", "-F", f"query={query}"]))
        return json.loads(dst.read_text())

    def job_log(self, job_id: int) -> str | None:
        """The job's log, or None once Actions has dropped it."""
        dst = self.cache / "logs" / f"{job_id}.log.gz"
        gone = self.cache / "logs" / f"{job_id}.gone"
        if gone.is_file():
            return None
        if not dst.is_file():
            dst.parent.mkdir(parents=True, exist_ok=True)
            try:
                body = self._gh(["api", "--allow-escape-sequences",
                                 f"repos/{REPO}/actions/jobs/{job_id}/logs"])
            except RuntimeError as e:
                if "HTTP 410" in str(e) or "HTTP 404" in str(e):
                    gone.write_text(str(e) + "\n")
                    return None
                raise
            dst.write_bytes(gzip.compress(body))
        return gzip.decompress(dst.read_bytes()).decode("utf-8", "replace")


def list_runs(f: Fetcher, since: str) -> list[dict]:
    """Every CI run created since `since`, oldest first."""
    runs: dict[int, dict] = {}
    for page in range(1, 100):
        doc = f.api(
            f"repos/{REPO}/actions/workflows/{WORKFLOW}/runs"
            f"?per_page=100&exclude_pull_requests=true"
            f"&created=%3E%3D{since}&page={page}",
            f"runs/{since}-page-{page}.json")
        got = doc.get("workflow_runs", [])
        for r in got:
            runs.setdefault(r["id"], r)
        if len(got) < 100:
            break
    return sorted(runs.values(), key=lambda r: r["created_at"])


def perf_jobs(f: Fetcher, commits: list[str], batch: int = 50) -> list[dict]:
    """The perf jobs of each commit, over every check suite it carries.

    One REST call per commit and runner would be two thousand calls; the
    check runs of fifty commits fit in one GraphQL query.
    """
    out: list[dict] = []
    for i in range(0, len(commits), batch):
        chunk = commits[i:i + batch]
        sel = "\n".join(f' c{n}: object(oid:"{sha}"){{ ...F }}'
                        for n, sha in enumerate(chunk))
        runners = "\n".join(
            f'   r{n}: checkRuns(first:5, filterBy:{{checkName:'
            f'"{JOB_NAME.format(runner=label)}"}})'
            f'{{nodes{{databaseId conclusion startedAt}}}}'
            for n, label in enumerate(RUNNERS))
        query = (f"query($owner:String!,$name:String!){{\n"
                 f" repository(owner:$owner,name:$name){{\n{sel}\n }}\n}}\n"
                 f"fragment F on Commit {{\n oid\n"
                 f" checkSuites(first:60){{nodes{{\n"
                 f"   workflowRun{{databaseId}}\n{runners}\n }}}}\n}}\n")
        key = hashlib.sha1(query.encode()).hexdigest()[:8]
        doc = f.graphql(query, f"jobs/{chunk[0]}-{len(chunk)}-{key}.json")
        if "errors" in doc:
            raise RuntimeError(json.dumps(doc["errors"])[:400])
        for node in (doc["data"]["repository"] or {}).values():
            if not node:
                continue
            for suite in node["checkSuites"]["nodes"]:
                run = suite.get("workflowRun")
                for n, label in enumerate(RUNNERS):
                    for cr in suite[f"r{n}"]["nodes"]:
                        out.append({
                            "sha": node["oid"],
                            "runner": label,
                            "run_id": run["databaseId"] if run else 0,
                            "job_id": cr["databaseId"],
                            "conclusion": (cr["conclusion"] or "").lower(),
                            "started_at": cr["startedAt"] or "",
                        })
    return out


def pick(jobs: list[dict]) -> list[dict]:
    """One job per (commit, runner): the last one that ran, preferring a
    success, since a rerun measured the same commit on the same machine class
    and the later table is the one CI would have published."""
    best: dict[tuple[str, str], dict] = {}
    for j in jobs:
        if j["conclusion"] not in ("success", "failure"):
            continue
        key = (j["sha"], j["runner"])
        cur = best.get(key)
        rank = (j["conclusion"] == "success", j["started_at"])
        if cur is None or rank > (cur["conclusion"] == "success",
                                  cur["started_at"]):
            best[key] = j
    return list(best.values())


def log_lines(text: str) -> list[tuple[str, str]]:
    """The log as (timestamp, body) pairs, with the runner's colouring
    removed and lines the runner did not stamp dropped."""
    out: list[tuple[str, str]] = []
    for raw in text.splitlines():
        m = TIMESTAMPED.match(raw)
        if m:
            out.append((m.group(1), ANSI.sub("", m.group(2)).strip()))
    return out


def parse_log(text: str) -> dict | None:
    """The job's tables as data: `taken`, `image`, `fixtures`, `results` from
    the perf table, and `benches` from the CPython comparison that follows it.

    The perf table is the only one that is per fixture and per compiler; the
    QuickJS comparison in the same log reports nanoseconds per operation and a
    KiB-rounded size, neither of which a record states, so it stays out.
    """
    lines = log_lines(text)
    taken = image = ""
    fixture = ""
    in_table = False
    rows: list[dict] = []
    fixtures: list[str] = []
    for stamp, body in lines:
        if not image:
            m = IMAGE.match(body)
            if m:
                image = m.group(1)
        if body == TABLE_START:
            taken, in_table, fixture, rows, fixtures = stamp, True, "", [], []
            continue
        if not in_table:
            continue
        if body.startswith("##[") or body.startswith("## "):
            in_table = False
            continue
        if body.startswith("### "):
            fixture = body[4:].strip()
            fixtures.append(fixture)
            continue
        if body.startswith("| compiler |"):
            if body != TABLE_HEAD:
                return None
            continue
        m = ROW.match(body)
        if m and fixture:
            rows.append({
                "fixture": fixture,
                "compiler": m.group(1),
                "run_ms": float(m.group(2)),
                "binary_bytes": int(m.group(3).replace(",", "")),
            })
    if not rows:
        return None
    cpython = perf_publish.parse_cpython(body for _, body in lines)
    return {
        "taken": taken[:19] + "Z",
        "image": image,
        "fixtures": [f for f in fixtures if any(r["fixture"] == f
                                                for r in rows)],
        "results": rows,
        "cpython": cpython,
    }


def runs_per_fixture(sha: str) -> int | None:
    """The repetition count the harness used at that commit, read from the
    commit itself rather than assumed from the tip."""
    r = subprocess.run(["git", "-C", str(ROOT), "show",
                        f"{sha}:tests/perf/run.py"],
                       capture_output=True, text=True)
    if r.returncode != 0:
        return None
    m = RUNS_PER_FIXTURE.search(r.stdout)
    return int(m.group(1)) if m else None


def record(job: Job, table: dict, reps: int | None) -> dict:
    """The run as `run.py --json` writes it, without the fields the log does
    not carry. `perf_publish.stamp` adds the schema-2 envelope from here."""
    order = []
    for r in table["results"]:
        if r["compiler"] not in order:
            order.append(r["compiler"])
    arch = RUNNERS[job.runner]
    doc: dict = {
        "taken": table["taken"],
        "machine": {"system": "Linux", "arch": arch, "runner": job.runner},
        "compilers": [{"name": c} for c in order],
        "fixtures": table["fixtures"],
        "results": table["results"],
        "provenance": {
            "source": "github-actions-job-log",
            "run_id": job.run_id,
            "job_id": job.job_id,
            "url": (f"https://github.com/{REPO}/actions/runs/"
                    f"{job.run_id}/job/{job.job_id}"),
        },
    }
    if table["image"]:
        doc["machine"]["image"] = table["image"]
    if reps is not None:
        doc["runs_per_fixture"] = reps
    cpython = table.get("cpython")
    if cpython and cpython["benches"] and \
            perf_publish.TARGET_ARCH.get(cpython["target"]) == arch:
        doc["benches"] = cpython["benches"]
    return doc


SAMPLE = ROOT / "tests" / "perf" / "ci_log_sample.txt"


def self_test() -> int:
    """Parse the captured excerpt: the perf table and the CPython comparison
    are taken, the QuickJS tables between them are not."""
    table = parse_log(SAMPLE.read_text())
    assert table is not None, "the excerpt holds a perf table"
    assert table["taken"] == "2026-09-19T23:57:48Z", table["taken"]
    assert table["image"] == "ubuntu-24.04", table["image"]
    assert table["fixtures"] == ["fib.c", "qsort.c"], table["fixtures"]
    assert len(table["results"]) == 10, len(table["results"])
    first = table["results"][0]
    assert first == {"fixture": "fib.c", "compiler": "badc",
                     "run_ms": 265.9, "binary_bytes": 18264}, first
    assert all("compile_ms" not in r for r in table["results"])
    compilers = {r["compiler"] for r in table["results"]}
    assert compilers == {"badc", "badc -O", "tcc", "clang -O0", "clang -O2"}, \
        compilers
    # The CPython and QuickJS tables in the same log name their compilers
    # differently and measure something else; nothing of theirs is a result.
    assert not any(r["compiler"].endswith("no-O") for r in table["results"])
    assert not any(r["fixture"].endswith(".js") for r in table["results"])

    # The CPython comparison of the same log, with its labels mapped onto the
    # perf table's and its KiB columns left behind.
    cp = table["cpython"]
    assert cp["target"] == "linux-x64" and cp["unmeasured"] == 0, cp
    assert cp["benches"] == [
        {"suite": "cpython", "name": "microbench", "compiler": "badc",
         "run_ms": 1197.808},
        {"suite": "cpython", "name": "microbench", "compiler": "badc -O",
         "run_ms": 70.821},
        {"suite": "cpython", "name": "microbench", "compiler": "clang -O0",
         "run_ms": 1036.238},
        {"suite": "cpython", "name": "microbench", "compiler": "clang -O2",
         "run_ms": 42.999},
    ], cp["benches"]
    # The QuickJS microbench in the same log counts nanoseconds per
    # operation, which is not a run time; none of it is filed.
    assert "empty_loop" not in json.dumps(table)

    arm = Job("0" * 40, "master", "ubuntu-24.04-arm", 1, 2, "success", "")
    doc = record(arm, table, 3)
    assert doc["machine"]["arch"] == "aarch64", doc["machine"]
    assert doc["provenance"]["job_id"] == 2, doc["provenance"]
    assert set(doc["provenance"]) == {"source", "run_id", "job_id", "url"}
    assert doc["runs_per_fixture"] == 3
    assert doc["compilers"][0] == {"name": "badc"}
    assert "compile_ms" not in json.dumps(doc)
    # The excerpt's CPython table was built for linux-x64; it is not the arm
    # job's measurement.
    assert "benches" not in doc, doc["benches"]
    x64 = Job("0" * 40, "master", "ubuntu-latest", 1, 2, "success", "")
    doc = record(x64, table, 3)
    assert doc["benches"] == cp["benches"], doc.get("benches")
    # No bench record states a size: the comparison prints KiB.
    assert all(set(b) == {"suite", "name", "compiler", "run_ms"}
               for b in doc["benches"])

    filed = perf_publish.stamp(doc, "1" * 40, "master", x64.runner)
    assert filed["schema"] == 2, filed["schema"]
    assert filed["commit"] == {"sha": "1" * 40, "branch": "master"}
    assert filed["provenance"]["source"] == "github-actions-job-log"
    assert filed["machine"]["image"] == "ubuntu-24.04"
    assert "cpu" not in filed["machine"], filed["machine"]

    truncated = SAMPLE.read_text().split("### qsort.c")[0]
    part = parse_log(truncated)
    assert part is not None and part["fixtures"] == ["fib.c"], part
    assert part["cpython"] is None, part["cpython"]
    assert parse_log("2026-01-01T00:00:00.0Z nothing here") is None

    # The runner colours what it echoes; a heading or a row can carry it.
    ansi = parse_log("\ufeff2026-01-01T00:00:00.0Z ## perf comparison\n"
                     "2026-01-01T00:00:01.0Z \x1b[36;1m### a.c\x1b[0m\n"
                     f"2026-01-01T00:00:02.0Z {TABLE_HEAD}\n"
                     "2026-01-01T00:00:03.0Z | badc | 1.5 | 1,024 | 1.00x |\n")
    assert ansi is not None and ansi["results"] == [
        {"fixture": "a.c", "compiler": "badc", "run_ms": 1.5,
         "binary_bytes": 1024}], ansi
    print("[perf_backfill] self-test OK")
    return 0


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--repo", type=Path, help="badc-perf-data checkout")
    ap.add_argument("--cache", type=Path, help="where listings and logs land")
    ap.add_argument("--since", help="YYYY-MM-DD; default the log retention")
    ap.add_argument("--limit", type=int, help="stop after this many records")
    ap.add_argument("--force", action="store_true",
                    help="refile commits the data repository already holds")
    ap.add_argument("--dry-run", action="store_true",
                    help="parse and report; write nothing")
    ap.add_argument("--fetch-jobs", type=int, default=6,
                    help="log downloads in flight")
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args(argv)
    if args.self_test:
        return self_test()
    if not args.repo or not args.cache:
        ap.error("--repo and --cache are required")

    since = args.since or time.strftime(
        "%Y-%m-%d", time.gmtime(time.time() - RETENTION_DAYS * 86400))
    f = Fetcher(args.cache)
    runs = list_runs(f, since)
    branch: dict[int, str] = {r["id"]: r["head_branch"] for r in runs}
    # A commit CI saw more than once (a pull request and the push that
    # followed) is one commit still; the jobs of all its suites are ranked
    # together below.
    commits = sorted({r["head_sha"] for r in runs})
    found = perf_jobs(f, commits)
    chosen = sorted(pick(found), key=lambda j: j["started_at"])
    print(f"{len(runs)} runs, {len(commits)} commits, {len(found)} perf jobs, "
          f"{len(chosen)} after picking one per commit and runner")

    todo: list[Job] = []
    for j in chosen:
        job = Job(sha=j["sha"], branch=branch.get(j["run_id"], ""),
                  runner=j["runner"], run_id=j["run_id"], job_id=j["job_id"],
                  conclusion=j["conclusion"], started_at=j["started_at"])
        if not job.branch:
            continue
        filed = args.repo / perf_publish.run_path(job.sha, job.runner)
        if filed.is_file() and not args.force:
            continue
        todo.append(job)
        if args.limit and len(todo) >= args.limit:
            break

    with ThreadPoolExecutor(max_workers=args.fetch_jobs) as pool:
        logs = list(pool.map(lambda j: f.job_log(j.job_id), todo))

    reps: dict[str, int | None] = {}
    counts = {"filed": 0, "expired": 0, "no table": 0, "no cpython table": 0,
              "cpython rows dropped": 0, "cpython arch mismatch": 0,
              "bench records": 0}
    mute: list[int] = []
    for job, text in zip(todo, logs):
        if text is None:
            counts["expired"] += 1
            continue
        table = parse_log(text)
        if table is None:
            counts["no table"] += 1
            mute.append(job.job_id)
            continue
        if job.sha not in reps:
            reps[job.sha] = runs_per_fixture(job.sha)
        doc = record(job, table, reps[job.sha])
        cpython = table.get("cpython")
        if cpython is None:
            counts["no cpython table"] += 1
        else:
            counts["cpython rows dropped"] += cpython["unmeasured"]
            if cpython["benches"] and "benches" not in doc:
                counts["cpython arch mismatch"] += 1
        counts["bench records"] += len(doc.get("benches", []))
        counts["filed"] += 1
        if args.dry_run:
            continue
        tmp = args.cache / "record.json"
        tmp.write_text(json.dumps(doc, indent=1) + "\n")
        rc = perf_publish.main(
            ["--data", str(tmp), "--repo", str(args.repo), "--sha", job.sha,
             "--branch", job.branch, "--runner", job.runner,
             "--run-id", str(job.run_id)])
        if rc:
            return rc

    print(f"{counts['filed']} filed, {counts['expired']} logs past retention, "
          f"{counts['no table']} without a table; "
          f"{counts['bench records']} bench records from "
          f"{counts['filed'] - counts['no cpython table']} CPython tables "
          f"({counts['cpython rows dropped']} rows without a benchmark, "
          f"{counts['cpython arch mismatch']} for another architecture); "
          f"{f.calls} API calls, {f.bytes / 1e6:.1f} MB")
    if mute:
        print("no table in jobs: " + " ".join(str(j) for j in mute[:20]))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
