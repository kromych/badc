// A dispatch loop holds eleven values its cases update, more than leave a
// case of its own temporaries a register, and each case reads only some of
// them: each keeps its value past the cases that do not read it, whichever
// holds the register meanwhile. One case leaves the loop on a condition,
// with a value read past that exit; one calls a function; one nests an if
// whose arms hold temporaries of their own. Each result is checked against
// the same computation over a volatile array. Returns 0 when every check
// passes; each failure returns a distinct code. The values are unsigned, so
// their arithmetic wraps (C17 6.2.5p9).
// snapshot-budget: exempt

typedef unsigned long u;

__attribute__((noinline)) u mix(u x, u y) {
    return (x ^ (y >> 3)) * 0x9e3779b97f4a7c15ul;
}

__attribute__((noinline)) u direct(const unsigned char *ops, long n, const u *o, u *t) {
    u a0 = o[0], a1 = o[1], a2 = o[2], a3 = o[3], a4 = o[4], a5 = o[5];
    u a6 = o[6], a7 = o[7], a8 = o[8], a9 = o[9], a10 = o[10];
    u acc = 0;
    for (long pc = 0; pc < n; pc++) {
        switch (ops[pc] & 7) {
        case 0:
            a0 += a1 ^ (u)pc;
            a2 ^= a0;
            a3 += a2 >> 1;
            break;
        case 1: {
            u t0 = t[0], t1 = t[1], t2 = t[2], t3 = t[3];
            u t4 = t[4], t5 = t[5], t6 = t[6], t7 = t[7];
            u s = t0 * t1 + t2 * t3 + t4 * t5 + t6 * t7;
            u d = (t0 ^ t7) + (t1 ^ t6) + (t2 ^ t5) + (t3 ^ t4);
            t[pc & 7] = s ^ d;
            t[(pc + 3) & 7] = s + d * t0 + t5;
            acc += s - d;
            break;
        }
        case 2:
            if (a4 > a5)
                a4 -= a5;
            else
                a5 -= a4;
            a6 ^= a4 + a5;
            break;
        case 3: {
            u t0 = t[1] + t[6], t1 = t[2] ^ t[5], t2 = t[3] - t[4];
            if (t0 == 0x77)
                goto out;
            t[0] = t0 * t1 + t2;
            t[7] = t1 * t2 + t0;
            acc ^= t0 + t1 + t2;
            break;
        }
        case 4:
            a7 = mix(a7, a8 + (u)pc);
            a8 += a7;
            break;
        case 5:
            if (pc & 1) {
                u t0 = t[0], t1 = t[2], t2 = t[4], t3 = t[6];
                u s = t0 * t2 + t1 * t3;
                t[1] = s + t0;
                t[3] = s ^ t1;
                acc += s;
            } else {
                u t0 = t[1], t1 = t[3], t2 = t[5], t3 = t[7];
                u s = t0 * t3 - t1 * t2;
                t[0] = s - t3;
                t[6] = s ^ t2;
                acc -= s;
            }
            break;
        case 6:
            a9 += a10 * 3 + (u)pc;
            a10 ^= a9 << 2;
            break;
        default:
            a1 += a3 ^ a6;
            acc += a0 + a8;
            break;
        }
    }
    acc += 1;
out:
    return acc + a0 + a1 * 3 + a2 * 5 + a3 * 7 + a4 * 9 + a5 * 11 + a6 * 13 + a7 * 15 +
           a8 * 17 + a9 * 19 + a10 * 21;
}

__attribute__((noinline)) u reference(const unsigned char *ops, long n, const u *o, u *t) {
    volatile u a[11];
    for (int i = 0; i < 11; i++)
        a[i] = o[i];
    u acc = 0;
    for (long pc = 0; pc < n; pc++) {
        volatile u *v = t;
        switch (ops[pc] & 7) {
        case 0:
            a[0] += a[1] ^ (u)pc;
            a[2] ^= a[0];
            a[3] += a[2] >> 1;
            break;
        case 1: {
            u s = v[0] * v[1] + v[2] * v[3] + v[4] * v[5] + v[6] * v[7];
            u d = (v[0] ^ v[7]) + (v[1] ^ v[6]) + (v[2] ^ v[5]) + (v[3] ^ v[4]);
            u t0 = v[0], t5 = v[5];
            v[pc & 7] = s ^ d;
            v[(pc + 3) & 7] = s + d * t0 + t5;
            acc += s - d;
            break;
        }
        case 2:
            if (a[4] > a[5])
                a[4] -= a[5];
            else
                a[5] -= a[4];
            a[6] ^= a[4] + a[5];
            break;
        case 3: {
            u t0 = v[1] + v[6], t1 = v[2] ^ v[5], t2 = v[3] - v[4];
            if (t0 == 0x77)
                goto out;
            v[0] = t0 * t1 + t2;
            v[7] = t1 * t2 + t0;
            acc ^= t0 + t1 + t2;
            break;
        }
        case 4:
            a[7] = mix(a[7], a[8] + (u)pc);
            a[8] += a[7];
            break;
        case 5:
            if (pc & 1) {
                u t0 = v[0], t1 = v[2], t2 = v[4], t3 = v[6];
                u s = t0 * t2 + t1 * t3;
                v[1] = s + t0;
                v[3] = s ^ t1;
                acc += s;
            } else {
                u t0 = v[1], t1 = v[3], t2 = v[5], t3 = v[7];
                u s = t0 * t3 - t1 * t2;
                v[0] = s - t3;
                v[6] = s ^ t2;
                acc -= s;
            }
            break;
        case 6:
            a[9] += a[10] * 3 + (u)pc;
            a[10] ^= a[9] << 2;
            break;
        default:
            a[1] += a[3] ^ a[6];
            acc += a[0] + a[8];
            break;
        }
    }
    acc += 1;
out:;
    u s = acc;
    for (int i = 0; i < 11; i++)
        s += a[i] * (2 * i + 1);
    return s;
}

int main(void) {
    unsigned char ops[200];
    for (int i = 0; i < 200; i++)
        ops[i] = (unsigned char)((i * 13 + i / 7) % 8);
    u o[11];
    for (int i = 0; i < 11; i++)
        o[i] = 0x1234567ul * (u)(i + 1) ^ ((u)i << 20);
    u t1[8], t2[8];
    for (int i = 0; i < 8; i++)
        t1[i] = t2[i] = 0x10001ul * (u)(i + 3);
    if (direct(ops, 200, o, t1) != reference(ops, 200, o, t2))
        return 1;
    for (int i = 0; i < 8; i++)
        if (t1[i] != t2[i])
            return 2;
    for (int i = 0; i < 8; i++)
        t1[i] = t2[i] = 0;
    t1[1] = t2[1] = 0x70;
    t1[6] = t2[6] = 7;
    unsigned char exit_ops[4] = {0, 3, 1, 2};
    if (direct(exit_ops, 4, o, t1) != reference(exit_ops, 4, o, t2))
        return 3;
    if (direct(ops, 0, o, t1) != reference(ops, 0, o, t2))
        return 4;
    return 0;
}
