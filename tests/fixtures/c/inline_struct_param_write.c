/* A body that writes into its own by-value aggregate parameter inlines.
   The write is what makes the splice reproduce the prologue's copy: the
   parameter's cell relocates into the caller's frame and is filled from
   the argument, so the store lands in the callee's own copy and the
   caller's object keeps the value it had at the call (C99 6.5.2.2p4).

   `struct big` is 40 bytes: System V AMD64 MEMORY class, AAPCS64
   by-reference. `struct pair` is 16 bytes: an integer register pair under
   both, which is the shape that reaches `param_aggs` on aarch64. */

struct big {
	long a, b, c, d, e;
};

struct pair {
	long x, y;
};

static struct big gbig;
static struct pair gpair;

/* A scalar store into the parameter. */
static __attribute__((always_inline)) long bump(struct big v, long k)
{
	v.a += k;
	v.e = k;
	return v.a * 100 + v.e;
}

/* A whole-aggregate assignment into the parameter. */
static __attribute__((always_inline)) long overwrite(struct pair p,
						     const struct pair *q)
{
	p = *q;
	return p.x * 10 + p.y;
}

/* A store through a pointer to the parameter, and one through a pointer
   that names the caller's object: the copy has to precede both. */
static __attribute__((always_inline)) long alias(struct big v, struct big *p)
{
	long *w = &v.c;

	*w = 42;
	p->c = 7;
	return v.c * 1000 + v.a;
}

/* The plain `inline` specifier takes the same path. */
static inline long shuffle(struct pair p)
{
	long t = p.x;

	p.x = p.y;
	p.y = t;
	return p.x * 10 + p.y;
}

static __attribute__((noinline)) long use_bump(struct big *p, long k)
{
	return bump(*p, k);
}

static __attribute__((noinline)) long use_overwrite(const struct pair *q)
{
	return overwrite(gpair, q);
}

static __attribute__((noinline)) long use_alias(void)
{
	return alias(gbig, &gbig);
}

static __attribute__((noinline)) long use_shuffle(struct pair *p)
{
	return shuffle(*p);
}

int main(void)
{
	struct big v = { 1, 2, 3, 4, 5 };

	if (use_bump(&v, 6) != 700 + 6) {
		return 1;
	}
	if (v.a != 1 || v.e != 5) {
		return 2;
	}

	gpair.x = 3;
	gpair.y = 4;
	struct pair q = { 8, 9 };
	if (use_overwrite(&q) != 89) {
		return 3;
	}
	if (gpair.x != 3 || gpair.y != 4) {
		return 4;
	}

	gbig = v;
	if (use_alias() != 42 * 1000 + 1) {
		return 5;
	}
	if (gbig.c != 7 || gbig.a != 1) {
		return 6;
	}

	struct pair r = { 2, 5 };
	if (use_shuffle(&r) != 52) {
		return 7;
	}
	if (r.x != 2 || r.y != 5) {
		return 8;
	}
	return 0;
}
