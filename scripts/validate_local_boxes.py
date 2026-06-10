#!/usr/bin/env python3
"""Run the pre-push validation suite on a caller-specified set of
remote boxes in parallel and bail on the first lane that goes red.
The point is to catch lane-specific regressions before paying the
GitHub Actions runtime cost: each remote box runs the same
release-mode lib test + four gating demos that CI exercises, so a
green run here is a solid proxy for a green run in the cloud.

Each lane:
  1. Rsync (Linux) or tar+scp (Windows) the working tree, excluding
     `target/` and the vendored demo caches so the remote side
     builds + fetches its own caches.
  2. Build release with `cargo build --release --locked`.
  3. Run `cargo test --release --lib`.
  4. Run the demos sqlite3 / lua / miniz / monocypher / stb / tweetnacl.

Usage (one `--box` flag per remote lane):

    python3 scripts/validate_local_boxes.py \\
        --box xps=xps-8930.local:~/src/compilers/badc/:linux \\
        --box krom2=krom2.local:~/src/compilers/badc/:linux \\
        --box win=kromyrzen.local:R:/src/compilers/badc/:windows

The `name` segment is the prefix that gets printed on every output
line so parallel lane output stays attributable. `kind` is
`linux` or `windows`; the sync + test commands switch accordingly.

A non-zero exit means at least one lane failed.
"""

from __future__ import annotations

import argparse
import os
import shlex
import subprocess
import sys
import threading
from dataclasses import dataclass
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

GATING_DEMOS = (
    "demos/sqlite3/smoke.py",
    "demos/lua/smoke.py",
    "demos/miniz/smoke.py",
    "demos/monocypher/smoke.py",
    "demos/stb/smoke.py",
    "demos/tweetnacl/smoke.py",
)


@dataclass
class Box:
    name: str
    host: str
    remote_path: str
    kind: str  # "linux" | "windows"

    @property
    def short(self) -> str:
        return self.name


def parse_box(spec: str) -> Box:
    """Parse a `--box name=host:path:kind` spec. The `path` may
    contain colons (e.g. Windows `R:/src/compilers/badc/`); split
    on `:` from the left for `name` and `host`, then from the
    right for `kind`."""
    if "=" not in spec:
        raise argparse.ArgumentTypeError(
            f"`--box` expects `name=host:path:kind`, got {spec!r}"
        )
    name, rest = spec.split("=", 1)
    if ":" not in rest:
        raise argparse.ArgumentTypeError(
            f"`--box {name}=...` body must be `host:path:kind`, got {rest!r}"
        )
    host, rest = rest.split(":", 1)
    if ":" not in rest:
        raise argparse.ArgumentTypeError(
            f"`--box {name}=...` body needs a `:kind` suffix, got {rest!r}"
        )
    path, kind = rest.rsplit(":", 1)
    kind = kind.strip().lower()
    if kind not in ("linux", "windows"):
        raise argparse.ArgumentTypeError(
            f"`--box {name}=...` kind must be `linux` or `windows`, got {kind!r}"
        )
    return Box(name=name, host=host, remote_path=path, kind=kind)


def stream(prefix: str, cmd: list[str]) -> int:
    """Run `cmd`, prefixing every output line with `prefix` so
    parallel lane outputs stay attributable."""
    proc = subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
    )
    assert proc.stdout is not None
    for line in proc.stdout:
        sys.stdout.write(f"[{prefix}] {line}")
        sys.stdout.flush()
    return proc.wait()


def sync_linux(box: Box, github_token: str) -> int:
    cmd = [
        "rsync",
        "-az",
        "--delete-excluded",
        "--exclude=target",
        "--exclude=demos/*/.cache",
        "--exclude=demos/*/.work",
        "--exclude=.git",
        "-e",
        "ssh",
        f"{REPO_ROOT}/",
        f"{box.host}:{box.remote_path}",
    ]
    return stream(box.short, cmd)


def remote_run_linux(box: Box, github_token: str) -> int:
    inner = (
        f"cd {box.remote_path} && "
        f"export GITHUB_TOKEN={shlex.quote(github_token)} && "
        f"cargo build --release --locked --features full 2>&1 | tail -3 && "
        f"cargo test --release --lib --features full 2>&1 | tail -3 && "
        + " && ".join(f"python3 {d} 2>&1 | tail -2" for d in GATING_DEMOS)
    )
    return stream(box.short, ["ssh", box.host, inner])


def sync_windows(box: Box, github_token: str) -> int:
    archive = Path("/tmp/badc-tree.tar.gz")
    tar = subprocess.run(
        [
            "tar",
            "czf",
            str(archive),
            "-C",
            str(REPO_ROOT),
            "--exclude=target",
            "--exclude=.git",
            "--exclude=demos/*/.cache",
            "--exclude=demos/*/.work",
            "--exclude=._*",
            ".",
        ],
        capture_output=True,
        text=True,
    )
    if tar.returncode != 0:
        sys.stdout.write(f"[{box.short}] tar failed: {tar.stderr}\n")
        return tar.returncode
    # The tarball must land where the extraction reads it. Windows
    # OpenSSH scp resolves a bare `/tmp/...` target against the SFTP root
    # (typically the user's home drive), not `C:\tmp`, so create `C:\tmp`
    # and scp to the explicit `C:/tmp/...` path the extraction uses --
    # otherwise the extraction silently runs against a stale tarball from
    # an earlier run.
    mkdir = subprocess.run(
        ["ssh", box.host, 'cmd /c "mkdir C:\\tmp 2>NUL & exit /b 0"'],
        capture_output=True,
        text=True,
    )
    if mkdir.returncode != 0:
        sys.stdout.write(f"[{box.short}] mkdir C:\\tmp failed: {mkdir.stderr}\n")
        return mkdir.returncode
    scp = subprocess.run(
        ["scp", str(archive), f"{box.host}:C:/tmp/badc-tree.tar.gz"],
        capture_output=True,
        text=True,
    )
    if scp.returncode != 0:
        sys.stdout.write(f"[{box.short}] scp failed: {scp.stderr}\n")
        return scp.returncode
    remote_path = box.remote_path.replace("/", "\\")
    return stream(
        box.short,
        [
            "ssh",
            box.host,
            f'cmd /c "mkdir {remote_path} 2>NUL & '
            f"cd /d {remote_path} && "
            f'tar xzf C:\\tmp\\badc-tree.tar.gz"',
        ],
    )


def remote_run_windows(box: Box, github_token: str) -> int:
    demo_cmd = " && ".join(f"python {d}" for d in GATING_DEMOS)
    # cmd's path separator is the backslash; forward slashes from a
    # caller-supplied --box arg work for some commands but not for
    # `cd /d`, which silently returns success without changing the cwd.
    remote_path = box.remote_path.replace("/", "\\")
    inner = (
        f"cd /d {remote_path} && "
        f"set GITHUB_TOKEN={github_token} && "
        f"cargo build --release --locked --features full && "
        f"cargo test --release --lib --features full && "
        f"{demo_cmd}"
    )
    # Quote the entire command so the outer ssh-side cmd /c treats the
    # whole `cd && ... && cargo ...` chain as one cmd context. Without
    # the quotes only the first `&&` chunk runs under the inner cd; the
    # rest run in the outer shell's cwd (C:\Users\krom) and fail to find
    # Cargo.toml.
    return stream(box.short, ["ssh", box.host, f'cmd /c "{inner}"'])


def run_box(box: Box, github_token: str) -> int:
    sync = sync_linux if box.kind == "linux" else sync_windows
    test = remote_run_linux if box.kind == "linux" else remote_run_windows
    rc = sync(box, github_token)
    if rc != 0:
        sys.stdout.write(f"[{box.short}] SYNC FAILED ({rc})\n")
        return rc
    rc = test(box, github_token)
    sys.stdout.write(f"[{box.short}] {'OK' if rc == 0 else f'FAIL ({rc})'}\n")
    return rc


def main() -> int:
    p = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    p.add_argument(
        "--box",
        action="append",
        type=parse_box,
        required=True,
        metavar="NAME=HOST:PATH:KIND",
        help="add one remote lane; repeat for additional lanes",
    )
    args = p.parse_args()
    selected: list[Box] = args.box
    if not selected:
        print("no boxes selected", file=sys.stderr)
        return 2

    github_token = ""
    try:
        github_token = subprocess.run(
            ["gh", "auth", "token"], capture_output=True, text=True, check=True
        ).stdout.strip()
    except (FileNotFoundError, subprocess.CalledProcessError):
        sys.stdout.write(
            "warning: `gh auth token` failed; vendored-demo setup.py fetches will 404 on the private mirror\n"
        )

    results: dict[str, int] = {}

    def worker(box: Box) -> None:
        results[box.short] = run_box(box, github_token)

    threads = [threading.Thread(target=worker, args=(b,)) for b in selected]
    for t in threads:
        t.start()
    for t in threads:
        t.join()

    print()
    for box in selected:
        rc = results.get(box.short, -1)
        marker = "OK" if rc == 0 else f"FAIL ({rc})"
        print(f"  {box.short:<6} {marker}")
    return 0 if all(rc == 0 for rc in results.values()) else 1


if __name__ == "__main__":
    sys.exit(main())
