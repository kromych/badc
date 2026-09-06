/* An explicit section holds a size-driven candidate out of line -- the
   splice moves the body out of the section its placement names -- but it
   does not hold a mandatory request out of line. gcc and clang both
   splice such a body into a caller in any section and emit no
   out-of-line copy; the kernel needs that, since a call left out of line
   from `.text` into an `__init` helper outlives the section it targets.

   The plain `inline` specifier keeps the contract, so the two forms are
   checked side by side. */

__attribute__((always_inline, section(".init.text")))
static inline int boot_scale(int x)
{
	return x * 3 + 1;
}

/* Same shape without the mandatory request: stays in its section. */
__attribute__((section(".init.text")))
static inline int boot_offset(int x)
{
	return x + 7;
}

/* A caller in the same section takes both. */
__attribute__((section(".init.text")))
static int boot_step(int x)
{
	return boot_scale(x) + boot_offset(x);
}

__attribute__((noinline)) static int run_boot(int x)
{
	return boot_step(x);
}

/* A caller in the default section: only the mandatory one is spliced. */
__attribute__((noinline)) static int run_text(int x)
{
	return boot_scale(x) + boot_offset(x);
}

int main(void)
{
	if (run_boot(5) != 5 * 3 + 1 + 5 + 7) {
		return 1;
	}
	if (run_text(4) != 4 * 3 + 1 + 4 + 7) {
		return 2;
	}
	return 0;
}
