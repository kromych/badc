// Unsigned narrow locals assigned once and read across a loop body.
// mem2reg promotes them by masking the reaching value at each read,
// which must reproduce the zero-extension a frame load performs
// (C99 6.3.1.3): uc = 300 reads back 44, us = 0x12345 reads back
// 0x2345. Each comparison returns a distinct bit so the check stays
// off the exit-code low byte where the untruncated values alias.
int main(void) {
    unsigned char uc = 300;       // 300 & 0xff = 44
    unsigned short us = 0x12345;   // & 0xffff = 0x2345
    int i = 0;
    int seen_uc = 0;
    int seen_us = 0;
    while (i < 3) {
        seen_uc = seen_uc + uc;
        seen_us = seen_us + us;
        i = i + 1;
    }
    int r = 0;
    if (uc != 44) r = r + 1;
    if (us != 0x2345) r = r + 2;
    if (seen_uc != 44 * 3) r = r + 4;
    if (seen_us != 0x2345 * 3) r = r + 8;
    return r;
}
