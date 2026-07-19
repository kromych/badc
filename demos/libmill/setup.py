#!/usr/bin/env python3
"""Fetch libmill (Go-style CSP coroutines in C) from upstream github.

Pins the head of `sustrik/libmill@master` by full commit SHA and
verifies a sha256 before extraction; the tree lands under
``demos/libmill/.cache/libmill-<sha>/``.

After extraction three source patches are applied so badc can build
the coroutine core; each is an exact-match string replacement and the
tree is re-extracted on every run, so the result is deterministic:

  1. The x86-64 asm setjmp/longjmp context switch is put behind
     ``!defined MILL_ARCH_FALLBACK`` (the knob libdill already has
     upstream). TODO(badc): the asm path needs the `%=` template
     escape, `lea <label>(%rip), reg`, and explicit-register memory
     operands (`8(%%rdx)`), none of which the x86-64 inline-asm
     catalogue accepts yet.
  2. The sigsetjmp/siglongjmp fallback macros deref through a cast.
     TODO(badc): dereferencing a typedef'd pointer-to-array
     (`mill_ctx` = `sigjmp_buf *`) yields the element type, so the
     uncast form passes a loaded long where libc expects `long *`.
  3. ``mill_go_()`` switches to the new coroutine stack with a
     one-instruction asm sp move (guarded by MILL_BADC_SETSP) instead
     of upstream's stack-pointer-displacing VLA. TODO(badc): VLA and
     alloca allocate from a fixed 8 KiB frame arena and trap (brk #1)
     on larger sizes, so the VLA form cannot move sp. The move parks
     sp 64 bytes below the aligned stack top: badc wraps a spilled asm
     operand in a 16-byte sp-relative block and unwinds it after the
     asm, so the gap keeps that unwind and the first frame inside the
     new stack.

Without -DMILL_BADC_SETSP and -DMILL_ARCH_FALLBACK the patched tree
still builds with gcc/clang exactly as upstream does.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import tarfile
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

UPSTREAM_SHA = "e8937e624757663f5379018cae3f2b3e916afb6c"  # sustrik/libmill @ master
URL = f"https://github.com/sustrik/libmill/archive/{UPSTREAM_SHA}.tar.gz"
SHA256 = "904e58eeefcb0e126d78817f1ca9747670b02dbeb65c3b2a8e41ea4803a660fb"
SRC_DIRNAME = f"libmill-{UPSTREAM_SHA}"

GO_STOCK = """#define mill_go_(fn) \\
    do {\\
        void *mill_sp;\\
        mill_ctx ctx = mill_getctx_();\\
        if(!mill_setjmp_(ctx)) {\\
            mill_sp = mill_prologue_(MILL_HERE_);\\
            int mill_anchor[mill_unoptimisable1_];\\
            mill_unoptimisable2_ = &mill_anchor;\\
            char mill_filler[(char*)&mill_anchor - (char*)(mill_sp)];\\
            mill_unoptimisable2_ = &mill_filler;\\
            fn;\\
            mill_epilogue_();\\
        }\\
    } while(0)"""

GO_BADC = """#if defined MILL_BADC_SETSP
#if defined __x86_64__
#define mill_setsp_(x) \\
    asm volatile("mov %0, %%rsp" : : "r"((void*)(((uintptr_t)(x) & ~(uintptr_t)15) - 64)))
#elif defined __aarch64__
#define mill_setsp_(x) \\
    asm volatile("mov sp, %0" : : "r"((void*)(((uintptr_t)(x) & ~(uintptr_t)15) - 64)))
#endif
#define mill_go_(fn) \\
    do {\\
        void *mill_sp;\\
        mill_ctx ctx = mill_getctx_();\\
        if(!mill_setjmp_(ctx)) {\\
            mill_sp = mill_prologue_(MILL_HERE_);\\
            mill_setsp_(mill_sp);\\
            fn;\\
            mill_epilogue_();\\
        }\\
    } while(0)
#else
""" + GO_STOCK + """
#endif"""

# (file, old, new) exact-match replacements; setup fails loudly if
# upstream drifts from the pinned text.
PATCHES = (
    (
        "cr.h",
        "#if defined(__x86_64__)\n    uint64_t ctx[10];",
        "#if defined(__x86_64__) && !defined MILL_ARCH_FALLBACK\n    uint64_t ctx[10];",
    ),
    (
        "cr.c",
        "#if defined __x86_64__\n    return mill_running->ctx;",
        "#if defined __x86_64__ && !defined MILL_ARCH_FALLBACK\n    return mill_running->ctx;",
    ),
    (
        "libmill.h",
        "#if defined __x86_64__\ntypedef uint64_t *mill_ctx;",
        "#if defined __x86_64__ && !defined MILL_ARCH_FALLBACK\ntypedef uint64_t *mill_ctx;",
    ),
    (
        "libmill.h",
        "#if defined(__x86_64__)\n#if defined(__AVX__)",
        "#if defined(__x86_64__) && !defined MILL_ARCH_FALLBACK\n#if defined(__AVX__)",
    ),
    (
        "libmill.h",
        "#define mill_setjmp_(ctx) \\\n    sigsetjmp(*ctx, 0)\n"
        "#define mill_longjmp_(ctx) \\\n    siglongjmp(*ctx, 1)",
        "#define mill_setjmp_(ctx) \\\n    sigsetjmp(*(sigjmp_buf *)(ctx), 0)\n"
        "#define mill_longjmp_(ctx) \\\n    siglongjmp(*(sigjmp_buf *)(ctx), 1)",
    ),
    ("libmill.h", GO_STOCK, GO_BADC),
)


def apply_patches(src: Path, log) -> None:
    for name, old, new in PATCHES:
        p = src / name
        text = p.read_text()
        if old not in text:
            sys.exit(f"setup: patch anchor not found in {p}:\n{old[:120]}")
        p.write_text(text.replace(old, new, 1))
        log(f"patched {name}")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    cache = Path(__file__).resolve().parent / ".cache"
    cache.mkdir(parents=True, exist_ok=True)
    tar_path = cache / f"libmill-{UPSTREAM_SHA[:8]}.tar.gz"

    if not (tar_path.is_file() and _fetch.sha256_of(tar_path) == SHA256):
        log(f"fetching {URL}")
        with _fetch._urlopen_retry(
            lambda: urllib.request.urlopen(URL)
        ) as resp, tar_path.open("wb") as out:
            shutil.copyfileobj(resp, out)
        actual = _fetch.sha256_of(tar_path)
        if actual != SHA256:
            tar_path.unlink(missing_ok=True)
            sys.exit(f"sha256 mismatch on {URL}: expected {SHA256}, got {actual}")

    src = cache / SRC_DIRNAME
    if src.exists():
        shutil.rmtree(src)
    log("extracting")
    with tarfile.open(tar_path, "r:gz") as tf:
        tf.extractall(cache)
    if not (src / "libmill.h").is_file():
        sys.exit(f"setup: expected {src}/libmill.h after extraction")

    apply_patches(src, log)
    log(f"done -- {src}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
