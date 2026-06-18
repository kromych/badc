# N-body simulation of the Jovian planets (float arithmetic, loops, dict
# iteration). Output is the system energy after the integration, which is
# a deterministic function of the IEEE-754 arithmetic.
import os

SCALE = float(os.environ.get("BENCH_SCALE", "1"))
STEPS = max(1, round(60000 * SCALE))

PI = 3.141592653589793
SOLAR_MASS = 4 * PI * PI
DAYS_PER_YEAR = 365.24

BODIES = {
    "sun": ([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], SOLAR_MASS),
    "jupiter": (
        [4.84143144246472090, -1.16032004402742839, -0.103622044471123109],
        [0.00166007664274403694 * DAYS_PER_YEAR,
         0.00769901118419740425 * DAYS_PER_YEAR,
         -0.0000690460016972063023 * DAYS_PER_YEAR],
        0.000954791938424326609 * SOLAR_MASS,
    ),
    "saturn": (
        [8.34336671824457987, 4.12479856412430479, -0.403523417114321381],
        [-0.00276742510726862411 * DAYS_PER_YEAR,
         0.00499852801234917238 * DAYS_PER_YEAR,
         0.0000230417297573763929 * DAYS_PER_YEAR],
        0.000285885980666130812 * SOLAR_MASS,
    ),
    "uranus": (
        [12.8943695621391310, -15.1111514016986312, -0.223307578892655734],
        [0.00296460137564761618 * DAYS_PER_YEAR,
         0.00237847173959480950 * DAYS_PER_YEAR,
         -0.0000296589568540237556 * DAYS_PER_YEAR],
        0.0000436624404335156298 * SOLAR_MASS,
    ),
    "neptune": (
        [15.3796971148509165, -25.9193146099879641, 0.179258772950371181],
        [0.00268067772490389322 * DAYS_PER_YEAR,
         0.00162824170038242295 * DAYS_PER_YEAR,
         -0.0000951592254519715870 * DAYS_PER_YEAR],
        0.0000515138902046611451 * SOLAR_MASS,
    ),
}

SYSTEM = list(BODIES.values())
PAIRS = [
    (SYSTEM[i], SYSTEM[j])
    for i in range(len(SYSTEM))
    for j in range(i + 1, len(SYSTEM))
]


def advance(dt, n):
    for _ in range(n):
        for (([x1, y1, z1], v1, m1), ([x2, y2, z2], v2, m2)) in PAIRS:
            dx = x1 - x2
            dy = y1 - y2
            dz = z1 - z2
            d2 = dx * dx + dy * dy + dz * dz
            mag = dt * d2 ** -1.5
            b1m = m1 * mag
            b2m = m2 * mag
            v1[0] -= dx * b2m
            v1[1] -= dy * b2m
            v1[2] -= dz * b2m
            v2[0] += dx * b1m
            v2[1] += dy * b1m
            v2[2] += dz * b1m
        for (r, v, m) in SYSTEM:
            r[0] += dt * v[0]
            r[1] += dt * v[1]
            r[2] += dt * v[2]


def energy():
    e = 0.0
    for i, (r1, v1, m1) in enumerate(SYSTEM):
        e += 0.5 * m1 * (v1[0] ** 2 + v1[1] ** 2 + v1[2] ** 2)
        for r2, v2, m2 in SYSTEM[i + 1:]:
            dx = r1[0] - r2[0]
            dy = r1[1] - r2[1]
            dz = r1[2] - r2[2]
            e -= (m1 * m2) / (dx * dx + dy * dy + dz * dz) ** 0.5
    return e


def offset_momentum():
    px = py = pz = 0.0
    for r, v, m in SYSTEM:
        px += v[0] * m
        py += v[1] * m
        pz += v[2] * m
    sun_v = SYSTEM[0][1]
    sun_v[0] = -px / SOLAR_MASS
    sun_v[1] = -py / SOLAR_MASS
    sun_v[2] = -pz / SOLAR_MASS


offset_momentum()
advance(0.01, STEPS)
print("%.9f" % energy())
