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
  4. On Linux lanes, rerun the lib suite under the register-pressure caps
     (`BADC_MAX_GPR=2 BADC_MAX_FPR=2`, `--lib --features "codegen_test full"`),
     the same scope as CI's pressure matrix.
  5. Run the gating demos (`GATING_DEMOS` below) through
     `scripts/run_demos.py`, which runs them concurrently; every demo the
     lane's kind selects runs, `--demo-jobs` bounds only how many at once.
  6. On the lane `--snapshot-box` names, regenerate `tests/snapshots/` and
     fail on drift, as CI's `snapshots clean` job does. Skip with
     `--no-snapshots`.
  7. On Linux lanes, compile and link the pinned `defconfig` kernel with
     badc -- CI's kernel corpus, not the vendored minimal configs. Skip
     with `--no-kernel`.

Usage (one `--box` flag per remote lane):

    python3 scripts/validate_local_boxes.py --snapshot-box krom2 \\
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

# Lane kinds a demo runs on. Not every off-platform demo skips with a
# zero status -- demos/chibicc exits 2 on Windows -- so the kinds are
# named rather than left to the demo.
ALL = frozenset({"linux", "windows", "macos"})
POSIX = frozenset({"linux", "macos"})
LINUX = frozenset({"linux"})

# Demos to run at a time per lane. Several drive their own thread pool
# (demos/qemu takes cpu_count), so the width trades lane wall clock
# against oversubscription rather than scaling with core count.
DEMO_JOBS = 4

# Longest first: the phase ends when the last long demo does, so one
# that starts late after the pool drains extends the phase by its whole
# duration. The four leading entries are the measured long poles.
GATING_DEMOS = (
    # The only demo that drives ./configure + make and replays the
    # Makefile's own compile lines through badc, and the only one
    # running an upstream suite (tests/all.tcl) against a zero-failure
    # baseline. The longest demo in the roster, so it sets the floor.
    ("demos/tcl/smoke.py", POSIX),
    # PE32+ EFI applications for both Windows targets, --freestanding,
    # badc's own linker, no GenFw: the EFIAPI ABI surface and the
    # subsystem-10 header, which no hosted demo reaches. Boots the
    # images where QEMU and firmware are installed.
    ("demos/edk2/smoke.py", ALL),
    # The widest corpus in the tree (1683 units on aarch64, 1466 on
    # x86_64) and the only pure self-link -- badc's own linker over
    # 100%-badc objects, no system linker. run_demos.py gates its build
    # and its run, not its boot: the boot consumes the firmware CI's
    # ovmf lane publishes as an artifact. Needs pkg-config,
    # libglib2.0-dev, zlib1g-dev, libfdt-dev.
    ("demos/qemu/smoke.py", LINUX),
    # The whole upstream src/ tree five ways, deliberately not
    # amalgamated: BearSSL reuses `static` names across files, so this
    # is the internal-linkage and cross-TU exercise. Runs 17 KAT suites.
    ("demos/bearssl/smoke.py", ALL),
    ("demos/sqlite3/smoke.py", ALL),
    ("demos/lua/smoke.py", ALL),
    ("demos/miniz/smoke.py", ALL),
    ("demos/monocypher/smoke.py", ALL),
    ("demos/stb/smoke.py", ALL),
    ("demos/tweetnacl/smoke.py", ALL),
    ("demos/quickjs/smoke.py", ALL),
    ("demos/raylib/smoke.py", ALL),
    ("demos/curl/smoke.py", ALL),
    # Cooperative-concurrency demos gate the inline-asm context switch
    # (sp move + setjmp/longjmp); POSIX-gated, they skip cleanly on
    # Windows and off x86-64.
    ("demos/libmill/smoke.py", ALL),
    ("demos/libdill/smoke.py", ALL),
    ("demos/coroutines/smoke.py", ALL),
    # A badc-built assembler runs its own golden suite, so a wrong value
    # in compiled code surfaces as a runtime failure rather than a bad
    # object. Every other demo here compiled clean while this caught a
    # stale-value miscompile, so it gates too.
    ("demos/nasm/smoke.py", ALL),
    # The only demo feeding badc an amalgamation on stdin (`badc -`)
    # with #line markers driving DWARF file attribution.
    ("demos/bzip2/smoke.py", ALL),
    # libm calls and their FP return register, compound-assign int->FP
    # conversion, and a JIT dlopen of libm.
    ("demos/kissfft/smoke.py", ALL),
    # Links system GUI libraries -- user32/gdi32, libX11.so.6, libobjc +
    # AppKit -- for all five targets from any host, plus #pragma
    # subsystem and #pragma entrypoint. The only cover for linking a
    # non-libc system library on a target that is not the host.
    ("demos/gui_hello/smoke.py", ALL),
    # PE subsystem bytes (CUI and NATIVE) and the ntdll HANDLE-returning
    # bindings, where a 64-bit return truncation would show.
    ("demos/nt_loader/smoke.py", ALL),
    # A self-hosting compiler's TU set across x86_64/aarch64 and
    # ELF/Mach-O/PE; locks in bitfield storage units (6.7.2.1p11),
    # <inttypes.h> PRI/SCN, and the Win64 16-byte-aligned jmp_buf.
    ("demos/tinycc/smoke.py", ALL),
    # POSIX libc surface no other demo here spells (fork/execvp/waitpid,
    # glob, dirname, open_memstream, strtold) and file-scope compound
    # literals. Exits 2 on Windows.
    ("demos/chibicc/smoke.py", POSIX),
)

# Out of the roster, measured on the boxes rather than assumed:
#   demos/kernel   481 s per Linux lane on both arches, nearly all of it
#                  eight UEFI boots, half cross-architecture under TCG.
#   demos/yasm     Red on both Linux boxes before badc is at fault: its
#                  host-cc reference build hits the boxes' gcc defaulting
#                  to -std=c23, where yasm's own
#                  `enum boolean { false = FALSE, ... }` is a syntax
#                  error. badc's yasm builds and runs on both.
#   demos/python   POSIX-only, and red on the aarch64 box in its host
#                  reference build: CPython's own checksharedmods step
#                  faults in sysconfig before badc compiles anything.
#                  The dynamic export of a BSS global, which this entry
#                  used to name as the blocker, is implemented in
#                  synth_build.rs; whether anything else blocks the demo
#                  cannot be told until the host build runs.


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
        "--exclude=.claude",
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


def demo_command(box: Box, jobs: int, runner: str) -> str:
    """The whole demo phase as one command.

    The demos are independent processes with per-demo cache directories, so
    `run_demos.py` runs them in a pool instead of a serial `&&` chain. It
    prints its roster and pool width; `jobs` bounds concurrency only."""
    demos = " ".join(d for d, kinds in GATING_DEMOS if box.kind in kinds)
    return f"{runner} scripts/run_demos.py --jobs {jobs} {demos}"


def remote_run_linux(
    box: Box, github_token: str, kernel: bool, demos: bool, snapshots: bool, jobs: int
) -> int:
    steps = [
        # Lint here, not only in the pre-push hook. Code behind
        # `cfg(target_os = "linux")` is not compiled on the macOS host the
        # hook runs on, so clippy cannot see it there at all -- a lint in a
        # Linux-gated path passes every local check and fails in CI. Debug
        # profile, matching the `fmt + clippy` job.
        "step cargo clippy --all-targets --features full -- -D warnings",
        "step cargo build --release --locked --features full",
        "step cargo test --release --features full",
        # CI additionally runs the suite under register-pressure caps
        # (BADC_MAX_GPR / BADC_MAX_FPR over several N); N=2 is the value
        # that has caught spill-interaction bugs the default banks hide.
        # The capped rerun keeps CI's --lib scope: the caps reach every
        # badc the tests spawn, and an integration fixture asserting an
        # optimization-strength property does not hold under a 2-register
        # bank.
        "step env BADC_MAX_GPR=2 BADC_MAX_FPR=2 "
        'cargo test --release --lib --features "codegen_test full"',
    ]
    if demos:
        steps.append("step " + demo_command(box, jobs, "python3"))
    if snapshots:
        steps.append("step python3 scripts/snapshot_drift.py")
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
    # macOS bsdtar synthesizes AppleDouble `._*` members for files
    # carrying extended attributes; `--exclude` cannot filter entries
    # created during packing, so they land on the box as stray files.
    tar_env = dict(os.environ, COPYFILE_DISABLE="1")
    tar = subprocess.run(
        [
            "tar",
            "czf",
            str(archive),
            "-C",
            str(REPO_ROOT),
            "--exclude=target",
            "--exclude=.git",
            "--exclude=.claude",
            "--exclude=demos/*/.cache",
            "--exclude=demos/*/.work",
            "--exclude=._*",
            ".",
        ],
        capture_output=True,
        text=True,
        errors="replace",
        env=tar_env,
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
    #
    # demos/ is not pruned: it holds the fetched-source caches the tar excludes,
    # and refetching them every run costs more than the staleness it would
    # clear. The one class of stale file that has actually broken a lane is
    # swept instead -- AppleDouble `._*` members, which the tar no longer packs
    # but which a box synced before that exclusion still carries. A demo that
    # globs `src/*.c` compiles one and fails on invalid UTF-8.
    return stream(
        box.short,
        [
            "ssh",
            box.host,
            f'cmd /c "mkdir {remote_path} 2>NUL & '
            f"cd /d {remote_path} && "
            f"rmdir /s /q src 2>NUL & rmdir /s /q tests 2>NUL & "
            f"del /s /q /f ._* 2>NUL & "
            f'tar xzf C:\\tmp\\badc-tree.tar.gz"',
        ],
    )


# `_kernel` and `_snapshots` are unused: both steps are Linux-lane
# dimensions, and the parameters are present only so both lane kinds
# dispatch through one signature.
def remote_run_windows(
    box: Box, github_token: str, _kernel: bool, demos: bool, _snapshots: bool, jobs: int
) -> int:
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
        parts.append(demo_command(box, jobs, "python"))
    inner = " && ".join(parts)
    # Quote the entire command so the outer ssh-side cmd /c treats the
    # whole `cd && ... && cargo ...` chain as one cmd context. Without
    # the quotes only the first `&&` chunk runs under the inner cd; the
    # rest run in the outer shell's cwd (C:\Users\krom) and fail to find
    # Cargo.toml.
    return stream(box.short, ["ssh", box.host, f'cmd /c "{inner}"'])


def run_box(
    box: Box, github_token: str, kernel: bool, demos: bool, snapshots: bool, jobs: int
) -> int:
    sync = sync_linux if box.kind == "linux" else sync_windows
    test = remote_run_linux if box.kind == "linux" else remote_run_windows
    rc = sync(box, github_token)
    if rc != 0:
        sys.stdout.write(f"[{box.short}] SYNC FAILED ({rc})\n")
        return rc
    rc = test(box, github_token, kernel, demos, snapshots, jobs)
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
        "--no-snapshots",
        action="store_true",
        help="skip the snapshot-drift check on the snapshot lane",
    )
    p.add_argument(
        "--snapshot-box",
        metavar="NAME",
        help="Linux lane that runs the snapshot-drift check; the check needs "
        "one lane's release build, not four. No lane runs it unless named: "
        "regeneration is not host-independent yet (see the note in main)",
    )
    p.add_argument(
        "--demo-jobs",
        type=int,
        default=DEMO_JOBS,
        help=f"demos to run at a time per lane (default {DEMO_JOBS}); bounds "
        "concurrency only, never which demos run",
    )
    p.add_argument(
        "--no-demos",
        action="store_true",
        help="skip the gating demos on every lane; with --no-kernel this "
        "leaves sync + release build + the full test suite (+ the pressure "
        "rerun on Linux), the quick check for intermediate merges -- the "
        "full gate stays required before a push",
    )
    p.add_argument(
        "--allow-dirty",
        action="store_true",
        help="gate the working tree even with uncommitted changes; off by "
        "default because the sync ships the working tree, so a stray edit "
        "is gated instead of the commit that will be pushed",
    )
    args = p.parse_args()
    selected: list[Box] = args.box
    if not selected:
        print("no boxes selected", file=sys.stderr)
        return 2

    # The sync ships the working tree, not HEAD. An uncommitted edit -- a
    # half-finished change, or an agent writing to the shared checkout --
    # is therefore what gets gated, and the result does not describe the
    # commit being pushed. Seen once: an in-progress change reached all
    # four lanes and failed every one on a test that HEAD passes.
    if not args.allow_dirty:
        dirty = subprocess.run(
            ["git", "status", "--porcelain"],
            cwd=REPO_ROOT,
            capture_output=True,
            text=True,
        ).stdout.strip()
        if dirty:
            print(
                "working tree is dirty; the sync would gate these instead of "
                "HEAD:\n" + dirty + "\ncommit, stash, or pass --allow-dirty",
                file=sys.stderr,
            )
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

    # The lane is named rather than picked: `scripts/snapshots.py` is not
    # host-independent yet. On a linux-x64 host the x64 fixtures link
    # natively, and on Fedora 44 that map does not yield a `.text` stop
    # address, so the regeneration appends the runtime tail to the x64
    # snapshots and every one of them reads as drifted. The aarch64 lane
    # cross-links both targets and matches the committed corpus.
    linux_lanes = [b for b in selected if b.kind == "linux"]
    snapshot_lane = ""
    if args.no_snapshots:
        print("snapshot-drift check: SKIPPED (--no-snapshots)")
    elif not args.snapshot_box:
        if linux_lanes:
            print("snapshot-drift check: NO LANE; name one with "
                  "--snapshot-box (a Linux lane) to gate tests/snapshots/ "
                  "against drift, as CI's `snapshots clean` job does")
    elif args.snapshot_box not in {b.short for b in linux_lanes}:
        print(f"--snapshot-box {args.snapshot_box!r} is not a selected Linux lane",
              file=sys.stderr)
        return 2
    else:
        snapshot_lane = args.snapshot_box
        print(f"snapshot-drift check: lane {snapshot_lane}; regenerates "
              "tests/snapshots/ and fails on drift, as CI's `snapshots clean` "
              "job does. Needs llvm-objdump. Skip with --no-snapshots.")

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
            box,
            github_token,
            not args.no_kernel,
            not args.no_demos,
            box.short == snapshot_lane,
            args.demo_jobs,
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
