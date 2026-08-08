/* C99 6.7.8p7: a designator list may chain array designators, one rank
   per `[i]`, mixed with `.member` steps. Static objects, constant
   locals, and runtime-valued locals all resolve the same chains. */
struct cell { int v; int w[2]; };
struct r {
    unsigned short ht_rates[2][3];
    struct cell cells[2][2];
    int cube[2][3][4];
};

struct r g = {
    .ht_rates[0][0] = 1,
    .ht_rates[0][1] = 2,
    .ht_rates[1][2] = 7,
    .cells[1][0].v = 5,
    .cells[1][0].w[1] = 6,
    .cube[1][2][3] = 9,
};

static int check(const struct r *p) {
    return p->ht_rates[0][0] == 1 && p->ht_rates[0][1] == 2
        && p->ht_rates[1][2] == 7 && p->cells[1][0].v == 5
        && p->cells[1][0].w[1] == 6 && p->cube[1][2][3] == 9
        && p->ht_rates[1][0] == 0 && p->cells[0][1].v == 0
        && p->cube[0][0][0] == 0;
}

int main(void) {
    struct r src = g;
    /* Runtime-valued member reads drive the same designator chains. */
    struct r loc = {
        .ht_rates[0][0] = src.ht_rates[0][0],
        .ht_rates[0][1] = src.ht_rates[0][1],
        .ht_rates[1][2] = src.ht_rates[1][2],
        .cells[1][0].v = src.cells[1][0].v,
        .cells[1][0].w[1] = src.cells[1][0].w[1],
        .cube[1][2][3] = src.cube[1][2][3],
    };
    struct r locc = {
        .ht_rates[0][0] = 1,
        .ht_rates[0][1] = 2,
        .ht_rates[1][2] = 7,
        .cells[1][0].v = 5,
        .cells[1][0].w[1] = 6,
        .cube[1][2][3] = 9,
    };
    static struct r stat = {
        .cube[0][1][2] = 4,
        .cube[1][0][0] = 3,
        .ht_rates[1][1] = 8,
    };
    if (!check(&g)) return 1;
    if (!check(&loc)) return 2;
    if (!check(&locc)) return 3;
    if (!(stat.cube[0][1][2] == 4 && stat.cube[1][0][0] == 3
          && stat.ht_rates[1][1] == 8 && stat.cube[1][2][3] == 0)) return 4;
    return 0;
}
