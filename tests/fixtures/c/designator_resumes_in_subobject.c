// C99 6.7.8p17: after a designator list that names a member of a member,
// an element of an array member or a member of an array element,
// initialization continues with the next subobject inside the designated
// one's enclosing object, its braces elided, before it moves on to the
// next subobject of the braced list's object. A designator after a
// brace-elided value names a subobject of the braced list's object.
// The GNU range resumes after its last element.
struct S {
	char m[3];
	int n;
};
struct T {
	int a, b;
};
struct I {
	int x, y;
};
struct O {
	struct I m;
	int z;
};
struct A {
	int a[3];
	int z;
};
struct M {
	struct I m[2];
	int z;
};
struct N {
	struct I i;
	int b;
};

static struct S s_open[] = { [1].m = "x", 5 };
static struct S s_bound[2] = { [1].m = "x", 5 };
static struct T t_open[] = { [1].a = 4, 5 };
static struct O o_member = { .m.x = 1, 2, 3 };
static struct A a_index = { .a[1] = 1, 2, 3 };
static struct M m_elem = { .m[1].x = 1, 2, 3 };
static struct N n_deep[] = { [1].i.x = 4, 5, 6 };
static struct O o_elided = { 1, .z = 3 };
static struct M m_elided = { 1, 2, 3, .z = 4 };
static struct I i_elided[2] = { 1, [1].y = 3 };
static struct T t_range[] = { [0 ... 1].a = 4, 5 };
static struct A a_range = { .a[0 ... 1] = 7, 8 };
static struct T t_rows[2][2] = { [0][0].a = 1, 2, 3 };

static int value(int v) { return v; }

int main(void) {
	if (sizeof s_open / sizeof s_open[0] != 2 || s_open[1].n != 5) return 1;
	if (s_bound[1].m[0] != 'x' || s_bound[1].n != 5) return 2;
	if (sizeof t_open / sizeof t_open[0] != 2 || t_open[1].b != 5) return 3;
	if (o_member.m.y != 2 || o_member.z != 3) return 4;
	if (a_index.a[2] != 2 || a_index.z != 3) return 5;
	if (m_elem.m[1].y != 2 || m_elem.z != 3) return 6;
	if (sizeof n_deep / sizeof n_deep[0] != 2) return 7;
	if (n_deep[1].i.y != 5 || n_deep[1].b != 6) return 8;
	if (o_elided.m.x != 1 || o_elided.m.y != 0 || o_elided.z != 3) return 9;
	if (m_elided.m[1].x != 3 || m_elided.z != 4) return 10;
	if (i_elided[0].x != 1 || i_elided[1].y != 3) return 11;
	if (sizeof t_range / sizeof t_range[0] != 2) return 12;
	if (t_range[0].b != 0 || t_range[1].b != 5) return 13;
	if (a_range.a[1] != 7 || a_range.a[2] != 8 || a_range.z != 0) return 14;
	if (t_rows[0][0].b != 2 || t_rows[0][1].a != 3) return 15;

	struct S l_open[] = { [1].m = "x", 5 };
	if (sizeof l_open / sizeof l_open[0] != 2 || l_open[1].n != 5) return 16;
	struct T l_bound[2] = { [1].a = 4, 5 };
	if (l_bound[1].b != 5) return 17;
	struct O l_member = { .m.x = 1, 2, 3 };
	if (l_member.m.y != 2 || l_member.z != 3) return 18;
	struct A l_index = { .a[1] = 1, 2, 3 };
	if (l_index.a[2] != 2 || l_index.z != 3) return 19;
	struct O l_elided = { 1, .z = 3 };
	if (l_elided.m.x != 1 || l_elided.z != 3) return 20;
	struct T l_rows[2][2] = { [0][0].a = 1, 2, 3 };
	if (l_rows[0][0].b != 2 || l_rows[0][1].a != 3) return 21;
	struct T l_range[] = { [0 ... 1].a = 4, 5 };
	if (l_range[0].b != 0 || l_range[1].b != 5) return 22;

	// Values that are not constant take the runtime store path.
	int v = value(5);
	struct T r_open[] = { [1].a = 4, v };
	if (sizeof r_open / sizeof r_open[0] != 2 || r_open[1].b != 5) return 23;
	struct O r_member = { .m.x = v, v + 1, v + 2 };
	if (r_member.m.y != 6 || r_member.z != 7) return 24;
	struct T r_rows[2][2] = { [0][0].a = 1, 2, v };
	if (r_rows[0][0].b != 2 || r_rows[0][1].a != 5) return 25;
	struct T r_range[] = { [0 ... 1].a = 4, v };
	if (r_range[0].b != 0 || r_range[1].b != 5) return 26;
	return 0;
}
