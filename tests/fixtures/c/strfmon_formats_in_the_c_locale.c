// <monetary.h>: strfmon in the C locale, where glibc and libSystem agree on
// the national format, the suppressed symbol, a left-justified field
// width and a suppressed grouping, returns the byte count, and fails with
// a count of -1 for a buffer too small.
// snapshot-budget: exempt
#include <monetary.h>
#include <string.h>

int main(void) {
    char buf[96];
    const char *want = "[1234.50] [7.00] [1.00      ] [1234567.00]";
    ssize_t n = strfmon(buf, sizeof buf, "[%n] [%!n] [%-10n] [%^n]", 1234.5, 7.0, 1.0, 1234567.0);

    if (n != (ssize_t)strlen(want)) return 1;
    if (strcmp(buf, want) != 0) return 2;
    if (strfmon(buf, 4, "%n", 1234.5) != -1) return 3;
    return 0;
}
