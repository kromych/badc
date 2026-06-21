# Count solutions to the N-queens problem by backtracking (recursion,
# closures, list mutation). Output is the exact solution count.
import os

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
N = max(8, min(12, round(11 + (SCALE - 1))))


def solve(n):
    count = 0
    cols = [False] * n
    diag1 = [False] * (2 * n)
    diag2 = [False] * (2 * n)

    def place(row):
        nonlocal count
        if row == n:
            count += 1
            return
        for col in range(n):
            d1 = row + col
            d2 = row - col + n
            if not cols[col] and not diag1[d1] and not diag2[d2]:
                cols[col] = diag1[d1] = diag2[d2] = True
                place(row + 1)
                cols[col] = diag1[d1] = diag2[d2] = False

    place(0)
    return count


print(solve(N))
