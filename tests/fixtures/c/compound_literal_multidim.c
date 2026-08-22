// C99 6.5.2.5: a compound literal may have a multi-dimensional array
// type. Every bracket dimension shapes the initializer -- the count is
// measured against the whole object, nested rows pad to the inner span,
// and the value decays to a pointer to the first row. Applies at file
// scope and block scope, on the constant and the per-element runtime
// store paths alike.
typedef signed char s8;
typedef int irow[3];

static s8 (*file_rows)[3] = (s8[2][3]){ { 1, 2, 3 }, { 4, 5, 6 } };
static int (*file_flat)[2] = (int[3][2]){ 10, 11, 12, 13, 14, 15 };
static int (*file_elide)[2] = (int[][2]){ 20, 21, 22, 23 };
static int file_elide_size = sizeof((int[][3]){ 1, 2, 3, 4, 5, 6 });
static int (*file_trows)[3] = (irow[2]){ { 1, 2, 3 }, { 4, 5, 6 } };
static int *file_trow = (irow){ 7, 8, 9 };
static int *file_pick = &(int[2][3]){ { 1, 2, 3 }, { 4, 5, 6 } }[1][2];
static int (*file_row1)[3] = &(int[2][3]){ { 1, 2, 3 }, { 4, 5, 6 } }[1];

static int runtime_seed(void) { return 40; }

int main(void) {
	int i, j, sum;

	sum = 0;
	for (i = 0; i < 2; i++)
		for (j = 0; j < 3; j++)
			sum += file_rows[i][j];
	if (sum != 21 || file_rows[1][2] != 6) return 1;
	if (file_flat[0][0] != 10 || file_flat[1][1] != 13 || file_flat[2][0] != 14)
		return 2;
	{
		s8 (*p)[3] = (s8[2][3]){ { 1, 2, 3 }, { 4, 5, 6 } };
		if (p[0][0] != 1 || p[1][0] != 4 || p[1][2] != 6) return 3;
	}
	{
		// Deferred outer dimension, completed by the row count.
		s8 (*p)[3] = (s8[][3]){ { 1, 2, 3 }, { 4, 5, 6 } };
		if (p[1][1] != 5) return 4;
		if (sizeof((s8[][3]){ { 1, 2, 3 }, { 4, 5, 6 } }) != 6) return 5;
	}
	{
		// A short row pads to the inner span (C99 6.7.8p21).
		int (*p)[3] = (int[2][3]){ { 7 }, { 8, 9 } };
		if (p[0][0] != 7 || p[0][1] != 0 || p[1][0] != 8 || p[1][2] != 0)
			return 6;
	}
	{
		// A non-constant element takes the runtime store path.
		int (*p)[2] = (int[2][2]){ { runtime_seed(), 41 }, { 42, 43 } };
		if (p[0][0] != 40 || p[0][1] != 41 || p[1][1] != 43) return 7;
	}
	if (sizeof((s8[2][3]){ { 1, 2, 3 }, { 4, 5, 6 } }) != 6) return 9;
	if ((int[2][3]){ { 9, 8, 7 }, { 6, 5, 4 } }[1][2] != 4) return 10;
	{
		s8 (*p)[2][2] = (s8[2][2][2]){ { { 1, 2 }, { 3, 4 } },
					       { { 5, 6 }, { 7, 8 } } };
		if (p[0][1][0] != 3 || p[1][0][1] != 6 || p[1][1][1] != 8) return 11;
	}
	{
		// Brace elision under a deferred outer dimension: a flat run
		// folds into rows of the inner span, and a partial last row
		// still opens a full one (C99 6.7.8p20-p22).
		int (*p)[3] = (int[][3]){ 1, 2, 3, 4, 5, 6 };
		if (sizeof((int[][3]){ 1, 2, 3, 4, 5, 6 }) != 24) return 12;
		if (sizeof((int[][2]){ 1, 2, 3 }) != 16) return 13;
		if (p[1][0] != 4 || p[1][2] != 6) return 14;
	}
	if (file_elide[0][1] != 21 || file_elide[1][0] != 22) return 15;
	if (file_elide_size != 24) return 16;
	{
		// Elided rows on the per-element runtime store path.
		int (*p)[2] = (int[][2]){ runtime_seed(), 51, 52, 53 };
		if (p[0][0] != 40 || p[0][1] != 51 || p[1][1] != 53) return 17;
	}
	{
		// An array typedef supplies the literal's inner dimensions
		// (C99 6.7.7): `(irow[2])` is `int[2][3]`, bare `(irow)` the
		// row itself, and a static local reads a staged element back.
		int (*p)[3] = (irow[2]){ { 1, 2, 3 }, { 4, 5, 6 } };
		static int pick = (irow[2]){ { 1, 2, 3 }, { 4, 5, 6 } }[1][0];
		if (sizeof((irow[2]){ { 1, 2, 3 } }) != 6 * sizeof(int)) return 18;
		if (sizeof((irow){ 7, 8, 9 }) != 3 * sizeof(int)) return 19;
		if (p[1][2] != 6 || (irow){ 7, 8, 9 }[2] != 9 || pick != 4) return 20;
	}
	if (file_trows[1][1] != 5 || file_trow[2] != 9) return 21;
	// Address constants into a file-scope literal stride by the row.
	if (*file_pick != 6 || (*file_row1)[0] != 4 || file_row1[0][2] != 6)
		return 22;
	return 0;
}
