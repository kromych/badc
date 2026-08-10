// `typeof` of a multi-dimensional array member names the same array type
// the member has, dimensions included: the type has to carry the row
// shape, not just the total element count, or `t[i]` has no row to index.
// The shape mm/kfence/kfence_test.c declares its expected-report buffer
// with.
static struct {
	int nlines;
	char lines[2][8];
} observed;

#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
#define ARRAY_END(a)  (&(a)[ARRAY_SIZE(a)])

int main(void) {
	typeof(observed.lines) expect;
	const char *end;
	char *cur;

	// Widths are exact byte counts, so no data model changes them.
	if (sizeof(expect) != sizeof(observed.lines)) return 1;
	if (sizeof(expect) != 16) return 2;
	if (sizeof(expect[0]) != 8) return 3;
	if (ARRAY_SIZE(expect) != 2) return 4;
	if (ARRAY_SIZE(expect[0]) != 8) return 5;

	cur = expect[0];
	end = ARRAY_END(expect[0]);
	if (end - cur != 8) return 6;
	if (expect[1] - expect[0] != 8) return 7;

	expect[1][3] = 'x';
	if (*(expect[0] + 8 + 3) != 'x') return 8;
	return 0;
}
