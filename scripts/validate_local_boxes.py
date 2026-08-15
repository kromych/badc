#!/usr/bin/env python3
"""Run the pre-push validation suite on a caller-specified set of
remote boxes in parallel and bail on the first lane that goes red.
The point is to catch lane-specific regressions before paying the
GitHub Actions runtime cost: each remote box runs the release-mode
test suite over every target -- the library plus the integration
suites under `tests/` -- and the gating demos CI exercises, so a
green run here is a solid proxy for a green run in the cloud.
Building and running the integration targets adds ~1.5 min to a lane
with a warm release build (measured on an idle linux-x64 box).

Each lane:
  1. Rsync (Linux) or tar+scp (Windows) the working tree, excluding
     `target/` and the vendored demo caches so the remote side
     builds + fetches its own caches.
  2. Build release with `cargo build --release --locked`.
  3. Run `cargo test --release` (all test targets).
  4. On Linux lanes, rerun the suite under the register-pressure caps
     (`BADC_MAX_GPR=2 BADC_MAX_FPR=2`, `--features "codegen_test full"`)
     as CI's pressure matrix does.
  5. Run the gating demos (`GATING_DEMOS` below).
  6. On Linux lanes, compile and link the pinned `defconfig` kernel with
     badc -- CI's kernel corpus, not the vendored minimal configs. Skip
     with `--no-kernel`.

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
    "demos/quickjs/smoke.py",
    "demos/raylib/smoke.py",
    "demos/curl/smoke.py",
    # Cooperative-concurrency demos gate the inline-asm context switch
    # (sp move + setjmp/longjmp); POSIX-gated, they skip cleanly on
    # Windows and off x86-64.
    "demos/libmill/smoke.py",
    "demos/libdill/smoke.py",
    "demos/coroutines/smoke.py",
    # A badc-built assembler runs its own golden suite, so a wrong value
    # in compiled code surfaces as a runtime failure rather than a bad
    # object. Every other demo here compiled clean while this caught a
    # stale-value miscompile, so it gates too. (demos/python is the same
    # kind of check and is gated in CI, but it cannot join this list
    # until a BSS global can be dynamically exported -- see the TODO in
    # src/c5/linker/synth_build.rs.)
    "demos/nasm/smoke.py",
)


# The kernel step's corpus is the pinned `defconfig` release setup.py fetches,
# which is the tree CI's `kernel` job builds. The vendored minimal configs
# compile a third to a half of defconfig's units and are not a substitute: they
# have passed while defconfig-only defects reached the branch. Its own cache
# dir, so the tree glob below cannot pick up a minimal-config tree.
KERNEL_CACHE = "~/.cache/badc-kernel-gate"

# Per-architecture unit floors, the same values as the `kernel` job's matrix in
# .github/workflows/ci.yml. A count below the floor means units dropped out of
# the build. Update both together.
KERNEL_FLOORS = {"aarch64": 4400, "x86_64": 2900}


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
        errors="replace",
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


# Each step's output is captured to a file rather than piped through
# `tail`: a green step is worth three lines, but a red one has to arrive
# whole. Truncating uniformly discarded exactly the part that names the
# failure -- cargo prints `failures:`, the test name and `test result:
# FAILED` before the final `error:` line, so a tail of the merged stream
# kept the error and dropped what it referred to.
FAIL_TAIL_LINES = 120

STEP_FN = (
    "step() { "
    'log=$(mktemp); if "$@" > "$log" 2>&1; then tail -3 "$log"; rm -f "$log"; '
    'else rc=$?; echo "--- lane step FAILED (rc=$rc): $*"; '
    f'tail -{FAIL_TAIL_LINES} "$log"; rm -f "$log"; exit $rc; fi; '
    "}"
)


def kernel_steps() -> list[str]:
    """Compile and link the pinned defconfig kernel with badc.

    The architecture is the box's own: setup.py and verify.py both default to
    the host. No boot phase -- this covers what is decided at the vmlinux link
    (a unit badc cannot compile, one that fell back, a link badc could not
    make, an undefined reference, a unit count below the floor), and a boot
    would add the emulator to the gate's dependencies for a class CI already
    covers. setup.py is idempotent: it re-verifies the cached tarball's sha256
    and reconfigures, so only the first run on a box pays the download."""
    floors = " ".join(f"{a}) floor={n};;" for a, n in KERNEL_FLOORS.items())
    return [
        f"step python3 demos/linux/setup.py --cache {KERNEL_CACHE}",
        f'ktree=$(find {KERNEL_CACHE} -maxdepth 1 -type d -name "linux-*" | head -1)',
        f'test -n "$ktree" || {{ echo "--- no kernel tree under {KERNEL_CACHE}"; exit 1; }}',
        f"case $(uname -m) in {floors} *) floor=0;; esac",
        # The boxes' reference compiler is not the one the pinned release was
        # released against; its warnings are not this step's subject, same as
        # in CI.
        "step env KCFLAGS=-Wno-error python3 demos/linux/verify.py "
        '--kernel-dir "$ktree" --linker badc --no-boot '
        f'--expect-units "$floor" --workdir {KERNEL_CACHE}/verify-out',
    ]


def remote_run_linux(box: Box, github_token: str, kernel: bool, demos: bool) -> int:
    steps = [
        "step cargo build --release --locked --features full",
        "step cargo test --release --features full",
        # CI additionally runs the suite under register-pressure caps
        # (BADC_MAX_GPR / BADC_MAX_FPR over several N); N=2 is the value
        # that has caught spill-interaction bugs the default banks hide.
        "step env BADC_MAX_GPR=2 BADC_MAX_FPR=2 "
        'cargo test --release --features "codegen_test full"',
    ]
    if demos:
        steps += [f"step python3 {d}" for d in GATING_DEMOS]
    # Last: the most expensive step, so the cheaper ones report first.
    if kernel:
        steps += kernel_steps()
    inner = (
        f"cd {box.remote_path} && "
        f"export GITHUB_TOKEN={shlex.quote(github_token)} && "
        f"{STEP_FN}; " + " && ".join(steps)
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
        errors="replace",
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
        errors="replace",
    )
    if mkdir.returncode != 0:
        sys.stdout.write(f"[{box.short}] mkdir C:\\tmp failed: {mkdir.stderr}\n")
        return mkdir.returncode
    scp = subprocess.run(
        ["scp", str(archive), f"{box.host}:C:/tmp/badc-tree.tar.gz"],
        capture_output=True,
        text=True,
        errors="replace",
    )
    if scp.returncode != 0:
        sys.stdout.write(f"[{box.short}] scp failed: {scp.stderr}\n")
        return scp.returncode
    remote_path = box.remote_path.replace("/", "\\")
    # Remove the tracked source trees before extracting. tar extraction does
    # not prune, so a file deleted or renamed in the working tree would linger
    # on the box and collide with its replacement (e.g. a module that became a
    # directory). target/ and .git are siblings and are preserved.
    return stream(
        box.short,
        [
            "ssh",
            box.host,
            f'cmd /c "mkdir {remote_path} 2>NUL & '
            f"cd /d {remote_path} && "
            f"rmdir /s /q src 2>NUL & rmdir /s /q tests 2>NUL & "
            f'tar xzf C:\\tmp\\badc-tree.tar.gz"',
        ],
    )


# `_kernel` is unused: the kernel step is a Linux-lane dimension, and the
# parameter is present only so both lane kinds dispatch through one signature.
def remote_run_windows(box: Box, github_token: str, _kernel: bool, demos: bool) -> int:
    # cmd's path separator is the backslash; forward slashes from a
    # caller-supplied --box arg work for some commands but not for
    # `cd /d`, which silently returns success without changing the cwd.
    remote_path = box.remote_path.replace("/", "\\")
    parts = [
        f"cd /d {remote_path}",
        f"set GITHUB_TOKEN={github_token}",
        "cargo build --release --locked --features full",
        "cargo test --release --features full",
    ]
    if demos:
        parts += [f"python {d}" for d in GATING_DEMOS]
    inner = " && ".join(parts)
    # Quote the entire command so the outer ssh-side cmd /c treats the
    # whole `cd && ... && cargo ...` chain as one cmd context. Without
    # the quotes only the first `&&` chunk runs under the inner cd; the
    # rest run in the outer shell's cwd (C:\Users\krom) and fail to find
    # Cargo.toml.
    return stream(box.short, ["ssh", box.host, f'cmd /c "{inner}"'])


def run_box(box: Box, github_token: str, kernel: bool, demos: bool) -> int:
    sync = sync_linux if box.kind == "linux" else sync_windows
    test = remote_run_linux if box.kind == "linux" else remote_run_windows
    rc = sync(box, github_token)
    if rc != 0:
        sys.stdout.write(f"[{box.short}] SYNC FAILED ({rc})\n")
        return rc
    rc = test(box, github_token, kernel, demos)
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
    p.add_argument(
        "--no-kernel",
        action="store_true",
        help="skip the defconfig kernel step on Linux lanes",
    )
    p.add_argument(
        "--no-demos",
        action="store_true",
        help="skip the gating demos on every lane; with --no-kernel this "
        "leaves sync + release build + the full test suite (+ the pressure "
        "rerun on Linux), the quick check for intermediate merges -- the "
        "full gate stays required before a push",
    )
    args = p.parse_args()
    selected: list[Box] = args.box
    if not selected:
        print("no boxes selected", file=sys.stderr)
        return 2

    if any(b.kind == "linux" for b in selected):
        if args.no_kernel:
            print("kernel step: SKIPPED (--no-kernel); the defconfig corpus is "
                  "where CI's kernel gate finds link-visible regressions")
        else:
            print("kernel step: 7.1.6 defconfig, compile + link, no boot; "
                  "adds 4.5-11 min per Linux lane (measured on an idle box and "
                  "on one shared with five other jobs). Lanes run in parallel, "
                  "so the gate grows by the slowest lane, not the sum. First "
                  "run on a box also downloads the release (~150 MB). "
                  "Skip with --no-kernel.")

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
        results[box.short] = run_box(
            box, github_token, not args.no_kernel, not args.no_demos
        )

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
