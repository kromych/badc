// C99 6.4.5p6 gives a string literal static storage, so a constant
// subscript on one is a constant value (the staged byte), and C99 6.6
// admits it in a static initializer -- also as the condition of an
// address-valued conditional, parenthesized or not. The shape comes
// from kunit's executor: `static char *p = ("" [0] ? "" : 0);`.
static char *p = ("" [0] ? "" : 0);
static char *q = "x"[0] ? "yes" : 0;
static char *r = ("x"[0] ? "yes" : 0);
static char *nul_arm = ("" [0] ? "" : ((void *)0));
static int m = ""[0];
static char e = "hi"[1];
static int b = "hi"[1] + 1;
static int arr[2] = { ""[0], "a"[0] };
static char *keep = "abc";

int f(void) {
	char *lp = ("" [0] ? "" : 0);
	static char *sp = ("" [0] ? "" : 0);
	static int sm = "z"[0];
	return !(lp == 0 && sp == 0 && sm == 'z');
}

int main(void) {
	if (p != 0) return 1;
	if (!q || q[0] != 'y' || q[2] != 's') return 2;
	if (!r || r[0] != 'y') return 3;
	if (nul_arm != 0) return 10;
	if (m != 0) return 4;
	if (e != 'i') return 5;
	if (b != 'i' + 1) return 6;
	if (arr[0] != 0 || arr[1] != 'a') return 7;
	if (keep[0] != 'a' || keep[2] != 'c') return 8;
	if (f()) return 9;
	return 0;
}
