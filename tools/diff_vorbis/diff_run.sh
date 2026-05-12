#!/bin/bash
# diff_run.sh -- drive a clang-vs-c5 trace divergence run for
# stb_vorbis on the embedded alarm.ogg payload.
#
# Pipeline:
#   1. Patch demos/stb/stb_vorbis.c into stb_vorbis.traced.c with
#      TRACE_ENTER / TRACE_ERR fprintf calls at every static fn
#      entry and every `return error(f, ...)` site.
#   2. Build a tiny test driver against the traced file under clang
#      (the reference baseline) and run it against alarm_ogg.h.
#   3. Build the same driver under c5 / target/release/badc and run.
#   4. Diff the two trace streams.
#
# The first diverging trace line localizes the function where c5's
# bytecode / codegen drifts off the reference behaviour. From there
# the per-function bytecode dump (`badc --dump-asm`) and the lldb
# local-dump comparison can drill into the specific op that
# misbehaved.
#
# Run from the repo root: `tools/diff_vorbis/diff_run.sh`.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STB_DIR="$REPO_ROOT/demos/stb"
TRACED="$STB_DIR/stb_vorbis.traced.c"
WORK="$REPO_ROOT/.diff_vorbis"

mkdir -p "$WORK"

echo "==> instrumenting stb_vorbis.c"
python3 "$REPO_ROOT/tools/diff_vorbis/instrument.py" --out "$TRACED"

# Write a minimal driver that opens alarm.ogg and exits. No printf
# from the driver itself -- all observable output comes from the
# instrumented stb_vorbis (`fprintf(stderr, "TRACE_..."`).
cat > "$WORK/driver.c" <<'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* sizeof(float)==8 in c5's slot model, so the FAST_SCALED bit-cast
 * path collapses to junk. Same knob the smoke driver uses. */
#define STB_VORBIS_NO_FAST_SCALED_FLOAT 1

/* Pre-bind alloca via the c5 shim so stb_vorbis's `temp_alloc`
 * macro parses (the alloca branch is dead at runtime because we
 * pass a non-NULL alloc_buffer). */
#include <alloca.h>

/* Pull the traced vorbis implementation. The build invokes the
 * compiler with `-I demos/stb` so the bare filenames resolve. */
#include "stb_vorbis.traced.c"
#include "alarm_ogg.h"

int main(void) {
    static char scratch[1024 * 1024];
    stb_vorbis_alloc alloc;
    int err = 0;
    alloc.alloc_buffer = scratch;
    alloc.alloc_buffer_length_in_bytes = (int)sizeof(scratch);
    stb_vorbis *v = stb_vorbis_open_memory(alarm_ogg, alarm_ogg_len, &err, &alloc);
    fprintf(stderr, "TRACE_OPEN v=%p err=%d\n", (void*)v, err);
    if (!v) return 1;
    int total = stb_vorbis_stream_length_in_samples(v);
    fprintf(stderr, "TRACE_TOTAL %d\n", total);
    int frames = 0, samples = 0;
    for (;;) {
        float **out;
        int n = stb_vorbis_get_frame_float(v, NULL, &out);
        if (n == 0) break;
        samples += n;
        frames++;
        if (frames > 1000) break;
    }
    fprintf(stderr, "TRACE_DECODE frames=%d samples=%d\n", frames, samples);
    stb_vorbis_close(v);
    return 0;
}
EOF

echo "==> building under clang (baseline)"
clang -O0 -w -I "$STB_DIR" -o "$WORK/driver.clang" "$WORK/driver.c" -lm
"$WORK/driver.clang" 2>"$WORK/trace.clang" 1>/dev/null || true

echo "==> building under c5"
BADC="${BADC:-$REPO_ROOT/target/release/badc}"
if [ ! -x "$BADC" ]; then
    cargo build --release --manifest-path "$REPO_ROOT/Cargo.toml" -q
fi
"$BADC" -I "$STB_DIR" -include msvc_compat.h -o "$WORK/driver.c5" "$WORK/driver.c" 2>"$WORK/build.c5.log"
chmod +x "$WORK/driver.c5"
"$WORK/driver.c5" 2>"$WORK/trace.c5" 1>/dev/null || true

echo "==> diffing"
echo "    clang trace: $(wc -l <"$WORK/trace.clang") lines"
echo "    c5    trace: $(wc -l <"$WORK/trace.c5") lines"

if diff -q "$WORK/trace.clang" "$WORK/trace.c5" >/dev/null; then
    echo "    no divergence -- traces are identical"
    exit 0
fi

# Show the first 80 lines of unified diff -- usually enough to spot
# the divergence point without paging through a megabyte of output.
echo "    first 80 lines of diff (full diff at $WORK/trace.diff):"
diff -u "$WORK/trace.clang" "$WORK/trace.c5" > "$WORK/trace.diff" || true
head -80 "$WORK/trace.diff"
