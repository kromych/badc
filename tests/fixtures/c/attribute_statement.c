// An attribute specifier at statement position. The GNU statement
// attributes make `__attribute__((fallthrough));` a null statement --
// what <linux/compiler_attributes.h> expands `fallthrough` to -- and an
// attribute may also precede a block-scope declaration. c5 acts on no
// statement attribute, so each is consumed and the statement after it
// runs normally.
#define fallthrough __attribute__((__fallthrough__))

static int classify(int m) {
	int r = 0;
	switch (m) {
	case 1:
		r += 1;
		fallthrough;
	case 2:
		r += 2;
		break;
	case 3:
		__attribute__((__fallthrough__));
	case 4:
		r += 4;
		break;
	default:
		r += 8;
		break;
	}
	return r;
}

static int labelled(int n) {
	__attribute__((unused)) int spare = 99;
	if (n)
		goto out;
	return 0;
out:
	__attribute__((unused));
	return spare;
}

int main(void) {
	if (classify(1) != 3) return 1;
	if (classify(2) != 2) return 2;
	if (classify(3) != 4) return 3;
	if (classify(4) != 4) return 4;
	if (classify(5) != 8) return 5;
	if (labelled(0) != 0) return 6;
	if (labelled(1) != 99) return 7;
	return 0;
}
