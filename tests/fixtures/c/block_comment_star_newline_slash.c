/* A block comment ends only at a star followed by a slash; a newline
 * between them is no line splice (C99 5.1.1.2p1, phases 2 and 3). */

/* a *
/ b */
int x = 4 /* half *
/ 2 /* c */;
/* d *\
/ int y = 3;

int main(void) {
    return x + y - 7;
}
