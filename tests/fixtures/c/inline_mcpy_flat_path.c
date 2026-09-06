/* A block copy in a single-block callee inlines. The flat splice remaps
   an `Mcpy`'s operands exactly as it remaps a `Store`'s: with no
   aggregate parameter or return the destination and source are pointer
   values the splice carries across, since an address of one of the
   callee's own slots is rejected before this point. With an aggregate
   return the destination is the result slot the splice redirects to the
   caller's object, and the source is any value -- a compound-literal
   template or, as here, the caller's argument.

   `HUF_decodeSymbolX2` in the kernel's zstd decompressor is the first
   shape: a `__always_inline` body whose only obstacle was a two-byte
   `ZSTD_memcpy` through a `void *` parameter. */

struct entry {
	unsigned short sequence;
	unsigned char nbBits;
	unsigned char length;
};

struct stream {
	unsigned long long bits;
	int consumed;
};

struct big {
	long a, b, c, d, e;
};

/* No aggregate parameter and no aggregate return: the copy writes
   through a pointer parameter. */
static __attribute__((always_inline)) unsigned decode(void *op,
						      struct stream *s,
						      const struct entry *dt,
						      unsigned log)
{
	unsigned long long val = s->bits >> (64 - log);

	__builtin_memcpy(op, &dt[val].sequence, 2);
	s->consumed += dt[val].nbBits;
	return dt[val].length;
}

/* An aggregate return filled by a copy from the caller's argument
   rather than from a static template. */
static __attribute__((always_inline)) struct big widen(const struct big *p)
{
	struct big r;

	__builtin_memcpy(&r, p, sizeof(r));
	r.a += 1;
	return r;
}

/* The template form the flat path already took, kept alongside it. */
static __attribute__((always_inline)) struct big preset(long k)
{
	struct big r = { 1, 2, 3, 4, 5 };

	r.e = k;
	return r;
}

static struct stream gstream;
static const struct entry gdt[4] = {
	{ 0x1111, 1, 10 }, { 0x2222, 2, 20 },
	{ 0x3333, 3, 30 }, { 0x4444, 4, 40 },
};
static struct big gbig = { 6, 7, 8, 9, 10 };

static __attribute__((noinline)) unsigned use_decode(unsigned short *out)
{
	return decode(out, &gstream, gdt, 2);
}

static __attribute__((noinline)) long use_widen(void)
{
	struct big r = widen(&gbig);

	return r.a + r.b * 10 + r.e * 100;
}

static __attribute__((noinline)) long use_preset(long k)
{
	struct big r = preset(k);

	return r.a + r.d * 10 + r.e * 100;
}

int main(void)
{
	unsigned short out = 0;

	gstream.bits = 2ULL << 62;
	gstream.consumed = 0;
	if (use_decode(&out) != 30) {
		return 1;
	}
	if (out != 0x3333) {
		return 2;
	}
	if (gstream.consumed != 3) {
		return 3;
	}

	if (use_widen() != 7 + 70 + 1000) {
		return 4;
	}
	/* The callee copied out of the caller's object, not into it. */
	if (gbig.a != 6) {
		return 5;
	}

	if (use_preset(11) != 1 + 40 + 1100) {
		return 6;
	}
	return 0;
}
