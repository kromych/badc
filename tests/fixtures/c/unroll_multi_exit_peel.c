/* A constant-trip loop whose body branches out of it -- what a `break`
 * (C99 6.8.6.3) or a `goto` out of the loop compiles to -- peels into
 * one copy per iteration, each keeping its own branch. The values the
 * copies carry past the loop are merged where the branches rejoin, so
 * every result below must match the same body run against a bound this
 * translation unit cannot fold, which keeps it rolled. */

#define N 4

long refaulted[N], total[N], weight[N];
int bound = N;

static long walk_peeled(long gain) {
    long acc = 0;
    int i;

    for (i = 0; i < N; i++) {
        acc += refaulted[i] * weight[i] * gain;
        if (total[i] < 0)
            break;
    }
    return acc * 8 + i;
}

static long walk_rolled(long gain) {
    long acc = 0;
    int i;

    for (i = 0; i < bound; i++) {
        acc += refaulted[i] * weight[i] * gain;
        if (total[i] < 0)
            break;
    }
    return acc * 8 + i;
}

/* Two exits out of one body, landing on different blocks, each with a
 * value live out of it. */
static long scan_peeled(long floor) {
    long acc = 0;
    int i;

    for (i = 0; i < N; i++) {
        if (refaulted[i] < 0)
            goto bail;
        acc += weight[i] * refaulted[i];
        if (total[i] < floor)
            break;
    }
    return acc * 8 + i;
bail:
    return -acc - i - 1;
}

static long scan_rolled(long floor) {
    long acc = 0;
    int i;

    for (i = 0; i < bound; i++) {
        if (refaulted[i] < 0)
            goto bail;
        acc += weight[i] * refaulted[i];
        if (total[i] < floor)
            break;
    }
    return acc * 8 + i;
bail:
    return -acc - i - 1;
}

static void fill(long r0, long r1, long r2, long r3, long t2) {
    refaulted[0] = r0;
    refaulted[1] = r1;
    refaulted[2] = r2;
    refaulted[3] = r3;
    weight[0] = 1;
    weight[1] = 10;
    weight[2] = 100;
    weight[3] = 1000;
    total[0] = 1;
    total[1] = 1;
    total[2] = t2;
    total[3] = 1;
}

int main(void) {
    long gain, floor;

    fill(1, 2, 3, 4, 1);
    if (walk_peeled(2) != 2 * (1 + 20 + 300 + 4000) * 8 + 4)
        return 1;
    if (scan_peeled(-2) != (1 + 20 + 300 + 4000) * 8 + 4)
        return 2;

    for (gain = 1; gain <= 3; gain++) {
        fill(1, 2, 3, 4, 1);
        if (walk_peeled(gain) != walk_rolled(gain))
            return 3;
        fill(1, 2, 3, 4, -1);
        if (walk_peeled(gain) != walk_rolled(gain))
            return 4;
        fill(-1, 2, 3, 4, 1);
        if (walk_peeled(gain) != walk_rolled(gain))
            return 5;
    }

    for (floor = -2; floor <= 2; floor++) {
        fill(1, 2, 3, 4, 1);
        if (scan_peeled(floor) != scan_rolled(floor))
            return 6;
        fill(1, 2, 3, 4, -1);
        if (scan_peeled(floor) != scan_rolled(floor))
            return 7;
        fill(1, -2, 3, 4, 1);
        if (scan_peeled(floor) != scan_rolled(floor))
            return 8;
        fill(-1, 2, 3, 4, -1);
        if (scan_peeled(floor) != scan_rolled(floor))
            return 9;
    }
    return 0;
}
