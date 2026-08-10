// GCC "Compound Literals": an array initialized by a compound literal of
// array type takes the literal's brace list, as if the list had been
// written directly. It applies to static and automatic storage alike, and
// the literal is commonly wrapped in grouping parentheses by the macro
// that produces it -- drivers/scsi/fcoe defines its FIP MAC constants as
// `((__u8[6]) { 1, 0x10, 0x18, 1, 0, 2 })` and initializes `u8 x[ETH_ALEN]`
// from them.
typedef unsigned char u8;

#define FIP_ALL_FCF_MACS ((u8[6]) { 1, 0x10, 0x18, 1, 0, 2 })
#define TRIPLE           (int[]) { 4, 5, 6 }

static u8 file_sized[6] = FIP_ALL_FCF_MACS;
static int file_unsized[] = TRIPLE;

static int block_static(void) {
	static u8 s[6] = FIP_ALL_FCF_MACS;
	return s[1] + s[5];
}

static int block_auto(void) {
	u8 a[6] = FIP_ALL_FCF_MACS;
	int t[3] = TRIPLE;
	return a[2] + t[2];
}

int main(void) {
	int i;
	static const u8 want[6] = { 1, 0x10, 0x18, 1, 0, 2 };

	for (i = 0; i < 6; i++)
		if (file_sized[i] != want[i]) return 1;
	if (sizeof(file_unsized) != 3 * sizeof(int)) return 2;
	if (file_unsized[0] != 4 || file_unsized[2] != 6) return 3;
	if (block_static() != 0x10 + 2) return 4;
	if (block_auto() != 0x18 + 6) return 5;
	return 0;
}
