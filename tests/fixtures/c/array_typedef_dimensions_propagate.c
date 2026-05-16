// Locks C99 6.7.7 paragraph 3: a typedef name "denotes the same
// type" as its right-hand-side; an aliased array type carries
// its dimension through every use position. The c5 parser
// previously dropped the array-ness when the typedef name was
// consumed as a base type, so the bound declarator collapsed
// to the element scalar.
//
// The fixture exercises the four positions the parser routes
// through: file-scope variable, block-scope variable, struct
// field, and a comparison against the raw-array form. Each
// must report the same byte count.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

typedef long arr_t[64];

arr_t g_direct;
struct WithArr { arr_t b; };

int main(void) {
    arr_t local;
    long  raw_arr[64];
    struct WithArr s;

    if (sizeof(g_direct) != 64 * sizeof(long)) return 11;
    if (sizeof(local)    != 64 * sizeof(long)) return 12;
    if (sizeof(raw_arr)  != 64 * sizeof(long)) return 13;
    if (sizeof(s.b)      != 64 * sizeof(long)) return 14;
    return 0;
}
