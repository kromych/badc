// N-Queens backtracking solver. Counts the placements for an
// N x N board. Exercises deep recursion with a stack-allocated
// array (`row[N]`), conditional control flow, and an integer
// accumulator that survives across calls.

#define N 8

static int conflicts(int *row, int r, int c) {
    int i;
    for (i = 0; i < r; i = i + 1) {
        int dr = r - i;
        int dc = c - row[i];
        if (dc < 0) dc = -dc;
        if (row[i] == c) return 1;
        if (dr == dc) return 1;
    }
    return 0;
}

static int solve(int *row, int r) {
    if (r == N) return 1;
    int total = 0;
    int c;
    for (c = 0; c < N; c = c + 1) {
        if (conflicts(row, r, c)) continue;
        row[r] = c;
        total = total + solve(row, r + 1);
    }
    return total;
}

int main(void) {
    int row[N];
    int n = solve(row, 0);
    // 8-queens has 92 solutions.
    if (n != 92) return 1;
    return 0;
}
