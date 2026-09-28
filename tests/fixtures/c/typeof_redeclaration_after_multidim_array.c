// C99 6.7.2.2, GNU typeof: `extern typeof(x) x;`, the redeclaration Linux's
// EXPORT_SYMBOL expands to, names x's own type. The typeof of an array of
// arrays -- an array of an array typedef, or a declared two-level array --
// leaves no bounds to the next declaration: a one-dimensional array
// redeclared or declared through typeof after it keeps its own bound.
// Returns 0, distinct non-zero per failure.

typedef struct mask {
    unsigned long bits[2];
} mask_t[1];
typedef int row_t[3];

extern unsigned long offsets[256];
mask_t masks[16];
extern typeof(masks) masks;
unsigned long offsets[256];
extern typeof(offsets) offsets;

row_t grid[4];
extern typeof(grid) grid;
int flat[5];
typeof(flat) copy;
extern typeof(flat) flat;

int main(void) {
    if (sizeof offsets != 256 * sizeof(unsigned long)) return 1;
    if (sizeof masks != 16 * sizeof(mask_t) || sizeof masks[0] != sizeof(struct mask)) return 2;
    if (sizeof flat != 5 * sizeof(int) || sizeof copy != sizeof flat) return 3;
    if (sizeof grid != 4 * sizeof(row_t)) return 4;
    offsets[255] = 7;
    masks[15][0].bits[1] = 9;
    grid[3][2] = 5;
    flat[4] = 6;
    copy[4] = 8;
    if (offsets[255] != 7 || masks[15][0].bits[1] != 9 || grid[3][2] != 5) return 5;
    if (flat[4] != 6 || copy[4] != 8 || &copy[4] - &copy[0] != 4) return 6;
    return 0;
}
