/* A union's size is its largest member rounded up to the union's own
 * alignment. packed sets that alignment to 1, so the size is 12. badc rounds to
 * the largest member's natural alignment instead and reports 16; gcc and clang
 * report 12. The alignment itself is right in all three.
 *
 * Silent: nothing diagnoses it in code that does not assert the size, and the
 * affected objects are wire and hardware-register layouts.
 */
union u {
	char c[12];
	long long v;
} __attribute__((packed));

_Static_assert(__alignof__(union u) == 1, "alignment");
_Static_assert(sizeof(union u) == 12, "size");
