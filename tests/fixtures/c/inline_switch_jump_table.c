/* A callee whose switch lowers to a jump table inlines. The successors
   ride a `jump_tables` row, which the splice clones with the callee's
   block ids shifted into the caller and the row index shifted past the
   caller's own rows; the switch's index operand remaps like any other
   value. The caller here has a switch of its own and two call sites, so
   the rows must land after the caller's and after each other.

   `mas_find_setup` in the kernel's maple tree is this shape: a
   `__always_inline` body that is a switch over a status enum. */

struct pair {
	long x, y;
};

static __attribute__((always_inline)) struct pair step(int k, struct pair r)
{
	switch (k) {
	case 0: r.x += 1; break;
	case 1: r.x += 8; break;
	case 2: r.x += 15; break;
	case 3: r.x += 22; break;
	case 4: r.x += 29; break;
	case 5: r.x += 36; break;
	case 6: r.x += 43; break;
	case 7: r.x += 50; break;
	case 8: r.x += 57; break;
	case 9: r.x += 64; break;
	case 10: r.x += 71; break;
	case 11: r.x += 78; break;
	default: r.x = -1; r.y = -1; return r;
	}
	r.y -= k;
	return r;
}

/* A scalar-returning switch callee that also returns early from inside
   the switch, so the splice's postfix join merges more than one arm. */
static __attribute__((always_inline)) long grade(int k)
{
	switch (k) {
	case 0: return 100;
	case 1: return 101;
	case 2: return 102;
	case 3: return 103;
	case 4: return 104;
	case 5: return 105;
	case 6: return 106;
	case 7: return 107;
	case 8: return 108;
	case 9: return 109;
	case 10: return 110;
	case 11: break;
	}
	return -1;
}

static __attribute__((noinline)) long use(int k, int j)
{
	long acc;

	switch (j) {
	case 0: acc = 2; break;
	case 1: acc = 5; break;
	case 2: acc = 8; break;
	case 3: acc = 11; break;
	case 4: acc = 14; break;
	case 5: acc = 17; break;
	case 6: acc = 20; break;
	case 7: acc = 23; break;
	case 8: acc = 26; break;
	case 9: acc = 29; break;
	case 10: acc = 32; break;
	case 11: acc = 35; break;
	default: acc = 1000; break;
	}

	struct pair s = { 100, 200 };
	struct pair a = step(k, s);
	struct pair b = step(k + 1, a);

	return acc + a.x * 1000 + a.y + b.x * 10 + b.y + grade(k);
}

static long expect(int k, int j)
{
	long acc = (j >= 0 && j < 12) ? (long)(j * 3 + 2) : 1000;
	long ax, ay, bx, by;
	int k2 = k + 1;

	if (k >= 0 && k < 12) {
		ax = 100 + k * 7 + 1;
		ay = 200 - k;
	} else {
		ax = -1;
		ay = -1;
	}
	if (k2 >= 0 && k2 < 12) {
		bx = ax + k2 * 7 + 1;
		by = ay - k2;
	} else {
		bx = -1;
		by = -1;
	}
	return acc + ax * 1000 + ay + bx * 10 + by
	       + ((k >= 0 && k <= 10) ? 100 + k : -1);
}

int main(void)
{
	for (int k = -2; k < 15; k++) {
		for (int j = -2; j < 15; j++) {
			if (use(k, j) != expect(k, j)) {
				return 1;
			}
		}
	}
	return 0;
}
