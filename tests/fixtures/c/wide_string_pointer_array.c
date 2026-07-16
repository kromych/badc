/* C99 6.7.8: `T *names[] = { "a", "b" }` is a brace list of pointer
   initializers, one string literal each -- NOT a brace-wrapped string
   initializing one array. The array path applied the brace-wrap unwrap
   whenever the first element was a wide string, regardless of the element
   type, so `wchar_t *names[] = { L"a", L"b" }` (the edk2 firmware form
   `CHAR16 *mDeviceTypeStr[]`) was rejected: after the first literal it
   demanded the closing `}`. The unwrap now requires a wchar_t-width scalar
   element, mirroring the narrow char[] guard, so a pointer array stays a
   brace list. The legitimate brace-wrapped and bare wide-array forms still
   work. Comparisons use code points, which hold at either wchar_t width. */

#include <stddef.h>

wchar_t *wide[] = { L"Legacy BEV", L"Legacy Floppy", L"CD" };
char    *narrow[] = { "aa", "bb", "cc" };
wchar_t  warr[] = { L"abc" };          /* brace-wrapped wide scalar array */
wchar_t  bare[] = L"xy";               /* bare wide string */
char     carr[] = { "hi" };            /* brace-wrapped narrow string */

int main(void) {
    /* Array of wide pointers: three distinct strings, indexable. */
    if (!(wide[0][0] == L'L' && wide[0][7] == L'B'))
        return 1;
    if (!(wide[1][7] == L'F' && wide[1][8] == L'l' && wide[1][12] == L'y'))   /* "Legacy Floppy" */
        return 2;
    if (!(wide[2][0] == L'C' && wide[2][1] == L'D' && wide[2][2] == 0))
        return 3;
    if (wide[0] == wide[1] || wide[1] == wide[2])
        return 4;

    /* Array of narrow pointers still a brace list. */
    if (!(narrow[0][0] == 'a' && narrow[2][1] == 'c'))
        return 5;

    /* Brace-wrapped wide scalar array: one string fills the array. */
    if (!(warr[0] == L'a' && warr[1] == L'b' && warr[2] == L'c' && warr[3] == 0))
        return 6;

    /* Bare wide string. */
    if (!(bare[0] == L'x' && bare[1] == L'y' && bare[2] == 0))
        return 7;

    /* Brace-wrapped narrow string. */
    if (!(carr[0] == 'h' && carr[1] == 'i' && carr[2] == 0))
        return 8;

    return 0;
}
