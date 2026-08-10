/* A parameter name is visible only inside its function (C99 6.2.1p4). Here the
 * parameter overwrites what badc recorded for the file-scope array: sizeof(reg)
 * still reports 32, but the second subscript no longer sees an array and the
 * use is rejected with "pointer type expected".
 *
 * Remove rd() and the same use compiles.
 */
static const unsigned int reg[2][4] = { {1, 2, 3, 4}, {5, 6, 7, 8} };

static unsigned int rd(unsigned int reg)
{
	return reg;
}

unsigned int g(void)
{
	return rd(reg[1][0]);
}
