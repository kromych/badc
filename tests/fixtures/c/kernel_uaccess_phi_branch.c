// snapshot-flags: -c -mcmodel=kernel -mfunction-return=thunk-extern -fcf-protection=branch
// `if (!user_access_begin(p, n)) return -EFAULT;` after inlining: the
// helper returns 0 from its range check and 1 past `stac`, a phi merges
// the two and the caller branches on the phi. Each predecessor is
// threaded past the merge to the arm its own constant selects, so the
// block past `stac` no longer has an edge to the error return: every
// path from `stac` reaches `clac` before the function returns, which is
// what objtool's UACCESS rule checks edge by edge.

typedef unsigned long size_t;

static inline __attribute__((always_inline)) int access_ok(const void *p, size_t n)
{
	return (unsigned long)p + n <= 0x7ffffffff000UL;
}

static inline __attribute__((always_inline)) _Bool user_access_begin(const void *ptr, size_t len)
{
	if (__builtin_expect(!access_ok(ptr, len), 0))
		return 0;
	asm volatile("stac" ::: "memory");
	return 1;
}

#define user_access_end() asm volatile("clac" ::: "memory")

#define unsafe_put_user(x, ptr, label)                                    \
	asm goto("1: movq %0, %1\n"                                       \
		 ".pushsection __ex_table,\"a\"\n"                        \
		 ".long 1b - ., %l2 - .\n"                                \
		 ".popsection\n"                                          \
		 : : "r"(x), "m"(*(ptr)) : : label)

int put_user_word(unsigned long *uptr, unsigned long v)
{
	if (!user_access_begin(uptr, sizeof(*uptr)))
		return -14;
	asm volatile("1: movq %1, %0\n" : "=m"(*uptr) : "r"(v));
	user_access_end();
	return 0;
}

int put_user_pair(unsigned long *uptr, unsigned long a, unsigned long b)
{
	if (!user_access_begin(uptr, 2 * sizeof(*uptr)))
		return -14;
	unsafe_put_user(a, &uptr[0], Efault);
	unsafe_put_user(b, &uptr[1], Efault);
	user_access_end();
	return 0;
Efault:
	user_access_end();
	return -14;
}
