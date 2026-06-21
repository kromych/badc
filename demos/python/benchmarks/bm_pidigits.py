# Digits of pi via the unbounded spigot algorithm (arbitrary-precision
# integer multiply/divide). Output is the digit count and the last ten
# digits produced.
import os

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
DIGITS = max(20, round(1500 * SCALE))


def pidigits(n):
    out = []
    q, r, t, k, m, x = 1, 0, 1, 1, 3, 3
    produced = 0
    while produced < n:
        if 4 * q + r - t < m * t:
            out.append(str(m))
            produced += 1
            q, r, m = 10 * q, 10 * (r - m * t), (10 * (3 * q + r)) // t - 10 * m
        else:
            q, r, t, k, m, x = (
                q * k,
                (2 * q + r) * x,
                t * x,
                k + 1,
                (q * (7 * k + 2) + r * x) // (t * x),
                x + 2,
            )
    return "".join(out)


s = pidigits(DIGITS)
print("%d %s" % (len(s), s[-10:]))
