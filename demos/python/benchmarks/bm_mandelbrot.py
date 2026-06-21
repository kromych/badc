# Mandelbrot set escape-time over a SIZE x SIZE grid (float arithmetic,
# tight inner loop). Output is the in-set count and total iteration count,
# both exact integers derived deterministically from the IEEE arithmetic.
import os

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
SIZE = max(40, round(200 * SCALE))
LIMIT = 4.0
ITER = 50


def mandelbrot(size):
    inside = 0
    total = 0
    for py in range(size):
        ci = 2.0 * py / size - 1.0
        for px in range(size):
            cr = 2.0 * px / size - 1.5
            zr = 0.0
            zi = 0.0
            i = 0
            while i < ITER:
                zr2 = zr * zr
                zi2 = zi * zi
                if zr2 + zi2 > LIMIT:
                    break
                zi = 2.0 * zr * zi + ci
                zr = zr2 - zi2 + cr
                i += 1
            else:
                inside += 1
            total += i
    return inside, total


inside, total = mandelbrot(SIZE)
print("%d %d" % (inside, total))
