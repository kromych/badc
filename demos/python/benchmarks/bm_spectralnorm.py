# Spectral norm of the infinite matrix A(i,j)=1/((i+j)(i+j+1)/2+i+1) via
# the power method (nested float loops, function calls).
import os

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
N = max(50, round(250 * SCALE))


def A(i, j):
    return 1.0 / ((i + j) * (i + j + 1) // 2 + i + 1)


def Au(u, out):
    n = len(u)
    for i in range(n):
        s = 0.0
        for j in range(n):
            s += A(i, j) * u[j]
        out[i] = s


def Atu(u, out):
    n = len(u)
    for i in range(n):
        s = 0.0
        for j in range(n):
            s += A(j, i) * u[j]
        out[i] = s


def AtAu(u, out, tmp):
    Au(u, tmp)
    Atu(tmp, out)


u = [1.0] * N
v = [0.0] * N
tmp = [0.0] * N
for _ in range(10):
    AtAu(u, v, tmp)
    AtAu(v, u, tmp)

vBv = 0.0
vv = 0.0
for i in range(N):
    vBv += u[i] * v[i]
    vv += v[i] * v[i]
print("%.9f" % ((vBv / vv) ** 0.5))
