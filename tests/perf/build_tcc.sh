#!/usr/bin/env bash
# Build the vendored tinycc with the host system cc and stash the
# result under tests/perf/build/tcc plus its include dir so run.py
# can pick it up via $TCC.

set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
tcc_src="$here/../../demos/tinycc"
build_dir="$here/build"
mkdir -p "$build_dir"

case "$(uname -s)" in
  Linux)
    target_define=""
    ;;
  Darwin)
    target_define="#define TCC_TARGET_MACHO 1"
    ;;
  MINGW*|MSYS*|CYGWIN*)
    target_define="#define TCC_TARGET_PE 1"
    ;;
  *)
    echo "unsupported host kernel: $(uname -s)" >&2
    exit 1
    ;;
esac

# Synthesize a config.h that hides the badc-specific compile-time
# knobs (`config.h` in demos/tinycc/ is set up for badc to build
# tcc, not for clang). Mirrors the upstream defaults used by the
# release build.
cat > "$build_dir/config.h" <<EOF
#define TCC_VERSION "0.9.28-perf"
#define CC_NAME CC_clang
#define GCC_MAJOR 0
#define GCC_MINOR 0
$( case "$(uname -m)" in
     x86_64|amd64) echo '#define TCC_TARGET_X86_64 1' ;;
     arm64|aarch64) echo '#define TCC_TARGET_ARM64 1' ;;
     *) echo "unsupported host arch: $(uname -m)" >&2; exit 1 ;;
   esac )
$target_define
#define CONFIG_TCC_PREDEFS 0
#define CONFIG_TCC_SEMLOCK 0
#define CONFIG_TCC_BACKTRACE 0
EOF

cp "$build_dir/config.h" "$tcc_src/config.h.perf"
saved_config=""
if [ -f "$tcc_src/config.h" ]; then
  saved_config="$tcc_src/config.h.saved"
  cp "$tcc_src/config.h" "$saved_config"
fi
cp "$build_dir/config.h" "$tcc_src/config.h"

cleanup() {
  if [ -n "$saved_config" ]; then
    mv "$saved_config" "$tcc_src/config.h"
  else
    rm -f "$tcc_src/config.h"
  fi
}
trap cleanup EXIT

cc="${CC:-clang}"
"$cc" -O2 -DONE_SOURCE \
  -I"$tcc_src" -I"$tcc_src/include" \
  -o "$build_dir/tcc" "$tcc_src/tcc.c" -lpthread -lm -ldl

# Provide the include set tcc expects at runtime alongside the
# binary, so `run.py` can pass `-B$build_dir` and find tccdefs.h
# / libtcc1.a (the runtime helper static library tcc bundles for
# things like __va_list_intrin).
mkdir -p "$build_dir/include"
cp -R "$tcc_src/include/." "$build_dir/include/" 2>/dev/null || true
cp "$tcc_src/include/tccdefs.h" "$build_dir/" 2>/dev/null || true
cp "$tcc_src/libtcc1.a" "$build_dir/" 2>/dev/null || true

echo "built: $build_dir/tcc"
