// C99 6.10.3.4p1: a replacement list is rescanned together with the
// tokens that follow it, so a function-like macro name ending an
// object-like macro's body takes its arguments from the source after the
// invocation -- including from later lines, since a new-line inside an
// argument list is white space. `#define dprint if (debug) print` is a
// debug-print macro of that shape, with the format string and its
// arguments wrapped onto a second line.
static int calls;
static int last;
static int debug = 1;

static int real_print(const char *fmt, int a) {
	(void)fmt;
	calls++;
	last = a;
	return a;
}

#define print(fmt, ...) real_print(fmt, ##__VA_ARGS__)
#define dprint	if (debug) print
#define ALIAS dprint

int main(void) {
	dprint("one %d\n", 11);
	if (calls != 1 || last != 11) return 1;

	dprint("two %d\n",
		22);
	if (calls != 2 || last != 22) return 2;

	ALIAS("three %d\n",
	      33);
	if (calls != 3 || last != 33) return 3;

	debug = 0;
	dprint("four %d\n",
		44);
	if (calls != 3 || last != 33) return 4;
	return 0;
}
