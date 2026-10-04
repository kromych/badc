// A pointer to an array with an unspecified bound (C99 6.7.5.2p4). The
// pointee is an incomplete array type, so `*p` is an lvalue of that type
// and decays to a pointer to its first element (6.3.2.1p3, which needs no
// complete type). A table typedef `typedef const struct token_entry
// table_t[];` and a `const table_t *` member dereferenced at the call
// take this shape.
struct token_entry {
	int token;
	const char *pattern;
};

typedef const struct token_entry table_t[];

struct proto {
	const char *name;
	const table_t *tokens;
};

static const table_t plain_tokens = {
	{ 3, "uid=%d" },
	{ 7, "err=%d" },
};

static const struct proto plain_proto = { "proto_plain", &plain_tokens };

static int find_token(const struct token_entry *table, const char *pattern) {
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
	const table_t *p = &plain_tokens;

	if (find_token(*plain_proto.tokens, "err=%d") != 7) return 1;
	if (find_token(*p, "uid=%d") != 3) return 2;
	if ((*p)[1].token != 7) return 3;
	if ((*p) + 1 != &(*p)[1]) return 4;
	// The decayed pointer and the member's own element pointer name the
	// same object.
	if (*plain_proto.tokens != &plain_tokens[0]) return 5;
	return 0;
}
