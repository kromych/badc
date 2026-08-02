/* The extent of an array with an omitted outer dimension is one past the
 * largest index an initializer writes (C99 6.7.8p22). With rank-2 designators
 * badc counts scalar elements instead of outer indices: it deduces 28 bytes for
 * an array gcc and clang size at 24, which is not even a whole number of rows.
 * The bytes are placed correctly; only the extent is wrong, so the explicit
 * form `t[4][3][2]' is rejected as having too many initializers.
 */
#define E(i, a, b, c, d) \
	[0][(i)] = {a, a}, \
	[1][(i)] = {b, b}, \
	[2][(i)] = {c, c}, \
	[3][(i)] = {d, d}

const signed char t[][3][2] = {
	E(0, 1, 2, 3, 4),
	E(1, 5, 6, 7, 8),
	E(2, 9, 10, 11, 12),
};

_Static_assert(sizeof(t) == 24, "deduced extent");
