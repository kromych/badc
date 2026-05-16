// C99 6.7.8: a static initializer for a pointer element can use
// a cast-of-string-literal idiom -- `((const T *)"...")` -- so
// the slot ends up as a pointer to a fixed byte sequence. The
// outer pair of parens around the cast is the form BearSSL uses
// for its hash OID macros and the matching dispatch tables.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

static const unsigned char *OIDS[] = {
    ((const unsigned char *)"\x05\x2B\x0E\x03\x02\x1A"),
    ((const unsigned char *)"\x09\x60\x86\x48\x01\x65\x03\x04\x02\x04"),
    ((const unsigned char *)"\x09\x60\x86\x48\x01\x65\x03\x04\x02\x01"),
};

int main(void) {
    if (OIDS[0][0] != 0x05) return 1;
    if (OIDS[0][5] != 0x1A) return 2;
    if (OIDS[1][0] != 0x09) return 3;
    if (OIDS[1][9] != 0x04) return 4;
    if (OIDS[2][9] != 0x01) return 5;
    return 0;
}
