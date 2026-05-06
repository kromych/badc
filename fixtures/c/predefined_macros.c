// standard predefined macros: __FILE__, __LINE__, __STDC__,
// __DATE__, __TIME__. The first two are dynamic (their expansion
// changes with each line); __STDC__ is the constant 1; __DATE__ and
// __TIME__ are seeded at badc build time and have the C99 formats
// "Mmm dd yyyy" and "hh:mm:ss" respectively.

int main() {
    int line_a, line_b;
    char *date_str;
    char *time_str;
    char *file_str;

    // __LINE__ resolves to the current source line, so two
    // adjacent uses report consecutive numbers.
    line_a = __LINE__;
    line_b = __LINE__;
    if (line_b - line_a != 1) return 1;

    // __STDC__ is the constant 1 per C99 §6.10.8.
    if (__STDC__ != 1) return 2;

    // __DATE__ is "Mmm dd yyyy" (11 characters). The space separator
    // between the month and the day is always at index 3, and the
    // space between the day and the year is always at index 6 (since
    // the day field is space-padded for single-digit days).
    date_str = __DATE__;
    if (date_str[3] != ' ') return 3;
    if (date_str[6] != ' ') return 4;
    if (date_str[11] != 0) return 5;  // NUL terminator

    // __TIME__ is "hh:mm:ss" (8 characters). The colons sit at
    // indices 2 and 5; the trailing NUL at index 8.
    time_str = __TIME__;
    if (time_str[2] != ':') return 6;
    if (time_str[5] != ':') return 7;
    if (time_str[8] != 0) return 8;

    // __FILE__ resolves to the current filename. The badc top-level
    // source file is "<source>" -- non-empty, so the first byte is
    // not the NUL terminator.
    file_str = __FILE__;
    if (file_str[0] == 0) return 9;

    return 0;
}
