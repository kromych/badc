// C11 6.7.2.1p13 promotes an anonymous aggregate's members into the
// enclosing one at every nesting level, and C99 6.7.9p17 gives each
// level its own brace. A brace may therefore open an inner anonymous
// aggregate whose enclosing anonymous level was spelled flat: the
// initializer has to recognize the inner run's start through the
// nested promotion records, not just the outermost one.
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

struct deep {
	int h;
	struct {
		int a;
		struct {
			int b;
			struct {
				int c;
				int d;
			};
		};
	};
	int t;
};

struct with_union {
	int h;
	struct {
		int a;
		union {
			unsigned char b[4];
			unsigned int w;
		};
	};
	int t;
};

static struct n flat        = { 1, 2, 3, 4, 5 };
static struct n inner_only  = { 1, 2, { 3, 4 }, 5 };
static struct n both        = { 1, { 2, { 3, 4 } }, 5 };

static struct deep dflat  = { 1, 2, 3, 4, 5, 6 };
static struct deep dmid   = { 1, 2, { 3, { 4, 5 } }, 6 };
static struct deep dinner = { 1, 2, 3, { 4, 5 }, 6 };

static struct with_union uflat  = { 1, 2, { { 7, 8 } }, 3 };

static int same(const struct n *p, const struct n *q) {
	return p->h == q->h && p->a == q->a && p->x == q->x && p->y == q->y
	       && p->t == q->t;
}

static int dsame(const struct deep *p, const struct deep *q) {
	return p->h == q->h && p->a == q->a && p->b == q->b && p->c == q->c
	       && p->d == q->d && p->t == q->t;
}

int main(void) {
	if (!same(&inner_only, &flat)) return 1;
	if (!same(&both, &flat)) return 2;
	if (!dsame(&dmid, &dflat)) return 3;
	if (!dsame(&dinner, &dflat)) return 4;
	if (uflat.h != 1 || uflat.a != 2 || uflat.t != 3) return 5;
	if (uflat.b[0] != 7 || uflat.b[1] != 8 || uflat.b[2] != 0) return 6;
	{
		// The same shapes through the local paths, constant and
		// runtime-valued.
		int k = 4;
		struct n loc = { 1, 2, { 3, 4 }, 5 };
		struct n rt = { 1, 2, { 3, k }, 5 };
		static struct n sloc = { 1, 2, { 3, 4 }, 5 };
		if (!same(&loc, &flat)) return 7;
		if (!same(&rt, &flat)) return 8;
		if (!same(&sloc, &flat)) return 9;
	}
	return 0;
}
