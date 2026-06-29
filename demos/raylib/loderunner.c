/* Lode Runner -- a small game built on raylib. badc compiles this and
 * the raylib sources it links against into one standalone binary.
 *
 * The renderer (level_draw) and the frame loop (main) are the only
 * raylib callers; all game rules live in loderunner_logic.c. Run with
 * no arguments for the interactive game, or `--selftest --frames N` to
 * auto-play N frames and exit (used by the headless CI run under a
 * virtual display). */
#include "raylib.h"

#include "loderunner.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static Color tile_fill(int t, int exit_open) {
    switch (t) {
        case TILE_BRICK: return BROWN;
        case TILE_SOLID: return DARKGRAY;
        case TILE_LADDER: return SKYBLUE;
        case TILE_ROPE: return GOLD;
        case TILE_GOLD: return GOLD;
        case TILE_EXIT_LADDER: return exit_open ? GREEN : DARKGRAY;
        default: return BLACK;
    }
}

static void level_draw(const GameState *g) {
    ClearBackground(GetColor(0x101418ff));

    for (int y = 0; y < MAP_H; y++) {
        for (int x = 0; x < MAP_W; x++) {
            int t = g->tile[y][x];
            int px = x * TILE_PX;
            int py = y * TILE_PX;
            switch (t) {
                case TILE_BRICK:
                    DrawRectangle(px, py, TILE_PX, TILE_PX, BROWN);
                    DrawRectangleLines(px, py, TILE_PX, TILE_PX, DARKBROWN);
                    break;
                case TILE_SOLID:
                    DrawRectangle(px, py, TILE_PX, TILE_PX, DARKGRAY);
                    break;
                case TILE_LADDER:
                case TILE_EXIT_LADDER: {
                    Color c = tile_fill(t, g->exit_open);
                    DrawRectangle(px + TILE_PX / 2 - 2, py, 4, TILE_PX, c);
                    DrawLine(px + 5, py + TILE_PX / 2, px + TILE_PX - 5,
                             py + TILE_PX / 2, c);
                    break;
                }
                case TILE_ROPE:
                    DrawLine(px, py + 4, px + TILE_PX, py + 4, GOLD);
                    break;
                case TILE_GOLD:
                    DrawRectangle(px + 7, py + 7, TILE_PX - 14, TILE_PX - 14,
                                  GOLD);
                    DrawRectangleLines(px + 7, py + 7, TILE_PX - 14,
                                       TILE_PX - 14, ORANGE);
                    break;
                default:
                    break;
            }
        }
    }

    for (int i = 0; i < g->guard_count; i++) {
        if (!g->guard[i].alive) continue;
        DrawRectangle(g->guard[i].x * TILE_PX + 3, g->guard[i].y * TILE_PX + 3,
                      TILE_PX - 6, TILE_PX - 6, RED);
    }
    DrawRectangle(g->player.x * TILE_PX + 3, g->player.y * TILE_PX + 3,
                  TILE_PX - 6, TILE_PX - 6, LIME);

    int hud_y = MAP_H * TILE_PX + 8;
    DrawText(TextFormat("GOLD %d / %d", g->gold_taken, g->gold_total), 8, hud_y,
             20, RAYWHITE);
    if (g->exit_open)
        DrawText("EXIT OPEN - climb the ladders!", 200, hud_y, 20, GREEN);
    if (g->state == ST_WIN)
        DrawText("LEVEL CLEAR - press R", MAP_W * TILE_PX / 2 - 110,
                 MAP_H * TILE_PX / 2, 30, GOLD);
    if (g->state == ST_DEAD)
        DrawText("CAUGHT - press R", MAP_W * TILE_PX / 2 - 90,
                 MAP_H * TILE_PX / 2, 30, RED);
}

static Input read_input(void) {
    Input in = {0};
    in.left = IsKeyDown(KEY_LEFT) || IsKeyDown(KEY_A);
    in.right = IsKeyDown(KEY_RIGHT) || IsKeyDown(KEY_D);
    in.up = IsKeyDown(KEY_UP) || IsKeyDown(KEY_W);
    in.down = IsKeyDown(KEY_DOWN) || IsKeyDown(KEY_S);
    in.dig_left = IsKeyPressed(KEY_Z) || IsKeyPressed(KEY_Q);
    in.dig_right = IsKeyPressed(KEY_X) || IsKeyPressed(KEY_E);
    in.restart = IsKeyPressed(KEY_R);
    return in;
}

/* A scripted input stream for --selftest: cycles through walking,
 * digging and climbing so the headless run exercises every draw path. */
static Input scripted_input(int frame) {
    Input in = {0};
    int phase = (frame / 12) % 4;
    if (phase == 0) in.right = 1;
    else if (phase == 1) in.dig_right = (frame % 12) == 0;
    else if (phase == 2) in.left = 1;
    else in.up = 1;
    return in;
}

/* rlgl's framebuffer read-back: returns width*height*4 RGBA bytes,
 * bottom-up (OpenGL origin). Declared here rather than including rlgl.h. */
extern unsigned char *rlReadScreenPixels(int width, int height);

/* Write an RGB PPM from the framebuffer, flipping to a top-down image.
 * Lets the rendered frame be inspected without a windowing session. */
static int dump_frame_ppm(const char *path) {
    int w = GetScreenWidth();
    int h = GetScreenHeight();
    unsigned char *rgba = rlReadScreenPixels(w, h);
    if (!rgba) return 1;
    FILE *f = fopen(path, "wb");
    if (!f) {
        free(rgba);
        return 1;
    }
    fprintf(f, "P6\n%d %d\n255\n", w, h);
    for (int y = h - 1; y >= 0; y--) {
        for (int x = 0; x < w; x++) {
            unsigned char *p = rgba + (y * w + x) * 4;
            fputc(p[0], f);
            fputc(p[1], f);
            fputc(p[2], f);
        }
    }
    fclose(f);
    free(rgba);
    return 0;
}

int main(int argc, char **argv) {
    int selftest = 0;
    int frames = 0;
    const char *dump_path = NULL;
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--selftest") == 0) {
            selftest = 1;
        } else if (strcmp(argv[i], "--frames") == 0 && i + 1 < argc) {
            frames = atoi(argv[++i]);
        } else if (strcmp(argv[i], "--dump-frame") == 0 && i + 1 < argc) {
            dump_path = argv[++i];
            selftest = 1;
        }
    }
    if (selftest && frames <= 0) frames = 300;
    if (dump_path && frames > 8) frames = 8;

    GameState g;
    level_load(&g);

    InitWindow(MAP_W * TILE_PX, MAP_H * TILE_PX + HUD_PX, "Lode Runner (badc)");
    SetTargetFPS(12);

    int frame = 0;
    while (!WindowShouldClose()) {
        Input in = selftest ? scripted_input(frame) : read_input();
        level_step(&g, in);

        BeginDrawing();
        level_draw(&g);
        EndDrawing();

        frame++;
        if (dump_path && frame >= frames) {
            if (dump_frame_ppm(dump_path) == 0)
                TraceLog(LOG_INFO, "FRAME: dumped to %s", dump_path);
            break;
        }
        if (selftest && frame >= frames) break;
    }

    CloseWindow();
    return 0;
}
