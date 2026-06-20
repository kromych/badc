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
#pragma binding(libc::tcsendbreak, "_tcsendbreak")
#pragma binding(libc::tcdrain,     "_tcdrain")
#pragma binding(libc::tcflush,     "_tcflush")
#pragma binding(libc::tcflow,      "_tcflow")
#pragma binding(libc::cfmakeraw,   "_cfmakeraw")
#pragma binding(libc::cfgetospeed, "_cfgetospeed")
#pragma binding(libc::cfgetispeed, "_cfgetispeed")
#pragma binding(libc::cfsetospeed, "_cfsetospeed")
#pragma binding(libc::cfsetispeed, "_cfsetispeed")

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
#define VSTART 12
#define VSTOP  13
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
#define CS5    0x00000000
#define CS6    0x00000100
#define CS7    0x00000200
#define CS8    0x00000300
#define PARENB 0x00001000
#define PARODD 0x00002000
#define CSTOPB 0x00000400
#define CREAD  0x00000800
#define CLOCAL 0x00008000
#define HUPCL  0x00004000
#define CRTSCTS 0x00030000
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
#pragma binding(libc::tcsendbreak, "tcsendbreak")
#pragma binding(libc::tcdrain,     "tcdrain")
#pragma binding(libc::tcflush,     "tcflush")
#pragma binding(libc::tcflow,      "tcflow")
#pragma binding(libc::cfmakeraw,   "cfmakeraw")
#pragma binding(libc::cfgetospeed, "cfgetospeed")
#pragma binding(libc::cfgetispeed, "cfgetispeed")
#pragma binding(libc::cfsetospeed, "cfsetospeed")
#pragma binding(libc::cfsetispeed, "cfsetispeed")

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
#define VSTART 8
#define VSTOP  9
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
#define CS5    0000000
#define CS6    0000020
#define CS7    0000040
#define CS8    0000060
#define PARENB 0000400
#define PARODD 0001000
#define CSTOPB 0000100
#define CREAD  0000200
#define CLOCAL 0004000
#define HUPCL  0002000
#define CRTSCTS 020000000000
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
#define VSTART 8
#define VSTOP  9
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
#define CS5    0000000
#define CS6    0000020
#define CS7    0000040
#define CS8    0000060
#define PARENB 0000400
#define PARODD 0001000
#define CSTOPB 0000100
#define CREAD  0000200
#define CLOCAL 0004000
#define HUPCL  0002000
#define CRTSCTS 020000000000
#define ISIG   0000001
#define ICANON 0000002
#define ECHO   0000010
#define ECHONL 0000100
#define IEXTEN 0100000
#endif

int tcgetattr(int fd, struct termios *termios_p);
unsigned int cfgetospeed(const struct termios *termios_p);
unsigned int cfgetispeed(const struct termios *termios_p);
int cfsetospeed(struct termios *termios_p, unsigned int speed);
int cfsetispeed(struct termios *termios_p, unsigned int speed);
int tcsetattr(int fd, int optional_actions, struct termios *termios_p);
int tcsendbreak(int fd, int duration);
int tcdrain(int fd);
int tcflush(int fd, int queue_selector);
int tcflow(int fd, int action);
void cfmakeraw(struct termios *termios_p);

// POSIX constants completed from per-target system headers (termios baud/flags,
// control chars, queue/flow selectors). Values extracted per target.
#ifndef _POSIX_VDISABLE
#if defined(__APPLE__)
#define _POSIX_VDISABLE 255
#endif
#endif
#ifndef ALTWERASE
#if defined(__APPLE__)
#define ALTWERASE 512
#endif
#endif
#ifndef B0
#define B0 0
#endif
#ifndef B1000000
#if defined(__linux__)
#define B1000000 1000000
#endif
#endif
#ifndef B110
#define B110 110
#endif
#ifndef B115200
#define B115200 115200
#endif
#ifndef B1152000
#if defined(__linux__)
#define B1152000 1152000
#endif
#endif
#ifndef B1200
#define B1200 1200
#endif
#ifndef B134
#define B134 134
#endif
#ifndef B14400
#define B14400 14400
#endif
#ifndef B150
#define B150 150
#endif
#ifndef B1500000
#if defined(__linux__)
#define B1500000 1500000
#endif
#endif
#ifndef B1800
#define B1800 1800
#endif
#ifndef B19200
#define B19200 19200
#endif
#ifndef B200
#define B200 200
#endif
#ifndef B2000000
#if defined(__linux__)
#define B2000000 2000000
#endif
#endif
#ifndef B230400
#define B230400 230400
#endif
#ifndef B2400
#define B2400 2400
#endif
#ifndef B2500000
#if defined(__linux__)
#define B2500000 2500000
#endif
#endif
#ifndef B28800
#define B28800 28800
#endif
#ifndef B300
#define B300 300
#endif
#ifndef B3000000
#if defined(__linux__)
#define B3000000 3000000
#endif
#endif
#ifndef B3500000
#if defined(__linux__)
#define B3500000 3500000
#endif
#endif
#ifndef B38400
#define B38400 38400
#endif
#ifndef B4000000
#if defined(__linux__)
#define B4000000 4000000
#endif
#endif
#ifndef B460800
#if defined(__linux__)
#define B460800 460800
#endif
#endif
#ifndef B4800
#define B4800 4800
#endif
#ifndef B50
#define B50 50
#endif
#ifndef B500000
#if defined(__linux__)
#define B500000 500000
#endif
#endif
#ifndef B57600
#define B57600 57600
#endif
#ifndef B576000
#if defined(__linux__)
#define B576000 576000
#endif
#endif
#ifndef B600
#define B600 600
#endif
#ifndef B7200
#define B7200 7200
#endif
#ifndef B75
#define B75 75
#endif
#ifndef B76800
#define B76800 76800
#endif
#ifndef B921600
#if defined(__linux__)
#define B921600 921600
#endif
#endif
#ifndef B9600
#define B9600 9600
#endif
#ifndef BRKINT
#define BRKINT 2
#endif
#ifndef BS0
#define BS0 0
#endif
#ifndef BS1
#if defined(__APPLE__)
#define BS1 32768
#else
#define BS1 8192
#endif
#endif
#ifndef BSDLY
#if defined(__APPLE__)
#define BSDLY 32768
#else
#define BSDLY 8192
#endif
#endif
#ifndef CBAUD
#if defined(__linux__)
#define CBAUD 4111
#endif
#endif
#ifndef CBAUDEX
#if defined(__linux__)
#define CBAUDEX 4096
#endif
#endif
#ifndef CCAR_OFLOW
#if defined(__APPLE__)
#define CCAR_OFLOW 1048576
#endif
#endif
#ifndef CCTS_OFLOW
#if defined(__APPLE__)
#define CCTS_OFLOW 65536
#endif
#endif
#ifndef CDSR_OFLOW
#if defined(__APPLE__)
#define CDSR_OFLOW 524288
#endif
#endif
#ifndef CDSUSP
#define CDSUSP 25
#endif
#ifndef CDTR_IFLOW
#if defined(__APPLE__)
#define CDTR_IFLOW 262144
#endif
#endif
#ifndef CEOF
#define CEOF 4
#endif
#ifndef CEOL
#if defined(__APPLE__)
#define CEOL 255
#else
#define CEOL 0
#endif
#endif
#ifndef CEOT
#define CEOT 4
#endif
#ifndef CERASE
#define CERASE 127
#endif
#ifndef CFLUSH
#define CFLUSH 15
#endif
#ifndef CIBAUD
#if defined(__linux__)
#define CIBAUD 269418496
#endif
#endif
#ifndef CIGNORE
#if defined(__APPLE__)
#define CIGNORE 1
#endif
#endif
#ifndef CINTR
#define CINTR 3
#endif
#ifndef CKILL
#define CKILL 21
#endif
#ifndef CLNEXT
#define CLNEXT 22
#endif
#ifndef CLOCAL
#if defined(__APPLE__)
#define CLOCAL 32768
#else
#define CLOCAL 2048
#endif
#endif
#ifndef CQUIT
#define CQUIT 28
#endif
#ifndef CR0
#define CR0 0
#endif
#ifndef CR1
#if defined(__APPLE__)
#define CR1 4096
#else
#define CR1 512
#endif
#endif
#ifndef CR2
#if defined(__APPLE__)
#define CR2 8192
#else
#define CR2 1024
#endif
#endif
#ifndef CR3
#if defined(__APPLE__)
#define CR3 12288
#else
#define CR3 1536
#endif
#endif
#ifndef CRDLY
#if defined(__APPLE__)
#define CRDLY 12288
#else
#define CRDLY 1536
#endif
#endif
#ifndef CREAD
#if defined(__APPLE__)
#define CREAD 2048
#else
#define CREAD 128
#endif
#endif
#ifndef CRPRNT
#define CRPRNT 18
#endif
#ifndef CRTS_IFLOW
#if defined(__APPLE__)
#define CRTS_IFLOW 131072
#endif
#endif
#ifndef CS5
#define CS5 0
#endif
#ifndef CS6
#if defined(__APPLE__)
#define CS6 256
#else
#define CS6 16
#endif
#endif
#ifndef CS7
#if defined(__APPLE__)
#define CS7 512
#else
#define CS7 32
#endif
#endif
#ifndef CS8
#if defined(__APPLE__)
#define CS8 768
#else
#define CS8 48
#endif
#endif
#ifndef CSIZE
#if defined(__APPLE__)
#define CSIZE 768
#else
#define CSIZE 48
#endif
#endif
#ifndef CSTART
#define CSTART 17
#endif
#ifndef CSTOP
#define CSTOP 19
#endif
#ifndef CSTOPB
#if defined(__APPLE__)
#define CSTOPB 1024
#else
#define CSTOPB 64
#endif
#endif
#ifndef CSUSP
#define CSUSP 26
#endif
#ifndef CWERASE
#define CWERASE 23
#endif
#ifndef ECHO
#define ECHO 8
#endif
#ifndef ECHOCTL
#if defined(__APPLE__)
#define ECHOCTL 64
#else
#define ECHOCTL 512
#endif
#endif
#ifndef ECHOE
#if defined(__APPLE__)
#define ECHOE 2
#else
#define ECHOE 16
#endif
#endif
#ifndef ECHOK
#if defined(__APPLE__)
#define ECHOK 4
#else
#define ECHOK 32
#endif
#endif
#ifndef ECHOKE
#if defined(__APPLE__)
#define ECHOKE 1
#else
#define ECHOKE 2048
#endif
#endif
#ifndef ECHONL
#if defined(__APPLE__)
#define ECHONL 16
#else
#define ECHONL 64
#endif
#endif
#ifndef ECHOPRT
#if defined(__APPLE__)
#define ECHOPRT 32
#else
#define ECHOPRT 1024
#endif
#endif
#ifndef EXTA
#define EXTA 19200
#endif
#ifndef EXTB
#define EXTB 38400
#endif
#ifndef EXTPROC
#if defined(__APPLE__)
#define EXTPROC 2048
#else
#define EXTPROC 65536
#endif
#endif
#ifndef FF0
#define FF0 0
#endif
#ifndef FF1
#if defined(__APPLE__)
#define FF1 16384
#else
#define FF1 32768
#endif
#endif
#ifndef FFDLY
#if defined(__APPLE__)
#define FFDLY 16384
#else
#define FFDLY 32768
#endif
#endif
#ifndef FLUSHO
#if defined(__APPLE__)
#define FLUSHO 8388608
#else
#define FLUSHO 4096
#endif
#endif
#ifndef HUPCL
#if defined(__APPLE__)
#define HUPCL 16384
#else
#define HUPCL 1024
#endif
#endif
#ifndef IBSHIFT
#if defined(__linux__)
#define IBSHIFT 16
#endif
#endif
#ifndef ICANON
#if defined(__APPLE__)
#define ICANON 256
#else
#define ICANON 2
#endif
#endif
#ifndef ICRNL
#define ICRNL 256
#endif
#ifndef IEXTEN
#if defined(__APPLE__)
#define IEXTEN 1024
#else
#define IEXTEN 32768
#endif
#endif
#ifndef IGNBRK
#define IGNBRK 1
#endif
#ifndef IGNCR
#define IGNCR 128
#endif
#ifndef IGNPAR
#define IGNPAR 4
#endif
#ifndef IMAXBEL
#define IMAXBEL 8192
#endif
#ifndef INLCR
#define INLCR 64
#endif
#ifndef INPCK
#define INPCK 16
#endif
#ifndef ISIG
#if defined(__APPLE__)
#define ISIG 128
#else
#define ISIG 1
#endif
#endif
#ifndef ISTRIP
#define ISTRIP 32
#endif
#ifndef IUCLC
#if defined(__linux__)
#define IUCLC 512
#endif
#endif
#ifndef IUTF8
#define IUTF8 16384
#endif
#ifndef IXANY
#define IXANY 2048
#endif
#ifndef IXOFF
#if defined(__APPLE__)
#define IXOFF 1024
#else
#define IXOFF 4096
#endif
#endif
#ifndef IXON
#if defined(__APPLE__)
#define IXON 512
#else
#define IXON 1024
#endif
#endif
#ifndef MDMBUF
#if defined(__APPLE__)
#define MDMBUF 1048576
#endif
#endif
#ifndef NCCS
#if defined(__APPLE__)
#define NCCS 20
#else
#define NCCS 32
#endif
#endif
#ifndef NL0
#define NL0 0
#endif
#ifndef NL1
#define NL1 256
#endif
#ifndef NL2
#if defined(__APPLE__)
#define NL2 512
#endif
#endif
#ifndef NL3
#if defined(__APPLE__)
#define NL3 768
#endif
#endif
#ifndef NLDLY
#if defined(__APPLE__)
#define NLDLY 768
#else
#define NLDLY 256
#endif
#endif
#ifndef NOFLSH
#if defined(__APPLE__)
#define NOFLSH 2147483648
#else
#define NOFLSH 128
#endif
#endif
#ifndef NOKERNINFO
#if defined(__APPLE__)
#define NOKERNINFO 33554432
#endif
#endif
#ifndef OCRNL
#if defined(__APPLE__)
#define OCRNL 16
#else
#define OCRNL 8
#endif
#endif
#ifndef OFDEL
#if defined(__APPLE__)
#define OFDEL 131072
#else
#define OFDEL 128
#endif
#endif
#ifndef OFILL
#if defined(__APPLE__)
#define OFILL 128
#else
#define OFILL 64
#endif
#endif
#ifndef OLCUC
#if defined(__linux__)
#define OLCUC 2
#endif
#endif
#ifndef ONLCR
#if defined(__APPLE__)
#define ONLCR 2
#else
#define ONLCR 4
#endif
#endif
#ifndef ONLRET
#if defined(__APPLE__)
#define ONLRET 64
#else
#define ONLRET 32
#endif
#endif
#ifndef ONOCR
#if defined(__APPLE__)
#define ONOCR 32
#else
#define ONOCR 16
#endif
#endif
#ifndef ONOEOT
#if defined(__APPLE__)
#define ONOEOT 8
#endif
#endif
#ifndef OPOST
#define OPOST 1
#endif
#ifndef OXTABS
#if defined(__APPLE__)
#define OXTABS 4
#endif
#endif
#ifndef PARENB
#if defined(__APPLE__)
#define PARENB 4096
#else
#define PARENB 256
#endif
#endif
#ifndef PARMRK
#define PARMRK 8
#endif
#ifndef PARODD
#if defined(__APPLE__)
#define PARODD 8192
#else
#define PARODD 512
#endif
#endif
#ifndef PENDIN
#if defined(__APPLE__)
#define PENDIN 536870912
#else
#define PENDIN 16384
#endif
#endif
#ifndef TAB0
#define TAB0 0
#endif
#ifndef TAB1
#if defined(__APPLE__)
#define TAB1 1024
#else
#define TAB1 2048
#endif
#endif
#ifndef TAB2
#if defined(__APPLE__)
#define TAB2 2048
#else
#define TAB2 4096
#endif
#endif
#ifndef TAB3
#if defined(__APPLE__)
#define TAB3 4
#else
#define TAB3 6144
#endif
#endif
#ifndef TABDLY
#if defined(__APPLE__)
#define TABDLY 3076
#else
#define TABDLY 6144
#endif
#endif
#ifndef TCIFLUSH
#if defined(__APPLE__)
#define TCIFLUSH 1
#else
#define TCIFLUSH 0
#endif
#endif
#ifndef TCIOFF
#if defined(__APPLE__)
#define TCIOFF 3
#else
#define TCIOFF 2
#endif
#endif
#ifndef TCIOFLUSH
#if defined(__APPLE__)
#define TCIOFLUSH 3
#else
#define TCIOFLUSH 2
#endif
#endif
#ifndef TCION
#if defined(__APPLE__)
#define TCION 4
#else
#define TCION 3
#endif
#endif
#ifndef TCOFLUSH
#if defined(__APPLE__)
#define TCOFLUSH 2
#else
#define TCOFLUSH 1
#endif
#endif
#ifndef TCOOFF
#if defined(__APPLE__)
#define TCOOFF 1
#else
#define TCOOFF 0
#endif
#endif
#ifndef TCOON
#if defined(__APPLE__)
#define TCOON 2
#else
#define TCOON 1
#endif
#endif
#ifndef TCSADRAIN
#define TCSADRAIN 1
#endif
#ifndef TCSAFLUSH
#define TCSAFLUSH 2
#endif
#ifndef TCSANOW
#define TCSANOW 0
#endif
#ifndef TCSASOFT
#if defined(__APPLE__)
#define TCSASOFT 16
#endif
#endif
#ifndef TIOCCONS
#if defined(__APPLE__)
#define TIOCCONS 2147775586
#endif
#endif
#ifndef TIOCEXCL
#if defined(__APPLE__)
#define TIOCEXCL 536900621
#endif
#endif
#ifndef TIOCGETD
#if defined(__APPLE__)
#define TIOCGETD 1074033690
#endif
#endif
#ifndef TIOCGPGRP
#if defined(__APPLE__)
#define TIOCGPGRP 1074033783
#endif
#endif
#ifndef TIOCGWINSZ
#if defined(__APPLE__)
#define TIOCGWINSZ 1074295912
#endif
#endif
#ifndef TIOCM_CAR
#if defined(__APPLE__)
#define TIOCM_CAR 64
#endif
#endif
#ifndef TIOCM_CD
#if defined(__APPLE__)
#define TIOCM_CD 64
#endif
#endif
#ifndef TIOCM_CTS
#if defined(__APPLE__)
#define TIOCM_CTS 32
#endif
#endif
#ifndef TIOCM_DSR
#if defined(__APPLE__)
#define TIOCM_DSR 256
#endif
#endif
#ifndef TIOCM_DTR
#if defined(__APPLE__)
#define TIOCM_DTR 2
#endif
#endif
#ifndef TIOCM_LE
#if defined(__APPLE__)
#define TIOCM_LE 1
#endif
#endif
#ifndef TIOCM_RI
#if defined(__APPLE__)
#define TIOCM_RI 128
#endif
#endif
#ifndef TIOCM_RNG
#if defined(__APPLE__)
#define TIOCM_RNG 128
#endif
#endif
#ifndef TIOCM_RTS
#if defined(__APPLE__)
#define TIOCM_RTS 4
#endif
#endif
#ifndef TIOCM_SR
#if defined(__APPLE__)
#define TIOCM_SR 16
#endif
#endif
#ifndef TIOCM_ST
#if defined(__APPLE__)
#define TIOCM_ST 8
#endif
#endif
#ifndef TIOCMBIC
#if defined(__APPLE__)
#define TIOCMBIC 2147775595
#endif
#endif
#ifndef TIOCMBIS
#if defined(__APPLE__)
#define TIOCMBIS 2147775596
#endif
#endif
#ifndef TIOCMGET
#if defined(__APPLE__)
#define TIOCMGET 1074033770
#endif
#endif
#ifndef TIOCMSET
#if defined(__APPLE__)
#define TIOCMSET 2147775597
#endif
#endif
#ifndef TIOCNOTTY
#if defined(__APPLE__)
#define TIOCNOTTY 536900721
#endif
#endif
#ifndef TIOCNXCL
#if defined(__APPLE__)
#define TIOCNXCL 536900622
#endif
#endif
#ifndef TIOCOUTQ
#if defined(__APPLE__)
#define TIOCOUTQ 1074033779
#endif
#endif
#ifndef TIOCPKT
#if defined(__APPLE__)
#define TIOCPKT 2147775600
#endif
#endif
#ifndef TIOCPKT_DATA
#if defined(__APPLE__)
#define TIOCPKT_DATA 0
#endif
#endif
#ifndef TIOCPKT_DOSTOP
#if defined(__APPLE__)
#define TIOCPKT_DOSTOP 32
#endif
#endif
#ifndef TIOCPKT_FLUSHREAD
#if defined(__APPLE__)
#define TIOCPKT_FLUSHREAD 1
#endif
#endif
#ifndef TIOCPKT_FLUSHWRITE
#if defined(__APPLE__)
#define TIOCPKT_FLUSHWRITE 2
#endif
#endif
#ifndef TIOCPKT_NOSTOP
#if defined(__APPLE__)
#define TIOCPKT_NOSTOP 16
#endif
#endif
#ifndef TIOCPKT_START
#if defined(__APPLE__)
#define TIOCPKT_START 8
#endif
#endif
#ifndef TIOCPKT_STOP
#if defined(__APPLE__)
#define TIOCPKT_STOP 4
#endif
#endif
#ifndef TIOCSCTTY
#if defined(__APPLE__)
#define TIOCSCTTY 536900705
#endif
#endif
#ifndef TIOCSER_TEMT
#if defined(__linux__)
#define TIOCSER_TEMT 1
#endif
#endif
#ifndef TIOCSETD
#if defined(__APPLE__)
#define TIOCSETD 2147775515
#endif
#endif
#ifndef TIOCSPGRP
#if defined(__APPLE__)
#define TIOCSPGRP 2147775606
#endif
#endif
#ifndef TIOCSTI
#if defined(__APPLE__)
#define TIOCSTI 2147578994
#endif
#endif
#ifndef TIOCSWINSZ
#if defined(__APPLE__)
#define TIOCSWINSZ 2148037735
#endif
#endif
#ifndef TOSTOP
#if defined(__APPLE__)
#define TOSTOP 4194304
#else
#define TOSTOP 256
#endif
#endif
#ifndef VDISCARD
#if defined(__APPLE__)
#define VDISCARD 15
#else
#define VDISCARD 13
#endif
#endif
#ifndef VDSUSP
#if defined(__APPLE__)
#define VDSUSP 11
#endif
#endif
#ifndef VEOF
#if defined(__APPLE__)
#define VEOF 0
#else
#define VEOF 4
#endif
#endif
#ifndef VEOL
#if defined(__APPLE__)
#define VEOL 1
#else
#define VEOL 11
#endif
#endif
#ifndef VEOL2
#if defined(__APPLE__)
#define VEOL2 2
#else
#define VEOL2 16
#endif
#endif
#ifndef VERASE
#if defined(__APPLE__)
#define VERASE 3
#else
#define VERASE 2
#endif
#endif
#ifndef VINTR
#if defined(__APPLE__)
#define VINTR 8
#else
#define VINTR 0
#endif
#endif
#ifndef VKILL
#if defined(__APPLE__)
#define VKILL 5
#else
#define VKILL 3
#endif
#endif
#ifndef VLNEXT
#if defined(__APPLE__)
#define VLNEXT 14
#else
#define VLNEXT 15
#endif
#endif
#ifndef VMIN
#if defined(__APPLE__)
#define VMIN 16
#else
#define VMIN 6
#endif
#endif
#ifndef VQUIT
#if defined(__APPLE__)
#define VQUIT 9
#else
#define VQUIT 1
#endif
#endif
#ifndef VREPRINT
#if defined(__APPLE__)
#define VREPRINT 6
#else
#define VREPRINT 12
#endif
#endif
#ifndef VSTART
#if defined(__APPLE__)
#define VSTART 12
#else
#define VSTART 8
#endif
#endif
#ifndef VSTATUS
#if defined(__APPLE__)
#define VSTATUS 18
#endif
#endif
#ifndef VSTOP
#if defined(__APPLE__)
#define VSTOP 13
#else
#define VSTOP 9
#endif
#endif
#ifndef VSUSP
#define VSUSP 10
#endif
#ifndef VSWTC
#if defined(__linux__)
#define VSWTC 7
#endif
#endif
#ifndef VT0
#define VT0 0
#endif
#ifndef VT1
#if defined(__APPLE__)
#define VT1 65536
#else
#define VT1 16384
#endif
#endif
#ifndef VTDLY
#if defined(__APPLE__)
#define VTDLY 65536
#else
#define VTDLY 16384
#endif
#endif
#ifndef VTIME
#if defined(__APPLE__)
#define VTIME 17
#else
#define VTIME 5
#endif
#endif
#ifndef VWERASE
#if defined(__APPLE__)
#define VWERASE 4
#else
#define VWERASE 14
#endif
#endif
#ifndef XCASE
#if defined(__linux__)
#define XCASE 4
#endif
#endif
#ifndef XTABS
#if defined(__linux__)
#define XTABS 6144
#endif
#endif
