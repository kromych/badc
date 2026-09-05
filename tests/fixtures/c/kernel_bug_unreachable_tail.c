// snapshot-flags: -c -mcmodel=kernel -mfunction-return=thunk-extern -fcf-protection=branch
// `BUG()`: a trapping asm followed by `__builtin_unreachable()`. The
// statement seals its block, so what the source places after it -- the
// `return` of a `default:` arm, the fall-off return of an inlined
// helper -- is unreachable and not emitted; objtool reports every
// instruction after a trap that no path reaches.

#define BUG()                                                                      \
	do {                                                                       \
		asm volatile("1:\tud2\n" : : "i"(__FILE__), "i"(__LINE__), "i"(0), \
			     "i"(12));                                             \
		__builtin_unreachable();                                           \
	} while (0)

static _Bool wants_ingress(int action)
{
	switch (action) {
	case 1:
	case 2:
		return 0;
	case 3:
	case 4:
		return 1;
	default:
		BUG();
	}
}

int redir(int action)
{
	return wants_ingress(action) ? 10 : 20;
}

int run_request(int test_case)
{
	switch (test_case) {
	case 1:
		return 5;
	case 2:
		return 6;
	default:
		BUG();
		return -22;
	}
}

int trap_then_return(int x)
{
	if (x < 0)
		__builtin_trap();
	return x;
}
