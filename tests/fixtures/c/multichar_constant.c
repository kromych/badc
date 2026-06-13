// C99 6.4.4.4p10: an integer character constant containing more than one
// character has an implementation-defined value. badc follows the common
// convention (gcc/clang for the narrow form): the bytes are packed with
// the first character in the most significant position,
// value = (value << 8) | byte. A single-character constant keeps its
// exact value, and escape sequences are unaffected.
int main(void) {
    if ('AB' != (('A' << 8) | 'B')) return 1;        // 0x4142
    if ('ABCD' != 0x41424344) return 2;
    if ('A' != 65) return 3;                          // single char unchanged
    if ('\n' != 10 || '\0' != 0 || '\t' != 9) return 4; // escapes unchanged
    if ('\101' != 'A') return 5;                      // octal escape, single
    if ('A\102' != (('A' << 8) | 'B')) return 6;      // char + octal escape
    return 0;
}
