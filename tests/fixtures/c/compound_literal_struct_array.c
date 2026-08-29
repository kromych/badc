// C99 6.5.2.5p3: a compound literal is an unnamed object initialized by
// its brace list, so an array-of-struct literal takes the same rules a
// named array of the element type does -- one element per brace group,
// brace elision folding a flat value run into one element (6.7.8p20),
// omitted positions zeroed (6.7.8p21), and `[N]` designators placing
// elements and sizing a deferred dimension (6.7.8p22). The count is
// measured in elements, not in scalar leaves. Both storage durations:
// file scope is static, block scope is automatic and re-initialized on
// each entry (6.5.2.5p5).
struct pair { int a; int b; };
struct row { int k; int v[3]; };
struct box { struct pair p; char c; };
union num { int i; struct pair p; };

static const struct pair *file_one = (const struct pair[]){ { 5, 6 } };
static const struct pair *file_many = (const struct pair[]){ { 1, 2 }, { 3, 4 }, { 5, 6 } };
static const struct pair *file_fixed = (const struct pair[2]){ { 1, 2 }, { 3, 4 } };
static const struct pair *file_elide = (const struct pair[]){ 7, 8, 9, 10 };
static const struct pair *file_part = (const struct pair[3]){ { 1, 2 } };
static const struct pair *file_desig = (const struct pair[]){ [2] = { 9, 10 } };
static const struct row *file_nest = (const struct row[]){ { 1, { 2, 3, 4 } }, { 5, { 6, 7, 8 } } };
static const struct box *file_box = (const struct box[2]){ { { 1, 2 }, 'x' }, { { 3, 4 }, 'y' } };
static const union num *file_uni = (const union num[3]){ { .p = { 1, 2 } }, { .i = 42 } };
static const struct pair (*file_2d)[2] =
	(const struct pair[2][2]){ { { 1, 2 }, { 3, 4 } }, { { 5, 6 }, { 7, 8 } } };

static int file_one_size = (int)sizeof((struct pair[]){ { 5, 6 } });
static int file_elide_size = (int)sizeof((struct pair[]){ 7, 8, 9, 10 });
static int file_desig_size = (int)sizeof((struct pair[]){ [2] = { 9, 10 } });

static int pair_sum(const struct pair *p, int n)
{
	int t = 0, i;
	for (i = 0; i < n; i++)
		t += p[i].a * 10 + p[i].b;
	return t;
}

int main(void)
{
	const struct pair *one, *many, *fixed, *elide, *part, *desig;
	const struct row *nest;
	const struct box *box;
	const union num *uni;
	const struct pair (*grid)[2];
	int i, seed, t;

	// File scope, static storage.
	if (file_one[0].a != 5 || file_one[0].b != 6) return 1;
	if (file_many[0].a != 1 || file_many[0].b != 2) return 2;
	if (file_many[1].a != 3 || file_many[1].b != 4) return 3;
	if (file_many[2].a != 5 || file_many[2].b != 6) return 4;
	if (file_fixed[0].a != 1 || file_fixed[0].b != 2) return 5;
	if (file_fixed[1].a != 3 || file_fixed[1].b != 4) return 6;
	if (file_elide[0].a != 7 || file_elide[0].b != 8) return 7;
	if (file_elide[1].a != 9 || file_elide[1].b != 10) return 8;
	if (file_part[0].a != 1 || file_part[0].b != 2) return 9;
	if (file_part[1].a != 0 || file_part[1].b != 0) return 10;
	if (file_part[2].a != 0 || file_part[2].b != 0) return 11;
	if (file_desig[0].a != 0 || file_desig[0].b != 0) return 12;
	if (file_desig[1].a != 0 || file_desig[1].b != 0) return 13;
	if (file_desig[2].a != 9 || file_desig[2].b != 10) return 14;
	if (file_nest[0].k != 1 || file_nest[0].v[0] != 2) return 15;
	if (file_nest[0].v[1] != 3 || file_nest[0].v[2] != 4) return 16;
	if (file_nest[1].k != 5 || file_nest[1].v[0] != 6) return 17;
	if (file_nest[1].v[1] != 7 || file_nest[1].v[2] != 8) return 18;
	if (file_box[0].p.a != 1 || file_box[0].p.b != 2 || file_box[0].c != 'x') return 19;
	if (file_box[1].p.a != 3 || file_box[1].p.b != 4 || file_box[1].c != 'y') return 20;
	if (file_uni[0].p.a != 1 || file_uni[0].p.b != 2) return 21;
	if (file_uni[1].i != 42 || file_uni[2].i != 0) return 22;
	if (file_2d[0][0].a != 1 || file_2d[0][1].b != 4) return 23;
	if (file_2d[1][0].a != 5 || file_2d[1][1].b != 8) return 24;

	// The count is elements, not scalar leaves: four values fill two
	// two-int elements, and a designator sizes past the entries.
	if (file_one_size != (int)sizeof(struct pair)) return 25;
	if (file_elide_size != 2 * (int)sizeof(struct pair)) return 26;
	if (file_desig_size != 3 * (int)sizeof(struct pair)) return 27;

	// Block scope, automatic storage. Same shapes.
	one = (const struct pair[]){ { 5, 6 } };
	many = (const struct pair[]){ { 1, 2 }, { 3, 4 }, { 5, 6 } };
	fixed = (const struct pair[2]){ { 1, 2 }, { 3, 4 } };
	elide = (const struct pair[]){ 7, 8, 9, 10 };
	part = (const struct pair[3]){ { 1, 2 } };
	desig = (const struct pair[]){ [2] = { 9, 10 } };
	nest = (const struct row[]){ { 1, { 2, 3, 4 } }, { 5, { 6, 7, 8 } } };
	box = (const struct box[2]){ { { 1, 2 }, 'x' }, { { 3, 4 }, 'y' } };
	uni = (const union num[3]){ { .p = { 1, 2 } }, { .i = 42 } };
	grid = (const struct pair[2][2]){ { { 1, 2 }, { 3, 4 } }, { { 5, 6 }, { 7, 8 } } };

	if (one[0].a != 5 || one[0].b != 6) return 28;
	if (many[0].a != 1 || many[0].b != 2) return 29;
	if (many[1].a != 3 || many[1].b != 4) return 30;
	if (many[2].a != 5 || many[2].b != 6) return 31;
	if (fixed[0].a != 1 || fixed[0].b != 2) return 32;
	if (fixed[1].a != 3 || fixed[1].b != 4) return 33;
	if (elide[0].a != 7 || elide[0].b != 8) return 34;
	if (elide[1].a != 9 || elide[1].b != 10) return 35;
	if (part[0].a != 1 || part[0].b != 2) return 36;
	if (part[1].a != 0 || part[1].b != 0) return 37;
	if (part[2].a != 0 || part[2].b != 0) return 38;
	if (desig[0].a != 0 || desig[0].b != 0) return 39;
	if (desig[1].a != 0 || desig[1].b != 0) return 40;
	if (desig[2].a != 9 || desig[2].b != 10) return 41;
	if (nest[0].k != 1 || nest[0].v[0] != 2) return 42;
	if (nest[0].v[1] != 3 || nest[0].v[2] != 4) return 43;
	if (nest[1].k != 5 || nest[1].v[0] != 6) return 44;
	if (nest[1].v[1] != 7 || nest[1].v[2] != 8) return 45;
	if (box[0].p.a != 1 || box[0].p.b != 2 || box[0].c != 'x') return 46;
	if (box[1].p.a != 3 || box[1].p.b != 4 || box[1].c != 'y') return 47;
	if (uni[0].p.a != 1 || uni[0].p.b != 2) return 48;
	if (uni[1].i != 42 || uni[2].i != 0) return 49;
	if (grid[0][0].a != 1 || grid[0][1].b != 4) return 50;
	if (grid[1][0].a != 5 || grid[1][1].b != 8) return 51;

	if ((int)sizeof((struct pair[]){ { 5, 6 } }) != (int)sizeof(struct pair)) return 52;
	if ((int)sizeof((struct pair[]){ 7, 8, 9, 10 }) != 2 * (int)sizeof(struct pair)) return 53;

	// C99 6.7.8p13: an automatic literal may hold non-constant values.
	seed = 3;
	if (pair_sum((const struct pair[]){ { seed, seed + 1 }, { seed + 2, seed + 3 } }, 2) != 34 + 56)
		return 54;

	// 6.5.2.5p5: the object is created anew on each block entry, so a
	// store into one iteration's literal does not reach the next.
	t = 0;
	for (i = 0; i < 3; i++) {
		struct pair *w = (struct pair[]){ { i, i + 1 }, { i + 2, i + 3 } };
		w[0].a += 100;
		t += w[0].a + w[1].b;
	}
	if (t != 315) return 55;

	// The literal decays to a pointer to its first element (6.3.2.1p3).
	if (pair_sum((const struct pair[]){ { 1, 2 }, { 3, 4 }, { 5, 6 } }, 3) != 12 + 34 + 56)
		return 56;

	return 0;
}
