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

/* Optional assets, loaded when `--assets <dir>` is passed: a 64x16
 * sprite sheet (four 16x16 tiles) and a pickup sound. When absent the
 * game draws procedurally and runs silent, so it still builds and runs
 * on a host without an audio backend. */
static Texture2D g_sheet;
static int g_assets;
#ifdef GAME_AUDIO
static Sound g_pickup;
#endif

static void load_assets(const char *dir) {
    char path[1024];
    snprintf(path, sizeof path, "%s/tiles.png", dir);
    g_sheet = LoadTexture(path);
    g_assets = (g_sheet.id != 0);
#ifdef GAME_AUDIO
    // Real playback is wired where the audio backend is built (macOS
    // CoreAudio today); elsewhere the sprites still load and draw.
    InitAudioDevice();
    snprintf(path, sizeof path, "%s/pickup.wav", dir);
    g_pickup = LoadSound(path);
#endif
}

static void unload_assets(void) {
    if (g_assets) UnloadTexture(g_sheet);
#ifdef GAME_AUDIO
    UnloadSound(g_pickup);
    if (IsAudioDeviceReady()) CloseAudioDevice();
#endif
}

/* Draw sprite tile `idx` (0..3) from the sheet at the tile cell. */
static void draw_sprite(int idx, int px, int py) {
    Rectangle src = {idx * 16.0f, 0, 16, 16};
    Rectangle dst = {(float)px, (float)py, TILE_PX, TILE_PX};
    DrawTexturePro(g_sheet, src, dst, (Vector2){0, 0}, 0, WHITE);
}

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
                    if (g_assets) {
                        draw_sprite(1, px, py);
                    } else {
                        DrawRectangle(px + 7, py + 7, TILE_PX - 14,
                                      TILE_PX - 14, GOLD);
                        DrawRectangleLines(px + 7, py + 7, TILE_PX - 14,
                                           TILE_PX - 14, ORANGE);
                    }
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
    if (g_assets)
        draw_sprite(0, g->player.x * TILE_PX, g->player.y * TILE_PX);
    else
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
    const char *assets_dir = NULL;
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--selftest") == 0) {
            selftest = 1;
        } else if (strcmp(argv[i], "--frames") == 0 && i + 1 < argc) {
            frames = atoi(argv[++i]);
        } else if (strcmp(argv[i], "--dump-frame") == 0 && i + 1 < argc) {
            dump_path = argv[++i];
            selftest = 1;
        } else if (strcmp(argv[i], "--assets") == 0 && i + 1 < argc) {
            assets_dir = argv[++i];
        }
    }
    if (selftest && frames <= 0) frames = 300;
    if (dump_path && frames > 8) frames = 8;

    GameState g;
    level_load(&g);

    InitWindow(MAP_W * TILE_PX, MAP_H * TILE_PX + HUD_PX, "Lode Runner (badc)");
    SetTargetFPS(12);
    if (assets_dir) load_assets(assets_dir);

    int prev_gold = g.gold_taken;
    int frame = 0;
    while (!WindowShouldClose()) {
        Input in = selftest ? scripted_input(frame) : read_input();
        level_step(&g, in);
#ifdef GAME_AUDIO
        if (g_assets && g.gold_taken > prev_gold) PlaySound(g_pickup);
#endif
        prev_gold = g.gold_taken;

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

    unload_assets();
    CloseWindow();
    return 0;
}
