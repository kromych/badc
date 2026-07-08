#!/usr/bin/env python3
"""Self-hosting cross-check: build CPython *and* NASM with badc, then run
NASM's golden test suite with the badc-built Python interpreter driving the
badc-built assembler.

Two independently non-trivial badc outputs cooperate: the interpreter runs the
suite harness (`travis/nasm-t.py`, which imports `subprocess` ->
`_posixsubprocess` and spawns processes), and the assembler it spawns is also
badc's. A codegen defect in either shows up as a failed golden comparison.

POSIX targets only: the harness needs `subprocess`, whose process-spawn
extension the badc-built interpreter provides on POSIX (`_posixsubprocess`).
"""

import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import smoke  # noqa: E402  (sibling module; provides badc_target + paths)

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]
PYDEMO = REPO / "demos" / "python"


def run(cmd: list[str], **kw) -> None:
    print(f"selfhost: $ {' '.join(cmd)}", flush=True)
    r = subprocess.run(cmd, **kw)
    if r.returncode != 0:
        sys.exit(f"selfhost FAIL: command exited {r.returncode}: {cmd}")


def main() -> int:
    target = os.environ.get("BADC_PY_TARGET") or smoke.badc_target()
    if smoke.IS_WIN:
        sys.exit("selfhost: POSIX targets only (harness needs _posixsubprocess)")

    # 1. Build the CPython interpreter with badc.
    run([sys.executable, str(PYDEMO / "setup.py")])
    run([sys.executable, str(PYDEMO / "build.py"), f"--target={target}", "--link"])
    pybin = PYDEMO / ".cache" / f"obj-{target}" / "python"
    srcs = sorted((PYDEMO / ".cache").glob("Python-*"))
    if not pybin.is_file() or not srcs:
        sys.exit("selfhost: badc-built python or its source tree not found")
    pysrc = srcs[-1]
    # Run the interpreter from a temp directory, not the checked-out workspace:
    # the hosted macOS runner refuses to execute binaries from the workspace
    # (build.py runs its own tests the same way). The interpreter locates its
    # stdlib via PYTHONHOME + a `Lib` symlink beside it; NASM_TEST_PYTHONHOME
    # scopes that to the harness subprocess (smoke.py stays on the host python).
    rundir = Path(tempfile.mkdtemp(prefix="badc-selfhost-"))
    try:
        exe = rundir / "python"
        shutil.copy2(pybin, exe)
        os.chmod(exe, 0o755)
        (rundir / "Lib").symlink_to(pysrc / "Lib")

        # 2 + 3. Build nasm with badc and run its golden suite, harness driven
        # by the badc-built interpreter.
        env = dict(os.environ,
                   NASM_TEST_PYTHON=str(exe),
                   NASM_TEST_PYTHONHOME=str(rundir))
        run([sys.executable, str(HERE / "smoke.py")], env=env)
    finally:
        shutil.rmtree(rundir, ignore_errors=True)
    print("selfhost: badc-built python drove the badc-built nasm golden suite OK",
          flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
