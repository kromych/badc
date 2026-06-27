/* C99 6.6: the address of a struct member or array element of a
   static-storage object is an address constant usable in a static
   initializer. The designator may chain members and subscripts. */

struct inner {
    int x;
    int y;
};
struct outer {
    int a;
    struct inner in;
    int arr[5];
};

static struct outer o = {1, {2, 3}, {10, 11, 12, 13, 14}};
static int grid[3][4];

static int *const p_member = &o.a;
static int *const p_nested = &o.in.y;
static int *const p_field_array = &o.arr[3];
static int *const p_grid = &grid[2][1];

int main(void) {
    grid[2][1] = 42;
    if (*p_member != 1) {
        return 1;
    }
    if (*p_nested != 3) {
        return 2;
    }
    if (*p_field_array != 13) {
        return 3;
    }
    if (*p_grid != 42) {
        return 4;
    }
    return 0;
}
