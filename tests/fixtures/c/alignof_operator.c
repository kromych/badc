// C11 6.5.3.4: `_Alignof ( type-name )` yields the alignment requirement
// of the type as a compile-time constant. The alignment of an array is
// its element's alignment (C11 6.2.8); a pointer aligns to 8 on the
// supported targets. The values used here are target-independent
// (`long long`, pointers, and `double` are 8-byte-aligned everywhere).

typedef struct { long long x; char c; } S;

static int g_align = _Alignof(S);

int main(void) {
    if (g_align != 8) return 1;
    if (_Alignof(S) != 8) return 2;
    if (_Alignof(char) != 1) return 3;
    if (_Alignof(short) != 2) return 4;
    if (_Alignof(int) != 4) return 5;
    if (_Alignof(double) != 8) return 6;
    if (_Alignof(int *) != 8) return 7;
    if (_Alignof(int[10]) != 4) return 8;
    if (_Alignof(S[4]) != 8) return 9;
    return 0;
}
