// termios.h -- POSIX terminal control. The subset interactive
// programs reach for: query the current attributes, switch the
// terminal in and out of raw / no-echo mode.
//
// struct termios has a platform-specific layout (the flag word width
// and the control-character count differ), so it is defined per
// target. tcgetattr / tcsetattr read and write the real layout
// through the pointer, and the field offsets must line up.

#pragma once

// tcsetattr optional-action values (uniform across targets).
#define TCSANOW   0
#define TCSADRAIN 1
#define TCSAFLUSH 2

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::tcgetattr, "_tcgetattr")
#pragma binding(libc::tcsetattr, "_tcsetattr")

typedef unsigned long tcflag_t;
typedef unsigned char cc_t;
typedef unsigned long speed_t;
#define NCCS 20

struct termios {
    tcflag_t c_iflag;
    tcflag_t c_oflag;
    tcflag_t c_cflag;
    tcflag_t c_lflag;
    cc_t c_cc[NCCS];
    speed_t c_ispeed;
    speed_t c_ospeed;
};

#define VMIN   16
#define VTIME  17
#define TCSANOW 0
// c_iflag
#define IGNBRK 0x00000001
#define BRKINT 0x00000002
#define PARMRK 0x00000008
#define ISTRIP 0x00000020
#define INLCR  0x00000040
#define IGNCR  0x00000080
#define ICRNL  0x00000100
#define IXON   0x00000200
#define IXOFF  0x00000400
#define IXANY  0x00000800
// c_oflag
#define OPOST  0x00000001
// c_cflag
#define CSIZE  0x00000300
#define CS8    0x00000300
#define PARENB 0x00001000
// c_lflag
#define ECHO   0x00000008
#define ECHONL 0x00000010
#define ISIG   0x00000080
#define ICANON 0x00000100
#define IEXTEN 0x00000400
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::tcgetattr, "tcgetattr")
#pragma binding(libc::tcsetattr, "tcsetattr")

typedef unsigned int tcflag_t;
typedef unsigned char cc_t;
typedef unsigned int speed_t;
#define NCCS 32

struct termios {
    tcflag_t c_iflag;
    tcflag_t c_oflag;
    tcflag_t c_cflag;
    tcflag_t c_lflag;
    cc_t c_line;
    cc_t c_cc[NCCS];
    speed_t c_ispeed;
    speed_t c_ospeed;
};

#define VMIN   6
#define VTIME  5
#define TCSANOW 0
// c_iflag
#define IGNBRK 0000001
#define BRKINT 0000002
#define PARMRK 0000010
#define ISTRIP 0000040
#define INLCR  0000100
#define IGNCR  0000200
#define ICRNL  0000400
#define IXON   0002000
#define IXOFF  0010000
#define IXANY  0004000
// c_oflag
#define OPOST  0000001
// c_cflag
#define CSIZE  0000060
#define CS8    0000060
#define PARENB 0000400
// c_lflag
#define ISIG   0000001
#define ICANON 0000002
#define ECHO   0000010
#define ECHONL 0000100
#define IEXTEN 0100000
#endif

#ifdef _WIN32
// Windows consoles are configured through SetConsoleMode in
// <windows.h>; the POSIX termios surface is unavailable.
typedef unsigned int tcflag_t;
typedef unsigned char cc_t;
typedef unsigned int speed_t;
#define NCCS 32
struct termios {
    tcflag_t c_iflag;
    tcflag_t c_oflag;
    tcflag_t c_cflag;
    tcflag_t c_lflag;
    cc_t c_cc[NCCS];
};
#define VMIN   6
#define VTIME  5
#define TCSANOW 0
#define IGNBRK 0000001
#define BRKINT 0000002
#define PARMRK 0000010
#define ISTRIP 0000040
#define INLCR  0000100
#define IGNCR  0000200
#define ICRNL  0000400
#define IXON   0002000
#define IXOFF  0010000
#define IXANY  0004000
#define OPOST  0000001
#define CSIZE  0000060
#define CS8    0000060
#define PARENB 0000400
#define ISIG   0000001
#define ICANON 0000002
#define ECHO   0000010
#define ECHONL 0000100
#define IEXTEN 0100000
#endif

int tcgetattr(int fd, struct termios *termios_p);
int tcsetattr(int fd, int optional_actions, struct termios *termios_p);
