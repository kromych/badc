// C99 6.7.8p17: after a designated entry, initialization resumes with
// the subobject following the one the designator named. A positional
// brace entry after a chained `[i][j] =` therefore spans the designator's
// rank, not a whole outer row -- measuring it against the outer row
// advances the element count by a full row per entry and rejects the
// list as overlong ("too many initializers").
typedef signed char s8;

static const s8 des[2][3][2] = {
	[0][1] = { 1, 2 },
	{ 3, 4 },
	[1][0] = { 5 },
	{ 7, 8 },
};
static const s8 flat[2][3][2] = {
	{ { 0, 0 }, { 1, 2 }, { 3, 4 } },
	{ { 5, 0 }, { 7, 8 }, { 0, 0 } },
};

// At a row boundary of the outer rank a positional brace entry spans a
// whole row again (its short list zero-fills the rest of the row).
static const s8 rows[2][2][2] = {
	[0][1] = { 1, 2 },
	{ 3, 4 },
};

static int same(const s8 *p, const s8 *q, int n) {
	int i;
	for (i = 0; i < n; i++)
		if (p[i] != q[i]) return 0;
	return 1;
}

int main(void) {
	if (sizeof(des) != 12) return 1;
	if (!same(&des[0][0][0], &flat[0][0][0], 12)) return 2;
	if (rows[0][1][0] != 1 || rows[0][1][1] != 2) return 3;
	if (rows[1][0][0] != 3 || rows[1][0][1] != 4) return 4;
	if (rows[1][1][0] != 0 || rows[1][1][1] != 0) return 5;
	{
		// The same list through the constant-local collector.
		const s8 loc[2][3][2] = {
			[0][1] = { 1, 2 },
			{ 3, 4 },
			[1][0] = { 5 },
			{ 7, 8 },
		};
		if (!same(&loc[0][0][0], &flat[0][0][0], 12)) return 6;
	}
	return 0;
}
