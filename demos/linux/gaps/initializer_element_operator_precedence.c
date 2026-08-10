/* An initializer element is an assignment-expression (C99 6.7.8p1), so the
 * whole inclusive-OR expression is one element. After a parenthesized
 * subexpression badc resumes only at additive precedence: `*' and `-' continue
 * the element, while `|', `&', `^', `<<' and `||' end it, and the remainder is
 * read as a further initializer -- "too many initializers for struct s".
 *
 * A parenthesized constant continues correctly ((1 + 1) | 2 is accepted), so
 * the trigger is a parenthesized conditional or comma expression.
 */
struct s {
	int f;
};

static const struct s a = { .f = (1 ? 0x1 : 0) | (1 ? 0x2 : 0) };

static const struct s b = { .f = (1 ? 0x1 : 0) * 2 };	/* accepted today */
