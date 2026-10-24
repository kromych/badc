/*
 * Runs Nuklear's demo windows headlessly. Each frame takes scripted input,
 * lays out the windows, converts the command queue to a vertex buffer with
 * nk_convert and renders it with the rawfb software renderer into a memory
 * framebuffer. One line per frame gives the 64-bit FNV-1a digests of the
 * command queue, of the converted draw commands, vertices and indices, and
 * of the framebuffer, so two builds of this program agree only when they
 * computed the same frames.
 *
 * Input events name their target by the text of a widget drawn in the
 * previous frame; the event acts on the centre of that text's rectangle.
 *
 * Usage: headless [dir]  -- with dir, the last frame of each scene is
 * written there as <scene>.ppm. Built with -DHEADLESS_TRACE it prints the
 * running command digest after each command to stderr, which finds the
 * first command two builds disagree on.
 */
#include <limits.h>
#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define NK_INCLUDE_FIXED_TYPES
#define NK_INCLUDE_STANDARD_IO
#define NK_INCLUDE_STANDARD_VARARGS
#define NK_INCLUDE_DEFAULT_ALLOCATOR
#define NK_INCLUDE_VERTEX_BUFFER_OUTPUT
#define NK_INCLUDE_FONT_BAKING
#define NK_INCLUDE_DEFAULT_FONT
#define NK_INCLUDE_SOFTWARE_FONT
#define NK_IMPLEMENTATION
#define NK_RAWFB_IMPLEMENTATION
#include "nuklear.h"
#include "demo/rawfb/nuklear_rawfb.h"

#define INCLUDE_STYLE
#include "demo/common/style.c"
#include "demo/common/calculator.c"
#include "demo/common/overview.c"
#include "demo/common/node_editor.c"
#include "demo/common/canvas.c"
#include "demo/common/style_configurator.c"

#define FB_W 800
#define FB_H 600
#define MAX_LABELS 1024

typedef unsigned long long u64;

static unsigned int framebuffer[FB_W * FB_H];
static unsigned char tex_scratch[512 * 512];
static unsigned char vtx_mem[1 << 21];
static unsigned char idx_mem[1 << 19];
static unsigned char drawcmd_mem[1 << 18];

static u64 fnv(u64 h, const void *p, size_t n)
{
    const unsigned char *b = p;
    while (n--) {
        h ^= *b++;
        h *= 1099511628211ULL;
    }
    return h;
}

static u64 fnv_int(u64 h, long v)
{
    unsigned char b[4];
    b[0] = (unsigned char)v;
    b[1] = (unsigned char)(v >> 8);
    b[2] = (unsigned char)(v >> 16);
    b[3] = (unsigned char)(v >> 24);
    return fnv(h, b, 4);
}

static u64 fnv_float(u64 h, float f)
{
    unsigned int bits;
    memcpy(&bits, &f, sizeof bits);
    return fnv_int(h, (long)bits);
}

static u64 fnv_color(u64 h, struct nk_color c)
{
    unsigned char b[4];
    b[0] = c.r; b[1] = c.g; b[2] = c.b; b[3] = c.a;
    return fnv(h, b, 4);
}

static u64 fnv_points(u64 h, const struct nk_vec2i *p, int n)
{
    int i;
    for (i = 0; i < n; ++i) {
        h = fnv_int(h, p[i].x);
        h = fnv_int(h, p[i].y);
    }
    return h;
}

/* Text drawn in the last frame, for the input script to aim at. */
struct label {
    char text[64];
    int x, y, w, h;
};
static struct label labels[MAX_LABELS];
static int label_count;

static void record_label(const struct nk_command_text *t)
{
    struct label *l;
    int n = t->length < 63 ? t->length : 63;
    if (label_count == MAX_LABELS)
        return;
    l = &labels[label_count++];
    memcpy(l->text, t->string, (size_t)n);
    l->text[n] = 0;
    l->x = t->x; l->y = t->y; l->w = t->w; l->h = t->h;
}

static const struct label *find_label(const char *text)
{
    int i;
    for (i = 0; i < label_count; ++i)
        if (!strcmp(labels[i].text, text))
            return &labels[i];
    return NULL;
}

/* Digest of the command queue by field, never by raw bytes: the commands
 * carry padding and pointers. */
static u64 hash_commands(struct nk_context *ctx, int *count)
{
    const struct nk_command *cmd;
    u64 h = 14695981039346656037ULL;
    *count = 0;
    label_count = 0;
    nk_foreach(cmd, ctx) {
        ++*count;
        h = fnv_int(h, cmd->type);
        switch (cmd->type) {
        case NK_COMMAND_SCISSOR: {
            const struct nk_command_scissor *s = (const void *)cmd;
            h = fnv_int(h, s->x); h = fnv_int(h, s->y);
            h = fnv_int(h, s->w); h = fnv_int(h, s->h);
        } break;
        case NK_COMMAND_LINE: {
            const struct nk_command_line *l = (const void *)cmd;
            h = fnv_int(h, l->line_thickness);
            h = fnv_points(h, &l->begin, 1); h = fnv_points(h, &l->end, 1);
            h = fnv_color(h, l->color);
        } break;
        case NK_COMMAND_CURVE: {
            const struct nk_command_curve *c = (const void *)cmd;
            h = fnv_int(h, c->line_thickness);
            h = fnv_points(h, &c->begin, 1); h = fnv_points(h, &c->end, 1);
            h = fnv_points(h, c->ctrl, 2);
            h = fnv_color(h, c->color);
        } break;
        case NK_COMMAND_RECT: {
            const struct nk_command_rect *r = (const void *)cmd;
            h = fnv_int(h, r->rounding); h = fnv_int(h, r->line_thickness);
            h = fnv_int(h, r->x); h = fnv_int(h, r->y);
            h = fnv_int(h, r->w); h = fnv_int(h, r->h);
            h = fnv_color(h, r->color);
        } break;
        case NK_COMMAND_RECT_FILLED: {
            const struct nk_command_rect_filled *r = (const void *)cmd;
            h = fnv_int(h, r->rounding);
            h = fnv_int(h, r->x); h = fnv_int(h, r->y);
            h = fnv_int(h, r->w); h = fnv_int(h, r->h);
            h = fnv_color(h, r->color);
        } break;
        case NK_COMMAND_RECT_MULTI_COLOR: {
            const struct nk_command_rect_multi_color *r = (const void *)cmd;
            h = fnv_int(h, r->x); h = fnv_int(h, r->y);
            h = fnv_int(h, r->w); h = fnv_int(h, r->h);
            h = fnv_color(h, r->left); h = fnv_color(h, r->top);
            h = fnv_color(h, r->bottom); h = fnv_color(h, r->right);
        } break;
        case NK_COMMAND_CIRCLE: {
            const struct nk_command_circle *c = (const void *)cmd;
            h = fnv_int(h, c->x); h = fnv_int(h, c->y);
            h = fnv_int(h, c->line_thickness);
            h = fnv_int(h, c->w); h = fnv_int(h, c->h);
            h = fnv_color(h, c->color);
        } break;
        case NK_COMMAND_CIRCLE_FILLED: {
            const struct nk_command_circle_filled *c = (const void *)cmd;
            h = fnv_int(h, c->x); h = fnv_int(h, c->y);
            h = fnv_int(h, c->w); h = fnv_int(h, c->h);
            h = fnv_color(h, c->color);
        } break;
        case NK_COMMAND_ARC: {
            const struct nk_command_arc *a = (const void *)cmd;
            h = fnv_int(h, a->cx); h = fnv_int(h, a->cy);
            h = fnv_int(h, a->r); h = fnv_int(h, a->line_thickness);
            h = fnv_float(h, a->a[0]); h = fnv_float(h, a->a[1]);
            h = fnv_color(h, a->color);
        } break;
        case NK_COMMAND_ARC_FILLED: {
            const struct nk_command_arc_filled *a = (const void *)cmd;
            h = fnv_int(h, a->cx); h = fnv_int(h, a->cy); h = fnv_int(h, a->r);
            h = fnv_float(h, a->a[0]); h = fnv_float(h, a->a[1]);
            h = fnv_color(h, a->color);
        } break;
        case NK_COMMAND_TRIANGLE: {
            const struct nk_command_triangle *t = (const void *)cmd;
            h = fnv_int(h, t->line_thickness);
            h = fnv_points(h, &t->a, 1); h = fnv_points(h, &t->b, 1);
            h = fnv_points(h, &t->c, 1);
            h = fnv_color(h, t->color);
        } break;
        case NK_COMMAND_TRIANGLE_FILLED: {
            const struct nk_command_triangle_filled *t = (const void *)cmd;
            h = fnv_points(h, &t->a, 1); h = fnv_points(h, &t->b, 1);
            h = fnv_points(h, &t->c, 1);
            h = fnv_color(h, t->color);
        } break;
        case NK_COMMAND_POLYGON:
        case NK_COMMAND_POLYLINE: {
            const struct nk_command_polygon *p = (const void *)cmd;
            h = fnv_color(h, p->color); h = fnv_int(h, p->line_thickness);
            h = fnv_int(h, p->point_count);
            h = fnv_points(h, p->points, p->point_count);
        } break;
        case NK_COMMAND_POLYGON_FILLED: {
            const struct nk_command_polygon_filled *p = (const void *)cmd;
            h = fnv_color(h, p->color); h = fnv_int(h, p->point_count);
            h = fnv_points(h, p->points, p->point_count);
        } break;
        case NK_COMMAND_TEXT: {
            const struct nk_command_text *t = (const void *)cmd;
            /* No background: nk_tree_state_base leaves a tab header's
             * text background unset, so it holds an indeterminate value
             * (C99 6.7.8p10). The renderers do not read it. */
            h = fnv_color(h, t->foreground);
            h = fnv_int(h, t->x); h = fnv_int(h, t->y);
            h = fnv_int(h, t->w); h = fnv_int(h, t->h);
            h = fnv_float(h, t->height); h = fnv_int(h, t->length);
            h = fnv(h, t->string, (size_t)t->length);
            record_label(t);
        } break;
        case NK_COMMAND_IMAGE: {
            const struct nk_command_image *i = (const void *)cmd;
            h = fnv_int(h, i->x); h = fnv_int(h, i->y);
            h = fnv_int(h, i->w); h = fnv_int(h, i->h);
            h = fnv_color(h, i->col);
        } break;
        default:
            break;
        }
#ifdef HEADLESS_TRACE
        fprintf(stderr, "cmd %d %016llx\n", cmd->type, h);
        if (cmd->type == NK_COMMAND_TEXT) {
            const struct nk_command_text *t = (const void *)cmd;
            fprintf(stderr, "  text '%.*s' bg %02x%02x%02x%02x fg %02x%02x%02x%02x %d %d %d %d %a %d\n",
                    t->length, t->string, t->background.r, t->background.g, t->background.b,
                    t->background.a, t->foreground.r, t->foreground.g, t->foreground.b,
                    t->foreground.a, t->x, t->y, t->w, t->h, t->height, t->length);
        }
#endif
    }
    return h;
}

struct vertex {
    float position[2];
    float uv[2];
    nk_byte col[4];
};

/* nk_convert's output: the draw commands by field, the vertex and index
 * buffers by bytes (the vertex has no padding). */
static void convert(struct nk_context *ctx,
                    u64 *hcmd, u64 *hvtx, u64 *hidx, int *nvtx)
{
    static const struct nk_draw_vertex_layout_element layout[] = {
        {NK_VERTEX_POSITION, NK_FORMAT_FLOAT, NK_OFFSETOF(struct vertex, position)},
        {NK_VERTEX_TEXCOORD, NK_FORMAT_FLOAT, NK_OFFSETOF(struct vertex, uv)},
        {NK_VERTEX_COLOR, NK_FORMAT_R8G8B8A8, NK_OFFSETOF(struct vertex, col)},
        {NK_VERTEX_LAYOUT_END}
    };
    struct nk_convert_config cfg;
    struct nk_buffer cmds, vbuf, ibuf;
    const struct nk_draw_command *dc;
    u64 h = 14695981039346656037ULL;

    memset(&cfg, 0, sizeof cfg);
    cfg.vertex_layout = layout;
    cfg.vertex_size = sizeof(struct vertex);
    cfg.vertex_alignment = NK_ALIGNOF(struct vertex);
    cfg.tex_null.texture = nk_handle_id(0);
    cfg.tex_null.uv = nk_vec2(0.0f, 0.0f);
    cfg.circle_segment_count = 22;
    cfg.curve_segment_count = 22;
    cfg.arc_segment_count = 22;
    cfg.global_alpha = 1.0f;
    cfg.shape_AA = NK_ANTI_ALIASING_ON;
    cfg.line_AA = NK_ANTI_ALIASING_ON;

    memset(vtx_mem, 0, sizeof vtx_mem);
    memset(idx_mem, 0, sizeof idx_mem);
    nk_buffer_init_fixed(&cmds, drawcmd_mem, sizeof drawcmd_mem);
    nk_buffer_init_fixed(&vbuf, vtx_mem, sizeof vtx_mem);
    nk_buffer_init_fixed(&ibuf, idx_mem, sizeof idx_mem);
    if (nk_convert(ctx, &cmds, &vbuf, &ibuf, &cfg) != NK_CONVERT_SUCCESS) {
        fprintf(stderr, "nk_convert failed\n");
        exit(2);
    }
    nk_draw_foreach(dc, ctx, &cmds) {
        if (!dc->elem_count)
            continue;
        h = fnv_int(h, (long)dc->elem_count);
        h = fnv_float(h, dc->clip_rect.x); h = fnv_float(h, dc->clip_rect.y);
        h = fnv_float(h, dc->clip_rect.w); h = fnv_float(h, dc->clip_rect.h);
    }
    *hcmd = h;
    *nvtx = (int)(vbuf.needed / sizeof(struct vertex));
    *hvtx = fnv(14695981039346656037ULL, vtx_mem, vbuf.needed);
    *hidx = fnv(14695981039346656037ULL, idx_mem, ibuf.needed);
}

/* rawfb asserts on an arc, which it does not draw; nk_convert has turned
 * the arcs into vertices already. */
static void drop_arcs(struct nk_context *ctx)
{
    const struct nk_command *cmd;
    nk_foreach(cmd, ctx)
        if (cmd->type == NK_COMMAND_ARC || cmd->type == NK_COMMAND_ARC_FILLED)
            ((struct nk_command *)cmd)->type = NK_COMMAND_NOP;
}

enum ev_kind { EV_CLICK, EV_PRESS, EV_DRAG, EV_RELEASE, EV_TEXT, EV_KEY, EV_SCROLL, EV_THEME };

struct event {
    int frame;
    enum ev_kind kind;
    const char *target; /* label text, or the characters EV_TEXT types */
    int dx, dy;         /* offset from the target's centre, or the drag step */
};

enum scene_id { SC_DEMO, SC_OVERVIEW, SC_NODES, SC_CANVAS, SC_STYLE };

struct scene {
    const char *name;
    enum scene_id id;
    int frames;
    const struct event *events;
};

static const struct event demo_events[] = {
    {1, EV_CLICK, "button", 0, 0},
    {3, EV_CLICK, "hard", 0, 0},
    {5, EV_CLICK, "1", 0, 0},
    {7, EV_CLICK, "2", 0, 0},
    {9, EV_CLICK, "+", 0, 0},
    {11, EV_CLICK, "7", 0, 0},
    {13, EV_CLICK, "*", 0, 0},
    {15, EV_CLICK, "3", 0, 0},
    {17, EV_CLICK, "=", 0, 0},
    {19, EV_CLICK, "57.00", 0, 0},
    {21, EV_TEXT, "9", 0, 0},
    {22, EV_KEY, NULL, NK_KEY_BACKSPACE, 1},
    {23, EV_KEY, NULL, NK_KEY_BACKSPACE, 0},
    {24, EV_KEY, NULL, NK_KEY_LEFT, 1},
    {25, EV_KEY, NULL, NK_KEY_LEFT, 0},
    {26, EV_TEXT, "4", 0, 0},
    {-1, EV_CLICK, NULL, 0, 0}
};

static const struct event overview_events[] = {
    {1, EV_CLICK, "Widgets", 0, 0},
    {3, EV_CLICK, "Basic", 0, 0},
    {5, EV_SCROLL, "Basic", 0, -3},
    {7, EV_SCROLL, "Overview", 0, 3},
    {9, EV_CLICK, "Basic", 0, 0},
    {11, EV_CLICK, "Selectable", 0, 0},
    {13, EV_CLICK, "Selectable", 0, 0},
    {15, EV_CLICK, "Widgets", 0, 0},
    {17, EV_CLICK, "Chart", 0, 0},
    {19, EV_CLICK, "Chart", 0, 0},
    {21, EV_CLICK, "Layout", 0, 0},
    {23, EV_CLICK, "Layout", 0, 0},
    {25, EV_PRESS, "Overview", 0, 0},
    {26, EV_DRAG, NULL, 40, 25},
    {27, EV_DRAG, NULL, 40, 25},
    {28, EV_RELEASE, NULL, 0, 0},
    {-1, EV_CLICK, NULL, 0, 0}
};

static const struct event node_events[] = {
    {1, EV_PRESS, "Source", 0, 0},
    {2, EV_DRAG, NULL, 30, 20},
    {3, EV_DRAG, NULL, 30, 20},
    {4, EV_RELEASE, NULL, 0, 0},
    {5, EV_CLICK, "Combine", 0, 0},
    {-1, EV_CLICK, NULL, 0, 0}
};

static const struct event canvas_events[] = {
    {-1, EV_CLICK, NULL, 0, 0}
};

static const struct event style_events[] = {
    {0, EV_THEME, NULL, THEME_WHITE, 0},
    {2, EV_THEME, NULL, THEME_RED, 0},
    {4, EV_THEME, NULL, THEME_BLUE, 0},
    {6, EV_THEME, NULL, THEME_DARK, 0},
    {8, EV_THEME, NULL, THEME_DRACULA, 0},
    {10, EV_THEME, NULL, THEME_CATPPUCCIN_LATTE, 0},
    {12, EV_THEME, NULL, THEME_CATPPUCCIN_FRAPPE, 0},
    {14, EV_THEME, NULL, THEME_CATPPUCCIN_MACCHIATO, 0},
    {16, EV_THEME, NULL, THEME_CATPPUCCIN_MOCHA, 0},
    {18, EV_CLICK, "Global Colors", 0, 0},
    {20, EV_THEME, NULL, THEME_BLACK, 0},
    {-1, EV_CLICK, NULL, 0, 0}
};

static const struct scene scenes[] = {
    {"demo", SC_DEMO, 28, demo_events},
    {"overview", SC_OVERVIEW, 30, overview_events},
    {"nodes", SC_NODES, 7, node_events},
    {"canvas", SC_CANVAS, 3, canvas_events},
    {"style", SC_STYLE, 22, style_events},
};

static struct nk_color color_table[NK_COLOR_COUNT];
static int pointer_x, pointer_y, pointer_down;

static void aim(const struct event *e)
{
    const struct label *l = find_label(e->target);
    if (!l) {
        fprintf(stderr, "input script: no text \"%s\" in the previous frame\n", e->target);
        exit(3);
    }
    pointer_x = l->x + l->w / 2 + e->dx;
    pointer_y = l->y + l->h / 2 + e->dy;
}

/* Feeds the frame's events. A click presses here and releases on the next
 * frame, as a pointer does. */
static void feed(struct nk_context *ctx, const struct event *ev, int frame,
                 int *release_next)
{
    const struct event *e;
    if (*release_next) {
        nk_input_button(ctx, NK_BUTTON_LEFT, pointer_x, pointer_y, 0);
        pointer_down = 0;
        *release_next = 0;
    }
    for (e = ev; e->frame >= 0; ++e) {
        if (e->frame != frame)
            continue;
        switch (e->kind) {
        case EV_CLICK:
        case EV_PRESS:
            aim(e);
            nk_input_motion(ctx, pointer_x, pointer_y);
            nk_input_button(ctx, NK_BUTTON_LEFT, pointer_x, pointer_y, 1);
            pointer_down = 1;
            *release_next = e->kind == EV_CLICK;
            break;
        case EV_DRAG:
            pointer_x += e->dx;
            pointer_y += e->dy;
            nk_input_motion(ctx, pointer_x, pointer_y);
            break;
        case EV_RELEASE:
            nk_input_button(ctx, NK_BUTTON_LEFT, pointer_x, pointer_y, 0);
            pointer_down = 0;
            break;
        case EV_TEXT: {
            const char *c;
            for (c = e->target; *c; ++c)
                nk_input_char(ctx, *c);
        } break;
        case EV_KEY:
            nk_input_key(ctx, (enum nk_keys)e->dx, e->dy);
            break;
        case EV_SCROLL:
            aim(e);
            nk_input_motion(ctx, pointer_x, pointer_y);
            nk_input_scroll(ctx, nk_vec2(0, (float)e->dy));
            break;
        case EV_THEME:
            set_style(ctx, (enum theme)e->dx);
            break;
        }
    }
}

static void draw(struct nk_context *ctx, enum scene_id id)
{
    switch (id) {
    case SC_DEMO:
        if (nk_begin(ctx, "Demo", nk_rect(250, 50, 220, 220),
                     NK_WINDOW_BORDER | NK_WINDOW_MOVABLE | NK_WINDOW_CLOSABLE |
                     NK_WINDOW_MINIMIZABLE | NK_WINDOW_TITLE)) {
            enum { EASY, HARD };
            static int op = EASY;
            static int property = 20;
            nk_layout_row_static(ctx, 30, 80, 1);
            if (nk_button_label(ctx, "button"))
                printf("button pressed\n");
            nk_layout_row_dynamic(ctx, 30, 2);
            if (nk_option_label(ctx, "easy", op == EASY)) op = EASY;
            if (nk_option_label(ctx, "hard", op == HARD)) op = HARD;
            nk_layout_row_dynamic(ctx, 25, 1);
            nk_property_int(ctx, "Compression:", 0, &property, 100, 10, 1);
        }
        nk_end(ctx);
        calculator(ctx);
        break;
    case SC_OVERVIEW:
        overview(ctx);
        break;
    case SC_NODES:
        node_editor(ctx);
        break;
    case SC_CANVAS:
        canvas(ctx);
        break;
    case SC_STYLE:
        style_configurator(ctx, color_table);
        calculator(ctx);
        break;
    }
}

/* The calculator's display: the first text with a decimal point after
 * the Demo window's last label. */
static void print_display(void)
{
    const struct label *l = find_label("Compression:");
    int i = l ? (int)(l - labels) + 1 : 0;
    for (; i < label_count; ++i)
        if (strchr(labels[i].text, '.')) {
            printf("calculator shows %s\n", labels[i].text);
            return;
        }
    printf("calculator display not found\n");
}

static void write_ppm(const char *dir, const char *name)
{
    char path[1024];
    FILE *f;
    int i;
    snprintf(path, sizeof path, "%s/%s.ppm", dir, name);
    f = fopen(path, "wb");
    if (!f) {
        fprintf(stderr, "cannot write %s\n", path);
        exit(4);
    }
    fprintf(f, "P6\n%d %d\n255\n", FB_W, FB_H);
    for (i = 0; i < FB_W * FB_H; ++i) {
        unsigned int p = framebuffer[i];
        unsigned char rgb[3];
        rgb[0] = (unsigned char)(p >> 16);
        rgb[1] = (unsigned char)(p >> 8);
        rgb[2] = (unsigned char)p;
        fwrite(rgb, 1, 3, f);
    }
    fclose(f);
}

int main(int argc, char **argv)
{
    struct rawfb_pl pl;
    struct rawfb_context *rawfb;
    struct nk_context *ctx;
    size_t s;
    int total = 0;

    memset(&pl, 0, sizeof pl);
    pl.bytesPerPixel = 4;
    pl.rshift = 16;
    pl.gshift = 8;
    pl.bshift = 0;
    pl.ashift = 24;
    rawfb = nk_rawfb_init(framebuffer, tex_scratch, FB_W, FB_H, FB_W * 4, pl);
    if (!rawfb) {
        fprintf(stderr, "nk_rawfb_init failed\n");
        return 1;
    }
    ctx = &rawfb->ctx;
    memcpy(color_table, nk_default_color_style, sizeof color_table);
    printf("font atlas %dx%d digest %016llx\n", rawfb->font_tex.w, rawfb->font_tex.h,
           fnv(14695981039346656037ULL, tex_scratch,
               (size_t)rawfb->font_tex.w * (size_t)rawfb->font_tex.h));

    for (s = 0; s < sizeof scenes / sizeof scenes[0]; ++s) {
        const struct scene *sc = &scenes[s];
        int frame, release_next = 0;
        label_count = 0;
        for (frame = 0; frame < sc->frames; ++frame) {
            u64 hq, hc, hv, hi, hf;
            int ncmd, nvtx;
            nk_input_begin(ctx);
            feed(ctx, sc->events, frame, &release_next);
            nk_input_end(ctx);
            ctx->delta_time_seconds = 1.0f / 60.0f;
            draw(ctx, sc->id);
            hq = hash_commands(ctx, &ncmd);
            convert(ctx, &hc, &hv, &hi, &nvtx);
            drop_arcs(ctx);
            nk_rawfb_render(rawfb, nk_rgb(30, 30, 30), 1);
            hf = fnv(14695981039346656037ULL, framebuffer, sizeof framebuffer);
            printf("%s %2d: cmds %4d %016llx draw %016llx vtx %5d %016llx idx %016llx fb %016llx\n",
                   sc->name, frame, ncmd, hq, hc, nvtx, hv, hi, hf);
            if (sc->id == SC_DEMO && (frame == 18 || frame == sc->frames - 1))
                print_display();
            ++total;
        }
        if (argc > 1)
            write_ppm(argv[1], sc->name);
        set_style(ctx, THEME_BLACK);
    }
    printf("%d frames\n", total);
    nk_rawfb_shutdown(rawfb);
    return 0;
}
