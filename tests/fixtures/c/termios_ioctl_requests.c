// The terminal ioctl request numbers and modem-line status bits of
// <termios.h> / <sys/ioctl.h>, checked against the values the target's
// own headers carry: <asm/ioctls.h> and <asm/termbits.h> on Linux, the
// SDK's <sys/ttycom.h> on macOS. Each request is also passed to ioctl
// against a pipe, which is not a terminal, so the call is a binding and
// argument-passing check and its failure is expected.
//
// The termios2 requests encode sizeof(struct termios2) in their size
// field, so the caller declares that struct -- the arrangement the
// kernel headers rely on -- and the asserted number covers the layout.

#ifdef _WIN32
int main(void) { return 0; }
#else
#include <sys/ioctl.h>
#include <termios.h>
#include <unistd.h>

#ifdef __linux__
struct termios2 {
    tcflag_t c_iflag;
    tcflag_t c_oflag;
    tcflag_t c_cflag;
    tcflag_t c_lflag;
    cc_t c_line;
    cc_t c_cc[19];
    speed_t c_ispeed;
    speed_t c_ospeed;
};
#endif

int main(void) {
    // Modem-control lines: read, set, and the per-bit set / clear pair.
#ifdef __linux__
    if (TIOCMGET != 0x5415) return 1;
    if (TIOCMBIS != 0x5416) return 2;
    if (TIOCMBIC != 0x5417) return 3;
    if (TIOCMSET != 0x5418) return 4;
    if (TIOCM_LE != 0x001) return 5;
    if (TIOCM_DTR != 0x002) return 6;
    if (TIOCM_RTS != 0x004) return 7;
    if (TIOCM_ST != 0x008) return 8;
    if (TIOCM_SR != 0x010) return 9;
    if (TIOCM_CTS != 0x020) return 10;
    if (TIOCM_CAR != 0x040) return 11;
    if (TIOCM_RNG != 0x080) return 12;
    if (TIOCM_DSR != 0x100) return 13;
    // Break, window size, and the session / line-discipline requests.
    if (TCSBRK != 0x5409) return 14;
    if (TCSBRKP != 0x5425) return 15;
    if (TIOCSBRK != 0x5427) return 16;
    if (TIOCCBRK != 0x5428) return 17;
    if (TIOCSWINSZ != 0x5414) return 18;
    if (TIOCEXCL != 0x540c) return 19;
    if (TIOCNXCL != 0x540d) return 20;
    if (TIOCSCTTY != 0x540e) return 21;
    if (TIOCGPGRP != 0x540f) return 22;
    if (TIOCSPGRP != 0x5410) return 23;
    if (TIOCOUTQ != 0x5411) return 24;
    if (TIOCSTI != 0x5412) return 25;
    if (TIOCCONS != 0x541d) return 26;
    if (TIOCPKT != 0x5420) return 27;
    if (TIOCNOTTY != 0x5422) return 28;
    if (TIOCSETD != 0x5423) return 29;
    if (TIOCGETD != 0x5424) return 30;
    if (TIOCPKT_DATA != 0) return 31;
    if (TIOCPKT_FLUSHREAD != 1) return 32;
    if (TIOCPKT_FLUSHWRITE != 2) return 33;
    if (TIOCPKT_STOP != 4) return 34;
    if (TIOCPKT_START != 8) return 35;
    if (TIOCPKT_NOSTOP != 16) return 36;
    if (TIOCPKT_DOSTOP != 32) return 37;
    // c_cflag: the arbitrary-baud selector and the mark/space parity bit.
    if (BOTHER != CBAUDEX) return 38;
    if (CMSPAR != 0x40000000) return 39;
    if (__MAX_BAUD != B4000000) return 40;
    // _IOR / _IOW over a 44-byte struct termios2.
    if (TCGETS2 != 0x802c542a) return 41;
    if (TCSETS2 != 0x402c542b) return 42;
    if (TCSETSW2 != 0x402c542c) return 43;
    if (TCSETSF2 != 0x402c542d) return 44;
    if (_POSIX_VDISABLE != 0) return 45;
#endif
#ifdef __APPLE__
    if (TIOCMGET != 0x4004746a) return 1;
    if (TIOCMBIS != 0x8004746c) return 2;
    if (TIOCMBIC != 0x8004746b) return 3;
    if (TIOCMSET != 0x8004746d) return 4;
    if (TIOCM_LE != 0x001) return 5;
    if (TIOCM_DTR != 0x002) return 6;
    if (TIOCM_RTS != 0x004) return 7;
    if (TIOCM_ST != 0x008) return 8;
    if (TIOCM_SR != 0x010) return 9;
    if (TIOCM_CTS != 0x020) return 10;
    if (TIOCM_CAR != 0x040) return 11;
    if (TIOCM_RNG != 0x080) return 12;
    if (TIOCM_DSR != 0x100) return 13;
    if (TIOCSWINSZ != 0x80087467) return 18;
    if (_POSIX_VDISABLE != 255) return 45;
#endif
    if (TIOCM_CD != TIOCM_CAR) return 46;
    if (TIOCM_RI != TIOCM_RNG) return 47;

    // A pipe read end is not a terminal, so each request fails; the
    // call still exercises the binding and the argument passing.
    int fds[2];
    if (pipe(fds)) return 48;
    int lines = 0;
    struct winsize ws;
    ws.ws_row = 24;
    ws.ws_col = 80;
    ws.ws_xpixel = 0;
    ws.ws_ypixel = 0;
    if (ioctl(fds[0], TIOCMGET, &lines) != -1) return 49;
    if (ioctl(fds[0], TIOCSWINSZ, &ws) != -1) return 50;
    close(fds[0]);
    close(fds[1]);
    return 0;
}
#endif
