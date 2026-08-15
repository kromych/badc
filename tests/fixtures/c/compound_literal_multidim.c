// C99 6.5.2.5: a compound literal may have a multi-dimensional array
// type. Every bracket dimension shapes the initializer -- the count is
// measured against the whole object, nested rows pad to the inner span,
// and the value decays to a pointer to the first row. Applies at file
// scope and block scope, on the constant and the per-element runtime
// store paths alike.
typedef signed char s8;

static s8 (*file_rows)[3] = (s8[2][3]){ { 1, 2, 3 }, { 4, 5, 6 } };
static int (*file_flat)[2] = (int[3][2]){ 10, 11, 12, 13, 14, 15 };

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
	return 0;
}
