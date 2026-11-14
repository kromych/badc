// Backtracking sudoku solver for the perf table. Each row, column, and box
// keeps the digits it holds as a 9-bit mask; the search fills the empty
// cell with the fewest candidates, tries those candidates in increasing
// order by isolating the lowest set bit, and stops at the second solution,
// so a puzzle with a unique solution is searched exhaustively. The puzzles
// have 17 to 23 givens, and REPS solves of the whole set are timed.
// Exercises the 81-cell scan with its table lookups and early exit,
// recursion over a struct held by pointer, mask updates and their undo,
// and branches that depend on the data.
//
// Each solution is checked, by counting rather than by masks, to place
// every digit once in each row, column, and box and to keep the givens;
// each puzzle must have exactly one, and every repetition must find the
// same solution after visiting the same number of nodes.

#include <stdio.h>
#include <string.h>
#include "bench_clock.h"

#define REPS 10
#define NPUZZLES ((int)(sizeof puzzles / sizeof puzzles[0]))

static const char *const puzzles[] = {
    "800000000003600000070090200050007000000045700000100030001000068008500010090000400",
    "100007090030020008009600500005300900010080002600004000300000010040000007007000300",
    "100000002090400050006000700050903000000070000000850040700000600030009080002000001",
    "000000039000001005003050800008090006070002000100400000009080050020000600400700000",
    "000000012000000003002300400001800005060070800000009000008500000900040500470006000",
    "000000000000003085001020000000507000004000100090000000500000073002010000000040009",
    "000000010400000000020000000000050407008000300001090000300400200050100000000806000",
    "000000010400000000020000000000050604008000300001090000300400200050100000000807000",
    "000000012000035000000600070700000300000400800100000000000120000080000040050000600",
    "000000012003600000000007000410020000000500300700000600280000040000300500000000000",
    "000000012008030000000000040120500000000004700060000000507000300000620000000100000",
};

struct solver {
    unsigned char cell[81];
    unsigned row[9], col[9], box[9];
    int found;
    long nodes;
    unsigned char solution[81];
};

static unsigned char box_of[81];
static unsigned char bit_count[512];
static unsigned char lowest_digit[512];

static void init_tables(void) {
    for (int i = 0; i < 81; i++) {
        box_of[i] = (unsigned char)(i / 27 * 3 + i % 9 / 3);
    }
    for (unsigned m = 1; m < 512; m++) {
        bit_count[m] = (unsigned char)(bit_count[m >> 1] + (m & 1));
        unsigned d = 1;
        while (!(m >> (d - 1) & 1)) {
            d++;
        }
        lowest_digit[m] = (unsigned char)d;
    }
}

static void search(struct solver *s, int filled) {
    s->nodes++;
    if (filled == 81) {
        if (s->found++ == 0) {
            memcpy(s->solution, s->cell, 81);
        }
        return;
    }
    int best = -1, best_count = 10;
    unsigned best_mask = 0;
    for (int i = 0; i < 81; i++) {
        if (s->cell[i] != 0) {
            continue;
        }
        unsigned m = ~(s->row[i / 9] | s->col[i % 9] | s->box[box_of[i]]) & 0x1ff;
        if (bit_count[m] < best_count) {
            best = i;
            best_count = bit_count[m];
            best_mask = m;
            if (best_count <= 1) {
                break;
            }
        }
    }
    int r = best / 9, c = best % 9, b = box_of[best];
    for (unsigned m = best_mask; m != 0 && s->found < 2; m &= m - 1) {
        unsigned bit = m & -m;
        s->cell[best] = lowest_digit[bit];
        s->row[r] |= bit;
        s->col[c] |= bit;
        s->box[b] |= bit;
        search(s, filled + 1);
        s->row[r] &= ~bit;
        s->col[c] &= ~bit;
        s->box[b] &= ~bit;
    }
    s->cell[best] = 0;
}

// Returns the number of solutions up to two, or -1 when the givens clash.
static int solve(struct solver *s, const char *puzzle) {
    memset(s, 0, sizeof *s);
    int filled = 0;
    for (int i = 0; i < 81; i++) {
        int d = puzzle[i] - '0';
        if (d == 0) {
            continue;
        }
        unsigned bit = 1u << (d - 1);
        if ((s->row[i / 9] | s->col[i % 9] | s->box[box_of[i]]) & bit) {
            return -1;
        }
        s->cell[i] = (unsigned char)d;
        s->row[i / 9] |= bit;
        s->col[i % 9] |= bit;
        s->box[box_of[i]] |= bit;
        filled++;
    }
    search(s, filled);
    return s->found;
}

static int valid_solution(const unsigned char *grid, const char *puzzle) {
    for (int k = 0; k < 9; k++) {
        int in_row[10] = {0}, in_col[10] = {0}, in_box[10] = {0};
        for (int j = 0; j < 9; j++) {
            int box_cell = (k / 3 * 3 + j / 3) * 9 + k % 3 * 3 + j % 3;
            in_row[grid[k * 9 + j]]++;
            in_col[grid[j * 9 + k]]++;
            in_box[grid[box_cell]]++;
        }
        for (int d = 1; d <= 9; d++) {
            if (in_row[d] != 1 || in_col[d] != 1 || in_box[d] != 1) {
                return 0;
            }
        }
    }
    for (int i = 0; i < 81; i++) {
        if (puzzle[i] != '0' && puzzle[i] - '0' != grid[i]) {
            return 0;
        }
    }
    return 1;
}

int main(void) {
    static struct solver s;
    static unsigned char first[NPUZZLES][81];
    long first_nodes[NPUZZLES];
    int bad = 0;
    unsigned checksum = 0;
    long nodes = 0;

    init_tables();
    double t0 = bench_ms();
    for (int rep = 0; rep < REPS; rep++) {
        for (int p = 0; p < NPUZZLES; p++) {
            int found = solve(&s, puzzles[p]);
            if (rep == 0) {
                memcpy(first[p], s.solution, 81);
                first_nodes[p] = s.nodes;
            }
            bad |= found != 1 || s.nodes != first_nodes[p] || memcmp(first[p], s.solution, 81) != 0;
            nodes += s.nodes;
            for (int i = 0; i < 81; i++) {
                checksum = checksum * 31u + s.solution[i];
            }
        }
    }
    double t1 = bench_ms();

    printf("sudoku %d puzzles x %d nodes=%ld checksum=%08x in %.2f ms\n", NPUZZLES, REPS, nodes,
           checksum, t1 - t0);

    for (int p = 0; p < NPUZZLES; p++) {
        bad |= !valid_solution(first[p], puzzles[p]);
    }
    if (bad) {
        printf("WRONG: a puzzle has no unique solution, or a solve differs between repetitions\n");
        return 1;
    }
    return 0;
}
