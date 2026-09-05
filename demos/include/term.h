/* Minimal <term.h> for building against the system terminfo library
 * (ncurses' libtinfo, or libcurses where the two are one library).
 * Declares only the termcap emulation entry points that the programs here
 * use; the signatures match ncurses' <term.h>. The capability tables, the
 * setupterm / tigetstr family, and the terminfo database structures are
 * omitted. The implementation is the system library, supplied at link
 * time. */
#ifndef TERM_H
#define TERM_H

int tgetent(char *bp, const char *name);
int tgetflag(const char *id);
int tgetnum(const char *id);
char *tgetstr(const char *id, char **area);
char *tgoto(const char *cap, int col, int row);
int tputs(const char *str, int affcnt, int (*putc)(int));

#endif
