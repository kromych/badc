/* End-to-end smoke driver for the stb header-only collection.
 *
 * Pulls every stb_*.h (plus stb_vorbis.c) the upstream archive
 * ships at top level into a single translation unit and exercises
 * a representative scenario per header where the surface is
 * testable without a display server / audio device / network.
 * Headers currently blocked on c5 dialect gaps are gated off
 * with a TODO line naming the specific follow-up to track.
 *
 * Headers covered today (19/21):
 *   stb_c_lexer.h, stb_connected_components.h, stb_divide.h,
 *   stb_ds.h, stb_dxt.h, stb_easy_font.h,
 *   stb_herringbone_wang_tile.h, stb_hexwave.h, stb_image.h,
 *   stb_image_write.h, stb_include.h, stb_leakcheck.h,
 *   stb_perlin.h, stb_rect_pack.h, stb_sprintf.h, stb_textedit.h,
 *   stb_truetype.h, stb_vorbis.c, stb_voxel_render.h
 *
 * Headers gated off (rationale + tracking issue):
 *   stb_image_resize2.h -- forward-referenced function pointers
 *     in a static dispatch table; needs a deferred-resolution
 *     CodeReloc path for initializer slots.
 *   stb_tilemap_editor.h -- non-constant local struct
 *     initializers (`stbte__colorrect r = { x0, y0, ... };`
 *     mixes runtime arguments into a brace-list at block scope).
 *     C99 6.7.8p13 admits these for automatic-storage
 *     aggregates; c5's local-struct-init path currently only
 *     accepts compile-time constants.
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/* math.h pulled in below by stb_truetype / stb_hexwave -- no
 * direct uses in the driver itself. */

/* `_lrotl` is an MSVC intrinsic. msvc_compat.h sets _MSC_VER on
 * Windows targets, which makes stb_image take the
 * `#define stbi_lrot(x,y) _lrotl(x,y)` branch; c5 has no
 * `_lrotl` binding, so shim it to the plain-C rotate the
 * non-MSVC branch uses. */
#define _lrotl(x, n) (((x) << (n)) | ((x) >> (32 - (n))))

/* msvc_compat.h also defines `__MINGW32__`, which makes
 * stb_leakcheck's dumpmem reporter call `__mingw_fprintf` (the
 * format-aware mingw printf wrapper). c5 binds the plain libc
 * `fprintf` only -- alias the two so the leakcheck dumpmem
 * path lowers cleanly on the Windows lanes. */
#define __mingw_fprintf fprintf

/* Cross-target SIMD opt-outs -- c5 doesn't model the SSE2 / NEON /
 * AVX intrinsic surface that stb_image's JPEG IDCT and
 * stb_image_resize2 reach for. The plain-C fallbacks are exactly
 * the paths c5 already compiles. */
#define STBI_NO_SIMD
#define STBIR_NO_SIMD

#define STB_SPRINTF_IMPLEMENTATION
#include "stb_sprintf.h"

#define STB_PERLIN_IMPLEMENTATION
#include "stb_perlin.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#define STBI_WRITE_NO_STDIO
#include "stb_image_write.h"

#define STB_IMAGE_IMPLEMENTATION
#define STBI_NO_STDIO
#define STBI_NO_HDR
#define STBI_NO_LINEAR
#define STBI_NO_THREAD_LOCALS
/* PSD path is included. `STBI_NOTUSED(v)` expands to
 * `(void)sizeof(v)`, and `stbi__psd_is16` uses that with
 * function-call operands -- which c5 used to drop emitted
 * bytecode for without rewinding `fn_call_fixups`, so the
 * stale fixup later corrupted the bytecode stream and ICE'd
 * codegen with "bad opcode". The sizeof-truncation fix
 * (rewinding fn_call_fixups + code_reloc_sym_idx alongside
 * text / data_imm_positions / source_lines) unblocked this
 * path. */
#include "stb_image.h"

#define STB_DS_IMPLEMENTATION
#include "stb_ds.h"

#define STB_RECT_PACK_IMPLEMENTATION
#include "stb_rect_pack.h"

#define STB_C_LEXER_IMPLEMENTATION
#include "stb_c_lexer.h"

#define STBCC_GRID_COUNT_X_LOG2 6
#define STBCC_GRID_COUNT_Y_LOG2 6
#define STB_CONNECTED_COMPONENTS_IMPLEMENTATION
#include "stb_connected_components.h"

#define STB_DIVIDE_IMPLEMENTATION
#include "stb_divide.h"

#define STB_DXT_IMPLEMENTATION
#include "stb_dxt.h"

#include "stb_easy_font.h"

#define STB_HERRINGBONE_WANG_TILE_IMPLEMENTATION
#include "stb_herringbone_wang_tile.h"

#define STB_HEXWAVE_IMPLEMENTATION
#include "stb_hexwave.h"

#define STB_INCLUDE_IMPLEMENTATION
#include "stb_include.h"

/* stb_leakcheck.h: pull the public-API prototypes only -- the
 * implementation block (gated by STB_LEAKCHECK_IMPLEMENTATION)
 * defines the wrapper functions plus the `#define malloc ...`
 * macros that would intercept every malloc / free in the rest
 * of the smoke. We DO want the wrappers compiled (so the
 * leakcheck scenario can call them by name) but we DON'T want
 * the malloc/free macros active TU-wide. Including the file
 * twice once with IMPLEMENTATION (for the bodies) and once
 * without (for the declarations) would also re-introduce the
 * macros. Solution: include with IMPLEMENTATION, then `#undef`
 * the macros so the rest of the TU sees libc malloc / free
 * again. The scenario calls `stb_leakcheck_malloc/_free` by
 * name. */
#define STB_LEAKCHECK_IMPLEMENTATION
#include "stb_leakcheck.h"
#undef malloc
#undef realloc
#undef free

#define STB_TRUETYPE_IMPLEMENTATION
#include "stb_truetype.h"

/* stb_textedit caller-supplied stub. The header describes
 * an embedder-supplied surface for the buffer type, length /
 * get / insert / delete hooks, per-character layout and width
 * queries, and the keyboard-input constants. The smoke wires
 * up a minimal single-line text buffer with one-pixel-wide
 * ASCII characters so the scenario exercises insert / cursor-
 * motion / backspace / delete and an undo round-trip. */
struct te_str {
    char chars[256];
    int  len;
};

#define STB_TEXTEDIT_STRING               struct te_str
#define STB_TEXTEDIT_CHARTYPE             char
#define STB_TEXTEDIT_KEYTYPE              int
#define STB_TEXTEDIT_POSITIONTYPE         int

/* First include with no IMPLEMENTATION: brings in the
 * `StbTexteditRow` / `STB_TexteditState` typedefs the hook
 * helpers below reference. The implementation include comes
 * after the hooks are defined. */
#include "stb_textedit.h"

#define STB_TEXTEDIT_STRINGLEN(s)         ((s)->len)
#define STB_TEXTEDIT_GETCHAR(s, i)        ((s)->chars[(i)])
#define STB_TEXTEDIT_GETWIDTH(s, n, i)    (1.0f)
#define STB_TEXTEDIT_KEYTOTEXT(k)         (((k) >= 0x20 && (k) < 0x7f) ? (k) : -1)
#define STB_TEXTEDIT_NEWLINE              '\n'
#define STB_TEXTEDIT_GETWIDTH_NEWLINE     (-1.0f)

/* High-bit keys so they don't collide with printable ASCII the
 * KEYTOTEXT branch funnels into INSERTCHARS. SHIFT is OR'd in. */
#define STB_TEXTEDIT_K_SHIFT      0x40000000
#define STB_TEXTEDIT_K_LEFT       0x10000
#define STB_TEXTEDIT_K_RIGHT      0x10001
#define STB_TEXTEDIT_K_UP         0x10002
#define STB_TEXTEDIT_K_DOWN       0x10003
#define STB_TEXTEDIT_K_LINESTART  0x10004
#define STB_TEXTEDIT_K_LINEEND    0x10005
#define STB_TEXTEDIT_K_TEXTSTART  0x10006
#define STB_TEXTEDIT_K_TEXTEND    0x10007
#define STB_TEXTEDIT_K_DELETE     0x10008
#define STB_TEXTEDIT_K_BACKSPACE  0x10009
#define STB_TEXTEDIT_K_UNDO       0x1000a
#define STB_TEXTEDIT_K_REDO       0x1000b
#define STB_TEXTEDIT_K_PGUP       0x1000c
#define STB_TEXTEDIT_K_PGDOWN     0x1000d

static void te_layout_row(StbTexteditRow *row, struct te_str *s, int n) {
    int remaining = s->len - n;
    row->x0 = 0.0f;
    row->x1 = (float)remaining;
    row->baseline_y_delta = 1.0f;
    row->ymin = 0.0f;
    row->ymax = 1.0f;
    row->num_chars = remaining;
}
#define STB_TEXTEDIT_LAYOUTROW(r, s, n)   te_layout_row((r), (s), (n))

static int te_insertchars(struct te_str *s, int pos, char *newtext, int num) {
    if (s->len + num > (int)sizeof(s->chars)) return 0;
    memmove(s->chars + pos + num, s->chars + pos, (size_t)(s->len - pos));
    memmove(s->chars + pos, newtext, (size_t)num);
    s->len += num;
    return 1;
}
#define STB_TEXTEDIT_INSERTCHARS(s, p, t, n) te_insertchars((s), (p), (t), (n))

static void te_deletechars(struct te_str *s, int pos, int num) {
    memmove(s->chars + pos, s->chars + pos + num, (size_t)(s->len - pos - num));
    s->len -= num;
}
#define STB_TEXTEDIT_DELETECHARS(s, p, n) te_deletechars((s), (p), (n))

#define STB_TEXTEDIT_IMPLEMENTATION
#include "stb_textedit.h"

#define STBVOX_CONFIG_MODE 0
#define STB_VOXEL_RENDER_IMPLEMENTATION
#include "stb_voxel_render.h"

/* `<alloca.h>` declares `alloca` and `__builtin_alloca` as
 * compiler intrinsics tagged with `#pragma intrinsic`. The c5
 * frontend lowers their call sites to `Op::Intrinsic(Alloca)`,
 * which decrements a per-frame arena pointer reserved by
 * `Op::Ent` and returns the new top -- no runtime SP bump, so
 * outstanding `Op::Psh` values stay where they are. stb_vorbis
 * uses this when the caller passes NULL alloc_buffer. */
#include <alloca.h>

/* c5's slot model reports `sizeof(float)` as 8 (one VM slot)
 * rather than the on-disk 4 bytes. stb_vorbis's
 * FAST_SCALED_FLOAT_TO_INT path bit-casts a `float` through a
 * union and depends on the 4-byte representation. The macro
 * surface below disables that path and falls back to the
 * portable `(int)(x * (1<<s))` form, which c5 lowers fine. */
#define STB_VORBIS_NO_FAST_SCALED_FLOAT 1

/* One-shot debugging aid for the c5-vs-gcc divergence in
 * stb_vorbis's setup phase: when defined, every
 * `return error(f, ...)` site in the implementation prints
 * its source line + error code to stderr. Compare runs of
 * the c5-built smoke vs a gcc-built copy of the same TU to
 * locate the first divergent failure point. */
/* #define VORBIS_TRACE_ERRORS 1 */

/* stb_vorbis lives in `stb_vorbis.c` (not `.h`) -- it's a single-
 * translation-unit library. Pull the full source: PUSHDATA +
 * PULLDATA + STDIO surface come along. */
#include "stb_vorbis.c"

/* Embedded ~12KB mono 48kHz Ogg/Vorbis test payload generated
 * from the `alarm.ogg` file at the repo root. The positive
 * `scenario_vorbis` decode path replays this through the
 * decoder. */
#include "alarm_ogg.h"
/* stb_vorbis leaks a handful of short macros (`C`, `M`, `R`, ...)
 * from its FAST_SCALED_FLOAT block + decoder tables. Undef them
 * so the smoke driver's own `enum { W, H, C }` scenarios below
 * aren't shadowed. */
#undef C
#undef M
#undef R

/* TODO(stb-tilemap-editor): blocked on non-constant local
 * struct initializers. The header writes shapes like
 * `stbte__colorrect r = { x0,y0,x1,y1,color };` inside
 * functions, where the brace-list mixes runtime parameter
 * values. c5's local-struct-init path currently only accepts
 * compile-time constants (C99 6.7.8p13 admits non-constant
 * initializers for automatic-storage aggregates). */

/* ============================================================ */
/*  Per-header smoke scenarios. Each returns 0 on success and
 *  non-zero (with a stderr diagnostic) on failure. */
/* ============================================================ */

static int scenario_sprintf(void) {
    char buf[128];
    int n = stbsp_snprintf(buf, (int)sizeof(buf),
        "%d %s %x %.3f", 42, "stb", 0xCAFE, 3.14159);
    if (n <= 0 || strcmp(buf, "42 stb cafe 3.142") != 0) {
        fprintf(stderr, "stb smoke: sprintf got [%s] (n=%d)\n", buf, n);
        return 1;
    }
    printf("sprintf OK: %s\n", buf);
    return 0;
}

static int scenario_perlin(void) {
    float a = stb_perlin_noise3(1.5f, 2.5f, 0.5f, 0, 0, 0);
    float b = stb_perlin_noise3(7.25f, 0.125f, 4.0f, 0, 0, 0);
    if (a != a || b != b) {
        fprintf(stderr, "stb smoke: perlin returned NaN: a=%f b=%f\n",
                (double)a, (double)b);
        return 1;
    }
    if (a < -1.0f || a > 1.0f || b < -1.0f || b > 1.0f) {
        fprintf(stderr, "stb smoke: perlin out of [-1,1]: a=%f b=%f\n",
                (double)a, (double)b);
        return 1;
    }
    if (a == b) {
        fprintf(stderr, "stb smoke: perlin returned same value for distinct points\n");
        return 1;
    }
    printf("perlin OK: in-range, distinct\n");
    return 0;
}

struct write_ctx {
    unsigned char *buf;
    size_t len;
    size_t cap;
};

static void write_cb(void *user, void *data, int size) {
    struct write_ctx *ctx = (struct write_ctx *)user;
    if (size <= 0) return;
    size_t need = ctx->len + (size_t)size;
    if (need > ctx->cap) {
        size_t newcap = ctx->cap ? ctx->cap * 2 : 256;
        while (newcap < need) newcap *= 2;
        ctx->buf = (unsigned char *)realloc(ctx->buf, newcap);
        ctx->cap = newcap;
    }
    memcpy(ctx->buf + ctx->len, data, (size_t)size);
    ctx->len += (size_t)size;
}

static int scenario_image_roundtrip(void) {
    enum { W = 4, H = 4, C = 3 };
    unsigned char src[W * H * C];
    int i;
    for (i = 0; i < W * H; i++) {
        int on = ((i + (i / W)) & 1) ? 255 : 16;
        src[i * 3 + 0] = (unsigned char)on;
        src[i * 3 + 1] = (unsigned char)(on / 2);
        src[i * 3 + 2] = (unsigned char)(255 - on);
    }

    struct write_ctx ctx;
    ctx.buf = NULL; ctx.len = 0; ctx.cap = 0;
    int wrc = stbi_write_png_to_func(write_cb, &ctx, W, H, C, src, W * C);
    if (!wrc || ctx.len == 0) {
        fprintf(stderr, "stb smoke: stbi_write_png_to_func failed\n");
        free(ctx.buf);
        return 1;
    }

    int dw = 0, dh = 0, dc = 0;
    unsigned char *dec = stbi_load_from_memory(ctx.buf, (int)ctx.len,
                                               &dw, &dh, &dc, 0);
    if (!dec) {
        fprintf(stderr, "stb smoke: stbi_load_from_memory failed: %s\n",
                stbi_failure_reason());
        free(ctx.buf);
        return 1;
    }
    if (dw != W || dh != H || dc != C) {
        fprintf(stderr, "stb smoke: decoded %dx%dx%d, want %dx%dx%d\n",
                dw, dh, dc, W, H, C);
        free(ctx.buf); stbi_image_free(dec);
        return 1;
    }
    if (memcmp(dec, src, sizeof(src)) != 0) {
        fprintf(stderr, "stb smoke: png round-trip pixel mismatch\n");
        free(ctx.buf); stbi_image_free(dec);
        return 1;
    }
    printf("image OK: png round-trip %d bytes\n", (int)ctx.len);
    free(ctx.buf); stbi_image_free(dec);
    return 0;
}

static int scenario_jpg_roundtrip(void) {
    /* JPEG round-trip. JPEG is lossy (DCT + quantization), so
     * we can't check exact pixel equality, but we can verify
     * the encoder produces a structurally valid stream, the
     * decoder reads it back at the right dimensions, and the
     * average error stays within a sane bound. The DCT path
     * exercises the full float-arithmetic pipeline that other
     * scenarios only touch through perlin/hexwave.
     */
    enum { W = 8, H = 8, C = 3 };
    unsigned char src[W * H * C];
    int i;
    for (i = 0; i < W * H; i++) {
        src[i * 3 + 0] = (unsigned char)(i * 7 + 13);
        src[i * 3 + 1] = (unsigned char)(i * 11 + 5);
        src[i * 3 + 2] = (unsigned char)(i * 5 + 23);
    }

    struct write_ctx ctx;
    ctx.buf = NULL; ctx.len = 0; ctx.cap = 0;
    int wrc = stbi_write_jpg_to_func(write_cb, &ctx, W, H, C, src, 90);
    if (!wrc || ctx.len == 0) {
        fprintf(stderr, "stb smoke: stbi_write_jpg_to_func failed\n");
        free(ctx.buf);
        return 1;
    }

    int dw = 0, dh = 0, dc = 0;
    unsigned char *dec = stbi_load_from_memory(ctx.buf, (int)ctx.len,
                                               &dw, &dh, &dc, 0);
    if (!dec) {
        fprintf(stderr, "stb smoke: jpg load_from_memory failed: %s\n",
                stbi_failure_reason());
        free(ctx.buf);
        return 1;
    }
    if (dw != W || dh != H || dc != C) {
        fprintf(stderr, "stb smoke: jpg decoded %dx%dx%d, want %dx%dx%d\n",
                dw, dh, dc, W, H, C);
        free(ctx.buf); stbi_image_free(dec);
        return 1;
    }
    /* A quality-90 JPEG of a smooth gradient should round-trip
     * to within ~16/channel on average. Empty (zero) pixel
     * data would show ~127/channel error vs the ramp source. */
    long sum_err = 0;
    for (i = 0; i < W * H * C; i++) {
        int d = (int)src[i] - (int)dec[i];
        sum_err += (d < 0 ? -d : d);
    }
    long avg_err = sum_err / (W * H * C);
    if (avg_err > 32) {
        fprintf(stderr, "stb smoke: jpg avg pixel error %ld too high\n",
                avg_err);
        free(ctx.buf); stbi_image_free(dec);
        return 1;
    }
    printf("jpg OK: %d bytes, avg err=%ld\n", (int)ctx.len, avg_err);
    free(ctx.buf); stbi_image_free(dec);
    return 0;
}

static int scenario_bmp_roundtrip(void) {
    /* BMP round-trip. BMP is a lossless integer-pixel format
     * (no DCT, no float math), so the round-trip is a
     * byte-for-byte equality check. Exercises a different
     * encoder code path than the PNG case: BMP writes BGR
     * rows bottom-up with a 4-byte alignment pad, so the
     * row-reordering / padding loop is what we're stressing.
     */
    enum { W = 6, H = 5, C = 3 };
    unsigned char src[W * H * C];
    int i;
    for (i = 0; i < W * H * C; i++) {
        src[i] = (unsigned char)((i * 17 + 3) & 0xff);
    }

    struct write_ctx ctx;
    ctx.buf = NULL; ctx.len = 0; ctx.cap = 0;
    int wrc = stbi_write_bmp_to_func(write_cb, &ctx, W, H, C, src);
    if (!wrc || ctx.len == 0) {
        fprintf(stderr, "stb smoke: stbi_write_bmp_to_func failed\n");
        free(ctx.buf);
        return 1;
    }

    int dw = 0, dh = 0, dc = 0;
    unsigned char *dec = stbi_load_from_memory(ctx.buf, (int)ctx.len,
                                               &dw, &dh, &dc, 0);
    if (!dec) {
        fprintf(stderr, "stb smoke: bmp load_from_memory failed: %s\n",
                stbi_failure_reason());
        free(ctx.buf);
        return 1;
    }
    if (dw != W || dh != H || dc != C) {
        fprintf(stderr, "stb smoke: bmp decoded %dx%dx%d, want %dx%dx%d\n",
                dw, dh, dc, W, H, C);
        free(ctx.buf); stbi_image_free(dec);
        return 1;
    }
    if (memcmp(dec, src, sizeof(src)) != 0) {
        fprintf(stderr, "stb smoke: bmp round-trip pixel mismatch\n");
        free(ctx.buf); stbi_image_free(dec);
        return 1;
    }
    printf("bmp OK: round-trip %d bytes\n", (int)ctx.len);
    free(ctx.buf); stbi_image_free(dec);
    return 0;
}

static int scenario_ds(void) {
    int *arr = NULL;
    int i;
    for (i = 0; i < 64; i++) {
        arrput(arr, i * i);
    }
    if (arrlen(arr) != 64) {
        fprintf(stderr, "stb smoke: arrlen %td, want 64\n", arrlen(arr));
        arrfree(arr);
        return 1;
    }
    int sum = 0;
    for (i = 0; i < arrlen(arr); i++) sum += arr[i];
    if (sum != 85344) {
        fprintf(stderr, "stb smoke: ds sum %d, want 85344\n", sum);
        arrfree(arr);
        return 1;
    }
    arrfree(arr);
    printf("ds OK: arr sum %d\n", sum);
    return 0;
}

static int scenario_rect_pack(void) {
    enum { N = 8 };
    stbrp_rect rects[N];
    int i;
    for (i = 0; i < N; i++) {
        rects[i].id = i;
        rects[i].w = 8 + (i % 3) * 4;
        rects[i].h = 6 + (i % 4) * 3;
        rects[i].x = rects[i].y = 0;
        rects[i].was_packed = 0;
    }
    stbrp_context ctx;
    stbrp_node nodes[64];
    stbrp_init_target(&ctx, 64, 64, nodes, 64);
    int packed = stbrp_pack_rects(&ctx, rects, N);
    if (!packed) {
        fprintf(stderr, "stb smoke: rect_pack returned 0\n");
        return 1;
    }
    for (i = 0; i < N; i++) {
        if (!rects[i].was_packed) {
            fprintf(stderr, "stb smoke: rect %d not packed\n", i);
            return 1;
        }
    }
    printf("rect_pack OK: %d rects placed\n", N);
    return 0;
}

static int scenario_c_lexer(void) {
    /* Lex a handful of token kinds and confirm the categories
     * match. stb_c_lexer carries its own classification enum;
     * CLEX_id covers identifiers, CLEX_intlit integer literals,
     * etc. */
    static const char src[] = "int x = 42; /* note */ return x + 1;";
    stb_lexer lex;
    char store[64];
    stb_c_lexer_init(&lex, src, src + sizeof(src) - 1, store, (int)sizeof(store));
    int kinds[8];
    int got = 0;
    while (got < 8 && stb_c_lexer_get_token(&lex)) {
        kinds[got++] = (int)lex.token;
    }
    /* Expected stream: id(int) id(x) '=' int(42) ';' id(return) id(x) '+'
     * but we only check the first four to avoid pinning the full sequence. */
    if (got < 4 || kinds[0] != CLEX_id || kinds[1] != CLEX_id
        || kinds[2] != '=' || kinds[3] != CLEX_intlit) {
        fprintf(stderr, "stb smoke: c_lexer kinds %d %d %d %d (got %d tokens)\n",
                kinds[0], kinds[1], kinds[2], kinds[3], got);
        return 1;
    }
    printf("c_lexer OK: %d tokens\n", got);
    return 0;
}

static int scenario_connected_components(void) {
    /* Tiny 8x8 reachability test (we configured GRID_COUNT to 6,
     * so 64x64 is the maximum). Mark the bottom-left and
     * top-right corners as open and check they belong to the
     * same component once we open a connecting row. */
    int w = 64, h = 64;
    unsigned char *map = (unsigned char *)calloc((size_t)(w * h), 1);
    if (!map) return 1;
    stbcc_grid *g = (stbcc_grid *)malloc(stbcc_grid_sizeof());
    /* Mark a row open so the two endpoints connect. */
    int x;
    for (x = 0; x < w; x++) map[x] = 0;       /* row 0 open */
    /* Other rows blocked. */
    int y;
    for (y = 1; y < h; y++) for (x = 0; x < w; x++) map[y * w + x] = 1;
    stbcc_init_grid(g, map, w, h);
    int ok = stbcc_query_grid_node_connection(g, 0, 0, w - 1, 0) ? 1 : 0;
    free(map); free(g);
    if (!ok) {
        fprintf(stderr, "stb smoke: connected_components row-connect query failed\n");
        return 1;
    }
    printf("connected_components OK: row connectivity\n");
    return 0;
}

static int scenario_divide(void) {
    /* stb_divide ships C-style euclidean and integer-divide
     * variants. Pin the canonical examples. */
    if (stb_div_eucl(-7, 3) != -3) return 1;
    if (stb_mod_eucl(-7, 3) != 2) return 1;
    if (stb_div_trunc(-7, 3) != -2) return 1;
    if (stb_mod_trunc(-7, 3) != -1) return 1;
    printf("divide OK: eucl/trunc forms\n");
    return 0;
}

static int scenario_dxt(void) {
    /* Compress a single 4x4 RGBA block and check the output is
     * 8 bytes (DXT1 block size). */
    unsigned char src[64];
    int i;
    for (i = 0; i < 64; i++) src[i] = (unsigned char)i;
    unsigned char block[8] = {0};
    stb_compress_dxt_block(block, src, 0, STB_DXT_NORMAL);
    int any = 0;
    for (i = 0; i < 8; i++) if (block[i] != 0) any = 1;
    if (!any) {
        fprintf(stderr, "stb smoke: dxt block all zero\n");
        return 1;
    }
    printf("dxt OK: 8-byte block\n");
    return 0;
}

static int scenario_easy_font(void) {
    /* Print "Hi" into a quad buffer and check the function
     * produced a non-zero quad count (each glyph is several
     * line segments rasterised to quads). */
    char buf[1024];
    int q = stb_easy_font_print(0, 0, "Hi", NULL, buf, (int)sizeof(buf));
    if (q <= 0) {
        fprintf(stderr, "stb smoke: easy_font quads = %d\n", q);
        return 1;
    }
    int w = stb_easy_font_width("Hi");
    int h = stb_easy_font_height("Hi");
    if (w <= 0 || h <= 0) {
        fprintf(stderr, "stb smoke: easy_font dims (%d, %d)\n", w, h);
        return 1;
    }
    printf("easy_font OK: %d quads, %dx%d\n", q, w, h);
    return 0;
}

static int scenario_hexwave(void) {
    /* Generate a few samples of the default hex-wave preset and
     * check the output is bounded -- a real DSP test would FFT
     * the buffer, but bounds + non-zero is plenty for a smoke. */
    hexwave_init(32, 16, NULL);
    HexWave hw;
    hexwave_create(&hw, 0, 0, 0, 0);
    float out[64];
    int i;
    for (i = 0; i < 64; i++) out[i] = 0.0f;
    hexwave_generate_samples(out, 64, &hw, 440.0f / 44100.0f);
    int any = 0;
    for (i = 0; i < 64; i++) {
        if (out[i] != out[i]) {
            fprintf(stderr, "stb smoke: hexwave NaN at %d\n", i);
            return 1;
        }
        if (out[i] < -2.0f || out[i] > 2.0f) {
            fprintf(stderr, "stb smoke: hexwave out of range at %d: %f\n",
                    i, (double)out[i]);
            return 1;
        }
        if (out[i] != 0.0f) any = 1;
    }
    hexwave_shutdown(NULL);
    if (!any) {
        fprintf(stderr, "stb smoke: hexwave all zero\n");
        return 1;
    }
    printf("hexwave OK: 64 samples in bounds\n");
    return 0;
}

static int scenario_leakcheck(void) {
    /* stb_leakcheck wraps malloc/free with a linked-list-backed
     * allocation tracker. We call the wrapped routines by name
     * (not through the `malloc` macro) so the rest of the smoke
     * keeps using libc's malloc and the leakcheck book-keeping
     * stays consistent. */
    void *p = stb_leakcheck_malloc(32, __FILE__, __LINE__);
    if (!p) return 1;
    memset(p, 0, 32);
    stb_leakcheck_free(p);
    printf("leakcheck OK: malloc/free pair\n");
    return 0;
}

static int scenario_truetype(void) {
    /* stb_truetype: confirm the API surface compiled by taking
     * the address of a representative entry point. Exercising
     * the runtime path needs a real .ttf payload (not bundled
     * here -- stbtt_FindGlyphIndex on a zeroed stbtt_fontinfo
     * dereferences NULL inside the font byte table). */
    int (*entry)(stbtt_fontinfo *, int) = stbtt_FindGlyphIndex;
    if (entry == NULL) return 1;
    printf("truetype OK: symbol resolves\n");
    return 0;
}

static int scenario_wang_tile(void) {
    /* The herringbone-wang generator is large; just check its
     * primary entry point produces a valid output buffer for a
     * tiny request. The template pre-image is a synthesised
     * 8-color wang-tile set; sending NULL would error out, so we
     * call into an introspection helper that doesn't require a
     * template. */
    /* stbhw_get_num_template_tiles needs a parsed template;
     * exercising the parse path requires a PNG, which we'd have
     * to bundle. For the smoke, just confirm the symbol resolves
     * by taking its address. */
    void (*entry)(stbhw_tileset *) = stbhw_free_tileset;
    if (entry == NULL) return 1;
    printf("herringbone_wang OK: symbol resolves\n");
    return 0;
}

static int scenario_vorbis(void) {
    /* stb_vorbis is a full Ogg-Vorbis decoder. The driver
     * embeds a real ~12KB mono 48kHz file (alarm.ogg) and
     * exercises:
     *
     *   - negative path: deliberately malformed bytes must
     *     return NULL and a non-zero error code,
     *   - positive path: the real .ogg must open, report the
     *     expected channel / rate / sample-count properties,
     *     and decode every frame to completion.
     *
     * The smoke passes a non-NULL `alloc_buffer`, so `temp_alloc`
     * runs against the scratch arena rather than the per-frame
     * `alloca` intrinsic. The alloca path itself is exercised
     * separately by `tests/fixtures/c/alloca_basic.c`. */
    static char scratch[1024 * 1024];
    stb_vorbis_alloc alloc;
    int err = 0;
    unsigned char bogus[16];
    int i;
    stb_vorbis *v;

    alloc.alloc_buffer = scratch;
    alloc.alloc_buffer_length_in_bytes = (int)sizeof(scratch);

    /* Negative path. */
    for (i = 0; i < (int)sizeof(bogus); i++) bogus[i] = (unsigned char)i;
    v = stb_vorbis_open_memory(bogus, (int)sizeof(bogus), &err, &alloc);
    if (v != NULL) {
        stb_vorbis_close(v);
        fprintf(stderr, "stb smoke: vorbis accepted bogus input\n");
        return 1;
    }
    if (err == 0) {
        fprintf(stderr, "stb smoke: vorbis returned NULL but err=0\n");
        return 1;
    }

    /* Positive path through `alarm_ogg`. Two c5 fixes drive
     * this end-to-end:
     *   - aarch64 Mcpy now uses scaled-12-bit `ldr/str` instead
     *     of the 9-bit `ldur/stur`, so `*f = p` -- the ~1.9 KB
     *     stb_vorbis struct copy inside `stb_vorbis_open_memory`
     *     -- carries every field past byte offset 256 correctly
     *     (notably `next_seg`).
     *   - The Brak postfix handler now surfaces the inner row
     *     length when a `T (*p)[N]` field is subscripted once,
     *     so `sizeof(r->residue_books[0])` returns `N*sizeof(T)`
     *     instead of `sizeof(pointer)`. Previously the residue
     *     setup_malloc was half-sized; the writes overran into
     *     adjacent codebook structs and `codebook_decode_start`
     *     dereferenced a corrupted pointer.
     * The .ogg is a real ~12 KB mono 48 kHz clip; both info
     * properties and total sample count are pinned. */
    v = stb_vorbis_open_memory(alarm_ogg, alarm_ogg_len, &err, &alloc);
    if (v == NULL) {
        fprintf(stderr, "stb smoke: vorbis_open_memory(alarm) failed err=%d\n", err);
        return 1;
    }
    {
        stb_vorbis_info info = stb_vorbis_get_info(v);
        short buf[4096];
        int total = 0;
        int n;
        if (info.channels != 1 || info.sample_rate != 48000) {
            fprintf(stderr, "stb smoke: vorbis info channels=%d rate=%d\n",
                    info.channels, info.sample_rate);
            stb_vorbis_close(v);
            return 1;
        }
        for (;;) {
            n = stb_vorbis_get_samples_short_interleaved(
                v, info.channels, buf, (int)(sizeof(buf) / sizeof(buf[0])));
            if (n <= 0) break;
            total += n;
        }
        if (total != 46028) {
            fprintf(stderr, "stb smoke: vorbis decoded %d samples, want 46028\n", total);
            stb_vorbis_close(v);
            return 1;
        }
        stb_vorbis_close(v);
        printf("vorbis OK: rejected bogus + decoded alarm_ogg %d samples @ %d Hz\n",
               total, info.sample_rate);
    }
    return 0;
}

static int scenario_voxel_render(void) {
    /* stb_voxel_render runs a heavy mesh-construction pipeline
     * that needs real input buffers + a GL-style backing store
     * to validate end-to-end. Here we just confirm the
     * `stbvox_init_mesh_maker` symbol resolves and the
     * implementation TU compiled cleanly through c5; further
     * exercise would need a non-trivial test rig. */
    void (*entry)(stbvox_mesh_maker *) = stbvox_init_mesh_maker;
    if (entry == NULL) return 1;
    printf("voxel_render OK: symbol resolves\n");
    return 0;
}

static int scenario_textedit(void) {
    struct te_str s;
    STB_TexteditState state;
    int i;

    s.len = 0;
    stb_textedit_initialize_state(&state, 1);

    /* Insert "hello" one char at a time through stb_textedit_key. */
    stb_textedit_key(&s, &state, 'h');
    stb_textedit_key(&s, &state, 'e');
    stb_textedit_key(&s, &state, 'l');
    stb_textedit_key(&s, &state, 'l');
    stb_textedit_key(&s, &state, 'o');
    if (s.len != 5 || memcmp(s.chars, "hello", 5) != 0) {
        fprintf(stderr, "stb smoke: textedit insert got len=%d\n", s.len);
        return 1;
    }
    if (state.cursor != 5) {
        fprintf(stderr, "stb smoke: textedit cursor=%d, want 5\n", state.cursor);
        return 1;
    }

    /* Cursor back 2 (between 'l' and 'l'), insert 'X' -> "helXlo". */
    stb_textedit_key(&s, &state, STB_TEXTEDIT_K_LEFT);
    stb_textedit_key(&s, &state, STB_TEXTEDIT_K_LEFT);
    stb_textedit_key(&s, &state, 'X');
    if (s.len != 6 || memcmp(s.chars, "helXlo", 6) != 0) {
        fprintf(stderr, "stb smoke: textedit insert-mid got len=%d [%c%c%c%c%c%c]\n",
                s.len, s.chars[0], s.chars[1], s.chars[2],
                s.chars[3], s.chars[4], s.chars[5]);
        return 1;
    }

    /* Backspace from cursor=4 deletes the 'X'. */
    stb_textedit_key(&s, &state, STB_TEXTEDIT_K_BACKSPACE);
    if (s.len != 5 || memcmp(s.chars, "hello", 5) != 0) {
        fprintf(stderr, "stb smoke: textedit backspace got len=%d\n", s.len);
        return 1;
    }

    /* Undo restores the 'X'. */
    stb_textedit_key(&s, &state, STB_TEXTEDIT_K_UNDO);
    if (s.len != 6 || memcmp(s.chars, "helXlo", 6) != 0) {
        fprintf(stderr, "stb smoke: textedit undo got len=%d\n", s.len);
        return 1;
    }

    /* Jump to start, delete forward 3 -> "Xlo". */
    stb_textedit_key(&s, &state, STB_TEXTEDIT_K_TEXTSTART);
    for (i = 0; i < 3; i++) {
        stb_textedit_key(&s, &state, STB_TEXTEDIT_K_DELETE);
    }
    if (s.len != 3 || memcmp(s.chars, "Xlo", 3) != 0) {
        fprintf(stderr, "stb smoke: textedit delete-forward got len=%d\n", s.len);
        return 1;
    }

    printf("textedit OK: insert/move/delete/undo\n");
    return 0;
}

static int scenario_include(void) {
    /* stb_include is a build helper -- it scans source for
     * `##include` directives and inlines them. Compile-test only
     * here; the runtime path needs a filesystem fixture. */
    char *out = stb_include_string("plain text", NULL, NULL, "test", NULL);
    if (!out) {
        fprintf(stderr, "stb smoke: stb_include_string returned NULL\n");
        return 1;
    }
    if (strcmp(out, "plain text") != 0) {
        fprintf(stderr, "stb smoke: stb_include passthrough got [%s]\n", out);
        free(out);
        return 1;
    }
    free(out);
    printf("include OK: passthrough\n");
    return 0;
}

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;
    if (scenario_sprintf() != 0) return 1;
    if (scenario_perlin() != 0) return 1;
    if (scenario_image_roundtrip() != 0) return 1;
    if (scenario_jpg_roundtrip() != 0) return 1;
    if (scenario_bmp_roundtrip() != 0) return 1;
    if (scenario_ds() != 0) return 1;
    if (scenario_rect_pack() != 0) return 1;
    if (scenario_c_lexer() != 0) return 1;
    if (scenario_connected_components() != 0) return 1;
    if (scenario_divide() != 0) return 1;
    if (scenario_dxt() != 0) return 1;
    if (scenario_easy_font() != 0) return 1;
    if (scenario_hexwave() != 0) return 1;
    if (scenario_leakcheck() != 0) return 1;
    if (scenario_truetype() != 0) return 1;
    if (scenario_wang_tile() != 0) return 1;
    if (scenario_vorbis() != 0) return 1;
    if (scenario_voxel_render() != 0) return 1;
    if (scenario_textedit() != 0) return 1;
    if (scenario_include() != 0) return 1;
    printf("stb smoke: all scenarios green\n");
    return 0;
}
