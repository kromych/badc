// C99 6.7.8p17: after a designated entry in an array of structs,
// initialization resumes with the subobject following the designated
// one. A positional entry after a chained `[i][j] =` (or a `.field`
// chain) therefore takes the next element, not the next outer row; at
// a row boundary it takes a whole row again. Applies to the file-scope,
// static-local, and deferred-size collectors alike.
struct p {
	int x, y;
};

static struct p g[2][2] = { [0][0] = { 1, 2 }, { 3, 4 } };
static struct p rows[2][2] = { [0][1] = { 1, 2 }, { { 3, 4 }, { 5, 6 } } };
static struct p fld[2][2] = { [0][0].y = 9, { 3, 4 } };
static struct p elide[2][2] = { [0][0] = { 1, 2 }, 3, 4 };

int main(void) {
	if (g[0][0].x != 1 || g[0][0].y != 2) return 1;
	if (g[0][1].x != 3 || g[0][1].y != 4) return 2;
	if (g[1][0].x != 0 || g[1][1].y != 0) return 3;

	// The designated element ends its row, so the positional brace
	// entry spans the next whole row.
	if (rows[0][1].x != 1 || rows[1][0].x != 3 || rows[1][1].y != 6)
		return 4;

	// A `.field` chain also resumes at the next element.
	if (fld[0][0].x != 0 || fld[0][0].y != 9) return 5;
	if (fld[0][1].x != 3 || fld[0][1].y != 4) return 6;

	// Brace-elided scalars after the designator fill the next element.
	if (elide[0][1].x != 3 || elide[0][1].y != 4 || elide[1][0].x != 0)
		return 7;

	{
		static struct p l[2][2] = { [0][0] = { 5, 6 }, { 7, 8 } };
		if (l[0][1].x != 7 || l[0][1].y != 8 || l[1][0].x != 0)
			return 8;
	}
	{
		// Deferred outer dimension routes through the shared walker.
		static struct p w[][2] = { [0][0] = { 1, 2 }, { 3, 4 } };
		if (sizeof(w) != sizeof(struct p[1][2])) return 9;
		if (w[0][1].x != 3 || w[0][1].y != 4) return 10;
	}
	{
		// A nested row's own brace list resumes the same way.
		struct p n[2][2][2] = { { [0][0] = { 1, 2 }, { 3, 4 } },
					{ { { 9, 9 } } } };
		if (n[0][0][1].x != 3 || n[0][0][1].y != 4) return 11;
		if (n[0][1][0].x != 0 || n[1][0][0].x != 9) return 12;
	}
	return 0;
}
