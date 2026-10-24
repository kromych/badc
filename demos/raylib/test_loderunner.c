/* Headless self-test for the pure Lode Runner logic. Links
 * loderunner_logic.c only -- no raylib symbol -- so it runs on any host
 * and under register pressure as a codegen regression for the game
 * code. Each check builds a small deterministic scenario and asserts on
 * the resulting state. Returns 0 on success, or the failing check's
 * number. */
#include "loderunner.h"

#include <stdio.h>
#include <string.h>

static void empty_grid(GameState *g) {
    memset(g, 0, sizeof(*g));
    g->state = ST_PLAY;
    g->player.alive = 1;
}

/* Extend `seen` with every cell the player reaches from a seen one, one
 * step of the real logic at a time, with the guards removed. */
static void reach(const GameState *base, int exit_open, unsigned char seen[MAP_H][MAP_W]) {
    static int qx[MAP_W * MAP_H], qy[MAP_W * MAP_H];
    int n = 0;
    for (int y = 0; y < MAP_H; y++)
        for (int x = 0; x < MAP_W; x++)
            if (seen[y][x]) qx[n] = x, qy[n++] = y;
    for (int head = 0; head < n; head++) {
        for (int k = 0; k < 5; k++) {
            static GameState s;
            Input in = {0};
            in.left = k == 0, in.right = k == 1, in.up = k == 2, in.down = k == 3;
            s = *base;
            s.guard_count = 0;
            s.exit_open = exit_open;
            s.gold_total = MAP_W * MAP_H;
            s.player.x = qx[head];
            s.player.y = qy[head];
            level_step(&s, in);
            if (!seen[s.player.y][s.player.x]) {
                seen[s.player.y][s.player.x] = 1;
                qx[n] = s.player.x, qy[n++] = s.player.y;
            }
        }
    }
}

static int fail(int code, const char *what) {
    fprintf(stderr, "test_loderunner: check %d failed (%s)\n", code, what);
    return code;
}

int main(void) {
    GameState g;
    Input none = {0};

    /* 1. The built-in level loads: gold counted, a player and at least
     * one guard placed, every entity in bounds. */
    level_load(&g);
    if (g.gold_total <= 0) return fail(1, "no gold in level");
    if (g.guard_count <= 0) return fail(1, "no guards in level");
    if (g.player.x < 0 || g.player.x >= MAP_W || g.player.y < 0 ||
        g.player.y >= MAP_H)
        return fail(1, "player out of bounds");

    /* 2. Running the real level for many frames keeps the player in
     * bounds and the state valid -- no crash, no escape. */
    for (int i = 0; i < 400; i++) {
        Input in = {0};
        in.right = (i % 7) < 4;
        in.left = (i % 11) < 2;
        in.up = (i % 5) == 0;
        in.down = (i % 13) == 0;
        in.dig_right = (i % 17) == 0;
        level_step(&g, in);
        if (g.player.x < 0 || g.player.x >= MAP_W || g.player.y < 0 ||
            g.player.y >= MAP_H)
            return fail(2, "player left the grid");
        if (g.state != ST_PLAY && g.state != ST_WIN && g.state != ST_DEAD)
            return fail(2, "invalid state");
    }

    /* 3. Gravity: an unsupported player falls one cell per step. */
    empty_grid(&g);
    g.player.x = 5;
    g.player.y = 5;
    level_step(&g, none);
    if (g.player.y != 6) return fail(3, "no fall");

    /* 4. Walking: on solid ground, a right input advances one cell. */
    empty_grid(&g);
    g.player.x = 5;
    g.player.y = 5;
    g.tile[6][5] = TILE_SOLID;
    Input right = {0};
    right.right = 1;
    level_step(&g, right);
    if (g.player.x != 6) return fail(4, "no walk");

    /* 5. Digging carves a hole that regrows after DIG_REGROW_TICKS. */
    empty_grid(&g);
    g.player.x = 5;
    g.player.y = 5;
    g.tile[6][5] = TILE_SOLID; /* stand here */
    g.tile[6][6] = TILE_BRICK; /* dig target, diagonally down-right */
    Input digr = {0};
    digr.dig_right = 1;
    level_step(&g, digr);
    if (g.tile[6][6] != TILE_EMPTY || g.hole_count != 1)
        return fail(5, "dig did not carve");
    for (int i = 0; i < DIG_REGROW_TICKS + 2; i++) level_step(&g, none);
    if (g.tile[6][6] != TILE_BRICK || g.hole_count != 0)
        return fail(5, "dig did not regrow");

    /* 6. Gold: stepping onto gold collects it; the last one opens the
     * exit. */
    empty_grid(&g);
    g.player.x = 5;
    g.player.y = 5;
    g.tile[6][5] = TILE_SOLID;
    g.tile[6][6] = TILE_SOLID;
    g.tile[5][6] = TILE_GOLD;
    g.gold_total = 1;
    level_step(&g, right);
    if (g.gold_taken != 1 || !g.exit_open)
        return fail(6, "gold not collected / exit not opened");

    /* 7. Win: with the exit open, climbing an exit ladder to the top
     * wins. */
    empty_grid(&g);
    g.exit_open = 1;
    for (int y = 0; y < MAP_H; y++) g.tile[y][5] = TILE_EXIT_LADDER;
    g.player.x = 5;
    g.player.y = 4;
    Input up = {0};
    up.up = 1;
    for (int i = 0; i < 6 && g.state == ST_PLAY; i++) level_step(&g, up);
    if (g.state != ST_WIN) return fail(7, "no win on exit climb");

    /* 8. Death: walking into a guard ends the game. */
    empty_grid(&g);
    g.player.x = 5;
    g.player.y = 5;
    g.tile[6][5] = TILE_SOLID;
    g.tile[6][6] = TILE_SOLID;
    g.guard_count = 1;
    g.guard[0].x = 6;
    g.guard[0].y = 5;
    g.guard[0].alive = 1;
    g.tick = 1;
    level_step(&g, right);
    if (g.state != ST_DEAD) return fail(8, "no death on guard contact");

    /* 9. The built-in level is winnable without digging: every gold is
     * reachable from the start, and then the top row through the open
     * exit. */
    static GameState level;
    static unsigned char seen[MAP_H][MAP_W];
    level_load(&level);
    memset(seen, 0, sizeof seen);
    seen[level.player.y][level.player.x] = 1;
    reach(&level, 0, seen);
    for (int y = 0; y < MAP_H; y++)
        for (int x = 0; x < MAP_W; x++)
            if (level.tile[y][x] == TILE_GOLD && !seen[y][x])
                return fail(9, "a gold the player cannot reach");
    reach(&level, 1, seen);
    int top = 0;
    for (int x = 0; x < MAP_W; x++) top |= seen[0][x];
    if (!top) return fail(9, "the exit cannot be reached");

    /* 10. Two guards that stop under a player they cannot climb to do not
     * share a cell. */
    empty_grid(&g);
    for (int x = 0; x < MAP_W; x++) g.tile[6][x] = TILE_SOLID;
    g.tile[4][10] = TILE_SOLID;
    g.player.x = 10;
    g.player.y = 3;
    g.guard_count = 2;
    g.guard[0] = (Entity){20, 5, 20, 5, 1, 0};
    g.guard[1] = (Entity){21, 5, 21, 5, 1, 0};
    for (int i = 0; i < 30 && g.state == ST_PLAY; i++) {
        level_step(&g, none);
        if (g.guard[0].x == g.guard[1].x && g.guard[0].y == g.guard[1].y)
            return fail(10, "two guards in one cell");
    }

    /* 11. A dead guard does not return onto the player standing at its
     * start. */
    empty_grid(&g);
    for (int x = 0; x < MAP_W; x++) g.tile[6][x] = TILE_SOLID;
    g.player.x = 8;
    g.player.y = 5;
    g.guard_count = 1;
    g.guard[0] = (Entity){0, 0, 8, 5, 0, 1};
    for (int i = 0; i < 6; i++) level_step(&g, none);
    if (g.guard[0].alive || g.state != ST_PLAY)
        return fail(11, "guard returned onto the player");

    printf("test_loderunner: all checks passed (gold_total=%d, guards=%d)\n",
           g.gold_total, g.guard_count);
    return 0;
}
