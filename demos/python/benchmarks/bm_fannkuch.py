# fannkuch-redux: integer arrays, list slicing, permutation enumeration.
# Output is the checksum and maximum flip count for permutations of N.
import os

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
N = max(8, min(11, round(9 + (SCALE - 1))))


def fannkuch(n):
    perm = list(range(n))
    perm1 = list(range(n))
    count = list(range(n))
    max_flips = 0
    checksum = 0
    r = n
    perm_sign = True
    while True:
        while r != 1:
            count[r - 1] = r
            r -= 1
        perm[:] = perm1
        flips = 0
        k = perm[0]
        while k:
            perm[: k + 1] = perm[k::-1]
            flips += 1
            k = perm[0]
        if flips > max_flips:
            max_flips = flips
        checksum += flips if perm_sign else -flips
        perm_sign = not perm_sign
        while True:
            if r == n:
                return checksum, max_flips
            p0 = perm1[0]
            i = 0
            while i < r:
                perm1[i] = perm1[i + 1]
                i += 1
            perm1[r] = p0
            count[r] -= 1
            if count[r] > 0:
                break
            r += 1


checksum, max_flips = fannkuch(N)
print("%d %d" % (checksum, max_flips))
