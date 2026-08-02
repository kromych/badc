/* A null pointer constant is an integer constant expression with value 0 cast
 * to void * (C99 6.3.2.3p3); when one ?: operand is one and the other is a
 * pointer to an object type, the result has the object-pointer type
 * (C99 6.5.15p6). __builtin_strlen of a string literal is such a constant
 * expression, and folds as one everywhere else in badc -- but not here, so the
 * ?: result keeps the void * type and the assertion fails.
 *
 * The idiom is how the kernel asks whether an expression is a constant
 * expression, and the fortified strlen() picks its arm on the answer.
 */
_Static_assert(__builtin_strlen("abc") == 3, "value context: folds");

char arr[__builtin_strlen("abc")];

static int *p = (void *)((long)__builtin_strlen("abc") * 0l);

_Static_assert(sizeof(*(8 ? (void *)((long)__builtin_strlen("abc") * 0l)
			  : (int *)8)) == sizeof(int), "null pointer constant");
