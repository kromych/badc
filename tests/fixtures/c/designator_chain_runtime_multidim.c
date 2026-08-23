// C99 6.7.8p6/p7/p17: a chained `[i][j]... =` designator on a local
// array whose element values force the per-element runtime store path
// takes the same grammar as the constant collector -- every subscript
// indexes one dimension, a member chain continues into a fully indexed
// struct element, the GNU `[lo ... hi]` range rides the last subscript,
// and a positional entry resumes at the subobject after the designated
// one.
struct p {
	int x, y;
};

static int seed(void) { return 7; }

int main(void) {
	{
		// Chained designator, then positional entries mid-row.
		int a[2][3] = { [0][1] = seed(), 30, 40 };
		if (a[0][0] != 0 || a[0][1] != 7 || a[0][2] != 30) return 1;
		if (a[1][0] != 40 || a[1][1] != 0) return 2;
	}
	{
		// Whole-row designator and a later chain into the other row.
		int b[2][3] = { [1] = { seed(), 8, 9 }, [0][2] = 5 };
		if (b[0][2] != 5 || b[1][0] != 7 || b[1][2] != 9) return 3;
	}
	{
		// Range on the last subscript of a chain.
		int c[2][4] = { [0][1 ... 2] = seed(), [1][0] = 1 };
		if (c[0][0] != 0 || c[0][1] != 7 || c[0][2] != 7 || c[0][3] != 0)
			return 4;
		if (c[1][0] != 1 || c[1][1] != 0) return 5;
	}
	{
		// Mid-depth chain names a sub-row; the positional entry after
		// it takes the next sub-row.
		int d[2][2][2] = { [1][0] = { seed(), 6 }, { 8, 9 } };
		if (d[0][0][0] != 0 || d[1][0][0] != 7 || d[1][0][1] != 6)
			return 6;
		if (d[1][1][0] != 8 || d[1][1][1] != 9) return 7;
	}
	{
		// Member chain on a fully indexed struct element.
		struct p e[2][2] = { [0][1].y = seed(), [1][0] = { 2, 3 } };
		if (e[0][1].x != 0 || e[0][1].y != 7) return 8;
		if (e[1][0].x != 2 || e[1][0].y != 3) return 9;
	}
	return 0;
}
