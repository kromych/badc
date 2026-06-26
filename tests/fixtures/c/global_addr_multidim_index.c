/* C99 6.6: the address of a multi-dimensional array element is an
   address constant usable in a static initializer. The byte offset is
   the sum over subscript levels of index * stride, where the stride at
   level k is the product of the inner dimensions times the element
   size. A single subscript level is the 1D case. */

static int grid[3][4];
static int cube[2][3][4];
static int *const row_ptr = &grid[2][1];
static int *const deep_ptr = &cube[1][2][3];
static int *const flat_ptr = &grid[0][0];

int main(void) {
    grid[2][1] = 21;
    cube[1][2][3] = 99;
    grid[0][0] = 7;
    if (*row_ptr != 21) {
        return 1;
    }
    if (*deep_ptr != 99) {
        return 2;
    }
    if (*flat_ptr != 7) {
        return 3;
    }
    return 0;
}
