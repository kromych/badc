/* Lode Runner pure game logic. References no raylib symbol, so it links
 * into the headless self-test as well as the windowed game. All motion
 * is on the tile grid, one cell per step; the renderer samples this
 * state each frame. */
#include "loderunner.h"

#include <string.h>

/* 30 columns wide; rows shorter than MAP_W are padded with empty cells
 * by level_load, so exact column counts are not required here. */
const char *const LEVEL_ASCII[MAP_H] = {
    "S                            S",
    "S    $$$      HH      $$$     S",
    "S#########    HH    #########SS",
    "S       H     HH     H       SS",
    "S  $    H  $  HH  $  H    $  SS",
    "S#####  H#######H#######  ####S",
    "S    H  H              H  H   S",
    "S $  H  H  G      G    H  H $ S",
    "S####H##H####H----H####H##H####",
    "S    H       H    H       H   S",
    "S $  H  $$$  H    H  $$$  H $  S",
    "S####H#######H----H#######H####",
    "S    H       =    =       H   S",
    "S $$ H  G                 H $$ S",
    "S===========     ============SS",
    "S          H     H           SS",
    "S    P     H     H     $$$    SS",
    "S=============================S",
};

static int in_bounds(int x, int y) {
    return x >= 0 && x < MAP_W && y >= 0 && y < MAP_H;
}

static int is_climbable(const GameState *g, int t) {
    return t == TILE_LADDER || (t == TILE_EXIT_LADDER && g->exit_open);
}

/* A cell an entity may occupy / move into. Bricks and concrete block;
 * a closed exit ladder blocks until every gold is collected. */
static int passable(const GameState *g, int x, int y) {
    if (!in_bounds(x, y)) return 0;
    int t = g->tile[y][x];
    if (t == TILE_BRICK || t == TILE_SOLID) return 0;
    if (t == TILE_EXIT_LADDER && !g->exit_open) return 0;
    return 1;
}

/* True when the entity at (x,y) does not fall: hanging on a ladder or
 * rope, standing on the floor, or standing on top of a brick / solid /
 * ladder. */
static int supported(const GameState *g, int x, int y) {
    int here = g->tile[y][x];
    if (is_climbable(g, here) || here == TILE_ROPE) return 1;
    if (y + 1 >= MAP_H) return 1;
    int below = g->tile[y + 1][x];
    if (below == TILE_BRICK || below == TILE_SOLID) return 1;
    if (is_climbable(g, below)) return 1;
    return 0;
}

static int hole_at(const GameState *g, int x, int y) {
    for (int i = 0; i < g->hole_count; i++)
        if (g->hole_x[i] == x && g->hole_y[i] == y) return 1;
    return 0;
}

/* Carve a temporary hole in the brick diagonally below the digger. dir
 * is -1 (left) or +1 (right). The side cell must be clear so the digger
 * has somewhere to stand. */
static void dig(GameState *g, const Entity *e, int dir) {
    int sx = e->x + dir;
    int hy = e->y + 1;
    if (!in_bounds(sx, hy)) return;
    if (g->tile[hy][sx] != TILE_BRICK) return;
    if (!passable(g, sx, e->y)) return;
    if (hole_at(g, sx, hy)) return;
    g->tile[hy][sx] = TILE_EMPTY;
    if (g->hole_count < MAX_HOLES) {
        g->hole_x[g->hole_count] = sx;
        g->hole_y[g->hole_count] = hy;
        g->hole_timer[g->hole_count] = DIG_REGROW_TICKS;
        g->hole_count++;
    }
}

/* Move one entity one cell from a desired direction. Climbing and
 * falling take priority over walking, matching the classic feel: you
 * cannot steer mid-fall, and a ladder is climbed before a step. */
static void move_entity(GameState *g, Entity *e, int dir_x, int up, int down) {
    int here = g->tile[e->y][e->x];
    if (up && is_climbable(g, here) && passable(g, e->x, e->y - 1)) {
        e->y--;
        return;
    }
    if (down && passable(g, e->x, e->y + 1)) {
        /* Leave a ladder/rope downward or drop into a hole. */
        e->y++;
        return;
    }
    if (!supported(g, e->x, e->y)) {
        if (passable(g, e->x, e->y + 1)) e->y++;
        return;
    }
    if (dir_x && passable(g, e->x + dir_x, e->y)) e->x += dir_x;
}

static void collect_gold(GameState *g, int x, int y) {
    if (g->tile[y][x] == TILE_GOLD) {
        g->tile[y][x] = TILE_EMPTY;
        g->gold_taken++;
        if (g->gold_taken >= g->gold_total) g->exit_open = 1;
    }
}

/* Refill expired holes. An entity caught in a refilling cell dies: the
 * player loses, a guard returns to its start after a delay. */
static void tick_holes(GameState *g) {
    int w = 0;
    for (int i = 0; i < g->hole_count; i++) {
        g->hole_timer[i]--;
        if (g->hole_timer[i] > 0) {
            g->hole_x[w] = g->hole_x[i];
            g->hole_y[w] = g->hole_y[i];
            g->hole_timer[w] = g->hole_timer[i];
            w++;
            continue;
        }
        int hx = g->hole_x[i], hy = g->hole_y[i];
        g->tile[hy][hx] = TILE_BRICK;
        if (g->player.x == hx && g->player.y == hy) g->state = ST_DEAD;
        for (int k = 0; k < g->guard_count; k++) {
            if (g->guard[k].alive && g->guard[k].x == hx && g->guard[k].y == hy) {
                g->guard[k].alive = 0;
                g->guard[k].respawn = GUARD_RESPAWN_TICKS;
            }
        }
    }
    g->hole_count = w;
}

static int sign(int v) { return v > 0 ? 1 : (v < 0 ? -1 : 0); }

/* Greedy chase: close the larger gap first, using a ladder when the
 * row must change. Guards step at two thirds of the player's cadence so
 * the level stays winnable. */
static void step_guards(GameState *g) {
    if (g->tick % 3 == 0) return;
    for (int i = 0; i < g->guard_count; i++) {
        Entity *gd = &g->guard[i];
        if (!gd->alive) {
            if (--gd->respawn <= 0) {
                gd->x = gd->home_x;
                gd->y = gd->home_y;
                gd->alive = 1;
            }
            continue;
        }
        int dx = sign(g->player.x - gd->x);
        int dy = sign(g->player.y - gd->y);
        int here = g->tile[gd->y][gd->x];
        int up = 0, down = 0, mx = 0;
        if (dy < 0 && is_climbable(g, here)) {
            up = 1;
        } else if (dy > 0 && passable(g, gd->x, gd->y + 1) &&
                   (is_climbable(g, here) || !supported(g, gd->x, gd->y))) {
            down = 1;
        } else {
            mx = dx;
        }
        move_entity(g, gd, mx, up, down);
    }
}

static void check_contact(GameState *g) {
    for (int i = 0; i < g->guard_count; i++)
        if (g->guard[i].alive && g->guard[i].x == g->player.x &&
            g->guard[i].y == g->player.y)
            g->state = ST_DEAD;
}

void level_load(GameState *g) {
    memset(g, 0, sizeof(*g));
    g->guard_count = 0;
    g->gold_total = 0;
    for (int y = 0; y < MAP_H; y++) {
        const char *row = LEVEL_ASCII[y];
        int len = (int)strlen(row);
        for (int x = 0; x < MAP_W; x++) {
            char c = x < len ? row[x] : ' ';
            unsigned char t = TILE_EMPTY;
            switch (c) {
                case '#': t = TILE_BRICK; break;
                case '=': t = TILE_SOLID; break;
                case 'H': t = TILE_LADDER; break;
                case '-': t = TILE_ROPE; break;
                case '$': t = TILE_GOLD; g->gold_total++; break;
                case 'S': t = TILE_EXIT_LADDER; break;
                case 'P':
                    g->player.x = x;
                    g->player.y = y;
                    g->player.home_x = x;
                    g->player.home_y = y;
                    g->player.alive = 1;
                    break;
                case 'G':
                    if (g->guard_count < MAX_GUARDS) {
                        Entity *gd = &g->guard[g->guard_count++];
                        gd->x = x;
                        gd->y = y;
                        gd->home_x = x;
                        gd->home_y = y;
                        gd->alive = 1;
                    }
                    break;
                default: break;
            }
            g->tile[y][x] = t;
        }
    }
    g->state = ST_PLAY;
    g->exit_open = 0;
    g->gold_taken = 0;
    g->tick = 0;
}

void level_reset(GameState *g) { level_load(g); }

void level_step(GameState *g, Input in) {
    if (g->state != ST_PLAY) {
        if (in.restart) level_reset(g);
        return;
    }
    if (in.dig_left) dig(g, &g->player, -1);
    if (in.dig_right) dig(g, &g->player, +1);

    int dir = in.right - in.left; /* signed chars: -1, 0, or +1 */
    move_entity(g, &g->player, dir, in.up, in.down);
    collect_gold(g, g->player.x, g->player.y);

    tick_holes(g);
    step_guards(g);
    check_contact(g);

    /* Win on reaching the top row through an open exit ladder. */
    if (g->exit_open && g->player.y == 0) g->state = ST_WIN;

    g->tick++;
}
