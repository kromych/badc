/* An object alias keeps the type its own declaration gives it: `sizeof`
 * and arithmetic follow that type, and only the symbol binds to the
 * target's storage (GNU C `alias`), including a target defined after the
 * alias.
 */

int arr[3] = {1, 2, 3};
extern int arr_first __attribute__((alias("arr")));

long scalar = 7;
extern long scalar_pair[2] __attribute__((alias("scalar")));

static int hidden[4] = {5, 6, 7, 8};
extern int hidden_first __attribute__((alias("hidden")));

extern int later __attribute__((alias("table")));
int table[5] = {10, 20, 30, 40, 50};

int main(void)
{
    if (sizeof arr_first != sizeof(int)) return 1;
    if (arr_first != 1 || arr_first + 1 != 2) return 2;
    if (sizeof scalar_pair != 2 * sizeof(long) || scalar_pair[0] != 7) return 3;
    if (sizeof hidden_first != sizeof(int) || hidden_first * 2 != 10) return 4;
    if (sizeof later != sizeof(int) || later + 1 != 11) return 5;
    return 0;
}
