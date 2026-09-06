// shadow.h -- the shadow password database, the companion to <pwd.h>
// where the hash lives outside /etc/passwd.
//
// Linux-only: it is an /etc/shadow interface, and Darwin keeps the
// hash in OpenDirectory with no such database. The aging fields are
// `long` because glibc declares them so, and -1 stands for unset.

#pragma once

#ifdef __linux__

struct spwd {
    char *sp_namp;    /* offset  0, login name */
    char *sp_pwdp;    /* offset  8, encrypted password */
    long  sp_lstchg;  /* offset 16, last change, days since the epoch */
    long  sp_min;     /* offset 24, days before a change is allowed */
    long  sp_max;     /* offset 32, days before a change is required */
    long  sp_warn;    /* offset 40, days of warning before expiry */
    long  sp_inact;   /* offset 48, days of inactivity allowed */
    long  sp_expire;  /* offset 56, account expiry, days since the epoch */
    unsigned long sp_flag; /* offset 64, reserved */
};

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::getspnam, "getspnam")
#pragma binding(libc::getspnam_r, "getspnam_r")
#pragma binding(libc::getspent, "getspent")
#pragma binding(libc::setspent, "setspent")
#pragma binding(libc::endspent, "endspent")
#pragma binding(libc::lckpwdf, "lckpwdf")
#pragma binding(libc::ulckpwdf, "ulckpwdf")

struct spwd *getspnam(char *name);
// Reentrant lookup, shaped like getpwnam_r: fills the caller's record
// and scratch buffer, sets `*result` to it or NULL, returns 0 or errno.
int getspnam_r(char *name, struct spwd *spbuf, char *buf, unsigned long buflen,
               struct spwd **result);
struct spwd *getspent();
void setspent();
void endspent();
// Advisory lock over the database, held between the two calls.
int lckpwdf(void);
int ulckpwdf(void);

#endif
