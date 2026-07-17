/* C99 6.5.2.5 / 6.7.8: a compound literal used as a field value inside a
   block-scope struct initializer is a distinct object; emitting it must
   not drop the field stores written before it. Regression for a bug
   where the runtime values assigned to fields before a `&(Pair){...}` /
   `(int[]){...}` field were silently dropped, so those fields read back
   as zero. */

typedef struct {
    int a;
    int b;
} Pair;

typedef struct {
    long x;
    long y;
    const Pair *p;
    const char *s;
} T;

static int check(long xv, long yv) {
    T t = {
        .x = xv,
        .y = yv,
        .p = &(const Pair){3, 4},
        .s = "ok",
    };
    if (t.x != xv) {
        return 1;
    }
    if (t.y != yv) {
        return 2;
    }
    if (t.p->a != 3 || t.p->b != 4) {
        return 3;
    }
    if (t.s[0] != 'o' || t.s[1] != 'k' || t.s[2] != 0) {
        return 4;
    }
    return 0;
}

int main(void) {
    /* An array compound literal after runtime fields, too. */
    long sum = 0;
    struct {
        long lead;
        const int *nums;
    } arr = {
        .lead = 100,
        .nums = (const int[]){5, 6, 7},
    };
    if (arr.lead != 100) {
        return 5;
    }
    for (int i = 0; i < 3; i++) {
        sum += arr.nums[i];
    }
    if (sum != 18) {
        return 6;
    }
    return check(11, 22);
}
