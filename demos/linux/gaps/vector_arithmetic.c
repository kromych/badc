/* GNU vector types support the arithmetic operators elementwise, with a scalar
 * operand broadcast. badc implements the bitwise and unary forms but rejects
 * binary +, - and *: "invalid operands to binary operator (aggregate type)",
 * or "bad lvalue in compound assignment" for the compound spelling.
 */
typedef unsigned char u8x16 __attribute__((vector_size(16)));

void f(u8x16 *p)
{
	u8x16 w = *p;

	w = w & w;	/* accepted today */
	w = -w;		/* accepted today */
	w = w + w;	/* rejected */
	w = w - 0x40;	/* rejected */
	w -= 0x40;	/* rejected */
	*p = w;
}
