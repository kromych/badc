// C11 6.7.2.1p13 makes the members of an anonymous aggregate members of
// the enclosing one, and C99 6.7.9p17 gives each such member its own
// brace level. The levels nest to any depth and mix struct with union, so
// the initializer has to treat a promoted run as a sub-object of the
// anonymous aggregate's own type rather than matching a per-kind tag.
struct n {
	char h;
	struct {
		char a;
		struct {
			char x;
			int y;
		};
	};
	char t;
};

union nested {
	struct {
		unsigned int lo;
		unsigned int hi;
		union {
			unsigned char b[2];
			unsigned short w;
		};
	};
	unsigned char raw[12];
};

struct with_union {
	int head;
	union {
		struct {
			int a;
			int b;
		};
		long long whole;
	};
	int tail;
};

static struct n flat   = { 1, 2, 3, 4, 5 };
static struct n one    = { 1, { 2, 3, 4 }, 5 };
static struct n nested = { 1, { 2, { 3, 4 } }, 5 };
static struct n desig  = { .h = 1, .a = 2, .x = 3, .y = 4, .t = 5 };

static union nested u = { { 0x11111111, 0x22222222, { { 7, 8 } } } };

static struct with_union w_first = { 1, { { 2, 3 } }, 4 };
static struct with_union w_alt   = { 1, { .whole = 0 }, 4 };
static struct with_union w_pos   = { 1, 2, 3 };

static int same(const struct n *p, const struct n *q) {
	return p->h == q->h && p->a == q->a && p->x == q->x && p->y == q->y
	       && p->t == q->t;
}

int main(void) {
	if (!same(&nested, &flat)) return 1;
	if (!same(&one, &flat)) return 2;
	if (!same(&desig, &flat)) return 3;
	if (nested.y != 4 || nested.t != 5) return 4;

	if (u.lo != 0x11111111u || u.hi != 0x22222222u) return 5;
	if (u.b[0] != 7 || u.b[1] != 8) return 6;

	if (w_first.head != 1 || w_first.a != 2 || w_first.b != 3
	    || w_first.tail != 4) return 7;
	if (w_alt.head != 1 || w_alt.whole != 0 || w_alt.tail != 4) return 8;
	// A positional entry fills the union's first alternative, whose own
	// members continue positionally; the next entry lands past the union.
	if (w_pos.head != 1 || w_pos.a != 2 || w_pos.b != 3) return 9;
	return 0;
}
