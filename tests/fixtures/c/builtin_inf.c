// __builtin_inf / __builtin_inff yield positive infinity (as <math.h>'s
// INFINITY does). The Linux-only SYNC_FILE_RANGE_* flags ride along under
// their guard so the constants are exercised where they apply.
#include <fcntl.h>
int main(void) {
    double inf = __builtin_inf();
    if (!(inf > 1e308)) return 1;
    if (!(__builtin_inff() > 3.0e38f)) return 2;
    if (__builtin_huge_val() <= 1e308) return 3;
#ifdef __linux__
    if ((SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE
         | SYNC_FILE_RANGE_WAIT_AFTER) != 7)
        return 4;
#endif
    return 0;
}
