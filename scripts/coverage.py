#!/usr/bin/env python3
"""Line and function coverage of `src/` under the test suite.

The suite is built and run with rustc's `-C instrument-coverage`, so
every test executable, and every `badc` the CLI suites spawn through
`CARGO_BIN_EXE_badc`, writes a raw profile at exit; `LLVM_PROFILE_FILE`
carries `%p-%m`, one file per process. `llvm-profdata` merges them and
`llvm-cov` reads the merge back against every executable the build
produced. Both tools come from the rustup `llvm-tools` component,
resolved through `rustc --print sysroot` before PATH.

The instrumented build has its own target directory (`target/coverage`
by default), so it neither invalidates nor is invalidated by the
ordinary build. The raw profiles are removed before each run: a report
covers the run that produced it. `--clean` also drops the build.

Counted: the sources under `src/`, less `src/c5/tests/` and the
`tests.rs` modules beside the code they test. Test functions in an
inline `#[cfg(test)]` module count with the file that holds them;
llvm-cov has no line-range exclusion. Doctests are not instrumented.

Output: `llvm-cov report`'s per-file table, a table per source
directory sorted by line coverage ascending, and the twenty files with
the most uncovered lines. `--lcov FILE` and `--html DIR` export the
same data. `--check PCT` fails when total line coverage over `src/` is
below PCT.
"""

from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
SRC = REPO_ROOT / "src"

# Test sources under `src/`. Restricting the report to `src/` already
# leaves out the CLI suites under `tests/`, `build.rs` and the
# dependencies compiled with the same flags.
IGNORE_SOURCES = (r"src/c5/tests/", r"/tests\.rs$")
LEAST_COVERED = 20


def llvm_tool_dir() -> Path:
    """Where the rustup `llvm-tools` component puts its binaries."""

    def rustc(*args: str) -> str:
        try:
            return subprocess.run(
                ["rustc", *args], capture_output=True, text=True, check=True
            ).stdout
        except (OSError, subprocess.CalledProcessError) as e:
            raise SystemExit(f"[coverage] rustc {' '.join(args)}: {e}")

    sysroot = rustc("--print", "sysroot").strip()
    host = ""
    for line in rustc("-vV").splitlines():
        if line.startswith("host:"):
            host = line.split(":", 1)[1].strip()
    return Path(sysroot) / "lib" / "rustlib" / host / "bin"


def llvm_tool(tool_dir: Path, name: str) -> Path:
    exe = name + (".exe" if os.name == "nt" else "")
    candidate = tool_dir / exe
    if candidate.is_file():
        return candidate
    found = shutil.which(exe)
    if found:
        return Path(found)
    raise SystemExit(
        f"[coverage] no {name} under {tool_dir} or on PATH; "
        "run `rustup component add llvm-tools`"
    )


def instrumented_env(target_dir: Path, profile_dir: Path) -> dict[str, str]:
    env = dict(os.environ)
    encoded = env.get("CARGO_ENCODED_RUSTFLAGS")
    if encoded is not None:
        flags = [f for f in encoded.split("\x1f") if f]
        env["CARGO_ENCODED_RUSTFLAGS"] = "\x1f".join(
            [*flags, "-C", "instrument-coverage"]
        )
    else:
        flags = env.get("RUSTFLAGS", "")
        env["RUSTFLAGS"] = f"{flags} -C instrument-coverage".strip()
    env["CARGO_TARGET_DIR"] = str(target_dir)
    env["LLVM_PROFILE_FILE"] = str(profile_dir / "badc-%p-%m.profraw")
    return env


def cargo_test(release: bool, jobs: int) -> list[str]:
    cmd = ["cargo", "test", "--features", "full", "--jobs", str(jobs)]
    if release:
        cmd.append("--release")
    return cmd


def build(env: dict[str, str], release: bool, jobs: int) -> list[Path]:
    """Build the suite; return the test executables and the `badc`
    binary the CLI suites spawn, which is the `bin` artifact."""
    cmd = [*cargo_test(release, jobs), "--no-run", "--message-format=json"]
    out = subprocess.run(
        cmd, cwd=REPO_ROOT, env=env, stdout=subprocess.PIPE, text=True
    )
    if out.returncode != 0:
        raise SystemExit(f"[coverage] {' '.join(cmd)} exited {out.returncode}")
    manifest = REPO_ROOT / "Cargo.toml"
    executables: list[Path] = []
    for line in out.stdout.splitlines():
        try:
            msg = json.loads(line)
        except ValueError:
            continue
        if msg.get("reason") != "compiler-artifact" or not msg.get("executable"):
            continue
        if Path(msg["manifest_path"]).resolve() != manifest:
            continue
        if not (msg["profile"]["test"] or "bin" in msg["target"]["kind"]):
            continue
        path = Path(msg["executable"])
        if path not in executables:
            executables.append(path)
    if not executables:
        raise SystemExit("[coverage] the build produced no test executable")
    return executables


def run_tests(
    env: dict[str, str], release: bool, jobs: int, test_args: list[str]
) -> int:
    cmd = [*cargo_test(release, jobs), "--no-fail-fast"]
    if test_args:
        cmd += ["--", *test_args]
    return subprocess.run(cmd, cwd=REPO_ROOT, env=env).returncode


def merge_profiles(profdata: Path, profile_dir: Path, out: Path) -> int:
    raws = sorted(profile_dir.glob("*.profraw"))
    if not raws:
        raise SystemExit(f"[coverage] no raw profiles under {profile_dir}")
    listing = out.with_suffix(".list")
    listing.write_text("".join(f"{p}\n" for p in raws))
    # A process killed before exit leaves a truncated profile; the merge
    # skips it with a warning rather than discarding the run.
    cmd = [
        str(profdata),
        "merge",
        "-sparse",
        "--failure-mode=all",
        f"--input-files={listing}",
        "-o",
        str(out),
    ]
    if subprocess.run(cmd).returncode != 0:
        raise SystemExit("[coverage] llvm-profdata merge failed")
    return len(raws)


def cov_command(
    cov: Path, sub: str, profdata: Path, objects: list[Path]
) -> list[str]:
    return [
        str(cov),
        sub,
        f"-instr-profile={profdata}",
        *(f"--object={o}" for o in objects),
        f"--ignore-filename-regex={'|'.join(IGNORE_SOURCES)}",
        "--sources",
        str(SRC),
    ]


def run_cov(cmd: list[str], **kwargs) -> subprocess.CompletedProcess:
    out = subprocess.run(cmd, **kwargs)
    if out.returncode != 0:
        raise SystemExit(f"[coverage] {cmd[0]} {cmd[1]} exited {out.returncode}")
    return out


class Counts:
    """Covered / total lines and functions of one file or directory."""

    def __init__(self) -> None:
        self.lines = [0, 0]
        self.functions = [0, 0]

    def add(self, summary: dict) -> None:
        for field, acc in (("lines", self.lines), ("functions", self.functions)):
            acc[0] += summary[field]["covered"]
            acc[1] += summary[field]["count"]

    @staticmethod
    def pct(pair: list[int]) -> float:
        return 100.0 * pair[0] / pair[1] if pair[1] else 0.0

    @property
    def line_pct(self) -> float:
        return self.pct(self.lines)

    @property
    def function_pct(self) -> float:
        return self.pct(self.functions)

    @property
    def uncovered(self) -> int:
        return self.lines[1] - self.lines[0]


def summarize(export: dict) -> tuple[dict[str, Counts], dict[str, Counts], Counts]:
    """Per-file and per-directory counts, paths relative to the root."""
    files: dict[str, Counts] = {}
    dirs: dict[str, Counts] = {}
    total = Counts()
    for entry in export["data"][0]["files"]:
        path = Path(entry["filename"])
        if path.is_absolute() and path.is_relative_to(REPO_ROOT):
            path = path.relative_to(REPO_ROOT)
        per_file = files.setdefault(path.as_posix(), Counts())
        per_dir = dirs.setdefault(path.parent.as_posix(), Counts())
        for acc in (per_file, per_dir, total):
            acc.add(entry["summary"])
    return files, dirs, total


def print_tables(
    files: dict[str, Counts], dirs: dict[str, Counts], total: Counts
) -> None:
    print(
        "\n| directory | lines | covered | line % | functions | covered | function % |"
        "\n|---|--:|--:|--:|--:|--:|--:|"
    )
    rows = sorted(dirs.items(), key=lambda kv: (kv[1].line_pct, kv[0]))
    for name, c in [*rows, ("total", total)]:
        print(
            f"| {name} | {c.lines[1]} | {c.lines[0]} | {c.line_pct:.2f} "
            f"| {c.functions[1]} | {c.functions[0]} | {c.function_pct:.2f} |"
        )
    print("\n| file | uncovered lines | lines | line % |\n|---|--:|--:|--:|")
    worst = sorted(files.items(), key=lambda kv: (-kv[1].uncovered, kv[0]))
    for name, c in worst[:LEAST_COVERED]:
        print(f"| {name} | {c.uncovered} | {c.lines[1]} | {c.line_pct:.2f} |")


def main(argv: list[str]) -> int:
    p = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    p.add_argument(
        "--release",
        action="store_true",
        help="measure the release profile, whose JIT and native parity tests "
        "a debug build skips",
    )
    p.add_argument(
        "--jobs",
        type=int,
        default=os.cpu_count() or 1,
        help="cargo build parallelism (default: every core)",
    )
    p.add_argument(
        "--target-dir",
        type=Path,
        default=REPO_ROOT / "target" / "coverage",
        help="target directory of the instrumented build",
    )
    p.add_argument("--lcov", type=Path, metavar="FILE", help="write an lcov trace")
    p.add_argument(
        "--html", type=Path, metavar="DIR", help="write annotated sources as HTML"
    )
    p.add_argument(
        "--check",
        type=float,
        metavar="PCT",
        help="fail when total line coverage over src/ is below PCT",
    )
    p.add_argument(
        "--clean",
        action="store_true",
        help="remove the raw profiles and the coverage target directory, "
        "then exit",
    )
    p.add_argument(
        "test_args",
        nargs="*",
        help="passed to the test harness after `--`, e.g. a test-name filter",
    )
    args = p.parse_args(argv)

    target_dir = args.target_dir.resolve()
    profile_dir = target_dir / "profraw"
    if args.clean:
        for d in (profile_dir, target_dir):
            shutil.rmtree(d, ignore_errors=True)
        print(f"[coverage] removed {target_dir}")
        return 0

    tool_dir = llvm_tool_dir()
    profdata = llvm_tool(tool_dir, "llvm-profdata")
    cov = llvm_tool(tool_dir, "llvm-cov")
    env = instrumented_env(target_dir, profile_dir)
    shutil.rmtree(profile_dir, ignore_errors=True)
    profile_dir.mkdir(parents=True)

    started = time.perf_counter()
    print(f"[coverage] building the instrumented suite under {target_dir}", flush=True)
    objects = build(env, args.release, args.jobs)
    built = time.perf_counter()
    print(f"[coverage] running the suite: {len(objects)} executables", flush=True)
    test_rc = run_tests(env, args.release, args.jobs, args.test_args)
    tested = time.perf_counter()

    merged = target_dir / "badc.profdata"
    raw_count = merge_profiles(profdata, profile_dir, merged)
    print(f"[coverage] merged {raw_count} raw profiles into {merged}", flush=True)
    run_cov(cov_command(cov, "report", merged, objects))
    export = json.loads(
        run_cov(
            [
                *cov_command(cov, "export", merged, objects),
                "-format=text",
                "-summary-only",
            ],
            stdout=subprocess.PIPE,
            text=True,
        ).stdout
    )
    if args.lcov:
        args.lcov.parent.mkdir(parents=True, exist_ok=True)
        with open(args.lcov, "w") as f:
            run_cov(
                [*cov_command(cov, "export", merged, objects), "-format=lcov"],
                stdout=f,
            )
        print(f"[coverage] wrote {args.lcov}")
    if args.html:
        run_cov(
            [
                *cov_command(cov, "show", merged, objects),
                "-format=html",
                f"-output-dir={args.html}",
            ]
        )
        print(f"[coverage] wrote {args.html}")

    files, dirs, total = summarize(export)
    print_tables(files, dirs, total)
    reported = time.perf_counter()
    print(
        f"\n[coverage] src/: lines {total.lines[0]}/{total.lines[1]} "
        f"({total.line_pct:.2f}%), functions {total.functions[0]}/"
        f"{total.functions[1]} ({total.function_pct:.2f}%); "
        f"build {built - started:.0f}s, tests {tested - built:.0f}s, "
        f"report {reported - tested:.0f}s"
    )
    rc = 0
    if test_rc != 0:
        print(
            f"[coverage] cargo test exited {test_rc}; "
            "the report covers the tests that ran"
        )
        rc = 1
    if args.check is not None and total.line_pct < args.check:
        print(
            f"[coverage] line coverage {total.line_pct:.2f}% is below the "
            f"{args.check:.2f}% floor"
        )
        rc = 1
    return rc


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
