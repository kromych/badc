/* Lode Runner game state and pure-logic interface.
 *
 * The logic in loderunner_logic.c references no raylib symbol, so the
 * headless self-test (test_loderunner.c) links it without the graphics
 * library. The renderer and frame loop live in loderunner.c and are the
 * only place raylib is called. The split keeps level_step deterministic
 * and independently testable. */
#ifndef LODERUNNER_H
#define LODERUNNER_H

#define MAP_W 30
#define MAP_H 18
#define TILE_PX 28
#define HUD_PX 36
#define MAX_GUARDS 3
#define MAX_HOLES (MAP_W * MAP_H)
#define DIG_REGROW_TICKS 90
#define GUARD_RESPAWN_TICKS 24

/* Grid cells. The ASCII level uses these glyphs:
 *   '#' brick (diggable)   '=' solid (undiggable)   'H' ladder
 *   '-' rope               '$' gold                 'S' exit ladder
 *   ' ' empty              'P' player start         'G' guard start
 * 'P'/'G' become empty cells in the grid; their coordinates seed the
 * entities. */
enum {
    TILE_EMPTY = 0,
    TILE_BRICK,
    TILE_SOLID,
    TILE_LADDER,
    TILE_ROPE,
    TILE_GOLD,
    TILE_EXIT_LADDER
};

enum { ST_PLAY = 0, ST_WIN = 1, ST_DEAD = 2 };

typedef struct {
    signed char left, right, up, down; /* held this frame */
    signed char dig_left, dig_right;   /* edge this frame */
    signed char restart;               /* edge this frame */
} Input;

typedef struct {
    int x, y;       /* tile coordinates */
    int home_x, home_y;
    int alive;      /* guards only; player is always 1 */
    int respawn;    /* ticks until a dead guard returns */
} Entity;

typedef struct {
    unsigned char tile[MAP_H][MAP_W];

    int hole_x[MAX_HOLES];
    int hole_y[MAX_HOLES];
    int hole_timer[MAX_HOLES];
    int hole_count;

    Entity player;
    Entity guard[MAX_GUARDS];
    int guard_count;

    int gold_total, gold_taken;
    int exit_open;
    int state;
    unsigned long tick;
} GameState;

/* The built-in level. Defined in loderunner_logic.c. */
extern const char *const LEVEL_ASCII[MAP_H];

/* Pure logic -- no raylib symbol referenced. */
void level_load(GameState *g);
void level_reset(GameState *g);
void level_step(GameState *g, Input in);

#endif /* LODERUNNER_H */
