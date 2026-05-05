// M28a -- string-literal and brace-list array initializers, both at
// function scope and at file scope. The fixture pins:
//   - char buf[] = "literal"  -- size inferred from string + NUL
//   - char buf[N] = "literal" -- explicit size, partial init, rest zero
//   - int xs[]  = {1, 2, 3}   -- size inferred from list
//   - int xs[N] = {1, 2, 3}   -- explicit size, partial init, rest zero
//   - char *names[] = { "a", "b" } -- pointer-array init
//
// At file scope, the data segment is pre-zeroed and the initializer
// overwrites the leading bytes. At function scope, an Mcpy from a
// data-segment template populates the array; bytes past the
// initializer's length are left as whatever the stack frame held on
// entry.

char g_msg[] = "hello";
int g_primes[] = {2, 3, 5, 7, 11};
char g_buf[16] = "hi";
int g_table[5] = {1, 2, 3};
char *g_names[] = {"alpha", "beta", "gamma"};

int main() {
    char msg[] = "world";
    int xs[] = {100, 200, 300};
    char buf2[8] = "ok";

    // File-scope arrays.
    if (g_msg[0] != 'h') return 1;
    if (g_msg[4] != 'o') return 2;
    if (g_msg[5] != 0) return 3;
    if (sizeof(g_msg) != 6) return 4;

    if (g_primes[0] + g_primes[1] + g_primes[2] + g_primes[3] + g_primes[4] != 28) return 5;
    // M31: 5 * sizeof(int) = 5 * 4 = 20.
    if (sizeof(g_primes) != 20) return 6;

    if (g_buf[0] != 'h') return 7;
    if (g_buf[1] != 'i') return 8;
    if (g_buf[2] != 0) return 9;
    if (g_buf[15] != 0) return 10;
    if (sizeof(g_buf) != 16) return 11;

    if (g_table[0] != 1) return 12;
    if (g_table[2] != 3) return 13;
    if (g_table[3] != 0) return 14;
    if (g_table[4] != 0) return 15;

    if (g_names[0][0] != 'a') return 16;
    if (g_names[1][0] != 'b') return 17;
    if (g_names[2][4] != 'a') return 18;

    // Function-scope arrays.
    if (msg[0] != 'w') return 19;
    if (msg[4] != 'd') return 20;
    if (msg[5] != 0) return 21;
    if (sizeof(msg) != 6) return 22;

    if (xs[0] + xs[1] + xs[2] != 600) return 23;
    // M31: 3 * sizeof(int) = 12. (Padded up to nothing -- no struct
    // tail rule for plain arrays; the array's size is N*elem.)
    if (sizeof(xs) != 12) return 24;

    if (buf2[0] != 'o') return 25;
    if (buf2[1] != 'k') return 26;
    if (buf2[2] != 0) return 27;

    return 0;
}
