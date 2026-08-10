// A pointer to an array with an unspecified bound (C99 6.7.5.2p4). The
// pointee is an incomplete array type, so `*p` is an lvalue of that type
// and decays to a pointer to its first element (6.3.2.1p3, which needs no
// complete type). The shape <linux/parser.h> declares its match tables
// with: `typedef const struct match_token match_table_t[];` and a
// `const match_table_t *` member dereferenced at the call.
struct match_token {
	int token;
	const char *pattern;
};

typedef const struct match_token table_t[];

struct lockops {
	const char *name;
	const table_t *tokens;
};

static const table_t nolock_tokens = {
	{ 3, "jid=%d" },
	{ 7, "err=%d" },
};

static const struct lockops nolock_ops = { "lock_nolock", &nolock_tokens };

static int match_token(const struct match_token *table, const char *pattern) {
	int i;
	for (i = 0; i < 2; i++) {
		const char *a = table[i].pattern;
		const char *b = pattern;
		while (*a && *a == *b) { a++; b++; }
		if (*a == *b) return table[i].token;
	}
	return -1;
}

int main(void) {
	const table_t *p = &nolock_tokens;

	if (match_token(*nolock_ops.tokens, "err=%d") != 7) return 1;
	if (match_token(*p, "jid=%d") != 3) return 2;
	if ((*p)[1].token != 7) return 3;
	if ((*p) + 1 != &(*p)[1]) return 4;
	// The decayed pointer and the member's own element pointer name the
	// same object.
	if (*nolock_ops.tokens != &nolock_tokens[0]) return 5;
	return 0;
}
