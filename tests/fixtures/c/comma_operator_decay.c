// C99 6.5.17p2: the comma operator's result is its right operand's value,
// after lvalue conversion, so an array there has decayed to a pointer to
// its first element and `sizeof` gives the pointer's size; the same holds
// for a GNU statement expression's value. A parenthesized array is still
// the array. Each check exits with its own code; success returns 0.

static int f(void) { return 1; }

int main(void) {
    int arr[3];
    int two[2][3];
    struct {
        int m[4];
    } s;
    int x = 0;
    if (sizeof((0, arr)) != sizeof(int *)) return 1;
    if (sizeof((x++, arr)) != sizeof(int *)) return 2;
    if (sizeof((arr)) != sizeof(arr)) return 3;
    if (sizeof((0, two)) != sizeof(int (*)[3])) return 4;
    if (sizeof((0, two[1])) != sizeof(int *)) return 5;
    if (sizeof((0, s.m)) != sizeof(int *)) return 6;
    if (sizeof((0, "abc")) != sizeof(char *)) return 7;
    if (sizeof((0, f)) != sizeof(int (*)(void))) return 8;
    if (sizeof((0, arr, arr)) != sizeof(int *)) return 9;
    if (sizeof(({ arr; })) != sizeof(int *)) return 10;
    if (sizeof(1 ? (0, arr) : arr) != sizeof(int *)) return 11;
    __typeof__((0, arr)) p = arr;
    __typeof__(0, s.m) q = s.m;
    if (sizeof(p) != sizeof(int *) || sizeof(q) != sizeof(int *)) return 12;
    if (p != arr || q != s.m) return 13;
    return x;
}
