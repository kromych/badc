#!/usr/bin/env python3
"""Build edk2 firmware with badc as the C compiler (the self-host rung).

Registers a BADC toolchain tag whose X64 CC is badc (via the badc-efi-cc
wrapper) and runs the edk2 `build` for a platform / module. GenFw, the
linker, and NASM stay the standard GCC5 tools -- badc is the compiler.

The point is a reproducible probe: the firmware build compiles hundreds
of C modules, and this reports the first one badc cannot yet build (the
next self-host blocker) with the failing command and badc's diagnostic.
On a clean pass it reports the produced FV directory.

Point badc via $BADC (default: the release binary in this tree). NASM is
found on PATH or via $NASM_PREFIX. Reuses the edk2 checkout / BaseTools
build from build_ovmf.py's work dir when present.

Host requirements match build_ovmf.py: git, gcc, make, nasm, iasl, and
the uuid dev files GenFw/GenFv link and include (Debian/Ubuntu: uuid-dev;
Fedora: libuuid-devel). Without root, the dev files can be extracted from
the distro package and exposed via $CPATH / $LIBRARY_PATH.
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
EDK2_URL = "https://github.com/tianocore/edk2.git"
EDK2_TAG = "edk2-stable202508"
SUBMODULES = (
    "CryptoPkg/Library/OpensslLib/openssl",
    "CryptoPkg/Library/MbedTlsLib/mbedtls",
    "MdeModulePkg/Library/BrotliCustomDecompressLib/brotli",
    "BaseTools/Source/C/BrotliCompress/brotli",
    "MdePkg/Library/MipiSysTLib/mipisyst",
    "MdePkg/Library/BaseFdtLib/libfdt",
    "SecurityPkg/DeviceSecurity/SpdmLib/libspdm",
)
# Platform -> (arch, DSC). A single -m module can be passed to stop early.
PLATFORMS = {
    "ovmf": ("X64", "OvmfPkg/OvmfPkgX64.dsc"),
}


def run(cmd, cwd=None, env=None, check=True, capture=False):
    print(f"+ {' '.join(map(str, cmd))}", flush=True)
    return subprocess.run(
        cmd, cwd=cwd, env=env, check=check,
        text=True,
        stdout=subprocess.PIPE if capture else None,
        stderr=subprocess.STDOUT if capture else None,
    )


def patch_fv_layout(src: Path) -> None:
    """Enlarge OVMF's fixed firmware-volume / flash layout to hold badc's
    output. badc's -O codegen is larger than gcc -Os, so the PEIFV / DXEFV
    (decompressed in RAM) and SECFV (in flash) overflow the stock sizes and
    GenFv fails. Grow each region and cascade the flash size / base / block
    counts. Idempotent: a stock string is absent once patched, so a second
    run replaces nothing. Each stock string must be unique."""
    def sub(path: Path, pairs: list[tuple[str, str]]) -> None:
        text = path.read_text()
        for stock, grown in pairs:
            if grown in text:
                continue  # already patched
            if text.count(stock) != 1:
                raise SystemExit(
                    f"patch_fv_layout: {path.name}: {stock!r} not unique "
                    f"({text.count(stock)}); edk2 layout changed")
            text = text.replace(stock, grown)
        path.write_text(text)

    # RAM map (FD.MEMFD): PEIFV 0xD0000->0x200000, shift EarlyMemDebugLog and
    # DXEFV, grow DXEFV 0xE80000->0x1800000 and the MEMFD total.
    sub(src / "OvmfPkg" / "OvmfPkgX64.fdf", [
        ("0x020000|0x0D0000", "0x020000|0x200000"),
        ("0x0F0000|0x10000", "0x220000|0x10000"),
        ("0x100000|0xE80000", "0x230000|0x1800000"),
        ("Size          = 0xF80000", "Size          = 0x1A80000"),
        ("NumBlocks     = 0xF8\n", "NumBlocks     = 0x1A8\n"),
    ])
    # Flash (active 4 MB variant): SECFV 0x34000->0x40000; FVMAIN unchanged;
    # CODE = FVMAIN + SECFV; FW = VARS + CODE; FW_BASE = 4 GiB - FW_SIZE;
    # CODE_BASE = FW_BASE + VARS. SECFV stays at the flash top (reset vector).
    sub(src / "OvmfPkg" / "Include" / "Fdf" / "OvmfPkgDefines.fdf.inc", [
        ("FW_BASE_ADDRESS   = 0xFFC00000", "FW_BASE_ADDRESS   = 0xFFBF4000"),
        ("FW_SIZE           = 0x00400000", "FW_SIZE           = 0x0040C000"),
        ("FW_BLOCKS         = 0x400", "FW_BLOCKS         = 0x40C"),
        ("CODE_BASE_ADDRESS = 0xFFC84000", "CODE_BASE_ADDRESS = 0xFFC78000"),
        ("CODE_SIZE         = 0x0037C000", "CODE_SIZE         = 0x00388000"),
        ("CODE_BLOCKS       = 0x37C", "CODE_BLOCKS       = 0x388"),
        ("SECFV_SIZE        = 0x34000", "SECFV_SIZE        = 0x40000"),
    ])


def default_badc() -> str:
    exe = "badc.exe" if os.name == "nt" else "badc"
    cand = HERE.parents[1] / "target" / "release" / exe
    return str(cand) if cand.is_file() else exe


def first_badc_failure(log: str) -> str:
    """Extract the first module + badc diagnostic from a failed build log."""
    lines = log.splitlines()
    for i, ln in enumerate(lines):
        if "error:" in ln or "internal compiler error" in ln:
            ctx = lines[max(0, i - 6): i + 3]
            return "\n".join(ctx)
    # `build` prints a "Failed-to-execute" / module summary near the end.
    return "\n".join(lines[-25:])


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--platform", choices=sorted(PLATFORMS), default="ovmf")
    ap.add_argument("--module", default=None,
                    help="a single .inf to build (stops the build early)")
    ap.add_argument("--work", type=Path, default=HERE / ".ovmf-build")
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--badc", default=os.environ.get("BADC") or default_badc())
    args = ap.parse_args()
    arch, dsc = PLATFORMS[args.platform]
    work: Path = args.work
    src = work / "edk2"

    for tool in ("git", "gcc", "make"):
        if shutil.which(tool) is None:
            print(f"error: `{tool}` not on PATH", file=sys.stderr)
            return 1
    nasm = shutil.which("nasm") or (
        os.environ.get("NASM_PREFIX", "") + "nasm")
    if not (shutil.which("nasm") or Path(nasm).is_file()):
        print("error: nasm not found (set NASM_PREFIX)", file=sys.stderr)
        return 1
    if not Path(args.badc).is_file() and shutil.which(args.badc) is None:
        print(f"error: badc not found at {args.badc}", file=sys.stderr)
        return 1

    work.mkdir(parents=True, exist_ok=True)
    if not (src / ".git").exists():
        run(["git", "clone", "--depth", "1", "--branch", EDK2_TAG,
             EDK2_URL, str(src)])
    for sub in SUBMODULES:
        if (src / sub).exists() and not any((src / sub).iterdir()):
            run(["git", "submodule", "update", "--init", "--depth", "1", sub],
                cwd=src)
    if not (src / "BaseTools" / "Source" / "C" / "bin" / "GenFw").exists():
        # BaseTools' C utilities predate current host gcc's stricter default
        # warnings (e.g. -Wunused-but-set-variable), which its -Werror then
        # promotes to build failures. Disable warnings-as-errors and silence
        # the newly-diagnosed ones; this only affects edk2's host tools, not
        # anything badc compiles.
        relax = "-Wno-error -Wno-unused-but-set-variable -Wno-unused-variable"
        run(["make", "-C", "BaseTools", f"-j{args.jobs}",
             f"EXTRA_OPTFLAGS={relax}"], cwd=src)

    patch_fv_layout(src)

    env = os.environ.copy()
    env["WORKSPACE"] = str(src)
    env["EDK_TOOLS_PATH"] = str(src / "BaseTools")
    env["BADC"] = args.badc
    if os.environ.get("NASM_PREFIX"):
        env["NASM_PREFIX"] = os.environ["NASM_PREFIX"]

    # edksetup.sh regenerates Conf/tools_def.txt from the template; register
    # the BADC tag afterwards so it survives. The CC wrapper resolves its
    # helpers relative to its own directory. edk2's build invokes it as an
    # executable, so ensure the execute bit is set even if a checkout / sync
    # dropped it.
    wrapper = HERE / "badc-efi-cc"
    compat = HERE / "badc_efi_compat.h"
    os.chmod(wrapper, os.stat(wrapper).st_mode | 0o111)
    register = (
        f'python3 {HERE / "badc_toolchain.py"} '
        f'Conf/tools_def.txt {wrapper} {compat}')
    module = f"-m {args.module}" if args.module else ""
    build = (
        f". ./edksetup.sh && {register} && "
        f"build -a {arch} -t BADC -b RELEASE -n {args.jobs} -p {dsc} {module}")
    r = run(["bash", "-ec", build], cwd=src, env=env, check=False, capture=True)
    sys.stdout.write(r.stdout)
    if r.returncode != 0:
        print("\n==== FIRST BADC BLOCKER ====")
        print(first_badc_failure(r.stdout))
        return r.returncode
    print(f"\nOK: built under {src / 'Build'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
