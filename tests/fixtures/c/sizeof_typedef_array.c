// C99 6.5.3.4 paragraph 4: when applied to an array operand,
// `sizeof` reports the total number of bytes. The rule must hold
// equally for an array `typedef` (`sizeof(arr_t)` must match
// `sizeof(arr_var)` for a `arr_t arr_var;`), since C99 6.7.7p3
// makes the typedef equivalent to the declared array type.
//
// Pointer decoration on the typedef collapses it to a scalar
// pointer; `sizeof(arr_t *)` is 8 regardless of the array size.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

typedef long arr_long_64[64];
typedef int  arr_int_10[10];

int main(void) {
    long  direct_long[64];
    int   direct_int[10];

    if (sizeof(direct_long) != 64 * sizeof(long)) return 1;
    if (sizeof(direct_int)  != 10 * sizeof(int))  return 2;

    if (sizeof(arr_long_64) != sizeof(direct_long)) return 3;
    if (sizeof(arr_int_10)  != sizeof(direct_int))  return 4;

    if (sizeof(arr_long_64 *) != sizeof(long *)) return 5;
    if (sizeof(arr_int_10  *) != sizeof(int *))  return 6;

    return 0;
}
