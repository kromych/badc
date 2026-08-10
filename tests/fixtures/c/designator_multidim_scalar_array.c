// A chained designator on a multi-dimensional array of scalars: `[i][j] =
// { a, b }` names a row of the innermost dimension, so the brace list
// spans that row, not the outer one. Measuring it against the outer row
// advances the cursor by a whole row per entry and overruns the object.
// drivers/media/platform/rockchip/rkvdec/rkvdec-cabac.c builds its
// `[4][464][2]` table from a macro that writes four such entries.
typedef signed char s8;

#define ENTRY(i, a, b, c, d) \
	[0][(i)] = { a, b },     \
	[1][(i)] = { c, d }

static const s8 tab[2][3][2] = {
	ENTRY(0, 1, 2, 3, 4),
	ENTRY(2, 5, 6, 7, 8),
};

// A range at the innermost level fills each row it covers.
static const int rows[2][4][2] = {
	[1][0 ... 3] = { 9, 10 },
};

int main(void) {
	if (sizeof(tab) != 12) return 1;
	if (tab[0][0][0] != 1 || tab[0][0][1] != 2) return 2;
	if (tab[1][0][0] != 3 || tab[1][0][1] != 4) return 3;
	if (tab[0][2][0] != 5 || tab[0][2][1] != 6) return 4;
	if (tab[1][2][0] != 7 || tab[1][2][1] != 8) return 5;
	if (tab[0][1][0] != 0 || tab[1][1][1] != 0) return 6;
	{
		int i;
		for (i = 0; i < 4; i++)
			if (rows[1][i][0] != 9 || rows[1][i][1] != 10) return 7;
		for (i = 0; i < 4; i++)
			if (rows[0][i][0] != 0 || rows[0][i][1] != 0) return 8;
	}
	return 0;
}
