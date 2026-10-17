/* An array of unknown size takes as many outer elements as its
 * initializer reaches, whole ones, the last zero-filled (C99 6.7.8p21,
 * p22): at file scope, as a block-scope static and automatic, beside a
 * non-constant element, through a typedef, of structures with braces
 * elided or mixed, and of string rows. Returns 0. */
struct P {
    int a;
};
typedef int T2[][3];

int f1[][2] = {1, 2, 3};
static char f2[][2][3] = {"ab", "cd", "ef"};
struct P f3[][2] = {{1}, 2, 3};
int f4[][2][2] = {1, 2, 3, 4, 5};
T2 f5 = {1, 2, 3, 4};

static int file_scope(void) {
    if (sizeof f1 != 16 || f1[1][0] != 3 || f1[1][1] != 0 || sizeof f2 != 12) {
        return 1;
    }
    if (f2[1][0][1] != 'f' || f2[1][1][0] != 0 || sizeof f3 != 16 || f3[1][1].a != 3) {
        return 2;
    }
    if (sizeof f4 != 32 || f4[1][0][0] != 5 || f4[1][1][1] != 0) {
        return 3;
    }
    return sizeof f5 == 24 && f5[1][0] == 4 && f5[1][2] == 0 ? 0 : 4;
}

static int block_scope(int x) {
    static int s1[][2] = {1, 2, 3};
    static struct P s2[][2] = {1, 2, 3};
    int a1[][2] = {1, 2, 3};
    char a2[][2][3] = {"ab", "cd", "ef"};
    struct P a3[][2] = {1, 2, 3};
    struct P a4[][2] = {{1}, 2, 3};
    struct P a5[][2] = {1, 2, x};
    int r1[][2] = {1, 2, x};
    T2 t = {1, 2, 3, x};
    if (sizeof s1 != 16 || s1[1][1] != 0 || sizeof s2 != 16 || s2[1][1].a != 0) {
        return 5;
    }
    if (sizeof a1 != 16 || a1[1][1] != 0 || sizeof a2 != 12 || a2[1][1][2] != 0) {
        return 6;
    }
    if (sizeof a3 != 16 || a3[1][1].a != 0 || sizeof a4 != 16 || a4[1][1].a != 3) {
        return 7;
    }
    if (sizeof a5 != 16 || a5[1][0].a != x || sizeof r1 != 16 || r1[1][0] != x) {
        return 8;
    }
    return sizeof t == 24 && t[1][0] == x && t[1][2] == 0 ? 0 : 9;
}

int main(void) {
    int r = file_scope();
    return r ? r : block_scope(9);
}
