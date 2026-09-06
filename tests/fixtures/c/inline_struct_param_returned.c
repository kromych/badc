/* A body that returns its by-value aggregate parameter unchanged inlines.
   The parameter's slot already redirects to the caller's argument, so the
   flat path has no second redirect to give the return; the callee takes
   the relocating splice instead, which binds the slot to the argument
   address and copies from there into the caller's return slot.

   The kernel's userfaultfd-write-protect accessors are this shape:
   `static __always_inline pte_t pte_mkuffd_wp(pte_t pte) { return pte; }`
   where the architecture has no such bit.

   Three layouts, so both ABIs reach every class: `word` is one integer
   register, `pair` two, `big` is System V AMD64 MEMORY class and AAPCS64
   by-reference. */

struct word {
	long a;
};

struct pair {
	long x, y;
};

struct big {
	long a, b, c, d, e;
};

static struct word gword;
static struct pair gpair;
static struct big gbig;

static __attribute__((always_inline)) struct word id_word(struct word v)
{
	return v;
}

static __attribute__((always_inline)) struct pair id_pair(struct pair v)
{
	return v;
}

static __attribute__((always_inline)) struct big id_big(struct big v)
{
	return v;
}

/* The plain `inline` specifier takes the same path. */
static inline struct pair id_pair_hint(struct pair v)
{
	return v;
}

/* An identity applied twice, so the second splice reads the first's
   result rather than a caller object. */
static __attribute__((always_inline)) struct pair id_pair_twice(struct pair v)
{
	return id_pair(id_pair(v));
}

/* A conditional identity: one arm returns the parameter, the other a
   value the body builds, so the postfix copy reads a merged address. */
static __attribute__((always_inline)) struct pair pick(struct pair v, int keep)
{
	struct pair other = { v.y, v.x };

	if (keep) {
		return v;
	}
	return other;
}

static __attribute__((noinline)) long use_word(struct word *p)
{
	struct word r = id_word(*p);

	return r.a;
}

static __attribute__((noinline)) long use_pair(void)
{
	struct pair r = id_pair(gpair);

	return r.x * 10 + r.y;
}

static __attribute__((noinline)) long use_big(void)
{
	struct big r = id_big(gbig);

	return r.a + r.b * 10 + r.c * 100 + r.d * 1000 + r.e * 10000;
}

static __attribute__((noinline)) long use_hint(struct pair *p)
{
	struct pair r = id_pair_hint(*p);

	return r.x * 10 + r.y;
}

static __attribute__((noinline)) long use_twice(struct pair *p)
{
	struct pair r = id_pair_twice(*p);

	return r.x * 10 + r.y;
}

static __attribute__((noinline)) long use_pick(struct pair *p, int keep)
{
	struct pair r = pick(*p, keep);

	return r.x * 10 + r.y;
}

int main(void)
{
	gword.a = 7;
	if (use_word(&gword) != 7) {
		return 1;
	}
	/* The argument is unchanged: the copy went one way. */
	if (gword.a != 7) {
		return 2;
	}

	gpair.x = 3;
	gpair.y = 4;
	if (use_pair() != 34) {
		return 3;
	}
	if (gpair.x != 3 || gpair.y != 4) {
		return 4;
	}

	gbig.a = 1;
	gbig.b = 2;
	gbig.c = 3;
	gbig.d = 4;
	gbig.e = 5;
	if (use_big() != 1 + 20 + 300 + 4000 + 50000) {
		return 5;
	}

	struct pair q = { 8, 9 };

	if (use_hint(&q) != 89) {
		return 6;
	}
	if (use_twice(&q) != 89) {
		return 7;
	}
	if (use_pick(&q, 1) != 89) {
		return 8;
	}
	if (use_pick(&q, 0) != 98) {
		return 9;
	}
	if (q.x != 8 || q.y != 9) {
		return 10;
	}
	return 0;
}
