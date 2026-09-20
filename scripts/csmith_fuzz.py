#!/usr/bin/env python3
"""Differential fuzzing of `badc` over `csmith`-generated translation units.

One case is one generated program: csmith emits it from a recorded seed, the
reference compiler and `badc -O0` / `badc -O` each build it, all three binaries
run, and the checksum the program prints is compared. csmith's contract is that
the program is free of undefined behaviour, so any disagreement, crash or
compile failure is a defect in one of the compilers.

The oracle is the reference compiler (`clang`, else `gcc`, else `cc`), for
three reasons the trial in the tree's history measured: it separates "badc
aborted" from "the generated program is simply slow", it catches the case where
both badc configurations agree and are wrong, and its own success is the
cheapest gate on the programs that do not terminate. A case is skipped, not
reported, unless the reference compiles it unoptimised, exits 0 within a second
and prints a checksum. Before a runtime finding is filed the reference is
rebuilt at `-O2` and rerun: a program on which the reference disagrees with
itself is the reference's own affair and is dropped.

Without a reference compiler the two badc configurations are compared against
each other. That is a weaker oracle -- it cannot see a miscompile both
configurations share -- and the run says so in its summary.

Generation is bounded (`GENERATION_BOUNDS`). csmith's defaults reach 3939
lines, and neither the defaults nor any bound stops it emitting a program that
does not terminate: its loop control variables include globals that a callee
writes. The reference run, capped at `--reference-run-timeout`, is what drops
those, which is why it runs first.

Findings are deduplicated by signature (see `signature_of`) within the run and
against the comments already on the week's issue, so one defect is reported
once per week per architecture rather than once per case that reaches it.

`--publish` files them: the offending source, unreduced, becomes an asset of
the `fuzz-cases-v1` release, and a comment naming it is appended to the issue
`compiler fuzzing, <Monday>...<Sunday>` for the run's ISO week, which is opened
if it does not exist. Without `--publish` nothing is written: the plan, the
issue body and every comment are printed instead.

`--self-test` checks the pure parts (signatures, dedup, week arithmetic,
rendering, the `gh` argument vectors) and needs neither csmith nor badc. With
csmith present it also asserts that a generation leaves the repository
untouched: csmith writes `platform.info` into its working directory, not beside
its `-o` output, so every case runs in its own scratch directory.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import contextlib
import dataclasses
import datetime as dt
import hashlib
import json
import os
import platform
import random
import re
import shutil
import signal
import subprocess
import sys
import tempfile
import time
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

# The badc configurations under test. `--interp` is out: the trial measured the
# SSA interpreter at minutes per case on programs of this size.
CONFIGS = ("-O0", "-O")

# The reference builds the case twice: once to gate and answer, once to confirm
# a runtime finding. The gate is unoptimised because the question it settles is
# whether the program terminates at all, and an optimiser answers a different
# one: a csmith program whose loop never ends is side-effect free, so `clang
# -O2` deletes the loop and the binary exits at once while every honest build
# of it runs forever. One such program reached a `run-timeout` finding against
# an `-O2` gate here before this was measured.
REFERENCE_GATE = "-O0"
REFERENCE_CONFIRM = "-O2"

# csmith bounds. Measured over 40 seeds on an aarch64 host: the defaults give
# 106 to 3160 lines (median 1461), these give 97 to 1465 (median 652), and the
# whole feature set -- bitfields, unions, packed structs, volatiles, jumps,
# safe-math wrappers, pointers -- is still generated. Floats stay off (csmith's
# default): badc contracts `a*b+c` at `-O` as C99 6.5p8 permits and clang -O2
# contracts too, so a float checksum compares two legal roundings and every
# such case would be a false finding.
GENERATION_BOUNDS = (
    "--max-funcs",
    "6",
    "--max-block-size",
    "4",
    "--max-block-depth",
    "3",
    "--max-expr-complexity",
    "6",
    "--max-array-dim",
    "2",
    "--max-array-len-per-dim",
    "6",
    "--max-struct-fields",
    "6",
    "--max-union-fields",
    "4",
    "--concise",
)

# The release used as the case store, and the label put on a weekly issue.
CASE_STORE_TAG = "fuzz-cases-v1"
ISSUE_LABEL = "robustness"

# Evidence kept in a comment. The rest stays in the run's JSON report.
EVIDENCE_LINES = 60

CHECKSUM_RE = re.compile(r"checksum\s*=\s*([0-9A-Fa-f]+)")
PANIC_RE = re.compile(r"panicked at ([^\s:]+(?::\d+)+)\s*:?\s*\n?(.*)")
DIAG_CODE_RE = re.compile(r"\[(B\d+)\]")
SIGNATURE_RE = re.compile(r"signature[^0-9a-f]{0,16}([0-9a-f]{12})\b")
ARCH_ALIASES = {"arm64": "aarch64", "amd64": "x86_64", "x64": "x86_64"}

# Verdicts that describe how the generated program behaved, rather than how it
# compiled: each is confirmed against the reference's other level before it is
# filed.
RUNTIME_VERDICTS = ("checksum-mismatch", "checksum-missing", "run-signal", "run-exit")


def host_arch() -> str:
    machine = platform.machine().lower()
    return ARCH_ALIASES.get(machine, machine)


# --------------------------------------------------------------------------
# tools


@dataclasses.dataclass(frozen=True)
class Csmith:
    binary: Path
    version: str
    include: Path


@dataclasses.dataclass(frozen=True)
class Reference:
    binary: Path
    version: str

    @property
    def name(self) -> str:
        return self.binary.name


def first_line_of_version(
    binary: Path, fallback: str, cwd: str | None = None
) -> str:
    try:
        out = subprocess.run(
            [str(binary), "--version"], capture_output=True, text=True, cwd=cwd
        ).stdout
    except OSError:
        return fallback
    return out.strip().splitlines()[0] if out.strip() else fallback


def csmith_version(binary: Path) -> str:
    """Ask the generator its version from a scratch directory.

    csmith writes `platform.info` into its working directory on every
    invocation, `--version` and `--help` included, so asking it anything from
    the repository leaves that file in the tree.
    """
    with tempfile.TemporaryDirectory() as scratch:
        return first_line_of_version(binary, "csmith (version unknown)", scratch)


def include_candidates(binary: Path, version: str) -> list[Path]:
    """Where csmith's runtime headers sit, in probe order.

    Homebrew puts them under the cellar's `include/csmith-<v>`, Debian and
    Ubuntu in `libcsmith-dev` at `/usr/include/csmith`, a source build under
    the prefix given to `configure`.
    """
    stamp = version.split()[-1] if version.split() else ""
    prefix = binary.resolve().parent.parent
    names = [f"csmith-{stamp}", "csmith"] if stamp else ["csmith"]
    roots = [prefix / "include", Path("/usr/include"), Path("/usr/local/include")]
    out = [root / name for root in roots for name in names]
    out.extend([prefix / "share" / n / "runtime" for n in names])
    return out


def find_csmith(binary: str | None, include: str | None) -> Csmith | None:
    found = binary or shutil.which("csmith")
    if not found or not Path(found).exists():
        return None
    path = Path(found).resolve()
    version = csmith_version(path)
    named = include or os.environ.get("CSMITH_INCLUDE")
    probe = [Path(named)] if named else include_candidates(path, version)
    for candidate in probe:
        if (candidate / "csmith.h").is_file():
            return Csmith(path, version, candidate)
    return None


def missing_csmith(explicit: str | None, include: str | None = None) -> str:
    """Say which half is missing: the generator or its runtime headers."""
    found = explicit or shutil.which("csmith")
    if not found or not Path(found).exists():
        return "csmith not found (Debian and Ubuntu: the `csmith` package)"
    path = Path(found).resolve()
    named = include or os.environ.get("CSMITH_INCLUDE")
    probe = (
        [Path(named)] if named else include_candidates(path, csmith_version(path))
    )
    looked = ", ".join(str(p) for p in probe)
    return (
        f"{path} has no csmith.h beside it (Debian and Ubuntu: the "
        f"`libcsmith-dev` package; --csmith-include or $CSMITH_INCLUDE names "
        f"the directory). Looked in: {looked}"
    )


def find_badc(explicit: str | None) -> Path | None:
    """The compiler under test, as an absolute path: cases run elsewhere."""
    if explicit:
        return Path(explicit).resolve() if Path(explicit).exists() else None
    for candidate in (
        REPO_ROOT / "target" / "release" / "badc",
        REPO_ROOT / "target" / "debug" / "badc",
    ):
        if candidate.exists():
            return candidate.resolve()
    found = shutil.which("badc")
    return Path(found).resolve() if found else None


def find_reference(explicit: str | None) -> Reference | None:
    names = [explicit] if explicit else ["clang", "gcc", "cc"]
    for name in names:
        found = shutil.which(name) if name else None
        if not found:
            continue
        path = Path(found).resolve()
        return Reference(path, first_line_of_version(path, name))
    return None


def tool_version(binary: Path) -> str:
    return first_line_of_version(binary, str(binary))


# --------------------------------------------------------------------------
# one case


@dataclasses.dataclass
class Step:
    argv: list[str]
    status: int | None
    seconds: float
    stdout: str
    stderr: str
    timed_out: bool

    @property
    def ok(self) -> bool:
        return self.status == 0

    def command(self) -> str:
        return " ".join(self.argv)


@dataclasses.dataclass
class Finding:
    verdict: str
    config: str
    seed: int
    detail: str
    evidence: str
    key: str
    human: str
    source: Path
    lines: int
    confirmed: bool = True


@dataclasses.dataclass
class CaseResult:
    seed: int
    lines: int
    seconds: float
    skip: str | None = None
    findings: list[Finding] = dataclasses.field(default_factory=list)
    steps: list[Step] = dataclasses.field(default_factory=list)


def run_command(
    argv: list[str], cwd: Path, timeout: float, env: dict[str, str] | None = None
) -> Step:
    started = time.monotonic()
    proc = subprocess.Popen(
        argv,
        cwd=str(cwd),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        errors="replace",
        env=env,
        start_new_session=os.name == "posix",
    )
    try:
        out, err = proc.communicate(timeout=timeout)
        return Step(argv, proc.returncode, time.monotonic() - started, out, err, False)
    except subprocess.TimeoutExpired:
        if os.name == "posix":
            with contextlib.suppress(ProcessLookupError):
                os.killpg(proc.pid, signal.SIGKILL)
        else:
            proc.kill()
        out, err = proc.communicate()
        return Step(argv, None, time.monotonic() - started, out, err, True)


def extract_checksum(text: str) -> str | None:
    found = CHECKSUM_RE.search(text)
    return found.group(1).upper() if found else None


def panic_site(text: str) -> tuple[str, str] | None:
    """The `file:line:col` and the message of a Rust panic, if one is there."""
    found = PANIC_RE.search(text)
    if not found:
        return None
    location = found.group(1)
    message = found.group(2).strip()
    if not message:
        tail = text[found.end() :].strip().splitlines()
        message = tail[0].strip() if tail else ""
    return location, message


def diagnostic_code(text: str) -> str | None:
    found = DIAG_CODE_RE.search(text)
    return found.group(1) if found else None


def first_error_line(text: str) -> str:
    """The diagnostic itself, which separates a rejection from an ICE."""
    for line in text.splitlines():
        if "error" in line:
            return line.strip()[:200]
    return ""


def normalize_message(message: str) -> str:
    """Drop what varies between two hits of the same defect.

    Indices, lengths and addresses differ per case; the shape of the message
    does not. Paths are stripped to their file name for the same reason.
    """
    text = re.sub(r"0x[0-9a-fA-F]+", "0xN", message)
    text = re.sub(r"\b\d+\b", "N", text)
    text = re.sub(r"[`'\"][^`'\"]*[`'\"]", "S", text)
    text = re.sub(r"\S*/([A-Za-z0-9_.+-]+\.(?:c|h|rs|o))", r"\1", text)
    return " ".join(text.split())[:200]


def signature_of(arch: str, parts: list[str]) -> tuple[str, str]:
    human = " ".join(parts)
    key = hashlib.sha256(f"{arch}|{human}".encode()).hexdigest()[:12]
    return key, human


def compile_argv(
    compiler: Path, config: str, include: Path, source: str, output: str
) -> list[str]:
    return [
        str(compiler),
        config,
        "-w",
        "-I",
        str(include),
        "-o",
        output,
        source,
    ]


@dataclasses.dataclass(frozen=True)
class Limits:
    generate: float
    compile: float
    run: float
    reference_run: float


def generate(csmith: Csmith, seed: int, workdir: Path, limits: Limits) -> Step:
    """Emit one program into `workdir`.

    The working directory is the case's own: csmith writes `platform.info` into
    it rather than beside the `-o` path, and a run from the repository root
    leaves that file behind.
    """
    argv = [str(csmith.binary), "--seed", str(seed), *GENERATION_BOUNDS, "-o", "case.c"]
    return run_command(argv, workdir, limits.generate)


def run_case(
    seed: int,
    root: Path,
    csmith: Csmith,
    badc: Path,
    reference: Reference | None,
    limits: Limits,
    arch: str,
) -> CaseResult:
    started = time.monotonic()
    workdir = root / f"case-{seed}"
    workdir.mkdir(parents=True, exist_ok=True)
    source = workdir / "case.c"
    steps: list[Step] = []

    step = generate(csmith, seed, workdir, limits)
    steps.append(step)
    if not step.ok or not source.is_file():
        return CaseResult(seed, 0, time.monotonic() - started, "generator failed", steps=steps)
    lines = len(source.read_text(errors="replace").splitlines())

    expected: str | None = None
    if reference is not None:
        gate = build_and_run(
            reference.binary,
            REFERENCE_GATE,
            workdir,
            csmith.include,
            limits,
            limits.reference_run,
            tag=reference.name,
        )
        steps.extend(gate.steps)
        if gate.checksum is None:
            reason = gate.skip or "printed no checksum"
            return CaseResult(
                seed,
                lines,
                time.monotonic() - started,
                f"reference {reason}",
                steps=steps,
            )
        expected = gate.checksum

    env = dict(os.environ, RUST_BACKTRACE="1")
    outcomes = {}
    for config in CONFIGS:
        outcome = build_and_run(
            badc, config, workdir, csmith.include, limits, limits.run, env=env
        )
        steps.extend(outcome.steps)
        outcomes[config] = outcome

    if expected is None:
        checksums = {c: o.checksum for c, o in outcomes.items() if o.checksum}
        if len(set(checksums.values())) == 1 and len(checksums) == len(CONFIGS):
            expected = next(iter(checksums.values()))

    findings = classify(seed, arch, outcomes, expected, source, lines)
    findings = [
        f
        for f in findings
        if confirm(f, reference, workdir, csmith, limits, expected, steps)
    ]
    findings = merge_by_signature(findings)
    for finding in findings:
        kept = root / "findings" / f"{finding.key}-seed-{seed}.c"
        kept.parent.mkdir(parents=True, exist_ok=True)
        if not kept.exists():
            shutil.copyfile(source, kept)
        finding.source = kept
    return CaseResult(seed, lines, time.monotonic() - started, None, findings, steps)


@dataclasses.dataclass
class Outcome:
    config: str
    compile_step: Step
    run_step: Step | None
    checksum: str | None
    skip: str | None
    steps: list[Step]


def build_and_run(
    compiler: Path,
    config: str,
    workdir: Path,
    include: Path,
    limits: Limits,
    run_timeout: float,
    env: dict[str, str] | None = None,
    tag: str = "badc",
) -> Outcome:
    # The output name carries the compiler as well as the level: the
    # reference's gate build and badc's are both at `-O0`, and one name for
    # both would leave a stale binary standing in for a build that produced
    # none.
    binary = f"case-{tag}{config}"
    argv = compile_argv(compiler, config, include, "case.c", binary)
    (workdir / binary).unlink(missing_ok=True)
    built = run_command(argv, workdir, limits.compile, env)
    if not built.ok or not (workdir / binary).exists():
        reason = "compile timed out" if built.timed_out else "compile failed"
        return Outcome(config, built, None, None, reason, [built])
    ran = run_command([f"./{binary}"], workdir, run_timeout)
    checksum = extract_checksum(ran.stdout) if ran.ok else None
    skip = None if ran.ok else ("run timed out" if ran.timed_out else "run failed")
    return Outcome(config, built, ran, checksum, skip, [built, ran])


def classify(
    seed: int,
    arch: str,
    outcomes: dict[str, Outcome],
    expected: str | None,
    source: Path,
    lines: int,
) -> list[Finding]:
    """Every way a case can be a defect, with the signature each is keyed by."""
    findings: list[Finding] = []

    def record(
        verdict: str,
        config: str,
        parts: list[str],
        detail: str,
        step: Step | None = None,
    ) -> None:
        key, human = signature_of(arch, parts)
        findings.append(
            Finding(
                verdict,
                config,
                seed,
                detail,
                evidence_of(step) if step else "",
                key,
                human,
                source,
                lines,
            )
        )

    for config, outcome in outcomes.items():
        built = outcome.compile_step
        if built.timed_out:
            record(
                "compile-timeout",
                config,
                ["compile-timeout", config],
                f"did not finish compiling in {built.seconds:.0f}s",
                built,
            )
            continue
        if not built.ok:
            panic = panic_site(built.stderr)
            if panic:
                location, message = panic
                record(
                    "compile-panic",
                    config,
                    ["panic", location, normalize_message(message)],
                    f"panicked: {message}",
                    built,
                )
            else:
                text = built.stderr + built.stdout
                code = diagnostic_code(text) or "no-code"
                said = first_error_line(text) or f"exit {built.status}"
                record(
                    "compile-error",
                    config,
                    ["compile-error", code],
                    f"rejected the program: {said}",
                    built,
                )
            continue

        ran = outcome.run_step
        assert ran is not None
        status = ran.status or 0
        if ran.timed_out:
            record(
                "run-timeout",
                config,
                ["run-timeout", config],
                f"the binary did not finish in {ran.seconds:.0f}s",
                ran,
            )
        elif status < 0:
            record(
                "run-signal",
                config,
                ["run-signal", str(-status), config],
                f"the binary died on signal {-status}",
                ran,
            )
        elif status != 0:
            record(
                "run-exit",
                config,
                ["run-exit", str(status), config],
                f"the binary exited {status}",
                ran,
            )
        elif outcome.checksum is None:
            record(
                "checksum-missing",
                config,
                ["checksum-missing", config],
                "the binary printed no checksum",
                ran,
            )

    if expected is not None:
        # One finding per set of configurations that disagree: that `-O` alone
        # is wrong and that both are wrong are different defects.
        wrong = sorted(
            c
            for c, o in outcomes.items()
            if o.checksum is not None and o.checksum != expected
        )
        if wrong:
            got = ", ".join(f"{c} = {outcomes[c].checksum}" for c in wrong)
            record(
                "checksum-mismatch",
                ",".join(wrong),
                ["checksum-mismatch", ",".join(wrong)],
                f"checksum {got}, expected {expected}",
            )
    return findings


def merge_by_signature(findings: list[Finding]) -> list[Finding]:
    """One entry per signature per case, naming every configuration that hit it.

    A front-end panic fires at `-O0` and at `-O`; that both reach it is triage
    information, and two comments for it are not.
    """
    merged: dict[str, Finding] = {}
    for finding in findings:
        first = merged.get(finding.key)
        if first is None:
            merged[finding.key] = finding
            continue
        configs = first.config.split(",") + finding.config.split(",")
        first.config = ",".join(dict.fromkeys(configs))
    return list(merged.values())


def evidence_of(step: Step) -> str:
    text = (step.stderr or "") + (step.stdout or "")
    kept = text.strip().splitlines()[:EVIDENCE_LINES]
    if len(text.strip().splitlines()) > EVIDENCE_LINES:
        kept.append(f"... [{len(text.splitlines()) - EVIDENCE_LINES} more lines]")
    return "\n".join(kept)


def confirm(
    finding: Finding,
    reference: Reference | None,
    workdir: Path,
    csmith: Csmith,
    limits: Limits,
    expected: str | None,
    steps: list[Step],
) -> bool:
    """Drop a runtime finding the reference cannot reproduce at `-O2`.

    A reference that disagrees with itself between the two levels is either
    optimising a program csmith did not keep free of undefined behaviour or
    wrong itself; either way the case says nothing about badc.
    """
    if finding.verdict not in RUNTIME_VERDICTS or reference is None:
        return True
    again = build_and_run(
        reference.binary,
        REFERENCE_CONFIRM,
        workdir,
        csmith.include,
        limits,
        limits.reference_run,
        tag=reference.name,
    )
    steps.extend(again.steps)
    if again.checksum is None:
        finding.detail += (
            f" (dropped: {reference.name} {REFERENCE_CONFIRM} {again.skip})"
        )
        return False
    if expected is not None and again.checksum != expected:
        finding.detail += (
            f" (dropped: {reference.name} {REFERENCE_CONFIRM} = {again.checksum},"
            f" {REFERENCE_GATE} = {expected})"
        )
        return False
    return True


# --------------------------------------------------------------------------
# the run


@dataclasses.dataclass
class Run:
    arch: str
    started: dt.datetime
    csmith: str
    badc: str
    reference: str
    reference_name: str
    bounds: str
    cases: int = 0
    skipped: dict[str, int] = dataclasses.field(default_factory=dict)
    findings: list[Finding] = dataclasses.field(default_factory=list)
    repeats: dict[str, int] = dataclasses.field(default_factory=dict)
    seconds: float = 0.0
    lines: list[int] = dataclasses.field(default_factory=list)


def fuzz(
    run: Run,
    root: Path,
    csmith: Csmith,
    badc: Path,
    reference: Reference | None,
    limits: Limits,
    minutes: float,
    max_cases: int,
    jobs: int,
    rng: random.Random,
    seeds: list[int] | None = None,
) -> None:
    queue = list(seeds or [])
    deadline = time.monotonic() + minutes * 60.0
    seen: dict[str, Finding] = {}
    started = time.monotonic()
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as pool:
        pending: set[concurrent.futures.Future[CaseResult]] = set()
        while True:
            while (
                len(pending) < jobs
                and (queue if seeds else time.monotonic() < deadline)
                and (max_cases == 0 or run.cases + len(pending) < max_cases)
            ):
                seed = queue.pop(0) if seeds else rng.randrange(1, 2**31 - 1)
                pending.add(
                    pool.submit(
                        run_case, seed, root, csmith, badc, reference, limits, run.arch
                    )
                )
            if not pending:
                break
            done, pending = concurrent.futures.wait(
                pending, return_when=concurrent.futures.FIRST_COMPLETED
            )
            for future in done:
                try:
                    result = future.result()
                except Exception as error:  # one broken case, not the run
                    run.cases += 1
                    reason = f"harness error: {type(error).__name__}: {error}"
                    run.skipped[reason] = run.skipped.get(reason, 0) + 1
                    continue
                run.cases += 1
                run.lines.append(result.lines)
                if result.skip:
                    run.skipped[result.skip] = run.skipped.get(result.skip, 0) + 1
                for finding in result.findings:
                    if finding.key in seen:
                        run.repeats[finding.key] = run.repeats.get(finding.key, 0) + 1
                        continue
                    seen[finding.key] = finding
                    run.findings.append(finding)
                    print(
                        f"finding {finding.key} {finding.verdict}"
                        f" seed {finding.seed}: {finding.detail}",
                        flush=True,
                    )
    run.seconds = time.monotonic() - started


# --------------------------------------------------------------------------
# reporting


def weekly_window(day: dt.date) -> tuple[dt.date, dt.date]:
    monday = day - dt.timedelta(days=day.weekday())
    return monday, monday + dt.timedelta(days=6)


def weekly_title(day: dt.date) -> str:
    start, end = weekly_window(day)
    return f"compiler fuzzing, {start.isoformat()}...{end.isoformat()}"


def weekly_issue_body(day: dt.date, run: Run) -> str:
    start, end = weekly_window(day)
    iso = day.isocalendar()
    return "\n".join(
        [
            f"Findings from the daily `csmith-fuzz` workflow for ISO week "
            f"{iso.year}-W{iso.week:02d} (UTC {start.isoformat()} through "
            f"{end.isoformat()}).",
            "",
            "One comment per distinct finding. The signature in a comment is "
            "what deduplicates: a case that reaches a signature already on this "
            "issue is counted in the job summary and not commented again, so "
            "the issue holds one entry per defect per architecture rather than "
            "one per case.",
            "",
            f"Each comment links the offending translation unit, kept unreduced "
            f"as an asset of the `{CASE_STORE_TAG}` release. A seed reproduces "
            f"only against the same generator, so every comment names its "
            f"csmith version.",
            "",
            "Harness: `scripts/csmith_fuzz.py`. Reducer: `scripts/c_reduce.py`.",
        ]
    )


def asset_name(day: dt.date, arch: str, key: str, seed: int) -> str:
    iso = day.isocalendar()
    return f"{iso.year}-W{iso.week:02d}-{arch}-{key}-seed-{seed}.c"


def asset_url(repo: str, name: str) -> str:
    return f"https://github.com/{repo}/releases/download/{CASE_STORE_TAG}/{name}"


def repro_commands(run: Run, finding: Finding, csmith: Csmith | None) -> str:
    """Generate the case and build it the way the finding was reached.

    A compile-time verdict needs the compile alone; a verdict about what the
    program did needs the runs and the reference's answer beside them.
    """
    bounds = " ".join(GENERATION_BOUNDS)
    include = str(csmith.include) if csmith else "$CSMITH_INCLUDE"
    runtime = not finding.verdict.startswith("compile-")
    lines = [f"csmith --seed {finding.seed} {bounds} -o case.c"]
    if runtime and run.reference_name:
        lines.append(
            f'{run.reference_name} {REFERENCE_GATE} -w -I "{include}"'
            " -o case-ref case.c && ./case-ref"
        )
    for config in finding.config.split(","):
        build = f'badc {config} -w -I "{include}" -o case{config} case.c'
        lines.append(f"{build} && ./case{config}" if runtime else build)
    return "\n".join(lines)


def finding_comment(
    run: Run,
    finding: Finding,
    day: dt.date,
    repo: str,
    where: str,
    csmith: Csmith | None,
) -> str:
    url = asset_url(repo, asset_name(day, run.arch, finding.key, finding.seed))
    configs = ", ".join(f"`{c}`" for c in finding.config.split(","))
    rows = [
        ("verdict", f"`{finding.verdict}`"),
        ("configuration", f"badc {configs}"),
        ("architecture", f"`{run.arch}`"),
        ("run", where),
        ("compiler", f"`{run.badc}`"),
        ("generator", f"`{run.csmith}`"),
        ("reference", f"`{run.reference}`"),
        ("seed", f"`{finding.seed}`"),
        ("case", f"[{finding.lines} lines, unreduced]({url})"),
        ("signature", f"`{finding.key}`"),
    ]
    table = ["| | |", "|---|---|"]
    table += [f"| {name} | {value} |" for name, value in rows]
    out = [f"## badc {finding.config.replace(',', ', ')}: {finding.detail}"]
    out += ["", *table, "", "Reproduce:", "", "```sh"]
    out += [repro_commands(run, finding, csmith), "```"]
    if finding.evidence:
        out += ["", "Compiler output, `RUST_BACKTRACE=1`:", "", "```", finding.evidence, "```"]
    out += [
        "",
        f"signature: {finding.key} ({finding.human})",
    ]
    return "\n".join(out)


def summary_markdown(run: Run, publishing: str) -> str:
    median = sorted(run.lines)[len(run.lines) // 2] if run.lines else 0
    rows = [
        ("architecture", run.arch),
        ("cases", str(run.cases)),
        ("wall clock", f"{run.seconds:.0f}s"),
        ("cases per minute", f"{run.cases / max(run.seconds / 60.0, 1e-9):.0f}"),
        ("median lines", str(median)),
        ("findings (distinct)", str(len(run.findings))),
        ("repeats", str(sum(run.repeats.values()))),
        ("skipped", str(sum(run.skipped.values()))),
        ("generator", run.csmith),
        ("compiler", run.badc),
        ("reference", run.reference),
        ("bounds", f"`{run.bounds}`"),
        ("reporting", publishing),
    ]
    out = ["## csmith fuzzing", "", "| | |", "|---|---|"]
    out += [f"| {name} | {value} |" for name, value in rows]
    if run.skipped:
        out += ["", "Skipped:", ""]
        out += [f"* {count} x {reason}" for reason, count in sorted(run.skipped.items())]
    if run.findings:
        out += ["", "| signature | verdict | configuration | seed | repeats |", "|---|---|---|---|---|"]
        for finding in run.findings:
            out.append(
                f"| `{finding.key}` | {finding.verdict} | `{finding.config}` |"
                f" {finding.seed} | {run.repeats.get(finding.key, 0)} |"
            )
    else:
        out += ["", "No findings."]
    return "\n".join(out) + "\n"


def report_json(run: Run, day: dt.date, repo: str) -> str:
    return json.dumps(
        {
            "arch": run.arch,
            "started": run.started.isoformat(),
            "week": weekly_title(day),
            "cases": run.cases,
            "seconds": round(run.seconds, 1),
            "median_lines": sorted(run.lines)[len(run.lines) // 2] if run.lines else 0,
            "csmith": run.csmith,
            "badc": run.badc,
            "reference": run.reference,
            "bounds": run.bounds,
            "skipped": run.skipped,
            "repeats": run.repeats,
            "findings": [
                {
                    "signature": f.key,
                    "human": f.human,
                    "verdict": f.verdict,
                    "config": f.config,
                    "seed": f.seed,
                    "detail": f.detail,
                    "lines": f.lines,
                    "asset": asset_name(day, run.arch, f.key, f.seed),
                    "evidence": f.evidence,
                }
                for f in run.findings
            ],
        },
        indent=2,
    )


# --------------------------------------------------------------------------
# publishing


class Gh:
    """`gh` invocations. Reads run either way; writes only with `--publish`."""

    def __init__(self, repo: str, publish: bool) -> None:
        self.repo = repo
        self.publish = publish
        self.binary = shutil.which("gh")
        self.planned: list[str] = []

    @property
    def available(self) -> bool:
        return self.binary is not None

    def read(self, argv: list[str]) -> str | None:
        if not self.available:
            return None
        full = [self.binary or "gh", *argv, "--repo", self.repo]
        done = subprocess.run(full, capture_output=True, text=True)
        return done.stdout if done.returncode == 0 else None

    def write(self, argv: list[str], stdin: str | None = None) -> str:
        full = ["gh", *argv, "--repo", self.repo]
        self.planned.append(" ".join(full))
        if not self.publish:
            print(f"would run: {' '.join(full)}")
            if stdin:
                print("--- body ---")
                print(stdin)
                print("--- end body ---")
            return ""
        done = subprocess.run(
            [self.binary or "gh", *argv, "--repo", self.repo],
            input=stdin,
            capture_output=True,
            text=True,
        )
        if done.returncode != 0:
            raise RuntimeError(f"{' '.join(full)}: {done.stderr.strip()}")
        return done.stdout.strip()


def open_weekly_issue(gh: Gh, title: str) -> int | None:
    raw = gh.read(["issue", "list", "--state", "open", "--limit", "100", "--json", "number,title"])
    if raw is None:
        return None
    for entry in json.loads(raw):
        if entry["title"] == title:
            return int(entry["number"])
    return None


def known_signatures(bodies: list[str]) -> set[str]:
    return {found for body in bodies for found in SIGNATURE_RE.findall(body)}


def issue_signatures(gh: Gh, number: int) -> set[str]:
    raw = gh.read(["issue", "view", str(number), "--json", "body,comments"])
    if raw is None:
        return set()
    data = json.loads(raw)
    bodies = [data.get("body") or ""]
    bodies += [c.get("body") or "" for c in data.get("comments", [])]
    return known_signatures(bodies)


def ensure_case_store(gh: Gh) -> None:
    if gh.read(["release", "view", CASE_STORE_TAG]) is not None:
        return
    notes = (
        "Unreduced csmith translation units that made `badc` crash, reject a "
        "valid program or compute the wrong answer. Uploaded by "
        "`scripts/csmith_fuzz.py`; each case is linked from a weekly "
        "`compiler fuzzing, ...` issue."
    )
    gh.write(
        [
            "release",
            "create",
            CASE_STORE_TAG,
            "--title",
            "csmith cases",
            "--notes",
            notes,
            "--latest=false",
        ]
    )


def publish(
    run: Run, gh: Gh, day: dt.date, where: str, csmith: Csmith | None, cases: Path
) -> int:
    title = weekly_title(day)
    number = open_weekly_issue(gh, title)
    already = issue_signatures(gh, number) if number is not None else set()
    fresh = [f for f in run.findings if f.key not in already]
    for finding in run.findings:
        if finding.key in already:
            run.repeats[finding.key] = run.repeats.get(finding.key, 0) + 1
    if not fresh:
        print(f"no new signatures for {title}; nothing to file")
        return 0

    ensure_case_store(gh)
    target = str(number)
    if number is None:
        out = gh.write(
            ["issue", "create", "--title", title, "--label", ISSUE_LABEL,
             "--body-file", "-"],
            stdin=weekly_issue_body(day, run),
        )
        target = out.rstrip("/").rsplit("/", 1)[-1] if out else "<new issue>"
        print(f"weekly issue: {out or title + ' (would be opened)'}")

    for finding in fresh:
        name = asset_name(day, run.arch, finding.key, finding.seed)
        staged = cases / name
        if finding.source.exists() and not staged.exists():
            staged.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(finding.source, staged)
        gh.write(["release", "upload", CASE_STORE_TAG, str(staged), "--clobber"])
        gh.write(
            ["issue", "comment", target, "--body-file", "-"],
            stdin=finding_comment(run, finding, day, gh.repo, where, csmith),
        )
    return len(fresh)


def detect_repo(explicit: str | None) -> str:
    if explicit:
        return explicit
    env = os.environ.get("GITHUB_REPOSITORY")
    if env:
        return env
    url = subprocess.run(
        ["git", "-C", str(REPO_ROOT), "remote", "get-url", "origin"],
        capture_output=True,
        text=True,
    ).stdout.strip()
    match = re.search(r"[:/]([^/:]+/[^/]+?)(?:\.git)?$", url)
    return match.group(1) if match else "kromych/badc"


def run_location() -> str:
    run_id = os.environ.get("GITHUB_RUN_ID")
    if run_id:
        server = os.environ.get("GITHUB_SERVER_URL", "https://github.com")
        repo = os.environ.get("GITHUB_REPOSITORY", "")
        runner = os.environ.get("RUNNER_OS", "")
        image = os.environ.get("ImageOS", "")
        label = f" ({runner} {image})".rstrip() if runner or image else ""
        return f"[{run_id}]({server}/{repo}/actions/runs/{run_id}){label}"
    return f"local run on {platform.node()}"


# --------------------------------------------------------------------------
# self-test


def self_test() -> int:
    failures: list[str] = []

    def check(name: str, got: object, want: object) -> None:
        if got != want:
            failures.append(f"{name}: got {got!r}, want {want!r}")

    check(
        "weekly title mid-week",
        weekly_title(dt.date(2026, 9, 17)),
        "compiler fuzzing, 2026-09-14...2026-09-20",
    )
    check(
        "weekly title on the Monday",
        weekly_title(dt.date(2026, 9, 14)),
        "compiler fuzzing, 2026-09-14...2026-09-20",
    )
    check(
        "weekly title on the Sunday",
        weekly_title(dt.date(2026, 9, 20)),
        "compiler fuzzing, 2026-09-14...2026-09-20",
    )
    check(
        "weekly title across new year",
        weekly_title(dt.date(2027, 1, 1)),
        "compiler fuzzing, 2026-12-28...2027-01-03",
    )
    check(
        "asset name",
        asset_name(dt.date(2026, 9, 17), "x86_64", "0123456789ab", 42),
        "2026-W38-x86_64-0123456789ab-seed-42.c",
    )

    panic = (
        "thread 'main' panicked at src/c5/front/init.rs:812:37:\n"
        "index out of bounds: the len is 3 but the index is 7\n"
        "stack backtrace:\n   0: rust_begin_unwind\n"
    )

    def panic_key(text: str) -> str:
        location, message = panic_site(text) or ("", "")
        return signature_of("x86_64", ["panic", location, normalize_message(message)])[0]

    site = panic_site(panic)
    check("panic location", site[0] if site else None, "src/c5/front/init.rs:812:37")
    check(
        "panic message",
        normalize_message(site[1]) if site else None,
        "index out of bounds: the len is N but the index is N",
    )
    other = panic.replace("len is 3 but the index is 7", "len is 9 but the index is 11")
    check("one defect keeps one signature", panic_key(other), panic_key(panic))
    moved = panic.replace("init.rs:812:37", "init.rs:913:5")
    check(
        "a different site is a different signature",
        panic_key(moved) != panic_key(panic),
        True,
    )
    check(
        "architecture separates signatures",
        signature_of("aarch64", ["run-timeout", "-O"])[0]
        != signature_of("x86_64", ["run-timeout", "-O"])[0],
        True,
    )
    check("no panic", panic_site("error: bad expression [B2020]"), None)
    check(
        "diagnostic code",
        diagnostic_code("case.c:7: error: bad expression: got `;` [B2020] [syntax]"),
        "B2020",
    )
    check("checksum", extract_checksum("...\nchecksum = 5c574cdb\n"), "5C574CDB")
    check("no checksum", extract_checksum("checksum ="), None)

    key, human = signature_of("x86_64", ["panic", "src/c5/front/init.rs:812:37", "boom"])
    run = Run(
        arch="x86_64",
        started=dt.datetime(2026, 9, 17, 3, 41),
        csmith="csmith 2.3.0",
        badc="badc 0.4.4",
        reference="clang 21.0.0",
        reference_name="clang",
        bounds=" ".join(GENERATION_BOUNDS),
    )
    finding = Finding(
        "compile-panic",
        "-O0",
        4177298122,
        "panicked: index out of bounds",
        "thread 'main' panicked at src/c5/front/init.rs:812:37:",
        key,
        human,
        Path("case.c"),
        652,
    )
    run.findings.append(finding)
    comment = finding_comment(
        run, finding, dt.date(2026, 9, 17), "kromych/badc", "local", None
    )
    check("comment carries its signature", known_signatures([comment]), {key})
    check("comment links the case", asset_url("kromych/badc", asset_name(dt.date(2026, 9, 17), "x86_64", key, 4177298122)) in comment, True)
    check("comment names the seed", "4177298122" in comment, True)
    check("summary lists the finding", key in summary_markdown(run, "dry run"), True)
    check(
        "dedup reads a signature out of prose",
        known_signatures(["nothing here", f"| signature | `{key}` |"]),
        {key},
    )
    check("dedup ignores hex that is not a signature", known_signatures(["0x00007fff1234abcd"]), set())
    json.loads(report_json(run, dt.date(2026, 9, 17), "kromych/badc"))

    gh = Gh("kromych/badc", publish=False)
    gh.write(["issue", "comment", "7", "--body-file", "-"], stdin="body")
    check(
        "gh argv names the repository and reads the body from stdin",
        gh.planned[-1],
        "gh issue comment 7 --body-file - --repo kromych/badc",
    )
    check("dry run holds no token", "token" not in " ".join(gh.planned).lower(), True)

    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp).resolve()
        headers = root / "include" / "csmith-2.3.0"
        headers.mkdir(parents=True)
        (headers / "csmith.h").write_text("")
        (root / "bin").mkdir()
        binary = root / "bin" / "csmith"
        binary.write_text("#!/bin/sh\necho 'csmith 2.3.0'\n")
        binary.chmod(0o755)
        check(
            "include probe finds the versioned directory",
            headers in include_candidates(binary, "csmith 2.3.0"),
            True,
        )
        found = find_csmith(str(binary), None)
        check("csmith is taken with its headers", found.include if found else None, headers)

    outcomes = {
        "-O0": Outcome("-O0", Step([], 0, 0.1, "", "", False), Step([], 0, 0.1, "checksum = AA\n", "", False), "AA", None, []),
        "-O": Outcome("-O", Step([], 0, 0.1, "", "", False), Step([], 0, 0.1, "checksum = BB\n", "", False), "BB", None, []),
    }
    verdicts = [f.verdict for f in classify(1, "x86_64", outcomes, "AA", Path("case.c"), 10)]
    check("a wrong checksum is one finding", verdicts, ["checksum-mismatch"])
    outcomes["-O"] = Outcome(
        "-O",
        Step([], None, 60.0, "", "", True),
        None,
        None,
        "compile timed out",
        [],
    )
    verdicts = [f.verdict for f in classify(1, "x86_64", outcomes, "AA", Path("case.c"), 10)]
    check("a compile timeout is a finding", verdicts, ["compile-timeout"])
    outcomes["-O"] = Outcome(
        "-O",
        Step([], 101, 0.1, "", "case.c:7: error: x [B2020] [syntax]", False),
        None,
        None,
        "compile failed",
        [],
    )
    findings = classify(1, "x86_64", outcomes, "AA", Path("case.c"), 10)
    check("a rejected program is a finding", [f.verdict for f in findings], ["compile-error"])
    check("its signature names the diagnostic", "B2020" in findings[0].human, True)
    check("its detail quotes the diagnostic", "error: x" in findings[0].detail, True)
    outcomes["-O"] = Outcome(
        "-O",
        Step([], 0, 0.1, "", "", False),
        Step([], -11, 0.1, "", "", False),
        None,
        None,
        [],
    )
    check(
        "a signal is a finding",
        [f.verdict for f in classify(1, "x86_64", outcomes, "AA", Path("case.c"), 10)],
        ["run-signal"],
    )

    failures.extend(generator_stays_out_of_the_tree())

    for failure in failures:
        print(f"FAIL {failure}")
    print(f"csmith_fuzz self-test: {'FAILED' if failures else 'ok'}")
    return 1 if failures else 0


def generator_stays_out_of_the_tree() -> list[str]:
    """csmith writes `platform.info` into its working directory.

    Every invocation does it, `--version` and `--help` included, so the check
    covers discovery as well as generation: both run from the repository root
    here, and neither may leave that file in the tree.
    """
    stray = REPO_ROOT / "platform.info"
    before = stray.exists()
    problems: list[str] = []
    here = os.getcwd()
    try:
        os.chdir(REPO_ROOT)
        csmith = find_csmith(None, None)
        if stray.exists() and not before:
            problems.append(f"finding the generator left {stray} in the repository")
            stray.unlink()
    finally:
        os.chdir(here)
    if csmith is None:
        print("csmith absent: the generator checks need it, skipping that part")
        return problems
    with tempfile.TemporaryDirectory() as tmp:
        workdir = Path(tmp)
        limits = Limits(generate=30.0, compile=60.0, run=20.0, reference_run=2.0)
        step = generate(csmith, 1, workdir, limits)
        if not step.ok:
            problems.append(f"generation failed: {step.stderr.strip()[:200]}")
        if not (workdir / "case.c").is_file():
            problems.append("the generated source is not in the scratch directory")
        if stray.exists() and not before:
            problems.append(f"the generator left {stray} in the repository")
        if not (workdir / "platform.info").is_file():
            problems.append("platform.info did not land in the scratch directory")
    if Path(tmp).exists():
        problems.append("the scratch directory outlived the run")
    return problems


# --------------------------------------------------------------------------


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--minutes", type=float, default=5.0, help="fuzzing budget")
    parser.add_argument("--cases", type=int, default=0, help="case cap, 0 for none")
    parser.add_argument("--jobs", type=int, default=0, help="cases in flight")
    parser.add_argument("--seed", type=int, default=0, help="seed the seed stream")
    parser.add_argument(
        "--case",
        type=int,
        action="append",
        default=[],
        help="run this csmith seed and stop; repeatable",
    )
    parser.add_argument("--badc", help="path to the compiler under test")
    parser.add_argument("--csmith", help="path to the generator")
    parser.add_argument("--csmith-include", help="directory holding csmith.h")
    parser.add_argument("--reference", help="reference compiler, or 'none'")
    parser.add_argument("--repo", help="owner/name for gh")
    parser.add_argument("--publish", action="store_true", help="file what was found")
    parser.add_argument("--report", help="write the run's JSON report here")
    parser.add_argument("--summary", help="write the job summary here")
    parser.add_argument("--out-dir", help="keep the offending sources here")
    parser.add_argument("--keep", action="store_true", help="keep the scratch tree")
    parser.add_argument("--fail-on-findings", action="store_true")
    parser.add_argument("--require-csmith", action="store_true")
    parser.add_argument("--compile-timeout", type=float, default=60.0)
    parser.add_argument("--run-timeout", type=float, default=10.0)
    # Over 120 bounded programs on an aarch64 host, every one that terminates
    # under `clang -O0` runs in under 5 ms and 12.5% do not terminate at all. A
    # one second cap clears the slowest measured case by 200x and is what the
    # budget spends on each non-terminating program.
    parser.add_argument("--reference-run-timeout", type=float, default=1.0)
    parser.add_argument("--generate-timeout", type=float, default=30.0)
    parser.add_argument("--self-test", action="store_true")
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    if args.self_test:
        return self_test()

    csmith = find_csmith(args.csmith, args.csmith_include)
    if csmith is None:
        message = missing_csmith(args.csmith, args.csmith_include)
        if args.require_csmith:
            print(f"error: {message}", file=sys.stderr)
            return 2
        print(f"{message}: skipping")
        return 0
    badc = find_badc(args.badc)
    if badc is None:
        print("error: badc not found; build it or pass --badc", file=sys.stderr)
        return 2
    reference = None if args.reference == "none" else find_reference(args.reference)

    day = dt.datetime.now(dt.timezone.utc).date()
    run = Run(
        arch=host_arch(),
        started=dt.datetime.now(dt.timezone.utc),
        csmith=csmith.version,
        badc=tool_version(badc),
        reference=(
            f"{reference.version} at {REFERENCE_GATE}"
            if reference
            else "none (badc -O0 vs -O only)"
        ),
        reference_name=reference.name if reference else "",
        bounds=" ".join(GENERATION_BOUNDS),
    )
    limits = Limits(
        generate=args.generate_timeout,
        compile=args.compile_timeout,
        run=args.run_timeout,
        reference_run=args.reference_run_timeout,
    )
    jobs = args.jobs or min(4, os.cpu_count() or 1)
    rng = random.Random(args.seed) if args.seed else random.SystemRandom()

    print(f"{run.csmith}, headers {csmith.include}")
    print(f"badc: {badc} ({run.badc})")
    print(f"reference: {run.reference}")
    budget = f"{len(args.case)} named seed(s)" if args.case else f"{args.minutes} min"
    print(f"{budget}, {jobs} cases in flight, arch {run.arch}")

    root = Path(tempfile.mkdtemp(prefix="badc-csmith-"))
    try:
        fuzz(
            run,
            root,
            csmith,
            badc,
            reference,
            limits,
            args.minutes,
            args.cases,
            jobs,
            rng,
            args.case or None,
        )
        cases = Path(args.out_dir) if args.out_dir else root / "store"
        repo = detect_repo(args.repo)
        gh = Gh(repo, args.publish)
        filed = 0
        if run.findings:
            if not gh.available and args.publish:
                print("error: gh not found; cannot file findings", file=sys.stderr)
                return 2
            try:
                filed = publish(run, gh, day, run_location(), csmith, cases)
            except RuntimeError as error:
                # The findings are in the summary and the report either way;
                # what failed is the filing, and it has to be visible.
                print(f"error: {error}", file=sys.stderr)
                print(summary_markdown(run, "not filed"))
                return 2
        mode = "filed" if args.publish else "dry run"
        summary = summary_markdown(run, f"{mode}, {filed} new signature(s)")
        print(summary)
        step_summary = args.summary or os.environ.get("GITHUB_STEP_SUMMARY")
        if step_summary:
            with open(step_summary, "a", encoding="utf-8") as handle:
                handle.write(summary)
        if args.report:
            Path(args.report).write_text(report_json(run, day, repo), encoding="utf-8")
    finally:
        if args.keep:
            print(f"scratch tree kept at {root}")
        else:
            shutil.rmtree(root, ignore_errors=True)
    return 1 if (args.fail_on_findings and run.findings) else 0


if __name__ == "__main__":
    sys.exit(main())
