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
    # tcc's default crt prefix is /usr/lib, but Debian / Ubuntu keep
    # crt1.o / crti.o / crtn.o and libc.so in the multiarch directory.
    # Detect it from the host cc so the produced binaries link and run.
    crtdir="$(dirname "$("${CC:-cc}" -print-file-name=crt1.o)")"
    # Debian / Ubuntu put glibc's `bits/*.h` under the multiarch
    # include dir, which is not on tcc's default search path.
    multiarch="$("${CC:-cc}" -print-multiarch 2>/dev/null || true)"
    sysinc="/usr/local/include:/usr/include"
    if [ -n "$multiarch" ]; then
      sysinc="$sysinc:/usr/include/$multiarch"
    fi
    case "$(uname -m)" in
      x86_64|amd64) interp="/lib64/ld-linux-x86-64.so.2" ;;
      arm64|aarch64) interp="/lib/ld-linux-aarch64.so.1" ;;
      *) interp="/lib64/ld-linux-x86-64.so.2" ;;
    esac
    target_define="#define CONFIG_TCC_CRTPREFIX \"$crtdir\"
#define CONFIG_TCC_LIBPATHS \"$crtdir:/usr/lib:/lib\"
#define CONFIG_TCC_SYSINCLUDEPATHS \"$sysinc\"
#define CONFIG_TCC_ELFINTERP \"$interp\""
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
# binary, so `run.py` can pass `-B$build_dir` and find tccdefs.h.
mkdir -p "$build_dir/include"
cp -R "$tcc_src/include/." "$build_dir/include/" 2>/dev/null || true
cp "$tcc_src/include/tccdefs.h" "$build_dir/" 2>/dev/null || true

# libtcc1.a holds tcc's runtime helpers (soft-float conversions, alloca,
# the va_arg shim). The vendored archive is built for badc's own tcc and
# the cc-built tcc here rejects its objects, so rebuild it by compiling
# the runtime sources with the tcc just produced. The set of sources is
# architecture-specific (x86_64 uses va_list.c + alloca.S; arm64 uses
# lib-arm64.c), so attempt each candidate and keep the objects that
# compile for this host. run.py passes `-L$build_dir` so tcc finds the
# archive on the library path.
rt_dir="$build_dir/rt"
rm -rf "$rt_dir"
mkdir -p "$rt_dir"
rt_objs=""
for src in libtcc1.c va_list.c builtin.c stdatomic.c tcov.c \
           alloca.S alloca-bt.S atomic.S lib-arm64.c; do
  obj="$rt_dir/${src%.*}.o"
  if "$build_dir/tcc" -B"$build_dir" -I"$build_dir" -I"$build_dir/include" \
       -I"$tcc_src" -c "$tcc_src/lib/$src" -o "$obj" 2>/dev/null; then
    rt_objs="$rt_objs $obj"
  fi
done
# shellcheck disable=SC2086
ar rcs "$build_dir/libtcc1.a" $rt_objs

echo "built: $build_dir/tcc"
