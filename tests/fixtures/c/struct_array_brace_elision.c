// C99 6.7.9p20: a sub-array whose braces are elided takes as many entries
// as it holds from the enclosing list and leaves the rest to the sub-array
// after it; 6.7.9p21 zeroes what no entry reaches. A multi-dimensional
// array of structs is the case that needs it -- `struct thermal_trip
// trips[N][M] = { 0 };` in drivers/thermal/intel is the whole-object zero
// spelling of it.
struct trip {
	int temp;
	int hyst;
};

static struct trip zeroed[3][2] = { 0 };
static struct trip flat[2][2] = { 1, 2, 3, 4, 5, 6, 7, 8 };
static struct trip mixed[3][2] = { { { 1, 2 } }, 3, 4, 5, 6 };

static int check_zero(const struct trip (*t)[2], int rows) {
	int i, j;
	for (i = 0; i < rows; i++)
		for (j = 0; j < 2; j++)
			if (t[i][j].temp != 0 || t[i][j].hyst != 0) return 1;
	return 0;
}

int main(void) {
	struct trip local[3][2] = { 0 };

	if (check_zero(zeroed, 3)) return 1;
	if (check_zero(local, 3)) return 2;

	if (flat[0][0].temp != 1 || flat[0][0].hyst != 2) return 3;
	if (flat[0][1].temp != 3 || flat[0][1].hyst != 4) return 4;
	if (flat[1][0].temp != 5 || flat[1][0].hyst != 6) return 5;
	if (flat[1][1].temp != 7 || flat[1][1].hyst != 8) return 6;

	// A braced first row stops at its own `}`; the elided entries after it
	// start the next row.
	if (mixed[0][0].temp != 1 || mixed[0][0].hyst != 2) return 7;
	if (mixed[0][1].temp != 0 || mixed[0][1].hyst != 0) return 8;
	if (mixed[1][0].temp != 3 || mixed[1][0].hyst != 4) return 9;
	if (mixed[1][1].temp != 5 || mixed[1][1].hyst != 6) return 10;
	if (mixed[2][0].temp != 0 || mixed[2][1].hyst != 0) return 11;
	return 0;
}
