#!/usr/bin/env python3
"""Publish one perf run into the data repository the performance page reads.

`tests/perf/run.py --json` writes what a run measured; this places that file
in a checkout of `badc-perf-data` under the commit it measured, updates the
index the page charts, and points the run's branch at it.

    perf_publish.py --data perf.json --repo ../badc-perf-data \\
        --sha <badc commit> --branch master --runner linux-x64 [--run-id N]

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
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
from pathlib import Path

INDEX = "index.json"


def run_path(sha: str, runner: str) -> str:
    return f"runs/{sha[0:2]}/{sha[2:4]}/{sha}/{runner}.json"


def git(repo: Path, *args: str) -> str:
    r = subprocess.run(["git", "-C", str(repo), *args], capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit(f"git {' '.join(args)}: {r.stderr.strip()}")
    return r.stdout.strip()


def load_index(repo: Path) -> list[dict]:
    path = repo / INDEX
    if not path.is_file():
        return []
    try:
        doc = json.loads(path.read_text())
    except json.JSONDecodeError as e:
        sys.exit(f"{path}: {e}")
    return doc.get("runs", [])


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--data", type=Path, required=True, help="a run.py --json file")
    ap.add_argument("--repo", type=Path, required=True, help="badc-perf-data checkout")
    ap.add_argument("--sha", required=True, help="the badc commit the run measured")
    ap.add_argument("--branch", required=True, help="the branch that commit is on")
    ap.add_argument("--runner", required=True, help="os-arch of the machine that ran it")
    ap.add_argument("--run-id", help="the Actions run id, for the link back")
    args = ap.parse_args(argv)

    if len(args.sha) != 40 or not all(c in "0123456789abcdef" for c in args.sha):
        sys.exit(f"--sha takes a full commit hash, not {args.sha!r}")
    data = json.loads(args.data.read_text())

    rel = run_path(args.sha, args.runner)
    dst = args.repo / rel
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(json.dumps(data, indent=1) + "\n")

    # The branch points at the run directory rather than one runner's file, so
    # a reader finds every runner of that run through one link.
    link = args.repo / "branches" / args.branch
    link.parent.mkdir(parents=True, exist_ok=True)
    if link.is_symlink() or link.exists():
        link.unlink()
    link.symlink_to(os.path.relpath(dst.parent, link.parent))

    runs = [r for r in load_index(args.repo)
            if not (r.get("sha") == args.sha and r.get("runner") == args.runner)]
    runs.insert(0, {
        "sha": args.sha,
        "branch": args.branch,
        "runner": args.runner,
        "taken": data.get("taken", ""),
        "machine": data.get("machine", {}).get("cpu", ""),
        "path": rel,
        "run_id": args.run_id or "",
    })
    (args.repo / INDEX).write_text(
        json.dumps({"runs": runs}, indent=1) + "\n")

    git(args.repo, "add", "-A", rel, INDEX, f"branches/{args.branch}")
    if not git(args.repo, "status", "--porcelain"):
        print("nothing to commit")
        return 0
    git(args.repo, "-c", "user.name=badc perf", "-c", "user.email=perf@badc.dev",
        "commit", "-q", "-m",
        f"{args.sha[:12]} {args.runner}: perf run from {data.get('taken', '')}")
    print(f"committed {rel} ({len(runs)} runs in the index)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
