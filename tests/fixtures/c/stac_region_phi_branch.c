// snapshot-flags: -c -mcmodel=kernel -mfunction-return=thunk-extern -fcf-protection=branch
// `if (!open_user_access(p, n)) return -EFAULT;` after inlining: the
// helper returns 0 from its range check and 1 past `stac`, a phi merges
// the two and the caller branches on the phi. Each predecessor is
// threaded past the merge to the arm its own constant selects, so the
// block past `stac` no longer has an edge to the error return: every
// path from `stac` reaches `clac` before the function returns, edge by
// edge.

typedef unsigned long size_t;

static inline __attribute__((always_inline)) int range_ok(const void *p, size_t n)
{
	return (unsigned long)p + n <= 0x7ffffffff000UL;
}

static inline __attribute__((always_inline)) _Bool open_user_access(const void *ptr, size_t len)
{
	if (__builtin_expect(!range_ok(ptr, len), 0))
		return 0;
	asm volatile("stac" ::: "memory");
	return 1;
}

#define close_user_access() asm volatile("clac" ::: "memory")

#define put_user_or_fault(x, ptr, label)                                  \
	asm goto("1: movq %0, %1\n"                                       \
		 ".pushsection __ex_table,\"a\"\n"                        \
		 ".long 1b - ., %l2 - .\n"                                \
		 ".popsection\n"                                          \
		 : : "r"(x), "m"(*(ptr)) : : label)

int put_user_word(unsigned long *uptr, unsigned long v)
{
	if (!open_user_access(uptr, sizeof(*uptr)))
		return -14;
	asm volatile("1: movq %1, %0\n" : "=m"(*uptr) : "r"(v));
	close_user_access();
	return 0;
}

int put_user_pair(unsigned long *uptr, unsigned long a, unsigned long b)
{
	if (!open_user_access(uptr, 2 * sizeof(*uptr)))
		return -14;
	put_user_or_fault(a, &uptr[0], Efault);
	put_user_or_fault(b, &uptr[1], Efault);
	close_user_access();
	return 0;
Efault:
	close_user_access();
	return -14;
}
